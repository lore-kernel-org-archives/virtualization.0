Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A944FC4332F
	for <virtualization@archiver.kernel.org>; Wed, 12 Oct 2022 22:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 391C1402A6;
	Wed, 12 Oct 2022 22:04:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 391C1402A6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ga11IxnE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k6XmcXYHHwDy; Wed, 12 Oct 2022 22:04:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4DCE1402A3;
	Wed, 12 Oct 2022 22:04:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4DCE1402A3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 173B8C0032;
	Wed, 12 Oct 2022 22:04:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C2F2C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 22:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 29B3E81501
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 22:04:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29B3E81501
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ga11IxnE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HSSkUARSVgs3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 22:04:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F1D72814BB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F1D72814BB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 22:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665612248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=+UHVZ0OKpbw8jecQvx7/f32wxsaBtJja/aKylAWrChs=;
 b=Ga11IxnE1faDQSBsCjxUS59XMt9XzIBK/DIHkO2ybPx/JcJKEUY7mpQzA9prJOrxenefxt
 1pWvCTidpMKvnApUydnCOiruD9976mm8s93kmgxLgFdsYcapQ6ZVvxz48D+q/+b2MJTlC/
 ns9SLscfUvTcz7ggox3QwdC+Tu4nE1k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-279-tfkGdfewMa25-nxpSY48YQ-1; Wed, 12 Oct 2022 18:04:07 -0400
X-MC-Unique: tfkGdfewMa25-nxpSY48YQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 q14-20020a7bce8e000000b003c6b7debf22so93608wmj.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 15:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+UHVZ0OKpbw8jecQvx7/f32wxsaBtJja/aKylAWrChs=;
 b=Q8fW6EQugMV2w80ITIXSxzTolQvIehVtKDLttqhB8O7I5bSHqDUWBT4F1KqJIvalNs
 /dXDcUxGt9/AuLwej/qK5/v5JAoWdRZj+9h+GFmNetO02g6RS7WC6ad7Cia8Yf5gJj2/
 hyAeqK75/yPUeYxKguMNKcc8CkDR1MwWYpEm5idPjd6iInXMPLwDMV/ijYUPlP8/8zcK
 E9roU1oYOuO1lWuGprYOEM9z6W299F9TfUlxBcvv2+Rg3lCHTuxjJmRQ5hHB9vHvdBcQ
 FMIJgsKX9zj/ASzF4SZVaZ8Y+PRMTYcRevMvz+pGQPcKeHGBtQBgIY96Ik2WIuqikz7B
 MXQQ==
X-Gm-Message-State: ACrzQf1c5LTdMH3lF1c7erAYS2wBNBMMu37GaV/xr7Zba/usAZ2s/YJX
 +GDYJZBXZ81anCIO80q8jylx3y5qQCt3xtd/DO+Tc2Xud8uwV9Z2zCR7ArULOptn6iHmH2AJF+G
 36eLPMiMRKinaiC4mQC8jC+W7rrgKLYkSc5P9wAwgeQ==
X-Received: by 2002:a7b:c404:0:b0:3b4:faca:cf50 with SMTP id
 k4-20020a7bc404000000b003b4facacf50mr4103267wmi.67.1665612246142; 
 Wed, 12 Oct 2022 15:04:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4MfahqjXwEkSDDOMNB17Cw+s5zIwA1SUMh4iBqCWkVIvhAH97bnjQIK7k88X1UxN6qaBAVEg==
X-Received: by 2002:a7b:c404:0:b0:3b4:faca:cf50 with SMTP id
 k4-20020a7bc404000000b003b4facacf50mr4103254wmi.67.1665612245909; 
 Wed, 12 Oct 2022 15:04:05 -0700 (PDT)
Received: from redhat.com ([2.54.162.123]) by smtp.gmail.com with ESMTPSA id
 l27-20020a056000023b00b0022a403954c3sm609517wrz.42.2022.10.12.15.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Oct 2022 15:04:05 -0700 (PDT)
Date: Wed, 12 Oct 2022 18:04:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_pci: use irq to detect interrupt support
Message-ID: <20221012220312.308522-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 virtualization@lists.linux-foundation.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Angus Chen <angus.chen@jaguarmicro.com>
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

commit 71491c54eafa ("virtio_pci: don't try to use intxif pin is zero")
breaks virtio_pci on powerpc, when running as a qemu guest.

vp_find_vqs() bails out because pci_dev->pin == 0.

But pci_dev->irq is populated correctly, so vp_find_vqs_intx() would
succeed if we called it - which is what the code used to do.

This seems to happen because pci_dev->pin is not populated in
pci_assign_irq().

Which is absolutely a bug in the relevant PCI code, but it
may also affect other platforms that use of_irq_parse_and_map_pci().

However Linus said:
	The correct way to check for "no irq" doesn't use NO_IRQ at all, it just does
		if (dev->irq) ...
so let's just check irq and be done with it.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Fixes: 71491c54eafa ("virtio_pci: don't try to use intxif pin is zero")
Cc: "Angus Chen" <angus.chen@jaguarmicro.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Build tested only - very late here. Angus any chance you could
help test this? Thanks!

 drivers/virtio/virtio_pci_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 4df77eeb4d16..a6c86f916dbd 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -409,8 +409,8 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
 	if (!err)
 		return 0;
-	/* Is there an interrupt pin? If not give up. */
-	if (!(to_vp_device(vdev)->pci_dev->pin))
+	/* Is there an interrupt? If not give up. */
+	if (!(to_vp_device(vdev)->pci_dev->irq))
 		return err;
 	/* Finally fall back to regular interrupts. */
 	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
