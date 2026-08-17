Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012006.outbound.protection.outlook.com [52.101.53.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A372836A6
	for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970829; cv=fail; b=u/xeROhrCAoc++1CsQ0eGhaHBnSLQ54OBVwQoYLUyXdHZaHeJ7BHnk8rNNbl1M6nlSLMPWPtox5LPVOTbWkieYztxVzep5QnMWpEDTxekxAqdA+uKcwNLb5pnY8H3CoGrQIJfHYCUHto7CK02har9ox3Yn7SjBvjG0cwB0niC/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970829; c=relaxed/simple;
	bh=bA5+uMG5rAqY7IBpu7o/tdUuxTLnpyEjLmeYC6nnsOU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ia8x4MVdTzPTcspVU17XmV2EwsPR3IZLzHstpsOyoDV4LANARJF081gLjW0TCYolW317QcYeCNae4um5fh7lgIwfQBHXZCCTkd9mZskMo7vnSRPFGlSdod+kGWhFxL+UnmeeBOB5vAMIZiiQW34ygWgM1WTsuN5s8EyL0zkzhzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YxzNcjCl; arc=fail smtp.client-ip=52.101.53.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YxzNcjCl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkdCUqi2c3riUf96KSKo2fcWjNjUHnXKHMZT49t6gfpD4m6dn6egZeElIzP6VJoV2OxTMZB2TjT6db8dMmm5SdMBUJ2F2l02g88y6vtV333+JQ3V5dEqJwxBrbr79cY+S+Fp0m2lrd/iDiR3HKWiYxuhAeJcpMsuIwk5W/fMoUU8g/x9NAREEoLvOlS6lasUxcvzibALffxZ9em5bosXkiFDkbWfPLNUwgJF8/wbb0I0FDscSsufTUmLB0T/+S7vfCgtcucQyP5v+15sxsifFndDD+TjrqLMTcdZQ3lyZtwA/lFYgkEYTbFTMHMC2LRhFXK5ovHCGjyVyU+10XfuJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZ/LqbYnInl2xnTvevUiedD/vAhonPCyGPUBy7NIjt0=;
 b=xbf2LLK/hAquVNRRtXUB0BbomNGwsDcgso2lPX47ltNbpCCNlRXmXv6n3tS8LE4LyFKVoTp5ibrzzOBfOQnGvF18TqkjDCzZcNa8cak4QhMntXXj1YPr9ivs2nrN90ppuLGir3HVNe2Ud49XNm9gA3v09h9IlN9ZlSqnVeDbiLvMMLIIEfbpQmicpW7GSnJq2Nwoxh2+kkRniQ7fKP0g/HPXytmf/gDqwcCetCky8Qvibwom7q1gWeysm8Fdvu0bn93AuvcTry2FGvGmRO1Im1fT65istKErNs1aZ3MFllFnloLe/GYUR3Ojgs/2eayJoWEVdtMrkHpRZYNzrTQPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZ/LqbYnInl2xnTvevUiedD/vAhonPCyGPUBy7NIjt0=;
 b=YxzNcjClkKsZA0pzz2gInQd3IuLmCtejTS+Zo9gRNyVrS416V8pC1dpvY782VTQAQsq0MAfLujIWr+Dy0NFMs/H8EjSdRBmo9P+8bOqywQW/tWEi+EsB3PVoqTpipKPF0ZQvA5HIhK9K5qaCFLG5FWtXPVHGjRfirfw2jEP/QP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 12:47:02 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0315.014; Mon, 17 Aug 2026
 12:47:02 +0000
Message-ID: <4673d669-b350-4723-b74e-6e1ea5f09c22@amd.com>
Date: Mon, 17 Aug 2026 20:46:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: About new backend for GPU compute ROCm in qemu
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 David Airlie <airlied@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, virtio-comment@lists.oasis-open.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 Honglei Huang <honglei1.huang@amd.com>, Huang Rui <Ray.Huang@amd.com>
References: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
 <87v799ru8w.fsf@draig.linaro.org>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <87v799ru8w.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0006.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::6)
 To CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: a070d88a-d929-4111-7636-08defc5da27b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|22082099003|18002099003|56012099006|3023799007|5023799004|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	gOnmMOpN/PZlFTDyvRi4OHs9f54oovh3Q6/BHjYPTac6P07zwxXOlZ15qBFagjghqwIcWNafr8aYQhYiksdB7SHovUzSV4cuJ/dDt6eXuflTIL8/jLCfcqDg/9qLNibU6ltDzK/Ku9q+1Ox4DTwsxF5Fqiw0eiptsCxUVDtjqaSK+4Ks/PtXAm0LrdFSGm04jv3Lx6O+cdhDIugquck3Vc7QrO+RxHp3ZqCME0DG8rGXJn2uZnzNWwhZbQ52VnK6Xk1Y5cuoVo6o2VeAoEXfTRsCSxkqRLzLMK2H8m0qV3NmIOv7yp33ZPzOEiII7WhXIxMkqj6yQSostyS9Z0ySYqEEzukbao7wTq/oVcm/YgwNPNNERC1PBwknzd+zmu45Y/oPw2NryB1AQpAH+yofSn+LiVh92akdzghJti3NeKvpCvZw5GCJjJlgEHnQToEcAUFccpzntRj16Wk2QunQQble43Ar4KuA8LZR8qfWc/z6qGekfLZuOjd86U6dAw2YYXzZ9UskTrR4sPUG2DBd9zlDCLQ8kRJ9M3Np6ITaRCg4TS+OAJn7j0xVvTi+q5g9ZfLxYO52kbYtOOCKgAioDbXEMYBdA4Uutwe6EcYEX3Oipof1C/UyrmUDpoC8gQQP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(5023799004)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWZNdDdQNHNwSzduWXhVaFBza2x6UGIxZkZTUkhBQXhsWkFaWjJDbVduVmF0?=
 =?utf-8?B?dUgwRUJjVU1FTzNpdHAyUzh0My82STJ4VDIwY1lQSTFRZi80a3BqdjRURHdh?=
 =?utf-8?B?dGlkem5mZGFSbkFkWW81czE1MmJGSlEwU2RUdjBDRzFjU29wcHBZeDUrOHZI?=
 =?utf-8?B?dFh5T3QvVHdrb3l2SGoxQzJmOFZrWEdWc09oR1JsU2N0dGh6MXdrenU2TEtT?=
 =?utf-8?B?ckRyS2dGVVFDS3BkaTh1ZG1ySmpEZCtFN0VQdGNmNkdHV2xyekViZWRpaDZL?=
 =?utf-8?B?ckJjZFgzZEhmT21xUUcvOTBLZEMrUWNCam1CZVVlZnNtZVRGOVlGbjNXU3J6?=
 =?utf-8?B?bjRRZkVjT3pRazBMYnY2RlEvdnk3M1B4Z2xrcWhFdkpIQTl6NlZuVm9VYlpI?=
 =?utf-8?B?eTEzcHhhcklZYUcrcUkzNkhwU2JmQ1BCQkpsNEkwdlk4aUJHbDV3UU8ySzRN?=
 =?utf-8?B?R05CTm01NnVYR2FLOHZIcUxLL0t3WUlLL0tLaCtpYzV0NWozaUlST29KbWtU?=
 =?utf-8?B?cG01Yi9MZ1F6a0FhSGk2NzUrZGk5cW83aEVMdDNUTlVqcllzRWMwaXJCRmtu?=
 =?utf-8?B?ejQ2K1lGSDhsWXJxc3VVTlZlcmdKb1FUUVNHS1R1dHowZnl3bWJSUGpoSXUw?=
 =?utf-8?B?aXZwUzkvRWg2Mlc4aGw5OWhZQlB1d2lpQWpNbWtsNXU0NXFKNkRCaFhHT2Fl?=
 =?utf-8?B?TjhicjRXQ2tJaG5KbG1ydWxLZTlFN29Mb2hPMkhpclZ3a29PaTNUODZkYlRG?=
 =?utf-8?B?cE0yWFRCdUsvSW90cGRkWVpjRkpvOXY1aEhGTkFxai9UTk1BWCtaaXozTnZO?=
 =?utf-8?B?eUdxVi9wUkE4a2padWw3RHZwbkNlZjVueERWbHJlV2RiNTBVMjZDZi9HYU44?=
 =?utf-8?B?TmhqbjRiTk5pd2hwdXRvWUdiY0pldFJISzFtOFNBVC9iZDVHM21vSnNEdkZW?=
 =?utf-8?B?d3l6MTRqQjEvNUdleDc0ZTBhMXF2Z1hQeTNkR1Rlb1VXVUNnelRvNXFSWWY0?=
 =?utf-8?B?Uk5qSnlVVzlxaWladnI4OVRSOC9tMCtZbGxDNkozenB3UzJDNm9FeURwTmVC?=
 =?utf-8?B?b3BBblliZ2NrUXdmR2J2SmRyYzA0NUowVi9HNUptMVcxeHJkd1hVa3B1c0tu?=
 =?utf-8?B?UDA5Q1gyY2RMaWZ3c1NkdEh1a3JrcGZBT3ZOalVhakwxM3ZqVGRaalBIb1Fa?=
 =?utf-8?B?ekRjTGFycGs0UzhjQXJRZytia2lndHVjOEhrd0hoS2YybTdKTG4xSFZmdCtB?=
 =?utf-8?B?RHhRSmhXMEZiWkdqUWVIbE5ZN01JRDZGVEI1ZXh2ZjBKTWZ3VmdFMEFDMk9q?=
 =?utf-8?B?Y0tsNHJvNDBsbHJIT2R0b3pVSDJFTGdFcVdmSmxNYnhZMm9oRWpiZ0xVRXl2?=
 =?utf-8?B?RVhucG9ua0lKRjJZa2JMQlZEUWJaemlhOG80eC9UR0tlYUhpL1JBVDRlK3Qx?=
 =?utf-8?B?YWw1WHp1TTI4Njc3WVlHMFlVc0hWSDNva2RCdXIzMGZVZzgwWm4wNGllcGIy?=
 =?utf-8?B?ZklYSlFmSm1uWkhOQ3lXUzVwa0U4dzdSbFVyOUkzS3RGRTd5VkwzRkJwc0NZ?=
 =?utf-8?B?ZXJWTGxWUm9ZN2ozU1RCTVp3VWRKZTRJaFk4bDhlMUFCc1c4Mm9yOUhjN0RF?=
 =?utf-8?B?V21McFdnUEJuOHYzYVZSWVg0RFAva1Z4QlNpbHJCZGljdCt4bFJldis0NmRw?=
 =?utf-8?B?RWZ4Vm9JdDZZNmI2NnI5Zk1UeWN1VDkvMWU4bjZjTFZQaWRyVHlrR2txa3hO?=
 =?utf-8?B?M1pma3RZQzdIYjhWb0ZsTGljVE9pNWtYMWd5LzJxa0s5TUxwZU5scXNEcnM1?=
 =?utf-8?B?QTU0RHpxc244ZUpKODhTMjRnTFpTVHIyQXlFWWJ2NCtLMDhsdE5XN2o1M09h?=
 =?utf-8?B?aG1ZV1I3T2grSFZMOExqSnowU0dHNE9GdTNMc2RSUmdOTHdlK21PTUczR2tB?=
 =?utf-8?B?NFdLZGI5ckFERUp0MnRmUzFKWHlZbThwQWN0bmwzendiRlVBS2d6aGpjaTFG?=
 =?utf-8?B?OFNBSnJ5S0dpbmJlcUJWNmtLSFFTTnVYSTJNOGEyVUZja21RaDJGbmdCUDRI?=
 =?utf-8?B?dGp4VnBmU0xjZUw1aTN1aVJjVmNFMXNKTmNqSHdpdmhMZ3BBM2c2M1I1Uml5?=
 =?utf-8?B?NXJpbzQ0Q1RQUDJPTTVRL2tQOUx4L1Q2dnVReDFmb2E3VzRRMXgycmxlUGwr?=
 =?utf-8?B?czlzaXU1MCs1RVd2SndsOXpyeUx0YmRKeUx1clkyWURzdnJhU0Y2WStTTUU0?=
 =?utf-8?B?ZEtEeE1Na3poYUphUkZoYWQ1NHd0NWhKRDNZQWZmc2RRU1VXZHMxWVM4QmVp?=
 =?utf-8?B?NnBTZlVTa0VLY2c3KzNYWm4vQk1pSzUrbjF2RFo1TnJoN0NhVllNQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a070d88a-d929-4111-7636-08defc5da27b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 12:47:02.3229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PalKmoz2QphR3zr1PH4x2DD9DMc1sDBnDbEjTehPgQj4ZdFwP6Gjj0XFprqKMgrULH+WcO/Qq2/2yJJmmpqnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354



On 8/17/2026 5:06 PM, Alex Bennée wrote:
> "Huang, Honglei" <honghuan@amd.com> writes:
> 
>> Hi Michael, Alex, Dmitry, Akihiko,
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
>>
>> Beyond that, sharing the display path is increasingly painful:
>>
>>    - Compute hammers the queues more than graphics, so sharing
>>      virtio gpu's single control queue with display/virgl causes contention
>>      and display stutter.
> 
> Is this just due to iteration? From a layman's point of view I'm curious
> as to what the queues are doing.

Really thanks for the reply.

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
>>    - Compute contexts need far more blob / shared memory than a display
>>    one.
> 
> I guess weights and context are long lived blobs compared to rendering assets?

Exactly, weights, KV caches, scratch heaps and the userptr/SVM arenas 
are large and long-lived, unlike per frame rendering assets, so an AI 
context maps far more memory than a display one.

> 
>>    - Maybe needs a wider ROCm / compute stack, cause the render model
>>      fits poorly:
>>      rocprofiler (PC sampling, SQTT/SPM, counters, high bandwidth streams)
>>      and ROCgdb (wave control, address watch, async exceptions an
>>      out of band channel that must not block display).
>>    - Events, faults and GPU reset/SMI are async and don't map onto fences.
>>    - All of this is hard to extend cleanly inside a display capset.
>>
>> On the QEMU/host side, would something like this be OK? One step, two parts:
>>
>>    - a dedicated headless virtio gpu instance for compute.
> 
> An oft-asked for VirtIO model is virtio-npu but I wonder if there is
> enough commonality for a virtio-compute device with the same sort native
> context type handling to deal with the those that want to have guests
> targeting specific hardware rather than going through an abstraction
> like Vulkan Computer or OpenGL CL.

Agreed there's likely enough commonality. The idea would be for the 
device to provide mechanism, not hardware policy. And actually the 
current ROCm implementation is doing like this, it can also support 
OPENCL and HIP.

> 
>>    - that instance served by a separate ROCm backend library loaded
>>      in-process by QEMU.
> 
> Is this library a binary blob or open source? The last time I looked at
> ROCm I had to give up as my AMD card was in an Aarch64 AVA machine.

It is open source, we are planing put it into ROCm stack, let it be a 
part of ROCm.

Regards,
Honglei

> 
>> That reuses the existing pluggable backend model, a second virtio gpu + a
>> backend library. It doesn't add dedicated queues for debug/profiling
>> currently.
>>
>> Waiting for reply and  happy to share more detail. Thanks!
>>
>> [1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1568
>>
>> Regards,
>> Honglei
> 

