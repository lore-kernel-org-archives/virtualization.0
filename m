Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D62233E342
	for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766063469; cv=none; b=jQbJtIfXixY//8H8QXZJliZNNvv01OcsprrjnA8f1/XV5c+og8Jtiowm2P1sYAqiOR4GwtzYVshQTXgp7GYmQBrnf4JOzfNYJH02EHczHPFJOyr07spcU7hObZ3BZNPMu1dpAL6YYeiIKDlqb+xrbV1mSWMaxoYloFdVXTEro+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766063469; c=relaxed/simple;
	bh=ng2u1ZO3pWLlvqOU/5JMCQn/uYH1AHpsPgzIQzT1VyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tp+Zd8+EB5i0ajorAANGZiR3D6eow3jUmrmVx2AYFsDq+qgVsPfHfil7A5PRf7s47H+nyyx9whjB2jxYhj05jU69O84rYprPN5eSoWbPyUyqs52tZ8p3bXAsS9RMLA/UigY4uyzrDG/3woI9aKHzQq7UZdPVqsOj4Mqkpaoa6U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LjdtUnf+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjdtUnf+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766063464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwQiBndTeoQIlzkayoca5vxy8KIO2IIkcOVfoFGn9lU=;
	b=LjdtUnf+cWHM8+vqgTzLJNwHbuxqTJ6WN0WAoKaAA/0F3FI0R3y4v3UKIb6XjAXR2phoWE
	QyPRA4MjMmOtvs20F746Nli+KttAVHDPrM18tCcCZeFbqtcPTrmUnXlB12nrfvC1nG8a5A
	jV5BwvmFLSa3zj7E/hemml7srL5z77A=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-wS0Wa7DxNsCSxlPbwBufMg-1; Thu, 18 Dec 2025 08:11:00 -0500
X-MC-Unique: wS0Wa7DxNsCSxlPbwBufMg-1
X-Mimecast-MFC-AGG-ID: wS0Wa7DxNsCSxlPbwBufMg_1766063460
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-78c30699c19so5435277b3.1
        for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 05:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766063459; x=1766668259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SwQiBndTeoQIlzkayoca5vxy8KIO2IIkcOVfoFGn9lU=;
        b=Y52E4LNfaqMnHDyppn6MeWpuNeKf/TuTYNZ0kFcSB7UTQ4zpd93TrwGarU0/SqpfuG
         FgIy+U//w3RK/eUBpHxGC9G0gaTdSRPe1WfKqOeotTLYiz+vvrVzXiQEtQcbl9/+5uhi
         T4F5Z7DOmVKVQga41bQVOSiLiDNiDIBjx3BIvkKdj1QoSPC5H0HpZCHRBxvrTEo7ETnO
         GWOJuTGM/4nrBLRK0oE1hAJj8wBY8UgmD2LwqBMcdUkiVzVeFKLk1hqxQg8Tk2I65DTT
         wKdiyiv64qLg04iKTVBaNLQLsPHXabRn+y3IV9WR+qSJs+nZgHCzPx0W5/o2aCtuuaRu
         mxmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvhh7NEC1/VU1Q1fCBRPpk7cXnHxDS7RlUsgA16Pd0i4JpAYok3zH+wQDhJ01NfTQHzubgFXf3tmNn3Q5TJw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4Kv6GN6/YFIiOoYwfAG/GtHsFUNBPyS91ZRcq6bJn+k5+XdVz
	3Q+hA6azrFWFLgagi1Aol7HOdhwiGLUxhzxwPnbF+OMsC/r2ihLoSspSO/+KqhOD7cU7o5oHBQv
	MfmUOha11cipJcQE2aXhzFMtgM9H+K9XMRCLSQO/zwwQJ5b1D/2/9Td3+TmcsC6QACG/sCoPGei
	suqcC0BlekznhtHjjC9ObcAnoiAZMhTQMjJyIrgFQPl1E6KVIkMeQl2g==
X-Gm-Gg: AY/fxX7kRhOqp2+fi+ex798pjTIEeozQyPShJOzFkOf9A+ckZa/gz0bQsr1Fpg5fOgf
	ll01JkzQFDxBVZTwgFljNXE47zLgW5RFZDgS89Z1EmHxMwFPqXhNatunfT9M6VVWN19ZDTSEsWO
	SvBHrUK3spV4DQS2VnlII/cGQFCz/JEvPldic0y6MxmcoBRMwiu2TlW8hgdL9G+165S9g=
X-Received: by 2002:a05:690c:6089:b0:787:e3c0:f61f with SMTP id 00721157ae682-78e66e22f5amr374791767b3.57.1766063458948;
        Thu, 18 Dec 2025 05:10:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4Gy9JJvzevgwdayxNJNRADkZMRsiLoKTYpiReUWC7utlwk9gS6CjCtEJTmRP+E3X8M7E19I7qVBMF+we7ieY=
X-Received: by 2002:a05:690c:6089:b0:787:e3c0:f61f with SMTP id
 00721157ae682-78e66e22f5amr374791137b3.57.1766063458124; Thu, 18 Dec 2025
 05:10:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251217112414.2374672-1-eperezma@redhat.com> <20251217112414.2374672-8-eperezma@redhat.com>
 <CACGkMEs6-j8h7X8navZGC0wraan4WSLO3NMFx++Fe0uaExWZmA@mail.gmail.com>
In-Reply-To: <CACGkMEs6-j8h7X8navZGC0wraan4WSLO3NMFx++Fe0uaExWZmA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 18 Dec 2025 14:10:21 +0100
X-Gm-Features: AQt7F2rILaxjul5j2cNq-_RkT5Q4A5oYaF8K9RaT6L4WMpcZaTMhrbWJos9YTlA
Message-ID: <CAJaqyWccuSam1W6WpMF64QF1RmJtVMkfH_uvF56RKJzCzwer1w@mail.gmail.com>
Subject: Re: [PATCH v10 7/8] vduse: add vq group asid support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DJl72lIKTm_LlsncicIV7JpmcsS6eoig1xdRDo1HKDE_1766063460
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 7:45=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Dec 17, 2025 at 7:24=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> > group.  This enables mapping each group into a distinct memory space.
> >
> > The vq group to ASID association is protected by a rwlock now.  But the
> > mutex domain_lock keeps protecting the domains of all ASIDs, as some
> > operations like the one related with the bounce buffer size still
> > requires to lock all the ASIDs.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >
> > ---
> > Future improvements can include performance optimizations on top could
> > move to per-ASID locks, or hardening by tracking ASID or ASID hashes on
> > unused bits of the DMA address.
> >
> > Tested virtio_vdpa by adding manually two threads in vduse_set_status:
> > one of them modifies the vq group 0 ASID and the other one map and unma=
p
> > memory continuously.  After a while, the two threads stop and the usual
> > work continues.
> >
> > Tested with vhost_vdpa by migrating a VM while ping on OVS+VDUSE.  A fe=
w
> > workaround were needed in some parts:
> > * Do not enable CVQ before data vqs in QEMU, as VDUSE does not forward
> >   the enable message to the userland device.  This will be solved in th=
e
> >   future.
> > * Share the suspended state between all vhost devices in QEMU:
> >   https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg02947.htm=
l
> > * Implement a fake VDUSE suspend vdpa operation callback that always
> >   returns true in the kernel.  DPDK suspend the device at the first
> >   GET_VRING_BASE.
> > * Remove the CVQ blocker in ASID.
> >
> > ---
> > v10:
> > * Back to rwlock version so stronger locks are used.
> > * Take out allocations from rwlock.
> > * Forbid changing ASID of a vq group after DRIVER_OK (Jason)
> > * Remove bad fetching again of domain variable in
> >   vduse_dev_max_mapping_size (Yongji).
> > * Remove unused vdev definition in vdpa map_ops callbacks (kernel test
> >   robot).
> >
> > v9:
> > * Replace mutex with rwlock, as the vdpa map_ops can run from atomic
> >   context.
> >
> > v8:
> > * Revert the mutex to rwlock change, it needs proper profiling to
> >   justify it.
> >
> > v7:
> > * Take write lock in the error path (Jason).
> >
> > v6:
> > * Make vdpa_dev_add use gotos for error handling (MST).
> > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VERSION_1) ?=
/
> >   (MST).
> > * Fix struct name not matching in the doc.
> >
> > v5:
> > * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET_F=
D
> >   ioctl (Jason).
> > * Properly set domain bounce size to divide equally between nas (Jason)=
.
> > * Exclude "padding" member from the only >V1 members in
> >   vduse_dev_request.
> >
> > v4:
> > * Divide each domain bounce size between the device bounce size (Jason)=
.
> > * revert unneeded addr =3D NULL assignment (Jason)
> > * Change if (x && (y || z)) return to if (x) { if (y) return; if (z)
> >   return; } (Jason)
> > * Change a bad multiline comment, using @ caracter instead of * (Jason)=
.
> > * Consider config->nas =3D=3D 0 as a fail (Jason).
> >
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
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 366 +++++++++++++++++++----------
> >  include/uapi/linux/vduse.h         |  53 ++++-
> >  2 files changed, 295 insertions(+), 124 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 767abcb7e375..786ab2378825 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -41,6 +41,7 @@
> >
> >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > +#define VDUSE_DEV_MAX_AS 0xffff
> >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > @@ -86,7 +87,15 @@ struct vduse_umem {
> >         struct mm_struct *mm;
> >  };
> >
> > +struct vduse_as {
> > +       struct vduse_iova_domain *domain;
> > +       struct vduse_umem *umem;
> > +       struct mutex mem_lock;
>
> Not related to this patch. But If I was not wrong we have 1:1 mapping
> between domain and as. If this is true, can we use bounce_lock instead
> of a new mem_lock? Since I see mem_lock is only used for synchronizing
> umem reg/degreg which has been synchronized with domain rwlock.
>

I think you're right, but they work at different levels at the moment.
The mem_lock is at vduse_dev and also protect the umem pointer, and
bounce_lock is at iova_domain.c .

Maybe the right thing to do is to move umem in iova_domain. Yongji
Xie, what do you think?

> > +};
> > +
> >  struct vduse_vq_group {
> > +       rwlock_t as_lock;
> > +       struct vduse_as *as; /* Protected by as_lock */
> >         struct vduse_dev *dev;
> >  };
> >
> > @@ -94,7 +103,7 @@ struct vduse_dev {
> >         struct vduse_vdpa *vdev;
> >         struct device *dev;
> >         struct vduse_virtqueue **vqs;
> > -       struct vduse_iova_domain *domain;
> > +       struct vduse_as *as;
> >         char *name;
> >         struct mutex lock;
> >         spinlock_t msg_lock;
> > @@ -122,9 +131,8 @@ struct vduse_dev {
> >         u32 vq_num;
> >         u32 vq_align;
> >         u32 ngroups;
> > -       struct vduse_umem *umem;
> > +       u32 nas;
> >         struct vduse_vq_group *groups;
> > -       struct mutex mem_lock;
> >         unsigned int bounce_size;
> >         struct mutex domain_lock;
> >  };
> > @@ -314,7 +322,7 @@ static int vduse_dev_set_status(struct vduse_dev *d=
ev, u8 status)
> >         return vduse_dev_msg_sync(dev, &msg);
> >  }
> >
> > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
> >                                   u64 start, u64 last)
> >  {
> >         struct vduse_dev_msg msg =3D { 0 };
> > @@ -323,8 +331,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev=
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
> > @@ -436,14 +450,29 @@ static __poll_t vduse_dev_poll(struct file *file,=
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
> > +       write_lock(&dev->groups[group].as_lock);
> > +       dev->groups[group].as =3D &dev->as[asid];
> > +       write_unlock(&dev->groups[group].as_lock);
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
>
> Btw, I see this:
>
> void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain)
> {
>         if (!domain->bounce_map)
>                 return;
>
>         spin_lock(&domain->iotlb_lock);
>         if (!domain->bounce_map)
>                 goto unlock;
>
>
> The counbe_map is checked twice, let's fix that.
>

Double checked locking to avoid taking the lock? I don't think it is
worth it to keep it as it is not in the hot path anyway. But that
would also be another patch independent of this series, isn't it?

> > +       }
> > +
> > +       for (i =3D 0; i < dev->ngroups; i++)
> > +               vduse_set_group_asid_nomsg(dev, i, 0);
>
> Note that this function still does:
>
>                 vq->vq_group =3D 0;
>
> Which is wrong.
>

Right, removing it for the next version. Thanks for the catch!

> >
> >         down_write(&dev->rwsem);
> >
> > @@ -623,6 +652,30 @@ static union virtio_map vduse_get_vq_map(struct vd=
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
> > +           group >=3D dev->ngroups || asid >=3D dev->nas ||
> > +           dev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> > +               return -EINVAL;
>
> If we forbid setting group asid for !DRIVER_OK, why do we still need a
> rwlock?

virtio_map_ops->alloc is still called before DRIVER_OK to allocate the
vrings in the bounce buffer, for example. If you're ok with that I'm
ok with removing the lock, as all the calls are issued by the driver
setup process anyway. Or just to keep it for alloc?

Anyway, I think I misunderstood your comment from [1] then.

> All we need to do is to synchronize set_group_asid() with
> set_status()/reset()?
>

That's also a good one. There is no synchronization if one thread call
reset and then the device is set up from another thread. As all this
situation is still hypothetical because virtio_vdpa does not support
set_group_asid, and vhost one is already protected by vhost lock, do
we need it?

> Or if you want to synchronize map ops with set_status() that looks
> like an independent thing (hardening).
>
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
>
> I'm not sure this has been discussed before, but I think it would be
> better to introduce a new ioctl to get group -> as mapping. This helps
> to avoid vduse_dev_msg_sync() as much as possible. And it doesn't
> require the userspace to poll vduse fd before DRIVER_OK.
>

I'm fine with that, but how do we communicate that they have changed?
Or how to communicate to the driver that the device does not accept
the assignment of the ASID to the group?

> > +       return 0;
> > +}
> > +
> >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> >                                 struct vdpa_vq_state *state)
> >  {
> > @@ -794,13 +847,13 @@ static int vduse_vdpa_set_map(struct vdpa_device =
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
> > @@ -843,6 +896,7 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
> >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> >         .reset                  =3D vduse_vdpa_reset,
> >         .set_map                =3D vduse_vdpa_set_map,
> > +       .set_group_asid         =3D vduse_set_group_asid,
> >         .get_vq_map             =3D vduse_get_vq_map,
> >         .free                   =3D vduse_vdpa_free,
> >  };
> > @@ -851,32 +905,30 @@ static void vduse_dev_sync_single_for_device(unio=
n virtio_map token,
> >                                              dma_addr_t dma_addr, size_=
t size,
> >                                              enum dma_data_direction di=
r)
> >  {
> > -       struct vduse_dev *vdev;
> >         struct vduse_iova_domain *domain;
> >
> >         if (!token.group)
> >                 return;
> >
> > -       vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > -
> > +       read_lock(&token.group->as_lock);
>
> I think we could optimize the lock here. E.g when nas is 1, we don't
> need any lock in fact.
>

Good point! Not taking the lock in that case for the next version, thanks!

> > +       domain =3D token.group->as->domain;
> >         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir=
);
> > +       read_unlock(&token.group->as_lock);
> >  }
> >
> >  static void vduse_dev_sync_single_for_cpu(union virtio_map token,
> >                                              dma_addr_t dma_addr, size_=
t size,
> >                                              enum dma_data_direction di=
r)
> >  {
> > -       struct vduse_dev *vdev;
> >         struct vduse_iova_domain *domain;
> >
> >         if (!token.group)
> >                 return;
> >
> > -       vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > -
> > +       read_lock(&token.group->as_lock);
> > +       domain =3D token.group->as->domain;
> >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
> > +       read_unlock(&token.group->as_lock);
> >  }
> >
> >  static dma_addr_t vduse_dev_map_page(union virtio_map token, struct pa=
ge *page,
> > @@ -884,38 +936,38 @@ static dma_addr_t vduse_dev_map_page(union virtio=
_map token, struct page *page,
> >                                      enum dma_data_direction dir,
> >                                      unsigned long attrs)
> >  {
> > -       struct vduse_dev *vdev;
> >         struct vduse_iova_domain *domain;
> > +       dma_addr_t r;
> >
> >         if (!token.group)
> >                 return DMA_MAPPING_ERROR;
> >
> > -       vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > +       read_lock(&token.group->as_lock);
> > +       domain =3D token.group->as->domain;
> > +       r =3D vduse_domain_map_page(domain, page, offset, size, dir, at=
trs);
> > +       read_unlock(&token.group->as_lock);
> >
> > -       return vduse_domain_map_page(domain, page, offset, size, dir, a=
ttrs);
> > +       return r;
> >  }
> >
> >  static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dm=
a_addr,
> >                                  size_t size, enum dma_data_direction d=
ir,
> >                                  unsigned long attrs)
> >  {
> > -       struct vduse_dev *vdev;
> >         struct vduse_iova_domain *domain;
> >
> >         if (!token.group)
> >                 return;
> >
> > -       vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > -
> > -       return vduse_domain_unmap_page(domain, dma_addr, size, dir, att=
rs);
> > +       read_lock(&token.group->as_lock);
> > +       domain =3D token.group->as->domain;
> > +       vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
> > +       read_unlock(&token.group->as_lock);
> >  }
> >
> >  static void *vduse_dev_alloc_coherent(union virtio_map token, size_t s=
ize,
> >                                       dma_addr_t *dma_addr, gfp_t flag)
> >  {
> > -       struct vduse_dev *vdev;
> >         struct vduse_iova_domain *domain;
> >         unsigned long iova;
> >         void *addr;
> > @@ -928,18 +980,21 @@ static void *vduse_dev_alloc_coherent(union virti=
o_map token, size_t size,
> >         if (!addr)
> >                 return NULL;
> >
> > -       vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > +       *dma_addr =3D (dma_addr_t)iova;
>
> Any reason we need to touch *dma_addr here? It might trigger UBSAN/KMSAN.
>

No, this is a leftover. I'm fixing it for the next version. Thanks!

> > +       read_lock(&token.group->as_lock);
> > +       domain =3D token.group->as->domain;
> >         addr =3D vduse_domain_alloc_coherent(domain, size,
> >                                            (dma_addr_t *)&iova, addr);
> >         if (!addr)
> >                 goto err;
> >
> >         *dma_addr =3D (dma_addr_t)iova;
> > +       read_unlock(&token.group->as_lock);
> >
> >         return addr;
> >
> >  err:
> > +       read_unlock(&token.group->as_lock);
> >         free_pages_exact(addr, size);
> >         return NULL;
> >  }
> > @@ -948,31 +1003,30 @@ static void vduse_dev_free_coherent(union virtio=
_map token, size_t size,
> >                                     void *vaddr, dma_addr_t dma_addr,
> >                                     unsigned long attrs)
> >  {
> > -       struct vduse_dev *vdev;
> >         struct vduse_iova_domain *domain;
> >
> >         if (!token.group)
> >                 return;
> >
> > -       vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > -
> > +       read_lock(&token.group->as_lock);
> > +       domain =3D token.group->as->domain;
> >         vduse_domain_free_coherent(domain, size, dma_addr, attrs);
> > +       read_unlock(&token.group->as_lock);
> >         free_pages_exact(vaddr, size);
> >  }
> >
> >  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma=
_addr)
> >  {
> > -       struct vduse_dev *vdev;
> > -       struct vduse_iova_domain *domain;
> > +       size_t bounce_size;
> >
> >         if (!token.group)
> >                 return false;
> >
> > -       vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > +       read_lock(&token.group->as_lock);
> > +       bounce_size =3D token.group->as->domain->bounce_size;
> > +       read_unlock(&token.group->as_lock);
> >
> > -       return dma_addr < domain->bounce_size;
> > +       return dma_addr < bounce_size;
> >  }
> >
> >  static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t =
dma_addr)
> > @@ -984,16 +1038,16 @@ static int vduse_dev_mapping_error(union virtio_=
map token, dma_addr_t dma_addr)
> >
> >  static size_t vduse_dev_max_mapping_size(union virtio_map token)
> >  {
> > -       struct vduse_dev *vdev;
> > -       struct vduse_iova_domain *domain;
> > +       size_t bounce_size;
> >
> >         if (!token.group)
> >                 return 0;
> >
> > -       vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > +       read_lock(&token.group->as_lock);
> > +       bounce_size =3D token.group->as->domain->bounce_size;
> > +       read_unlock(&token.group->as_lock);
> >
> > -       return domain->bounce_size;
> > +       return bounce_size;
> >  }
> >
> >  static const struct virtio_map_ops vduse_map_ops =3D {
> > @@ -1133,39 +1187,40 @@ static int vduse_dev_queue_irq_work(struct vdus=
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
> > @@ -1173,14 +1228,14 @@ static int vduse_dev_reg_umem(struct vduse_dev =
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
> > @@ -1204,7 +1259,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
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
> > @@ -1217,7 +1272,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
ev,
> >         umem->mm =3D current->mm;
> >         mmgrab(current->mm);
> >
> > -       dev->umem =3D umem;
> > +       dev->as[asid].umem =3D umem;
> >  out:
> >         if (ret && pinned > 0)
> >                 unpin_user_pages(page_list, pinned);
> > @@ -1228,7 +1283,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
ev,
> >                 vfree(page_list);
> >                 kfree(umem);
> >         }
> > -       mutex_unlock(&dev->mem_lock);
> > +       mutex_unlock(&dev->as[asid].mem_lock);
> >         return ret;
> >  }
> >
> > @@ -1260,47 +1315,66 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >
> >         switch (cmd) {
> >         case VDUSE_IOTLB_GET_FD: {
> > -               struct vduse_iotlb_entry entry;
> > +               struct vduse_iotlb_entry_v2 entry;
>
> Nit: if we stick entry and do copy_from_user() twice it might save
> lots of unnecessary changes.
>

I'm happy to move to something else but most of the changes happen
because of s/entry/entry.v1/ . If we stick with just vduse_iotlb_entry
and a separate asid variable, we also need to duplicate the
copy_from_user [2].

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
> >                 mutex_lock(&dev->domain_lock);
> > -               if (!dev->domain) {
> > +               asid =3D array_index_nospec(entry.asid, dev->nas);
> > +               if (!dev->as[asid].domain) {
> >                         mutex_unlock(&dev->domain_lock);
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
> >                 mutex_unlock(&dev->domain_lock);
> >                 ret =3D -EINVAL;
> >                 if (!f)
> >                         break;
> >
> > -               ret =3D -EFAULT;
> > -               if (copy_to_user(argp, &entry, sizeof(entry))) {
> > +               if (dev->api_version >=3D VDUSE_API_VERSION_1)
> > +                       ret =3D copy_to_user(argp, &entry,
> > +                                          sizeof(entry));
> > +               else
> > +                       ret =3D copy_to_user(argp, &entry.v1,
> > +                                          sizeof(entry.v1));
> > +
> > +               if (ret) {
> > +                       ret =3D -EFAULT;
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
> > @@ -1445,6 +1519,7 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
> >         }
> >         case VDUSE_IOTLB_REG_UMEM: {
> >                 struct vduse_iova_umem umem;
> > +               u32 asid;
> >
> >                 ret =3D -EFAULT;
> >                 if (copy_from_user(&umem, argp, sizeof(umem)))
> > @@ -1452,17 +1527,21 @@ static long vduse_dev_ioctl(struct file *file, =
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
> >                 mutex_lock(&dev->domain_lock);
> > -               ret =3D vduse_dev_reg_umem(dev, umem.iova,
> > +               asid =3D array_index_nospec(umem.asid, dev->nas);
> > +               ret =3D vduse_dev_reg_umem(dev, asid, umem.iova,
> >                                          umem.uaddr, umem.size);
> >                 mutex_unlock(&dev->domain_lock);
> >                 break;
> >         }
> >         case VDUSE_IOTLB_DEREG_UMEM: {
> >                 struct vduse_iova_umem umem;
> > +               u32 asid;
> >
> >                 ret =3D -EFAULT;
> >                 if (copy_from_user(&umem, argp, sizeof(umem)))
> > @@ -1470,10 +1549,15 @@ static long vduse_dev_ioctl(struct file *file, =
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
> >                 mutex_lock(&dev->domain_lock);
> > -               ret =3D vduse_dev_dereg_umem(dev, umem.iova,
> > +               asid =3D array_index_nospec(umem.asid, dev->nas);
> > +               ret =3D vduse_dev_dereg_umem(dev, asid, umem.iova,
> >                                            umem.size);
> >                 mutex_unlock(&dev->domain_lock);
> >                 break;
> > @@ -1481,6 +1565,7 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
> >         case VDUSE_IOTLB_GET_INFO: {
>
> Btw I see this:
>
>                 dev->vqs[index]->vq_group =3D config.group;
>
> In VDUSE_VQ_SETUP:
>
> I wonder what's the reason that it is not a part of CREATE_DEV? I
> meant it might be racy if DMA happens between CREATE_DEV and
> VDUSE_VQ_SETUP.
>

The reason the vq index -> vq group association cannot be part of
device creation is that we need CVQ to be isolated for live migration,
but the device doesn't know the CVQ index at the CREATE_DEV time, only
after the feature negotiation happens [3].

[1] https://lore.kernel.org/lkml/CACGkMEvRQ86dYeY3Enqoj1vkSpefU3roq4XGS+y5B=
5kmsXEkYg@mail.gmail.com/
[2] https://lore.kernel.org/lkml/CACGkMEtszQeZLTegxEbjODYxu-giTvURu=3DpKj4k=
YTHQYoKOzkQ@mail.gmail.com
[3] https://lore.kernel.org/lkml/CAJaqyWcvHx7kwcTceN2jazT0nKNo1r5zdzqWHqpxd=
na-kCS1RA@mail.gmail.com

> >                 struct vduse_iova_info info;
> >                 struct vhost_iotlb_map *map;
> > +               u32 asid;
> >
> >                 ret =3D -EFAULT;
> >                 if (copy_from_user(&info, argp, sizeof(info)))
> > @@ -1494,23 +1579,31 @@ static long vduse_dev_ioctl(struct file *file, =
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
> >                 mutex_lock(&dev->domain_lock);
> > -               if (!dev->domain) {
> > +               asid =3D array_index_nospec(info.asid, dev->nas);
> > +               if (!dev->as[asid].domain) {
> >                         mutex_unlock(&dev->domain_lock);
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
> >                 mutex_unlock(&dev->domain_lock);
> >                 if (!map)
> >                         break;
> > @@ -1535,8 +1628,10 @@ static int vduse_dev_release(struct inode *inode=
, struct file *file)
> >         struct vduse_dev *dev =3D file->private_data;
> >
> >         mutex_lock(&dev->domain_lock);
> > -       if (dev->domain)
> > -               vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
> > +       for (int i =3D 0; i < dev->nas; i++)
> > +               if (dev->as[i].domain)
> > +                       vduse_dev_dereg_umem(dev, i, 0,
> > +                                            dev->as[i].domain->bounce_=
size);
> >         mutex_unlock(&dev->domain_lock);
> >         spin_lock(&dev->msg_lock);
> >         /* Make sure the inflight messages can processed after reconnce=
ction */
> > @@ -1755,7 +1850,6 @@ static struct vduse_dev *vduse_dev_create(void)
> >                 return NULL;
> >
> >         mutex_init(&dev->lock);
> > -       mutex_init(&dev->mem_lock);
> >         mutex_init(&dev->domain_lock);
> >         spin_lock_init(&dev->msg_lock);
> >         INIT_LIST_HEAD(&dev->send_list);
> > @@ -1806,8 +1900,11 @@ static int vduse_destroy_dev(char *name)
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
> > @@ -1854,12 +1951,17 @@ static bool vduse_validate_config(struct vduse_=
dev_config *config,
> >                          sizeof(config->reserved)))
> >                 return false;
> >
> > -       if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> > +       if (api_version < VDUSE_API_VERSION_1 &&
> > +           (config->ngroups || config->nas))
> >                 return false;
> >
> > -       if (api_version >=3D VDUSE_API_VERSION_1 &&
> > -           (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GROUPS=
))
> > -               return false;
> > +       if (api_version >=3D VDUSE_API_VERSION_1) {
> > +               if (!config->ngroups || config->ngroups > VDUSE_DEV_MAX=
_GROUPS)
> > +                       return false;
> > +
> > +               if (!config->nas || config->nas > VDUSE_DEV_MAX_AS)
> > +                       return false;
> > +       }
> >
> >         if (config->vq_align > PAGE_SIZE)
> >                 return false;
> > @@ -1924,7 +2026,8 @@ static ssize_t bounce_size_store(struct device *d=
evice,
> >
> >         ret =3D -EPERM;
> >         mutex_lock(&dev->domain_lock);
> > -       if (dev->domain)
> > +       /* Assuming that if the first domain is allocated, all are allo=
cated */
> > +       if (dev->as[0].domain)
> >                 goto unlock;
>
> Not for this patch but I don't understand why we need to check dev->domai=
n here.
>

I guess you need to know the bounce size before you allocate the
domain. To make shrink logic for it seems not to be worth it, but
maybe I'm missing something.

> >
> >         ret =3D kstrtouint(buf, 10, &bounce_size);
> > @@ -1983,8 +2086,17 @@ static int vduse_create_dev(struct vduse_dev_con=
fig *config,
> >                               GFP_KERNEL);
> >         if (!dev->groups)
> >                 goto err_vq_groups;
> > -       for (u32 i =3D 0; i < dev->ngroups; ++i)
> > +       for (u32 i =3D 0; i < dev->ngroups; ++i) {
> >                 dev->groups[i].dev =3D dev;
> > +               rwlock_init(&dev->groups[i].as_lock);
> > +       }
> > +
> > +       dev->nas =3D (dev->api_version < VDUSE_API_VERSION_1) ? 1 : con=
fig->nas;
> > +       dev->as =3D kcalloc(dev->nas, sizeof(dev->as[0]), GFP_KERNEL);
> > +       if (!dev->as)
> > +               goto err_as;
> > +       for (int i =3D 0; i < dev->nas; i++)
> > +               mutex_init(&dev->as[i].mem_lock);
> >
> >         dev->name =3D kstrdup(config->name, GFP_KERNEL);
> >         if (!dev->name)
> > @@ -2022,6 +2134,8 @@ static int vduse_create_dev(struct vduse_dev_conf=
ig *config,
> >  err_idr:
> >         kfree(dev->name);
> >  err_str:
> > +       kfree(dev->as);
> > +err_as:
> >         kfree(dev->groups);
> >  err_vq_groups:
> >         vduse_dev_destroy(dev);
> > @@ -2147,7 +2261,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *=
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
> > @@ -2162,7 +2276,8 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
> >                         const struct vdpa_dev_set_config *config)
> >  {
> >         struct vduse_dev *dev;
> > -       int ret;
> > +       size_t domain_bounce_size;
> > +       int ret, i;
> >
> >         mutex_lock(&vduse_lock);
> >         dev =3D vduse_find_dev(name);
> > @@ -2176,29 +2291,38 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *m=
dev, const char *name,
> >                 return ret;
> >
> >         mutex_lock(&dev->domain_lock);
> > -       if (!dev->domain)
> > -               dev->domain =3D vduse_domain_create(VDUSE_IOVA_SIZE - 1=
,
> > -                                                 dev->bounce_size);
> > -       mutex_unlock(&dev->domain_lock);
> > -       if (!dev->domain) {
> > -               ret =3D -ENOMEM;
> > -               goto domain_err;
> > +       ret =3D 0;
> > +
> > +       domain_bounce_size =3D dev->bounce_size / dev->nas;
> > +       for (i =3D 0; i < dev->nas; ++i) {
> > +               dev->as[i].domain =3D vduse_domain_create(VDUSE_IOVA_SI=
ZE - 1,
> > +                                                       domain_bounce_s=
ize);
> > +               if (!dev->as[i].domain) {
> > +                       ret =3D -ENOMEM;
> > +                       goto err;
> > +               }
> >         }
> >
> > +       mutex_unlock(&dev->domain_lock);
> > +
> >         ret =3D _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
> > -       if (ret) {
> > -               goto register_err;
> > -       }
> > +       if (ret)
> > +               goto err_register;
> >
> >         return 0;
> >
> > -register_err:
> > +err_register:
> >         mutex_lock(&dev->domain_lock);
> > -       vduse_domain_destroy(dev->domain);
> > -       dev->domain =3D NULL;
> > +
> > +err:
> > +       for (int j =3D 0; j < i; j++) {
> > +               if (dev->as[j].domain) {
> > +                       vduse_domain_destroy(dev->as[j].domain);
> > +                       dev->as[j].domain =3D NULL;
> > +               }
> > +       }
> >         mutex_unlock(&dev->domain_lock);
> >
> > -domain_err:
> >         put_device(&dev->vdev->vdpa.dev);
> >
> >         return ret;
> > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > index a3d51cf6df3a..da2c5e47990e 100644
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
> > + * struct vduse_vq_group_asid - virtqueue group ASID
> > + * @group: Index of the virtqueue group
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
> > @@ -334,6 +376,11 @@ struct vduse_dev_request {
> >                 struct vduse_vq_state vq_state;
> >                 struct vduse_dev_status s;
> >                 struct vduse_iova_range iova;
> > +               /* Following members but padding exist only if vduse ap=
i
> > +                * version >=3D 1
> > +                */;
> > +               struct vduse_iova_range_v2 iova_v2;
> > +               struct vduse_vq_group_asid vq_group_asid;
> >                 __u32 padding[32];
> >         };
> >  };
> > --
> > 2.52.0
> >
>
> Thanks
>

