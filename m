Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED462135C5
	for <virtualization@lists.linux.dev>; Fri, 27 Mar 2026 01:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574138; cv=none; b=I6ix1Yp9lo2SVk8PgaB7CQOIrPPPQ1FZTrmsxY302QbPNudgYTPZb07ARci7OsCwvmU3Lszm2KZA0uxTQmTgSYhdHbkXobsXVfegYP2BxZXbK339AP66vaxLsleNOZggpeW2JsNVq21B2JdFlSX+T7YFKEJRiSBDGL71C4t1U4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574138; c=relaxed/simple;
	bh=TCK1Q+feG5AsWoU77KASPJT7280BdQ6k2DRbqfmCChE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsL1uncOfxPW+ntuob1IfA1BLt1uWcq4iRPuNirV+wcP3QbbGFAurhMLqfBI8mruqMfkhGBeYNABj74+8VUQiJqvpAFeS55gqT+JoDfXQv4dR62XG6FckPN8Rt5Irm+ACP+doDWTDWgL3HpXG5/uQ/Ym1os6AdfiMOsHbxHLauo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPhwdnr7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPhwdnr7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774574135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5vTJ2b2fv8SnIhF1x4tjcZkmifJ3WjKDU3Q/ihRO4xA=;
	b=EPhwdnr73GuCVBFgYiD/P7CCoHj9TqxeP+KZ3xWfpNCulOK9pCOrFZCjXjosGPqezT2+hC
	v7d0BgtajFEqvaentvaLa9lL2uScEEkBicMCx1grCeAOHRhVDiS/AsLxUkcq3reAD96xUe
	S0JL4QWSQov/J34APRByoemqVw/uuhA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-pxvejHRBNhWEO1xfk659kw-1; Thu, 26 Mar 2026 21:15:34 -0400
X-MC-Unique: pxvejHRBNhWEO1xfk659kw-1
X-Mimecast-MFC-AGG-ID: pxvejHRBNhWEO1xfk659kw_1774574133
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c737b6686ddso1097804a12.3
        for <virtualization@lists.linux.dev>; Thu, 26 Mar 2026 18:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774574133; x=1775178933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5vTJ2b2fv8SnIhF1x4tjcZkmifJ3WjKDU3Q/ihRO4xA=;
        b=I0PIBKfT1B8wP1KvGeSXdJpxqm42zMaN98bik1w9wWD/4LEB7qB2gMzZxdU4riy2rc
         3Z4fWCZvbbzSvlM+MzDfwND+f5qk1EWUDIxbOdd621uN9YPQk97C/m8zRkxN676a6YLp
         4pM/yQfZVKmmCsrj5A9Fk6s+F6gvbaUosisr8OxPo9fCV0dEXhP8fOipjIHR33GKi0Jg
         f9tNhN+ayW0WdjfkyJTHs3BDJbgeB/4aqW9bvGbo8VxquwOzyK8N2Zj5UQz9yIPOwxvs
         V3z2VKN0AaQ1iXFknJ8otCOAfdyx56WwuCgrX4yLOE3dLBPzOn1qnNHdgZxDF9qYwMYo
         gC6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVW6ui/sBpHUE3F/lgyjW/kXfpc0Y2g4A8CLjgpqfyPr8qw5Wh/ZWUMBImG6/6W70LLdVsmUk1TN25raA0gKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywx0quJ0kQfETQYOEFidLspPiRjLyNt2mCoxLv6z66UCHYXpsR7
	/n3JUKiHA9Hcbrhbsc8pLU5chvClkZU0Fv6BhEe1BBIP9A8Cvyxh5OBR+LPe1ZUbBx1+wnnZpDG
	JBskrPK7XC5O+K7psM9y5WTiugDIXxeo4Wx0pNNplNB3izY5KYettP6rroieiQ1ixc6zwCFpGyQ
	I8Gpj03OsBDzaqUPisnsVMGt3+ZNGQmbMPyWitktZcn8w=
X-Gm-Gg: ATEYQzxGT3ALhtOQ25lz3Mi0hwToPDbwwcv7J7uU83Xljg6qidlmtCrseLjA3AteIgs
	bvZyria086lE2qckc0WXxHWJAYdpxyg0KsquPYmlPX7L7SHzkPCmq0R7DL4LNqKQk7XAQF1RT5w
	H33IPqxI5xY2CTzy9XcylAvrPg8QrR/OtqiGqkjXZmXHi8Sl6T7iYNwSkD/UyJcW3dhSzkhTFTa
	x0+nPs=
X-Received: by 2002:a05:6a20:3d12:b0:39b:f750:a6f5 with SMTP id adf61e73a8af0-39c87c09bf2mr679003637.51.1774574133338;
        Thu, 26 Mar 2026 18:15:33 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d12:b0:39b:f750:a6f5 with SMTP id
 adf61e73a8af0-39c87c09bf2mr678957637.51.1774574132636; Thu, 26 Mar 2026
 18:15:32 -0700 (PDT)
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
 <CAJaqyWd40=bxMOwTR4wyHtPS_-Txn2WbwSj9rZEXoY-4DxQgpw@mail.gmail.com>
 <20260324112340-mutt-send-email-mst@kernel.org> <CACGkMEsFwQ=8Hu=OGzhGX5tA5dHNMJBa2K20KDXUmOoru2BR=g@mail.gmail.com>
 <CAJaqyWe74=3pqfYhzroSg+SiwX-L8E8bJsk_zK8_BssuPr3bWQ@mail.gmail.com>
In-Reply-To: <CAJaqyWe74=3pqfYhzroSg+SiwX-L8E8bJsk_zK8_BssuPr3bWQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Mar 2026 09:15:21 +0800
X-Gm-Features: AQROBzDWict4V-K84Vnyu-EFTUVIADSFuExZTm1R9XZHRbxEhOvMk4M1xK4AJdA
Message-ID: <CACGkMEsA8Rt+3Y3_-kA5dyL1jgqkE5LQ_M3X9P-cjhKXT1A+tA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] vduse: add F_QUEUE_READY feature
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zBGD5wx-3PIaV7QGI0qrvj3paZXBfT47ntFj2pK535w_1774574133
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 2:57=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Mar 26, 2026 at 3:44=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Tue, Mar 24, 2026 at 11:24=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Tue, Mar 24, 2026 at 03:01:47PM +0100, Eugenio Perez Martin wrote:
> > > > On Fri, Mar 13, 2026 at 8:08=E2=80=AFAM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Fri, Mar 13, 2026 at 7:05=E2=80=AFAM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > >
> > > > > > On Thu, Mar 12, 2026 at 2:24=E2=80=AFPM Eugenio Perez Martin
> > > > > > <eperezma@redhat.com> wrote:
> > > > > > >
> > > > > > > On Thu, Mar 12, 2026 at 4:58=E2=80=AFAM Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Mar 11, 2026 at 3:08=E2=80=AFAM Eugenio P=C3=A9rez =
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
> > > > > > > > > v2:
> > > > > > > > > * Fix comment of vduse_dev_request.vq_ready
> > > > > > > > > * Set vq_ready before sending the message to the VDUSE us=
erland
> > > > > > > > >   instance, avoiding the need for SMP sync after receivin=
g the message.
> > > > > > > > > ---
> > > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++=
+++++++++++-
> > > > > > > > >  include/uapi/linux/vduse.h         | 18 ++++++++++++++++=
++
> > > > > > > > >  2 files changed, 45 insertions(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers=
/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > index 17e0358d3a68..4f642b95a7cb 100644
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
> > > > > > > > > @@ -601,8 +603,29 @@ static void vduse_vdpa_set_vq_ready(=
struct vdpa_device *vdpa,
> > > > > > > > >  {
> > > > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > >         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> > > > > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > > +       int r;
> > > > > > > > >
> > > > > > > > >         vq->ready =3D ready;
> > > > > > > > > +
> > > > > > > > > +       if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUEUE=
_READY)))
> > > > > > > > > +               return;
> > > > > > > > > +
> > > > > > > > > +       msg.req.type =3D VDUSE_SET_VQ_READY;
> > > > > > > > > +       msg.req.vq_ready.num =3D idx;
> > > > > > > > > +       msg.req.vq_ready.ready =3D !!ready;
> > > > > > > > > +
> > > > > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > +
> > > > > > > > > +       if (r < 0) {
> > > > > > > > > +               dev_dbg(&vdpa->dev, "device refuses to se=
t vq %u ready %u",
> > > > > > > > > +                       idx, ready);
> > > > > > > > > +
> > > > > > > > > +               /* We can't do better than break the devi=
ce in this case */
> > > > > > > >
> > > > > > > > It's better to explain why we can't depend on vduse_dev_msg=
_sync() here.
> > > > > > > >
> > > > > > > > For example it did:
> > > > > > > >
> > > > > > > >         if (unlikely(dev->broken))
> > > > > > > >                 return -EIO;
> > > > > > > >
> > > > > > > >         init_waitqueue_head(&msg->waitq);
> > > > > > > >         spin_lock(&dev->msg_lock);
> > > > > > > >         if (unlikely(dev->broken)) {
> > > > > > > >                 spin_unlock(&dev->msg_lock);
> > > > > > > >                 return -EIO;
> > > > > > > >         }
> > > > > > > >
> > > > > > > > and
> > > > > > > >
> > > > > > > >         if (!msg->completed) {
> > > > > > > >                 list_del(&msg->list);
> > > > > > > >                 msg->resp.result =3D VDUSE_REQ_RESULT_FAILE=
D;
> > > > > > > >                 /* Mark the device as malfunction when ther=
e is a timeout */
> > > > > > > >                 if (!ret)
> > > > > > > >                         vduse_dev_broken(dev);
> > > > > > > >         }
> > > > > > > >
> > > > > > >
> > > > > > > I'm not sure I follow you here.
> > > > > > >
> > > > > > > We can't do better than breaking the device because the funct=
ion
> > > > > > > returns no error state, and the caller does not expect an err=
or code.
> > > > > > > Do you mean we can't depend on vduse_dev_msg_sync to call
> > > > > > > vduse_dev_broken(dev) by itself?
> > > > > >
> > > > > > I think I meant, reset seems to be more heavyweight than suspen=
d.
> > > > > >
> > > > > > So if reset can fail, I don't see reason ot break device only f=
or
> > > > > > suspend failure.
> > > > > >
> > > > >
> > > > > Sorry I still don't get you.
> > > > >
> > > > > This series does not implement suspend at all. It doesn't modify =
the
> > > > > VDUSE device reset or the virtio reset behavior. It only implemen=
ts
> > > > > the vq ready message for the device. If the device returns an err=
or
> > > > > from that operation, what is your proposal for when the driver se=
nds
> > > > > new messages like resume?
> > > > >
> > > >
> > > > Friendly ping.
> > >
> > > Jason, more comments? If this is to go in it has to go into linux nex=
t.
> >
> > A typo, basically I meant that reset is more heavyweight than queue
> > ready. If we decide to check the response for queue ready, we need to
> > check the reset as well.
> >
> > But I'm fine if you think we can start from this.
> >
>
> If you mean something like this:
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c
> b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 6202f6902fcd..23b850023417 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -816,7 +816,8 @@ static int vduse_vdpa_reset(struct vdpa_device *vdpa)
>         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
>         int ret =3D vduse_dev_set_status(dev, 0);
>
> -       vduse_dev_reset(dev);
> +       if (ret =3D=3D 0)
> +               vduse_dev_reset(dev);

Something like this but we need to check if it's a timeout as queue ready.

>
>         return ret;
>  }
>
> ---
>
> I totally agree. But in my opinion, it's outside this series' scope. I
> can send a patch on top.
>

Works for me.

Thanks

