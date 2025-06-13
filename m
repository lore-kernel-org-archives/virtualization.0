Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD97724DD0B
	for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 03:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749784336; cv=none; b=lbPIWJVPBckI9Z5IXsa3BO/rZB6vbGsUUhB7ilFl0URxZUPs0N+y0WEu5c/Zserp2gmRnvx7tGmLsDOCdEaK+Rn7jjZXST7TnOqmdAe49deKHnboPF4g6IHpPRb7M7ZRXqGOTQKVNJffMBXSKq54WdykAmI0RnovyP4x0JyVOFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749784336; c=relaxed/simple;
	bh=JpimrpV+MtzzCPBuM8z+T+yol8hWsqq4uAYSN7jCxp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wem2nplCOEB6p50zpAvxds8IdJ+yn0T+UNi8Owkow1OdxzyuD0WJhDfm8giYkzayVKkrBjqZamQECpgD/4COZWXFe2L5eaP3es/cnpn5G0gR0BJCNq7O3Ib9vZ05zb2Dyh5zNFVvJF325m/TSy/tlGgGNC8fplgS5MI8meArdig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNIq0lZD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNIq0lZD"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234c5b57557so16458785ad.3
        for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 20:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749784334; x=1750389134; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pUMawIHS3ge9aNMrUwuQCI1wFUmsQ8BlgJBs2il1xQ=;
        b=cNIq0lZDeBKtfri0y/5ajyAlwgjdjWj/MASzCXRyGGNOVmNmCYEDxiX0yUr5BRqSTA
         CnqMKHZ3T86jl58dvQOtPSJJtMrOKfGCm8PFpS32IwQkUWpSXtk7PJDR+Qu02Cy2WPPA
         zgk75eMi4rnTGB0T+Wszr72EZDEW5tkoYhmgDmOVtqVy/5t20KqLvRSC7H4Y/Bj4nr5u
         QF83/gTK4BsNoHIijzrPgASqOb/p74vUAYBcjbi7kkCN6GLlzU0xDQpR4d8ihppNWolv
         zVpChMO31qzWhlnW77zenqmAvDNqvj1mrFWC07qRo246mgN0WS6vVHMswp58muhUQI5g
         Yr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749784334; x=1750389134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pUMawIHS3ge9aNMrUwuQCI1wFUmsQ8BlgJBs2il1xQ=;
        b=VsUtXMOiYO2PDC5OuBbFlSTN9fU/M+W4OrztHXd+f6eMsC1T3gop3AzF04zyLr/WsT
         cN5rJiLfnE8qfdNhAA+Qm9IErRMHWZk+PdezXQf9vwwlbU+9vrdBq1Sn8BUh+ZOXOgiv
         r79Rl9sfAri2cALk9ow8PGGE9hEela/0eZKQ+u+fSbZJ7lVoWqO5MgKic61K8e9IUrWR
         Yj75vECkc9AtiZf8JIG5XPiNoA/M7fx8W5+0iBxccMTwkaaJviQvuFnXpbWC23FSP9/F
         IjhUostWkqDMabTPnyAuhbwyGIczTOoa1ze4UmDF5qoWEdS7XMc4VckWIvF26MFR0Z9j
         eWNA==
X-Gm-Message-State: AOJu0Yxy+yjHsfuDkRK+h9BMOSP1pvJdtEJOuqChnR0QgEP2y0WW+qVV
	EIUvrHhdwftMFttAXKKLBwqQowHhCbysSZ76HtMpC6PFbF+dEXDVjkVg
X-Gm-Gg: ASbGnct7ga9spiMG/07+tQjopOr1mii4eA1nV1A86AI2wsCMI+BAFVjoBXk1AgTpEn2
	HPlYbM2PMEdpgTJnI1xvZlPx0PK/Koh1HKC787XP4QqPAc2S/Y9GFwE7b90AHMhiNYhRSpA3E5U
	CBwKiZU0/EeHDC1F+o30NVnjbb8FXtxLRw63EwQakaty7Pk/8ZYrGsGJ6KXD1w18fIz7RCI0WfO
	+yOOAEgDNkYRu3PLL1/H3pSvUbB/vI+zv7Y90X+YfZgRtZ3U6QSDCzIYiCT2CmqfiprCnoOAoZH
	mHy1sxDq0GbTVawFu/iJrbmn2iE+N06v0ybjIS4r1AaxD/Vsu5AST9xMxm5drQDS4pcpfaiPonr
	e1KUZ7oyC6bmTEtbIg8E=
X-Google-Smtp-Source: AGHT+IE/WULKBGn+KiKpo+6kHWGrSlbQfCN38Xb5dm/8MIQWGayir5xKvllT8tXaon8W9A8tUHwuiQ==
X-Received: by 2002:a17:903:1b2c:b0:235:ed02:288b with SMTP id d9443c01a7336-2365da0bb53mr17826825ad.30.1749784333984;
        Thu, 12 Jun 2025 20:12:13 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1bcbb39sm2291801a91.8.2025.06.12.20.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 20:12:13 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com,
	mst@redhat.com,
	pabeni@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	stefanha@redhat.com
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fupan.lfp@antgroup.com,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [PATCH net-next v2 2/3] vsock/virtio: Add SIOCINQ support for all virtio based transports
Date: Fri, 13 Jun 2025 11:11:51 +0800
Message-Id: <20250613031152.1076725-3-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250613031152.1076725-1-niuxuewei.nxw@antgroup.com>
References: <20250613031152.1076725-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of the SIOCINQ is obtained by `virtio_transport_unread_bytes()`,
which is generic for all virtio transports. The function acquires the
`rx_lock` and returns the value of `rx_bytes`.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 drivers/vhost/vsock.c                   |  1 +
 include/linux/virtio_vsock.h            |  1 +
 net/vmw_vsock/virtio_transport.c        |  1 +
 net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++++
 net/vmw_vsock/vsock_loopback.c          |  1 +
 5 files changed, 17 insertions(+)

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
index 36fb3edfa403..74c50224431e 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -196,6 +196,7 @@ s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
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
index 1b5d9896edae..59e72d2dbd85 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1135,6 +1135,19 @@ ssize_t virtio_transport_unsent_bytes(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_unsent_bytes);
 
+ssize_t virtio_transport_unread_bytes(struct vsock_sock *vsk)
+{
+	struct virtio_vsock_sock *vvs = vsk->trans;
+	size_t ret;
+
+	spin_lock_bh(&vvs->rx_lock);
+	ret = vvs->rx_bytes;
+	spin_unlock_bh(&vvs->rx_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(virtio_transport_unread_bytes);
+
 static int virtio_transport_reset(struct vsock_sock *vsk,
 				  struct sk_buff *skb)
 {
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

