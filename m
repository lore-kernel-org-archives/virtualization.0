Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55F4C61DA3
	for <virtualization@archiver.kernel.org>; Tue, 21 Feb 2023 14:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 849A240FCE;
	Tue, 21 Feb 2023 14:47:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 849A240FCE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Z9AjOxJz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AEC9sd67vC6T; Tue, 21 Feb 2023 14:47:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E78C440D0F;
	Tue, 21 Feb 2023 14:47:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E78C440D0F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9333CC0033;
	Tue, 21 Feb 2023 14:47:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1C1EC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 14:47:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A718282353
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 14:47:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A718282353
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com
 header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=Z9AjOxJz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YsJy7t0TIzES
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 14:47:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1BA1A822CF
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1BA1A822CF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 14:47:44 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 l7-20020a05600c4f0700b003e79fa98ce1so1359854wmq.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 06:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o4mWVM9T8dfHGIl7P8eiExkKjczxJmVekYpJZZnuF0w=;
 b=Z9AjOxJzTYoZ2DIDfGgXBWzFfLcqYc6u7sRHjIITA4F3pganfmOao3DGyunICcyrai
 RFKSLlhJ6CrR9ktz1HSJlbA61Og4N8FlT8sxkNYtXmVWb/LBu0hTaDgmDfqYJ9+xcB0D
 iV2BNMEYfZkw13sRhE1Ub999SIBwaKm4SYTAau60gyjFJsjQ8RipJLQqT+traYnGqAN1
 PWLbn5ajy2GvFnBlZ8XH3tUoKXQ7iZBfZJ/5auNbn7LlmVwowC+lG/zfcMs03eWswVTk
 Pu9+N1zd0EUJFf/jSfC8DrPCu31Dz4SuBmoq19agOuiz2NtLYGyDa6I0ANXwu5TR1Gk3
 E3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o4mWVM9T8dfHGIl7P8eiExkKjczxJmVekYpJZZnuF0w=;
 b=Xa6GBSwh6apJ1pdvSF0aV+A0GsD17qKOIAVywG39P1B2TgntvYD2it4afKMXvLxgCX
 Rx3lbqjXYH7WPMmNRbDOs6Un7EFy8k4ihU179bkNyCKJJV+bs/0T+MiC70yJ2QTeznw4
 UmVZLo40h8Wopb4+X4VutDLOJM1jffkq/O6ZlpTSWTki2MBNCvpIIySEYbcSNNmOcAKj
 l34NlLwfFH8N7aKZxQQhZc0gQBCExqSYW/lbOKKkL9ao8OnsFhsTGWKJ/QgYTqipt+7I
 W1rXTvXOEImLZe2zjijItT9tT0IsedPkX+I8Ie00YMN6hrEajGNL0mrN28LYFAd1gS2u
 E1SQ==
X-Gm-Message-State: AO0yUKUj9gmTgbgo1ssNvL5pkTCG1g0wVCOqXGPNXhtwJHGc6QkK65qv
 ASagxZFXkbp59v9hoihnxeTCKA==
X-Google-Smtp-Source: AK7set9aahy7X6+87gTHV7TpgIzNTW6v9HbXn2RvM8cMKYKK3zXoO+BpzvAzvMQDU3rii1OjBDPOhg==
X-Received: by 2002:a05:600c:4d97:b0:3e2:bf1:9eb0 with SMTP id
 v23-20020a05600c4d9700b003e20bf19eb0mr3204208wmp.9.1676990863121; 
 Tue, 21 Feb 2023 06:47:43 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net.
 [213.179.129.39]) by smtp.gmail.com with ESMTPSA id
 m6-20020a05600c4f4600b003df245cd853sm6354173wmq.44.2023.02.21.06.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Feb 2023 06:47:42 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Subject: [patch net-next v2] net: virtio_net: implement exact header length
 guest feature
Date: Tue, 21 Feb 2023 15:47:41 +0100
Message-Id: <20230221144741.316477-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Cc: mst@redhat.com, vmireyno@marvell.com,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

From: Jiri Pirko <jiri@nvidia.com>

Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
set implicates that the driver provides the exact size of the header.

Quoting the original virtio spec:
"hdr_len is a hint to the device as to how much of the header needs to
 be kept to copy into each packet"

"a hint" might not be clear for the reader what does it mean, if it is
"maybe like that" of "exactly like that". This feature just makes it
crystal clear and let the device count on the hdr_len being filled up
by the exact length of header.

Also note the spec already has following note about hdr_len:
"Due to various bugs in implementations, this field is not useful
 as a guarantee of the transport header size."

Without this feature the device needs to parse the header in core
data path handling. Accurate information helps the device to eliminate
such header parsing and directly use the hardware accelerators
for GSO operation.

virtio_net_hdr_from_skb() fills up hdr_len to skb_headlen(skb).
The driver already complies to fill the correct value. Introduce the
feature and advertise it.

Note that virtio spec also includes following note for device
implementation:
"Caution should be taken by the implementation so as to prevent
 a malicious driver from attacking the device by setting
 an incorrect hdr_len."

There is a plan to support this feature in our emulated device.
A device of SolidRun offers this feature bit. They claim this feature
will save the device a few cycles for every GSO packet.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- extended patch description
---
 drivers/net/virtio_net.c        | 6 ++++--
 include/uapi/linux/virtio_net.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fb5e68ed3ec2..e85b03988733 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -62,7 +62,8 @@ static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_UFO,
 	VIRTIO_NET_F_GUEST_CSUM,
 	VIRTIO_NET_F_GUEST_USO4,
-	VIRTIO_NET_F_GUEST_USO6
+	VIRTIO_NET_F_GUEST_USO6,
+	VIRTIO_NET_F_GUEST_HDRLEN
 };
 
 #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
@@ -4213,7 +4214,8 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
 	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
-	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL
+	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
+	VIRTIO_NET_F_GUEST_HDRLEN
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index b4062bed186a..12c1c9699935 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -61,6 +61,7 @@
 #define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
 #define VIRTIO_NET_F_HOST_USO	56	/* Host can handle USO in. */
 #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
+#define VIRTIO_NET_F_GUEST_HDRLEN  59	/* Guest provides the exact hdr_len value. */
 #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
 #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
 #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
-- 
2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
