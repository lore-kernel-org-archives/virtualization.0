Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED473D962
	for <virtualization@lists.linux.dev>; Mon,  6 May 2024 03:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714965883; cv=none; b=R6P9xJkuDtMcMYncI2mHjmnOJibOE91O1pe1GhvElLjMOSkNqPdQPOklbolS9lR8Dmo4wHj/E6vfWAL338KJQfgQ87WHY15oocI0q53CQXHzZpWuza3FJ8/x+HRsNgvPc05byXhREK//0+ibKKd0E5L2POFvZCixegK7JKdLP4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714965883; c=relaxed/simple;
	bh=bBHRYR+zXOeAjZ6EPCrBlhNWwq4VARwBFLo2xTUGLZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlanfcaY7ycE/DTdPLDgRKKn/1ZQXEwtJjE8hKcZcUUyHJwBWKFLsmoD9uyI4BWRorjMLilYbktu2QaGSsdW43HAF1ftRJdQBArzE+6LBodRkVwyIS3yR0Cfp+lSVC8NW4ix+8efW9JH1FjsectT9b66stmFMJYO26SbSfA7v+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXJq8JDl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXJq8JDl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714965880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXECy0j7At+OptqnyBfrJG9H7LKgIkADB2rySsLldvo=;
	b=WXJq8JDlWzX2RreasT/YGBM98hdl/Ps6Nslp+qsHicoB3wDUpJVbd28NgUA3uM2svU9kWM
	1bF5ZbqLs7sMebBejVEygyQYgHl/StRkfX0QWPz0Vz4ndVVRF/XohxGAqpAuFGakyU3aHD
	wlbKwPhLpS6D+aU4vQdMHqkdfAz/pUs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-h1At8un-OUiVxIb3dc0UVw-1; Sun, 05 May 2024 23:24:38 -0400
X-MC-Unique: h1At8un-OUiVxIb3dc0UVw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2b38f3e2919so2768730a91.0
        for <virtualization@lists.linux.dev>; Sun, 05 May 2024 20:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714965878; x=1715570678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXECy0j7At+OptqnyBfrJG9H7LKgIkADB2rySsLldvo=;
        b=HrMNZjReKfRJqBQ3gkyDvsV3ZrTXQkKKsfSg4zgG7dHQUZTTupcglsWl7K+wz3Y4f4
         Ytf8/CuF9rOc2gi0+QykVWxZ5Er0B/iuqNgyAK1FbQXro+nQ6NgVod+1r5I5sPePnEd1
         28rCK7k6d16s4ka+pEGuBeNGU/88pa1JBG5YFKgpYEqy1RKd1qtPNJPJPLb+Xdrlk04k
         /CuJIQR3p8RoIU3ml5EKuboHcfS2Eab8TtixmVkrQoaHYoqrj3W+J/UrG8wsMCtXiNQC
         V8+0JAucLQGVp+WGHqX/SSNeenueoTk9Ft06njpMZeJk8xRD/zgLgzt1+YztIjKtUdCx
         43lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeZ7Dj90nbWFJBFEAz7sXNNLToJxweCSB+r5FUvrESdrOwtEoqCSW81uod3+X/xLjYejMZ9XYTAnGW/kiPOcFQzAXWOG3iLZBylnIlEOo=
X-Gm-Message-State: AOJu0YxRHbzwKf3clPmclLoCMvonWifrkYS4IvFZQnnm9/5+NlmavAFJ
	Mg1khtemSlf0ERj/5JfvOcNSMwUV6GNvmFKi0QZs1DaXsBcR64OF3lYbDIIMTl3R/hxgpmzNhSQ
	+KxAin576AV5iHRyuwu2jWUTu6cJ8fSO+Ni9d6bWxo41zLc97erLZjqUJS9gWIaCYuFzzqHz2fE
	2nUVkPMaPFCfiU6PixmlfMJml/8hucHbyC0skvkFc=
X-Received: by 2002:a17:90b:19cc:b0:2b2:da7:2c83 with SMTP id nm12-20020a17090b19cc00b002b20da72c83mr12511968pjb.4.1714965877808;
        Sun, 05 May 2024 20:24:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsgR09huJq7794Kr7Va7gw9HzoZRK/fRVHd00z788cM7NjAkL3DywsEKb+A/xOZDmoDbwkRNX9xodgt7fyblY=
X-Received: by 2002:a17:90b:19cc:b0:2b2:da7:2c83 with SMTP id
 nm12-20020a17090b19cc00b002b20da72c83mr12511949pjb.4.1714965877400; Sun, 05
 May 2024 20:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZjFH7Xb5gyTtOpWd@localhost.localdomain> <20240430121730-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240430121730-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 May 2024 11:24:25 +0800
Message-ID: <CACGkMEsFMXdswxgguH1P_TkY9wnKgE8RbhUdw_Pd+niSp2UjSg@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Warn if insufficient queue length for transmitting
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Darius Rad <darius@bluespec.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 4:07=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Apr 30, 2024 at 03:35:09PM -0400, Darius Rad wrote:
> > The transmit queue is stopped when the number of free queue entries is =
less
> > than 2+MAX_SKB_FRAGS, in start_xmit().  If the queue length (QUEUE_NUM_=
MAX)
> > is less than then this, transmission will immediately trigger a netdev
> > watchdog timeout.  Report this condition earlier and more directly.
> >
> > Signed-off-by: Darius Rad <darius@bluespec.com>
> > ---
> >  drivers/net/virtio_net.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 115c3c5414f2..72ee8473b61c 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4917,6 +4917,9 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >                       set_bit(guest_offloads[i], &vi->guest_offloads);
> >       vi->guest_offloads_capable =3D vi->guest_offloads;
> >
> > +     if (virtqueue_get_vring_size(vi->sq->vq) < 2 + MAX_SKB_FRAGS)
> > +             netdev_warn_once(dev, "not enough queue entries, expect x=
mit timeout\n");
> > +
>
> How about actually fixing it though? E.g. by linearizing...

Actually, the linearing is only needed for the case when the indirect
descriptor is not supported.

>
> It also bothers me that there's practically
> /proc/sys/net/core/max_skb_frags
> and if that's low then things could actually work.

Probably not as it won't exceed MAX_SKB_FRAGS.

>
> Finally, while originally it was just 17 typically, now it's
> configurable. So it's possible that you change the config to make big
> tcp

Note that virtio-net doesn't fully support big TCP.

> work better and device stops working while it worked fine
> previously.

For this patch, I guess not as we had:

        if (sq->vq->num_free < 2+MAX_SKB_FRAGS)

in the tx path. So it won't even work before this patch.

Thanks

>
>
> >       pr_debug("virtnet: registered device %s with %d RX and TX vq's\n"=
,
> >                dev->name, max_queue_pairs);
> >
> > --
> > 2.39.2
>

