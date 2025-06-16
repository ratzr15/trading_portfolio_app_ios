# trading_portfolio_app_ios
iOS application that displays a list of trading instruments along with a real-time price ticker to reflect price fluctuations.


## Details

- App uses MVVM architecture 
- Unit tested domain and data layer.
- App uses snapKit for programmatic UI creation.
- App uses Rx for reactive programming

### Highlights

- Business layer - view models are 100% tested
- Modularisation of different layers - Networking & Design system


### Code organization

```
   |--root
       |--Model
       		|--model.swift
       |--ViewModel
            |--viewmodel.swift
       |--View
       		|--viewcontroller.swift
       |--Networking
       		|--networkclient.swift
				
--tests
   |--unit
   |--ui
        
```

### Environment

```
  swift: 6.1
  xcode: 16.3
```
