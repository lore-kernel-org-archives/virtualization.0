Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08E329A9CD
	for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763119550; cv=none; b=ffdUh9ZYAfFppmetw/El4kGAKCkH/1VZzuW2+Ina3wykgRR/Jkxq88w9i6DYWEO3azOqE0dhsX0spVadXw/Hlmlm/zidq73UgK5y7qxXUnvcgZjSTXLj54rKw5R27WZ/ikb7+RfOTc7q+yUkDgxbaGTCdOF6SYoznYhiypXjPh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763119550; c=relaxed/simple;
	bh=J9wc7LYIY4ThZfodwsn7laHk4u0pPVcOTcrWK5gVpdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uoeXZJHhHvm4WWm7KV1UDOn3xFzzqfRLphqt0rxXv9pnmxrjT0XommOv1fDq26OoL049WB3FhXpwu616GTjMSVwsRNb9B/B3y7goPLkD2bs8tH+DG1n78WE3bXn6Xk5FtS8Zwc/1giivh7mnPuqrBdbQzp4nlw9SmuALXRjJr4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWptQ5FK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWptQ5FK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763119546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GT1jVNpb9q5+amm4s/U+2EC247XKPjMMbNPfbyDNXwA=;
	b=MWptQ5FKQS3yaB6lZeKFwEMrXbVsah/JcQJBOcdExd89+pjXHKrs0mf4ZVIhg88owujeSr
	sjKiotUF2PS5KFsnMj6iC1z3Oqx5RO8b2ZaEo+ptIy6p8dqpPa5HULfDt/Ft4RZ6jLcf2G
	+mrlmgdpWYcA1hH9r5pXMSF082Z+LV4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-Fskyt0XWMM23L8-rMrrRgQ-1; Fri, 14 Nov 2025 06:25:43 -0500
X-MC-Unique: Fskyt0XWMM23L8-rMrrRgQ-1
X-Mimecast-MFC-AGG-ID: Fskyt0XWMM23L8-rMrrRgQ_1763119542
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-37b9370bcd0so11045211fa.1
        for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 03:25:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763119542; x=1763724342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GT1jVNpb9q5+amm4s/U+2EC247XKPjMMbNPfbyDNXwA=;
        b=Vpzta0Nnab1vdTFeUzvQZYYcNQCQssFjF/pUsqTVXcOkzM1G+nYNaPlvRCq3zQ+Y20
         /JPUvFjFLMe67PghOw3eBzaJlQ1W2iIDNjSI+O3YOUhsp7uQaMwbNFfAEsxmSbUv77p1
         xlDNeVOi2+12mZ9HqXepspUCyoy4mgI9VymRD83xkd93p3XaKpOCOx1sKAev6C9Dd69P
         9h2jObKmYBTV0mK8KLQ0mKSSZHcEK330yCk+zlE5TQE6Gpc2LIIE2b1JYqS1uwGdfbnh
         LfbHuEJzGMCMXGsoKpsLpj1oVoIrsCGfTYh0EZXrx+am0lVOA2fGgHmAaNMmXvBv+vHS
         sG8g==
X-Forwarded-Encrypted: i=1; AJvYcCXNKrKKnt4fiXaqv7U1eZEe45GiYjBv2QhwYsNiefn/Zc4N9dtw/72WQA+0t5okSyCyH4tL8K4EFPDebg1fFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTOwxfj48NTgM6G8UAhrYe4ln397A7446brvCvsu70+RM+n8j5
	jCCk1tAH3m/mwke1jFdFpRzYE6uCzj2DZqUkFHWwu+M9pEboxoHPX4whQ1tQfIhBezT3z8irKYb
	ciZ2x2YO3Ie5rwzoPySRui2vzB8CW5MVprO7JAuJZaEHjwH/BFd2gInKLuaJsqKIzJqajEXPxQf
	n+wHiP2z4ql2WmSCFeI9JF/7Cr48xao18zEXXx8Cdq6wc=
X-Gm-Gg: ASbGncvKXZ2kYqMVMfkJ71xxxqG5sRNwe2jehaX7FeFB/ZwGfM+Zp06DGJ8sGEs3Uki
	rtap7kcmUogHGIP65H3+394wI6QKkNE6SNlnkap6r/vGhDr5WxpfZ84zjr7xtb2HY57RL58keOA
	7sLfKu26J6xnfg5k8f8u9FFBG0Z1d+4soJ3KLWVLghCscAahPe7LUCuzyo
X-Received: by 2002:a05:651c:41d4:b0:378:cd74:a287 with SMTP id 38308e7fff4ca-37babbc03f0mr6139841fa.2.1763119541875;
        Fri, 14 Nov 2025 03:25:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjD7BAKdqGBmnljokQ5CoABozoq5cyt0IxvTySuAg49uBttTdeackNGT9U0uu5JH3xPsJHtqbavniTAohtxgI=
X-Received: by 2002:a05:651c:41d4:b0:378:cd74:a287 with SMTP id
 38308e7fff4ca-37babbc03f0mr6139681fa.2.1763119541307; Fri, 14 Nov 2025
 03:25:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251113115558.1277981-1-eperezma@redhat.com> <20251113115558.1277981-6-eperezma@redhat.com>
 <CACGkMEuwzmSmrh5PBhuokzt6Tf5b4+6JGmAuTAC-y-Sm04FZPA@mail.gmail.com>
In-Reply-To: <CACGkMEuwzmSmrh5PBhuokzt6Tf5b4+6JGmAuTAC-y-Sm04FZPA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 14 Nov 2025 12:25:03 +0100
X-Gm-Features: AWmQ_blkcWLe6tevfhN6UCTeUCjKhXWNRqAhmJ9mz0rZqXqo2pBfMp20odzbS-Q
Message-ID: <CAJaqyWex0rE+KO-UE_qxqkG3RWWP4ntNy+9Nzvb+CZ+auR3mVw@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] vduse: add vq group asid support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	Maxime Coquelin <mcoqueli@redhat.com>, Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rt-GWNOKkRea1CpDequ5b5vLE6Ccmzl4w2fA5OI-I7g_1763119542
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 1:55=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Nov 13, 2025 at 7:56=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> > group.  This enables mapping each group into a distinct memory space.
> >
> > Now that the driver can change ASID in the middle of operation, the
> > domain that each vq address point is also protected by domain_lock.
>
> Maybe it's better to document what is protected by RCU and how.
>

I added the _rcu annotation but I can expand it for sure. I can also
modify the commit message.

> More below.
>
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>

I forgot to remove this, my bad!

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
> > +       struct vduse_as *as __rcu;
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
> > @@ -436,14 +450,32 @@ static __poll_t vduse_dev_poll(struct file *file,=
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
> > +       /*
> > +        * Two concurrent updates to this pointer are valid as they can=
not
> > +        * point to an invalid region.  It is ok for them to race as lo=
ng as
> > +        * the readers see a consistent state through RCU.
> > +        */
> > +       rcu_assign_pointer(dev->groups[group].as, &dev->as[asid]);
>
> I'd expect at least a synchronize_rcu() here to wait for the read is done=
?
>

What's the use? The only thing left here is to return from
vduse_set_group_asid_nomsg, and we don't need to wait for readers
here, do we?

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
> > @@ -623,6 +655,29 @@ static union virtio_map vduse_get_vq_map(struct vd=
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
> > @@ -794,13 +849,13 @@ static int vduse_vdpa_set_map(struct vdpa_device =
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
> > @@ -843,6 +898,7 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
> >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> >         .reset                  =3D vduse_vdpa_reset,
> >         .set_map                =3D vduse_vdpa_set_map,
> > +       .set_group_asid         =3D vduse_set_group_asid,
> >         .get_vq_map             =3D vduse_get_vq_map,
> >         .free                   =3D vduse_vdpa_free,
> >  };
> > @@ -852,14 +908,17 @@ static void vduse_dev_sync_single_for_device(unio=
n virtio_map token,
> >                                              enum dma_data_direction di=
r)
> >  {
> >         struct vduse_dev *vdev;
> > +       struct vduse_as *as;
> >         struct vduse_iova_domain *domain;
> >
> >         if (!token.group)
> >                 return;
> >
> >         vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > -
> > +       rcu_read_lock();
> > +       as =3D rcu_dereference(token.group->as);
> > +       domain =3D as->domain;
> > +       rcu_read_unlock();
> >         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir=
);
>
> This is suspicious, at least we should do rcu_read_unlock() after
> vduse_domain_sync_single_for_device(), otherwise I don't see how RCU
> works.
>

RCU is protecting that the address space pointer of the vq group is
not modified concurrently with the access. Ideally, this should be a
full lock, but just making sure that all accesses from the reader are
coherent is enough. Userspace should expect nothing if it uses the map
and modifies the vq group ASID at the same time anyway, but the kernel
needs to be sure that it does not see intermediate states. TBH, we
could move to a READ_ONCE / WRITE_ONCE, would that be more clear?

The function vduse_domain uses its own lock to protect concurrent
access to the maps of the ASID itself, as they were needed before
implementing ASID already.

> >  }
> >
> > @@ -868,14 +927,17 @@ static void vduse_dev_sync_single_for_cpu(union v=
irtio_map token,
> >                                              enum dma_data_direction di=
r)
> >  {
> >         struct vduse_dev *vdev;
> > +       struct vduse_as *as;
> >         struct vduse_iova_domain *domain;
> >
> >         if (!token.group)
> >                 return;
> >
> >         vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > -
> > +       rcu_read_lock();
> > +       as =3D rcu_dereference(token.group->as);
> > +       domain =3D as->domain;
> > +       rcu_read_unlock();
> >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
> >  }
> >
> > @@ -885,15 +947,21 @@ static dma_addr_t vduse_dev_map_page(union virtio=
_map token, struct page *page,
> >                                      unsigned long attrs)
> >  {
> >         struct vduse_dev *vdev;
> > +       struct vduse_as *as;
> >         struct vduse_iova_domain *domain;
> > +       dma_addr_t r;
> >
> >         if (!token.group)
> >                 return DMA_MAPPING_ERROR;
> >
> >         vdev =3D token.group->dev;
> > -       domain =3D vdev->domain;
> > +       rcu_read_lock();
> > +       as =3D rcu_dereference(token.group->as);
> > +       domain =3D as->domain;
> > +       rcu_read_unlock();
> > +       r =3D vduse_domain_map_page(domain, page, offset, size, dir, at=
trs);
>
> Same here.
>
> Thanks
>

