Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793944253;
	b=Kb9iA7WXGNreTcfvo1QgMxoXBYB82McVcvkHtWIcHjBg/3AWTpffIMTNd89VJ7cVuvsH
	 bOcvZxmS0SR9PdzxBwMFNkUizfeww+Z1+FusCB7AyEg0zlsG46R5w6fqSm4AB37AKy8my
	 /TZ77OO9Ob40oEXyLx+bX5XN0wEsQi8NxMOwHL9pZQBBmf5Uz0fpCj1puH0IrelVfRbn4
	 aI+4B096GgARlNTeYIjoGdzgm1gqBBVdg64LNoN2cw+w8JzOKZFcHaQh5N2W/ZEJS3QId
	 kc0EJ++0veGE6PIZeIuvaMW2jUX7rDMafWLgl9IFdnV5LRGbolREe8aKQ8hIL+weB/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944253;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q33Iw0NQot0Eu0pzBS6JaAbTkeKRPc2nqwP9zTt25Os=;
	b=QKT4HdcoJdEvUZfIcgwEDiYkoRKAl+U5a+eQWDejG4zbhztRLoVkV05rnokrQjZZds2W
	 sBlV/y+nIfxJkuLgfZ6lxt+rPAv9Xspwv2HW7HtQXGee+c5yllctxeF2MG7DMCCg/WRqB
	 efiX3V+uaLaxFJp9o7u9n5Hh5NJHTaFpS9yvhEyFDDd4BppIpraaoaeeO36xUKqKcDr97
	 D4lLNYyEOc5VWvpxs13Tc/K+gH88rIVGDG6oXUBMb7NVCc2RGVWx2ETWBz88M5m5GW003
	 t58v8Of7ArrOl0tFQm04N/BXnLX88JHX+y1Qwn3eco0bWVfUrsyvphGb0ZVVwf89vLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nkhIoCk9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A10606A335
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nkhIoCk9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909201F008A2;
	Fri,  6 Nov 2026 05:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793944252;
	bh=q33Iw0NQot0Eu0pzBS6JaAbTkeKRPc2nqwP9zTt25Os=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nkhIoCk9DwM9LoEYPsQlhTu0H86n+6EKiCKI87gsIehtnBihAb0G2Fui3sMJx45YJ
	 DTYPmnH09bJyL5Gt4o+8338dQLvTI54UjNtFqcdhNLNIEzODp60NNuEE+qDjk4MPbX
	 hdrxAgQ36LgFBuwIR+Eg2XjXUqsOY58KkNhNE08WRpO1cHzYicRp882z4hAAyD/Iyp
	 pA7lSG0yE3fK8kLyFBHiyaxTWf0pGiOKHbpXGj9USu3/5SnayPnhFU++07gg6brfZp
	 yIFR5vnZ70joEgW0O97y7NfDkbxRf6ECHxlle/zcMpbihEM+2+lN9hcBAFXzw2hwtG
	 114+ACDVw/eug==
Message-ID: <sashiko-outbox-200865@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] virtio_console: fix buffer ownership and unplug
 races in the read path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yaohan Li" <shunsheng1218@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106053438.1206065-1-shunsheng1218@gmail.com>
References: <20261106053438.1206065-1-shunsheng1218@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:50:52 +0000
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
- [Medium] virtio_console: unplug race in fill_readbuf() and
  port_fops_read() returns 0
--

commit eb5deeedcdec231a191fa4aa424df11b809cdf63
Author: Yaohan Li <shunsheng1218@gmail.com>

virtio_console: fix buffer ownership and unplug races in the read path

This commit tracks ownership of port input buffers across unlocked reads
and adds an unplugging state to prevent use-after-free and buffer reorder
races during concurrent reads and port hot-unplug.

> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 019bcae81af5c..d1757017d9bd0 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
[ ... ]
> @@ -534,19 +551,48 @@ static void discard_port_data(struct port *port)
>  			 err);
>  }
> =20
> -static bool port_has_data(struct port *port)
> +/*
> + * Input state of a port, snapshotted under inbuf_lock.  The distinction
> + * between a buffer that can be acquired now (AVAILABLE) and one that is
> + * owned by another reader (CLAIMED) matters for poll() and for blocking
> + * reads: only AVAILABLE must be reported as readable, while both mean
> + * that unread data may still be pending for the EOF logic.
> + */
> +enum port_input_state {
> +	PORT_INPUT_EMPTY,
> +	PORT_INPUT_AVAILABLE,
> +	PORT_INPUT_CLAIMED,
> +	PORT_INPUT_UNPLUGGED,
> +};
> +
> +/* Callers must not hold inbuf_lock. */
> +static enum port_input_state port_input_state(struct port *port)
>  {
>  	unsigned long flags;
> -	bool ret;
> +	enum port_input_state state;
> =20
> -	ret =3D false;
>  	spin_lock_irqsave(&port->inbuf_lock, flags);
> -	port->inbuf =3D get_inbuf(port);
> -	if (port->inbuf)
> -		ret =3D true;
> +
> +	if (port->unplugging || !port->portdev) {
> +		state =3D PORT_INPUT_UNPLUGGED;
> +	} else if (port->inbuf_claimed) {
> +		state =3D PORT_INPUT_CLAIMED;
> +	} else {
> +		port->inbuf =3D get_inbuf(port);
> +		state =3D port->inbuf ? PORT_INPUT_AVAILABLE
> +				    : PORT_INPUT_EMPTY;
> +	}
> =20
>  	spin_unlock_irqrestore(&port->inbuf_lock, flags);
> -	return ret;
> +	return state;
> +}
> +
> +static bool port_has_data(struct port *port)
> +{
> +	enum port_input_state state =3D port_input_state(port);
> +
> +	return state =3D=3D PORT_INPUT_AVAILABLE ||
> +	       state =3D=3D PORT_INPUT_CLAIMED;
>  }
[ ... ]
> @@ -692,24 +738,112 @@ static ssize_t __send_to_port(struct port *port, s=
truct scatterlist *sg,
[ ... ]
> +	port->inbuf =3D get_inbuf(port);
>  	buf =3D port->inbuf;
> +	if (!buf) {
> +		spin_unlock_irqrestore(&port->inbuf_lock, flags);
> +		if (!to_user)
> +			return 0;
> +		if (nonblock)
> +			return READ_ONCE(port->host_connected) ? -EAGAIN : 0;
> +		/*
> +		 * The data we saw was consumed by another reader while we
> +		 * waited for its claim.  Keep blocking like the fops-level
> +		 * wait instead of reporting a spurious EOF: wait for new
> +		 * data, a disconnect or the unplug fence.
> +		 */
> +		err =3D wait_event_freezable(port->waitqueue,
> +					   !will_read_block(port));
> +		if (err)
> +			return err;
> +		if (!READ_ONCE(port->guest_connected))
> +			return -ENODEV;
> +		if (!READ_ONCE(port->host_connected) && !port_has_data(port))
> +			return 0;
> +		goto retry;
> +	}

[Severity: Medium]
Can fill_readbuf() and port_fops_read() still return 0 instead of -ENODEV
when a read races with unplug_port()?

unplug_port() sets port->unplugging =3D true under inbuf_lock, drops the
lock to remove port->list under ports_lock, and only then re-acquires
inbuf_lock to clear guest_connected and host_connected.  Furthermore,
port_has_data() returns false for PORT_INPUT_UNPLUGGED, and
port->host_connected is read outside inbuf_lock:

CPU0 (fill_readbuf)               CPU1 (unplug_port)
wait_event_freezable(...)
                                  spin_lock_irq(&port->inbuf_lock)
                                  port->unplugging =3D true
                                  spin_unlock_irq(&port->inbuf_lock)
                                  ...
                                  spin_lock_irq(&port->inbuf_lock)
  !READ_ONCE(port->guest_connected)
    -> false
                                  port->guest_connected =3D false
                                  port->host_connected =3D false
                                  spin_unlock_irq(&port->inbuf_lock)
  !READ_ONCE(port->host_connected)
    && !port_has_data(port)
    -> true (PORT_INPUT_UNPLUGGED)
  return 0;  <-- returns EOF instead of -ENODEV

The same split between port_input_state() (or get_inbuf()) and
READ_ONCE(port->host_connected) exists in the non-blocking path above and
at bothPORT_INPUT_EMPTY checks in port_fops_read(): if unplug_port() runs
after port_input_state() returns PORT_INPUT_EMPTY, it clears
port->host_connected and the reader returns 0 instead of -ENODEV.

In addition, because unplug_port() sets port->unplugging before clearing
port->guest_connected, port_fops_poll() can observe port->guest_connected
as true and then call will_read_block(), which sees PORT_INPUT_UNPLUGGED
and returns false, reporting EPOLLIN | EPOLLRDNORM on an unplugging port
with no data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106053438.1206=
065-1-shunsheng1218@gmail.com?part=3D1
