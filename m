Received: from mail-pz2-f7.google.com (mail-pz2-f7.google.com [74.125.228.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2396038CFE1
	for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756475; cv=none; b=TYbEFHJxRFcuQkcUbiWIYVa3v4Kgi0crMz7mby9Wcg8YOKt1lrTCDeXUVWabD0qHFdnD2Ibh5l9Y7/I7BgLrJ0c7Str4parPC3HLM+U6qkmMzcl2A/hfc+aUo01F9yEzrvfxhhZAx0yO2DKPfJhVE3E3mHzZfDTitLOGbWdndkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756475; c=relaxed/simple;
	bh=P0WnxZam+SUgpdEBgJI3LyZDEoc1jUHTMId8rRtkibI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOoyv64ltAPiEBt4IEZyi1dsFiX7/MRX6njwXDYJwQjPWYR/u8W9wvKXV7nx4cK+C/Zlvgf9p90whDsyzSDYgcIEx06T1yKYY8eAnlJQJrJiDK3YWwc1g6W5TLhRDWCLngyM4nzzDWpdEFyojVlwF0+oh7orKGZhr9pILXHGkOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pz2-f7.google.com with SMTP id 41be03b00d2f7-cc4ae08cca6so353661a12.0
        for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 01:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790756473; x=1791361273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eq1BMklhPqpvc1j1QI1dLTGY02tlXth1DYlMuyL2BbQ=;
        b=xWmHEPoP/nwpd/Se0J9o2lIuvvc4oA+hn7f6HijLN1/Gvbrw56y5JzFXz7JkJgl93X
         UDoC8fZ8se9uyy8XpDaNmxfm4n5nG3CMLzdKgS4Q+JKe1Y9qO50oNktMm+zZueiucqNv
         dwXjsBUoJ/17dVLqqyw4rU6dArEV+GdU2JpgElgaK7i9EflI7uyR7M6LjrtyMx8YVwp5
         4RGgxjOFOQDZNkIXWgNsSF6zLr7Dw94FzTRnH3TnuSXzajCMVzpxKVhhOSJVzdrkEGSe
         /TcFyDLScqF0ksy68YFzP7Lvd6QtvVkDljHzP1mJGT1XuGcRTspxJ74hu02T0LwcYQF3
         pVbg==
X-Forwarded-Encrypted: i=1; AKwUvBzFEh8PL4ASvAsSc99GayZjf0V/Lqvr8yb2togGm2UouvbfNnOLoDaQyxBnwuvF+rCGSL2xBeP2Z7ni3ytr3g==@lists.linux.dev
X-Gm-Message-State: AFuF++ljN0jj4UZK3UqEsGi82wrXvkY4tljGsNQEluo4ceQEb21IzP9L
	RilCM78jL4CuHoFa++92RGtKpqu5rkwVLw28WS2IyI3RPa7/Ls8RCmf2
X-Gm-Gg: AYBFou3cnhj8EQfT5PAyqBMYKPpe5oPYAjjo4xSUz0NBnb6teGZ+X1qNOX9qWcbBl4w
	UmEBFRbYGK8nxVSYZm81K34YPi65luGsAH1c2Ogc/l2JqhRC5MoJvjkyrqQAoyxCoLqueB3oDZO
	MrZPN1jpd8zMUOaEkgr6hLRbXlEa5Tdjy02yirdmWQgi5BuWYyoOpYReHjnZvdJcAvsQBo/6LGE
	jhBpoXxZBHhklxgyGI8EFR7Y29lO4PkJ9PQOL0MvX76B3FA3V6AuQIVFTyT90GskxNmbvhaQry9
	YancA3KUL3kwcmf6pfQM24BOoKSEcw0jOLTF3zUwq0dOnkL+AsIm1ryqTrVTpwZiniXRt2kvAbJ
	8dIYVuNph9zldNh8WOuys23+Bn2CFAEMdo9ChNbdUV68hzXlBfmIp25qoBo/NyFTXNglr6jBHaa
	AzmPkOiBYBh8BExfiaqnAb8D35CouUT464gjHBGbGvUh6TJUJ2osSBBCjWlG9a9OaMtJaMqGrjX
	G0s87Taml0ZgrcN9WI=
X-Received: by 2002:a05:6a21:1145:b0:3d3:adbf:777c with SMTP id adf61e73a8af0-3de9e6e601amr682846637.24.1790756473028;
        Wed, 30 Sep 2026 01:21:13 -0700 (PDT)
Received: from foxmail.com ([120.239.72.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8872643904asm419955b3a.45.2026.09.30.01.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:21:12 -0700 (PDT)
From: Jianlin Shi <shijianlin11@foxmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	talgi@nvidia.com,
	hengqi@linux.alibaba.com,
	horms@kernel.org
Subject: [PATCH 2/2] virtio-net: unwind VQs when irq moderation init fails
Date: Wed, 30 Sep 2026 16:19:52 +0800
Message-ID: <4e21386a0840526578eac3dd10443758bf3b84e2.1790751008.git.shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790751008.git.shijianlin11@foxmail.com>
References: <cover.1790751008.git.shijianlin11@foxmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_probe() calls init_vqs() before virtnet_init_irq_moder().
The failure path used "goto free", which only calls free_netdev() and
skips virtio_reset_device() and virtnet_del_vqs().  The virtqueues and
their DMA mappings leak.

Use the existing free_irq_moder label, as virtnet_create_page_pools()
already does.  This is safe only after net_dim_init_irq_moder() clears
dev->irq_moder on failure; otherwise virtnet_free_irq_moder() would
free the dangling pointer.

Fixes: dcb67f6a9ead6 ("virtio-net: support dim profile fine-tuning")
Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e34c52d059d3..ef61097c4404 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6996,7 +6996,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 		err = virtnet_init_irq_moder(vi);
 		if (err)
-			goto free;
+			goto free_irq_moder;
 	}
 
 	/* Create page pools for receive queues.
-- 
2.43.0

