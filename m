Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129DA369975
	for <virtualization@lists.linux.dev>; Wed,  3 Sep 2025 18:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925983; cv=none; b=HRjr+EtCN7dYlCEJhbsfyz5kf6ecQUgTE76c2CJLdjzOZRshvaq5jIkeU9ogFd+cEoFtYyOJASp0aL+KFLrS6H67ZWOj4BshlgfnCh3CSSoPbZHKF4429xZBtBQoqWtBUcnT9RPT3aZOvIheitDFBwCyKL77RY2T7v9T4tN1sw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925983; c=relaxed/simple;
	bh=hMxsFCbfS4FNJ5KpQPQ814MUfYn5DLMes7LkACjORbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BV9bG+Cf062mEbqkUeHd9Pb/4yL2VJ/lzO/X1kr3MTcq1yZQW1w4r1HlLULuKgRY1XPhLB7Gv5F1i9uaXbLW8iKBUD0KZn4/y29LcgSeFCGdCyr9+MqYR0YULGWuqzsHNiACq11UmGyGgdd3/nCqYhEGyvc0Qb6+FZClSszC8JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTVk+ZcK; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTVk+ZcK"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7724fe9b24dso190648b3a.2
        for <virtualization@lists.linux.dev>; Wed, 03 Sep 2025 11:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756925981; x=1757530781; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tE4h8lAMatl8zOgx47ZsHYZprqFSGIay3bVnFsp5zpE=;
        b=hTVk+ZcKGZwfh2CTHRWy4oOuK+lB8P6XBtUqF1JBIlcfU1OsRzEt7kjj10r3HVhjrM
         OVL+V+dyUf5n9+D3QWH+0T4nrEoZ+8T/0r6Qo8SkdeC4It+TyklbXgfUaz+h1qEzzbQz
         ie69iozKlsRoP+K3O5uxt/D6yWBMPUfFZ79AK6CkFImRdRfVrB79Rv+w0PzQY1Zf7tA+
         Q0tDhnMnCndmP4EFgd4/VNbfDAzlr3UXDqf6Cep2iKFjYLMCaBpvL9N5oGRojaN1EbcQ
         MKJ7EeWQMhBctiNwoOvG5Vzcpd9P1ywHEGPTRbPUvSvObT4FTSofmCYgFfPVO51/gaFI
         N4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925981; x=1757530781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tE4h8lAMatl8zOgx47ZsHYZprqFSGIay3bVnFsp5zpE=;
        b=UTAAPnviJVCxxms7z1fziBGhQao//a3q/KLC+expL6eywKFOQEgt95HTG10obEbOBB
         DLbmFLpTjcM5JCwE4S6NWIEtmycG5WFFATjZ58dwCL97JPffnVsbOhSJXMkg6l63HXn0
         lGvANuapfXsAa7vthD215ql+TUBe9FMoLDgC232tma/ONaMTuSwXWOoi5JK4oIRPwxv8
         J0e/o9r1TAkaHwr0a9C8vQZXb2EZKlDir6CB1sMbrtXG9YJ4siiXWZTGjTFfoBWVfQCt
         FSHz6NIR1r48RdfYHnpLxnV/UMpHMFNLSOz1yK2nRblnIWxu/8U2b5AlEEi8TZd9ZY7R
         kMCA==
X-Forwarded-Encrypted: i=1; AJvYcCXL2Vz+KIlyU0V4MBoX2YxVoZ9Wp0kuiBd9mx2zj1WqUKfAuCj/KU3nuo00vgIy0NXEBCaWCUwwPkPhoQDQew==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrumfLaeC10jvvAkn0X1hPo5KMcScSduNJR11tuuOlH5922jJn
	VunNQ26GsceGU/esGuzM2hpU8bJcQcaVrE1hMmR23q+4+FPQa8hVHQNI
X-Gm-Gg: ASbGncscrLACWGW11ECjZTVzUeol/IKaqRvP3QWyRgS7jbPf8H+k3k4cmCblv8nZYmL
	arxieKzk5oDJExl8gVaLN7NgKVogeUBzxwK2tnOpwGxvJIaHxT0lH9sclDhj8bsqamxOjqVnJkJ
	bAHMhVBDOozmjWsnx4yJoawkL+RfscYez8vdstDnA6nhSWsricu0JBiGojS5cSA8rOkuEgc1Yqk
	V0X0ciQfeSkfd1nc5dciUjLeOBFAuYM9qfS3jhy6OUPC+0rxI0OdIAdICCQq37dsLvO9+670BBN
	+kQhcezmfCJomQQKqmLHSuD7udYBJwNhh8bwAhU0kfLmbzzKa+Y/zUXtiOMipJINNt/Noo75fLA
	4hRiouNFYNz12ISxCOiTCM5Rp2sw5iSKYXsaIrikzK570Zok0CbVkNPuNC5I8ngo9
X-Google-Smtp-Source: AGHT+IFOzZVS9DP4L6Y226muKjeIB1JH5DNA05hxxzbj7ORa/S2amssbHzjMdMYqRSy3xMpxXA++JA==
X-Received: by 2002:a17:902:cecc:b0:24a:aeb6:f1c8 with SMTP id d9443c01a7336-24aaeb6f63bmr166407785ad.43.1756925981346;
        Wed, 03 Sep 2025 11:59:41 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249065ab343sm169403475ad.126.2025.09.03.11.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:59:40 -0700 (PDT)
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
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v3 4/7] riscv: Stop calling page_address() in free_pages()
Date: Wed,  3 Sep 2025 11:59:18 -0700
Message-ID: <20250903185921.1785167-5-vishal.moola@gmail.com>
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
---
 arch/riscv/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 15683ae13fa5..1056c11d3251 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1624,7 +1624,7 @@ static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
 	if (PageReserved(page))
 		free_reserved_page(page);
 	else
-		free_pages((unsigned long)page_address(page), 0);
+		__free_pages(page, 0);
 	p4d_clear(p4d);
 }
 
@@ -1646,7 +1646,7 @@ static void __meminit free_vmemmap_storage(struct page *page, size_t size,
 		return;
 	}
 
-	free_pages((unsigned long)page_address(page), order);
+	__free_pages(page, order);
 }
 
 static void __meminit remove_pte_mapping(pte_t *pte_base, unsigned long addr, unsigned long end,
-- 
2.51.0

