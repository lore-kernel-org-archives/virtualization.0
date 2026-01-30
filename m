Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B8274B48
	for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 02:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769739471; cv=none; b=aMFwERXp/t6fbeqS5H4++4brrgwVCO9a8CjPOhsFD2mb6+qkilsLt6zllF+9Y1ls/ZMzGf5hxf/yLohpeGnwAGKK1oMkzWyU5MfHiyOx+GFwpxvrzWLsBkxWnIeJljQU74taYqqAMPIdocSd12mDDWuqdP7wtPJibVkd55X0+Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769739471; c=relaxed/simple;
	bh=SKycN8TAnbB767mN+cKS7qZXB8qJMSzoQbCbPp/1DRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrPA0XneVF191lxqRTaUUl07Y3ykI8AUEzdYw+GadM1WchIhnjpNKlkFcIxTJTWueGiWFrj5yZPGzYuT3/t2LL5uZyWpNw7mTT0IQkgzlTr6h7w72glu8VOwC6oy2WIC6YPVWz95owDow41PJNn0GtbMEApDLKCg5TYl5cBOyGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQmEEgbs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQmEEgbs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769739468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJ8Ry76GSPpRNzzIYFyMY/Tg7gwXOUB/xg4aoeA3VtA=;
	b=SQmEEgbsog7dWLPUu8SkTECjBA7tiEJM44BGevQfnzlj89bjHfvMIZele/huPFUmcpt5az
	CCHx6YFlBSruTwCq3fxK6s4J4Blm+xftcy9qjf0w5d/UXqZTGd256N2YEla+dUQum6LcJN
	Px/sPHlfzIhFrBGt/g3e3XOR+wc5Bao=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-VKMnpZ-RNzGVKRP5xY0s1A-1; Thu, 29 Jan 2026 21:17:45 -0500
X-MC-Unique: VKMnpZ-RNzGVKRP5xY0s1A-1
X-Mimecast-MFC-AGG-ID: VKMnpZ-RNzGVKRP5xY0s1A_1769739465
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c2f670a06so1829519a91.3
        for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 18:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769739464; x=1770344264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lJ8Ry76GSPpRNzzIYFyMY/Tg7gwXOUB/xg4aoeA3VtA=;
        b=qfLjDAfAphsHL8P1xV9EJoJLtQJRebaBMMozPgGrnkdoVEBJsvOLM+yJ4pOEZzr19g
         wba2iLFxVxGHC9tDeUqFXQP10Y2rNRpe/SU7EHYETjtN0+HgysnP5gWFpMftx/wUvhed
         UBenjbwagEpDtOd1m61hre30rTPAV8cQIUIevUHS/+hvAs1fBJYttpd9xv0uZeEzd/IB
         YzzLlScf3Mx0L0TgT7oTRyySMJgIdk7FYeyXvj9pU6pVtvUEP3CnCKPKZSCmw34IwAAx
         zcThb7I/KnAa8uV40zWHQem12h/TDIc3Ue5GJNsMIwtvIkBReJWd5FrMM21bbO1b+S8/
         8G5A==
X-Forwarded-Encrypted: i=1; AJvYcCV6lu33tz60u3+uuXmomFA9O/Rcd5okG9CoK1ZjcZghg9nGVVRkai8yD6q7BkRU1rY3e4wB3VFnKVn7jmpUWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzX1QYpkH0dbH+6XdA0RJIbMLBIclcjvFzdxdQzHzrxheg9wLJw
	hrZRuGJEj7oce6NpJfMmsn1odt1EB93iDDf4Y9D7ig93+DBgIoCFruJ47LLxqdsntCuxvoI49LG
	1rpIrWumyYov64ZC61A35491ETGdW1kpaLfmHFVQQCq/kGAEl5D6fkXTusdjX39fwvOjJ4Ghgd5
	qzXlpLTXYpYqKtdomha3S6U2XOgvxct58nNqI7ae7lUn01rI5y3jZjhA==
X-Gm-Gg: AZuq6aIlGwuv7ghRzVx5cXoZvzOYKPVyO1/h3Iy+hT12oGAFMvkj8EK1Zlr4Kql8GBy
	VeyrwXSI/DraA+b04e7hwLFf+PXnPiX6mJ3I08bxZzIb4MAIyCczCPKdXA+4CkJR0unE2Q7+KU2
	L55GOv1Aq7ytNYJqjKKn5/jQ4r0pUuT/KO1Xh6RBYzaMKz8m1jos32erMNcBC4aLyI
X-Received: by 2002:a17:90a:d40f:b0:340:bb64:c5e with SMTP id 98e67ed59e1d1-3543b32dc40mr1371457a91.14.1769739464256;
        Thu, 29 Jan 2026 18:17:44 -0800 (PST)
X-Received: by 2002:a17:90a:d40f:b0:340:bb64:c5e with SMTP id
 98e67ed59e1d1-3543b32dc40mr1371437a91.14.1769739463783; Thu, 29 Jan 2026
 18:17:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128124524.875271-1-eperezma@redhat.com> <20260128124524.875271-6-eperezma@redhat.com>
 <CACGkMEtuAG-uZYJWZcsT1A0+QBCTOnkr7m0dt8MdbTwd5UNyNw@mail.gmail.com> <CAJaqyWc8_B82n1a3JaBKKvhkWN=Rs93=kcfCU6e9RfzsPXdF5g@mail.gmail.com>
In-Reply-To: <CAJaqyWc8_B82n1a3JaBKKvhkWN=Rs93=kcfCU6e9RfzsPXdF5g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Jan 2026 10:17:31 +0800
X-Gm-Features: AZwV_Qh35p00PJFC5pig19AfbJNnmBohLPP2GVUguztORA5tdDuIR5J5dJf2K0c
Message-ID: <CACGkMEuqbEGXE-6xe_kkPMT_JicieQ=HjNKx9j_o3XG9TCuAKg@mail.gmail.com>
Subject: Re: [PATCH 5/6] vduse: add F_QUEUE_READY feature
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kgBhiPJimdr8ptGBk06hPpLgeZal9VzxZb5FJjTda5I_1769739465
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 2:26=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Jan 29, 2026 at 3:12=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
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
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 +++++++++++++++++++++++++++-
> > >  include/uapi/linux/vduse.h         | 19 +++++++++++++++++++
> > >  2 files changed, 46 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index e7da69c2ad71..1d93b540db4d 100644
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
> > > @@ -619,7 +621,30 @@ static void vduse_vdpa_set_vq_ready(struct vdpa_=
device *vdpa,
> > >  {
> > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > >         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> > > +       struct vduse_dev_msg msg =3D { 0 };
> > > +       int r;
> > > +
> > > +       if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUEUE_READY)))
> > > +               goto out;
> > > +
> > > +       msg.req.type =3D VDUSE_SET_VQ_READY;
> > > +       msg.req.vq_ready.num =3D idx;
> > > +       msg.req.vq_ready.ready =3D !!ready;
> > > +
> > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > >
> > > +       if (r < 0) {
> > > +               dev_dbg(&vdpa->dev, "device refuses to set vq %u read=
y %u",
> > > +                       idx, ready);
> > > +
> > > +               /* We can't do better than break the device in this c=
ase */
> > > +               spin_lock(&dev->msg_lock);
> > > +               vduse_dev_broken(dev);
> >
> > This has been done by vduse_dev_msg_sync().
> >
>
> This is done by msg_sync() when userland does not reply in a
> timeframe, but not when userland replies with VDUSE_REQ_RESULT_FAILED.
> Should I add a comment?

If this is not specific to Q_READY, I think we need to move it to
msg_sync() as well.

Thanks

>

