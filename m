Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BEC227EBF
	for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447735; cv=none; b=YtHlxTm/ghJg8LchnxxeXH4wY17sMy/nEcuRdrm1QWV5UT8a3GH7BXOaIPkAWZHv85i/JeoZ/58ZQQKidlD9iE3DueQtZcTi1+YKkHlKAR7BMRVLvdf28t+Pu9koXxERVijV7hcGZ1u0YBtZI9HDQMoRgjl2efLd29hOjQsAfpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447735; c=relaxed/simple;
	bh=C1OI5EFaptGAyIC31Qyp31hhbpiPg9O9Rv2rGr/QaG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e6QD9zH+n34cU5ARj0dEEEfU2mZMNWqtXR973sey04ycKoTzmswcxPIXf+zxgEU/MfUJ7+nTKtij1W+L6sFE05ckmt6DOG190+0q08/xgO01hE2R8KPYdDJOr7q1Tg/aQw9CAN3vkJAg+3PXTyjRNJOeUxRhLSSTfLQRjVXCE9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a9vXGzAg; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a9vXGzAg"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f26a82d1dso249759f8f.2
        for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 03:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739447730; x=1740052530; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VTfLFSL7H02DDwltR23No4VBBkNnVp9ZJzpNJFBZ+M4=;
        b=a9vXGzAgTB6ZZoaszMCOcQwrpir6RQuSILjb5EqRTxxxIOu/znSKC2dvjFTGXh7Vfu
         j4KnXihn+VwpsmMaHXSb8rFikS/ZbxQPWJLEMl44Il+vRQ1pCi5M/wwe3xDwTRBbS2sV
         +eTtptDaQpjuwPDnt+I9XjuyS79XvD1pf7/ML/rhngh0FiDPkDTs4WIheUYayvLyjdZC
         6tgL/Hr2NtR7mKyl68yTUeqRWbj7YN5r0+V8kf5YF53FptgZ6JFPflpeq8nI4Cce8pQY
         drLtlsdQrWyaUEXvt4g5qg9vRkuknLBrNh1ytv/L+w5q33jxL02VR53iKGTC/6bI8nWv
         T07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739447730; x=1740052530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTfLFSL7H02DDwltR23No4VBBkNnVp9ZJzpNJFBZ+M4=;
        b=a88D78gulnRb7qzuMh7CkW6Ln+doteE+t4/Aih5o5z9ys0EddA/7rB01ZYsKI8evgu
         QqtO6Yiue5+0cDv8hMdWyX5OUREYUe8JSL3w+Knqd/oZcnW2qDu5Y5hya6ZupC2zMq5t
         MYv339NzXVvA2V9ti9gS16M2Ct+4uGxWeE2xc1yKHzMYnKSN/2+rMIK3Bj6R0uKb8afL
         WId7HlOvRrU0zUYzvq/YDbCzMDO/LVeVURrpHRHKzB70c0VqomBObJCjNbtYoPzIUaLn
         eCooW1ojm7RmpnR5Bbfb3tG5IQ2Mp+tXPW1VVZ/fIZC1H0VTLhSR0FdekB23AfzuMipB
         7jVQ==
X-Gm-Message-State: AOJu0YxhhHUR+lpSv0PMxwhUOKVyfcK1+AdcYrh7dPXAeravsBwbCbwx
	SM/RF1MctGe2TJyNjkJiuKL39WFKiO1DLBHRY9X3jL+cGcjxtKudOyL5KLdJNfo=
X-Gm-Gg: ASbGncuLuyir0YUtQMhTydGSxXJkEbl0RBOAq1O8jvj6//Kffa2v1MDkJB8O63D92DM
	OCMCcCz81AYDIzzNR4QomCNxLxthJ+kiwJLIUuTptme8hbAnPXE4kAWJKjMRALER66nm4C6Myb2
	c63KR8OJIMYCcW3CTJwzDAzmfxLPlVZbFqZXHKPGdO15rR4fu2ivWxb0gjQg80vpTz3ssnN344P
	j9+VNRQRg9pFW4O10iyU8qGBPFgsaVRXKChYEx3J/A25slV3FiUunUctdeowKupi+xLZZ2JqeWf
	odRM3ebtGc7HOONZ6PX6LrUilmsZ9R1y346t2eYnWCsvsYKiBaSJfW73Wg==
X-Google-Smtp-Source: AGHT+IEQscap/b+OG/JXpDEd/gOofqnnclTalVfCJDzbZNCEN8OOVDRJVyYP2FSB0UDfTZafXUOxjQ==
X-Received: by 2002:a5d:5a0c:0:b0:38e:fab2:60d7 with SMTP id ffacd0b85a97d-38f244f9e11mr2676566f8f.29.1739447730235;
        Thu, 13 Feb 2025 03:55:30 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5d8bsm1666095f8f.70.2025.02.13.03.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 03:55:29 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
Date: Thu, 13 Feb 2025 12:55:17 +0100
Message-ID: <20250213115517.82975-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1812; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=C1OI5EFaptGAyIC31Qyp31hhbpiPg9O9Rv2rGr/QaG0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnrd2ljEeV1wUlG2Gq7g9rttq8V5T09HYkMOpTW LQG6NzlpriJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ63dpQAKCRCPgPtYfRL+ TlBGCACANwC/3+znCE5Yu7G6KJc3XUvL7o4bnojWvcKBTl4v41VWAzoVkJUy+YQLAIka7E8g9No +eBQxSXBmfd5cKRz2KzOWh69bdzW1q3Z/B10YTb2Ohh/Lv0dUjDrv6GAJMGbR5gRDoLPnFL6Qfc 2UD2gYVD6OgBKiE1rwL3v8qb6xtjFi2U+rmzesFKVA8d1Eftmb9STQYneE7JEnFdzyoYiW0yeJK MJ+xG49BtYdKMMNudVfhB2sVNkET4Ug4aLQ18jme8hxyDatazvFyHQ7+HjGT30e/gpNAovetwXC kqssV0zcI/WoUc3V/ZbhtS5Nxj6ziVw/OkSMLDYF/tPWxiIR
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

virtio_console.c can make use of REMOTEPROC. Therefore it has several
tests evaluating

	IS_ENABLED(CONFIG_REMOTEPROC)

. This currently only does the right thing because CONFIG_REMOTEPROC
cannot be modular. Otherwise the configuration

	CONFIG_REMOTEPROC=m
	CONFIG_VIRTIO_CONSOLE=y

would result in a build failure because then
IS_ENABLED(CONFIG_REMOTEPROC) evaluates to true but still the built-in
virtio_console.o must not use symbols from the remoteproc module.

To prepare for making REMOTEPROC modular change the tests to use
IS_REACHABLE() instead of IS_ENABLED() which copes correctly for the
above case as it evaluates to false then.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I didn't check what else needs to be done to make CONFIG_REMOTEPROC
tristate but even if it stays a bool using IS_REACHABLE() is still the
better choice.

Best regards
Uwe

 drivers/char/virtio_console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 24442485e73e..7d7463d6f218 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -28,7 +28,7 @@
 #include <linux/dma-mapping.h>
 #include "../tty/hvc/hvc_console.h"
 
-#define is_rproc_enabled IS_ENABLED(CONFIG_REMOTEPROC)
+#define is_rproc_enabled IS_REACHABLE(CONFIG_REMOTEPROC)
 #define VIRTCONS_MAX_PORTS 0x8000
 
 /*
@@ -2078,7 +2078,7 @@ static const unsigned int features[] = {
 };
 
 static const struct virtio_device_id rproc_serial_id_table[] = {
-#if IS_ENABLED(CONFIG_REMOTEPROC)
+#if IS_REACHABLE(CONFIG_REMOTEPROC)
 	{ VIRTIO_ID_RPROC_SERIAL, VIRTIO_DEV_ANY_ID },
 #endif
 	{ 0 },

base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
-- 
2.47.1

