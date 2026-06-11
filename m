Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5D935DA6E
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168485; cv=none; b=WYI+EqVhALUN+Uzaa6dx6vQnu+zaBqVLqeNeakeOqDTA7CXKIqrIh67X/qLRge0sTNHGVM6mWB1iHtFx7zx8+ezBc7wUawEylPiJV4nr6ALVlURNha+0a1MXnrq0t/EPpI8jzqzTFquXbyr9OCbAmkKkWN9zdv5RJe2wZwqw3fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168485; c=relaxed/simple;
	bh=E3qI6ZVSlf1pK0BK52x6ZMHdzTY1VyU5sBnDz0NHlvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QZaxtPjJwPOp83UV8PVcU37Vi5n2RSFT73By7PrZyWXbS086Zl0VF8nLmJfTJCCssqTfKWNTdVJFq9qV2nFf75+lZNRkXSxITdSLD+EsRdDjMS19J4/pI47exiGvAJCruDHcpfG9lLGMzT16KlClzrO7yat7fy0iaz4K0utY444=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hD9u9eFN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hD9u9eFN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781168483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AR5djebKyLdCEwoD8wE/BtoNjMCZfWrHQFJsPMItDkY=;
	b=hD9u9eFNelUgVJjIx/ExamSPZh/4CEzY771KY4A9N4PrEEx8oJ5QsOLWVSjQd2A3pALHG2
	onhfc+/klrojUYIfzBdt+NYu0pgmibfD27YrnqJ1ACk7QczuWlgkuIX+S+ZevuLAj5OcaV
	3WzlpPGJiqjhizvPS2+Mi8ByJUdSIxU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-JWLAZLKBMDyGdcuiNg-e_Q-1; Thu, 11 Jun 2026 05:01:20 -0400
X-MC-Unique: JWLAZLKBMDyGdcuiNg-e_Q-1
X-Mimecast-MFC-AGG-ID: JWLAZLKBMDyGdcuiNg-e_Q_1781168479
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490abeb7298so80158635e9.2
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168479; x=1781773279;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AR5djebKyLdCEwoD8wE/BtoNjMCZfWrHQFJsPMItDkY=;
        b=leyj0A+7rT56kFYsEjk/CwKcTvWTe5lvFj0iMtANKTVwM0GoI5JtBIqdbzPI01J4yL
         lNa8Yv2SpQUGKmm1fHhaHT1I484BPtMBpqEFE/Pg5cH/AD4gdiGDLmeE+slE8PaAt02u
         euALmDzXIxmRoOXUWASBB6w6R8ZNmBXUX8R8pYYei3bsmLrcRdTr4EnDl36OowJ4Utpq
         D1AThzrUBTTutdOq3TH3Ubczcz/egx6/7yWkH/UeNx/i4CHAf5+AXrJ5WwsMp8uvSLMg
         Kxn7O8VkRyPr2qJsuNVFpmqntu+uuwEGXDBpCO6hf3+HnCiLV5iC9Pe9kC9eZ2Gspunc
         hTfA==
X-Forwarded-Encrypted: i=1; AFNElJ9JFRNUFPM7UwtpMDqh5KNLjiupZ6mcil1OnTALUbtfurarepg61jCoah29GyfwmEqR3Vka0y1go/VOxlu9XA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzM3buABfjxAraMkF0jb+Rpac5Ledz4HPqILXA3V2xJrWOVMzGM
	MsWp3JynURR181NHTZfmQ0JhhqgYL6r4LvgycvJN82XtWRQIyE33rn0KzSmGeh6yi8Yy3/ny7sH
	4iAk03aIVjJ0kkIqkcSIryBseg5i19QnGdCJh8H6Aj2WTAP9sJTaHs+9h2GpH/XDCrNyG
X-Gm-Gg: Acq92OGPPLpzFZbXdg/iXGRYXv5m13XJZtehsx3vCA4kH0nLGrLzOZZu8FUPwq8Jc06
	ifZB+siONKkNt1nMZayFCGWJG7l6ZNGiPuKAYWmnlqpzfh0b062Jzygv5MGKLdekgwsOuttccEB
	gMdme8nj5U5TJMHxRbVh+lSi09uLbRLaYrMA0KRFi0fn6K4Kq9JUUiV4XohHzSKVIy9JSMFAOj5
	R3eyfEFt2mq+/+HMEcu4aO0T9XphuHC44/RQcHu6i9KpV7Kc31WzOGSYleg4PEEWQJ4PNZiwGZr
	0fSYIFJL9EEpW+0HUehV96QDe+N52uOGLoWh5sxCqc827XN0YKQTg/QG7megzJbrI6sF2N5gQl1
	n6ETKujFaTlhUjJdQ1FoldsiF0dHWwjZUR2cUmQGhvWbltuHA9zKogg==
X-Received: by 2002:a05:600c:4685:b0:490:3fdd:d353 with SMTP id 5b1f17b1804b1-490e55dd8c3mr25823105e9.8.1781168478894;
        Thu, 11 Jun 2026 02:01:18 -0700 (PDT)
X-Received: by 2002:a05:600c:4685:b0:490:3fdd:d353 with SMTP id 5b1f17b1804b1-490e55dd8c3mr25822315e9.8.1781168478247;
        Thu, 11 Jun 2026 02:01:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e532c778sm33144405e9.14.2026.06.11.02.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:01:17 -0700 (PDT)
Date: Thu, 11 Jun 2026 05:01:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] virtio_console: read size from config space
 during device init
Message-ID: <20260611044443-mutt-send-email-mst@kernel.org>
References: <20260223-virtio-console-fix-v1-1-0cf08303b428@gmail.com>
 <20260610030318-mutt-send-email-mst@kernel.org>
 <dce7a3af2e8fd674d842efe7e21abb4644248155.camel@gmail.com>
 <20260611033747-mutt-send-email-mst@kernel.org>
 <831dca185e55f56a14c0c580ab33ce84361eb67b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <831dca185e55f56a14c0c580ab33ce84361eb67b.camel@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JWqG-bBHKrct9J2J1xwYLo8cuSJyOGvY2bikSJJC08E_1781168479
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 10:29:50AM +0200, Filip Hejsek wrote:
> On Thu, 2026-06-11 at 03:38 -0400, Michael S. Tsirkin wrote:
> > [...]
> > > > 
> > > > Wait a second. Why is there this rproc test here?
> > > > Was not in the original code and commit log says nothing about it.
> > > > 
> > > 
> > > Previously, this code was in config_work_handler(), which was never
> > > called for rproc_serial (it's scheduled from config_intr(), which is
> > > the config_changed handler only for virtio_console).
> > > 
> > > Now update_size_from_config() is called unconditionally from
> > > virtcons_probe(), so it will be called for rproc_serial too, which
> > > doesn't have the F_SIZE feature.
> > 
> > So why not test it? 
> 
> The virtio_console driver implements two similar but distinct virtio
> devices: VIRTIO_ID_CONSOLE and VIRTIO_ID_RPROC_SERIAL. Although some of
> the implementation code is shared, the devices are different. In
> particular, rproc_serial doesn't support multiport nor any of the tty
> specific features. This means that the relevant feature bits are not
> valid for this device and must not be tested.



> I have to admit though that I don't quite understand what the
> RPROC_SERIAL device is supposed to be used for. It was added by commit
> 1b6370463e88b0c1c317de16d7b962acc1dab4f2, which describes it as "a
> simple serial connection driver called VIRTIO_ID_RPROC_SERIAL (11) for
> communicating with a remote processor in an asymmetric multi-processing
> configuration". It seems that it was never standardized, as the virtio
> spec only says that its ID is reserved.
> 
> > What does "not a valid feature" mean?
> 
> I copied the "not a valid feature" comment form other instances in the
> same file where a feature is tested, e.g. in resize_console():
> 
> 	/* Don't test F_SIZE at all if we're rproc: not a valid feature! */
> 	if (!is_rproc_serial(vdev) &&
> 	    virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
> 	  hvc_resize(port->cons.hvc, port->cons.ws);
> 
> 
> Best regards,
> Filip Hejsek

I get it, it's existing code.  It still makes no sense.

rproc has:

static const unsigned int rproc_serial_features[] = {
};      

No features.
So testing any feature bit at all always returns 0.

there's no reason to special case anything.

So I'm testing this, but I'm only compiling rproc, so pls holler if it seems wrong:


diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 198b97314168..2261862d4b4c 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -340,7 +340,7 @@ static inline bool use_multiport(struct ports_device *portdev)
 	 */
 	if (!portdev->vdev)
 		return false;
-	return __virtio_test_bit(portdev->vdev, VIRTIO_CONSOLE_F_MULTIPORT);
+	return virtio_has_feature(portdev->vdev, VIRTIO_CONSOLE_F_MULTIPORT);
 }
 
 static DEFINE_SPINLOCK(dma_bufs_lock);
@@ -1156,9 +1156,7 @@ static void resize_console(struct port *port)
 
 	vdev = port->portdev->vdev;
 
-	/* Don't test F_SIZE at all if we're rproc: not a valid feature! */
-	if (!is_rproc_serial(vdev) &&
-	    virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
+	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
 		hvc_resize(port->cons.hvc, port->cons.ws);
 }
 
@@ -1783,11 +1781,8 @@ static void update_size_from_config(struct ports_device *portdev)
 	 * We'll use this way of resizing only for legacy support.
 	 * For multiport devices, use control messages to indicate
 	 * console size changes so that it can be done per-port.
-	 *
-	 * Don't test F_SIZE at all if we're rproc: not a valid feature.
 	 */
-	if (is_rproc_serial(vdev) ||
-	    use_multiport(portdev) ||
+	if (use_multiport(portdev) ||
 	    !virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
 		return;
 
@@ -1994,9 +1989,7 @@ static int virtcons_probe(struct virtio_device *vdev)
 	multiport = false;
 	portdev->max_nr_ports = 1;
 
-	/* Don't test MULTIPORT at all if we're rproc: not a valid feature! */
-	if (!is_rproc_serial(vdev) &&
-	    virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
+	if (virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
 				 struct virtio_console_config, max_nr_ports,
 				 &portdev->max_nr_ports) == 0) {
 		if (portdev->max_nr_ports == 0 ||





-- 
MST

