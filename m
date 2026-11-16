Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841353;
	b=sG/2UqrdvpoSe+HBdpfqPFdAfrQl/Cx8ZuLKJ742PMYwt/V+8Dno5Im/0k8GhQoTkT9O
	 Uko+bA1RXLb+HIKuRpAKcfOwDmNNE2nVaCzoOKdDn5gLa7kIxHOMNd2EAwCjlIHCAJeJb
	 x/Qr3c+9tZGVVbg/7SNPTYLcj+PrETCEF1FI0HHQlA7xLFjf+i0Udz0B85/wlpxfbv6TW
	 qvItPsiujuvx7A/FH+orrIiG4plfDGT8J8u7OujQx8/oYLJ+jiFjgCNOaVW5FzAmUKS62
	 5EJMA7amZTFg+71/wqQEtpT9FYEjHJgKMUEMyLrgbgOMgDaV5TsX1lH/V1micl8XyZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841353;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spamd-Result:X-Spam-Score;
	bh=zQc5EyICwi/WW/kWrbTagUCxV3C3Ca0wfz47B+uZJxc=;
	b=Gj6IM1hOpxv3+54lc/u2/1EMJz0IrlNWy1N9mGDPShABaNPiIHe0ULh9n/DUpZXq6tsX
	 DEqDVfr0SNvBVraUYQ9Nno+YEtbC7voKRmqvClCSs2AZfUT8T2opd5kPo4WwyoLvlMOIz
	 FAqqZ0DdoElA1YwmTjKNJKS0ASLPkpV0ceneo23kSdZ909IeRxP+0vNlQsGeaeGzbna5e
	 vjaUW5sFZW3odfpQ/DitOtbao6d3nvS1nKbeg+ZJhz2M0I7TNeeFW9A2pmSsc6mCdgOuk
	 f16yJQQpm8b4jEZ3ulZ8WYtGTdp9LMyIFqeH+oUlpkUw07xB/1ZO0umk6/YH9amoxIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=bGrmhWH4;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=bGrmhWH4;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F57606A32C
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 15:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15F57606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=bGrmhWH4;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=bGrmhWH4
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5A54A221FE;
	Mon, 16 Nov 2026 15:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794841351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQc5EyICwi/WW/kWrbTagUCxV3C3Ca0wfz47B+uZJxc=;
	b=bGrmhWH4mOO+/DLoSuWBIfzvCmhEcpPCrNmUFil1roFNh5r3ef5sjqczjFkwwNeBHnoGOt
	96Sysgs7kfXlmRtgJk5SVWCk0daniPcWU1ygqCAE572O1FIba+nw24roGxzZLa+jax+6kj
	t83CaY9Sy72ZbbtlG9b7uxcX55/y1J4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bGrmhWH4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794841351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQc5EyICwi/WW/kWrbTagUCxV3C3Ca0wfz47B+uZJxc=;
	b=bGrmhWH4mOO+/DLoSuWBIfzvCmhEcpPCrNmUFil1roFNh5r3ef5sjqczjFkwwNeBHnoGOt
	96Sysgs7kfXlmRtgJk5SVWCk0daniPcWU1ygqCAE572O1FIba+nw24roGxzZLa+jax+6kj
	t83CaY9Sy72ZbbtlG9b7uxcX55/y1J4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC15E13408;
	Mon, 16 Nov 2026 15:02:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X4IuLAYb+2rNDwAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 16 Nov 2026 15:02:30 +0000
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
Subject: [PATCH v6 03/12] x86/msr: Remove rdmsr_safe()
Date: Mon, 16 Nov 2026 16:01:59 +0100
Message-ID: <20261116150208.1572254-4-jgross@suse.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116150208.1572254-1-jgross@suse.com>
References: <20261116150208.1572254-1-jgross@suse.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5A54A221FE
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:email];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.01

rdmsr_safe() has no users left. Delete it.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/msr.h      | 10 ----------
 arch/x86/include/asm/paravirt.h | 10 ----------
 2 files changed, 20 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 6fb7125608c7..776a2daa2ba2 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -205,16 +205,6 @@ static inline int wrmsrq_safe(u32 msr, u64 val)
 	return native_write_msr_safe(msr, val);
 }
 
-/* rdmsr with exception handling */
-#define rdmsr_safe(msr, low, high)				\
-({								\
-	u64 __val;						\
-	int __err = native_read_msr_safe((msr), &__val);	\
-	(*low) = (u32)__val;					\
-	(*high) = (u32)(__val >> 32);				\
-	__err;							\
-})
-
 static inline int rdmsrq_safe(u32 msr, u64 *p)
 {
 	return native_read_msr_safe(msr, p);
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 0591aa38fd85..97b082095572 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -177,16 +177,6 @@ static inline int wrmsrq_safe(u32 msr, u64 val)
 	return paravirt_write_msr_safe(msr, val);
 }
 
-/* rdmsr with exception handling */
-#define rdmsr_safe(msr, a, b)				\
-({							\
-	u64 _l;						\
-	int _err = paravirt_read_msr_safe((msr), &_l);	\
-	(*a) = (u32)_l;					\
-	(*b) = (u32)(_l >> 32);				\
-	_err;						\
-})
-
 static __always_inline int rdmsrq_safe(u32 msr, u64 *p)
 {
 	return paravirt_read_msr_safe(msr, p);
-- 
2.56.0

