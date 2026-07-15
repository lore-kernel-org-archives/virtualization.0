Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACD84BC020
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784134594; cv=none; b=WisHf2h/qSKWN8z+s60mgCaVoF2BxkbSdbOaio2oj5jHArF85GFZXincT0EDEaqeD6YSdLvI5I5WcAngElV/bOJ6en56iceJ+AiotO/2Aamg6P35YyG2unMbgbGeG8NI4bWKRw+TxUDpZPhNg9jtPuYfJ1qjKErnUnBdDRLEq2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784134594; c=relaxed/simple;
	bh=qeMqNCPR4JZWZmIFkke1fRMQtsN1pMrftafnXla94ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+A4h2FJWGIT4c+gjwi3U7bFEJNySOl1aTmBq5L4tBBChbDnVG5V8NhhyJysjv5uHSSoPPvTW6NM9aAdDcHkL2hSiImxagJ/04aevEdyqqt4bLqA2JmWVNqH8y/lSo4SlOEqy6SoNtr898hFWTyH1HXQ+04J/XBgnL58knYmwPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SASjAWtB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="SASjAWtB"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-476a130c138so2319613f8f.0
        for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 09:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784134591; x=1784739391; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0YbKISqvDXzDxXFBLILdiprJK/dXdWku3hILu+bMdhE=;
        b=SASjAWtBAjiL8a+y1045aQ8oOfOmWqIHAUsYsrurFGG5y4FijC7QZQGFciLImGU8NV
         u3Panw3LAdoTSsXS9AXwJywpd0cwEfjJIifP+OHlCtMcDRbgmW3LrgMUUlqemhmSKBHE
         wImVvdDGa45A+FLyMp6jWT57TPbn5KNgdpQBd103T4JD4wsLR5ciCsnzWygdELCnSqrT
         PdUqXtkbkOT+CgOKUvbcz2WmQnYdRhUM/AQlJcHQC3wKc2ss6CwsBNWo3nvpInLIraYf
         f9q2QRcpbmh4RFHg+XkjRErNKnRziBvYVufJ+NgcUK8HTq6GBdMvn5k54hRMkh0j3oJ6
         0ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784134591; x=1784739391;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0YbKISqvDXzDxXFBLILdiprJK/dXdWku3hILu+bMdhE=;
        b=VCdF5kEiTHCx5Dg3mdLPUIs+ukBj3TV0BxM1w55u8VEGdvr9fnV9J2XO9XsWfGAwqQ
         kxM5KgdbcNKXJNVYA34DRtxMnbNcrD/xOS8gTB7vq8FFuDzJIEl1vaGgFARuhJyPbToi
         nL8m6Uw9OwNSDSQBzzlsOLUVQz72ZSoXfTRvxrMajFfrWRYEz4SYT99GPsHLNoK8Exdy
         M0nMWIj2eqjgVcF8qEO6zVBO8jzG1Sh/QNO8c089MC3sgqkpLzYmpm2uwmTjQZGSPLfD
         tFWrzHYmncftjl8pTea75yGXOEMkfcwY5QVHjhAezGl5/n008ovb4pSmtG2/VZLNdPKN
         1mjw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6MWl5sNwyGqA3XFVmdMZTzBMzIrPBP1UpPRAdVkoqTFQ1mXSbPl2YEpZhlplC8wihMIsnkZ26PdTwYPuPfw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2Lsy3UFhk4KgFaHulTiYTZBSwhAcrbolVZGqOy8EO5e2y8JFZ
	YR6PSw06tmFHI4kAKg6FLTuTJ8i2ziMHN4SIWjaofm4oY/6w88Pu44vs/UVsBV/EAbI=
X-Gm-Gg: AfdE7ckB0SKYCFPIy23yxf4BNTs0DZNByNE/PmjZqxGJ+xSVxVG7rw19Fl8EnPya8Sm
	8GG7pHENnA41eXRi5h+p8WuNzMIURlwNLnMJIK9qd5Q7Q2VcihODtkqwevc7siUzNbfTKAB+4fE
	IB5SngvkwsF0WR7XSz/iyWOnj1jFpHKIEdfhM4BsmPViopi01x5g/JNDE+B9iuhl50n3tasJ9nN
	6WzyOxWoGQed8zgl9xqDmiI/3plE1RPXYEUOYPwNBGYC2EGJSo8rxtdlJ+3dctdmnCMbugoBTiA
	A9BVpHTH1v5Vxo306D6uWwzSjkYL0hkrbBVUgEeQHx76JD/4hAKT3O1U9Hr4wdhtmJeptNNwQj+
	AusD8siNsnOMJnBoDxnmp2VoBCuq+035CDNY5AXZRWsk6IL7PIO7d7BZLRxftZs5B6vk1W8TEhh
	HYnr9kGXOvYz8WM3xmEFc0IicTmBMZdx30fI471PJd/CZsICPQNHitm3ru7uvmgJNOt1sY6+vkO
	qo=
X-Received: by 2002:a5d:5f45:0:b0:475:f100:35fb with SMTP id ffacd0b85a97d-47f2dd42e56mr22174405f8f.56.1784134590979;
        Wed, 15 Jul 2026 09:56:30 -0700 (PDT)
Received: from localhost (p200300f65f47db04249e031dea91a10d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:249e:31d:ea91:a10d])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f464d6fa7sm17882394f8f.37.2026.07.15.09.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:56:30 -0700 (PDT)
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
Subject: [PATCH v2 21/21] gpio: Unify style of various *_device_id arrays
Date: Wed, 15 Jul 2026 18:55:26 +0200
Message-ID:  <74f18045a53d99047c5c2cc83d970b5b429dd14c.1784133987.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1784133987.git.u.kleine-koenig@baylibre.com>
References: <cover.1784133987.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3442; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=qeMqNCPR4JZWZmIFkke1fRMQtsN1pMrftafnXla94ZI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqV7uch2g9AnBq1MR+kOpC5ck2xFfv/uUZWPUsd dNPkiBW/PqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCale7nAAKCRCPgPtYfRL+ ToM0CACLAvIimVfXS8xTho2bAKb8xdVegyIEW1xqvduBfKnWYNQHbpxbenrwDf69EjXN9Yp3/Ca +Mg5ERVlDCQemWelrhbq3sq/MCemWG2YnPB6Uqo+96bx4RG3YUzxi0poqp8VHZqjhETsBmvbbyP r8rKwus6aIFV6pbAm/f4BE1MhP8yxnm3TEMvUpUK28jcJxbpCIT69TKqwZGnrM4V7sbC4ClMtMA UJR9JO5nFu9Pn+bp/5TMBiJX6+WvokZmkDKNgH1PjKl0qX3MI6L5WZ6daFTkkFlCR54I0lQF9JL qEMgBzYaSdfrXDpvYi5Zjbtttg7vqYMoTs7wtT2QKc04sGzb
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
index 918cadc2db07..7db33477faf1 100644
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
index a0116f004975..7c5817a3157e 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -392,7 +392,7 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "VEN_0488:00@355",
 		},
 	},
-	{} /* Terminating entry */
+	{ } /* Terminating entry */
 };
 
 static int __init acpi_gpio_setup_params(void)
-- 
2.55.0.11.g153666a7d9bb

