Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795851331;
	b=RcOEfUAhEayu6FvYvsRtT/nsoppDXXFHIHSExkZ63fuBPTvTXCPSxIem/dAZMikcRyqp
	 pSP1U5SgtmASY7vRklodQe+y7T+E9/s38mncLrU9QL9ou5b66kfu7DP7LGyrCFDJxJwpx
	 9K3WKBw05X/Ns99ckjy93+RSBUHWvd8CdzzMb6nsrmiAY2XgVBlpJDa2iDxH2qqfzf/Xv
	 SE8YDV+mBqxISG8I8zKVo0BZXrvHwLlm+dHQJiL8w4uxuhkJYea2MKQgyaIaEsJPBTO+4
	 XHH3C0urQIH2Q8PNbcymUC46/L4eDaMLCUG5BRfBqVLXqradqyHUKWToZ8JLhWhuYJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795851331;
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
	bh=zAb3NjLckI8ZVxsTpDslGM+jiTJNnNN6gUp1DDdrnTY=;
	b=rNq2Qf989vYEODmojjV3BceBq8HIbzvpfT/fi7EORPWmLmxQHXFOHwA2+wbqalUAdr53
	 o7umpM0PDcBGSLL90u0pM5OALt5IrDjtPGWFxC29xVYJTRlGC0xen9zEYAvOOcDEQHTTh
	 cmaUsZYgoSkB4yD7UQkrjjr2KN+LwayW69UaZXieW3Wys3e+MMgAlnRLC621D1ZAezZ+Y
	 /0tTXFxc5X74lsZz3N1S+EeOnHC+dlrnrYwucjxIc3FCySfu6okqP7+rpIRn802damWXa
	 ZjUvXTpgVZbaOAxEwaY4MwgLG3k0WzlKLRYYazH/PfKi3r+keG8RrCXtmwacqY3u1CA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=Xj2WEA1B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.3
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010003.outbound.protection.outlook.com [52.103.66.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9C1606A31C
	for <virtualization@lists.linux.dev>; Sat, 28 Nov 2026 07:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC9C1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=Xj2WEA1B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWDRqHKsPLInHAVf9J2Zov7WqQvQpZqmbkRj8FXnxV+zjiwUvXIl23NLfH8Jr9tKMHlBaKBDD/5vLXFHHqb1bFoQ/UVYWqkbIsWKw7EZ6/wZP16occMM5fXsDY+hbjJ9IpHeyjXLAWKIiph6w94gOTXgSxf1lOpfpp/L8wzIhbhlSCTZvnNVuEpr5DTtigh/4eqU16eTpOpt8LUhx2FIG3GYzV6G3o1OwI/dRwvqwGrHB86AKN0Tqeo9aH51NtN3VU9LSXT5xLvUGlvoCld57ji7YSUSW/PKSoHjyLF/oqsPv1lTmCwJdGOtINYvpuzfhzgN45NuMnmwx2h9KgNl6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAb3NjLckI8ZVxsTpDslGM+jiTJNnNN6gUp1DDdrnTY=;
 b=WjlkAGmo4CPcswr/Atk3wIWnlNiQslAOD3Wg4JbmDXykndnUj+hj3t/NR6s2rlQWhK3Mk5xig0K3bkxalf+cL1i4KpVwHbs/E0M87Pj+sFSML3Ed4hQnfs0NW5B1sH1t/CaPBNZ9cZ4LFuvsW2PISdvNPtlhrIaiRPmwjINCxbypki8juasyBpWSlr2d4MIX5e3F2bguBI5mSQH9CR0z0Is6B0YHeK/aQ/myP0c60bslJ6BKdM9KR583nZBWA7lpPkWVSmpWKhIMh+HfssDmN5R6zxiNtX/Yo3e/avNgTEyaiap2rREFx3ewST5qevYjbSvCqLmcT8irfy2TAeZQpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAb3NjLckI8ZVxsTpDslGM+jiTJNnNN6gUp1DDdrnTY=;
 b=Xj2WEA1Bn+hhM3TxUh84w3jwx4EekQ91EribBC2irYSb8oXUvjNj0OHb+8oLSgaBBnzdMsO4pjDHxBWbecP1d1lFKQtlq7283ZCFTzwvrAQ4l04qCVeN/gFJ+6egOIDLviWuPK5TuRawoaNLDgNzBRvkZY+7szhfjhsjjvL2PGA4vPNZEbR8/+9uKU6BIA2PqXQZPc5/TNTLY1pB5u3gJnlD/hpSuX8OifouE/BXUvIlKuKxQk8OT2OhPqqTxAzXklf7SlKm1V4c/4KTqm/akIQ6EveFtAQgxiNkb471RbmoUDClnaxSODSmZiXm1l64atfXIrPUXWG9lHaxSkR/rQ==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TYYPR01MB15574.jpnprd01.prod.outlook.com (2603:1096:405:292::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Sat, 28 Nov
 2026 07:35:26 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 07:35:26 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: Re: [PATCH v2] vhost-vdpa: skip unmapped gap in vhost_vdpa_va_map()
Message-ID:
 <OS3PR01MB102513620123817B5CC67D58CE7402@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: "Fang Xieyan" <fangxy@xiaopeng.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"Jason Wang" <jasowangio@gmail.com>, 
	"=?utf-8?Q?Eugenio_P=C3=A9rez?=" <eperezma@redhat.com>, 
	"Xie Yongji" <xieyongji@bytedance.com>, <virtualization@lists.linux.dev>
In-Reply-To: <20261126072414.97199-1-fangxy@xiaopeng.com>
References: <20261126072414.97199-1-fangxy@xiaopeng.com>
Date: Sat, 28 Nov 2026 07:35:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::16) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID:
 <3702d0a9-1361-4332-a194-923806f1c0da@milk.local>
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
X-MS-Office365-Filtering-Correlation-Id: 10c22dff-b2a4-4d20-8be8-08df4d222b36
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|24121999003|19110799012|15080799012|6090799003|23021999003|22091999003|25031999004|8060799015|24021099003|55001999006|51005399006|25010399006|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0F0Vll5b0NiQU5ML0lWcm8rWHRiSmNJYVFMYTJaaURxV2ZmWjltMlNCejJO?=
 =?utf-8?B?SmRuTlJXUzIrcEpKODZpZ01oa2NjSHlGREJWcHdaWktwTWwvWEhBT2dTZHl1?=
 =?utf-8?B?L2kvM2FsVGtuUFduME91MVlCWUpHZVhZdTZFQjd0MG5KNVVJalZtODU4bVJQ?=
 =?utf-8?B?MHlXdWFORHZDUmxycG56bUpib3dJRUMxQjVSc01hVjQvOWNsc2ZkeUpURkRJ?=
 =?utf-8?B?b0xFSTJJZVFxOUF2czFPWWYrQ21BM0dMYWQrUFpwaG1MSTZFcGx4Z05lM2JP?=
 =?utf-8?B?VHpMSmE5ZVFPRlRrN2NCL1hFd2pWczE5TTBMMTdGdHAwTW1qYzZ3anBlTGNo?=
 =?utf-8?B?cW5RMjk2bXl3SjNueW9BZXBvYXgxTkVwYU80bGJKVU5GV0RyVStGVW9Lc245?=
 =?utf-8?B?NFd6andVenBjRjRrMWhFYjh2R0g1ZFkwaHBONWgyR3dmREc1ckRiT2YxWlZt?=
 =?utf-8?B?ZDlzSFo2REVZQUlUS0JBajBxODA5dlFyWGFjUjlxRkJiNDBVYlpTc285akRO?=
 =?utf-8?B?THBuWmF5eTQyak1lUEI1OWNsR1FZL3VsS0xLakVBNUR1UGJ1VzFoSnBHV002?=
 =?utf-8?B?WlZyQkhkRGoxNEtRdmtQWjB2SlFGbnVNa0wrcDdIQmh3L3lnLy9kaTF1MHFm?=
 =?utf-8?B?YVBWUzhjRFhVT3l1M0hORU5Sd3B4Vy9TbkdlK282L2tNTXpCWUl4WEVjQ1kz?=
 =?utf-8?B?SHVnaHVKb2J1SDJTdDRRd2k4LzVSdFpPSTBkb28yZHFtdWFGUEVObFNCN1dW?=
 =?utf-8?B?Y3R2dGNMTmROTFZWOUJIWUg0QTZxTEQyanJHNkd1RjhXK3Z2TG15NTg2K2p5?=
 =?utf-8?B?MytqdGZucHA3S0lDTHFXdDhLWm5tdmJmSFp6ckthV1RSenZtYTBlcndsM2I1?=
 =?utf-8?B?dXpDeW80ZGxla0FJK0RyQmxiUlJzZ1pDWkI4d0kza0tUOVlWbVpoRVlLSUxz?=
 =?utf-8?B?R2sycG1manBUbEtlZlNhWm8rR1ZFem1ua1d5Z3htYmEyQ1V3UGJqYUR0dE9r?=
 =?utf-8?B?NDJ6R0w1Uk5qdzU4YXE3eDZIVnpmY0ZEbFVTeUhCblJwU3gza1NGRFVoNW1t?=
 =?utf-8?B?cFE0QlpRR2hiQlNvL0M5QXppYkRhY0RwejJqUWtXUWVJTVZLVm5zOVVLeS9u?=
 =?utf-8?B?OHhVeTlIOUdHME5xcHh1bG5Mb2JzQ09QdUZXTUxyZHgzcmtOU3VLcENXdzNS?=
 =?utf-8?B?ZDJBY2RUMVU0VjFHRTBWZHZPU2JFNTR3ajJmejIxZjZZTkdtcHBUTzhoUzgx?=
 =?utf-8?B?M25mSkRHL3NDMU9aWi9FaVJIYWZKQ3JxMmQxK3h6Y2ZLK1lUSzdrUDBlbStu?=
 =?utf-8?B?WDRwa0cyRis4L3BKL1BldzZJWDU4QWRtN1RvT0xBYWxRWkhyMldUOEJKS2RR?=
 =?utf-8?B?TENyR2QvNVVYOVphdThNQklyd243VjNqSkVSM0FzRlZpYVVRVWc5YzdkYno2?=
 =?utf-8?B?bE5iWVhXTUNZYVV6dGdLUEJYWU13a2VHR3hwSCtLcEZDM1JlbWVpNkZ0cGp6?=
 =?utf-8?Q?WwgWso=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXZMZVgzcmpMMm5WZDNOZC9zV0dHNFJMVVAwMFM0WHZjUVNHRzloWmI5S2ht?=
 =?utf-8?B?bm1PSG9VRXYxZDFQT3VYdUFSTVZmenRhNFVjeHdYdXJBdi9ZbDVqSm9ETEFQ?=
 =?utf-8?B?YnpTWitCbWt6T0t6WHZVN2VCTForTlh2NWFFL3hmRnhqZiszYXFKOTNsU0ZU?=
 =?utf-8?B?WmNhNWYzSWlvVjdTeE5lTXN0SDFrb1pJS1RUQ0NYUkFyOU02TFBZQ1IvMGRp?=
 =?utf-8?B?VWpQVmlrZ2czTDRKMDZpSXo5QkNNU2lMZE1IM2xZelVhY0ZQa3hyNjU0QkpV?=
 =?utf-8?B?L0EyQnorbEJxOHVna1ExYXVOUG5DTDVGcUdOcndKNHRyOXhEMGN4RE1wUlZ1?=
 =?utf-8?B?RXUrOUVVOGNNNGZCVlRRMTVLenNTVWM4R2o1K0xCWm9TT2xKL21OSzJkSGVV?=
 =?utf-8?B?bVFXL0Q0REFCakpyU2pSYlZ4WTA1YkU2UW51alkyd0VSbTh4MStJRzdtS0Vq?=
 =?utf-8?B?S1hFa0o4ejJxMWQxdnp3US9KOWdGdnRrMDFqcTU0YXE4UVI0bmkvTktJRTJm?=
 =?utf-8?B?RlYrSGtqbUJBdDdaWjViTzVhUDE1UUNoSS9YQlc2Q0ltSnFuTXoxN0JiU0Zz?=
 =?utf-8?B?aDQ5a3hnK0lKaU5ZbWsrRzZQMWU2MEk3NmJZdEhHNVBDamhiK20ycmN1ZEo1?=
 =?utf-8?B?UDFsWlNndXBOZmJNRjRKdG9Da3ZKeXgzdUlaY1RwMnBsS2dQRTMrSHRDV1Jr?=
 =?utf-8?B?SGs1VVFxRUttKytZbnh1dEtsZEN6RWE1RlFENWEwRTJSUHdZQ0JzTVVjRGZv?=
 =?utf-8?B?Y1k0TEo0WVNvR0xKeXB4K2h2MG5nbmRWa3h0NWl2QmJ6c2NrZVFPSmNCMW9B?=
 =?utf-8?B?b2JxNVVhZzJtUlEwUUR1OHVSZi9uT1NUTVMxaWprZmhkMUZDNW5MNDliRE9Z?=
 =?utf-8?B?cWtSdENXaTVmd3JUa1JUZFJjdCtKQ1dOcjB4d2VCUktDY2tRdDI3OGZBa2py?=
 =?utf-8?B?bktMUVJ1YWtyOXp2Q2lZcE5DVzlpUDBzL1JJYmhjNk1PbTladnpjT3F4Um1N?=
 =?utf-8?B?anhFMGlNdGlqNzV0YWk5L0x4a05sU1dnNDNQc0w3YnhvamorakRBRi84eCtD?=
 =?utf-8?B?YmlnR1MxMFF0aXo2MGI0MzRoUnoxdmZuajI1amhtY1ZxamljWHgybi9ycE94?=
 =?utf-8?B?UG9EdFowQWJHcGt5QnJKRXZFTXJyTk5IM1JWd0orOVNaNkpwUUdZZHdCYlhI?=
 =?utf-8?B?Zms2b3ZQTEo0ZEpaTTZ6ODJya2RNVTVJRzJvZDFWUFFzZU9PWUdSaFk2SmRR?=
 =?utf-8?B?YTZVSjljKyszVzBiUE14cHVFMGdKcFg1djl0VzhWYVBiTnFXVEdvRnlWdEVp?=
 =?utf-8?B?cXgxb0h3TUwvLzh2bkJ6QXpTSkMyNkhZVVdxUW9aaXNFTUZpdTd1cEozYTVQ?=
 =?utf-8?B?YzRDSXljWm1XT09tZVk0MTVjRVB0UXVNMmZBMFJxV0ZIMVAydW85anVGUzBp?=
 =?utf-8?B?b0NaSWh5bHZrRy9lVlZuOEFHZHYvZlBYb0E0NFF1Z3BoalhyMm1SdllkMmF6?=
 =?utf-8?B?TlVmc1dUNDhranIyY0xMMWZZMkt3WDUvaUZXZU54ZTRNOXVRYnRhcXpia0s0?=
 =?utf-8?B?U1d5T3hBcUpOOENkOXZJWjNqUHFCcEwzUEZzcSt1U0xOeEhYY3g4TU5LVDFt?=
 =?utf-8?B?dHZtbFpIaFdOb25rZkhzZ04zMkpMRC8zakZ2YWM0MzBqd3FUQTZjZjlRTFdx?=
 =?utf-8?B?TmJrK1BzOTllWE1HWjlsYkZ0bVd6MG16S1o4NUpwcGxOTk84bVphZ0xOeFhP?=
 =?utf-8?B?TnpLMkx6SzBLRVB4akZYdHJlV3pDclEyYVBsSi8yR3F1VlkwVkREYWlpU01R?=
 =?utf-8?B?YmVhR2RSZGk0b3l1aUpiZlRGeWh3enE4UUl2ZnJYNm1SbFBlVkVhekNGeEp2?=
 =?utf-8?Q?dWg1x1qIV8ezF?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c22dff-b2a4-4d20-8be8-08df4d222b36
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 07:35:26.0962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15574

There's another bug here though, in the rollback at the end of
vhost_vdpa_va_map():

	if (ret)
		vhost_vdpa_unmap(v, iotlb, iova, map_iova - iova);

If the very first chunk fails, that's a zero-size unmap, and with
iova == 0 vhost_vdpa_unmap() computes last = U64_MAX and wipes every
mapping in the AS. This is already broken with find_vma() (a uaddr
above all VMAs gets there), vma_lookup() just makes it easier to hit.
Reproduced with vdpa_sim under QEMU.

So I'd fix the rollback first, then switch to vma_lookup(). Are you
planning a v3? If not I'm happy to pick it up and keep you credited.

