Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012020.outbound.protection.outlook.com [40.107.200.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD3B4BF94B;
	Fri, 18 Sep 2026 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726404; cv=fail; b=e5szCyfelqfQA+r7c58j6Ki3aSaNRFisjn70ji/R/N1r6Gx8SX7IWKY4LTcbh1x+HN2paYCzkpeFQUln22wNOAtsrbHCccuqxhvbrqFr/FBajCdCR8jE9uF7CSYukiZtcKkM8lXqlyghmfxR4vxaQ5vvAkwShmHUBwNSmTzYfBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726404; c=relaxed/simple;
	bh=oXLky9XIg5IYND2CPS6v5TnnOhW7UjrOs2/iS5rg51w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f4Qo0SH0gif4JW5LzaKKrmzeSMxZ8NNvQ5l+DtzbfG2HIRuoVJ54k28wsNwRalQmG4G4+xcQFrHm+EOkmNxSr8ofJ8iSe2FNz6zE4XQsctqHNNvLXjc3zNxWY++W2lzf1idSvqr+LcDSMBhWKV5J5iIFyRrxmyDp7evKUQFa1jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R92lGRWZ; arc=fail smtp.client-ip=40.107.200.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R92lGRWZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8qi+0VP/fEGeE3QDl/LwwfPinlcf1KFFm53wtM1KwVLcdkHqL0Dhi73BDKR59vOkEdOLEK+8860fVINJlnsT0gy8OHGZCKycrvmJGwTpSTND25W/x+/GFagW42eq25r+NUYajyJcS/C6eBG5V9ijSpLFXqLlUiVUf/IOerb1dnDjzMeZpACdLEMV58hMpsYsI932U1mQpWgqv04gE3OZ1oVnCz9yEUlvuFVgI0rnYPegWnc0fkiEixk0Jfa4Yrh2322YXAexPTJCLoJiTnzz8zR7QMxN/xt3Sleld/xP0IraMLWKuoCaPI128ns68PaMOz9jrjQMT2HWK/qPtp3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwXvczs5hNhPRoiwgYZGyYAiX9hQzAIE2OM+XZfx/Dc=;
 b=isN5Bh7q75lIuf0rmepfw7IHAvUNb3FtPiAeQF4LGhClSb2zZ6foLx4dvyqqEt3s2H5YDjoPCzOp5eq8sZuBfF/Mi9o/QK1DMj/PBDXeKgU8UWVkSaXFjaxdFbYGw0+DrGPnoTR0p4ZM25ILBwSNJIsmIuV1sWYOSqdm1oHeS6mgef8+rnYdPWKXZ9HugC7RC9Hjz+SvhjP+iVCeSlauzjBOJruhraY+JS1kmUgwPRPU0h2K33i/2xM6j3xV2Nsxp/ixj6UqqyXVtsgGebl9yh5iDpgdPPBe+QYWdiThf3a7eW2JF6Oyf0G1gCxVRk0C27nGrO/0Fsrego1iOOj6ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwXvczs5hNhPRoiwgYZGyYAiX9hQzAIE2OM+XZfx/Dc=;
 b=R92lGRWZdAWoLY/FTEopWJjoQ6KI6nA8xPrUjyGMoZy4Cn0E3lkqcMQgHHj8g68gWMcuCcctb/nBCSmDLiFXqlF1VyEAEu46vqcIz3VhPS7yxkUoK/oBSVN4m5eVO+FTnbLchyu9ab0bfNo9PLJ44JK3d+RUwPZavHMXTke7QsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by LV8PR12MB9133.namprd12.prod.outlook.com (2603:10b6:408:188::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Fri, 18 Sep
 2026 10:13:15 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 10:13:15 +0000
Message-ID: <9fcb3203-63f4-4332-a47e-916774e11eb3@amd.com>
Date: Fri, 18 Sep 2026 18:13:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM
 capability
To: sashiko-reviews@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
 Eugenio Perez <eperezma@redhat.com>, dri-devel@lists.freedesktop.org
References: <20260918095940.2253018-1-honghuan@amd.com>
 <20260918095940.2253018-2-honghuan@amd.com>
 <20260918100746.2BB741F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <20260918100746.2BB741F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0043.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::18) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|LV8PR12MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: bbdf8a8c-f38e-4fb0-53b3-08df156d73d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hIJX/vzTF/n9+K6lVzbRZaAy8gvswl17qN5W63jtCi4pHEQJEXgdo47t+fa4Gp16FCPDLkl6tRxjgbz4sF5ZQKgU9YI3VYEP90mAnYM8jCmXDm4h64gfZbrsFcuAIwTEjrQY9F7A5nmz+tff8zQThVBpD8DC6VMD64yUVuPf+J8v2NuP49vAYUoNeZVmlGclXqeja3da2hCCS1S+DxakuJtbJbUXcsDEu8TcrUXIst3tO0Aj0V0oaBmsOqJNoGEAxCtx+tXGNe1RHDNEPllDHmiuNNz6TVPxhJfzNIMcHl4YOF0sYTeuDREU496WNsr57ysu1TdoWltlzJ5W3FYl1vzkmSsX7gATp48k+ec7nq7zCCdM71F4d9j16S9Sdmayg1Dn7ro9EEAmpgPXZWryAlIbF43FGY163Aic7imJNOkn9+n5Zsojqh2DXdfnIFD3b9FPjzl6fAho2aow9gO2QFxCSBGTm8B1I5c14E1Jb7B4zgIEcdeka7l6saLWyKZdtJVqHVVFxdvkET0TFnPoRvDn/BP2e2pTcMFywhGDfnyCpVGBzWmn71Z0E8nVk34e5wJiNEpwMtFnSZRRl1stra30PYzhPU0BwxXJEztpctJL6qEa6QJg7qyf/UYyYDGd/HznfPn0ydNZX51iMA6vmu5iCsatID4VmCbTaGP6fHU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1RrUGZQb21kS3dBR3NHZDdlU1VVOExLQmtLNlVmMVpsVzRaTFlUS1l0ZFVE?=
 =?utf-8?B?SXZCUjBuN0F4ZHhiNDlNdWdTeThBYTIzaE05V1NxR0Y1dzdXdEM4Z1V6OEtt?=
 =?utf-8?B?dVcvRnJiSFpCWFM0RmduS2pCeC9GRThJVG1laFhyWTd0K21scXBjZXBIODdD?=
 =?utf-8?B?SEozdGZrMFhCcXF3UjgrMHloYkV2TVd6clNOdXBSRENHd1c0bEFRZEFDQ0Va?=
 =?utf-8?B?T3RBOXZPWk90Z2dYNDM3T3pML1E2WUw5SGtybndvUmJzNVhtbk9pM0lLc3lt?=
 =?utf-8?B?Vy9UT3VxdGNqblNJY0M3dEx6WlJHYXZiN2dGWFU0UEN0UGx6M3Ftd2dPSzFh?=
 =?utf-8?B?dFdGM3h5cFM5U0Z5WVRzck10bzJZN3U5TDMzQ0ZSbGJ1S21rd25raTdVUnZq?=
 =?utf-8?B?c3JISys5L05jb2x5MHJQYWNVeUxKbUpZZWlEUXZTanZ6WFcvWjBYTGRkYUNo?=
 =?utf-8?B?MUNwN3AzQ1NjYUllUkJDTWhuemJyWkJRNHMwNnByK041MXFIVFp5ZHhhWDNk?=
 =?utf-8?B?dlBJRUZKQTdXNzdqdjJmTHpsV21Va0Y0aEk1Uk9SRnc3bDFRMkxJdExod2ty?=
 =?utf-8?B?dk5oeDZITzZQUGw1OThRRis3Tk9VSEJTU1RZeUloU01INFhYMlVtMDBvNElK?=
 =?utf-8?B?OFYyZTladk9iRU5oVkRpOHhmNUpCM1JTUFR5YmtMYisyZjVycm43amdrd3F0?=
 =?utf-8?B?YktBa3VKeTRwUEYxWGYzK3M4aFZHZ0lvT1ZSWEpnM2VSSjdPdGRSZ0NPbVNq?=
 =?utf-8?B?N0o2QXFDWE1lZWd2eG5oRzk5TUV6UlVaSnVTQm93Y2l4Zkt0aGN0Y09BWjdY?=
 =?utf-8?B?dE1YU3hsMXZtK1l1OVh3VU1QVGlUNmoyS2xwRVVxRkdFWDhwNVZqNmt1OTRv?=
 =?utf-8?B?T2lKR0ViYkNnYkFDOTJxVWg3d2N0L0dyTzNkZ25PUGVlUXBHRGt5YytVUWND?=
 =?utf-8?B?akQ1NXhsK0lqNTh1WGplbm9pR2YyZ3hwYWFHbUdIUHB1TDhac25WenpzNFU1?=
 =?utf-8?B?QmRqOXd3ZHF1bitvcDhreHYzRkVpMVlpNVBwUEFGMHZoRWgwYWc1Tk5mWVVJ?=
 =?utf-8?B?Z2g5cHVnZUZSTmVMQUhSM0VXbDJGLzdNYkI1NVErZnliSXJnbW9McmpOWDNP?=
 =?utf-8?B?RjkzUWZheE81T3Y3aktsanR6SUFRcTFJUUY4b2lJd1c3NW8rZkxlR1MwdHN3?=
 =?utf-8?B?SDNicWFCWldXaWJtYmpCWHh0dXVjeWhHS3pWcVBtRHhERTRXTVl0cUpIY2xz?=
 =?utf-8?B?MEFDUUUxUzVHck1HbjV0eUFFK0VzSG9NMW1WcG1aYmVvaGhCRHdMbnp3YTlK?=
 =?utf-8?B?VWs5QTF0c2k2UTQvcTJGNzBMc0plWEJ0amlLL2xnNkhWVVFYWGZBb2VkSStF?=
 =?utf-8?B?ZjFtSEJ1TExBMXB4ZlRSTjJUWmhXU0FYTzh3RmVXNC9kTHBWdmd5TkhUbnd3?=
 =?utf-8?B?Z2ZJTlpTbUovV09JM2ZiRmUydUJwbkh3Vm53MlJEMFVoc3FobnNaYTlFcmFx?=
 =?utf-8?B?eXVibkpZSDlrbzJYOFYxS2VuZkJnQmoydWo3MUV1ZWVlT3k1dG5FSVk3Ymln?=
 =?utf-8?B?UFpUbWVsS1RzUENEL3V2dGx0RnMyamZJcGlLTXEzQVpTY0JpcWxSc1l0N3lP?=
 =?utf-8?B?aDhIVHA5VThjbXVoa09KSWsvSVhhR1BOUnhJaURmREJ1bGNTVmUyTjN6Wll3?=
 =?utf-8?B?dlJRc2IxTk1VdTdyUUYzZGxxWFlhTDNLckxocWVuV3BPWFE0UXd3aTJDNG4y?=
 =?utf-8?B?ak5ITkRIbXFmeCtjWkZxa2NJRHhZVU5yMGFXL1BoUk1TZUJ4M0RRanl2Vkh6?=
 =?utf-8?B?cWM4RUtCanZOZUEzUVpmRVF0Wk9OdjNTa05DUTFFN3htTjJRaFM0ampVTWFL?=
 =?utf-8?B?SWRKdW9uR2Juc3hETUZicjRMT0hUaktyWWdHNHY5a1ZpU1dlQzRXUUNyejFx?=
 =?utf-8?B?bjZET1lBRlhiNDdRZHB4RVNWR3JaUy92MU4yVnhOWXR1OXNLQW54dTZlanpL?=
 =?utf-8?B?ZVFLWHJud1ZBcVJ0Rk9mTVphNzVjVGNkcUFuU1M0d0YxdExEM0ZERURuU1A5?=
 =?utf-8?B?bEdzUkhuNSt3SklTakJZNE5yaE0vMDJScHhTOE0vaER0UU5EV3VjZTBUZ0tT?=
 =?utf-8?B?VkU4RjBpbElBUGhGOHM2NmQwNUZzMFgvRi95RGs2b1RkVkhaaUw4aW1hU1V1?=
 =?utf-8?B?MlR1S2h3N05wT2F1UWVtYWZxMkg2eW55RDA5KzRyQU9pd1RtZGFsd2ZNeUJl?=
 =?utf-8?B?b2dCdTR1SlNNcUptVXM3eUtWdFk2dkU1d0F1ZEtpVFdsWWhzSXRhM0dIVXBJ?=
 =?utf-8?B?elhBSUZiWGhDZGc1RnVxUkZiTnE3dUpVdUYzKzZNZUw2d0JHUVNoQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdf8a8c-f38e-4fb0-53b3-08df156d73d1
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 10:13:14.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZqQeGr2tsAE3s1GX2GpSeVigfjq8IF5+eiXiqKdONi9tPK3PIk/Ce+dEHNqHWad0qJfrzWuMQzPa1UnBmATsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9133



This patch is for adding ROCm capset only, can be spited into another 
thread if it is needed.

Regards,
Honglei

On 9/18/2026 6:07 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] virtio-gpu: premature UAPI exposure of unfinalized capability ID
> - [Low] virtio-gpu: missing DRM UAPI alias for ROCM capability set
> --
> 
> commit a394228d77eeafc9f1dcc36150380f8561f1ee49
> Author: Honglei Huang <honghuan@amd.com>
> 
> drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability
> 
> This commit adds a new GPU capability set VIRTIO_GPU_CAPSET_ROCM with ID 8
> to support ROCm compute workloads. The commit message notes that the
> matching virtio-gpu specification change is currently in progress.
> 
>> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
>> index 4f530d90058c7..3d4dfadc9d789 100644
>> --- a/include/uapi/linux/virtio_gpu.h
>> +++ b/include/uapi/linux/virtio_gpu.h
>> @@ -321,6 +321,7 @@ struct virtio_gpu_cmd_submit {
>>   #define VIRTIO_GPU_CAPSET_VENUS 4
>>   #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
>>   #define VIRTIO_GPU_CAPSET_DRM 6
>> +#define VIRTIO_GPU_CAPSET_ROCM 8
> 
> [Severity: Medium]
> Is it safe to expose this speculative capability ID to userspace before the
> virtio-gpu specification is finalized?
> 
> The commit message states the specification change for ID 8 is in progress.
> Because the Linux UAPI is frozen once released, exposing this ID now could
> permanently commit the kernel to ID 8 for ROCm. If the OASIS virtio
> technical committee assigns a different ID or rejects the proposal, would
> this leave the Linux UAPI permanently incompatible with the standard?
> 
> [Severity: Low]
> Also, should there be a corresponding DRM UAPI alias added for this capability
> set?
> 
> Previous capability sets have matching definitions in virtgpu_drm.h, such as
> VIRTGPU_DRM_CAPSET_VENUS and VIRTGPU_DRM_CAPSET_DRM. Without adding a similar
> VIRTGPU_DRM_CAPSET_ROCM alias, userspace DRM clients relying on virtgpu_drm.h
> for the DRM_IOCTL_VIRTGPU_GET_CAPS ioctl will lack the necessary constant to
> query ROCm capabilities natively.
> 
>>   /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>>   struct virtio_gpu_get_capset_info {
> 

