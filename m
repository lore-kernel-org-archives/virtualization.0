Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795854852;
	b=jB0lJXNAiVSmnoDnhocUlQKeQahGxwGrxknnonv56LKbg1hANUlqMGvimFt8u7ZiGmmq
	 Kjz/gL17HgSExAmDNe6HYzstuNi3fZkTkKXlRQKI3NN9CIU9CLLM61Yeq8JTcpNvWfyao
	 RaWs+QuwUPI8NLDbz2PypLsl7v7Na3ktt2Vg8uk+bjkGb+8Rj9eSxMxDwan8ATIDib6aC
	 O9dodgZsWjFAWbfNa/44wRXi5eKq67eSp+l7DCLTvGSvt1FLwd/vSsMg+ikbUTUPRH/th
	 IZWMGlZBnSSLKmUp+9yHrWNdhy2cfKuqg86RU4b4e8sVx/3jIp2tWC9O8ZnXPvK2+pA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795854852;
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
	bh=CGM6w2/kYDL0n13zZ3XOgg6Pz6cpAlVJPpofs/20Zu0=;
	b=hCFjOKDkCdDoKkTB/GMzXaH0IpFocllMRQFFlVLin16MBvKAgzBNB1mJvXavPYx1IzjZ
	 qiIA/SDx0BI3Gf0BlaZHwPkRx5gUvAM8HwvPcnmOse59+g+QhpJ10Couji0Yvo6vhOVIS
	 bsO5Gtf+OWAJEkONO80Wu8QJNILJFgvCK1iZfeDPHeEJT+us54U6UMg6E2BMgZ/X/kdTv
	 S362u74WGwBfJ1YOXZa3JBdG21Z3MRtIY8PJuR2rUXX/y2RATXab1suNVwF81gFqD0ft0
	 BVEJfT6LC1evaIiMa2Ibhh3yHxjiUs+fiwXxN3zvGMcTTP4uBoo6JrjZ4Vn2UlD455A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b="m/XonRcc";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.18
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010018.outbound.protection.outlook.com [52.103.43.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ABC606A31C
	for <virtualization@lists.linux.dev>; Sat, 28 Nov 2026 08:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00ABC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=m/XonRcc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgOR1wjFNC+Xco8ffRBl+SLDifpFyvnK5aaGTq2JeHjKrQrqI+FwwHD0txeyRP83zciOQTKtwO5N+UDWUfM21NpsQmxUxl5IdEiNrJ7NAQXusxN7e344hAMsnBIAL2CdDCmGrjzL4w2TVgQrf7qWEmln1y1ZMYfj8wjbxdMensn/NXC4/bmWVOQixxuOhu2hqy80Wu6gyVqdj185bNgjem0jL5ICaeqfm3gze+JNQKSJio0PSdloiM0B5Ues+1IxRI3boutUFenlBO78HF3AxIo8gSu4ckT51pa6V3VpsOWUrXj87J3SwMvmC5OqzA/66MXMhbuXLwc0YoTxLVemgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGM6w2/kYDL0n13zZ3XOgg6Pz6cpAlVJPpofs/20Zu0=;
 b=BblOg2iWZb0HnEyQRZiFRkiX9UClaOj6LEk4Ry9tPf5QynhG/GA+vIUQIVcO7QonxUPlu6l7JQAY+6tKOYe6Cl8mu6FWo43dXUsGGkIoFBuCqrbXQ6iKp3xink3NBe2y42bc30qnC7yLA/gf4U+R34sYMACpmdaGoGlHB8gYR87pZxA3ljc+OFewseU8c5WqSSibpIrKyQtM5ZWEFgVErTmh6oh/rV9eqLHi5pF4Y4D53Y3AQOc9c6gTCARbbJll5VKuxMiNlN9ELgkYQbJEr4JVFJWlt4TMQDKXewxmctmqDIg8R8GMWohkz7Uf9czonQxD7kQPi3UgHUX4X7Uf3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGM6w2/kYDL0n13zZ3XOgg6Pz6cpAlVJPpofs/20Zu0=;
 b=m/XonRcc+e0uRpkz8EQk2Yi4gC94ye7X2/4EPyfdNUNnldYPI6qXhPz+wybeFOyHoti8JSKaykhyMnISIBxtCG6oVU6EVoXsvxgQnBxX0P90jOEu9lzMKNQ6BCUGz0SWsbGc75PUtHQW6rfSfIXyZqR092ica1xZtdTJS6DQnhnn5lqYH0do3jwax/T/mCZMy3MkHkv9+wn9CT4K8b2mjuERS/NBQ4zpCpiYL3hlhAuABH7oE4I+3fMjdecgTcAC2Rt5ttwaUCneAn4mX0wGWI3t3SQFdQc5bGMyOLYt2uiIkab0H6afLijAKfiyCyC6nyWNj04Yp8gmhUZP9UcEyQ==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TYKPR01MB248038.jpnprd01.prod.outlook.com (2603:1096:405:3f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Sat, 28 Nov
 2026 08:34:07 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 08:34:07 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: Re: [PATCH] vhost-vdpa: reject zero-size unmap
Message-ID:
 <OS3PR01MB10251E9EECFB72AD4DEC74A02E7402@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: "Weimin Xiong" <xiongwm2026@163.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"Jason Wang" <jasowangio@gmail.com>, 
	"Eugenio Perez Martin" <eperezma@redhat.com>, 
	"Fang Xieyan" <fangxy@xiaopeng.com>, <virtualization@lists.linux.dev>
In-Reply-To: <20260716030238.124368-1-xiongwm2026@163.com>
References: <20260716030238.124368-1-xiongwm2026@163.com>
Date: Sat, 28 Nov 2026 08:34:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0006.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::6)
 To OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID:
 <ab10290a-3f66-48c2-9fac-fcf135c27040@milk.local>
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
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|TYKPR01MB248038:EE_
X-MS-Office365-Filtering-Correlation-Id: d73483aa-0997-4b05-efb4-08df4d2a5dcc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|24121999003|5072599009|25031999004|22091999003|23021999003|41001999006|15080799012|19110799012|6090799003|55001999006|24021099003|25010399006|4140399003|51005399006|3412199025|4302099013|440099028|1602099012|40105399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHJCNituYmZ0Qk40TFFsNjdFbHcrRnJYMzVGVTNVb0pxcVlGOWJQZmF6eUV2?=
 =?utf-8?B?TktlQUZNQzdSN3pJTmlFVnliTmVha1I4djQ3TWgzSEJnRjYrM3kzVWI0N0pG?=
 =?utf-8?B?VUVSVkR4NWVodU9Vc1JKLzZyRXMyVGhmZFJXV1orcThhMGhsZnZlZGtud05E?=
 =?utf-8?B?N05mcGR2cVZtM29qelpEcmRBdGlpb1Uxdlptakx2RXRVQlpYOTlZMGs3K1Nj?=
 =?utf-8?B?eE10MXFLSW14eURhK3dTL3A2YTVNMnBCQWJFYWJUa1hxOStrM3hlK1FTaXBW?=
 =?utf-8?B?S0lMS2NqaGJUTSsrWmxmMFRIWHlXaHZQOEJMZVJJK013dXlUc1EzQ3JZVWMz?=
 =?utf-8?B?TWlnaWk1WWZKWm85R0ZXbUxaSVVidmdYQ1ZkRWZoUFhsUWl4RTFBRHdRK0g4?=
 =?utf-8?B?OU9KcE5Nd0p0NWZIWC82dnQ1S0tMZm1aeVRFVkhPS3QxTzN1SUFaM05SQTRr?=
 =?utf-8?B?QTM2Sm9Mck1jVXU4bkZldUxkR0dZcU9XdmVrWU5aZGtHMXk5UDkwNmJiVEpW?=
 =?utf-8?B?c0hDZnB1UDdsUlBWT2NLSUQxNUwrUjYwdHoxd2V1L0d1UFJ3UEZvOFk3bkg3?=
 =?utf-8?B?SWFlamlwRkt2OGRSeGE2bmdkVjZHS2ppSlNjdCtsOGczOVdybm9rN0hCd0N0?=
 =?utf-8?B?T0NGZGxhZ2xUQ3NhZVRsLzkrSEJQSFg2MW11ZzVSemppTUs2cjNhRmFaMDJ1?=
 =?utf-8?B?WkVmSlF1QklISmpESFc5WmhSVFpMTzVuR1pFRUlzT3JXazRJcTBoSnZMYW0y?=
 =?utf-8?B?RHRPUTZ0KzJpOVRrYS9renBCS2tjZVMrdzRlWHc4TU12TDhESEFoekNZSFpH?=
 =?utf-8?B?SnV6UHhleFRmR21SanhpSWRGQlpQOHpNUEdOV0NZRExKcmVTbDBHWi9UdjV3?=
 =?utf-8?B?MEZEN2ZEUmxGb2pwbjFnaWVvK0pxUmpJbDArTnAzTllQekF5Qkl3Mi9VWi9L?=
 =?utf-8?B?QXBob01hQ2c5dHJDTzh6MkNUaHFsdXcxampPLzM1YmdQRjVlY1BzbDhrNW5Q?=
 =?utf-8?B?Q2NzNHMxeWVERlh1VkZCVWtuV0JhZzFnY2tGdnNkMERLMkZMMmpGZmtTWXpr?=
 =?utf-8?B?b1djRVM0UkQxS1FSQnhjWkxMWCtYWXNBRzNQSW9rR1hCakY1N052ZlppQllh?=
 =?utf-8?B?TUlxS1djeU5NazNXbUJoZWE0akd6WlhQaHhqcmhLTERudDJZMWVxWU1xSDJ0?=
 =?utf-8?B?OHJiZ2x4aFg1cEZLcUhKdG1UNnhvcDlqckRCVHdBVzFQbGZCUHNFRjR6V2Ny?=
 =?utf-8?B?Vm40dGlQUUFmNXZTVGhWMUliN3dhd1M0VWl6Tm9EU3p4VUdCcUZrZVdseUVh?=
 =?utf-8?B?enJiWFVZeGV0OXdiN09wTUJadXNrZzdmNmZVL2QrbGtYYjluUkJPUEJaN3hD?=
 =?utf-8?B?b3pnN2RVUndycHdHT2h2cmpWTEpObmkxYkxYTEdCNUNKcHFiSGw1MlVXQ0J6?=
 =?utf-8?B?djZWbU12b2t4N0VDUkFzRVprcmFnSWhWSFdiaFplbmNmZWdRY2FYbGtObE15?=
 =?utf-8?B?anNMYnJtS2Q5QjFYVWd4UldtenVIZ245Y2hJOWVBRzBLaGNPRmZLS09RcHJq?=
 =?utf-8?Q?aSZQI6YpQ7+FfeY3suUt4NkHI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnNla0E4RUx6OEIzV2cwL3RHenBmV3ZrUnMxcnRiNDJvV3RQTVJ4Y05ld3FE?=
 =?utf-8?B?V1B3QXpTLzZ1VVcwTVUraFgzNU1Rd3NTQkxjREltcUFCc2FGQWM4K3BpYmpH?=
 =?utf-8?B?VHBrNEJidEJKbTRabHM1TVpMbE9zVThmZi82VWdFNXhheXZIQ0dRLy9ZL1k5?=
 =?utf-8?B?MEFTc001UEduSFp4YTJRMzVGM24rUlRFRTFrUEV2Rit1Z2hJRzhxWVlqMGd4?=
 =?utf-8?B?b2RxMXJTbzg1dFRxMnVYbkJrY1FINVNwZVlQaFlpLzZHSHZlMDBZSCtoS3Mr?=
 =?utf-8?B?T2JDNzBoTzZOMmdzRGtISmg5REl3bEZITUI4eFVEVk1BNitWKzRIMFdwU1NC?=
 =?utf-8?B?dFpvais5U1piTjkzVUUxU0pzMjVMbXpyWjJ0RW9mTk5pdXhORW81K0huVG1C?=
 =?utf-8?B?Tmt0cEU3STE3VjFhTU1KM2NjSm92TkRIN0VEbTJ5Vjd2cVBSUHhiNkNrRVVz?=
 =?utf-8?B?dSt3MkZDTnR3SlBQY1lDeEJpdGcrTnpjbTM0aHphYXhIV2dWdmdaSGplcWc5?=
 =?utf-8?B?SEV1T01DaTBjY0h2eHhCWHNnUk1zZnZUVFhBUndzdWRaWERSWnVhRHBoMTdn?=
 =?utf-8?B?UkJoVGN5M1p1ZkNUcWlldVh0Q1BRaGUraVEwbm0wbm1jYTdSbEI0RTdMUGQz?=
 =?utf-8?B?R1dGZ3dSeHhhd2w3eUxzOE8yVXN6NHB1ckRsTWQwR0N3d2J2M3J0azQ5b1V3?=
 =?utf-8?B?NXU0RS9Wb1d5Z3FjTDVRZkxyWE1Fc0w3RkFiMm50ZTR6emlxd0NKeGkvZWl6?=
 =?utf-8?B?aWh4VkRMelBiaVJrY1oyUEhHNlNta21McmlZeXBBNXVLVktRM1JRZG9EMXZU?=
 =?utf-8?B?Y29lSG5SOGx6bHpoaEV2MmdmM3J1bFg0WnJRR0IyNnNDTE44QnZFUW8zV0VW?=
 =?utf-8?B?ZU1rMmJSbWhkQ082NUwxd1VqYXh1c21KR3BlbVd6K1hnOEY5NHhFWE5VLzNh?=
 =?utf-8?B?MS9jZGZLNUJYK1RlM0hHd0lRdnJJTjF1Y3hWMzBzNTliNHJLS3N3WTdvNHJl?=
 =?utf-8?B?bGhiUXk2OFBJZGN4WEpqbnhnRlZrdURDdmJaUzRSTmJOSkdEYVk3b2wwTExD?=
 =?utf-8?B?Tkl2ejdKTnhtNTRWeTV2TUpSSlJlY3dyY2J0TjVhODBhUDZzRHg0UVorY0lK?=
 =?utf-8?B?aTZyR1ROdDlSeGFOenE0enZvNzdiY2o3ZmIyWGNwZ0VTQURTeDlZbGF0RTI3?=
 =?utf-8?B?eUt5QmJCaVREV2dUeWZrQ0NOckJFWkp1cVJDcG9qYkg4SThFbFYwUUcrQmpP?=
 =?utf-8?B?dHBHTlMrL2R1U21Lbm1hL1V0ZU5EVHk4bFJtRFpLNjV4ZW43Q1Q4MEVqa2JI?=
 =?utf-8?B?dXJEZU5FeVZQVEZwUWdMZnNEZlNrR2pLUUFXb25zaStXNVo3K29yRUtJaHVT?=
 =?utf-8?B?Zi9HemV1RHNCZzMrYVVmRjl0UEwzTUthaGxVZzJPb3JtSHNaVXJ0d3M5bTA3?=
 =?utf-8?B?K1EyQ1dEY1J1Z0tMdkg3MFo2djdSb0tBSm9DQVN1djJDWmFUNnRtcmlJcDh2?=
 =?utf-8?B?ZjFVNnZIWlVnN29FK1plMk9KMHJCa3BaYkZ6MkRzQURGTDVkdzNSRFM0bzd2?=
 =?utf-8?B?T015V2NJaTlxTW5mWERRS1BJQ1I0MkJqWXpWaXhkcGhsai9mZU1hMERJbnRC?=
 =?utf-8?B?ZGlLZVY0RlFjOGlKZ0J1MVBadFMxK3NNejU4Zld2Uk9NdktTMGRDd2tNdEV1?=
 =?utf-8?B?RS9YWjFDK2tpaFNsZUFjVlRJUEJldHE4ZDdtU0Y2RDVHaXBrT3JmbEUzN1p6?=
 =?utf-8?B?THZIVlFxZXkyQWJZQTRldEd1dHZqeHBQME5tdTR0R0dLVzBpZk10bzNWeTY0?=
 =?utf-8?B?SWp0ZDBhOHphbHZaWVNNTHE2bit4UWxtYTcvOFBtczl4ZUFJKzBESE92ZkZO?=
 =?utf-8?Q?YFguAMNURBDfX?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d73483aa-0997-4b05-efb4-08df4d2a5dcc
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 08:34:06.9984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYKPR01MB248038

> +	if (!size)
> +		return;

Ran into the same thing while reviewing Fang's va_map patch [1]. It
still hits on mainline, but this no longer applies after acbf36deb53d,
and unmap returns int now. Mind sending a v2? His fix needs this one
first.

[1] https://lore.kernel.org/all/20261126072414.97199-1-fangxy@xiaopeng.com/

