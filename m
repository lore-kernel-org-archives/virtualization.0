Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391AF42A16E
	for <virtualization@lists.linux.dev>; Mon,  6 Jul 2026 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783340658; cv=fail; b=PdBiXtKbx0xeum/gJfxfJM050lu34ps355xM7ALygJ796AXKJ63SByRbE1DbWZHFY+pZSS44AV6agJRV9VE8+Cp7SNX6x1WAlrNZ0BLLo7+2stVUm6Tdh+Jq3M8cJbLx1ocZUz78HQIGKKwYUd5e/3YYQjlcZHHigAoI7rXc0og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783340658; c=relaxed/simple;
	bh=pBC+8TYzfqZdj7B6w6JnMBWF0PDmyp+zWD/ELqataio=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ANOY3ylfiogq+fhSwRjmTqPxcjXHzpeGv0bffKYKnOIsY2f5payqkP7OHkn+/GDrzWFbc0NjDmULza4nLYw9xBSCH66MLMmmaauH8qviFkkaNHHgp6BamTmOnZfX6G05TaQiGBppKw8TdleVz7a5pOTyuoFj85YvdzTHFotNhpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WnOzDC9q; arc=fail smtp.client-ip=52.101.193.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WnOzDC9q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvORcwKtZRgmRUh+pcolCRPsPZNIytSFKwWKrPjOJo4tYbXsZp5uu84g78mofbXdZ4n4tHsjkn7jGTDtLno0ns+D5560WWR36MWw6oQEjNpE7TCVtndxj/4aG3fCGJSjBuzEbyIjHqpSP030c2l9ztuY7K7adEZvjHJKDFLr3LT/d58tjyv8JEOhyWKMRPdzbnSzz2O2hCYVQkegRClaLqzL/u2l3DkCQPUMLrwe375clZ9/mbU7H/1h49gpBrbpQ+f76Ug/psf4qLsAMXLNbSgwkN3lwNrwkWd4g0m7fXKEGlcZLL+kKhXbQ9kuvHiSzy101o9NY4wXlp2n9besoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmE1uT4Vz14SnWxWRw9m0wB2v0ryNKqAMwhFJxOKmCc=;
 b=yRLaD+DbEE8eQW1CL8yY/F0Sfx0f6Lat/5PJxEHsUjpPHKwKaytpKJGACpF5sa4lN+BpNNyGVIcHD59nkRSdb/5kvpoqvMtCzRS8CMR5ge3yY/j9ZOoGKHb2/VLEoAsRWBCckyoiwtFEsVTYsKirWHMWZCZXeARL7P1cXyHhvVPoBQ28Zld3+P5VUEIHufb0YWgVhFhCMDJU0XJuwRh8B+q26e0vywOtU1j3CHj/PihM5FJjcrg5kfjSQOSSGFoinFJ2OiA8td4Ho0sQycbP2vGwu+SCby6rtApDbJCXQ5F/OFhb3HvaEAvSdfA2B/ntlnqcjU6/vl8if53z2FeREA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmE1uT4Vz14SnWxWRw9m0wB2v0ryNKqAMwhFJxOKmCc=;
 b=WnOzDC9qPS3J9T+GaMbmPAAXouXiogak7C3rRC4TDqwPV7dvPuMnG0aEzaouoaWmN/MepKZ478NTwqP8LK6ynU7tKFlZgsNwRMF0eMZ7yfqcFRgjgNXhenu7qh4nUTmfe0QbzDKq1+QPlBR3NIYrjK0Ib99U3ctCfyK/dYfpEA1ot92gUzhrnumpGtOI2lcAVz217X1sGHJA7sHTzk2RhTEZ1I/CgWyn5bC5XfWzw0fq5PFuZ09w6VbMZfOnDTcAlZcOBCYJ1b5znJsHUW7sagyFWDDj26hRFjWCTdBV1DqTVj4Vts8cP4DksBFtP71EYtD5KxNC5EjJaTUcrPlnxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by CYXPR12MB9339.namprd12.prod.outlook.com (2603:10b6:930:d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:24:12 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 12:24:12 +0000
Message-ID: <d7272d8d-8146-4ed0-90d6-2a27eae5ab6e@nvidia.com>
Date: Mon, 6 Jul 2026 14:24:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCH] vdpa/mlx5: Fix buffer length in create_direct_keys()
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260706100129.1541140-1-borntraeger@linux.ibm.com>
 <06b371e3-418c-41d8-8c06-1971cc24d8d4@linux.ibm.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <06b371e3-418c-41d8-8c06-1971cc24d8d4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::9) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|CYXPR12MB9339:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d2d8cf-3bd1-4b22-c320-08dedb597c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|4143699003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	OJUlWYLqttSmguY4sOxEUMGagE3pXJlMPR+IokKdKIgJGj1UArpNQCqvNqV+jpFwWsgTbWIqrqhTHUGfVKWTMoZqaDkWENVT5inl3fFlKNgGyyD3HbpAwpU9D9yzDk5KVzZZdrKzT2g3rHS5OohhCvRjUBdnVfFyS+U/Zp1/OvNJmd8UlFHk4CdLy3TF++EnGhD1C4XrmVYxF1aFsEJHoKRNaettnQpYGCwbf8UrlROwIeAAFXoDocb7b0kjQFHp5SDO6GgsxElehWeQiX8MrCyh+kuHOxLhwxGY5AFok9FNbbTYrGmDJdt8nZ9nVreGzjdbzsQ4koc5nPBShFo+HrQmrgfg8uEUpW/AlpZe+RKtrjepWs1XhTapi0e+Xi2BH/qMJjEfnXzXny+FOt90aAXeQbMu/LbBXQcqkuc09tRixYi00W5+kzGl5mkotoAawk96ZMKbcd4OJCY3FoiRo7Llr1TJ/gzSY9a7dkYUeNVsMeglVoSWb5Z9fkoebFdUonEYiN6jsb+hTNDznwjbEjWJrvKQu5Ib4AusLL+MG5dVufFuUqbBNcUSDMjYSIleX7B0BICzvufmIOhjX+UnbpYiaPDCNAcxBDrt8LGrKyW60PRdS/nL2OqNqOtNFC/VL6reIxj1jPJCGimO+so22Q9WoZQyrXW8Arnd5Q0g1wA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(4143699003)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzExZWFPYWVQYlEvV0F5K2pWemNadnpzekJZT0xsbHU5R2hhVDRWQ0haSmxv?=
 =?utf-8?B?dHNJRkNEM1VKajBMUjV1bzFuQlJ6NS9PN3duSlJIWVNqZFdJWHRKdkV3ejJh?=
 =?utf-8?B?NjVlMW1pVEFxQ2FwTk4xaDZmekRPNEhyUnV5WldOMUlHWStFamlyMTdFZ3pq?=
 =?utf-8?B?Rm93OXV4d2ZxdEFQWFFrYVdic3ZmWGZEV3ZBd0ZucXJ6dEhFdnd1dUhuM3lH?=
 =?utf-8?B?eCszT2tJaktNSXBpU3UvOUQ3UTluT0RuRjdsV3BRWUxUdzF5dmErQXEwZlRr?=
 =?utf-8?B?NFF0dXR0RFpKaHBweUFQU1ptUktzVVBOUi9RM0hoUWluK2x0ZWR4WW1EU3FD?=
 =?utf-8?B?SjRCN2hCK0g4K1hlNFZadE1GcXZ0S0tKcm5EOU9qZFpublNkM0NWY2E3UnpR?=
 =?utf-8?B?S3paNXVwY2JXakJ0Wjh0TFdPdnJYM0dVcmxFcjUyWUNpNXhJREZ0ckNJNUxM?=
 =?utf-8?B?Vy9EWk1QdjVLcE5rVDhpaGFUS2I1WTlSOVV4aHduakFJblFUeUhKR3M3dFFo?=
 =?utf-8?B?YTBhY2hBNVBBbnNTUCsyWUhKL1dqYmY1MExMbVViUWdpNXpkcko1Tlc0WVlU?=
 =?utf-8?B?dmpHbXdPc0dQR204UHJQWVh2QTZJaDNtM1ZZMXdjN1EwQUJ4RDJzUHdxcDNW?=
 =?utf-8?B?dWdSc3ROcHZwdEFiUGFDQjhHazk3Nkw1ajlocENOYlduK1NvMThxOENyd0J6?=
 =?utf-8?B?ZjlINmNYYXduNi9tckdlN3hDRTRCSDZmbk9Ucm5LWDNXTkFNVHNSR01nRTVG?=
 =?utf-8?B?MS8yRUZjY3NKUGJOeTNuS1VYYXBnQkpQbXB5N2p6R2RYc0hxcC82L2ZrWDZT?=
 =?utf-8?B?c0gwSVJsRlhDSHBadnpZTXhpQTM1Mk1QSDFMY2RxeUVNN29xMllRNTdwRFhS?=
 =?utf-8?B?OFlRbGtrYzlablJNakIzamQ5YXVzZGNIMnFzQ3EzdS9ZYWREWjE5NUxFcUhy?=
 =?utf-8?B?MVAvSFVNNlhzQ3RqVThBTXdtbWNZVDB5N3JTUnFkWTNvMEtUTkM5MVBVbnRZ?=
 =?utf-8?B?c0RWZzRRTURxekx4ME1MWHdIMXh0SWtCMVFkd0VzM3Rld0pUR1gyaUV4TGN5?=
 =?utf-8?B?WTBrckxhTnNONDVoV0NNUW9YbnhYTkFOaVVZeUFEOE1scVhNM1JrZ25kckFH?=
 =?utf-8?B?WXlzbjJxM2VpdzNmMS9WZFU4TjdXcXNlWGhYR0g0M2xzM2huUksyeGlsN0xS?=
 =?utf-8?B?QmFGNU9LVGF2cklUVDZlR05Rc1BPaVRkcDdibmdnZ0NRR3hPd3FrMmhySzZO?=
 =?utf-8?B?ODM1eFJMSklaL1BEajRzazlHNTVwRDNNNjNqc0tVUi9rVDgvR25NMmlobnB3?=
 =?utf-8?B?a3ZXSUF1cVlrWWtDaXFsVmtUTzFzZll3K2ZXZnFwYitOOERCRGdzQjZIMWJi?=
 =?utf-8?B?RFRNTjVIa2U2bFFMQzkzUzdtbUI1SHFNUzNlSVdiTkVTU3JkamRVcTRLU0to?=
 =?utf-8?B?R0Znd3Y1cXlpQWlrL1VLWWo1RHlneGZ0MmJzQnVxK0tXbzlRMmltK1ZPNGpr?=
 =?utf-8?B?bDR4SFRha3o5cDNDai92WlZvLzkwVmk0RDFiQzVWQkVVYUhjSkFEMjd5alRn?=
 =?utf-8?B?c2RIYzRTcDlmQXRFV0taeFVlZHJxNTdtVjg2U2NLV1p0VUx6aVpZSk8xQk41?=
 =?utf-8?B?TmxYdkFiUGZPZEhKQ2tTdWZ3ekhqSGk0QVUwdzUvaDM3b3FrT2g3QmZ1akwx?=
 =?utf-8?B?WWxNTU00dk16dklZUTBiczZERHhYR1VFdWVFUnJmU2phRTJ6bVRQVFkxSzU0?=
 =?utf-8?B?RU9OVk1uMmxBNDU1YlROeVVGN1lNWTdPT2ZCUXh4dVh4NDRWaC9ZNjFmcTNu?=
 =?utf-8?B?OE9sYVNkZHNtajcxOXVYZUhRSEVacXh0RzhheDhRYlUydHJyTnpmVVBYNGtM?=
 =?utf-8?B?MTNVNVZ0d1NSMXhWSGNuamdqeUhpVWpKVUZvanhzOUVqc2V2blY5ZUZtVXRI?=
 =?utf-8?B?VSt6Yk00cWxWZnYyc2prTXNQcGF5L3ZPT2hrNmJVSGNjbUdveDBYUldhR0NB?=
 =?utf-8?B?Mm41ZDFtVG16WlNJYldmOVNFV3h6TGducjIwa1dhWnNBdmZsSDRBbjFNWTZG?=
 =?utf-8?B?YjcwT0xuUnYrQjVEKzVDWG9mcDdWTmxNbk5IbWFlczVqOHFhbUF4cW9aVUZl?=
 =?utf-8?B?NGduSThqOFI2ejlvV3paQVZBYktqbC9Vb1pOR3RPQXN2c20rQVUwV2crQnJO?=
 =?utf-8?B?RTBxSW9BOE9ZNkV2QmFjaEd2MWVnSFVqcjdXZFVuVkN6UUx2dkxGNVVHa05Z?=
 =?utf-8?B?UkVHL0xNN0FDSjdDeFIwaytMeEpGakFvcmtRL0Fwd0Z2ZWJmZEtwWGJZM2dV?=
 =?utf-8?B?YncxOERwcTBHYkRENU1RNG9uSmFub0x4Qk4vcDdiUUZ5Z2U4Tmtxdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d2d8cf-3bd1-4b22-c320-08dedb597c6d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:24:12.3289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kGQyB2OLlIGp+Rk2abZe3B5x18E2S4yFbYMWtAhm3zAg9GIf5CvdYB9CLvf1fwi4j5FqzXHerKAK9I9PyPCcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9339



On 06.07.26 12:13, Christian Borntraeger wrote:
> 
> 
> Am 06.07.26 um 12:01 schrieb Christian Borntraeger:
>> We have seen in our CI the following KASAN message:
>> BUG: KASAN: slab-out-of-bounds in cmd_exec+0x550/0xca0 [mlx5_core]
>> Read of size 272 at addr 0000000176795020 by task qemu-system-s39/82764
>> [...]
>> [<000011388ab3a7a0>] cmd_exec+0x550/0xca0 [mlx5_core]
>> [<000011388ab3b61c>] mlx5_cmd_exec_cb+0x25c/0x4f0 [mlx5_core]
>> [<000011388b21e82e>] mlx5_vdpa_exec_async_cmds+0x22e/0x5e0 [mlx5_vdpa]
>> [<000011388b21fd44>] create_direct_keys+0x954/0xef0 [mlx5_vdpa]
>> [...]
>> The buggy address is located 4128 bytes inside of
>> allocated 4384-byte region [0000000176794000, 0000000176795120)
>>
>> So in essence we read 16 bytes beyond 4384-byte allocation.
>> create_direct_keys calculates the pointer and length for in and out
>> buffers.
>> The size calculation for in includes the entire structure
>> size (out + in + mtt[]) but the pointer passed to cmd_exec points only
>> to the 'in' field, skipping the 'out' field.
>>
>> This causes mlx5_copy_to_msg() to read beyond the allocated buffer
>> by sizeof(out) bytes when copying command data.
>>
>> Calculates the input size as sizeof(in) + mtt_array_size to match the
>> pointer and allocation size.
>>
>> Fixes: 0071b138d44a ("vdpa/mlx5: Create direct MKEYs in parallel")
>> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>> ---
>>   drivers/vdpa/mlx5/core/mr.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
>> index 6d02ccf9eb91..03fe7f5ca412 100644
>> --- a/drivers/vdpa/mlx5/core/mr.c
>> +++ b/drivers/vdpa/mlx5/core/mr.c
>> @@ -233,7 +233,7 @@ static int create_direct_keys(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *
>>   		cmds[i].out = cmd_mem->out;
>>   		cmds[i].outlen = sizeof(cmd_mem->out);
>>   		cmds[i].in = cmd_mem->in;
>> -		cmds[i].inlen = struct_size(cmd_mem, mtt, mttcount);
>> +		cmds[i].inlen = sizeof(cmd_mem->in) + (mttcount * sizeof(cmd_mem->mtt[0]));
Woops... Thanks for the catch. The fix is good.

> 
> Assuming the fix is the correct fix, question is, if I should use the offset of in instead, e.g.
> 
> 		cmds[i].inlen = struct_size(cmd_mem, mtt, mttcount) - offsetof(cmd_mem, in);
> 
> to handle potential alignment and padding aspects.
> 
Seems harder to read. Why not:
sizeof(cmd_mem->in) + flex_array_size(cmd_mem, mtts, mttcount) ?

Thanks,
Dragos


