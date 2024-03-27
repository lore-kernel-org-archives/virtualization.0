Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE4622EF4
	for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 02:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711507507; cv=none; b=A8puLkHgezo5qe4gQ7kPfkulkt7BcQTPa4DmYCFoWlpZ0DnTLxj8E99P0f2g3+wuU5GCCFgmLRwjqnYGpCsZhjAM9SYbTJHYjt2j+Wd93/Z4Rms5AujD3MpB1+7U4PLeaW31ZQz4AqJYU1hxrpMUfoni3RRg5xHchF86rL2THls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711507507; c=relaxed/simple;
	bh=IqGg7LyLJ4vm9PU6ptmTZNKaGaZu+PMIhLvA/eSMrIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZjCrGD0WVQatwwDTSGtYeLIZrjnLj4PIVD3GAvFbyP0nJ7VyDYUcAX/1ttJnuEuAxuUloPg1DG48N9+qV6oKxdpnS0P3nO+CT0YeGULKHSXAZntkp/xwBCWnLjWuRWb39ysP0+K1CBhb2CqHZGAC+Nig9G3hGC+pxM0zbXkK2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+4Iee3H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+4Iee3H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711507502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkfmtcIYl603EVBW7jCFuDGcWJSt5orkk6Zu8ttf8Fk=;
	b=V+4Iee3H1VH8TEoiXWova94+JuDXaUkJd9qWvr4ATJnfRaShBNiexnBhmVG/iDb33rt40M
	Clrt2jSVxaEUzdOyaikJEGddhiQu7Isg5VvAfYpp7y0Q3q/N5JuoRDVXM2xtIj/inA9/DC
	sr4vgWvvGCuGIoe9V8D/oQMpB4eddLU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-2jK1RXswNFKFG3oEXqbR5g-1; Tue, 26 Mar 2024 22:45:01 -0400
X-MC-Unique: 2jK1RXswNFKFG3oEXqbR5g-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5cf555b2a53so255925a12.1
        for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 19:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711507499; x=1712112299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkfmtcIYl603EVBW7jCFuDGcWJSt5orkk6Zu8ttf8Fk=;
        b=qES3Bh2Gcc9qkAqu/YZUuv7CRBptG2Fveeo5/JSZ/n1Ojp98Cmu+9T6RUeWyS2dfWo
         eTjBpQWF2hgMGW8UOhw0wYpkeYh89VoZapxRBhQh8jB8Mk2i1yIkCfoBt/eJrVEVhqO8
         SSxyypw6ceaSXiflkys26QSPmou3nsC4gNVLSMPTJPfxlgZIwhxU7FqQxtJVgafpv4Nt
         mkISiSW5gE667v+r9TTrWJ/AeMS5WplarAyUDP5+XNCzRtsfBHmjpPTCkmLHZgYo5hCh
         6K61U7etuvmdm8JqL7PTey0G9nJHRKoUhPcq5fYjyaDn/sYH8kQRIARyQicvwSyLQQGV
         3utg==
X-Gm-Message-State: AOJu0YzukmkAEz8d4nk5o1tA9nX1ZmV8950xan8Cu+X0Wb+FDmmI893q
	MkdDiQdrDfb9bo6LkIkZmj9dcJfdJ97+nRRCpSBN7t8GJIYmdXTlq9Tf1uTHFdY5Qe6fDx3celJ
	yWqwm8AR0ry0n20+AOsOarvAcLAgDd22NRv6Wv39JXzblu1gZ3tE6A94tY1yVfQJuwbOTuZToll
	LujERgiSmQdtiZCV4NZxq7Y1d9ogJhy+J2Y5fLeNg=
X-Received: by 2002:a17:90a:c703:b0:2a0:76b1:896 with SMTP id o3-20020a17090ac70300b002a076b10896mr4392456pjt.12.1711507499589;
        Tue, 26 Mar 2024 19:44:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3MSgO2iAnKqGRMUSsmYhf817+2wItKWdIG835eY+e3znNWn8QDzGM+32n0mUkdpfVvpgn44vCtIs5VuWjmrI=
X-Received: by 2002:a17:90a:c703:b0:2a0:76b1:896 with SMTP id
 o3-20020a17090ac70300b002a076b10896mr4392437pjt.12.1711507499282; Tue, 26 Mar
 2024 19:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240326233846.1086253-1-gshan@redhat.com> <20240326233846.1086253-2-gshan@redhat.com>
 <CACGkMEtyEo2QQSEh0ZnZDUJSXMMhzeO97Jp0wF4_rhzUBGk4Zg@mail.gmail.com>
In-Reply-To: <CACGkMEtyEo2QQSEh0ZnZDUJSXMMhzeO97Jp0wF4_rhzUBGk4Zg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Mar 2024 10:44:48 +0800
Message-ID: <CACGkMEtUdgDr_M-F8-gdFkJp+29Xuw9DCib2-diFmJxFxDN2Bw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vhost: Add smp_rmb() in vhost_vq_avail_empty()
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	mst@redhat.com, davem@davemloft.net, stefanha@redhat.com, sgarzare@redhat.com, 
	keirf@google.com, yihyu@redhat.com, shan.gavin@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 10:34=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Wed, Mar 27, 2024 at 7:39=E2=80=AFAM Gavin Shan <gshan@redhat.com> wro=
te:
> >
> > A smp_rmb() has been missed in vhost_vq_avail_empty(), spotted by
> > Will Deacon <will@kernel.org>. Otherwise, it's not ensured the
> > available ring entries pushed by guest can be observed by vhost
> > in time, leading to stale available ring entries fetched by vhost
> > in vhost_get_vq_desc(), as reported by Yihuang Yu on NVidia's
> > grace-hopper (ARM64) platform.
> >
> >   /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
> >   -accel kvm -machine virt,gic-version=3Dhost -cpu host          \
> >   -smp maxcpus=3D1,cpus=3D1,sockets=3D1,clusters=3D1,cores=3D1,threads=
=3D1 \
> >   -m 4096M,slots=3D16,maxmem=3D64G                                 \
> >   -object memory-backend-ram,id=3Dmem0,size=3D4096M                \
> >    :                                                           \
> >   -netdev tap,id=3Dvnet0,vhost=3Dtrue                              \
> >   -device virtio-net-pci,bus=3Dpcie.8,netdev=3Dvnet0,mac=3D52:54:00:f1:=
26:b0
> >    :
> >   guest# netperf -H 10.26.1.81 -l 60 -C -c -t UDP_STREAM
> >   virtio_net virtio0: output.0:id 100 is not a head!
> >
> > Add the missed smp_rmb() in vhost_vq_avail_empty(). Note that it
> > should be safe until vq->avail_idx is changed by commit 275bf960ac697
> > ("vhost: better detection of available buffers").
> >
> > Fixes: 275bf960ac697 ("vhost: better detection of available buffers")
> > Cc: <stable@kernel.org> # v4.11+
> > Reported-by: Yihuang Yu <yihyu@redhat.com>
> > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > ---
> >  drivers/vhost/vhost.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 045f666b4f12..00445ab172b3 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2799,9 +2799,18 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev,=
 struct vhost_virtqueue *vq)
> >         r =3D vhost_get_avail_idx(vq, &avail_idx);
> >         if (unlikely(r))
> >                 return false;
> > +
> >         vq->avail_idx =3D vhost16_to_cpu(vq, avail_idx);
> > +       if (vq->avail_idx !=3D vq->last_avail_idx) {
> > +               /* Similar to what's done in vhost_get_vq_desc(), we ne=
ed
> > +                * to ensure the available ring entries have been expos=
ed
> > +                * by guest.
> > +                */
>
> We need to be more verbose here. For example, which load needs to be
> ordered with which load.
>
> The rmb in vhost_get_vq_desc() is used to order the load of avail idx
> and the load of head. It is paired with e.g virtio_wmb() in
> virtqueue_add_split().
>
> vhost_vq_avail_empty() are mostly used as a hint in
> vhost_net_busy_poll() which is under the protection of the vq mutex.
>
> An exception is the tx_can_batch(), but in that case it doesn't even
> want to read the head.

Ok, if it is needed only in that path, maybe we can move the barriers there=
.

Thanks

>
> Thanks
>
>
> > +               smp_rmb();
> > +               return false;
> > +       }
> >
> > -       return vq->avail_idx =3D=3D vq->last_avail_idx;
> > +       return true;
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);
> >
> > --
> > 2.44.0
> >

