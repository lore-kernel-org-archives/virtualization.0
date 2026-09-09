Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC7582BB6
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963373; cv=none; b=HKRYpbFWoEFL4BWzQgYUXOzijlD6kE/W5qfGTEOKODGQK4LDDNIT+lMTQ5C+EQDTbDLAbNWUnGrde+Ywc0nk95OxC11wvoCEGPI6siv0E9/Hv94vOuyzpifEXOn7prb3bAprlglBtglTBFgV6j1O3FBo3TgLmWE0s3uwAV3t+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963373; c=relaxed/simple;
	bh=g1i3Eo6h8TQM+VcYRum75cXtcRrravIbVHght8CLBrI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VfQcsa/hoKHJ8ggNJnFTCsZ6AguJFOOUuKWdBA5H7zH4GcsFi+zDZj7QaZKyj+MRVpx1QCJ+RTPHCI04BbZ3pc/o9whoM5+iQ/1xJwvKztWQnSXZMVbsQEBW03/Actzhd3vLrwl82JgOcZUmBRGs97jLNVBUYRjhR8b0XJp9RPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3h+scoJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3h+scoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11461F00A3D;
	Wed,  9 Sep 2026 14:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963372;
	bh=okeHHUx0uHvlAKd3B1pCL4kfrezX1K3FlMA05oqQVUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W3h+scoJGqYn88OgnHcszfGuk+JAKvqrRpnrZy/bnIoPepRwLYN8ZtYbQYUQHz0AI
	 hgLLnjW4pZ7/br2IJXEwFRpb/iogqIVNbZ+c3eUdbNG2RT++UAs/AGAfzZ8Q8wiE+9
	 HG1WhZ3fZJ7lZMV0xDNOCum2HM94UJRkZSHtD4vZjmBLe2GFtyPy8/JqnQMeKVJJhy
	 fxr9tu/BgrAby8+texkynXzLGY0Kib8FuHtebPHAtNR3SUKR3PHY2VqLgbVSlaiNuP
	 niz9GIuwPFxCGOeDhB2UJqW+okidN8Whs4rNqamYwRnrxA9O0uQqIhPv1MYOJDtC8e
	 WFgXJS/kTnOOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 01/13] sched/cputime: Add kcpustat_field_total
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260909135617.871006-2-sshegde@linux.ibm.com>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-2-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:16:11 +0000
Message-Id: <20260909141611.F11461F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Splitting a single iteration loop into two independent passes ov=
er a concurrently modified cpumask introduces a TOCTOU race, causing a mism=
atch between accumulated steal time and CPU count.
--

commit f4767f1bec53619b21fdac4c5195173936031ed9
Author: Shrikanth Hegde <sshegde@linux.ibm.com>

sched/cputime: Add kcpustat_field_total helper

This commit introduces a new helper function kcpustat_field_total() to sum =
up
a given cpustat over a specified cpumask. It then refactors existing code in
the s390 hiperdispatch and procfs uptime to use this helper to simplify the
code and avoid duplication.

> diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperdis=
patch.c
> index 2172065222661..c21496f0a141a 100644
> --- a/arch/s390/kernel/hiperdispatch.c
> +++ b/arch/s390/kernel/hiperdispatch.c
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

[Severity: Medium]
Does splitting this single loop into two independent passes over
hd_vmvl_cpumask introduce a race condition?

If CPU hotplug operations modify hd_vmvl_cpumask concurrently between the c=
alls
to kcpustat_field_total() and cpumask_weight(), could this result in a
mismatched numerator and denominator?

For example, the first read could see a large mask, while the second read s=
ees
a smaller mask. This mismatch can cause transient artificial spikes in the
steal percentage.

Could this incorrectly trigger a scheduler domain rebuild
(topology_schedule_update()) and lead to an unnecessary performance degrada=
tion
during CPU hotplug operations?

>  	/*
>  	 * If there is no vertical medium and low CPUs steal time
>  	 * is 0 as vertical high CPUs shouldn't experience steal time.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909135617.8710=
06-1-sshegde@linux.ibm.com?part=3D1
