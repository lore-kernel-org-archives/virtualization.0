Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CDCC77B72
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 09:20:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4478610C1;
	Mon, 17 Apr 2023 09:20:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D4478610C1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LwByioBy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3_gOhac2DJnN; Mon, 17 Apr 2023 09:20:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 41BF4610B6;
	Mon, 17 Apr 2023 09:20:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 41BF4610B6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00E0EC0036;
	Mon, 17 Apr 2023 09:20:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73740C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 09:20:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 41B4341C51
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 09:20:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 41B4341C51
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LwByioBy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IA-NLmQGf1Md
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 09:20:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 46A33400CF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 46A33400CF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 09:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681723218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vNVnMNLujGbpw5r7sYnlsLlVBFalrrcN8dNsOuZXTw0=;
 b=LwByioByOi++2PVxK35EKwZsP2CyQHTVsINo1/rGwFRF8SkvRewsO9crbk28pIcjOhiGME
 6LjN3qC6oGuEqTpBDbF0upxynjS+lXIZPcmO4sj69UFhX8MJDD+S7gVUq6LCpPw/rVw09P
 uhb6i4bVwlZ9yw26x5iZgt0xf6yeqnU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488--wnELPitPGCY-TitIOZTiQ-1; Mon, 17 Apr 2023 05:20:16 -0400
X-MC-Unique: -wnELPitPGCY-TitIOZTiQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 h20-20020a05622a171400b003dfd61e8594so17549779qtk.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 02:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681723216; x=1684315216;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vNVnMNLujGbpw5r7sYnlsLlVBFalrrcN8dNsOuZXTw0=;
 b=PO6w4ZeQ3KKNTrJ1iaAWml4DAkur3PtFbdyRp02SEjyS1Ruix/Z+T0e533em/qPohq
 LYDhxjnHJ0LPvxhO/Yz5AHZ15ZLeOU6hnk+8kM/HSRqVehxQSeiocKjI9oi2gywQo5OS
 tl7wcyc9sqRhZ4rOoLAe27ZhDlX9PU7S/Bj8CkN31sqFKddY25iJQblKmHdXDoiNCXtL
 GnztSMriT+zeZbd7Dm+6hhZbaR9SND2GdXbgbFjcbY/xRS6hwzH+CqH/SAzIIuR9drvn
 Ho96US3ICX0U67GGI1XeIoMYuCPcLISS2rZdY3V53elRFrtFrtwyAcnjnJY9CpUwZ+YU
 wS5w==
X-Gm-Message-State: AAQBX9fcEyRrpqyVor7/7TvnPli4EC00eLZk0ztAD8rMnPqT5KLrcXqp
 4y6cTh8kA1nJFvoJKCXfceNMZtAEMF1YieW2Tl5stNgBG9VteVcyYtbxscYqRW3KmnamdKoaURm
 0am5/qYK5Lonizl3CgVTJRoEqnqr7v6wOYr6IocHs3A==
X-Received: by 2002:a05:622a:550:b0:3e6:35d9:2c14 with SMTP id
 m16-20020a05622a055000b003e635d92c14mr25324983qtx.19.1681723216014; 
 Mon, 17 Apr 2023 02:20:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350b2JvceDDe59kay7fdrE1cUYDltBYRWJcjOLEX8d+sK0DHfxcKJlAzVlK4Jy62gtSq9j6RpqQ==
X-Received: by 2002:a05:622a:550:b0:3e6:35d9:2c14 with SMTP id
 m16-20020a05622a055000b003e635d92c14mr25324970qtx.19.1681723215756; 
 Mon, 17 Apr 2023 02:20:15 -0700 (PDT)
Received: from redhat.com ([185.199.103.251]) by smtp.gmail.com with ESMTPSA id
 bp11-20020a05620a458b00b0074cf9d16cb0sm1481988qkb.14.2023.04.17.02.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Apr 2023 02:20:15 -0700 (PDT)
Date: Mon, 17 Apr 2023 05:20:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230417051816-mutt-send-email-mst@kernel.org>
References: <20230416074607.292616-1-alvaro.karsz@solid-run.com>
 <AM0PR04MB4723C6E99A217F51973710F5D49F9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230416164453-mutt-send-email-mst@kernel.org>
 <CACGkMEvFhVyWb5+ET_akPvnjUq04+ZbJC8o_GtNBWqSMGNum8A@mail.gmail.com>
 <20230417021725-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723B8489F8F9AE547393697D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417023911-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237BFB8BB3A3606CE6A408D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417030713-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723F3E6AE381AEC36D1AEFED49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4723F3E6AE381AEC36D1AEFED49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

On Mon, Apr 17, 2023 at 07:33:58AM +0000, Alvaro Karsz wrote:
> > > > > > Actually, I think that all you need to do is disable NETIF_F_SG,
> > > > > > and things will work, no?
> > > > >
> > > > > I think that this is not so simple, if I understand correctly, by disabling NETIF_F_SG we will never receive a chained skbs to transmit, but we still have more functionality to address, for example:
> > > > > * The TX timeouts.
> > > >
> > > > I don't get it. With a linear skb we can transmit it as long as there's
> > > > space for 2 entries in the vq: header and data. What's the source of the
> > > > timeouts?
> > > >
> > >
> > > I'm not saying that this is not possible, I meant that we need more changes to virtio-net.
> > > The source of the timeouts is from the current implementation of virtnet_poll_tx.
> > >
> > > if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> > >       netif_tx_wake_queue(txq);
> > 
> > Oh right. So this should check NETIF_F_SG then.
> > BTW both ring size and s/g can be tweaked by ethtool, also
> > needs handling.
> > 
> 
> Good point.
> 
> > >
> > > > > * Guest GSO/big MTU (without VIRTIO_NET_F_MRG_RXBUF?), we can't chain page size buffers anymore.
> > > >
> > > > I think we can.  mergeable_min_buf_len will just be large.
> > > >
> > >
> > > I meant that we can't just by clearing NETIF_F_SG, we'll need to change virtio-net a little bit more, for example, the virtnet_set_big_packets function.
> > >
> > 
> > Right - for RX, big_packets_num_skbfrags ignores ring size and that's
> > probably a bug if mtu is very large.
> > 
> 
> So, what do you think, we should fix virtio-net to work with smaller rings? we should fail probe?
> 
> I think that since this never came up until now, there is no big demand to such small rings.

The worry is that once we start failing probe there's just a tiny chance
hosts begin to rely on us failing probe then we won't be able to fix it.
So it depends on the size of the patch I think. So far it seems small enough
that wasting code on failing probe isn't worth it.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
