Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A430353FD2B
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964382; cv=none; b=hu78GDZ3Xm376PWeqAZv4AJ1HudJJ2vz1AqbZJZFcTTaws4a06JS8zLlnPv0jCI6nzSbqjeLfJb3gp1bY19FTLAQWcHFNhy4O4nQ45cA7NoF/WhqujUFhran+8P8OHJhFueE6KYIWmxAXTZuytXW3FcNo4JaUvuFb01TQm6I5qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964382; c=relaxed/simple;
	bh=S4n5E5QplFyVs3/CYHOlIt0p3jP/HDRDuStan1ZQadc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S0LFjyehcR3wEwPAvd7CHEG0ZfI9/jYX+ITPr8ZstdRBjD18YGlhKXI/TCV/tJYcqgPpYLimK+Q8ok7eOpfONrq+L17belvd2s2eObQM996t689APFSEdxDYQMBjSVY3aCRVGSvkZsjKGah4W4YNeae3RPlYVbbpp/+UT26IaqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fz7K5wSs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fz7K5wSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F121F00A3D;
	Wed,  9 Sep 2026 14:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788964381;
	bh=49hDKVNmrmF6Z1u3YC4dQ33SC52kII1mYP4H7LtuXhg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fz7K5wSsh/J21F3M0lx7Dsr8uoREV/nyhuls+txd8BfV+sUso9zF/I4icYR8tmX1/
	 EF4m+rIPlV7PhGXCBYLADOfyhXLYUrPk1ZMuMoEKVR3Om9I7x/MtTIhG2hLUL9JgpK
	 x97Xf7uX+b76bPNdg8XLj3rBZSg3rVufra880vJwX3TfCTXyfAhyCM+XdsyOMFJPrg
	 PjD2acZHhhK2CaX/Xodn58PcVOpqog4dXw7y4PgWX2wXm5fD1WF9AH1/auLJGcHYOi
	 7zKgQQM3a1Ii2CRfWLCpJal06kJF42vpeMm3HpwLsGOx40qmpRodafN+rRqClT5vhd
	 0xJP+jNfP+Nrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 07/13] sched/fair: Load balance only among preferred
 CPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260909135617.871006-8-sshegde@linux.ibm.com>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-8-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:33:00 +0000
Message-Id: <20260909143301.46F121F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Group statistics (`avg_load`, `group_has_spare`) and load balancin=
g math are corrupted because load and utilization exclude non-preferred CPU=
s, while group capacity and weight incorrectly include them.
- [High] Periodic and busy load balancing can be completely disabled for a =
scheduling domain if the statically designated `group_balance_cpu` becomes =
non-preferred.
--

commit 2dcc3be382ec42f554b59dc47da29e35996ce2d6
Author: Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: sched/fair: Load balance only among preferred CPUs

This patch modifies load balancing to only consider preferred CPUs,
aiming to prevent balancing against the push task mechanism. It
updates sched_balance_rq() and sched_balance_newidle() to restrict
operations using cpu_preferred_mask.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b8bd308c2d5b1..4ef1167b8c73f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -13473,7 +13473,7 @@ static int sched_balance_rq(int this_cpu, struct =
rq *this_rq,
>  	};
>  	bool need_unlock =3D false;
> =20
> -	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
> +	cpumask_and(cpus, sched_domain_span(sd), cpu_preferred_mask);

[Severity: High]
Does restricting env.cpus to cpu_preferred_mask here corrupt the group
statistics calculation in update_sg_lb_stats()?

Looking at update_sg_lb_stats(), it accumulates load and utilization by
iterating only over env->cpus:

kernel/sched/fair.c:update_sg_lb_stats() {
    ...
    for_each_cpu_and(i, sched_group_span(group), env->cpus) {
        ...
    }
    ...
    sgs->group_capacity =3D group->sgc->capacity;
    sgs->group_weight =3D group->group_weight;
    ...
}

Since it assigns the full capacity and weight of the entire group, but only
accumulates load for the preferred CPUs, won't this artificially deflate
avg_load? This could cause the load balancer to perceive mixed groups as
severely under-loaded and aggressively pull tasks to already overloaded
preferred CPUs.

[Severity: High]
Can this also completely disable periodic and busy load balancing for a
scheduling domain if the statically designated balance CPU is non-preferred?

Looking at should_we_balance():

kernel/sched/fair.c:should_we_balance() {
    ...
    if (!cpumask_test_cpu(env->dst_cpu, env->cpus))
        return 0;
    ...
    return group_balance_cpu(sg) =3D=3D env->dst_cpu;
}

If the statically designated group_balance_cpu(sg) is non-preferred, it
will abort immediately because it is excluded from env.cpus. All other
preferred CPUs in the group will also abort because they fail the
group_balance_cpu(sg) =3D=3D env->dst_cpu check.=20

Does this mean no CPU will perform the domain balance, potentially causing
severe starvation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909135617.8710=
06-1-sshegde@linux.ibm.com?part=3D7
