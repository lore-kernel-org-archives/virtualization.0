Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7196274B31
	for <virtualization@lists.linux.dev>; Thu, 11 Sep 2025 06:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572536; cv=none; b=B2ALMU49AQJ7mSjPVSRojU6XKXx6IoHKbm2PUB+jTweVWtpei/B+sbSuY4Vd8FLA1jcIfDTU9drgUqhdPzFI1ExS4tO7Xf808tOwmjbjyy801rkvhVSy7p3G30ltaKTTysrfzYKzr1Nrg5vwttiMNkdihw8pmp9JJUT/f+illys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572536; c=relaxed/simple;
	bh=xy3jqwF408JwhqxHmyzfvt6kEM80GChienFFHKxqiCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtTDXLWdIAZaOQ0cnd35/TPDmG1tOXhI9JAM9NVGG0Z9laxCYPLoFjBMtX44T2zZJExYypwX8A5vm28j7r8dUAV0iuc+X9AzVQG0szwtuOdousveFqzZ41Dua7mo8NdVmY/bNkozKXABtbxkXo8uO0GvHZtJchdxlX9r+R4zV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Fi27eaVU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Fi27eaVU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Fi27eaVU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Fi27eaVU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 11FF5683EE;
	Thu, 11 Sep 2025 06:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757572533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3rYmKzu1bV4B3KXkFWnwyxUA5DKs+Eyiw1NEehwwDWQ=;
	b=Fi27eaVUw5UPm83I69qEf8QZZEVJAd/pTXgjnsMCzsXX6jdR8Nxd0k5H21v5NAZogWZKwg
	T2K/vFNhf8XJ21Hg69bP9Vh5LxvOtfCPsRK4ajy+bFiCYx7/4n8saA0bE5fnO3l9DFawhI
	xEYNVAdwPDs9EFOr4o2gmbzWa011B3w=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757572533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3rYmKzu1bV4B3KXkFWnwyxUA5DKs+Eyiw1NEehwwDWQ=;
	b=Fi27eaVUw5UPm83I69qEf8QZZEVJAd/pTXgjnsMCzsXX6jdR8Nxd0k5H21v5NAZogWZKwg
	T2K/vFNhf8XJ21Hg69bP9Vh5LxvOtfCPsRK4ajy+bFiCYx7/4n8saA0bE5fnO3l9DFawhI
	xEYNVAdwPDs9EFOr4o2gmbzWa011B3w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B95001372E;
	Thu, 11 Sep 2025 06:35:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aiPZK7RtwmgtTQAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 11 Sep 2025 06:35:32 +0000
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
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH 09/14] loongarch/paravirt: use common code for paravirt_steal_clock()
Date: Thu, 11 Sep 2025 08:34:28 +0200
Message-ID: <20250911063433.13783-10-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911063433.13783-1-jgross@suse.com>
References: <20250911063433.13783-1-jgross@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -6.80

Remove the arch specific variant of paravirt_steal_clock() and use
the common one instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/loongarch/Kconfig                |  1 +
 arch/loongarch/include/asm/paravirt.h | 10 ----------
 arch/loongarch/kernel/paravirt.c      |  7 -------
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index f0abc38c40ac..06bebad41c6f 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -678,6 +678,7 @@ source "kernel/livepatch/Kconfig"
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

