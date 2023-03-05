Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F26C61DA4
	for <virtualization@archiver.kernel.org>; Sun,  5 Mar 2023 15:49:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9DA974053D;
	Sun,  5 Mar 2023 15:49:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9DA974053D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=WzIHvLW3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YlTCH9tXJ3Ko; Sun,  5 Mar 2023 15:49:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E32C240503;
	Sun,  5 Mar 2023 15:49:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E32C240503
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD578C0071;
	Sun,  5 Mar 2023 15:49:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EA49C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Mar 2023 15:49:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F64160644
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Mar 2023 15:49:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F64160644
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=WzIHvLW3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wOOiHTQ5Ueq5
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Mar 2023 15:49:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A169E606FF
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A169E606FF
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Mar 2023 15:49:52 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 bg16-20020a05600c3c9000b003eb34e21bdfso6752637wmb.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Mar 2023 07:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LRSi5Bvl9ju1evxZ3BXsn8YIc0x56b4op0gZguf5otI=;
 b=WzIHvLW3VsTPXF/J1xy7AlHLM7xTSfKkGngJmaS/prSZXFoWcyisDbT8PYDi5iL3Ch
 VARShU/DyT1QWlxwzVH4RE+E8iSs2bnCXEFmFl/nu059RzW+YVQKCAUhcWbmxg0X3BJc
 t/SLzCFh6l3Ftyv+8nBz7jXTYAIgHxlluj6OPCq8EIHSuDX/3KJbMoJo1AkNol0l+52R
 CDxpZKpR62ScRTaeZFAeMaP9x6grZBtmlgyi+1/74kREA8lHl/UPyglzhFdYgTJLPBMX
 j2lYRJLh/i/X+Mw2yqdwMiaL5MLgOsrV5N//vc+D9fAlmmPbUnfL71QgsdGbufw7JlGk
 HATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LRSi5Bvl9ju1evxZ3BXsn8YIc0x56b4op0gZguf5otI=;
 b=7sGyL6zZ+vJYzrWdAn3tONR5FXdSp6TKieOZGjyHQeXAWWRxuELD3FgR5ZBjRbbGd/
 9H2Tp9IZiE/9uClSe+WHNOjB/qr0ukVgATK9TXRF/1WvgdqebdCJe2yXo/yqF6gaVrAy
 eZJQI/XuuILIDOpgzHMdA8/TiRMHJWbE25D6O3a1gj3wL8NKBqaiiMqXwnKQtqQTsVAc
 gH2Ro/an62pzmz9nToxbMjOkHT43lGyBe9tVwO0O8zMISXYC2OucJynOwRzoJEq8Nind
 SzQ8cymZEgXH8x1TZ2kDo8rfh4KB7WwcERxTpeshelb6HP0mzLLBIEok9C/9cgKxBilb
 9uNw==
X-Gm-Message-State: AO0yUKWiOIjfvpSgkrVFwU7H6D6wYvCa6QGv3l2uc0uGhILP4nW8dXOV
 FQszAHWObAnL+2FxKOo8lrxRHA==
X-Google-Smtp-Source: AK7set9r/iHAEz/eGxdl8GVFDBZKTINAY8Bc9v/muO8YAkId5A84EpF780HbjLIZYesr4PVqsKC6Gg==
X-Received: by 2002:a05:600c:a4c:b0:3dc:d5c:76d9 with SMTP id
 c12-20020a05600c0a4c00b003dc0d5c76d9mr7389089wmq.0.1678031390593; 
 Sun, 05 Mar 2023 07:49:50 -0800 (PST)
Received: from alvaro-dell.. (bzq-84-110-153-254.static-ip.bezeqint.net.
 [84.110.153.254]) by smtp.gmail.com with ESMTPSA id
 v12-20020a05600c12cc00b003de2fc8214esm7761724wmd.20.2023.03.05.07.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Mar 2023 07:49:49 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH net] virtio-net: unify notifications coalescing structs
Date: Sun,  5 Mar 2023 17:49:42 +0200
Message-Id: <20230305154942.1770925-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

Unify virtio_net_ctrl_coal_tx and virtio_net_ctrl_coal_rx structs into a
single struct, virtio_net_ctrl_coal, as they are identical.

This patch follows the VirtIO spec patch:
https://lists.oasis-open.org/archives/virtio-comment/202302/msg00431.html

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 drivers/net/virtio_net.c        | 15 +++++++--------
 include/uapi/linux/virtio_net.h | 24 +++++++-----------------
 2 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fb5e68ed3ec..86b6b3e0257 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2883,12 +2883,11 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 				       struct ethtool_coalesce *ec)
 {
 	struct scatterlist sgs_tx, sgs_rx;
-	struct virtio_net_ctrl_coal_tx coal_tx;
-	struct virtio_net_ctrl_coal_rx coal_rx;
+	struct virtio_net_ctrl_coal coal_params;
 
-	coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
-	coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
-	sg_init_one(&sgs_tx, &coal_tx, sizeof(coal_tx));
+	coal_params.max_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
+	coal_params.max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
+	sg_init_one(&sgs_tx, &coal_params, sizeof(coal_params));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_TX_SET,
@@ -2899,9 +2898,9 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 	vi->tx_usecs = ec->tx_coalesce_usecs;
 	vi->tx_max_packets = ec->tx_max_coalesced_frames;
 
-	coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
-	coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
-	sg_init_one(&sgs_rx, &coal_rx, sizeof(coal_rx));
+	coal_params.max_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
+	coal_params.max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
+	sg_init_one(&sgs_rx, &coal_params, sizeof(coal_params));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index b4062bed186..ce044260e02 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -367,28 +367,18 @@ struct virtio_net_hash_config {
  * Available with the VIRTIO_NET_F_NOTF_COAL feature bit.
  */
 #define VIRTIO_NET_CTRL_NOTF_COAL		6
-/*
- * Set the tx-usecs/tx-max-packets parameters.
- */
-struct virtio_net_ctrl_coal_tx {
-	/* Maximum number of packets to send before a TX notification */
-	__le32 tx_max_packets;
-	/* Maximum number of usecs to delay a TX notification */
-	__le32 tx_usecs;
-};
-
-#define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET		0
 
 /*
- * Set the rx-usecs/rx-max-packets parameters.
+ * Set the max_usecs/max_packets coalescing parameters for all transmit/receive virtqueues.
  */
-struct virtio_net_ctrl_coal_rx {
-	/* Maximum number of packets to receive before a RX notification */
-	__le32 rx_max_packets;
-	/* Maximum number of usecs to delay a RX notification */
-	__le32 rx_usecs;
+struct virtio_net_ctrl_coal {
+	/* Maximum number of packets to send/receive before a TX/RX notification */
+	__le32 max_packets;
+	/* Maximum number of microseconds to delay a TX/RX notification */
+	__le32 max_usecs;
 };
 
+#define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET		0
 #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET		1
 
 #endif /* _UAPI_LINUX_VIRTIO_NET_H */
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
