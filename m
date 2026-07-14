Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D7A3F9278
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 07:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013952; cv=none; b=gpYBuNd1OnSLec9dSpPmrCljCUhjnoqHYdi42qYTl43JysLeMnD/mcEYTM96yAulZ57I0xJkW+mGnW9i412t4PABHWehiHaWlBtDGEW/j49RPG7kR+XMJlI72G4G5aM2CMuC9mV1PuQqAA35vemZgxUl+sv5O1Ew4sEewoBh8DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013952; c=relaxed/simple;
	bh=fvu/m+rpcn3hmgIKPNxhMhPigeWKXUxr+xYgkr/uykI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHEKRzDuu0TwdRWHxgSgv+sg2JYoz4ZUc71akDL5p0iDnJozzsR8O3DaYE1eBFHfGKvJR+tyfPuyYZEQ0glsrEgcTEBJqyqA4f/HxTGZX4XWLI0VwIEmAmJsAC5ksC+XrbzAFD4t+qO5PF236Ibrbs+vgx47SvZJQa3p/+3bfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=RAdKAYeq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="RAdKAYeq"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so3602895e9.1
        for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 00:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784013948; x=1784618748; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xmgdis0KNSxiTcgJ05PgHtMXCrsCziLcVqNfaUxyfB0=;
        b=RAdKAYeqdFllvyNJvLxbRjLjy+ugba1sVcnVLoTSx8rqIh0AC/IIKZ5/D+9/1C9nKZ
         sqjfHo9Iy8PET0eVr381jnvJGSXSPKwzQKQfD8eSsZ5kPKQnldht8gUIjMSNbPNcOiEe
         YPKrrO/ADgJOWkqkP2lmPP76hTHL8V26SWwSvoYkBQsrngy54AseUAS3L7Oj1vYgEve9
         Tv3npHQPxffQY8reC17TqVLZiBrq329iEboK29uFWOzBN1wIRW+Ik9p4QxEhRGaRzFHg
         b6Nore2ihUmjUgQcoZapBx5u7eY16VfvOFsztqqVU0W/nouGdQafzdFjQmVCi8QKc7ht
         Gh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784013948; x=1784618748;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xmgdis0KNSxiTcgJ05PgHtMXCrsCziLcVqNfaUxyfB0=;
        b=tMrWaQCcsljPtZ8qbcDeOkBUFPANf96nDlYA3LXhM2W5kS+s4zwRwBRo3HPAxKbcBU
         mGa/rljZdpGOEES0llJzMwEjwybh6y93AstIrQBoK362cg3mQ9CZAvyfqBQ83hdLaFfR
         Nl6zalInWTll60ddrutXGGJeXSCmzOwlbgjOyyW8cSIiUSFMfj2unbKOnajRfjaZTMlI
         X3hf569JJbC9jTeVHQaSSlhBY/iDFprvj5kMC95Mh2vb6FyngMioBooPwyGahd/vF36x
         oOSUNQ5QcAHBrP/ar9WEQz7fiDg0z+jbLJkVjtUv9Iplu5EsDT1pHb8paK2Pi8luLGKX
         Berw==
X-Forwarded-Encrypted: i=1; AHgh+RpbPZ5S7MyFgGAgSGz4dxn8ruCBEmyJxnrhDt3jm6QistguyuSJxs79a/26zv3ujenBLV/raGBS4zFkoPz1Wg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVAApn/f0F9FWmNeMTwgCz04pbxVlo2MPSlMi0zTXeZk+wkFhA
	vJYylCsn7T0aqf8rWwIdDemrh8pfJan6GOkbcQp8PhTvmKHK8O6oDXeLeWRr5TjqHSM=
X-Gm-Gg: AfdE7ck4PxA3PDi8+O6bPZxtBKu3AdhNxFjrKcLALE8KK1JwoAHndk9LNT0YOWxr3GZ
	h8bH7eVBmYIBEHbEKIt+kP3j/bO3+nhUIWuQkNmoJw6U6dZcOzh/+0/Ox/IdOeM0TFvf2lY1gjO
	t16aU22IjCbD7G0XWJ0AaF2yV6Ar0Go1EQrixYXI/2rcuQtwHSz4hWhqOhWo4t58GB/vg/2r/mu
	YkGKVAonaw9u8c87jqBpJIdDXnBh0CHDXfYDCt64xFZvgKU56pJfqq1UM5hkkaDc6i7t1V09iZq
	ttQbOXixA1jBzrSN9GnoI9fM9MRymu41s8uSANDJfpLZa1Nv4X8Omz3Sxy6pUW+Smuq7V/7iP3X
	uLUHHC/tECKy8dYvf7QNlnV7AvG5CCEd5K1iVfF3PE+DZoqb+aWTfqhDxcOQv+AOyLu5tQQLgLJ
	H7vdl2cS4UmZTO2/2nsyFxtyvrbKFvY25QJQo3LihcHO7/CJAYB1zzgqbCQiaMCSYNFjNEs18pc
	fDc
X-Received: by 2002:a05:600c:198f:b0:492:3237:ddf with SMTP id 5b1f17b1804b1-493f882994bmr119418695e9.28.1784013948568;
        Tue, 14 Jul 2026 00:25:48 -0700 (PDT)
Received: from localhost (p200300f65f47db04b44a80421173aa03.dip0.t-ipconnect.de. [2003:f6:5f47:db04:b44a:8042:1173:aa03])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49510c8e220sm44969925e9.15.2026.07.14.00.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 00:25:48 -0700 (PDT)
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
	linux-acpi@vger.kernel.org
Subject: [PATCH v1 20/20] gpio: Unify style of various *_device_id arrays
Date: Tue, 14 Jul 2026 09:24:21 +0200
Message-ID:  <1f2d39342995533857417eb890628f7643b9a159.1784013063.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1784013063.git.u.kleine-koenig@baylibre.com>
References: <cover.1784013063.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3323; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=fvu/m+rpcn3hmgIKPNxhMhPigeWKXUxr+xYgkr/uykI=; b=owGbwMvMwMXY3/A7olbonx/jabUkhqzQJ37CljIiAd06L78f+7+h+OezSONtc83VW9kqpvv9+ LDZZ/blTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmIv2Hg2HFRtZM5fgQZYut ZrO6nFS2a4uEyz81YOJa26u4donSome6/BferCquWRsjt7fBMLRtSxITu6xkkQlDeUR0qqSS+eU I8eaO700m36JFZl6uS5br1TBMSKgL5FESTrp8+0PXQi6P98IKt40r2j6p/V6VtV2xSc6TpeDLxf 93OI8mlx4VuV+9YtbO7EIei8U6BaJdM3qWdqnEt9u9jePSPm7NP/V9pIf9JbcJBa892Jo6Wz2Mh fI3KMYv9BMVTXsS8EN5tclzkWerbks7rVK9tTD4wsyYidKc5peymLSe9h2KiV57MPKEXDNHu7nx /jMhVef+nHwXfelJ/20H1rNO0xldGtbPa1zqenyzeTIA
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

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpio/gpio-ljca.c           | 2 +-
 drivers/gpio/gpio-mpsse.c          | 3 +--
 drivers/gpio/gpio-pca953x.c        | 2 +-
 drivers/gpio/gpio-virtio.c         | 2 +-
 drivers/gpio/gpiolib-acpi-quirks.c | 2 +-
 5 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-ljca.c b/drivers/gpio/gpio-ljca.c
index ad5dc9a3a119..d9d7394d8b95 100644
--- a/drivers/gpio/gpio-ljca.c
+++ b/drivers/gpio/gpio-ljca.c
@@ -473,7 +473,7 @@ static void ljca_gpio_remove(struct auxiliary_device *auxdev)
 
 static const struct auxiliary_device_id ljca_gpio_id_table[] = {
 	{ "usb_ljca.ljca-gpio" },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(auxiliary, ljca_gpio_id_table);
 
diff --git a/drivers/gpio/gpio-mpsse.c b/drivers/gpio/gpio-mpsse.c
index a859deab2bca..7ca06bdb2c4b 100644
--- a/drivers/gpio/gpio-mpsse.c
+++ b/drivers/gpio/gpio-mpsse.c
@@ -77,10 +77,9 @@ static struct mpsse_quirk bryx_brik_quirk = {
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
index a2d85ab1d01f..09d0a65382f5 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -175,7 +175,7 @@ static const struct dmi_system_id pca953x_dmi_acpi_irq_info[] = {
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "GalileoGen2"),
 		},
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(dmi, pca953x_dmi_acpi_irq_info);
 #endif
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
index 5525c467c21d..9bf5ba619107 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -392,7 +392,7 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "VEN_0488:00@355",
 		},
 	},
-	{} /* Terminating entry */
+	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(dmi, gpiolib_acpi_quirks);
 
-- 
2.55.0.11.g153666a7d9bb

