using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Configuration;

namespace CodingExercise_PatientMaintenance.Helpers
{
    public class DESEncryptionHelper
    {
        private static byte[] key = Encoding.ASCII.GetBytes(ConfigurationManager.AppSettings["DESKey"]);
        private static byte[] vector = Encoding.ASCII.GetBytes(ConfigurationManager.AppSettings["DESVector"]);

        public static string Encrypt(string text)
        {
            using (var cryptoProvider = new DESCryptoServiceProvider())
            using (var memoryStream = new MemoryStream())
            using (var cryptoStream = new CryptoStream(memoryStream, cryptoProvider.CreateEncryptor(key, vector), CryptoStreamMode.Write))
            using (var writer = new StreamWriter(cryptoStream))
            {
                writer.Write(text);
                writer.Flush();
                cryptoStream.FlushFinalBlock();
                writer.Flush();
                return Convert.ToBase64String(memoryStream.GetBuffer(), 0, (int)memoryStream.Length);
            }
        }

        public static string Decrypt(string encrypted)
        {
            using (var cryptoProvider = new DESCryptoServiceProvider())
            using (var memoryStream = new MemoryStream(Convert.FromBase64String(encrypted)))
            using (var cryptoStream = new CryptoStream(memoryStream, cryptoProvider.CreateDecryptor(key, vector), CryptoStreamMode.Read))
            using (var reader = new StreamReader(cryptoStream))
            {
                return reader.ReadToEnd();
            }
        }

    }

}