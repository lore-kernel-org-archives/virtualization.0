Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC18B28C86E
	for <virtualization@lists.linux.dev>; Mon,  7 Jul 2025 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874634; cv=none; b=AMUzBBKIAUPp6GxYMd4bSXxrnilLBVq5V+6jKexuwMOU5D+3ldrwgc9kHgkwJ00WyTWkiVejKPju2TTZ4fBs6+Qzckhuf6BH/x1p1eWKls+SS+BMduSRKzAkOaEH59XZsIQr8+UjXZRCPsTo+KxnMbUMLbrvoY9gOrR4J1DXmL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874634; c=relaxed/simple;
	bh=7ouLYNojBK8YtI9q7Mvr6a4rawM5cEtpGwkrd35ZmBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SqU33LoDcuH76AJBorCbVU/pnKio7jf0SVrVwVOEuN2EblC6TNCT145i7sIyr1lM0F1EYfVcyT7BiekvBkNpzU+mLTOawI/Zhi+VRVachYLmr4w3qi4WpYgV00WUB230K9QPoObFUYgWKPOJCBuK8uqjUV+Iy/glRPPWMYBfA0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=BmV7Bm4e; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="BmV7Bm4e"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so2382197f8f.1
        for <virtualization@lists.linux.dev>; Mon, 07 Jul 2025 00:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751874631; x=1752479431; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKIG6360x9EOzMXFyVuOt0+qxmmOCbAUWOq9FvMmdEc=;
        b=BmV7Bm4eDZJg6fNXATaB2oQAYSKEaptoTza4l5Tky2jlk0WAAbG9+6dZcms9cQVHKf
         YPhIEuSCtnAs/uT5bySMcpleUHXIzatSD3UIxt9CD5KzmDCcZcc/QkP5Bi+QiZZOYRYt
         2FozGNno51JhjHSNwZZw4ozFBle85LYMwHWQAqZLvUxKsduxygXIvhxOyf9oNH287WD6
         IS+WZTeY+hOn4+GwQ/KG6CFi6qObghckSqBibTHNwnB6OS1/xP2GV8B/sLEyrQi+E8zg
         U2gDVbHngr+jgAvs9BKqRPv/7GHSheOofN9m6KQ2XSr9RVHUFkW9riDfAkNR1MTNBMGu
         KMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751874631; x=1752479431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKIG6360x9EOzMXFyVuOt0+qxmmOCbAUWOq9FvMmdEc=;
        b=pQFmFhPw8yzC3zUXObNu4ln/wNILDWECcZ2nDMRF5VcQ9g3Xay0mwqAIcvjKyTHFCd
         sEctYm3mnjkrN9y57em6zHPsA5FJlnHfGtGMT4c1oVDv9c+5cboTim2iV0+0LX1rD3Dz
         HOla5WARp7ETsGa/gKSDBLKLLkT/dLpDr2pWO+3+9/ZoG4/OdAPcsI1RQSB0D1Xq+gxd
         OYNzGbt272mnojk2EHNJrW/Clrhe7oCMQmmXqJb+hNmUDLOD/Je0SBvIctcHpgpAumgI
         KGrFJCQqbPRtKg8dcUEvHgpN7L03G59f6sTkkDEPABupjLtgL5ebUFXjrr16ZEI+7JrM
         q0hA==
X-Forwarded-Encrypted: i=1; AJvYcCWEfQGCPwSxc2bp3PxLUrPRvLZDc9QvjQ4Oe0aqLdAgRzfyhASevlJse2wmyFLF1HLh6MReO13gfcNWfqKXFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzIr/XN6JHj6Oh8ypZhtQxDeqevuv+f53bm3XVA6aOv5hpU3Iu
	d3TPZIBE/EBTeIowN2Yw7gUBNnVJf/02aIGtPJQx62t14Bslq/R71ne4sJAtdaOJ4mE=
X-Gm-Gg: ASbGncvUhtHznHmc/YkOO7I/TnyBHSFhKkRg57L1dNVsrNfKtz9cdtxwq9ySjt2bhig
	bqOAOpzMFAqDbnsbPuDBGMVr+h93THTahr5qrUTndd3QBm7XshZWufubaKZi76B2asJSkDakH1r
	MCkEva2Xb2UpHkCB/ZgiUQIoERa/WjYqxOtlrnrhiLUffz/n1Qrh4VgLYe5UU07nblpQ1ccuOnO
	Pl2UVgA/jHyr+WUjCYIceS/BlPH3lHXf2ynCgTaYU47xmLO7mvV1ywzeJ01tOY7xcWpZ2+uSUQN
	mUe/kiCxKgiR0CULDqNOwtaNozCYriY3LndX4c++MzIxojobl6id9hj8LkysAAJj+vg=
X-Google-Smtp-Source: AGHT+IGnSqLeLz4f4OlYPyWFl1B12Re+pZQxqbUbOij/xJOfJOGrlBFuuxidA355YJED2LEeFyFJGw==
X-Received: by 2002:a05:6000:200c:b0:3b3:9c56:b825 with SMTP id ffacd0b85a97d-3b4955895fbmr9795564f8f.22.1751874631294;
        Mon, 07 Jul 2025 00:50:31 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3cf3:a61f:85ed:69db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1893479sm104215455e9.39.2025.07.07.00.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 00:50:30 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 07 Jul 2025 09:50:21 +0200
Subject: [PATCH 08/12] gpio: twl6040: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-gpiochip-set-rv-gpio-round4-v1-8-35668aaaf6d2@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=WdoaTovljRVdfcPXoOOpPCv/dUUU3fxtmp6eCVydmWU=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoa3w7TnJ01R7z2+UX47L227yzd8aywcscqE3m4
 m+QNrchCa+JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaGt8OwAKCRARpy6gFHHX
 chuuEADWLZ0PhkJxuIIyFZpFqaQyNO+F2toxso5+gZ3uWKMxU46ds+vGbE/iA7kMN9669g+9rLZ
 C/K5a6cwcsdBh/kjSJXGC2cFI3B3y2rJgdLl2BdKowgiSFuXKgE1wg9ZtDdFfiMeaGfdzTN8wSd
 1X5x1jmE2/Dq5yPn12l7WoQrILfZMgB60shK9eXFPgFp2iL73Bk/wmah6skSo0ur2g5j3hSd+rV
 wa934N/PjDweLSFnkdaHjmSwTjPEZNPCaHW268ZUda/xhgcE1tR9XjIaSkYJKhmd4ga+Mk13fyp
 IkLIcd+6osDn7hDo/noQL3p5pkJRarD4wQ0pqR8ChCqRLqJb1OURx/Tl/Q7akeXtHetpp1O7rr2
 HbjxlvJ1hewJJg4qSvUsCHcUdrN4aDxpAtIy7TFTz+p4dnVf1WW0SrcJlgxBwjQHkwllrf+FYTc
 8MEiSlKjzg1qw4AGnMIm62hECJHxHyaAU2yjM3ys8p82rajD0BfXUYQqXcGZXV0dLxv6iVbSSwz
 0yq1ZKlyjplFPa9G4x8GUP6XGsN73FRba6S7CRO2yuXeEWR1yCKnudofXyNSdltRl3tn5rAfh/A
 va4XB4TxLbdGZ74JTSeh+UCzg77MjlSMZWwOnku7Y8m5+E+6otkV2Da6/OULGTFs9otJ7Rn+wH+
 tCPE7laRozoAEJA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-twl6040.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-twl6040.c b/drivers/gpio/gpio-twl6040.c
index b9171bf66168f054e9eddef8417bef6d8f197f3c..b9c0d54d12f43242444f12a2bd8b6988d1511466 100644
--- a/drivers/gpio/gpio-twl6040.c
+++ b/drivers/gpio/gpio-twl6040.c
@@ -44,7 +44,8 @@ static int twl6040gpo_direction_out(struct gpio_chip *chip, unsigned offset,
 	return 0;
 }
 
-static void twl6040gpo_set(struct gpio_chip *chip, unsigned offset, int value)
+static int twl6040gpo_set(struct gpio_chip *chip, unsigned int offset,
+			  int value)
 {
 	struct twl6040 *twl6040 = gpiochip_get_data(chip);
 	int ret;
@@ -52,14 +53,14 @@ static void twl6040gpo_set(struct gpio_chip *chip, unsigned offset, int value)
 
 	ret = twl6040_reg_read(twl6040, TWL6040_REG_GPOCTL);
 	if (ret < 0)
-		return;
+		return ret;
 
 	if (value)
 		gpoctl = ret | BIT(offset);
 	else
 		gpoctl = ret & ~BIT(offset);
 
-	twl6040_reg_write(twl6040, TWL6040_REG_GPOCTL, gpoctl);
+	return twl6040_reg_write(twl6040, TWL6040_REG_GPOCTL, gpoctl);
 }
 
 static struct gpio_chip twl6040gpo_chip = {
@@ -68,7 +69,7 @@ static struct gpio_chip twl6040gpo_chip = {
 	.get			= twl6040gpo_get,
 	.direction_output	= twl6040gpo_direction_out,
 	.get_direction		= twl6040gpo_get_direction,
-	.set			= twl6040gpo_set,
+	.set_rv			= twl6040gpo_set,
 	.can_sleep		= true,
 };
 

-- 
2.48.1

