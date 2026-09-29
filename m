Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B13029ACC6
	for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 04:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654620; cv=none; b=Rv6fZvWGQ25IG/aLS1CpqXe11l1Vo2rkuJdoEGwExyvVqieOxSBZIoGqU7TEb3Q0RLBg16Soqzldwu2Ca1cgdoBwprAzrifoJ4V/eU14QqY7RDDxg2s7XSvdMLoFTaW1qd5TKL6XyDv6X+LsIb5xU8WTiwphyXXP+jwqGvcxXjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654620; c=relaxed/simple;
	bh=rUzQo5KHgL8B6Zt2JDNYEUTyvIMbiqzpi4ZnuUlZBBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTk42br969VK4Dy+5mVh4hRHZJ2Wz3g1p85X3dW5OzB67L/feOIuUCYThAJVvVP7fV+JhSRdVSCADLCsw/wY/UWSIb93ZK/3Xy+9LyN/vsnbRqEcQayzZ/1nqxIF3O7KglkRhyOM8wDPFXhaeUcaBY7I1bNn6mGZaU3ALmLjXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ER1BL5Gs; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ER1BL5Gs"
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-675617e81f9so203785d50.3
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 21:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654615; x=1791259415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CV8TEMBP6IF+2lIlzYCpg42JpAwpPVBphnZX2jCaOFA=;
        b=FAvga2y/OrQPmcp4g/94KPDd/8lcBeVxvc/PhAH+hAeGyv5/D4SqZdd68q+dJxsa5W
         xQLabIseJDAH4qhi42M/7B++UhmIjJ+cEwxavX/e9Zwlfnk2RtLTQrsQMfJ3ExmtjJQ2
         kBgBVphKy24o57RWqrbhqixnwjVsNXeZzIRtoqAuOTFY2D+6a4AjZfR3i8dPCUdK3kSL
         UBErUIV5kCuIxjp8GE4Obr6q5jMSiPYT2EtbRLqU+COw/cmv/7CU/R5kmaHZKmrTlNqd
         yBN/9hO7zqS8+RoiQPr10/BbbquCMtKwWR4qnOa6W2ECzUStDsvr+NqEpwQ7rgdzPW3R
         CkAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAQM0/Y8NSm+Wk6vT17AqogMsQc/jz3IuPDDPGpV2+42TKeJ/qOICwv9PgKf3fXk6QTXwOMNXxsbEhKho9hw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKkkFzsLhoYo4HUvZ38eK4AF1hrrWGhrqPoWYde+NUp2SWak9CD
	EjYqQ7Jdgf/ErgEOpQNOyiJDzDirpledbYzJcbiPmGbSTUpaSoslJPdbMnzj0NSJALyDVRmbFul
	S/ElsmZPykxbcEKCFz0IzosToZbd/DEb+8qcQU19kyfqPPr7+qXedfSK5H6oNncqYtvok3LGPCz
	Lf3uDg8hrq3NxEBzLto1yAJX7eVjg1wPjJJnp843zGTCyHuJIP638gTziKHft3oF0N5VtUp9qq7
	9bUGbxX5czeNkIwpME=
X-Gm-Gg: AYBFou1ktq9FbIKIX1gOExs+8MPMEHxDMlw0DfFVQnrYf5oikiTmnmn5uV6HtdJy+/g
	uoWxL5zKayIgcWB7TXY2xVe40RDSqLyHXZ29xSYCW8CWKqdpLOiCfpOGN6U9DiGv69b85qsd6HE
	rtN188tQD9BhXtepTPIMal5Ko9S9sLnnIh84keiKz6Y5ddtmE2EVNffekq/Dx9F3FrRgsCRdh4D
	UXqD2joznqxzOnLo5fObz5nVHdb3aSaZbLDRJC1cO7hdcJT7JxXGRBqVM6XIW0Y8cJvKD1XbfyZ
	BKX8NZPdqEzX9TrROAtxwBiUj5uac02RZsq8niyJV+nScui3ZOEiDEsoUj9QkpM1SlaBFmTyXuc
	LSd9p92Hg/WABOv46XPoOZgbIyykSz5jGZYeOAk3R8mU/qrTubtisV7zCWgCy09lvTNFsLkRfLb
	h0jwybrOY6PmjM76Suf0bOvaGlKGnTLeZ8ENY=
X-Received: by 2002:a05:690e:4010:b0:675:3063:4819 with SMTP id 956f58d0204a3-67530634e15mr4357440d50.42.1790654615216;
        Mon, 28 Sep 2026 21:03:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6740eea6d77sm1850854d50.4.2026.09.28.21.03.33
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 21:03:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-342217d8d53so12163076eec.0
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 21:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790654613; x=1791259413; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CV8TEMBP6IF+2lIlzYCpg42JpAwpPVBphnZX2jCaOFA=;
        b=ER1BL5Gs94jlqX99uKXYE7uTM/ldG3TrwA73UTle11mQcD2c1zSXEzl/Je/cXcdliJ
         y6Xg+/5kLvju4AhxSMFn/KiULmKJSNypTLmuwWi75V88hBSNRQ2/rv+BX01lRKxNLAYV
         DBQiSytdKdoX22QB03AxzvfqPINQsVdMvIPzI=
X-Forwarded-Encrypted: i=1; AKwUvBwkR7NKk28hgPdurixcDruUX8eqIvKm8EhDxiYvn0bikQV3cK1Rzep3G0kw5crggDltdoiBC+ruA8THUwJGMA==@lists.linux.dev
X-Received: by 2002:a05:7301:4d0b:b0:341:d191:b838 with SMTP id 5a478bee46e88-34272562bc0mr12611764eec.31.1790654612907;
        Mon, 28 Sep 2026 21:03:32 -0700 (PDT)
X-Received: by 2002:a05:7301:4d0b:b0:341:d191:b838 with SMTP id 5a478bee46e88-34272562bc0mr12611727eec.31.1790654612252;
        Mon, 28 Sep 2026 21:03:32 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm10952571eec.15.2026.09.28.21.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:03:29 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Kiryl Shutsemau <kas@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 5/6] x86/tdx: Support early sharing of kernel data
Date: Tue, 29 Sep 2026 00:02:54 -0400
Message-ID: <20260929040256.543767-6-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929040256.543767-1-zack.rusin@broadcom.com>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Share pages before the page allocator is available, after both their
direct-map and kernel-image mappings have been made shared. Preserve
initial contents in a private scratch page, matching the AMD early helper,
and use the existing MapGPA path and shared-page accounting.

UP per-CPU data has an image alias. Drop shared image mappings before
kexec converts their backing pages to private through the direct map.

Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Link: https://lore.kernel.org/r/aqqGUAX65s4LdJkr@thinkstation
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/coco/tdx/tdx.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index f904a636d449..4a683e9eafc3 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -4,6 +4,7 @@
 #undef pr_fmt
 #define pr_fmt(fmt)     "tdx: " fmt
 
+#include <linux/cacheflush.h>
 #include <linux/cpufeature.h>
 #include <linux/export.h>
 #include <linux/io.h>
@@ -18,6 +19,7 @@
 #include <asm/paravirt_types.h>
 #include <asm/pgtable.h>
+#include <asm/sections.h>
 #include <asm/set_memory.h>
 #include <asm/traps.h>
 
 /* MMIO direction */
@@ -1006,6 +1008,23 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	return 0;
 }
 
+static char tdx_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
+
+static int __init tdx_early_decrypt_page(unsigned long addr, unsigned long alias)
+{
+	void *buffer = __va(__pa_symbol(tdx_early_buffer));
+	int ret;
+
+	memcpy(buffer, (void *)addr, PAGE_SIZE);
+	clflush_cache_range((void *)addr, PAGE_SIZE);
+	early_set_page_decrypted(addr, alias);
+	ret = tdx_enc_status_change_finish(addr, 1, false);
+	if (ret)
+		return ret;
+	memcpy((void *)addr, buffer, PAGE_SIZE);
+	return 0;
+}
+
 /* Stop new private<->shared conversions */
 static void tdx_kexec_begin(void)
 {
@@ -1033,6 +1052,18 @@ static void tdx_kexec_finish(void)
 
 	lockdep_assert_irqs_disabled();
 
+	/* Drop image aliases before the direct-map walk makes pages private. */
+	addr = (unsigned long)_text;
+	while (addr < _brk_end) {
+		unsigned int level;
+		pte_t *pte = lookup_address(addr, &level);
+
+		if (pte && pte_decrypted(*pte))
+			set_pte(pte, __pte(0));
+		addr = (addr & page_level_mask(level)) + page_level_size(level);
+	}
+	__flush_tlb_all();
+
 	addr = PAGE_OFFSET;
 	end  = PAGE_OFFSET + get_max_mapped();
 
@@ -1160,6 +1191,7 @@ void __init tdx_early_init(void)
 	 */
 	x86_platform.guest.enc_status_change_prepare = tdx_enc_status_change_prepare;
 	x86_platform.guest.enc_status_change_finish  = tdx_enc_status_change_finish;
+	x86_init.paging.early_decrypt_page = tdx_early_decrypt_page;
 
 	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
 	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
-- 
2.53.0

