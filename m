Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C58C636D4
	for <virtualization@archiver.kernel.org>; Fri, 17 Feb 2023 12:15:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6E4441B51;
	Fri, 17 Feb 2023 12:15:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6E4441B51
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=GLRo7Gjr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eRx72_YhcWIB; Fri, 17 Feb 2023 12:15:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DC2A041B48;
	Fri, 17 Feb 2023 12:15:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC2A041B48
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3110C0033;
	Fri, 17 Feb 2023 12:15:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DA89C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 12:15:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E9A1D41B51
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 12:15:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9A1D41B51
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IlLsukQLLWEo
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 12:15:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 666D141B48
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 666D141B48
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 12:15:52 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 e4-20020a05600c4e4400b003dc4050c94aso802362wmq.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 04:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fdAd75IKeGuiZC/gLVi/q5gzUOXi0Tilg6lxXWoO9Ic=;
 b=GLRo7GjrvRH2s3vxMtLX0NXuTsxH0mOLf2t4mh+bq3UTYnPxFxKa+aclc+N+Bg3Kwr
 YhZ3Q/YibkXLUgFCiJCvVHqL2bEj+abEN0qdl8U5gOAWUqE5iyXBh6lsQKU1DEbwatXG
 KC7YrbwNFJoQZFY7hEZdnGWp2I0etkgmkx2PoLCj0NYqjd8VSY+Wc8gRvz/toEHQtmdh
 +GLu/q2T/nM7PbNfwmlceO9Y7wPiUSgghmxHOiIdgHidKmWDDHQdsTLeRl1/6vUIvTbu
 wwcYTU3RgeLp62a/vPt+KntMJKKQ56Vp6E1QXJNJS2QAICNb95NoTqDxcLZwCWpmq+sK
 o5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fdAd75IKeGuiZC/gLVi/q5gzUOXi0Tilg6lxXWoO9Ic=;
 b=6ZDXjxh3qFzC8NKO/s5IqKYOiZKsTcmsxfMW0Y1G/YiLxqpRGruHPuRLYVbu4GrvzS
 gFGORUsAl9e1+/ipYTeX5bg6VRTVPNac2+B3UMBTfSV1zkioVLt36VjTCiteSRtS32JS
 njtSAzF0kr4GR7BfzrsfwbLtjXhCUsmUWu7zhg1UdZinVsURQsUNZbbch+Pf7lonqSED
 gi4SvNh4fLoTC4cVXLrKOATb7mNc07/nyFWno/ZU7TvO/LYS+Eztjrr7DXO8PZS2F76a
 pgvcJZ49ToJ27MWWuSsRqI+m3GfQ0O3xlIedypNymYZjF5lEJwWinZk5VJfwtYG8m301
 NhWw==
X-Gm-Message-State: AO0yUKWs7pUTpUbanCc9OJTe3dTBvkuDMEUTplivLDqOaSybRp3uxc4B
 yGDax9xj1tv2Fao7o3D2rA6amw==
X-Google-Smtp-Source: AK7set+NC36+Q5PbXb31/vlW/fxp3sjTPYoccHDngY01oTfli/nug4z1vpF9dVoW6KhN6RJwOVlWRQ==
X-Received: by 2002:a05:600c:2eca:b0:3df:f7e7:5f01 with SMTP id
 q10-20020a05600c2eca00b003dff7e75f01mr777021wmn.15.1676636150111; 
 Fri, 17 Feb 2023 04:15:50 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net.
 [213.179.129.39]) by smtp.gmail.com with ESMTPSA id
 4-20020a05600c024400b003e01493b136sm8425722wmj.43.2023.02.17.04.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Feb 2023 04:15:49 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Subject: [patch net-next] net: virtio_net: implement exact header length guest
 feature
Date: Fri, 17 Feb 2023 13:15:47 +0100
Message-Id: <20230217121547.3958716-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

virtio_net_hdr_from_skb() fills up hdr_len to skb_headlen(skb).

Virtio spec introduced a feature VIRTIO_NET_F_GUEST_HDRLEN which when
set implicates that the driver provides the exact size of the header.

The driver already complies to fill the correct value. Introduce the
feature and advertise it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
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
