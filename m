Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE0F430CE3
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241937; cv=fail; b=bGd/fNcXqzaZpn+7tyEGpEEZxVKoS4Bk0Pvel1W3kM03s47d7T0S+q/eFa2fFTAVEAA3JM+r915XDfpLnC05zJp1xhk+tcFCWoUrW8NbbElXtSj/kpGJE33+m7y0FBo5e4wFd51Nowp+g7Bxr3xm/zcIbY02fMa4tBuwyg7shis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241937; c=relaxed/simple;
	bh=RFF233Rm4ayNPp8gabHKCIVMNaH0VuMdv97PG7SE/Es=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hYNMK9+jr6x9JI36eLfl5ZFZKOv8NVgx/WI8C2sj8OhMjIxZFJjLUGgg7YwFjTiZamelTBEsmLcUbyO9x+W74905K44x+7M6M3s9fBgiqnkS42kSFq3CGrgPW7GpqDIQRYGyBFI7JvNgq/mIKvWpco/dFloE0XM049MUq96kmro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cpDTsVR9; arc=fail smtp.client-ip=52.101.56.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cpDTsVR9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+JjZokeKxRdLm2RIK7evPEvc9olIbs/qU5/jluQVKKe4sbbqHCp++hhsyX3RF7NW/03YodL1lSTdyl2ok13TrMMVr5iduzT+UGavu81RvFJc342QbVvOA4lSa2GagDBcWlXobH9TW/FeN/XvxLOajG3Y41bcV6MomSHFS4G0GNwOTKiC0KFfOBWsV6pYxPy3LNT5OleUn9QZHGxxH4w3Ta4dfQE7hVuW7M8NP+HB73D6Yn0d2d/yVDAiYD5kG7gdCfy5+Wil/kEI91slQIprOA8hs3vLZsk/xPCd0GIT78pb5d1Jc1CH26KDM21bEJGybdmZz2FDBe2XiM4d7QPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6CKV5maBEoLqPmQWc3RXgEe933RpD+Q7F+b3XN2b7g=;
 b=ByHTpNT3Ob2/wY5CEmt8Iv4rrxZpF55+2PryN4f3IXWuFuegQvHI4PwXOFmSOfczT/kNosvnSfGL4DLR7Jq8+FRZhpm9WOo7dHbYBnB32NNAftDQQF/yQIpr+Q3oV3UAyeheHPw7ppHpoNYXkhR4cSZHashu2i70Uge73bM9Qqp1v5Mvl4YQqJ1GAzq5t17QJbtDx2i/uMq5SrLkPUckV838EW20ZDIG4Wvgztke1HcwIZsRMcTojKDLX1dc4wdIJwQJyY2gv1/RgmInVa6yuOWHlW9QruhJaBX12Q2g4YVx9SRo5dORh5oKpGuYYXn40gMuniTGYkuuWsSehICDwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6CKV5maBEoLqPmQWc3RXgEe933RpD+Q7F+b3XN2b7g=;
 b=cpDTsVR970BVV6j0eB39rWXmxGYYu+DrZD4Nmypm+INSS5K5NaBhIqY8ZxnucT+GZTqn6uIWaQJ1LSfZmWgsLVwXyXKYgxxYG7Eol9DoFuUH+3RhuZJzGjw29CLeATGs5z5H9fbjMjZ9/bkD0KtT6DfEcp4SUvnZOc7lOeEkprk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Thu, 24 Sep
 2026 09:25:20 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 09:25:20 +0000
Message-ID: <4813f53c-d6f4-4e2b-a92d-2218b6e49951@amd.com>
Date: Thu, 24 Sep 2026 17:25:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] drm/virtio: implement userptr support for
 zero-copy memory access
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260918095940.2253018-1-honghuan@amd.com>
 <20260918095940.2253018-4-honghuan@amd.com>
 <30ce57b1-21ab-4fb3-9e6c-75d061807b17@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <30ce57b1-21ab-4fb3-9e6c-75d061807b17@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0028.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::17) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|CY5PR12MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7816c0-10ec-4157-3c7d-08df1a1dc0c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|5023799004|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	6qdfFrKY6AyignNxW/7X2NlRQWSdclQlR1wpZvT/IPQXTH4iLZZaWeyOZSWovx6LvoLwQoDQE0QHxw0sIJ9wmt5p+ILVwUxn8u0kiQ7QxJjfCnYcbVJVtTaO8BqRv7P3CLMVet38ROFTvuJsmH71cwWFFutxR7PNHEW7TaAlYA4lHv6WPpAsMNIqMqf+PemZtdtxCp6dI9o1Jp+HwCGeClRWQegIEoiLkI8hhuIgbP3dn/wx3g+VapUSxBuOdJzLKIRGX1ZvVMVJ0aLh46VDAceAXvTDcgiPnuWayn69+mA4OShv6UO698vv8zu7ns3BZPzYYzlNSI6mOWS8WTGz6iFHkCEBKYaSFxkYh0CkQ0jBc1neEPcJCoipOsyLoihvnLGlTGjtoILfkgbabMCt5Eyt97c2UwDOYTm2WgdkC1Av2zSkU76gURaViDEDSfzteipjMsCsOgSEdVTP2ccxL/VAu1xUaRf8p9rh0JC7s6xbnCd4pvjxZZ9kbt+46Mem5cirfsZhSfjqvzyjRoSWlqecCX8Hkj4R2RMw+af7S1CXueLEbG/ryFhoAXs+Id3gpHjdfSBryDQyd8H/ErY/03RC9N40SYh022A9YGcFQj9rHx2jzpY91CeVi1XLHvlF7XwVOHBysst3pWAXqr/nIGZVktaiNwmoK3QG9F8jcaA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(5023799004)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDMvV1AzNGlRT3cvVElkM2VyTXNEMmIrVmhDUzJITDVaUHhrcUtSWk4zZEVG?=
 =?utf-8?B?T2M1d0RSVWRaV3g0LzNQcTRlREo4b3MrVEtEaW5ucDI2VGt3M08ySGtVSzJE?=
 =?utf-8?B?YXlaK2RFSE9UTy9QSWttWVE5RnhERXZLT3dGOFN2QjVHRkZTa2xVcW9hOGVX?=
 =?utf-8?B?aFlRSmVpdll5MVVQT3BxSkd3YlBlTVRKZThHNFQ5YTJkVDlpdXlJS2N1NXUr?=
 =?utf-8?B?THJHckdtcGRVaGg5aTdyNU5lWFlkRng5ZUkwVHpZRWRVRW1sM3ZjaXZpRGYx?=
 =?utf-8?B?aXJpTzBUWWNKN1gwOU9lejV6Y1FrWFk4Ry82NkJBcGVUck15dGQ1WmlXYjhv?=
 =?utf-8?B?ZnBkb05UQXhySkFsTm03dDY5M0txT1BpaGRmb2tXSzVhdWpTcHJiWHZLa1RE?=
 =?utf-8?B?bWpRaExGK2VQeXI3bklSZmc0ak1nSjNuYXNmSmUzbDIybjNzUXBENXJNUHIr?=
 =?utf-8?B?Smw2eVZ1QXJQQTZBaGZxc2ppaFB6c3JjOFA1d1h1b0g2UVdmUzArOVJLcFNv?=
 =?utf-8?B?OG1xMWxCVzhOUVdER0d4NGlLR1d4Z3ljOURRZURUdm5oTTdmdmdHYlFJM2Vz?=
 =?utf-8?B?MkhEQ2FXTUpaTWtkdEZubzV5WXNkN2hzdXVDWDNNQW5WRWlvTUtPZ1I0VnE2?=
 =?utf-8?B?RkhENE1kdHBUTG9nYnplNlUyQXZVQUxzMFdJYU00RG9ncWFwNUpWOW9lM1BD?=
 =?utf-8?B?VlViM0ZwYWZhZXR3WUxtbVBVaHNPQ0lEWjRCdVRONlB3N01KRWVpRUFCMDFs?=
 =?utf-8?B?MmluVlBCWmxjbVM3ZkNKMDc2enVHak9zbFFrWlJJeEV1dWlPREFHQ1NNbUo4?=
 =?utf-8?B?VGtMTVBVeElxTDRZU3lIdDJiWWRHQ2ZKRWNlV1JQckViOXd2ZlcrelkydjNw?=
 =?utf-8?B?WDhiTmJxMTFwdVNyRyt6SjVQc0dYSkhUMU80S242aWRkZWRweUlQaHFyWVJk?=
 =?utf-8?B?dWRZVkV1eWxaVFRxSkI5TnNuVnZUeUpMbWs5RG1tYXAxVHVBUmkyQkdWZGxu?=
 =?utf-8?B?VlFGVTRERkNJNWltY2xaMnJvOWZ4SU5jNDU2VjBBOHoyRFpJTHZvemQ1SnFn?=
 =?utf-8?B?YmQ5dGRJUEVGUElkaEQwZlpXOVRsQmNhZnlJSmRiZCt1anhMMStUUWJiV1NQ?=
 =?utf-8?B?dmZoMGhJVG8zamsrSU9TUDNRaUF5ekFGN21Gb3QzK0cxeWdrSjBBMCt6RU5q?=
 =?utf-8?B?TVBuSk5RYmd1azNtQkp5TXNpMmR3S3g3aXhWWndkbkQ3MW9BNmVhSnphNnAz?=
 =?utf-8?B?a3NTMFVnWmZLWkpnUElGYXJ0R0pWSVZKZk5pdnM5ZWszYVZ4TnRnU0VDdnFz?=
 =?utf-8?B?VzJ2UHMyVFRuakdWejIwUzZxTGNGL2NOQ3VmemI4anhKZFJqRVFia0F4dk5Y?=
 =?utf-8?B?YU54K24wMllwbjRCcEtUVlAwZHFydDBXVkFlN2xBMVBZMy9OUFQ4ejFOOEla?=
 =?utf-8?B?UWMxZ3FDYlZENFlsOWNSUWI0ZTBXVSszdVVGZlNxL3NEbnNWQUNlU3l6dlJ4?=
 =?utf-8?B?elJnSTQzSUpxd0FQaDR1QVRieGhWYnJ3eXRLUEtkQnh3TmNrL0NrcVhsVy9P?=
 =?utf-8?B?Ym5NTWVheTkvSXh0TkpjNUpIaEtmZ043Wmt1am1xbmZPLzNZSE1rQ1BMWER0?=
 =?utf-8?B?RGFxcEFHeTdwTkhON3RJbmVXcER1ODN1S0ZEYXpsOUlPUXE3cE9XWk40T2sw?=
 =?utf-8?B?SXJKY2lFZHN2ZWE4SEwvK253eFRjQnd6Znl1ckprb2JhUEVPT1l5K292L0lo?=
 =?utf-8?B?eFVrUlFJQUxCQmlEem8xYUNZZ0w0RFFGT21nc0JkdHc5N1BmUURoUzdNWGpn?=
 =?utf-8?B?NlU1Tmd2cGVYQ21nTk5nY3hZMENMVDd1L3Y3NXRwQzVNWlYvZ3RTUEduTUg5?=
 =?utf-8?B?TWFxSWxUbnBpOVdYZURVOW1KcWtqVi94NFkxd2xMaE8rTTg2cStjU1Jmem5z?=
 =?utf-8?B?TXJlcWpiVlhHdkNyV2hrMVhmR0ZaRTdXSTdnNnNoNlUvTXdVcFo0QkVXNTNP?=
 =?utf-8?B?R0ZDVFd3VWVZVnhHdFduMFZ6SXBVMVV6QW5lMCtCUnd6K204MDE3ck9nZTl6?=
 =?utf-8?B?YWlPVW9malh1dHJHODFWQ2dldWZXL2QzSTdrZ052cC8rNUdHcUZKL2VGOFBl?=
 =?utf-8?B?S1k5U0hCSDkxL2ZlcUZwa1VFYVQ2eGF1aXR1WGNIOVpHdnNoNnZRR2NVNHRx?=
 =?utf-8?B?aUhrdWxyYm56SHZSa1B2NGU2MjduTUhHTys1Z2JMdlNCN1EvN1ZYeEpCNTlL?=
 =?utf-8?B?eDZoMTBSUVVTUDIxYlIrTXMvY1ZpcCs2UGo0a0EzMFhwNWp4OEFPcy9aTXBt?=
 =?utf-8?Q?aXDM8+h9a9tDcTHlni?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7816c0-10ec-4157-3c7d-08df1a1dc0c1
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 09:25:20.4745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xG0YpEEvM91ywfroNGoJ73VX9FxF75sil+MEQ8AraxE53o8Biqz4X+80cNJBki8vN37k08R5nJ15cygNH2ojSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226



On 9/19/2026 4:59 PM, Akihiko Odaki wrote:
> On 2026/09/18 18:59, Honglei Huang wrote:
>> Add userptr blob objects so the guest kernel can pin an existing
>> userspace mapping and advertise it as CREATE_BLOB backing entries.
>>
>> - New virtio_gpu_object_userptr type for userptr resources
>> - Pin pages with pin_user_pages_fast() and FOLL_LONGTERM
>> - Omit FOLL_WRITE when VIRTGPU_BLOB_FLAG_USE_READONLY is set
>> - Charge FOLL_LONGTERM pins against RLIMIT_MEMLOCK
>> - DMA-map the scatterlist only when virtio_gpu_use_dma_api() is
>>    required; use DMA_TO_DEVICE for USE_READONLY blobs
>> - Sync userptr SG for the device on TRANSFER_TO_HOST
>> - Mark writable pages dirty when unpinning
>> - Keep pages pinned until RESOURCE_UNREF is queued; drop them from
>>    cleanup_object() on the unref response or on create failure
>> - Clear userptr->pages on pin failure to avoid double-free on cleanup
>> - Reject unaligned or overflowing userptr ranges at create time
>> - Disallow PRIME export of userptr objects
>> - Save CREATE_BLOB params and restore userptr resources after
>>    hibernation without using the shmem restore path
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/virtio/Makefile          |   3 +-
>>   drivers/gpu/drm/virtio/virtgpu_drv.h     |  43 +++
>>   drivers/gpu/drm/virtio/virtgpu_object.c  |  22 ++
>>   drivers/gpu/drm/virtio/virtgpu_userptr.c | 365 +++++++++++++++++++++++
>>   drivers/gpu/drm/virtio/virtgpu_vq.c      |  33 +-
>>   5 files changed, 456 insertions(+), 10 deletions(-)
>>   create mode 100644 drivers/gpu/drm/virtio/virtgpu_userptr.c
>>
>> diff --git a/drivers/gpu/drm/virtio/Makefile b/drivers/gpu/drm/virtio/ 
>> Makefile
>> index d2e1788a82..fe7332a621 100644
>> --- a/drivers/gpu/drm/virtio/Makefile
>> +++ b/drivers/gpu/drm/virtio/Makefile
>> @@ -6,6 +6,7 @@
>>   virtio-gpu-y := virtgpu_drv.o virtgpu_kms.o virtgpu_gem.o 
>> virtgpu_vram.o \
>>       virtgpu_display.o virtgpu_vq.o \
>>       virtgpu_fence.o virtgpu_object.o virtgpu_debugfs.o 
>> virtgpu_plane.o \
>> -    virtgpu_ioctl.o virtgpu_prime.o virtgpu_trace_points.o 
>> virtgpu_submit.o
>> +    virtgpu_ioctl.o virtgpu_prime.o virtgpu_trace_points.o 
>> virtgpu_submit.o \
>> +    virtgpu_userptr.o
>>   obj-$(CONFIG_DRM_VIRTIO_GPU) += virtio-gpu.o
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/ 
>> virtio/virtgpu_drv.h
>> index 9df4c71173..e0941cc187 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
>> @@ -105,6 +105,7 @@ struct virtio_gpu_object_params {
>>       uint32_t blob_flags;
>>       uint64_t blob_id;
>>       uint32_t blob_hints;
>> +    uint64_t userptr;
>>   };
>>   struct virtio_gpu_object {
>> @@ -138,12 +139,42 @@ struct virtio_gpu_object_vram {
>>       struct drm_mm_node vram_node;
>>   };
>> +struct virtio_gpu_object_userptr;
>> +
>> +struct virtio_gpu_object_userptr_ops {
>> +    int (*get_pages)(struct virtio_gpu_object_userptr *userptr);
>> +    void (*put_pages)(struct virtio_gpu_object_userptr *userptr);
>> +};
>> +
>> +struct virtio_gpu_object_userptr {
>> +    struct virtio_gpu_object base;
>> +    const struct virtio_gpu_object_userptr_ops *ops;
>> +    /* Protects pages and sgt. */
>> +    struct mutex lock;
>> +
>> +    uint64_t start;
>> +    uint32_t npages;
>> +    uint32_t bo_handle;
>> +    uint32_t flags;
>> +
>> +    struct virtio_gpu_device *vgdev;
>> +    struct drm_file *file;
>> +    struct page **pages;
>> +    struct sg_table *sgt;
>> +    bool dma_mapped;
>> +    enum dma_data_direction dma_dir;
>> +    struct mm_struct *mm;
>> +};
>> +
>>   #define to_virtio_gpu_shmem(virtio_gpu_object) \
>>       container_of((virtio_gpu_object), struct 
>> virtio_gpu_object_shmem, base)
>>   #define to_virtio_gpu_vram(virtio_gpu_object) \
>>       container_of((virtio_gpu_object), struct virtio_gpu_object_vram, 
>> base)
>> +#define to_virtio_gpu_userptr(virtio_gpu_object) \
>> +    container_of((virtio_gpu_object), struct 
>> virtio_gpu_object_userptr, base)
>> +
>>   struct virtio_gpu_object_array {
>>       struct ww_acquire_ctx ticket;
>>       struct list_head next;
>> @@ -284,6 +315,7 @@ struct virtio_gpu_device {
>>       bool has_host_visible;
>>       bool has_context_init;
>>       bool has_blob_alignment;
>> +    bool has_blob_readonly;
>>       bool hibernated;
>>       struct virtio_shm_region host_visible_region;
>>       struct drm_mm host_visible_mm;
>> @@ -562,4 +594,15 @@ void virtio_gpu_vram_map_deferred(struct 
>> virtio_gpu_object_vram *vram);
>>   int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>>                   struct drm_file *file);
>> +/* virtgpu_userptr.c */
>> +int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
>> +                  struct drm_file *file,
>> +                  struct virtio_gpu_object_params *params,
>> +                  struct virtio_gpu_object **bo_ptr);
>> +bool virtio_gpu_is_userptr(struct virtio_gpu_object *bo);
>> +void virtio_gpu_userptr_dma_sync_for_device(struct virtio_gpu_object 
>> *bo);
>> +int virtio_gpu_userptr_restore(struct virtio_gpu_device *vgdev,
>> +                   struct virtio_gpu_object *bo,
>> +                   struct virtio_gpu_mem_entry **ents,
>> +                   unsigned int *nents);
>>   #endif
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/ 
>> drm/virtio/virtgpu_object.c
>> index 49899485be..ab21494b1c 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
>> @@ -91,6 +91,16 @@ void virtio_gpu_cleanup_object(struct 
>> virtio_gpu_object *bo)
>>           drm_gem_free_mmap_offset(&vram->base.base.base);
>>           drm_gem_object_release(&vram->base.base.base);
>>           kfree(vram);
>> +    } else if (virtio_gpu_is_userptr(bo)) {
>> +        struct virtio_gpu_object_userptr *userptr =
>> +            to_virtio_gpu_userptr(bo);
>> +
>> +        mutex_lock(&userptr->lock);
>> +        userptr->ops->put_pages(userptr);
>> +        mutex_unlock(&userptr->lock);
>> +        mutex_destroy(&userptr->lock);
>> +        drm_gem_object_release(&userptr->base.base.base);
>> +        kfree(userptr);
>>       } else {
>>           drm_gem_object_release(&bo->base.base);
>>           kfree(bo);
>> @@ -316,6 +326,18 @@ int virtio_gpu_object_restore_all(struct 
>> virtio_gpu_device *vgdev)
>>               continue;
>>           }
>> +        if (virtio_gpu_is_userptr(bo)) {
>> +            ret = virtio_gpu_userptr_restore(vgdev, bo, &ents,
>> +                             &nents);
>> +            if (ret)
>> +                break;
>> +
>> +            virtio_gpu_cmd_resource_create_blob(vgdev, bo,
>> +                                &bo->params,
>> +                                ents, nents);
>> +            continue;
>> +        }
>> +
>>           if (bo->params.blob || bo->attached) {
>>               ret = virtio_gpu_object_shmem_init(vgdev, bo, &ents,
>>                                  &nents);
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_userptr.c b/drivers/gpu/ 
>> drm/virtio/virtgpu_userptr.c
>> new file mode 100644
>> index 0000000000..ccfd96844e
>> --- /dev/null
>> +++ b/drivers/gpu/drm/virtio/virtgpu_userptr.c
>> @@ -0,0 +1,365 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <linux/dma-mapping.h>
>> +#include <linux/limits.h>
>> +#include <linux/mm.h>
>> +#include <linux/overflow.h>
>> +#include <linux/pid.h>
>> +#include <linux/sched/mm.h>
>> +#include <linux/sched/signal.h>
>> +#include <linux/vmalloc.h>
>> +
>> +#include "virtgpu_drv.h"
>> +#include <drm/drm_gem.h>
>> +
>> +static void virtio_gpu_userptr_free(struct drm_gem_object *obj)
>> +{
>> +    struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
>> +    struct virtio_gpu_device *vgdev = obj->dev->dev_private;
>> +
>> +    /*
>> +     * Keep pages pinned until RESOURCE_UNREF completes. The response
>> +     * callback calls virtio_gpu_cleanup_object(), which drops them.
>> +     */
>> +    if (bo->created) {
>> +        virtio_gpu_remove_from_restore_list(bo);
>> +        virtio_gpu_cmd_unref_resource(vgdev, bo, false);
>> +        virtio_gpu_notify(vgdev);
>> +        return;
>> +    }
>> +
>> +    virtio_gpu_cleanup_object(bo);
>> +}
>> +
>> +static struct dma_buf *
>> +virtio_gpu_userptr_prime_export(struct drm_gem_object *obj, int flags)
>> +{
>> +    return ERR_PTR(-EINVAL);
>> +}
>> +
>> +static const struct drm_gem_object_funcs virtio_gpu_userptr_funcs = {
>> +    .open = virtio_gpu_gem_object_open,
>> +    .close = virtio_gpu_gem_object_close,
>> +    .free = virtio_gpu_userptr_free,
>> +    .export = virtio_gpu_userptr_prime_export,
>> +};
>> +
>> +bool virtio_gpu_is_userptr(struct virtio_gpu_object *bo)
>> +{
>> +    return bo->base.base.funcs == &virtio_gpu_userptr_funcs;
>> +}
>> +
>> +void virtio_gpu_userptr_dma_sync_for_device(struct virtio_gpu_object 
>> *bo)
>> +{
>> +    struct virtio_gpu_object_userptr *userptr = 
>> to_virtio_gpu_userptr(bo);
>> +    struct device *dev;
>> +
>> +    if (!userptr->dma_mapped)
>> +        return;
>> +
>> +    dev = drm_dev_dma_dev(userptr->base.base.base.dev);
>> +    dma_sync_sgtable_for_device(dev, userptr->sgt, DMA_TO_DEVICE);
>> +}
>> +
>> +static int
>> +virtio_gpu_userptr_get_pages(struct virtio_gpu_object_userptr *userptr)
>> +{
>> +    unsigned int flag = FOLL_LONGTERM;
>> +    unsigned int num_pages, pinned = 0;
>> +    int ret = 0;
>> +
>> +    if (userptr->pages)
>> +        return 0;
>> +
>> +    userptr->pages = kvmalloc_array(userptr->npages, sizeof(struct 
>> page *),
>> +                    GFP_KERNEL);
>> +    if (!userptr->pages)
>> +        return -ENOMEM;
>> +
>> +    if (!(userptr->flags & VIRTGPU_BLOB_FLAG_USE_READONLY))
>> +        flag |= FOLL_WRITE;
>> +
>> +    do {
>> +        num_pages = userptr->npages - pinned;
>> +
>> +        ret = pin_user_pages_fast(userptr->start + pinned * PAGE_SIZE,
>> +                      num_pages, flag,
>> +                      userptr->pages + pinned);
>> +
>> +        if (ret < 0) {
>> +            if (pinned)
>> +                unpin_user_pages(userptr->pages, pinned);
>> +            kvfree(userptr->pages);
>> +            userptr->pages = NULL;
>> +            return ret;
>> +        }
>> +
>> +        pinned += ret;
>> +
>> +    } while (pinned < userptr->npages);
>> +
>> +    return 0;
>> +}
>> +
>> +static void
>> +virtio_gpu_userptr_unaccount(struct virtio_gpu_object_userptr *userptr)
>> +{
>> +    if (!userptr->mm)
>> +        return;
>> +
>> +    atomic64_sub(userptr->npages, &userptr->mm->pinned_vm);
>> +    mmdrop(userptr->mm);
>> +    userptr->mm = NULL;
>> +}
>> +
>> +static void
>> +virtio_gpu_userptr_put_pages(struct virtio_gpu_object_userptr *userptr)
>> +{
>> +    struct drm_device *dev = userptr->base.base.base.dev;
>> +
>> +    if (userptr->sgt) {
>> +        if (userptr->dma_mapped)
>> +            dma_unmap_sgtable(drm_dev_dma_dev(dev), userptr->sgt,
>> +                      userptr->dma_dir, 0);
>> +        userptr->dma_mapped = false;
>> +        sg_free_table(userptr->sgt);
>> +        kfree(userptr->sgt);
>> +        userptr->sgt = NULL;
>> +    }
>> +
>> +    if (userptr->pages) {
>> +        bool dirty = !(userptr->flags & VIRTGPU_BLOB_FLAG_USE_READONLY);
>> +
>> +        unpin_user_pages_dirty_lock(userptr->pages, userptr->npages,
>> +                        dirty);
>> +        kvfree(userptr->pages);
>> +        userptr->pages = NULL;
>> +    }
>> +
>> +    virtio_gpu_userptr_unaccount(userptr);
>> +}
>> +
>> +static int
>> +virtio_gpu_userptr_get_entries(struct virtio_gpu_device *vgdev,
>> +                   struct virtio_gpu_object_userptr *userptr,
>> +                   struct virtio_gpu_mem_entry **ents,
>> +                   unsigned int *nents)
>> +{
>> +    bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
>> +    struct scatterlist *sg;
>> +    unsigned int count;
>> +    int si;
>> +
>> +    count = use_dma_api ? userptr->sgt->nents : userptr->sgt- 
>> >orig_nents;
>> +    if (!count)
>> +        return -EINVAL;
>> +
>> +    *ents = kvmalloc_array(count, sizeof(**ents), GFP_KERNEL);
>> +    if (!*ents)
>> +        return -ENOMEM;
>> +
>> +    if (use_dma_api) {
>> +        for_each_sgtable_dma_sg(userptr->sgt, sg, si) {
>> +            (*ents)[si].addr = cpu_to_le64(sg_dma_address(sg));
>> +            (*ents)[si].length = cpu_to_le32(sg_dma_len(sg));
>> +            (*ents)[si].padding = 0;
>> +        }
>> +    } else {
>> +        for_each_sgtable_sg(userptr->sgt, sg, si) {
>> +            (*ents)[si].addr = cpu_to_le64(sg_phys(sg));
>> +            (*ents)[si].length = cpu_to_le32(sg->length);
>> +            (*ents)[si].padding = 0;
>> +        }
>> +    }
>> +
>> +    *nents = count;
>> +    return 0;
>> +}
>> +
>> +int virtio_gpu_userptr_restore(struct virtio_gpu_device *vgdev,
>> +                   struct virtio_gpu_object *bo,
>> +                   struct virtio_gpu_mem_entry **ents,
>> +                   unsigned int *nents)
>> +{
>> +    struct virtio_gpu_object_userptr *userptr = 
>> to_virtio_gpu_userptr(bo);
>> +    int ret;
>> +
>> +    mutex_lock(&userptr->lock);
>> +    if (!userptr->sgt || !userptr->pages) {
>> +        mutex_unlock(&userptr->lock);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (userptr->dma_mapped) {
>> +        struct device *dev = drm_dev_dma_dev(vgdev->ddev);
>> +
>> +        dma_unmap_sgtable(dev, userptr->sgt, userptr->dma_dir, 0);
>> +        userptr->dma_mapped = false;
>> +        ret = dma_map_sgtable(dev, userptr->sgt, userptr->dma_dir, 0);
> 
> This maps with attributes 0, allowing bounce buffers instead of
> "zero-copy memory access". It is also unclear what coherence guarantee 
> the UAPI is intended to provide.


This is a good point, will modify the commit and patch tittle to remove
ero-copy memory access.
And in virtio_gpu_object_shmem_init it also uses dma_map_sgtable(..., 
0), so keep 0 here.

Regards,
Honglei

> 
>> +        if (ret) {
>> +            mutex_unlock(&userptr->lock);
>> +            return ret;
>> +        }
>> +        userptr->dma_mapped = true;
>> +    }
>> +
>> +    ret = virtio_gpu_userptr_get_entries(vgdev, userptr, ents, nents);
>> +    mutex_unlock(&userptr->lock);
>> +    return ret;
>> +}
>> +
>> +static int
>> +virtio_gpu_userptr_init(struct drm_device *dev, struct drm_file *file,
>> +            struct virtio_gpu_object_userptr *userptr,
>> +            struct virtio_gpu_object_params *params,
>> +            const struct virtio_gpu_object_userptr_ops *ops)
>> +{
>> +    struct drm_gem_object *obj;
>> +    int ret;
>> +
>> +    userptr->start = params->userptr;
>> +    userptr->npages = params->size >> PAGE_SHIFT;
>> +    userptr->flags = params->blob_flags;
>> +
>> +    mutex_init(&userptr->lock);
>> +    userptr->vgdev = dev->dev_private;
>> +    userptr->file = file;
>> +    userptr->ops = ops;
>> +
>> +    /*
>> +     * Allocate the resource id before GEM init so a failure here can
>> +     * unwind with a plain kfree and does not need a special id=0 guard
>> +     * in the shared resource_id_put helper.
>> +     */
>> +    ret = virtio_gpu_resource_id_get(userptr->vgdev,
>> +                     &userptr->base.hw_res_handle);
>> +    if (ret) {
>> +        mutex_destroy(&userptr->lock);
>> +        return ret;
>> +    }
>> +
>> +    obj = &userptr->base.base.base;
>> +    obj->funcs = &virtio_gpu_userptr_funcs;
>> +
>> +    drm_gem_private_object_init(dev, obj, params->size);
>> +    INIT_LIST_HEAD(&userptr->base.restore_node);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct virtio_gpu_object_userptr_ops 
>> virtio_gpu_userptr_ops = {
>> +    .get_pages = virtio_gpu_userptr_get_pages,
>> +    .put_pages = virtio_gpu_userptr_put_pages,
>> +};
>> +
>> +int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
>> +                  struct drm_file *file,
>> +                  struct virtio_gpu_object_params *params,
>> +                  struct virtio_gpu_object **bo_ptr)
>> +{
>> +    struct virtio_gpu_object_userptr *userptr;
>> +    struct virtio_gpu_mem_entry *ents = NULL;
>> +    struct sg_table *sgt;
>> +    struct mm_struct *mm;
>> +    unsigned long lock_limit;
>> +    unsigned long start;
>> +    unsigned long end;
>> +    s64 new_pinned;
>> +    unsigned int nents;
>> +    int ret;
>> +
>> +    *bo_ptr = NULL;
>> +
>> +    if (!params->size || !IS_ALIGNED(params->size, PAGE_SIZE) ||
>> +        params->userptr != (unsigned long)params->userptr)
>> +        return -EINVAL;
>> +
>> +    start = params->userptr;
>> +    if (!IS_ALIGNED(start, PAGE_SIZE) ||
>> +        check_add_overflow(start, (unsigned long)params->size, &end))
>> +        return -EINVAL;
>> +
>> +    if (!can_do_mlock())
>> +        return -EPERM;
>> +
>> +    if (params->size >> PAGE_SHIFT > INT_MAX)
>> +        return -E2BIG;
>> +
>> +    if (!access_ok((void __user *)start, params->size))
>> +        return -EFAULT;
>> +
>> +    userptr = kzalloc_obj(*userptr);
>> +    if (!userptr)
>> +        return -ENOMEM;
>> +
>> +    ret = virtio_gpu_userptr_init(vgdev->ddev, file, userptr, params,
>> +                      &virtio_gpu_userptr_ops);
>> +    if (ret) {
>> +        kfree(userptr);
>> +        return ret;
>> +    }
>> +
>> +    mm = current->mm;
>> +    mmgrab(mm);
>> +    lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>> +    new_pinned = atomic64_add_return(userptr->npages, &mm->pinned_vm);
>> +    if (new_pinned < 0 ||
>> +        (new_pinned > lock_limit && !capable(CAP_IPC_LOCK))) {
>> +        atomic64_sub(userptr->npages, &mm->pinned_vm);
>> +        mmdrop(mm);
>> +        ret = new_pinned < 0 ? -EOVERFLOW : -ENOMEM;
>> +        goto err_cleanup;
>> +    }
>> +    userptr->mm = mm;
>> +
>> +    mutex_lock(&userptr->lock);
>> +    ret = userptr->ops->get_pages(userptr);
>> +    mutex_unlock(&userptr->lock);
>> +    if (ret)
>> +        goto err_cleanup;
>> +
>> +    sgt = drm_prime_pages_to_sg(vgdev->ddev, userptr->pages,
>> +                    userptr->npages);
>> +    if (IS_ERR(sgt)) {
>> +        ret = PTR_ERR(sgt);
>> +        goto err_cleanup;
>> +    }
>> +
>> +    userptr->sgt = sgt;
>> +
>> +    /*
>> +     * Match shmem blobs: only DMA-map when the virtio DMA API is in
>> +     * use. Mapping unconditionally can create SWIOTLB bounce buffers
>> +     * that get copied back over guest pages on unmap even though the
>> +     * host was given sg_phys() addresses.
>> +     */
>> +    if (virtio_gpu_use_dma_api(vgdev->vdev)) {
>> +        enum dma_data_direction dir =
>> +            (userptr->flags & VIRTGPU_BLOB_FLAG_USE_READONLY) ?
>> +            DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
>> +
>> +        ret = dma_map_sgtable(drm_dev_dma_dev(vgdev->ddev), sgt,
>> +                      dir, 0);
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
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/ 
>> virtio/virtgpu_vq.c
>> index c02c03c10d..dcbd7bb7a6 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
>> @@ -781,9 +781,14 @@ int 
>> virtio_gpu_panic_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>>       struct virtio_gpu_vbuffer *vbuf;
>>       bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
>> -    if (virtio_gpu_is_shmem(bo) && use_dma_api)
>> -        dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
>> -                        bo->base.sgt, DMA_TO_DEVICE);
>> +    if (use_dma_api) {
>> +        if (virtio_gpu_is_shmem(bo))
>> +            dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
>> +                            bo->base.sgt,
>> +                            DMA_TO_DEVICE);
>> +        else if (virtio_gpu_is_userptr(bo))
>> +            virtio_gpu_userptr_dma_sync_for_device(bo);
>> +    }
>>       cmd_p = virtio_gpu_panic_alloc_cmd_resp(vgdev, &vbuf, 
>> sizeof(*cmd_p));
>>       memset(cmd_p, 0, sizeof(*cmd_p));
>> @@ -812,9 +817,14 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct 
>> virtio_gpu_device *vgdev,
>>       struct virtio_gpu_vbuffer *vbuf;
>>       bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
>> -    if (virtio_gpu_is_shmem(bo) && use_dma_api)
>> -        dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
>> -                        bo->base.sgt, DMA_TO_DEVICE);
>> +    if (use_dma_api) {
>> +        if (virtio_gpu_is_shmem(bo))
>> +            dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
>> +                            bo->base.sgt,
>> +                            DMA_TO_DEVICE);
>> +        else if (virtio_gpu_is_userptr(bo))
>> +            virtio_gpu_userptr_dma_sync_for_device(bo);
>> +    }
>>       cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
>>       memset(cmd_p, 0, sizeof(*cmd_p));
>> @@ -1245,9 +1255,14 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct 
>> virtio_gpu_device *vgdev,
>>       struct virtio_gpu_vbuffer *vbuf;
>>       bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
>> -    if (virtio_gpu_is_shmem(bo) && use_dma_api)
>> -        dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
>> -                        bo->base.sgt, DMA_TO_DEVICE);
>> +    if (use_dma_api) {
>> +        if (virtio_gpu_is_shmem(bo))
>> +            dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
>> +                            bo->base.sgt,
>> +                            DMA_TO_DEVICE);
>> +        else if (virtio_gpu_is_userptr(bo))
>> +            virtio_gpu_userptr_dma_sync_for_device(bo);
> 
> This code is ineffective since the transfer ioctl rejects 
> VIRTGPU_BLOB_MEM_GUEST.
> 
> Regards,
> Akihiko Odaki

