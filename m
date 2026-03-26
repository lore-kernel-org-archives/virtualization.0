Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4B439151F
	for <virtualization@lists.linux.dev>; Thu, 26 Mar 2026 02:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774493058; cv=none; b=cJL+Ai2exlNywmegEvTwcAz0mSUTgKDaM1QX6mgwt7FuLQeIh/eWembZ3SnorSacj85Ofyj/F/2M8b/qkscnS06+YGJKncry87MBALvs5sK/XUU+oBNnKPVKFv5eWgbF40m8iVFYWu8VkMk8cUQeDOm5hKaDOaQ8NF6LaNuYS34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774493058; c=relaxed/simple;
	bh=0S1pUx2BvrmOmuOf95N3tuU2+Va4tkG5YPfCoA3y/VI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spMgV3NN5iW0Nj2OpBmYwGJaa2kQTK2C7GbAy5eyH5SlKBWt+hVrmPIe+7du8crUSxFFRo2iZaxXTo5faKdDegPqyor9cEiFf9wTJPSfwI/3U7Ku3URnnewkm+6BY22+Wovp32zl+lbJUTFMRB7Yc0VE75Vxd6AN5LgWPxPMjp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXaQWPjX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXaQWPjX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774493055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mLBpxJCBhRAvoIBB6nBH1AzmBnESylgkCNwVvr7yuHI=;
	b=OXaQWPjX00mf2MieCRhq2XBzPl3p1HTsalxpBLT2djxIbHj7vSTnnp7MPK7Of+HYjbiVBh
	PY4OFdhX9mmZxV/1KwTyjXg6cCtP4vX5eLCe5tkvT/jW6uk+S7yL3stFfcjtjoMIqsBINX
	xbAsO6gfuQohCX1NqLucEe8R0VXMkNc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-OKKr_HCmMqO_CRTKIkm_Rw-1; Wed, 25 Mar 2026 22:44:13 -0400
X-MC-Unique: OKKr_HCmMqO_CRTKIkm_Rw-1
X-Mimecast-MFC-AGG-ID: OKKr_HCmMqO_CRTKIkm_Rw_1774493053
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c741a9ef5f0so299985a12.1
        for <virtualization@lists.linux.dev>; Wed, 25 Mar 2026 19:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774493052; x=1775097852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mLBpxJCBhRAvoIBB6nBH1AzmBnESylgkCNwVvr7yuHI=;
        b=NOPay+PRHMeV+0JIx6O5i8uSqQLdLXDJFT1GD5TUHmSyb870nkxcEoRhRuIZKkvjO6
         kSg+yTfrWwE2PmK+FAYMhXBf6XSuXjTAujdhjoLkECZPheN9IfhlLSbO0k16p5/hTLMw
         c0MLet1AE+VDmX1LBUn0wWvayOmjm5AIVfo86tK11S1nmQKvlrtDP4WQ/2n0Cnjz73gy
         4jskpnF+5qGXElr5h46Sar88QHqRNJYhKbwHjHO0MhwFipISz1tUK8ZloPJPxd1jQzoU
         9SGwGxaE+y69EO5Iiw7bDdM8soTp79JU3E+jRrpqGxy7L3riX6qeC/eSswOsLcprT1hS
         KcMA==
X-Forwarded-Encrypted: i=1; AJvYcCUHqPis8Y40pg8XbW34MC/EzSskyIL9q291Vr6F1jquHbMj2MctZOpvSwnXC4qAE61dElmc4lEWwHb/Zhv1GA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvIKI/fa+jOlMHs3LQ6gsuocMj6uDq+lTMNAkbLIaRWcPSvJ31
	TT90ZR2u5hA/65lfFVoEJsgPCjCrjsh5EFtyNbIfHLieF9N0aPzo1sT28lYwFGk2+31KEgzPh6n
	eYE+kQuKmGxqxWWcHhKc9bt2xgGS6+Z/gvroShCge5EwGgTli5Vef25439QnhSv/nMsFWd/AXKL
	k/RqYjxsfHF2mHGu7Ve5sd0rz/kKawHpdGUKcXuIi7mXo=
X-Gm-Gg: ATEYQzzZuo7QgnUPJCS7WB98kwEtFGRUctXwP+ate9Xe7hQzSE+VOEi2SfbxrqdBL/t
	lDAuEQxOWYWYo/1dUMMAmme3zY7VvTx3qtH4jUtKOB7kO+1pCqnp+IW/D2j3ussh1U+WhybiE7L
	xP1L33LjB5kG55H8ww+9UAkLtoCPgwlxk6VQ/nn4HXnAS7hzkBvTqkwXMa5PPFAi6MXoUUCUHZD
	dsb
X-Received: by 2002:a05:6a20:4308:b0:395:acfc:b679 with SMTP id adf61e73a8af0-39c31029109mr8954311637.18.1774493052485;
        Wed, 25 Mar 2026 19:44:12 -0700 (PDT)
X-Received: by 2002:a05:6a20:4308:b0:395:acfc:b679 with SMTP id
 adf61e73a8af0-39c31029109mr8954283637.18.1774493051881; Wed, 25 Mar 2026
 19:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310190759.1097506-1-eperezma@redhat.com> <20260310190759.1097506-4-eperezma@redhat.com>
 <CACGkMEvwmC4qiYgZAkrHEC3r3q7FyMiqpg5=2oNMPGm0q=PLBA@mail.gmail.com>
 <CAJaqyWe+x9okNwPD5n6M+PeLt0cQY-_fBWOD9uXSa1nKHqRaFw@mail.gmail.com>
 <CACGkMEuKTezQQXJ0XEKWEoRaeo-ORcE07+xgSoJ_7UwpPdonWA@mail.gmail.com>
 <CAJaqyWf5mnARrEXssKQ2CQB0rZ+KVi_kW1xyOc_Dx1ELAs4LHA@mail.gmail.com>
 <CAJaqyWd40=bxMOwTR4wyHtPS_-Txn2WbwSj9rZEXoY-4DxQgpw@mail.gmail.com> <20260324112340-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260324112340-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Mar 2026 10:44:00 +0800
X-Gm-Features: AQROBzBUGUvCSldfDVUcr8Prb-S6ySaCxp6Ayi1QRXT4Ng2AcFHbJ_76cyqYGg4
Message-ID: <CACGkMEsFwQ=8Hu=OGzhGX5tA5dHNMJBa2K20KDXUmOoru2BR=g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] vduse: add F_QUEUE_READY feature
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u-9BP7AYd5f7SWIzc_I8DkNT5wDoyZqZVMdVXQQkiRA_1774493053
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 11:24=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Mar 24, 2026 at 03:01:47PM +0100, Eugenio Perez Martin wrote:
> > On Fri, Mar 13, 2026 at 8:08=E2=80=AFAM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Fri, Mar 13, 2026 at 7:05=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Thu, Mar 12, 2026 at 2:24=E2=80=AFPM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Thu, Mar 12, 2026 at 4:58=E2=80=AFAM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > >
> > > > > > On Wed, Mar 11, 2026 at 3:08=E2=80=AFAM Eugenio P=C3=A9rez <epe=
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
> > > > > > > v2:
> > > > > > > * Fix comment of vduse_dev_request.vq_ready
> > > > > > > * Set vq_ready before sending the message to the VDUSE userla=
nd
> > > > > > >   instance, avoiding the need for SMP sync after receiving th=
e message.
> > > > > > > ---
> > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++++++=
+++++++-
> > > > > > >  include/uapi/linux/vduse.h         | 18 ++++++++++++++++++
> > > > > > >  2 files changed, 45 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdp=
a/vdpa_user/vduse_dev.c
> > > > > > > index 17e0358d3a68..4f642b95a7cb 100644
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
> > > > > > > @@ -601,8 +603,29 @@ static void vduse_vdpa_set_vq_ready(stru=
ct vdpa_device *vdpa,
> > > > > > >  {
> > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > >         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> > > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > > +       int r;
> > > > > > >
> > > > > > >         vq->ready =3D ready;
> > > > > > > +
> > > > > > > +       if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUEUE_REA=
DY)))
> > > > > > > +               return;
> > > > > > > +
> > > > > > > +       msg.req.type =3D VDUSE_SET_VQ_READY;
> > > > > > > +       msg.req.vq_ready.num =3D idx;
> > > > > > > +       msg.req.vq_ready.ready =3D !!ready;
> > > > > > > +
> > > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > +
> > > > > > > +       if (r < 0) {
> > > > > > > +               dev_dbg(&vdpa->dev, "device refuses to set vq=
 %u ready %u",
> > > > > > > +                       idx, ready);
> > > > > > > +
> > > > > > > +               /* We can't do better than break the device i=
n this case */
> > > > > >
> > > > > > It's better to explain why we can't depend on vduse_dev_msg_syn=
c() here.
> > > > > >
> > > > > > For example it did:
> > > > > >
> > > > > >         if (unlikely(dev->broken))
> > > > > >                 return -EIO;
> > > > > >
> > > > > >         init_waitqueue_head(&msg->waitq);
> > > > > >         spin_lock(&dev->msg_lock);
> > > > > >         if (unlikely(dev->broken)) {
> > > > > >                 spin_unlock(&dev->msg_lock);
> > > > > >                 return -EIO;
> > > > > >         }
> > > > > >
> > > > > > and
> > > > > >
> > > > > >         if (!msg->completed) {
> > > > > >                 list_del(&msg->list);
> > > > > >                 msg->resp.result =3D VDUSE_REQ_RESULT_FAILED;
> > > > > >                 /* Mark the device as malfunction when there is=
 a timeout */
> > > > > >                 if (!ret)
> > > > > >                         vduse_dev_broken(dev);
> > > > > >         }
> > > > > >
> > > > >
> > > > > I'm not sure I follow you here.
> > > > >
> > > > > We can't do better than breaking the device because the function
> > > > > returns no error state, and the caller does not expect an error c=
ode.
> > > > > Do you mean we can't depend on vduse_dev_msg_sync to call
> > > > > vduse_dev_broken(dev) by itself?
> > > >
> > > > I think I meant, reset seems to be more heavyweight than suspend.
> > > >
> > > > So if reset can fail, I don't see reason ot break device only for
> > > > suspend failure.
> > > >
> > >
> > > Sorry I still don't get you.
> > >
> > > This series does not implement suspend at all. It doesn't modify the
> > > VDUSE device reset or the virtio reset behavior. It only implements
> > > the vq ready message for the device. If the device returns an error
> > > from that operation, what is your proposal for when the driver sends
> > > new messages like resume?
> > >
> >
> > Friendly ping.
>
> Jason, more comments? If this is to go in it has to go into linux next.

A typo, basically I meant that reset is more heavyweight than queue
ready. If we decide to check the response for queue ready, we need to
check the reset as well.

But I'm fine if you think we can start from this.

Thanks

>
> --
> MST
>

