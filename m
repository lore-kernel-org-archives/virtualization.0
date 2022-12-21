Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C385AC4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 06:17:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BF3A61006;
	Wed, 21 Dec 2022 06:17:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5BF3A61006
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IwHmzrZR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NWghxfYDQqKV; Wed, 21 Dec 2022 06:17:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A4C6F6101B;
	Wed, 21 Dec 2022 06:17:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A4C6F6101B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BA69C007C;
	Wed, 21 Dec 2022 06:17:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A91A3C007F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:17:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5C94140B25
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:17:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C94140B25
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IwHmzrZR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FRniilU10EYw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:17:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B4E7400D1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5B4E7400D1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671603434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qpSCk6/IKUVw3CgEVGoaTdSKSFUxagfxIV790+FKSD4=;
 b=IwHmzrZRy4ERSdZQ/4vNbkT60stFTReIofQHHSwWk7nhoxuT93fZPE8rJH352AtCXqlZnZ
 NkdfabbTXxQKvJK7SmUyN8NRqzRUgkoG8BZ3Y4NB4jIl7nrkhNy6RGFgfMQO1bTBfzgQGM
 RQrHpm0mN3SYAjHYjnTEhT9Q2jjt6nw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-AVJEbaEhNBm8hlaX78LLig-1; Wed, 21 Dec 2022 01:17:12 -0500
X-MC-Unique: AVJEbaEhNBm8hlaX78LLig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A351886461;
 Wed, 21 Dec 2022 06:17:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-236.pek2.redhat.com
 [10.72.13.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4F222166B26;
 Wed, 21 Dec 2022 06:17:09 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 4/4] vdpa_sim_net: vendor satistics
Date: Wed, 21 Dec 2022 14:16:52 +0800
Message-Id: <20221221061652.15202-5-jasowang@redhat.com>
In-Reply-To: <20221221061652.15202-1-jasowang@redhat.com>
References: <20221221061652.15202-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

This patch adds support for basic vendor stats that include counters
for tx, rx and cvq.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c     |   2 +
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 215 ++++++++++++++++++++++++++-
 2 files changed, 211 insertions(+), 6 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 02e892f819e7..595d9d5a372f 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -755,8 +755,10 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.set_vq_cb              = vdpasim_set_vq_cb,
 	.set_vq_ready           = vdpasim_set_vq_ready,
 	.get_vq_ready           = vdpasim_get_vq_ready,
+	.get_vendor_vq_stats    = vdpasim_get_vq_stats,
 	.set_vq_state           = vdpasim_set_vq_state,
 	.get_vq_state           = vdpasim_get_vq_state,
+	.get_vendor_vq_stats    = vdpasim_get_vq_stats,
 	.get_vq_align           = vdpasim_get_vq_align,
 	.get_vq_group           = vdpasim_get_vq_group,
 	.get_device_features    = vdpasim_get_device_features,
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 20cd5cdff919..3c05e932d90d 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -15,6 +15,7 @@
 #include <linux/etherdevice.h>
 #include <linux/vringh.h>
 #include <linux/vdpa.h>
+#include <net/netlink.h>
 #include <uapi/linux/virtio_net.h>
 #include <uapi/linux/vdpa.h>
 
@@ -36,6 +37,34 @@
 #define VDPASIM_NET_AS_NUM	2
 #define VDPASIM_NET_GROUP_NUM	2
 
+struct vdpasim_dataq_stats {
+	struct u64_stats_sync syncp;
+	u64 pkts;
+	u64 bytes;
+	u64 drops;
+	u64 errors;
+	u64 overruns;
+};
+
+struct vdpasim_cq_stats {
+	struct u64_stats_sync syncp;
+	u64 requests;
+	u64 successes;
+	u64 errors;
+};
+
+struct vdpasim_net{
+	struct vdpasim vdpasim;
+	struct vdpasim_dataq_stats tx_stats;
+	struct vdpasim_dataq_stats rx_stats;
+	struct vdpasim_cq_stats cq_stats;
+};
+
+static struct vdpasim_net *sim_to_net(struct vdpasim *vdpasim)
+{
+	return container_of(vdpasim, struct vdpasim_net, vdpasim);
+}
+
 static void vdpasim_net_complete(struct vdpasim_virtqueue *vq, size_t len)
 {
 	/* Make sure data is wrote before advancing index */
@@ -93,9 +122,11 @@ static virtio_net_ctrl_ack vdpasim_handle_ctrl_mac(struct vdpasim *vdpasim,
 static void vdpasim_handle_cvq(struct vdpasim *vdpasim)
 {
 	struct vdpasim_virtqueue *cvq = &vdpasim->vqs[2];
+	struct vdpasim_net *net = sim_to_net(vdpasim);
 	virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
 	struct virtio_net_ctrl_hdr ctrl;
 	size_t read, write;
+	u64 requests = 0, errors = 0;
 	int err;
 
 	if (!(vdpasim->features & (1ULL << VIRTIO_NET_F_CTRL_VQ)))
@@ -113,8 +144,12 @@ static void vdpasim_handle_cvq(struct vdpasim *vdpasim)
 
 		read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->in_iov, &ctrl,
 					     sizeof(ctrl));
-		if (read != sizeof(ctrl))
+		if (read != sizeof(ctrl)) {
+			++errors;
 			break;
+		}
+
+		++requests;
 
 		switch (ctrl.class) {
 		case VIRTIO_NET_CTRL_MAC:
@@ -141,6 +176,12 @@ static void vdpasim_handle_cvq(struct vdpasim *vdpasim)
 			cvq->cb(cvq->private);
 		local_bh_enable();
 	}
+
+	u64_stats_update_begin(&net->cq_stats.syncp);
+	net->cq_stats.requests += requests;
+	net->cq_stats.errors += errors;
+	net->cq_stats.successes += requests;
+	u64_stats_update_end(&net->cq_stats.syncp);
 }
 
 static void vdpasim_net_work(struct work_struct *work)
@@ -148,8 +189,10 @@ static void vdpasim_net_work(struct work_struct *work)
 	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
 	struct vdpasim_virtqueue *txq = &vdpasim->vqs[1];
 	struct vdpasim_virtqueue *rxq = &vdpasim->vqs[0];
+	struct vdpasim_net *net = sim_to_net(vdpasim);
 	ssize_t read, write;
-	int pkts = 0;
+	u64 tx_pkts = 0, rx_pkts = 0, tx_bytes = 0, rx_bytes = 0;
+	u64 rx_drops = 0, rx_overruns = 0, rx_errors = 0, tx_errors = 0;
 	int err;
 
 	spin_lock(&vdpasim->lock);
@@ -168,14 +211,21 @@ static void vdpasim_net_work(struct work_struct *work)
 	while (true) {
 		err = vringh_getdesc_iotlb(&txq->vring, &txq->out_iov, NULL,
 					   &txq->head, GFP_ATOMIC);
-		if (err <= 0)
+		if (err <= 0) {
+			if (err)
+				++tx_errors;
 			break;
+		}
 
+		++tx_pkts;
 		read = vringh_iov_pull_iotlb(&txq->vring, &txq->out_iov,
 					     vdpasim->buffer,
 					     PAGE_SIZE);
 
+		tx_bytes += read;
+
 		if (!receive_filter(vdpasim, read)) {
+			++rx_drops;
 			vdpasim_net_complete(txq, 0);
 			continue;
 		}
@@ -183,19 +233,25 @@ static void vdpasim_net_work(struct work_struct *work)
 		err = vringh_getdesc_iotlb(&rxq->vring, NULL, &rxq->in_iov,
 					   &rxq->head, GFP_ATOMIC);
 		if (err <= 0) {
+			++rx_overruns;
 			vdpasim_net_complete(txq, 0);
 			break;
 		}
 
 		write = vringh_iov_push_iotlb(&rxq->vring, &rxq->in_iov,
 					      vdpasim->buffer, read);
-		if (write <= 0)
+		if (write <= 0) {
+			++rx_errors;
 			break;
+		}
+
+		++rx_pkts;
+		rx_bytes += write;
 
 		vdpasim_net_complete(txq, 0);
 		vdpasim_net_complete(rxq, write);
 
-		if (++pkts > 4) {
+		if (tx_pkts > 4) {
 			schedule_work(&vdpasim->work);
 			goto out;
 		}
@@ -203,6 +259,145 @@ static void vdpasim_net_work(struct work_struct *work)
 
 out:
 	spin_unlock(&vdpasim->lock);
+
+	u64_stats_update_begin(&net->tx_stats.syncp);
+	net->tx_stats.pkts += tx_pkts;
+	net->tx_stats.bytes += tx_bytes;
+	net->tx_stats.errors += tx_errors;
+	u64_stats_update_end(&net->tx_stats.syncp);
+
+	u64_stats_update_begin(&net->rx_stats.syncp);
+	net->rx_stats.pkts += rx_pkts;
+	net->rx_stats.bytes += rx_bytes;
+	net->rx_stats.drops += rx_drops;
+	net->rx_stats.errors += rx_errors;
+	net->rx_stats.overruns += rx_overruns;
+	u64_stats_update_end(&net->rx_stats.syncp);
+}
+
+static int vdpasim_net_get_stats(struct vdpasim *vdpasim, u16 idx,
+				 struct sk_buff *msg,
+				 struct netlink_ext_ack *extack)
+{
+	struct vdpasim_net *net = sim_to_net(vdpasim);
+	u64 rx_pkts, rx_bytes, rx_errors, rx_overruns, rx_drops;
+	u64 tx_pkts, tx_bytes, tx_errors, tx_drops;
+	u64 cq_requests, cq_successes, cq_errors;
+	unsigned int start;
+	int err = -EMSGSIZE;
+
+	switch(idx) {
+	case 0:
+		do {
+			start = u64_stats_fetch_begin(&net->rx_stats.syncp);
+			rx_pkts = net->rx_stats.pkts;
+			rx_bytes = net->rx_stats.bytes;
+			rx_errors = net->rx_stats.errors;
+			rx_overruns = net->rx_stats.overruns;
+			rx_drops = net->rx_stats.drops;
+		} while (u64_stats_fetch_retry(&net->rx_stats.syncp, start));
+
+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
+					"rx packets"))
+			break;
+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
+				      rx_pkts, VDPA_ATTR_PAD))
+			break;
+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
+				  "rx bytes"))
+			break;
+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
+				      rx_bytes, VDPA_ATTR_PAD))
+			break;
+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
+				  "rx errors"))
+			break;
+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
+				      rx_errors, VDPA_ATTR_PAD))
+			break;
+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
+				  "rx overrunss"))
+			break;
+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
+				      rx_overruns, VDPA_ATTR_PAD))
+			break;
+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
+				  "rx drops"))
+			break;
+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
+				      rx_drops, VDPA_ATTR_PAD))
+			break;
+		err = 0;
+		break;
+	case 1:
+		do {
+			start = u64_stats_fetch_begin(&net->tx_stats.syncp);
+			tx_pkts = net->tx_stats.pkts;
+			tx_bytes = net->tx_stats.bytes;
+			tx_errors = net->tx_stats.errors;
+			tx_drops = net->tx_stats.drops;
+		} while (u64_stats_fetch_retry(&net->tx_stats.syncp, start));
+
+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
+				  "tx packets"))
+			break;
+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
+				      tx_pkts, VDPA_ATTR_PAD))
+			break;
+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
+				  "tx bytes"))
+			break;
+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
+				      tx_bytes, VDPA_ATTR_PAD))
+			break;
+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
+				  "tx errors"))
+			break;
+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
+				      tx_errors, VDPA_ATTR_PAD))
+			break;
+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
+				  "tx drops"))
+			break;
+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
+				      tx_drops, VDPA_ATTR_PAD))
+			break;
+		err = 0;
+		break;
+	case 2:
+		do {
+			start = u64_stats_fetch_begin(&net->cq_stats.syncp);
+			cq_requests = net->cq_stats.requests;
+			cq_successes = net->cq_stats.successes;
+			cq_errors = net->cq_stats.errors;
+		} while (u64_stats_fetch_retry(&net->cq_stats.syncp, start));
+
+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
+				  "cvq requests"))
+			break;
+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
+				      cq_requests, VDPA_ATTR_PAD))
+			break;
+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
+				  "cvq successes"))
+			break;
+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
+				      cq_successes, VDPA_ATTR_PAD))
+			break;
+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
+				  "cvq errors"))
+			break;
+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
+				      cq_errors, VDPA_ATTR_PAD))
+			break;
+		err = 0;
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+
+	return err;
 }
 
 static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
@@ -239,6 +434,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 			       const struct vdpa_dev_set_config *config)
 {
 	struct vdpasim_dev_attr dev_attr = {};
+	struct vdpasim_net *net;
 	struct vdpasim *simdev;
 	int ret;
 
@@ -249,10 +445,11 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	dev_attr.nvqs = VDPASIM_NET_VQ_NUM;
 	dev_attr.ngroups = VDPASIM_NET_GROUP_NUM;
 	dev_attr.nas = VDPASIM_NET_AS_NUM;
-	dev_attr.alloc_size = sizeof(struct vdpasim);
+	dev_attr.alloc_size = sizeof(struct vdpasim_net);
 	dev_attr.config_size = sizeof(struct virtio_net_config);
 	dev_attr.get_config = vdpasim_net_get_config;
 	dev_attr.work_fn = vdpasim_net_work;
+	dev_attr.get_stats = vdpasim_net_get_stats;
 	dev_attr.buffer_size = PAGE_SIZE;
 
 	simdev = vdpasim_create(&dev_attr, config);
@@ -265,6 +462,12 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	if (ret)
 		goto reg_err;
 
+	net = sim_to_net(simdev);
+
+	u64_stats_init(&net->tx_stats.syncp);
+	u64_stats_init(&net->rx_stats.syncp);
+	u64_stats_init(&net->cq_stats.syncp);
+
 	return 0;
 
 reg_err:
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
