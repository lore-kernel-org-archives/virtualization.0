Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE0B453A54;
	Fri, 25 Sep 2026 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322608; cv=none; b=nluegcE9Z5/1zwnvY7hAeShpqcOFyCLDr0oX97UKEyVcrzEJ3pvuXR16HO3TFucdSqEL+pUe3DMHzNhiLmVfI6xEmKdUytUvOT3PtQvqB/r4ULmAzvXoZzFROSSSf+BbEYI45PO2UzGrYgvzf93Alg09YVVgW7BZPF1cW0mPizM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322608; c=relaxed/simple;
	bh=jzKi0jRt9cauVGk6fvzC3PhVlMI87uyvXvGpAVe7xhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFmsTriz3dU08PYoquGB5e0nI3Fm+hhIoKq/NsWXvkVE2my0ReiNefjS9np2FC9zyhiLFnVusHsFFwi1qaIE5tYdHGEZgJxFzH9VOHzre70dy3mKcs8jT51qU1kqYuKJGD1PPkFQKEmJ1tTnSKm3sPPLakUfy9n8D0L5k9kqKOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ood8IM7h; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ood8IM7h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SI/MwWqv4yxwHThYUWRmZ7a1tSIE2B84HOyuWakguyc=; b=Ood8IM7h5ph/AwvDMkaS9J34EC
	+PxRHmWDSZbE5uy/Sn4DCRnJKLphzFrUXG5/iktrtgYq3ZavQ20IOKosd5LoLLcGGb31eZkv3+rbH
	oWpSo9k16qh59gj70Jc4PO1Np6Fy4LXY8v7v4g2CN1A/LTuEy4pV3in7K1lW+6dp50S0fqYxKA9RJ
	vQzip1t3QdOVFl6XairtlvX+1UNc+R13eXC2t6igAwNEsTerFuZxr0vfTsiSNak1QSQ5cf0yJ5LLG
	VnZfJZM0pGiWVhn1Z1F2QJ4WSlVF+RgFJ92SYEy/rzLn0BRmu5HbZLFtLOsu3t0OIIMnX44MKrRS/
	W8+th5eA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xA0gs-0000000Gi6A-3pkQ;
	Fri, 25 Sep 2026 07:49:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7115530070F; Fri, 25 Sep 2026 09:49:53 +0200 (CEST)
Date: Fri, 25 Sep 2026 09:49:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, yury.norov@gmail.com,
	kprateek.nayak@amd.com, iii@linux.ibm.com, corbet@lwn.net,
	meted@linux.ibm.com, ynorov@nvidia.com, tglx@kernel.org,
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
Subject: Re: [PATCH v13 08/13] sched/core: Push current task from non
 preferred CPU
Message-ID: <20260925074953.GG4121339@noisy.programming.kicks-ass.net>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-9-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909135617.871006-9-sshegde@linux.ibm.com>

On Wed, Sep 09, 2026 at 07:26:12PM +0530, Shrikanth Hegde wrote:
> Actively push out the current running task on a non-preferred CPU. Since
> the task is currently running, a stopper thread must be queued to push the
> task out. However, if the task is pinned only to non-preferred CPUs,
> it will continue running there. This helps to maintain userspace
> affinities, unlike CPU hotplug or isolated cpusets.
> 
> Though the code is similar to __balance_push_cpu_stop and quite close to
> push_cpu_stop, it is kept separate as it provides a cleaner
> implementation specifically for CONFIG_PREFERRED_CPU.

I would have preferred the code looking more like
__balance_push_cpu_stop(). Now you're written more or less the same, but
visually different for no reason. This makes comparing them unnecessarily
hard.

> Add the npc_push_work_pending flag to protect the work buffer.

I can't help but read NPC as Non-Playing-Character. Too much RPGs, and
that ain't Rocket Propelled Grenades. TLA are such fun :-)


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
> +			rq->npc_push_work_pending = false;
> +		put_task_struct(p);
> +		return 0;
> +	}
> +
> +	raw_spin_lock_irq(&p->pi_lock);
> +
> +	/*
> +	 * select_fallback_rq() may acquire the rq lock in case of fallback.
> +	 * So call it before grabbing rq lock. If the task migrates to
> +	 * another CPU before the rq lock is acquired, subsequent validation
> +	 * of task's current rq will help to safely bail out.
> +	 */
> +	cpu = select_fallback_rq(rq->cpu, p);
> +	rq_lock(rq, &rf);
> +	rq->npc_push_work_pending = false;
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

Anyway, I ended up with:

  static int sched_non_preferred_cpu_push_stop(void *arg)
  {
	  struct task_struct *p = arg;
	  struct rq *rq = this_rq();
	  struct rq_flags rf;
	  int cpu;

	  if (cpu_preferred(rq->cpu)) {
		  scoped_guard (rq_lock_irqsave, rq)
			  rq->npc_push_work_pending = false;
		  put_task_struct(p);
		  return 0;
	  }

	  scoped_guard (raw_spinlock_irq, &p->pi_lock) {
		  /*
		   * select_fallback_rq() may acquire the rq lock in case of
		   * fallback. So call it before grabbing rq lock. If the task
		   * migrates to another CPU before the rq lock is acquired,
		   * subsequent validation of task's current rq will help to
		   * safely bail out.
		   */
		  cpu = select_fallback_rq(rq->cpu, p);

		  rq_lock(rq, &rf);
		  rq->npc_push_work_pending = false;
		  update_rq_clock(rq);

		  context_unsafe_alias(rq);

		  if (task_rq(p) == rq && task_on_rq_queued(p) &&
		      !is_migration_disabled(p))
			  rq = __migrate_task(rq, &rf, p, cpu);
		  rq_unlock(rq, &rf);
	  }

	  put_task_struct(p);

	  return 0;
  }

And note how you have an extra !is_migration_disabled() vs
__balance_push_cpu_stop(). Either yours is superfluous or
__balance_push_cpu_stop() should have one. Which is it?


