Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CCC31353C
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806872; cv=none; b=NZ1+eEmNLZ/YW1FD9GjnFGB8i3KnHyqXryVhxYtmSNXKFVs2BPy9cSpx5M2iAuC+by3yRX2mLALU3+0bGjas/8IKC6aibTnZOKBkn7ku+4tRZ6Huix4Rj2lQldPSgvztT4iL4VoulYmPktKSOW1dMtnvw1zaXGD0uDSU2KDR8j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806872; c=relaxed/simple;
	bh=g5Pqhen6+TGsZaJhVjcxjHrty8uEIOPaJGSbz6Iayeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=naNX4PyRJ/JhW6Pur6dAOI4g+83Bnt0wTv8AlP3dZqCbH0MYCXmeELpoNylF73BzhAJryzX5JlxP+USlw5K2Ip9iBl25MyocZecSdZmdodb4UEmLtCEJm5E+szKpgFIfJGG/YkAXDyS92Qs5UjSfYlSIXNavlqPYd4+bKSmyQAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwJgGlgC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwJgGlgC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaqjYk7qiFpFT4dP16wKMuC8fiQfbkUwRRgQVKGzHC8=;
	b=hwJgGlgCUmgirtrA2eHxnEBgJ0uFpDxTtXG/HykbvGgE3BRkOkif/BQ/oCDQdu+D4BSA5d
	pXIfQgqJblIXe6lbmFJTSBxtwAQVI4ObAAfn6dmylvYDLJHr6TI5zzLr0XEj+QgBiHGDxS
	cBeoaAByPSk16R0GUz1khR8EDErkIYQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-iRlqUjsmPXKi_YMHY3xxWg-1; Thu, 21 Aug 2025 16:07:47 -0400
X-MC-Unique: iRlqUjsmPXKi_YMHY3xxWg-1
X-Mimecast-MFC-AGG-ID: iRlqUjsmPXKi_YMHY3xxWg_1755806866
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0bd6a9so6976855e9.2
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806866; x=1756411666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaqjYk7qiFpFT4dP16wKMuC8fiQfbkUwRRgQVKGzHC8=;
        b=k0GuvSqxGEdz0YZ6vTJIpx7PJ86ycoObnJ190cwdsL6akP0MCj/4/jYR2alcQzQDmk
         8pHXkBz3Qkt78Pa29SQDxLKeSKVPFAGFEhImOeyCrbjT3N2J6Mr0/vPSCooQiaikaETD
         Yox1u/md3V47Vamh4QE6p/BCbX+Sx9O2/ANN5PAa2MOjcczYHdNlA6JGzwWIRFvZnE4k
         PURNxk2gl5HRCAiQC2Wr/cxZ3f12FT1QYC+onPvJYloFg/2l50gJbnzWAms2KbAhJ3Ms
         toYTwgU7JIwgMz1SAJamQJE0mKHoL/7vfB6EWyr7hCmzC5pVmvDjN+feXk7XqvM0uzF3
         iGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUSlO+U/ysh69jEpmb6TL/imgptINgk6xLGoSYk2gkDRk7Fq+KCe9R6wxDY0LEWO1nhFREjuRPyIsPcVc8Gg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6Vsr/2D4fPe5bdOLnEtjwbOiRsmMqRP3rut63lh6ly7ZydA3r
	B7iXMyp+I2Bk66lXaoZ3vPYoNzE1IddB67X2EnW4mMdG80mPjCDx5hSretEKjdm/6TtCtbDL0lN
	uCgOhYCB5lHSk9jzWuACa2bfOkjSUc4B1N9uBT83wcJ9keSMX3FqeuAil7jFmYP4L2m8u
X-Gm-Gg: ASbGnctw3nXcc+NkunTnnlj6IdvZyKU+H4VJkihbflNOZH2XblqBZI+VPIiDFcwoP+N
	oYdX5+RV3BSRQYYpj6KtkLsP/lYrkKekSnRnH5pkFTHhiYS7DYIBgnsnY6iBA0ivGkyMgUFHNQZ
	U+9Deu7LWWH4+ZShHK/I2Rtd7C29QulYYlVDL+BT+x1F3nlg2KfZhijEfMJ/pIu23twF8kUxXx8
	2f3KwoEfgfeiVyf5QWX254CJocCnKNw/JQNmDhZfsG/gB1ux+fPvaiYVenuls+UvSUkqndT37n0
	W0ga+dhY/PJnw9DXy/VZQGbjCmQxuNaduEWyY380YP7PuYpiaUe3MEGxnB3W2cgat4DfTggVuS0
	bxZJrWBZs0cGTWWOhFFIrRQ==
X-Received: by 2002:a05:600c:1392:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-45b517d4e23mr2819395e9.26.1755806866185;
        Thu, 21 Aug 2025 13:07:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUtzGc4rPv18tjnV22wd1xjfGI25AJiVbHUBF3o7jj7YvZLrrv8XzLc39l/Z4dCqHj4yY2QA==
X-Received: by 2002:a05:600c:1392:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-45b517d4e23mr2819075e9.26.1755806865726;
        Thu, 21 Aug 2025 13:07:45 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dd0380sm8632985e9.10.2025.08.21.13.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:45 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 14/35] mm/mm/percpu-km: drop nth_page() usage within single allocation
Date: Thu, 21 Aug 2025 22:06:40 +0200
Message-ID: <20250821200701.1329277-15-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wgV4geGjDFwI2uXWTZRDaKqesU04jkoPvFQruy42q9Q_1755806866
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

We're allocating a higher-order page from the buddy. For these pages
(that are guaranteed to not exceed a single memory section) there is no
need to use nth_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/percpu-km.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu-km.c b/mm/percpu-km.c
index fe31aa19db81a..4efa74a495cb6 100644
--- a/mm/percpu-km.c
+++ b/mm/percpu-km.c
@@ -69,7 +69,7 @@ static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
 	}
 
 	for (i = 0; i < nr_pages; i++)
-		pcpu_set_page_chunk(nth_page(pages, i), chunk);
+		pcpu_set_page_chunk(pages + i, chunk);
 
 	chunk->data = pages;
 	chunk->base_addr = page_address(pages);
-- 
2.50.1

