Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E74273D8D
	for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769668004; cv=none; b=iIE0ldGYtI2etkLp7pURZkiUbr+sh8DzXFTDJx2ALARaY2d9rkWa6NehZ5KuIErYVeEBPF9J3h0lcuoKeu+A4TriR6ZVd/tQLxnYebJKqO+HLWexc5HAq9aGatCmVEqSMqBkSvXe5Kl4vMu/iyuziLcUR3wqwf+scQqFESjERb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769668004; c=relaxed/simple;
	bh=mBj/lNBLU520Nu/WoebEFbbg8DJogOSQSBU2JVGFtTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGXuy3ORtrmlhh0aq+CXLM8ayl0yYa+ytFysBpDDdFso1YjopBSqIg8PMGHk8ht0bkh4+y1wjSkiABOQcmvmy/zSw2dx/2ey6W6CkwBzapDmHhjczicIuKwCSlZ5UnVFg6moqJ03zhewout8TalA+4anB55AHGqDmkRAIo2xjgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4IfOpkB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4IfOpkB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769668001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/Sshgb0i0F6ZLu2U6Q0l3JX/CsW0xM0V4+hKEXnYnI=;
	b=a4IfOpkBNVwQtBt/3xs3IZMk3oKuCQ5rhTs7ObhgdC2dgV/nxYvgYsFAGWPDIU8+k3Ghfv
	O3nYEDZ/UVDBzpFSaEHntXaSKnF+48IvZZHQXaF8W0xF9mSDxWJjXfI88BgZNQbXk9Upla
	PfeyS1FZHzKnl+ZZbGDvVFN76PR/y3Y=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-1xdL-ookMcSNMY6zAMNPlw-1; Thu, 29 Jan 2026 01:26:39 -0500
X-MC-Unique: 1xdL-ookMcSNMY6zAMNPlw-1
X-Mimecast-MFC-AGG-ID: 1xdL-ookMcSNMY6zAMNPlw_1769667999
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7948fd222d0so10075897b3.3
        for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 22:26:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769667999; x=1770272799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j/Sshgb0i0F6ZLu2U6Q0l3JX/CsW0xM0V4+hKEXnYnI=;
        b=dFPpMoFwe5ytbVW6+r7o11aaHK/MwfCDc4RXdUwzoyOLHofjhEiqglmmj2XIQ8G16A
         w9taCdu0NFCHtH/jwYVutSYCEg251y/CqOcrTcdUWLSuzobhfzj6n1HtuLQIXrp1xp+i
         PfuN/cv4NA2Txh6Se0qmuGAZLm7tOEXujT2VyQsbPwaAlYkiu7+meBa2GEO/akQqfdO5
         C06DucAHHDr8Gj/LE0ySHmWzqk4nRi1B1WdDLAJNWd2JZtCWYq5TrOkhKbT+vqxrZ+sP
         dPplarPp0zP+SKUJzQAs+OSp4tiWlUcVJbopk+lXNhhs/M4lFigXsuLyYuGxiwJiBFrp
         k/8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQeMFPjw1w8raQ4y0qA0iAHv6cE2FfYMj9733laRybLmfAm343gF3r8VxKInId16HCMpWKF0wf4HXAQxUaZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCyJ1Zx6dzQ/lMl9g6ArYOISw0KetAHTANN5qpnDWiGRtOHNdX
	WoxCE9PW6frpVlhpqlEyaXNfTAjmtL7IBYvK1N2DS/mstHxRFiXmJPcKgoWol7eS6KMQVVVXkr2
	UGjMugsB4iMKa0LIbYrCIhK21c7gTMDMXE+UBV3r5fuYfJVbRHMPg6xS58k+JQW7rXFSuCGccDo
	TRKeJXj12GRal7WUBv3D2cp4v1eVGpLGSvBUvul4vu0EE=
X-Gm-Gg: AZuq6aL4R9XvxTj3pChXKer3O8GOP30FXtFgqOyNAucUvwqx0QWMEDYyKaxFzkUnCTN
	967SDU/KlW56ZT+O2LC29fxPNAjpvM+nmgBVjIWLodsvEAX3hmdsbo1s42IVKwBNyWyReQbLuWA
	QpWaeUuyEFjMv6ZorLXLJH6BupJeIE+KVw5fLGwHVsrO0J4c4+NT6ArVUPf1sOOh8WyA==
X-Received: by 2002:a05:690c:314:b0:794:7866:2611 with SMTP id 00721157ae682-7947aa17549mr63435387b3.1.1769667999377;
        Wed, 28 Jan 2026 22:26:39 -0800 (PST)
X-Received: by 2002:a05:690c:314:b0:794:7866:2611 with SMTP id
 00721157ae682-7947aa17549mr63435277b3.1.1769667999002; Wed, 28 Jan 2026
 22:26:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128124524.875271-1-eperezma@redhat.com> <20260128124524.875271-6-eperezma@redhat.com>
 <CACGkMEtuAG-uZYJWZcsT1A0+QBCTOnkr7m0dt8MdbTwd5UNyNw@mail.gmail.com>
In-Reply-To: <CACGkMEtuAG-uZYJWZcsT1A0+QBCTOnkr7m0dt8MdbTwd5UNyNw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 29 Jan 2026 07:26:02 +0100
X-Gm-Features: AZwV_QgHM6k4hECc7ue71EnwU1wBsYl6Iqf793Dic5kbqbPwDtWxxMAlC-1iUTU
Message-ID: <CAJaqyWc8_B82n1a3JaBKKvhkWN=Rs93=kcfCU6e9RfzsPXdF5g@mail.gmail.com>
Subject: Re: [PATCH 5/6] vduse: add F_QUEUE_READY feature
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0McNyRewwsNcgtQe8UzcVhEG-5gJwCjwsFq1YAmNbAs_1769667999
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 3:12=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
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
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 +++++++++++++++++++++++++++-
> >  include/uapi/linux/vduse.h         | 19 +++++++++++++++++++
> >  2 files changed, 46 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index e7da69c2ad71..1d93b540db4d 100644
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
> > @@ -619,7 +621,30 @@ static void vduse_vdpa_set_vq_ready(struct vdpa_de=
vice *vdpa,
> >  {
> >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> >         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> > +       struct vduse_dev_msg msg =3D { 0 };
> > +       int r;
> > +
> > +       if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUEUE_READY)))
> > +               goto out;
> > +
> > +       msg.req.type =3D VDUSE_SET_VQ_READY;
> > +       msg.req.vq_ready.num =3D idx;
> > +       msg.req.vq_ready.ready =3D !!ready;
> > +
> > +       r =3D vduse_dev_msg_sync(dev, &msg);
> >
> > +       if (r < 0) {
> > +               dev_dbg(&vdpa->dev, "device refuses to set vq %u ready =
%u",
> > +                       idx, ready);
> > +
> > +               /* We can't do better than break the device in this cas=
e */
> > +               spin_lock(&dev->msg_lock);
> > +               vduse_dev_broken(dev);
>
> This has been done by vduse_dev_msg_sync().
>

This is done by msg_sync() when userland does not reply in a
timeframe, but not when userland replies with VDUSE_REQ_RESULT_FAILED.
Should I add a comment?

