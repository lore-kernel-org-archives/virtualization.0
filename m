Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66EE340D9D
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789221355; cv=fail; b=r7IqXJK9Ll+oBhC4apuHCgNaiisR/YwHTOS1Kv9cVQdD0l5U5bKhhxWRMnrXJ29kNwuJxnBFnOOsgONnzzYBnHkIL6oFeScVdPEkPWq0bSGl6EcQxeTgyN5Fcnsed2Ha+yCYq9t52Ak+guplGViRq8/rlzsT/v/4WxmfXfHpnrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789221355; c=relaxed/simple;
	bh=OXWHymvX7vPQvguQ3sS2BdYBqxihBdRmtt9CRroPZLM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K9NunH2dHsusqJWwzmSh696/ipOddhjthsm02aZEvX2ejE5/FoptztpQelW8wSz45qZMrwiGfYJ+EcTLvL5DsCBLBT4i9fK/ChTr5tmM11Oe+zs+mYqrtao94+/JHi3g1GIE2xNa2VQlE/2M7VyxlJuTOU2TI8RBmC6xiDITOZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WqinHghY; arc=fail smtp.client-ip=52.101.52.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WqinHghY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i63v9K7PpVJgayr0jMO5CBrNlSvQU9r0TUEfyWXUYVZpJB1kwH9cJmU9aDYm3/8cPaoth/Yc/bA+OaXNUzO8xgTrJtFwEwFofp/14OUnmDvy4uvzO33ipUZeoAD+0y1EkTDvngjT2lLcNRnmYeBf2E1t0Hn161MiQ7pToIFNJGcWYRTO0isdS677Laj54jFSBCtR2e0yaI6svThiygaVMt1Moy6dWH9vRiSSJN/fjJNBLNXS3iAvuTNc44tqC18oeOP7AhNfi6/TmyQ5BNC3BkxBps3Zk445J5ODPjNbPC/8yqVHtXzb1PNGlcl/boSEOkAryKBBmLY4aiUZnA82Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltZpjztgfXffUkqg6cuXRmg/mXqrlVgDE5gzl3uvtHo=;
 b=zVDyp633M3RsguWqiccQyWP/7mGs7YmkoFTGGVie7C618cBJXYSqbI2WHFx7i17V2QYSo3qnJ9cq+eU2sVVlNb106YA6/EW+LxUfNd4nHenbKthyd/BMmvYZxN+rHBY7jgF8M1vSS/7FCeIGjII9hjwK6+IFtQ0mBuzn2xLlvJy2Q2vtzbLFo7X1KxCothqoXPabFRqZba+wj+A8zWdeSJzwbBCpZbE7EpYgfw8WfKOTPZKY5vsg+Hr+/miNWRMTH4L6yyUZ8f7R8o5+VmqPjT+xZSQOL6jAsa/R2JeRa9f5W8s7VDCi+wcEQhbEKeTHSYZcPmPb1vTt+lBZIaoemA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltZpjztgfXffUkqg6cuXRmg/mXqrlVgDE5gzl3uvtHo=;
 b=WqinHghYxBsoNSCGnq9wuc2UWDwaop4socVRmUoNqzJ2kuYu8koSy+IWeEOzvptPMIiBRQHil0rrgIrKk4OJwbOR+UoiOZMUqZpBgIApTX+iZ1wfd7A5Kg+EmD/O1930ZiqmclozHhfOSMVW2IUdWD/00rSU4j339wAhWc2KdHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Sat, 12 Sep
 2026 13:55:47 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 13:55:45 +0000
Message-ID: <d9365eb7-4142-4893-8d4b-eb4fadab0803@amd.com>
Date: Sat, 12 Sep 2026 21:55:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] virtio-gpu: Add userptr support for compute
 workloads
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 odaki@rsg.ci.i.u-tokyo.ac.jp, Chia-I Wu <olvaffe@gmail.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Honglei Huang <honglei1.huang@amd.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Ray.Huang@amd.com
References: <20260115075851.173318-1-honglei1.huang@amd.com>
 <b624e1a8-e957-48bb-9ae3-93215d764e53@collabora.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <b624e1a8-e957-48bb-9ae3-93215d764e53@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 59213728-e0c1-4ff3-aac6-08df10d58a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|4143699003|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+zL70aixjpsnDINrVNA+ZDnKY9+2FjtFIiH45EJDWWwIsgVDiJz5OlAWzCDe/4/ki570DbCtxxJNGvsj8khNTV4vUEcpsLPecQKCb+xrDH/eLfQdzMndZRZ4U8ASDDHBQ+ojAbtQkAyLkteKyiOoVGTJG3NDVJKs/2PwRHy3S2rSuGGX/BhI7g/9BBkL7AlkI74sCIrW1OHXnC7FzweFcAGGaM/vcx1UO4jZXaVyAMR5I6AN1YpEK3t1vtCKt9EAqlSIa2z7y8f4z02XmpzWaUGDPAyyIo2PHjb55RUPxZgHfGIP3ETmHYbRQqDQbMEWEl/CGC1YrnIJIGLChjt7FnyaS7v9QYSQwqb0PjCeaEHOnB2JYjKSaLoOb4Aji7ne9nWInrC9WEi6Kdu6cSW2vV3EzZ12Arr/kASWDGqzrhpqoi4ZjREeDlqXPGnepJE88Og6bPgkSlwcuNpHf0TmSdNRO7KcqMOoE8cl/JAEbH8FPcjmHw3bzDKYkwO8GuCJ8OH6v41KCWVAzH74Wdq92vxQExgHir4o8A0bx2InajnZULOGQVpYRSnYfap628mK2CyZIHNfBH4TCy1M3pVfet0YXEC2QrNZIc3bM+r+vsl1tngexTfPKBihTxAEEegL0rOuOs+GtnXWHUwSc95KUJ47r6fZc+1fZKsQiH1NlDQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y01HS1JYQ1YvMjZuSnpVQzBBQ2IxRVN5T1BnT01pdGtDQXA2SzVXeEtXTUhO?=
 =?utf-8?B?ZUtJdHdYdkhYanFGZE5KellvMlNXRHVwTXJqaitDR2l2cTQ1WnBlYmFtdkZV?=
 =?utf-8?B?d0xqNmhxdVY2R1phMytESy9XaEQvQ1lIZWVXQU5jd3hKby8vVzQ5cS9kR3Ax?=
 =?utf-8?B?Wk5aRUEyQk5RWjh4cnJUREtGcHBQdTRqLzByTjNOV3J5Z2ZHaVpRWndER05U?=
 =?utf-8?B?clFIbHNpMFhPZWJwY1BnczFmSTRGQXcyckdCM3ZMc1lMZVlPdzJpeVpHV0Z1?=
 =?utf-8?B?RVlMZVVLNTZiUWFDOFF3aTN3SUxGcUVWcnA4c0ZiMVJjZHRkRms3OTFicllK?=
 =?utf-8?B?WnJwdkdNUXcyNU5RQW90cGc1KzBUT09SN0NVRlc0d0tDK0t1WmZRWWFtYjJt?=
 =?utf-8?B?V1BzcDJDS09wVzBGeW9SNE4vSVhqczFNbnpXaXFpelZHZWt1MHRDdEtSWFBr?=
 =?utf-8?B?ck5ON0lNSmxQTmNOekQrcSs4Z1JNMXhsME1rc3dUTi84UzBPYXc4RTcxeGJM?=
 =?utf-8?B?a0t2ZUorRzFoNzh2Yk1iOWdoWlJ6bE05WUVyQnZNL2xrWldSTTdYRlpRSFlo?=
 =?utf-8?B?bUJDWkpFbU5WRGY0dXl5cGpaZlZWZWNGRmpueXNwVlI2S0JOK2hPNmhocVpi?=
 =?utf-8?B?SkdxaE81UDBYRUxSb2RDVnFKRDRGU3RVRGl4Y3lxTHFsM0NaaUJtb1dVemYv?=
 =?utf-8?B?SjZzNEFubStwcGptTUtIZHJ1Z1ViNVlNYnRXTjJSMUF1d3dZeDNobzQrbzlm?=
 =?utf-8?B?UjFPeS9LcWszMmZYUTFIVG9FLzJjTi9uUXhMR3VnQkRUWjI5MTFENENQUE16?=
 =?utf-8?B?bUVRRWlMM3pjeVd2NmtzL0ZMRG5hVk95YmV6Uis0dTlTVEdVQlNYMlVXZDhj?=
 =?utf-8?B?NHU3M25ObVZPaGJtWkNFYnFBRXFTcUZkY1NtTTBuR29QanRIOHNEdzVpTTd0?=
 =?utf-8?B?MjA0ZXZRa2djbHJXMlRkT3I1dU9BSVpXK2FZT1I2M3NibE5KMU1oVlJyY01E?=
 =?utf-8?B?UEN1U2NlczdlN0JxVlNFaGUwTTVEbmloa2F2NGpTT2FwTVF2TklzWFdkbWRs?=
 =?utf-8?B?NlNkWWZmU1ExYkVBTUJNcmIvQVZHSkpXMnY4TkNhNnkwSFczbnVrTUdKWWF2?=
 =?utf-8?B?NTdpVjdGWTVmY3EzRWZxWlJPdVZBZ3o5eVpjSGJnMSthaUlENTBKaE9LdHFq?=
 =?utf-8?B?TkFOMnpsTHllVm1UY2d5MFV2S3pKc3hQMDVOR3gxZ0ovUjY5czlLelI3TXlz?=
 =?utf-8?B?czhHNm9WQWFtZzJvdVZ0NnN2SkgrL28wV1hyMFhSUzRGQnArVGVxTTBkYjVo?=
 =?utf-8?B?YlFFUnZPeitHRmppUHdsa3U0TGdCQ0MrNzN1TG0zUlZGeU51Y2QyWEMzZjRj?=
 =?utf-8?B?ZjY4MXp1VHFCM1FWSkczVkplT2NQK0QxaFVMdTFhMkZXUlJSaEF0bUpPS3hn?=
 =?utf-8?B?L0ZncTNXMHpzTTdNTG1QVk5CNWo3YnpycU5SNDlGL3BEUkpINWdMVFBDZHRy?=
 =?utf-8?B?SFRiVzh3d2M4YzlERmRvQytnVDNodmVjTXJSV1FicXdjTGF5ZDJhVFlyc2RZ?=
 =?utf-8?B?NnpSRmtEaFNxWk9sdjkySmZMckpyYUJPNDBtTkxGT0NYWXF2eGhFWUowaFRR?=
 =?utf-8?B?ZEpNSDlpOFpXUEZGTFZnVTFQaXJNcDlvRnB1TUxOTnpPYTR6SkNvdWl6NUZN?=
 =?utf-8?B?UHBMQkYwREx5UXJvTERGSzQvZm52VG5VM3RaaU5kR04zRTlTU0FBanNlRks2?=
 =?utf-8?B?aVlrTkFHaVMwM2RURmRCdm5ueUtJYU1ON3NiK0RjOXRhdGk5TURyTTVESUE1?=
 =?utf-8?B?VXcxQ1hFekVaVlpJdlZneVovUG1BNXpkTXloUEFVY1k5Nzl2TE15WTc4S3Zv?=
 =?utf-8?B?WjdYTmU0cFk3T0lkOFN1TGZkY1YvNXJZTXRSWFdzd1Q4QXI1eEhRU25iZmlo?=
 =?utf-8?B?VFZMbWlKdDZXVlVReW5OSXFXNWF1clQ5MHNTV2hPdjJrK1JyMks3MXFwVUM5?=
 =?utf-8?B?UXc3N2N6dVZXdXE5Y2RUQjZSd3p2cEFjSlU1a3M0MVA4TnFWZUFmcEFOMEtY?=
 =?utf-8?B?N3JZMVM1ZUt3dkpINmFIMnUzV2FWbmkrUGRab2VGVzBxS1Nyc0ovUTMyMTlG?=
 =?utf-8?B?YlpSZ1Qxc0VoZUtYOHNMMzZ3Ny94d2luZS85b0VjdWRnUGcxRjQ0U1h1cFVO?=
 =?utf-8?B?YVNwTEgwMmpZdWw0ZXFuVWZGM1lEV09LL3NCS1N5VWFmWmpnUFpwVTR1M2pX?=
 =?utf-8?B?VDlzZkdzSkUrR2czM1U0KzhzZjgySVFRVVU3L09DazJ0aVVCbWlJdWpSZXd2?=
 =?utf-8?Q?BDe/mEkZB4kbq20mQr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59213728-e0c1-4ff3-aac6-08df10d58a9c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 13:55:45.3354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goy+oXiecBJCCPgFOcHEpXa33+RqpjfM8qu8WlLlbptX2oWkc6ObIK4kGps9Nze0r7ZZYSs+Ss8nR3HC+hkqEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452



On 9/11/2026 10:47 PM, Dmitry Osipenko wrote:
> On 1/15/26 10:58, Honglei Huang wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> Hello,
>>
>> This series adds virtio-gpu userptr support to enable ROCm native
>> context for compute workloads. The userptr feature allows the host to
>> directly access guest userspace memory without memcpy overhead, which is
>> essential for GPU compute performance.
>>
>> The userptr implementation provides buffer-based zero-copy memory access.
>> This approach pins guest userspace pages and exposes them to the host
>> via scatter-gather tables, enabling efficient compute operations.
>>
>> Key features:
>> - Zero-copy memory access between guest userspace and host GPU
>> - Read-only and read-write userptr support
>> - Runtime feature detection via VIRTGPU_PARAM_RESOURCE_USERPTR
>> - ROCm capset support for ROCm stack integration
>> - Proper page lifecycle management with FOLL_LONGTERM pinning
>>
>> Patches overview:
>> 1. Add VIRTIO_GPU_CAPSET_ROCM capability for compute workloads
>> 2. Add virtio-gpu API definitions for userptr blob resources
>> 3. Extend DRM UAPI with comprehensive userptr support
>> 4. Implement core userptr functionality with page management
>> 5. Integrate userptr into blob resource creation and advertise to userspace
>>
>> Performance: In popular compute benchmarks, this implementation achieves
>> approximately 70% efficiency compared to bare metal OpenCL performance on
>> AMD V2000 hardware, achieves 92% efficiency on AMD W7900 hardware.
>>
>> Testing: Verified with ROCm stack and OpenCL applications in VIRTIO virtualized
>> environments.
>> - Full OPENCL CTS tests passed on ROCm 5.7.0 in V2000 platform.
>> - Near 70% percentage of OPENCL CTS tests passed on ROCm 7.0 W7900 platform.
>> - most HIP catch tests passed on ROCm 7.0 W7900 platform.
>> - Some AI applications enabled on ROCm 7.0 W7900 platform.
>>
>> V4 changes:
>>      - Renamed VIRTIO_GPU_CAPSET_HSAKMT to VIRTIO_GPU_CAPSET_ROCM
>>      - Remove userptr feature probing cause it can reuse the guest
>>        blob resource code path, reduce patch count from 6 to 5
>>      - Updated corresponding commit messages
>>      - Consolidated userptr feature detection in final patch
>>      - Update corresponding cover letter content
>>
>> V3 changes:
>>      - Split into focused patches for easier review
>>      - Removed complex interval tree userptr management
>>      - Simplified resource creation without deduplication
>>      - Added VIRTGPU_PARAM_RESOURCE_USERPTR for feature detection
>>      - Improved UAPI documentation and error handling
>>      - Enhanced code quality with proper cleanup paths
>>      - Removed MMU notifier dependencies for simplicity
>>      - Fixed resource lifecycle management issues
>>
>> V2: - Split add HSAKMT context and blob userptr resource to two patches.
>>      - Remove MMU notifier related patches, cause use not moveable user space
>>        memory with MMU notifier is not a good idea.
>>      - Remove HSAKMT context check when create context, let all the context
>>        support the userptr feature.
>>      - Remove MMU notifier related content in cover letter.
>>      - Add more comments  for patch 6 in cover letter.
>>
>> Honglei Huang (5):
>>    drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability
>>    virtio-gpu api: add blob userptr resource
>>    drm/virtgpu api: add blob userptr resource
>>    drm/virtio: implement userptr support for zero-copy memory access
>>    drm/virtio: advertise base userptr feature to userspace
>>
>>   drivers/gpu/drm/virtio/Makefile          |   3 +-
>>   drivers/gpu/drm/virtio/virtgpu_drv.h     |  33 ++++
>>   drivers/gpu/drm/virtio/virtgpu_ioctl.c   |   9 +-
>>   drivers/gpu/drm/virtio/virtgpu_object.c  |   6 +
>>   drivers/gpu/drm/virtio/virtgpu_userptr.c | 231 +++++++++++++++++++++++
>>   include/uapi/drm/virtgpu_drm.h           |   9 +
>>   include/uapi/linux/virtio_gpu.h          |   7 +
>>   7 files changed, 295 insertions(+), 3 deletions(-)
>>   create mode 100644 drivers/gpu/drm/virtio/virtgpu_userptr.c
>>
> 
> Hi, could you please send rebased patches?

Got it, will send rebased version ASAP.

Regards,
Honglei


> 

