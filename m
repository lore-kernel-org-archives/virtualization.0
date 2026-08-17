Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A8B43D50E
	for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974287; cv=fail; b=MDyKb/Kf6ufvbCZOzOSnxNSpMrUtWpSxoxGILMpcCJOMqqBFMQNIg4FV4rsVFTQwnRC/ijYgFy0GgGp9fJScdQQ8svruu1kjtS6SLF6ARxcypPIaiMgbRFH05vjQvP1nLeqjngyGddrdwcS3BfSDrnn9kK5JQABwB1IisI/MyPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974287; c=relaxed/simple;
	bh=vWpErvTI1S/13Jd4MI00I6WN2rTIV+7EiZsy98l74jI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L2WheQnN8ae12wodOcV9LRvVebnyPZK7limljMf2yJLQheRTAAG2G86aTpHvn6cffnJ7Oonqr5AA8oOibl/XX8zkReoj732E3n7ffz4QKSKywUZ0D43931BlQZetoccUmmc+IKBoLS8TgaPl4l0t1IqdXOg1OuMbMYC1fhTRGVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uYg3YGj1; arc=fail smtp.client-ip=52.101.43.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uYg3YGj1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaVRrBs9WagrcZAK2SMPFRnL6zeRUk5986hHcxxdjol/lStIsYna6CfXlsk0Ugsgv9vturDKSbJwDOs+JZ4Tf+NKaaxRYzw7zHlzT6VSGT/TyduzI/2iIQDeyxfFALL76RfQpVKFweC5mB+QYxfej5pDfh67HA01sijcgbr1Ii5q2x20Dj6kLst6K5SSTPpMLp3lfv+8ngT9v6SKMUXZ5Qce6OUhNPOrTUiRPBANNK89J0RGW3GrzMptQw/q+ZSp/S0ZuCCHeZfzQEv7XC0NC4AN8KlBLcw8hGMKjQVCpR5snQdeZd6ods33vIwSaKD5o9+wZ40cmIV2l1g9hnS6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaN4ldxsuyy55jv8SRuwwFK4nTKDVXy+puGkAjSAWZ0=;
 b=ZtoSidyt1yJQKkevr35+3+ChJfTEBfuz62lz0fECz7Vhc+1CShG1FnHDmxBEngp52d8Jr9MtsMtKvQFZ/t0Ir/pNweKeidrFXuYNYcBdoKRKRuS0rsydvY+2vBWJEkND9Fu4rDAUn3StThYV1M0FNyo/lzn9twdmXM1dxcX6RJZKeC6hLCaS1PHqDESd20cqqHiFtc+V+FvpxrV3giE4DltJFS8lSbMAdROZRdhJsqZNJwG61i+WjQqdsiTDQfFZfxNykqVPhaMow1QMjWjfGZiZ8xeiwvinpCQ76i3K0HORL3zUxfc9rTtkAeSZ8l6YG4iyT5qvXm8lnSskC/JY2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaN4ldxsuyy55jv8SRuwwFK4nTKDVXy+puGkAjSAWZ0=;
 b=uYg3YGj1Zkw0/vGNNHyVx0AqwtGuCYo0Ydi429HD5TEFXPPqRctnscS43VGJs4jhr8iNtO2JJ9VzU4NiaRkXr08VZkPfao9r/IzvGP/a0jnEBcJtPswKDkyr8vTThc28uUG4m24O98zQU4UiNRB0SjTAT9Yxizkt8n/1j6RjVGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Mon, 17 Aug
 2026 13:44:34 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0315.014; Mon, 17 Aug 2026
 13:44:33 +0000
Message-ID: <78f0583f-93c0-4374-ba37-fd36f6388f0e@amd.com>
Date: Mon, 17 Aug 2026 21:44:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: About new backend for GPU compute ROCm in qemu
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, virtio-comment@lists.oasis-open.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 Honglei Huang <honglei1.huang@amd.com>, Huang Rui <Ray.Huang@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 David Airlie <airlied@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
 <ea899a6b-0a59-4a9c-9e81-3ed70711da59@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <ea899a6b-0a59-4a9c-9e81-3ed70711da59@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0014.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::11) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 3add673e-5efd-42d4-0054-08defc65ab97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|23010399003|1800799024|376014|18002099003|22082099003|5023799004|3023799007|11063799006|56012099006|4143699003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	71YfuqYTuzpVLJSMdm/KsadYMbMJDWJk11YhDfQkACqUPd0kX6YSv6qNgb7rHhkXDQkP40JX9qk6vU8Ogao92wz1vXiW7SRSIL1nom5tR8612RNrseVSoTmhiQki6ym+BtOaEuvO7p2w2vF1nKO2Z8FbP8RPzWXkEXmkqSnDhDq9W0owW+T8yH9zSiviOIgry4sW6leGXNP6qJkXv3iFv+rlMe2CM5mD5MsAWmQD5sLqqVDAVjm2Muj79jUTXZT+IE76zpOAT1BTlTvSHP+PT48CqBG15Btf+QDEIWv/s66MKsIc/GpB8Maujv7M7hpcZmjsQcUo1+qbchksoFJjt3ykx7PESGxT7stPruxJku6aZ02bifjFgza9sKe1/Lv0W3ZLywlQ+wVkEFQeZz/AnMGHP0tc1c0j4GdqDVRFTzvfUoXE7U3tYy8nivKD/yb3k2nDCvBw8VOgUPyrMCgOWuglOQj0G+gDBY6FjVEqeQUIh9BW8vvCPkEM0B2Lag4310icD+SCIv4ax6FxCcvfe3ShN3rADWE25cir1qNIyDXVafgna/keUdOWctt/56ef6J1Sde7wffH8y/y+fKCxT20eC7LlINpIxjxGZv+65eiaAdvVjRupyvtTwBzI9OKL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(5023799004)(3023799007)(11063799006)(56012099006)(4143699003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clpyY04zWW45YzNBQVJrb1ZCWFpUcmtSVzdmZ09KdmZNSU8xcGJJaGM1ZW9v?=
 =?utf-8?B?ZHZJbG96ekp5L2xHRGZqSEVZVGJaZEtIaVZra3RsWXRFY0w0eU51ekNuRFQ4?=
 =?utf-8?B?SmJ2VGNRbE16Y0JPNC9PelVoUUt3cEtyamQ5cG1PaW1ZdFpxM2lEaElPVGt0?=
 =?utf-8?B?RXVreWEwaTR2L0E4dENrNDdTbUExTXVDeElPUWtZeEFWUkp3dEtBYzlYRWFF?=
 =?utf-8?B?UEtWd3dRQkZ2SU94TmZjZ3R2NGRCWEFtR1pFQUxEbU0rZmFnU2cyd2V2Zlls?=
 =?utf-8?B?UkpIekJJV1FuVFJuM2hiZ2E2NkFwV1lEWnU2VTNJMEl5NTZrVDdwRXFTeEZx?=
 =?utf-8?B?ai9qZVFUT3BhUVNVaHJuUDBzV0xxMHEvN0FyOEIyT3NYMGN3VmhJa2orVjl3?=
 =?utf-8?B?YlRnSjJGS1F2THY2RjlTbytvaDJHQ1VGYkZ5TXluN1A4dVE0VU15MlV0elNG?=
 =?utf-8?B?cm8wTlpiTFJKdUlmdXNRUTJ2dE9qWE8wakZJcnRQeW1pYmxBS2pySWlycm1N?=
 =?utf-8?B?WjhQUjNieEdPb294ZDdYWnRHSVVkUjcrRGlkUXdHSThQZXU4WVIyakp0NVhX?=
 =?utf-8?B?ZzZPcDMrQThXM2VDRUM1cnA4UHFRRisyZVZNL3J0Wjg0QzNLMkZYdVpEbWNE?=
 =?utf-8?B?RkNWZU96RlRoN3pscHVtTkJXTVowRVNaTHJGd3FSUEI4clN1MGpvNEczUHBs?=
 =?utf-8?B?ZjJiK3V3OVFKYjJYQTRTdlluN0dqdERlVi9mKytwZEFxbDJRNmVFcUI1ZVIr?=
 =?utf-8?B?elZ6RjFxV0EwdzhpK1BoZTkwUVllOFNVZXJBVW1KK2RRbUdtWnVwQ2I3L1dW?=
 =?utf-8?B?MUEzMkp0OC9tZXUvRnpuLzVTVGE4TUYrbFVvZU9jWVViMUU0NzNzNzFsR21q?=
 =?utf-8?B?NFZyczliYmlDYWxUK2dicExncVYzVllHbm53dUtPOG9mU21kMHBjcGlJeXVr?=
 =?utf-8?B?QkEySjNYcE5iK2xsWTlBczJmYWlQd0tuZjdTV09HY1ZBeTJ3bFk2cDBiMW5M?=
 =?utf-8?B?SElKWEM4WndzdUpzdU1xZThPZTM3NmVTY1dNeGpQUlFrWHAybXlLMllFcG9R?=
 =?utf-8?B?OGhJZWo2b1NFMGE2dWdCVFVJZ1hGanlwbFBrUzR2RzBjaVVNOC9LSkpnNEdk?=
 =?utf-8?B?SzA4QkNJSzJaTnpVVTRQY2h2L2hiZDlGU3N5U1hNclo4TkxyemNsUlRyWklR?=
 =?utf-8?B?OUdOTjM0RUxuN0RTdGJNR0VTN2wzdmx5bHdRczg4c0lrYWRLRkFWbWFkdlE3?=
 =?utf-8?B?Y09rbTRGNlFWM25WaFpFZjA0Y2plVU9Eblk0cjZCS0NwcmNiU3ViU2xKTURi?=
 =?utf-8?B?T3JWRVNxQzFjd2FvcldoR09Wa0tDRHNCeG1BSlEzOHY5WGh6cmFBT0hxSUxm?=
 =?utf-8?B?cWx6Tm9tV1g4eWlIT1RQSFQ4dS9hTi9WaC9sZ3kwcFJrTHZqWnViSlh0WFlz?=
 =?utf-8?B?ZngzZlFHcnZXbUJiOGo3OFdBTGEyQ3g4NmtQOE9PVC8vNGJ3OHRzTWRtSWs3?=
 =?utf-8?B?MHd4REk4K2p4YmFNbXRqdlRucUtpN0RqVkxUK3FlbFd6RHpCNWVISGtLdDhK?=
 =?utf-8?B?cXc4YnJTQUdoUkZYRVRJMlI4emVlcldrUjZ1UTZZanlXL1NNV1lZQUhBSzNG?=
 =?utf-8?B?UllkaEgzWHVWVmZleDBFUjRCTndXcFArbDMzUEU2ZmJ1aXhIb3M3eG1pWTkr?=
 =?utf-8?B?LzlPS3N1emdneVM0TU5qVmltNzBXcmhqdzR1L29wZlR5cEQzd3lrOENsNjB2?=
 =?utf-8?B?ZXZ5cXdITGxvS2pvMUJ1RWtYRVcvUExMY1JBbmt0ckhxUC85Y05hd1hpeVc0?=
 =?utf-8?B?cWk4Ui9lT1crelpuNlJCeXp5SHUvSTRjZmxNRDRyUDR1Tm1FWUpMVVFwLzdZ?=
 =?utf-8?B?Kys4MjNYcFBmZWtPS0pJRkI4Q1VSUFdwL3RKRTNRc1VkVWE1cFJwWEdrdGZT?=
 =?utf-8?B?L2NONXI1U0QvOEQ3cWNaZGMvUTNSZXFVV3JyUzBYR3h5WjRIbzI1N1ErRSt2?=
 =?utf-8?B?RVdLaDlxYzNYN2E4VW41ZWx4NU1nSmNxWG5zOXAzTmJRWkl1b0pWNFpIcnEw?=
 =?utf-8?B?UFhEbWRjck1hZmNpQjIyemNTSldmSUVvRUJsVGt3L1E2V2RGaEI4Qlh0SkFl?=
 =?utf-8?B?NzVYYXdZQVMxY2NmaVcwOTU0SEI1TDNMZUVpdTk2eFkzZjVxekdtaFZDZkMy?=
 =?utf-8?B?SFJ6a0RaZlMxdzJIb3dHT3pra2pkY0dEOUU0YnhSVEtqNmJrbDlYUllMWW55?=
 =?utf-8?B?VFhwTm1oa3daaFEzS1FMbTdxZkpBeHpRakNYRWlQc2NaNUoyOXpNdTdrL0d2?=
 =?utf-8?Q?r51uGlFhIz+55CA1QY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3add673e-5efd-42d4-0054-08defc65ab97
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 13:44:33.5407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xj02WBqa9ufaRSfkKl+ywok1iQx6llfwPh1Vy/7HOnqkzLRLf+9Zb3w8IBf8emzqjHVIjwE7eb46G9cZ8G0YNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665



On 8/17/2026 7:44 PM, Akihiko Odaki wrote:
> On 2026/08/17 12:19, Huang, Honglei wrote:
>>
>> Hi Michael, Alex, Dmitry, Akihiko,
> 
> Hi Honglei,
> 
>>
>> I'm bringing AMD GPU compute ROCm based on virtio. I posted a ROCm 
>> over virtio
>> implementation to virglrenderer nine months ago (MR !1568 [1]). The 
>> ROCm side has
>> been supportted by ROCm offical.
>>
>> Current implementation is a virtio gpu context type capset handled inside
>> virglrenderer, sharing the display path. That's an awkward fit, many
>> compute GPUs have no display engine at all.
> 
> I think "sharing the display path" conflates several layers and makes 
> the problem difficult to assess. It would help to identify the concrete 
> constraint behind "awkward fit."
> 
> End-to-end, there are four relevant layers:
> 
> 1. Host GPU stack: hardware, host kernel, and host userspace
> 2. Paravirtualization stack: virglrenderer and QEMU

Yes we are asking can we add a new file like virtio-gpu specific for 
compute, but maybe we can only add a new backend like virglrenderer 
specific for compute.

> 3. Host/guest interface: virtio and the capset-specific command stream

In this plan we may need just add a capset id.

> 4. Guest GPU stack: guest kernel and guest userspace

Won't modify the guest kernel in this plan, this email list.

> 
> Orthogonally, acceleration is separate from display and scanout. A
> physical device may provide both, but acceleration does not require a
> display engine. Linux likewise exposes render and compute interfaces
> separately from modesetting. The userspace interface virglrenderer uses 
> is messy; there is Vulkan, EGL, OpenGL, and now you are adding ROCm. But 
> there is one thing I must note is that acceleration and display is 
> decoupled, and acceleration does not require display.

Yes totally agreed.

> 
> At the protocol layer, context command buffers are carried by 
> VIRTIO_GPU_CMD_SUBMIT_3D. Scanout uses separate core virtio-gpu 
> commands, and VIRTIO_GPU_CMD_GET_DISPLAY_INFO may report no enabled 
> displays. At the implementation layer, QEMU handles scanout 
> presentation. virgl_cmd_set_scanout() obtains resource information 
> through virgl_renderer_resource_get_info() or 
> virgl_renderer_resource_get_info_ext(). That does not make scanout a 
> virglrenderer-owned display path.

Yes, agreed.

> 
> Therefore, if "sharing the display path" means sharing the same device, 
> control queue, and QEMU execution context, that identifies a possible 
> source of contention. If it means that capsets or virglrenderer are 
> inherently tied to display, I do not think that is accurate. Vulkan 
> compute is already used through Venus with libkrun [2], and VCL proposes 
> OpenCL support through virglrenderer [3].

Yes，but the vulkan is for GFX originally, and for some formal AI frame 
work like pytorch, it's support is limited, and it performance is lower 
than ROCm, and vulkan also lacks many AI infrastructure, like composable 
kernel.
And for virCL, actually it is came from same project with ROCm native 
context, but the original author didn't continue to support it, they 
handed it over to someone else to take over. And in the first version of
virCL, it didn't pass the test of actual projects.

And it seems like virCL didn't upstream into virglrenderer also, correct 
me if I am wrong.

>> Beyond that, sharing the display path is increasingly painful:
>>
>>    - Compute hammers the queues more than graphics, so sharing
>>      virtio gpu's single control queue with display/virgl causes 
>> contention
>>      and display stutter.
> 
> All non-cursor commands do share one control queue, but a fence avoids 
> serialization.

yes, agreed.

> 
> There may still be implementation-level contention, and it is not
> necessarily specific to compute. A sufficiently busy graphics workload
> could expose the same bottlenecks. Possible contributors in current QEMU
> include:
> 
> a) qemu_console_hw_gl_block() blocks the entire queue when QEMU only
>     needs to fence scanout commands.

Yes, agreed.

> 
> b) virtio_gpu_virgl_unmap_resource_blob() may also block the entire
>     queue just to delay one command.

Yes, but it is seems like it is must, someone else in AMD tried to use 
async method to relase blob, but it failed to consistency issue, then
reverted to sync version.

> 
> c) QEMU dispatches the control queue and calls into virglrenderer from
>     its main-loop thread along with display work and many other things.
>     Venus's render server can offload renderer work, but control-queue
>     dispatch remains in QEMU's main loop.

Yes, we did some async optimization in ROCm context, but its 
effectiveness is limited, see bellow.

> 
> In any case, I think you need to do some experiments to track down the 
> real cause. a) is easy to check: just comment out all 
> qemu_console_hw_gl_block() calls; it may corrupt display but removes the 
> blocking. b) can also be tested by leaking the mappings instead of 
> blocking the whole queue. Using a different display device like qxl 
> tells whether c) is causing contention.

Yes, totally agreed. following is my findings. In short words:

Optimization can reduce queue pressure, but it can't withstand absolute 
overload because each command has some overhead. Making all commands 
asynchronous would lead to a debugging hell about asynchronous issues.
And we have high load applications rocmprofiler  that continuously catch 
information need virtio queue to handle. But create a new backend can 
not solve it simply, we are trying to find a way. like shmem between 
guest and host, then use cpu polling, bypass the virtqueue.

The load is mostly memory management. Running an AI model allocates and 
frees a large number of blobs. We already did some optimization release 
them asynchronously, but the host processing is a single queue one
process_cmdq, this is where the main bottleneck in my debugging work / 
my understanding so far. I'm not certain it's the whole picture, so 
please correct if I am wrong.

A model load or unload frees a large batch of BOs and allocates another. 
Some of those commands are async in the virtio-gpu guest driver, but 
QEMU still has to work through them on the one queue, which takes time; 
so even though any single command is quick, there are simply too many of 
them, the single queue backs up, and everything behind it, gets delayed.

real work load (a few downstream customisations): loading one 16 GB 
model (gemm4 e4b), drives ~1200 blob creates, a burst of
~1400 resource frees at teardown, ~3700 submits and ~6000 virtqueue 
notifies, caused a 22 s guest soft lockup. And the behavior of memory 
operations are controlled by upper layer like pytorch / HIP / runtime,
we can not control it.

To be honest, a separate backend won't fix this. But the real solution 
maybe is compute specific. That logic is only useful to the compute 
path, and folding it into the shared display device / renderer would 
mean churning code that is mature and stable for graphics, with 
regression risk. Keeping compute on its own instance and backend lets us 
iterate on these compute only optimisations.

> 
>>    - Compute contexts need far more blob / shared memory than a 
>> display one.
> 
> It is not a problem by itself. Frequent mapping and unmapping might 
> amplify the second issue above, but that needs to be measured.

Yes, agreed. I can give more detailed information.

> 
>>    - Maybe needs a wider ROCm / compute stack, cause the render model 
>> fits poorly:
>>      rocprofiler (PC sampling, SQTT/SPM, counters, high bandwidth 
>> streams)
>>      and ROCgdb (wave control, address watch, async exceptions an
>>      out of band channel that must not block display).
> 
> virglrenderer does not impose a particular render model. That's why 
> Vulkan Compute just works with Venus.

Yes but vulkan is used for GFX initally. And can not support many AI 
application.>
>>    - Events, faults and GPU reset/SMI are async and don't map onto 
>> fences.>    - All of this is hard to extend cleanly inside a display 
>> capset.
> Capset is not about display but determines the protocol of the 
> VIRTIO_GPU_CMD_SUBMIT_3D command stream. You have described events, 
> faults and GPU reset/SMI are async don't map onto fences that may be 
> associated with VIRTIO_GPU_CMD_SUBMIT_3D which is dictated by capset. An 
> additional feature may be necessary, and it may or may not be dictated 
> by capset. The other things are irrelevant with the protocol capset 
> represents; they are either behavioral or about different commands.

A fence is the one shot, but event is stateful and repeatable.
That may or may not be tied to capset. Agreed.

> 
>>
>> On the QEMU/host side, would something like this be OK? One step, two 
>> parts:
>>
>>    - a dedicated headless virtio gpu instance for compute.
> 
> A second device would isolate its virtqueues and device-wide
> renderer_blocked state. That may be useful if measurements show that
> these are the bottlenecks, but it is not yet clear that they are or that
> a second device is the appropriate solution.
> 
>>    - that instance served by a separate ROCm backend library loaded
>>      in-process by QEMU.
> 
> First, I think we need to establish why ROCm cannot or should not remain
> in virglrenderer. The virglrenderer, Venus, and VCL maintainers are
> likely better placed to advise on that boundary. Once the protocol
> requirements and performance measurements are clear, we can assess the
> appropriate QEMU integration.

venus is borned for GFX.
virCL not merged.

To be clear, I'm not saying virglrenderer can't host a ROCm native 
context it clearly can. My hesitation is more about fit and direction: 
virglrenderer has grown up around GL/graphics, and I haven't yet found 
compute oriented plumbing there to build on, while ROCm moves very fast 
and I need something I can keep current with low friction.

Regards,
Honglei


> 
> [2] https://developers.redhat.com/articles/2025/06/05/how-we-improved- 
> ai-inference-macos-podman-containers
> [3] https://www.qualcomm.com/developer/blog/2024/10/vcl-virtio-gpu- 
> opencl-driver
> 
> Regards,
> Akihiko Odaki
> 
>>
>> That reuses the existing pluggable backend model, a second virtio gpu + a
>> backend library. It doesn't add dedicated queues for debug/profiling 
>> currently.
>>
>> Waiting for reply and  happy to share more detail. Thanks!
>>
>> [1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/ 
>> merge_requests/1568
>>
>> Regards,
>> Honglei
> 

