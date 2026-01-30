Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD4C350D4A
	for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769760923; cv=none; b=CkewgRgsU8z4uP4fi2M8A/Bgq5nfcVODCKGhudwXiJhmdi4G6+jZYgDoncZZ1m8Jxy6iY91YUwJW4/5EWeR+mhPPZIXihX4OGAN1X4r/k0irDh6NGFObfnT8nlbgkkvQ1Bz7yJbvtuOEQplkF6bQhiMzna87vqCaS5Q0rdjPbIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769760923; c=relaxed/simple;
	bh=f7ySw4JHuvoTBXCMHwzHEk7wkpcjQNL9J3Dj7i80VIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcdclbb6v06gInA6Djy+czvP1WDrNpHQ+X2d+YBnzNX3s/4vABz9ZdJNwFR2n59cuUPgPetD7dBa5KgPsi28ynOFOMSn5XH5sFoqUoS0uZhzqCPOeR40+3o/hfOLFaNsZw1v/LYYQW6CieCghfpuUxGOzIqXPBG3LBMt4GeEDvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDNi7bGN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDNi7bGN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769760921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pVAmwDO+UagNqmKZECr1JH6DPLjCr253yvEHRUpFilw=;
	b=SDNi7bGNGQdWnDTJzNtOi29Sx4rfQdsWaknDbzhA5U26rn6EAhH2uCeqhph+DhKTF2m6Ju
	YKX0L4apwqlnhAclTYYxCEJa1/TKnC8dWHgHQKCDyb+U/0dYqlgotTM+ewCOy8osqb4e1+
	OQ/OQXCZ6gELeULiasPXU1JV/A7Ng/w=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-Tm8NPMkPONS0unPU1INuAw-1; Fri, 30 Jan 2026 03:15:19 -0500
X-MC-Unique: Tm8NPMkPONS0unPU1INuAw-1
X-Mimecast-MFC-AGG-ID: Tm8NPMkPONS0unPU1INuAw_1769760919
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-644548b1d9aso2605522d50.1
        for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 00:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769760918; x=1770365718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pVAmwDO+UagNqmKZECr1JH6DPLjCr253yvEHRUpFilw=;
        b=UUDBPW6tVyq2CawK12etCnBFIKl0Gbfo8UOc6I8x8EOA1BaYnEKF8Z+ov1+0C+TS2R
         UUGajklalIcT3CE2RVDptOcg9RI4LVbrUP8DdkYd2ruuVJa8Zo+jQCB0/AhX5fUfVASJ
         8eNx7OzCp5231YXp1gxcB8rWUc5DZ07HDMfd0zM+Zlb5gSnH85cHyez6gzwowmhqY+fe
         cTLP6arZxRlcxrTZt3XzvdJkGvtxDyw8rlgkcXlwqk/muItDNisdDVoIPYcvNomd2hQg
         Xyon/tNsdKPaaEt/ztFE8aCLnDitGYugGvYjTxQibPgeXmRiPaAZqkHQF+QnEi7z+MDg
         0ZDw==
X-Forwarded-Encrypted: i=1; AJvYcCUNG0J++USetjuP9Na5tD2RJdorD3jT/A3pbqD8immu8gxwIPrD95cZT+MAMhLXIM1DMtbdd4HzGuHwRcOgLA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyn8ORjiNk/RlC8P81EUMJYXciNVGrh0+52IPIIMfAUVEwrcK2D
	5pJXfx5TzFaZzXDJxWr4hA+PetMojJYrpcJpVfUS2VqWNMCnGoq6Z4iVyXnkgGvgp5mOGfktcEy
	ZCJISP1LHvXO2DqiBC2On6p9YyfpZqsuijIgD1Up8SZRI3vEchExi2QskNYqp2IwCHWJh0sYjgk
	jSKtDiQk03IkOChGv4SMu2MIk098YwPfvbi4805r6G/9sKVVo3q4c=
X-Gm-Gg: AZuq6aJlyMkNLSTioeiTNH4DPO2z5a6hS8qf8G/0kDI+zQhy8XMZsF/mO7dxTOacbKa
	Hp1lF9aVuNC19mxl/D6E6vD6QYU3MKaRW19Oxzf78IXM2RCJLqExNxAZ7KPcIgSdBaPq0SdXXBF
	Fi3IXaCgNdHoS6my+IfvTJ2Gv+ECchHscCglFoAAtjz5atoHnlA522OibtuSkDom+ynw==
X-Received: by 2002:a05:690c:6181:b0:786:5afa:375c with SMTP id 00721157ae682-7949e0b6619mr43649857b3.67.1769760918303;
        Fri, 30 Jan 2026 00:15:18 -0800 (PST)
X-Received: by 2002:a05:690c:6181:b0:786:5afa:375c with SMTP id
 00721157ae682-7949e0b6619mr43649527b3.67.1769760917950; Fri, 30 Jan 2026
 00:15:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128124524.875271-1-eperezma@redhat.com> <20260128124524.875271-6-eperezma@redhat.com>
 <CACGkMEtuAG-uZYJWZcsT1A0+QBCTOnkr7m0dt8MdbTwd5UNyNw@mail.gmail.com>
 <CAJaqyWc8_B82n1a3JaBKKvhkWN=Rs93=kcfCU6e9RfzsPXdF5g@mail.gmail.com> <CACGkMEuqbEGXE-6xe_kkPMT_JicieQ=HjNKx9j_o3XG9TCuAKg@mail.gmail.com>
In-Reply-To: <CACGkMEuqbEGXE-6xe_kkPMT_JicieQ=HjNKx9j_o3XG9TCuAKg@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 30 Jan 2026 09:14:40 +0100
X-Gm-Features: AZwV_QhR3GWTd8lcAc4ZJayjnyG3erK_itKFxlCTk9Mu4n0WBxwcz1qemyy3b9A
Message-ID: <CAJaqyWe_CLL4D-8WcTJm==AK=d0DrjSrco+ctaQjSobo5ZPHkg@mail.gmail.com>
Subject: Re: [PATCH 5/6] vduse: add F_QUEUE_READY feature
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AJRORy74Hdfp1Rzbgd9RR2P6yXXAOxxJauEHjDKvRxI_1769760919
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 3:17=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Jan 29, 2026 at 2:26=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Thu, Jan 29, 2026 at 3:12=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@=
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
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++++++++++++=
+-
> > > >  include/uapi/linux/vduse.h         | 19 +++++++++++++++++++
> > > >  2 files changed, 46 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index e7da69c2ad71..1d93b540db4d 100644
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
> > > > @@ -619,7 +621,30 @@ static void vduse_vdpa_set_vq_ready(struct vdp=
a_device *vdpa,
> > > >  {
> > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > >         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > +       int r;
> > > > +
> > > > +       if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUEUE_READY)))
> > > > +               goto out;
> > > > +
> > > > +       msg.req.type =3D VDUSE_SET_VQ_READY;
> > > > +       msg.req.vq_ready.num =3D idx;
> > > > +       msg.req.vq_ready.ready =3D !!ready;
> > > > +
> > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > >
> > > > +       if (r < 0) {
> > > > +               dev_dbg(&vdpa->dev, "device refuses to set vq %u re=
ady %u",
> > > > +                       idx, ready);
> > > > +
> > > > +               /* We can't do better than break the device in this=
 case */
> > > > +               spin_lock(&dev->msg_lock);
> > > > +               vduse_dev_broken(dev);
> > >
> > > This has been done by vduse_dev_msg_sync().
> > >
> >
> > This is done by msg_sync() when userland does not reply in a
> > timeframe, but not when userland replies with VDUSE_REQ_RESULT_FAILED.
> > Should I add a comment?
>
> If this is not specific to Q_READY, I think we need to move it to
> msg_sync() as well.
>

It's specific to Q_READY for me, as it's the request that returns void
and has no possibility to inform of an error.

The VDUSE userland instance could reply to other requests with
REQ_RESULT_FAILED and the driver still has capacity to recover from
the failure. If we always break the device on every request fail, we
deny that possibility.

