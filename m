Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161E0C6FD1D
	for <virtualization@archiver.kernel.org>; Fri, 17 Mar 2023 09:17:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90144416DE;
	Fri, 17 Mar 2023 09:17:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90144416DE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=HlvnOhw8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=kldgiKOT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7B6WffP55aOT; Fri, 17 Mar 2023 09:17:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 932F441612;
	Fri, 17 Mar 2023 09:17:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 932F441612
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7965CC0071;
	Fri, 17 Mar 2023 09:17:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAA7AC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 09:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A15A060F98
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 09:17:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A15A060F98
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=HlvnOhw8; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=kldgiKOT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fb5wi9kbY7xZ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 09:17:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8BBBF60F4C
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8BBBF60F4C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 09:17:12 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32H94Qss014865; Fri, 17 Mar 2023 09:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=AAlA6D8hz23AMTwCSmkeMY/wTtndV//OwyRDHAPBERQ=;
 b=HlvnOhw8vCEK9Y+Fd3E7W+NBExnAkEMPBK2ByBQqXz6Tstv+BUzi7yS5UIFVjz6CCWh7
 XFJOLI/dRSpii8VhgmBuER+IZVEcDdJ/fsR10xorIY+e4LWDIGxrhuMHwR0afL3EozL0
 8RNfsOlQ8277VwqFR9VP6dMpniU6FyOU8QtgYcn6mxrT4Wa0oE2TFUV+IOv970oCt85L
 FmaXXNUDORhovKbm7z4p9RHg6RgSqzb5XNOhhhj6SGStvnqWjpfDF8KDKM8KWMNS9WGr
 NMRRPi+8g/LOLq+5m/eIL60bMeKKYRKOP2YHkHAXUrSaS24thf5Yov7mPruxWyPvkua/ lw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs293ajp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Mar 2023 09:17:11 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32H70ktm026670; Fri, 17 Mar 2023 09:17:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3pch07rt72-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Mar 2023 09:17:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dd0dQAOXw5GhrmyX1s/SWoPF455b4GbyHAff0sx4C03rsmAQ61jYSK4Q2+z4BXCVnR/XG8IbzNBIKWLZThU6vneUQ5FMkttaGH6O+eYtVIlayDSmaSXh/JMOdwG3P9QfaK+9jn/fhwxTJmeyCGNqugZZ7eXnWRL5xDlxxKiPw5bu/1u/z6rEIUyD6OYyDtr3+QliF+km8EbGcO8LgQeuRu588ch5P4WOr8c3YI9oBHNPY+2cQyCAumtIM2l20NF6cPqJ71v49OTbVZTGfhSlRezV2FaqkmSYlOm2+bbtniThi4+KZGikwsrAYnG57gVQ3QdRWnsEfzAG/xyt9Y+Gig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAlA6D8hz23AMTwCSmkeMY/wTtndV//OwyRDHAPBERQ=;
 b=FGImOfvSxX9Z9d6rmiIr36lMCBCXf38tDET1U6vFdC8X3zT+2ECu5+ZEpOhG/UAXoMYExb+rZ+oPFfN/aT1srh68dRj8jv5mOXRoBVP4HkSD0oh1zlOs+3Hs0ec4reQyNfZ5kHEFgdy5/0bSZLq0pquGIC7Z8X7hyDBmR84Kr5MXLACelNJzRtfEiPBrPl0xR/3AOc8NQhSsLeIJvse1kM4aJA+Fz9H6Zj83pxx5oSvvoXd2t4xDJoF/YELaTtGgWQRgNoknwQAGTzOcNHhPpTKlTI4jX8QxA0TnXXx5+YYkVUqTJbkmdyQoCoETKZcbWI/zr5vg5dYlhXouM1UpSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAlA6D8hz23AMTwCSmkeMY/wTtndV//OwyRDHAPBERQ=;
 b=kldgiKOTXa5X2FZcujDOQvaI/W4ph4gMCrxEHRi8fz7mp9kwJm/QVo0B2QRrAWp1/jSa05Jp9N3n0ZyLckQQ4JHwgO4MFMG8GmIQIm3WulYQ4FkD2cJg4g8aPtAfv/H+jVWX5qrwq0DSpY8sRpNX9B4ptjeAchUqIjdMxiAMPko=
Received: from DS7PR10MB4926.namprd10.prod.outlook.com (2603:10b6:5:3ac::20)
 by DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 09:17:08 +0000
Received: from DS7PR10MB4926.namprd10.prod.outlook.com
 ([fe80::9ee4:1e8a:76b6:959b]) by DS7PR10MB4926.namprd10.prod.outlook.com
 ([fe80::9ee4:1e8a:76b6:959b%2]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 09:17:03 +0000
From: David Edmondson <david.edmondson@oracle.com>
To: Feng Liu <feliu@nvidia.com>, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 2/3] virtio_ring: Avoid using inline for small functions
In-Reply-To: <20230315185458.11638-3-feliu@nvidia.com>
References: <20230315185458.11638-1-feliu@nvidia.com>
 <20230315185458.11638-3-feliu@nvidia.com>
Date: Fri, 17 Mar 2023 09:16:57 +0000
Message-ID: <m2ttyjhh4m.fsf@oracle.com>
X-ClientProxiedBy: LO4P123CA0408.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::17) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|DM6PR10MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: d26a1cce-0369-45e7-2eb6-08db26c85ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+kEQC8v8PTFvjCpEP5CBdQ8IGnbdzH0u1vZftoJT5OUcvVW+QYMrotFYD0AMXkCWArzmVjGr9Vubp735f2e6lSbO0xm4Ppne5C6mh3EqE2sxt0xnaM2jRdcy0uuIZiEf0nbioKTdorbdHCbQKtTDesQRSYlcraImpfnsv3lNMxpr9y+CYXEoCrqcAgjw4UlGVKRtASvr5bhh5QeKeBa8cozlsQZeK/y23B8YU9uMmX1JvTRj3mNomXDJ/4p4EdE72MrEGLSTrnOc44//34//BLyd+l3slWh33dL+f+9GgXqt1wbRrz+gH1wUReXbmEOrwlW9JYeoY8/exOYglvLLfIJKpa5XcaJqg5L5gnH/4hqKFEV2tMZsgGHxehFzkf0586ZXPn5iwTuCkDCK4uiimI6a91J51uOGhko98SRvPnZ6JSmupnb+gDEW34xEEaDixDtYmwb0X8cntv9oTPTNNPhc9/w4FS42/tUhx/p9Ieet58HxnfI24udrSruiHVGw2I3QnRPQ+g0aZiaVwlKIPKq4+2PCgTyN5t3v+Rnm+GA15qOYeSRqI+FEZgBfouCAp2VVH19ywQKA5Y20Z4wj65s0Q13HJ1CvqVonjba0aKdewU4fSz0jq4Ki4AiLYaE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB4926.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199018)(966005)(6486002)(36756003)(54906003)(38100700002)(4326008)(2906002)(66556008)(316002)(8676002)(66946007)(66476007)(478600001)(186003)(2616005)(6506007)(26005)(83380400001)(6512007)(41300700001)(86362001)(6666004)(8936002)(44832011)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HOSumHb7vZsTK9xDmKMp5wXxzHW+QjltvVemy9KI3neQR9X9YgnURK3yLzMo?=
 =?us-ascii?Q?YkMVAp3zvf+4gxn41WJc8Hhe76k2DsU3YctPtvCgZ+qweR6BvQjIi2yR4smD?=
 =?us-ascii?Q?YcSMd9+vIFcpwZUSadLmDuolnUOJXdHAx8TErsjxseTt/bAl3Nq92F5qW6z8?=
 =?us-ascii?Q?9ugp8HlXqZBVsh+XmujkMk/Q/6GPlH0zyg+wT920DAxxSX8vnR6iJqwns/3Z?=
 =?us-ascii?Q?ZEJ2LKB9i0hjpDAqpIsldw/I1AlS2lPtPqsVUvHGYCC3u9lM0/ENDOOAHS5U?=
 =?us-ascii?Q?vzDXgfv5T+IDgXsJwHSNzo8ogSS+F+kfOT35C12dKNExfnTUsT/aIE52MsSp?=
 =?us-ascii?Q?42KjYg59teJzUf2KlHjWy8KDO0t8RRjn3wCywTzKpuicZCfiNmSqltPMQfuj?=
 =?us-ascii?Q?B6EH1HOvslNzg1bmt1y1icVW4P/gJMxiWvT3/3d2rrVgEK1O+XiwPW7Gl/ik?=
 =?us-ascii?Q?yHyN0NFr0NOJtZQfoGiKsdM+JbSHHv2knfyhhCyLssL6ceqJl6zOjYQOisL+?=
 =?us-ascii?Q?1TZ9Qxp9PxLor0BcqWgMlqxAxN/Zko7oKcPd1OaTMXSieAIXQQ5cMQ3FonAN?=
 =?us-ascii?Q?5NNScrHIJLLATU+a7Kmy4QTu1RSE5T06RgZvwMI4863Py2hMwJiXpOlsn8C8?=
 =?us-ascii?Q?/Dt7Cw3PG63ZP7AsQebgpZQHbGwrYEF9JXMN5796401sPS0E7SxD9UF7/Gg7?=
 =?us-ascii?Q?10uVUjb+6UD73f1La7ssVl18q22Eorp2nzW+Se4Ry/6Dk5KDfhZX4q33y3cP?=
 =?us-ascii?Q?K2pj2XWG3aQxfN2DfXbeeadKK2uKdWtByPxMY6NovADuNXGgf+bfrSqG2PqT?=
 =?us-ascii?Q?uSogiIP3M8VDO4I6U0NG/xmLQk5ItJDHlw2xqw01klrbvN81uYdP8S6ALEZM?=
 =?us-ascii?Q?TaZk9qyT6UQ9zlMz8pwITVCYbzcdV+FTl+RNBs4w4wWk2gteyRKBFZKUxUIp?=
 =?us-ascii?Q?urcRVNbDMVboh8e8SrDs7xP+rfQ5+38SHxP78ObgFkPYtXCQ8wji9b8xa1zR?=
 =?us-ascii?Q?7NWs86FpxKrFoX1tfTAj6krimWxhbzX75tId1A4/nXQxggB/wbZFvKh2AjdX?=
 =?us-ascii?Q?59cXkTlzy4vG2tgFHMJxppi5An7EiaSOuPmuObmgbieGpzsiJrKKHpJjZFHh?=
 =?us-ascii?Q?hUS2LucEV+7Lkq0K24i4dv26emxaba0IJmpgtMKfYD7lgr/iHhgamN0K9BTk?=
 =?us-ascii?Q?meE/T0TUADiNd0SivBfliXAdtCGW28XIR74DTxIRf81pg6r/MNytYv0o5kox?=
 =?us-ascii?Q?xLG7vWbkH0Xlanaitpr7Xi1ZaL6HOowLzzGQYwiDNZYfVSw4ggXuzg+kk4M+?=
 =?us-ascii?Q?kK4wqiGoAxWwF1/uUOoyOFJ1eCnTthVr48HG0g305DB+IOAyNjV0+tlEX6iA?=
 =?us-ascii?Q?r/+pk7GBgwh9EhBsUnT0EszUO5++nsPAUh9o+puM/RzfV76vWImodAPiYrPT?=
 =?us-ascii?Q?STKzkUqUuEXIxEIFEA1Wp1lnFvxk0w4dSN927ry3BX8t11lXN/ZYd3uKINHe?=
 =?us-ascii?Q?vQLcnUd3wQW6M3RCqKmQNrKqnWeWX+bXjIEJ0Pem1+OQftzKgh6o+87jdCzo?=
 =?us-ascii?Q?G98wvp8Ga53rU5vm/bC8p6C4AE1AsuK9STNbvmLFAA1E1bAKLIUdXA1uk9px?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OAV7DlyWgB4BQNsYTFQNA5kxyJlp6qU+hTR4SYFopW2EmtKmOP3ULsdghEkvwlyKpuvn5FaUj2MWjqNa9b8PiBIHadc9cN5SOJWiNxZG0pDa6bUiPaLIZVxdw0F74RaLOad8JQBcPmFfGbJVefVIm9Us/6lPej+/AubwM5TaA3UasWiNOxIf4AIuBVMOgzieJgjEQL8GoKQjHaf94iTgiQRHoAOrQdKah/nlWKK5Q+GRyH4nqYXUxjURWMmjFWRhsNjyN0+xdJf2WTCI/+/C/O6xXsOVKo3o9+UsM8dfkDbhaqZ0UxFZaGZ7by39+18elopfgmOoCj82Sr/HGY637OapADIA/0MynUSd1ND2MyGR7m6NTRch4h7jEEFMhxCEJK2lLDqOxZYIF7ECy0u8j6K+Jc/fpTy8B9TGsWuffLwFAzod8IPHRKnRebSdQwPfdLL8uncouGuyH8PdDE5NJXK1q3EgIi4MfwgvxZouhuW844HoXcxkpTFc3L0Plkhb0iMsGSZNBPCXlAgomydqxmP0lhE/LGx7t2iRJQHI79wDdEpfCvEIpIXcr5lpUj9++eWK2eoXI77HjOTWxBTHKhGhVwBlZChRKZWjMm8Zmt7vq0ObYQ0QVjFAl5/V/+VunJhGQ69/ZC5D4t6+K+xRW3kGxaHbumVplqdnhmGb9zAZImNFYnrx/lNkRxSxxmvzAHxG09VpuU2SgZKOCkVXqer01h/vqeMU4TLY2ngqSzPjYzC9pV+vGyeB280YSB7fjeG61M8oQ1A2fzqroJ7/al6VjUD7S1iRPZ0Ir//1WZeEeLOJZtUkjoKH8ujbJsULDCysVF7ilMHcp/8zcHxzH7BoOIowWmDVmx1PRN+JYTw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26a1cce-0369-45e7-2eb6-08db26c85ed8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 09:17:03.1160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxbNbcPdJ6gelt4fDvfou5+0tqmfJ5op7+1R6CLpSrz647iJF5fZWL1e7v2/vs0Cxd1Yh27mA7FxbrBEPlMDWJtlYO5k5BhzFgUdBrUbXpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4363
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_04,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170063
X-Proofpoint-ORIG-GUID: kdwsMoJFH3GLUTIIJt8AOAC5UTl9cTiO
X-Proofpoint-GUID: kdwsMoJFH3GLUTIIJt8AOAC5UTl9cTiO
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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

Feng Liu <feliu@nvidia.com> writes:

> Remove the inline keyword, according to kernel coding style [1], defining
> inline functions is not necessary for samll functions.
>
> It is verified with GCC 12.2.0, the generated code with/without inline
> is the same. Additionally tested with kernel pktgen and iperf, and
> verified the result, pps of the results are the same in the cases of
> with/without inline.
>
> [1]
> https://www.kernel.org/doc/html/v6.2-rc3/process/coding-style.html#the-inline-disease
>
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  drivers/virtio/virtio_ring.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 41144b5246a8..a26fab91c59f 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -233,8 +233,8 @@ static void vring_free(struct virtqueue *_vq);
>  
>  #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
>  
> -static inline bool virtqueue_use_indirect(struct vring_virtqueue *vq,
> -					  unsigned int total_sg)
> +static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
> +				   unsigned int total_sg)
>  {
>  	/*
>  	 * If the host supports indirect descriptor tables, and we have multiple
> @@ -349,7 +349,7 @@ static void vring_free_queue(struct virtio_device *vdev, size_t size,
>   * making all of the arch DMA ops work on the vring device itself
>   * is a mess.
>   */
> -static inline struct device *vring_dma_dev(const struct vring_virtqueue *vq)
> +static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
>  {
>  	return vq->dma_dev;
>  }
> @@ -784,7 +784,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  	}
>  }
>  
> -static inline bool more_used_split(const struct vring_virtqueue *vq)
> +static bool more_used_split(const struct vring_virtqueue *vq)
>  {
>  	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev,
>  			vq->split.vring.used->idx);
> @@ -1172,12 +1172,12 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
>  /*
>   * Packed ring specific functions - *_packed().
>   */
> -static inline bool packed_used_wrap_counter(u16 last_used_idx)
> +static bool packed_used_wrap_counter(u16 last_used_idx)
>  {
>  	return !!(last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP_CTR));
>  }
>  
> -static inline u16 packed_last_used(u16 last_used_idx)
> +static u16 packed_last_used(u16 last_used_idx)
>  {
>  	return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
>  }
> @@ -1612,7 +1612,7 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
>  	return avail == used && used == used_wrap_counter;
>  }
>  
> -static inline bool more_used_packed(const struct vring_virtqueue *vq)
> +static bool more_used_packed(const struct vring_virtqueue *vq)
>  {
>  	u16 last_used;
>  	u16 last_used_idx;
> -- 
> 2.34.1
-- 
But are you safe Miss Gradenko?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
