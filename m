Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887F92EA48F
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126900; cv=none; b=kqdCSbPkN0oXUUZBL+wsnVzTVN0LJHj6OAG0uu1s532K9XcBA4REcbYuoGeO2e/GD1H5w+KKxqoEb6ztLhSfOc1v/A3GC8Db9Gh3Gg1KxPDv8URLXRI5kL2j+HBHKMQhnIKvgnm7HGe6I6RCsaiRud/lFYHHqZ53j+1Hg0YgvFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126900; c=relaxed/simple;
	bh=Nqrg7BEPmR8SpccfoVvcGe8E4CqQjrFrdguvbskgNZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmUw1vjm63jXdR94EzTdSvv94vkOCu+TjuxodDclsGDmvVwOvGFNkn/U+rHQfnTk9o+bv0JleKC6ITG4A8mzxXLsVSFfRvO+ZSb8hzUrtwfVTi/QHIYt65dZUtN/zoT5fVPSkXqgqRD6LocamTmbab/U4u54W53uHWGbP6R+z6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1ieLqeZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1ieLqeZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758126897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=penqf9mEPvUX67JxoN3qO7Pg3bwnXjQ40y431xRBXsM=;
	b=S1ieLqeZUZPFCALAPiGjcKYjXl5SLDXaiuB4bzw0Y3NDX5LEmB0uBNEZIrF9c+a6w0zo9h
	RX+QKTC6B3knNphwcb3CuZsGtkIL9i/cWHocXMZXwWhUeJMiKYxP1YYkxu0Z93sKeTp3R2
	XReLMHcrLE/IoDfpqzbG+hgRV6NLVRg=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-0DMswfB_OWqVgpCw-x5Kkw-1; Wed, 17 Sep 2025 12:34:54 -0400
X-MC-Unique: 0DMswfB_OWqVgpCw-x5Kkw-1
X-Mimecast-MFC-AGG-ID: 0DMswfB_OWqVgpCw-x5Kkw_1758126894
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-6248c27f021so3402021d50.0
        for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 09:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758126894; x=1758731694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=penqf9mEPvUX67JxoN3qO7Pg3bwnXjQ40y431xRBXsM=;
        b=ZpS3ThtisF5Y/m6hTDNMKkHPCEX5Y2JDQlZtVtMxD3Lea7I5uT+pRaYn5OidLT3Sfg
         p7kWKcujkfY9Ij8f2wIRWAhIz4m9+MLuL3caIsQoFLMKiusoBbxSSfDaXsAMJlripDs/
         wJSByr9H33kY+B3rRiIrSVgnaxcf5A8MygVlafI7j9+0jnkZGYa6Utvu8qL6bNk+PsyJ
         9zbjW52cw7zESNcQL0LDR6N2Gxfc7in4Cph0HKEgmlA7Aph8V/suy5X0mOhB7UtBU3R0
         PZVpuxkf7Fw6pvCT2+CtEPY6BeJnV5tN1lCDF9f5KP/toSezyoeLt52EPrUFc/IXr8nl
         t1xA==
X-Forwarded-Encrypted: i=1; AJvYcCX3iTmrwppRoxPFqWy1Ga4ltPKNgp46k3idnvXiUVtusb695xmsvajpikdvSjUEfETytAz1A2MgwAVknLqhdg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPBoVw/75qI9oFQ7topSj7GWUtZ9Mk/xs6z5U2C83p2t8QgyiS
	CJGutFYKY3QBSA6vM3BN5SzSLwERpWNRXivH4I5fxESOPlyhYb1kCYyLh6XeWSKDnabS7X4MGBQ
	ctVS7NDhASyCLM5d391OzNONfytnHKbLdmomUlsBtLCCAgAc7FMY5bgmkpJ+KNHuFRU/YfLY6hD
	4GfObhEzqeTG6F78FpQcPCnyV1fAC71LOnap2oDlJ+0vI=
X-Gm-Gg: ASbGncvrubT05qPeOYPabiahsOuLg8TzUYKUdNevzmVgTN5VNOHNkmKxhlXrmDws9D3
	Q923zlvv77ae3vjqT3coh95PI+xibz9G4M/x+7G4Ab+0pyJD/Isq27zFqaIvMdU4s2F3idMtHSh
	V+ibdKsVg6AXnvdNu7rNtK/SgCl3BGlO80ia4s+DUQqBZb/Iiwv8oArQHBXMdh1wt3yWvtAb//b
	+BFGeOi
X-Received: by 2002:a53:b990:0:b0:629:6385:46f8 with SMTP id 956f58d0204a3-633b05d3fe9mr1937994d50.7.1758126893335;
        Wed, 17 Sep 2025 09:34:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHhxJTFPsBA2sDPpAoH+GOW5whkxtdxAHKX+PcGFOmp2wJS16tascp0z8u7i8/wNkwB9DlwAmmqT8fbW7LxZI=
X-Received: by 2002:a53:b990:0:b0:629:6385:46f8 with SMTP id
 956f58d0204a3-633b05d3fe9mr1937962d50.7.1758126892647; Wed, 17 Sep 2025
 09:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-6-eperezma@redhat.com>
 <CACGkMEtp61-OB2EpuMY+SWd2b1yShGwfTCNuw9xtMC5YdkpQkQ@mail.gmail.com>
In-Reply-To: <CACGkMEtp61-OB2EpuMY+SWd2b1yShGwfTCNuw9xtMC5YdkpQkQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 17 Sep 2025 18:34:14 +0200
X-Gm-Features: AS18NWB2VnP9VxBSPA0jfqJk6266N59qCFHI2dKbHeth1yuxMjq1G2yfhMlxS9U
Message-ID: <CAJaqyWdu9O_q7dzXk98XcUE=wT1J3gA89j_3DAEJ7y1p_V+c5w@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] vduse: create vduse_as to make it an array
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TbJHN6MZu-SjF17m-EUtPyjn7sURnIRrLmRXZqxqng4_1758126894
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:46=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Tue, Sep 16, 2025 at 9:09=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > This is a first step so we can make more than one different address
> > spaces.  No change on the colde flow intended.
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
>
> Sorry, I think I found something new.
>
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 114 +++++++++++++++--------------
> >  1 file changed, 59 insertions(+), 55 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 9c12ae72abc2..b45b1d22784f 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -86,6 +86,12 @@ struct vduse_umem {
> >         struct mm_struct *mm;
> >  };
> >
> > +struct vduse_as {
> > +       struct vduse_iova_domain *domain;
> > +       struct vduse_umem *umem;
> > +       struct mutex mem_lock;
> > +};
> > +
> >  struct vduse_vq_group_int {
> >         struct vduse_dev *dev;
>
> I would expect this has an indirection for as. E.g unsigned int as;
>

This is a change from the previous commit and *dev is needed for
taking the rwlock of the vq_group -> asid relation anyway, as function
like vduse_dev_sync_single_for_cpu could run at the same time as
VHOST_VDPA_SET_GROUP_ASID.

I'm ok with adding the "unsigned int as" indirection but it involves
memory walking that is not needed.

> >  };
> > @@ -94,7 +100,7 @@ struct vduse_dev {
> >         struct vduse_vdpa *vdev;
> >         struct device *dev;
> >         struct vduse_virtqueue **vqs;
> > -       struct vduse_iova_domain *domain;
> > +       struct vduse_as as;
>
> This needs to be an array per title:
>
> "vduse: create vduse_as to make it an array"
>

I meant "to make it an array in next patches". Would it work if I just
change the patch subject to:

"create vduse_as to contain per-as members"

And then specify that it will be converted to an array later in the
patch message? Or do you prefer me just to squash the patches?

> >         char *name;
> >         struct mutex lock;
> >         spinlock_t msg_lock;
> > @@ -122,9 +128,7 @@ struct vduse_dev {
> >         u32 vq_num;
> >         u32 vq_align;
> >         u32 ngroups;
> > -       struct vduse_umem *umem;
> >         struct vduse_vq_group_int *groups;
> > -       struct mutex mem_lock;
> >         unsigned int bounce_size;
> >         rwlock_t domain_lock;
> >  };
> > @@ -439,7 +443,7 @@ static __poll_t vduse_dev_poll(struct file *file, p=
oll_table *wait)
> >  static void vduse_dev_reset(struct vduse_dev *dev)
> >  {
> >         int i;
> > -       struct vduse_iova_domain *domain =3D dev->domain;
> > +       struct vduse_iova_domain *domain =3D dev->as.domain;
>
> This should be an iteration of all address spaces?
>

Yes, it will be in next patches.

The rest of the comments have the same reply actually, as this patch
just prepares the struct to make it an array in patches as small as
possible.

> >
> >         /* The coherent mappings are handled in vduse_dev_free_coherent=
() */
> >         if (domain && domain->bounce_map)
> > @@ -788,13 +792,13 @@ static int vduse_vdpa_set_map(struct vdpa_device =
*vdpa,
> >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> >         int ret;
> >
> > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > +       ret =3D vduse_domain_set_map(dev->as.domain, iotlb);
>
> The as should be indexed by asid here or I think i miss something. Or
> at least fail with asid !=3D 0?
>
> >         if (ret)
> >                 return ret;
> >
> >         ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> >         if (ret) {
> > -               vduse_domain_clear_map(dev->domain, iotlb);
> > +               vduse_domain_clear_map(dev->as.domain, iotlb);
> >                 return ret;
> >         }
> >
> > @@ -846,7 +850,7 @@ static void vduse_dev_sync_single_for_device(union =
virtio_map token,
> >                                              enum dma_data_direction di=
r)
> >  {
> >         struct vduse_dev *vdev =3D token.group->dev;
> > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > +       struct vduse_iova_domain *domain =3D vdev->as.domain;
>
> The address space should be fetched from the virtqueue group instead
> of the hard-coded one.
>
> >
> >         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir=
);
> >  }
> > @@ -856,7 +860,7 @@ static void vduse_dev_sync_single_for_cpu(union vir=
tio_map token,
> >                                              enum dma_data_direction di=
r)
> >  {
> >         struct vduse_dev *vdev =3D token.group->dev;
> > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > +       struct vduse_iova_domain *domain =3D vdev->as.domain;
> >
> >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
> >  }
> > @@ -867,7 +871,7 @@ static dma_addr_t vduse_dev_map_page(union virtio_m=
ap token, struct page *page,
> >                                      unsigned long attrs)
> >  {
> >         struct vduse_dev *vdev =3D token.group->dev;
> > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > +       struct vduse_iova_domain *domain =3D vdev->as.domain;
> >
> >         return vduse_domain_map_page(domain, page, offset, size, dir, a=
ttrs);
> >  }
> > @@ -877,7 +881,7 @@ static void vduse_dev_unmap_page(union virtio_map t=
oken, dma_addr_t dma_addr,
> >                                  unsigned long attrs)
> >  {
> >         struct vduse_dev *vdev =3D token.group->dev;
> > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > +       struct vduse_iova_domain *domain =3D vdev->as.domain;
> >
> >         return vduse_domain_unmap_page(domain, dma_addr, size, dir, att=
rs);
> >  }
> > @@ -886,7 +890,7 @@ static void *vduse_dev_alloc_coherent(union virtio_=
map token, size_t size,
> >                                       dma_addr_t *dma_addr, gfp_t flag)
> >  {
> >         struct vduse_dev *vdev =3D token.group->dev;
> > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > +       struct vduse_iova_domain *domain =3D vdev->as.domain;
> >         unsigned long iova;
> >         void *addr;
> >
> > @@ -906,7 +910,7 @@ static void vduse_dev_free_coherent(union virtio_ma=
p token, size_t size,
> >                                     unsigned long attrs)
> >  {
> >         struct vduse_dev *vdev =3D token.group->dev;
> > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > +       struct vduse_iova_domain *domain =3D vdev->as.domain;
> >
> >         vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs=
);
> >  }
> > @@ -914,7 +918,7 @@ static void vduse_dev_free_coherent(union virtio_ma=
p token, size_t size,
> >  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma=
_addr)
> >  {
> >         struct vduse_dev *vdev =3D token.group->dev;
> > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > +       struct vduse_iova_domain *domain =3D vdev->as.domain;
> >
> >         return dma_addr < domain->bounce_size;
> >  }
> > @@ -929,7 +933,7 @@ static int vduse_dev_mapping_error(union virtio_map=
 token, dma_addr_t dma_addr)
> >  static size_t vduse_dev_max_mapping_size(union virtio_map token)
> >  {
> >         struct vduse_dev *vdev =3D token.group->dev;
> > -       struct vduse_iova_domain *domain =3D vdev->domain;
> > +       struct vduse_iova_domain *domain =3D vdev->as.domain;
> >
> >         return domain->bounce_size;
> >  }
> > @@ -1076,29 +1080,29 @@ static int vduse_dev_dereg_umem(struct vduse_de=
v *dev,
> >  {
> >         int ret;
> >
> > -       mutex_lock(&dev->mem_lock);
> > +       mutex_lock(&dev->as.mem_lock);
> >         ret =3D -ENOENT;
> > -       if (!dev->umem)
> > +       if (!dev->as.umem)
> >                 goto unlock;
> >
> >         ret =3D -EINVAL;
> > -       if (!dev->domain)
> > +       if (!dev->as.domain)
> >                 goto unlock;
> >
> > -       if (dev->umem->iova !=3D iova || size !=3D dev->domain->bounce_=
size)
> > +       if (dev->as.umem->iova !=3D iova || size !=3D dev->as.domain->b=
ounce_size)
>
> I think it would be better to assume ASID =3D 0 here to ease the future e=
xtension.
>
> >                 goto unlock;
> >
> > -       vduse_domain_remove_user_bounce_pages(dev->domain);
> > -       unpin_user_pages_dirty_lock(dev->umem->pages,
> > -                                   dev->umem->npages, true);
> > -       atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
> > -       mmdrop(dev->umem->mm);
> > -       vfree(dev->umem->pages);
> > -       kfree(dev->umem);
> > -       dev->umem =3D NULL;
> > +       vduse_domain_remove_user_bounce_pages(dev->as.domain);
> > +       unpin_user_pages_dirty_lock(dev->as.umem->pages,
> > +                                   dev->as.umem->npages, true);
> > +       atomic64_sub(dev->as.umem->npages, &dev->as.umem->mm->pinned_vm=
);
> > +       mmdrop(dev->as.umem->mm);
> > +       vfree(dev->as.umem->pages);
> > +       kfree(dev->as.umem);
> > +       dev->as.umem =3D NULL;
> >         ret =3D 0;
> >  unlock:
> > -       mutex_unlock(&dev->mem_lock);
> > +       mutex_unlock(&dev->as.mem_lock);
> >         return ret;
> >  }
> >
> > @@ -1111,14 +1115,14 @@ static int vduse_dev_reg_umem(struct vduse_dev =
*dev,
> >         unsigned long npages, lock_limit;
> >         int ret;
> >
> > -       if (!dev->domain || !dev->domain->bounce_map ||
> > -           size !=3D dev->domain->bounce_size ||
> > +       if (!dev->as.domain || !dev->as.domain->bounce_map ||
> > +           size !=3D dev->as.domain->bounce_size ||
> >             iova !=3D 0 || uaddr & ~PAGE_MASK)
> >                 return -EINVAL;
> >
> > -       mutex_lock(&dev->mem_lock);
> > +       mutex_lock(&dev->as.mem_lock);
> >         ret =3D -EEXIST;
> > -       if (dev->umem)
> > +       if (dev->as.umem)
> >                 goto unlock;
> >
> >         ret =3D -ENOMEM;
> > @@ -1142,7 +1146,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
ev,
> >                 goto out;
> >         }
> >
> > -       ret =3D vduse_domain_add_user_bounce_pages(dev->domain,
> > +       ret =3D vduse_domain_add_user_bounce_pages(dev->as.domain,
> >                                                  page_list, pinned);
> >         if (ret)
> >                 goto out;
> > @@ -1155,7 +1159,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
ev,
> >         umem->mm =3D current->mm;
> >         mmgrab(current->mm);
> >
> > -       dev->umem =3D umem;
> > +       dev->as.umem =3D umem;
> >  out:
> >         if (ret && pinned > 0)
> >                 unpin_user_pages(page_list, pinned);
> > @@ -1166,7 +1170,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
ev,
> >                 vfree(page_list);
> >                 kfree(umem);
> >         }
> > -       mutex_unlock(&dev->mem_lock);
> > +       mutex_unlock(&dev->as.mem_lock);
> >         return ret;
> >  }
> >
> > @@ -1212,12 +1216,12 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >                         break;
> >
> >                 read_lock(&dev->domain_lock);
> > -               if (!dev->domain) {
> > +               if (!dev->as.domain) {
> >                         read_unlock(&dev->domain_lock);
> >                         break;
> >                 }
> > -               spin_lock(&dev->domain->iotlb_lock);
> > -               map =3D vhost_iotlb_itree_first(dev->domain->iotlb,
> > +               spin_lock(&dev->as.domain->iotlb_lock);
> > +               map =3D vhost_iotlb_itree_first(dev->as.domain->iotlb,
> >                                               entry.start, entry.last);
> >                 if (map) {
> >                         map_file =3D (struct vdpa_map_file *)map->opaqu=
e;
> > @@ -1227,7 +1231,7 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
> >                         entry.last =3D map->last;
> >                         entry.perm =3D map->perm;
> >                 }
> > -               spin_unlock(&dev->domain->iotlb_lock);
> > +               spin_unlock(&dev->as.domain->iotlb_lock);
> >                 read_unlock(&dev->domain_lock);
> >                 ret =3D -EINVAL;
> >                 if (!f)
> > @@ -1430,22 +1434,22 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >                         break;
> >
> >                 read_lock(&dev->domain_lock);
> > -               if (!dev->domain) {
> > +               if (!dev->as.domain) {
> >                         read_unlock(&dev->domain_lock);
> >                         break;
> >                 }
> > -               spin_lock(&dev->domain->iotlb_lock);
> > -               map =3D vhost_iotlb_itree_first(dev->domain->iotlb,
> > +               spin_lock(&dev->as.domain->iotlb_lock);
> > +               map =3D vhost_iotlb_itree_first(dev->as.domain->iotlb,
> >                                               info.start, info.last);
> >                 if (map) {
> >                         info.start =3D map->start;
> >                         info.last =3D map->last;
> >                         info.capability =3D 0;
> > -                       if (dev->domain->bounce_map && map->start =3D=
=3D 0 &&
> > -                           map->last =3D=3D dev->domain->bounce_size -=
 1)
> > +                       if (dev->as.domain->bounce_map && map->start =
=3D=3D 0 &&
> > +                           map->last =3D=3D dev->as.domain->bounce_siz=
e - 1)
> >                                 info.capability |=3D VDUSE_IOVA_CAP_UME=
M;
> >                 }
> > -               spin_unlock(&dev->domain->iotlb_lock);
> > +               spin_unlock(&dev->as.domain->iotlb_lock);
> >                 read_unlock(&dev->domain_lock);
> >                 if (!map)
> >                         break;
> > @@ -1470,8 +1474,8 @@ static int vduse_dev_release(struct inode *inode,=
 struct file *file)
> >         struct vduse_dev *dev =3D file->private_data;
> >
> >         write_lock(&dev->domain_lock);
> > -       if (dev->domain)
> > -               vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
> > +       if (dev->as.domain)
> > +               vduse_dev_dereg_umem(dev, 0, dev->as.domain->bounce_siz=
e);
> >         write_unlock(&dev->domain_lock);
> >         spin_lock(&dev->msg_lock);
> >         /* Make sure the inflight messages can processed after reconnce=
ction */
> > @@ -1690,7 +1694,7 @@ static struct vduse_dev *vduse_dev_create(void)
> >                 return NULL;
> >
> >         mutex_init(&dev->lock);
> > -       mutex_init(&dev->mem_lock);
> > +       mutex_init(&dev->as.mem_lock);
> >         rwlock_init(&dev->domain_lock);
> >         spin_lock_init(&dev->msg_lock);
> >         INIT_LIST_HEAD(&dev->send_list);
> > @@ -1741,8 +1745,8 @@ static int vduse_destroy_dev(char *name)
> >         idr_remove(&vduse_idr, dev->minor);
> >         kvfree(dev->config);
> >         vduse_dev_deinit_vqs(dev);
> > -       if (dev->domain)
> > -               vduse_domain_destroy(dev->domain);
> > +       if (dev->as.domain)
> > +               vduse_domain_destroy(dev->as.domain);
> >         kfree(dev->name);
> >         kfree(dev->groups);
> >         vduse_dev_destroy(dev);
> > @@ -1858,7 +1862,7 @@ static ssize_t bounce_size_store(struct device *d=
evice,
> >
> >         ret =3D -EPERM;
> >         write_lock(&dev->domain_lock);
> > -       if (dev->domain)
> > +       if (dev->as.domain)
> >                 goto unlock;
> >
> >         ret =3D kstrtouint(buf, 10, &bounce_size);
> > @@ -2109,11 +2113,11 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *m=
dev, const char *name,
> >                 return ret;
> >
> >         write_lock(&dev->domain_lock);
> > -       if (!dev->domain)
> > -               dev->domain =3D vduse_domain_create(VDUSE_IOVA_SIZE - 1=
,
> > +       if (!dev->as.domain)
> > +               dev->as.domain =3D vduse_domain_create(VDUSE_IOVA_SIZE =
- 1,
> >                                                   dev->bounce_size);
> >         write_unlock(&dev->domain_lock);
> > -       if (!dev->domain) {
> > +       if (!dev->as.domain) {
> >                 put_device(&dev->vdev->vdpa.dev);
> >                 return -ENOMEM;
> >         }
> > @@ -2122,8 +2126,8 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
> >         if (ret) {
> >                 put_device(&dev->vdev->vdpa.dev);
> >                 write_lock(&dev->domain_lock);
> > -               vduse_domain_destroy(dev->domain);
> > -               dev->domain =3D NULL;
> > +               vduse_domain_destroy(dev->as.domain);
> > +               dev->as.domain =3D NULL;
> >                 write_unlock(&dev->domain_lock);
> >                 return ret;
> >         }
> > --
> > 2.51.0
> >
>
> Thanks
>

