Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082776;
	b=BtdCo9wTVgoC3GFY30iq8mI4AaYA/aUCS2GBHld9yHMQqsyVliRMdoyz0G0UWyvFPldE
	 gZS5aifFY28YQL5SA6Tjuqur+V89FwZUAOdVn95hdJaurODPGuqEuxc+bjBavhHCwRZPv
	 oHvoYc/oJo++i+y1gaBcaxLZrPerZimFiXTcAGmYbkJeJ5w3gkFP4JnPjO1PJxUF2U4yL
	 vid0QC8i1kqyCGRVcQDbXmi3V+MKEgh4AGBGpgcg0xZsaVJ3fHK3VzKaQ3s1ZQfnSfJXP
	 LWqaNxWaaZhPudryrZxCfGw2Tku1CxBiJ9wO786U6MNKn5WrWv4PDGxUuj6b41ptRUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G+yf8Opi/PoX6Tds8cSLMSM4duoTp3+4gtT19yIltIM=;
	b=xQ/O0nRPlOERTpUBP9QayBLU/xUfjeyf+AvPr3QCYrt40ZeCjwIW4qH682dUS3f5tC5r
	 nd56zLpUlcNtBc30zyPCOdw2KOgnQRlxvrvPdv0YZMJq9nKdMzQyGgIB5f5EhTR6+UdmR
	 A5pr9Aje1TKhJGjyjSX7+6c6Eio4ONe2qqeuuL/IWDe/kMZfX3xlGj9dETDBPAYqmVfCi
	 Pt0fjmin3SIa3XbUal0zF6g5Reh3D61nnkThuW3MD3TGZ9q2Tn1Qygld5wcG1DICmJE2D
	 QBfQzvNcnseePSVPpzdWyX11ibzmqzjLP8hN0QbpwhtfnvzpjwV71z12ITvZG2WAHGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=liSPDydo;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C003606A325
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 10:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C003606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=liSPDydo
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b405d8f1cfso196926a91.3
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 02:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795082775; x=1795687575; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G+yf8Opi/PoX6Tds8cSLMSM4duoTp3+4gtT19yIltIM=;
        b=liSPDydoJ59ey09DnP9y5tg0jxANqZOEvg+e+KmPiuEwFNAQDFTFAa7gy6FH1WpMMT
         iSMP4yHFlksfzTZRozshx9BqUtklIGHJ8MPe11zlqi62P2zlpvNS9yvAnMaHd05pKAnP
         4ZQnEO3MwGKgR5cLyYdOC8fdcwttLsOrGjB3ZoCYPHL4vcQ9FKh+Usp4+fkmvM3cJE7A
         8td35YUtolHdqWTPRuhmKwI3zoNcTmvm1vwY6wFHZUZZZEOVd+T44TyJpY3WECwZUUpb
         e+urZZ1qLjVSkebQ7xq22rwz8Yo6JlboSX6YEfQF3HIWdO5PAL99PpFJ6Vx+1+7X7LMj
         zzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795082775; x=1795687575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G+yf8Opi/PoX6Tds8cSLMSM4duoTp3+4gtT19yIltIM=;
        b=0wnJyBARSP1maTElHthnfaZtHVc9Z+Nvxykr+nDc874+958QcYXM0HTfvUCUILl0UO
         NQE+TXVdEwm029JAXICK6lNNLUec8xITqv0Dt2qhnhhqFhihASgB55Ry/bjZZi37SBFj
         JN5C0IMbJsPVeRUFlE41XK4WMRpLRKlTc6tMgvgtFMoVMhP3dP6AvmXq8qIBkgGzYcPH
         qa5u1n/gv4C82fljvV1bFvPAIYOQ06Ve+GKzTW/IAzTlZkCt82cvTTEYQidiE6jb4laX
         ZttWbq/+ANqb1fVuOdeCsp1BYPzANnzOBzHz6feugsecq1/4b8YAFbnlvpnEFGLe9WLD
         y8HA==
X-Forwarded-Encrypted: i=1; AL+hErGKSrcnPQWXRDlPmAgHfypX6g5S3pVyUhdwhmO209XebupFkcFCV5C92P2NNRWO2FWVrbXkMg79cXdBT9B0pQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Y4/P0/nT8R7zdnM6yrhPub49Hb1GLm9Hie5tus6LUrTRiymme
	Bp7CJnrhLUknvQ/ls7UDRoS8erRxlUqdR7oCVHCVMdQC5t8VxPLY6Qg=
X-Gm-Gg: AZFdTZfhdMk8l4qMjB7KVOiTVKAmRp4nTh+PRvSrvQEHboFwPYuFkUpk6ryqLYzwgc+
	jZy41U5NDhFt7bxywFUOXJZxIcc6ZCVJ3Xb53vs70O1G9bmsfo+wxqxpktvfv6hmvsbWaKLwN9T
	D7M0vI44rXf4JCbP0M7TNIgdPqqytKSvsAaXCvSm2N+SGvrTQjR8emwifWeVGQkgaJs1tS5mzFo
	8Lnuzsu5GBb1VWZoNg3gjydHzfn6JRGKM+sDWgVm9QwqLgMQdgMu0yqX2N+pB73rVaawKFtJUBW
	fNLxpB6t3Fec/Mdo/OQI6pisuwM9F5caoAZSob1Mqv701Nag8lAJe5bI8y1nsE/4jS941p5Mkvy
	dhjYfCyl9LGc/gjolvVzy41bYHJJuKHZgQHvgfB9KaI+ScWrYX9mDAHZR0PXUYUs+e9RkqAj8JI
	lRbKBBhn/kVeuzh5lOxl9gs9/Tff+iJHbFG4Iibi3jV+ex8594hbpq4lKfr17A7w/5RSz6Wb4yh
	SGjC/eTpiRvki8GeBvd3bfAYnzlCauQQIYWdpZCKOdm81/XAsumNuAJDmsepaq71eRsqMX4Mpz7
	HQ3w2Tqr4PxnZ8DjRl5eZV9k0CU0i7CO/JDlYNc0tAMyhIYbYoI8yk3xfQxx2+75Ka00
X-Received: by 2002:a17:90b:1dcf:b0:3a4:e735:b39d with SMTP id 98e67ed59e1d1-3b3d0815de0mr5023900a91.64.1795082775366;
        Thu, 19 Nov 2026 02:06:15 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:e9b9:3878:5565:ae99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff62e38eesm28622955ad.76.2026.11.19.02.06.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 02:06:14 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Francesco Valla <francesco@valla.it>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH] virtio: Release the OF node when unregistering the device
Date: Thu, 19 Nov 2026 18:06:06 +0800
Message-ID: <20261119085343.virtio-of-node-a02bd3cf522b@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_device_of_init() acquires the OF node reference once during device
registration. virtio_dev_remove() currently puts it on each driver unbind,
although rebinding the driver does not acquire a new reference. Repeated
unbinds can therefore consume references not owned by the virtio device.
Conversely, unregistering a device that never bound to a driver leaves
the reference held.

Move the put to unregister_virtio_device() so it is paired with device
registration. Save the node pointer before device_unregister(), which
can free the virtio device, and put it after unregister has completed the
driver removal.

Fixes: 694a1116b405 ("virtio: Bind virtio device to device-tree node")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/sashiko-outbox-203883@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
AI assistance was used for analysis and patch preparation.

Based on next-20261104 (8b7179210b22).
The same OF node mismatch was independently noted in the linked review.
Compile-tested on 2026-11-05: arm64, GCC 14.2.0, W=1,
drivers/virtio/virtio.o; baseline and patched objects built without warnings.
The code diff is unchanged from that tested version; this refresh adds
the public report attribution and updates the mail headers.
On 2026-11-19 the patch also applies to the identical virtio.c in mainline
4405c18c95d2. No new build, hardware, boot, or KASAN test was performed.

 drivers/virtio/virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a8588d7ad109f1d65135dc7394b1dd4ae04978f1..c8be1a3f479d6abf1249f5fde66b6c93cb260d0d 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -381,8 +381,6 @@ static void virtio_dev_remove(struct device *_d)
 
 	/* Acknowledge the device's existence again. */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
-
-	of_node_put(dev->dev.of_node);
 }
 
 /*
@@ -604,10 +602,12 @@ EXPORT_SYMBOL_GPL(is_virtio_device);
 
 void unregister_virtio_device(struct virtio_device *dev)
 {
+	struct device_node *np = dev->dev.of_node;
 	int index = dev->index; /* save for after device release */
 
 	virtio_debug_device_exit(dev);
 	device_unregister(&dev->dev);
+	of_node_put(np);
 	ida_free(&virtio_index_ida, index);
 }
 EXPORT_SYMBOL_GPL(unregister_virtio_device);

base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
