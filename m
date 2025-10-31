Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6412EC57B
	for <virtualization@lists.linux.dev>; Fri, 31 Oct 2025 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761893533; cv=none; b=D3/yLyM/xcA5iNiD0+7l49ZYf1BcjMwayT2VqYcy66X+Gz+ICUvCs4vUIgEqa1+3qXFPVvFLZk2D2/d98NjsztxExU4I03dsGw70/Xfa4scx/VXdhgoiYVCpmpy4uq2QyXyEfzCQ70aS6VTBbgSTYxTUw5ueCL8PGB5z3QuhfSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761893533; c=relaxed/simple;
	bh=g7BtJVCW0fucQ7ZU5dmC/iRb1HlJ+OWINL/FohJU+XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGwjCm5GhDFRfG+Hpfr5r9EUNvveQ5xnJtt2ZQ7BgdnlDKr24gtfAQKojP5lbpyNJ8pzwx0jPkw9iCy7MqoaUtGeknrRH0mTnYPvAlpWsXOk3REsRPbguDEyZtY0NDXu1CY3rjtVXQoXa16n3IiXbEHr8ztXvl6mzWWxY/O0OGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=k/29Hej0; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="k/29Hej0"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a74b13f4f8so921970b3a.1
        for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 23:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761893530; x=1762498330; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHI7ZDinPpB5ekRk47oKd2XVRhGBo9zPmMBjTT7u/Xg=;
        b=k/29Hej0upz4v7Ian7y4ksjRy/I3f2R6rFd/uPKwSxX7GGKFj9MYNA8aDEatB5EiyQ
         X9eiYfWHdHng0zA0YrPVpu6FOGOiYhnDmwfq68LsHTfn7ufgiphic4AnWMbEk9486lPC
         L/0F/vOSkm3YPhhf+cwGlZEGeRyH9G5lmNm7IRgL+l/DobRbDNhQJUv+USqhdVvlIoqj
         UvbWUsIK6XFuLinsDh0eOimAYXlVXukIpSh0ae5mgyORtOdiL23U3JKwOT08NjjT8bd+
         6FeaEGhpXdI0oFf35Wgkvz86iH3vHPoN1XA8K+rNcPhB0dfObfIEkbkXlB+2/M1gR1V4
         cYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761893530; x=1762498330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHI7ZDinPpB5ekRk47oKd2XVRhGBo9zPmMBjTT7u/Xg=;
        b=lzsLNvLULcRJV86m/V+V/oxLM+EF80JDDtiRJsLzRgnwKqHp6yR4vZF1gp4N+gCtBR
         HBkCL7yS3yx6uh3Dtbh4AJkU2K4iB+OQ+csWXhVRM2q0ZqhPTrmD/WoP32l2vOEVzBkj
         AMtgYhxo6GuLeitPA+IReThNZhIXw2bqmIiAKXlZ/lUuHB7iAC+rYK1Sl826MUkhTVrO
         VTFUyfvR/yB6kG4h9FqcqFJAtrIdNtv5pqkeAzHnSK1puHiXHjXMgfFcBzkt9krCgmKf
         MNN46As2jK+jxi0E+flUCNw4iIbYw/tVyTDFQkjzLSLEQjfuoiFmLD4gmwFDjugguIQH
         0O1w==
X-Forwarded-Encrypted: i=1; AJvYcCWH9m6hX5RBShAoehFgXC87CLpfw0WxT4yD1MaI1t4FGwjm7nmbbB4UMLtyjsDNIc/dD59Y3eVCKnUI6xo+Qw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+ieVZfpnkkB8xLVFdX9nmJA/3RWyNdx+veu8uLkubrkoUXXzw
	/hNyNi4cr5/Aj1jmVkpY7+05aJFpiT9qZp/T8dtufbm76KKBybBFAuVD4QC4/6pcjfWguDhHWgz
	1WhvicBnsK+Bx3aQTeRgQKCxBOCpAX45SAWabun+L
X-Gm-Gg: ASbGncuWJnue9V2OaPfAlaIhiHPCJ1v4IJ+ttLAd3O7B4GAtYmHtw3ti2G+Od9qhgnP
	MJYL2rexlWqb2zOmxOIvrGh5n/0Mk3l2ld69cOVPdXuZ65olkrBhgSdQ9t5e+NybHmANhdT7MKr
	ex3WQKi8gSakaDGhcKswObz3AVsOl/s2UyISicNyRAPn0Lxf7O2VioVx4OdyryWoFkBks6G/tYy
	OlEmWv4oAn3KooBxqsI691hbkunMQbZgd+21nt3RvUeT0W1P6ThIzOhwRRp6WyuKbM0XDQ/yp/H
	YLEAIcR6V5ChPpeYTlq5Y5kZd0kOIcV4g9s6+uU=
X-Google-Smtp-Source: AGHT+IGIQwiVb3E4NVLYpMIcalD1uCVMlDKgpUYTlQ3wzwk5EEQzdhGxEzoe0QbmOQct/QXq0kIV6SvxeQ8OLwBZgmk=
X-Received: by 2002:a17:902:c406:b0:24b:25f:5f81 with SMTP id
 d9443c01a7336-2951a3eacaamr42061215ad.17.1761893529498; Thu, 30 Oct 2025
 23:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-6-eperezma@redhat.com>
 <CACycT3sYzQM88dkqHiT-g9eRtfo-8PjW7XcRtZ=5q++=By4RVw@mail.gmail.com> <CAJaqyWexPHJiZjC+RPvVH4J6gS55fCOfPQmKay2eWO-nqrjcRQ@mail.gmail.com>
In-Reply-To: <CAJaqyWexPHJiZjC+RPvVH4J6gS55fCOfPQmKay2eWO-nqrjcRQ@mail.gmail.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Fri, 31 Oct 2025 14:51:57 +0800
X-Gm-Features: AWmQ_blyhQLqU95y8Dt-2lfdh-Wxc7mHiwK3MCUZG7vaGiPo4msuexTlZcf9nWs
Message-ID: <CACycT3vdEAF1m5+UdDDoimQqUCTAmYVJ8cotcnUq+yQu0q8yqQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 5/6] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 2:31=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Oct 30, 2025 at 12:52=E2=80=AFPM Yongji Xie <xieyongji@bytedance.=
com> wrote:
> >
> > On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Add support for assigning Address Space Identifiers (ASIDs) to each V=
Q
> > > group.  This enables mapping each group into a distinct memory space.
> > >
> > > Now that the driver can change ASID in the middle of operation, the
> > > domain that each vq address point is also protected by domain_lock.
> > >
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > v8:
> > > * Revert the mutex to rwlock change, it needs proper profiling to
> > >   justify it.
> > >
> > > v7:
> > > * Take write lock in the error path (Jason).
> > >
> > > v6:
> > > * Make vdpa_dev_add use gotos for error handling (MST).
> > > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VERSION_1)=
 ?/
> > >   (MST).
> > > * Fix struct name not matching in the doc.
> > >
> > > v5:
> > > * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET=
_FD
> > >   ioctl (Jason).
> > > * Properly set domain bounce size to divide equally between nas (Jaso=
n).
> > > * Exclude "padding" member from the only >V1 members in
> > >   vduse_dev_request.
> > >
> > > v4:
> > > * Divide each domain bounce size between the device bounce size (Jaso=
n).
> > > * revert unneeded addr =3D NULL assignment (Jason)
> > > * Change if (x && (y || z)) return to if (x) { if (y) return; if (z)
> > >   return; } (Jason)
> > > * Change a bad multiline comment, using @ caracter instead of * (Jaso=
n).
> > > * Consider config->nas =3D=3D 0 as a fail (Jason).
> > >
> > > v3:
> > > * Get the vduse domain through the vduse_as in the map functions
> > >   (Jason).
> > > * Squash with the patch creating the vduse_as struct (Jason).
> > > * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic number
> > >   (Jason)
> > >
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
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 348 ++++++++++++++++++++-------=
--
> > >  include/uapi/linux/vduse.h         |  53 ++++-
> > >  2 files changed, 292 insertions(+), 109 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 97be04f73fbf..c6909d73d06d 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -41,6 +41,7 @@
> > >
> > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > +#define VDUSE_DEV_MAX_AS 0xffff
> > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > @@ -86,7 +87,14 @@ struct vduse_umem {
> > >         struct mm_struct *mm;
> > >  };
> > >
> > > +struct vduse_as {
> > > +       struct vduse_iova_domain *domain;
> > > +       struct vduse_umem *umem;
> > > +       struct mutex mem_lock;
> > > +};
> > > +
> > >  struct vduse_vq_group {
> > > +       struct vduse_as *as;
> > >         struct vduse_dev *dev;
> > >  };
> > >
> > > @@ -94,7 +102,7 @@ struct vduse_dev {
> > >         struct vduse_vdpa *vdev;
> > >         struct device *dev;
> > >         struct vduse_virtqueue **vqs;
> > > -       struct vduse_iova_domain *domain;
> > > +       struct vduse_as *as;
> > >         char *name;
> > >         struct mutex lock;
> > >         spinlock_t msg_lock;
> > > @@ -122,9 +130,8 @@ struct vduse_dev {
> > >         u32 vq_num;
> > >         u32 vq_align;
> > >         u32 ngroups;
> > > -       struct vduse_umem *umem;
> > > +       u32 nas;
> > >         struct vduse_vq_group *groups;
> > > -       struct mutex mem_lock;
> > >         unsigned int bounce_size;
> > >         struct mutex domain_lock;
> > >  };
> > > @@ -314,7 +321,7 @@ static int vduse_dev_set_status(struct vduse_dev =
*dev, u8 status)
> > >         return vduse_dev_msg_sync(dev, &msg);
> > >  }
> > >
> > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
> > >                                   u64 start, u64 last)
> > >  {
> > >         struct vduse_dev_msg msg =3D { 0 };
> > > @@ -323,8 +330,14 @@ static int vduse_dev_update_iotlb(struct vduse_d=
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
> > > @@ -436,14 +449,29 @@ static __poll_t vduse_dev_poll(struct file *fil=
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
> > > +       mutex_lock(&dev->domain_lock);
> > > +       dev->groups[group].as =3D &dev->as[asid];
> > > +       mutex_unlock(&dev->domain_lock);
> > > +}
> > > +
> > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > >  {
> > >         int i;
> > > -       struct vduse_iova_domain *domain =3D dev->domain;
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
> > > @@ -623,6 +651,29 @@ static union virtio_map vduse_get_vq_map(struct =
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
> > > @@ -794,13 +845,13 @@ static int vduse_vdpa_set_map(struct vdpa_devic=
e *vdpa,
> > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > >         int ret;
> > >
> > > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > > +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb);
> > >         if (ret)
> > >                 return ret;
> > >
> > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
> > >         if (ret) {
> > > -               vduse_domain_clear_map(dev->domain, iotlb);
> > > +               vduse_domain_clear_map(dev->as[asid].domain, iotlb);
> > >                 return ret;
> > >         }
> > >
> > > @@ -843,6 +894,7 @@ static const struct vdpa_config_ops vduse_vdpa_co=
nfig_ops =3D {
> > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > >         .reset                  =3D vduse_vdpa_reset,
> > >         .set_map                =3D vduse_vdpa_set_map,
> > > +       .set_group_asid         =3D vduse_set_group_asid,
> > >         .get_vq_map             =3D vduse_get_vq_map,
> > >         .free                   =3D vduse_vdpa_free,
> > >  };
> > > @@ -858,9 +910,10 @@ static void vduse_dev_sync_single_for_device(uni=
on virtio_map token,
> > >                 return;
> > >
> > >         vdev =3D token.group->dev;
> > > -       domain =3D vdev->domain;
> > > -
> > > +       mutex_lock(&vdev->domain_lock);
> > > +       domain =3D token.group->as->domain;
> > >         vduse_domain_sync_single_for_device(domain, dma_addr, size, d=
ir);
> > > +       mutex_unlock(&vdev->domain_lock);
> > >  }
> > >
> > >  static void vduse_dev_sync_single_for_cpu(union virtio_map token,
> > > @@ -874,9 +927,10 @@ static void vduse_dev_sync_single_for_cpu(union =
virtio_map token,
> > >                 return;
> > >
> > >         vdev =3D token.group->dev;
> > > -       domain =3D vdev->domain;
> > > -
> > > +       mutex_lock(&vdev->domain_lock);
> > > +       domain =3D token.group->as->domain;
> > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir)=
;
> > > +       mutex_unlock(&vdev->domain_lock);
> > >  }
> > >
> > >  static dma_addr_t vduse_dev_map_page(union virtio_map token, struct =
page *page,
> > > @@ -886,14 +940,18 @@ static dma_addr_t vduse_dev_map_page(union virt=
io_map token, struct page *page,
> > >  {
> > >         struct vduse_dev *vdev;
> > >         struct vduse_iova_domain *domain;
> > > +       dma_addr_t r;
> > >
> > >         if (!token.group)
> > >                 return DMA_MAPPING_ERROR;
> > >
> > >         vdev =3D token.group->dev;
> > > -       domain =3D vdev->domain;
> > > +       mutex_lock(&vdev->domain_lock);
> >
> > The mutex_lock can't be used here since the dma ops might be called in
> > atomic context. And I think we can just remove it since creation and
> > deletion operations of the iova domain are guaranteed not to execute
> > concurrently with I/O operations.
> >
>
> That would be great indeed! Can you expand on this, what protects here
> from the moment the two syscalls are issues from userland?
>
