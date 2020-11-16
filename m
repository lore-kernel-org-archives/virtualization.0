Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF1CC55ABD
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 09:52:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C7020738
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 09:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUbdgiBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C7020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 304C72002E;
	Mon, 16 Nov 2020 09:52:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JDEE7LdIN2IP; Mon, 16 Nov 2020 09:51:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6F47220016;
	Mon, 16 Nov 2020 09:51:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57891C0891;
	Mon, 16 Nov 2020 09:51:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9534AC07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 09:51:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8389285D94
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 09:51:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zoyktv_r-tEi
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 09:51:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C2E1D857C5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 09:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605520316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1KNmLbHx5FsMWeQyHC4U7PBaTOGh9+m1vfmK/puBcB8=;
 b=CUbdgiBvjV8KJAi/j3LCRNZ5nd2oBKNU48mlPecVB3qqBF6iI0RVQX6Z/LFeaDMj57SSVO
 /+e4XXBVcvdgPeTaqbBnPXzfswH4UpXjMVMqTRYmcFnMk5basZVMn7AOsQ4I09uyDCZdlq
 Rf92XA+4sPX/VQIkscUJFSUl03ugsEM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-LG99xgtWMwG2YaQEMZoYJQ-1; Mon, 16 Nov 2020 04:51:55 -0500
X-MC-Unique: LG99xgtWMwG2YaQEMZoYJQ-1
Received: by mail-wm1-f69.google.com with SMTP id a130so9248991wmf.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 01:51:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1KNmLbHx5FsMWeQyHC4U7PBaTOGh9+m1vfmK/puBcB8=;
 b=j90IsxcZ3NExw9xYqRqqKPO2SSXgi/psmwhezdr72soZU7UWkaUJvtiBaiaSGsVeFh
 A1JxE+0ja5JF8gE3aiGGN3RXTHEknb/Xt7JuAs+Pnhc/9T1BpVj+QG0t1daysLnjNmFa
 fZJRY+VgIOB0N/1Qpiwi8A1dOgAGDgaQj4xUkt50iA+8zjvyGt1bvL60/jyBkbr0i9Xf
 2E/1eFmoq+8yDw7uBT1ILz/qCswwvuQxv9Djj53NJWwC3EXhBL49MQP21chGhlb717lK
 MPVQmGTHARadpvPJVdTGjqHbX9Xo6ihh9gWrOpsR6y6NfS8rXyuY9SI/Y2PYhLtT2EBa
 sM0Q==
X-Gm-Message-State: AOAM530GS5k2XIGetis4t+24Ue1Ai/ggJb8pL3wYY/63Nqgh1lOdbkyd
 A1mi32P6CaYTWCBK9aNXzjQQGdfufwxXabkSEng3KX5HlWoVcwXLqs+ydOMbab8p4QmrHC/OLrc
 QvoGLzK3wGIhG3X7VN+5hkOwlzgKmLqz02KOZNMntgg==
X-Received: by 2002:a5d:4046:: with SMTP id w6mr17917571wrp.51.1605520313880; 
 Mon, 16 Nov 2020 01:51:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5W14m0wF60uDdLzrkjrK5PsnrgSpm7lIZwz39JWVlPNEmIAhEgzigORtf8B6aoS6/Wf5jEQ==
X-Received: by 2002:a5d:4046:: with SMTP id w6mr17917548wrp.51.1605520313646; 
 Mon, 16 Nov 2020 01:51:53 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id j8sm18304039wrx.11.2020.11.16.01.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 01:51:52 -0800 (PST)
Date: Mon, 16 Nov 2020 04:51:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH virtio] virtio: virtio_console: fix DMA memory allocation
 for rproc serial
Message-ID: <20201116045127-mutt-send-email-mst@kernel.org>
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
> 
> This whole model of the DMA subdevices in remoteproc is simply broken.
> 
> We really need to change the virtio code pass an expicit DMA device (
> similar to what e.g. the USB and RDMA code does),

Could you point me at an example or two please?

Thanks!

> instead of faking up
> devices with broken adhoc inheritance of DMA properties and magic poking
> into device parent relationships.
> 
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
