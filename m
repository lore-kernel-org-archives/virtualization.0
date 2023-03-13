Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66937C6FD19
	for <virtualization@archiver.kernel.org>; Mon, 13 Mar 2023 21:36:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E095C4049D;
	Mon, 13 Mar 2023 21:36:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E095C4049D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=YMFgoKfc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=SWW9HVYB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2EggID7PWSXR; Mon, 13 Mar 2023 21:36:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 04906400D0;
	Mon, 13 Mar 2023 21:36:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 04906400D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D870DC0071;
	Mon, 13 Mar 2023 21:36:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EA76C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 21:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24000417A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 21:36:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24000417A6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=YMFgoKfc; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=SWW9HVYB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id agZuBPsy_hOB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 21:36:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D66A417A5
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D66A417A5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 21:36:35 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32DL4Tga029912; Mon, 13 Mar 2023 21:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=b3yWgViwXxSVtSxI5NUn1UQKpdmSbCm6ZI0oefj5xHk=;
 b=YMFgoKfc8QA0PP4lhE8VDabuKY9ViUlP8Nvjy9C+8BC1BqYkQqL2ADbCESKHT0DZeVBw
 7YiDnGhOh5HRROpwaHFM5R4oH+8qRPFZvrAzhDRCN1lotW7j52AC+p0LRUkvBhex2h7y
 jCFAHlltz65vQ1FhAruNLoPXxZQJd/qjdXFGKhaDN4f4ehoOrCMQaCObe0L6bk+b63+j
 l4ONM3GtRU4tSkgAtC1LCgiS3Y6oyBEn0snsB9M5y0DjdMYTisuiu3CBfkhW7dnznzzE
 Yv/Q+HYP7mOeCZmS6wS8nRCSqJEZZCkB9nj9XT2McUKNCBWFBsoDBdfU/rhQjFb26FWb 9Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8ge2vywh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Mar 2023 21:36:34 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32DKYVN3007941; Mon, 13 Mar 2023 21:36:33 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3p8g35852q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Mar 2023 21:36:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwLw6VZLr1xe38podWt3CnnDkFToiMG9aRt6cePvTnY/CMMsSjV2Kl+Uj1x4ZU0lR6RTNwcJy+XHLoEeP1Wf/LbasTzLZRUV50gGblEHk+SMCOwY4bR32f6VCKvOXNbg+Or+kMBdO0zsIwPjBqia6R9G3dYtn85AFDp2qyQ7WKbMIa4+L0fDb3QdYSW/MgVwedtLh3u6kchBK/rij3ibDwc5kgDIRfsM91Il0RL17XKsOb4Iv+3exCNYv7hpBEvfDkifadCJvm7qMffpcXL1QWOXhGhLpGRAtGxCOwlXVFc9c1MSuGrLzBqsjGgChcGaztMw8ZbqbaMeDoBpHdseQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3yWgViwXxSVtSxI5NUn1UQKpdmSbCm6ZI0oefj5xHk=;
 b=goV+whvOFMTIJUfiFpu/Bvol46/nik5vUuCucGSWAK5LP4bqkhM9wQQaE/aowAkSBYu++h5SFY8fLGiV3IaOBAHvkrEbZMyYPJI1ZbgBHcMTgT9TGgQ1zAvfgu8vnuXBYF//EfE2A2foxf3GpYwGdhympRbZVrLV9pbZ+vCxmw2W9+4bnB8zSidPRSo/L5TzYCYKKOfs+WRkuUq2g9xZ84I6rlECeQrBVYsiORiRSBHW5dUOWdw/48cNt7KLccm7/cjk/Ppu5feU1a5QupYizD0WrgsJn76WNgra8H0iIW4178vndaKntEAPPha9LnQ6/VTodrwPPQWOP/Z2NhexQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3yWgViwXxSVtSxI5NUn1UQKpdmSbCm6ZI0oefj5xHk=;
 b=SWW9HVYBLf4OXvDcjAySJ+b+viRDgKy1wo76i17QKPqD0Z/wcsxPbNN6yLI6VkQWYNEbwEZCi8BkXper8XOFtLWVDHLIbZK69+1KJUN3UmdYdyiAQfKSyE5j3xHWN79fYOS5boHPnjh1ZQ/zYRmUEoVWM3NidGkLls6EDIfPdk8=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by MW4PR10MB6437.namprd10.prod.outlook.com (2603:10b6:303:218::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Mon, 13 Mar
 2023 21:36:30 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 21:36:30 +0000
Message-ID: <ba4c0e09-712f-8222-f9b2-83ba926681b0@oracle.com>
Date: Mon, 13 Mar 2023 14:36:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] vdpa/mlx5: Make VIRTIO_NET_F_MRG_RXBUF off by default
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@mellanox.com>
References: <20230312083920.2300028-1-elic@nvidia.com>
 <20230312083920.2300028-2-elic@nvidia.com>
 <20230312045717-mutt-send-email-mst@kernel.org>
 <f01c7204-5629-297e-47b6-06e58bd3f543@nvidia.com>
 <20230312054559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816C24BAA322567BED21A0DCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230312122355-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548140734E1A0A8A2FD2CE30DCB99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230313172309-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230313172309-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: LNXP123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::27) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|MW4PR10MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: ac34707d-4d7b-4c95-9f3f-08db240b01db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwNX33ZkiykK3j0qZcp5QLP0iX+ZylihtAqdcj3RG8WXnAMTI1Gyz2ZCAff7Dz2MF1HJWuK+CbqqrijNvzEG0KT+D4pK0UNzsH5iL8qd7b0mIqkXy4nHZC92u9GHYLqJCHCU3I8DujAP528U2FiH/PUAHNTqzm80n8Fqc/KhY+IJwn5Gvcgb1edsOd1fwAdn0Mo3JTTdSjYagdLUyVWb3mU/h8dyYMUPKYSD6I/PpnHLoSqj8E/HDmkEUPJLJzkJABg5/7QuVcO4wIi0yrpmqe8Ptdx9hDHury8vrmN9avQLt5ZT4izIRk17R/UgwCiiiSzlVBmdddzMwcOQC6YpK4rdIz6RLJdw9Efn1hP62RKay5rg+cT1Ub4U3+d69RB+sxfcdjSB59aWn+8LDtu8Bm5v5x7/h3+kPc4lZTnXo39eYwZmUH0uOwKDKAhtExjtTzpcQFlQjNg3ocO5B3ZPbW2xsoN17QtmXqSWd6Fyn8bSrbtRoS0O/CUWdyjYf7Ljr4JUeG95ulwvEF2h5dHzHeVXfEgCkkCvf4HY6fu9ka94dEo5l+JppXvNm5WTVqsb0c+lR4tJ6924SPgL2tX+eqg7vLhvT7f4mTZ/B13y9YBmnmfA79ykIJY1QoJE+29Rq8TbPbS/8a6rJkhJkwCJoFjRUbcZkAqscftefd8F/7FqiplmlGUwW6bCPNw6H+t8z8JryuG31UOIlHxPGXyX4in3y3JKt2vG+QqMQHQBh44=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199018)(31686004)(66899018)(83380400001)(2616005)(2906002)(53546011)(6486002)(54906003)(36916002)(36756003)(478600001)(26005)(6666004)(316002)(8936002)(186003)(6506007)(110136005)(6512007)(966005)(38100700002)(86362001)(31696002)(5660300002)(66946007)(4326008)(8676002)(66556008)(66476007)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGh5L01kQ1MyUkErdmF3RkEzMG9Hb1Q5NUhhSmtLaW8vOG5zRlk4WlV1TlJU?=
 =?utf-8?B?MzNOOEd6eStvNytIQ0VyZ2luUTVHUVZhZVNtaVNFalc0WVpqb0pwVnBBOXRo?=
 =?utf-8?B?Z2lBU2VWYnRLb29ibjdZMXFHbFBVOG1Eb0hZRCtXRTg3d2ZCRFVHblRmei9Z?=
 =?utf-8?B?WGRTTUpPbWVGMmM1RHh3eFpWdnZKV2VucUJiVnBWQUd4eWFnUGxEN24xNTRm?=
 =?utf-8?B?YUJ5UFpaRGt0djdML21VM21yem8vSUJ5S0J6UnBmUERaQUZ6aUkxM3pEdTdP?=
 =?utf-8?B?VXBab0RJVEZ4N0RaMzcvUWxUM1VuOUFnU3ZXZTdiY20xbUdyNklSaksxbzZZ?=
 =?utf-8?B?eWNnTXJ5SUVnb29kYm81cmllVXpDZVBySTZzcFpKczZ4RWY1TXNFMzl6c2Jj?=
 =?utf-8?B?ejNldDBITDhjUVRMbFBpcUo4c0ZCQ1F2L2N6MjFEbWJ5aDNlcVNNTDlBVUlT?=
 =?utf-8?B?bnVCdkVYL2F2K2NLODR6ZEE2VmVNK3B5eWhNaW1FdG1BR21sbmtIb2J6bzJU?=
 =?utf-8?B?WC9icHB2eEhCOVRyQ0NPeldFNVlIb2NCR2J0VkdNYXdlWGNDVUlpOFQyZ2l6?=
 =?utf-8?B?SWQwY2NNL3F4Wm5MRThHUDB4c0pOaWlkdXZPRktKVWVYc2RMRnhGS01ZME5N?=
 =?utf-8?B?TFpCRXN2Q0doRDgvazBKUExOdjMrMXUycFFZUGdVVjNlcGMrU0w0MHNKY25Y?=
 =?utf-8?B?UVNqM21DMGZnNjZoNHExYTF2eDF1L2dwSzNuRCtqM0RYWlJTeFZ1SkJmRDht?=
 =?utf-8?B?cDlsVU9tTHNNQkN5Qld4R2ExVVJqQkc1TXpGVk9NVTNYTGxoYm96akVLK2lM?=
 =?utf-8?B?T0lCZG1KNW5PNUhidEQwYkhldWJyTzM2YjRXUUpTbCs1NTlSSkJrWUR1M0hD?=
 =?utf-8?B?V1JGTXB5ajFqYTBvSXk4NWJ3ZjRWWlIzcktzZ3RwYzNUM1Npa0ROMGZtR3Ur?=
 =?utf-8?B?bmN2WXcvOEkyV241WExTTHNUSFAycE1sZHVnbWVFYmhrM1NsdE5taHBsSVpS?=
 =?utf-8?B?NWZHaUM4TEFaaGloQmVZaSs5WTFPNkc3RDNaTDdOaXJLekRobmM3S1lTWTZq?=
 =?utf-8?B?MzM0azBkUERrcWszckRMTytVdFFjRlZBODhjaGZ5ZTNsbWxhMnJCTUF5OUNl?=
 =?utf-8?B?eUo5UEpPalg3NktRK0hHbm10SGF4TGZ5WDJoYkdpa2lWei90dGRHNlBrTjNa?=
 =?utf-8?B?N2xxV1Y3QmlrbHFOekp4dTYwb2Z6eVRzZ2ttQVlWRUpTUGRnWGQweHRQSEhC?=
 =?utf-8?B?YVZ6MCswOGxTQXBGb1M5b2w5bThuU3YwOE80VkRodnNVRloxT2VDMFFSVytY?=
 =?utf-8?B?UmlwbUk4ZWhUSklaMWFEeWNZeHM2ZWNWdVF5TkZJcUJjR2FHc2Ftd1BIc2xl?=
 =?utf-8?B?WVZvQ2I2NnBWNDc1QXoramYyWU9KNkJ3WGFUNHRjZWNmTWV5c1BHZHB0NWFz?=
 =?utf-8?B?QUVHSzFlV0pseElMa2srYWZJQnQraHpNQk1rTGU2a1FvdFRzNndkMVUySC90?=
 =?utf-8?B?ZW1Gcm1GbUNlSGtpKy9SR1hYWDlzYlJ2a0hOWGduQ2owZWM3NG1DNkV0Nzd2?=
 =?utf-8?B?VU5RbWY4ZXlpSHNMSVlEd0FuSDloODhuMWd2VXBHNzNXK2tlQWFMTlorOVNR?=
 =?utf-8?B?bThDd2ZJMXcvVFlHTHRIV0VBdHBpZlREUE45WUNRd1dHdkpCbnhETE5XVFpX?=
 =?utf-8?B?RHZqUklUMEF4K01oYXFNdnplQ2ttK3hWS2U5dUs4cUd2akRvZmUwNWRCeldo?=
 =?utf-8?B?RC9YMGpUKzVUUkp0Rk15ejlUOXRPT2JLWTB3MTJuZjFSU3UyVUduWlRqRnFn?=
 =?utf-8?B?V1lCZmJ1MFdiSFJKU0JTZ21Eb0Z2NFhjejF1d25ncXd6MytBYWc0L29paEFF?=
 =?utf-8?B?dkplUUZVRmx1NmsrT0R6blRnbld5RjBuUDFldys2TUhHT1FOMnZtcHlGZlFr?=
 =?utf-8?B?Tjg0OHEwMXR4U0VQd25DQnlIWDQzTzkzRnRGVDFDVkU0N0REUHpoWlNqSGQ2?=
 =?utf-8?B?WWtNdkJsMHUyRTRHSE1BcTdKZUNndHNZRmFDaitIYk00RDJBMVIrWkFwWi8y?=
 =?utf-8?B?Q20vcjRkMDgrVG5jQVJqOXNMdFdLMjBhVkRuVElRZGRLMkZlcUpKdkMzUFNm?=
 =?utf-8?Q?OcYKKAy7I+27hBIRukhSGpiOI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: af9XT2aIizEvGJhkCFiMrn6W8gTtB4I7wiBRS92fi3UvScfQzt3RxOQN3hwmFJQqbMcGTXWNYylOUNoA3wb1+gGOuouZU28ODvOLwOTXzuLRKr+umdoeaDBRsJYkkOeWU56lkAV//2h56+lGu71FD2Q1stgo+JoCfp+r7famQTbWLOKk5l2/lspta+zktbLJHP3mJbYRPCxCT3CCG/7HxPLTqWRUDa/66N7vQyLM7PvZ79lDCp4qTLhk0CBYvqi19nOtmMXIRRd8aLkjgZBq7h9VFYJ2pVrOe8Th1khgj6VTPs/qFyaKqx4SaxP9tHKcvzJZHzNx3BF03iuNX/JfeuydYdwwboTXskjFoeMFEkmq2ckkxTWvh0+K0skj8DvxadOUZFIDzIbie9LFHbd12UGb6FmCzSY0jNyvMKdBdU0N+zsO+18oY41zjkLXEn4pjIc5BS8T7ncbjoIBN2ydn+I9bKVEgz4IqiHsX6PYSkBBt4iy5q6RbMM0T1chdD7/zRA9SVPcYm0RMlupVL+4KZFTACGKnxL24dTFj0iT55AyXxdvQS11UDNMQabXCDnuT2usGehXN2Gxcg8lXOsSVSaQrqVVv+ZXeVOtzBhxI2JYiMRic1/dtb7YWPvdbB+jsfg+x1Z/RX37Cw6wH1QtG4g9sZcF982VFkynzwaUCLDYgvtgTQQxlGSypZvGqw1T7OU9O+MMdea/BdsuiZlmWPxhY69jIqa/WLD17xM0qEXhO/G3c61JfWDxfcrf6Uv40YG7hFLw4FWQMwEzmWTpmz50Rjhl86hT2crYeIi5szXaFgzb6ngt3K0WcptwkTpF7uyPhHHxKMlUOoBYJh+8tGrNFzJCPuh2BIo06tpqCz2FblxUKKOch6MccoC+8PtY
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac34707d-4d7b-4c95-9f3f-08db240b01db
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 21:36:30.0592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgfovJndIN7NbwXcuoi8L0CV5tJtIV8SSluEigujup+SAJFyTz+t9zkJyC+oCIf2dJ1gmxMpe6TJlKUVVBFQLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_11,2023-03-13_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130169
X-Proofpoint-GUID: FBUnxJsXjVoCm8eg9DR-vC8U3ie1abFs
X-Proofpoint-ORIG-GUID: FBUnxJsXjVoCm8eg9DR-vC8U3ie1abFs
Cc: Eugenio Perez Martin <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "perezma@redhat.com" <perezma@redhat.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 3/13/2023 2:23 PM, Michael S. Tsirkin wrote:
> On Mon, Mar 13, 2023 at 09:14:38PM +0000, Parav Pandit wrote:
>>
>>> From: Michael S. Tsirkin <mst@redhat.com>
>>> Sent: Sunday, March 12, 2023 12:24 PM
>>>
>>> On Sun, Mar 12, 2023 at 01:28:06PM +0000, Parav Pandit wrote:
>>>>
>>>>> From: Michael S. Tsirkin <mst@redhat.com>
>>>>> Sent: Sunday, March 12, 2023 6:25 AM
>>>>>
>>>>> On Sun, Mar 12, 2023 at 11:10:25AM +0200, Eli Cohen wrote:
>>>>>> On 12/03/2023 10:58, Michael S. Tsirkin wrote:
>>>>>>> On Sun, Mar 12, 2023 at 10:39:19AM +0200, Eli Cohen wrote:
>>>>>>>> One can still enable it when creating the vdpa device using
>>>>>>>> vdpa tool by providing features that include it.
>>>>>>>>
>>>>>>>> For example:
>>>>>>>> $ vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2
>>>>>>>> device_features 0x300cb982b
>>>>>>>>
>>>>>>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>>>>>> What's the reason to turn it off by default? It's generally a
>>>>>>> performance win isn't it?
>>>>>> It has negative impact on packet rate so we want to keep it off by default.
>>>> The performance characteristics is very workload specific.
>>>> It is less of interest given the primary reason is backward compatibility, more
>>> below.
>>>>> Interesting.  I feel this would benefit from a bit more analysis.
>>>>> Packet rate with dpdk? With linux? Is there a chance this will
>>>>> regress some workloads?
>>>>> VIRTIO_NET_F_MRG_RXBUF was designed to save memory, which is good
>>>>> for small tcp buffers.
>>>> Eli,
>>>> Please update the commit message.
>>>> This change is to avoid regression in existing systems.
>>>> The device previously didn't report MRG_RXBUF cap and it was not in use.
>>>> Lately, certain devices are reporting this feature bit and it is breaking the
>>> backward compatibility.
>>>> So the driver keeps it disabled by default.
>>>> User should enable it when user prefers to.
>>> OK. And which commit changes that?
>> vdpa dev add command [1] has the ability to set the desired features.
>> The commit log of this patch has an example too.
>>
>> [1] https://elixir.bootlin.com/linux/v6.3-rc2/C/ident/vdpa_nl_cmd_dev_add_set_doit
> I mean if this is claiming to fix a performance regression it should have
> a Fixes: tag with the commit that introduced the regression.
I guess Eli and Parav may refer to the case where the hardware/firmware 
is going to offer VIRTIO_NET_F_MRG_RXBUF feature which has sort of 
performance impact to certain type of workload, while they want to keep 
the performance promise for the default vdap dev creation without having 
to mask the corresponding feature bit by explicitly specifying 
device_features. I don't think Fixes: tag is applicable here, right?

-Siwei




_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
