Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715C5C4742C
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 16:28:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC42C20776
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 16:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E8q5iMAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC42C20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 17664868AB;
	Mon, 16 Nov 2020 16:28:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cBtOTO0ZMxeu; Mon, 16 Nov 2020 16:28:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 78A5E8688C;
	Mon, 16 Nov 2020 16:28:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58E9FC0800;
	Mon, 16 Nov 2020 16:28:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08E5EC07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 03FDC8584C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:28:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 753TRdbFOnu8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:27:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6436385772
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=2NuZ81m6oUC1EPPya6oC4B+RkFMDfbQeS2iAs+KQSc0=; b=E8q5iMAFVmat6FprDTGNvNcVbT
 k+8B2sj5/ay9AYOvJ0+ZU3+/AtbYXbKzR6+hJt3OM6keJIC52UWU2TL9K/nyk5RHJDuuaT0W5MAdY
 ddlK+sv2snw1OeSzsqbr4fJrZKdVFHQTOMbDYI+YKSlQ1eqboE9vxbg7UbYVPCh5NHDkJ8RXrBpN1
 MtdUpG0wmAzPSZOQPJx4Li+dDtxnWBKxM4w5CYiRbARrDeN6QFN9tY65W9PJkZpDp9hSitCwv5sgx
 cuf/51MvUYtHKgz1mChZuvTZv0THl4gDH10EgMyN4YOXaMt6+fng89n9FDpYLnMBlhRFEQYNDl963
 wUNaIQ0g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kehM0-0004PY-2v; Mon, 16 Nov 2020 16:27:44 +0000
Date: Mon, 16 Nov 2020 16:27:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH virtio] virtio: virtio_console: fix DMA memory allocation
 for rproc serial
Message-ID: <20201116162744.GA16619@infradead.org>
References: <AOKowLclCbOCKxyiJ71WeNyuAAj2q8EUtxrXbyky5E@cp7-web-042.plabs.ch>
 <20201116091950.GA30524@infradead.org>
 <20201116045127-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201116045127-mutt-send-email-mst@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Ohad Ben-Cohen <ohad@wizery.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Amit Shah <amit@kernel.org>, Alexander Lobakin <alobakin@pm.me>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Christoph Hellwig <hch@infradead.org>, linux-remoteproc@vger.kernel.org,
 Suman Anna <s-anna@ti.com>, virtualization@lists.linux-foundation.org
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

On Mon, Nov 16, 2020 at 04:51:49AM -0500, Michael S. Tsirkin wrote:
> On Mon, Nov 16, 2020 at 09:19:50AM +0000, Christoph Hellwig wrote:
> > I just noticed this showing up in Linus' tree and I'm not happy.
> > 
> > This whole model of the DMA subdevices in remoteproc is simply broken.
> > 
> > We really need to change the virtio code pass an expicit DMA device (
> > similar to what e.g. the USB and RDMA code does),
> 
> Could you point me at an example or two please?

Take a look at the ib_dma_* helper in include/rdma/ib_verbs.h and
dma_device member in struct ib_device for the best example.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
