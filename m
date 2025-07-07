Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8F628C2DC
	for <virtualization@lists.linux.dev>; Mon,  7 Jul 2025 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874635; cv=none; b=V0FGGX5WDiNwRb7QbM6W9H760DAbTMoyt5r6AdvMDs2FzUKyF3SQgOIs6lOzZw1j/1X2ELSXpoMTwPwlFgZf01xXJjYaTQypy4mEnXTG9OQbIPYS/1oermGFZOIR6KfOOgf1SW7z+/L0tWHqk8mxTieDSeot1+bmdwM+mJiLx80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874635; c=relaxed/simple;
	bh=bB+qdsup3HKdiJRxvtUZ+z4bOpAuwrIw+6PCi56KZQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f9d9HiOZMH0DhX/+4yvd+iagiQ2LydBLiAYLG8fflFAAG31RqjGCb/21Pr36ARXWlDt7H1C+SqzFLPKYLEQuRyriTpgtyqUJlnHaAf39k87xGZBInZ05rdwBvNmh50FhbimpwUfg/mGZGMjGR26VXDShhWF63aTH0BOgI/trLmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Ko1yDnOW; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ko1yDnOW"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a54690d369so2769903f8f.3
        for <virtualization@lists.linux.dev>; Mon, 07 Jul 2025 00:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751874632; x=1752479432; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IrEXsrmsMuzA+1ugG+tl/Uw8h+zTajU0t+jnzMkT9nk=;
        b=Ko1yDnOWjkessfuvWsIUkHJzEw1KGzy5vxGBxshh0Obh9EuaaLGTJDssv3uIRs7pw6
         3+abrub4Qi1Mrg6vCphA5B2wLMzPThBl4qU725QtaGtqhjQxSJtXwtUyOm3LuFwvN2x8
         Wn1QkFmzMNMZkOy0ZR3ICsNE2O20neZldBMyj+kNFrc+hFzRxTvecje8gXOjEd3clm78
         g6QaUrtQwxwBNO355rjdTlvgACq1KDhSEYy79cjAC9Gc8wpzvIN+2+WWLwmNOKFJ3XKc
         lYidT5zVBveneUGdWjc5hawQI73VQZuvu/bxaRhovsHSkCTIynA+ItbfZs1WFKZaLqK2
         OT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751874632; x=1752479432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrEXsrmsMuzA+1ugG+tl/Uw8h+zTajU0t+jnzMkT9nk=;
        b=NneqMqnSXqgU6mQloT5rcmeEtM7mKZOW9MrC/JcKCU5bYhEB+7uk0f9pO3VgP6YfDT
         xXBtK0qIxkwMHayDPyhZJSqrAZnACH8WALfh3rs2sEWFJhx8oIQL8GAzu8uz7RVjkq2B
         SRbz4f5rSGrLXr54iN71mOeZvfIlrL39OGCikbUh152OOJaDCiqJ4NwsQx9bi/jgdx4/
         1QtwimiC7ejp/smRd8jwZcIyS5FfrtQLLNKIyr9PNyEdnXWWhcW/j2CaXOHaTQt7q+Dj
         Fo4ZJ+dOCgN4Bv5NJ4oaQQCZjQ2AHCFEOFAWEOxDZ0nExTOe2o/kH25Iyw9RWXJEKV10
         fzqA==
X-Forwarded-Encrypted: i=1; AJvYcCVueUIziRkqYb5ebKpN6GGT6HpUJ925dg11GWEAwBMbVtWc4lt7FQGKg7lCx9zbs6f9ZJecoD6VG9DUURAnmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrMlzr7qAbui0mRIaZh5x23cw0sM7HEzuCd1KcZjkoOcvpnadV
	2/4LgIhU8E2bv6mxkgI84sPseYd4HIWA6NnQgC/9FbHmqvz3sb+rm75LqXLym/64yZ8=
X-Gm-Gg: ASbGncunXSTps/z4/m6LYVlOnqFpxa5TMJ7WyUPGqEZONzhuGk1E/c7BA28LQItr2pF
	4eU3iNsRSIFNQYi2qLegOzEwS0LAiNXERzFL6UA0exRJMYbQ6jeBIc2Ah944DG2NLvsbLMDrV8E
	UYnLRZ4TadLRfshRBEUvr686IbcrH9OOZeQLH9psGq2r4s+R+MoeaHrpL9i3nROcbTZidVvUy/E
	buklrpHQUaKiFcwSxI3xHbLMTYbCstetK0bd2OKAjs00RJzC9KywekSdaDL/TXzJQ/WJgOXY6mp
	nyimGiWLKML8jkhvqkzD3P2CWVohgzbWJGe37NIqAiKwBpFaobqrVYqG
X-Google-Smtp-Source: AGHT+IHws7BTgvMwOHb/0fBxy+8f3J4P98k7LhETEkFH9aAE9cXx7D21DbjCELzGj9RNQtFyairGWg==
X-Received: by 2002:a05:6000:2008:b0:3a6:da76:38b0 with SMTP id ffacd0b85a97d-3b497013ecamr9654486f8f.25.1751874632251;
        Mon, 07 Jul 2025 00:50:32 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3cf3:a61f:85ed:69db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1893479sm104215455e9.39.2025.07.07.00.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 00:50:31 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 07 Jul 2025 09:50:22 +0200
Subject: [PATCH 09/12] gpio: twl6040: set line value in .direction_out()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-gpiochip-set-rv-gpio-round4-v1-9-35668aaaf6d2@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1456;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Ny+P9Gso1Z/D1GfvAgTj4CRCkIVwJInh/rnW4mX9aZc=;
 b=kA0DAAoBEacuoBRx13IByyZiAGhrfDui2kwMyLze1B+VgydmH/CxA8d3hCROGBTtuDeM+EhWN
 IkCMwQAAQoAHRYhBBad62wLw8RgE9LHnxGnLqAUcddyBQJoa3w7AAoJEBGnLqAUcddyJwsQAJux
 AaGxAEjlCH5FUm7Nx9OKDXdHlFxNrkFQ9QNylf5YpMHGmZ30INP3Is5LpN9xuflbZSf4KsYfYpQ
 xk3/uhHjyszowQ8Y3fENt7agn/Bk8GER5L8WbW21wYLgDWNKoSgShgk0DhkwIpDh+hOqZRXzrep
 q8lnDX5prFNHSG+b/63ZD+NovstwhNvVPg+sYHDDJHHmwrXuyuMziumwH9XqXo4xD8b1bxpsIkR
 oABQK6RNtQddFxJCiCCpg92iodNyCeevtNWB9DEKNT0ZAbqsz/k7vyzutCQarEPdpEhLbZeAAuF
 sQ3rp7OZJOaOQ0O1GiJmk5uR2iAaghn63kJsUN0KkA53gY9+154bOtjf2XvdjS9rLyRX1vzF3rq
 Ik1uGkb4XHNmR7IbLxgGiYd/RsLRY+jo4wDAYfPzbU2yQudZDPvxwcjnRCTctgIlRIReri5apYI
 z8eZYANfP4Q35Z+o/JFxtcEAP8PXEPq/V15Q56Q/71E1o80UOYI4JWXhP65jF/ZKj6MHpSmsJBV
 3u6RHZTWBjfMLIZE5dgL9uFk4IMLRAw6GqNC6ZLCWOzB3WQwhY7UnoPLwQRdyHdmAmXt5jfkNwI
 j4UrJMDJL8THSFsjbsnVckdlMdJ6J8O2nZ2zVuaH9zgWLzcnrSsTQx4C/5iiwNhTIUx/zPDc+DB
 REiJf
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

It's ok for a GPIO controller to be output-only but the .direction_out()
callback must also set the requested line value.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-twl6040.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-twl6040.c b/drivers/gpio/gpio-twl6040.c
index b9c0d54d12f43242444f12a2bd8b6988d1511466..b2196b62b528cd0a2df2c4a4c4869ad172d6e2cd 100644
--- a/drivers/gpio/gpio-twl6040.c
+++ b/drivers/gpio/gpio-twl6040.c
@@ -37,13 +37,6 @@ static int twl6040gpo_get_direction(struct gpio_chip *chip, unsigned offset)
 	return GPIO_LINE_DIRECTION_OUT;
 }
 
-static int twl6040gpo_direction_out(struct gpio_chip *chip, unsigned offset,
-				    int value)
-{
-	/* This only drives GPOs, and can't change direction */
-	return 0;
-}
-
 static int twl6040gpo_set(struct gpio_chip *chip, unsigned int offset,
 			  int value)
 {
@@ -63,6 +56,13 @@ static int twl6040gpo_set(struct gpio_chip *chip, unsigned int offset,
 	return twl6040_reg_write(twl6040, TWL6040_REG_GPOCTL, gpoctl);
 }
 
+static int twl6040gpo_direction_out(struct gpio_chip *chip, unsigned int offset,
+				    int value)
+{
+	/* This only drives GPOs, and can't change direction */
+	return twl6040gpo_set(chip, offset, value);
+}
+
 static struct gpio_chip twl6040gpo_chip = {
 	.label			= "twl6040",
 	.owner			= THIS_MODULE,

-- 
2.48.1

