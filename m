Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7A9336ED8
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611184; cv=none; b=K/Y/PE0C4sv0jPHCHbN8bbp4mdDNYVtilcVwKXrq5TBm4IUt3IHwbPgMsEUE6CqFaG+s6IdiwoUzy5fqVeaIgzgbDWsZUWZheUX7b8pTbK9IrwqLDyYGi4Zc5yIznaGe2DSB0Q8ynq04qln9Jkru/KxiMII289rckyZFBVgb1hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611184; c=relaxed/simple;
	bh=7cgTxHtz/iqw5FOAveWJrsPCFtnOZCi4ift5RztCyes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfxso+a9WIIrcRRGTkThTLTkmRdG2+W3D8tg+n3tgA8rwVvdr2BQsPV2+jm4X6KP44teMsB4VXr1gwbD0nN5YP2KASfxS+VuPKpj1WYk+0M0dOv6n5yWlfAP+vvMtqf27Om6nS9ZQwbaUp6I/Pqq+d/ZIQMvaQsdzmdzzVXHaN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BHmxbGo4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BHmxbGo4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BHmxbGo4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BHmxbGo4"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0CDF65BE34;
	Mon,  5 Jan 2026 11:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767611181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=clpt2oPoQAjEZ3VIAs/r2Dx0VRsR5HpVJE2gZdjGDx8=;
	b=BHmxbGo4NaHWyMUtvvGW8F0IOVYQraTcBOD9Dfzg2Zwusv30wnXRCrs49kwJjR90fuf0st
	yWW7ZdUtvuWzUw18D5ZgN8CDG4G6eRquShfMGTmNBzz3pcKpJkHWAmGMCsYdvSksYKRyPL
	DZG3CNHXEBMeuzWO3pFmd6rByX4lhOo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767611181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=clpt2oPoQAjEZ3VIAs/r2Dx0VRsR5HpVJE2gZdjGDx8=;
	b=BHmxbGo4NaHWyMUtvvGW8F0IOVYQraTcBOD9Dfzg2Zwusv30wnXRCrs49kwJjR90fuf0st
	yWW7ZdUtvuWzUw18D5ZgN8CDG4G6eRquShfMGTmNBzz3pcKpJkHWAmGMCsYdvSksYKRyPL
	DZG3CNHXEBMeuzWO3pFmd6rByX4lhOo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A362913964;
	Mon,  5 Jan 2026 11:06:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m5lTJiybW2kzWgAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 05 Jan 2026 11:06:20 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	virtualization@lists.linux.dev,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PATCH v5 09/21] loongarch/paravirt: Use common code for paravirt_steal_clock()
Date: Mon,  5 Jan 2026 12:05:08 +0100
Message-ID: <20260105110520.21356-10-jgross@suse.com>
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
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.987];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.80

Remove the arch specific variant of paravirt_steal_clock() and use
the common one instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/Kconfig                |  1 +
 arch/loongarch/include/asm/paravirt.h | 10 ----------
 arch/loongarch/kernel/paravirt.c      |  7 -------
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 730f34214519..19f08082a782 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -687,6 +687,7 @@ source "kernel/livepatch/Kconfig"
 config PARAVIRT
 	bool "Enable paravirtualization code"
 	depends on AS_HAS_LVZ_EXTENSION
+	select HAVE_PV_STEAL_CLOCK_GEN
 	help
 	  This changes the kernel so it can modify itself when it is run
 	  under a hypervisor, potentially improving performance significantly
diff --git a/arch/loongarch/include/asm/paravirt.h b/arch/loongarch/include/asm/paravirt.h
index d219ea0d98ac..0111f0ad5f73 100644
--- a/arch/loongarch/include/asm/paravirt.h
+++ b/arch/loongarch/include/asm/paravirt.h
@@ -4,16 +4,6 @@
 
 #ifdef CONFIG_PARAVIRT
 
-#include <linux/static_call_types.h>
-
-u64 dummy_steal_clock(int cpu);
-DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
-
-static inline u64 paravirt_steal_clock(int cpu)
-{
-	return static_call(pv_steal_clock)(cpu);
-}
-
 int __init pv_ipi_init(void);
 int __init pv_time_init(void);
 int __init pv_spinlock_init(void);
diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
index 8caaa94fed1a..c5e526098c0b 100644
--- a/arch/loongarch/kernel/paravirt.c
+++ b/arch/loongarch/kernel/paravirt.c
@@ -13,13 +13,6 @@ static int has_steal_clock;
 static DEFINE_PER_CPU(struct kvm_steal_time, steal_time) __aligned(64);
 DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
 
-static u64 native_steal_clock(int cpu)
-{
-	return 0;
-}
-
-DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
-
 static bool steal_acc = true;
 
 static int __init parse_no_stealacc(char *arg)
-- 
2.51.0

