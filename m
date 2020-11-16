Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3A8C5519F
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 12:25:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 336DA2224B
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 12:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="beiNO0zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336DA2224B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id ACFF78684E;
	Mon, 16 Nov 2020 12:25:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6f40catzTXLC; Mon, 16 Nov 2020 12:25:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 48DF186812;
	Mon, 16 Nov 2020 12:25:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2465EC0800;
	Mon, 16 Nov 2020 12:25:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E8E7C07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 12:25:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 26A8486806
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 12:25:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vveDJ-KHdXPB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 12:25:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id ADD0A86803
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 12:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605529542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=twYAjgtjeEtP7dme/B3MtQN8LFC4b+SiLV0pksaCw+Q=;
 b=beiNO0zmf1qEofoM6i6EUb8FXyRKDHCv7whNvQKSQhkrAYGpW54JifkHafQdEAICko/pXf
 4WvB6vWtD8nIvhuymQ2Y5gRLq+QjQNWgJmYgZ+hIEFg46/Rnau/imd2Ao66txutxC1NsBe
 hPIizj0dXXZl6onCyHNQWjMCxL1wa88=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-FS4_b5WlPm2XmSxi57Q1og-1; Mon, 16 Nov 2020 07:25:40 -0500
X-MC-Unique: FS4_b5WlPm2XmSxi57Q1og-1
Received: by mail-wm1-f72.google.com with SMTP id h9so8918531wmf.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 04:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=twYAjgtjeEtP7dme/B3MtQN8LFC4b+SiLV0pksaCw+Q=;
 b=gyuiP2cMMp6YOATjFoF93GCmEmSuJQ6GRWuL2RBI59NlDcwijYTobF48RPQdfGCVQe
 rTH4T9mZ+lvt56l8budo8m2IP8OEq7UJilm/XSQXG+zgPa11/lT8ywgEPdvBRAYmot3u
 XLw9HiaF8zFRDZJXoL2xqJRud5pRpQGQXLN7vI90oe+bExkCLYmfevjYgzzsMLACZCGE
 P4VtX0iKxppydGQTo1QnV6Eo5Dx82D47SOPdA3W4bPnGtuaBNrrAuInjBGdyowk9cZBq
 Mb9RNRnyvv1wdLcDvsk2PgAklaRNR9DheLGyI+paP+c+ThPy6y51lZ7/tsYrPcQAzcMs
 ZgLw==
X-Gm-Message-State: AOAM532crcr2XyGTCQb7lx8nb+OOd8kFMt4Eb/SapvpTPST0+DuReM2F
 g2bg5o+ue35MVYhZf10W166YPDxe0G0+WavwS9PN1Mle/mPRW+okKK8NX4cLZEag9X5ZssW46ji
 NbnAES2+89nBBzky4Ijk2QcBhIc2WtQE3nYZ2CjukWg==
X-Received: by 2002:adf:a551:: with SMTP id j17mr20868551wrb.217.1605529539628; 
 Mon, 16 Nov 2020 04:25:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTpJY9zGC+xn6xq+CTHXLTZWqhazVhhm46QQKKwl8uV2NZSejldsTJ5sdUDy6obYAtroP4Vw==
X-Received: by 2002:adf:a551:: with SMTP id j17mr20868522wrb.217.1605529539401; 
 Mon, 16 Nov 2020 04:25:39 -0800 (PST)
Received: from redhat.com ([147.161.8.56])
 by smtp.gmail.com with ESMTPSA id i10sm22686923wrs.22.2020.11.16.04.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 04:25:38 -0800 (PST)
Date: Mon, 16 Nov 2020 07:25:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH virtio] virtio: virtio_console: fix DMA memory allocation
 for rproc serial
Message-ID: <20201116071910-mutt-send-email-mst@kernel.org>
References: <AOKowLclCbOCKxyiJ71WeNyuAAj2q8EUtxrXbyky5E@cp7-web-042.plabs.ch>
 <20201116091950.GA30524@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20201116091950.GA30524@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Ohad Ben-Cohen <ohad@wizery.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Amit Shah <amit@kernel.org>, Alexander Lobakin <alobakin@pm.me>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Mon, Nov 16, 2020 at 09:19:50AM +0000, Christoph Hellwig wrote:
> I just noticed this showing up in Linus' tree and I'm not happy.

Are you sure? I think it's in next.

> This whole model of the DMA subdevices in remoteproc is simply broken.
> 
> We really need to change the virtio code pass an expicit DMA device (
> similar to what e.g. the USB and RDMA code does), instead of faking up
> devices with broken adhoc inheritance of DMA properties and magic poking
> into device parent relationships.

OK but we do have a regression since 5.7 and this looks like
a fix appropriate for e.g. stable, right?

> Bjorn, I thought you were going to look into this a while ago?
> 
> 
> On Wed, Nov 04, 2020 at 03:31:36PM +0000, Alexander Lobakin wrote:
> > Since commit 086d08725d34 ("remoteproc: create vdev subdevice with
> > specific dma memory pool"), every remoteproc has a DMA subdevice
> > ("remoteprocX#vdevYbuffer") for each virtio device, which inherits
> > DMA capabilities from the corresponding platform device. This allowed
> > to associate different DMA pools with each vdev, and required from
> > virtio drivers to perform DMA operations with the parent device
> > (vdev->dev.parent) instead of grandparent (vdev->dev.parent->parent).
> > 
> > virtio_rpmsg_bus was already changed in the same merge cycle with
> > commit d999b622fcfb ("rpmsg: virtio: allocate buffer from parent"),
> > but virtio_console did not. In fact, operations using the grandparent
> > worked fine while the grandparent was the platform device, but since
> > commit c774ad010873 ("remoteproc: Fix and restore the parenting
> > hierarchy for vdev") this was changed, and now the grandparent device
> > is the remoteproc device without any DMA capabilities.
> > So, starting v5.8-rc1 the following warning is observed:
> > 
> > [    2.483925] ------------[ cut here ]------------
> > [    2.489148] WARNING: CPU: 3 PID: 101 at kernel/dma/mapping.c:427 0x80e7eee8
> > [    2.489152] Modules linked in: virtio_console(+)
> > [    2.503737]  virtio_rpmsg_bus rpmsg_core
> > [    2.508903]
> > [    2.528898] <Other modules, stack and call trace here>
> > [    2.913043]
> > [    2.914907] ---[ end trace 93ac8746beab612c ]---
> > [    2.920102] virtio-ports vport1p0: Error allocating inbufs
> > 
> > kernel/dma/mapping.c:427 is:
> > 
> > WARN_ON_ONCE(!dev->coherent_dma_mask);
> > 
> > obviously because the grandparent now is remoteproc dev without any
> > DMA caps:
> > 
> > [    3.104943] Parent: remoteproc0#vdev1buffer, grandparent: remoteproc0
> > 
> > Fix this the same way as it was for virtio_rpmsg_bus, using just the
> > parent device (vdev->dev.parent, "remoteprocX#vdevYbuffer") for DMA
> > operations.
> > This also allows now to reserve DMA pools/buffers for rproc serial
> > via Device Tree.
> > 
> > Fixes: c774ad010873 ("remoteproc: Fix and restore the parenting hierarchy for vdev")
> > Cc: stable@vger.kernel.org # 5.1+
> > Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> > ---
> >  drivers/char/virtio_console.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index a2da8f768b94..1836cc56e357 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -435,12 +435,12 @@ static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size
> >  		/*
> >  		 * Allocate DMA memory from ancestor. When a virtio
> >  		 * device is created by remoteproc, the DMA memory is
> > -		 * associated with the grandparent device:
> > -		 * vdev => rproc => platform-dev.
> > +		 * associated with the parent device:
> > +		 * virtioY => remoteprocX#vdevYbuffer.
> >  		 */
> > -		if (!vdev->dev.parent || !vdev->dev.parent->parent)
> > +		buf->dev = vdev->dev.parent;
> > +		if (!buf->dev)
> >  			goto free_buf;
> > -		buf->dev = vdev->dev.parent->parent;
> >  
> >  		/* Increase device refcnt to avoid freeing it */
> >  		get_device(buf->dev);
> > -- 
> > 2.29.2
> > 
> > 
> ---end quoted text---

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
