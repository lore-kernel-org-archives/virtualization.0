Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F6AC43381
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:19:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E6B64E24
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E6B64E24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39A016F5D2;
	Wed, 24 Feb 2021 06:19:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sj82JOo7tfql; Wed, 24 Feb 2021 06:19:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 990CB6F5C7;
	Wed, 24 Feb 2021 06:19:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 816A0C001A;
	Wed, 24 Feb 2021 06:19:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4245CC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 31DD2414ED
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:19:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xbdjp8hhPIKk
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:19:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8DAD9414F0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:19:03 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6035efd70000>; Tue, 23 Feb 2021 22:19:03 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 24 Feb 2021 06:19:02 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next 4/9] vdpa_sim_net: Enable user to set mac address
 and mtu
Date: Wed, 24 Feb 2021 08:18:39 +0200
Message-ID: <20210224061844.137776-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210224061844.137776-1-parav@nvidia.com>
References: <20210224061844.137776-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614147543; bh=vVjK5k8jxwNSiCFKFBWh7+9cOsQkC1wo8MeRR/vSXHM=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-Originating-IP:X-ClientProxiedBy;
 b=VWkMK86XhYxM1wXmI5ZWLr7aT98Vg6MorJ59S2zabv2UUX+tNSTh81fuhtdfiwP8M
 00v7MLi2SPeTungD74NSo0eD8SQkdwyQ/NWRD5tbUR+hpEum2Un3gn4SycgHldS/E6
 I3IkNBopzPiXxYxD0kYdG8PGSeE+S78NvLvTgC5OTfn65Yt/0hmpIrbGwvA/znfMEI
 Z6LzmNX+VI++SUaYxt/D8skNX1Rz0Sf8vMeq+JVxXblqlyiPYp8rodl1Kostu+Chnw
 1y7iUXhrF9+mpsRx79hIO9e8+xZGHUTuCYCWWzH4iduhLwg77xDP7hC56sje7wddUA
 gCKbmF8pL7QIQ==
Cc: Eli Cohen <elic@nvidia.com>, mst@redhat.com
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

Enable user to set the mac address and mtu so that each vdpa device
can have its own user specified mac address and mtu.
This is done by implementing the management device's configuration
layout fields setting callback routine.

Now that user is enabled to set the mac address, remove the module
parameter for same.

And example of setting mac addr and mtu:
$ vdpa mgmtdev show

$ vdpa dev add name bar mgmtdev vdpasim_net
$ vdpa dev config set bar mac 00:11:22:33:44:55 mtu 9000

View the config after setting:
$ vdpa dev config show
bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000 speed 0 duplex 0

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 39 ++++++++++++++++------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 240a5f1306b5..6e941b0e7935 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -29,12 +29,6 @@
 
 #define VDPASIM_NET_VQ_NUM	2
 
-static char *macaddr;
-module_param(macaddr, charp, 0);
-MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
-
-static u8 macaddr_buf[ETH_ALEN];
-
 static void vdpasim_net_work(struct work_struct *work)
 {
 	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
@@ -113,9 +107,7 @@ static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
 	struct virtio_net_config *net_config =
 		(struct virtio_net_config *)config;
 
-	net_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
 	net_config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
-	memcpy(net_config->mac, macaddr_buf, ETH_ALEN);
 }
 
 static void vdpasim_net_mgmtdev_release(struct device *dev)
@@ -134,6 +126,7 @@ static struct device vdpasim_net_mgmtdev_dummy = {
 
 static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
 {
+	struct virtio_net_config *cfg;
 	struct vdpasim_dev_attr dev_attr = {};
 	struct vdpasim *simdev;
 	int ret;
@@ -152,6 +145,10 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
 	if (IS_ERR(simdev))
 		return PTR_ERR(simdev);
 
+	cfg = simdev->config;
+	eth_random_addr(cfg->mac);
+	cfg->mtu = cpu_to_vdpasim16(simdev, 1500);
+
 	ret = _vdpa_register_device(&simdev->vdpa);
 	if (ret)
 		goto reg_err;
@@ -171,9 +168,25 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_dev *mdev,
 	_vdpa_unregister_device(&simdev->vdpa);
 }
 
+static int
+vdpasim_net_dev_config_set(struct vdpa_mgmt_dev *mdev,
+			   struct vdpa_device *dev,
+			   const struct vdpa_dev_config_set_attr *attrs)
+{
+	struct vdpasim *simdev = container_of(dev, struct vdpasim, vdpa);
+	struct virtio_net_config *dev_cfg = simdev->config;
+
+	if (attrs->mask.mac_valid)
+		memcpy(dev_cfg->mac, attrs->cfg.mac, sizeof(dev_cfg->mac));
+	if (attrs->mask.mtu_valid)
+		dev_cfg->mtu = cpu_to_vdpasim16(simdev, attrs->cfg.mtu);
+	return 0;
+}
+
 static const struct vdpa_mgmtdev_ops vdpasim_net_mgmtdev_ops = {
 	.dev_add = vdpasim_net_dev_add,
-	.dev_del = vdpasim_net_dev_del
+	.dev_del = vdpasim_net_dev_del,
+	.dev_config_set = vdpasim_net_dev_config_set,
 };
 
 static struct virtio_device_id id_table[] = {
@@ -198,14 +211,6 @@ static int __init vdpasim_net_init(void)
 {
 	int ret;
 
-	if (macaddr) {
-		mac_pton(macaddr, macaddr_buf);
-		if (!is_valid_ether_addr(macaddr_buf))
-			return -EADDRNOTAVAIL;
-	} else {
-		eth_random_addr(macaddr_buf);
-	}
-
 	ret = device_register(&vdpasim_net_mgmtdev);
 	if (ret)
 		return ret;
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
