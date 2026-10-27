Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098260;
	b=DjNYdzcdDonEUg3UoxqZ8yzOO7t5LU+5BzGh+mkn9XTCTaCTaqIsrN4Jy7P+6HwTQcyy
	 rQwfwgZ0aPI3B6P/Q+OmD/hmYqQb5KsDBl9ZDQa9Lj60wVqYJTs+4Eh76W3rDWHFWnIMm
	 M1gji6jF4aDVJ+5REbBlckiSlr7Hn49KUny0ra+RlxoMlogQ+vLQdrzz3z49UIewJn+8P
	 0BofRxTL0IB/MbdLhvD4jCIsfAj5AH7jxomRh3O349aqL0dv0vrFC4IH5dxmIS1oadCP3
	 VfCgGZ+/53mn4FNhPVS2aygLMSUjHzoDYIFbZfTXttaBoIr1f72Yr4R4iEm6iEv9/xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098260;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=3VOGRaFrn8fAvV/f+zy2bWNoivBt7mrtA6BqeXwgJuA=;
	b=ufKVfCIo6Yo1omCslgHI5OZnfHwPjrgbtgNEhaey9uc117jZV5N2Posd7+SPWEGxb+FH
	 gYgV4NI9oje9MoLXbIoiJsIbAEJo4on2/r+FEEdzgA4zLZo0TCyDkrxWgaK7sgDJJIt6f
	 2awF4mrQIBW37pVvbBe1luefM1fVhKYtRk/Ck817mLUbNF3wuco0u4+TL2DosgSiK9TWA
	 WwaKKDEFYqkjWTR5LytI94PIJDy+1qHtMqDBfZWsYLDuhFfzTLq+Ze2bap03Jp5ZT4PoC
	 Ji6+ulm9hga3KwuvSaXSTdGigEjXW0Iei0LX3qjidlSewR++Jh0zboj8/pzXoGqRIgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ZU6IClCW;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36881606C263
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 10:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36881606C263
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ZU6IClCW
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a218c463d1so25084805e9.0
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 03:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793098258; x=1793703058; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3VOGRaFrn8fAvV/f+zy2bWNoivBt7mrtA6BqeXwgJuA=;
        b=ZU6IClCW6GV99GISQjSD4MzgFSeuTYn+yFOEp3A3ODCCGX3OUaqgalO+u+N0svpywK
         /S1vNd46smu0RUzrdwq0B4NZUNElY+8VBCT/qr1sxLmtfTrrI49UgCWd0B0nK0fvBZKr
         TjyU/twfVRUSJnwJ7s6aX+8bsymC3Ly4lOMIViBSSs/vgXL8ijYeS2mZpftfB2LTUQhq
         y6pgqvjvuVjr9Ahxryqzxw+NEtO4JMjjNJWvfFHnk1OCQapX6wEkmp9B/X2BocchF+Jx
         UbcXF4t35dJZVSPPKCqS0lqXLLdDyDnKy06TMraXKgDIWVV1d+KqgIcfODuEeWc+0x++
         uRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098258; x=1793703058;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3VOGRaFrn8fAvV/f+zy2bWNoivBt7mrtA6BqeXwgJuA=;
        b=lnntjGvRZQW+WW2afvnzuMdAGtomaFc3qrz4MRr9MMDaMzfC8nrCdBv6lnE0shtXzb
         U7tROEypuF4Lgub2F7kgewn7zw2n6g65egPLs77Q7+zLfGYgduqIuk+dPxCg2nXlMKyw
         6t8bdiPB4Tess8MY1JxeRdFayeTysc+/TAGFOgjaqVa5SJuDKs5vu+9GHWlUYiCx00E5
         QSJjYe++LInd0iiGSr74UYG3OY7Ko+eU0DUlr31fOXf5C3m0XZC13CTp8zQeoZoc9LVQ
         ecXFf+UrJvizDoTOfUaZQoEHCo9NcfwiVpQ0PnLbxWnOYNPCLSmgdRWJux+3hrmA6II6
         c0Gw==
X-Forwarded-Encrypted: i=1; AKwUvBzI3ys3UvnLk1oooN0QS/TxbaGZFdzBQAUszo/G5yorB5LNNRQCEyc9xTJ3wrQ8Ir5pI+dytB5QNacmy1tJ2w==@lists.linux.dev
X-Gm-Message-State: AFq9FYKrp6bH3Z8rQSfXJCtpOjjJ1amLYxEyT9eTHXVp7rEnNB2Nc4ao
	odrxc0COxFiuZOqVRsxFJgAdmLVAbt0qtgIWn0Tb4LOWxBaRCtWaTwdiCKJHugq5sCpEDp+BP1/
	QpeL62Ks=
X-Gm-Gg: AYBFou34LNHXY4ZK06fvyvGtnWLF+pcDOte6ulswVK1c0g+8g6xN0HbeLOAsW8e6iqJ
	gJjKGOgqEou5Zhe0Aw9VMI1q18GHJ/mD/5ymt0KmjzbIR+QhmXBj0koUXFu0qnXowv62I1Zn3jC
	0TUxnn0uVS2nAXcmjZBAEDig1pMSCjs5AQfrtgLnHez56r4zunApqhP0wpe3nGRvMmDVpDFCLzU
	e2fo+Bq+hE6dlMaW6hj+kIzeSGYGM7pHw3QW6cEB8aPAXFyiB6Y8RxBHoqvMCByfSJ6TdJKT07O
	rxIUG89uhdsKIbr+4NiEDerlwm1//2tHX5jmOy1Inq1oKc8GXVVzC3DMawcgvChmY7/A0N8U6Xr
	ai0Xz4N6zKkAJWEgbYN+SnkGDfFTWXZRnv+1ImobQEuOLXNXPQ1EbDpoeSpE+YsWy8DqoZv5fEF
	oPSluMbsNhH2NPAzpGZ3jvCvQcOineD7VDdzmIeJO/qYTWYauMbIKklEttf0E0EWjRqEqRfkb8n
	SkKYRosQ3n68zV2+8H+m9KgDKFNvWFPrq6SPKAnJQutkHtsLXFtMSZ5rHCPt9EWjSChPK+PCVqw
	xJU3DTAhKUMKvfeeCNu45egayI269yKe7+bN/3MDlZXDFBBmCf62fvoaOpdcEQPQ
X-Received: by 2002:a05:600c:3acb:b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4a35aca4fe1mr176894865e9.16.1793098257669;
        Tue, 27 Oct 2026 03:50:57 -0700 (PDT)
Received: from localhost (p200300f65f19a904240e81f1f32a429c.dip0.t-ipconnect.de. [2003:f6:5f19:a904:240e:81f1:f32a:429c])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a35a5698f1sm256311995e9.8.2026.10.27.03.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:50:57 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v4 23/23] gpio: Unify style of various *_device_id arrays
Date: Tue, 27 Oct 2026 11:49:00 +0100
Message-ID:  <c4102fd9781c4a79071b8a149577fa8c451e61d5.1793097104.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.56.0.rc1
In-Reply-To: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
References: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3905; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Y+ol7RAU4xTksWVGYwhEZhB8H6C2vUrzXYy4PRBuamI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq4IHhbaIqZR95/W9vS954qwXPTq+1LQgcynNtV agF6gmclOmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCauCB4QAKCRCPgPtYfRL+ TsQgB/9goajtO9UWZ46LFps8e2QfdurwGbjC8FPaELmHRAg+dxHD07Q8vEbR0RLHFrhkVx/hBkN jcaqOuwBWywOU9OjEnKnyITOL8Q+aB4MCGiTIV2CzOIrZF2WTw6ZG7u/1GY7+HvdXB0CA1lruYz WsNYYB2YuLA/2ly1jpz+SwLovuDT2iNYDFZn3VUbMkhqkeUZctLmRpO6E0SSqi4G05C5RN0fMlB p1zoxrhjseM2UJlQTGOkXIvYVpOP7nIy6Yv/TC3wVhImfTmgCq8LvIJGKVT7nBzB0CcsIb8WOSH jjewIC61gXUgzJVhzpUqexw+OK5QuFIyZs7m16NlGQdJicjd
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Update the various *_device_id arrays to conform to the most used and
generally recommended coding style. That is:

 - no comma after the list terminator;
 - a comma after an initializer if (and only if) the closing } is not
   directly following;
 - no explicit zeros in the list terminator;
 - a space after an opening { and before a closing }, a single space in
   the list terminator;

Adapt the few offenders accordingly.

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpio/gpio-ljca.c           | 2 +-
 drivers/gpio/gpio-mpsse.c          | 3 +--
 drivers/gpio/gpio-pca953x.c        | 2 +-
 drivers/gpio/gpio-shared-proxy.c   | 2 +-
 drivers/gpio/gpio-virtio.c         | 2 +-
 drivers/gpio/gpiolib-acpi-quirks.c | 2 +-
 6 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-ljca.c b/drivers/gpio/gpio-ljca.c
index f967feedb5d2..29b4e06497d9 100644
--- a/drivers/gpio/gpio-ljca.c
+++ b/drivers/gpio/gpio-ljca.c
@@ -473,7 +473,7 @@ static void ljca_gpio_remove(struct auxiliary_device *auxdev)
 
 static const struct auxiliary_device_id ljca_gpio_id_table[] = {
 	{ .name = "usb_ljca.ljca-gpio" },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(auxiliary, ljca_gpio_id_table);
 
diff --git a/drivers/gpio/gpio-mpsse.c b/drivers/gpio/gpio-mpsse.c
index 61c5ca96314b..a540f6e94f11 100644
--- a/drivers/gpio/gpio-mpsse.c
+++ b/drivers/gpio/gpio-mpsse.c
@@ -80,10 +80,9 @@ static struct mpsse_quirk bryx_brik_quirk = {
 static const struct usb_device_id gpio_mpsse_table[] = {
 	{ USB_DEVICE(0x0c52, 0xa064) },   /* SeaLevel Systems, Inc. */
 	{ USB_DEVICE(0x0403, 0x6988),     /* FTDI, assigned to Bryx */
-	  .driver_info = (kernel_ulong_t)&bryx_brik_quirk},
+	  .driver_info = (kernel_ulong_t)&bryx_brik_quirk },
 	{ }                               /* Terminating entry */
 };
-
 MODULE_DEVICE_TABLE(usb, gpio_mpsse_table);
 
 static DEFINE_IDA(gpio_mpsse_ida);
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 77b447c0fea5..06f7ad0299f3 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -175,7 +175,7 @@ static const struct dmi_system_id pca953x_dmi_acpi_irq_info[] = {
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "GalileoGen2"),
 		},
 	},
-	{}
+	{ }
 };
 #endif
 
diff --git a/drivers/gpio/gpio-shared-proxy.c b/drivers/gpio/gpio-shared-proxy.c
index bc69b8729d19..b64e32a1c0a5 100644
--- a/drivers/gpio/gpio-shared-proxy.c
+++ b/drivers/gpio/gpio-shared-proxy.c
@@ -303,7 +303,7 @@ static int gpio_shared_proxy_probe(struct auxiliary_device *adev,
 
 static const struct auxiliary_device_id gpio_shared_proxy_id_table[] = {
 	{ .name = "gpiolib_shared.proxy" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(auxiliary, gpio_shared_proxy_id_table);
 
diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index 42871db05ec1..062c70fe4671 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -647,7 +647,7 @@ static void virtio_gpio_remove(struct virtio_device *vdev)
 
 static const struct virtio_device_id id_table[] = {
 	{ .device = VIRTIO_ID_GPIO, .vendor = VIRTIO_DEV_ANY_ID },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(virtio, id_table);
 
diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index 3ab02c5f95df..77b9e34cd618 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -465,7 +465,7 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "GTCH7503:00@10",
 		},
 	},
-	{} /* Terminating entry */
+	{ } /* Terminating entry */
 };
 
 static int __init acpi_gpio_setup_params(void)
-- 
2.56.0.rc1

