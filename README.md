# ❄️ 냉장고 재료 관리 서비스: Frish 🥕
<p align="center">
<img width="187" alt="스크린샷 2025-06-21 02 15 37" src="https://github.com/user-attachments/assets/4af987c7-a1bb-4ea5-bad3-4f85e1174689" />
</p>
MapAPI: Naver Map, Kakao Map Search <br/>
OpenAPI: https://www.data.go.kr/data/15060073/openapi.do <br/><br/>

> 재료마다 일일히 포스트잇으로 소비기한을 붙여놓기 보단,<br/>
> 소비기한에 임박하면 알림을 보내주는 FRISH와 함께 효율적인 냉장고 관리를 시작해 보세요!

<br/>

## 🎥 시연 영상
https://youtu.be/Ov1ndLB0psQ

<br/>

## 🔥 주요 기능

- **재료 등록, 조회, 수정, 삭제**
	- [냉장, 냉동, 실온]별 재료 등록, 조회
	- 조회 화면에서 개수 수정, 재료 삭제
	
- **추천 레시피 조회, 검색**
	- 식품의약품안전처 OpenApi를 사용해 레시피 조회 및 검색
	
- **마트 체크리스트, 지도**
	- 마트에서 살 품목 체크리스트 기능
	- 현재 위치 1km 반경 내 마트를 지도에서 조회
	
- **소비기한 임박 푸시알림**
	- 소비기한이 2일 전, 당일인 품목 푸시알림
  - 알림 목록에서 2일 전은 노란색, 당일은 빨간색 아이콘으로 표시

<br/>

## 📱 화면 구성
|로그인 화면|회원가입 화면|
|--|--|
|![Simulator Screenshot - iPhone 16 - 2025-06-14 at 19 41 32](https://github.com/user-attachments/assets/f197ec22-9409-4e12-90f2-29aeed9d5ff8)|![Simulator Screenshot - iPhone 16 - 2025-06-21 at 02 26 23](https://github.com/user-attachments/assets/a7c3eef3-8a51-461b-a0d4-afc42d1f8d0b)|

|메인 화면|내정보 화면|
|--|--|
|![Simulator Screenshot - iPhone 16 - 2025-06-14 at 19 40 17](https://github.com/user-attachments/assets/6c5a3921-adba-4ba5-a883-6b87b4e34c7f)|![Simulator Screenshot - iPhone 16 - 2025-06-14 at 19 40 41](https://github.com/user-attachments/assets/1918413f-6b1f-4474-bbc6-149596c4eccf)|

|재료 등록 화면|재료 조회 화면|
|--|--|
|![Simulator Screenshot - iPhone 16 - 2025-06-14 at 19 40 28](https://github.com/user-attachments/assets/12cf6642-3ac3-46fd-9ca7-cb6708a212e3)|![Simulator Screenshot - iPhone 16 - 2025-06-14 at 19 40 22](https://github.com/user-attachments/assets/fa271a42-ff71-4272-b249-2d8a6c3160c5)|

|추천레시피 화면|레시피 상세 화면|
|--|--|
|![Simulator Screenshot - iPhone 16 - 2025-06-14 at 19 40 52](https://github.com/user-attachments/assets/bd5c8fe1-8772-4c62-a29a-41b9bedc5d5a)|![Simulator Screenshot - iPhone 16 - 2025-06-14 at 19 41 04](https://github.com/user-attachments/assets/0194b127-7615-4a15-8043-3d391e50c060)|

|체크리스트 화면|주변 마트 화면|
|--|--|
|![Simulator Screenshot - iPhone 16 - 2025-06-14 at 19 41 10](https://github.com/user-attachments/assets/65599028-cb83-43e5-abb5-5cc39b3f7d73)|![Simulator Screenshot - iPhone 16 - 2025-06-14 at 19 41 19](https://github.com/user-attachments/assets/b4129659-db99-42be-8fa2-19f96609cbc9)|

|푸시 알림|알림 목록 화면|
|--|--|
|![Simulator Screenshot - iPhone 16 - 2025-06-14 at 19 39 58](https://github.com/user-attachments/assets/4e3d1b00-3575-4f3c-9d46-bb52160d2cc7)|![Simulator Screenshot - iPhone 16 - 2025-06-14 at 19 40 11](https://github.com/user-attachments/assets/bfdb786b-9497-4193-aece-7391f4202f2f)|

<br/>

## 🆙 추가하고 싶은 기능
- 추천 레시피 찜 & 찜한 레시피만 필터링
- 나만의 레시피 메모 추가
- 앱스토어 배포

<br/>

## ⚙️ 개발 환경
**Environment & Language**<br/>
<img src="https://img.shields.io/badge/Xcode-147EFB?style=for-the-badge&logo=Xcode&logoColor=white"> <img src="https://img.shields.io/badge/Cocoapods-EE3322?style=for-the-badge&logo=Cocoapods&logoColor=white"> <img src="https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=Swift&logoColor=white">
(Storyboard)

**Tools & Services**<br/>
<img src="https://img.shields.io/badge/Firebase-DD2C00?style=for-the-badge&logo=Firebase&logoColor=white"> <img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=Git&logoColor=white"> <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=GitHub&logoColor=white"> <img src="https://img.shields.io/badge/Figma-EC5990?style=for-the-badge&logo=Figma&logoColor=white">
