Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA10362138
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574865; cv=none; b=oo+fjt8S0+5K8RUxvbHB6Hl0EZhQARmAjxF+NumcQpGVv5zZymmcodS4aN+5ppve0mXn2y7OMsFOLSF3bYCxWeaVbcI5VjZeOEJZAQBTp68LWMk8Yar9c4+kXLU/txDYsWjMLjwkfFD6EOZBcvfnOjM3nJqQjI7JNRELb1DAX2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574865; c=relaxed/simple;
	bh=OsJd3OxVpi4WASV6t0Z7/p7J3EPCFjKY8f1hpV+6kME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iDkm7gGNMg0546PGi17LHIWrRSXyQlPf6KK7gU4BCFmCpCXAhf6pkUrcdMqzb9epzFguUZ73vlCpBeCWW+P4CrFt5WQws/83QNW8/7aQrUXueAXoZ7CZ8t7kfsziUa4XW1xlP/Y643st+lRCs9oZhc/xhvX8OyXapG5K0d4xOgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7pGp+Nv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7pGp+Nv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0D21F000FF;
	Mon, 28 Sep 2026 05:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574864;
	bh=gnVlMDShBzl1knFZq+LjzSsJzr3/WCSPOj+hsrw+mCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b7pGp+NvY5fr7QDj/0IknZ+wyu9plLA2Es9wz9wi8x4GVvI/vYZmuendJFGk7FTUC
	 gvTf1cKYiFsIFd/vmlIe5goRzjWaixY406nnOvSQmyqFLy5hdj1T08XPUOQBQpvcLP
	 eZcJth/La7gcQYiCM/46puF8A+37n1oMdE8IhcVvBBGZCh+0zdjfjN3qKTBvxgn7ri
	 QKezssEHmEhPvsfgBLnO3KpP5G/cenrZTAuqbLSQVbeWKeZ0bxlqyt4k9eH3pKV6Ul
	 Wq2NCk3RbPQ00dB4wnzz31UmmBx0iSVANkIYFRvYuXk1uH6sQGO2zOpVVSY4kyDxmr
	 Nx/FaHgkK/KaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 01/13] sched/cputime: Add kcpustat_field_total
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260928053728.797539-2-sshegde@linux.ibm.com>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-2-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 05:54:23 +0000
Message-Id: <20260928055423.AF0D21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/hiperdispatch: TOCTOU race in hd_calculate_steal_percentage()=
 causes artificial steal percentage spikes
--

commit 543d41ec158ad38d026cd1a0e58754cc9393d347
Author: Shrikanth Hegde <sshegde@linux.ibm.com>

sched/cputime: Add kcpustat_field_total helper

This patch introduces a new helper function to sum up a given cpustat type
over a specified cpumask. It replaces the open-coded steal calculation in
s390 hiperdispatch and idle time calculation in proc uptime to simplify
the callers.

> diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperdis=
patch.c
> index 2172065222661..c21496f0a141a 100644
> --- a/arch/s390/kernel/hiperdispatch.c
> +++ b/arch/s390/kernel/hiperdispatch.c

[ ... ]

> @@ -207,16 +207,12 @@ static unsigned long hd_calculate_steal_percentage(=
void)
>  {
>  	unsigned long time_delta, steal_delta, steal, percentage;
>  	static ktime_t prev;
> -	int cpus, cpu;
> +	int cpus;
>  	ktime_t now;
> =20
> -	cpus =3D 0;
> -	steal =3D 0;
>  	percentage =3D 0;
> -	for_each_cpu(cpu, &hd_vmvl_cpumask) {
> -		steal +=3D kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];
> -		cpus++;
> -	}
> +	steal =3D kcpustat_field_total(CPUTIME_STEAL, &hd_vmvl_cpumask);
> +	cpus =3D cpumask_weight(&hd_vmvl_cpumask);

[Severity: High]
Could separating the summation from the divisor count open a race window
against concurrent mask updates?

In the previous single-loop calculation, the total steal time and CPU count
were evaluated together on a stable view of the mask. With these changes,
if a concurrent CPU hotplug event calls update_cpu_masks() while
hd_calculate_steal_percentage() is running, hd_vmvl_cpumask could be cleared
and repopulated asynchronously.

If the mask changes from multiple CPUs to 1 CPU between the
kcpustat_field_total calculation and the cpumask_weight call, steal will
reflect the delta of the larger number of CPUs, but cpus will evaluate to 1.

Because the percentage is computed as steal_delta / cpus, dividing the
larger steal_delta by 1 would artificially inflate the steal percentage.
Can this erroneous spike trip the hd_steal_threshold, causing the scheduler
topology to wrongly disable Hiperdispatch and downgrade high-capacity cores?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928053728.7975=
39-1-sshegde@linux.ibm.com?part=3D1
