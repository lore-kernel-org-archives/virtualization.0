Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D14C77B75
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 18:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D943040A5B;
	Mon,  8 May 2023 18:10:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D943040A5B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b7MXJ9jI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mosjkv3C6wgt; Mon,  8 May 2023 18:10:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2D4F64016F;
	Mon,  8 May 2023 18:10:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2D4F64016F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEB24C0037;
	Mon,  8 May 2023 18:10:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC030C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 18:10:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B972B6160B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 18:10:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B972B6160B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=b7MXJ9jI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DA1mb3_M7Lp8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 18:10:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 039166152C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 039166152C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 18:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683569420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xgNVzoHB5qPigrpPQ7go/TrIsJOwIwgQ8Ks/ppylKsI=;
 b=b7MXJ9jIOOB5OKLZX1JAn2DejdFv9WzEoxrwls71jjcGt2inDSDB2ZBQ2jtb//7gf6EgT6
 vPUv9HGWENKqmD/1RRwU9SfxPHmDg2dTibP9Vdffu86nIr42maY/hqy6pdMAnFGtqgEHTw
 FG4y71MxNGg53fW7gw1HxXrHllg1x+Y=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-9-r77IuuPb6n5GCZCAfxXQ-1; Mon, 08 May 2023 14:10:17 -0400
X-MC-Unique: 9-r77IuuPb6n5GCZCAfxXQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7578369dff3so450771485a.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 May 2023 11:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683569417; x=1686161417;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xgNVzoHB5qPigrpPQ7go/TrIsJOwIwgQ8Ks/ppylKsI=;
 b=M8sZrIy/YUX4AFxjFTfQZ7JCTn6IXZA7pkA9jHRdFwniUxEdf7Ud+TY0/WL0s8ImvR
 z5SUfWLDxAe4NNqnH9Y5RdCysIrqcgv8akmhhdepveieWxOR4N6iCAwYvY1vkZisb5Nf
 rzKNFpo/BvHHEcKhIFsijc4By58Vbq45lOPLxd8iXyBT9ZIbJ8efrtdbI8uyWAOUOz8o
 PZBJWTNbrUIN5mrYFxR8ig0baXuXgYRsyl3hjbuFFfhYcTlgb1vmRLHZ6BJzQm4z2L94
 8OKjpxJb6ul5z1vta5PuBY7TP/5i5VSv8ucCeL0JzH4XqMfJhuPB4x2wGzQgWK3/9q8T
 f3Dw==
X-Gm-Message-State: AC+VfDwvh/aeKfQk3AUhof46vjAf3taaTvgozujDTulFmunhc912QSo7
 THiWGW6c8Q1Xj8dcJDcC8DERdmwyzJwnpGxDeKOP++dYkOd3F3x2XggRHpZNyEKCYzQmCqeAxoN
 btiw/v0Fhr0VZ3E0+Z4FyhjVwuY98+5oYtORwO9mJ1w==
X-Received: by 2002:ad4:5f0c:0:b0:5ef:5503:d41c with SMTP id
 fo12-20020ad45f0c000000b005ef5503d41cmr25153934qvb.15.1683569417212; 
 Mon, 08 May 2023 11:10:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Lq7OZAVzmXVCW5f4cqHto6UaJGOJ1GoX0WMEjEVCmLq6SBVcEwpI3XStDPAy8HaCpKxsqmg==
X-Received: by 2002:ad4:5f0c:0:b0:5ef:5503:d41c with SMTP id
 fo12-20020ad45f0c000000b005ef5503d41cmr25153902qvb.15.1683569416907; 
 Mon, 08 May 2023 11:10:16 -0700 (PDT)
Received: from redhat.com ([185.187.243.116]) by smtp.gmail.com with ESMTPSA id
 w10-20020a0ce10a000000b006039f5a247esm151943qvk.78.2023.05.08.11.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 May 2023 11:10:15 -0700 (PDT)
Date: Mon, 8 May 2023 14:10:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] virtio_net: set default mtu to 1500 when 'Device maximum
 MTU' bigger than 1500
Message-ID: <20230508140640-mutt-send-email-mst@kernel.org>
References: <1683341417.0965195-4-xuanzhuo@linux.alibaba.com>
 <07b6b325-9a15-222f-e618-d149b57cbac2@yusur.tech>
 <20230507045627-mutt-send-email-mst@kernel.org>
 <1683511319.099806-2-xuanzhuo@linux.alibaba.com>
 <20230508020953-mutt-send-email-mst@kernel.org>
 <1683526688.7492425-1-xuanzhuo@linux.alibaba.com>
 <20230508024147-mutt-send-email-mst@kernel.org>
 <1683531716.238961-1-xuanzhuo@linux.alibaba.com>
 <20230508062928-mutt-send-email-mst@kernel.org>
 <20230508092548.5fc8f078@hermes.local>
MIME-Version: 1.0
In-Reply-To: <20230508092548.5fc8f078@hermes.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, zy@yusur.tech,
 Hao Chen <chenh@yusur.tech>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, hengqi@linux.alibaba.com,
 huangml@yusur.tech, Jakub Kicinski <kuba@kernel.org>,
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

On Mon, May 08, 2023 at 09:25:48AM -0700, Stephen Hemminger wrote:
> On Mon, 8 May 2023 06:30:07 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > > > I don't know, in any scenario, when the hardware supports a large mtu, but we do
> > > > > not want the user to use it by default.  
> > > >
> > > > When other devices on the same LAN have mtu set to 1500 and
> > > > won't accept bigger packets.  
> > > 
> > > So, that depends on pmtu/tcp-probe-mtu.
> > > 
> > > If the os without pmtu/tcp-probe-mtu has a bigger mtu, then it's big packet
> > > will lost.
> > > 
> > > Thanks.
> > >   
> > 
> > pmtu is designed for routing. LAN is supposed to be configured with
> > a consistent MTU.
> 
> Virtio is often used with bridging or macvlan which can't support PMTU.
> PMTU only works when forwarding at layer 3 (ie routing) where there is
> a IP address to send the ICMP response. If doing L2 forwarding, the
> only thin the bridge can do is drop the packet.
> 
> TCP cab recover but detecting an MTU blackhole requires retransmissions.

Exactly. That's why we basically use the MTU advice supplied by device
by default - it's designed for use-cases of software devices where
the device might have more information about the MTU than the guest.
If hardware devices want e.g. a way to communicate support for
jumbo frames without communicating any information about the LAN,
a new feature will be needed.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
