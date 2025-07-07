Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ABB28C5C5
	for <virtualization@lists.linux.dev>; Mon,  7 Jul 2025 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874633; cv=none; b=ZySSMw/KPiCmG1HtrMEVFSFOgu5HRWUAz0K2OjRx8y1NDvNk2wsm8qQaZgUvY2DvYV4Z5tMHy0u+u7OIVw+ah2MoNRaH4T0j1Ur3xCcQ/sN4DCwYv9YipAZ2cVpl2fQ4PUo9KnkiDKC6zJ8opv1ofyDvplsTNjUqgxkpGLvB3Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874633; c=relaxed/simple;
	bh=U+hDqtuMZ6JF+OOfTMalSXbSfzKpjAOm3HctY+nthUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=goBnDhj8sFCT1mFjBV5JwgLQXXNT14E3Q6OdlbcoX4BjDQmZPPWRhGTnAyWlQ0ORVAW5vK3r0O4tgrYYRFAQd8NezXmvN9Nng82rmTpbsOQVvmNxEcAKD7qmxf4Si9bYQzncNxei9XJ+t2Cy9sCsgLYo0p5fmTAzAlu8YMhb6c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kA8LIdp6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kA8LIdp6"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so24881245e9.3
        for <virtualization@lists.linux.dev>; Mon, 07 Jul 2025 00:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751874630; x=1752479430; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+JA5hCDJONRdLbjJGk+bpg/C8XRBbWfR2uFkIyaXac=;
        b=kA8LIdp64SEkmbhzkEqW1DQ811z66BLdp+VpjuSzasbZxOILVbVJmjvlzM/9RTy6SM
         nZTBVf9bwPBlxlJ1kmgA7uVq3KP2Qizz02UdsWgAgVHraXVtILddd1lyWmCROMJFJpDH
         qJCoLi1+CI6WnlQV17FCTF67EMlvfWc5nK/gWtDiqz2zUut4sy+l4lXeYOVMzK+y+S4p
         dd+7PyDiyYHfloYqX+EXI4NI4Ij9eGUMKgTmsYe3Vke0dENFYJ88hN2ROmBxtwWx43y2
         A3yD4w3jGvOC+3H1jMCsRUhanNOhw26RA7Kpw6WyGeEkSTViqfq6L8FgI8uXQIklrkqR
         MXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751874630; x=1752479430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+JA5hCDJONRdLbjJGk+bpg/C8XRBbWfR2uFkIyaXac=;
        b=Sl3vs8XbK5qCHjJdjQkYKfBsgDNnRFJ8+rXfIGgmsJzUS7mdofJnwqARLNYAqH0+4X
         3TqGl1Cc5x5h1weNuMXUOz+hUNlm2kVH3ZAdZsKiev0a6Su5JzM+4Nxsm3EBQo8X46OZ
         Ew18RUQFIZWwti6SBpjec0nOSLfqGsikLECUU4NqBB/G21kQXkfPGLLd1gwouvWy81lN
         j7SNegD9rfIDTLkKuCJu/Gyy/+lvARLibTexwjXJOiBMxElgqslXb1qXoLn7xQn2PMDu
         C3Dqs1i2x4nw00hz9tefg74UWNqzQQ1L2LEBBF0S8Qw+x9yvyioFnWfHeruJQF3stXoN
         qZUg==
X-Forwarded-Encrypted: i=1; AJvYcCX8pnPR/QkN5qvxbF0ULwZduJoHTqf2cF31/g8B0VL5XUkARfoMdHka2moaiOQ0OehQFO9WcbvB628ve0wOCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAI3qvrOfIYmUIDHDFFDvYtdiGvclLanbbDDL/qt/9jB93rf5S
	2GlmUUx6Xx6xiEy9qVuxzKFj6jVrkqZQuFphE0NQTYLk81vIQJmZbEymWE6zy2B1WvA=
X-Gm-Gg: ASbGncuOV1UCDyTpp/ehMniai6DVS6AlEOip/Vu+fN5ErJIFJO7XcRHC8hUqVjDqp2W
	h30DORlvWPCuPPmP+cEpZVN7x6aoSLmmPnLKA31MAcNKx8rge88bhfdNpqO5v0WGaf7vVzm/iCs
	PA4aZwwaaOa9O9bqx1sx+do7oipxbol5n11SSH2bZ8qlAoi9WiVCoN5OvVAOzSYG6+Kb3Jqh/0g
	+YU+wuVCa+vh7q/H3UelHZkc1iye0kfycaffiYsJvBWMUdKoDMdvPgVeUrQJei8SIkvAxXYC80T
	3L6DE0+sYPF/G0EVo7SvctwmCgaP5ifmHjNeSKOklLA64LVw8aCh/BFS
X-Google-Smtp-Source: AGHT+IHBlhSVc9pwEwajWE6AJVXz+4dQ6VQo86G02JHQBXvnIQfQwXZfMZgi+u0WCVRbP0X4BD5n/A==
X-Received: by 2002:a05:600c:630f:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-454bc4a5dbcmr50148525e9.20.1751874630164;
        Mon, 07 Jul 2025 00:50:30 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3cf3:a61f:85ed:69db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1893479sm104215455e9.39.2025.07.07.00.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 00:50:29 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 07 Jul 2025 09:50:20 +0200
Subject: [PATCH 07/12] gpio: twl4030: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-gpiochip-set-rv-gpio-round4-v1-7-35668aaaf6d2@linaro.org>
References: <20250707-gpiochip-set-rv-gpio-round4-v1-0-35668aaaf6d2@linaro.org>
In-Reply-To: <20250707-gpiochip-set-rv-gpio-round4-v1-0-35668aaaf6d2@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, linux-arm-kernel@lists.infradead.org, 
 virtualization@lists.linux.dev, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3195;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=3JDOrR9hQWFdJNurWCS9HHF9izhub7RSmsduqXEIo4Q=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoa3w7CxXxYgJaTdua9NdZqS9G8KYjVQfCYdNfk
 2GOraQ2CeKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaGt8OwAKCRARpy6gFHHX
 cqxYD/0aBgjkJNPm4W7AZUCumlwmMA0qFydna27fs9jkLYlIrVJtgngogU+DST19V5q6cnDiImH
 wwW+TreR6ojk5TotayIWj/VbBFKk11n+zW8r0R1Tzzqw+LzNqcwJcwUH2OXciSY7ymP/Ga7K45o
 suOmzS+NUqpuZSKjgGBg2IOgZVOSUuPhwDw1NTMFcQ0/5unrA1oPn7bsfBs219WYyre7nFEoBdv
 nzB0kOdXwd+vqzVdwjOfjOlDLw6NI2gkEvuFCMD+vGemXldP/ZuX0WGb7LK/mpssPNoCokrvqai
 QvjodAJCSkKLbS6frryk7/ETMYFnFPvpxEPwdc5dAj0sGrBi6H3uwBYMx9D6h0SYKVv/9skpe1v
 sVfO+vHdDoNN8SRtawKAjZ/DGAhlD4N4kxKF2mnen8xOwLZy1z8mSCYQaWxGZzStQB1W3aLKCLz
 +B2IEG26H4uIesiJWUHUdUDopwBrp4WlKdJQK4A6vEJs8U+V5eoHdGB3Ec+ZGeQnk4WmOg4ogRO
 +TkZFheAA4BTmwoCZutj8iaIpui2gifmFl8o0Rbez9WNv4lQa6CEIt5B8/BP7RgqL24CtHl3ono
 m7yBXe7J/Yz7aKLhlMcuvrSy7H+5AF0K5YB8GlRfviv+XZyju9xUNXiyUDWzEnaxaLP1KwAilMo
 vfiX6GFF8XIxngA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-twl4030.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index c5d7825f19c18bfa84083aa5a46e48d174b8fce6..e39e39e3ef85b7c60c1f29f78c11d6eeccec6206 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -120,7 +120,7 @@ static u8 cached_leden;
  * external pullup is needed.  We could also expose the integrated PWM
  * as a LED brightness control; we initialize it as "always on".
  */
-static void twl4030_led_set_value(int led, int value)
+static int twl4030_led_set_value(int led, int value)
 {
 	u8 mask = LEDEN_LEDAON | LEDEN_LEDAPWM;
 
@@ -132,8 +132,8 @@ static void twl4030_led_set_value(int led, int value)
 	else
 		cached_leden |= mask;
 
-	WARN_ON_ONCE(twl_i2c_write_u8(TWL4030_MODULE_LED, cached_leden,
-				      TWL4030_LED_LEDEN_REG));
+	return twl_i2c_write_u8(TWL4030_MODULE_LED, cached_leden,
+				TWL4030_LED_LEDEN_REG);
 }
 
 static int twl4030_set_gpio_direction(int gpio, int is_input)
@@ -278,7 +278,7 @@ static void twl_free(struct gpio_chip *chip, unsigned offset)
 
 	mutex_lock(&priv->mutex);
 	if (offset >= TWL4030_GPIO_MAX) {
-		twl4030_led_set_value(offset - TWL4030_GPIO_MAX, 1);
+		WARN_ON_ONCE(twl4030_led_set_value(offset - TWL4030_GPIO_MAX, 1));
 		goto out;
 	}
 
@@ -334,15 +334,16 @@ static int twl_get(struct gpio_chip *chip, unsigned offset)
 	return ret;
 }
 
-static void twl_set(struct gpio_chip *chip, unsigned offset, int value)
+static int twl_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct gpio_twl4030_priv *priv = gpiochip_get_data(chip);
+	int ret;
 
 	mutex_lock(&priv->mutex);
 	if (offset < TWL4030_GPIO_MAX)
-		twl4030_set_gpio_dataout(offset, value);
+		ret = twl4030_set_gpio_dataout(offset, value);
 	else
-		twl4030_led_set_value(offset - TWL4030_GPIO_MAX, value);
+		ret = twl4030_led_set_value(offset - TWL4030_GPIO_MAX, value);
 
 	if (value)
 		priv->out_state |= BIT(offset);
@@ -350,6 +351,8 @@ static void twl_set(struct gpio_chip *chip, unsigned offset, int value)
 		priv->out_state &= ~BIT(offset);
 
 	mutex_unlock(&priv->mutex);
+
+	return ret;
 }
 
 static int twl_direction_out(struct gpio_chip *chip, unsigned offset, int value)
@@ -373,9 +376,7 @@ static int twl_direction_out(struct gpio_chip *chip, unsigned offset, int value)
 	priv->direction |= BIT(offset);
 	mutex_unlock(&priv->mutex);
 
-	twl_set(chip, offset, value);
-
-	return ret;
+	return twl_set(chip, offset, value);
 }
 
 static int twl_get_direction(struct gpio_chip *chip, unsigned offset)
@@ -418,7 +419,7 @@ static const struct gpio_chip template_chip = {
 	.direction_output	= twl_direction_out,
 	.get_direction		= twl_get_direction,
 	.get			= twl_get,
-	.set			= twl_set,
+	.set_rv			= twl_set,
 	.to_irq			= twl_to_irq,
 	.can_sleep		= true,
 };

-- 
2.48.1

