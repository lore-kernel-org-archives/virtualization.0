Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF60C433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Apr 2022 02:46:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59F4640992;
	Mon, 25 Apr 2022 02:46:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zdg9_NeGbWcb; Mon, 25 Apr 2022 02:46:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B7F254086C;
	Mon, 25 Apr 2022 02:46:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CE0FC0039;
	Mon, 25 Apr 2022 02:46:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 265A5C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 02:46:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 14A5240323
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 02:46:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y-qIsgbxlGb9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 02:46:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7126B40112
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 02:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650854793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4mSFbIABjzRdSlvpdVrloyLlnqCDEpfJ/ut9z+vIsrM=;
 b=ClB1DdtgpJ84MY7qAvoD6guHVHinkXAB5tyvPuYrXzw/LPtGoYXYjHkgmoTQJNqQoedxqd
 N2BcvgPRlzq/9VH1ZDU5ZKT94qYQS2y2ia+fu9LmhZ4iekunoIWiJFPtd/5lBUO/fZT7sW
 Cx6fVHYC8MXoLexWt1cB8+1jxTWBf2E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-4Ainub48OoWr7r0QcFBmiw-1; Sun, 24 Apr 2022 22:46:30 -0400
X-MC-Unique: 4Ainub48OoWr7r0QcFBmiw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8C0F3C14100;
 Mon, 25 Apr 2022 02:46:29 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-160.pek2.redhat.com
 [10.72.13.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 436239E6E;
 Mon, 25 Apr 2022 02:46:03 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH V3 9/9] virtio: use WARN_ON() to warning illegal status value
Date: Mon, 25 Apr 2022 10:44:18 +0800
Message-Id: <20220425024418.8415-10-jasowang@redhat.com>
In-Reply-To: <20220425024418.8415-1-jasowang@redhat.com>
References: <20220425024418.8415-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Cc: lulu@redhat.com, paulmck@kernel.org, peterz@infradead.org, maz@kernel.org,
 cohuck@redhat.com, pasic@linux.ibm.com, eperezma@redhat.com,
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

We used to use BUG_ON() in virtio_device_ready() to detect illegal
status value, this seems sub-optimal since the value is under the
control of the device. Switch to use WARN_ON() instead.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/virtio_config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 3e2bc8aff51e..b0010b2ca7c2 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -254,7 +254,7 @@ void virtio_device_ready(struct virtio_device *dev)
 {
 	unsigned status = dev->config->get_status(dev);
 
-	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
+	WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
 
 	/*
 	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
