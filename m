Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CB9539A
	for <virtualization@lists.linux.dev>; Fri, 12 Jul 2024 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720771562; cv=none; b=hgo4sO/WIG/Syxsm2cS2P/DWBgHFfzJZjop1SoaS//2KBCkgt410wLpq4HUjyDUE1dFjRzn4aLWdV05L3bw3AEY2qgYKpQU9NwzxM4ZujnK5554+3X5t81x+d9mdcMkSgGomTStOVDioG/PnCMsGS7ohQgRmD4MICtnAWD+8rCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720771562; c=relaxed/simple;
	bh=n7vviI36mP6nxaBfP+nJqOCAwypxVaPTF7rt8y0p4A0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JrOQW6MP/0a45GMzM8sFe0kmAKNPlOA0Ic4HtycJ4XTaN/29/Hzt06wPpIZ0uiw3M7JGtZBopnCtIesPDqrx/bbYEDRLB5A/0+b3fUsnJvRh8B8zmOcfcOjC7lsK/16Hk6fJMTYHUiVEoSVRyUOydcRmFQ9ZiNvGgoIk/T5t7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U8C4lact; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U8C4lact"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4266ea6a412so11996835e9.1
        for <virtualization@lists.linux.dev>; Fri, 12 Jul 2024 01:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720771559; x=1721376359; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mfY0TlwmiLCfard5rvsJoOmoOPvQGEncPGG+Fen4OR0=;
        b=U8C4lact/JOhbEPBXXd4s8k73vqUBildWym8K7hoEhVvbNvE8nFXkNuKz6A7tYLM+h
         Hm9qPN+DllMXneybjlk5UC8fHrdBszL1z6EWfgoVFw4zvUcbLWlSR5xX0ZCUvwoJT7Be
         5IGg2CsCkhI+g0dn42RzVtXda3qCYQ6a1+9ADcaLtXlQVyNUVb8ldqN9t0Ri/XwA0mtJ
         GXblh1YlDu9fbbuEmrvxzHHBKt84Swv5TP4R7dOeW0ZXSrgcRaL9EYvmIhzL+HYNhbk8
         9rk6Nrak6I2dMc3E1DhQYladHC6SwRyzDgCEwNcfmuLlEUAgKTd+Ns9WAwYWDq27waVD
         okiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720771559; x=1721376359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfY0TlwmiLCfard5rvsJoOmoOPvQGEncPGG+Fen4OR0=;
        b=t7mJ0r6HKrC4LYtIFut5dW1igDAyYpespGwo1j2e7QVNul8UZe6JIeAfhYw/jAUYgA
         MH6ueW4OKXFS0t8TmwbXoNgxQr3BdXPCQwvjO4lmrneUL9rh2yl0evdNDxGvhJlyX3LQ
         8NtTvw3QD1DUUH4D7OiWF2AABal3znnEH3Q0DuZw+UEcozhVJWFLlc9yfVZBsk98q1Yw
         N5sBvTWQ1TSJ8knEJ2KFTPgbwYIw0uoOA/r6K0lurcvOt/UW4WXHcRbV6rIaXUpdXGz7
         rQlswKMmBw7WGJGu4sEyp5LPuajTh3qxlwxGWxstKKZ0FRxJwud3S0COrvk/YLRAd6JX
         v5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXIsKGi0qwfUynw3/1VF/rXKoUl/lXqXkY+pzs89UF5YDUK1fF7xuilnelfVP/3iytf5o9Dc18veOZ4FqLZOWbceYWV2PpoPGy1mA5VSw8=
X-Gm-Message-State: AOJu0Ywb3XSb9XEK9L7OJMVuZE7Os4UZA5Gcwq0L0XfxgOvokV02jBCl
	qZ4hmPDKePNybdZVaUrQ9YU5dMb2DfXJBB8TL9iezZpdw6ARVDaQZJmCq7JmOwY=
X-Google-Smtp-Source: AGHT+IGfk8XYbf3dJihjzUp/yY597NfBnHKfKpSAf6i1wn1c0DkkGLKIJxiK/uz8d8IUUZUHeOsrTg==
X-Received: by 2002:a05:600c:33a4:b0:426:6551:3174 with SMTP id 5b1f17b1804b1-426707f7e3amr77282455e9.29.1720771559350;
        Fri, 12 Jul 2024 01:05:59 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2c1d54sm14146525e9.44.2024.07.12.01.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 01:05:58 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: [PATCH net-next] net: virtio: fix virtnet_sq_free_stats initialization
Date: Fri, 12 Jul 2024 09:03:30 +0100
Message-ID: <20240712080329.197605-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
added two new fields to struct virtnet_sq_free_stats, but commit
23c81a20b998 ("net: virtio: unify code to init stats") accidentally
removed their initialization. In the worst case this can trigger the BUG
at lib/dynamic_queue_limits.c:99 because dql_completed() receives a
random value as count. Initialize the whole structure.

Fixes: 23c81a20b998 ("net: virtio: unify code to init stats")
Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
Both these patches are still in next so it might be possible to fix it
up directly.
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 10d8674eec5d2..f014802522e0f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -530,7 +530,7 @@ static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
 	unsigned int len;
 	void *ptr;
 
-	stats->bytes = stats->packets = 0;
+	memset(stats, 0, sizeof(*stats));
 
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
 		if (!is_xdp_frame(ptr)) {

base-commit: 3fe121b622825ff8cc995a1e6b026181c48188db
-- 
2.45.2

