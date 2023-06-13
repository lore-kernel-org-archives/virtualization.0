Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CE2C7EE43
	for <virtualization@archiver.kernel.org>; Tue, 13 Jun 2023 01:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19C878134E;
	Tue, 13 Jun 2023 01:33:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 19C878134E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=Oa8gzZ41;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=D9fzf/6K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gNFFNTib5edp; Tue, 13 Jun 2023 01:33:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8B7E5811FF;
	Tue, 13 Jun 2023 01:33:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B7E5811FF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 747F3C007A;
	Tue, 13 Jun 2023 01:33:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DBB5C0029
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 54D6940987
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 54D6940987
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=Oa8gzZ41; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=D9fzf/6K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PPG7279kTPi8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 37F604094C
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37F604094C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:35 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CKOWTe004094; Tue, 13 Jun 2023 01:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=8gIDnTdx7A4frqHWUXyujmLViqGQdlH3MmccA9wGvws=;
 b=Oa8gzZ41B5jgyXyh1j5zzmVks7gteT+7P6AXO7TwxqJOuLCV86tCGr+JODZuHm8uR1g/
 eg4UX6z+RkhXQ7LtiDH5KxjDiF5wxhfoeX+ZvwIekyT7mtCfscA0dcU4nWfSrClu8keo
 v3Vb4HmokeOhtM4Lp9TN7HhWlujUW2ZsTNhYfHJvGqDP+cjmCDSXNXQPdUAxGo+Rbsjf
 6Pl0YSlnA3lytmRXcmcC1VFrOeLGLpa5WnSNDZrlLEoKibv2rSodKVuyLcWTLpABmhdQ
 LQstVAalJR4bsRUyy56GOSNWD/GTkmMIjvuy9NEbkA9nosJTQVLoQDmZvfJ+23HhlyTV qA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs1v823-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:34 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35D10fxn008950; Tue, 13 Jun 2023 01:33:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm3sqc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lS7e2tWO+booZiq0WpG6RVvqrdB61HvrOqf9psAYibxNlEEGl3rgTh5FVugiLB6dv/TdwpUaR2wnJlyGP01A5YrtrdkI/dH7MeCaC/doNnGtOpHbPIx08NqR34FV4QdsmbUOL3IW+TiYc8dBio3K8Bqm19Pr/Zoe1vwltKi+/ZiZO+nVIg+zaGK0tcO8QCUq07V0Pv6fR2ZX616XhlJY6+uRa5NqfoA6COF4Qn8tef7gALZMy1wFyDjhzJ/I1l2WikCA9y9LtRmSQEF2c0rzdzHL6H5zkNlgdxhd8uyU0w/picb7tMv5lFkV/b0M2dY047hCniq8XMeXScWjLZn7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gIDnTdx7A4frqHWUXyujmLViqGQdlH3MmccA9wGvws=;
 b=cpUfoL0LWUvavL7Zo0/5YCQa+RA/hjI1lVdG9xMzZkyz0i6qlNWXkd8rN7haaNiRdG1h4Vv305ZI+71audIjoKpGNQ+tMnHRHAFOBDjURdw5jcdEm4CygdJtyP6Vf5WhG+C+AWKBBOkwM4dfqqpXWJAhhOxWD62HM8CLA7iQ50h83nyNHgyICTfDdydkXhBgtnqUWuHzDLlwQEglLotPmnkPxz6T5/ntbCN3eoRnquikFe5v8aIWfOPyWVz+WvQnzDEb/uK6NQkkGfGPifl7Y7IBwrympQISyDg7hfWyrYPVzHfUkWmSrXVMGkufBcxjxy5dvrWYlfsZ+ss1ZQ05Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gIDnTdx7A4frqHWUXyujmLViqGQdlH3MmccA9wGvws=;
 b=D9fzf/6KGD5afl1pbVyAL8ECBw56i6ZkXWLk0zCGsWrAmeOxy34GpKd6NDMOWzB7uwizKu+vM+1j+R4nPAtdXmvXuVNfuO8OMpa+sQtoePvJ1uUopU82v1Gf1XNDESmV/57dm85Wv889LscdhZdhtTpgVS3Nw/tVAcK2CN4KfmY=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 01:32:55 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 01:32:55 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v8 02/17] vhost: dynamically allocate vhost_worker
Date: Mon, 12 Jun 2023 20:32:33 -0500
Message-Id: <20230613013248.12196-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613013248.12196-1-michael.christie@oracle.com>
References: <20230613013248.12196-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR06CA0081.namprd06.prod.outlook.com
 (2603:10b6:5:336::14) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec7e526-8655-44b6-68d7-08db6bae1c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VirMtJVPVOC9uLRHTEwPi4SdcHjAyqA0mlF5150pcoJ3gEq76yZTj431piJs/EQZkJubcN5+UkzpnNloCtZFZLseS4irknI5fyqyhZ1y0yJBOm4EyYYZQrAVtb3qjw1mNNdRoqtxBWZhtBhHdVyZqfqv8CMWaJ7/+7szcilQRPGRqI87rAOecmSy3m6ecj/ybr1cWqVzRNmoxzDeLDAW+KnUXUpk41FG9erUsNegQiYVs+E+S6hfkXw0n6ujqzsYGz/XMwXDtsZPKt9Oaeg1JLr5jPEaaR+yA4lluvZkda/USJSZzCoQOpRYIHmwSBj2KeFmoCroOkjvBdPMkTV6HTyn+I1nk7HSoiIME3vtbeFCBt80P3YBIJcSRj3LB3kPdF5pwbaCRfYRqovSFag4NWFv170bYx/q9h8gD28XdrNBtlcjbumQpNzKGktUED7niLqW1kr3BhJtGDn7spS/sk6TfcpHsYwxOl3QbGMd5Rk3kmC5Ya2IS1NxoFTj/JO5UmGIOBPQ/5Gm2p3pWlA82WTRiPAi07c4lfMOoYUzzSJy818nmNdS5s7ejonBW9Ho
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(36756003)(86362001)(66556008)(4326008)(478600001)(66476007)(66946007)(6666004)(316002)(107886003)(6486002)(8936002)(5660300002)(2906002)(8676002)(41300700001)(38100700002)(2616005)(6512007)(6506007)(1076003)(26005)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m0+1lXQPI+5250Z76CCWnwfHB66KJZ+ZeBiEnLtyIc8nokX3/4ps99rBrE6B?=
 =?us-ascii?Q?RFR06Isl9YhS9gmWuJi6PqYiMX1qT9ZLMmotKFAbwdeuQfsC/VazQvZzgTRh?=
 =?us-ascii?Q?OTOiHVkYN2qhG4zPjpB8WoeZMP++eN9HQ+T/XwkZ+GnioQ2FRRGRVZNWwoYu?=
 =?us-ascii?Q?fQQYF8bkD5kWWDH1E+qKyHB8Rt/Ei1D3El3KMqCI/6XXMNgsqLsGbM4MYQXz?=
 =?us-ascii?Q?weCyHb4Bsm6oAdGmh1Gi3Ic+8Ru4GYNCAaOqivs7WOVV1/ba3yPpKmiedq7w?=
 =?us-ascii?Q?xHrfuAT1sAaNSEzScXbfWri6rjDsMu6m53qnxa7MawCRFpJ8v8zkd5t2mEC0?=
 =?us-ascii?Q?ADtRgcaTzfGejw50V9CGu3RvWoyIuiK6k4ee1e22S2jFhyoQLAWU4oLpA2Wa?=
 =?us-ascii?Q?19+nnLF1ho+NzBCte8LimwA/NhhlYue4lSYwFJDXMO6Ca4OEkWHFcZaO1iim?=
 =?us-ascii?Q?el6V7ukztmLeuimoHzwp6Xau0wI+J1WCpy99obOrBTkBeYkPSICfp42DAafx?=
 =?us-ascii?Q?M9/iDcQtpGeS0YI2LCypWGUBKlYyAVtuY9Um1NqoWZvhYwndHp9BvpUXzHcV?=
 =?us-ascii?Q?vQKEPAVfUf2k98HkqcTsOkhANWYY3gIrYVz4knEPG46CpwsLYHfhoglcP/av?=
 =?us-ascii?Q?Gw8xIC6TsNn89G4H3uJgwSapc9NnQFqgjBPDoJHIkwuX+x29rRmW6x/R9ywq?=
 =?us-ascii?Q?tIAkpmZybEYNJJDFbbjCb9AJTMAihtxsyWn1mtlpIiYSpHBIT2PdKQZgDlc2?=
 =?us-ascii?Q?/4KcJG0hJUKsnPaxiNHW8ZL7g5cZ6shOdDQ1DgdcuMgtfy2LQ30Zsx1pp9sH?=
 =?us-ascii?Q?cTpBRJ6PJRIOP+Fvs94zFSmJc84M15/AfalsUQ5rQ6fbESYAW89ik6V7STu6?=
 =?us-ascii?Q?tZK7HA6ZFE5EsFqD7p+l3/vr5YORVzwDIu+oEdHnZP/2px1iYqGEA6VvLCUZ?=
 =?us-ascii?Q?CgwhEGKerInIRlUEEaGaI+D9p2qYIoP9uJFqryL1MTKpW6LuKMD5jKCIJWvy?=
 =?us-ascii?Q?4IO8ulLTIeNrG7a9J8YA5+qOl/6DnntMb7h4zsjRJjgvWZ3737SOlZJpCnLb?=
 =?us-ascii?Q?gWYbw1lwB6IbDOzs+mIO9HuOFq0AelGqqIgIvrk235LaNZDYaHjk2CKGK+zM?=
 =?us-ascii?Q?avHjHgVlhke6M9UBpFg+O2jU/baB7v+DJhSO3J3PmGE40ViYNDOFVuUOsTPB?=
 =?us-ascii?Q?B71miYmoSAI7ELsnjtb042IDrjkmi6r5G9RxCHLCmt23H3sZku7AbDWMlxaz?=
 =?us-ascii?Q?166Sarf1Ju2WDLJpe8Dm+cet1o63FTd0+RHQZN8qidnG4iN1wjJGEiVYWHs7?=
 =?us-ascii?Q?cTtFBe0rwoG5GZzuU3ONXdTb5niIBo39l7F8BQzhIXSlInhXn89UvoVrEeJw?=
 =?us-ascii?Q?+ogE4yQZf90MHmOXlBSoUtZh38ofZZ0NY3G2ewh7xoQsf3j0ATCg0yJaf1A5?=
 =?us-ascii?Q?yOwiDnn/hVTsll+a8seE5nLT27s9VmD46Z374KqllrMsFMnDjzHOMsCzaVG3?=
 =?us-ascii?Q?t9/xVToFrbh9R6m2owBDncL7HGIVt9N/9JCwJbiXDIpnapRRWtKIh8HUO7eK?=
 =?us-ascii?Q?Wk/aDM8dUNtWVe7hXADy7hTH6Ta+1ikPE/m89QkqmXEK6Jl1nAHy8w5xg0sS?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sC6VSVZvOQrUcAeXz2SbcUawDEGPLtzi6YtYpccOaZ0gnW6xTSCUl+OTeHfVS+aD32VN8pbmooxBO/13rsYPWRxvS9SWeYsdGqe4bRTYLsWi1TzHlWDr6cSLNDSa7WahbYESTW0AGTpxu/5gr3xKnglNNF8ewPiAvzR8bsFfdc0CnPp3K16EroN0p73TwfB0qKkTBtZ5uZh0JNv3norzl2qgzj7CllqV6Y2LinABxyJ/yZUnZSi4U97Lq1x+zaFzKOPWFe96NySIA5EsOb4NOzHpQ0R2GhTitRMY4Yo8+dm07ta/f4k8nqqYv0FNfpx56jMo8du0xS35wvs1uMAE9Yg4j3gEXiSHZAqa28RsG6BC/vtnv62yBHvBUZkVAnMTa4bcIW/4gUhgg8gvSuruDloxoEWaLIZQgvObozqBnaNdjX77s1QD39oxH+sPDhiJVqHlG9v6hHzAPpeDSvDGKbY2Kopqjg7KQwaPFh0z4wpIWJs1OyK/1+nYZWGC+98aVf5NGSZjLcUgaDd9F5V+MkyPpBtQoiBECr/JYI6tXf3BrOMfjxI8VLg0OSxojKtT705eyo510HCEpAPr9hDRE0U5/vLsA3WC1fKIssB6wP77fZdSGvbHpRWBRqQDFdEBg+3Phdc1pHdVlBY5HB/WhELzSJwDxD1nuIbswZcMYQS8D+4lLtzIVASE47OUwNuh9z0tWhz7vBalztycOp2D538qAsA8RQwGJGzL5XGTKpjcGOpPHepXXlFysvfi20Mh5Zh9sP0Lnq83cwxoBlY6u1ViZgxCX716u/sDxW+dyqvbFz6wZbkurZE6sMI0HWpR
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec7e526-8655-44b6-68d7-08db6bae1c71
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:32:54.9914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buGUo49xGvyVaDdNphltjoYM7K7SUTPuPtVgwT6e93l1gJbE20eAJ7X8kU92Wa5/gDHY1GX/OkSLv/sh+CgHRIDX3I17+lTXLTUsFDPim7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130012
X-Proofpoint-GUID: D1HB3sJ8fVSaKJJohjVtEQ1cEwSjXsIX
X-Proofpoint-ORIG-GUID: D1HB3sJ8fVSaKJJohjVtEQ1cEwSjXsIX
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

This patchset allows us to allocate multiple workers, so this has us
move from the vhost_worker that's embedded in the vhost_dev to
dynamically allocating it.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 66 ++++++++++++++++++++++++++++---------------
 drivers/vhost/vhost.h |  4 +--
 2 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 82966ffb4a5c..dfd96cf6a152 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -235,36 +235,40 @@ void vhost_dev_flush(struct vhost_dev *dev)
 {
 	struct vhost_flush_struct flush;
 
-	if (dev->worker.vtsk) {
-		init_completion(&flush.wait_event);
-		vhost_work_init(&flush.work, vhost_flush_work);
+	init_completion(&flush.wait_event);
+	vhost_work_init(&flush.work, vhost_flush_work);
 
-		vhost_work_queue(dev, &flush.work);
+	if (vhost_work_queue(dev, &flush.work))
 		wait_for_completion(&flush.wait_event);
-	}
 }
 EXPORT_SYMBOL_GPL(vhost_dev_flush);
 
-void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
+bool vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 {
-	if (!dev->worker.vtsk)
-		return;
-
+	if (!dev->worker)
+		return false;
+	/*
+	 * vsock can queue while we do a VHOST_SET_OWNER, so we have a smp_wmb
+	 * when setting up the worker. We don't have a smp_rmb here because
+	 * test_and_set_bit gives us a mb already.
+	 */
 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
 		/* We can only add the work to the list after we're
 		 * sure it was not in the list.
 		 * test_and_set_bit() implies a memory barrier.
 		 */
-		llist_add(&work->node, &dev->worker.work_list);
-		vhost_task_wake(dev->worker.vtsk);
+		llist_add(&work->node, &dev->worker->work_list);
+		vhost_task_wake(dev->worker->vtsk);
 	}
+
+	return true;
 }
 EXPORT_SYMBOL_GPL(vhost_work_queue);
 
 /* A lockless hint for busy polling code to exit the loop */
 bool vhost_has_work(struct vhost_dev *dev)
 {
-	return !llist_empty(&dev->worker.work_list);
+	return !llist_empty(&dev->worker->work_list);
 }
 EXPORT_SYMBOL_GPL(vhost_has_work);
 
@@ -458,8 +462,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->umem = NULL;
 	dev->iotlb = NULL;
 	dev->mm = NULL;
-	memset(&dev->worker, 0, sizeof(dev->worker));
-	init_llist_head(&dev->worker.work_list);
+	dev->worker = NULL;
 	dev->iov_limit = iov_limit;
 	dev->weight = weight;
 	dev->byte_weight = byte_weight;
@@ -533,30 +536,47 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 
 static void vhost_worker_free(struct vhost_dev *dev)
 {
-	if (!dev->worker.vtsk)
+	if (!dev->worker)
 		return;
 
-	WARN_ON(!llist_empty(&dev->worker.work_list));
-	vhost_task_stop(dev->worker.vtsk);
-	dev->worker.kcov_handle = 0;
-	dev->worker.vtsk = NULL;
+	WARN_ON(!llist_empty(&dev->worker->work_list));
+	vhost_task_stop(dev->worker->vtsk);
+	kfree(dev->worker);
+	dev->worker = NULL;
 }
 
 static int vhost_worker_create(struct vhost_dev *dev)
 {
+	struct vhost_worker *worker;
 	struct vhost_task *vtsk;
 	char name[TASK_COMM_LEN];
 
+	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
+	if (!worker)
+		return -ENOMEM;
+
 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
 
-	vtsk = vhost_task_create(vhost_worker, &dev->worker, name);
+	vtsk = vhost_task_create(vhost_worker, worker, name);
 	if (!vtsk)
-		return -ENOMEM;
+		goto free_worker;
+
+	init_llist_head(&worker->work_list);
+	worker->kcov_handle = kcov_common_handle();
+	worker->vtsk = vtsk;
+	/*
+	 * vsock can already try to queue so make sure llist and vtsk are both
+	 * set before vhost_work_queue sees dev->worker is set.
+	 */
+	smp_wmb();
+	dev->worker = worker;
 
-	dev->worker.kcov_handle = kcov_common_handle();
-	dev->worker.vtsk = vtsk;
 	vhost_task_start(vtsk);
 	return 0;
+
+free_worker:
+	kfree(worker);
+	return -ENOMEM;
 }
 
 /* Caller should have device mutex */
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index fc900be504b3..cb872cc4157a 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -44,7 +44,7 @@ struct vhost_poll {
 };
 
 void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
-void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
+bool vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
 bool vhost_has_work(struct vhost_dev *dev);
 
 void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
@@ -158,7 +158,7 @@ struct vhost_dev {
 	struct vhost_virtqueue **vqs;
 	int nvqs;
 	struct eventfd_ctx *log_ctx;
-	struct vhost_worker worker;
+	struct vhost_worker *worker;
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
