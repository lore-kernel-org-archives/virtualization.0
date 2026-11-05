Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880363;
	b=UB473diq1ywowwpvfgcMjJ5+tGrtjV/xxx8AD3rv5/Wfm9qq2nLvauR5g4BoblQ3BOVf
	 KSLvfXJmM+DbwHApDk8OPmsjJO1jcbOGggf9iH65JY8QyWndNcWUu1KdItY9Ii8fg6Mvs
	 mmugihgUyDu6k/HPNJplFZfnribWVcgHKpHflIaNNwh7wipNiBnfou5NCQhSrurIbNnTs
	 iGlKiTfsqhe5Q199vVe6EGIwEatVqMHlq+kCtx5ym+HZGHbYGXMCR8Il4wdyltT6VRwRb
	 MAHS37HkGADRikHHrOt4p0lTMR8MibTRmeDgvIgbMTc2+smQs4npOPMixVVxU4mu17A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880363;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vkqKskyQ0ZOuzrr2K2yazMMuotx0yM/8WB0ng1c8dSQ=;
	b=N25F1PevfjF6TPYfXpVwCUv0V7tLEnoOcbcvIlg6aydhwCgpf+Nbi39olCYufYRp5o6l
	 OGP+W6cpd4HABn1ItMw8J60CA20fLnsgvNqrTBEtLtdTycn+Z+f18l8Xz7rv740lrAO08
	 bOAeDkH4Vz2ZTz8VkpqLMP9c4unP05o9hW7Vp8860XzFHdDC60kmolqXpx+gP7Lyb8YP2
	 QJ6eQqHUQdrKmd/NOm0fyLDDJZmL4MnVqMr1VCcLUyuHqax0kcoHJ2stDqcxRZ8vgtkcQ
	 caSpvC+Y4wHUpdgNvjhs+398AEyJOBvU4fW8wsShp1vueomJFI+qoYmrVLKHNJABKMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6Yv2llY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDE3606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6Yv2llY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC5C1F000C1;
	Thu,  5 Nov 2026 12:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793880362;
	bh=vkqKskyQ0ZOuzrr2K2yazMMuotx0yM/8WB0ng1c8dSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d6Yv2llYl9uQp8hMTALhEDJviLUM1hkV78RUbFNMnIY7LTYskkz1DSbpwcK7md+Iz
	 8D5hpV9AKth3M2qRCxGtDy+o6+nAkaDtsqrcGEQPdAXem1BdAXUvHoCVvNu0wenpgx
	 PnMOgmL5rLeiyp3NWi2zv8y2DqQ11/opCBPJP59IFNXgT+5RuptH4iTk6weAsp4At/
	 HmnlQfhNKopE8dhqIAlkfxTh6sCjb2zdfxUzTMVZ465EtquNtPEu2aomT0OCB47ztZ
	 xnd1CRNMpmnOJXkLP/LpgDieWhsk+zZcPrbS/OX7wUY5pao5VG8LrHOywZwLn2Lrwl
	 c72OFM+O7pKgQ==
Message-ID: <sashiko-outbox-198992@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] virtio_console: fix buffer ownership and unplug
 races in the read path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yaohan Li" <shunsheng1218@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105114535.972013-1-shunsheng1218@gmail.com>
References: <20261105114535.972013-1-shunsheng1218@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 12:06:01 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] virtio_console: NULL portdev dereference and vq access in in_intr(=
) on unplug
- [Medium] virtio_console: poll and O_NONBLOCK read mismatch when inbuf_cla=
imed is set
- [Medium] virtio_console: fill_readbuf() returns 0 instead of -ENODEV on p=
ort unplug
--

commit c34e695a42ae05ed26e613884cc4fae84545b23a
Author: Yaohan Li <shunsheng1218@gmail.com>

virtio_console: fix buffer ownership and unplug races in the read path

This commit introduces an ownership claim protocol (port->inbuf_claimed) and
an unplug flag (port->unplugging) under port->inbuf_lock to serialize buffer
access in fill_readbuf() and prevent input virtqueue operations during port
teardown.

> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 019bcae81af5c..191dceb77df1b 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c

[ ... ]

> @@ -541,10 +558,28 @@ static bool port_has_data(struct port *port)
> =20
>  	ret =3D false;
>  	spin_lock_irqsave(&port->inbuf_lock, flags);
> +
> +	/* The port is going away; its vqs are being torn down. */
> +	if (port->unplugging || !port->portdev)
> +		goto out_unlock;
> +
> +	/*
> +	 * A reader owns the claimed buffer, possibly sleeping in
> +	 * copy_to_user().  Report data as pending for the
> +	 * EOF/host-disconnect logic, but do not prefetch the next
> +	 * buffer: the claimer's unconsumed remainder must go back to
> +	 * inbuf first, or the prefetched buffer would be dropped.
> +	 */
> +	if (port->inbuf_claimed) {
> +		ret =3D true;
> +		goto out_unlock;
> +	}
> +
>  	port->inbuf =3D get_inbuf(port);
>  	if (port->inbuf)
>  		ret =3D true;
> =20
> +out_unlock:
>  	spin_unlock_irqrestore(&port->inbuf_lock, flags);
>  	return ret;
>  }
> @@ -692,24 +727,111 @@ static ssize_t __send_to_port(struct port *port, s=
truct scatterlist *sg,
>   * Give out the data that's requested from the buffer that we have
>   * queued up.
>   */
> +static bool will_read_block(struct port *port);
> +
>  static ssize_t fill_readbuf(struct port *port, u8 __user *out_buf,
> -			    size_t out_count, bool to_user)
> +			    size_t out_count, bool to_user, bool nonblock)
>  {
>  	struct port_buffer *buf;
>  	unsigned long flags;
> +	bool free_requeue_buf =3D false;
> +	int err;
> +
> +	if (!out_count)
> +		return 0;
> +
> +retry:
> +	spin_lock_irqsave(&port->inbuf_lock, flags);
> =20
> -	if (!out_count || !port_has_data(port))
> +	/* The port is going away; its vqs are being torn down. */
> +	if (port->unplugging || !port->portdev) {
> +		spin_unlock_irqrestore(&port->inbuf_lock, flags);
>  		return 0;
> +	}

[Severity: Medium]
Should fill_readbuf() return -ENODEV instead of 0 when to_user is true and
port->unplugging || !port->portdev is set?

In port_fops_read() and in the second wait path of fill_readbuf(), hot-unpl=
ug
(!port->guest_connected) returns -ENODEV to userspace to distinguish port
removal from a normal host disconnect (0):

drivers/char/virtio_console.c:port_fops_read() {
	if (!port->guest_connected)
		return -ENODEV;
}

However, if a blocking userspace reader waits on port->inbuf_claimed in
fill_readbuf() and is woken by unplug_port() setting port->unplugging =3D t=
rue,
jumping to retry hits this check and returns 0 instead of -ENODEV.

Similarly, if unplug_port() runs after port_fops_read() checks
!port->guest_connected, or between the two spin_lock_irq(&port->inbuf_lock)
critical sections in unplug_port() (where port->unplugging =3D true is set
before port->guest_connected =3D false), port_has_data() returns false and
port_fops_read() or fill_readbuf() can return 0 or -EAGAIN instead of
-ENODEV.

> =20
> +	/*
> +	 * Another reader (a userspace read() or the HVC console poll)
> +	 * owns the claimed buffer, possibly sleeping in copy_to_user().
> +	 * Prefetching the next buffer here would drop or reorder the
> +	 * claimed data once the owner returns its unconsumed remainder,
> +	 * so report no data instead.  The HVC poll will simply retry;
> +	 * a userspace reader waits for the claim to be released.
> +	 */
> +	if (port->inbuf_claimed) {
> +		spin_unlock_irqrestore(&port->inbuf_lock, flags);
> +		if (!to_user)
> +			return 0;
> +		if (nonblock)
> +			return -EAGAIN;

[Severity: Medium]
Can returning true from port_has_data() while returning -EAGAIN here cause a
busy loop between poll() and non-blocking read() when port->inbuf_claimed is
set?

When one reader has claimed port->inbuf and dropped port->inbuf_lock across
copy_to_user(), port_has_data() returns true, so will_read_block() evaluates
to false:

drivers/char/virtio_console.c:will_read_block() {
	if (!port->guest_connected) {
		/* Port got hot-unplugged. Let's exit. */
		return false;
	}
	return !port_has_data(port) && port->host_connected;
}

drivers/char/virtio_console.c:port_fops_poll() {
	...
	if (!will_read_block(port))
		ret |=3D EPOLLIN | EPOLLRDNORM;
}

A peer thread polling the same descriptor with O_NONBLOCK will see
EPOLLIN | EPOLLRDNORM from port_fops_poll(), call port_fops_read() ->
fill_readbuf(), and immediately get -EAGAIN while port->inbuf_claimed remai=
ns
true. In addition, a blocking reader waiting in fill_readbuf() at
wait_event_freezable(port->waitqueue, !will_read_block(port)) will wake up =
as
soon as another reader claims a buffer, even though no buffer can be acquir=
ed
yet.

[ ... ]

> @@ -1791,7 +1971,15 @@ static void in_intr(struct virtqueue *vq)
>  	}
> =20
>  	spin_lock_irqsave(&port->inbuf_lock, flags);
> -	port->inbuf =3D get_inbuf(port);
> +
> +	/*
> +	 * A reader may own an exclusively claimed buffer, possibly
> +	 * sleeping in copy_to_user().  Do not prefetch the next buffer
> +	 * now: the claimer's unconsumed remainder must go back to
> +	 * port->inbuf first, or the prefetched buffer would be lost.
> +	 */
> +	if (!port->unplugging && !port->inbuf_claimed)
> +		port->inbuf =3D get_inbuf(port);
> =20
>  	/*
>  	 * Normally the port should not accept data when the port is

[Severity: High]
If in_intr() races with unplug_port(), can falling through after skipping
get_inbuf() dereference a NULL port->portdev or touch the virtqueue during
teardown?

When in_intr() runs concurrently with unplug_port(), find_port_by_vq() can
obtain a port reference just before unplug_port() removes the port from
portdev->ports. In unplug_port():

drivers/char/virtio_console.c:unplug_port() {
	spin_lock_irq(&port->inbuf_lock);
	port->unplugging =3D true;
	spin_unlock_irq(&port->inbuf_lock);
	...
	spin_lock_irq(&port->inbuf_lock);
	if (port->guest_connected) {
		...
		port->guest_connected =3D false;
		port->host_connected =3D false;
		...
	}
	spin_unlock_irq(&port->inbuf_lock);
	...
	spin_lock_irq(&port->outvq_lock);
	port->portdev =3D NULL;
	spin_unlock_irq(&port->outvq_lock);
}

When in_intr() then acquires port->inbuf_lock, the new check skips
port->inbuf =3D get_inbuf(port), but execution continues directly into:

drivers/char/virtio_console.c:in_intr() {
	if (!port->guest_connected && !is_rproc_serial(port->portdev->vdev))
		discard_port_data(port);

	/* Send a SIGIO indicating new data in case the process asked for it */
	send_sigio_to_port(port);

	spin_unlock_irqrestore(&port->inbuf_lock, flags);

	wake_up_interruptible(&port->waitqueue);

	if (is_console_port(port) && hvc_poll(port->cons.hvc))
		hvc_kick();
}

Because unplug_port() cleared port->guest_connected, in_intr() evaluates
is_rproc_serial(port->portdev->vdev). If unplug_port() has already set
port->portdev =3D NULL under outvq_lock, this dereferences a NULL port->por=
tdev
before reaching the !port->portdev check inside discard_port_data(). Even if
port->portdev is not yet NULL, discard_port_data() will call get_inbuf() and
add_inbuf() on the unplugging virtqueue (or while port->inbuf_claimed is
held), and in_intr() can then call hvc_poll(port->cons.hvc) after
hvc_remove().

Should in_intr() bail out when port->unplugging || !port->portdev is set?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105114535.9720=
13-1-shunsheng1218@gmail.com?part=3D1
