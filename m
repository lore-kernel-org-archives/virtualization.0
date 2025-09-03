Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273EC369975
	for <virtualization@lists.linux.dev>; Wed,  3 Sep 2025 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925981; cv=none; b=mktDX+m7oPJh1qn9cDWAzUxMGLf9/jhno+hys8KK2HuXOgtijmH8YGlBVYfAxA5N5K3ieLj9/vOn3PaDvrmqe3/NgW+GopsWBzBUvvij+IsZ4Z93fQp3QUq8pW0Dxrt6S/yt6nFej7TfI+uCPTziG1tJLwbxYBKXocontkL3SIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925981; c=relaxed/simple;
	bh=tDJPTP0lhO5ivDTkZpNt7Rd4fQWnznv9kl6iZmQUTXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rxv841Ru1z1D1+aipUUg3z5NhleYjAEWnSskKs94n0+NuOTSQocwlCPr95vPgNWIXqJ3ldmYE7USXx8HVwkRcSzlDvdP9yVgJxtBj7X4a7ObgHK8bV2GnynXXmk3Gbmn1bhwQpCvsT4jTsOn+XTUuwFDZF17EPxRZVrUvUB2gfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2gG5nAf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2gG5nAf"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-248ff4403b9so2723915ad.0
        for <virtualization@lists.linux.dev>; Wed, 03 Sep 2025 11:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756925979; x=1757530779; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wz/bZSqqVx6pRJeL2TZzvIUdrr6/vXiyt+C/9X3zJM=;
        b=P2gG5nAfKgYEI3OQlbbpYPv4aAI/y4IjIRa3lErYshzUWJ6BUKdBvtIf3X1RyKvm8n
         fr8L8OzLXWPGcdHnspXM6bDRJBuulRiS8rCHHd595Is/Hd5kxmxch8nPob4CaWZuxSlU
         zzblk7gF3mhLoafGPkjgQoXZi4xsR9OmmM9oDoRDLpcr2le7aAzmrcVWfk1pWf2D9EPt
         YRt7HLQ5qJUkHmbxZCdKCoNoYJyLA0PehoniKk+2CFnuxkRaF/CS5yG/Eu6IcEB6C5QP
         XqNSUOUMh81eYjlgDlFHiLnLMR1zaoRoDV/GbwQuZfBnyliXMd9em/mpZ82q8XVoL6OV
         hVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925979; x=1757530779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wz/bZSqqVx6pRJeL2TZzvIUdrr6/vXiyt+C/9X3zJM=;
        b=oX1I5j7SKxe2UzE8Nq/RFIIeWikUAL/6jpQm6MYPrVc5cPItBsLbgCxSYh1lYUYSRn
         9SYzD1BYMRDVc2j49/JK2SgTToxrCAr6smhPkYGyA96UShy9FjerblXhQGss+Vdih+Dy
         hpTMgy/BBEYSZt5gbuJmeVldVtTvWM9WX1j8KjtYLEiGGNhIHVgXkSqDOHHTfz9RUVrn
         /fYCVG6qsguLL9Dhn5tKa9RV6DrfjCuozpz5ndf0VBV5irH42MYjR1ruDscY4JO47eep
         JZVOSnzQZyYhZ2s4DXqOffOEHbzLfW8gO1dhLm90GgALTF+GUZV108z7g1BbX+Cgw8lY
         3A/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXik2Nz7yGlURtFS/G9ql6qi7eGlJN1ZMYC6EznE3GOcmNG6UE9OhqeGgHQJ6VQwLQIc/wjgPBfZ+W0ve1xkw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx22zdPmZdvwMJqeJRMmSQ0Buo7O3WADHhQrzp6g+ymRCnFtWgQ
	gtTEfjXyzPVT6s9PWPObuUGjlAQeG97nSRBdviJNW5y2SoMBGii/B408
X-Gm-Gg: ASbGnct9nYYF0muJa6bU3D9Wy/JZWbrQ6+jvJlOK1WZA9EBQoQKngOlTDA2SHW83E2z
	SBSRhRZE3Ez7FPb91bu8bvhhRYIBtAoVqSClClyDG+fydiNXrzFCR5/3MrcCCrU1k3Jtif6t/bH
	U/UZ7miv3dXSuGG+X64Zhre57f1MUGecgvRfWYfdwYmgnoV9KWW3ILDCXuTPaxg9JjWqCcilR0a
	ASGzGCqNpJZ4dVNEDiOAdNKSWIB1w5GFVD05dn0IkHVc+tqrkUalDBQoTYAXlvDSlJST/e6dhcd
	L7aIbIrNN7XpPt5m84p5pkadr5kmY1qeiqQgTxrowp8e5XPi05/H+QhtZ/QCT6mhicBhVK8O6vF
	45tnrOzn/QgD3U0/HYeu5nNwiIQYfRvYNGQhLX1yljxIC1AzOnCjReg==
X-Google-Smtp-Source: AGHT+IFLYxGq/uXWczWSmoJ4dYmB1R4jOWZAcKlvb1pf3KqvOH6hTCxx8eQlFrsP54M7TPt133nTbQ==
X-Received: by 2002:a17:902:f789:b0:246:d383:3964 with SMTP id d9443c01a7336-249448ac3c8mr239306545ad.18.1756925979423;
        Wed, 03 Sep 2025 11:59:39 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249065ab343sm169403475ad.126.2025.09.03.11.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:59:38 -0700 (PDT)
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
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 3/7] x86: Stop calling page_address() in free_pages()
Date: Wed,  3 Sep 2025 11:59:17 -0700
Message-ID: <20250903185921.1785167-4-vishal.moola@gmail.com>
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

free_pages() should be used when we only have a virtual address. We
should call __free_pages() directly on our page instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/mm/init_64.c          | 2 +-
 arch/x86/platform/efi/memmap.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index b9426fce5f3e..0e4270e20fad 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1031,7 +1031,7 @@ static void __meminit free_pagetable(struct page *page, int order)
 		free_reserved_pages(page, nr_pages);
 #endif
 	} else {
-		free_pages((unsigned long)page_address(page), order);
+		__free_pages(page, order);
 	}
 }
 
diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
index 061b8ecc71a1..023697c88910 100644
--- a/arch/x86/platform/efi/memmap.c
+++ b/arch/x86/platform/efi/memmap.c
@@ -42,7 +42,7 @@ void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
 		struct page *p = pfn_to_page(PHYS_PFN(phys));
 		unsigned int order = get_order(size);
 
-		free_pages((unsigned long) page_address(p), order);
+		__free_pages(p, order);
 	}
 }
 
-- 
2.51.0

