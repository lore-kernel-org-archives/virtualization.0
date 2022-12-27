Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE41C46467
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 07:21:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D7C5240530;
	Tue, 27 Dec 2022 07:21:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D7C5240530
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NnLBodXP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qfh-I9GvJPjK; Tue, 27 Dec 2022 07:21:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 524EF403A7;
	Tue, 27 Dec 2022 07:21:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 524EF403A7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34552C0035;
	Tue, 27 Dec 2022 07:21:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2DCAC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:21:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A221403C2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:21:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7A221403C2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dGOr_35ZvqAy
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:21:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B19D8403A7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B19D8403A7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672125696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mEGiwEleRJj+ufJewl6x7iIcOZ+c/dqTegBY8jJTLFw=;
 b=NnLBodXPyk8gYJnvFHijXSowwPqqqLtUSOS82avVLwWrPEV9/N0Idwk5jwPcoFa1dsn4cN
 Yk+tXvJe9bDPIqjXpR2r3x2F3wlev/y5K7K0K5+gYyyE7oVKU/YvtMUuSDPSTdtstclsYq
 PdVXGEJ9RUgh8GUpWSAlsvPXszaGEl8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-115-rmmbaqp8OeqZWWmR1h7j1A-1; Tue, 27 Dec 2022 02:21:35 -0500
X-MC-Unique: rmmbaqp8OeqZWWmR1h7j1A-1
Received: by mail-wm1-f70.google.com with SMTP id
 v6-20020a1cf706000000b003d97b54caa1so1279636wmh.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:21:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEGiwEleRJj+ufJewl6x7iIcOZ+c/dqTegBY8jJTLFw=;
 b=dACkveAVr22upEWuciZ0ukZ6hfu4kohvApsts9R5eRGvvfDz6TQowwuthEVb5fbRyw
 AtIhp7jJ58wjAqSlJ0PTNj23Pm+UKY6ZXIAu1XWyC4r6trJGNyYnkszNgPgtQoh57PHH
 U4zT+qkHQ474d55smcm0NnEGP+COQHeBMgxrK89zy/oDvJtjmRaIRvvOGBeQWA8LIywX
 4jyK820/xXhozdaH+pMmvbkAFe2t7+Cg53U9yvH0ZvS+m+VSWhm7AkjWghGqlEQvlNOn
 Id1hvleqOkP+03gs71Pd/6/Xnp44BJzFn1eKuar+uy3K6xcaLjxdAw8JqOpoqhlcfQRG
 YaQQ==
X-Gm-Message-State: AFqh2kpMf5HQiGRUkUU3MjIyNH6dxwnOq7f5UQ/IgIIXXOTX1/7oTsHA
 xkFVIFacnzdfokuMz4aXbKt3Kgz51R4gyil2Kxr84mKAVSQLV4EmrseMBm4XJWW6hQxWYJs84p/
 RlYZMtQh4yXCf/PX8MPGqTfiAgw8ieaRvk9aE8K2kyg==
X-Received: by 2002:adf:f590:0:b0:242:5cf0:2039 with SMTP id
 f16-20020adff590000000b002425cf02039mr12492842wro.65.1672125694464; 
 Mon, 26 Dec 2022 23:21:34 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuzh/P3fMBgyffaJ+4YZm0UK7XcBjHgCs292arRQNyOfui9FBsi2J7c84AHLr0LcmbmmOOkNQ==
X-Received: by 2002:adf:f590:0:b0:242:5cf0:2039 with SMTP id
 f16-20020adff590000000b002425cf02039mr12492831wro.65.1672125694253; 
 Mon, 26 Dec 2022 23:21:34 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 t15-20020a5d534f000000b002365254ea42sm12143624wrv.1.2022.12.26.23.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Dec 2022 23:21:33 -0800 (PST)
Date: Tue, 27 Dec 2022 02:21:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/4] virtio_ring: switch to use BAD_RING()
Message-ID: <20221227022023-mutt-send-email-mst@kernel.org>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-3-jasowang@redhat.com>
 <20221226183604-mutt-send-email-mst@kernel.org>
 <CACGkMEuv9+o4anxnE8xewEaFj5Sc+bn4OFDrHYR6jyxb+3ApGw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuv9+o4anxnE8xewEaFj5Sc+bn4OFDrHYR6jyxb+3ApGw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Dec 27, 2022 at 11:51:02AM +0800, Jason Wang wrote:
> On Tue, Dec 27, 2022 at 7:36 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Dec 26, 2022 at 03:49:06PM +0800, Jason Wang wrote:
> > > Switch to reuse BAD_RING() to allow common logic to be implemented in
> > > BAD_RING().
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > Changes since V1:
> > > - switch to use BAD_RING in virtio_break_device()
> > > ---
> > >  drivers/virtio/virtio_ring.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 2e7689bb933b..5cfb2fa8abee 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -58,7 +58,8 @@
> > >       do {                                                    \
> > >               dev_err(&_vq->vq.vdev->dev,                     \
> > >                       "%s:"fmt, (_vq)->vq.name, ##args);      \
> > > -             (_vq)->broken = true;                           \
> > > +             /* Pairs with READ_ONCE() in virtqueue_is_broken(). */ \
> >
> > I don't think WRITE_ONCE/READ_ONCE pair as such. Can you point
> > me at documentation of such pairing?
> 
> Introduced by:
> 
> commit 60f0779862e4ab943810187752c462e85f5fa371
> Author: Parav Pandit <parav@nvidia.com>
> Date:   Wed Jul 21 17:26:45 2021 +0300
> 
>     virtio: Improve vq->broken access to avoid any compiler optimization
> 
> I think it might still apply here since virtqueue_is_broken() is still
> put into a loop inside wait_event().
> 
> Thanks

Oh I see. Maybe it's a response to some discussion we had at the time,
at this point I can no longer say what it meant.
But you are doing right not changing it here of course.

> >
> > > +             WRITE_ONCE((_vq)->broken, true);                       \
> > >       } while (0)
> > >  #define START_USE(vq)
> > >  #define END_USE(vq)
> > > @@ -2237,7 +2238,7 @@ bool virtqueue_notify(struct virtqueue *_vq)
> > >
> > >       /* Prod other side to tell it about changes. */
> > >       if (!vq->notify(_vq)) {
> > > -             vq->broken = true;
> > > +             BAD_RING(vq, "vq %d is broken\n", vq->vq.index);
> > >               return false;
> > >       }
> > >       return true;
> > > @@ -2786,8 +2787,7 @@ void virtio_break_device(struct virtio_device *dev)
> > >       list_for_each_entry(_vq, &dev->vqs, list) {
> > >               struct vring_virtqueue *vq = to_vvq(_vq);
> > >
> > > -             /* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> > > -             WRITE_ONCE(vq->broken, true);
> > > +             BAD_RING(vq, "Device break vq %d", _vq->index);
> > >       }
> > >       spin_unlock(&dev->vqs_list_lock);
> > >  }
> > > --
> > > 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
