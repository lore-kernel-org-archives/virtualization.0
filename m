Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481294D954D
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612629; cv=fail; b=gnCE5sQ81tmY5juM5bZ1dpq3siRhEtgPa4qlAEMXOeDzM+T1eUINw5rOicqDx6dzSEDnUG/7zqQsqRfgh6zm0NEMCDXU1UgE2tKGDxLsa+1HSSzQwj09Z7S8AHvzI7ixA2xqjNRvFuTbPqeUOOhh0zvyVuU4qBW9X20xpPgtDzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612629; c=relaxed/simple;
	bh=Lruz8dpDrf18njOfaZuUPfrJqg8/CARrF1ULXuKVFWM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ld/y9rgM89+JTsf8QE673IPUQH2MmIrKUvZjb8bbZOL5n1MngRvwHmI/OeZPNZZzYdZK5K7RuStfyTJcmRUZAsqU9OsDt+dGVDEx4cNIZao9ZFSVM2MGmVjyDZdZ9P44o/4kMNYO9ZphZ2ycOHdBII/E1Sp44dvKeZ8tjOfnqXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ReGHjd+G; arc=fail smtp.client-ip=52.101.52.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ReGHjd+G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnwyCPItXPKpReZW2Je+vZkn0B86wvRDwElIi5wb4vh04jd7qVkVOr/inDY+UOEBAk9sjS9rP0DXeMifkmdZ4/eMrsUYtKEFpgHIWDrxxoRt0Savz3MBVtdk6pslF+AlOS1Io5NWS9UTDMPxc51mGLJXk6JkeQ9cFkVuXfOfErobANMKIL7SGaA9YrVeLlgh/2GXEkdbd5t0TukSnnO56AMExfWmg24Lyo+Ssg78erBtcDovExKbURqx/i8+YbzDIdkY599ymUZQYyJyz432WtXu6TkYVIui4NuxeKlRC9G6k4vUhRRjC3SKqP9loNkJ77EWwTX3p4LGGIuRL/CboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gpg3D0taNDtLjx6aOJneUR+d6miA5jQHFfGDAEc7Flg=;
 b=OvkqcRTlIB5/ezWBz4WijaOfRhxxLubXVFsdCCrohtSeWQ2FhoP6UkkIaMJWGgKDXZOONyfktPSIgExOIhuL/uXUqBpaFO/1jUBZhY/Xds5CLLxQe1mOr+go9A9+lzRhwzdU8X/9MS2G8nkH6fIhyCVVv2s61dVRskW59sagk+UBnBiQaUqhTGnkO9WQsJVCsyvcLZ/6TWpnEPZkShaUN6wVGYJUFzEaHxjNnmPGK+cyrrYpWPDk+vK7FMUJrwNFeiYaSFB5U9nr4x2GWZH1G4jSuEjjFPXYp9nPZMlhZIT1hqPHt3fKk5UDNY2234ZuG+BSLnqeAyqQAwL1P8ZgmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gpg3D0taNDtLjx6aOJneUR+d6miA5jQHFfGDAEc7Flg=;
 b=ReGHjd+G+QDDY/N2xOIFRlLcAQYUhGg8so10i7QPcIjBCjAXmVpzdz/EVWlwO8jG+GYpD10Arm+iL6w7CTcf6mZ922MTxL0UJ/3KYfbqpI5tMNa7XKSOJ4i3rw6nTbIbN6Vgo+z+2YMaj38FMJulrw8voPilPUXL01JFhXTuruo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7183.namprd12.prod.outlook.com (2603:10b6:510:228::20)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 16:23:44 +0000
Received: from PH8PR12MB7183.namprd12.prod.outlook.com
 ([fe80::d54c:d13c:6346:4009]) by PH8PR12MB7183.namprd12.prod.outlook.com
 ([fe80::d54c:d13c:6346:4009%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:23:44 +0000
Message-ID: <c8ad52ce-d872-4a4f-a261-f907f0d8af30@amd.com>
Date: Tue, 29 Sep 2026 00:23:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 4/4] drm/virtio: wire blob ioctl creation to
 userptr objects
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 dmitry.osipenko@collabora.com, airlied@redhat.com, kraxel@redhat.com
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Ray.Huang@amd.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-5-honghuan@amd.com>
 <88d78717-d935-4c7f-a123-c6ddff761e97@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <88d78717-d935-4c7f-a123-c6ddff761e97@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To PH8PR12MB7183.namprd12.prod.outlook.com
 (2603:10b6:510:228::20)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7183:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 9deda296-fca8-4c7a-c94e-08df1d7cddd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|5023799004|11063799006|6133799003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	+DuDn59mf+E6nBUkOOHhbpJL0u+NW2Z6hlBIUeY/m/4BQv6riqrCfKmP37etohOlxLEgkIBcb/UwB+B0yu6dxNWG0Heix7IbdNyw/Ym6RynML76N0sbbSJk47qI02eQUBgT/sUz28mpEG37FljN4lxH2qBiFrp2txcOFtjj5gqxBa4jXTqcTLzjadNmcZVsNdjf9bhyT0nK7b0nMM6eDZrU0ndEuA7ihB+sNY60INadBEjMKBHIALdv0RQeNzg20JKKl8ObDtgslLQx3pa542aH11APzaR9ttfQETiiKXH0weww3AxcySFpL8gJYYSeYosBbUYO9WGO5BfH0VnKf8fqJM+AUgeLKV5VMioLRLdw9YAg9ry5wfskHHG1EBUKMbi8roew88Kor/orZjsG1eD+HoUD5nTYZQcVyeZLJtZ6G5CH89f4NjBPGcI4oufNB0wIaT5caYz4L5alZ1PgVssv9Ba46g+8j4l4n0UoXp8bIJG9OQixyeJAfldXpX514MxXcn0YSK4fP3N33vtno2m2n4fDIa6TxvOyggoc6MDb+vhPv8L4jYkZ1HeMXU/XmiFqQWiaoS7jxekN8aJWXXp3RBTqcVZh/af7yKOYKonOxVWxY1aZSwcoIi43Hw/azxBLhDqYC0ofpAfgCABHkRHh0Q498QIval0OXrg8DJzo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7183.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dStQY0NRS0xwVklFNmlaV05Lbm1ZeSswclJWNGxzSWM4dmpJdUxhK1dlWWJG?=
 =?utf-8?B?WnlPWlNlVnFHK09KZk00am1peGJQcjg2RUlFdFBxWjZ6Qm82YUFjRlVzc2w0?=
 =?utf-8?B?RUNNVXhzem1TWUZpMVA0RzJEY0pRZ1o1eEdnSDVuNUNkVXpURTFvTkRhN2hU?=
 =?utf-8?B?OWpLUE0zd0RUc1B1UlpKMzU5RFdJSldVb0tUMnhsUURWSVdBSTJNSWEyK09q?=
 =?utf-8?B?M2hpdCtHWjRUWEhNRUIzRyt2a2g4S0YzdnJHR1JTbEVDSFlwMU1DU0FxMDhC?=
 =?utf-8?B?S3VmZmQydHJ1eHBhYnZ6WUQrK21WSkxrSVFxRDdoTzkrTHFnWE1YNmd6b0dv?=
 =?utf-8?B?RDdqRks1TTdheUNjWWswRElzUEorZnpZdHJCSVFIUHhIbDFMOWIwNlVuSFpm?=
 =?utf-8?B?QkZrdnZZYnNjWklmNnVYU2xuWUtDVDJySVZBRTFTMFdYVWtCRDF2dUVWdmpB?=
 =?utf-8?B?eEwxazVwNWZ6Q2N6LzJyaHBSUENlajhlY1B1UTAvRzEvRWFqcFpqN2FnRXk4?=
 =?utf-8?B?eHpIWFExSHhwS2huNWQ0MXBjVzE2K1NPbkhYUjZTbk1EV3ZKS3JWTUdHQkV6?=
 =?utf-8?B?Y3NibHNtd1B3UzVxOXlYYUNKRWtNZ09lZFFtck5GSHZYc3JZN0Z0blFSRXlP?=
 =?utf-8?B?TjBOaWdTV1RPMGNNZWJ0UjJncVpTNktNUTBEUVY3VFJVKzJORWEwSXhRU09m?=
 =?utf-8?B?cjFNVzZOdzliSkFvaXhvVGRWZDIrWEg1dnJyVHB1ODVaMGZqQTVpMkZCS2JR?=
 =?utf-8?B?SndoaVAxVGtzUE5mUTh3aUFSYXlIT1UvVndzcURuNms2L2NFZDJUQnRkWXpS?=
 =?utf-8?B?RVVjUFNZY01MUnRLazMyMno5dVh6eWVsQVE1YWluaTdQL2pkOElFWG5vQTNm?=
 =?utf-8?B?OG0vRUpDK0tTSTl6NHZoQklLYTg2WEZBZEtPSHAxZkZvaU9Ld2V1S0tzVWV3?=
 =?utf-8?B?MzRlQjJkRThwRkhENjFQOGpnQ2prZUVhSjR6Q0FOeE5SdFRwU05PSGxYNkRT?=
 =?utf-8?B?WW5uWjBFalJHMjBuOEdKbXVGU0ZJdk1yQ1RnQUg2b2srNzgzMWxZQUkrVnZo?=
 =?utf-8?B?YlFPK1VhcW9XVFZ3dXoveUVXUEswUHlEQ0krbEE5WGF2K1c4aUtaazJqTG9r?=
 =?utf-8?B?YmYyV2p5SVk1bDFmUHFEVDBJUHFJVy83a3JwRnpaL3g5ckpCT2lRWkpPbnFZ?=
 =?utf-8?B?UUxMN3RXbnhpaWlndTljV3J5N2VGT290amg2UGtoQlF3UEljS0VETjBPakpi?=
 =?utf-8?B?SGVzSTZWSzlYNG9PakNmc0gySE1ldEJEbmVMOHVySGxFZXZWTXpHSXZNZmlp?=
 =?utf-8?B?Qk9BNWo5NlZBZE1MRHNVVEVidzBjWm5tSitMamtyRVgxZTFMbmNlMW03N2VM?=
 =?utf-8?B?YmpwclVRUWxZNWcxY0IvTjh6NFlTMVJ5NGU4Q2pRblZwejI2L3dPR1B6bGpQ?=
 =?utf-8?B?bWNiSXNPK1lUVm80Mk5HMitlajhkNWN0NjJrTlhiYWtvalBCSjNyNHFua2M5?=
 =?utf-8?B?SEx3ZTVrckRIMVd4ZFdkN2d1ZVpMakJSMlJZM096Q05ieG5vWFV3ZVRZNGtR?=
 =?utf-8?B?R0VQa1ZLWGEvcGpHSWJvdURid2xSS25ZcDJ5SXYyMnFUZWxySVpZNXZCUllY?=
 =?utf-8?B?OEQ3eml1Ykk4M2RFNnZIcyt0SklVT3g0VHNjSS9TWkU5QjhJcXdEbnZrNnYr?=
 =?utf-8?B?S3dqdzZWKzhML3hYT2hYRGNnVGEzazgwSUV1RTJBNmt3S0l0UGNsbkZyMkVM?=
 =?utf-8?B?WmZhUUZITnl6T056QXFkVXB1a1BPZU1lWTZiK0JFaWltTmNKRDNXRlUrQVVk?=
 =?utf-8?B?QUhNSUpkaFVreGFCeTJueTd3MFRnK3FpMkVSa1gyOFM2czYxRmN1S2drc3Ax?=
 =?utf-8?B?aG1FU1lPVHhNc0pFN29Hd1hBTjNXOGRwdGxTNUo0NGEzdmEralE0ZmxtUXBR?=
 =?utf-8?B?TG5JS3NuV3A4dmR5cUVrMXVlUEtKekZ5UTFNMDg5S0Vpa3VqZTVQb1FzRGo5?=
 =?utf-8?B?TFVYSGtpRUk2cHFRMU1WYVJnTGx4VEpyYWxJOFR0SVNTZnBCREtRQUNBZm5M?=
 =?utf-8?B?Qis0dXFmUlpwLzZpYi95OXdHMTA3SENBb2l0NnhObUNhSXk4TFJWdU1EYUo0?=
 =?utf-8?B?N3FEMzVoODJucU1EaVBsZXdwQmxWQWhyVHB2aTdZNlUrVmdQVDlLQkltOWJm?=
 =?utf-8?B?RmFJOUgxL2t5NkZmYlBrYjYwZlNpbEUrWiszMWtvMmRmNHJYTUh6SWNpZUN3?=
 =?utf-8?B?VTNwV2dFeG92UGFJbVRTNDBMYXNyTjJwTmFVaGpSdWcrUjl1R1NRM2FOaWxj?=
 =?utf-8?Q?U3CoeBFDyILzc4HuX6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9deda296-fca8-4c7a-c94e-08df1d7cddd7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7183.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:23:44.7207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: reuIJhkbLOaU4PyugeJHD8+ySOtX/mbEaHTZUA4p1hhr4ByxiAqnMDSesQUKhikwcg+m800sbRT6ZXz9lNmnSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105



On 9/27/2026 9:04 AM, Akihiko Odaki wrote:
> On 2026/09/24 18:55, Honglei Huang wrote:
>> Integrate userptr into the blob resource creation ioctl.
>>
>> - A non-zero userptr selects virtio_gpu_userptr_create()
>> - Reject userptr unless blob_mem is VIRTGPU_BLOB_MEM_GUEST
>> - Reject VIRTGPU_BLOB_FLAG_USE_READONLY unless the device
>>    advertised VIRTIO_GPU_F_BLOB_READONLY
>> - Advertise VIRTGPU_PARAM_USERPTR and VIRTGPU_PARAM_BLOB_READONLY
>> - Add VIRTIO_GPU_F_BLOB_READONLY to the driver's features[] array
>>
>> virtio_has_feature() routes device-specific feature bits through
>> virtio_check_driver_offered_feature(), which calls BUG() when the
>> driver queries a bit it never declared in features[]. The
>> VIRTIO_GPU_F_BLOB_READONLY probe added to virtio_gpu_init() hit
>> exactly that: every probe crashed regardless of host support because
>> the bit was missing from features[]. Registering it there fixes the
>> crash.
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/virtio/virtgpu_debugfs.c |  1 +
>>   drivers/gpu/drm/virtio/virtgpu_drv.c     |  1 +
>>   drivers/gpu/drm/virtio/virtgpu_ioctl.c   | 35 ++++++++++++++++++++----
>>   drivers/gpu/drm/virtio/virtgpu_kms.c     |  8 ++++--
>>   4 files changed, 38 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_debugfs.c b/drivers/gpu/ 
>> drm/virtio/virtgpu_debugfs.c
>> index 3a68a16b58..b8b9b40584 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_debugfs.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
>> @@ -55,6 +55,7 @@ static int virtio_gpu_features(struct seq_file *m, 
>> void *data)
>>                   vgdev->has_resource_assign_uuid);
>>       virtio_gpu_add_bool(m, "blob resources", vgdev->has_resource_blob);
>> +    virtio_gpu_add_bool(m, "blob readonly", vgdev->has_blob_readonly);
>>       virtio_gpu_add_bool(m, "context init", vgdev->has_context_init);
>>       virtio_gpu_add_int(m, "cap sets", vgdev->num_capsets);
>>       virtio_gpu_add_int(m, "scanouts", vgdev->num_scanouts);
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/ 
>> virtio/virtgpu_drv.c
>> index 2aaa7cb080..f1edd20c37 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
>> @@ -182,6 +182,7 @@ static unsigned int features[] = {
>>       VIRTIO_GPU_F_RESOURCE_BLOB,
>>       VIRTIO_GPU_F_CONTEXT_INIT,
>>       VIRTIO_GPU_F_BLOB_ALIGNMENT,
>> +    VIRTIO_GPU_F_BLOB_READONLY,
>>   };
>>   #ifdef CONFIG_PM_SLEEP
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/ 
>> virtio/virtgpu_ioctl.c
>> index 3d8e4ccdb7..3dc058e50e 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>> @@ -36,7 +36,10 @@
>>   #define VIRTGPU_BLOB_FLAG_USE_MASK (VIRTGPU_BLOB_FLAG_USE_MAPPABLE | \
>>                       VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
>> -                    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
>> +                    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE | \
>> +                    VIRTGPU_BLOB_FLAG_USE_READONLY)
>> +
>> +#define VIRTGPU_BLOB_HINT_MASK DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING
>>   /* Must be called with &virtio_gpu_fpriv.struct_mutex held. */
>>   static void virtio_gpu_create_context_locked(struct 
>> virtio_gpu_device *vgdev,
>> @@ -122,6 +125,12 @@ static int virtio_gpu_getparam_ioctl(struct 
>> drm_device *dev, void *data,
>>               return -ENOENT;
>>           value = vgdev->blob_alignment;
>>           break;
>> +    case VIRTGPU_PARAM_USERPTR:
>> +        value = 1;
>> +        break;
>> +    case VIRTGPU_PARAM_BLOB_READONLY:
>> +        value = vgdev->has_blob_readonly ? 1 : 0;
>> +        break;
>>       default:
>>           return -EINVAL;
>>       }
>> @@ -453,11 +462,23 @@ static int verify_blob(struct virtio_gpu_device 
>> *vgdev,
>>       if (rc_blob->blob_flags & ~VIRTGPU_BLOB_FLAG_USE_MASK)
>>           return -EINVAL;
>> +    if (rc_blob->blob_hints & ~VIRTGPU_BLOB_HINT_MASK)
>> +        return -EINVAL;
>> +
>>       if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
>>           if (!vgdev->has_resource_assign_uuid)
>>               return -EINVAL;
>>       }
>> +    if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_READONLY) {
>> +        if (!vgdev->has_blob_readonly)
>> +            return -EINVAL;
>> +    }
>> +
>> +    if (rc_blob->userptr &&
>> +        rc_blob->blob_mem != VIRTGPU_BLOB_MEM_GUEST)
>> +        return -EINVAL;
>> +
>>       switch (rc_blob->blob_mem) {
>>       case VIRTGPU_BLOB_MEM_GUEST:
>>           *guest_blob = true;
>> @@ -495,6 +516,7 @@ static int verify_blob(struct virtio_gpu_device 
>> *vgdev,
>>       params->blob = true;
>>       params->blob_flags = rc_blob->blob_flags;
>>       params->blob_hints = rc_blob->blob_hints;
>> +    params->userptr = rc_blob->userptr;
>>       if (vgdev->has_blob_alignment &&
>>           !IS_ALIGNED(params->size, vgdev->blob_alignment))
>> @@ -518,9 +540,10 @@ static int 
>> virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
>>       struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
>>       struct drm_virtgpu_resource_create_blob *rc_blob = data;
>> -    if (verify_blob(vgdev, vfpriv, &params, rc_blob,
>> -            &guest_blob, &host3d_blob))
>> -        return -EINVAL;
>> +    ret = verify_blob(vgdev, vfpriv, &params, rc_blob,
>> +              &guest_blob, &host3d_blob);
>> +    if (ret)
>> +        return ret;
>>       if (vgdev->has_virgl_3d)
>>           virtio_gpu_create_context(dev, file);
>> @@ -538,7 +561,9 @@ static int 
>> virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
>>                         vfpriv->ctx_id, NULL, NULL);
>>       }
>> -    if (guest_blob)
>> +    if (guest_blob && params.userptr)
>> +        ret = virtio_gpu_userptr_create(vgdev, file, &params, &bo);
> 
> After userptr creation has pinned pages, charged pinned_vm, queued 
> resource creation, and registered the object for restore, the [handle- 
> creation failure path calls drm_gem_object_release() directly. The UUID- 
> assignment failure path does likewise.
> 
> That function releases GEM internals; it does not invoke the 
> object’s .free callback. The userptr pages, DMA mapping, memlock charge, 
> and host resource therefore remain unreleased, with no userspace handle 
> available to close them.
> 
> These error paths predate the series, but this patch routes long-term 
> userptr pins through them.

Will fix it in next version.

Regards,
Honglei

> 
> Regards,
> Akihiko Odaki
> 
>> +    else if (guest_blob)
>>           ret = virtio_gpu_object_create(vgdev, &params, &bo, NULL);
>>       else if (!guest_blob && host3d_blob)
>>           ret = virtio_gpu_vram_create(vgdev, &params, &bo);
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/ 
>> virtio/virtgpu_kms.c
>> index 1d4d3bf46a..06c2bded49 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
>> @@ -249,15 +249,19 @@ int virtio_gpu_init(struct virtio_device *vdev, 
>> struct drm_device *dev)
>>           vgdev->blob_alignment = blob_alignment;
>>       }
>> +    if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_BLOB_READONLY))
>> +        vgdev->has_blob_readonly = true;
>> +
>>       DRM_INFO("features: %cvirgl %cedid %cresource_blob %chost_visible",
>>            vgdev->has_virgl_3d    ? '+' : '-',
>>            vgdev->has_edid        ? '+' : '-',
>>            vgdev->has_resource_blob ? '+' : '-',
>>            vgdev->has_host_visible ? '+' : '-');
>> -    DRM_INFO("features: %ccontext_init %cblob_alignment\n",
>> +    DRM_INFO("features: %ccontext_init %cblob_alignment 
>> %cblob_readonly\n",
>>            vgdev->has_context_init ? '+' : '-',
>> -         vgdev->has_blob_alignment ? '+' : '-');
>> +         vgdev->has_blob_alignment ? '+' : '-',
>> +         vgdev->has_blob_readonly ? '+' : '-');
>>       ret = virtio_gpu_find_vqs(vgdev);
>>       if (ret) {
> 

