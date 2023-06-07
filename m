Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E01C77B7A
	for <virtualization@archiver.kernel.org>; Wed,  7 Jun 2023 19:24:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35E31408E0;
	Wed,  7 Jun 2023 19:24:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 35E31408E0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=rzfSt77c;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=kMAkBMov
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mnKex34DmAP2; Wed,  7 Jun 2023 19:24:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4272E416F8;
	Wed,  7 Jun 2023 19:24:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4272E416F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11EAFC0037;
	Wed,  7 Jun 2023 19:24:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7425C0029
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 19:24:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B09AF60FBC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 19:24:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B09AF60FBC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=rzfSt77c; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=kMAkBMov
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9ZzUGzSYPS3c
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 19:24:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D9B9860BCE
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D9B9860BCE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 19:24:00 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 357EefK7017112; Wed, 7 Jun 2023 19:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=OnAuQhqJOSt2fKziBhyx7caNeve9h8ODrER/YnaOdYM=;
 b=rzfSt77cTf5afpCKaTaD4+pYSliyaj5wMM2GKzj7XsjpSxc7DmcuJJjGoKe5a0RUftzC
 xzCzxXLvu2tWbdPyYXvF17+mGl9/+uxFBjEg1kjUrBUCHYcBM4ZTN6GpE7RyBfOAh+YS
 aMMDzduVnu64y2BZhZeKaBsxi2s5NkqECZNL5KYZ+cLj5e0uTlKaMvtsRwEEgKqU6J8t
 yIrTxkKSW/V0FvGkWYvUzz5B3sbYt/6Ac7wDqGj+r0tV3ED5x4Y6bswbqXJqTBV0lPkQ
 fPpzspK4psUWypgLRU/JxQ4I/R22d7tCRRHxYdsjLGitebbXYZnV411jAd8Z7V61M6t+ hQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6pjkt1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 19:23:59 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 357Il5OK015653; Wed, 7 Jun 2023 19:23:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6m6cbe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 19:23:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqtFTW/LE1A1FSYkl67058gyqeaaFvCT4/AJvos9PhfdVlC8gE8iBMQMhQUmRc/3gAysGBPHeM4CEGiw16QdQI0ERCp9xTBXipvizkDxtlwgNsglH1rxviltv8eSTob1XOZV1OSIZH5gJ/GLgAvuM65HHIk+BecmJEgRxDemKX5BwXllyqAjIw118Ku9oKEhIHWO6EomRediPOPwGLQryuWsaUGFqfUCRdaaUeTyOFe2e8N+JZ7bT1F4CszCmceLPExQo7YTvWx6MAa5H/vD75n+liEZ/QgZz5OU2XWmbm+tmFDy4QERvWR/k/Femelg8h+7Mt7wtsPEhbh4MD+pZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnAuQhqJOSt2fKziBhyx7caNeve9h8ODrER/YnaOdYM=;
 b=eLmpewkrnsRz1MKISNPoIQ3hYQM8VehYnP2rglWyRxhuKgqbxr9+T4n6m1179QBWDLT+clOtqccG+A4+HMzZPDHLq2wt8skq2Tc9SNTcjGDHckQ8IwtUn+0mP6vni9BendqnrDmR29hxNPvtb9QHsbLV8LOnKSgonOX/JnYOAAl2ptaPhgZw2nUO8pK5NHtnVkNVovuMJrSuFt8Oj/xSStwAvAoN6vi6octrI+OPbAT2+kJRq/uIxSuafW0A4xmDcv0POG3K6L96CrHvE9PG15SP7gyzpLp7uOcqXbpZXygUDSkE15rIQWEEro2ik+kV0MrG9sU5kr6fFVdtSEv7JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnAuQhqJOSt2fKziBhyx7caNeve9h8ODrER/YnaOdYM=;
 b=kMAkBMovHUsw0IHpwNFIvSug2psQfQwyY66N7vYKJQfem4vaFxtSkeh4wLcSJpWaop65Ii0nC1VuP9fsMgXdPY+vCwaq8S4chDMPQksSc7FQkSA4j0RVvq+KjX8s6RP+DN3qsbN1jlWdnzuzEYwfoSbuIdovrim5Y9K1m9PzqU8=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB4808.namprd10.prod.outlook.com (2603:10b6:510:35::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Wed, 7 Jun
 2023 19:23:47 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 19:23:44 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH 2/2] vhost: Fix worker hangs due to missed wake up calls
Date: Wed,  7 Jun 2023 14:23:38 -0500
Message-Id: <20230607192338.6041-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230607192338.6041-1-michael.christie@oracle.com>
References: <20230607192338.6041-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:5:333::16) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB4808:EE_
X-MS-Office365-Filtering-Correlation-Id: a66cf7ec-6f98-42c1-c0f3-08db678cb5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cgq+0b9FVWkOpApBwEPf8dFi3HhbUeBUxjYJSIm4sF26ZCnsmqaBVpKA3mxLQu1Z4esmiXpoDoM7HGBv86QGbvzoHZl5VPv0C5o3pZ4enIfGV3ExytxelZzybUb++9gYkBQbcvTHpvJYRR9r7x5NKoyT4VT8h3ThfILGwm81qNCXmV8EWTvQo8qlppVdsEPsIT0U20QlkSXUGuVp3SgF4KHzjr7HCTN9Fd3DYl1jJ9sRKPi7irUketItHhP1Q2+sONqBGJPMLMjC3wsnNFvAI8N4J3Kay8/6HtgZ2ZjLlPuzw4cEI6Gh/cf2Jb73aXl4kHcfb0Ihdv667YcOzbpFISl51buxRkXtTcoe7Lop6wc005pYV/pY196B/23e4045S+8mie63acItNGoip3rK6+Ye8JNExRbNDLZej1bHuvV25OqP/ujwcQYmOOsWvN+FGtfkoimQTkpESIGhA4uPrWe59ynaoU56ejsoCE1GKeO4UzcDM0h+2sfS9JeGQ3lNT9fCzwb6Kctl19/RkawcqY7il9IMnCMmAXfmaoDQACdowYXXjdXYASg8qJECia9k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199021)(83380400001)(41300700001)(66556008)(66946007)(66476007)(38100700002)(2906002)(8676002)(8936002)(4326008)(316002)(5660300002)(2616005)(478600001)(6506007)(6666004)(6486002)(26005)(86362001)(186003)(1076003)(36756003)(6512007)(107886003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uSY4E9GA+7VT3+Ju/kSk/C1E7QjzlCrulgp1WBI6eBAQHWJGECqnnGzfLklG?=
 =?us-ascii?Q?xTqpyzdw3WVjPqj4UOBClTDlXC4lEraguIZSHYd0I25cgm9LQYmU+O9/4qv6?=
 =?us-ascii?Q?oQPYoV50eF+IxaFc0AzNv8x0+LDxK88uE0RH9FUgzNOZdMSwpqqJxItKEZhn?=
 =?us-ascii?Q?UUCqQKy3MXdaAsdXjZyblRcPtPzP46Nlpsvqj6Bj0UgdzV/TJ9pmSysXUVO5?=
 =?us-ascii?Q?uhu+eUMihMUaiwg6BhuDyk/ksiLYMRT3NI0fNGkXtFLNU0lzvvsTCc34PVsF?=
 =?us-ascii?Q?BlCynLIaOHhwOxktB7CPz7a5opo1z7uh+3DTZZuL9v5OSginfdpAykiXMn/I?=
 =?us-ascii?Q?yiiQ+J42G5ta1elGpOIQjRBzyl2UAfRpg2ez+GF2QK+H2iF1H0pvNFdJFExC?=
 =?us-ascii?Q?64F6lplI+e6P+GUSmegBPSAZwqMM2ESPR3WPzpoeLn76FQ7xfBFp/ICeqhjw?=
 =?us-ascii?Q?j/OvT+jB2c+dAzEMsKFQX0WiTY9VbmX6Q776tPdoZEaw21leMjxuwBQKLMPa?=
 =?us-ascii?Q?iu+BFiDjnlI32Doytc5ZBNXXDMXx40FnoWOn1TJ5mrC0Mh3PmB3kQMPpHYpN?=
 =?us-ascii?Q?fv4e5F1mZRGCya2vo0KneKtW7JoOFunKau+iWL95gRr4MzhsxwBYRZV1iHXj?=
 =?us-ascii?Q?9ITne1aRUBBrSarH3h7DndbqkC392KZMFcp2AZkoZk79SpLNbwcnwuHAYeNQ?=
 =?us-ascii?Q?g83cRp/bpLRmJuOsyqnKpofn4VxYfOicp4hZccDnhhIhpybC1+5j4sYdcL8u?=
 =?us-ascii?Q?JzArdPpe3uN1gyMtZqEZ5BYRDgEaQxk8Ael0eQ8XjAJtk5pTNpKAcQIEEf+S?=
 =?us-ascii?Q?8b1geSGztz5rcH1on6lzNxnZIvUQwY3r2wGNKZDiJQGF1lT1+PW/WzvA06vV?=
 =?us-ascii?Q?vAnrLN2QIg4awpu+jZIW3R80ilvKGQRWdKaje3ZBSZl4Tievdpp1qk7Z+g4Q?=
 =?us-ascii?Q?CJ1Y96HsktPUN5oJ8jyRkWDpBtX/WLwFUhFw6iXJOjsIS6+XwZMdtBBa289d?=
 =?us-ascii?Q?943emRkdfcogNKm657E0z3syxvOlOO6lKvfRL91W6wrWyaOyZT+RIZCgx331?=
 =?us-ascii?Q?FpOxEa36krseqSD0Z8VaYIdn4jq4DLTPKQg0xdjeM6UXNnmVb5ZQ8UxiBlCR?=
 =?us-ascii?Q?d+lUce0axc3ZXZQjFwCtY3dePfTdqO7ekDunTQ6uhgVD9cz5S/YDwSdRXC6e?=
 =?us-ascii?Q?1zQoyrs75Bs+FpkE62jXkNOWUvBdihDj4UGI2Ymh95v78JC2g7PmUu1YjUZJ?=
 =?us-ascii?Q?9zrA450HDOkmmei6LxNPyBpgfxQ0ouplPkk0MYR4vD5QLELoixhIaHvQ55eV?=
 =?us-ascii?Q?MuONMfpX7ddoeVXBwOwgP0Sj7g7thWAap+OdyK/WJJ4TZMJMdx03bBQ+kD6I?=
 =?us-ascii?Q?og3p1betGYLmF5F2+nQ4nluMLygFthQze8dz5tDslAkiLn7YnbzPWKBRdyhc?=
 =?us-ascii?Q?KpHrJY5zRxzoahlhFIh5UCt1XBymXPkbk0+3gLzAvDFYbRsJkr4JH39/Wv6V?=
 =?us-ascii?Q?okKE/7zmfXG8tAha1/wNMQLjDdo40xUK86vLoSXF43stUCgAxfIAi+nOpU8I?=
 =?us-ascii?Q?hnHCivcYXxxlN+UeVRbE8bDoe2qPXVQF5zPZnuZkgX7wnXAutPFlk9v96VSq?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nY5dAzXVfKPdXj0YwE7grUOwkLs3hj0ZaIShRHcpqrkX7i4kFKRP77Q4i0LAT7hWSXbY7uB+fEZ73xce+dlQfFGZHbw+9RndHUjOXms1W+ua07GitNx+Ktc4Kg1Z8EuNhhjo+8orWPM+7w9auvu9rwAttdf+1vDdQePBDAK9MosuyZQo7XhZeBssqsR3Eigul5mHkKB8cKDsg58Z3QneMT6JWsM222a4Mkw7PWuF8D+WF7mrksAOBRsqHiRjtR4vKMluoH3xNZijjWAn1mj53Rw4UDdZZrXO2jj7FPRoq6Bve1pqK4E9wzgQbt9EIWIZbq8yhEg6XQ8TLkrvnKANuid/e/eQAEuAzVXIEvpExx0Wws3lYBERrNTjXkuEb6mY/Px0uXrsqinLeu7zefoTH4boA5GoeGd2pOBcSzspHMHKd4zNLZDu1BatAhgyib6/ZwoO6ikCrFvVA4cAdsqACvm+6vEEVKIY7KUrACACuXlHP6JKJfTxj5rwcBmeegn+GD1ZKZlC2C5OQafkyjDVfb3FT73rUwFfswx1CAu2hLqAtbygLZOgr43giU9Gd6f4huB/4Do+Msfo7HqaYayKrxDFvvwxEm8O5Y1LzKLkb3894lUQJB/aceednGxvwwxBfxynX1rBTQtb9DhVTRkihHt0o9oBDHzF4ZLpDoptAZS8meo4vt9bdDR7z2lboPlChtb8G2CAMjRFcFZoKN8fEVuKRNQhb7zuyej8P4UvD1w8hhtCqIYSxD5D76pRezMN7cGFQuzwEYjaroY6FCXYyB6yV5zz3cDWqTpYEX6ye9O3u+7DVHrzmC/QQDQAi/DK
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a66cf7ec-6f98-42c1-c0f3-08db678cb5d6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 19:23:44.7940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ng8NbjxxkBmu9+IiKdBOmeHqMNwxUuuj3DJQSJXWCb4IPZnNb+vmAhtMBPDokcYSrcmUIgfKZpWZD7Ru/fSjjbm4+SnSbUJXGcMNS+39LqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_10,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070167
X-Proofpoint-ORIG-GUID: 2U1Wnys52ZClO9jSMXVg9OOJYKQNfJkd
X-Proofpoint-GUID: 2U1Wnys52ZClO9jSMXVg9OOJYKQNfJkd
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

We can race where we have added work to the work_list, but
vhost_task_fn has passed that check but not yet set us into
TASK_INTERRUPTIBLE. wake_up_process will see us in TASK_RUNNING and
just return.

This bug was intoduced in commit f9010dbdce91 ("fork, vhost: Use
CLONE_THREAD to fix freezer/ps regression") when I moved the setting
of TASK_INTERRUPTIBLE to simplfy the code and avoid get_signal from
logging warnings about being in the wrong state. This moves the setting
of TASK_INTERRUPTIBLE back to before we test if we need to stop the
task to avoid a possible race there as well. We then have vhost_worker
set TASK_RUNNING if it finds work similar to before.

Fixes: f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")
Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c |  2 ++
 kernel/vhost_task.c   | 16 +++++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 7a9f93eae225..b2722d29e069 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -341,6 +341,8 @@ static bool vhost_worker(void *data)
 
 	node = llist_del_all(&worker->work_list);
 	if (node) {
+		__set_current_state(TASK_RUNNING);
+
 		node = llist_reverse_order(node);
 		/* make sure flag is seen after deletion */
 		smp_wmb();
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index f80d5c51ae67..da35e5b7f047 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -28,10 +28,6 @@ static int vhost_task_fn(void *data)
 	for (;;) {
 		bool did_work;
 
-		/* mb paired w/ vhost_task_stop */
-		if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags))
-			break;
-
 		if (!dead && signal_pending(current)) {
 			struct ksignal ksig;
 			/*
@@ -48,11 +44,17 @@ static int vhost_task_fn(void *data)
 				clear_thread_flag(TIF_SIGPENDING);
 		}
 
+		/* mb paired w/ vhost_task_stop */
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
+			__set_current_state(TASK_RUNNING);
+			break;
+		}
+
 		did_work = vtsk->fn(vtsk->data);
-		if (!did_work) {
-			set_current_state(TASK_INTERRUPTIBLE);
+		if (!did_work)
 			schedule();
-		}
 	}
 
 	complete(&vtsk->exited);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
