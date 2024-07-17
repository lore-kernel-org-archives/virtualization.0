Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EEDED8
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Jul 2024 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721240964; cv=fail; b=hD6fiyLxTveZLCLUJxTi5xiBJYICv6j7KnjvgZdiBZwMf9KGQbA7bammkso31ebjFLvKFkEugRZA3rRq0DCHl421LKn6ht90a3A2bihC6RUlkbwpaSNpCnvOL0Wz2+RazdzN9yNgQmKszRGyj0BNmbkYeoepc46kC7aHutQ/2pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721240964; c=relaxed/simple;
	bh=NE9uXHyHtzaVKZLxQkRH19gIwk8vrUZslaVOA09pa2o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=biXt8LF2pTtyf98qyvPL5vJg2OGVVikRXBXLA4rBAxDUKYO5vElDDrUi8jxghUz7z0pPlxHKd5mzih7uG77dqAbnaqKoSOkQGhlAQRdjI6Z8Lu53tRLAQhb2b6YWOhb790Hv903IDi8sHOCk2KgieGysA4Ep0xdrQ7yrnowU0Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OvVeAQh6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a2FNpj73; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OvVeAQh6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a2FNpj73"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8D7BE409D9
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Jul 2024 18:29:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I9aw3NYEjReF for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Jul 2024 18:29:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 05E74409C7
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 05E74409C7
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=OvVeAQh6;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=a2FNpj73
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 05E74409C7
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Jul 2024 18:29:20 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HIAupH023775;
	Wed, 17 Jul 2024 18:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=sCaYo/GqcLfqo+b8rRWPMtPWgLgpi69MCdFjZ5u7A4c=; b=
	OvVeAQh6sqieeWCYNWAiW4/aS2M0WVSpHZL4Wlf100B9tLQU23TiY8LEwCFuxvuy
	DAt6y5TVjwUuXsv42FucY2fSaR+RKXKDisbTK0hz20KK1uXXsxQqvxa0NxsxA2mX
	si2BPdEosxGffHW0GTYMXBILNbHmR1CMAUiMg5gOs2adAdSxt1Ah2MgRQqy2pUwg
	aNCGx2+WxsL5zYB6lM+vIMkGGstDpfBLpZKYPr38LEnpMkjGcqLesrxX4RPN4aDO
	zLhq1rkQ+V7oRoFeslrgPUUifcy+ERm+KCAlxW9r5XT/gl6WsH4QVH1ccg3XPN35
	A457dxkDJjCLRAXETYjmKg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40ek0gg1h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 18:29:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HGf4YZ031871;
	Wed, 17 Jul 2024 18:29:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwexqybx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 18:29:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YejqujSEE22T9reZeCSdZ+1hay1FNbuV9TZobEoyRjJamDdaQ+L2gSDTH+pxAbvRJijOc+mPWykF5/aMbBgWdPorc6YmXv/uBIA5X748Pc6uI9m3wcOFcInlOlLMJhzXCg7qPmn1YC64AabcfbpTq318G/J2ICXmrWaxplOqS6HKJ98mOu6x7VVIrcagApKGBBxwzYAiVjNi6r18S1bJzcEF4x5A7chsP0e1MyN6c6YJ3SBmzY2CA7w3ClweVyib1VPplwKhb2uUbkHTwDELUnrpRJ6DEr/m3Pqoz1YpK+FK6i2Jj8uyx9ozLwf120YrnAT+r7aQI9LRGDPzrqFjHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCaYo/GqcLfqo+b8rRWPMtPWgLgpi69MCdFjZ5u7A4c=;
 b=VDsniczI5UHszvs1lvscadIMUHRwCFRKNBzzV3ipjoJrfO2qSDtpVSnzHfW8K1S+FHegmfC1WRN+fAidsM4Bo2UMo4VJSkkIWuscmLxqIMRCubLKfLlMUIDc1Kg6/RPn4tHGp+g5m3UWe96eVikpLpKRtSgIWiBprodUbbzw3f/g8HRM/gPeq+zEvXGMEkE/yBV1vqwrL2WPsNxLyT3BY6Ddjde1fjEAoIcvdEOPOtFwQDH8fQ8ulksxBbvnUdHwUzmZZJfXucZCJC1wxsvd774hxbWCKPwHZGq8+Cz77Xophtu6CH4Oekcm6dxiMvY30uIVcbmz9IWVMfOJZHgb5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCaYo/GqcLfqo+b8rRWPMtPWgLgpi69MCdFjZ5u7A4c=;
 b=a2FNpj738cg0c3ftnpG9iDeqP7Kyxukb8KSEwLI7czpoHdEfwOcPGPjLYk1SZqqT/BiEU8ir8vL34gv0Y1st2d6fhWb9KElEkCg08KcaCb0Kkh+qSh4sSBpVUXfpBKMaZUkuqIqJUyT6Ll7jhLQCBLKvzIZx5+KjQQADsc3mBVY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH2PR10MB4183.namprd10.prod.outlook.com (2603:10b6:610:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Wed, 17 Jul
 2024 18:29:14 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 18:29:14 +0000
Message-ID: <5a1cfaaf-64aa-426a-b1b4-da84a66b362a@oracle.com>
Date: Wed, 17 Jul 2024 14:29:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/7] vhost-vdpa: VHOST_IOTLB_REMAP
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea
 <dtatulea@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <1720790333-456232-6-git-send-email-steven.sistare@oracle.com>
 <CACGkMEurG88fXiThyainxbuzpgBUzzGkmvyQB5vuXsU7_6XBBw@mail.gmail.com>
 <d738a0e2-5a17-4323-9c86-b5a806066292@oracle.com>
 <CACGkMEuj-6EcEPo9xKkmuPSaQPQnH6zG+j2cqLRiScWUB4oqXw@mail.gmail.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEuj-6EcEPo9xKkmuPSaQPQnH6zG+j2cqLRiScWUB4oqXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0138.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::17) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH2PR10MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: 93be60c1-3c7f-417f-65d8-08dca68e5c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ckpPd3VFRGE5SWJyajBiVCtrVTZMSDhudDZncHVOVDAyc2ptZXZxQ2tPcy83?=
 =?utf-8?B?ekZNRTN1TU1FeTNJTjBlR0RBSmJOdVhZREI4blB3Z0VnbG5oN3daRnNTbGRm?=
 =?utf-8?B?Z1V3UnYvdXFJOUw5K1ZYSk1PZ3M4R01ZLzNDSFJRcVh3QXdhdGhZaHptYjc3?=
 =?utf-8?B?a2lKWVRKc0dJRUFLNCt6TzR5MWZvTVJ2VmZLRWVxNXhiSjVoeFpRS1RjbStH?=
 =?utf-8?B?VE1CVmNpdGZUckRidzZaOUFJZkowSHFxclRscDk1Tm9qb3FIbEp4bjlzUHpp?=
 =?utf-8?B?WDJ6MklML0kxTXJIV0tEZU9sZDdPSDdNNGpNZC8vMDRobDJJeXh2V0Y4T2hu?=
 =?utf-8?B?ZE5aZS9SbzRrTXcrT0JYbm9BaVBQQ3NsUWxCaHpIMCsvb1J0OGt2SzN6UVpM?=
 =?utf-8?B?azIyR09hTEhjY0V5MTRZS2pPalppTHYyT1A5TGZYUFNFcDlLLzF2dzFMdThk?=
 =?utf-8?B?S1Njc2N4L21RVnlQWkxWbjJDeis3a2dkNU5GcWpNMFI0Z3k2eDRpVTN1U0N3?=
 =?utf-8?B?eC9FbE5xYjRGV1BqVFFQbG1meGdpRjRjOEpZMmpOWmMyOEhqdXJvK2pYSzhj?=
 =?utf-8?B?ZGh2cDFyRDJITE5sNW04K3gzc3dqajVCdVIvakJqUDQycFlqSXJWVWo4RHJS?=
 =?utf-8?B?bExhL3c2Umd4ZThlbjVOcnVMQTVMN014MjVNR0dmS05OVW8rWXVzZWRacERD?=
 =?utf-8?B?REV4eHdqNWxpd2JrQTVHays5UVFPWEl5QlhHYk1BYW1UbHBJTjBuemJJZVU0?=
 =?utf-8?B?Qm1yMWNlUi8zU1NUUStPbTRHbzZLWFNSVU00M2MwQ28wcFBnbFZLVUorT2Zt?=
 =?utf-8?B?UThvYzBPQjZRWm13UW9Qa2RHSWlYTlV6VHVMK254ZFI1VEJRRUtmaDVOVlVH?=
 =?utf-8?B?OUUrZHR1a2VNTUVSL0ZzdThnNGFjVU45SWdXQmxzQVdsRUsyQk5SN1NzUjE2?=
 =?utf-8?B?dUFoN0t1QVhxZHRkbm51eWdDRHFoamQyNnBjMXorOGNQbElqcSs3cmh0YzF4?=
 =?utf-8?B?aVJPeTJscFlhWFhMYTdxOUxScldxNjF0aVNteHFIeDBIV09vejFNeGtaV2VR?=
 =?utf-8?B?RmZDUHdqMEMwWTl1WFBIUWo0VGxQUFd3d1dMNVdDUzlQNGd1K2dneTV6c1Q5?=
 =?utf-8?B?UXBnV3l3VjVRRy9La0l5cEw2MHhVbU83eUhBY3Uwc0hSMXFObDAyejFrakFE?=
 =?utf-8?B?V3plNWRnQ2VEdlVmNWxLOUZGK2ZFYlN3Q0Y0aTduUndYWHBzbzhLNXlBL01h?=
 =?utf-8?B?WmtvUU84a1Y3VVRaUlQ1SG5mQlRlU09ia0dJdVRFeTJtRGNMNVQyWHRVaXBP?=
 =?utf-8?B?N0Qxa2lMS2Nxa3ZEalJOMzMvdWR2bjlEUmdqTlV5c1h5VDFwUTFRN2QxclFq?=
 =?utf-8?B?dEF3ZStpclBuZUNFZ0ZpVzVHNHhzdWtBbXVZaUdJalA4Tlo0bWE3NW4waC9D?=
 =?utf-8?B?cGZQc1JCQzB0a0NodWdRVTRsK2sySVZWc09tWHdBZTlEUlh0TDNzT05DaHRt?=
 =?utf-8?B?VzRtOWxYcnZhZEFNU0JMZ1BqbmJVRjBLcTFiNG1QTXZGSExqeDFTVEViaElP?=
 =?utf-8?B?dWt4OTdjMlFka0JzVnhXeVYvMU91blRuTlR2NmVsVm9WNEtzL1IwWENBMjBl?=
 =?utf-8?B?YkdIRDYydDJXN3pXVWh3UWlmYXJ0NW5ZWFVIWWxKMkxyVTZ2MHUrSlo4M0F3?=
 =?utf-8?B?MXpBbDI3elVpSjJydEY2cGJMWWIyWmRtK0NGOHptSzZ1QlNMQUhlbitXaEJh?=
 =?utf-8?B?a0tiRVhkY0lTTm1oQ1AyeGl2MGFIdzUrVlZ0RDVQTXZKNWlYcDZNTEljRmd1?=
 =?utf-8?B?d0pLTDdHT0NJZk15dUJqZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UGdWZStEenc0bzBnTFVyeTV5N1F5M1pGYzVSRTJCWWpycWpkVVNTN2htbXc3?=
 =?utf-8?B?bjVPM05VMTFFQ05DYVlzUmxMRTc5WnBUNWNJK1I3SXd6ZGxpb2JXSmtVN2Vz?=
 =?utf-8?B?cHRkMk90dGRXNVRIdkp5Z01oUjNOSTIvbC9qb2htWFBqaVpCUld4UXFnWG5O?=
 =?utf-8?B?TjNvWkdHaVpYYTl6K0lGNDVZbWcrdlROOE41TitFWlQzVjFkQ0pybXNOYkt5?=
 =?utf-8?B?VE1td05hM01YOE1KQXRSdHhqcEtSam1Dd25FUDFsNDgxWHJlU29PRFJLM25u?=
 =?utf-8?B?YkF3akF1WUxmZ2YyYXdvL3U5THJVbGM2cXJFWEJKNnlwL21venpBcFZwTmxx?=
 =?utf-8?B?VWF4THhCSFdVYnV1dHVuZERnMjBPQnJQWStHTitwMXV2a0pQaEdZZmtPQk42?=
 =?utf-8?B?V09hNWRaUXBpU3ozcUJuOEdCUldyU09iMW5tWEM1dWptYkR5dVFmdllKQm9x?=
 =?utf-8?B?KzVZZk9adzZOeEhJS0tKTlRBMzdvNzYwTDZOZE1xbFk1eWFqMklSMmJXZEw1?=
 =?utf-8?B?Y1RLeGRCSXVLWTlQNWl3V3A5RG93NkVRMTlFcXdRNUtUUnNaSGJseUhONnh6?=
 =?utf-8?B?ZFdLOHhKVmU5a09YQWNJM2ZQeDB0UnlEanJXN1ZJM2diUHJpblVLSGEwWERB?=
 =?utf-8?B?REVuK0VGWWt2UjVLdmJLUXpuUTYwVWVIcVVBQTZ4L0hiaUptNHo5RkNzMHlt?=
 =?utf-8?B?NDlLdmptNExHZ3ZQTTFMbEozaCsrOXdMMlc1bTNuWXFNNnU0cnNSU2Z1UzlC?=
 =?utf-8?B?M1FrU0pKTWhZbGF4cEdRUnJ1YzA3Q1RIb3dSSU5icG96Z3ozdkhlZ2NHZTlL?=
 =?utf-8?B?MmY3WS9UL3N1enV4NlJkbWF2VVBBOHl2RTZsYkYzUkhxaGJxN3hRSHZTYkhF?=
 =?utf-8?B?eG1QaThBTVNnT0ZaRUZxTDVCRitvYmpickJQang3ZkxuMFFzWHlyRmVNTGRN?=
 =?utf-8?B?UU9Sc2xLSStGS3VuTGpRbk1uNU5RMEIrMTNZeWFqNlk1MGpWSnhRR1RoUGdR?=
 =?utf-8?B?cmxiY3BWbTBkVnduRjJuc2djVmhEYnprMDdvK1h1bFplK1Jyei80aVRQWWN1?=
 =?utf-8?B?UlJhRHdZZDJhSzVhMXV5TllDTmpCYVFYaFJpeFNSRE9kUGU5RjUwUVlxRHpD?=
 =?utf-8?B?clI0a01WS0RjSWIwKzdqa0d2SW5xWFZ2YXVLdzcvVFFBVHkzZFByemlTYjdY?=
 =?utf-8?B?bm9YUDViOUlsZkRtZzI0RUR3cldZNDhHK1F5b2tLYWQ5MUlrNWx4aTZKOWc4?=
 =?utf-8?B?eG1qRnpQSEFwcXJNUzdNU00wMXp3QVQ2K0laR25ZczF1QUUzREdSUUtWWStT?=
 =?utf-8?B?a2k5djBKMjIzcDBBODV6MGVmcTdBc3c3K0N0Qjd4OU9zUHpLUFlDbERVSVds?=
 =?utf-8?B?cjBuMVN1Q1NtMmF5bnpuaGR2NFY0bVcvcW9Ha0c4Q0lVclBVNHhPOWRkamFq?=
 =?utf-8?B?a1ZhN2loUkkyTzFnNEVvUDJxcTJ1NnpCWFdhdnRDTk42b2xQVmIwU2ZmOExt?=
 =?utf-8?B?bzk4K09HUHpxdjErUlVRcysvbUxKNWxGWEpZWGQ5c2xmNXlLQ2NHWVZnUWRF?=
 =?utf-8?B?MGtiSGpoVDFXTWxRSVRxbW1XZkdHOHZhZGJkMitlTm5NVlVWcDk2eWQzUWs5?=
 =?utf-8?B?WGYvQVhzNGI3VlIyZVRVS210aEhwQkI2NVg2WVA3ZHk1Q0F2aEliMGtQMU1q?=
 =?utf-8?B?aHFXVFovVUhJWmZTNGZGT1Q3dngyb0h3dTIwc0ZjVjBnWHcrN3F3N2lYUlhk?=
 =?utf-8?B?aXBPeTZxTzR0NlprZS8yUlBxZWk2VUp2Njd5cjVGYklUdW1sbUNqS0hvSHhJ?=
 =?utf-8?B?TklPaDNFSCs3cEJHakNsQmJqWC9JVnkrNnViL2d1MnY1VE5TelJuQnU2RVFt?=
 =?utf-8?B?U1RhRHdRMFI2ZkhyVnJ6SEVtM2lMM1NMSEJPdXROcHBySVJMMDZwclFyMzE1?=
 =?utf-8?B?aURqUEVrTEE0bGxTS3pTeXZaSWw4Ykh1cjUwNGtrSzRINElCMWxxUldHWTg4?=
 =?utf-8?B?eFFwbFJPUVVHTW1qWTRzTCs2WVJpbWRmL3lhV0daZ25oT0c4K0I1b25Nb1Bl?=
 =?utf-8?B?b3l0Skh2Z3JvVUtjRTVrSGZhN3ZkaDRVc21IVVFBTnYzdTh5b1dMQzNzNExz?=
 =?utf-8?B?TC92SWcvVURSeGY3MWxPYUNFQ3psWjkwSHNhdG1CZ0prN3JVZEJXc3dqS3Ey?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	umRwpPqpJ08Xc6HQaCBtMigESl7joxvgh93Np7DiX+SmYaHU96i7qqpEPBvpcRQQeBduoaZLW3BTyCsAHr2AGGaQ2p0ctMiBpChrDkY8rCsOVN8dp/Og6Ps8BviwdbK8zWeYUUafxcLAJBt6cFsnM6/SY5QGlxh6zhNqOVAraLQKlqR90CIDRXWukNeU6HXwvn3BaSBZLNxHOKdGwZboMXYXVZc7i9//c7G85I1kAGDCOD6NBe5QiamvEjGjDIklE3EVh+OCqaSkKD0JnywLavnPMYYL/CDvor5AcDkIFJu9TEtPPa/K/P8YdKW++uJkCdzwvEMTw0CIS0mvNKZdc0fQSYMXsZKtcPDA3paG9n0zXEcLzJ/LKmtU8h/cSO5E7LqomSD8XTTwaBgHj8L7b1+8mvD3RjE2vFKeVTaRShkvpsQwERNZRu/VrE4pa71RtAtKOfHUCq7/xdeUWkeZ5MhB/Qh0Dg/UToNjgy1t7nSjqcWck08ShNDPk6g+DvixAIB1bwKmvfp3ZyAcLYS4QKEOND3YnrXuj4nFGdWfN53ltQnjpi0QTrPlB6rxbJYpczCmjHyDAtV3AUQ2g02/sY+KuF521byLg76QsSKPO7k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93be60c1-3c7f-417f-65d8-08dca68e5c10
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 18:29:14.1648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94VjedwkN9gP4elbuKk46o2qNvVr/FoRGay/+9AeHQhD0aC8D0Y+KEiz7LMl1TnNoTR5ndSkdBWOvKC6qj9b8X47CpsnwKn/RumiMgxG2WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_13,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407170140
X-Proofpoint-GUID: BTB6V6gm7H9bkqToRFs3FZ86vF3rKEO4
X-Proofpoint-ORIG-GUID: BTB6V6gm7H9bkqToRFs3FZ86vF3rKEO4

On 7/16/2024 1:28 AM, Jason Wang wrote:
> On Mon, Jul 15, 2024 at 10:28 PM Steven Sistare
> <steven.sistare@oracle.com> wrote:
>>
>> On 7/14/2024 10:34 PM, Jason Wang wrote:
>>> On Fri, Jul 12, 2024 at 9:19 PM Steve Sistare <steven.sistare@oracle.com> wrote:
>>>>
>>>> When device ownership is passed to a new process via VHOST_NEW_OWNER,
>>>> some devices need to know the new userland addresses of the dma mappings.
>>>> Define the new iotlb message type VHOST_IOTLB_REMAP to update the uaddr
>>>> of a mapping.  The new uaddr must address the same memory object as
>>>> originally mapped.
>>>>
>>>> The user must suspend the device before the old address is invalidated,
>>>> and cannot resume it until after VHOST_IOTLB_REMAP is called, but this
>>>> requirement is not enforced by the API.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>    drivers/vhost/vdpa.c             | 58 ++++++++++++++++++++++++++++++++
>>>>    include/uapi/linux/vhost_types.h | 11 +++++-
>>>>    2 files changed, 68 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>>> index 4396fe1a90c4..51f71c45c4a9 100644
>>>> --- a/drivers/vhost/vdpa.c
>>>> +++ b/drivers/vhost/vdpa.c
>>>> @@ -1257,6 +1257,61 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>>>>
>>>>    }
>>>>
>>>> +static int vhost_vdpa_process_iotlb_remap(struct vhost_vdpa *v,
>>>> +                                         struct vhost_iotlb *iotlb,
>>>> +                                         struct vhost_iotlb_msg *msg)
>>>> +{
>>>> +       struct vdpa_device *vdpa = v->vdpa;
>>>> +       const struct vdpa_config_ops *ops = vdpa->config;
>>>> +       u32 asid = iotlb_to_asid(iotlb);
>>>> +       u64 start = msg->iova;
>>>> +       u64 last = start + msg->size - 1;
>>>> +       struct vhost_iotlb_map *map;
>>>> +       int r = 0;
>>>> +
>>>> +       if (msg->perm || !msg->size)
>>>> +               return -EINVAL;
>>>> +
>>>> +       map = vhost_iotlb_itree_first(iotlb, start, last);
>>>> +       if (!map)
>>>> +               return -ENOENT;
>>>> +
>>>> +       if (map->start != start || map->last != last)
>>>> +               return -EINVAL;
>>>
>>> I had a question here, if a buggy user space that:
>>>
>>> 1) forget to update some of the mappings
>>> 2) address is wrong
>>> 3) other cases.
>>>
>>> Does this mean the device can DMA to the previous owner?
>>
>> Yes, but only to the mappings which were already pinned for DMA for this
>> device, and the old owner is giving the new owner permission to DMA to that
>> memory even without bugs.
>>
>>> If yes, does
>>> this have security implications?
>>
>> No.  The previous owner has given the new owner permission to take over.  They
>> trust each other completely. In the live update case, they are the same; the new
>> owner is the old owner reincarnated.
> 
> I understand the processes may trust each other but I meant the kernel
> may not trust those processes.

If a process holds the key (the fd) then the kernel can trust that is has
permission to use it.  Keys are only passed around voluntarily, unless there
is a bug.

> For example:
> 
> 1) old owner pass fd to new owner which is another process
> 2) the new owner do VHOST_NEW_OWNER
> 3) new owner doesn't do remap correctly
> 
> There's no way for the old owner to remove/unpin the mappings as we
> have the owner check in IOTLB_UPDATE. Looks like a potential way for
> DOS.

This is a bug in the second cooperating process, not a DOS.  The application
must fix it.  Sometimes you cannot recover from an application bug at run time.

BTW, at one time vfio enforced the concept of an owner, but Alex deleted it.
It adds no value, because possession of the fd is the key.
   ffed0518d871 ("vfio: remove useless judgement")

- Steve

>>>> +
>>>> +       /*
>>>> +        * The current implementation does not support the platform iommu
>>>> +        * with use_va.  And if !use_va, remap is not necessary.
>>>> +        */
>>>> +       if (!ops->set_map && !ops->dma_map)
>>>> +               return -EINVAL;
>>>> +
>>>> +       /*
>>>> +        * The current implementation supports set_map but not dma_map.
>>>> +        */
>>>> +       if (!ops->set_map)
>>>> +               return -EINVAL;
>>>> +
>>>> +       /*
>>>> +        * Do not verify that the new size@uaddr points to the same physical
>>>> +        * pages as the old size@uaddr, because that would take time O(npages),
>>>> +        * and would increase guest down time during live update.  If the app
>>>> +        * is buggy and they differ, then the app may corrupt its own memory,
>>>> +        * but no one else's.
>>>> +        */
>>>> +
>>>> +       /*
>>>> +        * Batch will finish later in BATCH_END by calling set_map for the new
>>>> +        * addresses collected here.  Non-batch must do it now.
>>>> +        */
>>>> +       if (!v->in_batch)
>>>> +               r = ops->set_map(vdpa, asid, iotlb);
>>>> +       if (!r)
>>>> +               map->addr = msg->uaddr;
>>>> +
>>>> +       return r;
>>>> +}
>>>> +
>>>>    static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>>>                                              struct vhost_iotlb *iotlb,
>>>>                                              struct vhost_iotlb_msg *msg)
>>>> @@ -1336,6 +1391,9 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
>>>>                           ops->set_map(vdpa, asid, iotlb);
>>>>                   v->in_batch = false;
>>>>                   break;
>>>> +       case VHOST_IOTLB_REMAP:
>>>> +               r = vhost_vdpa_process_iotlb_remap(v, iotlb, msg);
>>>> +               break;
>>>>           default:
>>>>                   r = -EINVAL;
>>>>                   break;
>>>> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
>>>> index 9177843951e9..35908315ff55 100644
>>>> --- a/include/uapi/linux/vhost_types.h
>>>> +++ b/include/uapi/linux/vhost_types.h
>>>> @@ -79,7 +79,7 @@ struct vhost_iotlb_msg {
>>>>    /*
>>>>     * VHOST_IOTLB_BATCH_BEGIN and VHOST_IOTLB_BATCH_END allow modifying
>>>>     * multiple mappings in one go: beginning with
>>>> - * VHOST_IOTLB_BATCH_BEGIN, followed by any number of
>>>> + * VHOST_IOTLB_BATCH_BEGIN, followed by any number of VHOST_IOTLB_REMAP or
>>>>     * VHOST_IOTLB_UPDATE messages, and ending with VHOST_IOTLB_BATCH_END.
>>>>     * When one of these two values is used as the message type, the rest
>>>>     * of the fields in the message are ignored. There's no guarantee that
>>>> @@ -87,6 +87,15 @@ struct vhost_iotlb_msg {
>>>>     */
>>>>    #define VHOST_IOTLB_BATCH_BEGIN    5
>>>>    #define VHOST_IOTLB_BATCH_END      6
>>>> +
>>>> +/*
>>>> + * VHOST_IOTLB_REMAP registers a new uaddr for the existing mapping at iova.
>>>> + * The new uaddr must address the same memory object as originally mapped.
>>>> + * Failure to do so will result in user memory corruption and/or device
>>>> + * misbehavior.  iova and size must match the arguments used to create the
>>>> + * an existing mapping.  Protection is not changed, and perm must be 0.
>>>> + */
>>>> +#define VHOST_IOTLB_REMAP          7
>>>>           __u8 type;
>>>>    };
>>>
>>> Thanks
>>>
>>>>
>>>> --
>>>> 2.39.3
>>>>
>>>
>>
> 
