Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBB73C3F44
	for <virtualization@lists.linux.dev>; Fri, 28 Aug 2026 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903516; cv=none; b=Bb3VoIZZBw9N1nONlleEIUsIcGndDYHmq2d3XzkCI/DnWUU1J6IpypCNopSJgo60PHB5S2Arduq+AOhy0Nyn7X2Y2VCKERj5pkn7a3wcpgBsLlkKe8QXBIXNOjhHobUV9IoQq2dkCVKdLsmyx2MawoQqdxyhfuxnJqAOrQzdH9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903516; c=relaxed/simple;
	bh=/r42OzRKbehNytUbS0AlwvQqha8Fg7tNiKCBIbEVdb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5Cc2q3hoyvpoM/YsShtz5hkyeKlGrYrgl2j8bPDp8HVB+Geas8ceJiayw2Jsqpv3OYO+5jhK6GVxqxfCJQOZnfhJiEZPNDUtQeFLJpAHnlershOk9xdL6edUACMhYl6m4MReclWDNm6HBhK1/Cgj3RERQwjBmNr1Wu5T+e/8l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qyRs1slP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qyRs1slP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF1BD1516;
	Fri, 28 Aug 2026 00:51:49 -0700 (PDT)
Received: from [192.168.178.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE5183F7D8;
	Fri, 28 Aug 2026 00:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787903513; bh=/r42OzRKbehNytUbS0AlwvQqha8Fg7tNiKCBIbEVdb4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qyRs1slPyzy4qtN6fU37FQs+l+H3jAYpbcC2h3UtcVrvo5z3SjmO2VTAOAEJZq2pq
	 sHFeMdQE0ndRCz4WEiemVcxCS+ga6h2GvUQYZ96jeNg/pJWgoneG18bdCG72uzzOxG
	 guo214JrPJiRPBGaqWZv8B5+sDYd7e9nwQUPLyqo=
Message-ID: <8262d2f9-9f2f-4821-8497-991d7c8448a3@arm.com>
Date: Fri, 28 Aug 2026 09:51:47 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/12] sched/core: Try to use a preferred CPU in
 is_cpu_allowed
To: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
 mingo@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, yury.norov@gmail.com, kprateek.nayak@amd.com,
 iii@linux.ibm.com, corbet@lwn.net, meted@linux.ibm.com, ynorov@nvidia.com
Cc: tglx@kernel.org, gregkh@linuxfoundation.org, pbonzini@redhat.com,
 seanjc@google.com, vschneid@redhat.com, huschle@linux.ibm.com,
 rostedt@goodmis.org, maddy@linux.ibm.com, srikar@linux.ibm.com,
 hdanton@sina.com, chleroy@kernel.org, vineeth@bitbyteword.org,
 frederic@kernel.org, arighi@nvidia.com, pauld@redhat.com,
 christian.loehle@arm.com, tj@kernel.org, tommaso.cucinotta@gmail.com,
 maz@kernel.org, rafael@kernel.org, rdunlap@infradead.org,
 kernellwp@gmail.com, linux-doc@vger.kernel.org, jgross@suse.com,
 virtualization@lists.linux.dev, sunlightlinux@gmail.com
References: <20260825103855.721013-1-sshegde@linux.ibm.com>
 <20260825103855.721013-6-sshegde@linux.ibm.com>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20260825103855.721013-6-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.08.26 12:38, Shrikanth Hegde wrote:
> When possible, try to choose a preferred CPU.
> 
> This is essential to maintain user affinities when preferred
> CPUs change. A task pinned on a non-preferred CPU should continue
> to run there, since this is a non-user triggered event.
> 
> If a CPU is non-preferred and the task can run on other CPUs which are
> currently preferred, then choose a preferred CPU instead.
> This is decided by checking if cpus_ptr and cpu_preferred_mask
> intersect or not. If yes, then the task has other preferred CPUs.
> 
> The push task mechanism uses a stopper thread which calls
> select_fallback_rq() and uses this mechanism to pick a preferred CPU.
> 
> This takes care of the wakeup path for FAIR tasks too.
> is_cpu_allowed() is called to ensure wakeups happen on preferred CPUs.
> With that, additional checks in available_idle_cpu() are not necessary.
> 
> Ignore the preferred CPU state if a task's affinity is changing and
> its new mask no longer includes the CPU it is currently running on.
> This ensures migration_cpu_stop() does not abort, preventing the task
> from being stranded outside its allowed affinity.
> 
> Account for tasks with architecture-specific CPU masks
> (e.g., 32-bit tasks on arm64). For such tasks, explicitly check against
> the arch-allowed CPUs to determine if any of the preferred CPUs are
> actually valid.
> 
> For the majority of cases, this would still keep select_fallback_rq()
> as O(N). cpumask_intersects(), which is O(N), is called only if
> !cpu_preferred. The task running there is expected to move out.
> Subsequently, it should run on a preferred CPU. This becomes O(N**2)
> only for tasks pinned solely to non-preferred CPUs. That is a rare case.
> 
> Overhead is minimal when the CPU is preferred.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  kernel/sched/core.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a45f7c308329..f71317fe281d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2494,6 +2494,35 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
>  	return rq->nr_pinned;
>  }
>  
> +static inline bool task_can_sched_on_preferred(int cpu, struct task_struct *p)
> +{
> +	const struct cpumask *valid_mask;
> +	int i;
> +
> +	if (cpu_preferred(cpu))
> +		return false;
> +
> +	/* Only FAIR tasks honor preferred CPU state */
> +	if (unlikely(p->sched_class != &fair_sched_class))
> +		return false;
> +
> +	/* Ignore preferred state if task affinity is changing */
> +	if (unlikely(!cpumask_test_cpu(task_cpu(p), p->cpus_ptr)))
> +		return false;
> +
> +	valid_mask = task_cpu_possible_mask(p);
> +	if (likely(valid_mask == cpu_possible_mask))
> +		return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
> +
> +	/* Tasks with arch-specific CPU masks. e.g. 32-bit tasks on arm64. */
> +	for_each_cpu_and(i, p->cpus_ptr, cpu_preferred_mask) {
> +		if (cpumask_test_cpu(i, valid_mask))
> +			return true;
> +	}

Looking more into this, there might be a window in 64-32-bit execve()
for 32bit EL0 tasks on Arm64 (w/ allow_mismatched_32bit_el0 command line
option).

The time before arch_setup_new_exec() calls
force_compatible_cpus_allowed_ptr() to restrict CPU affinity for those
tasks.

Let me run more test on this ...

Why not simply:

- return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
+ return cpumask_first_and_and(p->cpus_ptr, cpu_preferred_mask,
+                              task_cpu_possible_mask(p)) < nr_cpu_ids;

IMHO, you want to know whether there is at least one CPU that belongs to
all three CPU masks?

[...]
