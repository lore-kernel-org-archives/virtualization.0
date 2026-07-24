Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515AF392C32
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 22:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930696; cv=fail; b=IRxYPX45rKsj1J+AJRVyWbbnBo3qUQx5pGfZkDpUs57clq3EwLE3oFskaZe9YYZKGt78+gi5VibtxhBsYhI9XF+vsx+C+jzoATdFbGnEYhSWo84k5kYt0yoi0DE5pBVCqkA7rakoqCCZfga02H1I6iSU9aO9CO5mT72vMNb9tvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930696; c=relaxed/simple;
	bh=Hr6++0XMLFndl6OoSIbM7IIgzTnPPjSTxOy9yn9Ls+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MzE5xQPaAicj7lzPQiUmph/+IyeAGBfpsd90hYlDBu/4vGNRRIZpPGiF3HIfzzkjZNWDtNKwwEVpFXcU9bXgCR3VLNvbWBEHcyQj14fqsPmjxr+UZJBAImwhmgYkLtmZmy4N910VqTmdSJ3vx/8TBqAPMosVnLUyJsYlAAUnq5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eN2IbyTn; arc=fail smtp.client-ip=52.101.46.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eN2IbyTn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDaveHTxMhbMfzbsOX+UquJ5vru3+u2x3Jxh9i0Er9ULbj+JSmqArY61akjiAJF4EAJxx4hVq57idiUja5cvp8GLJNxGyFMO0T51rPUqzeNAjsliU533etmnouPMdZQyL4SQc/BluM7e8mExyThiRS4iIWNGgSpgmODy5r4882y8QdMHUZqImkXZEQQDE6Sv4LCsiwDQpwqo2fso2XRGF9YfUkYORrtO9/4Z0lGoGhIox+KcU3/Lt7JffHC/EdGs27gGT7dyh12SekUwUvlPk6GiX16K6FqVfml1HjNq3cGI21Epxh+OT8H7Ko4W5Pl496nyTYxcNo4J507v/FYv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11XHMn5aleUXKWp78Mtt9+xMWnMas9C1mtiHDx69rGw=;
 b=JFD8miYk5H+TTBZwg3lYXCyM8VeA9hcwgCPzTrPADWkoo+UnCMUnZtBqddRj9NY2pgJIbrAiNmD28lz5FibUos8xcCAbNkLT8eUVa1LwqAkPgHPCPPPXtkCwFzHMc0rYxEYvh5VbNKy4APheMnE+xk8Fepi7Pfy6G/LUPJwucJ20JKzFda98TmuU/2mqxOCvek+C/I+t0SFowFdlsvWbX6YruZvhW28usz5T1mR7b8eyn/nypYxbJdc+EPz2uynsg+Ewit8ioM5fCmU642HnzXWd6aLSR6/Tdce1FIT3oqop1xyrIfOlGZf3SKK4uqnAZQ+z/akv7cWvL6XsF+LxZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11XHMn5aleUXKWp78Mtt9+xMWnMas9C1mtiHDx69rGw=;
 b=eN2IbyTnyEABcuunXtKLUhAXFLU3JaM5H5qE+kjGqVee23Dr2porXnj/x0Z565MGpBcbSAbzV4U6rrF0nN2OSkgSg0gAXwWK5/f5FKdInvxun9DxSu50TGI3mdAk0TmxmSYXbglqKYd1K4t7EdVC9+RNcLb1KAFWcUzUlyR34TEikt+z8PHSpP/ukC4LTTWBdeiIqjiGQWBAtzu6bkKN8JbfSWZH0Dvsmfd17r48LWD98EoOsxHRVoJ1YVFPMGt+Hwre6q85rSOMNAa3JjUjBycQ+jX31ITt086uglkghpe0Ty2bW2XKe44r0DrZJFugiuhPIoU+g5Z5W5PPOf/R4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 22:04:50 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 22:04:50 +0000
Date: Fri, 24 Jul 2026 18:04:47 -0400
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
Subject: Re: [PATCH v9 06/11] sched/core: Push current task from non
 preferred CPU
Message-ID: <amPhfyyVK-5g1PV5@yury>
References: <20260724140732.2683314-1-sshegde@linux.ibm.com>
 <20260724140732.2683314-7-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724140732.2683314-7-sshegde@linux.ibm.com>
X-ClientProxiedBy: BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::7) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: 813c7066-6245-4d48-5bf5-08dee9cf9510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|18002099003|22082099003|3023799007|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Yg8j5YWAM84A6pNH+nzjmKI2A+i1X9OC8To3yPsxpM8Thhdei+dc5h9fuYX5Vrq5YxDETVfcvloFBDEZIlbZVbBvSxd3Ih98rDdNYiVfND17m0kiYXe5HjTcR9iwXs94jgQJkdxDme6EYfWzIb91K7aRzyr/9jiaZnvI/wBQCp5N8rhZLRR7ISbLxE459ezR9Rtg2lK9OSBAKg6dpy9vgoASytcw5C+BEfIuR7PJAoGr6KCFilHIirGg9Ad/bEn7Uk/n//1GE7DzV+SL2T5+B84VXhD4OxFRICEL7B+RAqqGyIHRdlrGrZi0XAKq0CR9zMxknrn0piKl8PF9SW6R20oOQrYMtRhYPOquKJR9vW5NjPtn+7j+H/7NKP0G7uAceyDPflZ0EUrI+eQ9LjRmppZZWptlUFCCB/t1SYyRk2klXrYBLtOHrX7hxVEzQkTgCcreNklQFcvb/AwuQPClMuEAH9P7X++T/8YjZzljjWkdQr+BKKfQH5lQUZJScjHJFMGuWjy2o+hNyZORGEYJOCDbGHh8C+ZZ2F4uS9lz7x/9X78KqZDtgv+XvCx1j21zhFNosUEBUwFBR0ZTVhW9Afog2DOwdfGubWym5BqcY9g38ILu7BQN1Z3T8Z+NH+afa+3Zn5/9JtsZGR3sgaVQX96+WQomjfCa4P78lO84nAQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(22082099003)(3023799007)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NP6tRztIUVyCmleco7F4XAUi1SE5tsjUSX40jvNPndfuSBmWWo8BK/sUlfAL?=
 =?us-ascii?Q?ZFGqR2cVGc4E8+4UItoYvCm8Jc0KT3ltVS1iDZialoxHe1ZSwjv3bZ7b9F29?=
 =?us-ascii?Q?08jywJ6s8V8H1sURt/AwtqhFb1UTsXZbe5ZeSe2Ob8uLXwenTSAkxZbWyKqJ?=
 =?us-ascii?Q?3MzxnG8OM6s/6Y9UbPMYBOe5tF7V7k2tGpyZpTFLSpesdOB7c7gQgrOtyW+x?=
 =?us-ascii?Q?EHqRpSPV3/XfFsODqx5sVJGapx1DXO8Njunet/UQXC128zSVpTytKKLkPlTk?=
 =?us-ascii?Q?36iMNFvOgrrggQ/D823j9zVcYXX2OxmtAGA948Cji+qYa5Eap8zV97LOwOJD?=
 =?us-ascii?Q?K7mFdJazXDWeon3iyB8RMsZopUSn+KjCgmfLt5fR5WQpqivIeEEY5JHmvVfS?=
 =?us-ascii?Q?RaFZKWx3cMHOj18qiJy0JlV6alh5YePcIPmO+j4N4EP0AiB5DutHimghdxcw?=
 =?us-ascii?Q?iGr9j9Bvc7XfF0VhzdiJCV2WlgEi/pO2gAD2B3I15wcbiJD6WwMP8VIKGAxW?=
 =?us-ascii?Q?tDtpi4K1QCV12HytdpM9rRENHp+vk6ivYscYojtrIZNLJu4I6w+TcgYxSmGa?=
 =?us-ascii?Q?SBkX548I8+btvK/qNM2/M3zeRzTsfU7zSfmNeoIj5yxL2m1rhX7dzfVAFlM6?=
 =?us-ascii?Q?DBID7KkiDB03oJ59YvX4WrWeoeVAVVbvO/bhR3CNFaSAa4vbKa1Ai3alPiEb?=
 =?us-ascii?Q?uIoDR+9lg4evLnHwyzASIidkq10ZhkqFGZ9CeZ4KAzxUru36IwvymGywscZo?=
 =?us-ascii?Q?jy7yQDGyJpKjXR5ILoGxiNUNq2/axYQ1bnnj8AaZCYgsUlk/8KHfge4GJ8Pb?=
 =?us-ascii?Q?MLCZ+E1wvBHMYdN9TMWX3qtmhWK0Sgz9PXiE5lB9guInwKLR920j+7KeysJ8?=
 =?us-ascii?Q?UBES26L4qf2iLcZF5VWcgsi4iCR3HPYZqK0eAqKCTER4zloIMWH/QcNTrXzX?=
 =?us-ascii?Q?OktimhfDcn//id38Aj4MXgcktwMmM4SLKDypqxDeFgo+5oKca4jpuXM1LY+I?=
 =?us-ascii?Q?ypRPAJQB7aaTAgnHacAhul2Sp0vzR45xeL7oU9SJ1E/Z8j7qOa6iGwrWNrfo?=
 =?us-ascii?Q?elcGWm2Uom72EEeBa3E/r7JKSRMGo+gmuW5h8p2GulsfDjKRfm3DQP16DlZf?=
 =?us-ascii?Q?Rp266VvxElRHai6a5D5eLOta7T47o4X8mCeOGUfSQcG6tEi1QjCzeaFJqb4B?=
 =?us-ascii?Q?FQTtBKnA7Dvhf/FWaotS+P/RWkB28Zonx3ii0JeXX5rbyfMFjBEqsstWDoBm?=
 =?us-ascii?Q?WleX/VhNYxn7Xm8/YpgAENeB/1Z9jjhEzeD8E1psCv1vcBtpGGJub1ZAgD6C?=
 =?us-ascii?Q?6ib6Xc01TLmZySoqBk075eGWx4jTz0PZdE3DHCCiEbqzXCzdLImtpZcbFzh4?=
 =?us-ascii?Q?GS3U5WiEG3wJaGHpq4afsZf/4AzlfCLBrMs9R9OVppadXBm/lpNkZ07k3/89?=
 =?us-ascii?Q?yhRzSHov7pvdTUDH3+o8Xyd19dRCrEEzey4YwNWx9k5yyICQuygztL8nPc4C?=
 =?us-ascii?Q?5S792sB89QaQsZEG1Qc97GRBZRe67UZjfQiILy0bQT3RSOfTXZaxAsbVh+NT?=
 =?us-ascii?Q?dbqr3s9/2wBBGcsvnDIHymc5ElekoHIqU2WALCDrOiHPpiMQQ3iBRfhIataf?=
 =?us-ascii?Q?hWJrXp7ml+o0NsqB24L/U5rfSQeZa8naFEVRWk6wIk/krcFf80938nNQPlX1?=
 =?us-ascii?Q?9Cro3gzIP95+pFQYJwWMSRlFlour/TB+Fuflf90XqIS7WsMDQTQdRXPmF8Q0?=
 =?us-ascii?Q?E4GzsbJmWA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813c7066-6245-4d48-5bf5-08dee9cf9510
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 22:04:50.3931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uch+3buyFadWBgiWIlIAmBMso1P1gQFN/nCdIsrd5GM/WRsL+hh+ylAQ8dkU+OlfvJzsx8nhVyx871qaBoHVdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034

On Fri, Jul 24, 2026 at 07:37:27PM +0530, Shrikanth Hegde wrote:
> Actively push out task running on a non-preferred CPU. Since the task is
> running on the CPU, need to stop the cpu and push the task out.
> However, if the task is pinned only to non-preferred CPUs, it will continue
> running there. This will help in maintaining the userspace affinities
> unlike CPU hotplug or isolated cpusets.
> 
> Though code is similar to  __balance_push_cpu_stop and quite close to
> push_cpu_stop, it is being kept separate as it provides a cleaner
> implementation with CONFIG_PREFERRED_CPU.
> 
> Add push_task_work_done flag to protect work buffer.
> Works only with FAIR class.
> 
> For now, only current running task is pushed out. This keeps the code
> simpler. In future optimization maybe done to move all the queued
> task on the rq.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  kernel/sched/core.c  | 78 ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/sched.h |  8 +++++
>  2 files changed, 86 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9e8eec4451b6..704043531b24 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5774,6 +5774,9 @@ void sched_tick(void)
>  	unsigned long hw_pressure;
>  	u64 resched_latency;
>  
> +	if (!cpu_preferred(cpu))
> +		sched_push_current_non_preferred_cpu(rq);
> +
>  	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
>  		arch_scale_freq_tick();
>  
> @@ -11292,3 +11295,78 @@ void sched_change_end(struct sched_change_ctx *ctx)
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
> +		scoped_guard(rq_lock, rq)
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

You always return 0, and don't test the return value. Just make it
void, or return (and handle) some error, please.

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
> index 6de6366f2faa..80c02e2c09eb 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1277,6 +1277,8 @@ struct rq {
>  
>  	struct list_head cfs_tasks;
>  
> +	bool			push_task_work_done;
> +
>  	struct sched_avg	avg_rt;
>  	struct sched_avg	avg_dl;
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
> @@ -4242,4 +4244,10 @@ static inline bool task_can_sched_on_preferred(int cpu, struct task_struct *p)
>  	return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
>  }
>  
> +#ifdef CONFIG_PREFERRED_CPU
> +void sched_push_current_non_preferred_cpu(struct rq *rq);
> +#else	/* !CONFIG_PREFERRED_CPU */
> +static inline void sched_push_current_non_preferred_cpu(struct rq *rq) { }
> +#endif
> +
>  #endif /* _KERNEL_SCHED_SCHED_H */
> -- 
> 2.47.3
