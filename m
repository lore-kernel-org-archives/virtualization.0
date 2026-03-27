Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8AA386540
	for <virtualization@lists.linux.dev>; Fri, 27 Mar 2026 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774592689; cv=none; b=C//9YmsrW6zRtCMmjpJH6P/BukWMATF35pJu+12MyK25XZDkniloGA8wrhhCgF16wIZI4SldD+JXS+rRFK6SN9Z0yOTn121ElGrSoituDElxIQh44jQfgaDvqWPDmJXMLi1y7Ht2ihiB1ENISOOME8eBeJJnaq2iR5gZpi7MZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774592689; c=relaxed/simple;
	bh=ANbGHaKeAA/lNhx279xbXmAwyVDnKcwXDFpkch90aXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnmZ+NNimpbNQa20Pqsgy3oBJ5PGNKa90+/snUUcXPzhcnvJ8lBi1YLafGog4gCkO8KRJs6zzevewVYR2PY2siA50XUrTzLFwtfyS1IlEv743w3tSdI+6eKMTjT2GNgPcohohr2oz6lkR6rgjklcgtAV/Lm+PYGdx9dMkCOGvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRMnXzhu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRMnXzhu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774592683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dNCDbAlAePjte5UYR05hE5vrYjE9xAw8CJotVbK8a5Y=;
	b=hRMnXzhu2Od/Njk28oLvXOr4iKfX+qQyIzInk2ax1UJ1S/hMNV+/ZDB+f0uV348p891ZWb
	IoGjU9J7dhHa7y5I3DqMrkawMPIwdMBwuD3Y3xSACH1ZhnGnVrDAuJbQeKSR5hoHjHwFE0
	DxaOR6DVZ5pe1dBEGL8H9rSWj4XWqv4=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-QfoE_9gqMBmpx5Tsk6kbzA-1; Fri, 27 Mar 2026 02:24:41 -0400
X-MC-Unique: QfoE_9gqMBmpx5Tsk6kbzA-1
X-Mimecast-MFC-AGG-ID: QfoE_9gqMBmpx5Tsk6kbzA_1774592681
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-79832285fa1so38348037b3.1
        for <virtualization@lists.linux.dev>; Thu, 26 Mar 2026 23:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774592681; x=1775197481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dNCDbAlAePjte5UYR05hE5vrYjE9xAw8CJotVbK8a5Y=;
        b=bQfW0dJ14QhL93hPgdp3bLdBlatotVP2zy7OfB5Q0K22jMIMSPbvb42c8D2rtvhPfK
         QRx8YrV9CrKkTWlR2MrPsXVRzqdCOr3iCj2FddGJlQmLjsACef6bWM9u8Yw2gjoX5yK8
         vUt3nsXtQCFtw0tb3E9zuJjXEnU7/oP6FsqOSW/jgxTOFt6ig0FGiiBf50woZbwTRWeG
         H/s6oCiutiFdZak+F+rt0gGkdt4b3hocBDp4Gm/RyeXxQLt6YqT9Kxk02szqzo7VAmuS
         zq6NJWnwu/UrY+L4WXI3MC7scusRvHLrfFKfs+WTKCXqqjaAOPckG+etg2yGACdg1ZQc
         wKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbhEOc1EU4KGMA1jsPjH+lH5QjZ3xLjpTsWBfl1f6vm/cGThGAwNJLquaE4fJdPhIL4WMIrLwTMp3psvvu5w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2J+Pt6pAVinRGTK75zomdv7tlAozSsYjHwwPjKPOhGX38XZLL
	+pYgd0BGNGjko/blpfYPgY0tTW+T/QkLKGpSuvnO/27Vhm6taebLzGuCq57jMDxpNaDvPqTLtvQ
	Px3hob1VelVF+hQ3TsQiDHcLx24USXVKBjZ6SN/SF6Bfz/F/StMxRU3hSEDk223eO8Y0FmUP8EY
	DpRqObNay2hTH1IMMh6aEnebEduZ49wD7/NSRT1Y7FOtk=
X-Gm-Gg: ATEYQzyZ+wpcpmh2jdyjviKsC0VvwibWrBJYPXTxxC/vuvpF7+rk9qYw22sSAwNymJd
	K/+uaIw/e5uJ6IemaWpcAmdLoDju24cFZz6CxnU+hfMAqs2abm+mfKwDKlmaePaOEtUUe7pLXk9
	eekHsywnhFLa/FO7+EogrAUHvuUOPESanpBcYOLQAlNyddJAsflQzBedb2eIFCo12wdziafBYLB
	FARkA==
X-Received: by 2002:a05:690e:440e:b0:64c:af3f:e2a3 with SMTP id 956f58d0204a3-64ff74158efmr1106852d50.55.1774592680887;
        Thu, 26 Mar 2026 23:24:40 -0700 (PDT)
X-Received: by 2002:a05:690e:440e:b0:64c:af3f:e2a3 with SMTP id
 956f58d0204a3-64ff74158efmr1106834d50.55.1774592680349; Thu, 26 Mar 2026
 23:24:40 -0700 (PDT)
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
 <CAJaqyWe74=3pqfYhzroSg+SiwX-L8E8bJsk_zK8_BssuPr3bWQ@mail.gmail.com> <CACGkMEsA8Rt+3Y3_-kA5dyL1jgqkE5LQ_M3X9P-cjhKXT1A+tA@mail.gmail.com>
In-Reply-To: <CACGkMEsA8Rt+3Y3_-kA5dyL1jgqkE5LQ_M3X9P-cjhKXT1A+tA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 27 Mar 2026 07:24:03 +0100
X-Gm-Features: AQROBzCu3C2Mzzs2cMGo0oXc5drVXPeTxaW8NHaacrSRVjZZv-VyJItaDMP9xwY
Message-ID: <CAJaqyWfh5gWdusrC25gxGpVfqyssUxzeLD9QLTcgVpwgR4_Sxw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] vduse: add F_QUEUE_READY feature
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jlvNFGqgwrurXxmVoKOtT28piAhk2J6gazrCR6XaM-c_1774592681
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 2:15=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Mar 26, 2026 at 2:57=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Thu, Mar 26, 2026 at 3:44=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Tue, Mar 24, 2026 at 11:24=E2=80=AFPM Michael S. Tsirkin <mst@redh=
at.com> wrote:
> > > >
> > > > On Tue, Mar 24, 2026 at 03:01:47PM +0100, Eugenio Perez Martin wrot=
e:
> > > > > On Fri, Mar 13, 2026 at 8:08=E2=80=AFAM Eugenio Perez Martin
> > > > > <eperezma@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Mar 13, 2026 at 7:05=E2=80=AFAM Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > On Thu, Mar 12, 2026 at 2:24=E2=80=AFPM Eugenio Perez Martin
> > > > > > > <eperezma@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Mar 12, 2026 at 4:58=E2=80=AFAM Jason Wang <jasowan=
g@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Mar 11, 2026 at 3:08=E2=80=AFAM Eugenio P=C3=A9re=
z <eperezma@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Add the VDUSE_F_QUEUE_READY feature flag. This allows t=
he kernel module
> > > > > > > > > > to explicitly signal userspace when a specific virtqueu=
e has been
> > > > > > > > > > enabled.
> > > > > > > > > >
> > > > > > > > > > In scenarios like Live Migration of VirtIO net devices,=
 the dataplane
> > > > > > > > > > starts after the control virtqueue allowing QEMU to app=
ly configuration
> > > > > > > > > > in the destination device.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > > > > ---
> > > > > > > > > > v2:
> > > > > > > > > > * Fix comment of vduse_dev_request.vq_ready
> > > > > > > > > > * Set vq_ready before sending the message to the VDUSE =
userland
> > > > > > > > > >   instance, avoiding the need for SMP sync after receiv=
ing the message.
> > > > > > > > > > ---
> > > > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++=
+++++++++++++-
> > > > > > > > > >  include/uapi/linux/vduse.h         | 18 ++++++++++++++=
++++
> > > > > > > > > >  2 files changed, 45 insertions(+), 1 deletion(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drive=
rs/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > index 17e0358d3a68..4f642b95a7cb 100644
> > > > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > @@ -9,6 +9,7 @@
> > > > > > > > > >   */
> > > > > > > > > >
> > > > > > > > > >  #include "linux/virtio_net.h"
> > > > > > > > > > +#include <linux/bits.h>
> > > > > > > > > >  #include <linux/cleanup.h>
> > > > > > > > > >  #include <linux/init.h>
> > > > > > > > > >  #include <linux/module.h>
> > > > > > > > > > @@ -53,7 +54,7 @@
> > > > > > > > > >  #define IRQ_UNBOUND -1
> > > > > > > > > >
> > > > > > > > > >  /* Supported VDUSE features */
> > > > > > > > > > -static const uint64_t vduse_features;
> > > > > > > > > > +static const uint64_t vduse_features =3D BIT_U64(VDUSE=
_F_QUEUE_READY);
> > > > > > > > > >
> > > > > > > > > >  /*
> > > > > > > > > >   * VDUSE instance have not asked the vduse API version=
, so assume 0.
> > > > > > > > > > @@ -120,6 +121,7 @@ struct vduse_dev {
> > > > > > > > > >         char *name;
> > > > > > > > > >         struct mutex lock;
> > > > > > > > > >         spinlock_t msg_lock;
> > > > > > > > > > +       u64 vduse_features;
> > > > > > > > > >         u64 msg_unique;
> > > > > > > > > >         u32 msg_timeout;
> > > > > > > > > >         wait_queue_head_t waitq;
> > > > > > > > > > @@ -601,8 +603,29 @@ static void vduse_vdpa_set_vq_read=
y(struct vdpa_device *vdpa,
> > > > > > > > > >  {
> > > > > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > > >         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> > > > > > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > > > +       int r;
> > > > > > > > > >
> > > > > > > > > >         vq->ready =3D ready;
> > > > > > > > > > +
> > > > > > > > > > +       if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUE=
UE_READY)))
> > > > > > > > > > +               return;
> > > > > > > > > > +
> > > > > > > > > > +       msg.req.type =3D VDUSE_SET_VQ_READY;
> > > > > > > > > > +       msg.req.vq_ready.num =3D idx;
> > > > > > > > > > +       msg.req.vq_ready.ready =3D !!ready;
> > > > > > > > > > +
> > > > > > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > > +
> > > > > > > > > > +       if (r < 0) {
> > > > > > > > > > +               dev_dbg(&vdpa->dev, "device refuses to =
set vq %u ready %u",
> > > > > > > > > > +                       idx, ready);
> > > > > > > > > > +
> > > > > > > > > > +               /* We can't do better than break the de=
vice in this case */
> > > > > > > > >
> > > > > > > > > It's better to explain why we can't depend on vduse_dev_m=
sg_sync() here.
> > > > > > > > >
> > > > > > > > > For example it did:
> > > > > > > > >
> > > > > > > > >         if (unlikely(dev->broken))
> > > > > > > > >                 return -EIO;
> > > > > > > > >
> > > > > > > > >         init_waitqueue_head(&msg->waitq);
> > > > > > > > >         spin_lock(&dev->msg_lock);
> > > > > > > > >         if (unlikely(dev->broken)) {
> > > > > > > > >                 spin_unlock(&dev->msg_lock);
> > > > > > > > >                 return -EIO;
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > and
> > > > > > > > >
> > > > > > > > >         if (!msg->completed) {
> > > > > > > > >                 list_del(&msg->list);
> > > > > > > > >                 msg->resp.result =3D VDUSE_REQ_RESULT_FAI=
LED;
> > > > > > > > >                 /* Mark the device as malfunction when th=
ere is a timeout */
> > > > > > > > >                 if (!ret)
> > > > > > > > >                         vduse_dev_broken(dev);
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > >
> > > > > > > > I'm not sure I follow you here.
> > > > > > > >
> > > > > > > > We can't do better than breaking the device because the fun=
ction
> > > > > > > > returns no error state, and the caller does not expect an e=
rror code.
> > > > > > > > Do you mean we can't depend on vduse_dev_msg_sync to call
> > > > > > > > vduse_dev_broken(dev) by itself?
> > > > > > >
> > > > > > > I think I meant, reset seems to be more heavyweight than susp=
end.
> > > > > > >
> > > > > > > So if reset can fail, I don't see reason ot break device only=
 for
> > > > > > > suspend failure.
> > > > > > >
> > > > > >
> > > > > > Sorry I still don't get you.
> > > > > >
> > > > > > This series does not implement suspend at all. It doesn't modif=
y the
> > > > > > VDUSE device reset or the virtio reset behavior. It only implem=
ents
> > > > > > the vq ready message for the device. If the device returns an e=
rror
> > > > > > from that operation, what is your proposal for when the driver =
sends
> > > > > > new messages like resume?
> > > > > >
> > > > >
> > > > > Friendly ping.
> > > >
> > > > Jason, more comments? If this is to go in it has to go into linux n=
ext.
> > >
> > > A typo, basically I meant that reset is more heavyweight than queue
> > > ready. If we decide to check the response for queue ready, we need to
> > > check the reset as well.
> > >
> > > But I'm fine if you think we can start from this.
> > >
> >
> > If you mean something like this:
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c
> > b/drivers/vdpa/vdpa_user/vduse_dev.c
> > index 6202f6902fcd..23b850023417 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -816,7 +816,8 @@ static int vduse_vdpa_reset(struct vdpa_device *vdp=
a)
> >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> >         int ret =3D vduse_dev_set_status(dev, 0);
> >
> > -       vduse_dev_reset(dev);
> > +       if (ret =3D=3D 0)
> > +               vduse_dev_reset(dev);
>
> Something like this but we need to check if it's a timeout as queue ready=
.
>

What should VDUSE or vdpa layer do differently if it is a timeout vs
returning an error?

> >
> >         return ret;
> >  }
> >
> > ---
> >
> > I totally agree. But in my opinion, it's outside this series' scope. I
> > can send a patch on top.
> >
>
> Works for me.
>
> Thanks
>

