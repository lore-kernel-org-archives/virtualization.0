Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B8133BBB9;
	Fri,  5 Dec 2025 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764950641; cv=none; b=FXDTtrsiQOmdK9CkxYQbjNjumV3WwRkOI5hEVsyDkPH4z9XAgaBvwwvYe8ndVcdP0hBrQUHZYmuApY+Spu94uS+7YK1mUZV0wYTpQctKf/y41Jxoy5f/9n+W5xPlFzS7XxnvxZnvruqE4JNl9AVjD6je0NGuiogg0xhQ0OBdPGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764950641; c=relaxed/simple;
	bh=gEd0V53tfMvSwrHH2qnp3JUqg2ZEZToqGQ87g561X78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sB4PWEydqRWAhLlZSoTIDecvDLEVOAZE2iJtvLxSUPV+caFi7FdrGBYTGH5Dfv1kNlETHxTsZhSaxwteZlCMYnjX1RzKA3LlZ76sJU/82XIGhf5sfSqVCOCDs7cY807vuMzYPtWd+jzKEJ7nvvaQ+jVOdripOr48iQVxb5jREpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XZT8TMJL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XZT8TMJL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O2XwwJOH6ID2KTGfUPig7IAOjY7ik8syIuFJLCrFZsM=; b=XZT8TMJLJlodKVHuJqbR8fDWBb
	wmDBIUFBCQLzqfbfdnqTkJIuhgpGH2enuLja4p45aH+xSleZBwjjTePR3hejPKpQacwaZS37DzG3P
	VLyWXI6bgG2FY2KRybG6Z4IWQslyQX0CSGLlqdY3c9mXk6raOpsEuAL1v59tglQ2OKAt4ABe7iSlO
	oc5k1e5mjcY1lcYct/OOu9/oI3M8cuTqciEC1E3tXfK2dC65okBPjd8TU7u885fj6l4+I0z+6l/KM
	iv1UiZJyKvzLtm5RSGBkg2Jh3HJAneUjCuTaPMharkDFNrCNcvycNr3mIhO7ngMlkAbSEnjbR2xSd
	GiDVtexg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRYHH-00000005uqU-34rg;
	Fri, 05 Dec 2025 16:03:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9CE533003C4; Fri, 05 Dec 2025 17:03:26 +0100 (CET)
Date: Fri, 5 Dec 2025 17:03:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Ben Segall <bsegall@google.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Thomas Huth <thuth@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	virtualization@lists.linux.dev,
	Yicong Yang <yangyicong@hisilicon.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH 08/17] sched/core: Implement CPU soft offline/online
Message-ID: <20251205160326.GF2528459@noisy.programming.kicks-ass.net>
References: <20251204175405.1511340-1-srikar@linux.ibm.com>
 <20251204175405.1511340-9-srikar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204175405.1511340-9-srikar@linux.ibm.com>

On Thu, Dec 04, 2025 at 11:23:56PM +0530, Srikar Dronamraju wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 89efff1e1ead..f66fd1e925b0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8177,13 +8177,16 @@ static void balance_push(struct rq *rq)
>  	 * Only active while going offline and when invoked on the outgoing
>  	 * CPU.
>  	 */
> -	if (!cpu_dying(rq->cpu) || rq != this_rq())
> +	if (cpu_active(rq->cpu) || rq != this_rq())
>  		return;
>  
>  	/*
> -	 * Ensure the thing is persistent until balance_push_set(.on = false);
> +	 * Unless soft-offline, Ensure the thing is persistent until
> +	 * balance_push_set(.on = false); In case of soft-offline, just
> +	 * enough to push current non-pinned tasks out.
>  	 */
> -	rq->balance_callback = &balance_push_callback;
> +	if (cpu_dying(rq->cpu) || rq->nr_running)
> +		rq->balance_callback = &balance_push_callback;
>  
>  	/*
>  	 * Both the cpu-hotplug and stop task are in this case and are
> @@ -8392,6 +8395,8 @@ static inline void sched_smt_present_dec(int cpu)
>  #endif
>  }
>  
> +static struct cpumask cpu_softoffline_mask;
> +
>  int sched_cpu_activate(unsigned int cpu)
>  {
>  	struct rq *rq = cpu_rq(cpu);
> @@ -8411,7 +8416,10 @@ int sched_cpu_activate(unsigned int cpu)
>  	if (sched_smp_initialized) {
>  		sched_update_numa(cpu, true);
>  		sched_domains_numa_masks_set(cpu);
> -		cpuset_cpu_active();
> +
> +		/* For CPU soft-offline, dont need to rebuild sched-domains */
> +		if (!cpumask_test_cpu(cpu, &cpu_softoffline_mask))
> +			cpuset_cpu_active();
>  	}
>  
>  	scx_rq_activate(rq);
> @@ -8485,7 +8493,11 @@ int sched_cpu_deactivate(unsigned int cpu)
>  		return 0;
>  
>  	sched_update_numa(cpu, false);
> -	cpuset_cpu_inactive(cpu);
> +
> +	/* For CPU soft-offline, dont need to rebuild sched-domains */
> +	if (!cpumask_test_cpu(cpu, &cpu_softoffline_mask))
> +		cpuset_cpu_inactive(cpu);
> +
>  	sched_domains_numa_masks_clear(cpu);
>  	return 0;
>  }
> @@ -10928,3 +10940,25 @@ void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx)
>  		set_next_task(rq, ctx->p);
>  }
>  #endif /* CONFIG_SCHED_CLASS_EXT */
> +
> +void set_cpu_softoffline(int cpu, bool soft_offline)
> +{
> +	struct sched_domain *sd;
> +
> +	if (!cpu_online(cpu))
> +		return;
> +
> +	cpumask_set_cpu(cpu, &cpu_softoffline_mask);
> +
> +	rcu_read_lock();
> +	for_each_domain(cpu, sd)
> +		update_group_capacity(sd, cpu);
> +	rcu_read_unlock();
> +
> +	if (soft_offline)
> +		sched_cpu_deactivate(cpu);
> +	else
> +		sched_cpu_activate(cpu);
> +
> +	cpumask_clear_cpu(cpu, &cpu_softoffline_mask);
> +}

What happens if you then offline one of these softoffline CPUs? Doesn't
that do sched_cpu_deactivate() again?

Also, the way this seems to use softoffline_mask is as a hidden argument
to sched_cpu_{de,}activate() instead of as an actual mask.

Moreover, there does not seem to be any sort of serialization vs
concurrent set_cpu_softoffline() callers. At the very least
update_group_capacity() would end up with indeterminate results.

This all doesn't look 'robust'.
