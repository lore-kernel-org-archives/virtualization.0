Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C866F3FCB1E
	for <virtualization@lists.linux.dev>; Tue, 24 Mar 2026 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774360956; cv=none; b=lMjZn8izxO+RCs2/rTNb3epej4hfKGLgDo4NomKx13Du2fUr4rQF6M5Z7CNORVaNBLjwbYN8pJjtLLC+H4Fx3fgf4lFSl3OvHwdqduFjX9mCzappR3SK5HWnCpc+IMwCDT7Nvs+EQ15THXSCTwjPaSmJuyc/ddS1wkU1spjxIPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774360956; c=relaxed/simple;
	bh=i5XS5OV/+6tUO7TAS6jrPF3SxKNTVoq67pMTbn5wrcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nit7TAPxEiOA7IV4zl7aoMsH4GVGZqPy5yi5bqn02oSvyZkwZ6oXEpz2Jvs26vE44ZL7PanzjpP+JNCbRXAjKD2dMAG34XBPUSxIH0TrU/Rnte0omKpJiXKcCDSqPElLHJADohWrZhcJykNbZYmI1H2IlQ98u5JNs0ILUsS6pSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fbvpbn9l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbvpbn9l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774360951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mlvPDahKX2NFF6xhr+4/ztQAmDK+1ra9fm020urxfp0=;
	b=fbvpbn9lQjU1EU50XY27Ulx0BU0J4RCKRfzXoIcD0nKB0Ry4YS3gH5X4sjmZ8xn7JgmeLz
	iTkWDE9hea0Jys+JvWsC3cSiwMZs8lKAcbkM5DbTcZAZX005wMThfT21FBD4yNjgQYzBsT
	zPaq1/CTWSC8qJzj7dH5w1eBqBGOC/I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-Xc0hhLGdMuKk5XSqqlRNaA-1; Tue, 24 Mar 2026 10:02:28 -0400
X-MC-Unique: Xc0hhLGdMuKk5XSqqlRNaA-1
X-Mimecast-MFC-AGG-ID: Xc0hhLGdMuKk5XSqqlRNaA_1774360946
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5a1499d93a1so3032294e87.1
        for <virtualization@lists.linux.dev>; Tue, 24 Mar 2026 07:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774360946; x=1774965746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mlvPDahKX2NFF6xhr+4/ztQAmDK+1ra9fm020urxfp0=;
        b=oR7uzTLpHwv1jdq/PE+mTSAimk00vvpLHnCLljIHbyWcF+9qrsKNJhUOtJQxN3UY1c
         ZznSIXFdixE43cAux2gdh3SjfqmdfDu6mlX7SF1WumELsVCcgmZw8uIUEmmNeOMC0s8Y
         ql46btaOlJMB1GhVTOeu7J4EoAAttNITQUWQuaWmaCRVfkZZZtwkiEdxJLARo1nhYYpI
         UpCWDABLNrKxO0fclzmIRX30oIFcfy8PdVu/SEM5CbNgD/vvHtrXynd613c07LGr09Od
         4s+bG+O4twy5AQnz7YjtUJRkb0lJHwe/Abp3ursHhHu57xAHmaDJuCrwCap5fAmQxAZc
         P9MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfdx2SL+lBkji7/yjoxLPIobuctXxebWUnBI2wjFFTjRiIv/aOOcApRYK0vd4vzNeyxrxqxYHKk+V4+XJrVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrGrm4uIa1w88fozlx5O+hAE8/wnSXxu5T6zvvf7Yr00PqLCA7
	+Med+ntaCRZ/4d7/psU65uSsp+qsGVfbqzWuGIIsfiddTF73meGIrunEGOqumY3y7TmdUt6uYwp
	faXJR8/ToR4PhbP1CfAyejxnnScsMo5Ol2ptoQof9fFH3MmlQbIuwASr+NVQTqs5S+YEoxYMAzz
	D0253TgO4vPrIOLxud4FeWhesG5IBRB2svxycI21O9Wd4=
X-Gm-Gg: ATEYQzyjL3gTc+ni94bJWly2DaBRKiDggz+KAxwdJEFqv4tOZ4a5IMib7kAAQN8KsE+
	rRDCceyPom3zPyLynrBNhM04hm8imHZhNhMzHQjQY3nMlNhsOsz/c++QhI+T8iycATk0DxbQgSt
	/cvj8Ixr+rY5asunQIrTWDXLMJvnRh/fZMddlR8uSMahxxlH/9iW37f11Fd/eTrpsP8rIinWTmL
	2EIRA==
X-Received: by 2002:a05:6512:3d20:b0:5a1:2e7b:d885 with SMTP id 2adb3069b0e04-5a296220848mr1328731e87.25.1774360946183;
        Tue, 24 Mar 2026 07:02:26 -0700 (PDT)
X-Received: by 2002:a05:6512:3d20:b0:5a1:2e7b:d885 with SMTP id
 2adb3069b0e04-5a296220848mr1328700e87.25.1774360945532; Tue, 24 Mar 2026
 07:02:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310190759.1097506-1-eperezma@redhat.com> <20260310190759.1097506-4-eperezma@redhat.com>
 <CACGkMEvwmC4qiYgZAkrHEC3r3q7FyMiqpg5=2oNMPGm0q=PLBA@mail.gmail.com>
 <CAJaqyWe+x9okNwPD5n6M+PeLt0cQY-_fBWOD9uXSa1nKHqRaFw@mail.gmail.com>
 <CACGkMEuKTezQQXJ0XEKWEoRaeo-ORcE07+xgSoJ_7UwpPdonWA@mail.gmail.com> <CAJaqyWf5mnARrEXssKQ2CQB0rZ+KVi_kW1xyOc_Dx1ELAs4LHA@mail.gmail.com>
In-Reply-To: <CAJaqyWf5mnARrEXssKQ2CQB0rZ+KVi_kW1xyOc_Dx1ELAs4LHA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 24 Mar 2026 15:01:47 +0100
X-Gm-Features: AaiRm50XGJ92Ixi_DiKijf_WMmkWP6yH4dOrpt7f5HtlD3f-L_Ghpm4ryJcdwlE
Message-ID: <CAJaqyWd40=bxMOwTR4wyHtPS_-Txn2WbwSj9rZEXoY-4DxQgpw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] vduse: add F_QUEUE_READY feature
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zhQUDqUYj9EUagUahdCfZd65XSoWDnKodG8TkHrZ-jY_1774360946
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 8:08=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Mar 13, 2026 at 7:05=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Mar 12, 2026 at 2:24=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Thu, Mar 12, 2026 at 4:58=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Wed, Mar 11, 2026 at 3:08=E2=80=AFAM Eugenio P=C3=A9rez <eperezm=
a@redhat.com> wrote:
> > > > >
> > > > > Add the VDUSE_F_QUEUE_READY feature flag. This allows the kernel =
module
> > > > > to explicitly signal userspace when a specific virtqueue has been
> > > > > enabled.
> > > > >
> > > > > In scenarios like Live Migration of VirtIO net devices, the datap=
lane
> > > > > starts after the control virtqueue allowing QEMU to apply configu=
ration
> > > > > in the destination device.
> > > > >
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > ---
> > > > > v2:
> > > > > * Fix comment of vduse_dev_request.vq_ready
> > > > > * Set vq_ready before sending the message to the VDUSE userland
> > > > >   instance, avoiding the need for SMP sync after receiving the me=
ssage.
> > > > > ---
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++++++++++=
+++-
> > > > >  include/uapi/linux/vduse.h         | 18 ++++++++++++++++++
> > > > >  2 files changed, 45 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vd=
pa_user/vduse_dev.c
> > > > > index 17e0358d3a68..4f642b95a7cb 100644
> > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > @@ -9,6 +9,7 @@
> > > > >   */
> > > > >
> > > > >  #include "linux/virtio_net.h"
> > > > > +#include <linux/bits.h>
> > > > >  #include <linux/cleanup.h>
> > > > >  #include <linux/init.h>
> > > > >  #include <linux/module.h>
> > > > > @@ -53,7 +54,7 @@
> > > > >  #define IRQ_UNBOUND -1
> > > > >
> > > > >  /* Supported VDUSE features */
> > > > > -static const uint64_t vduse_features;
> > > > > +static const uint64_t vduse_features =3D BIT_U64(VDUSE_F_QUEUE_R=
EADY);
> > > > >
> > > > >  /*
> > > > >   * VDUSE instance have not asked the vduse API version, so assum=
e 0.
> > > > > @@ -120,6 +121,7 @@ struct vduse_dev {
> > > > >         char *name;
> > > > >         struct mutex lock;
> > > > >         spinlock_t msg_lock;
> > > > > +       u64 vduse_features;
> > > > >         u64 msg_unique;
> > > > >         u32 msg_timeout;
> > > > >         wait_queue_head_t waitq;
> > > > > @@ -601,8 +603,29 @@ static void vduse_vdpa_set_vq_ready(struct v=
dpa_device *vdpa,
> > > > >  {
> > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > >         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > +       int r;
> > > > >
> > > > >         vq->ready =3D ready;
> > > > > +
> > > > > +       if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUEUE_READY))=
)
> > > > > +               return;
> > > > > +
> > > > > +       msg.req.type =3D VDUSE_SET_VQ_READY;
> > > > > +       msg.req.vq_ready.num =3D idx;
> > > > > +       msg.req.vq_ready.ready =3D !!ready;
> > > > > +
> > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > +
> > > > > +       if (r < 0) {
> > > > > +               dev_dbg(&vdpa->dev, "device refuses to set vq %u =
ready %u",
> > > > > +                       idx, ready);
> > > > > +
> > > > > +               /* We can't do better than break the device in th=
is case */
> > > >
> > > > It's better to explain why we can't depend on vduse_dev_msg_sync() =
here.
> > > >
> > > > For example it did:
> > > >
> > > >         if (unlikely(dev->broken))
> > > >                 return -EIO;
> > > >
> > > >         init_waitqueue_head(&msg->waitq);
> > > >         spin_lock(&dev->msg_lock);
> > > >         if (unlikely(dev->broken)) {
> > > >                 spin_unlock(&dev->msg_lock);
> > > >                 return -EIO;
> > > >         }
> > > >
> > > > and
> > > >
> > > >         if (!msg->completed) {
> > > >                 list_del(&msg->list);
> > > >                 msg->resp.result =3D VDUSE_REQ_RESULT_FAILED;
> > > >                 /* Mark the device as malfunction when there is a t=
imeout */
> > > >                 if (!ret)
> > > >                         vduse_dev_broken(dev);
> > > >         }
> > > >
> > >
> > > I'm not sure I follow you here.
> > >
> > > We can't do better than breaking the device because the function
> > > returns no error state, and the caller does not expect an error code.
> > > Do you mean we can't depend on vduse_dev_msg_sync to call
> > > vduse_dev_broken(dev) by itself?
> >
> > I think I meant, reset seems to be more heavyweight than suspend.
> >
> > So if reset can fail, I don't see reason ot break device only for
> > suspend failure.
> >
>
> Sorry I still don't get you.
>
> This series does not implement suspend at all. It doesn't modify the
> VDUSE device reset or the virtio reset behavior. It only implements
> the vq ready message for the device. If the device returns an error
> from that operation, what is your proposal for when the driver sends
> new messages like resume?
>

Friendly ping.

