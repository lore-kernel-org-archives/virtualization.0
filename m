Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F757B3E1
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292160; cv=none; b=AiRlznHNmMhEtjhmyJcDzf+P4fGW06jYLaJbL10M3GbWzxx/2Awuoz+zrrIZ7nMTGzhziDItdRl6TLKKoOYdm9iZJADK/Ats/URmKXgl4MxIvdnj3JReJ1ukd8Ezq/RUOR00TA18b1j5v6IJDGTGLIR32Ln/duGYqxBeP2eITgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292160; c=relaxed/simple;
	bh=i0Ih+w27uGb8ApwJcyy8K/wXBEe5AomGLiW94Z7779U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ng6Do/NOUpZ2OJ+nvVJNqN1FOQT2b2L5arpyY7wPxlccPrML20AORRKkgkTOY9dd0N3fES6W4nTfWySEYojgduwc5s2N1SINa2BbuaIfRqYVEhm5I0eKLnRWRob7W+c6XyUPydC0Z8USClq6DxDffPrJ1z3j1ZE+K2WC2Zqgkmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEzghIrA; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEzghIrA"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE70A608BF
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:49:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.093
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PcnWX2cHwyyc for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 11:49:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1DEBD607C5
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1DEBD607C5
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UEzghIrA
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1DEBD607C5
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:49:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 20AB662213;
	Tue, 21 May 2024 11:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3296AC4AF0E;
	Tue, 21 May 2024 11:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716292155;
	bh=i0Ih+w27uGb8ApwJcyy8K/wXBEe5AomGLiW94Z7779U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UEzghIrA4Xj8E+KJcv5rV4Fg3OTCWpAUwdbjYoPWT7gVOSRV6SQWe8m/tqWm/Z9j5
	 LOq8iVVDdA9rPeFRqn06kyALX/Y+uzSJpXu3xND6BGYItuRbp/7eyMzvWoJ0sru44g
	 x4d1w6d0UF1SDAapeQK/4zR5j4SC+2FuKlwzMgObcR/47F8hL81htaSV4Rnu0ZDg4e
	 fEo46pfirWJf5acsZojEOXkrupLGS8O0Hsh4ukXb9lgUJXlztR8hWESUBNwCG8lIb8
	 KgEaYeUmtF8QkqoLyQKmF8kJUAICzjbt8epkz2evCCZ1IFxRnNAHVmemOu17uDk2yJ
	 LmoRZmxGAxPhQ==
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
Subject: [PATCH v3 7/9] riscv: Enable memory hotplugging for RISC-V
Date: Tue, 21 May 2024 13:48:28 +0200
Message-Id: <20240521114830.841660-8-bjorn@kernel.org>
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

Enable ARCH_ENABLE_MEMORY_HOTPLUG and ARCH_ENABLE_MEMORY_HOTREMOVE for
RISC-V.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fe5281398543..2724dc2af29f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -16,6 +16,8 @@ config RISCV
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
+	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM_VMEMMAP && 64BIT && MMU
+	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_BINFMT_FLAT
-- 
2.40.1

