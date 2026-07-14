Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE43F44EB
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013938; cv=none; b=bVKHwVlIOAgxoaKOVIDn1Yt0KKjPrvBweK4U5h4B+ygUGpCzouarfq8DotLQBtc22plK/RtGgb92XD0NBdjqvxOXSmGKjigitF4fKjIdajZPN+RBXheScYIEW3uhs1jT1rkcadxLQwTx6pOsobLbz0bfn4P+XL22xpxH7VASOPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013938; c=relaxed/simple;
	bh=zK32KFTfK2VeZqkps/3UVR2LG/9RZKDrXVPkrweLYjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opCAyOc5wSVERd7zjONGr5Qx3eZOYbSfXmv/ZaEcMXxU6CLwb1RlKWNt1IJM9NbRjuo8fxVKEVkKbHY44labHwUKk3Kj2o8Mow0RuHljg7OMspiprWozNhcZbN/5jX17COrUtQUmdefo6ApWbj2qskPJAlLq4LO4hegQSOyBUos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=DS//msz1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="DS//msz1"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493ec555a26so25527785e9.0
        for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 00:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784013935; x=1784618735; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OTtEYT4IybISQ68wyIhRqfBdv7sO2ZJrx2Yj4/Wp88U=;
        b=DS//msz1Kl3ed6+K4FiRWfUcvudrKeWVszeTIOk9CU/wbmlRuwcbEX6FaRIj942fto
         BwK0XjNhTXeYPCSn4+GUcXq42sb+EuY6iu8aBT+05lK1HAFKUNNAlfOwZTPT9Fdo1uns
         ksG9mVxgay2KnzWD0nvEV7Hgo0nL4srXyZV86i5YrOYEn+y7PxmNKxJwHbhPG6hrVFJw
         S42nKMdGNdzJJR1h9Fx3hyTetNfE7dUeHw+qSnNgDNS8mHYNSqCsI/rixqU30B7KSOov
         fkJfEkHsYfQyAOrvJQznjb2DW5Qb9f72KrccEBCfibgfNE+gYjZcGeIf9nK1W77kcrxf
         jfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784013935; x=1784618735;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OTtEYT4IybISQ68wyIhRqfBdv7sO2ZJrx2Yj4/Wp88U=;
        b=n12dFlTEmCvv91Vw2S8X2zaXatJieBN7e3HdFSSyYmqpVoj0ZPMXrMuvzn5XZG8q1m
         N0gxA+R8FHqK6aeWCaIBUAIwtM+A1Z1imrvoKbWJqwndjvFJskIlwJm5Q+0FB3eTwfld
         bcEPPPWtWy+Aj/EBn984XGSwDtAIk948t7SHaEq36O+yDhsDdySDDpJIinu45X5HpBiK
         DQSPOtIeZmgHk6zYrHjusCCHWNkbPrLnCjQ9tbimKzLKPdOaVY0iwArqCI7HS6QV8dX0
         mVxONlbt+FbFRDOzTib21JuZ4IVuaPkBAQQ+uKVvga7bt2+GhgEZFTVf6X0LXtPh0opQ
         wnsw==
X-Forwarded-Encrypted: i=1; AHgh+RqY1xuq04Yb3iqvwD3/hNOO+NqXrHVzkJwZm7XsFwKHCIClOVGeneaoNsNaB3bwmgFpt/trq4N4/6lhIBXUKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNoQ0UgQLMFQJW0u1tLCql/KhkU/J/rfOq1Bg1xrdT0dadFXd7
	TMmlinp6MnBRUeJh33N0/lSByREiH24HIBjrIfXI9/pVNzsMWSfBMk2s+2MDsInDrQw=
X-Gm-Gg: AfdE7ckGLKbYqvfJZXHMXHvr4CyoSUuvljxq6G2Gn06w9mCgW6TV9DOKA2MWpM/0MO9
	0ljYGHT60X1Rc1TTSucDalocDF+gfQqaHotzTb+a+JgV3lpDmKQ093NcapyiGQz0QYpCZnIMOol
	bVAPb6ZDcqBbYcvnrwc79RkKaCmQgFGfzGf44vVAnbPyYcS24wg+AcM8lo0RcpDE2eUjj/2HsP8
	KxbFLFbQwPRfppqmuAG0QpjyEsSTclJxwLR7Oa0CA1HxUUhKKZuFKX2oriChIaAPMsdp9H6qpWx
	hkzDcdDsN/HmCaz48PlOCTPdHvAbUYSqVXK/LjFW7dp9zGxWZSl/2ZSrm3suqmWuvmr/Lzu3Hia
	s3OYFZBBGRNDU5QlJaT6rm6vXelkGPZgTntW3gJXpkscIB+ycWVBvAEInTO6Yvqb9AOl9r7wpqj
	6tyhTfe+RKymBD2N+7Ext/R1JmZVf745ElDSjrRn+Wim/Gi98Avi5Z4T6wOhy25DoDw/5Lmkx8r
	9P2
X-Received: by 2002:a05:600c:4746:b0:493:e034:a3b5 with SMTP id 5b1f17b1804b1-493f8818cb0mr137611825e9.24.1784013935594;
        Tue, 14 Jul 2026 00:25:35 -0700 (PDT)
Received: from localhost (p200300f65f47db04b44a80421173aa03.dip0.t-ipconnect.de. [2003:f6:5f47:db04:b44a:8042:1173:aa03])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493f2d97527sm370187275e9.2.2026.07.14.00.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 00:25:35 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 13/20] gpio: virtio: Use a named initializer for virtio_device_id array
Date: Tue, 14 Jul 2026 09:24:14 +0200
Message-ID:  <1f764e00e8cbe7624f4c9f3d8e5c368fd9a13e08.1784013063.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=zK32KFTfK2VeZqkps/3UVR2LG/9RZKDrXVPkrweLYjs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqVeQ8jD+oZAE7W5RXF8rKJUVerBaw/+SR/Ptvb A6uSgxdM8mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCalXkPAAKCRCPgPtYfRL+ TncWCACxbyPh7OXwKnrY3teE/nhaOHCimlr7xEX7xf1tiLRQ/ZNVnlSU5LsOUMmenvmSyuvt9fC VPvSlR+D9pSJO/stSpJqY2kgjflibPOZu1REykCiz0Ip+bMfzhru84SFm+JMSX3xdLmqsLtjKZP GsuT4ghM2n4ZNJ12CeYNmdeKAOCalR0bIwVFF9eqA/nonLt2GLo04ANip11W8u4/hEJY2JoM+tK SndFhJGFR/PRKG3tsUChrDuGz7k0SrG37zqDQ49lWHcU1+Ke6g/SEDDXehXubqDNo0szl4NAjYC w5iWTkMyhZqiL0oNvM0CLi8lEtVXz+QOAGRM5ORZ9HunZ/ND
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

This patch doesn't modify the compiled array, only its representation in
source form benefits.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpio/gpio-virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index ed6e0e90fa8a..42871db05ec1 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -646,7 +646,7 @@ static void virtio_gpio_remove(struct virtio_device *vdev)
 }
 
 static const struct virtio_device_id id_table[] = {
-	{ VIRTIO_ID_GPIO, VIRTIO_DEV_ANY_ID },
+	{ .device = VIRTIO_ID_GPIO, .vendor = VIRTIO_DEV_ANY_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(virtio, id_table);
-- 
2.55.0.11.g153666a7d9bb

