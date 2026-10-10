Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8436C2F1FDF
	for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 07:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791617881; cv=fail; b=VhoRqXoDlJegmbQRzjlq9HkZBA0DqyCaWJGb6xpH62f3/7XddbP+ZndJunLiyuyxBjTs2voY58fCyPLlZxfR/vPg72kizbZkggkjQKhW7kBQpWQ1YIDdbpApFdyRpJLbqQsR4Gm6BY3iBgiUEgR2GEnL7jBuZcN3qmO0F9zh0eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791617881; c=relaxed/simple;
	bh=MXTqi6uYQ45ybZ9zcZIRTTf0PLGGuxWpHvuC4a48nXw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JhyN7IgU5nFBN6u5MDMV0/I1FXeEsvuA1M8bbgASuy2i+Nm+E6toTa/fvqWYdRzS5BTWu9jsQ0li/Ir+XYFcBmJiZ+NFiqCDYY2dFdAKmiLGkHpMSftctSD61r3bO5+tPZBIXm5HDN5hjFMbH7jv5zPmj+MQqlw4YFfxdfZ1zaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FUHKkRHZ; arc=fail smtp.client-ip=52.101.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FUHKkRHZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqMaqZ2Tc80XlZE4BLZOeAi4zRzE3ZCZYiQNBECJ85TNU51/w0681SnQHgO3Qr63wOFoapj+x1KJLbGTN6wIWK2nNR84kz5WS/fAa3gK77ZotUPqfmflHMwZpoDCQTM1TmM8uIws6NJwHd0zzCBWvlxa5oTWmw0x6HWCkYmRbC9Q+Nc6GHoxdRunBfOx6dZhgTQwtew21jyjSGTxnFnUeJbZ5CuCLj7ukWEC+DZZ+X0fDETvZvJA90it1IMdu6X4m+FRC3WzPAVCdmfs9U3xmFqlrPiBeJbljBjUheAAnLMGnC0KrmSOsb0bdzjEl9KFeK+Q0ajZMPRE4wXSNEOUIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzF8fiJs15TupAMOGtcF/tbDJnFRYi5WcSd2OPbn9Ww=;
 b=uzJkjETnpINA4GTva5U7eaZAJwxxDJbm5TGMl2yXqzhK1Vtdx7r8l995ZDWmDgc7WJV0c5tsonwJAZeZt8yaexJUxdiUB4S1ZQO46LnzntP66yAxxyR7S2uQx5T/vN6pNGZ7hhGpfWEYnjlHXx8dWcdp5Ay1xNw+65iuCAb6otT9vRFN/12nqXfZSXaDipgWwFXuQSumsQRZhUK6F9QnzWTnJM0CHfZOVq1OFV+57xgDeoaPX1RL8f9rxY+GWKuAo6zFdPc1k97NkvHxfemlVSHCIyfS08TqPTjOMV0ZYHXLc9Cmxo7dojRev7kyINYngA9R2/Il2NtXtUKXtJwR7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzF8fiJs15TupAMOGtcF/tbDJnFRYi5WcSd2OPbn9Ww=;
 b=FUHKkRHZatuFQl935GrVMfq3aw5DC+FXVYIUyqE7LupS/9PnSehpKopObI6r82GjdsMbEhKalgsWNw5c41RWQ1HPMYe76YqEVXJrHOdiJCt2hZuvegL5YLPeOQiGeAdg5i9x1FhaxdHeeNiZGbOWlPzG4PIOEhuazmuw3h4+J/w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Sat, 10 Oct
 2026 07:37:57 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0496.010; Sat, 10 Oct 2026
 07:37:57 +0000
Message-ID: <7c32c182-5b49-4dc0-9c97-a4238743f28c@amd.com>
Date: Sat, 10 Oct 2026 15:37:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] drm/virtio: implement userptr resource support
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Ray.Huang@amd.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 airlied@redhat.com, kraxel@redhat.com
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-4-honghuan@amd.com>
 <dfa2f117-1094-40b9-9445-ab2bbf62ff2e@collabora.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <dfa2f117-1094-40b9-9445-ab2bbf62ff2e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0046.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::17) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 94fb2e2e-a6c0-439e-f8c4-08df26a16704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|18002099003|22082099003|261009223027099003|261009221227099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	VCkjNf7FX9SQEtD0aYurkhupZ/vO/F4PoOrTtvzpHwB33kTGnFRCzPMga0M76vCvf8gK/SP33TroVjyHFWjdTYjntKEzWDJxQbAMDeX7l7O9URkzjXs18bm9XseviFmqleiKiADEmXIstjKzeGgLf9UCPQWtF5BLGBN/Gi2pVZA489wJFIMnx0NEWweZUpBMHcKkRWH8gIyqD71MtkMhOfPcf6IZw6ckw7mVFJYUo8rERx2kX7mtsMgq1HgBU05lA99RNDkGUZYJit5eqvv99kcaRY55UbhpITTPZVnYDYNIsabOQqWKbhxO4lZ/OVQvllJ5RIR//TKrWfFluDjySBr9Z+zJA8khwy2eHmD2d3mVd0eVx9PQ5hOxcF6U8YI+yr/hxxeH8XOwXiMbnqIIN8rocgW+9ua3Wg/kTc8OVRRMW5Rs/qcArLphHyTtZaXL3VVRrAATcFvfoZ6hPLhrsJ+ByhES4+lyZTe5ycqI/lrPouVzkQT2gHPTIFanIs5GNqyTHtf7uenqB1WgMOzYJ4/o3NEfa5dexGensJjFGzHqsZiBKN3WcIr7ZUtqhC8Mj4VykQEzMvrUPG/ah8J8RHzGkvkIAet+SqhrJvkGWqJtI0ZFQ7nnKgJsA9Trw3uNgdMiDyqhYCo7b51lLWVauxQ2ycW6e6r1dfQssSoaJvM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(261009223027099003)(261009221227099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWNYRjhXV3ZWWXZ6TmQ2UlpacFlERUtFNlBsZjBoWi8vc2pZQlNYTTY1WFli?=
 =?utf-8?B?bGZoNlBHR2N3bEVBQW41VUlSTjVlWEYzMHVyYmxPY0w2WllXOGpCWmpweDFR?=
 =?utf-8?B?REtLdTE0cVZkaUNyVnlRUGJmR0ZnTEt6M2I1MTZSTU4zVGE2YlN6dm1ldUls?=
 =?utf-8?B?UXVNT0ZVVWlxT2hBRGRtclJxNWRxOXlYU05KaEExeVJhNUxESGFOem9IK3Jw?=
 =?utf-8?B?UDNmdFkrN3JjaTBnaW9YYVNGWkdIemoxLzduR2ZNVWZNUEliRW5Fd0xKT25u?=
 =?utf-8?B?eVA2Um05R2dzOHc2bGdkdjVORlNNTUV6ZCs5Yy9vRm5OampqbnVORVpOdWdz?=
 =?utf-8?B?NWNIbjZjT3dvbmtGRVlOSndKaEQ2RUNQdkN2ZFBVckdpcHBtTiszSWVaWU5a?=
 =?utf-8?B?SWpPSGFEL0xHbUtKU0dtclhaUUNqN1FzTFlkbkRVd25JMWZ2SWQzcUtxQ2xL?=
 =?utf-8?B?NFd5TmxYRUs0L294WlRjekN6NHRJc1FpMHo0NEd6VU41N3F1Wk83Y2E2aHVr?=
 =?utf-8?B?eFp5RmxjKzkreTdraU5WNzJRSHBCUXNXb2JUU2tqa29Jc1lLOWRyaDErbldt?=
 =?utf-8?B?ZVBwMVE3bFA4bTEya2NSaUJEUHNacm5PZjliOVJBOXJNRW9TTEVCUkp6Sk80?=
 =?utf-8?B?SktGdFp5TTJPRExWUGkxRnV1UVlFa1I0RDVKVi9mZTBJNUJrT08vdjJ2OXV2?=
 =?utf-8?B?M3AyQisxM1RRenRYY2h3bTJ5dUU5WjB5Q3Jxd2NnMmRUZEpCZWNwbkpWdU5K?=
 =?utf-8?B?a1F5ZGZUVDMybnQxc0lnNEw0SmNINGtKNlJtYXpyMFBaZGxBUHZTMldMSU1Z?=
 =?utf-8?B?MFBkb0dYa3JGWWdVUWEwTHBleEYxZVdCbkZOWk9qUG5tSGhqblovd3IwTFA1?=
 =?utf-8?B?Vmt4K01SZkMrWFpTbU9RUEowODNOUVB1QWcySkFJWHlQSHNlcFRXcGdsVW15?=
 =?utf-8?B?aGNDT1h1ZEFibndocEpPaWJXcUYxOFArWUpoK3JXTnI1VjBVVEdZNlRPU0xH?=
 =?utf-8?B?UW1OTDBoVTl3dGpWczRBejVoYlZnOGpQKzllRHI4RHZ4bW1wMndocVp1YXVT?=
 =?utf-8?B?b2wrY1RRUDZ4UFZUNWo5K3o1Mi9kZVpKYWpkYXRwaHN0MEovWEZOay84bVBy?=
 =?utf-8?B?M2lKbyswdzFEaktlMkMvWkZPbzF2KytsS09QdWpKWDF4Wi9VK1dxVzJxaGNK?=
 =?utf-8?B?QjFDZnY2d1l6Z3ZVVGpHbVlVZEhraUdPaGRFTkZFTlVya0tXMGljWVh5TGdr?=
 =?utf-8?B?ck5td1E3U1RTc0toS0NZRkZUK2FSYVZmaEgzNUdOZXhDbmNqOHVxRjM0VDda?=
 =?utf-8?B?MnNuRzNNTFpRa0pkUFkxZ1lTUWtwRXIzYUhGK3dhTXBEV1haNXA0VWhjaGw5?=
 =?utf-8?B?Qy84dW1MaXM0bzg4UlcrYnZoc25XS0M1YWh2YzU4WlFRV25CTGRDU1FEV0FX?=
 =?utf-8?B?VmNyaVFXaXp0T3pPeWVJMjZJMHMrNFRiQ3h6OWpwRGxiV0ZvTkpjSzNWNDVO?=
 =?utf-8?B?Q0VnMDhPWUZMa253L1hEUnFBWFJqMDZTTGc1eTdneU5XTkRZZ1ZWTHBEYzIw?=
 =?utf-8?B?UzNUK3NYVkk1VkExQ3cvQ2pSaGY4OXJBaUx1ZEUvL25ack5ZdUNVZlZWWUNz?=
 =?utf-8?B?TThZWmtYdDdyVlpRWXcvTjA3STVLaTU5YUZUcnN3UnZSaXVuakhNaWpPRnIz?=
 =?utf-8?B?UnBMUW5iMnBPNy9uY1dCVUtOeUVrVDNtcUhwdU81dUlxR2k0VllQQXhuUGkv?=
 =?utf-8?B?YjUrOWpqN3kzd25ybko2TCtmT1ZYZjFSaXJmSVgxLy8yeG9ndlVGRlhUZXo3?=
 =?utf-8?B?VGhhRkpOUVpFdUtQaU9HeVFuZjRZWWR1SkJaMXg4bmUxekN6L3dxcitibFFt?=
 =?utf-8?B?MHRjUmxmVDhjWnRsY2M1VzJtaWVnbzdadlhwb0YvQjhIaUVjd2N1WFNVdnR4?=
 =?utf-8?B?ODczaS9Ga00vUDhKWDhPNFRIOHhxMGMxVEJXSUxMRXRVa0hlbTkwSWZIMVZ3?=
 =?utf-8?B?STJkaUgzZm0vWld4ZmZnZW8xWjdYbzI1L3NGaGx5K0EyeEp2QjV3NnJVWktr?=
 =?utf-8?B?K1k5YmxveVdnd1IzN2dEbU8rRnJ4LytmNW1kd2cwNzI3eFZTeHhudVVmWXBB?=
 =?utf-8?B?d252eUxsaVhZbTJUQ0xHUWVsY3BqeDhLcVJzUUtJc2NHbHJMRTdpTnlQR2ov?=
 =?utf-8?B?SkZDbGQ2Y2I4VW1xV1cyaHdsaXdYbTRYU045cVNVd2lNQzlwQlFzYW5OK1Y5?=
 =?utf-8?B?U29IZUtva0VaTUI2UjNxeEtmK1F3SGdUT2xIOUE3SHR4Ty8wYzdxRWtEVzZI?=
 =?utf-8?Q?6/yES/nQ77RL8NRl6L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fb2e2e-a6c0-439e-f8c4-08df26a16704
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 07:37:57.2174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOxI8+ykEUfhNab/vFolYNHShJ8r5N3u2nxVFpsuXUh7lTwvxNgjiMIDcJ1bmaUPeONRyGg5HR7GnCQegbo/mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042



On 10/10/2026 2:53 AM, Dmitry Osipenko wrote:
> 24.09.2026 12:55, Honglei Huang пишет:
>> +int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
>> +			      struct drm_file *file,
>> +			      struct virtio_gpu_object_params *params,
>> +			      struct virtio_gpu_object **bo_ptr)
>> +{
>> +	struct virtio_gpu_object_userptr *userptr;
>> +	struct virtio_gpu_mem_entry *ents = NULL;
>> +	struct sg_table *sgt;
>> +	struct mm_struct *mm;
>> +	unsigned long lock_limit;
>> +	unsigned long start;
>> +	unsigned long end;
>> +	s64 new_pinned;
>> +	unsigned int nents;
>> +	int ret;
>> +
>> +	*bo_ptr = NULL;
>> +
>> +	if (!params->size || !IS_ALIGNED(params->size, PAGE_SIZE) ||
>> +	    params->userptr != (unsigned long)params->userptr)
>> +		return -EINVAL;
>> +
>> +	start = params->userptr;
>> +	if (!IS_ALIGNED(start, PAGE_SIZE) ||
>> +	    check_add_overflow(start, (unsigned long)params->size, &end))
>> +		return -EINVAL;
> 
> There is new vgdev->blob_alignment defining host page size as it may
> differ from guest's page. Will be good to validate both.
> 

Will add blob_alignment check in next version, thanks for the review.

Regards,
Honglei

