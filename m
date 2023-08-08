Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A425C001E0
	for <virtualization@archiver.kernel.org>; Tue,  8 Aug 2023 22:58:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B680B611D4;
	Tue,  8 Aug 2023 22:58:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B680B611D4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=yQzLcTYG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=XXoqhuFk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wL07re995eup; Tue,  8 Aug 2023 22:58:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 92E4060DB7;
	Tue,  8 Aug 2023 22:58:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 92E4060DB7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7032BC0072;
	Tue,  8 Aug 2023 22:58:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E436C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 22:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8A0D81416
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 22:58:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D8A0D81416
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=yQzLcTYG; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=XXoqhuFk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UWwD4RFOeEIQ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 22:58:42 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EEB14813F9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Aug 2023 22:58:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EEB14813F9
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 378MhwAM008248; Tue, 8 Aug 2023 22:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=X/C1oyFrlBxfl9kFDi8jr+VOzUPJoHNboq3T4C9ccok=;
 b=yQzLcTYGszWYUlOBdniDthAokTWaOWazaaZ51GZn5CysLzz8QYA7fjh6bRdHjy2H8XSg
 Ku+RprhDNFpf8YS9BdRncNiHcRP3eq4xF1Lni95CsIf/6Xcl8VFA1bcYH5+Y73Y+BxHu
 TNSJFBFpHPbkHAs1CoA5Gn4LxZmqWPtE2MfdUhw/jATmNj++fJxT4biWNafEIK+DeHSY
 tx6G0e3qT/fcZVfFQoDH7ivGt9hVJn5liWD04jd6v+hIhkvW0m+gtSd96bfOH1NCMVj0
 QRsDBl9pMODdEuFYb3GYM4WHbU0eolLX96oVyM7w50hLZhgysSF9GSwQFFITkuxspdPV xA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9d73esc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Aug 2023 22:58:35 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 378MnucH010665; Tue, 8 Aug 2023 22:58:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3s9cv66tq1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Aug 2023 22:58:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmNSM0YvFz0yoKRpsIrHn9aqx18jCnatuTjZAO3fzBJwVNZxjs6SKb8yyqSVbTqZXmBSLx0r973zqx8kV3898tiSEk8yci2K1EAzU6fUNw1JSiPmytzwyOLebwoEPM0ZxsUUSKBJwVJzuuJkzdtqMNjwJSu9ZlviVOSHwVExRTlqDQNr+y5YmHKXytQjdmn8HaZcPT4BhMkyr9KuDo6LJpXjfjtJ4hA3qovkuTRMhIcUtD6nXLdMuLlJBa6YYz1L6dcXJo/jEaktKRF0/7k7luixpDrEo5u9PGK5P3G462oLxgSRiM3/1BjpMWYRMqsZKvEuJbA0EkujrYM2tdxtmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/C1oyFrlBxfl9kFDi8jr+VOzUPJoHNboq3T4C9ccok=;
 b=Q5ECdQ+7NFo/PQ5VlagJUVo50Ih9qM0DKgNWFTnStWmC09cgWnH1BPmpjkNaQD4jqqUQLQJfMcHHxcPUfOPTxY/xyWGWCZT5cQ2y6o3NbanIhNnSHK2Nt5AZjJCWFHW+IfeNuek5Ha3+SiBmmgb+4/retwlZjyyOxSEFqP1B9NTSY3rXI0J4OnzETljJL0nkCL3OLLGRutKP/xg7xcOO+AVGOz74BZfdUHTBZ6K0V+iyEKthU92pho94yVnW8MEhTof2KXskOs1Wb7JKcwkXw37vMdv5QfTU9+2Trwe7dT5fWlgohBZTlTzYkYqGzv8I67F76ztYMFN0urVWhGkU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/C1oyFrlBxfl9kFDi8jr+VOzUPJoHNboq3T4C9ccok=;
 b=XXoqhuFkPCj+SSkv0GtOlg0n0Zc4/52VkIbFJNn30cKdtGF0K3+mDS+pMxEsws2xj9msCXUUKKDQ1edLgK6SV4lioJSLc8UzM1jPxjX+MRyCrd7sH0PkbyPmXol7RVQ4df2k6EchxBrMQra7HEp/fKy7xiuH0LP5TSFhWOMG8UQ=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH8PR10MB6456.namprd10.prod.outlook.com (2603:10b6:510:22c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 22:58:20 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::2ae3:b57e:171f:789]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::2ae3:b57e:171f:789%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 22:58:20 +0000
Message-ID: <3472a482-dc1d-1994-e2d7-c2bd740bbd27@oracle.com>
Date: Tue, 8 Aug 2023 15:58:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix mr->initialized semantics
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230802171231.11001-1-dtatulea@nvidia.com>
 <20230802171231.11001-3-dtatulea@nvidia.com>
 <CACGkMEsE45k+fqv-biYfOX5VbqZLo_drQV5rPYByuLJZK03hWQ@mail.gmail.com>
 <741645a0-c576-e504-8ebc-6b716099d730@oracle.com>
 <CACGkMEuAUBa=ZWi2Y48KDABsyAsQFNc4AAPmkHZyXHCQ8Vv89A@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEuAUBa=ZWi2Y48KDABsyAsQFNc4AAPmkHZyXHCQ8Vv89A@mail.gmail.com>
X-ClientProxiedBy: SN7PR04CA0051.namprd04.prod.outlook.com
 (2603:10b6:806:120::26) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH8PR10MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b1b818-3a2a-4b43-bb07-08db9862f5ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FIF14E0H3ghLvyAcpui9baFrcDAueRRVSI9oyq8aVWks9AD5/k1QWi0NMJHn7Z7zaLxUB5/2NYP3T0f2JWkKJ3xSVOiRAxhDrUGE0zjbpzeYitfgPN+vihtVv2LiWS4DH/Uuf0sCL5auIPCkolY4XETo/dj99mkUKq79fI2e+KIavgcBN4R0F20hpq7mouCoFvz2KFUkShQDtTbs7PfnHuOMFkWSWcWkd7G3Pb2XbSm3qASfhIinS1l4FrqaEpfMq3qj7FSlINc9mmOyjyKnz7uHoqbEerQmEt9e7dtruvWucs3airQlGZ/dDDTiADmLAJ9kepvxmpIpae5yw9qbBy/4V2ZOmKiF/PzYPasTi+D9c9pDAXNTDiVf7wYhSEKQkhwNuGD4fZWc/t4Xprzay7tDyxef/xr0Jykly5sMRWO/ZZFQ0yqgbRDPF4oamd3MkcwqiYU7ggmc3UwKNFHEf3I9JihGufUf/y6GA6LiW/XyLm93olVDYJoJzc6+W/fC8xohBlLFAQTlRpc8W5uXd8ZeAxUTlJhwQCurg3BRuBT4MMe4IqcKatib8R6amBy1f1H4xkyLBwZsBb/Rtb5TnRQpt2dQI6Iqx2P01RcAHMJr61vS1Qyeei4P7ITrEDszQ8K3zo5HPDxDOCE8uDfBw+m7cSN/cGFSZfJYSAfQEkc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(366004)(136003)(396003)(346002)(376002)(186006)(1800799006)(451199021)(83380400001)(66574015)(31686004)(2616005)(54906003)(6916009)(4326008)(8676002)(316002)(5660300002)(8936002)(66946007)(66556008)(66476007)(38100700002)(6512007)(31696002)(36916002)(6666004)(966005)(86362001)(6486002)(478600001)(2906002)(41300700001)(36756003)(53546011)(6506007)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUd5ZENFcXdjV0VaWVpwQTlXMlJUa01wR29LSWR0RzNXRjdOVmFpS3ByVnc3?=
 =?utf-8?B?ak93N0dndGE2VFZJZlZIRG5HRDVrZUNkVDRIU0Z1ZWgrT3B4Y0UrbHUvYUdL?=
 =?utf-8?B?N0VtdUpnY0NLak5jaEF1ZFZzdWladi8xd3laNDNuejBhNld2NlBnSkRUdXZz?=
 =?utf-8?B?TWxqSXZIakVtMEcyWWh4MHpieUdjbTZrMWFHNnJIRVV6SjMwMEtDQStncHM2?=
 =?utf-8?B?bVVyZGtsOC9JZndVSXZnYnpFL3k4Zkd3Z2czUExrek1hZU82cDlLMmYzVlFu?=
 =?utf-8?B?c0lEVE9mZmxsMTVBMHZrRFYrRHNabGQ3Ty83VUtmbTVJRlRmUzUrU0N2dUpw?=
 =?utf-8?B?M1ovSkg2bVh6c09tVE5wUm1rMDFyUXJMUzhQT3hDajR3ZS9YdWowb2kwOVE1?=
 =?utf-8?B?eTBrN200VlBncG00bkRzMGk2SFpWWXJkb3NxL2dkdlg4cU1rUjlzaW5jbkJH?=
 =?utf-8?B?N2hWdVhKZWIyL3JzVnphZUU1Mm91VjNoOHl2VEJuRktEZzNQUStrMm1nN2Q0?=
 =?utf-8?B?bmx4aHlOVTAyR0FHaGtvR1ZSbWNxVFhYQnYrYXRwNXV3cFE3eFh2aFpzdmNu?=
 =?utf-8?B?OWlTNkpFRi9OZzB4ZE1mZEtyWGZvU242cmdWZE15Ym12NmNvQm1CZjhnMGdS?=
 =?utf-8?B?TlVPTXZoK2Zyc2pteTZacUMvcjFKZGRuRE9uTHVjcTlUa21QaXVFcEY1blFi?=
 =?utf-8?B?aDBneG9tMlEyRUVmQWdOVkRYdllzR1lyV083ZEFGbmpkVnU4S2xMSUljcHBD?=
 =?utf-8?B?RmZsS253dlZ2Z2tIWUR3VVFnSktsaUJvcEZFQjgvZ3cveW5LeXl2TkFMS3pz?=
 =?utf-8?B?bDF3aGNISXRlaEFtVnlnZDRoTGJwN3Raakd6enlIVDF5U0xYaEx3RXg5Nncr?=
 =?utf-8?B?UlJ3aDJqanRNb3kxc2pZUE9qdVFSMGE1K25xR3Q1dG90SU1MbWQ4a0FHL05w?=
 =?utf-8?B?WTN6eDg2WUpMeDlXb3ZCRWtwV0FTNGE5UmM2Nzgya2Y0dXN2RE5sRTBOTnM3?=
 =?utf-8?B?Q09mS0dqY2M4SDUrZ2FyUE5xRzdoeE5pSnpJYlRzczN0bEc1YytIZlBDbENJ?=
 =?utf-8?B?ZjZlUDVITzZ2ZkZrQWJlVitQazZFZ2YrekgxSGlpaGt0OXBSVFNJTFNKVEg2?=
 =?utf-8?B?ejJ0VFhrMGVzMDBwSlFWcFI2SExRN3hDdHd0amNpRCtqckplQ1B5dFFsYUNO?=
 =?utf-8?B?cFFzTVVINC9sbk9SRGYra3R3UHRSNXZBRHpDOHJ1RXNPL01wcVZBYVhoalR2?=
 =?utf-8?B?cnNWaFNwdlUvZ1RCMVRUV3kyNWdSYjk4WU5ldzE5emVSSDZmSVk3MHVVZGdi?=
 =?utf-8?B?b25FU0MyQjk1dGphdEhjWStNZHJEbkd3NkxuTnZ2cTYzbG9OQzJRSE9uOHNW?=
 =?utf-8?B?d051aVV5Q1hYMXIzZ1A5U2xnaGpLaGRSSzhKdkp0bVlJOUhveGxYVFp1UTg2?=
 =?utf-8?B?RUxlZkUwVm8wUTVMUkNNdnNNUUhMbHkvSUE0d1JZY1JScDQrQ21xbVRxVmcz?=
 =?utf-8?B?ZFZkQ0lwd1JvRVJYQnhUbjZFeXlVN3RodXIwM0Evb0pBS0FmU0FtMlI1bldv?=
 =?utf-8?B?bTJaTERRLy8zNTF6NHJxZHdhL2NtdE5ZalhtbXZFcjR2aWdoNXBycVl0SUJs?=
 =?utf-8?B?NG1UdFlkeE1yOERpS2dGMTQrNFdwTENRblJ3dC9YWkdtcE9vMFk4MHBFaXRT?=
 =?utf-8?B?MWc0M3Vyb0tTcFludVJQU0FRcDRUdm5qdG9mSllTRHdTYyttSFF5ejcxTlVE?=
 =?utf-8?B?TCtqRWlyRDk5dC9BQlphc3lGYnFPbGFwbm9FSWRiVUZ3MXJiM2JiUThYcEsv?=
 =?utf-8?B?bTZJTEdrbUsvekdGbVBKMDZ4eHgxQTZSUjRLUmVLVWQzOTQwOTEyVTRsMVN5?=
 =?utf-8?B?YktibEF1SGphNDNKa21FU1hucWtDT1NZdEU4aDZEbGpYV1VNdDVUS0RPZXZX?=
 =?utf-8?B?UjRKL0ttQTFWL3NHeGYvZ0NzaUJWRG1pQ3lrWXpvOFlRUnplY3V1a2tMSksx?=
 =?utf-8?B?eXlxOWR4LzFaT2RnRlJVTTF0MDBKQ2FrTWgxM1VXdFBObFVLNmsvOGVkaDlG?=
 =?utf-8?B?ZUxUMzIzVEtpM3NwZCtvclZYd3hnOVFyS0d2bHBqY1FGNFlCM3c0eGdMOUNO?=
 =?utf-8?Q?D/2bXFsRe1wpcee/AjkMrz6jY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MTNmUU9LaE5ONEsyT0ZZbG5zblhMVDBwN2kvS09CQ2NuRk1mTTJvNDg4YTdw?=
 =?utf-8?B?ZkpWSlpGSFRNeDd4WXUvSkpUTGJKQmI3bFViWkRSWTNTSEdZZm5ST1FsZzBX?=
 =?utf-8?B?VDFZYjlkR2dPOXFSQVJMOHBpWmxvT0JITWs5Mm05dFNSaXhDRG5EMDRCRlJ3?=
 =?utf-8?B?UWRYYmRXRGxBNmhhUkNkS2REYitFcnJ5MTRNL0h1ZWp3RVBySS93c0xSaFV3?=
 =?utf-8?B?Vjd2QVVFNU04eTlYUzJWSE9wU1dEN3pmaERIU1NRTDN1dStaU3NTajdyZk0w?=
 =?utf-8?B?WCtJRTgvN2hUS1QrN3FXR1hGd2hpYnMrSStDWlYrZm1WYzFVbWlubUlnOU81?=
 =?utf-8?B?Z2VaNGlGeTNRS3ljM3lGdFNtVTIvc3NOV1lqZmpGYzU0RWFIV1hDazdreEdt?=
 =?utf-8?B?Tm5PeHBYb2lGWWNHa1NCKytpTTdjaFIvM3pwdnpadTZFL3kxaDVJUGIrQ05i?=
 =?utf-8?B?Y0xXbFJPZk50TEh6TEJVa2ZWY0NreVdwaVBvdzREL3JES3U1VEhldVhxamhu?=
 =?utf-8?B?dGhNSS9zRjdjd3RFc3pxRlpZRnN3RXpBby9JWkJjTVVPclJQTDV0UytIeFpU?=
 =?utf-8?B?M2xJRmYxT0R3VFhIQzdlQ1F6UVJYYVVyeDJIc21iZnBPeGpxTkRqK2lleGQy?=
 =?utf-8?B?WTZPZ09xM00xZmo1Y3Z4YUpVQ1Mvd0o4RkVrV0I4L0NOcHNtV0RBak5CZUpR?=
 =?utf-8?B?WmhhcVlkaWRxczVFY1B1SktTdFg3ZXBYenp6Sm1Tam1qTnVEbVpSYzJGc3kv?=
 =?utf-8?B?dDR4clRBQlU2T00vOTkzNlRZRlRsTk1iaEpiaDV1SUpIZDJKUVgxT1lTeG9j?=
 =?utf-8?B?ejZzOHNyWEpMNmtWN3FQZnkzZWFRbWpaT1p2RStqRlVPUzVHLzYrNnhkcWcx?=
 =?utf-8?B?QzF5TUh4WGJaYlBobDlabzMvYU1KN3dVUHpBUXlGT0VJbmkrYkxXWG0rMzJO?=
 =?utf-8?B?Nkx1MFZqeWNvaXpyUTVhNUh2emR5bE9SODBwZkdjeURxQ2o1bHRFMDloRmJ2?=
 =?utf-8?B?alpld25DNDVSWWhDY01OTExyditJdUR3TjgzUy9JZmswVy9jcDU5VUhKTVVP?=
 =?utf-8?B?Mzh6U1FCZnFDa2RFbXFBVEpPQ21nVnh2bGZhOGxTeWZQMlN4Mk9vMUNIZjU4?=
 =?utf-8?B?ZTZJdXhMSVJzMkFCTTl3ZGVidHFGdkZTMFBYVkQ0V2pGZ2FFY2tZVnFZR3RG?=
 =?utf-8?B?c3pvdjFsS1lXR0YydGNCbmlpeEpIOGtoamdSMThlYSt5WUIycURjTVU2R2Er?=
 =?utf-8?Q?oGqkECrEzgI48oH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b1b818-3a2a-4b43-bb07-08db9862f5ac
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 22:58:20.1604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbDS/IDDAxBn954PExonK0jTm7Mjgil5w8Xl1cGDQPlbpsWgHja4rfV1DZ2XDJ7PAwmp2NyAX37MJLaJdkYFeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6456
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_21,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080206
X-Proofpoint-GUID: hdDZV88aqKu7WV2yI-zlxbt5_14mKiud
X-Proofpoint-ORIG-GUID: hdDZV88aqKu7WV2yI-zlxbt5_14mKiud
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>
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

CgpPbiA4LzcvMjAyMyA4OjAwIFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+IE9uIEZyaSwgQXVnIDQs
IDIwMjMgYXQgMTo1OOKAr0FNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4gd3Jv
dGU6Cj4+Cj4+Cj4+IE9uIDgvMy8yMDIzIDE6MDMgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4+PiBP
biBUaHUsIEF1ZyAzLCAyMDIzIGF0IDE6MTPigK9BTSBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFA
bnZpZGlhLmNvbT4gd3JvdGU6Cj4+Pj4gVGhlIG1yLT5pbml0aWFsaXplZCBmbGFnIGlzIHNoYXJl
ZCBiZXR3ZWVuIHRoZSBjb250cm9sIHZxIGFuZCBkYXRhIHZxCj4+Pj4gcGFydCBvZiB0aGUgbXIg
aW5pdC91bmluaXQuIEJ1dCBpZiB0aGUgY29udHJvbCB2cSBhbmQgZGF0YSB2cSBnZXQgcGxhY2Vk
Cj4+Pj4gaW4gZGlmZmVyZW50IEFTSURzLCBpdCBjYW4gaGFwcGVuIHRoYXQgaW5pdGlhbGl6aW5n
IHRoZSBjb250cm9sIHZxIHdpbGwKPj4+PiBwcmV2ZW50IHRoZSBkYXRhIHZxIG1yIGZyb20gYmVp
bmcgaW5pdGlhbGl6ZWQuCj4+Pj4KPj4+PiBUaGlzIHBhdGNoIGNvbnNvbGlkYXRlcyB0aGUgY29u
dHJvbCBhbmQgZGF0YSB2cSBpbml0IHBhcnRzIGludG8gdGhlaXIKPj4+PiBvd24gaW5pdCBmdW5j
dGlvbnMuIFRoZSBtci0+aW5pdGlhbGl6ZWQgd2lsbCBub3cgYmUgdXNlZCBmb3IgdGhlIGRhdGEg
dnEKPj4+PiBvbmx5LiBUaGUgY29udHJvbCB2cSBjdXJyZW50bHkgZG9lc24ndCBuZWVkIGEgZmxh
Zy4KPj4+Pgo+Pj4+IFRoZSB1bmluaXRpYWxpemluZyBwYXJ0IGlzIGFsc28gdGFrZW4gY2FyZSBv
ZjogbWx4NV92ZHBhX2Rlc3Ryb3lfbXIgZ290Cj4+Pj4gc3BsaXQgaW50byBkYXRhIGFuZCBjb250
cm9sIHZxIGZ1bmN0aW9ucyB3aGljaCBhcmUgbm93IGFsc28gQVNJRCBhd2FyZS4KPj4+Pgo+Pj4+
IEZpeGVzOiA4ZmNkMjBjMzA3MDQgKCJ2ZHBhL21seDU6IFN1cHBvcnQgZGlmZmVyZW50IGFkZHJl
c3Mgc3BhY2VzIGZvciBjb250cm9sIGFuZCBkYXRhIikKPj4+PiBTaWduZWQtb2ZmLWJ5OiBEcmFn
b3MgVGF0dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4KPj4+PiBSZXZpZXdlZC1ieTogRXVnZW5p
byBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4+Pj4gUmV2aWV3ZWQtYnk6IEdhbCBQcmVz
c21hbiA8Z2FsQG52aWRpYS5jb20+Cj4+Pj4gLS0tCj4+Pj4gICAgZHJpdmVycy92ZHBhL21seDUv
Y29yZS9tbHg1X3ZkcGEuaCB8ICAxICsKPj4+PiAgICBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21y
LmMgICAgICAgIHwgOTcgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tCj4+Pj4gICAgMiBm
aWxlcyBjaGFuZ2VkLCA3MSBpbnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkKPj4+Pgo+Pj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oIGIvZHJpdmVy
cy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaAo+Pj4+IGluZGV4IDI1ZmM0MTIwYjYxOC4uYTA0
MjBiZTUwNTlmIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92
ZHBhLmgKPj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCj4+Pj4g
QEAgLTMxLDYgKzMxLDcgQEAgc3RydWN0IG1seDVfdmRwYV9tciB7Cj4+Pj4gICAgICAgICAgIHN0
cnVjdCBsaXN0X2hlYWQgaGVhZDsKPj4+PiAgICAgICAgICAgdW5zaWduZWQgbG9uZyBudW1fZGly
ZWN0czsKPj4+PiAgICAgICAgICAgdW5zaWduZWQgbG9uZyBudW1fa2xtczsKPj4+PiArICAgICAg
IC8qIHN0YXRlIG9mIGR2cSBtciAqLwo+Pj4+ICAgICAgICAgICBib29sIGluaXRpYWxpemVkOwo+
Pj4+Cj4+Pj4gICAgICAgICAgIC8qIHNlcmlhbGl6ZSBta2V5IGNyZWF0aW9uIGFuZCBkZXN0cnVj
dGlvbiAqLwo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMgYi9k
cml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKPj4+PiBpbmRleCAwM2U1NDMyMjk3OTEuLjRhZTE0
YTI0OGE0YiAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKPj4+
PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKPj4+PiBAQCAtNDg5LDYwICs0ODks
MTAzIEBAIHN0YXRpYyB2b2lkIGRlc3Ryb3lfdXNlcl9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAq
bXZkZXYsIHN0cnVjdCBtbHg1X3ZkcGFfbXIgKm1yCj4+Pj4gICAgICAgICAgIH0KPj4+PiAgICB9
Cj4+Pj4KPj4+PiAtdm9pZCBtbHg1X3ZkcGFfZGVzdHJveV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2Rl
diAqbXZkZXYpCj4+Pj4gK3N0YXRpYyB2b2lkIF9tbHg1X3ZkcGFfZGVzdHJveV9jdnFfbXIoc3Ry
dWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCkKPj4+PiArewo+Pj4+
ICsgICAgICAgaWYgKG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9DVlFfR1JPVVBdICE9IGFz
aWQpCj4+Pj4gKyAgICAgICAgICAgICAgIHJldHVybjsKPj4+PiArCj4+Pj4gKyAgICAgICBwcnVu
ZV9pb3RsYihtdmRldik7Cj4+Pj4gK30KPj4+PiArCj4+Pj4gK3N0YXRpYyB2b2lkIF9tbHg1X3Zk
cGFfZGVzdHJveV9kdnFfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCB1bnNpZ25lZCBp
bnQgYXNpZCkKPj4+PiAgICB7Cj4+Pj4gICAgICAgICAgIHN0cnVjdCBtbHg1X3ZkcGFfbXIgKm1y
ID0gJm12ZGV2LT5tcjsKPj4+Pgo+Pj4+IC0gICAgICAgbXV0ZXhfbG9jaygmbXItPm1rZXlfbXR4
KTsKPj4+PiArICAgICAgIGlmIChtdmRldi0+Z3JvdXAyYXNpZFtNTFg1X1ZEUEFfREFUQVZRX0dS
T1VQXSAhPSBhc2lkKQo+Pj4+ICsgICAgICAgICAgICAgICByZXR1cm47Cj4+Pj4gKwo+Pj4+ICAg
ICAgICAgICBpZiAoIW1yLT5pbml0aWFsaXplZCkKPj4+PiAtICAgICAgICAgICAgICAgZ290byBv
dXQ7Cj4+Pj4gKyAgICAgICAgICAgICAgIHJldHVybjsKPj4+Pgo+Pj4+IC0gICAgICAgcHJ1bmVf
aW90bGIobXZkZXYpOwo+Pj4+ICAgICAgICAgICBpZiAobXItPnVzZXJfbXIpCj4+Pj4gICAgICAg
ICAgICAgICAgICAgZGVzdHJveV91c2VyX21yKG12ZGV2LCBtcik7Cj4+Pj4gICAgICAgICAgIGVs
c2UKPj4+PiAgICAgICAgICAgICAgICAgICBkZXN0cm95X2RtYV9tcihtdmRldiwgbXIpOwo+Pj4+
Cj4+Pj4gICAgICAgICAgIG1yLT5pbml0aWFsaXplZCA9IGZhbHNlOwo+Pj4+IC1vdXQ6Cj4+Pj4g
K30KPj4+PiArCj4+Pj4gK3N0YXRpYyB2b2lkIG1seDVfdmRwYV9kZXN0cm95X21yX2FzaWQoc3Ry
dWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCkKPj4+PiArewo+Pj4+
ICsgICAgICAgc3RydWN0IG1seDVfdmRwYV9tciAqbXIgPSAmbXZkZXYtPm1yOwo+Pj4+ICsKPj4+
PiArICAgICAgIG11dGV4X2xvY2soJm1yLT5ta2V5X210eCk7Cj4+Pj4gKwo+Pj4+ICsgICAgICAg
X21seDVfdmRwYV9kZXN0cm95X2R2cV9tcihtdmRldiwgYXNpZCk7Cj4+Pj4gKyAgICAgICBfbWx4
NV92ZHBhX2Rlc3Ryb3lfY3ZxX21yKG12ZGV2LCBhc2lkKTsKPj4+PiArCj4+Pj4gICAgICAgICAg
IG11dGV4X3VubG9jaygmbXItPm1rZXlfbXR4KTsKPj4+PiAgICB9Cj4+Pj4KPj4+PiAtc3RhdGlj
IGludCBfbWx4NV92ZHBhX2NyZWF0ZV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsCj4+
Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlv
dGxiLCB1bnNpZ25lZCBpbnQgYXNpZCkKPj4+PiArdm9pZCBtbHg1X3ZkcGFfZGVzdHJveV9tcihz
dHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYpCj4+Pj4gK3sKPj4+PiArICAgICAgIG1seDVfdmRw
YV9kZXN0cm95X21yX2FzaWQobXZkZXYsIG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9DVlFf
R1JPVVBdKTsKPj4+PiArICAgICAgIG1seDVfdmRwYV9kZXN0cm95X21yX2FzaWQobXZkZXYsIG12
ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9EQVRBVlFfR1JPVVBdKTsKPj4+PiArfQo+Pj4+ICsK
Pj4+PiArc3RhdGljIGludCBfbWx4NV92ZHBhX2NyZWF0ZV9jdnFfbXIoc3RydWN0IG1seDVfdmRw
YV9kZXYgKm12ZGV2LAo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdW5zaWduZWQgaW50IGFzaWQpCj4+Pj4gK3sKPj4+PiArICAgICAgIGlmIChtdmRl
di0+Z3JvdXAyYXNpZFtNTFg1X1ZEUEFfQ1ZRX0dST1VQXSAhPSBhc2lkKQo+Pj4+ICsgICAgICAg
ICAgICAgICByZXR1cm4gMDsKPj4+PiArCj4+Pj4gKyAgICAgICByZXR1cm4gZHVwX2lvdGxiKG12
ZGV2LCBpb3RsYik7Cj4+PiBUaGlzIHdvcnJpZXMgbWUgYXMgY29uY2VwdHVhbGx5LCB0aGVyZSBz
aG91bGQgYmUgbm8gZGlmZmVyZW5jZSBiZXR3ZWVuCj4+PiBkdnEgbXIgYW5kIGN2cSBtci4gVGhl
IHZpcnRxdWV1ZSBzaG91bGQgYmUgbG9vc2VseSBjb3VwbGVkIHdpdGggbXIuCj4+Pgo+Pj4gT25l
IGV4YW1wbGUgaXMgdGhhdCwgaWYgd2Ugb25seSBkbyBkdXBfaW90bGIoKSBidXQgbm90IHRyeSB0
byBjcmVhdGUKPj4+IGRtYSBtciBoZXJlLCB3ZSB3aWxsIGJyZWFrIHZpcnRpby12ZHBhOgo+PiBG
b3IgdGhpcyBjYXNlLCBJIGd1ZXNzIHdlIG1heSBuZWVkIGFub3RoZXIgd2F5IHRvIHN1cHBvcnQg
dmlydGlvLXZkcGEKPj4gMToxIG1hcHBpbmcgcmF0aGVyIHRoYW4gb3ZlcmxvYWRpbmcgdmlydGlv
IGRldmljZSByZXNldCBzZW1hbnRpY3MsIHNlZToKPj4KPj4gaHR0cHM6Ly93d3cubWFpbC1hcmNo
aXZlLmNvbS9xZW11LWRldmVsQG5vbmdudS5vcmcvbXNnOTUzNzU1Lmh0bWwKPj4KPj4gICA+IENv
bmNlcHR1YWxseSwgdGhlIGFkZHJlc3MgbWFwcGluZyBpcyBub3QgYSBwYXJ0IG9mIHRoZSBhYnN0
cmFjdGlvbiBmb3IKPj4gICA+IGEgdmlydGlvIGRldmljZSBub3cuIFNvIHJlc2V0dGluZyB0aGUg
bWVtb3J5IG1hcHBpbmcgZHVyaW5nIHZpcnRpbwo+PiAgID4gZGV2aWNlIHJlc2V0IHNlZW1zIHdy
b25nLgo+Pgo+PiB3aGVyZSB3ZSB3YW50IHRvIGtlZXAgbWVtb3J5IG1hcHBpbmcgaW50YWN0IGFj
cm9zcyB2aXJ0aW8gZGV2aWNlIHJlc2V0Cj4+IGZvciBiZXN0IGxpdmUgbWlncmF0aW9uIGxhdGVu
Y3kvZG93bnRpbWUuIEkgd29uZGVyIHdvdWxkIGl0IHdvcmsgdG8KPj4gcmVzZXQgdGhlIG1hcHBp
bmcgaW4gdmhvc3QtdmRwYSBsaWZlIGN5Y2xlIG91dCBvZiB2aXJ0aW8gcmVzZXQsIHNheQo+PiBp
bnRyb2R1Y2UgYSAucmVzZXRfbWFwKCkgb3AgdG8gcmVzdG9yZSAxOjEgbWFwcGluZyB3aXRoaW4K
Pj4gdmhvc3RfdmRwYV9yZW1vdmVfYXMoKSByaWdodCBhZnRlciB2aG9zdF92ZHBhX2lvdGxiX3Vu
bWFwKCk/IFRoZW4gd2UgY2FuCj4+IG1vdmUgdGhlIGlvdGxiIHJlc2V0IGxvZ2ljIHRvIHRoZXJl
IHdpdGhvdXQgd29ycnkgYnJlYWtpbmcgdmlydGlvLXZkcGEuCj4gSXQgbG9va3MgdG8gbWUgd2Ug
ZG9uJ3QgbmVlZCBhIG5ldyBvcHMuIFdlIGNhbiBzaW1wbHkgZG8gc2V0X21hcCgpCj4gdHdpY2UK
V2hhdCBkb2VzIGl0IG1lYW4sIGZpcnN0IHNldF9tYXAoMCwgLTFVTEwpIHdpdGggemVybyBpb3Rs
YiBlbnRyeSBwYXNzZWQgCmluIHRvIGRlc3Ryb3kgYWxsIGlvdGxiIG1hcHBpbmdzIHByZXZpb3Vz
bHkgYWRkZWQsIGFuZCBzZWNvbmQgc2V0X21hcCgwLCAKLTFVTEwpIHRvIHJlc3RvcmUgMToxIERN
QSBNUj8gQnV0IHVzZXJzcGFjZSAobWF5YmUgYSBidWdneSBvbmUgYnV0IApkb2Vzbid0IGRvIGhh
cm0pIGFwYXJ0IGZyb20gdmhvc3QtdmRwYSBpdHNlbGYgY2FuIGRvIHVubWFwIHR3aWNlIGFueXdh
eSwgCnRoaXMgaXMgc3VwcG9ydGVkIHRvZGF5IEkgdGhpbmsuIFdoeSB0aGVyZSdsbCBiZSBzdWNo
IG9ic2N1cmUgCmRpc3RpbmN0aW9uLCBvciB3aGF0J3MgdGhlIGJlbmVmaXQgdG8gdHJlYXQgc2Vj
b25kIC5zZXRfbWFwKCkgYXMgCnJlY3JlYXRpbmcgMToxIG1hcHBpbmc/Cgo+ICAgb3IgZG8geW91
IG1lYW4gaXQgd291bGQgYmUgZmFzdGVyPwpJIHRoaW5rIHdpdGggLnJlc2V0X21hcCgpIHdlIGF0
IGxlYXN0IGNhbiBhdm9pZCBpbmRlZmluaXRlIGxhdGVuY3kgCmhpY2N1cCBmcm9tIGRlc3Ryb3lp
bmcgYW5kIHJlY3JlYXRpbmcgMToxIG1hcHBpbmcgd2l0aCB0aGUgdW53YXJyYW50ZWQgCjJyZCB1
bm1hcCBjYWxsLiBBbmQgLnJlc2V0X21hcCgpIHNob3VsZCB3b3JrIHdpdGggYm90aCAuZG1hX21h
cCgpIGFuZCAKLnNldF9tYXAoKSBBUElzIHdpdGggY2xlYXIgc2VtYW50aWNzLgoKUmVnYXJkcywK
LVNpd2VpCj4KPiBUaGFua3MKPgo+PiBUaGFua3MsCj4+IC1TaXdlaQo+Pgo+Pj4gY29tbWl0IDZm
NTMxMmY4MDE4MzZlNmFmOWJjYmIwYmRiNDRkYzQyM2UxMjkyMDYKPj4+IEF1dGhvcjogRWxpIENv
aGVuIDxlbGljQG52aWRpYS5jb20+Cj4+PiBEYXRlOiAgIFdlZCBKdW4gMiAxMTo1ODo1NCAyMDIx
ICswMzAwCj4+Pgo+Pj4gICAgICAgdmRwYS9tbHg1OiBBZGQgc3VwcG9ydCBmb3IgcnVubmluZyB3
aXRoIHZpcnRpb192ZHBhCj4+Pgo+Pj4gICAgICAgSW4gb3JkZXIgdG8gc3VwcG9ydCBydW5uaW5n
IHZkcGEgdXNpbmcgdnJpdGlvX3ZkcGEgZHJpdmVyLCB3ZSBuZWVkICB0bwo+Pj4gICAgICAgY3Jl
YXRlIGEgZGlmZmVyZW50IGtpbmQgb2YgTVIsIG9uZSB0aGF0IGhhcyAxOjEgbWFwcGluZywgc2lu
Y2UgdGhlCj4+PiAgICAgICBhZGRyZXNzZXMgcmVmZXJyaW5nIHRvIHZpcnRxdWV1ZXMgYXJlIGRt
YSBhZGRyZXNzZXMuCj4+Pgo+Pj4gICAgICAgV2UgY3JlYXRlIHRoZSAxOjEgTVIgaW4gbWx4NV92
ZHBhX2Rldl9hZGQoKSBvbmx5IGluIGNhc2UgZmlybXdhcmUKPj4+ICAgICAgIHN1cHBvcnRzIHRo
ZSBnZW5lcmFsIGNhcGFiaWxpdHkgdW1lbV91aWRfMC4gVGhlIHJlYXNvbiBmb3IgdGhhdCBpcyB0
aGF0Cj4+PiAgICAgICAxOjEgTVJzIG11c3QgYmUgY3JlYXRlZCB3aXRoIHVpZCA9PSAwIHdoaWxl
IHZpcnRxdWV1ZSBvYmplY3RzIGNhbiBiZQo+Pj4gICAgICAgY3JlYXRlZCB3aXRoIHVpZCA9PSAw
IG9ubHkgd2hlbiB0aGUgZmlybXdhcmUgY2FwYWJpbGl0eSBpcyBvbi4KPj4+Cj4+PiAgICAgICBJ
ZiB0aGUgc2V0X21hcCgpIGNhbGxiYWNrIGlzIGNhbGxlZCB3aXRoIG5ldyB0cmFuc2xhdGlvbnMg
cHJvdmlkZWQKPj4+ICAgICAgIHRocm91Z2ggaW90bGIsIHRoZSBkcml2ZXIgd2lsbCBkZXN0cm95
IHRoZSAxOjEgTVIgYW5kIGNyZWF0ZSBhIHJlZ3VsYXIKPj4+ICAgICAgIG9uZS4KPj4+Cj4+PiAg
ICAgICBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPj4+ICAgICAg
IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMTA2MDIwODU4NTQuNjI2OTAtMS1l
bGljQG52aWRpYS5jb20KPj4+ICAgICAgIFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtp
biA8bXN0QHJlZGhhdC5jb20+Cj4+PiAgICAgICBBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4KPj4+Cj4+PiBUaGFua3MKPj4+Cj4+Pgo+Pj4+ICt9Cj4+Pj4gKwo+Pj4+
ICtzdGF0aWMgaW50IF9tbHg1X3ZkcGFfY3JlYXRlX2R2cV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2Rl
diAqbXZkZXYsCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHZob3N0X2lvdGxiICppb3RsYiwKPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1bnNpZ25lZCBpbnQgYXNpZCkKPj4+PiAgICB7Cj4+Pj4gICAgICAgICAgIHN0cnVjdCBt
bHg1X3ZkcGFfbXIgKm1yID0gJm12ZGV2LT5tcjsKPj4+PiAgICAgICAgICAgaW50IGVycjsKPj4+
Pgo+Pj4+IC0gICAgICAgaWYgKG1yLT5pbml0aWFsaXplZCkKPj4+PiArICAgICAgIGlmIChtdmRl
di0+Z3JvdXAyYXNpZFtNTFg1X1ZEUEFfREFUQVZRX0dST1VQXSAhPSBhc2lkKQo+Pj4+ICAgICAg
ICAgICAgICAgICAgIHJldHVybiAwOwo+Pj4+Cj4+Pj4gLSAgICAgICBpZiAobXZkZXYtPmdyb3Vw
MmFzaWRbTUxYNV9WRFBBX0RBVEFWUV9HUk9VUF0gPT0gYXNpZCkgewo+Pj4+IC0gICAgICAgICAg
ICAgICBpZiAoaW90bGIpCj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgZXJyID0gY3JlYXRl
X3VzZXJfbXIobXZkZXYsIGlvdGxiKTsKPj4+PiAtICAgICAgICAgICAgICAgZWxzZQo+Pj4+IC0g
ICAgICAgICAgICAgICAgICAgICAgIGVyciA9IGNyZWF0ZV9kbWFfbXIobXZkZXYsIG1yKTsKPj4+
PiArICAgICAgIGlmIChtci0+aW5pdGlhbGl6ZWQpCj4+Pj4gKyAgICAgICAgICAgICAgIHJldHVy
biAwOwo+Pj4+Cj4+Pj4gLSAgICAgICAgICAgICAgIGlmIChlcnIpCj4+Pj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIGVycjsKPj4+PiAtICAgICAgIH0KPj4+PiArICAgICAgIGlmIChp
b3RsYikKPj4+PiArICAgICAgICAgICAgICAgZXJyID0gY3JlYXRlX3VzZXJfbXIobXZkZXYsIGlv
dGxiKTsKPj4+PiArICAgICAgIGVsc2UKPj4+PiArICAgICAgICAgICAgICAgZXJyID0gY3JlYXRl
X2RtYV9tcihtdmRldiwgbXIpOwo+Pj4+Cj4+Pj4gLSAgICAgICBpZiAobXZkZXYtPmdyb3VwMmFz
aWRbTUxYNV9WRFBBX0NWUV9HUk9VUF0gPT0gYXNpZCkgewo+Pj4+IC0gICAgICAgICAgICAgICBl
cnIgPSBkdXBfaW90bGIobXZkZXYsIGlvdGxiKTsKPj4+PiAtICAgICAgICAgICAgICAgaWYgKGVy
cikKPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dF9lcnI7Cj4+Pj4gLSAgICAg
ICB9Cj4+Pj4gKyAgICAgICBpZiAoZXJyKQo+Pj4+ICsgICAgICAgICAgICAgICByZXR1cm4gZXJy
Owo+Pj4+Cj4+Pj4gICAgICAgICAgIG1yLT5pbml0aWFsaXplZCA9IHRydWU7Cj4+Pj4gKwo+Pj4+
ICsgICAgICAgcmV0dXJuIDA7Cj4+Pj4gK30KPj4+PiArCj4+Pj4gK3N0YXRpYyBpbnQgX21seDVf
dmRwYV9jcmVhdGVfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAo+Pj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwgdW5zaWdu
ZWQgaW50IGFzaWQpCj4+Pj4gK3sKPj4+PiArICAgICAgIGludCBlcnI7Cj4+Pj4gKwo+Pj4+ICsg
ICAgICAgZXJyID0gX21seDVfdmRwYV9jcmVhdGVfZHZxX21yKG12ZGV2LCBpb3RsYiwgYXNpZCk7
Cj4+Pj4gKyAgICAgICBpZiAoZXJyKQo+Pj4+ICsgICAgICAgICAgICAgICByZXR1cm4gZXJyOwo+
Pj4+ICsKPj4+PiArICAgICAgIGVyciA9IF9tbHg1X3ZkcGFfY3JlYXRlX2N2cV9tcihtdmRldiwg
aW90bGIsIGFzaWQpOwo+Pj4+ICsgICAgICAgaWYgKGVycikKPj4+PiArICAgICAgICAgICAgICAg
Z290byBvdXRfZXJyOwo+Pj4+ICsKPj4+PiAgICAgICAgICAgcmV0dXJuIDA7Cj4+Pj4KPj4+PiAg
ICBvdXRfZXJyOgo+Pj4+IC0gICAgICAgaWYgKG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9E
QVRBVlFfR1JPVVBdID09IGFzaWQpIHsKPj4+PiAtICAgICAgICAgICAgICAgaWYgKGlvdGxiKQo+
Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgIGRlc3Ryb3lfdXNlcl9tcihtdmRldiwgbXIpOwo+
Pj4+IC0gICAgICAgICAgICAgICBlbHNlCj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgZGVz
dHJveV9kbWFfbXIobXZkZXYsIG1yKTsKPj4+PiAtICAgICAgIH0KPj4+PiArICAgICAgIF9tbHg1
X3ZkcGFfZGVzdHJveV9kdnFfbXIobXZkZXYsIGFzaWQpOwo+Pj4+Cj4+Pj4gICAgICAgICAgIHJl
dHVybiBlcnI7Cj4+Pj4gICAgfQo+Pj4+IC0tCj4+Pj4gMi40MS4wCj4+Pj4KPj4+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+PiBWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKPj4+IFZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCj4+PiBodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
