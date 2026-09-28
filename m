Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736773FFAD0
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575204; cv=none; b=TEfTODL3Fq3lnic974QsAtnjdWiTl+MetrgmUr934Wlbw90Y2iAxMhqDraoiH002ivr3NVAVbnpdeYwZZAqYM5/ybvnGRh9giZQJHMo2HJ+kY2QSRo80EZki6H2fvur7ABkkzre9jCdO12EhDrbHeR10S7nVB6RjGTQcHtJKCm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575204; c=relaxed/simple;
	bh=xDIso2BcRigS7mtWJy5IJXGK0m4ChuywV79z6NaWVmg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fbwwUqN1bIrkgZ4ey5grDak9wLRL3ryZwj9MnSSQ+DIOJBXHjyhkAXKpQFXJ0dWjJyDJtlc/cZ9JRWgY42DGZKY073IdVVykQSfcBsvc50XgtrB5GhW2OI5GY52jleKXDksmaVq0SBU9k6C0e8wLLiYsd0tSdoVx0eVO9pPmBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQZTxjJ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQZTxjJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D711F000FF;
	Mon, 28 Sep 2026 06:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790575203;
	bh=mOIa9bWKF/VWGfkWlWv8FwIar/nh8omIyYtyN9GPozQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bQZTxjJ7rwKdXDSBHlwk0OKUfjnUHNBgziJqwF9Ckcf3OZPLfe0W56IFZext4RYAG
	 /1q51CAnGAW24FDgUjqLBU/xqAD+HEtrqpOGcmJKh4L5tTLo48bERIzXRNtgzibXaB
	 bhG0d5kr+exezETG5TwSNYhYgZvzq87Esjl+bUwDYGPDHnd9lzjodqgXSrWHoZ7m26
	 LF0FZYvS95HmwaHh5d56c9Kh62Y8M5ENO+USYL8pVLiM6+eARbyA6IiW4MqQQaJWox
	 YoxSf83cN7klAQbNLFN/6eeuY7XyXQqWVtc5WfCrac3bWnL+gdakqae3uNcEdeimqn
	 mndUIFCo8l+fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 06/13] sched/core: Try to use a preferred CPU in
 is_cpu_allowed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260928053728.797539-7-sshegde@linux.ibm.com>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-7-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 06:00:02 +0000
Message-Id: <20260928060002.C0D711F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] sched/core: O(N^2) wakeup latency and task clumping in fallback pa=
th
- [High] sched/fair: Active load balancing to non-preferred CPUs silently f=
ails
- [High] sched/core: TOCTOU race with CPU hotplug breaks task affinity
--

commit dfa0f159ec643e02807bc453bbfcc49c9f1e7915
Author: Shrikanth Hegde <sshegde@linux.ibm.com>

sched/core: Try to use a preferred CPU in is_cpu_allowed

This commit modifies the scheduler to preferentially select preferred CPUs
when checking if a task is allowed to run on a given CPU. It introduces a
helper function to check if a task can migrate to a preferred CPU based on
its affinity mask.

> For the majority of cases, this would still keep select_fallback_rq()
> as O(N). cpumask_intersects_and(), which is O(N), is called only if
> !cpu_preferred. The task running there is expected to move out.
> Subsequently, it should run on a preferred CPU. This becomes O(N**2)
> only for tasks pinned solely to non-preferred CPUs. That is a rare case.

Is this description accurate?

Because the fallback loop iterates over the affinity mask sequentially, if
the allowed preferred CPUs happen to have higher indices than the
non-preferred CPUs, the loop will perform the intersection operation for
every non-preferred CPU it checks. This means any task with preferred CPUs
at higher indices could experience the quadratic latency overhead, rather
than only tasks pinned solely to non-preferred CPUs.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0183c75d7d518..04400f934cc72 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
[ ... ]
> @@ -2504,6 +2504,24 @@ static inline bool rq_has_pinned_tasks(struct rq *=
rq)
>  	return rq->nr_pinned;
>  }
> =20
> +static inline bool task_can_migrate_to_preferred(struct task_struct *p, =
int cpu)
> +{
> +	/* No need to migrate from a preferred CPU */
> +	if (cpu_preferred(cpu))
> +		return false;
> +
> +	/* Only FAIR tasks honor preferred CPU state */
> +	if (unlikely(p->sched_class !=3D &fair_sched_class))
> +		return false;
> +
> +	/* Ignore preferred state if task affinity is changing */
> +	if (unlikely(!cpumask_test_cpu(task_cpu(p), p->cpus_ptr)))
> +		return false;
> +
> +	return cpumask_intersects_and(p->cpus_ptr, cpu_preferred_mask,
> +				      task_cpu_possible_mask(p));
> +}

[Severity: High]
Does this intersection operation lead to quadratic latency during wakeups
when combined with the fallback loop?

When select_task_rq() in kernel/sched/core.c picks a non-preferred CPU
because it is idle, is_cpu_allowed() will reject it, forcing the task into
select_fallback_rq(). The fallback loop iterates sequentially over all CPUs:

kernel/sched/core.c:select_fallback_rq() {
    ...
    for_each_cpu(dest_cpu, p->cpus_ptr) {
        if (!is_cpu_allowed(p, dest_cpu))
            continue;
        ...
        goto out;
    }
    ...
}

If the allowed preferred CPUs are at the end of the cpumask, wouldn't this
perform an intersection for every non-preferred CPU it checks, leading to
severe scheduling latency? Additionally, wouldn't this deterministic loop
always dump the task on the first preferred CPU it finds, destroying load
distribution by clumping tasks on the lowest-ID preferred CPU?

This performance degradation from wakeups on non-preferred CPUs does not
appear to be resolved in the final state of the patch series.

[ ... ]
> @@ -2519,8 +2537,12 @@ static inline bool is_cpu_allowed(struct task_stru=
ct *p, int cpu)
>  		return cpu_online(cpu);
> =20
>  	/* Non kernel threads are not allowed during either online or offline. =
*/
> -	if (!(p->flags & PF_KTHREAD))
> +	if (!(p->flags & PF_KTHREAD)) {
> +		/* Try to use preferred CPU if task's affinity allows */
> +		if (task_can_migrate_to_preferred(p, cpu))
> +			return false;

[Severity: High]
Could returning false for non-preferred CPUs here cause active load
balancing to silently fail?

During routine background load balancing, if the system attempts to pull
load from a preferred CPU to an idle non-preferred CPU, the stopper thread
will run __migrate_task().

kernel/sched/core.c:__migrate_task() {
    ...
    if (!is_cpu_allowed(p, dest_cpu))
        return rq;
    ...
}

Since the destination is non-preferred, won't is_cpu_allowed() reject it,
causing the stopper thread to silently abort the migration and break load
distribution?

While follow-up patches in the series restrict the busiest CPU to preferred
CPUs, they do not appear to prevent the destination from being non-preferre=
d,
leaving this active load balancing path broken.

[Severity: High]
Can this rejection introduce a race condition with CPU hotplug that breaks
a task's user-configured affinity?

In select_fallback_rq() in kernel/sched/core.c, the loop might skip an
active, non-preferred CPU because task_can_migrate_to_preferred() indicates
another preferred CPU is available in the affinity mask. If a concurrent
CPU hotplug operation removes that preferred CPU from the active mask before
the loop reaches it, the loop will skip it too:

kernel/sched/core.c:select_fallback_rq() {
    ...
    for_each_cpu(dest_cpu, p->cpus_ptr) {
        if (!is_cpu_allowed(p, dest_cpu))
            continue;
    ...
}

Could the loop then terminate without finding any allowed CPU, permanently
forcing the task outside of its allowed affinity?

>  		return cpu_active(cpu);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928053728.7975=
39-1-sshegde@linux.ibm.com?part=3D6
