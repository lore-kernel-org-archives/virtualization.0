Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73092C77B6E
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 09:29:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10BE2418F3;
	Tue, 28 Mar 2023 09:29:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 10BE2418F3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ES_gpkx8kT35; Tue, 28 Mar 2023 09:29:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1BC81418F0;
	Tue, 28 Mar 2023 09:29:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1BC81418F0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6087AC008B;
	Tue, 28 Mar 2023 09:29:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED121C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D6C9D82255
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:29:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D6C9D82255
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VuAHccv705Vq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:29:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB4EE81B83
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB4EE81B83
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:28:59 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VesYnUJ_1679995734; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VesYnUJ_1679995734) by smtp.aliyun-inc.com;
 Tue, 28 Mar 2023 17:28:55 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH 06/16] virtio_net: separate virtnet_ctrl_set_mac_address()
Date: Tue, 28 Mar 2023 17:28:37 +0800
Message-Id: <20230328092847.91643-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
References: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: e880b402863c
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

Separating the code setting MAC by cq to a function.

This is to facilitate separating cq-related functions into a separate
file.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/virtnet.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio/virtnet.c b/drivers/net/virtio/virtnet.c
index 0196492f289b..6ad217af44d9 100644
--- a/drivers/net/virtio/virtnet.c
+++ b/drivers/net/virtio/virtnet.c
@@ -1982,13 +1982,29 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	return vi->ctrl->status == VIRTIO_NET_OK;
 }
 
+static int virtnet_ctrl_set_mac_address(struct virtnet_info *vi, const void *addr, int len)
+{
+	struct virtio_device *vdev = vi->vdev;
+	struct scatterlist sg;
+
+	sg_init_one(&sg, addr, len);
+
+	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
+				  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
+		dev_warn(&vdev->dev,
+			 "Failed to set mac address by vq command.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int virtnet_set_mac_address(struct net_device *dev, void *p)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct virtio_device *vdev = vi->vdev;
 	int ret;
 	struct sockaddr *addr;
-	struct scatterlist sg;
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STANDBY))
 		return -EOPNOTSUPP;
@@ -2002,11 +2018,7 @@ static int virtnet_set_mac_address(struct net_device *dev, void *p)
 		goto out;
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
-		sg_init_one(&sg, addr->sa_data, dev->addr_len);
-		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
-					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
-			dev_warn(&vdev->dev,
-				 "Failed to set mac address by vq command.\n");
+		if (virtnet_ctrl_set_mac_address(vi, addr->sa_data, dev->addr_len)) {
 			ret = -EINVAL;
 			goto out;
 		}
@@ -3822,12 +3834,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	 */
 	if (!virtio_has_feature(vdev, VIRTIO_NET_F_MAC) &&
 	    virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
-		struct scatterlist sg;
-
-		sg_init_one(&sg, dev->dev_addr, dev->addr_len);
-		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
-					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
-			pr_debug("virtio_net: setting MAC address failed\n");
+		if (virtnet_ctrl_set_mac_address(vi, dev->dev_addr, dev->addr_len)) {
 			rtnl_unlock();
 			err = -EINVAL;
 			goto free_unregister_netdev;
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
