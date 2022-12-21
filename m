Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232E1C4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 12:06:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E65640B75;
	Wed, 21 Dec 2022 12:06:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E65640B75
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=IEVuxoUa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JbroGYUYPhEW; Wed, 21 Dec 2022 12:06:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 31B4740B59;
	Wed, 21 Dec 2022 12:06:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 31B4740B59
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D332BC0071;
	Wed, 21 Dec 2022 12:06:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0ECF5C0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 12:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A300340B75
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 12:06:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A300340B75
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cSOPuKxoF5mm
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 12:06:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1FB6140B59
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1FB6140B59
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 12:06:24 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id m19so10980687wms.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 04:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aK+harKFdh05j7ikUbsUL9aBNPAUblg48ttg0Rk1PY0=;
 b=IEVuxoUap2KilZ+w1fxmOQtAeVzY82k+84OlD6p3sdYWVhvtl+JrA8hIBYpyoaX8uY
 qdbg8yYRVY/avh7iOGf3ZJYwXYpMeOW6BE36hINj3oXhR0ifgPKBQqYCRbJzj6C4p70b
 50O8gTPNsAed4ijZJSCclUl+RB0VHZDcErLJGTRq6aXnk9D+/NoXkWxSQRVYUrKWt0Er
 PzTaCdv3eP+I6mNsmMeTS5N7udle4qqQGE7kMLjBdMgZUPuWhIZzTNESt/J/JlS33p2L
 hDC7941sBhFh9JZjUTgvKwQg7ae0B9FxlWAtWrvqEPOJRs4BWN0GZpSYxJDqDXMG2/+j
 cgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aK+harKFdh05j7ikUbsUL9aBNPAUblg48ttg0Rk1PY0=;
 b=pA9IO2vNEL/qFWDPYwXzzgikhhOUpsUxd7cpycw+dUZ7Igqg9sFT/5cLsAY6lcgbXv
 hSbyehyhSzCtyb3H6ZPA9upDI/6sMIOlQRTNsZJvcPpGvTll8G4p9EcyhDBi4YfkyYSG
 kj9/oMWjaw+gQpbhpeJfd+UHGBwqbNqv1iPBHHS9Aw3GB4vP2gTLBowFdW2tqQjzrwKC
 xyQQu60T8a1bywTnchHKdgoOsHPGSfh0QGZa7tx83IJUL8zlPGo801TqSCnTk5ZrUMqx
 ZN1R9eVn47R00LW8hcATDQ3C6jzEPpTXFdNgFqan5SBgfNurJ3wDAIKLJkcd4S05WT3K
 sPHg==
X-Gm-Message-State: AFqh2kqiTaWEooqnTKP6qLFeoqhgz4SNkkrCb01fUJY9EsJ7Xezhkj45
 33MRAUwPc3U0shNWB6R2GELtfO20V3MQxD/s/PE=
X-Google-Smtp-Source: AMrXdXvBSiQ4tAsA58ZmJ3PR3kRIyMor2XrvlGzrcNCf5mS9vAReIO1EeuyEqqJlszY260oiHhZA8Q==
X-Received: by 2002:a05:600c:1e18:b0:3d2:5e4e:701 with SMTP id
 ay24-20020a05600c1e1800b003d25e4e0701mr1467731wmb.31.1671624382538; 
 Wed, 21 Dec 2022 04:06:22 -0800 (PST)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a05600c348700b003cf6e1df4a8sm2118768wmq.15.2022.12.21.04.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Dec 2022 04:06:21 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH] virtio_net: send notification coalescing command only if
 value changed
Date: Wed, 21 Dec 2022 14:06:18 +0200
Message-Id: <20221221120618.652074-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
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

Don't send a VIRTIO_NET_CTRL_NOTF_COAL_TX_SET or
VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command if the coalescing parameters
haven't changed.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 drivers/net/virtio_net.c | 48 ++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7723b2a49d8..1d7118de62a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2760,31 +2760,37 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 	struct virtio_net_ctrl_coal_tx coal_tx;
 	struct virtio_net_ctrl_coal_rx coal_rx;
 
-	coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
-	coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
-	sg_init_one(&sgs_tx, &coal_tx, sizeof(coal_tx));
-
-	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
-				  VIRTIO_NET_CTRL_NOTF_COAL_TX_SET,
-				  &sgs_tx))
-		return -EINVAL;
+	if (ec->tx_coalesce_usecs != vi->tx_usecs ||
+	    ec->tx_max_coalesced_frames != vi->tx_max_packets) {
+		coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
+		coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
+		sg_init_one(&sgs_tx, &coal_tx, sizeof(coal_tx));
+
+		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
+					  VIRTIO_NET_CTRL_NOTF_COAL_TX_SET,
+					  &sgs_tx))
+			return -EINVAL;
 
-	/* Save parameters */
-	vi->tx_usecs = ec->tx_coalesce_usecs;
-	vi->tx_max_packets = ec->tx_max_coalesced_frames;
+		/* Save parameters */
+		vi->tx_usecs = ec->tx_coalesce_usecs;
+		vi->tx_max_packets = ec->tx_max_coalesced_frames;
+	}
 
-	coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
-	coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
-	sg_init_one(&sgs_rx, &coal_rx, sizeof(coal_rx));
+	if (ec->rx_coalesce_usecs != vi->rx_usecs ||
+	    ec->rx_max_coalesced_frames != vi->rx_max_packets) {
+		coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
+		coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
+		sg_init_one(&sgs_rx, &coal_rx, sizeof(coal_rx));
 
-	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
-				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
-				  &sgs_rx))
-		return -EINVAL;
+		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
+					  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
+					  &sgs_rx))
+			return -EINVAL;
 
-	/* Save parameters */
-	vi->rx_usecs = ec->rx_coalesce_usecs;
-	vi->rx_max_packets = ec->rx_max_coalesced_frames;
+		/* Save parameters */
+		vi->rx_usecs = ec->rx_coalesce_usecs;
+		vi->rx_max_packets = ec->rx_max_coalesced_frames;
+	}
 
 	return 0;
 }
-- 
2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
