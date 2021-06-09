Return-Path: <SRS0=l8rc=LD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DC4C47095
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 08:04:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8BA6128A
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 08:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8BA6128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFA1A600B6;
	Wed,  9 Jun 2021 08:04:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mDlRpkSeq5jB; Wed,  9 Jun 2021 08:04:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7DD75607A5;
	Wed,  9 Jun 2021 08:03:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D90BC000E;
	Wed,  9 Jun 2021 08:03:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B466BC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 08:03:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F6858338B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 08:03:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S6iWxVakXD5L
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 08:03:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E93EE8333F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 08:03:56 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C77936100A;
 Wed,  9 Jun 2021 08:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1623225836;
 bh=6Mr1RXgCFLUnG6pcdHJhdFFbpP0idPvtv3LrafGu9iw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FT7RLLABssI8l0xEPCvDV7RivDTgyKPiq1dpWCMfU1gZa7S2d02M5+OX+9V3Hcbez
 JyIILaUZL2PlF/lB2h41760M3unfMbDTKqtEYC6/dB0AkTEIqW1E3WjDJR/r8lCCP5
 7QsnERzaGl8W8AJCUnfLpIL1BoDlf8SbV6MwLeE8=
Date: Wed, 9 Jun 2021 10:03:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: virtio-net: kernel panic in virtio_net.c
Message-ID: <YMB16VOrQXq5oagz@kroah.com>
References: <YMBelFMOAhEqWoc+@kroah.com>
 <1623225080.4793522-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1623225080.4793522-1-xuanzhuo@linux.alibaba.com>
Cc: regressions@lists.linux.dev, "Michael S.Tsirkin" <mst@redhat.com>,
 Corentin =?iso-8859-1?Q?No=EBl?= <corentin.noel@collabora.com>,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>
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

On Wed, Jun 09, 2021 at 03:51:20PM +0800, Xuan Zhuo wrote:
> On Wed, 9 Jun 2021 08:24:20 +0200, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Wed, Jun 09, 2021 at 02:08:17PM +0800, Xuan Zhuo wrote:
> > > On Wed, 9 Jun 2021 06:50:10 +0200, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > On Wed, Jun 09, 2021 at 09:48:33AM +0800, Xuan Zhuo wrote:
> > > > > > > With this patch and the latest net branch I no longer get crashes.
> > > > > >
> > > > > > Did this ever get properly submitted to the networking tree to get into
> > > > > > 5.13-final?
> > > > >
> > > > > The patch has been submitted.
> > > > >
> > > > > 	[PATCH net] virtio-net: fix for skb_over_panic inside big mode
> > > >
> > > > Submitted where?  Do you have a lore.kernel.org link somewhere?
> > >
> > >
> > > https://lore.kernel.org/netdev/20210603170901.66504-1-xuanzhuo@linux.alibaba.com/
> >
> > So this is commit 1a8024239dac ("virtio-net: fix for skb_over_panic
> > inside big mode") in Linus's tree, right?
> 
> YES.
> 
> >
> > But why is that referencing:
> > 	Fixes: fb32856b16ad ("virtio-net: page_to_skb() use build_skb when there's sufficient tailroom")
> 
> This problem was indeed introduced in fb32856b16ad.
> 
> I confirmed that this commit fb32856b16ad was first entered in 5.13-rc1, and the
> previous 5.12 did not have this commit fb32856b16ad.
> 
> I'm not sure if it helped you.

Hm, then what resolves the reported problem that people were having with
the 5.12.y kernel release?  Is that a separate issue?

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
