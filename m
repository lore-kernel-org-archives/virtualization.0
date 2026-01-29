Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8771E353ECA
	for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 02:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769652779; cv=none; b=lQxi5aN2nIH+2mbqtZaOndoKMfS2fAS0dtQ3GX6nEUcrBpwXsC+ZXNTH9AFsM1gUQ5yono9PJTu35j5wTWkrslj2F5ijLSW75sv0D41bI075ohlwISV5aqpgy3PnY4UGVcV6E6s5UOHmIv5EVFG/hG8tY6J6pUsyTrr+WSwkhhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769652779; c=relaxed/simple;
	bh=GhSpdn29FxTwtve+AW8MqlAeVf0dNl0WnEVZP0VJRyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEiU+a/0ycy+xb5IF+uQH1V060AA8sqEUDtXH9O7tp2p30fD3AnJ9iRBQF7k1kkuq7225oReCnKMvFkqn6IhsssHH+itSoowghqGHkcCStPEEtnGQMxxbHUKF1RfRYRDmzJlz5nY0tE+F3jyxLzzmfStcYPeLk5oPhUcYXh0lXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KdxkjXOv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdxkjXOv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769652774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGS2ZHzyu32GKD6SuLaxfRJMCYDiF26USSPduT6xNJU=;
	b=KdxkjXOv/TAkz0YGIKaJOHdfFe129ZevyVS8prnGC7JsGu1rpOur6DrcoWyq6Ffg1NYS01
	oJgGh7pb8zIjSkC8Ziknqpb2p2WCpCaNuCE6wPhX4vn2laXUsDf6VIuZ1wer7Yh/73T4wC
	U8o307Yps7Vvv/UlgOUoIr0/tX3xVSU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-1IsHPaMEN8WJ3_bBp3X-Xg-1; Wed, 28 Jan 2026 21:12:53 -0500
X-MC-Unique: 1IsHPaMEN8WJ3_bBp3X-Xg-1
X-Mimecast-MFC-AGG-ID: 1IsHPaMEN8WJ3_bBp3X-Xg_1769652772
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c93f0849dso479400a91.1
        for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 18:12:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769652772; x=1770257572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NGS2ZHzyu32GKD6SuLaxfRJMCYDiF26USSPduT6xNJU=;
        b=oQIGLsMpvGFauGLKb1WE+rGH5SxHX+MHqzGId0cyAuEnMixKNEcNblY2Kq2r09xwGe
         Kn/VPDwObMU2kUw/2moS7Yzgzz+N7POWfQvv3UnkXDiIoYN79c5Yn6afj97tGAScz3Ud
         mi0jCKeYJFckdPvu8WQoZKIDpP5Z2V7c+BvwkP/ADX8tW/xSkDH5ltRSSGtfiIkHYyT5
         apqgRF717XVdP7fIME06VrXJOyL1YIvrQGabEIUu6LkmOTw0VO10ySvSwBXbxLGZT53D
         2HvoPO8XsNXVMMC2otGhQFxH6fentYCEe06NoTPpTBSDEX56l0gAgavJMf1+vjA8Goi2
         eQ3w==
X-Forwarded-Encrypted: i=1; AJvYcCXCO/m68VkfazQhiAIXwoJ2j4rjLVzPZfOJJwNJX5de4trydDy7Rj9pUpIKYCPy8pHbhDNO+Mp34hxUVGo6JA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxN+bm8JIVTu4WXI6w36yUJC1DRFxr5Lira8cIuMXSHdBsdUbyr
	JRL/9Jwmz71JvLb7NOkW5TRk3ke3ILk3+pN8rKl4HP32fq4XrAlhxP57sbN00h9wDs78W6Ma8Eo
	2g/oznD2vz7gbA0+00jsN6ILbA7NFBvHH+jOhq3FjvROBMe4Tov2YMypY6OEfm/ZlaCMJRH3Mw2
	WyCQUmIAfjFm/cx9O70ItSb5ZkIlxFyrZh8c79VBAzzzXyk//4lw+hcg==
X-Gm-Gg: AZuq6aLKZ27upt5zGW57Wibh9gkGi98ykgJtxf0OwI6ebFG9zmOECOV1Q6DZrndY54x
	Edcd9H358s0JI1n48c5Z7SfLp2QiS/7cupoGT5vXd+yUTcv62woXbZ8Q1rEUukIbtzH6oTYhTg2
	Q0f0jdKJ/R50UsE8oTuj3Kt8/bMP+vBv/RIDC/HvHJ1WG5urL02QRHdrSme8q+otIC
X-Received: by 2002:a17:90b:4d8c:b0:352:be45:1063 with SMTP id 98e67ed59e1d1-35429ac7eebmr1139237a91.10.1769652771875;
        Wed, 28 Jan 2026 18:12:51 -0800 (PST)
X-Received: by 2002:a17:90b:4d8c:b0:352:be45:1063 with SMTP id
 98e67ed59e1d1-35429ac7eebmr1139217a91.10.1769652771454; Wed, 28 Jan 2026
 18:12:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128124524.875271-1-eperezma@redhat.com> <20260128124524.875271-6-eperezma@redhat.com>
In-Reply-To: <20260128124524.875271-6-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Jan 2026 10:12:39 +0800
X-Gm-Features: AZwV_QhJ_W7ZrtFapVc6usZnd6QY6MqBRxsthMqtN6ofMw8sZtYl-cr7TLfJlaM
Message-ID: <CACGkMEtuAG-uZYJWZcsT1A0+QBCTOnkr7m0dt8MdbTwd5UNyNw@mail.gmail.com>
Subject: Re: [PATCH 5/6] vduse: add F_QUEUE_READY feature
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _XiLawsaa-1lfSJDwEYfG2ylkF9T50YPxnzwZ79XWsM_1769652772
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Add the VDUSE_F_QUEUE_READY feature flag. This allows the kernel module
> to explicitly signal userspace when a specific virtqueue has been
> enabled.
>
> In scenarios like Live Migration of VirtIO net devices, the dataplane
> starts after the control virtqueue allowing QEMU to apply configuration
> in the destination device.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 28 +++++++++++++++++++++++++++-
>  include/uapi/linux/vduse.h         | 19 +++++++++++++++++++
>  2 files changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index e7da69c2ad71..1d93b540db4d 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -9,6 +9,7 @@
>   */
>
>  #include "linux/virtio_net.h"
> +#include <linux/bits.h>
>  #include <linux/cleanup.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> @@ -53,7 +54,7 @@
>  #define IRQ_UNBOUND -1
>
>  /* Supported VDUSE features */
> -static const uint64_t vduse_features;
> +static const uint64_t vduse_features =3D BIT_U64(VDUSE_F_QUEUE_READY);
>
>  /*
>   * VDUSE instance have not asked the vduse API version, so assume 0.
> @@ -120,6 +121,7 @@ struct vduse_dev {
>         char *name;
>         struct mutex lock;
>         spinlock_t msg_lock;
> +       u64 vduse_features;
>         u64 msg_unique;
>         u32 msg_timeout;
>         wait_queue_head_t waitq;
> @@ -619,7 +621,30 @@ static void vduse_vdpa_set_vq_ready(struct vdpa_devi=
ce *vdpa,
>  {
>         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
>         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> +       struct vduse_dev_msg msg =3D { 0 };
> +       int r;
> +
> +       if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUEUE_READY)))
> +               goto out;
> +
> +       msg.req.type =3D VDUSE_SET_VQ_READY;
> +       msg.req.vq_ready.num =3D idx;
> +       msg.req.vq_ready.ready =3D !!ready;
> +
> +       r =3D vduse_dev_msg_sync(dev, &msg);
>
> +       if (r < 0) {
> +               dev_dbg(&vdpa->dev, "device refuses to set vq %u ready %u=
",
> +                       idx, ready);
> +
> +               /* We can't do better than break the device in this case =
*/
> +               spin_lock(&dev->msg_lock);
> +               vduse_dev_broken(dev);

This has been done by vduse_dev_msg_sync().

Thanks

> +               spin_unlock(&dev->msg_lock);
> +               return;
> +       }
> +
> +out:
>         vduse_vq_set_ready(vq, ready);
>  }
>
> @@ -2121,6 +2146,7 @@ static int vduse_create_dev(struct vduse_dev_config=
 *config,
>         dev->device_features =3D config->features;
>         dev->device_id =3D config->device_id;
>         dev->vendor_id =3D config->vendor_id;
> +       dev->vduse_features =3D config->vduse_features;
>
>         dev->nas =3D (dev->api_version < VDUSE_API_VERSION_1) ? 1 : confi=
g->nas;
>         dev->as =3D kcalloc(dev->nas, sizeof(dev->as[0]), GFP_KERNEL);
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 1f68e556cbf2..1e27395692ea 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -18,6 +18,9 @@
>
>  #define VDUSE_API_VERSION_2    2
>
> +/* The VDUSE instance expects a request for vq ready */
> +#define VDUSE_F_QUEUE_READY    0
> +
>  /*
>   * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION=
).
>   * This is used for future extension.
> @@ -330,6 +333,7 @@ enum vduse_req_type {
>         VDUSE_SET_STATUS,
>         VDUSE_UPDATE_IOTLB,
>         VDUSE_SET_VQ_GROUP_ASID,
> +       VDUSE_SET_VQ_READY,
>  };
>
>  /**
> @@ -376,6 +380,15 @@ struct vduse_iova_range_v2 {
>         __u32 asid;
>  };
>
> +/**
> + * struct vduse_vq_ready - Virtqueue ready request message
> + * @num: Virtqueue number
> + */
> +struct vduse_vq_ready {
> +       __u32 num;
> +       __u32 ready;
> +};
> +
>  /**
>   * struct vduse_dev_request - control request
>   * @type: request type
> @@ -386,6 +399,7 @@ struct vduse_iova_range_v2 {
>   * @iova: IOVA range for updating
>   * @iova_v2: IOVA range for updating if API_VERSION >=3D 1
>   * @vq_group_asid: ASID of a virtqueue group
> + * @vq_ready: Virtqueue ready request
>   * @padding: padding
>   *
>   * Structure used by read(2) on /dev/vduse/$NAME.
> @@ -403,6 +417,11 @@ struct vduse_dev_request {
>                  */
>                 struct vduse_iova_range_v2 iova_v2;
>                 struct vduse_vq_group_asid vq_group_asid;
> +               /*
> +                * Following members but padding exist only if vduse api
> +                * version >=3D 2
> +                */
> +               struct vduse_vq_ready vq_ready;
>                 __u32 padding[32];
>         };
>  };
> --
> 2.52.0
>

