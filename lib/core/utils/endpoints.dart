class Endpoints {
  // generic
  static String countries = '/countries?do_not_paginate=1';
  static String downloadSong = '/downloadSong';
  static String states = '/states?do_not_paginate=1';
  static String serviceStatus = '/service-status-check';
  static String serviceCharges = '/service-charges';
  static String paymentMethod = '/virtual-account-providers';
  static String faqs = '/faq-categories?filter%5Bstatus%5D=active&include=faqs';

  // Authentication
  static String registerUser = '/auth/register';
  static String loginUser = '/auth/login';
  static String logoutUser = '/auth/logout';
  static String confirmEmail = '/verify-user/channel/email';
  static String confirmPhoneNumber = '/verify-user/channel/phone';
  static String verifyOtp = '/auth/verify-otp';
  static String resendOtp = '/auth/resend-otp';
  static String resendEmailOTP = '/resend-verification-mail';
  static String forgotUserPassword = '/auth/forgot-password';
  static String verifyPasswordOTP = '/users/password/verify-reset-otp';
  static String resetUserPassword = '/auth/reset-password';
  static String googleSignIn = '/google/signin';
  static String updatePassword = '/update-password';

  // user
  static String user = '/user';
  static String userProfile = '/user/profile';
  static String liveLocation = '/user/live-location';
  static String updateProfileImage = '/update-profile-image';
  static String changePassword = '/user/change-password';
  static String changeAvatar = '/user/change-avatar';
  static String unlinkSocialAcct = '/user/unlink-social-account';
  static String setTxPin = '/user/set-tx-pin';
  static String changeSetTxPin = '/user/change-tx-pin';
  static String userWalletss = '/user/wallet';

  //bank

  static String banks = '/bank/list';
  static String resolveBanks = '/bank/resolve-account';

  //PROMOTION
  static String promotion = '/promotions';
  static String getOrderById({required String id}) {
    return '/promotions/$id';
  }

  //USER LEVEL
  static String userLevels = '/user-levels';
  static String initializeUserLevel = '/transactions/initialize-level-upgrade';

  //PROMOTION_TASK
  static String promotionTasks = '/promotion-tasks';
  static String PerformpromotionTasks = '/promotion-tasks/performed';
  //Platform
  static String platforms = '/platforms';
  //Notifications
  static String notifications = '/notifications';
  static String readAllNotifications = '/notifications/read';
  static String readNotificationsById({required String id}) {
    return '/notifications/read/$id';
  }

  static String deleteAllNotifications = '/notifications/trash';
  static String deleteNotificationsById({required String id}) {
    return '/notifications/trash/$id';
  }

  //Transaction
  static String initialiseWithdrawal = '/transactions/initialize-withdrawal';
  static String transactions = '/transactions';
  static String initializeWalletFunding =
      '/transactions/initialize-wallet-funding';
  static String verifyTransaction({required String id}) {
    return '/transactions/verify-transaction/$id';
  }

  //Upload
  static String uploads = '/uploads';

  //Onboarding
  static String addUserExperience = '/add-user-experience';

  //Road Map
  static String feedBacks = '/roadmap';
  static String addFeedBack = '/roadmap/add';
  static String vote = '/roadmap/vote';

  static String latestCampaign = '/dashboard/latest-campaigns';

  //DM - Campaigns
  static String fetchAllDmAutomatonCampaign = '/dm/campaign/all';
  static String dmCampaignMetrices = '/dm/campaign/metrics';
  static String resumeDmAutomationCampaign({required int dmCampaignId}) {
    return '/dm/campaign/$dmCampaignId/resume';
  }

  static String pauseDmAutomationCampaign({required int dmCampaignId}) {
    return '/dm/campaign/$dmCampaignId/pause';
  }

  static String deleteDmAutomationCampaign({required int dmCampaignId}) {
    return '/dm/campaign/$dmCampaignId/delete';
  }

  //DM - Leads
  static String fetchDMLeadsCampaign = '/leads';
  static String getAccountLead = '/get-account-leads';
  static String getLead = '/get-leads';
  static String fetchLeadsData({required int leadCampaignId}) {
    return '/leads/$leadCampaignId';
  }

  static String downloadLeadsData({required int leadCampaignId}) {
    return '/leads/download/$leadCampaignId';
  }

  static String deleteLeadsData({required int leadCampaignId}) {
    return '/leads/$leadCampaignId/delete';
  }

  //DM MESSEAGE
  static String conversation = '/conversations';
  static String conversationDetail = '/conversation';
  static String sendMessage = '/send-message';

  //Xaccount
  static String fetchXaccounts = '/xaccounts';
  static String addXaccount = '/add-xaccount';
  static String saveXaccount = '/save-xaccount';
  static String deleteXaccount({required int xId}) {
    return '/soft-delete-account/account/$xId';
  }

  //AI SMART CONTENT
  static String smartContent = '/smart-content';
  static String resumeAiSmartContentCampaign({required int smartContentId}) {
    return '/smart-content/resume/$smartContentId';
  }

  static String pauseAiSmartContentCampaign({required int smartContentId}) {
    return '/smart-content/pause/$smartContentId';
  }

  static String deleteAiSmartContentCampaign({required int smartContentId}) {
    return '/smart-content/delete/$smartContentId';
  }

  //GROWTH TOOL
  static String growthTool = '/growth-tools';
  static String growthToolMetrices = '/growth-tools/metrics';
  static String growthToolCampaignMetrices({required int campaignId}) {
    return '/growth-tools/$campaignId/metrics';
  }

  static String resumeGrowthToolCampaign({required int campaignId}) {
    return '/growth-tools/$campaignId/pause';
  }

  static String pauseGrowthToolCampaign({required int campaignId}) {
    return '/growth-tools/$campaignId/pause';
  }

  static String deleteGrowthToolCampaign({required int campaignId}) {
    return '/growth-tools/$campaignId';
  }

  // Wallet
  static String wallets = '/user/wallets';
  static String walletTransactions = '/transactions';
  static String initiateWalletfunding = '/transaction/wallet/init-funding';

  // bill
  static String fetchServicesByCategory({required String categoryId}) {
    return '/bill/categories/$categoryId/services';
  }

  static String fetchServiceVariations({required String serviceId}) {
    return '/bill/services/$serviceId/variations';
  }

  static String payBill = '/bill/pay';
  static String verifyBiller = '/bill/verify-biller';

  // Notifications
  static String updateUserNotifications = '/update-notification-settings';

  //Free Credits

  static String tasks = '/tasks';
  static String completeTask({required int id}) {
    return '/tasks/complete/$id';
  }

  // // Bank Accounts
  // static String allBanks = '/banks';
  // static String bankAccounts = '/bank-accounts';
  // static String verifyBankAccount = '/bank-accounts/verify';

  // // referrals
  // static String referrals = '/referrals';
  // static String referralTerm = '/referral-terms';

  //services

  static String systemServiceTypesEndpoint({required String type}) {
    return '/system/service-types/$type';
  }
  // static String verifyAirtimePhone = '/airtime/verify';

  // static String buyData = '/data';
  // static String subdscribeCableTv = '/tv-subscription';
  // static String verifySmartCardNo = '/tv-subscription/verify';
  // static String fundBettingWallet = '/betting';
  // static String verifyBettingWallet = '/betting/verify';
  // static String buyElectricity = '/electricity';
  // static String verifyMeterNo = '/electricity/verify';
  // static String purchaseEpin = '/e-pin';
  // static String verifyEPin = '/e-pin/verify';
  // static String getGiftcardCategories = '/giftcards';
  // static String getGiftcardProviders = '/giftcard-categories';

  // static String intlAirtime = '/international-airtime';
  // static String intlData = '/international-data';

  // static String transactions = '/transactions';
  // static String giftcardTransactions = '/giftcard-transactions';
  // static String scheduledTransactions = '/scheduled-transactions';

  // static String serviceProviderEndpoint({required String type}) {
  //   if (type == 'tv') {
  //     return '/tv-subscription';
  //   }
  //   if (type.startsWith('data/')) {
  //     return '/$type';
  //   }
  //   if (type == 'e-pin') {
  //     return '/e-pin';
  //   } else {
  //     return '/$type/providers';
  //   }
  // }

  //DASHBOARD
  static String accountBalance = '/dashboard/account-balances';

  //AFFILIATE
  static String affiliateStats = '/affiliate/statistics';
  static String affiliateCommissions = '/affiliate/earnings';
  static String walletBalance = '/wallet';
  static String payout = '/wallet/payout-history';
  static String requestPayout = '/wallet/payout';

  //LEARNING
  static String courseDetails = '/learning/student/course-detail/93';

  //PLANS
  static String plans = '/subscription/plans';
  static String foreverPlan = '/access_plan/forever-plan/request';
  static String creditOption = '/subscription/credit-options';
  static String addOns = '/subscription/get-addons';
  static String purchaseCredits = '/subscription/purchase-credits';
  static String purchaseAddOns = '/subscription/purchase-addons';
  static String subscribe = '/subscription/subscribe';
  static String downgradePlan = '/subscription/downgrade';
}
