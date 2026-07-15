Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AC7496917
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784134585; cv=none; b=qbCZpmdxH/0HLekKOxbGzKtWCE03eK/JO63JI5b2A6o8VQstXqpBlGwhChhDQLOxfIsIsxFyLoxReLBfuhOdCM6GkUG2x5NFiewplgssZug0QQBgGtkwlziHWQS7mnzheIQsPXaz3DnIJXZ1EQDmsFmueccXDl2SVr6ybQKLXmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784134585; c=relaxed/simple;
	bh=Cw+XLdNgXnftxuPSTDZj+51wyZZdxeif8BUFQO4Z1wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8IB+DhANl0e6JvvkIKEXvdKSHzd4bH/nqrzTj45hLyWFZvOUmKFptreIKww1dbOeXulwsjxg2zWyn6OC4mE+LJF4AUTzpuwdpFh78hGsrh7470lXFVF7ImoedwDU7IU8pSHw/sDhgPPuLA/x+Cni8L6RmRsrGiCq5LP5ECf23k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=BVyh2otV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="BVyh2otV"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493ece78b0cso40137235e9.0
        for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 09:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784134581; x=1784739381; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AO+MjM/BEQ0toQ97krU14h4AjetrPnZmMJGlqWBpdjs=;
        b=BVyh2otVizSrEWaKY/UXCZmAVPyDYZD4CFHhfi7kH8mkZpcisiL4OTu2lTgD9J6hju
         +jQBilBxKrxWNosHpJd9lsC1WLKyBsfY96XJtUb6L2bLPVDBpThFeKjXCr8q7YTd1Ki/
         Dr4CAogNSuQseRNgRNNySdnbTQ85y15SzdH1EVo37hfgP0HC2Un4rnqzRpZ/+5oINyvN
         7v8zdlVgtcmQhE9qX8t6geQppfPuJ4OeXFSoMa6M2YYN8bREULv20AxwcxDmQArmIUUV
         Q9iSDdh52HiaLygM4wypSQ2CUF0RQSMCUfgBRQnKuYAShMNn8AmBN+txDpfPeXS7dS9O
         Crmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784134581; x=1784739381;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AO+MjM/BEQ0toQ97krU14h4AjetrPnZmMJGlqWBpdjs=;
        b=AerzwXEyZ5mCrEwtHEbTHfiUbui+Qomi22uFaQ707O5EUK0zPY4VfZfJc9gX6WXbd3
         dBK7TWUTFrhbn3vQ6bd53ARTQoC0eiSVEbS+Iw8i/kctP7fU3PcEcafzokPErh+tOkUu
         E+cRW/RJ9+qjT72YmTUAH1WWNKCbPAhkOmlnKUisQxiyNzVwsRZDiGazQ6nj9voqi9KY
         oBB4Sr4IjWDDmlPem3NT346izkjX58tCtLjWxlRzdYWvdjDWuXZTOTcNs0ZUgIsbstDE
         f5/wOxLf+KN6lA86SeEjOCoJDtYL0+czALosB7jNkNTEy0NislZLrbJ451EljzvWvsBs
         dqsA==
X-Forwarded-Encrypted: i=1; AHgh+RrziUoCCa5A4+iP4PxrlmNtW1YjAQoi5sQ27Uv6YQqFIrnGgFYCwD0LAkEypTtfAWpEDT2K/EXv2PFVWThraA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4MMCpVXX2rg6kDQfjCszeIJD5LwLBVirH1DAM/hIyFd/uYVvu
	Gt4Iknz9Vsy7DYi2w1kSOex1A38Ka5pQki1v29nTcWbkCFa0UFLikthPvxY/jiau4Yw=
X-Gm-Gg: AfdE7clkslxO/KbG3RcGUh/0i9XfMEfMex1QltHBRqLUifjhQr/eM/RdbFuyalnoVZt
	pyjoFalgQXbkauF9Bj483jh1pUJirv5HbiS5COjUW6WQa4XRXBOcNdNw8Lu9jW58qLksuPqP0dl
	eTVjtcJXXG9CTDcz0pJJotgfQXWQQiwLM52QpJZYuoV+i1lNdenfZI7uNAefpqELO56lRqeH1uR
	g55UD1ws/ELkRChVJmDrUwRqxdfdK2bha8UpzHBLkX2Qfg/82wZ6bj3Q1rWQq7+tsAvHOE/znpf
	fJjZ9E5m3caBiim8zYSIcQUCouWxI64xSezzK+A/Gu1DPGucZ2RF4m2UovmdZ0mW51AxaOjALQG
	Oob3qkUhJ+y5LWqHxYe9WJ4qP8xOkMq2vSZ1Rv+8LkXkUl/7W5XQiIxvNmNLbT1kNwlY5igm+cb
	5j/Rq73nDcJ5BMgjEE6V9beo4zR9IkP5CdJ/bo3Bi7L+td49H3+XuNfmKH7CDoAib9/MksS6Ga9
	fE3PO7ky11aTw==
X-Received: by 2002:a05:600c:4f0d:b0:493:e4cd:def1 with SMTP id 5b1f17b1804b1-495158d11f7mr114531535e9.11.1784134581664;
        Wed, 15 Jul 2026 09:56:21 -0700 (PDT)
Received: from localhost (p200300f65f47db04249e031dea91a10d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:249e:31d:ea91:a10d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4950a2f951asm170203015e9.14.2026.07.15.09.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:56:21 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v2 14/21] gpio: virtio: Use a named initializer for virtio_device_id array
Date: Wed, 15 Jul 2026 18:55:19 +0200
Message-ID:  <5de4e961aa6934a020cd8291946b3652056a04b2.1784133987.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Cw+XLdNgXnftxuPSTDZj+51wyZZdxeif8BUFQO4Z1wM=; b=kA0DAAoBj4D7WH0S/k4ByyZiAGpXu4ug2Bw2yP055b202QWIbcCgQNl47qULDUKFxd260P5L9 IkBMwQAAQoAHRYhBD+BrGk6eh5Zia3+04+A+1h9Ev5OBQJqV7uLAAoJEI+A+1h9Ev5O0foIAKhT Utmm4r51n5Je7u+xT81r/SSwogmC+SvxQ2HmDykCYAeVrAlXPTxatZT+/dE7vB3qFp2fk66rAcs XzStO8hgAI6e+gQODI40dkCvE9iTqS3xv7YbWT84LPFCzZvVe86ia0+ttLXtHJgB1HQENFJ+CLO KZQ7qbDXWBhw7pod/A0efCglGZUL2xTdh6UwpFUzCDeM2qZkjv8c5BuvopnR1yf9f7PBj0RUEFB b4nBZoKnNIfvDgSzvQtfdHM+V1AxEyJR1mtYVwQfGPRSacnBP8KvWxVOWqbpfeHZzK5pJKWXAeJ E/0HnupDtVLuN5tXUAEAEQsjZLDTwt6ycNIwm+I=
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

This patch doesn't modify the compiled array, only its representation in
source form benefits.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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

