Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D43B1662E8
	for <virtualization@lists.linux.dev>; Wed, 28 Aug 2024 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837854; cv=fail; b=JRuuYeKl4VJDm/qNKsldn0mt9/wMl/7n2qcuBZno1e74acdBaKyR1+g7AORuY+iMAUT/OmfEdfnCk8RfK08yIkDCZ5H2NOgTJUtYGGWTefhH7cor+V8cawRM6t8L6dCML6J6ZvCYLtuYK6awLf+qnpmPCNloic1C6Pf5nroNbMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837854; c=relaxed/simple;
	bh=e8+tGlYBeZQQC43nWfiL78zeaLVPSjxl1ErR5YsG7Y4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dfi+luwdw6o9zxS/+J+1ttVkya7IYXPRjY/8N711D/Ax+hggBfV4waSvKogAK0xy/t0X5Gdq+yXmvgv5oAjLLJAjiB+b1U6AZ+/E+1gka6VC8b1JhQZwPjr9tnXhzbmVSfyTQ9v0Z4aKBlsnf5FLgB5ES0RlufzUB7re8wgIGoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G6k+EUy9; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G6k+EUy9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MllBT62lxhNlp6vTO9EMrVLcQfwr4kOHICXb/Ob+Jh/VS0+EIQ03qvNiZUTtpJZ0U3qOqB4uv7LbEXMOqPhfxOG83LJRR2HG3VjEUFdoidKbrapXKdITUS3VjzNt+FLPv+tEEwuSLvJsr+JR8+TnLDipKV0+1rtpxiysx95o8DS0+QeaqvbpZARuckt90FB9Sbt+3X8xdTyFOO8U3lCPf2Qd1t75j/f4vNKpWy2cHC/plzAQoHKbsxZBlGzYu8ZVTh/3Syj41EOvH8nbjr587hpf7DpgjiIh62o9agFOKe0S8+sMtqW30tqhisx98uSX1oN8zW/j0bzgLoaI662G+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=We+T8Vz5chgRZzZsYGKdFqqxb9g4uXN6WQPf3Emf4tc=;
 b=Harknubd35K7Ubcq4o+//st3NNfXSBIx/hia03o2cjqRi+VLA8DOEQjye3+vkCgSAWUzU/9GNK53L5D5Y1PYZCLVCi0jya6tNexaFusQTDiylrjO4tNwxEHcAQvXncC03orO5nvmGCccEU2hxK8IANGDR9EZTlCbBSNYpytbU4sHmirfcqHFT4WUT8HOAx1oR4kXYFlAJwzGggqwS7/HHbalufjDrpQAUa8jz6fU8A/zDHWbMo/GktDZp1Mb4swgZSj5dy7Owt6rxlJBf85rsdnGivxRleV7We/l6/urcUm538HsiwFkT9io53UmvEq1E14SBHdO9B3cOSnCEl0XGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We+T8Vz5chgRZzZsYGKdFqqxb9g4uXN6WQPf3Emf4tc=;
 b=G6k+EUy9lbaVkZMl9KRsfNGzadVRKsvus+/kY/3QDhcatpHe40toxf3iPj0Iy2iqKzY2vkqg6VPaqoyVEd6xds/o0sLbvSoant+wJOSLoGSFfbCR0TVGBqzEKxZQk85Mt5GyG5uLVV/VC8wFb7/Su7yStumvCmmHhk1i/ZRGIaxbLtvu3bbevZCqdpclmBRs7oGWQqS3G6BdoNri7Tof+4QU9qELDiAzyYyIbSqE1wHiIYHyWNZw+NCOwwSuk28fwOaVOg6z98ot5i8bprmwj98tjGPIJwsE5yp/De9JnwXsy0PWSOzw8OY+sOjIpniRQGHfQVLOkunEHOfy1pu9yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 09:37:28 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 09:37:27 +0000
Message-ID: <8daf221f-8d87-4da1-944c-3bcd0edea604@nvidia.com>
Date: Wed, 28 Aug 2024 11:37:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC
 set
To: Cindy Lu <lulu@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, si-wei.liu@oracle.com, Jiri Pirko <jiri@nvidia.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240827160256.2446626-2-dtatulea@nvidia.com>
 <CACGkMEuRvqu8W9-OqPBRhn1DG-+DO6TCzFdHqc7zB74GkNDkAQ@mail.gmail.com>
 <CACLfguXjiyp+Ya4mUKXu6Dmb3Wx5wW0bbNGRSFWE-Z0E5gALTA@mail.gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CACLfguXjiyp+Ya4mUKXu6Dmb3Wx5wW0bbNGRSFWE-Z0E5gALTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::11) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|CY5PR12MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: d1900bfe-9e03-40a9-8a97-08dcc74507a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1YwYXVodGxJTWJXL0xwTFVhdlMxOVZyK2xremthdXdnL0ExV1BTcGN4WC9T?=
 =?utf-8?B?WHo1d3NIeXdOTUV5R2tjUVJDaUxTYnU5elRSUWN1bkZkdVA3ZjdTbEN2bUdC?=
 =?utf-8?B?QnBmN0NTdDVqNVllWmdsTnpPYnRHQ29vVHhUVDV3alF0UFpjSW5sTllUZ1Fs?=
 =?utf-8?B?Y21yaWM5VEFDRm1DekkvTUFGbnZUZXh5U2pIcmFKRW9VTjJTbU5yb2dhK0h5?=
 =?utf-8?B?ZytVZXVKVWVFREJxcFo1K3NkTXVRM0xtZERIM0F6V0p2TDdwZGVTbVQwZ3B0?=
 =?utf-8?B?a3U5eElOMW55L3Jmc21jUkE3QndGTnZZRmJYeHo5UzAveXhyV0E4NldKTWhP?=
 =?utf-8?B?ZjRiUmJXWC9OdlpGV3Ixak9qL2VvMlNpUVhTcGpRTVd5d05jc0F3T1l5ek5U?=
 =?utf-8?B?Y1RMeGYrWVF0TVkySnMyM3h0ZnRUaXY2U2E3T21PVXF3dVN1NTlQQmtwMzdt?=
 =?utf-8?B?NFRkT2dvRDNZcVZqTmtXZm5sRkUxdTQvUzBIL1p5MW1Wc2FVY0JIeis1Tlda?=
 =?utf-8?B?L1YxU3ZvRVVLYWYrNGI4b0t3M2VCb2NHSExqY3V0V1VmVG9adkk1Zkh0dGY3?=
 =?utf-8?B?VDl2THl4VzJGMEh2MFZzU2Jkc3J2OGdzdUNKWC9XbUh2Nm1RTmNRQ1hFSXVX?=
 =?utf-8?B?by80OFJ2NHlMWmtTdUhkczgzUGdHd1ZwbUxRUTlYTitZUjFLVHhWbkdNTzFY?=
 =?utf-8?B?eUhMQ0pDRlpaczh0cmRZRTRhaXM1Qkk1QmhEZVRXamZXWVg1Tm9ka0NSL3B5?=
 =?utf-8?B?YnVWWVZGL3pJeUZtc2JndDdITFVlMllOMUxPWEFKSHc2aXBKazRPcmNwM24v?=
 =?utf-8?B?MHN5N1JrU1lZRjhBT3h5WERmTURIZ2NaYkRTbFZCNHRZTXFTR3pDMkgwYS83?=
 =?utf-8?B?a25Bai81TnpIMDNKa3BZdno5MlFDckZuK3IrRUp3SnU2NUxTcWhZVVY1V2hI?=
 =?utf-8?B?Q29TdWpLT0w0Q25RR2ZNdkZkMExzWmpsZGs5UzBGdzdxYTdDdm1jVjMvOFBz?=
 =?utf-8?B?dlRET3RTR2loYitERDRxc3BnMlFtTEo3cXJiOGhxMFRiVFZncTdQak1jTmVB?=
 =?utf-8?B?enY0aHB5Q3d2MGFaRnpIZlozNmZSYUlsY0pzNzRsaUorVTF0bDlvZG92Z3Bx?=
 =?utf-8?B?dGlaTmMrMnZxekhuRGIvUlNvZGQ5Q3UwMnhNUXBmVE13L2U3RUErOXU5MG8r?=
 =?utf-8?B?WVZITU1PRHhRUHZhTXA2OGlqZDBZTnp5RG5Bb1JqSUU4VGRzSm5mRDUzdUZj?=
 =?utf-8?B?WGV0Nmo1RjYrVmhGSldPcWRGM0Q4YSt2NWRXOU5FY3FQWmh0YmVsSW03Y3My?=
 =?utf-8?B?RnlXTldKQ0dVSDZWenlPTTNLenNhWGR2WGczNm5XNFpSUlgyaERYQ3d1WlBT?=
 =?utf-8?B?KzFMTURNZXhUY3BVdTlKaXFqckRxQ2RZUFkvZHh6VUtEOXdoV3lhbzBPV2lp?=
 =?utf-8?B?b3QrV2hYRk96bG1USjd6NFJESyt0VEdaNXZPODJpZnZNRzVyaUo1SVFDNkxq?=
 =?utf-8?B?QmVwVllGNGp5M210MEw4STd5ZzlieFFMVmtyK0pWZUYzSDBoUEtWRCtwREJI?=
 =?utf-8?B?RGFCa2pTKzJUUGhOd0dMNjNhREJhUjZkaDA1UUUrMmswdnA0aExHUjh1aUNE?=
 =?utf-8?B?dVlCTWp0cEw0SVF3MEtRSjdjdzhRT0trRy9rcXl3ZWtwaUxzMWhJbGZtbXJU?=
 =?utf-8?B?TjhLZ2M1Tk1VUU1sRjl4UnZSMXFsbEd2a2UrK05mNWxFdXhCTWtzZFlqVHcr?=
 =?utf-8?B?Q09VaVJUSkYwSkg4dzNYODJ0SkN6M0UrbVlYcTFqbmxsYUJuTDk3Tm10UTNy?=
 =?utf-8?B?Z21Bc2FjNHVNaFcrL1RRdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVAyQ0hnT0YreWlmZmt1TjlOc016VDNEVEdyckF4RWxzTUN4eWxadGh5MUxx?=
 =?utf-8?B?SDlSVUxHaVhlc28rRExHMS9QWW1nZmFJb1NpWU1oNEdjWENQRkdFTmpoblND?=
 =?utf-8?B?UHRYMDh1RzFrZWd0L1VHQ3Y3WFAzZ2t5eWU5aWdjZUlaUjRISzdXcDhHemFs?=
 =?utf-8?B?c0ZITkdrSlpMaDErLzNkaEdtbW9rT0d0dXFLelA4eGpSQlVoSWtBdmVxUC9S?=
 =?utf-8?B?L1pxbFBNVm1JeDZTUnNJQVVBVFlYbjBXd2lRaitGM2I1elUrN05aLzV6c0FR?=
 =?utf-8?B?NjlRTnAyNDRQL2dPK2NjenZkRkI5SEcxQVZMM2MyNHVvQ3hLRFVPSlh0STVG?=
 =?utf-8?B?aDhJQVhDNFZFTnFqRjE0WnRPcDZaNUUwKzVtMWlhSUtHd1dwdjBCdkQwNXpk?=
 =?utf-8?B?V2psODkweFNWQmNqNk5kbWJuNkY5bk1yS3c4Y2wvMGhyYkhPMUZPVUN3NCsx?=
 =?utf-8?B?amlGRFFNYkxaWERhRTVUMEpPTTVPTVQrUmQ5UVFzZzNVYlpucDNPQlNTYzVa?=
 =?utf-8?B?ejIvdzNIZFM0QWxIQ0lhMDlueTdQdjJxbjAvcVJ4Z0d3Y2poOE5DRzQxdFVn?=
 =?utf-8?B?NnBOb2JxckdLSVdmZnRMZmVlTXBSZjUyaXlESlJKcDR1ZFpFdFJ1NTM4bjNz?=
 =?utf-8?B?c3ZhNjNFUVlIclc1UmZPWjUrSmwrOFNDdFg2eUdyQ0x4eWhMNzZPMmRRWkg4?=
 =?utf-8?B?ODdzMDFoUWp5OFNWUkhIZmxqbENRUFF2dTExZnkwWFNQMTQzOGd6czRwTDhv?=
 =?utf-8?B?eG9kWEVjUVBYQ2hxR0ZCTUtCV2tlakI0TzhEQzV1eFJHTkpRTzZCbm0raXd0?=
 =?utf-8?B?VFFXbjlLNmJzZUhjQnJJYXhYZ3ZhcWF2aTdXS1ZWR2RyTTlXaVNkeDRzTzNM?=
 =?utf-8?B?VUNlL1VNWlVUQU1uRldxVVRnR3FTZmg2Zld4MXA4aWZNWEFudlV5SUIwWGpn?=
 =?utf-8?B?a001aFcvMzBKTUlpTTNkc2ZkM0UxeUdCZ3ljR2FtSEZ3UlY2YXE2ZXBXaW9L?=
 =?utf-8?B?eXNsbFRtUkZpL043eVVJLy9neXJwKzhDMi9YU2VHRndpMkoyalVzTXRhWHM4?=
 =?utf-8?B?TWI4aUVaZ3ZKMS9YOFMxSWxSRXQwYWZvYnk2Y0tQVlQ4OCtrYm9JTjZhZ2pD?=
 =?utf-8?B?RWljZVc0blJHdVZ1RWRtQ2VnQ2xvb0hyd1NycUVNMkEzdlFFM2ZiQ2xYTjVX?=
 =?utf-8?B?YTAxYkdvZS9sZVIweng1L3JpRkRBQ3QyL1hiUkpwcENvT0tXOHJGNHFhVlZq?=
 =?utf-8?B?WEtNUlVBeGZaYjBtYkpXU0pMTlU5M3NsZDNLQjVNREVhMDRZQ1drbGNmdmRm?=
 =?utf-8?B?UlRBdUpZLzNTMjRkMndyaktLZmxWNVluNzdGc1FGTWMvbDhMU0ZpVmx5Ukto?=
 =?utf-8?B?UERRRGRjMGxSdFVsL2xoSit4RDExVUh6NmVCS09zSVUzYnptanhHb3Vld0s3?=
 =?utf-8?B?ZzFaWEFpait4WkVobGtHTmUwcUFUU0RYSkRKVHVuUmczeTc2cm1oVmJ1ZmRR?=
 =?utf-8?B?UHdFM0R6S2MxRlRVcUFZWEpwakoyMzFMZjhoNmlXTU5BeFlJaVNCdEw1TVJC?=
 =?utf-8?B?SnkzNEJqbm56M0pONGZnMFJRVmZ3aUc4aWRzdDVaSWdTZS9HcklrN2p5bFgr?=
 =?utf-8?B?WktpVXhyS3Z5MWgraUdIM2dEN2VSMGNndnRFSmlsZURFN0pYdm92anBBVC9W?=
 =?utf-8?B?VGVwVk5EMEVkWHNOenJiTDh0MTVkWmMwblduS2xPSmxuTXptZ3lwbzN5dzdi?=
 =?utf-8?B?RTN6YWpIWVJkV2ZGOWc2TStaV0JlZHhrcXQxb3VhTDhWeUsxajhPN3BsYmQ5?=
 =?utf-8?B?NGkxazFmMG9JVGRuUzJJUXBQaXFERGF0VG5jR05jbTNjR2hhbkZuOWpucmw1?=
 =?utf-8?B?NXFWZ3FoN25KWHFNUklFdFdvcEdUZytKN25KVG1OYWFYeGh5T2ZodEVqcll5?=
 =?utf-8?B?ZEJWWFZDWXFVRUtUVkhTdUxubUNSMnpCTkJXTXdGVHhsVkNSWDNQZDBwQkor?=
 =?utf-8?B?TDhEUFAwZ3BpWCtxZ1UyTzQzQWgyL2RQT0JWL3BzdFpERDZqa3ZxcjZXK0la?=
 =?utf-8?B?aWZXUzI1MEc0Q2hHSHpkWVVrelEwc3N6TXM5VUpLWmpNT1Roa0x3K2JodFl5?=
 =?utf-8?Q?aHS9VhIbJ4trMozPOrixA1CUt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1900bfe-9e03-40a9-8a97-08dcc74507a9
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 09:37:27.7244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9g4whluHo4Nsr2zHo8LZslJKYkpB7zXpFyQTMjwibMujwFkl44NVToVjcC3PerSBYxSuNd31jNtrCklDVKAtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323



On 28.08.24 11:00, Cindy Lu wrote:
> On Wed, 28 Aug 2024 at 09:51, Jason Wang <jasowang@redhat.com> wrote:
>>
>> On Wed, Aug 28, 2024 at 12:03 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>
>>> When the vdpa device is configured without a specific MAC
>>> address, the vport MAC address is used. However, this
>>> address can be 0 which prevents the driver from properly
>>> configuring the MPFS and breaks steering.
>>>
>>> The solution is to simply generate a random MAC address
>>> when no MAC is set on the nic vport.
>>>
>>> Now it's possible to create a vdpa device without a
>>> MAC address and run qemu with this device without needing
>>> to configure an explicit MAC address.
>>>
>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>
>> Acked-by: Jason Wang <jasowang@redhat.com>
>>
>> (Adding Cindy for double checking if it has any side effect on Qemu side)
>>
>> Thanks
>>
> But Now there is a bug in QEMU: if the hardware MAC address does not
> match the one in the QEMU command line, it will cause traffic loss.
> 
Why is this a new issue in qemu? qemu in it's current state won't work
with a different mac address that the one that is set in HW anyway.

> So, Just an FYI here: if your patch merged, it may cause traffic loss.
> and now I'm working in the fix it in qemu, the link is
> https://patchew.org/QEMU/20240716011349.821777-1-lulu@redhat.com/
> The idea of this fix is
> There are will only two acceptable situations for qemu:
> 1. The hardware MAC address is the same as the MAC address specified
> in the QEMU command line, and both MAC addresses are not 0.
> 2. The hardware MAC address is not 0, and the MAC address in the QEMU
> command line is 0. In this situation, the hardware MAC address will
> overwrite the QEMU command line address.
> 
Why would this not work with this patch? This patch simply sets a MAC
if the vport doesn't have one set. Which allows for more scenarios to
work.

Thanks,
Dragos

> Thanks
> Cindy
> 
> 
>>> ---
>>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> index fa78e8288ebb..1c26139d02fe 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -3824,6 +3824,9 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>>                 err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
>>>                 if (err)
>>>                         goto err_alloc;
>>> +
>>> +               if (is_zero_ether_addr(config->mac))
>>> +                       eth_random_addr(config->mac);
>>>         }
>>>
>>>         if (!is_zero_ether_addr(config->mac)) {
>>> --
>>> 2.45.1
>>>
>>
> 
