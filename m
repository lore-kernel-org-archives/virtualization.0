Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3D5199231
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587720; cv=none; b=Cl08Sfib6t1iogbZjOkxxrEW9d4UwwYg4/tJs2WRVdbSQYCZ77+wTTnef4GTWHzKaUnmtLC1DPoDRSxu8JwUlDu2062SXyB0SOQXkwcMrQaIIMFXzWtFfuVT0u/p55D1FHRxbhKLcfO3RShK2DqdeCMRYtChJNke9dpK000KocM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587720; c=relaxed/simple;
	bh=JhdeFloFX/xxhqkxVxMkwy3o8a+I7NU1Jr3K3J+2XHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=smA8Dne9s8ZlwUF5AU8/zEZpntWzkSLX6uWGhS+6Tkj4dKxhT1BUqaFvZb/pM1RQepCIc7kp2qv9HxM8AthtmBQsZALKDuDZjiCtx4vPUFo7pISpJRuh7dR+kZqaCLryi2/kyMmg86mpSerZDvkskriAU92CquQFn/0bARXolnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yo0tPcOU; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yo0tPcOU"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CB9C6107C
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yEutHAaEiUCH for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jun 2024 11:41:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 85CA461072
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85CA461072
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Yo0tPcOU
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 85CA461072
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 48605CE1774;
	Wed,  5 Jun 2024 11:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EA3C3277B;
	Wed,  5 Jun 2024 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587698;
	bh=JhdeFloFX/xxhqkxVxMkwy3o8a+I7NU1Jr3K3J+2XHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yo0tPcOUDWbZKgAZCcnplN/Tpng+rYhahCirtGosu22vfbqUpPcHwDQA6k6SFhOAV
	 ZJqZbW2Hub+7wW8blIcchz+3RvICwE2f/9Ybv7CyKA+D07H53Ebb5i0DPEtvRVmP7+
	 +UJZgr4Sp39itexUAPNROpGAAJDUgk4oCvOQX909f0SpiDFFPHsojDG2bl1yDM6WIT
	 1SeA46LAIXR14O9bfozUPdydSqNyrw8nINXW38klf+p8XKmw4BCQ/CsmeOD9GOvQFi
	 hvRgm5Ntqz+0/jK4n1J/g/BIAKDgmEOtQ2+tEApA0MTtkbTxYZ4HxLyqMrMU4Yz12A
	 PHsFFb2fJFJpQ==
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
Subject: [PATCH v4 05/11] riscv: mm: Add pfn_to_kaddr() implementation
Date: Wed,  5 Jun 2024 13:40:48 +0200
Message-ID: <20240605114100.315918-6-bjorn@kernel.org>
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

The pfn_to_kaddr() function is used by KASAN's memory hotplugging
path. Add the missing function to the RISC-V port, so that it can be
built with MHP and CONFIG_KASAN.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/include/asm/page.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 115ac98b8d72..235fd45d998d 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -188,6 +188,11 @@ extern phys_addr_t __phys_addr_symbol(unsigned long x);
 
 unsigned long kaslr_offset(void);
 
+static __always_inline void *pfn_to_kaddr(unsigned long pfn)
+{
+	return __va(pfn << PAGE_SHIFT);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #define virt_addr_valid(vaddr)	({						\
-- 
2.43.0

