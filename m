Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793496804;
	b=bjBURt0pFL1AamyDIEQbFKi7vjnmgwyqfq1fhCEtAfQOlZ4LzQVbqr9vu9xJwNRl4Ufo
	 QMAWbTJnXd1DYaGB2nMXC1Z+ZfMzbrCa1WibtMzCuSMaSrUt3k88UAh3CyExiGhwJAWkA
	 GpVAlRrDtZcU6Y2fGIVj/+WcDiWFwb02arpDf2Ep/FZhv2dVUanw/ME2BHNnVTot78LrY
	 oj+WDNZ3JaRLs/K0hIe2eOF9EAVuYnMRJtzIU89hlGm756UwziX9XA6yaeKUjnYlGa2at
	 jigvTebJCQxes91ChG5kCdoSUFNJngsTpb4sf2KGjDUHYmksjfb7ocYZC8f5UmA5z0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793496804;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v21NHPdsOLLP7RKg1aRBpi1DMKpd5Yni6sbwZVczwA0=;
	b=nLEKRVaYsFORL1id9N809/ZXRRup3+ZrHJAIwS9fiVoaABHdKh9BOMJqugu6nz9HvjvO
	 Xh4Kwp9tSBVu95AexDM0Tgq2ba4EzWUrmg3VtNc/KkUt/ufgG7Q75bzvQoUjsypGYKjnp
	 7H5+WUVSmxZWM7c5s5ZWj12RGt8n51LC1QZ2cM+zMByI5k/IQbBwVq3JDxoLN8y10/ouX
	 VP+dZDqNT0mj4KCYtbwN51w25eTX4oFI4WlmYhS/qQp/bCfuHoUD2U43h/3N1lWnPUGyj
	 pzpdueEIYcPOTCGXl3l1gPG0HsrKnMmw9Zw/03cxLl8sUBVViG8k67JBdvDc1APJoiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0swMc55;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6168606A31A;
	Sun,  1 Nov 2026 01:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0swMc55
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEBC1F000C1;
	Sun,  1 Nov 2026 01:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793496803;
	bh=v21NHPdsOLLP7RKg1aRBpi1DMKpd5Yni6sbwZVczwA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H0swMc55NiRXaq7t/WxuB0DDj/CkuRnvv+YWzn5MJCVLIOLenNDKzPMtrsJVRPSJk
	 AiyE42jdjH8vbzf9RGgO+7kPph8LFuVKlHDKRe7hHLAHnddizF0TTZWSMwsA4M9mzK
	 COsFbFmqyFRtHHx9aN8hmbN7o9v2PbXnHhRAtMw537m4yeaSYRQufGnwRz7yeIqouh
	 bFy2PP6nJV7rj9K41k530Tp++Mvg6LvgO7lrFLkjiVE0OixweS7PdmmnxznsxG8OSy
	 q1gKaycPDfePboSsUU1PHY8iFzwU6msQzCg+r18BWb8pKqqGOvvpU+rr/zSBzmd0V7
	 pnSlleyuBqSCw==
Message-ID: <sashiko-outbox-192237@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost: Run TIF_NOTIFY_RESUME work in the vhost_task
 loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aamir Ahmed" <elb12345@hotmail.co.uk>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <AS8P251MB00012469E6ECBEA2B7D87BB0C86C2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
References: <AS8P251MB00012469E6ECBEA2B7D87BB0C86C2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 01:33:22 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vhost: missing cond_resched() and loop in vhost_task_fn() after ta=
sk_work
--

commit 97d56a24fed4c711b0eae24aaadc9595a3a04199
Author: Aamir Ahmed <elb12345@hotmail.co.uk>

vhost: Run TIF_NOTIFY_RESUME work in the vhost_task loop

This patch runs pending TIF_NOTIFY_RESUME work via resume_user_mode_work()
at the top of the vhost_task_fn() worker loop so that TWA_RESUME task_work,
such as CFS bandwidth throttling, is processed for vhost worker threads.

> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index 3717885a5992a..7fa96e1b85b66 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -6,6 +6,7 @@
>  #include <linux/completion.h>
>  #include <linux/sched/task.h>
>  #include <linux/sched/vhost_task.h>
> +#include <linux/resume_user_mode.h>
>  #include <linux/sched/signal.h>
> =20
>  enum vhost_task_flags {
> @@ -31,6 +32,14 @@ static int vhost_task_fn(void *data)
>  	for (;;) {
>  		bool did_work;
> =20
> +		/*
> +		 * We never return to user mode, so TWA_RESUME task_work (e.g. CFS
> +		 * bandwidth throttling) would otherwise never run. Run it here,
> +		 * where no locks are held, like io-wq workers do.
> +		 */
> +		if (test_thread_flag(TIF_NOTIFY_RESUME))
> +			resume_user_mode_work(NULL);

[Severity: High]
Should this loop while TIF_NOTIFY_RESUME is set and call cond_resched()
after resume_user_mode_work(NULL), similar to io_assign_current_work() in
io_uring/io-wq.c:

	if (work) {
		io_run_task_work();
		cond_resched();
	}

When resume_user_mode_work() runs task_work_run() -> throttle_cfs_rq_work()
in kernel/sched/fair.c, throttle_cfs_rq_work() dequeues current from its
cfs_rq (clearing p->se.on_rq), places it on cfs_rq->throttled_limbo_list,
sets p->throttled =3D true, and only sets TIF_NEED_RESCHED via
resched_curr(rq) without calling schedule():

	dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_THROTTLE);
	list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
	p->throttled =3D true;
	resched_curr(rq);

Without a cond_resched() and loop here, can several problems occur on
CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY kernels (or when a newly
unthrottled task is immediately re-throttled on schedule-in)?

1. Because unlocking task_rq_lock at the end of throttle_cfs_rq_work() does
not preempt current under CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY,
vhost_task_fn() proceeds directly into vtsk->fn(vtsk->data) while current
is already on throttled_limbo_list with TIF_NEED_RESCHED pending.

For example, when vtsk->fn is kvm_nx_huge_page_recovery_worker() calling
kvm_recover_nx_huge_pages() in arch/x86/kvm/mmu/mmu.c, it acquires
srcu_read_lock(&kvm->srcu) and kvm->mmu_lock and then checks need_resched():

	rcu_idx =3D srcu_read_lock(&kvm->srcu);
	if (is_tdp_mmu)
		read_lock(&kvm->mmu_lock);
	else
		write_lock(&kvm->mmu_lock);
	...
		if (need_resched() || rwlock_needbreak(&kvm->mmu_lock)) {
			...
			if (is_tdp_mmu)
				cond_resched_rwlock_read(&kvm->mmu_lock);
			else
				cond_resched_rwlock_write(&kvm->mmu_lock);

At that point it schedules out into throttled_limbo_list for the remainder
of the CFS bandwidth period while holding srcu_read_lock(&kvm->srcu),
stalling synchronize_srcu(&kvm->srcu). Similarly, on CONFIG_PREEMPT_NONE,
vhost_run_work_list() executes work->fn(work) (which acquires vq->mutex)
before reaching its own cond_resched() at the end of the work loop, and any
CPU time spent before rescheduling is not charged by update_curr() because
p->se.on_rq is already 0.

2. If vtsk->fn(vtsk->data) returns false (!did_work) while current is on
throttled_limbo_list, vhost_task_fn() calls schedule() with state set to
TASK_INTERRUPTIBLE. In __schedule() -> try_to_block_task() -> block_task()
-> dequeue_task_fair() -> dequeue_throttled_task():

	list_del_init(&p->throttle_node);

	/* task blocked after throttled */
	if (flags & DEQUEUE_SLEEP) {
		p->throttled =3D false;
		return;
	}

This removes the task from throttled_limbo_list and clears p->throttled, so
a subsequent vhost_task_wake() while the cgroup is still throttled will
enqueue the worker back onto the throttled cfs_rq.

3. Even if cond_resched() schedules the throttled task out, when the task
is later unthrottled and scheduled back in via set_next_task_fair(), if
sibling tasks have already consumed the newly replenished quota,
set_next_task_fair() calls task_throttle_setup_work(p) to set
TIF_NOTIFY_RESUME again without setting TIF_NEED_RESCHED:

	if (throttled)
		task_throttle_setup_work(p);

If vhost_task_fn() only checks TIF_NOTIFY_RESUME with an if statement
instead of a while loop around resume_user_mode_work(NULL) and
cond_resched(), returning from cond_resched() will proceed into vtsk->fn()
with the new TIF_NOTIFY_RESUME work still pending.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/AS8P251MB00012469E6=
ECBEA2B7D87BB0C86C2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM?part=3D1
