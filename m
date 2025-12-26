Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A891D86DC
	for <virtualization@lists.linux.dev>; Fri, 26 Dec 2025 11:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766749142; cv=none; b=Br9Fbivuo/hbcf1cLa4OD11aqPYBsj63LpiZYvOossALkY1AEF3fBwIGSxhlvYkB29aaEY89/DuxZ5j8ISaeRFTQJCc6r6E2R3SKAzzOYo64Mf9aeh2UHhpu3sW/Forrzf7iYar78j4uneuxieApGFKy71DtM3M3MqOsURty/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766749142; c=relaxed/simple;
	bh=WVOaQjfR4TT7TBU4mwhaPpDys42u7DlBX9OeV21ia4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vz6VQ3o/3iE5stZe+kD2NccpfNw8XolHG3vgxPHQ5DTqcIg8xJc2ZHlipwLqfXoaQ8EgC8E6gy6mxE+ArFIEvc9LV6DNb9g7NoIGAEJS36jL3IS20hVZB7x2HSdIFPn0QBztbSxVDt6Q8KsN4v1o1qFpqP5vuwaAkog8KS/x6Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NzY90MfN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzY90MfN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766749138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xht1OrGw5sIXhryQ7gP9OjD5mZUAOV0SV3Z5qWzHip8=;
	b=NzY90MfNcxa3G8txXy3m+CDctPaMPZzzmQFru9h5TCnnBlgE+2ExbbqLqcgHtBGuQnDZTS
	KuaUwCAqMlV0X8IBwG+yHyX/LZM2pfje/lM/anNeILam7M8jXmRqh3D9ADX0Lx0isAUBmW
	oqhef0RB1coEiczg7fZY0W69p4cNqt4=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-TWAhwBcXNIq_IwsQ-oXtYA-1; Fri, 26 Dec 2025 06:38:57 -0500
X-MC-Unique: TWAhwBcXNIq_IwsQ-oXtYA-1
X-Mimecast-MFC-AGG-ID: TWAhwBcXNIq_IwsQ-oXtYA_1766749137
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-78f92e123f5so88311007b3.2
        for <virtualization@lists.linux.dev>; Fri, 26 Dec 2025 03:38:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766749137; x=1767353937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xht1OrGw5sIXhryQ7gP9OjD5mZUAOV0SV3Z5qWzHip8=;
        b=nAo7dsh7cHL0uPRVg97TCcukLtA83wFmxCWDg6h6RYxFx7VlVZOc8ZTU5HMrdDaLq+
         3F0iBqjZZHt71/kBrCTZ31fRL+dBWy4YrUZXmHHXtmTZP6pvkKCpG/RCGKZ18rcTHYSt
         RgNPEngS23RJEU9cmP4r+9t7Y4xZg0U/wJ2aNJ3DFndV0+YAJznCSexcivSpQyTRQGWj
         wQBjQBsVUT1XKJ+DvC3+shUvFUnW9my6svyZjEPaxL/jlr51x6ihDLISNsCDoOEib/eq
         SLoLQGi8p4qRJGsl9o1vqEle1/E5wGnRMEIdMM0/MO6mbU0EMJJVX2N+18mcP3i3ayck
         urXA==
X-Forwarded-Encrypted: i=1; AJvYcCXBsZ4dbSWT0mCx5iR8RKm8Ly6KNRFvCfGp+94ZBJXDdVIM9EcZzUz/roQT/u+05IhVF6/1JT19IaVMVYfmoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcZ3yZhFDcQ3X5b2pYhBEAHjrVjGI87GJBtAKwGeX0Rk2QLmTq
	ba+2joPv0oqTTql4tkopaps2bg5w8q/UP8EfYAxV8uia9FicVPDy4Gem/KQhV/bm43iwfmyS8eM
	DsWV5rTj5GDr2uHIml0WMTnb3D72BnZOBb05sFqJTKkcUVVBUZbwQU/hwg8GspwF/QojGR5I+7t
	62nHXKd4IUDYLLyGCwuWCP/lj2jnbGTrrAlxxTf7WVg4Q=
X-Gm-Gg: AY/fxX5wbwviqC5ixhs05X7iNMX9dCTd8uqImeHgEnMT1Iu7csoeTEJNo9Xl/olpjBi
	fXf9V2yIV0NHxIn37w74Lm1QWfoUNEePtbMWaGUJzwoYaZafSfWeAZ1R4Pok3KOEPtu9nNndDup
	Kny9DugHiPhxfmcm1O4NDYV4tm0mORQOVNgnfu7BYkn4no8WYL4g7sno/+BjIuU6jzQQ==
X-Received: by 2002:a05:690c:c11:b0:78c:5bb4:1d27 with SMTP id 00721157ae682-78fb40296aemr210848847b3.38.1766749136473;
        Fri, 26 Dec 2025 03:38:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlCgP1M3yJ71X4CqDb6+8RoMlhR8/GjtN6bAxhNFtERlzDEMAa14H0A6d9iXZrG4WA+5lwDxpDhTs5pI/Ndx0=
X-Received: by 2002:a05:690c:c11:b0:78c:5bb4:1d27 with SMTP id
 00721157ae682-78fb40296aemr210848617b3.38.1766749135876; Fri, 26 Dec 2025
 03:38:55 -0800 (PST)
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
 <CAJaqyWe=YSV-gRqOra-yiiBFKR793pHJDT7t8mDTrrFKjzZ=Ow@mail.gmail.com>
 <CACGkMEvXdV4ukZE6xhLL0sSN70G=AWVQgpRnH98Fr4btzMkK9g@mail.gmail.com>
 <CAJaqyWf-MtnisowpBxjKDM1ULmFVkP4ODWVJiopTSJ7_d6M+aw@mail.gmail.com> <CACGkMEt+4M97qrUm7rybFU4YWG8=52_6xE8EPJaGK_SFZ4o2Cw@mail.gmail.com>
In-Reply-To: <CACGkMEt+4M97qrUm7rybFU4YWG8=52_6xE8EPJaGK_SFZ4o2Cw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 26 Dec 2025 12:38:19 +0100
X-Gm-Features: AQt7F2phVVnQkDfEoCB9BKvaz5LNMPKaWQHeBcqPGnMX7u7DFaLlCHkcwlMYQm4
Message-ID: <CAJaqyWeuLYAu8kONzHxM8-byOi3qenwN-oDOBw6KfwUaJf2WYg@mail.gmail.com>
Subject: Re: [PATCH v10 7/8] vduse: add vq group asid support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yc1GEWyB1A25BxvsSRwgU-hMiIP8F_cj8eu_AeDyJ5c_1766749137
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 25, 2025 at 3:23=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Dec 24, 2025 at 3:39=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Wed, Dec 24, 2025 at 1:20=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Tue, Dec 23, 2025 at 9:16=E2=80=AFPM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Tue, Dec 23, 2025 at 2:11=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Thu, Dec 18, 2025 at 9:11=E2=80=AFPM Eugenio Perez Martin
> > > > > <eperezma@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Dec 18, 2025 at 7:45=E2=80=AFAM Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > On Wed, Dec 17, 2025 at 7:24=E2=80=AFPM Eugenio P=C3=A9rez <e=
perezma@redhat.com> wrote:
> > > > > > > >
> > > > > > > > Add support for assigning Address Space Identifiers (ASIDs)=
 to each VQ
> > > > > > > > group.  This enables mapping each group into a distinct mem=
ory space.
> > > > > > > >
> > > > > > > > The vq group to ASID association is protected by a rwlock n=
ow.  But the
> > > > > > > > mutex domain_lock keeps protecting the domains of all ASIDs=
, as some
> > > > > > > > operations like the one related with the bounce buffer size=
 still
> > > > > > > > requires to lock all the ASIDs.
> > > > > > > >
> > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > >
> > > > > > > > ---
> > > > > > > > Future improvements can include performance optimizations o=
n top could
> > > > > > > > move to per-ASID locks, or hardening by tracking ASID or AS=
ID hashes on
> > > > > > > > unused bits of the DMA address.
> > > > > > > >
> > > > > > > > Tested virtio_vdpa by adding manually two threads in vduse_=
set_status:
> > > > > > > > one of them modifies the vq group 0 ASID and the other one =
map and unmap
> > > > > > > > memory continuously.  After a while, the two threads stop a=
nd the usual
> > > > > > > > work continues.
> > > > > > > >
> > > > > > > > Tested with vhost_vdpa by migrating a VM while ping on OVS+=
VDUSE.  A few
> > > > > > > > workaround were needed in some parts:
> > > > > > > > * Do not enable CVQ before data vqs in QEMU, as VDUSE does =
not forward
> > > > > > > >   the enable message to the userland device.  This will be =
solved in the
> > > > > > > >   future.
> > > > > > > > * Share the suspended state between all vhost devices in QE=
MU:
> > > > > > > >   https://lists.nongnu.org/archive/html/qemu-devel/2025-11/=
msg02947.html
> > > > > > > > * Implement a fake VDUSE suspend vdpa operation callback th=
at always
> > > > > > > >   returns true in the kernel.  DPDK suspend the device at t=
he first
> > > > > > > >   GET_VRING_BASE.
> > > > > > > > * Remove the CVQ blocker in ASID.
> > > > > > > >
> > > > > > > > ---
> > > > > > > > v10:
> > > > > > > > * Back to rwlock version so stronger locks are used.
> > > > > > > > * Take out allocations from rwlock.
> > > > > > > > * Forbid changing ASID of a vq group after DRIVER_OK (Jason=
)
> > > > > > > > * Remove bad fetching again of domain variable in
> > > > > > > >   vduse_dev_max_mapping_size (Yongji).
> > > > > > > > * Remove unused vdev definition in vdpa map_ops callbacks (=
kernel test
> > > > > > > >   robot).
> > > > > > > >
> > > > > > > > v9:
> > > > > > > > * Replace mutex with rwlock, as the vdpa map_ops can run fr=
om atomic
> > > > > > > >   context.
> > > > > > > >
> > > > > > > > v8:
> > > > > > > > * Revert the mutex to rwlock change, it needs proper profil=
ing to
> > > > > > > >   justify it.
> > > > > > > >
> > > > > > > > v7:
> > > > > > > > * Take write lock in the error path (Jason).
> > > > > > > >
> > > > > > > > v6:
> > > > > > > > * Make vdpa_dev_add use gotos for error handling (MST).
> > > > > > > > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_=
VERSION_1) ?/
> > > > > > > >   (MST).
> > > > > > > > * Fix struct name not matching in the doc.
> > > > > > > >
> > > > > > > > v5:
> > > > > > > > * Properly return errno if copy_to_user returns >0 in VDUSE=
_IOTLB_GET_FD
> > > > > > > >   ioctl (Jason).
> > > > > > > > * Properly set domain bounce size to divide equally between=
 nas (Jason).
> > > > > > > > * Exclude "padding" member from the only >V1 members in
> > > > > > > >   vduse_dev_request.
> > > > > > > >
> > > > > > > > v4:
> > > > > > > > * Divide each domain bounce size between the device bounce =
size (Jason).
> > > > > > > > * revert unneeded addr =3D NULL assignment (Jason)
> > > > > > > > * Change if (x && (y || z)) return to if (x) { if (y) retur=
n; if (z)
> > > > > > > >   return; } (Jason)
> > > > > > > > * Change a bad multiline comment, using @ caracter instead =
of * (Jason).
> > > > > > > > * Consider config->nas =3D=3D 0 as a fail (Jason).
> > > > > > > >
> > > > > > > > v3:
> > > > > > > > * Get the vduse domain through the vduse_as in the map func=
tions
> > > > > > > >   (Jason).
> > > > > > > > * Squash with the patch creating the vduse_as struct (Jason=
).
> > > > > > > > * Create VDUSE_DEV_MAX_AS instead of comparing agains a mag=
ic number
> > > > > > > >   (Jason)
> > > > > > > >
> > > > > > > > v2:
> > > > > > > > * Convert the use of mutex to rwlock.
> > > > > > > >
> > > > > > > > RFC v3:
> > > > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was se=
t to a lower
> > > > > > > >   value to reduce memory consumption, but vqs are already l=
imited to
> > > > > > > >   that value and userspace VDUSE is able to allocate that m=
any vqs.
> > > > > > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > > > > > > >   VDUSE_IOTLB_GET_INFO.
> > > > > > > > * Use of array_index_nospec in VDUSE device ioctls.
> > > > > > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > > > > > > * Move the umem mutex to asid struct so there is no content=
ion between
> > > > > > > >   ASIDs.
> > > > > > > >
> > > > > > > > RFC v2:
> > > > > > > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so =
the first
> > > > > > > >   part of the struct is the same.
> > > > > > > > ---
> > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 366 +++++++++++++++++=
++----------
> > > > > > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > > > > > >  2 files changed, 295 insertions(+), 124 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/v=
dpa/vdpa_user/vduse_dev.c
> > > > > > > > index 767abcb7e375..786ab2378825 100644
> > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > @@ -41,6 +41,7 @@
> > > > > > > >
> > > > > > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > > > > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > > > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > > > > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > > > > > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > > > > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > > > > > @@ -86,7 +87,15 @@ struct vduse_umem {
> > > > > > > >         struct mm_struct *mm;
> > > > > > > >  };
> > > > > > > >
> > > > > > > > +struct vduse_as {
> > > > > > > > +       struct vduse_iova_domain *domain;
> > > > > > > > +       struct vduse_umem *umem;
> > > > > > > > +       struct mutex mem_lock;
> > > > > > >
> > > > > > > Not related to this patch. But If I was not wrong we have 1:1=
 mapping
> > > > > > > between domain and as. If this is true, can we use bounce_loc=
k instead
> > > > > > > of a new mem_lock? Since I see mem_lock is only used for sync=
hronizing
> > > > > > > umem reg/degreg which has been synchronized with domain rwloc=
k.
> > > > > > >
> > > > > >
> > > > > > I think you're right, but they work at different levels at the =
moment.
> > > > > > The mem_lock is at vduse_dev and also protect the umem pointer,=
 and
> > > > > > bounce_lock is at iova_domain.c .
> > > > > >
> > > > > > Maybe the right thing to do is to move umem in iova_domain. Yon=
gji
> > > > > > Xie, what do you think?
> > > > > >
> > > > > > > > +};
> > > > > > > > +
> > > > > > > >  struct vduse_vq_group {
> > > > > > > > +       rwlock_t as_lock;
> > > > > > > > +       struct vduse_as *as; /* Protected by as_lock */
> > > > > > > >         struct vduse_dev *dev;
> > > > > > > >  };
> > > > > > > >
> > > > > > > > @@ -94,7 +103,7 @@ struct vduse_dev {
> > > > > > > >         struct vduse_vdpa *vdev;
> > > > > > > >         struct device *dev;
> > > > > > > >         struct vduse_virtqueue **vqs;
> > > > > > > > -       struct vduse_iova_domain *domain;
> > > > > > > > +       struct vduse_as *as;
> > > > > > > >         char *name;
> > > > > > > >         struct mutex lock;
> > > > > > > >         spinlock_t msg_lock;
> > > > > > > > @@ -122,9 +131,8 @@ struct vduse_dev {
> > > > > > > >         u32 vq_num;
> > > > > > > >         u32 vq_align;
> > > > > > > >         u32 ngroups;
> > > > > > > > -       struct vduse_umem *umem;
> > > > > > > > +       u32 nas;
> > > > > > > >         struct vduse_vq_group *groups;
> > > > > > > > -       struct mutex mem_lock;
> > > > > > > >         unsigned int bounce_size;
> > > > > > > >         struct mutex domain_lock;
> > > > > > > >  };
> > > > > > > > @@ -314,7 +322,7 @@ static int vduse_dev_set_status(struct =
vduse_dev *dev, u8 status)
> > > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > > > > > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u=
32 asid,
> > > > > > > >                                   u64 start, u64 last)
> > > > > > > >  {
> > > > > > > >         struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > @@ -323,8 +331,14 @@ static int vduse_dev_update_iotlb(stru=
ct vduse_dev *dev,
> > > > > > > >                 return -EINVAL;
> > > > > > > >
> > > > > > > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > > > > > > -       msg.req.iova.start =3D start;
> > > > > > > > -       msg.req.iova.last =3D last;
> > > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > > > > > > +               msg.req.iova.start =3D start;
> > > > > > > > +               msg.req.iova.last =3D last;
> > > > > > > > +       } else {
> > > > > > > > +               msg.req.iova_v2.start =3D start;
> > > > > > > > +               msg.req.iova_v2.last =3D last;
> > > > > > > > +               msg.req.iova_v2.asid =3D asid;
> > > > > > > > +       }
> > > > > > > >
> > > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > > >  }
> > > > > > > > @@ -436,14 +450,29 @@ static __poll_t vduse_dev_poll(struct=
 file *file, poll_table *wait)
> > > > > > > >         return mask;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +/* Force set the asid to a vq group without a message to t=
he VDUSE device */
> > > > > > > > +static void vduse_set_group_asid_nomsg(struct vduse_dev *d=
ev,
> > > > > > > > +                                      unsigned int group, =
unsigned int asid)
> > > > > > > > +{
> > > > > > > > +       write_lock(&dev->groups[group].as_lock);
> > > > > > > > +       dev->groups[group].as =3D &dev->as[asid];
> > > > > > > > +       write_unlock(&dev->groups[group].as_lock);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > > > > > > >  {
> > > > > > > >         int i;
> > > > > > > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > > > > > > >
> > > > > > > >         /* The coherent mappings are handled in vduse_dev_f=
ree_coherent() */
> > > > > > > > -       if (domain && domain->bounce_map)
> > > > > > > > -               vduse_domain_reset_bounce_map(domain);
> > > > > > > > +       for (i =3D 0; i < dev->nas; i++) {
> > > > > > > > +               struct vduse_iova_domain *domain =3D dev->a=
s[i].domain;
> > > > > > > > +
> > > > > > > > +               if (domain && domain->bounce_map)
> > > > > > > > +                       vduse_domain_reset_bounce_map(domai=
n);
> > > > > > >
> > > > > > > Btw, I see this:
> > > > > > >
> > > > > > > void vduse_domain_reset_bounce_map(struct vduse_iova_domain *=
domain)
> > > > > > > {
> > > > > > >         if (!domain->bounce_map)
> > > > > > >                 return;
> > > > > > >
> > > > > > >         spin_lock(&domain->iotlb_lock);
> > > > > > >         if (!domain->bounce_map)
> > > > > > >                 goto unlock;
> > > > > > >
> > > > > > >
> > > > > > > The counbe_map is checked twice, let's fix that.
> > > > > > >
> > > > > >
> > > > > > Double checked locking to avoid taking the lock?
> > > > >
> > > > > I don't know, but I think we don't care too much about the perfor=
mance
> > > > > of vduse_domain_reset_bounce_map().
> > > > >
> > > > > > I don't think it is
> > > > > > worth it to keep it as it is not in the hot path anyway. But th=
at
> > > > > > would also be another patch independent of this series, isn't i=
t?
> > > > >
> > > > > Yes, it's another independent issue I just found when reviewing t=
his patch.
> > > > >
> > > > > >
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > > > > > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> > > > > > >
> > > > > > > Note that this function still does:
> > > > > > >
> > > > > > >                 vq->vq_group =3D 0;
> > > > > > >
> > > > > > > Which is wrong.
> > > > > > >
> > > > > >
> > > > > > Right, removing it for the next version. Thanks for the catch!
> > > > > >
> > > > > > > >
> > > > > > > >         down_write(&dev->rwsem);
> > > > > > > >
> > > > > > > > @@ -623,6 +652,30 @@ static union virtio_map vduse_get_vq_m=
ap(struct vdpa_device *vdpa, u16 idx)
> > > > > > > >         return ret;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static int vduse_set_group_asid(struct vdpa_device *vdpa, =
unsigned int group,
> > > > > > > > +                               unsigned int asid)
> > > > > > > > +{
> > > > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > +       int r;
> > > > > > > > +
> > > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > > > > > > +           group >=3D dev->ngroups || asid >=3D dev->nas |=
|
> > > > > > > > +           dev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> > > > > > > > +               return -EINVAL;
> > > > > > >
> > > > > > > If we forbid setting group asid for !DRIVER_OK, why do we sti=
ll need a
> > > > > > > rwlock?
> > > > > >
> > > > > > virtio_map_ops->alloc is still called before DRIVER_OK to alloc=
ate the
> > > > > > vrings in the bounce buffer, for example. If you're ok with tha=
t I'm
> > > > > > ok with removing the lock, as all the calls are issued by the d=
river
> > > > > > setup process anyway. Or just to keep it for alloc?
> > > > >
> > > > > I see, then I think we need to keep that. The reason is that ther=
e's
> > > > > no guarantee that the alloc() must be called before DRIVER_OK.
> > > > >
> > > > > >
> > > > > > Anyway, I think I misunderstood your comment from [1] then.
> > > > > >
> > > > > > > All we need to do is to synchronize set_group_asid() with
> > > > > > > set_status()/reset()?
> > > > > > >
> > > > > >
> > > > > > That's also a good one. There is no synchronization if one thre=
ad call
> > > > > > reset and then the device is set up from another thread. As all=
 this
> > > > > > situation is still hypothetical because virtio_vdpa does not su=
pport
> > > > > > set_group_asid,
> > > > >
> > > > > Right.
> > > > >
> > > > > > and vhost one is already protected by vhost lock, do
> > > > > > we need it?
> > > > >
> > > > > Let's add a TODO in the code.
> > > > >
> > > >
> > > > Can you expand on this? I meant that there will be no synchronizati=
on
> > > > if we remove the rwlock (or similar). If we keep the rwlock we don'=
t
> > > > need to add any TODO, or am I missing something?
> > >
> > > I meant even with rwlock we don't synchronize set_group_as_id() and
> > > set_status(). Since you said vhost has been synchronized, I think we
> > > should either
> > >
> > > 1) document the synchronization that needs to be done in the upper la=
yer or
> > > 2) add a todo to synchronize the set_status() and set_group_asid()
> > >
> >
> > With the VDUSE messages they are synchronized by dev->msg_lock, the
> > vduse module always has a coherent status from both sides: the VDUSE
> > userland device and virtio_vdpa. If you want vduse not to trust vdpa
> > we can go the extra mile and make dev->status atomic for both device
> > features and group ASID, would that work?
>
> Yes, something like this, for example, msg_lock is only used to
> synchronize the IPC with the userspace, it doesn't synchronize the
> set_status() with set_group_asid().
>
> >
> > > >
> > > > > >
> > > > > > > Or if you want to synchronize map ops with set_status() that =
looks
> > > > > > > like an independent thing (hardening).
> > > > > > >
> > > > > > > > +
> > > > > > > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > > > > > > +       msg.req.vq_group_asid.group =3D group;
> > > > > > > > +       msg.req.vq_group_asid.asid =3D asid;
> > > > > > > > +
> > > > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > > +       if (r < 0)
> > > > > > > > +               return r;
> > > > > > > > +
> > > > > > > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > > > > >
> > > > > > > I'm not sure this has been discussed before, but I think it w=
ould be
> > > > > > > better to introduce a new ioctl to get group -> as mapping. T=
his helps
> > > > > > > to avoid vduse_dev_msg_sync() as much as possible. And it doe=
sn't
> > > > > > > require the userspace to poll vduse fd before DRIVER_OK.
> > > > > > >
> > > >
> > > > The userspace VDUSE device must poll vduse fd to get the DRIVER_OK
> > > > actually. so it cannot avoid polling the vduse device. What are the=
 reasons to
> > > > avoid vduse_dev_msg_sync?
> > >
> > > One less chance to avoid synchronization with userspace.
> > >
> >
> > But the ioctl alternative is more synchronization from my POV, not
> > less. Instead of receiving notifications that we could even batch, the
> > VDUSE userland device needs to issue many synchronous ioctls.
>
> Synchronous ioctl seems to be better than the trick like letting
> kernel to wait for the userspace to response (and timeout).
>

While I don't love the timeout part, I don't see it that way. To add a
"waiting for userspace device ioctl" status to the vduse device
complicates the code in many different places, and it is hard to
return an error from that point. But it is interesting to have on the
table for sure.

> >
> > > >
> > > > > >
> > > > > > I'm fine with that, but how do we communicate that they have ch=
anged?
> > > > >
> > > > > Since we forbid changing the group->as mapping after DRIVER_OK,
> > > > > userspace just needs to use that ioctl once after DRIVER_OK.
> > > > >
> > > >
> > > > But the userland VDUSE device needs to know when ASIDs are set by t=
he
> > > > driver and will not change anymore. In this series it is solved by =
the
> > > > order of the messages, but now we would need a way to know that tim=
e.
> > > > One idea is to issue this new ioctl when it receives VDUSE_SET_STAT=
US
> > > > msg.
> > >
> > > Yes.
> > >
> > > >
> > > > If we do it that way there is still a window where the hypothetical
> > > > (malicious) virtio_vdpa driver can read and write vq groups from
> > > > different threads.
> > >
> > > See above, we need to add synchronization in either vdpa or virtio_vd=
pa.
> > >
> > > > It could issue a set_group_asid after the VDUSE
> > > > device returns from the ioctl but before dev->status has not been
> > > > updated.
> > >
> > > In the case of VDUSE I think either side should not trust the other
> > > side. So userspace needs to be prepared for this, so did the driver.
> > > Since the memory accessing is initiated from the userspace, so it
> > > should not perform any memory access before the ioctl to fetch the
> > > group->asid mapping.
> > >
> >
> > I don't follow this. In the case of virtio_vdpa the ASID groups and
> > features are handled by the kernel entirely. And in the case of
> > vhost_vdpa they are handled by the vhost_dev->mutex lock. So can we
> > trust them?
>
> The problem is there's no way for VDUSE to know whether or not the
> upper layer is vhost or not?
>

My point is not that VDUSE can trust in vhost_vdpa but not in
virtio_vdpa or the reverse, like if we could set a conditional flag in
VDUSE and then modify the behavior based on that.

My point is that the code needs to be consistent in how the VDUSE
kernel module trusts the vdpa driver. It does not make sense to trust
that it will never issue a state change (like a reset) concurrently
with a DMA operation [1] but then don't trust that it will change the
feature flag.

At this moment VDUSE trusts that the vDPA driver does not launch these
operations concurrently, and each vDPA driver has its own way to
synchronize them. In the case of vhost is the vhost_dev mutex, and
virtio_vdpa has other ways. I'll add the hardening here, but this can
of worms can be extended through all the chain. How is that
virtio_vdpa trust virtio_net will never call vdpa_set_features after
DRIVER_OK? and virtio_net with virtio_ring? Should we harden all of
that?

virtio_net does protect against this, as is the one interacting with
userland. Same with vhost_vdpa.

> >
> > > >
> > > > I don't think we should protect that, but if we want to do it we
> > > > should protect that part either acquiring the rwlock and trusting t=
he
> > > > vduse_dev_msg_sync timeout or proceed with atomics, smp_store_relea=
se
> > > > / smp_load_acquire, read and write barriers...
> > > >
> > > > Note that I still think this is overthinking. We have the same
> > > > problems with driver features, where changing in bits like packed v=
q
> > > > changes the behavior of vDPA callbacks and could be able to
> > > > desynchronize the vduse kernel and the userland device.
> > >
> > > Probably, but for driver features, it's too late to do the change.
> > >
> >
> > Why is it late? We just need to add the same synchronization in both
> > driver features and ASID groups. The change is not visible for either
> > virtio_vdpa, vhost_vdpa, or VDUSE userland device, at all.
>
> Ok, I think I get you. I thought we were talking about reducing the
> vduse_dev_msg_sync() when doing SET_FETURES. But you meant the
> synchronization with set_status(). Yes, we can do that.
>
> >
> > > > But since
> > > > virtio_vdpa and vduse kernel modules run in the same kernel, so the=
y should
> > > > be able to trust each other.
> > >
> > > Better not, usually the lower layer (vdpa/vduse) should not trust the
> > > upper layer (virtio-vdpa) in this case.
> > >
> >
> > Ok, adding the hardening in the next version!
> >
> > > But if you stick to the method with vduse_dev_msg_sync, I'm also fine=
 with that.
> > >
> > > >
> > > > > > Or how to communicate to the driver that the device does not ac=
cept
> > > > > > the assignment of the ASID to the group?
> > > > >
> > > > > See above.
> > > > >
> > > >
> > > > I didn't find the answer :(.
> > > >
> > > > Let me put an example with QEMU and vhost_vdpa:
> > > > - QEMU calls VHOST_VDPA_SET_GROUP_ASID with a valid vq group and as=
id.
> > > > - vduse cannot send this information to the device as it must wait =
for
> > > > the ioctl.
> > >
> > > Which ioctl did you mean in this case?
> > >
> >
> > The new ioctl from the userland VDUSE device that you're proposing to
> > accept or reject the set ASID group. Let's call it
> > VDUSE_GET_GROUP_ASID, so let me rewrite the from from that moment:
> >
> > - QEMU calls VHOST_VDPA_SET_GROUP_ASID with a valid vq group (in
> > vdpa->ngroups range) and a valid asid (in vdpa->nas range)
> > - The vduse kernel module cannot send the information to the VDUSE
> > userland device, it must wait until the VDUSE userland device calls
> > the new VDUSE_GET_GROUP_ASID. It will not happen until QEMU calls
> > VHOST_VDPA_SET_STATUS with DRIVER_OK, but QEMU will not call
> > VHOST_VDPA_SET_STATUS until the kernel returns from
> > VHOST_VDPA_SET_GROUP_ASID. The vduse kernel module needs to return
> > success, without knowing if the device will accept it in the future or
> > not.
> > - Now QEMU sends DIRVER_OK, so the vduse kernel module forwards it to
> > the VDUSE userland device. The VDUSE userland device then calls
> > VDUSE_GET_GROUP_ASID, and the flow continues.
> > - The vduse userland device doesn't accept the vq group ASID map for
> > whatever reason, so it returns an error through another ioctl
>
> If the asid is less than the total number of address spaces, any
> reason for the usersapce to reject such configuration?
>

That's a good question I can only answer with "allowing userspace to
communicate back an error here will save us having to expand the
communication protocol when we find the reason".

If we continue the logic that userspace (or vDPA devices) cannot fail
as long as the AS is in range and status is !DRIVER_OK, should we just
move all the checks about valid AS range and valid state to vdpa core
and make the .set_group_asid operation return void? That would be a
good change indeed.

What should VDUSE do if the device replies VDUSE_REQ_RESULT_FAILED?
(or, in your case, if the device never knows the assigned ASID as it
never calls ioctl).

(Actually vhost_vdpa already checks for as < vdpa->nas so that part is
duplicated. It will be simpler in the next version, thanks!).

[1] https://patchew.org/linux/20251217112414.2374672-1-eperezma@redhat.com/=
20251217112414.2374672-8-eperezma@redhat.com/#CACGkMEs6-j8h7X8navZGC0wraan4=
WSLO3NMFx++Fe0uaExWZmA@mail.gmail.com

