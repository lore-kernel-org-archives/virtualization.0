Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE18D6CDA5
	for <virtualization@lists.linux.dev>; Fri, 17 May 2024 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957191; cv=none; b=g2EWRaaadTAADeF68F9a5rQnyW4tbXD6Et2IHWnpUY0HTpwbHdlhoKMarBbOA5TYO358V0Flg0W5al22AZ6CtSRfVlXbezt+MTUjBp7ZMoLqYyhhGTDQIeqyl/xGVCKtRYdjy6E9GLoN/cJbOYFuCzCcx3jZd8ZLlmi/C9TnPPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957191; c=relaxed/simple;
	bh=ayTww+DFRdv8kU8QHxSwm1TVYpqV1rJoYpxyAD0nsTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L+Z697smqoawmMqHmdXnd0RcKFI7wC0t0dtMxLshQBa+P9Xdyx6D+UvV2tTIbamWQIfbVkPtAm6vspKyXckvSsoNErGjZ4LWTnQoLUJUBp1ZNw9ACtEePiWP7KKORDqjxhvi3SFPxA7N76O9B9hFxVn6tmH3OslqgNQDuqs7O4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ak6vcBZp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak6vcBZp"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ee38966529so4908715ad.1
        for <virtualization@lists.linux.dev>; Fri, 17 May 2024 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715957188; x=1716561988; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObdkphHypw+pCyvAkBy4EywArmTATwnandulAo4H4xI=;
        b=ak6vcBZpFEHOdy+cxYf6M8EOIFsWUGeIRPIYQLR1IAgoQPltkZl4q/a2lTK1g2BCMU
         qDMNZivLgtmrTlOY1tUpzMXqqqdJCRSM8i4LGSDR10X76oIj0BpXLq5kmrnTAv6RMUlv
         GIJTgMDE5Aqx2tkY5iiiwksTSLxpYpW/wPJEUe/tozp4tZaM5N+3GbPfSyvFysNdf7oq
         8m6/tD6BAPbNaBxLmbok5O22WJU1+urYx3BF/KTJ+sH8r8sJsV30wAu2cd5hcSi1UARa
         cbZmYBxh7hn9TZ/dbV/yLQ63+G6HYk2URcPUrnSXU82jNa/nqgvuEppuWCp8ZmA1wulV
         ohgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715957188; x=1716561988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObdkphHypw+pCyvAkBy4EywArmTATwnandulAo4H4xI=;
        b=PdA2iLGHDT32yz75rcOPQktVihSKCWzbCBES5zdpWtSyApzrKkooYWDU5+e2dB7yPC
         ExznuT997fbD9XLQjgJhXG8V50tEgStCGJasdUkv5N259b2Tj2JUbYk8n27PJ70snxgV
         TJnm0vdTS7rrZMoiHVbcRef5wx+J7Lg3OwJ9+NECQToKxoAeo8EEUXWaVBAkTJwSwaP8
         qNQZomtlnC7k/UtQ1VS6fa3crdizKQWlDvMkZaNOuMThhh4ATwY9Wjq+uNOCoZpAOF8a
         YRwGzvM0dFkXCCew7SxOMXsptJLzhohJrfKn/YFrCduRV7HgMb+Q/LCFcLHkEXeh5Ag0
         E4qw==
X-Forwarded-Encrypted: i=1; AJvYcCVgLGFwmwbP5X+cpEh5vMw2aQuD2UC8HA8iyaf7P9gkm2JBbLyToz3sK3g1zQlzvZ9zrPySgHu4NEORJcBflTJPBo2CCUicOmzs5EvCVRw=
X-Gm-Message-State: AOJu0YwugvVlSx21K+67RMG3iTILNuIcMjFtw/KNFcnE2AJE6jhL/j0j
	lTR8apOUDTqMVu4sitGySnEGu2CTUrw9gcsAHMvmg95ZP34p/4iy
X-Google-Smtp-Source: AGHT+IGznRigy/pv1m+3lTVs4TUKCUcENj3vk2rDy123ij37qxwzekLbGPS3kJ0q5z1BkgDnP4tNkA==
X-Received: by 2002:a17:903:18a:b0:1eb:7855:43d5 with SMTP id d9443c01a7336-1ef432a0bf9mr313781075ad.30.1715957188387;
        Fri, 17 May 2024 07:46:28 -0700 (PDT)
Received: from devant.hz.ali.com ([47.89.83.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c160a1esm158504985ad.279.2024.05.17.07.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 07:46:27 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com,
	davem@davemloft.net,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [RFC PATCH 3/5] vsock/virtio: can_msgzerocopy adapts to multi-devices
Date: Fri, 17 May 2024 22:46:05 +0800
Message-Id: <20240517144607.2595798-4-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517144607.2595798-1-niuxuewei.nxw@antgroup.com>
References: <20240517144607.2595798-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a new argument, named "cid", to let them know which `virtio_vsock` to
be selected.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 include/linux/virtio_vsock.h            | 2 +-
 net/vmw_vsock/virtio_transport.c        | 5 ++---
 net/vmw_vsock/virtio_transport_common.c | 6 +++---
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index c82089dee0c8..21bfd5e0c2e7 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -168,7 +168,7 @@ struct virtio_transport {
 	 * extra checks and can perform zerocopy transmission by
 	 * default.
 	 */
-	bool (*can_msgzerocopy)(int bufs_num);
+	bool (*can_msgzerocopy)(u32 cid, int bufs_num);
 };
 
 ssize_t
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 93d25aeafb83..998b22e5ce36 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -521,14 +521,13 @@ static void virtio_vsock_rx_done(struct virtqueue *vq)
 	queue_work(virtio_vsock_workqueue, &vsock->rx_work);
 }
 
-static bool virtio_transport_can_msgzerocopy(int bufs_num)
+static bool virtio_transport_can_msgzerocopy(u32 cid, int bufs_num)
 {
 	struct virtio_vsock *vsock;
 	bool res = false;
 
 	rcu_read_lock();
-
-	vsock = rcu_dereference(the_virtio_vsock);
+	vsock = virtio_transport_get_virtio_vsock(cid);
 	if (vsock) {
 		struct virtqueue *vq = vsock->vqs[VSOCK_VQ_TX];
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index bed75a41419e..e7315d7b9af1 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -39,7 +39,7 @@ virtio_transport_get_ops(struct vsock_sock *vsk)
 
 static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
 				       struct virtio_vsock_pkt_info *info,
-				       size_t pkt_len)
+				       size_t pkt_len, unsigned int cid)
 {
 	struct iov_iter *iov_iter;
 
@@ -62,7 +62,7 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
 		int pages_to_send = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
 
 		/* +1 is for packet header. */
-		return t_ops->can_msgzerocopy(pages_to_send + 1);
+		return t_ops->can_msgzerocopy(cid, pages_to_send + 1);
 	}
 
 	return true;
@@ -375,7 +375,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 			info->msg->msg_flags &= ~MSG_ZEROCOPY;
 
 		if (info->msg->msg_flags & MSG_ZEROCOPY)
-			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
+			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len, src_cid);
 
 		if (can_zcopy)
 			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
-- 
2.34.1

