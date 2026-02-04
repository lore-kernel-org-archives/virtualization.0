Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6C52459DC
	for <virtualization@lists.linux.dev>; Wed,  4 Feb 2026 02:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770173058; cv=none; b=mCO92kkxQ8n2UgBGp4U0zeoFOb6fQxOGND0o1t+wUGH083zWtNbXgNui+1an53XvHALfgQ4RYj4u64v14dTgy+Wv9HB2ECg6DiGecSwHSDIKiMP7FkdOvSoyfuuC8WHi7QvChzg9UahvDiZvQGLZ2nyLtgc44DvLpeNf17m9mjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770173058; c=relaxed/simple;
	bh=adks4LFtbHouwJw7VD4JM9eCJRicJexBkau8fhoqws0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNRQP2ycp1nRuwQxcZoKuaSvBaFINYirFovEU0twMILOi7G960Vbv5bRndOPbzEWtuwApBoOXgIjTSDxwQLpNlM1DaXTFvtyCjTv/3uTVHVvQmQrSfRJ2Wnd/FSYz+qrBB+hgQfTrpzKQlRVIsF9MW7Xy3Zn2lu9BMDxkBSp/D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cUkQmYUt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUkQmYUt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770173056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2psjotZi8GOC5mCDqqLOl0cdZ/YeiOH6prShP1Kz8z8=;
	b=cUkQmYUtVM1vRFkObvW1Ncw6e4r5XlK2upCG+sHXO5nk7T+V6uSLkFuy3ZRhEexh9diojG
	0wGy80GEl8PS4StT0NYDD6Eewp/cm1XZ7V+Z1b5lNVU1BacnzOnBQjLEEtuAUNBfLR36Ke
	QunoVisfrcEYfqXhlREQQVB1nPEMpEY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-ZYZ-zLtWMfGVZfoLnXgqzQ-1; Tue, 03 Feb 2026 21:44:14 -0500
X-MC-Unique: ZYZ-zLtWMfGVZfoLnXgqzQ-1
X-Mimecast-MFC-AGG-ID: ZYZ-zLtWMfGVZfoLnXgqzQ_1770173054
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c6c45a843b6so1010527a12.2
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 18:44:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770173054; x=1770777854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2psjotZi8GOC5mCDqqLOl0cdZ/YeiOH6prShP1Kz8z8=;
        b=t9ELieYGu10XaXFH25ZeeYyXcVZRbT3779NL1pjK6/uLW8En48l0hfbN99j0zz3asv
         IpkDxdPW9OBYQbollFPgFZpAL8072mZAvFtMPBcdBmwEKgQABFVmnG1HzDJJp6RpQK70
         i/V87J8qo6fiPomb2LM2CWv6lSwPKXSma4RjAK6yw6gri9lUBZ6YCEuDmNAPv4UAWmmD
         0QDZ8OooXTb6yo1q6yTHGxAMkHOyM96OwQv0OWKickDEHWg2MxjH4PRvhTV3EXcfcMaa
         cYoD9RPQdrV8Qu3XbO/FP8H6j30E1N70nx5cCW4yrqDsC4t7tK4YctzS2PWduH+7by/d
         EB+g==
X-Forwarded-Encrypted: i=1; AJvYcCUIMwZsCxjIkZScFMXD66MCXkH7TzoCWNlF0l8WxK6zodh41VjaFyPiS68nVMJbcSff1BHh3AyJlDxxcBy7OA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2trFD0mssAS2EEvJRPqMZV9PZOGo/rVamzGFFekkkho3ffp2I
	fDQwySdnofO6vocYUGHJ/0Bsov7viT4RJJeeq2GhpgxOehH9I/Q88J0CnMcgYPXn21r8YL4bipd
	NYo7pkYRYcHkda7chFu/CB9X24ZS4xk7m2pg/bls9ETP7XT94mMkEC3MOp+FcvbWIIXHuHxRJQN
	Y93k1NUsyd37SXaGf4/iGtNR3FeO8yYLjxxL0vuCV1jr8=
X-Gm-Gg: AZuq6aLRFR9YBCBMZsu3T+gqwNywpksjBm0Ntgkm/3wamaYsttK1EqaAqR81zV6ZnGo
	UAj+pxfpc8dZsm2SrRmISzChrpc6xWC7m+0CaVgfUuWUvKckScCYogiH+rywxN09lplBLNzqIsY
	FgtYzfC0d2V5JnbQ3I2TVWyNP5eu8RquIFs1mdekSZYT7Ii9882amTH87U2ODLZYO01UY=
X-Received: by 2002:a05:6a20:7fa8:b0:38b:ebaa:c167 with SMTP id adf61e73a8af0-39372125555mr1391833637.20.1770173053755;
        Tue, 03 Feb 2026 18:44:13 -0800 (PST)
X-Received: by 2002:a05:6a20:7fa8:b0:38b:ebaa:c167 with SMTP id
 adf61e73a8af0-39372125555mr1391815637.20.1770173053292; Tue, 03 Feb 2026
 18:44:13 -0800 (PST)
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
 <CAJaqyWe_CLL4D-8WcTJm==AK=d0DrjSrco+ctaQjSobo5ZPHkg@mail.gmail.com>
 <CACGkMEtXh1xBDemkCCUw_Sow9-1pBU_bo1sN0SUmTQF0XCvvHA@mail.gmail.com> <CAJaqyWcJjtiw2VLzybuUAFs3Q4ugvhEPFeDtxN31vjzdvKS8RA@mail.gmail.com>
In-Reply-To: <CAJaqyWcJjtiw2VLzybuUAFs3Q4ugvhEPFeDtxN31vjzdvKS8RA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Feb 2026 10:44:02 +0800
X-Gm-Features: AZwV_QjTTctj-k-UDRmdqm14IZx1gDrqPg9o0aioFqSreBo91hAWQ1_LVDSq6I8
Message-ID: <CACGkMEt1XiKEqqYAs5QhLJnUwAE+SU4GzgAe9f34ohmAw8nzLg@mail.gmail.com>
Subject: Re: [PATCH 5/6] vduse: add F_QUEUE_READY feature
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S2aaEFMFEGVC7EmuBM5iqzoxCTzwc1IstfeM1HMraEA_1770173054
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 3:28=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Tue, Feb 3, 2026 at 5:00=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Fri, Jan 30, 2026 at 4:15=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Fri, Jan 30, 2026 at 3:17=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Thu, Jan 29, 2026 at 2:26=E2=80=AFPM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Thu, Jan 29, 2026 at 3:12=E2=80=AFAM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > >
> > > > > > On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <epe=
rezma@redhat.com> wrote:
> > > > > > >
> > > > > > > Add the VDUSE_F_QUEUE_READY feature flag. This allows the ker=
nel module
> > > > > > > to explicitly signal userspace when a specific virtqueue has =
been
> > > > > > > enabled.
> > > > > > >
> > > > > > > In scenarios like Live Migration of VirtIO net devices, the d=
ataplane
> > > > > > > starts after the control virtqueue allowing QEMU to apply con=
figuration
> > > > > > > in the destination device.
> > > > > > >
> > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > ---
> > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++++++=
+++++++-
> > > > > > >  include/uapi/linux/vduse.h         | 19 +++++++++++++++++++
> > > > > > >  2 files changed, 46 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdp=
a/vdpa_user/vduse_dev.c
> > > > > > > index e7da69c2ad71..1d93b540db4d 100644
> > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > @@ -9,6 +9,7 @@
> > > > > > >   */
> > > > > > >
> > > > > > >  #include "linux/virtio_net.h"
> > > > > > > +#include <linux/bits.h>
> > > > > > >  #include <linux/cleanup.h>
> > > > > > >  #include <linux/init.h>
> > > > > > >  #include <linux/module.h>
> > > > > > > @@ -53,7 +54,7 @@
> > > > > > >  #define IRQ_UNBOUND -1
> > > > > > >
> > > > > > >  /* Supported VDUSE features */
> > > > > > > -static const uint64_t vduse_features;
> > > > > > > +static const uint64_t vduse_features =3D BIT_U64(VDUSE_F_QUE=
UE_READY);
> > > > > > >
> > > > > > >  /*
> > > > > > >   * VDUSE instance have not asked the vduse API version, so a=
ssume 0.
> > > > > > > @@ -120,6 +121,7 @@ struct vduse_dev {
> > > > > > >         char *name;
> > > > > > >         struct mutex lock;
> > > > > > >         spinlock_t msg_lock;
> > > > > > > +       u64 vduse_features;
> > > > > > >         u64 msg_unique;
> > > > > > >         u32 msg_timeout;
> > > > > > >         wait_queue_head_t waitq;
> > > > > > > @@ -619,7 +621,30 @@ static void vduse_vdpa_set_vq_ready(stru=
ct vdpa_device *vdpa,
> > > > > > >  {
> > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > >         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> > > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > > +       int r;
> > > > > > > +
> > > > > > > +       if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUEUE_REA=
DY)))
> > > > > > > +               goto out;
> > > > > > > +
> > > > > > > +       msg.req.type =3D VDUSE_SET_VQ_READY;
> > > > > > > +       msg.req.vq_ready.num =3D idx;
> > > > > > > +       msg.req.vq_ready.ready =3D !!ready;
> > > > > > > +
> > > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > >
> > > > > > > +       if (r < 0) {
> > > > > > > +               dev_dbg(&vdpa->dev, "device refuses to set vq=
 %u ready %u",
> > > > > > > +                       idx, ready);
> > > > > > > +
> > > > > > > +               /* We can't do better than break the device i=
n this case */
> > > > > > > +               spin_lock(&dev->msg_lock);
> > > > > > > +               vduse_dev_broken(dev);
> > > > > >
> > > > > > This has been done by vduse_dev_msg_sync().
> > > > > >
> > > > >
> > > > > This is done by msg_sync() when userland does not reply in a
> > > > > timeframe, but not when userland replies with VDUSE_REQ_RESULT_FA=
ILED.
> > > > > Should I add a comment?
> > > >
> > > > If this is not specific to Q_READY, I think we need to move it to
> > > > msg_sync() as well.
> > > >
> > >
> > > It's specific to Q_READY for me, as it's the request that returns voi=
d
> > > and has no possibility to inform of an error.
> >
> > I may miss something, I mean why consider the failure of Q_READY to be
> > more serious than the failure of other commands (e.g set_status()).
> >
>
> I'm not considering the failure of Q_READY more serious than any other
> failure. I'm breaking the device here as I cannot return the error to
> the vDPA driver: This function returns void.

Yes, and set_status() return void as well.

void virtio_add_status(struct virtio_device *dev, unsigned int status)
{
        might_sleep();
=3D>      dev->config->set_status(dev, dev->config->get_status(dev) | statu=
s);
}

>
> We can make the function return a bool or int, and then make
> vhost_vdpa and virtio_vdpa react to that error.  QEMU is already
> prepared for VHOST_VDPA_SET_VRING_ENABLE to return an error, as it is
> an ioctl,

But we did:

        case VHOST_VDPA_SET_VRING_ENABLE:
                if (copy_from_user(&s, argp, sizeof(s)))
                        return -EFAULT;
                ops->set_vq_ready(vdpa, idx, s.num);
                return 0;

So the failure come from copy_from_user()

> and hopefully the rest of the users of
> VHOST_VDPA_SET_VRING_ENABLE are also prepared.
>
> Should I change vdpa_config_ops->set_vq_ready so it can return an
> error, as a prerequisite of this series?

Or it would be better to leave the breaking of device on
REQ_RESULT_FAILED for future investigation (not blocking this series).

>
> > >
> > > The VDUSE userland instance could reply to other requests with
> > > REQ_RESULT_FAILED and the driver still has capacity to recover from
> > > the failure.
> > > If we always break the device on every request fail, we
> > > deny that possibility.
> > >
> >
> > Thanks
> >
>

Thanks

