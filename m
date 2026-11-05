Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793888646;
	b=cEFvVkKKTo8bXH7Ih4k4+UsNWchMaQu0mg/55lFpZoKKigcJ5JR2HzZhdc6IBB5gHVTM
	 oIl+rKCiXn7/wcy464dDvDoqzLKDVcnoWA/qftUbGgiI4nAYX+qo4zavEFiG4+Fdvaft3
	 VbJi0MDBRwlVDn33+9K1ClZxO2Gnk7kOu8DGQ86eNVJZWj8ZZ/wjJphpQ7Fn3tSLHs9H6
	 63dpD+zSdk9GtFdrM7s/1242TkvsAncKtRSHwHjcYkFNX22L6SAzTaMTsJ+xGw8+ExMah
	 ZbTo16cIfs7GA1FEq8v8d/5ygv+fs3UNNiQAJni6YEbTkgesgESYIkh+u7K/a7/zJxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888646;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lKRyd6jPZ38O4z5cge9frYoPKfd8yqA+2zb6XL9yHDw=;
	b=e6F8q+GtXT837N8YSE3u3hbb5ViejbB85WePKfo82U5MIbQK8/9Gw92xVTv/I9MmRVe+
	 +kDfdSVd8DyBKx1HKynC2dFOHi69MpTg8l3WUJDFKfZmDTaFhYKMc54oVVBnByj7qPnAK
	 kd1z35Tqtj1QdKnKcxFRh4u3qwoIB6iN8M/4UZoe3UsGCW/0PG/E+OspiScfY/QIyztCJ
	 f0lLwgr0/8RyZdUy+z9bB8iUst0EqJWQvr1pY0fkS8i4cGd9uM9RX/gXNTKu9dg+pnzMv
	 7X8RS/qYtFKHbp0RfmAbPCAnQ+EWW16WgqBE7447Vr52s9EdBP2nfEqsieFAIlJnJfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EuPhVUPU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.37
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B88E606A33E
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 14:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B88E606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EuPhVUPU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTQ3lBP7t1HohBIxH0AxKro3SRKet1hE+wQ5PzLPI7+H99K1wz3a4pKvo2hb4WpbCkpGZnCCPrFMLxnu8O9+d0SGE+EcsIZHpPi166NYf+nGCfTncS2doKnrlew+a+s83vS0AiwNg4AmkeN0Q+iB/j06CYZF5b2HhcCaevENnsqZjbABGuvx7VSUXKj0RQDEM0j0crA2odfwRfuWwXrwMvFqIi0Q5Z41iagcBpECUbYq1uSnXbh6DH7eUVEZnC/zjqT2NofxwoLPt6Ae23I2x8zvwtm7uDjNbnnuDSGnfpTn45GhK9igkExvrshvodr/pmcm+Nzd3xHxLQw60kUCYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKRyd6jPZ38O4z5cge9frYoPKfd8yqA+2zb6XL9yHDw=;
 b=awqBlvJ2NOd0+c0k24unn78+kCMb33PvFRi1dWF8f9b3RlGElLl3ZjpMrfcFgsiyvE8jJs2RgHTih2g0gph0BCckuAMecJ4KbtrImVaA/dsbbv6IFcP9X+Kgc7lBw+p0OQspc+CVHS39I3qc90bPCiLWpkrGhzmwQeTU/vT3By97VPJt0yv1+r0nmZ06bbhWer7MYcrjlt9P/1VLTvb+L/eFLsEGhjljcmoeFSUjnPcV2bQioS7n0SX6U5o//Yvmh7J8NNEkwXCUKlrjbbJoLEuORbsMnvMbvuPBIws8OWh9gW1u6AOE7UV/giudBRA1cia6c0Vv6P7uOJ5s0jAKOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKRyd6jPZ38O4z5cge9frYoPKfd8yqA+2zb6XL9yHDw=;
 b=EuPhVUPUFDSXCSzpb/O5okXz68TN9xM1GftjG7fjBePou/nsV9J3SoBEU1KIhxaJ4sCZuTgfl/XgImBPmyXR0sSCB+qfODlZS+56Fj/0Gc75+IjDIG9XACcd7wW+QEQh5dU5/VH8ArBzHE58Wo4v6sz5NGgYCtZajLvMQWVOCPs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 14:24:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 14:24:02 +0000
Message-ID: <e7943b6b-0f3a-4336-8a0b-306aa11c8d31@amd.com>
Date: Thu, 5 Nov 2026 15:23:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dma-buf: dma-fence: Add flags parameter to
 dma_fence_init()
To: phasta@kernel.org, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 imagination@lists.freedesktop.org, lima@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20261105113529.1989375-2-phasta@kernel.org>
 <20261105113529.1989375-3-phasta@kernel.org>
 <2f377d0f-2760-4465-ac68-b62210b33bd6@ursulin.net>
 <005b77fd-5bd2-4ae5-a0c0-cff3f1f6c680@amd.com>
 <f284e3b9501acca2cf41fd19409004de84a36e15.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <f284e3b9501acca2cf41fd19409004de84a36e15.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5a5c40-99f4-4e2e-b119-08df3b48704e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|23010399003|1800799024|376014|22082099003|6133799003|10067099003|18002099003|261026121527099003|56012099006|11063799006|4143699003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	em4XYO2yBRkv3TPrZO9m5dOjdwSydqv1pRiSz4fLGp90mAQslFzUZPhQKp8HJDUmXH0BskJ7IT5reLK1Zq5C06JbVwjV0Tt0KTWDrEcAeddNJrB+rTW8TESR7wWBIQPLNput/KZ7ItE8V2CYXcxKa8HErwzzPX/8xoVGznoIRWbdDm0wRxH43RYWaxwyp+MDXhDx0Bko+GQr4l9RHtxgTfiYVs58t7QWQO4OVRfetNagjKOxzbf44pIW9TtiTLgOA5FhtiRRga7fmc8EwBYRO8i6EAQqyOnKhTNvfpLsPZS/C2dk5LxCyjF5UfjYbvHvu4PwF+pk63OYYxdA79HpKGdkV7A9raAwQLO6IJqmOIyTSzmnhjOnY3OeAh+e4bItE3pVF3KbkmzAl/6ZqDoYvaG8MFzP8TE+y5PL/gCPq/yXOe4FhEtpyd/Tvl64dCq9KOtsHI7TY0F0Kqy912RFE6O/IXS3/yzvkR+VXkmc5VjIVux91vDsXhsFk6gkze7Xov7m5/8jKNXyFZ5WdICgR3KBg8PGGgJsaRjSWX/yMS4ywRwj0+Ru76vqv2TG0zC0mw8A1cCDgNOmw0NiaMzHAffmb3pYVIfYeC3SjIv0MHNvdxtKMf20Oz03aF2A7NJhQStPYpgU1qT51HYat2MTVlMNTEcT5lMTkWteBOpxDeg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(1800799024)(376014)(22082099003)(6133799003)(10067099003)(18002099003)(261026121527099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXlJUGFwRFRuam5mZDNaZGVYYmJGNlFaaitwOUllQTB6TkM1R3RGL2lXVDdP?=
 =?utf-8?B?dVByVTg3QWRNdDhNRnNBMGd6YURpRzA0V3orczRpdEN3ZFdnRExtSzE2TVRN?=
 =?utf-8?B?K0ZwNEVTcU12TWZVZW1vcmwvbVdTVkFUemdKV1p6dWRTWVIrN2tKdTRyYzZt?=
 =?utf-8?B?cHdQRFgzSmYrRGtreFZ1RzcxQlVYWmY5d2w1aldmSnpRRUZZc3JaYkc4TjYr?=
 =?utf-8?B?WFYySVlzQ2JkQ0UxcXM3elVkblBSNStCMWRhRkc3bWprVk50YUcrLzErSnJa?=
 =?utf-8?B?YkVSSkZQUVlMUFJsYVUzUTVid0kvYkxVNDhIRkNDdG9acEdxYVkyc2hQbWx6?=
 =?utf-8?B?MFZoUGI3T2dkVTloY3RGRjNRamhTSlR5RElNYk5wcGpITjY0N1NMU2VUcE1T?=
 =?utf-8?B?Q3pFRlpUaUtZbmErOGFKVW5jRCtMSHBCRGhKU0ZzbUdpZERLOFYzTEZXbEJZ?=
 =?utf-8?B?cHNOam11Nm92clpQUzhnbVJGTE54UzJPTnpvU0tpaWhES090K25mTmN3c3I1?=
 =?utf-8?B?cTdpZ21SMjl0LzN4R0ZBVXFwa25VZjgyZERmL3FtMGVsOUFSa2FoS0I4T2xX?=
 =?utf-8?B?Q3QzYmxLWGFNcFNLWnJ3OWRRbFdCcXdMZ09NSmliRnN1QmZMeTlCN1dSTjJw?=
 =?utf-8?B?R0p0MEl3Y3FjVEJEbU5FaTNTU3cwbTFmWWJzM05BOXNiQUkxMVp1L29CTzIv?=
 =?utf-8?B?ajJiV1BWUUhzSEZiT2tJSnBZZ0hTUnNZUEN4N1N6SDZ4b3lpSDlkQnRTYVhH?=
 =?utf-8?B?RkhaaGFGR0lnMG02Wm9hNW1OZm5mVkQ0c2RGdkp0S3pSd3ErUmdiUHRsMm5r?=
 =?utf-8?B?cjNHRm9GS3ZyclhpZnFvMGNUSkZEVjIyNWRaVnRJZnFQK1NHdGxpNHBwN3V5?=
 =?utf-8?B?a1d5cjMwdXlMMlFLZVB0K1R3cFBXT01QdE5MZVFpQ25lLzQ4ck16aVIzMElH?=
 =?utf-8?B?TnQrMVpXYk45QVVPNlladEdVclBBSWVjdVNNd2JwWkdLSTVoTGFrMlpTcEF2?=
 =?utf-8?B?NG1rdmkvVGxNcHhYOC9LNkZVWmVZOEhibU50OVRRTStRU0ROanRpQU1iK0FV?=
 =?utf-8?B?bVFoY1IvUkNzdDB5OGg5M01nVjdoei9xVEFnTGxLS3gweDV6cEJtVGJ2dmE3?=
 =?utf-8?B?VGdnQ2g3aEt1R0ZsYjFkTUgzdHJidnRDM2dkKzI3TFJZVWZjUFdZQm05YUVr?=
 =?utf-8?B?aEszbGRBTklVcmIzZ1RyaHZqcmRIeTFFWnc4TCs1TlBoRUF6WCtyQ21MRmRL?=
 =?utf-8?B?ZGo3MHJBbG15UGJnUEtNT3hpVDl4cUZiSFhhNytGVmRPeVpqcEU4aHBwMy9z?=
 =?utf-8?B?cDMxWE9lOU85SlFoeTlJRGdKS05mcTlBL3Q4TnJFZUMwQnJMT3R6SXU2T25J?=
 =?utf-8?B?ckZGdjYxZzVlN0loWXRyUU0zRXZBNGtXTFk3UTlYcWR6a1lQL3Era21NM3FI?=
 =?utf-8?B?YXJib21TYytoQ2krRGVWZ3l5ZEVVSmVmY3ZuTlVoM0s2dEFVdE1zTWM3Ni9l?=
 =?utf-8?B?WkQyZ3EvbEcyd0NNcldnUVdIbDJFNG1JbDQxam4vd3hjKytVd05oSWJxZHVi?=
 =?utf-8?B?MVcxUTRYK1dBY2cxTDF3UjdjeWZmWllrVHZOb0ZQUCtjYzd6T01iR1RkSVI4?=
 =?utf-8?B?eWF6NjdTN0lhTm9tQlRUNC9obnloWTNuUzhISHJGaE5aRHArdGZxMG9TdUVl?=
 =?utf-8?B?S3ExeTRwNWFoNmRkNmdsN2FSM1JDaU15TUVIME9reStNUU9MY2lsTVJDMEg1?=
 =?utf-8?B?elBienlmcitpaE9SVThUR2FGblBtdjl6UklDdlNDeWhLd2huYWRHbUlueWxL?=
 =?utf-8?B?NXZaUVVxOE1MTlI5VUV1eDZOWnhqc2M4cDhTdGlJMU1kS1pvWVVqMVpLamsv?=
 =?utf-8?B?ZTVxUW9rQ3lVWmh0R1A0MCthRDJEVFFTYzVKTkZja0VIYXJQRDNpTkQ3QW5j?=
 =?utf-8?B?Rmkvd0NRcm42TW8rSHliWm5rQm81SWFtTVBIclRVTloxQ3FlR3dQTG9qVDdT?=
 =?utf-8?B?YmJtMWNodDlpZERnaFNiM25ESExSN3lKR1B6ME0xWkFzZW96Z2haMlhxcWZX?=
 =?utf-8?B?RUFYSVZZU3hkaXVPVUVUcllNNmRtSVZjakYvSE9nV3ZzTVEvenM0RUJJaWk0?=
 =?utf-8?B?enUwcFU2MjhyUUdmaUxTUVBWUkVVRnh0ZXRhZDdLdWwwd0h5cEllYUJqOG1M?=
 =?utf-8?B?bGplN052VnJWOHNnMHJFcS9SZ1VSWkxmeXhGbzdUWXhOZFNUdURuN1QvbFBP?=
 =?utf-8?B?MTl1SWJ1TXRHRFNBRTQ1dlE5SkhMZmVpbTVOaW5peklLaXBraGFURW53U3Fy?=
 =?utf-8?Q?t5aCMoyO0mSOb5LNGt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5a5c40-99f4-4e2e-b119-08df3b48704e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 14:24:01.9043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gut7kjbd5NTDxIdvP6ityKol10YUxTqhhdwlguD9tphlt2DkWnJS3/tYyaeX9Zj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523

On 11/5/26 13:48, Philipp Stanner wrote:
> -Cc rust-for-linux, since it was typo'ed and now misses the thread anyways..
> 
> On Thu, 2026-11-05 at 13:35 +0100, Christian König wrote:
>> On 11/5/26 13:06, Tvrtko Ursulin wrote:
>>>
>>> [I aggresively rewrote the To: list because my SMTP won't let me
>>> send this as it was.]
>>>
>>> On 05/11/2026 11:35, Philipp Stanner wrote:
>>>> Currently, there are two init functions for dma_fence,
>>>> dma_fence_init()
>>>> and dma_fence_init64().
>>>>
>>>> Since more future user options for dma_fence initialization would
>>>> require distinct init functions, too, it is better to do this in
>>>> a
>>>> unified way.
>>>
>>> Why not add something like dma_fence_init_flags() and leave the 99%
>>> of the callers out of the (huge) diff? Ie. just port
>>> dma_fence_init64() to dma_fence_init_flags().
>>
>> Well one advantage of the Linux kernel is to avoid such wrappers. I
>> think having more than one function for the same thing basically just
>> adds more confusion.
> 
> Do you think all future users would want SEQNO64 by default, btw?

I was considering to invert the flag meaning, e.g. have SEQNO32 instead of SEQNO64.

But as I recently learned even on brand new x86 Intel CPUs you can do non 64bit aligned 64bit writes (yeah x86 architecture!) and PCIe devices see that as two 32bit writes to system memory which might or might not read coherently.

So assuming all future HW will be 64bit is clearly not possible.

>>
>> That's also why I would really like to just have one
>> dma_fence_signal() and not like five (or was it four?) variants.
> 
> It should be dma_fence_signal(fence, error), anihilating
> dma_fence_set_error(), which is just another massive incentive to add
> race conditions.

Yeah I'm largely in favor of that as well.

Regards,
Christian.

> 
> 
> P.

