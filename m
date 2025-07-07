Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F94290095
	for <virtualization@lists.linux.dev>; Mon,  7 Jul 2025 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874639; cv=none; b=EhjgYpAPqhheF2wCFCTpEYmrvJWBq6lIS5Ie48xrU5ngfGCFUBIZbvXK6RdLx69rtcyzdIn8GmMDI7ADv2EZda3X+3yPjnkUw5jZ1Za88e2VTEjmbAEtNRcVJpV2r1piznKsj9yK7lEU6aNfymqfZEBbCOL522Y15APlUid5e6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874639; c=relaxed/simple;
	bh=vtL8c3CWHWi7bD8fUICBWVIWkoJx1ZraepAblph5uFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBfqN9iAdMIlavcSUwiZax9qqiZz2dYBV7HfH1hPPTYLiArzMYUbl68sEgSKmHqjw2ZfbavPS4U/G/+81oZxm2Qbf1t+5DrcFZWQfSBLraG+cUqqxJqc5EK5f/YPX1in3xvqq/cuBto4AG/B7AhyPt1E4mauQV+/89O57MfAOHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AyK+2tR5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AyK+2tR5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45348bff79fso30102385e9.2
        for <virtualization@lists.linux.dev>; Mon, 07 Jul 2025 00:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751874636; x=1752479436; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SWmN0oZOf47ZBuNC1PAZKMF4JI0fWMJVI0uHHLJq/Q=;
        b=AyK+2tR5N4LRIviIAJ0rHJKQa8wXgl8SSLlI40UkcIp2cBskMWlhYIwrqjwVdv5Dlf
         +7JUk8PYaUd8zpMNdCmCmEL3j/HC2Am4CG5tJXEKwT/l7OtJVqR6EVYYuQnJOXWW5cig
         mFKfCl4PSS2ejWkTMJgET/5sVe4jYl9mYfKadgUFSxBQ/cVYmNDikiaRMQCSKIoUhy94
         OTCTXn4H5yd0npDiiP9Pc+2sQcNVYhIvTI+c0JGdS9exxgGaKmRDgP41KgU5zjZFgkLG
         kazvbrPOdWwfvW3BvXKmbpJH3+n1PwKfaBnXlrdGVy/pvKNlExMsMwsoBKGkOreI6FPz
         in3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751874636; x=1752479436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SWmN0oZOf47ZBuNC1PAZKMF4JI0fWMJVI0uHHLJq/Q=;
        b=g0l0XVWRetsWYqfvB48C+oKcAKhnSOpNpL4w4v2IXV1Zt4PGUVAhj7QPjHrTSIy9SD
         f8xO5uTTMvQOXWVAh1bEDQpq3khytx+JJPqCKcrKpCMLTmjhZGwxC3iHNayENxW7ctq6
         ZRy4PB6ve9SVotyWbonxEF8cxzYiY3cWI7o3ZE2MCNZYo2PGGjvN4dH8uCPYR3TEJw7d
         ooFG/XeZwXhAfbPo814iqrpKmeFiiB4dttf78zd/0FZ1I5aSNqaJDZBc8dfwqRiACR3N
         OZjRE1Gzbd8NhdfOgedoawtd03oyarUbG6oysSOs5ewwt+x9Yds7dcGmyeis3/xR7a09
         Emaw==
X-Forwarded-Encrypted: i=1; AJvYcCUflC78LPX6vDutDLPkPz1Qk6ubREPOrZo3BR2mVyx5zJOTr67DW2OA0IBLdnOqDgefraQW8xDccZj75lCepQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9BxEnWPpgjyKpzP1d2c/MpSLxna4/tBTXyI71AcIWraLeg3Y8
	qpTPIwatWw0dQMT9K11Anm/jxV+dhyTbtbA3idX0ht7TcdSje50Cg0YFpTx/F805Bfg=
X-Gm-Gg: ASbGncs08kad0q5iaoMJRNG4AqiVrgVinwmVFzCMx3bUMHySHOHk51HIVrDIOyaDYRk
	ZKol2dEdoefv2R30A1v0Qf1SOPQM07BccabcZ9MYE64f8ZN/kRIw72+WXRzjGxGJpRfUWDXfKAP
	/1FhcWbx9VpPh3Pvw9aW5rpJaOWjC5GRcXdAjxOQ/9EpjL6IRtbAPawteaeXdKt29OFy1bTv8S3
	vuM10CwbOQF7AnYW72CLnq0JmpNuQIZMPcRBQwmUMfECykAEOpw+hRF1ByTEpfoYaFn9GkN74eU
	X1zO4WRoWHdMdoWU0DzqWriNoj42AB+Qfdh/CmMl4hCSyDbQirVCjoWId82aRmYcRL0=
X-Google-Smtp-Source: AGHT+IGkf+l7zAbCVq2RM9nxUZWQcOta3ZZ/CUcd1IUsy3YNoRjJEdd3rGBCVueejV8IrTqJPkhe5A==
X-Received: by 2002:a05:600c:a4b:b0:453:6b3a:6c06 with SMTP id 5b1f17b1804b1-454b4ec3c54mr96906635e9.29.1751874636031;
        Mon, 07 Jul 2025 00:50:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3cf3:a61f:85ed:69db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1893479sm104215455e9.39.2025.07.07.00.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 00:50:35 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 07 Jul 2025 09:50:25 +0200
Subject: [PATCH 12/12] gpio: virtio: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-gpiochip-set-rv-gpio-round4-v1-12-35668aaaf6d2@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=WBzxcByKBAOQyrVMEQA9NOf7MP8zLdwyhJ5inR/oPcY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoa3w8yxjQpOYow6Ti0FXaO1aSbr77VEqywPKk3
 2RwPz7x3IyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaGt8PAAKCRARpy6gFHHX
 coxND/9dppbq95ielLo9QfHw6O8rAfYnIC/QkOGI1bSRtDxVc8ijvATdgEARXzcG8jLM/e8I2oL
 ksw0hc7ylzWXX8rBjmHKEGYvWg2b7oiQdXuBqzquor1sLAQdezaSegOvOEmiUnA4DmbFu/dv8qR
 uVzn9tyMLNrYL2hOybxGyigDs8RN7e/I9PvsxwqUdiSM+FmltJD6ijePoyL6eDSDxHYz/seDAiT
 N9GD7fxPInPTAir4rIV8s10G/GBlxy5IctmxZ5zmTqVI05P8lrgAEgtY+vghcFtiCg058mfCug9
 cq3Y8sH6uXXxNDds8lbzNx+IvkP+qofDRCF5kyMEexQuB2s1tkWedNxTfUIEAzlbkEleI41OB7s
 q/qsCnoLjx1fio/B0+BBmG/rAyDpoiNl6JLMY0wEC37i+mdVajPwqteVW51UFtX8SpSoLKlDTMM
 mKw0pfW/3cELbn2Br7jE/H+CDShs5JSrBlfpnzozxWBkA5RJJfv9PgxhN3+kH76kJ58vByjHRHy
 ph5cMFrLy1s0HxEfS/ogCykmPLQRwbYPRWeVpsUPC+RmBo6TZTLPBxHTkhTePdPRNQvalymGYce
 pBbzqnznTVCAlkTIxCnXwvRO0fkfGIAuYcLHqZv5Mjfp/MGv+hX/9ppwqbeRVhsacoaaKEHCylA
 uA9yO4B5OLbLQeg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-virtio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index ac39da17a29bb844b0dd1e36eaf37670261396e8..92b456475d895912c903ad04a9d101daab5ceb58 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -194,11 +194,12 @@ static int virtio_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 	return ret ? ret : value;
 }
 
-static void virtio_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
+static int virtio_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
 {
 	struct virtio_gpio *vgpio = gpiochip_get_data(gc);
 
-	virtio_gpio_req(vgpio, VIRTIO_GPIO_MSG_SET_VALUE, gpio, value, NULL);
+	return virtio_gpio_req(vgpio, VIRTIO_GPIO_MSG_SET_VALUE, gpio, value,
+			       NULL);
 }
 
 /* Interrupt handling */
@@ -565,7 +566,7 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 	vgpio->gc.direction_input	= virtio_gpio_direction_input;
 	vgpio->gc.direction_output	= virtio_gpio_direction_output;
 	vgpio->gc.get			= virtio_gpio_get;
-	vgpio->gc.set			= virtio_gpio_set;
+	vgpio->gc.set_rv		= virtio_gpio_set;
 	vgpio->gc.ngpio			= ngpio;
 	vgpio->gc.base			= -1; /* Allocate base dynamically */
 	vgpio->gc.label			= dev_name(dev);

-- 
2.48.1

