Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2889956C621
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963445; cv=none; b=qbJUjA0D9sU581CDIaQRpOCzj/a1xDkVwPK36WUstqsYtQ4aK54CCpcBCKsS6ulmEjhHsUW73+4F0LxNpAFYJFIPZj8blmt4arfpfIORz01ts5bEDhwRsXW1MfCsyZI3P5ggjvEz+ilm7s97g8OdGygaDsHoLnrR3AUGoc9bPV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963445; c=relaxed/simple;
	bh=UvaFC925hs7jGeToFQnSvz1zb/s0F/iS4yjcSbG32QA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tbpd4MOBf9+mqiaVDk70sNKgxUCUz10WUwdAMD4fr3xuiJZ3okpdSApmKuwrBZK1T5ENkoO65YFtk+AiLy8k2TdVYAMKjFRbb/Wj6LjhgSFUiMAqvTAJnz88fW93b0P/v1XsPO4EN8RVFDyEzGRd1a/W72b7vrj2uo3DvpoDtdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKneQru9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKneQru9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5971F00A3D;
	Wed,  9 Sep 2026 14:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963444;
	bh=nCE/pwt7e+OE/4V5LSJeDlk9/gMjMOhg+uRo63HCr7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MKneQru9wB/GXlGNEZNwaKsF5scy9AhdBJkX+L78yj3t6ThDOc7xiYwALhuTou13O
	 6aTt84VwXSkDR79NyD7bknGwYdm9Bf9vV4K4uUoaoj0K4YkJrNBTOfUhZ7dt6Vbla+
	 HDc4fQo/6gA45V9QHLZfyj4wYw86sFClt+JJUSinUliB3Oxwjt6JCgCx/RsnuLScFu
	 fm7Oct+MBEPmqGzCjRJzCjzV1WG3XCQKsQV6q0VVb771jrM8Q46en8KI19TYddSPg6
	 TYvv9maQdlwq05/b/SICtCD53k6FjVWAtcMQNA4TA1hqUZgHNqAneawnf7Kn6alJyj
	 +whz/pXM5r/4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 13/13] virt/steal_governor: Enable the driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260909135617.871006-14-sshegde@linux.ibm.com>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-14-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:17:23 +0000
Message-Id: <20260909141723.AF5971F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] preferred_cpus_valid() reads cpu_preferred_mask and cpu_active_mas=
k without holding cpus_read_lock(), creating a data race with CPU hotplug t=
hat causes the governor to permanently shut down.
--

commit b0d791ea69ac4f874448d3baf935e4825cba622f
Author: Shrikanth Hegde <sshegde@linux.ibm.com>

virt/steal_governor: Enable the driver

This commit provides a configuration option to enable the steal_governor dr=
iver
for paravirtualized environments. It enforces PARAVIRT and SMP dependencies=
 and
selects CONFIG_PREFERRED_CPU for core scheduler mechanisms.

> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index 52eb7e4ba71f6..eeb84e578ddf9 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -41,6 +41,23 @@ config FSL_HV_MANAGER
>            4) A kernel interface for receiving callbacks when a managed
>  	     partition shuts down.
> =20
> +config STEAL_GOVERNOR
> +	tristate "Dynamic vCPU management based on steal time"
> +	depends on PARAVIRT && SMP
> +	select PREFERRED_CPU

[Severity: High]
While this patch enables the driver, can the background loop in
steal_governor_loop() permanently terminate during a concurrent CPU hotplug
operation?

If a CPU is offlined, sched_cpu_deactivate() clears the target CPU from
cpu_preferred_mask and then cpu_active_mask without memory barriers. If this
happens concurrently, preferred_cpus_valid() in drivers/virt/steal_governor=
.c
might observe a torn state because it evaluates the masks without holding
cpus_read_lock():

drivers/virt/steal_governor.c:preferred_cpus_valid()
	if (!cpumask_subset(cpu_preferred_mask, cpu_active_mask)) {
		pr_err("preferred: %*pbl is not subset of active: ...\n",
		       ...);
		return false;
	}

If the check fails due to this race, the governor loop permanently shuts do=
wn
since it returns instead of requeuing the work:

drivers/virt/steal_governor.c:steal_governor_loop()
	if (!preferred_cpus_valid()) {
		restore_preferred_to_active();
		return;
	}

Would holding cpus_read_lock() during these mask checks prevent this race a=
nd
keep the loop running correctly?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909135617.8710=
06-1-sshegde@linux.ibm.com?part=3D13
