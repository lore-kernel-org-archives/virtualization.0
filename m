Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2FA30AD05
	for <virtualization@lists.linux.dev>; Thu,  1 Oct 2026 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856972; cv=none; b=VzeXLbwLHpAB/GG8INLTrahS+yI5x0PolwoFRv7q+yBsIun6VC991kNCSezNYnNmJmYfTaN60bklk7+tVm24woBtmc4wKdUwIOSWaTfdRWqfECMOUu7K4J/TCFXIYwMZWT6x1WexTHVb9Q2UHXhAQsHE6A9yMnj4IDXxNk03EC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856972; c=relaxed/simple;
	bh=4BLrtmzurW8UA6fVSeNeIt87jffuF6uA+vo/13A2Om0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g9K8xrWVzZJHyxQz6cs0ahpVDJRdtozELD9oga9dzV2/9jvx9rEpiLuaFGPVjI7wh+59wFHvKOhfibZ32KeyABHsYHSFniQhr135zgyzTaY9F3fCLthV84L33Rt/zA/u6UyhoD5NSM3k2vFMbGUWkPz6D8jFBkA69rzkDKxPsHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5hFTNH4; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5hFTNH4"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso4620640a91.1
        for <virtualization@lists.linux.dev>; Thu, 01 Oct 2026 05:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790856968; x=1791461768; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IYDWZrZ8gM+j3CLV2m4lS/hjDIinyiJ4OzY5zDftFc8=;
        b=N5hFTNH4lerEapaiMvcOssPhyKcInnfWbhIeFvd3biWbyDNuCPORoqO97aM1dbM/XH
         5YpaF34PH8z0yxczyu/s87UCBea912txo7W22IWYDY7ZiILWCHtuVS7fcYMvDgvMgXBU
         aqgGAytCbzbCLE8Kcdptw2Fi/ROsuvVgKBSsr0HugH4UYfT4ZM4etRpYPeABERxcUQ/G
         jSmwttf1GeEWHB0quzVObHrA/sLAko/OzPuETOL/8+4BBAe8hW/dSNtfbuxgvAWHqBhW
         NWetAbi2QIZ5mAnkbtsA96dNaeRv3tl9PgpqnPuY3VQt+IZjMU4YX/Ry8XX3nxX25LZq
         D7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790856968; x=1791461768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IYDWZrZ8gM+j3CLV2m4lS/hjDIinyiJ4OzY5zDftFc8=;
        b=HqAXGtPjxNKm4/8wnPrLpoGsiC+Vy9sH5sceMR+t7zS8UotqRv3RoQ1KFLVdJlKcKW
         jMZIa+iVyF0Fy1BiBl4g0PRQ+TDGDBvBJl4in8YXFOacu9WUuIT8EYLo1gKd+pT2KBDU
         6FGSm/+Cfdt4XfIcgF2mG9zEv9HqRcyuI7z3K2gey6EBcpVRRDxwg53d3YfgBc19wFB0
         LPfj6lU922OW8FKGSFS3bfgO2X83YMe9V2Jdf2rAPiwunjzIuTjev+K5X34rG4gJGd4O
         L/oggU0tH42m6BgjyXMB4izlMibYsoxXFOTsmErSwYTx9m08oRf4z5GP55I0/IrnRhM2
         secA==
X-Forwarded-Encrypted: i=1; AKwUvBz5+kSGwcyB0CLizJAe96NhTXEULY+narHZNutA4GaAQuUl2zzcbJCPd+pTJCMpUtSDw9Kzl6t7ZxVegCwrkA==@lists.linux.dev
X-Gm-Message-State: AFq9FYK3ycCIhxk9hyJcoeniGPrnsTmohwLffdSMYnZA/Kaekk2p8YFf
	/9e9E8qT7L5xcLNluwO8RZQO7CG5NGhKTR4kvSglCYsgMOTim456IZAW
X-Gm-Gg: AYBFou3taIzdGNFUNE9mXUjRwM9gUb93s3FsPbmWDwPKwtV12BXGMlKkuLQ3VAjjesR
	YTpFdltHq6Zo8c+qtvoLZRyfkuc0k4WqEr35E7gzjzUWHgZfXxBLJRcWBQx1mZB+FHloHsMObwS
	a2AKll7Thh1sluTbj3D9NCyGqXOjUV7tzw2Do0C3zGZPacnPkJ685jzJHsGvgdE8OiYcSvejKT5
	UzXP0EcLidmdwhdPlnjjzRhdQG5AVHYE9uAbQiKb9bs1QPV58sx8EYQq8qELHDH0WBx8PmBXsyq
	hLcXAmH0UxSACDEsENXMfQ5xe7vrvyUzsC5ORY6vhTo6kQQU+W8xH7vEu6yqf789hqDwc1D1D+k
	KWBFi2VFP4A87+glrr+gJ8tjyCnKk3YfNLBq8BowaL5/nB8yreAs37syMhyC6EwakJQNs5/iSPS
	VgCvXLaV2CkxuaV9BINwxjd71WDk5aKtvxh/QHPcklyuA1ymq+jhw1TIa504ILz1Pg8xJN6PoY8
	zaZUoMu5Po=
X-Received: by 2002:a17:90a:fc47:b0:39e:2e7c:d43c with SMTP id 98e67ed59e1d1-3a4d102d65fmr3985879a91.7.1790856968300;
        Thu, 01 Oct 2026 05:16:08 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f43c8b02sm4352278a91.5.2026.10.01.05.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 05:16:07 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] vsock: account only unread bytes in read_skb()
Date: Thu,  1 Oct 2026 21:15:41 +0900
Message-ID: <20261001121541.2983379-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a partial stream receive, rx_bytes tracks the unread suffix while
buf_used and peer credit still cover the whole packet.
virtio_transport_read_skb() dequeues that packet but passes pkt_len for
both counters, underflowing rx_bytes.

On a connected CID_LOCAL stream with an SK_SKB verdict, a 40-byte read
from a 100-byte packet made SIOCINQ report -40, an empty recv return
ELOOP, and poll report the empty socket readable.  After verdict detach,
receiving 40 bytes wrapped the counter to zero and hid those queued bytes
until one more byte arrived.  The fixed run kept the counter balanced
and exposed all queued data immediately.

Subtract only skb->len minus the VSOCK offset from rx_bytes.  Retain the
full packet length for buf_used and peer credit.

Fixes: 45ca7e9f0730 ("vsock/virtio: fix `rx_bytes` accounting for stream sockets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f225f53ed4bab..1e762a480df49 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1927,6 +1927,7 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 	struct sock *sk = sk_vsock(vsk);
 	struct virtio_vsock_hdr *hdr;
 	struct sk_buff *skb;
+	u32 bytes_read;
 	u32 pkt_len;
 	int off = 0;
 	int err;
@@ -1946,7 +1947,8 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 		vvs->msg_count--;
 
 	pkt_len = le32_to_cpu(hdr->len);
-	virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);
+	bytes_read = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
+	virtio_transport_dec_rx_pkt(vvs, bytes_read, pkt_len);
 	spin_unlock_bh(&vvs->rx_lock);
 
 	virtio_transport_send_credit_update(vsk);

base-commit: e23a64eb244356ee47c0620f0722d51bd88db522
-- 
2.55.0

