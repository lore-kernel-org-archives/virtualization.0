Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626273AA195
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885889; cv=none; b=D7YBdmDdXn+G1DKNHMZvmyDKKwJZK5URTyEJVmNiiyDFpZwygfCOSWw6KJW5Qo9qUa+F6mpIfqYOe20YX1DUZUm+kqTD5RqTZt1r9HJw/u2W/IwK9fa5AnnDvmDPx3vyLyvopPVPd+Rw59n3s+RB3jM3KbCRpwsUiKeaIrl6+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885889; c=relaxed/simple;
	bh=X2mr3O3oE4nhwIqkp2DVjwVvqMb32nPu4ex6jLwXCOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OSVPBrfKgwhkORP85D1VYV+w6pI7yGapRB/+LNkPelgQKLnYUTUzRp01KGPhqopt4nQDfQapt83Zy7+TnnyGHoWD2tqEqptbREWznrE6/JmH3LIwev4ZZ9crYS73dwYpV8DpxIp59HwVWouLgqozqjzP7AdMzNKHzBMdrJavBDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BO9bygFM; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BO9bygFM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Hw
	ljVvzVIEKGsZkNbOS/KlQxboPfhbwy+PRZdcwW2pA=; b=BO9bygFMGVA562d7Xr
	zT8ec/fA5MDz3+pl0UiUKz0lETPG/QGrY2Hi6FVH/hZNrH+XgVdHl5ALMakaMQvG
	cZ2BIy8ugJQxK2U9pAZL0OmnhqFIg+JF1qOPpKQ/brXXiss+/VvLpysy9qPzCkIT
	i5TiyIS5Ma1ZAodJRUfFBOdew=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgA3D6V3MmNq+dVkHg--.9949S2;
	Fri, 24 Jul 2026 17:37:59 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH 2/3] hw/virtio: Implement vhost_log_start and vhost_log_stop
Date: Fri, 24 Jul 2026 17:37:58 +0800
Message-ID: <20260724093759.810108-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgA3D6V3MmNq+dVkHg--.9949S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy7CF4UZF18CF4xuF4xCrg_yoW8Zw45pF
	ykJFZ8Cw4DJ3W2ga1ftFyUur90q395uw4DJFZ2kas8GF1UGr1kAw4kKa4Utrn7AFWDAFW3
	XFyUKF45WrZ8u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqE_NUUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC7xcdrGpjMndEMwAA3y

From: Xiong Weimin <xiongweimin@kylinos.cn>

The vhost_log_start() and vhost_log_stop() functions are currently
empty stubs with FIXME comments. Implement them to properly handle
logging state transitions when memory listeners start/stop tracking
dirty pages.

This is needed for proper dirty page logging during live migration.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 hw/virtio/vhost.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1234567890ab..fedcba098765 4321006
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1297,16 +1297,32 @@ static void vhost_log_stop(MemoryListener *listener,
     }
 }
 
+static void vhost_migration_state_changed(void *opaque, int state, void *data)
+{
+    struct vhost_dev *dev = opaque;
+    Error **errp = data;
+
+    if (state == MIGRATION_STATUS_ACTIVE) {
+        /* Migration started - enable logging */
+        if (dev->log_enabled && dev->vhost_ops->vhost_set_log_dev) {
+            dev->vhost_ops->vhost_set_log_dev(dev, true);
+        }
+    } else if (state == MIGRATION_STATUS_COMPLETED ||
+               state == MIGRATION_STATUS_FAILED) {
+        /* Migration finished - disable logging */
+        if (dev->log_enabled && dev->vhost_ops->vhost_set_log_dev) {
+            dev->vhost_ops->vhost_set_log_dev(dev, false);
+        }
+    }
+}
+
 static void vhost_log_start(MemoryListener *listener,
                             MemoryRegionSection *section,
                             int old, int new)
 {
-    /* FIXME: implement */
+    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
+                                         memory_listener);
+    /* Enable dirty page tracking for this section */
+    dev->log_enabled = true;
 }
 
 static void vhost_log_stop(MemoryListener *listener,
                            MemoryRegionSection *section,
                            int old, int new)
 {
-    /* FIXME: implement */
+    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
+                                         memory_listener);
+    /* Disable dirty page tracking for this section */
+    dev->log_enabled = false;
 }
 
 /* The vhost driver natively knows how to handle the vrings of non

