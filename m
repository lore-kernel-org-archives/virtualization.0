Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689A8B651
	for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 04:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710993836; cv=none; b=IpZVwTcmq/4gODYyFtQ9R+wzUxnnM7g2kztRdTza4X9azJDg1JySfOBKgi4eI3Mc/Yez5QjV9NEKWF9anVNmT57J1J+2S6rr/0lUb9Oke577ZqmyuFVhYK2CIkJ5g6iwFeqPO4xLS6um1KFyyZYE3YjMl2pj8Dwb/jTZU6cOizY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710993836; c=relaxed/simple;
	bh=lAy7VDrmZYpvyY5thHQUC2bB1d0AmuO/N79m5Qw6qj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRGutpXICj2r6gm1WmxDNU5a115256hJFz0dNf5zWIrrwSwR2FskfhkuTtx2RdajBieTMgx2Y81r3Ibor9L7t5jxOdJbtxya8MUNhxLc0ebLMz95+NCP8FjArEYXFjeLFyefPVo+oN3FOpZV1x0CxBYvWBxC8l++HwGBCAGhOXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bVjnTDMz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVjnTDMz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710993832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XSb9h5JldUrmGAaQN8eAT8gnitrkJjZYtDIfBtTZ+h4=;
	b=bVjnTDMz2aqGQj4Rr4CCuD499k9gm+U0H2w5Z4ZRZf7A654AyFCqkVIDLOHa3+UzOfu/Pf
	IkJyhaf8Z9XVOTUjRn4yGnJrdKW90/mOZyna56rh8giFdO/fTalUUe1qvEgwgK2j9QlCy3
	Q5tHHPNp0oRvyKOMzerVVEvH6pTA6ho=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-LUU2lN73MmGzLJQqHS3bAQ-1; Thu, 21 Mar 2024 00:03:50 -0400
X-MC-Unique: LUU2lN73MmGzLJQqHS3bAQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5cdfd47de98so398315a12.1
        for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 21:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710993829; x=1711598629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSb9h5JldUrmGAaQN8eAT8gnitrkJjZYtDIfBtTZ+h4=;
        b=pJuxt8nSfceH8MkuCddDhwBVQedyZcxMwOx7UhtW3u1C2mZvyI8xNOpLMKK1+11GQu
         8OOTYwHtGEHLDhOJIIIpGJ7si7dJX1H7a9B4gb5nxpLkz47uMQ5rhefPWQIQ7uNiggod
         8zfQvA7EUwi/FL+OyP/bEaCiuh8XJkltQkrF8qDW920A/8kBXPEzrQynHJT2OKTc/vYO
         MSkuZkN2eW8vYk6tFOMg97ceLDqqqSq/oU4nGgP7W8Iz/HB3SxD3gRWahDeSbcRBV0oN
         ZZiCzY42u9eJRq0iQEDOCAZYdebQd1A/wHzDycBlOSLv45iW0cvXGIsvU2iRfx4two22
         XfwA==
X-Gm-Message-State: AOJu0YxafM48O8ZeACt6YYjiouOkVhU7rVMPsCmwiHjWbzLA6BVzyTq6
	S8eRdikN0Gp/4uIxTDFnj4C1rIV5NLEK3E/uvO3CxNfK/L8ht2gGX1R7y38550KXcUkmw2Jb0Ee
	LXFLUoJmf09BL4nM4/a/G4ubH8cZ1G2vhJejBLH2rj70RqIwiTU0fdy/X+F7MTFUYk9aAlDt2k9
	6r/jhU0sAigZAmKfGu1fNzcFWJ3f2857VaHTlSPTI=
X-Received: by 2002:a17:90b:4b4d:b0:29e:7f4:868f with SMTP id mi13-20020a17090b4b4d00b0029e07f4868fmr13632606pjb.18.1710993829667;
        Wed, 20 Mar 2024 21:03:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF/nEjygsHaklkexL75vFby99iU5hs23lZKo480O+Mh9fe6VkolA3Rr8Qn6tQNxBMCVWFlT5mdniPWyFUXX14=
X-Received: by 2002:a17:90b:4b4d:b0:29e:7f4:868f with SMTP id
 mi13-20020a17090b4b4d00b0029e07f4868fmr13632580pjb.18.1710993829329; Wed, 20
 Mar 2024 21:03:49 -0700 (PDT)
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
 <CACGkMEsO6e2=v36F=ezhHCEaXqG0+AhkCM2ZgmKAtyWncnif5Q@mail.gmail.com> <1710927569.5383172-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1710927569.5383172-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Mar 2024 12:03:36 +0800
Message-ID: <CACGkMEuEqiLLGj-HY=gx4R1EVh_d=eYrmi=cuLzb1SiqiEHb-A@mail.gmail.com>
Subject: Re: [PATCH vhost v3 1/4] virtio: find_vqs: pass struct instead of
 multi parameters
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 5:41=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 20 Mar 2024 17:22:50 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Mar 19, 2024 at 2:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Mar 18, 2024 at 01:59:52PM +0800, Xuan Zhuo wrote:
> > > > On Mon, 18 Mar 2024 12:18:23 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Fri, Mar 15, 2024 at 3:26=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > On Fri, 15 Mar 2024 11:51:48 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Thu, Mar 14, 2024 at 2:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@l=
inux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, 14 Mar 2024 11:12:24 +0800, Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > > > > On Tue, Mar 12, 2024 at 10:10=E2=80=AFAM Xuan Zhuo <xuanz=
huo@linux.alibaba.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Now, we pass multi parameters to find_vqs. These parame=
ters
> > > > > > > > > > may work for transport or work for vring.
> > > > > > > > > >
> > > > > > > > > > And find_vqs has multi implements in many places:
> > > > > > > > > >
> > > > > > > > > >  arch/um/drivers/virtio_uml.c
> > > > > > > > > >  drivers/platform/mellanox/mlxbf-tmfifo.c
> > > > > > > > > >  drivers/remoteproc/remoteproc_virtio.c
> > > > > > > > > >  drivers/s390/virtio/virtio_ccw.c
> > > > > > > > > >  drivers/virtio/virtio_mmio.c
> > > > > > > > > >  drivers/virtio/virtio_pci_legacy.c
> > > > > > > > > >  drivers/virtio/virtio_pci_modern.c
> > > > > > > > > >  drivers/virtio/virtio_vdpa.c
> > > > > > > > > >
> > > > > > > > > > Every time, we try to add a new parameter, that is diff=
icult.
> > > > > > > > > > We must change every find_vqs implement.
> > > > > > > > > >
> > > > > > > > > > One the other side, if we want to pass a parameter to v=
ring,
> > > > > > > > > > we must change the call path from transport to vring.
> > > > > > > > > > Too many functions need to be changed.
> > > > > > > > > >
> > > > > > > > > > So it is time to refactor the find_vqs. We pass a struc=
ture
> > > > > > > > > > cfg to find_vqs(), that will be passed to vring by tran=
sport.
> > > > > > > > > >
> > > > > > > > > > Because the vp_modern_create_avq() use the "const char =
*names[]",
> > > > > > > > > > and the virtio_uml.c changes the name in the subsequent=
 commit, so
> > > > > > > > > > change the "names" inside the virtio_vq_config from "co=
nst char *const
> > > > > > > > > > *names" to "const char **names".
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > > Acked-by: Johannes Berg <johannes@sipsolutions.net>
> > > > > > > > > > Reviewed-by: Ilpo J=3DE4rvinen <ilpo.jarvinen@linux.int=
el.com>
> > > > > > > > >
> > > > > > > > > The name seems broken here.
> > > > > > > >
> > > > > > > > Email APP bug.
> > > > > > > >
> > > > > > > > I will fix.
> > > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > [...]
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >  typedef void vq_callback_t(struct virtqueue *);
> > > > > > > > > >
> > > > > > > > > > +/**
> > > > > > > > > > + * struct virtio_vq_config - configure for find_vqs()
> > > > > > > > > > + * @cfg_idx: Used by virtio core. The drivers should s=
et this to 0.
> > > > > > > > > > + *     During the initialization of each vq(vring setu=
p), we need to know which
> > > > > > > > > > + *     item in the array should be used at that time. =
But since the item in
> > > > > > > > > > + *     names can be null, which causes some item of ar=
ray to be skipped, we
> > > > > > > > > > + *     cannot use vq.index as the current id. So add a=
 cfg_idx to let vring
> > > > > > > > > > + *     know how to get the current configuration from =
the array when
> > > > > > > > > > + *     initializing vq.
> > > > > > > > >
> > > > > > > > > So this design is not good. If it is not something that t=
he driver
> > > > > > > > > needs to care about, the core needs to hide it from the A=
PI.
> > > > > > > >
> > > > > > > > The driver just ignore it. That will be beneficial to the v=
irtio core.
> > > > > > > > Otherwise, we must pass one more parameter everywhere.
> > > > > > >
> > > > > > > I don't get here, it's an internal logic and we've already do=
ne that.
> > > > > >
> > > > > >
> > > > > > ## Then these must add one param "cfg_idx";
> > > > > >
> > > > > >  struct virtqueue *vring_create_virtqueue(struct virtio_device =
*vdev,
> > > > > >                                          unsigned int index,
> > > > > >                                          struct vq_transport_co=
nfig *tp_cfg,
> > > > > >                                          struct virtio_vq_confi=
g *cfg,
> > > > > > -->                                      uint cfg_idx);
> > > > > >
> > > > > >  struct virtqueue *vring_new_virtqueue(struct virtio_device *vd=
ev,
> > > > > >                                       unsigned int index,
> > > > > >                                       void *pages,
> > > > > >                                       struct vq_transport_confi=
g *tp_cfg,
> > > > > >                                       struct virtio_vq_config *=
cfg,
> > > > > > -->                                      uint cfg_idx);
> > > > > >
> > > > > >
> > > > > > ## The functions inside virtio_ring also need to add a new para=
m, such as:
> > > > > >
> > > > > >  static struct virtqueue *vring_create_virtqueue_split(struct v=
irtio_device *vdev,
> > > > > >                                                       unsigned =
int index,
> > > > > >                                                       struct vq=
_transport_config *tp_cfg,
> > > > > >                                                       struct vi=
rtio_vq_config,
> > > > > > -->                                                   uint cfg_=
idx);
> > > > > >
> > > > > >
> > > > > >
> > > > >
> > > > > I guess what I'm missing is when could the index differ from cfg_=
idx?
> > > >
> > > >
> > > >  @cfg_idx: Used by virtio core. The drivers should set this to 0.
> > > >      During the initialization of each vq(vring setup), we need to =
know which
> > > >      item in the array should be used at that time. But since the i=
tem in
> > > >      names can be null, which causes some item of array to be skipp=
ed, we
> > > >      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^
> > > >      cannot use vq.index as the current id. So add a cfg_idx to let=
 vring
> > > >      know how to get the current configuration from the array when
> > > >      initializing vq.
> > > >
> > > >
> > > > static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned in=
t nvqs,
> > > >
> > > >       ................
> > > >
> > > >       for (i =3D 0; i < nvqs; ++i) {
> > > >               if (!names[i]) {
> > > >                       vqs[i] =3D NULL;
> > > >                       continue;
> > > >               }
> > > >
> > > >               if (!callbacks[i])
> > > >                       msix_vec =3D VIRTIO_MSI_NO_VECTOR;
> > > >               else if (vp_dev->per_vq_vectors)
> > > >                       msix_vec =3D allocated_vectors++;
> > > >               else
> > > >                       msix_vec =3D VP_MSIX_VQ_VECTOR;
> > > >               vqs[i] =3D vp_setup_vq(vdev, queue_idx++, callbacks[i=
], names[i],
> > > >                                    ctx ? ctx[i] : false,
> > > >                                    msix_vec);
> > > >
> > > >
> > > > Thanks.
> > >
> > >
> > > Jason what do you think is the way to resolve this?
> >
> > I wonder which driver doesn't use a specific virtqueue in this case.
>
>
> commit 6457f126c888b3481fdae6f702e616cd0c79646e
> Author: Michael S. Tsirkin <mst@redhat.com>
> Date:   Wed Sep 5 21:47:45 2012 +0300
>
>     virtio: support reserved vqs
>
>     virtio network device multiqueue support reserves
>     vq 3 for future use (useful both for future extensions and to make it
>     pretty - this way receive vqs have even and transmit - odd numbers).
>     Make it possible to skip initialization for
>     specific vq numbers by specifying NULL for name.
>     Document this usage as well as (existing) NULL callback.
>
>     Drivers using this not coded up yet, so I simply tested
>     with virtio-pci and verified that this patch does
>     not break existing drivers.
>
>     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>     Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>
> This patch introduced this.
>
> Could we remove this? Then we can use the vq.index directly. That will
> be great.
>
> >
> > And it looks to me, introducing a per-vq-config struct might be better
> > then we have
> >
> > virtio_vqs_config {
> >       unsigned int nvqs;
> >       struct virtio_vq_config *configs;
> > }
>
> YES. I prefer this. But we need to refactor every driver.

Yes.

>
> >
> > So we don't need the cfg_idx stuff.
>
> This still needs cfg_idx.

Drive needs to pass config for each virtqueue. We can still check
config->name so the virtqueue index could be used.

Thanks

>
> Thanks
>
>
> >
> > Thanks
> >
> > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > > Thanks.
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > >
> >
>

