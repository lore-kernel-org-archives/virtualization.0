Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF311D5CE5
	for <virtualization@lists.linux-foundation.org>; Mon,  2 Jun 2025 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857647; cv=fail; b=HaMgB1XUoCg+/Wrtt1GFPsQ/sEHpMEgS36Px2IpahJY3RWO2cvsCf4YWjGA9Ff/BlkHsL/9BGiADj2T9n0EKlSPFv/d+qaq7ESldDCDN9WqP/dl0fKjNi4T11WGZmMzl7rUoSzfk0K7iM0lsWcNhBLqrG0qljXZsRnsJjguEBkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857647; c=relaxed/simple;
	bh=Yy6UrmF1+1rO5oCTIgUuSBF6gkAMSWMbKt35BrKAVDQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BpObx7V93aNjjHdppoFiQdJDMrSxg7RlwjxxwfHO2xuBR63UjrCWC/FThP6A2+06pHh5PPAvTVYr7VCNkgUCfY0KyBzIOeZWwxpT7Ho2oC99r0k2pHhxpzBMAQQGUzvoWbPreON8MPo9MlunbFO5SmpW3q1uE4RnZpuEoHKCUno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IKq5TkVA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lrwNXngt; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IKq5TkVA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lrwNXngt"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BCEC840217
	for <virtualization@lists.linux-foundation.org>; Mon,  2 Jun 2025 09:47:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.489
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HK56waBuS_2b for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Jun 2025 09:47:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=john.g.garry@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 51C3E40119
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 51C3E40119
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=IKq5TkVA;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=lrwNXngt
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 51C3E40119
	for <virtualization@lists.linux-foundation.org>; Mon,  2 Jun 2025 09:47:21 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5525ttJb011378;
	Mon, 2 Jun 2025 09:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uQ0alzaqZUTLZCwxmo4PPPFHb//mZXydPb86vBU3Rt4=; b=
	IKq5TkVAicPY5jRYJGpGTrOQ0BDSVE7rhcRG6ztX+U5cF9+D/ZqF/OZR0KM6UchH
	guFOr+cJ+rxc8EkZtBNhTorI/4ZWmT4E293X8RgNjqzmDyhrF/5oKk4YKSn7wH8s
	u6LIzY34pHC+j4PVpjq+LG45OElFVnn1kKCKPdqyLNrgNcIkxRMf0sCGIQsxGbYt
	XiKuS0cYDsiIbGs1OWiCpfPkOje4jH1bqaljsusrkCNJhy5VscYmXw3zeGI4A4xa
	s0e2p+x873BEAmeiBLTIDLnBatPEcIGu4+loHnmDOVfo4R6T1jiJA1X9jiVWPenT
	nOVIixEFIixoD5m418Vk0w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46yrj529tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 09:46:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5528XKHe016220;
	Mon, 2 Jun 2025 09:46:53 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr77rqh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 09:46:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G91tdbXP2YSMiv1i9oy8nMHXe2KaQK5cEyFt3boSl3qZfYi4TpSL2NHanf9762iAgfSQhf7akApfL4ADInKxhx4H2m0aIdXMYpwvbErajrauwExIBymYLkmKf0of9flxEEKAFKUiDmAm9ApKSz0Hq87o3p4+QqHIgapgEVXNf3gLSe8CKqAJCDoD4/GvHBNZBJkw/mngXHQFs/OSkBPvgGkz5oVV2BnQURQVjwnScGwcJ1APXrbAGtEIRr2JufF0ulCTUV1tcA/uX/IN1jOy5siSVgy9VL3oo9xnHoBYB8WXagkznx3SU+72TD8xDjYaL29W76D73JOUCdgXzwY9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQ0alzaqZUTLZCwxmo4PPPFHb//mZXydPb86vBU3Rt4=;
 b=psm9wv04PiNm8VFOznG2KtsFfOkX7j/txQnnXNKFUcRyhv3pydRNOJIWKQi+89A18JVX1pH8jtFx3CS1xSPtsLFz3c72x00xOehb9mhIP6lzxnGCo4NYi01BoQz9HHO2FtNmaLruaDtUdsHL5ErnUb5rpngj5mzvWDdtm8oWPfwQZPcWgpTemBgJpiXroCn0gcTC1FDRym72VHK03XNLBE0zFBfbG1cVQPnb8jdVUo7bjMC7GBCJfj1hhE5VV+PYrj3ilxXOQWS2Scjx4BgIIVD/7fRkomEfp1NxtUKEox/WKQEz8lqaRfO30ROYG3Nt6vZJcSSZceCKsjrswTZouA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQ0alzaqZUTLZCwxmo4PPPFHb//mZXydPb86vBU3Rt4=;
 b=lrwNXngtrTeWSQS2q+s2G8KkDPK1Ikq6121k0g+RR1Ir/01iEjEp3pQd+8NhvMfdJzSwawqK3Kb9JtB0iXMuGWp3qVQxkuStU5jrRFRmyghI7Lwss695uL5fp5+Z7W3I31lleGK+cBozxoySufv9XlqjN7j1SaHt+wCLGykFWyE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6056.namprd10.prod.outlook.com (2603:10b6:8:cb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.33; Mon, 2 Jun 2025 09:46:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8746.041; Mon, 2 Jun 2025
 09:46:49 +0000
Message-ID: <0a41252f-7833-4e14-a246-c2471731ef97@oracle.com>
Date: Mon, 2 Jun 2025 10:46:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Please backport 32e92d9f6f87 ("iommu/iova: Separate out rcache
 init") to linux-5.15.y
To: hyunki00.koo@samsung.com, joro@8bytes.org, will@kernel.org, mst@redhat.com,
        jasowang@redhat.com, robin.murphy@arm.com
Cc: xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linuxarm@huawei.com,
        taeyang.choi@samsung.com, bumyong.lee@samsung.com,
        iommu@lists.linux.dev
References: <CGME20250527093429epcas2p1ae70ad7304305bf547ce34a70f9badc6@epcas2p1.samsung.com>
 <000d01dbceea$8bfec3c0$a3fc4b40$@samsung.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <000d01dbceea$8bfec3c0$a3fc4b40$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f771b71-3fe2-4541-9cad-08dda1ba654f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1NhL1lSdElQclY0Zm9pZ2paSTYvL3N6bzFzNFU4WWI4WnhnanV1OUtNNStV?=
 =?utf-8?B?Q3Zxd1V2NmNjV0MyVlUyUFFUR1doRTFheFFsVTkvL3dwZDUyNUovZmlPTWRR?=
 =?utf-8?B?ZXVJN093Wi84WEdQL2s2bVFIV1dxRVlyQmpxcEUvWHgyOHRUa25rR3o3RHhE?=
 =?utf-8?B?SWlqdUl0Y3lBNFg1YUJQRzVIY2k3MHhkdWJNVnhCa05hanJxRmZLVXllL1g5?=
 =?utf-8?B?MnkvWjlWYXV4Y1F3ZFFFT2N5UHUwdFFGc05iODVFNkt4Q1NCUXlFa2ROdXUx?=
 =?utf-8?B?dXg2MmtjakJraUxaM0lqYkNYWGdUY0ZyY3VXclByUGN6elY3Q2E5aktZSndP?=
 =?utf-8?B?QThZT1JyekZrWE50OGJwM0RUd2VDRDNKbDBtSzZTRWw1TjA0WnZiVkNJbER3?=
 =?utf-8?B?amlqR0RIRzhCcC9vcTdCdTlQRXFvQkRQWTVLOG9oT29oSllTR0NlQitDS1lJ?=
 =?utf-8?B?amhYQXhnaVR6OGdUUGwzN25tTHkrZisxanNHLzBpMG1EK2tVKzJyL3k1SmFt?=
 =?utf-8?B?eFEzcXgyMGY0ZVUyZm5MYWVQOGt2SnNUS2RxYnpTWDNQcWdCZzZDVkNKSlN2?=
 =?utf-8?B?SmF0U0thS3ArT3NQR05PdUlXZFlqUVc5YUhISTN4RmhNQWVQWWhiM2p6TkNI?=
 =?utf-8?B?eVZoMWNZNU1YUmJhbVpVRHFLQlVET1A4MWhheWVNWGpvSlk5dXZJRzJBQmk4?=
 =?utf-8?B?S0VWQVVBeVovQnB5QTU0M3NqN1ZncG5zYnAwVVFxU2s0VG14TGdCT0RwYjJI?=
 =?utf-8?B?dTR1OStCWHZuVStESjQxMFpKU0NLYXZPWUtIRGVnK2s2cms3Uk5aK2pjUUlM?=
 =?utf-8?B?c0tHcDBmRWU0K2k1M043VHdyUlZuOHp1b3Vhc2ZLQmFDWjBxN0hBU2lBYTdT?=
 =?utf-8?B?cE1qbithY0ViQTNxRXpveEk2bDg1blFUU0tHVWlOY09ZNmRhaEQyOUVzb0Rv?=
 =?utf-8?B?TjRaU0pza3JJVG51Ny9PMTRIUUNEbWovSlJtSWk0QzZKWkE0K2F0d0d1dk5h?=
 =?utf-8?B?M3BFd3NzVEF3YVdINDkzUUV3NjgvSHR1ZFdCRjZzTWhJMUVNL211WVp1dng2?=
 =?utf-8?B?Z2d0MWhwNlBLdUJ3WTd4Qy92WmMwK3dSZDNoNW1IajdndnNjQkdIRjFtaWpG?=
 =?utf-8?B?U0ZHQTdYY1dOaVN0QmJHWUs5anI0YUdiNWlCSk9QS3F1RGNBcm9iN3Y0UUZv?=
 =?utf-8?B?NzkxUmlkVkI5ZlQ4TVB1T3BOR3VuRzFZdWNQTFZ0OXJwSW8xZ1VsS2NSR1FO?=
 =?utf-8?B?TUJiNUdXdnNWV0xoTVlsNkhTWS9MWU93b1Jjd2FUMzNMTVZNaS9MRWpjOCtU?=
 =?utf-8?B?a1M3MjJ0T200T3Y2ak1TeHB5RENuYXVIVm1zTzIyS05hMloxbjNkS3Y2Zkh4?=
 =?utf-8?B?VElXRVN4L1IzOHFUK1BSaVlBaXI2T0NwVzRmcGM3eTJzSWdjTFN5VXhzQVZI?=
 =?utf-8?B?YW9tbUhReDMwcC9rc3FLa2tqYnM1aVdEWlJQTDN6MnZyMXcxajRlVjczUExz?=
 =?utf-8?B?TnhEbllxdktDOXBQYURieit1clNRbTFMV0hiYUxoa0IrWndhWnZCNkw0L3N4?=
 =?utf-8?B?VjF6Rnora1RYTExja0VYeXFxTzZEZjloYkRjazdtam13bTZ6aDdBV09scEFx?=
 =?utf-8?B?cFF5STllWEdNUllMZHFWV3Vhc2xwejdDSXRLSHpNaldVQWdXdHlUNWd3YWRL?=
 =?utf-8?B?YUNPMXVsYmFyYUR0am80RGJXRVVYRjZZRXZXemRvTERtM0dsRkZOM1M1dWh6?=
 =?utf-8?B?a3pOUzVKZ0dEVCt1bG8wY0RYTXJyQnVUZUdlTWlvQWV4RnBlSUdIRExFcnJR?=
 =?utf-8?B?MDkraHQyNm5nSHk4VjFNRXcvbXl6b2g2YUFtR05NUTM0VFovZHExeC9GS21T?=
 =?utf-8?B?K0F5bEVJSTdaOUNQZlNnYXVreHA1bnNUa2VMOHRoaCtXSnVwOUZNZlAxNE1n?=
 =?utf-8?Q?Mzj7ZOPBQ7I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K01vZFluVmx3dUZzdVhLRExDMDhva2pkN1NlR05KS2lkeDRvRk5FWEo0NmdG?=
 =?utf-8?B?MDRLbStSMHNCUVpYdTliUGdDTkJFejdTU0doRjkwdFY0ZWpYajhUNmRRVkdu?=
 =?utf-8?B?K3NxR3FsQWVPTXYzNUM0MmxjNWVKT2NrUDFuS2RHUHF0THE2VnZDVzVsSXVo?=
 =?utf-8?B?aWNvckFPYWJBK2lDRFgySnFOdDJ6TmE3WmMxM2NjVzQrWEpIOVhJbEtVdFFr?=
 =?utf-8?B?ckVGSXYyTlN0R2YrOGJ2MnJWWVUzeU1YbHlteFFOakVka0R6cVp4Tk1aZm93?=
 =?utf-8?B?bGxWNnBKdTM3c3VjdUttMDcydkthU1lBalBUWFQ1MGx6c3FERUw3dkkyWGJz?=
 =?utf-8?B?L1NYMGtMaUFuMlVsWklWN0Z3TlFSTHoyYnVtL25YcjZYNklOb0ZZUEc0Z2NB?=
 =?utf-8?B?MVVvdE1kdXdTbkowSmpSZmwrUnhDYVpDaWlEWFArcXFpVHdqcG16UWdQY0xZ?=
 =?utf-8?B?Z2JwY0J4U21PekdlaExseHRiZU93RHFnMDRJRVQ5RVZ6YVIrbUZGS3VXQmdF?=
 =?utf-8?B?ck4zek8rMjFpWnBNQ1B6NjNXMUt3RUJ2ekk2ajJkZVlkc2JldFhDSU5DSWxT?=
 =?utf-8?B?b1oyVE5QUVhMNHFUQXMzUjNqMjJkajJQWXA1bXM1b2NDdHdhNGhUNEl4Z2c2?=
 =?utf-8?B?UDRrL25PcFlkenlVWHFtd0I1dHlOYlhtT3VHL0ttbHJEcjVmSSt1bnJabHQ0?=
 =?utf-8?B?UmNvZEhsb0dxTy9PTk5DNy9kMk4ySVZNemp5Z3oyZ290Z21VYlpEU3pxSVFx?=
 =?utf-8?B?S2NEZlJOMmdsb2xsV240V09TSGhza21wZHFPREtlMkovUHZWMm5xeXUzaHlT?=
 =?utf-8?B?SHFvQzNyb3BVSkxJRy81RXdrRkpnRFB6cEJvQzRnTm9TcTA1VlJFcGYvclBv?=
 =?utf-8?B?Z0hZWGF4bkxHVStVKzBEU1RxYjliTGRpOEYrNGhHek9qQ3ZQVjRhOEFMQVJW?=
 =?utf-8?B?d1JjVnhqVzNINDV4ZVlyUHZ3THErWEgwZk5hd01MQ2ZVYzhtRlE1akZBK0NN?=
 =?utf-8?B?eGI2dnBGbFJyd3BJQ3FJUnpScXY1cUIvekl0ZmZ0OEVBekcyV0J0UERLaUJ6?=
 =?utf-8?B?UmJIODU5elpUL21jL3RsOFkwOERIVU1IVjErL0tYUFZQU0Vkam1aTlZheDlq?=
 =?utf-8?B?WTN0aHgvZnRtQjhQWVRNbHFLU0MzcXRyV1JucVE0YThoYU02S3R6eVdyRUQr?=
 =?utf-8?B?ZEthT29aS1IwaXdsUFdTbzQ1cElkSVhCbmFTZldYbFYwTGRSOXFNSlc4WStv?=
 =?utf-8?B?YUhXYTZjVDkrWGVvQWNRRkpDaVNRc0hyQ1hSelFDL0J5cFluVjVjc0VmYW5Q?=
 =?utf-8?B?WW9UQStmRzZrbnl5RXZBVkRqY1I2SjJjS20yclNvZlFKWXNPUGlEQU91TjJq?=
 =?utf-8?B?RWNZVzNTdllLQ3M5T0UzTlhCQVhmOXdvNTg3eWRTQTlTcVpIekdhNzZWS204?=
 =?utf-8?B?VWNsUlFDbDdEU3dsbDN5R3RPbDNUMEhvdHRZZ0N3eVpiVHZXNktmY0E0dUd1?=
 =?utf-8?B?TzVTT0VlcERCYWMrTUpWbjQwemE0OWtIU2d3c0JCa1ROaWVsL3lJNXlDWWdn?=
 =?utf-8?B?d2Y5WW9STkJ0WnFKcXpXY3g1Z2d4MzZFMGJ3aHM0bUYyUklkdHY4NG1meWNx?=
 =?utf-8?B?dzh0MEVsblVSQU1DSlJ2cXBZdktYaHVuMkxNaG9ubGRTZjMrWURyYWVFbEVH?=
 =?utf-8?B?d3hVY1RjKzdPbkhOYkFrbmVLSjNjcTRGM2lqSm5aallZcURuNTdRR2FlUDhZ?=
 =?utf-8?B?RktxNStiU1MzdnhxQ3NWem5rZ2tEMlB3dlpDYmRuTXUySVBWVzNTR0d5MEVh?=
 =?utf-8?B?VmQyanZVbVR3cFZYNHpwdnJ4Y0RtUllwRG9PRkxtQ2xHcHZjbjdXdE1raXRP?=
 =?utf-8?B?TnhSdWV1c2FLR2IyWCs2ei9JNEJxZTkvRlVJOUlOY3RadHdHNlVtSDc5K0VC?=
 =?utf-8?B?VURkb2hJL3ZuTDNwR2N5ZFVHZkQ4VDczQUJqYmpXSFh5V0RSb0F6WlFFQXNy?=
 =?utf-8?B?ZkNGVFN1WXg0M2FXVXlPTUlXMmZzRzlvZDB0NTFrVWFWOEVpZldkeE1sak9P?=
 =?utf-8?B?Nm84N2FLOXVjTVgrWEZTc2tjZ1dOWVR2MUhXTFhodHowMUxXMkk5dTF3Vzlv?=
 =?utf-8?Q?kGH52u6uzmmnd8VLofTQoHn//?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sDpzRdE6jKFbBJLGapinG87eW7fhfYUwQL4AYglrDGMWbh+71c2XRcqxoFjvUcBa43TyRXJMKyGbZFAJ0bxzUUr/JiqFDEJ8A53CQKlMbspzCZ0s2KYd9jiZj1AlWRtPj3YEJj/WbcYVQFdLYiFn8IwbEA6JRkYc/Qez3NmSDmOovKZ7/XZrXnxZa8gFBl5Nii055/qIiThhNUsjnM5+JOxP06KulZlGh683yTI/SSqe1aoaz6eL7+MJaYklEsnNmfIBJYT0L73/3/ikLIv4pYx0W+AIb+XsVbax6TJcKX5PrLAscMAKggDtcq+vUw56YVNTvAP0a1nnkrt8EJeWLDVuCA4YaHuXbX09Onw1MGpWi4NLxNOlhDb8zGvuUhda+/2HDJEgEYrapit8ZSeY7Vlwg+JOToxpRyQ/QMMLNQMBCuTjKGbuEXEkBcoI0NIHSMmLGHVcL5N8lofG+Fcwb1T/8WwmPOkMKoagiTyB0OVjVqa1Mmt015km3mPbeTZaq+Y6RjHXTVJnkRVQHh6NcztsMcnUXi6gryLcjdkLVVUvGOwRS8qJ2Y+92kelJ5V7biPiC8WPx6So9rCCFnBg+PfuwMW6RIm1mcJ0W8Dcaxc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f771b71-3fe2-4541-9cad-08dda1ba654f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 09:46:49.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lo7c4X02DZF0tgV5ebjfS8mClKenOILEFLsu25OEAUkn8BEQJ6IIz3YP71tn6y0wobVTrRsCO5uHriEERjKbTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_04,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506020083
X-Authority-Analysis: v=2.4 cv=fs7cZE4f c=1 sm=1 tr=0 ts=683d730e cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=hD80L64hAAAA:8 a=KSekzgq8vg9I5NEyn_AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: luYJnGDIMNdSYGyM8ilS5jYUEguE4Jfn
X-Proofpoint-ORIG-GUID: luYJnGDIMNdSYGyM8ilS5jYUEguE4Jfn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDA4MyBTYWx0ZWRfX7R05FnoYkIKq SIfvrZ0AnMsurfYhWYEUE7Fxhq7eGjWiVIQ8YURy9wRt8A+TOD59fi5zsgmj1I6OUK7c4viEfOT 4r6/i0afnNVZo5OgnjfcF4a7p8JiDa9aFG0A/2fzBaNDHTPUsN49AAYnOkE8VCaKpeEoB/TbC6o
 DBnLuNu8YYvMpv2x+S+I592HQHf9RaoggmajOOQlV2gmUGq56F6TRS1kuWC5wuizGxJnPdfcsbF jq/faShS6DpWmU3dlo8Z4bIrZ/ylc8eA1BoN2GNC7/v+NUyT3tpTBeACrPb7kiDHHLqzlYPh2l4 9EAevKfdrbc/HK70euq0vyuwYQn5Osi9kLLFZpqNLmVsGbc1tvYA5nIp4S9RqYQWyMPmCPmyWT8
 OyhLJ824nfeR3ZR2efXe6TpFr0EHINW/QA6EAQSP4L0RH5zzURNmXs9usPb1UZVpdQJFTF0Q

On 27/05/2025 10:34, hyunki00.koo@samsung.com wrote:

- old addresses

> Please backport 32e92d9f6f87 ("iommu/iova: Separate out rcache init") to
> linux-5.15.y

If you want some work done, then you generally have to do it yourself or 
pay someone to do it. Or report a real problem, so someone who cares helps.

> 
> Commit de53fd7aedb1 32e92d9f6f87 ("iommu/iova: Separate out rcache init")
> fixes below issue.
> This should be applied to all stable kernels that applied commit.
> 
> Issue
> =====
> 
> As you metioned in commit message, fails in init_iova_rcaches() are not
> handled safely,
> and a problem actually occurs.
> 
> By the context of the 2 lines below in linux-5.15.y,
> callback of cpuhp may be called before the percpu variable is allocated.
> 
> cpuhp_state_add_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD, &iovad->cpuhp_dead);
> init_iova_rcaches(iovad);
> 
> The problem occurred in the Linux kernel version 5.15.144, if
> remove_cpu(cpu) is called between 2 line.

So this some artificial test you create to race cpu hotplug with 
adding/removing a device? Or something like that?

> The following is the panic log:
> [    2.097125][    T1] Unable to handle kernel paging request at virtual
> address ffffffcb74a6b004
> ...
> [    2.097226][    T1] Call trace:
> [    2.097323][    T1]  do_raw_spin_lock+0x1c/0x12c
> [    2.098469][    T1]  _raw_spin_lock_irqsave+0x30/0x60
> [    2.118152][    T1]  free_cpu_cached_iovas+0x50/0xb0
> [    2.118307][    T1]  iova_cpuhp_dead+0x1c/0x30
> [    2.119447][    T1]  cpuhp_invoke_callback+0x2d8/0x5b0
> [    2.119608][    T1]  _cpu_down+0x17c/0x4a0
> [    2.139216][    T1]  cpu_device_down+0x44/0x70
> [    2.139353][    T1]  cpu_subsys_offline+0x10/0x20
> [    2.140503][    T1]  device_offline+0xf4/0x130
> [    2.140640][    T1]  remove_cpu+0x24/0x40
> [    2.160305][    T1]  init_iova_domain+0xec/0x1f0
> 
> Here is my modification based on the top of the tree of linux-5.15.y
>
