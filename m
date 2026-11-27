Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795798298;
	b=McPSgZzD3EUI7MJp8gpU2z0LRskruFtfLMFFxTBbBpbgCUB30MBpdssFHey24ZC7MLrH
	 hKZDTKkMyDqiDH8bc0SdtCncGuhk9MEkbh7vEBQTKU2Jyw43ttBSzgEEO9hH4M4kYoSRh
	 KqfHM0u57h4DT2NTTXZTpxuUV5nYrt7LdVZsN2BYEQcFIQPF1xLteAmKdDxwEGw5FOGA9
	 eX9ShDLabzHEeYuljQkzAk8Cr8CltAtaLQ9kDtgTTo06vnX65WAA0rHMvfPJfAunYYV6P
	 bBXDc4670HVk3xzCrLnLU5jkPM0BAmI/Wq55ILQwSpkHrueQb5EcyrlNYvXmbSewg8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798298;
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
	bh=rB8H5xBowEk0RxDtI+Ibauba2o7JecZUa9JZtNZ7JWg=;
	b=vM2OTigmBPUK1Hf4cWnRz1KquR6n6I0kL9TFX/Jue8Z+36pVsUcK5TUxuHEOPosa1E45
	 BYd5Wc0i+2Q+FoDrJjR2rAfME12eO58jI4mxbXgTp+miWVHz14p9NVD6RPkb5rkHdnMtL
	 UeNLAh1GkBN7OKpXW5WVPUiUwFl4ETWCLDcrGmc1di4DILZFbFxuZerKmKyW+5x3ZDlDL
	 2EF5Swn5vI3zTPdai7HLUM2Evb4TyoxAx0Hf7NJ1q5dydRsXpWKIoY93fznBWm6l06BWs
	 0DqZd/ZgixMTqjzwxMlmt5XA0yuVuTBIsPBxCHWHDM8C/1UgoCYoWRZGij6bDV5RAPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=ku7doYYW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.35
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011035.outbound.protection.outlook.com [52.103.43.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5AE606A33D
	for <virtualization@lists.linux.dev>; Fri, 27 Nov 2026 16:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA5AE606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=ku7doYYW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2YwJcC7KkrejjK8/EMXZjHOz/cLi///6TsLGXKzD8FBrSOEuIO6MvH5UHQjjGm7BHRLT/iUvH0uuKmJB5HHiT6LcW2e3J7G6e3MWLo/67uC8Nc8vkPnXuLx/Ck1648CUEZPP88wLAhRWfeKimtGZy8tVJqcxxbQMHYNaP4p7b80F7bltTHbFUvNQ+j7o5b5RqAz2aT+mqzqyB6ZiAMVEkGN6jyxgsPTGFfYD3A8cQuCESgJyMaCllzMdn6UVf0O8uEPEC0HdMtirp/B8Y2d+XXYPy+lReBJx3xafoGp7kjoTiieot3FWW4QdzO61h05B2Am9qgQmyAIRVNfeAayoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rB8H5xBowEk0RxDtI+Ibauba2o7JecZUa9JZtNZ7JWg=;
 b=N6wvnoAhdVDecQj1wGjb3lA7V/6KsWE6wE/Uc6+cWyscl2eUubVApCbYSamkAZ418E/wHfDMfY9vHVQfboriSLvY+egkFnD5xBmIYX/GcHp7PmQGEBAPEUyK+amrIuDICIfM2xnSKcWrUkJa28D8dY7z4GCKIPUOYCoq/pAncmPoJzWCSo1A/8jNsamm2LpBJJoKTWxmUBDOdE+kImMkIsLpS6MQsRBpWaFUUpkofg39c3LztcwFsn1eFlm7uQ9/CeGiwUJZYOuZ09O9qn8leJGyKWBXou4MtV7ngMLo2JyNtyVQ+tCv93tNJ3aVZ8O+l37rWw9x/DjzvfHJ89/ReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rB8H5xBowEk0RxDtI+Ibauba2o7JecZUa9JZtNZ7JWg=;
 b=ku7doYYWeDyP3I3MSf6MajpkVNSxNt359TSeA5zH0k9cAj3l1ishocJl+RtLSHUVn64dhTSZDJ1BFPC8AOlWceXGG07mglBPPs3YLsZiC9gU8J+aQI/8Ly9bJMWpvmyerjowTQO2r+lhhRxbJMhuwlXfmW5vq3tZaaPOKFA7ZOqpeVf2itLnGC7xhfil8yEZg88nbdw6yWhgeGZdJvC6snQjOOezVIw9ztKb1riF2u6dTnB1JztIZgycOmBtvd7Oeh24exi7kyHDwVdV2zi8K1VXvWIZBkuNAhfXmUWpCs8+bCi8BL9iAVFZqcMJtRI2teStmBNQ5tG1uulVKILuww==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TYCPR01MB10197.jpnprd01.prod.outlook.com (2603:1096:400:1ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 16:51:33 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 16:51:33 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: Re: [PATCH] vhost: mask the in-order used-ring log cursor
Message-ID:
 <OS3PR01MB10251C57E853D892F935CB854E7412@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: <fadouse@pm.me>, "Eugenio Perez Martin" <eperezma@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"Jason Wang" <jasowangio@gmail.com>, <virtualization@lists.linux.dev>, 
	<kvm@vger.kernel.org>
In-Reply-To: <uD642sRa0jdIPD2nCoKzjJDfS2fpCefT340JqjRvOUyFkoXpwNAAabmjwSltui9-PD1DNwFJrw0xrsZqbYKJ5x3fraz9Wv46l3OrkBVA3vc=@pm.me>
References: <uD642sRa0jdIPD2nCoKzjJDfS2fpCefT340JqjRvOUyFkoXpwNAAabmjwSltui9-PD1DNwFJrw0xrsZqbYKJ5x3fraz9Wv46l3OrkBVA3vc=@pm.me>
Date: Fri, 27 Nov 2026 16:51:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0043.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::11) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID:
 <40bfb8d5-9d2a-4ef0-b5a7-14a2342abf4a@milk.local>
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
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|TYCPR01MB10197:EE_
X-MS-Office365-Filtering-Correlation-Id: 741b5ed7-7f73-4ca4-2036-08df4ca6b0f7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|22091999003|25031999004|6090799003|24121999003|15080799012|23021999003|5072599009|51005399006|24021099003|55001999006|8060799015|19110799012|25010399006|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YU9tV0JvZXNWNHpkZkdhdFdvcGR6U3hQUmRXUEdoOGxzQitVd1hkMklSL21q?=
 =?utf-8?B?OEljeWlFQi9ndlJZUUlBWTBIS2pJOTJLVmg0UjNlNmZQUEc1NUdDYnMxa3N3?=
 =?utf-8?B?MnIvM04vQmE5cnIzZzczSCtoeGd5MzRLRm9ac0hGWjJ6WmlkdE9DTmJqS3Ex?=
 =?utf-8?B?Vzd3Z1RMQjVDTmg4RGV6MUMybzNoWWNMN3A0UlNUdHQwQWNUaWdYTXpSTVRv?=
 =?utf-8?B?VkM0N2xTU3lhTSswbnY5ZXNZRnptR1lFbUpSRjdwb0tjNnZFbWZBa0FGZFQ1?=
 =?utf-8?B?aWxWNFVjcjVhVC9MY29aRWdvb0dmREt4V0c2OXl2b0gvVDU0dUxaN0FGZk9w?=
 =?utf-8?B?c0pJUnhJSFFBdGV6d3BIWEx5Y1M4VmtZVjdlcEp3R0xFK3N2LytCOXJSR0ZD?=
 =?utf-8?B?bVJjM0hxYm44SCtlTStHUk1KSE5NK2hvOGViSE9ZajdqUHVtdkdaRmwvQTIx?=
 =?utf-8?B?YTB6dGQwU0cxbkNUR2RCR1NQWEZMR3BiSHJ2eW0xblYzR0lGMXNGdzhrMjdE?=
 =?utf-8?B?ZnVnMG1ZUHFmNDNxRDgyMFdrUFlwMkhzVUpXcENvWXJVSmQ2U0h4TVpqOHdB?=
 =?utf-8?B?N3hXSjJVWmhRSTNMMWFZZVd1NzFvWndBeEo5SDhoUWc0SlQvc2FseWFaM0RN?=
 =?utf-8?B?UjI4bjl4bUx0VTMxdTRRZy9taGtOdkRYbC9lUDd6dDhkeHBhN05sZ0VqazZK?=
 =?utf-8?B?bnJZRjdkN2VONUpsY2hPbFBWRmMzWlM1WHRqV0dkQmV6bDZXZUJRWWswalI1?=
 =?utf-8?B?Z2pPbkdxajFhVVJvbDJKcHUrZ3R2d1hITWhBbE4vdGtsT0ZmNzNycEJIM0sz?=
 =?utf-8?B?eUZBYXV5YkhJd08zMDVZcXR3NzZDTGdKYndWK1dVQmI0cDdWNVlpTWRTbzNQ?=
 =?utf-8?B?OUpJVWZybE9TdTRYZlpnUnVacndTendjc0pCYnhHTEpJVWYvRGlkUFNCSmpT?=
 =?utf-8?B?S2pqUDNBUnRRZzZnNVJ3RVJiRC8wdDFkUHNmVnRrQlBGL0tLdkJPOG5WYkIw?=
 =?utf-8?B?MVpZQWZKVTkyZ2p2NW9EaFlGVTdzdGozSS82eVRyZXZQSFdoNWI5dDVLMzVh?=
 =?utf-8?B?UlMxNGxpVkNNb081Q1FuVjllM2lKcDhvWnRNZlNnWlB4YUl5ZE1CNERxY3hX?=
 =?utf-8?B?dzU2ckN5aVVveERSTlVadEk1U1lvdDZqdHg3eGFBcEJoU0x6a1RoV3hkakNP?=
 =?utf-8?B?cHFlQnpZYzluVUxUY0R5VEYvQS9HVnFGM1J3NlNlZk1HcDRIYXAxSHZ2L0tF?=
 =?utf-8?B?LzhCaHpXTnpyelk5TWt4aFl6bExOMUpXZWJrRmI3WWFXeTJNQjZ4Y011UmN4?=
 =?utf-8?B?QkNUYkJFMjRxbkJJek5FTW9hMGl5MTM3ajVReExlRis1cTZPY1dkRE9KdStI?=
 =?utf-8?B?TUhDNXFJSXoxdlhBaVVqd1BMUVdIRGcrdVpEb2Z5QWM0cHlxbkpxMHVVWUxR?=
 =?utf-8?B?REJjbW03UjJvTU1PSnVWOFZRM0kyQWVMMGdoYm1lSE9iaFBCMUF6djlabjJ2?=
 =?utf-8?Q?UpFg+k=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ky8zbk9SN1FlREpNaGIyLzl2Rkl1R25BMDE1LzRUeE5Dd0l1K1l1ZUV5bmo5?=
 =?utf-8?B?aXhQK2ZOeXV1NTJaVWFaOUdwMTZtN2JncjNSaVZoeU9XVlYwbmdsK3draFhJ?=
 =?utf-8?B?ZVpLMTVDNjVIbG1pZzY1UndNMVdVRFBuajNFRVlzYnViVURzcWlMbGc1ekdZ?=
 =?utf-8?B?ZTdBRXNkMit6WGNDQy9tQkdvWWVtQjQvV3VWVTd3Mk1lekRmNHNZZm9IcTVO?=
 =?utf-8?B?Q0dIa2tqUTl6SW1oVFlPdlVtRTNLL0thUlRRd0ovK3UvWGJnS1FGT1ZvVFpG?=
 =?utf-8?B?V1o4ejZPZXl2bklmVmwzWTlqUjRLVzIwVndQOFQzOXlpNFdrckk1VmZvWVl3?=
 =?utf-8?B?b3RoelZaM2FSaFQ4TStRb3QxaVhjQTJadWxEZ2ZQeTUvUGVMWVR1ZWt6aXZQ?=
 =?utf-8?B?WENlZDQ0dmZxK2w0azZuRkNjWUIzenNYQjg5ZkRjZmRNRzA4U3NoNTk4UDlN?=
 =?utf-8?B?emgxeHZxSFVsZy82bFNhWVN3dFZZbkhxMnFMdFhQNU1MdW1EaUtvaVNvZDJ3?=
 =?utf-8?B?WDZBRjlmTU5oeFB4aHR4eTVmQkNIbEdSaml1TFY4S3M4TUFuQmRPc2dwdzh6?=
 =?utf-8?B?MGNINnY0QlptSzUvQWNNOE10ZHpSSC8wUkx0REtrOTlSNlVYd3dCNkF6RkVv?=
 =?utf-8?B?eW9temxTUEw1UUtLS1FtMFhTNU4vZmZpR092aUF4RlhUNjFDN3RJYmw0OHIy?=
 =?utf-8?B?MjJTajgycE5EVVFVQVdpREdRN2k1OXFTVTcwRDRKdC94MXZ5ZHBPWmFZT1Nv?=
 =?utf-8?B?ZzJoTFJ0TGZIeWYwQUJWUzZPRHNEL2V1ZVA0VzZPQ3M1Q2VqWnloQksxVHlj?=
 =?utf-8?B?Z25KQkJFdHBzcEJjdDZ2WkFzT0k0MWFCcEpUL1JTU2xJSkxtUjJFejlLdEVn?=
 =?utf-8?B?bUkySjh0RUhZVTBQclVsWERoM2VZZjcvZko4Yy9yYVNIYXg3OC9PdHhyV0ps?=
 =?utf-8?B?cG1Dc08yK0l0eEhhYy9IZmd2NDFMUkVrUnR0VVpkVGJRMk82NjBvL2FIT2Jx?=
 =?utf-8?B?U3pNRXMyZXlMVVhnQ0MvYXd1T0tYU1RFMGV5ekM0V0dLM1M3U0FIUUltcFI3?=
 =?utf-8?B?NXZ1elRPYXdYVHM5ZGpPNXlGMlVKR25pS0pQVjlvMEdpVDJXbllMSk5mZytO?=
 =?utf-8?B?QXhwSXRJODNBQWRaWGlVRk10STF4bW1HSHZSVjE4SnZSS1E0N0VXUGVMRlFq?=
 =?utf-8?B?d2V1akFzU1RYc1l2aVBldzdWSjdlRHBwSVZkUVNZbEwzWEoweStlTHNBdWJn?=
 =?utf-8?B?Q3ZsQTFrTW15aCtmM2p0Q2dIV3FGcDMyaGdpWUZML2FEd2xzcXR1YzdBcFBm?=
 =?utf-8?B?OXNqNFkxM1puVUs2aVhyTXExRWhHOUZnUnNvK3gwNk9JTys1N0IydHY3TnM1?=
 =?utf-8?B?eWJLWjVyWUxhMGJmRkhLMTMrb1pmTUtmeDFqNFVlWS91TnFuL3E4K1grMWZy?=
 =?utf-8?B?Ylo4dmJvaWZPSXF0UFptc1k0c2FXU2o0S1Y0bzhXV1hGdUdvTHVnbGVpU2dp?=
 =?utf-8?B?S3VBMWRpVTl6Yk9zQm4rMlJqRGdRUzB2UVNzUlVTdUVxVnUyak5vTjB1TmZr?=
 =?utf-8?B?eUk5Z2loVnBmY3h5MzNxMkxSS0JORXU1NnhKVmlMYXVWdHY1dWNzUndxRFJm?=
 =?utf-8?B?SE1Xdm81RjB3Z2FLQitXSjZFR00vMmVUVFgxSFJvTHVnVHA3ZVBzdTZJYkh2?=
 =?utf-8?B?aDBmTGNlR25ObVpYdENWaW9RVHlzS3BYZWExNlV4bUtubVJvUnQ4aTd0bzFC?=
 =?utf-8?B?TWIwSEhVK2JTNW5qdDluaHRwYjY2MTJCeUg0Mmw4T0l2UXlQUlI5ZmFLdDdh?=
 =?utf-8?B?a2J6V2ZyQ1FWWStoNEhuUHFsM0g2Wm1pTkZxRDNmZmE4eFN5Y1NwTWxDUmlq?=
 =?utf-8?Q?ty5HjYwSXOmfN?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 741b5ed7-7f73-4ca4-2036-08df4ca6b0f7
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 16:51:33.0694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10197

> Bounding get_rx_bufs() (e.g. capping its quota against vq->num, or
> checking in-flight descriptors more broadly) is certainly worth
> looking at separately, while keeping the mask in
> vhost_add_used_n_in_order() keeps the dirty-logging cursor consistent
> with the publishing loop from commit e244725e86be.

Hmm, I'd actually go the other way round. Isn't the cap the real fix
here? The mask feels more like hardening to me.

Though the cap changes things for a packet that can't fit even a full
ring. If I read it right, today get_rx_bufs() runs out of descriptors,
rewinds and waits for a refill that never comes, since the guest has
nothing left to post, so the queue just sits there. With the cap it
hits the quota instead and the packet goes down the overrun path and
gets dropped. Probably better, but it's a behavior change, so it'd
need some care not to regress anything... a bit tricky I guess.

