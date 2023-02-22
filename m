Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E867C64EC4
	for <virtualization@archiver.kernel.org>; Wed, 22 Feb 2023 08:06:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1156C404C9;
	Wed, 22 Feb 2023 08:06:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1156C404C9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=HIzDykSU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O62gYryFgqjs; Wed, 22 Feb 2023 08:06:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 80B6240445;
	Wed, 22 Feb 2023 08:06:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 80B6240445
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47903C0032;
	Wed, 22 Feb 2023 08:06:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFCFCC002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 08:06:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C60E6414CE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 08:06:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C60E6414CE
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com
 header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=HIzDykSU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GGwv7G2whuwj
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 08:06:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 59728408CF
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 59728408CF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 08:06:42 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id h16so27101353edz.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 00:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/j5htBbjMea8DRzUGW3vKYq7/4smjMcgS0g+TBXKmzc=;
 b=HIzDykSUWHF42U2s4mMDUlFcSROuRArW2CgvwAjJwKnYHY7uF58nqlN/enQGqc7DNN
 6WzNPh9AKpvjT3HIrfzC3pLx3bSC/rfqfBt727JT0p9hxwJWctPgedeX2Ce6MvkLUTyB
 SsgeStGI00h0feBSn30xuMFxj4gMnYeRTKql0XqioPutYM1AwJrEcPqwM5iFMqGHBsoA
 9bdKvfb7ZnkQoSNElWBMTtfv6k8egcEoFIl5lOhRQDVr3dOeVm9fgq+2E05m/9Nt4pTc
 pozW+EW7vT2qHuyp12Ho4QKU3vi3sqNJy7ZAIyeNoWaJWL57e7DH+oZ27ahDInLOW0Qm
 9YMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/j5htBbjMea8DRzUGW3vKYq7/4smjMcgS0g+TBXKmzc=;
 b=irGwqYXtaYXMYfjcY6yFb4LqBG8W4+VUO+wJ1EhJP4xYQIQswt24Rvvu2VL7lcxji1
 hz8qkopi/QLoO3KYDLXg0vN3BkL1fuoguPUo9YxdZ8VyZfMyIhHjUOhIFHz/ksd3Ef9V
 FW9pE0dgWBepFOmwSUcYSQdYuRmAB0eon9dQXkyDWYnpjVXuSeS9ZZS9v4DwfpIcVwaU
 o0VB62AHPXhUxz9rAg7IPfBDcE5HltlaAt+Y6Dj8GGXCzG2J6yYjWIthGXoKaOl6MXZO
 lkcQRztTDNU4NPCJ+fB+s/1Qyc6uwPyKLxIbSwrc7MBHxL31Zot0VL0Q62Wsa8/kAdeC
 YsxA==
X-Gm-Message-State: AO0yUKVKuo60Um8KLa0ta7GSqN9YOhjms/spvMf73X03x+9MkiOx+9Yh
 vvM0v7HH0auLZrXiLZFvKHPXLg==
X-Google-Smtp-Source: AK7set8T15Ruj7il+jkoOd9Lr2am/9sj7gha7Wus6F+o4VRnGqraZxKYmZx9Gb1hxBucPkQ71j3Vyw==
X-Received: by 2002:aa7:c697:0:b0:4ac:c426:6b4a with SMTP id
 n23-20020aa7c697000000b004acc4266b4amr7409004edq.36.1677053200455; 
 Wed, 22 Feb 2023 00:06:40 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net.
 [213.179.129.39]) by smtp.gmail.com with ESMTPSA id
 i25-20020a508719000000b004acb42134c4sm2600612edb.70.2023.02.22.00.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Feb 2023 00:06:39 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Subject: [patch net-next v3] net: virtio_net: implement exact header length
 guest feature
Date: Wed, 22 Feb 2023 09:06:38 +0100
Message-Id: <20230222080638.382211-1-jiri@resnulli.us>
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
which when set implicates that device benefits from knowing the exact
size of the header. For compatibility, to signal to the device that
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
---
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
