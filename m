Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122111FC3
	for <virtualization@lists.linux.dev>; Mon,  9 Jun 2025 01:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749434130; cv=none; b=OYiF0QifzJ+rlaehVe3Itlb92+MGBbLouk3JZX5KMXOmJ2dTg148JilVPv6Gryu56gSmvIV71o9IIuszjRLd9jzR7VgxqYwinhOKMkZGIxw4XkTPjbkKG1WXDKB56wr6GVnw7E1RWjzFO2kohpKjQglxXfC8AWXT3QkYLit+0mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749434130; c=relaxed/simple;
	bh=VOe5urutkAxH5+2GKgsjCGrJibbWQoiIrYvZuRZKcxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R509GDGGsvvuSs2Lnh4UfmbHP1UnboiDXT+ZVpt5xqpZ20cVo3n0UfXmvYtlLDu3qe9sBVwSfPwSTOzD0FHLFlW8daoT+WvbScq0XKhHDOVramMHksE2KFKr5PGbOQrfB6JU4kuqHV9SeZt+KqbgysjwH/iVpSjOYayT/EHBqqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LbrTuoH8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbrTuoH8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749434128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0w6zqeLOZkkirFxQGPRGE5g/+QU0pvAOXMbzbLt2ys=;
	b=LbrTuoH8TuC3gOqXtgLG6lDRlt2db1qmyCzGn7laHneMQfdKgE7FFFv3/wQVjhLKVSHW5o
	fQQhTI/C9WcGykSkQ5kSYMMQac8npeb8hxyek8l+OLWDBA7xWMBV7lvqJRwtx7QqXjeUYU
	WusNgCgl0YoEaaWWiwliTjCj3ZmWIbg=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-ZweqsWUFOOOrQZJGbdyqXg-1; Sun, 08 Jun 2025 21:55:26 -0400
X-MC-Unique: ZweqsWUFOOOrQZJGbdyqXg-1
X-Mimecast-MFC-AGG-ID: ZweqsWUFOOOrQZJGbdyqXg_1749434126
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b2f4c436301so2434455a12.0
        for <virtualization@lists.linux.dev>; Sun, 08 Jun 2025 18:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749434126; x=1750038926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0w6zqeLOZkkirFxQGPRGE5g/+QU0pvAOXMbzbLt2ys=;
        b=RgtwvOv2IUaPclgMmw5Wc2ELmZYNGxYjd4eQDIe1FjcYVvP+r1Qfw+9Dlap8OkOG16
         P7XSkNdI/f4Vv7kpbU0vNk05IvlbC57XYuK6GiAYx8L6oTCxekG8UQhstnBgHGOM9csO
         SuwwKes6yQlCIYws4YBNKzCvQHf+9veeC6slyuHnrMDfWOOW5H/JfaS3Oq68PuZBzzGm
         ebecdn6c1LWa5E2BpflLehIi7DSXZEtKgbC3vg8FT3Yx0QCMm+z5o/DC8MbQqBBxN1C9
         cUvCMuioD4DvdkhA8mNnDBk0DZVs05yU8qQboeqy9++ivQ6W05x35WMotvWf72+Ivggy
         i/HA==
X-Forwarded-Encrypted: i=1; AJvYcCUELepXTFnsuYJNmDTF5hSwdlL84583Z79kqZ83hXdNfkHZnkk511o4vuEPAPZEzlPaJp2e5yTywqgHDibdNA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/mAFq3Zi7a+f7XoXgytlapzZbJI8VcXbTY0qC7uECuqqclvfq
	PX6Ms9fLwkZwnnX1Pe57pKiKxzNxOThPugk1peFHPJmW1fcm5wxOag+sp8qru+xzjag0iZST+ru
	VX7PFr5lKFZ44rle8AxWzdxEC143zZ/+GPnhtx/u113DPg9H8J2dE6+ZK14mKbLm7xf6jYBSgdK
	nErBp2dMn8bbg/pdZKU8DK2TXRsBzs62vhr1gA2gpAT8g=
X-Gm-Gg: ASbGncuoX7gGyf24sFyjYAtFOKO0RsiEjDTi9pmP8/92Obg/Br6HDKy63Cyey8UQK3z
	GGSb9s/xXZ3S251k0h72UAOvLByYAuDGlg+eOeEPsbArumYw+xC1TTOdwQ9342v1q1d8cmw==
X-Received: by 2002:a05:6a21:6da0:b0:21f:56d0:65dc with SMTP id adf61e73a8af0-21f56d06839mr5447390637.13.1749434125796;
        Sun, 08 Jun 2025 18:55:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPtsIYPtnYC9cuf2Cifew3BSh2vk4kjOtKJrwodeI+3ERVSyhF4KvzTAOpk2qGJNc75uW8SUUGMHdn2AfgSR4=
X-Received: by 2002:a05:6a21:6da0:b0:21f:56d0:65dc with SMTP id
 adf61e73a8af0-21f56d06839mr5447367637.13.1749434125369; Sun, 08 Jun 2025
 18:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250606115012.1331551-1-eperezma@redhat.com> <20250606115012.1331551-3-eperezma@redhat.com>
In-Reply-To: <20250606115012.1331551-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Jun 2025 09:55:13 +0800
X-Gm-Features: AX0GCFvnuUSiNMZ23lyrE3OtsaKHUpCDyUZm0YqWaKAova5xfZMwUb8H_29rS8c
Message-ID: <CACGkMEuGC6NQmfUgXj1YVyURQ6-S2YT2qkAuYQGLpqVaV75kJg@mail.gmail.com>
Subject: Re: [RFC 2/6] vduse: add vq group support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IOvDkSQ1Gl-y1Z9jZumVRjeCwJTBaMJ47WtmEK9DZHI_1749434126
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 7:50=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> The virtqueue group is the minimal set of virtqueues that must share an
> address space.  And the address space identifier could only be attached
> to a specific virtqueue group.  The virtqueue is attached to a
> virtqueue group for all the life of the device.
>
> During vDPA device allocation, the VDUSE device needs to report the
> number of virtqueue groups supported. At this moment only vhost_vdpa is
> able to do it.
>
> This helps to isolate the environments for the virtqueue that will not
> be assigned directly. E.g in the case of virtio-net, the control
> virtqueue will not be assigned directly to guest.
>
> As we need to back the vq groups with a struct device for the file
> operations, let's keep this number as low as possible at the moment: 2.
> We can back one VQ group with the vduse device and the other one with
> the vdpa device.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 44 +++++++++++++++++++++++++++++-
>  include/uapi/linux/vduse.h         | 17 +++++++++++-
>  2 files changed, 59 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 6a9a37351310..6fa687bc4912 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -46,6 +46,11 @@
>  #define VDUSE_IOVA_SIZE (VDUSE_MAX_BOUNCE_SIZE + 128 * 1024 * 1024)
>  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
>
> +/*
> + * Let's make it 2 for simplicity.
> + */
> +#define VDUSE_MAX_VQ_GROUPS 2
> +
>  #define IRQ_UNBOUND -1
>
>  struct vduse_virtqueue {
> @@ -114,6 +119,7 @@ struct vduse_dev {
>         u8 status;
>         u32 vq_num;
>         u32 vq_align;
> +       u32 ngroups;
>         struct vduse_umem *umem;
>         struct mutex mem_lock;
>         unsigned int bounce_size;
> @@ -592,6 +598,25 @@ static int vduse_vdpa_set_vq_state(struct vdpa_devic=
e *vdpa, u16 idx,
>         return 0;
>  }
>
> +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> +{
> +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> +       struct vduse_dev_msg msg =3D { 0 };
> +       int ret;
> +
> +       if (dev->api_version < VDUSE_API_VERSION_1)
> +               return 0;
> +
> +       msg.req.type =3D VDUSE_GET_VQ_GROUP;
> +       msg.req.vq_group.index =3D idx;

Considering there will be a set_group_asid request, could the kernel
cache the result so we don't need to bother with requests from
userspace?

> +
> +       ret =3D vduse_dev_msg_sync(dev, &msg);
> +       if (ret)
> +               return ret;
> +
> +       return msg.resp.vq_group.num;
> +}
> +
>  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
>                                 struct vdpa_vq_state *state)
>  {
> @@ -789,6 +814,7 @@ static const struct vdpa_config_ops vduse_vdpa_config=
_ops =3D {
>         .set_vq_cb              =3D vduse_vdpa_set_vq_cb,
>         .set_vq_num             =3D vduse_vdpa_set_vq_num,
>         .get_vq_size            =3D vduse_vdpa_get_vq_size,
> +       .get_vq_group           =3D vduse_get_vq_group,
>         .set_vq_ready           =3D vduse_vdpa_set_vq_ready,
>         .get_vq_ready           =3D vduse_vdpa_get_vq_ready,
>         .set_vq_state           =3D vduse_vdpa_set_vq_state,
> @@ -1850,6 +1876,16 @@ static int vduse_create_dev(struct vduse_dev_confi=
g *config,
>         dev->device_features =3D config->features;
>         dev->device_id =3D config->device_id;
>         dev->vendor_id =3D config->vendor_id;
> +       if (dev->api_version >=3D 1) {
> +               if (config->ngroups > VDUSE_MAX_VQ_GROUPS) {
> +                       pr_err("Not creating a VDUSE device with %u vq gr=
oups. Max: %u",
> +                               config->ngroups, VDUSE_MAX_VQ_GROUPS);
> +                       goto err_ngroups;
> +               }
> +               dev->ngroups =3D config->ngroups ?: 1;
> +       } else {
> +               dev->ngroups =3D 1;
> +       }
>         dev->name =3D kstrdup(config->name, GFP_KERNEL);
>         if (!dev->name)
>                 goto err_str;
> @@ -1885,6 +1921,7 @@ static int vduse_create_dev(struct vduse_dev_config=
 *config,
>         idr_remove(&vduse_idr, dev->minor);
>  err_idr:
>         kfree(dev->name);
> +err_ngroups:
>  err_str:
>         vduse_dev_destroy(dev);
>  err:
> @@ -2003,13 +2040,18 @@ static struct vduse_mgmt_dev *vduse_mgmt;
>  static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
>  {
>         struct vduse_vdpa *vdev;
> +       __u32 ngroups =3D 1;
>         int ret;
>
>         if (dev->vdev)
>                 return -EEXIST;
>
> +       if (vdev->dev->api_version >=3D VDUSE_API_VERSION_1)
> +               ngroups =3D vdev->dev->ngroups;
> +
>         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> -                                &vduse_vdpa_config_ops, 1, 1, name, true=
);
> +                                &vduse_vdpa_config_ops, ngroups, 1, name=
,
> +                                true);
>         if (IS_ERR(vdev))
>                 return PTR_ERR(vdev);
>
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 9a56d0416bfe..a779bcddac58 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -45,7 +45,8 @@ struct vduse_dev_config {
>         __u64 features;
>         __u32 vq_num;
>         __u32 vq_align;
> -       __u32 reserved[13];
> +       __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> +       __u32 reserved[12];
>         __u32 config_size;
>         __u8 config[];
>  };
> @@ -160,6 +161,16 @@ struct vduse_vq_state_packed {
>         __u16 last_used_idx;
>  };
>
> +/**
> + * struct vduse_vq_group - virtqueue group
> + * @num: Index of the virtqueue group
> + * @num: Group
> + */
> +struct vduse_vq_group {
> +       __u32 index;
> +       __u32 num;
> +};
> +
>  /**
>   * struct vduse_vq_info - information of a virtqueue
>   * @index: virtqueue index
> @@ -182,6 +193,7 @@ struct vduse_vq_info {
>         union {
>                 struct vduse_vq_state_split split;
>                 struct vduse_vq_state_packed packed;
> +               struct vduse_vq_group group;
>         };
>         __u8 ready;
>  };
> @@ -274,6 +286,7 @@ enum vduse_req_type {
>         VDUSE_GET_VQ_STATE,
>         VDUSE_SET_STATUS,
>         VDUSE_UPDATE_IOTLB,
> +       VDUSE_GET_VQ_GROUP,
>  };
>
>  /**
> @@ -328,6 +341,7 @@ struct vduse_dev_request {
>                 struct vduse_vq_state vq_state;
>                 struct vduse_dev_status s;
>                 struct vduse_iova_range iova;
> +               struct vduse_vq_group vq_group; /* Only if vduse api vers=
ion >=3D 1 */
>                 __u32 padding[32];

This should be [31] otherwise we break the uAPI?

>         };
>  };
> @@ -350,6 +364,7 @@ struct vduse_dev_response {
>         __u32 reserved[4];
>         union {
>                 struct vduse_vq_state vq_state;
> +               struct vduse_vq_group vq_group; /* Only if vduse api vers=
ion >=3D 1 */
>                 __u32 padding[32];

And here?

Thanks

>         };
>  };
> --
> 2.49.0
>

