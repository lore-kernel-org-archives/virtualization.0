Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE201156677
	for <virtualization@lists.linux.dev>; Thu,  5 Feb 2026 04:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770264551; cv=none; b=kmwMAnmcB9EAzFw+CDvSX1R/fJ4lknJJ1lSW3wO3GIZOTEaUDUzaJq1PJPeQTguKsZHOjZHeRGYk01BnNuaiKSqB/x4jWKcpHl+onfZqcAmq227JTtpTGkgoIWVR6DZI81eWhDa5ZNKSPDaMyy3hCBRqg7eJVobiz7fspNjGFMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770264551; c=relaxed/simple;
	bh=Jdt4rGaAfRb8vsWzTmDiMMjJ8iIJ1cV3UNfSYlRbKDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nf/iCcBvhxa3dQ7FGqCB/vDmZ50thTu5WGTyE4WId6St1HK4aHyIwj3sp1Rj4nU+vPSZRrMqIYYm9AsXIhXayg8SBI/aabHbnnYzgwmdcp2ZCxpFBcniC7mIcbkTI7sFAEy2JFg4ig9t54NXUK7TYzvW8g5oA8In6nSaXoxC1T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/dXn+m3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/dXn+m3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770264550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7WVw7I421f2Zcw7sXe47WQ3tcv+hyJcDrqMXlYgXEs=;
	b=d/dXn+m3VhuUb1tsXxNQBLACxBIp7vo6UL3/Wg8W5+rrPKSwA0v9TDFjuQ2df0lh+2Ne8g
	PF/oBvFvGppowZDPdwyXulVdMdczigJTLGjpA2HseQYLx+8SPhGH0Ktn0p7diXB3g+zmQ+
	BsLX//TmQWwj2dbE7KnY8r+JV2vZGSY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-NMUYjjZdNzOwX0gGTQ0DnA-1; Wed, 04 Feb 2026 23:09:09 -0500
X-MC-Unique: NMUYjjZdNzOwX0gGTQ0DnA-1
X-Mimecast-MFC-AGG-ID: NMUYjjZdNzOwX0gGTQ0DnA_1770264548
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c613929d317so316140a12.2
        for <virtualization@lists.linux.dev>; Wed, 04 Feb 2026 20:09:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770264548; x=1770869348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W7WVw7I421f2Zcw7sXe47WQ3tcv+hyJcDrqMXlYgXEs=;
        b=RQwMmq7EZx2Mw8kOTs+VxPO4KEDr/380UhrEBLyn64JUB3XaVgyZc4yJfinWBWWdPD
         sYNe0zHTWtWw8XSspwNQmrprDNS6jiElCmcMmKXpu7nzn+wgrlhaHyL2hqFJ6ErTeTkI
         m9+bBW4XOm+lkfhVkmKGKhOae3ZDclNUIuqC1p5373TQ38e1pBZPl66+ngfL+sjqfecx
         E8itG2CdajaSXI1+McBGNS2aqe5wnSZnt3sEjObDgY+sJIc+MhxmqBTbBL2JM2nyozVS
         5U1IeKKytODPmNBy8FXQcwmxnd+0GtPREGAwHdZVIOp67f621aoCjpiwIAIe3iWB+cFO
         noGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3eVuPTRkud/73mVdYnMnyLqYKkwkkzlRB7XKCQmsz9YGxfeFSX6GZixOq2golJqITz86jwlw2M4wG6Ob7ug==@lists.linux.dev
X-Gm-Message-State: AOJu0YzF3VLh2T6bSUe4uHO2ll8976QviVj8x+VeXfEyB9FtCJOjkI2I
	5chVqIaqo8I6Fpuse1tXe5pGBQP3HXhdv9gAqZJwNSjkRyQ6oq3y8Uw5OmxB1miV15yA3JYfAt2
	CKKgm2c/FZuVwHwbewsqxT/dsEvKLb67MPuhPs4byR0QoBbXHkEBck+Eb/tlEf8eQryOl3V0Bjq
	YXPLKZRyW8zzaR8oDXIWu+286fviaF2OSIyN4QWzmXLBY=
X-Gm-Gg: AZuq6aKVT3NWc3p6KWS8Lsxz7XBtJwYCn28dswwKWd4ydvE4g+Ao0VQb7ivBJBE65C4
	Wglmeujvq313LpqLSfRegXsXCTjBvEONreXhCLToxtiWIiz5Y5psusySya8IrGRL7bJ2Lv96WWD
	HG8th1mHB/8K7YTbhA5IKaHovocGDwTmlc35RMTfzwmRUZCrUe7tBPSLnJMJN8IPoWZg==
X-Received: by 2002:a05:6a20:3d86:b0:344:97a7:8c6a with SMTP id adf61e73a8af0-393723b7450mr5250054637.51.1770264548217;
        Wed, 04 Feb 2026 20:09:08 -0800 (PST)
X-Received: by 2002:a05:6a20:3d86:b0:344:97a7:8c6a with SMTP id
 adf61e73a8af0-393723b7450mr5250026637.51.1770264547760; Wed, 04 Feb 2026
 20:09:07 -0800 (PST)
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
 <CAJaqyWcJjtiw2VLzybuUAFs3Q4ugvhEPFeDtxN31vjzdvKS8RA@mail.gmail.com>
 <CACGkMEt1XiKEqqYAs5QhLJnUwAE+SU4GzgAe9f34ohmAw8nzLg@mail.gmail.com> <CAJaqyWcuwsnKj6wb1Vc2bXORyTeQhsn7ZLdsbEiU-C8QKKuFYQ@mail.gmail.com>
In-Reply-To: <CAJaqyWcuwsnKj6wb1Vc2bXORyTeQhsn7ZLdsbEiU-C8QKKuFYQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Feb 2026 12:08:55 +0800
X-Gm-Features: AZwV_QiitQc4_lO24NM3yhSWXKpCSqWvwh2g1CXJg7aXiJMyJnVMJdntCQzXFbs
Message-ID: <CACGkMEvgQsPUv_zK7=1bpLPhvem_HuS8MRb5uUB0VcB5vBQN4Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] vduse: add F_QUEUE_READY feature
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _Q_V26Tw52vkS7hAdRgO8CmBrbHAqD_eMOXst4zECyw_1770264548
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 3:35=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Wed, Feb 4, 2026 at 3:44=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Tue, Feb 3, 2026 at 3:28=E2=80=AFPM Eugenio Perez Martin <eperezma@r=
edhat.com> wrote:
> > >
> > > On Tue, Feb 3, 2026 at 5:00=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Fri, Jan 30, 2026 at 4:15=E2=80=AFPM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Fri, Jan 30, 2026 at 3:17=E2=80=AFAM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > >
> > > > > > On Thu, Jan 29, 2026 at 2:26=E2=80=AFPM Eugenio Perez Martin
> > > > > > <eperezma@redhat.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jan 29, 2026 at 3:12=E2=80=AFAM Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez =
<eperezma@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > Add the VDUSE_F_QUEUE_READY feature flag. This allows the=
 kernel module
> > > > > > > > > to explicitly signal userspace when a specific virtqueue =
has been
> > > > > > > > > enabled.
> > > > > > > > >
> > > > > > > > > In scenarios like Live Migration of VirtIO net devices, t=
he dataplane
> > > > > > > > > starts after the control virtqueue allowing QEMU to apply=
 configuration
> > > > > > > > > in the destination device.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++=
+++++++++++-
> > > > > > > > >  include/uapi/linux/vduse.h         | 19 ++++++++++++++++=
+++
> > > > > > > > >  2 files changed, 46 insertions(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers=
/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > index e7da69c2ad71..1d93b540db4d 100644
> > > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > @@ -9,6 +9,7 @@
> > > > > > > > >   */
> > > > > > > > >
> > > > > > > > >  #include "linux/virtio_net.h"
> > > > > > > > > +#include <linux/bits.h>
> > > > > > > > >  #include <linux/cleanup.h>
> > > > > > > > >  #include <linux/init.h>
> > > > > > > > >  #include <linux/module.h>
> > > > > > > > > @@ -53,7 +54,7 @@
> > > > > > > > >  #define IRQ_UNBOUND -1
> > > > > > > > >
> > > > > > > > >  /* Supported VDUSE features */
> > > > > > > > > -static const uint64_t vduse_features;
> > > > > > > > > +static const uint64_t vduse_features =3D BIT_U64(VDUSE_F=
_QUEUE_READY);
> > > > > > > > >
> > > > > > > > >  /*
> > > > > > > > >   * VDUSE instance have not asked the vduse API version, =
so assume 0.
> > > > > > > > > @@ -120,6 +121,7 @@ struct vduse_dev {
> > > > > > > > >         char *name;
> > > > > > > > >         struct mutex lock;
> > > > > > > > >         spinlock_t msg_lock;
> > > > > > > > > +       u64 vduse_features;
> > > > > > > > >         u64 msg_unique;
> > > > > > > > >         u32 msg_timeout;
> > > > > > > > >         wait_queue_head_t waitq;
> > > > > > > > > @@ -619,7 +621,30 @@ static void vduse_vdpa_set_vq_ready(=
struct vdpa_device *vdpa,
> > > > > > > > >  {
> > > > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > >         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> > > > > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > > +       int r;
> > > > > > > > > +
> > > > > > > > > +       if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUEUE=
_READY)))
> > > > > > > > > +               goto out;
> > > > > > > > > +
> > > > > > > > > +       msg.req.type =3D VDUSE_SET_VQ_READY;
> > > > > > > > > +       msg.req.vq_ready.num =3D idx;
> > > > > > > > > +       msg.req.vq_ready.ready =3D !!ready;
> > > > > > > > > +
> > > > > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > > >
> > > > > > > > > +       if (r < 0) {
> > > > > > > > > +               dev_dbg(&vdpa->dev, "device refuses to se=
t vq %u ready %u",
> > > > > > > > > +                       idx, ready);
> > > > > > > > > +
> > > > > > > > > +               /* We can't do better than break the devi=
ce in this case */
> > > > > > > > > +               spin_lock(&dev->msg_lock);
> > > > > > > > > +               vduse_dev_broken(dev);
> > > > > > > >
> > > > > > > > This has been done by vduse_dev_msg_sync().
> > > > > > > >
> > > > > > >
> > > > > > > This is done by msg_sync() when userland does not reply in a
> > > > > > > timeframe, but not when userland replies with VDUSE_REQ_RESUL=
T_FAILED.
> > > > > > > Should I add a comment?
> > > > > >
> > > > > > If this is not specific to Q_READY, I think we need to move it =
to
> > > > > > msg_sync() as well.
> > > > > >
> > > > >
> > > > > It's specific to Q_READY for me, as it's the request that returns=
 void
> > > > > and has no possibility to inform of an error.
> > > >
> > > > I may miss something, I mean why consider the failure of Q_READY to=
 be
> > > > more serious than the failure of other commands (e.g set_status()).
> > > >
> > >
> > > I'm not considering the failure of Q_READY more serious than any othe=
r
> > > failure. I'm breaking the device here as I cannot return the error to
> > > the vDPA driver: This function returns void.
> >
> > Yes, and set_status() return void as well.
> >
> > void virtio_add_status(struct virtio_device *dev, unsigned int status)
> > {
> >         might_sleep();
> > =3D>      dev->config->set_status(dev, dev->config->get_status(dev) | s=
tatus);
> > }
> >
>
> Yes, I'm not saying all of the other users of vduse_dev_msg_sync don't
> ignore the return code of the userland VDUSE instance. I'm saying that
> we have cases where it is not ignored and the driver can react from
> the error. After a fast look for them:
>
> 1) Case vhost_vdpa -> VHOST_GET_VRING_BASE -> ops->get_vq_state.
> 2) Case vhost_vdpa -> ops->vduse_vdpa_set_map -> vduse_dev_update_iotlb
>
> If the userland VDUSE instance returns an error, -EIO is propagated to
> vhost_vdpa user, and both can react and continue operating normally.
> If we break the device, the same two userlands apps see a totally
> different behavior: The device is totally unusable from that moment.
>
> Do we really want to break the device from the moment that VDUSE
> instance returns an error in these conditions, and do it in an user
> visible change?

Ok, I think you worries about that if we do it for set_status() it
might break userspace. That makes sense.

>
> > >
> > > We can make the function return a bool or int, and then make
> > > vhost_vdpa and virtio_vdpa react to that error.  QEMU is already
> > > prepared for VHOST_VDPA_SET_VRING_ENABLE to return an error, as it is
> > > an ioctl,
> >
> > But we did:
> >
> >         case VHOST_VDPA_SET_VRING_ENABLE:
> >                 if (copy_from_user(&s, argp, sizeof(s)))
> >                         return -EFAULT;
> >                 ops->set_vq_ready(vdpa, idx, s.num);
> >                 return 0;
> >
> > So the failure come from copy_from_user()
> >
>
> Yes. Let me rewrite it as:
>
> We can make ops->set_vq_ready return a bool or int, and then make
> vhost_vdpa react to that error. The driver virtio_vdpa already checks
> the same by calling get_vq_ready, but there is no equivalent in
> vhost_vdpa. I can set a comment explaining the two methods for
> checking the error of the call. QEMU is already prepared for handling
> the return of an error from VHOST_VDPA_SET_VRING_ENABLE, as the ioctl
> already returns errors like -EFAULT, and hopefully the rest of the
> users of VHOST_VDPA_SET_VRING_ENABLE are also prepared.
>
> > >
> > > Should I change vdpa_config_ops->set_vq_ready so it can return an
> > > error, as a prerequisite of this series?
> >
> > Or it would be better to leave the breaking of device on
> > REQ_RESULT_FAILED for future investigation (not blocking this series).
> >
>
> I'd say it's the best option, yes. But my vote is to make
> VHOST_VDPA_SET_VRING_ENABLE more robust actually :).

Ok, I think then it would be better to use a separate patch in this series?

Thanks

>
> > >
> > > > >
> > > > > The VDUSE userland instance could reply to other requests with
> > > > > REQ_RESULT_FAILED and the driver still has capacity to recover fr=
om
> > > > > the failure.
> > > > > If we always break the device on every request fail, we
> > > > > deny that possibility.
> > > > >
> > > >
> > > > Thanks
> > > >
> > >
> >
> > Thanks
> >
>

