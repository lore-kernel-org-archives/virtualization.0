Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6A7156237;
	Mon, 31 Mar 2025 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743409443; cv=none; b=h+hZZH31AnNc1tMOq0tnygnyjZYdFSxaoR+b0Zwh/fkGjuv47FOhC83NLcLevzSOKnI/oSuXQW2a5/sV8zKZBggYrpUR2RzJ38TNKxnNV0EA3zYOOBv3bsCgXSRtycYrMQHrSyofAChNoVv+86cPMwJHyYYuTkVsGz0FvPzFi8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743409443; c=relaxed/simple;
	bh=ABSKvHyBIrh6QHK4hlgn4QnqvAzBsraSRqbIPjJ35nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjNAyhU7Z554BCe23FN8wRgZyaKqMGNgl2SZPigxeQ/gKT1PltahvxvDA4LHqCveH+xc9pweubyZaZ0QrxXDPOUgdrgxjFYK/qCOmIvAk4J+cgW2iYjcpUB1hW9cpBjCE4Ptx5T2bp0mI2rRr4G2NZgBpIieB07Gy3H2nfxAIFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=SuHDQIJy; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SuHDQIJy"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52V8Mp0F3171319
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 31 Mar 2025 01:23:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52V8Mp0F3171319
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025032001; t=1743409410;
	bh=cMFNgaQ/yU5pBBnUjuHrZWgQ7p+gEOsEGfeLMhV/cHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SuHDQIJy8AzSLC0DrXz1UGsHXHhDsnDQpCgFuieur9l29e7EM1ArYQl7rGjnX8wD+
	 WkraR40jpmWTpADYisOZ7nbeYq+ByLQ5TLLYH8kKM7DCg5buwGVA5GHhHZVrggSeZ4
	 p9nifPZWSuSDm1534yUVgXXqF/kvTz/WBhHohMexeK1jikiHydt9HM2bVqx8MyrHLR
	 c8M6luTBzpzY8I0f63iDe6i8yCHSJXzCnLx3cOikN4ytSEhwdKsNU/oWb2NhlDUBla
	 mlZbjuvfxWirBhjjqog8XtnbNx9xitJDGMf/rsrr0eINZ0q1eEmyIbBAiN8ijpnMcH
	 lJXB3Tmz/tP0A==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
        linux-edac@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-ide@vger.kernel.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jgross@suse.com, andrew.cooper3@citrix.com, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        wei.liu@kernel.org, ajay.kaher@broadcom.com,
        alexey.amakhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        tony.luck@intel.com, pbonzini@redhat.com, vkuznets@redhat.com,
        seanjc@google.com, luto@kernel.org, boris.ostrovsky@oracle.com,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Subject: [RFC PATCH v1 15/15] x86/msr: Move the ARGS macros after the MSR read/write APIs
Date: Mon, 31 Mar 2025 01:22:51 -0700
Message-ID: <20250331082251.3171276-16-xin@zytor.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331082251.3171276-1-xin@zytor.com>
References: <20250331082251.3171276-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the ARGS macros are no longer used in the MSR read/write API
implementation, move them after their definitions.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/include/asm/msr.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index fc93c2601853..9b109d1d92aa 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -37,23 +37,6 @@ struct saved_msrs {
 	struct saved_msr *array;
 };
 
-/*
- * both i386 and x86_64 returns 64-bit value in edx:eax, but gcc's "A"
- * constraint has different meanings. For i386, "A" means exactly
- * edx:eax, while for x86_64 it doesn't mean rdx:rax or edx:eax. Instead,
- * it means rax *or* rdx.
- */
-#ifdef CONFIG_X86_64
-/* Using 64-bit values saves one instruction clearing the high half of low */
-#define DECLARE_ARGS(val, low, high)	unsigned long low, high
-#define EAX_EDX_VAL(val, low, high)	((low) | (high) << 32)
-#define EAX_EDX_RET(val, low, high)	"=a" (low), "=d" (high)
-#else
-#define DECLARE_ARGS(val, low, high)	unsigned long long val
-#define EAX_EDX_VAL(val, low, high)	(val)
-#define EAX_EDX_RET(val, low, high)	"=A" (val)
-#endif
-
 /*
  * Be very careful with includes. This header is prone to include loops.
  */
@@ -620,6 +603,23 @@ static __always_inline int wrmsrl_safe(const u32 msr, const u64 val)
 extern int rdmsr_safe_regs(u32 regs[8]);
 extern int wrmsr_safe_regs(u32 regs[8]);
 
+/*
+ * both i386 and x86_64 returns 64-bit value in edx:eax, but gcc's "A"
+ * constraint has different meanings. For i386, "A" means exactly
+ * edx:eax, while for x86_64 it doesn't mean rdx:rax or edx:eax. Instead,
+ * it means rax *or* rdx.
+ */
+#ifdef CONFIG_X86_64
+/* Using 64-bit values saves one instruction clearing the high half of low */
+#define DECLARE_ARGS(val, low, high)	unsigned long low, high
+#define EAX_EDX_VAL(val, low, high)	((low) | (high) << 32)
+#define EAX_EDX_RET(val, low, high)	"=a" (low), "=d" (high)
+#else
+#define DECLARE_ARGS(val, low, high)	unsigned long long val
+#define EAX_EDX_VAL(val, low, high)	(val)
+#define EAX_EDX_RET(val, low, high)	"=A" (val)
+#endif
+
 /**
  * rdtsc() - returns the current TSC without ordering constraints
  *
-- 
2.49.0

