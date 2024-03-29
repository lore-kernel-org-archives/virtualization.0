Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF8010796
	for <virtualization@lists.linux.dev>; Fri, 29 Mar 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711728806; cv=none; b=nWs18CGS6YPSd5PiKVMFkZzA45x1wT2RCnjkW7y/CXugOpfs1gGyfpqSGcMYY+7B+lfVQfbtqHWZX121b+y/+sqqFpYJzCSAkZmXKFEcYDfDV0awYgu1vQS3aooqNyaRoIuPRgJycjOnoV5tBsu71tPomUNHNovtCaHjDKLVJOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711728806; c=relaxed/simple;
	bh=I6FaA8lE1xu3cAiFmF8W7/Zh4WtxN7EK1Ev2dqCqEoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TdzyUoXl+4HQ0UCL3cLzwG+aM4kpgUqJFMZmp3ledCMtyUnn3UbM0ecWe3oVoPMPSABF2BynfdD7/KkFdv3TXgxiDBBC+eQHiJUVhP+nfzMTywk3NLulf7hS7AH6Mc67EyiILHbP3HE6yzgGFn6BD0dvxAz0wegXcr8hnCxwUho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BB77Mmza; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BB77Mmza"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34175878e3cso1550300f8f.0
        for <virtualization@lists.linux.dev>; Fri, 29 Mar 2024 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711728803; x=1712333603; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g+ENIHdShqwsDq8iCSWp4zm4/fE/0J9kqrrA/ykJ7CU=;
        b=BB77MmzamnH+qIU1jQCjQ7MI0Wr5ClwJdvNmqLKAuAxb4NPbUPWwHSBqMkYyOO2guq
         iuy7X9+SyjXvHnnL+TsuWMMpXYRwtiiRb16DxBShRGQvCyriRQKSR+EDAIJk2nN+IqhF
         BVjfJQAc1tT063vNWAEhNFCK9MwRHLjiyallMpTGRVw22z8HQudl/zXF43J2Ah3giP7c
         lY62ErPYPN2qahJdbPENmpuLQ+Cp5TniQIurD0FcOX1F0Cchluz1NJrpN8p7MocaoTzW
         RgKhBuj6gioL97A8rJkHwu1CFDMgWRX39yQtIg7BBxlUIXFlc3m0woPJgtW5+aVKGgUA
         7B6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711728803; x=1712333603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+ENIHdShqwsDq8iCSWp4zm4/fE/0J9kqrrA/ykJ7CU=;
        b=co+ZTHOyMIUWu+KhbgitmiVLnx2YTVGzCdtsUOSoVQ7jpQ5K+wHxtcXF6B8ZFqGTx2
         bLBIbjs2GwhpvdN+lpqPw+ZGr4XUzRYKjJ7zJhJp3cS7CEDtyyFMsXmWfRmFsw1FRyW3
         6eyrz5TMYelW+uzUN2Nx8mCVOgt3MbsN3D2D13/GGhNu257kxGGgNmLall9ghcAAiSBq
         +4BQSey4JH7CODb5nSGoY5nechogAhvXFM2DXqs/VgBoaonPsDMszHyfwK5Uolo/oHPD
         UpgzTshRzaL6Uve+3n6N/RgdqaIy67q9PU8nzj4HG0JysDDPYoQYk+JewKkKRAUpC0ZV
         hY1g==
X-Forwarded-Encrypted: i=1; AJvYcCWCB7+zvZcug/v4jEnaSp0Y3QCjpOlpq0rSv2gWYRBy+nkg4VUjDlq9QGoBQQjvY86OeE+iy/N29h82sXd6E9wFMT9+rsLRAZQGhZsyXio=
X-Gm-Message-State: AOJu0Yx2hFPvbynuw9eBQ7OArMmE/Cf5B5O7geJ3bUuT+6ky7Y6EaT+j
	c/4LDHzF5uzEfUNAnx8hL4SfurwiBFGINRTiMm/o1Qaa688A2yFB
X-Google-Smtp-Source: AGHT+IFlnSDXyqsWCoK4FhHyzIj1G42ZayTzwCniQd6CJMOPqt0tBI0jfZghP0OMpk25e+c8DeoHdw==
X-Received: by 2002:adf:f982:0:b0:33e:c69f:2cae with SMTP id f2-20020adff982000000b0033ec69f2caemr1453465wrr.23.1711728803359;
        Fri, 29 Mar 2024 09:13:23 -0700 (PDT)
Received: from localhost.localdomain ([82.84.234.137])
        by smtp.gmail.com with ESMTPSA id u4-20020adff884000000b00341d9e8cc62sm4464208wrp.100.2024.03.29.09.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 09:13:22 -0700 (PDT)
From: Marco Pinna <marco.pinn95@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ggarcia@deic.uab.cat,
	jhansen@vmware.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Pinna <marco.pinn95@gmail.com>,
	stable@vge.kernel.org
Subject: [PATCH net v2] vsock/virtio: fix packet delivery to tap device
Date: Fri, 29 Mar 2024 17:12:59 +0100
Message-ID: <20240329161259.411751-1-marco.pinn95@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 82dfb540aeb2 ("VSOCK: Add virtio vsock vsockmon hooks") added
virtio_transport_deliver_tap_pkt() for handing packets to the
vsockmon device. However, in virtio_transport_send_pkt_work(),
the function is called before actually sending the packet (i.e.
before placing it in the virtqueue with virtqueue_add_sgs() and checking
whether it returned successfully).
Queuing the packet in the virtqueue can fail even multiple times.
However, in virtio_transport_deliver_tap_pkt() we deliver the packet
to the monitoring tap interface only the first time we call it.
This certainly avoids seeing the same packet replicated multiple times
in the monitoring interface, but it can show the packet sent with the
wrong timestamp or even before we succeed to queue it in the virtqueue.

Move virtio_transport_deliver_tap_pkt() after calling virtqueue_add_sgs()
and making sure it returned successfully.

Fixes: 82dfb540aeb2 ("VSOCK: Add virtio vsock vsockmon hooks")
Cc: stable@vge.kernel.org
Signed-off-by: Marco Pinna <marco.pinn95@gmail.com>
---
 net/vmw_vsock/virtio_transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 1748268e0694..ee5d306a96d0 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -120,7 +120,6 @@ virtio_transport_send_pkt_work(struct work_struct *work)
 		if (!skb)
 			break;
 
-		virtio_transport_deliver_tap_pkt(skb);
 		reply = virtio_vsock_skb_reply(skb);
 		sgs = vsock->out_sgs;
 		sg_init_one(sgs[out_sg], virtio_vsock_hdr(skb),
@@ -170,6 +169,8 @@ virtio_transport_send_pkt_work(struct work_struct *work)
 			break;
 		}
 
+		virtio_transport_deliver_tap_pkt(skb);
+
 		if (reply) {
 			struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
 			int val;
-- 
2.44.0

