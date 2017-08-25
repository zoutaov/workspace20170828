#include "aeskey.cpp"
#include <stdio.h>
#include <jni.h>
#include <stdlib.h>
#include <string.h>
#include <android/log.h>
#include "aes.h"
#include "mlog.h"

//CRYPT CONFIG
#define MAX_LEN (2*1024*1024)
#define ENCRYPT 0
#define DECRYPT 1
#define AES_KEY_SIZE 256
#define READ_LEN 10

//typedef unsigned char BYTE;
//AES_IV
const BYTE AES_IV[16] = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
		0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f };

char *CharToAscii(const char *asc, char str[], int *out) {
	int i = 0, n = 0, len;
	char cTemp[1024];
	memset(cTemp, 0x00, sizeof(cTemp));
	strcpy(cTemp, asc);
	len = strlen(cTemp);
	for (i = 0; i < len; i += 2) {
		if (('0' <= cTemp[i] && cTemp[i] <= '9')
				&& ('0' <= cTemp[i + 1] && cTemp[i + 1] <= '9'))
			str[n++] = (char) (cTemp[i] << 4 | (cTemp[i + 1] & 0x0F));
		else if ('0' <= cTemp[i] && cTemp[i] <= '9'
				&& ('A' <= cTemp[i + 1] && cTemp[i + 1] <= 'F'))
			str[n++] = (char) (cTemp[i] << 4 | (cTemp[i + 1] - 0x37));
		else if (('A' <= cTemp[i] && cTemp[i] <= 'F')
				&& ('0' <= cTemp[i + 1] && cTemp[i + 1] <= '9'))
			str[n++] =
					(char) (((cTemp[i] - 0x37) << 4) | (cTemp[i + 1] & 0x0F));
		else if (('A' <= cTemp[i] && cTemp[i] <= 'F')
				&& ('A' <= cTemp[i + 1] && cTemp[i + 1] <= 'F'))
			str[n++] =
					(char) (((cTemp[i] - 0x37) << 4) | (cTemp[i + 1] - 0x37));
		else
			printf("your input is wrong!!");
	}
	str[n] = '\0';
	*out = n;
	return str;
}

/**
 * aes 解密  参数传16进制密文
 */
char * D274623FB4460072(const char * miwen) {
	char strin[1024];
	int tocharlen = 0; //strlen(tochar);
	memset(strin, 0x00, sizeof(strin));
	char * tochar = CharToAscii(miwen, strin, &tocharlen);
	//print_test(tochar);//打印输出

	unsigned int len = tocharlen; //  (unsigned int) ((*env)->GetArrayLength(env, jarray));
	if (len <= 0 || len >= MAX_LEN) {
		return NULL;
	}

	char *data = tochar; //(unsigned char*) (*env)->GetByteArrayElements(env,jarray, NULL);

	if (!data) {
		return NULL;
	}

	//计算填充长度，当为加密方式且长度不为16的整数倍时，则填充，与3DES填充类似(DESede/CBC/PKCS5Padding)
	unsigned int mode = 1;
	unsigned int rest_len = len % AES_BLOCK_SIZE;
	unsigned int padding_len = (
			(ENCRYPT == mode) ? (AES_BLOCK_SIZE - rest_len) : 0);
	unsigned int src_len = len + padding_len;

	//设置输入
	unsigned char *input = (unsigned char *) malloc(src_len);
	memset(input, 0, src_len);
	memcpy(input, data, len);
	if (padding_len > 0) {
		memset(input + len, (unsigned char) padding_len, padding_len);
	}

	//设置输出Buffer
	BYTE * buff_out = (BYTE*) malloc(src_len);
	if (!buff_out) {
		free(input);
		return NULL;
	}
	memset(buff_out, src_len, 0);

	//set key & iv
	unsigned int key_schedule[AES_BLOCK_SIZE * 4] = { 0 }; //>=53(这里取64)

	aes_key_setup(AES_KEY, key_schedule, AES_KEY_SIZE);

	aes_decrypt_cbc(input, src_len, buff_out, key_schedule, AES_KEY_SIZE,
			AES_IV);

	char* buff = (char*) buff_out;
//	char* buff =(char*)buff_out;
	//解密时计算填充长度
	if (ENCRYPT != mode) {
		char * ptr = buff;
		ptr += (src_len - 1);
		padding_len = (unsigned int) *ptr;
		if (padding_len > 0 && padding_len <= AES_BLOCK_SIZE) {
			src_len -= padding_len;
		}
		ptr = NULL;
	}
	int bufflen = strlen(buff);

	//内存释放
	free(input);
	free(buff_out);

	char * aesdec = buff;
//解密后去除后面乱码
	int i;
	int aesdeclen = strlen(aesdec);
	for (i = 0; i < aesdeclen;) {

		unsigned char ch = aesdec[i]; //注意要定义为无符号
		//先检查ch是否是字母：
		if ((ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z')) {
			i++;
			continue;
		} else {
			//再检查ch是否是数字：
			if (ch >= '0' && ch <= '9') {
				i++;
				continue;
			} else {
				//最后检查是否是汉字：（按GB 2312 汉字区检查，不考虑特殊汉字  B0A1-F7FE）
				if (ch >= 0xB0 && ch <= 0xF7) {
					//继续检查下一个字符是否能组织成汉字
					unsigned char ch1 = aesdec[i + 1]; //注意要定义为无符号
					if (ch1 >= 0xA1 && ch1 <= 0xFE) {
						i += 2;
						continue;
					}
				}
				if ((int) ch >= 32 && (int) ch <= 126) {
					i++;
					continue;
				}

			}
		}
		break;

	}
	char *newbuff = (char*) malloc((i + 1) * sizeof(char));
	int j = 0;
	for (; j < i; j++) {
		newbuff[j] = aesdec[j];
	}
	newbuff[i] = '\0';
	return newbuff;
}

