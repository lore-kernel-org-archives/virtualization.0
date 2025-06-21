Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBE01DE2CC
	for <virtualization@lists.linux.dev>; Sat, 21 Jun 2025 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750517498; cv=none; b=aCA9br6S5UEOKUw/oU3HFiLD6Tg5bFxF84KPPD78g7Jwf6GbP8uIgAlzhOICrJrOpdABkmDswzlWuxzDsKvMZ9+N3Me7aIIV6lIGGDxZJdYXK39ZnItHcBPGEgBgs/WH3prqu45KWc8MlIrHKxDilxlAfqJEEm6YftURv9QFEFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750517498; c=relaxed/simple;
	bh=VDC/H4qxrgNISEN09Sz7jFYSr9ya7/eF+9EuVS1vC2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvlzTdLj2k/YW8klvws794kqR1FQ/rb0jpQXoBw7H0H6XZmJSSNM8RZs4hCb8Wlk3J0NAoYrxa+2uePtrbP47EzJ/j93NjxJKgwfjbEaw2K3GWEu0L8AjGUnKBjId2aLJZyX7mkFoHbvVp9Q4uokYGeVXBOfQS6jQf53qD04YIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnIX/rNb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnIX/rNb"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748fe69a7baso2411762b3a.3
        for <virtualization@lists.linux.dev>; Sat, 21 Jun 2025 07:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750517496; x=1751122296; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsT1ZEXEOUtY1kEret+DIBmKa+OK0aPjmFKUZJqZ22A=;
        b=gnIX/rNbspSNQik7l7qXqXciz9rkKKlkwHpQaYBNmHQEs4WmZhVc6j+SfiVdZtJwja
         3bhWCD8h0c+dO+oSzuliYvsM8D01VBQc/X0llkW0xsmkJQDydgncw5nJq5eCcJFYunnG
         UcPLrW+pNWjCRIv/5IhZYdQlU5/aKwxUAN7WKOz/dJhy9l+H3SiYbHQdzxlSteSkd8aH
         cXIkyGQ5Vf5eZbrgOoDC5Nq0TVipZI71PkigL9pp8fCte6JEX6nC3uu2AT8N7M/URbOd
         9lhnSxy7s+9MlfzlLr7bUXBb6miWqVTyiREAzmqhIQu1s9fzDTRAlfhhgl8FbioQN2Aa
         PxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750517496; x=1751122296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsT1ZEXEOUtY1kEret+DIBmKa+OK0aPjmFKUZJqZ22A=;
        b=wGfI0JWU7hPZrJZVxAARd0zSxzgYiw9ThV7GDacd8Ag/lzRrp4e5plTsJ4hLnSrjBp
         dEAK7HORbbxVqg7PwizapNsA3v0KrXpYb/NoIa5DfJYWboESbUaMjY5XpY3anWy0bd8U
         KoP8m9WtNUVl99s4B/yKg7Lx2T7efgeHO/9HVQMVgTbNB6IWKgURG71ZaS2H1hGjtVSt
         THFXk7RIk6LZNsI9/eEXsNTtn+H01xSpkxG5fRfeqtSGRvbQvKvq0B1VcgREX0I3HJP2
         Kfl3jygFym+dJDWCJ/GLz4hiiRPottyebCPswy8d3xnbD9sR6JJDalSLYXpCkhFepv1y
         T7/A==
X-Forwarded-Encrypted: i=1; AJvYcCWIrkDSNp0r/oa6gKSlXujNlf8EVyZCs+LRlIffWY9c/OzUNFKOCTP+JOrLHR6BPX9Bph8ekvaOvssqs+Ci7g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx30xwYJmvm9mzJGynKbncW4vmE+6DVkUln27h0DLIc689lbdkI
	EJTAk+H0c9x3o2K3TTHDu8ujFwgIgQ+rzKBrvj5kq2BobpDNR5YnyvtY
X-Gm-Gg: ASbGnctjhgtdpR10bV1wpc2XZittFpYZQZnFSNCi9TpI2WICbUamBt/4MxD9A4/+1D5
	mZviKTBqNClSDAiGYNsiyQziP5iN3jvfKoBhc7sloShKu5GZXfoYBJmshDabfjmCbktdVBXv7CK
	h5uI9El5Y+8T7HOBd5z5z0bMU47//DD9TDMvuakJrBAI+b5rIGcchWl2kFisZ8m3UHO7v+P8H+J
	BiLmhryUaW6RmVc9ZWKAz0X8FNiS/zMHHQdjxMkjb3BWEbLcjJTmkQUN8pcqkER1r9CSLWvU7Jr
	YYCwoNwOLdRAsfowp86uGMj97+OR3eIYSk4pBGanTLTXSfAuFpsNaHmhHXYundoXGbAUcHO5suU
	+Vg==
X-Google-Smtp-Source: AGHT+IGDRfF/7GW0dG2asaXRVeS7I9SgZa3EowVkxZsXFjdDSpZWb6U65gMCd7WwyOg7LN/dQrCCAg==
X-Received: by 2002:a05:6a00:4612:b0:746:3040:4da2 with SMTP id d2e1a72fcca58-7490d51ba3emr10478119b3a.8.1750517496374;
        Sat, 21 Jun 2025 07:51:36 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:fea9:d2f2:6451:ed3b])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7490a46acf4sm4493490b3a.11.2025.06.21.07.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 07:51:35 -0700 (PDT)
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
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net v2 2/2] virtio-net: xsk: rx: move the xdp->data adjustment to buf_to_xdp()
Date: Sat, 21 Jun 2025 21:49:52 +0700
Message-ID: <20250621144952.32469-3-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621144952.32469-1-minhquangbui99@gmail.com>
References: <20250621144952.32469-1-minhquangbui99@gmail.com>
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
 drivers/net/virtio_net.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1eb237cd5d0b..4e942ea1bfa3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1159,7 +1159,19 @@ static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
 		return NULL;
 	}
 
-	xsk_buff_set_size(xdp, len);
+	if (first_buf) {
+		xsk_buff_set_size(xdp, len);
+	} else {
+		/* This is the same as xsk_buff_set_size but with the adjusted
+		 * xdp->data.
+		 */
+		xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
+		xdp->data -= vi->hdr_len;
+		xdp->data_meta = xdp->data;
+		xdp->data_end = xdp->data + len;
+		xdp->flags = 0;
+	}
+
 	xsk_buff_dma_sync_for_cpu(xdp);
 
 	return xdp;
@@ -1284,7 +1296,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
 			goto err;
 		}
 
-		memcpy(buf, xdp->data - vi->hdr_len, len);
+		memcpy(buf, xdp->data, len);
 
 		xsk_buff_free(xdp);
 
-- 
2.43.0

