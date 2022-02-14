# MovieApp
> 네이버 영화 API를 이용해 영화 검색 구현하기

## 목차
- [기능](#기능)
- [프로젝트 구조 및  구현](#프로젝트-구조-및-구현)

## 기능
### 영화 검색 및 결과 목록
영화 제목으로 검색 가능 및 빈문자열 또는 결과가 없을 경우에 검색 결과 없음 표시
| 화면 |
|---|
| <img src=https://user-images.githubusercontent.com/38883364/153869642-2e8722fc-1f8a-4db9-81f8-60ce25b356bc.gif width=300> |

### 영화 내용 상세 화면
WKWebView를 사용해 내용 상세화면 표시 및 즐겨찾기 추가,삭제 기능
| 화면 |
|---|
| <img src="https://user-images.githubusercontent.com/38883364/153870910-474ba80e-8acc-417e-9679-a6cb532d19d4.gif" width=300> |

### 즐겨찾기 모음 화면
UserDefaults를 사용해 즐겨찾기 영화를 저장, 상세화면으로 이동 
| 화면 |
|---|
| <img src="https://user-images.githubusercontent.com/38883364/153871422-59b7d582-c10f-4e5e-bf83-a00223afe3bf.gif" width=300> |


## 프로젝트 구조 및  구현
### 디렉토리 구조
```
🗂 Presentation
    - ViewController.swift
    - ViewModel.swift
    🗂 Views
        - MovieCollecitonView.swift
        - MovieCell.swift
    🗂 Common
        - Observable.swift
🗂 Domain
    - Usecase.swift
    - Movie.swift
🗂 Infra
    - Repository.swift
    - TransferService.swift
    - NetworkService.swift
    - MovieResponse.swift
    - MovieEndpoint.swift
- ImageCache.swift
- ImaageDownloadManaer.swift
- FavoriteManager.swift
Info.plist
```
<br/>

### ViewController 흐름
<img src="https://user-images.githubusercontent.com/38883364/153873682-b5edef7a-edad-4e9b-84ab-8183223b8531.png">

### 프로젝트 구조
MVVM 구조를 채택해 Viewmodel이 소유하는 영화 모델이 변경되면 View 업데이트
<img src="https://user-images.githubusercontent.com/38883364/153875626-19262388-352b-4d8a-b7db-8e67836362b6.png">

### 주요 객체 역할
| 객체  |  역할 |
|---|---|
| [MainViewController](./MovieApp/MovieApp/Presentation/MainViewController.swift)  | 영화 검색 결과 목록 표시  |
|  [MainViewModel](./MovieApp/MovieApp/Presentation/MainViewModel.swift) | usecase에 검색 쿼리 요청, 즐겨찾기 추가 및 삭제 |
|  [MovieUsecase](./MovieApp/MovieApp/Domain/MovieUsecase.swift) |  repository에 검색 결과 요청 |
|  [MovieRepository](./MovieApp/MovieApp/Infra/MovieRepository.swift) | MovieResponse -> Movie 객체로 변환<br> TransferService에 MovieResponse 요청 |
|  [TransferService](./MovieApp/MovieApp/Infra/TransferService.swift)  |  Data -> MovieResponse 객체로 변환<br> NetworkAPI Data 요청 |
|  [ImageDownloadManager](./MovieApp/MovieApp/ImageDownloadManager.swift)  |  이미지 다운로드, 이미지 캐시, 이미지 다운로드 취소 |
|  [FavoriteManager](./MovieApp/MovieApp/FavoriteManager.swift)  |  UserDefaults를 사용해 즐겨찾기 관리 |
|  [MovieCollectionView](./MovieApp/MovieApp/Presentation/Views/MovieCollectionView.swift)  |  영화 목록, 즐겨찾기 화면에서 CollectionView 재사용 |
|  [Observable](./MovieApp/MovieApp/Presentation/Common/Observable.swift)  |  데이터 바인딩 |

