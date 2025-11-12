Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394EC2E6CAB
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930544; cv=none; b=IZ84TpK09RyNGTWpDPwCuPnVanLnZpHE64fyjjC7yUmzDaH/kPV0Y0ZDGz15R4Ll93WxFE1xmTppANFHb3CIxV0tot8HzVI1QsBE0GH6Rd3t7VxeDb2DTjuL1U79B6yHDIYreVP4d0NT4swye5tHlJ42jv09RWGmON3aaTNNGZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930544; c=relaxed/simple;
	bh=veSnw3IGQ71cxIlqHypTONN3gf5WNTEJruTN4Lb14qA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K/D/0DVjtpp5JOndSXvuGU6CHb9AkPiMLkx/SkEyYJH2vB7Y0jDsqUfHNwo1nmV03u1csTvsiUT6aK/i2ylFOItR9WV+y/aheIAz8CvWXI5bWcBB5Tagt/v/GVUJ3JvHmxdcaA7IijvmzOCaMO4yZmlR8chsY2XyhPez2n4zAjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHwGojam; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHwGojam"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b18c6cc278so652915b3a.0
        for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 22:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762930539; x=1763535339; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3POWcPl845f0o8duse0G0nccbWINBqqIKArZonruJ3I=;
        b=LHwGojamoW4uhb12OkwOlRJP3CEE2zmNaMjfvV9WH4ArPcXo/42wwGTel5Csd5GyKN
         rOJFjksF4dLlh9jLmOKLfEQpxBbZ4qJrFSHe1Jyfc+Sv4+3DBNQeucwk7pj+wdNFFu48
         UfGTGisPqI+6JliLD4N0b5UQN4bc+/6LA01xxAZ+jy7tgejV+tbhAArAmNXtJ2UMPl0C
         Chpj02fTpIhyueeN0zKdx2FFRVbH465836H1IZb3QXzzo20m7db5OVDz9kMsYsKg2Ayl
         A5B8oVIaVM1kzTRVz+u/FGt4afo/Xc+UQmPaDiRAAQZEkfxu+52iGYL7uRgm3dW/DZo8
         TqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930539; x=1763535339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3POWcPl845f0o8duse0G0nccbWINBqqIKArZonruJ3I=;
        b=HKN1bgG9DDOgviJ+TaY+bxN+eskFJMJC69bCGilLMCjMluegMOUhfdRIVFM1nhy00a
         E8CbGBcbeLbBjVdJe2iOUbMMJSqZlv9OLULIOSgy7BLV7XIzaa8FX2zRUk/1WsjXOCV4
         no19CW+GXuaAusDYkYwusIt6pL+Y10Nmn2PjNO93kW4mDPwjhRqneE3pn1vhvnIGK43y
         LHjaXs/+g1faGGlbUvbMVtsm5oMDSFTHM44x0IC2zWSd05KCfy3cBCLP46SccF6uGvPA
         rXaBYhK5j/YsTecfF/v8PsnOydR2s6479Mz6ACaokZNUTQT/WsyUzezdDJ+SKJqhUkkm
         ZyUg==
X-Gm-Message-State: AOJu0Yy+4oGfPujDSFsUTAVQvbgQ+uBsm5WggiSSHMy4ArfWesJIO0JJ
	LmmqprBtnpkoXBzWof/ZAgLWyQWc0FU671m4I9n2Qe11Yc9SEbfusgvW
X-Gm-Gg: ASbGncv5fsIOaXQ6U/QVeAEyHjFOPZ5UZXI/q4IcGoC/OPSbM3cku6O6mb9dMcUbdjo
	lFk2yMEOhVhvP07c2N6SesvtynqVI/p6rpCsrzAKuuPQKMs2Qo78l6gwUEsnNNMSMgX52T55a9w
	Fdw1FOT725bx0RWe/3xTvAUB4vFmQ/bSlILuqzDQ2etqcOqTUSbolnq9NiLgMwI5hHywZM6wyWT
	tdQrSZCkingHyU+e+/rmdosDWsXsncMYa11AUQNMTM0Y+LZtXKmO7eUbxppiXyMQLsppbZor6Z9
	gBXW6Idi2zaULuIffVlBjs1SAiJ8S+o4xXt4Dd+enatyzW6UFUIcPtEa8kvKjEJkM0F6nP4HdFu
	z/M/95kApGSmcv9XuAFdnqpWadx9/IYgTc9eiH7JkJHOdBRvEhfpGKHlaV2y5hClary6zYjgm
X-Google-Smtp-Source: AGHT+IHHvidQKHevYduW37onhvCFlT+u0IEMiGDYOLRIvORJFfiefLF1h5W5O7IoFAvmqwigA4o2NQ==
X-Received: by 2002:a05:6a20:12cb:b0:334:8239:56dc with SMTP id adf61e73a8af0-3590b820767mr2885613637.56.1762930539480;
        Tue, 11 Nov 2025 22:55:39 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07d2e5esm1357244a91.17.2025.11.11.22.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:55:39 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 11 Nov 2025 22:54:47 -0800
Subject: [PATCH net-next v9 05/14] vsock: add netns and netns_tracker to
 vsock skb cb
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-vsock-vmtest-v9-5-852787a37bed@meta.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
In-Reply-To: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add a net pointer, netns_tracker, and net_mode to the vsock skb and
helpers for getting/setting them. These fields are only used by
vsock_loopback in order to avoid net-related race conditions (more info
in the loopback patch).

This extends virtio_vsock_skb_cb to 32 bytes (with
CONFIG_NET_DEV_REFCNT_TRACKER=y):

struct virtio_vsock_skb_cb {
	struct net *               net;                  /*     0     8 */
	netns_tracker              ns_tracker;           /*     8     8 */
	enum vsock_net_mode        net_mode;             /*    16     4 */
	u32                        offset;               /*    20     4 */
	bool                       reply;                /*    24     1 */
	bool                       tap_delivered;        /*    25     1 */

	/* size: 32, cachelines: 1, members: 6 */
	/* padding: 6 */
	/* last cacheline: 32 bytes */
};

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v9:
- update commit message to specify usage by loopback only
- add comment in virtio_vsock_skb_cb mentioning usage by vsock_loopback
- add ns_tracker to skb->cb
- removed Stefano's Reviewed-by trailer due to ns_tracker addition (not
  sure if this is the right process thing to do)

Changes in v7:
- rename `orig_net_mode` to `net_mode`
- update commit message with a more complete explanation of changes

Changes in v5:
- some diff context change due to rebase to current net-next
---
 include/linux/virtio_vsock.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 18deb3c8dab3..a3ef752cdb95 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -10,6 +10,10 @@
 #define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
 
 struct virtio_vsock_skb_cb {
+	/* net, net_mode, and ns_tracker are only used by vsock_loopback. */
+	struct net *net;
+	netns_tracker ns_tracker;
+	enum vsock_net_mode net_mode;
 	u32 offset;
 	bool reply;
 	bool tap_delivered;
@@ -130,6 +134,35 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
 	return (size_t)(skb_end_pointer(skb) - skb->head);
 }
 
+static inline struct net *virtio_vsock_skb_net(struct sk_buff *skb)
+{
+	return VIRTIO_VSOCK_SKB_CB(skb)->net;
+}
+
+static inline void virtio_vsock_skb_set_net(struct sk_buff *skb, struct net *net)
+{
+	get_net_track(net, &VIRTIO_VSOCK_SKB_CB(skb)->ns_tracker, GFP_KERNEL);
+	VIRTIO_VSOCK_SKB_CB(skb)->net = net;
+}
+
+static inline void virtio_vsock_skb_clear_net(struct sk_buff *skb)
+{
+	put_net_track(VIRTIO_VSOCK_SKB_CB(skb)->net,
+		      &VIRTIO_VSOCK_SKB_CB(skb)->ns_tracker);
+	VIRTIO_VSOCK_SKB_CB(skb)->net = NULL;
+}
+
+static inline enum vsock_net_mode virtio_vsock_skb_net_mode(struct sk_buff *skb)
+{
+	return VIRTIO_VSOCK_SKB_CB(skb)->net_mode;
+}
+
+static inline void virtio_vsock_skb_set_net_mode(struct sk_buff *skb,
+						      enum vsock_net_mode net_mode)
+{
+	VIRTIO_VSOCK_SKB_CB(skb)->net_mode = net_mode;
+}
+
 /* Dimension the RX SKB so that the entire thing fits exactly into
  * a single 4KiB page. This avoids wasting memory due to alloc_skb()
  * rounding up to the next page order and also means that we

-- 
2.47.3

