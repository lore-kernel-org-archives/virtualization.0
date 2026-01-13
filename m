Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311B3283FC3
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315147; cv=none; b=ba7gU9H4YQJPFpUcOfhZD/VoU3TXqnqcgt3Tr5POlvYK+MIn9GVWjJFvnxo+2zRE8/uXZIYz72Aqh6M3F8w3c78ZjRDNcetDHMlbO3J3BB8TKpVwa4NYxSTXY5kTVtYSHDbdLzQvjFn13IHfrmgXsTum18y4KFMeZ0xj5ezqRBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315147; c=relaxed/simple;
	bh=ix7O5ey/ywECTsinvNRt75QKclFZjsFP8O98hrtsydA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beOY6UWs+yAapvgnPS2NOi0co+1YbiNlatbrAWCvVwSk0rieqnpa9sDfj3mza7r9BBt14ypfF+xW2WLwQ1HDfT51ybjbAXCqtQrl6muMRfeKjszBymsgABlAKo5ZTDcQ/jAmQIrk2zl9cBuAbZIHS6oQkRuj6M03j1bWez3cqKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOTTC0Tn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOTTC0Tn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768315143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pfx2rcvNFfDwsjqio+ROXGK5XGhigzdMVIhLhCwrkrA=;
	b=EOTTC0Tn+TCJKzDeflKPKukVCEwfYs8ah1ZPzu3XIfb/HB23PHgiUJf3LDosfmTbzVrACx
	j3Nvjg88yQp5nP1auC6rDTbdYCteWzdBEbtnGQkGkzSsi1Q5xloeexwcIvzHpxYzfRoiFz
	8chaRMSU7dl3bIxfoagGRZU3eKw7Tx8=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-oEzuU40SPWGNJqM7pdX5oA-1; Tue, 13 Jan 2026 09:39:01 -0500
X-MC-Unique: oEzuU40SPWGNJqM7pdX5oA-1
X-Mimecast-MFC-AGG-ID: oEzuU40SPWGNJqM7pdX5oA_1768315141
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-645592c1b59so11691487d50.0
        for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 06:39:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768315141; x=1768919941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pfx2rcvNFfDwsjqio+ROXGK5XGhigzdMVIhLhCwrkrA=;
        b=gcRNND2pKcrxwzDKngIwmaDiF8dDUS47X57wue8bgS67lh5hBOwue8PY5nwT0bbt4J
         uya/PAx2xPncux5gWWpunYYWU/EpeCmQNzkhQsep2R1huqPmNQnq41y8YvSw4zScv4rZ
         nNFHI7WaLNpfQShOpaAN9HkF7OJsDgAghezRPLioKOvoOAWIPkoPhrGLzVUehImt1TUg
         2b6TxAvvN34ZuGZpSodymsLoo2FZVrpxdVfYabUDk7BbIJC1dRSGf/f/HG1oHn2pAZJq
         Wz6jsWAzPv1MoBibqLV7UqIlTgNbNBf7HJxW0JD2CpfjcEc2UO3+Mt6GIpELSpczsLy5
         qZmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGlUgS3BdYXiBiNjJcyUrAaByAVCKGoON36ZHITksLo/l7yOT4TVhMKckrpIPWd19B2UgH4FQ65sR/5tfCcw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzr7YCrYdjh20JVLoD13b3e65gxD84L5AwaGhGORjHpqpv1GRX8
	EcpnH2IZ7cSx2hieR3Eq0mpEtSIzUiriQUsKLfs7JyO3KonRCYjrCbi/4G6IcsdN65FgOjDYQKT
	dA0WKepukK+SrJmTnkcdfeZy8W0pw5JbrEj4J65hadRs8cqxxoqTjKXXEqCnkCkONj9hAig8H96
	kISBy5LtOfFaWDfrmhULvBQhmb2JFIMJDB8FXIhAtMXQ4=
X-Gm-Gg: AY/fxX7KqEbKTy5EbOw0vW3vcdbbwPvKL58N98tsLOoVbyHQp+cWgZ5P9MlAaV34VVk
	Y5GfiBWvG6KAEOdxZahogbJdIOis9c42PpJuzXWiKhLGa5saEWLw/x9CUBhztTln9Uxsc/NQ1Pm
	Kq4IH6U9ppbZX2SlqoLJ2plCeZmkKQUVfjYpgTRZPycUFBd6DFUjCjyVv/ihBza72e9w==
X-Received: by 2002:a05:690e:11cb:b0:63d:5d72:1918 with SMTP id 956f58d0204a3-64716c4f1camr18910868d50.63.1768315140811;
        Tue, 13 Jan 2026 06:39:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4KdyzMwELtXXnwuA+0VsTn48BrCNm+iurUtbffvvd7fZ0TpRdjMY4x0ydDB26sfSVRIAVbaFgaR8sjiAptK0=
X-Received: by 2002:a05:690e:11cb:b0:63d:5d72:1918 with SMTP id
 956f58d0204a3-64716c4f1camr18910818d50.63.1768315139915; Tue, 13 Jan 2026
 06:38:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109152430.512923-1-eperezma@redhat.com> <20260109152430.512923-12-eperezma@redhat.com>
 <CACGkMEsg+LPe7K7m85+CffGHtJqMhdMSu7GcegbKvTq6SCFBZQ@mail.gmail.com>
In-Reply-To: <CACGkMEsg+LPe7K7m85+CffGHtJqMhdMSu7GcegbKvTq6SCFBZQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 13 Jan 2026 15:38:23 +0100
X-Gm-Features: AZwV_QhFeZRqaJJlb5ZbEl8fwPNB5fBGVUi4O0sM71n_PJGFZS7Z15zGWwcelOs
Message-ID: <CAJaqyWebFjFcrg_us+r5i0-04r_OCu-L0LaEROo0bpX6wMhn5w@mail.gmail.com>
Subject: Re: [PATCH v11 11/12] vduse: add vq group asid support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, Maxime Coquelin <mcoqueli@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pfu9gTHMjvveK9CCZp3pHCD2bScLw8s-51SOHOmXy_Q_1768315141
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 7:23=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Jan 9, 2026 at 11:25=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
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
> > Future improvements can include performance optimizations on top like
> > ore to RCU or thread synchronized atomics, or hardening by tracking ASI=
D
> > or ASID hashes on unused bits of the DMA address.
> >
> > Tested virtio_vdpa by adding manually two threads in vduse_set_status:
> > one of them modifies the vq group 0 ASID and the other one map and unma=
p
> > memory continuously.  After a while, the two threads stop and the usual
> > work continues.  Test with version 0, version 1 with the old ioctl, and
> > verion 1 with the new ioctl.
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
> > The driver vhost_vdpa was also tested with version 0, version 1 with th=
e
> > old ioctl, version 1 with the new ioctl but only one ASID, and version =
1
> > with many ASID.
>
> I think we'd better update the Documentation/userspace-api/vduse.rst
> for the new uAPI.
>

Good point! I'll do it for the next version, thanks!

> >
> > ---
> > v11:
> > * Remove duplicated free_pages_exact in vduse_domain_free_coherent
> >   (Jason).
> > * Do not take the vq groups lock if nas =3D=3D 1.
> > * Do not reset the vq group ASID in vq reset (Jason).  Removed extra
> >   function vduse_set_group_asid_nomsg, not needed anymore.
> > * Move the vduse_iotlb_entry_v2 argument to a new ioctl, as argument
> >   didn't match the previous VDUSE_IOTLB_GET_FD.
> > * Move the asid < dev->nas check to vdpa core.
> >
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
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 392 ++++++++++++++++++++---------
> >  include/uapi/linux/vduse.h         |  63 ++++-
> >  2 files changed, 333 insertions(+), 122 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index bf437816fd7d..8227b5e9f3f6 100644
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
> > @@ -439,11 +453,14 @@ static __poll_t vduse_dev_poll(struct file *file,=
 poll_table *wait)
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
> >
> >         down_write(&dev->rwsem);
> >
> > @@ -622,6 +639,31 @@ static union virtio_map vduse_get_vq_map(struct vd=
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
> > +       if (dev->api_version < VDUSE_API_VERSION_1)
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
> > +       write_lock(&dev->groups[group].as_lock);
> > +       dev->groups[group].as =3D &dev->as[asid];
> > +       write_unlock(&dev->groups[group].as_lock);
> > +
> > +       return 0;
> > +}
> > +
> >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> >                                 struct vdpa_vq_state *state)
> >  {
> > @@ -793,13 +835,13 @@ static int vduse_vdpa_set_map(struct vdpa_device =
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
> > @@ -842,6 +884,7 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
> >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> >         .reset                  =3D vduse_vdpa_reset,
> >         .set_map                =3D vduse_vdpa_set_map,
> > +       .set_group_asid         =3D vduse_set_group_asid,
> >         .get_vq_map             =3D vduse_get_vq_map,
> >         .free                   =3D vduse_vdpa_free,
> >  };
> > @@ -850,32 +893,38 @@ static void vduse_dev_sync_single_for_device(unio=
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
> > +       if (token.group->dev->nas > 1)
> > +               read_lock(&token.group->as_lock);
>
> I suggest to factor this and unlock out into helpers.
>

I'm moving to scroped guards.

> >
> > +       domain =3D token.group->as->domain;
> >         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir=
);
> > +
> > +       if (token.group->dev->nas > 1)
> > +               read_unlock(&token.group->as_lock);
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
> > +       if (token.group->dev->nas > 1)
> > +               read_lock(&token.group->as_lock);
> >
> > +       domain =3D token.group->as->domain;
> >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
> > +
> > +       if (token.group->dev->nas > 1)
> > +               read_unlock(&token.group->as_lock);
> >  }
> >
> >  static dma_addr_t vduse_dev_map_page(union virtio_map token, struct pa=
ge *page,
> > @@ -883,38 +932,45 @@ static dma_addr_t vduse_dev_map_page(union virtio=
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
> > +       if (token.group->dev->nas > 1)
> > +               read_lock(&token.group->as_lock);
> > +       domain =3D token.group->as->domain;
> > +       r =3D vduse_domain_map_page(domain, page, offset, size, dir, at=
trs);
> >
> > -       return vduse_domain_map_page(domain, page, offset, size, dir, a=
ttrs);
> > +       if (token.group->dev->nas > 1)
> > +               read_unlock(&token.group->as_lock);
> > +
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
> > +       if (token.group->dev->nas > 1)
> > +               read_lock(&token.group->as_lock);
> > +
> > +       domain =3D token.group->as->domain;
> > +       vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
> >
> > -       return vduse_domain_unmap_page(domain, dma_addr, size, dir, att=
rs);
> > +       if (token.group->dev->nas > 1)
> > +               read_unlock(&token.group->as_lock);
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
> > @@ -927,8 +983,10 @@ static void *vduse_dev_alloc_coherent(union virtio=
_map token, size_t size,
> >         if (!addr)
> >                 return NULL;
> >
> > -       vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > +       if (token.group->dev->nas > 1)
> > +               read_lock(&token.group->as_lock);
> > +
> > +       domain =3D token.group->as->domain;
> >         addr =3D vduse_domain_alloc_coherent(domain, size,
> >                                            (dma_addr_t *)&iova, addr);
> >         if (!addr)
> > @@ -936,9 +994,14 @@ static void *vduse_dev_alloc_coherent(union virtio=
_map token, size_t size,
> >
> >         *dma_addr =3D (dma_addr_t)iova;
> >
> > +       if (token.group->dev->nas > 1)
> > +               read_unlock(&token.group->as_lock);
> > +
> >         return addr;
> >
> >  err:
> > +       if (token.group->dev->nas > 1)
> > +               read_unlock(&token.group->as_lock);
> >         free_pages_exact(addr, size);
> >         return NULL;
> >  }
> > @@ -947,31 +1010,39 @@ static void vduse_dev_free_coherent(union virtio=
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
> > +       if (token.group->dev->nas > 1)
> > +               read_lock(&token.group->as_lock);
> >
> > +       domain =3D token.group->as->domain;
> >         vduse_domain_free_coherent(domain, size, dma_addr, attrs);
> > +
> > +       if (token.group->dev->nas > 1)
> > +               read_unlock(&token.group->as_lock);
> > +
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
> > +       if (token.group->dev->nas > 1)
> > +               read_lock(&token.group->as_lock);
> > +
> > +       bounce_size =3D token.group->as->domain->bounce_size;
> > +
> > +       if (token.group->dev->nas > 1)
> > +               read_unlock(&token.group->as_lock);
> >
> > -       return dma_addr < domain->bounce_size;
> > +       return dma_addr < bounce_size;
> >  }
> >
> >  static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t =
dma_addr)
> > @@ -983,16 +1054,20 @@ static int vduse_dev_mapping_error(union virtio_=
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
> > +       if (token.group->dev->nas > 1)
> > +               read_lock(&token.group->as_lock);
> > +
> > +       bounce_size =3D token.group->as->domain->bounce_size;
> > +
> > +       if (token.group->dev->nas > 1)
> > +               read_unlock(&token.group->as_lock);
> >
> > -       return domain->bounce_size;
> > +       return bounce_size;
> >  }
> >
> >  static const struct virtio_map_ops vduse_map_ops =3D {
> > @@ -1132,39 +1207,40 @@ static int vduse_dev_queue_irq_work(struct vdus=
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
> > @@ -1172,14 +1248,14 @@ static int vduse_dev_reg_umem(struct vduse_dev =
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
> > @@ -1203,7 +1279,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
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
> > @@ -1216,7 +1292,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
ev,
> >         umem->mm =3D current->mm;
> >         mmgrab(current->mm);
> >
> > -       dev->umem =3D umem;
> > +       dev->as[asid].umem =3D umem;
> >  out:
> >         if (ret && pinned > 0)
> >                 unpin_user_pages(page_list, pinned);
> > @@ -1227,7 +1303,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
ev,
> >                 vfree(page_list);
> >                 kfree(umem);
> >         }
> > -       mutex_unlock(&dev->mem_lock);
> > +       mutex_unlock(&dev->as[asid].mem_lock);
> >         return ret;
> >  }
> >
> > @@ -1248,43 +1324,46 @@ static void vduse_vq_update_effective_cpu(struc=
t vduse_virtqueue *vq)
> >  }
> >
> >  static int vduse_dev_iotlb_entry(struct vduse_dev *dev,
> > -                                struct vduse_iotlb_entry *entry,
> > +                                struct vduse_iotlb_entry_v2 *entry,
> >                                  struct file **f, uint64_t *capability)
> >  {
> > +       u32 asid;
> >         int r =3D -EINVAL;
> >         struct vhost_iotlb_map *map;
> >         const struct vdpa_map_file *map_file;
> >
> > -       if (entry->start > entry->last)
> > +       if (entry->v1.start > entry->v1.last || entry->asid >=3D dev->n=
as)
> >                 return -EINVAL;
> >
> > +       asid =3D array_index_nospec(entry->asid, dev->nas);
> >         mutex_lock(&dev->domain_lock);
> > -       if (!dev->domain)
> > +
> > +       if (!dev->as[asid].domain)
> >                 goto out;
> >
> > -       spin_lock(&dev->domain->iotlb_lock);
> > -       map =3D vhost_iotlb_itree_first(dev->domain->iotlb, entry->star=
t,
> > -                                     entry->last);
> > +       spin_lock(&dev->as[asid].domain->iotlb_lock);
> > +       map =3D vhost_iotlb_itree_first(dev->as[asid].domain->iotlb,
> > +                                     entry->v1.start, entry->v1.last);
> >         if (map) {
> >                 if (f) {
> >                         map_file =3D (struct vdpa_map_file *)map->opaqu=
e;
> >                         *f =3D get_file(map_file->file);
> >                 }
> > -               entry->offset =3D map_file->offset;
> > -               entry->start =3D map->start;
> > -               entry->last =3D map->last;
> > -               entry->perm =3D map->perm;
> > +               entry->v1.offset =3D map_file->offset;
> > +               entry->v1.start =3D map->start;
> > +               entry->v1.last =3D map->last;
> > +               entry->v1.perm =3D map->perm;
> >                 if (capability) {
> >                         *capability =3D 0;
> >
> > -                       if (dev->domain->bounce_map && map->start =3D=
=3D 0 &&
> > -                           map->last =3D=3D dev->domain->bounce_size -=
 1)
> > +                       if (dev->as[asid].domain->bounce_map && map->st=
art =3D=3D 0 &&
> > +                           map->last =3D=3D dev->as[asid].domain->boun=
ce_size - 1)
> >                                 *capability |=3D VDUSE_IOVA_CAP_UMEM;
> >                 }
> >
> >                 r =3D 0;
> >         }
> > -       spin_unlock(&dev->domain->iotlb_lock);
> > +       spin_unlock(&dev->as[asid].domain->iotlb_lock);
> >
> >  out:
> >         mutex_unlock(&dev->domain_lock);
> > @@ -1302,12 +1381,29 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >                 return -EPERM;
> >
> >         switch (cmd) {
> > -       case VDUSE_IOTLB_GET_FD: {
> > -               struct vduse_iotlb_entry entry;
> > +       case VDUSE_IOTLB_GET_FD:
> > +       case VDUSE_IOTLB_GET_FD2: {
>
> I would rename this as GET_FD_ASID

It does not scale very well. What if we add more fields to the
reserved members of the ioctl argument?

> but I wonder the reason for the new
> ioctl. I think we can deduce it from the API version,

It's in the changelog but let me know if I should expand there.

The reason for a new ioctl is that the previous one is defined in the
uapi with a struct size that is not able to hold the addition of the
asid. From the documentation [1]:

"the command number encodes the sizeof(data_type) value in a 13-bit or
14-bit integer"

I'm not sure if any sanitizer checks this or if it will be implemented
in the future though. My interpretation of the next section of the
ioctl documentation "Interface versions" also recommends creating a
new versioned ioctl.

Sadly I didn't realize this in the first versions so I introduced it later.

> for example, you
> didn't introduce VDUSE_IOTLB_REG_UMEM2.
>

VDUSE_IOTLB_REG_UMEM already has room for extension in the form of
reserved members that must be zero in the master branch.

> > +               struct vduse_iotlb_entry_v2 entry =3D {0};
> >                 struct file *f =3D NULL;
> >
> > +               ret =3D -ENOIOCTLCMD;
> > +               if (dev->api_version < VDUSE_API_VERSION_1 &&
> > +                   cmd =3D=3D VDUSE_IOTLB_GET_FD2)
> > +                       break;
> > +
> >                 ret =3D -EFAULT;
> > -               if (copy_from_user(&entry, argp, sizeof(entry)))
> > +               if (cmd =3D=3D VDUSE_IOTLB_GET_FD2) {
> > +                       if (copy_from_user(&entry, argp, sizeof(entry))=
)
> > +                               break;
> > +               } else {
> > +                       if (copy_from_user(&entry.v1, argp,
> > +                                          sizeof(entry.v1)))
> > +                               break;
> > +               }
> > +
> > +               ret =3D -EINVAL;
> > +               if (!is_mem_zero((const char *)entry.reserved,
> > +                                sizeof(entry.reserved)))
> >                         break;
> >
> >                 ret =3D vduse_dev_iotlb_entry(dev, &entry, &f, NULL);
> > @@ -1318,12 +1414,19 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >                 if (!f)
> >                         break;
> >
> > -               ret =3D -EFAULT;
> > -               if (copy_to_user(argp, &entry, sizeof(entry))) {
> > +               if (cmd =3D=3D VDUSE_IOTLB_GET_FD2)
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
> > @@ -1468,6 +1571,7 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
> >         }
> >         case VDUSE_IOTLB_REG_UMEM: {
> >                 struct vduse_iova_umem umem;
> > +               u32 asid;
> >
> >                 ret =3D -EFAULT;
> >                 if (copy_from_user(&umem, argp, sizeof(umem)))
> > @@ -1475,17 +1579,21 @@ static long vduse_dev_ioctl(struct file *file, =
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
> > @@ -1493,17 +1601,22 @@ static long vduse_dev_ioctl(struct file *file, =
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
> >         }
> >         case VDUSE_IOTLB_GET_INFO: {
> >                 struct vduse_iova_info info;
> > -               struct vduse_iotlb_entry entry;
> > +               struct vduse_iotlb_entry_v2 entry;
> >
> >                 ret =3D -EFAULT;
> >                 if (copy_from_user(&info, argp, sizeof(info)))
> > @@ -1513,15 +1626,23 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >                                  sizeof(info.reserved)))
> >                         break;
> >
> > -               entry.start =3D info.start;
> > -               entry.last =3D info.last;
> > +               if (dev->api_version < VDUSE_API_VERSION_1) {
> > +                       if (info.asid)
> > +                               break;
> > +               } else if (info.asid >=3D dev->nas)
> > +                       break;
> > +
> > +               entry.v1.start =3D info.start;
> > +               entry.v1.last =3D info.last;
> > +               entry.asid =3D info.asid;
> >                 ret =3D vduse_dev_iotlb_entry(dev, &entry, NULL,
> >                                             &info.capability);
> >                 if (ret < 0)
> >                         break;
> >
> > -               info.start =3D entry.start;
> > -               info.last =3D entry.last;
> > +               info.start =3D entry.v1.start;
> > +               info.last =3D entry.v1.last;
> > +               info.asid =3D entry.asid;
> >
> >                 ret =3D -EFAULT;
> >                 if (copy_to_user(argp, &info, sizeof(info)))
> > @@ -1543,8 +1664,10 @@ static int vduse_dev_release(struct inode *inode=
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
> > @@ -1763,7 +1886,6 @@ static struct vduse_dev *vduse_dev_create(void)
> >                 return NULL;
> >
> >         mutex_init(&dev->lock);
> > -       mutex_init(&dev->mem_lock);
> >         mutex_init(&dev->domain_lock);
> >         spin_lock_init(&dev->msg_lock);
> >         INIT_LIST_HEAD(&dev->send_list);
> > @@ -1814,8 +1936,11 @@ static int vduse_destroy_dev(char *name)
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
> > @@ -1862,12 +1987,17 @@ static bool vduse_validate_config(struct vduse_=
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
> > @@ -1932,7 +2062,8 @@ static ssize_t bounce_size_store(struct device *d=
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
> Should we update the per as bounce size here, and if yes, how to
> synchronize with need_sync()?
>

No, per as bounce size is still not allocated. It is stored in the
per->as[i].domain we check that it is not allocated in this
conditional [2].

> >
> >         ret =3D kstrtouint(buf, 10, &bounce_size);
> > @@ -1984,6 +2115,14 @@ static int vduse_create_dev(struct vduse_dev_con=
fig *config,
> >         dev->device_features =3D config->features;
> >         dev->device_id =3D config->device_id;
> >         dev->vendor_id =3D config->vendor_id;
> > +
> > +       dev->nas =3D (dev->api_version < VDUSE_API_VERSION_1) ? 1 : con=
fig->nas;
> > +       dev->as =3D kcalloc(dev->nas, sizeof(dev->as[0]), GFP_KERNEL);
> > +       if (!dev->as)
> > +               goto err_as;
> > +       for (int i =3D 0; i < dev->nas; i++)
> > +               mutex_init(&dev->as[i].mem_lock);
> > +
> >         dev->ngroups =3D (dev->api_version < VDUSE_API_VERSION_1)
> >                        ? 1
> >                        : config->ngroups;
> > @@ -1991,8 +2130,11 @@ static int vduse_create_dev(struct vduse_dev_con=
fig *config,
> >                               GFP_KERNEL);
> >         if (!dev->groups)
> >                 goto err_vq_groups;
> > -       for (u32 i =3D 0; i < dev->ngroups; ++i)
> > +       for (u32 i =3D 0; i < dev->ngroups; ++i) {
> >                 dev->groups[i].dev =3D dev;
> > +               rwlock_init(&dev->groups[i].as_lock);
> > +               dev->groups[i].as =3D &dev->as[0];
> > +       }
> >
> >         dev->name =3D kstrdup(config->name, GFP_KERNEL);
> >         if (!dev->name)
> > @@ -2032,6 +2174,8 @@ static int vduse_create_dev(struct vduse_dev_conf=
ig *config,
> >  err_str:
> >         kfree(dev->groups);
> >  err_vq_groups:
> > +       kfree(dev->as);
> > +err_as:
> >         vduse_dev_destroy(dev);
> >  err:
> >         return ret;
> > @@ -2155,7 +2299,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *=
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
> > @@ -2170,7 +2314,8 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mde=
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
> > @@ -2184,29 +2329,38 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *m=
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
> > index a3d51cf6df3a..9e423163d819 100644
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
> > @@ -166,6 +167,16 @@ struct vduse_vq_state_packed {
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
> > @@ -225,6 +236,7 @@ struct vduse_vq_eventfd {
> >   * @uaddr: start address of userspace memory, it must be aligned to pa=
ge size
> >   * @iova: start of the IOVA region
> >   * @size: size of the IOVA region
> > + * @asid: Address space ID of the IOVA region
> >   * @reserved: for future use, needs to be initialized to zero
> >   *
> >   * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
> > @@ -234,7 +246,8 @@ struct vduse_iova_umem {
> >         __u64 uaddr;
> >         __u64 iova;
> >         __u64 size;
> > -       __u64 reserved[3];
> > +       __u32 asid;
> > +       __u32 reserved[5];
> >  };
> >
> >  /* Register userspace memory for IOVA regions */
> > @@ -248,6 +261,7 @@ struct vduse_iova_umem {
> >   * @start: start of the IOVA region
> >   * @last: last of the IOVA region
> >   * @capability: capability of the IOVA region
> > + * @asid: Address space ID of the IOVA region, only if device API vers=
ion >=3D 1
> >   * @reserved: for future use, needs to be initialized to zero
> >   *
> >   * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
> > @@ -258,7 +272,8 @@ struct vduse_iova_info {
> >         __u64 last;
> >  #define VDUSE_IOVA_CAP_UMEM (1 << 0)
> >         __u64 capability;
> > -       __u64 reserved[3];
> > +       __u32 asid; /* Only if device API version >=3D 1 */
> > +       __u32 reserved[5];
> >  };
> >
> >  /*
> > @@ -267,6 +282,28 @@ struct vduse_iova_info {
> >   */
> >  #define VDUSE_IOTLB_GET_INFO   _IOWR(VDUSE_BASE, 0x1a, struct vduse_io=
va_info)
> >
> > +/**
> > + * struct vduse_iotlb_entry_v2 - entry of IOTLB to describe one IOVA r=
egion
> > + *
> > + * @v1: the original vduse_iotlb_entry
> > + * @asid: address space ID of the IOVA region
> > + * @reserver: for future use, needs to be initialized to zero
> > + *
> > + * Structure used by VDUSE_IOTLB_GET_FD2 ioctl to find an overlapped I=
OVA region.
> > + */
> > +struct vduse_iotlb_entry_v2 {
> > +       struct vduse_iotlb_entry v1;
> > +       __u32 asid;
> > +       __u32 reserved[12];
> > +};
> > +
> > +/*
> > + * Same as VDUSE_IOTLB_GET_FD but with vduse_iotlb_entry_v2 argument t=
hat
> > + * support extra fields.
> > + */
> > +#define VDUSE_IOTLB_GET_FD2    _IOWR(VDUSE_BASE, 0x1b, struct vduse_io=
tlb_entry_v2)
> > +
> > +
> >  /* The control messages definition for read(2)/write(2) on /dev/vduse/=
$NAME */
> >
> >  /**
> > @@ -280,6 +317,7 @@ enum vduse_req_type {
> >         VDUSE_GET_VQ_STATE,
> >         VDUSE_SET_STATUS,
> >         VDUSE_UPDATE_IOTLB,
> > +       VDUSE_SET_VQ_GROUP_ASID,
> >  };
> >
> >  /**
> > @@ -314,6 +352,18 @@ struct vduse_iova_range {
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
> > @@ -322,6 +372,8 @@ struct vduse_iova_range {
> >   * @vq_state: virtqueue state, only index field is available
> >   * @s: device status
> >   * @iova: IOVA range for updating
> > + * @iova_v2: IOVA range for updating if API_VERSION >=3D 1
> > + * @vq_group_asid: ASID of a virtqueue group
> >   * @padding: padding
> >   *
> >   * Structure used by read(2) on /dev/vduse/$NAME.
> > @@ -334,6 +386,11 @@ struct vduse_dev_request {
> >                 struct vduse_vq_state vq_state;
> >                 struct vduse_dev_status s;
> >                 struct vduse_iova_range iova;
> > +               /* Following members but padding exist only if vduse ap=
i
> > +                * version >=3D 1
> > +                */;
>
> Unnecessary tailing ';'.
>

Ouch, fixing, thanks!

[1] https://docs.kernel.org/driver-api/ioctl.html
[2] https://lore.kernel.org/all/CACGkMEu1Lxun4aPza+kw7KrmLZJkfmW22KQNxbch+Y=
hiTMkJZg@mail.gmail.com/

> > +               struct vduse_iova_range_v2 iova_v2;
> > +               struct vduse_vq_group_asid vq_group_asid;
> >                 __u32 padding[32];
> >         };
> >  };
> > --
> > 2.52.0
> >
>

