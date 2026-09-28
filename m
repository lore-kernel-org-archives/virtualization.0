Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D393128A3
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574987; cv=none; b=q8MPkI/fEFTM3MAkwlFIxx/dbb1ZtjdeQodFb/ohFe9wRjy8OFQamlcyB+iu32Mk1mUbcWOJiRcYRhTu+MMdNYjiEqq173sxl14DQvfEySFecQl9U1z2ubwl+GEG6l1YhlKyZ5XWEGvbG251NKjPp+wEq09HMCSpe7stGEhIHpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574987; c=relaxed/simple;
	bh=21X8BRtgZjdbTHAjAfR15BAzeVZHK3XXLc87Erd1dic=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E6Bl40u23Sjn5OAk8eoRvpyKyT5KuKoZcfLNJnD7wfXxNKcextEQeFt9QB0xTvaul6N32ZavqZDCWdUXi5RvqICcK1Gt8ECDUWS6IK0YDbpZ7lznLe8isCX7K4p10ITNz9+7rs+EgpU+vOO6j0kpXFuj7yfT9mFcL3KE5Gfz9LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HM1RBEE2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HM1RBEE2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4681F000FF;
	Mon, 28 Sep 2026 05:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574986;
	bh=5GLMKaJx2cGccb6cUgZLjwYQC/H//1rxMbBFZllTcxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HM1RBEE2/s8NmOcrldeYrxPUcsFeGj/tTuFfQLC7i/DwG9QaSuzL2O7ma0qxYFO8L
	 5Ux+1jvlcMpPti+hj2HCV3bdsF8DyrQDG2LK+FReh/hOl0s13fSHBjYBiY+Y19HZOF
	 0XyTVlW63EqjrYlBEn/UewvSlD9n2HHKkK1LLXb+Ji63Z7WndbxIzGXnNNWxcb62BD
	 Dw/7nG3GsbqCsY32ucYdZzt923HC0YDsx4INOa7q7qJXzbESY17SH0uiPIor1JWfDY
	 RxFfCW5nY4taxA7+tTwOxtS6rQOhybcJLOrOo6SKawDp9NBp19qXTzsvGCKMDbtgdM
	 Q7A6nC8BkpiNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 08/13] sched/core: Push current task from non
 preferred CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260928053728.797539-9-sshegde@linux.ibm.com>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-9-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 05:56:25 +0000
Message-Id: <20260928055626.2C4681F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] sched/core: FAIR kthreads cause stopper thread livelock on non-pre=
ferred CPUs
--

commit a6718dc77694942ae8b63a9eb25ace9c01b3c5ef
Author: Shrikanth Hegde <sshegde@linux.ibm.com>

sched/core: Push current task from non preferred CPU

This patch actively pushes the currently running task off a non-preferred
CPU using a stopper thread, specifically targeting tasks in the FAIR
scheduling class. It adds the npc_push_work_pending flag to avoid queueing
multiple stopper threads.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
[ ... ]
> +static int sched_non_preferred_cpu_push_stop(void *arg)
> +{
> +	struct task_struct *p =3D arg;
> +	struct rq *rq =3D this_rq();
> +	struct rq_flags rf;
> +	int cpu;
> +
> +	if (cpu_preferred(rq->cpu)) {
> +		scoped_guard(rq_lock_irqsave, rq)
> +			rq->npc_push_work_pending =3D false;
> +		put_task_struct(p);
> +		return 0;
> +	}
> +
> +	scoped_guard (raw_spinlock_irq, &p->pi_lock) {
> +		/*
> +		 * select_fallback_rq() may acquire the rq lock in case of
> +		 * fallback. So call it before grabbing rq lock. If the task
> +		 * migrates to another CPU before the rq lock is acquired,
> +		 * subsequent validation of task's current rq will help to
> +		 * safely bail out.
> +		 */
> +		cpu =3D select_fallback_rq(rq->cpu, p);
[ ... ]
> +void sched_push_current_non_preferred_cpu(struct rq *rq)
> +{
> +	struct task_struct *push_task =3D rq->curr;
> +
> +	scoped_guard(rq_lock, rq) {
> +		/* Push the task if its explicit affinity allows */
> +		if (!task_can_migrate_to_preferred(push_task, rq->cpu))
> +			return;

[Severity: High]
Can this result in a livelock with endless stopper thread preemptions when
the task being pushed is a FAIR kthread (such as an unbound kworker)?

When task_can_migrate_to_preferred() returns true for a FAIR kthread,
this function successfully queues a stopper thread. However, when the
stopper thread runs sched_non_preferred_cpu_push_stop() and calls
select_fallback_rq(), it ultimately evaluates is_cpu_allowed(), which
skips the preferred-CPU check for kthreads:

kernel/sched/core.c:is_cpu_allowed() {
    ...
    /* Non kernel threads are not allowed during either online or offline. =
*/
    if (!(p->flags & PF_KTHREAD)) {
        /* Try to use preferred CPU if task's affinity allows */
        if (task_can_migrate_to_preferred(p, cpu))
            return false;
        return cpu_active(cpu);
    }
    ...
}

Because the kthread bypasses the preferred-CPU enforcement,
select_fallback_rq() can pick the first online CPU in the local node,
which might be the exact same non-preferred CPU we are trying to push it
away from.

If that happens, the migration becomes a no-op, npc_push_work_pending gets
cleared, and sched_tick() will just restart the same sequence on the next
tick, wasting CPU cycles in an endless loop.

> +
> +		/* There is already a stopper thread. Don't race with it. */
> +		if (rq->npc_push_work_pending)
> +			return;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928053728.7975=
39-1-sshegde@linux.ibm.com?part=3D8
