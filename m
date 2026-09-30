Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011043.outbound.protection.outlook.com [40.93.194.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9FD4F68B4
	for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775174; cv=fail; b=bUGn9fTibx3jc+0+1eiUoWLFn6JxRr+aQhL0myaFKY9WXzesG2PDPmOX0/cnBMYdDepy2a2llBRDchpXHCTKJgtHvwlv1SHssbTk11zPcWheMOMXAiKWDu+rkfsBIVcA3s7X02cDvK1rtaI0JchXmRQC6mJ2F3ftbVEKS8qLQXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775174; c=relaxed/simple;
	bh=fWzExBkdgG+FNtvCA8tV5CsCVcTrFo/yI30QWFTGFmw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dfqPldZE+rt13mXnIQ8NWgbgYfw/1PWzpiLbM/rhfUjcJpHUc/jUYT0k127ybll9GZlHa4wqSgXUYvM6+yeOOlyHIQQ/6RDMZOFuDdqM34eMfTVWbQKLk9xbq1T0TmLcn6TPKo/C8TQ3sDta4+xUv++UtbWVP05Ut4BsqPssPnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F5x9r7De; arc=fail smtp.client-ip=40.93.194.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F5x9r7De"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMZwDHcMbm+6k42CXQnqYHvtcW3QkAuxqUz0si6+tZErExFZzHMF/O8h0X+y9AB8u843UR1DpB/OZFj7EkPq4Lg5X1cEpf4eYcXHO4jVLYs55/aNLajf6l+zwKO+RYvSBCRY+8DoYKeSMWOfflHtdNJEAR+R6cBqkzrsmDU8md1lWXzT/5fvqKHJuwmweDrmLncuzUdvq35W38nmB+p0vk0F7Rcct7Nit8o5ZjaRYWNc4Ne/O2G6KwdnpBhDR1evviFEeBj5QhpCkd2QIlwUoOFzN5nRXlaCkpfpWkEb9csELGOducWRRAEmRiEAss86Nia7Nq3sNFmTfgBgKg8B5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bahXitpYeZsoLVRTHrIYq5OVV33hG/C3aPsiq40FvU=;
 b=uJOJP/ru1BPuFPfy0U+L4AJeYJbQrT2Fch/KokZBtgcdpKSJ6XXn9mTPy45kyUhQ7QAOtX6SBiXmWFOa8+IBfl4DiHZtH3SLxzooagZeYYVdp63KUjY0C1nQA01PRcK1y5FxX6yPlx4ac7KxmQScN3NvVVnr9No+QkxN6Xi/kAUni6C90zwaRscd49KomNRiovCQhaBLqrvGMJWsW4QNuYzdgP7C5wqIpX1VrNgdUn0IYAkJchCbXjKbPj8rnWLREMN4/zmrNsQ3LjfON/vYQaCf7BWJ3/tl7QypsGd9OnT7mZkta6+1h38a4Ru1fKYb9QCyl8wccaEmp9PJy9NDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bahXitpYeZsoLVRTHrIYq5OVV33hG/C3aPsiq40FvU=;
 b=F5x9r7Dee3Drec9UiUarygpQmQK1HtHHBJ8WPCqabmTXqNBjvinXO4U6X1XhWwOhUYFf8uGvTokJBO1NlHwC8oADvdjQa4IRdYN9eDpca8wEb7LcU5yNRJcJCmJ3nyP8NBJ/lz+0aCx0Oj8Gvms8Fen3KKTuIZQij1LmGhh4AjI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 13:32:42 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 13:32:42 +0000
Message-ID: <7d317175-d1f8-428b-a5fa-51c53e2d51c8@amd.com>
Date: Wed, 30 Sep 2026 21:32:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] drm/virtio: implement userptr resource support
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Ray.Huang@amd.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org, dmitry.osipenko@collabora.com,
 airlied@redhat.com, kraxel@redhat.com
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-4-honghuan@amd.com>
 <fd17a38e-a827-41a5-a46e-db2135bb9257@rsg.ci.i.u-tokyo.ac.jp>
 <37c0ef9c-7249-4785-a3fd-646d816e2d4c@amd.com>
 <47d7114c-f035-4628-a911-c7ab30d55a75@rsg.ci.i.u-tokyo.ac.jp>
 <ae305517-e678-4ac3-93d3-f250bd37b2be@amd.com>
 <dce3d9ed-87a7-43fe-b7d8-c7281514f7d1@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <dce3d9ed-87a7-43fe-b7d8-c7281514f7d1@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0185.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c5::8) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b8e4362-440b-480c-8173-08df1ef74db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|5023799004|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	uBjffF6omrq2kkFSExdYA8skKHpvBH64QaipKiC/6HG9UxP6WAhhrTtLBNY+SJxeEtTr+mmyl29U6s/uTHYZuFiHdWo/ymlKjAcnoK0CzoaPkdQNtbYzJVCoucM3Ah6sDUSjFUa8Sqwu88GuCmlUWgcZiTmqk+Dr05+HpvAC/ZMugdT183PykfaXLUIv1AE1f6VKuyjwKX4bFb4bnqyFyH6f+ZWy/olwXHXHI2Xe9cIaWvHY5jPBBuV1zR/ZVm6HYJJ4eLO3t1P+4BqmcP6fHhCoexg0BDmlimaaqmjIUIIMDkAPaC41uLfYxHU4YSpDtkUSBKyEEwS5VZ/9CFrhDvQzgRWhJXSFPrv0PIeuFdGALC9XZjRHXaK2tMUBwJJh7FtnatVAcGTlz5Hzr42jifgOMIbSP74OxRtZrKuf+qWix5Ahh5coObYbj7/6S2jE66RnBNXx1WjgOJ3dZk/UozFJnWJZu8w5i1sksJxkYakFn6tbqxffgFQzqw7jPuyeMvYXnwnyhJVTPkJCLaGZ9aaSLMWJxewqVq2sSSyYf8cyQRABd4YQAIgk3dlL0GURklGYM/wvfroJgqWzv6HgmnL9E+KFnb2LQIiTWBT8nNiRo875dAtadca6QFjYWyQ5BU6fgAmF6N0hpskXH5tMtCp+uN1BMNwb8kmSzqyPS5o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(5023799004)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0NVOUszOVFPRHZEaFYxSG1NVFVmUStjcEVOQWZTRDJ3TXZxZWhCRmVxWVhZ?=
 =?utf-8?B?VDMzNEpaNTRUR2ViZHJBS1RRUXFRalF5R1pIMkNsUTVmMzlPeE1pZGZkK3Fa?=
 =?utf-8?B?S05IUzluRDlqUUMyRlZEK2Fyem0vdXJVaG5rRDU2anoyc3V6VmdhNXhCY0VG?=
 =?utf-8?B?TEViS3BxNTdJaHV1ZW9Ebjlkc1QzT0w0KzVwUldkS3R5ZW9FZVVpbnpUSUha?=
 =?utf-8?B?Wk0zR0ZJNkVoYTNpdkZHTHJtQXdxOUpOZ052Wm5QM3grWmtmTmxLb3RIellm?=
 =?utf-8?B?QktMMktaeU5QazNSTEVFK1M1aWVMSVp5aHdQZUtCaVI2bXpiSmhGdFFXQ1lh?=
 =?utf-8?B?R3QyU2xFMDF5NnlDKyt0NHMvRTI0ZXZydW5ycEFWUFBTcmdEM0VNOFhzZEZZ?=
 =?utf-8?B?aG9yQWFnckNvMzhNam03QlU5UWRYNUZQV1h5K29TakpyU3hnVGZHckQ1VHdT?=
 =?utf-8?B?WXBMY01GempoMlB5VHhkaThQNzI5NTJKNHY0V3hBT3FVZWkwT3dLalg5V09u?=
 =?utf-8?B?bGNqd1VSaWlIcjliU2w3VktML3YzeXlqTldtcDdQRktDU0Y5NDFmeDRQUjRr?=
 =?utf-8?B?OGpCdTlrSzMxQ1FmWndqcmVNRytKamVyc3JINWJMVGxsbjA3aHB5WUZaeStP?=
 =?utf-8?B?dWl1UjNiK2VGME9PbTFXVTNjZmEyK1JYLzBhOTVQMkgveFdOVGRFei9TNDZq?=
 =?utf-8?B?VnVGZlhaUGJQU29GOC9QdmpNL041OElSaWJOVVV4WjRoOU0reExiZFRKeFJH?=
 =?utf-8?B?VzlRbCtLeXdYczdoZGZwdG94N0JBUFFGK3h6TE1UMDIySHRRRElKeGZ1VFFP?=
 =?utf-8?B?UkIzYXRxclpDYTgvZytUSGRWTkE5WVpHTzQ3bXYxTHR5M2N6Sm1nRU5GcUFw?=
 =?utf-8?B?Skc3Rk44Y1hEMWJma1BSY3VqVUtVMTA0Q2hkZTBOVlJRM0d6d3UxZ1ducGR3?=
 =?utf-8?B?ajV2YUw0SzBOZVhCOEdlSHNBNTlRUm1FYVFXWlRVWWRJbGp6OTZwUWo1UjdX?=
 =?utf-8?B?ZDZVSVUvR3ZrbHZkZTcveVQrRnptSkd4T3drQlozeUtTVGpQMlBuNG5QdEY1?=
 =?utf-8?B?eGF6L1M2Kzl3UGxWT2swWWZwOWRna2dYWUFHY3hFeTBCbmpWZk1ENWFMRXVB?=
 =?utf-8?B?cXU2UTRjYWsxSnNSYnJxdkplOVBzSEdlNWVGdjhXdUlYNlFzMXVZN1llV3lk?=
 =?utf-8?B?S09mRk54WUxidUVoWlZhZlYxTWZTbGxiRU9vTVcvMmE0VFQzV1FvcVFvK01r?=
 =?utf-8?B?cXZ4NEl2d1QyUHNuTitqcXgyemVwSUw0UnhNcC9ScGdJN2tIZG5JVkZ4TWVt?=
 =?utf-8?B?OWRIc0w5bnpRZUZoSFRBR1paSnlsSlRHKy9Bdld5eS9CSXlrVTFpVFpSaTNY?=
 =?utf-8?B?a0VibnRZSGdoWFhiK3JrSjA2bzN3b1E4L2RUbTQ5VVN2WkxCQTJpNE9jV0Mx?=
 =?utf-8?B?NldWclJnMTMvNTFCU2NQSzA3amdxbjd0RHRlMTlCbFh6b1RYK0FqUUIvaDNq?=
 =?utf-8?B?YlczV2tBVFloMVpRdmgyN0pUY3hNSEx2bXFPQnAxampyQzZVNWhHcHZRSWI5?=
 =?utf-8?B?TjMzU2dmVi9jRU9Kb1hGOG5xSDRscmFEWG4vN2lOWHFuU04yaEw3Uyt3S3ZY?=
 =?utf-8?B?a1FCRzdQb3NjZTJEMkRuMmUxTHRpTkk4QUVFUVNjd25ZVnRKMTB6ZTR0VU5L?=
 =?utf-8?B?bEdEdHlFWGFGTmxacW56WURaOENybWNlaThUWS8rdDlwV1VsZmczTUZLb3VH?=
 =?utf-8?B?R3F0UkQwVDc4N1VtU2xsdXlNY2wwdkpKN1hKbkRzTUFrdHZ0QmVmQit3a2Fv?=
 =?utf-8?B?NWYvM1RoWDhLN3Z0R1BvN05qcHZ3ZEtDb2VoaFBMYzFHTXBoVnpYdlF6V2wy?=
 =?utf-8?B?YlRYTm9vTWUzR0pyRGY3WDlBZmNvWU5HQk05ZXJqTDhMRnc0UEpkRmRSMUhS?=
 =?utf-8?B?RllrOHQ5OEdLd1hOQm8yTUZaUUl1T0JWOHlwUWRVTXJ6WGl0NzIyNFZzbmdy?=
 =?utf-8?B?eGNrcG1IVjlDenJKZ3A3TDU2dUNsV09kamhyaGNUU29RWWhaeHNvb2lJVWg4?=
 =?utf-8?B?WXI1c0dkRHpaS0Z3OU93RzVNUmxYRUNQbUJsSXl3N2RhazNzVnY1dUIzMm1D?=
 =?utf-8?B?azArTC9jUWdvUWxVc3d4d1dqRlZFMTliVmJVNlpvT0xzeWVLK1l0R3hNOU9p?=
 =?utf-8?B?dXMvKzlyMzY2TUdpZS9kZHZQdkFVQUlMS1FzcFN0SXA0WENodWlaOS85QXlq?=
 =?utf-8?B?WEhybCtwUGU1bDZGMEZSc1kwU2lnMmhWN2ZKN0VsM281QStibHNoOG9MWW9E?=
 =?utf-8?Q?oMp5r2vCe6FuJ8JTZv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8e4362-440b-480c-8173-08df1ef74db1
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 13:32:42.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dl84go3Gr9skybLdkCz1GFKJP5S4iMCiTYkT8WThS5DQXIUnJuOhyof1034PExUcpg6tL2rBJtN5CzUWdTzWvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455



On 9/30/2026 12:56 PM, Akihiko Odaki wrote:
> On 2026/09/29 11:22, Huang, Honglei wrote:
>>
>>
>> On 9/29/2026 1:25 AM, Akihiko Odaki wrote:
>>> On 2026/09/29 1:22, Huang, Honglei wrote:
>>>>
>>>>
>>>> On 9/26/2026 7:33 PM, Akihiko Odaki wrote:
>>>>> On 2026/09/24 18:55, Honglei Huang wrote:
>>>>>> Add userptr blob objects so the guest kernel can pin an existing
>>>>>> userspace mapping and advertise it as CREATE_BLOB backing entries.
>>>>>>
>>>>>> - New virtio_gpu_object_userptr type for userptr resources
>>>>>> - Pin pages with pin_user_pages_fast() and FOLL_LONGTERM
>>>>>> - Omit FOLL_WRITE when VIRTGPU_BLOB_FLAG_USE_READONLY is set
>>>>>> - Charge FOLL_LONGTERM pins against RLIMIT_MEMLOCK
>>>>>> - DMA-map the scatterlist only when virtio_gpu_use_dma_api() is
>>>>>>    required; use DMA_TO_DEVICE for USE_READONLY blobs
>>>>>> - Mark writable pages dirty when unpinning
>>>>>> - Keep pages pinned until RESOURCE_UNREF is queued; drop them from
>>>>>>    cleanup_object() on the unref response or on create failure
>>>>>> - Clear userptr->pages on pin failure to avoid double-free on cleanup
>>>>>> - Reject unaligned or overflowing userptr ranges at create time
>>>>>> - Disallow PRIME export of userptr objects
>>>>>> - Save CREATE_BLOB params and restore userptr resources after
>>>>>>    hibernation without using the shmem restore path
>>>>>>
>>>>>> The hibernation restore path maps with the same attrs and direction
>>>>>> used at create time, as documented next to the call. Like shmem
>>>>>> blobs, the DMA API can still bounce through a buffer there. This
>>>>>> design only avoids a second guest side shmem allocation and memcpy,
>>>>>> nothing more.
>>>>>
>>>>> I don't see the restore path is documented though this says 
>>>>> "documented next to the call".
>>>>
>>>> Will fix in next version
>>>>
>>>>>
>>>>>>
>>>> ...
>>>>>> +        goto err_cleanup;
>>>>>> +    }
>>>>>> +
>>>>>> +    userptr->sgt = sgt;
>>>>>> +
>>>>>> +    if (virtio_gpu_use_dma_api(vgdev->vdev)) {
>>>>>> +        enum dma_data_direction dir =
>>>>>> +            (userptr->flags & VIRTGPU_BLOB_FLAG_USE_READONLY) ?
>>>>>> +            DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
>>>>>> +
>>>>>> +        ret = dma_map_sgtable(drm_dev_dma_dev(vgdev->ddev), sgt,
>>>>>> +                      dir, 0);
>>>>>
>>>>> I checked the ROCm code and documentation, and I do not see how 
>>>>> this mapping satisfies the HIP coherence contract when bounce 
>>>>> buffers or explicit DMA cache maintenance are required.
>>>>>
>>>>> HIP distinguishes two coherence models:
>>>>>
>>>>>  > Coarse-grained coherence: The memory is considered up-to-date only
>>>>>  > after synchronization performed using hipDeviceSynchronize(),
>>>>>  > hipStreamSynchronize(), or any blocking operation that acts on the
>>>>>  > null stream such as hipMemcpy(). To avoid the cache from being
>>>>>  > accessed by a part of the system while simultaneously being 
>>>>> written by
>>>>>  > another, the memory is made visible only after the caches have been
>>>>>  > flushed.
>>>>>  >
>>>>>  > Fine-grained coherence: The memory is coherent even while being
>>>>>  > modified by a part of the system. Fine-grained coherence ensures 
>>>>> that
>>>>>  > up-to-date data is visible to others regardless of kernel 
>>>>> boundaries.
>>>>>  > This can be useful if both host and device operate on the same 
>>>>> data.
>>>>>
>>>>> https://rocm.docs.amd.com/projects/HIP/en/docs-10.0.0/how-to/ 
>>>>> hip_runtime_api/memory_management/coherence_control.html
>>>>>
>>>>> Fine-grained access requires coherence throughout execution; copying
>>>>> between the original pages and a bounce buffer only at kernel 
>>>>> boundaries
>>>>> would not suffice. Coarse-grained access could support such copies, 
>>>>> but
>>>>> they must occur at the required synchronization points. I found no 
>>>>> code
>>>>> that synchronizes this DMA mapping at those points.
>>>>>
>>>>
>>>> Whether dma_map_sgtable() bounces is decided by the platform's 
>>>> IOMMU/ SWIOTLB behind the device, not by we request. attrs=0 here 
>>>> just matches the existing shmem blob path, and is exactly what 
>>>> native (non- virtualized) ROCm's own userptr support does too:
>>>>
>>>> // drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c, 
>>>> kfd_mem_dmamap_userptr()
>>>> ret = dma_map_sgtable(adev->dev, ttm->sg, direction, 0);
>>>>
>>>> And HIP's coarse-grained/fine-grained coherence isn't a DMA layer 
>>>> property, it is a GPU VM/cache thing. In upstream KFD it's 
>>>> implemented as GPU MMU page table attributes (MTYPE_CC/MTYPE_RW, the 
>>>> SNOOPED bit), set by whichever driver programs the real GPU's page 
>>>> tables for this memory:
>>>>
>>>> // drivers/gpu/drm/amd/amdkfd/kfd_svm.c, svm_range_get_pte_flags()
>>>> mapping_flags |= coherent ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
>>>> pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
>>>>
>>>> I really want to disable the bounce buffers in DMA, but it is a 
>>>> platform behaviour, can not disable it in this layer. And in XEN, 
>>>> the dmapping for it is another form of iovector/simple sgtable. And 
>>>> if use the virtio-iommu or somthing else, the efficiency and the 
>>>> complexity of driver integration are both lower than using iovector/ 
>>>> sgtable directly.
>>>> And for how to handle the DMA thing for userptr, since we have so 
>>>> many concern about it, maybe we can drop this part in next version. 
>>>> But we may have the AI review warn/error.
>>>
>>> Documentation/core-api/dma-attributes.rst says:
>>>
>>>  > DMA_ATTR_REQUIRE_COHERENT
>>>  > -------------------------
>>>  >
>>>  > DMA mapping requests with the DMA_ATTR_REQUIRE_COHERENT fail on any
>>>  > system where SWIOTLB or cache management is required. This should 
>>> only
>>>  > be used to support uAPI designs that require continuous HW DMA
>>>  > coherence with userspace processes, for example RDMA and DRM. At a
>>>  > minimum the memory being mapped must be userspace memory from
>>>  > pin_user_pages() or similar.
>>>  >
>>>  > Drivers should consider using dma_mmap_pages() instead of this
>>>  > interface when building their uAPIs, when possible.
>>>  >
>>>  > It must never be used in an in-kernel driver that only works with
>>>  > kernel memory.
>>>
>>> This is exactly our use case. Although the platform decides whether a
>>> mapping requires bouncing or cache maintenance, 
>>> DMA_ATTR_REQUIRE_COHERENT lets the driver reject mappings that cannot 
>>> meet this requirement.
>>>
>>> The shmem path serves a different use case, but amdkfd is a relevant 
>>> comparison. HIP's coherence guarantees depend on both the GPU VM/ 
>>> cache configuration and the DMA mapping established by the kernel 
>>> driver. GPU page table attributes alone cannot make a bounce buffer 
>>> coherent with the original userspace pages.
>>>
>>> The amdkfd mapping you cited therefore warrants discussion with its
>>> developers as well. I have CCed the maintainer.
>>
>>
>> Will add DMA_ATTR_REQUIRE_COHERENT in virtio GPU userptr in next version.
>> And are there some places else need to be modified?
> 
> I don't have anything else to add right now. As a QEMU developer, I've 
> only reviewed the more obvious aspects of this patch, so others may have 
> deeper kernel-specific feedback.

Thanks for your detailed review.

> 
> At this stage, my main priority is seeing how the current feedback is 
> resolved. Before we dig deeper into the low-level details, I’d also like 
> to review the virtio specification changes alongside the QEMU/ 
> virglrenderer implementation so I can better evaluate the overall design.

Will give the implementation for other components later.

Regards,
Honglei

> 
> Regards,
> Akihiko Odaki

