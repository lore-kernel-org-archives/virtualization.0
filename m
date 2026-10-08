Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552BA3DF00B
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791443987; cv=none; b=MikbJefiqrdqaUPV3QDKCERwRHJy3Jos6b5wQBqoBTMqD9tdO4XOSX7kFj5NlHPFq5fEgyCHG3yHjzAPIPMH9nU5GFRBoy2TKXnHwLNvcSp+QnfWP+fwXfybTZrNP0kmqV+wJZJoymTa+EXyc/xxFRFEHUv4X+ch8cWNGmOqveA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791443987; c=relaxed/simple;
	bh=/kzVoVk5PsNlCLxCkKXedZDtmSZUJBXARrSyIWflFsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5EXZsnbTkMK4edg8oJd81fVvVTYMHHcqhnXtWXXWQsUterANlpSOz78rt57kmX5o5pj6ZM3CYi8wlJieUriK5O22Yqhim3RyYU7zDviMNoOmxadoOm2fdOrcxfdl2P9HKVvN+rOX8FekDQ+9wPBk9DUkY0zPAL5G7y3c8MMsw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D3F221B5A;
	Thu,  8 Oct 2026 07:19:42 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB12913354;
	Thu,  8 Oct 2026 07:19:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lKZxJw1Ex2rAcQAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 08 Oct 2026 07:19:41 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH v4 10/13] x86/msr: Remove wrmsr()
Date: Thu,  8 Oct 2026 09:18:36 +0200
Message-ID: <20261008071839.2247074-11-jgross@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008071839.2247074-1-jgross@suse.com>
References: <20261008071839.2247074-1-jgross@suse.com>
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
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 6D3F221B5A
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Action: no action

wrmsr() has no users left. Delete it.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/msr.h      | 5 -----
 arch/x86/include/asm/paravirt.h | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 776a2daa2ba2..badab5762f3a 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -186,11 +186,6 @@ do {								\
 	(void)((high) = (u32)(__val >> 32));			\
 } while (0)
 
-static inline void wrmsr(u32 msr, u32 low, u32 high)
-{
-	native_write_msr(msr, (u64)high << 32 | low);
-}
-
 #define rdmsrq(msr, val)			\
 	((val) = native_read_msr((msr)))
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 97b082095572..47d4e36d14cb 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -157,11 +157,6 @@ do {						\
 	val2 = _l >> 32;			\
 } while (0)
 
-static __always_inline void wrmsr(u32 msr, u32 low, u32 high)
-{
-	paravirt_write_msr(msr, (u64)high << 32 | low);
-}
-
 #define rdmsrq(msr, val)			\
 do {						\
 	val = paravirt_read_msr(msr);		\
-- 
2.55.0

