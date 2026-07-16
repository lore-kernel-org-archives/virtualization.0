Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023084.outbound.protection.outlook.com [52.101.72.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25643859D4
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224892; cv=fail; b=cUqLAdlXwTrkKnZcq/6sd7yO6omrKX+XN9rFHx5Ti0PfaZ9toTE1jKF63YF8/E9fZo/SnlkREla4ib7sL7mWpHPdROsUb5aoDE92aiJC8qqPpkK5utGMG/crY5bVw0d2e7yEP8n7MJjTXoFKUr/dDdvHuS3qAvmKIqi08RU5kvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224892; c=relaxed/simple;
	bh=XT0JFGVxDeSiGFWtdWXsaA6wdB1rDaHaobojgGMM/3A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nzZ3ZlosVv/yegD8gv2YraRAsRi+OiqmGbRLxw39jvKwiR4DnRQgwFuVIh9iIHv/Cr2h5rUv2ChNMFWi6EdORBoyfxOrnJpIoQ62HV+JktBKZR9MihYRa/YmdQaqpJkQJWQBVHkpg8NUw2FPb862NdvxL39hETWCI1J06AEMPhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=F3HHAdzR; arc=fail smtp.client-ip=52.101.72.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="F3HHAdzR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APAOiCHyfCYznz/aUlOiUA3+KPCckV8Q8UHf9xvoA6a2kZ2tIQAZOmWPaNhT6WyGREwgpxLbPY02821O4TgcwhQZBP48aOVcEbX76zjlV05lzn+FHJ0bKASPR0hZ1Lp7jKDFaVRGMeXuoBnSlmesnIzMZ7GZd68unKJKuyILGllOAuezGm4aU1WITqsijMDMbUl8nhZaIY7zo5NxO1qHRAyQbwAs7mv4RxAlIGG+TmKExxYSvBR3L/bvi+uPv2KLRmRz7i/RLRxjZd3MPxeh4+0Plm5E7laOAyzaPVD2XAkRYtb98JcwZhV1Pvs3x1HmDkobwLyqWsznaQka5iLb8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/bw8AlgIrJH6n7n4J1iNoZ5XE/tNyzlgktNpS2Uke4=;
 b=jw73TOxd2nMa5ZRJJSMEZBaOpLCn+0MEptqp1Nw5etyh6hyMrML0xCu5nG+gVeumBxRcRPB4LWLmNVE6eIrE0LVBTWD2vfyFzpsy36JB20sEWRlnQUXt64ZpvD3RChon1QKktE9zAknCvkR1T9s+Di1pbO21ZqEI1MCXLOaIH/jTUPmCtrzEQv5w2m4xuZq5GrLVxfZI98c0CayolyyYUIOBYpdndWXRNLKAlde8IDSTrGrFhUqA0qqrv6a4WShPA/6nzSZFUednAAiw0XUM5g3xcnm+jkbJYjFY8+WyWy6PKfc0Uj9GWPm9A2BircAmAtRzUX4FiJi43/RQLPz+sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/bw8AlgIrJH6n7n4J1iNoZ5XE/tNyzlgktNpS2Uke4=;
 b=F3HHAdzRHS7UphdyVfo+c3xuiY4BKX9r3LvXUYwMUwEI7YCMQwY2XnFTNmUpI/9oGzvZLe5z1PCyC7+9S+e6pLBio5nVM1eTZNtyhNVYNAWG5IpB9m5t1uPiCSbyfxta7CkpTUggWOwgadhq58pot7EmfSZridBMu+ku9mV4lba1vzBX3aCh96uH8nUQiOswoM19mUyJiX/qxWgimveyEKKmkEytGpyz3mcPCy/snG/AygrQeAxOolxwwWze2kqAAstwIeQg1XjEanEc9HQlIVn4Wa2ClToOu628i0ffRYczugb57OEwbPztS8c3A+C/UrntapLfNbWGs3B5zoR0qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV1PR08MB8498.eurprd08.prod.outlook.com
 (2603:10a6:150:82::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 18:01:24 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 18:01:24 +0000
Message-ID: <55d7c896-b871-4c50-a324-35f5c4a9d11a@virtuozzo.com>
Date: Thu, 16 Jul 2026 21:01:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] vhost: synchronize with RCU readers when freeing
 workers
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com,
 stefanha@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, ptikhomirov@virtuozzo.com,
 den@openvz.org
References: <20260714151638.143019-1-andrey.drobyshev@virtuozzo.com>
 <20260714151638.143019-5-andrey.drobyshev@virtuozzo.com>
 <alibLtcrC7o5r4Dh@sgarzare-redhat>
 <2f680236-f4c1-418b-8401-4dea1230caf0@virtuozzo.com>
 <alj_YKTitwqMjAez@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <alj_YKTitwqMjAez@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV1PR08MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6a5061-acd5-4bba-d6f3-08dee3643fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|5023799004|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TZHxwHX56/n3XRhoSJryOtjPkSx3KPb5Mh0FqeoOAq4m1fwhy6iSmjhktPnOufAPErnQYRQW3+MCU5DWde7u5WtBEVaZaROqN963rLm8GL9UJPLXucvDwSXmZqhh3/lWyBSggYIH77UhoZ8zO3idX9i+c93rzongxMFTAB1Nlwv5WQUdIKoQOTrWZwBxB3EwDx6PC3PeG3dcG83jWU6SzCt0E4QNQVcdUfFL+fVpwfLsoj/t4GX/UnmZx5yqI9P7W76NP/JVOHvmKbziMBNS7tmf4UTO0StWoO9a0BxHjzhN0aX+dV5dl8/JEGW2jJzzYiuHhWIgD+J2R38LpM7+65xn4SGrTtl7asshy6miVsY+amzvmp6QyjtLwrZ9TVavdOEbjyJSY6FY6SFjCk9wE3vw/gZX7PPw+GtMss0AZeBBUB76GtwKoo25lORgXvhrBFl8JPs/T7E+vzS1R0YKgFgY/5r7dyM3WCBrEx5coOo+bbtjsanQBsJMf7Sjniy9R3otqa9mjTEKvUeG837ghqb1ZE5RqsBkMGAU3HLf/OTIjdgmU9ua32bC4BMOuSwwZm13vapMPVQfAbLgaDp4FTfPCXJOtKIjgjr44UlWDYGcKK4XFelQJq2tlD+XTugjSqOMej1AQ7xkN3wBBRzaWvdQzpEByKI+3xwS/8GxKEI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2N5MngwRGo2eHBCb3JqbHRjckozWG5ORnVNbEdmQmFhSWZIRnAxYk42OUwr?=
 =?utf-8?B?QWh3RDJYWEcrUE5SbDNzd3NseXBsZ3VycXBrcmVrelJibUxZS3VmZEMyWmQ1?=
 =?utf-8?B?b1ZmaVg3dk4vOW9RYVJMVTR0dDgzdmZXbU5JUmE4c2huWFRkZ0xNdUs3RUtU?=
 =?utf-8?B?aWFNRmVIVzdzMm9KWmhzeC9udmo5UFZhSWhSNjBxUEJzUFprZlNsc0RZaVo0?=
 =?utf-8?B?TDJWTWo1cGxGV1REa0x0YmhHR2IzRnJQYXJkMGlQTnJJRGU4dXAxcS9pOEs5?=
 =?utf-8?B?RFFJUXorQXE2UFV1ak8wOHd2dHVZQXRodXlDdDdFYlAwNmFKeEhNRFlyNzNS?=
 =?utf-8?B?d2x1QVdsWGlVUUFqZ2ZwOFBIaUMrL1hSNERpbENzOVJhUUpRS3lleUJDdTJa?=
 =?utf-8?B?ZENJMmVYYUVqalE4eEx5SmUzdTJMQ3UvdEpqQTdYcWpwYkdVSjJ0cHNobTFP?=
 =?utf-8?B?ZDB2a1VXZE1LMTdEMGdhaWdxVEhlRlFIdUdKT0x6VEVCVWg3TDJDNkRMV1Bz?=
 =?utf-8?B?U0tTWFVBYzRDNnRpVzlYRksrMVNiVFV0bUpWZnZRR2VjaHFDcTNGT0VQWDNo?=
 =?utf-8?B?cFA0bkx1UzgzS3lLODMwc1pXUXgrdStKM3h6R2RsQTkvWGY5VkRDY0QxVTNK?=
 =?utf-8?B?TnhsOEN3aHhYald3RnhPVHRndkhUUERkRHBnbmtuVUc2bCtGS080N1Q1QWl4?=
 =?utf-8?B?S0hjOGdaVVB1cmhHeG04NHZLRlNtdTVmUW1reEVzcys4OFovYTY4cFFwY0xH?=
 =?utf-8?B?UmI2NS9SS09FSzVPQjBsVjVqTUEvY0FEZW5oaEJIZC8zdDdkRTVidFVSNjFE?=
 =?utf-8?B?WCt6YkZ3WkJ6cUVGaFZFMGM0YXhEek91WU9XTVRCMGR3TzB4dGZzdUJGRnJS?=
 =?utf-8?B?UkNONHB4Wi8ySHN6SkIrSG8zUCtFbDNCdExoY2xFR0ptQVE2amZxRllNTlVK?=
 =?utf-8?B?c3hsSXpRUzh3di81d0pBYStVMmRmVmsycTM0TTZmR2xWelJnK0FKZjlKeXE3?=
 =?utf-8?B?UURySTZZY2NkalM5QktEWUIwUjdBL0hoTzBsU1loVDhrWm85ZDFDNlJCUkxJ?=
 =?utf-8?B?QVNvbEZKWWNOWlNENHR6a2p0U3VEeXZUNkFhV0czQW9vMGRnejkvOWVnK2hU?=
 =?utf-8?B?L09QamVCUHoyK3IrYndqbDMrUjJPcmVNczFrZmJ6bm13RW1wdTBMRE9tYkNQ?=
 =?utf-8?B?OFlxdXNKN0N0d0JOWlJ5TUtjUWdYR2xvSlZMZlRRNVpkRG1ORDR1NzgwaEQy?=
 =?utf-8?B?b0cyN3g4VGZuM29hUWl4WDRzYnEyWnRrS3ZQOVY2WElaQzBCMWI5WTcwdWdm?=
 =?utf-8?B?SGZlUkFuUmZBQWxWclJpM0VxNVlCWGlvWUorVzV1N0JCVFlLcEl1Q0x0RGI3?=
 =?utf-8?B?UXpmMGVMdjNpWEhtNVJ5alViTk9pNmFsQzdUd3YySmdSbk1mL2ZMMFR2ekNs?=
 =?utf-8?B?VVZ0YXlDM1N0V2swQnFKWW03ZUhGbmkzUm8zaDBFaHJrSzlYUVArNFgxbThs?=
 =?utf-8?B?OFlKN1BaR1l4NGZadkg4dzVxZHpQTlYxSGRYaERYSCtxS011RmV4MURPUjBJ?=
 =?utf-8?B?eWhrdjAwZ3lmcHVJOTdybUZodEtxZmo1czZSczFINGtoZ0thMEdpN0IxYUxG?=
 =?utf-8?B?L0xsVDQ4RWNXUDB5cnVmWldCNWkvaWdROTNXWUIvRjRKZjVEVFdWc3Z6ZzBk?=
 =?utf-8?B?T29jRnJxVHVua0hITHBYendzdTkxaVdsSEhzL1VQU1ZNY1hXczlhV09qOXZZ?=
 =?utf-8?B?UkZCajNhY2lrc29vTWJ5QTNCMUF0cE4yTlhUZ0N0ZncvZUFOQzM1MHBBdG5F?=
 =?utf-8?B?blM0cWVyNCtUOWpkd2ZZdmZJZzJDNndCb3BBa1JLakl0UXBzNWdaSkZCZ3FL?=
 =?utf-8?B?aCtrcWVpMGk4SitTTVdNaEhHRnkrQkw4SzFNb2FqQnQxRUkrVG5FdkU3ZEp0?=
 =?utf-8?B?K2VQR0R1dFhCUTNHSndrRzIrbi9tMVhCSDhPV1RvVnNpTzRWM0pWQVBnWEpQ?=
 =?utf-8?B?anhZTFdyMmJXeFQ3V0t4RWllRFlUVkpOM0hBcjNEdDVwSHpUaDdtWENQWTBQ?=
 =?utf-8?B?ejdwOVNKQVZoVWxUNzlFOEZtaTdvV3dERloxbFZwdktrRUkzYXByK0FqQTZu?=
 =?utf-8?B?MkkyUVdUaFBzazJpR1FuWVI0N056bEdpNitITStaRFVyQlVXMjBXTFdra1pm?=
 =?utf-8?B?K1FGNFFPZm9sZG9pNFROQmU0dEI2OE04YldIZ01laVZpUGlxbXFzeGJRVTBt?=
 =?utf-8?B?L0NpT28wU0l0S1NoQnhLaFJNQnp5aWJxV3VaaVBWS0wxeUYweVdGMmN2aDVK?=
 =?utf-8?B?MU4vS1V5aFh4SXVpQXMzWmJjTmdQTGxuSk1tcERqRFpYUHFPNkJ3R3o2MzVF?=
 =?utf-8?Q?LfATRNdrz3vDMp+8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6a5061-acd5-4bba-d6f3-08dee3643fe8
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 18:01:24.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMxt0F43M3F9NpfujX/1YubvWOqShlPA7iXjgJfH0RIj3S+zj19ees8MXTMbGcfebwKKcfioPN0NZIB64MSR+ji7C+I9DIJfb9L7ft8cPJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8498

On 7/16/26 7:13 PM, Stefano Garzarella wrote:
> On Thu, Jul 16, 2026 at 06:39:48PM +0300, Andrey Drobyshev wrote:
>> On 7/16/26 11:57 AM, Stefano Garzarella wrote:
>>> On Tue, Jul 14, 2026 at 06:16:37PM +0300, Andrey Drobyshev wrote:
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
>>>> Close this the way vhost_worker_killed() already does: clear the
>>>> vq->worker pointers, wait for a grace period, run whatever the last
>>>> readers may have queued, and only then free the workers.  The
>>>> synchronize_rcu() is skipped if the device has no workers, so cleanup of
>>>> devices which never got an owner stays cheap.
>>>>
>>>
>>> Do we need a Fixes tag for this?
>>>
>>
>> I'm guessing it should be:
>>
>> Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>>
>>> Thanks for pointing out that the issue wasn't occurring, but I think we
>>> should add it because it's a sneaky problem we discovered by chance.
>>> IMO the code should already have `synchronize_rcu()` after
>>> `rcu_assign_pointer()` loop.
>>>
>>> @Michael, what do you think?
>>>
>>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>> ---
>>>> drivers/vhost/vhost.c | 15 +++++++++++++++
>>>> 1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>>>> index 4c525b3e16ea..0d1414d40f4e 100644
>>>> --- a/drivers/vhost/vhost.c
>>>> +++ b/drivers/vhost/vhost.c
>>>> @@ -729,6 +729,21 @@ static void vhost_workers_free(struct vhost_dev *dev)
>>>>
>>>> 	for (i = 0; i < dev->nvqs; i++)
>>>> 		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
>>>> +
>>>> +	/*
>>>> +	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
>>>> +	 * caller that fetched a worker before we cleared the pointers above
>>>> +	 * may still be about to queue work on it.  Wait for those RCU readers
>>>> +	 * to finish before freeing the worker, then run whatever they queued
>>>> +	 * so nothing is left with VHOST_WORK_QUEUED set.  Mirrors
>>>> +	 * vhost_worker_killed().
>>>> +	 */
>>>> +	if (!xa_empty(&dev->worker_xa)) {
>>>> +		synchronize_rcu();
>>>> +		xa_for_each(&dev->worker_xa, i, worker)
>>>> +			vhost_run_work_list(worker);
>>>> +	}
>>>> +
>>>
>>> Following sashiko review [1], I tried to undersand why we need this, but
>>> TBH I'm really confused. That said, this seems wrong also because it
>>> will work only with vhost_tasks, and not with kthreads.
>>>
>>> IIUC vhost_worker_killed() will be called anyway when calling
>>> vhost_worker_destroy(). For vhost_tasks, it will call
>>> vhost_task_do_stop() that calls vhost_task_stop(). This sets
>>> VHOST_TASK_FLAGS_STOP and wait the worker on vtsk->exited before freeing
>>> stuff. The worker breaks the loop and calls vtsk->handle_sigkill() that
>>> is exactly vhost_worker_killed() you mentioned we are mirroring here.
>>>
>>
>> Hmm, are we sure it's the case for our codepath?  Looking at the
>> vhost_task loop function:
>>
>>> static int vhost_task_fn(void *data)
>>> {
>>>     for (;;) {
>>>         if (signal_pending(current)) {
>>>             if (get_signal(&ksig))
>>>                 break;
>>>         }
>>>         ...
>>>         if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
>>>             __set_current_state(TASK_RUNNING);
>>>             break;
>>>         }
>>>         did_work = vtsk->fn(vtsk->data);
>>>         ...
>>>     }
>>>
>>>     ...
>>>
>>>     if (!test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
>>>         set_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags);
>>>         vtsk->handle_sigkill(vtsk->data);
>>>     }
>>>     ...
>>> }
>>
>> AFAICT, we exit the loop in 2 cases: signal delivery or STOP bit
>> setting.  Like you said, STOP is set by vhost_task_stop.  E.g. for our
>> RESET_OWNER case:
>>
>> vhost_vsock_reset_owner()
>>  vhost_dev_reset_owner()
>>    vhost_dev_cleanup()
>>      vhost_workers_free()
>>        vhost_worker_destroy()
>>          vhost_task_stop()  // for vhost_task_ops backend
>>            set_bit(VHOST_TASK_FLAGS_STOP)
>>
>> So, first of all, actual work by .fn() callback is done after the exit
>> checks, therefore we skip it - no chance to drain there.
>>
>> Secondly, the handle_sigkill() callback is deliberately NOT called in
>> the STOP case and only called on fatal signal delivery.  And for
>> vhost_task backend the .handle_sigkill() callback is exactly
>> vhost_worker_killed().
>>
>> So my understanding is: if we only call synchronize_rcu() here and leave
>> this path undrained, then whatever work which was put by send_pkt() for
>> the worker currently being freed - will be lost.  Please correct me if
>> I'm wrong.
> 
> Yep, your right. But what will be the issue of loosing them?
> 
> IIUC we are not loosing any data, just avoiding some works that will be 
> handled later when/if will set a new owner.
>

But will it actually be handled?

vhost_transport_send_pkt()  // called on every packet send
  virtio_vsock_skb_queue_tail(&send_pkt_queue, skb) // add skb to list
  vhost_vq_work_queue(&send_pkt_work) // try to arm the work
    vhost_worker_queue()
      if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
        llist_add(&worker->work_list)
      }

So send_pkt_queue is a list of skbs, it lives on the vhost_vsock device
state, and survives RESET_OWNER.  In that sense you're probably right
that we aren't loosing any data.

There's also send_pkt_work object, also living on the vhost_vsock device
state.  So we're accumulating skbs, and then send_pkg_work gets put in
the worker task list - but only if it's NOT already armed in there, i.e.
QUEUED bit is unset.  And the bit gets cleared by the workload callback
- for vhost_task backend it's vhost_run_work_list().

The most important thing is WHERE this piece of work is being put.  That
is worker->work_list - this list does not survive RESET_OWNER, as we
free the worker in vhost_workers_free().

Now imagine we have RESET_OWNER racing with send_pkt.  In
vhost_workers_free() we acquire ptr to a worker but not NULL'ify it yet.
 Then on the send_pkt path we arm the send_pkt_work, set the QUEUED bit,
and place it on the work_list of a DYING worker.  Then the worker gets
freed.  Now we have send_pkt_work (a singleton struct) with QUEUED set
in its flags, and with no worker to walk through this piece of work and
clear this flag.  As a result - send_pkt_work can't be placed in the
list of any other worker, because it doesn't pass the "if
(!test_and_set_bit(QUEUED)" check.  Thus no new packets can be
processed, and the connection is stalled.

Does this make sense?
>>
>> That said, I agree that vhost_run_work_list() will only work with
>> vhost_task backend, not with kthreads backend.  If we do
>> vhost_worker_flush() instead - I guess it'll keep the drain here, yet
>> become backend-agnostic. I.e.:
>>
>>> +       if (!xa_empty(&dev->worker_xa)) {
>>> +               synchronize_rcu();
>>> +               xa_for_each(&dev->worker_xa, i, worker)
>>> +                       vhost_worker_flush(worker);
>>> +       }
>>
>> With the last 2 lines being equivalent to just calling
>> vhost_dev_flush(dev).  And once we become backend-agnostic here, I'm
>> guessing the warning reported by Sashiko should be dealt with as well.
> 
> I'd avoid `if !xa_empty(&dev->worker_xa)` at all, and call 
> synchronize_rcu() in any case.
>

Agreed.

> About vhost_dev_flush(), we are calling it in several places, and maybe 
> we should re-check them. E.g. we call in vhost_vsock_flush(), but it's 
> also called by vhost_dev_stop(), maybe we can avoid to call 
> vhost_vsock_flush() if we call vhost_dev_stop().
> 
> I'm not sure we really need another one here, but if you think some 
> other works can be queued between the vhost_dev_stop() and the 
> synchronize_rcu() we are adding here, then okay, it may have sense.
>

Note that in our particular case we're gonna do:

vhost_workers_free()
  vhost_dev_flush()  // the flush we're planning to add
  xa_for_each(&dev->worker_xa, i, worker)
    vhost_worker_destroy(dev, worker)
  xa_destroy(&dev->worker_xa)

So we walk through the XArray, destroy workers in it one by one, then
destroy the XArray itself.  Then the next time we call
vhost_dev_flush(), e.g. from vhost_dev_stop() or wherever else, it tries
iterating over the XArray which no longer exists - which is gonna be a
no-op.

Now, we can reach vhost_workers_free() via (at least) 2 paths:
RESET_OWNER and device release path.  On the former the flush is needed
as I illustrated above.  On the latter it's indeed redundant but is
cheap as it's a no-op.

Andrey
> Thanks,
> Stefano
> 

