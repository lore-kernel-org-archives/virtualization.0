Return-Path: <SRS0=SJT6=GA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0843C433E0
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 17:22:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277B9229C5
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 17:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277B9229C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 27F8D8629B;
	Mon, 28 Dec 2020 17:22:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q0tFF-HxQtM0; Mon, 28 Dec 2020 17:22:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8DB3385CA3;
	Mon, 28 Dec 2020 17:22:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BB19C0893;
	Mon, 28 Dec 2020 17:22:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 631BCC0891
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 17:22:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5D61A85DCA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 17:22:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WDylEuCeOr3w
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 17:22:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1DCFF85CA3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 17:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609176156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jke4od+O1Dw2orQ/EEeWLodrstqfYPkGTioL6w+PUps=;
 b=FwkTrSZApOC42JVYcOLlsi3BnBwXJg+Hc2aEtWOt97ueVvMPxRQj+q7zwcIzoez42SJ7Oz
 sc3glU9ZVth5mtvVhkL+b3o9bDxYhSjoGyYEVxq/QYzJ+7dvQAgLszIxY3T7ueX031LatF
 7VOO1mSejzpqeTiaV4x/DQSX71pOED8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-KdqLc80MMdG7Bl_mAvdEXw-1; Mon, 28 Dec 2020 12:22:33 -0500
X-MC-Unique: KdqLc80MMdG7Bl_mAvdEXw-1
Received: by mail-wr1-f71.google.com with SMTP id r11so6571980wrs.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 09:22:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Jke4od+O1Dw2orQ/EEeWLodrstqfYPkGTioL6w+PUps=;
 b=ceqZlYikBP4OOa9R8ZHY097M7U1hPwuOZw93JDSt06ipkGiLK3lQEZF4sx0oi6QoV6
 QZa1b6BIhJzARNW9kzD4vmWfdqCx6o+KSWG96EaNz2eWn02+TcYNJ9Hwq9foetOAiJcI
 IO1qRDMdyjh6qGot3IjDfxWWRBLZQgRFbfJiLDyyzR4hFgwqwcIqxE4DsgeexmmSjuXW
 o/9rGu5TKo2AXqFE0WsqMrAYq3QME7HgnY5hMlx+uityMBmoXe6F1A4aOM2Q+OQh67FZ
 n/C6EfQ2FUFFzeAtO2p/A1dI/iBQkFmQj+PlMe6o/RSuKn9yRXeotO6iUDPvDrgqp0yB
 tTng==
X-Gm-Message-State: AOAM533Vic/9cYQI2S5g1sToTsNFQgoVPRPZicsncLF5Wwar+uGm1HtO
 YsYBj7WN5bHYQxMVv3vEWqFuYockzkhuhbgCQRGlxCS2R930CJyKztuLxv6Wi4ChPzw2xA9vgtC
 inO/cRZRfL7Wr+3xfrhm13KhPOvxBuCoQeJLhgePL6Q==
X-Received: by 2002:adf:f989:: with SMTP id f9mr51181806wrr.299.1609176152676; 
 Mon, 28 Dec 2020 09:22:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUaLe8ioYv03NOJ5oWSAsKkAyD/zpt3/mAAaDWrtV3sTLDw5RRuJRsa1hapzoRwdVJi8dQMA==
X-Received: by 2002:adf:f989:: with SMTP id f9mr51181792wrr.299.1609176152435; 
 Mon, 28 Dec 2020 09:22:32 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id t10sm54905044wrp.39.2020.12.28.09.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Dec 2020 09:22:31 -0800 (PST)
Date: Mon, 28 Dec 2020 12:22:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH rfc 1/3] virtio-net: support transmit hash report
Message-ID: <20201228122155-mutt-send-email-mst@kernel.org>
References: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
 <20201228162233.2032571-2-willemdebruijn.kernel@gmail.com>
 <20201228112657-mutt-send-email-mst@kernel.org>
 <CA+FuTSdYLxV2O2WiD3D0cy2vaVbiECWheW0j7OGKKgV84wkScA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+FuTSdYLxV2O2WiD3D0cy2vaVbiECWheW0j7OGKKgV84wkScA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Network Development <netdev@vger.kernel.org>,
 virtualization@lists.linux-foundation.org
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

On Mon, Dec 28, 2020 at 11:47:45AM -0500, Willem de Bruijn wrote:
> On Mon, Dec 28, 2020 at 11:28 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Dec 28, 2020 at 11:22:31AM -0500, Willem de Bruijn wrote:
> > > From: Willem de Bruijn <willemb@google.com>
> > >
> > > Virtio-net supports sharing the flow hash from host to guest on rx.
> > > Do the same on transmit, to allow the host to infer connection state
> > > for more robust routing and telemetry.
> > >
> > > Linux derives ipv6 flowlabel and ECMP multipath from sk->sk_txhash,
> > > and updates these fields on error with sk_rethink_txhash. This feature
> > > allows the host to make similar decisions.
> > >
> > > Besides the raw hash, optionally also convey connection state for
> > > this hash. Specifically, the hash rotates on transmit timeout. To
> > > avoid having to keep a stateful table in the host to detect flow
> > > changes, explicitly notify when a hash changed due to timeout.
> >
> > I don't actually see code using VIRTIO_NET_HASH_STATE_TIMEOUT_BIT
> > in this series. Want to split out that part to a separate patch?
> 
> Will do.
> 
> I wanted to make it clear that these bits must be reserved (i.e.,
> zero) until a later patch specifies them.

Already the case for the padding field I think ...

> The timeout notification feature requires additional plumbing between
> the TCP protocol stack and device driver, probably an skb bit. I'd
> like to leave that as follow-up for now.
> 
> Thanks for the fast feedback!

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
