Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AD5C433EF
	for <virtualization@archiver.kernel.org>; Sat,  7 May 2022 07:20:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B688640025;
	Sat,  7 May 2022 07:20:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OIf0-_hEsuBl; Sat,  7 May 2022 07:20:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5B751405AB;
	Sat,  7 May 2022 07:20:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36EABC0039;
	Sat,  7 May 2022 07:20:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEC0AC002D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 07:20:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC97140025
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 07:20:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kWSsnK8Qg4l9
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 07:20:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ED974405AB
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 07:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651908026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HQgO42DhiTroM5cVrJbp9LPKhZMQuD4duQmjIjsdyU=;
 b=bYv3SRCj7jtpQlISCP0od8clEw/ewojiqrsZ7ZWD88cNMVMKxm9Q0gbx2wQaxICOlckZpY
 hkypzEe2emQkJ/wL5E60420w8hW/RcW2tEO9k9Wqt9pvN53mfycbJ5+bK4ndBo/spBYg6c
 O05w0ibJDyB3C5yXV4/CyFf0lwFM32o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-CnFIrtpOPsaGTmhdPQbSFw-1; Sat, 07 May 2022 03:20:23 -0400
X-MC-Unique: CnFIrtpOPsaGTmhdPQbSFw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 214C9101AA44;
 Sat,  7 May 2022 07:20:23 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-216.pek2.redhat.com
 [10.72.13.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9180940D2971;
 Sat,  7 May 2022 07:20:17 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: jasowang@redhat.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/9] virtio: introduce config op to synchronize vring
 callbacks
Date: Sat,  7 May 2022 15:19:48 +0800
Message-Id: <20220507071954.14455-4-jasowang@redhat.com>
In-Reply-To: <20220507071954.14455-1-jasowang@redhat.com>
References: <20220507071954.14455-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
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

This patch introduces new virtio config op to vring
callbacks. Transport specific method is required to make sure the
write before this function is visible to the vring_interrupt() that is
called after the return of this function. For the transport that
doesn't provide synchronize_vqs(), use synchornize_rcu() which
synchronize with IRQ implicitly as a fallback.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/virtio_config.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index b341dd62aa4d..d8a2340f928e 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -57,6 +57,11 @@ struct virtio_shm_region {
  *		include a NULL entry for vqs unused by driver
  *	Returns 0 on success or error status
  * @del_vqs: free virtqueues found by find_vqs().
+ * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
+ *      The function guarantees that all memory operations on the
+ *      queue before it are visible to the vring_interrupt() that is
+ *      called after it.
+ *      vdev: the virtio_device
  * @get_features: get the array of feature bits for this device.
  *	vdev: the virtio_device
  *	Returns the first 64 feature bits (all we currently need).
@@ -89,6 +94,7 @@ struct virtio_config_ops {
 			const char * const names[], const bool *ctx,
 			struct irq_affinity *desc);
 	void (*del_vqs)(struct virtio_device *);
+	void (*synchronize_cbs)(struct virtio_device *);
 	u64 (*get_features)(struct virtio_device *vdev);
 	int (*finalize_features)(struct virtio_device *vdev);
 	const char *(*bus_name)(struct virtio_device *vdev);
@@ -217,6 +223,25 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
 				      desc);
 }
 
+/**
+ * virtio_synchronize_cbs - synchronize with virtqueue callbacks
+ * @vdev: the device
+ */
+static inline
+void virtio_synchronize_cbs(struct virtio_device *dev)
+{
+	if (dev->config->synchronize_cbs) {
+		dev->config->synchronize_cbs(dev);
+	} else {
+		/*
+		 * A best effort fallback to synchronize with
+		 * interrupts, preemption and softirq. See comment
+		 * above synchronize_rcu().
+		 */
+		synchronize_rcu();
+	}
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
