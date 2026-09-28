Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296FF3F483C
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574926; cv=none; b=u8WRsrY5Gz7FYBym/AcCO8nzHGyo1p1JvZJ6dLIuWNn7pcC9zvXzFfDHdkbknh+sGj9M4BwBOCvutwARC4/mvvAigJX5MnTLqSUZ0vLu+5BcAQneSjoqBa+CJXnfOaJ6FAge/SJXRo4iB70nqlUU6KLY+IZz7l40yfP3zrUv24c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574926; c=relaxed/simple;
	bh=SjaP6lbEedIN7E81pm1RKyk+5Zt/LuPRztmiP+pLv+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qgorsb+mT64nCJmTre+3fX2CcNQX5Kd0/Nlg9AGMRhaSpJ5ErihgZuJbdpEC+LsCQ9erzNHGXKXogCQzYCox+dMrZd93qPgSagFJAC/vpqimTSTF4/31UJJVRGUlm/ByEaCivPRYb6Wg3+hS5f4EhpW4wLjB5HF+BTlKapnAUd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZorVXmD/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZorVXmD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14B11F000FF;
	Mon, 28 Sep 2026 05:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574925;
	bh=9ErFzsOIBGLakneA2FG5VT5vKzeV93U8MDOGF7eFIHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZorVXmD/mF6T8Mw6ybGLXPFK4wj1rtxFf6IZ7BOFoTW9FR+nDaeOOKdjfgCiQIAiR
	 rz5QrvCbO9loBivUQXxAKCI9WZEOA6IaTlAxl+fnH75/PL6RGu4JEgpsBqMs9ZOJS9
	 iqp1XxHxsWJ/CV0sGKOOry4+9Fqx3aqm+/vj8AbBeuDb7X0AAhVTG5gjSfUF6oFpv6
	 +AF3odK5jRr1YuOwOtaYEXOePb2z8QAcB+x7UuV8/aL4+2vIbrSkLgWeAglamALgIQ
	 R+camg5rG7eIIXy3FvNQ0fWjSEIYXrshaX2v3AFHLFDELWoK/CRFzAVoVfint8bkSC
	 PYnnmBgawW/dA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 07/13] sched/fair: Load balance only among preferred
 CPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260928053728.797539-8-sshegde@linux.ibm.com>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-8-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 05:55:24 +0000
Message-Id: <20260928055524.C14B11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] sched: capacity mismatch in load balance due to restricted env->cp=
us
--

commit 614fa1366931a4c3a90955d4b7c85dd2e0e3bb49
Author: Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: sched/fair: Load balance only among preferred CPUs

This commit restricts load balancing to preferred CPUs to avoid conflicting
with the tick's push task mechanism. It replaces cpu_active_mask with
cpu_preferred_mask during load balance CPU mask initialization and bails
out early in newidle balancing if the CPU is not preferred.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 03206e15e6fe4..1c687c3c70f11 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -13467,7 +13467,7 @@ static int sched_balance_rq(int this_cpu, struct =
rq *this_rq,
>  	};
>  	bool need_unlock =3D false;
> =20
> -	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
> +	cpumask_and(cpus, sched_domain_span(sd), cpu_preferred_mask);

[Severity: High]
Will this change create a capacity mismatch in the load balancer?

When env->cpus is restricted to cpu_preferred_mask here, update_sg_lb_stats=
()
will only aggregate group load for those preferred CPUs:

kernel/sched/fair.c:update_sg_lb_stats() {
    ...
    for_each_cpu_and(i, sched_group_span(group), env->cpus) {
        struct rq *rq =3D cpu_rq(i);
        unsigned long load =3D cpu_load(rq);

        sgs->group_load +=3D load;
    ...
}

However, the group's capacity is set using the full capacity of all active
CPUs:

kernel/sched/fair.c:update_sg_lb_stats() {
    ...
    sgs->group_capacity =3D group->sgc->capacity;
    ...
}

Could the mismatch between the deflated group_load and the full group_capac=
ity
artificially lower sgs->avg_load?

This phantom spare capacity might cause the load balancer to aggressively p=
ull
tasks from other groups into the preferred CPUs of the destination group,
overloading them.

Can this also prevent tasks on non-preferred CPUs from ever being load
balanced?

kernel/sched/fair.c:sched_balance_find_src_rq() {
    ...
    for_each_cpu_and(i, sched_group_span(group), env->cpus) {
    ...
}

Because this loop uses env->cpus, the load balancer ignores non-preferred
CPUs entirely, even if they are overloaded.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928053728.7975=
39-1-sshegde@linux.ibm.com?part=3D7
