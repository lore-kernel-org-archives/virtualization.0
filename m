Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDAF7711D
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292146; cv=none; b=SeB4QOWwHmy4r7gi7sZZym/JA2gJ0hGnYJctuTxpIoTnKC33tsTnEVf6DGWmCJl4P+FAQr6t8gDfT4DtMexHTLentykpOw/j3/Cvcl4G1jxbHDf4azS7wSZmFHJLmHPLXmWekH0f/pkPpV/ItVwUHbqkthXD0gVPxZHlhpI6zZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292146; c=relaxed/simple;
	bh=OVWdCLBgos2+PxBgxUayZBCsMHg1Thrc2DYHTXT9Xk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Unx04ffGUg96DB73AVXBLTtcju1Yqrz3lZirAakrOFHfMDyqLUzxXGVpoYBZyIGHeD0tIWyuOZxw26HEu2r2GAwb8cKUPI8L/YWF8YHD8bUzlhEwfjwpHItNjr+RzE3jvV3mMt9ylCpVNn575Kqq1TrfD9t7faXs3WHsAUMTz4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuFto51Y; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuFto51Y"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DDE7E41503
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:49:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tC8XflKJIj37 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 11:49:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2B056400DC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B056400DC
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JuFto51Y
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2B056400DC
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:49:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 71891621B6;
	Tue, 21 May 2024 11:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A029C2BD11;
	Tue, 21 May 2024 11:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716292143;
	bh=OVWdCLBgos2+PxBgxUayZBCsMHg1Thrc2DYHTXT9Xk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JuFto51YhlnEYtIE5p7m81bgvn/FesIVCWWQrgta9FQ3B2VFM/MCwDRyv7PAP2PlM
	 OcGLM/qjlm9yHvJ42jxE/UVj9EaiKy4E4zOVTD7Aea+fGMPCYzFxrVrBmSXy/h4HDF
	 t926Rbef+QZc/5v6EBJZ92qopYPJAzrENcM/2kOdAKCneRJkyCJGk4uZ6XvWBnWTNY
	 UE0khZMgvG8QpNoNPeaJxOTsVFSCWY8XS77MDoU002hcPtheNG1MeEYymcH5WPgVDs
	 MmithN7NtP4w31zwP1/4w2/Ea+uNEwNZpSwC/G3ClsBE05NPIEj8Isbdxl0d8R08Xw
	 kjhfVQUKhzJew==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Oscar Salvador <osalvador@suse.de>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v3 4/9] riscv: mm: Refactor create_linear_mapping_range() for memory hot add
Date: Tue, 21 May 2024 13:48:25 +0200
Message-Id: <20240521114830.841660-5-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240521114830.841660-1-bjorn@kernel.org>
References: <20240521114830.841660-1-bjorn@kernel.org>
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

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
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

