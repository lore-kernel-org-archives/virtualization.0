Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020118.outbound.protection.outlook.com [52.101.69.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2333101A0
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216397; cv=fail; b=gat7xkrfCdTgAmhXvXsYXzWdnEVxl/oLYfxqv7n2GqIIMGl/5hMYww9p2GG95ARiVWMNPIHR8Vowe0Qsn2r2Or4qrj24fjYgZp3V0S8YIZXHx/eER+prO1hjIk4wqpuWV4qV58SLxcSAr9znZSCdYhbRP3tkPF0oopySQ70mC4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216397; c=relaxed/simple;
	bh=JWx2quMd/HEG5y4gIm9TU6a1zmHcOb8hNoCk82dFNpE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aaGHTx/cOq/Mwh2PgkOPDjQZshqJK+EW6mkbg7Auc4ltAABjhhs6O0so321CGf640GSzTlIiG+rOm1P/WD8dalqTYN7g0j2jlsG+qasmx5YWnholPjpwddvmoCGju75bsImxrb0NLYEXQP73qt+AsyvSktu+8tC4Aqmg/HHh3h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=O7rQks+F; arc=fail smtp.client-ip=52.101.69.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="O7rQks+F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6ByxqRTXRWbF4vx3qSoqMR5j47cCPWak0WvhYwHd5rDi8fjA8zLxp3bylNAlbFn/Ilr6DGSBR9xCUh/GxidJXTihhLbm/NsdH7fWZy01owAiFQLhalFki/orMiqXbe58XXKBs7BnrwQr8xGexNV3dYYa4M9uueJF4FRDv5cg6N8idonWWmhyQ0ox0fkVFeP4X+apMQYV+WoHZY/DooCftY1q5619X6eWERkbju0oXD2Ei8waSxuTSiAmzmOFx4p8yGZD1nvUxBNzkdkIkIVSRWzMAnPoPc3wuIpbLfu9kcjcxYg5awJxunQX4ij/QwIag/Tr7/8QfWiQIq10qA9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7MsonTAmiHKtK+k7ga7AWErWmbayxuuaHZRKhxOFxs=;
 b=ITth9ZEvTAqajRMUNw9mjIqOQtpBSPNecaxOdNTQ4AdHyl7TLbcBAQnaxf/QuGA7iJVike0wx8vToJgCLd3zgAeI9pTgJ8X7JAD5MiKavIXEWd3YlKfEgJRceAJeHPnXH8TMj/MwXy4H9a5o8JF+9gkCwT8KG+DkU2oi9LlKMO4YVVDTo+TgaEOBrqOh72e+8cn+cY4elNy2HMWKuflhRlGuAdp8/uftD7V8UhpdHcTHChcuxC1KrT9cRA0lNyaQR/tOoLXFmS3SYKtE/ef/K0DH1SznoH+RaTBp6i1D0rp2Kpo3OusDzM6hc+CEBMxvR5mKr6EgOAzAghGLC6m+Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7MsonTAmiHKtK+k7ga7AWErWmbayxuuaHZRKhxOFxs=;
 b=O7rQks+FL3KX3OrfJLecxYELXl6ViB9MPBKPFCFglkq9tPWe86o1TfjuQq3/7TIGjQ+SFm2vclcvtdkVktMbCwzLo4WD89p8MYg6ro7vxmoiqztbg3kNeWJt3WDKhP7nSz+yOJNqmNDazgpuNujXNUa9SjiYc89ZZQdRIdNIXT6JHJewu4EiFMJszLDmxpmFd5R8fwAI05PZq2ZW1asi4jA1JoY+T25wyz0P8KBwjAOxeLurSFl2x6WxObVKkzhAE9hNVSXdBUZkJ4vbmSjL5ZgpnSLi/4GfSe2t8oaRMdjvX6UbyoodAfcMvf2JFNcuR/CG3gGLztqldE66BsuyeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB5927.eurprd08.prod.outlook.com
 (2603:10a6:20b:292::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 15:39:50 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 15:39:49 +0000
Message-ID: <2f680236-f4c1-418b-8401-4dea1230caf0@virtuozzo.com>
Date: Thu, 16 Jul 2026 18:39:48 +0300
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
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <alibLtcrC7o5r4Dh@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::11) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f23bbd3-2376-4778-7377-08dee35078cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|10067099003|4143699003|22082099003|56012099006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info:
	yLTSU1r1F4jHjf6/aZ9D6jAvEJqkbhc0dr5MqscSctgoeEaOPHX50aHEEAf6pvlOSm1oGnH1o5UAOl5BviVs6Up4rF90ifgPRDrmoJXm4mSznJrbQgLU9rRVQh+LBx6HVlMApkEC3x10igNKFeHvkWJVWZ4qMM198JZcI+NZOu7Iir5TRW0Jy7GDvgSRizVIhWFqWe3p1nDQg3jWwWYOHRvji2qA5ktVjtzb1W+vozApu/66iY9J574zES+QIKJ4oDzdCmaCv5DSAcDtWt2cynCv/paF+4d+yjYqObWH5YoJPPGKoeo4Puc0VTZmyguTVfK6RmdyrTypka8+aDSSwulAsH/Xxc61l3S76exLqg3ctJ1Lzr5mqk0AIngaDk1XwTr6DOLJAeHGykPHI/cwDVRhaZUvpnGmovN8o9CGTYliNlC77htzyTz6k/asw2kupRLjx2kX5dMsfB8ElumEwvUqN68D40VYSSZKO56v40/UaAWeUcH9uatmA5Qbpun92C4xA/qcZPVLghVuy96vVdpIKyek6y/lCN3kQzB+vk8QdCJmP6m/KE9cfRV2G8ZBy6c85AJkHOT3Jo1wk5tlGyxt9SJZKY5gVOQextJrnh4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(4143699003)(22082099003)(56012099006)(5023799004)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3R6emJsYTZwMUxBaHpGbEQ3QVRINEJRRElWbEdMNzFuVXJha251SEFsTFh5?=
 =?utf-8?B?VG1pT0MvSzc2WWhvamxTb25ScFBrbUxVcHM0aStjREFjWWFZQzY1ZFljdFAw?=
 =?utf-8?B?czNPL3N3eFNIcXpVcUhZd0NqV0NXdDRWMTlkYmRZUDFrZjRQK2h4Qk42c3Fk?=
 =?utf-8?B?bmNqdEtTdk5oSXdKRHRMRUJldUVURW5JNURoQkd4ck1LWnN4ZEpUbS9aY1Iz?=
 =?utf-8?B?dmt5TnBKelhkZ0REL0MzUFBQN3ZDRHBVaTBDcFIxR2p5WlBZUEJiVktQR1FU?=
 =?utf-8?B?bGtVSnBvWnhEL3RxL0ZhdTNFdlkzL0xJV2UvUDFIbnVXOHdzbDdaNjJ3alBC?=
 =?utf-8?B?ZWtlWVMxOHdpTjBGNWdCZlhBdUd1aTlpcGVyYkRZQ084Y29qMnd3Y1c3SGND?=
 =?utf-8?B?aXJ0bTlXTGZEdUdSaWZ2VmtjMExueW5MK25TcVEybFJmOEhXamM3a21QMWg3?=
 =?utf-8?B?UCswa0lZKzlZQVUrMnNEWVJVeVFpeWc0Z01TRHNzT1JCTndUZGVWa2FKa29q?=
 =?utf-8?B?anRwSlNpSUNmdTdzbTZncmZMSUNyblZOK2pmZmhDM29nMWlDVWI4eVFQRW84?=
 =?utf-8?B?VjB6K1FLSUtaNTlxV0lQbmpCaVpHSlJiT0I0aFV2MUxUQVUxZ3VpZzRNQkc4?=
 =?utf-8?B?cjRQU1RUNGhnVDRWSkR4WkRvZnFvRU9xYnE1dEdNZ0lHR1BMUkF1TDlvS3lz?=
 =?utf-8?B?VU80MTVLcXVDUk00dytpNENBbmd1cVlKZnZrNEREdWhGc3pnY3FwMmpsNEhE?=
 =?utf-8?B?cDZKUUMyZGtTNGVPSjBzQ1JaSHBpWU1sNCtwTnRTYnRuZ0kwRGFyanEwTisx?=
 =?utf-8?B?WlA3TklYZE81djRXOVBVQjEyN0xucVpSTG84MnI4NWxyMVk5Rm12UU1WTmZI?=
 =?utf-8?B?V2lLNjk1L0FOUW5YYUtwR2hqLzh0cUFYd0ZIYWRmRWE5VDY5VHZSTldTSTRj?=
 =?utf-8?B?dEp5UzJ6Sm56Nm5tS0t0OGw3VTJFTUlLdklSZVNMN2ZIQTRyclRTeVhTZkhu?=
 =?utf-8?B?L2t2bWxlcWp0cjRBNk9lMGgrTmJBMGF3eE5MTU1RRDBWOTYwK0t0V2IxZXc0?=
 =?utf-8?B?MlBZa2NHZUVEUytwYXVnUUhUTG1kaE5LQmZjM0Fqc215dGZaUDM4OUIrcURJ?=
 =?utf-8?B?YW5vUVpBendOc3dYdTZhOTlpZXpVcGNmYlF0b1UxMUZNV2RVcFNIWHZDcFNP?=
 =?utf-8?B?L2hnbXBSaE5LQXoySlNpRHJjK1ZGVW0xQVJDRnNoVFZEU1RGVDVRVE1UOXBB?=
 =?utf-8?B?TnF2N1k5b0FiU2JrR3hyUEc5WVNMZHBadjZwMXNyT3dEcExmYTA5MWFYeExw?=
 =?utf-8?B?T2xKYTdHb3hYKzFyNlNnb1dJY04yVkw4NE5INmdBR2w3UmdNS1Yydi9sM0xV?=
 =?utf-8?B?SEdhMUdCK1BGeHFma0ZWL3FlcWJsNkF3N1BJMXJ5ZkkrYytJNVd3bWl5alhQ?=
 =?utf-8?B?YkNudFBvSzMrT3dtVjUxWi91OEdTQlI2YVJPOUd0VnNSNGRnaEpkSFkzYnlE?=
 =?utf-8?B?NGlyZ2R5VUdpekI0SHpOcWR2TUdBd1I0dmdDeGRLbGgwcGtSSDFSWTBBZWlk?=
 =?utf-8?B?eEhGZVRoWjliOUxIWTl3Z00vVENLTndkR3J0eTR1SnlteUxadjRFTzJqMXVJ?=
 =?utf-8?B?QmVkNkptQlNmV1dxU09ZTnVwR2Q3VlU2TW1BcHI4NjhWcmhvZGFCNWwvR0I3?=
 =?utf-8?B?c0xqYzFwYWRwdVdZYUFxNWVFNWlLMnlXOUIzejdUb0hwK0xQMjZhZzY1T3Ba?=
 =?utf-8?B?ek90a0tkc0lqTmlMU2toUHlFSWl1ZUtWSVp2K1lvRzZBWTM3Y2JRK3Zzamdl?=
 =?utf-8?B?MGF1aEprNEhZS3hiNTFqdk0yYWtUcUJuZ0FQMXNzNW9BWkg4RWlXZ2w1UlR0?=
 =?utf-8?B?OGpLQ081YTgvVFcvN1hOaUNPVVZqcGlUUm5CcithMnhnRTd2K0VrajZvUGFH?=
 =?utf-8?B?TCtabng5UHpka3B6MzRYM3lXNEVjNk5Eb0owRWZJTHNkL3RrZlBoQ1N4Z1FB?=
 =?utf-8?B?MmRXRzFDK2dSTGl6TENmZGk4NHd3aFNIN3lmRGFpdEJpbmRKd21Rdnp3ZVlV?=
 =?utf-8?B?TVcxZWlUdWtnTzMrYXAwTXlWeVpRRDhOb3drZkNkRkkyamExK2REaWJLWUw3?=
 =?utf-8?B?ZUVBTkI2dVdCblFWcVh4cG5WeUlOd1B3SkdJcklaNkFhTGZSV3ZWZTdjSERG?=
 =?utf-8?B?WGZaL1Z4ZUd2c2FSdEh3OHdDYzRBZ29UZUJ5WC9VNzliZDJuY09YQUtoWGpS?=
 =?utf-8?B?VTVVYjB6VmlIdEdjZEZqQzVwcXdKMkY3OTUrbXFEUCt6NnJKTy85NlVBdW1r?=
 =?utf-8?B?YXhqR0ppN2tPY213VGVscFVWdG1xb2l6UDZBbGIyNm1BOHFjMFgyN3doNjZC?=
 =?utf-8?Q?rRjDQQYErITObIxU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f23bbd3-2376-4778-7377-08dee35078cd
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 15:39:49.8097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ueQFx40CHHZod7G0vwjlGvQ1ja0FFi2b1+G+1XlbRUu8Fn8YLpljmkrcg8wyjN+wAk2g0t3ImMy8n65KWGfedaqWnDJWJ22u6nrPFRXCaZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5927

On 7/16/26 11:57 AM, Stefano Garzarella wrote:
> On Tue, Jul 14, 2026 at 06:16:37PM +0300, Andrey Drobyshev wrote:
>> vhost_vq_work_queue() only holds the RCU read lock while it dereferences
>> vq->worker and queues work on it.  vhost_workers_free() however clears
>> the vq->worker pointers and immediately frees the workers, without
>> waiting for a grace period.  A caller that fetched the worker right
>> before the pointer was cleared can therefore still be queueing work on
>> it while it is freed.  And even when the queueing itself wins the race,
>> the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
>> future attempts to queue it are silently skipped.
>>
>> None of the current callers can actually hit this: net and scsi stop
>> their virtqueues before the workers are freed, and vsock unhashes the
>> device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
>> before the workers go away.  But the upcoming VHOST_RESET_OWNER support
>> in vhost-vsock keeps the device hashed while its workers are freed, so
>> the lockless send/cancel paths become able to race with the teardown.
>>
>> Close this the way vhost_worker_killed() already does: clear the
>> vq->worker pointers, wait for a grace period, run whatever the last
>> readers may have queued, and only then free the workers.  The
>> synchronize_rcu() is skipped if the device has no workers, so cleanup of
>> devices which never got an owner stays cheap.
>>
> 
> Do we need a Fixes tag for this?
>

I'm guessing it should be:

Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")

> Thanks for pointing out that the issue wasn't occurring, but I think we 
> should add it because it's a sneaky problem we discovered by chance.
> IMO the code should already have `synchronize_rcu()` after 
> `rcu_assign_pointer()` loop.
> 
> @Michael, what do you think?
> 
>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> drivers/vhost/vhost.c | 15 +++++++++++++++
>> 1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 4c525b3e16ea..0d1414d40f4e 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -729,6 +729,21 @@ static void vhost_workers_free(struct vhost_dev *dev)
>>
>> 	for (i = 0; i < dev->nvqs; i++)
>> 		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
>> +
>> +	/*
>> +	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
>> +	 * caller that fetched a worker before we cleared the pointers above
>> +	 * may still be about to queue work on it.  Wait for those RCU readers
>> +	 * to finish before freeing the worker, then run whatever they queued
>> +	 * so nothing is left with VHOST_WORK_QUEUED set.  Mirrors
>> +	 * vhost_worker_killed().
>> +	 */
>> +	if (!xa_empty(&dev->worker_xa)) {
>> +		synchronize_rcu();
>> +		xa_for_each(&dev->worker_xa, i, worker)
>> +			vhost_run_work_list(worker);
>> +	}
>> +
> 
> Following sashiko review [1], I tried to undersand why we need this, but 
> TBH I'm really confused. That said, this seems wrong also because it 
> will work only with vhost_tasks, and not with kthreads.
> 
> IIUC vhost_worker_killed() will be called anyway when calling 
> vhost_worker_destroy(). For vhost_tasks, it will call 
> vhost_task_do_stop() that calls vhost_task_stop(). This sets 
> VHOST_TASK_FLAGS_STOP and wait the worker on vtsk->exited before freeing 
> stuff. The worker breaks the loop and calls vtsk->handle_sigkill() that 
> is exactly vhost_worker_killed() you mentioned we are mirroring here.
>

Hmm, are we sure it's the case for our codepath?  Looking at the
vhost_task loop function:

> static int vhost_task_fn(void *data)                                            
> {
>     for (;;) {                                                                                                                                                   
>         if (signal_pending(current)) {
>             if (get_signal(&ksig))                                                 
>                 break;                                                          
>         }                                                                       
>         ...
>         if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
>             __set_current_state(TASK_RUNNING);
>             break;
>         }                                                                          
>         did_work = vtsk->fn(vtsk->data);                                           
>         ...
>     }
>                                                                                 
>     ...
>
>     if (!test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {                       
>         set_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags);                         
>         vtsk->handle_sigkill(vtsk->data);                                       
>     }                                                                           
>     ...                                                                
> } 

AFAICT, we exit the loop in 2 cases: signal delivery or STOP bit
setting.  Like you said, STOP is set by vhost_task_stop.  E.g. for our
RESET_OWNER case:

vhost_vsock_reset_owner()
  vhost_dev_reset_owner()
    vhost_dev_cleanup()
      vhost_workers_free()
        vhost_worker_destroy()
          vhost_task_stop()  // for vhost_task_ops backend
            set_bit(VHOST_TASK_FLAGS_STOP)

So, first of all, actual work by .fn() callback is done after the exit
checks, therefore we skip it - no chance to drain there.

Secondly, the handle_sigkill() callback is deliberately NOT called in
the STOP case and only called on fatal signal delivery.  And for
vhost_task backend the .handle_sigkill() callback is exactly
vhost_worker_killed().

So my understanding is: if we only call synchronize_rcu() here and leave
this path undrained, then whatever work which was put by send_pkt() for
the worker currently being freed - will be lost.  Please correct me if
I'm wrong.

That said, I agree that vhost_run_work_list() will only work with
vhost_task backend, not with kthreads backend.  If we do
vhost_worker_flush() instead - I guess it'll keep the drain here, yet
become backend-agnostic. I.e.:

> +       if (!xa_empty(&dev->worker_xa)) {
> +               synchronize_rcu();
> +               xa_for_each(&dev->worker_xa, i, worker)
> +                       vhost_worker_flush(worker);
> +       }

With the last 2 lines being equivalent to just calling
vhost_dev_flush(dev).  And once we become backend-agnostic here, I'm
guessing the warning reported by Sashiko should be dealt with as well.

WDYT?

Andrey


> So, why we need this?
> 
> Should be enough to call synchronize_rcu() in any case after the 
> rcu_assign_pointer() loop?
> 
> Thanks,
> Stefano
>
> [1] 
> https://sashiko.dev/#/patchset/20260714151638.143019-1-andrey.drobyshev@virtuozzo.com?part=4
> 

