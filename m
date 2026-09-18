Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE94D179B;
	Fri, 18 Sep 2026 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746412; cv=fail; b=ePekLtYZWxu9AOzDoRv8fPFgjxnI+5c8K9Wo7fs9c9eH010NfrM/2zdh30796QJqFFM3hgkidsIt18CQ+cBy22QkQN+C/yydRNoQGjFFsngvGQhJkvYmkcYNpFhMWVohddaBsbElSSCypZziKAG/UWogRVoekiOYSXTNq8Gqd2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746412; c=relaxed/simple;
	bh=241GNGHq006q8i8XLXOFoWzeNkmK2jw7P5480QeEW2o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ffHQzmBPpOv9IT+FVxwho3P5YanCT61hXHTvzk4e/aC4HienVB6zrwz75JwdP9nmvm1TqxH/z4r79EtvU+eeEq/S3s029O2utrG5SPq395GNtNboaqKg6FJ8szUa5Qp/jnBWDy9BiWrC5XDwft5di7YLF6B/ikGkc3Vois1SX4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O61dkZfc; arc=fail smtp.client-ip=52.101.43.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O61dkZfc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwPgADxCBLo9wE/EG/w8cyE2pzn8gXxI2hAOm/5/n1+xh96D/cVLnZ5uttNwSAmirEQIP6CChQcYVbwV5OmbkjVcwsgF51dgYo+Sa8vAeyz/NEc386JGT53qLxe0OZCWXp0rxEMbMDyEkrSaUGQJWXoZZd35MHMU5b9SpFSP/oD84t18PJSaDbzVv0W6zv496ERIlXOBfdFzm99pbiEwjlvMoW6m6vvBw6Mo3+bVKafkwwSnl1Bd8L3om2dxzAVR8lfWqnr+s7Ct7brCbwIc+3w6ZQP/gl7q+fjPufiez6YrXt++kLDQjDlVhtY+TyTPZGCnNM27jEWayHs/ovMBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7dMwQMplat5DFHDbIQMNJjfKd17zCBn0hXMyqTRNRA=;
 b=MeiUFjDoAHEflz8CzFyiq+QV+YUxXi1NPpF9hs0jicoDBI1pHN0ijQ+r4Y07wPUEdNsRs0UT4YrlZdokDQa2UUamoVy5NHKh+OpM2WQFujqzKXrLGgsyLVtueqH8Sq8/Sh5U1SP1KI5fZ+wAFGLHzcGx84Zsb6tJKUUItTWECZ4HfcgxRlTmrXtYVicS6s+q5VqwI660+o6hICQzXv1IQcPPQH2s90apGW4HH/ECKSW2nKe/mfaazADnJhcDMqrPxU3eSp4wQCgAQ+MRMTDuBjUozr2WJHTlmjJUEXTYnRunfmK4UORJf24HnmhqzyCjqpoOfl8PVbF+J3Wu7QzetA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7dMwQMplat5DFHDbIQMNJjfKd17zCBn0hXMyqTRNRA=;
 b=O61dkZfc26H4hED39rRoyfXvClD1veRzkzZxrd63F04vaaFOgPILoIsNAKVwQCAA2QIFeKxOFAgjFGCr+J1y8kZnU94rOU0j7YGwQnMmMdWNpkw2IOeYRn0kSj/DSqlN9uqCQdWS0d920EiGGAr6Kq34zvWxbEbTraSyTtdsG2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 15:46:43 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 15:46:43 +0000
Message-ID: <52c825a5-1b47-47c7-8717-d194953e2986@amd.com>
Date: Fri, 18 Sep 2026 23:46:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM
 capability
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 sashiko-reviews@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
 Eugenio Perez <eperezma@redhat.com>, dri-devel@lists.freedesktop.org
References: <20260918095940.2253018-1-honghuan@amd.com>
 <20260918095940.2253018-2-honghuan@amd.com>
 <20260918100746.2BB741F000FF@smtp.kernel.org>
 <9fcb3203-63f4-4332-a47e-916774e11eb3@amd.com>
 <0e644466-8b4e-48bb-9322-e47c59c5c77c@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <0e644466-8b4e-48bb-9322-e47c59c5c77c@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4PR01CA0067.jpnprd01.prod.outlook.com
 (2603:1096:405:370::11) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|PH0PR12MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c8bb04-d278-442d-7e18-08df159c09e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|4143699003|6133799003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cY9Rqx1SGa8jy83YlvfNBQ7UYpwaAREZKXwCYnwRhnlKf7BmuXIDnKQHGA0F0xhHNNqnhpqy71g54eK5EbqfU0LGYg8ggkhXOWmeak83IJMc2IAEo7uNZPUWg/6+BqMuC+eMc5NJM40vp5psnkhoJGm6ydsUrpjHPod8uGcH5mPyyoY8BDivuzv9vNj9cmE/FeRr7iHIpd0PayB7goTHZzDsKWXnRl8JIJ7Z7+/sPqW+Kta99b9eqhyUqYqXTwyCEA4GsyigdsC9knENN2J7EAOozchdizBURb0KXviAr9DnPMUbPHG8WoFSGvF1h4WcUhMGKpiyX9HwExT/9V3bsIoIxZ309LH6JtHoRP8E2gvYkaUb8UG17weEvlKFT2q0IAlnXlx/BojbYBh+p6/iSYHl4yidpiO80SJF9txvkQc4zjVlKvPAOWslLD/bkZU8eP5T4+kC331ryOv/kc9IE52CE7kvyaXJQDCwKBuFMFFTR4a4/SuKLX63JFp/vfS5IRU/2GTB+FkrGHeOWlElNI2YEBasadmxaXUvHALo4aURBEWn/V5r68DT9rQZwSaIuNhCp9H4yMOTu+p6wq/0Vo1AEUVcFaiS/rk4dDxW/RoArtlZP1U8IdiVoD3L2X8g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(6133799003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0Z1RlFleW1sLzc0eURxWGRiYmZaeEpJclgxVTl0MWt1RjBZM0dNclI3dnp3?=
 =?utf-8?B?dXFWVzZRMGIwcWhUYmlKSzRYZ1B3QzJ6U2tBdlhHWEQ4QWx2d2c5VjBOa1lr?=
 =?utf-8?B?VzRYdmF1TkU2YjRKZHVickkwM3pab3NMZUhzNVByZlRLRlhhSDlMY0RnRVRT?=
 =?utf-8?B?dDQyV3BDZFZrMFhNU2g2RERDRkhNMXUwVGJuenhYckNnOTU2emVuODN5N3Rh?=
 =?utf-8?B?eWZtT1psRkxPZS9DSlhhREJmcE5PTGh5TG8rZUpHdEY2VjhqN1VNUUZXUDRV?=
 =?utf-8?B?WC9HU3VHZU50RXM4a0V0cllaaEljL09OU3dIcHhabjBLUktGUUxOMWM5T21Y?=
 =?utf-8?B?eWlZbW15WWJYKytxU2VpUFJud3BDWUJ5UkU1bTB1TXg1SmRNUTQ1WEFFTE9R?=
 =?utf-8?B?UUNrTWg3T0NpN0ZMWTBuU2RMdmN2RWZJRDI0a2RxTERUbnJFYTRvdnNVRmpF?=
 =?utf-8?B?TUpGWjZsWTFBNWUyazZpcTNDR01qZ0FmYXpsL09QWm54a3ZudXQyMGN3bUFp?=
 =?utf-8?B?V3VYTHhuNkRvc00yMGovWWZNR1lxMGFOYUhvQStoTzRoeFR0Wm9JWEYwSVdR?=
 =?utf-8?B?Mms1OTRGK2RtQktEYVZUZTRaRGMwNHg1MDFFSWNtaFJZZVJQVUoyOFRPaUZq?=
 =?utf-8?B?YVlwamZESDBVVlN4RGJ1bmF2d3BjRjRyM1BsYmdURDNVTnNoZ0NiSXJzSnE5?=
 =?utf-8?B?N0tnYTFQK3drYWR4ZCtMMkdkZGIrNDJiVk5RcnVOUmJJcHRPdXVoUjk4Y2NC?=
 =?utf-8?B?TDhHMUdyWExuQzZpZE5kTXNMSTBzajNOZWNxaHJvN0R4OUd2My9TU3pXVDhU?=
 =?utf-8?B?YW5qM3NlWmtCT1I0YXBjbGdBN3Q2Y0ZDR3V4VTY0SjJMM0ZmWmxsT050RkdE?=
 =?utf-8?B?Q3lrQzN0dzBwM0I4VTViS3FYV2kvenIyZENwZERpS2QzL3kyblRXRlRybUdW?=
 =?utf-8?B?djQvZzJSWWprem9YVEtaVHJhVzVpZ1Q2akJOT1ZnaFZRWTJlckhoeXJBZ0Zh?=
 =?utf-8?B?bGgzSTQ3a2hqTzBtOU5LL0FsbjRHUWZycHhwd0hJU1BKK2NKckpNY3FSWUhF?=
 =?utf-8?B?NFh6MWZFQzhkS2xYTld5QXR3V0g1VjB6ZzlhYnNiNVRtQTB1Y1c0Y1R1TFRB?=
 =?utf-8?B?dHZ3RHc2MlFoMVVHdmgzOW5LUk95aCt2cXFaWWx1dDlreEtTK1YyTzN3UlVZ?=
 =?utf-8?B?YWVwL0g1a09BSys3SWQ5L1ptL2tCeHVmOVZFOXV3dzh5elcreEk0M3NiUTFK?=
 =?utf-8?B?R3Z4RFZjTDdKTWNtbXJQL0NleHo2b0lFVi81a1Q5SUkvTGZBMU1VTFRVRTIx?=
 =?utf-8?B?bmhsLytUVnZIUEE4SDRScXIzZHRCWlNzRkcwd0FleDNtcXVVZzdxMmNyeEd5?=
 =?utf-8?B?OVgwNTZZUXpKaUJycUFuaHIxQ3RDK2JsTDJXTTQwT3N3by9EQTlFS1FzOUFI?=
 =?utf-8?B?bEVUU3lRVEtkUHEvRHpHdGdtS1NCdlBUTnB1YitrN3F4a2NKclNlVzh6UUNh?=
 =?utf-8?B?cUNaaWdYaHdVdThyaEduSm9XakZnUlQyMDQ4bkVvYjdUTTVueWR5YkFjMExQ?=
 =?utf-8?B?cndMUUJHVGxZWTl3d3Y5WHFxYkVhc1ZIQ0xCeDhDMUZHT3RSeFE0cUVyWlZi?=
 =?utf-8?B?dkVLM2o4ZnQwNnRtTFcyM2ZWRFNjdWNOV2hLcnJLY1VndmNrZ081T3g0OEE5?=
 =?utf-8?B?Y21zdXZYd0oyR2l1Q0svN0NZUFd1MExCaW9NVDV3VHBOTUk2N1dzVEpCaVMy?=
 =?utf-8?B?YTlwTHB4MjJrTWxEdWxwemdndUI3eFpNL1lIcS82SWdUcGJpYll3Ymp1N0NK?=
 =?utf-8?B?Nm1zZnpZS01HVGwvYm9aRm1PemFmeFBCT21RWWVaSHdqZmN2N0FEanVZQ2pP?=
 =?utf-8?B?RU5sWmFZdzRrTUhXR25pZGFvYnZ3cFFBMXdwdlBFM215VXFZYTVkcUpCWkRK?=
 =?utf-8?B?L0NvS1IvQ0NnVmEwVzc2RXdRRnU2SWFST1hidDdoZW15a2gvYjhKNUFyWHZM?=
 =?utf-8?B?SlEzSkdSM1hSejJvSDZ5a2ZYT2QrSURldUxLZndaTkJBbG5rbkRBMVRKeG0y?=
 =?utf-8?B?eHhpYWJaZ0JEcVFQVnFtVmVDZFRHNG8yZzlORmRXcW5Ga2Q2M0xtYnBNQ3BG?=
 =?utf-8?B?akZoZ1kzOHcyRE5SeXZ3aVdHV09wbGUrVHl6UWdYN3gyeVdKUUd1aXBCSnpU?=
 =?utf-8?B?QVZhU2pvMHkxaEo0c251OTVqTDh2MFV2dTRpMi9yKzVnMGhrNE9ncWJrTnVG?=
 =?utf-8?B?Mk5Senlld1JSUVNzZnYzcUMyWTF3YlhVc1FRTnduVHE0cHJDV3JzOFhpcUpR?=
 =?utf-8?B?K1l6VHBOb2VGN1R1YUJYUnM5TWNIenZjUmV1RS91amdHQStjNGJOQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c8bb04-d278-442d-7e18-08df159c09e6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 15:46:43.6243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxbqtvXMV8Yi64zexAuFgJD31NzZRdyKdMbflSzkKmf3RaDFPVZM/NvKLjzEgyUU7TOuoemImI2XiNAFyTklNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906



On 9/18/2026 7:27 PM, Akihiko Odaki wrote:
> On 2026/09/18 19:13, Huang, Honglei wrote:
>>
>>
>> This patch is for adding ROCm capset only, can be spited into another 
>> thread if it is needed.
>>
>> Regards,
>> Honglei
>>
>> On 9/18/2026 6:07 PM, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 2 potential 
>>> issue(s) to consider:
>>> - [Medium] virtio-gpu: premature UAPI exposure of unfinalized 
>>> capability ID
>>> - [Low] virtio-gpu: missing DRM UAPI alias for ROCM capability set
>>> -- 
>>>
>>> commit a394228d77eeafc9f1dcc36150380f8561f1ee49
>>> Author: Honglei Huang <honghuan@amd.com>
>>>
>>> drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability
>>>
>>> This commit adds a new GPU capability set VIRTIO_GPU_CAPSET_ROCM with 
>>> ID 8
>>> to support ROCm compute workloads. The commit message notes that the
>>> matching virtio-gpu specification change is currently in progress.
>>>
>>>> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/ 
>>>> virtio_gpu.h
>>>> index 4f530d90058c7..3d4dfadc9d789 100644
>>>> --- a/include/uapi/linux/virtio_gpu.h
>>>> +++ b/include/uapi/linux/virtio_gpu.h
>>>> @@ -321,6 +321,7 @@ struct virtio_gpu_cmd_submit {
>>>>   #define VIRTIO_GPU_CAPSET_VENUS 4
>>>>   #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
>>>>   #define VIRTIO_GPU_CAPSET_DRM 6
>>>> +#define VIRTIO_GPU_CAPSET_ROCM 8
>>>
>>> [Severity: Medium]
>>> Is it safe to expose this speculative capability ID to userspace 
>>> before the
>>> virtio-gpu specification is finalized?
>>>
>>> The commit message states the specification change for ID 8 is in 
>>> progress.
>>> Because the Linux UAPI is frozen once released, exposing this ID now 
>>> could
>>> permanently commit the kernel to ID 8 for ROCm. If the OASIS virtio
>>> technical committee assigns a different ID or rejects the proposal, 
>>> would
>>> this leave the Linux UAPI permanently incompatible with the standard?
> 
> It is actually somewhat common to introduce a capset before updating the 
> virtio specification, as capsets remain opaque to both the spec and the 
> kernel without strict interface stability enforcement (for example, 
> VIRTIO_GPU_CAPSET_DRM is still not in the spec). However, we must at 
> least wait until the virglrenderer developers agree to implement it.
> 
> An unfortunate complication is that gfxstream has already claimed 
> capsets 7–9 prior to updating the spec or kernel headers:
> 
> https://github.com/magma-gpu/rutabaga_gfx/blob/v0.1.85/ffi/src/include/ 
> rutabaga_gfx_ffi.h#L41-L43
> 
> You could target capset 10 instead, but I advise coordinating with the 
> VCL developers first to avoid further collisions.

Got it, will use 10 or 11 in next version.

> 
> Additionally, "[PATCH v8 2/4] drm/virtgpu api: add blob userptr 
> resource" poses a more critical issue: it adds 
> VIRTIO_GPU_F_BLOB_READONLY and VIRTIO_GPU_BLOB_FLAG_USE_READONLY, 
> directly altering semantics explicitly defined in the spec. We should 
> see at least a draft spec patch posted before moving forward, so this 
> series should remain an RFC until then.

Will change to RFC in next version.

the VIRTIO_GPU_F_BLOB_READONLY  flag is for ensure host side will handle
the readonly flag instead of ignoring that. Actually I think 
VIRTIO_GPU_BLOB_FLAG_USE_READONLY is enough, but AI review requests 
needs a VIRTIO_GPU_F_BLOB_READONLY  feature flag, maybe can remove it.


> 
>>>
>>> [Severity: Low]
>>> Also, should there be a corresponding DRM UAPI alias added for this 
>>> capability
>>> set?
>>>
>>> Previous capability sets have matching definitions in virtgpu_drm.h, 
>>> such as
>>> VIRTGPU_DRM_CAPSET_VENUS and VIRTGPU_DRM_CAPSET_DRM. Without adding a 
>>> similar
>>> VIRTGPU_DRM_CAPSET_ROCM alias, userspace DRM clients relying on 
>>> virtgpu_drm.h
>>> for the DRM_IOCTL_VIRTGPU_GET_CAPS ioctl will lack the necessary 
>>> constant to
>>> query ROCm capabilities natively.
> 
> As for Sashiko's suggestion regarding DRM UAPI aliases, while I am 
> unsure why those aliases were introduced initially, adding one here 
> makes sense for internal consistency.

Will add one.

Regards,
Honglei>
> Regards,
> Akihiko Odaki
> 
>>>
>>>>   /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>>>>   struct virtio_gpu_get_capset_info {
>>>
>>
> 

