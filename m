Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFC22E9EB5
	for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344257; cv=none; b=oN1lgMgEuIdlFb4ipZrp2/zFVkIBbqfObrhpj+6MliNPQgLPGGTtydxrEfGahyU51XqdHiKJG2oCeu2KW3sk0aqbcKWkMLrn1salkEOgPGEY6MPWiw9Yo9pRLEYhfUfPRFFfJF29N5Eg96IcceM7Tjy25lvg4rz9XD/wrMitgVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344257; c=relaxed/simple;
	bh=gXp1sqo04e6LO5/4Vkl6NRi4x49bKddvQgyl58yMMsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ER0htYwMYZilqoIROs/5aN8+JU8WioTT1yaecNitdqdsvyr7xE4k+TDth+RNAc2nMCtXdvG8qdRPK3EZt6cWEO2OEsdcUP5f5pRa8UCRozZ63uUx+ArUZQ1sBzivWPXGWSKrxlHYVO6RnF4t2Nve9SBCREB+22yDtFg8h+osI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDUoqEyq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDUoqEyq"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aea68839a5so11341895ad.1
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 12:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773344255; x=1773949055; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RzzRjNz0vk0FkgwQahTz097bKivrpMU+EtTeSnfZdlM=;
        b=FDUoqEyqhCaVe4DTciP4HO/3wksinv26WFI5wjizeUNBKvguY/U1kXx6PjjLxVMg8e
         85JALUv53CJbD30lKwdW77Kpi5L/Yel6ZJt548fL+gGZeFmtDAaMeM8gNLD72HH/Ljos
         kJph5lSIW8RWUhsKOtP60Zuj3eF7HQaQKR2QwjIHFkJ9hFAEsC4f6L73tQkE5XJSdA4E
         DFM/7K95PeZSYZlmdXybYG1uEa1wL0w7cErShK0pU8z/nrE985zYAmFBXzXfRnlNwsx0
         1IGdxhxUcs93RPiJsvRKfaMFIvedZXNlhmjdbVI16JoVL+NqeqLgsr+egQDZR1MzR4SO
         yAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773344255; x=1773949055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzzRjNz0vk0FkgwQahTz097bKivrpMU+EtTeSnfZdlM=;
        b=k4MyRy1aRXh+WTDRpUs2PKk3dF8j4sYOLuS1rDH8au4BxcEqm8cWjO3ZoyejRE2LnB
         mTOgdYk56rVRexBT7+Vlly1n1R3WBDKTeuMiCWINcBT4lZS4CCUy6beVDea198r167sw
         x3F7dCh7MKLoevAGkxaGoTsJdpFhnU2/9lMPmbGuxMMRzMLayjTu4sfNi2m2QuB4NykB
         qeP53zSrAoL/mocYZ2vN18764y/ok6jRqzW5z8O2QYWsyYGSQ7uZ5/qQsez+fPnJBCSE
         jrIZE1HIvDQppqS5Igz2UnBtnyZ1FozkpTIEasLTqQRXQr9lqUZGuqOrwaBHt3uXqN7G
         TS0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWY+jicgyrQ/9/5RJxxgqaT79flMMfIg0TxC73Uo8cUpZFIXcOQTNB+JffWAphJ93usLx0MTdVb3u6s9YVWTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNjKA4vxGytRD/s66siljCgsfwH/9E3pKHDEx94daN3l/JV+3u
	tOJ69VHWZPdLNtV6yJx0/3jJ2wwDUaSsoEE1bzv28R1eZNi2tWxsSrHA
X-Gm-Gg: ATEYQzznCM03n6e2ki/fuh7fOyClRzjtfPfLQEi3CN3DMurIgyP0wsZJGu7zAswi0t2
	k9AZ1ieeh4kwPxQVV/enSaBO4jzaV4zuXd43PBexkxwcbPrADcEUgNYQxr5WZ+Iv5paKjUClBHl
	v1LmzvPj/xf8Iu7DuisHpZV+/muLdgJ7lGm/MBgkIl+B8pnycPhOarTkDpbryQjAIcGtEHrdOJo
	n8Xvuuh0iH85CDAyHUjtMbG90fVKEm5kUZBj80b4q5Umq11cLMucRCwYhBlbM2VLbMwwT16gymT
	3mSVEzyXB5/mOscdYykd+wCXk1FZNCQwpSrkLvifIoz7WUoNs85Sd+SPbavkF6HARuJ+BIL3P02
	z2Df2MTOqFq0xaxxVT7ZfgCn+hJrOjyg4zlipQ8jVWgjCR70rMwARgi0ieiHILNgWmQn7I4Jxgi
	uGyyBYcFo5JLI+KchL+O78pVK5I9Wvrso0ZGaWIiV7yNZk34x3O8XbAg==
X-Received: by 2002:a17:902:ecc2:b0:2ae:3ae3:432c with SMTP id d9443c01a7336-2aeba46a7d0mr41568145ad.10.1773344255388;
        Thu, 12 Mar 2026 12:37:35 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae34de20sm62461975ad.60.2026.03.12.12.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:37:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	virtualization@lists.linux.dev (open list:VIRTIO GPIO DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv3] gpio: virtio: remove one kcalloc
Date: Thu, 12 Mar 2026 12:37:17 -0700
Message-ID: <20260312193717.12221-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A flexible array member can be used to combine allocations.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 v3: add counting field for __counted_by.
 v2: add space in struct
 drivers/gpio/gpio-virtio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index ed6e0e90fa8a..57d0eb532c3c 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -52,7 +52,6 @@ struct virtio_gpio {
 	struct virtio_device *vdev;
 	struct mutex lock; /* Protects virtqueue operation */
 	struct gpio_chip gc;
-	struct virtio_gpio_line *lines;
 	struct virtqueue *request_vq;

 	/* irq support */
@@ -60,6 +59,9 @@ struct virtio_gpio {
 	struct mutex irq_lock; /* Protects irq operation */
 	raw_spinlock_t eventq_lock; /* Protects queuing of the buffer */
 	struct vgpio_irq_line *irq_lines;
+
+	u16 ngpio;
+	struct virtio_gpio_line lines[] __counted_by(ngpio);
 };

 static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
@@ -541,10 +543,6 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 	u16 ngpio;
 	int ret, i;

-	vgpio = devm_kzalloc(dev, sizeof(*vgpio), GFP_KERNEL);
-	if (!vgpio)
-		return -ENOMEM;
-
 	/* Read configuration */
 	gpio_names_size =
 		virtio_cread32(vdev, offsetof(struct virtio_gpio_config,
@@ -556,10 +554,12 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 		return -EINVAL;
 	}

-	vgpio->lines = devm_kcalloc(dev, ngpio, sizeof(*vgpio->lines), GFP_KERNEL);
-	if (!vgpio->lines)
+	vgpio = devm_kzalloc(dev, struct_size(vgpio, lines, ngpio), GFP_KERNEL);
+	if (!vgpio)
 		return -ENOMEM;

+	vgpio->ngpio = ngpio;
+
 	for (i = 0; i < ngpio; i++) {
 		mutex_init(&vgpio->lines[i].lock);
 		init_completion(&vgpio->lines[i].completion);
--
2.53.0

