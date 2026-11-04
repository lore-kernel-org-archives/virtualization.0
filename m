Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786247;
	b=wpey4QRt4hbRmjv+MK/1JxUKQTdn2xB9ivmfHOLDbxbkYXCXvo1aRR2g7QZqf7iD0pXK
	 t3BPOgOZ1MciudYWbtc42V8DYxe6ssK7w64azKGjD4Qgd51GQYjw7fWzGmTiTo1ph3d5m
	 /BkZ12gjEMN56kNTgNJNo4eM8TTxXuWaSiGhvzT5iVuvkmVSdTul/hBKqdm6TnbHRyKMn
	 /EN+ST556w94od5fcHCvRh6XCxozpHfdB06scbmt0qIlmbivVnKnFg500Gs08T3FCbBeO
	 kBOfLAtLemyNsi9ZXuNOtW8tHIaePqvv64hjVWvSTJcZuGXbgBKW7g+lDTqsOoD2jgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786247;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RwKVyF8R+9+Xwdkw5qK3hkcaJ7fAC2XMgJWmiA74BJ8=;
	b=f6JayxngghW9mgayDwJCihkjVSF086W6hJvTDIdXjrsidPupgskn6mfp+f/4CE9C3lJZ
	 +jo6rZE8h9Bd5O9YhAgrRnMI3pZy909fP3kuY6LYCh0mwEiEJxnFzFt1VbD03JUjBZkwL
	 QXtm0f8eRnFANCqlLW9kkztUMi3NBbfZgTJuFHPoZtwacWTzdphANxQlje3f/oqu0P9Rn
	 mjgOAddRSTwALk2MNOw7L1/EHKuxko+fkBG/0LuchnmOOFt++Tl92lv3rHlqqG1vyRr2I
	 f/9kRdvLj+SXFKIDjT4RwBKBMloAPzQy+x6h4/gY1EHTPuS6lC0aHWnlACs13fOJvOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X+E930/T";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A3F606A31B
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+E930/T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530D61F000C1;
	Wed,  4 Nov 2026 09:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793786246;
	bh=RwKVyF8R+9+Xwdkw5qK3hkcaJ7fAC2XMgJWmiA74BJ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X+E930/Tm2bs0zBi3OaNVlOhlZ0oNoI3OWRTRMmmwbCmAwLP5KK2qbKmJvWtkDgJd
	 2ZRcZi0JOiXGrCgSLngdBNgqBrRlFNqtONtpR6IQujK2Co2u7YkqwQ1ni2JCMMZyt5
	 6upl9Jo4PVJR3CADAVJonZNVnXLt7Ga68EOysrweYYiStzpwjF2X+9HyhZBHIqjfD9
	 h0u0z8k5MMqDd9ToKers4zipgg+cSnc9EBnbRJQ5Jis4FMrRKl7QnbrGlD2XcgSos5
	 Y/gxXUqc30SPKP7YG4P8tp/Bwl+wbH8nRL7yjpAq41oJ/gDfBWeja9wxJ87ziKX4bj
	 9XtibGlXogcwQ==
Message-ID: <sashiko-outbox-197011@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_console: guard read-side virtqueue access during
 unplug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yaohan Li" <shunsheng1218@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <179378543196.71890.7555371342727156729@gmail.com>
References: <179378543196.71890.7555371342727156729@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 09:57:25 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] virtio_console: double free and UAF of port->inbuf in fill_rea=
dbuf()
- [Medium] virtio_console: lock gap in unplug_port() leaks port->inbuf on r=
ead race
--

commit a643b15852e7b766cdcc04cfb5d89a66c569bc43
Author: Yaohan Li <shunsheng1218@gmail.com>

virtio_console: guard read-side virtqueue access during unplug

This commit adds port->portdev checks under port->inbuf_lock in
port_has_data() and fill_readbuf(), and clears port->portdev under
port->inbuf_lock in unplug_port() to prevent read-side access to input
virtqueues during unplug.

> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 019bcae81af5c..e97e0daa34395 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c

[ ... ]

> @@ -725,6 +731,16 @@ static ssize_t fill_readbuf(struct port *port, u8 __=
user *out_buf,
>  		spin_lock_irqsave(&port->inbuf_lock, flags);
>  		port->inbuf =3D NULL;
> =20
> +		/*
> +		 * The port may have been unplugged while we were copying
> +		 * data out of the buffer: the vqs are then already gone.
> +		 */
> +		if (!port->portdev) {
> +			spin_unlock_irqrestore(&port->inbuf_lock, flags);
> +			free_buf(buf, true);
> +			return out_count;
> +		}

[Severity: Critical]
Can this free_buf(buf, true) call cause a double-free of buf when
fill_readbuf() races with unplug_port()?

In fill_readbuf(), port_has_data(port) acquires port->inbuf_lock, sets
port->inbuf =3D get_inbuf(port), and drops port->inbuf_lock while leaving
port->inbuf pointing to buf during the unlocked copy_to_user() or memcpy():

drivers/char/virtio_console.c:fill_readbuf() {
	if (!out_count || !port_has_data(port))
		return 0;

	buf =3D port->inbuf;
	out_count =3D min(out_count, buf->len - buf->offset);

	if (to_user) {
		ssize_t ret;

		ret =3D copy_to_user(out_buf, buf->buf + buf->offset, out_count);
		...
	}
	...
	buf->offset +=3D out_count;
}

If unplug_port() runs concurrently while fill_readbuf() is unlocked, it cal=
ls
remove_port_data(port) -> discard_port_data(port) under port->inbuf_lock
before setting port->portdev =3D NULL:

drivers/char/virtio_console.c:discard_port_data() {
	if (!port->portdev) {
		/* Device has been unplugged.  vqs are already gone. */
		return;
	}
	buf =3D get_inbuf(port);

	err =3D 0;
	while (buf) {
		port->stats.bytes_discarded +=3D buf->len - buf->offset;
		if (add_inbuf(port->in_vq, buf) < 0) {
			err++;
			free_buf(buf, false);
		}
		port->inbuf =3D NULL;
		buf =3D get_inbuf(port);
	}
}

Because port->inbuf still holds buf during the copy, get_inbuf(port) in
discard_port_data() returns that same active buf and either frees it via
free_buf(buf, false) (when port->in_vq is broken during device removal) or
re-queues it to port->in_vq (where remove_vqs() detaches and frees it), whi=
le
copy_to_user() is still reading from buf->buf or before fill_readbuf() loads
buf =3D port->inbuf (which is now NULL).

When fill_readbuf() finishes copying the buffer, it re-acquires
port->inbuf_lock, sees !port->portdev, and calls free_buf(buf, true) on the
same buf a second time.

> @@ -1568,6 +1584,18 @@ static void unplug_port(struct port *port)
>  	 * a close on an open port later from sending a stale control
>  	 * message.
>  	 */
> +	/*
> +	 * Null out portdev under inbuf_lock as well, so the read path
> +	 * (port_has_data(), fill_readbuf()) cannot race with the vq
> +	 * teardown: it checks port->portdev inside the same lock and
> +	 * bails out if NULL, preventing any virtqueue access to an
> +	 * already torn-down virtqueue =E2=80=94 mirroring the outvq_lock fence
> +	 * below for the write path.
> +	 */
> +	spin_lock_irq(&port->inbuf_lock);
> +	port->portdev =3D NULL;
> +	spin_unlock_irq(&port->inbuf_lock);

[Severity: Medium]
Does clearing port->portdev in a separate lock acquisition after
remove_port_data(port) leave a race window that can leak port->inbuf?

In unplug_port(), remove_port_data(port) acquires port->inbuf_lock, runs
discard_port_data(port), and drops port->inbuf_lock before unplug_port()
re-acquires port->inbuf_lock here to set port->portdev =3D NULL:

drivers/char/virtio_console.c:remove_port_data() {
	spin_lock_irq(&port->inbuf_lock);
	/* Remove unused data this port might have received. */
	discard_port_data(port);
	spin_unlock_irq(&port->inbuf_lock);

	spin_lock_irq(&port->outvq_lock);
	reclaim_consumed_buffers(port);
	spin_unlock_irq(&port->outvq_lock);
}

If a concurrent reader calls port_has_data(port) in the gap after
discard_port_data(port) unlocks port->inbuf_lock and before port->portdev is
set to NULL, port_has_data(port) sees port->portdev !=3D NULL and detaches a
buffer from port->in_vq into port->inbuf.

Once port->portdev is set to NULL, if port_fops_read() exits on
!port->guest_connected or fill_readbuf() only partially consumes the buffer
(or fails with -EFAULT), that detached buffer remains in port->inbuf and
discard_port_data() in port_fops_release() will bail out on !port->portdev
without freeing it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179378543196.71890.=
7555371342727156729@gmail.com?part=3D1
