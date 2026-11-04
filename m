Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786226;
	b=vRk7RpZNfPNPTKZR9ZTI1UBfTEQvCn/DgE5sGGAU98+XyftD172VKjgrPt4N0hXPCrki
	 maANqtN/+oQtjPInX3TfJouKJ9TTiYbFZW4AczE0Q1c/GSHZEzL3bKrxta5CbuXF3YcTd
	 Asyq/EFCr0vA3Bovj4Ruc7mvh2n0Li8ATgJMlI6eq0Qbz9IkO+UyI4KNEZzvYkj3ZITfQ
	 2QtFbLodSIumll80qNP/tfxYpgWsyQ+sIranQB2g0EpAg9x20SbIh+FdPeMivQt0aaWAl
	 0Z67rmm+2SL3kZPpRL37hHEkC/z4VfFDC+rafeDX61x5jlmpSoXcXaBshTqrdNFKIzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786226;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jib7iVrEclqtA59m2Vu3WHp6JPfxgd6zABTLHiLE+5Q=;
	b=JLNAhCSac2645xqgb6Ek4tQNJOmX9VjekpcX+6LZsYKKLeO98/uqnUEM2ma1YFKssow/
	 FO95Qbj2fxySpI1DoQVv8SyhI2M6aserEpNYuSd6Ip24fdzKuznOdg1AlwtSYUHPp84ZX
	 uM6uotAxa6+OBV675NDf4xxofAy2tFfD3Z+t0iwASPe58+vNvy6z+TD8l178egPEdsYRh
	 tf7XPJ3q9GaW92Mr8RVIgAJBzgOTluxiE00uM7b3zWndc1uxA0n8X/eik2Pn1DTkqvvhr
	 39j4GtOoNB/HtYtWG+rsxk6s6/FkV4LzgrohkByGFKv1ml6t8Bc+kIduWoa5ufbT/BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jU6i3dAJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9F9606A329
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jU6i3dAJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A17A1F000C1;
	Wed,  4 Nov 2026 09:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793786225;
	bh=jib7iVrEclqtA59m2Vu3WHp6JPfxgd6zABTLHiLE+5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jU6i3dAJyYTxkmXuUYx4PkpryFifi7b/mpLy7A45VulPSniopEB9wH8hHS7agVHKR
	 rWXb1f6MpozZgtzayWvAaThLbWFs7ktvXnhhGNnQpWbbPCHk/iNQ5hKSKR5g7k9wru
	 aZJY2R6Y1mIbN8U1/9kwp2N74VkOyDxp9epiNqHkiP59CsFGtkJZ8EUe9gCnicTKXp
	 yxrU46uvvQc9mu7+AUgJWwvdG7kwjN42c+QtnN6stLoE8ChoFaTQ7oPdbEMSPINAoL
	 5FQPRbg2+GcJxya5XThgXM6oYKwrtUEI4oVCAeLW3yVf4inXo9uBkGvMPiBq2pd/7N
	 XozyepNVxLpRw==
Message-ID: <sashiko-outbox-197010@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_console: synchronize HVC polling with port
 removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yaohan Li" <shunsheng1218@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <179378553951.72222.12851179500568566393@gmail.com>
References: <179378553951.72222.12851179500568566393@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 09:57:05 +0000
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
- [High] virtio_console: cons.hvc NULL races in resize_console() and port_f=
ops_open()
- [High] virtio_console: missing __rcu on cons.hvc and unsafe init_port_con=
sole() store
--

commit 67f46e55590e3a9043a67c038c41030d7d15c8e0
Author: Yaohan Li <shunsheng1218@gmail.com>

virtio_console: synchronize HVC polling with port removal

This commit protects the hvc_poll() call in in_intr() with an RCU read-side
critical section and clears port->cons.hvc followed by synchronize_rcu() in
unplug_port() before calling hvc_remove().

> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 019bcae81af5c..a3ee4af106d17 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1551,10 +1551,22 @@ static void unplug_port(struct port *port)
>  	spin_unlock_irq(&port->inbuf_lock);
> =20
>  	if (is_console_port(port)) {
> +		struct hvc_struct *cons_hvc =3D port->cons.hvc;
> +
>  		spin_lock_irq(&pdrvdata_lock);
>  		list_del(&port->cons.list);
>  		spin_unlock_irq(&pdrvdata_lock);
> -		hvc_remove(port->cons.hvc);
> +
> +		/*
> +		 * See in_intr(): a data vq callback may be running
> +		 * hvc_poll() on the adapter. Publish a NULL adapter so no
> +		 * new poll can start, wait for in-flight ones, and only
> +		 * then remove the adapter.
> +		 */
> +		rcu_assign_pointer(port->cons.hvc, NULL);
> +		synchronize_rcu();

[Severity: High]
Could clearing port->cons.hvc here introduce races with resize_console() and
port_fops_open()?

Previously, unplug_port() never cleared port->cons.hvc, so once a port was
initialized as a console port, port->cons.hvc remained non-NULL and
is_console_port(port) returned true for the rest of the port's lifetime.

With port->cons.hvc now set to NULL before synchronize_rcu() and hvc_remove=
(),
if hvc_open() -> notifier_add_vio() -> resize_console() runs concurrently in
drivers/char/virtio_console.c:

    static void resize_console(struct port *port)
    {
        struct virtio_device *vdev;

        /* The port could have been hot-unplugged */
        if (!port || !is_console_port(port))
            return;

        vdev =3D port->portdev->vdev;

        /* Don't test F_SIZE at all if we're rproc: not a valid feature! */
        if (!is_rproc_serial(vdev) &&
            virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
            hvc_resize(port->cons.hvc, port->cons.ws);
    }

is_console_port(port) checks port->cons.hvc once, and then hvc_resize()
reloads port->cons.hvc without RCU protection or caching the pointer in a
local variable. If unplug_port() clears port->cons.hvc between those two
reads, wouldn't hvc_resize() receive NULL and dereference &hp->lock?

Similarly, in port_fops_open() in drivers/char/virtio_console.c:

    if (is_console_port(port)) {
        ret =3D -ENXIO;
        goto out;
    }

    /* Allow only one process to open a particular port at a time */
    spin_lock_irq(&port->inbuf_lock);
    if (port->guest_connected) {
        spin_unlock_irq(&port->inbuf_lock);
        ret =3D -EBUSY;
        goto out;
    }

    port->guest_connected =3D true;

If port_fops_open() looks up a console port via find_port_by_devt() just
before unplug_port() removes port->list from portdev->ports, and reaches the
is_console_port(port) check while unplug_port() is sleeping in
synchronize_rcu() or hvc_remove() (before cdev_del()), both port->cons.hvc =
and
port->guest_connected have already been cleared. Wouldn't that allow the
unplugging console port to bypass the -ENXIO and -EBUSY checks, set
port->guest_connected =3D true, and send a VIRTIO_CONSOLE_PORT_OPEN control
message to the host?

> @@ -1820,8 +1833,19 @@ static void in_intr(struct virtqueue *vq)
> =20
>  	wake_up_interruptible(&port->waitqueue);
> =20
> -	if (is_console_port(port) && hvc_poll(port->cons.hvc))
> +	/*
> +	 * The vq callback calls hvc_poll() on the hvc adapter, which
> +	 * hvc_remove() frees on unplug without any lock shared with this
> +	 * hard-IRQ path (calling hvc_poll() with port->inbuf_lock held
> +	 * would deadlock: the hvc ops take that lock themselves). Take an
> +	 * RCU read lock across the poll and have the unplug path NULL out
> +	 * the adapter and wait for in-flight callbacks before removing it.
> +	 */
> +	rcu_read_lock();
> +	cons_hvc =3D rcu_dereference(port->cons.hvc);
> +	if (cons_hvc && hvc_poll(cons_hvc))
>  		hvc_kick();
> +	rcu_read_unlock();

[Severity: High]
Should struct console::hvc be annotated with __rcu, and does
init_port_console() need to avoid publishing an error or partially initiali=
zed
pointer to in_intr()?

In drivers/char/virtio_console.c, struct console still declares:

    struct console {
        ...
        /* The hvc device associated with this console port */
        struct hvc_struct *hvc;
        ...
    };

Without the __rcu annotation on hvc, rcu_assign_pointer() and
rcu_dereference() trigger Sparse address-space warnings.

In addition, on multiport devices, add_port() populates port->in_vq and lin=
ks
the port before the host sends VIRTIO_CONSOLE_CONSOLE_PORT, so in_intr() can
already run when handle_control_message() calls init_port_console(port):

    port->cons.vtermno =3D ret;
    port->cons.hvc =3D hvc_alloc(port->cons.vtermno, 0, &hv_ops, PAGE_SIZE);
    if (IS_ERR(port->cons.hvc)) {
        ret =3D PTR_ERR(port->cons.hvc);
        dev_err(port->dev,
            "error %d allocating hvc for port\n", ret);
        port->cons.hvc =3D NULL;
        ida_free(&vtermno_ida, port->cons.vtermno);
        return ret;
    }
    spin_lock_irq(&pdrvdata_lock);
    list_add_tail(&port->cons.list, &pdrvdata.consoles);
    spin_unlock_irq(&pdrvdata_lock);
    port->guest_connected =3D true;

If hvc_alloc() returns an ERR_PTR, port->cons.hvc transiently holds that
non-NULL error pointer until it is reset to NULL after dev_err(). If in_int=
r()
runs during that window, cons_hvc =3D rcu_dereference(port->cons.hvc) will =
be
non-NULL and hvc_poll(cons_hvc) will dereference the ERR_PTR. Even when
hvc_alloc() succeeds, port->cons.hvc is stored without rcu_assign_pointer()
and before port->cons.list is added to pdrvdata.consoles, so a concurrent
in_intr() -> hvc_poll() -> get_chars() -> find_port_by_vtermno() can fail to
find the console and return -EPIPE (triggering tty_hangup()).

Should init_port_console() store the hvc_alloc() result in a local variable,
validate it with IS_ERR(), add port->cons.list to pdrvdata.consoles, and th=
en
publish port->cons.hvc via rcu_assign_pointer()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179378553951.72222.=
12851179500568566393@gmail.com?part=3D1
