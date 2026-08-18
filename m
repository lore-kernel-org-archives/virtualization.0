Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCE91D5174
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 04:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787027186; cv=fail; b=tPo7Ka/LB8YyvriL1oVYkFsKKEyqzGAOubqHoBrPEhWmkBJPf0OfHGzUVz+iSCHypgHMZ9CK4OO/+wzOQD0fanGXt28Tsz1sxT4uppJ78Hrp2MGogPQuIGpmtK6rv4UYoUfF9FymeLc8gsN9XurRoOd7E4/bYrJUUuE2/c3BOL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787027186; c=relaxed/simple;
	bh=bsQ6mgFNG0osmDVWeVmnCS8OxeUTotbyZ0gYbE1+0f4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vyv+QIXPCTpXmPvs2Q2FMKqFd4QwCzZGttjSHNIZcEI+eiovCACrjvXbEstjVMOvc5MMpk5pk4MaE9zVuHLFvMROocJQPoCkbsGsEjq749ekwgeSx8j66acwbM9mg6QrNF+E5bTS6hgGM3vhe0Wh4GbhXt0XtOsPMgqG9uzzLtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x8ZC7ju1; arc=fail smtp.client-ip=40.93.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x8ZC7ju1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAL6Ssn5eWsKLzU5QQzKft/L5KDqVUF2MWLkyM3TbL5lZHii02gY5F7sYAqCplQ6cfcIC7a8mR9Dv6qExhaqPT1dFjMop25TK/zj2MdVdL8K+2kMLD6JSqE2/OU86XvD/y02oeE/yWHOVXywLzYkDBtKr2Xww4dJtnCJKFW/8YgbsH3eCZyuq87mhy3/D8u4iuZY7jI023bGH8WVyNddZrAVWTwKcboBkPLkbxLRfhcjAMqgGBO7wBYb9KrZnXtv1nXGkKSuHyzDaUAyUn+vlrXudXGbjBTPVL4v+QhJD3LGn34BErYIdeGAW0Ws9YowkNDEl+vdu9GbQZxi2Rc/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcvJh3q9o7maSw/RKW0MiUv2ptdPBek/d0g3F1litNo=;
 b=JTekjG05Ihs+4B0GLkkPBkjJsr75PK8ajyZaRSOI6DhEFJrXkhV/xEYjxevaHEABaiytRXH4v3UWRyhg2Sx7/fBGIM960BQh038CFC5bcqoFW54n5ZJE40UOtb4eKG++r2J7Z3Zr/BPTRrT6Gb5S087WNr1gp2SwPLIfN0imz+9WMUl1d/GR1f/mMM1zivCfEXoUSRrg8hAKVdb2uqz9gnstQ3tV1HxqsAv6CujGKyQh36dXvA9ce/Tax5izsrLDocfTvbFn/zKmDFfHdY0KFdKYefL6LdUTXPKGCuBZMKvOaV35J2EspkdGyeJJySPaZ/8lbfe0F1WWXjYrbGU/aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcvJh3q9o7maSw/RKW0MiUv2ptdPBek/d0g3F1litNo=;
 b=x8ZC7ju14eZvCQ4Etwnd1ck2xElonD8u6RH6Cph2DGoDr6JNkII/6OPmNp/QRgr7R6L4wyZvbsmPbF98wiW8KBGuzi28cgmMig8C4Ysy5aVqw5ZYtjNN5t5Hf3enXuBmkUskML6ykpg9MUoURWutsQIv1E2s5GCEpdPmVeKvs1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by CH1PR12MB9718.namprd12.prod.outlook.com (2603:10b6:610:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 04:26:18 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 04:26:18 +0000
Message-ID: <63d485c3-a418-493d-aad0-26b3c115f5b8@amd.com>
Date: Tue, 18 Aug 2026 12:26:10 +0800
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
 <3c3eb833-8026-44ad-8e33-dea346752db2@amd.com>
 <33bf6649-c1b9-43f6-94dd-09167d8e5db6@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <33bf6649-c1b9-43f6-94dd-09167d8e5db6@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI3PR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:4:297::12) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|CH1PR12MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: 19521991-14fa-444e-3d62-08defce0d950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|22082099003|18002099003|10067099003|5023799004|11063799006|56012099006|4143699003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	e2s/U/8c336VOGIwxlSClXGS2CeJ0yn/aH9LBriewNJmqpn7ueVJ5J2qyxmqFAF2yFXLbVZu7B/Nsh4tE+pYCaDTOe3Nul9rfuOKRVEdHHF1Wlc56pCaIsVTNvgTymmt7q8GMWn+Le8WMAyhkv8TIkaxrZE0SqxoyhSMTioChDMlpQow9/B+MfsE0XxkFOGcdPNG7/9j3HvojorzBRe83eD/5uPb8oRa8U4EENI3AOKCJFv03vw+t1m46/Cj7tPTsx3XNmkVc6XYmmLQ4xXOf75iVaFJVyKjoGy1Ssh1gotlP1qSSdCKmrofW1zzyrJswxkiSBMLZTXX+5q8zf39cSDFiNltvTs3lr62rNptKVHXWdh68OJ3jKpG1IjzpFKkFi3g8dyJlDxsAGv5Zd7CNVPXXUWd0u/kBWtBmcYkoAWHwXeFtqonocRWqpoOvF9bErrFznsfeRYBrAuHGtVK70k2q27dv96OGeJOgwgdUJq+VlOz6sM0vgyk8G2SfN513MrksWuEncatgnFiba7Omh9tbLHOyt24mpzZryLy3cPxn6UtDpvMDMvvfLu73MXhJkWgT7tY4hl2bhNE3cLc9sTpu0sk30SL3P1VwEfFB4LeDYHAVjIPbVbAMWp8+PJhHLN2MFWyOG9d4hDAHW8Pc6QTG3ZA/IgPP+MCDsNLcBM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(5023799004)(11063799006)(56012099006)(4143699003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHB6S205YitUQmlrU0RGd2VkaXBUQWttVXFDb283eVphYkdQOUIzaGQrRkk5?=
 =?utf-8?B?dkJJZG5IUjdiKzd6QUZNcmhtRTNpbThlNG5OeVlYNUdYM3hIcWsxM3M0K0pt?=
 =?utf-8?B?Nmx2aWpkd0RzN0FLMVcrcXVOWW1RdXMrOHBLWm1lRlNjbmdVSll4NVRudU4x?=
 =?utf-8?B?SUVkRWMxTm5VNTRpYWlVSUZRQWNRNVFvMnFHMGFnYTlKbHRYMFhpNW1rTUtN?=
 =?utf-8?B?VHloeTFicVJHbkFEMVllSExHTGJQU0N0aDVGc3F0RHJOaVRLY05jVUlOY1dt?=
 =?utf-8?B?VHdWM0lpUDdLVWpUTnYyZ29JZDFnT1BteFF1YzdVK2dYZFY3T2FPZ0YyRGRx?=
 =?utf-8?B?cjhtS3VVamszbjVtNkJXYTUvL0dDc2NXY29LMVNvT1djZTVISHk2OGYycmth?=
 =?utf-8?B?bUJiVDBhanZ0ZXlQbVljZkRNYmtob0NkSUJlcDRSMVMrK3FkbGtxVXN6R2Jj?=
 =?utf-8?B?Nkh6TVR2S0hBSGlsYk5VWkQ4TlhmaXd4bzdVVUNRNW9EaTZLOEdrVmRMRVVa?=
 =?utf-8?B?eTVlTUc1ODNRUHBlR1Z5ZlQwUnNJNWdZbDliUGRidmNDOVFLaGtvL0Z0eWlz?=
 =?utf-8?B?aml2eTUxSXBOa3JwK1dQRjNtNDdPazhiSFhMUVVGOS96clZlSmFjSVdyWWJp?=
 =?utf-8?B?bGJFMHlLN0VGQk93ekU0WGNrOWEraTU2ZERxU0EvVFZjVXRac1UxcGorTXVh?=
 =?utf-8?B?cVEyMW1ueTJFd1ExU1l2aHNjS0NrUUllUy9kcVJZQW9TdDhpQklhWDdhNSt4?=
 =?utf-8?B?RU5MRVlqVDhHZDl6T0NpY1dlbzl6M1F4aER6Z3kyY0hXVS9sN1JLV29HcmxU?=
 =?utf-8?B?Y0xjMzNwV0lOWENiaURkU2pMMXFhZmRlaVAvaGwzUFVsamgyU1lwSkw1OHY5?=
 =?utf-8?B?NTVIU2xGUmJERm9YbzNXbURzNHJkL3orOUx6WWFrMnB3VCt4dFR3UWI4NFpX?=
 =?utf-8?B?OUpEb0lodjNDM2NmQzd4S0QvZUJUekNOMW1WYkJ0aVRkamhjWDc1eFdBN0Zo?=
 =?utf-8?B?MG5mTWhwaHJRa1QxY2xtODYyZkUxTDRsbEQ4OC91d2s3NjZYTDVUd1pMNkFu?=
 =?utf-8?B?Tjh2dU1hajZaVDVSNUEraThheGF1K3hHZVQyN0w2eG81RWd4YXdmY2pyTjBH?=
 =?utf-8?B?azFnWWMvU01oeG0yaU42ZStaR1ZiSzlUZEVTVjAzbUM3TUw1QVRwZWNrTXBq?=
 =?utf-8?B?MnJLTEZnaW5RQUs4UWp2NTlTOWJJMzRYMXJyMWJlbFJOYzFYN2F3MEVmL3NL?=
 =?utf-8?B?cDFsS0xWV1NIb2VPekhqOHRSTE4vMFRySXNUZ2JJNHBvKzJLNVZsbHZDWUJ1?=
 =?utf-8?B?UHJaTjlQVDBaVDVHdWpYR0N0MUtpTEN4WTJSSmZ0ZHFOSzQ1QWhLekcraDZk?=
 =?utf-8?B?TWo3TUx1N0pIN1hoanQwZjhIVG9WVjNrSFZsdkMrWU0yWkxLUjR3cWQ2VFJt?=
 =?utf-8?B?b0liWCsvcHlRUWVjdHZVelAyeC9ic1g4L01raEFIZGRvbit6cDFrWVBjdUdn?=
 =?utf-8?B?L25HNmthclRGYzQzZU5pTXU1SXJKZFBYbkhQaFN5OTdjYUp6aW4xN3M4d2JM?=
 =?utf-8?B?TEc3dTBneEJNZ0RhYWVXdG9laDVpS1QwTTN3SXVFK2JPK3kyOHJONG5rVjBE?=
 =?utf-8?B?M1pROGdWT3Vuei9NdExNOXRnVG5TQ1p1ank2WjhCanRwNHAxa0pjakNtTWVw?=
 =?utf-8?B?eWpXcWN4K2VPNkJhL3dJS2VvZUE3R1VRbGZ4RDBDb0J4RXFEYitRdCtGeVRF?=
 =?utf-8?B?bVFUeGxlZzdIcHVtb25RWVlaNmdnWndRODcvN3l5bEpyeXNPWFVSbWY3VDNH?=
 =?utf-8?B?bERwVXV4T0o0bVJSblBvb3hBTERNcGg1MkYxOUVidzFBU2ZiUUdhVmgyWmR5?=
 =?utf-8?B?K0owQmRmT05lcXRVc2c4VVBkUDd2SE0wdDcxYXpueDJybTUyb3RyWit1S1Js?=
 =?utf-8?B?WkVCQUhvdWxSeUFsWTBjbkhlVngxbDhTaW11bjZnNzY0aFhJbGpnZU83bU1G?=
 =?utf-8?B?WGxWUzZPQVFMcm1vVUlKNWtlUC9TWHNLYkxaZys2QkNNa0IreE9SMzljL1lR?=
 =?utf-8?B?azRHRHFiWkNhWHFIL1Rvc2wrZ09CdHN2UzdJQm45UmFKcXR4cm5nL1BVWU1m?=
 =?utf-8?B?TlZwdTQxYTM4QXIxdmE5KzNkUTJWZC82YkZZbVBOaHNKdnR3VnFtUHJIZ1h0?=
 =?utf-8?B?SUQwSVFsWUFUL0Rjc1Q2THdNMFhrS2xjbG5uUjlVaXM2RngyaHlodWVwYTR5?=
 =?utf-8?B?dWxyUFBHT090TVlIdndreXYwYzZwNHFFWGtlOXhDcW1VdGR4VWtxR054RjlU?=
 =?utf-8?Q?d9Ho6jQOd5G9Rnr7iQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19521991-14fa-444e-3d62-08defce0d950
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 04:26:18.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlCba+vZ9c9UctnhuwJhPNxdnre1omHM+HVsAV6kV+FXUOF8iBBCavIaEUU8VzW7F/X7/81opNeyo6YWIavtGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9718



On 8/18/2026 12:05 PM, Akihiko Odaki wrote:
> On 2026/08/18 11:50, Huang, Honglei wrote:
>>
>>
>> On 8/18/2026 12:29 AM, Akihiko Odaki wrote:
>>> On 2026/08/17 22:44, Huang, Honglei wrote:
>>>>
>>>>
>>>> On 8/17/2026 7:44 PM, Akihiko Odaki wrote:
>>>>> On 2026/08/17 12:19, Huang, Honglei wrote:
>>>>>>
>>>>>> Hi Michael, Alex, Dmitry, Akihiko,
>>>>>
>>>>> Hi Honglei,
>>>>>
>>>>>>
>>>>>> I'm bringing AMD GPU compute ROCm based on virtio. I posted a ROCm 
>>>>>> over virtio
>>>>>> implementation to virglrenderer nine months ago (MR !1568 [1]). 
>>>>>> The ROCm side has
>>>>>> been supportted by ROCm offical.
>>>>>>
>>>>>> Current implementation is a virtio gpu context type capset handled 
>>>>>> inside
>>>>>> virglrenderer, sharing the display path. That's an awkward fit, many
>>>>>> compute GPUs have no display engine at all.
>>>>>
>>>>> I think "sharing the display path" conflates several layers and 
>>>>> makes the problem difficult to assess. It would help to identify 
>>>>> the concrete constraint behind "awkward fit."
>>>>>
>>>>> End-to-end, there are four relevant layers:
>>>>>
>>>>> 1. Host GPU stack: hardware, host kernel, and host userspace
>>>>> 2. Paravirtualization stack: virglrenderer and QEMU
>>>>
>>>> Yes we are asking can we add a new file like virtio-gpu specific for 
>>>> compute, but maybe we can only add a new backend like virglrenderer 
>>>> specific for compute.
>>>>
>>>>> 3. Host/guest interface: virtio and the capset-specific command stream
>>>>
>>>> In this plan we may need just add a capset id.
>>>>
>>>>> 4. Guest GPU stack: guest kernel and guest userspace
>>>>
>>>> Won't modify the guest kernel in this plan, this email list.
>>>>
>>>>>
>>>>> Orthogonally, acceleration is separate from display and scanout. A
>>>>> physical device may provide both, but acceleration does not require a
>>>>> display engine. Linux likewise exposes render and compute interfaces
>>>>> separately from modesetting. The userspace interface virglrenderer 
>>>>> uses is messy; there is Vulkan, EGL, OpenGL, and now you are adding 
>>>>> ROCm. But there is one thing I must note is that acceleration and 
>>>>> display is decoupled, and acceleration does not require display.
>>>>
>>>> Yes totally agreed.
>>>>
>>>>>
>>>>> At the protocol layer, context command buffers are carried by 
>>>>> VIRTIO_GPU_CMD_SUBMIT_3D. Scanout uses separate core virtio-gpu 
>>>>> commands, and VIRTIO_GPU_CMD_GET_DISPLAY_INFO may report no enabled 
>>>>> displays. At the implementation layer, QEMU handles scanout 
>>>>> presentation. virgl_cmd_set_scanout() obtains resource information 
>>>>> through virgl_renderer_resource_get_info() or 
>>>>> virgl_renderer_resource_get_info_ext(). That does not make scanout 
>>>>> a virglrenderer-owned display path.
>>>>
>>>> Yes, agreed.
>>>>
>>>>>
>>>>> Therefore, if "sharing the display path" means sharing the same 
>>>>> device, control queue, and QEMU execution context, that identifies 
>>>>> a possible source of contention. If it means that capsets or 
>>>>> virglrenderer are inherently tied to display, I do not think that 
>>>>> is accurate. Vulkan compute is already used through Venus with 
>>>>> libkrun [2], and VCL proposes OpenCL support through virglrenderer 
>>>>> [3].
>>>>
>>>> Yes，but the vulkan is for GFX originally, and for some formal AI 
>>>> frame work like pytorch, it's support is limited, and it performance 
>>>> is lower than ROCm, and vulkan also lacks many AI infrastructure, 
>>>> like composable kernel.
>>>> And for virCL, actually it is came from same project with ROCm 
>>>> native context, but the original author didn't continue to support 
>>>> it, they handed it over to someone else to take over. And in the 
>>>> first version of
>>>> virCL, it didn't pass the test of actual projects.
>>>>
>>>> And it seems like virCL didn't upstream into virglrenderer also, 
>>>> correct me if I am wrong.
>>>
>>> I cited Venus and VCL only as examples showing that virtio-gpu and
>>> virglrenderer are not intrinsically tied to display. I did not suggest
>>> either as a substitute for ROCm.
>>>
>>>>
>>>>>> Beyond that, sharing the display path is increasingly painful:
>>>>>>
>>>>>>    - Compute hammers the queues more than graphics, so sharing
>>>>>>      virtio gpu's single control queue with display/virgl causes 
>>>>>> contention
>>>>>>      and display stutter.
>>>>>
>>>>> All non-cursor commands do share one control queue, but a fence 
>>>>> avoids serialization.
>>>>
>>>> yes, agreed.
>>>>
>>>>>
>>>>> There may still be implementation-level contention, and it is not
>>>>> necessarily specific to compute. A sufficiently busy graphics workload
>>>>> could expose the same bottlenecks. Possible contributors in current 
>>>>> QEMU
>>>>> include:
>>>>>
>>>>> a) qemu_console_hw_gl_block() blocks the entire queue when QEMU only
>>>>>     needs to fence scanout commands.
>>>>
>>>> Yes, agreed.
>>>>
>>>>>
>>>>> b) virtio_gpu_virgl_unmap_resource_blob() may also block the entire
>>>>>     queue just to delay one command.
>>>>
>>>> Yes, but it is seems like it is must, someone else in AMD tried to 
>>>> use async method to relase blob, but it failed to consistency issue, 
>>>> then
>>>> reverted to sync version.
>>>
>>> Queue-wide suspension is not inherently required. Commit 4eb0aace85f5 
>>> ("virtio-gpu: Support mapping hostmem blobs with map_fixed") added a 
>>> path that avoids per-blob MemoryRegion teardown when 
>>> virgl_renderer_resource_map_fixed() succeeds. The remaining path is 
>>> also being improved with:
>>>
>>> https://lore.kernel.org/qemu-devel/20260424-force_rcu-v4-0- 
>>> feccfaca0568@rsg.ci.i.u-tokyo.ac.jp/
>>> ("[PATCH v4 0/6] virtio-gpu: Force RCU when unmapping blob")
>>
>> Thanks. force_rcu is a clean fix for the RCU-reclamation part, but it 
>> still keeps the unmap synchronous and serial.
>>
>>>
>>>>
>>>>>
>>>>> c) QEMU dispatches the control queue and calls into virglrenderer from
>>>>>     its main-loop thread along with display work and many other 
>>>>> things.
>>>>>     Venus's render server can offload renderer work, but control-queue
>>>>>     dispatch remains in QEMU's main loop.
>>>>
>>>> Yes, we did some async optimization in ROCm context, but its 
>>>> effectiveness is limited, see bellow.
>>>>
>>>>>
>>>>> In any case, I think you need to do some experiments to track down 
>>>>> the real cause. a) is easy to check: just comment out all 
>>>>> qemu_console_hw_gl_block() calls; it may corrupt display but 
>>>>> removes the blocking. b) can also be tested by leaking the mappings 
>>>>> instead of blocking the whole queue. Using a different display 
>>>>> device like qxl tells whether c) is causing contention.
>>>>
>>>> Yes, totally agreed. following is my findings. In short words:
>>>>
>>>> Optimization can reduce queue pressure, but it can't withstand 
>>>> absolute overload because each command has some overhead. Making all 
>>>> commands asynchronous would lead to a debugging hell about 
>>>> asynchronous issues.
>>>> And we have high load applications rocmprofiler  that continuously 
>>>> catch information need virtio queue to handle. But create a new 
>>>> backend can not solve it simply, we are trying to find a way. like 
>>>> shmem between guest and host, then use cpu polling, bypass the 
>>>> virtqueue.
>>>
>>> Most commands are fast on the CPU side, while heavy processing
>>> happens asynchronously on the GPU. Cases (a) and (b) are exceptions.
>>>
>>>>
>>>> The load is mostly memory management. Running an AI model allocates 
>>>> and frees a large number of blobs. We already did some optimization 
>>>> release them asynchronously, but the host processing is a single 
>>>> queue one
>>>> process_cmdq, this is where the main bottleneck in my debugging 
>>>> work / my understanding so far. I'm not certain it's the whole 
>>>> picture, so please correct if I am wrong.
>>>>
>>>> A model load or unload frees a large batch of BOs and allocates 
>>>> another. Some of those commands are async in the virtio-gpu guest 
>>>> driver, but QEMU still has to work through them on the one queue, 
>>>> which takes time; so even though any single command is quick, there 
>>>> are simply too many of them, the single queue backs up, and 
>>>> everything behind it, gets delayed.
>>>>
>>>> real work load (a few downstream customisations): loading one 16 GB 
>>>> model (gemm4 e4b), drives ~1200 blob creates, a burst of
>>>> ~1400 resource frees at teardown, ~3700 submits and ~6000 virtqueue 
>>>> notifies, caused a 22 s guest soft lockup. And the behavior of 
>>>> memory operations are controlled by upper layer like pytorch / HIP / 
>>>> runtime,
>>>> we can not control it.
>>>>
>>>> To be honest, a separate backend won't fix this. But the real 
>>>> solution maybe is compute specific. That logic is only useful to the 
>>>> compute path, and folding it into the shared display device / 
>>>> renderer would mean churning code that is mature and stable for 
>>>> graphics, with regression risk. Keeping compute on its own instance 
>>>> and backend lets us iterate on these compute only optimisations.
>>>
>>> A 22-second lockup is too long for those command counts.
>>>
>>> The most probable explanation I have is that the ROCm integration 
>>> blocks QEMU's main loop thread while synchronously waiting for GPU 
>>> execution. Creating separate devices won't resolve this because the 
>>> main loop thread is shared, and synchronously waiting on the GPU 
>>> should be avoided in the first place.
>>
>> No synchronously waiting in ROCm backend, we are using user queue, and 
>> event waiting, no sync operation in CMD wait. all the resource release 
>> in ROCm are all async now.
>> Only the sync thing is memory thing mapping/unmapping in qemu, as long 
>> as it remains synchronous, it will be overwhelmed by the massive 
>> number of requests.
> 
> Mapping and unmapping should not block QEMU's main-loop thread for that
> long. The command counts you reported are relatively small. That is why
> I suspect something else went wrong, such as the main-loop thread being
> inadvertently blocked while waiting for the GPU.

Will investigate it.

> 
>>
>>>
>>> In any case, profiling is necessary before touching the implementation.
>>>
>>>>
>>>>>
>>>>>>    - Compute contexts need far more blob / shared memory than a 
>>>>>> display one.
>>>>>
>>>>> It is not a problem by itself. Frequent mapping and unmapping might 
>>>>> amplify the second issue above, but that needs to be measured.
>>>>
>>>> Yes, agreed. I can give more detailed information.
>>>>
>>>>>
>>>>>>    - Maybe needs a wider ROCm / compute stack, cause the render 
>>>>>> model fits poorly:
>>>>>>      rocprofiler (PC sampling, SQTT/SPM, counters, high bandwidth 
>>>>>> streams)
>>>>>>      and ROCgdb (wave control, address watch, async exceptions an
>>>>>>      out of band channel that must not block display).
>>>>>
>>>>> virglrenderer does not impose a particular render model. That's why 
>>>>> Vulkan Compute just works with Venus.
>>>>
>>>> Yes but vulkan is used for GFX initally. And can not support many AI 
>>>> application.>
>>>>>>    - Events, faults and GPU reset/SMI are async and don't map onto 
>>>>>> fences.>    - All of this is hard to extend cleanly inside a 
>>>>>> display capset.
>>>>> Capset is not about display but determines the protocol of the 
>>>>> VIRTIO_GPU_CMD_SUBMIT_3D command stream. You have described events, 
>>>>> faults and GPU reset/SMI are async don't map onto fences that may 
>>>>> be associated with VIRTIO_GPU_CMD_SUBMIT_3D which is dictated by 
>>>>> capset. An additional feature may be necessary, and it may or may 
>>>>> not be dictated by capset. The other things are irrelevant with the 
>>>>> protocol capset represents; they are either behavioral or about 
>>>>> different commands.
>>>>
>>>> A fence is the one shot, but event is stateful and repeatable.
>>>> That may or may not be tied to capset. Agreed.
>>>>
>>>>>
>>>>>>
>>>>>> On the QEMU/host side, would something like this be OK? One step, 
>>>>>> two parts:
>>>>>>
>>>>>>    - a dedicated headless virtio gpu instance for compute.
>>>>>
>>>>> A second device would isolate its virtqueues and device-wide
>>>>> renderer_blocked state. That may be useful if measurements show that
>>>>> these are the bottlenecks, but it is not yet clear that they are or 
>>>>> that
>>>>> a second device is the appropriate solution.
>>>>>
>>>>>>    - that instance served by a separate ROCm backend library loaded
>>>>>>      in-process by QEMU.
>>>>>
>>>>> First, I think we need to establish why ROCm cannot or should not 
>>>>> remain
>>>>> in virglrenderer. The virglrenderer, Venus, and VCL maintainers are
>>>>> likely better placed to advise on that boundary. Once the protocol
>>>>> requirements and performance measurements are clear, we can assess the
>>>>> appropriate QEMU integration.
>>>>
>>>> venus is borned for GFX.
>>>> virCL not merged.
>>>>
>>>> To be clear, I'm not saying virglrenderer can't host a ROCm native 
>>>> context it clearly can. My hesitation is more about fit and 
>>>> direction: virglrenderer has grown up around GL/graphics, and I 
>>>> haven't yet found compute oriented plumbing there to build on, while 
>>>> ROCm moves very fast and I need something I can keep current with 
>>>> low friction.
>>>
>>> Whether keeping ROCm in virglrenderer would create extra friction is 
>>> primarily a question for the virglrenderer maintainers. Its graphics 
>>> origins do not by themselves motivate adding a separate backend 
>>> interface to QEMU.
>>
>> Fair. The first draft version in virglrenderer was in May 2024, and 
>> ROCm has gone 5.7 → 7.14 in that window.
> 
> One point to note is that virtio-gpu development in QEMU is somewhat
> less active. crosvm is the most active user of virglrenderer, and QEMU
> sometimes lags behind it. If you are considering moving the ROCm 
> integration from virglrenderer to QEMU solely because ROCm evolves 
> rapidly, I do not think that would be a good idea. A rapidly evolving 
> component is better kept in virglrenderer unless there is another reason 
> to place it in QEMU.

Actually didn't see something new about compute merged in to 
virglrenderer this recently 2 years.

Regards,
Honglei

> 
> Regards,
> Akihiko Odaki

