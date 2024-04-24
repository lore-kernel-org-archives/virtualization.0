Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A476013C3F8
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Apr 2024 03:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930720; cv=none; b=Ep/t2C7Ic2fEAMlEbG2uEPQEQJ+QwQNcpqy5xGPYjZ0aOqGq4gi+M8G7pnVCOpbN9XlIM8DRMvDj8U0aXw9IICYZoIdNlkxtzOCivZBQE+9z+Q3+2guI+Cl/BopaKnt1nKUnkOZ0JZTFLZS7v9e1rs2DKPYtTWNtGpMo/BqZX/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930720; c=relaxed/simple;
	bh=zmPXM0Dhe+4wAw7Mwb5P63k5qIFw0RYGHiHjcYr2Fj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtM7AT4anKYHtSc33SMGTKruoi2N3bByveyL7l/ocr19/hr4NGc8A7M3MLF/hI8emYqWdUSE8wheLSKN8PJIrwRFXivDAd4yMGsNu/j3LdBCXmCzvsTvjDZjzGMwmYJxszDEh0zs8cMclBUWx7bM/USy4tpWX6V+/HFOnFy07Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CaSGFPhM; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CaSGFPhM"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C34060B19
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Apr 2024 03:51:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fyrzz69br0Uw for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Apr 2024 03:51:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CF8EC60899
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CF8EC60899
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CaSGFPhM
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CF8EC60899
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Apr 2024 03:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713930715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K18eP4qkjIilGjFsvIGytTcX6bpQkpwDgR45u8Gpsbs=;
	b=CaSGFPhMHFyKFNWsiyL2s7j74gIgKNinQQ51EmyCy4pn9wIO+DoOMtW/LtWXv1nZGgor0+
	w/wb7SGYT601NTiPKKE43t+NgagGZ0kMCnV+lcrLq6v1qeEC6BQ+eAm4EsOonfTGpBFUEb
	dQI84bM2Pkx2vNW3u5+aBlpamVntFPs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-iAlSRLAsM2-z8WXn8U23Pg-1; Tue, 23 Apr 2024 23:51:52 -0400
X-MC-Unique: iAlSRLAsM2-z8WXn8U23Pg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ae8013ac66so2198523a91.3
        for <virtualization@lists.linux-foundation.org>; Tue, 23 Apr 2024 20:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713930711; x=1714535511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K18eP4qkjIilGjFsvIGytTcX6bpQkpwDgR45u8Gpsbs=;
        b=lhS30jCiOcZj1rn2XQrTQjvh05dwUZs6GirXqRker+Y7znSO1XLZjl7PMnHNVIy4KZ
         zbCKTgUNMGO5jLeykC6b4RSF5Y8j4RNT55CVV8+JfvnWdEq8SHcY5poOKWbjtvn0qWKZ
         b0MNSJJyoGLMzSdGfyvlqig3JGCEe8HxkLJOmgwBSjDYxPBcG5auonWyf2k8bwbh94QT
         YSqSGe8fA45HFzLJg7HibDy1GuQrMW/SM07HXCOV0uvegWBuTmCTYVlw8nY1eVyVbrUf
         XVN4o42/n3Nky8FOvQ8nKeoRXt/peSjh5znT6KsWETJ/ZQ85Rhl02jm9w84vi33Qut1u
         r7Bw==
X-Forwarded-Encrypted: i=1; AJvYcCU3iCB6/BnUVzkGq7Eq4RZ/eTWNaKVrzWeVXTKixEauclU3dzjVztom8NMgnOPeRlKHL+f5YsLV0td8N2Etmni9UZq8RuhlRiEoyVJJbkLpjlbvAqioSjr4lA==
X-Gm-Message-State: AOJu0YwOAk07XWNc/QKc8rnubA91rd2kiOG05+5wBJPMOZtz9G81Ru/3
	3/3MHdudxFEi3I1dIZ4QbFueUrkxdhz1VA54MG/bYp1sVcRFplsduALxbJ2MXJfGEaVrw7uZs5u
	rFTo7t4he4GJioacUcKReH2Do5mmuCRvqtxbZq/+u8wvOjm1ImxzOsZoNx1tZM1KqN6+IecC6Um
	fR9/Nxnb/0AJA9CH5Y1ab/jNM8HubLAlaatl1+XzrcuNxGMCyGmYoslA==
X-Received: by 2002:a17:90a:e7c3:b0:2af:3bce:6e4c with SMTP id kb3-20020a17090ae7c300b002af3bce6e4cmr562458pjb.16.1713930711542;
        Tue, 23 Apr 2024 20:51:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG73KOoT1LBuVxyOPo7Rg5CbwjbEBomK/zP99mw2XwaHzrikEAJp80JbdakKr2x8fDAjRlTz9pqibGjVkpov5c=
X-Received: by 2002:a17:90a:e7c3:b0:2af:3bce:6e4c with SMTP id
 kb3-20020a17090ae7c300b002af3bce6e4cmr562449pjb.16.1713930711187; Tue, 23 Apr
 2024 20:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240412133017.483407-1-lulu@redhat.com> <20240412133017.483407-4-lulu@redhat.com>
 <20240417052723-mutt-send-email-mst@kernel.org> <CACGkMEtv56TSaA=W337hFU3VALfbrGMcEdu25O4Ecx7guUacyQ@mail.gmail.com>
 <20240422160348-mutt-send-email-mst@kernel.org> <CACGkMEsj1aYBBO+kh5wmTk9vh=QRj50FHPFZ6QX3gs1Jh+XQdA@mail.gmail.com>
 <20240423043538-mutt-send-email-mst@kernel.org> <CACGkMEvbrH-ERbr-4DVpvK6+V_8Bh79YdYTdfWKhk5ziwcLDjg@mail.gmail.com>
 <CACLfguXzMEjXrC9dnO=q7cvoVAusQT930Wh8w4cHon_KTLpOtA@mail.gmail.com>
In-Reply-To: <CACLfguXzMEjXrC9dnO=q7cvoVAusQT930Wh8w4cHon_KTLpOtA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Apr 2024 11:51:39 +0800
Message-ID: <CACGkMEsfCa=awV6WebT_jm1ng4uY4afj4KLML4bHdi5=iakZYg@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for reconnection
To: Cindy Lu <lulu@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 11:15=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> On Wed, Apr 24, 2024 at 8:44=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Tue, Apr 23, 2024 at 4:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Tue, Apr 23, 2024 at 11:09:59AM +0800, Jason Wang wrote:
> > > > On Tue, Apr 23, 2024 at 4:05=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Thu, Apr 18, 2024 at 08:57:51AM +0800, Jason Wang wrote:
> > > > > > On Wed, Apr 17, 2024 at 5:29=E2=80=AFPM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > > >
> > > > > > > On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> > > > > > > > Add the function vduse_alloc_reconnnect_info_mem
> > > > > > > > and vduse_alloc_reconnnect_info_mem
> > > > > > > > These functions allow vduse to allocate and free memory for=
 reconnection
> > > > > > > > information. The amount of memory allocated is vq_num pages=
.
> > > > > > > > Each VQS will map its own page where the reconnection infor=
mation will be saved
> > > > > > > >
> > > > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > > > ---
> > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++=
++++++++++++
> > > > > > > >  1 file changed, 40 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/v=
dpa/vdpa_user/vduse_dev.c
> > > > > > > > index ef3c9681941e..2da659d5f4a8 100644
> > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > @@ -65,6 +65,7 @@ struct vduse_virtqueue {
> > > > > > > >       int irq_effective_cpu;
> > > > > > > >       struct cpumask irq_affinity;
> > > > > > > >       struct kobject kobj;
> > > > > > > > +     unsigned long vdpa_reconnect_vaddr;
> > > > > > > >  };
> > > > > > > >
> > > > > > > >  struct vduse_dev;
> > > > > > > > @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effectiv=
e_cpu(struct vduse_virtqueue *vq)
> > > > > > > >
> > > > > > > >       vq->irq_effective_cpu =3D curr_cpu;
> > > > > > > >  }
> > > > > > > > +static int vduse_alloc_reconnnect_info_mem(struct vduse_de=
v *dev)
> > > > > > > > +{
> > > > > > > > +     unsigned long vaddr =3D 0;
> > > > > > > > +     struct vduse_virtqueue *vq;
> > > > > > > > +
> > > > > > > > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > > > > > > > +             /*page 0~ vq_num save the reconnect info for =
vq*/
> > > > > > > > +             vq =3D dev->vqs[i];
> > > > > > > > +             vaddr =3D get_zeroed_page(GFP_KERNEL);
> > > > > > >
> > > > > > >
> > > > > > > I don't get why you insist on stealing kernel memory for some=
thing
> > > > > > > that is just used by userspace to store data for its own use.
> > > > > > > Userspace does not lack ways to persist data, for example,
> > > > > > > create a regular file anywhere in the filesystem.
> > > > > >
> > > > > > Good point. So the motivation here is to:
> > > > > >
> > > > > > 1) be self contained, no dependency for high speed persist data
> > > > > > storage like tmpfs
> > > > >
> > > > > No idea what this means.
> > > >
> > > > I mean a regular file may slow down the datapath performance, so
> > > > usually the application will try to use tmpfs and other which is a
> > > > dependency for implementing the reconnection.
> > >
> > > Are we worried about systems without tmpfs now?
> >
> > Yes.
> >
> > >
> > >
> > > > >
> > > > > > 2) standardize the format in uAPI which allows reconnection fro=
m
> > > > > > arbitrary userspace, unfortunately, such effort was removed in =
new
> > > > > > versions
> > > > >
> > > > > And I don't see why that has to live in the kernel tree either.
> > > >
> > > > I can't find a better place, any idea?
> > > >
> > > > Thanks
> > >
> > >
> > > Well anywhere on github really. with libvhost-user maybe?
> > > It's harmless enough in Documentation
> > > if you like but ties you to the kernel release cycle in a way that
> > > is completely unnecessary.
> >
> > Ok.
> >
> > Thanks
> >
> Sure, got it. Do we need to withdraw all the series? maybe we can keep
> the patch for support ioctl to get status and configure?

We can leave the mmap part for future, the rest is still useful unless
I miss anything.

Thanks

>
> thanks
> cindy
>
> > >
> > > > >
> > > > > > If the above doesn't make sense, we don't need to offer those p=
ages by VDUSE.
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > +             if (vaddr =3D=3D 0)
> > > > > > > > +                     return -ENOMEM;
> > > > > > > > +
> > > > > > > > +             vq->vdpa_reconnect_vaddr =3D vaddr;
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static int vduse_free_reconnnect_info_mem(struct vduse_dev=
 *dev)
> > > > > > > > +{
> > > > > > > > +     struct vduse_virtqueue *vq;
> > > > > > > > +
> > > > > > > > +     for (int i =3D 0; i < dev->vq_num; i++) {
> > > > > > > > +             vq =3D dev->vqs[i];
> > > > > > > > +
> > > > > > > > +             if (vq->vdpa_reconnect_vaddr)
> > > > > > > > +                     free_page(vq->vdpa_reconnect_vaddr);
> > > > > > > > +             vq->vdpa_reconnect_vaddr =3D 0;
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     return 0;
> > > > > > > > +}
> > > > > > > >
> > > > > > > >  static long vduse_dev_ioctl(struct file *file, unsigned in=
t cmd,
> > > > > > > >                           unsigned long arg)
> > > > > > > > @@ -1672,6 +1705,8 @@ static int vduse_destroy_dev(char *na=
me)
> > > > > > > >               mutex_unlock(&dev->lock);
> > > > > > > >               return -EBUSY;
> > > > > > > >       }
> > > > > > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > > > > > +
> > > > > > > >       dev->connected =3D true;
> > > > > > > >       mutex_unlock(&dev->lock);
> > > > > > > >
> > > > > > > > @@ -1855,12 +1890,17 @@ static int vduse_create_dev(struct =
vduse_dev_config *config,
> > > > > > > >       ret =3D vduse_dev_init_vqs(dev, config->vq_align, con=
fig->vq_num);
> > > > > > > >       if (ret)
> > > > > > > >               goto err_vqs;
> > > > > > > > +     ret =3D vduse_alloc_reconnnect_info_mem(dev);
> > > > > > > > +     if (ret < 0)
> > > > > > > > +             goto err_mem;
> > > > > > > >
> > > > > > > >       __module_get(THIS_MODULE);
> > > > > > > >
> > > > > > > >       return 0;
> > > > > > > >  err_vqs:
> > > > > > > >       device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major)=
, dev->minor));
> > > > > > > > +err_mem:
> > > > > > > > +     vduse_free_reconnnect_info_mem(dev);
> > > > > > > >  err_dev:
> > > > > > > >       idr_remove(&vduse_idr, dev->minor);
> > > > > > > >  err_idr:
> > > > > > > > --
> > > > > > > > 2.43.0
> > > > > > >
> > > > >
> > >
> >
>

