Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8E23E2756
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574721; cv=none; b=Drj59yeTcN0U8P8NdhGs2w7b2SV/VtkspgjZ3SSpXn/NdG+NxfF8v4lryoyB9YGyRyb8XiyLZH4LhqAErHoWILn/xDiLkgtGZmG8Ij4MF78odMm0r1YnIdzgITJbgdRJD4e6tMkF2J0gZDYsoT13j/ieNa5khhGUgCFu3jTnPTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574721; c=relaxed/simple;
	bh=InSmrKS+drC3kYtwG2EXM+0t/lyJAAWJcDx72ymDmHo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ct2eHOvLOCF3ZSpAgjF9e4mbaOAq+tbdCyiqvH4wmVEy9Y4MzDJwhsuVSPinBwc1SIEow8nxszLCTWXd2uP1BgNJi4rzOzyRArYz98gnP9nVdk7rvBtI0/A2nK76tEHdOgzhWkDU193i1GAVyosI6Ud8tlf7EE0pSjb5V1yTLk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9KEz1kI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9KEz1kI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EFF1F000FF;
	Mon, 28 Sep 2026 05:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574717;
	bh=BEKHHog5/XWaMGwaTtyqMxD9Z/SPJUmrpUZF7+Zy3JA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b9KEz1kI+cSWOid65eir/B24l0gvtcL4Ef59M2nM633I5y5c/xZQjNAQ8Rtz43CpZ
	 Ep3vHQ2u3siVlO1HPy0Qi86hl1FD6zre3vthDvPdvP9B4HQYYfzfyR/vihkisxEhSr
	 8OBexZrvKkTJnzdZfrP73OnKGIKYeYQthaMOCWDUzi/8fryrZcZKqkLjlPvDwA9bv2
	 IlOBzCJveGd7fU/eaHz0PwRhyIagINXxVPxXICoF03PP2zJGQS6xA8kkewu1MnCefh
	 ZYSFSbpdtbNHn+eYN2AKvAvdMJzZMTbZg9tuBWKUISADLGtr17V081m8Rg5buSON6K
	 YT/ELHuEScODg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 12/13] virt/steal_governor: Implement steal_governor
 policy loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260928053728.797539-13-sshegde@linux.ibm.com>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-13-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 05:51:56 +0000
Message-Id: <20260928055157.15EFF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing bounds check on interval_ms allows infinite workqueue spin=
loop
- [High] TOCTOU data race in preferred_cpus_valid() causes erroneous driver=
 shutdown
- [Medium] Integer overflow in steal_ratio denominator when VM is paused
--

commit 5f38399332407b64e0ce2da43681c27f1e1287d5
Author: Shrikanth Hegde <sshegde@linux.ibm.com>

virt/steal_governor: Implement steal_governor policy loop

Schedule work at regular intervals to implement the steal_governor
policy loop, which monitors steal time and takes action on the state of
preferred CPUs. The interval is determined by the interval_ms parameter.

> diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
> index 27f53ea16498b..6e31f9923dea4 100644
> --- a/drivers/virt/steal_governor.c
> +++ b/drivers/virt/steal_governor.c
[ ... ]
> +static bool preferred_cpus_valid(void)
> +{
> +	if (cpumask_empty(cpu_preferred_mask)) {
> +		pr_err("empty preferred mask. stopping\n");
> +		return false;
> +	}
> +
> +	if (!cpumask_subset(cpu_preferred_mask, cpu_active_mask)) {

[Severity: High]
Does this lockless read of cpu_preferred_mask and cpu_active_mask race
with CPU hotplug?

Since CPU hotplug clears the preferred mask bit before the active mask bit,
it seems cpumask_subset() can read a torn state where a word is read from
the preferred mask before the bit is cleared, and the corresponding word
is read from the active mask after the bit is cleared, returning false.

> +		pr_err("preferred: %*pbl is not subset of active: %*pbl, stopping\n",
> +		       cpumask_pr_args(cpu_preferred_mask),
> +		       cpumask_pr_args(cpu_active_mask));
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void steal_governor_loop(struct work_struct *work)
> +{
> +	u64 curr_steal, delta_steal, delta_ns, steal_ratio;
> +	ktime_t now;
> +
> +	now =3D ktime_get();
> +	delta_ns =3D ktime_to_ns(ktime_sub(now, sg_ctx.time));
> +
> +	if (unlikely(delta_ns < NSEC_PER_MSEC)) {
> +		pr_err_ratelimited("work scheduled too soon delta_ns: %llu\n", delta_n=
s);
> +		goto requeue_work;

[Severity: High]
Can this create an infinite spinloop if interval_ms is set to 0?

If interval_ms is 0, the delay is 0 jiffies. When the work executes, it will
take this branch because delta_ns < 1ms. It jumps directly to requeue_work
without updating sg_ctx.time, which schedules it again with 0 delay. This
will continuously spin and consume an entire CPU core.

> +	}
> +
> +	curr_steal =3D get_system_steal_time();
> +	delta_steal =3D curr_steal > sg_ctx.steal ? curr_steal - sg_ctx.steal :=
 0;
> +	sg_ctx.steal =3D curr_steal;
> +	sg_ctx.time =3D now;
> +
> +	/*
> +	 * steal_ratio =3D (delta_steal * 100*100)/(delta_ns * num_cpus())
> +	 * To avoid possible overflow, divide the denominator early.
> +	 * Note minimum interval is 100ms.
> +	 */
> +	delta_ns =3D max_t(u64, div_u64(delta_ns * get_system_cpus(), 10000), 1=
);

[Severity: Medium]
Will this silently overflow the 64-bit multiplication if the VM is paused
for an extended period?

Since the multiplication of delta_ns * get_system_cpus() happens before
the division, a large time delta (e.g., a large VM suspended for a long tim=
e)
can overflow U64_MAX, leading to a wildly incorrect steal_ratio calculation.

> +	steal_ratio =3D div64_u64(delta_steal, delta_ns);
> +
> +	if (steal_ratio > sg_ctx.high_threshold)
> +		decrease_preferred_cpus();
> +	else if (steal_ratio <=3D sg_ctx.low_threshold)
> +		increase_preferred_cpus();
> +	/*
> +	 * else: steal ratio is within bounds. Still do design checks so that
> +	 * module restores to active if CPU hotplug breaks those assumptions.
> +	 */
> +	if (!preferred_cpus_valid()) {

[Severity: High]
Does calling preferred_cpus_valid() here without cpus_read_lock() lead
to a false teardown?

If a hotplug operation is happening concurrently, the torn state read in
preferred_cpus_valid() will cause the governor to erroneously shut down
the policy loop permanently.

> +		restore_preferred_to_active();
> +		return;
> +	}
> +
> +requeue_work:
> +	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);

[Severity: High]
Does this immediately spin if sg_ctx.delay is 0, as mentioned above?

> +}
> +
>  static int __init steal_governor_init(void)
>  {
[ ... ]
>  	sg_ctx.delay =3D msecs_to_jiffies(sg_ctx.interval_ms);

[Severity: High]
Is it possible for sg_ctx.interval_ms to be 0 here?

The module parameter interval_ms doesn't appear to be bounds-checked
before this point, meaning it could be set to 0 and trigger the infinite
workqueue spinloop.

> +	INIT_DELAYED_WORK(&sg_ctx.work, steal_governor_loop);
> +	sg_ctx.steal =3D get_system_steal_time();
> +	sg_ctx.time =3D ktime_get();
> +	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);
>  	pr_info("enabled. interval: %ums, high_threshold: %u, low_threshold: %u=
\n",
>  		sg_ctx.interval_ms, sg_ctx.high_threshold, sg_ctx.low_threshold);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928053728.7975=
39-1-sshegde@linux.ibm.com?part=3D12
