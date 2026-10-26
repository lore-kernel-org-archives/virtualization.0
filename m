Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032210;
	b=q/TXo+mMbVS/k7M1SYdA4WsIR/ZxB1SpTMR8oWXQERdYyM/u5roHOXZMaFj+g/3GO/yk
	 NyRVFYHiShQK/FoqpfZon6i3e4KOA3kwcWv+x4I2Ie6jR8+LSugmCA4IgA/Mu+WcLs368
	 uu1UvKYndDq7tCd3DvQyseHd6Zr1fUTBLdK7NgOe/A671xVTUnXmkw5bpc12vE5pCM+kj
	 DK2Aj+Jcwja/qkcGHfTcfn5mEG8qfN0vsJr7qb/dT9VISUSz8Rb4HV7cTaY2kLW2q4APb
	 Sm5Fj5BjbVUmOv8IK1WzgeEScXDeltS+Wqzayz5qTTKMP5NSa9IZObM/IqLNzhNwN3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=tsrGFIGUSYgIS9WAku3WtyuWXYZnqWS0fWPP6Qel7w0=;
	b=5OGTv4SW/Evl1VOdVuG4WNlS550A8HW29M3OdyjagUgY3VzluvbJHRo3jOFZ7NGuwm/U
	 kHOVefiuYn+vBNxMYIHktYDrHi49K2jhNy5F3AGn/fVo5NN+h0vBHxpe9rGLNMS7KFl2z
	 LCBMDhOqGyRlMcuMz6+p2NGh2tFct9omwIjZxV3BN1rqgTeexFFlKZEChwkhSrZgJ1Y/Z
	 pXUW3+5TLd+yo8B/+pQVdIlAtTSI1nXxLxXYe/QQ1bHBtVqsBgM7LndE3rHud4ZERdtST
	 qLOk88F0cuZ84tTkFct8Vt4D1SCFyA/YXkVLZH3rrz/tZTfau2k9tyPAjdniVuMzJTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="L3x/Il80";
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631CE606B7C5
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 16:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 631CE606B7C5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=L3x/Il80
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so20531255e9.0
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793032209; x=1793637009; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tsrGFIGUSYgIS9WAku3WtyuWXYZnqWS0fWPP6Qel7w0=;
        b=L3x/Il80Fa3emNwy/0sGeyrsql3ZnwW297ySnecvp4Km0nVJllS2E491bOIQ7kdtsX
         kck24S1tOnojsHrtykzP8/RSxVz38m8ttfrmocuUhN5dgzMvTPKlAaRpzuMyiLEv+WpD
         Y3rWliul2Vj1jYiTle8rUTl1AXk/dmmO2eCd55uv4UJaaAAms76pxRCEcDuQ7jsRrJx/
         66CogpB6VgU24UBZj3E0CMqD5NqvEGg9H08y7hdF/sm1I9gEReUT6PTXFjrRHRQHBYA6
         WCEyRUkCusO7ff+xyNLKJ7gO9hvjQpAuBVASdaSpDFtWu5jlxoAaxgud5Z1AUtAR1jqF
         rwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793032209; x=1793637009;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tsrGFIGUSYgIS9WAku3WtyuWXYZnqWS0fWPP6Qel7w0=;
        b=ZdsSwoP1tRDZscpVg/v7nSYEwq1J9Jad1rtLlc2xz24GZ85zbaaZ0kM4vHvG4hcRGd
         uh2do3lOiEiGpQAorb+A+2tKiU2lzinRF+fgdR/TMSXkCpGEZvezIu5N8ktJJ9bFGpBv
         5Co0XfGT2QwOL3zRfQAlEgfB/tAEQWxcTUy+Tpnb/Mk+kAgeHFSao5OjH/smOHeCWEbE
         YHvab+UxRvwqwP2/yStBqvxBV+Fu36jKVtowvO4Nqd6TuWCxzr0mFzh1p8hgqoN6Wyja
         4LEhVvUHNWwKsDocfYdumqXD6JZpITDtObaVGCunCapn9q643obSFqoYJOLyo1oGRO1C
         S+OQ==
X-Forwarded-Encrypted: i=1; AKwUvBxS5sET1AlRPf0G97J19M3S8pXs+IXPP2ENL+xoDdYT1nxEusKT1Y0lNn73H1F2COe/3KmiYW/pLrL5V7T8SQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKq+maua5OeLaMJMOVQN1EL5mHlRd3nbfZeWbo8gQmWL9pesPB0
	MCbsOgvNsHDYnmT5Vpil1C39hwETtZ/pp39Fm/IXm6Ouv3tYD4WtnXQtzevkiY876nU=
X-Gm-Gg: AYBFou0l7NFxQloH46Plbd4msgRuXxVCXr387rVX0qRw2Irb7mDiz+fuZXRK5I98O/9
	nUn/rGinrolArPjmxBu0lF5swa7XkdcfHQo5XsnpBLMEca3yw51I624E0Q/UCFeQ6jFuQepoATE
	L3BnIav6mQrCIwprjOXngiVHnwSs8aGAyHtdsYsi3fPrXp+F3NIaED9dHd5O+S55ZcEiUBWJnIQ
	K0PCtjQ9CJuzwJ8QPMER96Nl2Svz+/sO4UXi35CJmmgdID9SgjSis5ipZxcior2ZkwJvAsf9KcB
	AG1efmaWn9eeVD90QIdXK4hXGJsyGNlEOBK/znUXBIJ/J8Sp0CzpyHTYkTTv2FabQtrD9PC8B2d
	+kCHTUQPyH4PgLgb+0Gpa/GifmURL8lPHcPN992iwi2hgkeirq3n+WuxQHLk02y6S/megFptdTR
	DIHO+l29eKixy9so7YV7gThOaK0l/4ywdrrcqobP9awhIhCKth4xxJH/WO8lSK0GJVjAWoqUpLi
	kaeMrYLdOSdvgTNUAwF94er3822vYZRWsM0bKR6vqyWFC6sXH7TY8xnaUy7WHRrIyuEs/Nv6NtR
	kZnyKcH3f08PCjG8gsbZ84BNSFFuDCld8O4YWxAIkEYnnLRDvlqpuK5mgGdbfN5S
X-Received: by 2002:a05:600c:6384:b0:4a2:a3b:7aa8 with SMTP id 5b1f17b1804b1-4a35ac3acb7mr134780025e9.3.1793032208691;
        Mon, 26 Oct 2026 09:30:08 -0700 (PDT)
Received: from localhost (p200300f65f19a904cbccaa7a4d73ac15.dip0.t-ipconnect.de. [2003:f6:5f19:a904:cbcc:aa7a:4d73:ac15])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48e3ecdfb8esm17396493f8f.54.2026.10.26.09.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:30:08 -0700 (PDT)
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
Subject: [PATCH v3 22/22] gpio: Unify style of various *_device_id arrays
Date: Mon, 26 Oct 2026 17:28:33 +0100
Message-ID:  <7a3aad753cd5bebe6dd3f05d72edff398920d1f6.1793030820.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.56.0.rc1
In-Reply-To: <cover.1793030820.git.u.kleine-koenig@baylibre.com>
References: <cover.1793030820.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3362; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=j/C3qYFYRthO80RC2ruW66dF5Huy3Fq9N8YWUVYu5G4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq33/c0ojVyzZ+u43M0bI2sq6g/5XGn+69FfExb 6JR29ElxDKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCat9/3AAKCRCPgPtYfRL+ Tu3mCACkeeZltd8ipKxsWv88vZPp7a51zX9A/QuTuoijhYbibnTnLrZgZA76jfu63MGJaQJGlqO RZ784GJXMxzbqjs80BfJAWadFOuUNepVzzvkgn3Y+A278UUH9Vsh3Mlb2YhbI7SHJQ3YleBzjj3 0BmtkMk6cPK3D+LwmR74MSGw0vDvjW0UzNI3hbPpG58wgMHfoHv3nny+SevlCB36OXOJ5BbzS+7 OMdumhFuzEkiijn3dxQybyFAvc5crrWIPu8XZmk9XvSGj3b2iMp0/LZ/YXGbHJqMg1xVEcbZTQ3 2HrFm6e6RZWV9HGnGroKYMqkR1OKXTuNCH+/gY3/+9skqw7X
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

