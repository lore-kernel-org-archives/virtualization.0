Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795504730;
	b=Jl5f0zFhy57OSYtHaQMjdThdzv7sn9+PQMj2zob/qv1+ldz3RXGTOipYRq29r6ovAyAF
	 AssGz9IEigK2aqIfK4tSxE5JIPV9AGoS5oVGBI1xpvXVN/iubTL29ytkCEy3NLXnqhn3Q
	 /jgIigLWEJ57D1YAS+ug9qOX2e2k5yQwy7Cwp2THeo6KLGrWQ2OIa+9/lNrkjnUX8yGG/
	 rKScHhI1XvSHFFMY2VFubtfaOLGuCxtySuSwrWsOMOYL5yvSo3SggjO+EtG+7Yr96T1wn
	 1gYbXuxBdHXSqMpIzGr5UDGj+G+0jxQEJv9XXhsEXxBLvK4gPINbc6dE8/qU/F3/0Zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795504730;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:
	 Message-ID:To:Cc:In-Reply-To:References:Date:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=gsmBD2HQANqwgpsnFSaMEVCgi3F4wqQw3On4nANdqJ0=;
	b=iL4KksMuO5A9dSXkTF+HahZipdqwdr7xuuwkroggewNCxQSq5W/r9YmjGmvuWFs43f0N
	 YvNGigRJaxx0gguILAW4iEcGO/zULWgQAgaRO7n87JopX4mMDdNfFkkY5yrn4atlbjpmc
	 I/ANFKwLppN/egQZjcsMOPdCTYFjNIuGO+EPHYq0egmOyTqdF711nQCsVJHBmfKuMPyoY
	 E6MF3qRSNg3nhcjmuav9trtnPyB5pjY0xz5QhCEcemNG3ErPwGS26xJ/j+xqo4YxjFI1+
	 57Q78PJbJ1zSYROiV8xfo1P36RpvIgX0QsOOxYWBji4+IUIy+WzsgT/t3v8FXO5lW/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=jDfFleuG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.21
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010021.outbound.protection.outlook.com [52.103.43.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FCF606A322
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 07:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91FCF606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=jDfFleuG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUBfy7zKIY3ostlhI8DN8U+9VVpkgkUkRHag3jDgW909UoluS7Wo3lYPkXusWYWQQ3ecwSPgR4BtkQfvLMStftaUWwS2ocADGtuPOXHw02W5hmnghWhUK3EtBmT+rLMVrDbUa06qcTx29EDmEuQYVluPyWXbEVv5ZzZnf718XTSG46ESlyLERYufwdun+psN4VussHPTpvP+1/jDejSmury61Z2A/3eF9zR0HepfmCXectfKLa7IJaKD6IufAdt3RNTUQP3RnEwH+ErXvCbDevBYw2BqJcTTPe8b/o2Q+dr6Ulhx2MDONylA0tM/V4k4RFpCMDOOBzcucInoOIt0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsmBD2HQANqwgpsnFSaMEVCgi3F4wqQw3On4nANdqJ0=;
 b=FCFp0sqv8m/4xzl6mjFp9rP8HSCnBnWBR9dIxFVEc99wuK4/hp3Ll7vwSaUhcrpdjKgyZd9QZUdY+AedbDAwoDMTcRpKkh0fNP51tqKhZLEfyqfHdUDwaLfWfItcFuBq4rjFJUFvkzlv3R7ccXGLKyJDwHfeVrCEHpQ53ILruicETNG5u2RUwJcoXFS5TI5Ew3jBYfvs81N7hjY0m0nDkfz/IoalxYVYDbhqu89lhkA+YlHCyDOgkMF2EAaL2HCOiRoLEEgRbaz7IAlbe0TM9KIpjjwCy/DV8ckztF+jyKSGM/KIy+/TyoULjSwg7PRVDkq2ximhYbUgi/6ghwxO+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsmBD2HQANqwgpsnFSaMEVCgi3F4wqQw3On4nANdqJ0=;
 b=jDfFleuG4ZRtLEpZYn5ijCeIQQeLEzmbqf/8CKf+L/OWWwXV2MGRfQx0MBp5TydvcStjamnGu2+9Y5TyB4mVZpMYlfgBJ8qRRngrM4h1zrxSka2UdRTH45gQUk7NEsMmB+03Uw2oOJeDzyfXx81AnWGBnC0eS5hEqcymX6kvMLyl387V5/fABESweI57fycOBBhDXVbJV9ain2X/nmBJdw4Bsi/kb9EYy5nzN6Rb6kPSwDxQbJLltwgVRsc3FHzBPJiNqY2m8dddr/cg3FO2TAwnKBrHuPwmbZEVHwiMrstuhK0Ayt3Nm0VuePlqPHrkoBiR/BAZJYW49vqw4SaItA==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by OSCPR01MB14402.jpnprd01.prod.outlook.com (2603:1096:604:3a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 07:18:40 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 07:18:40 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: Re: [PATCH] virtio_console: Put device on failure
Message-ID:
 <OS3PR01MB10251DDB055D1679B1EDE974FE7442@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: "Michail Tatas" <michail.tatas@gmail.com>
Cc: <amit@kernel.org>, <arnd@arndb.de>, 
	<gregkh@linuxfoundation.org>, <virtualization@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
In-Reply-To: <aoWK_qpSBeO6Bw0M@michalis-linux>
References: <aoWK_qpSBeO6Bw0M@michalis-linux>
Date: Tue, 24 Nov 2026 07:18:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TPYP295CA0006.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::16) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID:
 <3648a74c-c4f1-434b-9411-aa8e1aeaf4ef@milk.local>
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
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|OSCPR01MB14402:EE_
X-MS-Office365-Filtering-Correlation-Id: cd56f12b-a42c-4880-811e-08df49fb2a1b
X-MS-Exchange-SLBlob-MailProps:
	XL7il9rKhFcgcCPH3lrK9ONsiCq4wZam3H0nXZcNzNBmjuUqlEuHuXUwoTcPj3HZK2kcdmI4UOanWW/HbZBsG1A8yIwpEVCD51FGXt7i6LjerEnTaCTVNb2Broo7h0yM/lRl7IPYvEEU5BwYbKoCpgAxV8hJP3Wu5qUTOJ0ectooBYo+4WLM7iw84Hkn/ZEqXcEeKbPI79kljQuy6EVxybKiJSrtHvg/PLGlcyK8+7m69YH8NwzuMkABsLHoen0xp15SSk9r54XLyTieU1IMc1RRjlRMeXYPCmDSWGF2NPsxBAZL5wWDg9txpgkx6xdNFbZSpJh62YxhQbPumOy1f7xM+MKhPxCR+7WN4v7fqTgM+3FxmjPMszBXJUu4d0Z1ghfq6bru7rrvXg5JfCaB3mdAuwJi2jCrYTibyDuB8OSzG/OoOsnB5G+A6+VwMkWj6M//wr1gEOi1bsrr/+0UQt3ZyKlp6xsLSyIVZclosqdRdi22DOd4TFEwA32FYq314b2OAIdL73GrUkrHhUsRM2B0wJtUy2aaGvY2aU6jS5DvuniJuNL5p6NBQExaMmOsXknc8HuAuHAsD7fhyAEF54qHxjYjWkHRWlKLyW0HJhr1DmdPMdMhdr1ZFFs1LYNKDb0EEs4T5BK9ktK/syzFPQ==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|55001999006|22091999003|25031999004|24121999003|5072599009|19110799012|8060799015|23021999003|6090799003|15080799012|24021099003|51005399006|4140399003|25010399006|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmZYTyszNG9jb09SNWtEeHJudGQ3Q2wvYkNlVFVUU0RGaHFXSVcyMEdBbVVn?=
 =?utf-8?B?ZkZDcE1IeTA0TzBDRVl0VnozZ01WUU5BdDBTR1VjS2haSDg4UEF2MFRZTFNL?=
 =?utf-8?B?aUdNQmc2cGs2SDY0ZDdSV0ZMNURINWNUc3dsamEvbzVWcFcxTEdueWcrVE01?=
 =?utf-8?B?NUZYTE1VNHl2amlXbDR5TjYxN3pzRkxsVWplRDVPUUVDNlFnNlZrYncxVDNV?=
 =?utf-8?B?SnRsazcwQnRDelplVjZvSXhveTRoYkszKzY5TCsranBhS3dhdEV6WkkrUG5x?=
 =?utf-8?B?akt5VnhZWkNKMUw5WDFYcDhYaUFTU0ZlejlNMFB1QWhQWHdXVnppVUNSd1Jy?=
 =?utf-8?B?MXNqK3pxZmlmOUs3RzhaT3dmcU1JdHpjdUlRZEl4SnRuL3ZYaWIvWEFYUklX?=
 =?utf-8?B?ZnYwbFV6Mk5GOWwyTWI0R21ydzBMUmVNM1MyMGJyczhyYUhQUXExZVF4cXZY?=
 =?utf-8?B?aWk1VEZoRno5TytZK2w1ci9LenQ0TEdDMmtWeUtGMllqNCtRaW5rMGM0UjQw?=
 =?utf-8?B?Q3BHQ2YxWlJFUTZDVUZVcU5OQ1VLeHV3K2lWWWs5b01mNXpucmZsanpsam93?=
 =?utf-8?B?ZVI1VFRZWEFBWWxWY24rcHlzczFHTWkzN2dkbXBhOFJ4bUNzTVRZZDBjNDFx?=
 =?utf-8?B?UDJ0ZTRRRkdBeW52ZmszdVozVmdyTnJJSVB2aW00OXQzTjlpZVJjRWZIMFVr?=
 =?utf-8?B?d2RPcFZFclJmWU5CMFBXL1hiR2JCSlY0M0JRdWUzM3pXUEVaNE5uWStIWkpW?=
 =?utf-8?B?VmljemFNc0dJYnBPMmEyWGRTQTBmRmRYY0g4ck1WN3lPaXh5b2VxdW0ycWQw?=
 =?utf-8?B?cDlzKzlKbzVXaWNUMFYyTDV0S1kxYTJlUzRRUDRzTHdDdnlkWE9acGcrRERN?=
 =?utf-8?B?ZG9CU2FrSDN5T1UvUDF6QklnTXBaU2hmK0VIUmpmTzRGRSswb3U1MjBiYWVz?=
 =?utf-8?B?UWg0aVAvOEVVdW9tYlQzY1lWeUExQVpYSFY4RDZlTXZYc2F4VnJWMTAvR3hY?=
 =?utf-8?B?TitXVTFEUThlc1N1Q1JxM0RHdEFWbWtMZGNXMytoMDhWM25sNmc2YlRXQU9o?=
 =?utf-8?B?WGlaT2FNUjgvNUw2SXp5M3VmaGhXN1JsTUJCQ1h4SmZGYnIwRWRlSzE0MnI2?=
 =?utf-8?B?UFV6NFdOWHVsOEZtVjVEV0dmNHBpOVoycStua0swWldUNVhES2N6djJDQkgx?=
 =?utf-8?B?cFZpSXB5QkV1U1UyN1JlRERYS3lYYnZxVlkyRVBvVnl6a2pDVENsYjlwc0cr?=
 =?utf-8?B?azNJK1I2aklpVkkyNHFDOSszWGZxbGt0bnBwbkU2N1VBbGtYM0RNdzBkRUhz?=
 =?utf-8?B?cElpWmNtVFpoQUU2c2dwZFFnYUlXTlcxN0VoWUUveU5tRTE3c2ZGMnRoL1Yy?=
 =?utf-8?B?Rk45ZXdPdS9ZQ0owV25mSnpxZXBYcEFIU2RobjFZKzYxMUVJajRlUFBvd3J5?=
 =?utf-8?B?WkhvakpMODdmMWpDN0RVOTFSRlhMWkZwVkc2eGZJQTMzK1RWRVI5N2JLdW5j?=
 =?utf-8?Q?nI75U4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnFpdEo1SitJMGZjNlFpWk1pbXdidlNHWDRFeEUvb3pBckIzVFJRZTR2MXlV?=
 =?utf-8?B?WFAycGtYc0oxVjU5dmEzOWhGaVF5VVFuK0ZxOEpVNmpQbG1BUk9XeVgrSmxE?=
 =?utf-8?B?M0lzZlFPZ1A1UGkzb1EyZlhXNzVpK2RVUlB6Tlo0OVB0U2F2RHlwczl6U3g0?=
 =?utf-8?B?MWRFcjUwQjNaUHdMK0NPcU5xcWQ0NHFUQTY5TDc2NnMrSUUxQ0lSeXplaWlr?=
 =?utf-8?B?K0hacDlhOVZtemJjaTRSNHFRcmxyK09OVFBuc1lvRExGb3FXOWE1OGhOWW00?=
 =?utf-8?B?UUUxUWgrbHlJY2htTnl3dVRhZWxzdm01K0lDaFBPQmVDMkxPZnAzc2R2Q0g5?=
 =?utf-8?B?bDZxenJqK2hQVTJua0ZQMWdoOWNpdXVBTnhnZ2xSTTNYMjdLT2RMMmN0WTRV?=
 =?utf-8?B?OUYzMm9HR3JMV2ZtSHd6cGx0Wm1yN2Fld2haT3FqS0JOQTNrTFRxWjJCT2xo?=
 =?utf-8?B?cVhkK0ZYSFdMczhzczZsYWw0cFU5SEhkVktxVVpzNStraXFwa2t5TGFRM2k1?=
 =?utf-8?B?dzFoc2l0NURud2FtVloyLzAzZnZPR2psUGlMNnZhYzR6WWNDNDRUV2cyVmVS?=
 =?utf-8?B?VU5nNXlST1ROL3JqK3k0RHV3N2g0VndscHJKd2hlS0Zxb29xVlhCYjNyaUFn?=
 =?utf-8?B?OGtmaW9oWUZieE8xcENpeExMV01ZVEJzV0s4VmtjU1FQQ05HRnQ5cUhWdlJG?=
 =?utf-8?B?TFV0QVhzRFlGV25sbzAyYjhodnQ3NlpINU00QzMwYVlsdHN0WXB2WEwyQ0Nr?=
 =?utf-8?B?TE9zR0dxUjJKVTRaMGdDUVVGRS9BMG0vdjdEZk5temxnT20xTURzY3RucEo1?=
 =?utf-8?B?YSs5TzhvTVNWcHB4dUJWVk9Wd00rQ0cvM0kvMitzQUQ0bCsxKzRybWxxQWNM?=
 =?utf-8?B?aGVERWJVMFdqYkJ6UEJyUkxPYU1xNHdQalFRZjE0cThCa2gyVkRpRVZHc3lU?=
 =?utf-8?B?Si9ObW1TUHVxdjBBZUNLYUxaUEgrK3l0eGpXSWQvcFJxRG1maGZ4QXg2bTRj?=
 =?utf-8?B?eC9DRUx3c216QTBjQThNN1FobGNCVkhodWhHZmJ2dUR1RzRGOHZMQjJvYlVS?=
 =?utf-8?B?MHpXcEJiT3lNcndoeEVqVWl4VFdsb0dXdTl5TnJkcFJTZXFZUy9RUWxraE90?=
 =?utf-8?B?Y3JQaWdoRHlTQ0ZMZlhhNWFwa0dEZ1o4Q1lpdER6NVB0aE5SMXVmWXpZSit1?=
 =?utf-8?B?R3dtUDVqWlBzclFXL1BSNmpxSTdLSEMzcFZCcG5Od2dBYytDaVRLZC9XQXJ0?=
 =?utf-8?B?Qnk4QU9tWGxSODVtSEplS2wzLzRtNDZLSDBrTVJoeEZYd0h1aFdua01ka3VT?=
 =?utf-8?B?VENIelc5ekI0YlRzVWlWdFBnZ1pGUHdKeUVIZm5zYi9nZTBsSFNlTUppZkNG?=
 =?utf-8?B?UWdGYURJN014SEpnbGxHRXBmL3EzSUp4cEtreHBTd3hRNXVKNWRhcFNNZjlr?=
 =?utf-8?B?ZXBwWkovNTV0ejFuVVFGZ2xrS25YNFlOVExnUnlLQnVaaGtxTWQ3RjlWc2dn?=
 =?utf-8?B?UCs4bS81c3NwUUIrZnhRRTdkY0k3SUpnU2tZMUZCOVZldWhtcTRLQjRTQ2oz?=
 =?utf-8?B?eFF2bEdCcXJpZDZyNkJGS3dCQTlnazR5WG9xZm5RUW5Kb1JkeDZFQk1aY0tY?=
 =?utf-8?B?dlVuLzBya0Z5M3pQUEQ0c3p3ait5YmpqTGNqbE0rZkZoMTRDSGFjUjFhejhC?=
 =?utf-8?B?aXlDdmxBdGdTM3NoeEpiT2drU0tIK0lockZnQlEyOHlUaEszWWI1RUNPQ0tj?=
 =?utf-8?B?cjU1Rk02eWVEa1U1MThwTnJ4eDRoS0VWb3pWbytIVmRaZExkaEo5UmN4cFBr?=
 =?utf-8?B?dStmZXhUNWdtdW5MMlRRSy9FM2g4L0ZScDlzYjRUY3dSTGs2dGNqdGZNYVpx?=
 =?utf-8?Q?NHY6mwImBykIj?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cd56f12b-a42c-4880-811e-08df49fb2a1b
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 07:18:40.4871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14402

I ran into this patch while reviewing another fix for the same leak. That o=
ne was dropped as a duplicate, but the leak is still there in mainline.

Any chance you could resend this?

