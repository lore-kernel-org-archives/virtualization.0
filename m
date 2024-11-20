Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3991A4F02
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Nov 2024 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732108334; cv=none; b=mvbj5JnyPdrIerBeBCR5D0K30s+rkHoBvsRNIPCHz8cQNTxHs0y9Aqku9njUIWF8W/3uiYfWQYE9/3pm5d6xzQ9lHeO0q7rgFUaEFz1/zjLX+M36bXYXNNaL4smMKh2e95VIBAzcTr+pWcTQzSRF1wV8QoIDb5D5LCKE7X6vGvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732108334; c=relaxed/simple;
	bh=k+5dEYh0Wx0gYDwBov9cnbkAU6CMVjt/gVpf33OC/N8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oej8EBZaIKsPH9jqQt8sxSQqb8aes6Vr3y5aFw8v7WxQZVNj02iVcCx0zvUHym/O2Di19AFMyb2IeppYMoBUnkWjZKgjiahVhSgRqDM19r5OvQqvtkA5BJykinToacoDrfq8+jchWmuwJXKQVfc3ZmTybaXC6drw2GIw83LE6G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGZhu9Dw; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGZhu9Dw"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1ED340814
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Nov 2024 13:12:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UlB1wD4SvNXF for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Nov 2024 13:12:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9F0F34070F
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F0F34070F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jGZhu9Dw
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9F0F34070F
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Nov 2024 13:12:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 66B385C4C65;
	Wed, 20 Nov 2024 13:11:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB08CC4CECD;
	Wed, 20 Nov 2024 13:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732108330;
	bh=k+5dEYh0Wx0gYDwBov9cnbkAU6CMVjt/gVpf33OC/N8=;
	h=From:To:Cc:Subject:Date:From;
	b=jGZhu9Dwi+lGk9ZsjijKZtKKmfps855+KQDnqkWJagaRykvm2OPjoa3N7MXkOMafs
	 TE+QWilPmnA3oHJchvWXEJw1WePCqb4iEZzbli7EjPOJcdSJGkR7Pl9HO21Q2LWteL
	 eAwdFkF+dvkwEOJ2xB+30+nVCbEYibc1HqmsSgV7/nIoBve5Db+l6ZIACcoiViKHcT
	 cccKAxYjyGLTsGykPjnZ4z1n8KFZXypqjklh5YxiP+OM3MzFg21y6pHacUYDc1qedp
	 H6ayz5UPejtY03knpY4awE4AgRy3FByrk7wJdPB4tmtz0/3GEmcJTYBrmhvSGk1mN+
	 a9rDfMwo0nRnw==
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
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH fixes] riscv: mm: Do not call pmd dtor on vmemmap page table teardown
Date: Wed, 20 Nov 2024 14:12:02 +0100
Message-ID: <20241120131203.1859787-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

The vmemmap's, which is used for RV64 with SPARSEMEM_VMEMMAP, page
tables are populated using pmd (page middle directory) hugetables.
However, the pmd allocation is not using the generic mechanism used by
the VMA code (e.g. pmd_alloc()), or the RISC-V specific
create_pgd_mapping()/alloc_pmd_late(). Instead, the vmemmap page table
code allocates a page, and calls vmemmap_set_pmd(). This results in
that the pmd ctor is *not* called, nor would it make sense to do so.

Now, when tearing down a vmemmap page table pmd, the cleanup code
would unconditionally, and incorrectly call the pmd dtor, which
results in a crash (best case).

This issue was found when running the HMM selftests:

  | tools/testing/selftests/mm# ./test_hmm.sh smoke
  | ... # when unloading the test_hmm.ko module
  | page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10915b
  | flags: 0x1000000000000000(node=0|zone=1)
  | raw: 1000000000000000 0000000000000000 dead000000000122 0000000000000000
  | raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
  | page dumped because: VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte)
  | ------------[ cut here ]------------
  | kernel BUG at include/linux/mm.h:3080!
  | Kernel BUG [#1]
  | Modules linked in: test_hmm(-) sch_fq_codel fuse drm drm_panel_orientation_quirks backlight dm_mod
  | CPU: 1 UID: 0 PID: 514 Comm: modprobe Tainted: G        W          6.12.0-00982-gf2a4f1682d07 #2
  | Tainted: [W]=WARN
  | Hardware name: riscv-virtio qemu/qemu, BIOS 2024.10 10/01/2024
  | epc : remove_pgd_mapping+0xbec/0x1070
  |  ra : remove_pgd_mapping+0xbec/0x1070
  | epc : ffffffff80010a68 ra : ffffffff80010a68 sp : ff20000000a73940
  |  gp : ffffffff827b2d88 tp : ff6000008785da40 t0 : ffffffff80fbce04
  |  t1 : 0720072007200720 t2 : 706d756420656761 s0 : ff20000000a73a50
  |  s1 : ff6000008915cff8 a0 : 0000000000000039 a1 : 0000000000000008
  |  a2 : ff600003fff0de20 a3 : 0000000000000000 a4 : 0000000000000000
  |  a5 : 0000000000000000 a6 : c0000000ffffefff a7 : ffffffff824469b8
  |  s2 : ff1c0000022456c0 s3 : ff1ffffffdbfffff s4 : ff6000008915c000
  |  s5 : ff6000008915c000 s6 : ff6000008915c000 s7 : ff1ffffffdc00000
  |  s8 : 0000000000000001 s9 : ff1ffffffdc00000 s10: ffffffff819a31f0
  |  s11: ffffffffffffffff t3 : ffffffff8000c950 t4 : ff60000080244f00
  |  t5 : ff60000080244000 t6 : ff20000000a73708
  | status: 0000000200000120 badaddr: ffffffff80010a68 cause: 0000000000000003
  | [<ffffffff80010a68>] remove_pgd_mapping+0xbec/0x1070
  | [<ffffffff80fd238e>] vmemmap_free+0x14/0x1e
  | [<ffffffff8032e698>] section_deactivate+0x220/0x452
  | [<ffffffff8032ef7e>] sparse_remove_section+0x4a/0x58
  | [<ffffffff802f8700>] __remove_pages+0x7e/0xba
  | [<ffffffff803760d8>] memunmap_pages+0x2bc/0x3fe
  | [<ffffffff02a3ca28>] dmirror_device_remove_chunks+0x2ea/0x518 [test_hmm]
  | [<ffffffff02a3e026>] hmm_dmirror_exit+0x3e/0x1018 [test_hmm]
  | [<ffffffff80102c14>] __riscv_sys_delete_module+0x15a/0x2a6
  | [<ffffffff80fd020c>] do_trap_ecall_u+0x1f2/0x266
  | [<ffffffff80fde0a2>] _new_vmalloc_restore_context_a0+0xc6/0xd2
  | Code: bf51 7597 0184 8593 76a5 854a 4097 0029 80e7 2c00 (9002) 7597
  | ---[ end trace 0000000000000000 ]---
  | Kernel panic - not syncing: Fatal exception in interrupt

Add a check to avoid calling the pmd dtor, if the calling context is
vmemmap_free().

Fixes: c75a74f4ba19 ("riscv: mm: Add memory hotplugging support")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/mm/init.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0e8c20adcd98..fc53ce748c80 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1566,7 +1566,7 @@ static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
 	pmd_clear(pmd);
 }
 
-static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
+static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud, bool is_vmemmap)
 {
 	struct page *page = pud_page(*pud);
 	struct ptdesc *ptdesc = page_ptdesc(page);
@@ -1579,7 +1579,8 @@ static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
 			return;
 	}
 
-	pagetable_pmd_dtor(ptdesc);
+	if (!is_vmemmap)
+		pagetable_pmd_dtor(ptdesc);
 	if (PageReserved(page))
 		free_reserved_page(page);
 	else
@@ -1703,7 +1704,7 @@ static void __meminit remove_pud_mapping(pud_t *pud_base, unsigned long addr, un
 		remove_pmd_mapping(pmd_base, addr, next, is_vmemmap, altmap);
 
 		if (pgtable_l4_enabled)
-			free_pmd_table(pmd_base, pudp);
+			free_pmd_table(pmd_base, pudp, is_vmemmap);
 	}
 }
 

base-commit: 57f7c7dc78cd09622b12920d92b40c1ce11b234e
-- 
2.45.2

