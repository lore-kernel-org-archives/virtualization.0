Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2FD37BE78
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782167299; cv=none; b=HRBz9bkyQusJisGPYAuSTQCuh61fW+JBvpzAdkJmSQ/ACagUM8rJssJjXD/dmJWh3N/LHPYIjEAy6unb6STb71Wjm4j9m2Y1XsvRASEvbVz42/r5ED17JhvaEjvzZHR1C/zWP/bIpihfUOTSl7W25vhw5v/1JH7MzqUYZh95ooY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782167299; c=relaxed/simple;
	bh=gry1uQqAa0tANDVkHjkuPNbr5jKjvV245FrhWBFwAuQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ASiZ4YVLUs5nXRmxX4RcD7tenpN5rfzdwZ/pvngnkzGYC7KTGU+0RyIYP+89s87GkY7NxBw3roQhoh0m67MvMuYwnoKCVxFdngFF6isVffKltG8xpprONX0diqktLBVi8IiQvtFf1CMELvY6357LtoH81MHwyyeesXAcmnrgz9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sP3+Sw7x; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sP3+Sw7x"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-845438fbd9cso3622917b3a.2
        for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 15:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782167298; x=1782772098; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AEqk/nI9MwbHFJChA3EKe7XfZWAt05hBZjjNOpuqeXY=;
        b=sP3+Sw7xoMy1YueA0+V/WV9XWVHxrkdgSGEwGPkCaXQrPRglF1xqHrDxjhan1PwJ7a
         +JV5cweDE9LKkLxn5Ey6QaQL7XZx3NvC+cstckrfGTJyK7nb1QpF/5bK8useSnoSAn/z
         SWGbf4m0ExVFikfhB4I01mIH/9yvz0yTOsFYSb5nWPs2h1BepZUMUu+0a3tO/PvK/4Ma
         zZSAzpP8ALwLJmzqDnIAI5qhByNmlv4YQE4DRtSficnRauhUnnINfgArYriO3GwkZiU5
         uKy4QOeCTOA0h0YMrdlEyfW6Ho64hrFMa4IH7fxAP16EvALU4sDAcxO426LM8lABM1Kv
         DuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782167298; x=1782772098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEqk/nI9MwbHFJChA3EKe7XfZWAt05hBZjjNOpuqeXY=;
        b=Ir9Yli0neE5pPereqw/U0QALbrJLVbibFK4sMRzOT2FaITOGssrDla9SB9eaLpFxte
         JE7OdAUDA6vOjMJxbbpT+/vmay5BPWAXsRgUHJdZZqReSmUD781eBgoyMrEMF/V7I1EY
         VLEl6K+513gJwmqdrkY+ZXuNdJw9OB9vvs2u0ww5OLzfPpGtw0juxcPf6KsoIKnLryNi
         tlCG5Z14Y6lr51j1EPNA5tvKyxsjvrCCTbehGAMqwkczJfhKax/21dsyh9YfbbNlgifz
         Acm9nzvomC8q/JNlDfHcS5cWiqWYaBdC/bZqADUDgtroUloyQbbzdYwRDRMx8Yc3f/7Y
         FnYw==
X-Forwarded-Encrypted: i=1; AFNElJ9nF5A1W/NjPuK/8Uhr6NrLmePxZMlpl+ec9peOLYmKAYBRfLHvHNg8M0s3eTgAmp5iFFuLnPUWiOQagHjuqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YynmYtNnlacWazMFGKnzsJ1RYVlUSrbswdWd59KvJvRqSxknbvP
	4Yo4ockFE4c0rZgNT/FkOzfvJrO8GHCwL1kMALlnDieuE+Jip93aMCnuj/BxjFYMsJ6kzuUDIxV
	uSA==
X-Received: from pfn22.prod.google.com ([2002:a05:6a00:a216:b0:842:3963:226a])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:806:b0:845:41e4:3faa
 with SMTP id d2e1a72fcca58-845508bb8a9mr17027325b3a.31.1782167297664; Mon, 22
 Jun 2026 15:28:17 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:27:56 +0000
In-Reply-To: <20260622222757.2130402-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260622222757.2130402-1-tavip@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260622222757.2130402-2-tavip@google.com>
Subject: [PATCH net v3 1/2] iov_iter: export iov_iter_restore
From: Octavian Purdila <tavip@google.com>
To: netdev@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	kvm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Jens Axboe <axboe@kernel.dk>, Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

Export iov_iter_restore so that it can be used by modules.

This is needed by the virtio vsock transport (which can be built as a
module) to restore the msg_iter state when transmission fails.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 lib/iov_iter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 273919b161617..f5df63961fb24 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1491,6 +1491,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 		i->__iov -= state->nr_segs - i->nr_segs;
 	i->nr_segs = state->nr_segs;
 }
+EXPORT_SYMBOL_GPL(iov_iter_restore);
 
 /*
  * Extract a list of contiguous pages from an ITER_FOLIOQ iterator.  This does
-- 
2.55.0.rc0.799.gd6f94ed593-goog

