Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF31CC433E6
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 03:32:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E0420DD4
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 03:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E0420DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7471D85E93;
	Mon,  4 Jan 2021 03:32:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hD3J_zU0_S5r; Mon,  4 Jan 2021 03:32:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D809485E5C;
	Mon,  4 Jan 2021 03:32:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBD38C1DA7;
	Mon,  4 Jan 2021 03:32:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E764C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 03:32:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2AFD58708C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 03:32:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NKcu5tPldUwB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 03:32:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A3EF08703E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 03:32:19 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5ff28c430000>; Sun, 03 Jan 2021 19:32:19 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Mon, 4 Jan 2021 03:32:18 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v2 2/7] vdpa_sim_net: Add module param to disable
 default vdpa net device
Date: Mon, 4 Jan 2021 05:31:36 +0200
Message-ID: <20210104033141.105876-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210104033141.105876-1-parav@nvidia.com>
References: <20201112064005.349268-1-parav@nvidia.com>
 <20210104033141.105876-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1609731139; bh=Mq/ykPzI3k+3JEWZA9fI1HI4hQdmUcrsKx+CN5j4kAo=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-Originating-IP:X-ClientProxiedBy;
 b=pc8HkD229BC7vBaJnF5d+8NKy+4Dgr7aWhHt2gU3JyJzDSRIBgXAXWqPhwSmmpIZS
 M1UpMYNyHshd4Rh7szkdlyS3jY1LwNhYDkUBybsT7+NPSDYFSbVtNy4eG6RLNQdRHd
 EbE+WF24lG2iWXLROxKSSlRp5njaEDr/YhiSVOWSakIOqAv/I+aMGUqAfFDPSOjZC3
 monOT1PILwB2wfT+R0U8R2+tRpkg1draNBHqAj+BGvLIYPYxfMZECN2bWyANM3P6qx
 Cd2QfacKDOZNxxncJwS2uyNW0IhSmArXArIybQyyR6taLdeyuWVr5NUL94nTUgD/jd
 q+YDcLiiOFpFA==
Cc: netdev@vger.kernel.org, elic@nvidia.com, mst@redhat.com
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

To support creating multiple vdpa devices and to allow user to
manage them, add a knob to disable a default vdpa net device.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
Changelog:
v1->v2:
 - new patch
---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 41 ++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index f0482427186b..34155831538c 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -33,6 +33,10 @@ static char *macaddr;
 module_param(macaddr, charp, 0);
 MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
 
+static bool default_device = true;
+module_param(default_device, bool, 0);
+MODULE_PARM_DESC(default_device, "Support single default VDPA device");
+
 static u8 macaddr_buf[ETH_ALEN];
 
 static struct vdpasim *vdpasim_net_dev;
@@ -120,21 +124,11 @@ static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
 	memcpy(net_config->mac, macaddr_buf, ETH_ALEN);
 }
 
-static int __init vdpasim_net_init(void)
+static int vdpasim_net_default_dev_register(void)
 {
 	struct vdpasim_dev_attr dev_attr = {};
 	int ret;
 
-	if (macaddr) {
-		mac_pton(macaddr, macaddr_buf);
-		if (!is_valid_ether_addr(macaddr_buf)) {
-			ret = -EADDRNOTAVAIL;
-			goto out;
-		}
-	} else {
-		eth_random_addr(macaddr_buf);
-	}
-
 	dev_attr.id = VIRTIO_ID_NET;
 	dev_attr.supported_features = VDPASIM_NET_FEATURES;
 	dev_attr.nvqs = VDPASIM_NET_VQ_NUM;
@@ -161,13 +155,36 @@ static int __init vdpasim_net_init(void)
 	return ret;
 }
 
-static void __exit vdpasim_net_exit(void)
+static void vdpasim_net_default_dev_unregister(void)
 {
 	struct vdpa_device *vdpa = &vdpasim_net_dev->vdpa;
 
 	vdpa_unregister_device(vdpa);
 }
 
+static int __init vdpasim_net_init(void)
+{
+	int ret = 0;
+
+	if (macaddr) {
+		mac_pton(macaddr, macaddr_buf);
+		if (!is_valid_ether_addr(macaddr_buf))
+			return -EADDRNOTAVAIL;
+	} else {
+		eth_random_addr(macaddr_buf);
+	}
+
+	if (default_device)
+		ret = vdpasim_net_default_dev_register();
+	return ret;
+}
+
+static void __exit vdpasim_net_exit(void)
+{
+	if (default_device)
+		vdpasim_net_default_dev_unregister();
+}
+
 module_init(vdpasim_net_init);
 module_exit(vdpasim_net_exit);
 
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
