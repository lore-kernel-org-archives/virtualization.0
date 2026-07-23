Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021081.outbound.protection.outlook.com [52.101.65.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AFB381EAE
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825225; cv=fail; b=X9yVzOlJXI974xNUTtxIsSzwUsSmNt2lyMOUImJpJF+FdhZkFZrCcG+oC0+8huvsppTM551ORxuFWw+Z+QlYMu14ZqnBQiXEzTGyi++QcS6C4OyEZBbRIVbTspDpiy5wG0Yt/wAMdmYdZ0bvzgOz7nnmyst+OnmhL6/H0bSFT10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825225; c=relaxed/simple;
	bh=OwtE/9hYnBTN/CtLwgweSg0Es70axx1zZSGCKTG30c8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jJXR3UhruuJdBHIzbBYZ9ksS/7iQ3JV+9/JB/gaS75ekPzahIKEWWc/ZpamPfBeOgmAmDoR324TsKWpINhdEGU76QonpIHh5tjsyYQjZkA/IiY3p/4EM87to4iVbX1rPX5+fQAUEOfqqm+mu5oGrE2HiSMgNElrAZk72g9hOGEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=sGHShB1C; arc=fail smtp.client-ip=52.101.65.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sGHShB1C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkUEGCs6yXjbhq07uleTkYf2kg3ZsPOCzPuGgNUw56AAC1xSPIOhIu0wY9djnvrlrbNiRRdZv1vNiZcxnorxAqppBTJVYygLpH2+HuOolks9gkyGpeBQZJ6aaOr9xfHtK7t7gKMdC2lc5zQCGXk0PrMB3Ob/uPu5KOG5Ha8IhcmCxCtatwaqSxjpkn1YTvBK01j6cLvxuIZUqH9emFzdWsBoZBPjAvNMsaVczwf5fLOUc431bBxJQpf1D7+GcbK7bs7cfPiKyLumDIgq7J1gEgWLNa2twaH+nkWIsmm1MlROM/inEaO5ktc0C04E/sqimWtTgq0hLTZUGgE/VoINFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ob+sXT3/dlSYBgiFKctNNNLfbnA4bi6cH6YspPslFHw=;
 b=ZAQjFQq0x1fL/0Q07ji7KJ9KwmIdTB0uGHZ7NnoBzUpbXSwwKsGf1uG38OSMxXMBpU+6seozIIWaGyrTVZkLue+qljhAs4lJCgl6BDH1NYZ7Gaf0/L4hQRR7LTNzmDBfFBc9e+XInlT0imz/tiFD//XvdGgFFy8j6NbRi1qPHRRQWHMgU2Esr0Kdwi1V7upjmastOelKiCze5jO10et0Nb/aCjr0CiO/32QUdyKr8MNB+ZKu2AS8jWek9MyGB+oI5v3WeEVrswq0BS84YWwbvlhv6kk6XGedPHrbWLo3lM+S36YfXQaJ6oNLT8mgX30YxjNAEzgCmyTQtca83qH3+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ob+sXT3/dlSYBgiFKctNNNLfbnA4bi6cH6YspPslFHw=;
 b=sGHShB1CNnwfc03TopRz5PoBouwAGnHIc+4S9VVj7YdV8jMHg8AUSDlQsixKLttveuRVhqYfvhvvufw8LHUyTIkccu63B1fDsxg+knfTUgDF7YsdYNQixiNTNlV5ujNdJTDUnSQ+uJ55TNdKntJ4eDqwn8SfQlrmZHy4IFyrTuNALh2V1/WQgBaPc2G6cJNP4DXX3Af/VTc70WjS9b+oxLLcgQbMj9wPY4uYbWEeCGbwV7uzg3U/Vf1WrGZQMYZ640V4j3PykrEtEoFpm/kNFc2dzQxOfa7J2v7JKAOyt78NI8CLSigcWWG8C06CHM4KCA65tow8bWiBp5fzDVt+uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB9533.eurprd08.prod.outlook.com
 (2603:10a6:10:44f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 16:47:00 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 16:47:00 +0000
Message-ID: <0c7172c4-0dc4-4d7e-9310-4f045e27efb9@virtuozzo.com>
Date: Thu, 23 Jul 2026 19:46:58 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, sgarzare@redhat.com,
 stefanha@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, ptikhomirov@virtuozzo.com,
 den@openvz.org
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
 <20260723111557-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260723111557-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0088.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::21) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b881a5-b396-48af-146d-08dee8da0406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|22082099003|18002099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	n4s3GH1fC4rPVQv+eKdtP8uQGoTRHHtuYc4ZyFbBsEdBZMDlelHgKvJwiLvJyg0GxV9PQaDFZ5vDjww/ar2NCCMIbiNprIEhGH1SRLD5l7fPmHVPbtu0y9ukdiuzkaLkABoAN/njsAkpVioGU0KOxNq6V271OcdnJPmBZLUQOtHEy12rgEpFu+XO1jDs4xW78E8tYoAjeTjQOyNIh6vsn3gX71pMgh12KBVZwUGKWQwac3D4QoG8sk4QlLoqqRwIjj5KV8y/iIrH9VtmSKLWaZuhJmKh+qwaN/F8E+XTNnE4TK69t5j9iNrityimumDwBjZ+YR76diQQboIy/qt5R+8zLcFsV94xYW+vpA40Ji+iYDO6zlIztxmhTK8OnlT/bLJ0+wZ+WQiv0Haz0JA493B5w8dn8q4JfsnntqptVVN+Tn0tyW3CVc9i1rVIs+ul/i0LGTinbADS5gc3iKjW0DuWmDz9eE85UP4ae+6Pu9ECv4bJEccAYMKq0sNDeqz9353CBejVJSbAxi6ep33QTI/1sWYFtzcTwxxVJrW5OBsjsxxeZHrM/KOJfmnG8eLh1uLDwm3aDQcBSbJKnYs/QkTMZtb9d4H5QF9ozn+1R7gJ+3wf6/MG5nFyrWPcmJ+p6thzfLzwQg/eCnRB5o1fcBCkxMZpxHlB2YKdm6BAthE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEdxQzBQeTcxazhKQmhPS21yYmN2MlJmZFVHQ1crK005dS9yQXZaNGU4eitw?=
 =?utf-8?B?NWZNUUVrSmV3R2Z5ajhIQ0Ridk1FRkFIUXJHUmFYcXpWZUJjSWhEK0d0VWFN?=
 =?utf-8?B?TEorYWVLdzJmWXljQWFqWWhSdE9VaUF5VkpqV0hEYTVabmxTczdLWG41eVl3?=
 =?utf-8?B?MldqbVVIbTJiTTBPNnluYzlhVG1UbW4wUHVOOUZxZDRFNXpWbTRPbTlTR0dT?=
 =?utf-8?B?Rk1ITkcxZUQ5bVRjM3A0V2oraTdVeGF0UG1ocTJ6b2RiWTYwQ2VlaGpzTWlz?=
 =?utf-8?B?eTJkZVc0MUlML2Z2MXNoZ2dHNEY1QSt6TFJ4TUdLMUFiakFFTXBqUkVVN1Y3?=
 =?utf-8?B?WFJmelcvVVoxYXJvMk9mWlFVSVdrOGlDWW9HcE1telFMTjcyRDhJM29VMVpB?=
 =?utf-8?B?bHBYVnhDYXZlSTZsTW9YNStYOTA5STVwWGdIcHVaNlZEakU5dENiZVhMc0E4?=
 =?utf-8?B?U3dKN0R6dGl5R0lDL3hBamxJQlVBR2FQSkZPY1RHa285QzZ0bmZWbDhTMEM1?=
 =?utf-8?B?aGtsRGJDYUEva3oxK2JmQzQvZTQ2S2FMV0ZRRjlzNXlvMHBWTkhRMkpWZGFG?=
 =?utf-8?B?cHEvdUZueFBnRUtoNCtlZEFmUVFwMWlZaFFod3BXZmFFTUo5MXBWZnBsVmxJ?=
 =?utf-8?B?eDhsN0pOWkpyaDZBWkxsTWtiNnBFckhpOURrcCsvL0NwNnlHTjVKTVQ0eEZZ?=
 =?utf-8?B?YWVYSzNBY0tLMXdRUTNGdTZGYnpDMVp5NkRYTVZMTmFMZGxxRHZkc28ySzZ1?=
 =?utf-8?B?a3pJckVxR1NkU0kvSjM2MUlSVzBWaEN4YU9ZNVpFQzlvckthY0tlYTBrMjFm?=
 =?utf-8?B?TGJzcENacGs0WXBWViszZUU3d1FySXExUjlvZDNPR2gxbEU5bHhpRDdUcitP?=
 =?utf-8?B?S09XeiszZ3lZTDluYU1mUkcxL3A3QVVMWmRQdUlpSG4wRFdWcExrOWQ0T3cy?=
 =?utf-8?B?azlhL20yVlM0R1QwUWJHNEc1K1NUbityaXdOekhsNXBhczZSNFZlRFU4ZUlV?=
 =?utf-8?B?NkU3aXVpalZYZ0dOeGZXdTkySmRsQW5LNE9GL3VjaHdnM2Q4ZkFpcTVwaXkr?=
 =?utf-8?B?S1ZpdFU3Z3JBU24yMDhmWTBiRDI2cEJFNEhXamVaU0YzWThtKytDcjNaSlFU?=
 =?utf-8?B?TGRFY2ZnTDJzRTdGcFkvdU5MeVRua2lkSUlzWUhxbTM0dGxwUGdoNTRVYWtK?=
 =?utf-8?B?WFE0Z0Vnc2tzUlBjMm5GYXBLbk5aUnBtZHZ4eldTbTcyTHpGb3I1aHdvRURq?=
 =?utf-8?B?SXlPL2JLRGVPbk82c2RXV0VVUWlvcmFXWGl2RDh0S0M4R0tCL0gvMzAvNWhO?=
 =?utf-8?B?d3ZUbWlGc1Z3RlhhRHhzK2ZNelFlN3MvUERuaElJZEtlTWVvWUZSc0tSTnRk?=
 =?utf-8?B?akkrdlJuRk9mbnJZcXJoNWFtYmZKWER1SFkza1lOdmt3OTlVNTE4K1FTcEpB?=
 =?utf-8?B?SVprQW50NlBiaEpqS1crZ1ZLUXlxbDhIVjVqUHdrRlhkVFV6Ny9jRFo3UjFH?=
 =?utf-8?B?cERVOXdmUTgxSTJJbEg5OGlPYkVtT2JsWXdtNnp1bGNxVW04UmtQdlJzUTU2?=
 =?utf-8?B?SzNmVkV6ai9WZ3VPQndBeUZ2NlU4eDZQSTJKeHRCUWkxQXBRZkMxaG1xK3Yx?=
 =?utf-8?B?Z05ZOXNWejRRQWdWY3VUZHJnQ3pMbXZwbGhnMGk4WGFaOC9tci8yb1ZZcVlF?=
 =?utf-8?B?M2o0NGp3dE9kZE1hLzY5eThSRnBEOVBIdExiRm0vMURQVktTd2M5andXZTB6?=
 =?utf-8?B?bkd5b053TXRKaGhhNXZObTFmNHpaOGJWNWpIUGpVR2RvNkQrVzQvamhaS1V3?=
 =?utf-8?B?Y2JYQnBpS2Zsb1pNOTVIK0dGZWVsaWpaUm15eGlHSXI1bk9iR2cyWE03MEpE?=
 =?utf-8?B?N01KbEg5VjA3M1AxbGphby95QjFHajJncCtheURkc1VqRzJCZ004UFZqZkhn?=
 =?utf-8?B?ZGJ4WkN2Rnd1dkpGVVMwTC9tVzU4VjlrTDBXTm0za0JtK0JhSFpmVVZVZFli?=
 =?utf-8?B?cTZoNU5CYk82b0ErVDV6TnIrbkRLWlNLS2QrbWtwa3VwQy9xUUJRV01xb3Vt?=
 =?utf-8?B?dTFiZzhWczAzQnJRMytDZU1jMDRzS0QwaFp0YVVxUktmTE9YRWZ4YVFLaEJp?=
 =?utf-8?B?KzA1VzgzdjRtQ2VHTW9EVGxiVzRPZG9iNk9qUncwUnlnSENMSmNaWE5YN0h2?=
 =?utf-8?B?cmk1cjlIa0hoOHpyeG9GM1R5akEvMXI0TVc3YUlhbFVIYm94blpBR0FkL2VI?=
 =?utf-8?B?MENNZVFweFN1VUl6eWNxS0gzdXlMWTk1aFF4TWRiZURsUEpmVFBralFBcXR1?=
 =?utf-8?B?QklUcHVsenVpQWJNSFRoWUVkZnNEbTZLVXNMSlVyMWpFNXk1RmZjaUhTVzAy?=
 =?utf-8?Q?Q6LsfzL+WRtGNG94=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b881a5-b396-48af-146d-08dee8da0406
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 16:47:00.2831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxIe7rdnggWXEEYFCVufoFJJZTm1s/KcK5qQ14q5g2t63i0C33IcxcOEKy3HEn26g+lHF6B8AOza64AmmFeZ0jaPfN4UN1vDh9vMhatT5aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9533

On 7/23/26 6:18 PM, Michael S. Tsirkin wrote:
> On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
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
>> Fix this by clearing the vq->worker pointers, waiting for a grace
>> period, and then flushing the workers so any work the last readers
>> queued runs before the workers are freed.
> 
> 
> 
> 
>> Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>  drivers/vhost/vhost.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 4c525b3e16ea..d6e235c25254 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -729,6 +729,17 @@ static void vhost_workers_free(struct vhost_dev *dev)
>>  
>>  	for (i = 0; i < dev->nvqs; i++)
>>  		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
>> +
>> +	/*
>> +	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
>> +	 * reader that fetched a worker before we cleared the pointers above
>> +	 * may still be queueing work on it.  Wait for those readers to
>> +	 * finish, then flush so any work they queued runs (clearing
>> +	 * VHOST_WORK_QUEUED) before the workers are freed.
>> +	 */
>> +	synchronize_rcu();
> 
> 
> 
> Any way not to add this for all devices that don't need it?
> Or preferably, even for vsock in absense of the new ioctl?
>

This code was initially local to vsock, and was moved here in v3->v4
after we discussed with Stefano that the issue looks more generic and
should probably be fixed in vhost.c (see
https://lore.kernel.org/virtualization/akO6tps94iFxCAWv@sgarzare-redhat).

As a compromise, we can keep this code here, but only call it
conditionally.  Namely, create a bool flag on 'struct vhost_dev' which
is always false, only set it to true on RESET_OWNER, and only call this
code once it's set.  Clumsy, but this way no other code path would have
to wait the full grace period.

What are your thoughts on that?

Thanks,
Andrey
> 
>> +	vhost_dev_flush(dev);
>> +
>>  	/*
>>  	 * Free the default worker we created and cleanup workers userspace
>>  	 * created but couldn't clean up (it forgot or crashed).
>> -- 
>> 2.47.1
> 

