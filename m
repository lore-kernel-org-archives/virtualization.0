Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0170194123
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587716; cv=none; b=AHB4vfw1g7K3rKfwQoSWTxfsgMGVEEp35/l9DL4F6tWMtUn8W8+JnC7OPzsxft0nVVZn3onJ2llo7yn9l8sG2KfSb8ZZzRX2+b0YUR/JpKFP5xFjhp3n7Lqy+gCB+Lq3aoLV3iQMZEs7U58kZLjrffzHi9yMHm1XDuLfrywzq9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587716; c=relaxed/simple;
	bh=L6J14KqpfXLFzLpqo0wTWwklGSKZlK82ek5ghR0epQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hx+iMoGnxf+qVQyVlF2blxCmFLrrNn0x+bHCr8KvlL0VqPGfxlxHBguUQ+Kvh2cbtnvoxpYbi3H0Ho46WfvNN8Z9kadn/a8x5NVKaaSkzrq+vlWobKh3PXAb11hLJwSUXM+DsX/fl+hic16hsmFD8HOvL7MgxT7aAZhI6dpdM9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nB+tpFCK; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nB+tpFCK"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8120540B24
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.093
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3H6SJzyNn88U for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jun 2024 11:41:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0F32940AF6
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F32940AF6
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nB+tpFCK
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0F32940AF6
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5040A61828;
	Wed,  5 Jun 2024 11:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9B2C4AF09;
	Wed,  5 Jun 2024 11:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587713;
	bh=L6J14KqpfXLFzLpqo0wTWwklGSKZlK82ek5ghR0epQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nB+tpFCKWoin2Io1tYNh/CpS+b2KOE96Igf2M+PajeAiqjcAwFpQdkIQ1roxi2gFS
	 ybrJ6R3VNsPGfwYETuovRb8MmTUuzJYXMZkdk5PkklSmzl/mvUssCtdc8sq6Nn+608
	 Msnb1PAycmOOBfXZz9FDQCndMLunP+YGOi1F1+qIlP3WKOUwv5u+jFCiovPNw7bR/f
	 mDZYBsTyIzCYUGva5g5QSNHBpM7IOMr7msMbj2JmcxdV3QiHfU6VxtsKG0bPV/tDWi
	 hYQBxxJxkhebALDI+e5GZRgBFT6W8RxUwONIgOVjjb2cDwx5omNGuOKTPYICI4q2OY
	 63QpUaPxQzQfw==
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
Subject: [PATCH v4 08/11] riscv: Enable memory hotplugging for RISC-V
Date: Wed,  5 Jun 2024 13:40:51 +0200
Message-ID: <20240605114100.315918-9-bjorn@kernel.org>
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

Enable ARCH_ENABLE_MEMORY_HOTPLUG and ARCH_ENABLE_MEMORY_HOTREMOVE for
RISC-V.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0525ee2d63c7..8d860ad3b171 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -16,6 +16,8 @@ config RISCV
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
+	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM_VMEMMAP
+	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_BINFMT_FLAT
@@ -46,6 +48,7 @@ config RISCV
 	select ARCH_HAS_UBSAN
 	select ARCH_HAS_VDSO_DATA
 	select ARCH_KEEP_MEMBLOCK if ACPI
+	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
 	select ARCH_STACKWALK
-- 
2.43.0

