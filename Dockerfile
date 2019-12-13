FROM mcr.microsoft.com/dotnet/core/sdk:2.1 AS build-env
WORKDIR /code

# Copy csproj and restore as distinct layers
COPY api/*.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . .
RUN dotnet publish -c Release -o /out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:2.1
WORKDIR /app
COPY --from=build-env /out /app
EXPOSE 5000
ENTRYPOINT ["dotnet", "netcore-api.dll"]
