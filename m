Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F623680BA
	for <virtualization@lists.linux.dev>; Wed,  3 Sep 2025 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925977; cv=none; b=MlNgrftW7JdW3b7tyAX03fhXkgimkctALJ96orHm447ixh1eZPcNxcodIfR1nd/UgtZgRVQIdaRZGTWuYCWKGz4xQlad2NDblh6MM6khKy45kpSoV6vp3mfOJkPoYEw7E4bYvUwAdwD7AiQAlse85cRQlK+6Fa66k7cl3ocd2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925977; c=relaxed/simple;
	bh=LTLVF+hMZyPv1dZXihuaUEnmBeqbcuLCGvLuGg2qrsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IenNKbZziH56MQQdcAqpkcTwzWzPL/J9lraILOjB9+tI2NB57WqU5e8YvEJHgiXPkOHEcYEAzHhMsxUZMBPv2d9tFkutLXS0oe145qhUa2aRSJRXenx5J9UsVSNAJ3yPv5cP/8xxOs/oZ0l891odqNw78Y3m17GO5Lmyrkcs/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNU6UOdK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNU6UOdK"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-244582738b5so2245805ad.3
        for <virtualization@lists.linux.dev>; Wed, 03 Sep 2025 11:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756925976; x=1757530776; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cg3vWTOesz5aa5s3lECf1v2j8z5ZoWgWQOpdmwDONGE=;
        b=aNU6UOdKFERsRnAvZN1j9iz9ZpidY8JTYikiuMYjp/4tJfFVhg6Ss736m/iMn/xnyf
         OPiS4kgdG7r7YegfkDgWDD4ECjJlKh9x8DO0C+3PN3c3byfqXVZVa/yw4fBMuVw8Tnpa
         1r2KmeSLE+HAn9WD0OKiVRUPop66lHFcfJpDVeP6fab7iAGB6RN5jsAHL1tWwW6UT+6j
         VpoKHMEdeXZWXpRiT2wE6x5wA9VOl4gPHX9T6OKuUH0Ho5cFFpBmnf2zAHSXAJbIuxLo
         rEQuGb79Ff1gAAehTzTZyfClo/sHd7DEqoxR4zLxBV8XQOlU0BO6PgPgJnuKkdILL0zW
         Irhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925976; x=1757530776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cg3vWTOesz5aa5s3lECf1v2j8z5ZoWgWQOpdmwDONGE=;
        b=XioHpOxnQ4mXtF68W/ub280+X/7aeH2A7U0angIJ48WWRBsz0tZ8ePIfzijKMW+6E8
         vCzBo+Kcl3QaX0UGryhMNjZxiF2fKD0lmZITJM+4prklo6iusxKg3rA2EG9y9Hz0nJHj
         RWEpHpJ927jc+w9E0NydJL/jLVpgJE4nnPioK3mcyYwiB6DcrzBF6OCVUvKESHnWY6zh
         XQIAixUd4zHgsLfhOdW6899dITnXq4L7PQzpuRLME5QYn8gT13u6aVzq6euIUj3ujHys
         kYZYjGkyvijA1UBD77vn9GoYpv3WiOoUcktUu3P03c2VdD4yvLNN4DBplI9sjA2bZzOW
         PV2g==
X-Forwarded-Encrypted: i=1; AJvYcCW52ROgHOIwHjPNh1XB7+YAeGKPWLZ2d4UeAmdzldKze7p35I7H56g8N1Sd1kwyNHi/aRcVKrI5oxmBQhF/Iw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXZ4TV3F4/hKKYkS56Ef0qMIR0RCkWoNt/gadBWm3FPzj6zEDP
	Qzx/rmAuWajBgkq4v38DOlDHRwRDKVcNkE9Q8evGmJBERbsWOtZTmAI/
X-Gm-Gg: ASbGnctU1/5rbqdgbV7dV3ZxiWnSBi8S++xBQunubMJUpRSZkEFhJ9qMmP4TyeHuhte
	QABehQdlXpUg23st7zH1dMFBGMRx0vOtK4XFQWdtQckDesIit2gH6T4vZpCPFKhv2mm7A6OcJCr
	5FrnESUKReQBp4a9OS5whrydRxYN64oT9/GLZuawol1/Tq8afYvzrU0joz9/2APw4YcG+Q+xShR
	mYyJkRBNjRoZah8K5WsGgxv3hsxQ2OWwi9YZCVpqnAl5gRZDsyuDuqVmCo+3w0kpTsV3HbNvOIf
	dd6M+wVrPUcOXS1ERYMQMIDUejxBGkLvytfStSd4ixIphz6FKNl4ZUDl1XbhgxJd5hpOcJLRsa8
	2TpwRQPAe2UHKmJTy3ActhWZ3agPGPEIixbojla3yntSJ8iacomAjQA==
X-Google-Smtp-Source: AGHT+IEDGbdRM9mEhaV+2ag53MUmou+Up6hgUY2vpYZIptsrNmf4dFU9V5zvfqRBlRBpWDsd4n9KQA==
X-Received: by 2002:a17:902:d552:b0:248:fbc1:daf6 with SMTP id d9443c01a7336-24944ad55a3mr207897875ad.43.1756925975667;
        Wed, 03 Sep 2025 11:59:35 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249065ab343sm169403475ad.126.2025.09.03.11.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:59:35 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org,
	virtualization@lists.linux.dev,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH v3 1/7] mm/page_alloc: Add kernel-docs for free_pages()
Date: Wed,  3 Sep 2025 11:59:15 -0700
Message-ID: <20250903185921.1785167-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903185921.1785167-1-vishal.moola@gmail.com>
References: <20250903185921.1785167-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel-docs to free_pages(). This will help callers understand when
to use it instead of __free_pages().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: SeongJae Park <sj@kernel.org>
---
 mm/page_alloc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c2a254d877f8..0277b86b62ac 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5269,6 +5269,15 @@ void free_pages_nolock(struct page *page, unsigned int order)
 	___free_pages(page, order, FPI_TRYLOCK);
 }
 
+/**
+ * free_pages - Free pages allocated with __get_free_pages().
+ * @addr: The virtual address tied to a page returned from __get_free_pages().
+ * @order: The order of the allocation.
+ *
+ * This function behaves the same as __free_pages(). Use this function
+ * to free pages when you only have a valid virtual address. If you have
+ * the page, call __free_pages() instead.
+ */
 void free_pages(unsigned long addr, unsigned int order)
 {
 	if (addr != 0) {
-- 
2.51.0

