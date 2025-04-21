Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323AD25FA1D
	for <virtualization@lists.linux.dev>; Mon, 21 Apr 2025 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745233537; cv=fail; b=dqSOaPrrsXUbey/9zFf98WpWcYJMlZm/XsBAainmDYGyZ5UwBQfoBa2X9+y02wrNVD6vp5ycubGo68dIJYjjNOcnk4YjAsAAY0C+cl6WZkTcmSAOHAPcz16tnyBkiBwrrGVNgvsTzJNNR1ES7Z/kumgNGCHMNtO6geoV3965r7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745233537; c=relaxed/simple;
	bh=SxyD0r3tgerveVXTqicn4aCXhcHabPTd/TnBaptH1S4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fKA0O+QDH5vK5j0LLK/LvXsH3Q43l+O1XIIkRdjKqSaNlqYQReHTurKR5jDEvdH6pI1BGlVH63TQkIo+XLhs7r8HfrKYnvhcBoQX3BFIX9d/4oJUkGJhSlw5MAtwgkrjhTen5ovBYua2erMJxReE+rw2D6u7TWH7bF0B0D2if3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VRuvR4gM; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VRuvR4gM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozjxPOnQcIyqXpzpyasegaoiOaRBdFXBju4Q/UQttmsW9XBAzBjodhfZ6tGkSOv5n2+boiZR6kf9IaGeuzz9PE4N3CbEsQMkxaweNEiUSsBLXAyNjqClGxFtz4RBtZnHUMcWpW7hCSWSdy4tp0Vzi5evKa9Ks83ivNlkBKyc7D4yuHF5ZIvoW2jJllVzbIA8w0tGNTnry+xxoJ++lHuuFOmJufTHK92R68ugiusXfDAXW1bk66SfvRMSCojdXCgZ/jDhK1rtN73icIuNfBqGMaKg+VFsBVC4sAGx8Fn8ji3mRIrzytNHXMgLfo7xdpt09ZQsSriVeE7VrCzCzjKhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jpoc/OcgQfWpnOvCQ453rhrS+JWTXMZk8gUl08drCRQ=;
 b=u141h4V85EfDNrRxvd5bQ5Jjvx6XrIGxcG6AW6twVRRxqdvbyv5VcWv70MU4MuF/iKsTkdfUMD9bIVDE8ZtSuY8M3VoTS570tYXO77tAhD/lXe4x4toPEI0EjUcYg/83mnhyFfzJXqvxvHs2+vznIhCGNL4Mp+6JIsAkyRs4p9rpDILnP56VrWc0Z85P38kTW7kxRnwcZ8qOqUdreeLIvjXY1lXcH70vlvMhMDpLxWjnDkgypB/hbFWTaVOYLtHVPxOUkq97b62OMpkmIVxsqs1u/strh4pmIOw5vBblfS43Dvramd6fwtFgF6hCTNGacl66jVj01qZB2uBDqrEKsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jpoc/OcgQfWpnOvCQ453rhrS+JWTXMZk8gUl08drCRQ=;
 b=VRuvR4gM8KPSUCX1P/MgdbkgDsmC+u/kQATiRzt35EiBIk2yNRF25917HxK+q8+g1q4fB9Q07fAd8cejPxWvNJPtMDi8lYpd/w1ycB1c7ePb1QnmqUJ/yXO6Xlx0Oy4R4oJJ0bOcd/DQ5jCirLXM/YMQ1Z1k1UEDSNLlCZ1fvpR9IGvGZ2lmcjsbAPOCpdQed+ozC0ql/AABcpVwsOfzlwGQ6WJdfnYkU2lGl9brxQN+h/pDCm/lqPzt9A0+HMbvHKNghOCLVEsP1nWey71Lav2kGymU/9+Lf9VMhGNiJkZ/xz1fnYJdShvjNctIfR3VA+F2Wc2vnev8igPlJDBJMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 11:05:33 +0000
Received: from DM4PR12MB7646.namprd12.prod.outlook.com
 ([fe80::d87:f674:2f:1c0d]) by DM4PR12MB7646.namprd12.prod.outlook.com
 ([fe80::d87:f674:2f:1c0d%4]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 11:05:33 +0000
Message-ID: <f8ee410c-bfbb-4364-8e1e-c73ee7147fc6@nvidia.com>
Date: Mon, 21 Apr 2025 14:05:27 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio-pci: Add admin command length check for device
 writable portions
To: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
 Nitzan Carmi <nitzanc@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <1745147945-194225-1-git-send-email-israelr@nvidia.com>
 <1745147945-194225-3-git-send-email-israelr@nvidia.com>
 <20250420073230-mutt-send-email-mst@kernel.org>
 <b9e80050-9d09-4ed7-ab05-6a23a8e6e6a9@nvidia.com>
 <20250420090604-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Israel Rukshin <israelr@nvidia.com>
In-Reply-To: <20250420090604-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To DM4PR12MB7646.namprd12.prod.outlook.com
 (2603:10b6:8:106::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7646:EE_|MN2PR12MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: a1eeccf1-91b4-4b7f-cded-08dd80c46f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2RtcGoxOGwzejQ4UnI0Q3BvbmxJMGd2MTRObzdlbEZpL0lYanBnQzBsa0w0?=
 =?utf-8?B?ZDRPaUJ5bUR5alBLSXkwOVViZUJrd0xNMVR6NVhhcDlFZXVjSGFudWlIQ0oz?=
 =?utf-8?B?VXlteGJNbnJIdTdadmRHdTJYdnN0UWtiZ3FsR0U0WnN2M3VWK3QrbE1NMGl1?=
 =?utf-8?B?cGFzRlhpVkRQc2hURFVaZkg2Q0ZjNisxb0QxNE9nVExWb3BrNjBZaEQ2Mzhm?=
 =?utf-8?B?SkpzWm9DYnkzVjJsd2NMWXYwZkErQXV4NzdZc2lFTWNjZVp6cGhHQkVpaXZI?=
 =?utf-8?B?MVlsSHNRZVYyQ0pIbjkwNlRabkJhL2xvREtUdmxKKyt6M3haZENhL2ZSZ3Ex?=
 =?utf-8?B?YUsvSlI5N21BU1E2OUtaNGsxMmhNanpPbDFwWndPMUhFY1VqWWpIUjNUeFNl?=
 =?utf-8?B?ZnpXN3dobVdjSzJsdWs1SW9NQ0NQTE9UekVKSUh1aUxiV2R4Z0ZTS1JpRjRC?=
 =?utf-8?B?YjF5Tk4zemZ6TVZIZTRaMWlmWlU2dW1hTU1qUFJDdytwYlZBeWFMWklhVytz?=
 =?utf-8?B?N2pZSVRKcUlXMzV1bTJXVkpJTDlSWGpCS2VkQUtNaDI0SGJkVGVaVGJUZWs0?=
 =?utf-8?B?am13RGg4T3pXT0NGd3I0OHNwUEtwWk5WQlVZTklzcXp1N3BFekNFbUpyOVov?=
 =?utf-8?B?MWphc3ptUFl0NFl5ZG5GWUl2U1lPYVlKWmFpNURyTE9IdWpyK1ZVZCtMV29h?=
 =?utf-8?B?WnhSMmEybUgzWEFRaVlabGtveUd6R1Nmc1BldWFCUWNNK0hvOHE5emtjQ0hB?=
 =?utf-8?B?UEpDMys5SUFFai94OTFBSC9GZWMwRWJZWmk5SmlqZHZnNW9yQjVmRzdIdWhS?=
 =?utf-8?B?dUIwWCs1UzJYQ0VaNGhTZzRzTXRpaVVEOTBubUNTNHVGakxIbktKeCs3THl6?=
 =?utf-8?B?NE5OeGtlY1pBaTgxcWtiSEVib1cwQlp6V1AxNE5ZaTBlbHhTTThhRXNyRStY?=
 =?utf-8?B?OHRxRHA2VjdVejZtOHl1QTBSSDRtZ1RYU09aSDdrdjZ1anpTTHV5ZmNlYVpK?=
 =?utf-8?B?VSszcnlkblVXYzlOKzM4Lzk3STliWTJXQngzYUZSdnhaKzRzaXJ3VHphL1ZD?=
 =?utf-8?B?b3daL3lMeTVVeW1sV3p2aUNoQ1MweVFtVi9NZEErOGRuTmZpbmhKZG5zVWlP?=
 =?utf-8?B?MktHWnVzNzVyZ3psYmVpVG8yL2xxZnRvbGM3T0RnekdNYjVVNUpzdUQzd0Ur?=
 =?utf-8?B?c0FuN09vcllQOGZKOXBqZEFYRjR0bUg4eGlmS2p0Z1NDcitBZFZBQVJPNkl6?=
 =?utf-8?B?Mzc4Q3N3WUtTWXlnVE8wR0tXTjdmclFCVzQvQWt3a2FGN01OM0RhVEN5WVht?=
 =?utf-8?B?ZnNnVE5yOEEwZjA5MXJtdXplTzJ2R0dPSVhVVVN1eTVqZkxCYUQyQkltMjZp?=
 =?utf-8?B?eU5zVFBQd2dPWjg4Tk0xdTAzZ3AwcExOcnZ5bi9rMUdwYmRncGZIMis1Q2hO?=
 =?utf-8?B?em1TZENOai8wbGpmY1FHekxocjBQVUVYbjJGaCtzWWFzMDVHUXBUOXFVY0k2?=
 =?utf-8?B?YmNHSmRhS1VPakVYQm5nL0FiZFZVMERYdTU2eVpVbEpQcURhK1ZCRENCdjV0?=
 =?utf-8?B?eGl3RWpLK1E1Q0E1eXZ0eG9ZSU1ZbzI5Y1BJZlRoQ3FJY1E1Q0hhT0RzRThy?=
 =?utf-8?B?YW5SdmJneTVRL21tR2Y4eDJvMGxJRTBVUTdNSWNLdWNaSDVKL1I5Mm51ODBF?=
 =?utf-8?B?a21kRnNGUTFaa1hhNHhneUYvb2NiWWlTOFZzZFBWUjA2d2JyL2lnQkw2cjkw?=
 =?utf-8?B?N244KzQ4ZG1SZC9ZN2pHbTljTWQ2dEEySmdkMENBUFBzVk5BSUZLTWI0Qm41?=
 =?utf-8?B?WVlBTlJMbjl5RVlHZ3oxVVNMWjJCRXA0QXZBdzFrMXYrbHhVNjlXVW9oQkRj?=
 =?utf-8?B?UkRDbEl3bVp6UVdFVGJCWGxCc0RNWFI0bTFzUmlUK1VJZWE1OEFEOCsxMlVJ?=
 =?utf-8?Q?2LyRQmhxddU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7646.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlRQVVVuQmhwREJxYzltaGQybktQaEEzb2dPWmpxRjRWTTFITUE1cUFja1lM?=
 =?utf-8?B?VThDbExyUkZtem96VGl1Z2JUVWFabVdLNmFLSG81ODZSNjVGNHZ4Z0hicFd0?=
 =?utf-8?B?c00zVzZqc3NFVHdVT3J1NHdxQmMybERFdkE1UDYzRkZORGtZa0Nra1JTTnBi?=
 =?utf-8?B?QkhaeTRiSjNHalZHMWoyU3lNcGRoakdHeUlWckxXQ2JOWUZVY1ZOblF2SGFB?=
 =?utf-8?B?d2psYi9HcnRSaFk2c3BhNW16U2NzZWZwdWlxUlFCWkVjbVF6ZTJxVkQrbVpy?=
 =?utf-8?B?b2JkdDNGUHErdlZ0QjlYR2NMZlBXdUFheHNrOXVXN0FtVHlXMmV5aHJpK05h?=
 =?utf-8?B?c2ZZeU50M0pjT2QyZk5XT3dxeWIxckxRanFJVXlGV1Y4L1JtMEJCZlNVWDQw?=
 =?utf-8?B?VmdUcGo5enVUSHlURmhubVd0bldWaHNCWEt0MUlILzAwT2tSTk5ROHR3cUY3?=
 =?utf-8?B?QUZTUGxHbm1rWmJLWWFmRHlJTTRFa1BkaDZGQnZnbkI4TUZ1eG5VRmw0dTFi?=
 =?utf-8?B?N2U1bUlQRk4zbUhYSGtnQ0hua0l1N3VuZzBFczBEZUFsRjhiQjcrb2VHVzJu?=
 =?utf-8?B?eGNMdThOREJGNjBESDZ4c1pzVWF5cDZyaU56NEdDQ0JBS215cVJZWVRXVFZ6?=
 =?utf-8?B?VnRjemdWTHYxR3FyajI1YlVhR3ZjWWl4MTQ1TzQxUmJrUVVnUTFYNkJsdkN5?=
 =?utf-8?B?bVJpZ21UaG8xejlENUNvK0xXalNDTEhyVXFHMURZbEY3ZG9iOTBDNXVXNWJB?=
 =?utf-8?B?aFcwV0NRVUZJZGg4VTlLTlQwUmNhNktIU0F3TG5YZU5LeUR2Q1VYMGZaT3J6?=
 =?utf-8?B?dkp5TU1kZ0w0OHB2UFlzMHRqZWVtSG9xai80bkllR3h0Y25GQk96L0RHQ01i?=
 =?utf-8?B?MklLamVreUtqOElDOEYvakI4UmtGRG1DbHpqc2YvR1ErNGROd3IxRi83b0s1?=
 =?utf-8?B?OXRaMDZxTmNpSTloczFRbWVaTE90blVwdlY3bEFZd21kNEFWdGg4V2xieXFU?=
 =?utf-8?B?eWNiKzduZEVtMHZSK0xQV2UxN0l2QnNaRi8wTXl1T2hKcUJFbDV1VGxZeHp2?=
 =?utf-8?B?MEUwNlJtRStPb2F5eGxlLzRsUkg2WllRVWlMSUNzcDkwTUlTZWlYMkdESmpn?=
 =?utf-8?B?YWc0MWRCRm5KMUFUTDZoZTRlRUQwRUNodWJzOG94aU45RGdVRGVUZEE5QTIv?=
 =?utf-8?B?WjZGSmJMY0twRVN5MzdoVm5IbnUvM25CR0xwUy9nSnlnRDlnMmZ6RUh2RC9G?=
 =?utf-8?B?ZmFVK2lvL3owRVRUWmF4b2FERWdKVlk0WWFMbDkvTzB3ZlVLbnFvWTMzNVZs?=
 =?utf-8?B?aWxRaU52UmU0dUxGbm9JZEd4V1FGSWpockU0MnJ4QjlFYnZFVi9Xenp5NFJi?=
 =?utf-8?B?Rk5XbEdvRTRCVTYxS0VEZWpPY1YzekVBbEJOMm5kbU91ZzVaQzVaaWxjZjVY?=
 =?utf-8?B?cmJDQlRMcjg4MlBBeHJxVmRjOTgrdWJraU45RE1VRUNPTkxoZldwYTNaWXZI?=
 =?utf-8?B?azBmVUNoeUpxZHdBVlBuSkJQaTcyWi9FRlE3MVBLb3ZuV01wR3ZGbUYrMjhj?=
 =?utf-8?B?ME5SRVYwMldYMnBKbktXYUJwMGFlZlRtQW01dXVqOTZ2OWxTRmd3LzdFWE9D?=
 =?utf-8?B?OWFtRkNWeHNweUFBVUhKbkVzbStENTJ2dmxVbmVUUUJFWFlZMnowV3U1WHZv?=
 =?utf-8?B?MW5SVk1OZUNaTE5rSWQ4ZlNCTjhKYUhGWHdYaERPNDdKQ1hSckc4alJwRWdV?=
 =?utf-8?B?am9aTnhyL1N0NFloOElTUHdUaWhobTl4TnRTdlYwUmt2LzhFMlFIT3p1dzdV?=
 =?utf-8?B?eFgxTzAzelJEeWhOMTZ1UjZiM3liUG40N0FwelppNTVNRmMyTHZJMC9ZckZB?=
 =?utf-8?B?a1FTN1NxKzlUQUk2bTlodWhGN3RSTk93RURtK0VHTnN1Vm8yUG9QSkg5NWZq?=
 =?utf-8?B?UUlLV1VqNkJoa09hVFU0OUpscUtRWnRwYkNKZWtCMWpGRFJtd05uQ1hLb3ZF?=
 =?utf-8?B?WURKR2J0L3dhVmpqQVljYUVzVHdVcGpNOUFlWUYvZ2xNM3YwQnFCY3ROb3l5?=
 =?utf-8?B?Y3p1N2JhLzNXRXpxSkRUUDJaN3A0R0NzQWlSVk9QSkRjQ1VCMVpiWURVZnNW?=
 =?utf-8?Q?acLZtCGkaID4gtd0Ldo2VJ51r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1eeccf1-91b4-4b7f-cded-08dd80c46f6a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7646.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 11:05:33.0573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFI1aaEzdFuCXZ97t44hpjFYt2NDUCNdCC4Lbupyxkzh9fn/3qXRKxD2zUKpqD1ldyz+0+0ejQBw1zE6gj+Eog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255

On 4/20/2025 4:07 PM, Michael S. Tsirkin wrote:
> On Sun, Apr 20, 2025 at 03:31:25PM +0300, Max Gurtovoy wrote:
>> On 20/04/2025 14:33, Michael S. Tsirkin wrote:
>>> On Sun, Apr 20, 2025 at 02:19:05PM +0300, Israel Rukshin wrote:
>>>> Add a safety check to ensure that the length of data written by the
>>>> device is at least as large as the status length. If this condition is
>>>> not met, it indicates a potential error in the device's response.
>>>>
>>>> This change aligns with the virtio specification, which states:
>>>> "The driver MUST NOT make assumptions about data in device-writable
>>>> buffers beyond the first len bytes, and SHOULD ignore this data."
>>>>
>>>> By failing the admin command when len is insufficient, we ensure
>>>> that the driver does not process potentially invalid or incomplete
>>>> status from the device.
>>>>
>>>> Signed-off-by: Israel Rukshin <israelr@nvidia.com>
>>>> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>> ---
>>>>    drivers/virtio/virtio_pci_modern.c | 7 +++++--
>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
>>>> index 7209390a5cbf..0374e86aece3 100644
>>>> --- a/drivers/virtio/virtio_pci_modern.c
>>>> +++ b/drivers/virtio/virtio_pci_modern.c
>>>> @@ -48,6 +48,7 @@ void vp_modern_avq_done(struct virtqueue *vq)
>>>>    {
>>>>    	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
>>>>    	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
>>>> +	unsigned int status_size = sizeof(struct virtio_admin_cmd_status);
>>>>    	struct virtio_admin_cmd *cmd;
>>>>    	unsigned long flags;
>>>>    	unsigned int len;
>>>> @@ -56,8 +57,10 @@ void vp_modern_avq_done(struct virtqueue *vq)
>>>>    	do {
>>>>    		virtqueue_disable_cb(vq);
>>>>    		while ((cmd = virtqueue_get_buf(vq, &len))) {
>>>> -			cmd->result_sg_size =
>>>> -				len - sizeof(struct virtio_admin_cmd_status);
>>>> +			if (len < status_size)
>>>> +				cmd->ret = -EIO;
>>>> +			else
>>>> +				cmd->result_sg_size = len - status_size;
>>>>    			complete(&cmd->completion);
>>>>    		}
>>>
>>> No this is out of spec:
>>> 	Similarly, the driver compares the used buffer length
>>> 	of the buffer to what it expects and then silently
>>> 	truncates the structure to the used buffer length.
>>> 	The driver silently ignores any data falling outside
>>> 	the used buffer length reported by the device.  Any missing
>>> 	fields are interpreted as set to zero.
>>>
>>> so if status is 0, device can just write a shorter buffer and
>>> driver must assume 0, which is success, not failure.
>> maybe we can make a sanity check that the len is at least 4B (status and
>> status_qualifier) which is basic size to make sure device is acting as
>> expected ?
>>
>
> The spec says nothing about this. Just zero-initialize the buffer
> beyond len and be done with it.

What do you think on the bellow change for v2?

@@ -56,7 +57,13 @@ void vp_modern_avq_done(struct virtqueue *vq)
         do {
                 virtqueue_disable_cb(vq);
                 while ((cmd = virtqueue_get_buf(vq, &len))) {
-                       cmd->result_sg_size = len;
+                       /* If the length written is less than the status 
size,
+                        * the remaining status bytes stay zero-initialized.
+                        */
+                       if (len < status_size)
+                               cmd->result_sg_size = 0;
+                       else
+                               cmd->result_sg_size = len - status_size;
                         complete(&cmd->completion);
                 }
         } while (!virtqueue_enable_cb(vq));

>>>
>>>
>>>>    	} while (!virtqueue_enable_cb(vq));
>>>> -- 
>>>> 2.34.1
