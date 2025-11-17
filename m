Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3105F321437
	for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370524; cv=none; b=j1T7MCob+pg4q/YvGEyvDedrO5GUULxKq45+qUvrwsIF3mye5na1zxltzu08hdEKfwTDUVZmfqe0yL31t6MNEvex9dMBqbLtirMN9VUosW/l9cWwrxAgFfY1sffm2FfJmS89s6XamvlpQo1/K/YX0l9rzt1JDwZke16UbsPjq9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370524; c=relaxed/simple;
	bh=/PaLoN4sdVbIBF03jvG534ZiVk/3jQcm8Ay6gCl2y0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdtjFBSDUmnJncsn29QX572RqN+gYCKWt0qxE7JvGHOfQZbr4LhfOHOb3C+2F5IFmkCLngLLj2RNuBY41CRM7oGz1xKPsNHdpdj0dJ6P+k0bPwEzMhRMHvhtRk0f44WtsdTFyIzmZE4it1iPddg1bq/XyPkUJI5CZvfKdEFrUus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cvSCbNFy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvSCbNFy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763370521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljwlq5uZLSzzV70qghIUJ3FTpMoKV4NFKRMwA1HpblY=;
	b=cvSCbNFyRnSmJxrEVZ3eRLzVFtVth3By1QAEn3oXIxJWNLO5hx25rw+70AbjldJfXEx7KT
	6cKGyRDNc5TADVvCKmgROLn9MS2Vy1p+kWORILE84+onrc0x+Z/Lbsl4W9gAytYhZ70opA
	X92LLa4l+1CnbNGQLj1YXNv0+bVv/kc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-V_G8_-haM9qU0bv9erH8cg-1; Mon, 17 Nov 2025 04:08:39 -0500
X-MC-Unique: V_G8_-haM9qU0bv9erH8cg-1
X-Mimecast-MFC-AGG-ID: V_G8_-haM9qU0bv9erH8cg_1763370519
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-787e84cec10so59636627b3.3
        for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 01:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763370519; x=1763975319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ljwlq5uZLSzzV70qghIUJ3FTpMoKV4NFKRMwA1HpblY=;
        b=QTK5/tiT2NoJ42k40zWRG0StquH1Plvy4DRRvmrCqFnDCWD4IS3IyjEu/T8wJDZpPI
         RxmI5D1F+BPrXhhb1WezIGM8hAqk7sSTUwPx/ZvEGm2Isdu31DhVx+VKB6FmjyZixiNZ
         uxB1i7WNx2t6C6Kn0ZWeY1BXfnt0e0EhbR5i0EEfi5dHeWyepyppn1LAyKnS0liUdEam
         IzI5Zh4qGoiisNTpILqhuMuWktrWWc42sGZJ/CVRFKts5W3JRHGsYDKbVrTYs0tHvOdd
         rKimez8WD6FOuEcjKvA5pzjrgnn55CC92Q86zWFfi42tP2YtQpF9CouONknkLzVRXEO3
         6n4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmnTFhd/NJh3YbE0+PP+725CJcLCJh9TXssQQnosxApWyN4x2PvK7sjYZHdQ3hzFBJ2z26SBTtSaSEesGOJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbDrGeVo3kvwXLozmjcnG+wH86dSEGueM8S1jhMaXmdeTpYfG5
	fAgcefzsIdGEOTAny+kK7DGXwqd5+WbIeLo6lVkc8r1c4fryLRVB9rJ4D/Z1RD12+DuJrLwIJ+Z
	T0nWf9Ba+rz/UJ4piv+U7BTSDVtHT9PTdBVM1Mz7xgSreDho+upSqCzH3DFBbN3uGf9qufQ/6Lq
	KUfoJlZZ/ndFE1kJfQBHA6mJPZWWx0lZNdPXPyABBzWfE=
X-Gm-Gg: ASbGncv/Xl2pk6w1UHD2l4yPwmlF7xO+aBVX2HQ5SvLvixW/ZPjaDdNz7v1yFCAYrOh
	Ax78nGSBJUsPYkasfz+lIfwH7VFII+htDLp/4uj2WY8XdR2y3ItV/5POseP/VrWypqofdFI+PRp
	Pr1smbaEFOizRcSd1M6Dk65AClgNkZFIoyj9DQ0Ff4sBtiVv7HhiBuBcOl
X-Received: by 2002:a05:690c:9690:b0:77f:aab8:31ae with SMTP id 00721157ae682-78929efb9f1mr90909817b3.46.1763370518880;
        Mon, 17 Nov 2025 01:08:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfWtSzWN5llRu6fkbCZABuHd0/dVRaaPmdQDUXE7UGI/5ttZicUG10a3wjjEn8LsDG/sQdpDSeq7Pqjvvcusk=
X-Received: by 2002:a05:690c:9690:b0:77f:aab8:31ae with SMTP id
 00721157ae682-78929efb9f1mr90909597b3.46.1763370518451; Mon, 17 Nov 2025
 01:08:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251113115558.1277981-1-eperezma@redhat.com> <20251113115558.1277981-6-eperezma@redhat.com>
 <e1c8f03799732f82abe873d494e50c8d157670ad.a04fe0df.59e1.4e7b.ba43.fc004fb5f4db@bytedance.com>
In-Reply-To: <e1c8f03799732f82abe873d494e50c8d157670ad.a04fe0df.59e1.4e7b.ba43.fc004fb5f4db@bytedance.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 17 Nov 2025 10:08:00 +0100
X-Gm-Features: AWmQ_bktlcUMh7k7WUVV3ndi27ZOXyftWJuXGMiJfNDSxgAt5ByBoGygCUSnGcU
Message-ID: <CAJaqyWdJnx9bG9WLy0gp9e=kAyw8mHGBkyXVJP2WAE5SRohuxg@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] vduse: add vq group asid support
To: =?UTF-8?B?6LCi5rC45ZCJ?= <xieyongji@bytedance.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	virtualization <virtualization@lists.linux.dev>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nY7rwOye_xkzwwyNn4vaZqAEFGmb7A1DuX1SSN6oj4o_1763370519
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 4:10=E2=80=AFAM =E8=B0=A2=E6=B0=B8=E5=90=89 <xieyon=
gji@bytedance.com> wrote:
>
> > Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> > group.  This enables mapping each group into a distinct memory space.
> >
> > Now that the driver can change ASID in the middle of operation, the
> > domain that each vq address point is also protected by domain_lock.
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v9:
> > * Replace mutex with RCU, as the vdpa map_ops can run from atomic
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
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 370 ++++++++++++++++++++---------
> >  include/uapi/linux/vduse.h         |  53 ++++-
> >  2 files changed, 314 insertions(+), 109 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 97be04f73fbf..ff95ed56f22d 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -11,6 +11,7 @@
> >  #include "linux/virtio_net.h"
> >  #include <linux/init.h>
> >  #include <linux/module.h>
> > +#include <linux/rcupdate.h>
> >  #include <linux/cdev.h>
> >  #include <linux/device.h>
> >  #include <linux/eventfd.h>
> > @@ -41,6 +42,7 @@
> >
> >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > +#define VDUSE_DEV_MAX_AS 0xffff
> >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > @@ -86,7 +88,14 @@ struct vduse_umem {
> >          struct mm_struct *mm;
> >  };
> >
> > +struct vduse_as {
> > +        struct vduse_iova_domain *domain;
> > +        struct vduse_umem *umem;
> > +        struct mutex mem_lock;
> > +};
> > +
> >  struct vduse_vq_group {
> > +        struct vduse_as *as __rcu;
> >          struct vduse_dev *dev;
> >  };
> >
> > @@ -94,7 +103,7 @@ struct vduse_dev {
> >          struct vduse_vdpa *vdev;
> >          struct device *dev;
> >          struct vduse_virtqueue **vqs;
> > -        struct vduse_iova_domain *domain;
> > +        struct vduse_as *as;
> >          char *name;
> >          struct mutex lock;
> >          spinlock_t msg_lock;
> > @@ -122,9 +131,8 @@ struct vduse_dev {
> >          u32 vq_num;
> >          u32 vq_align;
> >          u32 ngroups;
> > -        struct vduse_umem *umem;
> > +        u32 nas;
> >          struct vduse_vq_group *groups;
> > -        struct mutex mem_lock;
> >          unsigned int bounce_size;
> >          struct mutex domain_lock;
> >  };
> > @@ -314,7 +322,7 @@ static int vduse_dev_set_status(struct vduse_dev *d=
ev, u8 status)
> >          return vduse_dev_msg_sync(dev, &msg);
> >  }
> >
> > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
> >                                    u64 start, u64 last)
> >  {
> >          struct vduse_dev_msg msg =3D { 0 };
> > @@ -323,8 +331,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev=
 *dev,
> >                  return -EINVAL;
> >
> >          msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > -        msg.req.iova.start =3D start;
> > -        msg.req.iova.last =3D last;
> > +        if (dev->api_version < VDUSE_API_VERSION_1) {
> > +                msg.req.iova.start =3D start;
> > +                msg.req.iova.last =3D last;
> > +        } else {
> > +                msg.req.iova_v2.start =3D start;
> > +                msg.req.iova_v2.last =3D last;
> > +                msg.req.iova_v2.asid =3D asid;
> > +        }
> >
> >          return vduse_dev_msg_sync(dev, &msg);
> >  }
> > @@ -436,14 +450,32 @@ static __poll_t vduse_dev_poll(struct file *file,=
 poll_table *wait)
> >          return mask;
> >  }
> >
> > +/* Force set the asid to a vq group without a message to the VDUSE dev=
ice */
> > +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> > +                                       unsigned int group, unsigned in=
t asid)
> > +{
> > +        /*
> > +         * Two concurrent updates to this pointer are valid as they ca=
nnot
> > +         * point to an invalid region.  It is ok for them to race as l=
ong as
> > +         * the readers see a consistent state through RCU.
> > +         */
> > +        rcu_assign_pointer(dev->groups[group].as, &dev->as[asid]);
> > +}
> > +
> >  static void vduse_dev_reset(struct vduse_dev *dev)
> >  {
> >          int i;
> > -        struct vduse_iova_domain *domain =3D dev->domain;
> >
> >          /* The coherent mappings are handled in vduse_dev_free_coheren=
t() */
> > -        if (domain && domain->bounce_map)
> > -                vduse_domain_reset_bounce_map(domain);
> > +        for (i =3D 0; i < dev->nas; i++) {
> > +                struct vduse_iova_domain *domain =3D dev->as[i].domain=
;
> > +
> > +                if (domain && domain->bounce_map)
> > +                        vduse_domain_reset_bounce_map(domain);
> > +        }
> > +
> > +        for (i =3D 0; i < dev->ngroups; i++)
> > +                vduse_set_group_asid_nomsg(dev, i, 0);
> >
> >          down_write(&dev->rwsem);
> >
> > @@ -623,6 +655,29 @@ static union virtio_map vduse_get_vq_map(struct vd=
pa_device *vdpa, u16 idx)
> >          return ret;
> >  }
> >
> > +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned int=
 group,
> > +                                unsigned int asid)
> > +{
> > +        struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > +        struct vduse_dev_msg msg =3D { 0 };
> > +        int r;
> > +
> > +        if (dev->api_version < VDUSE_API_VERSION_1 ||
> > +            group >=3D dev->ngroups || asid >=3D dev->nas)
> > +                return -EINVAL;
> > +
> > +        msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > +        msg.req.vq_group_asid.group =3D group;
> > +        msg.req.vq_group_asid.asid =3D asid;
> > +
> > +        r =3D vduse_dev_msg_sync(dev, &msg);
> > +        if (r < 0)
> > +                return r;
> > +
> > +        vduse_set_group_asid_nomsg(dev, group, asid);
> > +        return 0;
> > +}
> > +
> >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> >                                  struct vdpa_vq_state *state)
> >  {
> > @@ -794,13 +849,13 @@ static int vduse_vdpa_set_map(struct vdpa_device =
*vdpa,
> >          struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> >          int ret;
> >
> > -        ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > +        ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb);
> >          if (ret)
> >                  return ret;
> >
> > -        ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > +        ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
> >          if (ret) {
> > -                vduse_domain_clear_map(dev->domain, iotlb);
> > +                vduse_domain_clear_map(dev->as[asid].domain, iotlb);
> >                  return ret;
> >          }
> >
> > @@ -843,6 +898,7 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
> >          .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> >          .reset                        =3D vduse_vdpa_reset,
> >          .set_map                =3D vduse_vdpa_set_map,
> > +        .set_group_asid                =3D vduse_set_group_asid,
> >          .get_vq_map                =3D vduse_get_vq_map,
> >          .free                        =3D vduse_vdpa_free,
> >  };
> > @@ -852,14 +908,17 @@ static void vduse_dev_sync_single_for_device(unio=
n virtio_map token,
> >                                               enum dma_data_direction d=
ir)
> >  {
> >          struct vduse_dev *vdev;
> > +        struct vduse_as *as;
> >          struct vduse_iova_domain *domain;
> >
> >          if (!token.group)
> >                  return;
> >
> >          vdev =3D token.group->dev;
> > -        domain =3D vdev->domain;
> > -
> > +        rcu_read_lock();
> > +        as =3D rcu_dereference(token.group->as);
> > +        domain =3D as->domain;
> > +        rcu_read_unlock();
> >          vduse_domain_sync_single_for_device(domain, dma_addr, size, di=
r);
> >  }
> >
> > @@ -868,14 +927,17 @@ static void vduse_dev_sync_single_for_cpu(union v=
irtio_map token,
> >                                               enum dma_data_direction d=
ir)
> >  {
> >          struct vduse_dev *vdev;
> > +        struct vduse_as *as;
> >          struct vduse_iova_domain *domain;
> >
> >          if (!token.group)
> >                  return;
> >
> >          vdev =3D token.group->dev;
> > -        domain =3D vdev->domain;
> > -
> > +        rcu_read_lock();
> > +        as =3D rcu_dereference(token.group->as);
> > +        domain =3D as->domain;
> > +        rcu_read_unlock();
> >          vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
> >  }
> >
> > @@ -885,15 +947,21 @@ static dma_addr_t vduse_dev_map_page(union virtio=
_map token, struct page *page,
> >                                       unsigned long attrs)
> >  {
> >          struct vduse_dev *vdev;
> > +        struct vduse_as *as;
> >          struct vduse_iova_domain *domain;
> > +        dma_addr_t r;
> >
> >          if (!token.group)
> >                  return DMA_MAPPING_ERROR;
> >
> >          vdev =3D token.group->dev;
> > -        domain =3D vdev->domain;
> > +        rcu_read_lock();
> > +        as =3D rcu_dereference(token.group->as);
> > +        domain =3D as->domain;
> > +        rcu_read_unlock();
> > +        r =3D vduse_domain_map_page(domain, page, offset, size, dir, a=
ttrs);
> >
> > -        return vduse_domain_map_page(domain, page, offset, size, dir, =
attrs);
> > +        return r;
> >  }
> >
> >  static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dm=
a_addr,
> > @@ -901,21 +969,25 @@ static void vduse_dev_unmap_page(union virtio_map=
 token, dma_addr_t dma_addr,
> >                                   unsigned long attrs)
> >  {
> >          struct vduse_dev *vdev;
> > +        struct vduse_as *as;
> >          struct vduse_iova_domain *domain;
> >
> >          if (!token.group)
> >                  return;
> >
> >          vdev =3D token.group->dev;
> > -        domain =3D vdev->domain;
> > -
> > -        return vduse_domain_unmap_page(domain, dma_addr, size, dir, at=
trs);
> > +        rcu_read_lock();
> > +        as =3D rcu_dereference(token.group->as);
> > +        domain =3D as->domain;
> > +        rcu_read_unlock();
> > +        vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
> >  }
> >
> >  static void *vduse_dev_alloc_coherent(union virtio_map token, size_t s=
ize,
> >                                        dma_addr_t *dma_addr, gfp_t flag=
)
> >  {
> >          struct vduse_dev *vdev;
> > +        struct vduse_as *as;
> >          struct vduse_iova_domain *domain;
> >          unsigned long iova;
> >          void *addr;
> > @@ -925,13 +997,14 @@ static void *vduse_dev_alloc_coherent(union virti=
o_map token, size_t size,
> >                  return NULL;
> >
> >          vdev =3D token.group->dev;
> > -        domain =3D vdev->domain;
> > +        rcu_read_lock();
> > +        as =3D rcu_dereference(token.group->as);
> > +        domain =3D as->domain;
> > +        rcu_read_unlock();
> >          addr =3D vduse_domain_alloc_coherent(domain, size,
> >                                             (dma_addr_t *)&iova, flag);
> > -        if (!addr)
> > -                return NULL;
> > -
> > -        *dma_addr =3D (dma_addr_t)iova;
> > +        if (addr)
> > +                *dma_addr =3D (dma_addr_t)iova;
> >
> >          return addr;
> >  }
> > @@ -941,29 +1014,39 @@ static void vduse_dev_free_coherent(union virtio=
_map token, size_t size,
> >                                      unsigned long attrs)
> >  {
> >          struct vduse_dev *vdev;
> > +        struct vduse_as *as;
> >          struct vduse_iova_domain *domain;
> >
> >          if (!token.group)
> >                  return;
> >
> >          vdev =3D token.group->dev;
> > -        domain =3D vdev->domain;
> > -
> > +        rcu_read_lock();
> > +        as =3D rcu_dereference(token.group->as);
> > +        domain =3D as->domain;
> > +        rcu_read_unlock();
> >          vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attr=
s);
> > +        mutex_unlock(&vdev->domain_lock);
> >  }
> >
> >  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma=
_addr)
> >  {
> >          struct vduse_dev *vdev;
> > +        struct vduse_as *as;
> >          struct vduse_iova_domain *domain;
> > +        size_t bounce_size;
> >
> >          if (!token.group)
> >                  return false;
> >
> >          vdev =3D token.group->dev;
> > -        domain =3D vdev->domain;
> > +        rcu_read_lock();
> > +        as =3D rcu_dereference(token.group->as);
> > +        domain =3D as->domain;
> > +        rcu_read_unlock();
> > +        bounce_size =3D domain->bounce_size;
> >
> > -        return dma_addr < domain->bounce_size;
> > +        return dma_addr < bounce_size;
> >  }
> >
> >  static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t =
dma_addr)
> > @@ -976,15 +1059,22 @@ static int vduse_dev_mapping_error(union virtio_=
map token, dma_addr_t dma_addr)
> >  static size_t vduse_dev_max_mapping_size(union virtio_map token)
> >  {
> >          struct vduse_dev *vdev;
> > +        struct vduse_as *as;
> >          struct vduse_iova_domain *domain;
> > +        size_t bounce_size;
> >
> >          if (!token.group)
> >                  return 0;
> >
> >          vdev =3D token.group->dev;
> > -        domain =3D vdev->domain;
> > +        rcu_read_lock();
> > +        as =3D rcu_dereference(token.group->as);
> > +        domain =3D as->domain;
> > +        rcu_read_unlock();
> > +        domain =3D token.group->as->domain;
>
> This line should be removed?
>

Totally, thank you very much for the catch!

