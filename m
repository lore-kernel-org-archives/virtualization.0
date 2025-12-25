Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F69E2264BB
	for <virtualization@lists.linux.dev>; Thu, 25 Dec 2025 02:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766629416; cv=none; b=fpSiIO49LfcytQCujPUESM74V7SlIRN4TQNzF82Q2oEf+cDeTFa4fC+fvAOwDFcRdcLNdAjgvBW90fXA35SUXYwabkt9uYAquEf0Vl2Y/hbLAyg/qnq//mIhIsfeAbHrRrhnBQHkAR86SvV1k93pLOtdTvV4HV78XXqJX9WXPCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766629416; c=relaxed/simple;
	bh=v9Y9Hpal/UpR9H9rs76xGdgf14OHrFDuJWCWZX/8jPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRQ+Oup7yXZTwQbRafncsjaTxaXTU4rtRkW/4KDs0yGLQZMSdV41LrYvbw+hPpcMly5dV2FAdFmb7ts/vdinAZVqlriuHOmhMZ2zS3AoFXwXZdn5NOsocT1P768mtXt5wA/FsIPtqbgVcu1GBVX45C9lFWGXimGPh8Q32KnnXO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NyYagNZl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NyYagNZl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766629412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHlHgztM6gH7fv9DfHO20UI6bdPs9RvzbmwEqB3bQ+g=;
	b=NyYagNZlr1rDxUb0QkQIXTweV1T751DPNxQ18v3craH97LQ931A3xPwfnqpnOpwJ4Fov++
	giS8jecN8J1prY+37jdAFmma+b8IPoKsYOnBNGMEOkEzJMz/3/hBFigBU/OIp762D/+CVN
	QZs11E2CoLobbhIMkTPWmMPGE5kRgsM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-4ba6-iA1N5WnmmUpnG4m5w-1; Wed, 24 Dec 2025 21:23:30 -0500
X-MC-Unique: 4ba6-iA1N5WnmmUpnG4m5w-1
X-Mimecast-MFC-AGG-ID: 4ba6-iA1N5WnmmUpnG4m5w_1766629409
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c21341f56so19099032a91.2
        for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 18:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766629409; x=1767234209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UHlHgztM6gH7fv9DfHO20UI6bdPs9RvzbmwEqB3bQ+g=;
        b=jqDKPCEs1ECsKaVaKj3KmtjriN+L/vGlhjeb1mnJPfI30ttprSHVsWjeiG1o2Cw8Wf
         XamGK90tSfUoBqQsctoUIgcqBEg9gjgr2JkrYMOw0mCWCtIjIJ5BM+fvy/mUeFkVwQG/
         2c1WeIB7fNEOQHi269rcmjoeEUn5CBVrzrHIhhCjcOj2jJYrgkhhVnZQSbdto4eAiPRz
         Wh6x/8AsCjO1x1c5Bl05ABeFzv6QYulm/DNdfXxGRE7cccslXbtpvz8Foqr9tTX7H8hz
         yKEH8PGbpylHePeZzsUXHOTyxMa/WLwEZOq+9ZtdaI/7ev8mcipBe/BOQJIgcalcVDy4
         hauw==
X-Forwarded-Encrypted: i=1; AJvYcCUI7LI92hLHQgC/9SBAIgBoRVwJvr9IoAHday/cSiokTlc0b3PQrlLRCG9WSc+5bocmatVfw7G3IflJ9WNUhw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy55Wy50gMQCEziTsQeAMPP31YTeEUAGsz/Yqs1+TjUqe0a0nFf
	WSnyBuYDzXpx3+YO5Gwz8WxZ3eYE7eWDbPqwPN837dacczndQz28+kdkvdrIzT6DVYvHKmYD8bp
	RQG8yII3MB0IKqNPEKl7t57vu+SrYKV+XZd1/HHFe08If4EI+pBqShNe9ZsX01NBcQPwgdDyp/R
	5E7lchmT/4YxGB54E8bSoD7aEBzNMZuxEsn6PIeAGtxEU=
X-Gm-Gg: AY/fxX73QaJQbGXrlAmPhA6w/V1Lf6HRYGqflnVrvcXFkHqUqiBV33eDfXV2P+MmsPj
	l6F3mz6g0G4n2kWp97QWAj6y6Dx0mrAp8B14JxqXO1mmok4Pt/DuZiTsXSHX83SlLaHJFUoKR/X
	wv0XUAqNqpf9mX/0qRV9iW9wIs8/b1o6cjikSgh1v8vzEejmMsqvAwD45Y4cZa2+ZMRkWA
X-Received: by 2002:a17:90b:2f05:b0:34c:fe57:2793 with SMTP id 98e67ed59e1d1-34e921afa99mr17575805a91.20.1766629409259;
        Wed, 24 Dec 2025 18:23:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFv/gNIG3B7xGhUlnMew5sAmIrw9NZzztRvpFgdxPnAqm+I9iLUyjLYl6gvtVTNwkK9xvUNUbQP/skw6AaKXyA=
X-Received: by 2002:a17:90b:2f05:b0:34c:fe57:2793 with SMTP id
 98e67ed59e1d1-34e921afa99mr17575788a91.20.1766629408686; Wed, 24 Dec 2025
 18:23:28 -0800 (PST)
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
 <CACGkMEvXdV4ukZE6xhLL0sSN70G=AWVQgpRnH98Fr4btzMkK9g@mail.gmail.com> <CAJaqyWf-MtnisowpBxjKDM1ULmFVkP4ODWVJiopTSJ7_d6M+aw@mail.gmail.com>
In-Reply-To: <CAJaqyWf-MtnisowpBxjKDM1ULmFVkP4ODWVJiopTSJ7_d6M+aw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Dec 2025 10:23:17 +0800
X-Gm-Features: AQt7F2oVMzsFZ8LrTzDdDCNMP3IDHQ1LwtIQkqvVRbBObPZb344UpUA5PiZq2Dc
Message-ID: <CACGkMEt+4M97qrUm7rybFU4YWG8=52_6xE8EPJaGK_SFZ4o2Cw@mail.gmail.com>
Subject: Re: [PATCH v10 7/8] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B9aWxyge8uuf8jpbTKAr40u02bBvcb_mGKatduRT4TY_1766629409
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 3:39=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Dec 24, 2025 at 1:20=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Tue, Dec 23, 2025 at 9:16=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Tue, Dec 23, 2025 at 2:11=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Thu, Dec 18, 2025 at 9:11=E2=80=AFPM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Thu, Dec 18, 2025 at 7:45=E2=80=AFAM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > >
> > > > > > On Wed, Dec 17, 2025 at 7:24=E2=80=AFPM Eugenio P=C3=A9rez <epe=
rezma@redhat.com> wrote:
> > > > > > >
> > > > > > > Add support for assigning Address Space Identifiers (ASIDs) t=
o each VQ
> > > > > > > group.  This enables mapping each group into a distinct memor=
y space.
> > > > > > >
> > > > > > > The vq group to ASID association is protected by a rwlock now=
.  But the
> > > > > > > mutex domain_lock keeps protecting the domains of all ASIDs, =
as some
> > > > > > > operations like the one related with the bounce buffer size s=
till
> > > > > > > requires to lock all the ASIDs.
> > > > > > >
> > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > >
> > > > > > > ---
> > > > > > > Future improvements can include performance optimizations on =
top could
> > > > > > > move to per-ASID locks, or hardening by tracking ASID or ASID=
 hashes on
> > > > > > > unused bits of the DMA address.
> > > > > > >
> > > > > > > Tested virtio_vdpa by adding manually two threads in vduse_se=
t_status:
> > > > > > > one of them modifies the vq group 0 ASID and the other one ma=
p and unmap
> > > > > > > memory continuously.  After a while, the two threads stop and=
 the usual
> > > > > > > work continues.
> > > > > > >
> > > > > > > Tested with vhost_vdpa by migrating a VM while ping on OVS+VD=
USE.  A few
> > > > > > > workaround were needed in some parts:
> > > > > > > * Do not enable CVQ before data vqs in QEMU, as VDUSE does no=
t forward
> > > > > > >   the enable message to the userland device.  This will be so=
lved in the
> > > > > > >   future.
> > > > > > > * Share the suspended state between all vhost devices in QEMU=
:
> > > > > > >   https://lists.nongnu.org/archive/html/qemu-devel/2025-11/ms=
g02947.html
> > > > > > > * Implement a fake VDUSE suspend vdpa operation callback that=
 always
> > > > > > >   returns true in the kernel.  DPDK suspend the device at the=
 first
> > > > > > >   GET_VRING_BASE.
> > > > > > > * Remove the CVQ blocker in ASID.
> > > > > > >
> > > > > > > ---
> > > > > > > v10:
> > > > > > > * Back to rwlock version so stronger locks are used.
> > > > > > > * Take out allocations from rwlock.
> > > > > > > * Forbid changing ASID of a vq group after DRIVER_OK (Jason)
> > > > > > > * Remove bad fetching again of domain variable in
> > > > > > >   vduse_dev_max_mapping_size (Yongji).
> > > > > > > * Remove unused vdev definition in vdpa map_ops callbacks (ke=
rnel test
> > > > > > >   robot).
> > > > > > >
> > > > > > > v9:
> > > > > > > * Replace mutex with rwlock, as the vdpa map_ops can run from=
 atomic
> > > > > > >   context.
> > > > > > >
> > > > > > > v8:
> > > > > > > * Revert the mutex to rwlock change, it needs proper profilin=
g to
> > > > > > >   justify it.
> > > > > > >
> > > > > > > v7:
> > > > > > > * Take write lock in the error path (Jason).
> > > > > > >
> > > > > > > v6:
> > > > > > > * Make vdpa_dev_add use gotos for error handling (MST).
> > > > > > > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VE=
RSION_1) ?/
> > > > > > >   (MST).
> > > > > > > * Fix struct name not matching in the doc.
> > > > > > >
> > > > > > > v5:
> > > > > > > * Properly return errno if copy_to_user returns >0 in VDUSE_I=
OTLB_GET_FD
> > > > > > >   ioctl (Jason).
> > > > > > > * Properly set domain bounce size to divide equally between n=
as (Jason).
> > > > > > > * Exclude "padding" member from the only >V1 members in
> > > > > > >   vduse_dev_request.
> > > > > > >
> > > > > > > v4:
> > > > > > > * Divide each domain bounce size between the device bounce si=
ze (Jason).
> > > > > > > * revert unneeded addr =3D NULL assignment (Jason)
> > > > > > > * Change if (x && (y || z)) return to if (x) { if (y) return;=
 if (z)
> > > > > > >   return; } (Jason)
> > > > > > > * Change a bad multiline comment, using @ caracter instead of=
 * (Jason).
> > > > > > > * Consider config->nas =3D=3D 0 as a fail (Jason).
> > > > > > >
> > > > > > > v3:
> > > > > > > * Get the vduse domain through the vduse_as in the map functi=
ons
> > > > > > >   (Jason).
> > > > > > > * Squash with the patch creating the vduse_as struct (Jason).
> > > > > > > * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic=
 number
> > > > > > >   (Jason)
> > > > > > >
> > > > > > > v2:
> > > > > > > * Convert the use of mutex to rwlock.
> > > > > > >
> > > > > > > RFC v3:
> > > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set =
to a lower
> > > > > > >   value to reduce memory consumption, but vqs are already lim=
ited to
> > > > > > >   that value and userspace VDUSE is able to allocate that man=
y vqs.
> > > > > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > > > > > >   VDUSE_IOTLB_GET_INFO.
> > > > > > > * Use of array_index_nospec in VDUSE device ioctls.
> > > > > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > > > > > * Move the umem mutex to asid struct so there is no contentio=
n between
> > > > > > >   ASIDs.
> > > > > > >
> > > > > > > RFC v2:
> > > > > > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so th=
e first
> > > > > > >   part of the struct is the same.
> > > > > > > ---
> > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 366 +++++++++++++++++++=
----------
> > > > > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > > > > >  2 files changed, 295 insertions(+), 124 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdp=
a/vdpa_user/vduse_dev.c
> > > > > > > index 767abcb7e375..786ab2378825 100644
> > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > @@ -41,6 +41,7 @@
> > > > > > >
> > > > > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > > > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > > > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > > > > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > > > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > > > > @@ -86,7 +87,15 @@ struct vduse_umem {
> > > > > > >         struct mm_struct *mm;
> > > > > > >  };
> > > > > > >
> > > > > > > +struct vduse_as {
> > > > > > > +       struct vduse_iova_domain *domain;
> > > > > > > +       struct vduse_umem *umem;
> > > > > > > +       struct mutex mem_lock;
> > > > > >
> > > > > > Not related to this patch. But If I was not wrong we have 1:1 m=
apping
> > > > > > between domain and as. If this is true, can we use bounce_lock =
instead
> > > > > > of a new mem_lock? Since I see mem_lock is only used for synchr=
onizing
> > > > > > umem reg/degreg which has been synchronized with domain rwlock.
> > > > > >
> > > > >
> > > > > I think you're right, but they work at different levels at the mo=
ment.
> > > > > The mem_lock is at vduse_dev and also protect the umem pointer, a=
nd
> > > > > bounce_lock is at iova_domain.c .
> > > > >
> > > > > Maybe the right thing to do is to move umem in iova_domain. Yongj=
i
> > > > > Xie, what do you think?
> > > > >
> > > > > > > +};
> > > > > > > +
> > > > > > >  struct vduse_vq_group {
> > > > > > > +       rwlock_t as_lock;
> > > > > > > +       struct vduse_as *as; /* Protected by as_lock */
> > > > > > >         struct vduse_dev *dev;
> > > > > > >  };
> > > > > > >
> > > > > > > @@ -94,7 +103,7 @@ struct vduse_dev {
> > > > > > >         struct vduse_vdpa *vdev;
> > > > > > >         struct device *dev;
> > > > > > >         struct vduse_virtqueue **vqs;
> > > > > > > -       struct vduse_iova_domain *domain;
> > > > > > > +       struct vduse_as *as;
> > > > > > >         char *name;
> > > > > > >         struct mutex lock;
> > > > > > >         spinlock_t msg_lock;
> > > > > > > @@ -122,9 +131,8 @@ struct vduse_dev {
> > > > > > >         u32 vq_num;
> > > > > > >         u32 vq_align;
> > > > > > >         u32 ngroups;
> > > > > > > -       struct vduse_umem *umem;
> > > > > > > +       u32 nas;
> > > > > > >         struct vduse_vq_group *groups;
> > > > > > > -       struct mutex mem_lock;
> > > > > > >         unsigned int bounce_size;
> > > > > > >         struct mutex domain_lock;
> > > > > > >  };
> > > > > > > @@ -314,7 +322,7 @@ static int vduse_dev_set_status(struct vd=
use_dev *dev, u8 status)
> > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > >  }
> > > > > > >
> > > > > > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > > > > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32=
 asid,
> > > > > > >                                   u64 start, u64 last)
> > > > > > >  {
> > > > > > >         struct vduse_dev_msg msg =3D { 0 };
> > > > > > > @@ -323,8 +331,14 @@ static int vduse_dev_update_iotlb(struct=
 vduse_dev *dev,
> > > > > > >                 return -EINVAL;
> > > > > > >
> > > > > > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > > > > > -       msg.req.iova.start =3D start;
> > > > > > > -       msg.req.iova.last =3D last;
> > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > > > > > +               msg.req.iova.start =3D start;
> > > > > > > +               msg.req.iova.last =3D last;
> > > > > > > +       } else {
> > > > > > > +               msg.req.iova_v2.start =3D start;
> > > > > > > +               msg.req.iova_v2.last =3D last;
> > > > > > > +               msg.req.iova_v2.asid =3D asid;
> > > > > > > +       }
> > > > > > >
> > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > >  }
> > > > > > > @@ -436,14 +450,29 @@ static __poll_t vduse_dev_poll(struct f=
ile *file, poll_table *wait)
> > > > > > >         return mask;
> > > > > > >  }
> > > > > > >
> > > > > > > +/* Force set the asid to a vq group without a message to the=
 VDUSE device */
> > > > > > > +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev=
,
> > > > > > > +                                      unsigned int group, un=
signed int asid)
> > > > > > > +{
> > > > > > > +       write_lock(&dev->groups[group].as_lock);
> > > > > > > +       dev->groups[group].as =3D &dev->as[asid];
> > > > > > > +       write_unlock(&dev->groups[group].as_lock);
> > > > > > > +}
> > > > > > > +
> > > > > > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > > > > > >  {
> > > > > > >         int i;
> > > > > > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > > > > > >
> > > > > > >         /* The coherent mappings are handled in vduse_dev_fre=
e_coherent() */
> > > > > > > -       if (domain && domain->bounce_map)
> > > > > > > -               vduse_domain_reset_bounce_map(domain);
> > > > > > > +       for (i =3D 0; i < dev->nas; i++) {
> > > > > > > +               struct vduse_iova_domain *domain =3D dev->as[=
i].domain;
> > > > > > > +
> > > > > > > +               if (domain && domain->bounce_map)
> > > > > > > +                       vduse_domain_reset_bounce_map(domain)=
;
> > > > > >
> > > > > > Btw, I see this:
> > > > > >
> > > > > > void vduse_domain_reset_bounce_map(struct vduse_iova_domain *do=
main)
> > > > > > {
> > > > > >         if (!domain->bounce_map)
> > > > > >                 return;
> > > > > >
> > > > > >         spin_lock(&domain->iotlb_lock);
> > > > > >         if (!domain->bounce_map)
> > > > > >                 goto unlock;
> > > > > >
> > > > > >
> > > > > > The counbe_map is checked twice, let's fix that.
> > > > > >
> > > > >
> > > > > Double checked locking to avoid taking the lock?
> > > >
> > > > I don't know, but I think we don't care too much about the performa=
nce
> > > > of vduse_domain_reset_bounce_map().
> > > >
> > > > > I don't think it is
> > > > > worth it to keep it as it is not in the hot path anyway. But that
> > > > > would also be another patch independent of this series, isn't it?
> > > >
> > > > Yes, it's another independent issue I just found when reviewing thi=
s patch.
> > > >
> > > > >
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > > > > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> > > > > >
> > > > > > Note that this function still does:
> > > > > >
> > > > > >                 vq->vq_group =3D 0;
> > > > > >
> > > > > > Which is wrong.
> > > > > >
> > > > >
> > > > > Right, removing it for the next version. Thanks for the catch!
> > > > >
> > > > > > >
> > > > > > >         down_write(&dev->rwsem);
> > > > > > >
> > > > > > > @@ -623,6 +652,30 @@ static union virtio_map vduse_get_vq_map=
(struct vdpa_device *vdpa, u16 idx)
> > > > > > >         return ret;
> > > > > > >  }
> > > > > > >
> > > > > > > +static int vduse_set_group_asid(struct vdpa_device *vdpa, un=
signed int group,
> > > > > > > +                               unsigned int asid)
> > > > > > > +{
> > > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > > +       int r;
> > > > > > > +
> > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > > > > > +           group >=3D dev->ngroups || asid >=3D dev->nas ||
> > > > > > > +           dev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> > > > > > > +               return -EINVAL;
> > > > > >
> > > > > > If we forbid setting group asid for !DRIVER_OK, why do we still=
 need a
> > > > > > rwlock?
> > > > >
> > > > > virtio_map_ops->alloc is still called before DRIVER_OK to allocat=
e the
> > > > > vrings in the bounce buffer, for example. If you're ok with that =
I'm
> > > > > ok with removing the lock, as all the calls are issued by the dri=
ver
> > > > > setup process anyway. Or just to keep it for alloc?
> > > >
> > > > I see, then I think we need to keep that. The reason is that there'=
s
> > > > no guarantee that the alloc() must be called before DRIVER_OK.
> > > >
> > > > >
> > > > > Anyway, I think I misunderstood your comment from [1] then.
> > > > >
> > > > > > All we need to do is to synchronize set_group_asid() with
> > > > > > set_status()/reset()?
> > > > > >
> > > > >
> > > > > That's also a good one. There is no synchronization if one thread=
 call
> > > > > reset and then the device is set up from another thread. As all t=
his
> > > > > situation is still hypothetical because virtio_vdpa does not supp=
ort
> > > > > set_group_asid,
> > > >
> > > > Right.
> > > >
> > > > > and vhost one is already protected by vhost lock, do
> > > > > we need it?
> > > >
> > > > Let's add a TODO in the code.
> > > >
> > >
> > > Can you expand on this? I meant that there will be no synchronization
> > > if we remove the rwlock (or similar). If we keep the rwlock we don't
> > > need to add any TODO, or am I missing something?
> >
> > I meant even with rwlock we don't synchronize set_group_as_id() and
> > set_status(). Since you said vhost has been synchronized, I think we
> > should either
> >
> > 1) document the synchronization that needs to be done in the upper laye=
r or
> > 2) add a todo to synchronize the set_status() and set_group_asid()
> >
>
> With the VDUSE messages they are synchronized by dev->msg_lock, the
> vduse module always has a coherent status from both sides: the VDUSE
> userland device and virtio_vdpa. If you want vduse not to trust vdpa
> we can go the extra mile and make dev->status atomic for both device
> features and group ASID, would that work?

Yes, something like this, for example, msg_lock is only used to
synchronize the IPC with the userspace, it doesn't synchronize the
set_status() with set_group_asid().

>
> > >
> > > > >
> > > > > > Or if you want to synchronize map ops with set_status() that lo=
oks
> > > > > > like an independent thing (hardening).
> > > > > >
> > > > > > > +
> > > > > > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > > > > > +       msg.req.vq_group_asid.group =3D group;
> > > > > > > +       msg.req.vq_group_asid.asid =3D asid;
> > > > > > > +
> > > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > +       if (r < 0)
> > > > > > > +               return r;
> > > > > > > +
> > > > > > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > > > >
> > > > > > I'm not sure this has been discussed before, but I think it wou=
ld be
> > > > > > better to introduce a new ioctl to get group -> as mapping. Thi=
s helps
> > > > > > to avoid vduse_dev_msg_sync() as much as possible. And it doesn=
't
> > > > > > require the userspace to poll vduse fd before DRIVER_OK.
> > > > > >
> > >
> > > The userspace VDUSE device must poll vduse fd to get the DRIVER_OK
> > > actually. so it cannot avoid polling the vduse device. What are the r=
easons to
> > > avoid vduse_dev_msg_sync?
> >
> > One less chance to avoid synchronization with userspace.
> >
>
> But the ioctl alternative is more synchronization from my POV, not
> less. Instead of receiving notifications that we could even batch, the
> VDUSE userland device needs to issue many synchronous ioctls.

Synchronous ioctl seems to be better than the trick like letting
kernel to wait for the userspace to response (and timeout).

>
> > >
> > > > >
> > > > > I'm fine with that, but how do we communicate that they have chan=
ged?
> > > >
> > > > Since we forbid changing the group->as mapping after DRIVER_OK,
> > > > userspace just needs to use that ioctl once after DRIVER_OK.
> > > >
> > >
> > > But the userland VDUSE device needs to know when ASIDs are set by the
> > > driver and will not change anymore. In this series it is solved by th=
e
> > > order of the messages, but now we would need a way to know that time.
> > > One idea is to issue this new ioctl when it receives VDUSE_SET_STATUS
> > > msg.
> >
> > Yes.
> >
> > >
> > > If we do it that way there is still a window where the hypothetical
> > > (malicious) virtio_vdpa driver can read and write vq groups from
> > > different threads.
> >
> > See above, we need to add synchronization in either vdpa or virtio_vdpa=
.
> >
> > > It could issue a set_group_asid after the VDUSE
> > > device returns from the ioctl but before dev->status has not been
> > > updated.
> >
> > In the case of VDUSE I think either side should not trust the other
> > side. So userspace needs to be prepared for this, so did the driver.
> > Since the memory accessing is initiated from the userspace, so it
> > should not perform any memory access before the ioctl to fetch the
> > group->asid mapping.
> >
>
> I don't follow this. In the case of virtio_vdpa the ASID groups and
> features are handled by the kernel entirely. And in the case of
> vhost_vdpa they are handled by the vhost_dev->mutex lock. So can we
> trust them?

The problem is there's no way for VDUSE to know whether or not the
upper layer is vhost or not?

>
> > >
> > > I don't think we should protect that, but if we want to do it we
> > > should protect that part either acquiring the rwlock and trusting the
> > > vduse_dev_msg_sync timeout or proceed with atomics, smp_store_release
> > > / smp_load_acquire, read and write barriers...
> > >
> > > Note that I still think this is overthinking. We have the same
> > > problems with driver features, where changing in bits like packed vq
> > > changes the behavior of vDPA callbacks and could be able to
> > > desynchronize the vduse kernel and the userland device.
> >
> > Probably, but for driver features, it's too late to do the change.
> >
>
> Why is it late? We just need to add the same synchronization in both
> driver features and ASID groups. The change is not visible for either
> virtio_vdpa, vhost_vdpa, or VDUSE userland device, at all.

Ok, I think I get you. I thought we were talking about reducing the
vduse_dev_msg_sync() when doing SET_FETURES. But you meant the
synchronization with set_status(). Yes, we can do that.

>
> > > But since
> > > virtio_vdpa and vduse kernel modules run in the same kernel, so they =
should
> > > be able to trust each other.
> >
> > Better not, usually the lower layer (vdpa/vduse) should not trust the
> > upper layer (virtio-vdpa) in this case.
> >
>
> Ok, adding the hardening in the next version!
>
> > But if you stick to the method with vduse_dev_msg_sync, I'm also fine w=
ith that.
> >
> > >
> > > > > Or how to communicate to the driver that the device does not acce=
pt
> > > > > the assignment of the ASID to the group?
> > > >
> > > > See above.
> > > >
> > >
> > > I didn't find the answer :(.
> > >
> > > Let me put an example with QEMU and vhost_vdpa:
> > > - QEMU calls VHOST_VDPA_SET_GROUP_ASID with a valid vq group and asid=
.
> > > - vduse cannot send this information to the device as it must wait fo=
r
> > > the ioctl.
> >
> > Which ioctl did you mean in this case?
> >
>
> The new ioctl from the userland VDUSE device that you're proposing to
> accept or reject the set ASID group. Let's call it
> VDUSE_GET_GROUP_ASID, so let me rewrite the from from that moment:
>
> - QEMU calls VHOST_VDPA_SET_GROUP_ASID with a valid vq group (in
> vdpa->ngroups range) and a valid asid (in vdpa->nas range)
> - The vduse kernel module cannot send the information to the VDUSE
> userland device, it must wait until the VDUSE userland device calls
> the new VDUSE_GET_GROUP_ASID. It will not happen until QEMU calls
> VHOST_VDPA_SET_STATUS with DRIVER_OK, but QEMU will not call
> VHOST_VDPA_SET_STATUS until the kernel returns from
> VHOST_VDPA_SET_GROUP_ASID. The vduse kernel module needs to return
> success, without knowing if the device will accept it in the future or
> not.
> - Now QEMU sends DIRVER_OK, so the vduse kernel module forwards it to
> the VDUSE userland device. The VDUSE userland device then calls
> VDUSE_GET_GROUP_ASID, and the flow continues.
> - The vduse userland device doesn't accept the vq group ASID map for
> whatever reason, so it returns an error through another ioctl

If the asid is less than the total number of address spaces, any
reason for the usersapce to reject such configuration?

Thanks

