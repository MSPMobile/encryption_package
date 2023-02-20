
import java.security.SecureRandom;
import java.util.Base64;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.util.Arrays;

public class AES_GCM_Example
{
    static String timeStamp = "2023-02-06T12:26:17.977Z";
    static String transactionId = "6347398261";
    //static String timeStamp = "2023-02-07T08:17:23.697Z";
    //static String transactionId = "4560504288";
    static String plainData = "HELLO WORLD";
    static String GivencipherText = "A4lGo1p5tarCBuvk94swmTJQMA6Oxahlyho0nd-tV4iMbjgQeS90VmWqyHmdgCauOWY9aLn9TA4-82XTsS9JUVF9q0ngaCek34f2QCwzjgE5GxH0Nrya4ENqYAHHCnY-bV-3VHvhl8NkDLthyLhwWKptZ5yIjScvdhze06W-K4rNl1IU8oGdTA9-03th5bj7MpX5Z7XONtbdKy8AEYlAXAc9kGumShOA5aOl2VLSsW2crHdxfghdhxdh1ud6BSp7WZzsta2VfekyByBldcZHWx-jHW-niQqn00hNiKNsl8rbjLoDpIzTrlXLTIE0bnGFANafj-gBZ-zQKXWjPUm6K9Zdh7zWwE6Q";
    static String key = "miVEpAvDAMAo3ld2myaisaHiV37x0r80xnMrwQ4vXm8=";
    //static String key = "dxMZZ0CjvFJ/yQfk2uH8nm8/kAhEWfT/7iVBd5F7Bfc=";
    static String plainText = "This is a plain text which need to be encrypted by Java AES 256 GCM Encryption Algorithm";
    public static final int AES_KEY_SIZE = 256;
    public static final int GCM_IV_LENGTH = 12;
    public static final int GCM_TAG_LENGTH = 16;

    public static void main(String[] args) throws Exception
    {
        
        KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");
        keyGenerator.init(AES_KEY_SIZE);
       
        // Generate Key
        
        // XOR Operation for IV and AAD
        byte[] xorData = xorOperation(timeStamp,transactionId);
        
        // Write out xordata
        System.out.println("xordata : "+xorData.length);


        //SecretKey key = keyGenerator.generateKey();
        byte[] IV = getLastBytes(xorData,GCM_IV_LENGTH);
        byte[] aad = getLastBytes(xorData,GCM_TAG_LENGTH);
        byte[] keyArr = Base64.getDecoder().decode(key);
        SecretKey originalKey = new SecretKeySpec(keyArr, 0, keyArr.length, "AES");
        
        // SecureRandom random = new SecureRandom();
        // random.nextBytes(IV);


        // Input print out
        System.out.println("Original Text : " + plainData);

         // Encryption operation
        byte[] cipherText = encrypt(plainData.getBytes(), originalKey, IV, aad);
        System.out.println("\n Encrypted Text : " + Base64.getEncoder().encodeToString(cipherText));

        // Decryption Operation
        //Remove below two lines and uncommment the third line for the decrypt operation for the result of above encrypted text
        byte[] base64DecryptedText =  Base64.getUrlDecoder().decode(GivencipherText);
        //byte[] BCipherText = cipherText.getBytes();
        String decryptedText = decrypt(base64DecryptedText, originalKey, IV, aad);
        //String decryptedText = decrypt(cipherText, originalKey, IV, aad); Uncomment this line
        System.out.println("\n DeCrypted Text : " + decryptedText);

      
    }

    public static byte[] encrypt(byte[] plaintext, SecretKey key, byte[] IV, byte[] aad) throws Exception
    {
        // Get Cipher Instance
        Cipher cipher = Cipher.getInstance("AES/GCM/PKCS5Padding");
        
        // Create SecretKeySpec
        SecretKeySpec keySpec = new SecretKeySpec(key.getEncoded(), "AES");
        
        // Create GCMParameterSpec
        GCMParameterSpec gcmParameterSpec = new GCMParameterSpec(GCM_TAG_LENGTH * 8, IV);
        
        // Initialize Cipher for ENCRYPT_MODE
        cipher.init(Cipher.ENCRYPT_MODE, keySpec, gcmParameterSpec);
        
        cipher.updateAAD(aad);
        // Perform Encryption
        byte[] cipherText = cipher.doFinal(plaintext);
        
        return cipherText;
    }
    
    public static byte[] getLastBytes(byte[] xorBytes, int lastBytesNum) {
		assert(xorBytes.length >= lastBytesNum);
		return Arrays.copyOfRange(xorBytes, xorBytes.length - lastBytesNum, xorBytes.length);
	}

    public static byte[] xorOperation(String timestampString, String transtIdString) {
    
          byte[] timestamp = timestampString.getBytes();
          byte[] transactionId = transtIdString.getBytes();
          int timestampLength = timestamp.length;
          int transactionIdLength = transactionId.length;
      
          if (timestampLength > transactionIdLength) {
            transactionId =
                FillRange(transactionId, timestampLength - transactionIdLength);
          } else if (timestampLength > transactionIdLength) {
            timestamp = FillRange(timestamp, transactionIdLength - timestampLength);
          }
      
          int MaxLen = Math.max(timestampLength, transactionIdLength);
          byte[] list = new byte[MaxLen];
      
          for (int i = 0; i < MaxLen; i++) {
            list[i] = (byte)(timestamp[i] ^ transactionId[i]);
          }
      
          byte[] operationResults = list;
          //XORBytes = operationResults;
          return list;
          //Remove below line if UI is not necessary
          //operationResult = operationResults.toString();
      }
      
      public static byte[] FillRange(byte[] bytearrData, int len) {
     
          byte[] newList = new byte[bytearrData.length + len];
          int totalLen = bytearrData.length + len;
          int IterateLen = 0;
          for (; IterateLen < len; IterateLen++) {
            newList[IterateLen] = 0;
          }
      
          for (int j = 0; IterateLen < totalLen; IterateLen++, j++) {
            newList[IterateLen] = bytearrData[j];
          }
      
          return newList;
        
      }

    public static String decrypt(byte[] cipherText, SecretKey key, byte[] IV,byte[] aad) throws Exception
    {
        // Get Cipher Instance
        Cipher cipher = Cipher.getInstance("AES/GCM/PKCS5Padding");
        
        // Create SecretKeySpec
        SecretKeySpec keySpec = new SecretKeySpec(key.getEncoded(), "AES");
        
        // Create GCMParameterSpec
        GCMParameterSpec gcmParameterSpec = new GCMParameterSpec(GCM_TAG_LENGTH * 8, IV);
        
        // Initialize Cipher for DECRYPT_MODE
        cipher.init(Cipher.DECRYPT_MODE, keySpec, gcmParameterSpec);
        
        cipher.updateAAD(aad);
        // Perform Decryption
        byte[] decryptedText = cipher.doFinal(cipherText);
        
        return new String(decryptedText);
    }
}