Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBB81AE017
	for <virtualization@lists.linux.dev>; Mon,  4 Nov 2024 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710638; cv=none; b=c1apXKfII84AUAy8BxeyA4RspMtceu5u3eFSekVtyYYNFJURxfcdMFfX0zTNV7fWJbRtVRzzrkbPg5n4hPEOg2hZPeuizXTxqRz77TpeT+j/3V5Ss22lyHmN2mol4nt2hTzqxy2Zw9Eyf2nolTI6UlQcnJ3L0qTV8zXlVlpyN8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710638; c=relaxed/simple;
	bh=V0vrMzecjWvIpMgfph0nBk8GvqOF2Yh7vCTbp9INH8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uJSqHyzDtThaTXx6YsJTTqrBrzlVZsuHoB8lrptCOKQcZGCDvcRCNAl6z0/t0NmFmzIYvJF36y6OTW0fN2oSGdS6fL7Amb/RiB+8FGVSiectT+eZTKi2Gq2QcP57jV9eIIN5AIo/DzxP6wOJJsre+nFHpn8lF1qed3yzon1aFeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZOWnFvD+; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZOWnFvD+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730710628; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lnK0M8sGNi7Ztg3Tp3oZ1uuQpBKHXJRvIdF7FPbRKQ0=;
	b=ZOWnFvD+wmZb1T8oMvx2HXFchIY8MS9jV24REYRvLTqbe/+mqKx/dZ8H5jsVlJt/wDkMQr63fTXjc9uiA2+8IxKliS/JGsIkO8uTWGUbN5wlRQxdp8kD8J0+imVkQsyYqTnYrRCQjn2x+NWF8V6fK6++rHlKZEMKuFlOc5tkLu0=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WIdoIds_1730710627 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 16:57:08 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@daynix.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/4] virtio_net: Support dynamic rss indirection table size
Date: Mon,  4 Nov 2024 16:57:03 +0800
Message-Id: <20241104085706.13872-2-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241104085706.13872-1-lulie@linux.alibaba.com>
References: <20241104085706.13872-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading/writing virtio_net_ctrl_rss, we get the indirection table
size from vi->rss_indir_table_size, which is initialized in
virtnet_probe(). However, the actual size of indirection_table was set
as VIRTIO_NET_RSS_MAX_TABLE_LEN=128. This collision may cause issues if
the vi->rss_indir_table_size exceeds 128.

This patch instead uses dynamic indirection table, allocated with
vi->rss after vi->rss_indir_table_size initialized. And free it in
virtnet_remove().

In virtnet_commit_rss_command(), sgs for rss is initialized differently
with hash_report. So indirection_table is not used if !vi->has_rss, and
then we don't need to alloc indirection_table for hash_report only uses.

Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 869586c17ffd..75c1ff4efd13 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -368,15 +368,16 @@ struct receive_queue {
  * because table sizes may be differ according to the device configuration.
  */
 #define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
-#define VIRTIO_NET_RSS_MAX_TABLE_LEN    128
 struct virtio_net_ctrl_rss {
 	u32 hash_types;
 	u16 indirection_table_mask;
 	u16 unclassified_queue;
-	u16 indirection_table[VIRTIO_NET_RSS_MAX_TABLE_LEN];
+	u16 hash_cfg_reserved; /* for HASH_CONFIG (see virtio_net_hash_config for details) */
 	u16 max_tx_vq;
 	u8 hash_key_length;
 	u8 key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
+
+	u16 *indirection_table;
 };
 
 /* Control VQ buffers: protected by the rtnl lock */
@@ -512,6 +513,25 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
 					       struct page *page, void *buf,
 					       int len, int truesize);
 
+static int rss_indirection_table_alloc(struct virtio_net_ctrl_rss *rss, u16 indir_table_size)
+{
+	if (!indir_table_size) {
+		rss->indirection_table = NULL;
+		return 0;
+	}
+
+	rss->indirection_table = kmalloc_array(indir_table_size, sizeof(u16), GFP_KERNEL);
+	if (!rss->indirection_table)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void rss_indirection_table_free(struct virtio_net_ctrl_rss *rss)
+{
+	kfree(rss->indirection_table);
+}
+
 static bool is_xdp_frame(void *ptr)
 {
 	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
@@ -3828,11 +3848,15 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 	/* prepare sgs */
 	sg_init_table(sgs, 4);
 
-	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, indirection_table);
+	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, hash_cfg_reserved);
 	sg_set_buf(&sgs[0], &vi->rss, sg_buf_size);
 
-	sg_buf_size = sizeof(uint16_t) * (vi->rss.indirection_table_mask + 1);
-	sg_set_buf(&sgs[1], vi->rss.indirection_table, sg_buf_size);
+	if (vi->has_rss) {
+		sg_buf_size = sizeof(uint16_t) * vi->rss_indir_table_size;
+		sg_set_buf(&sgs[1], vi->rss.indirection_table, sg_buf_size);
+	} else {
+		sg_set_buf(&sgs[1], &vi->rss.hash_cfg_reserved, sizeof(uint16_t));
+	}
 
 	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, key)
 			- offsetof(struct virtio_net_ctrl_rss, max_tx_vq);
@@ -6420,6 +6444,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
 				rss_max_indirection_table_length));
 	}
+	err = rss_indirection_table_alloc(&vi->rss, vi->rss_indir_table_size);
+	if (err)
+		goto free;
 
 	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_key_size =
@@ -6674,6 +6701,8 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	remove_vq_common(vi);
 
+	rss_indirection_table_free(&vi->rss);
+
 	free_netdev(vi->dev);
 }
 
-- 
2.32.0.3.g01195cf9f

