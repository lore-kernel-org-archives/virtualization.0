Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625421;
	b=XxJaHsy2Mb+ORsTHoIT5rjG9iV8BV+CHxBDedDOdauEY596fB7Zsav1KFjYMQT4i4Z3M
	 v1Zq6wXO/x1kSpLWxBaGGL6lhOV6F9VRklvf2D6FC+IbB/49j5M8TmGE7l3QV8BRFc5Fy
	 KlOL0qga0F/+nCs87Z9yBSOVgJB6ckwIfzVim0tW2dO1VxN61NCmY0GxX4QJO4DDm4gZG
	 XpnryuPf60P4EFYKV1UOTp6WCeSzjx8vtMwWlpY7Ug2BiSXp6qMiIZnETPKD9/kCYjN73
	 dLjR4/8/sIi5dbDyKjWwhyRz1oMZCnqhY4Gcwwd0A+Xe+/8hum90i4foPhEUdMsyk/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625421;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ir6FbwZSNiaWiV+I6i7iN9AQfmkcbgxAJM3HyQge9rQ=;
	b=BO4fpe1lVSPcrhAUsQ0tQ5EtyPPsPRX63clj61kRX2dqIEYNtzfOZDSVq0cp1IcRocHv
	 tOAHJAbcL58xLKujIy5+cke3ux6qOICu7U+KrVJZ+ZwtTvl4un43rgInXqNeNsqDjz6mQ
	 AT2/U25I6Eb8uqGDGhO8Gl11su3uSirD7EPK0xh0Z7vtlXGdCxCQ+N2MQ5gcjTdXAUkAB
	 tvTqsKFstba9icMszVox44/3ySIm+C8vjcvqBDp/Biq4Cgixxw338fP2nNsLo5JaGzLql
	 6p8vVLpv3W4A0SZze7xfap5AREgT1MfvDpggxOREo53A9/fOZLg2XgA/PaQRnt0YFCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DR7lQMUc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3934606A31A;
	Wed, 21 Oct 2026 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DR7lQMUc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BB61F000C1;
	Wed, 21 Oct 2026 23:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792625420;
	bh=Ir6FbwZSNiaWiV+I6i7iN9AQfmkcbgxAJM3HyQge9rQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DR7lQMUcicvA8njwYFjeA/FLreJIMOVRE5xkX+5P1hUx42fQbxqltLUL76NT6yosG
	 8MvzUJqKEAK+WWwZapPcgIDWqopqayOrjM2xgehMmJHpDkwNZ4NlWVtTRSf/9sVJke
	 tzduvKkOJZAjCWfoz/KO8p6SLJFUrqYEUI553HdNaUcD5aM5QpmCuk0scSGaJFYtgE
	 K2C809FrNNvKF9kZYnwd3/S/cV0sy+dvxMkxEUJh1hs7BQJ8jqgvexL92HNUM3q9r0
	 fijYapjGVAWfQpVtBXcUYX74Qiax8REv8W6iVfI8cy/7TxzOHxsFE1scvjDuPlmudH
	 CP74KOuI6+YAw==
Message-ID: <sashiko-outbox-180785@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost: fix used ring index wrap in
 vhost_add_used_n_in_order
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fang Xieyan" <fangxy@xiaopeng.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261020232956.99970-1-fangxy@xiaopeng.com>
References: <20261020232956.99970-1-fangxy@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 23:30:19 +0000
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
- [Critical] vhost: wrong start index for log_used() in vhost_add_used_n_in=
_order()
--

commit dd320e3245fc3d77e9d6856274ea3ebedcc56808
Author: Fang Xieyan <fangxy@xiaopeng.com>

vhost: fix used ring index wrap in vhost_add_used_n_in_order

This commit masks start with (vq->num - 1) inside the loop in
vhost_add_used_n_in_order() so that advancing start by nheads[i] cannot
leave start >=3D vq->num when logging used-ring updates.

> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 4d5d32e68d35f..b1a9f8f05cf65 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -3188,8 +3188,7 @@ static int vhost_add_used_n_in_order(struct vhost_v=
irtqueue *vq,
>  		}
>  		start +=3D nheads[i];
>  		new +=3D nheads[i];
> -		if (start >=3D vq->num)
> -			start -=3D vq->num;
> +		start &=3D vq->num - 1;
>  	}
> =20
>  	if (unlikely(vq->log_used)) {

[Severity: Critical]
Does masking start inside the loop still leave the log_used() calculations
in drivers/vhost/vhost.c:vhost_add_used_n_in_order() broken, allowing
out-of-bounds writes to the dirty-log bitmap as well as missed dirty-page
logging?

Before the loop in vhost_add_used_n_in_order(), used is anchored to the
initial start index, and then the loop advances and masks start on each
iteration:

	start =3D vq->last_used_idx & (vq->num - 1);
	used =3D vq->used->ring + start;

	for (i =3D 0; i < count; i++) {
		if (vhost_put_used(vq, &heads[i], start, 1)) {
			vq_err(vq, "Failed to write used");
			return -EFAULT;
		}
		start +=3D nheads[i];
		new +=3D nheads[i];
		start &=3D vq->num - 1;
	}

	if (unlikely(vq->log_used)) {
		/* Make sure data is seen before log. */
		smp_wmb();
		/* Log used ring entry write. */
		log_used(vq, ((void __user *)used - (void __user *)vq->used),
			 (vq->num - start) * sizeof *used);
		if (start + count > vq->num)
			log_used(vq, 0,
				 (start + count - vq->num) * sizeof *used);
	}

When vq->log_used is enabled, the first log_used() call pairs the pre-loop
used pointer with the post-loop start index. If start wraps around the ring
during the loop so that the post-loop start is smaller than the initial
start (for example, initial start =3D vq->num - 1, count =3D 1, nheads[0] =
=3D 1,
ending with start =3D 0), then (vq->num - start) * sizeof *used logs
vq->num elements starting from vq->used->ring[vq->num - 1], extending
(vq->num - 1) elements past the end of vq->used->ring.

Similarly, in the second log_used() call, on the vhost-net receive path in
handle_rx(), count can reach 65 while vq->num is 32. If the post-loop start
is 31, (start + count - vq->num) * sizeof *used logs 64 elements from the
start of vq->used, again extending past the end of the 32-entry ring.

Because drivers/vhost/vhost.c:vq_log_used_access_ok() only validates the
bitmap range covering vhost_get_used_size(vq, vq->num):

	return !log_used || log_access_ok(log_base, log_addr,
					  vhost_get_used_size(vq, vq->num));

can logging past the end of vq->used->ring cross a page boundary and cause
log_used() -> log_write() to set bits beyond the end of the userspace
dirty-log bitmap?

Conversely, because each iteration writes a single element at the strided
index start before advancing start by nheads[i], can this also fail to log
dirty pages that were actually written (for instance, when start wraps
during the loop with post-loop start + count <=3D vq->num so the second
log_used() call is skipped, or when nheads[i] > 1 causes the total span of
written ring entries to be much larger than count)? Would it make more sense
to log each written entry inside the loop, or compute the logged range from
the initial start index and total advance (new - old)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020232956.9997=
0-1-fangxy@xiaopeng.com?part=3D1
