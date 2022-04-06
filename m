Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA43C433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 08:36:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E78DE40606;
	Wed,  6 Apr 2022 08:36:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wT1ufxKginJK; Wed,  6 Apr 2022 08:36:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1381B4019F;
	Wed,  6 Apr 2022 08:36:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1430C002C;
	Wed,  6 Apr 2022 08:36:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BFD9C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 08:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EFBA04019F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 08:36:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R6_CLP-L5rb6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 08:36:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 537F440193
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 08:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649234176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9fzws/TrjvfN5TEfT4l4EkTY22qMkOTX3Nn8UDj/95g=;
 b=XS5R1g2Oi0aLmBug5gYs9O0PoqGac7Y4RXEkPhEjy8WfMrDLiv/QZAQKqwVIWfJHuucIfC
 dvrlobTuaJTY+aQq/M4Gu5vyEN2V/4mWqQu81ZuHadL05YV7S7Mb93BBE5TYi4Afy5S/Js
 HMGoAnp3oGeI8yq8R5LvdQryDYIDkaU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-dyZ8qOuZMEmmn0cZcjH-8A-1; Wed, 06 Apr 2022 04:36:11 -0400
X-MC-Unique: dyZ8qOuZMEmmn0cZcjH-8A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 901B780B71C;
 Wed,  6 Apr 2022 08:36:10 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-58.pek2.redhat.com [10.72.12.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A80A112132D;
 Wed,  6 Apr 2022 08:36:05 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 3/5] virtio: introduce config op to synchronize vring
 callbacks
Date: Wed,  6 Apr 2022 16:35:36 +0800
Message-Id: <20220406083538.16274-4-jasowang@redhat.com>
In-Reply-To: <20220406083538.16274-1-jasowang@redhat.com>
References: <20220406083538.16274-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Cc: "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
 maz@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, tglx@linutronix.de
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

This patch introduce a new virtio config ops to vring
callbacks. Transport specific method is required to call
synchornize_irq() on the IRQs. For the transport that doesn't provide
synchronize_vqs(), use synchornize_rcu() as a fallback.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/virtio_config.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index b341dd62aa4d..08b73d9bbff2 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -57,6 +57,8 @@ struct virtio_shm_region {
  *		include a NULL entry for vqs unused by driver
  *	Returns 0 on success or error status
  * @del_vqs: free virtqueues found by find_vqs().
+ * @synchronize_vqs: synchronize with the virtqueue callbacks.
+ *	vdev: the virtio_device
  * @get_features: get the array of feature bits for this device.
  *	vdev: the virtio_device
  *	Returns the first 64 feature bits (all we currently need).
@@ -89,6 +91,7 @@ struct virtio_config_ops {
 			const char * const names[], const bool *ctx,
 			struct irq_affinity *desc);
 	void (*del_vqs)(struct virtio_device *);
+	void (*synchronize_vqs)(struct virtio_device *);
 	u64 (*get_features)(struct virtio_device *vdev);
 	int (*finalize_features)(struct virtio_device *vdev);
 	const char *(*bus_name)(struct virtio_device *vdev);
@@ -217,6 +220,19 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
 				      desc);
 }
 
+/**
+ * virtio_synchronize_vqs - synchronize with virtqueue callbacks
+ * @vdev: the device
+ */
+static inline
+void virtio_synchronize_vqs(struct virtio_device *dev)
+{
+	if (dev->config->synchronize_vqs)
+		dev->config->synchronize_vqs(dev);
+	else
+		synchronize_rcu();
+}
+
 /**
  * virtio_device_ready - enable vq use in probe function
  * @vdev: the device
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
