Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33BCC433FE
	for <virtualization@archiver.kernel.org>; Wed, 12 Oct 2022 11:07:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6B1354042B;
	Wed, 12 Oct 2022 11:07:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6B1354042B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U/+aZPuu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bmKY5e8tUh0p; Wed, 12 Oct 2022 11:07:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9F56140106;
	Wed, 12 Oct 2022 11:07:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F56140106
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79379C0033;
	Wed, 12 Oct 2022 11:07:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3469DC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 11:07:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 017464042B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 11:07:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 017464042B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8_B0fbtbcQ_e
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 11:07:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 15BDB40106
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 15BDB40106
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 11:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665572866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=QA+9IDqgn+blor4+o5DMdo6TwcAPu5Eh2nDXrpBAQL8=;
 b=U/+aZPuuTHsslqz4ALKDQB5CpOHp2y5hyn3KzGSEpYyz4wf6NhxzyF/nLhAHUokkfTcNuj
 z/Th0WfYxrnIv03eYQ16RQABtYDc5aQoLHjmjzxC1hghvx67Og85mR22gOaljZ5U1u6WYv
 eMXYcFDjT11nPp0FxyJcVJeN4nXbxAw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-15-ER1BeTxvP3yMurnPfjkIkQ-1; Wed, 12 Oct 2022 07:07:44 -0400
X-MC-Unique: ER1BeTxvP3yMurnPfjkIkQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 r132-20020a1c448a000000b003c3a87d8abdso6927691wma.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 04:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QA+9IDqgn+blor4+o5DMdo6TwcAPu5Eh2nDXrpBAQL8=;
 b=gToSY2bnZoizAgEk/Hxfz9vNBwBaOMmOpCtDIKt8xAy3JlZJ3f8aev3SN0zXWkA29i
 4TAKdjdrfqLxQ4JRcZXsnurVfTCSckXwgu95K+HRTO0Fget61mMEYsD/W15IdZ3bPAB+
 Un/qmfJPDe0Dy88coiAZrZD0B/4YfcuaLGjHAsOBjZzzye+cJfFFmFsnw0xU7tZd2GgK
 JE4ri3fI8sEIHlC2lEH1+mCHgTmcWfEodqDrpLYWV21nK1MfkCC1Zlf9yNxOFHB9L6gl
 85xWkWY2i2QtLOS8bPT0W3B+BxdE9M7S2JbuKhsvNqUeIhPLxmM156H2Fm8O+QR8Vt7+
 bJpA==
X-Gm-Message-State: ACrzQf393ScJOCGYSrdAPGsfLYGCm4H2OnVjVJtR6v+Q3njDazc+11Nu
 WAb+wpPdI3Z8Lo8jZQRMdmbqDUIXFT2fh7R5Ru04xYH66n7+m+thbsk3ExXQse4cMO/GuOthcl2
 0/cY69CveGJrhwAeRrFSuxUjNFNQRJ1dUWXLcU+KYnQ==
X-Received: by 2002:a05:600c:3c82:b0:3b5:60a6:c80f with SMTP id
 bg2-20020a05600c3c8200b003b560a6c80fmr2385207wmb.199.1665572863720; 
 Wed, 12 Oct 2022 04:07:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5inPNWHSWc1gs5TIXEf5jKgbpH2XPgEMLAGLpADyEG2gIXgIpphiXXjIRCrRcs0fdg6iZ/yQ==
X-Received: by 2002:a05:600c:3c82:b0:3b5:60a6:c80f with SMTP id
 bg2-20020a05600c3c8200b003b560a6c80fmr2385177wmb.199.1665572863169; 
 Wed, 12 Oct 2022 04:07:43 -0700 (PDT)
Received: from redhat.com ([2.54.162.123]) by smtp.gmail.com with ESMTPSA id
 a1-20020a05600c348100b003a5f4fccd4asm1469436wmq.35.2022.10.12.04.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Oct 2022 04:07:42 -0700 (PDT)
Date: Wed, 12 Oct 2022 07:07:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_pci: read interrupt pin directly
Message-ID: <20221012110736.285161-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 virtualization@lists.linux-foundation.org,
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

Work around the issue in virtio for now, and let's try to fix
all affected pci systems and then we can revert this.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Fixes: 71491c54eafa ("virtio_pci: don't try to use intxif pin is zero")
Cc: "Angus Chen" <angus.chen@jaguarmicro.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 4df77eeb4d16..6155ea4e7e4b 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -400,6 +400,7 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 		struct irq_affinity *desc)
 {
 	int err;
+	u8 pin = 0;
 
 	/* Try MSI-X with one vector per queue. */
 	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx, desc);
@@ -409,8 +410,13 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
 	if (!err)
 		return 0;
-	/* Is there an interrupt pin? If not give up. */
-	if (!(to_vp_device(vdev)->pci_dev->pin))
+	/*
+	 * Is there an interrupt pin? If not give up.
+	 * NB: It would seem to be better to use pci_dev->pin - unfortunately
+	 * not all platforms populate it.
+	 */
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	if (!pin)
 		return err;
 	/* Finally fall back to regular interrupts. */
 	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
