Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53F92BE029
	for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641786; cv=fail; b=lgoU0zuNzV1Ksx0s7Et8FjrlkgMUns/DdH2Fz2p/3OTUOwKOJ1AxWQvoPYDP/XhWDnf9sHsBnLz/SYcIW1kVRBVxZoPDIaGYue9PIinwwHYEUtdbC/TUPFQw2R3PE04vd4nWIQfwWVo/vi/sVEGGRVboFiiy6nqzz4dKjOnhvGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641786; c=relaxed/simple;
	bh=zOxbS1FwM2MFCtlDNgGeZlVUYci13QWh9fmAbbPC3mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CwUSo29QZdAm04ztwZZze8eED6Xuxoj4sImSkCbLQCAEywtvOZb1Xl2PSiXSbLJECYJn+SzYLawNpDWz/gX94/K7k5WcuIwXEXa8eZZEsE0I4u6mkDCbPjXj+dmLOK1lZLbBR6CvZVXY1H/RdB7Fl+v7ghWVLdqObaXuYTytnJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NptDrGZY; arc=fail smtp.client-ip=52.101.52.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NptDrGZY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKXWGMxz4ocVcRJ8LN6WcmirU26oVHvjbpdpSDmQNiQPxUs70XN/nRFo0hBGmVyCNfpVVe8LynTljqDRSDu4Ej4J/GAKQ7ZuIScgP96RTuDfdz/QoVydfCLIzE0Yv+hvtBKIK207Njc4JeQvvkaOCL0R0nCChObPyBKBGFJf6drTMMFtc96PBOjBPD6bgG2CkthwdZU46MlgO9bvLju47wWXzqsyFDIHanmYrJQ8h0ePKotQF6HQwVU4oMko2D0Fke37EAenbffUp7Pcl2AOFNW1UhSkZhKCs1jaR8zHJW1CaVJ6UUQL/PPuDtRz8CFkv0C1zQ/w+KHrwMuGjo3n7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RN6YC1BlQGO7tDs3XqpbgIllTTM20QlHQ4qnhWnXqlI=;
 b=wIDbln2+8EkWguDel2whzwHNeudcC0CrhLkc1b4huvHQej3UyGSNdI+lwmbmf0zzkdhKO8HuhlhqztaaJWDyzcqQWmV/h3COnX8gKCPGtswsJDwepZj9zsFtAgSTXHximWbjiI3L+KEale6o57QNfreBmC9Iswhgir6N0WQTRkAYiYmTG84RM0j1gcNjoxBXuXlgHibIoFU5PyZZ1IADY1HfVz5jMMpJI2YZWLUXb3XP9ob7g4cOwIdvLZn+RvFSP+C9HzKh/hyyMu+8j3O5gzOr/Y5ch4bWtfmBnZsPZEnjyGM5eqv/hr6NClz5itQ/PFBUp18CitAy3ip79Ftlqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RN6YC1BlQGO7tDs3XqpbgIllTTM20QlHQ4qnhWnXqlI=;
 b=NptDrGZYku9Cryx9OoqN+ZoT5J8gYyuq85awRNi6dIvh5HfFOdLgJ7R0pa/DWteTpjHPq6rfCJDYhhAA4r29284wXG0iHjoLkhHr+IXJ5VOgmNZWoNHK/2GkVnK1XpeZ8cadhyrDJVVJFIcAB1E3+ROgWRYFXTwvicnDNFAEHsX582pHps+UEpRBvmAODAm7RD/5y+kMHS3v5d/hQD839UYAkIUc0t6pMgw+BQVGa6anv5OZi8U2ZLcY5hybJaRAXrKPw9mR0OTgzOSnoqPMr3Z13RlaVAbF3pGc9RMoeDaHvnKnEeFPU/x0orDOVTMsKl35e/bBjWKvIwkHeNKH3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by PH7PR12MB8594.namprd12.prod.outlook.com (2603:10b6:510:1b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 08:56:20 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 08:56:19 +0000
Date: Tue, 28 Oct 2025 08:55:39 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Wenli Quan <wquan@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, virtualization@lists.linux.dev
Subject: Re: Host Crash when re-running vDPA device creation script after
 interruption
Message-ID: <y7jhsbztzc5cy75354pauxq7xs6rcnsimhdlnkcd52j4dislke@7gtn5te2uonk>
References: <CADZSLS0zp9rqP2=vCh8eHVH_U+g+k_8pitV939u9Ls8ZPEMfJQ@mail.gmail.com>
 <zfddiyxykxaoev4wbaxh6ml6czew44k5mt4jsxylpbybnqbs6y@rcfi5dpy5qv4>
 <CADZSLS1KPX6rgCkdDPqqyYC-R3oBWDGb8o26QQXaG5U4R=8zzA@mail.gmail.com>
 <w5oshdtp3wdhydjmh6htwtgb6keyml2teft7ihu277tbktzbp6@mweh7pyfwlrl>
 <CADZSLS0A_EEi46U_zF+ssfgXWqg_YwekwOsCiNTbbKg3ueNhRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADZSLS0A_EEi46U_zF+ssfgXWqg_YwekwOsCiNTbbKg3ueNhRQ@mail.gmail.com>
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|PH7PR12MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: bcdfe1cb-cdc7-4ec7-1243-08de15ffdca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDllc1ZUdkcvVUJKTlBhTWcyN3pWSFp2U2NncTBxZXhjeE9Bdk5nY2UvaytM?=
 =?utf-8?B?a3F5MnE2ZWRmVHI0RDVpcG02YjJZZUlZdmFZOTBNTHNWN0YrMmwwMy9yVWdZ?=
 =?utf-8?B?MVJNTnFtQ2thMWo2ZFA5clNrM0R6OUdWcTk0bkpkRkJTUy9kZTF6VjBBalBq?=
 =?utf-8?B?NDUrbXRNYUMyN0tSRWhGY3U3Q3BjRzdyU2pybzNyTks3YnlhNzVJdXU0SUZo?=
 =?utf-8?B?WWoyNDRZTG9GTTVPaHgwSFhtMEIxaU9Ib0FBOFFtT3gyYzIzeHJpL0J5cGNE?=
 =?utf-8?B?ZDhxKzJGMkR4SEp2clFwTjVNQkxlaDRPaS9Ud0xwSE5ab3FsczMwY2tEMlVR?=
 =?utf-8?B?cFVNMnl0aG9KL0dOYzNDMjZzQjA0bnlPYnBZUXVRNVdReWxyeVhOSXZPZnkz?=
 =?utf-8?B?YU9TM1dsMHhHck5zWHAwL1VTdnorUXorZGZvamdwQUg5OEVyeFpQdmJPenhp?=
 =?utf-8?B?M3BqKzRTVzRTb1FlZUpsWDdRUVFHb3plSWlqZjNVc3cxbUhlMUpuYk5GL0Q3?=
 =?utf-8?B?VHh5MGJTeER4YWh0bFlmamIrK0tDaDVUTWhpNEFJM0Rpa3Fwdkl6U21UN0Z1?=
 =?utf-8?B?SnZPU2V4REhJWEs2NXlDTzNNQzRWL2JjYk4wYlpMNzFoeGMwVU9DMyt3bEF1?=
 =?utf-8?B?em4rOWhwaG02MERhQTU1T3A3cU9VSElLZ2ZDOEtqSk5VSGgreXplRWRnRUZT?=
 =?utf-8?B?eUl6UmlJc016RU1QQVMxOGQzank4aHZUdm16ZFZtUGZSR29ROU0xTi8xSnRK?=
 =?utf-8?B?MnNOVjBaNzRUTWpINENLL21SL2cyWGxVQkhPVXJlb3l2Q3JEVHN0eG5MKzlF?=
 =?utf-8?B?UWxNbjM0YkR2MjlvbjdoaHFpMEZlN3VZSnlpUmY0YXpOYVJOVzZVSDZyYnJE?=
 =?utf-8?B?UHlGNHp6NWRhNUozTlhUNllXcEhCZFVYaEFINkpqYU83RmI1RHZtMWxTUFJi?=
 =?utf-8?B?QXEyR2F3bDlmbGdUMWwvTWRYbnQrMjRMWktZV3N1VUJudUw0WHpuUmZxRjJT?=
 =?utf-8?B?ZzVQeFk0bW9rZE9mbHBieTUvZXlhcjYwZU1EYlZtWXhVOWRZRklQVTVqMXBo?=
 =?utf-8?B?dzFzTDU3b2hkZWxYNkRVeWx5SVR2OC9qcHZoVmt4Z1VVTFVWOUowK0lHU3VM?=
 =?utf-8?B?QUprMW9WMnNISGZ4QXJ1bWEvVWYzblFUR29IKzcydldERURWSXdjZW15dS9Z?=
 =?utf-8?B?aVYwT3pGQnBkaGw0dXVjb01zMXkrWDFZOTg3Uml1dUlFM3Z5THNYMU5ZVmkz?=
 =?utf-8?B?N1VVUHUyZVlLN1lZaVNqZjVsbjVYQk9CcU9HYmthVG1PclFKQTZ4dUJ6STVU?=
 =?utf-8?B?V0NNMW42MktVYWZwUjlHRVFYM2lTSFdHdEhYYXpWYTk1MjNKcDRQYVBzbVh2?=
 =?utf-8?B?TmZDSWZhaEJnME1yTnFCZHRSRHRvRGt4RGE5b0NVUHhvWjQzQ1NmS1pWdmdy?=
 =?utf-8?B?WHpqMnFiSWQxdTR2YWU0YTFoWlR4WW9SVDY5UXVsS1psWCtSajhpbzA0Wm1u?=
 =?utf-8?B?Uk1nbUg5K0tVY3loMjVrY0U2bkd5alRUL1hiZW5ISFA1OGROcU8yUU91ZWRX?=
 =?utf-8?B?dklscHl3Y0tSUmltN2djS3A4WHZ6bEtRYTFQQUVFQkh6OTJDbWhJVTRreTBM?=
 =?utf-8?B?cHFpUTNwN2xEY043SHpZS1B2RUF5ZTlKNWs1RWxIRHE0SG04aGNxTmlyRVI4?=
 =?utf-8?B?RjlWVmFONmdJR0M3eHRhUllxY2ZhSTlPMXJvUDVrQ2tITzkzWEtXWFFxUGRO?=
 =?utf-8?B?eDdjcG8zbTRPK2V1YmRVUGs0eHNEWTFnSlNCYnNXWWZWWFR4VGQ0eFhRZUlW?=
 =?utf-8?B?U21tZTh5azJSVVNxc2gzWExnNUQrVjZBcUhkV3ZRMU1Sb01hR2pHWkxWNkk0?=
 =?utf-8?B?bGcwZldHVnFWdnFBMEg2Y25EVXhKaHlWUEh4ckhxUEt4QzkxYitUTDllaXFi?=
 =?utf-8?B?WDEwOUROVjNGQkt0SFBFc1BtNGswZXhERWh4RVFGbmo1aWdGV0dvcnh4T2Fu?=
 =?utf-8?B?WWxCaXRqV0FBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVpUM0JWZUJPZXVEMS9ETTJjSWZpZzBmQWJUL08vSnJGVFJkYm5DK2xra1lC?=
 =?utf-8?B?M1RvMHJITGZYc2xFSDFaUWxDNUZVUUtoNmRYQjhZbzZqQWFody9vQzhaNVpx?=
 =?utf-8?B?MmZpWGtVc2RyR2hkNDY5THZSNmFOMW44VjJUNS9FVVRnWDZJNC9yZ3ByVy9E?=
 =?utf-8?B?UnRqWUlzRWVOaUpCVXZ6NHBUNG0zUThSNVBJN2EwTmlGTm5jU3BuTHVLdHdG?=
 =?utf-8?B?ZktScjNiZ1o0bUQrQWFLVU11MlZTZDVmQ2hwMzJpRGpCdi9SaTNJL28rV21s?=
 =?utf-8?B?U1U3WDV1U2djYnBhZlBobGJhNHgzNWoyeEthb25hd2dEanZaV0tqTDJ3ZXpo?=
 =?utf-8?B?K3U4dHZkYkYxcjgwMWVFZStwZ3NFb1BzcGVlbEVRVUd2UXJsM3c0T1JnZkNN?=
 =?utf-8?B?VXAzOE15ZFB6R2NKTUZieHpMSEw3bkVBZU9JUnJxTjJZUENON3pZSHdWWE1T?=
 =?utf-8?B?NWhLYjlCVXJQY2QvQmJwT1NLWitWbFhUTVhGSEVkRDFsWEVuK1BsbFdieE1q?=
 =?utf-8?B?WTZVNzh4L05GS2g2cnNMeG1OaDVvdE5LWU8vZXBJWnFHaVNWd1VCQzlwcUVi?=
 =?utf-8?B?TFU5TDJPL3E2SDFURGtmclQrMEFrc0RXRHRtU1lxSzg3dzl3b0s2TGNERlNx?=
 =?utf-8?B?N1FYeG0rLy80T2VXa1VzM1BOZk1HVDNLRlBqb2NwNFhiTEljUTJLbllWenBF?=
 =?utf-8?B?NitVOWM5WlpXekJQb3hyN2EraitBd0hCNzVIY0h1ODRndk8yQzIvTEpRbzU0?=
 =?utf-8?B?KzBKS0dzZ2dPRXlNZW9UOTNQSE9FNzRQcHVRblZ4K2ZSQnY5Z0Z0RktsWVp5?=
 =?utf-8?B?WmZBUGhIL1RnMEdnRzZTazM2bndDNUNjWjB2TUNiSzBvMkEzcjlYcGNwYmJk?=
 =?utf-8?B?NXFPYmhobk5RVXFWdHdSWkYvSnV2anI0STNUbGw1dk81NC9IaE1mbzRSWjMy?=
 =?utf-8?B?MTVBWFdJNmNmQ2ZpMldOeDA4eGZQNUh5elVVWk9jbDI5a2MyKzFqbFNZZlgw?=
 =?utf-8?B?TTB3aVFuVFhwTVJUMmhQVXYvVGhneE9EbkozUG9wbnl1WnRDS2FIV0d3UzQ5?=
 =?utf-8?B?MlpBQ2djcGNIalpwb1JsUmkrL2p3S01lYnE2QXEvZUU2SnZqYWVCUWtvMVNh?=
 =?utf-8?B?Zmg0cTZ0TTFoeHAyUjA2TDVMeG55NUZhYVhVd1ljYnVUSTZGWjdXekVpZlAr?=
 =?utf-8?B?MVRDT3YvMXhVMXBqV3Z0SVFXVE96L0dsb29EYWdNZ2FXeXl1bUFpa3lSeVZl?=
 =?utf-8?B?dEpjbWNxOVh5VlN2elVmREJ4cXVVc1ZKU0hoVlNHK3RUbGhIOSsrRVNqQmJZ?=
 =?utf-8?B?bjZVMzhGU24wQTFNSjFxTEtwSmI3aC84bHBMYVVCNFJHZDZSS1dDUGR1aFhi?=
 =?utf-8?B?aHBGY3kxVnlJK3NMbHduTkFNanBaTzlYb3VYVkpmNmtzd3pLYnJPT3Z3Q2Y1?=
 =?utf-8?B?TXdoT2ZoSUhrRXU1MnFhcXdTS0pXWmtMSlBRWXluNndPNUtpdFV0Z0hwR3h3?=
 =?utf-8?B?N3NCZkhXVUVLV3JRK0hvNUVUUTVSd0EzaW1BbVZHNkRvT0xFRS9kbjRxdTVS?=
 =?utf-8?B?QjNRcVRjUjVvUGovMllacElLNWdWb2ZSK1QvY0RLVWQ3SVArbjJBMUVuMTgy?=
 =?utf-8?B?a2QzS0NIZkQyWjZPSFF4V3VUQjJxbkxLRWVnKzJFWXdUSDFVb1B6NWZ3bDlt?=
 =?utf-8?B?MWVMZWNHWDVPWTBIbWpmd1RtV3hGZkZlTFVpMnJ5Smd1MTZ5Y1FWZ0owa1JY?=
 =?utf-8?B?THgrK25aaHYveGY1OTQ0cm4xQ3Bjd21SM0xXcDZtc0QydTR3UWVUeUZzZTV1?=
 =?utf-8?B?Qk9iYWl2Qk5pTmdQQ2ZERmFUM0h2NW5sclZ4bTV6cEFRN0pldC9HcHZJczZS?=
 =?utf-8?B?VEJnQTJxbnRUT1VMOTd0TkY0Vloxa0NHcTBLUHZvb0tXRWxPa1VlSkd3V0l0?=
 =?utf-8?B?a2NZTTZLbXA1ajhEM1hScUhhV0dXb1dNOWVUREQwRExHeThaMkZ2Q2pyYXFS?=
 =?utf-8?B?Ujd2Snh5d2wyaytZSnhoeERLQ2FnYmx3V0lRVmFTK1B0dW1UcDBXSTFVemRL?=
 =?utf-8?B?M3hXWGd0anFtdllyZFpMN2VBTnV1ekh5TndCWlY1UG5kRHZtK2NIenQ4M3ZO?=
 =?utf-8?Q?MvuIs6Cwkd4+Df5kmKnzp1zpR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdfe1cb-cdc7-4ec7-1243-08de15ffdca4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 08:56:19.8309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCpbIs7qp3mYq2cDz3Ju79lQC8ELMNsaevgjtlb7JkiLBRBOTxb4eb4Dh1ZAv5vOqa8CqM9rs/qAOYjkj4mmCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8594

On Thu, Jul 10, 2025 at 06:18:39PM +0800, Wenli Quan wrote:
> On Wed, Jul 9, 2025 at 9:08 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> >
> > On Wed, Jul 09, 2025 at 08:59:13PM +0800, Wenli Quan wrote:
> > > On Wed, Jul 9, 2025 at 6:38 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> > > >
> > > > On Wed, Jul 09, 2025 at 05:36:04PM +0800, Wenli Quan wrote:
> > > > > I am reporting an issue where the host system crashes when re-running
> > > > > a script that creates a vDPA device after interrupting its previous
> > > > > execution. I am attaching the script for your analysis, as I am unsure
> > > > > of the exact step causing the crash.
> > > > >
> > > > Thanks for catching this Wenli. We'll look into it.
> > > >
> > > > > # uname -r
> > > > > 6.16.0-rc2
> > > > > # sh vdpa-setup.sh  0000:b5:00.1 1
> > > > > interrupted by pressing Ctrl+C
> > > > Could you specify during which stage of the script do you interrupt it?
> > >
> > > Interrupted after running for a few seconds.
> > >
> > I was not yet able to reproduce the issue.
> >
> > Could you print out the commands of the debug script so that we can see
> > where it was interrupted? set -x should be enough.
> 
> I tried again many times, just to reproduce once. the following script
> for your inference. but it doesn’t cause a crash every time.
>
Hi Wenli,

Could you try re-running this again please with the latest mainline as I
was not able to reproduce it.

There was a relevant fix [0] recently that might make a difference.
This was merged as commit
6b4be64fd9fe ("net/mlx5e: Harden uplink netdev access against device unbind")
in mainline.

[0] https://lore.kernel.org/all/1757939074-617281-2-git-send-email-tariqt@nvidia.com/

Thanks,
Dragos
