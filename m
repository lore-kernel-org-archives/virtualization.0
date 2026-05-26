Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3523FF1D5
	for <virtualization@lists.linux.dev>; Tue, 26 May 2026 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808086; cv=none; b=JFNqmJDonpc/2VG+7jI198+yvd/DCbCNH9V+k8vIhFMbqj8h5+0icPE4d81HeqzH6C7ZlWRD0H0CP0CTZqB5hQ2KoElbNO8mUUPGabTRbEHwpdmuRBDuA7w+Mv9R0D7YnMEfA/3Gophjic/pu/yKPpVe+I0Sq+K7EkhiTk/SC1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808086; c=relaxed/simple;
	bh=nrTiJ4QhvayZhulcBgYGEtWQscRvgCvMgseK0WjAtFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hnkjPoW0Ux378y8ekamhtjGkUbFiOYJVP2Kk3jdWZrj+2ne4xIYfiXbEI+mjtAYatuyrKLmuYBvazoglSBHbsTmES92BISbbjFsYnwMkxciqv4eUFKM3HGRNY6JgDCxET0dYl3FSG2CcI3fiHt1IROpVWutlvCDP12Bh8Ihb+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X0hCaH5O; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mAHAXM8U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X0hCaH5O";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mAHAXM8U"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C673F75EE0;
	Tue, 26 May 2026 15:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1779808082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yHeVRInwBdhPTyeUIDm80iXzexAaKjc6iJ7mRCvzf0o=;
	b=X0hCaH5Ou04bGdmMjYXA7Yqxh3MId+vNVUstba3gVRcIA6NAUvBiDiV4u4ukWBTJ2S8fp3
	m2ehEj3GKRUju2JgDxSEKJeiLovzeWykcBmopzGBkLtNoozneGCoBPWZUO6XGChOz5Ud+S
	+KJFFKXJG6hyXvKgCRwzQynUUt8+qkk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mAHAXM8U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1779808081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yHeVRInwBdhPTyeUIDm80iXzexAaKjc6iJ7mRCvzf0o=;
	b=mAHAXM8Ueb0PCWr1RCbutCZZ08Xj5nRqwQhdLaSrM6zsJ2Mb3Iv4zOofJwXY71hi2F2Gs4
	sWCh8bDq4rd/fYAHkzUW1mO64zXFnilEpth71ndsfqpvE26qeA3jbJtDXb427q4/XcHR9a
	+Vmtr4/LRyq8Ntr92MIUzmQgIv46/gc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F41F75A280;
	Tue, 26 May 2026 15:08:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Nu2JOlC3FWqKVQAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 26 May 2026 15:08:00 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	xen-devel@lists.xenproject.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH 0/5] x86/xen: Get rid of Xen private lazy MMU mode tracking
Date: Tue, 26 May 2026 17:05:09 +0200
Message-ID: <20260526150514.129330-1-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C673F75EE0
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]

With generic lazy MMU mode tracking being available, there is no real
need for having Xen PV specific code to track lazy MMU mode, too.

This makes it possible to drop two paravirt hooks.

Note that this series is based on my series "x86/xen: Do some Xen-PV
related cleanups" [1].

[1]: https://lore.kernel.org/lkml/20260522152114.77319-1-jgross@suse.com/

Juergen Gross (5):
  x86/xen: Drop lazy mode from trace entries
  x86/xen: Change interface of xen_mc_issue()
  mm: Refactor lazy_mmu_mode_pause() and lazy_mmu_mode_resume()
  x86/xen: Get rid of last XEN_LAZY_MMU uses
  x86/xen: Replace generic lazy tracking with cpu specific one

 arch/x86/include/asm/paravirt.h       |  9 ++--
 arch/x86/include/asm/paravirt_types.h | 11 +----
 arch/x86/include/asm/xen/hypervisor.h | 25 +---------
 arch/x86/kernel/paravirt.c            |  6 +--
 arch/x86/xen/enlighten_pv.c           | 30 +++++-------
 arch/x86/xen/mmu_pv.c                 | 66 +++++++++------------------
 arch/x86/xen/xen-ops.h                | 12 +++--
 include/linux/pgtable.h               | 56 ++++++++++++++++++-----
 include/trace/events/xen.h            | 33 ++++++++------
 9 files changed, 112 insertions(+), 136 deletions(-)

-- 
2.54.0

