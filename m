Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A01402435
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777552017; cv=none; b=fGXyEnD5gMy/fmgJw0SPzPSXDL9Q9jcRw726GfMTV6Iwwm+1J2Z1yaCylLUj2oPLF4Xq1LslUv8955Qt81SiDz0YDUmc1YC8UKlpIxzl4uoFbxJ+NNtOL/QWcFCx8zgrmFfr01Zk94HI1EUMa/Oi0iUWCHJOHvdZxuEA+nvXQuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777552017; c=relaxed/simple;
	bh=Q+CUg+VsmZKjq366q44C8YuEEFsvKKcl8wiXNOwD0e0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CnazhaN85EYQ8QvaScOSjCNJmo2ALpsqkUmPVcDYzUxXhA+6EGmIDiSw/5lYj/sB4XQOPVO9mA9BCfL/WXLe94/dMEIS0qxabnZlVs6TJU3G5aujU/AIhudczZuCFM6/ugGwvyYpP9CyVBDVXxeOK4IsHAzidiHDYy6Z3cSxxI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qwAko7zY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qwAko7zY"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-79472373f48so15100587b3.3
        for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 05:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777552014; x=1778156814; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ee+M/5NYR6efU5/2iPR/zMWzx0RQD/fTLUx2lJ5g5rk=;
        b=qwAko7zY7Eya5nTT/XwqjlhAeoFEzLAi1Bhj3pvnAdc+piYvJIm8PM9tTbAq6M9nIZ
         5TCUMo/CkSe59nXZnG8WagYH8GbWRfVM14l/M57Yr5MHndf3v+wJLmbl1yAdyO1FY3Zz
         ZLmBbNAmaVH00XVnTV8a0CTfwgNjleDhJCAA7Bxf8eqf1mffaqWyh0uwApYtOfbomotJ
         eCgrMCdADyJ8K7sIObP8dF9l729d4yfJdspUhrWnn7SdHk0D+vH/dMSj8XyjWVFPjuYZ
         I10OTEl7DW5/HvvYkveB8tAelseRCfvnZeWV3Ujp/tIiGGzkFXKlgTUOFvHmHqDW9lA4
         /miA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777552014; x=1778156814;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ee+M/5NYR6efU5/2iPR/zMWzx0RQD/fTLUx2lJ5g5rk=;
        b=juCf5AvFtux0Cg6Y6G2UY8ind03APYv+HoJYpAZX57JSkbKxXif93BvfB6lpMwu7xg
         Qfzy1za/Dwx547dTn/wiASdLvyAly9LYJ7UQ+xLZO9IjS//bNNppXLa9i/NT3hcNN91o
         FoPwXlTHDVT6CUQh/lBSUz7yHoHVP2mVfSXfbNwjKLhpBeUhIzKlqgqNUiohIy44JHM1
         IYgp0XQEmUvZy8huSWzDX4hy4tjCcylMkeG7N6HkGEv1N6LtriITVBI0dGSVTIfKOjE8
         rlcfkyTHWO9VDJC+CN+Zafv8GpVaEtP0FeJchwGVfQHvCHYKIeVAilKS166/dNVmxJW6
         8O5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+/TvGQ4xMiW1/1Iw6Rlad/9xTL8Vk+aBiJ2UoEazfzshVHJ8fD+yn//ZJF05uCvjyuXxiUXzutRJ1iW5uN6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFFH0n2FQHFZb7Dlaa9rB3kPCtZTMYu00vTqT5/rghuvWRMi11
	I4Hl8iaoJ7peiKDB9Qdhrf74zhpYvpWNg0Se6pk1vbZd1tMvhWRfv0j928Wty3SCBBAp1dZkX75
	XYncJC71v4mWC1Q==
X-Received: from ywbnv28-n1.prod.google.com ([2002:a05:690c:931c:10b0:7ba:eed4:c262])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a81:8ac2:0:b0:7a1:3088:e528 with SMTP id 00721157ae682-7bd5286eebfmr19968607b3.18.1777552014025;
 Thu, 30 Apr 2026 05:26:54 -0700 (PDT)
Date: Thu, 30 Apr 2026 12:26:52 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430122653.554058-1-edumazet@google.com>
Subject: [PATCH net] vsock/virtio: fix potential unbounded skb queue
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.

virtio_transport_recv_enqueue() skips coalescing for packets
with VIRTIO_VSOCK_SEQ_EOM.

If fed with packets with len =3D=3D 0 and VIRTIO_VSOCK_SEQ_EOM,
a very large number of packets can be queued
because vvs->rx_bytes stays at 0.

Fix this by estimating the skb metadata size:

	(Number of skbs in the queue) * SKB_TRUESIZE(0)

Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credi=
t")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
Cc: kvm@vger.kernel.org
Cc: virtualization@lists.linux.dev
---
 net/vmw_vsock/virtio_transport_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio=
_transport_common.c
index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fb=
ba4dfee58bd64 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_=
sock *vsk,
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	if (vvs->buf_used + len > vvs->buf_alloc)
+	u64 skb_overhead =3D (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0=
);
+
+	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
 		return false;
=20
 	vvs->rx_bytes +=3D len;
--=20
2.54.0.545.g6539524ca2-goog

