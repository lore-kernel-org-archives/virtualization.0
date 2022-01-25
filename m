Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E79C433EF
	for <virtualization@archiver.kernel.org>; Tue, 25 Jan 2022 08:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 409FC40472;
	Tue, 25 Jan 2022 08:47:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yU3ukIjxehFZ; Tue, 25 Jan 2022 08:47:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BE98A40A95;
	Tue, 25 Jan 2022 08:47:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9370C007F;
	Tue, 25 Jan 2022 08:47:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AECF1C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9CD474176C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QhEeM79Iw9q4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 861B14175F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:25 +0000 (UTC)
Received: by mail-lj1-x233.google.com with SMTP id q22so6967804ljh.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 00:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UtVU5Ioannj5lFzXA15MNhoL0jZF5uZA66JN5wY/VHo=;
 b=z1PVhkYnURa8uk4TdLAjmi4ey/+drh7NOxm8j5ND/n779yDew1YHn/TF1jSwclCBNz
 aExTGYGyghejwUs2hNWH+nYD08V+6xE6xa9k3FvihZgFRyQhDqgUNyWRjKuGBUU2UwEH
 q/SMJMs8GRd06V8oHMqLFnZsM74NV2Oc7IRvEkxixGzFVkyyLU8O7n5ef0vSET7gfXuv
 Eaqko63J/8AeudSImrul4ef25S9Vtr6a4tHVIoxmzTvfuHzDeiBXBZXsB9SEbGiDs703
 ChOXRRz2i7aT/wwqwgOrbR6ziolJ3xFET6e8Y6A2aFvx09YMk8ZoqJ7T6/usZsZeU/1C
 nFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UtVU5Ioannj5lFzXA15MNhoL0jZF5uZA66JN5wY/VHo=;
 b=gs843fFS0AuhkVx8jqS9HweYKom0QyKWWwsyrFFgz1nQae3GiixZDGdXbibgQOli+d
 jZaks5iw91zn+1GdA9bbhuM4mKH2bEaFADcZpzZSECQUBwAVHCRsyJyqpnrIa+/CQPr4
 QF3v2DXdYFPWhlz0XlymJxrZHU9YcaO4E9OV4FA0k6qp4Sdb9BlKH+jv5DzjEZ7MASHx
 nhDaJv7kM2FUXzz9+PA1HeHUmW8yTHZ5OUPguXbxyuTKEOJDVuc1ClZxR5+FzRECG7oO
 wM7X37Ds4PjsqRi63lT5tNPl0g2W8NofXua78pRXeJWvkXxgbWZrbtj0TGOseDUPjjka
 wVtw==
X-Gm-Message-State: AOAM530LsY9Wgf/z/0tM5gdbhz43X0mhdiQq02bj9bev2lHAtV/eVnRi
 OMkbnYmwAWd+Z14gw5l1S8T4U1O/HbWgC2E9l04=
X-Google-Smtp-Source: ABdhPJwyonKvuxlj8x8ao+iZgQDBoPXfdR2ybG7ru6rdG/cLdX4fw/FgGqWs+2hNx2lMu2DLvmkRLA==
X-Received: by 2002:a2e:9654:: with SMTP id z20mr14066133ljh.526.1643100443571; 
 Tue, 25 Jan 2022 00:47:23 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id q5sm1418944lfe.279.2022.01.25.00.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jan 2022 00:47:23 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, kuba@kernel.org, mst@redhat.com, jasowang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 3/5] uapi/linux/virtio_net.h: Added USO types.
Date: Tue, 25 Jan 2022 10:47:00 +0200
Message-Id: <20220125084702.3636253-4-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125084702.3636253-1-andrew@daynix.com>
References: <20220125084702.3636253-1-andrew@daynix.com>
MIME-Version: 1.0
Cc: yan@daynix.com, yuri.benditovich@daynix.com
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

Added new GSO type for USO: VIRTIO_NET_HDR_GSO_UDP_L4.
Feature VIRTIO_NET_F_HOST_USO allows to enable NETIF_F_GSO_UDP_L4.
Separated VIRTIO_NET_F_GUEST_USO4 & VIRTIO_NET_F_GUEST_USO6 features
required for Windows guests.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 include/uapi/linux/virtio_net.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 3f55a4215f11..620addc5767b 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -56,6 +56,9 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
+#define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */
+#define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
+#define VIRTIO_NET_F_HOST_USO	56	/* Host can handle USO in. */
 
 #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
 #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
@@ -130,6 +133,7 @@ struct virtio_net_hdr_v1 {
 #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
 #define VIRTIO_NET_HDR_GSO_UDP		3	/* GSO frame, IPv4 UDP (UFO) */
 #define VIRTIO_NET_HDR_GSO_TCPV6	4	/* GSO frame, IPv6 TCP */
+#define VIRTIO_NET_HDR_GSO_UDP_L4	5	/* GSO frame, IPv4 & IPv6 UDP (USO) */
 #define VIRTIO_NET_HDR_GSO_ECN		0x80	/* TCP has ECN set */
 	__u8 gso_type;
 	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
