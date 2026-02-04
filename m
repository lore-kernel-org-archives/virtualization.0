Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C965A38E5D3
	for <virtualization@lists.linux.dev>; Wed,  4 Feb 2026 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770190525; cv=none; b=D8IpS1GLWurjdc4li0zzw0u6Brgoxcfujyf1751GpGeDUSlEcCeUEjOc6pHj9EQsa5MPXiQpzT2TH1G8T056FQdYu/6w6MVVrVMW5+1qEqXN06gOpWEF4u5h23gVrXIjtqOYt6Ie2N5ic+b8Tovo8x3a29jOHyM4KkHkgpJizuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770190525; c=relaxed/simple;
	bh=X4uFs/Twz42fmg+L+1Q7nEwe2Nh5pU9abiarOtu+Iak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/IWq5RVcEpP6qmqc1oztTxNYPYdpfBKMFBkUfNPHxJvod+8JcaGLURdzR0Bhe4Dv3wltoh0efD9oeAU0nUPqx5l/93SkYussmXaMlu22cbQd752dhGzcAWETpUEH6Vu+j8CB9hXvdSnycvY/QEOodjSrpWO5eH33eqHChSynx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUcW2dQl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUcW2dQl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770190523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=An4MCE63/Z5eXS0ZIPmDYP9pIDxt9bwDZSBvCM7Fe6Q=;
	b=aUcW2dQlxUbfR3Fn11G9GMOmV6wKbKaBKk2QupJMBX3eRSfqmqwkSZLuV4tYsdnREmHoBl
	f4vB8TxGBSGacELSHHNus8pkFzNtY9B5enUgZQDDnQO3cIlrFvTEzw4EZo3C4pIZ9gDPl7
	J0sbtLFKhJ8Q2KRXbq1HZyGavRI76YA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-98BfxZHlM7eOJ-pVeOcqUA-1; Wed, 04 Feb 2026 02:35:20 -0500
X-MC-Unique: 98BfxZHlM7eOJ-pVeOcqUA-1
X-Mimecast-MFC-AGG-ID: 98BfxZHlM7eOJ-pVeOcqUA_1770190520
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-790afc07667so6218567b3.0
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 23:35:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770190520; x=1770795320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=An4MCE63/Z5eXS0ZIPmDYP9pIDxt9bwDZSBvCM7Fe6Q=;
        b=KqsAS9LurqEucdUJxRM6Hwyi5pU5h/DwzAsL1HsBJkSLQlFtcTsixJZNuSA6sqvVri
         phPR+g2izrhfdv2O+X1bqcbTKzzwt6lR/UIy8yi1k5nKZmD+b4XRKqF7DmtEj9hxC1EB
         JF2ZI5A4QLKMGGXMzXb4obmLWrv1CMJ1Jb3FoOH7mMeja67G54CTpyvEvZcH2TVWKaPK
         kPGlMUPqF4suxQ4eIkkaMzH520fnp6JiBksM/ZR7NuWrCYrVFrag6U9CNfq+sxpCaFIK
         B8IZCNGJktkwRjHFeiVSG34Xae1UZBPdndNnu11i42VYmC0K1w8WcFMmmhy5Pxbdgkvg
         0wQw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ/C1QZfPHFwmCt1DjToG4XNwcTqbVpIXA+0IQQF9BHnW0NHBtbi1NBERENJOVuriTiCNZhMixpUn3MsFR4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAW6OFf2rKFTq2HM7vH/hpxpr0SEDVtIz3/WCtiQAV21d2zS8d
	MFuqf5EYDBWi0hJT23sxPdY8oVIdb9xiLzzQ9oDeD+E88frw+6ZdKen58Vu3NZaXA0WiS9dIPeT
	q2TIYavv7LX+kUXbm5SClnBG8P2v2dFLAqUmIklevI6Hj2gGwT5/JGROjFpVsTshKwiQZWJ8qyj
	+ZFnJ9B0QNoWxilRr28sD8X6vkObc+da5PzpzfQqOsVjM=
X-Gm-Gg: AZuq6aJs3DO4CWB19E5boxVSh1pA82mEpBTwRMGyW1z1/pmU6T27qa7l3DnA3Ugz7S1
	GuQ3H9aAvA5+rdDR1v+V7RbpyufZPIQuRIO8uzEqJBY3CFf1oPJkPRc+yYchle5dIWrF4b8/uov
	28wZxPgzYa9H0r8XR5jj47wNK1YUpiTsmsEn6jK7RQjwcTYGyrjehDvthbpc7VQUcesA==
X-Received: by 2002:a05:690c:1c:b0:794:c3f1:bf73 with SMTP id 00721157ae682-794fe65173cmr20976127b3.4.1770190519966;
        Tue, 03 Feb 2026 23:35:19 -0800 (PST)
X-Received: by 2002:a05:690c:1c:b0:794:c3f1:bf73 with SMTP id
 00721157ae682-794fe65173cmr20975917b3.4.1770190519482; Tue, 03 Feb 2026
 23:35:19 -0800 (PST)
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
 <CACGkMEtXh1xBDemkCCUw_Sow9-1pBU_bo1sN0SUmTQF0XCvvHA@mail.gmail.com>
 <CAJaqyWcJjtiw2VLzybuUAFs3Q4ugvhEPFeDtxN31vjzdvKS8RA@mail.gmail.com> <CACGkMEt1XiKEqqYAs5QhLJnUwAE+SU4GzgAe9f34ohmAw8nzLg@mail.gmail.com>
In-Reply-To: <CACGkMEt1XiKEqqYAs5QhLJnUwAE+SU4GzgAe9f34ohmAw8nzLg@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 4 Feb 2026 08:34:43 +0100
X-Gm-Features: AZwV_QgachT3sqo8kEGFc03eJQ12G70tK9sRIs6ndTes7DzHdKS5MbKmxSwIodM
Message-ID: <CAJaqyWcuwsnKj6wb1Vc2bXORyTeQhsn7ZLdsbEiU-C8QKKuFYQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] vduse: add F_QUEUE_READY feature
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZbFRrmDvWOM5-d9L0od_1TZAhL7PAMQRHhSXvB_WDn8_1770190520
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 3:44=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Tue, Feb 3, 2026 at 3:28=E2=80=AFPM Eugenio Perez Martin <eperezma@red=
hat.com> wrote:
> >
> > On Tue, Feb 3, 2026 at 5:00=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Fri, Jan 30, 2026 at 4:15=E2=80=AFPM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Fri, Jan 30, 2026 at 3:17=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Thu, Jan 29, 2026 at 2:26=E2=80=AFPM Eugenio Perez Martin
> > > > > <eperezma@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Jan 29, 2026 at 3:12=E2=80=AFAM Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <e=
perezma@redhat.com> wrote:
> > > > > > > >
> > > > > > > > Add the VDUSE_F_QUEUE_READY feature flag. This allows the k=
ernel module
> > > > > > > > to explicitly signal userspace when a specific virtqueue ha=
s been
> > > > > > > > enabled.
> > > > > > > >
> > > > > > > > In scenarios like Live Migration of VirtIO net devices, the=
 dataplane
> > > > > > > > starts after the control virtqueue allowing QEMU to apply c=
onfiguration
> > > > > > > > in the destination device.
> > > > > > > >
> > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > > ---
> > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++++=
+++++++++-
> > > > > > > >  include/uapi/linux/vduse.h         | 19 ++++++++++++++++++=
+
> > > > > > > >  2 files changed, 46 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/v=
dpa/vdpa_user/vduse_dev.c
> > > > > > > > index e7da69c2ad71..1d93b540db4d 100644
> > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > @@ -9,6 +9,7 @@
> > > > > > > >   */
> > > > > > > >
> > > > > > > >  #include "linux/virtio_net.h"
> > > > > > > > +#include <linux/bits.h>
> > > > > > > >  #include <linux/cleanup.h>
> > > > > > > >  #include <linux/init.h>
> > > > > > > >  #include <linux/module.h>
> > > > > > > > @@ -53,7 +54,7 @@
> > > > > > > >  #define IRQ_UNBOUND -1
> > > > > > > >
> > > > > > > >  /* Supported VDUSE features */
> > > > > > > > -static const uint64_t vduse_features;
> > > > > > > > +static const uint64_t vduse_features =3D BIT_U64(VDUSE_F_Q=
UEUE_READY);
> > > > > > > >
> > > > > > > >  /*
> > > > > > > >   * VDUSE instance have not asked the vduse API version, so=
 assume 0.
> > > > > > > > @@ -120,6 +121,7 @@ struct vduse_dev {
> > > > > > > >         char *name;
> > > > > > > >         struct mutex lock;
> > > > > > > >         spinlock_t msg_lock;
> > > > > > > > +       u64 vduse_features;
> > > > > > > >         u64 msg_unique;
> > > > > > > >         u32 msg_timeout;
> > > > > > > >         wait_queue_head_t waitq;
> > > > > > > > @@ -619,7 +621,30 @@ static void vduse_vdpa_set_vq_ready(st=
ruct vdpa_device *vdpa,
> > > > > > > >  {
> > > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > >         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> > > > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > +       int r;
> > > > > > > > +
> > > > > > > > +       if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUEUE_R=
EADY)))
> > > > > > > > +               goto out;
> > > > > > > > +
> > > > > > > > +       msg.req.type =3D VDUSE_SET_VQ_READY;
> > > > > > > > +       msg.req.vq_ready.num =3D idx;
> > > > > > > > +       msg.req.vq_ready.ready =3D !!ready;
> > > > > > > > +
> > > > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > >
> > > > > > > > +       if (r < 0) {
> > > > > > > > +               dev_dbg(&vdpa->dev, "device refuses to set =
vq %u ready %u",
> > > > > > > > +                       idx, ready);
> > > > > > > > +
> > > > > > > > +               /* We can't do better than break the device=
 in this case */
> > > > > > > > +               spin_lock(&dev->msg_lock);
> > > > > > > > +               vduse_dev_broken(dev);
> > > > > > >
> > > > > > > This has been done by vduse_dev_msg_sync().
> > > > > > >
> > > > > >
> > > > > > This is done by msg_sync() when userland does not reply in a
> > > > > > timeframe, but not when userland replies with VDUSE_REQ_RESULT_=
FAILED.
> > > > > > Should I add a comment?
> > > > >
> > > > > If this is not specific to Q_READY, I think we need to move it to
> > > > > msg_sync() as well.
> > > > >
> > > >
> > > > It's specific to Q_READY for me, as it's the request that returns v=
oid
> > > > and has no possibility to inform of an error.
> > >
> > > I may miss something, I mean why consider the failure of Q_READY to b=
e
> > > more serious than the failure of other commands (e.g set_status()).
> > >
> >
> > I'm not considering the failure of Q_READY more serious than any other
> > failure. I'm breaking the device here as I cannot return the error to
> > the vDPA driver: This function returns void.
>
> Yes, and set_status() return void as well.
>
> void virtio_add_status(struct virtio_device *dev, unsigned int status)
> {
>         might_sleep();
> =3D>      dev->config->set_status(dev, dev->config->get_status(dev) | sta=
tus);
> }
>

Yes, I'm not saying all of the other users of vduse_dev_msg_sync don't
ignore the return code of the userland VDUSE instance. I'm saying that
we have cases where it is not ignored and the driver can react from
the error. After a fast look for them:

1) Case vhost_vdpa -> VHOST_GET_VRING_BASE -> ops->get_vq_state.
2) Case vhost_vdpa -> ops->vduse_vdpa_set_map -> vduse_dev_update_iotlb

If the userland VDUSE instance returns an error, -EIO is propagated to
vhost_vdpa user, and both can react and continue operating normally.
If we break the device, the same two userlands apps see a totally
different behavior: The device is totally unusable from that moment.

Do we really want to break the device from the moment that VDUSE
instance returns an error in these conditions, and do it in an user
visible change?

> >
> > We can make the function return a bool or int, and then make
> > vhost_vdpa and virtio_vdpa react to that error.  QEMU is already
> > prepared for VHOST_VDPA_SET_VRING_ENABLE to return an error, as it is
> > an ioctl,
>
> But we did:
>
>         case VHOST_VDPA_SET_VRING_ENABLE:
>                 if (copy_from_user(&s, argp, sizeof(s)))
>                         return -EFAULT;
>                 ops->set_vq_ready(vdpa, idx, s.num);
>                 return 0;
>
> So the failure come from copy_from_user()
>

Yes. Let me rewrite it as:

We can make ops->set_vq_ready return a bool or int, and then make
vhost_vdpa react to that error. The driver virtio_vdpa already checks
the same by calling get_vq_ready, but there is no equivalent in
vhost_vdpa. I can set a comment explaining the two methods for
checking the error of the call. QEMU is already prepared for handling
the return of an error from VHOST_VDPA_SET_VRING_ENABLE, as the ioctl
already returns errors like -EFAULT, and hopefully the rest of the
users of VHOST_VDPA_SET_VRING_ENABLE are also prepared.

> >
> > Should I change vdpa_config_ops->set_vq_ready so it can return an
> > error, as a prerequisite of this series?
>
> Or it would be better to leave the breaking of device on
> REQ_RESULT_FAILED for future investigation (not blocking this series).
>

I'd say it's the best option, yes. But my vote is to make
VHOST_VDPA_SET_VRING_ENABLE more robust actually :).

> >
> > > >
> > > > The VDUSE userland instance could reply to other requests with
> > > > REQ_RESULT_FAILED and the driver still has capacity to recover from
> > > > the failure.
> > > > If we always break the device on every request fail, we
> > > > deny that possibility.
> > > >
> > >
> > > Thanks
> > >
> >
>
> Thanks
>

