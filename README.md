## 현재 ssl 관련 테스트때문에 아래사항들이 작동하지 않습니다.

## 프로젝트 개요

인스타그램 api 서버를 레일즈로 간략하게 구현하였습니다.

프로젝트의 목적은 url을 통해서 서버에 request를 보내고 response를 받게 하는 간단한 api 서버를 만드는 것입니다.

> 사용한 언어 및 프레임워크 버전
>
> - ruby 2.3.1, rails 5.1.5

#### 모델

모델은 User, Relationship, Media를 생성했습니다.
User와 Relationship은 M:N 관계를 가지고, User와 Media는 1:N 관계를 가집니다.

#### 컨트롤러

컨트롤러는 유저와 관계를 처리해주는 users_controller와 미디어를 처리해주는 media_controller를 생성했습니다.

> 데이터를 보내는것은 모두 **JSON**형태로 response를 하게 했습니다.



## AWS 배포 방법

1. 우선 AWS에서 ec2 인스턴스를 하나 만들어 줍니다.
2. 만든 인스턴스에 따라 pem파일을 따로 저장하고, 터미널을 이용해 쉘로 접속을 합니다.(ssh -i 000.pem ec2-user@[your-public-ip])
3. 새로운 리눅스 환경에서 필요한 환경 세팅을 해줍니다.(git, rvm, ruby, nginx, passenger)
4. 환경세팅이 끝난후에는 프로젝트를 올려놓았던 github에서 production branch를 clone해서 가지고 옵니다.
5. sudo service nginx start로 서버를 시작하면 배포가 완료됩니다.



## 테스트 하기

test_access_token: fD6ByM5AtdR5kFJmAZtRaKFM

> 이 액세스 토큰은 7번 유저의 access_token입니다

구현한 부분은 유저파트 4개, 관계파트 3개, 미디어파트 1개입니다.

URL : http://13.124.76.75/

#### 유저파트

- 현재 유저 데이터 가져오기 : http://13.124.76.75/users/self?access_token=fD6ByM5AtdR5kFJmAZtRaKFM

  > **결과값**
  >
  > {"id":7,"email":"keven@heller.co","name":"Ena Rowe","password":"qwer","total_follower":1,"total_followee":16,"created_at":"2018-02-28T09:23:37.999Z","updated_at":"2018-02-28T09:23:37.999Z"}

- 다른 유저의 데이터 가져오기 : http://13.124.76.75/users/10?access_token=fD6ByM5AtdR5kFJmAZtRaKFM

  > **결과값**
  >
  > {"id":10,"email":"eva@howe.org","name":"Alena Hand Jr.","password":"qwer","total_follower":64,"total_followee":51,"created_at":"2018-02-28T09:23:38.022Z","updated_at":"2018-02-28T09:23:38.022Z"}

- 현재 유저의 최근 미디어 가져오기 : http://13.124.76.75/users/self/media/recent?access_token=fD6ByM5AtdR5kFJmAZtRaKFM

  > **결과값**
  >
  > {"id":40,"image":"Fasten your seatbelts. It's going to be a bumpy night.","description":"Enim dolor et mollitia.","user_id":7,"created_at":"2018-02-28T09:23:38.499Z","updated_at":"2018-02-28T09:23:38.499Z"}

- 다른 유저의 최근 데이터 가져오기 :http://13.124.76.75/users/10/media/recent?access_token=fD6ByM5AtdR5kFJmAZtRaKFM

  > **결과값**
  >
  > {"id":35,"image":"May the Force be with you.","description":"Ullam tempora quibusdam id rerum qui.","user_id":10,"created_at":"2018-02-28T09:23:38.455Z","updated_at":"2018-02-28T09:23:38.455Z"}



#### 관계파트

- 현재 유저가 팔로우 하는 유저 데이터 가져오기 : http://13.124.76.75/users/self/follows?access_token=fD6ByM5AtdR5kFJmAZtRaKFM

  > **결과값**
  >
  > [{"id":9,"follower_id":7,"followee_id":8,"accepted":true,"created_at":"2018-02-28T09:23:38.120Z","updated_at":"2018-02-28T09:23:38.120Z"}]

- 현재 유저를 팔로우 하는 유저 데이터 가져오기 : http://13.124.76.75/users/self/followed-by?access_token=fD6ByM5AtdR5kFJmAZtRaKFM

  > **결과값**
  >
  > [{"id":3,"follower_id":1,"followee_id":7,"accepted":true,"created_at":"2018-02-28T09:23:38.071Z","updated_at":"2018-02-28T09:23:38.071Z"},{"id":5,"follower_id":3,"followee_id":7,"accepted":true,"created_at":"2018-02-28T09:23:38.088Z","updated_at":"2018-02-28T09:23:38.088Z"},{"id":7,"follower_id":5,"followee_id":7,"accepted":true,"created_at":"2018-02-28T09:23:38.105Z","updated_at":"2018-02-28T09:23:38.105Z"},{"id":10,"follower_id":8,"followee_id":7,"accepted":true,"created_at":"2018-02-28T09:23:38.128Z","updated_at":"2018-02-28T09:23:38.128Z"}]

- 현재 유저를 팔로우 하기 원하는 유저 데이터 가져오기 : http://13.124.76.75/users/self/requested-by?access_token=fD6ByM5AtdR5kFJmAZtRaKFM

  > **결과값**
  >
  > [{"id":4,"follower_id":2,"followee_id":7,"accepted":false,"created_at":"2018-02-28T09:23:38.080Z","updated_at":"2018-02-28T09:23:38.080Z"},{"id":6,"follower_id":4,"followee_id":7,"accepted":false,"created_at":"2018-02-28T09:23:38.096Z","updated_at":"2018-02-28T09:23:38.096Z"},{"id":8,"follower_id":6,"followee_id":7,"accepted":false,"created_at":"2018-02-28T09:23:38.112Z","updated_at":"2018-02-28T09:23:38.112Z"}]



#### 미디어파트

- media-id 파라미터를 통해 특정 미디어 데이터 가져오기 : http://13.124.76.75/media/7?access_token=fD6ByM5AtdR5kFJmAZtRaKFM

  > **결과값**
  >
  > {"id":7,"image":"I'm going to make him an offer he can't refuse.","description":"Molestiae est necessitatibus corrupti accusantium et eum sunt ut.","user_id":7,"created_at":"2018-02-28T09:23:38.214Z","updated_at":"2018-02-28T09:23:38.214Z"}

----------------------------------------------------------------------------------------------------------------------------

### Notes 

- 액세스 토큰을 유저 모델에서 찾을수 없다면 {"status":"fail"}이란 response를 보내게 해놨습니다.

- 핵심적이라고 생각했던 액션들을 우선적으로 구현하였습니다. 

  > 예를 들어 미디어 파트에서는 shortcode도 있으면 좋지만 media-id를 통해서 접근하는 것이 있다면 현재 단계에서는 필요없을 것 같아서 show해주는 부분만 구현했습니다.

- Relationship 모델에서 요청을 한것과 요청을 받아들여진 것을 accepted라는 attribute를 추가하여 구분하였습니다.
