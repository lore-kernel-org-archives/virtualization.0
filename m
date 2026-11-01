Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793500655;
	b=zkJQieUdoklbi/gUdZW6+WEXTWYM3Cd5XjSEcpgv5wLzguuCsxSa5y4clQbsku/bzEV2
	 g7YInv+lG0+s+TT76zYCe5MH9bzUWZAeJP7trrM2xflaQd7R+Fwz62/kzXwLPXtpwjb8H
	 9C295hM0xNaBNng+uWlBBp4tnKhkuF/nYuS91ySpdhCbOqLbfgs6gNGmqu7JshA1F5Th1
	 prbYjgSjCEP8ECkCKOl5csn2+KLpRoFrjpG6NrvVGUpMR0i9lTlT8KW4Ozoi4wETT6kBK
	 H/LAwpbN89a16EyKlvnhPUFyuS77rPyICGNHqizTM/THhOhlylz7A2BxHR8Q+zGxQTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793500655;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rrudH8UIAv/LTt77MF7TP3SlBJsDUxZJhjoIjopSw+o=;
	b=lhwuXU0hOsRmWHtGM1ubYQtY4UAWNAQ+cs28Hppaopryb6+HjcHiL++YJxfpHg/Ak4mD
	 covbN+LZT6IXDhNh/0wPZbgKWR9nIf5Ad9iMj7op5iQerDtiertFhOOKCHAwQiJPc/dao
	 MPnHh0BTRRDyW+SzXF4yxY57Xz4zWCT/YTV6EvUogiwGIOu6/yz9ZZKH8ZEOqxPbZN+hG
	 naIhtTep4ximOlQeRbBdhKO9O6VCjuJ9shtf5PtLnxmAaa/MNcfIC9ZjAvEQw7nM4uwYO
	 Yxd3o1FVy3nwCWAezU4knwBhYwKvtP3lHennDJBAG0KRgEB/0DsKUTraHQQ1/9NQLoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxChpuvl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBC9606A324
	for <virtualization@lists.linux.dev>; Sun,  1 Nov 2026 02:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxChpuvl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1CA1F000C1;
	Sun,  1 Nov 2026 02:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793500654;
	bh=rrudH8UIAv/LTt77MF7TP3SlBJsDUxZJhjoIjopSw+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KxChpuvlwZfC9CN7FE5XSW1FZ6SdR6QeSp/gEi6H1LbGUvJPNq5u2fTIooSfcCqdl
	 htpHWmkX/fmpUAbBkAhDDxAzQC+5RNCuEiM3PK3tApX4awi3kezqhlZBweKctig6Rk
	 8lpoJWcO+7d1MX0iPfqZnMN9PbeKP6Nj9ftIUXDuFz/J1cZS/M4U3B43nC+xOvtwL4
	 YsTqQUe1EDBg2e8qkKVcu3sw2qiRy9yyOHTkNFZZyvlhJWuJ3TcVeQwnMLMR/yyvad
	 WPE/4NEFAJwbzKYeTiGJ3o680Cu5a5SJE+QsEFZgYnHQc/qxEyCYorfTaqsUhudDet
	 YsJccVtwWwsPw==
Message-ID: <sashiko-outbox-192252@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_console: add console port to list before
 hvc_alloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Foo Bar" <muratseker@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261101022435.3466820-1-muratseker@meta.com>
References: <20261101022435.3466820-1-muratseker@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 02:37:33 +0000
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
- [Critical] virtio_console: race between __send_to_port() and out_intr() i=
n add_port()
--

commit e1686190742677c49792956e3ec4f167b8b193e9
Author: Murat Seker <muratseker@meta.com>

virtio_console: add console port to list before hvc_alloc()

This commit adds the console port to pdrvdata.consoles before calling
hvc_alloc() in init_port_console() so that put_chars() can find the port
when register_console() replays the kernel log buffer. If hvc_alloc()
fails, the port is removed from pdrvdata.consoles before freeing the
vtermno.

> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 019bcae81af5c..a31fdac658913 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1280,18 +1280,28 @@ static int init_port_console(struct port *port)
>  		return ret;
> =20
>  	port->cons.vtermno =3D ret;
> +
> +	/*
> +	 * hvc_alloc() may register the console, which replays the log buffer
> +	 * through put_chars().  put_chars() finds the port on this list, so
> +	 * add it first or the replayed messages are dropped.
> +	 */
> +	spin_lock_irq(&pdrvdata_lock);
> +	list_add_tail(&port->cons.list, &pdrvdata.consoles);
> +	spin_unlock_irq(&pdrvdata_lock);
> +
>  	port->cons.hvc =3D hvc_alloc(port->cons.vtermno, 0, &hv_ops, PAGE_SIZE);

[Severity: Critical]
When probing a non-multiport device with a preferred hvc console, can this
cause a race between __send_to_port() and out_intr() on port->out_vq?

In virtcons_probe(), init_vqs() sets out_intr() as the callback for
portdev->out_vqs[0] and virtio_device_ready() enables virtqueue interrupts
before add_port() is called.

In add_port(), when !use_multiport(port->portdev) is true,
init_port_console() is called before the port is added to
port->portdev->ports:

drivers/char/virtio_console.c:add_port() {
	...
	else if (!use_multiport(port->portdev)) {
		/*
		 * If we're not using multiport support,
		 * this has to be a console port.
		 */
		err =3D init_port_console(port);
		if (err)
			goto free_inbufs;
	}

	spin_lock_irq(&portdev->ports_lock);
	list_add_tail(&port->list, &port->portdev->ports);
	spin_unlock_irq(&portdev->ports_lock);
	...
}

Because port->cons.list is now in pdrvdata.consoles during hvc_alloc(),
hvc_alloc() -> hvc_check_console() -> register_console() synchronously
replays the kernel log buffer through hvc_console_print() -> put_chars() ->
__send_to_port() while port is still not in portdev->ports.

__send_to_port() acquires port->outvq_lock with spin_lock_irqsave(), queues
the buffer on out_vq, kicks the host, and spins waiting for completion:

drivers/char/virtio_console.c:__send_to_port() {
	...
	/* Tell Host to go! */
	virtqueue_kick(out_vq);

	if (!in_blocking) {
		...
		while (!(buf =3D virtqueue_get_buf(out_vq, &len))
			&& !virtqueue_is_broken(out_vq))
			cpu_relax();
	}
	...
}

If the host completes the buffer and raises an interrupt on another CPU
before add_port() adds the port to portdev->ports, out_intr() runs and
find_port_by_vq() returns NULL:

drivers/char/virtio_console.c:out_intr() {
	struct port *port;

	port =3D find_port_by_vq(vq->vdev->priv, vq);
	if (!port) {
		flush_bufs(vq, false);
		return;
	}
	...
}

Wouldn't flush_bufs() then call virtqueue_get_buf() and free_buf() on
out_vq without holding port->outvq_lock, corrupting the virtqueue ring
concurrently with __send_to_port() and stealing the completed buffer so
that __send_to_port() spins forever with interrupts disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101022435.3466=
820-1-muratseker@meta.com?part=3D1
