Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206435;
	b=f5xhGPSKxJM8KbpiaegiEyquaAUPH+oM1jk6YyWmoJp20pjwlCsm5CgZ8jQ3tz35uskv
	 lucSE7+JOe9inIOFuVEPMoUZeZl7EGP++db8+4HqJptCy7ielWiQJaoU8WnhIzbMPxmcI
	 KZ1dzUWgkLbSe/XfzaHsjqgr4P3D5hQo8+XXNF/jqNMQYvYCnzK2bMHZ54qVOcrMHMoos
	 lWLfmDTpViNGkWGM/Yd0m6MK0e9uNp3az5zpybSY33sHBC60hG6atqNHWbQKREzNLhE7Z
	 Od0Ict6DKY83U5dKjE20ocJ2D7u2QVPfZApQU+POBKfy2q92tYBdWMo07TqXrDDHzfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206435;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZiyD7iz/aIGGNgXv+JvKD6DIeSWlbkixSkZaxiGvEZw=;
	b=m1YhKClGY89RJnsfwm6x2dKE/6dj4rZ4Zfo3+uBUb0AOdsoOlgetGdE8NGnSQC3hMFws
	 6NcWtOliYVmUfLxa76VBGkgjfL4OvFSMfqHbhNufKE06tfEbr7ke2u4pq+i2fw1Ve/+6l
	 t6fJ0ccMJmzACVeZqnRywPrVDFinU18XMSkZXkHQbmHjUwejtNX9B8pj9PKiU9ZB7J4Ys
	 zshBdI3OCSWFl6sRpLKAT7evW195OagypwSHpbFzZGReD6EaXH2rwrF3+alJSjiAwCkzr
	 q+lxisGMkvefMPHqkHrn8JcnNtPzCDsJyjfz75P1iK8W4WkOqPNqdiUkL+dqUP+3K0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmx2XHfU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7A5606A321
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmx2XHfU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3881F0089F;
	Mon,  9 Nov 2026 06:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794206433;
	bh=ZiyD7iz/aIGGNgXv+JvKD6DIeSWlbkixSkZaxiGvEZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nmx2XHfUXU+kw/50lDMvD5rWuBlVb3QHknlXRN7vkvwkWWkXWnkoZIrlO9qdVrK2A
	 //2vzvqLLGu197s51OMTcOzlySxjJR0qol6yNTSLIfg1ARmkv124GolTrAAqrVZ6PC
	 nEUujUluNp0IPAPaKjZPprZLc6pkWCPhXIQfnFOKLQRwXmmt2A955Uo0Z9JtHUhBvi
	 EG0MlBYMhlyM4IEWIGVtPIk/KH0NVzey1YmvM7SYagv46OQbR9RVHJtt1txCAK/7bf
	 FModn1A7QOz5MPW6SaVDsnceHU6hs3tRLN4uY6f6s2TLQ4bdIWrFtss/866GH+5W2k
	 RMek+CQDlWhAQ==
Message-ID: <sashiko-outbox-204499@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] virtio_balloon: drain update works on probe error
 paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mingbing Zhai" <zhaimingbing@cmss.chinamobile.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109062152.1097-1-zhaimingbing@cmss.chinamobile.com>
References: <8f914911-8453-4f8f-b02f-384114f9d4ef@kernel.org>
 <20261109062152.1097-1-zhaimingbing@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 06:40:33 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] virtio_balloon: inaccurate Fixes trailer commit in commit
  message
--

commit 86ecd6e43dcbe0f92a723582119232b2820f4329
Author: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>

> virtio_balloon: drain update works on probe error paths
>
> init_vqs() arms the stats virtqueue callback, so an update work can
> already be queued on the system freezable workqueue while
> virtballoon_probe() is still running.  If a later probe step fails, the
> error unwind deletes the virtqueues and frees vb without stopping the
> works, and the queued work runs after the balloon struct is gone:
>
>   BUG: KFENCE: use-after-free read in virtqueue_get_buf_ctx
>    update_balloon_stats_func+0x121/0x300
>    Workqueue: events_freezable update_balloon_stats_func
>
> remove() already handles this via virtballoon_quiesce().  Factor the
> stopping of the update works out of it and run it on the probe error
> path as well, before the queues and vb go away.
>
> The same hole exists when init_vqs() itself fails after
> virtio_find_vqs() succeeded: the stats priming can fail with the queues
> up and the callback armed, yet probe jumps straight to out_free_vb and
> leaks the virtqueues while the queued work still references vb.  Unwind
> inside init_vqs() in that case, stopping the works before the queues
> are deleted.
>
> Also reset the device before del_vqs() on these paths, like
> remove_common() and the virtio_net/virtio_scsi error unwinds do:
> without the reset the queues stay enabled on the device and the next
> probe fails in setup_vq() with -ENOENT.
>
> The drained work takes vb->wakeup_lock in process_wakeup_event() and
> finish_wakeup_event(), so this depends on "virtio_balloon: initialize
> wakeup_lock before virtqueues are set up", which moves that
> spin_lock_init() to the top of probe.
>
> Fixes: 1f34c71afe51 ("virtio: Fix scheduling while atomic in virtio_ballo=
on stats")
> Reported-by: syzbot+0f659760bac1ecb01812@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D0f659760bac1ecb01812
> Signed-off-by: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>

[Severity: Low]
In 1f34c71afe51 ("virtio: Fix scheduling while atomic in virtio_balloon
stats"), stats_request() only set vb->need_stats_update and woke the
vballoon kthread, which was created as the final fallible step in
virtballoon_probe(), and init_vqs() called BUG() if stats_vq priming
failed.

The undrained work on the virtballoon_probe() error path was introduced in
fad7b7b27b6a ("virtio_balloon: Use a workqueue instead of "vballoon"
kthread"), and the early error return in init_vqs() without cleaning up the
virtqueues was introduced in 74cf5b169c4c ("virtio-balloon: remove BUG() in
init_vqs").  Should the Fixes: tags reference those two commits instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109062152.1097=
-1-zhaimingbing@cmss.chinamobile.com?part=3D1
