Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF06C433F5
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 08:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4DC060EB9;
	Wed,  6 Apr 2022 08:36:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oqze-k0i_TZZ; Wed,  6 Apr 2022 08:36:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5878A60EA9;
	Wed,  6 Apr 2022 08:36:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CB5AC002C;
	Wed,  6 Apr 2022 08:36:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63F47C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 08:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60C0A4019F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 08:36:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YxLT0neCU3iZ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 08:36:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A9D4640193
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649234183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/3YhGhX98tXHPwykWkG6BkL+HnhGiXnNU5siRoG2nw4=;
 b=Tq7Y3n2szdc5maCld7Qy1iqdvdGJE6hbGCPT57kjRZHisDT2ttnjknRNILLO7OunmDtLrk
 3qYUidraaCA4TVV6evliiLZD3i0W7i6DdXxYVsyCKY/MoQXJIOJYWPJiq/ezlU2a5BhCHd
 LhOfpK0YJ9noxl5LOjiOHIrRdnq9UYo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-4tELYOGvP8ysDnXvHeBj-g-1; Wed, 06 Apr 2022 04:36:20 -0400
X-MC-Unique: 4tELYOGvP8ysDnXvHeBj-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F61B811E81;
 Wed,  6 Apr 2022 08:36:20 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-58.pek2.redhat.com [10.72.12.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1A6F112132D;
 Wed,  6 Apr 2022 08:36:10 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
Date: Wed,  6 Apr 2022 16:35:37 +0800
Message-Id: <20220406083538.16274-5-jasowang@redhat.com>
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

This patch implements PCI version of synchronize_vqs().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
 drivers/virtio/virtio_pci_common.h |  2 ++
 drivers/virtio/virtio_pci_legacy.c |  1 +
 drivers/virtio/virtio_pci_modern.c |  2 ++
 4 files changed, 19 insertions(+)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index d724f676608b..b78c8bc93a97 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
 		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
 }
 
+void vp_synchronize_vqs(struct virtio_device *vdev)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	int i;
+
+	if (vp_dev->intx_enabled) {
+		synchronize_irq(vp_dev->pci_dev->irq);
+		return;
+	}
+
+	for (i = 0; i < vp_dev->msix_vectors; ++i)
+		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
+}
+
 /* the notify function used when creating a virt queue */
 bool vp_notify(struct virtqueue *vq)
 {
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index eb17a29fc7ef..2b84d5c1b5bc 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -105,6 +105,8 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
 void vp_synchronize_vectors(struct virtio_device *vdev);
 /* the notify function used when creating a virt queue */
 bool vp_notify(struct virtqueue *vq);
+/* synchronize with callbacks */
+void vp_synchronize_vqs(struct virtio_device *vdev);
 /* the config->del_vqs() implementation */
 void vp_del_vqs(struct virtio_device *vdev);
 /* the config->find_vqs() implementation */
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 6f4e34ce96b8..5a9e62320edc 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -192,6 +192,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.reset		= vp_reset,
 	.find_vqs	= vp_find_vqs,
 	.del_vqs	= vp_del_vqs,
+	.synchronize_vqs = vp_synchronize_vqs,
 	.get_features	= vp_get_features,
 	.finalize_features = vp_finalize_features,
 	.bus_name	= vp_bus_name,
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index a2671a20ef77..584850389855 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -394,6 +394,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.reset		= vp_reset,
 	.find_vqs	= vp_modern_find_vqs,
 	.del_vqs	= vp_del_vqs,
+	.synchronize_vqs = vp_synchronize_vqs,
 	.get_features	= vp_get_features,
 	.finalize_features = vp_finalize_features,
 	.bus_name	= vp_bus_name,
@@ -411,6 +412,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.reset		= vp_reset,
 	.find_vqs	= vp_modern_find_vqs,
 	.del_vqs	= vp_del_vqs,
+	.synchronize_vqs = vp_synchronize_vqs,
 	.get_features	= vp_get_features,
 	.finalize_features = vp_finalize_features,
 	.bus_name	= vp_bus_name,
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
