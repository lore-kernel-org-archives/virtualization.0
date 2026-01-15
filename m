Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464397081A
	for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768484895; cv=none; b=WX9/KbBaGsN8pe1iUb136wppdNV+JWENvywcIJEAgtgM7Ei1BCUGK3JiXoOGbgcPsYjaPbgZRgf0VvTy45C/CDzpMD6FK8nk+QdnNhN1yBeiHQPe9kDpQFuUYuMgra/jya0YEDb6vmFXEHVlXTgXt0cYxeiDH78DJOjqWPWlwSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768484895; c=relaxed/simple;
	bh=v6sL5FlFwcJ9uF4XHSojlpJ3JzC/ns2hLNu0dTxwSIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WF2XafJOBgkj/oDnEGCVg4xujAlGcKk6ZipV6j0aJqpWeqRi2u91DER6ByjzIP6mxVuBPooPnMs26wHa5TH9bkC2YCG9zOSgJ2vYs21RpY73/bGlvMF/QUJuxRpfZsqTD8fSxgFKWvZaHP0pS/cqxVfd1hSvTdqEYnzEu3vUZsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FH9lnk+y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FH9lnk+y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768484892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LNVB3Cl97VXqWuirwYWckvKJ9pmI3BVBreE+/SzD7NE=;
	b=FH9lnk+yeGv+DpuD5vwevFwzL8EjovMZxRC9uPvBBWiAZRruyVdmXYtIpG+qmnxE8Qh2cc
	A64yK55DUqVtVaFpZMVDXppliO6QrUAiycxruXXehZK05C2LsyEkOWniL7oiMhtyPsY9Nr
	ayjepE1NSXR6SeZ1PPo6CSTD+PMGwko=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-WANMzSRFNjGA52DxBHybOA-1; Thu, 15 Jan 2026 08:48:10 -0500
X-MC-Unique: WANMzSRFNjGA52DxBHybOA-1
X-Mimecast-MFC-AGG-ID: WANMzSRFNjGA52DxBHybOA_1768484890
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-645535ac027so1144787d50.0
        for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 05:48:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768484890; x=1769089690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LNVB3Cl97VXqWuirwYWckvKJ9pmI3BVBreE+/SzD7NE=;
        b=d/NbqhuH0ii2CX5QFV1ivGBhvHAyiCUYLUHjAgpWteO0SlOJvoYnNGJUmcCqoni8/s
         IqgGFUR5kuAq0mHhvUUmDqCG+XIGrVKWda7jFDqO8gVvHi7vfxB+RWdZo/I7JSqS+KPc
         akTt1rJysDLeKjpbRUO+Sxy3gF5JLJxQ/lZP2aL8RspEsAG6lnEi1rkmCSbWIlnSzXiP
         V+BMmiuzNNqgXw6mm6pWIyK6rZJJM5qlncs8kJ211slc6JlWliJ3tmUcYqI/mLw5RwNQ
         vvZVg0PwEq0ED6YmZnIsl0D6EdURTD5druFOvBJj//jeymLzJGZYaNgwFDsyj2vz6Jxp
         E3SA==
X-Forwarded-Encrypted: i=1; AJvYcCWHNIC33dcT92ba17I7qY1hQnKfSPy4NfObxgmQFk54S6qN0XOKmwvgFz0bDvKbjJC2uofe/LdA8rwWlN3ORw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzaWu08DC97k1BrvyW8DEsm49DcHB2za3HXLJ6Rn1B1/pEp7/C
	BUFS/pyW9TVK1G9P0GvGsS2gU1eKAlH6+8eLJcZWqHj9siAFUSgjkZKLy3yo2bwRqojZSH9Pp4Y
	DrQrzq8MqFs1uII2iclDWkaWZ9xl/JYL4Ze+K4EgY35rMdjGaf057+yAgwroxl6dlhFIaNVDIBI
	fMrAk4II1AYeSFWfxchbNyKEW0V6HlG7JUrDdRU+q3/2A=
X-Gm-Gg: AY/fxX6N8MSorSZAKTgL/zjorfDtErXB59EzG3VNQfT++2vYeDpblzjawkGPnF58L9H
	GNUhcGIlDafNs/cgrv+sGpDQHcn06OX54aa0RXdXckqAkGQdaIykq7McB/rrhc6EzQvSe1od9ND
	EXtpCcJKcLYM0AiKtS+tA2gPR9aZgpeHTm9enbTmD2wt3hQMNH1mh8LnvwB5rF8G4fHA==
X-Received: by 2002:a05:690e:138a:b0:644:60d9:752f with SMTP id 956f58d0204a3-64903b61c49mr4061104d50.97.1768484889924;
        Thu, 15 Jan 2026 05:48:09 -0800 (PST)
X-Received: by 2002:a05:690e:138a:b0:644:60d9:752f with SMTP id
 956f58d0204a3-64903b61c49mr4061087d50.97.1768484889436; Thu, 15 Jan 2026
 05:48:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260114184839.926884-1-eperezma@redhat.com> <20260114184839.926884-12-eperezma@redhat.com>
 <CACGkMEtUv7Kge4A6rcSSiVu4moi5vSNU97pQ7_LiUmprOb0wBw@mail.gmail.com>
In-Reply-To: <CACGkMEtUv7Kge4A6rcSSiVu4moi5vSNU97pQ7_LiUmprOb0wBw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 15 Jan 2026 14:47:32 +0100
X-Gm-Features: AZwV_Qi3nIJtBXMs-mGYADMy-bz-WHzm_nzMIa0g2RLFNt0VpahlxmOQ-dfoM4o
Message-ID: <CAJaqyWckHQmTT78E-hnz3w5-qJJGX1_gp3orMDoAupyypcTOVQ@mail.gmail.com>
Subject: Re: [PATCH v12 11/13] vduse: add vq group asid support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SJHWIFaHxBU9amwep-6ufAP0nvBVSrQvKggxvYge0oc_1768484890
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 9:41=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Jan 15, 2026 at 2:49=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redh=
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
> > version 1 with the new ioctl.
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
> >
> > ---
> > v12:
> > * Using scoped guards for vq group rwlock, so the one queue optimizatio=
n
> >   is not missed (Jason proposed to factor them into helpers).
> > * Add the _v2 suffix to vduse_iova_range_v2 struct name fixing the doc
> >   (MST).
> > * s/verion/version/ in patch message.
> > * Remove trailing ; after a comment (Jason).
> >
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
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 385 +++++++++++++++++++----------
> >  include/uapi/linux/vduse.h         |  63 ++++-
> >  2 files changed, 312 insertions(+), 136 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index d658f3e1cebf..2727c0c26003 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -9,6 +9,7 @@
> >   */
> >
> >  #include "linux/virtio_net.h"
> > +#include <linux/cleanup.h>
> >  #include <linux/init.h>
> >  #include <linux/module.h>
> >  #include <linux/cdev.h>
> > @@ -41,6 +42,7 @@
> >
> >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > +#define VDUSE_DEV_MAX_AS 0xffff
> >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > @@ -86,7 +88,15 @@ struct vduse_umem {
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
> > @@ -94,7 +104,7 @@ struct vduse_dev {
> >         struct vduse_vdpa *vdev;
> >         struct device *dev;
> >         struct vduse_virtqueue **vqs;
> > -       struct vduse_iova_domain *domain;
> > +       struct vduse_as *as;
> >         char *name;
> >         struct mutex lock;
> >         spinlock_t msg_lock;
> > @@ -122,9 +132,8 @@ struct vduse_dev {
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
> > @@ -314,7 +323,7 @@ static int vduse_dev_set_status(struct vduse_dev *d=
ev, u8 status)
> >         return vduse_dev_msg_sync(dev, &msg);
> >  }
> >
> > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
> >                                   u64 start, u64 last)
> >  {
> >         struct vduse_dev_msg msg =3D { 0 };
> > @@ -323,8 +332,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev=
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
> > @@ -439,11 +454,14 @@ static __poll_t vduse_dev_poll(struct file *file,=
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
> > @@ -622,6 +640,42 @@ static union virtio_map vduse_get_vq_map(struct vd=
pa_device *vdpa, u16 idx)
> >         return ret;
> >  }
> >
> > +DEFINE_GUARD(vq_group_as_read_lock, struct vduse_vq_group *,
> > +       if (_T->dev->nas > 1)
> > +               read_lock(&_T->as_lock),
> > +       if (_T->dev->nas > 1)
> > +               read_unlock(&_T->as_lock))
> > +
> > +DEFINE_GUARD(vq_group_as_write_lock, struct vduse_vq_group *,
> > +       if (_T->dev->nas > 1)
> > +               write_lock(&_T->as_lock),
> > +       if (_T->dev->nas > 1)
> > +               write_unlock(&_T->as_lock))
> > +
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
> > +       guard(vq_group_as_write_lock)(&dev->groups[group]);
> > +       dev->groups[group].as =3D &dev->as[asid];
> > +
> > +       return 0;
> > +}
> > +
> >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> >                                 struct vdpa_vq_state *state)
> >  {
> > @@ -793,13 +847,13 @@ static int vduse_vdpa_set_map(struct vdpa_device =
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
> > @@ -842,6 +896,7 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
> >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> >         .reset                  =3D vduse_vdpa_reset,
> >         .set_map                =3D vduse_vdpa_set_map,
> > +       .set_group_asid         =3D vduse_set_group_asid,
> >         .get_vq_map             =3D vduse_get_vq_map,
> >         .free                   =3D vduse_vdpa_free,
> >  };
> > @@ -850,15 +905,13 @@ static void vduse_dev_sync_single_for_device(unio=
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
> > +       guard(vq_group_as_read_lock)(token.group);
> > +       domain =3D token.group->as->domain;
> >         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir=
);
> >  }
> >
> > @@ -866,15 +919,13 @@ static void vduse_dev_sync_single_for_cpu(union v=
irtio_map token,
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
> > +       guard(vq_group_as_read_lock)(token.group);
> > +       domain =3D token.group->as->domain;
> >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
> >  }
> >
> > @@ -883,15 +934,13 @@ static dma_addr_t vduse_dev_map_page(union virtio=
_map token, struct page *page,
> >                                      enum dma_data_direction dir,
> >                                      unsigned long attrs)
> >  {
> > -       struct vduse_dev *vdev;
> >         struct vduse_iova_domain *domain;
> >
> >         if (!token.group)
> >                 return DMA_MAPPING_ERROR;
> >
> > -       vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > -
> > +       guard(vq_group_as_read_lock)(token.group);
> > +       domain =3D token.group->as->domain;
> >         return vduse_domain_map_page(domain, page, offset, size, dir, a=
ttrs);
> >  }
> >
> > @@ -899,23 +948,19 @@ static void vduse_dev_unmap_page(union virtio_map=
 token, dma_addr_t dma_addr,
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
> > +       guard(vq_group_as_read_lock)(token.group);
> > +       domain =3D token.group->as->domain;
> > +       vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
> >  }
> >
> >  static void *vduse_dev_alloc_coherent(union virtio_map token, size_t s=
ize,
> >                                       dma_addr_t *dma_addr, gfp_t flag)
> >  {
> > -       struct vduse_dev *vdev;
> > -       struct vduse_iova_domain *domain;
> >         void *addr;
> >
> >         *dma_addr =3D DMA_MAPPING_ERROR;
> > @@ -926,11 +971,15 @@ static void *vduse_dev_alloc_coherent(union virti=
o_map token, size_t size,
> >         if (!addr)
> >                 return NULL;
> >
> > -       vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > -       *dma_addr =3D vduse_domain_alloc_coherent(domain, size, addr);
> > -       if (*dma_addr =3D=3D DMA_MAPPING_ERROR)
> > -               goto err;
> > +       {
> > +               struct vduse_iova_domain *domain;
> > +
> > +               guard(vq_group_as_read_lock)(token.group);
> > +               domain =3D token.group->as->domain;
> > +               *dma_addr =3D vduse_domain_alloc_coherent(domain, size,=
 addr);
> > +               if (*dma_addr =3D=3D DMA_MAPPING_ERROR)
> > +                       goto err;
> > +       }
>
> Nit: Having a standalone block probably means we have the chance to
> optimize the code, maybe using a helper?
>

What do you mean by optimize the code? Would you prefer
vduse_dev_alloc_coherent function to be changed like this (untested)?

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c
b/drivers/vdpa/vdpa_user/vduse_dev.c
index d658f3e1cebf..3561d3c00c89 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -911,11 +911,19 @@ static void vduse_dev_unmap_page(union
virtio_map token, dma_addr_t dma_addr,
        return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
 }

+static dma_addr_t *vduse_vq_group_alloc_coherent(struct vduse_vq_group *gr=
oup,
+                                                size_t size, void *addr)
+{
+       struct vduse_iova_domain *domain;
+
+       guard(vq_group_as_read_lock)(token.group);
+       domain =3D token.group->as->domain;
+       return vduse_domain_alloc_coherent(domain, size, addr);
+}
+
 static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
                                      dma_addr_t *dma_addr, gfp_t flag)
 {
-       struct vduse_dev *vdev;
-       struct vduse_iova_domain *domain;
        void *addr;

        *dma_addr =3D DMA_MAPPING_ERROR;
@@ -926,9 +934,7 @@ static void *vduse_dev_alloc_coherent(union
virtio_map token, size_t size,
        if (!addr)
                return NULL;

-       vdev =3D token.group->dev;
-       domain =3D vdev->domain;
-       *dma_addr =3D vduse_domain_alloc_coherent(domain, size, addr);
+       *dma_addr =3D vduse_vq_group_alloc_coherent(token.group, size, addr=
);
        if (*dma_addr =3D=3D DMA_MAPPING_ERROR)
                goto err;

---

I don't love single use functions but I'm ok with the change if that's
what you want.

