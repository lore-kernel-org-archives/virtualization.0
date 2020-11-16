Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFE5C55ABD
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 09:21:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E09D2224F
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 09:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WkZ4jWMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E09D2224F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C638F861A7;
	Mon, 16 Nov 2020 09:20:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Coc9ATc5vDW; Mon, 16 Nov 2020 09:20:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 14FD485BDF;
	Mon, 16 Nov 2020 09:20:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2946C0891;
	Mon, 16 Nov 2020 09:20:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1864C07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 09:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BBD3A2001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 09:20:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9UtN6YdVeebq
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 09:20:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id 52AB02044D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 09:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=l8lfZbtE/pQjKf8onWmpmDV2l9aNdEWCmZpm7QvhYhY=; b=WkZ4jWMSdM5oVJJ1+WT3a3ZKKw
 ZZd1qF3sOIRHnvODVySNJ0v9EmHjoNO5yHaKM+wxcmtRkp5tJ6xiiB8Ctp1jjq8rslJxEymNdglBP
 WaFi7AkglyXM9KtL/4HrR9B5G+5BQ75Ca2H2+eAB0Ix10CEsGgslpuPr0Rg7qjGinrOj5y54IbHAN
 9FmoqLypVkD5Dhx8lUSPxSBmHILF+SaNpwq/Q65nYk/fgyW3FvfidjnMzoaUIizFMe91Bmcx7vR4Z
 ike0qgFGPKS9fCN4ccNutbHYobwd2qe4CNXw7EBccw7LtABW6AD+J/p72yv57FL350vVm0OyurNam
 snYUw6lg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1keafu-00087a-31; Mon, 16 Nov 2020 09:19:50 +0000
Date: Mon, 16 Nov 2020 09:19:50 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH virtio] virtio: virtio_console: fix DMA memory allocation
 for rproc serial
Message-ID: <20201116091950.GA30524@infradead.org>
References: <AOKowLclCbOCKxyiJ71WeNyuAAj2q8EUtxrXbyky5E@cp7-web-042.plabs.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AOKowLclCbOCKxyiJ71WeNyuAAj2q8EUtxrXbyky5E@cp7-web-042.plabs.ch>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Arnd Bergmann <arnd@arndb.de>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Amit Shah <amit@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-remoteproc@vger.kernel.org, Suman Anna <s-anna@ti.com>,
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

I just noticed this showing up in Linus' tree and I'm not happy.

This whole model of the DMA subdevices in remoteproc is simply broken.

We really need to change the virtio code pass an expicit DMA device (
similar to what e.g. the USB and RDMA code does), instead of faking up
devices with broken adhoc inheritance of DMA properties and magic poking
into device parent relationships.

Bjorn, I thought you were going to look into this a while ago?


On Wed, Nov 04, 2020 at 03:31:36PM +0000, Alexander Lobakin wrote:
> Since commit 086d08725d34 ("remoteproc: create vdev subdevice with
> specific dma memory pool"), every remoteproc has a DMA subdevice
> ("remoteprocX#vdevYbuffer") for each virtio device, which inherits
> DMA capabilities from the corresponding platform device. This allowed
> to associate different DMA pools with each vdev, and required from
> virtio drivers to perform DMA operations with the parent device
> (vdev->dev.parent) instead of grandparent (vdev->dev.parent->parent).
> 
> virtio_rpmsg_bus was already changed in the same merge cycle with
> commit d999b622fcfb ("rpmsg: virtio: allocate buffer from parent"),
> but virtio_console did not. In fact, operations using the grandparent
> worked fine while the grandparent was the platform device, but since
> commit c774ad010873 ("remoteproc: Fix and restore the parenting
> hierarchy for vdev") this was changed, and now the grandparent device
> is the remoteproc device without any DMA capabilities.
> So, starting v5.8-rc1 the following warning is observed:
> 
> [    2.483925] ------------[ cut here ]------------
> [    2.489148] WARNING: CPU: 3 PID: 101 at kernel/dma/mapping.c:427 0x80e7eee8
> [    2.489152] Modules linked in: virtio_console(+)
> [    2.503737]  virtio_rpmsg_bus rpmsg_core
> [    2.508903]
> [    2.528898] <Other modules, stack and call trace here>
> [    2.913043]
> [    2.914907] ---[ end trace 93ac8746beab612c ]---
> [    2.920102] virtio-ports vport1p0: Error allocating inbufs
> 
> kernel/dma/mapping.c:427 is:
> 
> WARN_ON_ONCE(!dev->coherent_dma_mask);
> 
> obviously because the grandparent now is remoteproc dev without any
> DMA caps:
> 
> [    3.104943] Parent: remoteproc0#vdev1buffer, grandparent: remoteproc0
> 
> Fix this the same way as it was for virtio_rpmsg_bus, using just the
> parent device (vdev->dev.parent, "remoteprocX#vdevYbuffer") for DMA
> operations.
> This also allows now to reserve DMA pools/buffers for rproc serial
> via Device Tree.
> 
> Fixes: c774ad010873 ("remoteproc: Fix and restore the parenting hierarchy for vdev")
> Cc: stable@vger.kernel.org # 5.1+
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> ---
>  drivers/char/virtio_console.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index a2da8f768b94..1836cc56e357 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -435,12 +435,12 @@ static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size
>  		/*
>  		 * Allocate DMA memory from ancestor. When a virtio
>  		 * device is created by remoteproc, the DMA memory is
> -		 * associated with the grandparent device:
> -		 * vdev => rproc => platform-dev.
> +		 * associated with the parent device:
> +		 * virtioY => remoteprocX#vdevYbuffer.
>  		 */
> -		if (!vdev->dev.parent || !vdev->dev.parent->parent)
> +		buf->dev = vdev->dev.parent;
> +		if (!buf->dev)
>  			goto free_buf;
> -		buf->dev = vdev->dev.parent->parent;
>  
>  		/* Increase device refcnt to avoid freeing it */
>  		get_device(buf->dev);
> -- 
> 2.29.2
> 
> 
---end quoted text---
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
