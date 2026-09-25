Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE04936DA1A;
	Fri, 25 Sep 2026 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351158; cv=none; b=AC5FSTtgkELd0PZdPwD8gZNYKiwu4yQob7DWp5R8HhNTAzx1N1imLJcovOUK2tvpoivKtxj/RdSWrCq1EDfbfaYSVrX2Rq7UyHvBfgjrY8Hy1PmcXsKdq60hnimKIq04GykLH0V+P/kTKDgy9Xutd+vrJXj5peNJee6OMASL8lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351158; c=relaxed/simple;
	bh=K3bjdFYcfad2nFRfPY3Jg7b1aHiF3P7SNg113OptxqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT4AcOxtTA8JtoxOPYq0axu2/iNMAi7cZrhYIFuwsORGITvzMhKUtrmVoFMAVRKxaXVnIhZ9yPRfK0JX8wXwBtjuJDTxcpEaRYKy1DZauMubs7dotHSBO7TAy1VtCDC+TqTBV+4DD/QF+4CHW8CVgjMV0sw5hDwJ4mojlfWhBCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ao2r0nz+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ao2r0nz+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PqXWbcNl+6FM3P1VEZ3iGff49q9FfaKNbR1+IWpSZts=; b=Ao2r0nz+hqO2tNwaYqwNl9Q1iH
	My4C0ts3tyIpZO4kBQl9elEsMstronbAH6BEFR6XJnAsir0zHDqRfaH51I7JdKrhIQ1nn+ydTlDXx
	m3J78WEA6DorlQOl0D2KiL9nT4DUfHI8OgEc5JvzNfcSUVtJMqQxIeIBykcNIb2it10Xa620q000Q
	yn5mhk399tET3nKM3ttk4P667SfTc/DcCDO5lyA2ot6ORtGr8uIYYH0FvFs1jTsPu18th3VocYaaQ
	IDnw8WulC7g2e0kIEOw9zHgBwIiBXy3Sl/kvKGlPcLLBdwc+yU53+t+VCDOa5MSVMNVPj1OtzoN9V
	OeXysxgw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA87K-000000089cr-01bs;
	Fri, 25 Sep 2026 15:45:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E6E2E300754; Fri, 25 Sep 2026 17:45:40 +0200 (CEST)
Date: Fri, 25 Sep 2026 17:45:40 +0200
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
Subject: Re: [PATCH v13 09/13] sched/debug: Add migration stats due to non
 preferred CPUs
Message-ID: <20260925154540.GO2009045@noisy.programming.kicks-ass.net>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-10-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909135617.871006-10-sshegde@linux.ibm.com>

On Wed, Sep 09, 2026 at 07:26:13PM +0530, Shrikanth Hegde wrote:
> Add a new stat,
> - nr_migrations_cpu_non_preferred: number of migrations happened since
>   a CPU was marked as non preferred due to high steal time.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  include/linux/sched.h | 1 +
>  kernel/sched/core.c   | 9 +++++++--
>  kernel/sched/debug.c  | 1 +
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d7cc77181ef9..48639b0c75d0 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -554,6 +554,7 @@ struct sched_statistics {
>  	u64				nr_failed_migrations_running;
>  	u64				nr_failed_migrations_hot;
>  	u64				nr_forced_migrations;
> +	u64				nr_migrations_cpu_non_preferred;
>  
>  	u64				nr_wakeups;
>  	u64				nr_wakeups_sync;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 458b8c6fd9af..fb8404bd47e2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -11239,8 +11239,13 @@ static int sched_non_preferred_cpu_push_stop(void *arg)
>  	context_unsafe_alias(rq);
>  
>  	if (task_rq(p) == rq && task_on_rq_queued(p) &&
> -	    !is_migration_disabled(p))
> -		rq = __migrate_task(rq, &rf, p, cpu);
> +	    !is_migration_disabled(p)) {
> +		struct rq *dest_rq = __migrate_task(rq, &rf, p, cpu);
> +
> +		if (rq != dest_rq)
> +			schedstat_inc(p->stats.nr_migrations_cpu_non_preferred);
> +		rq = dest_rq;
> +	}
>  
>  	rq_unlock(rq, &rf);
>  	raw_spin_unlock_irq(&p->pi_lock);
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index fda10b3fa249..e6a3b516c703 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -1440,6 +1440,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>  		P_SCHEDSTAT(nr_failed_migrations_running);
>  		P_SCHEDSTAT(nr_failed_migrations_hot);
>  		P_SCHEDSTAT(nr_forced_migrations);
> +		P_SCHEDSTAT(nr_migrations_cpu_non_preferred);
>  		P_SCHEDSTAT(nr_wakeups);
>  		P_SCHEDSTAT(nr_wakeups_sync);
>  		P_SCHEDSTAT(nr_wakeups_migrate);

Should we not also bump the schedstat version? I forgot the rules, but
you do change the output. And did we ever merge that perf schedstat
thing, then that probably needs 'fixing' for the new format too.
