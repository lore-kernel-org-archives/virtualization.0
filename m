Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EEEC4332F
	for <virtualization@archiver.kernel.org>; Tue, 13 Dec 2022 15:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24A6160B6E;
	Tue, 13 Dec 2022 15:16:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 24A6160B6E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PxRWVPuU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LW9Q5qpfqviz; Tue, 13 Dec 2022 15:16:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8412060C05;
	Tue, 13 Dec 2022 15:16:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8412060C05
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55FD1C0032;
	Tue, 13 Dec 2022 15:16:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2C07C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 15:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A2E041727
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 15:16:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A2E041727
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PxRWVPuU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f0_ew5pfp42a
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 15:16:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F31DD4035E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F31DD4035E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 15:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670944561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lbIEUOJRndagsIzbonwHHIU2DwYDRVtl3eIrtsPjZPY=;
 b=PxRWVPuUMIpx60aKUS1iwMVLA/93RoWAEGICu1RITc5UQSio5jPcJ0tN5N4VibZEq0cNqM
 BRa3ZZRNRbJS+CluzkCJLa7oispuexGo4QeG6Sj7seJyOES3DscaLnPyqgPqitk3rLPnQ9
 tUUXTir12H9qYCU7r65KV9a4HaeGmfc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-201-txe8JOWTOUW3DF7D3WByAQ-1; Tue, 13 Dec 2022 10:15:58 -0500
X-MC-Unique: txe8JOWTOUW3DF7D3WByAQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 i25-20020adfaad9000000b002426945fa63so2949675wrc.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 07:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lbIEUOJRndagsIzbonwHHIU2DwYDRVtl3eIrtsPjZPY=;
 b=mr0pj4c7Csr2G6bVPH4oo2C6cboFcqUL69idxGHXbZEAYV4VPnrSeK2mVztzWrpRsY
 B+9nkVGowVSqcxxVJkaEN9fmsDXKWgxX8mk7K4WQflbAkazKxGTuh8to8lRK0cglWcio
 tdopua2d+t4mvTJSEapBIP93xC1+ocCc9IMtoFGZ8QhkA6MQqMSPIROQINYFB4lz9CC4
 7UA9StYn8HM+bsI6uhE3PZlRBLzCbMqFEEu+YymvYZVj61V3z76wSDVu9pUj7ob+ieDq
 fwHa+yIc8VbMdGtlLCbscnSs7lcWKnwUBNptr0cAccbQfZT9OwX2XB2W6O0zdBaPqk39
 K0Dw==
X-Gm-Message-State: ANoB5pkLTcA0AXQtImV7b7blaUt6b3aEr9vPU7YqhNSLKo00mR3oWq8y
 Em02S6sc2U96Shg7I8HKMJfMAx0h132lmEdH58/ukSFTQigMgxSOwZ2qT6E0KtsBk4j9FsVNNd7
 8tpWr9/z4h1HAF839cJk1ys/lnn+BU89bAyQuSO4eVg==
X-Received: by 2002:a05:600c:3483:b0:3cf:67ad:6284 with SMTP id
 a3-20020a05600c348300b003cf67ad6284mr15434363wmq.4.1670944556658; 
 Tue, 13 Dec 2022 07:15:56 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5/4uv+DoAXL906JZYpQZXcgVQ0peFwD4X+zA8ZABwsdTnKHC0INZm4AdCdMnQv41hdJWFMMQ==
X-Received: by 2002:a05:600c:3483:b0:3cf:67ad:6284 with SMTP id
 a3-20020a05600c348300b003cf67ad6284mr15434352wmq.4.1670944556447; 
 Tue, 13 Dec 2022 07:15:56 -0800 (PST)
Received: from redhat.com ([2.52.138.183]) by smtp.gmail.com with ESMTPSA id
 ay13-20020a05600c1e0d00b003c6bd91caa5sm13651091wmb.17.2022.12.13.07.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Dec 2022 07:15:55 -0800 (PST)
Date: Tue, 13 Dec 2022 10:15:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: correctly enable callback during
 start_xmit
Message-ID: <20221213100901-mutt-send-email-mst@kernel.org>
References: <20221212091029.54390-1-jasowang@redhat.com>
 <20221212042144-mutt-send-email-mst@kernel.org>
 <1670902391.9610498-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEu=1CcoNvvV9M+QrG5sLUBoPYkZ3DvUe+pLc1fSvgLuHA@mail.gmail.com>
 <20221213013231-mutt-send-email-mst@kernel.org>
 <CACGkMEukRrOWghcBXiqPrOtNbdjdDJUW7-cg9PsdtsVs1SuCyQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEukRrOWghcBXiqPrOtNbdjdDJUW7-cg9PsdtsVs1SuCyQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Tue, Dec 13, 2022 at 02:57:54PM +0800, Jason Wang wrote:
> On Tue, Dec 13, 2022 at 2:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Dec 13, 2022 at 11:43:36AM +0800, Jason Wang wrote:
> > > On Tue, Dec 13, 2022 at 11:38 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > >
> > > > On Mon, 12 Dec 2022 04:25:22 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > On Mon, Dec 12, 2022 at 05:10:29PM +0800, Jason Wang wrote:
> > > > > > Commit a7766ef18b33("virtio_net: disable cb aggressively") enables
> > > > > > virtqueue callback via the following statement:
> > > > > >
> > > > > >         do {
> > > > > >            ......
> > > > > >     } while (use_napi && kick &&
> > > > > >                unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > > > > >
> > > > > > This will cause a missing call to virtqueue_enable_cb_delayed() when
> > > > > > kick is false. Fixing this by removing the checking of the kick from
> > > > > > the condition to make sure callback is enabled correctly.
> > > > > >
> > > > > > Fixes: a7766ef18b33 ("virtio_net: disable cb aggressively")
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > ---
> > > > > > The patch is needed for -stable.
> > > > >
> > > > > stable rules don't allow for theoretical fixes. Was a problem observed?
> > >
> > > Yes, running a pktgen sample script can lead to a tx timeout.
> >
> > Since April 2021 and we only noticed now? Are you sure it's the
> > right Fixes tag?
> 
> Well, reverting a7766ef18b33 makes pktgen work again.
> 
> The reason we doesn't notice is probably because:
> 
> 1) We don't support BQL, so no bulk dequeuing (skb list) in normal traffic
> 2) When burst is enabled for pktgen, it can do bulk xmit via skb list by its own
> 
> >
> > > > >
> > > > > > ---
> > > > > >  drivers/net/virtio_net.c | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index 86e52454b5b5..44d7daf0267b 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -1834,8 +1834,8 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> > > > > >
> > > > > >             free_old_xmit_skbs(sq, false);
> > > > > >
> > > > > > -   } while (use_napi && kick &&
> > > > > > -          unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > > > > > +   } while (use_napi &&
> > > > > > +            unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > > > > >
> > > > >
> > > > > A bit more explanation pls.  kick simply means !netdev_xmit_more -
> > > > > if it's false we know there will be another packet, then transmissing
> > > > > that packet will invoke virtqueue_enable_cb_delayed. No?
> > > >
> > > > It's just that there may be a next packet, but in fact there may not be.
> > > > For example, the vq is full, and the driver stops the queue.
> > >
> > > Exactly, when the queue is about to be full we disable tx and wait for
> > > the next tx interrupt to re-enable tx.
> > >
> > > Thanks
> >
> > OK, it's a good idea to document that.
> 
> Will do.
> 
> > And we should enable callbacks at that point, not here on data path.
> 
> I'm not sure I understand here. Are you suggesting removing the
> !user_napi check here?
> 
>                 if (!use_napi &&
>                     unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
>                         /* More just got used, free them then recheck. */
>                         free_old_xmit_skbs(sq, false);
>                         if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
>                                 netif_start_subqueue(dev, qnum);
>                                 virtqueue_disable_cb(sq->vq);
>                         }
>                 }


At least, I suggest calling virtqueue_enable_cb_delayed around
this area of code. I have not really thought all this path through
and how all the corner cases interact.



> Btw, it doesn't differ too much as kick is always true without pktgen
> and that may even need more comments or make the code even harder to
> read. We need a patch for -stable at least so I prefer to let this
> patch go first and do optimization on top.
> 
> Thanks

There's a chance of perf regression here too.  Let's write the full
patch first of all. If you want to make it a 2 patch series that is fine
but it is here since 2021 I don't see why we should rush a fix. Worry
about backporting later.

> >
> >
> > > >
> > > > Thanks.
> > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > >     /* timestamp packet in software */
> > > > > >     skb_tx_timestamp(skb);
> > > > > > --
> > > > > > 2.25.1
> > > > >
> > > > > _______________________________________________
> > > > > Virtualization mailing list
> > > > > Virtualization@lists.linux-foundation.org
> > > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
