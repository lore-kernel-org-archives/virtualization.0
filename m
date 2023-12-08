Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B7FD526
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SlPqUVns"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6D6204051A
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 07:08:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D6204051A
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=SlPqUVns
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KObylzP9296j
	for <virtualization@lists.linux-foundation.org>;
	Fri,  8 Dec 2023 07:08:13 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 41FA140176
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 07:08:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 41FA140176
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b9e2a014e8so878099b6e.2
        for <virtualization@lists.linux-foundation.org>; Thu, 07 Dec 2023 23:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702019292; x=1702624092; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rG1LJyzQ4WSLAFPo5foe6eDbn3FyZZB8mnOn20irkuY=;
        b=SlPqUVnsbHU0ye+KyV9ZD9l0c8UJT3bvaxTmHrhzlPZ9k9hsZcbaqjGyniz2F7JD1F
         0XV4KzmtT0scrgC/WYlOcjrYjYiyvUgxmlQweVluGsrC+uCd7ApWy9hyCHK9rgH3j8Jt
         DmK8BTpebm2vZ7+x6ucEYCGoLEtf3CcaMMZus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702019292; x=1702624092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rG1LJyzQ4WSLAFPo5foe6eDbn3FyZZB8mnOn20irkuY=;
        b=osxbM+S9D/zqLsmOPTi1WramBLpjTCdO6Eb0JkOz6D2u+5OIgTAzLOPqSHetl4Dkgl
         q5DDz1N2Ih6KIm2PS8ljzhvDQT9fiHKcQUuNYRbRYz6bgFL/oLhfeNuR9pxItxSXC96f
         bTa7iLzsFarrzrAKmdQjeJcMeKOtuC8/SsAPkVxLTUcrCxixIvQPW18GVzMkIPJS1jqL
         hzfmZFRoz5dUK88VPD9zkvBm15wPqCy1BUeLUobF7g+yXuw9TES8XK/rBvYVJ8JfmAM6
         ToCvcJxLhMMSwO9eFJKPGDVjl1iiqu0hzB4S6nCpRyEcUaHw+tk99TfGKU++Qys+3Iy5
         SBmA==
X-Gm-Message-State: AOJu0YziVNYjn4PbsRMthEaeGDBEPghHNPfb0mkZKh57T5z6DOajK2Vy
	urjayHW4TIP0M8Z9L3689vT55w==
X-Google-Smtp-Source: AGHT+IGgnjG/3NQ1wEHNyjy2fZFw0CEWGZ97T4Rb4NN9Ky3FyaNkvUXgjl/ynxmXyhcvvJ56IYF95A==
X-Received: by 2002:a05:6808:2388:b0:3b9:d53f:452a with SMTP id bp8-20020a056808238800b003b9d53f452amr3762370oib.70.1702019292261;
        Thu, 07 Dec 2023 23:08:12 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:e611:1861:4d10:12fc])
        by smtp.gmail.com with UTF8SMTPSA id e14-20020a056a001a8e00b006ce6bd9703csm877120pfv.194.2023.12.07.23.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 23:08:11 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH v2] virtio: Add support for no-reset virtio PCI PM
Date: Fri,  8 Dec 2023 16:07:54 +0900
Message-ID: <20231208070754.3132339-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a virtio_pci_device supports native PCI power management and has the
No_Soft_Reset bit set, then skip resetting and reinitializing the device
when suspending and restoring the device. This allows system-wide low
power states like s2idle to be used in systems with stateful virtio
devices that can't simply be re-initialized (e.g. virtio-fs).

Signed-off-by: David Stevens <stevensd@chromium.org>
---
v1 -> v2:
 - Check the No_Soft_Reset bit

 drivers/virtio/virtio_pci_common.c | 34 +++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index c2524a7207cf..3a95ecaf12dc 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -492,8 +492,40 @@ static int virtio_pci_restore(struct device *dev)
 	return virtio_device_restore(&vp_dev->vdev);
 }
 
+static bool vp_supports_pm_no_reset(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	u16 pmcsr;
+
+	if (!pci_dev->pm_cap)
+		return false;
+
+	pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+	if (PCI_POSSIBLE_ERROR(pmcsr)) {
+		dev_err(dev, "Unable to query pmcsr");
+		return false;
+	}
+
+	return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
+}
+
+static int virtio_pci_suspend(struct device *dev)
+{
+	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_freeze(dev);
+}
+
+static int virtio_pci_resume(struct device *dev)
+{
+	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_restore(dev);
+}
+
 static const struct dev_pm_ops virtio_pci_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
+	.suspend = virtio_pci_suspend,
+	.resume = virtio_pci_resume,
+	.freeze = virtio_pci_freeze,
+	.thaw = virtio_pci_restore,
+	.poweroff = virtio_pci_freeze,
+	.restore = virtio_pci_restore,
 };
 #endif
 
-- 
2.43.0.472.g3155946c3a-goog

