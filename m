Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D783D3C10B8
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945622; cv=none; b=t9OlNAdDCY57UHxHIjGlAqf8zISR18mlyxgXVIsBAN1tdY1Q8k6ilnPxp55ezW5idVP45nxtseXVb2QnSMuA1jQvD21rHd3UyPDMynatFqVd6KdSID5xA1Ypg1N9rbWiJdyxZgdpFyxGOFlQe3eH566vPajeHQbZUolCQtJuWRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945622; c=relaxed/simple;
	bh=17wZhnhLAU7guGm8/q4zOLDl7pbFe4+c3f/2bu3GWN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j6aWputAariWG00v9/Yv5fWLQRa2/4VytTm7i1AZTFzngWQQkeXHo9KzoA/ECsMro2D7jE1FS9LQRha7JVbWvypOlZou6cOJGbWzfl9J+hmrjf5nqeulhvO21cb9rqfY9uHonPlkZZn9YfVvYKJ1cthDCatjwMh+LtXmzslZwMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gpSP3KSu; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gpSP3KSu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vW
	YKKm5eNGnLOyXewuA7MvTMu4RVLzS9R0S5754CSLY=; b=gpSP3KSuyWVd2Xg7Q1
	QgEEUFT2/+/WWpY29FCmp3vf0gFp8XZ4iEmL+E5mP8rAtpvd8YB0K4fVVWon97nf
	gbQI+maekO2X2k2eFUizUV+svahgfFLbtbJRZLF/HM4AHs8tZhZRYZWTjwp7t53f
	z3LqTZVFCjcqgxLqG6acuBf2U=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3V83AJKFqD5K4Bg--.63870S2;
	Wed, 09 Sep 2026 17:20:02 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	eperezma@redhat.com,
	jasowangio@gmail.com
Cc: xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	tanglongjun@kylinos.cn
Subject: [PATCH] tools/virtio: add missing device-id/virtio.h wrapper header
Date: Wed,  9 Sep 2026 17:20:00 +0800
Message-Id: <20260909092000.107827-1-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3V83AJKFqD5K4Bg--.63870S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurWxAry8Xw13tFWkAr1UKFg_yoWkAwbEkr
	1kXwn7Cr1jvFZ2yFWFkr1fXF9xK3WakFZrXrn5Jr18ZayDAw45W3W7A3Wqg3W3Wwnrur43
	WayrXr4kWr4agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbqjgDUUUUU==
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-QI8amqhJMLbjQAA3S

From: Longjun Tang <tanglongjun@kylinos.cn>

Since commit ecca1d63c1ea ("Replace <linux/mod_devicetable.h> by more
specific <linux/device-id/*.h> (headers)"), includes
<linux/device-id/virtio.h> instead of the old <linux/mod_devicetable.h>.
However, tools/virtio/ only had a wrapper for the old mod_devicetable.h,
causing the build to fail with:

    ./../../include/linux/virtio.h:10:10: fatal error: linux/device-id/virtio.h: No such file or directory

Add the missing wrapper header that redirects to
../../include/linux/device-id/virtio.h

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 tools/virtio/linux/device-id/virtio.h | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/virtio/linux/device-id/virtio.h

diff --git a/tools/virtio/linux/device-id/virtio.h b/tools/virtio/linux/device-id/virtio.h
new file mode 100644
index 000000000000..3c3e8c514c8d
--- /dev/null
+++ b/tools/virtio/linux/device-id/virtio.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <../../include/linux/device-id/virtio.h>
-- 
2.51.0

