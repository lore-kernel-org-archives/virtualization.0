Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B4222313
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303498; cv=none; b=cub+ziINiRXju/m/olCQK4Smc02wiEpU9cRr4f0V1GAm7/vEScjhnDXxNjTCteOz9+isuTvvBjPI0OzGEjDiM0fePZY6YYJA8zc1jIFlPIqXp/rvBDevKDirYOgefcbJfuQDjfzRKaSEeZhEwxbi5jc61H1dWnuPX2MZvrw6rec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303498; c=relaxed/simple;
	bh=mp25LbNH529boIqokRGeLXeQI0lUfBXs5y+8uNYS5oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vm4cAELRJfNqrcttVs6FqR7nzXXQWbta0WmFg7n71d/Opwi95NLZ9MmhfpqrWHrRkxxNufSJXFcd0mcCdKc/h9t0feGoCoczxWDIXCewGnxtLco+3YMr9NsfScNC4mQtdm4wVVy55zu4XlTKuTF+T7xkWldFSwUUkCj3ZqlKgy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J44273yx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J44273yx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719303494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNEkDiogTjMA3sbpKjhWJrByDlROYZM+6wl2gluyWtI=;
	b=J44273yx5F+U6vUbcJXWE9C0X1mTOH7RzYjuyq6HdBS64bjnMbfHKZ2R7qq3y/R21CnKCZ
	nMsiLX5gzsqU2IsCIq1SYnSKrjeI5WTO/yYmoDKCuF7G8Dtqm6qsWhQgQpx05oukXpO3U6
	Fkix+0igrgxyHL2MVmX7XkRZfOvFy9w=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-8C76t-79OlSuC3tPnfETVw-1; Tue, 25 Jun 2024 04:18:13 -0400
X-MC-Unique: 8C76t-79OlSuC3tPnfETVw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c7d2380cb8so4496631a91.0
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 01:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719303492; x=1719908292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNEkDiogTjMA3sbpKjhWJrByDlROYZM+6wl2gluyWtI=;
        b=HbMFA/jumtorJMtygVhsbWLOTtMPf39otQ/E+ToRZlRRZc9NXIqbpjvS+xjagQL9xM
         1DqxM0qLSkvZBa2cQhtS2lKCPfjK6WuJ8C515c6BsYq4c8o/x8fYhwGVaqzyn3JwJ+oz
         0zfEBUJDfuOVcr9EmA6ntdjsSylpON7G6hqBP6UQkQpog2JkjurgOAB4cuQgySbHItgK
         0nM9HHzz+cO6H7Uulhj7tKplY+YeGzzRtbzGUe7mKE8L3CEE1v/l0bBCWYjN+5snSQf6
         xVerMbSpkXnb7JbI6t/u02WkdJrSj5fxi5ePYGpr+O8dKs9rF/XEpyTYB96lD7BBa+LS
         gThw==
X-Forwarded-Encrypted: i=1; AJvYcCUnE84SZIVnArJeJ3dBx5DM54KMvu2IP63TfCTy0JkrDfmyhM5hHbdCsK4x4DRu1Rv/SeVk/6riUg9jrDOBO/sjw09bRsDsdR0pAqn8DHI=
X-Gm-Message-State: AOJu0YzLOiMnYvbdMP/OaxlV4xwopp+axfmEMWWEFeUXnsM7qGP2bqQw
	4NrZ5Aqg2NqfIRuopxNYhhCCH8gS7B5zM0/chlS+d6YD3oJtzuGJnk2mrlxdCoyprcFDno3SYCd
	zxrTn0KKpovZ80H3KpvSRMSgjA/A49lWrwcgu89F6Hs3oUJHOGPIr5iCvxoXMGpqQ01KVm/9QI1
	bXvLyT4q0Vtk28/saVRVvwtB1xZLvpnjpAKnQSIus=
X-Received: by 2002:a17:90a:ce01:b0:2c8:5e4d:8db2 with SMTP id 98e67ed59e1d1-2c85e4d8f8bmr8786440a91.5.1719303492147;
        Tue, 25 Jun 2024 01:18:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmclppzqVeu2FHkBTM4CnY178ioASO1IozlB1/rkrD7DD9ywC+6haNOKojp/iJ2YpBJV0iPvdxkEpLAjJo9Xw=
X-Received: by 2002:a17:90a:ce01:b0:2c8:5e4d:8db2 with SMTP id
 98e67ed59e1d1-2c85e4d8f8bmr8786394a91.5.1719303491498; Tue, 25 Jun 2024
 01:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240624024523.34272-1-jasowang@redhat.com> <20240624024523.34272-2-jasowang@redhat.com>
 <20240624054403-mutt-send-email-mst@kernel.org> <CACGkMEv1U7N-RRgQ=jbhBK1SWJ3EJz84qYaxC2kk6keM6J6MaQ@mail.gmail.com>
 <20240625030259-mutt-send-email-mst@kernel.org> <CACGkMEuP5GJTwcSoG6UP0xO6V7zeJynYyTDVRtF8R=PJ5z8aLg@mail.gmail.com>
 <20240625035746-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240625035746-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jun 2024 16:18:00 +0800
Message-ID: <CACGkMEtA8_StbzicRA6aEST8e4SNHFutLmtPu-8zaOZH2zO3cA@mail.gmail.com>
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

On Tue, Jun 25, 2024 at 4:04=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Jun 25, 2024 at 03:50:30PM +0800, Jason Wang wrote:
> > On Tue, Jun 25, 2024 at 3:11=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Tue, Jun 25, 2024 at 09:27:04AM +0800, Jason Wang wrote:
> > > > On Mon, Jun 24, 2024 at 5:59=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Mon, Jun 24, 2024 at 10:45:21AM +0800, Jason Wang wrote:
> > > > > > Somtime driver may want to enable or disable the config callbac=
k. This
> > > > > > requires a synchronization with the core. So this patch change =
the
> > > > > > config_enabled to be a integer counter. This allows the togglin=
g of
> > > > > > the config_enable to be synchronized between the virtio core an=
d the
> > > > > > virtio driver.
> > > > > >
> > > > > > The counter is not allowed to be increased greater than one, th=
is
> > > > > > simplifies the logic where the interrupt could be disabled imme=
diately
> > > > > > without extra synchronization between driver and core.
> > > > > >
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > ---
> > > > > >  drivers/virtio/virtio.c | 20 +++++++++++++-------
> > > > > >  include/linux/virtio.h  |  2 +-
> > > > > >  2 files changed, 14 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > > > index b968b2aa5f4d..d3aa74b8ae5d 100644
> > > > > > --- a/drivers/virtio/virtio.c
> > > > > > +++ b/drivers/virtio/virtio.c
> > > > > > @@ -127,7 +127,7 @@ static void __virtio_config_changed(struct =
virtio_device *dev)
> > > > > >  {
> > > > > >       struct virtio_driver *drv =3D drv_to_virtio(dev->dev.driv=
er);
> > > > > >
> > > > > > -     if (!dev->config_enabled)
> > > > > > +     if (dev->config_enabled < 1)
> > > > > >               dev->config_change_pending =3D true;
> > > > > >       else if (drv && drv->config_changed)
> > > > > >               drv->config_changed(dev);
> > > > > > @@ -146,17 +146,23 @@ EXPORT_SYMBOL_GPL(virtio_config_changed);
> > > > > >  static void virtio_config_disable(struct virtio_device *dev)
> > > > > >  {
> > > > > >       spin_lock_irq(&dev->config_lock);
> > > > > > -     dev->config_enabled =3D false;
> > > > > > +     --dev->config_enabled;
> > > > > >       spin_unlock_irq(&dev->config_lock);
> > > > > >  }
> > > > > >
> > > > > >  static void virtio_config_enable(struct virtio_device *dev)
> > > > > >  {
> > > > > >       spin_lock_irq(&dev->config_lock);
> > > > > > -     dev->config_enabled =3D true;
> > > > > > -     if (dev->config_change_pending)
> > > > > > -             __virtio_config_changed(dev);
> > > > > > -     dev->config_change_pending =3D false;
> > > > > > +
> > > > > > +     if (dev->config_enabled < 1) {
> > > > > > +             ++dev->config_enabled;
> > > > > > +             if (dev->config_enabled =3D=3D 1 &&
> > > > > > +                 dev->config_change_pending) {
> > > > > > +                     __virtio_config_changed(dev);
> > > > > > +                     dev->config_change_pending =3D false;
> > > > > > +             }
> > > > > > +     }
> > > > > > +
> > > > > >       spin_unlock_irq(&dev->config_lock);
> > > > > >  }
> > > > > >
> > > > >
> > > > > So every disable decrements the counter. Enable only increments i=
t up to 1.
> > > > > You seem to be making some very specific assumptions
> > > > > about how this API will be used. Any misuse will lead to under/ov=
erflow
> > > > > eventually ...
> > > > >
> > > >
> > > > Well, a counter gives us more information than a boolean. With
> > > > boolean, misuse is even harder to be noticed.
> > >
> > > With boolean we can prevent misuse easily because previous state
> > > is known exactly. E.g.:
> > >
> > > static void virtio_config_driver_disable(struct virtio_device *dev)
> > > {
> > >         BUG_ON(dev->config_driver_disabled);
> > >         dev->config_driver_disabled =3D true;
> > > }
> > >
> > >
> > >
> > > static void virtio_config_driver_enable(struct virtio_device *dev)
> > > {
> > >         BUG_ON(!dev->config_driver_disabled);
> > >         dev->config_driver_disabled =3D false;
> > > }
> > >
> > >
> > > Does not work with integer you simply have no idea what the value
> > > should be at point of call.
> >
> > Yes but I meant if we want the config could be disabled by different
> > parties (core, driver and others)
>
> For now, we don't have others ;)
>
> > >
> > >
> > > > >
> > > > >
> > > > > My suggestion would be to
> > > > > 1. rename config_enabled to config_core_enabled
> > > > > 2. rename virtio_config_enable/disable to virtio_config_core_enab=
le/disable
> > > > > 3. add bool config_driver_disabled and make virtio_config_enable/=
disable
> > > > >    switch that.
> > > > > 4. Change logic from dev->config_enabled to
> > > > >    dev->config_core_enabled && !dev->config_driver_disabled
> > > >
> > > > If we make config_driver_disabled by default true,
> > >
> > > No, we make it false by default.
> > >
> > > > we need someone to
> > > > enable it explicitly. If it's core, it breaks the semantic that it =
is
> > > > under the control of the driver (or needs to synchronize with the
> > > > driver). If it's a driver, each driver needs to enable it at some t=
ime
> > > > which can be easily forgotten. And if we end up with workarounds li=
ke:
> > > >
> > > >         /* If probe didn't do it, mark device DRIVER_OK ourselves. =
*/
> > > >         if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER=
_OK))
> > > >                 virtio_device_ready(dev);
> > > >
> > > > It's another break of the semantics. And actually the above is also=
 racy.
> > > >
> > > > It seems the only choice is to make config_driver_disabled by defau=
lt
> > > > false. But the driver needs to be aware of this and take extra care
> > > > when calling virtio_device_ready() which is also tricky.
> > >
> > >
> > > No, false by default simply means no change to semantics.
> >
> > No change to current semantics, probably. But we need to document
> >
> > 1) driver config is enabled by default
> > 2) no nested enabling and disabling
> >
> > If you think they are all fine, I can go with that way.
>
> yes, a good idea to document this.
>
>

[...]

> > >
> > > We have a simple problem, we can solve it simply. reference counting
> > > is tricky to get right and hard to debug, if we don't need it let us
> > > not go there.
> >
> > I fully agree, and that's why I limit the change to virtio-net driver
> > in the first version.
>
> I got that. I didn't like the code duplication though.
>
> > >
> > >
> > >
> > > But in conclusion ;) if you don't like my suggestion do something els=
e
> > > but make the APIs make sense,
> >
> > I don't say I don't like it:)
> >
> > Limiting it to virtio-net seems to be the most easy way. And if we
> > want to do it in the core, I just want to make nesting to be supported
> > which might not be necessary now.
>
> I feel limiting it to a single driver strikes the right balance ATM.

Just to make sure I understand here, should we go back to v1 or go
with the config_driver_disabled?

Thanks

>
> >
> > > at least do better than +5
> > > on Rusty's interface design scale.
> > >
> > > >
> >
> > Thanks
> >
> >
> > > >
> > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > > @@ -455,7 +461,7 @@ int register_virtio_device(struct virtio_de=
vice *dev)
> > > > > >               goto out_ida_remove;
> > > > > >
> > > > > >       spin_lock_init(&dev->config_lock);
> > > > > > -     dev->config_enabled =3D false;
> > > > > > +     dev->config_enabled =3D 0;
> > > > > >       dev->config_change_pending =3D false;
> > > > > >
> > > > > >       INIT_LIST_HEAD(&dev->vqs);
> > > > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > > > index 96fea920873b..4496f9ba5d82 100644
> > > > > > --- a/include/linux/virtio.h
> > > > > > +++ b/include/linux/virtio.h
> > > > > > @@ -132,7 +132,7 @@ struct virtio_admin_cmd {
> > > > > >  struct virtio_device {
> > > > > >       int index;
> > > > > >       bool failed;
> > > > > > -     bool config_enabled;
> > > > > > +     int config_enabled;
> > > > > >       bool config_change_pending;
> > > > > >       spinlock_t config_lock;
> > > > > >       spinlock_t vqs_list_lock;
> > > > > > --
> > > > > > 2.31.1
> > > > >
> > >
>

