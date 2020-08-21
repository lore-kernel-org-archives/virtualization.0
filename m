Return-Path: <SRS0=P9l2=CA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47548C433DF
	for <virtualization@archiver.kernel.org>; Sat, 22 Aug 2020 01:50:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2DCB20735
	for <virtualization@archiver.kernel.org>; Sat, 22 Aug 2020 01:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DCB20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CDFFA220C1;
	Sat, 22 Aug 2020 01:50:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UL3xMgmKu-Xe; Sat, 22 Aug 2020 01:50:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E41C520449;
	Sat, 22 Aug 2020 01:50:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE9D2C0889;
	Sat, 22 Aug 2020 01:50:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B85DAC0051
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Aug 2020 01:50:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 896F4220C1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Aug 2020 01:50:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oDf+ASXIRhlT
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Aug 2020 01:50:51 +0000 (UTC)
X-Greylist: delayed 02:26:42 by SQLgrey-1.7.6
Received: from smtprelay.hostedemail.com (smtprelay0169.hostedemail.com
 [216.40.44.169])
 by silver.osuosl.org (Postfix) with ESMTPS id 4A52120449
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Aug 2020 01:50:51 +0000 (UTC)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 63DAB1801650B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 23:24:07 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id 0766F181D341E;
 Fri, 21 Aug 2020 23:24:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: game49_02002042703d
X-Filterd-Recvd-Size: 5177
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf06.hostedemail.com (Postfix) with ESMTPA;
 Fri, 21 Aug 2020 23:24:03 +0000 (UTC)
Message-ID: <32801506f274e046e329da069839ff75443b2b78.camel@perches.com>
Subject: Re: [PATCH] vdpa/mlx5: Avoid warnings about shifts on 32-bit platforms
From: Joe Perches <joe@perches.com>
To: Randy Dunlap <rdunlap@infradead.org>, Nathan Chancellor
 <natechancellor@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Eli Cohen <eli@mellanox.com>
Date: Fri, 21 Aug 2020 16:24:02 -0700
In-Reply-To: <1975c0a0-c19a-c91e-dc10-2918061cc4e7@infradead.org>
References: <20200821225018.940798-1-natechancellor@gmail.com>
 <1975c0a0-c19a-c91e-dc10-2918061cc4e7@infradead.org>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Cc: clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Fri, 2020-08-21 at 16:13 -0700, Randy Dunlap wrote:
> On 8/21/20 3:50 PM, Nathan Chancellor wrote:
> > Clang warns several times when building for 32-bit ARM along the lines
> > of:

The defines are quite horrible to read.
Maybe:
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 61 +++++++++++++++++++++++++++-----
-------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 9df69d5efe8c..62b6eec713b2 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -15,24 +15,49 @@
 
 #define to_mvdev(__vdev) container_of((__vdev), struct mlx5_vdpa_dev, vdev)
 
-#define VALID_FEATURES_MASK                                                                        \
-	(BIT(VIRTIO_NET_F_CSUM) | BIT(VIRTIO_NET_F_GUEST_CSUM) |                                   \
-	 BIT(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) | BIT(VIRTIO_NET_F_MTU) | BIT(VIRTIO_NET_F_MAC) |   \
-	 BIT(VIRTIO_NET_F_GUEST_TSO4) | BIT(VIRTIO_NET_F_GUEST_TSO6) |                             \
-	 BIT(VIRTIO_NET_F_GUEST_ECN) | BIT(VIRTIO_NET_F_GUEST_UFO) | BIT(VIRTIO_NET_F_HOST_TSO4) | \
-	 BIT(VIRTIO_NET_F_HOST_TSO6) | BIT(VIRTIO_NET_F_HOST_ECN) | BIT(VIRTIO_NET_F_HOST_UFO) |   \
-	 BIT(VIRTIO_NET_F_MRG_RXBUF) | BIT(VIRTIO_NET_F_STATUS) | BIT(VIRTIO_NET_F_CTRL_VQ) |      \
-	 BIT(VIRTIO_NET_F_CTRL_RX) | BIT(VIRTIO_NET_F_CTRL_VLAN) |                                 \
-	 BIT(VIRTIO_NET_F_CTRL_RX_EXTRA) | BIT(VIRTIO_NET_F_GUEST_ANNOUNCE) |                      \
-	 BIT(VIRTIO_NET_F_MQ) | BIT(VIRTIO_NET_F_CTRL_MAC_ADDR) | BIT(VIRTIO_NET_F_HASH_REPORT) |  \
-	 BIT(VIRTIO_NET_F_RSS) | BIT(VIRTIO_NET_F_RSC_EXT) | BIT(VIRTIO_NET_F_STANDBY) |           \
-	 BIT(VIRTIO_NET_F_SPEED_DUPLEX) | BIT(VIRTIO_F_NOTIFY_ON_EMPTY) |                          \
-	 BIT(VIRTIO_F_ANY_LAYOUT) | BIT(VIRTIO_F_VERSION_1) | BIT(VIRTIO_F_ACCESS_PLATFORM) |      \
-	 BIT(VIRTIO_F_RING_PACKED) | BIT(VIRTIO_F_ORDER_PLATFORM) | BIT(VIRTIO_F_SR_IOV))
-
-#define VALID_STATUS_MASK                                                                          \
-	(VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_DRIVER_OK |        \
-	 VIRTIO_CONFIG_S_FEATURES_OK | VIRTIO_CONFIG_S_NEEDS_RESET | VIRTIO_CONFIG_S_FAILED)
+#define VALID_FEATURES_MASK						\
+	(BIT_ULL(VIRTIO_NET_F_CSUM) |					\
+	 BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |				\
+	 BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) |			\
+	 BIT_ULL(VIRTIO_NET_F_MTU) |					\
+	 BIT_ULL(VIRTIO_NET_F_MAC) |					\
+	 BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) |				\
+	 BIT_ULL(VIRTIO_NET_F_GUEST_TSO6) |				\
+	 BIT_ULL(VIRTIO_NET_F_GUEST_ECN) |				\
+	 BIT_ULL(VIRTIO_NET_F_GUEST_UFO) |				\
+	 BIT_ULL(VIRTIO_NET_F_HOST_TSO4) |				\
+	 BIT_ULL(VIRTIO_NET_F_HOST_TSO6) |				\
+	 BIT_ULL(VIRTIO_NET_F_HOST_ECN) |				\
+	 BIT_ULL(VIRTIO_NET_F_HOST_UFO) |				\
+	 BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |				\
+	 BIT_ULL(VIRTIO_NET_F_STATUS) |					\
+	 BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |				\
+	 BIT_ULL(VIRTIO_NET_F_CTRL_RX) |				\
+	 BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |				\
+	 BIT_ULL(VIRTIO_NET_F_CTRL_RX_EXTRA) |				\
+	 BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE) |				\
+	 BIT_ULL(VIRTIO_NET_F_MQ) |					\
+	 BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |				\
+	 BIT_ULL(VIRTIO_NET_F_HASH_REPORT) |				\
+	 BIT_ULL(VIRTIO_NET_F_RSS) |					\
+	 BIT_ULL(VIRTIO_NET_F_RSC_EXT) |				\
+	 BIT_ULL(VIRTIO_NET_F_STANDBY) |				\
+	 BIT_ULL(VIRTIO_NET_F_SPEED_DUPLEX) |				\
+	 BIT_ULL(VIRTIO_F_NOTIFY_ON_EMPTY) |				\
+	 BIT_ULL(VIRTIO_F_ANY_LAYOUT) |					\
+	 BIT_ULL(VIRTIO_F_VERSION_1) |					\
+	 BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) |				\
+	 BIT_ULL(VIRTIO_F_RING_PACKED) |				\
+	 BIT_ULL(VIRTIO_F_ORDER_PLATFORM) |				\
+	 BIT_ULL(VIRTIO_F_SR_IOV))
+
+#define VALID_STATUS_MASK						\
+	(VIRTIO_CONFIG_S_ACKNOWLEDGE |					\
+	 VIRTIO_CONFIG_S_DRIVER |					\
+	 VIRTIO_CONFIG_S_DRIVER_OK |					\
+	 VIRTIO_CONFIG_S_FEATURES_OK |					\
+	 VIRTIO_CONFIG_S_NEEDS_RESET |					\
+	 VIRTIO_CONFIG_S_FAILED)
 
 struct mlx5_vdpa_net_resources {
 	u32 tisn;


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
