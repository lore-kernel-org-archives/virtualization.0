Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795851309;
	b=AZe3Jwzn+42Mcg1v/2bGv3EW2nCYlGxlD6NXhb/gyFFFo2bpF4DAE9qgnTzZm3q8eYh8
	 43R/c941wnnXtLBxNgUSGVdoC1lOXtg9SmY01gFjRGZfRDi5OCXsSeCDjU851sV0gqUE+
	 kBRDQ+w1dd+tg1U7mpQfWtOIbJi8X38P5tJWnrhTqfEgbeunsE753Z5G7Ow6RnKcUE1mf
	 CjfF9duJ2/SQzJo50/H0XsePpgcZ+HU3lEI1x8KyIHN1Dsmf+EnHeSfFEAjsyOZHCTDDd
	 RGlzUQ2LKa4UGwbYEoptAutFVemLZof/0AwUCXruxb8atNk+Bbsxn5kvPOi4pGoSBZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795851309;
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
	bh=F9LMUabO44mGE5IdLhtvu3+A/A+W36Wx1NrXXGFDxSs=;
	b=V2F+9c29RKcXUM41NvOaIE99M/3bfPKg9dUP7L/Det5hkv6a7ByEHRUelZVsz4wU02V5
	 SqcuMDoBRUdKbAq38ys3FDw2pnjbZrezs+rZR16g/F0LUfck0cm4I8SrT4mw+vhVhW0HK
	 qyrvCKSRmRtFoMY2DzkgbAuj4DR0QhDzltr1Ml0VQLJ3VlFEaQAVz7YyNpE5hmwTfm0mn
	 +fTVHnwuoI9xnzuCRlYhDKrM4nnNO6JySP2/UOorZmRSc2I5ufneqn1poEiSzr/SwbVXM
	 OalyRkCrnKIZYuYCu4Svxw2GU2dGd0Zt3A3HpDfrEeiCMBnTNtX3l76WDHAWqjN1UYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=jnCIup8A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.14
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011014.outbound.protection.outlook.com [52.103.66.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DAD606A31C
	for <virtualization@lists.linux.dev>; Sat, 28 Nov 2026 07:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66DAD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=jnCIup8A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSr9m5jH7g5nyGfiRzd0GssnKbEjwLPdtN6PY6ifoOhEsOohkeR83KxfMsYwQ/NTuIR5GEzJ3r/+u11PnegiNK4aZqPuTdeJykAT9h0iR0kQrQqtoG/r6c4V0Be+KtX2NLZBXgGUvJEZOHdQloFQjdhca8C4eImwnnGcM/58kweNUJ1OhHJWzZ7hLhokWLrRJEyAhGlWwooQ+HfNbJ67l5rxV2NAz2SCh/he6woF6jBMYmQG/edxqbCAezUX0rg5O0A2dCte2/2LCTmb19mCOU4KBmpu0v4+zvzAV1CWpn2ivaR4dMwHFdnDZAhnDKyptVKPACdErNtN+zwj7wENxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9LMUabO44mGE5IdLhtvu3+A/A+W36Wx1NrXXGFDxSs=;
 b=qrYc2avrSIkDYBNIEpQKPDU4OqkW5vKC+zIN1JHpAdQh69CHLUOSA6Bvnsef0RvD4x8/r6ZWE+rL/PXGDwa1UhODasFBYvJsX2nIbrhFvr5glZS0d1E4rJgH5z/DcfFlc87CXuFdXEfzaGz8aqhRgRbAusbOi2P1ghSaRls3WeXCJsY4kesidirApPsndzyMoK80mtv5j/OYp8eFRDQhQLEzccG96nsIr4R5r/0LYN4K2SFluIIpPnA5QGoH62oO6xp7GRzLGbLMh+eISLv9HEPJjn1GnZTTgRhaOjIdClvQoDnm0b1b/ExN5TNLcT/RRBtE4FEpO9Uh349GDvndcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9LMUabO44mGE5IdLhtvu3+A/A+W36Wx1NrXXGFDxSs=;
 b=jnCIup8A3QxwANAJzI6e7GCvoSuYd9aaNSRjxnSVkcJArTTEUAh2a7/7rc1kBTmjl92N9Bi4U47Hf9sAbZbU9ac6NEa3cO96pIDS50PcHYHL+TKJuWalE5nvYyoXIAcWqpTsS3uEdNaCI1uDjXtgdSOqm06RFzekz9dk3WJV4Xn3+yHpqqrDldJkGaF0e4nGKSnAzZ3Tr7/pEfvLZVqhstZ69KEODYkaBvsaKtDLleyPjXmgYZSLIjfcy2SpeniFrkra3uoGp2BnVBPn6UHZtyvfx0ST6LnQVuhY4UTcyqSWHiBDFZN26TdyO4ragt7hPnhVcMK+rr2uKfu1ouYd6w==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TYYPR01MB15574.jpnprd01.prod.outlook.com (2603:1096:405:292::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Sat, 28 Nov
 2026 07:35:04 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 07:35:04 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: Re: [PATCH v2] vhost-vdpa: skip unmapped gap in vhost_vdpa_va_map()
Message-ID:
 <OS3PR01MB1025193804F50BB7C576C9989E7402@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: "Fang Xieyan" <fangxy@xiaopeng.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"Jason Wang" <jasowangio@gmail.com>, 
	"=?utf-8?Q?Eugenio_P=C3=A9rez?=" <eperezma@redhat.com>, 
	"Xie Yongji" <xieyongji@bytedance.com>, <virtualization@lists.linux.dev>
In-Reply-To: <20261126072414.97199-1-fangxy@xiaopeng.com>
References: <20261126072414.97199-1-fangxy@xiaopeng.com>
Date: Sat, 28 Nov 2026 07:34:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0003.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::14) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID:
 <78da90a2-5720-43fa-a0cc-6579d9e01b35@milk.local>
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
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|TYYPR01MB15574:EE_
X-MS-Office365-Filtering-Correlation-Id: aba1a868-b90e-44d5-63af-08df4d221df6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|24121999003|19110799012|15080799012|41001999006|6090799003|23021999003|22091999003|25031999004|8060799015|8022599003|24021099003|55001999006|25010399006|3412199025|440099028|3071699003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEY2MEo1VWc3NzZKT1FVK0dCR3JmYjNzdDNGT2tTWnRXcklEVWMvR0NQTjA4?=
 =?utf-8?B?d2FNMWN6bUhGZXNBY05UaVZXMXFzM1FyVU5ueFJoNnN0YWRzb0R5Y2lxaVU1?=
 =?utf-8?B?RkRRSk1UdVNzdW1UTmVtOGdBR21lVlEveDFudi9VbEc2dVNPejR1dlM4bG1r?=
 =?utf-8?B?TFRLTTZENXNHNDhlaE8vSHhON1I3Zy8ycnUzTW1iWEhTM2tXWHBDSE01MWlq?=
 =?utf-8?B?bkVRcWFuUVdxQythSkFHdldLdXNLcmt4QytzNzV0TitlUVdCa3h4YnorL2ds?=
 =?utf-8?B?akd6bEpiKzhjMnowSm5Wa2ZQZFF6T1dXejU1Uit4SmpzOVRLcTFVLy9PdVBn?=
 =?utf-8?B?RUd4dHRXS0pBdjR0UWpEdXY3aWRVSUZDUURoM0d5UU94SjQzTEJ4b1VVZWVw?=
 =?utf-8?B?UXRuOGRHMWRxejhKbDVMc2VDVGl2V250Nm1DdWpHb1ZVYU5KQ25lRS9QT1ZO?=
 =?utf-8?B?eml2bEV4U0VNTVBPZHc2czdXbkZEam9SL3RERFpHMjJ4M1lIMzNpR1hjdytt?=
 =?utf-8?B?SEhJM1lLaGdGaUNNSjFrOE93WDR4UmRGYzF2QnJKWWtwTEFOcGhKTkY2S2Yw?=
 =?utf-8?B?cW9qOW43bVZHaUJUUTdXaGpQTS9nRjhIbFFxWmZPRU9PZDZzL2VPOTBBVkxH?=
 =?utf-8?B?Q2ZrTDZoVk12QlE5UForY1RsWWVWSHN5aE04aTVINmFwNzlGUEU0TndHZ2wv?=
 =?utf-8?B?Y3JURUZxTUFaWVNiRkt3cVRUazI4WVAzay8zMy9pSFU4Qlc1Vy9NaC8rS0po?=
 =?utf-8?B?dm1BK0svVVZvUFgxcVRwVUdwUWFQelpxZDR6RjFjY21RZE5TdEdEMmh0S1RB?=
 =?utf-8?B?WEFOaVRMU2xsb244anh3L3ZHZ204YXpWd2IzbytvMU9VUDBYTjdnbDdMRHdQ?=
 =?utf-8?B?MjQvb0FFYTZ5NUVVTC83SEoxQTRtL3pzUWM2Zm9rc3ZsNkZ5VkN4MWdVcnlz?=
 =?utf-8?B?MFp0TTNJcU9XWWpJMjUySmdyNVpGajJxY01salZQTmcvZjRWN2hOUFhvemhm?=
 =?utf-8?B?VjFpNWxUNXcyZVZVb2RMeVA1enZmS01yN0JjQ2l6MXY4TDBDUkRXRFdlelZT?=
 =?utf-8?B?UUdkQVRQMXNSZmlLTFlJRGRRWTFTMlZtRXgxdm05MEhvNHZoR0VTdEtQejN2?=
 =?utf-8?B?dWRaQVZHZzkvL3dXOVRseFJwK1poRlEweVNqaHdJcGh1Vll1a3pZOHZ0NVhk?=
 =?utf-8?B?QnZWc3lOWEg2c0tlVHBzZXJwZnB6bXlueHNqMXZOcjdKT05qY2lRSEY2UEpQ?=
 =?utf-8?B?cTIzQmMzeHk1WmNrMWY5bkJxQy9NWkhGT2RiVU1kRlJPcGNWYmprRFlreVhk?=
 =?utf-8?B?aVhBYVdZUjBkaWNWNzR5T2FjQnB3MDJkRXhrS0dEcnhQc01uajRiemxjaHov?=
 =?utf-8?B?TWY3TitTTy81MVVTN2p2dmo3eGo2a1J4NGhnenRKQnBYNE5pV290cWdBRzhQ?=
 =?utf-8?B?TWhmbHcxWUszVGxyZHhiRkMvNHVueFgrZDIvek9zeVlub1IxSEJkM2o5bXh0?=
 =?utf-8?Q?wuoJRu4/GTtV/6t+GvvXz73qGpd?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWt2WmE1YnlRZmZjVXVXS0RNSEt1SWV4Z3dwdFFld3JRdTA0NFgwUkxrVDhK?=
 =?utf-8?B?QXN1cWJENUFvL2toSDQ4VU9kbUdGbzFKMUc0SHVUbk13VFZVTXNmamRFWXBa?=
 =?utf-8?B?MC9idVNqQ3l1d3laQVNmOWg4T3NvNndOaVVxU3ZrQXFyNjhlRzR5NzQvLzE4?=
 =?utf-8?B?bVVYbWYyL3NaTHJ0dVpKMDJPd0d0WUJXQ1RsSzd4b2I4aVovWDZBZzRLeHBW?=
 =?utf-8?B?ZXdWeHJhLzNOSUg0NEF3SHh2dXhOTUc2RDZzT2p4Tnp6Y0w1NzVjUkFNNUNK?=
 =?utf-8?B?dVcySXYyYzFQYmFGVnYrWEZjOGhER2xqcjZXb2Y3MGtDWk90Uk1MbllkOS85?=
 =?utf-8?B?ZWduWllXcU9QUlR4eEFyejRVZ1BTR3NpSm9lR2QzakhNNHU4MWdUS21GM05H?=
 =?utf-8?B?RktHeWI4VzVkWUNiY2RwSmRYcDladVozbVQrS3Z4L2tJZEJxVWdyWno5SUV5?=
 =?utf-8?B?TVRTQXdwNWtZQzQyaUtkckpCcy82UkFCdTBFVENOSFhLcnNTUndvY2EyVld5?=
 =?utf-8?B?ZlFDV2ZPUXZyckk0RWhmZkI5MGdBZWJiWjU1R2kwc2lZM1h2Vnk0MFJZTVow?=
 =?utf-8?B?RWJNaVRTS0VlTlc1MmdSYzRoNkFjUnh1VHVpWXJ4YUJ2Vk04ZjRONjh4UU4z?=
 =?utf-8?B?ZzdtQ0tHZ25mU21IbE45dWdORFpQUExjN2lQMjlUVTY4b3QrbzNCK1lmZ1Nw?=
 =?utf-8?B?YTYwMXJkV3JxM3lXdER1WTlxRjQweWFoK3VnV01mWnBqcGFiQi83QWlHSyt0?=
 =?utf-8?B?ZTVvWjJoUDlJSUNXSU5STm92VDVPSGxDdnRqQmM0SDg1NVdDYXR5OTRETFlF?=
 =?utf-8?B?dEpCTHJENk4xVTRlL2V3TVJFZVFzSkNHUlduUXZ5V2tva3VxTnRFeXl3N09v?=
 =?utf-8?B?YW9GcDhBMkFCZWJvUWVaSS9xY1lpQ1l5c1h0bmxiKzl1OVNyYWhQS0Q5YVJ2?=
 =?utf-8?B?aTREQmJwdXBybU0yY0NJVlIwMXdESWlJZjYwaUh1cEF6cTNxWTZxeWI1bFli?=
 =?utf-8?B?dTZLL3BkaURMSEc1OTAzancwSjdmcnB6RnczVC9walE4VktLMVM2aVRlVDJw?=
 =?utf-8?B?Z2prbDdPT2hRVVN4bGJDakhwMUxmN1drTjIxZ2dhczkzSlVRN0dZak51VVJm?=
 =?utf-8?B?YkJLRDdwRitSaUJJUHY3d2lJaVppdkFGU3VIVldTdm9IbHgvMEVHZUN2YUFr?=
 =?utf-8?B?elhKVTg4b3cwV1loWXI0Tk1XWFNxd1YrOVlrOFpSMXFwYWNTNFJDMml0cktO?=
 =?utf-8?B?YVJucEJROU11WkphaXBkcWtPdUF5VHdKcCtZWXlPL3FtLzJTbklIMXN0aEVL?=
 =?utf-8?B?d3hXMjM2NGE2eGR3MTJkeEtIK1ZSWVFnOUZ6YTcxKytqWEhEbEphR2gwQU54?=
 =?utf-8?B?MHk1UnVyOVpQdXdmcGlLL3FIcHk5SkdTM0VzUlEzZ0VVcnVLQWl4QmUxNWli?=
 =?utf-8?B?ejlNYUM4cDRnY3p1aHhLdDFZS0FkcXVBczI2R0hFcll6Vlk1NzZ1SE9CRC9p?=
 =?utf-8?B?R21KN0U2RmlHY25xaWlLMEN1bFRaWVlNTDd0YmlZMnRLUnZBdkxTekRDOVBZ?=
 =?utf-8?B?ckZ2bG1nc2dueTU2TndzUms0K2FxZ0h3eXNLQkVtMW9FSkNYWkN3MDlXYnB3?=
 =?utf-8?B?cGYzVmp4UUJqZ2Vsekp6NDBRSTZ3N3hVMEk0N1d4cWxtai9KVm40ZElDMExs?=
 =?utf-8?B?MUNBVmZCOElmMFRkcWIwcHI1amZ2Y2VmZlYxTXp1NnNoaGlKd21IZXlVd3VX?=
 =?utf-8?B?RGZEMFFTRmlYQWoxV09samQrLzV3Rm1PWGR3bjVOVkNsazNOblBZcVNRWHkr?=
 =?utf-8?B?ak5BdzVONkYyR2pGdUdUNEJ4ZWZGNlE1WVlPbW10by9YNW9yU2RmR0tPZVBU?=
 =?utf-8?Q?aaFOh+VRvGU0a?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: aba1a868-b90e-44d5-63af-08df4d221df6
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 07:35:04.2317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15574

> +		if (uaddr < vma->vm_start) {
> +			u64 gap = vma->vm_start - uaddr;
> +
> +			if (gap >= size)
> +				break;

So if the whole request sits in a hole we just bail out and return 0
with nothing mapped? Userspace has no way to know. Same with a hole in
the middle, it quietly ends up with a sparse mapping.

A hole here just means userspace gave us an address with nothing
behind it. Why not just use vma_lookup() instead and fail it?

-		vma = find_vma(dev->mm, uaddr);
+		vma = vma_lookup(dev->mm, uaddr);

That also gets rid of the "depends on what's mapped above" thing
sashiko pointed out, and it's what the PA path does anyway,
pin_user_pages() just fails there.

