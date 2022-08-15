Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19068C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 22:05:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A76568174A;
	Mon, 15 Aug 2022 22:05:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A76568174A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VflUBB1M
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PNzpB1794vQ7; Mon, 15 Aug 2022 22:05:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 429D481462;
	Mon, 15 Aug 2022 22:05:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 429D481462
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03A7CC0032;
	Mon, 15 Aug 2022 22:05:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E39DC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 471D8408A5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:04:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 471D8408A5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VflUBB1M
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OYuuPjzLEA0K
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:04:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 585A3404E9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 585A3404E9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660601097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=lyQQM+55ZldD7H6umrPU2pn/Ul/3O7z+T5LMRSIVXr0=;
 b=VflUBB1MrNiWPoxYqwXuHlykljpETD2ehvJcW+sEhScadvxbtIqTRCi2J8ArpzYW5BbDT+
 4cyMSREq4icCes2DcUtT9LEM5jQEBPXreUUsQwqn91CYyxOM63DtPK3d34ZN0jqL/ipmlG
 u+ge0bYctGapj0X0hl8Cak4H12Fn7gc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-547-piZtQcH0PmasdJVuQTNQ8g-1; Mon, 15 Aug 2022 18:04:53 -0400
X-MC-Unique: piZtQcH0PmasdJVuQTNQ8g-1
Received: by mail-wr1-f69.google.com with SMTP id
 j7-20020adfa547000000b00224f7782df0so1103598wrb.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 15:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=lyQQM+55ZldD7H6umrPU2pn/Ul/3O7z+T5LMRSIVXr0=;
 b=o441GwD8DZ8iVeDSDsruLLPBEQi6btGt4MdKWWEUg2eaYRc5aNGPMYf6x9NxmdDHPA
 ncQA1extVansjcJ0v6Ev+LbfbF2o1cin32baDcUHPhzp0aDcW/hS4Tz9V3MJxVcjylE9
 lJ8X28yLVkj4zMNTg3HQTR6qjBQBmdh11GlEVzAlXZBmU2B7XnEtWXv6ssfheEWGAe5x
 fA23z4P1yO0Qgm05vIqhZ5o6Mjrm9ua2EGFs1posBE75ohmkCqKAno644Oaq1sTyIwRp
 DGPLUYVfNYSAPfgJkcRTo/Vs7o9b8f4v6pFI9rqRyYO68RHu+ZL82km1y78kD9l2jelm
 WT4A==
X-Gm-Message-State: ACgBeo1TbORwVCLtP9jkGn+AhQQbvMcI8lDshFa7pvVLGFGFzVOW5qOH
 pZT4eGpkna7czYveXnNaPDSK0gMAWd4Jp3MnXWTyDzFAePHWa9A0WtM8vuNcfn/HVPAQa6nYbCv
 5se4kEmx5yTZpFPUWmyFNNx37YYxYIfIe5VY57QCRRw==
X-Received: by 2002:a05:600c:5107:b0:3a6:72a:e63a with SMTP id
 o7-20020a05600c510700b003a6072ae63amr194371wms.204.1660601092469; 
 Mon, 15 Aug 2022 15:04:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6PUhV7WZdq3IgqAnAv21g/kOlOq56EKtk/N9dRgjydoQVgIDJVhN0tVySUIn3OBVrOOkFoZg==
X-Received: by 2002:a05:600c:5107:b0:3a6:72a:e63a with SMTP id
 o7-20020a05600c510700b003a6072ae63amr194361wms.204.1660601092225; 
 Mon, 15 Aug 2022 15:04:52 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 y5-20020adff6c5000000b0021b970a68f9sm8189495wrp.26.2022.08.15.15.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 15:04:51 -0700 (PDT)
Date: Mon, 15 Aug 2022 18:04:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] virtio: drop vp_legacy_set_queue_size
Message-ID: <20220815220447.155860-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

There's actually no way to set queue size on legacy virtio pci.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_pci_legacy.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/virtio_pci_legacy.h b/include/linux/virtio_pci_legacy.h
index e5d665faf00e..a8dc757d0367 100644
--- a/include/linux/virtio_pci_legacy.h
+++ b/include/linux/virtio_pci_legacy.h
@@ -32,8 +32,6 @@ void vp_legacy_set_queue_address(struct virtio_pci_legacy_device *ldev,
 			     u16 index, u32 queue_pfn);
 bool vp_legacy_get_queue_enable(struct virtio_pci_legacy_device *ldev,
 				u16 idx);
-void vp_legacy_set_queue_size(struct virtio_pci_legacy_device *ldev,
-			      u16 idx, u16 size);
 u16 vp_legacy_get_queue_size(struct virtio_pci_legacy_device *ldev,
 			     u16 idx);
 int vp_legacy_probe(struct virtio_pci_legacy_device *ldev);
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
