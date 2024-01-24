Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B784F17C7C
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086721; cv=none; b=O4s5d9IyAPWkLC978Tg6boCntubLbMlxGyTEcI4lAwAUO2DNjX1RDwxBgeUTMGbSTGyQuNwuSwuuZkz+LDcFo+mXpPO/NrE+C5f/JN/l5mfBUWel9fLr+Sg+MoYYfvWmMrxZ5SQy6XogbksS5Qtz/WAD+q1CPo6azkupwgFq4vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086721; c=relaxed/simple;
	bh=og/4jZhQQp7y8j0tIvax0Xzi48W/KUOVqjDS1vcX2Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JQ5sqOqux6xGY6unil6ailjkeVxdwvAYXNebTTHrVkAnj29NWpXkXyLYpHNr0aj/3ld6+9sZMW4QDUY7IVYYN/9/6cVbAOcouc5YFqOjU3j0Rhh0P5tJcOatSan/dP9f1ejXZkQ0eFVfofCBPqM00FS5hKBDr5kCFCXtwqHRW5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmv0UzsI; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmv0UzsI"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4F20A4026F
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 08:58:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4F20A4026F
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bmv0UzsI
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eA1c4Lxp0pdr
	for <virtualization@lists.linux-foundation.org>;
	Wed, 24 Jan 2024 08:58:39 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 40F5B40148
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 08:58:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 40F5B40148
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-29041136f73so2674338a91.0
        for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 00:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706086718; x=1706691518; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPu6P60AtBzEJlySRcvQE2oYJV8KpvDM6ODg18dewI4=;
        b=bmv0UzsIq7MswZDBzHu4bWUyEt4AZo+h1CQeZ5aYGRC1uC29gU62PQHlZ2ZtsjOOjq
         zcZdUr77vG3vpeVZE4OnZ2ANpClzNyfqXV/reDTs01+bFVQUy3HsAS6gvR+fx8J55JVI
         3Oz5MreLp3i6IgDdoxm4u5AlQeQfcasmrgcxe2O4ZhR43Y4oOb++P5TlLUgcmih/ssLf
         JEj0txw4c6lQ0iw1+hGkzU53KIAqqxoRsnN0SnWo1Wobp7eXL6vi1ohcLYzOZUMceZVy
         kCRpnGNX4nu0EPJK/LnfXDMR7dVOhntNJTJxr4Lw8/yYjwEqi06SV8p4exrFYJEBqc4B
         f+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706086718; x=1706691518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPu6P60AtBzEJlySRcvQE2oYJV8KpvDM6ODg18dewI4=;
        b=C5hgjKN8TDogtLpLtNUVV03vH/Yni2MOWsbW7N9giPxuc2Rz4znvg8rWKtueVJHbyJ
         hDedxCaAXR+Xr6x/yE7msBxYxKWhImioj5+fbjB82IKDVE7EjSv61nUrtiLzXj6Jl5QX
         FAYK6EK15pT8o2CiZ+u2FEx619nRGemN6iFAAtSPWSyFu/0JUCsKkRVW1rXjjkpYI1nz
         pD+BrQGxamyekiE4DBVVvpVAkUkstiXiPA1M+AihFMU/NfcCjrBYULwj0i6Fkn3KaNy/
         BnOlASc45H6ESyX40Rb/UlwV2XRjnS23CCjcVNCL1Hn4VkDRxgtB7o2Hhw+pvKk8xHVI
         vQkQ==
X-Gm-Message-State: AOJu0Yx6nH07ITCJBKgjsmI7DR9mJGvYTtwfdyrzudsjiRXphCJnDQf0
	NXaO0+G8L2xz5ykDbLDXg5bjd1l5sj9JVo4jgkexEyvb1uPy+2pxyxcrWFrO
X-Google-Smtp-Source: AGHT+IGtaFk86gI0X1es3cazO+4bzDFE1/1zDKanQ1edDEL19O1uyHYitentoQwv3rAZxhz4ey3lCw==
X-Received: by 2002:a17:90a:ba8a:b0:28e:84eb:2958 with SMTP id t10-20020a17090aba8a00b0028e84eb2958mr3190942pjr.76.1706086718519;
        Wed, 24 Jan 2024 00:58:38 -0800 (PST)
Received: from localhost.localdomain ([107.167.25.130])
        by smtp.googlemail.com with ESMTPSA id sb3-20020a17090b50c300b0028ffc524085sm13192233pjb.56.2024.01.24.00.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 00:58:37 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	hengqi@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH v2 1/3] virtio_net: Preserve virtio header before XDP program execution
Date: Wed, 24 Jan 2024 16:57:19 +0800
Message-Id: <20240124085721.54442-2-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124085721.54442-1-liangchen.linux@gmail.com>
References: <20240124085721.54442-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xdp program may overwrite the inline virtio header. To ensure the
integrity of the virtio header, it is saved in a data structure that
wraps both the xdp_buff and the header before running the xdp program.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 drivers/net/virtio_net.c | 43 +++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d7ce4a1011ea..b56828804e5f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -349,6 +349,11 @@ struct virtio_net_common_hdr {
 	};
 };
 
+struct virtnet_xdp_buff {
+	struct xdp_buff xdp;
+	struct virtio_net_common_hdr hdr;
+};
+
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 
 static bool is_xdp_frame(void *ptr)
@@ -1199,9 +1204,10 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	unsigned int headroom = vi->hdr_len + header_offset;
 	struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
 	struct page *page = virt_to_head_page(buf);
+	struct virtnet_xdp_buff virtnet_xdp;
 	struct page *xdp_page;
+	struct xdp_buff *xdp;
 	unsigned int buflen;
-	struct xdp_buff xdp;
 	struct sk_buff *skb;
 	unsigned int metasize = 0;
 	u32 act;
@@ -1233,17 +1239,23 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 		page = xdp_page;
 	}
 
-	xdp_init_buff(&xdp, buflen, &rq->xdp_rxq);
-	xdp_prepare_buff(&xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
+	xdp = &virtnet_xdp.xdp;
+	xdp_init_buff(xdp, buflen, &rq->xdp_rxq);
+	xdp_prepare_buff(xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
 			 xdp_headroom, len, true);
 
-	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
+	/* Copy out the virtio header, as it may be overwritten by the
+	 * xdp program.
+	 */
+	memcpy(&virtnet_xdp.hdr, hdr, vi->hdr_len);
+
+	act = virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
 
 	switch (act) {
 	case XDP_PASS:
 		/* Recalculate length in case bpf program changed it */
-		len = xdp.data_end - xdp.data;
-		metasize = xdp.data - xdp.data_meta;
+		len = xdp->data_end - xdp->data;
+		metasize = xdp->data - xdp->data_meta;
 		break;
 
 	case XDP_TX:
@@ -1254,7 +1266,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 		goto err_xdp;
 	}
 
-	skb = virtnet_build_skb(buf, buflen, xdp.data - buf, len);
+	skb = virtnet_build_skb(buf, buflen, xdp->data - buf, len);
 	if (unlikely(!skb))
 		goto err;
 
@@ -1591,10 +1603,11 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
 	struct page *page = virt_to_head_page(buf);
 	int offset = buf - page_address(page);
+	struct virtnet_xdp_buff virtnet_xdp;
 	unsigned int xdp_frags_truesz = 0;
 	struct sk_buff *head_skb;
 	unsigned int frame_sz;
-	struct xdp_buff xdp;
+	struct xdp_buff *xdp;
 	void *data;
 	u32 act;
 	int err;
@@ -1604,16 +1617,22 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	if (unlikely(!data))
 		goto err_xdp;
 
-	err = virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, frame_sz,
+	xdp = &virtnet_xdp.xdp;
+	err = virtnet_build_xdp_buff_mrg(dev, vi, rq, xdp, data, len, frame_sz,
 					 &num_buf, &xdp_frags_truesz, stats);
 	if (unlikely(err))
 		goto err_xdp;
 
-	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
+	/* Copy out the virtio header, as it may be overwritten by the
+	 * xdp program.
+	 */
+	memcpy(&virtnet_xdp.hdr, hdr, vi->hdr_len);
+
+	act = virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
 
 	switch (act) {
 	case XDP_PASS:
-		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
+		head_skb = build_skb_from_xdp_buff(dev, vi, xdp, xdp_frags_truesz);
 		if (unlikely(!head_skb))
 			break;
 		return head_skb;
@@ -1626,7 +1645,7 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 		break;
 	}
 
-	put_xdp_frags(&xdp);
+	put_xdp_frags(xdp);
 
 err_xdp:
 	put_page(page);
-- 
2.40.1

