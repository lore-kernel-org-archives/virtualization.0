Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E39434752B
	for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 06:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296688; cv=none; b=WijMVqilBBW4yLs7XBJf6xGTwG4lr2vEJRA6e+iEKCSo07gSk4V/ofa7TU79nxfOKvxP5xXaFy0EorpC66l1mknHF2Z/j5V7pl9r6ZaGqWCWXKMC4HbctVbhTJVBY1NoZJwHtuQdcecbvKIhHU99rBMVzOogwnnnhpmn7GhuVPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296688; c=relaxed/simple;
	bh=uPGcksDnno8pfBBIwwAYOimnp4EyUg4RMjJDU81rvIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzDXRhCQyoSdEhHAyWhz+m2W4OSTk/5RSfkc3c4ewlYaGOwLcPplKQjwlKLi2KtxyKV9ryjnT/8OyJhVmEq713jUIaLQlPyna+msAfNVsHQUstgsg3MKnZdFNRwb5jSeywtphqHX1Mwc2Nhon5O0m0fPp6a2eUq27fPsOYNVAnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/O4FWwn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/O4FWwn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773296686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vVkhhn32gaPGKPIvO3UA6HH1EEKBW7k18z2m3prkATU=;
	b=Y/O4FWwntdAhPvN8vhciWuPnXZ8Ek6LBS2Yr3RY7gvxjl0l5KHb9zSHp9sfk1BKaK/vkke
	KIWPdv97KPiCZt+cNl5hqX1mbwut2SgVYA1tDXWWJtXZHpSZkqhM47Gph8F1Bp5EutWRVp
	cUQc6dQ7apmbfMAWfgnmdFGa7ikTf6k=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-5QR9PykDMTi7qr8DV51Kbg-1; Thu, 12 Mar 2026 02:24:44 -0400
X-MC-Unique: 5QR9PykDMTi7qr8DV51Kbg-1
X-Mimecast-MFC-AGG-ID: 5QR9PykDMTi7qr8DV51Kbg_1773296684
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-64cb719e778so1785610d50.1
        for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 23:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773296684; x=1773901484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vVkhhn32gaPGKPIvO3UA6HH1EEKBW7k18z2m3prkATU=;
        b=Q7veW9mrRhfmAITrJVG90kq0AwIbwO+6kLrCv9Jw6LPK8OusW5i6WuKuaadzjc3R2v
         YS+nNvApOIFResK+C8Ou3Q36xylzlz++rtIXO25dpODa/mmFfEkoVV5F2M51DA1H6c92
         6gj2fAJTm/edCU/1Q5dMNRGdNb4swQG9xpRI4A/NkxhvuJpmSGS6q8aLrbPU5DItbfaY
         LwtiNHdQtKBlGRYpSO3ViVkGoV6/n1NeK/Sp8yxCsJiO0aJ11dq+WOYmmQqhdjFqW/02
         u8eTSzKFKILv6jbtt0+DA2eJENjsZcs/sxY3RNSORygcW670e7EpmpSEHrRtQYH8Yhg8
         dRtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBEFndxRQ0GFIP1hWyNc9P0slj+p41S4RTEFmkdI+cC70LyX657xCOhnMkvHlVOVygJ2y2vCknB9PUDWeOKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVfCFZbYOAEO7l6DLNm5nqZbDZdaOGcutnElOgCVi9UeoTBV4J
	Tvp43QTqnTBl3ftDZ2rlcAbkcXMlHviiwFZJRpuwk3xtrHfouUjKGYMwJviHDdJyNodYpuAP70I
	IpKPa7rQFHIQpbmd2Mb0huKml3HQ6f+qh219b8R4SLVw+L3mLoBx4sycTUNG3xtTMVEVrWpPizV
	Ts011/Exlituk1MG/WMAJfMYKHzFihxS9vQbSjBuGUNJY=
X-Gm-Gg: ATEYQzxm6Fpl2uWr0rj8kE5UPHOgtoxzOYnFEoC6vUjVE+1lFyusdYpELo9DsJCQkdO
	RQt+TD9luYQhiQa9RUdMPDABE3h95sRQfS1F7HipboLHmG0PTXclovzfyMFrnVBaJ423iGiSc55
	/BqxGT3DIvNvy8hGFVfNPyx73OhdsPQjfsshRxHf9DaDh74+PplQIL1C+GkeTCYYA++NfIHXXd9
	4pNpw==
X-Received: by 2002:a05:690e:2057:b0:64a:ee3a:8f0c with SMTP id 956f58d0204a3-64d6582d83cmr3331485d50.83.1773296684096;
        Wed, 11 Mar 2026 23:24:44 -0700 (PDT)
X-Received: by 2002:a05:690e:2057:b0:64a:ee3a:8f0c with SMTP id
 956f58d0204a3-64d6582d83cmr3331472d50.83.1773296683656; Wed, 11 Mar 2026
 23:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310190759.1097506-1-eperezma@redhat.com> <20260310190759.1097506-4-eperezma@redhat.com>
 <CACGkMEvwmC4qiYgZAkrHEC3r3q7FyMiqpg5=2oNMPGm0q=PLBA@mail.gmail.com>
In-Reply-To: <CACGkMEvwmC4qiYgZAkrHEC3r3q7FyMiqpg5=2oNMPGm0q=PLBA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 12 Mar 2026 07:24:07 +0100
X-Gm-Features: AaiRm53-KAYpeFM0IazYNg9O7Nsy68t_mT43ASDqdZbm1wz7kbfNQjLhcDJbJJU
Message-ID: <CAJaqyWe+x9okNwPD5n6M+PeLt0cQY-_fBWOD9uXSa1nKHqRaFw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] vduse: add F_QUEUE_READY feature
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HUSC8_Ttmo7vOynYXmfQSMdAeXBu8pcRaELe-2VHAT8_1773296684
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 4:58=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Mar 11, 2026 at 3:08=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Add the VDUSE_F_QUEUE_READY feature flag. This allows the kernel module
> > to explicitly signal userspace when a specific virtqueue has been
> > enabled.
> >
> > In scenarios like Live Migration of VirtIO net devices, the dataplane
> > starts after the control virtqueue allowing QEMU to apply configuration
> > in the destination device.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v2:
> > * Fix comment of vduse_dev_request.vq_ready
> > * Set vq_ready before sending the message to the VDUSE userland
> >   instance, avoiding the need for SMP sync after receiving the message.
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 +++++++++++++++++++++++++++-
> >  include/uapi/linux/vduse.h         | 18 ++++++++++++++++++
> >  2 files changed, 45 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 17e0358d3a68..4f642b95a7cb 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -9,6 +9,7 @@
> >   */
> >
> >  #include "linux/virtio_net.h"
> > +#include <linux/bits.h>
> >  #include <linux/cleanup.h>
> >  #include <linux/init.h>
> >  #include <linux/module.h>
> > @@ -53,7 +54,7 @@
> >  #define IRQ_UNBOUND -1
> >
> >  /* Supported VDUSE features */
> > -static const uint64_t vduse_features;
> > +static const uint64_t vduse_features =3D BIT_U64(VDUSE_F_QUEUE_READY);
> >
> >  /*
> >   * VDUSE instance have not asked the vduse API version, so assume 0.
> > @@ -120,6 +121,7 @@ struct vduse_dev {
> >         char *name;
> >         struct mutex lock;
> >         spinlock_t msg_lock;
> > +       u64 vduse_features;
> >         u64 msg_unique;
> >         u32 msg_timeout;
> >         wait_queue_head_t waitq;
> > @@ -601,8 +603,29 @@ static void vduse_vdpa_set_vq_ready(struct vdpa_de=
vice *vdpa,
> >  {
> >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> >         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> > +       struct vduse_dev_msg msg =3D { 0 };
> > +       int r;
> >
> >         vq->ready =3D ready;
> > +
> > +       if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUEUE_READY)))
> > +               return;
> > +
> > +       msg.req.type =3D VDUSE_SET_VQ_READY;
> > +       msg.req.vq_ready.num =3D idx;
> > +       msg.req.vq_ready.ready =3D !!ready;
> > +
> > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > +
> > +       if (r < 0) {
> > +               dev_dbg(&vdpa->dev, "device refuses to set vq %u ready =
%u",
> > +                       idx, ready);
> > +
> > +               /* We can't do better than break the device in this cas=
e */
>
> It's better to explain why we can't depend on vduse_dev_msg_sync() here.
>
> For example it did:
>
>         if (unlikely(dev->broken))
>                 return -EIO;
>
>         init_waitqueue_head(&msg->waitq);
>         spin_lock(&dev->msg_lock);
>         if (unlikely(dev->broken)) {
>                 spin_unlock(&dev->msg_lock);
>                 return -EIO;
>         }
>
> and
>
>         if (!msg->completed) {
>                 list_del(&msg->list);
>                 msg->resp.result =3D VDUSE_REQ_RESULT_FAILED;
>                 /* Mark the device as malfunction when there is a timeout=
 */
>                 if (!ret)
>                         vduse_dev_broken(dev);
>         }
>

I'm not sure I follow you here.

We can't do better than breaking the device because the function
returns no error state, and the caller does not expect an error code.
Do you mean we can't depend on vduse_dev_msg_sync to call
vduse_dev_broken(dev) by itself?

> > +               spin_lock(&dev->msg_lock);
> > +               vduse_dev_broken(dev);
> > +               spin_unlock(&dev->msg_lock);
> > +       }
> >  }
> >
> >  static bool vduse_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 idx)
> > @@ -2078,6 +2101,9 @@ static int vduse_create_dev(struct vduse_dev_conf=
ig *config,
> >         dev->device_features =3D config->features;
> >         dev->device_id =3D config->device_id;
> >         dev->vendor_id =3D config->vendor_id;
> > +       dev->vduse_features =3D config->vduse_features;
> > +       dev_dbg(vduse_ctrl_dev, "Creating device %s with features 0x%ll=
x",
> > +               config->name, config->vduse_features);
> >
> >         dev->nas =3D (dev->api_version < VDUSE_API_VERSION_1) ? 1 : con=
fig->nas;
> >         dev->as =3D kcalloc(dev->nas, sizeof(dev->as[0]), GFP_KERNEL);
> > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > index e9b5f32a452d..7324faea5df4 100644
> > --- a/include/uapi/linux/vduse.h
> > +++ b/include/uapi/linux/vduse.h
> > @@ -14,6 +14,9 @@
> >
> >  #define VDUSE_API_VERSION_1    1
> >
> > +/* The VDUSE instance expects a request for vq ready */
> > +#define VDUSE_F_QUEUE_READY    0
> > +
> >  /*
> >   * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSI=
ON).
> >   * This is used for future extension.
> > @@ -330,6 +333,7 @@ enum vduse_req_type {
> >         VDUSE_SET_STATUS,
> >         VDUSE_UPDATE_IOTLB,
> >         VDUSE_SET_VQ_GROUP_ASID,
> > +       VDUSE_SET_VQ_READY,
> >  };
> >
> >  /**
> > @@ -377,6 +381,15 @@ struct vduse_iova_range_v2 {
> >         __u32 padding;
> >  };
> >
> > +/**
> > + * struct vduse_vq_ready - Virtqueue ready request message
> > + * @num: Virtqueue number
> > + */
> > +struct vduse_vq_ready {
> > +       __u32 num;
> > +       __u32 ready;
> > +};
> > +
> >  /**
> >   * struct vduse_dev_request - control request
> >   * @type: request type
> > @@ -387,6 +400,7 @@ struct vduse_iova_range_v2 {
> >   * @iova: IOVA range for updating
> >   * @iova_v2: IOVA range for updating if API_VERSION >=3D 1
> >   * @vq_group_asid: ASID of a virtqueue group
> > + * @vq_ready: Virtqueue ready request
> >   * @padding: padding
> >   *
> >   * Structure used by read(2) on /dev/vduse/$NAME.
> > @@ -404,6 +418,10 @@ struct vduse_dev_request {
> >                  */
> >                 struct vduse_iova_range_v2 iova_v2;
> >                 struct vduse_vq_group_asid vq_group_asid;
> > +
> > +               /* Only if VDUSE_F_QUEUE_READY is negotiated */
> > +               struct vduse_vq_ready vq_ready;
> > +
> >                 __u32 padding[32];
> >         };
> >  };
> > --
> > 2.53.0
> >
>
> Thanks
>

