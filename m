Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E00B3D6479
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 04:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787025889; cv=none; b=SM740UArEfJgeHBl4Bsv9kcdD3kaGirF+lBIenB2gQUagTX0cbbc15XVmF/N98ZopAqx62jcgqOTy8LegzUHWwu+dLGVOJDvuhnF5nywKBJ+wg3IzKWRuqt0Wb/Av3Ff30bgpqFAHYi3b6jGqCCNebBXUE77IsmibZ8xkQvsSfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787025889; c=relaxed/simple;
	bh=l69W+EZyKcniq5PZsld8TXXYYTWhjdq7srB119n5Ffo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fmh5LFlqNP3qxXLgS1/evrGDWa/oe5orrWz4k+OAt7Cj45pIOSC9k7f2oUA/JFPNDcpV22kvhYbiSXNPWLBdRET5zj01G19eQoCh9NWKbow/5SIFamEzb92zcgc4gQg51Qf3poRm8lf4SGJORnmhEhTjlpsWZ0ZAdnRFkWl9mkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/fNt6Un; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/fNt6Un"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so2881970f8f.2
        for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 21:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787025886; x=1787630686; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nn7G0bTuEpDi1wZUhidIQw3y0bqpyr7xiuj0he1hLQY=;
        b=b/fNt6Un1qm3+JPxO/vZ2LstfPxmKpMO2ekcZ3s+XBAFkUji+3unXyukUtsWxf5v7p
         8DEXru+SnLUDBB6BTGDcZzI+5SPQYVWqT+ppr6vkVblPfBiCm1LB1GP5VqI9NzBPJ8LN
         5F0fpF34rY2wyoZ+bXf7X02oUMEbcObSKBotfeHzV/5XkymjjpFTZg16Ot5e6vtiil1c
         xVW4G1Vcxf0I3aitTG4lpjDhP/8R2Npvu91F6zpndCccRr6VPA+E09kznZ/XddThx7+n
         CEcHdHv9WNYKGHzLy3aquPT/Nfnxge89jmMI/arSYOLdE/54yTDHL7CTybDiSzjcCigR
         8Pbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787025886; x=1787630686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nn7G0bTuEpDi1wZUhidIQw3y0bqpyr7xiuj0he1hLQY=;
        b=gKm51s4YTllJ9kWGy0U8eMQUaXWXoXfvHudCIzh8MuvHNR8i+pltXF5wtuaRLB0iSu
         7W4fk9OgEqJ6nJJ4z/JVkU0wBhIZHhnbgVLgVuGNUubicwRl9IdDmMwnI/tCyeiMiPkN
         t8EvbYrkQ3BBh7v1lCzdCQ0AsTMNlZrV2Q5re0RkCJGFQysS+YXhiysRtWnzsXm9/g7R
         UNzJe0tQypdrbMjKX1Nq/47dzTDzfsbt+IPbuIxkxWezI6bASl3LYAzDsCYTwz2RhBBU
         49tlnVGcT4vL6V5uqN9duYhfHia3nXE0PN7TBJGqke40aSMxna3qJ1+fhu30Wls0PYCh
         yO8A==
X-Forwarded-Encrypted: i=1; AHgh+RoNBYjMJjk4x6MrJ6Ro2Fc4QjXI0XEFFYoYSd1sf2wX8DvI0jGgtWnAxBTrXXTb6mcC8ZnbRNcaHGknE5etBA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQe0qdQX0OtPdVKNWRElvK8EHRJ9Dc98yM1IWpYysTAWeapHbH
	vOOnLPI5rOdyeo40Te4HhmDFFwEC0R0nDnVw5jfv3NRju7IV072mZzdh
X-Gm-Gg: AR+sD11AlJdvqV55XFjcuX9haO2SHzknDNAm95/YsP6idCRC+HD19p1SJWQO3Wyj2LD
	46eJ1CbiEZPdQ5bPxi0379KnEhzSFYGAtjEyRgFrSI/hnkwT+QAaYTgUCJPSkE6R1BF/fD3eD91
	9wUK18ywShiqH+AAkw4tG9ux/87sprGo9NepmiD3NUd02xyIIfZ8bkzSDuW7dI/l6CJiGAW3on6
	edUD1J51nN3+yu0fZ8R+xOWna+yxmk1iT7YP/CSG00cEE24dqWPaU6VL8E62vzvFZWKndzLJjfw
	s1v8t3yMu0eepp02TCuWTExn47JrRCdnuUA8MK/8A77U4hJgjjTcU+3egOOol1UUqelhYBokPLv
	NEzDD38lNIB4A2WmwKTNYyz2vVUUrkh/LJYQ26ajxlFPZN9wadEVKDscPqLzG2PAvFUX42zNApM
	mrpuGZzJBJWdi+FB49Gro6epEYvWPRg786GwniPdHzp8pbCYy7a0+MMibtJTMKwQ9pUT+QR/lOL
	93exanB8LNP4bkxUc1cD/KkbAQPwv7QzV1H+3HlN+SzTEz1V9Esz3rhViU9mKj+KkxWdLvFufv6
	SPeGV8xYl0RlpuG4AF7bjBxy3hYyo0b+296e0kiCkW7ViOvdMr0Aj2nAp2ehFpsR3Tc7zVK9J2f
	6JgVzl/qe
X-Received: by 2002:a05:6000:601:b0:47f:e721:1f77 with SMTP id ffacd0b85a97d-4816075ebdbmr48326885f8f.13.1787025886196;
        Mon, 17 Aug 2026 21:04:46 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a88f-5701-94a8-6746-801e-fa61.310.pool.telefonica.de. [2a02:3100:a88f:5701:94a8:6746:801e:fa61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b7cd38sm9030108f8f.32.2026.08.17.21.04.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Aug 2026 21:04:45 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>,
	virtualization@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] virtio-mmio: synchronize callbacks during device reset
Date: Tue, 18 Aug 2026 06:04:32 +0200
Message-Id: <20260818040433.66986-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260818040433.66986-1-kmehltretter@gmail.com>
References: <20260818040433.66986-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_reset_device() promises that vq callbacks are not in progress
once it returns, but vm_reset() only writes 0 to the status register.
A callback that has already entered vring_interrupt() keeps running
while the driver tears down the state it uses.

Wait for a status read to return 0, so the device has stopped raising
interrupts, then synchronize_irq() as vp_reset() does with
vp_synchronize_vectors().

Fixes: edfd52e63672 ("virtio: Add platform bus driver for memory mapped virtio device")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/virtio/virtio_mmio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 510b7c4efdff8..a2ca03dbe803d 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -55,6 +55,7 @@
 #define pr_fmt(fmt) "virtio-mmio: " fmt
 
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/highmem.h>
 #include <linux/interrupt.h>
@@ -254,6 +255,11 @@ static void vm_reset(struct virtio_device *vdev)
 
 	/* 0 status means a reset. */
 	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
+
+	/* Wait for reset completion before flushing callbacks. */
+	while (vm_get_status(vdev))
+		fsleep(1000);
+	synchronize_irq(platform_get_irq(vm_dev->pdev, 0));
 }
 
 
-- 
2.53.0

