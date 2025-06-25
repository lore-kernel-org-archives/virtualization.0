Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6CD17A318
	for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867842; cv=none; b=d/x9ctcABKyVDsTZOZZWA/E4ZLAvuIw+Kcz4rrp+JRpF0Ba4edM6e3M52YS9Vvm0VY8+Id4Pw9rOYbZPp6dQBX36u1RrXsCPKkY8hpltDVTTT3wF8yOJlnWvWKMfBiwkCwQhvfPbYDrJ6mhO27uTF9T5+oqlz4jlI/DaNJ1zE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867842; c=relaxed/simple;
	bh=ZvqfaDM3961shpPhB0QWB5bEV3krPacm7GyvkiFlYMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ifg1xk0Z6iiI+fu0MTt32V6WnuFj7nfcpAJjs+aBXTpn6zStnUjapqXD1NSnB/XMENHqJQIEj3F0oRJhxRf8t9JynsnNadKMtQrRkrM+ohlE2LLUSX2bLCpD3SMIdYkpXPykukYDUie9fbUfrrlq04KBo5aWu5jYd12dyEpRx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/51lhBT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/51lhBT"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23636167afeso765035ad.3
        for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 09:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750867839; x=1751472639; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MTOim0bI+o2eKzB/GRE0kdcUWqcDv8nQxQv5pqAodc=;
        b=T/51lhBTebOOTNyZPt01tuGX/edgMSYdbar22wb79l7irja5INLu/HZ/tjfP2B4OYs
         rJ42O4RBZb1FtpeT5KyJh2WJfXb82eRUavrikeGVC2LGwxCby8JJOBze513ZudyJINy4
         WhfCSB6PDbZpQsaCAFzEWevbUYI0HaYdmvKvwKH9u7mvsdTI8LPlhjpXdmEf0ibXFyUi
         w6M5ClEwnoowBJLjspZ1Rl9fEtsp1Cwz0a6UFagrkiJB5/KL9kNR5bmhS5hOiHbhKzOa
         XHTHrQrOnOEZcij0gU47zU1ehPDB6pA+PNiBf/53qm2czoA3itUn7pPBprIz09CeFcVH
         meJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867839; x=1751472639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MTOim0bI+o2eKzB/GRE0kdcUWqcDv8nQxQv5pqAodc=;
        b=YptYUzA9A+PogIIO+3RYNBDOAXmRI2uV09Y/DhOtIrga8qliOBkYkCyd8hq/4WldwH
         jdKXgSvynaAG2Lid5C1PYzNiexlQRr3aoqkwu1ou+1EW2Tn+f6Ms+q6qPU3xvh4DX1nl
         nDCgrNT7PvKQmT9oGiKN5GDCESuDvNwsfcII1eaI2WvGLywA11LVp7C2RrNChTYlKN9F
         lAvwsutsEa9nmehdCzuuB99guwROQH/EM/B/+xpv8ML6uaPSoEQvHhJq4Qs/L1cgGXcW
         NRpIo8t5CYfoKvU7/eVr+/qQUM/bRyzPrRzp79EXuiS5rXxTmCGrmgcJS+bAYpaYBFm4
         UP5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNjo7eqaoxJ4S9Krnfty3JT/VS+EZGYns2JoHYm1qpaed+MGW8aTD01wNa0XXsgiMm5AUx8RkfwXue07Jwyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPhuJ+ZtgldsfLCNT3kcCWdEKGIyQ4lyfj2hJpkr0o3FUMyjkR
	E7k3f4ouE0Rh9PYCtuxkY4fVB31yVr79UT3WQD8Ikfgnd4QUQIJRvfYk
X-Gm-Gg: ASbGnctH04gXWMfe4JFj7ChF2JMkWfA4U1HCXiNb2eJtVlyDEPIXVGB4zzqqusKVDLY
	u5SA+2c9sbN5HqvBN60yLG1/yTBkCIqsChKztdnEPKUhrDrKZ8d5OGwbseghZ/14VdHazLmF16U
	Gm+BS9FO07BaBVyTGHoSLA+g0kgmJwqvGoxu/GkC4RyLHX8/iDQFfIXITbGP2qRyPkH5ZaO2n6y
	Wl0+Hi3cyH0aihWTkycKvxH7yUErs90Vk6A7hP98WGTWWZ4NtPdQ/tZBjbxWnlkgHZX1IKFA9hU
	zDM71LqagyoLeru2f1rn1Wn5adlhcKS/BVJ/TNlklU0QsYDXpVXQADf+WdA0I/HXfxf8gOJKeyv
	uTg==
X-Google-Smtp-Source: AGHT+IFpH0ZhFM1LT/le3DUpl/1q/Q6WJthAozRqmYPKj6YzBEcv9GZLE7JYOv+loHFwm0tdUStuWw==
X-Received: by 2002:a17:903:1a4e:b0:234:c549:d9f1 with SMTP id d9443c01a7336-23824086ea1mr55865985ad.47.1750867839525;
        Wed, 25 Jun 2025 09:10:39 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:1cf0:45c2:bdd1:b92d])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-237d873845esm143219175ad.243.2025.06.25.09.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:10:38 -0700 (PDT)
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
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net 4/4] virtio-net: allow more allocated space for mergeable XDP
Date: Wed, 25 Jun 2025 23:08:49 +0700
Message-ID: <20250625160849.61344-5-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625160849.61344-1-minhquangbui99@gmail.com>
References: <20250625160849.61344-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the mergeable receive buffer is prefilled before XDP is set, it
does not reserve the space for XDP_PACKET_HEADROOM and skb_shared_info.
So when XDP is set and this buffer is used to receive frame, we need to
create a new buffer with reserved headroom, tailroom and copy the frame
data over. Currently, the new buffer's size is restricted to PAGE_SIZE
only. If the frame data's length + headroom + tailroom exceeds
PAGE_SIZE, the frame is dropped.

However, it seems like there is no restriction on the total size in XDP.
So we can just increase the size of new buffer to 2 * PAGE_SIZE in that
case and continue to process the frame.

In my opinion, the current drop behavior is fine and expected so this
commit is just an improvement not a bug fix.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 844cb2a78be0..663cec686045 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2277,13 +2277,26 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
 					      len);
 		if (!xdp_page)
 			return NULL;
+
+		*frame_sz = PAGE_SIZE;
 	} else {
+		unsigned int total_len;
+
 		xdp_room = SKB_DATA_ALIGN(XDP_PACKET_HEADROOM +
 					  sizeof(struct skb_shared_info));
-		if (*len + xdp_room > PAGE_SIZE)
+		total_len = *len + xdp_room;
+
+		/* This must never happen because len cannot exceed PAGE_SIZE */
+		if (unlikely(total_len > 2 * PAGE_SIZE))
 			return NULL;
 
-		xdp_page = alloc_page(GFP_ATOMIC);
+		if (total_len > PAGE_SIZE) {
+			xdp_page = alloc_pages(GFP_ATOMIC, 1);
+			*frame_sz = 2 * PAGE_SIZE;
+		} else {
+			xdp_page = alloc_page(GFP_ATOMIC);
+			*frame_sz = PAGE_SIZE;
+		}
 		if (!xdp_page)
 			return NULL;
 
@@ -2291,8 +2304,6 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
 		       page_address(*page) + offset, *len);
 	}
 
-	*frame_sz = PAGE_SIZE;
-
 	put_page(*page);
 
 	*page = xdp_page;
-- 
2.43.0

