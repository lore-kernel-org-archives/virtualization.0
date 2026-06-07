Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643C234A791
	for <virtualization@lists.linux.dev>; Sun,  7 Jun 2026 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780842979; cv=none; b=UKosHEp+kE754ErspZ9O6tSHs+e1uSzr5bIK+xc7IbdJRIuIzIX8KEMHT4WnjBHY2O2c3xXNLjHZACZAUHk4pKz77WymDAnNnQ+0mMnrtgyfyFRgayu0uJNwRsb3IsQboTKUCsP2CYoK2aSH5MUM79/+RlSJMl7cUp+ZEdR9iik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780842979; c=relaxed/simple;
	bh=feUHH/LEp6u8/oHXbL8P6YPJHTZzLSmRNvRm45rta6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ib/0QnPquzHxvrWCirOD/5SrvigLSyFKk9lEq+nuNQxJgxwdjULL1PRpJvI3hsI18IahCzwkSfaoKl/L0NAePz67luf09qEQkBykWlZwTUJNZ02TvTnoVzhbBhaCRjU043N4IZB34XOBpEDndgYkVJCgNJFGjiJPmVhHAHmZnCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com; spf=pass smtp.mailfrom=samsara.com; dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b=Qo8pbIhv; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsara.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b="Qo8pbIhv"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5176bbb9384so36357331cf.1
        for <virtualization@lists.linux.dev>; Sun, 07 Jun 2026 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google; t=1780842976; x=1781447776; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DbW28oB1oSvzSZjZ+FNiYrjtjQr/zqCs0wyMZfyjnsw=;
        b=Qo8pbIhvTJN42omo7CEbqod6wyg0MZWL+P8SN8dlZMvYzja2LeGCIF0sg5GJf5qe5G
         KUoDXH5MtK1syVSJqzIfEdhiVRUxGnMHiVPrSF/ymMHm31VzS2YhKyqE62/Tcs+G1f+O
         P/LrCHnVb4DnvTDzIEpBvXBRQwrvytG8ZFwfy7+8qg/QpIEmlkacsV1VJPHl2lznTMql
         042k2jobVZ9r3Myzc1lj5RDN/a4mHaglTcJhpBYQorTRWLnbfB4wxyKVeLJekyQYguoR
         MI4xKWA8TktCJWruhCOMtomLYPn19H3S4efKNNxL/vyDaWn62CfJjKBwL+Jx6h1jDJ7R
         lyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780842976; x=1781447776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbW28oB1oSvzSZjZ+FNiYrjtjQr/zqCs0wyMZfyjnsw=;
        b=FF9qnbkHP71i6e+p25ibExEmfIXylydkfN40GvE/Jnki22EO8+11OMkmvsEr0xfuOo
         cLm8GRNozrMDu2oPRnhEIGSIfnbb4VbenOFMGhBCWHONhCOdfYs/a2k59uk3berN9+GW
         E/mDESqQy9IidQmJpiHVSQEl7SkYl8rMz4hDOae28jT4zGIXkBJtcyC8V5oFBX8fmW4p
         93JVKPRP3qQ4dtD2mth9Tlr9NM87yqvvKVZFAkIc9GfIQJBbn/Blu5/E9ZUeybezrEwz
         ySHdVaWT467lqJf+sjDE3PnehZr6/M1Kf0aX5wdqj9vKu5+G4yTUktrAC6Bl4KEdIPCk
         tZxA==
X-Forwarded-Encrypted: i=1; AFNElJ+BQ2odyf/AeJHFWsUKmwjh7c7ZS5/rDnddDqkRyKEcYjk/mxMHVu4EI5F0g1LJ8uA4UlDEswwTfOa8m3cdng==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAdtIrrm/b4ja1uT9EQKlNxxlkLMcscEQypkHybKZ1e7Zz6Za7
	q2xuE7FSmaH2ag19tT7GIrfBXv19dJW8GMOJ1KWtWtAJrBiNUA8kVK9JBMQjjrj+mw==
X-Gm-Gg: Acq92OEzmOkVir0wibdkkXrHmCdDWLSmNHPDyrGqu1JIpz+dzfzUeeaRGCBCFBjBw3M
	SgMKe2Xk+DmEncvd53eLMyiRA5KQkuAiTzme9CzUL3YfI7Axhg1L64jjHJEWjefRa5v3pw3SVWU
	1Lwzox72dnwLvHNOtgIM5luofaDeP8Dn3oZ81Hfl9Ahh6csg+FmqeJDCegUY/WyUyWdtPd6hvfW
	TwITQgDDyWnDeodOGe0iZjssT9Ygl3ZQ/QTfcboj+IgZAFdQwE8IlxDvoQg69W5d6eHb3YWj5Jb
	3d/sYfd1qcNb9YBUSFNsoZgl3KmG/7lYWwNnEN4NJWw0q3k7CKErzcbew8Uou7pP7Bq98vgJStj
	qHzLKKJdhDQxrYsBky7eO9ClHXseU9CU0X5u1ph9SHrYKDmtBxhushBPz5rkAJR20GKpQ5flB4J
	5bEjVzkOyL+hvHIISygzX35cF603lwVvrquWvhYiNSe8CcX5qrfehksuEXch3yUFBNbQCdMpxoa
	moumZ9X2KPE0NE=
X-Received: by 2002:a05:622a:188b:b0:50e:6182:b4c with SMTP id d75a77b69052e-51795b8f843mr169612541cf.25.1780842976194;
        Sun, 07 Jun 2026 07:36:16 -0700 (PDT)
Received: from localhost.localdomain ([170.85.72.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd2629cesm133827566d6.41.2026.06.07.07.36.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Jun 2026 07:36:15 -0700 (PDT)
From: Gavin Li <gavin.li@samsara.com>
To: linux-i2c@vger.kernel.org,
	viresh.kumar@linaro.org
Cc: "Chen, Jian Jun" <jian.jun.chen@intel.com>,
	andi.shyti@kernel.org,
	virtualization@lists.linux.dev,
	Gavin Li <gavin.li@samsara.com>
Subject: [PATCH v1] i2c: virtio: wait uninterruptibly for completions to avoid UAF
Date: Sun,  7 Jun 2026 10:36:08 -0400
Message-ID: <20260607143608.76122-1-gavin.li@samsara.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_i2c_complete_reqs() uses wait_for_completion_interruptible() and stops
waiting when a signal arrives. virtio_i2c_xfer() then frees reqs and the
per-request DMA bounce buffers while the device may still hold virtqueue tokens
pointing at &reqs[i] and DMA into read bounce buffers. Additionally, when the
device later completes those requests, virtio_i2c_msg_done() calls complete()
on freed memory and can corrupt the slab freelist.

Wait uninterruptibly for every completion before freeing reqs. This
matches how other virtio drivers retain request storage until the device
completes it. The virtio spec unfortunately does not provide a way to
cancel an in-flight request, so waiting uninterruptibly is required.

Signed-off-by: Gavin Li <gavin.li@samsara.com>
---
 drivers/i2c/busses/i2c-virtio.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index 5da6fef92bec3..12acc049f5999 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -116,14 +116,13 @@ static int virtio_i2c_complete_reqs(struct virtqueue *vq,
 	for (i = 0; i < num; i++) {
 		struct virtio_i2c_req *req = &reqs[i];
 
-		if (!failed) {
-			if (wait_for_completion_interruptible(&req->completion))
-				failed = true;
-			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
-				failed = true;
-			else
-				j++;
-		}
+		/* Wait uninterruptibly: device still owns token/bounce buf until completion. */
+		wait_for_completion(&req->completion);
+
+		if (!failed)
+			failed = req->in_hdr.status != VIRTIO_I2C_MSG_OK;
+		if (!failed)
+			j++;
 
 		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
 	}
-- 
2.54.0

