Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BDDC433EF
	for <virtualization@archiver.kernel.org>; Wed, 15 Dec 2021 01:05:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19642817F5;
	Wed, 15 Dec 2021 01:05:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sl2c6fZ5q2bO; Wed, 15 Dec 2021 01:05:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 847A08184F;
	Wed, 15 Dec 2021 01:05:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B6D7C001E;
	Wed, 15 Dec 2021 01:05:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B986C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 01:05:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 499BE60D5D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 01:05:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="ZSgX34pQ";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="kHo+4UR5"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fFDhbGtTD-rO
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 01:05:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7781A60BB1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 01:05:40 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BEMSvpi007071; 
 Wed, 15 Dec 2021 01:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gUwHy0mAcOXiZBnYx3uISsvzbt/itf1sm7uaBTsSJb4=;
 b=ZSgX34pQLvXFK45WHgrKwCg9KGDcBELTHLi819BwsBk+mXO5uotSw91/eI8aExvzoVi8
 qdJSq9mC/o2ee1mnvIqRbu0W+AbfWRrKHErC6xjTa5esIVueCrp0hyufGQ0YbpyjEogo
 KWb8LUJCp8xyY7jQ1dqv6fWX8gVuKmIz216stAgEiosgrPLZ6ZlRG1/Ui8nJLzX23m0W
 nwXNFpbjHuhgCoCVtCE+EA9z44M62e8zvJkZB+CU4NNhtHXyVVl8OmZ7Wgp9O7bg0Cc1
 pE+Ix8OpBvF3kOGFDdmGhn3jPzw4vEEB1HNAdigbXhUb9HzuZWxf303M9ObEg4yH7Dol Xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cx2nfdfy9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Dec 2021 01:05:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BF122FZ109679;
 Wed, 15 Dec 2021 01:05:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
 by userp3030.oracle.com with ESMTP id 3cvh3ya5c6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Dec 2021 01:05:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ek31M4FOZUQ36ajwLvpoBSJPOoUJ12UbXNeD4XINuL83CO5x1smzVzGWq+zXCatPYzSynh945P12H3fKYxSu2IbR3ekTicT2LSalEBmbQNNT7S8lqlfcsl0W1GJp3TK1QDyfmKVWUg5jip73kfUaIxvMx+v3GEJr1IjAHdwr0nCxQGM8FGzaNRiUgz8PS4Hfdo45s74PpOgOo4hMHOBgVAoDqo9JlCb4sOYSSN5Zww4aulhdoXyNeoATj4vSmHydcbmdaW7XKzZcJCt2hHKdJxwnHI7CD1FLYap7H5B0ekNwTVlCqyGZVx2degbKx+PZtpgzklbfXj7QXXPUA31fmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUwHy0mAcOXiZBnYx3uISsvzbt/itf1sm7uaBTsSJb4=;
 b=gZSdIvwmU2rExsm3e60f+Xh7ODkAk+cNUw2MsI3YVuL7VSvLmHEQmwf9Sq1xZr+JxGdRwicRoKsVkPokhbOP7h+ljwMhT1yxx5roxn9fvP1sMt1k+4qriJ/O0zspC+ew1PEHpK8pP6OtndkFbXGnlwkpssMt3szmXa9tNiKpNcVVt+DZzz0IU7T6iFgvZNFq7ccqQ5WQnovhKUzknmJSdE2cXTAnwipuKCIv1SPx8r9Kbf+oC+Yc3bj6djyNUj0b/GXsy++4wDyrNlzfYKRKsb3w1aDtRQTy1ArpuX9RdRDjQ2Kq0tQmX1XfoOHSEBp/diyhhS0EsKrO+J1qmVTLfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUwHy0mAcOXiZBnYx3uISsvzbt/itf1sm7uaBTsSJb4=;
 b=kHo+4UR5FZxStgXSM+nqBYvQFwgTjGVVK8zTXtGICy/MqrT7EdPZDc/7VzaJrVIYllmwrFUYP5MWQ8tQJHi4odMfQyNHgPtfCo2x85SSEBECcXFUlEB37aY/rU7CnUH/lgv4KwKCu7D9eqcat4dHQlCzO6R1DJqoHCUpusv8KLg=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB4461.namprd10.prod.outlook.com (2603:10b6:a03:2d8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 01:05:35 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 01:05:35 +0000
Message-ID: <4fc43d0f-da9e-ce16-1f26-9f0225239b75@oracle.com>
Date: Tue, 14 Dec 2021 17:05:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: vdpa legacy guest support (was Re: [PATCH] vdpa/mlx5:
 set_features should allow reset to zero)
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
 <20210228163031-mutt-send-email-mst@kernel.org>
 <2cb51a6d-afa0-7cd1-d6f2-6b153186eaca@redhat.com>
 <20210302043419-mutt-send-email-mst@kernel.org>
 <178f8ea7-cebd-0e81-3dc7-10a058d22c07@redhat.com>
 <c9a0932f-a6d7-a9df-38ba-97e50f70c2b2@oracle.com>
 <20211212042311-mutt-send-email-mst@kernel.org>
 <ba9df703-29af-98a9-c554-f303ff045398@oracle.com>
 <20211214000245-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211214000245-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: BYAPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::46) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f69d72dd-54c1-4235-1653-08d9bf670042
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4461:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4461A0F02957F9A50EC3738EB1769@SJ0PR10MB4461.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQA7YsanEl9e1VbRA+V9KzL4GJjyZ1Wm6sZ4I01UzjHrfaD8dMjWu4jxO4LybtIftK9JAEc7VQhAEKXiAEE7w6YakjtdFUHyXHsOebK2+TpVvfACnB4CTEmlBokj0fChGaQWddEGud7e6HdF9R9nP0mx0Td/1hwiC13Cech5Wq8hYzfWsQMtzuFRv1FFUw+dJvcxsK3E0cV0T7txPdHkSnMWQ0bh1V9VLFD+VflvretkDkWF5nvTyFXtQej9ET6fwsegQEVD1NoZrqwdZkRgjyj8Ezlj8/yD0co2ukZS70xB96Ygeo/e1ye5stJSZe0eanuRdxEL8eaN8b0qujuvKdOBWJzOxS9dssgL1jZk1HEJ8xdMwPJfTuhQefdeUAhBxFDjtTXkWvIBGqziHNnHdUuWOp+er3yG6/RU/9y5C0TMbUd/RwHzfAq+IKp1BAHlL5LvKH3D/5T5PACy0xZnK3GlW31YFfKMWlASC42O4NdnM04PvBsbzQSluW/qA////CMuxtBF14uq7rZFeE7LF6u9NpWEMTcc0Q4p686qgyqug9n1IBz9z+D9rDgSy2VixEqSZoJlHCwkrARWO+5h+vlQL+fNs5gfAK+RlgEJnJEXpBI9lMph0bDi/4ZC8AKRx6BASBIzOxNwrkI0Bc58EBSN56PstO9nWXaO7nyBN42Zw8npIyTMPbL2xyRBLmuwlk7ArmeLUiE0e3dPGWg03hQsTVzy5wWdQ+HzLYa3+e5zN1x9XfXXaE1Utksx3vhQGPTjbiDX8bgsfQPtaJQ2GrGobBnPZ1KhUSHllJ1ukGuCUTL2CDPCX8WhpHV+7h9P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8936002)(38100700002)(53546011)(5660300002)(316002)(31686004)(6486002)(2906002)(36916002)(86362001)(31696002)(2616005)(186003)(6506007)(508600001)(6666004)(6512007)(966005)(8676002)(66476007)(66556008)(66946007)(6916009)(26005)(4326008)(83380400001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1l2TGxNQk40Ylk4aWo4YTg1ZHVjc3dZRVNLRkJUYU5qdi9ubGFhS0pMRmZ2?=
 =?utf-8?B?dmVqMjZOS3JUcHVjMSt3VEZ2STlUR2NiMVZ3c1hxZXFGYldjL0JzZVVRd3Vm?=
 =?utf-8?B?Rk9TTFdZNmQ1aTQzUklrNEg0ZVJOLytSNzVjYUxXNmZraTlTMEFjNHUxWDNv?=
 =?utf-8?B?TG04Wld3ZmMrMklxdit3K3NxM0Qvb3JOVTgxU2s0V3hraVh6MFZLM3o0ZUJt?=
 =?utf-8?B?QnRzOXdUejhBSmVIcDZjVDBieTUxQXpYY0NTREdDSlh6TFBQSG02QkhaL2Iw?=
 =?utf-8?B?T2IwZW5vQTVHcFJuMTdqTlE4UXFlTzRSTmFUdFpwcXh6TGsvN2FjTzBkbldM?=
 =?utf-8?B?QXJqQTFWT3paSVNpOWtPUm1DT0xrbzhRTGxVWmd1bEYzSzY2d0JqUk5zMTM0?=
 =?utf-8?B?aUdaTDcvSGNOeHZhZUdSZHRpVVN2a1lnMmJ0U28wVXhUSStHUGhwZTBLVXVM?=
 =?utf-8?B?ZXFDUFdJc1NDWWpDWkRya2ZERmloejJpTzZmYW5jUTN2SVNUZm8xSVI2QmVu?=
 =?utf-8?B?U3NxZEYwUEVIMTFDMUlxNTFiallBSjVCVGdWaVc3TktQaXJwN2Y4TEhFOTh1?=
 =?utf-8?B?Q2FSaDNlVy9IQ2xJUlF6UXg5L2xwUjFwVVd0NWtqZW5KaDhhWkw3ZmpmNzlJ?=
 =?utf-8?B?dkRTaXhhS2dqUVVCS0UrV294NVlPUWhvYi9KdE0zQWdaK1BVRjN3NjlmTGsv?=
 =?utf-8?B?THA2QUhKcFlCRmxGcTFzU3pRNUlIQVo3UFNDOW9pV0h4N0UwaktJSTZOdGQx?=
 =?utf-8?B?cC80SkhJZ1NDLzlXcHF4T210SE9mNmdzWDZtRG1oNGpzUVZINmVnRW4zT3o0?=
 =?utf-8?B?VXFHeHA3NjZNRHFycXlKZ3RaWUdGOTZVeE12NWwySWNKMk1aUEFIeFd5dFNa?=
 =?utf-8?B?dFZzYTFkYWFwMnY4ck92QyswMGU5UG52Vno3bGxxdVVSRHNabm9KcjhRVzc0?=
 =?utf-8?B?SFpOL1JnNFBJKzJZOHpJM3p1aHRCMnd1bWxpNUF2UWFnM2kwV01RVTJHUXF2?=
 =?utf-8?B?V1FoeW9QVnYreVRUQlJGVmZTV2NxcUdhTk1pRHNpRG5lcmYzdk52UHdJRzdW?=
 =?utf-8?B?MFZxZVA5L3BBWVpoL3ZOZStSVzdaSk1QbzFoQ0t0VzUxVndLaVFRc1B3eWpB?=
 =?utf-8?B?MWZlbktRb01PZlk5R1ZFUHY0YmVWclAxdEFSUjE4QTZYODFrUVJXNHJVYWpv?=
 =?utf-8?B?eE4yak85NzdYeGZ3d0RBRkxjVGNCL2dJd1RnWnJkNXNKTnl6TTVRSWxocjRI?=
 =?utf-8?B?dHhFNzFudTFuVThUbm9Qdi80bmtOWWNTdC8ybDdGejRramZieE40V21kbTkw?=
 =?utf-8?B?d1k1ZDE4RlZybzBudGRBVWFBYlpxZkpKK240N0lHR3lRMTREZ2daTGs2Y2FN?=
 =?utf-8?B?Rkl4N0V6WkZVVEwyaFBzR1BDWmVhNFBxNGNqV3VpWHJMeDBoY0dIOUo5Y3VT?=
 =?utf-8?B?REladlVJVWQyVXYyQkpQN3EvQ2lkTmNBZHhZNHhHbVZIeXJ4SE9uMUtnUkdk?=
 =?utf-8?B?SzFhMm1sV0NvVW84bC9NdXZjdUhhOFdtMEtyR29lQVBQcjhhalMzWXJST1Ex?=
 =?utf-8?B?MlMweG53MkRKWGppeEFCdVExQTFnU1pBV1M0Rk56bVB4K2pqRU9EL1AyUWFW?=
 =?utf-8?B?cjNyWXJFR0s1NVFhaHUxdnJOMHN6eG1HN0xXSTdUanhvVXYwZ3c4SFEwNU12?=
 =?utf-8?B?ZTdyWkVBM0ZBQVo3SzMyb1dudVd2SXQwV2VkOXpFUDRjdEN2L25hRFhHTE5F?=
 =?utf-8?B?OWQ4R2lRd3dLeXNOcVFUWFl1MG1ockN5NE8vRGlpaVI2Vzk1TkV3UnNlSzBt?=
 =?utf-8?B?Uk9obEwxS2R4Q3RQUGJSa3oxd2plTkxIZVNqeXg5cGRWL2ljV2NTd1ZnNERN?=
 =?utf-8?B?RldQbk1HbXhBdURKRWwwcElpTG1JV3Ayc2tHWXB0MlltNytPN2tuYVl2dlBB?=
 =?utf-8?B?ZkovME1MUEdsZjkzNEhyU3lCOUVpT0R3T0Z1RlpoYU1LdWtMRTd2cVE5cFp2?=
 =?utf-8?B?RUNWTENNSFlySXhYVkVvdktVOEtSbHM1NFoyZFByYTJWOWRkWE40S3RrcHhz?=
 =?utf-8?B?NTRjeENDZFZvaXdVQmNMczBZaXdGVFlFcDFodVlXV2VaV1pDN3lGaGl0L04v?=
 =?utf-8?B?THNUOHptcnY3VEErdFg3NE5oU2hKSHRCOHJneWRTMU82cTY4NTQzTlFsZ3p1?=
 =?utf-8?Q?yk2fDpv3R8JwvA90FJ5ekMc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69d72dd-54c1-4235-1653-08d9bf670042
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 01:05:35.8066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mzmrbg8xEf+7QZUdEniet7f9Y1xs3iZb78TFKUNTYzHEsPhA0FjI7HPnKdGEJSBZzXIU8drf/KBpxFtirKQaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4461
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10198
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112150004
X-Proofpoint-ORIG-GUID: 9-KGYoexQmnsISzNiSltgXvLsvjlMz-y
X-Proofpoint-GUID: 9-KGYoexQmnsISzNiSltgXvLsvjlMz-y
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elic@nvidia.com, linux-kernel@vger.kernel.org
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

CgpPbiAxMi8xMy8yMDIxIDk6MDYgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBN
b24sIERlYyAxMywgMjAyMSBhdCAwNTo1OTo0NVBNIC0wODAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+
Pgo+PiBPbiAxMi8xMi8yMDIxIDE6MjYgQU0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+
IE9uIEZyaSwgRGVjIDEwLCAyMDIxIGF0IDA1OjQ0OjE1UE0gLTA4MDAsIFNpLVdlaSBMaXUgd3Jv
dGU6Cj4+Pj4gU29ycnkgZm9yIHJldml2aW5nIHRoaXMgYW5jaWVudCB0aHJlYWQuIEkgd2FzIGtp
bmRhIGxvc3QgZm9yIHRoZSBjb25jbHVzaW9uCj4+Pj4gaXQgZW5kZWQgdXAgd2l0aC4gSSBoYXZl
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zLAo+Pj4+Cj4+Pj4gMS4gbGVnYWN5IGd1ZXN0IHN1cHBv
cnQ6IGZyb20gdGhlIHBhc3QgY29udmVyc2F0aW9ucyBpdCBkb2Vzbid0IHNlZW0gdGhlCj4+Pj4g
c3VwcG9ydCB3aWxsIGJlIGNvbXBsZXRlbHkgZHJvcHBlZCBmcm9tIHRoZSB0YWJsZSwgaXMgbXkg
dW5kZXJzdGFuZGluZwo+Pj4+IGNvcnJlY3Q/IEFjdHVhbGx5IHdlJ3JlIGludGVyZXN0ZWQgaW4g
c3VwcG9ydGluZyB2aXJ0aW8gdjAuOTUgZ3Vlc3QgZm9yIHg4NiwKPj4+PiB3aGljaCBpcyBiYWNr
ZWQgYnkgdGhlIHNwZWMgYXQKPj4+PiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6
Ly9vemxhYnMub3JnLypydXN0eS92aXJ0aW8tc3BlYy92aXJ0aW8tMC45LjUucGRmX187ZmchIUFD
V1Y1TjlNMlJWOTloUSFkVEttekp3d1JzRk03QnRTdVREdTFjTmx5NW40WENvdEgwV1ltaWR6R3FI
U1h0NDBpN1pVNDNVY05nN0dZeFpnJCAuIFRob3VnaCBJJ20gbm90IHN1cmUKPj4+PiBpZiB0aGVy
ZSdzIHJlcXVlc3QvbmVlZCB0byBzdXBwb3J0IHdpbGRlciBsZWdhY3kgdmlydGlvIHZlcnNpb25z
IGVhcmxpZXIKPj4+PiBiZXlvbmQuCj4+PiBJIHBlcnNvbmFsbHkgZmVlbCBpdCdzIGxlc3Mgd29y
ayB0byBhZGQgaW4ga2VybmVsIHRoYW4gdHJ5IHRvCj4+PiB3b3JrIGFyb3VuZCBpdCBpbiB1c2Vy
c3BhY2UuIEphc29uIGZlZWxzIGRpZmZlcmVudGx5Lgo+Pj4gTWF5YmUgcG9zdCB0aGUgcGF0Y2hl
cyBhbmQgdGhpcyB3aWxsIHByb3ZlIHRvIEphc29uIGl0J3Mgbm90Cj4+PiB0b28gdGVycmlibGU/
Cj4+IEkgc3VwcG9zZSBpZiB0aGUgdmRwYSB2ZW5kb3IgZG9lcyBzdXBwb3J0IDAuOTUgaW4gdGhl
IGRhdGFwYXRoIGFuZCByaW5nCj4+IGxheW91dCBsZXZlbCBhbmQgaXMgbGltaXRlZCB0byB4ODYg
b25seSwgdGhlcmUgc2hvdWxkIGJlIGVhc3kgd2F5IG91dC4KPiBOb3RlIGEgc3VidGxlIGRpZmZl
cmVuY2U6IHdoYXQgbWF0dGVycyBpcyB0aGF0IGd1ZXN0LCBub3QgaG9zdCBpcyB4ODYuCj4gTWF0
dGVycyBmb3IgZW11bGF0b3JzIHdoaWNoIG1pZ2h0IHJlb3JkZXIgbWVtb3J5IGFjY2Vzc2VzLgo+
IEkgZ3Vlc3MgdGhpcyBlbmZvcmNlbWVudCBiZWxvbmdzIGluIFFFTVUgdGhlbj8KUmlnaHQsIEkg
bWVhbiB0byBnZXQgc3RhcnRlZCwgdGhlIGluaXRpYWwgZ3Vlc3QgZHJpdmVyIHN1cHBvcnQgYW5k
IHRoZSAKY29ycmVzcG9uZGluZyBRRU1VIHN1cHBvcnQgZm9yIHRyYW5zaXRpb25hbCB2ZHBhIGJh
Y2tlbmQgY2FuIGJlIGxpbWl0ZWQgCnRvIHg4NiBndWVzdC9ob3N0IG9ubHkuIFNpbmNlIHRoZSBj
b25maWcgc3BhY2UgaXMgZW11bGF0ZWQgaW4gUUVNVSwgSSAKc3VwcG9zZSBpdCdzIG5vdCBoYXJk
IHRvIGVuZm9yY2UgaW4gUUVNVS4gUUVNVSBjYW4gZHJpdmUgR0VUX0xFR0FDWSwgCkdFVF9FTkRJ
QU4gZXQgYWwgaW9jdGxzIGluIGFkdmFuY2UgdG8gZ2V0IHRoZSBjYXBhYmlsaXR5IGZyb20gdGhl
IAppbmRpdmlkdWFsIHZlbmRvciBkcml2ZXIuIEZvciB0aGF0LCB3ZSBuZWVkIGFub3RoZXIgbmVn
b3RpYXRpb24gcHJvdG9jb2wgCnNpbWlsYXIgdG8gdmhvc3RfdXNlcidzIHByb3RvY29sX2ZlYXR1
cmVzIGJldHdlZW4gdGhlIHZkcGEga2VybmVsIGFuZCAKUUVNVSwgd2F5IGJlZm9yZSB0aGUgZ3Vl
c3QgZHJpdmVyIGlzIGV2ZXIgcHJvYmVkIGFuZCBpdHMgZmVhdHVyZSAKbmVnb3RpYXRpb24ga2lj
a3MgaW4uIE5vdCBzdXJlIHdlIG5lZWQgYSBHRVRfTUVNT1JZX09SREVSIGlvY3RsIGNhbGwgCmZy
b20gdGhlIGRldmljZSwgYnV0IHdlIGNhbiBhc3N1bWUgd2VhayBvcmRlcmluZyBmb3IgbGVnYWN5
IGF0IHRoaXMgCnBvaW50ICh4ODYgb25seSk/Cgo+Cj4+IEkKPj4gY2hlY2tlZCB3aXRoIEVsaSBh
bmQgb3RoZXIgTWVsbGFub3gvTlZESUEgZm9sa3MgZm9yIGhhcmR3YXJlL2Zpcm13YXJlIGxldmVs
Cj4+IDAuOTUgc3VwcG9ydCwgaXQgc2VlbXMgYWxsIHRoZSBpbmdyZWRpZW50IGhhZCBiZWVuIHRo
ZXJlIGFscmVhZHkgZGF0ZWQgYmFjawo+PiB0byB0aGUgRFBESyBkYXlzLiBUaGUgb25seSBtYWpv
ciB0aGluZyBsaW1pdGluZyBpcyBpbiB0aGUgdkRQQSBzb2Z0d2FyZSB0aGF0Cj4+IHRoZSBjdXJy
ZW50IHZkcGEgY29yZSBoYXMgdGhlIGFzc3VtcHRpb24gYXJvdW5kIFZJUlRJT19GX0FDQ0VTU19Q
TEFURk9STSBmb3IKPj4gYSBmZXcgRE1BIHNldHVwIG9wcywgd2hpY2ggaXMgdmlydGlvIDEuMCBv
bmx5Lgo+Pgo+Pj4+IDIuIHN1cHBvc2Ugc29tZSBmb3JtIG9mIGxlZ2FjeSBndWVzdCBzdXBwb3J0
IG5lZWRzIHRvIGJlIHRoZXJlLCBob3cgZG8gd2UKPj4+PiBkZWFsIHdpdGggdGhlIGJvZ3VzIGFz
c3VtcHRpb24gYmVsb3cgaW4gdmRwYV9nZXRfY29uZmlnKCkgaW4gdGhlIHNob3J0IHRlcm0/Cj4+
Pj4gSXQgbG9va3Mgb25lIG9mIHRoZSBpbnR1aXRpdmUgZml4IGlzIHRvIG1vdmUgdGhlIHZkcGFf
c2V0X2ZlYXR1cmVzIGNhbGwgb3V0Cj4+Pj4gb2YgdmRwYV9nZXRfY29uZmlnKCkgdG8gdmRwYV9z
ZXRfY29uZmlnKCkuCj4+Pj4KPj4+PiAgIMKgwqDCoMKgwqDCoMKgIC8qCj4+Pj4gICDCoMKgwqDC
oMKgwqDCoMKgICogQ29uZmlnIGFjY2Vzc2VzIGFyZW4ndCBzdXBwb3NlZCB0byB0cmlnZ2VyIGJl
Zm9yZSBmZWF0dXJlcyBhcmUKPj4+PiBzZXQuCj4+Pj4gICDCoMKgwqDCoMKgwqDCoMKgICogSWYg
aXQgZG9lcyBoYXBwZW4gd2UgYXNzdW1lIGEgbGVnYWN5IGd1ZXN0Lgo+Pj4+ICAgwqDCoMKgwqDC
oMKgwqDCoCAqLwo+Pj4+ICAgwqDCoMKgwqDCoMKgwqAgaWYgKCF2ZGV2LT5mZWF0dXJlc192YWxp
ZCkKPj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2ZHBhX3NldF9mZWF0dXJl
cyh2ZGV2LCAwKTsKPj4+PiAgIMKgwqDCoMKgwqDCoMKgIG9wcy0+Z2V0X2NvbmZpZyh2ZGV2LCBv
ZmZzZXQsIGJ1ZiwgbGVuKTsKPj4+Pgo+Pj4+IEkgY2FuIHBvc3QgYSBwYXRjaCB0byBmaXggMikg
aWYgdGhlcmUncyBjb25zZW5zdXMgYWxyZWFkeSByZWFjaGVkLgo+Pj4+Cj4+Pj4gVGhhbmtzLAo+
Pj4+IC1TaXdlaQo+Pj4gSSdtIG5vdCBzdXJlIGhvdyBpbXBvcnRhbnQgaXQgaXMgdG8gY2hhbmdl
IHRoYXQuCj4+PiBJbiBhbnkgY2FzZSBpdCBvbmx5IGFmZmVjdHMgdHJhbnNpdGlvbmFsIGRldmlj
ZXMsIHJpZ2h0Pwo+Pj4gTGVnYWN5IG9ubHkgc2hvdWxkIG5vdCBjYXJlIC4uLgo+PiBZZXMgSSdk
IGxpa2UgdG8gZGlzdGluZ3Vpc2ggbGVnYWN5IGRyaXZlciAoc3VwcG9zZSBpdCBpcyAwLjk1KSBh
Z2FpbnN0IHRoZQo+PiBtb2Rlcm4gb25lIGluIGEgdHJhbnNpdGlvbmFsIGRldmljZSBtb2RlbCBy
YXRoZXIgdGhhbiBiZWluZyBsZWdhY3kgb25seS4KPj4gVGhhdCB3YXkgYSB2MC45NSBhbmQgdjEu
MCBzdXBwb3J0aW5nIHZkcGEgcGFyZW50IGNhbiBzdXBwb3J0IGJvdGggdHlwZXMgb2YKPj4gZ3Vl
c3RzIHdpdGhvdXQgaGF2aW5nIHRvIHJlY29uZmlndXJlLiBPciBhcmUgeW91IHN1Z2dlc3Rpbmcg
bGltaXQgdG8gbGVnYWN5Cj4+IG9ubHkgYXQgdGhlIHRpbWUgb2YgdmRwYSBjcmVhdGlvbiB3b3Vs
ZCBzaW1wbGlmeSB0aGUgaW1wbGVtZW50YXRpb24gYSBsb3Q/Cj4+Cj4+IFRoYW5rcywKPj4gLVNp
d2VpCj4KPiBJIGRvbid0IGtub3cgZm9yIHN1cmUuIFRha2UgYSBsb29rIGF0IHRoZSB3b3JrIEhh
bGlsIHdhcyBkb2luZwo+IHRvIHRyeSBhbmQgc3VwcG9ydCB0cmFuc2l0aW9uYWwgZGV2aWNlcyB3
aXRoIEJFIGd1ZXN0cy4KSG1tbSwgd2UgY2FuIGhhdmUgdGhvc2UgZW5kaWFubmVzcyBpb2N0bHMg
ZGVmaW5lZCBidXQgdGhlIGluaXRpYWwgUUVNVSAKaW1wbGVtZW50YXRpb24gY2FuIGJlIHN0YXJ0
ZWQgdG8gc3VwcG9ydCB4ODYgZ3Vlc3QvaG9zdCB3aXRoIGxpdHRsZSAKZW5kaWFuIGFuZCB3ZWFr
IG1lbW9yeSBvcmRlcmluZyBmaXJzdC4gVGhlIHJlYWwgdHJpY2sgaXMgdG8gZGV0ZWN0IApsZWdh
Y3kgZ3Vlc3QgLSBJIGFtIG5vdCBzdXJlIGlmIGl0J3MgZmVhc2libGUgdG8gc2hpZnQgYWxsIHRo
ZSBsZWdhY3kgCmRldGVjdGlvbiB3b3JrIHRvIFFFTVUsIG9yIHRoZSBrZXJuZWwgaGFzIHRvIGJl
IHBhcnQgb2YgdGhlIGRldGVjdGlvbiAKKGUuZy4gdGhlIGtpY2sgYmVmb3JlIERSSVZFUl9PSyB0
aGluZyB3ZSBoYXZlIHRvIGR1cGxpY2F0ZSB0aGUgdHJhY2tpbmcgCmVmZm9ydCBpbiBRRU1VKSBh
cyB3ZWxsLiBMZXQgbWUgdGFrZSBhIGZ1cnRoZXIgbG9vayBhbmQgZ2V0IGJhY2suCgpNZWFud2hp
bGUsIEknbGwgY2hlY2sgaW50ZXJuYWxseSB0byBzZWUgaWYgYSBsZWdhY3kgb25seSBtb2RlbCB3
b3VsZCAKd29yay4gVGhhbmtzLgoKVGhhbmtzLAotU2l3ZWkKCgo+Cj4KPj4+PiBPbiAzLzIvMjAy
MSAyOjUzIEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+PiBPbiAyMDIxLzMvMiA1OjQ3IOS4i+WN
iCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4+Pj4gT24gTW9uLCBNYXIgMDEsIDIwMjEg
YXQgMTE6NTY6NTBBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+PiBPbiAyMDIxLzMv
MSA1OjM0IOS4iuWNiCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4+Pj4+PiBPbiBXZWQs
IEZlYiAyNCwgMjAyMSBhdCAxMDoyNDo0MUFNIC0wODAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+Pj4+
Pj4+Pj4+IERldGVjdGluZyBpdCBpc24ndCBlbm91Z2ggdGhvdWdoLCB3ZSB3aWxsIG5lZWQgYSBu
ZXcgaW9jdGwgdG8gbm90aWZ5Cj4+Pj4+Pj4+Pj4gdGhlIGtlcm5lbCB0aGF0IGl0J3MgYSBsZWdh
Y3kgZ3Vlc3QuIFVnaCA6KAo+Pj4+Pj4+Pj4gV2VsbCwgYWx0aG91Z2ggSSB0aGluayBhZGRpbmcg
YW4gaW9jdGwgaXMgZG9hYmxlLCBtYXkgSQo+Pj4+Pj4+Pj4ga25vdyB3aGF0IHRoZSB1c2UKPj4+
Pj4+Pj4+IGNhc2UgdGhlcmUgd2lsbCBiZSBmb3Iga2VybmVsIHRvIGxldmVyYWdlIHN1Y2ggaW5m
bwo+Pj4+Pj4+Pj4gZGlyZWN0bHk/IElzIHRoZXJlIGEKPj4+Pj4+Pj4+IGNhc2UgUUVNVSBjYW4n
dCBkbyB3aXRoIGRlZGljYXRlIGlvY3RscyBsYXRlciBpZiB0aGVyZSdzIGluZGVlZAo+Pj4+Pj4+
Pj4gZGlmZmVyZW50aWF0aW9uIChsZWdhY3kgdi5zLiBtb2Rlcm4pIG5lZWRlZD8KPj4+Pj4+Pj4g
QlRXIGEgZ29vZCBBUEkgY291bGQgYmUKPj4+Pj4+Pj4KPj4+Pj4+Pj4gI2RlZmluZSBWSE9TVF9T
RVRfRU5ESUFOIF9JT1coVkhPU1RfVklSVElPLCA/LCBpbnQpCj4+Pj4+Pj4+ICNkZWZpbmUgVkhP
U1RfR0VUX0VORElBTiBfSU9XKFZIT1NUX1ZJUlRJTywgPywgaW50KQo+Pj4+Pj4+Pgo+Pj4+Pj4+
PiB3ZSBkaWQgaXQgcGVyIHZyaW5nIGJ1dCBtYXliZSB0aGF0IHdhcyBhIG1pc3Rha2UgLi4uCj4+
Pj4+Pj4gQWN0dWFsbHksIEkgd29uZGVyIHdoZXRoZXIgaXQncyBnb29kIHRpbWUgdG8ganVzdCBu
b3Qgc3VwcG9ydAo+Pj4+Pj4+IGxlZ2FjeSBkcml2ZXIKPj4+Pj4+PiBmb3IgdkRQQS4gQ29uc2lk
ZXI6Cj4+Pj4+Pj4KPj4+Pj4+PiAxKSBJdCdzIGRlZmluaXRpb24gaXMgbm8tbm9ybWF0aXZlCj4+
Pj4+Pj4gMikgQSBsb3Qgb2YgYnVkcmVuIG9mIGNvZGVzCj4+Pj4+Pj4KPj4+Pj4+PiBTbyBxZW11
IGNhbiBzdGlsbCBwcmVzZW50IHRoZSBsZWdhY3kgZGV2aWNlIHNpbmNlIHRoZSBjb25maWcKPj4+
Pj4+PiBzcGFjZSBvciBvdGhlcgo+Pj4+Pj4+IHN0dWZmcyB0aGF0IGlzIHByZXNlbnRlZCBieSB2
aG9zdC12RFBBIGlzIG5vdCBleHBlY3RlZCB0byBiZQo+Pj4+Pj4+IGFjY2Vzc2VkIGJ5Cj4+Pj4+
Pj4gZ3Vlc3QgZGlyZWN0bHkuIFFlbXUgY2FuIGRvIHRoZSBlbmRpYW4gY29udmVyc2lvbiB3aGVu
IG5lY2Vzc2FyeQo+Pj4+Pj4+IGluIHRoaXMKPj4+Pj4+PiBjYXNlPwo+Pj4+Pj4+Cj4+Pj4+Pj4g
VGhhbmtzCj4+Pj4+Pj4KPj4+Pj4+IE92ZXJhbGwgSSB3b3VsZCBiZSBmaW5lIHdpdGggdGhpcyBh
cHByb2FjaCBidXQgd2UgbmVlZCB0byBhdm9pZCBicmVha2luZwo+Pj4+Pj4gd29ya2luZyB1c2Vy
c3BhY2UsIHFlbXUgcmVsZWFzZXMgd2l0aCB2ZHBhIHN1cHBvcnQgYXJlIG91dCB0aGVyZSBhbmQK
Pj4+Pj4+IHNlZW0gdG8gd29yayBmb3IgcGVvcGxlLiBBbnkgY2hhbmdlcyBuZWVkIHRvIHRha2Ug
dGhhdCBpbnRvIGFjY291bnQKPj4+Pj4+IGFuZCBkb2N1bWVudCBjb21wYXRpYmlsaXR5IGNvbmNl
cm5zLgo+Pj4+PiBBZ3JlZSwgbGV0IG1lIGNoZWNrLgo+Pj4+Pgo+Pj4+Pgo+Pj4+Pj4gICDCoCBJ
IG5vdGUgdGhhdCBhbnkgaGFyZHdhcmUKPj4+Pj4+IGltcGxlbWVudGF0aW9uIGlzIGFscmVhZHkg
YnJva2VuIGZvciBsZWdhY3kgZXhjZXB0IG9uIHBsYXRmb3JtcyB3aXRoCj4+Pj4+PiBzdHJvbmcg
b3JkZXJpbmcgd2hpY2ggbWlnaHQgYmUgaGVscGZ1bCBpbiByZWR1Y2luZyB0aGUgc2NvcGUuCj4+
Pj4+IFllcy4KPj4+Pj4KPj4+Pj4gVGhhbmtzCj4+Pj4+Cj4+Pj4+CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
