Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C05C77B72
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 07:10:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5056441B31;
	Mon, 17 Apr 2023 07:10:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5056441B31
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fvtATLfR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qGAalJmh1MuN; Mon, 17 Apr 2023 07:10:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 523A341A49;
	Mon, 17 Apr 2023 07:10:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 523A341A49
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F11FC0036;
	Mon, 17 Apr 2023 07:10:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA4D3C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 07:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BF46082239
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 07:10:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF46082239
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fvtATLfR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xBlKSM0XvfpQ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 07:10:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F4066821E9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F4066821E9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 07:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681715439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=khZ23ut9tSZy0CNwgidrOfEO75uvb5JIpDX8+Rd9+Ts=;
 b=fvtATLfR1G93TG8ZkskbSoiDwmJ+BMabCnY2CbK2LYWDqy1NxySiCyPj5q+od2XYPc2CQb
 9X/LTVnCJAyfEGu+ax9ZF0fHNQa2B2e75gLwg7TlpYCtXFBUy66G6Ja2Bcibf/FD13K12G
 Bhnh/ypcnGGjIn7jNfoG63J4wpjt3fg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-gBDiKHt6Mta72XxXZzomFg-1; Mon, 17 Apr 2023 03:10:38 -0400
X-MC-Unique: gBDiKHt6Mta72XxXZzomFg-1
Received: by mail-qv1-f72.google.com with SMTP id
 s14-20020a05621412ce00b005e839e5891bso12080165qvv.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 00:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681715437; x=1684307437;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khZ23ut9tSZy0CNwgidrOfEO75uvb5JIpDX8+Rd9+Ts=;
 b=KyIfhlYdqbql1dteFsrx5PU026P6HlEIQ6tEab+SokMh8jHo4YVUOICPuoxyqnHFI6
 3Z+7Dcs2PUXof35fxz26ziHnzmg4n8YrWNKWNVlyaznLWqWPZ0n0feTjeofXxh8Y+KXQ
 Tmy8/2pHbmBrbNllkF8hZvJMB1uG//lmCagFVNCivHGCynKEJGqctUs9g9WudKcNjG4j
 SY3rt3PU55vAxEUF4d/UiM5AbRg/B3fgR8IHtqmT+Sli92ctbV6kMr/F9TzNUAQpjuNZ
 COHXkVOiCPQlT6h/akatEh/we+LAaVoSFKrpoMRWk5hqFt0+wYMfE3zWB/h11M5xUJnx
 CtvQ==
X-Gm-Message-State: AAQBX9dsbD5FksQ4/g04xeZDaDPu4ZloNCngI6FbDEKmnxzabbRtWKbm
 0PslK34KF6vb1I7BUuxvL1kGISe6uIOn2MvcdPF9LCLOpmcH01htOuM9Ui4ravilT9mklyptnB9
 LGUqY6um63KxqHz4MxerIMqsdreNUuJFr9sfSNDHqFg==
X-Received: by 2002:ac8:5705:0:b0:3e1:18cc:7fb0 with SMTP id
 5-20020ac85705000000b003e118cc7fb0mr19873679qtw.41.1681715437549; 
 Mon, 17 Apr 2023 00:10:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZZNAN+4+EZys8WaUUUa9OgEdVXOuEUlcNT1Oqqqd2RWhLnDZZTLPDbDA7IGY19/AulMU52SA==
X-Received: by 2002:ac8:5705:0:b0:3e1:18cc:7fb0 with SMTP id
 5-20020ac85705000000b003e118cc7fb0mr19873659qtw.41.1681715437280; 
 Mon, 17 Apr 2023 00:10:37 -0700 (PDT)
Received: from redhat.com ([185.199.103.251]) by smtp.gmail.com with ESMTPSA id
 p15-20020a05622a00cf00b003ecf475286csm1559676qtw.39.2023.04.17.00.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Apr 2023 00:10:36 -0700 (PDT)
Date: Mon, 17 Apr 2023 03:10:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230417030713-mutt-send-email-mst@kernel.org>
References: <20230416074607.292616-1-alvaro.karsz@solid-run.com>
 <AM0PR04MB4723C6E99A217F51973710F5D49F9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230416164453-mutt-send-email-mst@kernel.org>
 <CACGkMEvFhVyWb5+ET_akPvnjUq04+ZbJC8o_GtNBWqSMGNum8A@mail.gmail.com>
 <20230417021725-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723B8489F8F9AE547393697D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417023911-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237BFB8BB3A3606CE6A408D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB47237BFB8BB3A3606CE6A408D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
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

On Mon, Apr 17, 2023 at 07:03:52AM +0000, Alvaro Karsz wrote:
> > > > Actually, I think that all you need to do is disable NETIF_F_SG,
> > > > and things will work, no?
> > >
> > > I think that this is not so simple, if I understand correctly, by disabling NETIF_F_SG we will never receive a chained skbs to transmit, but we still have more functionality to address, for example:
> > > * The TX timeouts.
> > 
> > I don't get it. With a linear skb we can transmit it as long as there's
> > space for 2 entries in the vq: header and data. What's the source of the
> > timeouts?
> > 
> 
> I'm not saying that this is not possible, I meant that we need more changes to virtio-net.
> The source of the timeouts is from the current implementation of virtnet_poll_tx.
> 
> if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> 	netif_tx_wake_queue(txq);

Oh right. So this should check NETIF_F_SG then.
BTW both ring size and s/g can be tweaked by ethtool, also
needs handling.


> 
> > > * Guest GSO/big MTU (without VIRTIO_NET_F_MRG_RXBUF?), we can't chain page size buffers anymore.
> > 
> > I think we can.  mergeable_min_buf_len will just be large.
> > 
> 
> I meant that we can't just by clearing NETIF_F_SG, we'll need to change virtio-net a little bit more, for example, the virtnet_set_big_packets function.
> 

Right - for RX, big_packets_num_skbfrags ignores ring size and that's
probably a bug if mtu is very large.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
