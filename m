Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99337C433EF
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 06:23:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B85B61156
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 06:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B85B61156
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E7AC60AD6;
	Thu, 14 Oct 2021 06:23:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0z1vnXThAU_p; Thu, 14 Oct 2021 06:23:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BD42A60A35;
	Thu, 14 Oct 2021 06:23:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93A00C0011;
	Thu, 14 Oct 2021 06:23:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9545EC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 06:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8530F4026F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 06:23:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ov22aJn8tTrE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 06:23:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D0E324025D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 06:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634192623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UV+KyYBQ2ewOSIHkPZsoUzWC0RAsR1CC6z1Zb8ZXfds=;
 b=eCPqGUSDV+lAJnpYAWiakgmnNoSc6b0GM09Z3hNJ2nBvTTZaheptRwvianBpAkoqwZA6bz
 yRVBJt4ubIWjouAPNE+YQpH39npurXDKUvEokVHkZBICBpTGSiHLHaEzF5e4kBp7f+JW2X
 9M1oxq6NiFbP8mYEgKrTxZfzjW+Zz0U=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-zc88oQtxOMSe4VOJfIAhfg-1; Thu, 14 Oct 2021 02:23:42 -0400
X-MC-Unique: zc88oQtxOMSe4VOJfIAhfg-1
Received: by mail-lf1-f72.google.com with SMTP id
 u17-20020a05651206d100b003fd714d9a38so3648452lff.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 23:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UV+KyYBQ2ewOSIHkPZsoUzWC0RAsR1CC6z1Zb8ZXfds=;
 b=Gu3Q4N+5KyLYj67N0VE7d+Ucn9W6UHPU4km6Q1Uw9GFKOyf81rLqtpOJxx3YCGCHe5
 DndL4F17hD8Nl7LKWrCtdQ2aMFBwtaaOI21/zR7Z1lUIlfW7ihlGc3sO/hIwt6x1pjpJ
 Jpc/EISpZU24mjAgkfwdFG3mnrGLHMidc/fU7cndHHk3ZSfhvmR5Tw/da9tm4QPRi28L
 u562uM/t2E2NMin9TIfyOc/57IumObQvopnjXZQiOqebWEbAgxgRceRE3fhuQ3oY+GcB
 c1EjLwnsqnuizHoASEbpEoZa+eZZrNM92D/7ltRRbCjnAxQeiq5vG/Hx2wAtHHAFmeyl
 kCgg==
X-Gm-Message-State: AOAM5328AcvSHwDWHTtAmvYQmlySfzn9LpuufH9Io1DGm4bUaqYayV1j
 qfeQ4+bIZercuMNHzURQ/QbX1rOvBIRh6Ou2kSEtMLCQJadB6G5wp1l0mw/8h1ao8Et+ulJ+Lsj
 YMyA4jxC1zVXzX1ZWxQGXNlEkCQVT8kX4Y+quNdlbAEVoNJi7qG24fPTsVQ==
X-Received: by 2002:ac2:494d:: with SMTP id o13mr3402130lfi.580.1634192621120; 
 Wed, 13 Oct 2021 23:23:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWIM3Iv66lzJKw/G3DWaRsoMAi8OdERHh0dsbal3MyO64tkpkHleB2uRCvFcE4uX5ZjTm4FBPDbinC59dDFlw=
X-Received: by 2002:ac2:494d:: with SMTP id o13mr3402108lfi.580.1634192620889; 
 Wed, 13 Oct 2021 23:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-2-jasowang@redhat.com>
 <20211013060341-mutt-send-email-mst@kernel.org>
 <CACGkMEvJ76EBtx847HodDmoLDkz7QjFoJMBdgGTEeEoZ8W-9Sw@mail.gmail.com>
 <20211014014210-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211014014210-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Oct 2021 14:23:29 +0800
Message-ID: <CACGkMEspr-TXYb4ZuC6Dm1-nJcN5D69vFdFzjPvxZv9hupVo5g@mail.gmail.com>
Subject: Re: [PATCH V2 01/12] virtio-blk: validate num_queues during probe
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kaplan, david" <david.kaplan@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

On Thu, Oct 14, 2021 at 1:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Oct 14, 2021 at 10:32:32AM +0800, Jason Wang wrote:
> > On Wed, Oct 13, 2021 at 6:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Oct 12, 2021 at 02:52:16PM +0800, Jason Wang wrote:
> > > > If an untrusted device neogitates BLK_F_MQ but advertises a zero
> > > > num_queues, the driver may end up trying to allocating zero size
> > > > buffers where ZERO_SIZE_PTR is returned which may pass the checking
> > > > against the NULL. This will lead unexpected results.
> > > >
> > > > Fixing this by using single queue if num_queues is zero.
> > > >
> > > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > > I'd rather fail probe so we don't need to support that.
> >
> > I think we should be consistent among all virtio drivers.
>
> Well we started being permissive. We can't change that
> since that might break on some hosts. But given focus on
> security being restrictive sounds better now.

Right.

>
> > E.g without this patch, we stick to 1 if virtio_create_feature() fail.
> > Do we need to fix that?
>
> We can't easily, some hosts might be broken.

Ok.

Thanks

>
> > And we do something similar at least for the virtio-net and a lot of
> > other places.
> >
> >         /* We need at least 2 queue's */
> >         if (err || max_queue_pairs < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
> >             max_queue_pairs > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX ||
> >             !virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
> >                 max_queue_pairs = 1;
> >
> > Thanks
> >
> > >
> > > > ---
> > > >  drivers/block/virtio_blk.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > index 9b3bd083b411..9deff01a38cb 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -495,7 +495,8 @@ static int init_vq(struct virtio_blk *vblk)
> > > >       err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
> > > >                                  struct virtio_blk_config, num_queues,
> > > >                                  &num_vqs);
> > > > -     if (err)
> > > > +     /* We need at least one virtqueue */
> > > > +     if (err || !num_vqs)
> > > >               num_vqs = 1;
> > > >
> > > >       num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
> > > > --
> > > > 2.25.1
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
