Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4383F7893
	for <virtualization@lists.linux.dev>; Wed,  3 Jun 2026 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511963; cv=none; b=IWsbLrG9IKleDCTei+Efp+ruyLAT2yyNSPCVef/sb8KwhYj3enZ7wdltLAw8VY4Sm2hd3hNJB+ulj7ppw5lMio4HNfEF+TQY+jUjv176bu2fTgKFyc0GVboIBZBfM4rfoPCEKDrF/tmrYd+sp9/nCwYbMTuwnKvT/Qxg3Bjhvwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511963; c=relaxed/simple;
	bh=TF4ItLZ8YlQvNhPtSMEpt7L6QIJyhDMz4eCFIc7jA2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=skKDz/C4mJJUmR0GPqp8B7wDCxazLBqND/IRSzTx29HM2/Ij6GdIw8yrMsAE8gCbVJzx9HQqZiNxuiigXJVZ+C9pTgokiCXiK9XJ6t9jWNpvUv79pEqUL8S7HGzsxpBnR3CzoWy1R3rwS9FOC+mx9X4iClprkozY7RbpLP7yCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDx61ctJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDx61ctJ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c2d8b95bso28179855ad.1
        for <virtualization@lists.linux.dev>; Wed, 03 Jun 2026 11:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780511960; x=1781116760; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozUbJpWYUhzivTommeH38n12r1e/VD6cdi/cyCWnfZE=;
        b=PDx61ctJXXIwSd9dQjM7iQ9dbis03zZvvgRbNPVKQuwW4Ja+bNQlUO+RAQ24yzvv38
         f3KhlFN1LuyMhR5AzCrPFBOUyxPwUU3ywx4+AMn6s4DEIBgLLTDUAPE5BhFyb0O72D46
         o9tXSBUvgktmIZCZml+pLQpWb8Z/hZJp6iDi7BMIwXSg5DHDFTu11S7VnGLLgH4Minqe
         BpCbpsEskyaCBNyj+Ch2EMSXr+lZf9BSNP9nCpYWJO7jga43Ho5jtBua966Zi1NN0grx
         FtSpmuivpiF7njlIztZ++bc9bdFH059tdLw003ksNaRz2BAYDr4g0mhf6Hw4Og6miYDO
         ZCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780511960; x=1781116760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ozUbJpWYUhzivTommeH38n12r1e/VD6cdi/cyCWnfZE=;
        b=aQ+66gYZWY+p4/Rw3ODpP1qHOwUy4VHk9PPV53/mKKIfXyVxQWKsaYoAuI0+p8jrLC
         Mjrdlq5PtZ488jwPJGqycX4jzrR0elm5yaajUCHTZg2D43MHgG6++uBGPnkoGOJUqupT
         X4jW45xZ5h6vId/tDZuOctUcju6DjzuA3oeZISPVFfQXKiT6tlil5PzLvAjVoRt1rDIl
         /Q2ep+K2Q3hVLYMfjP2GsZ5VY3O0NKMTEWBRSoy86V6jwIWuFZv9Z5UT8OuNRndmYpAC
         5eengEUiurzR9Jp2lOkZO2b5gB8vQG2d/bn6t5QzTJLD7Lbzub3tP9g5nsNrE7M6X3X/
         br+g==
X-Gm-Message-State: AOJu0YyHC9y5Am5bQksxe86z2SraikXlYm0eNQUkDB4e252dHxZa3bad
	RShBNkICoAzACegazc8lp64yjYnuBGABUdmRcLu2N0ES3ueIz9BgnbR7
X-Gm-Gg: Acq92OFefNsZYgfvNnduJh96nttuwFJKLWb95Rmo7qnMVO3rtbGyxWn11KUnJQHrZqD
	+2gZb5vXTlfo1wNC07Vfl5kf99j05WX+gyXVnPaLyP3tYSVoBrLa3soJN4ZSmPi0SCpRHlhfTWV
	vndphmow66md/KmU+3BlJ3d0aaVP3ZuV18j8NGqN8VVFBfFdOf/H11bITLtwXVecL2GBNPFmUw3
	R/xLuYDZ1f6tLNFM8+cL7n9ohsEn5b9e8g0x9Y4mHRYgfcwWjiFE07I1t8JhOdpABl89SrsibB2
	dAvrkaNpTS9DImMnGWstcm4oIKt9vQ/iHzD7pGdFBm/rulGQWiBUFa1AOHgO6ynQT19j22rAGmj
	Nj7BHUY0iDBm9RWAKCbmgAlt3uSvEAHlLkt9w33/iq60YjnL3nK5Nq2FAcc5k/ZqBMXPowNhzVq
	+BfOQ12S+XksZmlkSyWPbM4PniNW4RVkG75AGNa9oQh+GR/TqogqboCrxtxeKZN/bdK5bpStwFm
	sWU6bItkjlFTzU8bxmf1qT8x7dKd/BK8+ql8Q==
X-Received: by 2002:a17:902:c602:b0:2c0:a555:80d6 with SMTP id d9443c01a7336-2c163a14eb7mr29911955ad.2.1780511960422;
        Wed, 03 Jun 2026 11:39:20 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649c01asm32764915ad.74.2026.06.03.11.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:39:19 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: amit@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [PATCH v3 3/4] virtio_console: fix control queue race during restore
Date: Thu,  4 Jun 2026 03:37:56 +0900
Message-Id: <20260603183757.21587-4-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603183757.21587-1-baver.bae@gmail.com>
References: <20260603183757.21587-1-baver.bae@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sungho Bae <baver.bae@lge.com>

In virtcons_restore(), after virtio_device_ready() sets DRIVER_OK, the
device becomes active. If the control receive queue (c_ivq) is populated
immediately, the host can instantly deliver pending control messages
(e.g., VIRTIO_CONSOLE_PORT_REMOVE).

This triggers the control_work_handler(), which can modify the
portdev->ports list concurrently with the unprotected list_for_each_entry
loop in virtcons_restore(), leading to list corruption or Use-After-Free.

Fix this by deferring the population of the control receive queue
(fill_queue for c_ivq) until after the list iteration is complete. This
ensures the host cannot inject control messages during the vulnerable
window.

Signed-off-by: Sungho Bae <baver.bae@lge.com>
---
 drivers/char/virtio_console.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 589a12261e23..dd31f7069e19 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2164,9 +2164,6 @@ static int virtcons_restore(struct virtio_device *vdev)
 
 	virtio_device_ready(portdev->vdev);
 
-	if (use_multiport(portdev))
-		fill_queue(portdev->c_ivq, &portdev->c_ivq_lock);
-
 	list_for_each_entry(port, &portdev->ports, list) {
 		port->in_vq = portdev->in_vqs[port->id];
 		port->out_vq = portdev->out_vqs[port->id];
@@ -2183,6 +2180,18 @@ static int virtcons_restore(struct virtio_device *vdev)
 		if (port->guest_connected)
 			send_control_msg(port, VIRTIO_CONSOLE_PORT_OPEN, 1);
 	}
+
+	/*
+	 * Populate the control receive queue only after the list iteration
+	 * is complete. If we fill this queue before iterating, the host could
+	 * immediately deliver a VIRTIO_CONSOLE_PORT_REMOVE message.
+	 * This would trigger the control workqueue, which modifies the
+	 * portdev->ports list concurrently with the unprotected loop above,
+	 * leading to a Use-After-Free and list corruption.
+	 */
+	if (use_multiport(portdev))
+		fill_queue(portdev->c_ivq, &portdev->c_ivq_lock);
+
 	return 0;
 }
 #endif
-- 
2.34.1

