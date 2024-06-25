Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA1C146D55
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719301852; cv=none; b=Q28EZtegfNNPqQLKkprtAIteyktyzJbPl5Bu2bcWFbMbAFuiOh8Fd7NPVsyWWhvSFj2uX3Rcs0zfGDHZCRnDvE2tNTncM0/WvUK6YArcqO41j2vVjBnrUfLwf9XOOBHH4du/caNBBJkqoL732Jle1xr5x1200bDAoZ1479Q72Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719301852; c=relaxed/simple;
	bh=JjdjWqURBMBCsWWwm+UL3g6cP0BmawROoiA0yuQm/Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHhzKHBNT3EKoqPDRgK5gT/C97uA2d89EwtEAybSprJonApUh7JDAazD2rVaXVTmaKIRt4TwMBseINJHDOS/MtyfxqBsoFYKrU8CvPhnPlC+PUS0Fv0E2bKi8TWFD6hZSgVzlebyzZ7z960VL6Ncshne3SiDjmXWxy19la3S+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bd8p6btx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bd8p6btx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719301849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HoV58GQTGopluOa7fyIGB0MekMiGHFN0FrVZ1SzK5K8=;
	b=Bd8p6btxXC7UCTUSqF8FYaniZYDohwELIP3QVKEvkWzRybvM5N1HnF7RWX6cyEwh8wHUPT
	Gzp7GkqsQ15IlgD0HrI0XmdANVnR2vzUvm304XRcIyMLHrpnUJeDqoDeXrCpAFjOONoDuR
	FvONeAI/7Ut8iaj8pW6qbeSiM7I5XUI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-tim04O9IMwWVXfsYeAhopQ-1; Tue, 25 Jun 2024 03:50:45 -0400
X-MC-Unique: tim04O9IMwWVXfsYeAhopQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c7a6c639bfso6780320a91.3
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 00:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719301844; x=1719906644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoV58GQTGopluOa7fyIGB0MekMiGHFN0FrVZ1SzK5K8=;
        b=xRWBdh7EDAOYfXCQ4LvIKz570MuydZp1/f6em8bZohUd6OBMcJdueBQwmbe6t1dybb
         s663MPn2GvdUXRqZ9FaTNrF1j/cid8F3/ekk1OsJTUqE4ykeZpIhl9X5s8KyE+WjtwjR
         UozFI29pVMpdZKw36dhOvYg4E5ZQglwPljNFIsPJywOG8YQ+wjyBWY2VYl0vnfo5ZRBL
         PykoOKKtwx4SGLGltb8WtiOc+EbAIXVqy7qoEOCcxvgZZKEbwT4vj6D4jUUScyQXPQ7W
         TkslSGZTiH63fFxSiBzyz0TVCLshSXMxQaGAH6xzme5df/m14UMdxFN9G7y8mMfRKkWr
         ElJg==
X-Forwarded-Encrypted: i=1; AJvYcCVwzVIK++Hi9wX8AS6bIplouIuGiy+qv/2tTRasGs0fpPFy5NLyGqkjQnIrtqbebM2uovJmOxBwQL7Eq4TJ6otlWUbyKumvdnG9RHX3LM4=
X-Gm-Message-State: AOJu0YytneZy5gFgTMdqJXB8HE7+z/MK/oFGyJtp4GwOmuSC5ULhCRnJ
	GM6jUsJlZNMtXnmNKAn85MscOnik2brlS+Fx2ZOjS/9URKyD0uBwsvBfk67uisLsgRLERRJ8MrY
	YD7T9YHWhH6ldyvIxjt2b5BV6Cvq/jknGgLOq3Ab1TlK4nPY1Q11WZsm1LIz+2gxLaoMkIpPaZ6
	Cs0DyIRazSoKr+dxtf0ReQwiUwkRZ/h2ylLLOznjw=
X-Received: by 2002:a17:90b:1b0f:b0:2c8:3f5:3937 with SMTP id 98e67ed59e1d1-2c858208ff4mr6160155a91.28.1719301844634;
        Tue, 25 Jun 2024 00:50:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQvK5qdA1FBZvQp+q0PyDx7LTJheMl0fDu9wT7HwKGADSTVmOhaGiqvO3JmLgFDN7M9IsUtfzcJiIp79OJvNg=
X-Received: by 2002:a17:90b:1b0f:b0:2c8:3f5:3937 with SMTP id
 98e67ed59e1d1-2c858208ff4mr6160134a91.28.1719301844061; Tue, 25 Jun 2024
 00:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240624024523.34272-1-jasowang@redhat.com> <20240624024523.34272-2-jasowang@redhat.com>
 <20240624054403-mutt-send-email-mst@kernel.org> <CACGkMEv1U7N-RRgQ=jbhBK1SWJ3EJz84qYaxC2kk6keM6J6MaQ@mail.gmail.com>
 <20240625030259-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240625030259-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jun 2024 15:50:30 +0800
Message-ID: <CACGkMEuP5GJTwcSoG6UP0xO6V7zeJynYyTDVRtF8R=PJ5z8aLg@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] virtio: allow nested disabling of the configure interrupt
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com, 
	gia-khanh.nguyen@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 3:11=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Jun 25, 2024 at 09:27:04AM +0800, Jason Wang wrote:
> > On Mon, Jun 24, 2024 at 5:59=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Jun 24, 2024 at 10:45:21AM +0800, Jason Wang wrote:
> > > > Somtime driver may want to enable or disable the config callback. T=
his
> > > > requires a synchronization with the core. So this patch change the
> > > > config_enabled to be a integer counter. This allows the toggling of
> > > > the config_enable to be synchronized between the virtio core and th=
e
> > > > virtio driver.
> > > >
> > > > The counter is not allowed to be increased greater than one, this
> > > > simplifies the logic where the interrupt could be disabled immediat=
ely
> > > > without extra synchronization between driver and core.
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/virtio/virtio.c | 20 +++++++++++++-------
> > > >  include/linux/virtio.h  |  2 +-
> > > >  2 files changed, 14 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > index b968b2aa5f4d..d3aa74b8ae5d 100644
> > > > --- a/drivers/virtio/virtio.c
> > > > +++ b/drivers/virtio/virtio.c
> > > > @@ -127,7 +127,7 @@ static void __virtio_config_changed(struct virt=
io_device *dev)
> > > >  {
> > > >       struct virtio_driver *drv =3D drv_to_virtio(dev->dev.driver);
> > > >
> > > > -     if (!dev->config_enabled)
> > > > +     if (dev->config_enabled < 1)
> > > >               dev->config_change_pending =3D true;
> > > >       else if (drv && drv->config_changed)
> > > >               drv->config_changed(dev);
> > > > @@ -146,17 +146,23 @@ EXPORT_SYMBOL_GPL(virtio_config_changed);
> > > >  static void virtio_config_disable(struct virtio_device *dev)
> > > >  {
> > > >       spin_lock_irq(&dev->config_lock);
> > > > -     dev->config_enabled =3D false;
> > > > +     --dev->config_enabled;
> > > >       spin_unlock_irq(&dev->config_lock);
> > > >  }
> > > >
> > > >  static void virtio_config_enable(struct virtio_device *dev)
> > > >  {
> > > >       spin_lock_irq(&dev->config_lock);
> > > > -     dev->config_enabled =3D true;
> > > > -     if (dev->config_change_pending)
> > > > -             __virtio_config_changed(dev);
> > > > -     dev->config_change_pending =3D false;
> > > > +
> > > > +     if (dev->config_enabled < 1) {
> > > > +             ++dev->config_enabled;
> > > > +             if (dev->config_enabled =3D=3D 1 &&
> > > > +                 dev->config_change_pending) {
> > > > +                     __virtio_config_changed(dev);
> > > > +                     dev->config_change_pending =3D false;
> > > > +             }
> > > > +     }
> > > > +
> > > >       spin_unlock_irq(&dev->config_lock);
> > > >  }
> > > >
> > >
> > > So every disable decrements the counter. Enable only increments it up=
 to 1.
> > > You seem to be making some very specific assumptions
> > > about how this API will be used. Any misuse will lead to under/overfl=
ow
> > > eventually ...
> > >
> >
> > Well, a counter gives us more information than a boolean. With
> > boolean, misuse is even harder to be noticed.
>
> With boolean we can prevent misuse easily because previous state
> is known exactly. E.g.:
>
> static void virtio_config_driver_disable(struct virtio_device *dev)
> {
>         BUG_ON(dev->config_driver_disabled);
>         dev->config_driver_disabled =3D true;
> }
>
>
>
> static void virtio_config_driver_enable(struct virtio_device *dev)
> {
>         BUG_ON(!dev->config_driver_disabled);
>         dev->config_driver_disabled =3D false;
> }
>
>
> Does not work with integer you simply have no idea what the value
> should be at point of call.

Yes but I meant if we want the config could be disabled by different
parties (core, driver and others)

>
>
> > >
> > >
> > > My suggestion would be to
> > > 1. rename config_enabled to config_core_enabled
> > > 2. rename virtio_config_enable/disable to virtio_config_core_enable/d=
isable
> > > 3. add bool config_driver_disabled and make virtio_config_enable/disa=
ble
> > >    switch that.
> > > 4. Change logic from dev->config_enabled to
> > >    dev->config_core_enabled && !dev->config_driver_disabled
> >
> > If we make config_driver_disabled by default true,
>
> No, we make it false by default.
>
> > we need someone to
> > enable it explicitly. If it's core, it breaks the semantic that it is
> > under the control of the driver (or needs to synchronize with the
> > driver). If it's a driver, each driver needs to enable it at some time
> > which can be easily forgotten. And if we end up with workarounds like:
> >
> >         /* If probe didn't do it, mark device DRIVER_OK ourselves. */
> >         if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK)=
)
> >                 virtio_device_ready(dev);
> >
> > It's another break of the semantics. And actually the above is also rac=
y.
> >
> > It seems the only choice is to make config_driver_disabled by default
> > false. But the driver needs to be aware of this and take extra care
> > when calling virtio_device_ready() which is also tricky.
>
>
> No, false by default simply means no change to semantics.

No change to current semantics, probably. But we need to document

1) driver config is enabled by default
2) no nested enabling and disabling

If you think they are all fine, I can go with that way.

>
>
> >
> > So in conclusion, two booleans seems sut-optimal than a counter. For
> > example we can use different bits for the counter as preempt_count
> > did. With counter(s), core and driver don't need any implicit/explicit
> > synchronization.
> >
> > Thanks
> >
>
> We have a simple problem, we can solve it simply. reference counting
> is tricky to get right and hard to debug, if we don't need it let us
> not go there.

I fully agree, and that's why I limit the change to virtio-net driver
in the first version.

>
>
>
> But in conclusion ;) if you don't like my suggestion do something else
> but make the APIs make sense,

I don't say I don't like it:)

Limiting it to virtio-net seems to be the most easy way. And if we
want to do it in the core, I just want to make nesting to be supported
which might not be necessary now.

> at least do better than +5
> on Rusty's interface design scale.
>
> >

Thanks


> >
> >
> > >
> > >
> > >
> > >
> > > > @@ -455,7 +461,7 @@ int register_virtio_device(struct virtio_device=
 *dev)
> > > >               goto out_ida_remove;
> > > >
> > > >       spin_lock_init(&dev->config_lock);
> > > > -     dev->config_enabled =3D false;
> > > > +     dev->config_enabled =3D 0;
> > > >       dev->config_change_pending =3D false;
> > > >
> > > >       INIT_LIST_HEAD(&dev->vqs);
> > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > index 96fea920873b..4496f9ba5d82 100644
> > > > --- a/include/linux/virtio.h
> > > > +++ b/include/linux/virtio.h
> > > > @@ -132,7 +132,7 @@ struct virtio_admin_cmd {
> > > >  struct virtio_device {
> > > >       int index;
> > > >       bool failed;
> > > > -     bool config_enabled;
> > > > +     int config_enabled;
> > > >       bool config_change_pending;
> > > >       spinlock_t config_lock;
> > > >       spinlock_t vqs_list_lock;
> > > > --
> > > > 2.31.1
> > >
>

