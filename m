Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422025;
	b=oWkeka/BTFjiS4DnTeIYeyZHniRT9oBdG0Xm4Y7/p4gPyBqqyqqo+gmMXUWshBnAVMoO
	 OBNqtNIhL7vLssKFbygOnMVEn2HMx2GN+DPBjfcmF9wpSmK7uBgT626Gt7QPw7+nTmg5q
	 G7pEhkmt5ijGTgI1yONXLj1wG7l8+uviWTQvcKIw+sh7F/s8sa5vL2zvxNZC1vz1Hx8BF
	 OoOia9PNY8MEkzGfwpX4kD3uYM0ERvOQFcd2+Vy5wQWdqcE01NpqpTiXpUBke6TDMRzN7
	 xEWxkfF0UKgLuLHsRpOdugFfee6bvhweIZyO7vW+A6opI1ujrAUtk2cF6JHjh+szmmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422025;
	h=Received:Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 Date;
	bh=8emSutyWVqAS1tkDBOVixayHtpeIlGsueGuOiPC7DoY=;
	b=Zn2XjRY1JF/62/sR5mRnC5py4/W6ssF9ftaOuVgh2CBJXkGP2Mn8w5m/Cki9jy7Oxjsj
	 Gcljj7rSpGAa7xA+wOEY7KRcdi3/ge6Soy9aKf2SQJFc49owCp8R7sPHFm0+RX4njSO6/
	 iNx/nEkBcbFXWp1nrXHtCdQ+8fgIGdsJsxCRT+WwYerN5daOx+/+qMr+I4AJ2ZJPE+P6t
	 hVo7uKGXOKLL+A/tlB0ZWWpsr1aus9lGPQP3D/KP3bVuJ1JZf815ueMUw//D2Jp6jREvI
	 SMPbHLgPaE5kLeIrDU6E1ZuZ/xXHi0WO80UzqsBdxqylm+UASBOdP5WuuroQlJ+Mn3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=op3u6nZz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFA06079D56
	for <virtualization.lists.linux.dev@localhost.mlmmj>; Mon, 19 Oct 2026 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=op3u6nZz
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1229E33B975
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422025; cv=none; b=gSHV5183X6i4jstz3CgV3b8/DlmdpsMr2fjGwsX4zBEJ9Nupnqza5Yz7QL4OTT6d9H7K5Sy8+RztFzqeD219usmn7sMuHtWOORi4o8tcKlwPzhHrWWVnXvA3TGRCSy0whXpbO/73ZRZaGYZK+Fp5a7KHclJK4hNnXTSkA30Holc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422025; c=relaxed/simple;
	bh=pnHz9Z2RLCRZmwFwsjYdGXs7xRsHmrSLr3vDpiqbHWc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=tPaGGoPjCc9WoM3jn0pbcQ38vru81PDKjiprdTqhG4DEhUFgFeIsuRVwzo2ZM9bDLWmfN0cNzr+IVg2QzFyhotbFdEzRMsMBQwE+tyKTNMch8s+Izh1Li+h7Ed4oSkg6roR8Wg4IvO8Ufhe8hrWRQLLFBUVODKyf0L9Y8SrJkNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=op3u6nZz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8E01F000C4;
	Mon, 19 Oct 2026 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422024;
	bh=8emSutyWVqAS1tkDBOVixayHtpeIlGsueGuOiPC7DoY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=op3u6nZzWSo5hXjBpOCFbb6qh7cS7NeKyahx6ZHgTPXC9tEILCdbokOesgXLS52Ik
	 YY0CR1GDJvdoke7huC/3JCqiClD3rtUzsfSmn71SQdvxl1cQ3bA721qnjyuxdEa+qD
	 t1CO9Tkpr2wo9g/CbAZN2dEEjrQTodMaCZZg/uQdq0VPMgLBBiBWXAzTgAUPXrmL6y
	 miN7CZqY6Y8G2QSxbYbYiL4HeAqtNUwdsz2mjvioGSDYG+TqZ0+K6OA+B455sLQ2jI
	 lsrVFIznP94NK8oCu8eUYTnKt2Ac5xBbyha5L9KfwqTVWr+caFncjK4nnTJrVyzK9u
	 6iwxUSXiT+lmA==
Message-ID: <sashiko-outbox-177588@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] virtio_console: take a kref in
 find_port_by_vq() to fix port UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261019135441.1420968-319-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-319-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:00:23 +0000
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
- [Critical] virtio_console: use-after-free on port->cons.hvc in in_intr()
- [High] virtio_console: NULL portdev dereference and inbuf leak in in_intr=
()
--

commit 30bde48929beace6a7511551cb2600c5af9d8ca1
Author: Hari Mishal <harimishal1@gmail.com>

virtio_console: take a kref in find_port_by_vq() to fix port UAF

This commit takes a kref reference on struct port inside find_port_by_vq()
under ports_lock and releases it at the end of in_intr() and out_intr() to
prevent a use-after-free when racing with unplug_port().

Link: https://patch.msgid.link/20260717150622.23636-1-harimishal1@gmail.com

> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 088182e54debd..14ca24b6daf2c 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -304,6 +304,12 @@ static struct port *find_port_by_id(struct ports_dev=
ice *portdev, u32 id)
>  	return port;
>  }
> =20
> +/*
> + * Finds a port by the virtqueue and returns a pointer to struct port
> + * with the reference count incremented.
> + *
> + * Callers MUST decrement it when finished.
> + */
>  static struct port *find_port_by_vq(struct ports_device *portdev,
>  				    struct virtqueue *vq)
>  {
> @@ -312,8 +318,10 @@ static struct port *find_port_by_vq(struct ports_dev=
ice *portdev,
> =20
>  	spin_lock_irqsave(&portdev->ports_lock, flags);
>  	list_for_each_entry(port, &portdev->ports, list)
> -		if (port->in_vq =3D=3D vq || port->out_vq =3D=3D vq)
> +		if (port->in_vq =3D=3D vq || port->out_vq =3D=3D vq) {
> +			kref_get(&port->kref);
>  			goto out;
> +		}
>  	port =3D NULL;
>  out:
>  	spin_unlock_irqrestore(&portdev->ports_lock, flags);

[ ... ]

> @@ -1751,6 +1760,8 @@ static void in_intr(struct virtqueue *vq)
> =20
>  	if (is_console_port(port) && hvc_poll(port->cons.hvc))
>  		hvc_kick();
> +
> +	kref_put(&port->kref, remove_port);
>  }
> =20
>  static void control_intr(struct virtqueue *vq)

[Severity: High]
When in_intr() races with unplug_port() after find_port_by_vq() drops
ports_lock, can in_intr() dereference a NULL port->portdev pointer and
leak port->inbuf?

With the kref keeping struct port alive while unplug_port() executes on
another CPU, unplug_port() clears guest_connected, drains the port data,
and sets port->portdev to NULL:

drivers/char/virtio_console.c:unplug_port() {
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
	remove_port_data(port);

	port->portdev =3D NULL;
    ...
	kref_put(&port->kref, remove_port);
}

If in_intr() acquires port->inbuf_lock after unplug_port() has run, it
pops a buffer into port->inbuf and then checks port->portdev->vdev while
port->guest_connected is false:

drivers/char/virtio_console.c:in_intr() {
    ...
	spin_lock_irqsave(&port->inbuf_lock, flags);
	port->inbuf =3D get_inbuf(port);
    ...
	if (!port->guest_connected && !is_rproc_serial(port->portdev->vdev))
		discard_port_data(port);
    ...
}

Because port->portdev is now NULL, evaluating port->portdev->vdev
dereferences NULL in interrupt context.

Additionally, if port->portdev becomes NULL just before discard_port_data()
runs (or on an rproc_serial port), discard_port_data() returns early
without freeing port->inbuf:

drivers/char/virtio_console.c:discard_port_data() {
	if (!port->portdev) {
		/* Device has been unplugged.  vqs are already gone. */
		return;
	}
    ...
}

When in_intr() then drops the final reference via kref_put(&port->kref,
remove_port), remove_port() only calls kfree(port), leaking the struct
port_buffer stored in port->inbuf.

[Severity: Critical]
In the same race between in_intr() and unplug_port() on a console port,
can in_intr() pass a freed port->cons.hvc pointer to hvc_poll()?

While in_intr() holds a kref on struct port after find_port_by_vq() drops
ports_lock, unplug_port() tears down the HVC console without clearing
port->cons.hvc or synchronizing with in_intr():

drivers/char/virtio_console.c:unplug_port() {
    ...
	if (is_console_port(port)) {
		spin_lock_irq(&pdrvdata_lock);
		list_del(&port->cons.list);
		spin_unlock_irq(&pdrvdata_lock);
		hvc_remove(port->cons.hvc);
		ida_free(&vtermno_ida, port->cons.vtermno);
	}
    ...
}

hvc_remove() drops the tty_port reference, which frees the struct
hvc_struct in hvc_port_destruct() if no tty holds an open reference. When
in_intr() then reaches:

	if (is_console_port(port) && hvc_poll(port->cons.hvc))
		hvc_kick();

is_console_port(port) still sees a non-NULL port->cons.hvc and passes the
dangling pointer to hvc_poll().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-319-sashal@kernel.org?part=3D1
