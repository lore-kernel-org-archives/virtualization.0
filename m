Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA33A335928
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120796; cv=none; b=o28YiIe+xrNwlTHwdasoaByQWbQsU2iejj7gJwhreLz16unMe1c5NUoKG9iMIYbn5Nt5pgOtLiphfkQrbRELMrQM5dGlk6xVwCzOn/VGIqnVD9iEGCGOIi1AMB8QuL0n8yqiEJRBBtbLNePGJxyLCXfZiBl6pWyB4XF2lri4eGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120796; c=relaxed/simple;
	bh=xy2e3ltyTq4A99+QppKLcEOmYM+bISMYAnlSPzvetMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9iuS85+n0vAVIJP1mD/pBu0xuF26NtYOwJvdztP7v16+hW9vF6ndZRXmvbN5W72qN/HnhXCVih8cPVrIuFYdee4PUgxYj4diJN0049/+Z//m6k5W+cWYgEQM6at3mNRYGvktBbmfemAZKry+6X3obf+v3FLAJYP+S9E2tXJz9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Kjy74Sy+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Kjy74Sy+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Kjy74Sy+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Kjy74Sy+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE0FD33835;
	Wed, 17 Sep 2025 14:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758120792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NMqWWyGgNRbcYkcYgHA+RwfguOtEqmxDTVM3ouGRtRc=;
	b=Kjy74Sy+eReVpmAdSJW3BmpeBxu+wTbc94c7l83FyPjFzf2Kt2nhtd/QccFoACb5fE+mZp
	Yr38OQLkFoVbJeG4JNa4DJWujjx/01QKbYHENztQu7ilS5ymdE7i+4i30oGWdreOEIrA24
	dkNUxN2+Ev7uvwVDG053lBMJy9MNL40=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758120792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NMqWWyGgNRbcYkcYgHA+RwfguOtEqmxDTVM3ouGRtRc=;
	b=Kjy74Sy+eReVpmAdSJW3BmpeBxu+wTbc94c7l83FyPjFzf2Kt2nhtd/QccFoACb5fE+mZp
	Yr38OQLkFoVbJeG4JNa4DJWujjx/01QKbYHENztQu7ilS5ymdE7i+4i30oGWdreOEIrA24
	dkNUxN2+Ev7uvwVDG053lBMJy9MNL40=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 694531368D;
	Wed, 17 Sep 2025 14:53:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F9w/GFjLymghEwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 17 Sep 2025 14:53:12 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH v2 08/21] arm64/paravirt: Use common code for paravirt_steal_clock()
Date: Wed, 17 Sep 2025 16:52:07 +0200
Message-ID: <20250917145220.31064-9-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917145220.31064-1-jgross@suse.com>
References: <20250917145220.31064-1-jgross@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -6.80

Remove the arch specific variant of paravirt_steal_clock() and use
the common one instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/Kconfig                |  1 +
 arch/arm64/include/asm/paravirt.h | 10 ----------
 arch/arm64/kernel/paravirt.c      |  7 -------
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e9bbfacc35a6..08abcd353cf4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1582,6 +1582,7 @@ config CC_HAVE_SHADOW_CALL_STACK
 
 config PARAVIRT
 	bool "Enable paravirtualization code"
+	select HAVE_PV_STEAL_CLOCK_GEN
 	help
 	  This changes the kernel so it can modify itself when it is run
 	  under a hypervisor, potentially improving performance significantly
diff --git a/arch/arm64/include/asm/paravirt.h b/arch/arm64/include/asm/paravirt.h
index c9f7590baacb..cb037e742372 100644
--- a/arch/arm64/include/asm/paravirt.h
+++ b/arch/arm64/include/asm/paravirt.h
@@ -3,16 +3,6 @@
 #define _ASM_ARM64_PARAVIRT_H
 
 #ifdef CONFIG_PARAVIRT
-#include <linux/static_call_types.h>
-
-u64 dummy_steal_clock(int cpu);
-
-DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
-
-static inline u64 paravirt_steal_clock(int cpu)
-{
-	return static_call(pv_steal_clock)(cpu);
-}
 
 int __init pv_time_init(void);
 
diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c
index 943b60ce12f4..572efb96b23f 100644
--- a/arch/arm64/kernel/paravirt.c
+++ b/arch/arm64/kernel/paravirt.c
@@ -25,13 +25,6 @@
 #include <asm/pvclock-abi.h>
 #include <asm/smp_plat.h>
 
-static u64 native_steal_clock(int cpu)
-{
-	return 0;
-}
-
-DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
-
 struct pv_time_stolen_time_region {
 	struct pvclock_vcpu_stolen_time __rcu *kaddr;
 };
-- 
2.51.0

