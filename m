Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC472EAB61
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127279; cv=none; b=MpHx1dqBWkPe5R4O2XRWYzH9jr8lu7xOzRjahRPqC0aolD+ajlxO9WP9ng6A+gU0E1/NVHoMspUlekyK+Ywqmgjgq9M9xoN/kPnMqZm1W9iao8KK9EJ8FWIqZ1lvmU3bhUh8uSihjY7lRIxQZoo0iNQOSGb3ekeTK8hX8uZXydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127279; c=relaxed/simple;
	bh=W6Dh+yUVQoswGN4R5XOFfU1EvXGjRV03+I2lEav46z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaAuLbn7OvJWnSdR9DY/arpvYsQ3mjieTn3EUD1k3CmCO/OE3nPEY5lTdFj7oNy27+DYrqef9QnzSI3KVUqt5CBAdtExQs9bmB5STmObCKhx9HyOaE2WE9upZV/3CfS4Id/BZ9+ATdJXOyfgt1G3QxR8IJ0Xx1pGF2NS7QAkhUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVYw/RQC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVYw/RQC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758127275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yqq+NTh520/T1gHyGBc7UvY5vZWw8pcMK+mVYjQrak=;
	b=iVYw/RQCYNCB+OpVuuMF1IbzkJ4Jj19ba5y99U5NQX7rSz4TemAq1GUgaNtK2uG12eh66k
	JIetGEs/3RgXkl/FxnFUAQmhSLcBNa3RUp/bg1tAClUzjjqhPWeTwDNoOdqO0x7oMqnG8N
	+KDFHMNByMp2CyxOJd+dVmdnhbnbveM=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-EJiJBhWTPR-nFGFiI4O5bg-1; Wed, 17 Sep 2025 12:41:14 -0400
X-MC-Unique: EJiJBhWTPR-nFGFiI4O5bg-1
X-Mimecast-MFC-AGG-ID: EJiJBhWTPR-nFGFiI4O5bg_1758127273
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-632edf1e41dso2440761d50.1
        for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 09:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758127273; x=1758732073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yqq+NTh520/T1gHyGBc7UvY5vZWw8pcMK+mVYjQrak=;
        b=GxhARv5etfTxNk+9mjOCmddKAWqkNpg6aegKoy4fzkGIS33ntxsVBQDpJ0/ZRrFuY2
         eDEVQ0Efd2Kt98avvEadtY92L8HJ7PyrzRG3rRwkmuyMV+WuCx+jI3EUVfk9kGvgOMmp
         N/bjhYqH+41ZZz9WnEjmWwq3FiszOnB7ly08e358nuj6H6N1gtWY4Iate8uB48LaBoHG
         VnbirYkpLyUmMwVQ5Z2TF09SDh5ZVXQXWeX7BhB0mPg7TF5cxebYfg86XSmUDCkXaomM
         bZT/prSORxWeXGt/IU7md4FwJaj1fy18h1I8RYRUsT0Aw7+cQdjQ7hs7BIoL6+u6nmIq
         /TtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFFx+Ni7ubq41mnxX7WiK0o3aK3IVF4OOrVkmtzw5cLR/Lt9j9uABbpV6kYgsHuUhK7/rYfkL7zSJAtAzVrw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLnVbHSu3SnvpmVSQXsIGp37fGZNsuBfoSXz9UG/ZM0/AMTiLC
	Ai0WYcg6wO/u0/7UI2wEqhiXc7HQDLmHUT10ST8cvYJ+aVnz0bVGiLcmGRdPsthy/eIWXJm7cfO
	LpB+OjxDaDm7d+GI3Sg3j+Uy3RsaEGgwbs9D+2WAnovWu3CDdjhcKoJp3CL+2QbnFBnsqWgYjTy
	Y+d9Rygp+NH7V3MnB0JEVezrzONSOpkkT25Z52zXMA6gk=
X-Gm-Gg: ASbGncsNepiexQeM72wtky9byUaVrCw/vZ+6AQlQtkfbBQ2G2Y4ppIrs/gMpYxu8JzU
	t0J1P4mHyuPyEnYZCJjvOhn+2pnG2mOuoZGyd0+reqp44tbjg3cjYbYumAI5KwafQ3BTBS7XOFj
	DOQXeTb5vJzDCbPXoy+PL2zkAyUAnUb4Xu4Afqa/OOt0eKILdZI0jfGf+N2+tHQfloqJkhCKaTj
	SD04IWD
X-Received: by 2002:a05:690e:1447:b0:627:b214:8408 with SMTP id 956f58d0204a3-633b06a0e87mr2091131d50.24.1758127272632;
        Wed, 17 Sep 2025 09:41:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHG2tN5nM+uRGx1zVf6ntW+a0s3qb1RgYcubt7euT27EIqGfWZfM21CT0uIoFH94GEKekSZzhrLe6aLhGs2dg=
X-Received: by 2002:a05:690e:1447:b0:627:b214:8408 with SMTP id
 956f58d0204a3-633b06a0e87mr2091099d50.24.1758127271705; Wed, 17 Sep 2025
 09:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-7-eperezma@redhat.com>
 <CACGkMEu4F8Spw-=ve0w45CmJhEkBMtDdRCYNDorA6NxunkuDaw@mail.gmail.com>
In-Reply-To: <CACGkMEu4F8Spw-=ve0w45CmJhEkBMtDdRCYNDorA6NxunkuDaw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 17 Sep 2025 18:40:34 +0200
X-Gm-Features: AS18NWDHndSTUsezOduUaokTq0rcc2a1x-xXMqMWPO2MWASDfXvXR0lqrDYHSmc
Message-ID: <CAJaqyWfqNX6E89Z4Yz373V6r1xLzJVNon5A_fCdU=79nAk6CRQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] vduse: add vq group asid support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X9EVG3EYtqlvVoO637Myyx14iRUzEMy6nqrAY0aoOdg_1758127273
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:56=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Tue, Sep 16, 2025 at 9:09=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> > group.  This enables mapping each group into a distinct memory space.
> >
> > Now that the driver can change ASID in the middle of operation, the
> > domain that each vq address point is also protected by domain_lock.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v2:
> > * Convert the use of mutex to rwlock.
> >
> > RFC v3:
> > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
> >   value to reduce memory consumption, but vqs are already limited to
> >   that value and userspace VDUSE is able to allocate that many vqs.
> > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> >   VDUSE_IOTLB_GET_INFO.
> > * Use of array_index_nospec in VDUSE device ioctls.
> > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > * Move the umem mutex to asid struct so there is no contention between
> >   ASIDs.
> >
> > RFC v2:
> > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
> >   part of the struct is the same.
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 324 +++++++++++++++++++++--------
> >  include/uapi/linux/vduse.h         |  51 ++++-
> >  2 files changed, 284 insertions(+), 91 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index b45b1d22784f..06b7790380b7 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -93,6 +93,7 @@ struct vduse_as {
> >  };
> >
> >  struct vduse_vq_group_int {
> > +       struct vduse_iova_domain *domain;
> >         struct vduse_dev *dev;
>
> This confuses me, I think it should be an asid. And the vduse_dev
> pointer seems to be useless here.
>

The *dev pointer is used to take the rwlock, in case the vhost driver
calls VHOST_VDPA_SET_GROUP_ASID (or equivalent) at the same time
vduse_dev_sync_single_for_device (or _for_cpu, or equivalent) run.

> >  };
> >
> > @@ -100,7 +101,7 @@ struct vduse_dev {
> >         struct vduse_vdpa *vdev;
> >         struct device *dev;
> >         struct vduse_virtqueue **vqs;
> > -       struct vduse_as as;
> > +       struct vduse_as *as;
> >         char *name;
> >         struct mutex lock;
> >         spinlock_t msg_lock;
> > @@ -128,6 +129,7 @@ struct vduse_dev {
> >         u32 vq_num;
> >         u32 vq_align;
> >         u32 ngroups;
> > +       u32 nas;
> >         struct vduse_vq_group_int *groups;
> >         unsigned int bounce_size;
> >         rwlock_t domain_lock;
> > @@ -318,7 +320,7 @@ static int vduse_dev_set_status(struct vduse_dev *d=
ev, u8 status)
> >         return vduse_dev_msg_sync(dev, &msg);
> >  }
> >
> > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
> >                                   u64 start, u64 last)
> >  {
> >         struct vduse_dev_msg msg =3D { 0 };
> > @@ -327,8 +329,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev=
 *dev,
> >                 return -EINVAL;
> >
> >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > -       msg.req.iova.start =3D start;
> > -       msg.req.iova.last =3D last;
> > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > +               msg.req.iova.start =3D start;
> > +               msg.req.iova.last =3D last;
> > +       } else {
> > +               msg.req.iova_v2.start =3D start;
> > +               msg.req.iova_v2.last =3D last;
> > +               msg.req.iova_v2.asid =3D asid;
> > +       }
> >
> >         return vduse_dev_msg_sync(dev, &msg);
> >  }
> > @@ -440,14 +448,29 @@ static __poll_t vduse_dev_poll(struct file *file,=
 poll_table *wait)
> >         return mask;
> >  }
> >
> > +/* Force set the asid to a vq group without a message to the VDUSE dev=
ice */
> > +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> > +                                      unsigned int group, unsigned int=
 asid)
> > +{
> > +       write_lock(&dev->domain_lock);
> > +       dev->groups[group].domain =3D dev->as[asid].domain;
>
> I think it would be better to stick the group->as an indirection which
> should be .
>
> dev->groups.asid =3D asid;
>
> Or
>
> dev->group->as =3D as;
>

That involves an extra memory jump for functions that may be in the
hot path. I've not profiled it, but I'm ok with changing it that way
if you prefer.

> > +       write_unlock(&dev->domain_lock);
> > +}
> > +
> >  static void vduse_dev_reset(struct vduse_dev *dev)
> >  {
> >         int i;
> > -       struct vduse_iova_domain *domain =3D dev->as.domain;
> >
> >         /* The coherent mappings are handled in vduse_dev_free_coherent=
() */
> > -       if (domain && domain->bounce_map)
> > -               vduse_domain_reset_bounce_map(domain);
> > +       for (i =3D 0; i < dev->nas; i++) {
> > +               struct vduse_iova_domain *domain =3D dev->as[i].domain;
> > +
> > +               if (domain && domain->bounce_map)
> > +                       vduse_domain_reset_bounce_map(domain);
> > +       }
> > +
> > +       for (i =3D 0; i < dev->ngroups; i++)
> > +               vduse_set_group_asid_nomsg(dev, i, 0);
> >
> >         down_write(&dev->rwsem);
> >
> > @@ -621,6 +644,29 @@ static union virtio_map vduse_get_vq_map(struct vd=
pa_device *vdpa, u16 idx)
> >         return ret;
> >  }
> >
> > +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned int=
 group,
> > +                               unsigned int asid)
> > +{
> > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > +       struct vduse_dev_msg msg =3D { 0 };
> > +       int r;
> > +
> > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > +           group >=3D dev->ngroups || asid >=3D dev->nas)
> > +               return -EINVAL;
> > +
> > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > +       msg.req.vq_group_asid.group =3D group;
> > +       msg.req.vq_group_asid.asid =3D asid;
> > +
> > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > +       if (r < 0)
> > +               return r;
> > +
> > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > +       return 0;
> > +}
> > +
> >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> >                                 struct vdpa_vq_state *state)
> >  {
> > @@ -792,13 +838,13 @@ static int vduse_vdpa_set_map(struct vdpa_device =
*vdpa,
> >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> >         int ret;
> >
> > -       ret =3D vduse_domain_set_map(dev->as.domain, iotlb);
> > +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb);
> >         if (ret)
> >                 return ret;
> >
> > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
> >         if (ret) {
> > -               vduse_domain_clear_map(dev->as.domain, iotlb);
> > +               vduse_domain_clear_map(dev->as[asid].domain, iotlb);
> >                 return ret;
> >         }
> >
> > @@ -841,6 +887,7 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
> >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> >         .reset                  =3D vduse_vdpa_reset,
> >         .set_map                =3D vduse_vdpa_set_map,
> > +       .set_group_asid         =3D vduse_set_group_asid,
> >         .get_vq_map             =3D vduse_get_vq_map,
> >         .free                   =3D vduse_vdpa_free,
> >  };
> > @@ -850,9 +897,12 @@ static void vduse_dev_sync_single_for_device(union=
 virtio_map token,
> >                                              enum dma_data_direction di=
r)
> >  {
> >         struct vduse_dev *vdev =3D token.group->dev;
> > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > +       struct vduse_iova_domain *domain;
> >
> > +       read_lock(&vdev->domain_lock);
> > +       domain =3D token.group->domain;
> >         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir=
);
> > +       read_unlock(&vdev->domain_lock);
> >  }
> >
> >  static void vduse_dev_sync_single_for_cpu(union virtio_map token,
> > @@ -860,9 +910,12 @@ static void vduse_dev_sync_single_for_cpu(union vi=
rtio_map token,
> >                                              enum dma_data_direction di=
r)
> >  {
> >         struct vduse_dev *vdev =3D token.group->dev;
> > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > +       struct vduse_iova_domain *domain;
> >
> > +       read_lock(&vdev->domain_lock);
> > +       domain =3D token.group->domain;
>
> I think the domain is better fetched via vduse_as.
>
> >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
> > +       read_unlock(&vdev->domain_lock);
> >  }
> >
> >  static dma_addr_t vduse_dev_map_page(union virtio_map token, struct pa=
ge *page,
> > @@ -871,9 +924,15 @@ static dma_addr_t vduse_dev_map_page(union virtio_=
map token, struct page *page,
> >                                      unsigned long attrs)
> >  {
> >         struct vduse_dev *vdev =3D token.group->dev;
> > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > +       struct vduse_iova_domain *domain;
> > +       dma_addr_t r;
> >
> > -       return vduse_domain_map_page(domain, page, offset, size, dir, a=
ttrs);
> > +       read_lock(&vdev->domain_lock);
> > +       domain =3D token.group->domain;
> > +       r =3D vduse_domain_map_page(domain, page, offset, size, dir, at=
trs);
> > +       read_unlock(&vdev->domain_lock);
> > +
> > +       return r;
> >  }
> >
> >  static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dm=
a_addr,
> > @@ -881,27 +940,31 @@ static void vduse_dev_unmap_page(union virtio_map=
 token, dma_addr_t dma_addr,
> >                                  unsigned long attrs)
> >  {
> >         struct vduse_dev *vdev =3D token.group->dev;
> > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > +       struct vduse_iova_domain *domain;
> >
> > -       return vduse_domain_unmap_page(domain, dma_addr, size, dir, att=
rs);
> > +       read_lock(&vdev->domain_lock);
> > +       domain =3D token.group->domain;
> > +       vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
> > +       read_unlock(&vdev->domain_lock);
> >  }
> >
> >  static void *vduse_dev_alloc_coherent(union virtio_map token, size_t s=
ize,
> >                                       dma_addr_t *dma_addr, gfp_t flag)
> >  {
> >         struct vduse_dev *vdev =3D token.group->dev;
> > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > +       struct vduse_iova_domain *domain;
> >         unsigned long iova;
> > -       void *addr;
> > +       void *addr =3D NULL;
> >
> >         *dma_addr =3D DMA_MAPPING_ERROR;
> > +       read_lock(&vdev->domain_lock);
> > +       domain =3D token.group->domain;
> >         addr =3D vduse_domain_alloc_coherent(domain, size,
> >                                            (dma_addr_t *)&iova, flag);
> > -       if (!addr)
> > -               return NULL;
> > -
> > -       *dma_addr =3D (dma_addr_t)iova;
> > +       if (addr)
> > +               *dma_addr =3D (dma_addr_t)iova;
> >
> > +       read_unlock(&vdev->domain_lock);
> >         return addr;
> >  }
> >
> > @@ -910,17 +973,26 @@ static void vduse_dev_free_coherent(union virtio_=
map token, size_t size,
> >                                     unsigned long attrs)
> >  {
> >         struct vduse_dev *vdev =3D token.group->dev;
> > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > +       struct vduse_iova_domain *domain;
> >
> > +       read_lock(&vdev->domain_lock);
> > +       domain =3D token.group->domain;
> >         vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs=
);
> > +       read_unlock(&vdev->domain_lock);
> >  }
> >
> >  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma=
_addr)
> >  {
> >         struct vduse_dev *vdev =3D token.group->dev;
> > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > +       struct vduse_iova_domain *domain;
> > +       size_t bounce_size;
> >
> > -       return dma_addr < domain->bounce_size;
> > +       read_lock(&vdev->domain_lock);
> > +       domain =3D token.group->domain;
> > +       bounce_size =3D domain->bounce_size;
> > +       read_unlock(&vdev->domain_lock);
> > +
> > +       return dma_addr < bounce_size;
> >  }
> >
> >  static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t =
dma_addr)
> > @@ -933,9 +1005,15 @@ static int vduse_dev_mapping_error(union virtio_m=
ap token, dma_addr_t dma_addr)
> >  static size_t vduse_dev_max_mapping_size(union virtio_map token)
> >  {
> >         struct vduse_dev *vdev =3D token.group->dev;
> > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > +       struct vduse_iova_domain *domain;
> > +       size_t bounce_size;
> > +
> > +       read_lock(&vdev->domain_lock);
> > +       domain =3D token.group->domain;
> > +       bounce_size =3D domain->bounce_size;
> > +       read_unlock(&vdev->domain_lock);
> >
> > -       return domain->bounce_size;
> > +       return bounce_size;
> >  }
> >
> >  static const struct virtio_map_ops vduse_map_ops =3D {
> > @@ -1075,39 +1153,40 @@ static int vduse_dev_queue_irq_work(struct vdus=
e_dev *dev,
> >         return ret;
> >  }
> >
> > -static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> > +static int vduse_dev_dereg_umem(struct vduse_dev *dev, u32 asid,
> >                                 u64 iova, u64 size)
> >  {
> >         int ret;
> >
> > -       mutex_lock(&dev->as.mem_lock);
> > +       mutex_lock(&dev->as[asid].mem_lock);
> >         ret =3D -ENOENT;
> > -       if (!dev->as.umem)
> > +       if (!dev->as[asid].umem)
> >                 goto unlock;
> >
> >         ret =3D -EINVAL;
> > -       if (!dev->as.domain)
> > +       if (!dev->as[asid].domain)
> >                 goto unlock;
> >
> > -       if (dev->as.umem->iova !=3D iova || size !=3D dev->as.domain->b=
ounce_size)
> > +       if (dev->as[asid].umem->iova !=3D iova ||
> > +           size !=3D dev->as[asid].domain->bounce_size)
> >                 goto unlock;
> >
> > -       vduse_domain_remove_user_bounce_pages(dev->as.domain);
> > -       unpin_user_pages_dirty_lock(dev->as.umem->pages,
> > -                                   dev->as.umem->npages, true);
> > -       atomic64_sub(dev->as.umem->npages, &dev->as.umem->mm->pinned_vm=
);
> > -       mmdrop(dev->as.umem->mm);
> > -       vfree(dev->as.umem->pages);
> > -       kfree(dev->as.umem);
> > -       dev->as.umem =3D NULL;
> > +       vduse_domain_remove_user_bounce_pages(dev->as[asid].domain);
> > +       unpin_user_pages_dirty_lock(dev->as[asid].umem->pages,
> > +                                   dev->as[asid].umem->npages, true);
> > +       atomic64_sub(dev->as[asid].umem->npages, &dev->as[asid].umem->m=
m->pinned_vm);
> > +       mmdrop(dev->as[asid].umem->mm);
> > +       vfree(dev->as[asid].umem->pages);
> > +       kfree(dev->as[asid].umem);
> > +       dev->as[asid].umem =3D NULL;
>
> We can avoid those changeset if we do those in the previous correctly
> as it said it would make as an array.
>

I'm not following it. Is that different from squashing this patch with
the previous one? I'm ok with doing it, but this changes are needed
either way.

> >         ret =3D 0;
> >  unlock:
> > -       mutex_unlock(&dev->as.mem_lock);
> > +       mutex_unlock(&dev->as[asid].mem_lock);
> >         return ret;
> >  }
> >
> >  static int vduse_dev_reg_umem(struct vduse_dev *dev,
> > -                             u64 iova, u64 uaddr, u64 size)
> > +                             u32 asid, u64 iova, u64 uaddr, u64 size)
> >  {
> >         struct page **page_list =3D NULL;
> >         struct vduse_umem *umem =3D NULL;
> > @@ -1115,14 +1194,14 @@ static int vduse_dev_reg_umem(struct vduse_dev =
*dev,
> >         unsigned long npages, lock_limit;
> >         int ret;
> >
> > -       if (!dev->as.domain || !dev->as.domain->bounce_map ||
> > -           size !=3D dev->as.domain->bounce_size ||
> > +       if (!dev->as[asid].domain || !dev->as[asid].domain->bounce_map =
||
> > +           size !=3D dev->as[asid].domain->bounce_size ||
> >             iova !=3D 0 || uaddr & ~PAGE_MASK)
> >                 return -EINVAL;
> >
> > -       mutex_lock(&dev->as.mem_lock);
> > +       mutex_lock(&dev->as[asid].mem_lock);
> >         ret =3D -EEXIST;
> > -       if (dev->as.umem)
> > +       if (dev->as[asid].umem)
> >                 goto unlock;
> >
> >         ret =3D -ENOMEM;
> > @@ -1146,7 +1225,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
ev,
> >                 goto out;
> >         }
> >
> > -       ret =3D vduse_domain_add_user_bounce_pages(dev->as.domain,
> > +       ret =3D vduse_domain_add_user_bounce_pages(dev->as[asid].domain=
,
> >                                                  page_list, pinned);
> >         if (ret)
> >                 goto out;
> > @@ -1159,7 +1238,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
ev,
> >         umem->mm =3D current->mm;
> >         mmgrab(current->mm);
> >
> > -       dev->as.umem =3D umem;
> > +       dev->as[asid].umem =3D umem;
> >  out:
> >         if (ret && pinned > 0)
> >                 unpin_user_pages(page_list, pinned);
> > @@ -1170,7 +1249,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
ev,
> >                 vfree(page_list);
> >                 kfree(umem);
> >         }
> > -       mutex_unlock(&dev->as.mem_lock);
> > +       mutex_unlock(&dev->as[asid].mem_lock);
> >         return ret;
> >  }
> >
> > @@ -1202,47 +1281,66 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >
> >         switch (cmd) {
> >         case VDUSE_IOTLB_GET_FD: {
> > -               struct vduse_iotlb_entry entry;
> > +               struct vduse_iotlb_entry_v2 entry;
> >                 struct vhost_iotlb_map *map;
> >                 struct vdpa_map_file *map_file;
> >                 struct file *f =3D NULL;
> > +               u32 asid;
> >
> >                 ret =3D -EFAULT;
> > -               if (copy_from_user(&entry, argp, sizeof(entry)))
> > -                       break;
> > +               if (dev->api_version >=3D VDUSE_API_VERSION_1) {
> > +                       if (copy_from_user(&entry, argp, sizeof(entry))=
)
> > +                               break;
> > +               } else {
> > +                       entry.asid =3D 0;
> > +                       if (copy_from_user(&entry.v1, argp,
> > +                                          sizeof(entry.v1)))
> > +                               break;
> > +               }
> >
> >                 ret =3D -EINVAL;
> > -               if (entry.start > entry.last)
> > +               if (entry.v1.start > entry.v1.last)
> > +                       break;
> > +
> > +               if (entry.asid >=3D dev->nas)
> >                         break;
> >
> >                 read_lock(&dev->domain_lock);
> > -               if (!dev->as.domain) {
> > +               asid =3D array_index_nospec(entry.asid, dev->nas);
> > +               if (!dev->as[asid].domain) {
> >                         read_unlock(&dev->domain_lock);
> >                         break;
> >                 }
> > -               spin_lock(&dev->as.domain->iotlb_lock);
> > -               map =3D vhost_iotlb_itree_first(dev->as.domain->iotlb,
> > -                                             entry.start, entry.last);
> > +               spin_lock(&dev->as[asid].domain->iotlb_lock);
> > +               map =3D vhost_iotlb_itree_first(dev->as[asid].domain->i=
otlb,
> > +                                             entry.v1.start, entry.v1.=
last);
> >                 if (map) {
> >                         map_file =3D (struct vdpa_map_file *)map->opaqu=
e;
> >                         f =3D get_file(map_file->file);
> > -                       entry.offset =3D map_file->offset;
> > -                       entry.start =3D map->start;
> > -                       entry.last =3D map->last;
> > -                       entry.perm =3D map->perm;
> > +                       entry.v1.offset =3D map_file->offset;
> > +                       entry.v1.start =3D map->start;
> > +                       entry.v1.last =3D map->last;
> > +                       entry.v1.perm =3D map->perm;
> >                 }
> > -               spin_unlock(&dev->as.domain->iotlb_lock);
> > +               spin_unlock(&dev->as[asid].domain->iotlb_lock);
> >                 read_unlock(&dev->domain_lock);
> >                 ret =3D -EINVAL;
> >                 if (!f)
> >                         break;
> >
> >                 ret =3D -EFAULT;
> > -               if (copy_to_user(argp, &entry, sizeof(entry))) {
> > +               if (dev->api_version >=3D VDUSE_API_VERSION_1)
> > +                       ret =3D copy_to_user(argp, &entry,
> > +                                          sizeof(entry));
> > +               else
> > +                       ret =3D copy_to_user(argp, &entry.v1,
> > +                                          sizeof(entry.v1));
> > +
> > +               if (ret) {
> >                         fput(f);
> >                         break;
> >                 }
> > -               ret =3D receive_fd(f, NULL, perm_to_file_flags(entry.pe=
rm));
> > +               ret =3D receive_fd(f, NULL, perm_to_file_flags(entry.v1=
.perm));
>
> Nit: if we copy_from_user() twice and stick entry for v1 format, we
> can avoid a lot of lines of changes.
>

Let me draft something and put it as a reply here to check I'm
understanding your proposal.

> >                 fput(f);
> >                 break;
> >         }
> > @@ -1384,6 +1482,7 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
> >         }
> >         case VDUSE_IOTLB_REG_UMEM: {
> >                 struct vduse_iova_umem umem;
> > +               u32 asid;
> >
> >                 ret =3D -EFAULT;
> >                 if (copy_from_user(&umem, argp, sizeof(umem)))
> > @@ -1391,17 +1490,21 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >
> >                 ret =3D -EINVAL;
> >                 if (!is_mem_zero((const char *)umem.reserved,
> > -                                sizeof(umem.reserved)))
> > +                                sizeof(umem.reserved)) ||
> > +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> > +                    umem.asid !=3D 0) || umem.asid >=3D dev->nas)
> >                         break;
> >
> >                 write_lock(&dev->domain_lock);
> > -               ret =3D vduse_dev_reg_umem(dev, umem.iova,
> > +               asid =3D array_index_nospec(umem.asid, dev->nas);
> > +               ret =3D vduse_dev_reg_umem(dev, asid, umem.iova,
> >                                          umem.uaddr, umem.size);
> >                 write_unlock(&dev->domain_lock);
> >                 break;
> >         }
> >         case VDUSE_IOTLB_DEREG_UMEM: {
> >                 struct vduse_iova_umem umem;
> > +               u32 asid;
> >
> >                 ret =3D -EFAULT;
> >                 if (copy_from_user(&umem, argp, sizeof(umem)))
> > @@ -1409,10 +1512,15 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >
> >                 ret =3D -EINVAL;
> >                 if (!is_mem_zero((const char *)umem.reserved,
> > -                                sizeof(umem.reserved)))
> > +                                sizeof(umem.reserved)) ||
> > +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> > +                    umem.asid !=3D 0) ||
> > +                    umem.asid >=3D dev->nas)
> >                         break;
> > +
> >                 write_lock(&dev->domain_lock);
> > -               ret =3D vduse_dev_dereg_umem(dev, umem.iova,
> > +               asid =3D array_index_nospec(umem.asid, dev->nas);
> > +               ret =3D vduse_dev_dereg_umem(dev, asid, umem.iova,
> >                                            umem.size);
> >                 write_unlock(&dev->domain_lock);
> >                 break;
> > @@ -1420,6 +1528,7 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
> >         case VDUSE_IOTLB_GET_INFO: {
> >                 struct vduse_iova_info info;
> >                 struct vhost_iotlb_map *map;
> > +               u32 asid;
> >
> >                 ret =3D -EFAULT;
> >                 if (copy_from_user(&info, argp, sizeof(info)))
> > @@ -1433,23 +1542,31 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >                                  sizeof(info.reserved)))
> >                         break;
> >
> > +               if (dev->api_version < VDUSE_API_VERSION_1) {
> > +                       if (info.asid)
> > +                               break;
> > +               } else if (info.asid >=3D dev->nas)
> > +                       break;
> > +
> >                 read_lock(&dev->domain_lock);
> > -               if (!dev->as.domain) {
> > +               asid =3D array_index_nospec(info.asid, dev->nas);
> > +               if (!dev->as[asid].domain) {
> >                         read_unlock(&dev->domain_lock);
> >                         break;
> >                 }
> > -               spin_lock(&dev->as.domain->iotlb_lock);
> > -               map =3D vhost_iotlb_itree_first(dev->as.domain->iotlb,
> > +               spin_lock(&dev->as[asid].domain->iotlb_lock);
> > +               map =3D vhost_iotlb_itree_first(dev->as[asid].domain->i=
otlb,
> >                                               info.start, info.last);
> >                 if (map) {
> >                         info.start =3D map->start;
> >                         info.last =3D map->last;
> >                         info.capability =3D 0;
> > -                       if (dev->as.domain->bounce_map && map->start =
=3D=3D 0 &&
> > -                           map->last =3D=3D dev->as.domain->bounce_siz=
e - 1)
> > +                       if (dev->as[asid].domain->bounce_map &&
> > +                           map->start =3D=3D 0 &&
> > +                           map->last =3D=3D dev->as[asid].domain->boun=
ce_size - 1)
> >                                 info.capability |=3D VDUSE_IOVA_CAP_UME=
M;
> >                 }
> > -               spin_unlock(&dev->as.domain->iotlb_lock);
> > +               spin_unlock(&dev->as[asid].domain->iotlb_lock);
> >                 read_unlock(&dev->domain_lock);
> >                 if (!map)
> >                         break;
> > @@ -1474,8 +1591,10 @@ static int vduse_dev_release(struct inode *inode=
, struct file *file)
> >         struct vduse_dev *dev =3D file->private_data;
> >
> >         write_lock(&dev->domain_lock);
> > -       if (dev->as.domain)
> > -               vduse_dev_dereg_umem(dev, 0, dev->as.domain->bounce_siz=
e);
> > +       for (int i =3D 0; i < dev->nas; i++)
> > +               if (dev->as[i].domain)
> > +                       vduse_dev_dereg_umem(dev, i, 0,
> > +                                            dev->as[i].domain->bounce_=
size);
> >         write_unlock(&dev->domain_lock);
> >         spin_lock(&dev->msg_lock);
> >         /* Make sure the inflight messages can processed after reconnce=
ction */
> > @@ -1694,7 +1813,6 @@ static struct vduse_dev *vduse_dev_create(void)
> >                 return NULL;
> >
> >         mutex_init(&dev->lock);
> > -       mutex_init(&dev->as.mem_lock);
> >         rwlock_init(&dev->domain_lock);
> >         spin_lock_init(&dev->msg_lock);
> >         INIT_LIST_HEAD(&dev->send_list);
> > @@ -1745,8 +1863,11 @@ static int vduse_destroy_dev(char *name)
> >         idr_remove(&vduse_idr, dev->minor);
> >         kvfree(dev->config);
> >         vduse_dev_deinit_vqs(dev);
> > -       if (dev->as.domain)
> > -               vduse_domain_destroy(dev->as.domain);
> > +       for (int i =3D 0; i < dev->nas; i++) {
> > +               if (dev->as[i].domain)
> > +                       vduse_domain_destroy(dev->as[i].domain);
> > +       }
> > +       kfree(dev->as);
> >         kfree(dev->name);
> >         kfree(dev->groups);
> >         vduse_dev_destroy(dev);
> > @@ -1793,12 +1914,16 @@ static bool vduse_validate_config(struct vduse_=
dev_config *config,
> >                          sizeof(config->reserved)))
> >                 return false;
> >
> > -       if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> > +       if (api_version < VDUSE_API_VERSION_1 &&
> > +           (config->ngroups || config->nas))
> >                 return false;
> >
> >         if (api_version >=3D VDUSE_API_VERSION_1 && config->ngroups > 0=
xffff)
> >                 return false;
> >
> > +       if (api_version >=3D VDUSE_API_VERSION_1 && config->nas > 0xfff=
f)
> > +               return false;
> > +
> >         if (config->vq_align > PAGE_SIZE)
> >                 return false;
> >
> > @@ -1862,7 +1987,8 @@ static ssize_t bounce_size_store(struct device *d=
evice,
> >
> >         ret =3D -EPERM;
> >         write_lock(&dev->domain_lock);
> > -       if (dev->as.domain)
> > +       /* Assuming that if the first domain is allocated, all are allo=
cated */
> > +       if (dev->as[0].domain)
> >                 goto unlock;
> >
> >         ret =3D kstrtouint(buf, 10, &bounce_size);
> > @@ -1923,6 +2049,13 @@ static int vduse_create_dev(struct vduse_dev_con=
fig *config,
> >         for (u32 i =3D 0; i < dev->ngroups; ++i)
> >                 dev->groups[i].dev =3D dev;
> >
> > +       dev->nas =3D (dev->api_version < 1) ? 1 : (config->nas ?: 1);
> > +       dev->as =3D kcalloc(dev->nas, sizeof(dev->as[0]), GFP_KERNEL);
> > +       if (!dev->as)
> > +               goto err_as;
> > +       for (int i =3D 0; i < dev->nas; i++)
> > +               mutex_init(&dev->as[i].mem_lock);
> > +
> >         dev->name =3D kstrdup(config->name, GFP_KERNEL);
> >         if (!dev->name)
> >                 goto err_str;
> > @@ -1959,6 +2092,8 @@ static int vduse_create_dev(struct vduse_dev_conf=
ig *config,
> >  err_idr:
> >         kfree(dev->name);
> >  err_str:
> > +       kfree(dev->as);
> > +err_as:
> >         kfree(dev->groups);
> >  err_vq_groups:
> >         vduse_dev_destroy(dev);
> > @@ -2084,7 +2219,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *=
dev, const char *name)
> >
> >         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> >                                  &vduse_vdpa_config_ops, &vduse_map_ops=
,
> > -                                dev->ngroups, 1, name, true);
> > +                                dev->ngroups, dev->nas, name, true);
> >         if (IS_ERR(vdev))
> >                 return PTR_ERR(vdev);
> >
> > @@ -2113,11 +2248,20 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *m=
dev, const char *name,
> >                 return ret;
> >
> >         write_lock(&dev->domain_lock);
> > -       if (!dev->as.domain)
> > -               dev->as.domain =3D vduse_domain_create(VDUSE_IOVA_SIZE =
- 1,
> > -                                                 dev->bounce_size);
> > +       ret =3D 0;
> > +
> > +       for (int i =3D 0; i < dev->nas; ++i) {
> > +               dev->as[i].domain =3D vduse_domain_create(VDUSE_IOVA_SI=
ZE - 1,
> > +                                                       dev->bounce_siz=
e);
> > +               if (!dev->as[i].domain) {
> > +                       ret =3D -ENOMEM;
> > +                       for (int j =3D 0; j < i; ++j)
> > +                               vduse_domain_destroy(dev->as[j].domain)=
;
> > +               }
> > +       }
> > +
> >         write_unlock(&dev->domain_lock);
> > -       if (!dev->as.domain) {
> > +       if (ret =3D=3D -ENOMEM) {
> >                 put_device(&dev->vdev->vdpa.dev);
> >                 return -ENOMEM;
> >         }
> > @@ -2126,8 +2270,12 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *md=
ev, const char *name,
> >         if (ret) {
> >                 put_device(&dev->vdev->vdpa.dev);
> >                 write_lock(&dev->domain_lock);
> > -               vduse_domain_destroy(dev->as.domain);
> > -               dev->as.domain =3D NULL;
> > +               for (int i =3D 0; i < dev->nas; i++) {
> > +                       if (dev->as[i].domain) {
> > +                               vduse_domain_destroy(dev->as[i].domain)=
;
> > +                               dev->as[i].domain =3D NULL;
> > +                       }
> > +               }
> >                 write_unlock(&dev->domain_lock);
> >                 return ret;
> >         }
> > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > index a3d51cf6df3a..da73c3f2c280 100644
> > --- a/include/uapi/linux/vduse.h
> > +++ b/include/uapi/linux/vduse.h
> > @@ -47,7 +47,8 @@ struct vduse_dev_config {
> >         __u32 vq_num;
> >         __u32 vq_align;
> >         __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > -       __u32 reserved[12];
> > +       __u32 nas; /* if VDUSE_API_VERSION >=3D 1 */
> > +       __u32 reserved[11];
> >         __u32 config_size;
> >         __u8 config[];
> >  };
> > @@ -82,6 +83,18 @@ struct vduse_iotlb_entry {
> >         __u8 perm;
> >  };
> >
> > +/**
> > + * struct vduse_iotlb_entry_v2 - entry of IOTLB to describe one IOVA r=
egion in an ASID
> > + * @v1: the original vduse_iotlb_entry
> > + * @asid: address space ID of the IOVA region
> > + *
> > + * Structure used by VDUSE_IOTLB_GET_FD ioctl to find an overlapped IO=
VA region.
> > + */
> > +struct vduse_iotlb_entry_v2 {
> > +       struct vduse_iotlb_entry v1;
> > +       __u32 asid;
> > +};
> > +
> >  /*
> >   * Find the first IOVA region that overlaps with the range [start, las=
t]
> >   * and return the corresponding file descriptor. Return -EINVAL means =
the
> > @@ -166,6 +179,16 @@ struct vduse_vq_state_packed {
> >         __u16 last_used_idx;
> >  };
> >
> > +/**
> > + * struct vduse_vq_group - virtqueue group
> > + @ @group: Index of the virtqueue group
> > + * @asid: Address space ID of the group
> > + */
> > +struct vduse_vq_group_asid {
> > +       __u32 group;
> > +       __u32 asid;
> > +};
> > +
> >  /**
> >   * struct vduse_vq_info - information of a virtqueue
> >   * @index: virtqueue index
> > @@ -225,6 +248,7 @@ struct vduse_vq_eventfd {
> >   * @uaddr: start address of userspace memory, it must be aligned to pa=
ge size
> >   * @iova: start of the IOVA region
> >   * @size: size of the IOVA region
> > + * @asid: Address space ID of the IOVA region
> >   * @reserved: for future use, needs to be initialized to zero
> >   *
> >   * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
> > @@ -234,7 +258,8 @@ struct vduse_iova_umem {
> >         __u64 uaddr;
> >         __u64 iova;
> >         __u64 size;
> > -       __u64 reserved[3];
> > +       __u32 asid;
> > +       __u32 reserved[5];
> >  };
> >
> >  /* Register userspace memory for IOVA regions */
> > @@ -248,6 +273,7 @@ struct vduse_iova_umem {
> >   * @start: start of the IOVA region
> >   * @last: last of the IOVA region
> >   * @capability: capability of the IOVA region
> > + * @asid: Address space ID of the IOVA region, only if device API vers=
ion >=3D 1
> >   * @reserved: for future use, needs to be initialized to zero
> >   *
> >   * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
> > @@ -258,7 +284,8 @@ struct vduse_iova_info {
> >         __u64 last;
> >  #define VDUSE_IOVA_CAP_UMEM (1 << 0)
> >         __u64 capability;
> > -       __u64 reserved[3];
> > +       __u32 asid; /* Only if device API version >=3D 1 */
> > +       __u32 reserved[5];
> >  };
> >
> >  /*
> > @@ -280,6 +307,7 @@ enum vduse_req_type {
> >         VDUSE_GET_VQ_STATE,
> >         VDUSE_SET_STATUS,
> >         VDUSE_UPDATE_IOTLB,
> > +       VDUSE_SET_VQ_GROUP_ASID,
> >  };
> >
> >  /**
> > @@ -314,6 +342,18 @@ struct vduse_iova_range {
> >         __u64 last;
> >  };
> >
> > +/**
> > + * struct vduse_iova_range - IOVA range [start, last] if API_VERSION >=
=3D 1
> > + * @start: start of the IOVA range
> > + * @last: last of the IOVA range
> > + * @asid: address space ID of the IOVA range
> > + */
> > +struct vduse_iova_range_v2 {
> > +       __u64 start;
> > +       __u64 last;
> > +       __u32 asid;
> > +};
> > +
> >  /**
> >   * struct vduse_dev_request - control request
> >   * @type: request type
> > @@ -322,6 +362,8 @@ struct vduse_iova_range {
> >   * @vq_state: virtqueue state, only index field is available
> >   * @s: device status
> >   * @iova: IOVA range for updating
> > + * @iova_v2: IOVA range for updating if API_VERSION >=3D 1
> > + * @vq_group_asid: ASID of a virtqueue group
> >   * @padding: padding
> >   *
> >   * Structure used by read(2) on /dev/vduse/$NAME.
> > @@ -334,6 +376,9 @@ struct vduse_dev_request {
> >                 struct vduse_vq_state vq_state;
> >                 struct vduse_dev_status s;
> >                 struct vduse_iova_range iova;
> > +               /* Following members only if vduse api version >=3D 1 *=
/;
> > +               struct vduse_iova_range_v2 iova_v2;
> > +               struct vduse_vq_group_asid vq_group_asid;
> >                 __u32 padding[32];
> >         };
> >  };
> > --
> > 2.51.0
> >
>
> Thanks
>

