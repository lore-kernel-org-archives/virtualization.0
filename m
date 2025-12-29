Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE4A30FC21
	for <virtualization@lists.linux.dev>; Mon, 29 Dec 2025 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767045571; cv=none; b=gJvxOFcdm+xayg0nH+5wBMW85hqMdTZzeCCAXOEk3CAx2hBDZVt2z0DYTCaYIODJW9jIXRMvsDc/vlsPU4vCUDIvXlpG6VRMFXhumFTLajALpFA7+qaM/F8F1a39vsOpkj+m90YCjACZNT62mFztqFFnRQ5AZ9CLp1LfvMc4e5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767045571; c=relaxed/simple;
	bh=HLz/pKvZ8fPvlFlHYFg+4MkikJW/YUYjkfO51McHq3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDWt+QW3zYA/XC8Ns2qVFB5vJQDgV/igdQ/FWeyE2MlI87z78IIabiTDtWMzwJ00ITNZxklujcJEqrwpX8vOtnREPQTly+EYO9hNw+x6fieyhm4zyGM9MfZZAEo33cxMUmE8a2Xs4zaEtWd/Y/kC6+m+B3/PUCQVg2q4uv6jORQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XMaxBHFW; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XMaxBHFW"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a1388cdac3so88025485ad.0
        for <virtualization@lists.linux.dev>; Mon, 29 Dec 2025 13:59:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767045569; x=1767650369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=twseZy54c+QB1Kjp/hds53EAQKHotDuR3NVPADpEAm0=;
        b=LysqjKVtR6etH0ayjGKqQeE4IHUFmmuIajh6JXyEDAZz95dZMCrKOInWta+07X9A+J
         GsF1Mm4iqbq8/JtA++zr3X3QAk2lTxxDn7emZKPVPU1UyR5gx6bIfh3voOUtXEDGQ641
         zxlLZDgmKTL9Kx1rwaFK7k6h1v2iXErvDtcTHVNUMSiKcvzcl7peQt5mkX8N/8fbTo9j
         hmXRimPZ4juzy0dVoeQtIQsPNHpaLfuGSdVERxEN2dOn1n0ToAHPR7UjFWLR2aN+8ARR
         p0LkNyikWaf14w/6uTHqEgn73b00i7X4F+IaWILecgyvr/eybEZkV0HcpNhwOl7QYuO2
         cKsw==
X-Forwarded-Encrypted: i=1; AJvYcCW8MdWWhHdTPDIKxA65bGl0APtV/S7TyHCanjBdH3E0As2LQycVw0vYiQQT6o5Xm0t+FnTu202KfJwNMqcPVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVMYyBd4NVNo0I1Ebb+5t0fLITxtsQYWL7SQWNlZnk8peZxIwG
	gqqIjqVtRPgdYOc2T1PQmrXmM7wopMG5dJbgJT4B9S4yIkvMIiPAhGL2tAdBCh4qi0yEoRuWHO8
	Sc6pP0Lga5pRbg1NIQKEoMbVBZhdlD44qiYT7yxPM3YUYRj1BFrUJ3c/QYREQYwnwe1o3VdFJGe
	wbY/BhSodJDLZEcHTCv97Qw91tRmsPhwqJpoyY0BBMlTU6bNC0R6ehjbc2mVah8SgBqperBOPEk
	53jSJSBxvwe0gSsWmI=
X-Gm-Gg: AY/fxX4UkB4jKVP2HcayMEo6/OGMo8O3qtJbvJrkx5TEpGSk84+eIC4jMJhscJeJoGA
	6++d+pxKOzuO2VIqBmrR84CH7W2HRjBtX14izuVDFWXSf1NVU7Dd4dAYjqS8LNJNMazEO/aS9kF
	JswUyx0dCxuAWcAePeU2Fhn50Q/wiNEUgaETDjqyZwMWaqpwR+9Uj1XilLv0fLYJhyL2OrOJ4qh
	hMy183cv9//XuSyoZvZVVwg9ype3SrrKlr6KDMqiMYgwWmTJmuSAAg7LoZHvGtvBtDrw+eAN3h/
	BilmYY/R/rti3ISjVdJKM9BWaXIVCLG6c/EjEAGD8kjk2hHyfJyBduCRLOKItdlmTxbJ3TRDuVl
	z7fVaGNdCSUzlh2VOzYghjG2fBYL5/vlk1jJaKLO1xxUURT98mQHbj4bnV8uSeM+ullGRH7rNRo
	8FpNAZ4uV1ToULPdQ9A+f/XMk17ADgWvgeyk3lJSs=
X-Google-Smtp-Source: AGHT+IH7XOIxprepDIF3DBKbWSn0SSWY0B0ZxPTrzW30xGvfWbUQZUBIjv/33LVIzx1qte4XXEzvhoWR4VIN
X-Received: by 2002:a17:902:ce92:b0:2a2:d066:b668 with SMTP id d9443c01a7336-2a2f222adc2mr258277185ad.12.1767045569148;
        Mon, 29 Dec 2025 13:59:29 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a2f3d06e23sm34763975ad.35.2025.12.29.13.59.25
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Dec 2025 13:59:29 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-888825e6423so214658126d6.3
        for <virtualization@lists.linux.dev>; Mon, 29 Dec 2025 13:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767045565; x=1767650365; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twseZy54c+QB1Kjp/hds53EAQKHotDuR3NVPADpEAm0=;
        b=XMaxBHFWPGC0EV6NnjJp5zJ4967ILYfb/1h0FtGu0EBvAePhez/nmYbIO4YxOoDH1E
         PAhNPrLBH/aCI405+ghX2K//UTLfgK1ldx9IHjJiJUW3hFzMMvpG03aopY5DuqrBQY4P
         iNVI1yclOcUF5jcNDCpgfWXbmaaEVum/iVWK0=
X-Forwarded-Encrypted: i=1; AJvYcCUUUAP3C6HpsPH9hoWQIsTC2knzOU+q4IK9J+s/Md7cX0C0fMRvrYI3yCz4YdGghDt/erHgOTh0Pb28GwUggQ==@lists.linux.dev
X-Received: by 2002:a05:6214:1d26:b0:890:2480:f027 with SMTP id 6a1803df08f44-8902480f3d0mr64568826d6.27.1767045565055;
        Mon, 29 Dec 2025 13:59:25 -0800 (PST)
X-Received: by 2002:a05:6214:1d26:b0:890:2480:f027 with SMTP id 6a1803df08f44-8902480f3d0mr64568576d6.27.1767045564676;
        Mon, 29 Dec 2025 13:59:24 -0800 (PST)
Received: from localhost.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9759f164sm231530026d6.24.2025.12.29.13.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 13:59:22 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] drm/virtio: Add sysfb restore on probe failure
Date: Mon, 29 Dec 2025 16:58:11 -0500
Message-ID: <20251229215906.3688205-6-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251229215906.3688205-1-zack.rusin@broadcom.com>
References: <20251229215906.3688205-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Register a devm action on the virtio device to restore the system
framebuffer (efifb/simpledrm) if the driver's probe fails after
removing the firmware framebuffer.

Unlike PCI drivers, virtio-gpu cannot use the
devm_aperture_remove_conflicting_pci_devices() helper because the
PCI device is managed by the virtio-pci driver, not by virtio-gpu.
When virtio-gpu probe fails, the PCI device remains bound to
virtio-pci, so devm actions registered on the PCI device won't fire.

Instead, register the sysfb restore action on the virtio device
(&vdev->dev) which will be released if virtio-gpu probe fails.
Cancel the action after successful probe since the driver is now
responsible for display output.

This only applies to VGA devices where aperture_remove_conflicting_pci_devices()
is called to remove the firmware framebuffer.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Cc: David Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index a5ce96fb8a1d..13cc8396fc78 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/poll.h>
+#include <linux/sysfb.h>
 #include <linux/vgaarb.h>
 #include <linux/wait.h>
 
@@ -52,6 +53,11 @@ static int virtio_gpu_modeset = -1;
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, virtio_gpu_modeset, int, 0400);
 
+static void virtio_gpu_restore_sysfb(void *unused)
+{
+	sysfb_restore();
+}
+
 static int virtio_gpu_pci_quirk(struct drm_device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
@@ -75,6 +81,7 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
 {
 	struct drm_device *dev;
 	int ret;
+	bool sysfb_restore_registered = false;
 
 	if (drm_firmware_drivers_only() && virtio_gpu_modeset == -1)
 		return -EINVAL;
@@ -97,6 +104,21 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
 		ret = virtio_gpu_pci_quirk(dev);
 		if (ret)
 			goto err_free;
+
+		/*
+		 * For VGA devices, register sysfb restore on the virtio device.
+		 * We can't use devm_aperture_remove_conflicting_pci_devices()
+		 * because the PCI device is managed by virtio-pci, not us.
+		 * Register on &vdev->dev so it fires if our probe fails.
+		 */
+		if (pci_is_vga(to_pci_dev(vdev->dev.parent))) {
+			ret = devm_add_action_or_reset(&vdev->dev,
+						       virtio_gpu_restore_sysfb,
+						       NULL);
+			if (ret)
+				goto err_free;
+			sysfb_restore_registered = true;
+		}
 	}
 
 	dma_set_max_seg_size(dev->dev, dma_max_mapping_size(dev->dev) ?: UINT_MAX);
@@ -110,6 +132,13 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
 
 	drm_client_setup(vdev->priv, NULL);
 
+	/*
+	 * Probe succeeded - cancel sysfb restore. We're now responsible
+	 * for display output.
+	 */
+	if (sysfb_restore_registered)
+		devm_remove_action(&vdev->dev, virtio_gpu_restore_sysfb, NULL);
+
 	return 0;
 
 err_deinit:
-- 
2.48.1

