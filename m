Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF1A28DB5D
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296430; cv=none; b=hw1vhzGXINyIFd/8nUlznud4z+XoONnKaYre2z+t2/rG7qeNFRfuof5kqV5CJ4BWzE40Tws4sMei+jzK1rz9yY9hJeMv3eclU08pYQLybo+/plfyETgNWVjqm5AQZ8S89xbLpdocXl+NW+iHyLfiPfG5LzaCyDLUav+d2vEfjgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296430; c=relaxed/simple;
	bh=5mv+oGmYUQBg1ezZ8QQ1je1GKPmssv38hlgDpbVe09k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXwI1IwCEH60WYScMXI489ZeVKkRCa2vFfhOS1WhfcmtM082Snie6tgmJWseLdZYdwaVc28+aDWWFi4pBoCGv9WUiRdIW3y2//icj+nhI1KST9KgB0KBx2Vmvb/Unvk6vg7Z3dGRodFm1omtCp/gsMhs2VxKJzQZG/SuiX1er14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMvUg5QA; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMvUg5QA"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b3508961d43so1071419a12.3
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 08:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751296428; x=1751901228; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBu2Oaefb1JPmcr5RSg3Hzf1URtJFkgOjV7eKQ6deWg=;
        b=LMvUg5QA/MGSUYJFrY2HJup25u+lLYCMaUkDIuA3nQ1r+3UAqKyJW+LLPa2ZTIuT1e
         hOgvyYyR7AaVT3HeBVtzJCrXzoaR7jtAEgnlZNrxG85BtPp7Oj/d1e6oW/kqdqUoc/io
         RDDt+wpOpbFNjfETDJwmhnyVMJSDQ5xLqzBzie9FckqZxmY5Tf4pWyw8xY0Cekp0uf5b
         LlOL2VuuAC0jYDarC01YD9gHWerpsLks4OKAEurxG4Csjbsy2u6VofBbjt4pTnHySYg1
         Sl4Ff0jAhrIykk0EnKD8fJik8aM1TovOoICeqeoc5Xw5XbdOR7XXGIgX2wjth1SFG318
         gr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751296428; x=1751901228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBu2Oaefb1JPmcr5RSg3Hzf1URtJFkgOjV7eKQ6deWg=;
        b=jM8txq65Gm+W/QRrK53CKgfUIh9IAibZBiMHlTJDj+biNy3y9axi1iNkV6BxWfuI7N
         c3gQVnbIKtDOKcH9xAKaYiBxy4MyDI8ThhSXZLRxFRvRhDD74fKsBjrs7JmWpkFyFu6A
         6aVGG3dYkiJPohj5WK6Z9i1d+9jjUD5rXT5cmHWjnpgDlmqoPx83PGOmv12eOQEymAMA
         p7VlOqhHRce+/ochJ9dkQVRiqeUuarJRjJ6W/A+yhL563vzniWjAUg0NDlGvRNpXtz0A
         idGL73VkJxUQ3ALLX4gaWL672CLzmJ8RgfVdI/mnSv2v7H2EmV9aURiHi3j6kw+kwpTp
         I9eA==
X-Forwarded-Encrypted: i=1; AJvYcCVsoMcbpFCkHctYxcIATyJMxSwIkQl8SOqYTzR20erFFzT7EN/L7ROpY9BwnS4aOcaylq9SVym18J9pXQ6Pjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaBEY/NII1z07ZpE/jyHT5Eaw9mNisgBQKYof20zJlmjcJQZT2
	hA8LV5sKEWUuTomHuiR5lB8GD2Z9wxnEJPfEJ3lhS2y6h291Ai2GgJrT
X-Gm-Gg: ASbGnctlw3+auZJdFovJY9C4uUhPEKGlgkqjtT3kqTxxSWZA8yIbS1XOVNptZio0CfJ
	Pfq7w6qLXpVDSDFjBeFxLszM/S/oYB8M5cVChoJu5oWmk86KVs/CA/TgviWM11qOXzOc6rMj5b5
	nrz+JjFvI1IgiOMvaQ7FTfwqDiFCFdjGIURvYq9m4fKqd7rQJ5HHL1eODfbJjosekDZ5SAT8p7k
	CKmstek4l4jmxbhHz3SY+lUb/97KXn9Hfw/ZgivSeKoD8je/MPLVU0/HhQpTNLJwPP8BGzFbz3F
	LfbjdUoTGQXGpMZj4y7aaBWZT5vTld758niLUVleMTGuzl9bLFu1l5mYGhKkQdwY8Jx8bcDNKOs
	r
X-Google-Smtp-Source: AGHT+IFwWEbLrxuNpGb6xkKNMp0XC0hNjgZ5eIlHaLzs3SUtzwOhDuKMakpxMq7cSzD+BMZJOw3BQw==
X-Received: by 2002:a05:6a21:393:b0:21f:39c9:2122 with SMTP id adf61e73a8af0-220a12a6789mr23026011637.2.1751296428201;
        Mon, 30 Jun 2025 08:13:48 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2f51:de71:60e:eca9])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b34e31bea17sm8323340a12.46.2025.06.30.08.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 08:13:47 -0700 (PDT)
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
Subject: [PATCH net v3 2/2] virtio-net: xsk: rx: move the xdp->data adjustment to buf_to_xdp()
Date: Mon, 30 Jun 2025 22:13:15 +0700
Message-ID: <20250630151315.86722-3-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630151315.86722-1-minhquangbui99@gmail.com>
References: <20250630151315.86722-1-minhquangbui99@gmail.com>
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
index 1eb237cd5d0b..58876d1e1344 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1159,7 +1159,14 @@ static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
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
@@ -1284,7 +1291,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
 			goto err;
 		}
 
-		memcpy(buf, xdp->data - vi->hdr_len, len);
+		memcpy(buf, xdp->data, len);
 
 		xsk_buff_free(xdp);
 
-- 
2.43.0

