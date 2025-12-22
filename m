Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A841DF261
	for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766390444; cv=none; b=ryPygwfiOHdlucukcsLRAvZjBOQGsSL/tjRzpg7PNDRalj5TeedYHBE2fj12+z7oazoxp1Q1tkJYUCz9/7arHAYhkvvahKVoKM6yFSIqpRQefBPCGMpk8+QL7+j8S6AHDjJx4D6AiaZg/L/04t9gOOWAHGjxRSzzQiD2xGK7L9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766390444; c=relaxed/simple;
	bh=hzy66bQ/L/zjKccvEoSQgxUDwXkgz71tY1bSVUI/K4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LQsGcBcxpdM5IsS9dLeSB4SIwHMxRlTbaqiE+cxoNEgLagPM3vhVNhFvVOzLZVo74wUf0fCBN4YnHPM/px5hb7cSmFqmTqRvEwRbYnaSxxRmTujYiIF2xSpRBufE7YBsLOt1yxycNzVDG358xrqEScEFfB/Ih/0fUClFwROW+uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A8V8p6zM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dbhE49Tx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A8V8p6zM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dbhE49Tx"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766390441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DzXzDXgcob+pf4L3eGkW5j2N24JMY5n3kv9AZCNBPQc=;
	b=A8V8p6zMYLgnRXYw1C4w43gRQron/HTy+j7VtSKyCHDgTheBUvr1TI3dMybJOzVdUKwqbv
	x0Rf2dVayRpuhTQCxoxQh6KWkqBouQl80L4l1e5BWuQn3BCQLCzTMDg79wbthix/YWAcN3
	1xWwDv3SMa91WEFr7mkRLIlZ1mayVsYxWiU3DR2iomCKWIFHM8nFIPnVDiTXrBfl/6B/gR
	rrIxvmyXOpZG1WCx7SNTKidmENWt0E6J9qBES2RJRhf5wrVhySxe2BsvCfZuo6WF+LkO8C
	hbXwJD9HoIKlk0jTqgbCQAdVXfyC/GZyVEvyfINN5Cv/iu11c0cZevG+XK44EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766390441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DzXzDXgcob+pf4L3eGkW5j2N24JMY5n3kv9AZCNBPQc=;
	b=dbhE49TxeM7mXpYv/2gHAiMmkdO046tJS7Fc8YPXrO3Dq13AvUvxcB0MhKZ8GLRASId2Xv
	4vp2AOk5vGxBMQDQ==
Date: Mon, 22 Dec 2025 09:00:33 +0100
Subject: [PATCH] virtio: uapi: avoid usage of libc types
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251222-uapi-virtio-v1-1-29390f87bcad@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAKD6SGkC/x3MQQqAIBBA0avErBN0QKiuEi1Mp5qNipYE4t2Tl
 m/xf4VMiSnDMlRIVDhz8B1qHMBexp8k2HUDStQKEcVjIovC6eYgHMppn5W2RjnoRUx08Pvf1q2
 1D1I1bDRdAAAA
X-Change-ID: 20251222-uapi-virtio-d208b915ca1d
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766390435; l=1401;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=hzy66bQ/L/zjKccvEoSQgxUDwXkgz71tY1bSVUI/K4Q=;
 b=iSvSBGMhGTayIiwrXsRAaHFxyR0Xoi2713u5Jnhoo75UOS6vM792b8wQwmzxaB7/YI9W5uI+c
 UIvbrbJ1Ye2C1gEM/eByN46lPdbpo8hMhT8gHKK8znzjaYOPSbNykpP
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Using libc types and headers from the UAPI headers is problematic as it
introduces a dependency on a full C toolchain.

On Linux 'unsigned long' works as a replacement for 'uintptr_t' and does
not depend on libc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/linux/virtio_ring.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index f8c20d3de8da..3c478582a3c2 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -31,9 +31,6 @@
  * SUCH DAMAGE.
  *
  * Copyright Rusty Russell IBM Corporation 2007. */
-#ifndef __KERNEL__
-#include <stdint.h>
-#endif
 #include <linux/types.h>
 #include <linux/virtio_types.h>
 
@@ -202,7 +199,7 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
 	vr->num = num;
 	vr->desc = p;
 	vr->avail = (struct vring_avail *)((char *)p + num * sizeof(struct vring_desc));
-	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
+	vr->used = (void *)(((unsigned long)&vr->avail->ring[num] + sizeof(__virtio16)
 		+ align-1) & ~(align - 1));
 }
 

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251222-uapi-virtio-d208b915ca1d

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

