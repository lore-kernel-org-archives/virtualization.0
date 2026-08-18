Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379761F16B
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 02:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787020048; cv=fail; b=R7Isdj0L1tfQDU3qHwZ/HQ6hYGjohaLJj/T1QNAZ6kEX4tbpNvpOXSuNQGvpdKeNoXqtiq8rNqTrC/ZhJBaVocVmBa5t2AJ/3dmIQMLbS0HHaMfsnMfdXFrajv/pX/SN9YXmgsVPfgf3CVrq8j0JlyehUNOqZl4y1dAYNBvlFEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787020048; c=relaxed/simple;
	bh=VYqAcaZMx4h85Z8o5/SbYsttwqGUEFfCMC15v8VMzI0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=upBANagP8S89cBQCiUXpj8n/a2dJwY+KLonf5c+fyu78jz5Fz6ImnNoMLqO0YH8jPEY4Gm6P10jQy4ixq4FsHwmFjEWP3sdKUBfsyB16+hDc5J8geYtPj19TznoB8Wo1Dv8RHkFZ1Z9SPhE7zzHgLBQaiHsjs+VlM3fTcEow7pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O3y6FsG1; arc=fail smtp.client-ip=40.107.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O3y6FsG1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lm2yxW3pjw3qNmvjO8f80grpAjsHH6vZp/cigRRlF4gy+GNKQeDQIkC+vsRz01QQds9FPpSwmKx4YJIuR00o4qWdamMZtJkBchV8hooEVKzDjN8Rs4HjcbTAMQ0n8w94hQBky2n8Y1DScHDza/uEWktzLKNeh3PSkDNZWnfQi6v++tcrKCvHmeXg+Ub4egShNYLdSBswC+0Dv8fKhWfckx7HKSfnKraUYg4iIRABHfrQfA7KR9xyO6BzO07JKG0G4fK/S7gSGaD2oTPyE7lJliXU8aJTkApe0PyL6Iz4mu38p4aZeh9pOQf6wZl30sgEFROaixsU8ETnb6Uw42kLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+Axb70i3Bfef/taM3rZOCmK4bHxcFXLUNjTc152p4Y=;
 b=VRqEw91M5UxBPVuYnmWUjEpWLDd+R4Th4fV9TxclaHeEAk40DXCvpVGi8IKmwAyLj6Eh9dscVlpo/9RPBM1ToYr2m8LigUZkPMu9PiKQFNn9TTxZbts0IPcj7BSOJyr/ObR7dtc+nCKbLO3LDXDJp5YSM7Iuk1x00MuhuUTsBpynfbqB77SVDe4VH4Q2OwO9nlHuCgjLIuwRMI5dqFhH6f1G7UgxFWkWeRirjnvVDvodA2kczDzN5WwY/gtpQwDl8UibjPSf4lXG+yTGSc1hsX8jjWi7YAFAoUEOXJsKo7RGk6HYTjiaSRyVcuqZ9hfpC3h2NOYCDfg5RiLwbpkrXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+Axb70i3Bfef/taM3rZOCmK4bHxcFXLUNjTc152p4Y=;
 b=O3y6FsG1LW+3Ce2UG6A3jB/3hN2wLHbC7Vc0I2rcRcIg59i4LBwub83aiyH94HFTAMzdJvh9ZcMHHGj4G/KECRmROVBBcqZ04f6Pv/BxmsfrcQIHZ0tSzN6J1ajuhU2JjXMTd2yqZJtRjEvgAT1+/L9kxnldQ0SNsYw3MQCMIQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Tue, 18 Aug
 2026 02:27:23 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 02:27:23 +0000
Message-ID: <0e223bf3-df75-4ebe-966d-44c13e273586@amd.com>
Date: Tue, 18 Aug 2026 10:27:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: About new backend for GPU compute ROCm in qemu
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 virtio-comment@lists.oasis-open.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, Honglei Huang <honglei1.huang@amd.com>,
 Huang Rui <Ray.Huang@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 David Airlie <airlied@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
 <ea899a6b-0a59-4a9c-9e81-3ed70711da59@rsg.ci.i.u-tokyo.ac.jp>
 <78f0583f-93c0-4374-ba37-fd36f6388f0e@amd.com>
 <87pkzgsu2z.fsf@draig.linaro.org>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <87pkzgsu2z.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0042.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::20) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|DS0PR12MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 68832a43-8f37-4029-88bf-08defcd03c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|4143699003|3023799007|10067099003|6133799003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jkaMO/H8+rfuYhRCW3lF6w7zuaqM6CEG/6dWdQE1WvcoKCK5UJqobKj0mVXX/LGkSYZ/YmpEGCRyyT6vWhwNDXDugy+BKcjgNUKWNkLTSg3n3sm5zJ+h4WvP3MXEixhuVgRCPU3n/ss+Mad8lENXe5pP3L9iNoOSRaphNT3BOuVls8AQrfjm6dO5aiDvGKd7TxDMIZY2cRyxDjmCzKiijhcPWL6G2+2qqMUU/BVFQEwQO4CE6jTbBJkhiyPECGXlrAUWpUA+71u9uYwElQstqYpdhD3YXTvKB3xM+qCh6+Q5iLprSurbR/bfk3mhHd6wlMN2+PhX9zVGGFSxBTds2L2Wbt0UwQJkQ6orZSsWXVPsDuGzOHDjXIhzJAytSFQsHAOk8GlUs+c/bhErXu/BHvAWw3EW0W+TWZjFqw3kH5/sGiJ4U0/c3LNBna8sdj0seCc3nsmbzNCuC09hE89ysVF28ug46hiBe8lHnRpbEGC7mOINFx/iSj9MJVd8Te+RquW8MnYjF0PYjoiTE99HI4z3BlDUA2K9VeIZ1XizNXl9apMy2r2FxizghKxqDt3UX2s+Fxstfr6NrtRpnOzsDzPnzC6gtkxVWGtBF1qTjC3AMD4wKFOTOT5/xDvMOlKr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(4143699003)(3023799007)(10067099003)(6133799003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGRtallHalZDTkpTWlBDL1ZHTDAxd3hheFlXZ0loTDlybDRGSUdFWktxQ1ZG?=
 =?utf-8?B?Tkk5MzNJMll5bWtvdk1Vc3ZqWTdPMXI5OGJEb1hheU1tZmQ2WUc2MmJMTTZt?=
 =?utf-8?B?NUQ4bUYwK0JGM1Q0TEZsb3JnVldCZEdSMExubmFTczc2QUdLRUgzSzJENzZF?=
 =?utf-8?B?WFFaVmhlNEEwdHVHMTMvdEhFNDdGT3dWNGtLTDUxZU5pZWd2dFlka05CeVcv?=
 =?utf-8?B?SGJIaGtlU0Q4L2hMalpKRGxOQlUyRCtZWFhScTFUUkRyaFI4dy9neTFkdHpm?=
 =?utf-8?B?U3hjQnYxRHVnMkhESCtZeTVvOWxmeVRYOGRUVU9XK3FTN3J1Q1daU2tkeURK?=
 =?utf-8?B?bkUwODBFcEVKeitVUEVNOFFIVlJ6eCtQMVlKWmYyK1QrTXU1QVVkd1AySXg3?=
 =?utf-8?B?NzB2MWlwTXo3RTNLMzh4eXJoRW10eTZOdDh0YUZsdXE2Tng1U2FMSXpCeXNJ?=
 =?utf-8?B?OWd4eURxM1FMNTRHMWc4V2dTWWJOaDI4MklrQVRZZXpEeEFsK3B5WHJPUisz?=
 =?utf-8?B?QzNBYXFNVTk3bE0rR3VMeERsSVBZdURlV1dYY3FHcStCZkdzelQzc2hnVzlW?=
 =?utf-8?B?azcxTU8xSElJcGkxVVc0SlJ1cG5pRkdNVE9vK256Nk93RjV2d1FVT3RHVGlM?=
 =?utf-8?B?RXdaamVJY3FiT25JdEE5M1VsT1hkaVBWMW9YWHF0NTFTN1RSQmZxRGpmTXAr?=
 =?utf-8?B?OWwySzhPUTZQOERMZHdJY0I4NW1iLzBPMUtRdGNtSnpzM01LVS8wTThMZ3JQ?=
 =?utf-8?B?UGkvdnZIUno2OTN1eWwyalJzODBFZno3cUdyVVYvWnhVbWhvajNFcW9BOHl4?=
 =?utf-8?B?N0lZdmYrU1hWckpDQ1E0UXpOcktMMzZIVC9ES2xCenBHTFlyK3hDZGVvb3BJ?=
 =?utf-8?B?NUs0L2sycEhLZ1ZFQ00rTTdFUmFlQmYxcGZCYTlva0tFbU9FMjVPa3NGMURF?=
 =?utf-8?B?b1huVDVEUmlEeVBHTStiK2d3Qkd3R3d0MUhLSDZ1bStyV0U2MGJyaGJoTVpN?=
 =?utf-8?B?Z01zMGlzcDlPS1BVYWxiRzJDMEFKZndGSzRLNGtEMTVBVjlSZmZQM1ZiWlVS?=
 =?utf-8?B?L1VSQVFPOERMR05HNkVxaWdpVGI2RHF2SnZvTEFUV0lERXNyQ1BJVDZoZlhX?=
 =?utf-8?B?a2ltQTY0RnN6UmJ0MytZTHZQVjVtZ1B2ZUNkMnlqWGhwcTVuVSszbTdvUkQz?=
 =?utf-8?B?c3E4MFdkbFpoYllaTU5pVFBFS0UxZGM3WjdPQVd2RFZNbGc3Zm4raUIzNXEy?=
 =?utf-8?B?ampKUUhZRmN2Y2hZOG0xNmJqbXRpM21DTVJxV0JRR2x2bEJsM1RCbmswNWNw?=
 =?utf-8?B?TmV3RGVkSXF0RjBSaGg1dFpxa1N6YU8yOFJyaWFmNHJVdHNKbkVGSUsvNlpn?=
 =?utf-8?B?MklzQjllT3hScU9wQmQ0aTU4WjhGMUJuaGN5aU8vWlp2NGFqSzNEMmQ1UWd2?=
 =?utf-8?B?bm1jVDJyY0dUM0VTODRKU3FYZ2NWSlpPUzhtcmg3RlN4RUIyenRRajJTRmlD?=
 =?utf-8?B?SXYyT05VVU1BcjBzRFhkUEpjOHM5c2RwR3J0NVZBdjVrNDFDQWsxOE9vSTB3?=
 =?utf-8?B?bng5Rittb0xSU0dsV1lGaTRLSWUwS2ZYcFF5dDczZEJrT3FkQ25OeE45MHJS?=
 =?utf-8?B?NHQzTFN4aGNiYVFpRjg3QkRTSHU5RU9mMDRGem9mK1dKZ09hVWV4VHpSMHI0?=
 =?utf-8?B?d2tqN2dJWVZ5K05DbmF2YVBGUDdyQUx6ZnRQcytSd1NQNGNYbTVKS0k4d2Ir?=
 =?utf-8?B?dTZjSWt4T2JaTHF0L1hNWTJhQkFoVmRpUFRWUWZBWm43NnBidmMxdjdCekhx?=
 =?utf-8?B?VktVeWZRZnpyS251VEY4M2hicm1FT3BDclRHS0YrVXovL041WVdqNDI2Q1Fs?=
 =?utf-8?B?emJlcDh0REtibElWWElRT3V2ZStVcXZxYlhpcFVmbWhJQTV1Y2dXQnYxb3ZP?=
 =?utf-8?B?REZHcFZKNVg5MVBFTXp0dzBKa2tnVWo1MmU1Rmx0R3dmNHJKVzV0K0xlYURv?=
 =?utf-8?B?RzV3aFZEWnZmRm5SOWN4bzkyZTljV3hqTkZQa0xwWkxGS29IR01HWHp5VVlm?=
 =?utf-8?B?R2t6ZDFPVGsvLzFjeFNyeTkwRVByYzVOaHBNK3I1L2IrcW5wN05pV0VIK3RY?=
 =?utf-8?B?MVdyRzlacHU3YUlpM1ZhaDU5K0VCYjdOZFFRVG9maTZXVUFTMlBscmlWcXFw?=
 =?utf-8?B?eTdsL2RpamFaMGp2b3gvdFlNOVY0RG90dWl5NHFoNk9XMmlPUkZLbHc0VmJS?=
 =?utf-8?B?eXIxbUVLOHozRDdZTkRJbUcrWE9URXp1dnhSRzFrZ0V3RmhaVGtsUHB0dmcx?=
 =?utf-8?Q?tslHvv8XeZaMa4rtF2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68832a43-8f37-4029-88bf-08defcd03c2c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 02:27:22.9103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHibdJzAsVmYZ31aPusH0hstAOSRZ1p+IKXHO/1nHTL7yb3+AsafoFXl3+OcMXO4bAunBvgbQvHzri8yrMl2sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814



On 8/17/2026 10:24 PM, Alex Bennée wrote:
> "Huang, Honglei" <honghuan@amd.com> writes:
> 
>> On 8/17/2026 7:44 PM, Akihiko Odaki wrote:
>>> On 2026/08/17 12:19, Huang, Honglei wrote:
>>>>
>>>> Hi Michael, Alex, Dmitry, Akihiko,
>>> Hi Honglei,
>>>
>>>>
>>>> I'm bringing AMD GPU compute ROCm based on virtio. I posted a ROCm
>>>> over virtio
>>>> implementation to virglrenderer nine months ago (MR !1568 [1]). The
>>>> ROCm side has
>>>> been supportted by ROCm offical.
>>>>
>>>> Current implementation is a virtio gpu context type capset handled inside
>>>> virglrenderer, sharing the display path. That's an awkward fit, many
>>>> compute GPUs have no display engine at all.
> <snip>
>>>>     - that instance served by a separate ROCm backend library loaded
>>>>       in-process by QEMU.
>>> First, I think we need to establish why ROCm cannot or should not
>>> remain
>>> in virglrenderer. The virglrenderer, Venus, and VCL maintainers are
>>> likely better placed to advise on that boundary. Once the protocol
>>> requirements and performance measurements are clear, we can assess the
>>> appropriate QEMU integration.
>>
>> venus is borned for GFX.
>> virCL not merged.
>>
>> To be clear, I'm not saying virglrenderer can't host a ROCm native
>> context it clearly can. My hesitation is more about fit and direction:
>> virglrenderer has grown up around GL/graphics, and I haven't yet found
>> compute oriented plumbing there to build on, while ROCm moves very
>> fast and I need something I can keep current with low friction.
> 
> I'm unsure what the current development status of virglrenderer is but
> it does see a continuing stream of merges. However the threading model
> does make things tricky for QEMU when we are sharing lifetime of blobs
> between QEMU proper and the virglrenderer thread. Perhaps there is a
> better way to organise things?

Yes, agreed. ROCm has no render thread of its own, it uses user-mode 
queues So, I think there's a better organisation.

> 
> Could we do the marshalling of VirtIO GPU commands into ROCm directly
> inside QEMU rather than going through additional plumbing? 

Yes, by "additional plumbing" I take you to mean routing through a
virglrenderer style renderer ( extra thread and blob coordination).
Yes, I'd drop that. What I'd keep is only a thin in QEMU backend the 
9pfs/cryptodev kind of pluggable backend, not a renderer layer which is 
what lets QEMU own the blob lifetime directly.


> Are the sequences we need to handle more or less complex than your general gfx
> rendering? How might this work with other frameworks?

Simpler, I think. ROCm has no render thread. It uses HSA user-mode 
queues: the application writes AQL packets into an in memory ring and 
rings a doorbell an MMIO page from the GPU's mapped straight into user 
space and the GPU's hardware scheduler picks the work up. Nothing on the 
host translates or dispatches a command stream the way a GL renderer 
does. Completion is an signal: either an interrupt backed event wait, or 
the CPU polling the signal value the GPU writes to memory. So the host 
side is closer to an ioctl proxy (create/destroy queues, 
alloc/map/register memory, signals, submit); the hard parts are the 
memory stuff you raised and the async event/fault channel.

For other frameworks, I think we can keep the device generic, user 
queues, a shared memory, events with the framework specific marshalling 
in a small pluggable backend. AMD is unifying queues in DRM, allowing 
devices to use user queues and event like mechanisms, which will greatly 
simplify device emulation. It also may affect the NPU. I think that 
graphics may use the same mechanism in the future to avoid complex 
synchronization issues.

Regards,
Honglei

> 
>>
>> Regards,
>> Honglei
>>
>>
>>> [2]
>>> https://developers.redhat.com/articles/2025/06/05/how-we-improved-
>>> ai-inference-macos-podman-containers
>>> [3] https://www.qualcomm.com/developer/blog/2024/10/vcl-virtio-gpu-
>>> opencl-driver
>>> Regards,
>>> Akihiko Odaki
>>>
>>>>
>>>> That reuses the existing pluggable backend model, a second virtio gpu + a
>>>> backend library. It doesn't add dedicated queues for
>>>> debug/profiling currently.
>>>>
>>>> Waiting for reply and  happy to share more detail. Thanks!
>>>>
>>>> [1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/
>>>> merge_requests/1568
>>>>
>>>> Regards,
>>>> Honglei
>>>
> 

