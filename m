Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC5856B6A
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861760; cv=none; b=oIXikPr4zSqsj3pfwlbZAczfvEahXKibwHqMP55UcbMhxaG8Th9fRap+KVPua8McLqUh5nrzSyd72MXDgAcFj+fG5fgNkeQmQKnjpgrNZsK8W1DMIt0Gb21P7Ua76bd98IbDl+x2cxwPs9xH8TAciNkPbKi7xRWmz1PURUmjiRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861760; c=relaxed/simple;
	bh=420ieITu/mOMgWUiG5XIDKXkNpQTIIyPR7xSDcGkETs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KYy9xcgFhfKOl+dzUHISqW43Ty/UP5rRqBjHp6ZADm0XSygIhDC7wGYJRagYfYyYHwAxjZqeXn9Dgip/TQ74zd3kxHXL8w4sSUx1962fswsHO1lTdXtdZDvVShKLEqXGUs4sxce3rQ7v8zH+FM+//ZoGGdBIzt1FDvKV2572DhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZJooopv3; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZJooopv3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713861750; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ErnL2XZDXVRSR5BJwDKdTnza46FQIEIcG4s5MNDVDX4=;
	b=ZJooopv3jLCbBI6kMXsX7tg7ULARxb9P4asV8zGZY3pB0K8hXtF3VliemBd6+5HOi5EJKPXA+vwSkHnWOEFIjzpdJy9skhqYkjP11/g6Fm5g/cBA9gWh2Mgke9eIEpvADnoaneuTYmuGFp7gBmzDd2klVAG8gvAghVpEiS4Ud+8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W58Gl8W_1713861748;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W58Gl8W_1713861748)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 16:42:29 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/2] virtio_net: virtnet_send_command supports command-specific-result
Date: Tue, 23 Apr 2024 16:42:25 +0800
Message-Id: <20240423084226.25440-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240423084226.25440-1-hengqi@linux.alibaba.com>
References: <20240423084226.25440-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82

The virtnet cvq supports to get result from the device.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7176b956460b..3bc9b1e621db 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2527,11 +2527,12 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
  * supported by the hypervisor, as indicated by feature bits, should
  * never fail unless improperly formatted.
  */
-static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
-				 struct scatterlist *out)
+static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd,
+				       struct scatterlist *out,
+				       struct scatterlist *in)
 {
-	struct scatterlist *sgs[4], hdr, stat;
-	unsigned out_num = 0, tmp;
+	struct scatterlist *sgs[5], hdr, stat;
+	u32 out_num = 0, tmp, in_num = 0;
 	int ret;
 
 	/* Caller should know better */
@@ -2549,10 +2550,13 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 
 	/* Add return status. */
 	sg_init_one(&stat, &vi->ctrl->status, sizeof(vi->ctrl->status));
-	sgs[out_num] = &stat;
+	sgs[out_num + in_num++] = &stat;
 
-	BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
-	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, vi, GFP_ATOMIC);
+	if (in)
+		sgs[out_num + in_num++] = in;
+
+	BUG_ON(out_num + in_num > ARRAY_SIZE(sgs));
+	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi, GFP_ATOMIC);
 	if (ret < 0) {
 		dev_warn(&vi->vdev->dev,
 			 "Failed to add sgs for command vq: %d\n.", ret);
@@ -2574,6 +2578,12 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	return vi->ctrl->status == VIRTIO_NET_OK;
 }
 
+static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
+				 struct scatterlist *out)
+{
+	return virtnet_send_command_reply(vi, class, cmd, out, NULL);
+}
+
 static int virtnet_set_mac_address(struct net_device *dev, void *p)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-- 
2.32.0.3.g01195cf9f

