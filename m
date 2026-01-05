Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7183533A71B
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611243; cv=none; b=rBk5C3VO+hqpfD+rR5RwqiU6MccJ6qXVdYk5aXTrVzea/epHS05PkcA9c25cvm0ny9t1aRqgXrdUXSfWhSeBJdiWBn2sXD1LrcMjGvFZ0N+dVMwTsAS++rjKZwgkxTzeomryl3o7XURZz/th5CtgRVQrKoc1vH5129Of1HnKhQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611243; c=relaxed/simple;
	bh=KhS2hR8yS4ddPWKetGb5Mg/+66yHTxjFfkIrs4V1taA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONH1wU4EAB+3OcOxD7+slDD5uUWf6PxmeJQ/xB65+xS0+mnfsfuweJpp0uwgHJ84CAxcTG3s0TnaPepha136esvnnxR2wxf6wfVsawBtR31XX9oxTUuRXPsFcg0TxS1CVN/ifV//XNvpdA1XDxeXdcFVHDHaGBJGV5lKII5Jpqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC8FF3371A;
	Mon,  5 Jan 2026 11:07:19 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5759F3EA63;
	Mon,  5 Jan 2026 11:07:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MGzQEmebW2lsWgAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 05 Jan 2026 11:07:19 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 19/21] x86/paravirt: Allow pv-calls outside paravirt.h
Date: Mon,  5 Jan 2026 12:05:18 +0100
Message-ID: <20260105110520.21356-20-jgross@suse.com>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: CC8FF3371A
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

In order to prepare for defining paravirt functions outside of
paravirt.h, don't #undef the paravirt call macros.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 62399f5d037d..ba6b14b6f36a 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -588,22 +588,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
 }
 #endif
 
-
-/* Make sure as little as possible of this mess escapes. */
-#undef PARAVIRT_CALL
-#undef __PVOP_CALL
-#undef __PVOP_VCALL
-#undef PVOP_VCALL0
-#undef PVOP_CALL0
-#undef PVOP_VCALL1
-#undef PVOP_CALL1
-#undef PVOP_VCALL2
-#undef PVOP_CALL2
-#undef PVOP_VCALL3
-#undef PVOP_CALL3
-#undef PVOP_VCALL4
-#undef PVOP_CALL4
-
 void native_pv_lock_init(void) __init;
 
 #else  /* __ASSEMBLER__ */
-- 
2.51.0

