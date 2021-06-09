Return-Path: <SRS0=l8rc=LD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD91DC47095
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 06:24:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8EB61040
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 06:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8EB61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DF4440236;
	Wed,  9 Jun 2021 06:24:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YwZSP2Uk2IEj; Wed,  9 Jun 2021 06:24:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 881F340482;
	Wed,  9 Jun 2021 06:24:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52B3EC000E;
	Wed,  9 Jun 2021 06:24:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B185C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 06:24:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 16D584015D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 06:24:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D9FHoj43a1sx
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 06:24:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E3934010D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 06:24:23 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F66E61352;
 Wed,  9 Jun 2021 06:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1623219862;
 bh=PZI/QDz7xWSlIQGk4btpDqsFHnCoZdsyGl8U8TeVF0I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AdkrvkPn7Vz0F83eSHoKjTTFChar0SwNy1QF2SKAGj3MFeCu7KATd25KEcqPXCKSv
 4HGm46qFXm0Jhan4TzkanLoy4P1ox9SnkW/c4ZPbagjb7uP9KQIYryFrIQB14Y0tPs
 iCus5CsZW9jOeQrNXNqH8JYf2ESPWxYNVPzbhwPk=
Date: Wed, 9 Jun 2021 08:24:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: virtio-net: kernel panic in virtio_net.c
Message-ID: <YMBelFMOAhEqWoc+@kroah.com>
References: <YMBIghQaTelAvXOY@kroah.com>
 <1623218897.4150124-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1623218897.4150124-1-xuanzhuo@linux.alibaba.com>
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

On Wed, Jun 09, 2021 at 02:08:17PM +0800, Xuan Zhuo wrote:
> On Wed, 9 Jun 2021 06:50:10 +0200, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Wed, Jun 09, 2021 at 09:48:33AM +0800, Xuan Zhuo wrote:
> > > > > With this patch and the latest net branch I no longer get crashes.
> > > >
> > > > Did this ever get properly submitted to the networking tree to get into
> > > > 5.13-final?
> > >
> > > The patch has been submitted.
> > >
> > > 	[PATCH net] virtio-net: fix for skb_over_panic inside big mode
> >
> > Submitted where?  Do you have a lore.kernel.org link somewhere?
> 
> 
> https://lore.kernel.org/netdev/20210603170901.66504-1-xuanzhuo@linux.alibaba.com/

So this is commit 1a8024239dac ("virtio-net: fix for skb_over_panic
inside big mode") in Linus's tree, right?

But why is that referencing:
	Fixes: fb32856b16ad ("virtio-net: page_to_skb() use build_skb when there's sufficient tailroom")

when this problem was seen in stable kernels that had a different commit
backported to it?

Is there nothing needed to be done for the stable kernel trees?

confused,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
