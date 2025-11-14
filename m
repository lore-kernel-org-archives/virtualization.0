Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC1319E819
	for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763081738; cv=none; b=Rgn6+2jp4cXGs6YKM69JcwHMv5EuWCH4lGb9oL5biQgJL2/tLVXAWHg10lsleHmylpsq73ysnFDaaA/yC8Yi74VbPGKIZrDAmy3RuhQ6wMzINfoik06HGV1AvmIdj30EOjjY2RHKB/AvinNrFUuMxLCEzg2bYY0chMj1DBs2kwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763081738; c=relaxed/simple;
	bh=Uhb9CzOh3BPVQaITk/lnZZwzy0R5Cj5QXzACd8ChyTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZyGQLwuE9BituOOZ/aK5Oq9nq0fvKwYUBCvn4cqMOPCqSXuh07KRWUFLr3lxbgYAiH7cl0o9LS6Dn4i/T4GLjftuDgxcBDaQgy89+RYdiGUg2O1t6zqhAKIWT5HlEOLtRboSj5XbQgwRNYtzfnVkN2mrrNuO7vk8RfeOXEvgcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7IEbQUS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7IEbQUS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763081735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whKC/4wkAzvpS4hTsEwzC8fqPGYtzwfEWHjhPJPP9+s=;
	b=S7IEbQUSCNqO49Yf4KUsY8Vnzw1G5nZeDtbXMhOdyBdgo9N600wcqgZlfQKn0r1V474Yff
	HYJtzDCz94l6Fm3h3lDjLw0IX6TWjbsTg2g/BwFxQ8ufmU7rBZjP4+yAd+gACHV0q9VF3c
	T4x/IOnsbb6Rt/pTCTH/OCccU1RRhNM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-aWuvHB-IONCF8Lf_ybp_NA-1; Thu, 13 Nov 2025 19:55:34 -0500
X-MC-Unique: aWuvHB-IONCF8Lf_ybp_NA-1
X-Mimecast-MFC-AGG-ID: aWuvHB-IONCF8Lf_ybp_NA_1763081734
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3416dc5754fso2000802a91.1
        for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 16:55:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763081733; x=1763686533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=whKC/4wkAzvpS4hTsEwzC8fqPGYtzwfEWHjhPJPP9+s=;
        b=l4LXZXJpkIX8PivFdZc1lx7JhtmZSk7gALS7EuUzo77FVDMKNo/qBJbXUgE6SobRpN
         Yo8NlNxz9gAfqSZyZQGGetmfrtve94+VZRDyQ9nl85UaPS2uDJsWaLAjnlkcXQFcjOj9
         /IWcPwwC2wQAX45poo2AXzG34RJ14kcA9oJdyoUXM0ENDzHXfzku9pFIczyRPsm7URdq
         tSYvO4v9lP8BFhg00KU58qDjCLDE0zPYyjyupxSKMXF/jxqUCIjwfcV3Hhe0XeD7XtAt
         UF5LyxMBny++kcIcng1Uh+8bs0iJ/jfwm1tQ1rCCdPI+0y6MwDmRDYFRdMBujqmNATWC
         5KAg==
X-Forwarded-Encrypted: i=1; AJvYcCWUqiMcCrMD22WODdkv1YUTXjvy7iN7a01SjdoSVeQ+AWaFu7CV/azxilzXeX7xs5ppN/BwjNmbottnbCmKXg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzxvfa1SA5Q1sppxB4ykpzovYlu2Nwq+JePEwisEo8d1po98uMo
	weJXUcfgICWTfP4wNt5R6mKVKHEN7b+I2t+nqwbGqd7tVLIKAOt2YGW50B+OrnvX0g1M7Zo7I4F
	krSLM/5mSn51TEjUb3PGII3oG8IEKV7kvhy8HIzptJTuM6qWZ8HfevvfgF5w75v7c89p8ot4IB9
	c0/8f2jXujDR6LxJrkoOmUK7sNCGafjwi5qqXHDu80FpY=
X-Gm-Gg: ASbGncsJdU1pLKcivOWgAJ72KnlRgKIVV/kXIoqhwsUJI0Ji1EBNfMKrua8/l06tS3r
	eCpavKMtgH2qPShkuELeDvPzind8TmU/ex0BFDGY97s/cT7Y68msQFuBvAWGhcBP8NeXYBUYNi/
	5zzFIzyv23yGwyUdhHxRYzGC2aIxNW2LkXWO+gq/0hMHLJSU6Fw61dLt7PQBvTkR1X
X-Received: by 2002:a17:90b:1dcf:b0:343:87b1:272 with SMTP id 98e67ed59e1d1-343fa637871mr1262986a91.22.1763081733573;
        Thu, 13 Nov 2025 16:55:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm2W3N8mAOhCWGT2ZsVpFRufV2VMu5Y207WqIlubliKVtcx2kxyYEAu7njiUhxa177GrC240In4B0f5WpIBLM=
X-Received: by 2002:a17:90b:1dcf:b0:343:87b1:272 with SMTP id
 98e67ed59e1d1-343fa637871mr1262960a91.22.1763081733095; Thu, 13 Nov 2025
 16:55:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251113115558.1277981-1-eperezma@redhat.com> <20251113115558.1277981-6-eperezma@redhat.com>
In-Reply-To: <20251113115558.1277981-6-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Nov 2025 08:55:21 +0800
X-Gm-Features: AWmQ_bnuuatnjzYJvvEmA3dFK2guTD1300Mqmmxw_19KRgPLwQrlUjke4OUyJis
Message-ID: <CACGkMEuwzmSmrh5PBhuokzt6Tf5b4+6JGmAuTAC-y-Sm04FZPA@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] vduse: add vq group asid support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	Maxime Coquelin <mcoqueli@redhat.com>, Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qeSMkK0_0ajj1TBiEiwLg-zV_Tir3oZaOCx1rVSjFtg_1763081734
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 7:56=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> group.  This enables mapping each group into a distinct memory space.
>
> Now that the driver can change ASID in the middle of operation, the
> domain that each vq address point is also protected by domain_lock.

Maybe it's better to document what is protected by RCU and how.

More below.

>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v9:
> * Replace mutex with RCU, as the vdpa map_ops can run from atomic
>   context.
>
> v8:
> * Revert the mutex to rwlock change, it needs proper profiling to
>   justify it.
>
> v7:
> * Take write lock in the error path (Jason).
>
> v6:
> * Make vdpa_dev_add use gotos for error handling (MST).
> * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VERSION_1) ?/
>   (MST).
> * Fix struct name not matching in the doc.
>
> v5:
> * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET_FD
>   ioctl (Jason).
> * Properly set domain bounce size to divide equally between nas (Jason).
> * Exclude "padding" member from the only >V1 members in
>   vduse_dev_request.
>
> v4:
> * Divide each domain bounce size between the device bounce size (Jason).
> * revert unneeded addr =3D NULL assignment (Jason)
> * Change if (x && (y || z)) return to if (x) { if (y) return; if (z)
>   return; } (Jason)
> * Change a bad multiline comment, using @ caracter instead of * (Jason).
> * Consider config->nas =3D=3D 0 as a fail (Jason).
>
> v3:
> * Get the vduse domain through the vduse_as in the map functions
>   (Jason).
> * Squash with the patch creating the vduse_as struct (Jason).
> * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic number
>   (Jason)
>
> v2:
> * Convert the use of mutex to rwlock.
>
> RFC v3:
> * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
>   value to reduce memory consumption, but vqs are already limited to
>   that value and userspace VDUSE is able to allocate that many vqs.
> * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
>   VDUSE_IOTLB_GET_INFO.
> * Use of array_index_nospec in VDUSE device ioctls.
> * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> * Move the umem mutex to asid struct so there is no contention between
>   ASIDs.
>
> RFC v2:
> * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
>   part of the struct is the same.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 370 ++++++++++++++++++++---------
>  include/uapi/linux/vduse.h         |  53 ++++-
>  2 files changed, 314 insertions(+), 109 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 97be04f73fbf..ff95ed56f22d 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -11,6 +11,7 @@
>  #include "linux/virtio_net.h"
>  #include <linux/init.h>
>  #include <linux/module.h>
> +#include <linux/rcupdate.h>
>  #include <linux/cdev.h>
>  #include <linux/device.h>
>  #include <linux/eventfd.h>
> @@ -41,6 +42,7 @@
>
>  #define VDUSE_DEV_MAX (1U << MINORBITS)
>  #define VDUSE_DEV_MAX_GROUPS 0xffff
> +#define VDUSE_DEV_MAX_AS 0xffff
>  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
>  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
>  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> @@ -86,7 +88,14 @@ struct vduse_umem {
>         struct mm_struct *mm;
>  };
>
> +struct vduse_as {
> +       struct vduse_iova_domain *domain;
> +       struct vduse_umem *umem;
> +       struct mutex mem_lock;
> +};
> +
>  struct vduse_vq_group {
> +       struct vduse_as *as __rcu;
>         struct vduse_dev *dev;
>  };
>
> @@ -94,7 +103,7 @@ struct vduse_dev {
>         struct vduse_vdpa *vdev;
>         struct device *dev;
>         struct vduse_virtqueue **vqs;
> -       struct vduse_iova_domain *domain;
> +       struct vduse_as *as;
>         char *name;
>         struct mutex lock;
>         spinlock_t msg_lock;
> @@ -122,9 +131,8 @@ struct vduse_dev {
>         u32 vq_num;
>         u32 vq_align;
>         u32 ngroups;
> -       struct vduse_umem *umem;
> +       u32 nas;
>         struct vduse_vq_group *groups;
> -       struct mutex mem_lock;
>         unsigned int bounce_size;
>         struct mutex domain_lock;
>  };
> @@ -314,7 +322,7 @@ static int vduse_dev_set_status(struct vduse_dev *dev=
, u8 status)
>         return vduse_dev_msg_sync(dev, &msg);
>  }
>
> -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
>                                   u64 start, u64 last)
>  {
>         struct vduse_dev_msg msg =3D { 0 };
> @@ -323,8 +331,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev *=
dev,
>                 return -EINVAL;
>
>         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> -       msg.req.iova.start =3D start;
> -       msg.req.iova.last =3D last;
> +       if (dev->api_version < VDUSE_API_VERSION_1) {
> +               msg.req.iova.start =3D start;
> +               msg.req.iova.last =3D last;
> +       } else {
> +               msg.req.iova_v2.start =3D start;
> +               msg.req.iova_v2.last =3D last;
> +               msg.req.iova_v2.asid =3D asid;
> +       }
>
>         return vduse_dev_msg_sync(dev, &msg);
>  }
> @@ -436,14 +450,32 @@ static __poll_t vduse_dev_poll(struct file *file, p=
oll_table *wait)
>         return mask;
>  }
>
> +/* Force set the asid to a vq group without a message to the VDUSE devic=
e */
> +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> +                                      unsigned int group, unsigned int a=
sid)
> +{
> +       /*
> +        * Two concurrent updates to this pointer are valid as they canno=
t
> +        * point to an invalid region.  It is ok for them to race as long=
 as
> +        * the readers see a consistent state through RCU.
> +        */
> +       rcu_assign_pointer(dev->groups[group].as, &dev->as[asid]);

I'd expect at least a synchronize_rcu() here to wait for the read is done?

> +}
> +
>  static void vduse_dev_reset(struct vduse_dev *dev)
>  {
>         int i;
> -       struct vduse_iova_domain *domain =3D dev->domain;
>
>         /* The coherent mappings are handled in vduse_dev_free_coherent()=
 */
> -       if (domain && domain->bounce_map)
> -               vduse_domain_reset_bounce_map(domain);
> +       for (i =3D 0; i < dev->nas; i++) {
> +               struct vduse_iova_domain *domain =3D dev->as[i].domain;
> +
> +               if (domain && domain->bounce_map)
> +                       vduse_domain_reset_bounce_map(domain);
> +       }
> +
> +       for (i =3D 0; i < dev->ngroups; i++)
> +               vduse_set_group_asid_nomsg(dev, i, 0);
>
>         down_write(&dev->rwsem);
>
> @@ -623,6 +655,29 @@ static union virtio_map vduse_get_vq_map(struct vdpa=
_device *vdpa, u16 idx)
>         return ret;
>  }
>
> +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned int g=
roup,
> +                               unsigned int asid)
> +{
> +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> +       struct vduse_dev_msg msg =3D { 0 };
> +       int r;
> +
> +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> +           group >=3D dev->ngroups || asid >=3D dev->nas)
> +               return -EINVAL;
> +
> +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> +       msg.req.vq_group_asid.group =3D group;
> +       msg.req.vq_group_asid.asid =3D asid;
> +
> +       r =3D vduse_dev_msg_sync(dev, &msg);
> +       if (r < 0)
> +               return r;
> +
> +       vduse_set_group_asid_nomsg(dev, group, asid);
> +       return 0;
> +}
> +
>  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
>                                 struct vdpa_vq_state *state)
>  {
> @@ -794,13 +849,13 @@ static int vduse_vdpa_set_map(struct vdpa_device *v=
dpa,
>         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
>         int ret;
>
> -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb);
>         if (ret)
>                 return ret;
>
> -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
>         if (ret) {
> -               vduse_domain_clear_map(dev->domain, iotlb);
> +               vduse_domain_clear_map(dev->as[asid].domain, iotlb);
>                 return ret;
>         }
>
> @@ -843,6 +898,7 @@ static const struct vdpa_config_ops vduse_vdpa_config=
_ops =3D {
>         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
>         .reset                  =3D vduse_vdpa_reset,
>         .set_map                =3D vduse_vdpa_set_map,
> +       .set_group_asid         =3D vduse_set_group_asid,
>         .get_vq_map             =3D vduse_get_vq_map,
>         .free                   =3D vduse_vdpa_free,
>  };
> @@ -852,14 +908,17 @@ static void vduse_dev_sync_single_for_device(union =
virtio_map token,
>                                              enum dma_data_direction dir)
>  {
>         struct vduse_dev *vdev;
> +       struct vduse_as *as;
>         struct vduse_iova_domain *domain;
>
>         if (!token.group)
>                 return;
>
>         vdev =3D token.group->dev;
> -       domain =3D vdev->domain;
> -
> +       rcu_read_lock();
> +       as =3D rcu_dereference(token.group->as);
> +       domain =3D as->domain;
> +       rcu_read_unlock();
>         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);

This is suspicious, at least we should do rcu_read_unlock() after
vduse_domain_sync_single_for_device(), otherwise I don't see how RCU
works.

>  }
>
> @@ -868,14 +927,17 @@ static void vduse_dev_sync_single_for_cpu(union vir=
tio_map token,
>                                              enum dma_data_direction dir)
>  {
>         struct vduse_dev *vdev;
> +       struct vduse_as *as;
>         struct vduse_iova_domain *domain;
>
>         if (!token.group)
>                 return;
>
>         vdev =3D token.group->dev;
> -       domain =3D vdev->domain;
> -
> +       rcu_read_lock();
> +       as =3D rcu_dereference(token.group->as);
> +       domain =3D as->domain;
> +       rcu_read_unlock();
>         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
>  }
>
> @@ -885,15 +947,21 @@ static dma_addr_t vduse_dev_map_page(union virtio_m=
ap token, struct page *page,
>                                      unsigned long attrs)
>  {
>         struct vduse_dev *vdev;
> +       struct vduse_as *as;
>         struct vduse_iova_domain *domain;
> +       dma_addr_t r;
>
>         if (!token.group)
>                 return DMA_MAPPING_ERROR;
>
>         vdev =3D token.group->dev;
> -       domain =3D vdev->domain;
> +       rcu_read_lock();
> +       as =3D rcu_dereference(token.group->as);
> +       domain =3D as->domain;
> +       rcu_read_unlock();
> +       r =3D vduse_domain_map_page(domain, page, offset, size, dir, attr=
s);

Same here.

Thanks

