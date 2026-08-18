Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E0C1F4611
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787021443; cv=fail; b=kd8HdLGDGWtmLMr7xL+pd82ibukkVAGWDIfIvuLpFSJvCiORW9JBbLIWynrHOPLhSu44WAzsu4FAl1loau7MflQqwsAWJ6X/K5GJL0jF/5UAN3BKxSRBubpTZy7iJfQ6WIKe9dAtLKFsvNM4eh6N76/76IcOUVQQzAYJjc1kISc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787021443; c=relaxed/simple;
	bh=0MvTxsVMqtZCUadRQ5wtJi35CIKz2ovRkw1blhGPJTM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uq5i62nWQWVr5TYIkv4x9Gz72YziPVUwWpL02S52fgx7EydebWSyA+kldIVwP6FNNfNc44Wkysf5zlweG6KyVPlltpKUsGCc689p11gTSjbE0XFDR/PN2UknGze/6pXNGRU7HjbSpnfyc7iGJjdydK9bkulOWZqA6IXPsKxe6TQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BYlT8ll1; arc=fail smtp.client-ip=52.101.62.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BYlT8ll1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFMnyoFdJ4gtWNOpFZEJkwThp4tt2a+cWc2m/4tLMUJs9GDwvgXrCoPVidoxL/jUPj91P4W5lG67+j+jFmJss4DuH6kyQZ1QO0N8FqkIeYC2F0+7Nzl+OX5XeNXBIKytarHXVCLEeAYhWnf7utGs20/KD3IPfZp4HCTWGBj9FTx00Y60N1oQ4eQsQ4W7sslxkc2ythiPfT1W5c7IhIDpv8kykqVeLjf6B6O+/HtDBbDVDfzuCBjrTeNhAvgykjbS9fahHfGoNziPUohyq9fIeZzFFohuwnnvZImNWN8RmNVAOJxM3ta2gZeWu5IyavUeiGCnSSJxyxiGb/uxJghCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itzBNaL62UWSqpGxP5Z3DAJ22deJl+AcMRTLqJVL7iU=;
 b=HOusaLwJQc43Iqt8nGCQFi0LF2ApN5/fZKI1c7Vk0QjgPhtU5O7EM5dJPvBvYw56XigInAOEURaQsg0syqmno5f6cLuGDC2fwH9Yi8h4xEujNNtmd+gbEx2JwJ72JLnawVdEwjhNSkpFxTWxKTxdqC0abdIUCRIxVYT3cmtgYUk0CpQ/syc3CDhtqyb6iT0zc7eyO+6c58UtyzKveuOsrvYQ+IapAB0y6Kz7JTf2Y1SDzQlLFsZeMNJhikvCobLaR649RpNreacKNyJOihhxZ/z5CZ+U/FZYHb1VjqukTh1mrwzIS/w+/23DYjlmjZn1gnp/EdfJ1FevuqxnhCpjXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itzBNaL62UWSqpGxP5Z3DAJ22deJl+AcMRTLqJVL7iU=;
 b=BYlT8ll1hCCW1HrZqfYbTQr1bSFLE1EFi5DIjLsWvU2GuR+0Q855tX0Hxb9HxV8lXnqYT+d8Qb/K3oOkAguCPn3EMk8IK9bSRNEzF7V/bVavKI7t/BTZtm7hqQRY9f5ZpqiKMutQvU2WI8qeA3MRJpYl55oPDXAvv2Jf6MBmfmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 02:50:34 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 02:50:34 +0000
Message-ID: <3c3eb833-8026-44ad-8e33-dea346752db2@amd.com>
Date: Tue, 18 Aug 2026 10:50:25 +0800
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
 <78f0583f-93c0-4374-ba37-fd36f6388f0e@amd.com>
 <c79bbd91-0057-4e9a-bc56-28ca4c4ccae2@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <c79bbd91-0057-4e9a-bc56-28ca4c4ccae2@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0003.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::9)
 To CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|LV3PR12MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: 401a8135-a7dd-4787-ae9f-08defcd37954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|10067099003|56012099006|11063799006|5023799004|6133799003|4143699003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OUBItjAx/Z4fuuuV9qDzQc0RIc1WcXynRhnr+Ok43IUA2rg4K+J4sPUDAf7bSFmrbHAypsfTj/4usAa2cmV9NF03FvXxzpSpiGNCCLRh9BXYCckY/7gXMNwv4gX4NC7Vb6ZrJ3kof28TQ3fUcGtL/D98nzBQV/vmm7w0KRVtfFx/OtuiWW3TQtNrWz2AQqQSnJgs7VCWOjj2rbK41Dp8mM+wPUkDO/DNGSJQrXZVWvaYgv9pegTUBVT6dZ48kJ05OZeE/lhIkdVQnv/0t00EYc7NwjtwCykR05hiZkR4+PelOp5qPSB7HVEgiIgqxpH31b/WY7Jif3jN5dRhqM+CAktPAMrxUyb+WhXiTz4DycNFvNUw9yVggIoFrLZW/rxqdQlZ7eRUzBPeMDVEMSSnMjub75pMwMki9UCHRne+IQ0ff2itUnJM6Yf2U4Sk7Dr5AjGfhFyUwHgyEw89FYKg/Slz0W5zhQOqqRcPKVwXSBX2tJZHDBMB8VMUbbv4ziUmyrf6b59nOesm0nhaV/+gPwbJDD7Hq6gMepk0SkqVTEh2KqX+rfuBgXFOplnZkRS/NzxosSge/DSMdop8RCsNv797W34BD3Gf+ZQyNA3W5jHT2KT/5BmJUtk5p2LVTIiH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(10067099003)(56012099006)(11063799006)(5023799004)(6133799003)(4143699003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2RYSVQ4ZFFFRkhiamRacWRFQk41K2RENkNJK0FPKzl2Qmg0RkpYclJVdHJ2?=
 =?utf-8?B?RkdISkp2dGRnZE9Ub0RDSUZRSThSZlVaRngweWtuWFZkbGU5UkVBYWx0Vmc1?=
 =?utf-8?B?a2hZZDFyajVQSWJnYzVLTUJSS0c2Z2xvVGx5RWNlWlE4UW1SNVNrOFFmaFNr?=
 =?utf-8?B?WFNLUEJGMThqVlFDUGdzaWE5VXQyUFF2REtoVGExK1NDeUNSK2xWYUkzNGZz?=
 =?utf-8?B?WVVvMlJTNnBJMnNZN09JYXlLbGV5UGJvOEM0OEFOTUlKbTlFWGR0OVJJQWxz?=
 =?utf-8?B?VGI3YUYzQXJVanNESXpWYWdMbHl1TmJyRDBuWDZLRXFoODI2VkRId1VPeWYz?=
 =?utf-8?B?YWl3OW02ckx3ZmpWc3pkbDA1Z0R2YjVyYW1SVW9KN0g3N296NnpyMWNBcXNk?=
 =?utf-8?B?LzFWTXJ4UDhTYkIvVThrZkErYkJhL3JrZFNnbmpIUGJVSFBPZHE4Vkd0QXcy?=
 =?utf-8?B?MmVhbW1SUnZCMFpIejF2RTlnTzJleEduTXhPZGlqTWdSdkJzb0RPOUptSDh1?=
 =?utf-8?B?R3UwVklrN0lNTVNVZU5CRWVXT2tEZkZOdjNOVXFQM2M1K2JJQS9CUUk3NVlt?=
 =?utf-8?B?MjhRR2FMa3R3UHVrVEtjakUreFRFQlk2VnZzU3ZheUlqWjF5MjE0RFZZQjcy?=
 =?utf-8?B?TGMvVGNTdFVuenphQjA0QVFtenRGcGdWcE5HL2dSL2hZSnVsbi9sTVNuS250?=
 =?utf-8?B?bCtMMW5jUENoZlJvbnp6akwyQldBZzNOMlVKc2NvWGhodmVxTGxDSHZseDhj?=
 =?utf-8?B?UGFEMWpJeldydEJUSDFTUGd0SWVFcmU3M2dpeGE2MURHL21PRzJCRkZrUDZG?=
 =?utf-8?B?SWtyQ2VjRXdURW9oOFBqOUpuNWFyRTJ5Nm43Tm4vV3ArcXpiNkpFMDdGcHda?=
 =?utf-8?B?Y0hWekNtZnBoRUp5Nmd5YUZYWWVOVkJsSmJMaGtCTjNEMTY0eXRRdjJPSzRY?=
 =?utf-8?B?dUdnenVxT3RuaDYvV0pKaEdiVithYnYySVpFY0d4MUFzcmsvSGtYMUhlMkNS?=
 =?utf-8?B?Y2ZYRVRvWmNjOHB1R1RrVGFsWUdCSjUvMTZXL082K20rS2ZQeXF2QWk3bnhi?=
 =?utf-8?B?czBzbnNxZWxjS0JSU1E2ZndxQzZXeUg1RWxOVkp6Z0ZBeFdCeDVrQzhNV1N0?=
 =?utf-8?B?dDNkL0lwK1NCUTF3R1diamdHREdUMUxzZmRTVlBlTVc0cElncXVFN2MzeU9S?=
 =?utf-8?B?eitxL2NDV3BYemk0b2tTdzN4ck5yWHd4Nm0xRlVOZFJqRVpSUStXd2V2UGRU?=
 =?utf-8?B?ampiOHlTc2oxc2R0RVVTa1FvU2NIZUMyWmdTajBscTVMUVBXRE8xZE1ZZzRP?=
 =?utf-8?B?UjIxb2tCbGM3NnczallEdlc1dVZicGUvYXgvTGpSWGJUVnY0SzZOeTQxYWtY?=
 =?utf-8?B?TEhQVTkwWnQvakVkZjR5aWYvb1kwcHJsNmx1VXNqUE5ib1ZiRjBDTEVhcitn?=
 =?utf-8?B?SGR4RThGL2Z6WkRGTksxaC9kZE13bUpXTWdMQ1VTWlJRU29Kb2xUWFpTMDV0?=
 =?utf-8?B?V0g4S1plN0dIYkF2ckJaQnRJdTA1TjNiOG9USUtTU2xzaXpmbHQ5UldhK2kw?=
 =?utf-8?B?T1JqMEhrTXI1T3cvZjVSN1VoTVQvMWgxTXlxSFQ2Um9Zc3ZwNU9Kcmdaa1hq?=
 =?utf-8?B?eFhBY3R0c0g2d2RtRmI2djgxYVRTbGxTRkE4QmdnOEttRmRZSFJTYndvaElu?=
 =?utf-8?B?TlZSWkVjcDVYa1dPU214Sk1XcllFbk55V0tZQm11dXZSdHVlaHZhcEFRejFO?=
 =?utf-8?B?b3d2blFKY2FDWXhNNVBZaTJubVBiYmlEdjM5SWkvaVFNUit0SzZZQjFBeTF5?=
 =?utf-8?B?STFpV3kwMlc3RXRUbHdOaHpXOTNyMGhmVUxCdDlpMHdJaGdWcGZJZjlSVUpt?=
 =?utf-8?B?OUlmTG8vRWlyVTNNNUVjVUtIcW1hVk9tWG4yYWNvUGFsVUJsZjVkODZwM0NK?=
 =?utf-8?B?VG41RnF4RmRiQS9DZ0JCSGZMSG5HNmg1ait5NjM0L0ZrenFGdEVNNm5FU2Fr?=
 =?utf-8?B?MTJ4QTRvTnJ5SnBjRkxmVWZPTk85MEgwY0h4STBHRFlPVG01ZDVzSVVTaTlh?=
 =?utf-8?B?dk5WOXpOaDNNOEZQck84WEJPY0ZpVlBuUFA1SnJsdk1lQmxsejZHTjR1R1lR?=
 =?utf-8?B?QndMMDJxTU9BbVI5LzZuMHNYYk11VXlYNWdPdTJUbDhBU1RLazZGalJhQXVy?=
 =?utf-8?B?MmxWbjh2TisyYkR4TzBYd2lKTjFyTEhDekYvNGk4QjFlbHhBdHViN0swSUJn?=
 =?utf-8?B?VENqZjY1bGdtemswQ1d0T1FJVWlweVVyUFBuZXdLK2UzTjdQNDBqV3J3OUc0?=
 =?utf-8?Q?CnojPfYId8DiQKB9Uo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401a8135-a7dd-4787-ae9f-08defcd37954
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 02:50:33.9704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +j9H+OmO0YLeJfvycZ043NEcm5jHfA+NjpNeMlfuJkp5t/7u1wETlfpXeigCGat7DT3E3bx3LuwGVG5ESR5Zjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186



On 8/18/2026 12:29 AM, Akihiko Odaki wrote:
> On 2026/08/17 22:44, Huang, Honglei wrote:
>>
>>
>> On 8/17/2026 7:44 PM, Akihiko Odaki wrote:
>>> On 2026/08/17 12:19, Huang, Honglei wrote:
>>>>
>>>> Hi Michael, Alex, Dmitry, Akihiko,
>>>
>>> Hi Honglei,
>>>
>>>>
>>>> I'm bringing AMD GPU compute ROCm based on virtio. I posted a ROCm 
>>>> over virtio
>>>> implementation to virglrenderer nine months ago (MR !1568 [1]). The 
>>>> ROCm side has
>>>> been supportted by ROCm offical.
>>>>
>>>> Current implementation is a virtio gpu context type capset handled 
>>>> inside
>>>> virglrenderer, sharing the display path. That's an awkward fit, many
>>>> compute GPUs have no display engine at all.
>>>
>>> I think "sharing the display path" conflates several layers and makes 
>>> the problem difficult to assess. It would help to identify the 
>>> concrete constraint behind "awkward fit."
>>>
>>> End-to-end, there are four relevant layers:
>>>
>>> 1. Host GPU stack: hardware, host kernel, and host userspace
>>> 2. Paravirtualization stack: virglrenderer and QEMU
>>
>> Yes we are asking can we add a new file like virtio-gpu specific for 
>> compute, but maybe we can only add a new backend like virglrenderer 
>> specific for compute.
>>
>>> 3. Host/guest interface: virtio and the capset-specific command stream
>>
>> In this plan we may need just add a capset id.
>>
>>> 4. Guest GPU stack: guest kernel and guest userspace
>>
>> Won't modify the guest kernel in this plan, this email list.
>>
>>>
>>> Orthogonally, acceleration is separate from display and scanout. A
>>> physical device may provide both, but acceleration does not require a
>>> display engine. Linux likewise exposes render and compute interfaces
>>> separately from modesetting. The userspace interface virglrenderer 
>>> uses is messy; there is Vulkan, EGL, OpenGL, and now you are adding 
>>> ROCm. But there is one thing I must note is that acceleration and 
>>> display is decoupled, and acceleration does not require display.
>>
>> Yes totally agreed.
>>
>>>
>>> At the protocol layer, context command buffers are carried by 
>>> VIRTIO_GPU_CMD_SUBMIT_3D. Scanout uses separate core virtio-gpu 
>>> commands, and VIRTIO_GPU_CMD_GET_DISPLAY_INFO may report no enabled 
>>> displays. At the implementation layer, QEMU handles scanout 
>>> presentation. virgl_cmd_set_scanout() obtains resource information 
>>> through virgl_renderer_resource_get_info() or 
>>> virgl_renderer_resource_get_info_ext(). That does not make scanout a 
>>> virglrenderer-owned display path.
>>
>> Yes, agreed.
>>
>>>
>>> Therefore, if "sharing the display path" means sharing the same 
>>> device, control queue, and QEMU execution context, that identifies a 
>>> possible source of contention. If it means that capsets or 
>>> virglrenderer are inherently tied to display, I do not think that is 
>>> accurate. Vulkan compute is already used through Venus with libkrun 
>>> [2], and VCL proposes OpenCL support through virglrenderer [3].
>>
>> Yes，but the vulkan is for GFX originally, and for some formal AI 
>> frame work like pytorch, it's support is limited, and it performance 
>> is lower than ROCm, and vulkan also lacks many AI infrastructure, like 
>> composable kernel.
>> And for virCL, actually it is came from same project with ROCm native 
>> context, but the original author didn't continue to support it, they 
>> handed it over to someone else to take over. And in the first version of
>> virCL, it didn't pass the test of actual projects.
>>
>> And it seems like virCL didn't upstream into virglrenderer also, 
>> correct me if I am wrong.
> 
> I cited Venus and VCL only as examples showing that virtio-gpu and
> virglrenderer are not intrinsically tied to display. I did not suggest
> either as a substitute for ROCm.
> 
>>
>>>> Beyond that, sharing the display path is increasingly painful:
>>>>
>>>>    - Compute hammers the queues more than graphics, so sharing
>>>>      virtio gpu's single control queue with display/virgl causes 
>>>> contention
>>>>      and display stutter.
>>>
>>> All non-cursor commands do share one control queue, but a fence 
>>> avoids serialization.
>>
>> yes, agreed.
>>
>>>
>>> There may still be implementation-level contention, and it is not
>>> necessarily specific to compute. A sufficiently busy graphics workload
>>> could expose the same bottlenecks. Possible contributors in current QEMU
>>> include:
>>>
>>> a) qemu_console_hw_gl_block() blocks the entire queue when QEMU only
>>>     needs to fence scanout commands.
>>
>> Yes, agreed.
>>
>>>
>>> b) virtio_gpu_virgl_unmap_resource_blob() may also block the entire
>>>     queue just to delay one command.
>>
>> Yes, but it is seems like it is must, someone else in AMD tried to use 
>> async method to relase blob, but it failed to consistency issue, then
>> reverted to sync version.
> 
> Queue-wide suspension is not inherently required. Commit 4eb0aace85f5 
> ("virtio-gpu: Support mapping hostmem blobs with map_fixed") added a 
> path that avoids per-blob MemoryRegion teardown when 
> virgl_renderer_resource_map_fixed() succeeds. The remaining path is also 
> being improved with:
> 
> https://lore.kernel.org/qemu-devel/20260424-force_rcu-v4-0- 
> feccfaca0568@rsg.ci.i.u-tokyo.ac.jp/
> ("[PATCH v4 0/6] virtio-gpu: Force RCU when unmapping blob")

Thanks. force_rcu is a clean fix for the RCU-reclamation part, but it 
still keeps the unmap synchronous and serial.

> 
>>
>>>
>>> c) QEMU dispatches the control queue and calls into virglrenderer from
>>>     its main-loop thread along with display work and many other things.
>>>     Venus's render server can offload renderer work, but control-queue
>>>     dispatch remains in QEMU's main loop.
>>
>> Yes, we did some async optimization in ROCm context, but its 
>> effectiveness is limited, see bellow.
>>
>>>
>>> In any case, I think you need to do some experiments to track down 
>>> the real cause. a) is easy to check: just comment out all 
>>> qemu_console_hw_gl_block() calls; it may corrupt display but removes 
>>> the blocking. b) can also be tested by leaking the mappings instead 
>>> of blocking the whole queue. Using a different display device like 
>>> qxl tells whether c) is causing contention.
>>
>> Yes, totally agreed. following is my findings. In short words:
>>
>> Optimization can reduce queue pressure, but it can't withstand 
>> absolute overload because each command has some overhead. Making all 
>> commands asynchronous would lead to a debugging hell about 
>> asynchronous issues.
>> And we have high load applications rocmprofiler  that continuously 
>> catch information need virtio queue to handle. But create a new 
>> backend can not solve it simply, we are trying to find a way. like 
>> shmem between guest and host, then use cpu polling, bypass the virtqueue.
> 
> Most commands are fast on the CPU side, while heavy processing
> happens asynchronously on the GPU. Cases (a) and (b) are exceptions.
> 
>>
>> The load is mostly memory management. Running an AI model allocates 
>> and frees a large number of blobs. We already did some optimization 
>> release them asynchronously, but the host processing is a single queue 
>> one
>> process_cmdq, this is where the main bottleneck in my debugging work / 
>> my understanding so far. I'm not certain it's the whole picture, so 
>> please correct if I am wrong.
>>
>> A model load or unload frees a large batch of BOs and allocates 
>> another. Some of those commands are async in the virtio-gpu guest 
>> driver, but QEMU still has to work through them on the one queue, 
>> which takes time; so even though any single command is quick, there 
>> are simply too many of them, the single queue backs up, and everything 
>> behind it, gets delayed.
>>
>> real work load (a few downstream customisations): loading one 16 GB 
>> model (gemm4 e4b), drives ~1200 blob creates, a burst of
>> ~1400 resource frees at teardown, ~3700 submits and ~6000 virtqueue 
>> notifies, caused a 22 s guest soft lockup. And the behavior of memory 
>> operations are controlled by upper layer like pytorch / HIP / runtime,
>> we can not control it.
>>
>> To be honest, a separate backend won't fix this. But the real solution 
>> maybe is compute specific. That logic is only useful to the compute 
>> path, and folding it into the shared display device / renderer would 
>> mean churning code that is mature and stable for graphics, with 
>> regression risk. Keeping compute on its own instance and backend lets 
>> us iterate on these compute only optimisations.
> 
> A 22-second lockup is too long for those command counts.
> 
> The most probable explanation I have is that the ROCm integration blocks 
> QEMU's main loop thread while synchronously waiting for GPU execution. 
> Creating separate devices won't resolve this because the main loop 
> thread is shared, and synchronously waiting on the GPU should be avoided 
> in the first place.

No synchronously waiting in ROCm backend, we are using user queue, and 
event waiting, no sync operation in CMD wait. all the resource release 
in ROCm are all async now.
Only the sync thing is memory thing mapping/unmapping in qemu, as long 
as it remains synchronous, it will be overwhelmed by the massive number 
of requests.

> 
> In any case, profiling is necessary before touching the implementation.
> 
>>
>>>
>>>>    - Compute contexts need far more blob / shared memory than a 
>>>> display one.
>>>
>>> It is not a problem by itself. Frequent mapping and unmapping might 
>>> amplify the second issue above, but that needs to be measured.
>>
>> Yes, agreed. I can give more detailed information.
>>
>>>
>>>>    - Maybe needs a wider ROCm / compute stack, cause the render 
>>>> model fits poorly:
>>>>      rocprofiler (PC sampling, SQTT/SPM, counters, high bandwidth 
>>>> streams)
>>>>      and ROCgdb (wave control, address watch, async exceptions an
>>>>      out of band channel that must not block display).
>>>
>>> virglrenderer does not impose a particular render model. That's why 
>>> Vulkan Compute just works with Venus.
>>
>> Yes but vulkan is used for GFX initally. And can not support many AI 
>> application.>
>>>>    - Events, faults and GPU reset/SMI are async and don't map onto 
>>>> fences.>    - All of this is hard to extend cleanly inside a display 
>>>> capset.
>>> Capset is not about display but determines the protocol of the 
>>> VIRTIO_GPU_CMD_SUBMIT_3D command stream. You have described events, 
>>> faults and GPU reset/SMI are async don't map onto fences that may be 
>>> associated with VIRTIO_GPU_CMD_SUBMIT_3D which is dictated by capset. 
>>> An additional feature may be necessary, and it may or may not be 
>>> dictated by capset. The other things are irrelevant with the protocol 
>>> capset represents; they are either behavioral or about different 
>>> commands.
>>
>> A fence is the one shot, but event is stateful and repeatable.
>> That may or may not be tied to capset. Agreed.
>>
>>>
>>>>
>>>> On the QEMU/host side, would something like this be OK? One step, 
>>>> two parts:
>>>>
>>>>    - a dedicated headless virtio gpu instance for compute.
>>>
>>> A second device would isolate its virtqueues and device-wide
>>> renderer_blocked state. That may be useful if measurements show that
>>> these are the bottlenecks, but it is not yet clear that they are or that
>>> a second device is the appropriate solution.
>>>
>>>>    - that instance served by a separate ROCm backend library loaded
>>>>      in-process by QEMU.
>>>
>>> First, I think we need to establish why ROCm cannot or should not remain
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
> Whether keeping ROCm in virglrenderer would create extra friction is 
> primarily a question for the virglrenderer maintainers. Its graphics 
> origins do not by themselves motivate adding a separate backend 
> interface to QEMU.

Fair. The first draft version in virglrenderer was in May 2024, and ROCm 
has gone 5.7 → 7.14 in that window.

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
>>
>>>
>>> [2] https://developers.redhat.com/articles/2025/06/05/how-we- 
>>> improved- ai-inference-macos-podman-containers
>>> [3] https://www.qualcomm.com/developer/blog/2024/10/vcl-virtio-gpu- 
>>> opencl-driver
>>>
>>> Regards,
>>> Akihiko Odaki
>>>
>>>>
>>>> That reuses the existing pluggable backend model, a second virtio 
>>>> gpu + a
>>>> backend library. It doesn't add dedicated queues for debug/profiling 
>>>> currently.
>>>>
>>>> Waiting for reply and  happy to share more detail. Thanks!
>>>>
>>>> [1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/ 
>>>> merge_requests/1568
>>>>
>>>> Regards,
>>>> Honglei
>>>
>>
> 

