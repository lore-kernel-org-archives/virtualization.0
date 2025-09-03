Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71511547C9
	for <virtualization@lists.linux.dev>; Wed,  3 Sep 2025 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925976; cv=none; b=NNRTDNJfBYryw/y9TnWW1Heey2VaTDu2vanr1z/Tl41VASL6gtuPZXMfEd/hQ8wstWnn8tA+cSnQSAcbrcmyGxfZEwXx3NJJ3Ewc7MIU+8GbzLM1d3JdLRrJcVKsfO62pU5Jp7eUqhNQPwweYsWUvNGQneHAsljiO6iJocZWW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925976; c=relaxed/simple;
	bh=CmRuSfLVesYC6zLMzuuR1yKrwX/yrIq9Ukf9DYSfjYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SYVHPnlQkGxtCjcPsn2IXHSikzzRv7SMbVfFjbJHhPlurtPwJC6OUA5kjh868ue7aJFfKZCBGSx1QlQ6c6rxx19B3oqK/0SectxDciHh6fbHGOHLuuGr8TivK+s2NwU85MF/Lblt/bzx6E/IjiHoag17G0RpDj3Qk6Sj0Fil5xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLKIiRkQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLKIiRkQ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-248d5074ff7so9497465ad.0
        for <virtualization@lists.linux.dev>; Wed, 03 Sep 2025 11:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756925974; x=1757530774; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qZy30c40uMQ+C5mAmU5IprjDTVrN2KgzxusGEfWx0IE=;
        b=jLKIiRkQhHpi3oN0weyp9ZckubdJXY1MJc8JgbQrh+B6XxW7qWQHR0BkKJNfjwvIEl
         vHJGE3wa7cxTHjDKaTAgQ5NrSQMby9z2jj06w8KL4fLprtWXUwyv24cBZCOEouYgENSJ
         +sFmdqLI7GljXV2+CLSl3QksVkGPk8Pd+Nyt2dSTPl5D4woua1ZWHxcU+kdfb5sX5qj/
         BwyK8qTyi4yhBuISnB05cisGd4QmZhJpDD+zn8Q86OXc9KvCP7OgVQEEB3gkfaeecpTz
         pf7c8HyfehzE6gdxN7P116DrPdjQ2jH3ulDHzJUtURB0oCInxHd+bku8XqF54mlKtQQV
         kWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925974; x=1757530774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZy30c40uMQ+C5mAmU5IprjDTVrN2KgzxusGEfWx0IE=;
        b=EeDjUTe1mQqLZRFzKP7APFkHxdF1yX1XbBRO5npgOsX+0NOOltikWYk4jOWBQQaBtG
         jxNoSuf7pR5XRZpi21PjvvDppe8U4kDUlGi/eJqNLB1QrOfW41ITh88KmZmnldZpCnJn
         G+4o7tzLRcSJ2Wzaj6xfUlVHbvlNulvCRSLGjtOcKaHC3HQ/HvOF/OO/tqoqYWAq7B2D
         eQ9CLvz5cBedsCUYu4WQdxGEz3bI5iKgQfHegqbhWyNA3ENmCM73Un0IdV1BWx1NPSJE
         y7yXXffUae4B/PABtOEIJ5T1rjaP1NCyZs7ItXdPsxvugDtcdDmCpJRxLrkw1mHyiRKr
         XqkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGhIESNfc9nHmVrrOgzOg9ix37fMAmcqA7LWRQsilS6cDFn+SwIMHlS3mHK0aXsXC4AEY7H2JCqiqjaeWVYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNBZwHaFpmKCyy5AHay+2BsFOvF2W6TIM0E1aZKnvI7aZBwnt0
	YKKNrVgtYgIUARTDZ2Ka6ZZeIK8+GzhC+P31bfH7rxaWGMiRqSOM7pfb
X-Gm-Gg: ASbGnctkRYr79SwETwOM7XvNYs3JNen8d7Yd/m8jRJxOt1Ire8AKFOeQqROP2KqaiUq
	WWQ1a+6tFixXDNs3KVSlTzTAnAzUQawKI3Ho7C8p3GWda+oTcn1PFQDRosyzcP5dXqyA5hTlIgQ
	bm1NhxwrjhlbJ1M86/awFM7yISjPrRMrfz3oDuVF3XU+KDaUr8shVqYw2Dk5Eyc3UOZX1izIC19
	x7Z+OidCAbawyhO1K95otXtI8efLQBjjtDsMAXLKk7LWIgc8+LFOLiFHX7hfShzV7RPVJRk7xsH
	JfH98kEM89ij7dLCF3PRyFWQseG30r7KsfNunP34q9iTCzpYEmwhJeBLZED93W1NOSJ01VP88yI
	bDl1GgKhkRldLU10MkUP8dDQ80smWCqObsX4ygUQzccTFrUHm/mWwJA==
X-Google-Smtp-Source: AGHT+IGc1hOCFlrmhtuYXy2RF4eOcL1ED3xkJpQYquvPOenW1RGNO8PJflQF3KtC2IpnrJ0auNPnsg==
X-Received: by 2002:a17:902:f642:b0:234:986c:66cf with SMTP id d9443c01a7336-24944ac387bmr203183595ad.16.1756925973872;
        Wed, 03 Sep 2025 11:59:33 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249065ab343sm169403475ad.126.2025.09.03.11.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:59:33 -0700 (PDT)
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
	Justin Sanders <justin@coraid.com>,
	Jens Axboe <axboe@kernel.dk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 0/7] Cleanup free_pages() misuse
Date: Wed,  3 Sep 2025 11:59:14 -0700
Message-ID: <20250903185921.1785167-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_pages() is supposed to be called when we only have a virtual address.
__free_pages() is supposed to be called when we have a page.

There are a number of callers that use page_address() to get a page's
virtual address then call free_pages() on it when they should just call
__free_pages() directly.

Add kernel-docs for free_pages() to help callers better understand which
function they should be calling, and replace the obvious cases of
misuse.

-----------------
Based on mm-new, I intend to have all of these taken through the mm tree.

I've split the patches into separate subsystems to make it easier to
resolve conflicts, but there aren't any functional changes.

v3:
  - Collect some Reviewed-by Tags
  - Replace remaining free_page() calls in patch 7 (all other patches
    are unchanged from v2)
  - Add all appropriate mailing lists that were missing from v2

v2:
  - Reference __get_free_pages() instead of alloc_pages() in the
  free_pages() kernel-doc
  - Get some Reviewed-by tags
  - cc the subsystem maintainers related to specific patches

Vishal Moola (Oracle) (7):
  mm/page_alloc: Add kernel-docs for free_pages()
  aoe: Stop calling page_address() in free_page()
  x86: Stop calling page_address() in free_pages()
  riscv: Stop calling page_address() in free_pages()
  powerpc: Stop calling page_address() in free_pages()
  arm64: Stop calling page_address() in free_pages()
  virtio_balloon: Stop calling page_address() in free_pages()

 arch/arm64/mm/mmu.c                      | 2 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c | 2 +-
 arch/riscv/mm/init.c                     | 4 ++--
 arch/x86/mm/init_64.c                    | 2 +-
 arch/x86/platform/efi/memmap.c           | 2 +-
 drivers/block/aoe/aoecmd.c               | 2 +-
 drivers/virtio/virtio_balloon.c          | 8 +++-----
 mm/page_alloc.c                          | 9 +++++++++
 8 files changed, 19 insertions(+), 12 deletions(-)

-- 
2.51.0

