Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F69EC433ED
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 19:53:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD09613C6
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 19:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD09613C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77DEE6070D;
	Tue, 13 Apr 2021 19:53:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tI3shU73cA1R; Tue, 13 Apr 2021 19:53:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17A0D60C25;
	Tue, 13 Apr 2021 19:53:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD959C000B;
	Tue, 13 Apr 2021 19:53:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59C80C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 19:53:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F11640606
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 19:53:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rBIII5cn-W97
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 19:53:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 54C6E40614
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 19:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618343589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PgxG98RIEr3wCT1TwIssbfw/Fb5NwDAXhW1pDV2SLkI=;
 b=KQGyyBbxiQ8EKwJEJAu7gfYdumNnvoCpnvEnTJdKpZp3S6cvCqD9J/Rix6Mqy2ZR4cQbDf
 1EoIVJ9P3pDiJGfomCXDPiMlKJn0g+IXQkoWo5sLM2nkzfzEhxb4izTPeQsMm49QK/45fV
 9A5K5RNUOW9Mm9FXQM5XNHBneGMzJvc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-YILJJtumNl2NNyW9sU5S5Q-1; Tue, 13 Apr 2021 15:53:07 -0400
X-MC-Unique: YILJJtumNl2NNyW9sU5S5Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 g21-20020a1c4e150000b0290125a227e5bbso1558056wmh.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 12:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PgxG98RIEr3wCT1TwIssbfw/Fb5NwDAXhW1pDV2SLkI=;
 b=J8MtX8qomgXqzSfoc2nA7AN9rdvFKiA393cK6rT8M1ea/sFfh+n/vRIZqSFoGID80u
 qUeNgCyV+YcYi+oHcLPiIwAdGqU4OM+qeuRLCsLyy42+5uBttbq0t6JQGPXNanyEh8zo
 H/dgk77Z2KBi/1H9pMpP+r2zl9cfU1xxJW2VKe2axaVKOaxaiPVdJv4kwlhl2UE92XPX
 FpqeZHhviU16kDA5AwhddDBQ/8y2n/Py8g0vs8HwIdmeqg3Ozw8cPhAgZ5wTOaIcrbXl
 SLu2frGJFhNCX089oQDJnDQtx1il8A2182w8V3WaiW9+W8u4LTZlZZ0D/GHQWygd5dPJ
 3v/Q==
X-Gm-Message-State: AOAM532uYjc0YrnvQBFzV7dQlUXTsqdmAzZj2TGa8quf5B3DkT6gexTu
 WKOg3zo9rGPX8UqvG9SE4pm+W0jYu2uoje7+5v1wqtoec3wqAZIs5jgHyHNbAOanfaIcvcuJoZ8
 CwMzteZlF2tIwp2NHiy3CiFFqusohObOyFgEtsFxy5w==
X-Received: by 2002:a05:600c:b4b:: with SMTP id
 k11mr1571298wmr.180.1618343586103; 
 Tue, 13 Apr 2021 12:53:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlmN7KaZKdITDxZqR2cpHlOrzpfnuJ/uAOJzQ9V0l+bBdQa1ahISUDELIG3Q25KPQ4au2brg==
X-Received: by 2002:a05:600c:b4b:: with SMTP id
 k11mr1571284wmr.180.1618343585950; 
 Tue, 13 Apr 2021 12:53:05 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id a15sm20955449wrr.53.2021.04.13.12.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Apr 2021 12:53:05 -0700 (PDT)
Date: Tue, 13 Apr 2021 15:53:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH RFC v2 1/4] virtio: fix up virtio_disable_cb
Message-ID: <20210413153951-mutt-send-email-mst@kernel.org>
References: <20210413054733.36363-1-mst@redhat.com>
 <20210413054733.36363-2-mst@redhat.com>
 <CA+FuTSe_SjUY4JxR6G9b8a0nx-MfQOkLdHJSzmjpuRG4BvsVPw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+FuTSe_SjUY4JxR6G9b8a0nx-MfQOkLdHJSzmjpuRG4BvsVPw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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

On Tue, Apr 13, 2021 at 10:01:11AM -0400, Willem de Bruijn wrote:
> On Tue, Apr 13, 2021 at 1:47 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > virtio_disable_cb is currently a nop for split ring with event index.
> > This is because it used to be always called from a callback when we know
> > device won't trigger more events until we update the index.  However,
> > now that we run with interrupts enabled a lot we also poll without a
> > callback so that is different: disabling callbacks will help reduce the
> > number of spurious interrupts.
> 
> The device may poll for transmit completions as a result of an interrupt
> from virtnet_poll_tx.
> 
> As well as asynchronously to this transmit interrupt, from start_xmit or
> from virtnet_poll_cleantx as a result of a receive interrupt.
> 
> As of napi-tx, transmit interrupts are left enabled to operate in standard
> napi mode. While previously they would be left disabled for most of the
> time, enabling only when the queue as low on descriptors.
> 
> (in practice, for the at the time common case of split ring with event index,
> little changed, as that mode does not actually enable/disable the interrupt,
> but looks at the consumer index in the ring to decide whether to interrupt)
> 
> Combined, this may cause the following:
> 
> 1. device sends a packet and fires transmit interrupt
> 2. driver cleans interrupts using virtnet_poll_cleantx
> 3. driver handles transmit interrupt using vring_interrupt,
>     detects that the vring is empty: !more_used(vq),
>     and records a spurious interrupt.
> 
> I don't quite follow how suppressing interrupt suppression, i.e.,
> skipping disable_cb, helps avoid this.
> I'm probably missing something. Is this solving a subtly different
> problem from the one as I understand it?

I was thinking of this one:

 1. device is sending packets
 2. driver cleans them at the same time using virtnet_poll_cleantx
 3. device fires transmit interrupts
 4. driver handles transmit interrupts using vring_interrupt,
     detects that the vring is empty: !more_used(vq),
     and records spurious interrupts.


but even yours is also fixed I think.

The common point is that a single spurious interrupt is not a problem.
The problem only exists if there are tons of spurious interrupts with no
real ones. For this to trigger, we keep polling the ring and while we do
device keeps firing interrupts. So just disable interrupts while we
poll.



> > Further, if using event index with a packed ring, and if being called
> > from a callback, we actually do disable interrupts which is unnecessary.
> >
> > Fix both issues by tracking whenever we get a callback. If that is
> > the case disabling interrupts with event index can be a nop.
> > If not the case disable interrupts. Note: with a split ring
> > there's no explicit "no interrupts" value. For now we write
> > a fixed value so our chance of triggering an interupt
> > is 1/ring size. It's probably better to write something
> > related to the last used index there to reduce the chance
> > even further. For now I'm keeping it simple.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
