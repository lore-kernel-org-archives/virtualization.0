Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6704423D291
	for <virtualization@lists.linux.dev>; Thu, 26 Mar 2026 06:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774508251; cv=none; b=c6myU88aFFOAYy5QuDNaiuVk/i/cRrnnDst+QFtQ/5LIupqQT2g2J/NiPR7o0Bl8FchNCMusfSbcKZYe1krvOBAkPo/iWoTWQCE5kRl5bY2WuxDnvYwrfncbHyPbcZOD6Up0RuKEdamA9aDEwHnN9JhLkqJ/dbfDJqzphGx5l3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774508251; c=relaxed/simple;
	bh=jfkx25VSYrUmUqJC/57AkCFhdwr2lbbG64Yw5zFJH3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ie32FUgi/F4HS3MwUEUnLdm+7kAAbc6qyOXZv1WjUxjpuFg7QdwAY39sQTB5fXZMnByU/FX6+P4ptfSmeUnAvzpQR6ZyduyuXh1+GTu7sEnu58odc5n3QiHFOUYKsdZYhsxgoPG9YrjgjKK1ghDj73HqUBTsrL9fgr3Xj3i4/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=epu7bKb5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epu7bKb5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774508249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2LHljqVs5d+m34NAM3SzfJ4CxMwfUbbKezMqdOzTY60=;
	b=epu7bKb5iefHAbPRACKVch26QhoL/bCFpHdlJKyA9ACnugctwM6XrPNeFMqFoGeM9OUHRk
	jBYrfVncfbs4ShMTB1xMxI3tkUxFhgnw3rSjVqHlzXwJR293zJTRFNWeN8IKYnWx3jAP7K
	9cfujVOlP6gZdmEnMJm5EMELJWyKWxU=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-MHF1atK8Op-E4o8kGi2_8g-1; Thu, 26 Mar 2026 02:57:28 -0400
X-MC-Unique: MHF1atK8Op-E4o8kGi2_8g-1
X-Mimecast-MFC-AGG-ID: MHF1atK8Op-E4o8kGi2_8g_1774508247
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-64eb1476bbfso1910257d50.3
        for <virtualization@lists.linux.dev>; Wed, 25 Mar 2026 23:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774508247; x=1775113047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2LHljqVs5d+m34NAM3SzfJ4CxMwfUbbKezMqdOzTY60=;
        b=FHMK+NmUgQ8xBKSFMpJs8wv7guzGnZEOehxmjoZGO7KAkux1/fpCYLWakHHc73WrIM
         ELXb/la4lTtElswehPlxXHE+SaEAVXulIezuCzv+rpv1TeKNl+s5k7ZLFDcICb7CIptu
         Vq8z63BAK8Eazq3SRHeU2dDm/emsW7CH5inPv0v23F1zteEODRFcbGx7S3AdaBU9redy
         oLzx06id46GE7vTV25U7QTLUqvKw/Ksw9C0xrIopNVBspuQw6fGngFoIBVR2WtJKgaGz
         /sWz/m1eDyk5BBr5zsv4SwytCkFY61B+/sLqkY1/EqBVJNBfascxzvjpmZerVNKVUTP+
         wqjw==
X-Forwarded-Encrypted: i=1; AJvYcCVnnmOtQC1/ISnFyueAx7wU4228AnbpdV0h2kVRR+HeNwXwX3ygzDUb8IWh3LOF2xA3Vm3BEQCrdKeKVCWkmg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyo1oXXSL+1KkfW5ZjCIPSHa1YwTStjocwJj9YxdXYlpTAXZBm6
	0dCFCdzzRjxKNHHbfbfdS0jHdHGAOvy9MRa9XONCKJPURYMgHbpLyXB2fGKCDlDMtc0vU3ewD/g
	4sunnctEIeKUX353DdkqZoWITubjl3fHZGNcJL/pFsMIz8CMkoSO6WJvWEIcj3JCVhu/9rrnePJ
	cGIqNKRHO0YEOjMLmO8ykYxRWfDoMY385J/FSGhA9YXdY=
X-Gm-Gg: ATEYQzwH4dEluYC+JnTpTfgVrxvnb/MFZsNIx56zSVzP75EnGQ3DAI7HvtLKUghcPye
	N7iK9HhL331wZ1fetHToh2IHjtkTDpmJ+syVHS6Wr7mYmoeiPbD70tem8OI4n6++V4i+yucjwm6
	cc6d1nv2Wz+nzZC07jRzJxr87dTL4OGOxgED/ZeLXDl485JStAVsnbWth0SOMH8Ez47kP9NWAId
	difAw==
X-Received: by 2002:a53:b118:0:b0:64e:c169:1665 with SMTP id 956f58d0204a3-64ee61198demr5582577d50.37.1774508247363;
        Wed, 25 Mar 2026 23:57:27 -0700 (PDT)
X-Received: by 2002:a53:b118:0:b0:64e:c169:1665 with SMTP id
 956f58d0204a3-64ee61198demr5582556d50.37.1774508246920; Wed, 25 Mar 2026
 23:57:26 -0700 (PDT)
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
In-Reply-To: <CACGkMEsFwQ=8Hu=OGzhGX5tA5dHNMJBa2K20KDXUmOoru2BR=g@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 26 Mar 2026 07:56:50 +0100
X-Gm-Features: AaiRm52E6l9xGwuxAA5Nsn6RadfaRwgI8BjKn15MDdGQf-rAjrQ6Iy_GvAKNBzI
Message-ID: <CAJaqyWe74=3pqfYhzroSg+SiwX-L8E8bJsk_zK8_BssuPr3bWQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] vduse: add F_QUEUE_READY feature
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LPuS-BqxkNOkODclVNrFGaIKiJe3mw9BbzGX3N76VJw_1774508247
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 3:44=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Mar 24, 2026 at 11:24=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> >
> > On Tue, Mar 24, 2026 at 03:01:47PM +0100, Eugenio Perez Martin wrote:
> > > On Fri, Mar 13, 2026 at 8:08=E2=80=AFAM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Fri, Mar 13, 2026 at 7:05=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Thu, Mar 12, 2026 at 2:24=E2=80=AFPM Eugenio Perez Martin
> > > > > <eperezma@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Mar 12, 2026 at 4:58=E2=80=AFAM Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > On Wed, Mar 11, 2026 at 3:08=E2=80=AFAM Eugenio P=C3=A9rez <e=
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
> > > > > > > > v2:
> > > > > > > > * Fix comment of vduse_dev_request.vq_ready
> > > > > > > > * Set vq_ready before sending the message to the VDUSE user=
land
> > > > > > > >   instance, avoiding the need for SMP sync after receiving =
the message.
> > > > > > > > ---
> > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++++=
+++++++++-
> > > > > > > >  include/uapi/linux/vduse.h         | 18 ++++++++++++++++++
> > > > > > > >  2 files changed, 45 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/v=
dpa/vdpa_user/vduse_dev.c
> > > > > > > > index 17e0358d3a68..4f642b95a7cb 100644
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
> > > > > > > > @@ -601,8 +603,29 @@ static void vduse_vdpa_set_vq_ready(st=
ruct vdpa_device *vdpa,
> > > > > > > >  {
> > > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > >         struct vduse_virtqueue *vq =3D dev->vqs[idx];
> > > > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > +       int r;
> > > > > > > >
> > > > > > > >         vq->ready =3D ready;
> > > > > > > > +
> > > > > > > > +       if (!(dev->vduse_features & BIT_U64(VDUSE_F_QUEUE_R=
EADY)))
> > > > > > > > +               return;
> > > > > > > > +
> > > > > > > > +       msg.req.type =3D VDUSE_SET_VQ_READY;
> > > > > > > > +       msg.req.vq_ready.num =3D idx;
> > > > > > > > +       msg.req.vq_ready.ready =3D !!ready;
> > > > > > > > +
> > > > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > > +
> > > > > > > > +       if (r < 0) {
> > > > > > > > +               dev_dbg(&vdpa->dev, "device refuses to set =
vq %u ready %u",
> > > > > > > > +                       idx, ready);
> > > > > > > > +
> > > > > > > > +               /* We can't do better than break the device=
 in this case */
> > > > > > >
> > > > > > > It's better to explain why we can't depend on vduse_dev_msg_s=
ync() here.
> > > > > > >
> > > > > > > For example it did:
> > > > > > >
> > > > > > >         if (unlikely(dev->broken))
> > > > > > >                 return -EIO;
> > > > > > >
> > > > > > >         init_waitqueue_head(&msg->waitq);
> > > > > > >         spin_lock(&dev->msg_lock);
> > > > > > >         if (unlikely(dev->broken)) {
> > > > > > >                 spin_unlock(&dev->msg_lock);
> > > > > > >                 return -EIO;
> > > > > > >         }
> > > > > > >
> > > > > > > and
> > > > > > >
> > > > > > >         if (!msg->completed) {
> > > > > > >                 list_del(&msg->list);
> > > > > > >                 msg->resp.result =3D VDUSE_REQ_RESULT_FAILED;
> > > > > > >                 /* Mark the device as malfunction when there =
is a timeout */
> > > > > > >                 if (!ret)
> > > > > > >                         vduse_dev_broken(dev);
> > > > > > >         }
> > > > > > >
> > > > > >
> > > > > > I'm not sure I follow you here.
> > > > > >
> > > > > > We can't do better than breaking the device because the functio=
n
> > > > > > returns no error state, and the caller does not expect an error=
 code.
> > > > > > Do you mean we can't depend on vduse_dev_msg_sync to call
> > > > > > vduse_dev_broken(dev) by itself?
> > > > >
> > > > > I think I meant, reset seems to be more heavyweight than suspend.
> > > > >
> > > > > So if reset can fail, I don't see reason ot break device only for
> > > > > suspend failure.
> > > > >
> > > >
> > > > Sorry I still don't get you.
> > > >
> > > > This series does not implement suspend at all. It doesn't modify th=
e
> > > > VDUSE device reset or the virtio reset behavior. It only implements
> > > > the vq ready message for the device. If the device returns an error
> > > > from that operation, what is your proposal for when the driver send=
s
> > > > new messages like resume?
> > > >
> > >
> > > Friendly ping.
> >
> > Jason, more comments? If this is to go in it has to go into linux next.
>
> A typo, basically I meant that reset is more heavyweight than queue
> ready. If we decide to check the response for queue ready, we need to
> check the reset as well.
>
> But I'm fine if you think we can start from this.
>

If you mean something like this:
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c
b/drivers/vdpa/vdpa_user/vduse_dev.c
index 6202f6902fcd..23b850023417 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -816,7 +816,8 @@ static int vduse_vdpa_reset(struct vdpa_device *vdpa)
        struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
        int ret =3D vduse_dev_set_status(dev, 0);

-       vduse_dev_reset(dev);
+       if (ret =3D=3D 0)
+               vduse_dev_reset(dev);

        return ret;
 }

---

I totally agree. But in my opinion, it's outside this series' scope. I
can send a patch on top.

