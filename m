Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A86215F5C
	for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452289; cv=none; b=dexwbYZsQaFEcQYLzCubiJDWGfSqPc65gGcgWlxBuVsT3hdy3HBh94uErw+thgyd/q5HwtVSkRR+zo3sSaIeI10Z4ho6vCZVH5Mh5G5MswG8cN2HwIVxoVT65ZlPrVIVSUexC7oRY1KCYCREvjW9o6yDP2jBGZtb0gJbnIsy718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452289; c=relaxed/simple;
	bh=Pzuw+xAkTyYvj165jAPZXheYwfckcVKHdvbjyPsnmYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lynSY3JKO/2dLVa/seMLLKdL5m/ruth2+72bVIsR9RD+9CtwZIY4Rn8yUuh872vTWotCgk+cxQDvx+asN98Pfo8lEZZv/plxwMFG1D2a8vwI87uf1VKWe1OqG41VcOCtWozUCaX/SjNxoEAb+YYBw9OlTJmhvNcqElDJsNgGCgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YDfUAwcW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDfUAwcW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766452285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3Tm0snUvAKgk3XfLUqnmWx+sovP0Vg1bInSx4UYBl4=;
	b=YDfUAwcW5KsWvV6TGrTX466CgCevX/TPh4imUGZ+v0Eg5f1xG98zAGD3CGoTK7Q/WIM+uO
	Zv9uSyBoVne0YaPFiTOAU8JhJ0botelF54Nc1CV12pkVaKoc0UdYIycsHnQ1a+qnVC4C9M
	glWFqbgNNWy/EoXr20wKTTQKDa+mTe8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-JvxYf-OsP3GfYQn8gsSSUA-1; Mon, 22 Dec 2025 20:11:23 -0500
X-MC-Unique: JvxYf-OsP3GfYQn8gsSSUA-1
X-Mimecast-MFC-AGG-ID: JvxYf-OsP3GfYQn8gsSSUA_1766452283
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c904a1168so9721167a91.1
        for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 17:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766452283; x=1767057083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c3Tm0snUvAKgk3XfLUqnmWx+sovP0Vg1bInSx4UYBl4=;
        b=EU7CUP2QqRBnAGhAJXJkEA/Om7uSJj6fT7DLR6mgb15uAkDuM7EnI3lLhAq9BhOwWS
         HqCmX/TgWH1qJe74yj36+8lhXHfq4N1y/b76rGg6eDLieJ5YY/eoZh9G2xBnHWQ1M7S+
         1EOMCunNDbfZxBkpeHA/Q407ERBNBGHxKM3+8skeCJbbChpgkPv2t1Ln+EMECi/wLncz
         7VsbfvqAnCkWXo+CVaRxFohYV/8h/XDEY9ItF7L4MPznp58mKKOCk2pia0QxnqNsD3wR
         ZyF2eKlsE3NYfH5ctBwR1HVj2up8JpTJskf6ZJwxt5KkBhhhO7Ru9EKerOtll3Ug2CNF
         xvyw==
X-Forwarded-Encrypted: i=1; AJvYcCX/AIbYmMr3T7tmUe6YHJXSAHScVMrFNg6ZQ4sOQ/WgUeGSlOAiGUMkDpXTzH/S2wqCXonG9ZXM8nvXvHE6KA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy54Wqs/rJQ1QkIqF/xzcKOH9KQcFpHFpQ2innjdg0rck0JsEGQ
	D6zjR3ueCJz3/XyGZYjJF2oDHw+xVnQCK+cBONH7J1GkD5qjRgrKWWipL1NIRFSxpk8T1TqT1l1
	3FW29Vm5sks9IQf/Z/xhokGmp26tOTYVehKcDPZ3kweA4WSfr1wQsAZWVAixCJbw04NlXBnTERB
	d5xfflLEEm1ZrYjaxy2wODKlduX9pXRaUVQIqzL+RCccw=
X-Gm-Gg: AY/fxX4djlZDVknAcDNEy/l8rnzAZnU/USp0vmjyz25pRJaXigFvTnE1fbuv/4VXIPZ
	Htq8J01VCXNpYxq3q+Pv2eg/idwe0TVxS3P9Z+FbXDz0wEXsZy+jscCkC7H9NASp50LAxwHLUL0
	bN8eVgG5YGxlzPafjPoFpU1ppDy2GriT+8GcS2GsLPvOC2G6FTVyKF+XrXM9jW98przBQ=
X-Received: by 2002:a17:90b:4d87:b0:340:e521:bc73 with SMTP id 98e67ed59e1d1-34e921371c5mr10722007a91.5.1766452281666;
        Mon, 22 Dec 2025 17:11:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb2Pin8QLzRiN04bm494hWeoY4y/+PjME14KqmatajSE2A9eFioB6RjHtNKRqIgOVQByACFKPa0g6DCRXqSCs=
X-Received: by 2002:a17:90b:4d87:b0:340:e521:bc73 with SMTP id
 98e67ed59e1d1-34e921371c5mr10721978a91.5.1766452280946; Mon, 22 Dec 2025
 17:11:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251217112414.2374672-1-eperezma@redhat.com> <20251217112414.2374672-8-eperezma@redhat.com>
 <CACGkMEs6-j8h7X8navZGC0wraan4WSLO3NMFx++Fe0uaExWZmA@mail.gmail.com> <CAJaqyWccuSam1W6WpMF64QF1RmJtVMkfH_uvF56RKJzCzwer1w@mail.gmail.com>
In-Reply-To: <CAJaqyWccuSam1W6WpMF64QF1RmJtVMkfH_uvF56RKJzCzwer1w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Dec 2025 09:11:09 +0800
X-Gm-Features: AQt7F2oSNsfG2dpo9eCw5I5kQ3iSXiQIyxZ1yTB9y40Wz-nUXzN9EGZxP7qlyZM
Message-ID: <CACGkMEu1Lxun4aPza+kw7KrmLZJkfmW22KQNxbch+YhiTMkJZg@mail.gmail.com>
Subject: Re: [PATCH v10 7/8] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xPobu7VAEcdkxhZ2jMYU8dOqmT5bBNpvWvNfg3aZxmQ_1766452283
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 9:11=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Dec 18, 2025 at 7:45=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Dec 17, 2025 at 7:24=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Add support for assigning Address Space Identifiers (ASIDs) to each V=
Q
> > > group.  This enables mapping each group into a distinct memory space.
> > >
> > > The vq group to ASID association is protected by a rwlock now.  But t=
he
> > > mutex domain_lock keeps protecting the domains of all ASIDs, as some
> > > operations like the one related with the bounce buffer size still
> > > requires to lock all the ASIDs.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > >
> > > ---
> > > Future improvements can include performance optimizations on top coul=
d
> > > move to per-ASID locks, or hardening by tracking ASID or ASID hashes =
on
> > > unused bits of the DMA address.
> > >
> > > Tested virtio_vdpa by adding manually two threads in vduse_set_status=
:
> > > one of them modifies the vq group 0 ASID and the other one map and un=
map
> > > memory continuously.  After a while, the two threads stop and the usu=
al
> > > work continues.
> > >
> > > Tested with vhost_vdpa by migrating a VM while ping on OVS+VDUSE.  A =
few
> > > workaround were needed in some parts:
> > > * Do not enable CVQ before data vqs in QEMU, as VDUSE does not forwar=
d
> > >   the enable message to the userland device.  This will be solved in =
the
> > >   future.
> > > * Share the suspended state between all vhost devices in QEMU:
> > >   https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg02947.h=
tml
> > > * Implement a fake VDUSE suspend vdpa operation callback that always
> > >   returns true in the kernel.  DPDK suspend the device at the first
> > >   GET_VRING_BASE.
> > > * Remove the CVQ blocker in ASID.
> > >
> > > ---
> > > v10:
> > > * Back to rwlock version so stronger locks are used.
> > > * Take out allocations from rwlock.
> > > * Forbid changing ASID of a vq group after DRIVER_OK (Jason)
> > > * Remove bad fetching again of domain variable in
> > >   vduse_dev_max_mapping_size (Yongji).
> > > * Remove unused vdev definition in vdpa map_ops callbacks (kernel tes=
t
> > >   robot).
> > >
> > > v9:
> > > * Replace mutex with rwlock, as the vdpa map_ops can run from atomic
> > >   context.
> > >
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
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 366 +++++++++++++++++++--------=
--
> > >  include/uapi/linux/vduse.h         |  53 ++++-
> > >  2 files changed, 295 insertions(+), 124 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 767abcb7e375..786ab2378825 100644
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
> > > @@ -86,7 +87,15 @@ struct vduse_umem {
> > >         struct mm_struct *mm;
> > >  };
> > >
> > > +struct vduse_as {
> > > +       struct vduse_iova_domain *domain;
> > > +       struct vduse_umem *umem;
> > > +       struct mutex mem_lock;
> >
> > Not related to this patch. But If I was not wrong we have 1:1 mapping
> > between domain and as. If this is true, can we use bounce_lock instead
> > of a new mem_lock? Since I see mem_lock is only used for synchronizing
> > umem reg/degreg which has been synchronized with domain rwlock.
> >
>
> I think you're right, but they work at different levels at the moment.
> The mem_lock is at vduse_dev and also protect the umem pointer, and
> bounce_lock is at iova_domain.c .
>
> Maybe the right thing to do is to move umem in iova_domain. Yongji
> Xie, what do you think?
>
> > > +};
> > > +
> > >  struct vduse_vq_group {
> > > +       rwlock_t as_lock;
> > > +       struct vduse_as *as; /* Protected by as_lock */
> > >         struct vduse_dev *dev;
> > >  };
> > >
> > > @@ -94,7 +103,7 @@ struct vduse_dev {
> > >         struct vduse_vdpa *vdev;
> > >         struct device *dev;
> > >         struct vduse_virtqueue **vqs;
> > > -       struct vduse_iova_domain *domain;
> > > +       struct vduse_as *as;
> > >         char *name;
> > >         struct mutex lock;
> > >         spinlock_t msg_lock;
> > > @@ -122,9 +131,8 @@ struct vduse_dev {
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
> > > @@ -314,7 +322,7 @@ static int vduse_dev_set_status(struct vduse_dev =
*dev, u8 status)
> > >         return vduse_dev_msg_sync(dev, &msg);
> > >  }
> > >
> > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
> > >                                   u64 start, u64 last)
> > >  {
> > >         struct vduse_dev_msg msg =3D { 0 };
> > > @@ -323,8 +331,14 @@ static int vduse_dev_update_iotlb(struct vduse_d=
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
> > > @@ -436,14 +450,29 @@ static __poll_t vduse_dev_poll(struct file *fil=
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
> > > +       write_lock(&dev->groups[group].as_lock);
> > > +       dev->groups[group].as =3D &dev->as[asid];
> > > +       write_unlock(&dev->groups[group].as_lock);
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
> >
> > Btw, I see this:
> >
> > void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain)
> > {
> >         if (!domain->bounce_map)
> >                 return;
> >
> >         spin_lock(&domain->iotlb_lock);
> >         if (!domain->bounce_map)
> >                 goto unlock;
> >
> >
> > The counbe_map is checked twice, let's fix that.
> >
>
> Double checked locking to avoid taking the lock?

I don't know, but I think we don't care too much about the performance
of vduse_domain_reset_bounce_map().

> I don't think it is
> worth it to keep it as it is not in the hot path anyway. But that
> would also be another patch independent of this series, isn't it?

Yes, it's another independent issue I just found when reviewing this patch.

>
> > > +       }
> > > +
> > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> >
> > Note that this function still does:
> >
> >                 vq->vq_group =3D 0;
> >
> > Which is wrong.
> >
>
> Right, removing it for the next version. Thanks for the catch!
>
> > >
> > >         down_write(&dev->rwsem);
> > >
> > > @@ -623,6 +652,30 @@ static union virtio_map vduse_get_vq_map(struct =
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
> > > +           group >=3D dev->ngroups || asid >=3D dev->nas ||
> > > +           dev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> > > +               return -EINVAL;
> >
> > If we forbid setting group asid for !DRIVER_OK, why do we still need a
> > rwlock?
>
> virtio_map_ops->alloc is still called before DRIVER_OK to allocate the
> vrings in the bounce buffer, for example. If you're ok with that I'm
> ok with removing the lock, as all the calls are issued by the driver
> setup process anyway. Or just to keep it for alloc?

I see, then I think we need to keep that. The reason is that there's
no guarantee that the alloc() must be called before DRIVER_OK.

>
> Anyway, I think I misunderstood your comment from [1] then.
>
> > All we need to do is to synchronize set_group_asid() with
> > set_status()/reset()?
> >
>
> That's also a good one. There is no synchronization if one thread call
> reset and then the device is set up from another thread. As all this
> situation is still hypothetical because virtio_vdpa does not support
> set_group_asid,

Right.

> and vhost one is already protected by vhost lock, do
> we need it?

Let's add a TODO in the code.

>
> > Or if you want to synchronize map ops with set_status() that looks
> > like an independent thing (hardening).
> >
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
> >
> > I'm not sure this has been discussed before, but I think it would be
> > better to introduce a new ioctl to get group -> as mapping. This helps
> > to avoid vduse_dev_msg_sync() as much as possible. And it doesn't
> > require the userspace to poll vduse fd before DRIVER_OK.
> >
>
> I'm fine with that, but how do we communicate that they have changed?

Since we forbid changing the group->as mapping after DRIVER_OK,
userspace just needs to use that ioctl once after DRIVER_OK.

> Or how to communicate to the driver that the device does not accept
> the assignment of the ASID to the group?

See above.

>
> > > +       return 0;
> > > +}
> > > +
> > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx=
,
> > >                                 struct vdpa_vq_state *state)
> > >  {
> > > @@ -794,13 +847,13 @@ static int vduse_vdpa_set_map(struct vdpa_devic=
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
> > > @@ -843,6 +896,7 @@ static const struct vdpa_config_ops vduse_vdpa_co=
nfig_ops =3D {
> > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > >         .reset                  =3D vduse_vdpa_reset,
> > >         .set_map                =3D vduse_vdpa_set_map,
> > > +       .set_group_asid         =3D vduse_set_group_asid,
> > >         .get_vq_map             =3D vduse_get_vq_map,
> > >         .free                   =3D vduse_vdpa_free,
> > >  };
> > > @@ -851,32 +905,30 @@ static void vduse_dev_sync_single_for_device(un=
ion virtio_map token,
> > >                                              dma_addr_t dma_addr, siz=
e_t size,
> > >                                              enum dma_data_direction =
dir)
> > >  {
> > > -       struct vduse_dev *vdev;
> > >         struct vduse_iova_domain *domain;
> > >
> > >         if (!token.group)
> > >                 return;
> > >
> > > -       vdev =3D token.group->dev;
> > > -       domain =3D vdev->domain;
> > > -
> > > +       read_lock(&token.group->as_lock);
> >
> > I think we could optimize the lock here. E.g when nas is 1, we don't
> > need any lock in fact.
> >
>
> Good point! Not taking the lock in that case for the next version, thanks=
!
>
> > > +       domain =3D token.group->as->domain;
> > >         vduse_domain_sync_single_for_device(domain, dma_addr, size, d=
ir);
> > > +       read_unlock(&token.group->as_lock);
> > >  }
> > >
> > >  static void vduse_dev_sync_single_for_cpu(union virtio_map token,
> > >                                              dma_addr_t dma_addr, siz=
e_t size,
> > >                                              enum dma_data_direction =
dir)
> > >  {
> > > -       struct vduse_dev *vdev;
> > >         struct vduse_iova_domain *domain;
> > >
> > >         if (!token.group)
> > >                 return;
> > >
> > > -       vdev =3D token.group->dev;
> > > -       domain =3D vdev->domain;
> > > -
> > > +       read_lock(&token.group->as_lock);
> > > +       domain =3D token.group->as->domain;
> > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir)=
;
> > > +       read_unlock(&token.group->as_lock);
> > >  }
> > >
> > >  static dma_addr_t vduse_dev_map_page(union virtio_map token, struct =
page *page,
> > > @@ -884,38 +936,38 @@ static dma_addr_t vduse_dev_map_page(union virt=
io_map token, struct page *page,
> > >                                      enum dma_data_direction dir,
> > >                                      unsigned long attrs)
> > >  {
> > > -       struct vduse_dev *vdev;
> > >         struct vduse_iova_domain *domain;
> > > +       dma_addr_t r;
> > >
> > >         if (!token.group)
> > >                 return DMA_MAPPING_ERROR;
> > >
> > > -       vdev =3D token.group->dev;
> > > -       domain =3D vdev->domain;
> > > +       read_lock(&token.group->as_lock);
> > > +       domain =3D token.group->as->domain;
> > > +       r =3D vduse_domain_map_page(domain, page, offset, size, dir, =
attrs);
> > > +       read_unlock(&token.group->as_lock);
> > >
> > > -       return vduse_domain_map_page(domain, page, offset, size, dir,=
 attrs);
> > > +       return r;
> > >  }
> > >
> > >  static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t =
dma_addr,
> > >                                  size_t size, enum dma_data_direction=
 dir,
> > >                                  unsigned long attrs)
> > >  {
> > > -       struct vduse_dev *vdev;
> > >         struct vduse_iova_domain *domain;
> > >
> > >         if (!token.group)
> > >                 return;
> > >
> > > -       vdev =3D token.group->dev;
> > > -       domain =3D vdev->domain;
> > > -
> > > -       return vduse_domain_unmap_page(domain, dma_addr, size, dir, a=
ttrs);
> > > +       read_lock(&token.group->as_lock);
> > > +       domain =3D token.group->as->domain;
> > > +       vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
> > > +       read_unlock(&token.group->as_lock);
> > >  }
> > >
> > >  static void *vduse_dev_alloc_coherent(union virtio_map token, size_t=
 size,
> > >                                       dma_addr_t *dma_addr, gfp_t fla=
g)
> > >  {
> > > -       struct vduse_dev *vdev;
> > >         struct vduse_iova_domain *domain;
> > >         unsigned long iova;
> > >         void *addr;
> > > @@ -928,18 +980,21 @@ static void *vduse_dev_alloc_coherent(union vir=
tio_map token, size_t size,
> > >         if (!addr)
> > >                 return NULL;
> > >
> > > -       vdev =3D token.group->dev;
> > > -       domain =3D vdev->domain;
> > > +       *dma_addr =3D (dma_addr_t)iova;
> >
> > Any reason we need to touch *dma_addr here? It might trigger UBSAN/KMSA=
N.
> >
>
> No, this is a leftover. I'm fixing it for the next version. Thanks!
>
> > > +       read_lock(&token.group->as_lock);
> > > +       domain =3D token.group->as->domain;
> > >         addr =3D vduse_domain_alloc_coherent(domain, size,
> > >                                            (dma_addr_t *)&iova, addr)=
;
> > >         if (!addr)
> > >                 goto err;
> > >
> > >         *dma_addr =3D (dma_addr_t)iova;
> > > +       read_unlock(&token.group->as_lock);
> > >
> > >         return addr;
> > >
> > >  err:
> > > +       read_unlock(&token.group->as_lock);
> > >         free_pages_exact(addr, size);
> > >         return NULL;
> > >  }
> > > @@ -948,31 +1003,30 @@ static void vduse_dev_free_coherent(union virt=
io_map token, size_t size,
> > >                                     void *vaddr, dma_addr_t dma_addr,
> > >                                     unsigned long attrs)
> > >  {
> > > -       struct vduse_dev *vdev;
> > >         struct vduse_iova_domain *domain;
> > >
> > >         if (!token.group)
> > >                 return;
> > >
> > > -       vdev =3D token.group->dev;
> > > -       domain =3D vdev->domain;
> > > -
> > > +       read_lock(&token.group->as_lock);
> > > +       domain =3D token.group->as->domain;
> > >         vduse_domain_free_coherent(domain, size, dma_addr, attrs);
> > > +       read_unlock(&token.group->as_lock);
> > >         free_pages_exact(vaddr, size);
> > >  }
> > >
> > >  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t d=
ma_addr)
> > >  {
> > > -       struct vduse_dev *vdev;
> > > -       struct vduse_iova_domain *domain;
> > > +       size_t bounce_size;
> > >
> > >         if (!token.group)
> > >                 return false;
> > >
> > > -       vdev =3D token.group->dev;
> > > -       domain =3D vdev->domain;
> > > +       read_lock(&token.group->as_lock);
> > > +       bounce_size =3D token.group->as->domain->bounce_size;
> > > +       read_unlock(&token.group->as_lock);
> > >
> > > -       return dma_addr < domain->bounce_size;
> > > +       return dma_addr < bounce_size;
> > >  }
> > >
> > >  static int vduse_dev_mapping_error(union virtio_map token, dma_addr_=
t dma_addr)
> > > @@ -984,16 +1038,16 @@ static int vduse_dev_mapping_error(union virti=
o_map token, dma_addr_t dma_addr)
> > >
> > >  static size_t vduse_dev_max_mapping_size(union virtio_map token)
> > >  {
> > > -       struct vduse_dev *vdev;
> > > -       struct vduse_iova_domain *domain;
> > > +       size_t bounce_size;
> > >
> > >         if (!token.group)
> > >                 return 0;
> > >
> > > -       vdev =3D token.group->dev;
> > > -       domain =3D vdev->domain;
> > > +       read_lock(&token.group->as_lock);
> > > +       bounce_size =3D token.group->as->domain->bounce_size;
> > > +       read_unlock(&token.group->as_lock);
> > >
> > > -       return domain->bounce_size;
> > > +       return bounce_size;
> > >  }
> > >
> > >  static const struct virtio_map_ops vduse_map_ops =3D {
> > > @@ -1133,39 +1187,40 @@ static int vduse_dev_queue_irq_work(struct vd=
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
> > > -       mutex_lock(&dev->mem_lock);
> > > +       mutex_lock(&dev->as[asid].mem_lock);
> > >         ret =3D -ENOENT;
> > > -       if (!dev->umem)
> > > +       if (!dev->as[asid].umem)
> > >                 goto unlock;
> > >
> > >         ret =3D -EINVAL;
> > > -       if (!dev->domain)
> > > +       if (!dev->as[asid].domain)
> > >                 goto unlock;
> > >
> > > -       if (dev->umem->iova !=3D iova || size !=3D dev->domain->bounc=
e_size)
> > > +       if (dev->as[asid].umem->iova !=3D iova ||
> > > +           size !=3D dev->as[asid].domain->bounce_size)
> > >                 goto unlock;
> > >
> > > -       vduse_domain_remove_user_bounce_pages(dev->domain);
> > > -       unpin_user_pages_dirty_lock(dev->umem->pages,
> > > -                                   dev->umem->npages, true);
> > > -       atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
> > > -       mmdrop(dev->umem->mm);
> > > -       vfree(dev->umem->pages);
> > > -       kfree(dev->umem);
> > > -       dev->umem =3D NULL;
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
> > > -       mutex_unlock(&dev->mem_lock);
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
> > > @@ -1173,14 +1228,14 @@ static int vduse_dev_reg_umem(struct vduse_de=
v *dev,
> > >         unsigned long npages, lock_limit;
> > >         int ret;
> > >
> > > -       if (!dev->domain || !dev->domain->bounce_map ||
> > > -           size !=3D dev->domain->bounce_size ||
> > > +       if (!dev->as[asid].domain || !dev->as[asid].domain->bounce_ma=
p ||
> > > +           size !=3D dev->as[asid].domain->bounce_size ||
> > >             iova !=3D 0 || uaddr & ~PAGE_MASK)
> > >                 return -EINVAL;
> > >
> > > -       mutex_lock(&dev->mem_lock);
> > > +       mutex_lock(&dev->as[asid].mem_lock);
> > >         ret =3D -EEXIST;
> > > -       if (dev->umem)
> > > +       if (dev->as[asid].umem)
> > >                 goto unlock;
> > >
> > >         ret =3D -ENOMEM;
> > > @@ -1204,7 +1259,7 @@ static int vduse_dev_reg_umem(struct vduse_dev =
*dev,
> > >                 goto out;
> > >         }
> > >
> > > -       ret =3D vduse_domain_add_user_bounce_pages(dev->domain,
> > > +       ret =3D vduse_domain_add_user_bounce_pages(dev->as[asid].doma=
in,
> > >                                                  page_list, pinned);
> > >         if (ret)
> > >                 goto out;
> > > @@ -1217,7 +1272,7 @@ static int vduse_dev_reg_umem(struct vduse_dev =
*dev,
> > >         umem->mm =3D current->mm;
> > >         mmgrab(current->mm);
> > >
> > > -       dev->umem =3D umem;
> > > +       dev->as[asid].umem =3D umem;
> > >  out:
> > >         if (ret && pinned > 0)
> > >                 unpin_user_pages(page_list, pinned);
> > > @@ -1228,7 +1283,7 @@ static int vduse_dev_reg_umem(struct vduse_dev =
*dev,
> > >                 vfree(page_list);
> > >                 kfree(umem);
> > >         }
> > > -       mutex_unlock(&dev->mem_lock);
> > > +       mutex_unlock(&dev->as[asid].mem_lock);
> > >         return ret;
> > >  }
> > >
> > > @@ -1260,47 +1315,66 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> > >
> > >         switch (cmd) {
> > >         case VDUSE_IOTLB_GET_FD: {
> > > -               struct vduse_iotlb_entry entry;
> > > +               struct vduse_iotlb_entry_v2 entry;
> >
> > Nit: if we stick entry and do copy_from_user() twice it might save
> > lots of unnecessary changes.
> >
>
> I'm happy to move to something else but most of the changes happen
> because of s/entry/entry.v1/ . If we stick with just vduse_iotlb_entry
> and a separate asid variable, we also need to duplicate the
> copy_from_user [2].
>
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
> > > -               if (!dev->domain) {
> > > +               asid =3D array_index_nospec(entry.asid, dev->nas);
> > > +               if (!dev->as[asid].domain) {
> > >                         mutex_unlock(&dev->domain_lock);
> > >                         break;
> > >                 }
> > > -               spin_lock(&dev->domain->iotlb_lock);
> > > -               map =3D vhost_iotlb_itree_first(dev->domain->iotlb,
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
> > > -               spin_unlock(&dev->domain->iotlb_lock);
> > > +               spin_unlock(&dev->as[asid].domain->iotlb_lock);
> > >                 mutex_unlock(&dev->domain_lock);
> > >                 ret =3D -EINVAL;
> > >                 if (!f)
> > >                         break;
> > >
> > > -               ret =3D -EFAULT;
> > > -               if (copy_to_user(argp, &entry, sizeof(entry))) {
> > > +               if (dev->api_version >=3D VDUSE_API_VERSION_1)
> > > +                       ret =3D copy_to_user(argp, &entry,
> > > +                                          sizeof(entry));
> > > +               else
> > > +                       ret =3D copy_to_user(argp, &entry.v1,
> > > +                                          sizeof(entry.v1));
> > > +
> > > +               if (ret) {
> > > +                       ret =3D -EFAULT;
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
> > > @@ -1445,6 +1519,7 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> > >         }
> > >         case VDUSE_IOTLB_REG_UMEM: {
> > >                 struct vduse_iova_umem umem;
> > > +               u32 asid;
> > >
> > >                 ret =3D -EFAULT;
> > >                 if (copy_from_user(&umem, argp, sizeof(umem)))
> > > @@ -1452,17 +1527,21 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> > >
> > >                 ret =3D -EINVAL;
> > >                 if (!is_mem_zero((const char *)umem.reserved,
> > > -                                sizeof(umem.reserved)))
> > > +                                sizeof(umem.reserved)) ||
> > > +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> > > +                    umem.asid !=3D 0) || umem.asid >=3D dev->nas)
> > >                         break;
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
> > > @@ -1470,10 +1549,15 @@ static long vduse_dev_ioctl(struct file *file=
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
> > > @@ -1481,6 +1565,7 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> > >         case VDUSE_IOTLB_GET_INFO: {
> >
> > Btw I see this:
> >
> >                 dev->vqs[index]->vq_group =3D config.group;
> >
> > In VDUSE_VQ_SETUP:
> >
> > I wonder what's the reason that it is not a part of CREATE_DEV? I
> > meant it might be racy if DMA happens between CREATE_DEV and
> > VDUSE_VQ_SETUP.
> >
>
> The reason the vq index -> vq group association cannot be part of
> device creation is that we need CVQ to be isolated for live migration,
> but the device doesn't know the CVQ index at the CREATE_DEV time, only
> after the feature negotiation happens [3].

Exactly, the cvq index is changed.

>
> [1] https://lore.kernel.org/lkml/CACGkMEvRQ86dYeY3Enqoj1vkSpefU3roq4XGS+y=
5B5kmsXEkYg@mail.gmail.com/
> [2] https://lore.kernel.org/lkml/CACGkMEtszQeZLTegxEbjODYxu-giTvURu=3DpKj=
4kYTHQYoKOzkQ@mail.gmail.com
> [3] https://lore.kernel.org/lkml/CAJaqyWcvHx7kwcTceN2jazT0nKNo1r5zdzqWHqp=
xdna-kCS1RA@mail.gmail.com

I see, but a question. What happens if there's a DMA between
CREATE_DEV and VDUSE_VQ_SETUP. If we can find ways to forbid this (or
it has been forbidden), we are probably fine.

>
> > >                 struct vduse_iova_info info;
> > >                 struct vhost_iotlb_map *map;
> > > +               u32 asid;
> > >
> > >                 ret =3D -EFAULT;
> > >                 if (copy_from_user(&info, argp, sizeof(info)))
> > > @@ -1494,23 +1579,31 @@ static long vduse_dev_ioctl(struct file *file=
, unsigned int cmd,
> > >                                  sizeof(info.reserved)))
> > >                         break;
> > >
> > > +               if (dev->api_version < VDUSE_API_VERSION_1) {
> > > +                       if (info.asid)
> > > +                               break;
> > > +               } else if (info.asid >=3D dev->nas)
> > > +                       break;
> > > +
> > >                 mutex_lock(&dev->domain_lock);
> > > -               if (!dev->domain) {
> > > +               asid =3D array_index_nospec(info.asid, dev->nas);
> > > +               if (!dev->as[asid].domain) {
> > >                         mutex_unlock(&dev->domain_lock);
> > >                         break;
> > >                 }
> > > -               spin_lock(&dev->domain->iotlb_lock);
> > > -               map =3D vhost_iotlb_itree_first(dev->domain->iotlb,
> > > +               spin_lock(&dev->as[asid].domain->iotlb_lock);
> > > +               map =3D vhost_iotlb_itree_first(dev->as[asid].domain-=
>iotlb,
> > >                                               info.start, info.last);
> > >                 if (map) {
> > >                         info.start =3D map->start;
> > >                         info.last =3D map->last;
> > >                         info.capability =3D 0;
> > > -                       if (dev->domain->bounce_map && map->start =3D=
=3D 0 &&
> > > -                           map->last =3D=3D dev->domain->bounce_size=
 - 1)
> > > +                       if (dev->as[asid].domain->bounce_map &&
> > > +                           map->start =3D=3D 0 &&
> > > +                           map->last =3D=3D dev->as[asid].domain->bo=
unce_size - 1)
> > >                                 info.capability |=3D VDUSE_IOVA_CAP_U=
MEM;
> > >                 }
> > > -               spin_unlock(&dev->domain->iotlb_lock);
> > > +               spin_unlock(&dev->as[asid].domain->iotlb_lock);
> > >                 mutex_unlock(&dev->domain_lock);
> > >                 if (!map)
> > >                         break;
> > > @@ -1535,8 +1628,10 @@ static int vduse_dev_release(struct inode *ino=
de, struct file *file)
> > >         struct vduse_dev *dev =3D file->private_data;
> > >
> > >         mutex_lock(&dev->domain_lock);
> > > -       if (dev->domain)
> > > -               vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size=
);
> > > +       for (int i =3D 0; i < dev->nas; i++)
> > > +               if (dev->as[i].domain)
> > > +                       vduse_dev_dereg_umem(dev, i, 0,
> > > +                                            dev->as[i].domain->bounc=
e_size);
> > >         mutex_unlock(&dev->domain_lock);
> > >         spin_lock(&dev->msg_lock);
> > >         /* Make sure the inflight messages can processed after reconn=
cection */
> > > @@ -1755,7 +1850,6 @@ static struct vduse_dev *vduse_dev_create(void)
> > >                 return NULL;
> > >
> > >         mutex_init(&dev->lock);
> > > -       mutex_init(&dev->mem_lock);
> > >         mutex_init(&dev->domain_lock);
> > >         spin_lock_init(&dev->msg_lock);
> > >         INIT_LIST_HEAD(&dev->send_list);
> > > @@ -1806,8 +1900,11 @@ static int vduse_destroy_dev(char *name)
> > >         idr_remove(&vduse_idr, dev->minor);
> > >         kvfree(dev->config);
> > >         vduse_dev_deinit_vqs(dev);
> > > -       if (dev->domain)
> > > -               vduse_domain_destroy(dev->domain);
> > > +       for (int i =3D 0; i < dev->nas; i++) {
> > > +               if (dev->as[i].domain)
> > > +                       vduse_domain_destroy(dev->as[i].domain);
> > > +       }
> > > +       kfree(dev->as);
> > >         kfree(dev->name);
> > >         kfree(dev->groups);
> > >         vduse_dev_destroy(dev);
> > > @@ -1854,12 +1951,17 @@ static bool vduse_validate_config(struct vdus=
e_dev_config *config,
> > >                          sizeof(config->reserved)))
> > >                 return false;
> > >
> > > -       if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> > > +       if (api_version < VDUSE_API_VERSION_1 &&
> > > +           (config->ngroups || config->nas))
> > >                 return false;
> > >
> > > -       if (api_version >=3D VDUSE_API_VERSION_1 &&
> > > -           (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GROU=
PS))
> > > -               return false;
> > > +       if (api_version >=3D VDUSE_API_VERSION_1) {
> > > +               if (!config->ngroups || config->ngroups > VDUSE_DEV_M=
AX_GROUPS)
> > > +                       return false;
> > > +
> > > +               if (!config->nas || config->nas > VDUSE_DEV_MAX_AS)
> > > +                       return false;
> > > +       }
> > >
> > >         if (config->vq_align > PAGE_SIZE)
> > >                 return false;
> > > @@ -1924,7 +2026,8 @@ static ssize_t bounce_size_store(struct device =
*device,
> > >
> > >         ret =3D -EPERM;
> > >         mutex_lock(&dev->domain_lock);
> > > -       if (dev->domain)
> > > +       /* Assuming that if the first domain is allocated, all are al=
located */
> > > +       if (dev->as[0].domain)
> > >                 goto unlock;
> >
> > Not for this patch but I don't understand why we need to check dev->dom=
ain here.
> >
>
> I guess you need to know the bounce size before you allocate the
> domain. To make shrink logic for it seems not to be worth it, but
> maybe I'm missing something.

Right.

Thanks

