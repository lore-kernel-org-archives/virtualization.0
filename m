Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3273EC05027
	for <virtualization@archiver.kernel.org>; Mon,  6 Feb 2023 04:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCA7C6070A;
	Mon,  6 Feb 2023 04:53:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CCA7C6070A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=0vh2NCcz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=fS54worM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s0aGjdJ3Qhi5; Mon,  6 Feb 2023 04:53:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5DFF460706;
	Mon,  6 Feb 2023 04:53:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5DFF460706
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AD89C0032;
	Mon,  6 Feb 2023 04:53:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7AFEC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Feb 2023 04:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B1F688144B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Feb 2023 04:53:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1F688144B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=0vh2NCcz; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=fS54worM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M32fPmvMViOi
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Feb 2023 04:53:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C7F19813AE
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C7F19813AE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Feb 2023 04:53:53 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 315N4mkY018938; Mon, 6 Feb 2023 04:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KpBka6SXZ8VOU406/sM8GjDPWDzgnRAvTVc8ccaY6Ns=;
 b=0vh2NCcz2zgQPmVcXGqpEta/nOVyLz/yJqwtFbMuiTl8dij3JZR2g/f6PGERklOtNB5s
 CKxkT2dzt6u3ElVcTHAVGNnQ9Rd02F+bM6TBaAu9psvKx8KAfBp1sqToZfLfQlTEuz6Y
 DY0qJ7SCmDYGfWVeKmJn9nSF39XsvMEFUW2kKnjSN5JDPRON7x3AKDWT3ZY543kcD9bn
 nqPQ83Wy9Ujgzb9bhPRSb2d4fwPe2r4EqRVLY18dd+Frfj6SD6U2L0aTwip8xhhGiMpX
 n7hB+0UEXNfN4Nh87uBlMc1ynEIM7XyyqdUz9HC9x6h1nhmhYqCk5n4VnjN8ds//aA2S 6g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfdca0fq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Feb 2023 04:53:52 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 3162X3vA011584; Mon, 6 Feb 2023 04:53:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3nhdt428ks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Feb 2023 04:53:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVdxv5EQJSvYIHoqY57fJL9hi/OTSGVgNMlFZbws76RXUMfcnvCBfDTvNMaP9cRm3fxu855Pt6CS58eDLEB6YXyG8HsRXbzXyESwoEXOeTdB68XJfvLh+wtRQZL5QSowBC4gCglqqkZiiBqUICca7LBQCEPOC+rEWf4nEhb8B090p7RAjpE1qUFwXrTvtXLLfFLSXfOGnUSNLijTJVGDCNvlhDVpsgRQu/jo76a3XKzFLmU79RZ9PRSxJJrg/NPxCkM0czocitsQYeZAWjQqL/w2ADKQygsKNV6/RPNxL976WgEhFh5DDWGJHj2WQdLnEfUxE59rYRVtnuFUKMQnPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpBka6SXZ8VOU406/sM8GjDPWDzgnRAvTVc8ccaY6Ns=;
 b=BIQ/7yKvteNb7MOvjTGkvq0NEEt/eGQvapjADKJVF2Cd/zyHk3ER6O/jacvKXDM4amJDB825j/8l+EQkbT8jPgLYz6FgpMrKTh/J1tBFwI9PkEM5r6YTr2KORa3jXcNuB9mwmI9z7JMA1l/cCisYOHyIJ6rIOwr3IhKtb/zMrJIKI07G26giG6mBG+GR/KX6n/HSicBdJgY3GYFPn6Olx6JcdM6iVB7rfbYnHuS9OIF6grDDl1B96055IISLTuQWoNh9MOyBveTK5f22E+CIQT+obiWUjF528Bu/iULq5qHcnZ6q+xQ+jUSH/HPzhWXxuxt3sDbz1M2JDPTspJQz1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpBka6SXZ8VOU406/sM8GjDPWDzgnRAvTVc8ccaY6Ns=;
 b=fS54worMHBtT/iDEKwL+zsa0GdpstGDk1zzcQDQp360znQLNCywtUm1HM11COkdd6vhF2iWqiKZYUcD0i2PfkkWNbYMfpzWQEK980XV8lNqkan49tbDAxBsA/GeC5I1O/NRYRelcHHGsMNI6EBKZpDahHeB8hK21EevdFTZaxL4=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BL3PR10MB6164.namprd10.prod.outlook.com (2603:10b6:208:3bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Mon, 6 Feb
 2023 04:53:45 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b%6]) with mapi id 15.20.6086.009; Mon, 6 Feb 2023
 04:53:45 +0000
Message-ID: <7b3af822-0075-889c-911c-b79860fd5ce2@oracle.com>
Date: Sun, 5 Feb 2023 20:53:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/6] vdpa: conditionally read STATUS in config space
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 parav@nvidia.com
References: <1675400523-12519-1-git-send-email-si-wei.liu@oracle.com>
 <1675400523-12519-3-git-send-email-si-wei.liu@oracle.com>
 <0f158916-aaab-0afd-6cd0-382f54ef26d9@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <0f158916-aaab-0afd-6cd0-382f54ef26d9@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::34) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BL3PR10MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b98560e-077b-447b-d9da-08db07fe2056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8Im6U5zrJYazRk2L07PKH79WXnrL3hk2t9Gxds1a8l2FEMA1aOanK22FoxH3OfCfISUnGVPq8AQ6EfOsNqCmCfHMjx607fw1KqlaA2MyWz+qOzW5ZNH9xDCNoZJlvk5uWdOHBWgKiP1SMMgNJYCrGfWVSXAnjd4AoeXkacPejlQ9H2Y8N9pgXSE5dyaOYnxaBfHv6Rm4XH5fQaLkVOI56o92Q3tQWxlngRKglAF1Q38odsmUolJI7t9XxP9CzGIyHE2IEv1vdTUjPHghXVZ31KP40aU/djSUxj0F6dqJqTgC/nklj0y7laBdXt52vdLRqQRsWTISgvuhWS+3y2rMUFtRHk2Dab1km6G1lRk9S0wzTXclOYTKuJvYuIoAtrw37zbl+UgGSO9E/S9yqo8SJE8ik54kpxdd9xuckDcUVbAU7//KX23hxrzWQSCRT7Vwf6x6GOQqWjhtKpw959cbkz7nwpOJG3ZhhsCU46mHSrMBBu3ic8AYKUGol5Ot0gCLyfoHGGIOXMZq1Ujxg46Of2vxCrLIgcIElf1ljsY+OnnY0+7S7oSiAaqrIq1NjoNp/cJCrUPGn3o/InMnmdE1OST7Rs2/NeOzvkfmBFTHNDwS5Vn2cuT8lmD4FHUIJlRDVduw/3NJwSlKWlyOf0GZgDw8ITgUWioS2U6jFn9EEJuz/dTqwHFYeOzcHf+tamHBMqAHQkJFxgM/PRbnv/9KhwYaxXBTHDiO3KUxS17jbs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199018)(2616005)(36916002)(83380400001)(41300700001)(6666004)(4326008)(316002)(66476007)(8936002)(66946007)(8676002)(6512007)(86362001)(53546011)(6486002)(186003)(6506007)(31696002)(66556008)(26005)(5660300002)(36756003)(38100700002)(2906002)(478600001)(31686004)(66899018)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlQ0cmtGY3kzSCs2Z25EMHJqZ3J2MWVKMEVFaGtXRTc3Z25FYU5ZZXpHb3BQ?=
 =?utf-8?B?U1hZZFAvcytKMmhIbWtTSVdmeWdpT1M0S1VpdTR4VVJTdFU3R1VUd3U0RXc2?=
 =?utf-8?B?QjdaMmRtYnA3T1dxZCthMnZpYnpxRFo5RDY0MUpkL0hHUkNwTjN6SFFrQ3Jk?=
 =?utf-8?B?NWJldUFuSDRtM3g4WnpjVy8vWVFCVU8wRUtlSktzRWhXQWc0UlRHNE1NeXpX?=
 =?utf-8?B?RHhlMmV0UkhLaUMxWGZ3dDlsVS9EVTZyckV5dzRwTURDbk1DV01USzk5UVBr?=
 =?utf-8?B?cmtpZTk5cUp5Y0pNR2o1MHlCVW56akw0VjV5M3pLbzUwdVpIYzBJZnIvcU1u?=
 =?utf-8?B?Z2Q1OFpPSkNOUFIrZytmN05lL0RFTDl1eFVxTkwxOUJQVi9yZURudVl2dVkv?=
 =?utf-8?B?amF0LzhZL3ZzRkNXOHBiQzI3M1BobnRMZnJwbWZ2YUVZMnpCVFVHbjJLcHlm?=
 =?utf-8?B?NXBOTUg3YjlpSjJjU2xQN0dVVkFvUDdudExRNW5vUWg3ZVhhODF6ZUNqc084?=
 =?utf-8?B?bUtpdEhvclUxa2pZNkRSeUJGdWZoVkR0NEJvemRaeWkvWTNyZnQxN2h6L0Vp?=
 =?utf-8?B?WjR5Z2NVZHhPWVJvZVJBTnRCM3BJUU8zR0xpZVVHWitZdWtDNWdGbFU5QXlB?=
 =?utf-8?B?YzQ5WDF5THJjMTRkKy9LVEcyUlVjVzNiVXFqNS9QbUlDYjdIQUdHSEpvY0RI?=
 =?utf-8?B?V1RyTWU4MjZLVnk1aGhiR3A3c0dPNHh0V3N4Rnl1R25kRGxvb05wVkZQK1di?=
 =?utf-8?B?ZGtad2VsVSt0bFUrNXUybDI3RlpxUXJWMWlzeDNrblRjOGZwK0RzVTVJcHJE?=
 =?utf-8?B?bkNnNGI2bEIzd2tSN0VOU3VVRFJ6VGZnWERHR3VCY3pRM1FZZ2h4Z1JoRmlO?=
 =?utf-8?B?TTRYa3FLU3lOQks2S2RNNm9lL1Yzd25uOHZRWU1odGNYajVSNm5yLytnTllw?=
 =?utf-8?B?M3p1RC9VZmdkcVhsU2lGbk9wWVNGdlZWVklrZ1FHVHhOd3JGVTFSTkp5S0sy?=
 =?utf-8?B?ZGRpUXNHV1ZBNHcxcXAzMHk0dTZ6SFJIY3B1V1E2L3FNRm5ITmtNWGpLdzdt?=
 =?utf-8?B?NDlZdjNwVlVPeTN6UzRBVHgxZ0xEY0VQcVkrT1ZtakFVNitTbmNwbGZYd3FN?=
 =?utf-8?B?eVE0bW1jaW55VXo0YzY2OGhrK2Y4WlBXQWxUUTRaM25BNlJkeE1qQTAySlA4?=
 =?utf-8?B?YnlpUmlGWURhN3NCR3duVG1hMEpLYXhPREFHYTdGSkxHL0RGVGxrcm10V05m?=
 =?utf-8?B?V0gvMkROa1JrR3VOVlp3ZEx3ZHVDam5IZHR6UmdHbTRSL3hEVmV4cnBrTzQ4?=
 =?utf-8?B?K3hhTk1pbUxKYnZBa1BrK2ROTmptazUvUGhpQnRvVm5WeXhPL2tWTXF0dkx5?=
 =?utf-8?B?K0VUY3loYWdpdWx1OGFML3EwWGJ0RUpDVkQ5N0RuM2ZGejBCV3dGTU5IdW1D?=
 =?utf-8?B?TkprTmJlNDhWV0szR0ZHM09DK2dDMDhKZ0lyc1ZEN2tNK1RJM2Q3VkZheXdw?=
 =?utf-8?B?QWxMTkdQcGZmLy9GaFVWZlh1WUVBR25tNEZXTE9SZ3dMVXVwWldkN3JiR3Vj?=
 =?utf-8?B?UmRKWXdhUE5IUVBuZUMvN2dIanJ5QzRncTBCWC9JMUdndUx1eGhkZWJMQTJI?=
 =?utf-8?B?b0tWazJLTWl6YUdDU1hxb2lQZHdtZDZBbTRvYmNyL3ZWWXU2MDJYZWN5Y0hS?=
 =?utf-8?B?MmUzdnE1N0dzbEE2L2tabWFiSlhWMm9FbWZpaWwybDEvdzVaN05UN1VPZTFC?=
 =?utf-8?B?YzlscmczNnUreUswdy9NdkFlTzd5N2ExRmpHUlFVUHNkNWg2eHRPNXdwelIv?=
 =?utf-8?B?SWIrT0xoaEs4M1pSMHhGZk9nbGhiVEMvbExLUExKM3A2T2taQ3pRcjhWMTZ0?=
 =?utf-8?B?ZTF4MjNXN2Jxc2FMQ2VQNnFMd2dWQmlYcHo0alJ2b2l1UDJNdmZEZGozZTc4?=
 =?utf-8?B?NWtzWDBFL2w2S05tU0VMZUNaL21IM2JHbC9jQTZZMWl3WDQ3OGw1M1ZuU0l0?=
 =?utf-8?B?STFQT2p6UWF1RWRKWlQwckRBV2xrbDkyUkJjMFk5Y2NNMkhCdHZlN2ZETUQ4?=
 =?utf-8?B?Z1AzSm5UbVh4MUFiRDZVdWZxUk55QkwyUFBLWVltbHVhQkNzZTcwSGlaYnhr?=
 =?utf-8?Q?/EKJ3RXcZeXu5hpDr1ElfL0HY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: phtO1eFTP0i5kSVEUEiHLsO8kYauoMKO8bSvLq7g8YgmdoIhIKmsF7GtckZJB9F9ao0/yZf7TsVe6mNLZheDHwKEPoUXz1qPoEyspC4xpyuX/p9TRLLrdTGucdNGy/VJLD63T0aPosJxYq07y0qtaqQGlQtOxUjracPA0ITy+zi2W/ie2r5FyBMCmIaXT8Is1jHJZSQr6/Q0c5vkA3pENH0EC3dvwIvK9OM596s3Im3YgRDES50tFOjaU34HDh9rW7UTqmfCJ12qn6PrfdZctlP3+MU4MDNh6tog7XCVs7KCdS5viJV9KEVfd83WqJyTwAtl2CODDaXusyftKAl2jaXwt8Rpc6EFDa8d4XJcIjpXNJs/37qgm4u/U6Bw87CYBTBZJyIOu76sSCGItRjIR/CA08lLQQIJwzq7sb9ZTSLMkrl52OrB+WoLqD5utx1mY3x40g8blNwqzl2NyN1hF7eOF7cj213wc+yumUM0yPcYu0HweU1vt7ZMw7L+n1+HPewjdUjvOJ+8FjUaFYHpfM0YoDIY9aQ0hvyJsgiXCIUEMZBQI2RAVqzPG+vgQYZ7/qgbqG42dpvrY0ClARGst7pR/enXdm8XPtTRO300KTmsw2eC6nu085Xp5uvNwAEarowCJHDJGQkM+6fG0rrGLIcRnAssTSqSB//eJXEKSV+fEHC7C9b4pHaYzw8HaAXxKFlcw/1OcRl5K+CBxK9xO7acSJTgBuUDbtdOgcuazBU2V3h5Xa5JJcEgr/showMSDXosQ9SqVr2m3inH3fkskaJvJdJaQlfN2WQlzMzhruZKNJu26g9TCiBZE5OAGBI0TrQc5Bd05j810NS9BRSsieqLDCM2bdk/8qL2onPnLKMMRIvzwtiOVko5KSRseasg0qg6HKpoRhgI764AQXS4gQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b98560e-077b-447b-d9da-08db07fe2056
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 04:53:44.9957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6vFcD8vOnFeZ27PznhVbN1pxT4pC47X2cZ0RFjNuGet+lLNWS9OIBvzXMsBYGipNhpKPEGzs99rlJu7AQ8Jew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_02,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060042
X-Proofpoint-GUID: QhWH9t5b--WOmZ1LULG6tPBmXSHAGw-R
X-Proofpoint-ORIG-GUID: QhWH9t5b--WOmZ1LULG6tPBmXSHAGw-R
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAyLzUvMjAyMyAxMjoyNiBBTSwgRWxpIENvaGVuIHdyb3RlOgo+Cj4gT24gMDMvMDIvMjAy
MyA3OjAxLCBTaS1XZWkgTGl1IHdyb3RlOgo+PiBUaGUgc3BlYyBzYXlzOgo+PiDCoMKgwqDCoCBz
dGF0dXMgb25seSBleGlzdHMgaWYgVklSVElPX05FVF9GX1NUQVRVUyBpcyBzZXQKPj4KPj4gU2lt
aWxhciB0byBNQUMgYW5kIE1UVSwgdmRwYV9kZXZfbmV0X2NvbmZpZ19maWxsKCkgc2hvdWxkIHJl
YWQKPj4gU1RBVFVTIGNvbmRpdGlvbmFsbHkgZGVwZW5kaW5nIG9uIHRoZSBmZWF0dXJlIGJpdHMu
Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4K
Pj4gUmV2aWV3ZWQtYnk6IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4KPj4gLS0tCj4+
IMKgIGRyaXZlcnMvdmRwYS92ZHBhLmMgfCAyMCArKysrKysrKysrKysrKystLS0tLQo+PiDCoCAx
IGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPj4KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYS5jCj4+IGlu
ZGV4IDNhODJjYTc4Li4yMWM4YWEzIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYS5j
Cj4+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4gQEAgLTg0MywxOCArODQzLDI1IEBAIHN0
YXRpYyBpbnQgdmRwYV9kZXZfbmV0X21hY19jb25maWdfZmlsbChzdHJ1Y3QgCj4+IHNrX2J1ZmYg
Km1zZywgdTY0IGZlYXR1cmVzLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2Yo
Y29uZmlnLT5tYWMpLCBjb25maWctPm1hYyk7Cj4+IMKgIH0KPj4gwqAgK3N0YXRpYyBpbnQgdmRw
YV9kZXZfbmV0X3N0YXR1c19jb25maWdfZmlsbChzdHJ1Y3Qgc2tfYnVmZiAqbXNnLCAKPj4gdTY0
IGZlYXR1cmVzLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY29uc3Qgc3RydWN0IHZpcnRpb19uZXRfY29uZmlnICpjb25maWcpCj4+ICt7Cj4+ICvCoMKg
wqAgdTE2IHZhbF91MTY7Cj4+ICsKPj4gK8KgwqDCoCBpZiAoKGZlYXR1cmVzICYgQklUX1VMTChW
SVJUSU9fTkVUX0ZfU1RBVFVTKSkgPT0gMCkKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+
IEluc3RlYWQgb2YgcmV0dXJuaW5nIDAgaGVyZSwgaXQgd291bGQgYmUgYmV0dGVyIHRvIGV4cGxp
Y2l0bHkgcHV0IDAgaW4gCj4gdGhlIG1lc3NhZ2UgZmllbGQgZm9yCj4KPiBWRFBBX0FUVFJfREVW
X05FVF9TVEFUVVMKSW4gbGlnaHQgb2YgY29tbWl0IDQxYTJhZDkyN2FhMiAoInZEUEE6IGNvbmRp
dGlvbmFsbHkgcmVhZCBNVFUgYW5kIE1BQyAKaW4gZGV2IGNmZyBzcGFjZSIpLCB0aGUgdXNlcnNw
YWNlIG11c3Qgbm93IHNob3cgdGhlIGNvbmZpZyBzcGFjZSBmaWVsZCAKcHJlc2VudGVkIGJ5IHRo
ZSBkZXZpY2UgKmFzLWlzKi4gSWYgdGhlIGZlYXR1cmUgYml0IGlzIG5vdCBvZmZlcmVkIGJ5IApk
ZXZpY2UsIHRoZSByZWxldmFudCBmaWVsZCB3aWxsIG5vdCBiZSBkaXNwbGF5ZWQgaW4gJ3ZkcGEg
ZGV2IGNvbmZpZycgCm91dHB1dC4gRm9yIGluc3RhbmNlLCBNQUMgYWRkcmVzcyB3b24ndCBiZSBz
aG93biBpZiB0aGUgTUFDIGZlYXR1cmUgaXMgCm5vdCBzdXBwb3J0ZWQvb2ZmZXJlZCBieSB0aGUg
ZGV2aWNlIChub3RlIHRoaXMgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCAKbmVnb3RpYXRlZCBmZWF0
dXJlcyksIGV2ZW4gdGhvdWdoIHRoZSB2ZHBhIHBhcmVudCBtYXkgaGF2ZSBhIG5vbi16ZXJvIApN
QUMgYWRkcmVzcyBvZiBpdHMgb3duLiBJIHRoaW5rIFNUQVRVUyBzaG91bGQgbm90IGJlIGRpZmZl
cmVudCBmcm9tIE1BQyAKYW5kIE1UVSBoZXJlLgoKUmVnYXJkcywKLVNpd2VpCgo+Cj4+ICsKPj4g
K8KgwqDCoCB2YWxfdTE2ID0gX192aXJ0aW8xNl90b19jcHUodHJ1ZSwgY29uZmlnLT5zdGF0dXMp
Owo+PiArwqDCoMKgIHJldHVybiBubGFfcHV0X3UxNihtc2csIFZEUEFfQVRUUl9ERVZfTkVUX1NU
QVRVUywgdmFsX3UxNik7Cj4+ICt9Cj4+ICsKPj4gwqAgc3RhdGljIGludCB2ZHBhX2Rldl9uZXRf
Y29uZmlnX2ZpbGwoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCAKPj4gc3RydWN0IHNrX2J1ZmYg
Km1zZykKPj4gwqAgewo+PiDCoMKgwqDCoMKgIHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyBjb25m
aWcgPSB7fTsKPj4gwqDCoMKgwqDCoCB1NjQgZmVhdHVyZXNfZGV2aWNlOwo+PiAtwqDCoMKgIHUx
NiB2YWxfdTE2Owo+PiDCoCDCoMKgwqDCoMKgIHZkZXYtPmNvbmZpZy0+Z2V0X2NvbmZpZyh2ZGV2
LCAwLCAmY29uZmlnLCBzaXplb2YoY29uZmlnKSk7Cj4+IMKgIC3CoMKgwqAgdmFsX3UxNiA9IF9f
dmlydGlvMTZfdG9fY3B1KHRydWUsIGNvbmZpZy5zdGF0dXMpOwo+PiAtwqDCoMKgIGlmIChubGFf
cHV0X3UxNihtc2csIFZEUEFfQVRUUl9ERVZfTkVUX1NUQVRVUywgdmFsX3UxNikpCj4+IC3CoMKg
wqDCoMKgwqDCoCByZXR1cm4gLUVNU0dTSVpFOwo+PiAtCj4+IMKgwqDCoMKgwqAgZmVhdHVyZXNf
ZGV2aWNlID0gdmRldi0+Y29uZmlnLT5nZXRfZGV2aWNlX2ZlYXR1cmVzKHZkZXYpOwo+PiDCoCDC
oMKgwqDCoMKgIGlmIChubGFfcHV0X3U2NF82NGJpdChtc2csIFZEUEFfQVRUUl9ERVZfRkVBVFVS
RVMsIAo+PiBmZWF0dXJlc19kZXZpY2UsCj4+IEBAIC04NjcsNiArODc0LDkgQEAgc3RhdGljIGlu
dCB2ZHBhX2Rldl9uZXRfY29uZmlnX2ZpbGwoc3RydWN0IAo+PiB2ZHBhX2RldmljZSAqdmRldiwg
c3RydWN0IHNrX2J1ZmYgKm1zCj4+IMKgwqDCoMKgwqAgaWYgKHZkcGFfZGV2X25ldF9tYWNfY29u
ZmlnX2ZpbGwobXNnLCBmZWF0dXJlc19kZXZpY2UsICZjb25maWcpKQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIC1FTVNHU0laRTsKPj4gwqAgK8KgwqDCoCBpZiAodmRwYV9kZXZfbmV0X3N0
YXR1c19jb25maWdfZmlsbChtc2csIGZlYXR1cmVzX2RldmljZSwgCj4+ICZjb25maWcpKQo+PiAr
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTVNHU0laRTsKPj4gKwo+PiDCoMKgwqDCoMKgIHJldHVy
biB2ZHBhX2Rldl9uZXRfbXFfY29uZmlnX2ZpbGwobXNnLCBmZWF0dXJlc19kZXZpY2UsICZjb25m
aWcpOwo+PiDCoCB9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
