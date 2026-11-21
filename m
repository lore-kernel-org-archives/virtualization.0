Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795249661;
	b=onj3HQLLEaKNtXR+tLeDOgzU/Gf1vHwoRnPVDL97fqRc69rWNyL1qCFgUOCpU1TlPUId
	 TAjVRN1ugV/buVSPHhvuqptHck+bGIf2JyLWmycqira2SWE1Hm5hoVDtdnqWWQzRjV2yL
	 FyI3IXhXrPx/NG8DTbbH5hYxHbpOBqAGHsz3Z2W6XF61kM4vKXbUWB1sKH8NUC7mKoPh7
	 vQ+LkWTmlWkmTuuSkY1rBBjz1IgosFs1txV6/IesZzYMkvkRtY/LYiAyutmRrKNfvPKHL
	 FTQlp9Jt5qk/MOQpOgsWjo9JgOJY4kYdoV5xhxfoLNwb3n18HwL7VdzW3lM+AzqlrFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795249661;
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
	bh=4uYADKCgxsml7OyEV1OzsaEmce/bIGwvtb9NkIGHbjY=;
	b=4i5uaHXDtSwEGfP3T5sJRjiEI3eldbBZJANXVSBpo+B/xGFY6vxUg29LpwJ8/OFKEnjP
	 opIGmfPI9AJo3OjZjtyrSQkDa1fFkx/vSaRO6h+QfW+M+qqD8kM6sTx7esSuvqdxABZnJ
	 2VTjbP3j4tcC1f3HlxXC5euJSz+SCeTZe6SfsShPxcjI+teIj8+EsgvyVqFN2rW4JT9sn
	 cOyNWedobs4UmkQbZI/Fh2AiSiwdM5iu1OaMsyP7kGtoNrHxFk+8vd1rxLwh4bL0WyHah
	 hU3XDnyeo8mkxAYSKM0b9i9/vDyDIA/3+umx/NWCixVmz4X0LPM1Hx4otas5buXo+sQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=pnCGRDRb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.0
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010000.outbound.protection.outlook.com [52.103.66.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0581B606A335
	for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 08:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0581B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=pnCGRDRb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3fH0HzgZEC2L8JKlwvK4391mr3KxMJ7FvWYOj2drosTDXBDXoA7PPQipugb6yGr21Q/yGWMLSucvbjp6lRm2U8UJywc7ekewevi9KejHNZ7uhL4mk544TaBqyguAD92kvDhhONr3A+eqUj363gId09BQeb0ui7O+ZT8TB4Gyc602K+wA8KaG9Q38jl9YBetLbm8B2LXjy/XPnDSSPGD9VJ/SbBizTN4TULlIUJ1LjoI4sTHv2vgS5dOsPJtW/yLOH6h5n/Y9WzKpBBSgf3fleEdqSDegvOBzhHUrVkY6MGaAM11QEVnvMmhK5sq31HmPEb1faly8oJcy8axDUlqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uYADKCgxsml7OyEV1OzsaEmce/bIGwvtb9NkIGHbjY=;
 b=Z+cFxC0wPiz4sk7GagJMj37QcZcCRMX6kkuS6/U6iQGRPZLHFTGPhQjEgaJo94vRxevNU7CCnCW/vNGTiYe9cFPMEtCHF9Nz23ibie5doaptRezxhV1PAWh8dSXrjH0dTbTsEmhPrF/R8lW9CUJfJ+9l8s1OYZ/tG8pFmDZinXmV2eq3xExcMpqz0Q2BpQTV/TujdH30nD6YWw4uDSeG4k6NQTfpfwqLBGcZLA1m8rqis7cvdW7QfcLiNWejY6aV/pAhFu9Lp0MgCNQvOe1gQmATJ0erxr0dGfArYEVovQlYZTJS0d4nbpVXnsSqOpinGHmBaCGLeqQ+wh0aZh821Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uYADKCgxsml7OyEV1OzsaEmce/bIGwvtb9NkIGHbjY=;
 b=pnCGRDRb50HV5BjUQCm+yx1JDG/Gs2ac5TNcZ7ri0Muvph/gKWY7vzag/f0vcJa/NL6AGuQDFnhLg851IpzCw8LVGk4SswTWnV8I7I0+rHXeVMeztnTKhYwbGv88NVjWa4sMUkuNDc/YW0BUfE9K6t2O1Du/mLmTacWNmgtMJycQxojuZKfjNPOqD3sf6t2E6ut9tQFue6bl4NpLijRVCePdqeHKQbRgRW2/5MUvwMoomlm5h7Eva3HqkRHDHnlq1N912idSGDHjJxCgWhexFOsUfSq2f1xZ+T7r61OqyT6yVN6QGVLNTpbrmjS0slrrDpYbYp/b7kVRqd1hvfFqmA==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by OS7PR01MB11680.jpnprd01.prod.outlook.com (2603:1096:604:247::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sat, 21 Nov
 2026 08:27:35 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0639.012; Sat, 21 Nov 2026
 08:27:35 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: =?us-ascii?Q?Re:_[PATCH_v2_0/3]_virtio=5Fnet:_introduce_an_RX_q?=
	=?us-ascii?Q?ueue_watchdog_for_stuck_detection?=
Message-ID:
 <OS3PR01MB10251CFF97E32B1E7B71D497CE7472@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: "Longjun Tang" <lange_tang@163.com>
Cc: <mst@redhat.com>, <kuba@kernel.org>, 
	<eperezma@redhat.com>, <jasowangio@gmail.com>, 
	<xuanzhuo@linux.alibaba.com>, <virtualization@lists.linux.dev>, 
	<netdev@vger.kernel.org>, <tanglongjun@kylinos.cn>
In-Reply-To: <20261120071826.198604-1-lange_tang@163.com>
References: <20261120071826.198604-1-lange_tang@163.com>
Date: Sat, 21 Nov 2026 08:27:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TPYP295CA0059.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::20) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID:
 <520e7744-fc14-48e6-9db2-a611eaf6c7ef@milk.local>
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
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|OS7PR01MB11680:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a35045-11e0-45b8-023c-08df47a949d4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|22091999003|24121999003|25031999004|15080799012|8022599003|6090799003|23021999003|5072599009|8060799015|19110799012|25010399006|24021099003|55001999006|440099028|3412199025|4302099013|1602099012|10035399007|3071699003|30101999006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGdPTHBuWWNJcHJxN1N2Yy82QmRoSkdOTUxueFIxRzNwSE9CL1JUUXdCUEpT?=
 =?utf-8?B?MDNSRXNrMkZlck5CeGxDWW0wV3FFbkQ3UUt0TWxzb1RQV0Q3SWlrU1VNNUNk?=
 =?utf-8?B?T21IcGpDRE50bEUxRzN4ZGdRYWhHbWpUSTFzWmxuaVR2ZGdOYVRYT3Z2Q2ZK?=
 =?utf-8?B?bzkrWDNhU2hnVFRUMDBSYWVGMHYvaEF2RzFyMUc5VXdRRGVPRDZXRkJ0WGdW?=
 =?utf-8?B?dTNWaExVeE5TL0dCeXk3Q2VoanN0UU9hYkpqK2J3SmNtUGo2MGF1eFViUnNP?=
 =?utf-8?B?WXpqZkZvdkp0YUlXUG5lOGRoc09GckpLclV5TUZjd3FwRkdYUHAyVXg2Z3Z0?=
 =?utf-8?B?YUJEZklZZFJzM2RvcjExMkd4ZGVBekFsbVgyTjVOais0bnZOOTZmLzFOUHNl?=
 =?utf-8?B?cDlRNmdxSXRtOW5lb2YxY3NHSnJJeGVya1J2aDNzbzhSeUhhYmN1Njd5SFBF?=
 =?utf-8?B?K2Q5UVZiaFFhUTNMWDkxbUdyVzMvQ2VxU09wNzc1TmNpandmTjhYNERNU0N3?=
 =?utf-8?B?V1p3MSswWFh3cVRQYUJHT3grcUk0bVJLS1F3ZjFOcmZ2R3RVNFVaZUx6NWd3?=
 =?utf-8?B?MHROMklXKzJ1ZUhnT2xpOXBDajlkWmY2ekpkT1hIZUZISGNKVUFGYW9qN3Bx?=
 =?utf-8?B?bUJBWHNvWEhYRXBCVERmTlQ2SXl6bXY3czBza0cxaWl5VHI2ZHR1bENsbUxI?=
 =?utf-8?B?T3ovWSswbXYyZDZsZ21YeEF5bHJyOHM1UXBTY21wbUhyRGNod0JGSnJ1N0hG?=
 =?utf-8?B?YnVGclBwSFEvR0pDS1BQQlIyR2U5WTJrZWhCT3kxcUd6bS9iYWtuZ09SbEdw?=
 =?utf-8?B?bUk0a21hNlVhQ3laT0E0U0l5MWVsYXgrQ0Z0NWZGZStCQ3pSOE1WREE5UDZT?=
 =?utf-8?B?VE5vUlFRaXdWNEpmTittMXFwSzQ5WG1MRnZGdkhJcTNSNW9HTkJTM3A0R2cz?=
 =?utf-8?B?TXZjNDV4Ky9hdUZHWmNkZEQxT2V3NytaM2Y0bmpoQnVzWnRTVkZTbGVrYTU0?=
 =?utf-8?B?VXNCL0xuVk91RXVFMk1CeGNkUUZWMFFXTzJiTHpuRHMwM2c1ZzVyT2Y0RWEv?=
 =?utf-8?B?MllPTEhZWkJkWTBoV3VYTHJxVklmRkp6UGM0WVF4RGhVWEkyeFVPUkJVQndB?=
 =?utf-8?B?aERrT0x0MkRUL3dpSFl4K3BTM013dis2N1BmcFdhM3o3Z2E2TWJudVNURmNp?=
 =?utf-8?B?cjdUeHE0YVIvVk1KQlFhQkMwa1I1ZlM3U2liK3ozZitrVDhkSUViUEF5UHl6?=
 =?utf-8?B?Zk9vVGFnTFhPMmdxZ1NNRGM5Y0dnYXBrMExxdU15dUpWeStXNlMvNFpyS2ox?=
 =?utf-8?B?anpZUmxaMzkvU01mK2tPak05NURQRUUxL1h6dEt3YkNEL3FZNVUwTGRGd0xW?=
 =?utf-8?B?WjBwRjhEODlXdGdBK1M2azZ4RVJkVzU3VElUb1U4b1dnY045WC9Icy9zWlg5?=
 =?utf-8?B?eFVIa3MxVyswa0R0cGY2R3AzVmhBWWt6M0UyOVhIRHRDZUZ4MnplTHkyRFh4?=
 =?utf-8?B?a3U2T2lCQWMyTmdUU0FGTDlmSGpXOEFiSUJqZ2ZLSFBSa0ZuTDlTMFFNSHpP?=
 =?utf-8?Q?d3gPS8zZ3Z6SKQAKrNi7V/tTU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2dubXdsWmxEdHlxZTFWK0lTZCtTc3ZCYmErdHdwSlpGRytaTllmN1EwYjhW?=
 =?utf-8?B?UUtPVGJTdHdVNllRUWhUeTlvSVFnZWc3TVRQWUlOL0FGTXlGY1J1azhDYVVU?=
 =?utf-8?B?TkRwa2lNT3lKcVRBWXM1cVRDdFdVOG5mT0hSUjhWVWkrcXRqNW9NclkxN0hr?=
 =?utf-8?B?T2Y1RDdXYmlJa0ZFOHpqeVdPTWQzZG41cm4vUFdrZzAxd3VLN2pZcmNNSTZY?=
 =?utf-8?B?U283WGE4aGZsRFE4Qk5vRHRYMW5XWnlTWTRucjd2L04zbkZTYThhSStwZUFY?=
 =?utf-8?B?RVYwSC9INVhFb1JwSld3SVphejYxL1VOTDRBODFmNHFVM2lOWG8xbWl6TzNS?=
 =?utf-8?B?d0hveW5haUVDNVNlWituM0RxRFlCVGhZM3EyMmt4NFI2NjlqdmJWN3VmT3c4?=
 =?utf-8?B?V2YvZGRjSDVjN0diWXpUYjFGUmlUVDYwZzZabkRCR0orRUlUekYrRnFYYXNW?=
 =?utf-8?B?M2RJTDhYRUk2enFiZ1h2ZlF1RUFwT0s4MHhnNGdhQUZEbUVxbktjaVViaklN?=
 =?utf-8?B?eTRJQ25Bb2JBZFlBVGVtL1NBQ2NNbVRMZDNFellGb2E0TkZVbm1rcGlRbzBD?=
 =?utf-8?B?QnlCWVFjUzhoeStFajBXV3l4dlViZnN4K2lNUGFCS1R1dXNGTHd3OTNVbmpE?=
 =?utf-8?B?RFFvSmJueUtXZksxenBmcGtDckFueFFzYWt0K3VHR2pGTjh2Q1dZRXJuV0po?=
 =?utf-8?B?UlVVdVlCMStzRVZKWEthU0tackM5ZnJ1a1FEaGRDanhBTzFIeXlsWk0xY3E5?=
 =?utf-8?B?WDlmOTdaWmNPdnBtVy9zcVIzV1V4WFhhU1o5OUZCZEhTbDlmY3R5Sk5rNXV0?=
 =?utf-8?B?RnJVNWhmaVRqNEpqeElKU0NNVFB0Rk9ZTHlJNVd0MVBKVTUxdDZMN1JJNVVh?=
 =?utf-8?B?Q1NsMTRRT2VtYXRZekNOL0I4VVJ0c1Rpd01tZUtIQ21rNndOZk00UWtFTVd2?=
 =?utf-8?B?Y0ZtUzhGdlRjMWpTbk9TQklBQkp5RTkyQVpWaVJreSt5WDNwUkYyS0JIRUJm?=
 =?utf-8?B?aXBGY2FxM0ZhTkVQVUM1UWxIT000NGp4YS9OS0JMN1JuemNkVlZoUHlFZDNr?=
 =?utf-8?B?SmRGUW5tYUJyY3AxTE9WMWthN1F5WkZSRURONE9MTlpCSEpqb2taUmFWSWpp?=
 =?utf-8?B?cW14L1JzZmQ0ajJ6eHRSM1BoVEdRRzJVaDl5YWlFZ0VQUVFnTktDekpUbGF4?=
 =?utf-8?B?VmFVaWpKcXFXbWRud0h3eG0rRmh0R2R2KzlEWmtuTFhITW8ydXZvbWJCZUhN?=
 =?utf-8?B?QkRraWJPT09EcllLd2Ftb1NZcjVLMDY3cVdQeUtpMDdCcXlWOVFaMExsY0hn?=
 =?utf-8?B?RDV1cnREb0VVb3c1UlExMlRMMHFJRU93T0lEdmRCaTlUbzVqTjVYcVFObU1m?=
 =?utf-8?B?b2dORU9USHpzUzZFR1UxMHY2SlRZTUgrZkxoQy9wc2VYMVVLS0ZsSnc4dW8x?=
 =?utf-8?B?cGJYczJWM1diSG5jRGRoR2xNeTVMWGFqL2xpMi9hRTU1Y0ZReEE3OXlzeTNm?=
 =?utf-8?B?N2MrTGhFTlJLbEI3ZWM0aUsyOUJTMC9CUnQ1QmpJUTkwdDFETncxV0ROT1Js?=
 =?utf-8?B?TzRCTDd5TWRnNUhFdHQ1bnBJQzFadUlZMUVPUmdzTDVNNlZId041N0ExY05a?=
 =?utf-8?B?Mm5WWnI5bWFqNWFqOXgyWTFCWmovU1RhMzBMaUtxeXBIYlpPVGpqWi9kSUo0?=
 =?utf-8?B?V1JFbmlNcktiWjVOUlVFUGxxTFNCTjhZSU1XdU1wSWJJMUxXVDZtWFRTcVNn?=
 =?utf-8?B?Mk5XdFhqeGtjZzBJMFRMK3BuZEZMU0tmSVFCcXQ4cE5CMEFZRkxrOXZ0dW1a?=
 =?utf-8?B?MTFtNEFqTTlEZVE3UnhFTXJZLytMelVKUmFJeHJsR3hUajJQRVl0TDFINWRP?=
 =?utf-8?Q?oJih01rh722mP?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a35045-11e0-45b8-023c-08df47a949d4
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 08:27:35.2714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11680

Hi Longjun,

I don't think this reasoning holds. You saw an RX stall, but that
doesn't mean it was caused by a lost interrupt. Masking the interrupt
injection only creates the same symptom, it doesn't reproduce what
happened in production.

Michael posted a patch for a similar RX stall recently:
https://lore.kernel.org/netdev/ad74886a8429a862c00d1e42f1dc746f2924b75f.179=
5108341.git.mst@redhat.com/

So did your guest have IRQ deferral enabled (napi_defer_hard_irqs and
gro_flush_timeout)? If so, you may have hit the race Michael fixed. It
stalls the queue the same way without losing any interrupt.

