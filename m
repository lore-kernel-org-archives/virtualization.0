Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665C338F94F
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770103721; cv=none; b=Z7hCZHWFfiTq65xbI5EPmBKNLyHt04qOt7d2hyZaS0LQr64Ebp3JzzXinVOsOV558x+cROSn+cZrCWNBfcEGROTAyWqElFejl00t6xBG12g9YpuqbxymgqXoIfgxGtMNjHF8Hmp4/GAu6faKKTS8sCro/JKL+BueQRQm3EayD7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770103721; c=relaxed/simple;
	bh=ifJHSAEIlWofq7+TD4J/Le9Zdb9sbW42a6SjyKV5L3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILP1atq6vX8BinCM0OQJOGC4QmWFOwjwLacPPoCRbyYmB/q4CD1I6zllSnwgRwHYhPng3mpKWkyUN7jt4eGq2aNmMruLP+ivrzAltf10JV/8VKPxmnIIMowGTWLCDWr7NK3c1o/TWwrMtx8MdN5l5nsHbskeOueg1c1GqFqxkKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJ3GqPD0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJ3GqPD0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770103718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PaD4rdR6B8l3ZFThiKaJdCFlD5QDIE6jFqV3PYvyKEM=;
	b=hJ3GqPD0jnq5UgGP/5Bg1ePxESTKog2Z8qNVnDYRtTZDz5dXB92RYZqAnalVNdQiDq9pOk
	M2Aom2/JcEQPByf2xCXGETUCj0BwvOFWxgEdOPmYViJ5EGjxaCQ2wpMxj7W9v5SNy3tJrY
	FuampZSRpof4IvvXxDjHlefvnR5lqok=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-puYhD8TwO-im-Z1OU74wLg-1; Tue, 03 Feb 2026 02:28:37 -0500
X-MC-Unique: puYhD8TwO-im-Z1OU74wLg-1
X-Mimecast-MFC-AGG-ID: puYhD8TwO-im-Z1OU74wLg_1770103716
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-794969ae1caso74315947b3.1
        for <virtualization@lists.linux.dev>; Mon, 02 Feb 2026 23:28:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770103716; x=1770708516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PaD4rdR6B8l3ZFThiKaJdCFlD5QDIE6jFqV3PYvyKEM=;
        b=pKAUtZ4tycQr8xQcbHjdgl1nRfv4VGJFT8EcjKSD2BqFaLQ1xVY3OVGHWw0PeKhSOu
         g3r8ue41URLvVrBv7fPfcaQk9cS0ByFqleQD+FOZcuU7L/gs2T4yL/SzP8PVk1u/OmyT
         ktOexbcUJBy+LOhejG+OvMawL692no7jH+XgMq5WRGAKpCUDYzfWdniZNL8KcrI4xMtc
         YAaNVNqQ9rK8mCtlbYR5uD/ztYn14kabHaWJr9lLQID+UXGhHOdXCmN8fEl/J87dcwV7
         2YtSbJS4TpX6kjgSJCaSELjINEBEY1ZSw24OBdbM73+4aPeJF69IhLtJc3czqEicUAcc
         0f7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMa1frWHd2TT0bG/d8mgWrp59KgYaejZHwl84hYWi3F0Y3sVe4aRK8m/yoYJOWwWEiq6yJrmhtZb5kVjEUgw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+zvsKjCgZ99hNEvn/VKmgQ8iNuKrVHbkKtLq1CWdLGo4M8MXi
	Ybre9rCiY8csmUdXRTXc3GMqHeYbwHeShbKEGQsdBM6J08fu2Ol6Ft0k+5GVcPNPEfDfrnXAktl
	LmxxpdJwsV4+aNRGLYvuBSjaHc/oy6rbNzmDj3ulLDWvKEZpn1PgJ/e+psDzD7h7XazrIJfXvpS
	VJ25hEr7Uj7B2AZbfJG8xumEJyiCqCOMjN6U/Q6NsOucA=
X-Gm-Gg: AZuq6aIfhWPpJ2Rb7l1Fk8JeTGSx6IbOui8UHUAWkV+1mhx/cTo2yjo6x85En5ZK+hd
	vhPP4noZ1WKe/mGvlNwnGHO0n2my1/1h0TcP6v+wtFlBD+C/2AShbUC6xb2WwudmvKVVVZ5u1Z8
	geIIdiP2cgbg3CupVCJc8HF3LCVhYFARtjxEGzROnNeNtdTOA4aFQbzTjJikFcxybgnQ==
X-Received: by 2002:a05:690c:b1b:b0:788:763:179b with SMTP id 00721157ae682-7949dfcb644mr130609547b3.45.1770103716457;
        Mon, 02 Feb 2026 23:28:36 -0800 (PST)
X-Received: by 2002:a05:690c:b1b:b0:788:763:179b with SMTP id
 00721157ae682-7949dfcb644mr130609457b3.45.1770103716120; Mon, 02 Feb 2026
 23:28:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128124524.875271-1-eperezma@redhat.com> <20260128124524.875271-6-eperezma@redhat.com>
 <CACGkMEtuAG-uZYJWZcsT1A0+QBCTOnkr7m0dt8MdbTwd5UNyNw@mail.gmail.com>
 <CAJaqyWc8_B82n1a3JaBKKvhkWN=Rs93=kcfCU6e9RfzsPXdF5g@mail.gmail.com>
 <CACGkMEuqbEGXE-6xe_kkPMT_JicieQ=HjNKx9j_o3XG9TCuAKg@mail.gmail.com>
 <CAJaqyWe_CLL4D-8WcTJm==AK=d0DrjSrco+ctaQjSobo5ZPHkg@mail.gmail.com> <CACGkMEtXh1xBDemkCCUw_Sow9-1pBU_bo1sN0SUmTQF0XCvvHA@mail.gmail.com>
In-Reply-To: <CACGkMEtXh1xBDemkCCUw_Sow9-1pBU_bo1sN0SUmTQF0XCvvHA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 3 Feb 2026 08:27:59 +0100
X-Gm-Features: AZwV_QjqxVbXv7VlqipEDYcCjb1HlzHSOwZh4gJddC83eHkDl0v7Nu87dtbdu9I
Message-ID: <CAJaqyWcJjtiw2VLzybuUAFs3Q4ugvhEPFeDtxN31vjzdvKS8RA@mail.gmail.com>
Subject: Re: [PATCH 5/6] vduse: add F_QUEUE_READY feature
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0B4a1Hsk4zvb17LJNcrekICr-VbXA9MP271dhhWhdlk_1770103716
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 5:00=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Fri, Jan 30, 2026 at 4:15=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Fri, Jan 30, 2026 at 3:17=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Thu, Jan 29, 2026 at 2:26=E2=80=AFPM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Thu, Jan 29, 2026 at 3:12=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <epere=
zma@redhat.com> wrote:
> > > > > >
> > > > > > Add the VDUSE_F_QUEUE_READY feature flag. This allows the kerne=
l module
> > > > > > to explicitly signal userspace when a specific virtqueue has be=
en
> > > > > > enabled.
> > > > > >
> > > > > > In scenarios like Live Migration of VirtIO net devices, the dat=
aplane
> > > > > > starts after the control virtqueue allowing QEMU to apply confi=
guration
> > > > > > in the destination device.
> > > > > >
> > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > ---
> > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++++++++=
+++++-
> > > > > >  include/uapi/linux/vduse.h         | 19 +++++++++++++++++++
> > > > > >  2 files changed, 46 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/=
vdpa_user/vduse_dev.c
> > > > > > index e7da69c2ad71..1d93b540db4d 100644
> > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > @@ -9,6 +9,7 @@
> > > > > >   */
> > > > > >
> > > > > >  #include "linux/virtio_net.h"
> > > > > > +#include <linux/bits.h>
> > > > > >  #include <linux/cleanup.h>
> > > > > >  #include <linux/init.h>
> > > > > >  #include <linux/module.h>
> > > > > > @@ -53,7 +54,7 @@
> > > > > >  #define IRQ_UNBOUND -1
> > > > > >
> > > > > >  /* Supported VDUSE features */
> > > > > > -static const uint64_t vduse_features;
> > > > > > +static const uint64_t vduse_features =3D BIT_U64(VDUSE_F_QUEUE=
_READY);
> > > > > >
> > > > > >  /*
> > > > > >   * VDUSE instance have not asked the vduse API version, so ass=
ume 0.
> > > > > > @@ -120,6 +121,7 @@ struct vduse_dev {
> > > > > >         char *name;
> > > > > >         struct mutex lock;
> > > > > >         spinlock_t msg_lock;
> > > > > > +       u64 vduse_features;
> > > > > >         u64 msg_unique;
> > > > > >         u32 msg_timeout;
> > > > > >         wait_queue_head_t waitq;
> > > > > > @@ -619,7 +621,30 @@ static void vduse_vdpa_set_vq_ready(struct=
 vdpa_device *vdpa,
> > > > > >  {
> > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > >         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > +       int r;
> > > > > > +
> > > > > > +       if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUEUE_READY=
)))
> > > > > > +               goto out;
> > > > > > +
> > > > > > +       msg.req.type =3D VDUSE_SET_VQ_READY;
> > > > > > +       msg.req.vq_ready.num =3D idx;
> > > > > > +       msg.req.vq_ready.ready =3D !!ready;
> > > > > > +
> > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > >
> > > > > > +       if (r < 0) {
> > > > > > +               dev_dbg(&vdpa->dev, "device refuses to set vq %=
u ready %u",
> > > > > > +                       idx, ready);
> > > > > > +
> > > > > > +               /* We can't do better than break the device in =
this case */
> > > > > > +               spin_lock(&dev->msg_lock);
> > > > > > +               vduse_dev_broken(dev);
> > > > >
> > > > > This has been done by vduse_dev_msg_sync().
> > > > >
> > > >
> > > > This is done by msg_sync() when userland does not reply in a
> > > > timeframe, but not when userland replies with VDUSE_REQ_RESULT_FAIL=
ED.
> > > > Should I add a comment?
> > >
> > > If this is not specific to Q_READY, I think we need to move it to
> > > msg_sync() as well.
> > >
> >
> > It's specific to Q_READY for me, as it's the request that returns void
> > and has no possibility to inform of an error.
>
> I may miss something, I mean why consider the failure of Q_READY to be
> more serious than the failure of other commands (e.g set_status()).
>

I'm not considering the failure of Q_READY more serious than any other
failure. I'm breaking the device here as I cannot return the error to
the vDPA driver: This function returns void.

We can make the function return a bool or int, and then make
vhost_vdpa and virtio_vdpa react to that error.  QEMU is already
prepared for VHOST_VDPA_SET_VRING_ENABLE to return an error, as it is
an ioctl, and hopefully the rest of the users of
VHOST_VDPA_SET_VRING_ENABLE are also prepared.

Should I change vdpa_config_ops->set_vq_ready so it can return an
error, as a prerequisite of this series?

> >
> > The VDUSE userland instance could reply to other requests with
> > REQ_RESULT_FAILED and the driver still has capacity to recover from
> > the failure.
> > If we always break the device on every request fail, we
> > deny that possibility.
> >
>
> Thanks
>

