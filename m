Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011057.outbound.protection.outlook.com [40.93.194.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674963939DB
	for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 02:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648578; cv=fail; b=k8t1J1D8F6VYZ37i2xZD0crOl5oqDVyuJnzzYkVyVI4bwI29xQNNfIyR+f8ryibJRr4nnFIB4Z2IHBOuJkIKAu0uKNeE5HmGjrf90HQE1c0uuhrA+AxDVlUm7uDzaZTtXyx9bNcX3PJ+wthVQzbjqjpz2AjmgjpMt+L2Ig4YBqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648578; c=relaxed/simple;
	bh=qrJ/CBoaaWS/fu5cOjblKi+fEo1MjZBXJurBGeVJBqY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tyhu/Bnxaau6uvkWQ0uJL85VWPkkdYFbqD1YWbvo1VSWr0UaAuED9t29SU6+H/bYdXpLDmKXcm5Y0eHB5SQchbtieQqdSYSPC591ZhXkpviAWeYg/Wqju1WCNjv0OMNWBMfaTVe2lzx6OnJmmG2+mZh2fnZG47PBsxgaIS4ZQFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HGYpu6Ns; arc=fail smtp.client-ip=40.93.194.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HGYpu6Ns"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVmO+UOjzlnjRRa1iE73WlgAjZGpci1lmEQF1MFAbcpXwDggZ20BUDLycltKvtf6o4abpMQTpdZP1/CZbERXsjb6uycvpUQNsm1sxzJDCQJCWOlx+3x1ufDiI0dmi5UOay/1/MTcW7091DVgSqGKkjyi/QgZGUwJBL2ueGttx6j/wiSQyib74Z/x1fx+obsRHMA6+crgvigOE0aroIfw1BVOOG8RxjwZNECASDlEfehTaJQkxD8ZbaT5D6E5rq0qeHVe6toDDK9H0PiW85CN4LMtJ4FcUtGE5K6Xbd1uxGV22BF+L4Wdeqm0hcXIad/AYvcCQu4+ml3qnwDi7S+7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ngi65xzURwX2GKt3gysuD3mFb+MmKsVvS4gibV8pwk=;
 b=d7WfGbWL0TBkm3gqNCi5AdjKiuX2LtzY48sHj0nb6Cy93/NB1R69ep9ZSlx3uXubxCHkjO4nvYixSf3cHKPvQGfk0NnkntZjvwtUlcP9AGQjF+Sdd2ZQhi8C4rq0oQyNkfhDSNHCNfJuR4b8cFldl0D1zetjQ5cxVidKzSdsj0eSIWHZRs2Z0M+kQiI8Wq7V70xnIxz9voNAJWYCICy1eupMctklpGQnyKteyXOS5MXeRPNXtRsjr7VcRX2byyqphHintxDNoOW4R6cp/VlEeja3TKvF1YCgfvIjxuAtHcwLHhbBWQO5MpIEs7VsOkUSj/XRcdxTUYK/Xb6ACninKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ngi65xzURwX2GKt3gysuD3mFb+MmKsVvS4gibV8pwk=;
 b=HGYpu6NsM+sJwDb81/GnzcXX/Q4glm8e6mjIzFS+sro6C3ddxO9JpG9tMjzKekChZAZ1C21Gh0R7Fw8fkIc/Uyj55WK+CRJXt5e3oD6Tt6OlYxRxL1AbzolmQ5ISzeSdvj6w1x4cLbczMoFQtnho9rvcV50H2U5Sq6TXW6EpAA0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 02:22:52 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 02:22:51 +0000
Message-ID: <ae305517-e678-4ac3-93d3-f250bd37b2be@amd.com>
Date: Tue, 29 Sep 2026 10:22:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] drm/virtio: implement userptr resource support
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 dmitry.osipenko@collabora.com, airlied@redhat.com, kraxel@redhat.com
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Ray.Huang@amd.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-4-honghuan@amd.com>
 <fd17a38e-a827-41a5-a46e-db2135bb9257@rsg.ci.i.u-tokyo.ac.jp>
 <37c0ef9c-7249-4785-a3fd-646d816e2d4c@amd.com>
 <47d7114c-f035-4628-a911-c7ab30d55a75@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <47d7114c-f035-4628-a911-c7ab30d55a75@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0078.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c6::15) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: fc8ef4f1-fd97-4e78-53b7-08df1dd08f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|10067099003|5023799004|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QsSHVOx/SbBZaD25aufxDm5i5MD2vfivDbAjoV6ZuMykAEnkGe/xkoFHPN1LLTneD4ktTIl4HsbdH3GApIVZtfS0gwtLvtHsxwFA++nnolEgEWklutrUr5MB5o16iD19mP5St2AP8XftCnGlQoaHA/fXF/cQVQlR3SwqvCwnsOsEdYH4pQvv/+BF2emdCCdWWebDoQXse5CvtYGQ6U5P26yyXbsfgfl6oCVE2WMJuQzao/wsuJUr6Ibgf2MD7vRrRLuOBaKHrUuQK2EcJyVCo7Ksg1I7zHh+71A4bm7/YjojSi3jMaWeqleE7nBOlnL+mJFBzfNuDM3LNpj2xyRVfgL524RSKMteqUigXzvvQO0gGZqnba5tCJmcD+UmWqEB5bEnYrubMM65wQU0OIionCoh4B9+6cs154ppvlAABKEpir/XakrguEn1u4bThjdFTuJEX9rovjh4HTxD0p4EWx2oRtEsd54mZbx3gMeodtDJpSr+DUDAQ7PR6rnbQnYUmnsL35IuWjWNlm6xPAvJqUk6CHam+fO9ML9it95NLW2aQ4RGQvgd5hXGxpiAWPTyRZICDliU6E+3GHohpB59LVfbgKFeajZ5i5gOxalzJXrTrbQ4olIP6i1iICD/rY1Gr09Cif+hQHJwJRbCUjTTUSZVh4IfQOK09bYgBMtJSZY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10067099003)(5023799004)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXJTdytkV2dtQnNoUWh2cHBIVnp2UVZnYk9ITjJUZlBWNzZaWFVYQmhJUWt4?=
 =?utf-8?B?aVdsRXJTdStraHQxVDY5ZGJlbThRcC8ydG53QUk0cUdMUGlXSllJb29GM1NE?=
 =?utf-8?B?M0lab1grTUZNN3pHdDRhYnRubWtOdjlsditXTmt6eEJXaW54SGxjNlo5UktG?=
 =?utf-8?B?aGx6MGZLbWJ3TjZFSXdkbVF0bGh2WkMzUDIyMkNZb2NLMDJ6YUVVNDFhejFT?=
 =?utf-8?B?TE52SVJJSENpYmpnYks4Ry9oUmRaempveWV0M29xTlFYY2QzazZHbUZIMkVE?=
 =?utf-8?B?eEl1cUdrOHJPdXVyc3BsRThmejkxN0tFWVhsVUNWOS9GaWU3SWpSSnFWTmdC?=
 =?utf-8?B?Z3d1SDJOS2xCOGVSWlBEMTNrZEVIZFROUUo5U1BpN0h6Vjl0aXZrZzFUaTJC?=
 =?utf-8?B?S0xrUE9kbklNVFAwVjc3VmZzbVBDUHYvZnhUZXBZaFhyV0h6aHRBWGZ3TmtO?=
 =?utf-8?B?MHJWT1ZZV2p5UlJlLzVuTHB5MGFpRlU0aklvUGQ0S1BOdm1xMFJacC9JSXdM?=
 =?utf-8?B?Mk1RUHlPOGZ5Y1lkd1Raa2g1WGhaMUEyd2xCSld1WEVHZXY4MDNwb0MwS2ti?=
 =?utf-8?B?TnBiRjJDMFp0RHdwcE1CTHVRakdBU05kSS9DeUJ0bUNHRS9LTVhxRnVKR0ly?=
 =?utf-8?B?KzRxMHFOT0tZZUZ3akJKcHFYSS9FaGI0MFNSeDg1bUljWFBVbERBREExYzVa?=
 =?utf-8?B?S1lXOFVJL3grMHhpZGJUa05pQkx5WnB1bXg4WlZ0ZjgycnAzZDZUU0l2SDdt?=
 =?utf-8?B?bnZncVpsRTVpUXZBbjBmSGdtM2oxU3JWTWRyZVd5aDVrR3RJcTNFRU5zUzI2?=
 =?utf-8?B?WUQzeWovSGpqVXdseGNLWEJSU1ZaRkV5Myt1UGRFZUV2NVQ5L0dpQnBsREhC?=
 =?utf-8?B?TVlKaTA2VCtwcitZOXJESGZXT1o4c09XWC9LSVVJQUF4SEdmbURzakN2UVdF?=
 =?utf-8?B?UUE3Z3NsWEFMUGE1RlgyNWU3N3VqS3VGazlpcDViQjM4QjI0N1BiaXo3UmVa?=
 =?utf-8?B?SXhTblg2Y1dZZGhXMURzTWl6R1l2TzhvQUJLVEtVdTZRQU1wVVZlYmRxYkJE?=
 =?utf-8?B?QW5MeUk1SUVKRWtCdDBNalNySHRES3loWm1OQ0RNT1dzM3djWDNMOVNQNksz?=
 =?utf-8?B?QmtWamdXTEZtUFJOUnhZdmRNM25SbW1zbHduRm1HY2VJZ3QxMHloSGdVNFhH?=
 =?utf-8?B?TmZOZ05QUy95dmRGcWtENlo5a0FCbG9lOTdKQjV0elg5ZmwvRjRJcGYvM2tS?=
 =?utf-8?B?TGRtZEl1ZDhBODVtazMxM1pDbjMxMjhNVEVpcVpNMEttbzdqMml0SUZ6UXZn?=
 =?utf-8?B?ZU9aMjkyRHNOTkR3My84U0ZmOUovUE9IbTNjU0dWVlNpcVROWGNKdHZmWFhB?=
 =?utf-8?B?bXpRbXRIMUVYMHM3TkdDTHN1NkU4OVlmZ2EwSElYdlpMd3IrT3VnT1lPeGxk?=
 =?utf-8?B?NjlscUQyWncrMHR2RjhONllRek1VVFM0MVVqU2daMmZzZVh2S3J4UEk1V2Rw?=
 =?utf-8?B?dU9NVENNenNwMDZERXhnNkFjanlZU3pKVVpXTU03ZGRUUktlc1lCU0dadUht?=
 =?utf-8?B?QXZWdTV6Sm9ZSzFWQW51cGZyN1FmTUdQWDEyS3BucjN0SXZ2SzVIL1VIYzNi?=
 =?utf-8?B?Q3ppMFNPN0tTbllXdjRWeHV0a1d1WXJnQnRRNjJYMjZvcG14MVBvbFVUQ1lv?=
 =?utf-8?B?TjVMcE92Rkp6UzBRNXN6SG91MFlQT3hKTkNqTHdweW5vdTVVeWorUWZtVi9v?=
 =?utf-8?B?NGhDeVIzc056Rjh5L2pNZy9zMXV1Nk5tNERJWE1HOU1teXJtYVBocUxyZ1VV?=
 =?utf-8?B?KzRzWU9EQTJNTmR6ZmVWc01qbkN1Ty9Xd3kxdkxMV0Z6eDZhWDdnK2htaUJV?=
 =?utf-8?B?bDhJSjhOK2tidWVrR0RRVXpBdW9kVTAwSHM0OWszQUEyZzU3OVRhOXFMUW43?=
 =?utf-8?B?R3lSa0dScE1KRm9UOVg1L29kOTRnSG1WYWFsQmo5d2s5TFk2ZzU0WUN2a3po?=
 =?utf-8?B?WTBwV3pEVUtvY3JxUWg1TlE1Rjd2S0xDWDhsVUkvaUFiK3JPdkpLd0ZReTRw?=
 =?utf-8?B?MytmV1ZMU1B0aGxXMDdKbkZTMTFmU3AralIrYnVGM3drODhQQWJ6MlA3WlBa?=
 =?utf-8?B?TGMyOEgwNlFUUENFby9XWFE3cDhLT29aMFhlYU84YlB2Sm55aFpYR2ltNTVk?=
 =?utf-8?B?WHdzbmZFQ2dRYWxTL2Z3RXlJVTM1dU1vakdGL09KTWZLbHpSYVBwVjgzYmNn?=
 =?utf-8?B?aktnK1gveFFYaGM3Q2dSb1NxTzlKR1plUFpBVExVL2dSZVM5aDdSank1M0xQ?=
 =?utf-8?Q?G+VV3bGE2Ky1z67xzP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8ef4f1-fd97-4e78-53b7-08df1dd08f99
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 02:22:51.3190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SE5SD5dFvQvuRo6IEW1kLDtbzKaZwM5LirXqe7GxNRfi/cNWAECwpXMF0ZjUnGZTVQ6CtGj2iEWU35kCHlFarg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655



On 9/29/2026 1:25 AM, Akihiko Odaki wrote:
> On 2026/09/29 1:22, Huang, Honglei wrote:
>>
>>
>> On 9/26/2026 7:33 PM, Akihiko Odaki wrote:
>>> On 2026/09/24 18:55, Honglei Huang wrote:
>>>> Add userptr blob objects so the guest kernel can pin an existing
>>>> userspace mapping and advertise it as CREATE_BLOB backing entries.
>>>>
>>>> - New virtio_gpu_object_userptr type for userptr resources
>>>> - Pin pages with pin_user_pages_fast() and FOLL_LONGTERM
>>>> - Omit FOLL_WRITE when VIRTGPU_BLOB_FLAG_USE_READONLY is set
>>>> - Charge FOLL_LONGTERM pins against RLIMIT_MEMLOCK
>>>> - DMA-map the scatterlist only when virtio_gpu_use_dma_api() is
>>>>    required; use DMA_TO_DEVICE for USE_READONLY blobs
>>>> - Mark writable pages dirty when unpinning
>>>> - Keep pages pinned until RESOURCE_UNREF is queued; drop them from
>>>>    cleanup_object() on the unref response or on create failure
>>>> - Clear userptr->pages on pin failure to avoid double-free on cleanup
>>>> - Reject unaligned or overflowing userptr ranges at create time
>>>> - Disallow PRIME export of userptr objects
>>>> - Save CREATE_BLOB params and restore userptr resources after
>>>>    hibernation without using the shmem restore path
>>>>
>>>> The hibernation restore path maps with the same attrs and direction
>>>> used at create time, as documented next to the call. Like shmem
>>>> blobs, the DMA API can still bounce through a buffer there. This
>>>> design only avoids a second guest side shmem allocation and memcpy,
>>>> nothing more.
>>>
>>> I don't see the restore path is documented though this says 
>>> "documented next to the call".
>>
>> Will fix in next version
>>
>>>
>>>>
>> ...
>>>> +        goto err_cleanup;
>>>> +    }
>>>> +
>>>> +    userptr->sgt = sgt;
>>>> +
>>>> +    if (virtio_gpu_use_dma_api(vgdev->vdev)) {
>>>> +        enum dma_data_direction dir =
>>>> +            (userptr->flags & VIRTGPU_BLOB_FLAG_USE_READONLY) ?
>>>> +            DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
>>>> +
>>>> +        ret = dma_map_sgtable(drm_dev_dma_dev(vgdev->ddev), sgt,
>>>> +                      dir, 0);
>>>
>>> I checked the ROCm code and documentation, and I do not see how this 
>>> mapping satisfies the HIP coherence contract when bounce buffers or 
>>> explicit DMA cache maintenance are required.
>>>
>>> HIP distinguishes two coherence models:
>>>
>>>  > Coarse-grained coherence: The memory is considered up-to-date only
>>>  > after synchronization performed using hipDeviceSynchronize(),
>>>  > hipStreamSynchronize(), or any blocking operation that acts on the
>>>  > null stream such as hipMemcpy(). To avoid the cache from being
>>>  > accessed by a part of the system while simultaneously being 
>>> written by
>>>  > another, the memory is made visible only after the caches have been
>>>  > flushed.
>>>  >
>>>  > Fine-grained coherence: The memory is coherent even while being
>>>  > modified by a part of the system. Fine-grained coherence ensures that
>>>  > up-to-date data is visible to others regardless of kernel boundaries.
>>>  > This can be useful if both host and device operate on the same data.
>>>
>>> https://rocm.docs.amd.com/projects/HIP/en/docs-10.0.0/how-to/ 
>>> hip_runtime_api/memory_management/coherence_control.html
>>>
>>> Fine-grained access requires coherence throughout execution; copying
>>> between the original pages and a bounce buffer only at kernel boundaries
>>> would not suffice. Coarse-grained access could support such copies, but
>>> they must occur at the required synchronization points. I found no code
>>> that synchronizes this DMA mapping at those points.
>>>
>>
>> Whether dma_map_sgtable() bounces is decided by the platform's IOMMU/ 
>> SWIOTLB behind the device, not by we request. attrs=0 here just 
>> matches the existing shmem blob path, and is exactly what native (non- 
>> virtualized) ROCm's own userptr support does too:
>>
>> // drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c, 
>> kfd_mem_dmamap_userptr()
>> ret = dma_map_sgtable(adev->dev, ttm->sg, direction, 0);
>>
>> And HIP's coarse-grained/fine-grained coherence isn't a DMA layer 
>> property, it is a GPU VM/cache thing. In upstream KFD it's implemented 
>> as GPU MMU page table attributes (MTYPE_CC/MTYPE_RW, the SNOOPED bit), 
>> set by whichever driver programs the real GPU's page tables for this 
>> memory:
>>
>> // drivers/gpu/drm/amd/amdkfd/kfd_svm.c, svm_range_get_pte_flags()
>> mapping_flags |= coherent ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
>> pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
>>
>> I really want to disable the bounce buffers in DMA, but it is a 
>> platform behaviour, can not disable it in this layer. And in XEN, the 
>> dmapping for it is another form of iovector/simple sgtable. And if use 
>> the virtio-iommu or somthing else, the efficiency and the complexity 
>> of driver integration are both lower than using iovector/sgtable 
>> directly.
>> And for how to handle the DMA thing for userptr, since we have so many 
>> concern about it, maybe we can drop this part in next version. But we 
>> may have the AI review warn/error.
> 
> Documentation/core-api/dma-attributes.rst says:
> 
>  > DMA_ATTR_REQUIRE_COHERENT
>  > -------------------------
>  >
>  > DMA mapping requests with the DMA_ATTR_REQUIRE_COHERENT fail on any
>  > system where SWIOTLB or cache management is required. This should only
>  > be used to support uAPI designs that require continuous HW DMA
>  > coherence with userspace processes, for example RDMA and DRM. At a
>  > minimum the memory being mapped must be userspace memory from
>  > pin_user_pages() or similar.
>  >
>  > Drivers should consider using dma_mmap_pages() instead of this
>  > interface when building their uAPIs, when possible.
>  >
>  > It must never be used in an in-kernel driver that only works with
>  > kernel memory.
> 
> This is exactly our use case. Although the platform decides whether a
> mapping requires bouncing or cache maintenance, 
> DMA_ATTR_REQUIRE_COHERENT lets the driver reject mappings that cannot 
> meet this requirement.
> 
> The shmem path serves a different use case, but amdkfd is a relevant 
> comparison. HIP's coherence guarantees depend on both the GPU VM/cache 
> configuration and the DMA mapping established by the kernel driver. GPU 
> page table attributes alone cannot make a bounce buffer coherent with 
> the original userspace pages.
> 
> The amdkfd mapping you cited therefore warrants discussion with its
> developers as well. I have CCed the maintainer.


Will add DMA_ATTR_REQUIRE_COHERENT in virtio GPU userptr in next version.
And are there some places else need to be modified?


Regards,
Honglei

> 
> Regards,
> Akihiko Odaki
> 
>>
>> Regards,
>> Honglei
>>
>>> Regards,
>>> Akihiko Odaki
>>>
>>>> +        if (ret)
>>>> +            goto err_cleanup;
>>>> +
>>>> +        userptr->dma_dir = dir;
>>>> +        userptr->dma_mapped = true;
>>>> +    }
>>>> +
>>>> +    ret = virtio_gpu_userptr_get_entries(vgdev, userptr, &ents, 
>>>> &nents);
>>>> +    if (ret)
>>>> +        goto err_cleanup;
>>>> +
>>>> +    virtio_gpu_cmd_resource_create_blob(vgdev, &userptr->base, 
>>>> params, ents,
>>>> +                        nents);
>>>> +
>>>> +    userptr->base.params = *params;
>>>> +    virtio_gpu_add_object_to_restore_list(vgdev, &userptr->base);
>>>> +
>>>> +    *bo_ptr = &userptr->base;
>>>> +    return 0;
>>>> +
>>>> +err_cleanup:
>>>> +    virtio_gpu_cleanup_object(&userptr->base);
>>>> +    return ret;
>>>> +}
>>>
>>
> 

