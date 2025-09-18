Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDB92C0270
	for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 06:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758175294; cv=none; b=l6HY+/9RD8jCTIEm38XmqHEkqNzUxRym3ixcld4ZYfeswXCMK3HsOACSQOd/7kZz58ody/KEY4sTjWJjgwJh4cBHehXxOYYuu6X6H0VSMWxjLJ7zRqnHmB6P9agfhNSLTVz9MtEZVn7ysAY/vY79+zXOZKQ+k0KLE0m+KCiwqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758175294; c=relaxed/simple;
	bh=F6PJ5sQuLeWoui3h2IeTIGET/+Tl6Dh4Hqzs4mXntL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSpMruF3sWLS3Ze+dZO1eeSe+xGq1L/1tgC8fGgbS9aaeqaPyFnSRCZKjYo4isxvY+UtGWv/O534Fg8P2x5Kq8SVxQV3sjVSYLE6BrZdJIi0Rv3emAuqAnJlzJP+siI7UjYlnZobxaXkgfX6LJbftzIOSPLrEqr4yePozcQDlOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OBCzH7zM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBCzH7zM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758175291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IzuE/sVEIP49GyPLtIFMnoeSvzxhUD8lfSAmKMWlyxA=;
	b=OBCzH7zMIgyiHwtChKgHgmehJJhZyGYQVvvqBiB2Q5fQXPEHGHsAkiYcMuolXN9QwqQmCv
	bjudAxVT9+ZtF+tpc+xLUsAczmErJfOYaCb28ojMQOUkI7LlDSoah7FTAddJSqQ5uohmgE
	hyBSKILII260dX4AUmfJ7GwvLGQEEFI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-TL8kvq8wP9mxYg6kZx7qiw-1; Thu, 18 Sep 2025 02:01:27 -0400
X-MC-Unique: TL8kvq8wP9mxYg6kZx7qiw-1
X-Mimecast-MFC-AGG-ID: TL8kvq8wP9mxYg6kZx7qiw_1758175286
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32e8c800a79so704296a91.0
        for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 23:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758175286; x=1758780086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzuE/sVEIP49GyPLtIFMnoeSvzxhUD8lfSAmKMWlyxA=;
        b=hYwa8jl7Xov+6CPgD4tOgofeGqE69jDCjoGSR19ogrsT9Wjlq2spMvnEh7Qeu7wcD2
         q7AqpnvCVJJ0hMCWlMXRkl9mfq1lHBmSy4fMmKe/Izc8Mul8pSuFyppxIwZbuRTQisrg
         uGXcUZ7RqkDz+uOULELVXuDJaKRLUFAZPhEixk95fA83DQXrwMv40Ddg7xK+K7hc/8lN
         DGP4SbABpo6lYgamT6ZhNLDo+g3Q0G/BUUweZDIcl27t1qujcy5Cb22HqyBTQzrJspR6
         47Q2Lzd42XMZDfdtvxqvmWa6IfnNmJrzZ56yP3IbOLXpQO/2Fil0gq4IqnEy1wi/w1HI
         o27A==
X-Forwarded-Encrypted: i=1; AJvYcCVee3IDZNDno1OxEMgHdN3IbDts6rhEcVVHmmXTtoFSo3uUd0MunZip+uP8nskOTcX6myrZd1FP5bgTmvVttA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQXf4zQoqP6rb/RUkPVm7+taR0BqpIn3f0PZBDTkxIexGj4aYd
	/qio81+1S/iUwfGzb0urGIFu2c9lkDUBzW7UMDDLoRCF3Aa6bYfiFk791+4GDB18BYsRLogA7QE
	5PjejP8eaGvhkhebqwu/+8QLISfxc6J/1P8nRRTmZfa7XEcQzDDE0NO7rbLtRauG2fTAh1QIboJ
	GgcshNzbN33p7gCw2L6ZJqa8G+8sQZoJBjRbgYLoLfYDA=
X-Gm-Gg: ASbGnctytM7OuWe59bHK9M82BzailW22XLBx+Z0nP2gMvCh3pHi7l6/vo/tV3AZxNaj
	iYRxh9vTYn+q4UFytLEY1zjwxJpDKnXJNJ4WbtZ8pl5jqR+FJhQbOP+0MhYRG5UKucvvii1SY3V
	KiSVutYEdcTmpmZGAMNOzKrQ==
X-Received: by 2002:a17:90a:d605:b0:32d:dc3e:559a with SMTP id 98e67ed59e1d1-32ee3efdfc9mr5581734a91.10.1758175286287;
        Wed, 17 Sep 2025 23:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfmJKCoA5y7MoRr4bYSaS8CiHLpFq0iE4EPRNFATTud9bsTx5aFhmChJlICDrZYsKveR/4ce5Y13Wk4tvBAZg=
X-Received: by 2002:a17:90a:d605:b0:32d:dc3e:559a with SMTP id
 98e67ed59e1d1-32ee3efdfc9mr5581702a91.10.1758175285879; Wed, 17 Sep 2025
 23:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-5-eperezma@redhat.com>
 <CACGkMEuY359QtVeTY40Z_L1zhG87rB2te=qc7YM6gZxcKM=m7w@mail.gmail.com> <CAJaqyWfkpxmFXafRnxvP1Wjd3=uBaSr_m05BCpDYB4e7XR9diQ@mail.gmail.com>
In-Reply-To: <CAJaqyWfkpxmFXafRnxvP1Wjd3=uBaSr_m05BCpDYB4e7XR9diQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Sep 2025 14:01:14 +0800
X-Gm-Features: AS18NWBLzBcRmksoMvZDbU4LLioMJtZOsvqhhZPcF9nUwwqwEpDd82qsByN5YAI
Message-ID: <CACGkMEto2vc3rYO7aKJvqgRFE6QFDrtxRbHhXrVb=91vvqJ9=w@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] vduse: return internal vq group struct as map token
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JcFneUlFaWrdiTTtff84Gcop_6JvaYolrSTvqNDjM7s_1758175286
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:17=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Sep 17, 2025 at 10:37=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Tue, Sep 16, 2025 at 9:09=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Return the internal struct that represents the vq group as virtqueue =
map
> > > token, instead of the device.  This allows the map functions to acces=
s
> > > the information per group.
> > >
> > > At this moment all the virtqueues share the same vq group, that only
> > > can point to ASID 0.  This change prepares the infrastructure for act=
ual
> > > per-group address space handling
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > RFC v3:
> > > * Make the vq groups a dynamic array to support an arbitrary number o=
f
> > >   them.
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 52 ++++++++++++++++++++++++----=
--
> > >  include/linux/virtio.h             |  6 ++--
> > >  2 files changed, 46 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 42f8807911d4..9c12ae72abc2 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -23,6 +23,7 @@
> > >  #include <linux/uio.h>
> > >  #include <linux/vdpa.h>
> > >  #include <linux/nospec.h>
> > > +#include <linux/virtio.h>
> > >  #include <linux/vmalloc.h>
> > >  #include <linux/sched/mm.h>
> > >  #include <uapi/linux/vduse.h>
> > > @@ -85,6 +86,10 @@ struct vduse_umem {
> > >         struct mm_struct *mm;
> > >  };
> > >
> > > +struct vduse_vq_group_int {
> > > +       struct vduse_dev *dev;
> > > +};
> >
> > I remember we had some discussion over this, and the conclusion is to
> > have a better name.
> >
> > Maybe just vduse_vq_group?
> >
>
> Good catch, I also hate the _int suffix :). vduse_vq_group was used in
> the vduse uapi in previous series, but now there is no reason for it.
> Replacing it, thanks!
>
> > And to be conceptually correct, we need to use iova_domain here
> > instead of the vduse_dev. More below.
> >
> > > +
> > >  struct vduse_dev {
> > >         struct vduse_vdpa *vdev;
> > >         struct device *dev;
> > > @@ -118,6 +123,7 @@ struct vduse_dev {
> > >         u32 vq_align;
> > >         u32 ngroups;
> > >         struct vduse_umem *umem;
> > > +       struct vduse_vq_group_int *groups;
> > >         struct mutex mem_lock;
> > >         unsigned int bounce_size;
> > >         rwlock_t domain_lock;
> > > @@ -602,6 +608,15 @@ static u32 vduse_get_vq_group(struct vdpa_device=
 *vdpa, u16 idx)
> > >         return dev->vqs[idx]->vq_group;
> > >  }
> > >
> > > +static union virtio_map vduse_get_vq_map(struct vdpa_device *vdpa, u=
16 idx)
> > > +{
> > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > +       u32 vq_group =3D dev->vqs[idx]->vq_group;
> > > +       union virtio_map ret =3D { .group =3D &dev->groups[vq_group] =
};
> > > +
> > > +       return ret;
> > > +}
> > > +
> > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx=
,
> > >                                 struct vdpa_vq_state *state)
> > >  {
> > > @@ -822,6 +837,7 @@ static const struct vdpa_config_ops vduse_vdpa_co=
nfig_ops =3D {
> > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > >         .reset                  =3D vduse_vdpa_reset,
> > >         .set_map                =3D vduse_vdpa_set_map,
> > > +       .get_vq_map             =3D vduse_get_vq_map,
> > >         .free                   =3D vduse_vdpa_free,
> > >  };
> > >
> > > @@ -829,7 +845,8 @@ static void vduse_dev_sync_single_for_device(unio=
n virtio_map token,
> > >                                              dma_addr_t dma_addr, siz=
e_t size,
> > >                                              enum dma_data_direction =
dir)
> > >  {
> > > -       struct vduse_iova_domain *domain =3D token.iova_domain;
> > > +       struct vduse_dev *vdev =3D token.group->dev;
> > > +       struct vduse_iova_domain *domain =3D vdev->domain;
> >
> > If we really want to do this, we need to move the iova_domian into the =
group.
> >
>
> It's done in patches on top to make each patch smaller. This patch is
> focused on just changing the type of the union. Would you prefer me to
> reorder the patches so that part is done earlier?

I think it would be better for logical completeness.

Thanks

