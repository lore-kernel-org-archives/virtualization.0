Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013025.outbound.protection.outlook.com [40.107.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B7E43B6CB
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043214; cv=fail; b=I1JEBlHv61IcrfNylx56fVDZENbZEn9J2NslU65k7ezfT3q6DV4LJBj56qRqTDhWGDrAlgOR+jzRiIh9j/R4Q1pRu20p5LQGBNtBRivZ09j5kFv9QhK0tEDggMx4Wu2RpYkS6MSjyBV+25RuQucaxZX9kV8wQUePQKijc0Sijvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043214; c=relaxed/simple;
	bh=V++yPpoqVVW8FbQ8Dsf2+8AwZwGmDg/lezaZWUVYRcU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jtaDY1cZeyEINh5kBZ+TeYAzfBnkDrdBXopKN/5q66pJy9zN74iU7N+vmIUIfql8JA58r3AfgiZVA4pLd0fIeknKaOMc0h2fQmJpfRyTDoEIXcu0u0rNw42ABrejV9WeKhFgReQ77AlwQsXDpT+dB6sSidrwyb5XZYf9Abf0OtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4956vE8R; arc=fail smtp.client-ip=40.107.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4956vE8R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxpUvezp8czNufb1vx9AZx4M8Q/0MpoPBAhPthzN1I3sTNkQUajj8hZsehU5U/NXrsJC/66VXBPTLj0O0iFTq67gTFFRccgo7kQyshsJgmSijuLprFnlXbVxb/Oi6sxxEpbZyO7JEWar1vZihiNWn8kv1NuwiCLOsOEy7b2qEr6kD0tVyAyzWU1KGyM3CkjZc+4fRauCCAGK7GvO+bPuVDsm4T2WBlUAvRIyGnJ9bYy89rjRtbFmCF9e9KLv8+k8l4/77n2k/R8MRJ+AfT464EUHNQkXFiLk4A2wI/spS4/hjbhJC84VddMd6oPa3sUNN7P03XfYSQTiEKBobNGPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SK+PfpoLV2N6/L9FcV4wsGDjjfd+pYck9JqdJfErCZk=;
 b=qsLtt4CdrUZyKvMESVP/PH7hPKEzJRl1Bnt2mjyC8AJJ0lnJ17xCtpCMzlZ78StvJj1n8jE/qHnTEB4MrDQYF4GLnMGlk1/F6ZoNDxZCxephcHjni5BBs2UqNGfBqDW8WfW/K2m5X6xwV2MxeAJBZNyAayC55YNRp0Z74ygMMiUTnbQ30Q4zxUyCmloYoOpuVanOMsTm2YnQFHm1TlDSqAAW8IaBEfBNCEomBWpxRqCkU98/ntmAGbQeRVxnpnduyQmg/YfITHW7Rs+r8z7tLsg02vEPOs2Gto+iYtv7+Z7WXIsckEANN62UgUWG5hc1o5rcXyY7VJtjblyUc1BvRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SK+PfpoLV2N6/L9FcV4wsGDjjfd+pYck9JqdJfErCZk=;
 b=4956vE8RkEHi6mvGfDX5g9TtI4ajVmuXzCyr4sozLfUVuXfmYqIydMpDgcF7zT2VGwQOPYa2K0Gj+jGf4SNAHZrqTZ676u+iPQEVZSVUrrr7j4mq7o7nKaR62Adm7TQ0OBoAvF5J6FAu5Y0r+FYqTG1HdWzcS6DClV1F9s43Px8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 08:53:27 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 08:53:27 +0000
Message-ID: <ef751787-8688-4e30-8bc4-f1740ef162fc@amd.com>
Date: Tue, 18 Aug 2026 16:53:18 +0800
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
 <63d485c3-a418-493d-aad0-26b3c115f5b8@amd.com>
 <7fa93963-880b-47fd-a51b-880a651be963@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <7fa93963-880b-47fd-a51b-880a651be963@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU2P306CA0051.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3d::12) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|MN6PR12MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d8833d2-d7c0-4745-cb06-08defd062b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003|5023799004|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	m4Ij//bfr5hPi4KQLt+M6snt+SIHyOuwGrDPbPouEoETlapQ/MQQ4ZM5qs5+eR6x7rplXy+2vrSTL//VJOV2B6hwaoILNGTLYj3Xz3T8lktcBRWK29jjdkyyok4hOptHqnZQIhHCRLhcMKYCGvSupR0apQRCljkibZBc+jet+bGt+Shw7Nlx9eFdXgr0IRhtyi8m/mDwWHFNltRVqkMMhHbTPasHXBuqLRgonJm21Mjt29i4SP2xt+2j12dbjqeqrw1a9P1yOgK8hqiBX8dhfG7MWXH9ccAaRbhJss+Ri3DcdDIqEBE0arimiuKbPA6sBTfuWcMKE8HZphahkrWA7KcwY5flRzZMOGN8z2p4uVbAMaz/PAcWemAnJ3wvQ8C5buvRXa/avFajyr6Hu3/3IfDf+FxeOPHxxhWaqB3GIq2KyKSfKSAzE4w91GFHWqD/kncVAdVhdxKYCJPmYcRrm2OwZ2wkzIgjX6xNtsymPipehpg+qQg/goqUo4DmHA+GJsWw9KY2sVQHGyh5OhlUzeauC4vzeSB1ls8Y3UB+629UqknX/ipcjXnPw6lbd7dHHvcXzyEul/cr5KNmfryxmS6cvdQjKSdmwUlzgO8E2uWC4HBDmIzDusPFd3K1GxMk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(5023799004)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXRESk9lSHMrekpQVTBINEU0YThPMHB5RWpUN04vMVVZOUlqNEkyTmttNXhG?=
 =?utf-8?B?bi9EVkJlVENOTHQ3SksrVllkR05LSUUvUEdJOC9LSTFHRjdrQW1NSzQrNHMz?=
 =?utf-8?B?RmlxR0FFZUZmOGpOTFJERWZzNmg4VnlJd0doWDdWeGVRck5PSjczYVZtdHhs?=
 =?utf-8?B?cytFeWxub0JjT0h1WkVrMmQzdVR1ZHZTejM4TU9mQ3d1UWdxV01XNnJPQWw5?=
 =?utf-8?B?SG1VTk9tRXlaTXg0T0QrUDk4Mmc1citneTNXT1YyQlFIQUUvQXgvTWM1ZEI5?=
 =?utf-8?B?NDlVU2l3YWV3K2RrRU8wc3JURFU2N01XQkpsNmkzVmFvcnRocjRGd3VkcVVV?=
 =?utf-8?B?WC9DWmIwbnFsNnNKd3kzaVhTR3VIR2NxZjZqV3JQUHd2QWVVUUNuQlF6ZXpG?=
 =?utf-8?B?dzAxME0wWGFvZUlOZXdwZHFXQ3lOK0ZjU0k0eUFvWUh3UVdmV0k0S0Viak1l?=
 =?utf-8?B?RXV5cE5vTGpuMVRuOTE2WTRyT2R4cEVmbmlHVndXU0RrWHNhMnhocGdpcnNX?=
 =?utf-8?B?TEFlTW5WVmxtL0d4RlRGQXVvc0txRW9wWndaMlV2dFBwbldGT1JQaGZIakpO?=
 =?utf-8?B?dmhlM0o0ZUJHWGRSZ0xjOVZ2YWhCcTJTRjV5NWJlM3o4bWEvZ3k1OXV1RlI5?=
 =?utf-8?B?L05DQnpJNXNHT0xEUjdES21paU1mWlJrYzJQQkZIRXg1VlVCMUErRGNrYTd4?=
 =?utf-8?B?ckJhakhSSitnbjA3Y2RCRExnWmZqc1NCSzM4MHFmeWRySnluTm1sTnoyOHFV?=
 =?utf-8?B?SkRVS1hlWXU0ZTA1dlY3M2RycU5MRHRoQUE0d25pK1VQcWF2S1J2U09PRlMw?=
 =?utf-8?B?VW1BbHN0dHJIcTJZMjc3V01oTllkWEpISGxqMm5xRDlHNStPbHc2TnFiY085?=
 =?utf-8?B?R0s3WHovUFloRTJDd2c1RVpTOTlHOE13UEJoZkxlZmxhZEpid1RPZzlab2pq?=
 =?utf-8?B?Wm1HajJGZFMvRGJWdVJ1V2FSVWJrRzdPZDhENUhENHVrenU2dk0wcEdncDNW?=
 =?utf-8?B?Y3R5QkJIaTlSN21ISjJkdUNIbkphR0VQNktKSGpadS9DY1pZYmlPU25KeE9B?=
 =?utf-8?B?UXpFRU51QnJwK2Rjd0RaTDVhdWtXSHRUSk5ld0J2Z0M4Y2xaNmNhaitHMWYv?=
 =?utf-8?B?aklNK2FGWUUvaVZJWGJtMUdtWVlzV0pVaFFta21RbVJMRVdIN0JBS2NYWVFx?=
 =?utf-8?B?MW9BMURXcjdVUVRSdlo3MzlEMWo3RktRVE1COFRLY2RwZi8yNFl4amRRTmxE?=
 =?utf-8?B?WUhDc3l0Uis0ZUlDR0d6bVdHaXAxVjhOOFBkNk9MV2FrMjFnZDZab0Q1d1R6?=
 =?utf-8?B?d2hDdkUvdGt1T0didGJWUmxBNUxkMUhRWVpwSTJQWUc2dmtPYkpXOGg1ZUs5?=
 =?utf-8?B?YTZrQlc0WjVUUHcxanRoVW1SU0VxRU1uSURZYWhwampKZUUvZFI2RkRzTzg1?=
 =?utf-8?B?RXhvaXlRMU4vbDlOdVZDa29tMjRyZXdvVTJQZ3EvMXFFanVueHlmYnlnekJG?=
 =?utf-8?B?RS92bklIRCtGVkVzSEVBbXA3Q2g2MjdSVFlWaDFtaHZZejVHSHIvNlF5YU8r?=
 =?utf-8?B?ZDBYc3IzYy8xY09kZXU4S2QvWGY2Q1hBYmFRbHpFRWlHQXl0NmV1Y3VNblJn?=
 =?utf-8?B?bTVWUHFkTmxlTU83eEFPQTdRVmdmRTJRT1QrYjFNeGRadjM2bnJMWFlaeWVL?=
 =?utf-8?B?QThod3EyZWErZTFoZHRLNDhiWk11cnFxWGJuRy9hcEdlQnhocllrTVhMOTd1?=
 =?utf-8?B?alNFNkJLUWV0Kys4T21tbG5nT0ZqQ00vQVhxVkRJdG9VZG5hTit4dDdydEVh?=
 =?utf-8?B?cVlsRERPckRsTnZRUituQ1pRRjV2akF5NkEzbWEvb25hTVdJUlFxdjJDelRa?=
 =?utf-8?B?MW4zODNlOThlMFpxcE1vMVZXY2hEZlhONGw2UitpYWhGWGVFRUlaeDZWbmRs?=
 =?utf-8?B?N2VUVnhId3ZmaEJlN2hRMkFTSXZLN2NJd1dFV1UrdlloT0FYWDJ2N2t3dm0y?=
 =?utf-8?B?NnM0UjNMTzhiT2loZHE3ayt3VEZIV1RqRUlmZHNlY2REWFRkdTV6MXVnUFBs?=
 =?utf-8?B?SnVuSVhhS1lrYlRBSVV5c285dTl6M08xZjhOcStEV1VlQk8zTHMzeVFYd3Na?=
 =?utf-8?B?MHlDUXZsM3d0K2VOM1RuS3dObENVTjZuY2lSYUVoMy9wMTFyaHhOblloQ21t?=
 =?utf-8?B?bElIWGt0bWx6Y3A5S1pvVC9nS0E5ZVZPbWZuc3R6UTF6SEVneUpIMTllQnpw?=
 =?utf-8?B?OHpsU1pkYTVxcjBGRHRIa2JiQlV6amxUME1GazB6RnBpWDJKeTFLRk9KS05t?=
 =?utf-8?Q?5JqGVhp2Lys08sRREQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8833d2-d7c0-4745-cb06-08defd062b13
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 08:53:27.1371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6OPijnjkcGVtGoX3fmbH0v/jSwOwvRd2TjpUNw+ibZHneRN7UF/W+udlpjlA0DBl31Qv+VJeaAByPgeOSnfDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471



On 8/18/2026 3:50 PM, Akihiko Odaki wrote:
> On 2026/08/18 13:26, Huang, Honglei wrote:
>>
>>
>> On 8/18/2026 12:05 PM, Akihiko Odaki wrote:
>>> On 2026/08/18 11:50, Huang, Honglei wrote:
>>>>
>>>>
>>>> On 8/18/2026 12:29 AM, Akihiko Odaki wrote:
>>>>> On 2026/08/17 22:44, Huang, Honglei wrote:
>>>>>>
>>>>>>
>>>>>> On 8/17/2026 7:44 PM, Akihiko Odaki wrote:
>>>>>>> On 2026/08/17 12:19, Huang, Honglei wrote:
>>>>>>>>
>>>>>>>> Hi Michael, Alex, Dmitry, Akihiko,
>>>>>>>
>>>>>>> Hi Honglei,
>>>>>>>
>>>>>>>>
>>>>>>>> I'm bringing AMD GPU compute ROCm based on virtio. I posted a 
>>>>>>>> ROCm over virtio
>>>>>>>> implementation to virglrenderer nine months ago (MR !1568 [1]). 
>>>>>>>> The ROCm side has
>>>>>>>> been supportted by ROCm offical.
>>>>>>>>
>>>>>>>> Current implementation is a virtio gpu context type capset 
>>>>>>>> handled inside
>>>>>>>> virglrenderer, sharing the display path. That's an awkward fit, 
>>>>>>>> many
>>>>>>>> compute GPUs have no display engine at all.
>>>>>>>
>>>>>>> I think "sharing the display path" conflates several layers and 
>>>>>>> makes the problem difficult to assess. It would help to identify 
>>>>>>> the concrete constraint behind "awkward fit."
>>>>>>>
>>>>>>> End-to-end, there are four relevant layers:
>>>>>>>
>>>>>>> 1. Host GPU stack: hardware, host kernel, and host userspace
>>>>>>> 2. Paravirtualization stack: virglrenderer and QEMU
>>>>>>
>>>>>> Yes we are asking can we add a new file like virtio-gpu specific 
>>>>>> for compute, but maybe we can only add a new backend like 
>>>>>> virglrenderer specific for compute.
>>>>>>
>>>>>>> 3. Host/guest interface: virtio and the capset-specific command 
>>>>>>> stream
>>>>>>
>>>>>> In this plan we may need just add a capset id.
>>>>>>
>>>>>>> 4. Guest GPU stack: guest kernel and guest userspace
>>>>>>
>>>>>> Won't modify the guest kernel in this plan, this email list.
>>>>>>
>>>>>>>
>>>>>>> Orthogonally, acceleration is separate from display and scanout. A
>>>>>>> physical device may provide both, but acceleration does not 
>>>>>>> require a
>>>>>>> display engine. Linux likewise exposes render and compute interfaces
>>>>>>> separately from modesetting. The userspace interface 
>>>>>>> virglrenderer uses is messy; there is Vulkan, EGL, OpenGL, and 
>>>>>>> now you are adding ROCm. But there is one thing I must note is 
>>>>>>> that acceleration and display is decoupled, and acceleration does 
>>>>>>> not require display.
>>>>>>
>>>>>> Yes totally agreed.
>>>>>>
>>>>>>>
>>>>>>> At the protocol layer, context command buffers are carried by 
>>>>>>> VIRTIO_GPU_CMD_SUBMIT_3D. Scanout uses separate core virtio-gpu 
>>>>>>> commands, and VIRTIO_GPU_CMD_GET_DISPLAY_INFO may report no 
>>>>>>> enabled displays. At the implementation layer, QEMU handles 
>>>>>>> scanout presentation. virgl_cmd_set_scanout() obtains resource 
>>>>>>> information through virgl_renderer_resource_get_info() or 
>>>>>>> virgl_renderer_resource_get_info_ext(). That does not make 
>>>>>>> scanout a virglrenderer-owned display path.
>>>>>>
>>>>>> Yes, agreed.
>>>>>>
>>>>>>>
>>>>>>> Therefore, if "sharing the display path" means sharing the same 
>>>>>>> device, control queue, and QEMU execution context, that 
>>>>>>> identifies a possible source of contention. If it means that 
>>>>>>> capsets or virglrenderer are inherently tied to display, I do not 
>>>>>>> think that is accurate. Vulkan compute is already used through 
>>>>>>> Venus with libkrun [2], and VCL proposes OpenCL support through 
>>>>>>> virglrenderer [3].
>>>>>>
>>>>>> Yes，but the vulkan is for GFX originally, and for some formal AI 
>>>>>> frame work like pytorch, it's support is limited, and it 
>>>>>> performance is lower than ROCm, and vulkan also lacks many AI 
>>>>>> infrastructure, like composable kernel.
>>>>>> And for virCL, actually it is came from same project with ROCm 
>>>>>> native context, but the original author didn't continue to support 
>>>>>> it, they handed it over to someone else to take over. And in the 
>>>>>> first version of
>>>>>> virCL, it didn't pass the test of actual projects.
>>>>>>
>>>>>> And it seems like virCL didn't upstream into virglrenderer also, 
>>>>>> correct me if I am wrong.
>>>>>
>>>>> I cited Venus and VCL only as examples showing that virtio-gpu and
>>>>> virglrenderer are not intrinsically tied to display. I did not suggest
>>>>> either as a substitute for ROCm.
>>>>>
>>>>>>
>>>>>>>> Beyond that, sharing the display path is increasingly painful:
>>>>>>>>
>>>>>>>>    - Compute hammers the queues more than graphics, so sharing
>>>>>>>>      virtio gpu's single control queue with display/virgl causes 
>>>>>>>> contention
>>>>>>>>      and display stutter.
>>>>>>>
>>>>>>> All non-cursor commands do share one control queue, but a fence 
>>>>>>> avoids serialization.
>>>>>>
>>>>>> yes, agreed.
>>>>>>
>>>>>>>
>>>>>>> There may still be implementation-level contention, and it is not
>>>>>>> necessarily specific to compute. A sufficiently busy graphics 
>>>>>>> workload
>>>>>>> could expose the same bottlenecks. Possible contributors in 
>>>>>>> current QEMU
>>>>>>> include:
>>>>>>>
>>>>>>> a) qemu_console_hw_gl_block() blocks the entire queue when QEMU only
>>>>>>>     needs to fence scanout commands.
>>>>>>
>>>>>> Yes, agreed.
>>>>>>
>>>>>>>
>>>>>>> b) virtio_gpu_virgl_unmap_resource_blob() may also block the entire
>>>>>>>     queue just to delay one command.
>>>>>>
>>>>>> Yes, but it is seems like it is must, someone else in AMD tried to 
>>>>>> use async method to relase blob, but it failed to consistency 
>>>>>> issue, then
>>>>>> reverted to sync version.
>>>>>
>>>>> Queue-wide suspension is not inherently required. Commit 
>>>>> 4eb0aace85f5 ("virtio-gpu: Support mapping hostmem blobs with 
>>>>> map_fixed") added a path that avoids per-blob MemoryRegion teardown 
>>>>> when virgl_renderer_resource_map_fixed() succeeds. The remaining 
>>>>> path is also being improved with:
>>>>>
>>>>> https://lore.kernel.org/qemu-devel/20260424-force_rcu-v4-0- 
>>>>> feccfaca0568@rsg.ci.i.u-tokyo.ac.jp/
>>>>> ("[PATCH v4 0/6] virtio-gpu: Force RCU when unmapping blob")
>>>>
>>>> Thanks. force_rcu is a clean fix for the RCU-reclamation part, but 
>>>> it still keeps the unmap synchronous and serial.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> c) QEMU dispatches the control queue and calls into virglrenderer 
>>>>>>> from
>>>>>>>     its main-loop thread along with display work and many other 
>>>>>>> things.
>>>>>>>     Venus's render server can offload renderer work, but control- 
>>>>>>> queue
>>>>>>>     dispatch remains in QEMU's main loop.
>>>>>>
>>>>>> Yes, we did some async optimization in ROCm context, but its 
>>>>>> effectiveness is limited, see bellow.
>>>>>>
>>>>>>>
>>>>>>> In any case, I think you need to do some experiments to track 
>>>>>>> down the real cause. a) is easy to check: just comment out all 
>>>>>>> qemu_console_hw_gl_block() calls; it may corrupt display but 
>>>>>>> removes the blocking. b) can also be tested by leaking the 
>>>>>>> mappings instead of blocking the whole queue. Using a different 
>>>>>>> display device like qxl tells whether c) is causing contention.
>>>>>>
>>>>>> Yes, totally agreed. following is my findings. In short words:
>>>>>>
>>>>>> Optimization can reduce queue pressure, but it can't withstand 
>>>>>> absolute overload because each command has some overhead. Making 
>>>>>> all commands asynchronous would lead to a debugging hell about 
>>>>>> asynchronous issues.
>>>>>> And we have high load applications rocmprofiler  that continuously 
>>>>>> catch information need virtio queue to handle. But create a new 
>>>>>> backend can not solve it simply, we are trying to find a way. like 
>>>>>> shmem between guest and host, then use cpu polling, bypass the 
>>>>>> virtqueue.
>>>>>
>>>>> Most commands are fast on the CPU side, while heavy processing
>>>>> happens asynchronously on the GPU. Cases (a) and (b) are exceptions.
>>>>>
>>>>>>
>>>>>> The load is mostly memory management. Running an AI model 
>>>>>> allocates and frees a large number of blobs. We already did some 
>>>>>> optimization release them asynchronously, but the host processing 
>>>>>> is a single queue one
>>>>>> process_cmdq, this is where the main bottleneck in my debugging 
>>>>>> work / my understanding so far. I'm not certain it's the whole 
>>>>>> picture, so please correct if I am wrong.
>>>>>>
>>>>>> A model load or unload frees a large batch of BOs and allocates 
>>>>>> another. Some of those commands are async in the virtio-gpu guest 
>>>>>> driver, but QEMU still has to work through them on the one queue, 
>>>>>> which takes time; so even though any single command is quick, 
>>>>>> there are simply too many of them, the single queue backs up, and 
>>>>>> everything behind it, gets delayed.
>>>>>>
>>>>>> real work load (a few downstream customisations): loading one 16 
>>>>>> GB model (gemm4 e4b), drives ~1200 blob creates, a burst of
>>>>>> ~1400 resource frees at teardown, ~3700 submits and ~6000 
>>>>>> virtqueue notifies, caused a 22 s guest soft lockup. And the 
>>>>>> behavior of memory operations are controlled by upper layer like 
>>>>>> pytorch / HIP / runtime,
>>>>>> we can not control it.
>>>>>>
>>>>>> To be honest, a separate backend won't fix this. But the real 
>>>>>> solution maybe is compute specific. That logic is only useful to 
>>>>>> the compute path, and folding it into the shared display device / 
>>>>>> renderer would mean churning code that is mature and stable for 
>>>>>> graphics, with regression risk. Keeping compute on its own 
>>>>>> instance and backend lets us iterate on these compute only 
>>>>>> optimisations.
>>>>>
>>>>> A 22-second lockup is too long for those command counts.
>>>>>
>>>>> The most probable explanation I have is that the ROCm integration 
>>>>> blocks QEMU's main loop thread while synchronously waiting for GPU 
>>>>> execution. Creating separate devices won't resolve this because the 
>>>>> main loop thread is shared, and synchronously waiting on the GPU 
>>>>> should be avoided in the first place.
>>>>
>>>> No synchronously waiting in ROCm backend, we are using user queue, 
>>>> and event waiting, no sync operation in CMD wait. all the resource 
>>>> release in ROCm are all async now.
>>>> Only the sync thing is memory thing mapping/unmapping in qemu, as 
>>>> long as it remains synchronous, it will be overwhelmed by the 
>>>> massive number of requests.
>>>
>>> Mapping and unmapping should not block QEMU's main-loop thread for that
>>> long. The command counts you reported are relatively small. That is why
>>> I suspect something else went wrong, such as the main-loop thread being
>>> inadvertently blocked while waiting for the GPU.
>>
>> Will investigate it.
>>
>>>
>>>>
>>>>>
>>>>> In any case, profiling is necessary before touching the 
>>>>> implementation.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>    - Compute contexts need far more blob / shared memory than a 
>>>>>>>> display one.
>>>>>>>
>>>>>>> It is not a problem by itself. Frequent mapping and unmapping 
>>>>>>> might amplify the second issue above, but that needs to be measured.
>>>>>>
>>>>>> Yes, agreed. I can give more detailed information.
>>>>>>
>>>>>>>
>>>>>>>>    - Maybe needs a wider ROCm / compute stack, cause the render 
>>>>>>>> model fits poorly:
>>>>>>>>      rocprofiler (PC sampling, SQTT/SPM, counters, high 
>>>>>>>> bandwidth streams)
>>>>>>>>      and ROCgdb (wave control, address watch, async exceptions an
>>>>>>>>      out of band channel that must not block display).
>>>>>>>
>>>>>>> virglrenderer does not impose a particular render model. That's 
>>>>>>> why Vulkan Compute just works with Venus.
>>>>>>
>>>>>> Yes but vulkan is used for GFX initally. And can not support many 
>>>>>> AI application.>
>>>>>>>>    - Events, faults and GPU reset/SMI are async and don't map 
>>>>>>>> onto fences.>    - All of this is hard to extend cleanly inside 
>>>>>>>> a display capset.
>>>>>>> Capset is not about display but determines the protocol of the 
>>>>>>> VIRTIO_GPU_CMD_SUBMIT_3D command stream. You have described 
>>>>>>> events, faults and GPU reset/SMI are async don't map onto fences 
>>>>>>> that may be associated with VIRTIO_GPU_CMD_SUBMIT_3D which is 
>>>>>>> dictated by capset. An additional feature may be necessary, and 
>>>>>>> it may or may not be dictated by capset. The other things are 
>>>>>>> irrelevant with the protocol capset represents; they are either 
>>>>>>> behavioral or about different commands.
>>>>>>
>>>>>> A fence is the one shot, but event is stateful and repeatable.
>>>>>> That may or may not be tied to capset. Agreed.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> On the QEMU/host side, would something like this be OK? One 
>>>>>>>> step, two parts:
>>>>>>>>
>>>>>>>>    - a dedicated headless virtio gpu instance for compute.
>>>>>>>
>>>>>>> A second device would isolate its virtqueues and device-wide
>>>>>>> renderer_blocked state. That may be useful if measurements show that
>>>>>>> these are the bottlenecks, but it is not yet clear that they are 
>>>>>>> or that
>>>>>>> a second device is the appropriate solution.
>>>>>>>
>>>>>>>>    - that instance served by a separate ROCm backend library loaded
>>>>>>>>      in-process by QEMU.
>>>>>>>
>>>>>>> First, I think we need to establish why ROCm cannot or should not 
>>>>>>> remain
>>>>>>> in virglrenderer. The virglrenderer, Venus, and VCL maintainers are
>>>>>>> likely better placed to advise on that boundary. Once the protocol
>>>>>>> requirements and performance measurements are clear, we can 
>>>>>>> assess the
>>>>>>> appropriate QEMU integration.
>>>>>>
>>>>>> venus is borned for GFX.
>>>>>> virCL not merged.
>>>>>>
>>>>>> To be clear, I'm not saying virglrenderer can't host a ROCm native 
>>>>>> context it clearly can. My hesitation is more about fit and 
>>>>>> direction: virglrenderer has grown up around GL/graphics, and I 
>>>>>> haven't yet found compute oriented plumbing there to build on, 
>>>>>> while ROCm moves very fast and I need something I can keep current 
>>>>>> with low friction.
>>>>>
>>>>> Whether keeping ROCm in virglrenderer would create extra friction 
>>>>> is primarily a question for the virglrenderer maintainers. Its 
>>>>> graphics origins do not by themselves motivate adding a separate 
>>>>> backend interface to QEMU.
>>>>
>>>> Fair. The first draft version in virglrenderer was in May 2024, and 
>>>> ROCm has gone 5.7 → 7.14 in that window.
>>>
>>> One point to note is that virtio-gpu development in QEMU is somewhat
>>> less active. crosvm is the most active user of virglrenderer, and QEMU
>>> sometimes lags behind it. If you are considering moving the ROCm 
>>> integration from virglrenderer to QEMU solely because ROCm evolves 
>>> rapidly, I do not think that would be a good idea. A rapidly evolving 
>>> component is better kept in virglrenderer unless there is another 
>>> reason to place it in QEMU.
>>
>> Actually didn't see something new about compute merged in to 
>> virglrenderer this recently 2 years.
> 
> Neither QEMU nor virglrenderer has seen new compute-related additions in 
> the past two years.

Maybe that is the reason we need a compute specific path? But I think 
the VFIO or vDPA are all can be used for compute, they are really 
active. We only need a small file for compute, providing the basic 
mechanisms, this code will also benefit other computing devices, such as 
NPU, I believe there will be more and more computing devices in the future.


> 
> While you have regularly updated the merge request, initiating 
> discussions around it is necessary to move review forward. Open-source 
> projects like QEMU and virglrenderer need proactive driving to complete 
> reviews. Simply shifting the ROCm integration to QEMU will not resolve 
> this bottleneck.

Yes I have actively promoted it, but I haven't received substantial 
reviews regarding virtio gpu userptr and virglrenderer. Hard to make MR 
move forward without a substantial review. So I am finding a another way.

> 
> Besides, looking at the "Architecture Components" in the description, 
> most of them haven't been merged yet. The virglrenderer code cannot be 
> merged in its current state, so focusing on those dependencies first is 
> essential.

Yes, I must admit that most of them not merged.
But actually for para virtualization those components are need merged 
together because they are closely connected.

> 
> However, taking a naive approach can lead to a chicken-and-egg problem: 
> component maintainers want the virglrenderer side stabilized first, 
> while virglrenderer maintainers want the component side stabilized. To 
> break this deadlock, I suggest seeking consensus on the interfaces 
> before completing the implementation. Once an interface agreement is 
> reached, changes to each component can land independently:

I've seen amdgpu native context (for GFX) and msm native context merged 
quickly. And actually ROCm native context is using the same method. 
That's why I think this is a problem of direction.

> 
> - virtio interface: I raised a concern regarding the interface [1][2]
>    that needs to be addressed.

I'm open to any feedback from the virtio maintainer, but since it's 
really just you and me discussing this, I can immediately modify your 
proposal if the maintainer agrees.

> - amdkfd patches: There are interface-level concerns [3] that still need
>    resolution.

We have a another solution to solve it, it is already done in virglrender.

> - ROCm runtime: The description lists this as "90% complete," but the
>    linked pull requests were closed due to inactivity. They need to be
>    reopened and seek for a consensus on its interface.

It was completed using another PR, so it was closed.

> 
> Once these items are addressed, you can update the merge request and ask 
> for a fresh review.
> 
> In parallel, you can request review of self-contained parts of 
> components that do not depend on those decisions. Once the interfaces 
> are agreed, the implementations can be reviewed in parallel and merged 
> in dependency order.
> 
> These steps can proceed in parallel alongside investigating the 
> performance bottleneck.

Really thanks for the suggestion. I think the compute specific path 
still worth discussing.

Regards,
Honglei

> 
> Regards,
> Akihiko Odaki
> 
> [1] https://lore.kernel.org/lkml/ 
> b69439ec-0ebd-4527-873b-85b283e03888@rsg.ci.i.u-tokyo.ac.jp/
> [2] https://lore.kernel.org/qemu-devel/35a8add7-da49-4833-9e69- 
> d213f52c771a@amd.com/
> [3] https://lore.kernel.org/lkml/20260104072122.3045656-1- 
> honglei1.huang@amd.com/
> [4] https://www.spinics.net/lists/amd-gfx/msg137231.html

