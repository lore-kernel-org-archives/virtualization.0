Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552D73E0090
	for <virtualization@lists.linux.dev>; Fri, 28 Aug 2026 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787913538; cv=pass; b=FjLb8J+il82uEtTbMICFtIvvA1npHWHjldFcWS3kLpy/kfoF0tXNA7NOdBEORDbiWmUI9oWWLLRBWYyUhTt2dIaeh7tyXepMS+F+WAjZyWMBOb/EaX8xVYS24N/gKvo6rpwbSnH4PqJncxn0u5R2OLiiVEWs6Eso2HnoylPfohY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787913538; c=relaxed/simple;
	bh=ZHNPvgcNvjnqAN+85MR7Lyl0b9dDkq4jyaQvoDGUW/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2izxWIQ8FeUmHeuIG9fmXwsYYEw+5uZBCU1J3lkKI4JqJhVBXO8klyT+WLfwXMXFqlyAK/V0bhdZvK7Pf3qvWRgxllch8N/lSLOBUiU56epv77cKaVU3b/iw9iw237gy89+R1O1bi43UIF9bL6rN5JSnRZiVjZhOK/a9ikIIKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WWlf/hkx; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWlf/hkx"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a5f968ada7so1696762a12.0
        for <virtualization@lists.linux.dev>; Fri, 28 Aug 2026 03:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787913534; cv=none;
        d=google.com; s=arc-20260327;
        b=iviHuMHTMKLceyYZtvYT4ip09I582TnUjEDtqgri9LvRfQVp9uI5mLjVvQWGsiAGQ6
         tIdgvm7Tb+c6V1LUVSIkHaknGI+HiRNdznjGFOKWSm06AHBTe6KRjfKuZfdzyC1qRoX2
         bDCSGHMQqz3XDueluGq5NBlc2yEAK4rGdCAJlRJkB9OJyy2XrdpRyNf3qOotgqrKSltl
         YEiOHzT3LetsHE87ckoGaYI/URhcl5TuFmcZFS18ZiqGgfA6M41hv1GfjQZMcP3eIMsw
         Ixqs0izPbJXxax1CV19y4sN+0mR5ZSVvEafaX5bltHlNkPfpiy3bMY+2CTC2W3SAfdbe
         4JFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aSNPU2ja2u72rxkCHAjApXZObqZ59bvTYvEEgnVj1lM=;
        fh=kZqgcveR+Pk366fT8bzBN4NSCcp63rp5VuCPgRIxIbA=;
        b=GWGWTJq+dzmG+AjedsAusNKlRMFQ6GumOYItTZVvzQdrh1Um1PbDhLkzkC8XB+4cHN
         Rcy1NJzjUkLB12IT7WISeDKqo09DTlIgJAtW6yryjRvuYK/jsHgIVmXg0sTcM3jWJMf7
         +V9Isf/xQX3NGCYmXRUIMw0OpWXURMwARzyaFZ03OPe1oj3wWNCO2aPQC1szteQsh4bs
         PnzlbuWOA7IcVb+Lp4bvwqeO0qTLiqWg6r0LYu+K5GE274d3+e8OOQVuhN6QbrDq5lUa
         dykcENX8GBgMV4+/HP0ZN5Onw6W46cj7qsx17aDMBos7Gz1GHawOfVkgi6wfPAKUzJ+o
         q5Bg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787913534; x=1788518334; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aSNPU2ja2u72rxkCHAjApXZObqZ59bvTYvEEgnVj1lM=;
        b=WWlf/hkx4FJjN18kGtp0iSZWYYrnxN2m1h7gVCDoO1CWuT4ZpNlZptHSUMFZc3BBCy
         hzipqtoATsYeMT8ag+bTLH76ZD+LCkmfDhBAV0lzkAWHJXn8i2I78UgPAh3iXaIbm8PM
         5+GQ0m0c0pHUxzq6xkL8BGueT/ntmTji24ER2sAGrGQVLqhFRFpamPXNvSNgt1kC2Bs/
         Fy+gbS+OeSoq/KIkQLKdBvJq9qqKVT4LR+d5LaXG2hAjFWZREpKw4qlhNWdzv7czh0JI
         Hq7r0nPbIY5UYFNOkGLnU/sIYSyXFsuGE3r/3bjHKoQjwkRZDcDNGEKjR4G6wST3g5Gc
         tlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787913534; x=1788518334;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aSNPU2ja2u72rxkCHAjApXZObqZ59bvTYvEEgnVj1lM=;
        b=Vij+KaGoqAq0yQXBYQht8zRJdJmaK3RUdqayVVvExNA6AgwMBup4dTF0Z6le4jl7wN
         SCNu3lzBSY3uO35W0Ku3TvJdZ1Jl9t0lpp3dkiuCDgNf4ifEdYaxw5UgWJfhxvb8qM0o
         6LSw+8375apDjacemX1VBKhFE2s4rUdwOnxeFqkTcjLgEgN4y2H6EiJ/WhYHCI+6viK7
         ypnEFkVG2v8XqjNF1lLmx6f5E1xXcnkC59e2vYLUIQ4bYAc40GgLNqcbEgkKFWn4iqir
         AcKKxgddsDA/NkhMfjmwqYcJZ/J643djnzQuzWIhWqwhlGPkLifutpezRlro1MeQFM18
         UP6w==
X-Forwarded-Encrypted: i=1; AHgh+RqYcgfjDiS7UH4ImmvJE3tUH43pUw3n8M27vL8cyAEe3YPL97PdvHvECpEXurlphqhDECkAXsOrHzkTtrKPRA==@lists.linux.dev
X-Gm-Message-State: AFuF++k+Zsba7QuTLmHCHspPjJa2dXEX2n/Q+t6tQjKH0arlHb7OFhUz
	h4IwJITSXU8jyM9gam6RG5KherFfUdsBC6oQXVPZmrcPl1dS80zXcOMhWekwU+OYWIOiInfn8A+
	ZjYViRv2nOOCIbnJKpi7TDcs5B9sdtn0daMO37h4QuA==
X-Gm-Gg: AR+sD13YUG9lmdKiXontO4OlPmnEl0wmYA42dAnJa1A2Gdp/L4BTur847bLVWe0y0L4
	ijwUfiQqLPYbckTyRMAdDYRlTG5eVYYGmiLuwWHfzw/nlmt7pw1ZwVPFuAKf7aAK+489LXAz2la
	gdqpj419megc1XDAgSAeJgW9S7siXIzC97EnR1t0uPiOiWGhRPQkqijDs8qt37VMZHorK9CPn7E
	AdIOJrYJm6hHaoG8D/g7+pmHaWHv4OP5C28wogdlDSLiTYjUD6tjkKD/Z/v6i90tgwDkcXExbCS
	dedaRvARDStdcDcmPI9nyxlcMNtVg0nGMjjp0flWBQ/aE0llG4h0vOf3qGLw7TlZzZxA0+NEcrN
	xaw==
X-Received: by 2002:a05:6402:52d0:b0:697:eb97:a4ed with SMTP id
 4fb4d7f45d1cf-6a60c5ab04dmr3838875a12.7.1787913534540; Fri, 28 Aug 2026
 03:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260825103855.721013-1-sshegde@linux.ibm.com>
 <20260825103855.721013-6-sshegde@linux.ibm.com> <8262d2f9-9f2f-4821-8497-991d7c8448a3@arm.com>
In-Reply-To: <8262d2f9-9f2f-4821-8497-991d7c8448a3@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 28 Aug 2026 12:38:41 +0200
X-Gm-Features: AcwNN1VRBsyVPI-p9UXzNMfWcn7VLGiTkR-yO7pmCmFXXcSrsOwzowtaWwf6M1s
Message-ID: <CAKfTPtB27-eFXGG9GcXdm4=YLZy6-vQMAQqoCbHa5xZxA3YBpw@mail.gmail.com>
Subject: Re: [PATCH v11 05/12] sched/core: Try to use a preferred CPU in is_cpu_allowed
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	peterz@infradead.org, juri.lelli@redhat.com, yury.norov@gmail.com, 
	kprateek.nayak@amd.com, iii@linux.ibm.com, corbet@lwn.net, 
	meted@linux.ibm.com, ynorov@nvidia.com, tglx@kernel.org, 
	gregkh@linuxfoundation.org, pbonzini@redhat.com, seanjc@google.com, 
	vschneid@redhat.com, huschle@linux.ibm.com, rostedt@goodmis.org, 
	maddy@linux.ibm.com, srikar@linux.ibm.com, hdanton@sina.com, 
	chleroy@kernel.org, vineeth@bitbyteword.org, frederic@kernel.org, 
	arighi@nvidia.com, pauld@redhat.com, christian.loehle@arm.com, tj@kernel.org, 
	tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org, 
	rdunlap@infradead.org, kernellwp@gmail.com, linux-doc@vger.kernel.org, 
	jgross@suse.com, virtualization@lists.linux.dev, sunlightlinux@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Aug 2026 at 09:51, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 25.08.26 12:38, Shrikanth Hegde wrote:
> > When possible, try to choose a preferred CPU.
> >
> > This is essential to maintain user affinities when preferred
> > CPUs change. A task pinned on a non-preferred CPU should continue
> > to run there, since this is a non-user triggered event.
> >
> > If a CPU is non-preferred and the task can run on other CPUs which are
> > currently preferred, then choose a preferred CPU instead.
> > This is decided by checking if cpus_ptr and cpu_preferred_mask
> > intersect or not. If yes, then the task has other preferred CPUs.
> >
> > The push task mechanism uses a stopper thread which calls
> > select_fallback_rq() and uses this mechanism to pick a preferred CPU.
> >
> > This takes care of the wakeup path for FAIR tasks too.
> > is_cpu_allowed() is called to ensure wakeups happen on preferred CPUs.
> > With that, additional checks in available_idle_cpu() are not necessary.
> >
> > Ignore the preferred CPU state if a task's affinity is changing and
> > its new mask no longer includes the CPU it is currently running on.
> > This ensures migration_cpu_stop() does not abort, preventing the task
> > from being stranded outside its allowed affinity.
> >
> > Account for tasks with architecture-specific CPU masks
> > (e.g., 32-bit tasks on arm64). For such tasks, explicitly check against
> > the arch-allowed CPUs to determine if any of the preferred CPUs are
> > actually valid.
> >
> > For the majority of cases, this would still keep select_fallback_rq()
> > as O(N). cpumask_intersects(), which is O(N), is called only if
> > !cpu_preferred. The task running there is expected to move out.
> > Subsequently, it should run on a preferred CPU. This becomes O(N**2)
> > only for tasks pinned solely to non-preferred CPUs. That is a rare case.
> >
> > Overhead is minimal when the CPU is preferred.
> >
> > Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> > ---
> >  kernel/sched/core.c | 41 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 39 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index a45f7c308329..f71317fe281d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2494,6 +2494,35 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
> >       return rq->nr_pinned;
> >  }
> >
> > +static inline bool task_can_sched_on_preferred(int cpu, struct task_struct *p)
> > +{
> > +     const struct cpumask *valid_mask;
> > +     int i;
> > +
> > +     if (cpu_preferred(cpu))
> > +             return false;
> > +
> > +     /* Only FAIR tasks honor preferred CPU state */
> > +     if (unlikely(p->sched_class != &fair_sched_class))
> > +             return false;
> > +
> > +     /* Ignore preferred state if task affinity is changing */
> > +     if (unlikely(!cpumask_test_cpu(task_cpu(p), p->cpus_ptr)))
> > +             return false;
> > +
> > +     valid_mask = task_cpu_possible_mask(p);
> > +     if (likely(valid_mask == cpu_possible_mask))
> > +             return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
> > +
> > +     /* Tasks with arch-specific CPU masks. e.g. 32-bit tasks on arm64. */
> > +     for_each_cpu_and(i, p->cpus_ptr, cpu_preferred_mask) {
> > +             if (cpumask_test_cpu(i, valid_mask))
> > +                     return true;
> > +     }
>
> Looking more into this, there might be a window in 64-32-bit execve()
> for 32bit EL0 tasks on Arm64 (w/ allow_mismatched_32bit_el0 command line
> option).
>
> The time before arch_setup_new_exec() calls
> force_compatible_cpus_allowed_ptr() to restrict CPU affinity for those
> tasks.
>
> Let me run more test on this ...
>
> Why not simply:
>
> - return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
> + return cpumask_first_and_and(p->cpus_ptr, cpu_preferred_mask,
> +                              task_cpu_possible_mask(p)) < nr_cpu_ids;

+1
This is the best way to check that there is a valid cpu

>
> IMHO, you want to know whether there is at least one CPU that belongs to
> all three CPU masks?
>
> [...]
