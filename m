Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A7121FF30
	for <virtualization@lists.linux.dev>; Mon,  7 Jul 2025 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874632; cv=none; b=T1ZZ7Sb+ll5ANZFM96J8HmRdf6OWUlFT+G9B/z880Gz0xQn2MUZCrOJeXH1Syg/c2p7sz6mvZtD+J0ZfvntR0v83f2KNrN5OO/pJBpoK/btM73xCLH9AA/Rxk5o6qdIk7ULt461nQzD8yNhquxO89JR8fQ7qA68HVT/yD9mFp44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874632; c=relaxed/simple;
	bh=DF8g7z93gK4m1xDXfctS3XNuY6lY/Bdhe4tMyGbYlp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NWi9mpCfmY2UxROJao/fUA5fSA6NwfEcn+hR0daiP7cY6umJ/KcSqhyJQ5x58JJzV8GMTHIyhnukxhIL8wIuH4WsmxtsuCMEcS+NHrttZNAh96JHWS2oSKsPzhZQoPpV4FzzOco6UokP0ehKUcZMPacldhMgfsMELHE9JflqPqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RaERm/ak; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RaERm/ak"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a54690d369so2769857f8f.3
        for <virtualization@lists.linux.dev>; Mon, 07 Jul 2025 00:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751874629; x=1752479429; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnquyqvd+FVIVtLd1Ux9gRwnVLnxC1Ivy7WluAJ5AJU=;
        b=RaERm/akrox/7tEwhtzurQT1vAyT6gaisBSSGYFiwAOqEVUKCk8h1dXFrMArDNts5Y
         taO9qjlcpag7IUS/W2+YtC+JaMqBjnNK+ecHKlU/jXZMgoJDYSh3Tdi/8OzC+hJEfs+H
         1qkjNGoGatCcMBUSAWg/A+8OFIPYERneI22uJrZ05SB/P7ukizfVVhmBAP6NKfPoDUfl
         wjRYj4e0ud+BvGvvCGCIn7yD8YEPsl6ztGdps689IbR9exorM9zNUTg01cCm1P4p2Ofv
         VsA63AuDcr9gv5MX61s5MR/uI8vEQaEQfBm9N7RMPghh172HNosBcnjh92opP3lGenOY
         f6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751874629; x=1752479429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnquyqvd+FVIVtLd1Ux9gRwnVLnxC1Ivy7WluAJ5AJU=;
        b=Nbt3IfzKQmwVBSOpIWO6AQaF35AEcehU3atioPA8H4apY2yrrBpiqHCPI8XEcMCFZz
         nJ71FwysxKvw+Cll29x+wZ5xFzcCgnaSlgtSq7Umvfj0MXJOWcR98wMJFtbkse8nyDuL
         Dr454C/eUF/gKFilaXwoArFUuR89opD/7tqlqWsH1bDTDnBGMF/xQzo6Lrh94U26+4ny
         yuF7UjZO59+G6kz2U1e6L2n0NJYULQCqLY+6aCcWOGWPdH3RWclyYpHhkQSwk1YNjZdi
         7fXox0zGiJh/x3z8CU/wvr/oulY2hNsmvVP+0COzpD/OWUqQ5TjTXNaNzYlRYf0Fy3jz
         K1UA==
X-Forwarded-Encrypted: i=1; AJvYcCWAeYZXAhNWpBkcrK3Gh1/TvYEj5X1p+Ry4kIIltNmRh9Ol+5GdBEZnGomTdGs1WO5old4EcG4YHQJ9oiYRjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOo/+HBLYF7GKAwE9iymfOWh31PJACj4ith6JdM7IKMZjkwRze
	AyO4mfmiYwWzQeCfArg8dyLoUHeGkKc4o4F6BIJiW1VF0Lrke5FklQg3jogt0mOUoMI=
X-Gm-Gg: ASbGncsl+CjknWZaPDxWOVDMuonkpr/WvTwmfOY2lbMXvXV565zVbC8TEMUbTiNjYMj
	72vupEtFGmiXQtMjcPC8GzXZUKp1aZJeEij1DWvhmV/5zQh04qwYomh044qIooCPFLcOPa754eH
	V/MXwcG9oZf2oCVvVVoS5SpFQ+vi4nieupIOzCNMqMAVNprW7aanywtcAxfZBy8uydquGyt7ONH
	Am63XaNxB5c/M6y+in1kbb0rvP1vLXmSOafHxayQ60akRCjW58NeKqm1ffXBchP4ZO0BSU2HhaH
	oOeY+8K76jzJZ6vGkj4SQhGSZ1z4XLNhKI8UNxYiWbYPtyAqT9g+NUyy
X-Google-Smtp-Source: AGHT+IHgxOKlD/HCW2fuVG89O4d1zyNRJfWgVpguHMzHEibk0vk9GJEv0seQmb613A3MAdd1OnnO6g==
X-Received: by 2002:a05:6000:18a9:b0:3a5:2cb5:63f8 with SMTP id ffacd0b85a97d-3b497029583mr8019614f8f.29.1751874629034;
        Mon, 07 Jul 2025 00:50:29 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3cf3:a61f:85ed:69db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1893479sm104215455e9.39.2025.07.07.00.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 00:50:28 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 07 Jul 2025 09:50:19 +0200
Subject: [PATCH 06/12] gpio: ts4900: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-gpiochip-set-rv-gpio-round4-v1-6-35668aaaf6d2@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1694;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Hxwco5xikujaT/ZxkZ/bggRaPqpzZXsQM3Uycdv2rNE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoa3w6jCJ38rKBLEmVT/K9IQDFTn/kWS7yzy5e+
 8+YcbST3eSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaGt8OgAKCRARpy6gFHHX
 cmJaEACRTemPq7dQtszLFYGQQhrB8GbuvRBdwmylDUTUzHrV0C6NHTU/ixPtpoV82APcyrZBhoA
 IaeLMDdzRNCMbbppt5EVyfM3nMcxuXYbynZ5TqSETkVvGWRD0PKDVcB0uguMi3/9AGgztW+93S2
 1ULcFIewGcEFwSAMT9jPQynovXVkg61ZXo+ag8i/ZHKM6ARelvwNFXZC8itqc6duqYu0RrCZa4x
 h8GYZsy3uDIPyqlBkdo1sMQTHr0/mtzzpfoI7ej1PZS9bdh/wrA7J+QsyMHSDWA3vtVlxF0OryA
 nbXpATzt5JDkV5XP0cih30xwTD/AdEfsbCCPH/7bPVxHLnGC7N8q43eYBjEsQYLUZ4l4j5p/rkW
 duJ/fTvLljmG6LgPNWmchFPUUmum/gk6JSQm8YGGOAEeRFjBsLuLMVGOCUbcw6BeCJBgC6ZPoW9
 rkLqRLCW8Ut0txVrIjT9GM6vGuuhNkjSq9sq9S629v/BchbbBqH3PLaVoVEIyL3RUtVTuFFoFjf
 8hFON6qCC2J+k1O7URKJ23Z5spVoUEJLuLlwY1pyfiVW4bHpplLH1y9RgylYZ8RJTMiPQfHCTI3
 WnZ4OsWJihB8iUPMtsW8teAk7g66+Xd3TPqUF3grAcJgLyc8qrsJCfNsINEmwC10yYtCL82Yfnl
 UisioaJnKelhkhA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-ts4900.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-ts4900.c b/drivers/gpio/gpio-ts4900.c
index 5c806140fdf0d6e60f2225824aa18d393f61b607..35dd2d09b4d441256f01d9ac762dd3a2f0a47352 100644
--- a/drivers/gpio/gpio-ts4900.c
+++ b/drivers/gpio/gpio-ts4900.c
@@ -95,16 +95,16 @@ static int ts4900_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	return !!(reg & priv->input_bit);
 }
 
-static void ts4900_gpio_set(struct gpio_chip *chip, unsigned int offset,
-			    int value)
+static int ts4900_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			   int value)
 {
 	struct ts4900_gpio_priv *priv = gpiochip_get_data(chip);
 
 	if (value)
-		regmap_update_bits(priv->regmap, offset, TS4900_GPIO_OUT,
-				   TS4900_GPIO_OUT);
-	else
-		regmap_update_bits(priv->regmap, offset, TS4900_GPIO_OUT, 0);
+		return regmap_update_bits(priv->regmap, offset,
+					  TS4900_GPIO_OUT, TS4900_GPIO_OUT);
+
+	return regmap_update_bits(priv->regmap, offset, TS4900_GPIO_OUT, 0);
 }
 
 static const struct regmap_config ts4900_regmap_config = {
@@ -119,7 +119,7 @@ static const struct gpio_chip template_chip = {
 	.direction_input	= ts4900_gpio_direction_input,
 	.direction_output	= ts4900_gpio_direction_output,
 	.get			= ts4900_gpio_get,
-	.set			= ts4900_gpio_set,
+	.set_rv			= ts4900_gpio_set,
 	.base			= -1,
 	.can_sleep		= true,
 };

-- 
2.48.1

