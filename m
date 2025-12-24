Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE803EEAB
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 00:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766535659; cv=none; b=J3s2e/f4L0N7IYU2XjxJJF463Z23Jh/g+R4sb5mYVR/I5JDCYRNpZ2bA5QJXt4Vh2V2Q7GKXu1/6fNy6GWiAt/B2si8DunmSI3Ux1suY9aPyCji/8yDcNQKJ8HZnHTDX3H9OBiR+wDHGroF7Kn5Bp7iPJdsAfMzGMCSzNjoxmTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766535659; c=relaxed/simple;
	bh=xNwDI//NjiIdIotm6PujF9nNQGgFtCfxNjSP8Zt8/iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnDn12uuTCzCqkAdsn3ZxoRdGxMQdx4+YWG6wf/sy6UGiUfYbKKQPzUNGjyYyI6h5zuDgwV4xcM+dMxtS6F1mJbcfcc0Ay+9a7mxxO4l0gNfcNMNJqj7lXNI0IWXS2Z4GzkQXnY/e5vXrE+PyRkRZBKbpSXt278RJzMuoIi7c3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dsa6jCbc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dsa6jCbc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766535654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jp3Ij1V0c6G3Yj+gv1az2gTaHyjDirRW3mVKEoNu0qc=;
	b=Dsa6jCbcSlUP2sAJefTSNBUnJxZzFCj+UeRFx/fS95OPJKeVysuO9q77A+bCeKtfTkHh6+
	m1vdPnarMXlN/l8VuKmDSCcedimtoN114xzKiWYk3z4aiZiqpKXDo31ebY8is086dPm00M
	9x1d3uROgHfIOsPsovQzBm7yKStUfD0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-GZXEoIEZOkuscUwQC4WWIw-1; Tue, 23 Dec 2025 19:20:52 -0500
X-MC-Unique: GZXEoIEZOkuscUwQC4WWIw-1
X-Mimecast-MFC-AGG-ID: GZXEoIEZOkuscUwQC4WWIw_1766535651
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34e70e2e363so11498126a91.1
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 16:20:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766535651; x=1767140451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jp3Ij1V0c6G3Yj+gv1az2gTaHyjDirRW3mVKEoNu0qc=;
        b=KhttkXjfn83xM5JqIePdq98M5+h5T0HVVlRxF9TC+BPOd+wEX33oLBfX7iKWg1iBk0
         DydE0k8KBsxJiWImSbwSEekBfThWdUg1jKgY5TZ8x4QyJaTnoJEHzY/2rMt23p8BiEAG
         6U0pFGXfYk2GO2y9LqY+4jgNLBpXXl0qDWDhW4nYOcz9UkuueXK0S4O61RZ+PNaJE1di
         fyjTv9ab/0aoPWTk9BfEwl/oMDEyB+qH462BXkcMyPAvhpruByf1truuj1gfIBuvd++1
         Vvl3v4sIsZ0myYESWFE46DH+Oxf1St1Js1okqhg31CakBNz2Z9PLog6VdjJkB3KK6645
         Hphw==
X-Forwarded-Encrypted: i=1; AJvYcCU8fSDu+o3nbtA1YBIFwPhEGhqXUhQ0ThjZOXo9Z1PpvCBQJk15/8l/mcNaQ5gfDEa5amoNS1pUJ7nXN3f0Bg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxV860lhRmkzecYkdBa08PjPOM/yXPzBJIzej61ScmZRyF19LXc
	/r93E41tOBmBBVLkaettMzBkhaD+mcNU7pHzCVF/odB8NI2l/6vYltS7Plv86QRaB0XhYxMQGfX
	5Q3dJMQ+8GBYcVxjqn6pggfFA7zzBff4ZSkFbge1bBxfgnw9lYlDGNVZ2TfM+p1Ljo2bUwvTT7M
	xbmZ2oicyZRkhKrp1RyLGX27PXQ3ejKnUwtZdV71MwvGQ=
X-Gm-Gg: AY/fxX7ZpakDVp/Gcr5VCT441LVAwyoVGPx4OnZHvKwIIJvxfOQyp8I/+q+068nutar
	pWvYPsL+Zvs7mOuH0hl2iWxxWEP3BmTk+28PSgWv472RPSlSPTIjQonZTrfCz0yxugoIQUmQvdn
	19kH+ePxcKpjScd+bhBv4yPRyv82zZC0S34StDyapPDybTekAz3ZARq9cfAfU3c1/1filG
X-Received: by 2002:a17:90b:3145:b0:32d:d5f1:fe7f with SMTP id 98e67ed59e1d1-34e92142cb5mr14480453a91.15.1766535650909;
        Tue, 23 Dec 2025 16:20:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEL+Vwzq7av3QQZ4GlMrypRkMTzgk7CkSYM2OTtC1+1GBUl4wIE5+hfLhlpL/6D+PuIb3U703MI00kOPubVMVA=
X-Received: by 2002:a17:90b:3145:b0:32d:d5f1:fe7f with SMTP id
 98e67ed59e1d1-34e92142cb5mr14480425a91.15.1766535650118; Tue, 23 Dec 2025
 16:20:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251217112414.2374672-1-eperezma@redhat.com> <20251217112414.2374672-8-eperezma@redhat.com>
 <CACGkMEs6-j8h7X8navZGC0wraan4WSLO3NMFx++Fe0uaExWZmA@mail.gmail.com>
 <CAJaqyWccuSam1W6WpMF64QF1RmJtVMkfH_uvF56RKJzCzwer1w@mail.gmail.com>
 <CACGkMEu1Lxun4aPza+kw7KrmLZJkfmW22KQNxbch+YhiTMkJZg@mail.gmail.com> <CAJaqyWe=YSV-gRqOra-yiiBFKR793pHJDT7t8mDTrrFKjzZ=Ow@mail.gmail.com>
In-Reply-To: <CAJaqyWe=YSV-gRqOra-yiiBFKR793pHJDT7t8mDTrrFKjzZ=Ow@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Dec 2025 08:20:36 +0800
X-Gm-Features: AQt7F2qGn_Jcck4ILtDXPSnnS9eOpwyDeMFc9DHmresrXyCYn2IO0SrlbKVKxdA
Message-ID: <CACGkMEvXdV4ukZE6xhLL0sSN70G=AWVQgpRnH98Fr4btzMkK9g@mail.gmail.com>
Subject: Re: [PATCH v10 7/8] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AYG23YJ0H_o2wwXjnM6Z_l6CK40BTg36Zqi3eBgTLG8_1766535651
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 9:16=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Tue, Dec 23, 2025 at 2:11=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Dec 18, 2025 at 9:11=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Thu, Dec 18, 2025 at 7:45=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Wed, Dec 17, 2025 at 7:24=E2=80=AFPM Eugenio P=C3=A9rez <eperezm=
a@redhat.com> wrote:
> > > > >
> > > > > Add support for assigning Address Space Identifiers (ASIDs) to ea=
ch VQ
> > > > > group.  This enables mapping each group into a distinct memory sp=
ace.
> > > > >
> > > > > The vq group to ASID association is protected by a rwlock now.  B=
ut the
> > > > > mutex domain_lock keeps protecting the domains of all ASIDs, as s=
ome
> > > > > operations like the one related with the bounce buffer size still
> > > > > requires to lock all the ASIDs.
> > > > >
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > >
> > > > > ---
> > > > > Future improvements can include performance optimizations on top =
could
> > > > > move to per-ASID locks, or hardening by tracking ASID or ASID has=
hes on
> > > > > unused bits of the DMA address.
> > > > >
> > > > > Tested virtio_vdpa by adding manually two threads in vduse_set_st=
atus:
> > > > > one of them modifies the vq group 0 ASID and the other one map an=
d unmap
> > > > > memory continuously.  After a while, the two threads stop and the=
 usual
> > > > > work continues.
> > > > >
> > > > > Tested with vhost_vdpa by migrating a VM while ping on OVS+VDUSE.=
  A few
> > > > > workaround were needed in some parts:
> > > > > * Do not enable CVQ before data vqs in QEMU, as VDUSE does not fo=
rward
> > > > >   the enable message to the userland device.  This will be solved=
 in the
> > > > >   future.
> > > > > * Share the suspended state between all vhost devices in QEMU:
> > > > >   https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg029=
47.html
> > > > > * Implement a fake VDUSE suspend vdpa operation callback that alw=
ays
> > > > >   returns true in the kernel.  DPDK suspend the device at the fir=
st
> > > > >   GET_VRING_BASE.
> > > > > * Remove the CVQ blocker in ASID.
> > > > >
> > > > > ---
> > > > > v10:
> > > > > * Back to rwlock version so stronger locks are used.
> > > > > * Take out allocations from rwlock.
> > > > > * Forbid changing ASID of a vq group after DRIVER_OK (Jason)
> > > > > * Remove bad fetching again of domain variable in
> > > > >   vduse_dev_max_mapping_size (Yongji).
> > > > > * Remove unused vdev definition in vdpa map_ops callbacks (kernel=
 test
> > > > >   robot).
> > > > >
> > > > > v9:
> > > > > * Replace mutex with rwlock, as the vdpa map_ops can run from ato=
mic
> > > > >   context.
> > > > >
> > > > > v8:
> > > > > * Revert the mutex to rwlock change, it needs proper profiling to
> > > > >   justify it.
> > > > >
> > > > > v7:
> > > > > * Take write lock in the error path (Jason).
> > > > >
> > > > > v6:
> > > > > * Make vdpa_dev_add use gotos for error handling (MST).
> > > > > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VERSIO=
N_1) ?/
> > > > >   (MST).
> > > > > * Fix struct name not matching in the doc.
> > > > >
> > > > > v5:
> > > > > * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB=
_GET_FD
> > > > >   ioctl (Jason).
> > > > > * Properly set domain bounce size to divide equally between nas (=
Jason).
> > > > > * Exclude "padding" member from the only >V1 members in
> > > > >   vduse_dev_request.
> > > > >
> > > > > v4:
> > > > > * Divide each domain bounce size between the device bounce size (=
Jason).
> > > > > * revert unneeded addr =3D NULL assignment (Jason)
> > > > > * Change if (x && (y || z)) return to if (x) { if (y) return; if =
(z)
> > > > >   return; } (Jason)
> > > > > * Change a bad multiline comment, using @ caracter instead of * (=
Jason).
> > > > > * Consider config->nas =3D=3D 0 as a fail (Jason).
> > > > >
> > > > > v3:
> > > > > * Get the vduse domain through the vduse_as in the map functions
> > > > >   (Jason).
> > > > > * Squash with the patch creating the vduse_as struct (Jason).
> > > > > * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic num=
ber
> > > > >   (Jason)
> > > > >
> > > > > v2:
> > > > > * Convert the use of mutex to rwlock.
> > > > >
> > > > > RFC v3:
> > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a=
 lower
> > > > >   value to reduce memory consumption, but vqs are already limited=
 to
> > > > >   that value and userspace VDUSE is able to allocate that many vq=
s.
> > > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > > > >   VDUSE_IOTLB_GET_INFO.
> > > > > * Use of array_index_nospec in VDUSE device ioctls.
> > > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > > > * Move the umem mutex to asid struct so there is no contention be=
tween
> > > > >   ASIDs.
> > > > >
> > > > > RFC v2:
> > > > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the fi=
rst
> > > > >   part of the struct is the same.
> > > > > ---
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 366 +++++++++++++++++++----=
------
> > > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > > >  2 files changed, 295 insertions(+), 124 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vd=
pa_user/vduse_dev.c
> > > > > index 767abcb7e375..786ab2378825 100644
> > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > @@ -41,6 +41,7 @@
> > > > >
> > > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > > @@ -86,7 +87,15 @@ struct vduse_umem {
> > > > >         struct mm_struct *mm;
> > > > >  };
> > > > >
> > > > > +struct vduse_as {
> > > > > +       struct vduse_iova_domain *domain;
> > > > > +       struct vduse_umem *umem;
> > > > > +       struct mutex mem_lock;
> > > >
> > > > Not related to this patch. But If I was not wrong we have 1:1 mappi=
ng
> > > > between domain and as. If this is true, can we use bounce_lock inst=
ead
> > > > of a new mem_lock? Since I see mem_lock is only used for synchroniz=
ing
> > > > umem reg/degreg which has been synchronized with domain rwlock.
> > > >
> > >
> > > I think you're right, but they work at different levels at the moment=
.
> > > The mem_lock is at vduse_dev and also protect the umem pointer, and
> > > bounce_lock is at iova_domain.c .
> > >
> > > Maybe the right thing to do is to move umem in iova_domain. Yongji
> > > Xie, what do you think?
> > >
> > > > > +};
> > > > > +
> > > > >  struct vduse_vq_group {
> > > > > +       rwlock_t as_lock;
> > > > > +       struct vduse_as *as; /* Protected by as_lock */
> > > > >         struct vduse_dev *dev;
> > > > >  };
> > > > >
> > > > > @@ -94,7 +103,7 @@ struct vduse_dev {
> > > > >         struct vduse_vdpa *vdev;
> > > > >         struct device *dev;
> > > > >         struct vduse_virtqueue **vqs;
> > > > > -       struct vduse_iova_domain *domain;
> > > > > +       struct vduse_as *as;
> > > > >         char *name;
> > > > >         struct mutex lock;
> > > > >         spinlock_t msg_lock;
> > > > > @@ -122,9 +131,8 @@ struct vduse_dev {
> > > > >         u32 vq_num;
> > > > >         u32 vq_align;
> > > > >         u32 ngroups;
> > > > > -       struct vduse_umem *umem;
> > > > > +       u32 nas;
> > > > >         struct vduse_vq_group *groups;
> > > > > -       struct mutex mem_lock;
> > > > >         unsigned int bounce_size;
> > > > >         struct mutex domain_lock;
> > > > >  };
> > > > > @@ -314,7 +322,7 @@ static int vduse_dev_set_status(struct vduse_=
dev *dev, u8 status)
> > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > >  }
> > > > >
> > > > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asi=
d,
> > > > >                                   u64 start, u64 last)
> > > > >  {
> > > > >         struct vduse_dev_msg msg =3D { 0 };
> > > > > @@ -323,8 +331,14 @@ static int vduse_dev_update_iotlb(struct vdu=
se_dev *dev,
> > > > >                 return -EINVAL;
> > > > >
> > > > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > > > -       msg.req.iova.start =3D start;
> > > > > -       msg.req.iova.last =3D last;
> > > > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > > > +               msg.req.iova.start =3D start;
> > > > > +               msg.req.iova.last =3D last;
> > > > > +       } else {
> > > > > +               msg.req.iova_v2.start =3D start;
> > > > > +               msg.req.iova_v2.last =3D last;
> > > > > +               msg.req.iova_v2.asid =3D asid;
> > > > > +       }
> > > > >
> > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > >  }
> > > > > @@ -436,14 +450,29 @@ static __poll_t vduse_dev_poll(struct file =
*file, poll_table *wait)
> > > > >         return mask;
> > > > >  }
> > > > >
> > > > > +/* Force set the asid to a vq group without a message to the VDU=
SE device */
> > > > > +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> > > > > +                                      unsigned int group, unsign=
ed int asid)
> > > > > +{
> > > > > +       write_lock(&dev->groups[group].as_lock);
> > > > > +       dev->groups[group].as =3D &dev->as[asid];
> > > > > +       write_unlock(&dev->groups[group].as_lock);
> > > > > +}
> > > > > +
> > > > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > > > >  {
> > > > >         int i;
> > > > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > > > >
> > > > >         /* The coherent mappings are handled in vduse_dev_free_co=
herent() */
> > > > > -       if (domain && domain->bounce_map)
> > > > > -               vduse_domain_reset_bounce_map(domain);
> > > > > +       for (i =3D 0; i < dev->nas; i++) {
> > > > > +               struct vduse_iova_domain *domain =3D dev->as[i].d=
omain;
> > > > > +
> > > > > +               if (domain && domain->bounce_map)
> > > > > +                       vduse_domain_reset_bounce_map(domain);
> > > >
> > > > Btw, I see this:
> > > >
> > > > void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain=
)
> > > > {
> > > >         if (!domain->bounce_map)
> > > >                 return;
> > > >
> > > >         spin_lock(&domain->iotlb_lock);
> > > >         if (!domain->bounce_map)
> > > >                 goto unlock;
> > > >
> > > >
> > > > The counbe_map is checked twice, let's fix that.
> > > >
> > >
> > > Double checked locking to avoid taking the lock?
> >
> > I don't know, but I think we don't care too much about the performance
> > of vduse_domain_reset_bounce_map().
> >
> > > I don't think it is
> > > worth it to keep it as it is not in the hot path anyway. But that
> > > would also be another patch independent of this series, isn't it?
> >
> > Yes, it's another independent issue I just found when reviewing this pa=
tch.
> >
> > >
> > > > > +       }
> > > > > +
> > > > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> > > >
> > > > Note that this function still does:
> > > >
> > > >                 vq->vq_group =3D 0;
> > > >
> > > > Which is wrong.
> > > >
> > >
> > > Right, removing it for the next version. Thanks for the catch!
> > >
> > > > >
> > > > >         down_write(&dev->rwsem);
> > > > >
> > > > > @@ -623,6 +652,30 @@ static union virtio_map vduse_get_vq_map(str=
uct vdpa_device *vdpa, u16 idx)
> > > > >         return ret;
> > > > >  }
> > > > >
> > > > > +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsign=
ed int group,
> > > > > +                               unsigned int asid)
> > > > > +{
> > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > +       int r;
> > > > > +
> > > > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > > > +           group >=3D dev->ngroups || asid >=3D dev->nas ||
> > > > > +           dev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> > > > > +               return -EINVAL;
> > > >
> > > > If we forbid setting group asid for !DRIVER_OK, why do we still nee=
d a
> > > > rwlock?
> > >
> > > virtio_map_ops->alloc is still called before DRIVER_OK to allocate th=
e
> > > vrings in the bounce buffer, for example. If you're ok with that I'm
> > > ok with removing the lock, as all the calls are issued by the driver
> > > setup process anyway. Or just to keep it for alloc?
> >
> > I see, then I think we need to keep that. The reason is that there's
> > no guarantee that the alloc() must be called before DRIVER_OK.
> >
> > >
> > > Anyway, I think I misunderstood your comment from [1] then.
> > >
> > > > All we need to do is to synchronize set_group_asid() with
> > > > set_status()/reset()?
> > > >
> > >
> > > That's also a good one. There is no synchronization if one thread cal=
l
> > > reset and then the device is set up from another thread. As all this
> > > situation is still hypothetical because virtio_vdpa does not support
> > > set_group_asid,
> >
> > Right.
> >
> > > and vhost one is already protected by vhost lock, do
> > > we need it?
> >
> > Let's add a TODO in the code.
> >
>
> Can you expand on this? I meant that there will be no synchronization
> if we remove the rwlock (or similar). If we keep the rwlock we don't
> need to add any TODO, or am I missing something?

I meant even with rwlock we don't synchronize set_group_as_id() and
set_status(). Since you said vhost has been synchronized, I think we
should either

1) document the synchronization that needs to be done in the upper layer or
2) add a todo to synchronize the set_status() and set_group_asid()

>
> > >
> > > > Or if you want to synchronize map ops with set_status() that looks
> > > > like an independent thing (hardening).
> > > >
> > > > > +
> > > > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > > > +       msg.req.vq_group_asid.group =3D group;
> > > > > +       msg.req.vq_group_asid.asid =3D asid;
> > > > > +
> > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > +       if (r < 0)
> > > > > +               return r;
> > > > > +
> > > > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > >
> > > > I'm not sure this has been discussed before, but I think it would b=
e
> > > > better to introduce a new ioctl to get group -> as mapping. This he=
lps
> > > > to avoid vduse_dev_msg_sync() as much as possible. And it doesn't
> > > > require the userspace to poll vduse fd before DRIVER_OK.
> > > >
>
> The userspace VDUSE device must poll vduse fd to get the DRIVER_OK
> actually. so it cannot avoid polling the vduse device. What are the reaso=
ns to
> avoid vduse_dev_msg_sync?

One less chance to avoid synchronization with userspace.

>
> > >
> > > I'm fine with that, but how do we communicate that they have changed?
> >
> > Since we forbid changing the group->as mapping after DRIVER_OK,
> > userspace just needs to use that ioctl once after DRIVER_OK.
> >
>
> But the userland VDUSE device needs to know when ASIDs are set by the
> driver and will not change anymore. In this series it is solved by the
> order of the messages, but now we would need a way to know that time.
> One idea is to issue this new ioctl when it receives VDUSE_SET_STATUS
> msg.

Yes.

>
> If we do it that way there is still a window where the hypothetical
> (malicious) virtio_vdpa driver can read and write vq groups from
> different threads.

See above, we need to add synchronization in either vdpa or virtio_vdpa.

> It could issue a set_group_asid after the VDUSE
> device returns from the ioctl but before dev->status has not been
> updated.

In the case of VDUSE I think either side should not trust the other
side. So userspace needs to be prepared for this, so did the driver.
Since the memory accessing is initiated from the userspace, so it
should not perform any memory access before the ioctl to fetch the
group->asid mapping.

>
> I don't think we should protect that, but if we want to do it we
> should protect that part either acquiring the rwlock and trusting the
> vduse_dev_msg_sync timeout or proceed with atomics, smp_store_release
> / smp_load_acquire, read and write barriers...
>
> Note that I still think this is overthinking. We have the same
> problems with driver features, where changing in bits like packed vq
> changes the behavior of vDPA callbacks and could be able to
> desynchronize the vduse kernel and the userland device.

Probably, but for driver features, it's too late to do the change.

> But since
> virtio_vdpa and vduse kernel modules run in the same kernel, so they shou=
ld
> be able to trust each other.

Better not, usually the lower layer (vdpa/vduse) should not trust the
upper layer (virtio-vdpa) in this case.

But if you stick to the method with vduse_dev_msg_sync, I'm also fine with =
that.

>
> > > Or how to communicate to the driver that the device does not accept
> > > the assignment of the ASID to the group?
> >
> > See above.
> >
>
> I didn't find the answer :(.
>
> Let me put an example with QEMU and vhost_vdpa:
> - QEMU calls VHOST_VDPA_SET_GROUP_ASID with a valid vq group and asid.
> - vduse cannot send this information to the device as it must wait for
> the ioctl.

Which ioctl did you mean in this case?

> It returns success to the QEMU ioctl.
> - Now the vduse userland device doesn't accept the vq group ASID, so
> it returns an error through that ioctl. I'm not sure how, should it
> just reset the whole device? NEED_RESET?

Vduse userland needs to do ioctl VDUSE_GET_GROUP_ASID after DRIVER_OK,
then everything is fine?

> - If it does not reset the whole device, how to return that single set
> vq group asid error to QEMU?
>
> > >
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16=
 idx,
> > > > >                                 struct vdpa_vq_state *state)
> > > > >  {
> > > > > @@ -794,13 +847,13 @@ static int vduse_vdpa_set_map(struct vdpa_d=
evice *vdpa,
> > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > >         int ret;
> > > > >
> > > > > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > > > > +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb)=
;
> > > > >         if (ret)
> > > > >                 return ret;
> > > > >
> > > > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > > > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MA=
X);
> > > > >         if (ret) {
> > > > > -               vduse_domain_clear_map(dev->domain, iotlb);
> > > > > +               vduse_domain_clear_map(dev->as[asid].domain, iotl=
b);
> > > > >                 return ret;
> > > > >         }
> > > > >
> > > > > @@ -843,6 +896,7 @@ static const struct vdpa_config_ops vduse_vdp=
a_config_ops =3D {
> > > > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > > > >         .reset                  =3D vduse_vdpa_reset,
> > > > >         .set_map                =3D vduse_vdpa_set_map,
> > > > > +       .set_group_asid         =3D vduse_set_group_asid,
> > > > >         .get_vq_map             =3D vduse_get_vq_map,
> > > > >         .free                   =3D vduse_vdpa_free,
> > > > >  };
> > > > > @@ -851,32 +905,30 @@ static void vduse_dev_sync_single_for_devic=
e(union virtio_map token,
> > > > >                                              dma_addr_t dma_addr,=
 size_t size,
> > > > >                                              enum dma_data_direct=
ion dir)
> > > > >  {
> > > > > -       struct vduse_dev *vdev;
> > > > >         struct vduse_iova_domain *domain;
> > > > >
> > > > >         if (!token.group)
> > > > >                 return;
> > > > >
> > > > > -       vdev =3D token.group->dev;
> > > > > -       domain =3D vdev->domain;
> > > > > -
> > > > > +       read_lock(&token.group->as_lock);
> > > >
> > > > I think we could optimize the lock here. E.g when nas is 1, we don'=
t
> > > > need any lock in fact.
> > > >
> > >
> > > Good point! Not taking the lock in that case for the next version, th=
anks!
> > >
> > > > > +       domain =3D token.group->as->domain;
> > > > >         vduse_domain_sync_single_for_device(domain, dma_addr, siz=
e, dir);
> > > > > +       read_unlock(&token.group->as_lock);
> > > > >  }
> > > > >
> > > > >  static void vduse_dev_sync_single_for_cpu(union virtio_map token=
,
> > > > >                                              dma_addr_t dma_addr,=
 size_t size,
> > > > >                                              enum dma_data_direct=
ion dir)
> > > > >  {
> > > > > -       struct vduse_dev *vdev;
> > > > >         struct vduse_iova_domain *domain;
> > > > >
> > > > >         if (!token.group)
> > > > >                 return;
> > > > >
> > > > > -       vdev =3D token.group->dev;
> > > > > -       domain =3D vdev->domain;
> > > > > -
> > > > > +       read_lock(&token.group->as_lock);
> > > > > +       domain =3D token.group->as->domain;
> > > > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, =
dir);
> > > > > +       read_unlock(&token.group->as_lock);
> > > > >  }
> > > > >
> > > > >  static dma_addr_t vduse_dev_map_page(union virtio_map token, str=
uct page *page,
> > > > > @@ -884,38 +936,38 @@ static dma_addr_t vduse_dev_map_page(union =
virtio_map token, struct page *page,
> > > > >                                      enum dma_data_direction dir,
> > > > >                                      unsigned long attrs)
> > > > >  {
> > > > > -       struct vduse_dev *vdev;
> > > > >         struct vduse_iova_domain *domain;
> > > > > +       dma_addr_t r;
> > > > >
> > > > >         if (!token.group)
> > > > >                 return DMA_MAPPING_ERROR;
> > > > >
> > > > > -       vdev =3D token.group->dev;
> > > > > -       domain =3D vdev->domain;
> > > > > +       read_lock(&token.group->as_lock);
> > > > > +       domain =3D token.group->as->domain;
> > > > > +       r =3D vduse_domain_map_page(domain, page, offset, size, d=
ir, attrs);
> > > > > +       read_unlock(&token.group->as_lock);
> > > > >
> > > > > -       return vduse_domain_map_page(domain, page, offset, size, =
dir, attrs);
> > > > > +       return r;
> > > > >  }
> > > > >
> > > > >  static void vduse_dev_unmap_page(union virtio_map token, dma_add=
r_t dma_addr,
> > > > >                                  size_t size, enum dma_data_direc=
tion dir,
> > > > >                                  unsigned long attrs)
> > > > >  {
> > > > > -       struct vduse_dev *vdev;
> > > > >         struct vduse_iova_domain *domain;
> > > > >
> > > > >         if (!token.group)
> > > > >                 return;
> > > > >
> > > > > -       vdev =3D token.group->dev;
> > > > > -       domain =3D vdev->domain;
> > > > > -
> > > > > -       return vduse_domain_unmap_page(domain, dma_addr, size, di=
r, attrs);
> > > > > +       read_lock(&token.group->as_lock);
> > > > > +       domain =3D token.group->as->domain;
> > > > > +       vduse_domain_unmap_page(domain, dma_addr, size, dir, attr=
s);
> > > > > +       read_unlock(&token.group->as_lock);
> > > > >  }
> > > > >
> > > > >  static void *vduse_dev_alloc_coherent(union virtio_map token, si=
ze_t size,
> > > > >                                       dma_addr_t *dma_addr, gfp_t=
 flag)
> > > > >  {
> > > > > -       struct vduse_dev *vdev;
> > > > >         struct vduse_iova_domain *domain;
> > > > >         unsigned long iova;
> > > > >         void *addr;
> > > > > @@ -928,18 +980,21 @@ static void *vduse_dev_alloc_coherent(union=
 virtio_map token, size_t size,
> > > > >         if (!addr)
> > > > >                 return NULL;
> > > > >
> > > > > -       vdev =3D token.group->dev;
> > > > > -       domain =3D vdev->domain;
> > > > > +       *dma_addr =3D (dma_addr_t)iova;
> > > >
> > > > Any reason we need to touch *dma_addr here? It might trigger UBSAN/=
KMSAN.
> > > >
> > >
> > > No, this is a leftover. I'm fixing it for the next version. Thanks!
> > >
> > > > > +       read_lock(&token.group->as_lock);
> > > > > +       domain =3D token.group->as->domain;
> > > > >         addr =3D vduse_domain_alloc_coherent(domain, size,
> > > > >                                            (dma_addr_t *)&iova, a=
ddr);
> > > > >         if (!addr)
> > > > >                 goto err;
> > > > >
> > > > >         *dma_addr =3D (dma_addr_t)iova;
> > > > > +       read_unlock(&token.group->as_lock);
> > > > >
> > > > >         return addr;
> > > > >
> > > > >  err:
> > > > > +       read_unlock(&token.group->as_lock);
> > > > >         free_pages_exact(addr, size);
> > > > >         return NULL;
> > > > >  }
> > > > > @@ -948,31 +1003,30 @@ static void vduse_dev_free_coherent(union =
virtio_map token, size_t size,
> > > > >                                     void *vaddr, dma_addr_t dma_a=
ddr,
> > > > >                                     unsigned long attrs)
> > > > >  {
> > > > > -       struct vduse_dev *vdev;
> > > > >         struct vduse_iova_domain *domain;
> > > > >
> > > > >         if (!token.group)
> > > > >                 return;
> > > > >
> > > > > -       vdev =3D token.group->dev;
> > > > > -       domain =3D vdev->domain;
> > > > > -
> > > > > +       read_lock(&token.group->as_lock);
> > > > > +       domain =3D token.group->as->domain;
> > > > >         vduse_domain_free_coherent(domain, size, dma_addr, attrs)=
;
> > > > > +       read_unlock(&token.group->as_lock);
> > > > >         free_pages_exact(vaddr, size);
> > > > >  }
> > > > >
> > > > >  static bool vduse_dev_need_sync(union virtio_map token, dma_addr=
_t dma_addr)
> > > > >  {
> > > > > -       struct vduse_dev *vdev;
> > > > > -       struct vduse_iova_domain *domain;
> > > > > +       size_t bounce_size;
> > > > >
> > > > >         if (!token.group)
> > > > >                 return false;
> > > > >
> > > > > -       vdev =3D token.group->dev;
> > > > > -       domain =3D vdev->domain;
> > > > > +       read_lock(&token.group->as_lock);
> > > > > +       bounce_size =3D token.group->as->domain->bounce_size;
> > > > > +       read_unlock(&token.group->as_lock);
> > > > >
> > > > > -       return dma_addr < domain->bounce_size;
> > > > > +       return dma_addr < bounce_size;
> > > > >  }
> > > > >
> > > > >  static int vduse_dev_mapping_error(union virtio_map token, dma_a=
ddr_t dma_addr)
> > > > > @@ -984,16 +1038,16 @@ static int vduse_dev_mapping_error(union v=
irtio_map token, dma_addr_t dma_addr)
> > > > >
> > > > >  static size_t vduse_dev_max_mapping_size(union virtio_map token)
> > > > >  {
> > > > > -       struct vduse_dev *vdev;
> > > > > -       struct vduse_iova_domain *domain;
> > > > > +       size_t bounce_size;
> > > > >
> > > > >         if (!token.group)
> > > > >                 return 0;
> > > > >
> > > > > -       vdev =3D token.group->dev;
> > > > > -       domain =3D vdev->domain;
> > > > > +       read_lock(&token.group->as_lock);
> > > > > +       bounce_size =3D token.group->as->domain->bounce_size;
> > > > > +       read_unlock(&token.group->as_lock);
> > > > >
> > > > > -       return domain->bounce_size;
> > > > > +       return bounce_size;
> > > > >  }
> > > > >
> > > > >  static const struct virtio_map_ops vduse_map_ops =3D {
> > > > > @@ -1133,39 +1187,40 @@ static int vduse_dev_queue_irq_work(struc=
t vduse_dev *dev,
> > > > >         return ret;
> > > > >  }
> > > > >
> > > > > -static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> > > > > +static int vduse_dev_dereg_umem(struct vduse_dev *dev, u32 asid,
> > > > >                                 u64 iova, u64 size)
> > > > >  {
> > > > >         int ret;
> > > > >
> > > > > -       mutex_lock(&dev->mem_lock);
> > > > > +       mutex_lock(&dev->as[asid].mem_lock);
> > > > >         ret =3D -ENOENT;
> > > > > -       if (!dev->umem)
> > > > > +       if (!dev->as[asid].umem)
> > > > >                 goto unlock;
> > > > >
> > > > >         ret =3D -EINVAL;
> > > > > -       if (!dev->domain)
> > > > > +       if (!dev->as[asid].domain)
> > > > >                 goto unlock;
> > > > >
> > > > > -       if (dev->umem->iova !=3D iova || size !=3D dev->domain->b=
ounce_size)
> > > > > +       if (dev->as[asid].umem->iova !=3D iova ||
> > > > > +           size !=3D dev->as[asid].domain->bounce_size)
> > > > >                 goto unlock;
> > > > >
> > > > > -       vduse_domain_remove_user_bounce_pages(dev->domain);
> > > > > -       unpin_user_pages_dirty_lock(dev->umem->pages,
> > > > > -                                   dev->umem->npages, true);
> > > > > -       atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm=
);
> > > > > -       mmdrop(dev->umem->mm);
> > > > > -       vfree(dev->umem->pages);
> > > > > -       kfree(dev->umem);
> > > > > -       dev->umem =3D NULL;
> > > > > +       vduse_domain_remove_user_bounce_pages(dev->as[asid].domai=
n);
> > > > > +       unpin_user_pages_dirty_lock(dev->as[asid].umem->pages,
> > > > > +                                   dev->as[asid].umem->npages, t=
rue);
> > > > > +       atomic64_sub(dev->as[asid].umem->npages, &dev->as[asid].u=
mem->mm->pinned_vm);
> > > > > +       mmdrop(dev->as[asid].umem->mm);
> > > > > +       vfree(dev->as[asid].umem->pages);
> > > > > +       kfree(dev->as[asid].umem);
> > > > > +       dev->as[asid].umem =3D NULL;
> > > > >         ret =3D 0;
> > > > >  unlock:
> > > > > -       mutex_unlock(&dev->mem_lock);
> > > > > +       mutex_unlock(&dev->as[asid].mem_lock);
> > > > >         return ret;
> > > > >  }
> > > > >
> > > > >  static int vduse_dev_reg_umem(struct vduse_dev *dev,
> > > > > -                             u64 iova, u64 uaddr, u64 size)
> > > > > +                             u32 asid, u64 iova, u64 uaddr, u64 =
size)
> > > > >  {
> > > > >         struct page **page_list =3D NULL;
> > > > >         struct vduse_umem *umem =3D NULL;
> > > > > @@ -1173,14 +1228,14 @@ static int vduse_dev_reg_umem(struct vdus=
e_dev *dev,
> > > > >         unsigned long npages, lock_limit;
> > > > >         int ret;
> > > > >
> > > > > -       if (!dev->domain || !dev->domain->bounce_map ||
> > > > > -           size !=3D dev->domain->bounce_size ||
> > > > > +       if (!dev->as[asid].domain || !dev->as[asid].domain->bounc=
e_map ||
> > > > > +           size !=3D dev->as[asid].domain->bounce_size ||
> > > > >             iova !=3D 0 || uaddr & ~PAGE_MASK)
> > > > >                 return -EINVAL;
> > > > >
> > > > > -       mutex_lock(&dev->mem_lock);
> > > > > +       mutex_lock(&dev->as[asid].mem_lock);
> > > > >         ret =3D -EEXIST;
> > > > > -       if (dev->umem)
> > > > > +       if (dev->as[asid].umem)
> > > > >                 goto unlock;
> > > > >
> > > > >         ret =3D -ENOMEM;
> > > > > @@ -1204,7 +1259,7 @@ static int vduse_dev_reg_umem(struct vduse_=
dev *dev,
> > > > >                 goto out;
> > > > >         }
> > > > >
> > > > > -       ret =3D vduse_domain_add_user_bounce_pages(dev->domain,
> > > > > +       ret =3D vduse_domain_add_user_bounce_pages(dev->as[asid].=
domain,
> > > > >                                                  page_list, pinne=
d);
> > > > >         if (ret)
> > > > >                 goto out;
> > > > > @@ -1217,7 +1272,7 @@ static int vduse_dev_reg_umem(struct vduse_=
dev *dev,
> > > > >         umem->mm =3D current->mm;
> > > > >         mmgrab(current->mm);
> > > > >
> > > > > -       dev->umem =3D umem;
> > > > > +       dev->as[asid].umem =3D umem;
> > > > >  out:
> > > > >         if (ret && pinned > 0)
> > > > >                 unpin_user_pages(page_list, pinned);
> > > > > @@ -1228,7 +1283,7 @@ static int vduse_dev_reg_umem(struct vduse_=
dev *dev,
> > > > >                 vfree(page_list);
> > > > >                 kfree(umem);
> > > > >         }
> > > > > -       mutex_unlock(&dev->mem_lock);
> > > > > +       mutex_unlock(&dev->as[asid].mem_lock);
> > > > >         return ret;
> > > > >  }
> > > > >
> > > > > @@ -1260,47 +1315,66 @@ static long vduse_dev_ioctl(struct file *=
file, unsigned int cmd,
> > > > >
> > > > >         switch (cmd) {
> > > > >         case VDUSE_IOTLB_GET_FD: {
> > > > > -               struct vduse_iotlb_entry entry;
> > > > > +               struct vduse_iotlb_entry_v2 entry;
> > > >
> > > > Nit: if we stick entry and do copy_from_user() twice it might save
> > > > lots of unnecessary changes.
> > > >
> > >
> > > I'm happy to move to something else but most of the changes happen
> > > because of s/entry/entry.v1/ . If we stick with just vduse_iotlb_entr=
y
> > > and a separate asid variable, we also need to duplicate the
> > > copy_from_user [2].
> > >
> > > > >                 struct vhost_iotlb_map *map;
> > > > >                 struct vdpa_map_file *map_file;
> > > > >                 struct file *f =3D NULL;
> > > > > +               u32 asid;
> > > > >
> > > > >                 ret =3D -EFAULT;
> > > > > -               if (copy_from_user(&entry, argp, sizeof(entry)))
> > > > > -                       break;
> > > > > +               if (dev->api_version >=3D VDUSE_API_VERSION_1) {
> > > > > +                       if (copy_from_user(&entry, argp, sizeof(e=
ntry)))
> > > > > +                               break;
> > > > > +               } else {
> > > > > +                       entry.asid =3D 0;
> > > > > +                       if (copy_from_user(&entry.v1, argp,
> > > > > +                                          sizeof(entry.v1)))
> > > > > +                               break;
> > > > > +               }
> > > > >
> > > > >                 ret =3D -EINVAL;
> > > > > -               if (entry.start > entry.last)
> > > > > +               if (entry.v1.start > entry.v1.last)
> > > > > +                       break;
> > > > > +
> > > > > +               if (entry.asid >=3D dev->nas)
> > > > >                         break;
> > > > >
> > > > >                 mutex_lock(&dev->domain_lock);
> > > > > -               if (!dev->domain) {
> > > > > +               asid =3D array_index_nospec(entry.asid, dev->nas)=
;
> > > > > +               if (!dev->as[asid].domain) {
> > > > >                         mutex_unlock(&dev->domain_lock);
> > > > >                         break;
> > > > >                 }
> > > > > -               spin_lock(&dev->domain->iotlb_lock);
> > > > > -               map =3D vhost_iotlb_itree_first(dev->domain->iotl=
b,
> > > > > -                                             entry.start, entry.=
last);
> > > > > +               spin_lock(&dev->as[asid].domain->iotlb_lock);
> > > > > +               map =3D vhost_iotlb_itree_first(dev->as[asid].dom=
ain->iotlb,
> > > > > +                                             entry.v1.start, ent=
ry.v1.last);
> > > > >                 if (map) {
> > > > >                         map_file =3D (struct vdpa_map_file *)map-=
>opaque;
> > > > >                         f =3D get_file(map_file->file);
> > > > > -                       entry.offset =3D map_file->offset;
> > > > > -                       entry.start =3D map->start;
> > > > > -                       entry.last =3D map->last;
> > > > > -                       entry.perm =3D map->perm;
> > > > > +                       entry.v1.offset =3D map_file->offset;
> > > > > +                       entry.v1.start =3D map->start;
> > > > > +                       entry.v1.last =3D map->last;
> > > > > +                       entry.v1.perm =3D map->perm;
> > > > >                 }
> > > > > -               spin_unlock(&dev->domain->iotlb_lock);
> > > > > +               spin_unlock(&dev->as[asid].domain->iotlb_lock);
> > > > >                 mutex_unlock(&dev->domain_lock);
> > > > >                 ret =3D -EINVAL;
> > > > >                 if (!f)
> > > > >                         break;
> > > > >
> > > > > -               ret =3D -EFAULT;
> > > > > -               if (copy_to_user(argp, &entry, sizeof(entry))) {
> > > > > +               if (dev->api_version >=3D VDUSE_API_VERSION_1)
> > > > > +                       ret =3D copy_to_user(argp, &entry,
> > > > > +                                          sizeof(entry));
> > > > > +               else
> > > > > +                       ret =3D copy_to_user(argp, &entry.v1,
> > > > > +                                          sizeof(entry.v1));
> > > > > +
> > > > > +               if (ret) {
> > > > > +                       ret =3D -EFAULT;
> > > > >                         fput(f);
> > > > >                         break;
> > > > >                 }
> > > > > -               ret =3D receive_fd(f, NULL, perm_to_file_flags(en=
try.perm));
> > > > > +               ret =3D receive_fd(f, NULL, perm_to_file_flags(en=
try.v1.perm));
> > > > >                 fput(f);
> > > > >                 break;
> > > > >         }
> > > > > @@ -1445,6 +1519,7 @@ static long vduse_dev_ioctl(struct file *fi=
le, unsigned int cmd,
> > > > >         }
> > > > >         case VDUSE_IOTLB_REG_UMEM: {
> > > > >                 struct vduse_iova_umem umem;
> > > > > +               u32 asid;
> > > > >
> > > > >                 ret =3D -EFAULT;
> > > > >                 if (copy_from_user(&umem, argp, sizeof(umem)))
> > > > > @@ -1452,17 +1527,21 @@ static long vduse_dev_ioctl(struct file *=
file, unsigned int cmd,
> > > > >
> > > > >                 ret =3D -EINVAL;
> > > > >                 if (!is_mem_zero((const char *)umem.reserved,
> > > > > -                                sizeof(umem.reserved)))
> > > > > +                                sizeof(umem.reserved)) ||
> > > > > +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> > > > > +                    umem.asid !=3D 0) || umem.asid >=3D dev->nas=
)
> > > > >                         break;
> > > > >
> > > > >                 mutex_lock(&dev->domain_lock);
> > > > > -               ret =3D vduse_dev_reg_umem(dev, umem.iova,
> > > > > +               asid =3D array_index_nospec(umem.asid, dev->nas);
> > > > > +               ret =3D vduse_dev_reg_umem(dev, asid, umem.iova,
> > > > >                                          umem.uaddr, umem.size);
> > > > >                 mutex_unlock(&dev->domain_lock);
> > > > >                 break;
> > > > >         }
> > > > >         case VDUSE_IOTLB_DEREG_UMEM: {
> > > > >                 struct vduse_iova_umem umem;
> > > > > +               u32 asid;
> > > > >
> > > > >                 ret =3D -EFAULT;
> > > > >                 if (copy_from_user(&umem, argp, sizeof(umem)))
> > > > > @@ -1470,10 +1549,15 @@ static long vduse_dev_ioctl(struct file *=
file, unsigned int cmd,
> > > > >
> > > > >                 ret =3D -EINVAL;
> > > > >                 if (!is_mem_zero((const char *)umem.reserved,
> > > > > -                                sizeof(umem.reserved)))
> > > > > +                                sizeof(umem.reserved)) ||
> > > > > +                   (dev->api_version < VDUSE_API_VERSION_1 &&
> > > > > +                    umem.asid !=3D 0) ||
> > > > > +                    umem.asid >=3D dev->nas)
> > > > >                         break;
> > > > > +
> > > > >                 mutex_lock(&dev->domain_lock);
> > > > > -               ret =3D vduse_dev_dereg_umem(dev, umem.iova,
> > > > > +               asid =3D array_index_nospec(umem.asid, dev->nas);
> > > > > +               ret =3D vduse_dev_dereg_umem(dev, asid, umem.iova=
,
> > > > >                                            umem.size);
> > > > >                 mutex_unlock(&dev->domain_lock);
> > > > >                 break;
> > > > > @@ -1481,6 +1565,7 @@ static long vduse_dev_ioctl(struct file *fi=
le, unsigned int cmd,
> > > > >         case VDUSE_IOTLB_GET_INFO: {
> > > >
> > > > Btw I see this:
> > > >
> > > >                 dev->vqs[index]->vq_group =3D config.group;
> > > >
> > > > In VDUSE_VQ_SETUP:
> > > >
> > > > I wonder what's the reason that it is not a part of CREATE_DEV? I
> > > > meant it might be racy if DMA happens between CREATE_DEV and
> > > > VDUSE_VQ_SETUP.
> > > >
> > >
> > > The reason the vq index -> vq group association cannot be part of
> > > device creation is that we need CVQ to be isolated for live migration=
,
> > > but the device doesn't know the CVQ index at the CREATE_DEV time, onl=
y
> > > after the feature negotiation happens [3].
> >
> > Exactly, the cvq index is changed.
> >
> > >
> > > [1] https://lore.kernel.org/lkml/CACGkMEvRQ86dYeY3Enqoj1vkSpefU3roq4X=
GS+y5B5kmsXEkYg@mail.gmail.com/
> > > [2] https://lore.kernel.org/lkml/CACGkMEtszQeZLTegxEbjODYxu-giTvURu=
=3DpKj4kYTHQYoKOzkQ@mail.gmail.com
> > > [3] https://lore.kernel.org/lkml/CAJaqyWcvHx7kwcTceN2jazT0nKNo1r5zdzq=
WHqpxdna-kCS1RA@mail.gmail.com
> >
> > I see, but a question. What happens if there's a DMA between
> > CREATE_DEV and VDUSE_VQ_SETUP. If we can find ways to forbid this (or
> > it has been forbidden), we are probably fine.
> >
>
> It's already forbidden by vdpa_dev_add:
>
> dev =3D vduse_find_dev(name);
> if (!dev || !vduse_dev_is_ready(dev)) {
>         mutex_unlock(&vduse_lock);
>         return -EINVAL;
> }
>
> where vduse_dev_is_ready():
> static bool vduse_dev_is_ready(struct vduse_dev *dev)
> {
>         int i;
>
>         for (i =3D 0; i < dev->vq_num; i++)
>                 if (!dev->vqs[i]->num_max)
>                         return false;
>
>         return true;
> }
>
> Since we set the vq group with the same ioctl than vq->num_max, we are
> safe here. I didn't catch it until now, so thanks for proposing to
> move the vq group parameter to that ioctl back then! :).

Great.

Thanks

