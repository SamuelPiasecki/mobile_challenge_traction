# Mobile Challenge Traction

This is a mobile application built using **Flutter** and **Riverpod** for state management. The app is designed to display a list of companies on the homepage and show their related assets on a detailed page. 

## Pages

### HomePage

The **HomePage** displays a list of companies fetched from an API. Users can see the loading state while data is being fetched, handle errors, and tap on a company to navigate to the **AssetPage**.

### AssetPage

The **AssetPage** is used to display a detailed view of a selected company's assets. The page supports search filtering and various states such as loading, error, and displaying assets.

## Dependencies:
- Riverpod
- go_router
- http
- flutter_svg

## Points to improve
If I had more time, I would create a more organized and structured UI by separating widgets. I would also spend some time testing the app to make sure that everything is working perfectly. However, the main thing I would improve is my tree structure and filters. I believe there are better ways to handle this problem. I tried to take the approach of creating a class for the tree nodes and using DFS for the filters, but not everything is working as expected.


https://github.com/user-attachments/assets/20af9c7c-abc2-4586-9fbb-e57864ea0098

