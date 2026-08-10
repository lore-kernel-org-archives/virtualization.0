Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4E83E173D
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369268; cv=none; b=ZvGlvU7gfWk4PE+d8iEa70id3M7mvuKbJuQUAGLKKv9rwN+/2jJ2UKCIPeUZHGuKGkwOVggoAhuZ6qwQjRefn+3KtezSRiqYkbjlogNYnpp23zxMQ9fU8lqIw1cMwp0CL+eEOpNIN9cDP9ZfDfYdcR3LU8aVhQeeXky0ewEFMGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369268; c=relaxed/simple;
	bh=OR5SJbAjYqfNbWbLK/Xp9DBpEIRw6MZvXrZYmbjvOZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i8lbCM9QWAPD19h2joojQivNov3ipGJx7ylSJOG7yhmuuHhXlivYM5sxIFTpgaFLqaldprvxNLRh2tbYcxNozEEL1pyXBOv2VO6qB0FxYVPe913qmGw2Zgx12N+qYjNp6at9AM1hlTIM6PGoj+jOZPjR80gCpWR1hCd/BXEGZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZT6j1G1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZT6j1G1"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso1805035b3a.1
        for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 06:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786369266; x=1786974066; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WBpRbjDpae64ONOAIzC7CQyuvwbiULpdksSC8EfBNlY=;
        b=aZT6j1G1ECqCYKmPOvWTGHhQ2/bbcVaao58751eyuoyNc54WGQ61FB5m68gZ43dQEq
         DMvtChBvjDuOfBs4KJeZIaMCLLrUeNFeXUUO+To0khambW0MfLKHYQx0c+TXdO6eZb4w
         kChE78PRaxPRvVqIGr9HiGGXpuNXqRMy1gAmX8noASzJAkRw8IRzgByntfEYSpBJG/53
         KtPU//+Tf1iiZJBuLZmEwFpjudRe1XBGaJpguvv/CXjm9w8MdmnNgd2tcXmBzTbNwkjN
         wIOCH2yvayTiFTby+a8hsrEIh4qTHivzlIHIAufNJtVYjLfp5nl2hBjfHhxtVPg/DkFg
         gC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786369266; x=1786974066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WBpRbjDpae64ONOAIzC7CQyuvwbiULpdksSC8EfBNlY=;
        b=XAYwy21Pb42FlUWM+Iyu48wQclrMtkf7ZSORKMrgO24nUGNpyvzrLyGIVRRast+Mz5
         ZCgnxdJBAFfoIIorm7Z3QopyblAfzNkhHy0JnBH8jeTMKk3v571WMpNHIqs/p/MXq0AO
         YcHl07T9u4uHB3CwG+Tm9sQPzNXqnWR1h3cG202cXmlxa6Bk8ZMqMP8vb68A8mkANuLb
         slZ4BdHFqbz2UuPpjqssU1DBlJNTkbUYLC62lJlX12qQm5XLo4LrBz5GOB9CAmlLcwyU
         1y0TtA0kV1nmlhMyZ1ylubUim25MU8i1d//O5btKZXnK2Coyqm3EaYqb8KOfgJAGAri3
         e8FQ==
X-Forwarded-Encrypted: i=1; AHgh+RpuWF7wyAy1wVkmVlLoatD1PleVQuMNGeunT93PTYLygDF03tvU12ELwO5gImdKF455yN3vBvQ6muxxmdCaCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWn8/b0KH7hzIXFYP/RqIawkUQkfQ7m+8M15zlyLb24SCVIyv6
	CI8ALn8IbAAW6t8HqghhSrGfeCsID5NtinIFH/gC7/v+GEp6h9K/n8Wn
X-Gm-Gg: AR+sD121wM5eD2i9xNHtt1/wAdzau7OomSnCAWkyq+p8KGzFn/TZxBsvMERzhiNClNX
	2ELEp3SjqIGkM5KsUkt2GoFytuHq/NVsL3iOVv2yAm2xXdT6Y3vMnKSBZt9odVz4zDnl4mcPPm9
	MhArSE6AJJVbTub2EiQ5AEWgwyc6GQSiLtoAPx6/5d41uFS+fEGdabuquB9f39n/shZ4TX10rJu
	aVhXW/j0maqZBOjqzrxloKTejq1q+pCI0ALHvGOOa40XSiMM/L2n3xrvT0367T9rUgmCtolbhj6
	LmhCz3SGz7J+J/iWNBPlAo1hk1ZIL6PsWxWVFdlI5zkOePWvIN7BrKH0Bogw8vX+Y0EsDjfc5JP
	XM+VXuHY73ecj863GAC1RVxM/uIzHYOHYJWUb0TdzzTv4+4p8F6uZC4FRK9zulHDJlY9mrLJcfi
	hYN40vyjShs4V1jeExG7AJdpz0AA7KkQ75cf31kBn0DHiu6CkfZWtbezO96HR4/YVvy7DrFaY=
X-Received: by 2002:a05:6a00:4b45:b0:84e:cd14:aeba with SMTP id d2e1a72fcca58-84f6b6f2e61mr17355422b3a.6.1786369265853;
        Mon, 10 Aug 2026 06:41:05 -0700 (PDT)
Received: from gmail.com ([123.118.75.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51f166sm4006236b3a.35.2026.08.10.06.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:41:05 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] vhost/vsock: keep IOTLB across feature updates
Date: Mon, 10 Aug 2026 21:40:18 +0800
Message-Id: <20260810134018.143973-3-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260810134018.143973-1-physicalmtea@gmail.com>
References: <20260810134018.143973-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VHOST_SET_FEATURES is also used to update logging while a device is
running. When ACCESS_PLATFORM stays enabled, allocating a new empty
IOTLB on every call drops valid translations and forces avoidable
misses.

Initialize the device IOTLB only when one does not already exist.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 7372c22691de..1beae7f5b9a9 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -889,7 +889,8 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 		goto err;
 	}
 
-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
+	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
+	    !vsock->dev.iotlb) {
 		if (vhost_init_device_iotlb(&vsock->dev))
 			goto err;
 	}
-- 
2.34.1

