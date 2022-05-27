Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA942C433EF
	for <virtualization@archiver.kernel.org>; Fri, 27 May 2022 06:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7C127412D5;
	Fri, 27 May 2022 06:01:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Yc0N9x8skVK; Fri, 27 May 2022 06:01:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 24107412D1;
	Fri, 27 May 2022 06:01:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2400C0039;
	Fri, 27 May 2022 06:01:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC232C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 06:01:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ACCEF847F6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 06:01:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4qH0LnhndCrq
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 06:01:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B033D84599
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 06:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653631313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8mYK00a7UR4B8Uf7OoMylov9T5hCzf7730+L4Uy7mis=;
 b=UPEQasYOzKpKlmAiWHymtKh48D1Wp37nxDmuLs8od5KmnvAXNAqCPW0d1QIK2lZ4Hy0xWF
 x3tu8poLHSwHD5csdWCqr76mHUnlZfCEFQzzZzSKxcD9DeoHpU7nkCtsXJHBo0LX8ZfcFh
 hstP4iXHwT18Qdmqn+QcomPgorFUs2A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-5C-lqayINPC7G6eSBY2K-A-1; Fri, 27 May 2022 02:01:49 -0400
X-MC-Unique: 5C-lqayINPC7G6eSBY2K-A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0AC562949BA6;
 Fri, 27 May 2022 06:01:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-240.pek2.redhat.com
 [10.72.13.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F09702166B26;
 Fri, 27 May 2022 06:01:40 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 2/9] virtio: use virtio_reset_device() when possible
Date: Fri, 27 May 2022 14:01:13 +0800
Message-Id: <20220527060120.20964-3-jasowang@redhat.com>
In-Reply-To: <20220527060120.20964-1-jasowang@redhat.com>
References: <20220527060120.20964-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Cc: lulu@redhat.com, paulmck@kernel.org, linux-s390@vger.kernel.org,
 peterz@infradead.org, maz@kernel.org, cohuck@redhat.com,
 Peter Oberparleiter <oberpar@linux.ibm.com>, pasic@linux.ibm.com,
 eperezma@redhat.com, Vineeth Vijayan <vneethv@linux.ibm.com>,
 tglx@linutronix.de
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

This allows us to do common extension without duplicating code.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 938e975029d4..aa1eb5132767 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -430,7 +430,7 @@ int register_virtio_device(struct virtio_device *dev)
 
 	/* We always start by resetting the device, in case a previous
 	 * driver messed it up.  This also tests that code path a little. */
-	dev->config->reset(dev);
+	virtio_reset_device(dev);
 
 	/* Acknowledge that we've seen the device. */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
@@ -496,7 +496,7 @@ int virtio_device_restore(struct virtio_device *dev)
 
 	/* We always start by resetting the device, in case a previous
 	 * driver messed it up. */
-	dev->config->reset(dev);
+	virtio_reset_device(dev);
 
 	/* Acknowledge that we've seen the device. */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
