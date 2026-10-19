Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422680;
	b=NKioj3kInFclfLT69lZmEopfi9id8cxJ0JWbzpOyfGcPaCXDtmdQYGxq7uPYkwayfwvv
	 FHTZY7utlNTfeK9/fZEa/a+E+N+J1OAPt2sw0FuZ0aJUoOFacaigYJnF0324f2GYCeifx
	 y9uH4NLHnEzZ/jK43a/3qYzeoL6ZCnoCQNMnPWF2Vk+wZaIetRKgFJ4AEoUZtE5BRaBzm
	 QCSEOyr6m0WWU7A+Fx/OY6hDZLLrviHkLED2ktNaSQYRiw/6YXUjkjqQmjoVfVB+yhX8k
	 km3RYbC+pjsjgP1P/1kRvCqgxSV+0H8m5GggUJQOMVF8d10JlafFl9GAUuQCJKjy8uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422680;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nyJgJ+d1ug+K5MC1TbHzNfhB/zRtX6i9c1fq3vKznDE=;
	b=NgcT6Cp5KB/FCkUyQa9ztCJSBspYvtLiXgCXIxL2MWcWalV/e5tF1ilzsbQAFcS2qnQr
	 k1ecg2YsiRJsUmIS9ZCvTGdZalqaPPakwZbVzJSHzdpqkzKJXbyG00aDLOs5eNFgNKvJK
	 HWt24AOA1LgxKuf11suXM41dBMz91TWBZMdQFv1t6RFkXMupTMeWRlb59ieN4WsfeJDmP
	 YSkkRS3aiFyRv8+hiVeBjvtqkYvP0eW1GsW/pEUEIOp+kQsZf0PPOUgfelImtRdfyAFSU
	 sEpYp01uWu1K6F5uLtsUFhLGLe82NXajRnMeP4lhbBqUfut7MkWp0fpnVZOrdGr85iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cYF/0Pfy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6399B60892EC
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYF/0Pfy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E941F000C4;
	Mon, 19 Oct 2026 15:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422679;
	bh=nyJgJ+d1ug+K5MC1TbHzNfhB/zRtX6i9c1fq3vKznDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cYF/0Pfyv2LVk/sqdtLOQzI1P9RwejKYFfJs4wkdYUbid5/1T7cFOegtmuZvHvQ/5
	 /LRMIX1vRQdlXmpewwwYAEicg4Mg5TAhIak3q4qSl0AueQMB/DldGUPpG7fcvUr2Fh
	 /PglGrceDj01a1pMW90uj3XOJ2u6B42/FOwve+Y8CbdTgtq2N099RTB8zzOhioVWvp
	 V1QqIJPzWBD29N8TXH4sy505qRuXOfGgCF3VGB9YfE/rOq8sqezxY4r27pq6+HLHkZ
	 pCB1kCQTrWJf2K23c0znnOKyk3iERZvyUwurtLj7nC71XKV7hH27fESz041pUHtzor
	 8j5bM3rewxQ8A==
Message-ID: <sashiko-outbox-177637@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] virtio_console: fix control queue
 race during restore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261019135441.1420968-390-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-390-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:11:18 +0000
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
- [High] virtio_console: dropped host control replies in virtcons_restore()
--

commit 896c2558dbc3180e4d84cf033ee9bf699250ed69
Author: Sungho Bae <baver.bae@lge.com>

virtio_console: fix control queue race during restore

This commit defers populating the control receive queue (portdev->c_ivq) in
virtcons_restore() until after iterating over portdev->ports to prevent
concurrent list modification from control_work_handler().

Link: https://patch.msgid.link/20260603183757.21587-4-baver.bae@gmail.com

> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 088182e54debd..6dd0cf78bf839 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -2136,9 +2136,6 @@ static int virtcons_restore(struct virtio_device *v=
dev)
> =20
>  	virtio_device_ready(portdev->vdev);
> =20
> -	if (use_multiport(portdev))
> -		fill_queue(portdev->c_ivq, &portdev->c_ivq_lock);
> -
>  	list_for_each_entry(port, &portdev->ports, list) {
>  		port->in_vq =3D portdev->in_vqs[port->id];
>  		port->out_vq =3D portdev->out_vqs[port->id];
> @@ -2155,6 +2152,18 @@ static int virtcons_restore(struct virtio_device *=
vdev)
>  		if (port->guest_connected)
>  			send_control_msg(port, VIRTIO_CONSOLE_PORT_OPEN, 1);
>  	}
> +
> +	/*
> +	 * Populate the control receive queue only after the list iteration
> +	 * is complete. If we fill this queue before iterating, the host could
> +	 * immediately deliver a VIRTIO_CONSOLE_PORT_REMOVE message.
> +	 * This would trigger the control workqueue, which modifies the
> +	 * portdev->ports list concurrently with the unprotected loop above,
> +	 * leading to a Use-After-Free and list corruption.
> +	 */
> +	if (use_multiport(portdev))
> +		fill_queue(portdev->c_ivq, &portdev->c_ivq_lock);
> +
>  	return 0;
>  }
>  #endif

[Severity: High]
Won't deferring fill_queue(portdev->c_ivq, &portdev->c_ivq_lock) until after
the loop cause the host's control replies to be dropped during restore?

During freeze, virtcons_freeze() clears port->host_connected for every port
and destroys all virtqueues:

drivers/char/virtio_console.c:virtcons_freeze() {
	...
	list_for_each_entry(port, &portdev->ports, list) {
		virtqueue_disable_cb(port->in_vq);
		virtqueue_disable_cb(port->out_vq);
		/*
		 * We'll ask the host later if the new invocation has
		 * the port opened or closed.
		 */
		port->host_connected =3D false;
		remove_port_data(port);
	}
	remove_vqs(portdev);
	...
}

In virtcons_restore(), the list_for_each_entry() loop queries the host for
each port's open/close status via send_control_msg() -> __send_control_msg(=
):

drivers/char/virtio_console.c:virtcons_restore() {
	...
	list_for_each_entry(port, &portdev->ports, list) {
		...
		/* Get port open/close status on the host */
		send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
		...
	}
}

Because __send_control_msg() kicks portdev->c_ovq and busy-waits
synchronously until the host consumes the VIRTIO_CONSOLE_PORT_READY request:

drivers/char/virtio_console.c:__send_control_msg() {
	...
	if (virtqueue_add_outbuf(vq, sg, 1, &portdev->cpkt, GFP_ATOMIC) =3D=3D 0) {
		virtqueue_kick(vq);\
		while (!virtqueue_get_buf(vq, &len)
			&& !virtqueue_is_broken(vq))
			cpu_relax();
	}
	...
}

the host processes VIRTIO_CONSOLE_PORT_READY and immediately attempts to se=
nd
back VIRTIO_CONSOLE_PORT_OPEN (along with VIRTIO_CONSOLE_CONSOLE_PORT and
VIRTIO_CONSOLE_PORT_NAME) on portdev->c_ivq before __send_control_msg()
returns.

If fill_queue(portdev->c_ivq, &portdev->c_ivq_lock) has not been called yet,
portdev->c_ivq has zero receive buffers when the host replies, causing those
VIRTIO_CONSOLE_PORT_OPEN replies to be dropped and leaving
port->host_connected permanently stuck at false after restore (which causes
port_fops_write() to block or fail with -EAGAIN, port_fops_read() to return
EOF, and port_fops_poll() to report EPOLLHUP).

Would it work to keep fill_queue(portdev->c_ivq, &portdev->c_ivq_lock) befo=
re
the loop, but disable the c_ivq callback or defer scheduling control_work
until the loop finishes so the host has receive buffers available while list
traversal is still protected from concurrent control_work_handler() runs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-390-sashal@kernel.org?part=3D1
