Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097DECA0EC3
	for <virtualization@archiver.kernel.org>; Mon, 11 Sep 2023 23:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C54781765;
	Mon, 11 Sep 2023 23:31:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C54781765
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=2QC8MjeK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=ZWNbXVKX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iXo2BbOtSIwa; Mon, 11 Sep 2023 23:31:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DDC70813FF;
	Mon, 11 Sep 2023 23:31:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDC70813FF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD2AAC0071;
	Mon, 11 Sep 2023 23:31:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28C1FC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 23:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E661E40328
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 23:31:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E661E40328
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=2QC8MjeK; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=ZWNbXVKX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6scw7aD0OG8N
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 23:31:22 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB45A40316
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 23:31:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB45A40316
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38BJat2e011489; Mon, 11 Sep 2023 23:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RSXjVqccP6wbw7QoTSGYIDJKSAhzed2C0d1b7OZnhtI=;
 b=2QC8MjeKCs/5QeluOLxjqFyA4NhbEpWSpT9xw28u7wEXBYCcGct1I8l/+cqvHzXCRulL
 B0/QEo3PfXL9PlYwtUD2ujFvhtJDRXqR1xuCf+rybcWDcWBweuD/2DytRuxnikO3+QGL
 a0+A/Snx3bq1cxltAURbQuqfppvzjz+gKttLfaKdKHz7BIfzoa7LnjtavVIN+jMiEOUc
 EoO5XW9xsojTCMLMK7Fs5bleqgmHQjnHj7003UE/rmQRYTI2BBDH3A16SDaZDZiiTus5
 5XItWVP9PCBq4AdXV5YMUjDvo4E7Q15hmrIY6Pg/fw9RSDMqQqRgU2nzzrqAqgvkLTVK fQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jhqaq2c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Sep 2023 23:31:18 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38BM9SZc004466; Mon, 11 Sep 2023 23:31:17 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0f55pa47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Sep 2023 23:31:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHZDkdbO6mY2ePuZArYZ8nctdbeLX1djsFoVsjHJ3i2oIT5qObVM/GHGKi5zIAR683Wi/m6uzSN4ay0NiQ9M3Q0mtlK9G15aNTm8BFxUMxNJt27C4UJAZ8g0NKalZTbwQeq6Uq2JPgIkU1I0M2OOzOK2B5oupuNJvDcoJY0qsyGG3TSd4nOF7zSJRArKkm334HMRQbFHIKShol0Xj8QgXy79/aPX2LM4eWtZWboP2Ya6r9qr1saSIdPwgpBdmXXn4MmXhAeo3X6I9XEJ3x7kTO8ojJfnPVkdpSqIQT2m9MO4sZqb27gSz9mrVL0853D6V5el5MdEyJN13CGb8r+RNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSXjVqccP6wbw7QoTSGYIDJKSAhzed2C0d1b7OZnhtI=;
 b=autq0J4In2HV2Cb8AAKcA+Z7TR70a/ZlfwILXFjRnY4+/3BkfFxGFwdkHjXKP2Ps8ZOfHdl5Vsrgv2hR3FvOg6UQ7AX10aoiYGtjX45O/ntQgeRyhmPuJv16VfpwRV2eipCVd7Mn/LuZdiK+jpkDPvVAYxY4hzF2GlKuzJyC4c47aXD/ZzOmFkbHagL5BFpb7i/iap7bsqA2x1KizueRy0yBs+d7VP1eQADM09bVY3CshpC87tdEm8kc195DlQ+ZQ/N77B/psJArbQRt1J2f6m7f+nNO+FCbpvLWXM0v6zngFRNLYf5631AhqBya/AZRNFegtzG98/621aJoevE3PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSXjVqccP6wbw7QoTSGYIDJKSAhzed2C0d1b7OZnhtI=;
 b=ZWNbXVKXOZQx8gw3ZrNxTZ2mR/Lfy3EbU8y2rVFID556vBbcLu/mneq/cGS+knAttBEHqUA2n9AAlo34+1TeBxnSoRFtbp8RWDjCARAakOvQ7YnyT9mmouRcrF+wShyfLrG+z+mCmgLMdwChScNaJggcQYP0Zfz9S1CN/1isWeY=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH7PR10MB6060.namprd10.prod.outlook.com (2603:10b6:510:1fc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Mon, 11 Sep
 2023 23:31:15 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8%3]) with mapi id 15.20.6745.035; Mon, 11 Sep 2023
 23:31:15 +0000
Message-ID: <c73cf75a-00bd-a0d9-90cf-7ad3ab76977c@oracle.com>
Date: Mon, 11 Sep 2023 16:31:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RFC v2 1/4] vdpa: introduce .reset_map operation callback
To: Jason Wang <jasowang@redhat.com>
References: <1694266319-32287-1-git-send-email-si-wei.liu@oracle.com>
 <1694266319-32287-2-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEsACZcKQr9BGB0FzqJQbpfu9QTsh3hTxLaJ72on+3pK7w@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEsACZcKQr9BGB0FzqJQbpfu9QTsh3hTxLaJ72on+3pK7w@mail.gmail.com>
X-ClientProxiedBy: SN7PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:806:121::30) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH7PR10MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: e123c6eb-00f4-47e0-e070-08dbb31f310c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EA0BHRNshELZrCKGWAKrANRGpe8vjEzsrMmqbCbkJVwfjHIPVh2h07Qx7uwKj+N/3pn1s5DPM8d6fKzB8bwR1W4/xlU2PFhOmqWKCbaCT5MbjjiVyVd/Euj3tO9E8kxTYdw1cIuLwQxnm6Fp6207Mmn4lmwwAxnNXjOX7Pc8YqxW5vFMTLZN1ivvFx8qd/sw0a/m2dxbXRQln18GUJjEw3W1RNsupjsfTvZD8ujJ5VHXDLZqMQz/M/katSw58/fc0OhymLQsio9WMa8a/dUV3mLRIkY8IXvuN4oz6OOnnFRUwxwrov6sOnLyEKNan3XRHCl1HZg/db9OOfgtvdKwMWiNbLplmD7aoijHjoIaznI/6Tfg2lw/JuZqmkCtaLD1z1944gpAi1cHITFDKacrAsSecz6dLXz8Bgnp/cx+qRu/QbAj8pgphib09wh3IgjjRdCl2E9W8Oj8hpurkisyR0zOVQLCaSkH0k9OilMAJi8gWVBZZTH9flH/eDYVEHwdlorfbcDl5+P14uxO8PmNM3MNjrL1OVfRRLqJwGh7pZT3SAY8tyq2tAxWRQsUdPnZ5Lk1LkeoQOIcZiqwkbPSUCwys3zw5nbBH+rYFNOWPKH9kNmIigeF9Z9OPqjdhv1nkpU7GsLHYbv+odaVVy61lnkZ8viVVEWd2GFSn/wqaim0u240VPGvfHTYtE7EO7LJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(346002)(396003)(136003)(186009)(1800799009)(451199024)(36916002)(6666004)(6506007)(6486002)(53546011)(6512007)(83380400001)(2616005)(2906002)(26005)(478600001)(66476007)(6916009)(66556008)(66946007)(5660300002)(4326008)(8676002)(8936002)(316002)(36756003)(86362001)(31696002)(38100700002)(31686004)(41300700001)(66899024)(142923001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dElkMUpaWnVJOWlyRWFZK0pTZGJqWWJYSXN0M2dad1JZdnZsTGtBeEdlYWc5?=
 =?utf-8?B?WEZnSng1SXN5Z29jWG81OGc1eXdJSGJ6amVPaTNxR2Y3Ni8zRFkwcjVTYXhM?=
 =?utf-8?B?UUxhb3pNcjg0dHloSnc4emZjL1dkcGtwMVVDOHk3ZFZHY29oNHZqd3lMbmxQ?=
 =?utf-8?B?V1RmbGNuQnFjaThlVWQvaGtISXAzSzVDeThOTDMyTG03QWlFbjRMQ2xwbXRl?=
 =?utf-8?B?M0VBd1plTmpUZk9IaVkvMmtzcVAwK09GUGZIZUs5RDhWS0ErSDZqWmQ1VzdN?=
 =?utf-8?B?eUpCeXdlWXJJaVg5NnN2eTJvM2JIVXU4VlZMSG4yUkY3WHU4TDlWbVAxMy9k?=
 =?utf-8?B?SFhDOW9UdUo0anRyODl4NG9qenJUYVRZbGVSR0JLSkhnQWVZRVhhbkYwTTg2?=
 =?utf-8?B?RzZoL3JuMHdQVzI4RlpSbU9RSk9wT1Fndm9DYmhLL21kdmFHTXZRcS9QMW92?=
 =?utf-8?B?K1FzVUJjN1NTclQxRTNRV01wRFljTEd0cDR1em5PaElQUFc3NW5jcC9nZkgr?=
 =?utf-8?B?aUF3dmg2aFhGQ2JJUm1XMXRUQ05MdTR3L3M5QS9WSzhIYk1WSDhZTkNpYkRi?=
 =?utf-8?B?OCtBZVdiblk3RVloKzFpWnU4Yy9QZjNsdS9XdE1SZlMrZGthbXdRR2pidm1s?=
 =?utf-8?B?bnNYNXIzaGpzVlY2cXVSR1VCdU5IUCtTWXQ3V1paQnhJazVIeTFVSW10QlZC?=
 =?utf-8?B?Sk10QTVia2NvdGU1U242bUFYa25GZFB2WDVhOXUrUzhHWDh2c3hTUFROc1hY?=
 =?utf-8?B?ZG9keHEvTEd0UFYyQnBrYkZWY1FaZlo3VFllUjJ4SllZb1RFVWM4RSt2ZUtn?=
 =?utf-8?B?aFdyb0QxKzhaa2tPc1JhU2Qrb0tzVjFiZVc2YzU2K2xKVmExZmx5ZzVuTDNw?=
 =?utf-8?B?S0t6bTBOc3lUVHpGdzNSMWdDak4zS1l0NXdIWTY2RU0rRURaYjNTbUUrd1Jl?=
 =?utf-8?B?R2RpTGJ2MWlseUdOQ3d5RFJSVnhBU0dsWTY3UmRlK3BhNzFIZGEvdFY3V2M0?=
 =?utf-8?B?SDR2Q2Q2NHFudkR0clIzbW82SG94SmI3ZzBuQlFMN2lqOGRoWC9zclpIT3Jz?=
 =?utf-8?B?WDNRT2owd3B5ZFZiTFliQXlCdGdCQXoxWUFVV1dxb2hNL3Rzek1oeTAwTmIw?=
 =?utf-8?B?a05lTEl2UzVaZ0o1SkpiVlVuSm5sUEhWV0lGa0VySVBFYjEwZnhlTHpPYjRF?=
 =?utf-8?B?VC85ajAzV0pWTkNtRkRvamJkN0FoNkJCcCs2YUtzQThuNXZlQlg3L1NqaTVw?=
 =?utf-8?B?QUNySHZhbXF5cXN1eFpiWUVSTlZzN2lyY2VKbDlCZmRFWXpHVnh2NlRoWXBW?=
 =?utf-8?B?RUc4YmZIckN6RnVVWVFPU2lIRnJNMFpaRUhUTExzUXNyZERhdC81UVFnWHhJ?=
 =?utf-8?B?OVlBMVdDc2RIVVBhN3c5NVoxakhzTFk4MElnZjRuSmVtVWhySk94Nmpya21z?=
 =?utf-8?B?SWc2SmgwdXQvUEQveTdUa2FleldvQXIvK0NmSktZUC9WRDFLd2NZaVB5WFB2?=
 =?utf-8?B?bzQ0bWoxZytXWStoYVFWODJmQzg5TkVKUXpNSGdJcFQzaWQrd3lGU25qOHZK?=
 =?utf-8?B?Nmp1TkowcnVLKzQrTlBwTjlYTlhxMG9LbS9hVUNYT1AxaVpNU0JUWnJETTAy?=
 =?utf-8?B?WWwwUmJLU0kydEFuVEdkQzdGYTA1ZDgyR0s0ZlNVd1RnUlNsbEdYdWc2bDBN?=
 =?utf-8?B?NW5wOGZDaGZpOXJtSzV0REMyclBVYkE1YWpncGxzU2JIWkZxcWo3TzBJcjRi?=
 =?utf-8?B?aVozNnFneEd0YUhOQ2huTkVhYkxFZXVwUTVRdGYxRFMyMUIzb1hZUDlFS25k?=
 =?utf-8?B?cUQzT3czY2wrUDI2MWNtSkIra1IvV0ZHbUNCTjFLbEc0NmVWU1JhRXlabmd1?=
 =?utf-8?B?VnR6d1ZNek8zcEZWOW9vb0dWT0hKSnhEOVZPcEd2aUVTSkJpVEl0WnJSdGxI?=
 =?utf-8?B?VGp5a3pvZk12SDlmY2hHT2xoN1R0c3lnNEdIWFJsdWd4WkFQQnFRL2JFbDVl?=
 =?utf-8?B?eERkSVdzajJ6a1ZPcjRSeVkrSXFqMHdTWnBxYzU2Vlk5KzFMM3BySHZ4NHVx?=
 =?utf-8?B?UHRoYVRMWGJPNzNIdS9oY0pGMmtBdE9JNXg1eDBFR0MrdnEya0Q4bTkxeFQ2?=
 =?utf-8?Q?WIZS9Oj6fWRlubP1RPgLuuWMu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6VwwkH93sgTwlk9nVFnndfrJlquORHMG7FygxlOiPsNFPVkNjf+xgJ1fSk7BBlQbWKGvREkhTXknDqUqbKC0NG85T+JGg/PyExGtDOSArmdbfRWSFNn+cRZwFbjwbec02LVpJo/Huhr0thQBr0veclKD4w8V4R39nek1asJ1PF8VUFIYadYLtJ556tMgS0T2TXxFpewFiOMLVKncNunDgU/TNI8Iqiq/W/0AtbzM/vUnkLdfta+LCAHBuZcf6GDGFmjVfw/YecwxR9FyS7uJBqPKSv5SJjOMO/uiLomFClnhdN4B7njEQMh0mCsyz7uf/zTU8E+ov9ygjWyeInBukH+DP/Ot0sjsv6UResoK8/m6KXLcGIwhYLgcRxhhANv5SJt0LZzyfyEIVV6DKX+DCkJT+wZoKB+7HbB44pfJ+ZP6AQkibu6Y12ZXNM/JGvIoZbnPj2npd7KGB5/B7LvOp+9FItcvj79WuMLWPLg7tVOWuymYNtcbUT/1G5nFn5LUZf/1KpUzgejEtjp3Husi5ylUxo63/zNh92qGeKeKOvURXPKCnDdkraX2lGHKRcyXBN1N1nWodsmQBhjSDJbZ3aeB8c7+A9Y4QWUZ1S1HiYlK2nV5bKZWwJVVZh8aQ2qL2Ny/JHGt3LtX/UjIWw/PzukuI0PX39aaikVB2655TyR+yplYi4ic0x16JrL5sjeVKi/7619NLDbzzQcI0lWiR1taj91ak1gcpvBKqljHuXpiQBv4vR/GQdAStAF0MkyghvjEkcHzP0d+bSVMQt4YMbLh+2WoT9wXxd3Uf7ekGpDaI5NiPDdC9F0FQ8L+fWNi5qb38TirANAGIjtrW8F9v+FfFy5agFYlaMq9LTTtV15W8HPwkChIp4lNLxo3OXXgnfI5eVqfrpMqXjbUYT4DQw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e123c6eb-00f4-47e0-e070-08dbb31f310c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 23:31:15.3749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcBZk+GKJq6TWmv7X9G0tzmD9fLImE8LBF20KtUDSdHXaswpnMvH89OHwizId4uyGo6x/U9IybmOW99N7CAO6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110216
X-Proofpoint-ORIG-GUID: P8RkpT8I6VEUYlLJyc0aEzdb3WK9emMi
X-Proofpoint-GUID: P8RkpT8I6VEUYlLJyc0aEzdb3WK9emMi
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 xuanzhuo@linux.alibaba.com, mst@redhat.com
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

SGkgSmFzb24sCgpPbiA5LzEwLzIwMjMgODo0MiBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiBIaSBT
aS1XZWk6Cj4KPiBPbiBTYXQsIFNlcCA5LCAyMDIzIGF0IDk6MzTigK9QTSBTaS1XZWkgTGl1IDxz
aS13ZWkubGl1QG9yYWNsZS5jb20+IHdyb3RlOgo+PiBPbi1jaGlwIElPTU1VIHBhcmVudCBkcml2
ZXIgY291bGQgdXNlIGl0IHRvIHJlc3RvcmUgbWVtb3J5IG1hcHBpbmcKPj4gdG8gdGhlIGluaXRp
YWwgc3RhdGUuCj4gQXMgZGlzY3Vzc2VkIGJlZm9yZS4gT24tY2hpcCBJT01NVSBpcyB0aGUgaGFy
ZHdhcmUgZGV0YWlscyB0aGF0IG5lZWQKPiB0byBiZSBoaWRkZW4gYnkgdGhlIHZEUEEgYnVzLgpJ
IGd1ZXNzIHRvZGF5IHRoaXMgaXMgZXhwb3NlZCB0byB0aGUgYnVzIGRyaXZlciBsYXllciBhbHJl
YWR5LCBmb3IgZS5nLiAKdmhvc3RfdmRwYV9tYXAoKSBjYW4gY2FsbCBpbnRvIHRoZcKgIC5kbWFf
bWFwLCBvciAuc2V0X21hcCwgb3IgCmlvbW11X21hcCgpIGZsYXZvcnMgZGVwZW5kaW5nIG9uIHRo
ZSBzcGVjaWZpYyBoYXJkd2FyZSBJT01NVSAKaW1wbGVtZW50YXRpb24gdW5kZXJuZWF0aD8gU3Bl
Y2lmaWNhbGx5LCAic3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluIiAKaXMgbm93IHBhcnQgb2Yg
InN0cnVjdCB2aG9zdF92ZHBhIiBhdCBhbiBpbmRpdmlkdWFsIGJ1cyBkcml2ZXIgCih2aG9zdC12
ZHBhKSwgcmF0aGVyIHRoYW4gYmVpbmcgd3JhcHBlZCBhcm91bmQgdW5kZXIgdGhlIHZkcGEgY29y
ZSAKInN0cnVjdCB2ZHBhX2RldmljZSIgYXMgdmRwYSBkZXZpY2UgbGV2ZWwgb2JqZWN0LiBEbyB3
ZSBrbm93IGZvciB3aGF0IApyZWFzb24gdGhlIGhhcmR3YXJlIGRldGFpbHMgY291bGQgYmUgZXhw
b3NlZCB0byBidXMgY2FsbGVycyBsaWtlIAp2aG9zdF92ZHBhX21hcCBhbmQgdmhvc3RfdmRwYV9n
ZW5lcmFsX3VubWFwLCB3aGlsZSBpdCdzIHByb2hpYml0ZWQgZm9yIApvdGhlciBzaW1pbGFyIGNh
c2VzIG9uIHRoZSBvdGhlciBoYW5kPyBPciBpcyB0aGVyZSBhIGJvdW5kYXJ5IGluIGJldHdlZW4g
Ckkgd2FzIG5vdCBhd2FyZSBvZj8KCkkgdGhpbmsgYSBtb3JlIGZ1bmRhbWVudGFsIHF1ZXN0aW9u
IEkgZG9uJ3QgcXVpdGUgdW5kZXJzdGFuZCwgaXMgYWRkaW5nIAphbiBleHRyYSBBUEkgdG8gb24t
Y2hpcCBJT01NVSBpdHNlbGYgYW4gaXNzdWUsIG9yIGp1c3QgdGhhdCB5b3UgZG9uJ3QgCmxpa2Ug
dGhlIHdheSBob3cgdGhlIElPTU1VIG1vZGVsIGdldHMgZXhwb3NlZCB2aWEgdGhpcyBzcGVjaWZp
YyBBUEkgb2YgCi5yZXNldF9tYXA/IEZvciB0aGUgcGxhdGZvcm0gSU9NTVUgY2FzZSwgaW50ZXJu
YWxseSB0aGVyZSBleGlzdHMgCmRpc3RpbmN0aW9uIGJldHdlZW4gdGhlIDE6MSBpZGVudGlmeSAo
cGFzc3Rocm91Z2gpIG1vZGUgYW5kIERNQSBwYWdlIAptYXBwaW5nIG1vZGUsIGFuZCB0aGlzIGRp
c3RpbmN0aW9uIGlzIHNvbWVob3cgZ2V0dGluZyBleHBvc2VkIGFuZCAKcHJvcGFnYXRlZCB0aHJv
dWdoIHRoZSBJT01NVSBBUEkgLSBmb3IgZS5nLiBpb21tdV9kb21haW5fYWxsb2MoKSBhbmQgCmlv
bW11X2F0dGFjaF9kZXZpY2UoKSBhcmUgYmVpbmcgY2FsbGVkIGV4cGxpY2l0bHkgZnJvbSAKdmhv
c3RfdmRwYV9hbGxvY19kb21haW4oKSBieSB2aG9zdC12ZHBhIChhbmQgdGhlIG9wcG9zaXRlIGZy
b20gd2l0aGluIAp2aG9zdF92ZHBhX2ZyZWVfZG9tYWluKSwgd2hpbGUgZm9yIHZpcnRpby12ZHBh
IGl0IGRvZXNuJ3QgY2FsbCBhbnkgSU9NTVUgCkFQSSBhdCBhbGwgb24gdGhlIG90aGVyIGhhbmQg
LSB3aGljaCBpcyB0byBpbmhlcml0IHdoYXQgZGVmYXVsdCBJT01NVSAKZG9tYWluIGhhcy4gSWRl
YWxseSBmb3Igb24tY2hpcCBJT01NVSB3ZSBjYW4gYW5kIHNob3VsZCBkbyBwcmV0dHkgbXVjaCAK
dGhlIHNhbWUsIGJ1dCBJIGRvbid0IHRoaW5rIHRoZXJlJ3MgYSBjbGVhbiB3YXkgd2l0aG91dCBp
bnRyb2R1Y2luZyBhbnkgCmRyaXZlciBBUEkgdG8gbWFrZSB2aG9zdC12ZHBhIGNhc2UgZGlzdGlu
Z3Vpc2ggZnJvbSB0aGUgdmlydGlvLXZkcGEgCmNhc2UuIEknbSBhZnJhaWQgdG8gc2F5IHRoYXQg
aXQgd2FzIGp1c3QgYSBoYWNrIHRvIGhpZGUgdGhlIG5lY2Vzc2FyeSAKZGlzdGluY3Rpb24gbmVl
ZGVkIGJ5IHZkcGEgYnVzIHVzZXJzIGZvciBlLmcuIGluIHRoZSBkZWVwIG9mIAp2ZHBhX3Jlc2V0
KCksIGlmIG5vdCBpbnRyb2R1Y2luZyBhbnkgbmV3IGRyaXZlciBBUEkgaXMgdGhlIGdvYWwgaGVy
ZS4uLgoKPiBFeHBvc2luZyB0aGlzIHdpbGwgY29tcGxpY2F0ZSB0aGUgaW1wbGVtZW50YXRpb24g
b2YgYnVzIGRyaXZlcnMuCkFzIHNhaWQgYWJvdmUsIHRoaXMgZGlzdGluY3Rpb24gaXMgbmVlZGVk
IGJ5IGJ1cyBkcml2ZXJzLCBhbmQgaXQncyAKYWxyZWFkeSBkb25lIGJ5IHBsYXRmb3JtIElPTU1V
IHZpYSBJT01NVSBBUEkuIEkgY2FuIGRyb3AgdGhlIC5yZXNldF9tYXAgCkFQSSB3aGlsZSBhZGQg
YW5vdGhlciBzZXQgb2Ygc2ltaWxhciBkcml2ZXIgQVBJIHRvIG1pbWljIAppb21tdV9kb21haW5f
YWxsb2MvaW9tbXVfZG9tYWluX2ZyZWUsIGJ1dCBkb2luZyB0aGlzIHdpbGwgY29tcGxpY2F0ZSB0
aGUgCnBhcmVudCBkcml2ZXIncyBpbXBsZW1lbnRhdGlvbiBvbiB0aGUgb3RoZXIgaGFuZC4gV2hp
bGUgLnJlc2V0X21hcCBpcyAKd2hhdCBJIGNhbiB0aGluayBvZiB0byBiZSB0aGUgc2ltcGxlc3Qg
Zm9yIHBhcmVudCwgSSBjYW4gZG8gdGhlIG90aGVyIAp3YXkgaWYgeW91J3JlIGZpbmUgd2l0aCBp
dC4gTGV0IG1lIGtub3cgaG93IGl0IHNvdW5kcy4KClRoYW5rcywKLVNpd2VpCgo+Cj4gVGhhbmtz
Cj4KPj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+
PiAtLS0KPj4gICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCB8IDcgKysrKysrKwo+PiAgIDEgZmlsZSBj
aGFuZ2VkLCA3IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
dmRwYS5oIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4gaW5kZXggMTdhNGVmYS4uZGFlY2Y1NSAx
MDA2NDQKPj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4gKysrIGIvaW5jbHVkZS9saW51
eC92ZHBhLmgKPj4gQEAgLTMyNCw2ICszMjQsMTIgQEAgc3RydWN0IHZkcGFfbWFwX2ZpbGUgewo+
PiAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAaW92YTogaW92YSB0byBiZSB1bm1h
cHBlZAo+PiAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAc2l6ZTogc2l6ZSBvZiB0
aGUgYXJlYQo+PiAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSZXR1cm5zIGludGVn
ZXI6IHN1Y2Nlc3MgKDApIG9yIGVycm9yICg8IDApCj4+ICsgKiBAcmVzZXRfbWFwOiAgICAgICAg
ICAgICAgICAgUmVzZXQgZGV2aWNlIG1lbW9yeSBtYXBwaW5nIChvcHRpb25hbCkKPj4gKyAqICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBOZWVkZWQgZm9yIGRldmljZSB0aGF0IHVzaW5nIGRl
dmljZQo+PiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNwZWNpZmljIERNQSB0cmFu
c2xhdGlvbiAob24tY2hpcCBJT01NVSkKPj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBAdmRldjogdmRwYSBkZXZpY2UKPj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBA
YXNpZDogYWRkcmVzcyBzcGFjZSBpZGVudGlmaWVyCj4+ICsgKiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgUmV0dXJucyBpbnRlZ2VyOiBzdWNjZXNzICgwKSBvciBlcnJvciAoPCAwKQo+PiAg
ICAqIEBnZXRfdnFfZG1hX2RldjogICAgICAgICAgICBHZXQgdGhlIGRtYSBkZXZpY2UgZm9yIGEg
c3BlY2lmaWMKPj4gICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmlydHF1ZXVlIChv
cHRpb25hbCkKPj4gICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQHZkZXY6IHZkcGEg
ZGV2aWNlCj4+IEBAIC00MDEsNiArNDA3LDcgQEAgc3RydWN0IHZkcGFfY29uZmlnX29wcyB7Cj4+
ICAgICAgICAgICAgICAgICAgICAgICAgIHU2NCBpb3ZhLCB1NjQgc2l6ZSwgdTY0IHBhLCB1MzIg
cGVybSwgdm9pZCAqb3BhcXVlKTsKPj4gICAgICAgICAgaW50ICgqZG1hX3VubWFwKShzdHJ1Y3Qg
dmRwYV9kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBhc2lkLAo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHU2NCBpb3ZhLCB1NjQgc2l6ZSk7Cj4+ICsgICAgICAgaW50ICgqcmVzZXRfbWFw
KShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBhc2lkKTsKPj4gICAgICAg
ICAgaW50ICgqc2V0X2dyb3VwX2FzaWQpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWdu
ZWQgaW50IGdyb3VwLAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQg
aW50IGFzaWQpOwo+PiAgICAgICAgICBzdHJ1Y3QgZGV2aWNlICooKmdldF92cV9kbWFfZGV2KShz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUxNiBpZHgpOwo+PiAtLQo+PiAxLjguMy4xCj4+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
