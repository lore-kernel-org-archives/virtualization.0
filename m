Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1616118DF64
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 05:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288898; cv=none; b=lad4szpl8QPmfV2+Y4EiBKsw5aBzio9KjC15UHgB5oThSt6ZneAskatk7PnlEVCWlYq449S7atjPLoKsYZp0qdDElUgUi/7wtVqUgNu/XsHYJgEH7zVV0YtY7+VpJKh7EA5vt2EdGNao5FAPvuJ8G0yr6D/UkCkIU6eeRwYOGE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288898; c=relaxed/simple;
	bh=gLYoI15BjmtBU7oAvSpTarPfyfyGSgvB72KHD0BKUnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMdLviO3Sj1TZszrbKCe734GABOOLEWxF+P1zflDZQDNuZtZACgJMez6h88P5IE7o0HYSvVY8wUcQol3lYNiNSkLrZ3rVs2j6fGUHKnohJpoELpO9dIQ/dCe19ja4/xICgm8BDlmU6PDg1YxHZ2pzjpBUuA72vo4VGS3hAS5z9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nDC+V+XV; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nDC+V+XV"
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DDECE40CE3
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 05:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733288895;
	bh=ObVc7Whi17Pu6UUwsCZaDHkuVEONGWJHt7EBpIl7aAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=nDC+V+XVcAD7b1H+1pBB2uwhAywejnQ/hMRFp+/jG23uEQ8xcyCd7DNJrJB5NRwup
	 pvzi+glCd2gAoKxP0vu813xGDVgcIFujukFGUtEpnFIZKnW7Cy0vQITQoxXgl6btHo
	 4Sx585rAL4o+J0zI9xb34fZHydysrUaDjQ8VywfhtJAmfOXOlLaKYo7Ynlaj6bb4el
	 mczlFqveJECYWvEtov3SuxjDvDtmgt9NdFgRrloBTcWfYA5ey1YGTC4w5+CpsxJ+og
	 LJps9Cvx3XxGE4mN5wyK3zv2rmUcvxGqy278oTtB0KT82YJiU8kmNmGTNBaxQdEgLA
	 bDX+oXzAcSLOg==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7fcd0eff40cso2399017a12.0
        for <virtualization@lists.linux.dev>; Tue, 03 Dec 2024 21:08:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733288894; x=1733893694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObVc7Whi17Pu6UUwsCZaDHkuVEONGWJHt7EBpIl7aAs=;
        b=K70enJ5ZGZzQLRAOSgK5HMjs65lVSRJVmedNAIT3GRy+1djzcFCuYptdzvIsgNDaex
         llh4cXA+2YakvJ7Jvo6luwc5wcmXmn6DU4OI6/mg5UImD67dTJqw5j3RnYnD+/6y4XRW
         I3Q/jaAcerjYoPLAUULH1rqS1eeg3Hu+9c6C9cfd5BH/Weh9C2HBjbaSMIvhGFRRCN+2
         gB0LDsVfgfWudArG/HNZRmdgv9Q64tiPrykdIVEhqbPMG0ZuUXAQKTBOd2Bkr563zr8a
         HQsSTk6m9Y728cZl37YXxwTuT1zcvvDsM7FsBrQSn/pOyGZNGbhYKExBlghTUjtBmKK6
         0jRQ==
X-Gm-Message-State: AOJu0YwCvq0MMZuU/Th9mZPPwOYFQ1l6D2EyZDc6QvTG/yNjYBrNYp1j
	o4+zwzyVRnGoZyBGcsnXBMWju3OcQX9m1K8o/u1dGE20acOH6cjRVtJqJw4fuGGfUvG166DEj+B
	XLMY+doT9x+1hzZUytptSQY6KXECJAeWFDyCjWsHG4t0g1pBNrpZFi7sgMmk+FgZ8CxKOB5PJNz
	fvmSNKCMJT3lTX
X-Gm-Gg: ASbGncs/v4lgw9fERsC5vwAuz9LGufvdWaTQBhbY7UZfQt03irC1gsVBtsPOWxHSTgG
	NVoHHwVFsy5tJRu00pM9bZXjubTQIegDYGLx3V7L0wTwr5Ew/c4eHa+oOeV7XZgsaZC1UuVFlnX
	0LO5O/jaWQd2jMguD9JakQFgab57GWVNi5RvRQiLOoQWPkcj7DLTtVv4hfmsf2KS8IPRzVjYKAG
	tQL9Aw6t6g1kzDUSeFKHrUXbLCOGUxHJZiFgLm9+uhgnXvUozDcYAmIVh6oXGN/j2e6
X-Received: by 2002:a05:6a20:3948:b0:1e0:c7cf:bc2d with SMTP id adf61e73a8af0-1e16bdd328amr5699731637.3.1733288894393;
        Tue, 03 Dec 2024 21:08:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj+uUlyY1C0BsWmALoxtojbbY8sLNjryjJ+hUDmswkw3F7P+vqgijj+KJpqRsQ36IWx1WReA==
X-Received: by 2002:a05:6a20:3948:b0:1e0:c7cf:bc2d with SMTP id adf61e73a8af0-1e16bdd328amr5699705637.3.1733288894118;
        Tue, 03 Dec 2024 21:08:14 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd0a0682d6sm145466a12.10.2024.12.03.21.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:08:13 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net-next v3 5/7] virtio_net: ensure netdev_tx_reset_queue is called on tx ring resize
Date: Wed,  4 Dec 2024 14:07:22 +0900
Message-ID: <20241204050724.307544-6-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204050724.307544-1-koichiro.den@canonical.com>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_tx_resize() flushes remaining tx skbs, requiring DQL counters to
be reset when flushing has actually occurred. Add
virtnet_sq_free_unused_buf_done() as a callback for virtqueue_reset() to
handle this.

Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2a90655cfa4f..d0cf29fd8255 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3395,7 +3395,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf, NULL);
+	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf,
+			       virtnet_sq_free_unused_buf_done);
 	if (err)
 		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
 
-- 
2.43.0

