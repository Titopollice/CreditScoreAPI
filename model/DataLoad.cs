using CsvHelper;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;

public class DataLoad : IDataLoad
{
    private string dataDirectory = @"C:\Users\TIAGO\Documents\Dev\CScoreAPI\CreditScoreAPI\data\";

    public List<Data> Search()
    {
        string filePath = Path.Combine(dataDirectory, "Car_Insurance_Claim.csv");
        return Load<Data>(filePath);
    }

    public List<T> Load<T>(string local)
    {
        if (!File.Exists(local))
            throw new ArgumentException("O arquivo não foi encontrado: " + local);

        using (var reader = new StreamReader(local))
        using (var csv = new CsvReader(reader, CultureInfo.InvariantCulture))
        {
            return csv.GetRecords<T>().ToList();
        }
    }
}
