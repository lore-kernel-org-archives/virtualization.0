Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01656C63697
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 16:39:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9044521527
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 16:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c3SQUeMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9044521527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4BD3E87173;
	Mon, 16 Nov 2020 16:39:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eV5bWNfoCLCm; Mon, 16 Nov 2020 16:39:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C3ED385AC7;
	Mon, 16 Nov 2020 16:39:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 922DAC0800;
	Mon, 16 Nov 2020 16:39:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DE2DC07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 39FC185B2F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:39:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A5Z_Z2ifAIu8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:39:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 793B585B25
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=/M9t61KOqi1MYTJyagjw+b8PgJisejej65ZgJ6XoswQ=; b=c3SQUeMiZ9CED8cEqQQLM9KkUB
 6i+1ST71hFHKpE43MqROlgG6q/v+fN1xdBwUbfi7kGuSWOnKW7HquppFhlrUpXMC+x8MSeYgi37UR
 9LBBGdeyY/8nwkhxPmFbQLe3jkmev9R6j1sWhUHZEyU9UaV1S+L6ALECNoE2Wm/h8QGJB/o+BgGiE
 Xjx+vMS2QqGgXaI/0peIaY40ntlEgZDAxRq4lKfHUwtxzXj/E4/DyQiLGhY8bOZmuPqssbbDTEQWH
 r9/u+8JGT/mB/b6VS7gAiB4jrKn9T34MMvHs6orCNCV+UONq4274s0z2zudslnnUolT2zBOWTklf2
 1erZnp/Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kehX1-0005Cd-9h; Mon, 16 Nov 2020 16:39:07 +0000
Date: Mon, 16 Nov 2020 16:39:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Subject: Re: [PATCH virtio] virtio: virtio_console: fix DMA memory allocation
 for rproc serial
Message-ID: <20201116163907.GA19209@infradead.org>
References: <AOKowLclCbOCKxyiJ71WeNyuAAj2q8EUtxrXbyky5E@cp7-web-042.plabs.ch>
 <20201116091950.GA30524@infradead.org>
 <ca183081-5a9f-0104-bf79-5fea544c9271@st.com>
 <20201116162844.GB16619@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201116162844.GB16619@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Ohad Ben-Cohen <ohad@wizery.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Amit Shah <amit@kernel.org>, Alexander Lobakin <alobakin@pm.me>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Christoph Hellwig <hch@infradead.org>, Suman Anna <s-anna@ti.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

Btw, I also still don't understand why remoteproc is using
dma_declare_coherent_memory to start with.  The virtio code has exactly
one call to dma_alloc_coherent vring_alloc_queue, a function that
already switches between two different allocators.  Why can't we just
add a third allocator specifically for these remoteproc memory carveouts
and bypass dma_declare_coherent_memory entirely?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
