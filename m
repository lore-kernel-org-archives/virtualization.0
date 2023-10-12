Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C132CDB46E
	for <virtualization@archiver.kernel.org>; Thu, 12 Oct 2023 09:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1DFE81EAD;
	Thu, 12 Oct 2023 09:37:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E1DFE81EAD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fXh3qIjB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rnVuG7iyRYq8; Thu, 12 Oct 2023 09:37:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 73BFC81B9A;
	Thu, 12 Oct 2023 09:37:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 73BFC81B9A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FCF6C0071;
	Thu, 12 Oct 2023 09:37:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B0BBC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:37:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83557607B0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:37:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 83557607B0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fXh3qIjB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pzpl-PTrCC6d
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:37:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BEFBC600C5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:37:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BEFBC600C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697103423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Og6raZ6jMMyD5EqCW+syNcRq/tuwwhy1dUriBPTt9yk=;
 b=fXh3qIjBMeibSOOOWJ3X7uOFiCiffiG4kUUBmYclgdaywfXh43/d/5x1y8MfRMPDIKCx/1
 kRjSSWq7PEfHE017EYKgQf6+NkgIolW7wm6NSeNKq80BQM6WTN/EPelblh9uwIy+7ceSak
 cQNT2AZYDYZ0mf44jCwWTwSOuagOFik=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-QAIqD4cmOdGSqC1pT7iqmg-1; Thu, 12 Oct 2023 05:37:02 -0400
X-MC-Unique: QAIqD4cmOdGSqC1pT7iqmg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so6363735e9.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 02:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697103421; x=1697708221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Og6raZ6jMMyD5EqCW+syNcRq/tuwwhy1dUriBPTt9yk=;
 b=g76GGbHBcZYNbjI5jZITFXdAdpfusz1zT0ibWRsgK8X2nLG9iDXYgthzdjaQ8JMpOv
 tibBwklfkMCruXa4/Hzvooi7eTBqZTtTcHUUpQSMr2E0qm+GfRb17fRwt82mIZ/ta+j9
 /klrWm17jwZdwNaU73VtUaubt0MScL2GAEvt2S9qDdmvvGdu0uQaOaLCqmaF3cJYNvVR
 qd60NQfJKKoRlJcc5gzdEmBk8suxMSVQNyiLqOHYh1bcMIB+NlE7d+UvydVk9VivOwcD
 lgD/hvlDNDn1jasNDUPw8q+ZFlgeMjYTG7JUcDYWH6nxn07I9lyfhpFJP1Vt7srtF65N
 OPqQ==
X-Gm-Message-State: AOJu0YwllrzoCTMz+oGfSyBQKeviqMr9JhUV9sAuqWa/2Xc5ELwXs45h
 AWu4l7dB7zFWjFJZ4KXBE1rWmZR+cEUoV/vgyJdxjbHCKkOiwZ1XTSRv6lqLHcOstqRZyjtqyvL
 wYqpimxuHwIQ2GgVaYaxTdSB9AlID07AXPkO2CAv8Sw==
X-Received: by 2002:a05:600c:252:b0:402:f536:2d3e with SMTP id
 18-20020a05600c025200b00402f5362d3emr20099631wmj.14.1697103421203; 
 Thu, 12 Oct 2023 02:37:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9fq1jjgKP01Xp12dXEJDHMAnxRgZMq82IS2jTsardKR/fkkLRB52Ezc7m3vDYYuSCK2nZGQ==
X-Received: by 2002:a05:600c:252:b0:402:f536:2d3e with SMTP id
 18-20020a05600c025200b00402f5362d3emr20099607wmj.14.1697103420786; 
 Thu, 12 Oct 2023 02:37:00 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 az41-20020a05600c602900b004068495910csm21393884wmb.23.2023.10.12.02.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 02:36:59 -0700 (PDT)
Date: Thu, 12 Oct 2023 05:36:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 21/22] virtio_net: update tx timeout record
Message-ID: <20231012052017-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-22-xuanzhuo@linux.alibaba.com>
 <20231012050936-mutt-send-email-mst@kernel.org>
 <1697101953.6236846-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1697101953.6236846-1-xuanzhuo@linux.alibaba.com>
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

On Thu, Oct 12, 2023 at 05:12:33PM +0800, Xuan Zhuo wrote:
> On Thu, 12 Oct 2023 05:10:55 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Oct 11, 2023 at 05:27:27PM +0800, Xuan Zhuo wrote:
> > > If send queue sent some packets, we update the tx timeout
> > > record to prevent the tx timeout.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio/xsk.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> > > index 7abd46bb0e3d..e605f860edb6 100644
> > > --- a/drivers/net/virtio/xsk.c
> > > +++ b/drivers/net/virtio/xsk.c
> > > @@ -274,6 +274,16 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
> > >
> > >  	virtnet_xsk_check_queue(sq);
> > >
> > > +	if (stats.packets) {
> > > +		struct netdev_queue *txq;
> > > +		struct virtnet_info *vi;
> > > +
> > > +		vi = sq->vq->vdev->priv;
> > > +
> > > +		txq = netdev_get_tx_queue(vi->dev, sq - vi->sq);
> > > +		txq_trans_cond_update(txq);
> > > +	}
> > > +
> > >  	u64_stats_update_begin(&sq->stats.syncp);
> > >  	sq->stats.packets += stats.packets;
> > >  	sq->stats.bytes += stats.bytes;
> >
> > I don't get what this is doing. Is there some kind of race here you
> > are trying to address? And what introduced the race?
> 
> 
> Because the xsk xmit shares the send queue with the kernel xmit,
> then when I do benchmark, the xsk will always use the send queue,
> so the kernel may have no chance to do xmit, the tx watchdog
> thinks that the send queue is hang and prints tx timeout log.
> 
> So I call the txq_trans_cond_update() to tell the tx watchdog
> that the send queue is working.
> 
> Thanks.

Don't like this hack.
So packets are stuck in queue - that's not good is it?
Is ours the only driver that shares queues like this?

> 
> >
> > > --
> > > 2.32.0.3.g01195cf9f
> >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
