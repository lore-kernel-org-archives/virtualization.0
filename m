Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012010.outbound.protection.outlook.com [40.107.200.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6E8423760
	for <virtualization@lists.linux.dev>; Fri, 10 Jul 2026 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683449; cv=fail; b=TFxZ12Aqu4Q+Uz735eu9lEmaaTGTbv0mdTrn3Q2jz0NdqSumMqTd9iytWHd+dAwUjfp7i4oNSTN/hhd944Bls/0zYmbphp2yZsxW2zW8hqPShZB10f7eM4NpCAUGwO+x3RW9sBxME0Zqq7LvsaW0AiGAWVxh4FbDITSwhibUuLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683449; c=relaxed/simple;
	bh=CJu0p0hKOJAQvUYvTI97WReSVF6DCyLPPjBgM77t0fI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O05xk2vU8sT/6Xp/p9qkpuD0ECFS5G6DOEqAE6NQ5y2yT44Ss4tcWrApJxTii9TGRcyfjq+pyuz4Bi0iisWvUJJyuxP7mY7qs3faFeDYGjMiFfyvxs4M8T0cSgwKD/xImU5vLeZnByRbHlPAF4BEvicLjrwUjRwTp9uQ76YrQMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VOeEfpU6; arc=fail smtp.client-ip=40.107.200.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VOeEfpU6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOW8UKsjmxgJ021VkxEUgDZLVlLsPJBP5nre833G71tYC2XVrzAt0+N1SzmvijwRht7RZJUIYFPwrKr/zFEznnFBJ2Ah2Yu1TQ16LluTbFMQVtYhkNa7YBpnRWWH/hjyttGWOHGd4YI3ewwuqdDEiWaDJun1ASuAZmtSIbFFXF/5+P2FF6aKHsfpL+oQWhiRcyuyyTD0BdjHS558PH28jD+eTYJ+x/ZdEL4njN8QEOWIvtQaAtBpjB6hp7PVUNnknJ4Dupk1zw/Vdm+VRvmXd7rsHKOuGpe4cWXZ9eh7JC9sAIVGocAae5ZK1ALDgNbEJqsVxVHyj6OH07aOTdD07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+iPZIR3V05irFIbm+fEDfOn7ZCi0EjoM7rQnHfepJg=;
 b=SH+V5rn0FcXwZ3sYrVnSSRrWEgfO2ZluARWEg8Od1Gz7lTSQwbQ94hlbGBEk4hOyQV3/+7/DWDHrQ6ug4D16RnMcPgaJsKXIowjMplAglOIGJ5lG85nQOiOLls6degowOC+S73ERncCH/7Av2aXeMrQpGJXBrQ91QzhB3Ev9rDMqIy8a+unzoMQbkzMPwC5Rv+zpsa/V39C2rM0eTUQt/ltxkW4OUChzEqfAn3PCGTyrdV0hEitB5SH49YxzD5Id5E8BpdtMPc87Buo3HPk45mts07dnQfKBYNiPZaTbfr7L5Qt3nmx//NHNr5tKVGPddBrA3bghOH1VQuYDBmW6Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+iPZIR3V05irFIbm+fEDfOn7ZCi0EjoM7rQnHfepJg=;
 b=VOeEfpU6e78Y8ccw4GegsDgJhOSDCbR3NlO1z03Dl2a9CdJHeJL5Isz/aWP92DDXixaMD5lBtJTXfDzs1UaaAQokcGSCPcCPW2EZpAvgb9QyZ3MGTjjETOu+VaD0oBr1C/lj1PN70UX/7rltr+hOuLjW2YlC4l+MlesPmRKHpuByaxFqs0bhWgogItv1MlmMy/0r0EpF0YthRmfFFGCEI1KlLAxx7e3ebBQjYvF0UWInKX5VATvoTUBFoDfKqAqblRnHXvgMNsZAO7wU/vvlh6sL7bkaL5C479JOgd3qBYGM9V3UK7M/M27yqBVvXMTkmLy38ykg7dNkHko3nyM58w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 11:37:14 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 11:37:14 +0000
Message-ID: <be143bcb-8d26-4576-a5b4-278a2905e6d7@nvidia.com>
Date: Fri, 10 Jul 2026 13:37:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vdpa/mlx5: Fix buffer length in create_direct_keys()
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260706141537.3510294-1-borntraeger@linux.ibm.com>
 <3508dbb8-d110-42dc-aa25-4b3e73057422@linux.ibm.com>
 <9f799ce2-f84c-4224-b91d-464dc767eb00@linux.ibm.com>
 <21e944c6-2039-4e34-a2f9-711ea4769294@nvidia.com>
Content-Language: en-US
In-Reply-To: <21e944c6-2039-4e34-a2f9-711ea4769294@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:332::26) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: f75a8a01-d43d-4774-8e68-08dede779644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0phtrJyaVpvHJF2RryssqziPdGiMmbsnUr3vFDz4yH907ZaLMp939wen5mlFTq57ZWhim1XwWLo71zLXvWEmRL3NZidO4/bFNP0sXttLLZtGVPtECw2hefhdMOUDyB0mS90SBHxBwBvkPSF9E9Ah6CWOTlDib8i6NaSqgngAovMYzKNemgdlC9/QY7NFADcDTtFl5p0rNbLFcmA6IbGIoXXedJw30NU4TzxNkVXmXSCfr9FFSy5hB2eSRGZR36tqnzGEQXXHGpCpC1xWE2n2Bfeu7KbS7DeZMZiwubBIxo3c6xG4enPMIt3g6khnvKFaAiNDgjQfX2JUr0qpSQrrNr4BJF0F04/s2jaeGHtSPBITQN8fpVTF1yHFPtbyKYkcj2u2kecMwrio/Sm0st3RVWqrdtPeekX+fGrO4jrb9I75jHcE5J96GprOMmV715K6IWSKwZzhQ/sWocMi++gN0jor+uLzMDivGnKJh+Ruz/c+5zXJnLVktFB6n0jflm3Usb/IsLPU42ajpWlriPVducmbbOCxi1JZ2H+MOuuujvKs2K1Vmjd8+xGRTcuNAkKun5le5DBafjBrXiqV60WjuPeO+3tTDezfpbHR5AzpMqdlPHlnQ4tn+tx4rudocKNf41GPnywF6A1XvT9UB2x9RWwbSq6cj6KS+UaZxspzbwo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWFOUVUvajZLK0xFM1FQWkJGZWc5aUQ1WFd6ZTNyY1VTakZOdHRRbEcxeWRI?=
 =?utf-8?B?VXZ2ei9YbG1OVXpKYW5sdXJHT0h5OXB2TkdoKzZDWW5Gc0g5bnRpSWxJemp5?=
 =?utf-8?B?RDRaOVZxUmZSNnRTTGI2M1BHdlp4cThUS2lmZEV4cFNMb2JnWmZZRjc4VkNz?=
 =?utf-8?B?TFU2NEpTRDNNaGZTcDcycVFMUmREWDlPZXVLZktSY2F6ZS83M2hlVkJiaU5x?=
 =?utf-8?B?K0xsV1NFd3BSY1BiU0J0OUhOZ0RlNGJVTGRXOERtbzFyd1phMFhra0lLSld0?=
 =?utf-8?B?cnVDSU51dnk3OUlkSHRka0NVV2NoVUR4SnJWbkZkOGpmdWFWM3lLa0hvSnBI?=
 =?utf-8?B?dzFzNnVrMzVaaGxHbDZtZ3BZU2kzaXlQdGErT3BJaDJtdGFlaWR2SEFZbTBh?=
 =?utf-8?B?T0QwVmpKVjZTWkR6dDZEbEJQZk9Ub21SQ1c1RmpjdEp3NGwwYWFEVEppRlI0?=
 =?utf-8?B?MXZKVWhGSE1sWXUrMXB6SEtvdS9LYktxd1FvNi9qN3JId3I2SGlDRGNSN0p2?=
 =?utf-8?B?NTloSWcvWE5nSG9GQk1CWTByRkVtSVdEYmo5TVZ0SGdWVjArTitoMFhSaVBB?=
 =?utf-8?B?K2hXTFFkVWF0SjhBOFB0dktPWTFhMm5UTzdkaHVUYjZENlVJYVRPSXdWMnJU?=
 =?utf-8?B?citYUjFyc3Q5S2Rka2pKdVNHSXEzUXYyZzN0TU5LcU5kYmNQYVdUUGUwdkVz?=
 =?utf-8?B?S1dOcHBIWlB1NG9YRHloc2phL2hSRHVWQ2FRUEpXNE9uajFVL0tSUUFBblZj?=
 =?utf-8?B?dytRSXViMElQSmpiajR2SmZKV3BBUEY4QzErRkRkU2ZTNFVabVA2UkNrSzN1?=
 =?utf-8?B?Sk1Ed2V6WkgrTlJJbkZ3VUNIZHZGNUpWRHVOcElYMTZuZEJhWk1KZ050SkRC?=
 =?utf-8?B?STFockl3MllYdWNFendBZlgvOUZ1aFR0OHo0YVZBWVFOdmVXYS9rM2E3aGVU?=
 =?utf-8?B?ODFMc2dCbi9oWVFXeEg4REMxekdGdW10WjF2OUJ2UitQa2hLTXFyMENOZ21m?=
 =?utf-8?B?ZllLbEcrS3RiL3F1RTE1dnN2MWhGYS8rZUZPcXI3UTFKZXF6cnh4d005aDBR?=
 =?utf-8?B?QlVTQ0ltRC9QM1hhMDJwYjhXRmw1R3BqdTNCbGl0V1A2MXkyaGxadUFndDZp?=
 =?utf-8?B?QnhOYi9GRDI2cGprRjg4MEVPMkZDNlVEeUJwbGxpY1JsdGorOEFVakFRT3Fm?=
 =?utf-8?B?Tm9MVEhadktLeGxFMVYycktLUzA3Q1dnUXpFTDFpSmx5alM3Y0xCM0djZmxK?=
 =?utf-8?B?U3BOQlIrREkxYnY5UURDeFlrUGlFbFJyMU1Temk2c25uakFsSlpzRERkWFdx?=
 =?utf-8?B?YU41RlptRW1TclVvVm41ZnNyemlwS0k0azZwOTN6THNSQjlDdnVmbWV3a1E4?=
 =?utf-8?B?bWs3UFIrUEIrampHME9TajR3UEhjUVV6TkpmL0tqSjQyS0tPNnc5VDI3K1FU?=
 =?utf-8?B?NXFVRHFSd09ESnFqcC8vNWdZeVFBUXQyRzJWdFVlV0crOUs0cXcvVDVBVTlR?=
 =?utf-8?B?TjQ3NktBTHNSVVZjZVg5Z0VCblhIWWQxWWdzUFdmbVZTN0NobEJwRDJmMmpB?=
 =?utf-8?B?eERnU2RDNWtPM2l5S0dRVFMxY0dpYUVkUnZRV0QrazZMYnFQeVZxdk5pSUlP?=
 =?utf-8?B?ZHlRdUpxRmFNK0FMU3RNQ2hxZ09KUno0S3I3Z3hVWG9TekJuUlZpRC9SU2Jk?=
 =?utf-8?B?Q2VWTnpjbUdPN0xFUnErS0xOV09wcldLTnpoV2piYjllNThkTVhla0VKYlRX?=
 =?utf-8?B?dS9uOC81WGNvMjhSWkdKVW92MTZaVVcyOFFDZVd2Y29SVHNIYm4zT0lBNzlR?=
 =?utf-8?B?NmRvK3VTdTVlOGdQVEt3TVZuYmdCOTRUSm9XTUFVb2lwYnNFVldjbElSMjRl?=
 =?utf-8?B?ZXpBblBoZkxUZkYyMk4xNXBJR0dYOE5GMVhKV1h2c0F5eUZsRGhNZG95OVFk?=
 =?utf-8?B?NzdpWWlhYTdRcDFpK3BEODFtWG1OUk5tditVbzZhYm5lK0lsY3Y4ODFXaU1V?=
 =?utf-8?B?M21xck1rRU1wbGRoT3RuWENNQklSZktmZ0krb0NTSUlNcUx4TnpZeUlYZ3RL?=
 =?utf-8?B?MVI1NUpDUWRvTEkrck05K28vNGsyQnhFOURIZ1ZUTWJvcUZvRzlPdUdsZjVD?=
 =?utf-8?B?REFPbTVkT013dXI5ZXJ5RXpUdmU0U0d6TEpZd3JXYTNBVHVyaUJmemdxREpF?=
 =?utf-8?B?bkFHclhJcXVnVHpaK2dSM3FyRVpLN1VwOC9ueVRkcGMwdFlZdytHV21VVkpn?=
 =?utf-8?B?OHo0RUE4TVVydC9sVFhkd3lpM0llV3VoRUZ5WUtuQWI0bXFVSm9QbUZDK0Nl?=
 =?utf-8?B?SmRlRjhOeTJNbWkrdTg0c1dCRVF0SzYvcEJaUk8zaDBzbTBPcXViQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75a8a01-d43d-4774-8e68-08dede779644
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 11:37:13.8845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZNXt6bKKKLWcPE7qCiBFfwvl6+68eomYkacuYXxV4Zl1emD4YQFS8xWsCN/iPmEjZfKWcvD5Y8Ljs30ueyEEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557



On 10.07.26 10:23, Dragos Tatulea wrote:
> 
> 
> On 10.07.26 09:18, Christian Borntraeger wrote:
>> Am 07.07.26 um 09:17 schrieb Christian Borntraeger:
>>> Am 06.07.26 um 16:15 schrieb Christian Borntraeger:
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
>>>> Properly calculate the input size to match the pointer and allocation size.
>>>>
>>>> Fixes: 0071b138d44a ("vdpa/mlx5: Create direct MKEYs in parallel")
>>>> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>>>
>>>
>>> Dragos,
>>>
>>> With this fix our nighly CI did not result in a kasan message. As I only have
>>> limited test coverage a full regression on your side might still be the right
>>> thing to do.
>>
>> Any feedback? 
>>
> Sorry, got carried away with other stuff. Yes, I will check it on our side.
> 
> Until then:
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> 
I was able to reproduce the issue with KASAN during our live migration tests.
With this patch the issue is gone. Thanks for the fix!
Tested-by: Dragos Tatulea <dtatulea@nvidia.com>

Thanks,
Dragos
