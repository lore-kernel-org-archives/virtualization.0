Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60CC334C1C
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611160; cv=none; b=YBIqNUI6rH0bY9tUNkUs7iyw5tzoKqW0aIlvs96KsNs2BSzFZHrlIlYCs/QABgWjtSgyh1rblDB0wdJ6yP08yU5FinOl4W1dcrsrtevh9UVBDt+01jMqN6nqr/JgnMApV5jPQ7oQ7+QJOp0o7S9hQlXDcLQgIyVLyyYf+382W9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611160; c=relaxed/simple;
	bh=X0nuqOpFbSQrdHQsjRnp41q23aFKITCcOOkVpN8KVzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCtR/4LKQ75eHjvn9waRuhnFvqFYWWKt1uJ3I6vY8xCfT6EO16qXvcMvqA6petP4lYnbkXIALnW7N/8zQ5s70AjzSSrn+OLbb2R+6a4P8FE5T1RTmgu4KZMp+tIH+AOz9I8UnDbTh56DFd9RQkDI4ZaSFimxn9qncMQVnu16LTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XCUbz4+c; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LPK51PNt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XCUbz4+c";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LPK51PNt"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C82095BE3A;
	Mon,  5 Jan 2026 11:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767611157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+tOSWic7S6HlVBqSz9Z3RHyoIROEUV2RDNG4tvd3Nc=;
	b=XCUbz4+cgY6Yyu7GveUVvDVkSN0wlR2byIRimBehRswqQgwtrpvV0gqoNPS7spPnUU+EAz
	5c1sr+DclMxE+UpwaCdmWb7V2gdVyEM2mKj06ettgnQm8pi3ILgTbAlr0toJglcTIQjj+X
	hzq7P2wJ9RHV1LPbOa4tx3DhUQlfQt8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767611156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+tOSWic7S6HlVBqSz9Z3RHyoIROEUV2RDNG4tvd3Nc=;
	b=LPK51PNtGiDnlgEk/lYC05MPTK2zibYG8wN1ZbGfmaPz2L8o07Js5molQxKkMV6Ww+F4Gr
	QZvMBVvMJTQ2RGoETvhSJr7ln+WBJUq6ipSl8ebjhaxxokOiswL8DJL2WjxIf6jaSI5K8v
	o5c4boBMH4eM0J1NAm9qqHhfTtCJU4k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AC9813964;
	Mon,  5 Jan 2026 11:05:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ilsNJBObW2kOWgAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 05 Jan 2026 11:05:55 +0000
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
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
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
Subject: [PATCH v5 05/21] paravirt: Remove asm/paravirt_api_clock.h
Date: Mon,  5 Jan 2026 12:05:04 +0100
Message-ID: <20260105110520.21356-6-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105110520.21356-1-jgross@suse.com>
References: <20260105110520.21356-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[suse.com,broadcom.com,armlinux.org.uk,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,linaro.org,goodmis.org,google.com,suse.de,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

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
index d30cca6870f5..28e7cc4f7964 100644
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

