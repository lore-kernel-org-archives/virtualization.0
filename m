Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A03618A92C
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724965690; cv=fail; b=hQBPfoOp3W/Lk1/E0Sb2J6wOlVnpOoIm37hMQiLQWh2FMoOsMUqEjXp83ENUzdZRooQDDPhyqDmPBGxEE4oKUFs7U0zl15IxaGyg3N6LhUCFGAtmuNnktc+Fs9+CowmBJTJ9hxoAzEbtsX7/YCrS5+QH2+Cb6+AYD00Z2xTgAWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724965690; c=relaxed/simple;
	bh=I1G0/8esZW0hOUlV6TzI+YkZJfKxfjVqtYEuiRfzQpk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KPzjS7cJ0eVqBmv0HPdiKyjcHlxMt7pQtwj3ziktxPcijAxYPzL2fIyF0ZlAMjM9VX14DLc0JPG9uwmo+mPMroeWwkG4szl36ePaXEF8ah4pLbb4CQX+Pd2V2Jp2gJ320G8aHHL7RRSEqXkoiKiLz770HcVtdtsBwpQ7S35LeW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KPe06w5m; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KPe06w5m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYvJnLGbRmhXW3cr6Zz3UfjJT4WoTC9BxwX54F0dKG8VN1ncE5RNbA2+3eOEwb0W7M0xrxx35EgZZU1nw0n7KwB6csJhD5/3/3WZRyZ2g3gTRF3IHCEoP/XSjdAxWQrxKnhPC6ph5faM6OVOV2BoE1bHC4Z5cBbn9hyyEJUNYN1fsypxiM1nmkwFvq5a46RGVomAnq77P98eoZMiwvsmX4aiw6DU0yYH1HFIeLRC8136uinnrn2oVj+Hh47T2Afu9XKd63xOW/pt8fCPZLhSHFz+ibE8OEPI9bksx89LcfogcKJiDa+dxfXkg8Nk2Nzhxi+W4NCuGr5PLE3jOCtIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLjO0DH2NEniLPKd6nZBTQnjJJ+O8DU2Tv7REXkLHr4=;
 b=gKV4U850GpGYDyyxQ5xYupFxNLCs7rt/QmGhFDDAYhtgWQZn7MhGd1ERVBNIH1uPjlfzhu9FXmAA/85YvfiPafi9DMGbrZk79pPOOOnwSBm/agO+gC/jGw0apSsXHk7tu6KC/w5I3Yt0MOoAr/GdT6Ss+I4xwii9tLPsGXmbFtFHMNeJVsn/O7Fl03GqR88UTjyrQC1vj8Vj3yeUVZeRBeXWFl/GGVma8LSTc3BFYzPs/sAectrmXcG5VPvgyrRT++Agw9LPMRJW5r/lvvOCGOlF7s2KfTI5XJzMW9xmMgK9UO/C9srURdycPzoFFZQTk9zGFN3fkbTQUXfPfzA3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLjO0DH2NEniLPKd6nZBTQnjJJ+O8DU2Tv7REXkLHr4=;
 b=KPe06w5mr5IF9iXMw2cx5OCr6WFQRJ605p5OjOfY0ifuuKOrpfi8UQD3XTrcUiOqXeW+6tx7fUu3hzCSF6CqJx359a/HRr7qAqcG5uuIsaoD7T95Yoq0sRxdesTvWsFKe9/AUyzI2VYMM+2z2Kl/gwJxHlc4pDwyWQGrmoN3Vie0NPyf3ZQglL3z+ZEDUjCejNfK5qhhEQsKlS1XVl9AgDSoNW8P4PQwKUi/FPj7fICiR1WW2Aax6SGy2HMaZWpk3HWufVg7/xXnKB6eJ01V1uJhvwb76cO4iPnPqt+X0opjvC29C1Yl+J/bhbWItqhU91FE5L9G/JDVQPYFc7RcZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 21:08:03 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 21:08:03 +0000
Message-ID: <c15d3682-05ee-437c-b51c-d6a824252d76@nvidia.com>
Date: Thu, 29 Aug 2024 23:07:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vdpa: Add support to update speed/duplex in
 vDPA/mlx5_vnet
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, mst@redhat.com,
 jasowang@redhat.com
Cc: bilbao@vt.edu, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 cratiu@nvidia.com, lingshan.zhu@intel.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Carlos Bilbao <cbilbao@digitalocean.com>
References: <20240829161620.38679-1-carlos.bilbao.osdev@gmail.com>
 <20240829161620.38679-3-carlos.bilbao.osdev@gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20240829161620.38679-3-carlos.bilbao.osdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0421.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::6) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d512e5b-5ace-41a4-1fdc-08dcc86eabdb
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YTY1aVdhOWdjQUZMSWtTMHE1WW1hdjBUckVhM2o0aGZQNFROMXJqMVN5T09o?=
 =?utf-8?B?Wm1tRDlQZkhVRjVjOEdENDhkeGNZdUxTNnpCZkk1ZDlBVGpSYldNdmVmSHBJ?=
 =?utf-8?B?RjFvU28yRExROGJUZEo5N01BL01YY1VWVDJOWUpPZDI1TG4xaGRNY0JnRktt?=
 =?utf-8?B?NzFyU2VJMGQvMldCNlZWay8vYzkyTVRDdFltb0F0Zlp2WElxZ3p1NmlXYVZV?=
 =?utf-8?B?QkJUeW5uc3RycGduajd2RHhvT2EvMEZjYUlzL3NtRk93dC9lNlBGUXFmMGth?=
 =?utf-8?B?UzZCT2srMVdPYmdHK3UxRkduU3JSNk0wazB4U3JyQlZwcWRjc1IwbDkrSmdk?=
 =?utf-8?B?MWo5UUQ4eVRPMlhJaFgxM2dGSjFkOHhrdjlRQUs3Rkd0OFkwT3VmcW5pOVcr?=
 =?utf-8?B?MTVJbmoyYktQb0RNOUo4aXh1VGl2UUg2ZEg5VlA1NGhvY0oyQmhHM1o1YXBr?=
 =?utf-8?B?SHRXWEs0TDAxWW5Cd2crN1RFZklKNGNjekUzQTNTQWtPdUdua3dzOXczNllx?=
 =?utf-8?B?MEg4ejFjdzFCb2NOa0Y2b05VSUF4UWxtOXJOOG0yK2crbGl6bXFyUFMySXd6?=
 =?utf-8?B?bVZlVml5UXhFMnhkQWV0TG5VOEhkT3Nqb25LVk9lbTFTRVlKdE93ZDdwdzFG?=
 =?utf-8?B?ZE85K2swNjJYN1NxWkF1bHFHK0d2dnhENkFLOGJKQm9mYzBIbnR3aUw0bks1?=
 =?utf-8?B?bjdld2ZqQ2dKNS9zcGlrWGFTNTNuUzloREJhK3Y3NCtPbFFxUkE1WVpXeXVp?=
 =?utf-8?B?bnpCeXBXQ09aRXozSEZPaVhrYjRLRVVTaXJiS0VyOTk1cU5tYW9aWk10d1pN?=
 =?utf-8?B?aEI5MXhzbHhrUFhkVERxV0h0UVZacC9VZVNtelhHUGJsZU1BS01ZT29aK3pB?=
 =?utf-8?B?Y3BvbS9LUnVKY3hzWTh5V0Z3WUV1dzdHNFpZWG1zV2tZakhLMjZZTXhvNlRx?=
 =?utf-8?B?dUVweHhHbEJueXVzS2lKaXJwSDd1RnF5dldmdjBPWTJ1R2tMdk9SWXZUcCtk?=
 =?utf-8?B?NVRrRi8xNG5ZeVQxZXdSbHFpclZ5VituOTB4UEY3ejcvODcxRGFLblg3c2hG?=
 =?utf-8?B?bUJMUlBWOW5DRFozTExnbWxsUDR5RkZmTDJvT3pham9NOFhuYXZaVEkyUnlO?=
 =?utf-8?B?alpub2VPUGVYc21xOFdHSkpSZUM5cWluZWNzUHI4T2Jpc3lJR2kzZnhqVU4y?=
 =?utf-8?B?Vm1naXFxV3ZlN05GYzRHeEhPK2FCWi9lNk9JZFFNSlhuR1QxenNkZzZCVEtS?=
 =?utf-8?B?QW1ESUtQY0dnRTJITHhwem9QNm9qcTRiRFZrdDNvc1Q2RnYzWVJFTDlxcmVy?=
 =?utf-8?B?MTJ1d3VJU08vYk5nMmZrUi9DdU1kK2RaS1FxWGNwRXFnS2E0ZERjMFgrWVdq?=
 =?utf-8?B?OWIxV1labkdla09CL1NKVXhSaGptOFUyUEMzVVgxdUcyTElCdU9RSmZ0ei9l?=
 =?utf-8?B?QW1XRUZaa1QzbEFvcWdvdjdJaW9iU1UxUmF3RWdyV1RVT1dMcjRGWXVNZDRK?=
 =?utf-8?B?VjVoMHl0RjlaRHIrUXN1QTI1c3p2a1BhSFA3YVljMlBBNVkrbERiMjVvWXli?=
 =?utf-8?B?b2N6SWJYVW5vd3Z5b3BNeFNsMFVUM2NETGJLQmcwRGRMKzZLOE1rQ1o2WTNw?=
 =?utf-8?B?b1FWNjlOd1BxWXV6UWVJb2NLTHIvMmI1ZWExbm83YSt1RmYxT3RiZ3U5RmNE?=
 =?utf-8?B?RHMxN3c3UW9nUm5JNjBwTHU1enRpN1pDRytYOUIrOXNSdHM5NmdWZ1M5V0g5?=
 =?utf-8?B?Vk5TQkx6TjIyY1ZNK2tLS2tZQzJrZk9ad0hqQnk4cXdvNU5CQzFwVitweDdp?=
 =?utf-8?B?Z1hmRzJ5VERzNUxldVgyUT09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?U2pZUVBwNDduZ2FzWDlGNUtXMjRFaUs3SVZVUThSOEZhTlJWWUZLSDNSVTQw?=
 =?utf-8?B?N0duV3JxRnFNMnJ0NktudUI4a2FiVFM1NDIyZVpSMWsrcDhVRnhLMUwrUWho?=
 =?utf-8?B?QzQ4WDRQZkNLb0N2Z1ExQTBIODNUQVRiL3owU2krRWlUWGZ1MGc4R1ZFZndY?=
 =?utf-8?B?Smx3YU5jbXVqM0pxSE1tOHo2dExWMGRER2gxb2lsMys1c0FQbUhzcWtaaEZY?=
 =?utf-8?B?UE90L0RTYkJRZDhLQ1hRZnZhVGVsSENsbGs1Y3c0ZHRXRXV0Zkc4MktOa0di?=
 =?utf-8?B?Rzc1c09KMm9nQW5YQi9XaU1LdGFIZUxmZ2lNR2QrblN5MFJKa2xMREVjN0pE?=
 =?utf-8?B?MFZqTnh3YTl2cU9kQjdiVnVVQ0tid2JUMWJrMDhMU3RsTXVkNWxSU25nVmtD?=
 =?utf-8?B?dFBRMG92WEg5RDZsb253Zm5Vc3ZDV0pxODhDWVk5RVVpcitSczFLOVVMYnlk?=
 =?utf-8?B?dVdhOXZIcjdDeUJWTE5vUHZzejhjeXRSblVOZ0FaWFR6MXNqRmozb3RmUHla?=
 =?utf-8?B?T2hKbW5WenlJOUlMYVp4TDV5QUsxbitxaERVVE5vZXEzTVRRY3hXeDN0WFdq?=
 =?utf-8?B?b0NWRzZ5SFJDYjFvMWJ0R1JRTGowZkpLYTlSYThYeXIycElhSVZHUlZpbHJK?=
 =?utf-8?B?TjNVWjJMVS8yMzRjMTZudnJFUTZtTzhMSlN1VFFZMTdMOU5RU2FwNmdhVkhR?=
 =?utf-8?B?aDg4TTdZaFFjVmgzTExCUjVNckdHWXhYMEN6N0ZIVEU5dENkWnQ1KzljRjBy?=
 =?utf-8?B?WXRiSzk4TE52dWhxVmVtY1Y0WWtNUnZRVmtEc0wrYS9PQ21nNmtYam1WS2FV?=
 =?utf-8?B?bSt6ZER1RzZZZWRvOUdEYnZrcysyaVEwK294Uzh2ZGVWbStWOXdlVFUwcG9U?=
 =?utf-8?B?UkJXU3N3OFhiZzlsUEVKTGwvUHVjQ0NNVS9wZ3pUN01EWjFSdzNNY1ZBMnlD?=
 =?utf-8?B?UnUxTU5sNm53SHlZTVlTeUIvNTBobXZXM1lkSHhhL3h1YmxJR1NLMEd1TkRv?=
 =?utf-8?B?WHdDN0lwWnpxWmx0eGd6MkZlTU0xN3F1RzI1MTArUStBMXdGK3NOdkpTS0J0?=
 =?utf-8?B?UWRBS0ZFekdVSDB0K295Vm8vb21Gaks5QlprTTk3bVVLTU1Rb2kwaDJJekpu?=
 =?utf-8?B?VXJJYUkvOXZWZHluSWE0b1NXdkk3Vyt2M3JmZ3ZyZ0Jwam13ZHRuckhYT2pP?=
 =?utf-8?B?dlVkUEptbFlSeGxJK3JBRTNIUlFVT2FweXhKN2xtd3Q1eHpsVnVxNnBVRm8v?=
 =?utf-8?B?cGVicEYxV3BpZjErd1Y5UHZRVDVpUG1SS3hNZUxGbmNmQ0dUQzYrYllhMUoz?=
 =?utf-8?B?Qlp0UHZiNHN3cHFRUXl4di9lbzBwakZIWHkzZzF4QjFoejVxSEFFT21sYUd2?=
 =?utf-8?B?SmpUVlBxN3hod1RyNk9MenVHODAyMkxUaisvWU52VlBOKzFsTG5Ddm5ZNytX?=
 =?utf-8?B?bzRsM2xITTJqeFdlZUhpTWxwZUhoMlV5NEw3cHhwU2ZvWGVSS2JJZkhpRXVo?=
 =?utf-8?B?SU1pbTQ1anNOdWdEOFhPb1BnUEQxQkFQQitCaHp3L3hBTDUvaElrbzlGblRw?=
 =?utf-8?B?cTdPSjBjWGxKakNkNHhMc1c4SUFqdG9VWFZ1Q2dMaWczSXI0T2M0TUZhMVNN?=
 =?utf-8?B?RFJNUC8rSDZhYzhjYUdNTk1xQUtZZ3lFWTJTc0lyR2ZNQnRxbUp3bnZpV1RW?=
 =?utf-8?B?Rjg0dEcrME01RTM0SldDU1hkWXZkcTNVa1JpWndVRjZELzRPWGZ1cTVUTk1Z?=
 =?utf-8?B?bW1BUkl1b291Szl6NUtUYU1QUGhRbDlPd3VLcDlBbldtaERqdVJTSlBvS0J5?=
 =?utf-8?B?Ui9TN0tpN0tMZmR0czNCbmhLNFdMdXlqSjJHWTFJVit6VlYxbE9NczJJV0x0?=
 =?utf-8?B?eTBqN2w3NG9jT2NSYWtmMDZibmdXMWc5SUo3dXBpUlRBRjZSUnQvaWh2VGxL?=
 =?utf-8?B?UGtSOUhNMDNETnF1ZUxqV2pXWHo4NHZCVloxRUhxSTV5VFBCWnVENEMzZ1lU?=
 =?utf-8?B?VVJqQVFvTmJZcmtQMXBSamp5bUxMVkZYQ29NdHBZVk9rTjJzKzRYZkRYa3pN?=
 =?utf-8?B?Yml0MG44Y3l2VVM1OFlBM3Y1QXJrVEFoTVNZTzd4NUdwem81SExMeGNCb3F3?=
 =?utf-8?Q?4PEMpV8ohuEdilNKBWzJf7fiD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d512e5b-5ace-41a4-1fdc-08dcc86eabdb
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 21:08:03.7261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxs1SmoYteFnwcfU2CxD8AryRTxQpmCv/rJRdHkNAAn2pXhdWwSWGbQgIvq1p3yLPW8Xrcrh8luyVk39FtXYEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726

(resending as I accidentally replied only to Carlos)

On 29.08.24 18:16, Carlos Bilbao wrote:
> From: Carlos Bilbao <cbilbao@digitalocean.com>
> 
> Include support to update the vDPA configuration fields of speed and
> duplex (as needed by VHOST_VDPA_SET_CONFIG). This includes function
> mlx5_vdpa_set_config() as well as changes in vdpa.c to fill the initial
> values to UNKNOWN. Also add a warning message for when
> mlx5_vdpa_get_config() receives offset and length out of bounds.
> 
> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 34 ++++++++++++++++++++++++++++++-
>  drivers/vdpa/vdpa.c               | 27 ++++++++++++++++++++++++
>  include/uapi/linux/vdpa.h         |  2 ++
>  3 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index c47009a8b472..a44bb2072eec 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3221,12 +3221,44 @@ static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>  
>  	if (offset + len <= sizeof(struct virtio_net_config))
>  		memcpy(buf, (u8 *)&ndev->config + offset, len);
> +	else
> +		mlx5_vdpa_warn(mvdev, "Offset and length out of bounds\n");
>  }
>  
>  static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
>  				 unsigned int len)
>  {
> -	/* not supported */
> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> +	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> +
> +	if (offset + len > sizeof(struct virtio_net_config)) {
> +		mlx5_vdpa_warn(mvdev, "Offset and length out of bounds\n");
> +		return;
> +	}
> +
> +	/*
> +	 * Note that this will update the speed/duplex configuration fields
> +	 * but the hardware support to actually perform this change does
> +	 * not exist yet.
> +	 */
> +	switch (offset) {
> +	case offsetof(struct virtio_net_config, speed):
> +		if (len == sizeof(((struct virtio_net_config *) 0)->speed))
> +			memcpy(&ndev->config.speed, buf, len);
> +		else
> +			mlx5_vdpa_warn(mvdev, "Invalid length for speed.\n");
> +		break;
> +
> +	case offsetof(struct virtio_net_config, duplex):
> +		if (len == sizeof(((struct virtio_net_config *)0)->duplex))
> +			memcpy(&ndev->config.duplex, buf, len);
> +		else
> +			mlx5_vdpa_warn(mvdev, "Invalid length for duplex.\n");
> +		break;
> +
> +	default:
> +		mlx5_vdpa_warn(mvdev, "Configuration field not supported.\n");
This will trigger noise in dmesg because there is a MAC configuration here.
> +	}
I would prefer that the .set_config remains a stub TBH. Setting the fields here is
misleading: the user might deduce that the configuration worked when they read the
values and see that they were updated.

Thanks,
dragos
>  }
>  
>  static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 4dbd2e55a288..b920e4405f6d 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -15,6 +15,7 @@
>  #include <net/genetlink.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/virtio_ids.h>
> +#include <uapi/linux/ethtool.h>
>  
>  static LIST_HEAD(mdev_head);
>  /* A global mutex that protects vdpa management device and device level operations. */
> @@ -919,6 +920,22 @@ static int vdpa_dev_net_status_config_fill(struct sk_buff *msg, u64 features,
>  	return nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16);
>  }
>  
> +static int vdpa_dev_net_speed_config_fill(struct sk_buff *msg, u64 features,
> +					struct virtio_net_config *config)
> +{
> +	__le32 speed = cpu_to_le32(SPEED_UNKNOWN);
> +
> +	return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_SPEED, sizeof(speed), &speed);
> +}
> +
> +static int vdpa_dev_net_duplex_config_fill(struct sk_buff *msg, u64 features,
> +					struct virtio_net_config *config)
> +{
> +	u8 duplex = DUPLEX_UNKNOWN;
> +
> +	return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_DUPLEX, sizeof(duplex), &duplex);
> +}
> +
>  static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
>  {
>  	struct virtio_net_config config = {};
> @@ -940,6 +957,16 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>  
>  	if (vdpa_dev_net_status_config_fill(msg, features_device, &config))
>  		return -EMSGSIZE;
> +	/*
> +	 * mlx5_vdpa vDPA devicess currently do not support the
> +	 * VIRTIO_NET_F_SPEED_DUPLEX feature, which reports speed and
> +	 * duplex; hence these are set to UNKNOWN for now.
> +	 */
> +	if (vdpa_dev_net_speed_config_fill(msg, features_device, &config))
> +		return -EMSGSIZE;
> +
> +	if (vdpa_dev_net_duplex_config_fill(msg, features_device, &config))
> +		return -EMSGSIZE;
>  
>  	return vdpa_dev_net_mq_config_fill(msg, features_device, &config);
>  }
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 842bf1201ac4..1c64ee0dd7b1 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -43,6 +43,8 @@ enum vdpa_attr {
>  	VDPA_ATTR_DEV_NET_STATUS,		/* u8 */
>  	VDPA_ATTR_DEV_NET_CFG_MAX_VQP,		/* u16 */
>  	VDPA_ATTR_DEV_NET_CFG_MTU,		/* u16 */
> +	VDPA_ATTR_DEV_NET_CFG_SPEED,		/* u32 */
> +	VDPA_ATTR_DEV_NET_CFG_DUPLEX,		/* u8 */
>  
>  	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>  	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */

