Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E73C7EE2E
	for <virtualization@archiver.kernel.org>; Tue, 13 Jun 2023 01:33:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BB1C4097A;
	Tue, 13 Jun 2023 01:33:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0BB1C4097A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=kFAKSxp7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=xnmGkfHx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NbPnpYU7ppzY; Tue, 13 Jun 2023 01:33:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1A81D408C3;
	Tue, 13 Jun 2023 01:33:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A81D408C3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77A45C008E;
	Tue, 13 Jun 2023 01:33:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A3E5C007A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 04B60402E2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 04B60402E2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RpVMnByFPEGy
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2561F402D1
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2561F402D1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:19 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CKNt8H031449; Tue, 13 Jun 2023 01:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=0lIbe3BKHnt4wvwxFZESIQVQ0xB/JTFwNIyquGjcuMk=;
 b=kFAKSxp7CDhJ5oZTGqKsH2v2cQlyM6lJhjXryvptbyTBs9lqBKf3MKOmF91mOacchXMe
 rGY3trGdC9Po2Avjgn5FJdiaWos6qX/jP9cTlp+08Gi3ajghLme5fUWMRASALvSFLpTM
 l4YjmbgWg6iXdrPsiNr81gzmk90APMx4IK0VAK0AfW4NO3o2ejZJgHO3quxrk67dIRl0
 sLL88nKy42+wEGvRtyCvE6dK3TCnkj/MQnE+s5gnPnYN/0UzJAu1i4nhSt6v3ZoOtCfX
 Qf9ddR196N4Ogivnw4Jix9btsgsKCtxNoTug0MAb64DHkP2G2OhNRHcCw4XTa8WLCeqd NQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gstv3gy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:19 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35D1CJRH021613; Tue, 13 Jun 2023 01:33:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm3hg44-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRkKx+i4WPMbvrVyQtBAIcnjK4FDOtCrR0P8EGbPoMR5fOk579u1c6Mh7TcAglCXYXuVRBklhbiS9x/WgT2J3lUOLRfhggjkxE+9dLMAyGvy6efijB/DlDAsorQGY8eD55tfza9dIpgQaaCSppKljVzTyWAHtfJiYnikHU+PCmF/nIeXYGiOxfYXIqtfRdHUdHsF1s7TNVq+HMiMF8sVZeOsIzvnVvLJeDOOLZmOPWGTeAWPsRQxu72EAiN0o1j1dCuaYmEWpmLjAsgEnxIuJPXZ65Yk74fOLBvJb6VTpFoi0cIVW66M83P+EdKdo7XuKJmvrTIk+QFYPDNLL6QTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lIbe3BKHnt4wvwxFZESIQVQ0xB/JTFwNIyquGjcuMk=;
 b=UXg2UnBX+qD8RbdzlJsDEkMaqYm4vzaTA3QfbL9g4IV4k4hNK+3bmPMIMSVB/466iIysNfiX0MR9D+wDtcass4qNsrsC35ut8BbKocFCuS/AaiCfT6gFYXDBzrbMCv4PAmUatvIjyG1mZx5e/xYce2VfxZrfSNPuQk7EJKM5UoQwc7ipVgZkCdwgZiArXVfvPkYRceEsZtydM+o5ppv40PERuSBK24l5+eocdBv4ilOzd4Xik+l4mpAB1Ft2UI895clBQUdQBVM0EeAv9S1lnX6337yy1yT0R82sBkEEgOOUi3Yv/sX6U3P/vT9aqjrPl07w+f571Ot/qJWkFG//2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lIbe3BKHnt4wvwxFZESIQVQ0xB/JTFwNIyquGjcuMk=;
 b=xnmGkfHxt3LDnVhMRAjgMOSA2hYTTRDAXrS5mp/0OcuDTnbXyMXPaGO9QVm/Igc95K9vpmbyTx6dYN6xh9wKDqPRv22hdCdIfMxL6hYPVMirX2bXg29KCaDRjclpaLtkUPoBZIrdzIAYjfwnHPJrKhA32mIj2sjX6sCjx4RdK+A=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 01:33:03 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 01:33:03 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v8 08/17] vhost_sock: convert to vhost_vq_work_queue
Date: Mon, 12 Jun 2023 20:32:39 -0500
Message-Id: <20230613013248.12196-9-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613013248.12196-1-michael.christie@oracle.com>
References: <20230613013248.12196-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::27) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d1b7ba-e53d-4214-dc8d-08db6bae21af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w6Ep8W4SL+R50a1RmZfq3qDl9LkAScdv99wuu9M1QPvbQZjkonxUIIWm0jn4VU7bzhjyiwkenK9pj3P/Qg67kUHlYrJfSpM/1oxbG3lKUnOOU1sofQwFWIKYiqr7ZUqKtjfT5y4qQuRrZP+OTCtfYOSWsTj2euMYG8JFCwK+awcCzRwZYr5s5w+Vadb8/iesIhE6/B2g/D9LGINEMcngGzXcLPvxQ+totr12Ayf0EQ1pN3Wn13apigC1sU56Rah4NW5Z6d9fA7C/4AlqI05kUzZ2F6M3xdyYTkDM/7BgWp88p+jAawDTdWeSvO9igGWQ2CxF3rKp6Y/7kEOMaIulAFe7ZpdEn1BSIvrKP7ExVKj5rgMVH6UYtf8IENcWEFT4Z7TpIryf42NyZGChL5Ed7KBGJKqgcviJ2g4BFpO0Xx6Nk9FHJVVGyXIDiu+OTdhEijEq6VqlfuNYrgpnCXuQp1dooOG1/ZAkGPZ1g7h+buUsCZSe7Jx9qzAPGbSLgSTFnT2OlZsMj3ParcXqoVFynHzfs2rrkia20/9MYWT6mYgInMDuq5Twu1Oid0CTRWHs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(36756003)(86362001)(66556008)(4326008)(478600001)(66476007)(66946007)(6666004)(316002)(107886003)(6486002)(8936002)(5660300002)(2906002)(8676002)(41300700001)(38100700002)(2616005)(6512007)(6506007)(1076003)(26005)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SmJvcLE+IdVsj1jV38qj1JtN1mNULoRChmftvIt9KlA4I81BE1xQLHhJ5zpY?=
 =?us-ascii?Q?DX5Xy9FnGgk3sOlOTJXDKURAI+1EksnKIDRKX/9b5K85/rTVaRh0KXzQWDNB?=
 =?us-ascii?Q?IoyeIhlSE/DhB5C/9CrZcHcLMFarCWp/T9a/8qRvexCDfS85DaXrtzdCFYLZ?=
 =?us-ascii?Q?BSa48AOIlvi9zVdIc86zH3rg/AJ2whtq+87/oWCZKtHPqvMVbT+EJeKNDtMf?=
 =?us-ascii?Q?UQvDFwax6qsHs3sjAVbZJ8UbV68AMTgxaNIoqhtJYlrbo9bTIo1SqAlBbMfP?=
 =?us-ascii?Q?NNCEwwemjtpnHZ7auPI15310zFIMizTEPiyCQhtKhyHLqC82C6dAQyptYCeK?=
 =?us-ascii?Q?419v3wwjWMu5zIhk4aVBIx8UPIQ+RFKb5GASH1ij3Zt9/Amu7bK0ToG9rI2e?=
 =?us-ascii?Q?DHAZaWUK0ky6/8T1w5ds1VupjmYxiQfj/tcdJEBiROwrfYJVMgDeIim1ZWJi?=
 =?us-ascii?Q?0NXuHh1wZKI3d7ym4C53m/kSEXzhsVf/VJUk1zfk7lVJ+TODmj/UoqwUmD3N?=
 =?us-ascii?Q?/+cMmTRi89hVi5DxMi1NIteW4qsax0rT5BAxcdA7FtVEy0FhVDDOyNfr/zda?=
 =?us-ascii?Q?CPhItGuUsD4HZkA4j0Z5Ypi4p3qPgQmT1TFDgCDEr+C9QiCp9rLXRa14sBNA?=
 =?us-ascii?Q?8CCQDJVTJd2SDijE3S4NChHcKNPiE9LKWBKH4FlH3LSFRcINHOvPym7Fg4yR?=
 =?us-ascii?Q?S3xvZRjfPBiwiLukrSw3sMratOr/VX999z0Q9/CtovmvKn4TAVuhNJM6V1TO?=
 =?us-ascii?Q?73uk5L4hRzHaneK1GbwWFxbDyDXHfrBP9qo2lgoGswVE4ik623F/3CKzuJDi?=
 =?us-ascii?Q?/J7xUP3wxUZpFs07ewEgbbOFght83MQoWrGQuss011MsvP1HZpEej57JFYKz?=
 =?us-ascii?Q?Y6VrmXEvM+dG9bRgX0ncUUM8hx5oefLCZ0kdLDYisd5XxAP5T0ptVsnSZZcP?=
 =?us-ascii?Q?tuu37wV3uSYvSYhHi8xOXG4Ma5DMNaRl38gCoIb6y9lhE4YqCbQIJOplzSyh?=
 =?us-ascii?Q?8JtMLu0KANdgpezVdBx3rGozxGiP6wWyXak5Tls98lVBAsD8silgaSRI6+bv?=
 =?us-ascii?Q?xaIzmgzT34w/nWlmTKkEnYC3TKOUIZ0BonteRJXs83Qin6w330KSlon9maOc?=
 =?us-ascii?Q?g566ZuB2W+8nwYmnA4hsarAeIlHgGcqLaKX23p7Zv4Epv6xZsYkNhG4njp4A?=
 =?us-ascii?Q?WdiR2ClhlMvbnArsbSUSJ3mB7C/zg8knN/uJoP8fpPuan2EgJOMWMzcW4lnW?=
 =?us-ascii?Q?2bPx5kTX9ma3ZLiEoo9G12rlplaynb3pkmS+mc/kUDMl1aCDCbF2g7OhgCTt?=
 =?us-ascii?Q?CzIekodKVBL4ioIw5qJCbAEfORaYw0hPgBkj2JzUKsPrBD+LSZcit9swmABe?=
 =?us-ascii?Q?+8y5XMF7DPDsNjJH6suij8DbDHZGL+hGCh55BloZVldEsLyzpgELAjfQELc3?=
 =?us-ascii?Q?e8XmaFIBXuTnfb7TfSMHeiVRecatd5D/0+CAFTfrOEoq9MlKsasw5S74V5SE?=
 =?us-ascii?Q?gFsctFdD+jTYqUd3XsTLTyao1cBbuoIBn/o82MZqBH15Pc5Fv7cskxypbDDh?=
 =?us-ascii?Q?RszfZ7ptQq6QyFd2WGeqktcA2Inj61s//+3B2NNwxlbMq/gsQVw0MZ9zVYC+?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PwhQ4tQ5mrYO9f89/5qYWEoVQ5zfeGoUrJcmtshgjw4XH0Mgcod1x/RzSs61o5MMkg5ZMW6WAXsYLliBY6wZ9ysGB3Jic/rpJYUjf85cVjDLpXA0k6IreKZ0+kad5RnItfV044o5IRqvUicKONmxzPqWtgn2G66oqUsdRwRvg7lwVHLrl/blHjYC9mg+ks6jYnhSJNHZZy0AuKC/u8fiiVVoxnnBaxEkNKL4hBPqVscPL6+BJ8dalkVxwBrx+3uCrcmZmiRYDnTarLzmFZnegxf7G68eH07i7XVP0Uikyz2zq8DpbxqGdjS+RvdqMhrl+XgVtDyVxQOQZGeelvGGkzH0qzXSMPMGQXocgRZRHK17MM4xucbgzFx3/k54RCWQXtrStUUDnxJf77enftS7Ht72edCEGandIoHWOYBHEEFf0/GIJL67E5lX2manIzL2aFWfkt6NwrTGOZ5q+yNWtgpeZ8Us0iHW2DHzm4Ob0VIwAAJzhUAyDfBDWnhakZFZ1lo9Zy4vjNZoN6I13cLhA49/E67lShjdcOM2a4hZEPfDt0ouyN0Zyt9SpJOp8GbsjolXZNSYo5p/fOUs5BnlrvPGduwAKChYFze0AhuRijUUnd8tVqsfaU97C3iHFYTDYzR6AucHIqAPfabPxnHcY3xop1oesYwS9FCErHsrc028ehjsY/HVkdjzSElwWQmz3pXC2xTvIebBA60TSISTInMvC4QqBPgZldjzjoR1gEoX7QjznIeUM5iyFmvHNeJJnbB7IS2SWsFNndMQh+vL2pKlYSNTT5zSIP+y1HTeKNr/s+6yUb9bvCYCRlNp375D
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d1b7ba-e53d-4214-dc8d-08db6bae21af
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:33:03.7768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 012bU5VWxPbt4i+xk7ualzeIHeQ8gH7oqhEytYxfRsC6Z6oZSKqI+GIuET1I2XstR7WodncykKx4AEIr38z0Vjs7YI9BgDRc6Qi1Mc3LWUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130012
X-Proofpoint-GUID: u75nvi986vPgplWD4iRNnpqKtqwervWw
X-Proofpoint-ORIG-GUID: u75nvi986vPgplWD4iRNnpqKtqwervWw
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Convert from vhost_work_queue to vhost_vq_work_queue, so we can drop
vhost_work_queue.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vsock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 6578db78f0ae..817d377a3f36 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -285,7 +285,7 @@ vhost_transport_send_pkt(struct sk_buff *skb)
 		atomic_inc(&vsock->queued_replies);
 
 	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
-	vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
+	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
 
 	rcu_read_unlock();
 	return len;
@@ -583,7 +583,7 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 	/* Some packets may have been queued before the device was started,
 	 * let's kick the send worker to send them.
 	 */
-	vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
+	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
 
 	mutex_unlock(&vsock->dev.mutex);
 	return 0;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
