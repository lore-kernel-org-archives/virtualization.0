Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7D33E7
	for <virtualization@lists.linux.dev>; Wed,  3 Sep 2025 03:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756871826; cv=none; b=hrM5Upeyvq9MtKQ5ZIo6qy1exwZfTK7RPL+lnf9BDzBQzRIT9KfVsK2U2M1z4ZoLimt4U10i1Lx/fJknvF4JCyX4eYP9xvKleEsh8k8lygrncDi1QoCF/PyjRKIeR7L8UQEYnMMJP61qTfEO4D6ETCoUhToANYBnpaXU2qIJ88I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756871826; c=relaxed/simple;
	bh=wMBjT1HB+TlojxMMIMogCsOCkdDO27c+CaBI7nhJbsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgcRYAsYqo5mMwahOMslFgGbG7aPi1f/p2GKqth/Zy2/mipqBXVwJZLNeqJm1Vi4UhH5SZKC10SCXThMjTq8H9plRaZLfW7Fxo4eLJOu5dAXSxGDAayesDjhWdnVutfwB0K455T7ljVY1/tTk+XUDQfV9+xkZu3OjL4DpI3YNi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AcTiqL2S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcTiqL2S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756871821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sAPdF61V/YdtwO0zStjUzTkMuHO4mfqaI+bakqF7GKQ=;
	b=AcTiqL2S7djnn8Dq7FgO4WVfe6ymrC86d/GbFwzkM4cZ9dUKhV26ThPo3IVoVizheC55XT
	ixK1OSq6JG1ahLrcGH/AEdDbc5xV4zAFcWy+OfXMvhHCqD9thW+Pc8gM9etnXB78mONdmp
	yEbUL9C/AXV3IyoKPaUSO5rHh+Tk2+U=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-0m3y5NudOLWB62aqE7Yjcg-1; Tue, 02 Sep 2025 23:57:00 -0400
X-MC-Unique: 0m3y5NudOLWB62aqE7Yjcg-1
X-Mimecast-MFC-AGG-ID: 0m3y5NudOLWB62aqE7Yjcg_1756871819
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-244581ce13aso119147335ad.2
        for <virtualization@lists.linux.dev>; Tue, 02 Sep 2025 20:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756871819; x=1757476619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAPdF61V/YdtwO0zStjUzTkMuHO4mfqaI+bakqF7GKQ=;
        b=rwUkNYlhpwXWWLqyaPBG+jUcN/wNEthsEvTIU3OSEHJGX7g3Plb9BRKMRuoHr1DDfl
         n1He3YnQ339xjoCKNqsUrO46rogFXjavM9U7KAbiti3aLlSALrP1VQDoojiXT8WOO3hm
         Qe3CPk/kv86GT3fXBF/e2tbl04LMu88PT45a7aY9ucpGStY4oR5JBgg9EfBzWe1KHad0
         SPJA1MR+9Xt0AEGSyTh5WWvOZnbyUNBT9hUB4PV3v3ceZTTpVKSH6cEFqQ+ZFRXAr7YG
         v8kFs6gpHOMO+iRVKDsQvns2ZPy81Yl0wHQnbUQN490gvBAv4W2+msBtKHR2uWUrSV6C
         5JhA==
X-Forwarded-Encrypted: i=1; AJvYcCWzJd172fROr/N3aeTnEq7s5/YYsv0VIbWI2xjGbp1/5xbGj3DVkFcE7PzsJtSJteV140hledOuzJ9Zqfnr2g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyj9K5g5FQnAkduLVKADVG9u7Uw1fmU1kTiL6o0+WczTcuC+hBQ
	iukM6Nj5EkPDoXkxP2TWRvKRSliNgVcTAAoGctbEQccvbUPlcXlw2BIumN89R63kNW3K3wx2gv7
	yQvjvJsrcKCkvu+PwqhdEHV1nj6FLTopuU/jeniEPKZMizCcCZuAjVXgLfpG/df8Zx1AVTn2N7t
	nqb/eusPgl7Y0mY/xlmNejkTDSiR3v+JcqSIvnEXpvkpg=
X-Gm-Gg: ASbGncvXDXW8TCu4iVKCmGk2B/JRtursvsXrjrBPAUD65zY7hSyQDhHG90e+fSJymVw
	InQb+pPC+SktzdZmGRMRrsOh0n32SN41mIOMkeoeBvtB4dmAzmvYvwjEMRM8iRkaQVCkOdYq/dy
	p4JnPprPlNkg0QftEe+vi/WA==
X-Received: by 2002:a17:903:2cf:b0:248:9e56:e806 with SMTP id d9443c01a7336-24944870a36mr208342685ad.12.1756871818916;
        Tue, 02 Sep 2025 20:56:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH91QTNWURwZyq+jfrufwDPXhYZ7WfuAhsURfl38s48fRT8fK/JL6QUg8zqz+3Qdv+zYqTmBD5Cn02b9SWm5w4=
X-Received: by 2002:a17:903:2cf:b0:248:9e56:e806 with SMTP id
 d9443c01a7336-24944870a36mr208342225ad.12.1756871818056; Tue, 02 Sep 2025
 20:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-6-eperezma@redhat.com>
 <CACGkMEt4OS25YszcQ=d08Mbnk8Sj7_o6U1NxyQaXp8k6m1wKig@mail.gmail.com> <CAJaqyWdo6EcBNpOhDXVEB4dyu5N9S1zKO4UZ+azhDjCR+68L_Q@mail.gmail.com>
In-Reply-To: <CAJaqyWdo6EcBNpOhDXVEB4dyu5N9S1zKO4UZ+azhDjCR+68L_Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Sep 2025 11:56:46 +0800
X-Gm-Features: Ac12FXxBvmy2WluFlDv2-PrZCRYMKa_qt4XW2QmDvUxV9y_o3ZodZGbBiSCSBck
Message-ID: <CACGkMEsZiX-M-PNGX8W7GprBJmiGi9Gz1=ayE=iMaP3WO3vr2Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u5DFhdgyMSAblhIGThCMpMAJ3gW8bhAAoAoLL5nqovA_1756871819
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 5:12=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Mon, Sep 1, 2025 at 4:46=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Add support for assigning Address Space Identifiers (ASIDs) to each V=
Q
> > > group.  This enables mapping each group into a distinct memory space.
> > >
> > > Now that the driver can change ASID in the middle of operation, the
> > > domain that each vq address point is also protected by domain_lock.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > v3:
> > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a low=
er
> > >   value to reduce memory consumption, but vqs are already limited to
> > >   that value and userspace VDUSE is able to allocate that many vqs.
> > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > >   VDUSE_IOTLB_GET_INFO.
> > > * Use of array_index_nospec in VDUSE device ioctls.
> > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > * Move the umem mutex to asid struct so there is no contention betwee=
n
> > >   ASIDs.
> > >
> > > v2:
> > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
> > >   part of the struct is the same.
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 290 +++++++++++++++++++++------=
--
> > >  include/uapi/linux/vduse.h         |  52 +++++-
> > >  2 files changed, 259 insertions(+), 83 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 7d2a3ed77b1e..2fb227713972 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -92,6 +92,7 @@ struct vduse_as {
> > >  };
> > >
> > >  struct vduse_vq_group_int {
> > > +       struct vduse_iova_domain *domain;
> >
> > I'd expect this should be vduse_as. Anything I miss?
> >
>
> It just saves a memory indirection step, as the rest of members of
> vduse_as are not used in vduse_map_ops callbacks. I can use vduse_as
> if you prefer it.

I think it's better to use that to follow the abstraction of a group
to address space indirection.

>
> > >         struct vduse_dev *dev;
> > >  };
> > >
> > > @@ -99,7 +100,7 @@ struct vduse_dev {
> > >         struct vduse_vdpa *vdev;
> > >         struct device *dev;
> > >         struct vduse_virtqueue **vqs;
> > > -       struct vduse_as as;
> > > +       struct vduse_as *as;
> > >         char *name;
> > >         struct mutex lock;
> > >         spinlock_t msg_lock;
> > > @@ -127,6 +128,7 @@ struct vduse_dev {
> > >         u32 vq_num;
> > >         u32 vq_align;
> > >         u32 ngroups;
> > > +       u32 nas;
> > >         struct vduse_vq_group_int *groups;
> > >         unsigned int bounce_size;
> > >         struct mutex domain_lock;
> > > @@ -317,7 +319,7 @@ static int vduse_dev_set_status(struct vduse_dev =
*dev, u8 status)
> > >         return vduse_dev_msg_sync(dev, &msg);
> > >  }
> > >
> > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
> > >                                   u64 start, u64 last)
> > >  {
> > >         struct vduse_dev_msg msg =3D { 0 };
> > > @@ -326,8 +328,14 @@ static int vduse_dev_update_iotlb(struct vduse_d=
ev *dev,
> > >                 return -EINVAL;
> > >
> > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > -       msg.req.iova.start =3D start;
> > > -       msg.req.iova.last =3D last;
> > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > +               msg.req.iova.start =3D start;
> > > +               msg.req.iova.last =3D last;
> > > +       } else {
> > > +               msg.req.iova_v2.start =3D start;
> > > +               msg.req.iova_v2.last =3D last;
> > > +               msg.req.iova_v2.asid =3D asid;
> > > +       }
> > >
> > >         return vduse_dev_msg_sync(dev, &msg);
> > >  }
> > > @@ -439,14 +447,28 @@ static __poll_t vduse_dev_poll(struct file *fil=
e, poll_table *wait)
> > >         return mask;
> > >  }
> > >
> > > +/* Force set the asid to a vq group without a message to the VDUSE d=
evice */
> > > +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> > > +                                      unsigned int group, unsigned i=
nt asid)
> > > +{
> > > +       guard(mutex)(&dev->domain_lock);
> > > +       dev->groups[group].domain =3D dev->as[asid].domain;
> > > +}
> > > +
> > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > >  {
> > >         int i;
> > > -       struct vduse_iova_domain *domain =3D dev->as.domain;
> > >
> > >         /* The coherent mappings are handled in vduse_dev_free_cohere=
nt() */
> > > -       if (domain && domain->bounce_map)
> > > -               vduse_domain_reset_bounce_map(domain);
> > > +       for (i =3D 0; i < dev->nas; i++) {
> > > +               struct vduse_iova_domain *domain =3D dev->as[i].domai=
n;
> > > +
> > > +               if (domain && domain->bounce_map)
> > > +                       vduse_domain_reset_bounce_map(domain);
> > > +       }
> > > +
> > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> > >
> > >         down_write(&dev->rwsem);
> > >
> > > @@ -620,6 +642,29 @@ static union virtio_map vduse_get_vq_map(struct =
vdpa_device *vdpa, u16 idx)
> > >         return ret;
> > >  }
> > >
> > > +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned i=
nt group,
> > > +                               unsigned int asid)
> > > +{
> > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > +       struct vduse_dev_msg msg =3D { 0 };
> > > +       int r;
> > > +
> > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > +           group >=3D dev->ngroups || asid >=3D dev->nas)
> > > +               return -EINVAL;
> > > +
> > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > +       msg.req.vq_group_asid.group =3D group;
> > > +       msg.req.vq_group_asid.asid =3D asid;
> > > +
> > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > +       if (r < 0)
> > > +               return r;
> > > +
> > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > +       return 0;
> > > +}
> > > +
> > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx=
,
> > >                                 struct vdpa_vq_state *state)
> > >  {
> > > @@ -818,13 +863,13 @@ static int vduse_vdpa_set_map(struct vdpa_devic=
e *vdpa,
> > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > >         int ret;
> > >
> > > -       ret =3D vduse_domain_set_map(dev->as.domain, iotlb);
> > > +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb);
> > >         if (ret)
> > >                 return ret;
> > >
> > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
> > >         if (ret) {
> > > -               vduse_domain_clear_map(dev->as.domain, iotlb);
> > > +               vduse_domain_clear_map(dev->as[asid].domain, iotlb);
> > >                 return ret;
> > >         }
> > >
> > > @@ -867,6 +912,7 @@ static const struct vdpa_config_ops vduse_vdpa_co=
nfig_ops =3D {
> > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > >         .reset                  =3D vduse_vdpa_reset,
> > >         .set_map                =3D vduse_vdpa_set_map,
> > > +       .set_group_asid         =3D vduse_set_group_asid,
> > >         .get_vq_map             =3D vduse_get_vq_map,
> > >         .free                   =3D vduse_vdpa_free,
> > >  };
> > > @@ -876,8 +922,10 @@ static void vduse_dev_sync_single_for_device(uni=
on virtio_map token,
> > >                                              enum dma_data_direction =
dir)
> > >  {
> > >         struct vduse_dev *vdev =3D token.group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > +       struct vduse_iova_domain *domain;
> > >
> > > +       guard(mutex)(&vdev->domain_lock);
> >
> > Is this correct? I mean each AS should have its own lock instead of
> > having a BQL.
> >
>
> That would not protect the pointer if vduse_dev_sync_single_for_device
> (or equivalent function that uses the domain) is called at the same
> time as vduse_set_group_asid.
>
> > > +       domain =3D token.group->domain;
> > >         vduse_domain_sync_single_for_device(domain, dma_addr, size, d=
ir);
> > >  }
> > >
> > > @@ -886,8 +934,10 @@ static void vduse_dev_sync_single_for_cpu(union =
virtio_map token,
> > >                                              enum dma_data_direction =
dir)
> > >  {
> > >         struct vduse_dev *vdev =3D token.group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > +       struct vduse_iova_domain *domain;
> > >
> > > +       guard(mutex)(&vdev->domain_lock);
> > > +       domain =3D token.group->domain;
> > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir)=
;
> > >  }
> > >
> > > @@ -897,8 +947,10 @@ static dma_addr_t vduse_dev_map_page(union virti=
o_map token, struct page *page,
> > >                                      unsigned long attrs)
> > >  {
> > >         struct vduse_dev *vdev =3D token.group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > +       struct vduse_iova_domain *domain;
> > >
> > > +       guard(mutex)(&vdev->domain_lock);
> > > +       domain =3D token.group->domain;
> > >         return vduse_domain_map_page(domain, page, offset, size, dir,=
 attrs);
> > >  }
> > >
> > > @@ -907,8 +959,10 @@ static void vduse_dev_unmap_page(union virtio_ma=
p token, dma_addr_t dma_addr,
> > >                                  unsigned long attrs)
> > >  {
> > >         struct vduse_dev *vdev =3D token.group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > +       struct vduse_iova_domain *domain;
> > >
> > > +       guard(mutex)(&vdev->domain_lock);
> > > +       domain =3D token.group->domain;
> > >         return vduse_domain_unmap_page(domain, dma_addr, size, dir, a=
ttrs);
> > >  }
> > >
> > > @@ -916,11 +970,13 @@ static void *vduse_dev_alloc_coherent(union vir=
tio_map token, size_t size,
> > >                                       dma_addr_t *dma_addr, gfp_t fla=
g)
> > >  {
> > >         struct vduse_dev *vdev =3D token.group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > +       struct vduse_iova_domain *domain;
> > >         unsigned long iova;
> > >         void *addr;
> > >
> > >         *dma_addr =3D DMA_MAPPING_ERROR;
> > > +       guard(mutex)(&vdev->domain_lock);
> > > +       domain =3D token.group->domain;
> > >         addr =3D vduse_domain_alloc_coherent(domain, size,
> > >                                            (dma_addr_t *)&iova, flag)=
;
> > >         if (!addr)
> > > @@ -936,16 +992,20 @@ static void vduse_dev_free_coherent(union virti=
o_map token, size_t size,
> > >                                     unsigned long attrs)
> > >  {
> > >         struct vduse_dev *vdev =3D token.group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > +       struct vduse_iova_domain *domain;
> > >
> > > +       guard(mutex)(&vdev->domain_lock);
> > > +       domain =3D token.group->domain;
> > >         vduse_domain_free_coherent(domain, size, vaddr, dma_addr, att=
rs);
> > >  }
> > >
> > >  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t d=
ma_addr)
> > >  {
> > >         struct vduse_dev *vdev =3D token.group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > +       struct vduse_iova_domain *domain;
> > >
> > > +       guard(mutex)(&vdev->domain_lock);
> > > +       domain =3D token.group->domain;
> > >         return dma_addr < domain->bounce_size;
> > >  }
> > >
> > > @@ -959,8 +1019,10 @@ static int vduse_dev_mapping_error(union virtio=
_map token, dma_addr_t dma_addr)
> > >  static size_t vduse_dev_max_mapping_size(union virtio_map token)
> > >  {
> > >         struct vduse_dev *vdev =3D token.group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > +       struct vduse_iova_domain *domain;
> > >
> > > +       guard(mutex)(&vdev->domain_lock);
> > > +       domain =3D token.group->domain;
> > >         return domain->bounce_size;
> > >  }
> > >
> > > @@ -1101,39 +1163,40 @@ static int vduse_dev_queue_irq_work(struct vd=
use_dev *dev,
> > >         return ret;
> > >  }
> > >
> > > -static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> > > +static int vduse_dev_dereg_umem(struct vduse_dev *dev, u32 asid,
> > >                                 u64 iova, u64 size)
> > >  {
> > >         int ret;
> > >
> > > -       mutex_lock(&dev->as.mem_lock);
> > > +       mutex_lock(&dev->as[asid].mem_lock);
> > >         ret =3D -ENOENT;
> > > -       if (!dev->as.umem)
> > > +       if (!dev->as[asid].umem)
> > >                 goto unlock;
> > >
> > >         ret =3D -EINVAL;
> > > -       if (!dev->as.domain)
> > > +       if (!dev->as[asid].domain)
> > >                 goto unlock;
> > >
> > > -       if (dev->as.umem->iova !=3D iova || size !=3D dev->as.domain-=
>bounce_size)
> > > +       if (dev->as[asid].umem->iova !=3D iova ||
> > > +           size !=3D dev->as[asid].domain->bounce_size)
> > >                 goto unlock;
> > >
> > > -       vduse_domain_remove_user_bounce_pages(dev->as.domain);
> > > -       unpin_user_pages_dirty_lock(dev->as.umem->pages,
> > > -                                   dev->as.umem->npages, true);
> > > -       atomic64_sub(dev->as.umem->npages, &dev->as.umem->mm->pinned_=
vm);
> > > -       mmdrop(dev->as.umem->mm);
> > > -       vfree(dev->as.umem->pages);
> > > -       kfree(dev->as.umem);
> > > -       dev->as.umem =3D NULL;
> > > +       vduse_domain_remove_user_bounce_pages(dev->as[asid].domain);
> > > +       unpin_user_pages_dirty_lock(dev->as[asid].umem->pages,
> > > +                                   dev->as[asid].umem->npages, true)=
;
> > > +       atomic64_sub(dev->as[asid].umem->npages, &dev->as[asid].umem-=
>mm->pinned_vm);
> > > +       mmdrop(dev->as[asid].umem->mm);
> > > +       vfree(dev->as[asid].umem->pages);
> > > +       kfree(dev->as[asid].umem);
> > > +       dev->as[asid].umem =3D NULL;
> > >         ret =3D 0;
> > >  unlock:
> > > -       mutex_unlock(&dev->as.mem_lock);
> > > +       mutex_unlock(&dev->as[asid].mem_lock);
> > >         return ret;
> > >  }
> > >
> > >  static int vduse_dev_reg_umem(struct vduse_dev *dev,
> > > -                             u64 iova, u64 uaddr, u64 size)
> > > +                             u32 asid, u64 iova, u64 uaddr, u64 size=
)
> > >  {
> > >         struct page **page_list =3D NULL;
> > >         struct vduse_umem *umem =3D NULL;
> > > @@ -1141,14 +1204,14 @@ static int vduse_dev_reg_umem(struct vduse_de=
v *dev,
> > >         unsigned long npages, lock_limit;
> > >         int ret;
> > >
> > > -       if (!dev->as.domain || !dev->as.domain->bounce_map ||
> > > -           size !=3D dev->as.domain->bounce_size ||
> > > +       if (!dev->as[asid].domain || !dev->as[asid].domain->bounce_ma=
p ||
> > > +           size !=3D dev->as[asid].domain->bounce_size ||
> > >             iova !=3D 0 || uaddr & ~PAGE_MASK)
> > >                 return -EINVAL;
> > >
> > > -       mutex_lock(&dev->as.mem_lock);
> > > +       mutex_lock(&dev->as[asid].mem_lock);
> > >         ret =3D -EEXIST;
> > > -       if (dev->as.umem)
> > > +       if (dev->as[asid].umem)
> > >                 goto unlock;
> > >
> > >         ret =3D -ENOMEM;
> > > @@ -1172,7 +1235,7 @@ static int vduse_dev_reg_umem(struct vduse_dev =
*dev,
> > >                 goto out;
> > >         }
> > >
> > > -       ret =3D vduse_domain_add_user_bounce_pages(dev->as.domain,
> > > +       ret =3D vduse_domain_add_user_bounce_pages(dev->as[asid].doma=
in,
> > >                                                  page_list, pinned);
> > >         if (ret)
> > >                 goto out;
> > > @@ -1185,7 +1248,7 @@ static int vduse_dev_reg_umem(struct vduse_dev =
*dev,
> > >         umem->mm =3D current->mm;
> > >         mmgrab(current->mm);
> > >
> > > -       dev->as.umem =3D umem;
> > > +       dev->as[asid].umem =3D umem;
> > >  out:
> > >         if (ret && pinned > 0)
> > >                 unpin_user_pages(page_list, pinned);
> > > @@ -1196,7 +1259,7 @@ static int vduse_dev_reg_umem(struct vduse_dev =
*dev,
> > >                 vfree(page_list);
> > >                 kfree(umem);
> > >         }
> > > -       mutex_unlock(&dev->as.mem_lock);
> > > +       mutex_unlock(&dev->as[asid].mem_lock);
> > >         return ret;
> > >  }
> > >
> > > @@ -1228,47 +1291,66 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> > >
> > >         switch (cmd) {
> > >         case VDUSE_IOTLB_GET_FD: {
> > > -               struct vduse_iotlb_entry entry;
> > > +               struct vduse_iotlb_entry_v2 entry;
> > >                 struct vhost_iotlb_map *map;
> > >                 struct vdpa_map_file *map_file;
> > >                 struct file *f =3D NULL;
> > > +               u32 asid;
> > >
> > >                 ret =3D -EFAULT;
> > > -               if (copy_from_user(&entry, argp, sizeof(entry)))
> > > -                       break;
> > > +               if (dev->api_version >=3D VDUSE_API_VERSION_1) {
> > > +                       if (copy_from_user(&entry, argp, sizeof(entry=
)))
> > > +                               break;
> > > +               } else {
> > > +                       entry.asid =3D 0;
> > > +                       if (copy_from_user(&entry.v1, argp,
> > > +                                          sizeof(entry.v1)))
> > > +                               break;
> > > +               }
> > >
> > >                 ret =3D -EINVAL;
> > > -               if (entry.start > entry.last)
> > > +               if (entry.v1.start > entry.v1.last)
> > > +                       break;
> > > +
> > > +               if (entry.asid >=3D dev->nas)
> > >                         break;
> > >
> > >                 mutex_lock(&dev->domain_lock);
> > > -               if (!dev->as.domain) {
> > > +               asid =3D array_index_nospec(entry.asid, dev->nas);
> > > +               if (!dev->as[asid].domain) {
> > >                         mutex_unlock(&dev->domain_lock);
> > >                         break;
> > >                 }
> > > -               spin_lock(&dev->as.domain->iotlb_lock);
> > > -               map =3D vhost_iotlb_itree_first(dev->as.domain->iotlb=
,
> > > -                                             entry.start, entry.last=
);
> > > +               spin_lock(&dev->as[asid].domain->iotlb_lock);
> > > +               map =3D vhost_iotlb_itree_first(dev->as[asid].domain-=
>iotlb,
> > > +                                             entry.v1.start, entry.v=
1.last);
> > >                 if (map) {
> > >                         map_file =3D (struct vdpa_map_file *)map->opa=
que;
> > >                         f =3D get_file(map_file->file);
> > > -                       entry.offset =3D map_file->offset;
> > > -                       entry.start =3D map->start;
> > > -                       entry.last =3D map->last;
> > > -                       entry.perm =3D map->perm;
> > > +                       entry.v1.offset =3D map_file->offset;
> > > +                       entry.v1.start =3D map->start;
> > > +                       entry.v1.last =3D map->last;
> > > +                       entry.v1.perm =3D map->perm;
> > >                 }
> > > -               spin_unlock(&dev->as.domain->iotlb_lock);
> > > +               spin_unlock(&dev->as[asid].domain->iotlb_lock);
> > >                 mutex_unlock(&dev->domain_lock);
> > >                 ret =3D -EINVAL;
> > >                 if (!f)
> > >                         break;
> > >
> > >                 ret =3D -EFAULT;
> > > -               if (copy_to_user(argp, &entry, sizeof(entry))) {
> > > +               if (dev->api_version >=3D VDUSE_API_VERSION_1)
> > > +                       ret =3D copy_to_user(argp, &entry,
> > > +                                          sizeof(entry));
> > > +               else
> > > +                       ret =3D copy_to_user(argp, &entry.v1,
> > > +                                          sizeof(entry.v1));
> > > +
> > > +               if (ret) {
> > >                         fput(f);
> > >                         break;
> > >                 }
> > > -               ret =3D receive_fd(f, NULL, perm_to_file_flags(entry.=
perm));
> > > +               ret =3D receive_fd(f, NULL, perm_to_file_flags(entry.=
v1.perm));
> > >                 fput(f);
> > >                 break;
> > >         }
> > > @@ -1401,6 +1483,7 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> > >         }
> > >         case VDUSE_IOTLB_REG_UMEM: {
> > >                 struct vduse_iova_umem umem;
> > > +               u32 asid;
> > >
> > >                 ret =3D -EFAULT;
> > >                 if (copy_from_user(&umem, argp, sizeof(umem)))
> > > @@ -1408,17 +1491,21 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> > >
> > >                 ret =3D -EINVAL;
> > >                 if (!is_mem_zero((const char *)umem.reserved,
> > > -                                sizeof(umem.reserved)))
> > > +                                sizeof(umem.reserved)) ||
> > > +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> > > +                    umem.asid !=3D 0) || umem.asid >=3D dev->nas)
> > >                         break;
> >
> > Does this mean umem is only supported for asid =3D=3D 0? This looks lik=
e a bug.
> >
>
> No, that conditional means that:
> * If dev->api_version < V1 (In other words, if it is 0), umem.asid
> must be 0. Previous versions already return -EINVAL if the reserved
> members are 0 so we must keep this behavior.
> * If the version is 1 or bigger, the asid must be smaller than the
> device number of ASID (dev->nas).

Ok I see, I misread it as

+                   (dev->api_version < VDUSE_API_VERSION_1 &&
+                    (umem.asid !=3D 0) || umem.asid >=3D dev->nas))

>
> > >
> > >                 mutex_lock(&dev->domain_lock);
> > > -               ret =3D vduse_dev_reg_umem(dev, umem.iova,
> > > +               asid =3D array_index_nospec(umem.asid, dev->nas);
> > > +               ret =3D vduse_dev_reg_umem(dev, asid, umem.iova,
> > >                                          umem.uaddr, umem.size);
> > >                 mutex_unlock(&dev->domain_lock);
> > >                 break;
> > >         }
> > >         case VDUSE_IOTLB_DEREG_UMEM: {
> > >                 struct vduse_iova_umem umem;
> > > +               u32 asid;
> > >
> > >                 ret =3D -EFAULT;
> > >                 if (copy_from_user(&umem, argp, sizeof(umem)))
> > > @@ -1426,10 +1513,15 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> > >
> > >                 ret =3D -EINVAL;
> > >                 if (!is_mem_zero((const char *)umem.reserved,
> > > -                                sizeof(umem.reserved)))
> > > +                                sizeof(umem.reserved)) ||
> > > +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> > > +                    umem.asid !=3D 0) ||
> > > +                    umem.asid >=3D dev->nas)
> > >                         break;
> > > +
> > >                 mutex_lock(&dev->domain_lock);
> > > -               ret =3D vduse_dev_dereg_umem(dev, umem.iova,
> > > +               asid =3D array_index_nospec(umem.asid, dev->nas);
> > > +               ret =3D vduse_dev_dereg_umem(dev, asid, umem.iova,
> > >                                            umem.size);
> > >                 mutex_unlock(&dev->domain_lock);
> > >                 break;
> > > @@ -1437,6 +1529,7 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> > >         case VDUSE_IOTLB_GET_INFO: {
> > >                 struct vduse_iova_info info;
> > >                 struct vhost_iotlb_map *map;
> > > +               u32 asid;
> > >
> > >                 ret =3D -EFAULT;
> > >                 if (copy_from_user(&info, argp, sizeof(info)))
> > > @@ -1450,23 +1543,31 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> > >                                  sizeof(info.reserved)))
> > >                         break;
> > >
> > > +               if (dev->api_version < VDUSE_API_VERSION_1) {
> > > +                       if (info.asid)
> > > +                               break;
> > > +               } else if (info.asid >=3D dev->nas)
> >
> > It would be simpler if we mandate dev->nas =3D=3D 1 VERSION 0.
> >
>
> That's done later in this patch, in the change of the
> vduse_validate_config function.
>
> > > +                       break;
> > > +
> > >                 mutex_lock(&dev->domain_lock);
> > > -               if (!dev->as.domain) {
> > > +               asid =3D array_index_nospec(info.asid, dev->nas);
> > > +               if (!dev->as[asid].domain) {
> > >                         mutex_unlock(&dev->domain_lock);
> > >                         break;
> > >                 }
> > > -               spin_lock(&dev->as.domain->iotlb_lock);
> > > -               map =3D vhost_iotlb_itree_first(dev->as.domain->iotlb=
,
> > > +               spin_lock(&dev->as[asid].domain->iotlb_lock);
> > > +               map =3D vhost_iotlb_itree_first(dev->as[asid].domain-=
>iotlb,
> > >                                               info.start, info.last);
> > >                 if (map) {
> > >                         info.start =3D map->start;
> > >                         info.last =3D map->last;
> > >                         info.capability =3D 0;
> > > -                       if (dev->as.domain->bounce_map && map->start =
=3D=3D 0 &&
> > > -                           map->last =3D=3D dev->as.domain->bounce_s=
ize - 1)
> > > +                       if (dev->as[asid].domain->bounce_map &&
> > > +                           map->start =3D=3D 0 &&
> > > +                           map->last =3D=3D dev->as[asid].domain->bo=
unce_size - 1)
> > >                                 info.capability |=3D VDUSE_IOVA_CAP_U=
MEM;
> > >                 }
> > > -               spin_unlock(&dev->as.domain->iotlb_lock);
> > > +               spin_unlock(&dev->as[asid].domain->iotlb_lock);
> > >                 mutex_unlock(&dev->domain_lock);
> > >                 if (!map)
> > >                         break;
> > > @@ -1491,8 +1592,10 @@ static int vduse_dev_release(struct inode *ino=
de, struct file *file)
> > >         struct vduse_dev *dev =3D file->private_data;
> > >
> > >         mutex_lock(&dev->domain_lock);
> > > -       if (dev->as.domain)
> > > -               vduse_dev_dereg_umem(dev, 0, dev->as.domain->bounce_s=
ize);
> > > +       for (int i =3D 0; i < dev->nas; i++)
> > > +               if (dev->as[i].domain)
> >
> > Not related to this patch, but I wonder which case could we get domain
> > =3D=3D NULL here?
> >
>
> I never tried myself but the domain is set at vdpa_dev_add. If a VDUSE
> device is created by the VDUSE_CREATE_DEV ioctl and then destroyed
> with VDUSE_DESTROY_DEV without calling "vdpa dev add" the
> vduse_dev_release function will find dev->as[i].domain =3D=3D NULL.
>

Ok, but I didn't see a similar if(dev->domain) check in
VDUSE_IOTLB_DEREG_UMEM. Is this a bug? If it is, maybe it's better to
move the as check inside vduse_dev_dereg_umem.


> > > +                       vduse_dev_dereg_umem(dev, i, 0,
> > > +                                            dev->as[i].domain->bounc=
e_size);
> > >         mutex_unlock(&dev->domain_lock);
> > >         spin_lock(&dev->msg_lock);
> > >         /* Make sure the inflight messages can processed after reconn=
cection */
> > > @@ -1711,7 +1814,6 @@ static struct vduse_dev *vduse_dev_create(void)
> > >                 return NULL;
> > >
> > >         mutex_init(&dev->lock);
> > > -       mutex_init(&dev->as.mem_lock);
> > >         mutex_init(&dev->domain_lock);
> > >         spin_lock_init(&dev->msg_lock);
> > >         INIT_LIST_HEAD(&dev->send_list);
> > > @@ -1762,8 +1864,11 @@ static int vduse_destroy_dev(char *name)
> > >         idr_remove(&vduse_idr, dev->minor);
> > >         kvfree(dev->config);
> > >         vduse_dev_deinit_vqs(dev);
> > > -       if (dev->as.domain)
> > > -               vduse_domain_destroy(dev->as.domain);
> > > +       for (int i =3D 0; i < dev->nas; i++) {
> > > +               if (dev->as[i].domain)
> > > +                       vduse_domain_destroy(dev->as[i].domain);
> > > +       }
> > > +       kfree(dev->as);
> > >         kfree(dev->name);
> > >         kfree(dev->groups);
> > >         vduse_dev_destroy(dev);
> > > @@ -1810,12 +1915,16 @@ static bool vduse_validate_config(struct vdus=
e_dev_config *config,
> > >                          sizeof(config->reserved)))
> > >                 return false;
> > >
> > > -       if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> > > +       if (api_version < VDUSE_API_VERSION_1 &&
> > > +           (config->ngroups || config->nas))
> > >                 return false;
> > >
> > >         if (api_version >=3D VDUSE_API_VERSION_1 && config->ngroups >=
 0xffff)
> > >                 return false;
> > >
> > > +       if (api_version >=3D VDUSE_API_VERSION_1 && config->nas > 0xf=
fff)
> > > +               return false;
> >
> > Using macro instead of magic number please.
> >
> > > +
> > >         if (config->vq_align > PAGE_SIZE)
> > >                 return false;
> > >
> > > @@ -1879,7 +1988,8 @@ static ssize_t bounce_size_store(struct device =
*device,
> > >
> >
> > So the real size of the bounce should be bounce_size * nas? Should we
> > be conservative to adjust per as bounce size to bounce_size / nas?
> >
>
> I think that's a bad idea in net devices in particular, as I expect
> the dataplane will need way more memory than CVQ.

Ok, I just want to note that the bounce might consume more than what
the user set here.

> bounce_size per
> device seems more correct to me. But I can divide per nas for sure.

Or make bounce_size to be the total size of all virtqueues, so
management will increase it when it knows there's a multiqueue device.

>
> > >         ret =3D -EPERM;
> > >         mutex_lock(&dev->domain_lock);
> > > -       if (dev->as.domain)
> > > +       /* Assuming that if the first domain is allocated, all are al=
located */
> > > +       if (dev->as[0].domain)
> > >                 goto unlock;
> > >
> > >         ret =3D kstrtouint(buf, 10, &bounce_size);
> > > @@ -1940,6 +2050,13 @@ static int vduse_create_dev(struct vduse_dev_c=
onfig *config,
> > >         for (u32 i =3D 0; i < dev->ngroups; ++i)
> > >                 dev->groups[i].dev =3D dev;
> > >
> > > +       dev->nas =3D (dev->api_version < 1) ? 1 : (config->nas ?: 1);
> > > +       dev->as =3D kcalloc(dev->nas, sizeof(dev->as[0]), GFP_KERNEL)=
;
> > > +       if (!dev->as)
> > > +               goto err_as;
> > > +       for (int i =3D 0; i < dev->nas; i++)
> > > +               mutex_init(&dev->as[i].mem_lock);
> > > +
> > >         dev->name =3D kstrdup(config->name, GFP_KERNEL);
> > >         if (!dev->name)
> > >                 goto err_str;
> > > @@ -1976,6 +2093,8 @@ static int vduse_create_dev(struct vduse_dev_co=
nfig *config,
> > >  err_idr:
> > >         kfree(dev->name);
> > >  err_str:
> > > +       kfree(dev->as);
> > > +err_as:
> > >         kfree(dev->groups);
> > >  err_vq_groups:
> > >         vduse_dev_destroy(dev);
> > > @@ -2101,7 +2220,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev=
 *dev, const char *name)
> > >
> > >         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> > >                                  &vduse_vdpa_config_ops, &vduse_map_o=
ps,
> > > -                                dev->ngroups, 1, name, true);
> > > +                                dev->ngroups, dev->nas, name, true);
> > >         if (IS_ERR(vdev))
> > >                 return PTR_ERR(vdev);
> > >
> > > @@ -2130,11 +2249,20 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev =
*mdev, const char *name,
> > >                 return ret;
> > >
> > >         mutex_lock(&dev->domain_lock);
> > > -       if (!dev->as.domain)
> > > -               dev->as.domain =3D vduse_domain_create(VDUSE_IOVA_SIZ=
E - 1,
> > > -                                                 dev->bounce_size);
> > > +       ret =3D 0;
> > > +
> > > +       for (int i =3D 0; i < dev->nas; ++i) {
> > > +               dev->as[i].domain =3D vduse_domain_create(VDUSE_IOVA_=
SIZE - 1,
> > > +                                                       dev->bounce_s=
ize);
> > > +               if (!dev->as[i].domain) {
> > > +                       ret =3D -ENOMEM;
> > > +                       for (int j =3D 0; j < i; ++j)
> > > +                               vduse_domain_destroy(dev->as[j].domai=
n);
> > > +               }
> > > +       }
> > > +
> > >         mutex_unlock(&dev->domain_lock);
> > > -       if (!dev->as.domain) {
> > > +       if (ret =3D=3D -ENOMEM) {
> > >                 put_device(&dev->vdev->vdpa.dev);
> > >                 return -ENOMEM;
> > >         }
> > > @@ -2143,8 +2271,12 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *=
mdev, const char *name,
> > >         if (ret) {
> > >                 put_device(&dev->vdev->vdpa.dev);
> > >                 mutex_lock(&dev->domain_lock);
> > > -               vduse_domain_destroy(dev->as.domain);
> > > -               dev->as.domain =3D NULL;
> > > +               for (int i =3D 0; i < dev->nas; i++) {
> > > +                       if (dev->as[i].domain) {
> > > +                               vduse_domain_destroy(dev->as[i].domai=
n);
> > > +                               dev->as[i].domain =3D NULL;
> > > +                       }
> >
> > This is a little bit duplicated with the error handling above, should
> > we consider to switch to use err labels?
> >
>
> Sure, I can change it.
>
> > > +               }
> > >                 mutex_unlock(&dev->domain_lock);
> > >                 return ret;
> > >         }
> > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > index b1c0e47d71fb..54da965a65dc 100644
> > > --- a/include/uapi/linux/vduse.h
> > > +++ b/include/uapi/linux/vduse.h
> > > @@ -47,7 +47,8 @@ struct vduse_dev_config {
> > >         __u32 vq_num;
> > >         __u32 vq_align;
> > >         __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > > -       __u32 reserved[12];
> > > +       __u32 nas; /* if VDUSE_API_VERSION >=3D 1 */
> > > +       __u32 reserved[11];
> > >         __u32 config_size;
> > >         __u8 config[];
> > >  };
> > > @@ -82,6 +83,18 @@ struct vduse_iotlb_entry {
> > >         __u8 perm;
> > >  };
> > >
> > > +/**
> > > + * struct vduse_iotlb_entry_v2 - entry of IOTLB to describe one IOVA=
 region in an ASID
> > > + * @v1: the original vduse_iotlb_entry
> > > + * @asid: address space ID of the IOVA region
> > > + *
> > > + * Structure used by VDUSE_IOTLB_GET_FD ioctl to find an overlapped =
IOVA region.
> > > + */
> > > +struct vduse_iotlb_entry_v2 {
> > > +       struct vduse_iotlb_entry v1;
> > > +       __u32 asid;
> > > +};
> > > +
> > >  /*
> > >   * Find the first IOVA region that overlaps with the range [start, l=
ast]
> > >   * and return the corresponding file descriptor. Return -EINVAL mean=
s the
> > > @@ -172,6 +185,16 @@ struct vduse_vq_group {
> > >         __u32 group;
> > >  };
> > >
> > > +/**
> > > + * struct vduse_vq_group - virtqueue group
> > > + @ @group: Index of the virtqueue group
> > > + * @asid: Address space ID of the group
> > > + */
> > > +struct vduse_vq_group_asid {
> > > +       __u32 group;
> > > +       __u32 asid;
> > > +};
> > > +
> > >  /**
> > >   * struct vduse_vq_info - information of a virtqueue
> > >   * @index: virtqueue index
> > > @@ -231,6 +254,7 @@ struct vduse_vq_eventfd {
> > >   * @uaddr: start address of userspace memory, it must be aligned to =
page size
> > >   * @iova: start of the IOVA region
> > >   * @size: size of the IOVA region
> > > + * @asid: Address space ID of the IOVA region
> > >   * @reserved: for future use, needs to be initialized to zero
> > >   *
> > >   * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
> > > @@ -240,7 +264,8 @@ struct vduse_iova_umem {
> > >         __u64 uaddr;
> > >         __u64 iova;
> > >         __u64 size;
> > > -       __u64 reserved[3];
> > > +       __u32 asid;
> > > +       __u32 reserved[5];
> > >  };
> > >
> > >  /* Register userspace memory for IOVA regions */
> > > @@ -254,6 +279,7 @@ struct vduse_iova_umem {
> > >   * @start: start of the IOVA region
> > >   * @last: last of the IOVA region
> > >   * @capability: capability of the IOVA regsion
> > > + * @asid: Address space ID of the IOVA region, only if device API ve=
rsion >=3D 1
> > >   * @reserved: for future use, needs to be initialized to zero
> > >   *
> > >   * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information o=
f
> > > @@ -264,7 +290,8 @@ struct vduse_iova_info {
> > >         __u64 last;
> > >  #define VDUSE_IOVA_CAP_UMEM (1 << 0)
> > >         __u64 capability;
> > > -       __u64 reserved[3];
> > > +       __u32 asid; /* Only if device API version >=3D 1 */
> > > +       __u32 reserved[5];
> > >  };
> > >
> > >  /*
> > > @@ -287,6 +314,7 @@ enum vduse_req_type {
> > >         VDUSE_SET_STATUS,
> > >         VDUSE_UPDATE_IOTLB,
> > >         VDUSE_GET_VQ_GROUP,
> > > +       VDUSE_SET_VQ_GROUP_ASID,
> > >  };
> > >
> > >  /**
> > > @@ -321,6 +349,18 @@ struct vduse_iova_range {
> > >         __u64 last;
> > >  };
> > >
> > > +/**
> > > + * struct vduse_iova_range - IOVA range [start, last] if API_VERSION=
 >=3D 1
> > > + * @start: start of the IOVA range
> > > + * @last: last of the IOVA range
> > > + * @asid: address space ID of the IOVA range
> > > + */
> > > +struct vduse_iova_range_v2 {
> > > +       __u64 start;
> > > +       __u64 last;
> > > +       __u32 asid;
> > > +};
> > > +
> > >  /**
> > >   * struct vduse_dev_request - control request
> > >   * @type: request type
> > > @@ -330,6 +370,8 @@ struct vduse_iova_range {
> > >   * @s: device status
> > >   * @iova: IOVA range for updating
> > >   * @vq_group: virtqueue group of a virtqueue
> > > + * @iova_v2: IOVA range for updating if API_VERSION >=3D 1
> > > + * @vq_group_asid: ASID of a virtqueue group
> > >   * @padding: padding
> > >   *
> > >   * Structure used by read(2) on /dev/vduse/$NAME.
> > > @@ -342,8 +384,10 @@ struct vduse_dev_request {
> > >                 struct vduse_vq_state vq_state;
> > >                 struct vduse_dev_status s;
> > >                 struct vduse_iova_range iova;
> > > -               /* Only if vduse api version >=3D 1 */;
> > > +               /* Following members only if vduse api version >=3D 1=
 */;
> > >                 struct vduse_vq_group vq_group;
> > > +               struct vduse_iova_range_v2 iova_v2;
> > > +               struct vduse_vq_group_asid vq_group_asid;
> > >                 __u32 padding[32];
> >
> > This seems to break the uAPI for the userspace that tries to use
> > sizeof(struct vduse_dev_request)?
> >
>
> No, I'm adding a member to the union that is smaller than u32[32]:
>
> https://patchew.org/linux/20250606115012.1331551-1-eperezma@redhat.com/20=
250606115012.1331551-4-eperezma@redhat.com/#CACGkMEvT._5F1ngR9Cs1A6ghNhZtyX=
iAb7qZq-Xj=3D7NWOzO9o5C=3Dw@mail.gmail.com
>

You are right.

Thanks

