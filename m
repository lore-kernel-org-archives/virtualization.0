Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C75F47DFBD
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963394; cv=none; b=Xl+dT0jCv4xkIlebXzOXUZtftZ85EXmZN1T9z6OZcx3/9DWl7MP4qiFD+A2CBOCm2xDr2G13SyvBtVeQpGw+yHFHja5UkKNeK5DmC6jlPLud379zg2IcdQMSo/Bg7zlrBAAeFRxQOxNN8pnlJID61bQzWbCtZIjbXpqK23o/wv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963394; c=relaxed/simple;
	bh=YR4jXoaayYFT0sWAQBrI+nPOHeq0dqtgpoQGoGme1J8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QckA3hLCOqrJr0Z9R1pTH9kg6hKqp0Mk74wffyjs2OJOU2DWM1h/1kXFOFWx8X5YJh6LVV6hFDo8U7SaPzeAu6N0wmvnmOodzjJX4wZ0OwJ75TX0Qx+JodWyjEsOZAAw74aEnaaCXg9HiiczIdd8xg1BKCump8+cabSUkPu27JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agYkGmg+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agYkGmg+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A4A1F00A3A;
	Wed,  9 Sep 2026 14:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963393;
	bh=WvIfrvKDaKWJbgbd3VbzM8uM76vvEem3S70N+4N+THk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=agYkGmg+O0JHdYgCzudx9RdQ4rz2DLUjOaAewFm22CELh3snX46U70YCmcJg87pbM
	 WFpgxdFISRkQOzAhKRtwS5occmmEZvfcZy0fvnze8tdyaZ9LmZdDzV6jH2ZagoiEOj
	 aXt36S4O3dcaK3vNu6W2reJlKbjJTs2HBsPoglR8Xowdn1jVBbbfc+gTYYzZYuXlmr
	 ToV39t1iOqm/X/Cf/ANrjgfz8pkJiSW2sfOdV6fJbruTU3O860g8bCtgk6IIq3Grgf
	 MrdQ5WH8B5SMhyGVYixIF9rEPW2deNKlpTZQNyhQb0aZ2fEocvKWZeAdUCetz/buI5
	 X8cChzMH6IAUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 12/13] virt/steal_governor: Implement steal_governor
 policy loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260909135617.871006-13-sshegde@linux.ibm.com>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-13-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:16:32 +0000
Message-Id: <20260909141632.C7A4A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Lockless access to `cpu_active_mask` in `preferred_cpus_valid()` c=
an lead to a spurious failure of `cpumask_subset()`, causing the driver to =
permanently shut down.
--

commit 77aa795bc87999089d7a60bf5b5985b2c580cbec
Author: Shrikanth Hegde <sshegde@linux.ibm.com>

virt/steal_governor: Implement steal_governor policy loop

This patch implements the core policy loop for the steal_governor driver us=
ing
a delayed workqueue. It periodically calculates the steal time ratio and
dynamically adjusts the preferred CPU mask based on high or low contention
thresholds.

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
Can this lockless check spuriously fail and cause the driver to incorrectly
shut down?

Because cpus_read_lock() is not held here, there appears to be a race
condition with CPU hotplug operations (such as sched_cpu_deactivate()). Whe=
n a
CPU is taken offline, it is removed from the relevant masks sequentially.

If cpumask_subset() reads cpu_preferred_mask while the dying CPU's bit is
still set, and then reads cpu_active_mask after the CPU's bit has been clea=
red,
the subset evaluation will spuriously return false.

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

[ ... ]

> +	if (steal_ratio > sg_ctx.high_threshold)
> +		decrease_preferred_cpus();
> +	else if (steal_ratio <=3D sg_ctx.low_threshold)
> +		increase_preferred_cpus();
> +	/*
> +	 * else: steal ratio is within bounds. Still do design checks so that
> +	 * module restores to active if CPU hotplug breaks those assumptions.
> +	 */
> +	if (!preferred_cpus_valid()) {
> +		restore_preferred_to_active();
> +		return;

[Severity: High]
If preferred_cpus_valid() spuriously fails due to the lockless race describ=
ed
above, does this early return permanently disable the driver?

By returning here without requeueing the work via schedule_delayed_work(),
the periodic loop is halted completely, leaving the driver non-functional
until the module is manually reloaded.

> +	}
> +
> +requeue_work:
> +	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909135617.8710=
06-1-sshegde@linux.ibm.com?part=3D12
