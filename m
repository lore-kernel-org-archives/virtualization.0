Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4EB33B6EF
	for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 08:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768466486; cv=none; b=u3cHeTV66jleV91oIoc8i40fXK5fiibPs1MmAfxAAvEtEw9TgqHDD/WFe2jr7GYtR5QjmZXgnDvCbYcVsMqrCR1hjZKyWmjrGt12QiDf5oJ8BVtQRxY2nDNDCqLS9gZzJVJP/GCWbTPc9qLZEUiR8Nr+eLK5Up92BK47YcixqEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768466486; c=relaxed/simple;
	bh=0ouT9psk1v2Oe8x1k3HrmuaESMnKKctOZhFt4yWr3yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBcInj08OfkPAIZeb8Uki0SNwJ92TcvU7A8WyWSs8EShF+zgd7ZrxARXN6AuuuIcUjbHwXubPpl0tO/IF7mdeKjtbTPpYlXPfYGaUmos1ir+nNX1qNg1YP04LbfMjxRPcMzdttXyQuQVDwq8vhqyX0NROwh8N+3fL10PKUePkMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=faX1hlVZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faX1hlVZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768466483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ujr2ET+58t5RreQaQHFcb7TeEOJBjqlT12t+CxC37CI=;
	b=faX1hlVZ20m+WFS55z+9VrVHXXdtS9GpCpcUMtYM5l+C8ZwUkDkBnM6sUzvCZsqADLkKZA
	EPpQGS9Fb9uQ/aHhFq5G9llYjJYh+vF6jLkRkDdMi89pTmyjW9vdDy5x39xciu4tKsABh+
	e4NltIUS8vzgXGLE883fTE3aEuJqpIo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-lF6xAgUpNni7xevJwh6buQ-1; Thu, 15 Jan 2026 03:41:21 -0500
X-MC-Unique: lF6xAgUpNni7xevJwh6buQ-1
X-Mimecast-MFC-AGG-ID: lF6xAgUpNni7xevJwh6buQ_1768466481
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f25a008dbso5126835ad.1
        for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 00:41:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466481; x=1769071281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ujr2ET+58t5RreQaQHFcb7TeEOJBjqlT12t+CxC37CI=;
        b=VxIQXKAtXCygvPXVGOjTz8xTNSvBhB8kzzt6kjzx/gAMUE3LIlo0MgkuqTs2CVqYmf
         y+LBBuwz0A8EHr/DNSgeBpxuJ+M/zurGEJyCUz+v1ryoXfWfNMlaSiH/f0wKuS2NAkJ+
         MTfl8b0qLPh6YwHFDbN6fcIEtyKHW0OU1dWwx1yumvEZ1ncslrs6tulAC8BDjQx0jJyy
         gpT/LFrixklKHVdNRPiIYDRNkpXeTQcyRaYs8gquuC2h6BQfhK9m7Gv+ecPbzCkRWL6p
         Mk0fTkszXWcUH7AqTQ/foJud3H0zxIduqss6QPA6X81M2km/1Y6V4yrZvlskLHHd8unp
         XWpQ==
X-Forwarded-Encrypted: i=1; AJvYcCViDqWXSw37y54pjSbDnLUDxkAT5YxQBqCVhhglyYer6YA4ZUKdQ/LVA4cADfY/ci74SRFOQM2FgPRL2+TrEw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjkNtv6SQttStZccM1hMI3nGwb+Q2/ZrL2mkubsqdSshAnZZzO
	AEu3ix6Z+Xp1CkMTq/FalbJIa41CP9u9bqcmXYBf/EiaMLBTBzcLi8EHQCkZBhl3rkluuh4Ihr/
	JQXkdUdRywKebi38Ri6adSAGCQnTpx2b4/3ex+/33ZmR/TE1SXyIvVowkdIFx60TrJFokTQPtPH
	Dt3fuYwIhhaXdpJV8+kExU3RB99Itva0plJIHvXeG6YNQ=
X-Gm-Gg: AY/fxX50SUd/rzx8vughqrYcUMcFuE8oxU6mpx2qDPDzDvsORq5BCvFUAgJLmDr2SXB
	BLxYo2VplU/LVWsBK9BIpEqlDeURgaCfObO6QMc9bwCSCEvONECUVTo7Txy+GCFbqKBZ0hFDSqR
	oqm32nBYcmWcU8DmF8A6gcpL7fBIm7+Dpp1atdK5tNj+QxkHZscQDEeKkw/60VEIE4h6s=
X-Received: by 2002:a17:903:19e7:b0:29e:1415:df95 with SMTP id d9443c01a7336-2a599e5c08cmr49817965ad.51.1768466480579;
        Thu, 15 Jan 2026 00:41:20 -0800 (PST)
X-Received: by 2002:a17:903:19e7:b0:29e:1415:df95 with SMTP id
 d9443c01a7336-2a599e5c08cmr49817645ad.51.1768466480012; Thu, 15 Jan 2026
 00:41:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260114184839.926884-1-eperezma@redhat.com> <20260114184839.926884-12-eperezma@redhat.com>
In-Reply-To: <20260114184839.926884-12-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 15 Jan 2026 16:41:05 +0800
X-Gm-Features: AZwV_QhiDgiSfqR-QKw0a45ntZPyjf5-h0H5Evt6j7I5zs14pt8g01HwuGNEEpE
Message-ID: <CACGkMEtUv7Kge4A6rcSSiVu4moi5vSNU97pQ7_LiUmprOb0wBw@mail.gmail.com>
Subject: Re: [PATCH v12 11/13] vduse: add vq group asid support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oTVB8ECLzDFi4i5IEaK5xeURrEuAtmlXYVxy-gjDVXE_1768466481
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 2:49=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> group.  This enables mapping each group into a distinct memory space.
>
> The vq group to ASID association is protected by a rwlock now.  But the
> mutex domain_lock keeps protecting the domains of all ASIDs, as some
> operations like the one related with the bounce buffer size still
> requires to lock all the ASIDs.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> ---
> Future improvements can include performance optimizations on top like
> ore to RCU or thread synchronized atomics, or hardening by tracking ASID
> or ASID hashes on unused bits of the DMA address.
>
> Tested virtio_vdpa by adding manually two threads in vduse_set_status:
> one of them modifies the vq group 0 ASID and the other one map and unmap
> memory continuously.  After a while, the two threads stop and the usual
> work continues.  Test with version 0, version 1 with the old ioctl, and
> version 1 with the new ioctl.
>
> Tested with vhost_vdpa by migrating a VM while ping on OVS+VDUSE.  A few
> workaround were needed in some parts:
> * Do not enable CVQ before data vqs in QEMU, as VDUSE does not forward
>   the enable message to the userland device.  This will be solved in the
>   future.
> * Share the suspended state between all vhost devices in QEMU:
>   https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg02947.html
> * Implement a fake VDUSE suspend vdpa operation callback that always
>   returns true in the kernel.  DPDK suspend the device at the first
>   GET_VRING_BASE.
> * Remove the CVQ blocker in ASID.
>
> The driver vhost_vdpa was also tested with version 0, version 1 with the
> old ioctl, version 1 with the new ioctl but only one ASID, and version 1
> with many ASID.
>
> ---
> v12:
> * Using scoped guards for vq group rwlock, so the one queue optimization
>   is not missed (Jason proposed to factor them into helpers).
> * Add the _v2 suffix to vduse_iova_range_v2 struct name fixing the doc
>   (MST).
> * s/verion/version/ in patch message.
> * Remove trailing ; after a comment (Jason).
>
> v11:
> * Remove duplicated free_pages_exact in vduse_domain_free_coherent
>   (Jason).
> * Do not take the vq groups lock if nas =3D=3D 1.
> * Do not reset the vq group ASID in vq reset (Jason).  Removed extra
>   function vduse_set_group_asid_nomsg, not needed anymore.
> * Move the vduse_iotlb_entry_v2 argument to a new ioctl, as argument
>   didn't match the previous VDUSE_IOTLB_GET_FD.
> * Move the asid < dev->nas check to vdpa core.
>
> v10:
> * Back to rwlock version so stronger locks are used.
> * Take out allocations from rwlock.
> * Forbid changing ASID of a vq group after DRIVER_OK (Jason)
> * Remove bad fetching again of domain variable in
>   vduse_dev_max_mapping_size (Yongji).
> * Remove unused vdev definition in vdpa map_ops callbacks (kernel test
>   robot).
>
> v9:
> * Replace mutex with rwlock, as the vdpa map_ops can run from atomic
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
>  drivers/vdpa/vdpa_user/vduse_dev.c | 385 +++++++++++++++++++----------
>  include/uapi/linux/vduse.h         |  63 ++++-
>  2 files changed, 312 insertions(+), 136 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index d658f3e1cebf..2727c0c26003 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -9,6 +9,7 @@
>   */
>
>  #include "linux/virtio_net.h"
> +#include <linux/cleanup.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/cdev.h>
> @@ -41,6 +42,7 @@
>
>  #define VDUSE_DEV_MAX (1U << MINORBITS)
>  #define VDUSE_DEV_MAX_GROUPS 0xffff
> +#define VDUSE_DEV_MAX_AS 0xffff
>  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
>  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
>  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> @@ -86,7 +88,15 @@ struct vduse_umem {
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
> +       rwlock_t as_lock;
> +       struct vduse_as *as; /* Protected by as_lock */
>         struct vduse_dev *dev;
>  };
>
> @@ -94,7 +104,7 @@ struct vduse_dev {
>         struct vduse_vdpa *vdev;
>         struct device *dev;
>         struct vduse_virtqueue **vqs;
> -       struct vduse_iova_domain *domain;
> +       struct vduse_as *as;
>         char *name;
>         struct mutex lock;
>         spinlock_t msg_lock;
> @@ -122,9 +132,8 @@ struct vduse_dev {
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
> @@ -314,7 +323,7 @@ static int vduse_dev_set_status(struct vduse_dev *dev=
, u8 status)
>         return vduse_dev_msg_sync(dev, &msg);
>  }
>
> -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
>                                   u64 start, u64 last)
>  {
>         struct vduse_dev_msg msg =3D { 0 };
> @@ -323,8 +332,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev *=
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
> @@ -439,11 +454,14 @@ static __poll_t vduse_dev_poll(struct file *file, p=
oll_table *wait)
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
>
>         down_write(&dev->rwsem);
>
> @@ -622,6 +640,42 @@ static union virtio_map vduse_get_vq_map(struct vdpa=
_device *vdpa, u16 idx)
>         return ret;
>  }
>
> +DEFINE_GUARD(vq_group_as_read_lock, struct vduse_vq_group *,
> +       if (_T->dev->nas > 1)
> +               read_lock(&_T->as_lock),
> +       if (_T->dev->nas > 1)
> +               read_unlock(&_T->as_lock))
> +
> +DEFINE_GUARD(vq_group_as_write_lock, struct vduse_vq_group *,
> +       if (_T->dev->nas > 1)
> +               write_lock(&_T->as_lock),
> +       if (_T->dev->nas > 1)
> +               write_unlock(&_T->as_lock))
> +
> +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned int g=
roup,
> +                               unsigned int asid)
> +{
> +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> +       struct vduse_dev_msg msg =3D { 0 };
> +       int r;
> +
> +       if (dev->api_version < VDUSE_API_VERSION_1)
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
> +       guard(vq_group_as_write_lock)(&dev->groups[group]);
> +       dev->groups[group].as =3D &dev->as[asid];
> +
> +       return 0;
> +}
> +
>  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
>                                 struct vdpa_vq_state *state)
>  {
> @@ -793,13 +847,13 @@ static int vduse_vdpa_set_map(struct vdpa_device *v=
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
> @@ -842,6 +896,7 @@ static const struct vdpa_config_ops vduse_vdpa_config=
_ops =3D {
>         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
>         .reset                  =3D vduse_vdpa_reset,
>         .set_map                =3D vduse_vdpa_set_map,
> +       .set_group_asid         =3D vduse_set_group_asid,
>         .get_vq_map             =3D vduse_get_vq_map,
>         .free                   =3D vduse_vdpa_free,
>  };
> @@ -850,15 +905,13 @@ static void vduse_dev_sync_single_for_device(union =
virtio_map token,
>                                              dma_addr_t dma_addr, size_t =
size,
>                                              enum dma_data_direction dir)
>  {
> -       struct vduse_dev *vdev;
>         struct vduse_iova_domain *domain;
>
>         if (!token.group)
>                 return;
>
> -       vdev =3D token.group->dev;
> -       domain =3D vdev->domain;
> -
> +       guard(vq_group_as_read_lock)(token.group);
> +       domain =3D token.group->as->domain;
>         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
>  }
>
> @@ -866,15 +919,13 @@ static void vduse_dev_sync_single_for_cpu(union vir=
tio_map token,
>                                              dma_addr_t dma_addr, size_t =
size,
>                                              enum dma_data_direction dir)
>  {
> -       struct vduse_dev *vdev;
>         struct vduse_iova_domain *domain;
>
>         if (!token.group)
>                 return;
>
> -       vdev =3D token.group->dev;
> -       domain =3D vdev->domain;
> -
> +       guard(vq_group_as_read_lock)(token.group);
> +       domain =3D token.group->as->domain;
>         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
>  }
>
> @@ -883,15 +934,13 @@ static dma_addr_t vduse_dev_map_page(union virtio_m=
ap token, struct page *page,
>                                      enum dma_data_direction dir,
>                                      unsigned long attrs)
>  {
> -       struct vduse_dev *vdev;
>         struct vduse_iova_domain *domain;
>
>         if (!token.group)
>                 return DMA_MAPPING_ERROR;
>
> -       vdev =3D token.group->dev;
> -       domain =3D vdev->domain;
> -
> +       guard(vq_group_as_read_lock)(token.group);
> +       domain =3D token.group->as->domain;
>         return vduse_domain_map_page(domain, page, offset, size, dir, att=
rs);
>  }
>
> @@ -899,23 +948,19 @@ static void vduse_dev_unmap_page(union virtio_map t=
oken, dma_addr_t dma_addr,
>                                  size_t size, enum dma_data_direction dir=
,
>                                  unsigned long attrs)
>  {
> -       struct vduse_dev *vdev;
>         struct vduse_iova_domain *domain;
>
>         if (!token.group)
>                 return;
>
> -       vdev =3D token.group->dev;
> -       domain =3D vdev->domain;
> -
> -       return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs=
);
> +       guard(vq_group_as_read_lock)(token.group);
> +       domain =3D token.group->as->domain;
> +       vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
>  }
>
>  static void *vduse_dev_alloc_coherent(union virtio_map token, size_t siz=
e,
>                                       dma_addr_t *dma_addr, gfp_t flag)
>  {
> -       struct vduse_dev *vdev;
> -       struct vduse_iova_domain *domain;
>         void *addr;
>
>         *dma_addr =3D DMA_MAPPING_ERROR;
> @@ -926,11 +971,15 @@ static void *vduse_dev_alloc_coherent(union virtio_=
map token, size_t size,
>         if (!addr)
>                 return NULL;
>
> -       vdev =3D token.group->dev;
> -       domain =3D vdev->domain;
> -       *dma_addr =3D vduse_domain_alloc_coherent(domain, size, addr);
> -       if (*dma_addr =3D=3D DMA_MAPPING_ERROR)
> -               goto err;
> +       {
> +               struct vduse_iova_domain *domain;
> +
> +               guard(vq_group_as_read_lock)(token.group);
> +               domain =3D token.group->as->domain;
> +               *dma_addr =3D vduse_domain_alloc_coherent(domain, size, a=
ddr);
> +               if (*dma_addr =3D=3D DMA_MAPPING_ERROR)
> +                       goto err;
> +       }

Nit: Having a standalone block probably means we have the chance to
optimize the code, maybe using a helper?

Thanks

