Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1667319415D
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587697; cv=none; b=QSdmLrHTxe2TQvj/2hnQQlby6y75KUEYZHSU9FjOK2YTXuu6Edy3rxpdfulvwuti7pyNl+ES26zY450qK/fCVvM5SuHNolVJNXyUTAQbEetn1QlhYc7Hp7b9SNSPKWKb/l7/ITxwKe/xIVbG68UIh3WxkDjDNLxmosD+VuZASqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587697; c=relaxed/simple;
	bh=MENbBPiOyzG6FBgO0rCD/3ta5d0qLTF/n4fv5DxVET4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dS8s2dRTB1XiDDt13tqo7YVPACdtA6BCDWtGsrtleHLMtQMvFnH/b1O7E0QpDY4C/UHuMEnTcdmRKdzVlIiQj4h1NzbH8tU2wV7pZMwf5XzPtV3AMYZdXW4CV9p61qiUCR9UDmlxr6IZ/Ptj5RumBzEzDfBOWKHuIQKgbHpu6+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p39Mrvw8; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p39Mrvw8"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A748182122
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qUzhBI0I12Mj for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jun 2024 11:41:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EF9E582115
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF9E582115
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p39Mrvw8
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EF9E582115
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1A27B61828;
	Wed,  5 Jun 2024 11:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53260C32781;
	Wed,  5 Jun 2024 11:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587693;
	bh=MENbBPiOyzG6FBgO0rCD/3ta5d0qLTF/n4fv5DxVET4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p39Mrvw8AJVDKum0Jwg2kb6k87OxJJJ6NrzWSjUUAw1HBTx0uMsmH4QIVLXMIQSjh
	 gGHpGG50o4vxjchkAer0QNCnDkBV9o8kftuixBD9zQDfl1A74EwF3vGFGAOgdDUt3J
	 jhltzpH8+ixqmF4cy66BaweUitmK0U5TaHrrG7i0qbCCCYYDxf1H7GcZfuSiv3PEH5
	 ODfv8fk9v6erj4Ljcbke3zr58EffgPQNPBd1xbKrR/e1Bfw5dXLk5FkLcBVflIxCHI
	 Bc0UHKuPkQS00F3mFuO5iPHr7YzBmcdN+Gt/nFL77/pTRGZDMKBxiaC+EFfD06kZCo
	 9XJgH9lq5cqLw==
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
Subject: [PATCH v4 04/11] riscv: mm: Refactor create_linear_mapping_range() for memory hot add
Date: Wed,  5 Jun 2024 13:40:47 +0200
Message-ID: <20240605114100.315918-5-bjorn@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114100.315918-1-bjorn@kernel.org>
References: <20240605114100.315918-1-bjorn@kernel.org>
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
index 0dd04cedc0d2..1f7e7c223bec 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1232,7 +1232,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 }
 
 static void __meminit create_linear_mapping_range(phys_addr_t start, phys_addr_t end,
-						  uintptr_t fixed_map_size)
+						  uintptr_t fixed_map_size, const pgprot_t *pgprot)
 {
 	phys_addr_t pa;
 	uintptr_t va, map_size;
@@ -1243,7 +1243,7 @@ static void __meminit create_linear_mapping_range(phys_addr_t start, phys_addr_t
 					    best_map_size(pa, va, end - pa);
 
 		create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
-				   pgprot_from_va(va));
+				   pgprot ? *pgprot : pgprot_from_va(va));
 	}
 }
 
@@ -1287,22 +1287,19 @@ static void __init create_linear_mapping_page_table(void)
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
2.43.0

