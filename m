Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9CF144D3B
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695521; cv=none; b=I40jQjiGHVn/eCRujWktGJt0P/hTniGkozhTVTs41y6CSW+Gtd8wLfQzC/iGIEmnFi7s9qDUKLICseh23xGaUaZaNMucNFk9Oj1BFtAjtpcs9vUbtUEhND4JYO/JR+aHuAXlCDrG0Hgu9063nisOymDo3ur9TeAeGcPilw1lEtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695521; c=relaxed/simple;
	bh=pGRP84KXNHRvDwj4d3tBEvZ5yXWiOvKEJ5ie6tEwIpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eh4p+/0ykcBASa1tS15NTKu8IesUArpi8zveLAdC+v8luJeZr90emVfhmAHryUag7Po/EmKWMvjIW/lsfY9dTPfkxEr8XRDFV3GP28OSZAv85D6JcYMEFAPtJUfscr1lOLCm9pWeRRnnX3LbeM9fMU5Lfavh/8tJGtw9NxDGNGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tutFg42F; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tutFg42F"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17A5C40930
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pgLKSrI-sjPE for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 14:05:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0967C40785
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0967C40785
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tutFg42F
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0967C40785
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3183261276;
	Tue, 14 May 2024 14:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B219C32781;
	Tue, 14 May 2024 14:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715695518;
	bh=pGRP84KXNHRvDwj4d3tBEvZ5yXWiOvKEJ5ie6tEwIpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tutFg42F+WZxo8OqjmYracQbf76JUHyChIpewLcaBxxXzAHL9f9NzUzxKpCwPQPMp
	 JAOf7a5DMjRYICN6Zd3nayVU2QucQqYBCAI8sN3NmvDZjznrg3QP+0FsKPkhBf5X1d
	 DjQUz7i2J5ltDjh2koA8AsRmQ0kDN4rVWu0JQFdPf4Vmy6PaVJo12jabRGD99LsIn6
	 QsnhffWfY2J+BIqE97O1tmA6XlKvqzaJOazwfm63YK7bQUZNkTJ0dnTNMdXBkL3W1n
	 IXNollIatVKhq1PFO/MKuIo9s9ffetE+5TaxWGUT6CgxwvGg7EYhSFKTurXIn/mT0T
	 2VnjGlsE++ceA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 3/8] riscv: mm: Refactor create_linear_mapping_range() for memory hot add
Date: Tue, 14 May 2024 16:04:41 +0200
Message-Id: <20240514140446.538622-4-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240514140446.538622-1-bjorn@kernel.org>
References: <20240514140446.538622-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

Add a parameter to the direct map setup function, so it can be used in
arch_add_memory() later.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/mm/init.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index c969427eab88..6f72b0b2b854 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1227,7 +1227,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 }
 
 static void __meminit create_linear_mapping_range(phys_addr_t start, phys_addr_t end,
-						  uintptr_t fixed_map_size)
+						  uintptr_t fixed_map_size, const pgprot_t *pgprot)
 {
 	phys_addr_t pa;
 	uintptr_t va, map_size;
@@ -1238,7 +1238,7 @@ static void __meminit create_linear_mapping_range(phys_addr_t start, phys_addr_t
 					    best_map_size(pa, va, end - pa);
 
 		create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
-				   pgprot_from_va(va));
+				   pgprot ? *pgprot : pgprot_from_va(va));
 	}
 }
 
@@ -1282,22 +1282,19 @@ static void __init create_linear_mapping_page_table(void)
 		if (end >= __pa(PAGE_OFFSET) + memory_limit)
 			end = __pa(PAGE_OFFSET) + memory_limit;
 
-		create_linear_mapping_range(start, end, 0);
+		create_linear_mapping_range(start, end, 0, NULL);
 	}
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-	create_linear_mapping_range(ktext_start, ktext_start + ktext_size, 0);
-	create_linear_mapping_range(krodata_start,
-				    krodata_start + krodata_size, 0);
+	create_linear_mapping_range(ktext_start, ktext_start + ktext_size, 0, NULL);
+	create_linear_mapping_range(krodata_start, krodata_start + krodata_size, 0, NULL);
 
 	memblock_clear_nomap(ktext_start,  ktext_size);
 	memblock_clear_nomap(krodata_start, krodata_size);
 #endif
 
 #ifdef CONFIG_KFENCE
-	create_linear_mapping_range(kfence_pool,
-				    kfence_pool + KFENCE_POOL_SIZE,
-				    PAGE_SIZE);
+	create_linear_mapping_range(kfence_pool, kfence_pool + KFENCE_POOL_SIZE, PAGE_SIZE, NULL);
 
 	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
 #endif
-- 
2.40.1

