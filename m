Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB983A1A1
	for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710926590; cv=none; b=J82ygfoUWwqIUUXD2YEys1trW/lREeE1L/4xwkAY+RexVF6kncIgnpK81HDQwLzNy7tmz1RMzVM2PVTq+Y0DI6QZgzIHO3ILUlvgBoN7JImWDHONL7HqILyuIxbw2zZcDyV411vEIp/wgrENoH2e6DB4yVlE1fNsetLxWLV7yZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710926590; c=relaxed/simple;
	bh=9shQ/eAmTaQK6Q7YTowaKS9ym+5bwIiLd/mi5mRa/SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/3hp9HPuI42hR2v3Bt+ezNAWrQ3nSPbVAo6MwewTZHgh9XB+mg7FxPCrgtz9esxzKljWigtCU209kasxT0wy6IzVkpwb2lkeh4lpz9nXJxL/loAhRVarbBakdpg8qgBDqxBwpx6Dpd7jNQGI7ev+1s0JOM/1nDAFpxSp8ciXe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9VpXiYD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9VpXiYD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710926587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Vjg8zrCnFg/tqbys7l4j13t+oLp9giExjkF7oHtAuI=;
	b=S9VpXiYDXNGfSGd2fBdjy0ivSsW7vNu6jTsSsZKbJTWYyCYzvCs3TX9uaDQXJHnkycHrae
	Fc5pwVlZjwG2Nl/v6Xz/9s/iIQ9dskgIDyXajLGwKUYd7qfaa2X3BBuyk0AWpddm0VNmLn
	8Z4PAVnilzIegk4ZWiXpcy9Ui9Gkn/k=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-YeCRW-zZM7uXTN1Srv-SvA-1; Wed, 20 Mar 2024 05:23:02 -0400
X-MC-Unique: YeCRW-zZM7uXTN1Srv-SvA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29905ac5c21so4957186a91.0
        for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 02:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710926582; x=1711531382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Vjg8zrCnFg/tqbys7l4j13t+oLp9giExjkF7oHtAuI=;
        b=fGZU8IOXUNMg+cw4bOHzQs5MBSlj+fHtTfv/tivYh3f6h35yzvNdq011dINy/1w/UI
         G/3EhtfTj3hGFHImbu48G31QggwAb73O0ga2EgvWztFCyWOSH1Xw8xxhYGRxwrW5ZTkY
         0zHuVw6JPLwDYsn3sCTPT8vM9i5V+IVv2xnY4y1W67ALqRaKF0IQQV8ISKUqZSAlujHw
         jCZkcU6n5D1QhB+JSlJL7o3Z14b85HXb3ATQAYKIm4q9QtkW5Ant74aL1sWy9q0RhXZ7
         tvoYAbbKv3NixO6bo6RlULhfpq/CMAYQz9JdbI+NVg56zMReE7199EYDetRkhllWPSju
         IQLg==
X-Forwarded-Encrypted: i=1; AJvYcCU3wCBPrBZAsFjct6bN6kWwMPtkfKmw5PUwrsuVsr7DEjg5mXTUrEyws511Vdb+d3cj0OLDoy2cXsxrJv/MECQbqaOop6VxJXo3+SQULnM=
X-Gm-Message-State: AOJu0YxWBlvFTk6RIAN/DGQsk5Jt0pv2J9KlxPIBA36f6eirgHShMQkS
	oJ95aghs2Egq/uBHrerWnRUwEF5y46x2NJjRfcJfKVEFEEgsBzExAGLSJ+h3LRdlY/vWCTZifSS
	g4KcnRrJvUD1um/isDlraf9i5RxYQ2HwDUByt0/iIMXLFdcITt9BRcdCqCqahzBtOv+gcxdwyMU
	8L5d8L7YtO3KYX8fFarO1PUg5FkJLT6WD9+Uy2hC4=
X-Received: by 2002:a17:90b:3649:b0:29e:926:b582 with SMTP id nh9-20020a17090b364900b0029e0926b582mr10780649pjb.23.1710926581647;
        Wed, 20 Mar 2024 02:23:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa5t5yKeGVgUBrB/m7ZYinl2zOV2h69MtzYov0EG5AwEvBxWiWBFcij6dKejn6wI3bBgvnbbPLiFiqn5O6R+A=
X-Received: by 2002:a17:90b:3649:b0:29e:926:b582 with SMTP id
 nh9-20020a17090b364900b0029e0926b582mr10780641pjb.23.1710926581319; Wed, 20
 Mar 2024 02:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240312021013.88656-1-xuanzhuo@linux.alibaba.com>
 <20240312021013.88656-2-xuanzhuo@linux.alibaba.com> <CACGkMEvVgfgAxLoKeFTgy-1GR0W07ciPYFuqs6PiWtKCnXuWTw@mail.gmail.com>
 <1710395908.7915084-1-xuanzhuo@linux.alibaba.com> <CACGkMEsT2JqJ1r_kStUzW0+-f+qT0C05n2A+Yrjpc-mHMZD_mQ@mail.gmail.com>
 <1710487245.6843069-1-xuanzhuo@linux.alibaba.com> <CACGkMEspzDTZP1yxkBz17MgU9meyfCUBDxG8mjm=acXHNxAxhg@mail.gmail.com>
 <1710741592.205804-1-xuanzhuo@linux.alibaba.com> <20240319025726-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240319025726-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Mar 2024 17:22:50 +0800
Message-ID: <CACGkMEsO6e2=v36F=ezhHCEaXqG0+AhkCM2ZgmKAtyWncnif5Q@mail.gmail.com>
Subject: Re: [PATCH vhost v3 1/4] virtio: find_vqs: pass struct instead of
 multi parameters
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 2:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Mar 18, 2024 at 01:59:52PM +0800, Xuan Zhuo wrote:
> > On Mon, 18 Mar 2024 12:18:23 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Fri, Mar 15, 2024 at 3:26=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Fri, 15 Mar 2024 11:51:48 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Thu, Mar 14, 2024 at 2:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > On Thu, 14 Mar 2024 11:12:24 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Tue, Mar 12, 2024 at 10:10=E2=80=AFAM Xuan Zhuo <xuanzhuo@=
linux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > Now, we pass multi parameters to find_vqs. These parameters
> > > > > > > > may work for transport or work for vring.
> > > > > > > >
> > > > > > > > And find_vqs has multi implements in many places:
> > > > > > > >
> > > > > > > >  arch/um/drivers/virtio_uml.c
> > > > > > > >  drivers/platform/mellanox/mlxbf-tmfifo.c
> > > > > > > >  drivers/remoteproc/remoteproc_virtio.c
> > > > > > > >  drivers/s390/virtio/virtio_ccw.c
> > > > > > > >  drivers/virtio/virtio_mmio.c
> > > > > > > >  drivers/virtio/virtio_pci_legacy.c
> > > > > > > >  drivers/virtio/virtio_pci_modern.c
> > > > > > > >  drivers/virtio/virtio_vdpa.c
> > > > > > > >
> > > > > > > > Every time, we try to add a new parameter, that is difficul=
t.
> > > > > > > > We must change every find_vqs implement.
> > > > > > > >
> > > > > > > > One the other side, if we want to pass a parameter to vring=
,
> > > > > > > > we must change the call path from transport to vring.
> > > > > > > > Too many functions need to be changed.
> > > > > > > >
> > > > > > > > So it is time to refactor the find_vqs. We pass a structure
> > > > > > > > cfg to find_vqs(), that will be passed to vring by transpor=
t.
> > > > > > > >
> > > > > > > > Because the vp_modern_create_avq() use the "const char *nam=
es[]",
> > > > > > > > and the virtio_uml.c changes the name in the subsequent com=
mit, so
> > > > > > > > change the "names" inside the virtio_vq_config from "const =
char *const
> > > > > > > > *names" to "const char **names".
> > > > > > > >
> > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > Acked-by: Johannes Berg <johannes@sipsolutions.net>
> > > > > > > > Reviewed-by: Ilpo J=3DE4rvinen <ilpo.jarvinen@linux.intel.c=
om>
> > > > > > >
> > > > > > > The name seems broken here.
> > > > > >
> > > > > > Email APP bug.
> > > > > >
> > > > > > I will fix.
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > [...]
> > > > > > >
> > > > > > > >
> > > > > > > >  typedef void vq_callback_t(struct virtqueue *);
> > > > > > > >
> > > > > > > > +/**
> > > > > > > > + * struct virtio_vq_config - configure for find_vqs()
> > > > > > > > + * @cfg_idx: Used by virtio core. The drivers should set t=
his to 0.
> > > > > > > > + *     During the initialization of each vq(vring setup), =
we need to know which
> > > > > > > > + *     item in the array should be used at that time. But =
since the item in
> > > > > > > > + *     names can be null, which causes some item of array =
to be skipped, we
> > > > > > > > + *     cannot use vq.index as the current id. So add a cfg=
_idx to let vring
> > > > > > > > + *     know how to get the current configuration from the =
array when
> > > > > > > > + *     initializing vq.
> > > > > > >
> > > > > > > So this design is not good. If it is not something that the d=
river
> > > > > > > needs to care about, the core needs to hide it from the API.
> > > > > >
> > > > > > The driver just ignore it. That will be beneficial to the virti=
o core.
> > > > > > Otherwise, we must pass one more parameter everywhere.
> > > > >
> > > > > I don't get here, it's an internal logic and we've already done t=
hat.
> > > >
> > > >
> > > > ## Then these must add one param "cfg_idx";
> > > >
> > > >  struct virtqueue *vring_create_virtqueue(struct virtio_device *vde=
v,
> > > >                                          unsigned int index,
> > > >                                          struct vq_transport_config=
 *tp_cfg,
> > > >                                          struct virtio_vq_config *c=
fg,
> > > > -->                                      uint cfg_idx);
> > > >
> > > >  struct virtqueue *vring_new_virtqueue(struct virtio_device *vdev,
> > > >                                       unsigned int index,
> > > >                                       void *pages,
> > > >                                       struct vq_transport_config *t=
p_cfg,
> > > >                                       struct virtio_vq_config *cfg,
> > > > -->                                      uint cfg_idx);
> > > >
> > > >
> > > > ## The functions inside virtio_ring also need to add a new param, s=
uch as:
> > > >
> > > >  static struct virtqueue *vring_create_virtqueue_split(struct virti=
o_device *vdev,
> > > >                                                       unsigned int =
index,
> > > >                                                       struct vq_tra=
nsport_config *tp_cfg,
> > > >                                                       struct virtio=
_vq_config,
> > > > -->                                                   uint cfg_idx)=
;
> > > >
> > > >
> > > >
> > >
> > > I guess what I'm missing is when could the index differ from cfg_idx?
> >
> >
> >  @cfg_idx: Used by virtio core. The drivers should set this to 0.
> >      During the initialization of each vq(vring setup), we need to know=
 which
> >      item in the array should be used at that time. But since the item =
in
> >      names can be null, which causes some item of array to be skipped, =
we
> >      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >      cannot use vq.index as the current id. So add a cfg_idx to let vri=
ng
> >      know how to get the current configuration from the array when
> >      initializing vq.
> >
> >
> > static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nv=
qs,
> >
> >       ................
> >
> >       for (i =3D 0; i < nvqs; ++i) {
> >               if (!names[i]) {
> >                       vqs[i] =3D NULL;
> >                       continue;
> >               }
> >
> >               if (!callbacks[i])
> >                       msix_vec =3D VIRTIO_MSI_NO_VECTOR;
> >               else if (vp_dev->per_vq_vectors)
> >                       msix_vec =3D allocated_vectors++;
> >               else
> >                       msix_vec =3D VP_MSIX_VQ_VECTOR;
> >               vqs[i] =3D vp_setup_vq(vdev, queue_idx++, callbacks[i], n=
ames[i],
> >                                    ctx ? ctx[i] : false,
> >                                    msix_vec);
> >
> >
> > Thanks.
>
>
> Jason what do you think is the way to resolve this?

I wonder which driver doesn't use a specific virtqueue in this case.

And it looks to me, introducing a per-vq-config struct might be better
then we have

virtio_vqs_config {
      unsigned int nvqs;
      struct virtio_vq_config *configs;
}

So we don't need the cfg_idx stuff.

Thanks

>
> > >
> > > Thanks
> > >
> > > > Thanks.
> > > >
> > > >
> > > >
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
>

