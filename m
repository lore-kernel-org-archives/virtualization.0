Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089202FA0C7
	for <virtualization@lists.linux.dev>; Mon,  8 Sep 2025 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333556; cv=none; b=AujDyy9uNu1IA7MO7eUL4P2pxaW47uUoxRml9xqqJ7nEqjs60yff3R+sC/wabLOjr3dAEbkxbenTHEkRuvp0tcKzSC2vDwVqPA0wgaUrbTd+c01y30HBb1cxaZVZL+W0oclMzzgMBXgB/xxEP9PN75+wBMiagSRV9A3NcK31W1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333556; c=relaxed/simple;
	bh=otFOLS41MOzeOmIi5Qj4erstUXuYLgtkMaxX1Oi9Z/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRbC/orjG/bjW9FOSPyCJk0+hTlhXbCuTOq1UQPswCZMHbDkxhGT6coFv3r05YKRoe6iO0AjvHE4k2RBPlsccmIQZY0XKGp2qccJ7VF+TgxixO/PoSRq0AK3Ut9ia+mXgHNC1UyYuxTQWXa5xuFGGJ7A63T/JMHaUKVNQhriNl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Hi+YuKvo; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Hi+YuKvo"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4cb3367d87so2832554a12.3
        for <virtualization@lists.linux.dev>; Mon, 08 Sep 2025 05:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757333553; x=1757938353; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeeAbZ1EiDBRybQL5hHr70oeFHubNRnYbaFSvRYvGpY=;
        b=Hi+YuKvoJk3LrrgEWsptmWqI2vd+7/6y3lzJARvDt4wIKSTYCO72I16NIUfjraTLQh
         SoNUfn/2i78eK/iKN+Jm8fTx5mtxV+qTsJWUzKY2XT5vfQ9QF1LU7naxMeqjOF0y25ep
         /Z/kFTzey+1iGluYw0Z30CSe+UF6rSmm/PCo+Rflezc7PhCh8CIuBxIONNhyHEMecaj3
         JYo5Jsys4wlEz2PpVUKfuimtOmq1WDtdteIRe3pi5TpD8NxtcUqgQw+YF3kNxBZlEpl+
         v7ylbSEFlZROtyxZ2B5O114WW5c3LP0+ZZpZqhDwOIbgPRch/Xz0/9PecgD1UttV66XL
         /1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333553; x=1757938353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeeAbZ1EiDBRybQL5hHr70oeFHubNRnYbaFSvRYvGpY=;
        b=tY4xl5pS8SskULsjic9Y6FkE/fCbV9cMz4D84/7fOgSrlmz5wluMCOyEHo7AI56qWp
         VwXIsvPM+VZHWWg/4w3sA7K3kXSdicUNxomniwy4bTvEnWf0t4AkaqneKLiIbdvNLAaZ
         xdlszmgdtSGVbJT0p0GdBkuabWm+/DXvHTXoXEr+EU0dZsqBAr/CZ/1J3a44xwIIR5mi
         yyEVt7ef9XRYMkfs2ZNDlnEDCPa4hco/e2oqYFUTxyp8la/I0827zXMc/4W9rN1Su9cq
         JuZrbPb475ecBgV/rTdfteHQv35OtVA8OrjBEJslseMkHJmSc5eTxjBcY22KccjsHIfe
         fkkA==
X-Forwarded-Encrypted: i=1; AJvYcCUbZU2IGEgOYvR8yeTadYuSfXWlWCkhbs2L2YCcbxghhZ51PZUHNvARrNoilccNxhKzgvPux3a8B64pBPwMGw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwctaShJv0bZ1r/GbLf5kzsrj4nDgcBGUdisIIE8M9AEUGgJo7p
	UFkwnR2+SuptS3JoPN1I8SWZ2JUUSh/UYiKwwBJuI5+4K7IZqizPTWCtXMftGmSGIq3GkVi+Vih
	07Pw4s1cUTEuwfA8uxXxtHQ5QkUP/iC9BYK+ly1rl
X-Gm-Gg: ASbGncv0LsDS/TmSNYCe8nas4ZEMCOhgw3JtlS0DL4GR1ITP+t5WsGWHV1cLXWAmT7n
	P7fsDdXNcLgz0xFiFZHUsWAs19E9XoynzKe8896+y16l1KxLDPGbKP7AOY5GvzGzzsVHq4gCbSO
	Bh17XnJ463v9Zu/2w8usmw4kD6ppzmXR8O4su5vIKtc+TsCCt+TJT/fLfgUqRpxsam4jq9xV7eq
	UZkotY7PF1OlVEdAUAH3qgW+FVD2pdvhOaZ
X-Google-Smtp-Source: AGHT+IGx6pmzghjPqFgsVQmVTkwwTtz5N4DB6EsXhw7FXgcknmkdSOnhkpnsWHjBZ6c8uUIRX/mbOCTyucBTce3hJUQ=
X-Received: by 2002:a17:902:cf04:b0:24a:8e36:420a with SMTP id
 d9443c01a7336-25172291ecdmr99814645ad.40.1757333553153; Mon, 08 Sep 2025
 05:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-6-eperezma@redhat.com>
In-Reply-To: <20250826112709.1051172-6-eperezma@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 8 Sep 2025 20:12:20 +0800
X-Gm-Features: Ac12FXzQHka_VYKIEEmUPWsxhC3NsQ2ds4URqALiW1y4mZc2t3dSHUvk0HNuFtc
Message-ID: <CACycT3v=_Nm6fefJGFEyoU+Xf5G=Kzi0sXhhaBHnJQZcG-4EqA@mail.gmail.com>
Subject: Re: [PATCH 5/6] vduse: add vq group asid support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, Jason Wang <jasowang@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eugenio,

On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> group.  This enables mapping each group into a distinct memory space.
>
> Now that the driver can change ASID in the middle of operation, the
> domain that each vq address point is also protected by domain_lock.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v3:
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
> v2:
> * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
>   part of the struct is the same.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 290 +++++++++++++++++++++--------
>  include/uapi/linux/vduse.h         |  52 +++++-
>  2 files changed, 259 insertions(+), 83 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 7d2a3ed77b1e..2fb227713972 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -92,6 +92,7 @@ struct vduse_as {
>  };
>
>  struct vduse_vq_group_int {
> +       struct vduse_iova_domain *domain;
>         struct vduse_dev *dev;
>  };
>
> @@ -99,7 +100,7 @@ struct vduse_dev {
>         struct vduse_vdpa *vdev;
>         struct device *dev;
>         struct vduse_virtqueue **vqs;
> -       struct vduse_as as;
> +       struct vduse_as *as;
>         char *name;
>         struct mutex lock;
>         spinlock_t msg_lock;
> @@ -127,6 +128,7 @@ struct vduse_dev {
>         u32 vq_num;
>         u32 vq_align;
>         u32 ngroups;
> +       u32 nas;
>         struct vduse_vq_group_int *groups;
>         unsigned int bounce_size;
>         struct mutex domain_lock;
> @@ -317,7 +319,7 @@ static int vduse_dev_set_status(struct vduse_dev *dev=
, u8 status)
>         return vduse_dev_msg_sync(dev, &msg);
>  }
>
> -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
>                                   u64 start, u64 last)
>  {
>         struct vduse_dev_msg msg =3D { 0 };
> @@ -326,8 +328,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev *=
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
> @@ -439,14 +447,28 @@ static __poll_t vduse_dev_poll(struct file *file, p=
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
> +       guard(mutex)(&dev->domain_lock);
> +       dev->groups[group].domain =3D dev->as[asid].domain;
> +}
> +
>  static void vduse_dev_reset(struct vduse_dev *dev)
>  {
>         int i;
> -       struct vduse_iova_domain *domain =3D dev->as.domain;
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
> @@ -620,6 +642,29 @@ static union virtio_map vduse_get_vq_map(struct vdpa=
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
> @@ -818,13 +863,13 @@ static int vduse_vdpa_set_map(struct vdpa_device *v=
dpa,
>         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
>         int ret;
>
> -       ret =3D vduse_domain_set_map(dev->as.domain, iotlb);
> +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb);
>         if (ret)
>                 return ret;
>
> -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
>         if (ret) {
> -               vduse_domain_clear_map(dev->as.domain, iotlb);
> +               vduse_domain_clear_map(dev->as[asid].domain, iotlb);
>                 return ret;
>         }
>
> @@ -867,6 +912,7 @@ static const struct vdpa_config_ops vduse_vdpa_config=
_ops =3D {
>         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
>         .reset                  =3D vduse_vdpa_reset,
>         .set_map                =3D vduse_vdpa_set_map,
> +       .set_group_asid         =3D vduse_set_group_asid,
>         .get_vq_map             =3D vduse_get_vq_map,
>         .free                   =3D vduse_vdpa_free,
>  };
> @@ -876,8 +922,10 @@ static void vduse_dev_sync_single_for_device(union v=
irtio_map token,
>                                              enum dma_data_direction dir)
>  {
>         struct vduse_dev *vdev =3D token.group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> +       struct vduse_iova_domain *domain;
>
> +       guard(mutex)(&vdev->domain_lock);
> +       domain =3D token.group->domain;
>         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
>  }
>
> @@ -886,8 +934,10 @@ static void vduse_dev_sync_single_for_cpu(union virt=
io_map token,
>                                              enum dma_data_direction dir)
>  {
>         struct vduse_dev *vdev =3D token.group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> +       struct vduse_iova_domain *domain;
>
> +       guard(mutex)(&vdev->domain_lock);
> +       domain =3D token.group->domain;
>         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
>  }
>
> @@ -897,8 +947,10 @@ static dma_addr_t vduse_dev_map_page(union virtio_ma=
p token, struct page *page,
>                                      unsigned long attrs)
>  {
>         struct vduse_dev *vdev =3D token.group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> +       struct vduse_iova_domain *domain;
>
> +       guard(mutex)(&vdev->domain_lock);

Won't this mutex lock hurt the performance? Can we use rw_lock/rcu_lock ins=
tead?

Thanks,
Yongji
