Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA424E9C0A
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612591; cv=fail; b=YhwqBZnhVfyY9GES6kPHc7ntMOK/p87VYccVTd9kIzj7InsdWzw6OOcZo5qi9G1EbeFJrANjQcq8n1malMedZD/SycjtJClpZVvsu2qldt7USQkeO/BrQMw5lFr/zGcgf9hFUqjpHDfoDFWflsYV/xWEoGnEwPFO3TiMfBlWqF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612591; c=relaxed/simple;
	bh=fy0CMS/DT/JT2Suqa5tmZa6mC9hPjvSdShayPIf40bU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HDAyb+B86dlo2wXAlPqTe1dosi9AyqqnCty0Q4Ls/BA1yaHzp2hyJx0ca1Y41wg+/1Rhe+Dd/A1fzk6FleooaGrVLRk06Jkrdl4pD4Uhp7L334GlNPOFQhSFSBb7/e4n0ka4u8yGkpq+1gXNt8lFB8UKqGaz3vnglbSWKMJZlpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bwVKxqWM; arc=fail smtp.client-ip=40.93.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bwVKxqWM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYnHjlswy32KDS8zcj3GGiO29f9fpQFw7pDPddVcon3846gwKk9e2xZPxkYxY1Jb91XA1kHO124yhsoSxqqW9pfw6XaYXlp3IbmKhTLjURdniCi8m/8m5GwfyOmJ4x7ZzzrmAvGb188zvcq2E16AtS1Hc6hWJtfnFZaEuzlOxCj/l1HSA0uH5XFefLEszpteIUJ2gCNJFMpd5d1iQlgct3+lHJYoOxYh/2oWNbCqghWxw50tFUZGkVuFGwKhu2A7ioCt8Bs6XXHLOwrY5drGh6SYfEwCAvDK4i6mPJYgJ+QcQTHHCUkd/Jxu3K04Hhg0wVCaC7xsumyvWuWXNluz2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJambJeQVS89QP5SS+oWw+80b9z2/pS8Cdgo5j+faok=;
 b=qTHtSKRaXIqAfelKzn30+zA8jwbLzPG84y3g0Kvd8z+hXCslRbX3F1MgxdHRe69E7FThK6nHFZkHhj+by6H78BvbQEI+tWp9mxi24y8i1ZhtVTpwhH1Hcbl4M/Pi3edn7SXBZtpogrNvwJuuka/TmTYOV1CUUxRiB1r5/B4L7cGemM6hXmTWWG8fXhE2poz+pIgxgGHYWMmf8yCsSH1/jPgUY7f/zoFwyMf8gtLOcr4CpCsQgjf9c7Ys9P1wx0hsL4whWoX8wKxDFLc7kpEimAo50iETgOr7sR+B5WZsXrjaUwLKN6rZwOYg+bIVwoe8ZVjBj2YmojoqH4DNp/OYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJambJeQVS89QP5SS+oWw+80b9z2/pS8Cdgo5j+faok=;
 b=bwVKxqWMtCdqAUdM6A09z+5IVELdObz4z3qiLtD4Q4DMOtVkCjb4O3vJjLusmSyfEH2ACcMcAq+I6yMkL1H72SAqlXu+GQ8SE/CoisVkXI6ie/hMeUtCbwlkzFUie2ya9pH5TxOsolsiJshHeI2bNkrFFWI75DITa3qzri8oU8c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7183.namprd12.prod.outlook.com (2603:10b6:510:228::20)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 16:23:02 +0000
Received: from PH8PR12MB7183.namprd12.prod.outlook.com
 ([fe80::d54c:d13c:6346:4009]) by PH8PR12MB7183.namprd12.prod.outlook.com
 ([fe80::d54c:d13c:6346:4009%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:23:02 +0000
Message-ID: <37c0ef9c-7249-4785-a3fd-646d816e2d4c@amd.com>
Date: Tue, 29 Sep 2026 00:22:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] drm/virtio: implement userptr resource support
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 dmitry.osipenko@collabora.com, airlied@redhat.com, kraxel@redhat.com
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Ray.Huang@amd.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-4-honghuan@amd.com>
 <fd17a38e-a827-41a5-a46e-db2135bb9257@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <fd17a38e-a827-41a5-a46e-db2135bb9257@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To PH8PR12MB7183.namprd12.prod.outlook.com
 (2603:10b6:510:228::20)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7183:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 0159946f-2e40-4f6e-7095-08df1d7cc470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|5023799004|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	jhXAjIbjc+Nqwdp+UjeIc7zcGiNMo2MnLwHW1V/hZSExjc4QIicbq2/Mcat1tx3kK2sVBUBRNELqJpYk8qT8l/B84gyFvXTZnntlrbnDY0qRKScgmbv0X6obpW3C7l8kitYL26Ru1p4yT/VE3Z9FUksFVqfO/9YXuw9iKlX/ykwgR/HnHhRMSmqZ/8nSXRCWb795K9aQlcL0qvRM8wUfFsC6iSmT5dv6dE0om7JFpj8KM1AtWpWEFCAB2j++akIbxeZWW+Lwg13NPPvvYqe/HNDcO+O9sli1fpVTjtnZA3TW36ovUGVYaElAdmRuHxnIfUsMjgNRMibua58wOF1/rxR6QKelmyDLT3ycQrvQrLGVCgkQldlszCMVCpP6HofD39l5/CvAiTPx+cPf8hHhhb52f+FhEtDMvq/WcK3SjPUFIf3uSCU40Bh1LoEaeWMMPfeR/EmtlgJI9W3eEKaoyQ2vQu1UOTS7d9O7DlPEVevbxciGdL6LtVjHhiWZaD8yS9WzTHViJ/aCj4O13bL9mQ36vIvU0Amy7p4aj8hFaQetD3XcG6tUZrgz5u5NzGgpQb6L6xEK/JRJ46o4/v7QB4HXn/Vxs/EcJu8tEXIFiLSPFDyPp7YpZtyWs+fVjojFoOxdfEbAFaZ/PrbzOHktu/ZdtMxl3HWnCBFZIUJZB0c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7183.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0JTUHF5amQ1QzhEdDd0dUJrY1l2SEpHRHlUYlphU0NZUHRnbis2aVJHMkFH?=
 =?utf-8?B?bnpFNGY4MFF0dFhZQlMyQ2FOUkl6VzV2MGhTSzNTS2lTS2UrUzZIcG5GTkJJ?=
 =?utf-8?B?WkR0ZXd5citvdFNRQ0doVWtHNlF3anNzNzQzK3NmUi9JbStUbHBjbSszdDRU?=
 =?utf-8?B?b1JTVkJzMU1BeFZoODNzNnc3SWVwaWR1bjlES2grT0Q0cUEwY3BIYlE2RUl4?=
 =?utf-8?B?TUNqK0pTTjVpaHgvdHhDUXB2VHNORVExSnBpejA1MysxZVVlZEFXSG5OR3Rl?=
 =?utf-8?B?N2huLzVQRXBpdG9FZjdiS2J4eFBpMTQ4dVdBRnh1Q3pFSmJNRkg1ejYrVkJ2?=
 =?utf-8?B?WXMxVVlCOG1vMmJRYk5lNWkvTE5ySGp4WVZsVUZmZHNRaCtpVG9LUUFzeHV1?=
 =?utf-8?B?eHY3OWhyWlByK05RcHBLREZoemxXWnBmc3BFZTZoaFlJczJqeXZXenV5d1dU?=
 =?utf-8?B?a0JnN2RscGJvbFhlckkyY3dlL1ZCNHdmM241a0hVNnEzUkxmcUM1V1lWalFZ?=
 =?utf-8?B?NXJoU3Z4Yk1Zd1Y2cHY2S3RvSm5sMzYrd0VZdUtVRi9OdXhIY0pyRldtdU1I?=
 =?utf-8?B?WC8xOFluL24wUGhiR0NoeUlySEZ1YUdYcktrSHNKaXA4ZTNROEd2WDFzZUM0?=
 =?utf-8?B?OEYvVWltb0c3RDlPYWxZMENqcytPZUNVMlVrcmcwSDFSQ2lMQUVHaEhSc0sv?=
 =?utf-8?B?dGFvblpwZmtUUVFiUW1SZnVoT2pscnhWUG1UMmJkd1dVZjZHZitrN0RHV0F4?=
 =?utf-8?B?YXZubFcrekFDUW82ZStUbFhMSkk5eE1FUVo2T0R1L3dHMDArL3FEYUt6U0dt?=
 =?utf-8?B?c1licXRmTnZxL3NXdkJYZ3o0ejhyTTZ6S2RaMG8xKy9IK2ZZQTMyZkM4M3h2?=
 =?utf-8?B?RTY5bUFmWVJmdnpWaWtmdWIyS25ZYmYvRTBHUVE3TFlnOEtzanBnVjJHQi8x?=
 =?utf-8?B?UEFMRkkwRHJBeUVMMHI5T1pHL2FuQ3RoU0dhOGprZlM1cmdEVHR3Y3lQMzhN?=
 =?utf-8?B?Nm52UVFsbGVEOWl5bU1MSFN1SEJwSTRKY0x5UTF2UkZuV2lsSGIyUGhsQ2pJ?=
 =?utf-8?B?MlZobHNVazlJNS9sakZ1SW1xL3BOWWpYT0dQR2FQa2ZXaW5mQ0hQLytDVFBW?=
 =?utf-8?B?Q0FDc1ZSUUZYQXpwMTBCcTVpcllaQ29ZMDVRcUhlTjhQQm81dkZxa1pYZmZG?=
 =?utf-8?B?cUkvbUNERGxnTCtWaHJqZVE1NDZjSlVPczRhb3dVMWVOa3ZoZ0labWNPSTRP?=
 =?utf-8?B?WllBaStiQ05LdlBzNEJFVnV5cEl2T2RqSFczUUZxemVocWF5ME84U2lJUHhz?=
 =?utf-8?B?VTlUOU9kY0RGV2ZwMnNUNU0rbmRSdTRoS0dMRTVoNHJndGl4S3JnV0xadlNz?=
 =?utf-8?B?bU0vSW00YTRDRHg1cURrenZKZk5iSnJBR2duSEZUMHBIN0ljNlBabGFOZjFC?=
 =?utf-8?B?ZW9sdkJLQkFqUkd2U2ZaMGhKRDkwbnlPeHBNeW5JTFRFMXgxNDJpZ1hqWVF2?=
 =?utf-8?B?eXU4Qys3VGhjLzBrN1loTzRNTXJRMWMxV3h1cEtHTG84Y3dqRnM2NU5aWWht?=
 =?utf-8?B?dEMvQjJPQnNaa0h2dXFwSi9SQ0VWM1hQUmRoaXUzUW5sV09idjc2RWlRZUdW?=
 =?utf-8?B?MFFlNkFDMFhxamdLSE4wTzhNT09HTnlNS3lTTTR6Z1ZTWXcxVW5DMnNXZldM?=
 =?utf-8?B?S0VBamhBOU1FMlNLbFhpcjNkalZ2cndPclNiaGs4ZXROcnhwczBEMjBHR0NR?=
 =?utf-8?B?L1FBV0w0NUlPK3BDR2VqVmRIanpqVkxRQzZROHB6NG9ORDBnZXJZeEhCdTJC?=
 =?utf-8?B?Z3dUc3Ntb3NYcjg1NGhqSENaampINHp3eFJWUXducWkwQmdLdnBsS1dqUFZz?=
 =?utf-8?B?b252OXhoRmE0bTJ0R1FKc1NNTURSdERoMDBmMUp3M0VqTzBnN1lrMzVsaWVZ?=
 =?utf-8?B?TmFZZ2YvSmdjZmZLRi9vcjRDYmJiQ29wUmFkejFRUWJsWitNdWZFVFhUOFg3?=
 =?utf-8?B?TzlQVTQ2K1hSVExLRXp6cXFUMUNZRHZTL2l5c2NXaFZ4SWNEWS9ZUHpoL0wy?=
 =?utf-8?B?cjBQV1FIcGxaTWIvZGs5VTNIY3RkVG1iS1QrWGVGSWFQNFFncjJSZklSTStI?=
 =?utf-8?B?K0t3L20vdEFWeWZUMWJvNk5TaFJzRktQQ3JXd3pnUEdxS2grQ3RlenFXRTQ2?=
 =?utf-8?B?YXNlVld3ZXA2Y0EvN1JISWg0b29kcGVNanMrRGRhLzdFU0tJS2RJY0JQdTRW?=
 =?utf-8?B?SUQwbVdWZGw5NEViRjhiVHR0QnF6VzN6N0lUaE9jcTM3RnEvU0xDUEY3RThr?=
 =?utf-8?Q?urU5lOjMhWzboG0WU+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0159946f-2e40-4f6e-7095-08df1d7cc470
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7183.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:23:02.0963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Vqzi90hBV+UtlEz4QVpoMrq8FNyJXyVS0P8pYhSolf9C5YW5c1GzvIBABNsApfwnd/eJY/rNFgvh1Zpm8JruQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105



On 9/26/2026 7:33 PM, Akihiko Odaki wrote:
> On 2026/09/24 18:55, Honglei Huang wrote:
>> Add userptr blob objects so the guest kernel can pin an existing
>> userspace mapping and advertise it as CREATE_BLOB backing entries.
>>
>> - New virtio_gpu_object_userptr type for userptr resources
>> - Pin pages with pin_user_pages_fast() and FOLL_LONGTERM
>> - Omit FOLL_WRITE when VIRTGPU_BLOB_FLAG_USE_READONLY is set
>> - Charge FOLL_LONGTERM pins against RLIMIT_MEMLOCK
>> - DMA-map the scatterlist only when virtio_gpu_use_dma_api() is
>>    required; use DMA_TO_DEVICE for USE_READONLY blobs
>> - Mark writable pages dirty when unpinning
>> - Keep pages pinned until RESOURCE_UNREF is queued; drop them from
>>    cleanup_object() on the unref response or on create failure
>> - Clear userptr->pages on pin failure to avoid double-free on cleanup
>> - Reject unaligned or overflowing userptr ranges at create time
>> - Disallow PRIME export of userptr objects
>> - Save CREATE_BLOB params and restore userptr resources after
>>    hibernation without using the shmem restore path
>>
>> The hibernation restore path maps with the same attrs and direction
>> used at create time, as documented next to the call. Like shmem
>> blobs, the DMA API can still bounce through a buffer there. This
>> design only avoids a second guest side shmem allocation and memcpy,
>> nothing more.
> 
> I don't see the restore path is documented though this says "documented 
> next to the call".

Will fix in next version

> 
>>
...
>> +        goto err_cleanup;
>> +    }
>> +
>> +    userptr->sgt = sgt;
>> +
>> +    if (virtio_gpu_use_dma_api(vgdev->vdev)) {
>> +        enum dma_data_direction dir =
>> +            (userptr->flags & VIRTGPU_BLOB_FLAG_USE_READONLY) ?
>> +            DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
>> +
>> +        ret = dma_map_sgtable(drm_dev_dma_dev(vgdev->ddev), sgt,
>> +                      dir, 0);
> 
> I checked the ROCm code and documentation, and I do not see how this 
> mapping satisfies the HIP coherence contract when bounce buffers or 
> explicit DMA cache maintenance are required.
> 
> HIP distinguishes two coherence models:
> 
>  > Coarse-grained coherence: The memory is considered up-to-date only
>  > after synchronization performed using hipDeviceSynchronize(),
>  > hipStreamSynchronize(), or any blocking operation that acts on the
>  > null stream such as hipMemcpy(). To avoid the cache from being
>  > accessed by a part of the system while simultaneously being written by
>  > another, the memory is made visible only after the caches have been
>  > flushed.
>  >
>  > Fine-grained coherence: The memory is coherent even while being
>  > modified by a part of the system. Fine-grained coherence ensures that
>  > up-to-date data is visible to others regardless of kernel boundaries.
>  > This can be useful if both host and device operate on the same data.
> 
> https://rocm.docs.amd.com/projects/HIP/en/docs-10.0.0/how-to/ 
> hip_runtime_api/memory_management/coherence_control.html
> 
> Fine-grained access requires coherence throughout execution; copying
> between the original pages and a bounce buffer only at kernel boundaries
> would not suffice. Coarse-grained access could support such copies, but
> they must occur at the required synchronization points. I found no code
> that synchronizes this DMA mapping at those points.
>

Whether dma_map_sgtable() bounces is decided by the platform's 
IOMMU/SWIOTLB behind the device, not by we request. attrs=0 here just 
matches the existing shmem blob path, and is exactly what native 
(non-virtualized) ROCm's own userptr support does too:

// drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c, 
kfd_mem_dmamap_userptr()
ret = dma_map_sgtable(adev->dev, ttm->sg, direction, 0);

And HIP's coarse-grained/fine-grained coherence isn't a DMA layer 
property, it is a GPU VM/cache thing. In upstream KFD it's implemented 
as GPU MMU page table attributes (MTYPE_CC/MTYPE_RW, the SNOOPED bit), 
set by whichever driver programs the real GPU's page tables for this memory:

// drivers/gpu/drm/amd/amdkfd/kfd_svm.c, svm_range_get_pte_flags()
mapping_flags |= coherent ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;

I really want to disable the bounce buffers in DMA, but it is a platform 
behaviour, can not disable it in this layer. And in XEN, the dmapping 
for it is another form of iovector/simple sgtable. And if use the 
virtio-iommu or somthing else, the efficiency and the complexity of 
driver integration are both lower than using iovector/sgtable directly.
And for how to handle the DMA thing for userptr, since we have so many 
concern about it, maybe we can drop this part in next version. But we 
may have the AI review warn/error.

Regards,
Honglei

> Regards,
> Akihiko Odaki
> 
>> +        if (ret)
>> +            goto err_cleanup;
>> +
>> +        userptr->dma_dir = dir;
>> +        userptr->dma_mapped = true;
>> +    }
>> +
>> +    ret = virtio_gpu_userptr_get_entries(vgdev, userptr, &ents, &nents);
>> +    if (ret)
>> +        goto err_cleanup;
>> +
>> +    virtio_gpu_cmd_resource_create_blob(vgdev, &userptr->base, 
>> params, ents,
>> +                        nents);
>> +
>> +    userptr->base.params = *params;
>> +    virtio_gpu_add_object_to_restore_list(vgdev, &userptr->base);
>> +
>> +    *bo_ptr = &userptr->base;
>> +    return 0;
>> +
>> +err_cleanup:
>> +    virtio_gpu_cleanup_object(&userptr->base);
>> +    return ret;
>> +}
> 

