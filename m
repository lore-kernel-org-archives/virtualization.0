Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C779D1BE877
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957086; cv=fail; b=RQHtRTCJgxHZgRFO8HNnWAsDiGb2aUCsFhXvHxmGnbEilZxFB5qSz3SzIH3mLhiLyzMW3JwVQ25mf2+8NsNDfqLuE94UPWfyP5+pORToU68zy0iSd1bg6vsiD+qSSb4eQcA77ZgiucQ6cYvRZLiL4JH8lCrRxgCjb8h1LUTZs8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957086; c=relaxed/simple;
	bh=EGyFyZ2HKbb2Lv/DZQ3czEcsBFSbtcsEAn1SCbpE+Ss=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EirTWmQWknLqWv1g17Sk8RvaYEfJYYMIhrZLPOB86QY47nwzTJvfZtO36xZvnwJOBkebISbmW7YFTnyG/qfani2FZ1bovgAnVF6Btg37o0Ctb4WqEbBaGhVgZJXKAeAOA/lVZyezBLBCMKAGiVjBTjBKssAP5HREugWLwvmfq4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CCLbSHRx; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CCLbSHRx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwnBbG4+656HbRRz0sRo08QgObhiSKXDB6i/2vqoIPkSewpPQxn01apnjWPJJTdEH/lPgc3WltXNg3y7CetKZGtmiU5fuBgkZ0xqTq+acYtiGlv2bUCAbOMYaq+Bp0cYrGb7RFgPJ0Hh+AePoxvvz08SSz2NHLMYrt/eSM7usUFGMMyebbxfkYhasjgS5iBSMPgnBSmO1sSfiz2XjotqW5heLQ6tX8Gbb63xE4XrQ4C9h0a+BfHsdIqZnVC2EGrXxDssxH6Kl6Wpf0gJPlzdLI45LjsAl91urmgOZD+E8CmUBqt/yulcwphIw2VnScIaU0KLILlYox56yq8D22zFFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjZcaZB8dO/QXjnlnQoXRQTxmUisEXWMoHSO1MM2eds=;
 b=byrv8gVmXd6iLv8nCTpeZZ7X8hgsxKbBCKXaZ+1DWUJxbKwH41YL2mjDzp/7tTm1tpv9vLaci1ySy3siyL9sCeeKOEDgApEweu/ksYTXKVqcoa6KKxMSDxVevbWl1u2tunx99CR5gdwYBsxprNYjqShXYpKzeFEsd///aywedBdaxFs8gkfThlK9OYVoG0hRFZe7KGP59c6LHcwgYfWKuBUwgBaAAJuVn/A6MWJ654YdcZltSHQJSJ22IhccYq2n+MV4EsigRADptEo6fPrhu5FW+suIi4egfOSTFj27fgkJK6Oj+R5CvUYG5GvWmxSHZcVWNzhLBOGAFUzERlA8PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjZcaZB8dO/QXjnlnQoXRQTxmUisEXWMoHSO1MM2eds=;
 b=CCLbSHRxiLdXfB5VT8NxApnHgBQ2wNk4wgAeUpZ4FYqYk0SCXy2yLCD7asvVwCvCTKPTdEOneDI5vl7Dh76oebAoET9oBmlMPc7TOqBrglJCi/4erSWJRwKpcEnjQ9sunAYlpIl+DwLn/zTnfK7I2RBAzXT+AHNxTfh64XcxSuCKDtByxftuIdN8yve+hKw3JEbNGGRViDBjlZHLujsvN/NpwH2SqEybUqpL178cujfzQkVTlLiwJq2/H2lbcaA+lyfk6Un3+l8aKsqeDSF35PpZ3Wxp/mIhbsG3c3ZcGn73HIPSfCx4o819e0LupuabV+n4yU59bPjxubzy1n1gzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by DS7PR12MB5742.namprd12.prod.outlook.com (2603:10b6:8:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 18:44:41 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 18:44:40 +0000
Message-ID: <06bda32c-6670-4d47-bd68-f8d0771aa838@nvidia.com>
Date: Thu, 29 Aug 2024 20:44:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mlx5_vnet: Set speed and duplex of vDPA devices to
 UNKNOWN
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, mst@redhat.com,
 jasowang@redhat.com
Cc: bilbao@vt.edu, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 cratiu@nvidia.com, lingshan.zhu@intel.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Carlos Bilbao <cbilbao@digitalocean.com>
References: <20240829161620.38679-1-carlos.bilbao.osdev@gmail.com>
 <20240829161620.38679-2-carlos.bilbao.osdev@gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20240829161620.38679-2-carlos.bilbao.osdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::10) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|DS7PR12MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: e3988c4a-bc74-44c3-9eaf-08dcc85aa42b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eEdZdkdzUmdoQW5XNlV5a3lUYXdQcUwraGVUc1kwYm9FWmQxclpnbGRucDZ1?=
 =?utf-8?B?RjdwQUdXK3p0cXUxZXR0TmpOVHVmVElIbkxuUWM1d1NVSGJ1VDlLZTRoTU9T?=
 =?utf-8?B?Y2VqeVU2M0NQZm02aWZYaDRIL1ZJNE5lV0kzeWlUTGxyODlGWmJ4ZzhUSHpK?=
 =?utf-8?B?eVRPMVZuSmFsaEkzUUhyTHRRQ0dmSzhhS0I4K2UzOWxFT1dWS05MSU5GejFj?=
 =?utf-8?B?bzAreTBlZ1g2NnJ2RUVNdHpKbmdJNnl4RVppREhLOEMzY2Y1akVlRzlTWWR3?=
 =?utf-8?B?RU45c09nb0Yrc2VKckNXTkN4T0s3SUJLUDNmYytpT1VDZnR2WEFUZ3ZUMGkw?=
 =?utf-8?B?NFUzWHNvbGpGN3NNOWFXcFdWU3kyVHBhRElybk1CdEdkY3BqVlhiSUVFemxJ?=
 =?utf-8?B?cFcvS1JZVUhSL0Z1ZDNObWpyS1BHaHlqTXc5VUh0clJXOVdCRTlHeFRXSldU?=
 =?utf-8?B?THpjazYvZ2xvQ3lBSFVCUjNEb21xWGJxK2ZNMmRxaVV6WUNGeXdFOUw5RTlR?=
 =?utf-8?B?dC9ZK3JLZjRNdXNvVmNNSXNkZFFMeDhUelgwMUNvT1dyOCsrYXpmR1p4aVBj?=
 =?utf-8?B?UEFESUwvY29Jc1ZoZnQxM1c4T2tLczdweEhkbWkrL0tRckU3T1dTTTZDcHJk?=
 =?utf-8?B?bVo5WHQ2MEk0aHdOOG9YekhmR1VHQXh2a2tNRW9IM3FQaEhXL1VtSm56QkNN?=
 =?utf-8?B?NUZXTHdtVFRWNVdnVGNZM3JNUEp2MlhFS0tBejRBK1E3MC9xbi9HeUNNNjF4?=
 =?utf-8?B?RXpyNEU1bTZxMWFsNHY5MVByK1FJRzJQNEJ1Zk1XZ0pOVzFaTmVzSW9TbGxS?=
 =?utf-8?B?S0ovMVY1ZWtlZTRYdzdSY3BsZERuZGdxZ2c5Z3FnaFk4SnI1M0cwY3dkaUsy?=
 =?utf-8?B?R3pMbCtHQzBxcjlMYkZsNVNOLzVnQTdKb0o5bzB4b3V3Y2hlOFNlQmswK2Y1?=
 =?utf-8?B?M3VHT0dZR0RiRlB6SDN3Vmo4Rk4zWW9GK2tQMXkzendub2tMNkREZ1BwS0hU?=
 =?utf-8?B?MnNPWTJyT1NaUnpHeENzTThsSmRpSGZNOXE4VzlUOERXRldNa2xVKzlmYTFK?=
 =?utf-8?B?T3RKL0QrUVFCQThNcjVOajNORUN6RzVlUGJXRmZxdm5PeFVEUTFKdGZ5RFVp?=
 =?utf-8?B?N2FRRndWb09OSnRLSE1xam5HVGFXRlh4bUdsUytsMFRIUEMzc2JZZnZWUExv?=
 =?utf-8?B?R2pyQVZQRG5pbVB3c1pKckRheDdwb21ZV2JsZWhtVHFKaWVRSkx0UE5wVjgy?=
 =?utf-8?B?SUpUSS9TQi9iMk1FVWFFV3dZbThwN1RwMmFqeFBIQUJpNnVqVjBHUFBtOG9T?=
 =?utf-8?B?NEFMOU5aSU9aTW1HOUZRaXhQMVhCNU1PTHlRNXhsRGR5ZFJEVEVEdHRNRUpw?=
 =?utf-8?B?a0pBdXBRZXBPZTc5QzlMc1VPYnI0RXoydDFhVlUramoxSkMxRmpFYUVCdFg5?=
 =?utf-8?B?eE5Sd2M5SzB1L3UyUVJvck9MT01mVGowV2pzb2cvSDJNMEE5bmNIejZ0RHF5?=
 =?utf-8?B?K1VLUVNyREUvb0lOZzFCaFFzaWFWVmczQ2cxZ1ovcVhiNGM4TUpBSUg3Z1hi?=
 =?utf-8?B?OTdDL3UvbzRnVWpMdXA4UHF6SHNLRlhWK2NDV3kya1poamxYb0NhV1BKMmpp?=
 =?utf-8?B?WFJtVHRnaHVaUkZHN0x2OE9vaDJxSkZna3RSUkZMaFovMEVCenJLWk92NEZM?=
 =?utf-8?B?U2dQcm1RV250b3U2VFVObUpCN25qaWcrVHBROU9WaEJoWE9PRktVTktUcHhW?=
 =?utf-8?B?VU93VHFOUUVyUmcvWE1rMUVZYUtiNmdsVURibEZTMHNNOEdmM3J1WFpzNWJB?=
 =?utf-8?B?U0laUEtyY1dzNnVJdWZlUT09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SDVTaGhHSnVHcGYxbktrdG0zR0c0SkNRbHBvbFdvdzhlVHh3dVE1cWtnaU5q?=
 =?utf-8?B?d3JOd25iL2oxcGFNUXdoNlBxOGhXbG5LOGtDZ0VqdjF2YkZMbi9vd2FlQVpY?=
 =?utf-8?B?aU1RSnZXZmJpN1p4Q0k4K2FkaXdOUG5CajNybTdlcm43WEFpV0FZMDhuZFNl?=
 =?utf-8?B?NEhNb0NQa1E4M2lKMmM1TVBJT2kvMHMzaHlIYzF6Yk9mcFJaZGxiK1M4d25r?=
 =?utf-8?B?SmlheG9xU29ZdWlPY2FBWmt3S2xaLzV0NEVEMEtacXhkOU1uY1pOdEVqSUlM?=
 =?utf-8?B?U1c3WVdqL0NxM2E0enBLeS95Mlo0cjF3UEh6Q1FaQThDc0c5a0RJeGVjME1a?=
 =?utf-8?B?WFlTMmJQbGZTNlR2NnA0UzFJR0crdDNBMlpUNWp1UUFLWWQ5d2ZkSTA2NEZy?=
 =?utf-8?B?Tklrd2s0aEExZTNLSE5pQ0d5RHZ4UkErZStOWTF3SUFYMnJTUGlESit0VWZK?=
 =?utf-8?B?Rk9ZTDRqNmxUcC9nSm5lbDg3RGNicC9Xc3QrOFNNU0VBR09heVowbnl6K09u?=
 =?utf-8?B?d0VvQ1ZFVm5NNjZEblNVdXcveDJBZ3RQanN6MWZXWXRWNExVZW5UbElsejZk?=
 =?utf-8?B?NVU0QitzeEJRR2Fza0t6bDdSYjk0RS91ZDN2NmxLUjllWk9PdHQ1Q0N0NTU0?=
 =?utf-8?B?SGp0MGttQTJ3S2RPMGxpMUprN2RvN24vYml3UytiWWtPOHNpaGNlS0J4NzZT?=
 =?utf-8?B?ZFU2dXpudllFR2srWnpHMkpVMWx5cTQ1WFl0U2NPT3lUQmJEZUZ0bGdpZVB4?=
 =?utf-8?B?UVM0WGFNQlB1Sjl5YU1SOTBDaE0wZUJheWxnMktsVjltSStrR2lmRUVpVTJw?=
 =?utf-8?B?aDhudE1TRldzMGh6ZU5hcHlVTEl3Q29SdGtJK1gza2FEL1ZkR2J1MnJPaDlQ?=
 =?utf-8?B?c0RFOEk5YU5PWWNISEZ4SzFGK0kzTjFyRUM2UXVBZjJIbjBnYWVTRFppb0N6?=
 =?utf-8?B?eDRNb0RDcWZLbWd1NEFJcjkxaXh5T1JsR1JPK25rQzE4RHlOVUV1cWVJMjdR?=
 =?utf-8?B?NVFxbHZydVM2Mlk5TWwzSjlTY2dvQUgrNjIzcWdTNkdxYXIzOG5lMlozc1Fn?=
 =?utf-8?B?NGhJOVFkUjNHbHBEMWpWZElJeWZTV1k0bnlUbW4xSXA3K01QQ0ZwVmU4N1R0?=
 =?utf-8?B?VHhjOFF0QVVKMXVZaWpVWElzSWNTcFVMRmxKYmJSdmx3eW8yYXowaXFMNmln?=
 =?utf-8?B?NXBrRHpmVzdzSjVrcGtQeTI3RVBtREgzNmkzVnZ5ekY4TDAyekQxa25kRGVm?=
 =?utf-8?B?Q1hMYUNNUUY1NW1mdmNUelVTTTAzczVBWU1SSHZHVW9UWktEYkc0djI5NFFv?=
 =?utf-8?B?WUZRdmE3bjhoNmFvYUJ1c2oyK1hhUUFKT1EwWmVVUmlRSFJIRUszZ1A4S3Nk?=
 =?utf-8?B?eXRvQlEwWThIUHN3Ymd0WHpLdW5ycEpERVVaT1NqWVl5TkU3UCtpeEVzYWxy?=
 =?utf-8?B?QkJQQkZjWEQ5R2hnY2dKQTQ4Z2xkZndqSzdOb3dNeVgrL1pBLzFwdUp0Yjdq?=
 =?utf-8?B?VjFodXc2dzlNZkloVEZWTS9UMHdzNk9JOEJCa2gxQ25tbkJrVFUwR0hzZTRG?=
 =?utf-8?B?YVV3ZjZJOTNJUDUrWmg3Ri90dHhrMi93dHMzVUgxUGd3emtHZ0ZmQjg5dklW?=
 =?utf-8?B?a3V1K25hdE1qQkRnVHA2bWZvN3lSWWF4UFk4cy9vR1FpbzZ6dXJxTFZHaC8z?=
 =?utf-8?B?U0VDazRXUW1Xalp2K3BzQWpocXFjK1k1ZGdmeVdTUmNPVmJKT3VVNXB2VEZz?=
 =?utf-8?B?NGRvZ1pQY2ZqSHIyaFRFUTVuLytoRzZMbnEzZmxZZHpicDRVemJsN21LZng0?=
 =?utf-8?B?SGNEL1pPMERiVCtPLzZ3dzRlL2NhK2Z0N0Y4OG9GZ0FhVFBEUUV4d2hQeVhV?=
 =?utf-8?B?ZjFhc21kWUh1S0JWTGNQbGtITllCQWNMNHErb283MTZ1YUlNNEJycmRVck1R?=
 =?utf-8?B?SjJrRmc0dUtYd0ZrS3N3MFVTNXV0dHE5Q1BkOC9qMGlyc1RESlE0VEVqQ0ht?=
 =?utf-8?B?RlVXU3VmbU9tRGVtRnExbjdYSXYwRmxVU0M3WUtOcVgrd0drVHZ6MTdYTW94?=
 =?utf-8?B?d21aY09hNjFNbmcxMStGdHAwajZyRDY4TnY1ZStqWnZYbk9MUXJzTFhuWHB1?=
 =?utf-8?Q?N4wxGSbN/pfMwUjp7H5Qf8ss0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3988c4a-bc74-44c3-9eaf-08dcc85aa42b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 18:44:40.9055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRuCIyPrTl55HqR0SBbsWwZYaAfs8VsPgenrboxPrI0mlp3hCPE04jXRW6zGuukA6+qd1Y6ISEvPFVm8g0Na8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5742



On 29.08.24 18:16, Carlos Bilbao wrote:
> From: Carlos Bilbao <cbilbao@digitalocean.com>
> 
> Initialize the speed and duplex fields in virtio_net_config to UNKNOWN.
> This is needed because mlx5_vdpa vDPA devicess currently do not support the
> VIRTIO_NET_F_SPEED_DUPLEX feature which reports speed and duplex. Add
> needed helper cpu_to_mlx5vdpa32() to convert endianness of speed.
> 
> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
Nit: prefix is vdpa/mlx5. Once that is fixed, for this patch:
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index fa78e8288ebb..c47009a8b472 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -193,6 +193,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
>  	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
>  }
>  
> +static __virtio32 cpu_to_mlx5vdpa32(struct mlx5_vdpa_dev *mvdev, u32 val)
> +{
> +	return __cpu_to_virtio32(mlx5_vdpa_is_little_endian(mvdev), val);
> +}
> +
>  static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
>  {
>  	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> @@ -3795,6 +3800,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	init_rwsem(&ndev->reslock);
>  	config = &ndev->config;
>  
> +	/*
> +	 * mlx5_vdpa vDPA devices currently don't support reporting or
> +	 * setting the speed or duplex.
> +	 */
> +	config->speed  = cpu_to_mlx5vdpa32(mvdev, SPEED_UNKNOWN);
> +	config->duplex = DUPLEX_UNKNOWN;
> +
>  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>  		err = config_func_mtu(mdev, add_config->net.mtu);
>  		if (err)

