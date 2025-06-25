Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BAF288CB7
	for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867828; cv=none; b=qS0EqeiaZd7fPWDYltk1mMWY6ppdabTqit1C7KRMgE8JgwyFny/DmChZaDYM4zCXP5qFTBloZ3hUW60kkIvWySBCKibbr7ndInoQq4SCW5+bsCcLyO4ZM4NTnNvIJSVntuBw2pk/923m0FFH457+/wA3AP2nshcjpD+9e2G410w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867828; c=relaxed/simple;
	bh=0sJ8AeOBtujsSHHSnnt99pZ3s4tdzAw+C4OWiCGVWno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdFIcXlrIST2uKHCv2C0tFJqnXH3LGikMGSZms26t5K7fQ4J2krBx5fuGZF05diy6EN25Or7QCW0SS74xZmwxdEL0AkliWWwqRWGPSYHNMeOeUyvwoXK0hPMXmIU2T2nAexw33KJ/QqOQiksN4vleJ66af+HMCVbIO9HG1M7TJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtAlp346; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtAlp346"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235ef62066eso567135ad.3
        for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750867827; x=1751472627; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmQ7iHayqhhe6CdrM/SyPC+bVPoeFePLL7uHhJ+6594=;
        b=BtAlp346CNvO35A8buFBtiiipgEnIfB3v/Mdn8Tq8Ux/17ugmTLo8YlNJIz3FwhfHs
         xksp5+T3OoQRM4CaI/qeKOLOLKWwDqekEkCnsl7hDQDU3pYsZK65cnh34xpSjIclU5lL
         6wofPeUUs+YPXQXwvDoiKt7IdVu7trnQxph01pskOVgqD19TYAnLL+ejCzq1wRD+eVWb
         2LE/IM2piwtzMFUwGtNSF9pc808/7m/vHn+uKo83VTEMzRLAgg+YEmZgP9XUhsarlc+e
         L3Of0uSrdH33wA8Qh0MB/tEGHrNQA/JJmpnd71bojJJHFqOS6gJ6OO5k94/3b1kZ+C5j
         /fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867827; x=1751472627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmQ7iHayqhhe6CdrM/SyPC+bVPoeFePLL7uHhJ+6594=;
        b=JAqacoz1cuK4vppz5t8X8KHFCO9Dz56IYgl1Wd5D8aicV3rkuFjKK+l/oeiehjvcws
         ODNYE+8NPuvlrl8SIieC59uvpPozHMwN9aN9d8dw9gZGtUdsHk/9jMzOZzpRgVDsjmEJ
         iLuoNUc++68h+5/EMSCqjQwCMbclI9H3FXeecU6Lvfaq7XXpo8c33Kd2cviWIRs9cQGO
         qTcQ6YSl8mI8PD9TTVjHgcc/dhRaC7oqrcDrFzgyEeKV5N07Lxy0keYpcGHRFBTT4dks
         XAwRTBYzzNR6FapOYvYrpJCR1PQuyC4jMQAO+Dez7IQlyHF7lkMz4LtExf0vubf5b9Mc
         qW6A==
X-Forwarded-Encrypted: i=1; AJvYcCUaojSBAXaMKhwqcclXdUrh+dEGqABjLXTxYk+zUwKYy02Fu9FDteeOm88Ecxj97kJAESyKam3PbPaRSlYo9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6TUbvC6e2wRWABweUQ9BikmG2X55tSGMMh+C8CObRazclnjPJ
	IN13vXum4UYXD5uphs24x6QxlNzWNGu5C4pERnz/NhIXfwF9rd9t3vRg
X-Gm-Gg: ASbGnctpyBHjjkVcwcC9grZ2b2qfOZ/zH37N/Wi+SxPHR4Cysz2YRpqyYoNob7v1oMD
	wm7I1NgEJ4W7cTwTpBm0gCFY5nVOkyTLlA33wKo1E9C1JAj+kxz3LYvJr+VZlD8m6aQEf79O81e
	DV8edNvYr15S6M+/dEuX9u2tzKVnC4fUy4ds+d/jiaVRR81FLMpZJ+7aDLoNMsgKhXBXa6KwIqe
	CjmMYXMt74BVqG5CCBBfOfDNrcq+Moqr55idbGWym48UIEQDDOjcI25azvqSOZMb12N8l+T3iu2
	iyHt9vp3YoVSmV1vKqbSZvIDKHL9AVg9n+y55oMrbev5BNiZAyGhMStGAGNAYS4LRrZ/LJWhGTA
	ZGg==
X-Google-Smtp-Source: AGHT+IHZco/gamSdqfqByRJ3U6FIbuRY9/AJtMaXeQeuyElS4WMZmBKDToEdDl1TnVC6imwFD7vuIQ==
X-Received: by 2002:a17:902:d58f:b0:234:cb4a:bc48 with SMTP id d9443c01a7336-23824030cfamr69817065ad.31.1750867826672;
        Wed, 25 Jun 2025 09:10:26 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:1cf0:45c2:bdd1:b92d])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-237d873845esm143219175ad.243.2025.06.25.09.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:10:23 -0700 (PDT)
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
Subject: [PATCH net 2/4] virtio-net: remove redundant truesize check with PAGE_SIZE
Date: Wed, 25 Jun 2025 23:08:47 +0700
Message-ID: <20250625160849.61344-3-minhquangbui99@gmail.com>
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

The truesize is guaranteed not to exceed PAGE_SIZE in
get_mergeable_buf_len(). It is saved in mergeable context, which is not
changeable by the host side, so the check in receive path is quite
redundant.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2a130a3e50ac..6f9fedad4a5e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2144,9 +2144,9 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 {
 	struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
 	unsigned int headroom, tailroom, room;
-	unsigned int truesize, cur_frag_size;
 	struct skb_shared_info *shinfo;
 	unsigned int xdp_frags_truesz = 0;
+	unsigned int truesize;
 	struct page *page;
 	skb_frag_t *frag;
 	int offset;
@@ -2194,9 +2194,8 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 		tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
 		room = SKB_DATA_ALIGN(headroom + tailroom);
 
-		cur_frag_size = truesize;
-		xdp_frags_truesz += cur_frag_size;
-		if (unlikely(len > truesize - room || cur_frag_size > PAGE_SIZE)) {
+		xdp_frags_truesz += truesize;
+		if (unlikely(len > truesize - room)) {
 			put_page(page);
 			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
 				 dev->name, len, (unsigned long)(truesize - room));
-- 
2.43.0

