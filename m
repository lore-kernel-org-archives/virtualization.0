Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D9219D8A3
	for <virtualization@lists.linux.dev>; Sat,  5 Jul 2025 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751702171; cv=none; b=WANZ/o2dSVJ7/Zri4bzRraidvN6S6G7bOM9Kk5c73Hpem2+nENt13P5CFMs7p5QaUPVDWQCco+gU4yOQ9310Qtt+xDB2w0Op0APpwav+VBtY8gDQ1bFrBudw42oVCcS4iO+vWD+CEZCw26/PPGlx89gkSxy+TxnjM2c+V9pxKZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751702171; c=relaxed/simple;
	bh=1P2U2dshSLhnnrRgjC9ySFPrNtAdxhRNQ9ZjqtLrhc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t8KGZJjhl+tpFgth0t1OoYrDGxe3w1LcAl40+E/Xz2WE3bYNJfdLXkXra3joWDqSw+T8nlbnQxkYeFr3O2VqkIogRTVLZcem1s8pV80tUbtpuD2VIXD5vpFxO76Y/Y5jtfwJBc5wXXDoOKjkVJdpxrUUAxvjIosGF3kvqK0wEIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8sxc9En; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8sxc9En"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b3226307787so1052591a12.1
        for <virtualization@lists.linux.dev>; Sat, 05 Jul 2025 00:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751702169; x=1752306969; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h/IUKcxSD2e2ah4kSG9Q2b9GaMgau4YL3nl4/Ou8ZYo=;
        b=e8sxc9EnAONovmpu5T8pVN0E3AVVQeN/dD1pmvWMaeJ/Hr+tw0/XCgTYUpXpkGMFVH
         A0guIwxmbUH3/saT147FnDETaUh3DYsc1K7iOnEnTFWb1D134WC07Db2BMYTFIkK/1L3
         y6xQ8WUxtaHSWwyBghEGxIMQ0ihgD8kO+EwtDwpCMaVUkxWpXyqMBC9sw4HCCWh+jXPu
         Kkzye++33YGI4531BNXjV4XUho4xJJVHE/nOKCW7F09l5Rt9060Szr/bqI2C2mQutBHm
         CnnZaPxId/knzvJn1hTlpMNXJ/58sSsKohC+wdCNWtp2O3pA8rP0YbmFIYUZpGHfiZGV
         Lf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751702169; x=1752306969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/IUKcxSD2e2ah4kSG9Q2b9GaMgau4YL3nl4/Ou8ZYo=;
        b=uC/qW/LNH6EFdGvJYq1UCoaB6eA5i8YTr8wsQIRQAcXi7HQdcgg0YT1voTz3PncOzE
         EsNIB8YV2+tev8iD/P4fP2XpkJEqFw5UlTUGjh0+1AGupv8UnrjwGiP0mG3B/mm99Dc7
         9RVpk0opzUGYHefYFi4JotZWD1AQZnx23/SazBe/IbMEYRwPJ7YmQi0X7sg6KWzhBkGg
         0EYdKnC740EVhlSxOqj5ZXeqpd+SJZK/yV5Ym6J5bLFffQqbFUKG5mgGczvXWYJNtJ7+
         ADNHKxmCYG0dON0qfGPFbLJrOP6RP0mZBNijqZg5OIFvWNbrlxFLFsCVJNGrfbdI33iZ
         Worg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/pk2ouEymjrj4nPlmofY76ZVc+niUDw3I/7lAfWiqYIf/xG8vvheubEGkf0dpl56O3ZegIwVI9j7AyvNGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXnrkcy2nWuMrZWChpKjj5fee3+slGWDi21guIfiUNwkTFtTHz
	+gT+lFpoa0A6BLL2BptbHz/QPH6k7QACQWMG5+hyd/YIZKp/PoK84sX7
X-Gm-Gg: ASbGnct2JbfuxkAmGFOqZhsOXx4Gq2XM+c/LMxLq8+t6lgPZZkM2+tpz4gCU8tn5Az9
	omqn2hAQTiXVYIAiJvMXB45K867PPYFqljKMFhtOh+vQFbEBLz2WZCeo9wgHabBcOjLOUqId3Cv
	CqgVZKZ3iPLr6I2bEl0GPjIyens4pd+JBvdI6lE3DOvxNb0IZwd7OullUnwzXh67vFPBm4KeJ/A
	6VhhBKUpK+jDQ9bSFy3uqTINaLyeUbQvEI4jWYYlicoqFQCAdhHOYQeQfH883Tfjv3dw50erKm6
	ufuj3p1KINEhce/L8vknuGHtLVilD4bEKjDQW8JboNEf2wWaaxYUOnKAPT8ucaqu5VK3MDot6Is
	aSA==
X-Google-Smtp-Source: AGHT+IELb59jy1yq/0ZLxHvUZqGi8xjJJOOy8kXY/fGS5HJJFKa5k9aihU11XHC1d9gpDvqKsoQ2NA==
X-Received: by 2002:a05:6a21:33a5:b0:220:658:860 with SMTP id adf61e73a8af0-2260989672amr6461002637.12.1751702169435;
        Sat, 05 Jul 2025 00:56:09 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:8079:3d14:21d6:b779])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74ce359e9c7sm4092388b3a.15.2025.07.05.00.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 00:56:09 -0700 (PDT)
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
Subject: [PATCH net-next] virtio-net: xsk: rx: move the xdp->data adjustment to buf_to_xdp()
Date: Sat,  5 Jul 2025 14:55:14 +0700
Message-ID: <20250705075515.34260-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit does not do any functional changes. It moves xdp->data
adjustment for buffer other than first buffer to buf_to_xdp() helper so
that the xdp_buff adjustment does not scatter over different functions.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9f6e0153ed2d..4d995a47a116 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1179,7 +1179,14 @@ static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
 		return NULL;
 	}
 
-	xsk_buff_set_size(xdp, len);
+	if (first_buf) {
+		xsk_buff_set_size(xdp, len);
+	} else {
+		xdp_prepare_buff(xdp, xdp->data_hard_start,
+				 XDP_PACKET_HEADROOM - vi->hdr_len, len, 1);
+		xdp->flags = 0;
+	}
+
 	xsk_buff_dma_sync_for_cpu(xdp);
 
 	return xdp;
@@ -1304,7 +1311,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
 			goto err;
 		}
 
-		memcpy(buf, xdp->data - vi->hdr_len, len);
+		memcpy(buf, xdp->data, len);
 
 		xsk_buff_free(xdp);
 
-- 
2.43.0

