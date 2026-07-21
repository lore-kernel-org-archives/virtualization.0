Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010066.outbound.protection.outlook.com [52.101.193.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1BA46A60E
	for <virtualization@lists.linux.dev>; Tue, 21 Jul 2026 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662138; cv=fail; b=fA54/uAkVj+XIb2jhDnuCe3V7qVGL0bpnsavRi0kakz2/7wced3V6Ev9cKjJsT9pEvyrwrTXgWuwFdCRfRrJ4JmMVTT7m65S81nmXksWeZerel0aX+uPgu47ocRkRSXZVoqS6bv99suaXmfRWmR/UM/erEZ07QBLh7m8UHjuuNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662138; c=relaxed/simple;
	bh=gEoFNXpfd36WXfmZDDTjaBtRxF/2WqW6sMJXLmSAB20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FwbjXmn3sM2sxuT4W6RZ8456nqI19xMlGZ4TY+hyHnUi+IsgQGmMCF74PJithEqEdnZVaJ8bdeAuhvjEtycJK2cMTYPYdFcIWD/jO7MryidhuESvivBBW5C1e52gosHFNG9JIn2d5/XqIsaiaAsunFXBACgwIXw0wN16R3/1j6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pKm6zXUX; arc=fail smtp.client-ip=52.101.193.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pKm6zXUX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9LSFHWgXN+g6Lt0m+NLLn27luc5AaJcncbUVtMbZf9LMXAEZSi9eZVKPvnv9pgshLRX3hehXnO9uEVPMYXoeYI0b1gc+g8jTWErWz51jxPVlhkjRrYho8ZYfZs7l12PNotxnbciohVMlmGLRCmyBI9qv93+GSQuS39SlSoAjeGhvXOmQmkU5BFqK4V/ziPBVeo6aoL6Xj2raW0tOWVCQkBa00fL/T3UoQfXdzkPkvSihKhklgsoNXorwmzAJqphVL5rsXe0qnK1fS+t5UaGsE8WMdlmMWvDdXrrCubtO88eLXvUDYyGTgFlNyH2aOfQxI1cvP0MR/S+L6HJQUin8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipgKk8RIKawZ2CEzN9dVQfg8apSYevm42Bt7XwRw3iM=;
 b=VHQQg0zHvzQSMJdoYYTVsWpuP3jbTrGmNP2Mb+Ry5ew9mUPALuOkAnIck/X+MZ+EVV5MlKaZjU3UUZF+PORLBdNTb/Lt4i0v4mRo85wAtlT3h6JAHcfs40338tt3C5pHTlcDici8Z/AOZ5rlFA6Fa5gq3UANofh/0P3cmSxUL4j5JsEbvZo0On6UVF8S4OS5BIrqmMvweBijrQE06j8eeX7Lxh8688MLPbTb6w7vBNo/ykQcVUYUwrAhJ7leiRk9+b1ApaJWTR8Zz64JiB+nRMpwO5UMWI3Yb5WgtOnfcEaLbCmDJr1mdsTyP5Me6R2/q4Yp5iLJP89ixx2Lany7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipgKk8RIKawZ2CEzN9dVQfg8apSYevm42Bt7XwRw3iM=;
 b=pKm6zXUXEM2RV0E5q4UibXTp1FqmSOMFMn0Ge033hMCiyBAVv84HhFTgHRVY3vj0kujH7zKTXY3y8Qh0aL9e2VYMFQlqv3bFgCyCzMDF4UV4Set3K3eU6PGjtLeTrONJHuViZXHhmcSc4I9KqbVmcROOBYcrBAc06ztmBdsouM/eY7v0mZVctbsjQnQwHcu8PM4IQ4mc3r3f1o9TOEGEknWoFj5DSwA18JCJDxs1jh21hDt2GO8KQT6VQdGDJYQkK+yn4T7qwuwKn3nV5nT5m1OP4g1vXGz5tWvLLRPvV7CibZoLNH6AEZhR0pZSobCD3whaUWLCO4I0mUQvyca7zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) by
 IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Tue, 21 Jul 2026 19:28:49 +0000
Received: from DM3PR12MB9349.namprd12.prod.outlook.com
 ([fe80::7678:ab4c:4a7d:7f9f]) by DM3PR12MB9349.namprd12.prod.outlook.com
 ([fe80::7678:ab4c:4a7d:7f9f%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 19:28:49 +0000
Date: Tue, 21 Jul 2026 15:28:45 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
	corbet@lwn.net, tglx@kernel.org, gregkh@linuxfoundation.org,
	pbonzini@redhat.com, seanjc@google.com, vschneid@redhat.com,
	huschle@linux.ibm.com, rostedt@goodmis.org,
	dietmar.eggemann@arm.com, maddy@linux.ibm.com, srikar@linux.ibm.com,
	hdanton@sina.com, chleroy@kernel.org, vineeth@bitbyteword.org,
	frederic@kernel.org, arighi@nvidia.com, pauld@redhat.com,
	christian.loehle@arm.com, tj@kernel.org,
	tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
	rdunlap@infradead.org, kernellwp@gmail.com,
	linux-doc@vger.kernel.org, jgross@suse.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v8 10/11] virt/steal_governor: Implement steal_governor
 policy loop
Message-ID: <al_IbeAa3sDrt9A7@yury>
References: <20260720172250.2257582-1-sshegde@linux.ibm.com>
 <20260720172250.2257582-11-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720172250.2257582-11-sshegde@linux.ibm.com>
X-ClientProxiedBy: BY3PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:217::13) To DM3PR12MB9349.namprd12.prod.outlook.com
 (2603:10b6:0:49::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9349:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 292051f3-c5c8-4ccf-6d4b-08dee75e4a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|11063799006|5023799004|4143699003|10067099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V/FP/HdG8LDEsrjQmDrwxFionRU27xwbgoDUdqTXRsgMyLSd2ePpwhBUVtOAaQst7qdtT4pL1WL4EnEK8h0xN5dI5c4O2b5/YZTInobZ6S0StS1bGiNomodvrF1Tfl5+W+Odvi2rV0XP2z5vvBvBis6Hm31CN764bdsNGcNkKuq39ypNhAR1W502SGFaRDSKufl/lxOUHp3fNX3KhvkI5S2RPwMfhPd2tlkiuuG9nc3jd52oq++OLKD8YNHsJxnV1FcQ5KEeUm4MMr46+1rE/+XYgrmXF/EjGeA/8dqe6FyYe7IrWNno1/N/bMgg+tuIvqG/X9gGHYKcPQTqHReFGTHBpt5mVpJjouhGmrUWLvfJ3bt+/8aQB1oiM4AsVxxGWzleiwksAjbdrePh7YkcfQfjNMU6osOtlWIexp+LtQU8VIH9MIPi7kIz1PU4KUqr+eGG/7TcQmdPhU7EEnwTcjzgRx5R1fAU9UzInX7R+D80WB5obTP4uaD2UXC3XiAQpX56yDkn93ydTb3HFcbzidNOO4L7ysraBCml6ogd4+NZu5q94kM7d7lY6vWeTXBMPewOtDbkSDnaDN5hvP2106ZVYk4gwgy2dJFC9JXc034JHtT63YIWh/uemfU3YUAix8hY7Kw1AeijmzFW8jPsRI4H6T0c+6+nECN+pfcxPW8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(11063799006)(5023799004)(4143699003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oaPkCKBga4E2Nhb/xSmLx3XeYzhdTXJ+0BvzDQklBmO3UOCN4ydLBJxOV4XW?=
 =?us-ascii?Q?LGh7Xy7EIq3+NK/fS/YjP6bNI+mHKPsSwU0AHOlwS2ORduJ1skzRAnhadl/T?=
 =?us-ascii?Q?5AEQoz72+V0C//bvZrRZXE1TI5dsJa7VLfeF6/jEUO9PAK/6ukWWptCQsKqG?=
 =?us-ascii?Q?b7wpq2Z/YyJ0UZUofNVRzMWWOUFw98EEsk5tjGVQmpNDncChwP8l2HK6IGb0?=
 =?us-ascii?Q?SUuV8mHIZVpfJkhrIZMKkdpDcWZ3LC7o0s2/Ki/jCv3OFHHvEAqO1mMH+vo8?=
 =?us-ascii?Q?gXcqw+bo8mq8zusqQuOuFZTgevSLvoG8o071uVO/reeMk/C3Hn2hWjHHPOQj?=
 =?us-ascii?Q?icajeNlCh8//yExmuinErb8jL6/zPWMCwwC861haMPrmqR9xAOkICxioOM+8?=
 =?us-ascii?Q?n8+EbVk9OsBLC62lLxHNtHVCSayJGjVsYqyGk2IPSP18dMJ8Bf/ON/YHsmcm?=
 =?us-ascii?Q?JjULigBEaXa1vZ16QvXy17Xl/jR6bhYQiFmy89YJmu3fqr/HGZAh/bj3hRs7?=
 =?us-ascii?Q?s1nz94J3RRiW4bdKRQpQyof15gK45h6gsxj0T+bWV3NCGbhCqmVIkc2AHby9?=
 =?us-ascii?Q?awyXmxkAu6b/Q+1bP2p+KV0YQNxqRT6y3cI5DNI5B+2bLx1sm974nUakMnJv?=
 =?us-ascii?Q?z6NpEhueleFTMzexXykatmdtC1k9Lw9VRLZqELxyQ6sgpsV4D02kzNAuO377?=
 =?us-ascii?Q?mULNW2SkvsI99Pn85TNQhzIjRqLjKZRwjUtnDWgyEeKQbVfrU4LqpQ4wzFS2?=
 =?us-ascii?Q?7Zvb0jbwTfYohAsAAEHarwC8902x3TEeLltQemCjYzFDwRBBUjToO5vucxb9?=
 =?us-ascii?Q?KTk2Zmjp1CvH35zki/PfF8hf6jOJKmkEGy+fVVz/0mCOk/KmDSvSngVGk3JX?=
 =?us-ascii?Q?gfFAzB7HXOp9VhblYOKwUBHTpQHGjO3ndmP4GgMGk0rfS15cK5aM6H0UJrQ4?=
 =?us-ascii?Q?oGSYLWqSs6kjb2RYEAVFbOO+1+08ajF9yvVP0GD0PeUUsuIqCW8Q9Yk1Mdwi?=
 =?us-ascii?Q?5n0IjAGHKhMMskBrvrSMLTmX/StmGZ8hAmrxI+Q6p8G9jMKa/RIeGlTUxM3i?=
 =?us-ascii?Q?U6rVc1zzWf8b6BCjf7LmiUFT3jhMfdHeOBtc723i9jkuNgTGVsw71kILX+RZ?=
 =?us-ascii?Q?nBzPl3giwtUM8Hz4QZMhhLW3AbXM+FEhnukuEkgnaMKtAQFI2LIBH1x2RDr+?=
 =?us-ascii?Q?kwr8fYCQyQgHjYMeUkrjxsbjmMp2j6nErvX8zwf8Xe8ZlMfCmgP+YKU/tfIw?=
 =?us-ascii?Q?sBP+AayP8QQd/+k5jdspmYiFWqs5rsRa+6h3IqOP5Wox993OXyAG85GiNmuv?=
 =?us-ascii?Q?U7wB3gn/ZTJlkSnMzfW8O5LNR/aYS0HBWDjLS4s7ZBHrO69loUnNaBMXJNKq?=
 =?us-ascii?Q?q26slWvF7dTqJhWPteVAa7JqCQpVVkW0b//6lnOoEFuEIwl1FAEC+2TNYWVU?=
 =?us-ascii?Q?96zwOH5g4YE7wcE4SDl37h5+3H7dQKBXyp3oH8/rQJKwWAI5yaO5ZRWiRWfN?=
 =?us-ascii?Q?Jor06V6ZYUr7IclDPaDib1MtLXH1v0CbOBQ3pexQTarirzjj1mXesa1UkNys?=
 =?us-ascii?Q?Fo6lu3ZQhkBy0S2CqfaISk8UklGxYpQgOTaShrEVZ4S4nP/dFcTYMEvcsW7R?=
 =?us-ascii?Q?TkSzgk+aIq00w3FG8d1u7opJOPbIwBt1Mtlx+IRtChgpXA4SUX7Z8RbvWa35?=
 =?us-ascii?Q?5RTDptSqfJHst7umpxBuyG8gPr0zduX48AqHmCCKAMSe2svI3qghwFiXUxjZ?=
 =?us-ascii?Q?4oB4Jvy4vQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292051f3-c5c8-4ccf-6d4b-08dee75e4a4c
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:28:49.5096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SVq1+H9mVGNNFfp2MAT1xpTQW33/+tAK345QUKgnn/iTuCQZIRkDE5n9ngbKMuiGYdVjyXv+2rMYa7rDm/4TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374

On Mon, Jul 20, 2026 at 10:52:49PM +0530, Shrikanth Hegde wrote:
> schedule work at regular intervals to implement the steal_governor
> policy of monitoring the steal time and take action on the state of
> preferred CPUs. The interval is determined by interval_ms parameter.
> schedule_delayed_work is used since interval_ms
> is in the order of milliseconds. Work need not happen instantly.
> 
> Periodic policy loop essentially does:
> - Gets the total/delta steal values and cpus to use steal_ratio.
>   (get_system_steal_time, get_num_cpus_steal_ratio)
> - Calculate the steal_ratio as below.
> 
>        steal_ratio = (delta_steal * 100*100)/(delta_ns * num_cpus())
> 
>   It is calculated to consider the fractional values of steal time.
>   I.e 10 means 0.1% steal time. A few tricks such as divide by 10,000
>   are used to avoid possible overflow.
> - If steal value is higher than high threshold, call the method to reduce
>   the preferred CPUs. (decrease_preferred_cpus)
> - If steal value is lower or equal to low threshold, call the method to
>   increase the preferred CPUs. (increase_preferred_cpus)
> - If the steal value is in between, no action is taken.
> - Save the values for next delta calculations.
> - Ensure design checks are met.
>   1. At least one core/CPU must be there in preferred mask.
>   2. preferred CPUs is subset of active CPUs.
> If not met, then restore preferred CPUs to active and stop
> requeue of the work. Driver is effectively non-functional after that.
> 
> In Order to help the above loop, a few helper functions have been added.
> 
> 1. get_system_steal_time()
> - steal governor takes global view of steal time instead of individual
>   vCPU. Collect the steal values across the vCPUs of interest.
> - Sum up steal time values across possible CPUs. This helps to keep it
>   a monotonically increasing number and avoids spikes due to CPU
>   hotplug.
> 
> 2. decrease_preferred_cpus()
> - Called when there is high steal time. It needs to decide which CPUs to
>   mark as non-preferred and set that state.
> - Get first housekeeping CPU and its core mask. Mark it as
>   protected core. This helps to keep at least one core as preferred.
>   kernel ensures at least one housekeeping CPU stays active.
> - Find the last CPU outside of this protected core mask. (target CPU)
> - Based on that target CPU, get its sibling and mark them as
>   non-preferred.
> 
> 3. increase_preferred_cpus()
> - Called when there is low steal time. It needs to decide which CPUs to
>   mark as preferred and set that state.
> - Get the first active non-preferred CPUs. This likely is the last
>   set of CPUs being marked as non-preferred.
> - get the siblings of that CPU and mark them as preferred.
> 
> 4. get_num_cpus_steal_ratio()
> - informs how many CPUs needs to be considered for steal_ratio
>   calculations.
> - Return number of possible CPUs as get_system_steal_time computes
>   steal values across possible CPUs.
> 
> Notes:
> 1. Using core instead of individual CPUs performs better as SMT is
>    quite common and some hypervisor such as powerVM does core scheduling.
> 
> 2. This doesn't do any NUMA splicing to keep the code simpler and
>    minimal overhead. Current code expects CPUs spread uniformly
>    across NUMA nodes.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  drivers/virt/steal_governor/core.c | 160 +++++++++++++++++++++++++++++
>  drivers/virt/steal_governor/core.h |   5 +
>  2 files changed, 165 insertions(+)
> 
> diff --git a/drivers/virt/steal_governor/core.c b/drivers/virt/steal_governor/core.c
> index 1cb766a8ce28..97f82d6df60f 100644
> --- a/drivers/virt/steal_governor/core.c
> +++ b/drivers/virt/steal_governor/core.c
> @@ -89,6 +89,158 @@ module_param_named(low_threshold, sg_core_ctx.low_threshold, uint, 0444);
>  MODULE_PARM_DESC(low_threshold,
>  		 "Low steal threshold. default: 200 i.e 2%. Must be < high_threshold");
>  
> +/*
> + * Returns steal time of the full system.
> + * Compute collective steal time across all possible CPUs.
> + */
> +static u64 get_system_steal_time(void)
> +{
> +	int cpu;
> +	u64 total_steal = 0;
> +
> +	for_each_possible_cpu(cpu)
> +		total_steal += kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];
> +
> +	return total_steal;
> +}

There's another implementation of the same logic in
hd_calculate_steal_percentage())

It means it should live in include/linux/kernel_stat.h as:
        
        u64 kcpustat_steal_time(struct cpumask *cpus);

Or possibly even more generic:

        u64 kcpustat_field_total(enum cpu_usage_stat usage, struct cpumask *cpus);

Similarly to the existing kcpustat_field().

The other possible candidates are: fs/proc/stat.c:: show_stat()
arch_cpu_idle_time(), but I think it's out of the scope of your
series. 

What's the relation between the arch/s390/kernel/hiperdispatch.c and
your steal governor? Is that a similar concept?

> +/*
> + * Returns number of CPUs to consider for steal ratio.
> + * Return possible CPUs.
> + */

Can you rephrase the comment? It has 2 'return' sections with
different meaning. If the 2nd one is the implementation detail,
I'd put it inside the function scope, or drop entirely.

> +static unsigned int get_num_cpus_steal_ratio(void)
> +{
> +	return num_possible_cpus();
> +}
> +
> +/*
> + * Take action to decrease preferred CPUs.
> + *

Drop this 'Take action' wording please.

> + * Decrease the preferred CPUs by 1 core.
> + * Take out the last core in the active & preferred.
> + *
> + * Must ensure
> + * - least one housekeeping core is always kept as preferred

s/least/at least/ ?

> + * - preferred is always subset of active.
> + */
> +static void decrease_preferred_cpus(void)
> +{
> +	int tmp_cpu, first_hk_cpu, last_cpu;
> +	const struct cpumask *first_hk_core;
> +	int target_cpu = nr_cpu_ids;
> +
> +	guard(cpus_read_lock)();
> +	first_hk_cpu = cpumask_first_and(housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
> +					 cpu_preferred_mask);
> +	if (first_hk_cpu >= nr_cpu_ids)
> +		return;
> +
> +	last_cpu = cpumask_last(cpu_preferred_mask);
> +
> +	if (last_cpu >= nr_cpu_ids)
> +		return;
> +
> +	/* Always leave first housekeeping core as preferred. */
> +	first_hk_core = topology_sibling_cpumask(first_hk_cpu);
> +
> +	/* Find the last CPU which doesn't belong to that first hk_core. */
> +	if (!cpumask_test_cpu(last_cpu, first_hk_core)) {
> +		target_cpu = last_cpu;
> +	} else {
> +		for_each_cpu_andnot(tmp_cpu, cpu_preferred_mask, first_hk_core)
> +			target_cpu = tmp_cpu;
> +	}

Too much local variables. You can drop those tmp_cpu, last_cpu and
target_cpu, and just use a single variable 'cpu'. That would also
simplify your logic:

        cpu = cpumask_last(cpu_preferred_mask);
        core = topology_sibling_cpumask(first_hk_cpu);

        if (cpumask_test_cpu(cpu, core)) {
                for_each_cpu_andnot(cpu, cpu_preferred_mask, core)
                        /* nop */ ;
        }

        if (cpu >= nr_cpu_ids)
                return;

And so on.

> +
> +	/* Only the first housekeeping core remains */
> +	if (target_cpu >= nr_cpu_ids)
> +		return;
> +
> +	for_each_cpu_and(tmp_cpu, topology_sibling_cpumask(target_cpu),
> +			 cpu_preferred_mask)
> +		set_cpu_preferred(tmp_cpu, false);
> +}
> +
> +/*
> + * Take action to increase preferred CPUs.
> + *

Again, drop this 'take action' thing.

> + * Increase the preferred CPUs by 1 core.
> + * Add the first core in active & !preferred
> + *
> + * Must ensure preferred is subset of active.
> + */
> +static void increase_preferred_cpus(void)
> +{
> +	int first_cpu, tmp_cpu;
> +
> +	guard(cpus_read_lock)();
> +	first_cpu = cpumask_first_andnot(cpu_active_mask, cpu_preferred_mask);
> +
> +	/* All CPUs are preferred. Nothing to increase further */
> +	if (first_cpu >= nr_cpu_ids)
> +		return;
> +
> +	for_each_cpu_and(tmp_cpu, topology_sibling_cpumask(first_cpu),
> +			 cpu_active_mask)
> +		set_cpu_preferred(tmp_cpu, true);
> +}
> +
> +static void compute_preferred_cpus_work(struct work_struct *work)
> +{
> +	u64 curr_steal, delta_steal, delta_ns, steal_ratio;
> +	ktime_t now;
> +
> +	now = ktime_get();
> +	delta_ns = ktime_to_ns(ktime_sub(now, sg_core_ctx.time));
> +
> +	if (unlikely(delta_ns < NSEC_PER_MSEC)) {
> +		pr_err_ratelimited("steal_governor: work scheduled too soon delta_ns: %llu\n",
> +				   delta_ns);
> +		goto requeue_work;
> +	}
> +
> +	curr_steal = get_system_steal_time();
> +	delta_steal = curr_steal > sg_core_ctx.steal ?
> +		      curr_steal - sg_core_ctx.steal : 0;
> +
> +	/* Update for next calculation */
> +	sg_core_ctx.steal = curr_steal;
> +	sg_core_ctx.time = now;
> +
> +	/*
> +	 * steal_ratio = (delta_steal * 100*100)/(delta_ns * num_cpus())
> +	 * To avoid possible overflow, divide the denominator early.
> +	 * Note minimum interval is 100ms.
> +	 */
> +	delta_ns = max_t(u64, div_u64(delta_ns * get_num_cpus_steal_ratio(),
> +				      100 * 100), 1);
> +	steal_ratio = div64_u64(delta_steal, delta_ns);
> +
> +	if (steal_ratio > sg_core_ctx.high_threshold)
> +		decrease_preferred_cpus();
> +	if (steal_ratio <= sg_core_ctx.low_threshold)
> +		increase_preferred_cpus();

If you neither increase, nor decrease, you don't need to check the mask
because you know you don't modify it. Also, I'd wrap the below integrity
checks into a helper function.

	if (steal_ratio > sg_core_ctx.high_threshold)
		decrease_preferred_cpus();
	else if (steal_ratio <= sg_core_ctx.low_threshold)
		increase_preferred_cpus();
        else
                goto requeue_work;

        if (check_integrity())
                return;

> +	/* maintain design constructs always */
> +	if (cpumask_empty(cpu_preferred_mask)) {
> +		pr_err("empty preferred mask. stop steal governor\n");
> +		restore_preferred_to_active();
> +		return;
> +	}
> +
> +	if (!cpumask_subset(cpu_preferred_mask, cpu_active_mask)) {
> +		pr_err("preferred: %*pbl is not subset of active: %*pbl, stop steal governor\n",
> +		       cpumask_pr_args(cpu_preferred_mask),
> +		       cpumask_pr_args(cpu_active_mask));
> +		restore_preferred_to_active();
> +		return;
> +	}
> +
> +requeue_work:
> +	/* Trigger for next sampling */

The lablel above is pretty explaining to me. The comment just
duplicates it. Maybe drop the comment?

> +	schedule_delayed_work(&sg_core_ctx.work,
> +			      msecs_to_jiffies(sg_core_ctx.interval_ms));

If you need jiffies, why don't you have them in the structure, instead of
milliseconds?

	schedule_delayed_work(&sg_core_ctx.work, sg_core_ctx.delay);

> +}
> +
>  static int __init steal_governor_init(void)
>  {
>  	if (sg_core_ctx.low_threshold >= sg_core_ctx.high_threshold) {
> @@ -100,11 +252,19 @@ static int __init steal_governor_init(void)
>  	pr_info("steal_governor is enabled. interval: %ums, high_threshold: %u, low_threshold: %u\n",
>  		sg_core_ctx.interval_ms, sg_core_ctx.high_threshold, sg_core_ctx.low_threshold);
>  
> +	INIT_DELAYED_WORK(&sg_core_ctx.work, compute_preferred_cpus_work);
> +	sg_core_ctx.steal = get_system_steal_time();
> +	sg_core_ctx.time = ktime_get();
> +
> +	schedule_delayed_work(&sg_core_ctx.work,
> +			      msecs_to_jiffies(sg_core_ctx.interval_ms));
> +
>  	return 0;
>  }
>  
>  static void __exit steal_governor_exit(void)
>  {
> +	disable_delayed_work_sync(&sg_core_ctx.work);
>  	restore_preferred_to_active();
>  	pr_info("steal_governor is disabled\n");
>  }
> diff --git a/drivers/virt/steal_governor/core.h b/drivers/virt/steal_governor/core.h
> index e27305284ac0..59329c1d7109 100644
> --- a/drivers/virt/steal_governor/core.h
> +++ b/drivers/virt/steal_governor/core.h
> @@ -12,6 +12,11 @@
>  #include <linux/workqueue.h>
>  #include <linux/ktime.h>
>  #include <linux/kconfig.h>
> +#include <linux/kernel_stat.h>
> +#include <linux/topology.h>
> +#include <linux/sched/isolation.h>
> +#include <linux/cleanup.h>
> +#include <linux/math64.h>
>  
>  struct steal_governor {
>  	struct delayed_work	work;
> -- 
> 2.47.3
