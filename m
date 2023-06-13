Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485A4C88CBB
	for <virtualization@archiver.kernel.org>; Tue, 13 Jun 2023 01:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DCA524095D;
	Tue, 13 Jun 2023 01:33:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DCA524095D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=zUxD1rvI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=VOLQbddd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id olddPYfXet1q; Tue, 13 Jun 2023 01:33:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 34F4B405F5;
	Tue, 13 Jun 2023 01:33:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 34F4B405F5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7182CC0096;
	Tue, 13 Jun 2023 01:33:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19A0BC0092
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E45A6402D5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E45A6402D5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=zUxD1rvI; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=VOLQbddd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3qOOQSY2it46
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 10199402D1
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 10199402D1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:21 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CKNjmn016679; Tue, 13 Jun 2023 01:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=NlyzNBzbRcOF/ScJ48Fm0hL5HZsmlCtcjfcLpOzM8ug=;
 b=zUxD1rvIZInEhbAhCWb+nH/7ZB533NjWxNPOzo1qY+yA8revrblRt8VpqmbwoMg+o+cD
 ZkMTjuWjIx2n+jSPiHDfSTbh3npDj1XNu4nxnMagCl99D3WtzfdlshbZ6dOP2sVcaQLR
 H7P74YKWy/KcEDWSFydmKcCMz3GmTzvFx1aBZdyG20LD3Ve782TjMgYuZvRiH55Jm0J2
 e3ArpMkaANdzVpE8i1YVxhsBlbIhfx3hKDFkG6mXXUOwI/xLHmVXQ5ky3G/sbg2avt9W
 FVucOdSMUmt4CIG/ju3kqZtIy7WnTrofDetO42lTd3IbFO3+tCeTBLqtIciOZHiMaAe2 MQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fy3c5f4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:20 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35D1CJRL021613; Tue, 13 Jun 2023 01:33:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm3hg44-10
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHnFMbPb3xMObESs+s8NT/T+oGXE8rwzLnMa25Ki4OJWK6WqGbqGI3ZTKJDTo3u/iCcuS0MTCIGJpmDF23W84csWqmOGB69b2SkhaPN/3jAdlFCzxGlxwjkw7YS3rC9BEGSz+9x+euB31+Vro8ZuSdYQai8/cPKw1BuQ5XGvxvlHyCHQpYr4IR6uhuCK3t9W+91OyRW5GyHTAStkORud7VaXlkipwkjiPwisp0th7J1kxP87rF231B3o+zhCFxykXS4cVOv/rQuU7fxmDmaqGkYIpqtuzq/kipHKM5BlT7Ku++o0z1r5fO67cY/WpfRDnekJOrx0VwYnrCsLNanIGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlyzNBzbRcOF/ScJ48Fm0hL5HZsmlCtcjfcLpOzM8ug=;
 b=Z2DjYdx8vsq9LEwASSkShYSk57xoTLm/dG0SR0XaT7Cs4nC+yr4eBoVyg4VyMEPFLnR1BuACFBxEe+B2KpEqeuS4Y1NG7KwnnI8r3hLnQ9aI1IWBojOfcEOgVsFDr61Sqkj7nFWKGiQ5wNXs0QYULI+rafF1hpXV376bOVGOQlB5iI6yRIFy3krBqFNwcB4o0xzkdbke3iL7BAvBUq2URwOCszAbinpKJVgvbAYkOLmZ2McPKs/zx1aWl8alqsyF5K2YZ19pM1RWYn5tmEvDdui9fK2CJ/BXeqdImBeGiejSq7NsJHc+5bBvmisbInIFwFzXANDVqVB7+XSyKxr2Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlyzNBzbRcOF/ScJ48Fm0hL5HZsmlCtcjfcLpOzM8ug=;
 b=VOLQbdddyRXA2S0MB+9sKvPd3M7FmImz6EqODo3N9mxGyFrhAMvn+4kBpT8BxMqaxSifXk/803mZLK6qBDocFp18tz+Zr6Qgne9Dwcagc+spvuoMo676FJeFc26bMCcqWdxhNn7xqKwTjHpXLOp/tykNBIQEDPZmcG93PujDnwc=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 01:33:13 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 01:33:13 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v8 13/17] vhost: add helper to parse userspace vring state/file
Date: Mon, 12 Jun 2023 20:32:44 -0500
Message-Id: <20230613013248.12196-14-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613013248.12196-1-michael.christie@oracle.com>
References: <20230613013248.12196-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::28) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: dad8572d-ccc6-4381-6224-08db6bae275e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECJQHldY4SfhSVgmtmwjafgBZ2xDZaF/lJTlHNFZpp4chu6N9Zkf2rQ6y3LeQhFq7w+6FuJTp+dqO8n+HK/GsUlK7jPBsR8vECDMJGTwEEJoE6tQ+Z0Gbj3jQmbzOrKp5OZV2E7VUpe96iiGJd5Cu4lVlf4J9BSpY+HPj4NQ2A3i+IgnUvSU9ppsDtCLJweOrx0TkO6QbHdaMxM6Hbo3xD9IvkBa1OZR8eaL/bgG8o3mkWx2tJOuDENuF4RokB12fILyLEFNva/fVcWNYQhFCaq6v3NNNp240nJORiSn+WmksMT1X9FfaMZhu5gA3rHlCXxWsL7O6Pf35MTAUArLT0B5quK1xpw7653Is3qB3FP7/AMi/imdVd8/5NprV5fwdAzOZlApQV6ZqYROgmycO3QVafvjvUVC6gDfSWlTL+oGTXEb3L2UdhMZmnpZ3nZF38NHX81Mde1M3ymUhOnwTyUIdQpSA5IG7IIX4R2x+qMFETjzvFjR/m52+K5daGU+NT5Sh8vdldZ8dqXVvGnVkO3ebgkBiH49gD41yxoO8HztKzN8U/Jy9LkpC82QPCV+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(36756003)(86362001)(66556008)(4326008)(478600001)(66476007)(66946007)(6666004)(316002)(107886003)(6486002)(8936002)(5660300002)(2906002)(8676002)(41300700001)(38100700002)(2616005)(6512007)(6506007)(1076003)(26005)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TQ18jJjmtkAyc0xJ3ysuz4HiJxjJuyz/OdBUXxdLL+UuBYIU/cCkDOBfwOY/?=
 =?us-ascii?Q?cwFe4zBzMcdb97eD8LTn6BzIA1llrLsGwwz6glXbsLaTxfOxlHu7KSkxvTVX?=
 =?us-ascii?Q?+FfNlaKU56MlwxvtGiTcFxoWBhIq48eJh2Wg3Fi6W3lXV7+gU2SxU0ekny8s?=
 =?us-ascii?Q?+mNZaXXpmCtWqgv0JuK8jBkQo1BxRez6rKr398pgx77Al2vGkl1tH2xMnsj3?=
 =?us-ascii?Q?O3lfE/L5SwYtExBWKDGL+tB9aL8sWvqHD35vK+aSJ79uJoOsuxGMHYDZwdL4?=
 =?us-ascii?Q?5h+PX26JsXqYb/mPqWIn4OcoGRK2AhMdtLSMKm1TtcylACI4W3vVGITetEWR?=
 =?us-ascii?Q?VTSv84QOAZwXWS+i+L4dexSCPkuGJ4s0UCajvWy15zR2MMsdwEsIisB39mPs?=
 =?us-ascii?Q?lx59whvv7i+jB+e0ozEHNU2w8wFlfCh1MLXq2NASiEh56s/kWhF7H6fjpgHQ?=
 =?us-ascii?Q?XjlBbYcnY+Nq+PzeI4KBPbN5XO0l6BPgeQFcbHMwfJhgq+N3lM+IcoI9r45I?=
 =?us-ascii?Q?zC2Erfw2nNCsR4OhmABQYAlD+p7H+MhYv9glKm8EbzelV9S5uuu/kJJi8UnF?=
 =?us-ascii?Q?nSwN09B9XBsUwmKDt3YLEDpD6CXpWph44m3ReXYl5NVrWgy2avkejlCg9Y7o?=
 =?us-ascii?Q?50AxXYx38TCcYa4OP+AVFIbVzXoVJYbGsQtQ1F76WnxRrZhVc0oYdkTdPi6q?=
 =?us-ascii?Q?6mVZE5MD+zPXMu4MlcCAokP5Qre8aQvGkXbwJCkC4F7kOOCg7IOXhcAgMXR+?=
 =?us-ascii?Q?Fv5NsK/BEF5uu/5SykS2IREuyCSz3GjcJIrboamRnLBS8MCLkGKpOd7LSDUo?=
 =?us-ascii?Q?bG2dmm7bsFs4U+gqSchiDyAKGmF82XsGdZi/t9/6MJ2CkgJvOUD34N8jqpq+?=
 =?us-ascii?Q?zVSNfIzhlEf93lnfItihQdZTAixPIJHjw/phsuNUSz0vUVDwLSfskk9zzrz7?=
 =?us-ascii?Q?rUij1T5X7JAWvbNdIPXK/JcbdqgfEL+Fi15rSOARRdbfahV9SaC/EKx9JKSc?=
 =?us-ascii?Q?S50Ad//HwPdAbLNaOBJDPc5+EI5kQfIob8cjMIX4Yj0iTUbzlLp7pPShMylN?=
 =?us-ascii?Q?M1XtB6Kv6wxoWG2lqR3gZyIoeePQwwQQuViWbfBJtJKzczykIZ16Ol95pp5n?=
 =?us-ascii?Q?bX1V6JWA1b/u3LxEWFmx3XzdrU2wLkh8eA4mbmS5lPvX4TTfDHwBVagSz+Op?=
 =?us-ascii?Q?quIYqgLJ7Tkt/YwTlbBeg4Y0dy1GkfISr3Uezj0x+N/4rvZRYgp1q/PEgVsL?=
 =?us-ascii?Q?robRsZbd7wREXeNaghWigg3D+GYGAqG6kJi26W1OoxqkGq9WcerxpYErBHzG?=
 =?us-ascii?Q?HUl0Nvn6KVF6/qd6qvmBPBWtiaqkwDqADD3cqWp0IghxQWi35JUPGWVHi35Z?=
 =?us-ascii?Q?yx29ILmeUU6tRSYOm+1u/WvqRKjNkTjNO/YMw88n0R8LjiIU6hYxAFFGRSn2?=
 =?us-ascii?Q?FSvkAe2TOA5RCclgoRSAMJm59h6CTxBR1Ag+R46arX7dMoBW0NBrwrE7ic0y?=
 =?us-ascii?Q?n9oiSNxP2pFTKxGMVb50E/eaTh//UU3cX9VwBrbt0MK3ZoYdayIsCSZIEbpE?=
 =?us-ascii?Q?KVwT1vo4TIs4QS+W2ZT3Ud/3NX4aIOekD6rWh20J8qHPyCCEYPSnLFLKI6nQ?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6d3/Zkvbayi3nVKLU6uz3vZbp/0uE5q9+Xb8lvBMzJexizgboz1XU0Br33yYUwfr/3DoadqWzimVnfRPqDxFD6DvNema864QhtCFKtYE9Z9/wyZ9nixT8CA7cadOCSHkkTzZVfKLdukxXhQW5ILoEGmadQkyjnEWVLcukX4dDprlhA7+nxD+c5dUNC9dBo3cbQDYfhv/RMK3rADJFsu/bdVvwkjIhNi8xBKfRKFtUWJRPPuSwmB9mcLFFfjuSSS+KAbbfbLR+ofSPbh4qv/LyNQsZDINX/j4a6uxafpX2zQ7tJ7YeA12iX33lofkq3q3hknq6uneUrkBBqMme7t7rl/7QHqVYRipgzVYaJRG87XVpfgJZX6GnKwy/KBsz5XwidYc/ADbJXRDv+eQ6rcKgLysDdcdP2D5M3GxKIjjR9NG+3gGNGKgUYRFIeJO4OHpMTW7UyYc2v7nwJMdeMGjHODDAp6poTdPHjF1muO0dZ8x5FdDUrlow+ltWqEJJn1IICJNfONZ5Way4T0pjbHZBlVcBdpcNkNgEg1emWVGCZp1LV/PBvVY0ozNLct7sdXNj4hHLbjZ1FskhaknjbD6wV2KmfVFbbovfnNsl1WqROJMA0mRCDFNx1jDWMMX4Ab6UclWG51zzTh74z7VYEL6amGtdVMhL0J7S/bRx2Dq0XI4U+Z9QpD00wM2YhQ6d7nMXtt7CxIe2lJYFv627vY3bD8dHw1cj4KkSZTL1KznzM9+jsJ3PoQjZxCo7oalRTPtej8eUq5nNNtAFXhNYskBMdjPIm3GN59OM2a1PNsVvv1Ca2t7xW2aQ2wB3rTyjU/g
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad8572d-ccc6-4381-6224-08db6bae275e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:33:13.3096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIYUdyUg1ekQN6Mhm1GuRG9ry+8j0fsE7YopjMso+/l9P8ikIGmD/Apvv9P9/AGD7BGQ/9DWrYojnCkz5G4dI9B9xtIw94vGFJNG9KtR6wA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130012
X-Proofpoint-GUID: OMk3AYJ9od1zkPhXp70ch_Lk-bstYEw9
X-Proofpoint-ORIG-GUID: OMk3AYJ9od1zkPhXp70ch_Lk-bstYEw9
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

The next patches add new vhost worker ioctls which will need to get a
vhost_virtqueue from a userspace struct which specifies the vq's index.
This moves the vhost_vring_ioctl code to do this to a helper so it can
be shared.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 176d5fcd4b58..0db093dfaa22 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -599,6 +599,27 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	return NULL;
 }
 
+static int vhost_get_vq_from_user(struct vhost_dev *dev, void __user *argp,
+				  struct vhost_virtqueue **vq, u32 *id)
+{
+	u32 __user *idxp = argp;
+	u32 idx;
+	long r;
+
+	r = get_user(idx, idxp);
+	if (r < 0)
+		return r;
+
+	if (idx >= dev->nvqs)
+		return -ENOBUFS;
+
+	idx = array_index_nospec(idx, dev->nvqs);
+
+	*vq = dev->vqs[idx];
+	*id = idx;
+	return 0;
+}
+
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
@@ -1618,21 +1639,15 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 	struct file *eventfp, *filep = NULL;
 	bool pollstart = false, pollstop = false;
 	struct eventfd_ctx *ctx = NULL;
-	u32 __user *idxp = argp;
 	struct vhost_virtqueue *vq;
 	struct vhost_vring_state s;
 	struct vhost_vring_file f;
 	u32 idx;
 	long r;
 
-	r = get_user(idx, idxp);
+	r = vhost_get_vq_from_user(d, argp, &vq, &idx);
 	if (r < 0)
 		return r;
-	if (idx >= d->nvqs)
-		return -ENOBUFS;
-
-	idx = array_index_nospec(idx, d->nvqs);
-	vq = d->vqs[idx];
 
 	if (ioctl == VHOST_SET_VRING_NUM ||
 	    ioctl == VHOST_SET_VRING_ADDR) {
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
