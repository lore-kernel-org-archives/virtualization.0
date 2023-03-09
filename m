Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16432C64EC4
	for <virtualization@archiver.kernel.org>; Thu,  9 Mar 2023 09:46:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8CB2540C63;
	Thu,  9 Mar 2023 09:46:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8CB2540C63
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=SHp7EWFO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id syqie40SiLFH; Thu,  9 Mar 2023 09:46:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E14F540360;
	Thu,  9 Mar 2023 09:46:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E14F540360
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1C80C0071;
	Thu,  9 Mar 2023 09:46:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F164C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 09:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 071C640363
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 09:46:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 071C640363
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 70w03_Furv2C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 09:46:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 46ED640360
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 46ED640360
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 09:46:03 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id p26so702071wmc.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Mar 2023 01:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20210112.gappssmtp.com; s=20210112; t=1678355162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7ByKEWC2al4eO3WGl73gO3Qu6gf7BRWv6Uu6cBRRz4Q=;
 b=SHp7EWFOp+RCs04Sq0K3DdZkvjuxmSl219/U67X2zF2O+BIkhR+F6dYilwFXN216Gf
 yPQcx61pmaNLI1B93ZCa9iL4xy0993dqSAxIBJNgm01LcGxf1PSWR1wEy6qa36WB1RD1
 yT3vY2+tVK+k/VwG+r3L/7xLjNrjOs2ACUZFACq/oq0dtSi5Kasx+AJA1lZwYFvNFDKZ
 3kQSEr+FQFwj56xwhKkWl+hRKx1bGJd5r50vA7XdXh53rI23b0gEfxc6LNwrjm+sbias
 GqRAtnDDbUcxO/GgpttDmiQF2GLZ976nkAfKtxtvAE6/uij6duviLVeVFrqpu5O+WkRp
 B2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678355162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ByKEWC2al4eO3WGl73gO3Qu6gf7BRWv6Uu6cBRRz4Q=;
 b=uR3qRgQmuyLDpEbxf+D2aEbRjDqKm4Hzx4EC/MeKQ/TkWRI2EEKAG/QyBOusiGDDm0
 fS9q76icdifTu6iM2vfq7cg77NzZKjWpJhFhzgc4ltBGYyLqmaypJp925PsUeeUPCbnH
 ecSphZzhgH/Qsmwkj22pkfMQs2265RVnmzvxDDx6NbN3N+W08qy1dbVKKBtri9RIyVQX
 X0sQ7ozmTmFP5NHY04sHCjhsWTPVxCyscow0OFWQmH4JWlCcB/shxaYYfJG0CO9AgXyI
 hlbdOG4NnYSvo60PuUgPK5yEfCiBldBo19absgIjMUUanqhvSzIP9yH/dQKYpsX+X96G
 kYtQ==
X-Gm-Message-State: AO0yUKW2s0grGZnI0GQrHwIFUnuXMMbTwqMrR5yBIgZJvGK7cBmXYta4
 4jRIUKcKjxfJO8Sv5drBo6P9Mw==
X-Google-Smtp-Source: AK7set8nKKC49FrVDccv+YmIlOYV+yfiCeCYeWkacvZgL8H/czWgD+J2n66tqM33cG9WVnfYPXqUqg==
X-Received: by 2002:a05:600c:a08:b0:3eb:2e32:72b4 with SMTP id
 z8-20020a05600c0a0800b003eb2e3272b4mr18729981wmp.15.1678355161838; 
 Thu, 09 Mar 2023 01:46:01 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net.
 [213.179.129.39]) by smtp.gmail.com with ESMTPSA id
 o8-20020a05600c510800b003e215a796fasm2287099wms.34.2023.03.09.01.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Mar 2023 01:46:01 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Subject: [patch net-next v4] net: virtio_net: implement exact header length
 guest feature
Date: Thu,  9 Mar 2023 10:45:59 +0100
Message-Id: <20230309094559.917857-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Cc: willemdebruijn.kernel@gmail.com, mst@redhat.com, vmireyno@marvell.com,
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
set implicates that device benefits from knowing the exact size
of the header. For compatibility, to signal to the device that
the header is reliable driver also needs to set this feature.
Without this feature set by driver, device has to figure
out the header size itself.

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

Link: https://docs.oasis-open.org/virtio/virtio/v1.2/cs01/virtio-v1.2-cs01.html#x1-230006x3
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Willem de Bruijn <willemb@google.com>
---
v3->v4:
- fixed double "which when"
v2->v3:
- changed the first paragraph in patch description according to
  Michael's suggestion
- added Link tag with link to the spec
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
