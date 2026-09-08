Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012059.outbound.protection.outlook.com [40.107.200.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F59436B912
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 05:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845604; cv=fail; b=pUpPe9MjglAdlfkvB1fNifBnAnWOrKZyjAynUxuXsMhuj23C9q2GOFa/1edmBwFWGHcBR77y25UiHOnrAh38SpVFUBsDOmymSEGsiLp+Rv8jycD9HzMhzT1zDkWaVlLgQ0Iyb42xbjjuwk7/dHL3j3PcX3VaPBe23MtY1+HNZiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845604; c=relaxed/simple;
	bh=BzkqkZdhBzYDadoLYu/9w8WQQTApWDXiRp0jBA8gccY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P1/JDxcfkl0DBdxl/sGtZQxJdEgRHXqlrnrQIBYcStlqgDpS0sWRI/a/ge6tTiP9gCLv6YZjdTJKTGO3qta+Qi4m00oJHs4PnnBHh3fGUM2ssQMbN+H55WmN1tQGB/lTw5q3b8c808QDed7cwN0IRMy4O0Uidb2FyqYksDpSQz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yR+Gw8dq; arc=fail smtp.client-ip=40.107.200.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yR+Gw8dq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSbTQIoj7u1cDXPNR03xEa539tyocqZEf8buMX2Yd4ZPN+C2G/AASiH4ayL/SGTxa4zzKsmmR0HhU+H23yNx03LDQsnN6FuiAYvGE0l87ULiEOXCNlqZCT8OOHNoXH4TAa3bDU0+mLVrDHDWuo9ZTANCHdPgW5vXWMfXynXo6iV02ika4vEyVUUGb6PrLzhW4OTFRlqllSSCtwxEChDax2b1bbAR+dyTDRwDNUJeotA+PorLpTBgNCHqh3zz4SVnqpwNelgsHr8CakgqNyMNfjAhQxZmklZLMO9kkE0DfpMYhQevI2mfgaxUVeTdDHEom/nO+mlRsZEJRTPjCwn8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeuiPf7USSxgFsmNjvg3g9OXorJmI1iO2uJ52aEY71E=;
 b=Tvd3nyzvoSr5hOAiHorzMA7McSVf3CPnAOscMr3zi3xmVNii+lz3EeM8X4wyXfkYA2cmCJ37dKyibqdIMWJ9SialQexMFY6vNasukqYMzwXezi61oyFYZ0/Qc8ehUQT2hvxSleq1zH+7hqE1IBkuP6QInL6B+mSyu4TbFfUlvr4qXcOmmJO2oRjxlB7sYqCJENBWelu1o0GlxaIa9+3EQTfMx3mfcKsRIvCWfLPxtIiRXZfXkTr0h3R9mdnQS4ICgS30V4YeDC6dQWEuhaNW15Qgw89K+e+o2AO1obsjEH8nAv3cBvVbll6StF5HcL6VvXlUolRyMS2ngPHPfRwhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeuiPf7USSxgFsmNjvg3g9OXorJmI1iO2uJ52aEY71E=;
 b=yR+Gw8dqCVCOYGSaxVl+02iEErPKls/2AhiDCPjhKSb4lvSerz9TgyH+hlclOVDi0ZOd0AN6zpY7Viji5YJqwCF73RQ0B1S3LRao7cqNsSkSwJ+RDjuGzRJ/NMUUv6XW07DyL1kYqNJrGvul+5vvtTRsIfDFAOnlzs1lvpNwqaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 05:33:18 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 05:33:18 +0000
Message-ID: <0a135279-74da-4982-98bf-6de06131c285@amd.com>
Date: Tue, 8 Sep 2026 13:33:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: About new backend for GPU compute ROCm in qemu
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, virtio-comment@lists.oasis-open.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 Honglei Huang <honglei1.huang@amd.com>, Huang Rui <Ray.Huang@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
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
 <9640c016-1a64-4ef9-91f1-7955c3fb63a3@amd.com>
 <ebc19ae7-0cc7-4252-a85d-1f010aea8a12@collabora.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <ebc19ae7-0cc7-4252-a85d-1f010aea8a12@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0067.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:39::11) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|MW3PR12MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb0e3f9-befc-4f9c-df17-08df0d6ab028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|4143699003|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	U6txMLFvDRZcuJq66DVaW6uq+ik49WXWinFLRFPN823BidEauo2P41k9fyhAlHw4itfm6X/ed7wMLon9N01HI3VNovawSj/SC/IWZ4r1Q06JPOL8IRE7DDedVyICYWn8s41ad3E2mWCGk2KIIxbYinTeyW1P4QmGPYvPqvqC1vNaQ8KW9kAUyNzstvclbnosHj08ObgjEZFPgsyBytyiSH+PXqip84opU8k4ogBmlAE8wq/I0w0dJKGOPoE/HY+1xlMct6Bfeu/TWOCx6SuL3H/49jRlFfC2obuKU6cPz/IJrJI+Z5VGwCkUNGXuzbBR0ElVY62mxTOMn4VvQhZWgIRZ+GzTFU3Zn+QFeHOnfx9u8/eYFHMBzXPiHrLBCJRZ9vtKgBwSAmAqH+fvuEm9wMxfBu77Jr1pYTwXDYvJE833vlxNtzOcoEOirzXco0Hl1p9t0XXnBjoXj7DsxcwnniQm5ttOCUF2hr/FBt04+r6vqWiwRq1h4U9SkgvoEaed+AGniaicyOa70obBxXMvKRERNCWLu1MGfQPFpp5NiCosV6YCjAbyhP35I8QJKvo26mJjOMJ5366uTCgIaWiyHW2hzAZaUpLv9taBol0gW4GZ/a6rQbjyuF03K8kJJnsVj4PA1kQTjHmEBAyofVOOrwWNxH34ahIuUrjE8RfGpeA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2ZHOEhXZm40d1o5aHNRVWVzdTlTdDJTMzZCK2sxU2xYU05tRkI2SnpScHU3?=
 =?utf-8?B?Y2o1UFhPR3oxQUM2SXJsYmlvc2EwcHBKbGhVZGF4VXlmYmVNZmhqN2hCbVBr?=
 =?utf-8?B?dkhKTCt4QTNxTkRMWDcxRU1yb1RkT2lxeEwwSFFjWU1sdHdlSE1YMUtnZk1r?=
 =?utf-8?B?Nmt4VStmZmNDQ1l2ZUVLR0NRcllhV1l1bzdRVWcwMkpGMnRwUGpYRFEzSy9n?=
 =?utf-8?B?REsrcW0za2grNElIUk93K0hWYStxSTdQZGZSNm9IanBMZU5xa3JZbVJQMjlu?=
 =?utf-8?B?Smlvam1HdmJyM1Q5T2RkVXFQTlZIa1RueHUvWmh4ZlFEd0VMcnkzVDhwOXNZ?=
 =?utf-8?B?RXovSXFBc0l3SkQveEgycVBGNE5YcERrSnhmTTFQb2VBRW1UVlhnZWozNkJv?=
 =?utf-8?B?MHcwem5IWEYzVTk4a3dQUmEybVVhNlhIM1JzQU80T2J1Sng3YUwrRm9TNzJE?=
 =?utf-8?B?blpXNStORUxMQXBZNUR6eFh6MUNOVkE5ZmdsVGNlSi9pRURaZ0IyZGRUcHo2?=
 =?utf-8?B?OFRTYmRWTThhTUN5WHJlalhvb1YyMjZ0emg5RENwUkZMR1NiZlpqeThIbHF4?=
 =?utf-8?B?WHJ6NGdsc3A0N1JMWXdCVGk3VlVrczh3UE5WdXFMejlwWjg5TllVNHFSSEFu?=
 =?utf-8?B?Ujd4c09LbnRpb1ZHb0xMdCt3bzlqZXZaTUsxUVZ6ME80MTBTTFNhbnNpTGl2?=
 =?utf-8?B?ZVMvL3dRc1JIZVhkY1RXalJRcm1oaWI5ZUFLVEZZWVIreU1zaTFNY0hhcExu?=
 =?utf-8?B?VlRvTDJqSXY4WnpjNGdlTS9VTTgrRCtKRjVGaHh2cEpmeDR6Wm1VWUkzYnFG?=
 =?utf-8?B?RDNrenBZMHRIYWhtVVJQM0c2QU5qT0FhVlduVy8rUHowNnlHK1pxMWdjSEhT?=
 =?utf-8?B?MDNiZVFZUnUzNlprMDd5UFZxRG9XK3ZvanhtWjhqd0FCc0g0TWZoYVNHQWY5?=
 =?utf-8?B?MFVRZ2pSdjdHRXVkSFB0Zzh0bGo5NHpqWFI1NG9jQVdGVWJpOVdFSzNvMkxI?=
 =?utf-8?B?L3E5anhya3NjSHNFUU5Dem9WRU1rcmZtL2pEamZFVm1kelJZMEhUd1VUeGpz?=
 =?utf-8?B?NGxVRTZ4UHNHMEVROTMxSjFVRXpaRTFYQU4zU3ZCUE9WczJFL0FZeXRqQlBN?=
 =?utf-8?B?RzU5Wkh4Tm8xcHlrdHFremZ3cGhDN0Vsc2Z6OXArU25LU3ZIb1lNdUYyb2F0?=
 =?utf-8?B?Y3kreVdtQmNuaW11SDVXemVvZXBJS09WRlVMbWI5U3NUZjFHUDJLOFh0U2Z5?=
 =?utf-8?B?dDZsZDVweTQybG5iRlk5ZjYvWm45UlNBc0xGM3FsMTBSVjl3VDdlRGEzcGRj?=
 =?utf-8?B?ZnpiWHZIdTBMZ2RSeGQ2dm11NHg0Vks4YTd1K2hOdGY5dCs3ckd1T0ZjTkhY?=
 =?utf-8?B?ZEV5WDNQUjVReUNlOVhIaHFuVFBPUThQWXJCa1dLRzhDd3Y4R3ZWODVYck1T?=
 =?utf-8?B?eEdla0gxTnllMGwvT0FETmc5MHFMamtMUzFiUC9UTFcxMXRDZU5pYUlSQ213?=
 =?utf-8?B?ck1nOEwvc2dKMDJiSjJLb3ZTMjZ5ZkNDRE0raXVlTVhzZzhMbkxPckpzYllp?=
 =?utf-8?B?Zlh0SXlTQ25MMVYyTlpKamd4RzZMclJGY3ptUGk0QVVKaHFVcGkzdHQrUzJ3?=
 =?utf-8?B?ZkZ0RFBuWE1pMStzRDBjSHBkRTJGNjM2UEJoVm53d2NPc1k4Y1FIZlF5Szlw?=
 =?utf-8?B?Z0I1NWRZTUJSaUlKUi9xKzhDc1pSbStidnlGOUtBWlk3THZ5dENOYWkrQ1FM?=
 =?utf-8?B?ckQ3d0FHak81cU9nUkcvYUF2MFBUemJxSXJiWkY1eHgvOFdMTFlNRWVUY0F3?=
 =?utf-8?B?Z1JETWhscFpCRmk0RUFNZDRJb01JejQyTHlHbS93eVRDUnRHNnV1QjlJcWxU?=
 =?utf-8?B?aDBkczd4dUZWaHlxeU5DTHVMT2RuY005dlZTaEtiSjdJdmorQkhTSjZjMHQv?=
 =?utf-8?B?bkhZSzU1dTRWalVsbHdnUzRsOVpRYWlESFM4U3pScXVETXN1YmxqQzRFa0VK?=
 =?utf-8?B?Ym1pbDd6YisvOUo1TTFxcVdtMkpOWlZYMXAwczBZNVlLd0U4ZWRFcS92WFk5?=
 =?utf-8?B?elA0VnRPWjlrTzNxVDNnd2lXaTI5eldsSXRCbkpDdGV3WUthdG9paVZmSWM4?=
 =?utf-8?B?bkJJYnFmZHNxZ3RNT1U5ZWlTcjZKREZiR3l5OEZUdVR3Y2xNNjY4MXpmWXBO?=
 =?utf-8?B?N25hak5oTlh5NXdKSEUyb0RTUTI1eVZ3YXVLUnh6Znd5L1NQTjRiREpKRWZS?=
 =?utf-8?B?WG9Db0wvRGEvcU5KY1EwL0RrL2xrcGhGampLRmtzZ3BISXNLVjlVaFlHb2Rj?=
 =?utf-8?B?eVdjYnl0enlIRmRlQ0x0eDVIUTYwUkxkUmxuZnQ3cndFMVFpS0d3dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb0e3f9-befc-4f9c-df17-08df0d6ab028
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 05:33:18.4429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bzbIdV0eLA5O+RBW+ZUt2Jq5earJHBc/0W1BExl+XzEb6qmSLlH/XfoU+9yzxGpKMrEpRvAnT+BOjBg6zTMBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427



On 9/7/2026 9:12 PM, Dmitry Osipenko wrote:
> On 8/20/26 13:49, Huang, Honglei wrote:
...
>>>
>>> These are great news. I suggest updating the MR description then so
>>> that potential reviewers can see the progress.
>>
>> Will update the virtio userptr and virglrenderer PR in future. But
>> unclear how compute will eventually evolve on virtio. The virgl version
>> may only support old ROCm version.
>>
>> And a single control queue is the design of the virtio GPU, and it is
>> indeed a bottleneck, modifying it is difficult. However, some other
>> virtio devices have multi queues for different usages.
>>
>> And actually such as NPUs, TPUs, or custom ASICs, no display compute
>> card all go to the virglrenderer seem like not a natural long term
>> abstraction.
> 
> It's not clear to me if you're still wanting to have current virtio-gpu
> ROCm context version landed upstream, or you now looking for a better
> alternative?
> 
> Virtio-gpu multi-queue support was in discussions over past years,
> primary driven by ChromeOS+crosvm needs. Yes, it's not a trivial task to
> support multi-queue, no progress was made on it AFAIK.
> 

Yes, we are still aiming to land the upstream ROCm native context on 
virtio-gpu.

And please take the large buffer mapping into design consider for multi 
queue support, we have a performance bottleneck here.


Regards,
Honglei



