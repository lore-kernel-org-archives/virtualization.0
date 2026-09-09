Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69497577E56
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963496; cv=none; b=Tb2pgN+7NUGN1MaP85XwiR5ie6hC5ioN/kdYnWT5LN4CRhXHYuOLaL9/j+eT8aTW7CTJqDHGKYN6ehzttfRXaOBq9dc4KmIz8JW9Je5ioy5AUJGTnFxxvlLgre9FYwzvgXSre4CBznuCEhU+tr0pHgXJw2hW/5pecBLL4gUxpb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963496; c=relaxed/simple;
	bh=nhyshk6eb0REvp0qqUpSiCy7nbZhIyE8KgMteLoky34=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EUin5L0cpJzZx1dVxe+txV5L+JpzQH8ffPbCtFJ6ZIhQWcZAe10FyzoASIZnpxQ4GG0FdDkJEv5QCPGxLbtxAjzN7RE0fbvHOIm4ozVxL10FliY6dnNsuWFP+BT45oLezTkImUJUdk/5/zfdCkA3cc1xXh3W3khUjWbzAeyzyCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtXAU6ze; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtXAU6ze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF841F00A3E;
	Wed,  9 Sep 2026 14:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963495;
	bh=/ac8KOxDROG2fsA94Xd/yevn40OFmlTSIvsk9n6bj1I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YtXAU6zecS4HA+z8JnKeVevu/f51ERIXiANzm93+4NzZtqUs1rSp4vUmRNvu4Kmv2
	 vbP/jnsTIpf0rXZvOCDamkx9tIlbdwKMxe2OrnZALudtNsw6DVyH1P3uXHIikO/UYd
	 2wGoWLl74U1YH0PtgiRzIJCiiOGXisq4KMZ1UEN6gXy8bCGv6mLQWCDjwz6/vvDhOm
	 kVSCQ8huvcL5i5sbU8sArL3lGtM87bKddFD95l9xIzXQpw6SA1bMlGMQhXGxYiq0a1
	 /s4LozocUwC+6ok0G02+BWjjS2dTAFO6Tgkk8wKfAgrtJEAWeIgjFQfyCYkbSIX5D7
	 uRdNI/XLRXBsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 06/13] sched/core: Try to use a preferred CPU in
 is_cpu_allowed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260909135617.871006-7-sshegde@linux.ibm.com>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-7-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:18:14 +0000
Message-Id: <20260909141814.BAF841F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Wakeup path funneling to lowest-ID preferred CPU bypassing CFS loa=
d balancing
--

commit 2b5645419bf5356450334e7129102cfed3b5f5bf
Author: Shrikanth Hegde <sshegde@linux.ibm.com>

sched/core: Try to use a preferred CPU in is_cpu_allowed

When possible, try to choose a preferred CPU to maintain user affinities
when preferred CPUs change. Update is_cpu_allowed() to ensure wakeups
happen on preferred CPUs.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a689a0cea4ebe..b4ef2e92d786b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
[ ... ]
> @@ -2519,8 +2536,12 @@ static inline bool is_cpu_allowed(struct task_stru=
ct *p, int cpu)
>  		return cpu_online(cpu);
> =20
>  	/* Non kernel threads are not allowed during either online or offline. =
*/
> -	if (!(p->flags & PF_KTHREAD))
> +	if (!(p->flags & PF_KTHREAD)) {
> +		/* Try to use preferred CPU if task's affinity allows */
> +		if (task_can_sched_on_preferred(cpu, p))
> +			return false;

[Severity: High]
Does returning false here for non-preferred CPUs cause FAIR wakeups to funn=
el
into a single CPU and bypass CFS load balancing?

When a FAIR task wakes up, select_task_rq_fair() and select_idle_sibling()=
=20
search for an idle CPU. Because select_idle_sibling() remains unaware of=20
cpu_preferred_mask, it can actively select an idle non-preferred CPU.

When this selected CPU is checked after the scheduler class's placement
decision, is_cpu_allowed() will now hard-reject it. This forces
select_task_rq() into the slow path:

    cpu =3D p->sched_class->select_task_rq(p, task_cpu(p), wake_flags);
    if (unlikely(!is_cpu_allowed(p, cpu)))
        cpu =3D select_fallback_rq(task_cpu(p), p);

Because select_fallback_rq() sequentially searches the mask:

    for_each_cpu(dest_cpu, nodemask) {
        if (is_cpu_allowed(p, dest_cpu))
            return dest_cpu;
    }

Will this cause waking tasks to be dumped repeatedly onto the lowest-ID
preferred CPU, creating massive runqueue hotspots?

>  		return cpu_active(cpu);
> +	}
> =20
>  	/* KTHREAD_IS_PER_CPU is always allowed. */
>  	if (kthread_is_per_cpu(p))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909135617.8710=
06-1-sshegde@linux.ibm.com?part=3D6
