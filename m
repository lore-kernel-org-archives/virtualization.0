Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C38330B0B
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 06:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773381915; cv=none; b=dO7NT4RxF0IUrHycro5MtQ2Ihb4ZOpYTaCifHeNh166juzjmI6U5b7L6e2rvTM4WR2l9y5/Jb/QAxrFJfV/goNejAySTEoHgkGywgKy1mW3EgxuL30Y9DrfaJrml3kvJkPySW7vnTdYT0Cr8YluN1BrNVWmqAcAO5cxWlXDrejc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773381915; c=relaxed/simple;
	bh=p1hfP9kqQCTwkV8L4zd6axfh6fsKks9x78kfI5PwrY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvN3f5XyMcAK5W25tTUvHNCrfsyOxbhe3JRkf6MNDYqP4RS8/xAYi1pSpPeM6f2J3C+LhrLjgnCaPY3pZYogx4kz1v817kEg/ZTY5JdTOny/FfJRVkAIPgJv96L58GQ9kjmo8XA/J1wjeXpg62+AMyuLKLCNjzZtyjSoycsTTlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQfOQA50; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQfOQA50"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773381909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIh20M3zcFewEIyrSyj3ncpFpGqaFulOVyd58s20MRg=;
	b=SQfOQA50fNnLLqppwZYmxc5C+GvJ7Gx+vxV95whMzJwNqezOcTj3fwivAvUcJj2phmFco/
	ZZIcRA5IlYbudQLdFHMbhdv1KMCh5lANVS+nA42WgoTPlXc372+Syfu7y7sMI0jPUjiOg4
	hnJBZbwC0hBRmMiZUqLpCbGxsQKg6xk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-Oyv_BSrMPs6jSCI-anM-6Q-1; Fri, 13 Mar 2026 02:05:08 -0400
X-MC-Unique: Oyv_BSrMPs6jSCI-anM-6Q-1
X-Mimecast-MFC-AGG-ID: Oyv_BSrMPs6jSCI-anM-6Q_1773381907
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c7385a1476aso1026780a12.2
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 23:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773381907; x=1773986707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZIh20M3zcFewEIyrSyj3ncpFpGqaFulOVyd58s20MRg=;
        b=oztDUMF2h+k66Aoi/Z2WvYV8PbEQObqKIFsHK18sBdUG8Ac01dqv+kmpGRShxkf8WM
         lcOoCYjpN5cxM9RcB6nNF5WgefLmkSYboqXBSQzdmLd+4KWSFmpYDBV3ccxa5DAEB5lQ
         1nqvrWZS1TZ3OAB0SR+myNKjG4qAJvPfzCAkfUeGWr9VbS/70T1kRflsqO8TFXsqoYzA
         pUhaGyx3Rl/Fk1YKMItaa9FektOCasR+Xj+fupf/NjmhZ3b8y0rR1MpfPLX424QOsRHz
         V67I5Dje2iwTgb2AFAWCZMasehwiJG9trBmTSlEE6o2436lVincXMviCn255U48tmgr4
         fnTw==
X-Forwarded-Encrypted: i=1; AJvYcCXZyVKTO6w5JqoiaNk00l5aAFfk4jZgBZPYCorFioLZd6pDldrYSRrM+WxtL020IYn3Hn5310agAn+5d3pIbg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyuy0SmomhMD7Fm14sxmbono1rXBSVfUjsf3e1Rqbnq7pbo0kZe
	Srt2AvqgBoX10AWvVwDzBSvQLim2xTi8WgtFaKVr67EuVmPJ25KwUbYuqZ8/6x60+naUxUq3IsA
	Ul3v2IEkgitEre8Z6qpM14AYQvyJe+Y18CpGlf2bqCBSczXcuQlgxi1rNHQ91EiEpVZtETDthgi
	5gEDIgaWMBaz1ciGDJqa30/saHiZkn3VgyLyWubfcgows=
X-Gm-Gg: ATEYQzw47hJvsr3X1uhs6bBDhUYTbKIPxW0UpLueC8SXcwDfKsBrH52dzVGzzc4d/R1
	iUIErpd3yRR9G647sfSbm9nUowaUrfIxe16wYhcdWvGJ0JDJ6AP5SyfdmNWpqiPOBW523CJk3gG
	VV8g+3glSKQZbK+cisDgmUAcrT1Sy5DE6KTw+z+Dde6rTIj1vngmw4lqxFx6F7i0BJ4T+W7h3hB
	ok=
X-Received: by 2002:a05:6a20:3d86:b0:398:8a92:78a5 with SMTP id adf61e73a8af0-398ecaf85c3mr1816758637.28.1773381907315;
        Thu, 12 Mar 2026 23:05:07 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d86:b0:398:8a92:78a5 with SMTP id
 adf61e73a8af0-398ecaf85c3mr1816727637.28.1773381906831; Thu, 12 Mar 2026
 23:05:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310190759.1097506-1-eperezma@redhat.com> <20260310190759.1097506-4-eperezma@redhat.com>
 <CACGkMEvwmC4qiYgZAkrHEC3r3q7FyMiqpg5=2oNMPGm0q=PLBA@mail.gmail.com> <CAJaqyWe+x9okNwPD5n6M+PeLt0cQY-_fBWOD9uXSa1nKHqRaFw@mail.gmail.com>
In-Reply-To: <CAJaqyWe+x9okNwPD5n6M+PeLt0cQY-_fBWOD9uXSa1nKHqRaFw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Mar 2026 14:04:55 +0800
X-Gm-Features: AaiRm529ANLJLPmgCDmdBK8siQ3PN1yeg5O7XicKV0Ebcng3zaVyXK3FUKdJFXQ
Message-ID: <CACGkMEuKTezQQXJ0XEKWEoRaeo-ORcE07+xgSoJ_7UwpPdonWA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] vduse: add F_QUEUE_READY feature
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c5iW65r_k9dhx2MeknxiaUal78MWqLkzUvfC8RTazn4_1773381907
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 2:24=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Mar 12, 2026 at 4:58=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Mar 11, 2026 at 3:08=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Add the VDUSE_F_QUEUE_READY feature flag. This allows the kernel modu=
le
> > > to explicitly signal userspace when a specific virtqueue has been
> > > enabled.
> > >
> > > In scenarios like Live Migration of VirtIO net devices, the dataplane
> > > starts after the control virtqueue allowing QEMU to apply configurati=
on
> > > in the destination device.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > v2:
> > > * Fix comment of vduse_dev_request.vq_ready
> > > * Set vq_ready before sending the message to the VDUSE userland
> > >   instance, avoiding the need for SMP sync after receiving the messag=
e.
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 +++++++++++++++++++++++++++-
> > >  include/uapi/linux/vduse.h         | 18 ++++++++++++++++++
> > >  2 files changed, 45 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 17e0358d3a68..4f642b95a7cb 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -9,6 +9,7 @@
> > >   */
> > >
> > >  #include "linux/virtio_net.h"
> > > +#include <linux/bits.h>
> > >  #include <linux/cleanup.h>
> > >  #include <linux/init.h>
> > >  #include <linux/module.h>
> > > @@ -53,7 +54,7 @@
> > >  #define IRQ_UNBOUND -1
> > >
> > >  /* Supported VDUSE features */
> > > -static const uint64_t vduse_features;
> > > +static const uint64_t vduse_features =3D BIT_U64(VDUSE_F_QUEUE_READY=
);
> > >
> > >  /*
> > >   * VDUSE instance have not asked the vduse API version, so assume 0.
> > > @@ -120,6 +121,7 @@ struct vduse_dev {
> > >         char *name;
> > >         struct mutex lock;
> > >         spinlock_t msg_lock;
> > > +       u64 vduse_features;
> > >         u64 msg_unique;
> > >         u32 msg_timeout;
> > >         wait_queue_head_t waitq;
> > > @@ -601,8 +603,29 @@ static void vduse_vdpa_set_vq_ready(struct vdpa_=
device *vdpa,
> > >  {
> > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > >         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> > > +       struct vduse_dev_msg msg =3D { 0 };
> > > +       int r;
> > >
> > >         vq->ready =3D ready;
> > > +
> > > +       if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUEUE_READY)))
> > > +               return;
> > > +
> > > +       msg.req.type =3D VDUSE_SET_VQ_READY;
> > > +       msg.req.vq_ready.num =3D idx;
> > > +       msg.req.vq_ready.ready =3D !!ready;
> > > +
> > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > +
> > > +       if (r < 0) {
> > > +               dev_dbg(&vdpa->dev, "device refuses to set vq %u read=
y %u",
> > > +                       idx, ready);
> > > +
> > > +               /* We can't do better than break the device in this c=
ase */
> >
> > It's better to explain why we can't depend on vduse_dev_msg_sync() here=
.
> >
> > For example it did:
> >
> >         if (unlikely(dev->broken))
> >                 return -EIO;
> >
> >         init_waitqueue_head(&msg->waitq);
> >         spin_lock(&dev->msg_lock);
> >         if (unlikely(dev->broken)) {
> >                 spin_unlock(&dev->msg_lock);
> >                 return -EIO;
> >         }
> >
> > and
> >
> >         if (!msg->completed) {
> >                 list_del(&msg->list);
> >                 msg->resp.result =3D VDUSE_REQ_RESULT_FAILED;
> >                 /* Mark the device as malfunction when there is a timeo=
ut */
> >                 if (!ret)
> >                         vduse_dev_broken(dev);
> >         }
> >
>
> I'm not sure I follow you here.
>
> We can't do better than breaking the device because the function
> returns no error state, and the caller does not expect an error code.
> Do you mean we can't depend on vduse_dev_msg_sync to call
> vduse_dev_broken(dev) by itself?

I think I meant, reset seems to be more heavyweight than suspend.

So if reset can fail, I don't see reason ot break device only for
suspend failure.

Thanks

>
> > > +               spin_lock(&dev->msg_lock);
> > > +               vduse_dev_broken(dev);
> > > +               spin_unlock(&dev->msg_lock);
> > > +       }
> > >  }
> > >
> > >  static bool vduse_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 id=
x)
> > > @@ -2078,6 +2101,9 @@ static int vduse_create_dev(struct vduse_dev_co=
nfig *config,
> > >         dev->device_features =3D config->features;
> > >         dev->device_id =3D config->device_id;
> > >         dev->vendor_id =3D config->vendor_id;
> > > +       dev->vduse_features =3D config->vduse_features;
> > > +       dev_dbg(vduse_ctrl_dev, "Creating device %s with features 0x%=
llx",
> > > +               config->name, config->vduse_features);
> > >
> > >         dev->nas =3D (dev->api_version < VDUSE_API_VERSION_1) ? 1 : c=
onfig->nas;
> > >         dev->as =3D kcalloc(dev->nas, sizeof(dev->as[0]), GFP_KERNEL)=
;
> > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > index e9b5f32a452d..7324faea5df4 100644
> > > --- a/include/uapi/linux/vduse.h
> > > +++ b/include/uapi/linux/vduse.h
> > > @@ -14,6 +14,9 @@
> > >
> > >  #define VDUSE_API_VERSION_1    1
> > >
> > > +/* The VDUSE instance expects a request for vq ready */
> > > +#define VDUSE_F_QUEUE_READY    0
> > > +
> > >  /*
> > >   * Get the version of VDUSE API that kernel supported (VDUSE_API_VER=
SION).
> > >   * This is used for future extension.
> > > @@ -330,6 +333,7 @@ enum vduse_req_type {
> > >         VDUSE_SET_STATUS,
> > >         VDUSE_UPDATE_IOTLB,
> > >         VDUSE_SET_VQ_GROUP_ASID,
> > > +       VDUSE_SET_VQ_READY,
> > >  };
> > >
> > >  /**
> > > @@ -377,6 +381,15 @@ struct vduse_iova_range_v2 {
> > >         __u32 padding;
> > >  };
> > >
> > > +/**
> > > + * struct vduse_vq_ready - Virtqueue ready request message
> > > + * @num: Virtqueue number
> > > + */
> > > +struct vduse_vq_ready {
> > > +       __u32 num;
> > > +       __u32 ready;
> > > +};
> > > +
> > >  /**
> > >   * struct vduse_dev_request - control request
> > >   * @type: request type
> > > @@ -387,6 +400,7 @@ struct vduse_iova_range_v2 {
> > >   * @iova: IOVA range for updating
> > >   * @iova_v2: IOVA range for updating if API_VERSION >=3D 1
> > >   * @vq_group_asid: ASID of a virtqueue group
> > > + * @vq_ready: Virtqueue ready request
> > >   * @padding: padding
> > >   *
> > >   * Structure used by read(2) on /dev/vduse/$NAME.
> > > @@ -404,6 +418,10 @@ struct vduse_dev_request {
> > >                  */
> > >                 struct vduse_iova_range_v2 iova_v2;
> > >                 struct vduse_vq_group_asid vq_group_asid;
> > > +
> > > +               /* Only if VDUSE_F_QUEUE_READY is negotiated */
> > > +               struct vduse_vq_ready vq_ready;
> > > +
> > >                 __u32 padding[32];
> > >         };
> > >  };
> > > --
> > > 2.53.0
> > >
> >
> > Thanks
> >
>

