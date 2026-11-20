Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176213;
	b=gzYoV8YrCjg7ngFhAdyBsJH4TSsWomPijl7ePgfkmhVCvjREsCR+49i3erTtWR39564w
	 JQ+ZdS4aeOgu36eRzZ1xy904DoXi7LL0A38eAzrzbrVEtQWr2xY5RbvsHx9LZ/SjB1OVg
	 CpJN26c5+JKVcN48oW/8Wl58ublDOldJgK6LKzoF4NtId5IwVJnJ3KAPNwiyZSmKgRB9Z
	 8igRJn0gSY4o9YResto3xOSIM7KIoIRpFrITJZGHqcVPNbtDCzW0QcinXLTqx4kPKekLb
	 PTUgjmOLlO2s5VamRi7dwPa1jcCoNeCmVKXI13L/ZgKdULdvjrb3JbWCUZ+KzXEOhNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176213;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HsgHV0quLYYKk4mxB/bu1tZX7bUFJNZxSMDfjRQjlJA=;
	b=bnS5ISd4yfhu+X4qmYtv3by/WAF44MBPsOuPoq5LE51us7Dc4+7i401DV1kDnFRC/vax
	 ozoJR5tcAqN45tqh6sU/d6joz0GeZhFnL9c23g3Yn5BSUGNCgucC25u+llY+sini62i4g
	 IXPa6+XbzgWUbXYaHZB63cMjg4o7aeujAP4fy04iLlNA3GqQXI5ll0KWYGWbaTzEvFcPa
	 KKNFxAoxBIDdBEPTf3sJLQEy3y5XxXEJxOdhfFDAw9oqubxv/ucbG5cSk8ivgP6tsYvTT
	 gV1Yeq2Rz1O3yoj3bolDAptjGxSvag/afrPWvX45EpCfRoWcP0NywSQi3D1/ZgDqo6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAIbLE0S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54D6606A320
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAIbLE0S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304451F000D0;
	Fri, 20 Nov 2026 12:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795176213;
	bh=HsgHV0quLYYKk4mxB/bu1tZX7bUFJNZxSMDfjRQjlJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JAIbLE0SH66We0axqp5/5KdlL4zj67ge49JQ2cCV9dAz/iTIwzwB1SRZPYmdXduU3
	 EwcST2h/+/KodO8RL8AG0apwubEEUVrFqF8j0kW//ZNishM9rVOOFt82L307NJL8pO
	 DbYjVJ1nseWtSoajx3IAJAeNE87VcC/z36Ujzx0HRFpQg1AOzB1wX91VprScfL3KZo
	 q10aRKZDEY6WcjRaayp0kLp+lOTUsEum1g1C6jfZvMrUe0ICOz8u1on8flgB+nKpZ/
	 N4eygASNQ2HAXbIdEnRREuF/O2UWfIGrkWPY6oL3vMdCM7mW83e0COyYtE1JCuK6Ol
	 1zf9qnS+uszaQ==
Message-ID: <sashiko-outbox-225116@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 7/7] mm: page_reporting: add flush parameter with
 page budget
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "David Hildenbrand" <david@kernel.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Brendan Jackman" <jackmanb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Suren Baghdasaryan" <surenb@google.com>, "Jason
 Wang" <jasowang@redhat.com>, "Andrea Arcangeli" <aarcange@redhat.com>, "Dev
 Jain" <dev.jain@arm.com>, "Geert Uytterhoeven" <geert@linux-m68k.org>, "Greg
 Ungerer" <gerg@linux-m68k.org>, "Gregory Price" <gourry@gourry.net>,
 =?utf-8?b?SHVhbmcsIFlpbmc=?= <ying.huang@linux.alibaba.com>, "Lance Yang" <lance.yang@linux.dev>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Magnus Lindholm" <linmag7@gmail.com>, "Matthew
 Wilcox" <willy@infradead.org>, "Miaohe Lin" <linmiaohe@huawei.com>, "Zi Yan" <ziy@nvidia.com>, linux-mm@kvack.org, virtualization@lists.linux.dev, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Brendan Jackman" <brendan.jackman@linux.dev>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <2d518dd7b8f7be147b9a957ad94f6c6641e4b5ef.1795089715.git.mst@redhat.com>
References: <cover.1795089715.git.mst@redhat.com>
 <2d518dd7b8f7be147b9a957ad94f6c6641e4b5ef.1795089715.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 12:03:31 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] mm: page_reporting: redundant work flush in
  page_reporting_flush_set()
- [Medium] mm: page_reporting: hardcoded capacity in
  page_reporting_flush_set()
- [Low] mm: page_reporting: unused variable and get op for write-only
  flush param
--

commit 18e2a422153fdecadcaa01e59911f68043266f81
Author: Michael S. Tsirkin <mst@redhat.com>

mm: page_reporting: add flush parameter with page budget

This commit adds a write-only "flush" module parameter to trigger
immediate page reporting up to an approximate page budget.

> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index 841dcd64777d1..74c03844fc3e9 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -360,6 +360,46 @@ static void page_reporting_process(struct work_struc=
t *work)
>  static DEFINE_MUTEX(page_reporting_mutex);
>  DEFINE_STATIC_KEY_FALSE(page_reporting_enabled);
> =20
> +static int page_reporting_flush_set(const char *val,
> +				    const struct kernel_param *kp)
> +{
> +	struct page_reporting_dev_info *prdev;
> +	unsigned int budget;
> +	int err;
> +
> +	err =3D kstrtouint(val, 0, &budget);
> +	if (err)
> +		return err;
> +	if (!budget)
> +		return 0;
> +
> +	mutex_lock(&page_reporting_mutex);
> +	prdev =3D rcu_dereference_protected(pr_dev_info,
> +				lockdep_is_held(&page_reporting_mutex));
> +	if (prdev) {
> +		while (budget) {
> +			budget -=3D min(budget, PAGE_REPORTING_CAPACITY);

[Severity: Medium]
Should this decrement budget by prdev->capacity instead of
PAGE_REPORTING_CAPACITY?  A driver can register with a smaller
prdev->capacity than PAGE_REPORTING_CAPACITY, which is what
page_reporting_process() uses to size each batch, so using
PAGE_REPORTING_CAPACITY exhausts the requested budget too early.

> +			flush_delayed_work(&prdev->work);
> +			__page_reporting_request(prdev);
> +			flush_delayed_work(&prdev->work);
> +			if (atomic_read(&prdev->state) =3D=3D PAGE_REPORTING_IDLE)
> +				break;

[Severity: Medium]
Does calling flush_delayed_work(&prdev->work) both before and after
__page_reporting_request(prdev) inside the loop run two reporting passes
per iteration and an extra pass after all pages are reported?

When page_reporting_process() finishes a pass with more pages left to
report, it already re-schedules prdev->work before returning:

mm/page_reporting.c:page_reporting_process() {
    ...
	state =3D atomic_cmpxchg(&prdev->state, state, PAGE_REPORTING_IDLE);
	if (state =3D=3D PAGE_REPORTING_REQUESTED)
		page_reporting_schedule_work(prdev);
}

Whenever prdev->work is already queued (including every iteration after
the first), the first flush_delayed_work() runs a full reporting pass.  If
that pass finishes all remaining pages and sets prdev->state to
PAGE_REPORTING_IDLE, __page_reporting_request() immediately transitions
prdev->state back to PAGE_REPORTING_REQUESTED and queues another pass that
the second flush_delayed_work() executes across all zones.  If unreported
pages remain after the first flush, page_reporting_process() has already
queued prdev->work again, so the second flush_delayed_work() runs a second
full pass in the same iteration while only decrementing budget once.

> +			if (signal_pending(current))
> +				break;
> +		}
> +	}
> +	mutex_unlock(&page_reporting_mutex);
> +	return 0;
> +}
> +
> +static const struct kernel_param_ops flush_ops =3D {
> +	.set =3D page_reporting_flush_set,
> +	.get =3D param_get_uint,
> +};
> +static unsigned int page_reporting_flush;
> +module_param_cb(flush, &flush_ops, &page_reporting_flush, 0200);

[Severity: Low]
Since flush is a write-only parameter and page_reporting_flush_set() never
touches page_reporting_flush, should flush_ops.get and
page_reporting_flush be dropped (passing NULL to module_param_cb()) so
param_attr_show() returns -EPERM if the sysfs mode is changed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795089715.gi=
t.mst@redhat.com?part=3D7
