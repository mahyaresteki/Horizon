import sys
from Crypto.Cipher import DES
from Crypto.Cipher import DES3
from Crypto.Util.strxor import strxor
import binascii
import base64

class Cryptography:

    def CreateMac(key, msg):
        return macIso9797_alg3(key, msg, "00")


    def CreatePinBlock(pan, pin, pinKey):
        pinlengthAsHex = str(len(pin))
        str1 = "0000" + pan[len(pan) - 13: len(pan) - 1]
        str2 = pinlengthAsHex.rjust(2,'0') + pin.ljust(14,'f')

        data = strxor(binascii.unhexlify(str1), binascii.unhexlify(str2))

        byteKey = binascii.unhexlify(pinKey)

        return DESEncrypt(byteKey, data)


    def GetTopUpCode(additionalCustomInfo, topUpkey):
        providerlen = int(AdditionalCustomInfo[4:6])
        topUplen = int(AdditionalCustomInfo[providerlen+6:providerlen+8])
        encryptedSharj = AdditionalCustomInfo[providerlen+8:providerlen+8+topUplen]

        text = binascii.unhexlify(encryptedSharj);
        key = binascii.unhexlify(topUpkey)
        codeC = DESDecrypt(key, text).hex()
        print(key)

        return re.sub(r'[^0-9]','', codeC)


    def macIso9797_alg3(key, msg, pad_start):

        key_len = int(len(key)/2)    

        if (key_len != 16):
            raise ValueError("Key length should be 16 digits")    

        # force header  padding
        msg += pad_start

        # padding with "00"
        lenRestOfData = int((len(msg)/2) % 8)
        msg += "00"*(8-lenRestOfData)

        loopNum = int((len(msg)/2) / 8)

        bufferOutput = binascii.unhexlify("00"*8)
        IV = '\x00'*8    

        keya = binascii.unhexlify(key[0:16])
        keyb = binascii.unhexlify(key[16:])

        i = 0
        for i in range (0, loopNum):
            tdesa = DES.new(keya, DES.MODE_ECB)

            data = msg[i*16:i*16+16]

            x = bufferOutput
            bufferOutput = strxor(binascii.unhexlify(data), bufferOutput)

            bufferOutput = tdesa.encrypt(bufferOutput)

        tdesb = DES.new(keyb, DES.MODE_ECB)
        bufferOutput = tdesb.decrypt(bufferOutput)

        tdesa = DES.new(keya, DES.MODE_ECB)
        bufferOutput = tdesa.encrypt(bufferOutput)

        return bufferOutput


    def DESEncrypt(key, message):
        cipher_encrypt = DES3.new(key, DES3.MODE_ECB)
        encrypted_text = cipher_encrypt.encrypt(message)
        return encrypted_text


    def DESDecrypt(key, message):
        cipher_encrypt = DES3.new(key, DES3.MODE_ECB)
        encrypted_text = cipher_encrypt.decrypt(message)
        return encrypted_text