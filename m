Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5B94C9F
	for <virtualization@lists.linux-foundation.org>; Mon, 12 Aug 2024 06:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445417; cv=none; b=r2KUEeuA+AAs/e6CJpc7dBNcVmpklHS7QOXNnTZtsmp309g0sEBisz7Vlo+qzDveHMqpdz0YmIHNkedCeXZI4ESd4KMdsbfc4Bz5eScbfhQsamSeyHoFMG02c0Pl/nOUd3XCclkH/GhBbKZPwkYRCObtEwPcuFywc+X5tCQwW2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445417; c=relaxed/simple;
	bh=W0eY8Xq3o3fHaz8bN7dG7yytV8UUgXdPUr5ycR0qiCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jse3dCXXCGiVnROqjUlgYoeuXeeCrvC6PDpl4z027kncEoby7Mr4Jmk7I1+XiFCfCzn6PwhdzZSo8NYy3OGpya20I0Ku7vKdjEFz9OeNSJOaPJz0VeoCZYBtxbE+6JTk+WgEzI31vAWZ0ugMjt7869zOuy37k+6s/QtoyZhFI0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EULJzA+1; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EULJzA+1"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1FB14047D
	for <virtualization@lists.linux-foundation.org>; Mon, 12 Aug 2024 06:50:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IKPre1x8tTql for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Aug 2024 06:50:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C2F74403F7
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C2F74403F7
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EULJzA+1
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C2F74403F7
	for <virtualization@lists.linux-foundation.org>; Mon, 12 Aug 2024 06:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723445412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gD7Wwk8kOu+4mm0l1d/x7a1qMGGKB1sRxp0z9/NXgwQ=;
	b=EULJzA+1iL59PK70cBnkU4uQe3dWtBgf+/9wnTGwu76KrjmfeeOdkFvF63XrC+Oa1IWxHd
	X/3P7tC2NWNJ4xNvSsxl5xcBZ6Sno1fX6xCojyqh/Jay+ivD/db8K1RZmcCAp4FvBGd9BI
	Jt+gUM5LwyfV9Y3PJ8z/xcU9Ic6G0jI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-ygxQHqvZPv2tZNe51CBK_A-1; Mon, 12 Aug 2024 02:50:09 -0400
X-MC-Unique: ygxQHqvZPv2tZNe51CBK_A-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cfe9270d4aso5535846a91.0
        for <virtualization@lists.linux-foundation.org>; Sun, 11 Aug 2024 23:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723445408; x=1724050208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gD7Wwk8kOu+4mm0l1d/x7a1qMGGKB1sRxp0z9/NXgwQ=;
        b=GO1g4ikRa5lp3l7m9MjUSqTP5GhFC1rOfMoJA73IDMF+uclV5l90HV56PPL3uAzhUz
         51WLH+6KL0ub+VXjJ3jCTrlplXMXK9wkmns/yr5L2gAluncve6x8WLMOdgXRllfxeGE3
         tS+12LNZX89dd1ZSNofwktjVpVoPEHItJ3mqC8bQ6Tp8hOEOUpI+jmD6wGs3kra0DRym
         bSqqHIVf+cthugDc2hyuRMOxip2Y9nQiE/lqLBTX4L6G3SE7+86wsEu9rnjq9Vm8bnoP
         dtMsPijWE1+9rEp8RY9TefBEp69JSJPITsB6BdUB9MHQEHNKgyH2Ot8EBT9UWJOJVmZc
         CDdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXya6F7WLNCCMU4Hb0/Pwzg0cpnhefc2was5+oBLB7Ag9P8dL7/qwJae5E/sYfRu0Y/XBJx18Y4Ryrqf2MwCmAmDy0ul+D+akaGqireyvShEblOJo16Fat2sw==
X-Gm-Message-State: AOJu0YyDdjhGGvFbbtSE/IGAPZmsdrnIsvNHsoZLyMTs53U8oNq4raaK
	sCmrsnYW+SE8I/18xmltXkmD1WdoHh1eZTFthmwaSI8u9knlYqpO5G4a/H18JVAn4YCmXgOl8aW
	5FArUoH7s+4pijfU3kynsPQ+g8GuJeNMBWVxpy4tfCNfktsSztXyKuLmh/8p2K1szL4ZQrVkNdr
	Tq5rDmttAp7QcT0ifJNSj4Wa+WEOnRc2xbq6bY78gDQANO2J41id1gkQ==
X-Received: by 2002:a17:90b:207:b0:2c8:6308:ad78 with SMTP id 98e67ed59e1d1-2d1e80535d9mr10033993a91.34.1723445408336;
        Sun, 11 Aug 2024 23:50:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLGdwLYNX0VkuJKSx7I3Z1IUqAOr4ykW1cwWLQquNN9Af/9UdiPhu4hOno89xx+1HV9TCUE70bE5DOF3ax+PY=
X-Received: by 2002:a17:90b:207:b0:2c8:6308:ad78 with SMTP id
 98e67ed59e1d1-2d1e80535d9mr10033967a91.34.1723445407662; Sun, 11 Aug 2024
 23:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240808082044.11356-1-jasowang@redhat.com> <9da68127-23d8-48a4-b56f-a3ff54fa213c@nvidia.com>
 <CACGkMEshq0=djGQ0gJe=AinZ2EHSpgE6CykspxRgLS_Ok55FKw@mail.gmail.com>
In-Reply-To: <CACGkMEshq0=djGQ0gJe=AinZ2EHSpgE6CykspxRgLS_Ok55FKw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 12 Aug 2024 14:49:56 +0800
Message-ID: <CACGkMEvAVM+KLpq7=+m8q1Wajs_FSSfftRGE+HN16OrFhqX=ow@mail.gmail.com>
Subject: Re: [RFC PATCH] vhost_vdpa: assign irq bypass producer token correctly
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: mst@redhat.com, lingshan.zhu@intel.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 1:47=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Aug 9, 2024 at 2:04=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
> >
> >
> >
> > On 08.08.24 10:20, Jason Wang wrote:
> > > We used to call irq_bypass_unregister_producer() in
> > > vhost_vdpa_setup_vq_irq() which is problematic as we don't know if th=
e
> > > token pointer is still valid or not.
> > >
> > > Actually, we use the eventfd_ctx as the token so the life cycle of th=
e
> > > token should be bound to the VHOST_SET_VRING_CALL instead of
> > > vhost_vdpa_setup_vq_irq() which could be called by set_status().
> > >
> > > Fixing this by setting up  irq bypass producer's token when handling
> > > VHOST_SET_VRING_CALL and un-registering the producer before calling
> > > vhost_vring_ioctl() to prevent a possible use after free as eventfd
> > > could have been released in vhost_vring_ioctl().
> > >
> > > Fixes: 2cf1ba9a4d15 ("vhost_vdpa: implement IRQ offloading in vhost_v=
dpa")
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > Note for Dragos: Please check whether this fixes your issue. I
> > > slightly test it with vp_vdpa in L2.
> > > ---
> > >  drivers/vhost/vdpa.c | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index e31ec9ebc4ce..388226a48bcc 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -209,11 +209,9 @@ static void vhost_vdpa_setup_vq_irq(struct vhost=
_vdpa *v, u16 qid)
> > >       if (irq < 0)
> > >               return;
> > >
> > > -     irq_bypass_unregister_producer(&vq->call_ctx.producer);
> > >       if (!vq->call_ctx.ctx)
> > >               return;
> > >
> > > -     vq->call_ctx.producer.token =3D vq->call_ctx.ctx;
> > >       vq->call_ctx.producer.irq =3D irq;
> > >       ret =3D irq_bypass_register_producer(&vq->call_ctx.producer);
> > >       if (unlikely(ret))
> > > @@ -709,6 +707,12 @@ static long vhost_vdpa_vring_ioctl(struct vhost_=
vdpa *v, unsigned int cmd,
> > >                       vq->last_avail_idx =3D vq_state.split.avail_ind=
ex;
> > >               }
> > >               break;
> > > +     case VHOST_SET_VRING_CALL:
> > > +             if (vq->call_ctx.ctx) {
> > > +                     vhost_vdpa_unsetup_vq_irq(v, idx);
> > > +                     vq->call_ctx.producer.token =3D NULL;
> > > +             }
> > > +             break;
> > >       }
> > >
> > >       r =3D vhost_vring_ioctl(&v->vdev, cmd, argp);
> > > @@ -747,13 +751,14 @@ static long vhost_vdpa_vring_ioctl(struct vhost=
_vdpa *v, unsigned int cmd,
> > >                       cb.callback =3D vhost_vdpa_virtqueue_cb;
> > >                       cb.private =3D vq;
> > >                       cb.trigger =3D vq->call_ctx.ctx;
> > > +                     vq->call_ctx.producer.token =3D vq->call_ctx.ct=
x;
> > > +                     vhost_vdpa_setup_vq_irq(v, idx);
> > >               } else {
> > >                       cb.callback =3D NULL;
> > >                       cb.private =3D NULL;
> > >                       cb.trigger =3D NULL;
> > >               }
> > >               ops->set_vq_cb(vdpa, idx, &cb);
> > > -             vhost_vdpa_setup_vq_irq(v, idx);
> > >               break;
> > >
> > >       case VHOST_SET_VRING_NUM:
> > > @@ -1419,6 +1424,7 @@ static int vhost_vdpa_open(struct inode *inode,=
 struct file *filep)
> > >       for (i =3D 0; i < nvqs; i++) {
> > >               vqs[i] =3D &v->vqs[i];
> > >               vqs[i]->handle_kick =3D handle_vq_kick;
> > > +             vqs[i]->call_ctx.ctx =3D NULL;
> > >       }
> > >       vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
> > >                      vhost_vdpa_process_iotlb_msg);
> >
> > No more crashes, but now getting a lot of:
> >  vhost-vdpa-X: vq Y, irq bypass producer (token 00000000a66e28ab) regis=
tration fails, ret =3D  -16
> >
> > ... seems like the irq_bypass_unregister_producer() that was removed
> > might still be needed somewhere?
>
> Probably, but I didn't see this when testing vp_vdpa.
>
> When did you meet those warnings? Is it during the boot or migration?

Btw, it would be helpful to check if mlx5_get_vq_irq() works
correctly. I believe it should return an error if the virtqueue
interrupt is not allocated. After a glance at the code, it seems not
straightforward to me.

Thanks

>
> Thanks
>
> >
> > Thanks,
> > Dragos
> >
> >

