Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FDE27B4F2
	for <virtualization@lists.linux.dev>; Thu, 11 Sep 2025 06:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572560; cv=none; b=UgDDuJiAfR2nVSMkf6lY/wv13d6c3sM34LKRwtS8GEshOXPT/swLYnGizQ2dx/JeTnUczDMYtgvtp5lMDJShudBRvUM7xDCFPsoVxcWud4F36wy/z9vkEdrmG5HLN+QTrZ/pHPuqKZWfDP8HXwwX8tCgOraddXBie0w/Z+WmI+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572560; c=relaxed/simple;
	bh=5Dg7hGt4E3Me3pfF1JRmhuTrzbAq/joRjl3QDigm1cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLvQ9b2TjHryimPTZP8Uak7V+90C0P39vuDnEcQfAjwMRIAO25OxXFhSOIDIRWyV+ALPeXwCuZOXV/3xiMDPlgCDxGoVul0u8pgRlG7ZgnVZKdCxcZ0VU6Tf5ed17C/SD20pxMpoupD8IYjEGVHPYP66zyWFcL/JLi457g/qfs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED6B3681EA;
	Thu, 11 Sep 2025 06:35:56 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8370F1372E;
	Thu, 11 Sep 2025 06:35:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Fep1HsxtwmhcTQAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 11 Sep 2025 06:35:56 +0000
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
Subject: [PATCH 13/14] x86/paravirt: allow pv-calls outside paravirt.h
Date: Thu, 11 Sep 2025 08:34:32 +0200
Message-ID: <20250911063433.13783-14-jgross@suse.com>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: ED6B3681EA
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

In order to prepare for defining paravirt functions outside of
paravirt.h, don't #undef the paravirt call macros.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index bd050ceaae00..13c0e4e65467 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -589,22 +589,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
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
 extern void default_banner(void);
 void native_pv_lock_init(void) __init;
 
-- 
2.51.0

