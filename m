Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260B8EB64D7
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 23:23:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA2714185A;
	Mon, 26 Jun 2023 23:23:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA2714185A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=BMsOm+x+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=V5L/Ip2A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sYB7ACmHHp-5; Mon, 26 Jun 2023 23:23:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5F33B408AD;
	Mon, 26 Jun 2023 23:23:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F33B408AD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F7F9C0037;
	Mon, 26 Jun 2023 23:23:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C55AC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3DB9E61175
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3DB9E61175
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=BMsOm+x+; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=V5L/Ip2A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XUU4OjHZ_VBe
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C7AF260FE0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C7AF260FE0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:37 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QMi67Z023174; Mon, 26 Jun 2023 23:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=NPN4ALPiTWSufXn5F6wYB5Xfg3inYUngLWZ5K1cfa8Q=;
 b=BMsOm+x+/o6EwN7oYtsFXrhHIc4s+UrTmQhUeFBxky51mBVU2X7dSnj23GijpxZCuvm0
 77bVUiU+ns7laRwCkliPQ5wCKvmFyCf0dGodUnxobuCBmoOlQrrlUKj14F0Sb3x4TpXU
 B7LWDemn7y6orS8uY+iz5lTv9hTS/DT7mPXozgo+2mNclX0cXZ4v1NlXfRi02F2GYjpx
 RAA5FKWSuvolJoc9GXKtGMr7vyWWKjznqsXC7TkL0r47zqWvXqpocO0QP1rCBLONE7/U
 1izVUn8EmcLHCpyO3GCRIWgwjIOg/6C98/9YEJKlvl30zi5hIdJl9sVaW+Z5pjkiGzvZ XQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq933ufh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:36 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QMnGk7028296; Mon, 26 Jun 2023 23:23:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx3rghw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9/wBHFJIIJ47xx6/MKtRxtRKv8iv1HbpY5UeC3qd2FlLA+VZicdtzQJBd3mtRMrpbOXk8/F4cJBi1y009yeGYKm1lzS35b+jV4bRL8YKRLM9Qyl05ZovtPfK62QZk79Fk8zJlJsd7t7ql+D8TyxdDvvNwqk0OxR3TmaBE6WzVNhDEdTMe0eQ6QJq+2nmUtA+Np4Be7ljcezXBb8kcbCJq0sePPttB9j+NuTx1rL/IVAuBHnRyWJkPE7pJwiA3fyULkh5IcNJ8jbbf5/IAwWe5WsztlVwEG44UNfbCAKs2CKklNqQCOjVwYgur1melq8WzlLqCswFGbcuIaSCSVOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPN4ALPiTWSufXn5F6wYB5Xfg3inYUngLWZ5K1cfa8Q=;
 b=NvruI6pFexN31pxnp5qXqSvHuA8oaL91hbrWu0fAGNxSy6oPvwdUKbVMFIPwJEEUgRt5sx3OpA5SbuqGuAQNfZ6URSme9R3vnljpY7uJ555H8RiRk/aUshlXLUX8sfDLiXHvXYAp0NG7QNeEOk9mUCNRas14bwjP6ADdr70ZNyiHQ1DpGCIZPbZmYPaY5GZZbC55Ym85HKd5++pRHBUUo/LUMGkNC2bSdg7RiPVwzKkwGYoLDBolKNG6Gh9uq2mZKFoD/lmwrAmsmvL2U2Hl4czW8ikwEez63lxQOupGUg+GLY3i0dWVmz8y+zzbRPoFdq1i5dLw39AEiMHtaDGoPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPN4ALPiTWSufXn5F6wYB5Xfg3inYUngLWZ5K1cfa8Q=;
 b=V5L/Ip2Alk/ZGpQlEwfcuwLgmgIr1eFseP2kgzVkYajYJFiPU/rkBmghXXqSkrCMDxzHGDV3z/s558ltwSlkBMyazG5UbHuZrEJNgNV5fWPguczAW3iC+zzhLybx2P8uuneKVSZMHY01JHjfEG8GXpLq2xnZm3CGdMsdbDjAKq0=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 23:23:33 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 23:23:33 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v9 15/17] vhost: allow userspace to create workers
Date: Mon, 26 Jun 2023 18:23:05 -0500
Message-Id: <20230626232307.97930-16-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626232307.97930-1-michael.christie@oracle.com>
References: <20230626232307.97930-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::28) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 68703491-4c66-4d92-be79-08db769c5c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJZX6GGHCXYMYAhN2F1Pm60nBojemwaPKmoYoHNPKcvtVZEOCzpiavFnoLX/y+ATEDZS4zJw6JIV8Ra3SfAyInUaHahT7XCodqyS6yBzhXBs/pqUy44CInYD1F6hJLebLZEGgAt6MDc7SBmSRKlVFHi6z6rjlYOz4T1SpZxDMQ8duiWSAvljOH5v5UnEjCscJuSsk2FuwhHFCu1WLbfzilkkF86oPU3H+oQsUgxA+1IfySpvebVXEOD1rO3bLmrGIypFsp9gjGYtwpt3PvV87mlxtzv8IRsWa1fX8ww5d6bHEtiCLLnykT7+Rgtj6DJ5PQr6wxVTOSb7sSrC/lEU7fBCg6GEpIfzhL8Tdkb7hLmu9FM/S7YBeSPQMnt9gessYKKX5MZab32je8YUrTKdc0zzh59JV/l+n78UZgNt/IjyfFxEJN+taxdPdRjVT2VeZe7qiFquwfgegT3KXv6LyYD+xl+2VKbqwAWVUXHXsQbyp1qsT4cPtBUgxZ9mL9RMPtf/1oxj52XpuC4yHw4juyQXhyPzOmLrGTDmsUNnuYdmrmL4mxh/klkaoAKlRO6arBFA8cbxFTMKf4dKerYx3riLAj6A3opGg3Npq4PrFPE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(2616005)(107886003)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pLSY/ndZwa8HHbtkGNzx+IzeJlhRo+K3e6WVfpTST+loaRq0/MT2yq9wC8tu?=
 =?us-ascii?Q?yzPPrkBw5KqKaGspXnEw3FhHx2KJmI+vG7rWLMjSTqZ7dYJowCMsGdLBUYi8?=
 =?us-ascii?Q?CdsqYD9VXcOrwc/MIR+uyWgocU6Satx1okMTocneqV2WKG0JGRe/6c2tZukR?=
 =?us-ascii?Q?6wq0hjTfAtIZO3XC05DGASDI/Nwgh0kWOI4TXFgJO8mqWTtZ4Ghwrf5+jABS?=
 =?us-ascii?Q?iJifDfSDc440GzKqPRmTAPu7Z6WKpYhphL2m+8iNXoofoN6e20GVO+e0Mhv0?=
 =?us-ascii?Q?GJqS6oHCDEr81jGrg1D3uybyMk4u8lH+CJaRWCKg/pdjr7/qrPFs+xnfCZwT?=
 =?us-ascii?Q?xdzW1mEtZnMXnpQdpbVJIj5wCv8zrQWk+ZtfudXWhj0bSB0hKj1UC1juEJ/A?=
 =?us-ascii?Q?Nhx/NaRU4FaVOCMcBgOjur5RKDak4ijW2Mc3Kqp02ydq3C88iEAUbrfetjPL?=
 =?us-ascii?Q?4FYi4SjFrh15dBTvt7dqljSeKz2s6YTwj/uSEkgp1J9R2YzEIKBP9l15DMf5?=
 =?us-ascii?Q?5O+VaNbP5EqsgAiArAcwOukIzU+TbnwdM60/OArojPOvX2oD2oyYW9d8lG3P?=
 =?us-ascii?Q?8LVT/MWTA/akZM7wD8nB0uChSSaR5bxVSh1Rw8hXJ8L41ww9QRah6Ie0hrfC?=
 =?us-ascii?Q?vhKEYg3lZTE4+pgjRetJKzFkgYU1zSFyR040acCGX+JHyzs80yzHrbOHa2BD?=
 =?us-ascii?Q?J7WO8iEuA+57Mkz2keTVEwI79SZyCQCQd3a4RnlA8VgQ4ZEE8UTRjH+w0sRe?=
 =?us-ascii?Q?lHZy37FSqoFA9/r7DfJ9zOx3wi5twIIuOOyUExJqJYrptF8a/fglSBNCZleQ?=
 =?us-ascii?Q?gXW4UWMACkhSMWuU5UFeWIZVxH0sXG2CoCDeIviUXucWQG4wzBzkGPs6pAge?=
 =?us-ascii?Q?e7AZQxNL/1HPA/R+nJgSvwdzZmPyqsvl+ASBnOizGkflUfUrogWbCmljvwg2?=
 =?us-ascii?Q?gKYY1U6zNxXhBvlMhtYhYmGFAD2MB0Dr+/G1X0sn0YS5UBJtQ7IhkJ94N4w6?=
 =?us-ascii?Q?K6HbsCEuQQi+ggJo60xP28ZL+QH9kMDffUr2QCbgKBRnIDv/OwQq0zmKVhHj?=
 =?us-ascii?Q?5z7xOJXBSkkrusObO/h7Rz+6D0W9AVPVvB9DPH2BAXw5umIJtHZBSqOa3Pws?=
 =?us-ascii?Q?MGgIULZeX8sgD5U0O/Av1r2hv3CnwT4bIBn+eTq16EQpguKqZyMIXGJkukgV?=
 =?us-ascii?Q?+YvquLBdhT2LPADUlSU7VWR2IXTfECwrauaL0wg/fvHk4rzVREJMJa0MADtc?=
 =?us-ascii?Q?+UBoLZJERVQ520rN961E1IuKQl4wzBMdxtt+FoRD8yjDUnwkbJbg0AVEAjEt?=
 =?us-ascii?Q?UEnqnrQO/7AkJkluHl85ZS7R6K4DFA/NIc1tX/bdq8jtRW2IlqDMu+X1Z6L1?=
 =?us-ascii?Q?wT3/B6MEXZ+670xmOblcUdNfzEl3II2cFQmXi0ZhgOncvmLKLI2yVj7QIVg6?=
 =?us-ascii?Q?6ABX3NQPfGrrNqNxXerm+Yrt9Zvvm+a/+P8AxEjKTIIOfCBOjAwtIudMEji9?=
 =?us-ascii?Q?oBJjh/iR6uRAR9NZJaQYIdSdXpCBvAh8ZDLoEDEH2XjxepWXhS6Q+EVKTqOW?=
 =?us-ascii?Q?DTVuxriEqPPmPkr2qvwe3ZrueG0cycDpwtK/fwFuuzeyWgerXWFCXquGuLJA?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nBoHvxCzMA8jIuRUohGRPGB/9dNkSl4vdBOT50eAMqFeD4Y4barU6SMQU4yR2rDen57dPNGhdVx3Y0yEu/b2BiK8OOkfbyne9d44YHhcs4oMnxgxMgVeHsAckfxtKw/V0VSUD2+/LGJJo9l6Tai6KVIlgNViEQ059c/3cF4CWiauMEis6AxBGz17NIMjJ84iP8hyVaAfPUnZYgnLaTCc4/rblX+mkct2vBnUvBIcgiTCdo36ANLnGHhHVXwiNNpBIGVBymrecvaWcWiYzmXwaey03+JoCTnDtUbPsnX2WN1R9St8nht+rFQLD8IkfLt0yonzLUpyto6jWnFWWjeYT8riDsNPHiuy1TQ2va59vNU/tlxg7oYF1xrKghP2OHIDJMVWLES5RB1iRx1GCuANvq4VeV4nCB8J6jyhvMLzLlUUwksDqV+UhSX3f4QsnxKNuK43zwaCKcXawXWtNR6tT75lBkNIxHAB+3rLMbCDHGUn5Yc278iLCJ16JTe/XbTuJFeUejOzH4778YLeQPlmSTsAZrzXkBJrNPIN3vbsbIBZGPOJNGIogxPJy6nxxvzEtelKCu6FtZp+TpXMZ+4jByOH1uKwii4AloUQPIhC2r4hDQQQ4eMWa3EOFfyBcpy0Sm5kOS65ZwbKp/zp4brjtq7jBzw+qCAGWz3QMVYCeCyXEJL8+XjXLNB+XtpHCqdX/AnowfrppyFFpmt/WIzfGHF9r+AD0hKa13ZTkuRphoBihCwj2HqrCoOFwLRmXL2WOqNrFkh9wWa9KO+VRLvBJCYDvCPhBRJRfN59Uj7tQd/BicziiJavdCCMI7zREI1z
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68703491-4c66-4d92-be79-08db769c5c3a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 23:23:33.8336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVtX3iqQlUtpElvE2rmBJt13J9mx7AU9heaNOiAQHdFL93O4ppso8BwmkLbiAaWUunWTOUwKEEKUyCWip7VoaWArEnB5SimfXIgIeUS0v1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260218
X-Proofpoint-ORIG-GUID: cg37F9kdrT6RbwEOhyIs5WwzTxCIzf9w
X-Proofpoint-GUID: cg37F9kdrT6RbwEOhyIs5WwzTxCIzf9w
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

For vhost-scsi with 3 vqs or more and a workload that tries to use
them in parallel like:

fio --filename=/dev/sdb  --direct=1 --rw=randrw --bs=4k \
--ioengine=libaio --iodepth=128  --numjobs=3

the single vhost worker thread will become a bottlneck and we are stuck
at around 500K IOPs no matter how many jobs, virtqueues, and CPUs are
used.

To better utilize virtqueues and available CPUs, this patch allows
userspace to create workers and bind them to vqs. You can have N workers
per dev and also share N workers with M vqs on that dev.

This patch adds the interface related code and the next patch will hook
vhost-scsi into it. The patches do not try to hook net and vsock into
the interface because:

1. multiple workers don't seem to help vsock. The problem is that with
only 2 virtqueues we never fully use the existing worker when doing
bidirectional tests. This seems to match vhost-scsi where we don't see
the worker as a bottleneck until 3 virtqueues are used.

2. net already has a way to use multiple workers.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c            | 142 ++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h            |   3 +
 include/uapi/linux/vhost.h       |  33 +++++++
 include/uapi/linux/vhost_types.h |  16 ++++
 4 files changed, 193 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index ffbaf7d32e2c..bfba91ecbd0a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -626,6 +626,76 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	return NULL;
 }
 
+/* Caller must have device mutex */
+static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
+				     struct vhost_worker *worker)
+{
+	if (vq->worker)
+		vq->worker->attachment_cnt--;
+	worker->attachment_cnt++;
+	vq->worker = worker;
+}
+
+ /* Caller must have device and virtqueue mutex */
+static int vhost_vq_attach_worker(struct vhost_virtqueue *vq,
+				  struct vhost_vring_worker *info)
+{
+	unsigned long index = info->worker_id;
+	struct vhost_dev *dev = vq->dev;
+	struct vhost_worker *worker;
+
+	if (!dev->use_worker)
+		return -EINVAL;
+
+	/*
+	 * We only allow userspace to set a virtqueue's worker if it's not
+	 * active and polling is not enabled. We also assume drivers
+	 * supporting this will not be internally queueing works directly or
+	 * via calls like vhost_dev_flush at this time.
+	 */
+	if (vhost_vq_get_backend(vq) || vq->kick)
+		return -EBUSY;
+
+	worker = xa_find(&dev->worker_xa, &index, UINT_MAX, XA_PRESENT);
+	if (!worker || worker->id != info->worker_id)
+		return -ENODEV;
+
+	__vhost_vq_attach_worker(vq, worker);
+	return 0;
+}
+
+/* Caller must have device mutex */
+static int vhost_new_worker(struct vhost_dev *dev,
+			    struct vhost_worker_state *info)
+{
+	struct vhost_worker *worker;
+
+	worker = vhost_worker_create(dev);
+	if (!worker)
+		return -ENOMEM;
+
+	info->worker_id = worker->id;
+	return 0;
+}
+
+/* Caller must have device mutex */
+static int vhost_free_worker(struct vhost_dev *dev,
+			     struct vhost_worker_state *info)
+{
+	unsigned long index = info->worker_id;
+	struct vhost_worker *worker;
+
+	worker = xa_find(&dev->worker_xa, &index, UINT_MAX, XA_PRESENT);
+	if (!worker || worker->id != info->worker_id)
+		return -ENODEV;
+
+	if (worker->attachment_cnt)
+		return -EBUSY;
+
+	vhost_worker_destroy(dev, worker);
+	return 0;
+}
+
 static int vhost_get_vq_from_user(struct vhost_dev *dev, void __user *argp,
 				  struct vhost_virtqueue **vq, u32 *id)
 {
@@ -647,6 +717,76 @@ static int vhost_get_vq_from_user(struct vhost_dev *dev, void __user *argp,
 	return 0;
 }
 
+/* Caller must have device mutex */
+long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
+			void __user *argp)
+{
+	struct vhost_vring_worker ring_worker;
+	struct vhost_worker_state state;
+	struct vhost_virtqueue *vq;
+	long ret;
+	u32 idx;
+
+	if (!dev->use_worker)
+		return -EINVAL;
+
+	if (!vhost_dev_has_owner(dev))
+		return -EINVAL;
+
+	ret = vhost_dev_check_owner(dev);
+	if (ret)
+		return ret;
+
+	switch (ioctl) {
+	/* dev worker ioctls */
+	case VHOST_NEW_WORKER:
+		ret = vhost_new_worker(dev, &state);
+		if (!ret && copy_to_user(argp, &state, sizeof(state)))
+			ret = -EFAULT;
+		return ret;
+	case VHOST_FREE_WORKER:
+		if (copy_from_user(&state, argp, sizeof(state)))
+			return -EFAULT;
+		return vhost_free_worker(dev, &state);
+	/* vring worker ioctls */
+	case VHOST_ATTACH_VRING_WORKER:
+	case VHOST_GET_VRING_WORKER:
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	ret = vhost_get_vq_from_user(dev, argp, &vq, &idx);
+	if (ret)
+		return ret;
+
+	mutex_lock(&vq->mutex);
+	switch (ioctl) {
+	case VHOST_ATTACH_VRING_WORKER:
+		if (copy_from_user(&ring_worker, argp, sizeof(ring_worker))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = vhost_vq_attach_worker(vq, &ring_worker);
+		break;
+	case VHOST_GET_VRING_WORKER:
+		ring_worker.index = idx;
+		ring_worker.worker_id = vq->worker->id;
+
+		if (copy_to_user(argp, &ring_worker, sizeof(ring_worker)))
+			ret = -EFAULT;
+		break;
+	default:
+		ret = -ENOIOCTLCMD;
+		break;
+	}
+
+	mutex_unlock(&vq->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vhost_worker_ioctl);
+
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
@@ -684,7 +824,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 		smp_wmb();
 
 		for (i = 0; i < dev->nvqs; i++)
-			dev->vqs[i]->worker = worker;
+			__vhost_vq_attach_worker(dev->vqs[i], worker);
 	}
 
 	return 0;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 44c3017766b2..039be5d56867 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -31,6 +31,7 @@ struct vhost_worker {
 	struct llist_head	work_list;
 	u64			kcov_handle;
 	u32			id;
+	int			attachment_cnt;
 };
 
 /* Poll a file (eventfd or socket) */
@@ -190,6 +191,8 @@ void vhost_dev_cleanup(struct vhost_dev *);
 void vhost_dev_stop(struct vhost_dev *);
 long vhost_dev_ioctl(struct vhost_dev *, unsigned int ioctl, void __user *argp);
 long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp);
+long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
+			void __user *argp);
 bool vhost_vq_access_ok(struct vhost_virtqueue *vq);
 bool vhost_log_access_ok(struct vhost_dev *);
 void vhost_clear_msg(struct vhost_dev *dev);
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 92e1b700b51c..96dc146c2d15 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -45,6 +45,25 @@
 #define VHOST_SET_LOG_BASE _IOW(VHOST_VIRTIO, 0x04, __u64)
 /* Specify an eventfd file descriptor to signal on log write. */
 #define VHOST_SET_LOG_FD _IOW(VHOST_VIRTIO, 0x07, int)
+/* By default, a device gets one vhost_worker that its virtqueues share. This
+ * command allows the owner of the device to create an additional vhost_worker
+ * for the device. It can later be bound to 1 or more of its virtqueues using
+ * the VHOST_ATTACH_VRING_WORKER command.
+ *
+ * This must be called after VHOST_SET_OWNER and the caller must be the owner
+ * of the device. The new thread will inherit caller's cgroups and namespaces,
+ * and will share the caller's memory space. The new thread will also be
+ * counted against the caller's RLIMIT_NPROC value.
+ *
+ * The worker's ID used in other commands will be returned in
+ * vhost_worker_state.
+ */
+#define VHOST_NEW_WORKER _IOR(VHOST_VIRTIO, 0x8, struct vhost_worker_state)
+/* Free a worker created with VHOST_NEW_WORKER if it's not attached to any
+ * virtqueue. If userspace is not able to call this for workers its created,
+ * the kernel will free all the device's workers when the device is closed.
+ */
+#define VHOST_FREE_WORKER _IOW(VHOST_VIRTIO, 0x9, struct vhost_worker_state)
 
 /* Ring setup. */
 /* Set number of descriptors in ring. This parameter can not
@@ -70,6 +89,20 @@
 #define VHOST_VRING_BIG_ENDIAN 1
 #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
 #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
+/* Attach a vhost_worker created with VHOST_NEW_WORKER to one of the device's
+ * virtqueues. This must be done before VHOST_SET_VRING_KICK and the driver
+ * specific ioctl to activate the virtqueue (VHOST_SCSI_SET_ENDPOINT,
+ * VHOST_NET_SET_BACKEND, VHOST_VSOCK_SET_RUNNING) has been run.
+ *
+ * This will replace the virtqueue's existing worker. If the replaced worker
+ * is no longer attached to any virtqueues, it can be freed with
+ * VHOST_FREE_WORKER.
+ */
+#define VHOST_ATTACH_VRING_WORKER _IOW(VHOST_VIRTIO, 0x15,		\
+				       struct vhost_vring_worker)
+/* Return the vring worker's ID */
+#define VHOST_GET_VRING_WORKER _IOWR(VHOST_VIRTIO, 0x16,		\
+				     struct vhost_vring_worker)
 
 /* The following ioctls use eventfd file descriptors to signal and poll
  * for events. */
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index 4889e6d70b15..2d827d22cd99 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -47,6 +47,22 @@ struct vhost_vring_addr {
 	__u64 log_guest_addr;
 };
 
+struct vhost_worker_state {
+	/*
+	 * For VHOST_NEW_WORKER the kernel will return the new vhost_worker id.
+	 * For VHOST_FREE_WORKER this must be set to the id of the vhost_worker
+	 * to free.
+	 */
+	unsigned int worker_id;
+};
+
+struct vhost_vring_worker {
+	/* vring index */
+	unsigned int index;
+	/* The id of the vhost_worker returned from VHOST_NEW_WORKER */
+	unsigned int worker_id;
+};
+
 /* no alignment requirement */
 struct vhost_iotlb_msg {
 	__u64 iova;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
