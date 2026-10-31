Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793406802;
	b=th7TWieJa6H29ttXoPOMIYgj47CeCDRUu6G54xUEMYKQkg0hgp0fQrckx3NBeJ6A2u7l
	 CzVnzKHsFGFtBHoiWX4+HZ9WgIiy9eSa/hLhlKmKXtoMoZP1EsGd2n03hiRtL+vjjdM58
	 UYADlnv68D+PnOngAr82rNmkNZBpcCcjDhc8D9YjUKkAMs/JfpUdsvDU8RZhbS37tdDhr
	 qwPD4MrD4pXxT7XWbmikUym8xZYK+bxWhCTtuuXmh3lYiuo0mfcm2LQEFUZBqsOlvzOON
	 z8YWEaIJsGm+f1zXzYP12Ne4i1FnAgj0tlLgjALpGTeVlAFim0D2cXlZaxenbeTz0UA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793406802;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=yih6QHYE4DaDHg0Vf0uZHGGyozrwe6Oms167g1kGBBM=;
	b=oxAY58Qs5s8fmbA1Ve6+4aBBO00pHQURUtW2UBPAllEduwYKB34Cl+K1p0NEPyBqjfA/
	 EhVesiLncBptxbavG82c0uMnaW4usBgeFoi4fqpyvxL9yxU4oVjQAFVlkIGfggBqaomLW
	 iV8JF05TRCCtqLUMoG/TPDgemqiqbLr3xNJiiIiB9Y7Mqe+kojrGWw97LUsO8KpTeIV9C
	 pkoMK1Tm9wo89fG9EZTWw83UZ/ooc2uTh2l/nZGA5fXIT4qmvL3KwWzVDefiE+B2hAbEV
	 BTyLqNnpPGVXrPKKZQ8PCe8FZ8XLUgEEbkK35UBatrZ1xIV7JLWmf4ZNH37N6+cibMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Pj4NAWOf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.60
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010060.outbound.protection.outlook.com [40.93.198.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC05606A31D
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 00:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAC05606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Pj4NAWOf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhMzKwZMKQly6GmYIumdhB25xDVO/pGr8mMMMlkSforA129BbfG7MNhK7VYLsdD/KA9o0YXzMkizR+0revsXhus6vXl7LFPtFB/nqzg4cA64aByFkE1kqzOpN2f4lQNvKnVvE4NIVnyaYv4NV+PPvfN6RjgX4dYwW/bEApdKrelj1F2GnS311cQwflmTtyzc/lwxc49gK6dkq+dKQWeYnlaQtQBg5u/AOX+73m3thVmlnZVVVp7AeJGqnnylCj2gB1fWeB7wLzN1Q3HrW9KVvmhXzljeDLna3azooS8x84FPxUI37qiDJoVYYJt+Won07WiInf57arb+cEK2jvAlmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yih6QHYE4DaDHg0Vf0uZHGGyozrwe6Oms167g1kGBBM=;
 b=U/nf+ZoxSo0YhkhPIuwDOD5oBqSoMluEdhI4cQy0yihGOwGCk7vQPr3Oh2NpVYPklbmAuS3yjqSfcNRQzfhFT0SoNwY9hCQCE2xyi/s7LyKehBzyzqDVAco73HTXilMhe62TMwOlpTvPETcgQ42cwdnsrrqEUWNBVuehuVj6xHIfgrIzBFjpGfSLTZrVUl18DEHUQZ9LyUpUe7QLVCTWz+l+KjGrREeS3TTeWF9Da04rvsyFV+Yy03+1c1MUKHMCcTXFAYMMeAb0Gz/cJiaqS5y9Ya1zV8EQuCPc0tiI3E75YFFS2OyXEljoFpOvrk7tRrlNit3Rtr3nXR6ZGiKcUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yih6QHYE4DaDHg0Vf0uZHGGyozrwe6Oms167g1kGBBM=;
 b=Pj4NAWOfGu23NdnrtLCDLiYGgJa10xYwK8hshd3ka3eRY1H58YxmfZgXzfSGmNconrSZ4WSIhMNiDqsREQlqW1bO6cvjRH7zKXhERRowWVFcicy3efYjxdX/2KXao/AZ+W3Cb5uWR37eMSfluT38aD/A6Mvk2z/DyDDBCB3fuHQ=
Received: from MW4PR03CA0120.namprd03.prod.outlook.com (2603:10b6:303:b7::35)
 by SN7PR12MB8002.namprd12.prod.outlook.com (2603:10b6:806:34b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Sat, 31 Oct
 2026 00:33:13 +0000
Received: from MWH0EPF000D894F.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::63) by MW4PR03CA0120.outlook.office365.com
 (2603:10b6:303:b7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Sat, 31
 Oct 2026 00:33:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000D894F.mail.protection.outlook.com (10.167.249.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Sat, 31 Oct 2026 00:33:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 19:33:12 -0500
Received: from amd-BIRMANPLUS.mshome.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Fri, 30 Oct 2026 19:33:10 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>, "Broadcom internal kernel
 review list" <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Yazen Ghannam <yazen.ghannam@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>
CC: Jason Andryuk <jason.andryuk@amd.com>, Sean Christopherson
	<seanjc@google.com>, Ingo Molnar <mingo@kernel.org>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>
Subject: [PATCH] x86/paravirt: Add ioremap_verify_range hook and implement it for Xen PV
Date: Fri, 30 Oct 2026 20:33:08 -0400
Message-ID: <20261031003309.3751-1-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894F:EE_|SN7PR12MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: d7fea2ce-8a16-4fb9-77d5-08df36e68c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|36860700016|82310400026|921020|260925022911599003|260925021911599003|260925021311599003|11063799006|56012099006|261009223027099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	aWk6nQhKji0GcTEmX23tLPr4lYCz4W5jlrdrp2QAHXlkIK4KMFpVZFXdTeVQKmbeBFLCyrSmljHSR7EZmCUkF0HsOnnoUaocL0a+Pf5qPkayCbKfkNcyGB1DxTvws5K7IVX5eig6qTGRhdC5rCV7X9SbhmjSPpefOtXCvvPHRj61GbroMPq+HjMhTL++WH6VQC94VtKNUmhY4vCF06GCLv3BdIaKOLnn3IAAaimUWVDPD2oKYfQarklJVR9UTOOjXEzKflK2PXx5TQAoMoK319mZ2UDcV8xkmXj/u8tbHHSr9U1dY2rJYFesHi/g5Yci1rkjRc779gCqC2IwRgVKJQg3YuRfwfCNrXifytIW2dYsRFiVWGhwxGuw1hyI7U7tfSOdT5makn5MCHYmZY5sOksB7KvIeSUMh9K4eq2i7V0b1QBfqqZtFQ3AtyE9BenyJs8bpBHoMZVayU0f0LGuFmBU3bpXVwKX7ErK9ve7sdOizVc4bMCzRjlygLWAF19hHosXB7rbHWBoKvSfBtcN+0pDXw/tvQ6SXyEK2VFnzCzI+P88nAazNWeioMrem9S2E9DAZy5a9uWoUQjYuA3cmJ9ds51w9lhcI2eXz6ibzaA3Ye2P5KpninpAKtTgbCx7RjI0H1AioRp5WJny7lD6Oo11eAsfBQY9XFyJyxI1SFAypdzqAH0HZb64gGEGvkgXOjXwzJtp5HunXaBhjDvWeA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(36860700016)(82310400026)(921020)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NYRg0/BadDsns6DekT8ePeXb82enHV1ukRb5r52da1kdASpsWvA0mXuU15E3cFx1hHSgRYrqBbIozCDfFHTziJoruYwopYVw6igrGxSTguSTg4Qhfp++W5ZX6aGLuC0/pgqLtQ+iBtmHO5YkGhVIoBvaWaw7w6WiHvXiNrN/+EusxAjBiXA3C6/kS7w4719+P3in2EFe8BHpwuW28TAu8f+k4gXh6RyOukBly+trzlKTHOR2ngP2f8oKbLXLLahsqYlgNl5XEwtP075VkpKDdbax0Vg1ooDjbkQxlczggrJOgYBrocTr7daAbFgiQVr8/25ge/P9ko+YUJH7scHFHDj6Gc6tI+zRGXe84Bbmxq6W4db8aLcxK0XdrHeDBIAuUAUE5j526/zmVlYSPMmfbh6Hz/gqCFe5QDNVSMJIl2jAnmvcsCwd5jh47pJj89aQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 00:33:12.8540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fea2ce-8a16-4fb9-77d5-08df36e68c03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000D894F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002

Xen PV guests update page tables via hypercalls, and Xen refuses to let a
domain map machine frames it does not own, such as chipset MMIO in a domU.
The set_pte() paths ignore the hypercall result, so ioremap() returns a
mapping whose PTEs are not present.  Accessing the virtual address then
faults.  This was seen in print_s5_reset_status_mmio() on Xen PV domUs
on AMD Zen hosts.  The machine address is not accessible by the domU and
faults on access.

Add a pv_mmu_ops hook, ioremap_verify_range, which __ioremap_caller()
calls after ioremap_page_range().  It defaults to returning success.
Xen PV implements it by walking the range with lookup_address() and
failing if any entry is not present, making ioremap() return NULL.

This also affects a Xen PV dom0: an ioremap() of a range containing any
page Xen refuses to map (e.g. MMIO Xen reserves for itself) now fails as
a whole, rather than succeeding and faulting only when the refused page
is accessed.  Pages Xen forces read-only are still mapped present and
are unaffected.

Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
Link: https://lore.kernel.org/xen-devel/20251219010131.12659-1-ariadne@ariadne.space/
Suggested-by: Sean Christopherson <seanjc@google.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
 arch/x86/include/asm/paravirt.h       | 10 ++++++++++
 arch/x86/include/asm/paravirt_types.h |  6 ++++++
 arch/x86/kernel/paravirt.c            |  7 +++++++
 arch/x86/mm/ioremap.c                 |  3 +++
 arch/x86/xen/mmu_pv.c                 | 24 ++++++++++++++++++++++++
 5 files changed, 50 insertions(+)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 0591aa38fd85..30cb1d1636e4 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -495,6 +495,11 @@ static inline void arch_leave_lazy_mmu_mode(void)
 	arch_flush_lazy_mmu_mode();
 }
 
+static inline int ioremap_verify_range(unsigned long addr, unsigned long size)
+{
+	return PVOP_CALL2(int, pv_ops, mmu.ioremap_verify_range, addr, size);
+}
+
 static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
 				phys_addr_t phys, pgprot_t flags)
 {
@@ -557,6 +562,11 @@ static __always_inline unsigned long arch_local_irq_save(void)
 static inline void paravirt_enter_mmap(struct mm_struct *mm)
 {
 }
+
+static inline int ioremap_verify_range(unsigned long addr, unsigned long size)
+{
+	return 0;
+}
 #endif
 
 #ifndef CONFIG_PARAVIRT
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index b4c4a23e77a1..674613301a83 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -164,6 +164,12 @@ struct pv_mmu_ops {
 
 	void (*lazy_mode_flush)(void);
 
+	/*
+	 * Verify that an ioremap()ed kernel virtual address range was
+	 * actually mapped.  Returns 0 on success.
+	 */
+	int (*ioremap_verify_range)(unsigned long addr, unsigned long size);
+
 	/* dom0 ops */
 
 	/* Sometimes the physical address is a pfn, and sometimes its
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 00b59d774389..b1bc519c660d 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -88,6 +88,11 @@ static noinstr void pv_native_set_debugreg(int regno, unsigned long val)
 {
 	native_set_debugreg(regno, val);
 }
+
+static int native_ioremap_verify_range(unsigned long addr, unsigned long size)
+{
+	return 0;
+}
 #endif
 
 struct pv_info pv_info = {
@@ -207,6 +212,8 @@ struct paravirt_patch_template pv_ops = {
 
 	.mmu.lazy_mode_flush	= paravirt_nop,
 
+	.mmu.ioremap_verify_range	= native_ioremap_verify_range,
+
 	.mmu.set_fixmap		= native_set_fixmap,
 #endif /* CONFIG_PARAVIRT_XXL */
 };
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 12c8180ca1ba..6b45a7eef593 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -301,6 +301,9 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	if (ioremap_page_range(vaddr, vaddr + size, phys_addr, prot))
 		goto err_free_area;
 
+	if (ioremap_verify_range(vaddr, size))
+		goto err_free_area;
+
 	ret_addr = (void __iomem *) (vaddr + offset);
 	mmiotrace_ioremap(unaligned_phys_addr, unaligned_size, ret_addr);
 
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 377c3c0d9f20..e524d318171f 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -359,6 +359,29 @@ static void xen_set_pte(pte_t *ptep, pte_t pteval)
 	__xen_set_pte(ptep, pteval);
 }
 
+/*
+ * PTE updates are made via (possibly batched) hypercalls whose failures
+ * are not propagated back to the caller.  Xen refuses to let a domain map
+ * machine frames it does not own (e.g. chipset MMIO in a domU), leaving the
+ * PTE not present.  Walk the range to make sure every page got mapped.
+ */
+static int xen_ioremap_verify_range(unsigned long addr, unsigned long size)
+{
+	unsigned long end = addr + size;
+	unsigned int level;
+	pte_t *pte;
+
+	while (addr < end) {
+		pte = lookup_address(addr, &level);
+		if (!pte || !pte_present(*pte))
+			return -ENXIO;
+
+		addr = (addr & page_level_mask(level)) + page_level_size(level);
+	}
+
+	return 0;
+}
+
 static pte_t xen_ptep_modify_prot_start(struct vm_area_struct *vma,
 					unsigned long addr, pte_t *ptep)
 {
@@ -2218,6 +2241,7 @@ void __init xen_init_mmu_ops(void)
 	pv_ops.mmu.enter_mmap = xen_enter_mmap;
 	pv_ops.mmu.exit_mmap = xen_exit_mmap;
 	pv_ops.mmu.lazy_mode_flush = xen_flush_lazy_mmu;
+	pv_ops.mmu.ioremap_verify_range = xen_ioremap_verify_range;
 	pv_ops.mmu.set_fixmap = xen_set_fixmap;
 
 	memset(dummy_mapping, 0xff, PAGE_SIZE);
-- 
2.34.1

