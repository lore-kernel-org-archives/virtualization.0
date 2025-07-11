Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F321ADC7E
	for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258636; cv=none; b=MEZYBfASxHmRV0I/lG8FcDpp6KKAcUm7k2tjvYyfssGMhwIyvsi0QxP+kLKI0MDYaNI8ydluqqYuyPhduFfsW+9R09hrS1YgWSBrReNJNgWsFSFWFHiO1O21+iNMnfjEUnOzggOC50uUcDuipq1I1bAEW5cHCX1zWZ5/ZnqK1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258636; c=relaxed/simple;
	bh=sJW/1fGSw11zYgLi/9LWnszpW7KHJj2dr0zHLZ1lreM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i6hA0xtp2xaZdkI7OQLs134vlgRabEAnfw13jCVwkeOODABTf5XO+IlF2qYlTCFXXX3KfAlNeKK+CAvgOGT+D30tWvX+Dq25NcQEIXsAsexq27kgRO/8PWyhNOZ/F7WxcAwrE3JJiQ4PmHMD/dKcTDYMQmuMqzd4kFljRf1bPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKImfFIz; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKImfFIz"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c01f70092so3855286a12.3
        for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 11:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752258631; x=1752863431; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TOP6MH4LWDkkQWWYHqizxUdoYZyd4qiL1+SiqsnJqbg=;
        b=KKImfFIz3Qt0F9XuY25/B1zgdqnEZ53K/V7nNELTOIBK54xT7f6b3fReJ/u3PF7xRX
         8XR6L1cEiGC7lH4359Xj7YsCMKu26XMYVCR3A3b0bu3e6TB4qK36jBqXXRT5Ed42pTey
         i9TtLPt/b9g0J4nKs4vmpVu3k5VScMO8jcza7FGWRugF0MaF018rzOUR7yw5q2X2MDQK
         11IkysbPKj8/3rourxlR6ScHW7t7Fw6YkKGEoCD0xSBmNTAzTy1TSJCwQ+9r7kRnplkb
         B5I0Qaet55NYQ4S54QSqkJaEj+Uc7En8Yak0bmY9A89Qpgv62EASpRKqs6vb4iZ9pN+I
         S8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752258631; x=1752863431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TOP6MH4LWDkkQWWYHqizxUdoYZyd4qiL1+SiqsnJqbg=;
        b=WzAJzQtwUDiJPeZSvQ3uGyssCm0LuOusI7XVpWzqNFsW38bDjAc9eCCsfZjQ1hLyP8
         7AI0fGjeBhfKfJhuqkFs4qyBFE23UzHqcy18LgvzEZbM3kD0BJMGt48sX5AlWfCwHffb
         jpQgiduee1lEwK8OVZzaML9uudu420mAQ0kdYpx/zI1iJLL+Nxfl6Cpr8JHdJPlmcQSQ
         MDRBdBj53FnkUqn/QdCPmtzY7TVj5Ee9ADqIGKqurPRbGkCQmK/e9+gGGQ6wVv8PUKHC
         2RthhxXRgcZu6tICCYzAQDGtSmkRssnMpO9oo0sPKh8LW9sB/D1C1NguEWnyRi59k5r8
         ak5w==
X-Forwarded-Encrypted: i=1; AJvYcCVqw4O/GIb1UcO9PZk1CsaV+LmaUf/uPjhwd68E5VRVRf6+qB3Oe43PMJp2mRu/+y2D6VJdGD0an+oby/MKHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbwzKE6gsjYNtF0kyyR02DBwNWzf9xEKMAn51Pdzu8bIscOPsX
	6MgfnmKgCvawp6i8FXh+KwVum5fciCKRRWb/ctpUnM0qMCuHVm5RMzAF
X-Gm-Gg: ASbGncslLvgye/5tbuYyKAtpv4QDOO5nRGY93+2fQqb/cEqSRbygYX/Tw3m8vCHV/69
	d3XUFrBTUnTYI0SjqfqerL0TDaSTyYdLGypS0nGfbAtYNq/VVoArLMOb8rucxGinGphfDYfol6Q
	F0Vy3phIrUWlSoaPYcllzwQFoqTq7FZT5pcSMIWOa7PLI4MItFwjXvAySe4U2fITZScafpbeawV
	IczRRpXGP6Om05JALc+OGViSJKl8Puqgl4Fiv2SBAm5RHxlGDfYw9niGS22DvgXHz+TRgZ2jM9g
	FhFTObDAfNxelf9t00Hc6mxyUYb8IkljOT3gZZsKp2ovFV2Ip7oHTTsyOr9n/i86GknTSdexmzz
	ooWF5ZLcJln3R4bzz83WrTSTiGpumaQplzLw=
X-Google-Smtp-Source: AGHT+IFZ+CT7VU8SXE2R9rYpWGqwI+x5YqfZKcBNQpoWiXBRCuYmYkFXigYic9U/s5bCPICsGUlhJA==
X-Received: by 2002:a17:907:805:b0:ae6:d3dc:4f47 with SMTP id a640c23a62f3a-ae6fbf98a08mr496827266b.43.1752258630915;
        Fri, 11 Jul 2025 11:30:30 -0700 (PDT)
Received: from ws-linux01 ([2a02:2f07:6009:b200:8bc2:7901:5231:7913])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee569asm334750066b.44.2025.07.11.11.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 11:30:29 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ovidiu Panait <ovidiu.panait.oss@gmail.com>,
	freude@linux.ibm.com,
	dengler@linux.ibm.com,
	linux-s390@vger.kernel.org,
	horia.geanta@nxp.com,
	pankaj.gupta@nxp.com,
	gaurav.jain@nxp.com,
	arei.gonglei@huawei.com,
	virtualization@lists.linux.dev
Subject: [PATCH 1/2] crypto: engine: remove request batching support
Date: Fri, 11 Jul 2025 21:29:31 +0300
Message-ID: <20250711182932.918257-1-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove request batching support from crypto_engine, as there are no
drivers using this feature and it doesn't really work that well.

Instead of doing batching based on backlog, a more optimal approach
would be for the user to handle the batching (similar to how IPsec
can hook into GSO to get 64K of data each time or how block encryption
can use unit sizes much greater than 4K).

Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
Cc: freude@linux.ibm.com
Cc: dengler@linux.ibm.com
Cc: linux-s390@vger.kernel.org
Cc: horia.geanta@nxp.com
Cc: pankaj.gupta@nxp.com
Cc: gaurav.jain@nxp.com
Cc: arei.gonglei@huawei.com
Cc: virtualization@lists.linux.dev

 arch/s390/crypto/paes_s390.c               |  2 +-
 arch/s390/crypto/phmac_s390.c              |  2 +-
 crypto/crypto_engine.c                     | 25 +---------------------
 drivers/crypto/caam/jr.c                   |  3 +--
 drivers/crypto/virtio/virtio_crypto_core.c |  2 +-
 include/crypto/engine.h                    |  1 -
 include/crypto/internal/engine.h           |  4 ----
 7 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index 8a340c16acb4..a624a43a2b54 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -1633,7 +1633,7 @@ static int __init paes_s390_init(void)
 	/* with this pseudo devie alloc and start a crypto engine */
 	paes_crypto_engine =
 		crypto_engine_alloc_init_and_set(paes_dev.this_device,
-						 true, NULL, false, MAX_QLEN);
+						 true, false, MAX_QLEN);
 	if (!paes_crypto_engine) {
 		rc = -ENOMEM;
 		goto out_err;
diff --git a/arch/s390/crypto/phmac_s390.c b/arch/s390/crypto/phmac_s390.c
index 90602f72108f..7ecfdc4fba2d 100644
--- a/arch/s390/crypto/phmac_s390.c
+++ b/arch/s390/crypto/phmac_s390.c
@@ -1006,7 +1006,7 @@ static int __init s390_phmac_init(void)
 	/* with this pseudo device alloc and start a crypto engine */
 	phmac_crypto_engine =
 		crypto_engine_alloc_init_and_set(phmac_dev.this_device,
-						 true, NULL, false, MAX_QLEN);
+						 true, false, MAX_QLEN);
 	if (!phmac_crypto_engine) {
 		rc = -ENOMEM;
 		goto out_err;
diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index 445d3c113ee1..8a2400f240d4 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -195,17 +195,6 @@ static void crypto_pump_requests(struct crypto_engine *engine,
 out:
 	spin_unlock_irqrestore(&engine->queue_lock, flags);
 
-	/*
-	 * Batch requests is possible only if
-	 * hardware can enqueue multiple requests
-	 */
-	if (engine->do_batch_requests) {
-		ret = engine->do_batch_requests(engine);
-		if (ret)
-			dev_err(engine->dev, "failed to do batch requests: %d\n",
-				ret);
-	}
-
 	return;
 }
 
@@ -462,12 +451,6 @@ EXPORT_SYMBOL_GPL(crypto_engine_stop);
  * crypto-engine queue.
  * @dev: the device attached with one hardware engine
  * @retry_support: whether hardware has support for retry mechanism
- * @cbk_do_batch: pointer to a callback function to be invoked when executing
- *                a batch of requests.
- *                This has the form:
- *                callback(struct crypto_engine *engine)
- *                where:
- *                engine: the crypto engine structure.
  * @rt: whether this queue is set to run as a realtime task
  * @qlen: maximum size of the crypto-engine queue
  *
@@ -476,7 +459,6 @@ EXPORT_SYMBOL_GPL(crypto_engine_stop);
  */
 struct crypto_engine *crypto_engine_alloc_init_and_set(struct device *dev,
 						       bool retry_support,
-						       int (*cbk_do_batch)(struct crypto_engine *engine),
 						       bool rt, int qlen)
 {
 	struct crypto_engine *engine;
@@ -495,11 +477,6 @@ struct crypto_engine *crypto_engine_alloc_init_and_set(struct device *dev,
 	engine->idling = false;
 	engine->retry_support = retry_support;
 	engine->priv_data = dev;
-	/*
-	 * Batch requests is possible only if
-	 * hardware has support for retry mechanism.
-	 */
-	engine->do_batch_requests = retry_support ? cbk_do_batch : NULL;
 
 	snprintf(engine->name, sizeof(engine->name),
 		 "%s-engine", dev_name(dev));
@@ -534,7 +511,7 @@ EXPORT_SYMBOL_GPL(crypto_engine_alloc_init_and_set);
  */
 struct crypto_engine *crypto_engine_alloc_init(struct device *dev, bool rt)
 {
-	return crypto_engine_alloc_init_and_set(dev, false, NULL, rt,
+	return crypto_engine_alloc_init_and_set(dev, false, rt,
 						CRYPTO_ENGINE_MAX_QLEN);
 }
 EXPORT_SYMBOL_GPL(crypto_engine_alloc_init);
diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 9fcdb64084ac..0ef00df9730e 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -629,8 +629,7 @@ static int caam_jr_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize crypto engine */
-	jrpriv->engine = crypto_engine_alloc_init_and_set(jrdev, true, NULL,
-							  false,
+	jrpriv->engine = crypto_engine_alloc_init_and_set(jrdev, true, false,
 							  CRYPTO_ENGINE_MAX_QLEN);
 	if (!jrpriv->engine) {
 		dev_err(jrdev, "Could not init crypto-engine\n");
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 0d522049f595..3d241446099c 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -139,7 +139,7 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 		spin_lock_init(&vi->data_vq[i].lock);
 		vi->data_vq[i].vq = vqs[i];
 		/* Initialize crypto engine */
-		vi->data_vq[i].engine = crypto_engine_alloc_init_and_set(dev, true, NULL, true,
+		vi->data_vq[i].engine = crypto_engine_alloc_init_and_set(dev, true, true,
 						virtqueue_get_vring_size(vqs[i]));
 		if (!vi->data_vq[i].engine) {
 			ret = -ENOMEM;
diff --git a/include/crypto/engine.h b/include/crypto/engine.h
index 545dbefe3e13..2e60344437da 100644
--- a/include/crypto/engine.h
+++ b/include/crypto/engine.h
@@ -76,7 +76,6 @@ int crypto_engine_stop(struct crypto_engine *engine);
 struct crypto_engine *crypto_engine_alloc_init(struct device *dev, bool rt);
 struct crypto_engine *crypto_engine_alloc_init_and_set(struct device *dev,
 						       bool retry_support,
-						       int (*cbk_do_batch)(struct crypto_engine *engine),
 						       bool rt, int qlen);
 void crypto_engine_exit(struct crypto_engine *engine);
 
diff --git a/include/crypto/internal/engine.h b/include/crypto/internal/engine.h
index b6a4ea2240fc..8da1a13619c9 100644
--- a/include/crypto/internal/engine.h
+++ b/include/crypto/internal/engine.h
@@ -37,8 +37,6 @@ struct device;
  * @unprepare_crypt_hardware: there are currently no more requests on the
  * queue so the subsystem notifies the driver that it may relax the
  * hardware by issuing this call
- * @do_batch_requests: execute a batch of requests. Depends on multiple
- * requests support.
  * @kworker: kthread worker struct for request pump
  * @pump_requests: work struct for scheduling work to the request pump
  * @priv_data: the engine private data
@@ -60,8 +58,6 @@ struct crypto_engine {
 
 	int (*prepare_crypt_hardware)(struct crypto_engine *engine);
 	int (*unprepare_crypt_hardware)(struct crypto_engine *engine);
-	int (*do_batch_requests)(struct crypto_engine *engine);
-
 
 	struct kthread_worker           *kworker;
 	struct kthread_work             pump_requests;
-- 
2.50.0

