Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6720EA49
	for <virtualization@lists.linux.dev>; Thu,  7 Nov 2024 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985678; cv=none; b=pqsMrYb3T6SFoeAxoOz1alKZqTYDrarrIRwObGLa9Yq1Xh013EjoppYfd2LoNFk3jFFeEOT3btLzGTy/MopVOkelN7+O8bDrX423ZKRmA6AK3zjii5hgwJnw2Gp8Y1Uucc/bhalLBokjKMpsgwDd6YoXrAP6CFqu5GtjlthDUZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985678; c=relaxed/simple;
	bh=OVv9ifGn8JQI5BCwW+w6UoB4j809hlfmgBlW/wNe8BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lgndRY7ZYKIxlUkbfjjBSwcWUybtwVz186vjC2CHH2WykhZzv53peS1ybveKdYlRKoyf37ICR3JOQF0YnBEoWvx9xau4Z6z1nFHJlIwX2obPR7Pgyf24wdF/4gLqscoToxnV3ZKkQH0aO990ocpUGfb3yIiyfPg2Z7bwmMPaXTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R93cymDU; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R93cymDU"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso520280f8f.3
        for <virtualization@lists.linux.dev>; Thu, 07 Nov 2024 05:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730985675; x=1731590475; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x48A24d9EG3vC7+OzW7Pkz/MOvuoiuHEwn/TjkX8Lrw=;
        b=R93cymDUtrtPxjz5NkHqpedRAx/FqNgaLy/VRFQwwlZRx+3xej5nxUn0ZdoVZO3FoA
         S2KHuwBbBrbyUpQwiQrL3s5O6Z7dWTd2PWORZXbYxYULTHGyRnYP8Kre6aw6V2aLc4rH
         nBsweeHhEh8PoCsANtUQ+lDpMj7opEedKUWbmZVntxNH2Rl7MnpPcIkHDfkSK+0mUYFB
         FPf1/ORIDVXZVuap3pmabTplknDXrF5eMpXOu8JtTTM4NR/ehDntulaYsZqRKbRjvc66
         NaLDegfXl6EQGvMsWtD+ZnyjdYI5F1jT2rEq89QkiEkhMmtL6hSo7cNb3o5G9F1nALXX
         ddCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730985675; x=1731590475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x48A24d9EG3vC7+OzW7Pkz/MOvuoiuHEwn/TjkX8Lrw=;
        b=NW5yr175pDi1RovoAVV+4iDoIPTR58GZy59p0G5po9Wwdu5ZT+wldzKExcNk2yfXJk
         Gfnm2Mv/tf0KTj/XZbjoZhfoKdvspcsJAVihSktuWVXPzRFN7LmYWOLnLG95TQLim92j
         ZQVLShjt5O+uDS5FUU9qsnTmvQOsH9gS7m0zu5rivKph87w3UyO2J33Aivzv5gr60RZQ
         bfLx++9ye6ADTugyMkzCUiOIFvXUCmyf1o96NHqeEy8xaHfUipbdIFMLsP4lWQYoStLY
         2D32jzGwvP6mcGC0nT4geIZi3SoSi6NF81IkF09HqqN4N9oX4wbPKlz0x+r1g2hTEEnT
         E89g==
X-Forwarded-Encrypted: i=1; AJvYcCVF1Jy1xdYwPjX9jXvnwe+5tvk7enA2ARvQdcKgLBe3ax7yDeQh/dyQC/pNyDOZYBAObqR+lfg/knIbKsssLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTfkU9/aD4EcpFeOj6DG1M70JdtVO8FgdPAYW3QkJCo6mvC7p3
	HSfqZtRYwVV17+Oh3e0DsHzko4ENRu/RbPppriXDpgZ9sELyjezp
X-Google-Smtp-Source: AGHT+IGDc+8YZf7dKd0Zij01XmxG6xQTZ3cNTUk7h0sARTGTVOECCSJSGzn9JsXbtM3C4Gvb7uXKoQ==
X-Received: by 2002:adf:f28f:0:b0:37d:4b73:24c0 with SMTP id ffacd0b85a97d-38061190da2mr27250414f8f.35.1730985675155;
        Thu, 07 Nov 2024 05:21:15 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97ce0fsm1711845f8f.33.2024.11.07.05.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:21:14 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] virtio_vdpa: remove redundant check on desc
Date: Thu,  7 Nov 2024 13:21:14 +0000
Message-Id: <20241107132114.22188-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The boolean variable has_affinity is true when desc is non-null and
ops->set_vq_affinity is non-null. Hence the call to create_affinity_masks
does not need to check for desc being non-null is redundant when
has_affinity is true, so it can be removed as well as the now unused
default_affd.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/virtio/virtio_vdpa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 7364bd53e38d..1f60c9d5cb18 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -364,14 +364,13 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
 	const struct vdpa_config_ops *ops = vdpa->config;
-	struct irq_affinity default_affd = { 0 };
 	struct cpumask *masks;
 	struct vdpa_callback cb;
 	bool has_affinity = desc && ops->set_vq_affinity;
 	int i, err, queue_idx = 0;
 
 	if (has_affinity) {
-		masks = create_affinity_masks(nvqs, desc ? desc : &default_affd);
+		masks = create_affinity_masks(nvqs, desc);
 		if (!masks)
 			return -ENOMEM;
 	}
-- 
2.39.5

