Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280D31A2C0B
	for <virtualization@lists.linux.dev>; Thu,  2 Apr 2026 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775117890; cv=none; b=aIhJ4IRN28xuRXoEhcJwvNK6WLo6xwnPXSMyQc4isum0YMgP5HEzIY4Y/f/ns41YaLmC60YZkzY+OKM7vlEVPEmennc9c6oLsK4LIYabYu7IJb6BDT9A3yXBSDfvYrUY7EBRIB2ytklj8AHmAsc+XFneXEqRtqC9i+G7fkh0VS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775117890; c=relaxed/simple;
	bh=Gv4j5F5kmYPN2toSNOT0NUM+Ds/EorTosVmZDSuDh0M=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=d4SqqrVFOL4PpvfK2CvOwj/2dmBvsyZMDbIcmgRXWZDH2ed3hFAGQUmsSwrsVuPtFoNL33MVHc3WdPuVxU8MQY7WmHOAUyuI4ElcO0MkdYxBRKSCvWD/ATG+/wo++Zg97v2Y3tPrSSOHiRFDLHbSIAgVtb6+7mNJQBwqEfaJgQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dm7t+OgM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dm7t+OgM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775117887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t6mFCTOwHARpB/AAY05EQ/dyhhMmoktNcIHAMGcB1vg=;
	b=Dm7t+OgMdQ4Wfg5ug4cdghgZ8DGPzHtltpKN0EhpcO12jf4pb4/nO08+P/4a3aIPDGsb9a
	4pmkz2vTE1Qj4DO/AsorIs+sNbE0YFGts/duPvfbBUeMkF9stlRi0qPwzAJcVODw6CNW4n
	AZ27i2tw+aKj1E43UR4rX2/wWn4hY74=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-fxuAYhO_MMKYbqbRCcUeVg-1; Thu, 02 Apr 2026 04:18:05 -0400
X-MC-Unique: fxuAYhO_MMKYbqbRCcUeVg-1
X-Mimecast-MFC-AGG-ID: fxuAYhO_MMKYbqbRCcUeVg_1775117884
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43cf6758644so553397f8f.3
        for <virtualization@lists.linux.dev>; Thu, 02 Apr 2026 01:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775117884; x=1775722684;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6mFCTOwHARpB/AAY05EQ/dyhhMmoktNcIHAMGcB1vg=;
        b=broHhzWcE3ifPmikOY/Ym31iKX5GcNNDSG15PwKcaaC8/mPg7pJWWy7/3Sj614NTNe
         khin81DSzygLhVQ96xG31Alr9/me+6eYzCO3ZCGLuoa250ZXvDocPUzWZIhNPdR8Zvs5
         NdsUu79VeiQhQjJEIQVK8mBXG2Y5gr8x8XdtmeEuwghVhELntyC6/ARCQ6qFoMEZStgz
         1ERDk4zIhgwns+59oJiJozETYOiN2r/ivXrrMjpACJvIjZJNa33LrkWiw8FMtQgoZUeh
         jZvaF/Xmr4MDG30zTVmEwYZ9wA8tkoAwzV2ae7X/nxGjGQLR/HAX6yTQvqkc803OJJFw
         LkAw==
X-Forwarded-Encrypted: i=1; AJvYcCUIFL/P+/82GrM8Wps0ZOM3QYU48RZ+YdgVemsrvN7fgIUxmf74+2wC1DE6jagIYcntJe6ItTBs/dAvdHVsow==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHqEN62u2mVjp4ro/YTQHdTFC2+hGeJrcm6TdHRWPTUU5Px/Ut
	jjOihL8VyevmvCx14/CO8PI7UMq8Syyoqkp1AZ6bwjkac2mQ/R9/YRdn8YvtkbBSF4BEx3CBLwZ
	ycR/Og5ZbM+ivGr17KsZ2e5vl0KqF62zVRvWkz0pp8Dpr86JYa1SBn8G8BDhQ1FkLRv1b
X-Gm-Gg: ATEYQzzH0BMF8kq7qB3+mVKVXN0V4VMNRawayUOdDtMlXhoFb7ta1DwXc1kFG7gbuYM
	GrLrPzWZca9kFs6f0QF/iiMk7IRax3dCYYdnhCkLFQGQB5Nu6uCrFJpkUwiGVGKyeO8fAsUC8yB
	FsnZ5aqIDuhXXH/FW/9SgoA0fCVpH3Y67RyiCawGcdCoZllx9EXIiRasu3LiO9DNHVb+PvUfMAs
	dDa+cZM4IGpaGETcRUJ1kr6tdkfaxOjsD/ZPLu8DEPKYn54yrSKzf0UlHrue54bH6ZKHUxiULIP
	+EJCgAdFn72w36wLYPjgZmbKu9HX6Yz3XedUdVo1xo0RX0bKuuLHuduWs4sUd0kC31UPWg+cvcx
	FOgpjxG763OQZ+8aBYeArJ8pdYVaxVdC7JOhPxg0rJDJc4V/OHB2cOjPwTreF
X-Received: by 2002:a05:600c:45c5:b0:485:3193:6ddb with SMTP id 5b1f17b1804b1-4888356a036mr110318955e9.3.1775117884411;
        Thu, 02 Apr 2026 01:18:04 -0700 (PDT)
X-Received: by 2002:a05:600c:45c5:b0:485:3193:6ddb with SMTP id 5b1f17b1804b1-4888356a036mr110318555e9.3.1775117883944;
        Thu, 02 Apr 2026 01:18:03 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e735532sm214476005e9.0.2026.04.02.01.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:18:03 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net 0/2] vsock/virtio: fix MSG_PEEK calculation on bytes to
 copy
Date: Thu, 02 Apr 2026 10:18:00 +0200
Message-Id: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwND3bTMiviC1NRsXTMLY/MkC2MTM8tUYyWg8oKiVKAc2KhopbzUEqX
 Y2loAioNizF8AAAA=
X-Change-ID: 20260401-fix_peek-6837b83469e3
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zMoqzr54WyYGV1TzgyRFMrKukUZXlQHMOEGWuu95cpk_1775117884
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

`virtio_transport_stream_do_peek`, when calculating the number of bytes to copy,
didn't consider the `offset`, caused by partial reads that happend before.
This might cause out-of-bounds read that lead to an EFAULT.
More details in the commit.

Commit 1 introduces the fix
Commit 2 introduces a test that checks for this bug to avoid future
regressions.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Luigi Leonardi (2):
      vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating bytes to copy
      vsock/test: add MSG_PEEK after partial recv test

 net/vmw_vsock/virtio_transport_common.c |  5 ++-
 tools/testing/vsock/vsock_test.c        | 64 +++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 3 deletions(-)
---
base-commit: 9147566d801602c9e7fc7f85e989735735bf38ba
change-id: 20260401-fix_peek-6837b83469e3

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>

