# Application Insights

## Install NuGet Library
```shell-session
$ Install-Package Microsoft.ApplicationInsights.AspNetCore
```

## Configuration with ASP.NET Core 3.1
Startup.cs
```csharp
public class Startup
{
    public void ConfigureServices(IServiceCollection services)
    {
        // The following line enables Application Insights telemetry collection.
        services.AddApplicationInsightsTelemetry();

        services.AddControllersWithViews();
    }
}
```

appsettings.json
```json
{
  "ApplicationInsights": {
    "ConnectionString": "InstrumentationKey=xxx"
  },
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft": "Warning",
      "Microsoft.Hosting.Lifetime": "Information"
    }
  },
  "AllowedHosts": "*"
}
```

## Configuration with Azure Web Apps
App Settings
| KEY | VALUE |
----|---- 
| APPLICATIONINSIGHTS_CONNECTION_STRING | InstrumentationKey=xxx |

