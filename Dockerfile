# Define a imagem base para construção do aplicativo
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Instala o SDK do .NET Core
RUN dotnet --version

# Copia todos os arquivos do diretório atual para o diretório de trabalho no contêiner
COPY . ./

# Restaura as dependências
RUN dotnet restore

# Publica o aplicativo em modo Release
RUN dotnet publish -c Release -o out

# Define a imagem base para a execução do aplicativo
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copia os arquivos publicados do diretório de compilação para o diretório de trabalho no contêiner
COPY --from=build-env /app/out .

# Define o ponto de entrada para o aplicativo
ENTRYPOINT ["dotnet", "DotNet.Docker.dll"]
