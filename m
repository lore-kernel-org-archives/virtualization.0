Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A692D66B2A
	for <virtualization@lists.linux.dev>; Tue, 30 Jan 2024 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614078; cv=none; b=Kzn0UxGLiavoVfhr61LqnBArAdzELFsTLnhHVo3lRwUuOUNoBiMy1ucm4l2yjfn5m5niC4efTmcidm5ptKnuGanGM5iegL+jj/5mr8jUOH67FrmgmQGmlX+YZw30dVVN5pvrerxxoBRt79yDmjS7wVt14mPiNiDHpRadMqAKKfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614078; c=relaxed/simple;
	bh=VJ3WxFyUH1QX/R2FezaIZrc9SHd0VxU+WMrUCCCzWbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Miy1b7Ehw9OeqMWfa9IIpLpa1TDboLyfFLnZ4GSuhFWYlpX6n5BUMNICH8Q9/WRNuHeXG+XX8KiW27fPLaj9IuFQg82z1OGWhdeAqF7h2fSTEDtke9EjiVtf6be7CliL8BchV+G6WK6pVN8zPUnfY1gqjqQO+tm0duLDfFranfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eBO5Ag6T; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eBO5Ag6T"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d91397bd22so1767775ad.0
        for <virtualization@lists.linux.dev>; Tue, 30 Jan 2024 03:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706614076; x=1707218876; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NFz/ioS5pMtmsywy9UOLGQH2uroA4Qw/qVk4L7fINX0=;
        b=eBO5Ag6ThDbIGmlN/6Fito94abk7/aHH44xbjM0uZm0IuYXvbDVBYLZU7U+nSKao9l
         I9JrzZSD9uWUcBSV5SvBYZsjadDyB/s37V3wIBRktxvuZI7t2K3yxat3Nt/4aBEaAJ4C
         xUMXXW7zpxXQntbLxEuas4PHMWD4Rq2FcUmanzKf2wytGhdn9ukiVTlL5I1TFuZWEu1t
         PC0MCo85WRkKmTn0/EL+X6JoDrqmwa4u3KNZQxyfJwBaV2xUsMYRvl3HiTuhFpnFLt2X
         oiFyM5eYJ3QIKG/VteJcjZTER+q4lapWQaMBHGHZGTUf2N1jZR6P5okxnAwao2Af5sSk
         DiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706614076; x=1707218876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFz/ioS5pMtmsywy9UOLGQH2uroA4Qw/qVk4L7fINX0=;
        b=rM3SQxcrDrwclf0ZLlJCc/pIdZH/Bo6GLjYK4rWR00z+9rq7VUn3mbsqK2WiEfkgjB
         y1A5NcGbRBDDXLB+QlG93KETiY2KWwAWag1NQ2PIqupL9uEAHtN16M/4XqN2SPt4r9ru
         uQh/3eMqQCJIdKHSeKE0lqQuyHV1Bl453MaWjyYoLeISgM4n08YFHFZ/7o0fU2eMm9E4
         UiwN5/DSlaFpOjIgX6GCo/8mlfUbaJLPdCpsjioPB2nA7uHfqA3Lcgj+aZKdvKZIc5DJ
         gPwJNT2C2EWcth7jY22LqDT5pFSUMZL/yPIWwBuTA680+cdVwUO9yjfmb6kunzdvE3IV
         2U/g==
X-Gm-Message-State: AOJu0Yz5lfMAlVw4vd0H16VsyPZbnBuXBIjEdoc0lGAwpdQuhTOBzw68
	xYFcJ+I0NNEaF1Z6bBBHzlZpH7Cj/ba60I54P5ANtPA7xWr8sw0trYz+9wMm5Uo=
X-Google-Smtp-Source: AGHT+IFxYQYsZlp0TH8j7NTAhzYbg+/UE/MPq1RYMFL1zOTZBo9xa9ES0Z1wEP85nypj79LLuQ20dw==
X-Received: by 2002:a17:903:2692:b0:1d4:4e13:6b59 with SMTP id jf18-20020a170903269200b001d44e136b59mr4044993plb.45.1706614075892;
        Tue, 30 Jan 2024 03:27:55 -0800 (PST)
Received: from always-x1.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id jz6-20020a170903430600b001d74502d261sm7002041plb.115.2024.01.30.03.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 03:27:55 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com,
	jasowang@redhat.com,
	herbert@gondor.apana.org.au
Cc: xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	nathan@kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH] crypto: virtio/akcipher - Fix stack overflow on memcpy
Date: Tue, 30 Jan 2024 19:27:40 +0800
Message-Id: <20240130112740.882183-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sizeof(struct virtio_crypto_akcipher_session_para) is less than
sizeof(struct virtio_crypto_op_ctrl_req::u), copying more bytes from
stack variable leads stack overflow. Clang reports this issue by
commands:
make -j CC=clang-14 mrproper >/dev/null 2>&1
make -j O=/tmp/crypto-build CC=clang-14 allmodconfig >/dev/null 2>&1
make -j O=/tmp/crypto-build W=1 CC=clang-14 drivers/crypto/virtio/
  virtio_crypto_akcipher_algs.o

Fixes: 59ca6c93387d ("virtio-crypto: implement RSA algorithm")
Link: https://lore.kernel.org/all/0a194a79-e3a3-45e7-be98-83abd3e1cb7e@roeck-us.net/
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index 2621ff8a9376..de53eddf6796 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -104,7 +104,8 @@ static void virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *
 }
 
 static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher_ctx *ctx,
-		struct virtio_crypto_ctrl_header *header, void *para,
+		struct virtio_crypto_ctrl_header *header,
+		struct virtio_crypto_akcipher_session_para *para,
 		const uint8_t *key, unsigned int keylen)
 {
 	struct scatterlist outhdr_sg, key_sg, inhdr_sg, *sgs[3];
@@ -128,7 +129,7 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
 
 	ctrl = &vc_ctrl_req->ctrl;
 	memcpy(&ctrl->header, header, sizeof(ctrl->header));
-	memcpy(&ctrl->u, para, sizeof(ctrl->u));
+	memcpy(&ctrl->u.akcipher_create_session.para, para, sizeof(*para));
 	input = &vc_ctrl_req->input;
 	input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
 
-- 
2.34.1

