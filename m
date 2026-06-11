Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A0F2E2DD2
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781144026; cv=none; b=fO8ZOcbd2eO5WKjPSDStqBtQIpn1ticA/aEALSWFBTMYmorC2BHuuElJaJTz3zFsHZhOC9oBREQN+zIdwsicWtCDvDARZbbL/b8frMez2xJIcNdupsQ0aTwURoyzYc9GLQ8fw0Lh4YA4CIH4YZni5JJ62oDSHXrmXbOLRopIIMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781144026; c=relaxed/simple;
	bh=CBIsTgpYepvuCGXqFToVF+k6SD6b2t65VP4Atc30Lzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2Yb6yMqmLVZu7GnGmSKihDvivqV7RRYx/tVutMdJVKqBjg+qGZxvLe0vmb0+8Hg/2x/C+T7spDYy3VjlNFEbHVBHnRZ3guy218iNqiJTvEJEDzPwhEeVp1bhrbAq9/kU4j7caV/+r5hxZh4uNuRZuhCYsXrYlSIcAm7pSDT5fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oqyoHxu4; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqyoHxu4"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36b8d414666so4168661a91.3
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 19:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781144020; x=1781748820; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnYLzFvhBsoLcQfgDB5iqWDqZ07p+tRABlGYQccfF3I=;
        b=oqyoHxu4hHwVFHqp72TNI52p4Ysj5eo9Jz5nPe91rfdRXNexh6niU/9I7AkALr7JAU
         MtYY30F/KrZsiyLV/xEirnNlvA6tULuvgexJWcMZf1qW5Gvc9fd6cW+Y5ZWGtA0ri2vL
         aht9U2Q8aW6XyxVGxO0jScPoh6TdheNrtILggeiOHP42aOqoSfxnpQtLKaJY9WPCpvzY
         NnYu1o1AekIo/pBXLUatfb9COXy2P8y/1fMMiXsyoxpuqvudZIMZdLzOtC2UDLeBpIYb
         mlSa2mp2rZHZ6ZELO8ib3WVmCl9/r9J6gab783WrUN02qPIs8b7lVe/CIhpRVZcI+Ps+
         owWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781144020; x=1781748820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WnYLzFvhBsoLcQfgDB5iqWDqZ07p+tRABlGYQccfF3I=;
        b=SDygVukHn3EPp1c0HuGbiPwqcg6JMVbCy7QIfZoRdTXO7uJzr665/59EgBNrqnefef
         LASLxmIIEoqZ82Y7czAlD4QtJRCgK7jv9TKIC0nKOKpT3tZ/+N9FDNtFU7mccLh0fS1b
         vu+WakkgKTh1h/2sYLYYrmVVnZ9gOa5WbF/yVmDWVg/X3ykfJ69lsvd+rVmItFkWvj3i
         4f0kSZlavORcdDhf2OC5GSik0vJsbUYDHkDcLova3XQC6OeXdEEknAngbXBNzA4m0sRR
         hzXeyWJoh6Tzj0q1Tj54U9mcHyXb5V8Nu51vwXJy2qKQAtNQi9d7+6jBD5f8sC+5U4Ll
         jJAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2/2M9v4TNorTFSn9tR3Um6aIPRIfB3sdZLuCD94YvPcvjk3cv7DZlXJLz6G4mHLG6HE8Ors3PJ4Er7/Rh5A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6uZVv37zLp+JKX9BiM5n1zc/jIS4pBskA1V9x3Hp6Da2fUq7b
	klCDNvbQfOlSU4PB1j6IMVq/Iu+Dyry2mUMHOdKSdVLOW0YLzJXKAxg=
X-Gm-Gg: Acq92OG7oQeSxTXX3oNvRC2EwlYIfbKNEo5NHRf+kHb7aBohKiOn/1qVx94IrCZ0H5W
	bRHf2jnCinCrohcXeDxUkxCd2YE8WaUpWxrdNTtwwHplRhBacClO6xJNwLjk4IPkCa5L/5rTIM8
	ZB8pWQtaWKu7auG9xJCRAxmycYm3aueXaqrbd1IFgj3Xk0xQAR+MUR5k+ntyDtd7cZCX30Fhh+u
	UPnkKqOc+p3ZOqzIoB5qNYyjm2oif5NtQmfVQ64pvqU4JNiCDDlRkumwmHI05hgBZzQBgVjVS8q
	OE/dqPAXfgVwYYrL19ILILHVlgYJSgvryv/jDuYy69LnwInAxBenNZmkxR2bMP3p2j0mVAWfvZ1
	BxNVLzAg19FWhPIqY8oMFZeN+40F0llTILMv9YwID/5BG4NNXjUAFz9AWxWNSZ0trjNBmwq8KYn
	Wcr7dixVtAVtWbtphbo2hLTYkMHjvE6CgWMoG2IkFwvBZF8VhpIV43bOpI5sLOvP/EH3f4gAkQ+
	F7PTsSqIlKHscW0
X-Received: by 2002:a17:90b:1fcf:b0:36a:95c:7613 with SMTP id 98e67ed59e1d1-3779ecb811dmr908513a91.10.1781144020432;
        Wed, 10 Jun 2026 19:13:40 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a0eb9sm732006a91.4.2026.06.10.19.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 19:13:40 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	bobbyeshleman@gmail.com,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next v2 1/2] vsock: fold sk_acceptq_added() into vsock_enqueue_accept()
Date: Thu, 11 Jun 2026 02:13:16 +0000
Message-ID: <20260611021317.69362-2-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611021317.69362-1-rafdog35@gmail.com>
References: <20260611021317.69362-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio and hyperv call sk_acceptq_added() immediately before
vsock_enqueue_accept(). Move the call into vsock_enqueue_accept()
itself so callers cannot forget it and the accounting is consistent.

vmci is left unchanged as sk_acceptq_added() there pairs with
vsock_add_pending(), not vsock_enqueue_accept(), since connections
can be cleaned up by the pending work timer before ever reaching
vsock_enqueue_accept().

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>

Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 net/vmw_vsock/af_vsock.c                | 1 +
 net/vmw_vsock/hyperv_transport.c        | 1 -
 net/vmw_vsock/virtio_transport_common.c | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2ce1063d4a..73e6416ee9 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -507,6 +507,7 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
 	sock_hold(connected);
 	sock_hold(listener);
 	list_add_tail(&vconnected->accept_queue, &vlistener->accept_queue);
+	sk_acceptq_added(listener);
 }
 EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
 
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index b3394946b2..0de8148877 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -410,7 +410,6 @@ static void hvs_open_connection(struct vmbus_channel *chan)
 
 	if (conn_from_host) {
 		new->sk_state = TCP_ESTABLISHED;
-		sk_acceptq_added(sk);
 
 		hvs_new->vm_srv_id = *if_type;
 		hvs_new->host_srv_id = *if_instance;
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index b10666937c..4a39d48db9 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1582,7 +1582,6 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 		return ret;
 	}
 
-	sk_acceptq_added(sk);
 	if (virtio_transport_space_update(child, skb))
 		child->sk_write_space(child);
 
-- 
2.54.0

