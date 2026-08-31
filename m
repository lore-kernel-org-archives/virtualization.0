Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF724A99D1
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188999; cv=pass; b=RNgD7Ifoa7tYTnKspA5VNLtuN/v2rFifUZPyRiAthyIeT/gEkbhlYeT2k/iu1jxfXc/LuW42E8hIq6hErbfmvPb/3FdrWcwg8nTW/v3ZDKLFTsSO5K9HrbJHbSvOjr4OQ0cZSNFPW7yce+F+hMI/R9f6tDPAXns7mOVWD4h5oNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188999; c=relaxed/simple;
	bh=EvAXVNP9yVBqvEJz1b62aPEGqoOpJmPXDM4IPy03jPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqvQsumh9fKrxrodbzdO/8J5i859RXXXOC7UJ3A95AxFwftmIJ8abhnN2ht3ddeGNuP7yi37AEGocE9n+sCBOUgn2EdFTBt5yMu5ncbNmrDnwkVFNQl/OFu3EXjV7WwSx7nv/053ROjtEGiYUHMLbk79+TLVoMEGBHr0G87eVlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aL4LtIV2; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aL4LtIV2"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a0c8283146so5628380a12.0
        for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 08:09:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788188995; cv=none;
        d=google.com; s=arc-20260327;
        b=qZmG9Gt6iUQlvSvgdItpDu0CD0rd1PEJW2JZ7nUvuGOqAw196fF88bnd3XcwWPooyn
         RMtybG5PS2GO+vjM45kbkszs+9vsemsE8R8mO9xwcAoa5TRqozSwvRzdnOJeiv+d8rnw
         BLHs17o/+uayG86R3Du/QRvggcjVf4STRhecGLIv/OTp++jrzo+WCNy+Vc8VlRbwve9O
         rxfHG9SXtJl4143zQI+xOGv40r2DBZA66HSqrljg8yUdyzSNgvRPmDoiJwIa7jLQoz5O
         e5BaGkRgXFW0gTUw3GYNFy0lPXSAyKsK6gj5PaWzPq72VD6tKDPnDVDj5BTxw2CgzxWK
         Relg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JrzNzCE+6e/7fYHlEvlqtxiIjYnJBRLeb7tYosECYm8=;
        fh=TEPJUFHr2RIHySFmBpkTj7GS0BWywypezNPfBbmaOHk=;
        b=GSrwhw2jVWVZ4x8CwvS+seGp8Enzux7yBMIxWi+/xuzG1xAEh3zLmhxj5yrV3GrXa+
         csM3khbAozNnYn2hHLJMBQJcIcs4Z7ae0V+Q1h345vfp8xe6RuQz+trgu5NplZGcMd2w
         wZE1vlUYCSwjhl2p6nt6ws7J0dkMXnUctHazs4WuBeHHlr0KcP1Tb2dmcnloa++btD9R
         /9ZcalSS9cLKbWw5cZbFp7kOp/KY9TTfpjMy1Z5E4Q5jHoaqYDM9aJXXTytQkfEd/44u
         7gj/YzpODpCh747e9A0ZGtdwGyI44E0Zc0M1++j1YRVSxpGgnOyqACJj7bJXDB+5VyZv
         aNHA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788188995; x=1788793795; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JrzNzCE+6e/7fYHlEvlqtxiIjYnJBRLeb7tYosECYm8=;
        b=aL4LtIV2hvc23brnfUen1GXocqEt5d76dW5MnDmVNA/P8qkl3tmjT+vkNNglzKolmo
         o4NZpmXkA/OZdwazETogazkUOe4tMnI/i8RpzcAa/KuVTIkb/K3SBM+VLtJa3M9a7gzT
         HsV7feNGq+uafd9VeJc5WncVM6hfqSM01aSCReN6t6TrUyi7AWiYVddrZsexEFyRrD3d
         6FlYYW1gVF+1WI4K+H0I1mqk2rySmOJLnvreYfdeXaxjsuNoof1gfUSit0MeX8k4Q5X3
         rEZ97XfdNb9Prp+AoPKP8kQLtW5yn6TZ9eL602EvdOhgyAAVQHYvi38wXto/Bzv6ZpEn
         x4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188995; x=1788793795;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JrzNzCE+6e/7fYHlEvlqtxiIjYnJBRLeb7tYosECYm8=;
        b=avSpwtgfPGpXfcGf+txuKVmHSulESVBZHnHMMzdkHhx7WEyBbvh4R52Fl84duPYuOX
         0vIdhBJMgXP8YxUJ7/1esxPiOCczPyr6isijRXBT2w7dN1aorexleuYbJtJG6xMgRPxx
         rLiVmOhlgvrJvELdE6NN4l32Efl8PspmHMzNCKv6zFs9ueSxG9JnuqwYXKiPkp4pZyGr
         v3QZXJXSwXm3+f73vyFnO+Xupigutsgy108w43QYThgku0VQyInxwC7xAoqI6oAO1+Wh
         NnWc/tXg7ikdei7+xOYovGqrQ3PVn5jpeOZcSpY0n399w+BgiusT0xVID/y3JR/aKOmE
         el3w==
X-Forwarded-Encrypted: i=1; AKwUvByeeTe0/dcBUNhVyoB57lSR8YjVLxLN3ASp4G+2366gC0oVXuGmDaABbWecXgo4w6Z8xlZHanHvYAfti4k5+g==@lists.linux.dev
X-Gm-Message-State: AFuF++kythqVd47ig0YGbCe4xWExeOdCAm+Fbx6dbfsAyPHewxTyC0wW
	O7si0Gqokx9cDGq1MvM05bQ7Js9BU+VkiqbvIKwenMtp5rOWhsZmrfALb3DqJJoghYak5srmdXY
	MofL67ZZb60AfiPZYHZD8Ii//ij6u4OmUBvnnTo2XfQ==
X-Gm-Gg: AYBFou2pDjKXPS7DXfuQ1mNZPFK/GyXv//GBb8kc7H1hGZDi0fPGzno5mg1HHYB50xr
	gEiEA4iZ0a1Hr5kanq2aGdzYQrf20NsdZm1YQ3T8iJdi7nvgh6JV9GlplgxAp4xLN7dqQLR8CPq
	b6F81zxHVegq3NqS6aP9p9jBOSkh9vvGmRZuSJDl7dVey3gVi2ypvEHbbupLVxu6PWz4l63crpQ
	pMSQNEhPjdadSfvUL4ocoXERvYye9vKfOL3z7HP+bJ9arjyOr6bQ/AybcsLazoNPIE5+vHMNej9
	Zb+RHTIszBkZv2O+Qz0EyZOWDIc99mV6mMYPfuBJpP5T4RLuYjKsSryQ75mI68YRtHhw8e1ot4N
	rAQ==
X-Received: by 2002:a05:6402:2483:b0:6a3:8652:a373 with SMTP id
 4fb4d7f45d1cf-6a663a61f85mr1302653a12.3.1788188995367; Mon, 31 Aug 2026
 08:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260825103855.721013-1-sshegde@linux.ibm.com>
 <20260825103855.721013-6-sshegde@linux.ibm.com> <8262d2f9-9f2f-4821-8497-991d7c8448a3@arm.com>
 <apMziCV_8y0xeIBT@yury> <53035ba4-53ec-4907-93b8-c8b957d1fa61@linux.ibm.com>
In-Reply-To: <53035ba4-53ec-4907-93b8-c8b957d1fa61@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 31 Aug 2026 17:09:41 +0200
X-Gm-Features: AcwNN1WuQPzuapLI2-JLpyWulustWf-m7h6Qeoz6g2HFHQKGD7paBioDMOOd3wc
Message-ID: <CAKfTPtA5Bdw89hezn1wi_p0m0dJgJJ1GYg8H93PsvsMC4bVJxA@mail.gmail.com>
Subject: Re: [PATCH v11 05/12] sched/core: Try to use a preferred CPU in is_cpu_allowed
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Yury Norov <ynorov@nvidia.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, 
	juri.lelli@redhat.com, yury.norov@gmail.com, kprateek.nayak@amd.com, 
	iii@linux.ibm.com, corbet@lwn.net, meted@linux.ibm.com, tglx@kernel.org, 
	gregkh@linuxfoundation.org, pbonzini@redhat.com, seanjc@google.com, 
	vschneid@redhat.com, huschle@linux.ibm.com, rostedt@goodmis.org, 
	maddy@linux.ibm.com, srikar@linux.ibm.com, hdanton@sina.com, 
	chleroy@kernel.org, vineeth@bitbyteword.org, frederic@kernel.org, 
	arighi@nvidia.com, pauld@redhat.com, christian.loehle@arm.com, tj@kernel.org, 
	tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org, 
	rdunlap@infradead.org, kernellwp@gmail.com, linux-doc@vger.kernel.org, 
	jgross@suse.com, virtualization@lists.linux.dev, sunlightlinux@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Aug 2026 at 04:19, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
> Hi Yury,
> Thanks for going through and your suggestions!.
>
> On 8/30/26 1:01 AM, Yury Norov wrote:
> > On Fri, Aug 28, 2026 at 09:51:47AM +0200, Dietmar Eggemann wrote:
> >> On 25.08.26 12:38, Shrikanth Hegde wrote:
> >>> When possible, try to choose a preferred CPU.
> >>>
> >>> This is essential to maintain user affinities when preferred
> >>> CPUs change. A task pinned on a non-preferred CPU should continue
> >>> to run there, since this is a non-user triggered event.
> >>>
> >>> If a CPU is non-preferred and the task can run on other CPUs which are
> >>> currently preferred, then choose a preferred CPU instead.
> >>> This is decided by checking if cpus_ptr and cpu_preferred_mask
> >>> intersect or not. If yes, then the task has other preferred CPUs.
> >>>
> >>> The push task mechanism uses a stopper thread which calls
> >>> select_fallback_rq() and uses this mechanism to pick a preferred CPU.
> >>>
> >>> This takes care of the wakeup path for FAIR tasks too.
> >>> is_cpu_allowed() is called to ensure wakeups happen on preferred CPUs.
> >>> With that, additional checks in available_idle_cpu() are not necessary.
> >>>
> >>> Ignore the preferred CPU state if a task's affinity is changing and
> >>> its new mask no longer includes the CPU it is currently running on.
> >>> This ensures migration_cpu_stop() does not abort, preventing the task
> >>> from being stranded outside its allowed affinity.
> >>>
> >>> Account for tasks with architecture-specific CPU masks
> >>> (e.g., 32-bit tasks on arm64). For such tasks, explicitly check against
> >>> the arch-allowed CPUs to determine if any of the preferred CPUs are
> >>> actually valid.
> >>>
> >>> For the majority of cases, this would still keep select_fallback_rq()
> >>> as O(N). cpumask_intersects(), which is O(N), is called only if
> >>> !cpu_preferred. The task running there is expected to move out.
> >>> Subsequently, it should run on a preferred CPU. This becomes O(N**2)
> >>> only for tasks pinned solely to non-preferred CPUs. That is a rare case.
> >>>
> >>> Overhead is minimal when the CPU is preferred.
> >>>
> >>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> >>> ---
> >>>   kernel/sched/core.c | 41 +++++++++++++++++++++++++++++++++++++++--
> >>>   1 file changed, 39 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >>> index a45f7c308329..f71317fe281d 100644
> >>> --- a/kernel/sched/core.c
> >>> +++ b/kernel/sched/core.c
> >>> @@ -2494,6 +2494,35 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
> >>>     return rq->nr_pinned;
> >>>   }
> >>>
> >>> +static inline bool task_can_sched_on_preferred(int cpu, struct task_struct *p)
> >>> +{
> >>> +   const struct cpumask *valid_mask;
> >>> +   int i;
> >>> +
> >>> +   if (cpu_preferred(cpu))
> >>> +           return false;
> >>> +
> >>> +   /* Only FAIR tasks honor preferred CPU state */
> >>> +   if (unlikely(p->sched_class != &fair_sched_class))
> >>> +           return false;
> >>> +
> >>> +   /* Ignore preferred state if task affinity is changing */
> >>> +   if (unlikely(!cpumask_test_cpu(task_cpu(p), p->cpus_ptr)))
> >>> +           return false;
> >>> +
> >>> +   valid_mask = task_cpu_possible_mask(p);
> >>> +   if (likely(valid_mask == cpu_possible_mask))
> >>> +           return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
> >>> +
> >>> +   /* Tasks with arch-specific CPU masks. e.g. 32-bit tasks on arm64. */
> >>> +   for_each_cpu_and(i, p->cpus_ptr, cpu_preferred_mask) {
> >>> +           if (cpumask_test_cpu(i, valid_mask))
> >>> +                   return true;
> >>> +   }
> >>
> >> Looking more into this, there might be a window in 64-32-bit execve()
> >> for 32bit EL0 tasks on Arm64 (w/ allow_mismatched_32bit_el0 command line
> >> option).
> >>
> >> The time before arch_setup_new_exec() calls
> >> force_compatible_cpus_allowed_ptr() to restrict CPU affinity for those
> >> tasks.
> >>
> >> Let me run more test on this ...
> >>
> >> Why not simply:
> >>
> >> - return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
> >> + return cpumask_first_and_and(p->cpus_ptr, cpu_preferred_mask,
> >> +                              task_cpu_possible_mask(p)) < nr_cpu_ids;
> >>
> >> IMHO, you want to know whether there is at least one CPU that belongs to
> >> all three CPU masks?
> >
> > Yeah, the cpumask_first_and_and() would replace the for-loop more
> > effectively, but I'd suggest introducing the new helper:
> >
> >
> >          return cpumask_intersects_and(p->cpus_ptr, cpu_preferred_mask,
> >                                        task_cpu_possible_mask(p));
> >
>
>
> Ack. However, we will only need this change if ARM64 wants to enable
> this driver right now. If not, we can go back to the earlier
> cpumask_intersects(), and the 3-way intersection can be added
> later when the ARM ecosystem enables the feature.
>
>
> Dietmar/Vincent,
> Do you think it makes sense to enable the driver on ARM64 now?
> Or you think it is better to delay it and once the feature is stable
> ARM ecosystem can enable it?

It's always better to support all arch by default, unless something is
missing which is not the case here.

>
> > This would also highlight the intention better - we're looking for
> > intersection, and call the 'intersects' function.
> >
> > I don't like how this patch plays with likely() macro.
> > Possible == task_possible condition is surely likely for x86, but is
> > always unlikely for aarch64/el0-32 tasks. This would lead to suboptimal
> > code generation on aarch64.
> >
> > The approach I've suggested also worsen performance because of a
> > possibly unnecessary traversing of the cpu_possible_mask.
> >
> > If task_can_sched_on_preferred() is really a performance critical piece
> > of code, we can invent arch_task_can_sched_on_preferred() to avoid it.
> >
>
> It is called only on non-preferred CPU and unless pinned, tasks would have moved
> out of it. So we are okay here I guess. If it really pops up, then we can do the
> above idea.
>
> > --
> >
> > On general side, the governor is really tested in 2 configurations:
> > PPC+powervm and x86+kvm; and there's clearly an interest from XEN and
> > ARM engineers.
> >
> > Maybe, to stay on safe side, we'd enable the feature where it's actually
> > tested? I suggested it when DOM0 case was revealed, and now we've got
> > the 2nd corner case from arm64 compat tasks.
>
> Indeed. It would safer and that way it would get more testing before arch/hypervisor
> enables it.
>
> The design is intended to work on architectures that provide steal-time
> accounting, but each architecture and hypervisor combination should be validated
> before enabling it.
>
> >
> > The advantages of this approach are:
> >
> >   - faster adoption of the existing code for the tested architectures;
> >   - delegate arch/vm support to the domain professionals;
> >   - delay arch/vm support decisions to the later phase of adoption, when
> >     the API is better stabilized.
> >
> > Thanks,
> > Yury
>
> So far, I have PPC_SPLPAR, S390, X86_64 in the Kconfig list.
> I will wait to hear from Dietmar/Vincent about ARM.
