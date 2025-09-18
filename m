Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6226AE4
	for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 06:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758175659; cv=none; b=FWm0V5IOdiiLQWSXx8xIPSRhQTyzkmFRZZfNN1kNsFFANrGtiqWQnyzJHPCzC0XpyTAxWrWXxZoXzneTr+FcXxB5mJHI0EZyQcxuO6/WnVmzWfRJcOnTqB7dk3+x6MBJiaUOxRr5wzYxp0/HiPNHIMN1TgR9qUF/YijpLepcfrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758175659; c=relaxed/simple;
	bh=z4oIWm49i9xtxXDY0gFrQKRp5rHnEifMZCNxbQ74FIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIEghFpO5tkl5+9qt3d7z4bb6tfDDyuqlu1VJecAKAtxcUG5O7N8Sk1zivHPkD0iNp6ZA5Ab+dfqHF5iFX5G6PHBJbBulupmGf4tUF1C1mKMFJHm4Cs9HoQtuNRaC1JDtZYe/2PBe+sJFFQpTZfpU3lUTUBp0PiU5RXXSItGqcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bk/07kAW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bk/07kAW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758175656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o444ASJxqrVfQHq84e1V7Sy5rT5Ljlc+mdZwExnWJ/0=;
	b=Bk/07kAWZcOFfierHPjgWp3/QMSqlS5XxEdnB5aEW4kpXBC5sJvIM6vyYxJSpCIQk6SRw9
	CQybVQggPFNmtnTRkHimgpq/8mNqbUcGi3fSBiqqjxuyMW7StsaWjGR3YTkecKhu8655KY
	noasPX2maFddlpT2lg4pd7ey30J6YV0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-dW0iqeGCOCKQvaZ5J7Sinw-1; Thu, 18 Sep 2025 02:07:34 -0400
X-MC-Unique: dW0iqeGCOCKQvaZ5J7Sinw-1
X-Mimecast-MFC-AGG-ID: dW0iqeGCOCKQvaZ5J7Sinw_1758175654
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32dd3e922fdso873701a91.0
        for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 23:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758175654; x=1758780454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o444ASJxqrVfQHq84e1V7Sy5rT5Ljlc+mdZwExnWJ/0=;
        b=BMoh+rRRQh7uJM8+sJBdYrrVLvd65PALc1aieb9PKSio9vA/lz290+Y52Kdg+pP7Oe
         gdib2yz/cynne7SGdeFQRtxjMVno3dpVDmCpELuau1ZVP3u2h9mt78h912wGZx/VIt8u
         x1iMj39YG/c9egEN89V16LiOwbu1vOGaONBqrm2MEM7ASPWMaRFrO6UveB+Ziq6Asm0S
         6OfxIJn1g+Nwi4jw3HBfLfX0UOkZ0YFUe7UaIDmquorzNUPoAtlhXgIpueHoJKev6X34
         T5BaWec0RcxpWaC4IqohgS4cKNoqLn6fnEyXH9Jglt3ZKBigPNH4tKJpBewY4vhAhJTl
         +Mmg==
X-Forwarded-Encrypted: i=1; AJvYcCXcIZkDvE76ug/X6ziqTKfjw1KOd8x62+WEDK6BGJC9jq2BNyvbtCnLU6bNGteV93Hf7awXsiO8m2U3NOvDPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxO0CoO6wSLSl5biVngFR9xdXAdCosa12TUNSswX+xldso7N6XA
	CcW1gkKZ66RmDMxJh2iKVe9XnFl4xtTJmuZY0TPVNSHUMIarndHPXciIqUWST+d+sCCkINDbBul
	oiYS394FmMWj7PeMrQeVwkO1crU3fG92xkJgbAM4kf0uOajJJQOSV8Tyu6dt21vkG6fzUropHow
	JtP9XHKCsLfZzuy6qVZhfRLys/sMqCAeubdF/K8uj0a10=
X-Gm-Gg: ASbGnctzGt2xy0ymjnNZZs1OzvoYQlgxDdD5YSOV4oxJM9JCxR7klBYROCg9XmtNenk
	Mw1DuaHlo5LRM5JAPWicvsCgf3NQlpkw6PZMqWLp9ycpklOyAIFgkQOwLeaR306I7zPLOIpvbI1
	XwPPG2cS7qX6EEI/E5coMgOQ==
X-Received: by 2002:a17:90b:28c8:b0:32d:db5b:7636 with SMTP id 98e67ed59e1d1-32ee3f7452amr5738905a91.27.1758175653641;
        Wed, 17 Sep 2025 23:07:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExAPBsrTuDoGmrR3JV3sz9O4WehD7JhmWDN8YZcMf4tr4vSAKUj5cpeOeOPgqlgELLWAHn8XOBGD5tKkw9g6E=
X-Received: by 2002:a17:90b:28c8:b0:32d:db5b:7636 with SMTP id
 98e67ed59e1d1-32ee3f7452amr5738861a91.27.1758175653087; Wed, 17 Sep 2025
 23:07:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-7-eperezma@redhat.com>
 <CACGkMEu4F8Spw-=ve0w45CmJhEkBMtDdRCYNDorA6NxunkuDaw@mail.gmail.com> <CAJaqyWfqNX6E89Z4Yz373V6r1xLzJVNon5A_fCdU=79nAk6CRQ@mail.gmail.com>
In-Reply-To: <CAJaqyWfqNX6E89Z4Yz373V6r1xLzJVNon5A_fCdU=79nAk6CRQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Sep 2025 14:07:21 +0800
X-Gm-Features: AS18NWD-oGA5pEZ-yAnvzLuTjmUpiChIocyuHAObpnFK3NX5dTYS7mdw58eu8OU
Message-ID: <CACGkMEurRDttMmrKzA8Wc4afBZi7T8wbLMfFS1wAEgabbVbAtA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dU8cGHryi3n8WsChCiY2CPsn4iOk17W_dsGwycJSIYI_1758175654
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:41=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Sep 17, 2025 at 10:56=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Tue, Sep 16, 2025 at 9:09=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
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
> > > v2:
> > > * Convert the use of mutex to rwlock.
> > >
> > > RFC v3:
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
> > > RFC v2:
> > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
> > >   part of the struct is the same.
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 324 +++++++++++++++++++++------=
--
> > >  include/uapi/linux/vduse.h         |  51 ++++-
> > >  2 files changed, 284 insertions(+), 91 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index b45b1d22784f..06b7790380b7 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -93,6 +93,7 @@ struct vduse_as {
> > >  };
> > >
> > >  struct vduse_vq_group_int {
> > > +       struct vduse_iova_domain *domain;
> > >         struct vduse_dev *dev;
> >
> > This confuses me, I think it should be an asid. And the vduse_dev
> > pointer seems to be useless here.
> >
>
> The *dev pointer is used to take the rwlock, in case the vhost driver
> calls VHOST_VDPA_SET_GROUP_ASID (or equivalent) at the same time
> vduse_dev_sync_single_for_device (or _for_cpu, or equivalent) run.

Ok, but having it in a group seems odd. A better place is to move it to the=
 as?

>
> > >  };
> > >
> > > @@ -100,7 +101,7 @@ struct vduse_dev {
> > >         struct vduse_vdpa *vdev;
> > >         struct device *dev;
> > >         struct vduse_virtqueue **vqs;
> > > -       struct vduse_as as;
> > > +       struct vduse_as *as;
> > >         char *name;
> > >         struct mutex lock;
> > >         spinlock_t msg_lock;
> > > @@ -128,6 +129,7 @@ struct vduse_dev {
> > >         u32 vq_num;
> > >         u32 vq_align;
> > >         u32 ngroups;
> > > +       u32 nas;
> > >         struct vduse_vq_group_int *groups;
> > >         unsigned int bounce_size;
> > >         rwlock_t domain_lock;
> > > @@ -318,7 +320,7 @@ static int vduse_dev_set_status(struct vduse_dev =
*dev, u8 status)
> > >         return vduse_dev_msg_sync(dev, &msg);
> > >  }
> > >
> > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
> > >                                   u64 start, u64 last)
> > >  {
> > >         struct vduse_dev_msg msg =3D { 0 };
> > > @@ -327,8 +329,14 @@ static int vduse_dev_update_iotlb(struct vduse_d=
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
> > > @@ -440,14 +448,29 @@ static __poll_t vduse_dev_poll(struct file *fil=
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
> > > +       write_lock(&dev->domain_lock);
> > > +       dev->groups[group].domain =3D dev->as[asid].domain;
> >
> > I think it would be better to stick the group->as an indirection which
> > should be .
> >
> > dev->groups.asid =3D asid;
> >
> > Or
> >
> > dev->group->as =3D as;
> >
>
> That involves an extra memory jump for functions that may be in the
> hot path. I've not profiled it, but I'm ok with changing it that way
> if you prefer.

I think it would be better if we can change (see my reply in previous patch=
).

>
> > > +       write_unlock(&dev->domain_lock);
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
> > > @@ -621,6 +644,29 @@ static union virtio_map vduse_get_vq_map(struct =
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
> > > @@ -792,13 +838,13 @@ static int vduse_vdpa_set_map(struct vdpa_devic=
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
> > > @@ -841,6 +887,7 @@ static const struct vdpa_config_ops vduse_vdpa_co=
nfig_ops =3D {
> > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > >         .reset                  =3D vduse_vdpa_reset,
> > >         .set_map                =3D vduse_vdpa_set_map,
> > > +       .set_group_asid         =3D vduse_set_group_asid,
> > >         .get_vq_map             =3D vduse_get_vq_map,
> > >         .free                   =3D vduse_vdpa_free,
> > >  };
> > > @@ -850,9 +897,12 @@ static void vduse_dev_sync_single_for_device(uni=
on virtio_map token,
> > >                                              enum dma_data_direction =
dir)
> > >  {
> > >         struct vduse_dev *vdev =3D token.group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > +       struct vduse_iova_domain *domain;
> > >
> > > +       read_lock(&vdev->domain_lock);
> > > +       domain =3D token.group->domain;
> > >         vduse_domain_sync_single_for_device(domain, dma_addr, size, d=
ir);
> > > +       read_unlock(&vdev->domain_lock);
> > >  }
> > >
> > >  static void vduse_dev_sync_single_for_cpu(union virtio_map token,
> > > @@ -860,9 +910,12 @@ static void vduse_dev_sync_single_for_cpu(union =
virtio_map token,
> > >                                              enum dma_data_direction =
dir)
> > >  {
> > >         struct vduse_dev *vdev =3D token.group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > +       struct vduse_iova_domain *domain;
> > >
> > > +       read_lock(&vdev->domain_lock);
> > > +       domain =3D token.group->domain;
> >
> > I think the domain is better fetched via vduse_as.
> >
> > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir)=
;
> > > +       read_unlock(&vdev->domain_lock);
> > >  }
> > >
> > >  static dma_addr_t vduse_dev_map_page(union virtio_map token, struct =
page *page,
> > > @@ -871,9 +924,15 @@ static dma_addr_t vduse_dev_map_page(union virti=
o_map token, struct page *page,
> > >                                      unsigned long attrs)
> > >  {
> > >         struct vduse_dev *vdev =3D token.group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > +       struct vduse_iova_domain *domain;
> > > +       dma_addr_t r;
> > >
> > > -       return vduse_domain_map_page(domain, page, offset, size, dir,=
 attrs);
> > > +       read_lock(&vdev->domain_lock);
> > > +       domain =3D token.group->domain;
> > > +       r =3D vduse_domain_map_page(domain, page, offset, size, dir, =
attrs);
> > > +       read_unlock(&vdev->domain_lock);
> > > +
> > > +       return r;
> > >  }
> > >
> > >  static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t =
dma_addr,
> > > @@ -881,27 +940,31 @@ static void vduse_dev_unmap_page(union virtio_m=
ap token, dma_addr_t dma_addr,
> > >                                  unsigned long attrs)
> > >  {
> > >         struct vduse_dev *vdev =3D token.group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > +       struct vduse_iova_domain *domain;
> > >
> > > -       return vduse_domain_unmap_page(domain, dma_addr, size, dir, a=
ttrs);
> > > +       read_lock(&vdev->domain_lock);
> > > +       domain =3D token.group->domain;
> > > +       vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
> > > +       read_unlock(&vdev->domain_lock);
> > >  }
> > >
> > >  static void *vduse_dev_alloc_coherent(union virtio_map token, size_t=
 size,
> > >                                       dma_addr_t *dma_addr, gfp_t fla=
g)
> > >  {
> > >         struct vduse_dev *vdev =3D token.group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > +       struct vduse_iova_domain *domain;
> > >         unsigned long iova;
> > > -       void *addr;
> > > +       void *addr =3D NULL;
> > >
> > >         *dma_addr =3D DMA_MAPPING_ERROR;
> > > +       read_lock(&vdev->domain_lock);
> > > +       domain =3D token.group->domain;
> > >         addr =3D vduse_domain_alloc_coherent(domain, size,
> > >                                            (dma_addr_t *)&iova, flag)=
;
> > > -       if (!addr)
> > > -               return NULL;
> > > -
> > > -       *dma_addr =3D (dma_addr_t)iova;
> > > +       if (addr)
> > > +               *dma_addr =3D (dma_addr_t)iova;
> > >
> > > +       read_unlock(&vdev->domain_lock);
> > >         return addr;
> > >  }
> > >
> > > @@ -910,17 +973,26 @@ static void vduse_dev_free_coherent(union virti=
o_map token, size_t size,
> > >                                     unsigned long attrs)
> > >  {
> > >         struct vduse_dev *vdev =3D token.group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > +       struct vduse_iova_domain *domain;
> > >
> > > +       read_lock(&vdev->domain_lock);
> > > +       domain =3D token.group->domain;
> > >         vduse_domain_free_coherent(domain, size, vaddr, dma_addr, att=
rs);
> > > +       read_unlock(&vdev->domain_lock);
> > >  }
> > >
> > >  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t d=
ma_addr)
> > >  {
> > >         struct vduse_dev *vdev =3D token.group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > +       struct vduse_iova_domain *domain;
> > > +       size_t bounce_size;
> > >
> > > -       return dma_addr < domain->bounce_size;
> > > +       read_lock(&vdev->domain_lock);
> > > +       domain =3D token.group->domain;
> > > +       bounce_size =3D domain->bounce_size;
> > > +       read_unlock(&vdev->domain_lock);
> > > +
> > > +       return dma_addr < bounce_size;
> > >  }
> > >
> > >  static int vduse_dev_mapping_error(union virtio_map token, dma_addr_=
t dma_addr)
> > > @@ -933,9 +1005,15 @@ static int vduse_dev_mapping_error(union virtio=
_map token, dma_addr_t dma_addr)
> > >  static size_t vduse_dev_max_mapping_size(union virtio_map token)
> > >  {
> > >         struct vduse_dev *vdev =3D token.group->dev;
> > > -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> > > +       struct vduse_iova_domain *domain;
> > > +       size_t bounce_size;
> > > +
> > > +       read_lock(&vdev->domain_lock);
> > > +       domain =3D token.group->domain;
> > > +       bounce_size =3D domain->bounce_size;
> > > +       read_unlock(&vdev->domain_lock);
> > >
> > > -       return domain->bounce_size;
> > > +       return bounce_size;
> > >  }
> > >
> > >  static const struct virtio_map_ops vduse_map_ops =3D {
> > > @@ -1075,39 +1153,40 @@ static int vduse_dev_queue_irq_work(struct vd=
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
> >
> > We can avoid those changeset if we do those in the previous correctly
> > as it said it would make as an array.
> >
>
> I'm not following it. Is that different from squashing this patch with
> the previous one? I'm ok with doing it, but this changes are needed
> either way.

See my reply for whether we need to make it as an array in the last
patch. I meant basically we only need to change them once, but this
series touches this twice.

Thanks

