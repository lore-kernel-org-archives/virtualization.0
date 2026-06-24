Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FB232E75A
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328028; cv=none; b=PKuqp55MxpVQAt4aIVO/w3H4QeNaClQKsvrSG7h1S1spkJAvIPCz0KpYIA2UxRoqDXljR+0gNwTER4tMLZTAQNd3iyCK7LJBxqHD20+vx3TkhUQLFsN8nGemU22zOJXl5v5nnMQsOmxtt3YMafgLWbUOg534HUHKct8SlBF7WJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328028; c=relaxed/simple;
	bh=8LkfFMB4XG4EiUlUUfCp5eNP3of8+WWy7c96tMRZBtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uBe/jslMfNZlA9De7BdSqaIe+4ufrEept5ZXevT3uPK+BkALlLdYGgJhiKQu1nbLUm3x3NirR8NSMK3wM1yHRQDCnviLTVRF3/kn177D6k+g0f1VzL46FbyI5gbFdMLnxfMuU2oPptnjCkUclI64ud9uQLhmxupi1moGt9IINBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFmzR1OS; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFmzR1OS"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45fe59255beso769646f8f.1
        for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 12:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782328025; x=1782932825; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DfCmQjaXvxIPY9LgYjyAuGOJaOamYtsKcoImA7m2aMQ=;
        b=XFmzR1OSIUzpWGTHjUN5x3yx55L5FUab7alSY1Hj4ouZQKEospKmFPmEYc9HZsq2DX
         C9L+krCXl/u6sAlYUyHeUMva4DG6lQFzs/tf95OxzaVRUJ6Q/Xwvhjie8FftDshMiEIL
         MuMCepANFRV95NWjke7qGkH0MvyWCaYABCqxuUG7FQ0Uaq9D/Ua3k17N1FmFwJXs8GvN
         v9RqphLaLT1cj6OY6Hft4GcXGefB3TSWOVctmY6T0+yuxvNbu5Nspzd8W409NLyDj0pD
         dDasv4yYFcsXCKxfbRw+umFZ0bYWmrCEFnUuzOY7rsMkwE8PR+6av8HqngJIMJb7AEkw
         ZuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782328025; x=1782932825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfCmQjaXvxIPY9LgYjyAuGOJaOamYtsKcoImA7m2aMQ=;
        b=Vtq7axs6ezuJziwNrxu1n1nd0cyrYNhbzOCrqrZQcAECdUm6qzO64lcmpaJeITy36L
         RkwxWeIoa02Y7u6vBHVS0Tq7oHp/E1/c5moxD/04WWAVGqxhoZ9xKE2jLwC0ke2Ne5r2
         s9lHoqGxNGfEDE/voEDZYMImJ6/nghU6Jq7OxKXqnRfMZRuuqR16J7x8eT+PLZyzHXbp
         Aj57so5v33g7ZJmaEiTgupFpLj3rXmNaOk0N7UOThFd/EV8LzvaCTaUV8pJfcQR4ScPX
         e0POP1cOjhyUlkmd2g5B7/iWM/dDqjHyOvF1vWGH4N8y9D1m4SnHdQpu0VUw6aZDi8U1
         LDWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Ne2HYaqhZXbVXvv+dF8i3pB+xel0Gqd3nIxqIXF7P9fUbOY4Ah29CKJkNMsuRfC5Wx9wQtTo6BHfdVtWd5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPbbXIeMQG/dkBEuJ9duf1hmXyIATd5gf8d+KFIWZSF2E/F9jq
	nAXy7iy0bf24KSx6iGXtRYqJPUop+YGHWRraMNsPcKGRmJmh3kx04yAv
X-Gm-Gg: AfdE7cl9tFcmJ6wbfjVJqitynwdLZSCP7LVcK49mSWZUXRDI6yD3u4b5pJUChjHgh+0
	2JjyeEMhqv5fhKq1slhz+Z5DV/BvwDKaSF7g3ZXKIMjHR24H7aty5LhB3Y3eaSScmhyqIhS7wZc
	9/R+cImDYzapXLCTSNqRBztVkP0PwTMAow8MG0Y24pcKwyIM2e4/2zkUtSov5b/uNEazeudBWCI
	Nj/8fWP8rc+q/jWTN4pFKXkzk5jDX+JJE0SAEumqqoFKdANSPMCGZE6Gc2+VgdddFiRMxaAD6kf
	K7JhIIsj1uhxeRZZV9Gif77LtTLenFizi+YzA2xb50DRqmwKo5Bcdcj52d55mCw+D80qtICbT81
	CFcgJe/Y286v3LuriRnXG0Sg72zae4ZfFco4j5tV4ukrX5dQvzKR3ggPabtNj1+3qfMFv0zRjVW
	5TD7oZ/GDgyfjVzb9BMCF/on4+Rw==
X-Received: by 2002:a05:600c:4453:b0:490:d32b:39d6 with SMTP id 5b1f17b1804b1-4925b37973bmr133374295e9.19.1782328025219;
        Wed, 24 Jun 2026 12:07:05 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee01d9csm8843587f8f.12.2026.06.24.12.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:07:04 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] vhost/vdpa: reject overflowing PA map page counts
Date: Wed, 24 Jun 2026 21:06:53 +0200
Message-ID: <20260624190653.2893-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
size before computing the number of pages to pin. If that addition wraps,
the code can pin and map fewer pages than the requested IOTLB range.

Reject sizes that overflow the page-count calculation. Also make the
memlock check subtraction-based so a large page count cannot wrap the
pinned page total.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/vhost/vdpa.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ac55275fa..090cb8693 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1102,6 +1102,8 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	unsigned int gup_flags = FOLL_LONGTERM;
 	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
 	unsigned long lock_limit, sz2pin, nchunks, i;
+	unsigned long page_offset;
+	u64 pinned_vm;
 	u64 start = iova;
 	long pinned;
 	int ret = 0;
@@ -1114,7 +1116,12 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	if (perm & VHOST_ACCESS_WO)
 		gup_flags |= FOLL_WRITE;
 
-	npages = PFN_UP(size + (iova & ~PAGE_MASK));
+	page_offset = iova & ~PAGE_MASK;
+	if (size > ULONG_MAX - page_offset) {
+		ret = -EINVAL;
+		goto free;
+	}
+	npages = PFN_UP(size + page_offset);
 	if (!npages) {
 		ret = -EINVAL;
 		goto free;
@@ -1123,7 +1130,8 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	mmap_read_lock(dev->mm);
 
 	lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
-	if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
+	pinned_vm = atomic64_read(&dev->mm->pinned_vm);
+	if (npages > lock_limit || pinned_vm > lock_limit - npages) {
 		ret = -ENOMEM;
 		goto unlock;
 	}
-- 
2.54.0

