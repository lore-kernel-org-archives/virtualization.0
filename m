Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B63BBFA0
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310138; cv=none; b=OAxaatHnk9ZNAggOe7VzNoqYEnBLSn6XHwSp7Euh2bUZylSVbmQTtOfZ4O4Okcm8+gns4k2M/2ZNpH/p61TeSwjQBaI2bq+TUAiglBXfZfWfETFIwGan//Td/vqudr3iSXFFZeiGL+wct3ClhbzN90WIZk34DQZdZJaZFJw5azw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310138; c=relaxed/simple;
	bh=igFQrv/PXQXqgtIh1JcAjAlWZZUf6i60J4mXCx0b60k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIyv2n6MDQ1nvGTa5m0uu/dX1xCAlv04p1aClK4LTB5JrA9GD8/CQt+FJq4hBLfOAlOnGzn+uSSiir23zDHlPvcOvcQISNT5MtkIKhIX9pja4n2hSVRZqFax3Td6nZ9FFHo1uPuwbF7MxJFrAThU3pAH+TurBJ1USzWrHoE7Sic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org; spf=pass smtp.mailfrom=openvz.org; dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b=DDDC7QQ7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b="DDDC7QQ7"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4924944fe6bso7407295e9.0
        for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 07:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1782310134; x=1782914934; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCGKpS/WMN7c7W5tvYHxEGKLGq4sMQBRHoD49luMqTA=;
        b=DDDC7QQ7eB/qZh3WgysM27A+wzfobXWVcXOn/p7Hv0tMcIGPceXDUcQiUopOXNFiEO
         cmjDBnznMPJPaJeyyhZqxGVsKwWzdS4gKMDhLYxW8VdNnBWpnff8kpBOCEfB+eTGcJIF
         4AN2NkVbuSSmoIQxUvlHumOg/fnyGDhXYDUAjmYKLWQCOl/cJ5Lm2I8XdvTmN53uf202
         Jdw6eTHvmAQivxaSSjMJk9nnP3sGINwHB0tPg3K90fUcgV3FwH3B8UGjmgPrNeWBDTSP
         HZ5jnCdLSZgX7utorRmXYUGjWohDoVzCXgpjCcnqQ1NYE7L+HaYfBIJ2E3UjjFFPe8Hg
         9a8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782310134; x=1782914934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XCGKpS/WMN7c7W5tvYHxEGKLGq4sMQBRHoD49luMqTA=;
        b=CmxxpTcxFzgHLkPW7AVq7eT1XSr36+Cp3N16p9ZrMZHSyNd7Xc/roqFDDByMXXP6vK
         F1q7+SAprpGyFYDE6Wg9KC/uUMWUmWalOgtc4f7ENgnjzPAEPO/wUw38QxhU9G3Ra2AH
         iyEgmvSY+sE3lwWif9PgumzHiDzk//iyFapVai229vDhl5/l0axPEZNCs3LcDIStUBbM
         8V2NUX+YRilA6H9atL4IVSdj26hXNyzjcwghfBkh0MrtiLTYIOgFqsXHgW/SNMzvOk40
         h/UNtjYM0x/7BDfWi/47P2u49tJCK3rvempX+yeo9m1IgIMM6ZgiGQCZaGO7VI1YRAG0
         a7nw==
X-Gm-Message-State: AOJu0YyGZ1Yv1PDxkekTpos2gVkHNliTlu7R/5iqPfSae2hL2TtKGMsH
	sjKaK3XiwfaHdojOrIN/v9LAeHltRORQy8stPCVncPC8kpyc9nyWOdRCwK76s7mn4Ro=
X-Gm-Gg: AfdE7cmxIq1K0zhh8tAvbG6lq+S43fzirwsmlQxhhHhOq7giD+zPDPdiY6taNBuW8kU
	Gw3OYuu6wW+K4Dzr1tE7hl3ZGQao/dFjLoqv93k6FRtA8E69QJrLQADsPgj8LP6s7MxXC09Asmz
	X3SBzk8Tb7GXTJiPOPeiTGNkucruKI45GVOePjPHO6hDdA7UnDPklskWbjSWvLkdABbHq1pkG5h
	rOWFpnPM585ey2szJ+akEAjhO9uzbSqekVQtsm+rivqgHGxTTUgXMSSFoX/pQxGRvxtWz948LKm
	yNif8/3fSAni81ebVKVUF5MpXY24ZCDK09b62G3jCqhuECNTQ1HhXJJ4dP1pnTM5Ess3EQ2bcpg
	qSftQM3atB9pYRKo+EPWYBhVyk5cTIhYBkT8+IG6B6ucJx/KmFRhEnstGe1TPZHa7KMQMlg==
X-Received: by 2002:a05:600c:871b:b0:490:9588:bdae with SMTP id 5b1f17b1804b1-4926086d9bfmr51433695e9.18.1782310134163;
        Wed, 24 Jun 2026 07:08:54 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:306c:c2d:85d5:28d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1fa34sm519680275e9.5.2026.06.24.07.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:08:53 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: mst@redhat.com,
	david@kernel.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Denis V. Lunev" <den@openvz.org>
Subject: [PATCH v2 4/4] virtio_balloon: warn on failed buffer add in tell_host()
Date: Wed, 24 Jun 2026 16:08:46 +0200
Message-ID: <20260624140846.2616797-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624140846.2616797-1-den@openvz.org>
References: <20260624140846.2616797-1-den@openvz.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tell_host() ignores the return value of virtqueue_add_outbuf() and goes
on to kick the queue and wait_event() for the host's ack. The comment
claims "We should always be able to add one buffer to an empty queue",
but that does not hold once the virtqueue has been broken (e.g. on
device shutdown): the add then fails with -EIO and the following
wait_event() would block forever on a buffer the host can never return.

Warn and bail out on failure, mirroring virtballoon_free_page_report().

Suggested-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 drivers/virtio/virtio_balloon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 26fc3c40d5b2..0866a8781f0b 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -184,16 +184,18 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
 {
 	struct scatterlist sg;
 	unsigned int len;
+	int err;
 
 	sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);
 
 	/* We should always be able to add one buffer to an empty queue. */
-	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
+	err = virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
+	if (WARN_ON_ONCE(err))
+		return;
 	virtqueue_kick(vq);
 
 	/* When host has read buffer, this completes via balloon_ack */
 	wait_event(vb->acked, virtqueue_get_buf(vq, &len));
-
 }
 
 static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_info,
-- 
2.53.0

