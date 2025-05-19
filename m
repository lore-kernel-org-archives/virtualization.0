Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B6026658F
	for <virtualization@lists.linux.dev>; Mon, 19 May 2025 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747638439; cv=none; b=tWTGR7ku+z99SOC4vFO0ksqlONOVx6Slh9lIiOl9Fqy2ZeoBZmgZd7klJI0tHET3bQw73tNo9ZYewPwC56qlySOee95V5T6lMV42jLakWLy2N+NJbkLxksGaE/PkqxHoe/mEhIZxiHREXpGyg39cxqfzgUqxc0X9bqDhDuAKE7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747638439; c=relaxed/simple;
	bh=o4+xCFenhmp96OI75UNoIQhOcjTBx0Ax3r1tXJ88EXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q/KD50ItlAsYs+6pTnWsEN06AoQI8b5/8T/6O5+KEm3/Hwscd1ZOsof5tbTPQ1spXYAN1AeLb0iWzh27fhK/ty8846R6tGz1VD2XKpUENvLhH83aH/YEYrpegjF6o3LX6L0PlpskEjXAA9jOc8tcjEwlHulbfLvMT9bePhaOkLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRupc6wn; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRupc6wn"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30e93626065so1846974a91.1
        for <virtualization@lists.linux.dev>; Mon, 19 May 2025 00:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747638434; x=1748243234; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWPdfKtT2OXZLeQL6cLLp0+NSNfqA1Oi993as69qazA=;
        b=LRupc6wnzW/dkandZp7DnA7rbWw7lkJXU++A2dyvAeXrWavah/NoYIrTMngJqfvl1Q
         mIMnEDtB7IraM1TIoSGNXz9QAcVvsqBU4i4GCM2RsHch42MOwL4o/G/PKDtP60Y1LehM
         bkACCRUsa0Dkp90l4RE+Y1Ae5VVYKMDGL8bJLk2aRhQgePt7DDuXBozRYsIPFhBIBBo7
         oi/F23dKUJHhNr4fbnqsBSlkg8Rn9UbYwP7KxPkZeC7Jzlw7KP/QAXdgeHUbxXnQDAiK
         NCIDzzoIxNgOIWe4twfr3kseu9e9ni6PiGn7mW724Q0qb+veTPcHrPmdvrFJe/oIMtdo
         SybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747638434; x=1748243234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWPdfKtT2OXZLeQL6cLLp0+NSNfqA1Oi993as69qazA=;
        b=i8fXTkKIF1abZb7cSTNEhMw4uuqkQz0R5vGI0z9+YZVNHta7rw4EkUSAFxkT0HMWHk
         LWTyzXwSGohYOPBAtdeiJw+pd/HBydR2mdsf/i4QOk4xAliuRMotUSk5hRJcMij/O/2x
         Wu5onTEYTCtimokYoMq9rHby9mk78dVnOnnnNd6DXtcogBDiZ0Ylc4nGuY6vxzGHCzeU
         NaX4BUXUWwECB77O2tr0JJ0YXvVsmRNrsUw3AR8t059cBSXjrhkbUbRcgosUqJAUsfTQ
         aPr7IpSXc1MYQXMnnk7QJTbu4nYa+FmMlwd+IyU90CdANnsGwG+LxY+hD5Qir2kKp3YT
         tsew==
X-Gm-Message-State: AOJu0YwQTGsG5QTy/GhGw4sMdU0b0FXthisy1moH9WHx55/VCdGq34nz
	eG7V/nnifb8abyyrMz1N7OH4bx2y7pyY9F4AApEz7FLuEPl/EzMbMhA6
X-Gm-Gg: ASbGncsJnH3k1e3uKWoIe8lcBsGhZUrrI81eb72JHgti0WTFAejI8JSfR7pGTrMzOEN
	4sn9VCCWqrjdbpIatJEv/2iQogDGU2wpA/7zxHvL2CyQm2rIscI174ms8tv6Yjv23qKZFmaEUJH
	/W2VL3tv6Hmxd+zMU6W7UmUjY1CYPMuiuqHCqEWb1W1Vb+hpcMfc7jkVoa8/nFiXfEKyOYvCArX
	gFzTNNZOvhArSpxjGBXu/pH44LoibSOWGNUu35DBP9ml9h67hiCu5HVS+6OD/G84SAhowOAcfS4
	lu72znjDsKm8qIjAxflSyD//wDLgPyPWV2PTdYIL9N33a6Nkvuw7qGBXNnDzLyiMIVdvXOkEQQ=
	=
X-Google-Smtp-Source: AGHT+IGAGsvIArGOURC6jETHsXCGSSkCUmd1tqdQbpGNwcsLQuYAUGuTL9uAfECQEQuYsai0/RRvNA==
X-Received: by 2002:a17:90b:55cc:b0:2ee:d63f:d73 with SMTP id 98e67ed59e1d1-30e830ebe05mr20262447a91.11.1747638434394;
        Mon, 19 May 2025 00:07:14 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a0120sm5574336a12.63.2025.05.19.00.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 00:07:13 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com,
	mst@redhat.com,
	fupan.lfp@antgroup.com,
	pabeni@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	stefanha@redhat.com
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [PATCH 2/3] vsock/virtio: Add SIOCINQ support for all virtio based transports
Date: Mon, 19 May 2025 15:06:48 +0800
Message-Id: <20250519070649.3063874-3-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250519070649.3063874-1-niuxuewei.nxw@antgroup.com>
References: <20250519070649.3063874-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtio_vsock_sock has a new field called bytes_unread as the return
value of the SIOCINQ ioctl.

Though the rx_bytes exists, we introduce a bytes_unread field to the
virtio_vsock_sock struct. The reason is that it will not be updated
until the skbuff is fully consumed, which causes inconsistency.

The byte_unread is increased by the length of the skbuff when skbuff is
enqueued, and it is decreased when dequeued.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 drivers/vhost/vsock.c                   |  1 +
 include/linux/virtio_vsock.h            |  2 ++
 net/vmw_vsock/virtio_transport.c        |  1 +
 net/vmw_vsock/virtio_transport_common.c | 17 +++++++++++++++++
 net/vmw_vsock/vsock_loopback.c          |  1 +
 5 files changed, 22 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 802153e23073..0f20af6e5036 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -452,6 +452,7 @@ static struct virtio_transport vhost_transport = {
 		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
 
 		.unsent_bytes             = virtio_transport_unsent_bytes,
+		.unread_bytes             = virtio_transport_unread_bytes,
 
 		.read_skb = virtio_transport_read_skb,
 	},
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 0387d64e2c66..0a7bd240113a 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -142,6 +142,7 @@ struct virtio_vsock_sock {
 	u32 buf_alloc;
 	struct sk_buff_head rx_queue;
 	u32 msg_count;
+	size_t bytes_unread;
 };
 
 struct virtio_vsock_pkt_info {
@@ -195,6 +196,7 @@ s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
 u32 virtio_transport_seqpacket_has_data(struct vsock_sock *vsk);
 
 ssize_t virtio_transport_unsent_bytes(struct vsock_sock *vsk);
+ssize_t virtio_transport_unread_bytes(struct vsock_sock *vsk);
 
 void virtio_transport_consume_skb_sent(struct sk_buff *skb,
 				       bool consume);
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index f0e48e6911fc..917881537b63 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -585,6 +585,7 @@ static struct virtio_transport virtio_transport = {
 		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
 
 		.unsent_bytes             = virtio_transport_unsent_bytes,
+		.unread_bytes             = virtio_transport_unread_bytes,
 
 		.read_skb = virtio_transport_read_skb,
 	},
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 7f7de6d88096..11eae88c60fc 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -632,6 +632,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 	free_space = vvs->buf_alloc - fwd_cnt_delta;
 	low_rx_bytes = (vvs->rx_bytes <
 			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
+	vvs->bytes_unread -= total;
 
 	spin_unlock_bh(&vvs->rx_lock);
 
@@ -782,6 +783,7 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
 		}
 
 		virtio_transport_dec_rx_pkt(vvs, pkt_len);
+		vvs->bytes_unread -= pkt_len;
 		kfree_skb(skb);
 	}
 
@@ -1132,6 +1134,19 @@ ssize_t virtio_transport_unsent_bytes(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_unsent_bytes);
 
+ssize_t virtio_transport_unread_bytes(struct vsock_sock *vsk)
+{
+	struct virtio_vsock_sock *vvs = vsk->trans;
+	size_t ret;
+
+	spin_lock_bh(&vvs->rx_lock);
+	ret = vvs->bytes_unread;
+	spin_unlock_bh(&vvs->rx_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(virtio_transport_unread_bytes);
+
 static int virtio_transport_reset(struct vsock_sock *vsk,
 				  struct sk_buff *skb)
 {
@@ -1365,6 +1380,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 		goto out;
 	}
 
+	vvs->bytes_unread += len;
+
 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
 		vvs->msg_count++;
 
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 6e78927a598e..13a77db2a76f 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -99,6 +99,7 @@ static struct virtio_transport loopback_transport = {
 		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
 
 		.unsent_bytes             = virtio_transport_unsent_bytes,
+		.unread_bytes             = virtio_transport_unread_bytes,
 
 		.read_skb = virtio_transport_read_skb,
 	},
-- 
2.34.1

