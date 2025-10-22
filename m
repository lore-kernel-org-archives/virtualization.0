Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A343E25783F
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148665; cv=none; b=cP2Fjzc6se98EKZxIONoesngnB52f/Oe/xN0ChyOxBCHmD1DsDV9FIPyvQnrnKVH2k9waPDi59EDCQNvZxNPikMYBD8KEdlnnpKWbr42EKrbsL9R4k5nVO3fgCCWRUxnqvGjnY3qPGoYfJUqUgMgyAkyMbCrHm5aoc2xTDq2M8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148665; c=relaxed/simple;
	bh=dbCAjiJaJQiN/J2VVY9g9g6U74sYQAol3HyEtlrFnUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SGZ3kaRdIX/qmRzRPkiub78IOCPBSQqi1Fmv9MG2MxMrRFcLdHwBRbHMBq8LyaHK28mjFR4tdOwkLURaxY23SS9JSPZ9Fxj/lSHhJrB06gmq7vuTvCFUi9BQSxysBLtNdG9bACMminA/b5Lcvfjc5nOR+3TWytvjnGPjwQRpcDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZOSmz2W; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZOSmz2W"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-292fd52d527so16155385ad.2
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761148662; x=1761753462; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=naY20CMWDzYHs1ZYgUoMtzuy7r6fuKt6p40K/aayGos=;
        b=VZOSmz2WWCH9pzb384yjNEyZFBWHKvIBRMg2nt+kMzTh6syCRzlr7kkZ2lifhjFUv/
         Gn+7pheXIEhCmU8UHzeieogOBnIkWuUcvEmr4zLHH3C22YfWCs+qwA0tfiT4DLxg1NAu
         iXT3lBN4lXJUWwW/F7J9t2CjzVR2KxQn6vhQo7MTtPq5XTebWGAQS6TaTSDOVvJmRJZH
         U1mgTT4OIz1Tsu9nBZ8J28cC49Jt9jwCKso4F/aW3Sc0AJ0lKGl6XXGuKbhwkfejP29F
         FmmCOBMj2J3aOWG5Jnz+k8QRYwfuTIgSs9HK92hSNNeVgZh3N9H7/DFWZVsUoFh/y2Dv
         X+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761148662; x=1761753462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naY20CMWDzYHs1ZYgUoMtzuy7r6fuKt6p40K/aayGos=;
        b=DNKN6PMcrCwLjRs4NEms7ylPjr7xQ/9pRQBS+xCyEWRZ8ijXAdwE/1LulUPi0cgNsH
         97KbcaaiEkVbDAMptk1I3a5q3NMrsLlWQjZYcMbBZ+95GO0jprw6hZvGZq+e8rnZOfGk
         LJ9R7qxUPSiuOgCvNDYLAN5ESaQs8DA0Sf5BByqVfMyPqM7IYYpHM06Oqv0D7liQ1PdA
         7Xi7sSG6T6H2/1s2WJJXDis4hC5QrqRE17rtua44/Ky73OIhfT2bosARWMK+jKZIype0
         gV3lc6FHZIEUfXvuEsP98OAyCSJcd4pzMTrXQK7pJmDMfb9AwMYW7aC58IL/5JzhCIa+
         lakQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTmy6Quilry7qPkTQ6PdQMSEaHBSe8hVgh+BmerUrqnK8jWlyFO9ILQ4ahnaO/yWayCmPk88JvnpxkQfMqHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVIa5N9vQlnn+mSHsLxXW8LoT4p2zDbLq0YxwqCXR3mftculs9
	k3nj+jF+tL5Gm/n3EsVGW2vF1vm+vDCh4T50t9mW/5jYObG7bSCDSfaG
X-Gm-Gg: ASbGnctLnHLA7WN5BbK/rUQ8VupQ5Ej2xjGq5dFSa396s3JWdoRJ5w2zkbQCy7PcQ4k
	pucNSKsjchu/NWFudsA1n1PGNXkjSZ9l3sbr29Tb3oMHiyQiZSt8NLqmaBpg1J/GE8izwOgPKDG
	tYdsACaigS8V7xRXBkpGENdNWTk2XD8LHeoc9gGAVtDriYV37HG3ekedx1gaYWHyCZIXi25ybfg
	SBKH2I+CwNE6PJTJM+07fan8AYbXOGS5kluYDJsNLxZJluBV7A1rzpUcgFLJJeuAJy0izjryaHb
	vJ9T7+v4/xjBN3ySL8Y0fwwfsrmK4FguIEA9QHh89+j/JfXOYT8Ifr/H6xkYncpS5F1S7Nrxx1q
	/J5xfet7ea0dbDMTlNcClowv7OvDiBfu9717IqrDuwjrGEfuqm0hOHchGeQDww4rb2PF76AHkmo
	0hyXLumXKogQ==
X-Google-Smtp-Source: AGHT+IGff1qulcywTryt+y1hQgxYYHQojnwIuJuCP1ttfYIhTSd/04VrdxcFUc0K86XacXDYxdgD8Q==
X-Received: by 2002:a17:902:e88e:b0:24b:25f:5f81 with SMTP id d9443c01a7336-290c9ca72bcmr272142045ad.17.1761148661728;
        Wed, 22 Oct 2025 08:57:41 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:1e3:b1:dcbf:ab83])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2930975631dsm21990425ad.20.2025.10.22.08.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:57:41 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] virtio-net: drop the multi-buffer XDP packet in zerocopy
Date: Wed, 22 Oct 2025 22:56:30 +0700
Message-ID: <20251022155630.49272-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In virtio-net, we have not yet supported multi-buffer XDP packet in
zerocopy mode when there is a binding XDP program. However, in that
case, when receiving multi-buffer XDP packet, we skip the XDP program
and return XDP_PASS. As a result, the packet is passed to normal network
stack which is an incorrect behavior (e.g. a XDP program for packet
count is installed, multi-buffer XDP packet arrives and does go through
XDP program. As a result, the packet count does not increase but the
packet is still received from network stack).This commit instead returns
XDP_ABORTED in that case.

Fixes: 99c861b44eb1 ("virtio_net: xsk: rx: support recv merge mode")
Cc: stable@vger.kernel.org
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Changes in v2:
- Return XDP_ABORTED instead of XDP_DROP, make clearer explanation in
commit message
---
 drivers/net/virtio_net.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a757cbcab87f..8e8a179aaa49 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1379,9 +1379,14 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
 	ret = XDP_PASS;
 	rcu_read_lock();
 	prog = rcu_dereference(rq->xdp_prog);
-	/* TODO: support multi buffer. */
-	if (prog && num_buf == 1)
-		ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
+	if (prog) {
+		/* TODO: support multi buffer. */
+		if (num_buf == 1)
+			ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit,
+						  stats);
+		else
+			ret = XDP_ABORTED;
+	}
 	rcu_read_unlock();
 
 	switch (ret) {
-- 
2.43.0

