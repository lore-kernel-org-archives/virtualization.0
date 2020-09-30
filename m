Return-Path: <SRS0=Q6Zn=DH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D66DC4727C
	for <virtualization@archiver.kernel.org>; Wed, 30 Sep 2020 02:05:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E105E20773
	for <virtualization@archiver.kernel.org>; Wed, 30 Sep 2020 02:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfEZt0Es"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E105E20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E2F88204B3;
	Wed, 30 Sep 2020 02:05:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SeYdZda5D9ie; Wed, 30 Sep 2020 02:05:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B392E2046B;
	Wed, 30 Sep 2020 02:05:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96CD5C016F;
	Wed, 30 Sep 2020 02:05:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDEB7C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 02:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D4EC086090
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 02:05:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ijKtdNjm1WqX
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 02:05:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8D04886084
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 02:05:52 +0000 (UTC)
Received: by mail-oi1-f194.google.com with SMTP id u126so7783423oif.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 19:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=T0BMwdFvGafs3VXiDpg3UXiEW7pVRzc87P0d5q2TBSw=;
 b=rfEZt0EsfLeVlfr9Y0EFVsMkwVoZFtSaiWgPoSMR5Dys3AV0XJL8/J1SfbklZQVJO1
 4zLaaNyWrlO/LRAvMA783bjwht+c7XqGXmvbNW6MKrdaLJqiHV/YNGF+/PH+5Dj5uo3J
 74P3n7Aj+Ujms6lYPMC0Ifw9/L5QKSxCfZhnAbCFtflQ6vj5LUqdLjIzzVteJlg+Ccv3
 B+2ZAclsEFM+pYbHpmtnufGceNqajMB9KkKghdAJqBHhNbNKtH6lquHUI4FwoVb6M7hR
 QaqiV3RSt76Y4erhWW0bk/IuvHaS4zXP+ZSrfGXnuq0+I4rQRV1emyMdnf5XHsfGWsdi
 p6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=T0BMwdFvGafs3VXiDpg3UXiEW7pVRzc87P0d5q2TBSw=;
 b=EwY0gLfPydmhkNkydM33h/nRLpYUpGYYHBktZy6HCF9fyzBfKzPkjCcTVkFNtjwOZi
 btOKL9Vl6Yadz1bNYfVucgCqNWozNnpptnBwT0EitlILlWbhMn8iVybahZ+9dItAbSiH
 szWkra3TxaaDiO4F583g5AT390djtz4CkmCoJ9tiZlpE94GhIqHkaNUPVEdq3NQo/cb7
 hyjpqCIN08kghsxU2V4SonJ/2ecyCeWGr5rl7C2HGH8J+AAiWEMqp7357C57EHF5AzWT
 mY0PRaeCIhooA8WleJGaArjQ5FcVYc8QB0yMZIpTZjFs9KUicm1dmGMKRMp1gGVHcC5P
 eVjA==
X-Gm-Message-State: AOAM532xDh3uTZNHMR1h0xmSB1pvNQSG7aes2+dn4r+jC6IgG1LM2SLI
 KD9KeOiI3gyR1WrZzi2m5Rg=
X-Google-Smtp-Source: ABdhPJwDBP1sGpK+4M36t3OTguXYgxpsLNwX0xpGzwSB2+d7eRx4I7S1neyDWbXiG5hKIHBhmo0m5g==
X-Received: by 2002:aca:913:: with SMTP id 19mr189541oij.169.1601431551697;
 Tue, 29 Sep 2020 19:05:51 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
 by smtp.gmail.com with ESMTPSA id n186sm28043oob.11.2020.09.29.19.05.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Sep 2020 19:05:50 -0700 (PDT)
From: xiangxia.m.yue@gmail.com
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [PATCH net-next v2] virtio-net: ethtool configurable RXCSUM
Date: Wed, 30 Sep 2020 10:03:00 +0800
Message-Id: <20200930020300.62245-1-xiangxia.m.yue@gmail.com>
X-Mailer: git-send-email 2.15.0
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

Allow user configuring RXCSUM separately with ethtool -K,
reusing the existing virtnet_set_guest_offloads helper
that configures RXCSUM for XDP. This is conditional on
VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.

If Rx checksum is disabled, LRO should also be disabled.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
---
v2:
* LRO depends the rx csum
* remove the unnecessary check
---
 drivers/net/virtio_net.c | 49 ++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 21b71148c532..5407a0106771 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -68,6 +68,8 @@ static const unsigned long guest_offloads[] = {
 				(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
 				(1ULL << VIRTIO_NET_F_GUEST_UFO))
 
+#define GUEST_OFFLOAD_CSUM_MASK (1ULL << VIRTIO_NET_F_GUEST_CSUM)
+
 struct virtnet_stat_desc {
 	char desc[ETH_GSTRING_LEN];
 	size_t offset;
@@ -2522,29 +2524,49 @@ static int virtnet_get_phys_port_name(struct net_device *dev, char *buf,
 	return 0;
 }
 
+static netdev_features_t virtnet_fix_features(struct net_device *netdev,
+					      netdev_features_t features)
+{
+	/* If Rx checksum is disabled, LRO should also be disabled.
+	 * That is life. :)
+	 */
+	if (!(features & NETIF_F_RXCSUM))
+		features &= ~NETIF_F_LRO;
+
+	return features;
+}
+
 static int virtnet_set_features(struct net_device *dev,
 				netdev_features_t features)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	u64 offloads;
+	u64 offloads = vi->guest_offloads &
+		       vi->guest_offloads_capable;
 	int err;
 
-	if ((dev->features ^ features) & NETIF_F_LRO) {
-		if (vi->xdp_queue_pairs)
-			return -EBUSY;
+	/* Don't allow configuration while XDP is active. */
+	if (vi->xdp_queue_pairs)
+		return -EBUSY;
 
+	if ((dev->features ^ features) & NETIF_F_LRO) {
 		if (features & NETIF_F_LRO)
-			offloads = vi->guest_offloads_capable;
+			offloads |= GUEST_OFFLOAD_LRO_MASK;
 		else
-			offloads = vi->guest_offloads_capable &
-				   ~GUEST_OFFLOAD_LRO_MASK;
+			offloads &= ~GUEST_OFFLOAD_LRO_MASK;
+	}
 
-		err = virtnet_set_guest_offloads(vi, offloads);
-		if (err)
-			return err;
-		vi->guest_offloads = offloads;
+	if ((dev->features ^ features) & NETIF_F_RXCSUM) {
+		if (features & NETIF_F_RXCSUM)
+			offloads |= GUEST_OFFLOAD_CSUM_MASK;
+		else
+			offloads &= ~GUEST_OFFLOAD_CSUM_MASK;
 	}
 
+	err = virtnet_set_guest_offloads(vi, offloads);
+	if (err)
+		return err;
+
+	vi->guest_offloads = offloads;
 	return 0;
 }
 
@@ -2563,6 +2585,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_features_check	= passthru_features_check,
 	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
 	.ndo_set_features	= virtnet_set_features,
+	.ndo_fix_features	= virtnet_fix_features,
 };
 
 static void virtnet_config_changed_work(struct work_struct *work)
@@ -3013,8 +3036,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
 		dev->features |= NETIF_F_LRO;
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
+		dev->hw_features |= NETIF_F_RXCSUM;
 		dev->hw_features |= NETIF_F_LRO;
+	}
 
 	dev->vlan_features = dev->features;
 
-- 
2.23.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
