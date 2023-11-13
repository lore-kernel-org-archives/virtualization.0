Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CB111702
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gqM43HrN"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BCBD416D1
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 05:51:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9BCBD416D1
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gqM43HrN
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Na3bmpXiEVg1
	for <virtualization@lists.linux-foundation.org>;
	Mon, 13 Nov 2023 05:51:55 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 04E6B416C6
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 05:51:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 04E6B416C6
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5c194b111d6so424348a12.0
        for <virtualization@lists.linux-foundation.org>; Sun, 12 Nov 2023 21:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699854713; x=1700459513; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d3gsxgxUWE7sauUTr/vPNFu3myJ6+D29dcITW4pw1EI=;
        b=gqM43HrNMscxZ3xNS31EP3QMX+1tHjCK0JhjT7QGn0BNuLxCTDh384X2yc+6CgMPuj
         L2aCkrKQ/9hKxQ6THdzvYvpiGEluSgFcHJeDjbfKlXLqnspq37NZWsNuZgEqBzmdzKDy
         OoU9DxHwE1tusO0NvRT9kndkDPnBY8kMO7nco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699854713; x=1700459513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d3gsxgxUWE7sauUTr/vPNFu3myJ6+D29dcITW4pw1EI=;
        b=H44bNAywivSBoFk48Wx+CbRt8GsBn7ytJ8Lg0WwLVhWgsVbp8jjblNiM2TW0WXS4o/
         pYy9yixLEa5Qky8sXEswXtQncTOaAwCaAOKIRSMdiMIHlILg3sG+jd5no+NwbvMDNPHy
         xkKk/tZuT3ZW7USWDod+eKkxeIqT7y6X6zKFMqa+9lsOUtw9G4TyTF/yH4hdmlPtj5Ur
         u+S9zzJVdQ9jLq4tdqHrc1w+CsI2guyALbFtatO9iY9WcOr18gIMn6lmzb67MXlSBfna
         DT5MBo/zwNg7EAFyp6HW+MitLgDRdSja9A1mEVVHPP1TQo2n/ftFraobAuCVR+1OAJ1T
         O6mw==
X-Gm-Message-State: AOJu0YzcNBonFjiYI9uN1FPrbom19JwNHKnF4YWu8QBQvrcI5Sj2oBMd
	SlUFOQVr4FZDq2ySQlND/AKPSK+cdB2vjcS3wQo=
X-Google-Smtp-Source: AGHT+IGtoqIiLNdRIrkQj/Km8AZg8AWLn5j3QqvI8VTAGO98KBA9/AXhjfpsp6WdhaljfbeKQiE4fA==
X-Received: by 2002:a05:6a20:1447:b0:185:a90d:367e with SMTP id a7-20020a056a20144700b00185a90d367emr8322809pzi.2.1699854713209;
        Sun, 12 Nov 2023 21:51:53 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:b3d4:3d34:1798:ff1c])
        by smtp.gmail.com with UTF8SMTPSA id jc17-20020a17090325d100b001c724732058sm3373241plb.235.2023.11.12.21.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 21:51:52 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
To: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: David Stevens <stevensd@chromium.org>
Subject: [PATCH] virtio: Add virtio-device power management
Date: Mon, 13 Nov 2023 14:51:38 +0900
Message-ID: <20231113055138.117392-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Virtio power management for virtio pci devices is defined on top of PCI
power management, so it mostly works out of the box. All that's needed
is to add suspend/resume callbacks to the virtio core, instead of
reusing the freeze/restore.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/virtio/virtio_pci_common.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index c2524a7207cf..0cad900eaf4f 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -492,8 +492,27 @@ static int virtio_pci_restore(struct device *dev)
 	return virtio_device_restore(&vp_dev->vdev);
 }
 
+static int virtio_pci_suspend(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+
+	return pci_dev->pm_cap ? 0 : virtio_pci_freeze(dev);
+}
+
+static int virtio_pci_resume(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+
+	return pci_dev->pm_cap ? 0 : virtio_pci_restore(dev);
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
2.42.0.869.gea05f2083d-goog

