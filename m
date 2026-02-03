Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA2A1DEFE8
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 04:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770091240; cv=none; b=iozsaLVG7Kl3aKapVbcyjrlC+nj2+rlSn+L8S+goximob9/6XNpMwDdxKNIqMGJQ5VsITQRTRWyEkASG9AaNx5ZuerPiiBY8s+INjh1jUKLC8HEtJE0uIevuMYZf03CZroo+qu7LsmBMbtluZP9cuz6tXZUXRN9hScLBvWzxMIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770091240; c=relaxed/simple;
	bh=m5WJLTewhoh6/jemqZWQu656wMPxLZQqJ1l4Zqq1kFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwlP0BaFRooRJBZYrAy4+dj78DfVuATD9GSTixUN0lzFfxHCtZmFw/UHB8yRQLo45OlyuUTX6JanMgKHtZCY1OkscoS3YVntqTjgC2FE9AEn5K4WoALwzXX1BQRx2tUms/155lNdMrteUanXvY3skyi3UboZM4SzexdYc5/M4vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BERyBVdr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BERyBVdr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770091237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NiF0FipwOAh55C7MRt2ClkaqP8uY46sivuxEJkIIwO4=;
	b=BERyBVdrCcI7qosLZewvC2aAE+uB/XTLYw2tBVOmqurvJeEJmRLkGJNJHXLF5aOLP5XDXm
	jBI59BYpBFoorNt+AFROGgvoMNMhGehcKBg31vU1/t3GnCBPrJ0D+EfPpZmWV7tI9a3F39
	YMLz6bprlJHdV8HKrsR4m1Xt//6oEzo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-MatocffAPBGGg6m9xfmIJQ-1; Mon, 02 Feb 2026 23:00:35 -0500
X-MC-Unique: MatocffAPBGGg6m9xfmIJQ-1
X-Mimecast-MFC-AGG-ID: MatocffAPBGGg6m9xfmIJQ_1770091235
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ed2so4767853a91.0
        for <virtualization@lists.linux.dev>; Mon, 02 Feb 2026 20:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770091235; x=1770696035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NiF0FipwOAh55C7MRt2ClkaqP8uY46sivuxEJkIIwO4=;
        b=iyxZhW8hMi07V2Ra5AdDLdMy6/ni6z1Osn88LXnBDIWqlD1bqWP8R2ym6pDX+I2Ii9
         ahjtN+WLx5diOq2KNbOZCI34HZjQRwa4N6ipuFJjBH2dCsW8VIK7ll+26CVlXva8/O2K
         8PAn6G8dE0qITQrAdiLN25m3Ca+tqBZQCiNw64R68BEnCokJ6clWxcr4CUf6LyCHzJFV
         WLvrP9V5ahTDms6XBeivzUyRG71038JS6HDknb78qq/RaDBz4/hOIa/YyFDFf5UHTbIh
         xmaZUkVbJ1OUJNmfykLnyH27UEgABJTivo2No1/aYK1DAlT/dDbJf+DpkJ6OHckgiAJg
         nmMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzy42apEZeqydy+RY3gzM/tnu1hIbu27yEaOpNSrEEi873t0vxhkVwzEX0NSu5u0dM86MOi9J3JeV1tJXWdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzlkTGBZ3LqtYp5viFwstGaZWzxDseLDIpPodmztPsqr+keMT+
	kuW9Vwx1ojEHsnclwYVKP+sy1JEL9UP+eih0JLyu1ap2WMxtDipl5pppfi1WslGtnSsY0ObL98y
	xHd0vkcIUMaBBlH3n3I9Y4wz52Nmyicz7dJjAoBemfVoHpdBoOsGpoeUboJJ70Rl25vzGbOqMeo
	KwXrwD8WuqklxdzsJfr80W+Svu0mCMQZzs3EZo4nN7P6A=
X-Gm-Gg: AZuq6aLO/MvRfmj4qOvvALFReF3KR1IAB6eDrgUG0oLnOxIc8MqGLSJkaGYPABMrdO6
	3BdSK5lszG1H3blm3zeAnpCrCGfE73nizeu63DU7q1t6wnjePLgcDb2Ab4sW1a7CdYf0KeYUyfk
	YmoI3dY1MnL2NcY62RHG6+Z/OwUaP8mpMay2/y3QFPzNawA6Uci8uUT9vU8NTqEixoCFA=
X-Received: by 2002:a17:90b:584f:b0:340:be44:dd11 with SMTP id 98e67ed59e1d1-3543b3d01b0mr12555445a91.27.1770091234760;
        Mon, 02 Feb 2026 20:00:34 -0800 (PST)
X-Received: by 2002:a17:90b:584f:b0:340:be44:dd11 with SMTP id
 98e67ed59e1d1-3543b3d01b0mr12555430a91.27.1770091234362; Mon, 02 Feb 2026
 20:00:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128124524.875271-1-eperezma@redhat.com> <20260128124524.875271-6-eperezma@redhat.com>
 <CACGkMEtuAG-uZYJWZcsT1A0+QBCTOnkr7m0dt8MdbTwd5UNyNw@mail.gmail.com>
 <CAJaqyWc8_B82n1a3JaBKKvhkWN=Rs93=kcfCU6e9RfzsPXdF5g@mail.gmail.com>
 <CACGkMEuqbEGXE-6xe_kkPMT_JicieQ=HjNKx9j_o3XG9TCuAKg@mail.gmail.com> <CAJaqyWe_CLL4D-8WcTJm==AK=d0DrjSrco+ctaQjSobo5ZPHkg@mail.gmail.com>
In-Reply-To: <CAJaqyWe_CLL4D-8WcTJm==AK=d0DrjSrco+ctaQjSobo5ZPHkg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Feb 2026 12:00:23 +0800
X-Gm-Features: AZwV_QiNlKe-pRzRhPJFDrD24pCNL62beB-Vc_lif2MiHfQOX__FDTTz5z2yQwA
Message-ID: <CACGkMEtXh1xBDemkCCUw_Sow9-1pBU_bo1sN0SUmTQF0XCvvHA@mail.gmail.com>
Subject: Re: [PATCH 5/6] vduse: add F_QUEUE_READY feature
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CB1AIE5IIjz4rGie78YbI8spelmCWxfaY2otaDuD2Tc_1770091235
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 4:15=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Jan 30, 2026 at 3:17=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Jan 29, 2026 at 2:26=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Thu, Jan 29, 2026 at 3:12=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <eperezm=
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
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++++++++++=
+++-
> > > > >  include/uapi/linux/vduse.h         | 19 +++++++++++++++++++
> > > > >  2 files changed, 46 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vd=
pa_user/vduse_dev.c
> > > > > index e7da69c2ad71..1d93b540db4d 100644
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
> > > > > @@ -619,7 +621,30 @@ static void vduse_vdpa_set_vq_ready(struct v=
dpa_device *vdpa,
> > > > >  {
> > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > >         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > +       int r;
> > > > > +
> > > > > +       if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUEUE_READY))=
)
> > > > > +               goto out;
> > > > > +
> > > > > +       msg.req.type =3D VDUSE_SET_VQ_READY;
> > > > > +       msg.req.vq_ready.num =3D idx;
> > > > > +       msg.req.vq_ready.ready =3D !!ready;
> > > > > +
> > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > >
> > > > > +       if (r < 0) {
> > > > > +               dev_dbg(&vdpa->dev, "device refuses to set vq %u =
ready %u",
> > > > > +                       idx, ready);
> > > > > +
> > > > > +               /* We can't do better than break the device in th=
is case */
> > > > > +               spin_lock(&dev->msg_lock);
> > > > > +               vduse_dev_broken(dev);
> > > >
> > > > This has been done by vduse_dev_msg_sync().
> > > >
> > >
> > > This is done by msg_sync() when userland does not reply in a
> > > timeframe, but not when userland replies with VDUSE_REQ_RESULT_FAILED=
.
> > > Should I add a comment?
> >
> > If this is not specific to Q_READY, I think we need to move it to
> > msg_sync() as well.
> >
>
> It's specific to Q_READY for me, as it's the request that returns void
> and has no possibility to inform of an error.

I may miss something, I mean why consider the failure of Q_READY to be
more serious than the failure of other commands (e.g set_status()).

>
> The VDUSE userland instance could reply to other requests with
> REQ_RESULT_FAILED and the driver still has capacity to recover from
> the failure.
> If we always break the device on every request fail, we
> deny that possibility.
>

Thanks

