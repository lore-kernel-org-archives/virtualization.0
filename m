Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA23F190462
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766561953; cv=none; b=sj2G3I8HTVRXlDGBQz7DuuVyYbEURnGrQZwsM7/N6LbTJoy9uAHVrX7dkEpts8aJkcjo/VhXDiMHksnYN5SJb1xEecOHygB7hDLqwlpjZGeTu0SIloelp+jMf6qw+1+6X1W08uWJm+0daREojvShR4CAmhiyIiwQGrGIsvBsJZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766561953; c=relaxed/simple;
	bh=lViW/nunYaoJm8zuKn8eBewFpRXixj8ntxspXTPBA8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/soochX0EU0nCS/7ugFs/W0ONyCA3CYkELm13Hn1h1ZfG5MoxSd4MCKcMKtYJQVLkRjBa44ZzDJHWhbi1pE8ZuUS7J3Y0VLg/oHdcz0qEvM0WehCkrXUhAan/IIn59pfCsKTsazfJFdzoDeNQF68WIJ/vYY88kU++Ci5w+BhX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SVHljleo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVHljleo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766561949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sC0PCdkDHeE1n9Z2FVyzdApoj6E1QfOYm+P0qBvXeeQ=;
	b=SVHljleosIm3yH18BCGlh5YHEoE7cxVz+yvZ4Pu6qbmUw4/UwSE/9xa/H6ATzdbC0sGDlc
	uMvznY0tYdxTgCaRvtaPRyb8dFTmkIYnT/wWC/3Rl6X9xX4ZxysNy3fUgzmWGAVuqNcsB1
	Y5TA8WV9tY2uHS5s77Q+/2y3qRKJwlw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-KsdDdkaxPFCEjXTsS2SJHg-1; Wed, 24 Dec 2025 02:39:05 -0500
X-MC-Unique: KsdDdkaxPFCEjXTsS2SJHg-1
X-Mimecast-MFC-AGG-ID: KsdDdkaxPFCEjXTsS2SJHg_1766561945
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-78fc5fa98baso47217367b3.1
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 23:39:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766561945; x=1767166745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sC0PCdkDHeE1n9Z2FVyzdApoj6E1QfOYm+P0qBvXeeQ=;
        b=q1jzWLRf4aCb/+VpjDbDAZ60IPmylDMnN6l53l638QJjU3mdav3S5pcXb3EddWiE8V
         fcr+pj9CvjuObHq1ZL3aQNMFlAAl9jr8yBnt3TJ49Zhcv0HLFlwd5uopbxO42TP/LrVG
         VCRkOBy2RWuCntRcO9k65Q8GwgQjEQZjjJF/jA5nzZ4qeYz9dRJORAkxBsjiPsB2rju2
         bT4u76k6+oA8ljiwt2OQHoqglGvY+O4lJX2uwYj786jy9SnZdFyGum2rQpMHj9CmE/Hz
         hB/2x24x8L80odrbU0Pu+KHdo7N2dl6igGFbPlVWOWrEHPtTkcNYe6MUVOSMWWAH9v6T
         lnPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQnf+vUtlfRmi+WkUEmOX6lUQCzbJRbdVnGBBvEF8ImEaeYG3iA396sNuABjpvRITIZoqdmWJfe4lZOO59PQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPEcKTOIGfS4N9SPDKkEQIQQ7S+WLXDG9B3jVRA5kxIqk3omxq
	1unPl6+7Ih9y2jHMGDKjvdgkYeXoIBcbtdryS7TXaUjjrtBXVSC2LneFeLtT+EKQ07v1Q+Xubtg
	B7wMIyAyJLc9p92Ngptdjxu/cZh85idYmLMtfIUvBmLm36A7GnbLfyjTv1UQHs05uso9KqHkhI8
	k7OF24X6ntyjxP9uGv6rzkl/EWatbDBuKohlJNrpr0Wz8=
X-Gm-Gg: AY/fxX40mk8N+gNveBCjilXeJhBh3D2rew6hqUboFMPcytGa8QdgWtP+sYD9v2D2dV7
	QDO9L5+kO9pquWMkF5ypSsjy6b/Xwo6vbfOQRSGpO3VQCOYIsgEia3+MbWni4dAlmIyEQ2So9QV
	EsEJPcYWAWcgOCbBh2Asln0DhClIL5VL5AWZeOxVn5j2J15D1WnBxWOSVSLqcyFVm35Q==
X-Received: by 2002:a05:690c:6c8b:b0:78e:1aa5:e98a with SMTP id 00721157ae682-78fb403b9b6mr333402397b3.37.1766561944575;
        Tue, 23 Dec 2025 23:39:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESWt8/h0Ta8bXHgL8o2w3bzfDkX/A3dD1KUxdP+WYOkwN+PCl8YlHs8Z6+7U02ykvfI74QNmrGamGTP253yOA=
X-Received: by 2002:a05:690c:6c8b:b0:78e:1aa5:e98a with SMTP id
 00721157ae682-78fb403b9b6mr333402047b3.37.1766561943839; Tue, 23 Dec 2025
 23:39:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251217112414.2374672-1-eperezma@redhat.com> <20251217112414.2374672-8-eperezma@redhat.com>
 <CACGkMEs6-j8h7X8navZGC0wraan4WSLO3NMFx++Fe0uaExWZmA@mail.gmail.com>
 <CAJaqyWccuSam1W6WpMF64QF1RmJtVMkfH_uvF56RKJzCzwer1w@mail.gmail.com>
 <CACGkMEu1Lxun4aPza+kw7KrmLZJkfmW22KQNxbch+YhiTMkJZg@mail.gmail.com>
 <CAJaqyWe=YSV-gRqOra-yiiBFKR793pHJDT7t8mDTrrFKjzZ=Ow@mail.gmail.com> <CACGkMEvXdV4ukZE6xhLL0sSN70G=AWVQgpRnH98Fr4btzMkK9g@mail.gmail.com>
In-Reply-To: <CACGkMEvXdV4ukZE6xhLL0sSN70G=AWVQgpRnH98Fr4btzMkK9g@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 24 Dec 2025 08:38:27 +0100
X-Gm-Features: AQt7F2r5J6v1t6au2h4S4KfX75zXH4yUWHHXfGiWgjLYMc7bLe_SVfyStX6cuJY
Message-ID: <CAJaqyWf-MtnisowpBxjKDM1ULmFVkP4ODWVJiopTSJ7_d6M+aw@mail.gmail.com>
Subject: Re: [PATCH v10 7/8] vduse: add vq group asid support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wMI9XcXz2DqpfwGc8bfKDeDlhhr7uQquvpQbiKob1qA_1766561945
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 1:20=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Dec 23, 2025 at 9:16=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Tue, Dec 23, 2025 at 2:11=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Thu, Dec 18, 2025 at 9:11=E2=80=AFPM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Thu, Dec 18, 2025 at 7:45=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Wed, Dec 17, 2025 at 7:24=E2=80=AFPM Eugenio P=C3=A9rez <epere=
zma@redhat.com> wrote:
> > > > > >
> > > > > > Add support for assigning Address Space Identifiers (ASIDs) to =
each VQ
> > > > > > group.  This enables mapping each group into a distinct memory =
space.
> > > > > >
> > > > > > The vq group to ASID association is protected by a rwlock now. =
 But the
> > > > > > mutex domain_lock keeps protecting the domains of all ASIDs, as=
 some
> > > > > > operations like the one related with the bounce buffer size sti=
ll
> > > > > > requires to lock all the ASIDs.
> > > > > >
> > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > >
> > > > > > ---
> > > > > > Future improvements can include performance optimizations on to=
p could
> > > > > > move to per-ASID locks, or hardening by tracking ASID or ASID h=
ashes on
> > > > > > unused bits of the DMA address.
> > > > > >
> > > > > > Tested virtio_vdpa by adding manually two threads in vduse_set_=
status:
> > > > > > one of them modifies the vq group 0 ASID and the other one map =
and unmap
> > > > > > memory continuously.  After a while, the two threads stop and t=
he usual
> > > > > > work continues.
> > > > > >
> > > > > > Tested with vhost_vdpa by migrating a VM while ping on OVS+VDUS=
E.  A few
> > > > > > workaround were needed in some parts:
> > > > > > * Do not enable CVQ before data vqs in QEMU, as VDUSE does not =
forward
> > > > > >   the enable message to the userland device.  This will be solv=
ed in the
> > > > > >   future.
> > > > > > * Share the suspended state between all vhost devices in QEMU:
> > > > > >   https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg0=
2947.html
> > > > > > * Implement a fake VDUSE suspend vdpa operation callback that a=
lways
> > > > > >   returns true in the kernel.  DPDK suspend the device at the f=
irst
> > > > > >   GET_VRING_BASE.
> > > > > > * Remove the CVQ blocker in ASID.
> > > > > >
> > > > > > ---
> > > > > > v10:
> > > > > > * Back to rwlock version so stronger locks are used.
> > > > > > * Take out allocations from rwlock.
> > > > > > * Forbid changing ASID of a vq group after DRIVER_OK (Jason)
> > > > > > * Remove bad fetching again of domain variable in
> > > > > >   vduse_dev_max_mapping_size (Yongji).
> > > > > > * Remove unused vdev definition in vdpa map_ops callbacks (kern=
el test
> > > > > >   robot).
> > > > > >
> > > > > > v9:
> > > > > > * Replace mutex with rwlock, as the vdpa map_ops can run from a=
tomic
> > > > > >   context.
> > > > > >
> > > > > > v8:
> > > > > > * Revert the mutex to rwlock change, it needs proper profiling =
to
> > > > > >   justify it.
> > > > > >
> > > > > > v7:
> > > > > > * Take write lock in the error path (Jason).
> > > > > >
> > > > > > v6:
> > > > > > * Make vdpa_dev_add use gotos for error handling (MST).
> > > > > > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VERS=
ION_1) ?/
> > > > > >   (MST).
> > > > > > * Fix struct name not matching in the doc.
> > > > > >
> > > > > > v5:
> > > > > > * Properly return errno if copy_to_user returns >0 in VDUSE_IOT=
LB_GET_FD
> > > > > >   ioctl (Jason).
> > > > > > * Properly set domain bounce size to divide equally between nas=
 (Jason).
> > > > > > * Exclude "padding" member from the only >V1 members in
> > > > > >   vduse_dev_request.
> > > > > >
> > > > > > v4:
> > > > > > * Divide each domain bounce size between the device bounce size=
 (Jason).
> > > > > > * revert unneeded addr =3D NULL assignment (Jason)
> > > > > > * Change if (x && (y || z)) return to if (x) { if (y) return; i=
f (z)
> > > > > >   return; } (Jason)
> > > > > > * Change a bad multiline comment, using @ caracter instead of *=
 (Jason).
> > > > > > * Consider config->nas =3D=3D 0 as a fail (Jason).
> > > > > >
> > > > > > v3:
> > > > > > * Get the vduse domain through the vduse_as in the map function=
s
> > > > > >   (Jason).
> > > > > > * Squash with the patch creating the vduse_as struct (Jason).
> > > > > > * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic n=
umber
> > > > > >   (Jason)
> > > > > >
> > > > > > v2:
> > > > > > * Convert the use of mutex to rwlock.
> > > > > >
> > > > > > RFC v3:
> > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to=
 a lower
> > > > > >   value to reduce memory consumption, but vqs are already limit=
ed to
> > > > > >   that value and userspace VDUSE is able to allocate that many =
vqs.
> > > > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > > > > >   VDUSE_IOTLB_GET_INFO.
> > > > > > * Use of array_index_nospec in VDUSE device ioctls.
> > > > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > > > > * Move the umem mutex to asid struct so there is no contention =
between
> > > > > >   ASIDs.
> > > > > >
> > > > > > RFC v2:
> > > > > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the =
first
> > > > > >   part of the struct is the same.
> > > > > > ---
> > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 366 +++++++++++++++++++--=
--------
> > > > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > > > >  2 files changed, 295 insertions(+), 124 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/=
vdpa_user/vduse_dev.c
> > > > > > index 767abcb7e375..786ab2378825 100644
> > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > @@ -41,6 +41,7 @@
> > > > > >
> > > > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > > > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > > > @@ -86,7 +87,15 @@ struct vduse_umem {
> > > > > >         struct mm_struct *mm;
> > > > > >  };
> > > > > >
> > > > > > +struct vduse_as {
> > > > > > +       struct vduse_iova_domain *domain;
> > > > > > +       struct vduse_umem *umem;
> > > > > > +       struct mutex mem_lock;
> > > > >
> > > > > Not related to this patch. But If I was not wrong we have 1:1 map=
ping
> > > > > between domain and as. If this is true, can we use bounce_lock in=
stead
> > > > > of a new mem_lock? Since I see mem_lock is only used for synchron=
izing
> > > > > umem reg/degreg which has been synchronized with domain rwlock.
> > > > >
> > > >
> > > > I think you're right, but they work at different levels at the mome=
nt.
> > > > The mem_lock is at vduse_dev and also protect the umem pointer, and
> > > > bounce_lock is at iova_domain.c .
> > > >
> > > > Maybe the right thing to do is to move umem in iova_domain. Yongji
> > > > Xie, what do you think?
> > > >
> > > > > > +};
> > > > > > +
> > > > > >  struct vduse_vq_group {
> > > > > > +       rwlock_t as_lock;
> > > > > > +       struct vduse_as *as; /* Protected by as_lock */
> > > > > >         struct vduse_dev *dev;
> > > > > >  };
> > > > > >
> > > > > > @@ -94,7 +103,7 @@ struct vduse_dev {
> > > > > >         struct vduse_vdpa *vdev;
> > > > > >         struct device *dev;
> > > > > >         struct vduse_virtqueue **vqs;
> > > > > > -       struct vduse_iova_domain *domain;
> > > > > > +       struct vduse_as *as;
> > > > > >         char *name;
> > > > > >         struct mutex lock;
> > > > > >         spinlock_t msg_lock;
> > > > > > @@ -122,9 +131,8 @@ struct vduse_dev {
> > > > > >         u32 vq_num;
> > > > > >         u32 vq_align;
> > > > > >         u32 ngroups;
> > > > > > -       struct vduse_umem *umem;
> > > > > > +       u32 nas;
> > > > > >         struct vduse_vq_group *groups;
> > > > > > -       struct mutex mem_lock;
> > > > > >         unsigned int bounce_size;
> > > > > >         struct mutex domain_lock;
> > > > > >  };
> > > > > > @@ -314,7 +322,7 @@ static int vduse_dev_set_status(struct vdus=
e_dev *dev, u8 status)
> > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > >  }
> > > > > >
> > > > > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > > > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 a=
sid,
> > > > > >                                   u64 start, u64 last)
> > > > > >  {
> > > > > >         struct vduse_dev_msg msg =3D { 0 };
> > > > > > @@ -323,8 +331,14 @@ static int vduse_dev_update_iotlb(struct v=
duse_dev *dev,
> > > > > >                 return -EINVAL;
> > > > > >
> > > > > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > > > > -       msg.req.iova.start =3D start;
> > > > > > -       msg.req.iova.last =3D last;
> > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > > > > +               msg.req.iova.start =3D start;
> > > > > > +               msg.req.iova.last =3D last;
> > > > > > +       } else {
> > > > > > +               msg.req.iova_v2.start =3D start;
> > > > > > +               msg.req.iova_v2.last =3D last;
> > > > > > +               msg.req.iova_v2.asid =3D asid;
> > > > > > +       }
> > > > > >
> > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > >  }
> > > > > > @@ -436,14 +450,29 @@ static __poll_t vduse_dev_poll(struct fil=
e *file, poll_table *wait)
> > > > > >         return mask;
> > > > > >  }
> > > > > >
> > > > > > +/* Force set the asid to a vq group without a message to the V=
DUSE device */
> > > > > > +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> > > > > > +                                      unsigned int group, unsi=
gned int asid)
> > > > > > +{
> > > > > > +       write_lock(&dev->groups[group].as_lock);
> > > > > > +       dev->groups[group].as =3D &dev->as[asid];
> > > > > > +       write_unlock(&dev->groups[group].as_lock);
> > > > > > +}
> > > > > > +
> > > > > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > > > > >  {
> > > > > >         int i;
> > > > > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > > > > >
> > > > > >         /* The coherent mappings are handled in vduse_dev_free_=
coherent() */
> > > > > > -       if (domain && domain->bounce_map)
> > > > > > -               vduse_domain_reset_bounce_map(domain);
> > > > > > +       for (i =3D 0; i < dev->nas; i++) {
> > > > > > +               struct vduse_iova_domain *domain =3D dev->as[i]=
.domain;
> > > > > > +
> > > > > > +               if (domain && domain->bounce_map)
> > > > > > +                       vduse_domain_reset_bounce_map(domain);
> > > > >
> > > > > Btw, I see this:
> > > > >
> > > > > void vduse_domain_reset_bounce_map(struct vduse_iova_domain *doma=
in)
> > > > > {
> > > > >         if (!domain->bounce_map)
> > > > >                 return;
> > > > >
> > > > >         spin_lock(&domain->iotlb_lock);
> > > > >         if (!domain->bounce_map)
> > > > >                 goto unlock;
> > > > >
> > > > >
> > > > > The counbe_map is checked twice, let's fix that.
> > > > >
> > > >
> > > > Double checked locking to avoid taking the lock?
> > >
> > > I don't know, but I think we don't care too much about the performanc=
e
> > > of vduse_domain_reset_bounce_map().
> > >
> > > > I don't think it is
> > > > worth it to keep it as it is not in the hot path anyway. But that
> > > > would also be another patch independent of this series, isn't it?
> > >
> > > Yes, it's another independent issue I just found when reviewing this =
patch.
> > >
> > > >
> > > > > > +       }
> > > > > > +
> > > > > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > > > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> > > > >
> > > > > Note that this function still does:
> > > > >
> > > > >                 vq->vq_group =3D 0;
> > > > >
> > > > > Which is wrong.
> > > > >
> > > >
> > > > Right, removing it for the next version. Thanks for the catch!
> > > >
> > > > > >
> > > > > >         down_write(&dev->rwsem);
> > > > > >
> > > > > > @@ -623,6 +652,30 @@ static union virtio_map vduse_get_vq_map(s=
truct vdpa_device *vdpa, u16 idx)
> > > > > >         return ret;
> > > > > >  }
> > > > > >
> > > > > > +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsi=
gned int group,
> > > > > > +                               unsigned int asid)
> > > > > > +{
> > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > +       int r;
> > > > > > +
> > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > > > > +           group >=3D dev->ngroups || asid >=3D dev->nas ||
> > > > > > +           dev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> > > > > > +               return -EINVAL;
> > > > >
> > > > > If we forbid setting group asid for !DRIVER_OK, why do we still n=
eed a
> > > > > rwlock?
> > > >
> > > > virtio_map_ops->alloc is still called before DRIVER_OK to allocate =
the
> > > > vrings in the bounce buffer, for example. If you're ok with that I'=
m
> > > > ok with removing the lock, as all the calls are issued by the drive=
r
> > > > setup process anyway. Or just to keep it for alloc?
> > >
> > > I see, then I think we need to keep that. The reason is that there's
> > > no guarantee that the alloc() must be called before DRIVER_OK.
> > >
> > > >
> > > > Anyway, I think I misunderstood your comment from [1] then.
> > > >
> > > > > All we need to do is to synchronize set_group_asid() with
> > > > > set_status()/reset()?
> > > > >
> > > >
> > > > That's also a good one. There is no synchronization if one thread c=
all
> > > > reset and then the device is set up from another thread. As all thi=
s
> > > > situation is still hypothetical because virtio_vdpa does not suppor=
t
> > > > set_group_asid,
> > >
> > > Right.
> > >
> > > > and vhost one is already protected by vhost lock, do
> > > > we need it?
> > >
> > > Let's add a TODO in the code.
> > >
> >
> > Can you expand on this? I meant that there will be no synchronization
> > if we remove the rwlock (or similar). If we keep the rwlock we don't
> > need to add any TODO, or am I missing something?
>
> I meant even with rwlock we don't synchronize set_group_as_id() and
> set_status(). Since you said vhost has been synchronized, I think we
> should either
>
> 1) document the synchronization that needs to be done in the upper layer =
or
> 2) add a todo to synchronize the set_status() and set_group_asid()
>

With the VDUSE messages they are synchronized by dev->msg_lock, the
vduse module always has a coherent status from both sides: the VDUSE
userland device and virtio_vdpa. If you want vduse not to trust vdpa
we can go the extra mile and make dev->status atomic for both device
features and group ASID, would that work?

> >
> > > >
> > > > > Or if you want to synchronize map ops with set_status() that look=
s
> > > > > like an independent thing (hardening).
> > > > >
> > > > > > +
> > > > > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > > > > +       msg.req.vq_group_asid.group =3D group;
> > > > > > +       msg.req.vq_group_asid.asid =3D asid;
> > > > > > +
> > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > +       if (r < 0)
> > > > > > +               return r;
> > > > > > +
> > > > > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > > >
> > > > > I'm not sure this has been discussed before, but I think it would=
 be
> > > > > better to introduce a new ioctl to get group -> as mapping. This =
helps
> > > > > to avoid vduse_dev_msg_sync() as much as possible. And it doesn't
> > > > > require the userspace to poll vduse fd before DRIVER_OK.
> > > > >
> >
> > The userspace VDUSE device must poll vduse fd to get the DRIVER_OK
> > actually. so it cannot avoid polling the vduse device. What are the rea=
sons to
> > avoid vduse_dev_msg_sync?
>
> One less chance to avoid synchronization with userspace.
>

But the ioctl alternative is more synchronization from my POV, not
less. Instead of receiving notifications that we could even batch, the
VDUSE userland device needs to issue many synchronous ioctls.

> >
> > > >
> > > > I'm fine with that, but how do we communicate that they have change=
d?
> > >
> > > Since we forbid changing the group->as mapping after DRIVER_OK,
> > > userspace just needs to use that ioctl once after DRIVER_OK.
> > >
> >
> > But the userland VDUSE device needs to know when ASIDs are set by the
> > driver and will not change anymore. In this series it is solved by the
> > order of the messages, but now we would need a way to know that time.
> > One idea is to issue this new ioctl when it receives VDUSE_SET_STATUS
> > msg.
>
> Yes.
>
> >
> > If we do it that way there is still a window where the hypothetical
> > (malicious) virtio_vdpa driver can read and write vq groups from
> > different threads.
>
> See above, we need to add synchronization in either vdpa or virtio_vdpa.
>
> > It could issue a set_group_asid after the VDUSE
> > device returns from the ioctl but before dev->status has not been
> > updated.
>
> In the case of VDUSE I think either side should not trust the other
> side. So userspace needs to be prepared for this, so did the driver.
> Since the memory accessing is initiated from the userspace, so it
> should not perform any memory access before the ioctl to fetch the
> group->asid mapping.
>

I don't follow this. In the case of virtio_vdpa the ASID groups and
features are handled by the kernel entirely. And in the case of
vhost_vdpa they are handled by the vhost_dev->mutex lock. So can we
trust them?

> >
> > I don't think we should protect that, but if we want to do it we
> > should protect that part either acquiring the rwlock and trusting the
> > vduse_dev_msg_sync timeout or proceed with atomics, smp_store_release
> > / smp_load_acquire, read and write barriers...
> >
> > Note that I still think this is overthinking. We have the same
> > problems with driver features, where changing in bits like packed vq
> > changes the behavior of vDPA callbacks and could be able to
> > desynchronize the vduse kernel and the userland device.
>
> Probably, but for driver features, it's too late to do the change.
>

Why is it late? We just need to add the same synchronization in both
driver features and ASID groups. The change is not visible for either
virtio_vdpa, vhost_vdpa, or VDUSE userland device, at all.

> > But since
> > virtio_vdpa and vduse kernel modules run in the same kernel, so they sh=
ould
> > be able to trust each other.
>
> Better not, usually the lower layer (vdpa/vduse) should not trust the
> upper layer (virtio-vdpa) in this case.
>

Ok, adding the hardening in the next version!

> But if you stick to the method with vduse_dev_msg_sync, I'm also fine wit=
h that.
>
> >
> > > > Or how to communicate to the driver that the device does not accept
> > > > the assignment of the ASID to the group?
> > >
> > > See above.
> > >
> >
> > I didn't find the answer :(.
> >
> > Let me put an example with QEMU and vhost_vdpa:
> > - QEMU calls VHOST_VDPA_SET_GROUP_ASID with a valid vq group and asid.
> > - vduse cannot send this information to the device as it must wait for
> > the ioctl.
>
> Which ioctl did you mean in this case?
>

The new ioctl from the userland VDUSE device that you're proposing to
accept or reject the set ASID group. Let's call it
VDUSE_GET_GROUP_ASID, so let me rewrite the from from that moment:

- QEMU calls VHOST_VDPA_SET_GROUP_ASID with a valid vq group (in
vdpa->ngroups range) and a valid asid (in vdpa->nas range)
- The vduse kernel module cannot send the information to the VDUSE
userland device, it must wait until the VDUSE userland device calls
the new VDUSE_GET_GROUP_ASID. It will not happen until QEMU calls
VHOST_VDPA_SET_STATUS with DRIVER_OK, but QEMU will not call
VHOST_VDPA_SET_STATUS until the kernel returns from
VHOST_VDPA_SET_GROUP_ASID. The vduse kernel module needs to return
success, without knowing if the device will accept it in the future or
not.
- Now QEMU sends DIRVER_OK, so the vduse kernel module forwards it to
the VDUSE userland device. The VDUSE userland device then calls
VDUSE_GET_GROUP_ASID, and the flow continues.
- The vduse userland device doesn't accept the vq group ASID map for
whatever reason, so it returns an error through another ioctl
(VDUSE_CONFIRM_GROUP_ASID with a boolean as argument?). How should the
vduse kernel module proceed? just reset the whole device with
NEED_RESET?

> >
> > > >
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +
> > > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u=
16 idx,
> > > > > >                                 struct vdpa_vq_state *state)
> > > > > >  {
> > > > > > @@ -794,13 +847,13 @@ static int vduse_vdpa_set_map(struct vdpa=
_device *vdpa,
> > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > >         int ret;
> > > > > >
> > > > > > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > > > > > +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotl=
b);
> > > > > >         if (ret)
> > > > > >                 return ret;
> > > > > >
> > > > > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > > > > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_=
MAX);
> > > > > >         if (ret) {
> > > > > > -               vduse_domain_clear_map(dev->domain, iotlb);
> > > > > > +               vduse_domain_clear_map(dev->as[asid].domain, io=
tlb);
> > > > > >                 return ret;
> > > > > >         }
> > > > > >
> > > > > > @@ -843,6 +896,7 @@ static const struct vdpa_config_ops vduse_v=
dpa_config_ops =3D {
> > > > > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > > > > >         .reset                  =3D vduse_vdpa_reset,
> > > > > >         .set_map                =3D vduse_vdpa_set_map,
> > > > > > +       .set_group_asid         =3D vduse_set_group_asid,
> > > > > >         .get_vq_map             =3D vduse_get_vq_map,
> > > > > >         .free                   =3D vduse_vdpa_free,
> > > > > >  };
> > > > > > @@ -851,32 +905,30 @@ static void vduse_dev_sync_single_for_dev=
ice(union virtio_map token,
> > > > > >                                              dma_addr_t dma_add=
r, size_t size,
> > > > > >                                              enum dma_data_dire=
ction dir)
> > > > > >  {
> > > > > > -       struct vduse_dev *vdev;
> > > > > >         struct vduse_iova_domain *domain;
> > > > > >
> > > > > >         if (!token.group)
> > > > > >                 return;
> > > > > >
> > > > > > -       vdev =3D token.group->dev;
> > > > > > -       domain =3D vdev->domain;
> > > > > > -
> > > > > > +       read_lock(&token.group->as_lock);
> > > > >
> > > > > I think we could optimize the lock here. E.g when nas is 1, we do=
n't
> > > > > need any lock in fact.
> > > > >
> > > >
> > > > Good point! Not taking the lock in that case for the next version, =
thanks!
> > > >
> > > > > > +       domain =3D token.group->as->domain;
> > > > > >         vduse_domain_sync_single_for_device(domain, dma_addr, s=
ize, dir);
> > > > > > +       read_unlock(&token.group->as_lock);
> > > > > >  }
> > > > > >
> > > > > >  static void vduse_dev_sync_single_for_cpu(union virtio_map tok=
en,
> > > > > >                                              dma_addr_t dma_add=
r, size_t size,
> > > > > >                                              enum dma_data_dire=
ction dir)
> > > > > >  {
> > > > > > -       struct vduse_dev *vdev;
> > > > > >         struct vduse_iova_domain *domain;
> > > > > >
> > > > > >         if (!token.group)
> > > > > >                 return;
> > > > > >
> > > > > > -       vdev =3D token.group->dev;
> > > > > > -       domain =3D vdev->domain;
> > > > > > -
> > > > > > +       read_lock(&token.group->as_lock);
> > > > > > +       domain =3D token.group->as->domain;
> > > > > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size=
, dir);
> > > > > > +       read_unlock(&token.group->as_lock);
> > > > > >  }
> > > > > >
> > > > > >  static dma_addr_t vduse_dev_map_page(union virtio_map token, s=
truct page *page,
> > > > > > @@ -884,38 +936,38 @@ static dma_addr_t vduse_dev_map_page(unio=
n virtio_map token, struct page *page,
> > > > > >                                      enum dma_data_direction di=
r,
> > > > > >                                      unsigned long attrs)
> > > > > >  {
> > > > > > -       struct vduse_dev *vdev;
> > > > > >         struct vduse_iova_domain *domain;
> > > > > > +       dma_addr_t r;
> > > > > >
> > > > > >         if (!token.group)
> > > > > >                 return DMA_MAPPING_ERROR;
> > > > > >
> > > > > > -       vdev =3D token.group->dev;
> > > > > > -       domain =3D vdev->domain;
> > > > > > +       read_lock(&token.group->as_lock);
> > > > > > +       domain =3D token.group->as->domain;
> > > > > > +       r =3D vduse_domain_map_page(domain, page, offset, size,=
 dir, attrs);
> > > > > > +       read_unlock(&token.group->as_lock);
> > > > > >
> > > > > > -       return vduse_domain_map_page(domain, page, offset, size=
, dir, attrs);
> > > > > > +       return r;
> > > > > >  }
> > > > > >
> > > > > >  static void vduse_dev_unmap_page(union virtio_map token, dma_a=
ddr_t dma_addr,
> > > > > >                                  size_t size, enum dma_data_dir=
ection dir,
> > > > > >                                  unsigned long attrs)
> > > > > >  {
> > > > > > -       struct vduse_dev *vdev;
> > > > > >         struct vduse_iova_domain *domain;
> > > > > >
> > > > > >         if (!token.group)
> > > > > >                 return;
> > > > > >
> > > > > > -       vdev =3D token.group->dev;
> > > > > > -       domain =3D vdev->domain;
> > > > > > -
> > > > > > -       return vduse_domain_unmap_page(domain, dma_addr, size, =
dir, attrs);
> > > > > > +       read_lock(&token.group->as_lock);
> > > > > > +       domain =3D token.group->as->domain;
> > > > > > +       vduse_domain_unmap_page(domain, dma_addr, size, dir, at=
trs);
> > > > > > +       read_unlock(&token.group->as_lock);
> > > > > >  }
> > > > > >
> > > > > >  static void *vduse_dev_alloc_coherent(union virtio_map token, =
size_t size,
> > > > > >                                       dma_addr_t *dma_addr, gfp=
_t flag)
> > > > > >  {
> > > > > > -       struct vduse_dev *vdev;
> > > > > >         struct vduse_iova_domain *domain;
> > > > > >         unsigned long iova;
> > > > > >         void *addr;
> > > > > > @@ -928,18 +980,21 @@ static void *vduse_dev_alloc_coherent(uni=
on virtio_map token, size_t size,
> > > > > >         if (!addr)
> > > > > >                 return NULL;
> > > > > >
> > > > > > -       vdev =3D token.group->dev;
> > > > > > -       domain =3D vdev->domain;
> > > > > > +       *dma_addr =3D (dma_addr_t)iova;
> > > > >
> > > > > Any reason we need to touch *dma_addr here? It might trigger UBSA=
N/KMSAN.
> > > > >
> > > >
> > > > No, this is a leftover. I'm fixing it for the next version. Thanks!
> > > >
> > > > > > +       read_lock(&token.group->as_lock);
> > > > > > +       domain =3D token.group->as->domain;
> > > > > >         addr =3D vduse_domain_alloc_coherent(domain, size,
> > > > > >                                            (dma_addr_t *)&iova,=
 addr);
> > > > > >         if (!addr)
> > > > > >                 goto err;
> > > > > >
> > > > > >         *dma_addr =3D (dma_addr_t)iova;
> > > > > > +       read_unlock(&token.group->as_lock);
> > > > > >
> > > > > >         return addr;
> > > > > >
> > > > > >  err:
> > > > > > +       read_unlock(&token.group->as_lock);
> > > > > >         free_pages_exact(addr, size);
> > > > > >         return NULL;
> > > > > >  }
> > > > > > @@ -948,31 +1003,30 @@ static void vduse_dev_free_coherent(unio=
n virtio_map token, size_t size,
> > > > > >                                     void *vaddr, dma_addr_t dma=
_addr,
> > > > > >                                     unsigned long attrs)
> > > > > >  {
> > > > > > -       struct vduse_dev *vdev;
> > > > > >         struct vduse_iova_domain *domain;
> > > > > >
> > > > > >         if (!token.group)
> > > > > >                 return;
> > > > > >
> > > > > > -       vdev =3D token.group->dev;
> > > > > > -       domain =3D vdev->domain;
> > > > > > -
> > > > > > +       read_lock(&token.group->as_lock);
> > > > > > +       domain =3D token.group->as->domain;
> > > > > >         vduse_domain_free_coherent(domain, size, dma_addr, attr=
s);
> > > > > > +       read_unlock(&token.group->as_lock);
> > > > > >         free_pages_exact(vaddr, size);
> > > > > >  }
> > > > > >
> > > > > >  static bool vduse_dev_need_sync(union virtio_map token, dma_ad=
dr_t dma_addr)
> > > > > >  {
> > > > > > -       struct vduse_dev *vdev;
> > > > > > -       struct vduse_iova_domain *domain;
> > > > > > +       size_t bounce_size;
> > > > > >
> > > > > >         if (!token.group)
> > > > > >                 return false;
> > > > > >
> > > > > > -       vdev =3D token.group->dev;
> > > > > > -       domain =3D vdev->domain;
> > > > > > +       read_lock(&token.group->as_lock);
> > > > > > +       bounce_size =3D token.group->as->domain->bounce_size;
> > > > > > +       read_unlock(&token.group->as_lock);
> > > > > >
> > > > > > -       return dma_addr < domain->bounce_size;
> > > > > > +       return dma_addr < bounce_size;
> > > > > >  }
> > > > > >
> > > > > >  static int vduse_dev_mapping_error(union virtio_map token, dma=
_addr_t dma_addr)
> > > > > > @@ -984,16 +1038,16 @@ static int vduse_dev_mapping_error(union=
 virtio_map token, dma_addr_t dma_addr)
> > > > > >
> > > > > >  static size_t vduse_dev_max_mapping_size(union virtio_map toke=
n)
> > > > > >  {
> > > > > > -       struct vduse_dev *vdev;
> > > > > > -       struct vduse_iova_domain *domain;
> > > > > > +       size_t bounce_size;
> > > > > >
> > > > > >         if (!token.group)
> > > > > >                 return 0;
> > > > > >
> > > > > > -       vdev =3D token.group->dev;
> > > > > > -       domain =3D vdev->domain;
> > > > > > +       read_lock(&token.group->as_lock);
> > > > > > +       bounce_size =3D token.group->as->domain->bounce_size;
> > > > > > +       read_unlock(&token.group->as_lock);
> > > > > >
> > > > > > -       return domain->bounce_size;
> > > > > > +       return bounce_size;
> > > > > >  }
> > > > > >
> > > > > >  static const struct virtio_map_ops vduse_map_ops =3D {
> > > > > > @@ -1133,39 +1187,40 @@ static int vduse_dev_queue_irq_work(str=
uct vduse_dev *dev,
> > > > > >         return ret;
> > > > > >  }
> > > > > >
> > > > > > -static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> > > > > > +static int vduse_dev_dereg_umem(struct vduse_dev *dev, u32 asi=
d,
> > > > > >                                 u64 iova, u64 size)
> > > > > >  {
> > > > > >         int ret;
> > > > > >
> > > > > > -       mutex_lock(&dev->mem_lock);
> > > > > > +       mutex_lock(&dev->as[asid].mem_lock);
> > > > > >         ret =3D -ENOENT;
> > > > > > -       if (!dev->umem)
> > > > > > +       if (!dev->as[asid].umem)
> > > > > >                 goto unlock;
> > > > > >
> > > > > >         ret =3D -EINVAL;
> > > > > > -       if (!dev->domain)
> > > > > > +       if (!dev->as[asid].domain)
> > > > > >                 goto unlock;
> > > > > >
> > > > > > -       if (dev->umem->iova !=3D iova || size !=3D dev->domain-=
>bounce_size)
> > > > > > +       if (dev->as[asid].umem->iova !=3D iova ||
> > > > > > +           size !=3D dev->as[asid].domain->bounce_size)
> > > > > >                 goto unlock;
> > > > > >
> > > > > > -       vduse_domain_remove_user_bounce_pages(dev->domain);
> > > > > > -       unpin_user_pages_dirty_lock(dev->umem->pages,
> > > > > > -                                   dev->umem->npages, true);
> > > > > > -       atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_=
vm);
> > > > > > -       mmdrop(dev->umem->mm);
> > > > > > -       vfree(dev->umem->pages);
> > > > > > -       kfree(dev->umem);
> > > > > > -       dev->umem =3D NULL;
> > > > > > +       vduse_domain_remove_user_bounce_pages(dev->as[asid].dom=
ain);
> > > > > > +       unpin_user_pages_dirty_lock(dev->as[asid].umem->pages,
> > > > > > +                                   dev->as[asid].umem->npages,=
 true);
> > > > > > +       atomic64_sub(dev->as[asid].umem->npages, &dev->as[asid]=
.umem->mm->pinned_vm);
> > > > > > +       mmdrop(dev->as[asid].umem->mm);
> > > > > > +       vfree(dev->as[asid].umem->pages);
> > > > > > +       kfree(dev->as[asid].umem);
> > > > > > +       dev->as[asid].umem =3D NULL;
> > > > > >         ret =3D 0;
> > > > > >  unlock:
> > > > > > -       mutex_unlock(&dev->mem_lock);
> > > > > > +       mutex_unlock(&dev->as[asid].mem_lock);
> > > > > >         return ret;
> > > > > >  }
> > > > > >
> > > > > >  static int vduse_dev_reg_umem(struct vduse_dev *dev,
> > > > > > -                             u64 iova, u64 uaddr, u64 size)
> > > > > > +                             u32 asid, u64 iova, u64 uaddr, u6=
4 size)
> > > > > >  {
> > > > > >         struct page **page_list =3D NULL;
> > > > > >         struct vduse_umem *umem =3D NULL;
> > > > > > @@ -1173,14 +1228,14 @@ static int vduse_dev_reg_umem(struct vd=
use_dev *dev,
> > > > > >         unsigned long npages, lock_limit;
> > > > > >         int ret;
> > > > > >
> > > > > > -       if (!dev->domain || !dev->domain->bounce_map ||
> > > > > > -           size !=3D dev->domain->bounce_size ||
> > > > > > +       if (!dev->as[asid].domain || !dev->as[asid].domain->bou=
nce_map ||
> > > > > > +           size !=3D dev->as[asid].domain->bounce_size ||
> > > > > >             iova !=3D 0 || uaddr & ~PAGE_MASK)
> > > > > >                 return -EINVAL;
> > > > > >
> > > > > > -       mutex_lock(&dev->mem_lock);
> > > > > > +       mutex_lock(&dev->as[asid].mem_lock);
> > > > > >         ret =3D -EEXIST;
> > > > > > -       if (dev->umem)
> > > > > > +       if (dev->as[asid].umem)
> > > > > >                 goto unlock;
> > > > > >
> > > > > >         ret =3D -ENOMEM;
> > > > > > @@ -1204,7 +1259,7 @@ static int vduse_dev_reg_umem(struct vdus=
e_dev *dev,
> > > > > >                 goto out;
> > > > > >         }
> > > > > >
> > > > > > -       ret =3D vduse_domain_add_user_bounce_pages(dev->domain,
> > > > > > +       ret =3D vduse_domain_add_user_bounce_pages(dev->as[asid=
].domain,
> > > > > >                                                  page_list, pin=
ned);
> > > > > >         if (ret)
> > > > > >                 goto out;
> > > > > > @@ -1217,7 +1272,7 @@ static int vduse_dev_reg_umem(struct vdus=
e_dev *dev,
> > > > > >         umem->mm =3D current->mm;
> > > > > >         mmgrab(current->mm);
> > > > > >
> > > > > > -       dev->umem =3D umem;
> > > > > > +       dev->as[asid].umem =3D umem;
> > > > > >  out:
> > > > > >         if (ret && pinned > 0)
> > > > > >                 unpin_user_pages(page_list, pinned);
> > > > > > @@ -1228,7 +1283,7 @@ static int vduse_dev_reg_umem(struct vdus=
e_dev *dev,
> > > > > >                 vfree(page_list);
> > > > > >                 kfree(umem);
> > > > > >         }
> > > > > > -       mutex_unlock(&dev->mem_lock);
> > > > > > +       mutex_unlock(&dev->as[asid].mem_lock);
> > > > > >         return ret;
> > > > > >  }
> > > > > >
> > > > > > @@ -1260,47 +1315,66 @@ static long vduse_dev_ioctl(struct file=
 *file, unsigned int cmd,
> > > > > >
> > > > > >         switch (cmd) {
> > > > > >         case VDUSE_IOTLB_GET_FD: {
> > > > > > -               struct vduse_iotlb_entry entry;
> > > > > > +               struct vduse_iotlb_entry_v2 entry;
> > > > >
> > > > > Nit: if we stick entry and do copy_from_user() twice it might sav=
e
> > > > > lots of unnecessary changes.
> > > > >
> > > >
> > > > I'm happy to move to something else but most of the changes happen
> > > > because of s/entry/entry.v1/ . If we stick with just vduse_iotlb_en=
try
> > > > and a separate asid variable, we also need to duplicate the
> > > > copy_from_user [2].
> > > >
> > > > > >                 struct vhost_iotlb_map *map;
> > > > > >                 struct vdpa_map_file *map_file;
> > > > > >                 struct file *f =3D NULL;
> > > > > > +               u32 asid;
> > > > > >
> > > > > >                 ret =3D -EFAULT;
> > > > > > -               if (copy_from_user(&entry, argp, sizeof(entry))=
)
> > > > > > -                       break;
> > > > > > +               if (dev->api_version >=3D VDUSE_API_VERSION_1) =
{
> > > > > > +                       if (copy_from_user(&entry, argp, sizeof=
(entry)))
> > > > > > +                               break;
> > > > > > +               } else {
> > > > > > +                       entry.asid =3D 0;
> > > > > > +                       if (copy_from_user(&entry.v1, argp,
> > > > > > +                                          sizeof(entry.v1)))
> > > > > > +                               break;
> > > > > > +               }
> > > > > >
> > > > > >                 ret =3D -EINVAL;
> > > > > > -               if (entry.start > entry.last)
> > > > > > +               if (entry.v1.start > entry.v1.last)
> > > > > > +                       break;
> > > > > > +
> > > > > > +               if (entry.asid >=3D dev->nas)
> > > > > >                         break;
> > > > > >
> > > > > >                 mutex_lock(&dev->domain_lock);
> > > > > > -               if (!dev->domain) {
> > > > > > +               asid =3D array_index_nospec(entry.asid, dev->na=
s);
> > > > > > +               if (!dev->as[asid].domain) {
> > > > > >                         mutex_unlock(&dev->domain_lock);
> > > > > >                         break;
> > > > > >                 }
> > > > > > -               spin_lock(&dev->domain->iotlb_lock);
> > > > > > -               map =3D vhost_iotlb_itree_first(dev->domain->io=
tlb,
> > > > > > -                                             entry.start, entr=
y.last);
> > > > > > +               spin_lock(&dev->as[asid].domain->iotlb_lock);
> > > > > > +               map =3D vhost_iotlb_itree_first(dev->as[asid].d=
omain->iotlb,
> > > > > > +                                             entry.v1.start, e=
ntry.v1.last);
> > > > > >                 if (map) {
> > > > > >                         map_file =3D (struct vdpa_map_file *)ma=
p->opaque;
> > > > > >                         f =3D get_file(map_file->file);
> > > > > > -                       entry.offset =3D map_file->offset;
> > > > > > -                       entry.start =3D map->start;
> > > > > > -                       entry.last =3D map->last;
> > > > > > -                       entry.perm =3D map->perm;
> > > > > > +                       entry.v1.offset =3D map_file->offset;
> > > > > > +                       entry.v1.start =3D map->start;
> > > > > > +                       entry.v1.last =3D map->last;
> > > > > > +                       entry.v1.perm =3D map->perm;
> > > > > >                 }
> > > > > > -               spin_unlock(&dev->domain->iotlb_lock);
> > > > > > +               spin_unlock(&dev->as[asid].domain->iotlb_lock);
> > > > > >                 mutex_unlock(&dev->domain_lock);
> > > > > >                 ret =3D -EINVAL;
> > > > > >                 if (!f)
> > > > > >                         break;
> > > > > >
> > > > > > -               ret =3D -EFAULT;
> > > > > > -               if (copy_to_user(argp, &entry, sizeof(entry))) =
{
> > > > > > +               if (dev->api_version >=3D VDUSE_API_VERSION_1)
> > > > > > +                       ret =3D copy_to_user(argp, &entry,
> > > > > > +                                          sizeof(entry));
> > > > > > +               else
> > > > > > +                       ret =3D copy_to_user(argp, &entry.v1,
> > > > > > +                                          sizeof(entry.v1));
> > > > > > +
> > > > > > +               if (ret) {
> > > > > > +                       ret =3D -EFAULT;
> > > > > >                         fput(f);
> > > > > >                         break;
> > > > > >                 }
> > > > > > -               ret =3D receive_fd(f, NULL, perm_to_file_flags(=
entry.perm));
> > > > > > +               ret =3D receive_fd(f, NULL, perm_to_file_flags(=
entry.v1.perm));
> > > > > >                 fput(f);
> > > > > >                 break;
> > > > > >         }
> > > > > > @@ -1445,6 +1519,7 @@ static long vduse_dev_ioctl(struct file *=
file, unsigned int cmd,
> > > > > >         }
> > > > > >         case VDUSE_IOTLB_REG_UMEM: {
> > > > > >                 struct vduse_iova_umem umem;
> > > > > > +               u32 asid;
> > > > > >
> > > > > >                 ret =3D -EFAULT;
> > > > > >                 if (copy_from_user(&umem, argp, sizeof(umem)))
> > > > > > @@ -1452,17 +1527,21 @@ static long vduse_dev_ioctl(struct file=
 *file, unsigned int cmd,
> > > > > >
> > > > > >                 ret =3D -EINVAL;
> > > > > >                 if (!is_mem_zero((const char *)umem.reserved,
> > > > > > -                                sizeof(umem.reserved)))
> > > > > > +                                sizeof(umem.reserved)) ||
> > > > > > +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> > > > > > +                    umem.asid !=3D 0) || umem.asid >=3D dev->n=
as)
> > > > > >                         break;
> > > > > >
> > > > > >                 mutex_lock(&dev->domain_lock);
> > > > > > -               ret =3D vduse_dev_reg_umem(dev, umem.iova,
> > > > > > +               asid =3D array_index_nospec(umem.asid, dev->nas=
);
> > > > > > +               ret =3D vduse_dev_reg_umem(dev, asid, umem.iova=
,
> > > > > >                                          umem.uaddr, umem.size)=
;
> > > > > >                 mutex_unlock(&dev->domain_lock);
> > > > > >                 break;
> > > > > >         }
> > > > > >         case VDUSE_IOTLB_DEREG_UMEM: {
> > > > > >                 struct vduse_iova_umem umem;
> > > > > > +               u32 asid;
> > > > > >
> > > > > >                 ret =3D -EFAULT;
> > > > > >                 if (copy_from_user(&umem, argp, sizeof(umem)))
> > > > > > @@ -1470,10 +1549,15 @@ static long vduse_dev_ioctl(struct file=
 *file, unsigned int cmd,
> > > > > >
> > > > > >                 ret =3D -EINVAL;
> > > > > >                 if (!is_mem_zero((const char *)umem.reserved,
> > > > > > -                                sizeof(umem.reserved)))
> > > > > > +                                sizeof(umem.reserved)) ||
> > > > > > +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> > > > > > +                    umem.asid !=3D 0) ||
> > > > > > +                    umem.asid >=3D dev->nas)
> > > > > >                         break;
> > > > > > +
> > > > > >                 mutex_lock(&dev->domain_lock);
> > > > > > -               ret =3D vduse_dev_dereg_umem(dev, umem.iova,
> > > > > > +               asid =3D array_index_nospec(umem.asid, dev->nas=
);
> > > > > > +               ret =3D vduse_dev_dereg_umem(dev, asid, umem.io=
va,
> > > > > >                                            umem.size);
> > > > > >                 mutex_unlock(&dev->domain_lock);
> > > > > >                 break;
> > > > > > @@ -1481,6 +1565,7 @@ static long vduse_dev_ioctl(struct file *=
file, unsigned int cmd,
> > > > > >         case VDUSE_IOTLB_GET_INFO: {
> > > > >
> > > > > Btw I see this:
> > > > >
> > > > >                 dev->vqs[index]->vq_group =3D config.group;
> > > > >
> > > > > In VDUSE_VQ_SETUP:
> > > > >
> > > > > I wonder what's the reason that it is not a part of CREATE_DEV? I
> > > > > meant it might be racy if DMA happens between CREATE_DEV and
> > > > > VDUSE_VQ_SETUP.
> > > > >
> > > >
> > > > The reason the vq index -> vq group association cannot be part of
> > > > device creation is that we need CVQ to be isolated for live migrati=
on,
> > > > but the device doesn't know the CVQ index at the CREATE_DEV time, o=
nly
> > > > after the feature negotiation happens [3].
> > >
> > > Exactly, the cvq index is changed.
> > >
> > > >
> > > > [1] https://lore.kernel.org/lkml/CACGkMEvRQ86dYeY3Enqoj1vkSpefU3roq=
4XGS+y5B5kmsXEkYg@mail.gmail.com/
> > > > [2] https://lore.kernel.org/lkml/CACGkMEtszQeZLTegxEbjODYxu-giTvURu=
=3DpKj4kYTHQYoKOzkQ@mail.gmail.com
> > > > [3] https://lore.kernel.org/lkml/CAJaqyWcvHx7kwcTceN2jazT0nKNo1r5zd=
zqWHqpxdna-kCS1RA@mail.gmail.com
> > >
> > > I see, but a question. What happens if there's a DMA between
> > > CREATE_DEV and VDUSE_VQ_SETUP. If we can find ways to forbid this (or
> > > it has been forbidden), we are probably fine.
> > >
> >
> > It's already forbidden by vdpa_dev_add:
> >
> > dev =3D vduse_find_dev(name);
> > if (!dev || !vduse_dev_is_ready(dev)) {
> >         mutex_unlock(&vduse_lock);
> >         return -EINVAL;
> > }
> >
> > where vduse_dev_is_ready():
> > static bool vduse_dev_is_ready(struct vduse_dev *dev)
> > {
> >         int i;
> >
> >         for (i =3D 0; i < dev->vq_num; i++)
> >                 if (!dev->vqs[i]->num_max)
> >                         return false;
> >
> >         return true;
> > }
> >
> > Since we set the vq group with the same ioctl than vq->num_max, we are
> > safe here. I didn't catch it until now, so thanks for proposing to
> > move the vq group parameter to that ioctl back then! :).
>
> Great.
>
> Thanks
>

