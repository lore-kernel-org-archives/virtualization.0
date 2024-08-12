Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1231614E2F0
	for <virtualization@lists.linux-foundation.org>; Mon, 12 Aug 2024 05:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723441649; cv=none; b=AsdVl2eijtAnQ2jB7PLIOR5ti/V5mqmdWoEMVGnHc/gghs0YVsJOenhe3B5W89BQAu4WGBF+L67TeZ3h9QD+Tvo4onCVdzDSrshodkJ5doS1F4KmXQbOKN2yo3Fy/7J0TVXNKiRgSdytmijON1iDyvag+kHm/wcQpkKORCkHi6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723441649; c=relaxed/simple;
	bh=Uw8yb612ZKPbURrgt/Fv4sgrL3dUlccka3seY1ans64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atuHV8o1JllTLpvAPM/7CyfhE/MNFwAOiwj4vbPdyE+yyATp+f0lZpd37uCF8tM4eo2CwY9ojcLZDD2OUwGwtBPPyad2KFUsR7eQlc0sX3lt5hd3xf2aS1W1C7uh535TbmzvHBOwWFwz5cnFk1oDrClevfHobiAA0u3wFC/375I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EMGHvAXB; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMGHvAXB"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0D4160779
	for <virtualization@lists.linux-foundation.org>; Mon, 12 Aug 2024 05:47:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n0qWSn4scPSg for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Aug 2024 05:47:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7E3DA6076D
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E3DA6076D
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EMGHvAXB
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7E3DA6076D
	for <virtualization@lists.linux-foundation.org>; Mon, 12 Aug 2024 05:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723441644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5CsJWNFYLKrhPjV5w6+3TXZvOdH+ndcySRvBH2M9eo=;
	b=EMGHvAXBNu7hOT9aZv7WG2auUbqOf69O0YplC4Ao8wfwNxLbDZQfT3ys7lpHpuQBO07bQQ
	lPkmPbraTAzpkyzHNiHqa1C+FyEjje24enXdIcuUTIJ+vU6VZxVWV4R5GN/l1FgYvii/yY
	an4Nt/tQSrFxxiDQEK2w63OMIhAhDKk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-C0_RhwhJOT-OT-6ZE43o3g-1; Mon, 12 Aug 2024 01:47:22 -0400
X-MC-Unique: C0_RhwhJOT-OT-6ZE43o3g-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7a12bb066aaso3203966a12.3
        for <virtualization@lists.linux-foundation.org>; Sun, 11 Aug 2024 22:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723441642; x=1724046442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5CsJWNFYLKrhPjV5w6+3TXZvOdH+ndcySRvBH2M9eo=;
        b=G+Pu3/GimjPU9kCo7RSnZMqLY8lHcOJ4Ju1aDyTU/qKoEJUdJ6NgJ3IneKDmwBHiD2
         rJJojTgcrcT7lEipFAdUqxZDYKfsYAxBFxdedI5i+N0JQtbIeKKZrzbJ/0fyX9QNUAFl
         7bx3RkoSJPWiLJLg7PgPbE49e8TQeNuZZp+CoOvHJtAcfma3vvQGUb2VJiE3qHCY2/ap
         oE+IYQtj8/7XbdyuBUJROYvqQrVdUHX5qlWjywBw55PHNldDxfFi5esriFVOvQUqeVL/
         TG1Apqe+rd/fxCKZ3tD5HCburxvAGTKU3DX20gSkg435Noooz2BI68Y76HTXetxU85yf
         O0DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpdYw214LLe/5sXsnUhnOd4Ogj2rGA0AGcfMpvh6ZbNwp/r2p4M26dJxtZuvh3J380bA5OzHRMyfEqwdeKfIrG4PSVi0qYNASzpS1RsVkedUBAWL5OZE/J7g==
X-Gm-Message-State: AOJu0YxB8gTlRItcfBYnOqYuvN3rSpC7dTdl5VJ7NITY5wMtmnhME3c+
	BM2C4lCX/KLVKRn7UK3V7PpKRHCBU2mU9NsTww/bSYPPeDuRAHS/NXht1vp8tjhrFU5PZmTA/Vf
	W1jyw+7AiR604U1+stqfnmt1vsnSAuiBZYQFAXKpKbWpGDcmdbZNEz+GdFyhGY0NMSMmdz9dtaU
	wNBLPsNNoUmQ4zKung2FGGK1VWdNos56M9n+YX21zJ6SuTGyRRD6XMig==
X-Received: by 2002:a17:90b:4a01:b0:2c8:53be:fa21 with SMTP id 98e67ed59e1d1-2d1e80512c7mr9791791a91.34.1723441641645;
        Sun, 11 Aug 2024 22:47:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcQ+XQNc52+i7y7nv+eFycOjVns25ofqhkZcSaAIAiL54PDiPb1KE6nRmNAupkKLE5WiXOivV/pbuxkhY+hnM=
X-Received: by 2002:a17:90b:4a01:b0:2c8:53be:fa21 with SMTP id
 98e67ed59e1d1-2d1e80512c7mr9791777a91.34.1723441641179; Sun, 11 Aug 2024
 22:47:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240808082044.11356-1-jasowang@redhat.com> <9da68127-23d8-48a4-b56f-a3ff54fa213c@nvidia.com>
In-Reply-To: <9da68127-23d8-48a4-b56f-a3ff54fa213c@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 12 Aug 2024 13:47:10 +0800
Message-ID: <CACGkMEshq0=djGQ0gJe=AinZ2EHSpgE6CykspxRgLS_Ok55FKw@mail.gmail.com>
Subject: Re: [RFC PATCH] vhost_vdpa: assign irq bypass producer token correctly
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: mst@redhat.com, lingshan.zhu@intel.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 2:04=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
>
>
> On 08.08.24 10:20, Jason Wang wrote:
> > We used to call irq_bypass_unregister_producer() in
> > vhost_vdpa_setup_vq_irq() which is problematic as we don't know if the
> > token pointer is still valid or not.
> >
> > Actually, we use the eventfd_ctx as the token so the life cycle of the
> > token should be bound to the VHOST_SET_VRING_CALL instead of
> > vhost_vdpa_setup_vq_irq() which could be called by set_status().
> >
> > Fixing this by setting up  irq bypass producer's token when handling
> > VHOST_SET_VRING_CALL and un-registering the producer before calling
> > vhost_vring_ioctl() to prevent a possible use after free as eventfd
> > could have been released in vhost_vring_ioctl().
> >
> > Fixes: 2cf1ba9a4d15 ("vhost_vdpa: implement IRQ offloading in vhost_vdp=
a")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Note for Dragos: Please check whether this fixes your issue. I
> > slightly test it with vp_vdpa in L2.
> > ---
> >  drivers/vhost/vdpa.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index e31ec9ebc4ce..388226a48bcc 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -209,11 +209,9 @@ static void vhost_vdpa_setup_vq_irq(struct vhost_v=
dpa *v, u16 qid)
> >       if (irq < 0)
> >               return;
> >
> > -     irq_bypass_unregister_producer(&vq->call_ctx.producer);
> >       if (!vq->call_ctx.ctx)
> >               return;
> >
> > -     vq->call_ctx.producer.token =3D vq->call_ctx.ctx;
> >       vq->call_ctx.producer.irq =3D irq;
> >       ret =3D irq_bypass_register_producer(&vq->call_ctx.producer);
> >       if (unlikely(ret))
> > @@ -709,6 +707,12 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vd=
pa *v, unsigned int cmd,
> >                       vq->last_avail_idx =3D vq_state.split.avail_index=
;
> >               }
> >               break;
> > +     case VHOST_SET_VRING_CALL:
> > +             if (vq->call_ctx.ctx) {
> > +                     vhost_vdpa_unsetup_vq_irq(v, idx);
> > +                     vq->call_ctx.producer.token =3D NULL;
> > +             }
> > +             break;
> >       }
> >
> >       r =3D vhost_vring_ioctl(&v->vdev, cmd, argp);
> > @@ -747,13 +751,14 @@ static long vhost_vdpa_vring_ioctl(struct vhost_v=
dpa *v, unsigned int cmd,
> >                       cb.callback =3D vhost_vdpa_virtqueue_cb;
> >                       cb.private =3D vq;
> >                       cb.trigger =3D vq->call_ctx.ctx;
> > +                     vq->call_ctx.producer.token =3D vq->call_ctx.ctx;
> > +                     vhost_vdpa_setup_vq_irq(v, idx);
> >               } else {
> >                       cb.callback =3D NULL;
> >                       cb.private =3D NULL;
> >                       cb.trigger =3D NULL;
> >               }
> >               ops->set_vq_cb(vdpa, idx, &cb);
> > -             vhost_vdpa_setup_vq_irq(v, idx);
> >               break;
> >
> >       case VHOST_SET_VRING_NUM:
> > @@ -1419,6 +1424,7 @@ static int vhost_vdpa_open(struct inode *inode, s=
truct file *filep)
> >       for (i =3D 0; i < nvqs; i++) {
> >               vqs[i] =3D &v->vqs[i];
> >               vqs[i]->handle_kick =3D handle_vq_kick;
> > +             vqs[i]->call_ctx.ctx =3D NULL;
> >       }
> >       vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
> >                      vhost_vdpa_process_iotlb_msg);
>
> No more crashes, but now getting a lot of:
>  vhost-vdpa-X: vq Y, irq bypass producer (token 00000000a66e28ab) registr=
ation fails, ret =3D  -16
>
> ... seems like the irq_bypass_unregister_producer() that was removed
> might still be needed somewhere?

Probably, but I didn't see this when testing vp_vdpa.

When did you meet those warnings? Is it during the boot or migration?

Thanks

>
> Thanks,
> Dragos
>
>

