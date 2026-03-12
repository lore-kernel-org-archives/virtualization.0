Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22CC38911C
	for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 03:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773287908; cv=none; b=rEDieW2C1OpgsIewDlkHxpvSkOYGmFwSFtaugWYvaFn+2r3m+ODDPnNWW50pQ/zortzkYKwTwWCu4eVrZ26wyAmkDulOZfcvyD3VseNpuEkdvLeAlM7tBT2iGfvD2LuCYoYgMpIxSBfQQ9/a5vrAh/2PIoDN2TrsoDV93y9nG6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773287908; c=relaxed/simple;
	bh=mPz/HD5BGv6Xv4EdRG0CEBrh22DvXGdndjW9YkLRDKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqvnFYBvtwnl7vC09PfoVv8CGsIT63VxFbEkdicaHQLtiZ/2HQeidOshtYpFhLOV9QHYKRDm7pbmC/ryx0+xLPQ0p90S8nk8TgoB7qEQ48djkIAaOT87mx2DeVI0HRKL+sJOo+yQnMSAF9Uc4FZr6Scd1G94PXsBBOat236hd2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOXVPdEj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOXVPdEj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773287904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jWBQRhqe0Vxmesbnergg8dunL7gEBfvHH62hCNo1gQk=;
	b=cOXVPdEjH5zb3xGH6SwQJPpa4ao6mP7zR1/mIApBzIAJIZrNGXeoODbixNZo9VMRHKWiNz
	c+W3IcNqhcYl/yL2iwpg9PvLtJf6/gp+N9cIcnV4OK5+/rei1Sf68rVvtlC/87W1+FlqN/
	mCfgGLQsFAFw78GqIPE/b9Lvo8NG/yc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-DcW-ykjBON2GUECLHcWFDA-1; Wed, 11 Mar 2026 23:58:22 -0400
X-MC-Unique: DcW-ykjBON2GUECLHcWFDA-1
X-Mimecast-MFC-AGG-ID: DcW-ykjBON2GUECLHcWFDA_1773287902
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-358e425c261so467116a91.3
        for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 20:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773287902; x=1773892702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jWBQRhqe0Vxmesbnergg8dunL7gEBfvHH62hCNo1gQk=;
        b=jxjJLK11anujSNv+KSoSvtzwKY+AHRDn/x3h3bGhjhw+7MwfOKfK+tgNLThBlUMJej
         r+1DoLi5vYywC84SG2dupsmYqj4+5v/Px5Y54gty5Cx2wQz6KJbt2JGdmmiz8zJCkGkb
         LXGEqep/qmj6wE2zkctwD29AIHVdUtBw2eLq7AWsYO30QuMn8rQkijxA3zpQF9rJM0MM
         r6BtbQmClpooKistQZn2HEHoP9XreL/BJnH78/1CuyLcnd7+psRPKinmMwlZ9HlMQfSs
         4FoIq0Xt5mYXNroIxzUFS+Vxnre1Jz4JLqwtWj0qLWskKJsZSyxWDi8ciDNegU3d82Yh
         Eskg==
X-Forwarded-Encrypted: i=1; AJvYcCWKoZvN8UQEK/NSvnIc9p3YY7benOYmuiXljalis+67CPjJseQ3f7QO7uBQqneROcU9dGOUJlgqEpW5x9NhEg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2c7Dm5OLk81ZS6sBxAmxLPnVzcbHUQ49WX3yhQz71hUiFfFzs
	IXa4ISosgQ3FKKOyGn/Er0P4uwwqkoF7gSQFQ0ZDe74lcD3WGnp83C+L+HFJZxaqHpdD3Jx6uFv
	8YxL+uw3e7yV1Ubhj+QabMFUSYR2cYn/f42GZcEAmE1tXLjnp15ZA2LAk8jBeBlfqH8MOlL9CuZ
	a7gam2K3pgSQf2A9gyTSKB5oNRlIhNlOMrVLuY2+vX05E=
X-Gm-Gg: ATEYQzxxon6qmljSEZeJUtkpMhFydNKnWIiX30vpklr0pJcHLtXO4guNKy20lUXXqCt
	5kAx/PyR2t4YbisWrBgdIvTTf5/WCMkXqh2suZYxqN5Y3ARUhOE1Xf28TQz8BtLbF+JxWRIKec1
	0MGSvzIGP/hbC2oIJco8QRH0MP86oQqvCpPc0YUYTk6yDjP5RdpIu1202vtP1Dx5Jlz/+c63BC1
	lsLUKtk
X-Received: by 2002:a17:90b:1d09:b0:359:fd9a:c50c with SMTP id 98e67ed59e1d1-35a01284f8dmr4522431a91.22.1773287901714;
        Wed, 11 Mar 2026 20:58:21 -0700 (PDT)
X-Received: by 2002:a17:90b:1d09:b0:359:fd9a:c50c with SMTP id
 98e67ed59e1d1-35a01284f8dmr4522409a91.22.1773287901197; Wed, 11 Mar 2026
 20:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310190759.1097506-1-eperezma@redhat.com> <20260310190759.1097506-4-eperezma@redhat.com>
In-Reply-To: <20260310190759.1097506-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Mar 2026 11:58:09 +0800
X-Gm-Features: AaiRm50Zfs5dNjBlLcPuON2bxJNbAzFwwQo-GrnduY2d6L1Hm37rvgUzeAinUv8
Message-ID: <CACGkMEvwmC4qiYgZAkrHEC3r3q7FyMiqpg5=2oNMPGm0q=PLBA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] vduse: add F_QUEUE_READY feature
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vJSuBiLPpJIfizHP64HgRNma0tgUG365oUVOeoVR7ek_1773287902
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 3:08=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
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
> v2:
> * Fix comment of vduse_dev_request.vq_ready
> * Set vq_ready before sending the message to the VDUSE userland
>   instance, avoiding the need for SMP sync after receiving the message.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 28 +++++++++++++++++++++++++++-
>  include/uapi/linux/vduse.h         | 18 ++++++++++++++++++
>  2 files changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 17e0358d3a68..4f642b95a7cb 100644
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
> @@ -601,8 +603,29 @@ static void vduse_vdpa_set_vq_ready(struct vdpa_devi=
ce *vdpa,
>  {
>         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
>         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> +       struct vduse_dev_msg msg =3D { 0 };
> +       int r;
>
>         vq->ready =3D ready;
> +
> +       if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUEUE_READY)))
> +               return;
> +
> +       msg.req.type =3D VDUSE_SET_VQ_READY;
> +       msg.req.vq_ready.num =3D idx;
> +       msg.req.vq_ready.ready =3D !!ready;
> +
> +       r =3D vduse_dev_msg_sync(dev, &msg);
> +
> +       if (r < 0) {
> +               dev_dbg(&vdpa->dev, "device refuses to set vq %u ready %u=
",
> +                       idx, ready);
> +
> +               /* We can't do better than break the device in this case =
*/

It's better to explain why we can't depend on vduse_dev_msg_sync() here.

For example it did:

        if (unlikely(dev->broken))
                return -EIO;

        init_waitqueue_head(&msg->waitq);
        spin_lock(&dev->msg_lock);
        if (unlikely(dev->broken)) {
                spin_unlock(&dev->msg_lock);
                return -EIO;
        }

and

        if (!msg->completed) {
                list_del(&msg->list);
                msg->resp.result =3D VDUSE_REQ_RESULT_FAILED;
                /* Mark the device as malfunction when there is a timeout *=
/
                if (!ret)
                        vduse_dev_broken(dev);
        }

> +               spin_lock(&dev->msg_lock);
> +               vduse_dev_broken(dev);
> +               spin_unlock(&dev->msg_lock);
> +       }
>  }
>
>  static bool vduse_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 idx)
> @@ -2078,6 +2101,9 @@ static int vduse_create_dev(struct vduse_dev_config=
 *config,
>         dev->device_features =3D config->features;
>         dev->device_id =3D config->device_id;
>         dev->vendor_id =3D config->vendor_id;
> +       dev->vduse_features =3D config->vduse_features;
> +       dev_dbg(vduse_ctrl_dev, "Creating device %s with features 0x%llx"=
,
> +               config->name, config->vduse_features);
>
>         dev->nas =3D (dev->api_version < VDUSE_API_VERSION_1) ? 1 : confi=
g->nas;
>         dev->as =3D kcalloc(dev->nas, sizeof(dev->as[0]), GFP_KERNEL);
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index e9b5f32a452d..7324faea5df4 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -14,6 +14,9 @@
>
>  #define VDUSE_API_VERSION_1    1
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
> @@ -377,6 +381,15 @@ struct vduse_iova_range_v2 {
>         __u32 padding;
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
> @@ -387,6 +400,7 @@ struct vduse_iova_range_v2 {
>   * @iova: IOVA range for updating
>   * @iova_v2: IOVA range for updating if API_VERSION >=3D 1
>   * @vq_group_asid: ASID of a virtqueue group
> + * @vq_ready: Virtqueue ready request
>   * @padding: padding
>   *
>   * Structure used by read(2) on /dev/vduse/$NAME.
> @@ -404,6 +418,10 @@ struct vduse_dev_request {
>                  */
>                 struct vduse_iova_range_v2 iova_v2;
>                 struct vduse_vq_group_asid vq_group_asid;
> +
> +               /* Only if VDUSE_F_QUEUE_READY is negotiated */
> +               struct vduse_vq_ready vq_ready;
> +
>                 __u32 padding[32];
>         };
>  };
> --
> 2.53.0
>

Thanks

