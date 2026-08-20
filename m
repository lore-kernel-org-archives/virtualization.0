Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013038.outbound.protection.outlook.com [40.107.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2169841686C
	for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787222958; cv=fail; b=sjdGRCSYRsaGUMWTVpWcnTti68gWer1urTbCdbvMMN5ELrUmsoYT2NMpesqK9t5B3ncqZBvxjr/9T5tYw6RREtKHkz/VZYJsJEnPYNw4O5/sA84yQsdJlivs+ZY9diy3vko15FhkzjTrJCnPqPBmC/N9Fci+twZJjpgHJqmuqvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787222958; c=relaxed/simple;
	bh=ynEiuqNsbtfhkDn61WMoAW60K+7Q73RuAdFkKok8nwQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bWG37YLiHJ4+T6hQspOkmNv/WHCzQDnOqWYKRjJQueHOiB4ZOyrPq3MZkC+nU50zVjG9BnPZoNgnpAWNaTEVdLswc6vi3/xqOBftFwNVDMGogw49F+nq7qjoLaF1s0S2vZbeRL/3G4nlzSbTLlaHLIve/3QJ4FOe71KG3Xl5EUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n+BI2BFT; arc=fail smtp.client-ip=40.107.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n+BI2BFT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUCNqdsQhy7Z2PKK8yJ1OnqSaGwej+dUAMJIHIMJ0SnhM1ktia7OsNz4uVHtd1JIJKjC0ZlJN1QeyPq+Ck1J1gTSmvr355sWs5r+KYPU/b4jMOwdQ2tkyFsJl7/Iy7tizrPy0NhSgZzjogKX7tBEiisbjdeIUIy7fM8ATOMZtwx3u52vN1dZDmLcry4xR/PsWL/P3TY0z/aRqja7ZjA6a/6hxvswCoK84dl/0HmZWwGRqLHxKxq6tBrDBKVjCPEhoqnLGPqrgnoc0HykkLqY6+y1gHTO0zfNSpsh2/tNrXoyhCkSNnBIJ2wVXIS2liyPVwpkzws8dwhQ++D/b0WHCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3368QmVRlK2ZUKWLvuEX0TCxYtsMH1moSNfC/9hSnw=;
 b=PX27IV2f1TCElYJodOMJPQsvLUAOODRLfHzDV8mLp2VKsi3aNL35gDu6t/BOWgwiYLAVIc4KF8ndDzjNTtMvOlhz7GExqK01BuBXxzXH0kkV3eJEl6YyJ2tnSy8CqqAUbwkMz5atgt7ypwFNuEubUCX9/iyKkLp/7O2Wq2se90/XWiHV4v8LVU9n50wCUKMhBKL69sIRgEhV3XJiLfNIui7J8FAosJrYAaCKvw9W1D+uxRqy5EvywUukR4IQeWiGqCnJE3tRgz2du7rN78EBULwF3ICgEMDrb+INOeEq08HUBxyi0pDUm4S1l328+8V2ggoyfSKKAqjQh0LcstRLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3368QmVRlK2ZUKWLvuEX0TCxYtsMH1moSNfC/9hSnw=;
 b=n+BI2BFTtse58dxkYhcfo8p+0cXPYTknheRJPFHZfRqmTWy35jymR5JM9HvAtit4Rhl57SLnMrvOB1fuUl3W1pjg8QQ8HLtN0RWkjR6jgPunULovmaOxS/8r0PDyjl5NZjxTMr+5XEb6SLQE+n4/cO4oGOZ3YcITBuPGye329ms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by SN7PR12MB8603.namprd12.prod.outlook.com (2603:10b6:806:260::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 20 Aug
 2026 10:49:11 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 10:49:11 +0000
Message-ID: <9640c016-1a64-4ef9-91f1-7955c3fb63a3@amd.com>
Date: Thu, 20 Aug 2026 18:49:01 +0800
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
 <ef751787-8688-4e30-8bc4-f1740ef162fc@amd.com>
 <14c4d7ac-607f-4372-8d1f-ca836f36498b@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <14c4d7ac-607f-4372-8d1f-ca836f36498b@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::14) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|SN7PR12MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: 310a6321-2b5a-4675-5729-08defea8ab0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|56012099006|11063799006|6133799003|5023799004|10067099003|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Mte3iu+Wgm3Af+86e0i9WL28VGct+bDixc/CllnGIyO0kir0TmjKKYXAryl+JR4h41ZPQfOMRUZBAv4Nw/uArIWvxAVOH78eMWk+Oecq30EKR9uFgcqKqZgRKAbxYzKBsIiyUa/8530YEkC2vZDkHIxTA+WhXPvuQNNzATkAyoNYr+rVhb7TWmH1G3Jh8F3/NTOxqE/jJW7yvt+hQEW7VvtrcpoHBgnoWaHv4jiZVoigORwDPkKuFBOytEx+ibeRH5K6kEGFnpKOq17hSXcKWiKOnXQKj3AGxfTpqYa8mKabsLW0l+4WJy+m5tOfy+t1vV9b6+e8EZ1d1H2GzaycsVEpvxXec9LOBokD2VaAzVjmbYs8ULQWzuQpA59sEe5EXLKuntlmFDMDzvNNkztO1zlZm3TpZDsOibxh1yopebYuNiJt9Yub+w1x6SY0vZTaN0ndGTtwAa6ied79sNtIS7uZgfZkCAL9rl896N+03pYLUgtlxpuVQKQfokTH6JYOoPwrBanQci0wF0/9nHez4QCFTWiAtM00FYT/oFXpnSn3lZFk1d/ecvdlS9jvhvIHVYmFJmnNchjQ2T2aXr0Gvm0/EhNoLyQ//CmYnqiEWVRIBFoPTlP7dssFsVYCYsndsc0OlRLc+U6T3Sg1w7sSVZFkobY+Gou5SWK8h3UMlkA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(5023799004)(10067099003)(4143699003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUFUUVVoN2xEVFN4NUFlMWRBaU9zeVYwaTNmNmZMMUtid0cwbEpUcStKbGZI?=
 =?utf-8?B?VDBpVkdKdHpoUXBCNGJJMFZQbFhyWXozWU9pc3Y0Q05wd0QxM0w5dU9uNjJC?=
 =?utf-8?B?NlRidUZKTkRETDV5RGdDQUtnbXNqK3U1WHYzLzZjZm5yZUpBdlhwVHF0UjVX?=
 =?utf-8?B?bHpnUlBsdm9CdWl5WVBVZnd6VXNyTHJ1L1BuaWRHTFJEL2VKVVdkUGM2b0xl?=
 =?utf-8?B?QlVweHluZUVrczIzSTRyS2NBZGhNcWFGbU0xUVJIa212SlpZeEY4RDU3RVVH?=
 =?utf-8?B?UUNoVFpablVBN3ptTnBOTWVLWjJSSml2bUk3TGd5NDRZdWdGaVFIRk9zdXFy?=
 =?utf-8?B?Wm5WdnVTOGlvdEtYcVRMZUNhZlNFRWRPM2xxWXpNcStMV1FhZG54TUMweEZI?=
 =?utf-8?B?ay8ycHo3N2RyeEs5MitaT0ljcE1wUHB0bkV0aGJ4ZW9NSG9lR0gzTVEwZGc5?=
 =?utf-8?B?Rk0yUmRuNmoyNUl6dWcySlVnNHBrQ2FPWWFjc1prM0hGWi9QekQwYjZqRFhZ?=
 =?utf-8?B?Ri91UE5zOXV3RDBoS3I5Qmw2YUsxVkZSL3I3MmdUUzNCNGJFWDk4eVV2c3FI?=
 =?utf-8?B?ZFQrQXFJQTZLWnltSytOVnFsT0Z4eXhDVzJsTlB4UVR0bVFGaGVGbUVLYnk0?=
 =?utf-8?B?Z3dDTm5mZDBzTldoK0c2OFlOZ3VHbE9IRC9hcGVKelkvRGRheU9lb20xVDVM?=
 =?utf-8?B?blVNQnhkV2xZTWNvNVZEVXA4MGpBaXhFWGpWY0Q0SDR5RXBqMnc0YVlaakxr?=
 =?utf-8?B?TXh2d1FYcnU5THBwRk5GWE42aHAxNWVSUTZFckZTNGtoaDB4NE5kcnpxRmFI?=
 =?utf-8?B?WHp0dHFCNlFwL0o0bjlIb2ZGTnNkZFhjUXFCZjNIRURRS1gwT3krc0ZtZmt0?=
 =?utf-8?B?NnBhZWRvQVQxYlUwalFIT0RFQlNIRTd1UkRPZTJzeTc2V2VpTHY1MkdtUjBy?=
 =?utf-8?B?cnlpNTF5SG9naUx1ZmczUFVlQ2hraTQxbVV4OFkxK0U5TXFFbktDU3F0dFcv?=
 =?utf-8?B?bkNkbjJUa3hWMkFkTEdYL3FoYVp3SG45RWptRnhmckdjMkxqKzBrelhUNmI4?=
 =?utf-8?B?b3FtaFRvb1pNeEZaUmVBQlpSWVRmaTdqSFJpUEkvMTBnLzRtaFdRY1AwaDgx?=
 =?utf-8?B?S1oxK2Y0N2xlMTNBdDllZks2eElYNm9rUklnUWZyVUExZW5PSHd1dS94SjA5?=
 =?utf-8?B?eUE3dlBFV1hUcXI4UmRueEFUWlAvcndSTm4vRnRrRXRSc2UzNnhZRnUxaGRK?=
 =?utf-8?B?Rm82RFNGa0lZUEpGcHJXaXl1N0NNQWY5R042QlFOakFkcnQzekVUdWkzbWRR?=
 =?utf-8?B?WnJNU2ViN2hGdEdEaGlZamVTdTVXc1I2VzQ5WFpLSk5USmRTbUxPQmZUa3NF?=
 =?utf-8?B?VUZhdW9JZ0JkV0pzVWVOYnpWSjBYWmJLSVBzQmlJTytSUFhzeEpDTzI4WGNT?=
 =?utf-8?B?VWRqUURWMnZSbTN4MUljaUdCeVNXZkR2eUVxTERFWlpJODVsSDdkT3IyeHVG?=
 =?utf-8?B?L0JFRGRvQ3k5alpVNTNJVUVGMVB3R25qNlRCa2l1a1M0Znd1Vml2TElydFNE?=
 =?utf-8?B?SkE2QmtMazByWDJPT3VzSnpRT0tvRVByOW5BL3hOQ1lWNFNuY1duZTBhZzJD?=
 =?utf-8?B?NloybXhhUWg3cXRpd1lNSEI0VjRvSTh4b3BvMmJuZFk4eWZ5YTFhdHdaNDB4?=
 =?utf-8?B?ZEFqRko0NjdaOUZ2eVgzZGhCMUtqSG9sSlFXNUQ4RmpaNjhuTFljTkswNzhE?=
 =?utf-8?B?WERVNjA3WENUTDNwRkFsWFpoK1FmQVJMVG9nZnYwcDBTMGRXVGxucWsra050?=
 =?utf-8?B?UCtWcmRHWWNSUGl6bWx4aW9pMy83WUNQeVpSdEpOYWxJZHUxam5HbHltNzZp?=
 =?utf-8?B?Z0puemtIa2pZdE5ScWc4UDRLK1hySHZYLy9Fcm1HR0JQZXZpQTFtQjlDUlV3?=
 =?utf-8?B?NitZK2NDSjhaVnY3N2NiODZIb05QVFRGWlN2OGIwVjN1cnJEZlIvTk9xK1lH?=
 =?utf-8?B?dUR5ekVHUGZpUmR6WldhTWpzZFkvSUgvOUU0MmxzWjgxNFBwaHRUb1FQYjBE?=
 =?utf-8?B?b05WTlpjMDE3Y0JTMXJDNnlCUGVpWEVjMW9uL3RJbEtVR1ZiUzY0NW1QYURJ?=
 =?utf-8?B?UU94N21zTGtRd3NzZDNZTjZsM3I1cjUxdTNxS2NRSXJmYk5oeVdXYytheE5M?=
 =?utf-8?B?amVrYkhHQStMR29UeUhORTZscDRoQXNrREk0bk5UMnNtRzFvaGt3UmVxVDJv?=
 =?utf-8?B?RUozN2c2emdKdjFzQTY4Y2dBUVVFWkpqTi90RU9KcWNab3E2dzZiNFBzNzM5?=
 =?utf-8?Q?clAHU6pPwW6nu67F/R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310a6321-2b5a-4675-5729-08defea8ab0a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 10:49:11.3045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sN5y6yIym/Sx8tSaYt4MdmqTjc8x0J3r5AYdVi7wjvAhFnW5AZbj26JKzCLmO96/rS2CpgeZDUmxheZZAOWvsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8603



On 8/18/2026 7:27 PM, Akihiko Odaki wrote:
> On 2026/08/18 17:53, Huang, Honglei wrote:
>>
>>
>> On 8/18/2026 3:50 PM, Akihiko Odaki wrote:
>>> On 2026/08/18 13:26, Huang, Honglei wrote:
>>>>
>>>>
>>>> On 8/18/2026 12:05 PM, Akihiko Odaki wrote:
>>>>> On 2026/08/18 11:50, Huang, Honglei wrote:
>>>>>>
>>>>>>
>>>>>> On 8/18/2026 12:29 AM, Akihiko Odaki wrote:
>>>>>>> On 2026/08/17 22:44, Huang, Honglei wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 8/17/2026 7:44 PM, Akihiko Odaki wrote:
>>>>>>>>> On 2026/08/17 12:19, Huang, Honglei wrote:
>>>>>>>>>>
>>>>>>>>>> Hi Michael, Alex, Dmitry, Akihiko,
>>>>>>>>>
>>>>>>>>> Hi Honglei,
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I'm bringing AMD GPU compute ROCm based on virtio. I posted a 
>>>>>>>>>> ROCm over virtio
>>>>>>>>>> implementation to virglrenderer nine months ago (MR !1568 
>>>>>>>>>> [1]). The ROCm side has
>>>>>>>>>> been supportted by ROCm offical.
>>>>>>>>>>
>>>>>>>>>> Current implementation is a virtio gpu context type capset 
>>>>>>>>>> handled inside
>>>>>>>>>> virglrenderer, sharing the display path. That's an awkward 
>>>>>>>>>> fit, many
>>>>>>>>>> compute GPUs have no display engine at all.
>>>>>>>>>
>>>>>>>>> I think "sharing the display path" conflates several layers and 
>>>>>>>>> makes the problem difficult to assess. It would help to 
>>>>>>>>> identify the concrete constraint behind "awkward fit."
>>>>>>>>>
>>>>>>>>> End-to-end, there are four relevant layers:
>>>>>>>>>
>>>>>>>>> 1. Host GPU stack: hardware, host kernel, and host userspace
>>>>>>>>> 2. Paravirtualization stack: virglrenderer and QEMU
>>>>>>>>
>>>>>>>> Yes we are asking can we add a new file like virtio-gpu specific 
>>>>>>>> for compute, but maybe we can only add a new backend like 
>>>>>>>> virglrenderer specific for compute.
>>>>>>>>
>>>>>>>>> 3. Host/guest interface: virtio and the capset-specific command 
>>>>>>>>> stream
>>>>>>>>
>>>>>>>> In this plan we may need just add a capset id.
>>>>>>>>
>>>>>>>>> 4. Guest GPU stack: guest kernel and guest userspace
>>>>>>>>
>>>>>>>> Won't modify the guest kernel in this plan, this email list.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Orthogonally, acceleration is separate from display and scanout. A
>>>>>>>>> physical device may provide both, but acceleration does not 
>>>>>>>>> require a
>>>>>>>>> display engine. Linux likewise exposes render and compute 
>>>>>>>>> interfaces
>>>>>>>>> separately from modesetting. The userspace interface 
>>>>>>>>> virglrenderer uses is messy; there is Vulkan, EGL, OpenGL, and 
>>>>>>>>> now you are adding ROCm. But there is one thing I must note is 
>>>>>>>>> that acceleration and display is decoupled, and acceleration 
>>>>>>>>> does not require display.
>>>>>>>>
>>>>>>>> Yes totally agreed.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> At the protocol layer, context command buffers are carried by 
>>>>>>>>> VIRTIO_GPU_CMD_SUBMIT_3D. Scanout uses separate core virtio-gpu 
>>>>>>>>> commands, and VIRTIO_GPU_CMD_GET_DISPLAY_INFO may report no 
>>>>>>>>> enabled displays. At the implementation layer, QEMU handles 
>>>>>>>>> scanout presentation. virgl_cmd_set_scanout() obtains resource 
>>>>>>>>> information through virgl_renderer_resource_get_info() or 
>>>>>>>>> virgl_renderer_resource_get_info_ext(). That does not make 
>>>>>>>>> scanout a virglrenderer-owned display path.
>>>>>>>>
>>>>>>>> Yes, agreed.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Therefore, if "sharing the display path" means sharing the same 
>>>>>>>>> device, control queue, and QEMU execution context, that 
>>>>>>>>> identifies a possible source of contention. If it means that 
>>>>>>>>> capsets or virglrenderer are inherently tied to display, I do 
>>>>>>>>> not think that is accurate. Vulkan compute is already used 
>>>>>>>>> through Venus with libkrun [2], and VCL proposes OpenCL support 
>>>>>>>>> through virglrenderer [3].
>>>>>>>>
>>>>>>>> Yes，but the vulkan is for GFX originally, and for some formal 
>>>>>>>> AI frame work like pytorch, it's support is limited, and it 
>>>>>>>> performance is lower than ROCm, and vulkan also lacks many AI 
>>>>>>>> infrastructure, like composable kernel.
>>>>>>>> And for virCL, actually it is came from same project with ROCm 
>>>>>>>> native context, but the original author didn't continue to 
>>>>>>>> support it, they handed it over to someone else to take over. 
>>>>>>>> And in the first version of
>>>>>>>> virCL, it didn't pass the test of actual projects.
>>>>>>>>
>>>>>>>> And it seems like virCL didn't upstream into virglrenderer also, 
>>>>>>>> correct me if I am wrong.
>>>>>>>
>>>>>>> I cited Venus and VCL only as examples showing that virtio-gpu and
>>>>>>> virglrenderer are not intrinsically tied to display. I did not 
>>>>>>> suggest
>>>>>>> either as a substitute for ROCm.
>>>>>>>
>>>>>>>>
>>>>>>>>>> Beyond that, sharing the display path is increasingly painful:
>>>>>>>>>>
>>>>>>>>>>    - Compute hammers the queues more than graphics, so sharing
>>>>>>>>>>      virtio gpu's single control queue with display/virgl 
>>>>>>>>>> causes contention
>>>>>>>>>>      and display stutter.
>>>>>>>>>
>>>>>>>>> All non-cursor commands do share one control queue, but a fence 
>>>>>>>>> avoids serialization.
>>>>>>>>
>>>>>>>> yes, agreed.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> There may still be implementation-level contention, and it is not
>>>>>>>>> necessarily specific to compute. A sufficiently busy graphics 
>>>>>>>>> workload
>>>>>>>>> could expose the same bottlenecks. Possible contributors in 
>>>>>>>>> current QEMU
>>>>>>>>> include:
>>>>>>>>>
>>>>>>>>> a) qemu_console_hw_gl_block() blocks the entire queue when QEMU 
>>>>>>>>> only
>>>>>>>>>     needs to fence scanout commands.
>>>>>>>>
>>>>>>>> Yes, agreed.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> b) virtio_gpu_virgl_unmap_resource_blob() may also block the 
>>>>>>>>> entire
>>>>>>>>>     queue just to delay one command.
>>>>>>>>
>>>>>>>> Yes, but it is seems like it is must, someone else in AMD tried 
>>>>>>>> to use async method to relase blob, but it failed to consistency 
>>>>>>>> issue, then
>>>>>>>> reverted to sync version.
>>>>>>>
>>>>>>> Queue-wide suspension is not inherently required. Commit 
>>>>>>> 4eb0aace85f5 ("virtio-gpu: Support mapping hostmem blobs with 
>>>>>>> map_fixed") added a path that avoids per-blob MemoryRegion 
>>>>>>> teardown when virgl_renderer_resource_map_fixed() succeeds. The 
>>>>>>> remaining path is also being improved with:
>>>>>>>
>>>>>>> https://lore.kernel.org/qemu-devel/20260424-force_rcu-v4-0- 
>>>>>>> feccfaca0568@rsg.ci.i.u-tokyo.ac.jp/
>>>>>>> ("[PATCH v4 0/6] virtio-gpu: Force RCU when unmapping blob")
>>>>>>
>>>>>> Thanks. force_rcu is a clean fix for the RCU-reclamation part, but 
>>>>>> it still keeps the unmap synchronous and serial.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> c) QEMU dispatches the control queue and calls into 
>>>>>>>>> virglrenderer from
>>>>>>>>>     its main-loop thread along with display work and many other 
>>>>>>>>> things.
>>>>>>>>>     Venus's render server can offload renderer work, but 
>>>>>>>>> control- queue
>>>>>>>>>     dispatch remains in QEMU's main loop.
>>>>>>>>
>>>>>>>> Yes, we did some async optimization in ROCm context, but its 
>>>>>>>> effectiveness is limited, see bellow.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> In any case, I think you need to do some experiments to track 
>>>>>>>>> down the real cause. a) is easy to check: just comment out all 
>>>>>>>>> qemu_console_hw_gl_block() calls; it may corrupt display but 
>>>>>>>>> removes the blocking. b) can also be tested by leaking the 
>>>>>>>>> mappings instead of blocking the whole queue. Using a different 
>>>>>>>>> display device like qxl tells whether c) is causing contention.
>>>>>>>>
>>>>>>>> Yes, totally agreed. following is my findings. In short words:
>>>>>>>>
>>>>>>>> Optimization can reduce queue pressure, but it can't withstand 
>>>>>>>> absolute overload because each command has some overhead. Making 
>>>>>>>> all commands asynchronous would lead to a debugging hell about 
>>>>>>>> asynchronous issues.
>>>>>>>> And we have high load applications rocmprofiler  that 
>>>>>>>> continuously catch information need virtio queue to handle. But 
>>>>>>>> create a new backend can not solve it simply, we are trying to 
>>>>>>>> find a way. like shmem between guest and host, then use cpu 
>>>>>>>> polling, bypass the virtqueue.
>>>>>>>
>>>>>>> Most commands are fast on the CPU side, while heavy processing
>>>>>>> happens asynchronously on the GPU. Cases (a) and (b) are exceptions.
>>>>>>>
>>>>>>>>
>>>>>>>> The load is mostly memory management. Running an AI model 
>>>>>>>> allocates and frees a large number of blobs. We already did some 
>>>>>>>> optimization release them asynchronously, but the host 
>>>>>>>> processing is a single queue one
>>>>>>>> process_cmdq, this is where the main bottleneck in my debugging 
>>>>>>>> work / my understanding so far. I'm not certain it's the whole 
>>>>>>>> picture, so please correct if I am wrong.
>>>>>>>>
>>>>>>>> A model load or unload frees a large batch of BOs and allocates 
>>>>>>>> another. Some of those commands are async in the virtio-gpu 
>>>>>>>> guest driver, but QEMU still has to work through them on the one 
>>>>>>>> queue, which takes time; so even though any single command is 
>>>>>>>> quick, there are simply too many of them, the single queue backs 
>>>>>>>> up, and everything behind it, gets delayed.
>>>>>>>>
>>>>>>>> real work load (a few downstream customisations): loading one 16 
>>>>>>>> GB model (gemm4 e4b), drives ~1200 blob creates, a burst of
>>>>>>>> ~1400 resource frees at teardown, ~3700 submits and ~6000 
>>>>>>>> virtqueue notifies, caused a 22 s guest soft lockup. And the 
>>>>>>>> behavior of memory operations are controlled by upper layer like 
>>>>>>>> pytorch / HIP / runtime,
>>>>>>>> we can not control it.
>>>>>>>>
>>>>>>>> To be honest, a separate backend won't fix this. But the real 
>>>>>>>> solution maybe is compute specific. That logic is only useful to 
>>>>>>>> the compute path, and folding it into the shared display 
>>>>>>>> device / renderer would mean churning code that is mature and 
>>>>>>>> stable for graphics, with regression risk. Keeping compute on 
>>>>>>>> its own instance and backend lets us iterate on these compute 
>>>>>>>> only optimisations.
>>>>>>>
>>>>>>> A 22-second lockup is too long for those command counts.
>>>>>>>
>>>>>>> The most probable explanation I have is that the ROCm integration 
>>>>>>> blocks QEMU's main loop thread while synchronously waiting for 
>>>>>>> GPU execution. Creating separate devices won't resolve this 
>>>>>>> because the main loop thread is shared, and synchronously waiting 
>>>>>>> on the GPU should be avoided in the first place.
>>>>>>
>>>>>> No synchronously waiting in ROCm backend, we are using user queue, 
>>>>>> and event waiting, no sync operation in CMD wait. all the resource 
>>>>>> release in ROCm are all async now.
>>>>>> Only the sync thing is memory thing mapping/unmapping in qemu, as 
>>>>>> long as it remains synchronous, it will be overwhelmed by the 
>>>>>> massive number of requests.
>>>>>
>>>>> Mapping and unmapping should not block QEMU's main-loop thread for 
>>>>> that
>>>>> long. The command counts you reported are relatively small. That is 
>>>>> why
>>>>> I suspect something else went wrong, such as the main-loop thread 
>>>>> being
>>>>> inadvertently blocked while waiting for the GPU.
>>>>
>>>> Will investigate it.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> In any case, profiling is necessary before touching the 
>>>>>>> implementation.
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>    - Compute contexts need far more blob / shared memory than 
>>>>>>>>>> a display one.
>>>>>>>>>
>>>>>>>>> It is not a problem by itself. Frequent mapping and unmapping 
>>>>>>>>> might amplify the second issue above, but that needs to be 
>>>>>>>>> measured.
>>>>>>>>
>>>>>>>> Yes, agreed. I can give more detailed information.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>    - Maybe needs a wider ROCm / compute stack, cause the 
>>>>>>>>>> render model fits poorly:
>>>>>>>>>>      rocprofiler (PC sampling, SQTT/SPM, counters, high 
>>>>>>>>>> bandwidth streams)
>>>>>>>>>>      and ROCgdb (wave control, address watch, async exceptions an
>>>>>>>>>>      out of band channel that must not block display).
>>>>>>>>>
>>>>>>>>> virglrenderer does not impose a particular render model. That's 
>>>>>>>>> why Vulkan Compute just works with Venus.
>>>>>>>>
>>>>>>>> Yes but vulkan is used for GFX initally. And can not support 
>>>>>>>> many AI application.>
>>>>>>>>>>    - Events, faults and GPU reset/SMI are async and don't map 
>>>>>>>>>> onto fences.>    - All of this is hard to extend cleanly 
>>>>>>>>>> inside a display capset.
>>>>>>>>> Capset is not about display but determines the protocol of the 
>>>>>>>>> VIRTIO_GPU_CMD_SUBMIT_3D command stream. You have described 
>>>>>>>>> events, faults and GPU reset/SMI are async don't map onto 
>>>>>>>>> fences that may be associated with VIRTIO_GPU_CMD_SUBMIT_3D 
>>>>>>>>> which is dictated by capset. An additional feature may be 
>>>>>>>>> necessary, and it may or may not be dictated by capset. The 
>>>>>>>>> other things are irrelevant with the protocol capset 
>>>>>>>>> represents; they are either behavioral or about different 
>>>>>>>>> commands.
>>>>>>>>
>>>>>>>> A fence is the one shot, but event is stateful and repeatable.
>>>>>>>> That may or may not be tied to capset. Agreed.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On the QEMU/host side, would something like this be OK? One 
>>>>>>>>>> step, two parts:
>>>>>>>>>>
>>>>>>>>>>    - a dedicated headless virtio gpu instance for compute.
>>>>>>>>>
>>>>>>>>> A second device would isolate its virtqueues and device-wide
>>>>>>>>> renderer_blocked state. That may be useful if measurements show 
>>>>>>>>> that
>>>>>>>>> these are the bottlenecks, but it is not yet clear that they 
>>>>>>>>> are or that
>>>>>>>>> a second device is the appropriate solution.
>>>>>>>>>
>>>>>>>>>>    - that instance served by a separate ROCm backend library 
>>>>>>>>>> loaded
>>>>>>>>>>      in-process by QEMU.
>>>>>>>>>
>>>>>>>>> First, I think we need to establish why ROCm cannot or should 
>>>>>>>>> not remain
>>>>>>>>> in virglrenderer. The virglrenderer, Venus, and VCL maintainers 
>>>>>>>>> are
>>>>>>>>> likely better placed to advise on that boundary. Once the protocol
>>>>>>>>> requirements and performance measurements are clear, we can 
>>>>>>>>> assess the
>>>>>>>>> appropriate QEMU integration.
>>>>>>>>
>>>>>>>> venus is borned for GFX.
>>>>>>>> virCL not merged.
>>>>>>>>
>>>>>>>> To be clear, I'm not saying virglrenderer can't host a ROCm 
>>>>>>>> native context it clearly can. My hesitation is more about fit 
>>>>>>>> and direction: virglrenderer has grown up around GL/graphics, 
>>>>>>>> and I haven't yet found compute oriented plumbing there to build 
>>>>>>>> on, while ROCm moves very fast and I need something I can keep 
>>>>>>>> current with low friction.
>>>>>>>
>>>>>>> Whether keeping ROCm in virglrenderer would create extra friction 
>>>>>>> is primarily a question for the virglrenderer maintainers. Its 
>>>>>>> graphics origins do not by themselves motivate adding a separate 
>>>>>>> backend interface to QEMU.
>>>>>>
>>>>>> Fair. The first draft version in virglrenderer was in May 2024, 
>>>>>> and ROCm has gone 5.7 → 7.14 in that window.
>>>>>
>>>>> One point to note is that virtio-gpu development in QEMU is somewhat
>>>>> less active. crosvm is the most active user of virglrenderer, and QEMU
>>>>> sometimes lags behind it. If you are considering moving the ROCm 
>>>>> integration from virglrenderer to QEMU solely because ROCm evolves 
>>>>> rapidly, I do not think that would be a good idea. A rapidly 
>>>>> evolving component is better kept in virglrenderer unless there is 
>>>>> another reason to place it in QEMU.
>>>>
>>>> Actually didn't see something new about compute merged in to 
>>>> virglrenderer this recently 2 years.
>>>
>>> Neither QEMU nor virglrenderer has seen new compute-related additions 
>>> in the past two years.
>>
>> Maybe that is the reason we need a compute specific path? But I think 
>> the VFIO or vDPA are all can be used for compute, they are really 
>> active. We only need a small file for compute, providing the basic 
>> mechanisms, this code will also benefit other computing devices, such 
>> as NPU, I believe there will be more and more computing devices in the 
>> future.
> 
> I think this highlights that you are pioneering device-specific 
> paravirtualization here. Venus demonstrates a vendor-neutral approach, 
> but it didn't get compute-specific plumbing simply because Venus didn't 
> need one. Pushing improvements through virglrenderer will help both 
> graphics and compute accelerators.
> 
>>
>>
>>>
>>> While you have regularly updated the merge request, initiating 
>>> discussions around it is necessary to move review forward. Open- 
>>> source projects like QEMU and virglrenderer need proactive driving to 
>>> complete reviews. Simply shifting the ROCm integration to QEMU will 
>>> not resolve this bottleneck.
>>
>> Yes I have actively promoted it, but I haven't received substantial 
>> reviews regarding virtio gpu userptr and virglrenderer. Hard to make 
>> MR move forward without a substantial review. So I am finding a 
>> another way.
> 
> I don't see recent engagement on the MR. Reaching out publicly on the MR 
> would be a good way to show that you are actively driving it forward.
> 
>>
>>>
>>> Besides, looking at the "Architecture Components" in the description, 
>>> most of them haven't been merged yet. The virglrenderer code cannot 
>>> be merged in its current state, so focusing on those dependencies 
>>> first is essential.
>>
>> Yes, I must admit that most of them not merged.
>> But actually for para virtualization those components are need merged 
>> together because they are closely connected.
>>
>>>
>>> However, taking a naive approach can lead to a chicken-and-egg 
>>> problem: component maintainers want the virglrenderer side stabilized 
>>> first, while virglrenderer maintainers want the component side 
>>> stabilized. To break this deadlock, I suggest seeking consensus on 
>>> the interfaces before completing the implementation. Once an 
>>> interface agreement is reached, changes to each component can land 
>>> independently:
>>
>> I've seen amdgpu native context (for GFX) and msm native context 
>> merged quickly. And actually ROCm native context is using the same 
>> method. That's why I think this is a problem of direction.
> 
> It is understandable that those merged more quickly given the state of 
> the "Architecture Components" mentioned earlier. For both the amdgpu and 
> msm native contexts, the UAPI was already in place, allowing those 
> changes to be reviewed and merged in isolation.
> 
>>
>>>
>>> - virtio interface: I raised a concern regarding the interface [1][2]
>>>    that needs to be addressed.
>>
>> I'm open to any feedback from the virtio maintainer, but since it's 
>> really just you and me discussing this, I can immediately modify your 
>> proposal if the maintainer agrees.
> 
> A pattern sometimes I observe is that maintainers often skip patches 
> with unaddressed discussion items. Updating the code to resolve known 
> feedback often serves as a good trigger to draw in new reviewers.
> 
>>
>>> - amdkfd patches: There are interface-level concerns [3] that still need
>>>    resolution.
>>
>> We have a another solution to solve it, it is already done in 
>> virglrender.
>>
>>> - ROCm runtime: The description lists this as "90% complete," but the
>>>    linked pull requests were closed due to inactivity. They need to be
>>>    reopened and seek for a consensus on its interface.
>>
>> It was completed using another PR, so it was closed.
> 
> These are great news. I suggest updating the MR description then so that 
> potential reviewers can see the progress.

Will update the virtio userptr and virglrenderer PR in future. But 
unclear how compute will eventually evolve on virtio. The virgl version 
may only support old ROCm version.

And a single control queue is the design of the virtio GPU, and it is 
indeed a bottleneck, modifying it is difficult. However, some other 
virtio devices have multi queues for different usages.

And actually such as NPUs, TPUs, or custom ASICs, no display compute 
card all go to the virglrenderer seem like not a natural long term 
abstraction.

Regards,
Honglei

> 
> Regards,
> Akihiko Odaki

