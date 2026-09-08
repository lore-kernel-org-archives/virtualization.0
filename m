Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AA1492E25
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908347; cv=none; b=mY1zHPGfpGdo7X3Nln3HLm7UfS7sdTXTZoCopGoj/7k+dECMBkA4VYRYXzaUS16IIOcTUEkhLmJMhCfnYALUDSKPcbcO4EN6uIdwTR3ZCODKyUzZFAyh0nfzMC/WpkBpG5iTXT5W83LGMXgS9RIQ07macZG/J4ACKR/Aqn9iVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908347; c=relaxed/simple;
	bh=RUdKSO/DKe7Tfh1nS3jSt+4GDpq/U0Yu7CmdcHTOt+g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeNuLOZVU7d6vUiv5SW3E/2KUvLSOGib7aSycCBO7crTztYby9kWDSv9s5zvPkmGieeV35Ec1tnd04XnjDud4lupdLv5XFle9+C7DiXPJPT/0L5L88Jmd4OdSSKXwzZq3zw+nqWDOHDXWo9JwoJd2Pb4Gfyj8uNghW75aqdbseY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PN0wV2/v; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN0wV2/v"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d6e954afbdso34113145ad.2
        for <virtualization@lists.linux.dev>; Tue, 08 Sep 2026 15:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788908345; x=1789513145; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LxX1rEZrKYtuWO+o8T+2BCvyEblD/tbwlp93Hac6Zsg=;
        b=PN0wV2/vlUZrbZ1/KBpVMHGy69pkoIu/IPXBikQ2hhWdOWqIQTjCSk2kN13Ax0DXlx
         moUjf2x5Ekw5MQv4cDqEj6BDFWijZ+wysZIPvGrevKZ5lnz/yCw1WI/BvAFb47ip+hp3
         /1SvIvAXrXAtuHykwDNk+Ts6ZjO3eImEfTSLGvfLzQasw+MOHUB5nahmNP2JFYdumQFS
         2Qnmmi0D2B8ZSM45CoPhKXa9DpWVBIuz1jDG2K5javcVO689MaSUMx6Ds56f9U/0vVRN
         lz5Lp7QFEQRLM5ek2SiEaPhY72kd3VHlZTZEDkrs1ZCl8HXgfuDl0/HyoCpcL1hCK2KV
         qmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788908345; x=1789513145;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LxX1rEZrKYtuWO+o8T+2BCvyEblD/tbwlp93Hac6Zsg=;
        b=Ne5jIEN7hITu36hdteGB1G+d3E7oPMxJAHrRU/2S0aVXfoxGsbeYQRYoBydx75GpEv
         gvnYG1N0zTP6tfW/mLdfcqps+RnJRTksviQiAboTlVRePgCcj/P5lg/6LhZR8Ga3aUju
         SQLFpW6o7gkpv6p5G0Vv+BbamcTQkxSpcMmCdyHSuPg5dUI4bjmh67JhA4uuaq2wwvV8
         R299d2m1sPYw7XmblDMmRhdaLkYErN7u7K0+lXcEOymAggl2Ioy6vnC6n+UCeZ1Tu0T3
         CP12mFjiS8iMiu3zfg7nZSA3fxeip3h4YDj1I111mB5xVNfpee+BPlPCubzjt2YERKgD
         d7rQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJ7ZgnbRJUkfQ/zjgWRekJl+cY5MNpllFQR3KS053SF99wdpz5mM3ggzHzzcd26jws0ssJ8O3b4Iv9tJyE5A==@lists.linux.dev
X-Gm-Message-State: AFuF++nZPXwsaj7gRWHBy09AmDIFQxRV3Qyuz13D5x7bI+wI2dAy3uii
	npAwkxHKfKZX56vRLPnJNXohl7Os4u1tOShDf73sPXrfrSXXt61qNbRd
X-Gm-Gg: AYBFou3sJR2SwXX7/DvAEYEoWI1AxpilK5ShCzm43OlP9YVRlNgOUMTWHZnS/wqMFC5
	gIeEvUER4ZPEJNOtSTHarZwmqhHVYdynGw2JqdMb5zoBND2pmaGy6K5yB6RZPS88qzEj091ckva
	sZc6MJOsOxCYc+pufiIuoWXNk7xDJ+h0/pw9svMbklgzEbqWSK5bSuey+Y6/RjlBvL4dXh3zPga
	UaisTHtsRieZZ1MHsSNcg5fgRr8WXuwFBAKhvVs5zTwquWeUv3EjZPtcbNBGglYJz7MG2keWfzE
	RDtWtyez1Lu59ZAcKhGdpq+Fkg3rat++DRks4xkwgzt+ra4MoPJdoD/9heqIRpnqmmFnj3ad0UE
	8Cpi0FFOz5U5KZWKIIXE3XAiPimTVM2tWU3VFsp2xn2S7ZC6oYLi636w/eeUL5cZ4LP3ybdCITZ
	wN+GYcvBMjbZx9yc8woAWUgL75RMkO4mhd1C2AfIvGRHfB2IYaxnOEDtUWz34p6sb3NQwbsA==
X-Received: by 2002:a17:90b:2ccf:b0:398:a2a3:b631 with SMTP id 98e67ed59e1d1-39b262aaf3dmr49898755a91.19.1788908344988;
        Tue, 08 Sep 2026 15:59:04 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435648esm46668031c88.5.2026.09.08.15.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 15:59:04 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Tue, 8 Sep 2026 18:58:57 -0400
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: yury.norov@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, kprateek.nayak@amd.com,
	iii@linux.ibm.com, corbet@lwn.net, meted@linux.ibm.com,
	tglx@kernel.org, gregkh@linuxfoundation.org, pbonzini@redhat.com,
	seanjc@google.com, vschneid@redhat.com, huschle@linux.ibm.com,
	rostedt@goodmis.org, dietmar.eggemann@arm.com, maddy@linux.ibm.com,
	srikar@linux.ibm.com, hdanton@sina.com, chleroy@kernel.org,
	vineeth@bitbyteword.org, frederic@kernel.org, arighi@nvidia.com,
	pauld@redhat.com, christian.loehle@arm.com, tj@kernel.org,
	tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
	rdunlap@infradead.org, kernellwp@gmail.com,
	linux-doc@vger.kernel.org, jgross@suse.com,
	virtualization@lists.linux.dev, sunlightlinux@gmail.com
Subject: Re: [PATCH v12 08/13] sched/core: Push current task from non
 preferred CPU
Message-ID: <aqCTMREUoCmbtygK@yury>
References: <20260903063240.268775-1-sshegde@linux.ibm.com>
 <20260903063240.268775-9-sshegde@linux.ibm.com>
 <aptiJP_8SWwZWju6@yury>
 <7d88a3c4-a7e4-4814-9e29-84955b69a5b3@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d88a3c4-a7e4-4814-9e29-84955b69a5b3@linux.ibm.com>

On Mon, Sep 07, 2026 at 08:53:19AM +0530, Shrikanth Hegde wrote:
> Hi Yury, thanks for taking a look.
> 
> On 9/5/26 5:58 AM, Yury Norov wrote:
> > On Thu, Sep 03, 2026 at 12:02:35PM +0530, Shrikanth Hegde wrote:
> > > Actively push out the current running task on a non-preferred CPU. Since
> > > the task is currently running, a stopper thread must be queued to push the
> > > task out. However, if the task is pinned only to non-preferred CPUs,
> > > it will continue running there. This helps to maintain userspace
> > > affinities, unlike CPU hotplug or isolated cpusets.
> > > 
> > > Though the code is similar to __balance_push_cpu_stop and quite close to
> > > push_cpu_stop, it is kept separate as it provides a cleaner
> > > implementation specifically for CONFIG_PREFERRED_CPU.
> > > 
> > > Add the push_task_work_done flag to protect the work buffer.
> > > 
> > > For now, only the currently running task is pushed out. This keeps the code
> > > simpler. In the future, an optimization may be added to move all queued
> > > tasks on the runqueue.
> > > 
> > > This works only for the FAIR scheduling class.
> > > 
> > > Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> > > ---
> > >   kernel/sched/core.c  | 81 ++++++++++++++++++++++++++++++++++++++++++++
> > >   kernel/sched/sched.h |  8 +++++
> > >   2 files changed, 89 insertions(+)
> > > 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index b4ef2e92d786..35e7eedad104 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -5808,6 +5808,9 @@ void sched_tick(void)
> > >   	unsigned long hw_pressure;
> > >   	u64 resched_latency;
> > > +	if (!cpu_preferred(cpu))
> > > +		sched_push_current_non_preferred_cpu(rq);
> > > +
> > >   	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
> > >   		arch_scale_freq_tick();
> > > @@ -11202,3 +11205,81 @@ void sched_change_end(struct sched_change_ctx *ctx)
> > >   		p->sched_class->prio_changed(rq, p, ctx->prio);
> > >   	}
> > >   }
> > > +
> > > +#ifdef CONFIG_PREFERRED_CPU
> > > +static DEFINE_PER_CPU(struct cpu_stop_work, npc_push_task_work);
> > > +
> > > +static int sched_non_preferred_cpu_push_stop(void *arg)
> > > +{
> > > +	struct task_struct *p = arg;
> > > +	struct rq *rq = this_rq();
> > > +	struct rq_flags rf;
> > > +	int cpu;
> > > +
> > > +	if (cpu_preferred(rq->cpu)) {
> > > +		scoped_guard(rq_lock_irqsave, rq)
> > > +			rq->push_task_work_done = false;
> > > +		put_task_struct(p);
> > > +		return 0;
> > > +	}
> > > +
> > > +	raw_spin_lock_irq(&p->pi_lock);
> > > +
> > > +	/* This could take rq lock. So call it before rq lock is taken */
> > > +	cpu = select_fallback_rq(rq->cpu, p);
> > > +	rq_lock(rq, &rf);
> > 
> > If select_fallback_rq() grabs the lock, then when it releases the
> > lock, there's a window for race between the other process and the
> > subsequent rq_lock(). Or I misunderstand it?
> > 
> 
> select_fallback_rq taking lock is for any state change that needs to happen
> such as fallback to possible CPUs etc.
> 
> Most of the time it won't grab the rq lock. Even if the task got pulled by load balancer
> before grabbing the lock, Below (task_rq(p) == rq) will catch that, and it bails out.
> 
> So it is safe.

OK... Can you please explain it in the comment above?

...

> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > index 6c3ad70e58b8..678e44134acf 100644
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -1298,6 +1298,8 @@ struct rq {
> > >   	struct list_head cfs_tasks;
> > > +	bool			push_task_work_done;
> > > +
> > 
> > It should be protected with CONFIG_PREFERRED_CPU. Also, the name
> > doesn't look correct. You set the variable to 'true' even before
> > calling the stopper. Maybe need_push_to_npc, or similar?
> > 
> 
> ok. npc_push_work_pending is probably a better one?
> > Why did you place it between cfs_tasks and avg_rt? If no specific
> > reason, maybe place it next to CONFIG_PARAVIRT-guarded fields.
> > 
> 
> I don't see a common empty space there. I could increase the size.
> 
> > What about pahole?
> 
> I did check pahole on powerpc which has 128 byte cachelines.
> 
> 	int                        online;               /*  4524     4 */
> 	struct list_head           cfs_tasks;            /*  4528    16 */
> 
> 	/* XXX 64 bytes hole, try to pack */
> 
> It was empty space. Now, that i check 64 byte cachelines it may not be the
> optimal one.
> 
> I do see, a couple common places for both 64 abd 126 byte cacheline. I believe those
> are better places. It won't increase the size or cause any existing fields to
> misalign. It also makes sense to guard it again CONFIG_PREFERRED_CPU. I had not
> done to avoid ifdefs. But it is used only under it. So i think that makes sense too.
> 
> 1.
> 
> 	struct balance_callback *  balance_callback;     /*  3608     8 */
> 	unsigned char              nohz_idle_balance;    /*  3616     1 */
> 	unsigned char              idle_balance;         /*  3617     1 */
> 
> 	/* XXX 6 bytes hole, try to pack */
> 	long unsigned int          misfit_task_load;     /*  3624     8 */
> 
> 
> 2.
> 	unsigned int               ttwu_count;           /*  5276     4 */
> 	unsigned int               ttwu_local;           /*  5280     4 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	struct cpuidle_state *     idle_state;           /*  5288     8 */

The struct rq is highly configurable. Depending on your config,
the holes will migrate to different places. I'd not rely on just
'optimizing holes' problem. Just put the new field next to logically
related existing fields.

You've got paravirt-related prev_steal_time and prev_steal_time_rq,
and you've got the /* For active balancing */ section. Maybe one of
them?

Thanks,
Yury
