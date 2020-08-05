Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68708C433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:45:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 366C92065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tc2FWQML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366C92065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2309288251;
	Wed,  5 Aug 2020 13:45:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tJS7XS3+3LD2; Wed,  5 Aug 2020 13:45:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 976D888221;
	Wed,  5 Aug 2020 13:45:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EE25C0051;
	Wed,  5 Aug 2020 13:45:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A993C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 25E7B226DB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 35GJgdYQsJ6t
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id 5F5C020518
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sf4mb/ld3dK0n/pClGJVnIPC6I0ejWcYW7v5x6Bo1+M=;
 b=Tc2FWQMLEXdSd4majCFG/0J2SZadnKp8QxMvTG+Q68OKbOAb5Mvx8U1G22v7RfSKw4cf7e
 yvxkoNlfegLYH/79lfShh47+VXm6rilV7LZUzX9tpLZuU8wl4DFZWfubQRbWT29iPxaK7m
 AEnB0eoRUv5zSICmLykJDyLZ3F8ih88=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-s20ukweyPou7EkYFNlPTwA-1; Wed, 05 Aug 2020 09:44:54 -0400
X-MC-Unique: s20ukweyPou7EkYFNlPTwA-1
Received: by mail-wr1-f72.google.com with SMTP id r29so9280216wrr.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Sf4mb/ld3dK0n/pClGJVnIPC6I0ejWcYW7v5x6Bo1+M=;
 b=bZj7xB6BH2dJy9ogMqx+iGuVejKhvIa1Nlox4Ku4CfLRxMZf3eO9i3L3u5VtQi4aGy
 FXrEKhO2WBWwQnAA63oe/mxgNu+Mekvqy0+ngX08zv89dgiqJZpVS4FKGwCTykdTtsNR
 hgVweBLJ00hD5uTHdx0n87L4AxItOVtDSB4WjYSkMxzLBhkcynF79/48VA9jnMcuL1Ck
 3K4IYD/yC5wPnRU/TM9+DOQaXyKUvimhcIRHuYEe90x9Z4RRuxpz1vd1WmfxAiT8Jlyx
 sF/UB0bNQ04XKtXKvgycDWmw5G0bfP6x/u9ySmgFzuDOJRRbuYX9WjiyHyj/PveYNKi8
 vXpQ==
X-Gm-Message-State: AOAM531MvwmTgpInJfxtZogNj9VQmC/7QICgBP9g0/FA4eY1lXgdIyd8
 DAH2AZsdD0T96mVNK1R/XFIVNQaWXO2QFU9rQPCGtk4LrIvU88vf0CxZ3XNpBNenWtNQsmtrU0J
 NYzqVImEB0DM3i8sv0TsxKjlyeMl1VPWA8OleY2FJsA==
X-Received: by 2002:a1c:c913:: with SMTP id f19mr3240853wmb.173.1596635093533; 
 Wed, 05 Aug 2020 06:44:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwflRN35X8m9gQQJIZ3vjZ5SU2XnNfJs8gjixlHntqQFa+r3w98pkq2rkqq6VjoBWUYewG77w==
X-Received: by 2002:a1c:c913:: with SMTP id f19mr3240842wmb.173.1596635093367; 
 Wed, 05 Aug 2020 06:44:53 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
 by smtp.gmail.com with ESMTPSA id
 130sm2886172wme.26.2020.08.05.06.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:44:52 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:44:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 35/38] virtio_mem: convert to LE accessors
Message-ID: <20200805134226.1106164-36-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
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

Virtio mem is modern-only. Use LE accessors for config space.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_mem.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index f26f5f64ae82..c08512fcea90 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1530,21 +1530,21 @@ static void virtio_mem_refresh_config(struct virtio_mem *vm)
 	uint64_t new_plugged_size, usable_region_size, end_addr;
 
 	/* the plugged_size is just a reflection of what _we_ did previously */
-	virtio_cread(vm->vdev, struct virtio_mem_config, plugged_size,
-		     &new_plugged_size);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, plugged_size,
+			&new_plugged_size);
 	if (WARN_ON_ONCE(new_plugged_size != vm->plugged_size))
 		vm->plugged_size = new_plugged_size;
 
 	/* calculate the last usable memory block id */
-	virtio_cread(vm->vdev, struct virtio_mem_config,
-		     usable_region_size, &usable_region_size);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config,
+			usable_region_size, &usable_region_size);
 	end_addr = vm->addr + usable_region_size;
 	end_addr = min(end_addr, phys_limit);
 	vm->last_usable_mb_id = virtio_mem_phys_to_mb_id(end_addr) - 1;
 
 	/* see if there is a request to change the size */
-	virtio_cread(vm->vdev, struct virtio_mem_config, requested_size,
-		     &vm->requested_size);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, requested_size,
+			&vm->requested_size);
 
 	dev_info(&vm->vdev->dev, "plugged size: 0x%llx", vm->plugged_size);
 	dev_info(&vm->vdev->dev, "requested size: 0x%llx", vm->requested_size);
@@ -1677,16 +1677,16 @@ static int virtio_mem_init(struct virtio_mem *vm)
 	}
 
 	/* Fetch all properties that can't change. */
-	virtio_cread(vm->vdev, struct virtio_mem_config, plugged_size,
-		     &vm->plugged_size);
-	virtio_cread(vm->vdev, struct virtio_mem_config, block_size,
-		     &vm->device_block_size);
-	virtio_cread(vm->vdev, struct virtio_mem_config, node_id,
-		     &node_id);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, plugged_size,
+			&vm->plugged_size);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, block_size,
+			&vm->device_block_size);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, node_id,
+			&node_id);
 	vm->nid = virtio_mem_translate_node_id(vm, node_id);
-	virtio_cread(vm->vdev, struct virtio_mem_config, addr, &vm->addr);
-	virtio_cread(vm->vdev, struct virtio_mem_config, region_size,
-		     &vm->region_size);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, addr, &vm->addr);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, region_size,
+			&vm->region_size);
 
 	/*
 	 * We always hotplug memory in memory block granularity. This way,
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
