Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1C62FFF88
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098219; cv=none; b=jaypT5FPJMhKSIQ/Y9PhSYRGI+eHjmMTeyVlUBdKsnc9pJv2Xm3PR2+rQXCxqTdaw+FmsHwNQi9wsXTinPNssAfaSuuHAo6nPJEIBDigywRTftOrZMBxDg9fcINzly6DXP/GHxwLx17eHNfwl2tW7YsK9BdKh3tTbn/Y6JYAbbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098219; c=relaxed/simple;
	bh=mtdwjpppQuMYOYtHvgA3BLkqkWiPCjQmZHjBoBL53Qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBPRQYS0ZYY394SKdK2BfWT4cD1lzmDZ/jZxuVyzK/Q8VraLxrHBhoEv/3EAdhTqMFSShPlN2FLYRUP1cMlNb9BZhU+1gB4sT8EC9CLgyieXIc5JRWdvh+Q4cbT83Cudlco/DOxYfIHWNDdtU3j5CCfxoqM/ZSWAYWTUjyKn8fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GO9SSFq5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GO9SSFq5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758098217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZO090sKfTZEMJYwRNikVJVW8jUDpl6sZ6AO04VdsuYE=;
	b=GO9SSFq5qVMWi4eNnk+5uISJME6bdqEFjsor5efQuKzv+8O2lv158Ii1vPAWoWtxfnCoZP
	rH3hdkmwKxfNBayw+x2ZLoCZ8tniP06vpjkbCosmpd39BURX0G5zKa9Ww8OfVM5LrzO+ev
	DG5jluGiLHw0h3mR6vtp6qI3KZBBmSY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-8VNAlhTgNyCQUnNLu_nLlg-1; Wed, 17 Sep 2025 04:36:55 -0400
X-MC-Unique: 8VNAlhTgNyCQUnNLu_nLlg-1
X-Mimecast-MFC-AGG-ID: 8VNAlhTgNyCQUnNLu_nLlg_1758098215
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b471737e673so8191285a12.1
        for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 01:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098214; x=1758703014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZO090sKfTZEMJYwRNikVJVW8jUDpl6sZ6AO04VdsuYE=;
        b=EanP/+9K/zp5kLnsoAR3ruQhLCoJT4amgEJ96yDrN5wTwi+rj3AMRLc9fgpZo+pLLk
         iuLBmAKOtxBGZhJGeb4f9JdIu8LpBzhGAsB04Q/5Rbh+QGQobuGbgNuUQcXokrTtak+H
         zKCJRfj5tCOq65VCGuGHJFsJsyetCajvfINs8Tftgw5fl4zk7lIUYHAa9fkrPpwQmzSC
         TeLfOcfXtZB1wSHhkiH6NXpVD1GSIK4sGhwHFuacVN3Z27kJToQY2qx3f6rUyRrT/GhN
         salvAvQdbttTD0N4IBNCrG2kmpg9GhY5pXZPEhbIk+bwjCs44UXz8LlZ7NurwOiGneMX
         I64w==
X-Forwarded-Encrypted: i=1; AJvYcCUt/EUDzXLL3NbRCxyoNxA49dc8r1DMCpWvQIRqiIKZ6cmg03MYE4+0popBNvrBtYzvIBo/SbnGj/KfGhQVWw==@lists.linux.dev
X-Gm-Message-State: AOJu0YylT7F5F+Eaj6p4jrOn7d62XuCkWw0IHIFDJVQygMOKnKn9+BI6
	+q1U9MgkK+2M0jNmvTLhKGD5ZL0y73eapaRVzjXC2aLwcrBuRw6oDEj67O9HynQrpp6NJyC9AkM
	ABGetfxT1nSjZ8R0NDlYHqWLMdNALK8ePc2i4P3Hrjljdr1VbOXq0v7QIqU0tTQLqOr1HgIHHwI
	sqfuLC+nN8U2zAFpLZmg+zF3Xydjjb/V3UJoYip2H6PmIZnCMO66OKxg==
X-Gm-Gg: ASbGnctqNYQ0wwU3/hu7BTR9zJBdDlmrr5eNDho/WeIVe1OUGYxjJBfrN190IfdwRkO
	+x9vKB7EWDDCiVHC+vY5fwsYUfoRLLEKi/40Q+UATdGbHQI9cC/vOaq1mNL4AwMgjxQvtz6mulA
	CeW8GjMTWvD+SG3p3YbQ==
X-Received: by 2002:a05:6a20:3d05:b0:243:b3e2:ca07 with SMTP id adf61e73a8af0-27ab81613efmr1868863637.58.1758098214239;
        Wed, 17 Sep 2025 01:36:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGob8kyHak87Gd1ib5FpUZgzKA2iunl8JSl9iFDu6+BKTmDjmymMDjhF+A303gZi84HYTtXhb58wiGpAb9YSaM=
X-Received: by 2002:a05:6a20:3d05:b0:243:b3e2:ca07 with SMTP id
 adf61e73a8af0-27ab81613efmr1868818637.58.1758098213766; Wed, 17 Sep 2025
 01:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-3-eperezma@redhat.com>
In-Reply-To: <20250916130833.329087-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Sep 2025 16:36:42 +0800
X-Gm-Features: AS18NWBP8Pwo30SbuEqdrKv5Y0rlJF8L0BtuNswrz5Nzc-YpJTlgxpRv6bDffgo
Message-ID: <CACGkMEsNTtD9nc7dRi9LH4jwh37kXQgM2WjbJfoz-MsHFe750Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] vduse: make domain_lock an rwlock
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DnkTzQm0wPUNZ_Wl8ygmPn5bqpDBD8edcKPBKIRd1pw_1758098215
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:08=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> It will be used in a few more scenarios read-only so make it more
> scalable.
>
> Suggested-by: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
> v2: New in v2
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 41 +++++++++++++++---------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index e7bced0b5542..2b6a8958ffe0 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -14,6 +14,7 @@
>  #include <linux/cdev.h>
>  #include <linux/device.h>
>  #include <linux/eventfd.h>
> +#include <linux/rwlock.h>
>  #include <linux/slab.h>
>  #include <linux/wait.h>
>  #include <linux/dma-map-ops.h>
> @@ -117,7 +118,7 @@ struct vduse_dev {
>         struct vduse_umem *umem;
>         struct mutex mem_lock;
>         unsigned int bounce_size;
> -       struct mutex domain_lock;
> +       rwlock_t domain_lock;
>  };
>
>  struct vduse_dev_msg {
> @@ -1176,9 +1177,9 @@ static long vduse_dev_ioctl(struct file *file, unsi=
gned int cmd,
>                 if (entry.start > entry.last)
>                         break;
>
> -               mutex_lock(&dev->domain_lock);
> +               read_lock(&dev->domain_lock);
>                 if (!dev->domain) {
> -                       mutex_unlock(&dev->domain_lock);
> +                       read_unlock(&dev->domain_lock);
>                         break;
>                 }
>                 spin_lock(&dev->domain->iotlb_lock);
> @@ -1193,7 +1194,7 @@ static long vduse_dev_ioctl(struct file *file, unsi=
gned int cmd,
>                         entry.perm =3D map->perm;
>                 }
>                 spin_unlock(&dev->domain->iotlb_lock);
> -               mutex_unlock(&dev->domain_lock);
> +               read_unlock(&dev->domain_lock);
>                 ret =3D -EINVAL;
>                 if (!f)
>                         break;
> @@ -1346,10 +1347,10 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
>                                  sizeof(umem.reserved)))
>                         break;
>
> -               mutex_lock(&dev->domain_lock);
> +               write_lock(&dev->domain_lock);
>                 ret =3D vduse_dev_reg_umem(dev, umem.iova,
>                                          umem.uaddr, umem.size);
> -               mutex_unlock(&dev->domain_lock);
> +               write_unlock(&dev->domain_lock);
>                 break;
>         }
>         case VDUSE_IOTLB_DEREG_UMEM: {
> @@ -1363,10 +1364,10 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
>                 if (!is_mem_zero((const char *)umem.reserved,
>                                  sizeof(umem.reserved)))
>                         break;
> -               mutex_lock(&dev->domain_lock);
> +               write_lock(&dev->domain_lock);
>                 ret =3D vduse_dev_dereg_umem(dev, umem.iova,
>                                            umem.size);
> -               mutex_unlock(&dev->domain_lock);
> +               write_unlock(&dev->domain_lock);
>                 break;
>         }
>         case VDUSE_IOTLB_GET_INFO: {
> @@ -1385,9 +1386,9 @@ static long vduse_dev_ioctl(struct file *file, unsi=
gned int cmd,
>                                  sizeof(info.reserved)))
>                         break;
>
> -               mutex_lock(&dev->domain_lock);
> +               read_lock(&dev->domain_lock);
>                 if (!dev->domain) {
> -                       mutex_unlock(&dev->domain_lock);
> +                       read_unlock(&dev->domain_lock);
>                         break;
>                 }
>                 spin_lock(&dev->domain->iotlb_lock);
> @@ -1402,7 +1403,7 @@ static long vduse_dev_ioctl(struct file *file, unsi=
gned int cmd,
>                                 info.capability |=3D VDUSE_IOVA_CAP_UMEM;
>                 }
>                 spin_unlock(&dev->domain->iotlb_lock);
> -               mutex_unlock(&dev->domain_lock);
> +               read_unlock(&dev->domain_lock);
>                 if (!map)
>                         break;
>
> @@ -1425,10 +1426,10 @@ static int vduse_dev_release(struct inode *inode,=
 struct file *file)
>  {
>         struct vduse_dev *dev =3D file->private_data;
>
> -       mutex_lock(&dev->domain_lock);
> +       write_lock(&dev->domain_lock);
>         if (dev->domain)
>                 vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
> -       mutex_unlock(&dev->domain_lock);
> +       write_unlock(&dev->domain_lock);
>         spin_lock(&dev->msg_lock);
>         /* Make sure the inflight messages can processed after reconncect=
ion */
>         list_splice_init(&dev->recv_list, &dev->send_list);
> @@ -1647,7 +1648,7 @@ static struct vduse_dev *vduse_dev_create(void)
>
>         mutex_init(&dev->lock);
>         mutex_init(&dev->mem_lock);
> -       mutex_init(&dev->domain_lock);
> +       rwlock_init(&dev->domain_lock);
>         spin_lock_init(&dev->msg_lock);
>         INIT_LIST_HEAD(&dev->send_list);
>         INIT_LIST_HEAD(&dev->recv_list);
> @@ -1805,7 +1806,7 @@ static ssize_t bounce_size_store(struct device *dev=
ice,
>         int ret;
>
>         ret =3D -EPERM;
> -       mutex_lock(&dev->domain_lock);
> +       write_lock(&dev->domain_lock);
>         if (dev->domain)
>                 goto unlock;
>
> @@ -1821,7 +1822,7 @@ static ssize_t bounce_size_store(struct device *dev=
ice,
>         dev->bounce_size =3D bounce_size & PAGE_MASK;
>         ret =3D count;
>  unlock:
> -       mutex_unlock(&dev->domain_lock);
> +       write_unlock(&dev->domain_lock);
>         return ret;
>  }
>
> @@ -2045,11 +2046,11 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
>         if (ret)
>                 return ret;
>
> -       mutex_lock(&dev->domain_lock);
> +       write_lock(&dev->domain_lock);
>         if (!dev->domain)
>                 dev->domain =3D vduse_domain_create(VDUSE_IOVA_SIZE - 1,
>                                                   dev->bounce_size);
> -       mutex_unlock(&dev->domain_lock);
> +       write_unlock(&dev->domain_lock);
>         if (!dev->domain) {
>                 put_device(&dev->vdev->vdpa.dev);
>                 return -ENOMEM;
> @@ -2059,10 +2060,10 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
>         ret =3D _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
>         if (ret) {
>                 put_device(&dev->vdev->vdpa.dev);
> -               mutex_lock(&dev->domain_lock);
> +               write_lock(&dev->domain_lock);
>                 vduse_domain_destroy(dev->domain);
>                 dev->domain =3D NULL;
> -               mutex_unlock(&dev->domain_lock);
> +               write_unlock(&dev->domain_lock);
>                 return ret;
>         }
>
> --
> 2.51.0
>

