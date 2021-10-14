Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3DBC433EF
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 02:32:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA6A761105
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 02:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA6A761105
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78FA66080E;
	Thu, 14 Oct 2021 02:32:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LSYi48v5bT9p; Thu, 14 Oct 2021 02:32:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0C1B8607D7;
	Thu, 14 Oct 2021 02:32:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C63EEC000F;
	Thu, 14 Oct 2021 02:32:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEA51C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 02:32:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C2698607E3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 02:32:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QsbQSbbOZrr9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 02:32:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1532E607D7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 02:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634178770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KmFVg5ZuffecAFNIjkmXZt3j+Qt+4uHaiepr5Oi9Sik=;
 b=SYYMGaZXY8jh9oCzJrrmQm8SffQQIp317OjyHrpj4utLMX2mNQ4qo12GHv4LFi9d7e2L1R
 UhtJoZLrL6U1pTO7y2MrBExKgAbPJGoHB1/vCoZ4PhMZatWILP9r1QwnqRC5O16h6HncJR
 ErOlU+luXxzaB9wf5gl/IQb5l5MB9Ik=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-sYXvgj9WPQSNTFlBbkN_mw-1; Wed, 13 Oct 2021 22:32:46 -0400
X-MC-Unique: sYXvgj9WPQSNTFlBbkN_mw-1
Received: by mail-lf1-f69.google.com with SMTP id
 u17-20020a05651206d100b003fd714d9a38so3339557lff.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 19:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KmFVg5ZuffecAFNIjkmXZt3j+Qt+4uHaiepr5Oi9Sik=;
 b=Pr4Hoetqg38qaXEcj/srTrenG+e9nfGCIR/JWi5XWAfgzWCkSepagOb7wHFvN4DBwR
 bD6kuhrbF1GmJ+EYEjSMUlz0D3+EmLuvKoc4xdKS6PZYWAQg7QGvlDfA9EMlB5JktHJy
 ZAAHVBdh5rUrKTu8C0ketEBfzI+hOK2qRFhmlZtTl0pdR65a2TzlH60MYZGc8a6rMC7A
 9F8gJbg+zwAtVlBbfepi7tsk2t/l8Ftw1TjjNbfao7a8F3twSS5LgHMVVkWGkp1WicZq
 /6f4L2yoHwey4t3cmR09TDWFmH7RDRb852BHd0sPqiIJstvx+gnCaOGSxamZzzK0GhL5
 unMg==
X-Gm-Message-State: AOAM532YEu/5IvZ4DCxuP2eOYyBdBwZKEt1m7jHhO6C574Aa3U37ApY8
 9rJEx3T+B+hT9PEqh6kHlizTqPqLo1aA9PXribI5VMMxGk+FfT5wjjxfEYR908hoiTmJUqlc4P1
 k3i1POAJ7qpE/dTuORssHF80AyOg7L65m5JYywvoTE+zeZZp7sZnYOBns8g==
X-Received: by 2002:ac2:5e78:: with SMTP id a24mr2710407lfr.348.1634178765461; 
 Wed, 13 Oct 2021 19:32:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxC8NYVX6vWXIyoDwoDh8tCFftHbvBtZ2Xcw/ah6Y/GZ3hPJ6/10p88binEKXbKV+YxUbyy7xx7TVNeoWExRYE=
X-Received: by 2002:ac2:5e78:: with SMTP id a24mr2710381lfr.348.1634178765223; 
 Wed, 13 Oct 2021 19:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-2-jasowang@redhat.com>
 <20211013060341-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211013060341-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Oct 2021 10:32:32 +0800
Message-ID: <CACGkMEvJ76EBtx847HodDmoLDkz7QjFoJMBdgGTEeEoZ8W-9Sw@mail.gmail.com>
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

On Wed, Oct 13, 2021 at 6:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Oct 12, 2021 at 02:52:16PM +0800, Jason Wang wrote:
> > If an untrusted device neogitates BLK_F_MQ but advertises a zero
> > num_queues, the driver may end up trying to allocating zero size
> > buffers where ZERO_SIZE_PTR is returned which may pass the checking
> > against the NULL. This will lead unexpected results.
> >
> > Fixing this by using single queue if num_queues is zero.
> >
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> I'd rather fail probe so we don't need to support that.

I think we should be consistent among all virtio drivers.

E.g without this patch, we stick to 1 if virtio_create_feature() fail.
Do we need to fix that?

And we do something similar at least for the virtio-net and a lot of
other places.

        /* We need at least 2 queue's */
        if (err || max_queue_pairs < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
            max_queue_pairs > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX ||
            !virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
                max_queue_pairs = 1;

Thanks

>
> > ---
> >  drivers/block/virtio_blk.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 9b3bd083b411..9deff01a38cb 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -495,7 +495,8 @@ static int init_vq(struct virtio_blk *vblk)
> >       err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
> >                                  struct virtio_blk_config, num_queues,
> >                                  &num_vqs);
> > -     if (err)
> > +     /* We need at least one virtqueue */
> > +     if (err || !num_vqs)
> >               num_vqs = 1;
> >
> >       num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
