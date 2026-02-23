Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F0F330B2D
	for <virtualization@lists.linux.dev>; Mon, 23 Feb 2026 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868258; cv=none; b=TCwL+R+4x6IJd+6+hXiKGgStqEg9UhWjr7gUTRLP6/ahqhO7hqxPOKi2+50tK/vZEV/ecZ8uYMrtj+YKuci9dEBb8+dARvxYL9v75ZqpNUJDkNaoVCBHOiEiHcXj4JMXdEhVHAOOFx9NL3qR1M/Pldz7GieySkhvLVUihy1SxEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868258; c=relaxed/simple;
	bh=bNE1C/ycXlu3DoYv5hPAJ1NqqZt7vvoqqFWzSQqVdcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o5gUJ1SSgoB6Qxpt/Ml5l5Bfw0gEaHC+HC15YZb/aVykbXMdtTYoHrGsKxoaTobxv64M1xIBV2NTpgoDNfH0m+gvANVYSu1xN2ySqkeE3pXgJpIe5vwP11aU9JwPMGHxKE4rk1XN8FhKUJF3nNoOVHkXqWC3qHaO+SK9sxkXh1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0eUKT1o; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0eUKT1o"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4837907f535so41510835e9.3
        for <virtualization@lists.linux.dev>; Mon, 23 Feb 2026 09:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771868255; x=1772473055; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aqudQbT7/MPE0BjTOSVNKoEUnhB2WCPkvdNMz5SxcQI=;
        b=C0eUKT1o/+9CO3lokzbq1kvYCuL1RMK2n5wmPhWHGm+z/15s738nBm5enWDLNVlzq/
         m1lKJPBONN/u2ILNHxRMEJ/LOhYilRLAXMNP6NMGFlPJw+C/D2pA/XSSIcXzq9xeD6ik
         6fYpMcQMz1KqERCnRBatjSjp0sZBOusVxGLralBxvo4VfGcVyxIHgsW659ml4bi/QGxW
         g98M7B8tc94jKmrqPsKMoT4rRvJvj+oet5SCHbpGjivYATZ7PEdL/yMi8ZQA5mwfJoZ/
         JlXWcMfqR86QARHDajjesJLV6ysCJTzqinvZuBRWTDFZ6byMmH3kXscMzBgXg5v/k9TW
         KEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771868255; x=1772473055;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqudQbT7/MPE0BjTOSVNKoEUnhB2WCPkvdNMz5SxcQI=;
        b=OaJ5BJz6zsoN510E6a8xbpVlUdEPp7K8rXX+aJmkIIoihb8Wqt3DKLiZvEYS9hp+L1
         c5gQRLeHXUjpyJV9Of69/jo9y3jSWHxK1Wb+O3taCl2z3wZ1qJZ9JwtY6O/QZAAC4+Kt
         MJu33mObxcnCMoGwqRqrVFuUBZHzOpIJKfa48yFolkQB/frf0uS6kC/XlGDfds6Sh38t
         ZC6GY5UxiysoeBwqaYdO2xY+GtVT313fIMxeR0GbleTrn49Hhlu2ZoNLspbtKJ635psM
         ERzvr1Y/5FCToaEKZWxctZdwvNnLSwYr4uehrDcewfyq/hqdK8LN+/N8nS0RjD1WhAoK
         9nsw==
X-Forwarded-Encrypted: i=1; AJvYcCXeUuAv4KeGjEPDxtnIuUCZqx+peNfUUcup+NIi+0fRTqTCStCGtlIaD8bh/XXCwH+mjb3KgcM2YYSNnSmghw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNM4FAIzc6UwL00+EM04rBYO+rvKolrpNwAPMrfhVje0X4ArPy
	pfGmOR3YaXQUcN5RUJmFbeChW2yVWXUIN9maquqf98f+9VvP3sPTKahA
X-Gm-Gg: AZuq6aKujPK0CJeHLEyHmhxLwPpiyrR891SQBad3TG4M60MAIoWh6oSggeZKXnzfBmb
	FjQRk7RZ+9p9ZSJUWmePRDiPoWMmiMBgAJWEJqej2eDYb1Qbcg8njZS6KX/imWJfi9B0znv63ra
	ROmujeTPm5pqtCFdQ2nFs3xSz5vIk8jwplnaXipXhlPi1ERP2Q9rqf+73cFvFShKVy78++OBPg5
	bF4ysZ6TuBvGlhvjIv/6y3rvYmQA7omw6cDr85T0r9X6jiRbDcn7DuHTMACQ9xvS1s14ycgbXAY
	/nV/9+NhFvKnJVV1t2Hg/dmeQ0rGtzeLt2uqedbaIG4y5z1qB/8vmrNdN2oMdZqYDK+mVhPix2/
	CFdIfdZKhIgV3GaPBWWoo4NDnojrj/SeiUvK5uhElY4J1kealU3EAl5z6BA/xByD6ClyOvLkBaX
	ua7msZE7SEafRNU+Wnqzb7+A==
X-Received: by 2002:a05:600c:1c04:b0:480:1b65:b741 with SMTP id 5b1f17b1804b1-483a95cfc62mr177427845e9.15.1771868254679;
        Mon, 23 Feb 2026 09:37:34 -0800 (PST)
Received: from localhost ([89.150.43.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3ff27sm22403922f8f.22.2026.02.23.09.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:37:34 -0800 (PST)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 23 Feb 2026 18:37:02 +0100
Subject: [PATCH RESEND] virtio_console: read size from config space during
 device init
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-virtio-console-fix-v1-1-0cf08303b428@gmail.com>
To: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771868253; l=4024;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=bNE1C/ycXlu3DoYv5hPAJ1NqqZt7vvoqqFWzSQqVdcM=;
 b=lp8kdQlCCgnQtMa8C7vRgUSI7TnDds3ZVs1AdbQIEpUq7q8dq5pICepK/m8EZrIJcX+yltyxE
 qtFxaw1slVjDu0yGmY4YkfAYnKKgKX5mpzIzt4fYvV2AlYITn7VdZWx
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=

Previously, the size was only read upon receiving the config interrupt.
This interrupt is sent when the size changes. However, we also need to
read the initial size.

Also make sure to only read the size from config if F_SIZE is enabled.

Fixes: 9778829cffd4 ("virtio: console: Store each console's size in the console structure")
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
This is a resend of [1], which hasn't received any response.

I found this bug while developing patches for QEMU that add virtio
console resize support. If you want to test this, you can get my QEMU
patches from [2]. You will need to disable multiport
using `-device virtio-serial,max_ports=1`.

[1]: https://lore.kernel.org/all/20251224-virtio-console-fix-v1-1-69d0349692dc@gmail.com/
[2]: https://lore.kernel.org/all/20250921-console-resize-v5-0-89e3c6727060@gmail.com/

I'll also repeat my questions from the previous submission here. These are
things that confused me when I was trying to understand the surrounding code,
but should in no way prevent merging this patch.

  - Why does use_multiport use __virtio_test_bit instead of
    virtio_has_feature?

  - The VIRTIO_CONSOLE_RESIZE handler sets irq_requested to 1, which I
    think makes no sense?
---
 drivers/char/virtio_console.c | 52 ++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 088182e54d..c355f6d392 100644
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

