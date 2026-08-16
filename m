Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3923DD51E
	for <virtualization@lists.linux.dev>; Sun, 16 Aug 2026 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786876035; cv=none; b=fmzQMqYZ8yi7XZt8BVPdAOcbA+d9Obrnh+ovtyAfLC3DwpZfKu4IpTACAz9T68WmXBlBdCtm+cl1XNYObFmCrtRMIR12FNSyuZbOKOsxn1gKktUNgbTmCECmiiaMKVmnxmvuxRf20As10RH6Hc4oVWEzVyNHr+PPZg44hfZcQFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786876035; c=relaxed/simple;
	bh=MUhl6pyDa4/jlZ7yWjmBEuMvbCqtRmSqF9TiFB0Lmys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQjPok/ITVntOXiPkybTP/xx5gNUH6bnQqjFKh+upxp9+eIaREM/NRC2RjSfHslqqw/xvgKc/i6raJzufz6Yl1fkTqaBG+6s/cWwrc1oLCXXNC6fooq8q2p1+Pu/v37cHRqxzcs6/b+Upev62F/zlRnclU3KRsW8sjlg4O7D5/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p1zjveBK; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1zjveBK"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so1432267a12.2
        for <virtualization@lists.linux.dev>; Sun, 16 Aug 2026 03:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786876033; x=1787480833; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PdkrMc9DhMp/prIWFy0w2tuUoEKS5220Jm/KkOhdl3M=;
        b=p1zjveBKt89JhL+4tuo19icQcEJzr7Ey0Zra1qj0eejfQ8j4xpcCeQmiWfd50zJ8tJ
         fZH1a8xv9KTPD0ZDlG+BiHnIBenenGvp2+UhbB9LKz9HiXoRje03R6YP6y7X2o9B7wuO
         hnT3OtK4Ha5HW+DBFyJWHTYjg8Mc/DSONfWVyYT//026Lxw0YEloQA/SvfJViM6ptecr
         DWZoRtWQH++0ElEhvjgpI8SLtmRuRAskfG9wG1m108avDhqolx1IXJ2mvVM/9jc4DyLs
         TQQk2HD8CnBe1gmplwgASfOEMZyI6TCZmAafaoPWwmOjbsVGu8lWbTObCwk6zmqMaEih
         yqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786876033; x=1787480833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PdkrMc9DhMp/prIWFy0w2tuUoEKS5220Jm/KkOhdl3M=;
        b=YZhllROw4wwRFDzU7r75erC7lydrOm5GeRZN/F5EYszkI6yR/wKfJ4aMs6D//32jrO
         /f3fSl04+aNYBHCaOHkZxj7yVWLAuf1g5jvmcNyuycebzoay4LAGkuNOBwnlLH5ExsOR
         atZgF+pYCFs/+J4RSnxYDhZj4oh5pHrc80dDNjCCz3DQz7dkUAx+urX2n+I7Rk3u7Lgb
         fv8W69gvA84DsyyxLQeUPokTAeJJd8EIDvPSrNlr76HL+zJyXLPLUMj3PXeIuFhSLMpX
         nG39H6XMGZD1dmL1yzYF1OmCOl+Wgqp74s5KyVyXeIkC/zzSwMcYiofg1Tl8p937s1XO
         KPpw==
X-Gm-Message-State: AOJu0YxTt6IzZqIRjNUE3Zn801qYeNoI6CCRakCtOTwhO+LSxyM4wpGq
	jstp1Qldq28x3xZ2BX7UyE5jLG4Qsuu8WOMmVZliYE27tlUMyrpqkBL7JjqOmPXW
X-Gm-Gg: AR+sD12xEu0p28AW5xvVObc24z53J77QahQ4JG6jIgWnBGtYAlySAvwOv0zSP59JyKI
	QUNDcH3ufn7zu7+6+6AYNxh28GFDNFZipfQm1NUoKpNV4itrAJ6dF27ASPhCxEtBokV+/ZyTZE+
	ybI+4OpI01abp+GWitHsbyaL5bpfqw8OnAn1tWgSvm5Q0hPeggI3MEUVHQa7u8WEAfpNIvJxcr/
	JEvRe9uBBG/be1VpwK6bmYJUqCa2K5oAw1PrFuJPUyrfMQdAvkD1b74TkOdBUW2w9TExMrWJ6JX
	bxRFjiyIgIfDUNnZYuqTPX6HT57w2jk3anPjikUMkIzlHwfR6Z+rYgVinpMifDqfZoziieAAG72
	Tgr2fVvkxDBgaGinefBquORMTybJL6buAZ7ChGoTQ4wKbTYgU1Ja9KvVWw1mXyRf4JbEoYRdnU8
	VrG/3zE5l5t2/gJMbQxaiqodErLfPd7a8feXMpOjXmnEM6Gm/IxIs1oiyStTT4hvMjSyCHhfDqk
	sQRei1DB6vuCeRgM+Q2Htu/Vdjz+aZG/QI=
X-Received: by 2002:a05:6a20:94c8:b0:3c4:3b16:2979 with SMTP id adf61e73a8af0-3cc71d80e38mr18233699637.30.1786876033351;
        Sun, 16 Aug 2026 03:27:13 -0700 (PDT)
Received: from Debian.tail44843d.ts.net ([183.82.161.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387ed5b1sm49210284c88.8.2026.08.16.03.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 03:27:12 -0700 (PDT)
From: Mirza Ishan Beg <seedandsyntax@gmail.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Mirza Ishan Beg <seedandsyntax@gmail.com>
Subject: [PATCH] virtio_pci_modern: replace msleep(1) with usleep_range(1000, 2000)
Date: Sun, 16 Aug 2026 15:13:19 +0530
Message-ID: <20260816094318.8083-2-seedandsyntax@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace msleep(1) with usleep_range(1000, 2000) in the queue reset
loops.
msleep(1) relies on jiffies and can sleep up to 4-10 ms depending on HZ,
whereas usleep_range provides predictable microsecond-level delay.

Signed-off-by: Mirza Ishan Beg <seedandsyntax@gmail.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 413a8c353463..8e74a813ca97 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -535,10 +535,10 @@ void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
 	vp_iowrite16(1, &cfg->queue_reset);
 
 	while (vp_ioread16(&cfg->queue_reset))
-		msleep(1);
+		usleep_range(1000, 2000);
 
 	while (vp_ioread16(&cfg->cfg.queue_enable))
-		msleep(1);
+		usleep_range(1000, 2000);
 }
 EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
 
-- 
2.47.3

