Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65751862A
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086724; cv=none; b=PxWbAOxQJnfBnDQzsFRB/PTEpsj0gt1B7PamDVWJ5dMu0rjWCkvWF0EmeaPXsxtWdBJDYO3E/CQ1jt09RMdiHi1+tNmRX2NGFjTB4wTg/GsyCmfkli2HXt3KzgPBf11zGWY+UrNo8sRt1aS6m9hpgHmq8yh/mHvG4kICrgAf3GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086724; c=relaxed/simple;
	bh=pm9aMyhWNz9rm/sMj0oyg9mmTCbkXLENoPmkXenNn3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJ+xwPieL+ELa/ZcSoWD7hEWMJb6d0vtcI3DTEIrX19mD4FdDPfUWAVZpOT9gNbrNEbf+Yx5aTlmyvPdjdYOXDplj4IPXV439Rnw8LeKzHzYg0JbUxgzCojsMcACDPIWCNbtRtTufHg7D3lZ++Nfy9V7QgVxzVpmPuc2b+WkmWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DD9Krygt; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DD9Krygt"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D7FC42FCF
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 08:58:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3D7FC42FCF
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DD9Krygt
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oAhoW5pCVLL0
	for <virtualization@lists.linux-foundation.org>;
	Wed, 24 Jan 2024 08:58:42 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9C82C42FCB
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 08:58:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C82C42FCB
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d7881b1843so1301515ad.3
        for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 00:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706086722; x=1706691522; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CK0KBx9FD+Y1tESpbZmNKfn63bqMoyAe4iVd1hNTd0Y=;
        b=DD9KrygtaEs1gCQrD2hEFhv25PxUrXTrEnGVnXUTalJ2pz4w1XyNWO/y9BgbncYNA8
         JXWFuHf4U9XvC0b5K0V3laGw5rV0IizLFRKHe30pwamTTu2qm0gxsbsG53VKsDJFKTps
         efllFqmhrFE5JAv7MonJCYKy5EcGoCE89Jh9ZaD0e4s6yKrvhhKGR6sLx1lcE+jFNvNh
         DUAFVroUoeYFCVaMXz10GL8VPDNnzGCmJjg64vN1/xTPw+kHIciqvyVWkDMYFZr9CJfM
         46mZ+1cZ9p9ISv9vsAKezOiQYzwgTzuoVI9bEG66bV1R1dDEdJKN8VYHoyox3PyqLam5
         RqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706086722; x=1706691522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CK0KBx9FD+Y1tESpbZmNKfn63bqMoyAe4iVd1hNTd0Y=;
        b=CmbcEja5Nog44uHdghANNAPMJX2aCZGKLQZ8+lZrVCwhyo2Owoajs8pwrYbu/BKGV/
         jpChCV9OM4sxX716/mnY4DXf67JW7lsW0IfnaSFvIJ5O1Mr58+lExbqxTEBTghrpYSsq
         kbwEuI6+VX2oaSV8w0Q0PDnb8Jpmd/h/89cYQ6ZhEteoW0/W6Z7lFkTw0Kk0zwJK3N0m
         a8LmzxGhL/HNOV7ohV8MNxEks8j4dhBZESRogaLsW/4DVxnu2aY5b17ye2DD83UWpurl
         jNlCx9dAeyQzJnMrY5KTXaGuquWteV603D4O8FssCLsAkSfvXex2cDcvEJXVok5/BkGV
         f4SA==
X-Gm-Message-State: AOJu0YyL8QVirofO3NTnewj6UFO6piq2BKE+yy/i9e4hjCd+SxljgvnQ
	5PogLwIUw1edMJHWWNLJh5LMAoeIg3sbo7Lk4lnLZGfVoy1t/Eku
X-Google-Smtp-Source: AGHT+IGdbtmBHlh771/e7XW80WboOCEY8KIq0A7Cki/4uv3/prXelAx6n10SWNOjukoJlGlxbzdHJQ==
X-Received: by 2002:a17:90a:880b:b0:28d:1e38:88f8 with SMTP id s11-20020a17090a880b00b0028d1e3888f8mr4079930pjn.41.1706086721888;
        Wed, 24 Jan 2024 00:58:41 -0800 (PST)
Received: from localhost.localdomain ([107.167.25.130])
        by smtp.googlemail.com with ESMTPSA id sb3-20020a17090b50c300b0028ffc524085sm13192233pjb.56.2024.01.24.00.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 00:58:40 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	hengqi@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH v2 2/3] virtio_net: Add missing virtio header in skb for XDP_PASS
Date: Wed, 24 Jan 2024 16:57:20 +0800
Message-Id: <20240124085721.54442-3-liangchen.linux@gmail.com>
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

For the XDP_PASS scenario of the XDP path, the skb constructed with
xdp_buff does not include the virtio header. Adding the virtio header
information back when creating the skb.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 drivers/net/virtio_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b56828804e5f..2de46eb4c661 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1270,6 +1270,9 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	if (unlikely(!skb))
 		goto err;
 
+	/* Store the original virtio header for subsequent use by the driver. */
+	memcpy(skb_vnet_common_hdr(skb), &virtnet_xdp.hdr, vi->hdr_len);
+
 	if (metasize)
 		skb_metadata_set(skb, metasize);
 
@@ -1635,6 +1638,9 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 		head_skb = build_skb_from_xdp_buff(dev, vi, xdp, xdp_frags_truesz);
 		if (unlikely(!head_skb))
 			break;
+		/* Store the original virtio header for subsequent use by the driver. */
+		memcpy(skb_vnet_common_hdr(head_skb), &virtnet_xdp.hdr, vi->hdr_len);
+
 		return head_skb;
 
 	case XDP_TX:
-- 
2.40.1

