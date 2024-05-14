Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6914017F36E
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 21:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715720630; cv=none; b=ZnItgWHBlnBO5A02FRQTzVsTwZBnADjg1xIu/irfa4PCxx/dZrzRqsJTTtcYRIFGbNdu8GyfxuAMPMNBgDYKL9DU2nk7KDqzsnnvjNqI0kkYvxE33Qj9D9mO+CNJG49Wr20kORBJV6L11KjGXL1hgVqjsowkhXxIvmD4dRH5LjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715720630; c=relaxed/simple;
	bh=GECJCyHkaDUmKNqSuWSOdIioBqA9Kdoym171AamYHYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmuj0unJOkQ/rav+abeXxXOfxUrezZlUjyLy+jxsPo3TxjY+b3qoIcy5+MoUNIqd6UwNrvhAlRZn3nXA1PrhAc/KTxQ45ctctkTqws0dJtu0HfLr/JEK2HShlhXNJmBcLyiDQqSleRMLHMFpuTNwqXcQrZtzyyX77R143oI+N/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u6ZVCiAj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/f9yNye8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u6ZVCiAj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/f9yNye8; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u6ZVCiAj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/f9yNye8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u6ZVCiAj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/f9yNye8"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E493E80DD3
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 21:03:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.4
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bt2gFSThXjYd for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 21:03:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E9B2780DCC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=suse.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E9B2780DCC
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=u6ZVCiAj;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/f9yNye8;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=u6ZVCiAj;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/f9yNye8
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E9B2780DCC
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 21:03:47 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9CA9A1FBA6;
	Tue, 14 May 2024 21:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715720625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsytN/Ol0bA8FK1+9NUuQFTtsbXKHbOnQZ7CagSXtsE=;
	b=u6ZVCiAjzycXAwGcaHq1QPNWE8OZdJEdtr1m3hRNKyev3uDuY/xGzqChh7uk5T4NjYUeuX
	crPvzJ8JLq4isvh9TLO9QECXAWJcCSPwVNvvV4EaVYUA0JSXjP8d2wiQD6p7VEwYDjXCzq
	me1TGuukLfetINnfR6MZSOOO4cCcJYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715720625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsytN/Ol0bA8FK1+9NUuQFTtsbXKHbOnQZ7CagSXtsE=;
	b=/f9yNye86xDoN89fH3Puo6+R4EuwSeCQwsnMxLRcEwCCN0q/fXDri7/gSpoFwdEyJN7aIK
	ecgjVPiglyCZWdAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u6ZVCiAj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/f9yNye8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715720625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsytN/Ol0bA8FK1+9NUuQFTtsbXKHbOnQZ7CagSXtsE=;
	b=u6ZVCiAjzycXAwGcaHq1QPNWE8OZdJEdtr1m3hRNKyev3uDuY/xGzqChh7uk5T4NjYUeuX
	crPvzJ8JLq4isvh9TLO9QECXAWJcCSPwVNvvV4EaVYUA0JSXjP8d2wiQD6p7VEwYDjXCzq
	me1TGuukLfetINnfR6MZSOOO4cCcJYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715720625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsytN/Ol0bA8FK1+9NUuQFTtsbXKHbOnQZ7CagSXtsE=;
	b=/f9yNye86xDoN89fH3Puo6+R4EuwSeCQwsnMxLRcEwCCN0q/fXDri7/gSpoFwdEyJN7aIK
	ecgjVPiglyCZWdAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B45331372E;
	Tue, 14 May 2024 21:03:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /kVBKbDRQ2Y5KAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 14 May 2024 21:03:44 +0000
Date: Tue, 14 May 2024 23:03:39 +0200
From: Oscar Salvador <osalvador@suse.de>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 5/8] riscv: mm: Take memory hotplug read-lock during
 kernel page table dump
Message-ID: <ZkPRq5zca7PGsqwJ@localhost.localdomain>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-6-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240514140446.538622-6-bjorn@kernel.org>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9CA9A1FBA6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[rivosinc.com,eecs.berkeley.edu,redhat.com,dabbelt.com,sifive.com,lists.infradead.org,catalinasystems.io,gmail.com,ventanamicro.com,vger.kernel.org,kvack.org,lists.linux-foundation.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rivosinc.com:email,suse.de:dkim,suse.de:email]

On Tue, May 14, 2024 at 04:04:43PM +0200, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> During memory hot remove, the ptdump functionality can end up touching
> stale data. Avoid any potential crashes (or worse), by holding the
> memory hotplug read-lock while traversing the page table.
> 
> This change is analogous to arm64's commit bf2b59f60ee1 ("arm64/mm:
> Hold memory hotplug lock while walking for kernel page table dump").
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

funny enough, it seems arm64 and riscv are the only ones holding the
hotplug lock here.
I think we have the same problem on the other arches as well (at least
on x86_64 that I can see).

If we happen to finally need the lock in those, I would rather have a
centric function in the generic mm code with the locking and then
calling an arch specific ptdump_show function, so the lock is not
scattered. But that is another story.

 

-- 
Oscar Salvador
SUSE Labs
