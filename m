Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0385837E2E9
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 05:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845987; cv=none; b=lm1cR8f3othPzsnJZ6u17RCL10dfYI+yO0UveL0M3yKVXBp4tgzHjsc5YxTxbD/jONAMiJyjIsKjZwM1/PbAr6RTRh5Zeh7aSuIq4aDux+4cVcrQkL5A0SruMXJaAr3Y+Kw2lvO6duS1b2MVELjK3uZ29jp7skrqDe9xcAd9MxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845987; c=relaxed/simple;
	bh=aHcAwCFI8yTOgrqgZxZPyZpx9kC63bQn/NwjoFN18eI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PR95abXfHj7+vy34OVNc0T2D1hBjedrEw7c48kJPdajMbPaJyBQoh7htECipLl/WESJZZFSnCTYi+23aAIxs7GRuR2SIm4jgsR6CEmOsJ9bkFfH/oy4LkVYVr8ZOJ4AHi+Aw+h6ZKBBKiiuJNNNhEhVQfwuRWGn4CZL/vCnE9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nt3wRjWB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt3wRjWB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so50120545e9.1
        for <virtualization@lists.linux.dev>; Mon, 07 Sep 2026 22:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845981; x=1789450781; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RUNN4pXUiIqbT553r7BwzJCI10zpfzMw6DzVR+9Z+tQ=;
        b=Nt3wRjWBykcFcKW4eUkN/sg/ZG2p6XAYdE20DQdbjp4lN4EmEAHuKLC+813C3kSetx
         fZ8UiLZYq+iaH67i/JKxD2/yyv38oZ7qHzNGttvvZyY8Ty2BSJeU0yyTjs/FKlSFiV5f
         gNyxayJ5O5GcV1HGG400b766Ddl/df26aAFpL3P/WBR64wToXo9rVu7gYPpqSkXX4iEA
         CnRuaRK3UvqMNTC9jJYpRvKmFNghIj6u6YCCrlD4lBf+gK3ndXlZNwjIMpJMaF00eAiK
         1lxW2Mzr5bNxt7fzwNiItpZqpmD/Pa+Hs4KGGHq/37fuOTMcC81fUXgqEwJ6BC0rhbIT
         +p0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845981; x=1789450781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RUNN4pXUiIqbT553r7BwzJCI10zpfzMw6DzVR+9Z+tQ=;
        b=BOvTdb5t/zVnFHcwue86QVOywPcrQBKz3U3XrRdIPpZ9iUPQyTUkrIAeLXAE2mEVZL
         jxwu8BWertxK6mz/YmiHu/elW5XHfmXd6acDt9/YjUdQ+DAYJcIsLRxTq3v2DD98cMkX
         ky5i3yNb1vSvbkgJiR0aecWYrL59gWCHgwyYNlUkOUXJ8ImAZbyi6WPddQ98zsKcxAqT
         Q4niOKdeT81CAlf8PcQ1c9MsGHTaldHXv0tApvFvcm1Ejo17r4qrARn/Ylwkdohjw9oD
         zheeE3xisTejTsFIzLAMtyL+uMYTby8tqkNYaR+ApLUYUIquq+98ib99zO8E4pLFN3q2
         C5HQ==
X-Forwarded-Encrypted: i=1; AKwUvBy5pOXq7RFCv0iyg6rsuxiLUZyY0YoHLuP5M5eJL2SC2XgSE2EADy6sU8riPboI67vrIuHNZpN+AtdSoOzNNw==@lists.linux.dev
X-Gm-Message-State: AFuF++nzxQhx0mmHn4gRSBLntU2Lv9wwt7ut1xdBc76Mbi13K2Sy6saw
	3ImvIxDwKEKB7zu35X+ex6liS9zgf7JufEMujrlDELEkv7W5zNNFntl/
X-Gm-Gg: AYBFou0BBW06sq8GR7ocJk3iUVU9xUX7MdGTKDsgbd+6nUcyxhjJq+w8wiAJWFXXO3R
	YWr55Ho2dxe9LH9BNxfL3qXOF8H6GxNCkV/TJ8zWA300cBDRN66IP51Oitp8uorK8U6z+JpnoIm
	y/Nthmg/cOI+eQnLmBc7P2iYoWdAKV9L4yWE1Na9tLKJquuB6CXnsFpCm8K2+9aYMYS/VL+v2V4
	PuyvnHbpy6BHdpvrNoLxJAy5FAgn+itUZn3r42FgvB9K8LgXZG1AWBfYDULdV9H2o5k/1MblAxr
	z/4YoP4bEk5XRCL1Nq1CMMKcEMenhckrxpqny34gxCIRej/oMis38uebUaRHXJHcqdQH0Hsqz+u
	i+vzpM0rnJHrr6plRvq80ysLlSARsKfZu+nK6A/GdIJ9oKkdgrIamU0hztq82JH07RyyYeDzVYV
	QP1gaUTZ9M7lmEY1Xzo6orTn96EpZqrrwoR2HEco59GHv8/eFM+RVcEuLiEqPPFRw2YkCxf3Z76
	nz3os4qAuEExB+r1LR8qXs/IpHi0wDzYi9agM3swMnAhrBbhHu+hYWOVJX7bx0QmE9ahTL7qKUZ
	MiuAnqtA71ME7N3GkdFwEh1KxOXETIw=
X-Received: by 2002:a05:600c:3b21:b0:49c:ee01:8c53 with SMTP id 5b1f17b1804b1-49cf820ab3dmr263600185e9.2.1788845980825;
        Mon, 07 Sep 2026 22:39:40 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm523841335e9.13.2026.09.07.22.39.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:39:40 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3 2/6] virtio_ccw: always take irq_lock in the classic interrupt handler
Date: Tue,  8 Sep 2026 07:38:13 +0200
Message-Id: <20260908053817.26065-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260908053817.26065-1-kmehltretter@gmail.com>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_ccw_int_handler() takes vcdev->irq_lock around its
vring_interrupt() calls only when VIRTIO_HARDEN_NOTIFICATION is enabled.

The virtio shutdown path calls synchronize_cbs() even when notification
hardening is disabled. virtio_reset_device() now does so after the
transport reset too.

For classic interrupts, synchronize_cbs() takes vcdev->irq_lock for
writing, but the interrupt handler does not take the matching read
lock in that configuration. synchronize_cbs() can return while a
callback is still running.

Take the read lock unconditionally so the write side can synchronize
with the callbacks.

Fixes: 8bd2fa086a04 ("virtio: break and reset virtio devices on device_shutdown()")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/s390/virtio/virtio_ccw.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index b90299205698..552d77998012 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -1204,13 +1204,11 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 			vcdev->err = -EIO;
 	}
 	virtio_ccw_check_activity(vcdev, activity);
-#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 	/*
 	 * Paired with virtio_ccw_synchronize_cbs() and interrupts are
 	 * disabled here.
 	 */
 	read_lock(&vcdev->irq_lock);
-#endif
 	for_each_set_bit(i, indicators(vcdev),
 			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
 		/* The bit clear must happen before the vring kick. */
@@ -1219,9 +1217,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 		vq = virtio_ccw_vq_by_ind(vcdev, i);
 		vring_interrupt(0, vq);
 	}
-#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
 	read_unlock(&vcdev->irq_lock);
-#endif
 	if (test_bit(0, indicators2(vcdev))) {
 		virtio_config_changed(&vcdev->vdev);
 		clear_bit(0, indicators2(vcdev));
-- 
2.39.5 (Apple Git-154)
