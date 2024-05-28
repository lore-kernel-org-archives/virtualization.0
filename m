Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DBD502B9
	for <virtualization@lists.linux.dev>; Tue, 28 May 2024 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899998; cv=fail; b=PwRfqh756B3uDhPakjYpzlHYxrfUL7n9daCaYMY3h2qidfy8936eIieCOGMfZrrx3jUU2hWdPBWPjWP2nB7Zj3kpJ4NyGnRdN1UZ1gLCpYwAWknD/vlRkCiYV5Qc7Ihz9OtSK9d/3CVImMUokNS8Q9hhXfvKQ8YktIWTpNOJeKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899998; c=relaxed/simple;
	bh=sMYRO/GJn0P4dzUo+wL4paSx41LYZlZ2FpfkuSmSuaA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CQS0Nx+W/LhM8c1oVDBWZzCnDnPzfci/2zttlbTZlwI3Jf5jMmxR+OSD/1yS6rkxRtNSXmTzclT7LP/O3+b9p6m8eRzZ5YCWZUJbfB0BohkS6sTIOD39xUi9WLx1j5syvSzKts6DdPNkthTe6Hxop3z3lyWynrRb4h4YejrZGk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BZJXP0mK; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BZJXP0mK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R48qP0lmDY31E719hy91HGEgdc+Hz7xnsL1TYanZS1k2mgXU8Q5Ya5N/7pQkcrwYpe8OTr8EVaMAlmO5NCYcHvvGSDLH9zaxl/+h/3s3gRHkuNfit6HBWoCS8o05lLTgiW/g+qDSCKQ3jZqxvgaKmh2y4bLe5n/54LzV9pQ0wEUM63bxFza0Ddieap2nCKhSFhSycEs1IUUZEaCClPSYKRSXHveq19OuW+y6+8fNSkhibYWnlaskdcHJBtroQwbF4r26JhS3f1oPQ/GuyNG9Kiu1rxsuEu+YZ7bZ7ku3YPLc3dtXu/PuFSbBRjImOjqw2VzwMOZeH0xiBlNwgRAZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMYRO/GJn0P4dzUo+wL4paSx41LYZlZ2FpfkuSmSuaA=;
 b=lvzGg+wFwJMVxdJWjm1U2rZi0eDuB4BZVwjpW5NUQ/u5H47hiY/finJfucHQHiUKorpjB4QsQWTGRlwCBviTwq9sE+tii+obt3QK9rzgufZSL5HAez+z6hCfXzTUDGYlSjs/cgN3KPKfrPnpB7QnYjJfG4ADgCL5lYqP26YN7RaOZm/INCgW0m/j773qrih4mPccBf/wwHJCpl8K25XGei1B7xMlfa7bWlH0STnDzQHgUayN4w2ekSY0HDEJxHg+qY0C9yLzxjgBSNX38nZMCqRAvY20qfoJg2py5c3nyS2UnqCvA0NMaurrQDmiTFLYO/2LVe1DOyg1KEz0FA6jrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMYRO/GJn0P4dzUo+wL4paSx41LYZlZ2FpfkuSmSuaA=;
 b=BZJXP0mKWfLmSn6X0gqjhBy0eNEDv00XaOa9bgPdh2PbLZ64JqajoXhVUAVsDyac7Ybagcj8vKxfv5fk1fVMwnEpm8imNUdjZWV4gd3Tlw+sys6vmX+hT5vUScPPRycsH173wM+1urvoYaSgy6DtMZbqrvzBnktn9NpswnDubPtjd8FMc/2xkXO8ICM3nLvZh1zKGXudAFGgXcOiLxxsxx9nmFmL5ueocF0Ef9FlLFOU4R3nc9m9ODRLHdyNr/qA186dZVQkRP2/6eZrF1KhRJOD98g4ZawS2mpPYJPdyEc3o/1JMfEtfhZpt6a8D4gW6S4Cf7e3XNtCdnGDmzFv+g==
Received: from SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15)
 by PH0PR12MB7010.namprd12.prod.outlook.com (2603:10b6:510:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 12:39:47 +0000
Received: from SN7PR12MB7833.namprd12.prod.outlook.com
 ([fe80::6f09:43ac:d28:b19]) by SN7PR12MB7833.namprd12.prod.outlook.com
 ([fe80::6f09:43ac:d28:b19%6]) with mapi id 15.20.7633.017; Tue, 28 May 2024
 12:39:47 +0000
From: Peter-Jan Gootzen <pgootzen@nvidia.com>
To: "miklos@szeredi.hu" <miklos@szeredi.hu>, "jefflexu@linux.alibaba.com"
	<jefflexu@linux.alibaba.com>
CC: "vgoyal@redhat.com" <vgoyal@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Yoray Zack
	<yorayz@nvidia.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Max
 Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 2/2] virtio-fs: add multi-queue support
Thread-Topic: [PATCH 2/2] virtio-fs: add multi-queue support
Thread-Index: AQHam9202+2TyynzgE27Na4LWMIzbLGsgNEAgAA0ZoCAAAtUgA==
Date: Tue, 28 May 2024 12:39:47 +0000
Message-ID: <4ac6b36f677c2447d1e4987435dc0f990fdbe996.camel@nvidia.com>
References: <20240501153817.540855-1-pgootzen@nvidia.com>
	 <20240501153817.540855-3-pgootzen@nvidia.com>
	 <08795907-fb19-47d7-a8c9-3db0ecc91889@linux.alibaba.com>
	 <CAJfpegs7Dgn1++gYU5jNmCbiJwDFxWShgH_0fkaSN13nmbiY-g@mail.gmail.com>
In-Reply-To:
 <CAJfpegs7Dgn1++gYU5jNmCbiJwDFxWShgH_0fkaSN13nmbiY-g@mail.gmail.com>
Reply-To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7833:EE_|PH0PR12MB7010:EE_
x-ms-office365-filtering-correlation-id: bc8b6d16-ba1e-469b-5601-08dc7f13427f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?eXRFN2ZVeFExRFJjL2RkY0NPZFJ6eVVVK29kZkQ3bnB0Q1JGVStmUU9EUmhL?=
 =?utf-8?B?NTFrNS81R2lPREJtTEVQMlNtTmF2ZDlHZDRZdE50QVhQK2c3UnF5cVJ4RTJj?=
 =?utf-8?B?UUFDVmszeEVaN1VJcTN1cW92aE10UGhzTUNKNEwyeE5TN1VOVWJtLzJGaTZz?=
 =?utf-8?B?UEFzWUgxNkNlK3ZHMDZQR21BbTIyR0hvNHFRTS9BaFFndURneWJ4MFNYNGtW?=
 =?utf-8?B?WXlVZUl1bTZGVTY2eURUTDhGam9NZzBlS3Q1ekxQUTZ3T0NqeHlJVE1OODBD?=
 =?utf-8?B?em1ZWHhiSjZnMUJ4dVFxemRLWGZPa1RSZmZnMWFXcGZBbHV2S0J4R1psYzBM?=
 =?utf-8?B?akp4eXJmOWR3UEhCcnFjRHZnYWxEa0NFRDhyOXZVdEorZk54c3dHdldNYmpP?=
 =?utf-8?B?eEdXcVJvQlpSTGtrNlcwbHpmeUlaZ21rZXNQVEJURkh3d1JsY3JwQjBLTUh3?=
 =?utf-8?B?ZU53KzZ1VytpSWU5OHZDNnBjZkJJTnYzZGgraU95LzJuZzJoQ2lrMm9sOGtM?=
 =?utf-8?B?dXZxTGQ4ZTdCMUhKZjVrdzlSYzVRUnJPcTRSVzFYMmpIUU1HQ3hmZU1tRy83?=
 =?utf-8?B?RFpObmw2M0NLK2VSMUp3UytDU2IybTRVbWkzZGp4L0YxSGV3ZjFUQVlhSXVM?=
 =?utf-8?B?YzdjZDMvbHZIYVVGR1N4a2l1RVFCK2tldkhYMmlCZnBxOVRSUXFjUE9FNHVB?=
 =?utf-8?B?ZUg0b2V5bUdmUTF6QmVyR0lwaUxGajZpYUpUNlNHRHB2eDZrR3FNY2JtOGZk?=
 =?utf-8?B?RUUxOU5kV0NWaWhEUHM3cXQxMnFTMUk1RnpMZlJwdDJpMjNLZ3BpQ0hxUnFD?=
 =?utf-8?B?WTgzcGpjVlo2VER4Mk1QSTRHc0lwU1RrVFZ2MEJaOG1NT1NhZm96QkczV3ZL?=
 =?utf-8?B?UngwYVAvTEJPTjJiR2hhWVVzalBQbUdvZjhGQU5JMDRzN2taT3hyaUFEaStz?=
 =?utf-8?B?OVJIU3JWcEJpaWpHd0owaFlud0t4bW9hZ2c5TjBjazh1czBFdlg4bWNQM1l4?=
 =?utf-8?B?RS9yV09jeTA4N1ZaNURXVFQ3NHBFRUJ0TnpMeFNQR3h6aXF2N2pUejRMTzRP?=
 =?utf-8?B?TURHV3g0eWpDblpiakora1kyUlJIVVBOUzRPUnF4c0hlQmJTWGFCbW0vUzdI?=
 =?utf-8?B?MkxyM05XNmg1WTA0ZXBvRHpWenMybUYzQW5CaFpZMTBLSG9VbnZ1Nk5kWkJv?=
 =?utf-8?B?Wm56WUIwV0xHTng1OXQ3aGhNOTdZQk9SYkgxNDNOcjhCRS9jZndERGR2bW54?=
 =?utf-8?B?ZWxmbUQ5VnM0WVViTjg3NWtzanJGUFh3TWFVSWtjcmhFRW05ZjZJcnBKSGxs?=
 =?utf-8?B?T2VwVFc0NnRBaS9pQlhvRW5sRVZJTCtaandDd05yTTV1WFFoMVJLS0FFcFhk?=
 =?utf-8?B?cE9VZVd5aXVPNXlOMFQwc0lWM2IwYXlsanZQUjV0NXZjekdkRmVjZDVvQ2xa?=
 =?utf-8?B?VnU5cUhwbGwydUVTblBRZWJFM1FqbW44Tm5WQlQ5bStFSkh0Q0t6QWZMbGQ4?=
 =?utf-8?B?dlA3K1BQVE5YdDI3ZEd2Ti9JTHNGS1gzYjVpYWdGNmF4dmJlR2dRVis5aFdi?=
 =?utf-8?B?ZjF4YWlnWUV4NERVUDk4N1VEM041N29YbFJPYU5SYXppNGR1cTdVS0tnOTdR?=
 =?utf-8?B?ckJ3OVcxTUFVQ3NHUnREMzk2ZWN4NS94WFZHVG53aTFVTGJsVnZ6OUptb0Jr?=
 =?utf-8?B?UkdOSGRZOWdhd0xFNmZHU285ZmsrV3VYNFNydVJtTWtGdGxIRkVvOXN5ZFRv?=
 =?utf-8?B?RlNZYTRaejhoUDlwQzcxaHFXRTZsT2daOU11R1orWmlUTitWVjdlZXJGZlpT?=
 =?utf-8?B?ampnTHdCOUMwWlZTRVJmQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7833.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2RnVGFwNFFmTC9TZ3p2Z0szWjBkcU41bkJLa3psZ29VcXVuWkM3cHh6aXRM?=
 =?utf-8?B?c0JCWExoeUpOOXVoZ2I2S1VmVWJyYWplVDM1dG54RnkvcG9hc0hKQUtKakpt?=
 =?utf-8?B?eFVibEhxUHlYa0RObVYxNHBBcGhaU05UVkQ1dURHUzUwTG8xQnRDVEYwaGtB?=
 =?utf-8?B?RXBmVHdCR21GRk1nL0NYSFVYVkhqaVpDdmw2eGl5S3lzNjloQnBKUEdFMDg5?=
 =?utf-8?B?blRKQndqUUhhaCtYM285ZERuSEUrc3lLNTNQODJlMDM3cDhNbEdHY2hQb0Yy?=
 =?utf-8?B?QXhuUmFoM3MwajhHYkFDZmZ6R1AyUm1aVmlkOHdWVkp2QUtFQ200NEIzWUZM?=
 =?utf-8?B?L0kvRzBsMmJ3ajJvalFiWlRIeVhSNFlYUUNlZnVEYkFMK01wY2VYME1kdWZm?=
 =?utf-8?B?Qk9iMjhycENzVEtQODR4bnpKSG9Pd2hiUEIybDhEcE9GZFIvVXRWY200a01s?=
 =?utf-8?B?d2w0SHFBQk5peDNMekZBcUNwbFloNUM0K3J5MHFyZ3JFdHpzbGt0MDB5a01v?=
 =?utf-8?B?N05hRHYwdmlucWx0NHAvZkJUYWt3N2creXVsTGZWNWJjWDBYb1hYd3NyNjZ3?=
 =?utf-8?B?dFI1b25SVEpkcExyempidk1ReDZVTlp0ZTFpRmdVNmxqZG8zWFdGcG8yaWVE?=
 =?utf-8?B?OTRoWnFGdVhwTVVjK2ViQ3pLVDhlMDBrYlpUeU1qbmZNRzRMc2pVRFBxVFlO?=
 =?utf-8?B?aXpoLzVXd0VrNlEyYURaRkFZOGtualhhak9VOFNsYWVVNVF1Wi9uckdWb2Z6?=
 =?utf-8?B?SlVSREhuNk5XY2JNRllEWTV6cHNYVkpwNFM2WXJUcWJaclBEQnRnSDdIVVpV?=
 =?utf-8?B?MTZOclJveHVIMnNVd1M2emRBWjgvbnJxT0FrUVRjN0ZvSkZwVUUwQWprUllu?=
 =?utf-8?B?MDFBbnVWSy9xMStuSU56endFdWwvODFSUHE4cklNUmxUZkxmelQ2d0JRNUx1?=
 =?utf-8?B?bGROVHhGOTRIakYwV282K2p1b3pWc2RsTTVWUXhTajcxMEIrMTZhWlJ6UGM1?=
 =?utf-8?B?MWNUTEJlM3RYc3ZYeE9IbU1LaS9FMC9tS0tTOUVKVkJsUDhETkdqUWlUM0hN?=
 =?utf-8?B?cHNvVzVvdUgwRDNaOVJzbllydzg3Qi9HcXFLMmcyUHZieTVFYmdQT3ZlamI3?=
 =?utf-8?B?ZGxmRjhiUkhiWTRtWGVwYVBzVldkSXdtRXN6ZUNEaVRyK1FZVGc5T09LZTR3?=
 =?utf-8?B?dk1aMytSWnJMT01TeHRQdkl1RGhCWkhXRll5Z1NEemZTZUdjTWRkMWIxNkF3?=
 =?utf-8?B?VjNMODZsVWhFbE1kSjBWbXM4RCthWjVFN0FPR0ZHYVAyVnc4QW9wYVF5Rnpm?=
 =?utf-8?B?b0pyeGd5Q0dYdlJEL3hHaC9EOEMxYTFkM0JsR05LYjVpZ0dwTlFoSTZiRmt3?=
 =?utf-8?B?YnB0T0J4bmRPVlRpVWhMck1vNmFrYUVtazBOVXpvbVRwNEcxZVk2RDA5eHpy?=
 =?utf-8?B?TksxaFFSMk4rL3Uwdys2bUhNS0dsTGZyWGRkUlFEYUNSVHBRRGd2TENramxx?=
 =?utf-8?B?T0swdDJBRWVFMlk1Uk0ycHNKUGhIYm9KQlZsMFRyUjNWUFF4WlFZcUI1NHg0?=
 =?utf-8?B?OVlZVXZqbGZmZDZMV2hDU2lHYjNKSGxpeXJpbXUzb0tvOWp0UjBWY3FES2VU?=
 =?utf-8?B?TzVpdGZrckxBSGlIOWR0Y285NFpjenh0S1UvMDNGZkNvcS9ENmZSSWpST3Bu?=
 =?utf-8?B?aVRJMnEwUDRXUExvWWU4RHpRQ2FBUjdFcjJyR2IwRFZSWDJ1WVROMDBCWHJE?=
 =?utf-8?B?ejA2MUIxcVdHNk9qR256RUZVZFcrekVYUWlWTVVZaTIybkdzbFRYc3VsMlpO?=
 =?utf-8?B?ZHhNOUNZckhwUmxBSkFnaHVCcE4yaFliVlM5LzlUUmdzRzNyU2c4QUt0Qnpo?=
 =?utf-8?B?aTZmdi9SRERvYUZIRzdmOExNTUJHR2V1ekorZW9FODJxcVoyWjlxajFOcFJ3?=
 =?utf-8?B?QnJhVW9adEVwaHJBQys4b2RsRWpTb0ZWSHBOQUNGaWpnWmtLYlNVTmFwaHdt?=
 =?utf-8?B?RTdqd29DMjNUSGVLbllXbzVZRjc5UmZVMlE3SWVTNUZjVERBNlZVaHlnWFJq?=
 =?utf-8?B?cWY0MG5PTi94ZWdGYVhYelNKR3h1UWVOTG4xOW1KMTlaS2hteUdiWHdPTk5s?=
 =?utf-8?B?QmRpd2ZsbWNHbmZhYS9kQldWOEpsR0IwTVI1RHhOWUo2OXA5WjM4SkoxemhW?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7C2345ACCBA4E4B9FE686ADC14155A5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7833.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8b6d16-ba1e-469b-5601-08dc7f13427f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 12:39:47.6083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C3mTIr950GgYXa2YFYfZsuNdikepj1QnvPu7jDs88+exqXzVG03rxlwWGp/POD9Fla3xFHIxZy3TJe6XLprfzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7010

T24gVHVlLCAyMDI0LTA1LTI4IGF0IDEzOjU5ICswMjAwLCBNaWtsb3MgU3plcmVkaSB3cm90ZToN
Cj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVu
dHMNCj4gDQo+IA0KPiBPbiBUdWUsIDI4IE1heSAyMDI0IGF0IDEwOjUyLCBKaW5nYm8gWHUgPGpl
ZmZsZXh1QGxpbnV4LmFsaWJhYmEuY29tPg0KPiB3cm90ZToNCj4gPiANCj4gPiBIaSBQZXRlci1K
YW4sDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB0aGUgYW1hemluZyB3b3JrLg0KPiA+IA0KPiA+IEkn
ZCBqdXN0IGxpa2UgdG8ga25vdyBpZiB5b3UgaGF2ZSBhbnkgcGxhbiBvZiBtYWtpbmcgZmlxIGFu
ZCBmaXEtDQo+ID4gPmxvY2sNCj4gPiBtb3JlIHNjYWxhYmxlLCBlLmcuIG1ha2UgZmlxIGEgcGVy
LUNQVSBzb2Z0d2FyZSBxdWV1ZT8NCldlIGhhdmUgYWxzbyBpZGVudGlmaWVkIHRoZSBzaW5nbGUg
ZmlxIGFuZCBmaXEtPmxvY2sgYXMgYSBsb2dpY2FsbHkNCmxhcmdlIGJvdHRsZW5lY2sgaW4gb3Vy
IHN5c3RlbSdzIGRhdGEgcGF0aC4gQnV0IHdlIGRvbid0IGhhdmUgaGFyZCBwcm9vZg0KZm9yIHRo
aXMganVzdCB5ZXQuDQoNCkkgYWxzbyBzdGlsbCBuZWVkIHRvIGludmVzdGlnYXRlIHdoYXQgdGhl
IGltcGFjdCBvZiBoYXZpbmcgbXVsdGlwbGUNCmxvY2tzIHdvdWxkIGJlIG9uIHRoZSBmaWxlIHN5
c3RlbSBjb25zaXN0ZW5jeSBpbiB0aGUgRlVTRSBkcml2ZXIuIEZpbGUNCnN5c3RlbXMgbGlrZSB0
aGVpciBsb2Nrcy4uLg0KQ2FuIGFueW9uZSBoZXJlIGNvbW1lbnQgb24gdGhhdD8NCg0KPiANCj4g
RG9pbmcgYSBwZXItQ1BVIHF1ZXVlIGlzIG5vdCBuZWNlc3NhcmlseSBhIGdvb2QgaWRlYTogYXN5
bmMgcmVxdWVzdHMNCj4gY291bGQgb3ZlcmxvYWQgb25lIHF1ZXVlIHdoaWxlIG90aGVycyBhcmUg
aWRsZS4NCj4gDQo+IE9uZSBpZGVhIGlzIHRvIGFsbG93IHJlcXVlc3QgdG8gZ28gdGhyb3VnaCBh
IHBlci1DUFUgZmFzdCBwYXRoIGlmIHRoZQ0KPiByZXNwZWN0aXZlIGxpc3RlbmVyIGlzIGlkbGUu
wqAgT3RoZXJ3aXNlIHRoZSByZXF1ZXN0IHdvdWxkIGVudGVyIHRoZQ0KPiBkZWZhdWx0IHNsb3cg
cXVldWUsIHdoZXJlIGlkbGUgbGlzdGVuZXJzIHdvdWxkIHBpY2sgcmVxdWVzdHMgKGxpa2UNCj4g
dGhleSBkbyBub3cpLg0KPiANCj4gTWlnaHQgbWFrZSBzZW5zZSB0byBhbHNvIG9wdGltaXplIHRo
ZSB3YXkgdGhpcyBwaWNraW5nIGlzIGRvbmUgaWYNCj4gdGhlcmUgYXJlIHNldmVyYWwgaWRsZSBs
aXN0ZW5lcnMgYWNjb3JkaW5nIHRvIGhvdyBjbG9zZSB0aGUgbGlzdGVuZXIncw0KPiBDUFUgaXMg
dG8gdGhlIG9uZSB0aGF0IGdlbmVyYXRlZCB0aGUgcmVxdWVzdC4NCj4gDQo+IFRoYW5rcywNCj4g
TWlrbG9zDQoNCkkgYW0gbm90IHRoYXQgZmFtaWxpYXIgeWV0IHdpdGggdGhlIEZVU0UgZHJpdmVy
LiBXaGF0IGFyZSB0aGVzZQ0KbGlzdGVuZXJzIHlvdSBhcmUgcmVmZXJyaW5nIHRvPyBJZiBJIGZv
bGxvdyBhIEZVU0UgZmlsZSBzeXN0ZW0gb3BlcmF0aW9uDQpsaWtlIGZ1c2Vfc3RhdGZzLCBJIHNl
ZSBhIHNpbmdsZS10aHJlYWRlZCBwYXRoIHRvd2FyZHMgdGhlDQp3YWtlX3BlbmRpbmdfYW5kX3Vu
bG9jayBvZiB2aXJ0aW8tZnMgdmlhIGZ1c2Vfc2ltcGxlX3JlcXVlc3QuDQpPciBhcmUgdGhlc2Ug
bGlzdGVuZXJzIHNvbWV0aGluZyBmcm9tIHRoZSB2aXJ0aW9mc2QgaW1wbGVtZW50YXRpb24/DQoN
CkkgdGhpbmsgdGhlIG9wdGltYWxpdHkgb2YgYW5vdGhlciAic2ltcGxlIiBtdWx0aS1xdWV1ZSBs
YXllciBidXQgaW4gdGhlDQpGVVNFIGRyaXZlciB3b3VsZCBkZXBlbmQgb24gdGhlIHZpcnRpby1m
cyBkZXZpY2UgaW1wbGVtZW50YXRpb24gKGJ1c3kNCnBvbGxpbmcgb3IgdGhyZWFkIHBvb2xpbmcg
bGlrZSB2aXJ0aW9mc2QpIGFuZCBob3cgdGhlIGZpbGUgc3lzdGVtDQpvcGVyYXRlcyAoYXN5bmNo
cm9ub3VzbHkgb3ZlciB0aGUgbmV0d29yayBvciBsb2NhbGx5IGFjY2Vzc2luZyB0aGUNCmRpc2sp
Lg0KDQpBcmUgeW91IGF3YXJlIG9mIG90aGVyIGRldmljZSBkcml2ZXJzIHRoYXQgcGVyZm9ybSBz
bWFydCB0cmlja3MgbGlrZQ0KY2hlY2tpbmcgaWYgdGhlIHBlci1jb3JlIHF1ZXVlIGlzIGZ1bGwg
YW5kIHVzaW5nIGFub3RoZXIgZW1wdHkgb25lPw0K
