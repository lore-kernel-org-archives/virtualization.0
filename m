Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348C3C04A68
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 09:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B275880C09;
	Wed, 27 Jul 2022 09:43:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B275880C09
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=UxqmPMLV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=jUeuEFXd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fh1hFu6ipD5p; Wed, 27 Jul 2022 09:43:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AE0E080BFD;
	Wed, 27 Jul 2022 09:43:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE0E080BFD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FAF3C0035;
	Wed, 27 Jul 2022 09:43:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB236C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:43:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD06B40320
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:43:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD06B40320
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=UxqmPMLV; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=jUeuEFXd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hpjr0SjSW54B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:43:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5560340308
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5560340308
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:43:44 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R7PYvK010356;
 Wed, 27 Jul 2022 09:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=bMKYARdSh1h0jyO0/KM30VzeZSB3ajyC1bDnT2SSSyc=;
 b=UxqmPMLVkgAGoAslJQPhrkgaEjoB8d+/ppaXbdejoy3pht/8V3ZNU/9MM37jDuU69xau
 xmLpyL8W++dwSvqP5o3iEZWedi0WoKwQvf4AV+wTg+KUooduvng1xa1AcjO6GaSPYs8c
 KR5MspbhKj5VrMwyJV6REIqslq/sTKgcloI13Cjwjt+o6lpun/t5Q9tK+IdZJ44aB1Ko
 Dytw7Zj7BI8yM/ErsmvtcvpQp8lSkhDdDiUF0DSrNDfm+u6Zs+NZNzQwWNoKvnLoSwlT
 TboesIjLBWDr+P+Ltu0dNUuycB9z6iEUkSfZm2NhyjWr5Uwx3/ca2Q0rtDcy4c7R5xE2 yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a9h2gr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Jul 2022 09:43:32 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26R7bup4023134; Wed, 27 Jul 2022 09:43:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh5yvxvsw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Jul 2022 09:43:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FniDjXFPHp7OAiy65pSsApuOYHrKD44gvPsbGBd4NpvgDYxlPuJr/XcYZIHeUOjYW/asRYmJCIZldxeBH+k/z7auPwBRSmlzDxSwaU+kWYePr8hDPVYrB49gURkuBp91e8L/SG/kVeov1Qo84Y041Lzj6xOsQtbDBwU7PzWby3lZXguDn6BheQ9ybPsAM8TGN+oX82Qwrekwvx//BwWUBte2B2nwhYFE+r/RNn0c9PKDKVuX0itWTJvB375aK+MPrTEOcYJxSob/OtrxKDRncWlTh9+mcDP7QznWu891Y26aKNEjdaoFuOApcksl1pDMqL30LTTlZkpgSFy9FQkonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMKYARdSh1h0jyO0/KM30VzeZSB3ajyC1bDnT2SSSyc=;
 b=N6FOHT70J1hC6FXYmXa9pWLKBMBE27QNS9QCOM14b2JtEREB9ho/yJMRDK6zT92YQ88ryjmYXezkArJMZRTQLMUXf89IXYR8mZyVNkqUEawQlnn++xgITUz4eqq6cUlBZ2f9ZyhZyT+lhsalfnqW0LC+Xh0I4KG05PyuOql6ZKqmC7XsXkcJ9aFCTVGq7RZh818D7fjWjzN5Wj36CjCDGMD6u3D/D7q1W06mWmUv5tPum5XmZawOOqecMnIb9S9Dg4JoG8dgLRBZ27+6s2qPxVxrBJp34b36HStKHQcTuWAS+Occw9Z4VjFJVpYKW2QCDOgLIv/4Sk6s+PrBg4H09A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMKYARdSh1h0jyO0/KM30VzeZSB3ajyC1bDnT2SSSyc=;
 b=jUeuEFXdI58gWsejn96VpfSi8d3ek4MtlF6m6UigDjJvPZdA0Mad5ru5teHDgjdvOQxW/JPFObICwCZTmotx3VUXGLq9zyHAfiAur6SQ2uNq5xCUjPzmaA4tD6KIpvp0MKiOXnxevEbAwjYhHrbDR1vRZ6sXPEvAwnmohUpUD/A=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB3842.namprd10.prod.outlook.com (2603:10b6:a03:1f9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Wed, 27 Jul
 2022 09:43:28 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803%4]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 09:43:27 +0000
Message-ID: <00889067-50ac-d2cd-675f-748f171e5c83@oracle.com>
Date: Wed, 27 Jul 2022 02:43:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Content-Language: en-US
To: Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@nvidia.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-5-lingshan.zhu@intel.com>
 <PH0PR12MB548190DE76CC64E56DA2DF13DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <PH0PR12MB548190DE76CC64E56DA2DF13DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-ClientProxiedBy: BYAPR02CA0072.namprd02.prod.outlook.com
 (2603:10b6:a03:54::49) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8ef49a4-610d-4e37-88a7-08da6fb47515
X-MS-TrafficTypeDiagnostic: BY5PR10MB3842:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ioGE4egSUCneJYVU4u53lYg2UzBBn7riy+P4B0SCID1GqBmzmXqpU6UW8aNPW3D+02hKP+EI3jyS0RGe3+qbbSRd7hPxaBaht5U6FMgEok8TzCkFssMunq/WP8wkkaQxGnjWyJZBe3cKomW7XgYYW4NVB162dY9vLccTPoLfr6xP9vVMZrjCpNAcJTLYT/LWsG3DNcf2osJlzHilaclEWTAdDV+l3vvRnR1fH2rK3OSsl+dcztOcDZn/6nNRiI3o2ilNojvnFhH3naN7UNO0Q7Mod5xOnfxYE1UT1kqSfaHLq/pUb1IgNy/5lC5IZwJ1CTg4CBfWbxWKCNcGZMqEn1l/zQ6JwVgIEAHD++75fHBlsO/zf5PJoU2EnHeujA86lMv5ys5lUH/X/vbzGBDyEEiXp/jpZboff1fgCdH090ieRAO0uc4XKOwvHmruUOfHDkOZMZID14n6M9f95kWNuwlEeA6URlVNRTZCtj6dXVO9xVnBJExmt55gYPnqxIrf5Fb4NCdsyDU6XZ0OgRvbuQK3yVf+ryj8DB9deB+qY6WeIt4pfbPbCpNYvAdY7+F98NA+hqUc8cG9wVvGdgmtuU9/mhKziVQOeauabOx2k+RXH3P5vr1LUhdsKnZN+kGPRbkCuQLzGFgV7mpY8iPOZdLjgjiGWGoEgLx+w/8cUj5d5ANM857NzTKF0+VcrR9GpYXNdksjclYjQWgyor6Ug2LXO++7bJZ145THWohfH8afNGHKamtm6awbGXuSQd8RHnqNSUJiYDrntpE0IM8jJmguHx+fL+USsqGvn6AOed1/m+eihIccYKSkngwgI/3NOvO2GXBvdQMDFbKXWPOEOhqsCuJiYTAfXFQkTSGGkNA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(39860400002)(376002)(346002)(396003)(366004)(136003)(31696002)(66476007)(4326008)(8676002)(31686004)(66556008)(110136005)(8936002)(316002)(66946007)(54906003)(36756003)(86362001)(478600001)(6486002)(966005)(5660300002)(186003)(2616005)(26005)(6512007)(36916002)(33964004)(41300700001)(2906002)(53546011)(6506007)(166002)(83380400001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHBzWmFFZ1YyNEZkYW00WFNYeXRDRzVPcXUzT1pvdmQrSkdLbG1iQ1NIdzNs?=
 =?utf-8?B?czFqZGNXR3UwbnBsZFRtOUZkZm1VSzBCZGM0VWVCYmpjMHNXK2pnWUgrTUVi?=
 =?utf-8?B?L2dDN2ZKQ0w5WmNiK3dFK0tmV3htV0l1ejRBSG5yV1YrR3BWcW8wZm5aSzNL?=
 =?utf-8?B?RUwrV05BSmh2czcwd1Nxc253TmN3SU4yUHVyQUtuZDhzb2RMYnRkRktxUEp5?=
 =?utf-8?B?REpsS0VMdkJ5ZFJmTFJJdjRxR1A4cU1NWjVKYTFvamNHQjdMdDdGQVRzL003?=
 =?utf-8?B?aWJ1VVZBSzBMZG1SSFhON1pWVzFZYjJsM3pKU3lRaE5haTc3S0o4K1ArdFZE?=
 =?utf-8?B?dUI2aHRDRHZ3SE9TaWhyVEFzUVVPbUVSdjVLTDkyQis5eXd5MGh0RVNXa1V4?=
 =?utf-8?B?VERRT1hXdFE1QlBDbjhSM2RxTFpPdDZ6YkY4Z2FrSDNCZ095elY5K3FSVU9q?=
 =?utf-8?B?RWF0MC9uNEJtaElkWjNiS25iU0Mvd1VyZy9OYW5YRUswVFpLeTJwbzJ1NVFr?=
 =?utf-8?B?bmdEckNwcGQ0aUJVamRoOUI1VWZYK1dCQVdGN093UkNScmp3TVl4T1ZCTmhJ?=
 =?utf-8?B?d3NTK3U2dkVXbllNekZNcE9nQTJ4QWNoa3ZSRk54UTRSVFBYd2dxem5RY3Nm?=
 =?utf-8?B?ME5GR2JuUkZpZjJxOXdBVm9XdlZNblNiVU1hM29PRmVNSGh4WnN2Tlh0MjRV?=
 =?utf-8?B?dU1GRE1hOXpIOWsxdHVkTXVTako4UmFTd29mWlhleHhIUzJyS1Z4MTcyc3VY?=
 =?utf-8?B?QlAyZnE1RnZhd1ViRXQwSzE2UzZlcmNSaUcwL2NwVnA0RllKR1Q1SXd6eGdr?=
 =?utf-8?B?T2tHcjRjYThsWWdmc0EzS2ZPQkhwUldIM0laRWpKMm5CS0krOHJFQVgzNTlQ?=
 =?utf-8?B?ZlprSStodGhmamFoSCtQNzZSWjZiaUhCLy9oNll0T09PdTJEajF2SlBTU042?=
 =?utf-8?B?K21DbzlEd0tLNzV2N09SbjNwQXV3NjdmOUNlOW5uRlk4ZGNLWHoySS80bGxE?=
 =?utf-8?B?emJ3MGZhQW4vS0ZwTVRTMUhnQ0R0MjNrcVl1V08vWEprdDhSMWxMNE53dlZk?=
 =?utf-8?B?QUFnRktNTXY0V1JwNkpDNjJ2dklrWjFoVkZNak8wZjA4bjE2ekhORnpqRGJj?=
 =?utf-8?B?dTAxMXFKZkxHWFVscGlWUnpwbWtrNkVxNGJOdGY1T3ljZTFickxVeWQ5S1hs?=
 =?utf-8?B?WEFQSXBxZ0JYT0F5NEtJbXRQVlFLbVBRRjRtS2lrMjVxNWNIWHFFakdJQmVO?=
 =?utf-8?B?Wlhnc1p3T1VnVzhEVkRUVVFpWFA4TzBkVkZsbll4MmdnMld4MXJVY1lOeVlk?=
 =?utf-8?B?L3k2dDdZbVRaSzU1dVM1T2Z6U1gzQ1lla0VON3FjdjdYS0xTT2xGSmxXWmth?=
 =?utf-8?B?aGZ1aDhPL2J6enBkQ3czZGZ2WVIxblBERXZKcG43czA2VkNwNS9sc3RFNE56?=
 =?utf-8?B?azNVVXFFUGo5dDJrWWg4QWRvOFFuTXlQWk05aGg1YUpJTC9tYWJOVElwUGtp?=
 =?utf-8?B?YWYzK2NGQjE2QmkvOGJkM25NRVU5SW1vblhISTZOdDBnQ0puSytIYm44ZEZu?=
 =?utf-8?B?Qkg3Z3h4eXc4Tzh5aklWK2R3Yi9WTklvcTg0aTd2REdPdDhsTDdiVUJKOVJr?=
 =?utf-8?B?bUp6SWcwaXBuNUN3MnhtVVNsOHpnWjRzVVU2cU55a3g0ZUNwOUQ2eEFZd1VG?=
 =?utf-8?B?Ym9reXFFM2ZVWG82TE9reUIvcnE5WW9uUU94dGYyc1puM1lMVFdDS2Ewc2tH?=
 =?utf-8?B?L2c5a0JiNjJ3SXdXd0Y3NHZBSTYzajdPYzZPaVdYNndPUzdyL2p5c1g2a1lS?=
 =?utf-8?B?TE5LbzZxSThkRWlGL1hCMlA0Rjk0dTQwQVA5WUZPWC9HU3I4ZDZ2dUZleEZR?=
 =?utf-8?B?UHVoRXdWS3dnWS9oMG1Nb0MrTFBuSDBtLzBVK2hjSjd2NVRUYm82UUZEMFEv?=
 =?utf-8?B?MGVZeDB0Z0Y5QWZiRzR0SWRTdFNsWFdNY3pZQTlFWTJZNTJ5UHJBY3FLeGRr?=
 =?utf-8?B?VmxvWjFtcHU2cjRXdi9qUHlMTkZZVjdKY21yRVdyWHFmSWhPaUdMcjd4dUdM?=
 =?utf-8?B?QUhVRVVFUDBGVGRhMjBMcXBteUZSeDNpenlaOTR5R0FlZG91WUNhdFZsRENR?=
 =?utf-8?Q?pfhml3pOkQJ46xQdcgfi8is2Y?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ef49a4-610d-4e37-88a7-08da6fb47515
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 09:43:27.7363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jctho0lZNm0EHhqDZ87mt5u0IMP/pOy60zHBpDgxbc45Ip5Zzp6bQ7MBFed1LnVW/2koEJ+npc2saAd67ybuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3842
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207270039
X-Proofpoint-GUID: ltnCcNeJrlaS72zOxSMHssdLk7Ef4x_u
X-Proofpoint-ORIG-GUID: ltnCcNeJrlaS72zOxSMHssdLk7Ef4x_u
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>
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
Content-Type: multipart/mixed; boundary="===============6740869225350739156=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============6740869225350739156==
Content-Type: multipart/alternative;
 boundary="------------KLqs1gnwK5EW1OaYlhFWoeyQ"
Content-Language: en-US

--------------KLqs1gnwK5EW1OaYlhFWoeyQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry to chime in late in the game. For some reason I couldn't get to 
most emails for this discussion (I only subscribed to the virtualization 
list), while I was taking off amongst the past few weeks.

It looks to me this patch is incomplete. Noted down the way in 
vdpa_dev_net_config_fill(), we have the following:

         features = vdev->config->get_driver_features(vdev);
         if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features,
                               VDPA_ATTR_PAD))
                 return -EMSGSIZE;

Making call to .get_driver_features() doesn't make sense when feature 
negotiation isn't complete. Neither should present negotiated_features 
to userspace before negotiation is done.

Similarly, max_vqp through vdpa_dev_net_mq_config_fill() probably should 
not show before negotiation is done - it depends on driver features 
negotiated.

Last but not the least, this "vdpa dev config" command was not designed 
to display the real config space register values in the first place. 
Quoting the vdpa-dev(8) man page:

> vdpa dev config show - Show configuration of specific device or all 
> devices.
> DEV - specifies the vdpa device to show its configuration. If this 
> argument is omitted all devices configuration is listed.
It doesn't say anything about configuration space or register values in 
config space. As long as it can convey the config attribute when 
instantiating vDPA device instance, and more importantly, the config can 
be easily imported from or exported to userspace tools when trying to 
reconstruct vdpa instance intact on destination host for live migration, 
IMHO in my personal interpretation it doesn't matter what the config 
space may present. It may be worth while adding a new debug command to 
expose the real register value, but that's another story.

Having said, please consider to drop the Fixes tag, as appears to me 
you're proposing a new feature rather than fixing a real issue.

Thanks,
-Siwei

On 7/1/2022 3:12 PM, Parav Pandit via Virtualization wrote:
>
>> From: Zhu Lingshan<lingshan.zhu@intel.com>
>> Sent: Friday, July 1, 2022 9:28 AM
>>
>> Users may want to query the config space of a vDPA device, to choose a
>> appropriate one for a certain guest. This means the users need to read the
>> config space before FEATURES_OK, and the existence of config space
>> contents does not depend on FEATURES_OK.
>>
>> The spec says:
>> The device MUST allow reading of any device-specific configuration field
>> before FEATURES_OK is set by the driver. This includes fields which are
>> conditional on feature bits, as long as those feature bits are offered by the
>> device.
>>
>> Fixes: 30ef7a8ac8a07 (vdpa: Read device configuration only if FEATURES_OK)
> Fix is fine, but fixes tag needs correction described below.
>
> Above commit id is 13 letters should be 12.
> And
> It should be in format
> Fixes: 30ef7a8ac8a0 ("vdpa: Read device configuration only if FEATURES_OK")
>
> Please use checkpatch.pl script before posting the patches to catch these errors.
> There is a bot that looks at the fixes tag and identifies the right kernel version to apply this fix.
>
>> Signed-off-by: Zhu Lingshan<lingshan.zhu@intel.com>
>> ---
>>   drivers/vdpa/vdpa.c | 8 --------
>>   1 file changed, 8 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
>> 9b0e39b2f022..d76b22b2f7ae 100644
>> --- a/drivers/vdpa/vdpa.c
>> +++ b/drivers/vdpa/vdpa.c
>> @@ -851,17 +851,9 @@ vdpa_dev_config_fill(struct vdpa_device *vdev,
>> struct sk_buff *msg, u32 portid,  {
>>   	u32 device_id;
>>   	void *hdr;
>> -	u8 status;
>>   	int err;
>>
>>   	down_read(&vdev->cf_lock);
>> -	status = vdev->config->get_status(vdev);
>> -	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
>> -		NL_SET_ERR_MSG_MOD(extack, "Features negotiation not
>> completed");
>> -		err = -EAGAIN;
>> -		goto out;
>> -	}
>> -
>>   	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
>>   			  VDPA_CMD_DEV_CONFIG_GET);
>>   	if (!hdr) {
>> --
>> 2.31.1
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

--------------KLqs1gnwK5EW1OaYlhFWoeyQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Sorry to chime in late in the game. For some reason I couldn't get
    to most emails for this discussion (I only subscribed to the
    virtualization list), while I was taking off amongst the past few
    weeks. <br>
    <br>
    It looks to me this patch is incomplete. Noted down the way in
    vdpa_dev_net_config_fill(), we have the following:
    <pre id="b" style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 0, 51); white-space: pre-wrap; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
        features = vdev-&gt;config-&gt;get_driver_features(vdev);
        if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features,
                              VDPA_ATTR_PAD))
                return -EMSGSIZE;

</pre>
    Making call to .get_driver_features() doesn't make sense when
    feature negotiation isn't complete. Neither should present
    negotiated_features to userspace before negotiation is done.<br>
    <br>
    Similarly, max_vqp through vdpa_dev_net_mq_config_fill() probably
    should not show before negotiation is done - it depends on driver
    features negotiated. <br>
    <br>
    Last but not the least, this &quot;vdpa dev config&quot; command was not
    designed to display the real config space register values in the
    first place. Quoting the vdpa-dev(8) man page:<br>
    <br>
    <blockquote type="cite">vdpa dev config show - Show configuration of
      specific device or all devices.<br>
      DEV - specifies the vdpa device to show its configuration. If this
      argument is omitted all devices configuration is listed.</blockquote>
    It doesn't say anything about configuration space or register values
    in config space. As long as it can convey the config attribute when
    instantiating vDPA device instance, and more importantly, the config
    can be easily imported from or exported to userspace tools when
    trying to reconstruct vdpa instance intact on destination host for
    live migration, IMHO in my personal interpretation it doesn't matter
    what the config space may present. It may be worth while adding a
    new debug command to expose the real register value, but that's
    another story.<br>
    <br>
    Having said, please consider to drop the Fixes tag, as appears to me
    you're proposing a new feature rather than fixing a real issue.<br>
    <br>
    Thanks,<br>
    -Siwei<br>
    <br>
    <div class="moz-cite-prefix">On 7/1/2022 3:12 PM, Parav Pandit via
      Virtualization wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:PH0PR12MB548190DE76CC64E56DA2DF13DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">From: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com">&lt;lingshan.zhu@intel.com&gt;</a>
Sent: Friday, July 1, 2022 9:28 AM

Users may want to query the config space of a vDPA device, to choose a
appropriate one for a certain guest. This means the users need to read the
config space before FEATURES_OK, and the existence of config space
contents does not depend on FEATURES_OK.

The spec says:
The device MUST allow reading of any device-specific configuration field
before FEATURES_OK is set by the driver. This includes fields which are
conditional on feature bits, as long as those feature bits are offered by the
device.

Fixes: 30ef7a8ac8a07 (vdpa: Read device configuration only if FEATURES_OK)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Fix is fine, but fixes tag needs correction described below.

Above commit id is 13 letters should be 12.
And 
It should be in format
Fixes: 30ef7a8ac8a0 (&quot;vdpa: Read device configuration only if FEATURES_OK&quot;)

Please use checkpatch.pl script before posting the patches to catch these errors.
There is a bot that looks at the fixes tag and identifies the right kernel version to apply this fix.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com">&lt;lingshan.zhu@intel.com&gt;</a>
---
 drivers/vdpa/vdpa.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
9b0e39b2f022..d76b22b2f7ae 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -851,17 +851,9 @@ vdpa_dev_config_fill(struct vdpa_device *vdev,
struct sk_buff *msg, u32 portid,  {
 	u32 device_id;
 	void *hdr;
-	u8 status;
 	int err;

 	down_read(&amp;vdev-&gt;cf_lock);
-	status = vdev-&gt;config-&gt;get_status(vdev);
-	if (!(status &amp; VIRTIO_CONFIG_S_FEATURES_OK)) {
-		NL_SET_ERR_MSG_MOD(extack, &quot;Features negotiation not
completed&quot;);
-		err = -EAGAIN;
-		goto out;
-	}
-
 	hdr = genlmsg_put(msg, portid, seq, &amp;vdpa_nl_family, flags,
 			  VDPA_CMD_DEV_CONFIG_GET);
 	if (!hdr) {
--
2.31.1
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
_______________________________________________
Virtualization mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Virtualization@lists.linux-foundation.org">Virtualization@lists.linux-foundation.org</a>
<a class="moz-txt-link-freetext" href="https://lists.linuxfoundation.org/mailman/listinfo/virtualization">https://lists.linuxfoundation.org/mailman/listinfo/virtualization</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------KLqs1gnwK5EW1OaYlhFWoeyQ--

--===============6740869225350739156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6740869225350739156==--
