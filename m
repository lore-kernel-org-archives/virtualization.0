Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EEBC433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 14:26:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F5064DEC
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 14:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F5064DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D260886731;
	Tue, 16 Feb 2021 14:26:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iOnQfo-lzDqe; Tue, 16 Feb 2021 14:26:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 429F486AC2;
	Tue, 16 Feb 2021 14:26:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E953C0174;
	Tue, 16 Feb 2021 14:26:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1809CC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 14:26:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 14CA8851D6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 14:26:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LzQGt3C1ZGMs
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 14:26:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6B98A851CC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 14:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613485571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NsfAQuQEXLoLRBbDa4M48z/HfNRahv2joJ6WWM+PrFI=;
 b=U4PH66RuQF2wlOZ+NF/g8MoOI/HxB2NHZf4IDAs+m6lvOLRUwP5ZtQb3DIli9p90JC0Iik
 NjteymcNmzWe1vSXLCC8KSZGGdI4WDUtcLPjxJ8M1bs3ZAq2A1fiHTEoySCUEx08D9AjA/
 g/bjWUehE4jJQYCKgmDjLPeZJ0oSd/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-1PI4taZjMv6-EvsIEXcjRg-1; Tue, 16 Feb 2021 09:26:07 -0500
X-MC-Unique: 1PI4taZjMv6-EvsIEXcjRg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BE8E423C3;
 Tue, 16 Feb 2021 14:25:39 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20AA01981B;
 Tue, 16 Feb 2021 14:25:37 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH for 5.10 v2 5/5] vdpa_sim: add get_config callback in
 vdpasim_dev_attr
Date: Tue, 16 Feb 2021 15:24:39 +0100
Message-Id: <20210216142439.258713-6-sgarzare@redhat.com>
In-Reply-To: <20210216142439.258713-1-sgarzare@redhat.com>
References: <20210216142439.258713-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

commit 65b709586e222fa6ffd4166ac7fdb5d5dad113ee upstream.

The get_config callback can be used by the device to fill the
config structure.
The callback will be invoked in vdpasim_get_config() before copying
bytes into caller buffer.

Move vDPA-net config updates from vdpasim_set_features() in the
new vdpasim_net_get_config() callback.
This is safe since in vdpa_get_config() we already check that
.set_features() callback is called before .get_config().

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/r/20201215144256.155342-13-sgarzare@redhat.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Cc: <stable@vger.kernel.org> # 5.10.x
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 35 +++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index d9c494455156..f2ad450db547 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -69,9 +69,12 @@ static u64 vdpasim_features = (1ULL << VIRTIO_F_ANY_LAYOUT) |
 			      (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
 			      (1ULL << VIRTIO_NET_F_MAC);
 
+struct vdpasim;
+
 struct vdpasim_dev_attr {
 	size_t config_size;
 	int nvqs;
+	void (*get_config)(struct vdpasim *vdpasim, void *config);
 };
 
 /* State of each vdpasim device */
@@ -524,8 +527,6 @@ static u64 vdpasim_get_features(struct vdpa_device *vdpa)
 static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
-	struct virtio_net_config *config =
-		(struct virtio_net_config *)vdpasim->config;
 
 	/* DMA mapping must be done by driver */
 	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
@@ -533,16 +534,6 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
 
 	vdpasim->features = features & vdpasim_features;
 
-	/* We generally only know whether guest is using the legacy interface
-	 * here, so generally that's the earliest we can set config fields.
-	 * Note: We actually require VIRTIO_F_ACCESS_PLATFORM above which
-	 * implies VIRTIO_F_VERSION_1, but let's not try to be clever here.
-	 */
-
-	config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
-	config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
-	memcpy(config->mac, macaddr_buf, ETH_ALEN);
-
 	return 0;
 }
 
@@ -595,8 +586,13 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
-	if (offset + len < vdpasim->dev_attr.config_size)
-		memcpy(buf, vdpasim->config + offset, len);
+	if (offset + len > vdpasim->dev_attr.config_size)
+		return;
+
+	if (vdpasim->dev_attr.get_config)
+		vdpasim->dev_attr.get_config(vdpasim, vdpasim->config);
+
+	memcpy(buf, vdpasim->config + offset, len);
 }
 
 static void vdpasim_set_config(struct vdpa_device *vdpa, unsigned int offset,
@@ -739,12 +735,23 @@ static const struct vdpa_config_ops vdpasim_net_batch_config_ops = {
 	.free                   = vdpasim_free,
 };
 
+static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
+{
+	struct virtio_net_config *net_config =
+		(struct virtio_net_config *)config;
+
+	net_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
+	net_config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
+	memcpy(net_config->mac, macaddr_buf, ETH_ALEN);
+}
+
 static int __init vdpasim_dev_init(void)
 {
 	struct vdpasim_dev_attr dev_attr = {};
 
 	dev_attr.nvqs = VDPASIM_VQ_NUM;
 	dev_attr.config_size = sizeof(struct virtio_net_config);
+	dev_attr.get_config = vdpasim_net_get_config;
 
 	vdpasim_dev = vdpasim_create(&dev_attr);
 
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
