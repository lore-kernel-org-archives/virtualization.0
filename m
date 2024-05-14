Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DAF14A612
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695540; cv=none; b=fHtKmT/MdODCJnBbfMFRAwd+aT5wIGFEuTBsZIqEV4hl0W91CsZVg/Btxgv5LXLVVAVwV3un6xA5mBw/+nY422mksDKL599V90ylHjdoBbVRk28MoAMiTiXvyfTZPjXO/ZnCzH3dOL94v/WvgDMzml0b+xwzYleWM4NqBULfcH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695540; c=relaxed/simple;
	bh=0+IP68HpeOuix87ttHx6QCBPaROV37lTjVVbI88agM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y65Lj8uBNCYzuIsdv5l6O40MyPrhNDAOg7I+gwyPScM7HI2yb+ldLcjWjz1EhqittnVXieSS940uBXG3jpyaQn6il+z+++KwGtj/W++/+RK9FQoDZdFskDea2sV6B808/qEIlMPKmhIvpYxl20PCUnKAmuapdMO5UDbfzUeMJwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0t8ZY/k; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0t8ZY/k"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7AC7D402E8
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.393
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1oHEqmax0ePB for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 14:05:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E3326403C7
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E3326403C7
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=T0t8ZY/k
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E3326403C7
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B05FBCE127B;
	Tue, 14 May 2024 14:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D16C32781;
	Tue, 14 May 2024 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715695531;
	bh=0+IP68HpeOuix87ttHx6QCBPaROV37lTjVVbI88agM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T0t8ZY/krMImQEE1pbX37Lqd9otojKaCNU52Jdf+6IsnQPuwbjYf/17i4Dfm9wU/N
	 cG8ZVIKuEChYfl+ArN6nlpcBLN94ethBeWZaRLHF2O26wOR/YjsM4iypPJlep2EOIs
	 WnQduiMtRTX6HihYJYNGu+Zvx4ZfY6kifpj7mrb3c0qzOXrMObRZ+pyv1Di+53Y4BR
	 yVzogJGugSULHDBgRoPYVq0AQf3NMvV11V+DCtVicxdz9nCIPrBc3BZjkQibvEOlkP
	 LsDeyAlUKQ2u6jbtG/qyTzE50IDMatmyZSG5pDBfnCFVFZOhVoq3W+Su/3lVcXaMJx
	 OvCy8N0USQs3Q==
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
Subject: [PATCH v2 6/8] riscv: Enable memory hotplugging for RISC-V
Date: Tue, 14 May 2024 16:04:44 +0200
Message-Id: <20240514140446.538622-7-bjorn@kernel.org>
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

Enable ARCH_ENABLE_MEMORY_HOTPLUG and ARCH_ENABLE_MEMORY_HOTREMOVE for
RISC-V.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6bec1bce6586..b9398b64bb69 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -16,6 +16,8 @@ config RISCV
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
+	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM && 64BIT && MMU
+	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_BINFMT_FLAT
-- 
2.40.1

