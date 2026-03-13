Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DBE381AF
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 07:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385777; cv=none; b=U35nr1+v5T/SKi/uX/CB5BVBXsO1u7e5WKEOsSqx4WQZD13XQKofL1paQKySKUGT9hYe4F6tdaByP+iARdFVDSy8lHkCs83QKwzSM12zQ6JaYqfiRjhQNGdVfEvGdDAcT7/0NSQj2XdLRI5s4ltudaXynbH3MRGf6JnLpY09+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385777; c=relaxed/simple;
	bh=zpWMTIIsDU5pytrs36tBG6B9O+mLl1YKQqh/raI6y/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYUFOuMgIm8Xz4sZLPRWfQKuPcQIxjBqfb+QYLiwwEGcaSPwrj1tU25UQHuy2QGkXynWjbJQNEFHDtmVtuYSE+sIEv3JYh8yXEK0+m9v5GTs9k8Na7yJMa58PlBfh2xHVaYnEoubDzOS57SKLL/p96beqE+bEpzypLTWhKYyx1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KLqryZvp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLqryZvp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773385774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tGLHHMlkxvn9yOYAE3QMyUNpmuIw499v1QmSDP4J2xQ=;
	b=KLqryZvp9ynjUVaUe7M5d0YrBKTIBkYg3med3d5qmUjoQomVQtIrs1nsdwnyVJXK+onnOO
	YG1vj20t9z8kcfRuo3MPS0iAtSeCN3lbSij4uJy95lC/NWNlQUSdb3oEpWNibVkL0m8Xb8
	qX0cHhMxu6VA2KV5jO0nxKl7ED6062E=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-oUBAoRMAP8WbvDRTRSUmeg-1; Fri, 13 Mar 2026 03:09:33 -0400
X-MC-Unique: oUBAoRMAP8WbvDRTRSUmeg-1
X-Mimecast-MFC-AGG-ID: oUBAoRMAP8WbvDRTRSUmeg_1773385773
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7986f771f69so81803427b3.1
        for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 00:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773385773; x=1773990573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tGLHHMlkxvn9yOYAE3QMyUNpmuIw499v1QmSDP4J2xQ=;
        b=l8khNMq+NG9lQxfLwwsXAApHtA/yisj89IOcFozqp9x6CUVfKdf/GT708Luk/VCNuv
         SJy6XKdCQJmSTNdiC4edcpBXwpg9CgD780hYRfmiHEdPx4ZgvDorLGI2wQm0frj3wIdT
         /Cg7p/r2Zv9OeQiII7XwZXP69aiSj49teM7WyJmMHvib74/Rvilk1BaXBkn0MXk4+wXV
         0/wvaR/57D5N4un32CojOPYXb16rFlyKZffRFlxgKxGfrCbtChVkXKxxZmp3afsRIZzS
         R6/OR/4CuqXLn/NFEsIQALKmjcGhp0t+Ao9sTW/ZHz/K7VWYJf+/SRZvyCWEUTewLhGV
         PKmA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ2lo4oCX02d9g8ueK0O6Q4rYkDKqTrfJUJhUH0h+S8VgGU0zBbwbYAOiVmSLNjVH/VqfE/ApEOdJVmb05CQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywtg1o9WoFdxPBm23RPFBVDmwVP4l1w9Fqd1w6vXCzaLaFXE4iN
	9ip4VnZr50rrWdh811EABvDIxIzEVitd0fo8rW0V11BBHHR2Iob+2FLp2G7n6vnyzFwvy8R7ktE
	C4ODF4WB+Y6DiJZkxfeGquBAApoIUz8iAbl3jU/KKKq1D7bBT1W812jNQrSCc4G27GRWqLFTdQ9
	uFERJj+UJuIAIpFTVoutiN1NMq1leTukfzcHwLRhrj5P8=
X-Gm-Gg: ATEYQzxUL8IpzC8w9rmPHIpBXXNvLsKjjocW2wa8UaXv6vJWWwNQxoxlSKX3tYPUk0X
	Q2B3B+PHoHHxcxyx3xEtSdY58GnfYwFULrTE1+6QUbs9x//hik1+VIYRCG8svRQyjC6YJqeaLVh
	nlPr/CeR03qLm/3KQFYtREQAJSDULZcjMYVBYnuGg94D4By5OpS2/jKDXIEIl+CHByRl5zB+f5c
	y3Hqg==
X-Received: by 2002:a05:690e:43ce:b0:64a:ce57:cac4 with SMTP id 956f58d0204a3-64e6281c002mr1536219d50.24.1773385772858;
        Fri, 13 Mar 2026 00:09:32 -0700 (PDT)
X-Received: by 2002:a05:690e:43ce:b0:64a:ce57:cac4 with SMTP id
 956f58d0204a3-64e6281c002mr1536209d50.24.1773385772486; Fri, 13 Mar 2026
 00:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310190759.1097506-1-eperezma@redhat.com> <20260310190759.1097506-4-eperezma@redhat.com>
 <CACGkMEvwmC4qiYgZAkrHEC3r3q7FyMiqpg5=2oNMPGm0q=PLBA@mail.gmail.com>
 <CAJaqyWe+x9okNwPD5n6M+PeLt0cQY-_fBWOD9uXSa1nKHqRaFw@mail.gmail.com> <CACGkMEuKTezQQXJ0XEKWEoRaeo-ORcE07+xgSoJ_7UwpPdonWA@mail.gmail.com>
In-Reply-To: <CACGkMEuKTezQQXJ0XEKWEoRaeo-ORcE07+xgSoJ_7UwpPdonWA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 13 Mar 2026 08:08:56 +0100
X-Gm-Features: AaiRm52alvvUvdFbuOzUrnPB80GVd5V2gTPqWE31hSxruyVvFmqg0a2zeu5eLz4
Message-ID: <CAJaqyWf5mnARrEXssKQ2CQB0rZ+KVi_kW1xyOc_Dx1ELAs4LHA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] vduse: add F_QUEUE_READY feature
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 50RgBNHkDvu8wg4zdiTUhLPbuq47im6pLzRc5SHhXNM_1773385773
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 7:05=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Mar 12, 2026 at 2:24=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Thu, Mar 12, 2026 at 4:58=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Mar 11, 2026 at 3:08=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@=
redhat.com> wrote:
> > > >
> > > > Add the VDUSE_F_QUEUE_READY feature flag. This allows the kernel mo=
dule
> > > > to explicitly signal userspace when a specific virtqueue has been
> > > > enabled.
> > > >
> > > > In scenarios like Live Migration of VirtIO net devices, the datapla=
ne
> > > > starts after the control virtqueue allowing QEMU to apply configura=
tion
> > > > in the destination device.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > > v2:
> > > > * Fix comment of vduse_dev_request.vq_ready
> > > > * Set vq_ready before sending the message to the VDUSE userland
> > > >   instance, avoiding the need for SMP sync after receiving the mess=
age.
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++++++++++++=
+-
> > > >  include/uapi/linux/vduse.h         | 18 ++++++++++++++++++
> > > >  2 files changed, 45 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index 17e0358d3a68..4f642b95a7cb 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -9,6 +9,7 @@
> > > >   */
> > > >
> > > >  #include "linux/virtio_net.h"
> > > > +#include <linux/bits.h>
> > > >  #include <linux/cleanup.h>
> > > >  #include <linux/init.h>
> > > >  #include <linux/module.h>
> > > > @@ -53,7 +54,7 @@
> > > >  #define IRQ_UNBOUND -1
> > > >
> > > >  /* Supported VDUSE features */
> > > > -static const uint64_t vduse_features;
> > > > +static const uint64_t vduse_features =3D BIT_U64(VDUSE_F_QUEUE_REA=
DY);
> > > >
> > > >  /*
> > > >   * VDUSE instance have not asked the vduse API version, so assume =
0.
> > > > @@ -120,6 +121,7 @@ struct vduse_dev {
> > > >         char *name;
> > > >         struct mutex lock;
> > > >         spinlock_t msg_lock;
> > > > +       u64 vduse_features;
> > > >         u64 msg_unique;
> > > >         u32 msg_timeout;
> > > >         wait_queue_head_t waitq;
> > > > @@ -601,8 +603,29 @@ static void vduse_vdpa_set_vq_ready(struct vdp=
a_device *vdpa,
> > > >  {
> > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > >         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > +       int r;
> > > >
> > > >         vq->ready =3D ready;
> > > > +
> > > > +       if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUEUE_READY)))
> > > > +               return;
> > > > +
> > > > +       msg.req.type =3D VDUSE_SET_VQ_READY;
> > > > +       msg.req.vq_ready.num =3D idx;
> > > > +       msg.req.vq_ready.ready =3D !!ready;
> > > > +
> > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > +
> > > > +       if (r < 0) {
> > > > +               dev_dbg(&vdpa->dev, "device refuses to set vq %u re=
ady %u",
> > > > +                       idx, ready);
> > > > +
> > > > +               /* We can't do better than break the device in this=
 case */
> > >
> > > It's better to explain why we can't depend on vduse_dev_msg_sync() he=
re.
> > >
> > > For example it did:
> > >
> > >         if (unlikely(dev->broken))
> > >                 return -EIO;
> > >
> > >         init_waitqueue_head(&msg->waitq);
> > >         spin_lock(&dev->msg_lock);
> > >         if (unlikely(dev->broken)) {
> > >                 spin_unlock(&dev->msg_lock);
> > >                 return -EIO;
> > >         }
> > >
> > > and
> > >
> > >         if (!msg->completed) {
> > >                 list_del(&msg->list);
> > >                 msg->resp.result =3D VDUSE_REQ_RESULT_FAILED;
> > >                 /* Mark the device as malfunction when there is a tim=
eout */
> > >                 if (!ret)
> > >                         vduse_dev_broken(dev);
> > >         }
> > >
> >
> > I'm not sure I follow you here.
> >
> > We can't do better than breaking the device because the function
> > returns no error state, and the caller does not expect an error code.
> > Do you mean we can't depend on vduse_dev_msg_sync to call
> > vduse_dev_broken(dev) by itself?
>
> I think I meant, reset seems to be more heavyweight than suspend.
>
> So if reset can fail, I don't see reason ot break device only for
> suspend failure.
>

Sorry I still don't get you.

This series does not implement suspend at all. It doesn't modify the
VDUSE device reset or the virtio reset behavior. It only implements
the vq ready message for the device. If the device returns an error
from that operation, what is your proposal for when the driver sends
new messages like resume?

> Thanks
>
> >
> > > > +               spin_lock(&dev->msg_lock);
> > > > +               vduse_dev_broken(dev);
> > > > +               spin_unlock(&dev->msg_lock);
> > > > +       }
> > > >  }
> > > >
> > > >  static bool vduse_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 =
idx)
> > > > @@ -2078,6 +2101,9 @@ static int vduse_create_dev(struct vduse_dev_=
config *config,
> > > >         dev->device_features =3D config->features;
> > > >         dev->device_id =3D config->device_id;
> > > >         dev->vendor_id =3D config->vendor_id;
> > > > +       dev->vduse_features =3D config->vduse_features;
> > > > +       dev_dbg(vduse_ctrl_dev, "Creating device %s with features 0=
x%llx",
> > > > +               config->name, config->vduse_features);
> > > >
> > > >         dev->nas =3D (dev->api_version < VDUSE_API_VERSION_1) ? 1 :=
 config->nas;
> > > >         dev->as =3D kcalloc(dev->nas, sizeof(dev->as[0]), GFP_KERNE=
L);
> > > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.=
h
> > > > index e9b5f32a452d..7324faea5df4 100644
> > > > --- a/include/uapi/linux/vduse.h
> > > > +++ b/include/uapi/linux/vduse.h
> > > > @@ -14,6 +14,9 @@
> > > >
> > > >  #define VDUSE_API_VERSION_1    1
> > > >
> > > > +/* The VDUSE instance expects a request for vq ready */
> > > > +#define VDUSE_F_QUEUE_READY    0
> > > > +
> > > >  /*
> > > >   * Get the version of VDUSE API that kernel supported (VDUSE_API_V=
ERSION).
> > > >   * This is used for future extension.
> > > > @@ -330,6 +333,7 @@ enum vduse_req_type {
> > > >         VDUSE_SET_STATUS,
> > > >         VDUSE_UPDATE_IOTLB,
> > > >         VDUSE_SET_VQ_GROUP_ASID,
> > > > +       VDUSE_SET_VQ_READY,
> > > >  };
> > > >
> > > >  /**
> > > > @@ -377,6 +381,15 @@ struct vduse_iova_range_v2 {
> > > >         __u32 padding;
> > > >  };
> > > >
> > > > +/**
> > > > + * struct vduse_vq_ready - Virtqueue ready request message
> > > > + * @num: Virtqueue number
> > > > + */
> > > > +struct vduse_vq_ready {
> > > > +       __u32 num;
> > > > +       __u32 ready;
> > > > +};
> > > > +
> > > >  /**
> > > >   * struct vduse_dev_request - control request
> > > >   * @type: request type
> > > > @@ -387,6 +400,7 @@ struct vduse_iova_range_v2 {
> > > >   * @iova: IOVA range for updating
> > > >   * @iova_v2: IOVA range for updating if API_VERSION >=3D 1
> > > >   * @vq_group_asid: ASID of a virtqueue group
> > > > + * @vq_ready: Virtqueue ready request
> > > >   * @padding: padding
> > > >   *
> > > >   * Structure used by read(2) on /dev/vduse/$NAME.
> > > > @@ -404,6 +418,10 @@ struct vduse_dev_request {
> > > >                  */
> > > >                 struct vduse_iova_range_v2 iova_v2;
> > > >                 struct vduse_vq_group_asid vq_group_asid;
> > > > +
> > > > +               /* Only if VDUSE_F_QUEUE_READY is negotiated */
> > > > +               struct vduse_vq_ready vq_ready;
> > > > +
> > > >                 __u32 padding[32];
> > > >         };
> > > >  };
> > > > --
> > > > 2.53.0
> > > >
> > >
> > > Thanks
> > >
> >
>

