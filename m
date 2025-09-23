Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDD02797A9
	for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648377; cv=none; b=CFwTfBdJQnZ/foZCmDOlF7WZMECGsO/3jb/2MRRVicwuW0QfeFGpTx79b6415V+ntiDr+mKNTJHPQKOSBGG2UajWJ0ynHO74zNjWVaEjIwF/YS4b33UwHAPXAcDlBQqmzGfiDb3BJK9o1pn+oRNIR68O+yMYBHWkUM89wH0UdW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648377; c=relaxed/simple;
	bh=jwn5LkXLngYIB5TFJuW4HWIf8Z4eqk3/zX5FdB2wg+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fA7bmmyA1xjARwzffJsvK6vNIX/l2STJ9xUtLhloucxtf2Eo68uVR/zjP2Qk0RTr1fId3GcG4srZV7syxQZtzyJ3hFrKOc0hLhaTwKn5+KPS0J+7LkLfcPGQLUtss/cgeh4E92WB+cMVOyDRc1k3x8hvfnHPI8b7vgO3DwnV+bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LvCjNbWO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvCjNbWO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758648374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TiaYNVRZR6UTUiAwZQPRhu5KvUHNnEdtxEFSkgRrMrs=;
	b=LvCjNbWOK6nyQ9DXfixUTgtX+rMsWinnN1dtIJgVDUZqoqRQUzCUWyawMjqaduDEk314ya
	NA/K/BrFIEov5luaHbaiK7XrOoGW986eRLRjHT00xH2YeQkhX4VXsakKW2sae/EjRJ0xat
	LocQnzYOL02YsgM1wVsR6CvWLIDc3Q0=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-Key0AWTlP8WCLzwsWDhcvA-1; Tue, 23 Sep 2025 13:26:12 -0400
X-MC-Unique: Key0AWTlP8WCLzwsWDhcvA-1
X-Mimecast-MFC-AGG-ID: Key0AWTlP8WCLzwsWDhcvA_1758648372
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-eaa3ccb864eso6184207276.0
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 10:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758648372; x=1759253172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiaYNVRZR6UTUiAwZQPRhu5KvUHNnEdtxEFSkgRrMrs=;
        b=soIr+VO6QptwLR3xVaCY37vbQeulLdP7MUz0YiBOpAmexXEhAmd83XXuFDsmhbpphv
         nsFrvVGu3jJdgJbZ3KmpT6BASC6eMHQHsnANQ1u9gYfRYlpweOkmru+WWCwyeW6GKME1
         15wupP00L0X7JMgKei3Rn9MIUt7S2BEBRbZBVKvqCoyQgI/XglzL+Vk3j+GyF8H32e0J
         H2anyC+lHgvJe9nb77tt2AevkdJADsWSs2EWG6nZeXcmZ46y4KxERCc6i0905Ts64d3h
         LQe6NtaB/DOxBktbJw41v/j2jjElYvDPHYOcex8vKI2qNnZGAxe6ucOtqPMtntuUMfCB
         ZiAA==
X-Forwarded-Encrypted: i=1; AJvYcCVh0fyeaEOmKBzSwMLc0SDD6SCfca5RUpLOrncY6QYBWO0I9cKeBMZ+2xWH2C/s/v+ra+U1facjUw0++3MVxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwItj4v1K52jJLVncvQ+CRSnQRHml0Ai4b8jWbhF9zyiLOapf72
	uR6y7u5jDM6qF3ZHz3xjfz0XMeS/NRFSn5oEbdcTMubwQNdG4v0ypPBWxZLzgnMt5vHvtDvkKhP
	Q5zKgXvJGWvkMH8KKJ0XtV3+7/AT6en+dX5JFGFz+KiyelvmlEkxOrFKnUFlAyBofPL+pFP2lfE
	EIjm85oX76p2aNm30zq4LBt4kSPBUkPM0mz3+bpemakbw=
X-Gm-Gg: ASbGnctmORHEHZ9Sox95Nb/tYOv9cYD0arpch4e2rXeKjLUkQdEd3huZYR5lSS/D9aM
	XmWSlwxFsvirZSmkm4f+lDJDuwlk5FuejzQa+4aAMBXhkKTWTBcYS7K3jBvztJtlHRDRdKJgcm2
	7NAZqD7qEoNusP6+EgUnmFrHMI5cyJ9o4pGwyd/jC3a+unD5HKMNXEe16vBxy1xIV3miIBcS9Nr
	vH4fcfg
X-Received: by 2002:a05:6902:725:b0:ea4:15a7:5efe with SMTP id 3f1490d57ef6-eb32e72d38bmr3216240276.13.1758648371017;
        Tue, 23 Sep 2025 10:26:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhdlCnZs00K9k1E6qWWASPvMTxVsnRFiSD5HI+W9JWlplceW7BxHGkypP8ZfL8R31ej6nzVDVngKKoQmzgDtQ=
X-Received: by 2002:a05:6902:725:b0:ea4:15a7:5efe with SMTP id
 3f1490d57ef6-eb32e72d38bmr3216123276.13.1758648368889; Tue, 23 Sep 2025
 10:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250919093359.961296-1-eperezma@redhat.com> <20250919093359.961296-6-eperezma@redhat.com>
 <CACGkMEuodLC2M=ePytKWa=FQeTZs+uFzofN-EYOdx3u=HuwkGg@mail.gmail.com>
In-Reply-To: <CACGkMEuodLC2M=ePytKWa=FQeTZs+uFzofN-EYOdx3u=HuwkGg@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 23 Sep 2025 19:25:31 +0200
X-Gm-Features: AS18NWDYStrLaHR6NPnePAQYdHgunSSpsRb1Uhn3Dm3Rh0DC3a9_j3lF2guKGrg
Message-ID: <CAJaqyWeTmRp5JkQ11fmjfzoAeOJWJfpA4OM6jVU8pCNia1Y7Qg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] vduse: add vq group asid support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5OWby_-1YcjcgZFPFmQc_YAkdBaznailklu4cdInkPw_1758648372
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 3:50=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Sep 19, 2025 at 5:34=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
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
> > v3:
> > * Get the vduse domain through the vduse_as in the map functions
> >   (Jason).
> > * Squash with the patch creating the vduse_as struct (Jason).
> > * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic number
> >   (Jason)
> >
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
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 327 ++++++++++++++++++++---------
> >  include/uapi/linux/vduse.h         |  51 ++++-
> >  2 files changed, 281 insertions(+), 97 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 6fdabc3c910e..c6c70cfd4887 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -42,6 +42,7 @@
> >
> >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > +#define VDUSE_DEV_MAX_AS 0xffff
> >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > @@ -89,7 +90,14 @@ struct vduse_umem {
> >         struct mm_struct *mm;
> >  };
> >
> > +struct vduse_as {
> > +       struct vduse_iova_domain *domain;
> > +       struct vduse_umem *umem;
> > +       struct mutex mem_lock;
> > +};
> > +
> >  struct vduse_vq_group {
> > +       struct vduse_as *as;
> >         struct vduse_dev *dev;
> >  };
> >
> > @@ -97,7 +105,7 @@ struct vduse_dev {
> >         struct vduse_vdpa *vdev;
> >         struct device *dev;
> >         struct vduse_virtqueue **vqs;
> > -       struct vduse_iova_domain *domain;
> > +       struct vduse_as *as;
> >         char *name;
> >         struct mutex lock;
> >         spinlock_t msg_lock;
> > @@ -125,9 +133,8 @@ struct vduse_dev {
> >         u32 vq_num;
> >         u32 vq_align;
> >         u32 ngroups;
> > -       struct vduse_umem *umem;
> > +       u32 nas;
> >         struct vduse_vq_group *groups;
> > -       struct mutex mem_lock;
> >         unsigned int bounce_size;
> >         rwlock_t domain_lock;
> >  };
> > @@ -324,7 +331,7 @@ static int vduse_dev_set_status(struct vduse_dev *d=
ev, u8 status)
> >         return vduse_dev_msg_sync(dev, &msg);
> >  }
> >
> > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
> >                                   u64 start, u64 last)
> >  {
> >         struct vduse_dev_msg msg =3D { 0 };
> > @@ -333,8 +340,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev=
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
> > @@ -446,14 +459,29 @@ static __poll_t vduse_dev_poll(struct file *file,=
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
> > +       dev->groups[group].as =3D &dev->as[asid];
> > +       write_unlock(&dev->domain_lock);
> > +}
> > +
> >  static void vduse_dev_reset(struct vduse_dev *dev)
> >  {
> >         int i;
> > -       struct vduse_iova_domain *domain =3D dev->domain;
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
> > @@ -639,6 +667,29 @@ static union virtio_map vduse_get_vq_map(struct vd=
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
> > @@ -810,13 +861,13 @@ static int vduse_vdpa_set_map(struct vdpa_device =
*vdpa,
> >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> >         int ret;
> >
> > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb);
> >         if (ret)
> >                 return ret;
> >
> > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
> >         if (ret) {
> > -               vduse_domain_clear_map(dev->domain, iotlb);
> > +               vduse_domain_clear_map(dev->as[asid].domain, iotlb);
> >                 return ret;
> >         }
> >
> > @@ -859,6 +910,7 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
> >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> >         .reset                  =3D vduse_vdpa_reset,
> >         .set_map                =3D vduse_vdpa_set_map,
> > +       .set_group_asid         =3D vduse_set_group_asid,
> >         .get_vq_map             =3D vduse_get_vq_map,
> >         .free                   =3D vduse_vdpa_free,
> >  };
> > @@ -874,9 +926,10 @@ static void vduse_dev_sync_single_for_device(union=
 virtio_map token,
> >                 return;
> >
> >         vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > -
> > +       read_lock(&vdev->domain_lock);
>
> This introduce atomic operation in the datapath, I wonder if we can
> switch to use RCU instead.
>

I think it is a path that is worth exploring. The reason I chose
rwlock (and just plain mutex before) is that
vduse_domain_sync_single_for_device and
vduse_domain_sync_single_for_cpu already take a read lock, so it seems
the overhead was ok.

Can we do it on top of this series? I think both using RCU can improve
the performance for sure, but just taking out one of them would not
buy us a lot.

> > +       domain =3D token.group->as->domain;
> >         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir=
);
> > +       read_unlock(&vdev->domain_lock);
> >  }
> >
> >  static void vduse_dev_sync_single_for_cpu(union virtio_map token,
> > @@ -890,9 +943,10 @@ static void vduse_dev_sync_single_for_cpu(union vi=
rtio_map token,
> >                 return;
> >
> >         vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > -
> > +       read_lock(&vdev->domain_lock);
> > +       domain =3D token.group->as->domain;
> >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
> > +       read_unlock(&vdev->domain_lock);
> >  }
> >
> >  static dma_addr_t vduse_dev_map_page(union virtio_map token, struct pa=
ge *page,
> > @@ -902,14 +956,18 @@ static dma_addr_t vduse_dev_map_page(union virtio=
_map token, struct page *page,
> >  {
> >         struct vduse_dev *vdev;
> >         struct vduse_iova_domain *domain;
> > +       dma_addr_t r;
> >
> >         if (!token.group)
> >                 return DMA_MAPPING_ERROR;
> >
> >         vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > +       read_lock(&vdev->domain_lock);
> > +       domain =3D token.group->as->domain;
> > +       r =3D vduse_domain_map_page(domain, page, offset, size, dir, at=
trs);
> > +       read_unlock(&vdev->domain_lock);
> >
> > -       return vduse_domain_map_page(domain, page, offset, size, dir, a=
ttrs);
> > +       return r;
> >  }
> >
> >  static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dm=
a_addr,
> > @@ -923,9 +981,10 @@ static void vduse_dev_unmap_page(union virtio_map =
token, dma_addr_t dma_addr,
> >                 return;
> >
> >         vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > -
> > -       return vduse_domain_unmap_page(domain, dma_addr, size, dir, att=
rs);
> > +       read_lock(&vdev->domain_lock);
> > +       domain =3D token.group->as->domain;
> > +       vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
> > +       read_unlock(&vdev->domain_lock);
> >  }
> >
> >  static void *vduse_dev_alloc_coherent(union virtio_map token, size_t s=
ize,
> > @@ -934,21 +993,21 @@ static void *vduse_dev_alloc_coherent(union virti=
o_map token, size_t size,
> >         struct vduse_dev *vdev;
> >         struct vduse_iova_domain *domain;
> >         unsigned long iova;
> > -       void *addr;
> > +       void *addr =3D NULL;
>
> Nit: if we stick to no NULL assignment we can save some lines of code bel=
ow.
>

Right, I guess I added it in a previous iteration of the code and now
it is not needed anymore. Reverting!

> >
> >         *dma_addr =3D DMA_MAPPING_ERROR;
> >         if (!token.group)
> >                 return NULL;
> >
> >         vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > +       read_lock(&vdev->domain_lock);
> > +       domain =3D token.group->as->domain;
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
> > @@ -963,23 +1022,28 @@ static void vduse_dev_free_coherent(union virtio=
_map token, size_t size,
> >                 return;
> >
> >         vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > -
> > +       read_lock(&vdev->domain_lock);
> > +       domain =3D token.group->as->domain;
> >         vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs=
);
> > +       read_unlock(&vdev->domain_lock);
> >  }
> >
> >  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma=
_addr)
> >  {
> >         struct vduse_dev *vdev;
> >         struct vduse_iova_domain *domain;
> > +       size_t bounce_size;
> >
> >         if (!token.group)
> >                 return false;
> >
> >         vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > +       read_lock(&vdev->domain_lock);
> > +       domain =3D token.group->as->domain;
> > +       bounce_size =3D domain->bounce_size;
> > +       read_unlock(&vdev->domain_lock);
> >
> > -       return dma_addr < domain->bounce_size;
> > +       return dma_addr < bounce_size;
> >  }
> >
> >  static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t =
dma_addr)
> > @@ -993,14 +1057,18 @@ static size_t vduse_dev_max_mapping_size(union v=
irtio_map token)
> >  {
> >         struct vduse_dev *vdev;
> >         struct vduse_iova_domain *domain;
> > +       size_t bounce_size;
> >
> >         if (!token.group)
> >                 return 0;
> >
> >         vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > +       read_lock(&vdev->domain_lock);
> > +       domain =3D token.group->as->domain;
> > +       bounce_size =3D domain->bounce_size;
> > +       read_unlock(&vdev->domain_lock);
> >
> > -       return domain->bounce_size;
> > +       return bounce_size;
> >  }
> >
> >  static const struct virtio_map_ops vduse_map_ops =3D {
> > @@ -1140,39 +1208,40 @@ static int vduse_dev_queue_irq_work(struct vdus=
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
> > -       mutex_lock(&dev->mem_lock);
> > +       mutex_lock(&dev->as[asid].mem_lock);
> >         ret =3D -ENOENT;
> > -       if (!dev->umem)
> > +       if (!dev->as[asid].umem)
> >                 goto unlock;
> >
> >         ret =3D -EINVAL;
> > -       if (!dev->domain)
> > +       if (!dev->as[asid].domain)
> >                 goto unlock;
> >
> > -       if (dev->umem->iova !=3D iova || size !=3D dev->domain->bounce_=
size)
> > +       if (dev->as[asid].umem->iova !=3D iova ||
> > +           size !=3D dev->as[asid].domain->bounce_size)
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
> > +       vduse_domain_remove_user_bounce_pages(dev->as[asid].domain);
> > +       unpin_user_pages_dirty_lock(dev->as[asid].umem->pages,
> > +                                   dev->as[asid].umem->npages, true);
> > +       atomic64_sub(dev->as[asid].umem->npages, &dev->as[asid].umem->m=
m->pinned_vm);
> > +       mmdrop(dev->as[asid].umem->mm);
> > +       vfree(dev->as[asid].umem->pages);
> > +       kfree(dev->as[asid].umem);
> > +       dev->as[asid].umem =3D NULL;
> >         ret =3D 0;
> >  unlock:
> > -       mutex_unlock(&dev->mem_lock);
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
> > @@ -1180,14 +1249,14 @@ static int vduse_dev_reg_umem(struct vduse_dev =
*dev,
> >         unsigned long npages, lock_limit;
> >         int ret;
> >
> > -       if (!dev->domain || !dev->domain->bounce_map ||
> > -           size !=3D dev->domain->bounce_size ||
> > +       if (!dev->as[asid].domain || !dev->as[asid].domain->bounce_map =
||
> > +           size !=3D dev->as[asid].domain->bounce_size ||
> >             iova !=3D 0 || uaddr & ~PAGE_MASK)
> >                 return -EINVAL;
> >
> > -       mutex_lock(&dev->mem_lock);
> > +       mutex_lock(&dev->as[asid].mem_lock);
> >         ret =3D -EEXIST;
> > -       if (dev->umem)
> > +       if (dev->as[asid].umem)
> >                 goto unlock;
> >
> >         ret =3D -ENOMEM;
> > @@ -1211,7 +1280,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
ev,
> >                 goto out;
> >         }
> >
> > -       ret =3D vduse_domain_add_user_bounce_pages(dev->domain,
> > +       ret =3D vduse_domain_add_user_bounce_pages(dev->as[asid].domain=
,
> >                                                  page_list, pinned);
> >         if (ret)
> >                 goto out;
> > @@ -1224,7 +1293,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
ev,
> >         umem->mm =3D current->mm;
> >         mmgrab(current->mm);
> >
> > -       dev->umem =3D umem;
> > +       dev->as[asid].umem =3D umem;
> >  out:
> >         if (ret && pinned > 0)
> >                 unpin_user_pages(page_list, pinned);
> > @@ -1235,7 +1304,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
ev,
> >                 vfree(page_list);
> >                 kfree(umem);
> >         }
> > -       mutex_unlock(&dev->mem_lock);
> > +       mutex_unlock(&dev->as[asid].mem_lock);
> >         return ret;
> >  }
> >
> > @@ -1267,47 +1336,66 @@ static long vduse_dev_ioctl(struct file *file, =
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
> > -               if (!dev->domain) {
> > +               asid =3D array_index_nospec(entry.asid, dev->nas);
> > +               if (!dev->as[asid].domain) {
> >                         read_unlock(&dev->domain_lock);
> >                         break;
> >                 }
> > -               spin_lock(&dev->domain->iotlb_lock);
> > -               map =3D vhost_iotlb_itree_first(dev->domain->iotlb,
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
> > -               spin_unlock(&dev->domain->iotlb_lock);
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
> >                 fput(f);
> >                 break;
> >         }
> > @@ -1452,6 +1540,7 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
> >         }
> >         case VDUSE_IOTLB_REG_UMEM: {
> >                 struct vduse_iova_umem umem;
> > +               u32 asid;
> >
> >                 ret =3D -EFAULT;
> >                 if (copy_from_user(&umem, argp, sizeof(umem)))
> > @@ -1459,17 +1548,21 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >
> >                 ret =3D -EINVAL;
> >                 if (!is_mem_zero((const char *)umem.reserved,
> > -                                sizeof(umem.reserved)))
> > +                                sizeof(umem.reserved)) ||
> > +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> > +                    umem.asid !=3D 0) || umem.asid >=3D dev->nas)
>
> This allows umem.asid to be set even with version < 1?
>

Not sure if I'm missing something. If (dev->api_version <
VDUSE_API_VERSION_1 && umem.asid !=3D 0), it takes the break.

Seems similar to comment [1].

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
> > @@ -1477,10 +1570,15 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >
> >                 ret =3D -EINVAL;
> >                 if (!is_mem_zero((const char *)umem.reserved,
> > -                                sizeof(umem.reserved)))
> > +                                sizeof(umem.reserved)) ||
> > +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> > +                    umem.asid !=3D 0) ||
> > +                    umem.asid >=3D dev->nas)
>
> And here?
>

Same here.

> >                         break;
> > +
> >                 write_lock(&dev->domain_lock);
> > -               ret =3D vduse_dev_dereg_umem(dev, umem.iova,
> > +               asid =3D array_index_nospec(umem.asid, dev->nas);
> > +               ret =3D vduse_dev_dereg_umem(dev, asid, umem.iova,
> >                                            umem.size);
> >                 write_unlock(&dev->domain_lock);
> >                 break;
> > @@ -1488,6 +1586,7 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
> >         case VDUSE_IOTLB_GET_INFO: {
> >                 struct vduse_iova_info info;
> >                 struct vhost_iotlb_map *map;
> > +               u32 asid;
> >
> >                 ret =3D -EFAULT;
> >                 if (copy_from_user(&info, argp, sizeof(info)))
> > @@ -1501,23 +1600,31 @@ static long vduse_dev_ioctl(struct file *file, =
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
> > -               if (!dev->domain) {
> > +               asid =3D array_index_nospec(info.asid, dev->nas);
> > +               if (!dev->as[asid].domain) {
> >                         read_unlock(&dev->domain_lock);
> >                         break;
> >                 }
> > -               spin_lock(&dev->domain->iotlb_lock);
> > -               map =3D vhost_iotlb_itree_first(dev->domain->iotlb,
> > +               spin_lock(&dev->as[asid].domain->iotlb_lock);
> > +               map =3D vhost_iotlb_itree_first(dev->as[asid].domain->i=
otlb,
> >                                               info.start, info.last);
> >                 if (map) {
> >                         info.start =3D map->start;
> >                         info.last =3D map->last;
> >                         info.capability =3D 0;
> > -                       if (dev->domain->bounce_map && map->start =3D=
=3D 0 &&
> > -                           map->last =3D=3D dev->domain->bounce_size -=
 1)
> > +                       if (dev->as[asid].domain->bounce_map &&
> > +                           map->start =3D=3D 0 &&
> > +                           map->last =3D=3D dev->as[asid].domain->boun=
ce_size - 1)
> >                                 info.capability |=3D VDUSE_IOVA_CAP_UME=
M;
> >                 }
> > -               spin_unlock(&dev->domain->iotlb_lock);
> > +               spin_unlock(&dev->as[asid].domain->iotlb_lock);
> >                 read_unlock(&dev->domain_lock);
> >                 if (!map)
> >                         break;
> > @@ -1542,8 +1649,10 @@ static int vduse_dev_release(struct inode *inode=
, struct file *file)
> >         struct vduse_dev *dev =3D file->private_data;
> >
> >         write_lock(&dev->domain_lock);
> > -       if (dev->domain)
> > -               vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
> > +       for (int i =3D 0; i < dev->nas; i++)
> > +               if (dev->as[i].domain)
> > +                       vduse_dev_dereg_umem(dev, i, 0,
> > +                                            dev->as[i].domain->bounce_=
size);
> >         write_unlock(&dev->domain_lock);
> >         spin_lock(&dev->msg_lock);
> >         /* Make sure the inflight messages can processed after reconnce=
ction */
> > @@ -1762,7 +1871,6 @@ static struct vduse_dev *vduse_dev_create(void)
> >                 return NULL;
> >
> >         mutex_init(&dev->lock);
> > -       mutex_init(&dev->mem_lock);
> >         rwlock_init(&dev->domain_lock);
> >         spin_lock_init(&dev->msg_lock);
> >         INIT_LIST_HEAD(&dev->send_list);
> > @@ -1813,8 +1921,11 @@ static int vduse_destroy_dev(char *name)
> >         idr_remove(&vduse_idr, dev->minor);
> >         kvfree(dev->config);
> >         vduse_dev_deinit_vqs(dev);
> > -       if (dev->domain)
> > -               vduse_domain_destroy(dev->domain);
> > +       for (int i =3D 0; i < dev->nas; i++) {
> > +               if (dev->as[i].domain)
> > +                       vduse_domain_destroy(dev->as[i].domain);
> > +       }
> > +       kfree(dev->as);
> >         kfree(dev->name);
> >         kfree(dev->groups);
> >         vduse_dev_destroy(dev);
> > @@ -1861,13 +1972,18 @@ static bool vduse_validate_config(struct vduse_=
dev_config *config,
> >                          sizeof(config->reserved)))
> >                 return false;
> >
> > -       if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> > +       if (api_version < VDUSE_API_VERSION_1 &&
> > +           (config->ngroups || config->nas))
> >                 return false;
> >
> >         if (api_version >=3D VDUSE_API_VERSION_1 &&
> >             config->ngroups > VDUSE_DEV_MAX_GROUPS)
> >                 return false;
> >
> > +       if (api_version >=3D VDUSE_API_VERSION_1 &&
> > +           config->nas > VDUSE_DEV_MAX_AS)
> > +               return false;
>
> Nit: is this better to have:
>
> if (api_version >=3D VDUSE_API_VERSION_1) {
>       if () return false;
>       if () return false;
> }
>
> ?
>

Sure, rewriting this.

> > +
> >         if (config->vq_align > PAGE_SIZE)
> >                 return false;
> >
> > @@ -1931,7 +2047,8 @@ static ssize_t bounce_size_store(struct device *d=
evice,
> >
> >         ret =3D -EPERM;
> >         write_lock(&dev->domain_lock);
> > -       if (dev->domain)
> > +       /* Assuming that if the first domain is allocated, all are allo=
cated */
>
> I don't fully understand the comment here.
>

We're only checking for dev->as[0].domain, but all domains are
allocated at the same time. So if dev->as[0].domain, all
dev->as[i].domain when i < dev->nas are allocated.

Would you like me to rewrite the comment differently?

> > +       if (dev->as[0].domain)
> >                 goto unlock;
> >
> >         ret =3D kstrtouint(buf, 10, &bounce_size);
> > @@ -1992,6 +2109,13 @@ static int vduse_create_dev(struct vduse_dev_con=
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
> > @@ -2028,6 +2152,8 @@ static int vduse_create_dev(struct vduse_dev_conf=
ig *config,
> >  err_idr:
> >         kfree(dev->name);
> >  err_str:
> > +       kfree(dev->as);
> > +err_as:
> >         kfree(dev->groups);
> >  err_vq_groups:
> >         vduse_dev_destroy(dev);
> > @@ -2153,7 +2279,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *=
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
> > @@ -2182,11 +2308,20 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *m=
dev, const char *name,
> >                 return ret;
> >
> >         write_lock(&dev->domain_lock);
> > -       if (!dev->domain)
> > -               dev->domain =3D vduse_domain_create(VDUSE_IOVA_SIZE - 1=
,
> > -                                                 dev->bounce_size);
> > +       ret =3D 0;
> > +
> > +       for (int i =3D 0; i < dev->nas; ++i) {
> > +               dev->as[i].domain =3D vduse_domain_create(VDUSE_IOVA_SI=
ZE - 1,
> > +                                                       dev->bounce_siz=
e);
>
> Per discussion previously, should we divide bounce_size here?
>

Right, I forgot it. And making it shared between vqs will cause
contention between threads, at least for an atomic. So yes let's
divide it.

> > +               if (!dev->as[i].domain) {
> > +                       ret =3D -ENOMEM;
> > +                       for (int j =3D 0; j < i; ++j)
> > +                               vduse_domain_destroy(dev->as[j].domain)=
;
> > +               }
> > +       }
> > +
> >         write_unlock(&dev->domain_lock);
> > -       if (!dev->domain) {
> > +       if (ret =3D=3D -ENOMEM) {
> >                 put_device(&dev->vdev->vdpa.dev);
> >                 return -ENOMEM;
> >         }
> > @@ -2195,8 +2330,12 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *md=
ev, const char *name,
> >         if (ret) {
> >                 put_device(&dev->vdev->vdpa.dev);
> >                 write_lock(&dev->domain_lock);
> > -               vduse_domain_destroy(dev->domain);
> > -               dev->domain =3D NULL;
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
>
> I see double "@".
>

Ouch what a miss, thanks!

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

[1] https://patchew.org/linux/20250826112709.1051172-1-eperezma@redhat.com/=
20250826112709.1051172-6-eperezma@redhat.com/#CACGkMEsZiX-M-PNGX8W7GprBJmiG=
i9Gz1=3DayE=3DiMaP3WO3vr2Q@mail.gmail.com

