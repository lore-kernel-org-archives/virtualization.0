Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795855274;
	b=fmdTeDeji5E0IOU8n+XnIXbcF5MPmzhILHd6H8uZrYIBmQMMsAt5Wt+7rzczULvuwGyA
	 tfVYN5DRmA8+f+STHi4nchJt58d5+ke3mnRzfb07DxtTTiHKnWqIOcnJVAehCclFrGBVx
	 YzFGxuCznk7RpUt2l5MOuUoGXhnatAg2NAkLYrb9wyX0+JTeIay8Ak459AifPdLPqXTz6
	 oz3MSLrdH+ww5Hh0JNzRVN1ArEF9xXMFKXczDIkuHtZzLjkkOSUoV1NVuBH6BE5t62rzQ
	 fSYdYspk5TRmuWmySlA7WheFauedm3HoJglixT7iHCwUhcCmZIFySHg2TOmqmhxxXvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795855274;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:
	 Message-ID:To:Cc:In-Reply-To:References:Date:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eTVy0bGw52rI1jeGLkhzPwyWKDHSnOctv2TizQ9krxw=;
	b=NO+Zd5UFIsF0rQPt7FnWQc/FRmMDfhPVNj20vZ56Dw2c6jpFFw6kl6B9YbbfzQ8HFcsE
	 8sb4Nywyh++/8TViU3bj0PoKzSHIC6JVB8wBqUI3tx3vn4aboZd4YytQjHZOIA145dJeh
	 Vp39oj99IFGpxHkY7Qh3kGYKvotXbxKmx6F6/A4hQVJhLUeYAQyZb7kK4Cfr8CXlPWB2b
	 odtoRyYkixjCrINzFI5Jfpu7iXYN1NEBaB4kEJlY4QXMLrGpQiCx4PGGWBpDUG5XF+e8E
	 F3Huml+ig/G7ZnV7jEROfuQi+J2UIerS3BDXTxRhuMvGo86zyodbQI2d0VkDUCEApPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b="ho/YvRQU";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.6
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010006.outbound.protection.outlook.com [52.103.66.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E07606A31C
	for <virtualization@lists.linux.dev>; Sat, 28 Nov 2026 08:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97E07606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=ho/YvRQU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyR6us4hWhDggLeYsLDT0SriAbktGrvzqMY/+Ko4J0V6GBafAtGMfh+tJVg6lIsNclEAihKOecizZDAaYIT69VoezQZ/DQn4v+RxmGBsyHLOc1SZ3xnuYLYe7IUhXFkRoGEBRtGb4w5ZgqvJDL/vsmLf31o1D9oobj1q1wP3nq9FPm0inHZJMBPOqN3Ai2ns9wqJukQyonyZcIOCtHf2QOUkH3oRXUt+fO9LKbF5A0cT0CXeWHT9voffOx7JjTWWRTUh8IS0O2bT/zE6ON+6rNdSXBunSmqxFmsPm2OVDTi9Ah0iN0JR7MANUQHdqZMEZD4ajpUXfdrVF4C+s6/jeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTVy0bGw52rI1jeGLkhzPwyWKDHSnOctv2TizQ9krxw=;
 b=kWCTfCUi5AycJh3Ms4mWCw/ToGENUU3apH53BzKkG5Q0RSmOikH/rYUG7Re/myfh5VSuXnkMLmzMZiYZXu3eXrBGLRBMOGmFSHL5B7ig0nnu2NeFXGLenADxVzfdF+LS73rUBZ9zqh3G3sELbZQg7vf74L2yz5t9DsWHhSwxuUUc0/fkAWLU6ia31OHTpjJVmcF/jOpqxsJcat1hLCdt5YvUaH5VAmaCRCMsvd124zxViHnbPNC8YjiWJKx3WG6vCqG1Bi/kTWxd0xuoDOBpUKA12L6h1xeZPz0LH2zZC6LF5pjffaubDLHbCL7D9JbWiKSH9sFZyChQ/YQ8+XURzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTVy0bGw52rI1jeGLkhzPwyWKDHSnOctv2TizQ9krxw=;
 b=ho/YvRQUOpqqeUj0NGj7G97n+u/dxKkfjMr78DCU1wXF+vPGXGwKyGYzHfaOEnO0/zyfDxHs7HyccFwlVkyyVW8p/uzUpXUpZw179e9pOhjALOEb7dLXvHBkIInpn+FGcX2r8BpLPjshPmgQudTEIati0YknG3o3iBhXnZ95H9C0uzI2i9IiXIWpsFuAKFlI96+eRLeZ9XG47dhMTpuMmyxfe+AlugCttLl21k0POfXaFkkAUrqFY7pl6UPKpQ6lfniaDrOAmco4hwia7AgnobwIufFtmD2nIlgpSPpcstgflw80kH8rkWGcJ3nPWAZ7e+5TKFQbRFy4nP5bLdGVNA==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TYYPR01MB7055.jpnprd01.prod.outlook.com (2603:1096:400:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Sat, 28 Nov
 2026 08:41:08 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 08:41:08 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: Re: [PATCH v2] vhost-vdpa: skip unmapped gap in vhost_vdpa_va_map()
Message-ID:
 <OS3PR01MB1025190F5285E8D5EC0BCF66CE7402@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: "Fang Xieyan" <fangxy@xiaopeng.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"Jason Wang" <jasowangio@gmail.com>, 
	"=?utf-8?Q?Eugenio_P=C3=A9rez?=" <eperezma@redhat.com>, 
	"Xie Yongji" <xieyongji@bytedance.com>, <virtualization@lists.linux.dev>
In-Reply-To: <OS3PR01MB102513620123817B5CC67D58CE7402@OS3PR01MB10251.jpnprd01.prod.outlook.com>
References: <OS3PR01MB102513620123817B5CC67D58CE7402@OS3PR01MB10251.jpnprd01.prod.outlook.com>
Date: Sat, 28 Nov 2026 08:41:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0049.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::13) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID:
 <720c11a2-1b2d-4b24-8d36-2197f584ab68@milk.local>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|TYYPR01MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: 8adcd7e6-bcd0-4f00-d235-08df4d2b58f4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|23021999003|6090799003|25010399006|51005399006|5072599009|24121999003|15080799012|25031999004|8060799015|19110799012|22091999003|1602099012|10035399007|40105399003|3412199025|4302099013|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzh0YjlkTjRtRXkvKzJSTlBCdXVWWGFuZFN4djRhYlhqd09uSXpBeXFCMUtE?=
 =?utf-8?B?cklOVWR0c1YxQ0V6Nk9kSXNRdTc3VzJNaUtJZHJ1QkFtN3MxNXhOOTNMOEoz?=
 =?utf-8?B?VjFHU1FFRmdrQUk4QnJnbjRFZC9kVW5uT1hsOUJ4V01aNFpQTE95MTlwTDZj?=
 =?utf-8?B?YkR5Z0g0b1BIYlJLcU8wbm1QazF0dVI2dVR6UFdTQUZRN2poOStvRURianlo?=
 =?utf-8?B?NGxyYnVPUUorTGZxeE43dXJHczB4Z0dSQlN0bDExQjQ3N0dKZUNLZDh4dDda?=
 =?utf-8?B?eVB2bmlobDZjWGo0UHl4eEVOdGNDS3FuOThuaFFqK3NQWjlOZUlseHhuTGZS?=
 =?utf-8?B?T1pOOVNjQVUwb0RIdFhzWURHZGlSL2Zac250dTNDazBBMzV1RUdpNVI2OFZj?=
 =?utf-8?B?b21vcFZwWmE4RzVlb0wwakpUMSsrZGNWRDRkYTBKcWc0eTFDS0U5T3BqUnYw?=
 =?utf-8?B?UXpDZld1bC9reGRwN2tNKzNURXFaMFhibFI2b0swYWFxU2FMVzMvNGhnZkta?=
 =?utf-8?B?SytHN3NCdFZYaWJkT0FWSE1sc3R0cXZOMC9VUk9uN0Q4dWpoMWh5WElSeERR?=
 =?utf-8?B?OGZ0ZkJOOUFmSFRIUU9PZHRJT3RTczJBTjlIRlJ5K1lJMS8xTlpMMmpzclVm?=
 =?utf-8?B?S2xmYVIyWC9zK2RKVVJDRUV2V0RqblBtVEx6TnkrNjlkRnBWZzNaSm5zeGlo?=
 =?utf-8?B?eGR4cm11N2JrVWJheTRNVlZyNm96UEkwRHJocHdWRDZVaXhLZnZBOHBydlFy?=
 =?utf-8?B?TktWZ0NUWlozWWZmbGtmK1JlNms5Z1RORmtkeEhvUjdpcFRCTUVmZTBqTlRF?=
 =?utf-8?B?d0swTE1zUzNuczJSUHlmVHltZkY1MWVxR3BXSkljOHI3RUh2Y3pTREc1RkEy?=
 =?utf-8?B?dGIyTWlyNytJY3d2VTBPVXh6UjhSak9DRmVEZnZtQmhTdmFpNjUzRENTL1k2?=
 =?utf-8?B?N0Nzd2VDSEdXaU10VWRaN1hSQWh0Vm03RXhyS0hONXZJTWY3NUdGNmVvWDZD?=
 =?utf-8?B?aURYc1VqSyt3aU95YkR3VzhBNTRhc08vMGZrUEZmQlJJRkw4dUtoOFVBZ2ZT?=
 =?utf-8?B?Sjg0UURQYU50cXZLREZqQVR1M3JJNUxnOXNWc1R6OTdHMVBMTXE2enlWdm1o?=
 =?utf-8?B?aVFpbFp1Q2JQbnF5OWxQd1BnWkRQcWloZ2c2T2J3MlJKMEJlT0VUUk1TZ3o2?=
 =?utf-8?B?UmQrK2NzVEczWTNMamk3d0o3ODRYVCtpdVIrWkl2TzlzdE54NkZiSnllb2NH?=
 =?utf-8?B?Z29Vc0tlZ0huRVFkY0R5Q0NpUXlxNnRxNTlJczZFazZJUHhyclNocFhycCs1?=
 =?utf-8?B?QVdZRmprR0pBdlZSd0tUMXlBcFpvWXliZ1F1cGtQd2FYZnFpSHZ1eTlwK05J?=
 =?utf-8?B?ZWdWR2p2eUZieWlNVGhtRFhIOHVGVWFWejdJWDB6NktsNzRWcDlBbXVJZnp6?=
 =?utf-8?B?M1kzbkdLMVIrVWN0QUVhYnR4RVVCc0l3aHJWQmFHNWZ6d0FKaDM1N2RhQWtB?=
 =?utf-8?B?aGZMbFVncDcxTHFEc0U1Q01OUy9rekYrUHFLU2ZvbEdzZ3hyek82cGhvWVkr?=
 =?utf-8?B?dS9ZQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlAzY3RkVDNzbFlUcE1UUURVTzRvOG05Nm9TUnBJaUU0QWw1Ulp4bVhIY21T?=
 =?utf-8?B?VCsrb2Rlb21WTFFCeko5bjBKMHhoTkpaUzZFakdoZDJXMzMyazA2Vys3RnVl?=
 =?utf-8?B?VldDOVpIVGUxNW9Od0JxTUJJTWtWYy9yaHlZL3lKbVB4aVIzSlp3aER3OHEv?=
 =?utf-8?B?aFlnTWhaSHBZRW1RakljVGszZFRpU1lFaURiRENFTU9kMTErR1I1NzEvVE45?=
 =?utf-8?B?VXFxUmE0SEZLUGVxTkJrWG1nci9lN3BRbjduNThLUllXWXJLREZXU1RrSThN?=
 =?utf-8?B?b1JUSk5YTUJmR0lqKzgxZHFQb253Ujh3bHhYMUxxdmR1L094OHY2YnNBTkF6?=
 =?utf-8?B?MlZ4K0VJaVpGdzk2WGFHeVZwdHN0VFMzVWxEdHMzV3lhRzFlbEtOVm1qR3NZ?=
 =?utf-8?B?dnJKYmFCWGVLNm51NTYxUTYrckpycmhEWjJrL2JWKzlqWVJ0dm1ucG5FNWpl?=
 =?utf-8?B?S2RaT0pScDBPRnh3dWhERlhlckROLzBwL0lmaUVwMUlwMUZYdm44cjJuWjYx?=
 =?utf-8?B?R3hXSE5ZTE5TOFRtRWVwVUdnYjhJVjdQdUZXS3d5Qi9LTStMZHJZRjRSWWpX?=
 =?utf-8?B?U1ViNVBtSkw3cDd2a1JxK05wTVQ1VkhINkJOazhxUDVSNW9yekVJa0E2dUU5?=
 =?utf-8?B?T3ZPdmIwUTZQazVFNmtlU3l3N29RaWZyYVozVHJSTnZVRWFGSmlqaytCRTNS?=
 =?utf-8?B?WnNqOTEzcWwzUUVjczRmRnAwSE1RZ2Y2dE02NUN0M0ZUU0RwSnRTcmFJbTB3?=
 =?utf-8?B?VHNwRVRBVEx6R0lGU203NjNPSStuSTZ2Q0dRTm9vNm9PdlMvNW80Ulg3MXVI?=
 =?utf-8?B?cW1jNEk1dGR2TmxrZmQzWnlzbERBSmozYlBkY1Fod2dISEhMaTA5aTRkbk1W?=
 =?utf-8?B?RkpZYVNZMUNJTlNkSHAyckFJYjc1NVdkaXUreXIxckhER0RnYjBETWMvZS9k?=
 =?utf-8?B?dmE2Uk5QSkxscEJTVFBDbUkrT2tSaEM4US9QazlFMGg0QWkzY2pxZFdySVJa?=
 =?utf-8?B?TjJmQTNEcGs3Slh2d1RGNDh1YWhYa05kakp6NDM5SUlJTXZzbWMwWmxVeVVL?=
 =?utf-8?B?dm42RC9wRlMxVW96SjNQQ3ZqSEl1NVQrbHp6elhaRmJZMFRHQTNwRmx3RnIz?=
 =?utf-8?B?dU5rTS9rYjVWbGJ4VGVEQ3pYUVFGTzBMQXJvZjJxWUVzZkFtS1lSY1FWZkUv?=
 =?utf-8?B?Mml6NEFaaHlCTnBxbWxZMFBOS0tudmh4SVg2dExGRHVac3ZjK2p5dVoxYXNH?=
 =?utf-8?B?dnpXZHBjNVF1SmhNRW50S254Ti9sZFMybGpKdDNCM1pmakhBejhVWHRjTHhP?=
 =?utf-8?B?YjM4VGdxYW1Wc1hWVitDK1VvS1JWSnBrSHFWYlVVaXptaldWZ1JyVjhJa0F4?=
 =?utf-8?B?OENxajRsV1U5SmZrSWlHeERueXRmNWZrNlZHOWJ3dFBLcjBNZ2xZdHhNb3g5?=
 =?utf-8?B?dUMvd0pndGhPcDZMYS9JbllpRXJXOWZOK3ZCV2J3SEo1ckFsUzYyendGaUph?=
 =?utf-8?B?Tk5xajJkWCtKRkxvdzZlUm9TcGVrN3kzb3ovcUc4cC9HbU1Nckw3QUgzejhm?=
 =?utf-8?B?OVBZY0ppc052SVRNVlZLb3owcnNJQk5jV2tpdnF0WkRaUUN3RWVvWDQxV0p3?=
 =?utf-8?B?S01NTFJaa2dYcEpDbGtST3l3bndjcnBtcEN2aXNjT2hlRzRFaWExY0k3aWk3?=
 =?utf-8?B?KzY4U1BUYm56amczYTNoZFNrMG9aWE05eXAwN1BXd21kQysxNWgzTXNsRDEy?=
 =?utf-8?B?WVg3dnhTdHNmRW8zK2NFeXlwTEh5azh6dFBwRE12YU0zRzJMM2RxQlcxaUpi?=
 =?utf-8?B?am9wRjN2VkQ4RFc3YmhXeEhxOCtUclpqaVZHOWFRcFc2VEVUR01qclBuODkz?=
 =?utf-8?Q?WlhAW04lQbalR?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adcd7e6-bcd0-4f00-d235-08df4d2b58f4
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 08:41:08.2958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7055

> So I'd fix the rollback first, then switch to vma_lookup().

Aha :P
Weimin already sent the rollback fix in July [1]. I've asked him for a
rebased v2, vma_lookup() can go on top of that.

[1] https://lore.kernel.org/all/20260716030238.124368-1-xiongwm2026@163.com/

