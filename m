Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793191479;
	b=WAATdh4mUQ1gU13xh3sqyT9F18jIGNJsD1Iw2rx6rRxwB6Sfv/kJbZUUez5j3yCByKFE
	 o6FPIygKHLFKP2r3bJRDSisUt/ngsdW57z2YkjrKKT6PVKZkvmWNyOJvB+sH9G9aN+9rZ
	 M9MeTCGxs8XXhlDzVmwX8wTfODhyZ6i2L33Pt6AgvRmpuqJQY9+RFs3FmxnBHVSYCS3Yo
	 chxGHE2EDj2lZZDZAyqy1KoMGd9sS0oPp8yRnOmvs12iL2IaV4m7NJWI58knoP5Qyu2Wx
	 +m+6KiAeCEbN+/8lQYUJ26NliXa+jjuHzUWjTk6FMqoAA04anNGK5+ORLYWVRCJXSbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191479;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=XBY4NGgrHhx5CB3aA23vGaIRkRGvUh3JM1ZjlwTjrek=;
	b=uXk0hFFDpkEcKqsjcDXIhVYUcrQCj5f86T+vFK3KgoFTbu3aFeZXgmF6Pr+zrYs67nfA
	 v5m0qsrBbUmbwAShIk9n4CUDMI3tVy74Q4Xrjnv2gDYEOtYo1zpujDIZPHsWJaqc3V4Ni
	 6oVMzhFc8L8WZ153AszK0SWoFSpyI/qlXNVXwSHlSVsB7pvZaSauBMzBCy5vWmySI5exF
	 Is8QON4Ik5ZS7+XjtIb5dhdXA4NMIcOOusiw97CZAZhFoqmZdhdMnA7M+x5tRnNaUAuir
	 1RJzWwdZwcRE7/SQbZnBrBlDHOWBA4s8rhNAymDAmhkNGhx8CANklRalUOZWLKBv0ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qnq7I65u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.38
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011038.outbound.protection.outlook.com [40.93.194.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B679606A31A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 12:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B679606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qnq7I65u
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPQCx/bZtjJTJ5brsrYL7KhBCO96XqttAvXW/ZNcsDK/baz2UjFiLPibAJ+gYBHpJd0yvpGDYmbxRpZ0o8jalBQcdNtSQ5+D58mtEJWWQz961QiA8/62fZtch38vdgRURYfx37vL6F/gibrzI0uLQLeBRRtnMpp81plAtEslp/afghAYAeHry2W9Moue77+XA4AKdICVqLxhDizosudR73YAlfjonkscnuU99vbjdjmT4+5nj37vq+ryxOWIDlcMYADc5h1DZ6c9FwZNA01QO9g6pNev7NStcl9nvBk2WpOZECfxZLHJ94jy0kvN8WX1Cx0SZqPGlCBvd1wqOhNaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBY4NGgrHhx5CB3aA23vGaIRkRGvUh3JM1ZjlwTjrek=;
 b=Ec2znLVy77UkWBp6E+DFCoEnmrda8n2HM0VRy/nfLgxcqY8hJP3A70jLEDQgynIBuPYn46pJCDXR5RJRnRm3HJC3Kj+5NYOw1I+rl1Xytrp7XnoHPcPWCcpJk3sf/RynBc01b2SBEpiV3mn0YneX0caXka2ivAn5i8h2jPIZIQoMpE8q7xoqjhJWWcKo1AT6k6rGPApGnUNiGkMQqUqMnE1xdIK9RiJkTuCHjcpIm8eAhpoLH4ijdkb2QQX4C/zmsVcPP16zgBPQrESBn4G+CuE0kl9nnufV4NeehVeQY3xxsVAd7eO701vIjbUB1iDW/CIvA7TEN/QWps8mG4rAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBY4NGgrHhx5CB3aA23vGaIRkRGvUh3JM1ZjlwTjrek=;
 b=qnq7I65uhv2lhu3WnoOsf0ZcJTtpSni9Bu9xyDUv+4HPb03KXtCN6bkGPNWbg//JjRfM6AYRxOfjBilaZlCGDu2bye0IeAf4IhAXnlG7wqPsljTEfKpPQjyDgnxfQtzfqf7VgpOcfgRN0z6Wz2f7p51Dl+7TCd1khMOKQ6LMTepZN9dG/mWfAwmTktsrkUtxSPBvER0Zm9ukf04mMUSBvca30r7yoRn1Ps5AZi2IjjBrcQReamHZawJNLwuZWYGwTAqwNE+5gZG432jm3Kqnxunl9TTfHwL3gDcaqGLBuAm9FebOMc9QUHnziCF++/d/pJ8OHqJDszI743QtE3ZWYA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22) by PH6PR12MB893224.namprd12.prod.outlook.com
 (2603:10b6:510:3da::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 12:44:34 +0000
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205]) by CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 12:44:34 +0000
Message-ID: <0f51918f-88c9-4930-ae5a-616bbe73e7cb@nvidia.com>
Date: Wed, 28 Oct 2026 13:44:30 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "mst@redhat.com" <mst@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 Linfeng Sun <linfeng.sun.dev@gmail.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 Jason Wang <jasowangio@gmail.com>
From: Dragos Tatulea <dtatulea@nvidia.com>
Subject: [REGRESSION] vhost_iotlb: bound map allocation in add_range breaks
 vhost-vdpa on hosts with fragmented memory
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::7) To CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22)
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
X-MS-TrafficTypeDiagnostic: CHAPR12MB999248:EE_|PH6PR12MB893224:EE_
X-MS-Office365-Filtering-Correlation-Id: 40bb5369-2a0b-40d4-5472-08df34f13855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|261021121427099003|261022113327099003|261022105027099003|10067099003|56012099006|261022075727099003|261026140227099003|18002099003|261026121527099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	nilaWSG7UtkKobMbGaRBbs+xoAw+7arwsvRoLSIE7TnQn636bLHAXGvD9SEP2TZdNYZpqStQ9yZjFh19rnDXS2l6GN5lrmtI1+GIvUhx6PNtM7UR0z7mVBEWWk5j/1JGs6ZTYxLKeZ9ZLKqTDst+FAqBldKdANE72PScZPWXC5yLANBPzHZKPHB60+UBHSFq4xRNGnkSkZU5Iw1LrIcI83CfgQo7SmI1neob1fjGN+pcyMSiDnR2jKqNGgB9KAq+93X0KrAKNgirc4HKTH3+QxfUtUMwek2U4yfAXt8A4XiRULuZWyl3qjxbGRlCoxnXYKpU53QCiJcu7vVlIYL5zWUFgsw0E2Ki8qYavKtze0KflY5sjRT/g+siIIXbfNh0L1q9oZMdEhDST/BWzOKEHAoGS+a4+459v9FpVsI83I7rkp6fVzFKMi1UMQFREuuB1QSBO8QaUTZ8NJp8g+Agtc5elOmHQwCJSneX7GHiFi6YG+fhFtLnGIyFixsp6rrY/d1mdNKaELC1yFos+BXQr4ZFZ2lKiikx+KMZwzjbZCikQafYjNTArSo1n3dgoIVh52BJt3ePA/ZdQITGS59AoeKQPhEMXVde+xqWlATVCOyhT0THwat/6Oqw3R8QD/Gn+g4kktPrZYDjWw+KHWlXBdQyFo+dcuPWEb6UEAMUqLY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(261021121427099003)(261022113327099003)(261022105027099003)(10067099003)(56012099006)(261022075727099003)(261026140227099003)(18002099003)(261026121527099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2l5MnQwUDJBZjlKeTdGQ21SY3IxWSsvZzJzVGJ0WlEzeTlESjRqN1Z5eHdq?=
 =?utf-8?B?U2gremJsTjlRTyt2bzJ5RjJwS0ZSQVV6anY5eUR4L3M1cVVyRGE2U2ZyYk1M?=
 =?utf-8?B?djlkeVpSN0JuVzBQOXptcnlEekRXYXBQNDBhcjl0Z0tMdWptczVremlzZE96?=
 =?utf-8?B?aXZCYmlJemxORlV4WlRRQVRNcmV0VHJ1YU9sMWZ2SGZFUlV0R1g5YmJhYW5v?=
 =?utf-8?B?N3dDZEo5M0d0ZlRBUW9qY0pZdU9oNWl4YlpBakJabmhmRjh5dDlWdHVoZjI0?=
 =?utf-8?B?Wm1EeTl0WXpQQUVtQS9tVStPQVNQREhlZzg1N01ybm1WV283TXZ5L3NySjF3?=
 =?utf-8?B?Q2R6Yzc5NVZTZks1VUhWRHZjeUtuNUo0WDFYZ1VUMHp3VzRHSDVkYUR6SkRp?=
 =?utf-8?B?LzcxQ1hOUlNzSStvVE8wY3FRMy9yalNWWGNuR1dkc1FOMlFPcTFyOUo3NzQx?=
 =?utf-8?B?aHVrNmxtKzdaNVFPMXlKS2FkUHJiaHNCRkkrSEd0NDNTZEZmSEJMb0JvczNs?=
 =?utf-8?B?aDJJemJQdW4xZ2VoUFU0MGNoT0lsVzAxZnNjU0VmQURlNmNxMnE1aldRc3ln?=
 =?utf-8?B?N3IxUXlmVXRxNC9ZMmlQU2VZT1JYRU9TZ0I0aEVQVEZSL0l5ZTI1UjY5ckhJ?=
 =?utf-8?B?d0lIVTFER2t2L1dzcUgxVXNjdnZTajF5cmhLNm1TdnhvWUlQcVZ3L3R3Mi84?=
 =?utf-8?B?YXdiQlAzdHJlclFhZllHVTQvS25KRTc5RFF0VCtIZUNIL3hCanBubTQzTngw?=
 =?utf-8?B?TmtyRWxMZGc4Z0I0aHU1NEJ3dU9sQklidTNlcHlqOUN0bG9NY2VPRThxeWxV?=
 =?utf-8?B?SytCWHJpQU5LeDZ3cTBFYllhMWluQjlDRDlVWnlYMVRxOXkyeldPQmJMUFBw?=
 =?utf-8?B?VlhlOXk3aXBPTUxHdUhheWJONkdRZ3VIbnRiMTEzL09wcDQrV2JINFp6QitP?=
 =?utf-8?B?ZlhoY3RkTzVwQ0daTkZLNW5hSWc3NzFMU3RVczhxVlQ5ekU4YjNRRUZpVlR0?=
 =?utf-8?B?bmtjTDJQWHpvenFzcWRNcGhUNzRjNmRITnlpT1dkMCs1MzRKaUNzWDZWaXVr?=
 =?utf-8?B?QmZITDMyZzNOamxoaWgycGVGNFRyM1pUTEo1dFVHUFc0bEpCaldHWm5oNmZL?=
 =?utf-8?B?a3lxdUczcnJ5cnh1K0h1WExKcFBmSE5VczhRRlJIMi9yN3RwWkp2a2ZMN1Vo?=
 =?utf-8?B?UlNIWUt5Y0t5cEVwOVFBT2lpWDhFbHQwdUpiWk93UzhMVmRSUlRjb1JQTC9J?=
 =?utf-8?B?Y3BYVGZZNHc3VUNIcFZ6bnJFa0JHY1o2dnpSamZuV1BWd2IxSVhWMmdXZWk3?=
 =?utf-8?B?U2xsc0RXbTFodXFnenNrbjZRMHJRMmZSL0dXd1RaT0Fsc1N5ZDVFOEc3cXNs?=
 =?utf-8?B?MmlpeDNwOUpkR3JLOEl2L0N4cW9qUEx6a3U0dVBaekdPRDNtN1hVQzJaN2Rw?=
 =?utf-8?B?K29WUU1YcTM5UlVrWFN5aVk5ekVpSjlISm92TmZhK1liVXMvaDYwOVpqR0lo?=
 =?utf-8?B?Wmw0WVhXcVNEb0xmVFhJMmNWS3IzQlB3cmlDN1lTSVIyem9ZeUR6b3A4dzAy?=
 =?utf-8?B?TGl0TkYrYU95aE4rOXRVazJ5OFNmdGoyZEh6dlppM1o2Ulc4WUVDUkhHSUNu?=
 =?utf-8?B?OTZKcXVIS25SRHZoR05Sc2FVSjVsSGU3aFNkc3VJejVPbFl1akRlU3c1bnph?=
 =?utf-8?B?V0hzNlZCUm5hTEpqR2t0eU94ZFkxa00yWFN0U3A5YUNaYTBETVE3Uit1MkRu?=
 =?utf-8?B?OTVvazNkdjdTSUVKVkFIaDdlUlVJY2JLKy9QU3hVbVdQOEdzTlBUc2V0S2tS?=
 =?utf-8?B?ODdnU3hHL2xSR0hZNjZUUmZpVFpSU3hmcGg3cFNHUXFpbU55T3R4QTNqaktV?=
 =?utf-8?B?RVNSSVBvekhmQkNXNU9WeDJ2dkhmd0JjRGpaK1ZWRmljaFpGbE0vcnZSR1ly?=
 =?utf-8?B?Q1loTXBacUExR3F6MW9USExYT3ZNc1FtRkhRSFlNNFB3K1pQdFhOc2FjMFZl?=
 =?utf-8?B?T3ZFb3FIcXcxSkFBa0pFcTQ0SXpORUxUZmdpN1FLWnEwZklPNWVIMVFtd3Y5?=
 =?utf-8?B?aFNDRXdqVlFWeW83dUJvY1dYVUk2dGlSYlJrLzd3RU5tTFYrRTcwTVBJUGhX?=
 =?utf-8?B?NGJYbzlFYVpFRjB0SnRJUDdTYUVNbUhUa2VPUUk0SFI0bzZVY2FSSWgycXdl?=
 =?utf-8?B?dHFTVFNsTVJTaWlWRG4vcTdHZFA4MlJTOHdzZUx1dmx6TUJ6Vmk0Y1NpaEtO?=
 =?utf-8?B?YWN3Z1VWQmdiSXVoRGYxdXhNRmZJemZDRTlMSENiMHR2SktyY1ZXdjJ1eXZm?=
 =?utf-8?B?KzkvSVR1a2dUM1cwVnpBUzVkeHNlWjl1TTZSeVJlRUEzUHhkRG5XUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bb5369-2a0b-40d4-5472-08df34f13855
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 12:44:34.8613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G038Ln3oC/3G4SrIsrKpBLpMv6+fKcXXTek2oUVySnIhB283xMslZy+bNQcv9u8VhtNbS1fI4nznRsGPG8zTOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH6PR12MB893224

Hi,

We've started seeing regressions for a while in our verification CI for
vDPA Live Migration tests. Occasionally the FW returns a syndrome
related to invalid mappings during device reset.

We've narrowed this down to commit 1ed35ac7f3fe "vhost_iotlb: bound map
allocation in add_range" which limits the iotlbs to 2K by default. On a
host with fragmented memory you can get easily more than 2K entries.
This results in truncated/incomplete iotlbs mapped to the device and when
the rings happen to be outside of the first 2K mappings the FW will complain
because it got addresses that are not mapped.

I'm not sure how to fix this though:

- LLM suggests setting the 2K limit only in VA mode and using 0 as
  before in PA mode because PA mode is limited anyway. Does this
  work?

- Can we detect this and reject the device / stop the device at boot time?
  Probably not as this doesn't cover Live Migration.

Any thoughts?

Thanks,
Dragos
