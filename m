Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995DE418A46
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 05:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791869569; cv=fail; b=KgChefcMTUIwy7Y4UYbZLhhVBiPObuy3weW4uboaXnNpAAAc7D0lOwseFmOm7g6JUS7YexPsMqrsn8cNyvbQj2u/9qToAM+N+IpjdfuBuC3eVVEaemv5dattwaXmFY+Z+skNYAblPbtC8Ho7rVzDf0tZD6P8lec3xTBM3eLthVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791869569; c=relaxed/simple;
	bh=QvdmH+1E/3Y/P59DuYGAWRG/HcJfs6UbnwqKOo2wKs0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WHpE6wRV2s2XXn0LNMLbUDHjTN8HCsV/hGdDBS5tuO8zCd61eFUAIsK6hjFFGVKWGUReXnPwtyCNJZA1/AyYwOTMEMZ8x7MlmSwrRs5PYRP5PUZuMWkvb85zFFabyc8OwJps3ohC0/Aw2QuCHFL8nWPd3x0ZUr8rvMqHN2JAlx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=blbTBsZI; arc=fail smtp.client-ip=40.107.209.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="blbTBsZI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVFfqu+H+4C0gXGeFRr1LLV70Xvk5zS7yKRWV9/9JWtQStU20dYmzxDgMGNoo1fLpHFzpOYG17V+Drv5mzg1AWMAcUBYhTPn1NJATUtZyVPTqjUvW5VF0CZz3AOjjThsI/eMFOj5aDT5xre/HPWR4UnpCaH3szzdOCISv3VuslA9i2qrzydw5nbstv0JuId4+NJ0D1cx1+2iFekioXKdaBvMc9nzc9GQMKzzwgnT2hkRq9C/zOl7kU0cmiCkZzTxuIZo/JkmEP5u2y6qQEV529jxrX7OZBDkfYTjLZVDAXmmjr/fZ2YRKJSpmjSr8qx1IBs+X1322k0x77lyT8bOuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8VQXQmUVa0Z1a9lKoKA8Za5Ck+uwHEa63Py6ca9DmQ=;
 b=Olf+X4z/Y8aWcEyaTmWsOFx8/icLo7irIvGKiTbC/EIiDkmx1zbKg0fqXafUOffExcFGpUaYyvyRxCvdjmYxLppZh9K8lUe0toXkrrLU2xGQVhnNMYoFAhr6BcdEwO4irkEVKcyV92Rog2YYlzcxJHHUeDqcGX5byaQLwgp9PGpYpVE3YHX8H/7sGWN8URMXMpMmmeai5tmvqj6sTXIfmBrCpqajwQenL6wMwMLsZ9vyv6Sq5oqJB8aumXKvZoDoNEOiJ9giOl1VsEU2aa8Hv1NHQobDm/bpPeSatCoPso+vUDbrJpP5RNROLCxEo9BFhaBtjXTLyYIIxXp+n8kGKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8VQXQmUVa0Z1a9lKoKA8Za5Ck+uwHEa63Py6ca9DmQ=;
 b=blbTBsZIpwEVzpk58DzjvuPFZdd8XWj45dyOg72wlntVfgx2cCZyS84BPJKUbVI6bCIYxZWmvU6zbWjG+ATwFEu6Jw/TY9VUQwsX+CPLloZ29hJfn02T68vZ66lM8YhY/yEt5xuck2K64N087XWl992WDdaGuWSSIYl8fAUoi+U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by SA1PR12MB6752.namprd12.prod.outlook.com (2603:10b6:806:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Tue, 13 Oct
 2026 05:32:43 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 05:32:42 +0000
Message-ID: <317cc6e9-8e15-462d-9e9c-2657011b7128@amd.com>
Date: Tue, 13 Oct 2026 13:32:28 +0800
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
 <7c32c182-5b49-4dc0-9c97-a4238743f28c@amd.com>
 <efd5fa89-e888-469a-ac80-e6e605f9a015@collabora.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <efd5fa89-e888-469a-ac80-e6e605f9a015@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0045.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::6)
 To CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|SA1PR12MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df93b3f-edd5-4843-570a-08df28eb6734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003|261009221227099003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	Xl7cSjGxoJX5ndXiCQNL12bLFgbciipzG8YEHBfL4LO9edq3Dj517wVFqxqXNi8r54dPH8F+BeR9GIdd+7kq75Vz15sKk1oUVDGHdZ1vlXlSqqgECjWllFoNEUuLFW0ZZUiFL7RW7KLil2CsWhUat/d+ozf5SBeKX63fey3cx6AIOZxRNAo8PwrqRSsQul5H45LVEYHYWfrLlCxpOAyDHdrNQ7ron141OPpGVGMbYZf0RqgeIgDZ50cU95ViZBdT15rfWVcf1Sh3cCaqgOSX62CGM7P76mAgJJyR8qnV5NunzEe1x0fC51I7gTZ9bn2D1/b+OzFU1m/WQvaYMneqRoBa1wRq0r8I1xINKbSFR0XWi+A1nmU7Tal40xWzgZOTEhXLFd7GlirLt5MGSCT85c8FZDVmALL7bKIx7u3X6GBjcbbOQiykku+CXsmNJFAZM5PCbSDHW//dOa5WyQ5WLpPhz6YdndXsSnI7lDqsxXsZ4yz12c/jULUl5BgFXVVLmPS4FiATX8qw7bTZ7x0A7z1NxX4eKf5i2yN5dpLGCp1iS/qJO4zd0dQwLCuPrfKy3PnfuBkj/GEGDOnZGGQLhquxydjTgU95UXatM+ZycT96PEzx6aeNhUegxxl/KD5c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(261009221227099003)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clZ4Qi9LOVBxVFQxT2I0NlRUZWk1ZEJjaG9rQnR1ekwrR1Q0b21EV0hUd0xC?=
 =?utf-8?B?WGtnZUF2ODlzZHliUytHRlVtTEhMRHE0UnE5bURmN1picmpMTUpkV0tVM01C?=
 =?utf-8?B?WmgvODNtdkhjaTJaVWdxcEk5dlV2cDdsYzlMbzNseno2QnFOcUl5MW9SUGtS?=
 =?utf-8?B?REdHVGdpd3FYc1JXT25vZ2hJZkYrelpFNkUvNHpkeTZESWJHaGpLS2dyUVNs?=
 =?utf-8?B?N0s3Y0tKa3RzYkkxRXlDdGxPSnc1Qk9CalVETHZqWExaTDFHc3c5alVjdUxL?=
 =?utf-8?B?QUZRZmdoWklXRlAwNi9sTGsrTGpTRzdVTmdYQnM3RXF5djVsNmNaaEg1MVk0?=
 =?utf-8?B?bzJtV3NhNDZLUE5ZOVNZM050OHR5YSsvV05FblVnTVBmK3JtdTVFZ0w1ZXA3?=
 =?utf-8?B?dUlFalovY2VXSll2b2R2RTd2cW5uNGlkbkdoT0luMXRCS1hCczRNTXhSdHY2?=
 =?utf-8?B?U21IYVJxNXBFdXRYVnJuY1BGQnNqVVBZSW1mTVZUVG1RZ2h4MDJLaG9FZDVQ?=
 =?utf-8?B?RVdKZFZpcXhlRVhLWlBHb0JJRTROMXJROGFsUHI0YlIwaXhUQXBDU3psWUo3?=
 =?utf-8?B?bXNYdDVxVVU3YURXSExIZ3U3Z0pxSGNSZjBST05Hd2NMU2p6cjlKZkVHbFU5?=
 =?utf-8?B?a1pvc3htbFFhQU9nWG5CeExHMGJpWXpXY3JQei95VXluQkFjZ0REUUxoaGNq?=
 =?utf-8?B?cDYzNkVPTjlwWThFakMrc2JlNGVzWDNudjJXN2poMHppNktqSDZNQ0FpeFd0?=
 =?utf-8?B?akE2VlI2WUNieG9MZ1FpT0tZRll0VW1vRkM5czV3OHpzY3NuSVhib1UyeU9q?=
 =?utf-8?B?QWZEb2I1ZzZPNkN3dmhsTUtRMlZzSjhJQkZWaE5SaC9GRXZmQ3VUOCtBM21Q?=
 =?utf-8?B?aG5Hc0ppV0VHMmhHdlQ5elJjQ2c5TU5zZG12L2hweDE0bVlXWE9KdktvQkNl?=
 =?utf-8?B?QU1iL2lYLzU1Q0RUMmZnY29RWUpkUUpPMnJzUnRZNTNFdHFmWi9WdDQvYVdE?=
 =?utf-8?B?YmwvSVh1a041Q0I4eWhaMEpZMzFFTEVnNzBZbVplNnRlL25kM3I3eUpIQmlt?=
 =?utf-8?B?SXgxT3hJSGlObjg1ZW5QRVNoSmZmb2R2U3lhVXpkWUw1N0N6c0t0R1JZeFpZ?=
 =?utf-8?B?ait4S1IwMUsvdEpKZDBGSWc2UUVxK2traUowTVk5M0VUV2tZTVZIdnVNTUpv?=
 =?utf-8?B?OWY5bjVEN1dLMTNRZzhWQ0QrU1ZXMGtPcTlBd2NlTld0NGtSR2NLUEZvY3Vr?=
 =?utf-8?B?QTRZV1RJYzMyVHVYNC8xemxqQXJpTzlCZ28zTFQ1TGNuZHFDQ2liUHhPVS9v?=
 =?utf-8?B?TG9Ub0IxMVpxdllHQituTVdhUmdkNlFsL0U3YTNWT2VYU3U3am5DTTlJU0Fz?=
 =?utf-8?B?ZEVXN0JzNWg0K2lvNVFwdzMvWXhyMHpUQ0ZjZ0x2M01yTjNCeEQzUmd2NS91?=
 =?utf-8?B?c21WOWNuZGNRNGE4V3R0OFlaeGFGTVNtc0FFc1RIR3dObzBXcXNmamtYOC9W?=
 =?utf-8?B?WnZvRDNqRFZVS2plTDRDQUNrM0tKR0hsRXVxMVdjZHlMZFJnWlBJTzBTTGNx?=
 =?utf-8?B?YmgrQ2t1dXdyZVFmUVpNa1hkWUJEd1VVUHNTc1dkS2hQenZ2SStxRXhNS2RG?=
 =?utf-8?B?V2U3SjJZRzcwRUdSQzRHandyWjhZbUxvQVNzTUdyOUxNM2JzRWh0dmRBYkM0?=
 =?utf-8?B?dFUvRjgwKytPNHJrelRCYXAxVUhjWWh6OC9uZDNMT2F1VERTdlJyQXJLejlF?=
 =?utf-8?B?NjlwVTVmQmpvR1pXNHpXM3ZwM2pDOEM1ZXQyOWxCeFB2a0lHd3IyRzVWdnVi?=
 =?utf-8?B?bU80WkZka1hSdWdKNUlDbS9iN0U2cEUwNFVzSldPamErd1h5aE8xOHhDa1p4?=
 =?utf-8?B?K0xNM0Z3ZGdaQzNkUHZONHZKUlY4UFFjZDByT1pDUkI2MXdmSGo4OTMxNy9o?=
 =?utf-8?B?S2MvaWFweFpsTjU4enVHN2U2UWFQNXdwZWxMV0pCTW8xdXZLS3VMQ0Y3TFJi?=
 =?utf-8?B?QnRDUVpJQklRLzhXK3ZSZ3R1S2Q1VUpUV0lwTGZHeFBRbVV6MFg3RkM5b3NU?=
 =?utf-8?B?NDNpcGF4Zzk0cnRhUEdKR2lzUHVsSDNncXZqUXdDTUh0ZlVhWm8zWHhTdytu?=
 =?utf-8?B?UDF0a2ZsL3BraXQ5bTVGWExHcmpqcnpNdjZYZU9VdndrOEI0WEtOU1VIdEww?=
 =?utf-8?B?ZHVGZGhpTHkrQ0gwUzBxcWJnckFweENpSlNoSzlqYmpBU044WjlBUjVWZ0d0?=
 =?utf-8?B?Q0I5ZGs2bUFxMEFkOUlYOUR1MVpHai9FZ2pneENNdjJYQjlzeHhtWmhrNVpn?=
 =?utf-8?Q?t0nP/t3wYNf8su9scD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df93b3f-edd5-4843-570a-08df28eb6734
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 05:32:42.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Be3QdUSb1tPsbNLiVHg+1OSbj3k2uP6Bs7yCsNx+AM/2ryymr7V57EoztoamVyZiy/0TApugxpHzQz3Z2MshiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6752



On 10/10/2026 8:50 PM, Dmitry Osipenko wrote:
> On 10/10/26 10:37, Huang, Honglei wrote:
>>
>>
>> On 10/10/2026 2:53 AM, Dmitry Osipenko wrote:
>>> 24.09.2026 12:55, Honglei Huang пишет:
>>>> +int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
>>>> +                  struct drm_file *file,
>>>> +                  struct virtio_gpu_object_params *params,
>>>> +                  struct virtio_gpu_object **bo_ptr)
>>>> +{
>>>> +    struct virtio_gpu_object_userptr *userptr;
>>>> +    struct virtio_gpu_mem_entry *ents = NULL;
>>>> +    struct sg_table *sgt;
>>>> +    struct mm_struct *mm;
>>>> +    unsigned long lock_limit;
>>>> +    unsigned long start;
>>>> +    unsigned long end;
>>>> +    s64 new_pinned;
>>>> +    unsigned int nents;
>>>> +    int ret;
>>>> +
>>>> +    *bo_ptr = NULL;
>>>> +
>>>> +    if (!params->size || !IS_ALIGNED(params->size, PAGE_SIZE) ||
>>>> +        params->userptr != (unsigned long)params->userptr)
>>>> +        return -EINVAL;
>>>> +
>>>> +    start = params->userptr;
>>>> +    if (!IS_ALIGNED(start, PAGE_SIZE) ||
>>>> +        check_add_overflow(start, (unsigned long)params->size, &end))
>>>> +        return -EINVAL;
>>>
>>> There is new vgdev->blob_alignment defining host page size as it may
>>> differ from guest's page. Will be good to validate both.
>>>
>>
>> Will add blob_alignment check in next version, thanks for the review.
> Missed that verify_blob() already should be validating the userptr
> blob_alignment. The patches look good.
> 
> BTW, previously the extra AMD KFD patches were needed on host kernel,
> did they land upstream?

According to KFD maintainer, they want to us to add those virtio 
specific feature into drm svm, a new SVM frame work based on drm svm 
helpers. We are working on it:
https://lore.kernel.org/amd-gfx/20260804094246.1719318-1-ray.huang@amd.com/

And the amdgpu VM maintainer has agreed that he will help to consider 
how to intergate the virtio requirements into the design of amdgpu drmsvm.

And for now we can use a user space method to replace the AMD KFD 
patches function, it is mremap, it also works, we tested it, but
it has some performance loss, I will update the whole thing when all the 
components code are ready.

Regards,
Honglei


> 

