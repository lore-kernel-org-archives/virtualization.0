Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A48832AABA
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168975; cv=none; b=eY2SW3czwwCiekSUKPA7rgtRVkKwSWHa1YaiB16A0iasarwW/NTnsgr0NpQgRLQ/1dFFh4o/4R0A0Vkvjyje9JE7b74Hzf2kERwGXCA/u+Fc5Jo9FbbLL/4g4JO7lwnNKoPJG1iPOaL1L2Jt9vtxLu2aWiz7WD81WHvDQQy5yhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168975; c=relaxed/simple;
	bh=uXw4kUrKvGdpvA7TizOZIWTxRiIoQDCHNqxd/QzJqJA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V/cLq4T/VQMwJA2uAhJkrwEO5PnWTqgcfQB3P3E3DWNibWGex/P4HiiYWC++SxDZWLH+LvubrxLU6bzzpP2MVwQwsRII/hD2ljbiqKNlIoHb1P4XMsKF5l+ql0id8xdGDsWxLkf9jYE5MhWjheyKpTL7A17firkidhzF0/9CKcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJQ6Im6b; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJQ6Im6b"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b3e03939so5569875e9.1
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781168972; x=1781773772; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5oPLEjtKrkT2zg/kgRAfIr3x/KHKzvjTCXuRNjefBxw=;
        b=RJQ6Im6boh+dPXJyqiwZ0YIXZSCeZgijzsPIpXmPe/lXOzgM7lIrvyEXamOTJU747y
         x53JsGT+2D99+gi+LQNl4QB9v3rOCiGSLoJJ3kxO+T6CSNSb7I3QY086/S8Vz5SwsLg1
         zkyrwujH4BWpVbi/1dpW2Pc5x9M37yNAwqcvesvnu7rQCRZkHZ54TfMnl3a0Cf1/4MPL
         aKvtUb4HZPRE0NgTmOplrFCNvjL+husS3EbxrqsNWYqP7+WfV+ZJ89vJu+4i7Y9gccWE
         spptBtrZL66JVWGNt8F31ejrcjnabRd3+3kRRi8pRdVPJiFE5otkEFJbNA+5gPBGbX6M
         UFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168972; x=1781773772;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5oPLEjtKrkT2zg/kgRAfIr3x/KHKzvjTCXuRNjefBxw=;
        b=j28ALiVjWdJD7iPzwUaKVKuWk9L4IlUlWLLNr7yYts2sIEpNg9z+AQA7aeIcfX2vqM
         57rQUHTkyYtrvfKEJfyZ4dhz82+doUPdAVZRRLuA71k6wuNGDobZxrtitIsFhDglYdUo
         4uBBwQLLxGhoopDSUm5tKgD0QkJJ2ichqxoxwIxJKEgiadxyHU+I889QE/gJ0CMAkZxf
         bM4hbXIPN98SvhM6cUvx4cxJDlNc8wrJbJRTGK4JyLdZ7cufnce0KT07yw6I5BQbtJrd
         D+ocgHfkJyxjWr8QP00PT8F3f47KhvLAO5Bq9RChlxSQ1jLoNucsv71QWZJXYJGCr0fh
         v3YQ==
X-Forwarded-Encrypted: i=1; AFNElJ+fsbruE4jJWJouKh0MmCRR20ZiRO2j4Y1LYIzTqTcuQpC4LspyK+qSpX7q2dzuLycwTe8fR3liUBG7Zx9xrA==@lists.linux.dev
X-Gm-Message-State: AOJu0YweVcoNQeTYu0Fortjmx7KOkWgUdwND3eCN0G1l0p496h8QgbAM
	FEsZhzGccnMpSLW9bmPNIy7+WgIbEPqQTMzkJR995zUH66RhGn37RCxF
X-Gm-Gg: Acq92OHSSvIimmhPNvTokX0DrBOEFkNGDfvruF+t9Q5n2p5Z+y0H4YsFRFnu8SjiG/Z
	yhN5P4/oqrqeNQ62UumXSkU3wCj5SGINxPwuAtFw8ensz/90TXeYPpMgr63trNtIfEEHTWVK0Nj
	7uU0Ffoi45kVBAFgiKrmNjzTAFqiNOoPG/1g7qOl9V/NIMx5UvphE4wVNCwyPA/bqyQb4bMEe6x
	3F+rHLuoSKIJt5ed8FTU7ZZIyhGdBxlM59DFvlECLqPbLfjcInjzA9M7D20M1w+vNJrHKIll+YP
	CfCM6o/87/WtvVrhImhtw3UyQ8pZ8xm7iOPhzLGeIKam4ojYD6GLEv7o/u/3bhzYZ7NpJ68px8f
	n7gsqn+eE1qybe9yQTx2TMrE1gVth4JVzJPNRKUjIT47iLj6nxt1hxVu7KTLMQSZEFYUlq4e3a5
	3ESD0DOzvaRmoMGdXzHqGC5AOePcv0/mDCpmmr4kzmc8f30HsY5vQColz48b4imuptYlwN
X-Received: by 2002:a7b:c40e:0:b0:490:b5ab:b41f with SMTP id 5b1f17b1804b1-490e5139f2bmr13700595e9.13.1781168971521;
        Thu, 11 Jun 2026 02:09:31 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f345209sm85649650f8f.17.2026.06.11.02.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:09:31 -0700 (PDT)
Message-ID: <13ed71f8e2bc22476fb0dd48eb17af4917f4f03b.camel@gmail.com>
Subject: Re: [PATCH RESEND] virtio_console: read size from config space
 during device init
From: Filip Hejsek <filip.hejsek@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Rusty Russell
 <rusty@rustcorp.com.au>, 	virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Thu, 11 Jun 2026 11:09:30 +0200
In-Reply-To: <20260611044443-mutt-send-email-mst@kernel.org>
References: <20260223-virtio-console-fix-v1-1-0cf08303b428@gmail.com>
	 <20260610030318-mutt-send-email-mst@kernel.org>
	 <dce7a3af2e8fd674d842efe7e21abb4644248155.camel@gmail.com>
	 <20260611033747-mutt-send-email-mst@kernel.org>
	 <831dca185e55f56a14c0c580ab33ce84361eb67b.camel@gmail.com>
	 <20260611044443-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Thu, 2026-06-11 at 05:01 -0400, Michael S. Tsirkin wrote:
> On Thu, Jun 11, 2026 at 10:29:50AM +0200, Filip Hejsek wrote:
> > On Thu, 2026-06-11 at 03:38 -0400, Michael S. Tsirkin wrote:
> > > [...]
> > > > >=20
> > > > > Wait a second. Why is there this rproc test here?
> > > > > Was not in the original code and commit log says nothing about it=
.
> > > > >=20
> > > >=20
> > > > Previously, this code was in config_work_handler(), which was never
> > > > called for rproc_serial (it's scheduled from config_intr(), which i=
s
> > > > the config_changed handler only for virtio_console).
> > > >=20
> > > > Now update_size_from_config() is called unconditionally from
> > > > virtcons_probe(), so it will be called for rproc_serial too, which
> > > > doesn't have the F_SIZE feature.
> > >=20
> > > So why not test it?=C2=A0
> >=20
> > The virtio_console driver implements two similar but distinct virtio
> > devices: VIRTIO_ID_CONSOLE and VIRTIO_ID_RPROC_SERIAL. Although some of
> > the implementation code is shared, the devices are different. In
> > particular, rproc_serial doesn't support multiport nor any of the tty
> > specific features. This means that the relevant feature bits are not
> > valid for this device and must not be tested.
>=20
>=20
>=20
> > I have to admit though that I don't quite understand what the
> > RPROC_SERIAL device is supposed to be used for. It was added by commit
> > 1b6370463e88b0c1c317de16d7b962acc1dab4f2, which describes it as "a
> > simple serial connection driver called VIRTIO_ID_RPROC_SERIAL (11) for
> > communicating with a remote processor in an asymmetric multi-processing
> > configuration". It seems that it was never standardized, as the virtio
> > spec only says that its ID is reserved.
> >=20
> > > What does "not a valid feature" mean?
> >=20
> > I copied the "not a valid feature" comment form other instances in the
> > same file where a feature is tested, e.g. in resize_console():
> >=20
> > 	/* Don't test F_SIZE at all if we're rproc: not a valid feature! */
> > 	if (!is_rproc_serial(vdev) &&
> > 	    virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
> > 	  hvc_resize(port->cons.hvc, port->cons.ws);
> >=20
> >=20
> > Best regards,
> > Filip Hejsek
>=20
> I get it, it's existing code.  It still makes no sense.
>=20
> rproc has:
>=20
> static const unsigned int rproc_serial_features[] =3D {
> };     =20
>=20
> No features.
> So testing any feature bit at all always returns 0.

virtio_has_feature() will BUG() if called with a feature that hasn't
been offered by the driver (see virtio_check_driver_offered_feature).

(Maybe that was why __virtio_test_bit was used? But that seems pretty
hacky to me.)

>=20
> there's no reason to special case anything.
>=20
> So I'm testing this, but I'm only compiling rproc, so pls holler if it se=
ems wrong:
>=20
>=20
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.=
c
> index 198b97314168..2261862d4b4c 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -340,7 +340,7 @@ static inline bool use_multiport(struct ports_device =
*portdev)
>  	 */
>  	if (!portdev->vdev)
>  		return false;
> -	return __virtio_test_bit(portdev->vdev, VIRTIO_CONSOLE_F_MULTIPORT);
> +	return virtio_has_feature(portdev->vdev, VIRTIO_CONSOLE_F_MULTIPORT);
>  }
> =20
>  static DEFINE_SPINLOCK(dma_bufs_lock);
> @@ -1156,9 +1156,7 @@ static void resize_console(struct port *port)
> =20
>  	vdev =3D port->portdev->vdev;
> =20
> -	/* Don't test F_SIZE at all if we're rproc: not a valid feature! */
> -	if (!is_rproc_serial(vdev) &&
> -	    virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
> +	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
>  		hvc_resize(port->cons.hvc, port->cons.ws);
>  }
> =20
> @@ -1783,11 +1781,8 @@ static void update_size_from_config(struct ports_d=
evice *portdev)
>  	 * We'll use this way of resizing only for legacy support.
>  	 * For multiport devices, use control messages to indicate
>  	 * console size changes so that it can be done per-port.
> -	 *
> -	 * Don't test F_SIZE at all if we're rproc: not a valid feature.
>  	 */
> -	if (is_rproc_serial(vdev) ||
> -	    use_multiport(portdev) ||
> +	if (use_multiport(portdev) ||
>  	    !virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
>  		return;
> =20
> @@ -1994,9 +1989,7 @@ static int virtcons_probe(struct virtio_device *vde=
v)
>  	multiport =3D false;
>  	portdev->max_nr_ports =3D 1;
> =20
> -	/* Don't test MULTIPORT at all if we're rproc: not a valid feature! */
> -	if (!is_rproc_serial(vdev) &&
> -	    virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
> +	if (virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
>  				 struct virtio_console_config, max_nr_ports,
>  				 &portdev->max_nr_ports) =3D=3D 0) {
>  		if (portdev->max_nr_ports =3D=3D 0 ||
>=20
>=20
>=20
>=20
