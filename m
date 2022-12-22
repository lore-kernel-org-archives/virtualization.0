Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC442C4332F
	for <virtualization@archiver.kernel.org>; Thu, 22 Dec 2022 05:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D885418C6;
	Thu, 22 Dec 2022 05:01:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D885418C6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f1XqMYrS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1tYuCGCrkrP9; Thu, 22 Dec 2022 05:01:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EBE0341859;
	Thu, 22 Dec 2022 05:01:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EBE0341859
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C65A2C0071;
	Thu, 22 Dec 2022 05:01:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 680BDC0070
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 05:01:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 376E98202B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 05:01:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 376E98202B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=f1XqMYrS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LlAkW8R-wzOO
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 05:01:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2AAE482026
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2AAE482026
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 05:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671685275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGAAeJVRfD3TxjueXfmIvJPUw+3c+MyXX7u29DhUHLQ=;
 b=f1XqMYrSsmCLlPLkInw+WKNrR2tN3Ky+yiLThUzDSFTUT58XyqjmuojxFk9ZXqUCUp2yl5
 gnJWGttX+Bj8/XWuV7bSFkzkNUEtHU95115Ukz9PWMUY4hWtH+4zUGZWrsICvt1esBNV5v
 vSOgIkpTmMEhtt3d7YeXAlfc9j0IU5I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-Eq5x6eIrNWyx7vWDw-at5A-1; Thu, 22 Dec 2022 00:01:13 -0500
X-MC-Unique: Eq5x6eIrNWyx7vWDw-at5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 448C88588E0;
 Thu, 22 Dec 2022 05:01:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-15.pek2.redhat.com [10.72.13.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A68C540C2004;
 Thu, 22 Dec 2022 05:01:10 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 4/4] vdpa_sim_net: vendor satistics
Date: Thu, 22 Dec 2022 13:00:52 +0800
Message-Id: <20221222050052.20785-5-jasowang@redhat.com>
In-Reply-To: <20221222050052.20785-1-jasowang@redhat.com>
References: <20221222050052.20785-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 222 ++++++++++++++++++++++++++-
 1 file changed, 216 insertions(+), 6 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 20cd5cdff919..e0fbb739fc4d 100644
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
@@ -93,9 +122,14 @@ static virtio_net_ctrl_ack vdpasim_handle_ctrl_mac(struct vdpasim *vdpasim,
 static void vdpasim_handle_cvq(struct vdpasim *vdpasim)
 {
 	struct vdpasim_virtqueue *cvq = &vdpasim->vqs[2];
+
+
+
+	struct vdpasim_net *net = sim_to_net(vdpasim);
 	virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
 	struct virtio_net_ctrl_hdr ctrl;
 	size_t read, write;
+	u64 requests = 0, errors = 0, successes = 0;
 	int err;
 
 	if (!(vdpasim->features & (1ULL << VIRTIO_NET_F_CTRL_VQ)))
@@ -111,10 +145,13 @@ static void vdpasim_handle_cvq(struct vdpasim *vdpasim)
 		if (err <= 0)
 			break;
 
+		++requests;
 		read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->in_iov, &ctrl,
 					     sizeof(ctrl));
-		if (read != sizeof(ctrl))
+		if (read != sizeof(ctrl)) {
+			++errors;
 			break;
+		}
 
 		switch (ctrl.class) {
 		case VIRTIO_NET_CTRL_MAC:
@@ -124,6 +161,11 @@ static void vdpasim_handle_cvq(struct vdpasim *vdpasim)
 			break;
 		}
 
+		if (status == VIRTIO_NET_OK)
+			++successes;
+		else
+			++errors;
+
 		/* Make sure data is wrote before advancing index */
 		smp_wmb();
 
@@ -141,6 +183,12 @@ static void vdpasim_handle_cvq(struct vdpasim *vdpasim)
 			cvq->cb(cvq->private);
 		local_bh_enable();
 	}
+
+	u64_stats_update_begin(&net->cq_stats.syncp);
+	net->cq_stats.requests += requests;
+	net->cq_stats.errors += errors;
+	net->cq_stats.successes += successes;
+	u64_stats_update_end(&net->cq_stats.syncp);
 }
 
 static void vdpasim_net_work(struct work_struct *work)
@@ -148,8 +196,10 @@ static void vdpasim_net_work(struct work_struct *work)
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
@@ -168,14 +218,21 @@ static void vdpasim_net_work(struct work_struct *work)
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
@@ -183,19 +240,25 @@ static void vdpasim_net_work(struct work_struct *work)
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
@@ -203,6 +266,145 @@ static void vdpasim_net_work(struct work_struct *work)
 
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
@@ -239,6 +441,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 			       const struct vdpa_dev_set_config *config)
 {
 	struct vdpasim_dev_attr dev_attr = {};
+	struct vdpasim_net *net;
 	struct vdpasim *simdev;
 	int ret;
 
@@ -249,10 +452,11 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
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
@@ -265,6 +469,12 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
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
