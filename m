Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A2C38E5DC
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 06:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161085; cv=none; b=TKFTEaIH5OT3xJjVd812kRm9OistxIu+Uakt+n+JPI9oP2pnluhg6/otIfwSxS9p7CxnYiLlq8Lwj+HwHFRovSFf/aPdnSvhksa6nB2d2drkTfKHfz21gsEGqYexXHe6HJuHtQ2wLmAD90ZbPN7z+uX+SSz+T+vDGpUla5ItNjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161085; c=relaxed/simple;
	bh=ZrbNfBzMmUTqGBOYhHktbtct3S5ijcX7oqcD99fGGrg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fuEzx8YjDRy0ThiREiVUUTUQlMTgXBCbf/ZA4gVw56EZX/sLtgneF9clwnkMbui9GvvIVoICFVrH0bT0SuuS7pyJPBSZXNh0clHR0BPWpFB9QK/XfIAcXqh6LzIIhNbcScNOwxjitSFoBf9hBKtpsZk9u9GWoe/aMWQM6KvHI9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZtgLgCJ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZtgLgCJ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef5146b56so360643f8f.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 23:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781161080; x=1781765880; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JH2zHVEfiMPFc41JmepJizrYfOyCb3ptRxHBNZBruwQ=;
        b=WZtgLgCJNIb4fkTs4R4301u+23fXdpcU5NKLeUFykzsazNOpudkcrk9hsn4i4C9QPs
         bdLoA/UEy/GSucU29V6g2C6Bmc5ckZBTBFL0yz4p4m8PEeRjHU0zja2SeYvkBz67Xl9n
         0ZbL2moMZlbxYUnGEbMggmbjHee+Ej7wBYvMEEF/vlUQZ9ViqQ+ULbMEsBdhVpCD3w75
         mUiyuToAI76bpiSlXgq2tLP9gIQQ6LOJ5FDbCGOpDgZLr/BHc94tGAIxT/X1e+gcKdnK
         3TaGPY++EeOYcc/qq/3ux8xI0MH8oyB6F8cpYNB8groZ08GDlC3HeXUODY8/v9TmESPy
         9zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161080; x=1781765880;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JH2zHVEfiMPFc41JmepJizrYfOyCb3ptRxHBNZBruwQ=;
        b=PA40Wg1dbg6cFHHHe0quJ60P5JyVf7ixcwfx2nSXhW9lL4D2IVv3oi0lDv0y3HMTql
         sIrfUmYSiUo2As8y7kbYcIfuRwRtYKbr8aMmHHoKPqAgZmp0zFrOuRu1TNKEYkhZmK59
         Fv9rjGIROftA0Z39Zf9N1LO0/2LVEdb4IEfqILkmFi7IWl4cbdKvbPQp+m6Z84BkQRdn
         pKECZT4x4eWba/Vaj6sKXeCb2+xV39KB4NcwZawyO981TuHwFQFJmn15MZ/Q+1rD65Z4
         ZpqHKPtKabsDx/TVojKSJrr6zEJnOiw4uAKfKsy4gdOn2JLfz+jN2O9YKBGJtAk2QUKD
         Dh5w==
X-Forwarded-Encrypted: i=1; AFNElJ/Jhma9TaZ9T3meKCarwLKDUrkAnmGoxbyTUaeOiekh18FWyuF6iHxNa2w2ik/1MJunJQik0EcotlKWnujEWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRyuC8rULYuzOWc2zbg1aDQ2c09Kp7SymPol2VVsAB4DOOPrd6
	6f3qI8Ld3pF2IaON/Z80LEh9uqPUdXZvR7r/O50M4NC8lSd0YY1VC7gm
X-Gm-Gg: Acq92OEVBowZuefUUvVP+7rWvAsPkkwjqV2JMgkKIH+fUDL0pRpj9l1+gjJZogrYFXz
	PKA+0Z6zCbhqU+1lklMem+rr+NUKSvO6UFhSezOeiEwzd+WxBxbMP0xlSQCY12HAlUO5w4NDfc8
	WHE3lvIQRrS5KZvA4wDldpkPUvXAmnmiQ3IEmmHphNF3UfPG6+LLfW8CZHcEg08QAARQSfHUn73
	LsgkxY+jN3ZEEARkkj5wShsMYP/zqCeK9Fyj0hYN0boPRWXp/wVocm1/aE90tfpNzt0+gOQ668W
	kVMm/t8pNxHZN5cbWvTmoFYiJ1zR69XU+JipjIvksZeXq0HDS9Q7OIV4F233ZEgHU4qGzxc4qES
	0Y9pH0V0WI1nrwRgOGUtXl/0MVyELzuCDghb8OHDqViLq/uYuTB0AkY6ogt28z9OrJtFOLJoPhg
	CK3OH6tJASnCQ9UQvKeqPRgDKAd69xbFfxcmMy9M1au/n+cJ8j72zh+WhuUUiDFJX7sfMb
X-Received: by 2002:a05:6000:184e:b0:45f:3385:bceb with SMTP id ffacd0b85a97d-46067bd48afmr1624072f8f.4.1781161079512;
        Wed, 10 Jun 2026 23:57:59 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dcbdsm65778592f8f.7.2026.06.10.23.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:57:58 -0700 (PDT)
Message-ID: <dce7a3af2e8fd674d842efe7e21abb4644248155.camel@gmail.com>
Subject: Re: [PATCH RESEND] virtio_console: read size from config space
 during device init
From: Filip Hejsek <filip.hejsek@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Rusty Russell
 <rusty@rustcorp.com.au>, 	virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Thu, 11 Jun 2026 08:57:57 +0200
In-Reply-To: <20260610030318-mutt-send-email-mst@kernel.org>
References: <20260223-virtio-console-fix-v1-1-0cf08303b428@gmail.com>
	 <20260610030318-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Wed, 2026-06-10 at 03:04 -0400, Michael S. Tsirkin wrote:
> On Mon, Feb 23, 2026 at 06:37:02PM +0100, Filip Hejsek wrote:
> > Previously, the size was only read upon receiving the config interrupt.
> > This interrupt is sent when the size changes. However, we also need to
> > read the initial size.
> >=20
> > Also make sure to only read the size from config if F_SIZE is enabled.
> >=20
> > Fixes: 9778829cffd4 ("virtio: console: Store each console's size in the=
 console structure")
> > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> > ---
> > This is a resend of [1], which hasn't received any response.
> >=20
> > I found this bug while developing patches for QEMU that add virtio
> > console resize support. If you want to test this, you can get my QEMU
> > patches from [2]. You will need to disable multiport
> > using `-device virtio-serial,max_ports=3D1`.
> >=20
> > [1]: https://lore.kernel.org/all/20251224-virtio-console-fix-v1-1-69d03=
49692dc@gmail.com/
> > [2]: https://lore.kernel.org/all/20250921-console-resize-v5-0-89e3c6727=
060@gmail.com/
> >=20
> > I'll also repeat my questions from the previous submission here. These =
are
> > things that confused me when I was trying to understand the surrounding=
 code,
> > but should in no way prevent merging this patch.
> >=20
> >   - Why does use_multiport use __virtio_test_bit instead of
> >     virtio_has_feature?
> >=20
> >   - The VIRTIO_CONSOLE_RESIZE handler sets irq_requested to 1, which I
> >     think makes no sense?
> > ---
> >  drivers/char/virtio_console.c | 52 ++++++++++++++++++++++++++---------=
--------
> >  1 file changed, 31 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_consol=
e.c
> > index 088182e54d..c355f6d392 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -1771,32 +1771,40 @@ static void config_intr(struct virtio_device *v=
dev)
> >  		schedule_work(&portdev->config_work);
> >  }
> > =20
> > -static void config_work_handler(struct work_struct *work)
> > +static void update_size_from_config(struct ports_device *portdev)
> >  {
> > -	struct ports_device *portdev;
> > +	struct virtio_device *vdev;
> > +	struct port *port;
> > +	u16 rows, cols;
> > =20
> > -	portdev =3D container_of(work, struct ports_device, config_work);
> > -	if (!use_multiport(portdev)) {
> > -		struct virtio_device *vdev;
> > -		struct port *port;
> > -		u16 rows, cols;
> > +	vdev =3D portdev->vdev;
> > =20
> > -		vdev =3D portdev->vdev;
> > -		virtio_cread(vdev, struct virtio_console_config, cols, &cols);
> > -		virtio_cread(vdev, struct virtio_console_config, rows, &rows);
> > +	/*
> > +	 * We'll use this way of resizing only for legacy support.
> > +	 * For multiport devices, use control messages to indicate
> > +	 * console size changes so that it can be done per-port.
> > +	 *
> > +	 * Don't test F_SIZE at all if we're rproc: not a valid feature.
> > +	 */
> > +	if (is_rproc_serial(vdev) ||
>=20
> Wait a second. Why is there this rproc test here?
> Was not in the original code and commit log says nothing about it.
>=20

Previously, this code was in config_work_handler(), which was never
called for rproc_serial (it's scheduled from config_intr(), which is
the config_changed handler only for virtio_console).

Now update_size_from_config() is called unconditionally from
virtcons_probe(), so it will be called for rproc_serial too, which
doesn't have the F_SIZE feature.

>=20
> > +	    use_multiport(portdev) ||
> > +	    !virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
> > +		return;
> > =20
> > -		port =3D find_port_by_id(portdev, 0);
> > -		set_console_size(port, rows, cols);
> > +	virtio_cread(vdev, struct virtio_console_config, cols, &cols);
> > +	virtio_cread(vdev, struct virtio_console_config, rows, &rows);
> > =20
> > -		/*
> > -		 * We'll use this way of resizing only for legacy
> > -		 * support.  For newer userspace
> > -		 * (VIRTIO_CONSOLE_F_MULTPORT+), use control messages
> > -		 * to indicate console size changes so that it can be
> > -		 * done per-port.
> > -		 */
> > -		resize_console(port);
> > -	}
> > +	port =3D find_port_by_id(portdev, 0);
> > +	set_console_size(port, rows, cols);
> > +	resize_console(port);
> > +}
> > +
> > +static void config_work_handler(struct work_struct *work)
> > +{
> > +	struct ports_device *portdev;
> > +
> > +	portdev =3D container_of(work, struct ports_device, config_work);
> > +	update_size_from_config(portdev);
> >  }
> > =20
> >  static int init_vqs(struct ports_device *portdev)
> > @@ -2054,6 +2062,8 @@ static int virtcons_probe(struct virtio_device *v=
dev)
> >  	__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
> >  			   VIRTIO_CONSOLE_DEVICE_READY, 1);
> > =20
> > +	update_size_from_config(portdev);
> > +
> >  	return 0;
> > =20
> >  free_chrdev:
> >=20
> > ---
> > base-commit: b927546677c876e26eba308550207c2ddf812a43
> > change-id: 20251224-virtio-console-fix-3d46980ef569
> >=20
> > Best regards,
> > --=20
> > Filip Hejsek <filip.hejsek@gmail.com>
