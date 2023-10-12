Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597C6CDB46E
	for <virtualization@archiver.kernel.org>; Thu, 12 Oct 2023 13:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B99B641B6C;
	Thu, 12 Oct 2023 13:07:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B99B641B6C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M/0cRI1K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HRD4L7Mm7CR0; Thu, 12 Oct 2023 13:07:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CC7C941D7C;
	Thu, 12 Oct 2023 13:07:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC7C941D7C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4A26C007F;
	Thu, 12 Oct 2023 13:07:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34608C0071
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 13:07:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F4E88224B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 13:07:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0F4E88224B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=M/0cRI1K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R0DsuHDnmaaX
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 13:07:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B04382211
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 13:07:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B04382211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697116050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6RsmbdmHeIJjajNpJlxE4knqBt1TJWSS+6uc9jgSnK8=;
 b=M/0cRI1KUeBMbDkg++FV6NHiSCplY9sicEY4llaDf80pP0vZjaLYpHT4dDamr6vxUghZvv
 ThjScP5W5R2oXwu0q28qBOBsd3x0k/DHp+dG0MMvNWpZgvWz9I/IQqQcdKK6ejl20FSHs/
 6gtqyaTpseIZkSSvn026wrCpRXjwuCQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-R1grxQyxPgOLbayDiNcc9A-1; Thu, 12 Oct 2023 09:07:28 -0400
X-MC-Unique: R1grxQyxPgOLbayDiNcc9A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4053a5c6a59so6413005e9.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 06:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697116047; x=1697720847;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6RsmbdmHeIJjajNpJlxE4knqBt1TJWSS+6uc9jgSnK8=;
 b=o6TO8mqOHw7ZOHDuQk/SbbH+repG+FCGBOWT9rMcdDxcyYSdCMEHSWz0YFGziN76yk
 kNkmSFRP4TnQqGwfkYy6ZxmwScZHcZjz0E6dEEw3ATY8WOqjDzdxS+Tfj0TbNKTjH+ro
 vgJitUCMtJQrEZE0uNJ+NggEUYMiXJQTNnlbVxkX75vdyCVuDL1V8wn73HsWIO99J5ps
 yvTbwGZmhVo1ISWS6tt0EqLEzeI7FubsGVQASY8TR9UKAMQKfsWOvL53gw3ggNCO5uGg
 47GFrzQTLDktdkygEMjoUwiBKDvoZbkHRTkhcfvR1Tg2JLNDyMnA+uVYVruPk4b9KtBT
 0+8w==
X-Gm-Message-State: AOJu0Yyu15SPZtFx6GUNrS3usG5gkFLjoEZ7EqYqYz6nd7BsgN5pLsM5
 vP5iLtRqKjXu9Blh/HwFvBQoXO+LgxyagBNNgO7FqGAJwkH2iUU0m1XEbUchstyqx8M+oStCVN9
 4DAvU2EPG4ht1NNVqB3K3NIcsQkmXmFHy3fLvU8EsEw==
X-Received: by 2002:a05:600c:2219:b0:405:1c19:b747 with SMTP id
 z25-20020a05600c221900b004051c19b747mr20736211wml.15.1697116047569; 
 Thu, 12 Oct 2023 06:07:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENFzPHy318ZIAZGjzjpy4+I+lUIwRej9/NXgZPJcOdLn4eVm1MWxNkCTzCBfrKN6XADTgSJQ==
X-Received: by 2002:a05:600c:2219:b0:405:1c19:b747 with SMTP id
 z25-20020a05600c221900b004051c19b747mr20736181wml.15.1697116047160; 
 Thu, 12 Oct 2023 06:07:27 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a05600c290200b004063d8b43e7sm21849039wmd.48.2023.10.12.06.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 06:07:26 -0700 (PDT)
Date: Thu, 12 Oct 2023 09:07:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 21/22] virtio_net: update tx timeout record
Message-ID: <20231012090632-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-22-xuanzhuo@linux.alibaba.com>
 <20231012050936-mutt-send-email-mst@kernel.org>
 <1697101953.6236846-1-xuanzhuo@linux.alibaba.com>
 <20231012052017-mutt-send-email-mst@kernel.org>
 <1697111642.7917345-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1697111642.7917345-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Thu, Oct 12, 2023 at 07:54:02PM +0800, Xuan Zhuo wrote:
> On Thu, 12 Oct 2023 05:36:56 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Oct 12, 2023 at 05:12:33PM +0800, Xuan Zhuo wrote:
> > > On Thu, 12 Oct 2023 05:10:55 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Wed, Oct 11, 2023 at 05:27:27PM +0800, Xuan Zhuo wrote:
> > > > > If send queue sent some packets, we update the tx timeout
> > > > > record to prevent the tx timeout.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio/xsk.c | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > >
> > > > > diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> > > > > index 7abd46bb0e3d..e605f860edb6 100644
> > > > > --- a/drivers/net/virtio/xsk.c
> > > > > +++ b/drivers/net/virtio/xsk.c
> > > > > @@ -274,6 +274,16 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
> > > > >
> > > > >  	virtnet_xsk_check_queue(sq);
> > > > >
> > > > > +	if (stats.packets) {
> > > > > +		struct netdev_queue *txq;
> > > > > +		struct virtnet_info *vi;
> > > > > +
> > > > > +		vi = sq->vq->vdev->priv;
> > > > > +
> > > > > +		txq = netdev_get_tx_queue(vi->dev, sq - vi->sq);
> > > > > +		txq_trans_cond_update(txq);
> > > > > +	}
> > > > > +
> > > > >  	u64_stats_update_begin(&sq->stats.syncp);
> > > > >  	sq->stats.packets += stats.packets;
> > > > >  	sq->stats.bytes += stats.bytes;
> > > >
> > > > I don't get what this is doing. Is there some kind of race here you
> > > > are trying to address? And what introduced the race?
> > >
> > >
> > > Because the xsk xmit shares the send queue with the kernel xmit,
> > > then when I do benchmark, the xsk will always use the send queue,
> > > so the kernel may have no chance to do xmit, the tx watchdog
> > > thinks that the send queue is hang and prints tx timeout log.
> > >
> > > So I call the txq_trans_cond_update() to tell the tx watchdog
> > > that the send queue is working.
> > >
> > > Thanks.
> >
> > Don't like this hack.
> > So packets are stuck in queue - that's not good is it?
> > Is ours the only driver that shares queues like this?
> 
> NO.
> 
> And txq_trans_cond_update() is called by many net drivers for the similar reason.
> 
> Thanks

Hmm it seems you are right. OK, sorry about the noise.

> 
> >
> > >
> > > >
> > > > > --
> > > > > 2.32.0.3.g01195cf9f
> > > >
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
