Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B43A31D757
	for <virtualization@lists.linux.dev>; Mon,  6 Jul 2026 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346369; cv=fail; b=EpXWWznoUdmIMMD228nASptUarRUQlIVDA1KcTdXy4C+tIwEcycy/avh4KNlfrHVWizMQq/i4A2pwEV8OszbAYfTLzbwVNVNh2uOVsOjnak7a4Oj6r/FhwJ0Gda+4+rM6fR5rdU66dp/s/RHSyDlmdKhxIwH+bXM0jbO+nBsmXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346369; c=relaxed/simple;
	bh=/l5115dyEik5VgFz0zuvuA22nGctOWCt+CpYvWWlI4A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XUn52XJFEsFzTWkYy6hhPpT3g/DN1iao1tOxvYdEbA96rzEwFo56sydfr4m3Oh/j5XR41np+O0+ITpdlaNYodYOzM63vJCc1MtbI8uPH6LM6mpsWCUvLDm9TbeCC6l/iLM63PK7+G3bQbUZr6Of+MzK+CKLpSrL/orwUea+PcVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YTtanEVj; arc=fail smtp.client-ip=52.101.56.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YTtanEVj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7QyaLUfJHw+VYW50Dvl9N1QYJvRH97b0bzB7eTGNtUiiJWaUs1EQtIqosAR06jTtHPqwDk/UGnIp3omBsvXaFU3uuRQzgkC2f8QQhS7jk0tsEEmbRCfMI3Lbh95tk5EDJawZl6JOy1uXlcupW/eMveW2L7v+9Jy1dOk6WkhcYCSrr4/GLxk3Ws6kfZKjRX0nednvFqx5MJJjSHDXyOOyzoY9eWlEiA9fFyEJ05ebmrwHZK4YkiFYNoLXy1IL9k/MCl0Kjd56eAC5j/AOCELrIOeFVvsFwQ2ExkvDjx5tTswp9K/FT71AKHNo/YnAGcWFL8stAXFGc3Mzpsbvbn5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SSefKI9XmEb0hgu8qfr4QX225lLiW/N2n9avOhC6F8=;
 b=CzuP4CaFaE1ppdmno2FORs5hZgWlb3GjegvCH7qAMeG1bALTaUvVCPrpy9Kv0khY4i47jdbPuMLQIY7rI1ZZD5ZrTDd39/IGmINx4fv3cxdm6sWnJ6f5OTsYJp24YvJ1ykp4Rq53Cdlp1pm5FHIaS68wi5jdupghhZIUL4a1l0nx/vVDSrC3F1PpFcO5D72XV8ffgibekPZVfqzmEho/aToH051uR354PDCmNseHe/KtSY1SstY0JQSXd9AMN7+uDKlumAPL4C5fF5fRgexAngxq0nT3oyyfQtLtuht9kr+bFWjFeMIb17IqNIhTzh3pHgY9hmetJe6k7MESNvw8Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SSefKI9XmEb0hgu8qfr4QX225lLiW/N2n9avOhC6F8=;
 b=YTtanEVjGukFdg4ik1/Wa+GsgHINetNk9+Va1mxMjjLaEzZfRJy9IS07KVYkURuM11noSoJbqGu8QMZ29+/zbqOpkkzITTYqxQ91InYcl+CA5il+ehWY7mZIpbwVB2V7YhMEpocFHW0IDF2qipIjkCGGb46MUa+pZ6SrGbA9EA8QHNeowO5nMRceujE6uXcD/uWhHFPYc97E68qhRMrroAzSPP3F6QSqhuaXBZTagXU7EfpRvEHsvxocXnDO3C/B2OQi1+flu6jH3rHlhTowHBLKkwQ4weT5aTGx7p+pA7TUDQgLPctNsdUUSBZr60XqTbGqEro5ZWSfAfRDdXXpPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 13:59:23 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 13:59:23 +0000
Message-ID: <0153f73e-2508-4816-be17-959f7f7baf3d@nvidia.com>
Date: Mon, 6 Jul 2026 15:59:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCH] vdpa/mlx5: Fix buffer length in create_direct_keys()
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260706100129.1541140-1-borntraeger@linux.ibm.com>
 <06b371e3-418c-41d8-8c06-1971cc24d8d4@linux.ibm.com>
 <d7272d8d-8146-4ed0-90d6-2a27eae5ab6e@nvidia.com>
 <530d7a50-3bd0-496a-bf41-3b99c8fbbad4@linux.ibm.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <530d7a50-3bd0-496a-bf41-3b99c8fbbad4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0441.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::10) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|CH3PR12MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6efc0e-53d0-4348-98e1-08dedb66c8b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3kjHLYNsmiw69BED+egn8meKZ6Ss17CgZEvnDVP0gFPewypgTKiFp1IrnV7Hz6GxsjBcyEoJAtHk1HQ/Nffo1srIKONPYwELGntTHHnFKNbml0+IbGznkLv1Rz+0rEAxppSRsT5XUU/6Avjd65JJOJ+iPoCCzw5FWFKQFrSPF2yKOKs9pBdmNe6bEY/S74KxqNFG3UrB0H6g4N4U718lL3Np3Z4KFW/XtXgo9FV7hjDafEQTEzd5OOpVgnxIVsxAvPbp5NS2idmwmINiJ01SJA9hM3H0bUctamHi0M5wTAOG6GHT7lew5n3Qn5Z15gc0UCSqgpbP/oj4/QTk24EzLSVvvIlNif5Jt4BkvePgahUPob1WI/P0yFCThwOjPV9YtFvdTkV+iUFD6vGwe25s5zAQrFiPMN5hDPTrW/pBuHbp12Nki7yCbyXgfII0XDv7QtlccOAPlg7DMzpQoVU+AXGnD9a4vomW4Wbq3pHe5PmqgkHzBnTZmu9t4VHjOzzmxTKH0ufO2RFtl+sJKLtbTwwVkB+EQlIAczfeNYzStREZ/fgWfpzCOp9uPQbT1oq3qG3LHqCOy1+1hLIWTjJgLgrlJeahJRwBsoyYcd13Yntb+WET+75P1XxZb3JYc7tmGyhSL1moJg5zL3JDwKH5BmER32iQ8XnZRZOqqF5C45Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWExMnRPb2E4NU1sNXFiTUJncGRyTVZEelBhRVZnUTN4MDlOdDhJcTYyK2xN?=
 =?utf-8?B?ODEyTW5HNmQxUlNobHpsME93RUhlTXdMUlpzdFlOcW5HWkgwZjFTbEdudm5C?=
 =?utf-8?B?cmdPbWxSL3lCNGU0c1E1T0RmV2k3bko3UHh1Y3l1MFlvZHhvZE1KZ1JyWWoy?=
 =?utf-8?B?aEVFYW9PamVDdEtLYWNSMUppMlhtYVZEekwwN2d5VXRGVEx5ZVVydm1qaERk?=
 =?utf-8?B?Y1pmYm5lK2JOL2JERjY5cEhQeXBDUUxDVmMvSHZxWWtoTkpUdXU4cTJmS1Mx?=
 =?utf-8?B?M3BBMlZhSVp1ZlM2UWZnWU5ZdFk3WWx1Y1lyOHdPODEzWld0NmkwNmNSZTVK?=
 =?utf-8?B?OXNaYTdBK3BHVlVhL1hXL2dVS0ZsVFpzYWl6TEl1c0tOZmNuRmZrQ1pmTzVH?=
 =?utf-8?B?OTdLaEVBcHNsb3d2anNvWjU5OGdWeDVwS25ldGNRQ2dTajk4UjBMemZvS0R1?=
 =?utf-8?B?TFRIZTBWbmZ2OTQ3azREcmtOYy9pZUtjUGE3MWNlbFpwQ0RnTFVqVWhjRjZJ?=
 =?utf-8?B?bDVaVXQ3MFVVN3lnWFAwRkdUVzFldFVGc3o1bkxFTFBoSGhydjFiUldzMHBa?=
 =?utf-8?B?bFlzcXNhTlc5eitvSElCV0d2dDllL1JvMXFoSTBRTFI3T2NmTjJiS1JDNHJL?=
 =?utf-8?B?RW9pMHdIZUlBOU5xNTJ6T25VOFB5Q3ZzYkNlMVN5YWw2c0kzdnRMN0E3Tkp1?=
 =?utf-8?B?YmpNZE0xcDZSMXVDVWtubFVpYU5kV3RTUkdWb0dnUmZTR25yVnd5MU1Jekkx?=
 =?utf-8?B?OENlbUFaNXIyUXh4WTVkVFhlRXhPWFV5dzhWcitHemlqcVI2SmxsTzJ6N1V5?=
 =?utf-8?B?czEraUxSOFlEMWlrYlM1Ti82ZzF3eG5FdXJhY2RzMDJsc0k4MWZrUG1TV1Ar?=
 =?utf-8?B?Z09uMGZra2o4OVlIMldQMlNzOE00NXVKd1BKQmxTdlFsNjYxQnBmbk54MHpF?=
 =?utf-8?B?KzMrNExIZFBYODRuRzU5MVNHclZuZDJSciswZFpZQ2c1dVZSUHRiTG1QaFVi?=
 =?utf-8?B?eWFtcUxTdmMvYmlTbWRVZzVKVGgydldxck9WaXVqMkM1eXExcnlzeVZoa3dx?=
 =?utf-8?B?Z21pWDNUZjJuUThPdXJ5MEh5ZTlMZW1qQ3VvQUZjSEIvd1RjU1RTRGdBUCs1?=
 =?utf-8?B?MUdPUENFY05STnovMEdiSW0vTHp6Y1lzbU5sa3Mxc3lhSzlDV1pOL3FKMWtw?=
 =?utf-8?B?RnNuRXJTdlVZK2xhWG9meVNpSVBvQzROUG83b1FWUGtqVVpmM3BqODliSGt2?=
 =?utf-8?B?MjhxRC9IVkc3dGZtR2dlR3QwSVJ5UzNMWTM5cEgxQmJPeTNSVzVhdk9ITzZU?=
 =?utf-8?B?Ry9tZ01FQ2k3cE1OS0tMYkw3b0Qwc3dXeU40T1VzWFZva0NIM1pGRlFOZVRH?=
 =?utf-8?B?bUJiZjljeUVROTJQRHI1NC9MMmRwSk5pdnhiWUlQTDN4enpNN0JZcVJLQi9h?=
 =?utf-8?B?M0NGd2dCdDlyQ2s2V2E3bXVwVm5ycVZPN1RkU1hoY282WUk5UFhncFk5K252?=
 =?utf-8?B?TW1mV0ZVcVEybmp2Z09jMDFiZE1SMlppbVQ2dDZ5MlZRUU5PMm4vT0h2QzVX?=
 =?utf-8?B?MjNBb0lyVGJXTGI4NTBOL1hUeWxaRzNuNGYvQUJrRkw3dUR3aEJGak4vbHlE?=
 =?utf-8?B?dUJTVHFhUmMvM1JJL2JlWUdHYXh3SjhOdkVubUNBa2Y5S3FHd0FSS294QlRS?=
 =?utf-8?B?YzNEWjdNMzkwR29iQUhTdXgwU3R6cDlibEtDWmNZdHNoODNhdEVDWVQvNS9y?=
 =?utf-8?B?UWREQ0N5RkdDM00veXhFYitObUxnc1RSTTVuSklwSlpOS3FIeEhUakZWS2Ez?=
 =?utf-8?B?S3JWK3RwQ1BMVU43R3FVVW1MWjdQclk2UDd1RzVOYzZOUWdKMVlqMjVncXBY?=
 =?utf-8?B?SFNSMXk0YkR2ZWo3WFZJMmhWZDFyVTZkZURiZW9ER2JhZEpLR1hRcGpQL2E1?=
 =?utf-8?B?MkRYZ2xlMWZoSjA4Z3V6Sk9KZ3JxWVFxbkRBK3JZRWR6K0ZaY3dtaE1ialpa?=
 =?utf-8?B?KzJKMzlvVDlFL3ZqOGVYZnVKOTVNWHBkZDMvOTY2YS9PcWZxTGpTRVJmdHhO?=
 =?utf-8?B?NERaYTBmQTFpcTBQcE4zT1BPd1h4ZURPZFFNT1ZNeEE1d1RpSTRoVEFEVitM?=
 =?utf-8?B?b1FoVk9GN2ZpRjZaR0J5cGNQRDJQdjloNVBxc28vYkc3cnM5dXFsK3JYRGN1?=
 =?utf-8?B?VnBuN1NsYVNWR3dFdXVYc0tTK3JZWXF3QVlLY0NWNHNzeVhuVFJiQjQ1Q2NQ?=
 =?utf-8?B?QkE0UCtwb3RQRWZFd2NQQk11eUVqN2lGRlFlVmY1VmtwaXZpSkljRWpDVktk?=
 =?utf-8?B?UlV0Q1YrQU51MUxJY2NzMnErdm9oYk5DQXFmWDdhdGRNa3VvRXJZQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6efc0e-53d0-4348-98e1-08dedb66c8b5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 13:59:23.6492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWtSQp1grQB2/1FkyluFECZ8F8jLZxT67kFBl/TGQY2IQsnioUTKFm7w5OOJeOsPN1qJmglyd23dtHpmP8KtIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025



On 06.07.26 14:59, Christian Borntraeger wrote:
> 
> 
> Am 06.07.26 um 14:24 schrieb Dragos Tatulea:
>>
>>
>> On 06.07.26 12:13, Christian Borntraeger wrote:
>>>
>>>
>>> Am 06.07.26 um 12:01 schrieb Christian Borntraeger:
>>>> We have seen in our CI the following KASAN message:
>>>> BUG: KASAN: slab-out-of-bounds in cmd_exec+0x550/0xca0 [mlx5_core]
>>>> Read of size 272 at addr 0000000176795020 by task qemu-system-s39/82764
>>>> [...]
>>>> [<000011388ab3a7a0>] cmd_exec+0x550/0xca0 [mlx5_core]
>>>> [<000011388ab3b61c>] mlx5_cmd_exec_cb+0x25c/0x4f0 [mlx5_core]
>>>> [<000011388b21e82e>] mlx5_vdpa_exec_async_cmds+0x22e/0x5e0 [mlx5_vdpa]
>>>> [<000011388b21fd44>] create_direct_keys+0x954/0xef0 [mlx5_vdpa]
>>>> [...]
>>>> The buggy address is located 4128 bytes inside of
>>>> allocated 4384-byte region [0000000176794000, 0000000176795120)
>>>>
>>>> So in essence we read 16 bytes beyond 4384-byte allocation.
>>>> create_direct_keys calculates the pointer and length for in and out
>>>> buffers.
>>>> The size calculation for in includes the entire structure
>>>> size (out + in + mtt[]) but the pointer passed to cmd_exec points only
>>>> to the 'in' field, skipping the 'out' field.
>>>>
>>>> This causes mlx5_copy_to_msg() to read beyond the allocated buffer
>>>> by sizeof(out) bytes when copying command data.
>>>>
>>>> Calculates the input size as sizeof(in) + mtt_array_size to match the
>>>> pointer and allocation size.
>>>>
>>>> Fixes: 0071b138d44a ("vdpa/mlx5: Create direct MKEYs in parallel")
>>>> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>>>> ---
>>>>    drivers/vdpa/mlx5/core/mr.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
>>>> index 6d02ccf9eb91..03fe7f5ca412 100644
>>>> --- a/drivers/vdpa/mlx5/core/mr.c
>>>> +++ b/drivers/vdpa/mlx5/core/mr.c
>>>> @@ -233,7 +233,7 @@ static int create_direct_keys(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *
>>>>    		cmds[i].out = cmd_mem->out;
>>>>    		cmds[i].outlen = sizeof(cmd_mem->out);
>>>>    		cmds[i].in = cmd_mem->in;
>>>> -		cmds[i].inlen = struct_size(cmd_mem, mtt, mttcount);
>>>> +		cmds[i].inlen = sizeof(cmd_mem->in) + (mttcount * sizeof(cmd_mem->mtt[0]));
>> Woops... Thanks for the catch. The fix is good.
>>
>>>
>>> Assuming the fix is the correct fix, question is, if I should use the offset of in instead, e.g.
>>>
>>> 		cmds[i].inlen = struct_size(cmd_mem, mtt, mttcount) - offsetof(cmd_mem, in);
>>>
>>> to handle potential alignment and padding aspects.
>>>
>> Seems harder to read. Why not:
>> sizeof(cmd_mem->in) + flex_array_size(cmd_mem, mtts, mttcount) ?
> 
> Can do that. I assume we do not have any implicit holes in the structure due to alignment? In
> other words, sizeof(cmd_mem->in) can never be something like 20 (and then the flex array would
> start at 24 to align 8 byte elements). If thats the case I will respin with your proposal.
Weeelll, I checked on a x86_64 build and there is a hole there of 16 bytes. So your second
formula is indeed the way to go.

Thanks,
Dragos
