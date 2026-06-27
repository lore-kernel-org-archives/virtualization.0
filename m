Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246D33955D3
	for <virtualization@lists.linux.dev>; Sat, 27 Jun 2026 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782557738; cv=none; b=PEY089ZCFFb7XeXkw0xt0Sl05CuEHVT2toOceuuUYPj9V0iiApzahzZhO1So4GfjFPf1dOZEX76bPLPe7DE3XhcWcc3RBIhBJsryXTisC8oKq994tJa0PFNpEbTcesoeitF29QKc3Nl3lrDBmqYuZSXInrbRprJ3MtXRiZtrgZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782557738; c=relaxed/simple;
	bh=kVL1u7e2q+LOcCuGSRh3tx166iySQpDeLE0uWIsPFx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VtTUbsJt09/ujoz8UWmG+r+f0lXXgQ+JnL6kL0v9Ni25hCXN+XNqyw3rZXQQpGIdRxcBpqKL9FzXp6HGrM+lDU/QJmwe1mthkN+gSBAxUDDmdsoY76XY1dP4p+ba2g+0UcIQqkX9mFXaKto9Hw9eeLen9doKnxrM5MMgBMER5gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCgzAzrV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCgzAzrV"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4923139e940so10169935e9.3
        for <virtualization@lists.linux.dev>; Sat, 27 Jun 2026 03:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782557735; x=1783162535; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DLzuYgF/9ZgCU+ncM87SrlvZIAMdu0dBEfSPlmMNg6E=;
        b=ZCgzAzrV8bwczhaMGEqj9SOWST9hGrncWVrfumHOhJ5lc5ywyWegdYQAEb84846CX0
         rYgZjXuQA9HZ40EdaBK4bEVB5i3HvidvRCaY3QcoB78mMv891iA1qq7rZ6/ij5uoMy9v
         uXnZOF12T/NceZ2FWd+h4G+aFjAHJHOPsdrR4IVbW0weQ958DBj0kcAI4YiCeEUJGnew
         ygV0Pqns6wI1c1QT7w0h7u/n8vKizR+buBOtH0Y1VSJ0jY4gWd1hf0VwupnoxGmJCSKF
         Kk++rJ4DodFysAKmQ4Q+D2L1Sz4iCQlgXCXUs2PUvOBYHl9a/2V9T+kc5a6WNLNyeSNC
         Mttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782557735; x=1783162535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLzuYgF/9ZgCU+ncM87SrlvZIAMdu0dBEfSPlmMNg6E=;
        b=c67l0Q/xMA03T+3rA9xW2Vzqwg9iRNE6XGgZFVdL6V9k6MmJ62GNEvh1xXcvgp0RnQ
         bn95bi1sOJVAJNpazRVbPRbgENFPkbLYNhV+jlUuzYpO6jse4mqPe8j7Iuft7wY/I4hT
         tTy4bRM8Zun4DjgYpiGAlxQb+Bgdpm3hgA9rk7kFS8pGYQxwIlJwNsgDGWUcmMxpF8P2
         /0sCc8MqdF9D22WhJPIwGDiRswgFBUHTS9nF1BFrc0Jeh9xSTHPBFifave4EDJEswfm1
         1z4keXTzrf2ho9HnAB7c5OH6HnGUAWROKonwq6UEctx96XnA6PDwbLg8VqGSgw+lndV+
         xIuA==
X-Forwarded-Encrypted: i=1; AFNElJ8PO8+z6ixRlhi4+oBF4bcf2iLnQME1VvGuHKRXsENXIF9uxAZ3FaOwVllBNOnv+kksLSK4+sWbFoCSjYmbbw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFRaCgpR0kSPZ4XcN+CeNOTsTcriGTuj/u6quKqN+KutsYzxE5
	vpKWshZ1elbsfOo5GVArdWrN1G//JmCjTsymZuEhIrzCNIZ1sug5hwGQ
X-Gm-Gg: AfdE7ck7iQbA5uni/QVsXYA4WqhR0NutJEAXq4mhF0aHx9GJ/L+huIz9pZLQdbgxcTq
	qIzfbrL+TVodPk5pVxj25G6Kw5psW2EivguxUvXhK45JaDP/nPHeCQz0okk3SWu6ynfCC2coxUq
	uD5sNNIqmK0/xi/XJEV9sMSMNzf1jgH/KanOBunaN+d9mimjTJjDC7ceqN46Kf/FrLQKY1+v9vu
	ZO41TSYakf+xLIw2MGdkdFYioSTe/YIw6eAnOaoR2bNbbw5XMwla360JI/gtrXdLMcBoJyvhgit
	cyuWEMLyZPN6a5NYrwAG9A/j4nqjRJmxqIQQqblvKCbIk8Er2ksRUMoY8sOmMPQmW4A7mPuVdTG
	qoCc/8RMKpqg3rbVNsn79JxK5gxR/26DX/3moCBoXrT4+J+DnfHORS4VXLZ6OGXcC0XbnOZAT9t
	5YwMT4Q0kaKMq0if9G1TfI+hVpFKCCJDtpg+cwzzvcBRS6dsAox+Vm5FDp8zqqAmYM2SqPuvcPJ
	wx4
X-Received: by 2002:a05:600c:3492:b0:492:39b6:5a30 with SMTP id 5b1f17b1804b1-4926719847bmr135969575e9.35.1782557735296;
        Sat, 27 Jun 2026 03:55:35 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2 (212.pool95-21-2.static.orange.es. [95.21.2.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690168d5sm208127095e9.14.2026.06.27.03.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 03:55:34 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	linux-kernel-mentees@lists.linux.dev,
	=?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
Subject: [PATCH v2] drm/qxl: fix use-after-free in qxl_irq_handler on PCI
Date: Sat, 27 Jun 2026 12:54:46 +0200
Message-ID: <20260627105445.89827-2-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

while :; do
    echo [pci qxl id] > /sys/bus/pci/drivers/qxl/unbind
    echo [pci qxl id] > /sys/bus/pci/drivers/qxl/bind
done

After a few seconds, it reports:

==================================================================
BUG: KASAN: slab-use-after-free in qxl_irq_handler+0x269/0x2b0
Read of size 8 at addr ffff888001c6cd48 by task swapper/0/0

CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
     7.1.0-10963-g1a3746ccbb0a #31 PREEMPT(lazy)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
               BIOS Arch Linux 1.17.0-2-2 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl+0x4d/0x70
 print_report+0x14b/0x4b0
 ? __pfx__raw_spin_lock_irqsave+0x10/0x10
 ? profile_tick+0x56/0x90
 ? tick_nohz_handler+0x23c/0x5c0
 kasan_report+0x117/0x140
 ? qxl_irq_handler+0x269/0x2b0
 ? qxl_irq_handler+0x269/0x2b0
 ? __pfx_qxl_irq_handler+0x10/0x10
 qxl_irq_handler+0x269/0x2b0
 ? __pfx_qxl_irq_handler+0x10/0x10
 ? __pfx_qxl_irq_handler+0x10/0x10
 __handle_irq_event_percpu+0x116/0x450
 ? __pfx__raw_spin_lock+0x10/0x10
 handle_irq_event+0xa6/0x1c0
 handle_fasteoi_irq+0x271/0xb10
 ? __pfx_handle_fasteoi_irq+0x10/0x10
 __common_interrupt+0x60/0x130
 common_interrupt+0x7a/0x90
 </IRQ>
 <TASK>
  asm_common_interrupt+0x26/0x40
 RIP: 0010:pv_native_safe_halt+0xf/0x20
 Code: 42 de 00 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90
       90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d a3 cf 20 00
       fb f4 <c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90
       90 90 90 90 90
 RSP: 0018:ffffffffb8207e48 EFLAGS: 00000206
 RAX: ffff8880b296f000 RBX: ffffffffb82146c0 RCX: 0000000000000001
 RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000067a04
 RBP: fffffbfff70428d8 R08: ffffffffb7247e1d R09: 1ffff1100d846202
 R10: ffffed100d846203 R11: ffffed100d846203 R12: 0000000000000000
 R13: 0000000000000000 R14: 1ffffffff7040fcd R15: dffffc0000000000
  ? ct_kernel_exit.constprop.0+0x9d/0xc0
  default_idle+0x9/0x10
o  default_idle_call+0x37/0x60
  do_idle+0x3a8/0x5d0
  ? __pfx___schedule+0x10/0x10
  ? __pfx_do_idle+0x10/0x10
  cpu_startup_entry+0x4e/0x60
  rest_init+0x11a/0x120
  start_kernel+0x382/0x390
  x86_64_start_reservations+0x24/0x30
  x86_64_start_kernel+0xd6/0xe0
  common_startup_64+0x13e/0x158
  </TASK>

The qxl_pci_remove() function does not call free_irq(), allowing the IRQ
handler to fire after the device has been torn down, accessing freed
memory (qdev->ram_header, qdev->io_base).

I followed these steps to unload driver at link.

Added Disable the device from generating IRQs, Release the IRQ (free_irq())
at the start of qxl_pci_remove() to ensure no IRQs fire
after teardown begins.

Added at end Disable the device.

Fix: Added goto fini in ttm_device_fini() on error.
Bug: qxl_ttm_init never calls ttm_device_fini on failure
If qxl_ttm_init_mem_type() fails after ttm_device_init() succeeded,
ttm_glob_use_count stays incremented. All subsequent bind/unbind cycles
see refcount > 0 and skip ttm_pool_mgr_{init,fini}() entirely.
The global pool types are never finalized, and the list_lru_destroy fix
in ttm_pool_mgr_fini never runs.

Assisted-by: OpenCode:1.17.8-Big Pickle
Fixes: 48bd85808443 ("drm/qxl: Convert to Linux IRQ interfaces")
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
Link: https://www.kernel.org/doc/html/latest/PCI/pci.html
---
 drivers/gpu/drm/qxl/qxl_drv.c | 7 +++++++
 drivers/gpu/drm/qxl/qxl_ttm.c | 8 ++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 1e6a2392d7c6..1613547c1856 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -154,12 +154,19 @@ static void
 qxl_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct qxl_device *qdev = to_qxl(dev);
+
+	qdev->ram_header->int_mask = 0;
+	outb(0, qdev->io_base + QXL_IO_UPDATE_IRQ);
+	free_irq(pdev->irq, dev);
+	cancel_work_sync(&qdev->client_monitors_config_work);
 
 	drm_kms_helper_poll_fini(dev);
 	drm_dev_unregister(dev);
 	drm_atomic_helper_shutdown(dev);
 	if (pci_is_vga(pdev) && pdev->revision < 5)
 		vga_put(pdev, VGA_RSRC_LEGACY_IO);
+	pci_disable_device(pdev);
 }
 
 static void
diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 5d495c4798a3..bdcc7560f3f1 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -207,13 +207,13 @@ int qxl_ttm_init(struct qxl_device *qdev)
 	r = qxl_ttm_init_mem_type(qdev, TTM_PL_VRAM, num_io_pages);
 	if (r) {
 		DRM_ERROR("Failed initializing VRAM heap.\n");
-		return r;
+		goto fini;
 	}
 	r = qxl_ttm_init_mem_type(qdev, TTM_PL_PRIV,
 				  qdev->surfaceram_size / PAGE_SIZE);
 	if (r) {
 		DRM_ERROR("Failed initializing Surfaces heap.\n");
-		return r;
+		goto fini;
 	}
 	DRM_INFO("qxl: %uM of VRAM memory size\n",
 		 (unsigned int)qdev->vram_size / (1024 * 1024));
@@ -222,6 +222,10 @@ int qxl_ttm_init(struct qxl_device *qdev)
 	DRM_INFO("qxl: %uM of Surface memory size\n",
 		 (unsigned int)qdev->surfaceram_size / (1024 * 1024));
 	return 0;
+
+fini:
+	ttm_device_fini(&qdev->mman.bdev);
+	return r;
 }
 
 void qxl_ttm_fini(struct qxl_device *qdev)
-- 
2.54.0

