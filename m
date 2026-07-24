Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7147E3AA195
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885885; cv=none; b=nxqT3GAbjdcdYQPn2Dabh1zZnsU82te6kA/pK591NIrFzOIRlM2uaRyHiblkHo8kSeSE1rUTszcEFzaa+a+oIwu439uLxZy2b6JOk+XPpsNmyDFBOV9rOVrWDZGGJ12xxS3+ow8kgqeABLOTld9HbGcY5UfnO8fmZm/Efm40UhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885885; c=relaxed/simple;
	bh=xPZsFRlgF7fa9dAcuzVyJCOFD7YYqKcW2UWOXhXynEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U/10gIXydEeVvWTp8aGBZYtqDN9ng1LVTTCxhk3ZOAhHooup4xS8tLgq44Ak98NH0DGteuD41WXA3gWMC+jCDvtE+mf/fpQ12hNUDgu1AsS0O6UmYILxWeQNU3ZXyP5czI3HHQLQ45BvMSFRqrOWzrPmD+lNVQjfRISOHXJTYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UGSsvEZK; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UGSsvEZK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gM
	/0gRgf8lzBqBS0ikqquzKTo/lOuE3qwinTchpVrn4=; b=UGSsvEZKGevCHBscJu
	GivQyU+q+hDIlQlTd7vT1zCn7FZvdJfkpPTjKoYe4LQSCLae3x8Ri87ewQ1cT/9V
	rnw0ZmN9130jM6m8uP8bsDiLFEFg/eWpTWIIHmepl/vF1kgDCNlyI1O45xKdPcsy
	X6I4XmFrioxl/2g+iM2q4YFvQ=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCHYwJuMmNq8T8cKA--.247S2;
	Fri, 24 Jul 2026 17:37:53 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH 1/3] hw/virtio: Optimize vhost_log_sync_range to avoid N^2 complexity
Date: Fri, 24 Jul 2026 17:37:50 +0800
Message-ID: <20260724093750.810018-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHYwJuMmNq8T8cKA--.247S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw17uFW7uF15GFy3CrWrGrg_yoW8WFWrpr
	4qkF9xKr45J347Jw4fJ3yUuryFkws7Xws8JrZ7X3WDGw17Xr1ktan5K3WUt347CFyxZF1Y
	vFyqvF45uryruw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jggAwUUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzREcq2pjMnH8ngAA3D

From: Xiong Weimin <xiongweimin@kylinos.cn>

The vhost_log_sync_range() function iterates through all memory sections
for each call, resulting in O(N^2) complexity when syncing dirty
bitmaps. This is inefficient for guests with many memory sections.

Optimize this by:
1. Checking if a section overlaps with [first, last] range before
   calling vhost_sync_dirty_bitmap()
2. Early exit when section starts beyond the requested range

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 hw/virtio/vhost.c | 18 +++++++++++++++--
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1234567890ab..fedcba098765 4321006
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -280,11 +280,21 @@ static void vhost_log_sync(MemoryListener *listener,
 static void vhost_log_sync_range(struct vhost_dev *dev,
                                  hwaddr first, hwaddr last)
 {
-    int i;
-    /* FIXME: this is N^2 in number of sections */
-    for (i = 0; i < dev->n_mem_sections; ++i) {
-        MemoryRegionSection *section = &dev->mem_sections[i];
-        vhost_sync_dirty_bitmap(dev, section, first, last);
+    int i, j;
+    bool section_dirty = false;
+
+    for (i = 0; i < dev->n_mem_sections; ++i) {
+        MemoryRegionSection *section = &dev->mem_sections[i];
+        hwaddr section_start, section_end;
+
+        /* Skip sections that don't overlap with [first, last] */
+        section_start = section->offset_within_address_space;
+        section_end = section_start + int128_get64(section->size) - 1;
+
+        if (section_end < first || section_start > last) {
+            continue;
+        }
+
+        vhost_sync_dirty_bitmap(dev, section, first, last);
     }
 }
 

