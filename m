Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44333262F
	for <virtualization@lists.linux.dev>; Fri, 10 Jul 2026 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671843; cv=fail; b=jZzI1AexLz4Bm2zCnv84YQ+7hHNa+EFFfn0RtuI+W4rcTHit608VVdGS00NaIVQHDCRU2ZJ/SZ8Ezc0MrelRirO3bIHD9yNs4XbmVRPDYMpTuopAHlVGnziePG58oojqQuv2TT4kpGQsZHk97swD/M4SwdrOSgQCsbfUwkU2wRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671843; c=relaxed/simple;
	bh=rJH29i5jT9Cd7XR3/3i/W/wDNMFstQIIZ1ArNmZojEE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NCCEJi9MJCCFUDAUWIE6tsd0klu3KnNPwUDKq430ET/3hpYiLkmV9SJj105rZQ3RauQsbCGFK2YI73RMLoRnuMc5vTzqRdM/3Hja61xqFBL/fLrJ3VujI/1LcM9JuiI6EQFO7K4D3ocdmdB5Tkcml9Zh5fMdlTURVdxjh/rq9ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xton5vUg; arc=fail smtp.client-ip=40.107.208.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xton5vUg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ry00HQG7Q5lDDEGpMPF4nzF0HSaXKED5P11/qn2jh0T8zrHrxjV5+tfzhRmDnfL7ccFCrUBYVaRHNvZxKWN8Q8b31GyUZLrqMobdQuv4G4Ft3JnTxfzZwhCAAYQ2KaRHMBGdYVX+zcZAz0yp/K0C+RO9drEGY0AXInj/Uk3ojPHTwSKOyrzZA2KP53CLeLVE5Etg8n65YUxHxPKNfsQXFQoiyEMHKREqCQazhhCrGLmBP3obr8yMBvCk1IJgZFIayEfXE8IkThL4AAadCvD6mo4Sj849d07Vo+Mda+CmCyO1glZ2MB55U9nfDqYkJj1ILf9kuhrzQJcvWdJ9B460gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e84jce12pI5vPPCoH3P3ngJCRxgSqpRCKYa2j8OFq64=;
 b=HVb1Dt9l75aEHRJGx/KoLqrh1+cMW8haSaZ7YMecfPh/c67EH1BODLZe0HJyD1NyeIQyWOd0qKxRIXM9X3pqFBh3jwCcg770xFw7rpOr/qE4V1fL8gKe4cK21CwyzNRcKhbUUsZSu2/lhshFedg6JGaVmXIKeWSD1OLbhfCTkhYYc0RyhAbdKSJWzAd2KNEuFdC/3S0j9/Uci7d+gVQvmNvSV6dWnIKWEA7EC8IlgJjFPG4ezimyHwdg4iaJtNy0Y4YtCK9F2l7ZUnRJkxeSQNwizcjLDkMacp51j73OpD312Yioj9JA5yyzJFImsBuWvDytRdJSZEuC0ajyhXwqMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e84jce12pI5vPPCoH3P3ngJCRxgSqpRCKYa2j8OFq64=;
 b=Xton5vUgqnFZG/CAtmusx7pTJShv12eLJavTb3AG5z1qhGZ97itnEqOL1JczHe37U0P3giAn0uhe/txuFJBrwRQE3Ii6zdRBBYIoNTZr57Pfaq3sZM4A2ZOfUi/u5pJ2W2Aj5qoLypTXmlfDyavbZKYCdmn4hwYbjk5JSTJUcXxt9C92JLHPVavS9km9dhNcBmClsgOSZqa6E/4V/M/+4j8dIo3ztnOjsysKmMJg5NNqeum2p3DxGFPqJjuEQ4u9hmYGnBhtBXdYW4YhEAWcS3ojW4CXEE0X+Agaf4Uj7oWQMjp80sYBz8dzgC2aQa/SeDjv3xXXVPIZN+zYeG4nAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 08:23:58 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 08:23:58 +0000
Message-ID: <21e944c6-2039-4e34-a2f9-711ea4769294@nvidia.com>
Date: Fri, 10 Jul 2026 10:23:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vdpa/mlx5: Fix buffer length in create_direct_keys()
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260706141537.3510294-1-borntraeger@linux.ibm.com>
 <3508dbb8-d110-42dc-aa25-4b3e73057422@linux.ibm.com>
 <9f799ce2-f84c-4224-b91d-464dc767eb00@linux.ibm.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <9f799ce2-f84c-4224-b91d-464dc767eb00@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|MN0PR12MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: 08dfeb3f-0734-42ca-7724-08dede5c96ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ntf5xVqZKhfrOSwmxyl73CeIf3EfiRNz6lVTsTLxLfY3EZCqqSlECCc0Ndn/QJXrSZE6Y/hJJjRF0wmGHQ6/rXOOCHl6pi16E1T/3C5yyAF8i2B4QFoLffENKnXVu4l5JHXflV31Ddt39BGe8qOk0krqanLdE4qphHPkmzNGKesPs2cqeBuckCmAojiv+/JSCkZA9jyvVgnCYZaoS6fJLrt6ZSUPGzBzk/8aJM6tc7ADf+LUA3i6NOQMdfLEjRCOPOj8pSZFKq5/IpZCIrvjBc3v8njN168g9ejc7vhE0cs/YDcapeUuqlKrHWYRNy/0Vf3/hx5hIG0mj9I1WzM2dckUgv0/iOqn7zRKbaX7vk8nZEJ6lWY296MVwcdKxDRLud+sotlx46gtuIcUPbQYqZ8pMVSiR4BxPzYrm+WFzmG5sRsVuyrXpedAcMnL/y7QKqhgjPNZyH6Ssz628VWR77P4LbVvHzmu4pZFbwLVpKO8rXGECDosX08LMZQHOJv6f7WgMHLCgHVOx4UG3SublAjYNzn8DDHgo73z5ho3m5yJMh6uER9alvTsHe5QWsUfHUAJhzAZeeCl+JvOwQojWIopBxqWhBzucNEKQP1EII2C04mg46IPeOlQmX/+zw71g/os45UmM+r3aR+kk2rK53w9Psd66Y332O9zMW4cpzM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clFJY1Zrc1RLYVV1NG9Od2FjRG9RbTg5ZkdybUlyeTVRcUlIbVlrd0F2Rm9S?=
 =?utf-8?B?dmE3dG9NcnExZXRzT0dKV3JDTDl5TzF3dHhoNzlYam80ZDdzeVdZZ1VpTlFu?=
 =?utf-8?B?UlI1MjFYRmtDTnpQY2VISG9xZWlzTWZlUnJpRllHTGQ0R0VQaUcrN0ZrdDcz?=
 =?utf-8?B?ZmNtdVVmajZiZ0JRUEpzQWQwSjlIWEdaQzhPRXVrallXSlVPeEp0TEdCWStV?=
 =?utf-8?B?VzhBWm9BNXdJbGVXUms3Rm5xK1o2NWg5QTNkNzlhRHJ0NDh3TFJXS1dQMWF1?=
 =?utf-8?B?cnoxYW9KZldOOC9JY214dXlPYlpBb01iVjVoMWJINHdoVGZlWTJaTXVhdmU2?=
 =?utf-8?B?WG1ybExEZ1BCa0hmMlpmTDNSeTRzc2xpSjdNeG9zUS93OU1KZ3BSQVV1TzRP?=
 =?utf-8?B?ZmtoS3crUGlYbytqMEk1djREU1hQemJpdWJmV1dQMERWaHlacnp1am8wSm9U?=
 =?utf-8?B?VFZWRjd6Z01Gc05MRFkzSU1YL1g2ZlpTd0lCUnFGSHFmUjYyamNIK3JvRHcw?=
 =?utf-8?B?VFp4WXV6d21Hc0Z2ckN4VzQ4RTJ6TEN2M1VqWGlsSDAzSytxQ09lU2lIUnV6?=
 =?utf-8?B?a1VkSGhxSUxoL3QyY3B4U2ovdlUyaS9JbUZyQnU3a1FoRWpPQnBnK2Q2R1hO?=
 =?utf-8?B?Y0ZUNWs2NGVEUUtUazQrZ0xCZG9uRTVib0dScGxOYVRhWDRKQnAxZzFaOExC?=
 =?utf-8?B?eHhCNG5DSllOaXhoanl2dy9VbE1FaUJWbGJiYUJHTndHbG5JajJvL3p6Y1FR?=
 =?utf-8?B?cXNuZlhQVmZvd3V4UlVPZlc2UUxMUzMxQkdNUSthaFMrTGNNa2ZjMVRUeXNJ?=
 =?utf-8?B?ZjY1eUxqUlluL0pNT2JkcUlQMTRXSVlQTHZSS2publd0cnN5RE1oUlFZZmdN?=
 =?utf-8?B?RnJCQjkwUnBHL09oTGVpRkJLNUZSQ0V2LzM3Ujk1bzloUjFSVG11OWRxdk5K?=
 =?utf-8?B?WmI5Si9XNmZQWlh0dURmNElVdFEwKzFoNGRWT0ttSnh5cmloemh0RUVYOEVs?=
 =?utf-8?B?Q2E3dUNJSldEUHVSaHhFWnVGaWtPMUF3NmhpV0gxa0FZRWsyVnY1dGsxakZ0?=
 =?utf-8?B?YWFsY1FkYzhQN1BHcUxKdEdUSFovaXJCc2Zub2FjTEQxVXkvd2liNjE5S1E3?=
 =?utf-8?B?dk4zSVVCU3ZmTVNIRnVLVzJNR1I4Z2gvV3lEdDNTVjBvMEp3cGVvQ2hpU1lV?=
 =?utf-8?B?U3hBcUxXUk5QWW9iTXJud0lvT1dvdDJjN1lvWXRmYmNQdmJKL3hFL2o5SUMv?=
 =?utf-8?B?cGo2YnRuUG9LNzVnNTRqbTVuR2k5ZlY3RjFzdXRvbWUzdnVWc0J2eTNKT3g0?=
 =?utf-8?B?M3BKY2M3ZkRneGhjMVF6QlBDV2ZSM09OVXdmU2JIbDVENFNFYlBpZmxncWNE?=
 =?utf-8?B?czczc3lMbzhLVEJsSllMNnJqZks2Tk11VzFKR01vTDl6VXo0TlBWa3lFWVhs?=
 =?utf-8?B?STI1WGNXZzBZU05vMEVyZW1hS2NhbWJaQjZnVnZVd1RER1ZobmNkNCtteHJI?=
 =?utf-8?B?VTZGdTN3T3F6V0lTRHVOZnd1ZkJPaFlVaWVyTEx4M0Z6RUNmcU1ka2thOXhP?=
 =?utf-8?B?cEtGRTF0S1paczNCZnpMT3JyWG50dU5yam9qcUZ5ZW8wL3JwNXRLOG1kS2Jy?=
 =?utf-8?B?RXByVkk2YjZOQU9xTXkvU240OUw2Qm0xZnNhbW1ZVXlVN1FXcjhBR05tWENz?=
 =?utf-8?B?aGZmN0RtOHE2VlVPSEcxaUZSNjNoT1l2YWRxM0ZLQk9raUswNmNNT1F1dEZp?=
 =?utf-8?B?YWVFQ2FUWE0yUWRwTlluR2hqZGFyY3B4TmUxaWFYM01nWWRncUFPczVCMk5Z?=
 =?utf-8?B?Ukdqc0xGY1pxanJjK2pzbjk1Zi9jeGJSdDdZUXpFS0ZoSVBJanJkdTZHOWs5?=
 =?utf-8?B?cVUveWtBWDNtV2FsLzBKQUVNcUlSSHdia2xxdHk2b25PL1p2dzBuTTFKejF4?=
 =?utf-8?B?MkhxQkhXUjh4Q3hnZzNGSlRzbERKSTE5Z0hVamVkbGNjTnVscml3ZEV0dWFM?=
 =?utf-8?B?a3ltU1c3aFFzSG56a09MdTc4ZTNybmx6NXhkZ09MaTNkdFlIL3g1dnVQZGZa?=
 =?utf-8?B?a0M2QzgrVS90MTZGNkZkTlhYSG5TYnByM25MS2NleEVDYmhIMGYxTU53aFF3?=
 =?utf-8?B?OWtaNHluZVNUbExZTC9pdmYwZGJ5Tko4am9Jb2lyYzdiUWk2dGxwZ1hFbHRQ?=
 =?utf-8?B?M3Y2Kzhhb0NjRVNOcmZIQlEvUTJqbG5ac3Rja1drcWxZdG5NNWNXODlXckU4?=
 =?utf-8?B?OWZoZWNVNHlMdFV1OFZocUJKYU5ROUIzMUluaUYvblE4cnlXQ0tkUW9tZkRy?=
 =?utf-8?B?NXlDRW5ScmFtSEdIcU9BN1ZDWDN4dDNQV2tzOWRkaWdSZzFBMHBDQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08dfeb3f-0734-42ca-7724-08dede5c96ac
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:23:58.1880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AP4MvsLYtUfMrjhdebh2FmLHnxezESq3uawGu8T3yA/y+MDzbMgLChP1wdQaizktIu9PTO/TpuK3vneHUgQaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245



On 10.07.26 09:18, Christian Borntraeger wrote:
> Am 07.07.26 um 09:17 schrieb Christian Borntraeger:
>> Am 06.07.26 um 16:15 schrieb Christian Borntraeger:
>>> We have seen in our CI the following KASAN message:
>>> BUG: KASAN: slab-out-of-bounds in cmd_exec+0x550/0xca0 [mlx5_core]
>>> Read of size 272 at addr 0000000176795020 by task qemu-system-s39/82764
>>> [...]
>>> [<000011388ab3a7a0>] cmd_exec+0x550/0xca0 [mlx5_core]
>>> [<000011388ab3b61c>] mlx5_cmd_exec_cb+0x25c/0x4f0 [mlx5_core]
>>> [<000011388b21e82e>] mlx5_vdpa_exec_async_cmds+0x22e/0x5e0 [mlx5_vdpa]
>>> [<000011388b21fd44>] create_direct_keys+0x954/0xef0 [mlx5_vdpa]
>>> [...]
>>> The buggy address is located 4128 bytes inside of
>>> allocated 4384-byte region [0000000176794000, 0000000176795120)
>>>
>>> So in essence we read 16 bytes beyond 4384-byte allocation.
>>> create_direct_keys calculates the pointer and length for in and out
>>> buffers.
>>> The size calculation for in includes the entire structure
>>> size (out + in + mtt[]) but the pointer passed to cmd_exec points only
>>> to the 'in' field, skipping the 'out' field.
>>>
>>> This causes mlx5_copy_to_msg() to read beyond the allocated buffer
>>> by sizeof(out) bytes when copying command data.
>>>
>>> Properly calculate the input size to match the pointer and allocation size.
>>>
>>> Fixes: 0071b138d44a ("vdpa/mlx5: Create direct MKEYs in parallel")
>>> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>>
>>
>> Dragos,
>>
>> With this fix our nighly CI did not result in a kasan message. As I only have
>> limited test coverage a full regression on your side might still be the right
>> thing to do.
> 
> Any feedback? 
> 
Sorry, got carried away with other stuff. Yes, I will check it on our side.

Until then:
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Thanks,
Dragos

