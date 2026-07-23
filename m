Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021137.outbound.protection.outlook.com [52.101.65.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB974347FFE
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816962; cv=fail; b=R/VL75lfj58dgiAVcGzHTSbqkevXQEvufvuh6kI7KMnaAfK8wMD4DrBtfhAzBDJlIqvrXXICTwrG7jMR/J5kOLWdBx+gVuxZqRNe/2IiudvI+2TS2FM19eT1+S1ZzmgsPTvx418K/+sQ3qv4mGB6Q6JYN3Cmp7pOxcU1LciVnCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816962; c=relaxed/simple;
	bh=EYR1JB401I3Njy3zkoaR+XRHtvH5k2sUHTUVZBgbBNk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LvRiIcgr0CJ4qOdGmz7hX4CXC7VQ4IlQkK1ygHVVPfbyBw+fJPlh7cVB/WPu9XtM7F8nwLdwq10e0DPR0z5lpJ7VDt1ujuT8zOj/K4mjT0MC0WPOHLkuUp14LgIBamff8bPD5prngnlBAgPl5Y/Bkx1sK22oC6g42NDnC04fIyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=XtPy0F/x; arc=fail smtp.client-ip=52.101.65.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XtPy0F/x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBx0mgdYAsrvKsIWR5cQvE1BlXBnlntjgpVZQcLs0gcMfpv4l/tD8C28YM3VMv1TpjoI2Sdi6JqqGnsq+fcjYkZ/5CHOEvDvEpDNvIxg+KxW4n8jx7jCOdsllY8owqWLqXW4AxLB9YDptzG0H/6eURzGof0gPVPu5LYR8LdKDb7HrOSoPbpJ/QK16+HJg1K/L/bICMFetzOcYibTV8DfKlXsXQQi9/ceaaFenJNZkqUc4HNjpqkm3e/cTBwbHy9u7oUsxSO4t62K0rbCfmYj5ZiFITAsEMmk2RyXEZroyZlHTS9tC3NTrNMvSMW4ThjQZ3DyUlaYadiLPMXs2x/loQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=689DCyxtc2qcJULCPCNBv9P/zNrIUmyoug2aIt9GJzI=;
 b=SUkd8D/5GRXVgIxxtROqMb1ePZ1IQG7rKKa833WxCxmi74xMtR6iZJF3QVqj+AQ3X9N5q/6zur6Ie6eTDDgoDKEwLOlUSyOcubadxdBwM9kBDBeCRYkCL8fqQT+kaxDbk4/C/txdXCNTtXgCUSrPk7e6PEw2+eIYb7/7UnBLJoi05tSIx0gDiP19t9N0LvPx/jR3//2UjXvIQPjR/nX6EfuCDChJFrNjPpbPdcF3oZghBbZ1l1LRfn09E6aoBE0Ti/GY9iMCzrkWlFCp0qfbRCY/zIYMM50dvMFtG64bmkaHcbUjaWVlyiA3JQOCcsqIFZs8k54YXdTZL56PfVxV1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=689DCyxtc2qcJULCPCNBv9P/zNrIUmyoug2aIt9GJzI=;
 b=XtPy0F/xC3n2UX+gs/fZ2WjiJ/lUniBJhsuWfPS2+CvlBrg8bxhgDjewx+92m9nhojvwRVRAtKw4je/GllbuXt4ITgjR8h/hJUAjbI22OCGFkYQH2NCI7uynZHV9e6wlqgdfl3dL3b/E4M+cN727bZWe05p/NSuWooUuRP44Z9hUXKWI95gNlITNn7z5XeANXCngpuwYNDpZtcixWBy/VWXrADSzNvLBvqO+WY/JnhakPkNyEESjxLeVdnHm4BinNHL7ypv7h+vHyRyblUQ1zG5a/Vzz4SdLCKKYzzps2c9PH0aD8+5fUNYdcnTjURFZ9bPWIrZHBFNGdUc+1yJwYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by VE1PR08MB5725.eurprd08.prod.outlook.com
 (2603:10a6:800:1b0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 14:29:14 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 14:29:13 +0000
Message-ID: <f21667c3-64f1-40c6-9941-9453af173eda@virtuozzo.com>
Date: Thu, 23 Jul 2026 17:29:12 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com,
 stefanha@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, ptikhomirov@virtuozzo.com,
 den@openvz.org
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
 <amCPLOrnpYmr5n0p@sgarzare-redhat>
 <82066fcb-150f-47ef-86a7-0df0f9eb41c5@virtuozzo.com>
 <amIe79X3j7GxDBdO@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <amIe79X3j7GxDBdO@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::7) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|VE1PR08MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a2bc38-a71a-4166-153a-08dee8c6c4bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|6133799003|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4cjD38QhH4P3TFChU22Z/3u9Quaeb21KptjxEneEy8CG9DmojmwoHHPZT5mmL0CO0DnkYyrBep29+JYFodVmc7vvLrDpBGxNfkEeT5w3CnT8FwNBEoXD3o2/RszX8o2G+PV1onlMgDgYHDogWRRZwvQy34Zez2IThlVCePc4iCvhVzeEDBpbpgAaae5nFkvudEZwpcTCVLvhw0SxLC45rF5P4lwJCPI0V+PGao+qNp8SG/UfInyQss6KDfEPjaykBUFbpLNtPCCKPqjCjvh4ItRWileJ3XjMANaaYxgZkb4j0aVplzBO2FLXnSKJ+zS200dwiTNVdLWVE2HcUD4q89Qa55u6M/2de79qSJtgH4s4uMa1Z/nYXD4+DSFMxes9W/CwxTx8IKt7hGgIQskexb7rOl7gGgs3U/9Lba8DHSdj9vaIlH64o4uLaiiodf0NpUoROjr+qBvF70UtNl6x1AvFo+7KLI2++cZ81v83SiCVhfyV8ZV75YGk8unYG/DLGFsDaNeuGT/qvbe9V5/Gl6mph32Z5yA/45GWSTEk6gVvg64CUbX7j1iwxeteFkMDvoEkQ3P68qaR6AlVcTfgJJ6IlmNi7CjME20kaJFK3mE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(6133799003)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVJNT3RIZGhIY1hpWDcwb2NUWGtsQWo3Qlk1SThaMVVnNDdSRFVUR0lob1RN?=
 =?utf-8?B?UmJlVFdqYW5TTHV5b2dJOTVxYjg4OWlUTERROTJ2TUdUQkE2Vy9sT1B2Q05l?=
 =?utf-8?B?aGo0UExDZkpGbFpzM1BTREN4aVliaHdPR1EwVkExdlRNOGxGNitabGhNVExY?=
 =?utf-8?B?MldjcmR5ZXhMZ2ZpMzdoT1Nmem80L0JnRGlDdHQveGZGMlIwYkYwN0tmK3kz?=
 =?utf-8?B?YlhGUDNiSDdmZVplZWFuU0JjbGFBNEYxVjZJeWJLS0lLRGs0UjROY21wNjJs?=
 =?utf-8?B?SVJKWEFnbzArWWorUjFWbWlzeWNNSUU4L3VWNE5GNnJ5UXhTRWdadGNBZEdj?=
 =?utf-8?B?MEU0MExoQmxJTVc2ZHpwV3lsdjB1U3JLRytidDg4VDM2WVF4SlYwQStYd3lO?=
 =?utf-8?B?SXMzYkxCWHhTc0dPWUl4c3hXUG9Gb3lxVUVMWVc4VG5hTmNKOTBVR290ekps?=
 =?utf-8?B?cWtvcEZZSGZBMTJJSlM4V0ZsQVJMcGFiVWhweExYcHhWWnBRRGdMY3JYaDdO?=
 =?utf-8?B?bmJXajY2cGpmbGg1NVd5N1BTdjlKb2g4L2d3OWtnQW1sdjhKU0o2RldvYy91?=
 =?utf-8?B?OE4zRVdSdkw1Z3FyU2ZObXpvQ0dxR2FIdWYyZHlIYWh1aVdRZ25pY3pERHJ1?=
 =?utf-8?B?cWxkcGtkcXF3N0xpWVMwc0toSzhHRElvK0Nsc0I1VmRnc2NSY01yZGRZVXIx?=
 =?utf-8?B?MnBzZWpHckhZMDBONG1NS25NTzJ5RWU1SENHdmo5bFo3MHFtSE81NzYyTS9X?=
 =?utf-8?B?N2RrT3NSY1JPakl6ZWpJWGo2ckY5REhMbGtIeUgzTngwOEtTbTdSWU9WYjJU?=
 =?utf-8?B?ajB1Z2NyN2pZVkFCZlE4MTJCdkFRNVdMRFBmNG9OKzM2OENybDBXTmFFTEJU?=
 =?utf-8?B?VURNdERQUy9VbHhBVlcvUGdUb3lkSXhSVUZRN2RYOXhmaE9ITUloK0ladnFT?=
 =?utf-8?B?bUZSNW55c1dCRkM3QTAzODJTajdiZjBzKytITzhOd2cyMFFUYmRYZU40L25U?=
 =?utf-8?B?M3VyZzFIRGhBUU5IMEx4VjBRNkp6RUNuU0Q4SHRHRWt3b3YvaVFodFhHUEFR?=
 =?utf-8?B?aGcwTmgwblBud3FRcTBzeHYxenE4enp2WGtpZnpFUi9jU3NHUU50N3hoeVI2?=
 =?utf-8?B?N3BaeS9US3lFU0hzNGc1MnZXckl5aFc0RkhidVJrQnJiVkl0Q1VWUU91K25j?=
 =?utf-8?B?d2l2WW8vdzMzVjUzL0luTmNpT3djTm1BUVgzTlJpVGdKUkRhT3lQbVFyWHJz?=
 =?utf-8?B?bjBQaitLcUJlRy8xcXFpaDUwTWF5UDdTQzNCZjVZcW5NNGQyeEVwTjQ0a1pJ?=
 =?utf-8?B?WGdqSWpCWDk2RExaZ1RacmFHQXRIQVZwNmRLV05wd3I3Y0lBVUhmU2NhM0VG?=
 =?utf-8?B?VTdUTk5DR3QzQ2Q0RThuNUVPYmorWDFXcWNKNFZkTkdoc2FzcFBJSVRoM3BY?=
 =?utf-8?B?ZHJwc1ZyYXFDaTZSWUlqNGlRbTdhUytLb2RkRUdnWWo4SzFac0ZqeGlrNDZ2?=
 =?utf-8?B?bXUzdHRWUnZwM3JVd3diM0FBSlltM1cvZHdzelJoMkhGay9uUy96VitMWVpx?=
 =?utf-8?B?bE40WUxWZHFGMURzTWFYb3JBYjdDVURXaE5sc0lYUGdONzI5dHlVbFg5djdx?=
 =?utf-8?B?dVV1WVliY3FYVUppV3RvOUdCSFpsa25QNG5tajlDbHN2WGM2Tkl3WTR4b3Bl?=
 =?utf-8?B?a2U4bi9aT0h1c2g3T0VrbFo0YloxYjlGQmUydVdkaEllZ2FscTJJRnBQMzBM?=
 =?utf-8?B?LzhLOE1aY2VqL0dEWHlXc2hFVm9JVEhqUk1uWXNBc21sQ2g5MFplVTl5a3BS?=
 =?utf-8?B?WnZETm1UYkR0WERONUNVODg2TFRGbUFiaWRvc0hCa3NNMDlidldsc1pMYi9Z?=
 =?utf-8?B?b0ZxNTA1SGZ6RVA4RGNLVTdSZG03bFFCUnZXQWpFMU5DRzkxS1VVUXlvZGRX?=
 =?utf-8?B?aW44QktlbjNBcEtsVXdLSys1Vi9RODlJaEJMN2xORmsvZ2Z2b3Mxa2VqaFdw?=
 =?utf-8?B?a25yQU1INGxiZXg5NFN4SlZDTnNTa0JVeVExLzRnZzBCM1E4VmNMV1FJUjU1?=
 =?utf-8?B?NVlEYXpBWnAvTGlxK1R4NVRqL1RwQkN2NWpZTmdjVTNkZHExQ09PdlpoZ2xx?=
 =?utf-8?B?T1hRbDlqbU1RRm9sUnJaWU5LNVNGWjhYc2toS0tUZ2oyQlVqV3dPRERBM3BV?=
 =?utf-8?B?MzM4a3RLeWNPUWpPcWN5MkFWYTRUQ3ZEM3hKbDJqeHd3azA0YVZsbnl0cDdN?=
 =?utf-8?B?dVc3Mjg4a25yMnlpSzFSQ1NReUZPbENlak1sVlJlcXlPd0pHMUpiZmRLY3RW?=
 =?utf-8?B?RXlDdnpjaEhMWXpNbmhoS09jbnorc2M2TjNjQW1xS2ljVXNQZUd2WitOZHZu?=
 =?utf-8?Q?0440AaAnbrSEAyzo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a2bc38-a71a-4166-153a-08dee8c6c4bf
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 14:29:13.6658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNOs1YKL63Cn1B7MdPRR7zujbErWsgCvhi2yuOfY0WWYhKA8s0Qf1XIFMusHv18cK5Kw7bTEf6lGIbJzgqYx8zfy36y6md+E6UR6HsGqzx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5725

On 7/23/26 5:03 PM, Stefano Garzarella wrote:
> On Thu, Jul 23, 2026 at 04:57:47PM +0300, Andrey Drobyshev wrote:
>> On 7/22/26 12:43 PM, Stefano Garzarella wrote:
>>> On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
>>>> vhost_vq_work_queue() only holds the RCU read lock while it dereferences
>>>> vq->worker and queues work on it.  vhost_workers_free() however clears
>>>> the vq->worker pointers and immediately frees the workers, without
>>>> waiting for a grace period.  A caller that fetched the worker right
>>>> before the pointer was cleared can therefore still be queueing work on
>>>> it while it is freed.  And even when the queueing itself wins the race,
>>>> the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
>>>> future attempts to queue it are silently skipped.
>>>>
>>>> None of the current callers can actually hit this: net and scsi stop
>>>> their virtqueues before the workers are freed, and vsock unhashes the
>>>> device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
>>>> before the workers go away.  But the upcoming VHOST_RESET_OWNER support
>>>> in vhost-vsock keeps the device hashed while its workers are freed, so
>>>> the lockless send/cancel paths become able to race with the teardown.
>>>>
>>>> Fix this by clearing the vq->worker pointers, waiting for a grace
>>>> period, and then flushing the workers so any work the last readers
>>>> queued runs before the workers are freed.
>>>>
>>>> Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>> ---
>>>> drivers/vhost/vhost.c | 11 +++++++++++
>>>> 1 file changed, 11 insertions(+)
>>>
>>> Sashiko reported some potential issues here:
>>> https://sashiko.dev/#/patchset/20260720102241.371610-1-andrey.drobyshev@virtuozzo.com?part=4
>>>
>>> IMO the first one is pre-existing, but not really sure it is a real
>>> issue since happening when the worker/vmm is going to be killed.
>>>
>>
>> Sashiko claims:
>>
>>> Will this leave the queued work unexecuted and permanently break the
>> virtqueue by leaving VHOST_WORK_QUEUED set?
>>
>> I agree this issue is pre-existing and doesn't have much to do with our
>> series here.  It looks real, but in reality should be harmless since we
>> may only hit it while the device already dying.  Means there's no VQ
>> state to be saved.  The only potentially observable artifact I guess is
>> a warning here:
>>
>> vhost_workers_free()
>>  vhost_worker_destroy()
>>    WARN_ON(!llist_empty())
>>
>> So more of a cosmetic noise on a dying device.  Again, not relevant to
>> this series.  But one optional way to make it go away would be to clear
>> vq->worker under vq->mutex in vhost_workers_free() (mirroring
>> vhost_worker_killed()).
>>> The second one also not sure if it's an issue since the sender is not
>>> lockless IIUC.
>>>
>>
>> The term 'sender' is confusing here:
>>
>> * vhost_transport_send_pkt() is the .send_pkt() method of struct
>> virtio_transport.  It only stores skbs into the queue, doesn't process
>> them. It indeed is lockless as it doesn't take vq->mutex.
>>
>> * vhost_transport_send_pkt_work() is the .fn() method of send_pkt_work.
>> It's called by the worker thread to process skbs in the queue, calls
>> vhost_transport_do_send_pkt() which does in turn take vq->mutex.
>>
>> I think sashiko points out to the former.  Still, I don't think it's an
>> actual bug.  Look:
>>
>> 1) By invoking flush, we wake the worker thread:
>> vhost_dev_flush()
>>  __vhost_worker_flush()
>>    vhost_worker_queue(flush.work)
>>      worker->ops->wakeup()
>>
>> 2) Then woken worker does:
>> vhost_run_work_list()
>>  llist_for_each_entry_safe(work) {
>>    clear_bit(VHOST_WORK_QUEUED, &work->flags)
>>    work->fn(work) // for send_pkt_work = vhost_transport_send_pkt_work
>>  }
>>
>> 3) And then in work->fn() (vhost_transport_send_pkt_work):
>> vhost_transport_send_pkt_work()
>>  vhost_transport_do_send_pkt()
>>    if (!vhost_vq_get_backend(vq))
>>      goto out;
>>
>> As you can see, we return early in case backend was unset.
>>
>> So after doing this flush, we have: 1) QUEUED bit is unset; that makes
>> send_pkt_work re-queueable. 2) But the queue doesn't actually get
>> processed, and VQ state isn't actually touched here - so I guess
>> Sashiko's conclusion is incorrect and there's no actual bug.
>>
>>> But, please can you double check them?
>>>
>>
>> In general I'd leave this patch as-is as Sashiko's complaints aren't
>> very convincing so far.  If you want I can add another patch which wraps
>> NULLifying workers in vhost_workers_free() in vq->mutex.
>>
>> WDYT?
> 
> Yeah, I agree, about the other patch, up to you, but I'll eventually 
> send it separately.
> 
> Thanks,
> Stefano
> 

Alright, then let me resend it once more along with this 6th patch, so
that we don't have it uncovered.

Andrey
