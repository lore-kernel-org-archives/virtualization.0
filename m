Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F47B28A1D5
	for <virtualization@lists.linux.dev>; Mon,  7 Jul 2025 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874627; cv=none; b=ZTm+qHPFhsADoWN09v2StujshB520jbsGYLFZmNXZkAvEkwpf/gigSM/DbA1ADazBZE3A1ZT2xG6UD93VSlSl3z0bck+cYIjz0C0ok6xRIKld4Dr6kUJqKyn5sCl/Vunkjmyi9siXlFGm3OrWXccx6f29Tzk8DubWsEtqaeyuG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874627; c=relaxed/simple;
	bh=o3ttjvWaE7oBjAWT5UQDQCptRYAsYF8S/9c+FjxVKOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VIMGrb7noS3FYzbsc34zy2TTG3JmTNqG8ih+qsQcCy90SL39cUEAEDaW6TjCyJ2Un01MiLH7ZNrZhT6anX3Mxbaui7PhZwJIghxmHJlLzUCY3o9i4fQ6YEsNuHBUMbObOxwDnaRhvpm2TX7F1wjZyPvjfto4vvl+w2+QNW41qr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kJSDuc3i; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kJSDuc3i"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so2300089f8f.2
        for <virtualization@lists.linux.dev>; Mon, 07 Jul 2025 00:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751874625; x=1752479425; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5D/gCx91/Y//En9n7QYQnwwJaerz4uwu5zS3XJUkJg=;
        b=kJSDuc3i3OOcQFyWMwvf+2ijYIwImrP3eDkXm6pmfKEsVEMHFOxo/7y9Hnd90k/hk+
         LGa/7Pjqapi/vQ9bRlSx6HvrxjRQlokodCf/iLCK0oG/VEFAXTi9lk6+a2SFhB8uYLX3
         uU5zx8b7lT3MLn9myBpav8IQb4CCymyvP8XVfFYIrH4QBvGihJd9q2NI5DL3S9D0EA+A
         DVDtLJ6KKXFVmWw47DC1gZuYX/YeczuSPkEgzUY16aSF7+7Q6/vY/1RUx6muAEeNsBRJ
         SVDZC8kE3jeSfb9HIYu25a5htoK8rtmwfF7uRV50CEYe5C2T5NSTs06jS8kGFmfuwtxL
         4myA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751874625; x=1752479425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5D/gCx91/Y//En9n7QYQnwwJaerz4uwu5zS3XJUkJg=;
        b=H7dYLd2FRNXNoyv+Z8U13os+uIksOS9kSsc9vI+HJcWyfT/ExA9+cBtoaKEBwLq4On
         dx5ffhd1juf/Hwu0ZxqDbE6pgODUjwQBZWQk+zdJQsnJJP89W0pbGF9mR0iDUifK+VdI
         rEs4VGvwrgAX2x/c5dnmew8a7Uj8HtzvCp9WieFMFTQUL2xJuIKdnd2RC//nrDdidY58
         gnPM9u327bZZn0fS/VD6fgs04iQonY6nXDW6SMrj3bhvdg6MjphftIfAsLdJESowsnlO
         IZsckM6wf0H5Xy/TMCVtMWCbtAsGczjg9RbkmV2fkmMpQZSZH6CFzArvQkK6XM8qUFiT
         gAgA==
X-Forwarded-Encrypted: i=1; AJvYcCVYIaG7YKMhgNdg0bWGVq4T9zIH1oAQMsACIftmfmaLMULfadyy0AcZvE+AsRVfNoJ4o+ME0NuNSAHCU6L2nA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6zYenNOCfg/Z6hUq82C+1SAjxbKTNvtmTxCv18z4lSqcKc1oO
	Kq9cgrXTodr87dotG/h/6Z1EyGSZdVz1YjvKxy/Ma9gsVIP0kZhWjkwyuMYqdGu+ZpY=
X-Gm-Gg: ASbGncuvFgc2rmCNFwnA2k9SmrFLYbGsK6scYQviTR5ucelAzHSHRCxYWzBt1Fglg3f
	5UphDwakq7O9Al15f5HZxOCkLSlz9nV7sfujD3Moj3qQWPxiUflFUGZQOdzyLuycLGuvB8YBi06
	f/b5IqVmPIbCzWt+Byu12qxsYYlHqx10yRLmDMl62n9sKU1dMPJljyV9zs1ffLum1YaFfp2VkRa
	AGmmiJJjGOv0EEtJmSks+pheXXVV9oTC87nhZLJ/q1kFGiVmgun5mcoHzpAyjcStRZ4LjTnctK1
	29vxvI+mH/1i+bbWuAB1TZ1OcgoIGX8PpqPwRAb7c9jFFHcJAPQqAtRI
X-Google-Smtp-Source: AGHT+IE9q3D6H1GQiSGZ7AcHRsGtYbQq9ZPf0BYDp6zHpmdTX7TwrerIwRMk4FYZqkacGFOvWKLeNw==
X-Received: by 2002:a05:6000:1788:b0:3a4:f379:65bc with SMTP id ffacd0b85a97d-3b497038e7emr8999552f8f.40.1751874624545;
        Mon, 07 Jul 2025 00:50:24 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3cf3:a61f:85ed:69db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1893479sm104215455e9.39.2025.07.07.00.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 00:50:23 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 07 Jul 2025 09:50:16 +0200
Subject: [PATCH 03/12] gpio: tps65912: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-gpiochip-set-rv-gpio-round4-v1-3-35668aaaf6d2@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=njAvtdVnxWRlINwsdw8tywJxxxUNxg5ByBiqLbpLFkc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoa3w6MMvFmoVqaXM5v/0/S4TOBonUxrVRC0Rfy
 oCggMgQFOCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaGt8OgAKCRARpy6gFHHX
 csJWD/0e0mBypz9MzWTZzbT4hEw7e0gkI0Ba1/PVBmUVVodHFTL3Stjt0WmK646DDRMpHqBHTiY
 Iq9ZzKlhSx5O2rvppnDdI/MzSktt0Lv3hl4GO6zPP9WBYvdv6LBfSRFi2a3p/lUV6api0DmI+s2
 PISctwGoDbaZnZeOTYZ981yBhivTw7yjHcMNVFPMMnPfHG5D96v1ONuWJFgEuQ3x8H6DVTDJLMK
 qPgqpOLr19TG2cLGAeEui+ES+KxO+OgrzsSTuz9ujFuCtRhLKU3cXLcQof2fx9fwg/cHWlopiTf
 m2HJYDx/jMQIWHsiwjOaNjjmw9Le4rwzjvUZUR2QhD1Sjh6QJrGiU+myMmijns5Xhd5+LB7Hc9n
 hJ2rPXYZ91ttj1Ozdee1UOwXBBsbLYDonURUnLr4Re/6nFMeYKjYPpAO1mLV0amLGLXzv/X/1+L
 0BQroNJK0NtWuTz9hZ/RCkyKxvnjWazk83nQtoE1guYFenIfZzKeMNn4ogIbzT5a1/4R2VxzCEJ
 IlKZuHBNjtx0/J8Gtqzv1EkZo72E58dgRnxmzUSb+zxNYbKTtIsOxbEqVTeC1YVEF4bWfdgEP1Q
 U7IRchb1/aaSwRZ09j2dPlDS987IdvdVB3gySxb0S2tQxyN/vd1SbtrGPxXizFKMr07xx2eF+SO
 a1O0y5m9g0Y+bvg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-tps65912.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-tps65912.c b/drivers/gpio/gpio-tps65912.c
index bac757c191c2ea0d103eb0577710065611fd79aa..d586ccfbfc56c17ca18f5c2b04a807305dd66890 100644
--- a/drivers/gpio/gpio-tps65912.c
+++ b/drivers/gpio/gpio-tps65912.c
@@ -76,13 +76,13 @@ static int tps65912_gpio_get(struct gpio_chip *gc, unsigned offset)
 	return 0;
 }
 
-static void tps65912_gpio_set(struct gpio_chip *gc, unsigned offset,
-			      int value)
+static int tps65912_gpio_set(struct gpio_chip *gc, unsigned int offset,
+			     int value)
 {
 	struct tps65912_gpio *gpio = gpiochip_get_data(gc);
 
-	regmap_update_bits(gpio->tps->regmap, TPS65912_GPIO1 + offset,
-			   GPIO_SET_MASK, value ? GPIO_SET_MASK : 0);
+	return regmap_update_bits(gpio->tps->regmap, TPS65912_GPIO1 + offset,
+				  GPIO_SET_MASK, value ? GPIO_SET_MASK : 0);
 }
 
 static const struct gpio_chip template_chip = {
@@ -92,7 +92,7 @@ static const struct gpio_chip template_chip = {
 	.direction_input	= tps65912_gpio_direction_input,
 	.direction_output	= tps65912_gpio_direction_output,
 	.get			= tps65912_gpio_get,
-	.set			= tps65912_gpio_set,
+	.set_rv			= tps65912_gpio_set,
 	.base			= -1,
 	.ngpio			= 5,
 	.can_sleep		= true,

-- 
2.48.1

