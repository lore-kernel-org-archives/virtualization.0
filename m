Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3F24EA90
	for <virtualization@lists.linux.dev>; Sat,  5 Sep 2026 00:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788568109; cv=fail; b=QOEjmcvITpjngJjaNNc92qsnH7KVaFTUce4V+xvmV0aAJkb+RQHKf3qAi34wz59/vxPlEcAlEa7j1gzYSkv1eMLP40lq9uXcE5HQi9RkuTXWQMiGIF+WaM8ZtdOyaYS0411/Glz6xPc1W6mwo9NMwO4UNp5k2JTDKX/mvh2HOKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788568109; c=relaxed/simple;
	bh=X7jZlqAhsYgN5ZytF/PdmovPPkKUZEz0D3bjsdgfmd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cm6nDcADwlyvTKG4mdO+nLlzdjELuGx/sU3037GO5GVI/KtTdJ5HfyAkV+3guJeQJbEqwGnO0Bt+YMfg0exKpWYyTIpRjZVk/LKo57PKtbgecXUOcToNDJoeySJqQd1k54j0NXE6nk55hVDYuE3EovysnnhxrVRqFy5Z2DZh2z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nR5uLkfW; arc=fail smtp.client-ip=40.107.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nR5uLkfW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXOo9zvOsCPnkqSwb+pF5CfHPGNuuCYlAOYQ+8p/efuBTGDJX1eXYl9wOz8WdaSdXLdu2FCQZKC8kF0KXdjB8LU/XH/j0HIvoacBFnPbjxUeW7NKSZSU8lpEjj61SV85tyU7kntXJQmwKRNQOOeakpx0BRaF5TG0vhKy3bgRVHNvw/hbQcMeLp3waO1kiP45cXT2fXbDAhi25DC4/eX5UR89/92k29xaHGs+KygGNYce0vE4LlYwhjYgW63PrZ4pS02rXsw7sLXkQ48dLU43dDTFfD93imKIauNCOoC5nZRL54EYgsvsAEs5gbV35kf99+G8fFb+j2B2SKftfCqQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kq74jnbwNtVKXW9veG5cufaGgeqnl4DIcGBkk2Mzl0I=;
 b=XAAK96THNj2/tU4RiWPtCssHegVh5XmwLtDnQfKn4rM+n/8ZcKJyJl0ICcYEiiYGrcBvZKTlh1daOF0/6HVM3bgEAri5Hi/6JOTIVmKohmDrXPuz2gDqCYKpBj0Vgvk4WE1Kpz9l8Sm78UxanPIBSP1RRanamn4Go/u3SnQL/XQP/OdbXE6z49zyr+Kap00czEb6yxQNtYlRaviDV71S/VpzgamAvjrT8GAVYf/giUUE1gt/STOqZIEZybpOe29vDoxTDtRSSTULT2N1j0GWh+N95bVwUydBQD3NUmIwrABxJx3+q48TtgQrUclsLrhebxF/6tWeoLcOOLH8CJzPFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kq74jnbwNtVKXW9veG5cufaGgeqnl4DIcGBkk2Mzl0I=;
 b=nR5uLkfW6FKvlLGYgZ23cyXqRe7m37rTjogiCsHBzu1ScBNxEKJcgrHXZnkaW8gICubpS+s3YVAPfQAvC0UkwvjjCJB1fEN9aBz25E38Rhr7kBfFNeR1mZoF0Reb8lL+Nh/dWNqE2CV7Q9QNL4p0EbbsMr3FYSFoXWwlJ500mujbuIqOTZfs7kdUddS0FZLgOTeg1fllCyaY4xoh0T3yi9gjb4MOgagyrnPddy9yg5A3T/CBJMVvbJvnxat3WRnEHvmyRaR09fhLAxnONypXq7CKOMuW7DT/CmRd6k+MgZOiAfWwP/ZnBafGe6mijQ5rWI0s3ZS5Or6bi5u2O65Hkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 00:28:22 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0360.008; Sat, 5 Sep 2026
 00:28:22 +0000
Date: Fri, 4 Sep 2026 20:28:20 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
	corbet@lwn.net, meted@linux.ibm.com, tglx@kernel.org,
	gregkh@linuxfoundation.org, pbonzini@redhat.com, seanjc@google.com,
	vschneid@redhat.com, huschle@linux.ibm.com, rostedt@goodmis.org,
	dietmar.eggemann@arm.com, maddy@linux.ibm.com, srikar@linux.ibm.com,
	hdanton@sina.com, chleroy@kernel.org, vineeth@bitbyteword.org,
	frederic@kernel.org, arighi@nvidia.com, pauld@redhat.com,
	christian.loehle@arm.com, tj@kernel.org,
	tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
	rdunlap@infradead.org, kernellwp@gmail.com,
	linux-doc@vger.kernel.org, jgross@suse.com,
	virtualization@lists.linux.dev, sunlightlinux@gmail.com
Subject: Re: [PATCH v12 08/13] sched/core: Push current task from non
 preferred CPU
Message-ID: <aptiJP_8SWwZWju6@yury>
References: <20260903063240.268775-1-sshegde@linux.ibm.com>
 <20260903063240.268775-9-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903063240.268775-9-sshegde@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0247.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::12) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|BL3PR12MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 98918d32-3669-483c-13a1-08df0ae49763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|23010399003|18002099003|22082099003|3023799007|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	YpESm2euYG8o6W7+ezDivxP7OvCebMSlG0jKEejgFSPYQzEb21CVmKdBFAWEQ6dKXkANGgl6jOZTT4azarZ4NRd+EuF1aPpIMyPttTCT7o/Oltsxz2VVpPQa1sXS1e2r30EMgia1KFAEzDWs11sMv98rqNhoexNCf+QCoYIzXcA1wQfcETW9h24JHJL2FMAFsPjr1SdmD07JHOqkyuxFGYAtR8HjbiwHvEpPwGdgmcad14wIj2jypkDkBqt6WBRgTAR7GAOpxdC/7S8zv8Sfu9b7vw2hwOtQntSufJ25O3XpexQWSJFYp4D/Rlfm3hQXH/sTDOJ9NtkcZT20hs7t0+bd8RMl9UTz59ZLFl1TXjt/0eXlZ6BbpRgPPnePFgiqB3acA/c+L8sU6YappMNK7KpmEjg7j8r9TqbixnQdzjWrBlUzn0rBU/5RNH7H0cvcUEbN58mn26+Oz9jDNEwEiMhpIos/nus1NKnc2sVABxcedUFD58UdCTYnKR9UKB0XUcZcfZDNKSO88inBwcDm8UKDmoy7J/M9Nr+sjd6GqiZPmlXAyzF1ky7eYOBAcP1Ebzv6SjHxokROE2MYfjqEGTnzbDULLGP2CMrpfONV5r/sWTVW2tHmVVwv+djjlmC57047WJYFS7zteRDRbynbyjd/3DwkswdOgeNqnJiFjnM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jCQTQ2hEUnYkFqiOMHuqbC7trx33vmjxGc7IPiRGI9ScRMI/s4BbvGugWDJO?=
 =?us-ascii?Q?CN5SBXY8u/qGCwpyHumcb5A6O1eHCYTvs93a9zd0YX4L50XNNQiOXaKTcjsf?=
 =?us-ascii?Q?MwRKRpFjC47E+hiB4EtY88W6t+yWfwlQy5Sj7KCBOlY6S3sajYNVjJhWjPCX?=
 =?us-ascii?Q?wY/a1u2RuakgKShaiCF9sTMv2IQNr8vcJCg+TrwPwxATLTXHjFAEgepSH4Qx?=
 =?us-ascii?Q?Lkp5cgE3/ZpPkWQJpANa6m21xOJC4PDgdXATR8R5HKnGxIIRcd4IOhlXX7C3?=
 =?us-ascii?Q?0evE1VgRQpi5YziaFtQ/hVqRGO1fHtfXtNUnDf6jTR24lbIDv3yHYY+JAJFn?=
 =?us-ascii?Q?9VJRxx73FzslLD/pcAM6lBlX2OzXiBok5s9gG+rWU13cmmOFn+sG+lqGBook?=
 =?us-ascii?Q?Nj83Sz67cRMK4oZg60I0yPK9mmz9NZUC1yMhG1I6Nz+5cStlhCtR2Rr1cLYJ?=
 =?us-ascii?Q?Q5w86d8gLiF/oJ2lPkVrIoReNZl/yXqGKsO/MH1vfRRIqhsaE5L5F2fOXU0x?=
 =?us-ascii?Q?mBrUXbFP5eJL1eP3eIxcW+RSXf18YyGavqpcaq77rcVxzku3m8pwUkVdWqZf?=
 =?us-ascii?Q?c3Ly7o/6+jMvYb1yF/cmY3DxjDrvGYpA73RbjSbJFY9YIoa4qoyjMciIVFBn?=
 =?us-ascii?Q?uPNLSLKsxp13sUjGgB2iIWS2naOIBoIc35DmKqV/UsGEncxVetot+t7oXxGF?=
 =?us-ascii?Q?8eo1ptybmDGfGfWEUqMKAgOe/52o700A6q3AIl71hpVKt64DWazMgHj8DETv?=
 =?us-ascii?Q?kaZzhXZyAo3qMI5fJCyyXPMF1/zzLSQArQ9zhs4yEmInd772f0edvXHwLqm1?=
 =?us-ascii?Q?4FDkD9Mu5GzzxhzpEmpMvooD1drKZr9Lf+y4y52sjfCLCogVKI6XCVl1Eipp?=
 =?us-ascii?Q?C3zs3vaf15pn+nrTv6FDGJhVPpNjIgu/9mv2IPa1JmiGOc8bX6yrKx07plEx?=
 =?us-ascii?Q?DzmcGSo9CLV6H8/6CyDQ1a72XfX+H4Nkg8rIIQP6pKqv2RtNqpdX8lEl4tQB?=
 =?us-ascii?Q?Nh0YPkjycYVCgqcaLZ1MIXHK+mOGzav1eGBolNOztwusIrC9BzWoYhLqfopG?=
 =?us-ascii?Q?fIOFW9QRZ7jDLZcp03Aut9D/kEPs4uOyLINpSdJVeKY1ROnV/NXxmm7mlglJ?=
 =?us-ascii?Q?Uo6jPbdUp0SbcpXeP3po5SAwSIT63HjvLeFD3qPhQszN40B77COV2GikmnPs?=
 =?us-ascii?Q?wh7VWU65mNqlzjo5yP1qqrzQaMXw9mEkKYoHqFat7hTkeWUJJdzXOwEUKusj?=
 =?us-ascii?Q?3wI+jCqaBWqrazYfyzjm1kxuD7OaPHJz8vFnsKX3CRyvV5QztdjMZCiAxwDh?=
 =?us-ascii?Q?C3Rj+XLxPKJm44djxYWEVougERoOGF/6VExSTwlsYCbyU6hmFkc1XPlFDEaD?=
 =?us-ascii?Q?oMZHnUL8xV3Nl6A3WyQiScJvBmgLGe5cjrD9j0AYeLCUy7zWyMU8T0l/mclf?=
 =?us-ascii?Q?1+GqC3de/4RlcdVSkBebvgpEAi4b4Ma1VdRb4flkzhktF2yZQlvHitRh0HZQ?=
 =?us-ascii?Q?qeKEmak8VFV8QqhaqiNP8A9xEtxGNEuwQ19UHBLZ6KJ+jp4noZoLp7m/3QaU?=
 =?us-ascii?Q?CgyBwCHRvcvOwW2jZBWx8kq8DMSISXRY2jM9kG/QIB44WhfaD3wj5rdrw804?=
 =?us-ascii?Q?8QPpvbRTOYqbjebYz3jXhkBFNqmBTT/VZhraovyeBaXG0Bp+6/ARnpRBrZUY?=
 =?us-ascii?Q?G/cF41QNfaMR+VAV3Ihgr8cvwkK8RadBe3+Aynp1AtahxZQn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98918d32-3669-483c-13a1-08df0ae49763
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 00:28:22.0582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zu1NN7WtoSZhr14T77q06bspPSWX35Zkj0DSJWSfAyg6vYc2JAarlWzUun5TwQXzfp2yJ7wrPhCjRsFaNzbqMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642

On Thu, Sep 03, 2026 at 12:02:35PM +0530, Shrikanth Hegde wrote:
> Actively push out the current running task on a non-preferred CPU. Since
> the task is currently running, a stopper thread must be queued to push the
> task out. However, if the task is pinned only to non-preferred CPUs,
> it will continue running there. This helps to maintain userspace
> affinities, unlike CPU hotplug or isolated cpusets.
> 
> Though the code is similar to __balance_push_cpu_stop and quite close to
> push_cpu_stop, it is kept separate as it provides a cleaner
> implementation specifically for CONFIG_PREFERRED_CPU.
> 
> Add the push_task_work_done flag to protect the work buffer.
> 
> For now, only the currently running task is pushed out. This keeps the code
> simpler. In the future, an optimization may be added to move all queued
> tasks on the runqueue.
> 
> This works only for the FAIR scheduling class.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  kernel/sched/core.c  | 81 ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/sched.h |  8 +++++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b4ef2e92d786..35e7eedad104 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5808,6 +5808,9 @@ void sched_tick(void)
>  	unsigned long hw_pressure;
>  	u64 resched_latency;
>  
> +	if (!cpu_preferred(cpu))
> +		sched_push_current_non_preferred_cpu(rq);
> +
>  	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
>  		arch_scale_freq_tick();
>  
> @@ -11202,3 +11205,81 @@ void sched_change_end(struct sched_change_ctx *ctx)
>  		p->sched_class->prio_changed(rq, p, ctx->prio);
>  	}
>  }
> +
> +#ifdef CONFIG_PREFERRED_CPU
> +static DEFINE_PER_CPU(struct cpu_stop_work, npc_push_task_work);
> +
> +static int sched_non_preferred_cpu_push_stop(void *arg)
> +{
> +	struct task_struct *p = arg;
> +	struct rq *rq = this_rq();
> +	struct rq_flags rf;
> +	int cpu;
> +
> +	if (cpu_preferred(rq->cpu)) {
> +		scoped_guard(rq_lock_irqsave, rq)
> +			rq->push_task_work_done = false;
> +		put_task_struct(p);
> +		return 0;
> +	}
> +
> +	raw_spin_lock_irq(&p->pi_lock);
> +
> +	/* This could take rq lock. So call it before rq lock is taken */
> +	cpu = select_fallback_rq(rq->cpu, p);
> +	rq_lock(rq, &rf);

If select_fallback_rq() grabs the lock, then when it releases the
lock, there's a window for race between the other process and the
subsequent rq_lock(). Or I misunderstand it?

> +	rq->push_task_work_done = false;
> +	update_rq_clock(rq);
> +
> +	context_unsafe_alias(rq);
> +
> +	if (task_rq(p) == rq && task_on_rq_queued(p) &&
> +	    !is_migration_disabled(p))
> +		rq = __migrate_task(rq, &rf, p, cpu);
> +
> +	rq_unlock(rq, &rf);
> +	raw_spin_unlock_irq(&p->pi_lock);
> +	put_task_struct(p);
> +
> +	return 0;
> +}
> +
> +/*
> + * Push the current task running on non-preferred CPU(npc).
> + * Using this non preferred CPU will lead to more contention
> + * in the host. So it is better not to use this CPU.
> + *
> + * Since task is running, call a stopper to push the task out. This is
> + * similar to how task moves during hotplug. In select_fallback_rq a
> + * preferred CPU will be chosen and henceforth task shouldn't come back to
> + * this CPU again.
> + *
> + * Works for FAIR class only.
> + *
> + * If task is affined only on non-preferred CPUs, no point in moving it out.
> + */
> +void sched_push_current_non_preferred_cpu(struct rq *rq)
> +{
> +	struct task_struct *push_task = rq->curr;
> +
> +	scoped_guard(rq_lock, rq) {
> +		/* Push the task if its explicit affinity allows */
> +		if (!task_can_sched_on_preferred(rq->cpu, push_task))
> +			return;
> +
> +		/* There is already a stopper thread. Don't race with it. */
> +		if (rq->push_task_work_done)
> +			return;
> +
> +		if (is_migration_disabled(push_task))
> +			return;
> +
> +		rq->push_task_work_done = true;
> +	}
> +
> +	/* sched_tick runs with interrupts disabled. */
> +	get_task_struct(push_task);
> +	stop_one_cpu_nowait(rq->cpu, sched_non_preferred_cpu_push_stop,
> +			    push_task, this_cpu_ptr(&npc_push_task_work));
> +}
> +#endif
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 6c3ad70e58b8..678e44134acf 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1298,6 +1298,8 @@ struct rq {
>  
>  	struct list_head cfs_tasks;
>  
> +	bool			push_task_work_done;
> +

It should be protected with CONFIG_PREFERRED_CPU. Also, the name
doesn't look correct. You set the variable to 'true' even before
calling the stopper. Maybe need_push_to_npc, or similar?

Why did you place it between cfs_tasks and avg_rt? If no specific
reason, maybe place it next to CONFIG_PARAVIRT-guarded fields.

What about pahole?

>  	struct sched_avg	avg_rt;
>  	struct sched_avg	avg_dl;
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
> @@ -4280,4 +4282,10 @@ DEFINE_CLASS_IS_UNCONDITIONAL(sched_change)
>  
>  #include "ext/ext.h"
>  
> +#ifdef CONFIG_PREFERRED_CPU
> +void sched_push_current_non_preferred_cpu(struct rq *rq);
> +#else	/* !CONFIG_PREFERRED_CPU */
> +static inline void sched_push_current_non_preferred_cpu(struct rq *rq) { }
> +#endif
> +
>  #endif /* _KERNEL_SCHED_SCHED_H */
> -- 
> 2.52.0
