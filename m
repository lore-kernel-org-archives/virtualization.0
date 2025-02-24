Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB668156677
	for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 02:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362850; cv=none; b=BKRy1l3d0Xqdn+qFkfmnZt1pmDMBF40zH/vcGQa4QtWjbIDllOfFusnOV6JC4qid3GHhRqAshp4CEFtFCTQXx6pRVg6VYfgS7/HWo/Xn7ON83vqq6BLeB1QJrmuBneMx2MWdioe032jrEkoRf4TcyLXkpUsqrfCPo7uHM8/v+y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362850; c=relaxed/simple;
	bh=PU6yMr0sXTgg8AdmJiBB0C7zILOYqIrL0RzfBj+VJek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3jJoc1LyAZUPYn+TPdWzbvqAOu4gA5ca1JMuICtjikV3HoVV3q57l5IZboqSWFjNSnn6wUKJ6i9G9PbJ5QPZfUAAvz7A6JS5kcon0sJrHkEejqr10OnUNMm04rjOp3HbJMsz8/YobmEqy8VHuIERpiR5FbR8hdfk6uM83UKj48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M966L7yF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M966L7yF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740362847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVe7vnB2MmA0mVlr6ZcRDcJS83l3FqdJ8ruAmpKAwnw=;
	b=M966L7yF045tCp5mx3uRzWbeJJnifpPwRky4Shf4HD5qiMQns4Qs/M58SuYJiqRa3jVQwk
	9PgAdxdirpoZoctHAI78x65FL49s3I0H6+FKVpftzDvRZxdrBWGT9EerxKo1bNaimVPHJw
	7vKy912orek0Q1skarhGSYVmilJ/ENc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-idBc8vWCOZCzZeLFpP5zGQ-1; Sun, 23 Feb 2025 21:07:24 -0500
X-MC-Unique: idBc8vWCOZCzZeLFpP5zGQ-1
X-Mimecast-MFC-AGG-ID: idBc8vWCOZCzZeLFpP5zGQ_1740362843
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-220ec5c16e9so81560265ad.1
        for <virtualization@lists.linux.dev>; Sun, 23 Feb 2025 18:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740362843; x=1740967643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVe7vnB2MmA0mVlr6ZcRDcJS83l3FqdJ8ruAmpKAwnw=;
        b=tATF278O7sTIXjQKTZxgiVwzK+NZY4Q4Y/wXX10ogN3ayjOjaMx3phs/WBcFGU3FmL
         6BJkunp/eWB3HkgVYlsSLxKVBjFo+Ag8E22GG1ah/+dHE5vSGEb1JqerEeiZIzxFtvY5
         cyQR4hYldJiwDEk/lxXWcyP+5BTzwfvnXA2QpQbxfdakCeGzh/oP9KLquvnkwvx0au73
         8Myl5Pm0WorZ5VFS8V+9BOEsVmZzOisMr6AAHnpCcWjzMxtahJyPiKNUiZRfavGsiEBQ
         5n45japDZhLYSsbdGX8aroo6NhOxbnYqScCdo1Q44R3r/Dk5Sax9LDFcRPaGu/XEUtqs
         YBOA==
X-Forwarded-Encrypted: i=1; AJvYcCXV6tSimKz33VXTYGwfRCccHe1c05PVGhyAn/pi1w69k0A1KlE94RkZGtDHKeVLAiNiap9YpxrS/grJN59fpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQnV2idiD3IxZqel24qwKnY7ia8nARTYL3SNASwPjeDPwoIN2R
	z/L27xl35GTsk7UlRut876u/FDgGRjjivdUt9FFB0Z+4mKkRDfql7xhY8LbQfOw/F4as1ODX+Wu
	rDhgVuipb0EO742gQXRR24t9Vfn2il/en8tD35VrHX88LTrXZDStPVBY19X3TZ53XSXShuWwTif
	8ZOJ1bKh1144ngAWpZVrqDwXRkFhfuHoBKtlbGsCg=
X-Gm-Gg: ASbGncvysWoYRggvwiO7AYNuGYjjYZusr2+86Oi7eodbheDKc3RmLPgxCQmldn5fZ/5
	jLTNHwTTacNbEWlQb2TFba83HhIjUDabzZWgqrM12fqzNGz+O4yP0G3uc/5qPGlx2z11Cd9GHCA
	==
X-Received: by 2002:a17:902:fc44:b0:215:bb50:6a05 with SMTP id d9443c01a7336-221a0ec944cmr167789775ad.9.1740362843338;
        Sun, 23 Feb 2025 18:07:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWxLxRjbNeL3k+qp4dEmIQrhzolbd0KxIjdVJyEzBRQaexy3vtda6ZsVVrL+WWqHZzBpasJUPbARwF1vugpVw=
X-Received: by 2002:a17:902:fc44:b0:215:bb50:6a05 with SMTP id
 d9443c01a7336-221a0ec944cmr167789465ad.9.1740362842890; Sun, 23 Feb 2025
 18:07:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <c1dbc7dbad9b445245d3348f19e6742b0be07347.1740094946.git.mst@redhat.com>
 <CACGkMEsK5Z_5B9Lz46kYYB_ndOG=CrvtZE_tLbRjL7=fT7OxbQ@mail.gmail.com> <20250220202425-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250220202425-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2025 10:07:11 +0800
X-Gm-Features: AWEUYZko-kyR9PF7g9ncOaaPlJPn8qANKIEBHPGlYecjyDDfOeEVhkoKNiHoBsY
Message-ID: <CACGkMEuKb040MZHeNEX2b2XhuJMLpCwBgTms_zL5NEw9KFgzew@mail.gmail.com>
Subject: Re: [PATCH] virtio: break and reset virtio devices on device_shutdown()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eric Auger <eauger@redhat.com>, 
	Hongyu Ning <hongyu.ning@linux.intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zSgcPuGwWQ-twQX8f489XzTGBV3DqKFHbKWc6DQ3OjE_1740362843
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 9:37=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Feb 21, 2025 at 09:11:51AM +0800, Jason Wang wrote:
> > On Fri, Feb 21, 2025 at 7:42=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> > > accesses during the hang.
> > >
> > >         Invalid read at addr 0x102877002, size 2, region '(null)', re=
ason: rejected
> > >         Invalid write at addr 0x102877A44, size 2, region '(null)', r=
eason: rejected
> > >         ...
> > >
> > > It was traced down to virtio-console. Kexec works fine if virtio-cons=
ole
> > > is not in use.
> > >
> > > The issue is that virtio-console continues to write to the MMIO even =
after
> > > underlying virtio-pci device is reset.
> >
> > Some of my questions were not answered so I need to post them again.
> >
> > Do we need to fix vitio-console?
>
> this fixes all devices so no.
>
> > Note that we've already break the device in virtio_pci_remove():
> >
> > static void virtio_pci_remove(struct pci_dev *pci_dev)
> > {
> >   struct virtio_pci_device *vp_dev =3D pci_get_drvdata(pci_dev);
> >         struct device *dev =3D get_device(&vp_dev->vdev.dev);
> >
> >         /*
> >          * Device is marked broken on surprise removal so that virtio u=
pper
> >          * layers can abort any ongoing operation.
> >          */
> >         if (!pci_device_is_present(pci_dev))
> >                 virtio_break_device(&vp_dev->vdev);
> >
> > ...
>
>
> shutdown path does not invoke remove, and I do not want to,
> since that will slow down reboots for no good reason.
>
> > >
> > > Additionally, Eric noticed that IOMMUs are reset before devices, if
> > > devices are not reset on shutdown they continue to poke at guest memo=
ry
> > > and get errors from the IOMMU. Some devices get wedged then.
> > >
> > > The problem can be solved by breaking all virtio devices on virtio
> > > bus shutdown, then resetting them.
> > >
> > > Reported-by: Eric Auger <eauger@redhat.com>
> > > Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  drivers/virtio/virtio.c | 31 +++++++++++++++++++++++++++++++
> > >  1 file changed, 31 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > index c1cc1157b380..e5b29520d3b2 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -377,6 +377,36 @@ static void virtio_dev_remove(struct device *_d)
> > >         of_node_put(dev->dev.of_node);
> > >  }
> > >
> > > +static void virtio_dev_shutdown(struct device *_d)
> > > +{
> > > +       struct virtio_device *dev =3D dev_to_virtio(_d);
> > > +       struct virtio_driver *drv =3D drv_to_virtio(dev->dev.driver);
> > > +
> > > +       /*
> > > +        * Stop accesses to or from the device.
> > > +        * We only need to do it if there's a driver - no accesses ot=
herwise.
> > > +        */
> > > +       if (!drv)
> > > +               return;
> > > +
> > > +       /*
> > > +        * Some devices get wedged if you kick them after they are
> > > +        * reset. Mark all vqs as broken to make sure we don't.
> > > +        */
> > > +       virtio_break_device(dev);
> > > +       /*
> > > +        * The below virtio_synchronize_cbs() guarantees that any int=
errupt
> > > +        * for this line arriving after virtio_synchronize_vqs() has =
completed
> > > +        * is guaranteed to see vq->broken as true.
> > > +        */
> > > +       virtio_synchronize_cbs(dev);
> >
> > This looks like a partial re-introduction of the hardening work, but
> > the ccw part is still in-completed e.g the synchronization requires a
> > read_lock() and depends on CONFIG_VIRTIO_HARDEN_NOTIFICATION (which is
> > marked as broken now).
>
> Hmm I don't understand why we can not just take a subchannel lock.

Might be, just want to point that ccw (and there maybe other transport
that) lacks synchronization.

> worth thinking about it. as this doesn't regress i think
> I can live with it for now.
>
> > Should it better to
> >
> > 1) fix the virtio-console
>
> the problem is not unique to console. it was just observed there.
> any device can trigger this.
>
> > 2) simply rest in shutdown
>
> then we are back with devices wedged as they are kicked
> while reset.
>
> > 3) wait for the hardening work to be done in the future?
> >
> > Thanks
>
> as users are seeing this on x86, I want to fix it.
> finding a way to fix virtio_synchronize_cbs seems best.
>
> does not need to block this patch.

Ok.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> > > +       /*
> > > +        * As IOMMUs are reset on shutdown, this will block device ac=
cess to memory.
> > > +        * Some devices get wedged if this happens, so reset to make =
sure it does not.
> > > +        */
> > > +       dev->config->reset(dev);
> > > +}
> > > +
> > >  static const struct bus_type virtio_bus =3D {
> > >         .name  =3D "virtio",
> > >         .match =3D virtio_dev_match,
> > > @@ -384,6 +414,7 @@ static const struct bus_type virtio_bus =3D {
> > >         .uevent =3D virtio_uevent,
> > >         .probe =3D virtio_dev_probe,
> > >         .remove =3D virtio_dev_remove,
> > > +       .shutdown =3D virtio_dev_shutdown,
> > >  };
> > >
> > >  int __register_virtio_driver(struct virtio_driver *driver, struct mo=
dule *owner)
> > > --
> > > MST
> > >
>

