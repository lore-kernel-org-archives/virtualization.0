Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2F6248F5C
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 03:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766547884; cv=none; b=OwRu1mY6W0r7Um+diaHkPVuIKTA0apm1coK7KhotiqzWlxIudbR6tmzvdYU4/dUY/LJHDiSC6sdzyescKKwIE9Abh+HOl9RMKP3SAcAe8/U3cP01o31SgaRaYskXeA3cWk+e66og0CKxjWOFQjV6WWDWozqjUfrvA8MCNObg7Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766547884; c=relaxed/simple;
	bh=fTWxo+poNduOUg0IjnFiktP33OycMuTZ5yCyD17HpXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SUwxFEd33EQ42EArgE2nTzSHLhQ7A+cSzlxp7OjeDMeY24+CneJSb3Sp55IBgKgj/IHKFwoL9B4XQgfOwK6iM8nJ7uLlzxtt09re9W1dOVNmv+4fTZwkCkQ4W+YG+XOLVZ5wsiE9qYI+CEYSbpgZU3tqXVDqaVaoJJrnZq+wSSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7Igd2iz; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7Igd2iz"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7355f6ef12so1043367266b.3
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 19:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766547881; x=1767152681; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iqClP1J3Blj4kNw4f75McA5KSMvq9OaxJjrHWGLacHo=;
        b=Z7Igd2izniqN4PydQAGxkhcwA4xZhquBsx6E7PMlcIjbaitG0i644zLCYP1pVi0VkR
         H5KciUDCge3QFrRoY7rtPNetStf1M1tyDiYumnAdWemcvIo5HZJICUbW+rj921xoNKMV
         X3lbYNH8yhgkMZCJ0kK7ZqqKNzTfBrZZMtX+6pteTmvE/tbXv8RAiAplArIpwKCPggyI
         9u9o8mIgQxebvltVxRAEy9xu4nYSGszCzVUnjw1N4HFRd1NTYq4vzvvdGmRC00q4rH/c
         QUct0EJZkCEubkm8k1REyXxUgbQKSGAMakhdG8rR1x5Ztze1gKW5IHHfJPhNl91pFy4c
         Sf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766547881; x=1767152681;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqClP1J3Blj4kNw4f75McA5KSMvq9OaxJjrHWGLacHo=;
        b=nczj3uFcOI/KPJGsnrYsBk/Gm7VFlhmsarIPzARKI+NjG9NvDp2R5+7breIPoEGOkX
         sxyLxTxzpMW660JCv+YvI4cRSbMuhQxZg3jLu9lwb6q8UL3hec6t8E9Wfa7NQ6ren4fC
         tMEAVoKCDGANKhlvRH7IvC4G1GzU34bghqkxr+FbXdaQXzO8CWF90m94Q0SEDzAlXq6K
         klXfWMrX5Ii5nxeGWZY7sEtHQIkLMLhAtOtXTcxzIfw6Il2Cz/eyhEigZMcB3/G/Ys6A
         UfVn1p8NaALOHIhZaPepAr3CrqYWmmMzN7bcNkFxcxHgawMtEYandyEByv+vrDq3w5B9
         NTkg==
X-Gm-Message-State: AOJu0Yy56WaQBgZTv3pgzVbcU2vpr0CLn9WSkgAY+jg5jjRUCv8YMfMG
	CIMDDsDL31nDIbGGer1UC0vizStYWPPso1BU1nml8bQW2lJIUAVvu40C
X-Gm-Gg: AY/fxX7esNu/OQbGkMC5bwbgQuOM7Wz3N9boKfvyFcBkSMP52lRshJiHnIwtbeKcaN0
	1/Itqv72DVNPbiJeYyay5ZwWDc3w0nTE+EkkXqvLZ4kDWEJR3L7K8/FQnextKn42EsA+naLwvip
	e4xdxarhqjembk3fVx6vL8/EFXt5gQq8ATlvuCjZCRarYiTCmzaTgkxGw9vq8nplgpb/RpL62zL
	YX/mDPrg+zgMhg6F4vt8tVx1y4V8CKhCsPcembcjTUMVXwj049hlTTLgqU016Hf1oqLXQ3eJvVO
	5JXtnXvEYa53f0izbelBjfVAlbuzk0re3RDE/mN82kwTJG6TlEyPUC9C0axE1W7z3gkKOW/VU33
	ZMWr4RRBip7HnMYmZhhmcyIxjcrihkt/ZItmM5d6Pz3adZIHamLZ5YzkAd0IsWSwn83gmcAI1ww
	+Q6UFRQnppO63AwIiOeHehbRWaVK/QdrlRmXsc4zHi
X-Google-Smtp-Source: AGHT+IFtFPTf8Y7FfhjP3jw+d9+0TUQIjezaoa1JRTlwOhq0qKOO5sF3sFUhRJYY5TqEtoAzV4yXYw==
X-Received: by 2002:a17:907:3e8c:b0:b72:5d08:486c with SMTP id a640c23a62f3a-b8036f5a0cdmr1911426666b.27.1766547881122;
        Tue, 23 Dec 2025 19:44:41 -0800 (PST)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0b12dsm1621963966b.48.2025.12.23.19.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 19:44:40 -0800 (PST)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Wed, 24 Dec 2025 04:44:06 +0100
Subject: [PATCH] virtio_console: read size from config space during device
 init
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251224-virtio-console-fix-v1-1-69d0349692dc@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIVhS2kC/x2MQQqAMAzAviI9W9C5ifoV8SCz04Js0ooI4t8dH
 hNIHlASJoWheEDoYuUUM9RlAX6b40rIS2YwlXG1MRYvlpMT+hQ17YSBb2wW2/ZdRcG1PeTwEMr
 6n47T+35/fsk1ZAAAAA==
X-Change-ID: 20251224-virtio-console-fix-3d46980ef569
To: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766547879; l=3793;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=fTWxo+poNduOUg0IjnFiktP33OycMuTZ5yCyD17HpXc=;
 b=Gy38c1nLgv7mAfyfZdz7Ho1GUKBy/xnez7CbXH71d8vtKp9i0ikf6l6rYkWkosA4HQ6eHK3AJ
 4/B/ys2DkRSBrWObSAUnFUHXqGpEHYymLPlilbJdIpCqbEDE6jYnddr
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=

Previously, the size was only read upon receiving the config interrupt.
This interrupt is sent when the size changes. However, we also need to
read the initial size.

Also make sure to only read the size from config if F_SIZE is enabled.

Fixes: 9778829cffd4 ("virtio: console: Store each console's size in the console structure")
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
I found this bug while developing patches for QEMU that add virtio
console resize support. If you want to test this, you can get my QEMU
patches from [1]. You will need to disable multiport
using `-device virtio-serial,max_ports=1`.

[1]: https://lore.kernel.org/all/20250921-console-resize-v5-0-89e3c6727060@gmail.com/

As an aside, when I was trying to understand the kernel resizing code,
I noticed two things which didn't make sense to me:

  - Why does use_multiport use __virtio_test_bit instead of
    virtio_has_feature?

  - The VIRTIO_CONSOLE_RESIZE handler sets irq_requested to 1, which I
    think makes no sense?
---
 drivers/char/virtio_console.c | 52 ++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 088182e54deb..c355f6d39274 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1771,32 +1771,40 @@ static void config_intr(struct virtio_device *vdev)
 		schedule_work(&portdev->config_work);
 }
 
-static void config_work_handler(struct work_struct *work)
+static void update_size_from_config(struct ports_device *portdev)
 {
-	struct ports_device *portdev;
+	struct virtio_device *vdev;
+	struct port *port;
+	u16 rows, cols;
 
-	portdev = container_of(work, struct ports_device, config_work);
-	if (!use_multiport(portdev)) {
-		struct virtio_device *vdev;
-		struct port *port;
-		u16 rows, cols;
+	vdev = portdev->vdev;
 
-		vdev = portdev->vdev;
-		virtio_cread(vdev, struct virtio_console_config, cols, &cols);
-		virtio_cread(vdev, struct virtio_console_config, rows, &rows);
+	/*
+	 * We'll use this way of resizing only for legacy support.
+	 * For multiport devices, use control messages to indicate
+	 * console size changes so that it can be done per-port.
+	 *
+	 * Don't test F_SIZE at all if we're rproc: not a valid feature.
+	 */
+	if (is_rproc_serial(vdev) ||
+	    use_multiport(portdev) ||
+	    !virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
+		return;
 
-		port = find_port_by_id(portdev, 0);
-		set_console_size(port, rows, cols);
+	virtio_cread(vdev, struct virtio_console_config, cols, &cols);
+	virtio_cread(vdev, struct virtio_console_config, rows, &rows);
 
-		/*
-		 * We'll use this way of resizing only for legacy
-		 * support.  For newer userspace
-		 * (VIRTIO_CONSOLE_F_MULTPORT+), use control messages
-		 * to indicate console size changes so that it can be
-		 * done per-port.
-		 */
-		resize_console(port);
-	}
+	port = find_port_by_id(portdev, 0);
+	set_console_size(port, rows, cols);
+	resize_console(port);
+}
+
+static void config_work_handler(struct work_struct *work)
+{
+	struct ports_device *portdev;
+
+	portdev = container_of(work, struct ports_device, config_work);
+	update_size_from_config(portdev);
 }
 
 static int init_vqs(struct ports_device *portdev)
@@ -2054,6 +2062,8 @@ static int virtcons_probe(struct virtio_device *vdev)
 	__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
 			   VIRTIO_CONSOLE_DEVICE_READY, 1);
 
+	update_size_from_config(portdev);
+
 	return 0;
 
 free_chrdev:

---
base-commit: b927546677c876e26eba308550207c2ddf812a43
change-id: 20251224-virtio-console-fix-3d46980ef569

Best regards,
-- 
Filip Hejsek <filip.hejsek@gmail.com>

