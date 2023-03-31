
<div align="center">

# CMC 12기 Neordinary-Hackathon
## 점선면 프로젝트
<img width="799" alt="스크린샷 2023-03-31 오후 4 37 18" src="https://user-images.githubusercontent.com/66284051/229054998-2b5f63c5-cd4f-4461-9b23-e61a6b9da12c.png"><br><br>
<b>실행영상: https://workable-mouse-f4f.notion.site/9dd3cb65e08f4461ab2592548fb070aa</b>


</div>

### ‘점, 선, 면’ 이라는 테마를 선택하여, ‘단어, 문장, 작품’ 을 완성하는 iOS 애플리케이션 입니다.

- 개발 기간: 2023.01.07-2023.01.08

- 프로젝트 인원
기획자(1), 디자이너(1), iOS(3), server(1)

- ios
  - Alamofire : macOS를 위한 스위프트 기반 HTTP 네트워킹 라이브러리, 서버와 상호 통신에 사용
  - SnapKit : 짧은 코드로 autolayout을 표현할 수 있도록 도와주는 프레임워크, 레이아웃 존 지정하는데 사용

- Kakao 로그인 API 사용
  - 전국민이 사용하는 카카오에서 제공하는 간편로그인을 사용해 회원가입이 주는 피로함을 줄일 수 있게 함

- 깃 컨벤션과 플로우 준수
  - (깃 컨벤션) 사전에 미리 컨벤션을 협의해서 커밋할때 준수하여 가독성을 높임.
  - (깃 플로우) 기능단위로 이슈를 열고 브랜치를 뽑아서 작성하여 충돌을 줄이고 효율적인 개발을 함.

- 배포 환경
  - AWS EC2
  - AWS RDS(postgreSQL)
  - 배포 서버와 db서버를 분리하여 배포 서버에 부하를 최대한 줄일 수 있도록 함.

- 기획안: https://drive.google.com/file/d/14Nob_vBiZiZW7jZtADYmiZsE2ZTQF2_8/view
- figma: https://www.figma.com/file/8UHnoM2nd5dLF83r2huuOH/%ED%95%B4%EC%BB%A4%ED%86%A4-4%ED%8C%80?node-id=0-1&t=0odYlU5YS41myxRB-0
- api 문서: https://www.notion.so/caa988e14a224a80901ded1e440c082b?v=d3c5869cb72341029dbd984d7a3c034d
