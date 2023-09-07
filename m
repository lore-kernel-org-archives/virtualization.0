Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91FFEC8758
	for <virtualization@archiver.kernel.org>; Thu,  7 Sep 2023 20:41:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 469458230D;
	Thu,  7 Sep 2023 20:41:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 469458230D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=PTuFM5xI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=SsTaBiwy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id szI9OqAG2XYx; Thu,  7 Sep 2023 20:41:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B8C3F82304;
	Thu,  7 Sep 2023 20:41:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B8C3F82304
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 956AEC0039;
	Thu,  7 Sep 2023 20:41:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E7D5C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Sep 2023 20:41:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5FAC68230D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Sep 2023 20:41:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5FAC68230D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7MZ9jt4dDL2j
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Sep 2023 20:41:49 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7C90B82304
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Sep 2023 20:41:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C90B82304
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 387KXwYp031306; Thu, 7 Sep 2023 20:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 to : cc : references : subject : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=A4ddccH1b4z+1PgeFOXmWKMr/jW+MvhMeCUv+FxORQw=;
 b=PTuFM5xI5W7i5vh7e76EV45XnvOl+Bd0Dsh2E2iQ72Ge/qd+U9OOMwPbWUrFfmN/u6tC
 vyHtm30Jm1x4AAuuJ2dpKGGu2vvzpQn2pITlnvl/9QI245E62ddKxzbCqfDyjF7KnIG7
 s4wvWAkWGmOGgj4J0+K9s52eS4LlqvoHpblLFlhJ9UD6sm1ZiJchkJ2vYKU6s20UZHQk
 IewTCaTRgRcQ2b0AjtDGcT2n3jTfM/IMZIT76QlosxloaIFSYmhB+iuomxK2/RKbTYe6
 Cu779Wf0hgMGJnaWK2LNtvnATS8ud/f7pNLF1miOne6ZgJXN3Rz0+2AbKZMjusz1EvgC Ug== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3syng2816c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Sep 2023 20:41:41 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 387J4s0c009287; Thu, 7 Sep 2023 20:41:41 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3syfy0f208-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Sep 2023 20:41:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzY1JswVlxwPNdfwEj/fAyxt6lUnA5kl3hOEMn19j2Q4z0l5fnw9kMAvmPphOqoS1tNdF4pxE7oWKZjepza13ioZSMH18lNbkXPiOCbkM2Yfe2Wb9meYG6Deu7921Ll1YrSCk3tgkJAPJb/Kjvg2h/2zitRHN5RT6mCLwUsUGKL8hWZPiqPQBbWyz9CvJYuMcwhZG3OiWC/uElRUqKdmd4LC2TPerZWHtOJ4VuE/hpfH9m/9nMoILAWfJpW9bg1jQIV1Dd86rvDAsFGve2bvDSSKFNLF/2Oj2C+AwBQKVntFa8u+Jz2Me35wngLiflhe73v9nIcuVJwEeumaQBKAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4ddccH1b4z+1PgeFOXmWKMr/jW+MvhMeCUv+FxORQw=;
 b=BPigcZYT33DQPrl2McUeXpD0WQg6NvhPL5ZlRn+S4ns7gQnSCycRWvJ13ajcLVg7DaYWw2GzziCgnJXft5qsQO7hpWqDG2aJ3qTepSM7GO8OwZamZUcvvHfHaDNVHPCfTM/gMjYF47fiZP+sxY8CTPJTa4WSokF/u7zr6Sextgno0OeJsYRagbdmo7nK0MM1WTwLAU2w7vwYmvH26Cb7mCkkFNsEGmnYsGmhz6EBDIOX/8jmLGp/nr+Trd2AX30Pn1awlz4oTrQIwiXrrFwADIkxQx6RTBgvvRtWT4kYTBhLhRLk6XxvEj2w9n5gCEGjjL/7rhbR4KzueLFuWs9MmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4ddccH1b4z+1PgeFOXmWKMr/jW+MvhMeCUv+FxORQw=;
 b=SsTaBiwyPo8arAoXA0oKLId9nXWc87NIKKI1WabPwcNPle2Q/wK/bKNdEjlpSmEpscv8uRiXfbXCU9sws+Sl3zPsjfb06blpb/NpL3QMHyLYMOTAhSOvUbrbpfmZR/WyWhHU5Fnfb40uUP7H7lp1HbZYtB2Z27OVerUuS1fgJEk=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CO1PR10MB4449.namprd10.prod.outlook.com (2603:10b6:303:9d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 20:41:39 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8%3]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 20:41:39 +0000
Message-ID: <b4eeb1b9-1e65-3ef5-1a19-ecd0b14d29e9@oracle.com>
Date: Thu, 7 Sep 2023 13:41:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: dsahern@kernel.org
References: <29db10bca7e5ef6b1137282292660fc337a4323a.1683907102.git.allen.hubbe@amd.com>
Subject: Re: [PATCH] vdpa: consume device_features parameter
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <29db10bca7e5ef6b1137282292660fc337a4323a.1683907102.git.allen.hubbe@amd.com>
X-ClientProxiedBy: PH8PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:510:23c::29) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CO1PR10MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: 28be031b-0b5f-4e21-086b-08dbafe2d655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0ufMsAxtYp5h1jb+sLG1bB74VWZd93fdVIRzBGDiEJPV2KHcBq7E0fE/luI91rAnWaEA5attPRKmO5SclyvxlrY3tsFvdWy2vNEtDbguM8I824Llym7DgHwuvvYrXo2asD1xu/thSmdpJXRSn8B6WAAbd3K6lhJPtemc8zsNlxdQx/9L2vvOsj4R22PAZbuH2lPbfyFXTyiNRw1srjCKCrZ5gLG74lPLyAdvBU695L3I6NGMcbspOoPSoiuMWJzuFWdeH2ozEckqOmlPFO9wUK3F1uVoMVUkWKHV9VQXKxu0vAeFucRxng/d9+t7Y0YK6jUqKpC5BSxxdxWZwd1/jCAr5QjMUT0rP4MpRgj6pYXrRPT/azM8OGz0eYV2DZPIID4IrBMbbO8PxBV6F1cceYvZR3VTGCuED/1GxlA3icIdSghG00vN/gInjszlNKIxcZvTwnnWFP/eD4bvrtdCWaCb0abuNN8srvWxTZy1TsG3pipFHqLAa4U9x9m2czdJA6jjdkqGPrw39YCuACt3VjKfXCsC/9TiBPeRW3Hat92OCAvq5eHdG/eZfQKjLhhAznsGATMMP/j/Uh5Hs7tfm7RRu7kW1QDOrY3cXFOCZFe7uo8JI8AKvXOhEkM7M9Tt2kazmLGGW0gYLkSSQ+JCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(186009)(1800799009)(451199024)(86362001)(31696002)(36756003)(38100700002)(478600001)(2906002)(53546011)(36916002)(6506007)(316002)(4326008)(6486002)(8936002)(8676002)(6512007)(5660300002)(41300700001)(66556008)(6916009)(31686004)(66946007)(26005)(66476007)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWpMRnR5MUJoNmpQZ3g4bFg1MGkvZEJncWtZTHloOUZXZDVNRTdIOWdYZ1NM?=
 =?utf-8?B?bXBUTnlDNUg0YXMxRXJTSEx4cVR1K0ZucXJ0TlpCVksxc2ZKUnpKc0VrbG9i?=
 =?utf-8?B?MEx5OXNaWVFlUUM5Wm1YTjVEYUhRV3greldjbGxwOEZyNkJ6K1BESkgwTG5y?=
 =?utf-8?B?OTlQNHo2S0FNZFlCMHhZamUzMnZyZVlTZUJqdWEvTjNmdGlGSDdjenZPZ2VG?=
 =?utf-8?B?Yk1sRzliRkhFS1QwUVcrNy91Um1JL0dRTVc1NVFwTnBod1NaUTlkU2JLVE1m?=
 =?utf-8?B?Q0d6QS9pYnRySUFEMldNaEU0eWpxWXdNNW94endkUDhQdWhZcjFqNXRJRWZR?=
 =?utf-8?B?ZWYyTFA1L3VOTWJCQ29EajAyUGRibmZjNzFmc0cybjN3ZlZ0VEpaWUY4OE1z?=
 =?utf-8?B?RkZoL2dsN3NuckdVbk5JTDBxQ29YbWtpMm9lOFBZcEd0a3ZXZmxVUU1RQkVU?=
 =?utf-8?B?ZFFhMmVNajhVd0RiOUJOdytkQ1BISnJhbGRzK3R2Y0NwNGNoblc2eWRwNmZL?=
 =?utf-8?B?dmtlLzZOem9SeDA0RTAyaEpOWHZRZllhazk4RDVka1ZrQnZwTmRjdzMrekxW?=
 =?utf-8?B?bVIvWENuRFZWODVnZVM4STFOQ1BUQ01OcUZlc3pJQ1QyOFZMNlVUTk5td21r?=
 =?utf-8?B?N2puTHJvMGtBZ0RwUnhSZVE5SGRVYVhKOEE5M1lFMVIrOURKNFJRbU42b1JJ?=
 =?utf-8?B?dmhwR2w5VjdTaW1VZGMxTXFCVUxNS25ybE00MFc4ajZrOGgwWXlqeURseXd4?=
 =?utf-8?B?di9mT3NJdzUxQnMzaXY2N0pWZ0ZRSnBOY3hERmY3aWx5Z2xqSjQwZy92TEpz?=
 =?utf-8?B?dmZqSExhK21HN0wzenRyRUVwTXFSdmgwV2c5Z2kydWUvSTZYRWhPaXVJT01M?=
 =?utf-8?B?WnhsNmVRV3V0V01Pamt5bUNkeVV0U1pXVnZOaUxjTVF0Q0x0VTNFbGw3WnM1?=
 =?utf-8?B?NkEwTnFSZCtIbjBhSnlFQlVIaTdsT2R3Zm5qMGgzaEJMS3pUQ3ZRbCtPdDQx?=
 =?utf-8?B?S05vS2tvODdaN3lZcXYxWlRXc255WUlrZGNpbi9EYzFVRDhqVVV1ckt2YjZ5?=
 =?utf-8?B?alRHWVdIamJNbFQ5N0dYRzNLcmFWcGRlcXlmOEk1UVIwdmV6djJKQk1YYkgv?=
 =?utf-8?B?MmFXNFJxa0hBei9pb1ZJZFVLYnk4MXYycEFSY0toczVYRWtwRjFaMUlsU2dr?=
 =?utf-8?B?Q3dYd3lzemZpTEdBZHMxR2gxeVRnRUtTMTlLQWR2ZlNjWkp1dzFKeFpCeGdX?=
 =?utf-8?B?MDJmVjR5N0Z6L0FEaTFlSTVWSVgrZVRlMXhwSHh6Y0FrcGVKb2FienFEb3k1?=
 =?utf-8?B?ZXF5ZG5nWFN1eTRCM1JuOWIrV284Qk9KQUk5Ny9ab1h5djdCOG9aSmhGMGFq?=
 =?utf-8?B?czZEdUxIZkVqajJQcTZ5R25OMUZKOFBRTHhHSkJhek9tT2hrNHEzVTQ1cXJ4?=
 =?utf-8?B?M1JLTk9RMEdSRkRsMEI0R3NZRExDOWhCQ3NKVU4rVUswT3VYcTZkOE9GWFRj?=
 =?utf-8?B?YlVseXZnTDBqQW5tV1RPNGJJZjBnd0hhdnR1cjZTbzh2YTN4eGR1TERYRnpT?=
 =?utf-8?B?dWRGR3lValQvNm9HaUJzbjRjeUxKZ0tBdE0vTlJXTDFhOFdtN2lxcUZtQlp6?=
 =?utf-8?B?cFd3UjZWRjJBNlYxQldZdEJIQndyNWQ2RS96akhVNFhOSzRBRC8yQTM5YTBi?=
 =?utf-8?B?TlJoVU5hMjY3ZkxFUG9uZkZEMTVFaDBNVnI4NWRWRlJJbStsNVEwV1hiOTZX?=
 =?utf-8?B?bnFscEdUdTJBdXByWlZFdVMxRTZhb3FjMG41dW5SajFyNDJNaXpzU1R5cjZz?=
 =?utf-8?B?NStaWE92VDkxaE5YaTZHeTVSenhKUnFRKytFK2gzajZCUUdrUnN6SHBscXhp?=
 =?utf-8?B?VnZxN0krN2NaWHFZVkg5RGtYWGNGY2ptNCt5QUxZZ3dHczhYbDVEUitVelMv?=
 =?utf-8?B?NTkreWtNWmJ1NjZpSmxSQWc1RVlON1RvSm5PakNZbVRhQ3ErZVVGZzk0UFNC?=
 =?utf-8?B?aWEremlydmp3MWZ0RDU0UzFJaHI2Rm8yZ1hGWVJleS9oQm1lM0djUUNWRnpH?=
 =?utf-8?B?VVo2ZTFDT0dHNTFjekhLUEJjNjNCVFNOaE12TENpWFQ1WG1lbmJ0SWx6T3py?=
 =?utf-8?Q?KwB4VnQgG7PfWZIPQft03B9UE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZTFtVHpUSWowL2tla2RGSGVCRTQ5VnAzdFRySXU5empyUzNUUGQ4Y1A3TUtU?=
 =?utf-8?B?V0N1Q2NuVTBLNitaZi9nWkUzeWl0UytiV0pwSUd3QUZvUlRRT202MjZ2bVI3?=
 =?utf-8?B?N0hnSnFUYXVMM0phS1g4U3hOT2NFWmROVFdGdDdiQ0VRUGxXbjhIU0xlek8z?=
 =?utf-8?B?QTVLVHhUTERFNVRxYXUyY2cxSy9NeHdqWW85cFVPdy8zMkVVazNwNGFGUERu?=
 =?utf-8?B?eDdiM1NtM3V5UG9rU2hYcUxsTGpSYmlNNFluc1ZJNmJBNk9vOFRsa202NE1H?=
 =?utf-8?B?alNOQWVwbmdnWGswV21CZnk2MHM4TGp6MDIyZlJoTUdqcnNXQmtWRHM1cml4?=
 =?utf-8?B?Nkc0eE4rYmIxb0gwRk9aYWFFQnh6MmpwRXUwb1AwSnczRmtCWWc4SFAyZGJy?=
 =?utf-8?B?ekc0MkZxdHBGVEZBSDRVZndZQVUzU1VOQ0hwSmtFYUlPc09RUUdlZWhCVHBo?=
 =?utf-8?B?Tnp5Ym4vQ0lzaW4yUm8zYUVVdEhEOGVsOUlVQXZNRVkwWUJobDFDQjlaS1FI?=
 =?utf-8?B?cm15M3hmZ2ZJNEpXUzRDcGxmZG84WXlkUFQ0d0xmTktKL09pM09rMldEV0th?=
 =?utf-8?B?M0RJa1l5bFNJNDhsMTJsdEJpdUxod0pzWU5TbUFYMFBNVURmMHp4RVZvYk41?=
 =?utf-8?B?STZvaEZVbW9yaXBoU0ttWFRoS2xsMm9HUFk5YU1mT09tSG5tQmkvRlZxcU5X?=
 =?utf-8?B?Y25SekJuUithRjJWU3RmZkVQdnpwQkZOeThydm5hb0pOOXZLSTUvVW0wQnRZ?=
 =?utf-8?B?b0ZXNE5YQVhvSnlHbFlaN3BRVnp2dkE2Rm96eWJpRzFTNmFXY2tINW4yVm8y?=
 =?utf-8?B?ZkgwMmFmaEtmbElDSExTNHBmSll5dGowZG5UZnBZWDR1Y3BXcktWQWFIaENn?=
 =?utf-8?B?R0JOK1BGYjd1ZTJQNXZUSGswSTV5dmxwbEZFUDNPSFl0UDZuWHBWOFA5ZHBL?=
 =?utf-8?B?a0d5K0kySG00bHk4UXRHYXRMTUdqWDM3cHBwU0FuQUZNZ2RRUTQvWnlhQlFa?=
 =?utf-8?B?ZUxEcmxpZUVjUE5hdjUvaVZqR21VQjNYK2FqeUoyUlhreGFDK0Y2dGRQQWgy?=
 =?utf-8?B?VE95THlWRkRNdnR6SzdxdEhyRTg0U3pEY0FKemRFYURzaXhuRzI3YTFTNDE1?=
 =?utf-8?B?OGlDck1Qa0FiVkdjTWtMSVhidHp5aUxHZk5Ta1BUZjVRakp3dGRiOVAva0dw?=
 =?utf-8?B?UnZPUXgvOE9LWmVORHJFQkNFOWxtM3NSZHlUWjFoY3RGYWRSem9jWGhSRTIx?=
 =?utf-8?Q?L/jkXXy77XETpUN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28be031b-0b5f-4e21-086b-08dbafe2d655
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 20:41:39.8209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glPSwyavKsqo09A4j44jh7FOBb+VF027KfwwGbho2a8tQtRzK9F8kyw9TIYGgCJ0exm4kQ70jdHgdg3iiRit4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4449
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070183
X-Proofpoint-GUID: Y6bBMsZj8BVMWEAmsTFLLfYfZY2iN-CF
X-Proofpoint-ORIG-GUID: Y6bBMsZj8BVMWEAmsTFLLfYfZY2iN-CF
Cc: mst@redhat.com, allen.hubbe@amd.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, drivers@pensando.io
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

SGkgRGF2aWQsCgpXaHkgdGhpcyBwYXRjaCBkb2Vzbid0IGdldCBwaWNrZWQgaW4gdGhlIGxhc3Qg
NCBtb250aHM/IE1heWJlIHRoZSAKc3ViamVjdCBpcyBub3QgY2xlYXIsIGJ1dCB0aGlzIGlzIGFu
IGlwcm91dGUyIHBhdGNoLiBXb3VsZCBpdCBiZSAKcG9zc2libGUgdG8gbWVyZ2UgYXQgeW91ciBl
YXJsaWVzdCBjb252ZW5pZW5jZT8KClBTLCBhZGRpbmcgbXkgUi1iIHRvIHRoZSBwYXRjaC4KClRo
YW5rcywKLVNpd2VpCgoKT24gU2F0LCBNYXkgMTMsIDIwMjMgYXQgMTI6NDLigK9BTSBTaGFubm9u
IE5lbHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4gCndyb3RlOgogPgogPiBGcm9tOiBBbGxl
biBIdWJiZSA8YWxsZW4uaHViYmVAYW1kLmNvbT4KID4KID4gQ29uc3VtZSB0aGUgcGFyYW1ldGVy
IHRvIGRldmljZV9mZWF0dXJlcyB3aGVuIHBhcnNpbmcgY29tbWFuZCBsaW5lCiA+IG9wdGlvbnMu
wqAgT3RoZXJ3aXNlIHRoZSBwYXJhbWV0ZXIgbWF5IGJlIHVzZWQgYWdhaW4gYXMgYW4gb3B0aW9u
IG5hbWUuCiA+CiA+wqAgIyB2ZHBhIGRldiBhZGQgLi4uIGRldmljZV9mZWF0dXJlcyAweGRlYWRi
ZWVmIG1hYyAwMDoxMToyMjozMzo0NDo1NQogPsKgIFVua25vd24gb3B0aW9uICIweGRlYWRiZWVm
IgogPgogPiBGaXhlczogYTQ0NDJjZTU4ZWJiICgidmRwYTogYWxsb3cgcHJvdmlzaW9uaW5nIGRl
dmljZSBmZWF0dXJlcyIpCiA+IFNpZ25lZC1vZmYtYnk6IEFsbGVuIEh1YmJlIDxhbGxlbi5odWJi
ZUBhbWQuY29tPgogPiBSZXZpZXdlZC1ieTogU2hhbm5vbiBOZWxzb24gPHNoYW5ub24ubmVsc29u
QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29t
PgoKID4gLS0tCiA+wqAgdmRwYS92ZHBhLmMgfCAyICsrCiA+wqAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKQogPgogPiBkaWZmIC0tZ2l0IGEvdmRwYS92ZHBhLmMgYi92ZHBhL3ZkcGEu
YwogPiBpbmRleCAyNzY0N2Q3M2Q0OTguLjhhMmZjYTg2NDdiNiAxMDA2NDQKID4gLS0tIGEvdmRw
YS92ZHBhLmMKID4gKysrIGIvdmRwYS92ZHBhLmMKID4gQEAgLTM1Myw2ICszNTMsOCBAQCBzdGF0
aWMgaW50IHZkcGFfYXJndl9wYXJzZShzdHJ1Y3QgdmRwYSAqdmRwYSwgaW50IAphcmdjLCBjaGFy
ICoqYXJndiwKID4gJm9wdHMtPmRldmljZV9mZWF0dXJlcyk7CiA+wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChlcnIpCiA+wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
ZXJyOwogPiArCiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBORVhUX0FSR19GV0QoKTsKID7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgb19mb3VuZCB8PSBWRFBBX09QVF9WREVWX0ZFQVRVUkVTOwogPsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSB7CiA+wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZwcmludGYoc3RkZXJyLCAiVW5rbm93biBvcHRp
b24gXCIlc1wiXG4iLCAKKmFyZ3YpOwogPiAtLQogPiAyLjE3LjEKID4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
