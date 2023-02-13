Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A2CC636CC
	for <virtualization@archiver.kernel.org>; Mon, 13 Feb 2023 20:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34F0561088;
	Mon, 13 Feb 2023 20:17:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 34F0561088
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=ypLWhn7W;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=hEO6DAqq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4H9hGFR35oKD; Mon, 13 Feb 2023 20:17:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9E9FD6104D;
	Mon, 13 Feb 2023 20:17:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E9FD6104D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83554C0032;
	Mon, 13 Feb 2023 20:17:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EB45C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 20:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2AD1A81C56
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 20:17:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2AD1A81C56
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=ypLWhn7W; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=hEO6DAqq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uS8uhpQB3Lt9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 20:17:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA3F181BD6
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA3F181BD6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 20:17:40 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 31DI5De9003196; Mon, 13 Feb 2023 20:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Gn2A8lybsNqZEoOLQFHA661x0RLpEcj+D+f8Qv9GtSs=;
 b=ypLWhn7WCycwzr18iBRgphm6mI5jL/ARmfEr0IpHmYvQ2Nkvrs10LaGSXZ8NprxeVvZv
 jvqfOUPyTtXcKm1UwzODs9tbtNQe8T8E29EsPx+qiBHDk64LW2puPqT3L25K57BnCpH0
 aYlnor+6Tj7dwzygN2fW6+QI3JZG7fPMaWOQfVAUQODvD/YuQLm/ILYc63KCvsqYdbvV
 eFgJ35/VQo34Py9LgQBbwLw6iLahjbkuGLBZMXF5JwB4caCSJqCVTexZCHYRCSjXqn4Q
 OiryBGc8ui54OzyS2rDvbiV28zSOxPBfGIrccooylL5tuVKJv50UVyKVg/hIt17JGp+c AQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np3jturcd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Feb 2023 20:17:40 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 31DIYvlO011688; Mon, 13 Feb 2023 20:17:38 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3np1f4m8vv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Feb 2023 20:17:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9o0stmklBcPBQbUcziEAQLjjb6EdPetzf3vsr6ehBTnti5CU86dB7QMAtlI2tMAc4rFZI7/1mkYAbqnmRS7dkcaoWIHe397H3MPWEA2j2LQ5k88bE4jZweKFDyqUg3PbZAiXH40qeXcFBST+RLg205VS6rUGkW9q7V1aVpGB6RHF2eN6acv8SNVKRTClZFJ7jbD3jvi9BYiyy2eEHm3pw5lcKMkVVlJV5IzyvJ2/xfvSkDP2gCf0oVUGMudgVXQwMsfVBCev38TmcsQXohhWTvF0V5FWIvQ8X897LbXDbeZtK0nHejv37fL1s2FICOUyVnDLRSimKwFDNNfdmCQpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gn2A8lybsNqZEoOLQFHA661x0RLpEcj+D+f8Qv9GtSs=;
 b=Irp547Tp3P3t4/Yk5QzfxaYTY/69pzczN/7ICNjzZo0uk7VfTwWSpNkkt0o99QFIEvRCaWu7ADMF+1ux5DT4IGN8K0y59ICiGUUdq0QnPoIqrnTmnCcqavVSmUeHrgfuQ3mzGTprK2h4YDNVI6apdd9FP8alhgwB2SDUrmhVim8UFljML/a/SQ7bAjIOX5+opx5Cp1I4zpIOL5y8v0csZKB3eSDmj4KDkljUyRhYoxVDEtDsufZIVr09dgVLwW4hrLFPNuvxx7akP0VQBs9nBabhk6zGeqL7YKTXDGPh/2nElR30ZqLa0RrLiztE9+msLOlNo9XimJTf5/ktRpsZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gn2A8lybsNqZEoOLQFHA661x0RLpEcj+D+f8Qv9GtSs=;
 b=hEO6DAqqPm3gkZL9oKZi1R6ZCv6+W38O4RsiTAI32lyPaKZa4Bm4vVe8208F1vgocNaA+A3GAhde3R5X053obJ0mFE19jYBiiHGnnbdEtZtjn//uUg5I+4q3pm0r1VnZ31QJTttWgAcwQdZTGBydPgkLvhgH/chYcDiV0+N3ad4=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH8PR10MB6501.namprd10.prod.outlook.com (2603:10b6:510:22b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.9; Mon, 13 Feb
 2023 20:17:36 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3%9]) with mapi id 15.20.6111.010; Mon, 13 Feb 2023
 20:17:36 +0000
Message-ID: <cec254c1-4508-56de-96bb-f6bf82a7fd18@oracle.com>
Date: Mon, 13 Feb 2023 12:17:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] vdpa/mlx5: should not activate virtq object when suspended
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 Eugenio Perez Martin <eperezma@redhat.com>
References: <1676095694-15563-1-git-send-email-si-wei.liu@oracle.com>
 <536e8152-b575-7b8f-d7c9-37975bbedd3d@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <536e8152-b575-7b8f-d7c9-37975bbedd3d@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::13) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH8PR10MB6501:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9b379c-4568-4b68-30c1-08db0dff58d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxM/iRMvE+uG682RRYvf5LQYxOmr5nhBWnKn/yckzKFZz/DfrGFeG95lugwt65R4tbWz8T1H/iqVf8WpoAV0/ZFqO+Zy9ZMO+ACDKmRlfsvNL+8RepEyW3xKDhqIUkdhWm87i3N1n0BVhWKVGAnoPE18y1l4f9Nm30S0kRZdhb+YGJhyYkIyMoNMBLtt3GriYPUgVrw0+JSxnYMxpgJIq7rIi9TzNZGA7c4RnZ0c/kdQdwuzPcp3LUCmgUO5EsbVP71xFoRnXd0ULl8nnPwrIjA96lUwWlxQKXfmkluiqKn6LkxakERtt4BJ2Uj1qHHP7u7UH8ZXkXhBSslvTaPXAcSoVaoP18tC8jKWF4bmYBuz623Q/DDDjEgr23E3Gel06D7G2GKj9g9ooYS9Lvt/q19l2iaxL0WI9mo5MWU99Oa/LiSHTUTJwfjkdad71wlzCcThNxnOHsPoI00Pcvr+f/h5NQSYTl+XVfuFEQFndgdogxQ8IbkxwRF6QdiLQfyO5ZZiKmA6rSKopKXwIl7f9r3hjHIBWAFQfiK/vYfNAqSd5h3oHRy9g0gJ6gDSY0LvNBINK4BdSAepWpi0B4aX8UtYx+3OelQBVsyAhcX8lW3hAW9uJcsL6ypGtw8KRh8HcHJtucKG2cec7qlHtmnU1q0CxcRT/BNrcyr8KEffqzPxLNEM1lawWeqEo2zansFliaG7x/bZ3nIrVLYejJSc3zirtJ+CmzRb4ZjrPdrv4XQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199018)(31696002)(6486002)(110136005)(36916002)(53546011)(186003)(478600001)(26005)(6512007)(6666004)(6506007)(2906002)(41300700001)(8936002)(5660300002)(316002)(15650500001)(8676002)(38100700002)(66556008)(66476007)(4326008)(66946007)(2616005)(83380400001)(36756003)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1FCTEY5eWFDZWdNd1dlTG5GZElOTkNpaFUxcHY1eUVEV3FlM1hNNGd4UEdJ?=
 =?utf-8?B?VXdkQ3dyTkI2SmVxM0l3akZwV0pvWmxCb2o4aWx6SkdCcjA3cUtrU2dkaHlP?=
 =?utf-8?B?czlMbHZMbXRKZXpPK3Jzamd3a0lQWlZZblNOUFhIZ1VROGpFS0s5cGdqVUF2?=
 =?utf-8?B?aU1nb1V1T2thZE9ibnR3bVNlakhwcXdldk9Zak9sRzNCKy9jRE5aeSt4SHp5?=
 =?utf-8?B?Y2NxMGQycFNzWWZjZlNkUTN2TUp5bUpQTE9LaU5KY3EvTlJ1RGR5S3BEbDBm?=
 =?utf-8?B?SGVhVHcvTzMxb1pqb1JIN0pmTlVaVVo0N1cvdTVwQkZISlVRanZqaXcvclRG?=
 =?utf-8?B?TlNZazNzbXdZUWM5QlQ2RFN3Zmo5NkMrczU5WDVIRnE4dDBpSTNQSldpNThw?=
 =?utf-8?B?eEVHbmxGQnZRVm4rOFBhTUhtMHlyOU9hU2F6OUxPUTB0UEN1NkMvTmpqZGE0?=
 =?utf-8?B?dGhZczg0Sy8ybFREMldMbEkySFE5aEd1T3dybUxGUG1VMU1BM0l1dCsrQ09S?=
 =?utf-8?B?MitVcFNmZk1zd3hUeTNDWUF4WG90aFdWNGMvZ1pMejJad0t2U2J5RCtYdUIy?=
 =?utf-8?B?VUo2WWFaY2JudFBDMHN4cjhBd0dSZUlEZHBBUit1UmwyUHNQMXdlL2hoNHNB?=
 =?utf-8?B?WklYZkZ2MU1MY3NuRzhzUVU0WDdkeWZlMkNvMGtzWHFBdk1EOVVaSE1VWmFw?=
 =?utf-8?B?RWVBeGlGaytPVGRuaFA0SW1RVTU0Wmo2YStONmZrYXZ5TlBFbmZ2YnNvYmZq?=
 =?utf-8?B?L3h2dnJKTUIxTGxyVEJJbEV6NFFZekpjeU8vWHpqcXVlcjZFL01MTnFpL21a?=
 =?utf-8?B?bndOSTlZYmRFY3o1dllaQ0VOZGtNejBFOUFXVWg5Y0xnS0QwVzNId3ZkS3px?=
 =?utf-8?B?VUpsU1J5OHo2WTI1cjgrQnVNZ3ExTmZVOTFLNVRxcjFMK25YSDJPaXR2MXN2?=
 =?utf-8?B?djIvSVVKWENSM1g3MGNSdlFvZ1plQ0R0ZVJGTEI3VGJEZVVMNm9MRlVaV3lp?=
 =?utf-8?B?NVBrVTh4elRQUE8xQmQvYm10ZHFnQ3ZkSzhkWmgxY05HRXF2VG9iclBUK3Ru?=
 =?utf-8?B?Z2FsaGZvZFdmWWtZNHRNdFNIZURWdkVwNnh4Sm9iOU1QR2ZGcDhHQVNMWTJT?=
 =?utf-8?B?Z2QwVklwYzNhRXh6bUcrZ2g1em9SeWg3UU1TaGtybnFtc0M4ZXQvWGtMYmNr?=
 =?utf-8?B?STJzS1BjSGoxbVJYN0xQcUxXa3piMWVWcjhDdzJFN0k0VU16Z0Zub3FnOStV?=
 =?utf-8?B?ZGNpWnZYdWZvdENKNnRldXdrV2owaVc4d1N6WStxR2VQaE96SEpVRUxJcHpX?=
 =?utf-8?B?R2pwQlE5T1BFc3VqS2xaelBvZnF2Slo1ZThSVVhCL0tZdk93eGMrNHRUK1Ey?=
 =?utf-8?B?RGRMenNHM1pPSWdzbTBOcENXRWwzZUQ5YWJCTVUveFIwM2JLeFNHZGdRVlFu?=
 =?utf-8?B?M3Q4Mmt5dTVqRzl1azdpUGhQZ3d0OHpFSlB4Mnk4QUNFUjZmbXIrQWc3aUZU?=
 =?utf-8?B?TDJrT0VQcEpoaDIrYVQ5Nm9KdGF0TVEyL3dlVDc0NEZmbEhkN3VackE4dWxp?=
 =?utf-8?B?eFZpUWlBLy9GM3NIVFozZndwK0hYdHB1R1FBK1JyclNTUW9DY004N1dCbHFr?=
 =?utf-8?B?T09pZlBoNlZEMTRyelJwQkFQZFVuWmlHNHhadzZETmhYdmpkYk96Q2MwTkJp?=
 =?utf-8?B?RmR0NTA2YllCb3YxSUtYOXFtYWhRQS9ERkozRTRkTGdYV25QRTM5cVEwY2p5?=
 =?utf-8?B?R0NTa2UrN3FYNVlreEp0YkFFamE3NGNOLzBRSTRKYkhqdUlXUDV0MnZyN2Yx?=
 =?utf-8?B?b2FKWlAzLzVZT3pmY2Rnc1E1bk5VWXEzRzVENEN1N2JaU0N6SURmNmszbjN2?=
 =?utf-8?B?Rkw5alZ5QkY3aUdqWGdGbEcxOUFNN3Zna09YazF6WVc1VENvMFV4SFpoRnI0?=
 =?utf-8?B?dGpkeVIvQW5NbVZIcXZkSFNpMVprZXFyUlJmcjF6Sk9YdmRKRVRmeUtVbFVY?=
 =?utf-8?B?RkVFUis3NWJHY0EvMTlXdGdDUHd2R2l3UzVHM0owZnAvWGZyRHVERlkvTUp6?=
 =?utf-8?B?TW5JdlJhOVFKS3Q0dVhsVzYyZ2F1a0VmUWZCbzYzNjF6ZjVUeFNPc3M3SFlB?=
 =?utf-8?Q?RuLdbEM8t755sjcNgNI5WTpF9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NqAk32VAa12/vk0bueLmTRnB3JokGRS9kgQZr8zTVBkHvpWObCuvKHu+CkCYh/wcVn+8kRGi0rNRlEyclWWVv0d8l/Ui2TDoahw7hy5pclO2RdpbdnYNjIhpz00B4EtFAR7KJBvVjoFkyP7LXVaglBxd3S6j15Uty9OXQbb9zFn/SaYaOPnb0oQI/AsUOWhYBdWKPugQZ1D5jM33XanTWW3hAu60gfBA3gK3SKvhccsjiy34qgRRntoW9pkV5vgkvcFVAw5N2Sttqv4uXLVW/dY+HH+oz2n8HJJvQ7Irrq26x/mB4oN30Kbs5F44SVaYp0On+fy5M1DHjQ2Skp5CzXDiQDYxwk+UHc+t/4Wi1OjhqIoJl/a1sH5uXtYz97eTnz6LByTWDBe2XhRFPoNcxDPGMtNPseeFy8GxBLFK0yQ9eUuvI7QdRxDEJySAhnCdfqNuNA0QfLgoSqD+S+oQHtGmS+px0Khn+cOcVfrqTZr+wile1elBRjZkxSNrww4kFcDXfp+kBtOP9Y1ABus27LKTr70A27e4UtA/UqaUAt5iMskSqHmnXLCp5UK2JKoVYW0GxCJ/jny0R86dbi3f2jFxjuIOn21VAvsl2gG7uVGc5Xl1TU5BGFY4OpgSBa48/Y0ew8IZO7QnRKlfdiPUV+cJvP/dnqG7M5TaxItIoI813G2oJxCFATKv0NdQa0Dv3KznMDFR8pjHeg3CVvAPUiBLOGGfhiCN180BOIB4Aw99V6k0n8GgUBKbC3To3wt/vXnSnbGqXnHK13gFhg8aNsAcmel3xUiYP5aoggQSY7n7on2rcdGdNJqcdtVR37LvnB8+GOySqsHDXAcGOZiYLOlXhErRvEs9pETKSLmOaEo+4wRFR1TXFaAbj40SsIEc/DDMQ9XgsJLrpYjqLRFSlg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9b379c-4568-4b68-30c1-08db0dff58d3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 20:17:36.3013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTOsiOEWFVwkDHsgoX5hWAFbSzwZmzs1dRXn9ZSnGZSiqTqr4B34+GiIlx56Sm+n6if6jY9Fx8UrVaJP3ltQqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6501
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130178
X-Proofpoint-ORIG-GUID: R5jRQHndacG9aP6bklCMCIGyyBdve9NV
X-Proofpoint-GUID: R5jRQHndacG9aP6bklCMCIGyyBdve9NV
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

KyBFdWdlbmlvCgpPbiAyLzExLzIwMjMgMTA6NTUgUE0sIEVsaSBDb2hlbiB3cm90ZToKPgo+IE9u
IDExLzAyLzIwMjMgODowOCwgU2ktV2VpIExpdSB3cm90ZToKPj4gT3RoZXJ3aXNlIHRoZSB2aXJ0
cXVldWUgb2JqZWN0IHRvIGluc3RhdGUgY291bGQgcG9pbnQgdG8gaW52YWxpZCBhZGRyZXNzCj4+
IHRoYXQgd2FzIHVubWFwcGVkIGZyb20gdGhlIE1UVDoKPj4KPj4gwqDCoCBtbHg1X2NvcmUgMDAw
MDo0MTowNC4yOiBtbHg1X2NtZF9vdXRfZXJyOjc4MjoocGlkIDgzMjEpOgo+PiDCoMKgIENSRUFU
RV9HRU5FUkFMX09CSkVDVCgweGEwMCkgb3BfbW9kKDB4ZCkgZmFpbGVkLCBzdGF0dXMKPj4gwqDC
oCBiYWQgcGFyYW1ldGVyKDB4MyksIHN5bmRyb21lICgweDVmYTFjKSwgZXJyKC0yMikKPiBJIGFt
IGZhbWlsaWFyIHdpdGggdGhpcyBpc3N1ZSBidXQgSSB0aGluayBpdCBzaG91bGQgYmUgaGFuZGxl
ZCBhdCB0aGUgCj4gcWVtdSBsZXZlbC4gVGhpcyBsb2dpYyBqdXN0IGhpZGVzIHRoZSByZWFsIHBy
b2JsZW0uIHFlbXUgcHJvdmlkZXMgdGhlIAo+IGlvdmEgYW5kIHRoZSBWUXMnIGFkZHJlc3NlcyBz
byBpdCBzaG91bGQgbm90IHNocmluayB0aGUgbWFwIHdoaWxlIHN1Y2ggCj4gdGhhdCBWUSBhZGRy
ZXNzZXMgYXJlIG91dCBvZiB0aGUgaW92YSByYW5nZS4KCkhlcmUgdGhlIHdob2xlIGRldmljZSBp
cyBhbHJlYWR5IHN1c3BlbmRlZCwgd2hpY2ggc2hvdWxkIGd1YXJhbnRlZSBubyAKZnVydGhlciBE
TUEgbWVtb3J5IGFjY2VzcyB3aWxsIGJlIGluaXRpYXRlZCBieSB0aGUgZGV2aWNlLiBXaGF0IGlz
IHRoZSAKcHJvYmxlbSB0aGUgbWFwcGluZyBjYW4ndCBzaHJpbmsgaW4gdGhpcyBjYXNlPyBOb3Rl
ZCB0aGUgY29kZSBhbHJlYWR5IAphbGxvd3Mgc2hyaW5raW5nIGZvciB0aGUgcmVzZXQgY2FzZSAo
flZJUlRJT19DT05GSUdfU19EUklWRVJfT0sgc3RhdHVzIApjaGVjayksIEkgc2VlIG5vIGVzc2Vu
dGlhbCBkaWZmZXJlbmNlIHRoZSBzYW1lIGNvdWxkbid0IGJlIGFwcGxpZWQgdG8gCnRoZSBzdXNw
ZW5kIGNhc2UuIE9uIHRoZSBvdGhlciBoYW5kLCBtYXAgc2hyaW5raW5nIHdvcmtzIHdlbGwgd2l0
aCAKcGxhdGZvcm0gSU9NTVUgaW9tbXVfbWFwL3VubWFwKCkgY2FsbHMgd2hpbGUgdmRwYSBkZXZp
Y2UgaXMgc3VzcGVuZGVkLgoKSWYgeW91ciBjb25jZXJuIGlzIHRoYXQgdGhlIGRldmljZSB3b24n
dCB3b3JrIHdpdGggdGhlIHNocnVuayBtYXAgb25jZSAKdGhlIGRldmljZSBpcyB0byBiZSBSRVNV
TUUnZCwgSSB0aGluayBJIGFncmVlIHRoYXQncyB3aGF0IFFFTVUgaGFzIHRvIApndWFyYW50ZWUs
IGJ5IGVpdGhlciBhZGRpbmcgYmFjayB0aGUgcmVxdWlyZWQgbWFwcGluZyBlbnRyaWVzIGFzIG5l
ZWRlZCwgCm9yIGNoYW5nZSBWUSBhZGRyZXNzZXMgZHVyaW5nIHN1c3BlbmQgdGhhdCBwb2ludHMg
dG8gbWFwcGVkIElPVkEgCmFkZHJlc3Nlcy4gT3IgYm90aCBjYW4gYmUgZG9uZSBhdCB0aGUgc2Ft
ZSB0aW1lIGR1cmluZyBzdXNwZW5kLCB3aXRoIAp0aGF0IHdlIGNhbiBidWlsZCBhIGZhc3QgcGF0
aCB0byBzd2l0Y2ggc3ZxIG1vZGUgd2l0aCBvbi1jaGlwIElPTU1VIGUuZy4gCm1seDVfdmRwYSwg
cmF0aGVyIHRoYW4gZ28gdGhyb3VnaCBmdWxsIGRldmljZSByZXNldCBjeWNsZS4KCj4+Cj4+IFdo
aWxlIGF0IGl0LCBhZGQgd2FybmluZyBtZXNzYWdlIHRvIHRlbGwgYXBhcnQgd2hpY2ggb2JqZWN0
IGlzCj4+IHJlc3BvbnNpYmxlIGZvciB0aGUgQ1JFQVRFX0dFTkVSQUxfT0JKRUNUIGNvbW1hbmQg
ZmFpbHVyZS4KPj4KPj4gRml4ZXM6IGNhZTE1YzJlZDhlNiAoInZkcGEvbWx4NTogSW1wbGVtZW50
IHN1c3VwZW5kIHZpcnRxdWV1ZSBjYWxsYmFjayIpCj4+IENjOiBFbGkgQ29oZW4gPGVsaWNAbnZp
ZGlhLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUu
Y29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgMTcg
KysrKysrKysrKysrKystLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMgCj4+IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+IGlu
ZGV4IDNhNmRiYmM2Li5jMDVjN2Y2IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9u
ZXQvbWx4NV92bmV0LmMKPj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
Cj4+IEBAIC0xNjUsNiArMTY1LDcgQEAgc3RydWN0IG1seDVfdmRwYV9uZXQgewo+PiDCoMKgwqDC
oMKgIHUzMiBjdXJfbnVtX3ZxczsKPj4gwqDCoMKgwqDCoCB1MzIgcnF0X3NpemU7Cj4+IMKgwqDC
oMKgwqAgYm9vbCBuYl9yZWdpc3RlcmVkOwo+PiArwqDCoMKgIGJvb2wgc3VzcGVuZGVkOwo+PiDC
oMKgwqDCoMKgIHN0cnVjdCBub3RpZmllcl9ibG9jayBuYjsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3Qg
dmRwYV9jYWxsYmFjayBjb25maWdfY2I7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IG1seDVfdmRwYV93
cV9lbnQgY3ZxX2VudDsKPj4gQEAgLTEyNDUsMTIgKzEyNDYsMTggQEAgc3RhdGljIGludCBzZXR1
cF92cShzdHJ1Y3QgbWx4NV92ZHBhX25ldCAKPj4gKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmly
dHF1ZXVlICptdnEpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9jb25uZWN0Owo+PiDC
oCDCoMKgwqDCoMKgIGVyciA9IGNvdW50ZXJfc2V0X2FsbG9jKG5kZXYsIG12cSk7Cj4+IC3CoMKg
wqAgaWYgKGVycikKPj4gK8KgwqDCoCBpZiAoZXJyKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBtbHg1
X3ZkcGFfd2FybigmbmRldi0+bXZkZXYsICJmYWlsZWQgdG8gYWxsb2MgY291bnRlciBvbiB2cSAK
Pj4gaWR4ICVkKCVkKVxuIiwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZHgsIGVycik7Cj4gQWx0aG91Z2ggeW91IG1lbnRpb24gaW4gdGhlIGNvbW1pdCBsb2csIG1h
eWJlIGl0J3MgYmV0dGVyIHRvIGhhdmUgYSAKPiBzZXBhcmF0ZSBwYXRjaCBmb3IgaW1wcm92aW5n
IHdhcm5pbmcgbWVzc2FnZXMuCkFscmlnaHQsIEkgd2lsbCBtb3ZlIHRoZSBpbXByb3ZlZCB3YXJu
aW5nIG1lc3NhZ2Ugb3V0IG9mIHRoaXMgcGF0Y2guIApUaGlzIGlzc3VlIGVmZmVjdGl2ZWx5IGJs
b2NrcyBsaXZlIG1pZ3JhdGluZyBtbHg1X3ZkcGEgZGV2aWNlIHRoYXQgaGFzIAp0byBnZXQgbWVy
Z2VkIGFzYXAuIFdoaWxlIG90aGVycyBjYW4gcG9zdCBwYXRjaGVzIHRvIGltcHJvdmUgd2Fybmlu
Z3Mgb24gCnRvcC4KCgpUaGFua3MsCi1TaXdlaQoKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8g
ZXJyX2NvdW50ZXI7Cj4+ICvCoMKgwqAgfQo+PiDCoCDCoMKgwqDCoMKgIGVyciA9IGNyZWF0ZV92
aXJ0cXVldWUobmRldiwgbXZxKTsKPj4gLcKgwqDCoCBpZiAoZXJyKQo+PiArwqDCoMKgIGlmIChl
cnIpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIG1seDVfdmRwYV93YXJuKCZuZGV2LT5tdmRldiwgImZh
aWxlZCB0byBjcmVhdGUgdmlydHF1ZXVlIGlkeCAKPj4gJWQoJWQpXG4iLAo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlkeCwgZXJyKTsKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGdvdG8gZXJyX2Nvbm5lY3Q7Cj4+ICvCoMKgwqAgfQo+PiDCoCDCoMKgwqDCoMKgIGlmICht
dnEtPnJlYWR5KSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBlcnIgPSBtb2RpZnlfdmlydHF1ZXVl
KG5kZXYsIG12cSwgCj4+IE1MWDVfVklSVElPX05FVF9RX09CSkVDVF9TVEFURV9SRFkpOwo+PiBA
QCAtMjQxMSw3ICsyNDE4LDcgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfY2hhbmdlX21hcChzdHJ1
Y3QgCj4+IG1seDVfdmRwYV9kZXYgKm12ZGV2LAo+PiDCoMKgwqDCoMKgIGlmIChlcnIpCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9tcjsKPj4gwqAgLcKgwqDCoCBpZiAoIShtdmRldi0+
c3RhdHVzICYgVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSykpCj4+ICvCoMKgwqAgaWYgKCEobXZk
ZXYtPnN0YXR1cyAmIFZJUlRJT19DT05GSUdfU19EUklWRVJfT0spIHx8IAo+PiBuZGV2LT5zdXNw
ZW5kZWQpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9tcjsKPj4gwqAgwqDCoMKgwqDC
oCByZXN0b3JlX2NoYW5uZWxzX2luZm8obmRldik7Cj4+IEBAIC0yNTgwLDYgKzI1ODcsNyBAQCBz
dGF0aWMgaW50IG1seDVfdmRwYV9yZXNldChzdHJ1Y3QgdmRwYV9kZXZpY2UgCj4+ICp2ZGV2KQo+
PiDCoMKgwqDCoMKgIG1seDVfdmRwYV9kZXN0cm95X21yKCZuZGV2LT5tdmRldik7Cj4+IMKgwqDC
oMKgwqAgbmRldi0+bXZkZXYuc3RhdHVzID0gMDsKPj4gwqDCoMKgwqDCoCBuZGV2LT5jdXJfbnVt
X3ZxcyA9IDA7Cj4+ICvCoMKgwqAgbmRldi0+c3VzcGVuZGVkID0gZmFsc2U7Cj4+IMKgwqDCoMKg
wqAgbmRldi0+bXZkZXYuY3ZxLnJlY2VpdmVkX2Rlc2MgPSAwOwo+PiDCoMKgwqDCoMKgIG5kZXYt
Pm12ZGV2LmN2cS5jb21wbGV0ZWRfZGVzYyA9IDA7Cj4+IMKgwqDCoMKgwqAgbWVtc2V0KG5kZXYt
PmV2ZW50X2NicywgMCwgc2l6ZW9mKCpuZGV2LT5ldmVudF9jYnMpICogCj4+IChtdmRldi0+bWF4
X3ZxcyArIDEpKTsKPj4gQEAgLTI4MTUsNiArMjgyMyw4IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBh
X3N1c3BlbmQoc3RydWN0IHZkcGFfZGV2aWNlIAo+PiAqdmRldikKPj4gwqDCoMKgwqDCoCBzdHJ1
Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1ZSAqbXZxOwo+PiDCoMKgwqDCoMKgIGludCBpOwo+PiDCoCAr
wqDCoMKgIG1seDVfdmRwYV9pbmZvKG12ZGV2LCAic3VzcGVuZGluZyBkZXZpY2VcbiIpOwo+PiAr
Cj4+IMKgwqDCoMKgwqAgZG93bl93cml0ZSgmbmRldi0+cmVzbG9jayk7Cj4+IMKgwqDCoMKgwqAg
bmRldi0+bmJfcmVnaXN0ZXJlZCA9IGZhbHNlOwo+PiDCoMKgwqDCoMKgIG1seDVfbm90aWZpZXJf
dW5yZWdpc3RlcihtdmRldi0+bWRldiwgJm5kZXYtPm5iKTsKPj4gQEAgLTI4MjQsNiArMjgzNCw3
IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX3N1c3BlbmQoc3RydWN0IHZkcGFfZGV2aWNlIAo+PiAq
dmRldikKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHN1c3BlbmRfdnEobmRldiwgbXZxKTsKPj4gwqDC
oMKgwqDCoCB9Cj4+IMKgwqDCoMKgwqAgbWx4NV92ZHBhX2N2cV9zdXNwZW5kKG12ZGV2KTsKPj4g
K8KgwqDCoCBuZGV2LT5zdXNwZW5kZWQgPSB0cnVlOwo+PiDCoMKgwqDCoMKgIHVwX3dyaXRlKCZu
ZGV2LT5yZXNsb2NrKTsKPj4gwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gwqAgfQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
