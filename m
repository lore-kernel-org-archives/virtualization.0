Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED2B314D03
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 07:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764227362; cv=none; b=PzxOiW/TVoViErEABTT6BdfnPDTvY12hZJHmy+hX4HSLFsd9lntzd/xHbAACnHUzFUxxmGRwE1XPzWLgfF8F/VEWKc9ZennmcKFizeNOSeIu8YSCOhXdIsosupvp/QK1Xn8/hTJ/5TNmXOpnqQRp5b2x5718OBM89+aWAhUBn8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764227362; c=relaxed/simple;
	bh=PeTZjp4oTq6mRsuNBjWSWUsoczvRYgMh3Gio5/GHNTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uagVSI+noDlrDvqWhnDlvLMkZL6H8HSuPiR0BaKdV0YlXgnldcy2ys0AfiQWGmZKwDLCXLw9VzvMmRSihr6CNY5OT1HqmOrEFk8M0aq3qFOBLhqQX8fNqVBwns6jcN/sRANWfwh4hrVZIO26tKCtumi9dfMxTc26V0k+g+EozoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4206A33693;
	Thu, 27 Nov 2025 07:09:18 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 353CD3EA63;
	Thu, 27 Nov 2025 07:09:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EWuXCx35J2l8XAAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 27 Nov 2025 07:09:17 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org
Cc: Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH v4 05/21] paravirt: Remove asm/paravirt_api_clock.h
Date: Thu, 27 Nov 2025 08:08:28 +0100
Message-ID: <20251127070844.21919-6-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127070844.21919-1-jgross@suse.com>
References: <20251127070844.21919-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)]
X-Rspamd-Queue-Id: 4206A33693
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

All architectures supporting CONFIG_PARAVIRT share the same contents
of asm/paravirt_api_clock.h:

  #include <asm/paravirt.h>

So remove all incarnations of asm/paravirt_api_clock.h and remove the
only place where it is included, as there asm/paravirt.h is included
anyway.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com> # powerpc, scheduler bits
---
 arch/arm/include/asm/paravirt_api_clock.h       | 1 -
 arch/arm64/include/asm/paravirt_api_clock.h     | 1 -
 arch/loongarch/include/asm/paravirt_api_clock.h | 1 -
 arch/powerpc/include/asm/paravirt_api_clock.h   | 2 --
 arch/riscv/include/asm/paravirt_api_clock.h     | 1 -
 arch/x86/include/asm/paravirt_api_clock.h       | 1 -
 kernel/sched/sched.h                            | 1 -
 7 files changed, 8 deletions(-)
 delete mode 100644 arch/arm/include/asm/paravirt_api_clock.h
 delete mode 100644 arch/arm64/include/asm/paravirt_api_clock.h
 delete mode 100644 arch/loongarch/include/asm/paravirt_api_clock.h
 delete mode 100644 arch/powerpc/include/asm/paravirt_api_clock.h
 delete mode 100644 arch/riscv/include/asm/paravirt_api_clock.h
 delete mode 100644 arch/x86/include/asm/paravirt_api_clock.h

diff --git a/arch/arm/include/asm/paravirt_api_clock.h b/arch/arm/include/asm/paravirt_api_clock.h
deleted file mode 100644
index 65ac7cee0dad..000000000000
--- a/arch/arm/include/asm/paravirt_api_clock.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm/paravirt.h>
diff --git a/arch/arm64/include/asm/paravirt_api_clock.h b/arch/arm64/include/asm/paravirt_api_clock.h
deleted file mode 100644
index 65ac7cee0dad..000000000000
--- a/arch/arm64/include/asm/paravirt_api_clock.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm/paravirt.h>
diff --git a/arch/loongarch/include/asm/paravirt_api_clock.h b/arch/loongarch/include/asm/paravirt_api_clock.h
deleted file mode 100644
index 65ac7cee0dad..000000000000
--- a/arch/loongarch/include/asm/paravirt_api_clock.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm/paravirt.h>
diff --git a/arch/powerpc/include/asm/paravirt_api_clock.h b/arch/powerpc/include/asm/paravirt_api_clock.h
deleted file mode 100644
index d25ca7ac57c7..000000000000
--- a/arch/powerpc/include/asm/paravirt_api_clock.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/paravirt.h>
diff --git a/arch/riscv/include/asm/paravirt_api_clock.h b/arch/riscv/include/asm/paravirt_api_clock.h
deleted file mode 100644
index 65ac7cee0dad..000000000000
--- a/arch/riscv/include/asm/paravirt_api_clock.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm/paravirt.h>
diff --git a/arch/x86/include/asm/paravirt_api_clock.h b/arch/x86/include/asm/paravirt_api_clock.h
deleted file mode 100644
index 65ac7cee0dad..000000000000
--- a/arch/x86/include/asm/paravirt_api_clock.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm/paravirt.h>
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index adfb6e3409d7..ccd0d92ff7d1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -84,7 +84,6 @@ struct cpuidle_state;
 
 #ifdef CONFIG_PARAVIRT
 # include <asm/paravirt.h>
-# include <asm/paravirt_api_clock.h>
 #endif
 
 #include <asm/barrier.h>
-- 
2.51.0

