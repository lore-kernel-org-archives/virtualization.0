Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794389983;
	b=bSWbYmI1kTjfsP/yyA1S7r0Ivtjc5qBCoW04hT3o6oHznQobr0FeZ5r3OrXA4WeLnHC/
	 aQLEAkfXRQ9F6QeJA8IueHrhnQ87fZN90T17OJhAXi9t8L5tkPSoMtaono2MJQqdFsANE
	 DW2aPo33fnBE6OUc4TtBVnOcLuJceCk76iSP5gm4VP4wLMhZfE3fStP0KnTgAcQh9ThGG
	 9nvrcv9QrBqbE+c272YDiiOCdh5MEBLXy7/qUIQ2viSkPAIBa5kSyV6V5P43OpFo3+UDJ
	 2sUGuPzzchzGvoNtADyjfd2yWKmauR9+SIz4nFg6jA68HZj6wcLfMk2aU33ZlJTtr+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389983;
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
	bh=OADNlzxOLEmHJL3G/edAJ3fJuoIxIe3Gd9gp9UaQebM=;
	b=KuFl0KcJW1DIF7TdlOb1bUmdswlDpmivtFOx9rB+P0BqOsS5yL9O6f2XDf1QwV3ZM5bp
	 a9ikzmOMXRXlR/CcOpcIMa2h5GWFWnkBL8e4qIBsY4ZvzrUwZ4mrbZOr5LlHcOsuOGhBk
	 kSt6rgRwPPcpxXxEZYzAX4PEM1ODsDneo7P420UEU/5Rq2RUurEAGvPBh2JGgvV+NVqqa
	 NlVpZIOFDnvIwbnQ0i2CtOAyG/ov87QAr7yAcpWl7fxZk29Qzu/7y1l24hJMTSmzpfZ6s
	 A/ZKTgv93UI88aiPx0lc62eY1uW+lsCZXeFSEDBwNeoHjFlF4FS6NU7wIecIEqBFacw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PjFixaF9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.62
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96E7606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 09:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E96E7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PjFixaF9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUEHqqB+JedF4QuQibQQ5Eus02LTPydFMowaO0/QjMzm9qawbP159T61Tnf8KPZvfYm8Ij9pPtTLXbvxzlIUHF5PGUQN5A2Sr0BM0UWVnBdOa1clBZaNL+aR/CBtQC/q/m184Rf+dDNygslPAgm8LIJLVXxnRfoS1dXJKmOLhZWeK1EwDHyaqmJHPjRsOCB2C9B1sHAl2D8A5YAOGiNoWhx6tgBacSQRpxtReZvXKnXnVaUsoKRJ/WtingjxuqT2v4nec02qz2XL/hwAmG1LXLnH5nb9dO2u0LzSUR+B9rSVjADResdtIpVkeCf5v2uGX+2P4Haf8BWbjylM1qwmJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OADNlzxOLEmHJL3G/edAJ3fJuoIxIe3Gd9gp9UaQebM=;
 b=f6qjMf9AjoDtgxstU/z0WxC2T2PH1ZISpAYs7j85jpLXVS8V3s1Q27io57y27kB+IuMVF4ki89Bnpf++khxllB2hVdIptZuR2HW0llCmaRBJL8I8b+4DWiH9oyOlEf+vWn4OOtEJlFLMFEwzWmvApZU17qTi8movVWuH49ZQiDyHB7uRbMFZfcsiHzy/4LhmKjQQmPN0X84JAyxdy3rmDwBBiTKWdY1hs+rd9kt4WYTxsAcKOywRGCfkhYF5c4AaW6zWYCdpTCWzZnw/rF6qzW+PqeDccbW2d0i9sBzYyzikcA8hmBUqe3D1s+x5pZ8Ug8XFfRy1yuAByZRmkbOIHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OADNlzxOLEmHJL3G/edAJ3fJuoIxIe3Gd9gp9UaQebM=;
 b=PjFixaF9xaOSSmWTTDoz7XvnKGCsROVYtpgq6d6IDLk01MIbxHvDz4Q5q2Hy2S/Ye3CbXRx2W3nA2PwT+mBg3Z6nx7BoV3MpBKqStShJoUEelmSPSo3H0d0O16SEXHT/00/p7hGKDSNwJnj/o+pDVWNv4uqYJrLAct2d/ppJef4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB5635.namprd12.prod.outlook.com (2603:10b6:a03:42a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 09:39:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 09:39:37 +0000
Message-ID: <227cad9e-84e4-4e91-9a6b-0993c6807081@amd.com>
Date: Wed, 11 Nov 2026 10:39:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dma-buf: dma-fence: Add flags parameter to
 dma_fence_init()
To: Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 imagination@lists.freedesktop.org, lima@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-usb@vger.kernel.org, rust-for-linux@vger.kernel.or
References: <20261105113529.1989375-2-phasta@kernel.org>
 <20261105113529.1989375-3-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261105113529.1989375-3-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:208:23d::24) To PH7PR12MB5685.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ac6a82-8e84-4a02-1f89-08df3fd7b355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|4143699003|261009223027099003|261026121527099003|260925021311599003|260925021911599003|260925022911599003|56012099006|11063799006|261028144727099003|261021130227099003|261021133027099003|261026130827099003|261021121427099003|261021123027099003|261022075727099003|261021135927099003|261022113327099003|261009221227099003|261022115727099003|261026135527099003|261026140227099003|261022105027099003|10067099003|261102130727099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	PTyaggMbGArnQrpUFjLhZW0zcnVNaWxMe5d/8bd2tGtFUP0TD9O/HLl/+I3NpnPgN1wKJBrSixAh0KK+D/M9KYtmaMfifMl0jsOngTJ4wKB9+TYzfUvCV3ZIykwxg5apdXreBy7zo811PwFMvlRrPvSvQkJFv0s6ph0MJkqY4bik09xsPs0+2nC/5/laHXgDaSlju0yq9Z9rWG7Sz6wJUOknBc2uRKeK0uJY+PFEWU8JANEpFJ25ksMMnxU/UGWe6EP0+bgIGCAE8mBIEORTaOclItCTMIzK3Hka1wFyr2ksNuSAZj0W85irOWCC2GPSPGd5UKQigC8HGHt3fWM9ixWCzlaS2MKmk9XehiMvbuJ3ajgFVO/V6vdaxCqGN7nbG3AOHcnQgzXvXmlZ1WkV0TkXaDT2wp454tr8usCQEvqbWlseh28N1FNdlSx0yKedtstrI/j3GiVtsWEyRIdQyi8jfZmCZvqAlBV5CFN97S4hOKxpIccgalM7IFd8G6IoRp4Z6SR9J4q+qJmk8J6qr+qADgWqQkSMTPofhyQmjsE+xt/k8GzyFOLFxw75g8RtHgALnAD23RB9f4xwsU/7iEuaJqDvywaTBkgdbZEvp1oNeVygTMMYxUJYJHElnl5Ny7RD38Ld460bbqJvOmbqLgAKeW3nstglifyNBj/hjik=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(4143699003)(261009223027099003)(261026121527099003)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(11063799006)(261028144727099003)(261021130227099003)(261021133027099003)(261026130827099003)(261021121427099003)(261021123027099003)(261022075727099003)(261021135927099003)(261022113327099003)(261009221227099003)(261022115727099003)(261026135527099003)(261026140227099003)(261022105027099003)(10067099003)(261102130727099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFJjemFqdXZhWHNuaVFIZnJTNlhid25mUnoyNFNPTXJsTnBxYll1ekNPTVhB?=
 =?utf-8?B?RXdrS0pZRHhSL1ltejF3OWNoNC9KbXJ6L1dacUw1VndENjhWbjViM0ZRSlNX?=
 =?utf-8?B?SmVDS1VCc2Q2WkJlUm8rb3Vtb3NoblZDeWRDbHZnQVNMU2p2a09kWHRveDhP?=
 =?utf-8?B?MHZweW1sYWRHTmtkVmRzUG9QcnU0bURaUU5rMjJNa0RYUGxJRE14eU9hTmhQ?=
 =?utf-8?B?RXpaZnRtOHFTN0JPMzNhankrQ2Z0TE9qM3NUVXROdUYrZVdnMmx6eDV2OS9a?=
 =?utf-8?B?TXhYSGxmTEwvQm4xOE5vc2V5OEVBUkZHZTBCQWc4ZG1HMm5rK3UzQnlCejY4?=
 =?utf-8?B?ZnFIOFRrY29SZnBZOERNOHZQa1lYeHhnQjIvczNBUm44cGJ1cFFpSXRXSnVN?=
 =?utf-8?B?VjlFVTlMeHZRNTY3Uko4RG5qVEtNeTUvUFFSL3NJd0JodStwcGlJRUhLelRq?=
 =?utf-8?B?RWNlZU1IRDg3Sk9DaEQ2QXFOWlQzT3FvaGNvUDBnaG5pL0k5a2xRNjAySUZM?=
 =?utf-8?B?Y2VMUU1VWTYvbTVqVDVYOHhhT2hoRlFiNXB2Ly9ONDJnYnNSbmxHK2ZLdjdJ?=
 =?utf-8?B?Tlp3WUE3ejdkSVJrcEtTeEZ0eUJFNDREUFQwUWpTQzI2OTRkSWNPbllGSUcy?=
 =?utf-8?B?a0ZGZldwWGtUa0U4NS9TS3p5REthN0FUSUtIR3U5bEZ6WWpDL2NadEd0OTIx?=
 =?utf-8?B?anRyOGN1Z0EvRTFhN2p4by9teHZmK3NJUHhEYjNEVWYvSDV3dEFwc25SQ1Ro?=
 =?utf-8?B?eG5JSEYzTDExUzJWcHR1b3BkS1p2YnJ5MkZUNEc4eTg5c3NKQ1NzeUtQTFU0?=
 =?utf-8?B?bm1oOEsxY29oaUl6c292NVRvTktzcWZGK3RpaGJvWU50dy9OYjQyUnZ1blpP?=
 =?utf-8?B?MDlpK3c4UHIvckxGWmtCRHpsK1NoTkM1ZFBGYlQ3UHdGOWNMUU5VWmM2OHcy?=
 =?utf-8?B?OXg0MVZ5d3RVU3VvMGJ6ZWFmL2RNOWg2THR0aTVxVUVGTDA0cUl3aXVNbUt5?=
 =?utf-8?B?SHlVeGlvUnA0ZlQzL0JEL3VwNlFnb2RUem5BMVpveVFoY2dBaGRaU29PR2h0?=
 =?utf-8?B?Vkk4Q3pmQU5BSUhENGdhSW9VRGZpSXJuYk4xenhoc1ovZndVZUR2N0FkK25G?=
 =?utf-8?B?dWp0Vm5nNWNsLys5TWluSzY5YjlTQ200UWoyYW5FR1dVN0VaUVNhMG1Db2Zx?=
 =?utf-8?B?YzJSNE5kaVpGenQwY0I4WFQ1K2ExeTVFREJxNWNRMitBTnlSd29Qdzc1d0lP?=
 =?utf-8?B?Qi84aHZNSnYrYmJBdFJRbzYwS200c2hhNEtNUzdZZlk5ZkVUTVFKZkluSmRB?=
 =?utf-8?B?UmE0ZlFtNG9NYlR2czVsdGNoY3A5VkIrUjdDelhlaVBKc2VpWC9SbGtpTURI?=
 =?utf-8?B?ZXNGNXp6TDE4bnlhUjNhK055ZERPYVEvV3RWVlE1M2FjTXY4amM2QnE5OFlB?=
 =?utf-8?B?cmcvQW5IRy83K2hPRjRYSzhwK0JVUEpDSHVqVUFuUVpnR0xXM3U1M2JaK2Uv?=
 =?utf-8?B?Mi9INnd2QU1Md1ZzSDZrTG5UMzhUL0NqZUVSQnFSdlFLT2RWMGNueHZUeGNO?=
 =?utf-8?B?K2hha2hCOEJUV2xBRG9FYXg0ZUh3OE9PYnZVK3BiWE9oOW9VR1VQQmpPK0Z3?=
 =?utf-8?B?TWhySXo0UTE1NTVYT2plWndCN3JSMmxGTDQycFQwWE42bzAzRTFtODh5VVEw?=
 =?utf-8?B?OVhyRzVmdGRqMElKdm1XbExkVHJYYWZnWUZKaVVKREhTdzVlaXN1TnhvWmlx?=
 =?utf-8?B?OHZzMG9oYVNnTFRaZ0VZR3ZzNmxsZEVWdi80cUljZ1Y0TFRCdTZKYUllaWlC?=
 =?utf-8?B?N2swVjNQdWZMakE5dnFRSE95UzZkUEVIVGJjTG5MaloxRDVkRng1MG4yLzd6?=
 =?utf-8?B?QmpmWC82cjNJZmsybGd1c21nRzRva0F0SnBGU2FaUlJlRzgrazdYR0ZEaGw0?=
 =?utf-8?B?UU9RZ3VVZFFKM3h2TE9vL2MyS0JybVpGVk5GTXM5UndtU3l0VFNUVmQ3TUhH?=
 =?utf-8?B?WmZmNlgyUU92S3doTHg5OFRFYVRmNzdFNkFGcThzY3V4dmNUMDJNTVpxc0tp?=
 =?utf-8?B?bUhPL3RsZ1JSZmF5ZlNJb3d6VFBRSFRWZFV3VitBRXJHM0NoRXVkMCtVY3JC?=
 =?utf-8?B?ek5WbWRqckt1RUExNEorc1hMeTVCWitNYUhBSEdDOGVwVmtmRGlzUE5xYkV0?=
 =?utf-8?B?c2ZEYWZhUnRGSjNEZTFvQzduWnlqTTEzdTQ5RURBVXQ3b3VleUY5YzErakNs?=
 =?utf-8?B?OFVLNGZiUzVDYk0wM25QU016M0EzVnJOSFhmckM1VlFLTXRqNFVHTG1kcVhZ?=
 =?utf-8?Q?yGbKs0N5op1QE11vAM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ac6a82-8e84-4a02-1f89-08df3fd7b355
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:39:37.1179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMxGDyDbg02/CJjsJLdAK6Q5ceUvOc7d5LZwDHrVP45xUhaPtMFikNvA+SST8hd/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5635

On 11/5/26 12:35, Philipp Stanner wrote:
...>  
> +static bool dma_fence_flags_invalid(unsigned long flags)

I think dma_fence_are_flags_valid() would match the kernel naming style better.

But that is only a nit pick. With or without the name changed Reviewed-by: Christian König <christian.koenig@amd.com> for the entire series.

Feel free to push to drm-misc-next or ping me when I should.

Thanks,
Christian.

> +{
> +	const unsigned long valid_fence_bits =
> +		BIT(DMA_FENCE_FLAG_SEQNO64_BIT);
> +	const unsigned long valid_user_bits =
> +		GENMASK(
> +			BITS_PER_TYPE(unsigned long) - 1,
> +			DMA_FENCE_FLAG_USER_BITS
> +		       );
> +	const unsigned long invalid_bits =
> +		~(valid_fence_bits | valid_user_bits);
> +
> +	return flags & invalid_bits;
> +}
> +
>  /**
>   * dma_fence_init - Initialize a custom fence.
>   * @fence: the fence to initialize
> @@ -1094,6 +1108,7 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>   * @lock: optional irqsafe spinlock to use for locking this fence
>   * @context: the execution context this fence is run on
>   * @seqno: a linear increasing sequence number for this context
> + * @flags: flags modifying a fence's behavior
>   *
>   * Initializes an allocated fence, the caller doesn't have to keep its
>   * refcount after committing with this fence, but it will need to hold a
> @@ -1108,12 +1123,18 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>   * introduction of the callback, but the external lock is still around. New
>   * users MUST NOT use external locks, as they force the issuer to outlive all
>   * fences that reference the lock.
> + *
> + * The @flags you can specify here are either DMA_FENCE_FLAG_SEQNO64_BIT or
> + * user-specified bits >= DMA_FENCE_FLAG_USER_BITS.
>   */
>  void
>  dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
> -	       spinlock_t *lock, u64 context, u64 seqno)
> +	       spinlock_t *lock, u64 context, u64 seqno,
> +	       unsigned long flags)
>  {
> -	__dma_fence_init(fence, ops, lock, context, seqno, 0UL);
> +	WARN_ON(dma_fence_flags_invalid(flags));
> +
> +	__dma_fence_init(fence, ops, lock, context, seqno, flags);
>  }
>  EXPORT_SYMBOL(dma_fence_init);
>  
> diff --git a/drivers/dma-buf/st-dma-fence-chain.c b/drivers/dma-buf/st-dma-fence-chain.c
> index e0d9b69bfa76..b9610df3ff19 100644
> --- a/drivers/dma-buf/st-dma-fence-chain.c
> +++ b/drivers/dma-buf/st-dma-fence-chain.c
> @@ -52,7 +52,7 @@ static struct dma_fence *mock_fence(void)
>  		return NULL;
>  
>  	spin_lock_init(&f->lock);
> -	dma_fence_init(&f->base, &mock_ops, &f->lock, 0, 0);
> +	dma_fence_init(&f->base, &mock_ops, &f->lock, 0, 0, 0);
>  
>  	return &f->base;
>  }
> diff --git a/drivers/dma-buf/st-dma-fence-unwrap.c b/drivers/dma-buf/st-dma-fence-unwrap.c
> index c5353b36f0e4..dbebc3046d42 100644
> --- a/drivers/dma-buf/st-dma-fence-unwrap.c
> +++ b/drivers/dma-buf/st-dma-fence-unwrap.c
> @@ -36,7 +36,7 @@ static struct dma_fence *__mock_fence(u64 context, u64 seqno)
>  		return NULL;
>  
>  	spin_lock_init(&f->lock);
> -	dma_fence_init(&f->base, &mock_ops, &f->lock, context, seqno);
> +	dma_fence_init(&f->base, &mock_ops, &f->lock, context, seqno, 0);
>  
>  	return &f->base;
>  }
> diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fence.c
> index cb62e606d0a2..b3f88e89cc44 100644
> --- a/drivers/dma-buf/st-dma-fence.c
> +++ b/drivers/dma-buf/st-dma-fence.c
> @@ -31,7 +31,7 @@ static struct dma_fence *mock_fence(void)
>  	if (!f)
>  		return NULL;
>  
> -	dma_fence_init(f, &mock_ops, NULL, 0, 0);
> +	dma_fence_init(f, &mock_ops, NULL, 0, 0, 0);
>  	return f;
>  }
>  
> diff --git a/drivers/dma-buf/st-dma-resv.c b/drivers/dma-buf/st-dma-resv.c
> index 0b96136bbd54..c3a920ab3fcf 100644
> --- a/drivers/dma-buf/st-dma-resv.c
> +++ b/drivers/dma-buf/st-dma-resv.c
> @@ -35,7 +35,7 @@ static struct dma_fence *alloc_fence(void)
>  	if (!f)
>  		return NULL;
>  
> -	dma_fence_init(f, &fence_ops, &fence_lock, 0, 0);
> +	dma_fence_init(f, &fence_ops, &fence_lock, 0, 0, 0);
>  	return f;
>  }
>  
> diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
> index 8df20b0218a9..ce43af7e735e 100644
> --- a/drivers/dma-buf/sw_sync.c
> +++ b/drivers/dma-buf/sw_sync.c
> @@ -258,7 +258,7 @@ static struct sync_pt *sync_pt_create(struct sync_timeline *obj,
>  
>  	sync_timeline_get(obj);
>  	dma_fence_init(&pt->base, &timeline_fence_ops, &obj->lock,
> -		       obj->context, value);
> +		       obj->context, value, 0);
>  	INIT_LIST_HEAD(&pt->link);
>  
>  	spin_lock_irq(&obj->lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> index 9b10d015671c..30ccdb3e0b47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> @@ -77,7 +77,7 @@ struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
>  	spin_lock_init(&fence->lock);
>  	fence->context_id = context_id;
>  	dma_fence_init(&fence->base, &amdkfd_fence_ops, &fence->lock,
> -		   context, atomic_inc_return(&fence_seq));
> +		   context, atomic_inc_return(&fence_seq), 0);
>  
>  	return fence;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index bff2d38f3571..03e1974f8dda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -112,7 +112,7 @@ void amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
>  	seq = ++ring->fence_drv.sync_seq;
>  	dma_fence_init(fence, &amdgpu_fence_ops,
>  		       &ring->fence_drv.lock,
> -		       adev->fence_context + ring->idx, seq);
> +		       adev->fence_context + ring->idx, seq, 0);
>  
>  	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>  			       seq, flags | AMDGPU_FENCE_FLAG_INT);
> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index 63ead8ba6756..92641bc0a378 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -190,7 +190,7 @@ struct dma_fence *drm_crtc_create_fence(struct drm_crtc *crtc)
>  		return NULL;
>  
>  	dma_fence_init(fence, &drm_crtc_fence_ops, &crtc->fence_lock,
> -		       crtc->fence_context, ++crtc->fence_seqno);
> +		       crtc->fence_context, ++crtc->fence_seqno, 0);
>  
>  	return fence;
>  }
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> index b4a002e6d043..64b06b890f19 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -592,7 +592,7 @@ drm_writeback_get_out_fence(struct drm_writeback_connector *wb_connector)
>  
>  	dma_fence_init(fence, &drm_writeback_fence_ops,
>  		       &wb_connector->fence_lock, wb_connector->fence_context,
> -		       ++wb_connector->fence_seqno);
> +		       ++wb_connector->fence_seqno, 0);
>  
>  	return fence;
>  }
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index e75dab5e407d..a10e4e4cf372 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1199,7 +1199,7 @@ static struct dma_fence *etnaviv_gpu_fence_alloc(struct etnaviv_gpu *gpu)
>  	f->gpu = gpu;
>  
>  	dma_fence_init(&f->base, &etnaviv_fence_ops, &gpu->fence_spinlock,
> -		       gpu->fence_context, ++gpu->next_fence);
> +		       gpu->fence_context, ++gpu->next_fence, 0);
>  
>  	return &f->base;
>  }
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
> index 56489cc127d6..ffaa70191f27 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
> @@ -437,7 +437,7 @@ i915_ttm_memcpy_work_arm(struct i915_ttm_memcpy_work *work,
>  	int ret;
>  
>  	spin_lock_init(&work->lock);
> -	dma_fence_init(&work->fence, &dma_fence_memcpy_ops, &work->lock, 0, 0);
> +	dma_fence_init(&work->fence, &dma_fence_memcpy_ops, &work->lock, 0, 0, 0);
>  	dma_fence_get(&work->fence);
>  	ret = dma_fence_add_callback(dep, &work->cb, __memcpy_cb);
>  	if (ret) {
> diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
> index f66f8efc7062..0f4fc9cc0033 100644
> --- a/drivers/gpu/drm/i915/i915_request.c
> +++ b/drivers/gpu/drm/i915/i915_request.c
> @@ -953,7 +953,7 @@ __i915_request_create(struct intel_context *ce, gfp_t gfp)
>  		goto err_free;
>  
>  	dma_fence_init(&rq->fence, &i915_fence_ops, &rq->lock,
> -		       tl->fence_context, seqno);
> +		       tl->fence_context, seqno, 0);
>  
>  	RCU_INIT_POINTER(rq->timeline, tl);
>  	rq->hwsp_seqno = tl->hwsp_seqno;
> diff --git a/drivers/gpu/drm/i915/i915_sw_fence_work.c b/drivers/gpu/drm/i915/i915_sw_fence_work.c
> index 366418108f78..4cd44dd26e35 100644
> --- a/drivers/gpu/drm/i915/i915_sw_fence_work.c
> +++ b/drivers/gpu/drm/i915/i915_sw_fence_work.c
> @@ -85,7 +85,7 @@ void dma_fence_work_init(struct dma_fence_work *f,
>  {
>  	f->ops = ops;
>  	spin_lock_init(&f->lock);
> -	dma_fence_init(&f->dma, &fence_ops, &f->lock, 0, 0);
> +	dma_fence_init(&f->dma, &fence_ops, &f->lock, 0, 0, 0);
>  	i915_sw_fence_init(&f->chain, fence_notify);
>  	INIT_WORK(&f->work, fence_work);
>  }
> diff --git a/drivers/gpu/drm/i915/i915_vma_resource.c b/drivers/gpu/drm/i915/i915_vma_resource.c
> index a8f2112ce81f..19596410e32f 100644
> --- a/drivers/gpu/drm/i915/i915_vma_resource.c
> +++ b/drivers/gpu/drm/i915/i915_vma_resource.c
> @@ -263,7 +263,7 @@ void __i915_vma_resource_init(struct i915_vma_resource *vma_res)
>  {
>  	spin_lock_init(&vma_res->lock);
>  	dma_fence_init(&vma_res->unbind_fence, &unbind_fence_ops,
> -		       &vma_res->lock, 0, 0);
> +		       &vma_res->lock, 0, 0, 0);
>  	refcount_set(&vma_res->hold_count, 1);
>  	i915_sw_fence_init(&vma_res->chain, i915_vma_resource_fence_notify);
>  }
> diff --git a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
> index ecb2d718f6a6..d8d4f7057031 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
> @@ -641,7 +641,7 @@ static struct dma_fence *alloc_dma_fence(void)
>  
>  	dma = kmalloc_obj(*dma);
>  	if (dma)
> -		dma_fence_init(dma, &mock_fence_ops, &mock_fence_lock, 0, 0);
> +		dma_fence_init(dma, &mock_fence_ops, &mock_fence_lock, 0, 0, 0);
>  
>  	return dma;
>  }
> diff --git a/drivers/gpu/drm/imagination/pvr_ccb.c b/drivers/gpu/drm/imagination/pvr_ccb.c
> index e408df74853d..7043b491fe54 100644
> --- a/drivers/gpu/drm/imagination/pvr_ccb.c
> +++ b/drivers/gpu/drm/imagination/pvr_ccb.c
> @@ -645,7 +645,7 @@ pvr_kccb_reserve_slot(struct pvr_device *pvr_dev, struct dma_fence *f)
>  		dma_fence_init(&fence->base, &pvr_kccb_fence_ops,
>  			       &pvr_dev->kccb.fence_ctx.lock,
>  			       pvr_dev->kccb.fence_ctx.id,
> -			       atomic_inc_return(&pvr_dev->kccb.fence_ctx.seqno));
> +			       atomic_inc_return(&pvr_dev->kccb.fence_ctx.seqno), 0);
>  		out_fence = dma_fence_get(&fence->base);
>  		list_add_tail(&fence->node, &pvr_dev->kccb.waiters);
>  	} else {
> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
> index 24a8645aa913..34b826381aa2 100644
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
> @@ -305,7 +305,7 @@ pvr_queue_fence_init(struct dma_fence *f,
>  	INIT_WORK(&fence->release_work, pvr_queue_fence_release_work);
>  	dma_fence_init(&fence->base, fence_ops,
>  		       &fence_ctx->lock, fence_ctx->id,
> -		       atomic_inc_return(&fence_ctx->seqno));
> +		       atomic_inc_return(&fence_ctx->seqno), 0);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
> index 9a1e6b9ecbe5..fee595b9629a 100644
> --- a/drivers/gpu/drm/lima/lima_sched.c
> +++ b/drivers/gpu/drm/lima/lima_sched.c
> @@ -97,7 +97,7 @@ static struct lima_fence *lima_fence_create(struct lima_sched_pipe *pipe)
>  
>  	fence->pipe = pipe;
>  	dma_fence_init(&fence->base, &lima_fence_ops, &pipe->fence_lock,
> -		       pipe->fence_context, ++pipe->fence_seqno);
> +		       pipe->fence_context, ++pipe->fence_seqno, 0);
>  
>  	return fence;
>  }
> diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_fence.c
> index 3dca8e09c192..1ec59919c32e 100644
> --- a/drivers/gpu/drm/msm/msm_fence.c
> +++ b/drivers/gpu/drm/msm/msm_fence.c
> @@ -197,5 +197,5 @@ msm_fence_init(struct dma_fence *fence, struct msm_fence_context *fctx)
>  	WARN_ON(kref_read(&fence->refcount));
>  
>  	dma_fence_init(&f->base, &msm_fence_ops, &fctx->spinlock,
> -		       fctx->context, ++fctx->last_fence);
> +		       fctx->context, ++fctx->last_fence, 0);
>  }
> diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
> index 11e95c37ce50..97e20954c71b 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_fence.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
> @@ -216,10 +216,10 @@ nouveau_fence_emit(struct nouveau_fence *fence)
>  
>  	if (priv->uevent)
>  		dma_fence_init(&fence->base, &nouveau_fence_ops_uevent,
> -			       &fctx->lock, fctx->context, ++fctx->sequence);
> +			       &fctx->lock, fctx->context, ++fctx->sequence, 0);
>  	else
>  		dma_fence_init(&fence->base, &nouveau_fence_ops_legacy,
> -			       &fctx->lock, fctx->context, ++fctx->sequence);
> +			       &fctx->lock, fctx->context, ++fctx->sequence, 0);
>  	kref_get(&fctx->fence_ref);
>  
>  	ret = fctx->emit(fence);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index 4ddf4b722ddf..de242d275978 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -105,7 +105,7 @@ static struct dma_fence *panfrost_fence_create(struct panfrost_device *pfdev, in
>  	fence->queue = js_num;
>  	fence->seqno = ++js->queue[js_num].emit_seqno;
>  	dma_fence_init(&fence->base, &panfrost_fence_ops, &js->job_lock,
> -		       js->queue[js_num].fence_context, fence->seqno);
> +		       js->queue[js_num].fence_context, fence->seqno, 0);
>  
>  	return &fence->base;
>  }
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index a343c5180e01..c46f69ade7a0 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3322,7 +3322,7 @@ queue_run_job(struct drm_sched_job *sched_job)
>  		       &panthor_queue_fence_ops,
>  		       &queue->fence_ctx.lock,
>  		       queue->fence_ctx.id,
> -		       atomic64_inc_return(&queue->fence_ctx.seqno));
> +		       atomic64_inc_return(&queue->fence_ctx.seqno), 0);
>  
>  	job->profiling.slot = queue->profiling.seqno++;
>  	if (queue->profiling.seqno == queue->profiling.slot_count)
> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
> index 06979d0e8a9f..2608d82f7370 100644
> --- a/drivers/gpu/drm/qxl/qxl_release.c
> +++ b/drivers/gpu/drm/qxl/qxl_release.c
> @@ -430,7 +430,7 @@ void qxl_release_fence_buffer_objects(struct qxl_release *release)
>  	 * set the highest bits. This will break if we really allow exporting of dma-bufs.
>  	 */
>  	dma_fence_init(&release->base, &qxl_fence_ops, &qdev->release_lock,
> -		       release->id | 0xf0000000, release->base.seqno);
> +		       release->id | 0xf0000000, release->base.seqno, 0);
>  	trace_dma_fence_emit(&release->base);
>  
>  	list_for_each_entry(entry, &release->bos, list) {
> diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
> index 8e9402b8811b..1360b5215f5e 100644
> --- a/drivers/gpu/drm/radeon/radeon_fence.c
> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
> @@ -148,7 +148,7 @@ int radeon_fence_emit(struct radeon_device *rdev,
>  	dma_fence_init(&(*fence)->base, &radeon_fence_ops,
>  		       &rdev->fence_queue.lock,
>  		       rdev->fence_context + ring,
> -		       seq);
> +		       seq, 0);
>  	radeon_fence_ring_emit(rdev, ring, *fence);
>  	trace_radeon_fence_emit(rdev_to_drm(rdev), ring, (*fence)->seq);
>  	radeon_fence_schedule_check(rdev, ring);
> diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
> index b7a4cb921234..94ba0cf4fe02 100644
> --- a/drivers/gpu/drm/scheduler/sched_fence.c
> +++ b/drivers/gpu/drm/scheduler/sched_fence.c
> @@ -229,9 +229,9 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
>  	fence->sched = entity->rq->sched;
>  	seq = atomic_inc_return(&entity->fence_seq);
>  	dma_fence_init(&fence->scheduled, &drm_sched_fence_ops_scheduled,
> -		       &fence->lock, entity->fence_context, seq);
> +		       &fence->lock, entity->fence_context, seq, 0);
>  	dma_fence_init(&fence->finished, &drm_sched_fence_ops_finished,
> -		       &fence->lock, entity->fence_context + 1, seq);
> +		       &fence->lock, entity->fence_context + 1, seq, 0);
>  }
>  
>  module_init(drm_sched_fence_slab_init);
> diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> index 2dfa3efef210..169792a4b329 100644
> --- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> @@ -173,7 +173,7 @@ static struct dma_fence *mock_sched_run_job(struct drm_sched_job *sched_job)
>  		       &drm_mock_sched_hw_fence_ops,
>  		       &sched->lock,
>  		       sched->hw_timeline.context,
> -		       atomic_inc_return(&sched->hw_timeline.next_seqno));
> +		       atomic_inc_return(&sched->hw_timeline.next_seqno), 0);
>  
>  	dma_fence_get(&job->hw_fence); /* Reference for the job_list */
>  
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
> index f3103307b5df..633cc7458505 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
> @@ -450,7 +450,7 @@ static void ttm_bo_fini_shared_resv(struct kunit *test)
>  	KUNIT_ASSERT_NOT_NULL(test, fence);
>  
>  	spin_lock_init(&fence_lock);
> -	dma_fence_init(fence, &mock_fence_ops, &fence_lock, 0, 0);
> +	dma_fence_init(fence, &mock_fence_ops, &fence_lock, 0, 0, 0);
>  
>  	dma_resv_lock(external_resv, NULL);
>  	dma_resv_reserve_fences(external_resv, 1);
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> index 56ad8ef32584..e22a1335f166 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> @@ -57,7 +57,7 @@ static struct dma_fence *alloc_mock_fence(struct kunit *test)
>  	fence = kunit_kzalloc(test, sizeof(*fence), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, fence);
>  
> -	dma_fence_init(fence, &fence_ops, &fence_lock, 0, 0);
> +	dma_fence_init(fence, &fence_ops, &fence_lock, 0, 0, 0);
>  
>  	return fence;
>  }
> diff --git a/drivers/gpu/drm/v3d/v3d_fence.c b/drivers/gpu/drm/v3d/v3d_fence.c
> index c500136d0455..1fdba5a21580 100644
> --- a/drivers/gpu/drm/v3d/v3d_fence.c
> +++ b/drivers/gpu/drm/v3d/v3d_fence.c
> @@ -16,7 +16,7 @@ struct dma_fence *v3d_fence_create(struct v3d_dev *v3d, enum v3d_queue q)
>  	fence->queue = q;
>  	fence->seqno = ++queue->emit_seqno;
>  	dma_fence_init(&fence->base, &v3d_fence_ops, &queue->queue_lock,
> -		       queue->fence_context, fence->seqno);
> +		       queue->fence_context, fence->seqno, 0);
>  
>  	return &fence->base;
>  }
> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
> index ff611c618d6b..420988d516c1 100644
> --- a/drivers/gpu/drm/vc4/vc4_gem.c
> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
> @@ -648,7 +648,7 @@ vc4_queue_submit(struct drm_device *dev, struct vc4_exec_info *exec,
>  	exec->seqno = seqno;
>  
>  	dma_fence_init(&fence->base, &vc4_fence_ops, &vc4->job_lock,
> -		       vc4->dma_fence_context, exec->seqno);
> +		       vc4->dma_fence_context, exec->seqno, 0);
>  	fence->seqno = exec->seqno;
>  	exec->fence = &fence->base;
>  
> diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
> index 0e53ba7db629..18700e5f9167 100644
> --- a/drivers/gpu/drm/vgem/vgem_fence.c
> +++ b/drivers/gpu/drm/vgem/vgem_fence.c
> @@ -77,7 +77,7 @@ static struct dma_fence *vgem_fence_create(struct vgem_file *vfile,
>  
>  	spin_lock_init(&fence->lock);
>  	dma_fence_init(&fence->base, &vgem_fence_ops, &fence->lock,
> -		       dma_fence_context_alloc(1), 1);
> +		       dma_fence_context_alloc(1), 1, 0);
>  
>  	timer_setup(&fence->timer, vgem_fence_timeout, TIMER_IRQSAFE);
>  
> diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
> index c3e66ef2133a..8e469391d2e4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_fence.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
> @@ -76,7 +76,7 @@ struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *vgdev,
>  	 */
>  
>  	dma_fence_init(&fence->f, &virtio_gpu_fence_ops, &drv->lock,
> -		       fence_context, 0);
> +		       fence_context, 0, 0);
>  
>  	return fence;
>  }
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> index 384c6736cf6b..15f355dc6881 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> @@ -163,7 +163,7 @@ static int vmw_fence_obj_init(struct vmw_fence_manager *fman,
>  	int ret = 0;
>  
>  	dma_fence_init(&fence->base, &vmw_fence_ops, &fman->lock,
> -		       fman->ctx, seqno);
> +		       fman->ctx, seqno, 0);
>  	fence->destroy = destroy;
>  
>  	spin_lock(&fman->lock);
> diff --git a/drivers/gpu/drm/xe/xe_hw_fence.c b/drivers/gpu/drm/xe/xe_hw_fence.c
> index 14720623ad00..30bfc42972e0 100644
> --- a/drivers/gpu/drm/xe/xe_hw_fence.c
> +++ b/drivers/gpu/drm/xe/xe_hw_fence.c
> @@ -243,7 +243,7 @@ void xe_hw_fence_init(struct dma_fence *fence, struct xe_hw_fence_ctx *ctx,
>  	INIT_LIST_HEAD(&hw_fence->irq_link);
>  
>  	dma_fence_init(fence, &xe_hw_fence_ops, &ctx->irq->lock,
> -		       ctx->dma_fence_ctx, ctx->next_seqno++);
> +		       ctx->dma_fence_ctx, ctx->next_seqno++, 0);
>  
>  	trace_xe_hw_fence_create(hw_fence);
>  }
> diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
> index c9320feeafba..912840eeec50 100644
> --- a/drivers/gpu/drm/xe/xe_oa.c
> +++ b/drivers/gpu/drm/xe/xe_oa.c
> @@ -1053,7 +1053,7 @@ static int xe_oa_emit_oa_config(struct xe_oa_stream *stream, struct xe_oa_config
>  
>  	/* Point of no return: initialize and set fence to signal */
>  	spin_lock_init(&ofence->lock);
> -	dma_fence_init(&ofence->base, &xe_oa_fence_ops, &ofence->lock, 0, 0);
> +	dma_fence_init(&ofence->base, &xe_oa_fence_ops, &ofence->lock, 0, 0, 0);
>  
>  	for (i = 0; i < stream->num_syncs; i++) {
>  		if (stream->syncs[i].flags & DRM_XE_SYNC_FLAG_SIGNAL)
> diff --git a/drivers/gpu/drm/xe/xe_preempt_fence.c b/drivers/gpu/drm/xe/xe_preempt_fence.c
> index 4aa570fe745d..343f1ba1e1cd 100644
> --- a/drivers/gpu/drm/xe/xe_preempt_fence.c
> +++ b/drivers/gpu/drm/xe/xe_preempt_fence.c
> @@ -154,7 +154,7 @@ xe_preempt_fence_arm(struct xe_preempt_fence *pfence, struct xe_exec_queue *q,
>  	pfence->q = xe_exec_queue_get(q);
>  	spin_lock_init(&pfence->lock);
>  	dma_fence_init(&pfence->base, &preempt_fence_ops,
> -		      &pfence->lock, context, seqno);
> +		      &pfence->lock, context, seqno, 0);
>  
>  	return &pfence->base;
>  }
> diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
> index c9cc5842d65b..1fd39434dc0e 100644
> --- a/drivers/gpu/drm/xe/xe_tlb_inval.c
> +++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
> @@ -544,7 +544,7 @@ void xe_tlb_inval_fence_init(struct xe_tlb_inval *tlb_inval,
>  
>  	spin_lock_irq(&tlb_inval->lock);
>  	dma_fence_init(&fence->base, &inval_fence_ops, &tlb_inval->lock,
> -		       dma_fence_context_alloc(1), 1);
> +		       dma_fence_context_alloc(1), 1, 0);
>  	spin_unlock_irq(&tlb_inval->lock);
>  	INIT_LIST_HEAD(&fence->link);
>  	if (stack)
> diff --git a/drivers/gpu/host1x/fence.c b/drivers/gpu/host1x/fence.c
> index 1acf579c562b..7e074e72a055 100644
> --- a/drivers/gpu/host1x/fence.c
> +++ b/drivers/gpu/host1x/fence.c
> @@ -136,7 +136,7 @@ struct dma_fence *host1x_fence_create(struct host1x_syncpt *sp, u32 threshold,
>  	fence->timeout = timeout;
>  
>  	dma_fence_init(&fence->base, &host1x_syncpt_fence_ops, &sp->fences.lock,
> -		       dma_fence_context_alloc(1), 0);
> +		       dma_fence_context_alloc(1), 0, 0);
>  
>  	INIT_DELAYED_WORK(&fence->timeout_work, do_fence_timeout);
>  
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 4294101810fd..f7d6b294b63c 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1904,7 +1904,7 @@ static int iio_buffer_enqueue_dmabuf(struct iio_dev_buffer_pair *ib,
>  	 * the dma_fence.
>  	 */
>  	dma_fence_init(&fence->base, &iio_buffer_dma_fence_ops,
> -		       &fence->lock, priv->context, seqno);
> +		       &fence->lock, priv->context, seqno, 0);
>  
>  	ret = iio_dma_resv_lock(dmabuf, nonblock);
>  	if (ret)
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index c64a268e98a4..eb367a1666c2 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -1733,7 +1733,7 @@ static int ffs_dmabuf_transfer(struct file *file,
>  	seqno = atomic_add_return(1, &epfile->seqno);
>  
>  	dma_fence_init(&fence->base, &ffs_dmabuf_fence_ops,
> -		       &priv->lock, priv->context, seqno);
> +		       &priv->lock, priv->context, seqno, 0);
>  
>  	resv_dir = epfile->in ? DMA_RESV_USAGE_READ : DMA_RESV_USAGE_WRITE;
>  
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index dd07d128adc3..6f5c245d89ec 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -103,6 +103,12 @@ struct dma_fence {
>  	int error;
>  };
>  
> +/** enum dma_fence_flag_bits - internal dma_fence flags
> + *
> + * These flags are all only for internal usage, except for
> + * @DMA_FENCE_FLAG_SEQNO64_BIT and the user bits beginning at
> + * @DMA_FENCE_FLAG_USER_BITS.
> + */
>  enum dma_fence_flag_bits {
>  	DMA_FENCE_FLAG_INITIALIZED_BIT,
>  	DMA_FENCE_FLAG_INLINE_LOCK_BIT,
> @@ -110,6 +116,7 @@ enum dma_fence_flag_bits {
>  	DMA_FENCE_FLAG_SIGNALED_BIT,
>  	DMA_FENCE_FLAG_TIMESTAMP_BIT,
>  	DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
> +
>  	DMA_FENCE_FLAG_USER_BITS, /* must always be last member */
>  };
>  
> @@ -279,11 +286,10 @@ struct dma_fence_ops {
>  };
>  
>  void dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
> -		    spinlock_t *lock, u64 context, u64 seqno);
> -
> +		    spinlock_t *lock, u64 context, u64 seqno,
> +		    unsigned long flags);
>  void dma_fence_init64(struct dma_fence *fence, const struct dma_fence_ops *ops,
>  		      spinlock_t *lock, u64 context, u64 seqno);
> -
>  void dma_fence_release(struct kref *kref);
>  void dma_fence_free(struct dma_fence *fence);
>  void dma_fence_describe(struct dma_fence *fence, struct seq_file *seq);
> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
> index 18a43e1bb442..ee8fa4ecd6c1 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs
> @@ -736,7 +736,7 @@ pub fn new_fence(self) -> DriverFence<'a, T> {
>          // SAFETY: `fence_ptr` has been created directly above. It will live
>          // at least as long as `Self`. The same applies to `&Self::OPS`.
>          unsafe {
> -            bindings::dma_fence_init(fence_ptr, self.ops, null_ptr, self.data.fctx.nr, seqno)
> +            bindings::dma_fence_init(fence_ptr, self.ops, null_ptr, self.data.fctx.nr, seqno, 0)
>          };
>  
>          self.data.fctx.nr_of_unsignaled_fences.fetch_add(1, Relaxed);

