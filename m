Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F9B672
	for <virtualization@lists.linux.dev>; Sun,  5 Jul 2026 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783267188; cv=none; b=nOpqbP75n1SeE5Qmy7iFSdTC6mJhqReN4IIaN1JevCLr6Ov4mHQibmBn3g6etYngA2T7E3RuywiKVRjrQukyJddNCXN+5MUfH5HHr2PLKCks3AVJk/8i2CZ1kkb+udZ9XHj6XlhNZFZDUyiOf7sTe7o5FGJEOuaaIPupJLn2NmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783267188; c=relaxed/simple;
	bh=xPyvtKmNvExaeH5iOJF/u3wmRDZK6SHOgH8krALFXzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oGAJA9E+4Zkw5Mx2VbVuMFDg3vpDUPi3Lj+EnmkPmc2q8XUniTarQ7JuEWs6MHaZ2ookl3PUbNlX7CK3+K4VdF9mA+MJPDrV/Y4QRqZ7XaRjeuh7Uu+lVmiZIxjh48FiFKaVChIh2iB/VXH+jdUsj5jDtU6Xsy5tsaCBEAv1xJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbxC/tVV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbxC/tVV"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c7c61b5292so31279755ad.0
        for <virtualization@lists.linux.dev>; Sun, 05 Jul 2026 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783267186; x=1783871986; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2h3lN4661rhNBRpzqyqQ47ADQ5d9ZH08acIhfwExsJ4=;
        b=FbxC/tVVBm99aGcmvviDV09uXQQdDKqhUvV5eIr+F89pqpCsx2u+6XTElg9+Dv9VJY
         kSLX9giCtnYvxltDRHLneaktvyxkSWvzZwVewI4Sk5dj+QubF+hhFWKrdNe0T/KUjbKl
         mIK1L9N8ESWCC8KGfkh3zGNrQO0T4pjpAcX+u3/uN8OwsJKzKP5W4grNMwmxHgxs5ml+
         NWfjvCdpngi7q3TDqWS4fhfv07/l1n/M+u3cLY32a9pXKKho+YYwtk/VRSSPsNf03Ezy
         GJ1AJ3yW4pnqtq5iFHWsURGPxT8jQRmFrbZovwvnNYJJD8ySoS83g4RwtPVEyP8M2h28
         XgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783267186; x=1783871986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2h3lN4661rhNBRpzqyqQ47ADQ5d9ZH08acIhfwExsJ4=;
        b=mkW4Nl2C2r76O2GMT1s0++Dkqnf3c5UGJsJeSghgNGibymyEuGL8lvchZOTtIh16FL
         tI5D9lLsqdPINzyWVI/07XXJGwcBE5ett4YwFUZaM/JPDdFJQ4EECy8Jgjg1+vNmNRe3
         dA37ZivqtjsqM4AH04uKLegGTgvvoFOHF+4x28nDlb6TEfjA8vUshOs+akhzuHIhYzdc
         CKlWcvDEjIR5H1FUfp8UmpJ7zTW5ycHMyZi49ort9rEviqI6JijtJ0IH+2TY6zQi3f6o
         rhiHkoQubkW6aBulWnAIS88GWlu/UXVdZLVrGIsMBIhtet3j3tDWE0ruPFc+5lUA/xij
         fwqQ==
X-Forwarded-Encrypted: i=1; AHgh+RqNrdMcIgdxSbllihoEjq/aS9LLcwKUVd3zNStxW6akrm7qvLO1qrlMvLEBIcaHrJ9li85+l6h1S4MinyyJGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTpruMdTop90K4EHo41my62MagSgUXRgMt1/IH3qPIxrp9nhVd
	mxgQKdrttzgK2+FejI56woL3bW9YfEAoWA9jB4pypHEQt7r9wDDhw4WRMF+jQWAetSc=
X-Gm-Gg: AfdE7cn9GH05bxJ+XoT2GtzyZ6nAkDlC4W7R2K1GvXFcDjAzQ0R5+iSFq4NMAe5+jX2
	FeniRZ5jphWM3nziXPLienlRk15JzXJBLY103u1btdFuAjdH4z4bpgrdrbdgyjZBVD271q3sfoZ
	eLKqJUh7lhnAI9c1z1oiLE7M+RoMzBLFuHoIHgrEj5avz7sR80fjIYJNozxo8A2LhI9XMKxH7Tu
	eaWFnQ0XHL3kSriy8htvkxXBXJpNtJHe1ZzZU01T+Jo4CA6bp9tdkbzWVAnTQHBh8YBgHS03Mhs
	MnonfJ6oMYNsdZ6if4YaF+3tl48iKOgw7xvagTLluylnxX5HZGnvbwSA7CHdXIKFbtrOV0IjO6o
	9/ZOV/OHoxspAEumrhwZuuAL2C5c7Xxrj8bTpsgYwErzBzFjKFtJChNvTeZMnBUUrB7xJ51lO8q
	GPsQ==
X-Received: by 2002:a17:902:f788:b0:2c8:1c05:16aa with SMTP id d9443c01a7336-2cbb7511947mr65538905ad.19.1783267186422;
        Sun, 05 Jul 2026 08:59:46 -0700 (PDT)
Received: from lgs.. ([101.36.111.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad78aa06bsm35281165ad.84.2026.07.05.08.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 08:59:45 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
	"Chen, Jian Jun" <jian.jun.chen@intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] i2c: virtio: Reset virtqueue before freeing interrupted requests
Date: Sun,  5 Jul 2026 23:59:25 +0800
Message-ID: <20260705155925.292765-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_i2c_complete_reqs() waits for each queued request to complete
before releasing the per-message DMA-safe buffer. The request array is
then freed by virtio_i2c_xfer().

After wait_for_completion_interruptible() was introduced, the wait can
return before the current request has completed. In that case, the
request and the remaining requests may still be owned by the virtqueue
and may still be completed by the device later.

The error path nevertheless continues to release each message buffer and
virtio_i2c_xfer() frees the request array. A later device completion can
then write to freed request memory or call complete() on a freed
completion object.

Reset the virtqueue when the wait is interrupted so that outstanding
buffers are recovered before the request array and message buffers are
freed.

Fixes: a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible completion wait")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-virtio.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index 5da6fef92bec..6ef09eda3ed0 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -117,12 +117,19 @@ static int virtio_i2c_complete_reqs(struct virtqueue *vq,
 		struct virtio_i2c_req *req = &reqs[i];
 
 		if (!failed) {
-			if (wait_for_completion_interruptible(&req->completion))
+			if (wait_for_completion_interruptible(&req->completion)) {
+				/*
+				 * The remaining buffers may still be owned by
+				 * the device. Reset the virtqueue before freeing
+				 * the request array and message buffers.
+				 */
+				virtqueue_reset(vq, NULL, NULL);
 				failed = true;
-			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
+			} else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK) {
 				failed = true;
-			else
+			} else {
 				j++;
+			}
 		}
 
 		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
-- 
2.43.0

