Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC4DC433EF
	for <virtualization@archiver.kernel.org>; Wed, 15 Dec 2021 20:52:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D64060F42;
	Wed, 15 Dec 2021 20:52:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oAlZglj5RFNw; Wed, 15 Dec 2021 20:52:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8614F60F33;
	Wed, 15 Dec 2021 20:52:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C080C002F;
	Wed, 15 Dec 2021 20:52:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41989C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 20:52:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 25E3D40A38
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 20:52:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="OdTIrsmL";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="a5cwChzc"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id elmfgI3Cyk_I
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 20:52:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1A36D40A3B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 20:52:32 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFIGTup018877; 
 Wed, 15 Dec 2021 20:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6/hG+9/RQhME6Mcsws6mdOxIpDo5UWMO5QZkAeg1hr4=;
 b=OdTIrsmLTiHkSK9bq/C6Yf7E5nFf0z2fD2n3QNSRu/EY/du5iGUW7KjHEkIfWVX72S+K
 UJhiRKtRBIYcYsILnqdXr8z/cGjBmR+DPw9n+ruewURxJSptB1yDhTH9wWHoUyvk9RYr
 sm7V/gyvN2G0STlx3Ks9R1KbKfypecehLnpUU016SmcCbFbCiT2PijFTFNnUYvbQJmTr
 NiRPdCGqiRJVPe5o6+RvM1N/8u2QextWYeBxgtZw9Ihw4livBrLBVwqk3R4tlQmy+8A3
 EbQA6YPxvqsZg+1/tIk9tf5tc42m/17lmDOZKBuv5YlDcLvQB3fDApE9ALMrlpsOyBaW ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cyknrgtcj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Dec 2021 20:52:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BFKjkfY029032;
 Wed, 15 Dec 2021 20:52:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
 by userp3020.oracle.com with ESMTP id 3cvnesj2t9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Dec 2021 20:52:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RD2+J91BhdVl1sBQwV3ZEKyriiYHNOpT08+cU34Tq106TDBXQqFs+vCodvIiwZVJeDtBeFJUvL5lAxNWEJHK46C9ygLcyfsbs3lApU0dPy6eYSzr4hEWYhtLrZh3Xl73U6asACgxPkOG+ODIQU4Yc6qx00fCk0SLCINa+FKYcrgYurqszDaavqQSLVxZ5fMkEe0m7/+gxpSAeSiR25re30JzwTnAvPBbrUIRsIVRClBgytU3HQvQPGEcTnk+CnnaxtzK7Y/DyVxShlBo7bWUHaBL7jI2pDHHfTl04PzrxZPLuXVKWtvu+ThjaitrvomH8n3abkGyv3Vm23kaHuxn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/hG+9/RQhME6Mcsws6mdOxIpDo5UWMO5QZkAeg1hr4=;
 b=Yi/DMUvTm05XJQmRqAFxGPvUEYmSdTIe563KJtVEKvrl5r/Zv8T7GvYvLzGm9epQ6E3WAVGRhAO7lyhQArFJZiVQO6Dqc2sJ9r/Sd3mekJtmk0gpvRljHdHkRLwvwGpMYyyoDkUtgKdxvzh06j0pLRWMTB03sKgxW+xXhUjr7vTFlCd0AFovrvyBqthN6kPsoBXtDhugMWB3Zc/cmtM+9NpOuiyLZcIpD/RCrDWI8zmc0bX9BruqcbevsdKPbY32pC1jRRG9iNrVaPSK0IuuaeyRBlS2lx24wijnTDUK4w0Zpr05CsnDuPAyaVCqV8ojrLXgwYfjKNP/x9G5cHgXDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/hG+9/RQhME6Mcsws6mdOxIpDo5UWMO5QZkAeg1hr4=;
 b=a5cwChzcKTCVbwUbAtL/rbdUzPxuqwhW5fyRvbMz6m6D3xgnIKmRIlEc1kO0G4O5vcHo7j/NcKyMNl3fJs9j/6GKx/2Ri8Clezlm6c0kTva1dHLdhuAlpg0Ee8WN9hyXrMDiBc6FDY867a4fSyfiZQczMKHzCdVJs9jwna+sAXo=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB4337.namprd10.prod.outlook.com (2603:10b6:a03:201::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 20:52:26 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 20:52:26 +0000
Message-ID: <6eaf672c-cc86-b5bf-5b74-c837affeb6e1@oracle.com>
Date: Wed, 15 Dec 2021 12:52:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: vdpa legacy guest support (was Re: [PATCH] vdpa/mlx5:
 set_features should allow reset to zero)
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
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
 <4fc43d0f-da9e-ce16-1f26-9f0225239b75@oracle.com>
 <CACGkMEsttnFEKGK-aKdCZeXkUnZJg1uaqYzFqpv-g5TobHGSzQ@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEsttnFEKGK-aKdCZeXkUnZJg1uaqYzFqpv-g5TobHGSzQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR01CA0027.prod.exchangelabs.com (2603:10b6:a02:80::40)
 To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b836775-d1db-46c1-3b86-08d9c00ccce8
X-MS-TrafficTypeDiagnostic: BY5PR10MB4337:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4337195B3B89D16FA59BF994B1769@BY5PR10MB4337.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Vq9mpMWgumt19k2R7AzotPDX1li1Yka/EbMmL5WZozS9Q6RnDAYvlWH+OGgteKp5JyKIhJMJCdTJPWbdZ6Vhku+71zEGOOQooMFcwCsZ5gmpsPcrbIlDvUJn1PxT3aTxlKFJsz7aecbwugT6csTbfPOBIBGducJrA0daXONyUvFjSh+FvRslBgytvWdRhnqUEkZLJbuOkztX52Pj/cXty4Ynw6ce9uhCItih6HgkbStN/1IcjZnxMMx2f1ohzOXR5pS5xXD6BZJScKDgwl4FREsh9VqyGGON6RARECPm9mF/zgVA9NaG/3qDx52KM8wOAuIKClZtNo7KenW+aoTY38AQip5lEAkmXkkvCl5n5yHTlOW+3Yh7cl6XLrNEv9xaCi158kmUTntQb5at0IEGR0U+fuHcULISrim9hmEac6iDhI/OtW/PLsUv/67lml/3CNxM+Nzxncy/aYkI24zHdGmfu96lLzOge2FQw0qSzIhZoqOMHXts1AZUf8PwoaRQtUHuJUvFRMnVTb3nAKltM40wmqYNaCdPYc98jH2l9i0/4LEi0C/M4g15gtv+7KILt0RFmCbGyJwW+aZnjiSlbh7ZnTTKmzgMEDuS+e2YMuEXEHgPAqrLvydEu4Rh9f1yKxLvR1iv+Cc+n4DWU3GrnutlPxqU44wHj/2aXnuyNQmlHHbRqe/x1G1/JxXjKSOxXKr4dFqjHuYDXqkIUEJHNs/lr+avB9sD0zEcOHDI1WlHqLjHMUGTx+gZtg/PP6sQS/uKwp9oHH3mbRGwPO/Xr/R46ppfbG3qGxXc7+MjUR2ZIE51g46pIUpGEQvbL4M
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(31686004)(36916002)(66556008)(4326008)(36756003)(2616005)(6506007)(86362001)(53546011)(6512007)(8936002)(6666004)(966005)(6486002)(5660300002)(2906002)(26005)(6916009)(38100700002)(186003)(316002)(66946007)(8676002)(83380400001)(66476007)(54906003)(508600001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGpkN1F0eXFJY2k2T3FSWXZEaFhNNFF5K1oxNVlHbUQ5a2xkamQwNDh0c3dM?=
 =?utf-8?B?U2lkYnJwYkhGUlNWaytUaHJEMDNjSnJrMkxuR0M5dWVhcjhOQTF2bnlDbmg1?=
 =?utf-8?B?T1FYQlkvYW5OajV2Q3FvQTBVZ0UwckVaMkV5ZFhrZkh1ZlpSa3BHMll6cTA5?=
 =?utf-8?B?Z0EvMmQwcE43cVlaQVFjcWh5Z2FNVlhLZVcvbjBIWTJXN1kzWXVVUFZqQzl4?=
 =?utf-8?B?U21aZlY0RlNsYjF5dldiTTVwams0NGNDRGd3c3ZkdDNkNHhsQWVZaG9oWGxo?=
 =?utf-8?B?WlppYVdUUGw1Z1lHaFFZdmVJOTFIVEpMaGdUL0thaWNFN1MrR3dSZmVJRWoz?=
 =?utf-8?B?MDJDcTNVNFZvSXloaEdiNmR2ZE9FTUwrNnpNZWxwa0hLN2NTR29HbU1Ud2Yr?=
 =?utf-8?B?S0xRRUhWcXdsV2JGOHlHOENXdlZxTERUMVpxQVhnZWxwanJ1cEwwbHAyK1R2?=
 =?utf-8?B?cFlPTEpvV2J3Z2xUWEREbTVuVzNYb1hRVWt3ZXBZdkxidUduRUdzZFloVWl2?=
 =?utf-8?B?UHcvOGo0Vm5UVk50V1FKbkR3ZHQxZTJ6T3JFSSsyaEtyc2pKbWMrdEtMcUZQ?=
 =?utf-8?B?TnU3N3lQcG02K0pIQjU4bnZrNFBtQjlyQ1lqTFRPaDV3bVNhTi9CYVliQXhp?=
 =?utf-8?B?UitqVXVDZW4xRmw2WGNRVi9VQzY1LzErTkhTdExkY3VGTFpOSjBrczU5R2Mx?=
 =?utf-8?B?L3NUVlhUU1J4VExYNXFKSy9UTnhWMGwweTZiOUdqZUI2WEl4dFRnSW9KTU9y?=
 =?utf-8?B?N3FVRnpYK1dKVDNDVk5obXFrbHpqWkhQVDVwWHp0R2FBSEhnMlkyOWlJakdO?=
 =?utf-8?B?TGZ5YndKdkN1UVROQVlhMDZ3V2dBWUtiNjBUczF3aTY0TTMvMzd5d05CQ1p1?=
 =?utf-8?B?cEVsaVFQaXlhckg5MklhdmVIK2VRWmQ4MkxveWVsVDFGNEZsVHZZWkR6TDZx?=
 =?utf-8?B?S3dSTjR3RWRFamlRZm04S3RDOWZqNFNhc3l4akZ0a3YvQXpwV3NWMUNCd1Er?=
 =?utf-8?B?V0JVRzlMMTVXcjFOaXJRTnZmV1FWcXY4R1RYejFxWmJkZ3F6T0RBMFVOVWJi?=
 =?utf-8?B?Z3JkRUpqUkVvWWJ0VXo2UmNqbU5kT3VzVTVwR01jN0VWaE9qVm4vMnNVSHZn?=
 =?utf-8?B?VDhjeGZ0VkZybHJRMU8wNmxQNExZMGVKYWcrU21DbjFSR1gwMWgyVmx6K2Q4?=
 =?utf-8?B?Q1FST01KcFFnT3VQTlFOSTMvam81aTF3WnBMSnhMeXAvKy9YOER6MWdCRlV3?=
 =?utf-8?B?YWQ5cUlmQ3V6MjVnL3pseVJ5RWlSeWNXN3lTRHhxMzAwMkcwODVzbXFsc3ZB?=
 =?utf-8?B?eVU4Q014bVVqd0ZxZlVrdWZNNTVERGRYY2NsdTlnNVIwQlR0QXVpQXdKQXBF?=
 =?utf-8?B?clVmaTFDVW16NGxreXpNb2ZQT0gyQ1VGQzJjUmFYMyt0RWU1bUxCbmpkd2tB?=
 =?utf-8?B?Y3d2TWxaQ2NGbVNlRFFzM1FTYTRtS0twUStmM2Z2WU50cEFXRzBHMmMzNjZa?=
 =?utf-8?B?bGxNQ2xGUUxpU1dXdDgrSVh6U0gxTjZBM1laL0tJbUV0ampPYVF0MGdkWXNU?=
 =?utf-8?B?RHc5RXBhaXBSdWx3QUx3dWJEWWkvNzJGWUIxOHZETW1JdXlkZzEySXJUc0hK?=
 =?utf-8?B?QmhsKzdxalBESXZBYVA0R2dkZndmS1FBczlEeWE1UXFyN2tRMjRyaHJKdDF3?=
 =?utf-8?B?RDFoVHVnV2dEcE5sdWdyVW0wT1hDdU1CbllQZE9WdGRkYlpRQkRRaHUwZ1Mz?=
 =?utf-8?B?ZzBIS3phQmtuOEI1SSt1eTRiMzVKZVdpbUI1NVBXMFo2YmR5Q0xxb2U4bitB?=
 =?utf-8?B?Q21KZnlFeTJIdzBaL3dmWVZmei9xdzErWU0yanlrMjNEcDRFWXA0R3BLNmIw?=
 =?utf-8?B?WGtMVStGUStVQkQvWDUzelpjdjJkNVRtRDlqb280YzNCOVB3b1luV2htejl4?=
 =?utf-8?B?SWVsaytYc1NYeDArK09oR2s3T3o5bnFPMTFRd2tqTmNNZFNKaGt3bEp5R0hE?=
 =?utf-8?B?NWpqRzVPb09yWm9kYStjK3djbHYwZlc0ckMvUjVIMXZNb0RneDdyY3BndVRY?=
 =?utf-8?B?VTdpeHpKSThzRndaMkVmcFAwcW40ZEtmcVQwd1ZHM3R0VkZnY0ZBcVIrMG85?=
 =?utf-8?B?dVdYTnp3Y3ZmODc0M0pYNTMxcEpPTGtSWDlQcm40SUlxVm40ZEsxODBNMkN5?=
 =?utf-8?Q?9OnVRSxQOr4o2mAh1YGzIu4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b836775-d1db-46c1-3b86-08d9c00ccce8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 20:52:26.5016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xGk5SIlX0Lf4ufDQCfFslrKDBa53lRGiKTdKrGrtgDo0ToZMLMkHCDeF2tzl/aGRI8QG05mwmEqzOC2RA/biw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4337
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112150115
X-Proofpoint-ORIG-GUID: n21MkkjZeAG1tKzKewt4luP6lUl6y_C9
X-Proofpoint-GUID: n21MkkjZeAG1tKzKewt4luP6lUl6y_C9
Cc: netdev <netdev@vger.kernel.org>, Eli Cohen <elic@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

CgpPbiAxMi8xNC8yMDIxIDY6MDYgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4gT24gV2VkLCBEZWMg
MTUsIDIwMjEgYXQgOTowNSBBTSBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+IHdy
b3RlOgo+Pgo+Pgo+PiBPbiAxMi8xMy8yMDIxIDk6MDYgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3
cm90ZToKPj4+IE9uIE1vbiwgRGVjIDEzLCAyMDIxIGF0IDA1OjU5OjQ1UE0gLTA4MDAsIFNpLVdl
aSBMaXUgd3JvdGU6Cj4+Pj4gT24gMTIvMTIvMjAyMSAxOjI2IEFNLCBNaWNoYWVsIFMuIFRzaXJr
aW4gd3JvdGU6Cj4+Pj4+IE9uIEZyaSwgRGVjIDEwLCAyMDIxIGF0IDA1OjQ0OjE1UE0gLTA4MDAs
IFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4+PiBTb3JyeSBmb3IgcmV2aXZpbmcgdGhpcyBhbmNpZW50
IHRocmVhZC4gSSB3YXMga2luZGEgbG9zdCBmb3IgdGhlIGNvbmNsdXNpb24KPj4+Pj4+IGl0IGVu
ZGVkIHVwIHdpdGguIEkgaGF2ZSB0aGUgZm9sbG93aW5nIHF1ZXN0aW9ucywKPj4+Pj4+Cj4+Pj4+
PiAxLiBsZWdhY3kgZ3Vlc3Qgc3VwcG9ydDogZnJvbSB0aGUgcGFzdCBjb252ZXJzYXRpb25zIGl0
IGRvZXNuJ3Qgc2VlbSB0aGUKPj4+Pj4+IHN1cHBvcnQgd2lsbCBiZSBjb21wbGV0ZWx5IGRyb3Bw
ZWQgZnJvbSB0aGUgdGFibGUsIGlzIG15IHVuZGVyc3RhbmRpbmcKPj4+Pj4+IGNvcnJlY3Q/IEFj
dHVhbGx5IHdlJ3JlIGludGVyZXN0ZWQgaW4gc3VwcG9ydGluZyB2aXJ0aW8gdjAuOTUgZ3Vlc3Qg
Zm9yIHg4NiwKPj4+Pj4+IHdoaWNoIGlzIGJhY2tlZCBieSB0aGUgc3BlYyBhdAo+Pj4+Pj4gaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vb3psYWJzLm9yZy8qcnVzdHkvdmlydGlv
LXNwZWMvdmlydGlvLTAuOS41LnBkZl9fO2ZnISFBQ1dWNU45TTJSVjk5aFEhZFRLbXpKd3dSc0ZN
N0J0U3VURHUxY05seTVuNFhDb3RIMFdZbWlkekdxSFNYdDQwaTdaVTQzVWNOZzdHWXhaZyQgLiBU
aG91Z2ggSSdtIG5vdCBzdXJlCj4+Pj4+PiBpZiB0aGVyZSdzIHJlcXVlc3QvbmVlZCB0byBzdXBw
b3J0IHdpbGRlciBsZWdhY3kgdmlydGlvIHZlcnNpb25zIGVhcmxpZXIKPj4+Pj4+IGJleW9uZC4K
Pj4+Pj4gSSBwZXJzb25hbGx5IGZlZWwgaXQncyBsZXNzIHdvcmsgdG8gYWRkIGluIGtlcm5lbCB0
aGFuIHRyeSB0bwo+Pj4+PiB3b3JrIGFyb3VuZCBpdCBpbiB1c2Vyc3BhY2UuIEphc29uIGZlZWxz
IGRpZmZlcmVudGx5Lgo+Pj4+PiBNYXliZSBwb3N0IHRoZSBwYXRjaGVzIGFuZCB0aGlzIHdpbGwg
cHJvdmUgdG8gSmFzb24gaXQncyBub3QKPj4+Pj4gdG9vIHRlcnJpYmxlPwo+Pj4+IEkgc3VwcG9z
ZSBpZiB0aGUgdmRwYSB2ZW5kb3IgZG9lcyBzdXBwb3J0IDAuOTUgaW4gdGhlIGRhdGFwYXRoIGFu
ZCByaW5nCj4+Pj4gbGF5b3V0IGxldmVsIGFuZCBpcyBsaW1pdGVkIHRvIHg4NiBvbmx5LCB0aGVy
ZSBzaG91bGQgYmUgZWFzeSB3YXkgb3V0Lgo+Pj4gTm90ZSBhIHN1YnRsZSBkaWZmZXJlbmNlOiB3
aGF0IG1hdHRlcnMgaXMgdGhhdCBndWVzdCwgbm90IGhvc3QgaXMgeDg2Lgo+Pj4gTWF0dGVycyBm
b3IgZW11bGF0b3JzIHdoaWNoIG1pZ2h0IHJlb3JkZXIgbWVtb3J5IGFjY2Vzc2VzLgo+Pj4gSSBn
dWVzcyB0aGlzIGVuZm9yY2VtZW50IGJlbG9uZ3MgaW4gUUVNVSB0aGVuPwo+PiBSaWdodCwgSSBt
ZWFuIHRvIGdldCBzdGFydGVkLCB0aGUgaW5pdGlhbCBndWVzdCBkcml2ZXIgc3VwcG9ydCBhbmQg
dGhlCj4+IGNvcnJlc3BvbmRpbmcgUUVNVSBzdXBwb3J0IGZvciB0cmFuc2l0aW9uYWwgdmRwYSBi
YWNrZW5kIGNhbiBiZSBsaW1pdGVkCj4+IHRvIHg4NiBndWVzdC9ob3N0IG9ubHkuIFNpbmNlIHRo
ZSBjb25maWcgc3BhY2UgaXMgZW11bGF0ZWQgaW4gUUVNVSwgSQo+PiBzdXBwb3NlIGl0J3Mgbm90
IGhhcmQgdG8gZW5mb3JjZSBpbiBRRU1VLgo+IEl0J3MgbW9yZSB0aGFuIGp1c3QgY29uZmlnIHNw
YWNlLCBtb3N0IGRldmljZXMgaGF2ZSBoZWFkZXJzIGJlZm9yZSB0aGUgYnVmZmVyLgpUaGUgb3Jk
ZXJpbmcgaW4gZGF0YXBhdGggKGRhdGEgVlFzKSB3b3VsZCBoYXZlIHRvIHJlbHkgb24gdmVuZG9y
J3MgCnN1cHBvcnQuIFNpbmNlIE9SREVSX1BMQVRGT1JNIGlzIHByZXR0eSBuZXcgKHYxLjEpLCBJ
IGd1ZXNzIHZkcGEgaC93IAp2ZW5kb3Igbm93YWRheXMgY2FuL3Nob3VsZCB3ZWxsIHN1cHBvcnQg
dGhlIGNhc2Ugd2hlbiBPUkRFUl9QTEFURk9STSBpcyAKbm90IGFja2VkIGJ5IHRoZSBkcml2ZXIg
KGFjdHVhbGx5IHRoaXMgZmVhdHVyZSBpcyBmaWx0ZXJlZCBvdXQgYnkgdGhlIApRRU1VIHZob3N0
LXZkcGEgZHJpdmVyIHRvZGF5KSwgZXZlbiB3aXRoIHYxLjAgc3BlYyBjb25mb3JtaW5nIGFuZCBt
b2Rlcm4gCm9ubHkgdkRQQSBkZXZpY2UuIFRoZSBjb250cm9sIFZRIGlzIGltcGxlbWVudGVkIGlu
IHNvZnR3YXJlIGluIHRoZSAKa2VybmVsLCB3aGljaCBjYW4gYmUgZWFzaWx5IGFjY29tbW9kYXRl
ZC9maXhlZCB3aGVuIG5lZWRlZC4KCj4KPj4gUUVNVSBjYW4gZHJpdmUgR0VUX0xFR0FDWSwKPj4g
R0VUX0VORElBTiBldCBhbCBpb2N0bHMgaW4gYWR2YW5jZSB0byBnZXQgdGhlIGNhcGFiaWxpdHkg
ZnJvbSB0aGUKPj4gaW5kaXZpZHVhbCB2ZW5kb3IgZHJpdmVyLiBGb3IgdGhhdCwgd2UgbmVlZCBh
bm90aGVyIG5lZ290aWF0aW9uIHByb3RvY29sCj4+IHNpbWlsYXIgdG8gdmhvc3RfdXNlcidzIHBy
b3RvY29sX2ZlYXR1cmVzIGJldHdlZW4gdGhlIHZkcGEga2VybmVsIGFuZAo+PiBRRU1VLCB3YXkg
YmVmb3JlIHRoZSBndWVzdCBkcml2ZXIgaXMgZXZlciBwcm9iZWQgYW5kIGl0cyBmZWF0dXJlCj4+
IG5lZ290aWF0aW9uIGtpY2tzIGluLiBOb3Qgc3VyZSB3ZSBuZWVkIGEgR0VUX01FTU9SWV9PUkRF
UiBpb2N0bCBjYWxsCj4+IGZyb20gdGhlIGRldmljZSwgYnV0IHdlIGNhbiBhc3N1bWUgd2VhayBv
cmRlcmluZyBmb3IgbGVnYWN5IGF0IHRoaXMKPj4gcG9pbnQgKHg4NiBvbmx5KT8KPiBJJ20gbG9z
dCBoZXJlLCB3ZSBoYXZlIGdldF9mZWF0dXJlcygpIHNvOgpJIGFzc3VtZSBoZXJlIHlvdSByZWZl
ciB0byBnZXRfZGV2aWNlX2ZlYXR1cmVzKCkgdGhhdCBFbGkganVzdCBjaGFuZ2VkIAp0aGUgbmFt
ZS4KPgo+IDEpIFZFUlNJT05fMSBtZWFucyB0aGUgZGV2aWNlIHVzZXMgTEUgaWYgcHJvdmlkZWQs
IG90aGVyd2lzZSBuYXR2aWUKPiAyKSBPUkRFUl9QTEFURk9STSBtZWFucyBkZXZpY2UgcmVxdWly
ZXMgcGxhdGZvcm0gb3JkZXJpbmcKPgo+IEFueSByZWFzb24gZm9yIGhhdmluZyBhIG5ldyBBUEkg
Zm9yIHRoaXM/CkFyZSB5b3UgZ29pbmcgdG8gZW5mb3JjZSBhbGwgdkRQQSBoYXJkd2FyZSB2ZW5k
b3JzIHRvIHN1cHBvcnQgdGhlIAp0cmFuc2l0aW9uYWwgbW9kZWwgZm9yIGxlZ2FjeSBndWVzdD8g
bWVhbmluZyBndWVzdCBub3QgYWNrbm93bGVkZ2luZyAKVkVSU0lPTl8xIHdvdWxkIHVzZSB0aGUg
bGVnYWN5IGludGVyZmFjZXMgY2FwdHVyZWQgaW4gdGhlIHNwZWMgc2VjdGlvbiAKNy40IChyZWdh
cmRpbmcgcmluZyBsYXlvdXQsIG5hdGl2ZSBlbmRpYW5uZXNzLCBtZXNzYWdlIGZyYW1pbmcsIHZx
IAphbGlnbm1lbnQgb2YgNDA5NiwgMzJiaXQgZmVhdHVyZSwgbm8gZmVhdHVyZXNfb2sgYml0IGlu
IHN0YXR1cywgSU8gcG9ydCAKaW50ZXJmYWNlIGkuZS4gYWxsIHRoZSB0aGluZ3MpIGluc3RlYWQ/
IE5vdGVkIHdlIGRvbid0IHlldCBoYXZlIGEgCnNldF9kZXZpY2VfZmVhdHVyZXMoKSB0aGF0IGFs
bG93cyB0aGUgdmRwYSBkZXZpY2UgdG8gdGVsbCB3aGV0aGVyIGl0IGlzIApvcGVyYXRpbmcgaW4g
dHJhbnNpdGlvbmFsIG9yIG1vZGVybi1vbmx5IG1vZGUuIEZvciBzb2Z0d2FyZSB2aXJ0aW8sIGFs
bCAKc3VwcG9ydCBmb3IgdGhlIGxlZ2FjeSBwYXJ0IGluIGEgdHJhbnNpdGlvbmFsIG1vZGVsIGhh
cyBiZWVuIGJ1aWx0IHVwIAp0aGVyZSBhbHJlYWR5LCBob3dldmVyLCBpdCdzIG5vdCBlYXN5IGZv
ciB2RFBBIHZlbmRvcnMgdG8gaW1wbGVtZW50IGFsbCAKdGhlIHJlcXVpcmVtZW50cyBmb3IgYW4g
YWxsLW9yLW5vdGhpbmcgbGVnYWN5IGd1ZXN0IHN1cHBvcnQgKGJpZyBlbmRpYW4gCmd1ZXN0IGZv
ciBleGFtcGxlKS4gVG8gdGhlc2UgdmVuZG9ycywgdGhlIGxlZ2FjeSBzdXBwb3J0IHdpdGhpbiBh
IAp0cmFuc2l0aW9uYWwgbW9kZWwgaXMgbW9yZSBvZiBmZWF0dXJlIHRvIHRoZW0gYW5kIGl0J3Mg
YmVzdCB0byBsZWF2ZSAKc29tZSBmbGV4aWJpbGl0eSBmb3IgdGhlbSB0byBpbXBsZW1lbnQgcGFy
dGlhbCBzdXBwb3J0IGZvciBsZWdhY3kuIFRoYXQgCmluIHR1cm4gY2FsbHMgb3V0IHRoZSBuZWVk
IGZvciBhIHZob3N0LXVzZXIgcHJvdG9jb2wgZmVhdHVyZSBsaWtlIApuZWdvdGlhdGlvbiBBUEkg
dGhhdCBjYW4gcHJvaGliaXQgdGhvc2UgdW5zdXBwb3J0ZWQgZ3Vlc3Qgc2V0dXBzIHRvIGFzIApl
YXJseSBhcyBiYWNrZW5kX2luaXQgYmVmb3JlIGxhdW5jaGluZyB0aGUgVk0uCgoKPgo+Pj4+IEkK
Pj4+PiBjaGVja2VkIHdpdGggRWxpIGFuZCBvdGhlciBNZWxsYW5veC9OVkRJQSBmb2xrcyBmb3Ig
aGFyZHdhcmUvZmlybXdhcmUgbGV2ZWwKPj4+PiAwLjk1IHN1cHBvcnQsIGl0IHNlZW1zIGFsbCB0
aGUgaW5ncmVkaWVudCBoYWQgYmVlbiB0aGVyZSBhbHJlYWR5IGRhdGVkIGJhY2sKPj4+PiB0byB0
aGUgRFBESyBkYXlzLiBUaGUgb25seSBtYWpvciB0aGluZyBsaW1pdGluZyBpcyBpbiB0aGUgdkRQ
QSBzb2Z0d2FyZSB0aGF0Cj4+Pj4gdGhlIGN1cnJlbnQgdmRwYSBjb3JlIGhhcyB0aGUgYXNzdW1w
dGlvbiBhcm91bmQgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIGZvcgo+Pj4+IGEgZmV3IERNQSBz
ZXR1cCBvcHMsIHdoaWNoIGlzIHZpcnRpbyAxLjAgb25seS4KPj4+Pgo+Pj4+Pj4gMi4gc3VwcG9z
ZSBzb21lIGZvcm0gb2YgbGVnYWN5IGd1ZXN0IHN1cHBvcnQgbmVlZHMgdG8gYmUgdGhlcmUsIGhv
dyBkbyB3ZQo+Pj4+Pj4gZGVhbCB3aXRoIHRoZSBib2d1cyBhc3N1bXB0aW9uIGJlbG93IGluIHZk
cGFfZ2V0X2NvbmZpZygpIGluIHRoZSBzaG9ydCB0ZXJtPwo+Pj4+Pj4gSXQgbG9va3Mgb25lIG9m
IHRoZSBpbnR1aXRpdmUgZml4IGlzIHRvIG1vdmUgdGhlIHZkcGFfc2V0X2ZlYXR1cmVzIGNhbGwg
b3V0Cj4+Pj4+PiBvZiB2ZHBhX2dldF9jb25maWcoKSB0byB2ZHBhX3NldF9jb25maWcoKS4KPj4+
Pj4+Cj4+Pj4+PiAgICAgICAgICAgIC8qCj4+Pj4+PiAgICAgICAgICAgICAqIENvbmZpZyBhY2Nl
c3NlcyBhcmVuJ3Qgc3VwcG9zZWQgdG8gdHJpZ2dlciBiZWZvcmUgZmVhdHVyZXMgYXJlCj4+Pj4+
PiBzZXQuCj4+Pj4+PiAgICAgICAgICAgICAqIElmIGl0IGRvZXMgaGFwcGVuIHdlIGFzc3VtZSBh
IGxlZ2FjeSBndWVzdC4KPj4+Pj4+ICAgICAgICAgICAgICovCj4+Pj4+PiAgICAgICAgICAgIGlm
ICghdmRldi0+ZmVhdHVyZXNfdmFsaWQpCj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgdmRwYV9z
ZXRfZmVhdHVyZXModmRldiwgMCk7Cj4+Pj4+PiAgICAgICAgICAgIG9wcy0+Z2V0X2NvbmZpZyh2
ZGV2LCBvZmZzZXQsIGJ1ZiwgbGVuKTsKPj4+Pj4+Cj4+Pj4+PiBJIGNhbiBwb3N0IGEgcGF0Y2gg
dG8gZml4IDIpIGlmIHRoZXJlJ3MgY29uc2Vuc3VzIGFscmVhZHkgcmVhY2hlZC4KPj4+Pj4+Cj4+
Pj4+PiBUaGFua3MsCj4+Pj4+PiAtU2l3ZWkKPj4+Pj4gSSdtIG5vdCBzdXJlIGhvdyBpbXBvcnRh
bnQgaXQgaXMgdG8gY2hhbmdlIHRoYXQuCj4+Pj4+IEluIGFueSBjYXNlIGl0IG9ubHkgYWZmZWN0
cyB0cmFuc2l0aW9uYWwgZGV2aWNlcywgcmlnaHQ/Cj4+Pj4+IExlZ2FjeSBvbmx5IHNob3VsZCBu
b3QgY2FyZSAuLi4KPj4+PiBZZXMgSSdkIGxpa2UgdG8gZGlzdGluZ3Vpc2ggbGVnYWN5IGRyaXZl
ciAoc3VwcG9zZSBpdCBpcyAwLjk1KSBhZ2FpbnN0IHRoZQo+Pj4+IG1vZGVybiBvbmUgaW4gYSB0
cmFuc2l0aW9uYWwgZGV2aWNlIG1vZGVsIHJhdGhlciB0aGFuIGJlaW5nIGxlZ2FjeSBvbmx5Lgo+
Pj4+IFRoYXQgd2F5IGEgdjAuOTUgYW5kIHYxLjAgc3VwcG9ydGluZyB2ZHBhIHBhcmVudCBjYW4g
c3VwcG9ydCBib3RoIHR5cGVzIG9mCj4+Pj4gZ3Vlc3RzIHdpdGhvdXQgaGF2aW5nIHRvIHJlY29u
ZmlndXJlLiBPciBhcmUgeW91IHN1Z2dlc3RpbmcgbGltaXQgdG8gbGVnYWN5Cj4+Pj4gb25seSBh
dCB0aGUgdGltZSBvZiB2ZHBhIGNyZWF0aW9uIHdvdWxkIHNpbXBsaWZ5IHRoZSBpbXBsZW1lbnRh
dGlvbiBhIGxvdD8KPj4+Pgo+Pj4+IFRoYW5rcywKPj4+PiAtU2l3ZWkKPj4+IEkgZG9uJ3Qga25v
dyBmb3Igc3VyZS4gVGFrZSBhIGxvb2sgYXQgdGhlIHdvcmsgSGFsaWwgd2FzIGRvaW5nCj4+PiB0
byB0cnkgYW5kIHN1cHBvcnQgdHJhbnNpdGlvbmFsIGRldmljZXMgd2l0aCBCRSBndWVzdHMuCj4+
IEhtbW0sIHdlIGNhbiBoYXZlIHRob3NlIGVuZGlhbm5lc3MgaW9jdGxzIGRlZmluZWQgYnV0IHRo
ZSBpbml0aWFsIFFFTVUKPj4gaW1wbGVtZW50YXRpb24gY2FuIGJlIHN0YXJ0ZWQgdG8gc3VwcG9y
dCB4ODYgZ3Vlc3QvaG9zdCB3aXRoIGxpdHRsZQo+PiBlbmRpYW4gYW5kIHdlYWsgbWVtb3J5IG9y
ZGVyaW5nIGZpcnN0LiBUaGUgcmVhbCB0cmljayBpcyB0byBkZXRlY3QKPj4gbGVnYWN5IGd1ZXN0
IC0gSSBhbSBub3Qgc3VyZSBpZiBpdCdzIGZlYXNpYmxlIHRvIHNoaWZ0IGFsbCB0aGUgbGVnYWN5
Cj4+IGRldGVjdGlvbiB3b3JrIHRvIFFFTVUsIG9yIHRoZSBrZXJuZWwgaGFzIHRvIGJlIHBhcnQg
b2YgdGhlIGRldGVjdGlvbgo+PiAoZS5nLiB0aGUga2ljayBiZWZvcmUgRFJJVkVSX09LIHRoaW5n
IHdlIGhhdmUgdG8gZHVwbGljYXRlIHRoZSB0cmFja2luZwo+PiBlZmZvcnQgaW4gUUVNVSkgYXMg
d2VsbC4gTGV0IG1lIHRha2UgYSBmdXJ0aGVyIGxvb2sgYW5kIGdldCBiYWNrLgo+IE1pY2hhZWwg
bWF5IHRoaW5rIGRpZmZlcmVudGx5IGJ1dCBJIHRoaW5rIGRvaW5nIHRoaXMgaW4gUWVtdSBpcyBt
dWNoIGVhc2llci4KSSB0aGluayB0aGUga2V5IGlzIHdoZXRoZXIgd2UgcG9zaXRpb24gZW11bGF0
aW5nIGxlZ2FjeSBpbnRlcmZhY2VzIGluIApRRU1VIGRvaW5nIHRyYW5zbGF0aW9uIG9uIHRvcCBv
ZiBhIHYxLjAgbW9kZXJuLW9ubHkgZGV2aWNlIGluIHRoZSAKa2VybmVsLCBvciB3ZSBhbGxvdyB2
ZHBhIGNvcmUgKG9yIHlvdSBjYW4gc2F5IHZob3N0LXZkcGEpIGFuZCB2ZW5kb3IgCmRyaXZlciB0
byBzdXBwb3J0IGEgdHJhbnNpdGlvbmFsIG1vZGVsIGluIHRoZSBrZXJuZWwgdGhhdCBpcyBhYmxl
IHRvIAp3b3JrIGZvciBib3RoIHYwLjk1IGFuZCB2MS4wIGRyaXZlcnMsIHdpdGggc29tZSBzbGln
aHQgYWlkIGZyb20gUUVNVSBmb3IgCmRldGVjdGluZy9lbXVsYXRpb24vc2hhZG93aW5nIChmb3Ig
ZS5nIENWUSwgSS9PIHBvcnQgcmVsYXkpLiBJIGd1ZXNzIGZvciAKdGhlIGZvcm1lciB3ZSBzdGls
bCByZWx5IG9uIHZlbmRvciBmb3IgYSBwZXJmb3JtYW50IGRhdGEgdnFzIAppbXBsZW1lbnRhdGlv
biwgbGVhdmluZyB0aGUgcXVlc3Rpb24gdG8gd2hhdCBpdCBtYXkgZW5kIHVwIGV2ZW50dWFsbHkg
aW4gCnRoZSBrZXJuZWwgaXMgZWZmZWN0aXZlbHkgdGhlIGxhdHRlcikuCgpUaGFua3MsCi1TaXdl
aQoKPgo+IFRoYW5rcwo+Cj4KPgo+PiBNZWFud2hpbGUsIEknbGwgY2hlY2sgaW50ZXJuYWxseSB0
byBzZWUgaWYgYSBsZWdhY3kgb25seSBtb2RlbCB3b3VsZAo+PiB3b3JrLiBUaGFua3MuCj4+Cj4+
IFRoYW5rcywKPj4gLVNpd2VpCj4+Cj4+Cj4+Pgo+Pj4+Pj4gT24gMy8yLzIwMjEgMjo1MyBBTSwg
SmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+PiBPbiAyMDIxLzMvMiA1OjQ3IOS4i+WNiCwgTWljaGFl
bCBTLiBUc2lya2luIHdyb3RlOgo+Pj4+Pj4+PiBPbiBNb24sIE1hciAwMSwgMjAyMSBhdCAxMTo1
Njo1MEFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4+Pj4gT24gMjAyMS8zLzEgNToz
NCDkuIrljYgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+Pj4+Pj4+PiBPbiBXZWQsIEZl
YiAyNCwgMjAyMSBhdCAxMDoyNDo0MUFNIC0wODAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+Pj4+Pj4+
Pj4+Pj4gRGV0ZWN0aW5nIGl0IGlzbid0IGVub3VnaCB0aG91Z2gsIHdlIHdpbGwgbmVlZCBhIG5l
dyBpb2N0bCB0byBub3RpZnkKPj4+Pj4+Pj4+Pj4+IHRoZSBrZXJuZWwgdGhhdCBpdCdzIGEgbGVn
YWN5IGd1ZXN0LiBVZ2ggOigKPj4+Pj4+Pj4+Pj4gV2VsbCwgYWx0aG91Z2ggSSB0aGluayBhZGRp
bmcgYW4gaW9jdGwgaXMgZG9hYmxlLCBtYXkgSQo+Pj4+Pj4+Pj4+PiBrbm93IHdoYXQgdGhlIHVz
ZQo+Pj4+Pj4+Pj4+PiBjYXNlIHRoZXJlIHdpbGwgYmUgZm9yIGtlcm5lbCB0byBsZXZlcmFnZSBz
dWNoIGluZm8KPj4+Pj4+Pj4+Pj4gZGlyZWN0bHk/IElzIHRoZXJlIGEKPj4+Pj4+Pj4+Pj4gY2Fz
ZSBRRU1VIGNhbid0IGRvIHdpdGggZGVkaWNhdGUgaW9jdGxzIGxhdGVyIGlmIHRoZXJlJ3MgaW5k
ZWVkCj4+Pj4+Pj4+Pj4+IGRpZmZlcmVudGlhdGlvbiAobGVnYWN5IHYucy4gbW9kZXJuKSBuZWVk
ZWQ/Cj4+Pj4+Pj4+Pj4gQlRXIGEgZ29vZCBBUEkgY291bGQgYmUKPj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+ICNkZWZpbmUgVkhPU1RfU0VUX0VORElBTiBfSU9XKFZIT1NUX1ZJUlRJTywgPywgaW50KQo+
Pj4+Pj4+Pj4+ICNkZWZpbmUgVkhPU1RfR0VUX0VORElBTiBfSU9XKFZIT1NUX1ZJUlRJTywgPywg
aW50KQo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gd2UgZGlkIGl0IHBlciB2cmluZyBidXQgbWF5YmUg
dGhhdCB3YXMgYSBtaXN0YWtlIC4uLgo+Pj4+Pj4+Pj4gQWN0dWFsbHksIEkgd29uZGVyIHdoZXRo
ZXIgaXQncyBnb29kIHRpbWUgdG8ganVzdCBub3Qgc3VwcG9ydAo+Pj4+Pj4+Pj4gbGVnYWN5IGRy
aXZlcgo+Pj4+Pj4+Pj4gZm9yIHZEUEEuIENvbnNpZGVyOgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IDEp
IEl0J3MgZGVmaW5pdGlvbiBpcyBuby1ub3JtYXRpdmUKPj4+Pj4+Pj4+IDIpIEEgbG90IG9mIGJ1
ZHJlbiBvZiBjb2Rlcwo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IFNvIHFlbXUgY2FuIHN0aWxsIHByZXNl
bnQgdGhlIGxlZ2FjeSBkZXZpY2Ugc2luY2UgdGhlIGNvbmZpZwo+Pj4+Pj4+Pj4gc3BhY2Ugb3Ig
b3RoZXIKPj4+Pj4+Pj4+IHN0dWZmcyB0aGF0IGlzIHByZXNlbnRlZCBieSB2aG9zdC12RFBBIGlz
IG5vdCBleHBlY3RlZCB0byBiZQo+Pj4+Pj4+Pj4gYWNjZXNzZWQgYnkKPj4+Pj4+Pj4+IGd1ZXN0
IGRpcmVjdGx5LiBRZW11IGNhbiBkbyB0aGUgZW5kaWFuIGNvbnZlcnNpb24gd2hlbiBuZWNlc3Nh
cnkKPj4+Pj4+Pj4+IGluIHRoaXMKPj4+Pj4+Pj4+IGNhc2U/Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4g
VGhhbmtzCj4+Pj4+Pj4+Pgo+Pj4+Pj4+PiBPdmVyYWxsIEkgd291bGQgYmUgZmluZSB3aXRoIHRo
aXMgYXBwcm9hY2ggYnV0IHdlIG5lZWQgdG8gYXZvaWQgYnJlYWtpbmcKPj4+Pj4+Pj4gd29ya2lu
ZyB1c2Vyc3BhY2UsIHFlbXUgcmVsZWFzZXMgd2l0aCB2ZHBhIHN1cHBvcnQgYXJlIG91dCB0aGVy
ZSBhbmQKPj4+Pj4+Pj4gc2VlbSB0byB3b3JrIGZvciBwZW9wbGUuIEFueSBjaGFuZ2VzIG5lZWQg
dG8gdGFrZSB0aGF0IGludG8gYWNjb3VudAo+Pj4+Pj4+PiBhbmQgZG9jdW1lbnQgY29tcGF0aWJp
bGl0eSBjb25jZXJucy4KPj4+Pj4+PiBBZ3JlZSwgbGV0IG1lIGNoZWNrLgo+Pj4+Pj4+Cj4+Pj4+
Pj4KPj4+Pj4+Pj4gICAgICBJIG5vdGUgdGhhdCBhbnkgaGFyZHdhcmUKPj4+Pj4+Pj4gaW1wbGVt
ZW50YXRpb24gaXMgYWxyZWFkeSBicm9rZW4gZm9yIGxlZ2FjeSBleGNlcHQgb24gcGxhdGZvcm1z
IHdpdGgKPj4+Pj4+Pj4gc3Ryb25nIG9yZGVyaW5nIHdoaWNoIG1pZ2h0IGJlIGhlbHBmdWwgaW4g
cmVkdWNpbmcgdGhlIHNjb3BlLgo+Pj4+Pj4+IFllcy4KPj4+Pj4+Pgo+Pj4+Pj4+IFRoYW5rcwo+
Pj4+Pj4+Cj4+Pj4+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
