FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS build

WORKDIR /src
COPY ["project.csproj", "./"]
RUN dotnet restore "project.csproj" -r alpine-x64 /p:PublishReadyToRun=true
COPY . .
RUN dotnet publish "project.csproj" --no-restore -c Release -r alpine-x64 -o /app/publish /p:PublishTrimmed=true /p:PublishReadyToRun=true /p:PublishSingleFile=true --self-contained true

FROM mcr.microsoft.com/dotnet/runtime-deps:6.0-alpine AS final
EXPOSE 5000
ENV ASPNETCORE_URLS=http://+:5000

RUN apk add curl
HEALTHCHECK CMD curl --fail http://localhost:5000/WeatherForecast || exit 1 

RUN adduser --disabled-password --home /app --gecos '' nonroot && chown -R nonroot /app
USER nonroot

WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["./project"]