Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2234328C2B3
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 12:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633624; cv=none; b=dcDH6us/GMGpk14rWZ6g+r/oI/8NCCPjMqkS4tyR+PEQDsUmA0yssdq+Das4tRAuSZl3XYldzxsxHfgYaLXPeN63KqRGHePcoaYap2z18KDQap61aCI58l9NAZQrANlztJ88PFIoaqvfbcJe9tsML5ToFD081/358HobteHTtFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633624; c=relaxed/simple;
	bh=gQW1V9m71ryrxmlD4mF7lowP8cVRVurHwVgZWNpXS00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5r9N8Fjp4WJPv54/VklN4gTieHpOH2a2R5EpQptnkmULl2E4V7B5KH6Humt++dZC7J3KbOhdagoaxlCICJm32ZrCzK7l6bC8ueD0Eu+xM7PX6oBxa2rCwcdvScu8+OUI554Yqx1H8y2baP837OJXhuObuX274kC4fV+leJ0jog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q3VM8cMJ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q3VM8cMJ"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32b4c37ebf3so2140711fa.3
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 05:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751633620; x=1752238420; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C5irpwJohjmYuveaRSftdub5qXB+Y6zVr7PqlDralMk=;
        b=Q3VM8cMJU8ewNlxQ7TamZlloFJEPPRsRY5Uer164KciqR/MOwP9vGUEYaP4IJTMstb
         yTNZVdlU6G+fQpK8fJltqecMIAHovnrJpAU8Nw+RXMHryrvTxejJ5/QWBOzV/9XBpFxl
         r/JBlKm0sy/tBVClREhTRVl6a2HfZW3gaGbAjcGyEMWTWSP2zyVLHQmftBrUjxi7YhYZ
         6VPbTyJBFbQK/O9+J/NLYJoWh7ljAHawJKijc77ASWE5Q9N4udlxWwdHzNqNksQqKf2F
         UZxk2HW3ff/yb/EwiQsUnXKRgZQDRAZHxRGNhZHijOjhjkmjR1Pwn69SYi+t31J0iefu
         Bkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751633620; x=1752238420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5irpwJohjmYuveaRSftdub5qXB+Y6zVr7PqlDralMk=;
        b=l16DhYisxZ4SAJlV4ZgV9bzW/Gw4kA8odN6BbaE/Bi5WF3G9zriZOA6g/sBnuKVI2x
         cQGKsQDdu7WRssVIUSfHDZFF0eEAQs2S7+p0TnzZGew/+8vEK1QoiaH5tmguuJHfMdYe
         0bC/M7OfpvqNbRBzGkk6Bfpy79JCTEYBQiJVpnIhSaIGT34zZntr7Z2C5bj9MYQz3ayV
         rytjaLODKZPCN2IjVK3+EUD6dYcIYT/1yaaC6LkHgIeXSz8jPzNi/DS1w/rb7BW3ohlk
         isnkn/ZDkm/MwmHqRpKA7c0mF5bIgmnnKGYiZu/s7BBL7GYjVEHFC8xkG6yWIJ0ECFUD
         2Z4w==
X-Gm-Message-State: AOJu0YxsNC+nhg8Tx7yYbcFyaBKFHeqmnTALHSEOZFGALAruOrI/iI9Z
	Ye8uXikCSZ27XH80UtVOztaq+crgqA8R5XAsh2lTy7nHzo716KH65RCLi4fsNu1WUlU=
X-Gm-Gg: ASbGnctN0jpPsUaLhaHOQrIfQSLmJNOplM174z6TCgn6ClxXYP20TUIBsgAYJvIxB2H
	g8fgvNE1taVXlQE6a/inzQBIucHCydjcYgNwzPhHJdTZuT52Zib33N4w2X9e1+TkE5Kxlxv7EAe
	v3if6AYQKbtCohOWTalVXPhctaHH0aumR0lEFAl/liLPBaD2n22hEI+ig+s7/5GDO/dep6K3cPW
	y2a07BlO9aCOHNHyU+gqSSmENLAxdLLuAC4JT7q+cTUzaPJ3gv3uB2qbSsRJxMn1Z2j5StM238v
	7C1NaAYKTmTj4RAd0t4zY6Upxs9XTIFsk+S9Z14eDJvJ/T+F7P3y0UZYN8M+V28zsOYptmkvRDs
	OQDyZaFScoTrWcbvCS6rTbg==
X-Google-Smtp-Source: AGHT+IEQlE2inVcPa3XqH6/JYvapWfOKX27mQ8m7//vg+Z9RExKQrvITesM045aa9ircpVQ2pBhElg==
X-Received: by 2002:a05:6512:3d0a:b0:54f:c1ab:2cc8 with SMTP id 2adb3069b0e04-556e71185fcmr232528e87.10.1751633620006;
        Fri, 04 Jul 2025 05:53:40 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-556384d57a9sm241167e87.257.2025.07.04.05.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 05:53:39 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] vdpa: Fix IDR memory leak in VDUSE module exit
Date: Fri,  4 Jul 2025 14:53:35 +0200
Message-ID: <20250704125335.1084649-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing idr_destroy() call in vduse_exit() to properly free the
vduse_idr radix tree nodes. Without this, module load/unload cycles leak
576-byte radix tree node allocations, detectable by kmemleak as:

unreferenced object (size 576):
  backtrace:
    [<ffffffff81234567>] radix_tree_node_alloc+0xa0/0xf0
    [<ffffffff81234568>] idr_get_free+0x128/0x280

The vduse_idr is initialized via DEFINE_IDR() at line 136 and used throughout
the VDUSE (vDPA Device in Userspace) driver for device ID management. The fix
follows the documented pattern in lib/idr.c and matches the cleanup approach
used by other drivers.

This leak was discovered through comprehensive module testing with cumulative
kmemleak detection across 10 load/unload iterations per module.

Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 6a9a37351310..04620bb77203 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2216,6 +2216,7 @@ static void vduse_exit(void)
 	cdev_del(&vduse_ctrl_cdev);
 	unregister_chrdev_region(vduse_major, VDUSE_DEV_MAX);
 	class_unregister(&vduse_class);
+	idr_destroy(&vduse_idr);
 }
 module_exit(vduse_exit);
 
-- 
2.47.2

