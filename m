Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E085181339
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715720810; cv=none; b=jHWh6qwmH0p8hkdCF2F2cDqCo9WWlA5afxvy1v6tgDn+/4XEfLLyTIxC1GNbRL5klzBrAzQ5Ua2KvY1VjXc0rYmxaijZu5pG5YWXhHWrBfiTtOeMMLItyCU26b8IPfm80/CmU/efV42jcB4dDO5A9msvM8Vy7j0KLGBfPU2NBDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715720810; c=relaxed/simple;
	bh=gYCUW4tqnJup9F7JzVjpKyNyJPHk/tRp5a9F0VQighA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLymH5u53kros80sdHvsac0w/6Wf+zFYYXaOdq6fFPlXxB1Jw8JiscIFSdp+XhHtuuvYHvLdD2QfTGXbAGSNyLiYD6mTAuyqb+U+MecYei19M7bJLORKAVzAiDaM5Makhp+svfMtQw3nfhS7fcSsxY+odQWI8FyOYQ3gGz8Dzm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hHft803e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wMWfzj2H; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hHft803e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wMWfzj2H; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hHft803e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wMWfzj2H";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hHft803e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wMWfzj2H"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1C8040782
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 21:06:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.4
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5jjXuZTWGwt7 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 21:06:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A86FD406B1
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=suse.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A86FD406B1
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hHft803e;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wMWfzj2H;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hHft803e;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wMWfzj2H
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A86FD406B1
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 21:06:47 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 670E51FBAB;
	Tue, 14 May 2024 21:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715720805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMfKixceV4qr83nNPK38FwuyfKkOiLi4Qx7Rk6Mapug=;
	b=hHft803ecNlAb2YgHf6izR+uuw6VXIVGwgEFzoR3J5Fmy5mxhCGpMIwVP/QgnoAuADzfR8
	3fBt2jrbi3GFXS3JqjP3piN11nmBrP+zcHEkBhDSoXVP0kPQC3xT8lJyOMt8SqNesYXY9U
	NeV9r4RpUeBPDj9g0R0N3D5bQ7WuMoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715720805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMfKixceV4qr83nNPK38FwuyfKkOiLi4Qx7Rk6Mapug=;
	b=wMWfzj2HuRxxULRaIM/Wsg5cwWf03TJ88p+VC7oC193PoZn+9GVXkz0sGMRxpDwJhL28LZ
	O6TSPa/HhmUko3AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hHft803e;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wMWfzj2H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715720805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMfKixceV4qr83nNPK38FwuyfKkOiLi4Qx7Rk6Mapug=;
	b=hHft803ecNlAb2YgHf6izR+uuw6VXIVGwgEFzoR3J5Fmy5mxhCGpMIwVP/QgnoAuADzfR8
	3fBt2jrbi3GFXS3JqjP3piN11nmBrP+zcHEkBhDSoXVP0kPQC3xT8lJyOMt8SqNesYXY9U
	NeV9r4RpUeBPDj9g0R0N3D5bQ7WuMoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715720805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMfKixceV4qr83nNPK38FwuyfKkOiLi4Qx7Rk6Mapug=;
	b=wMWfzj2HuRxxULRaIM/Wsg5cwWf03TJ88p+VC7oC193PoZn+9GVXkz0sGMRxpDwJhL28LZ
	O6TSPa/HhmUko3AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E7D21372E;
	Tue, 14 May 2024 21:06:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QUEoHGTSQ2bjKAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 14 May 2024 21:06:44 +0000
Date: Tue, 14 May 2024 23:06:43 +0200
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
Subject: Re: [PATCH v2 6/8] riscv: Enable memory hotplugging for RISC-V
Message-ID: <ZkPSY6JLddeusGXJ@localhost.localdomain>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-7-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240514140446.538622-7-bjorn@kernel.org>
X-Spamd-Result: default: False [-6.50 / 50.00];
	BAYES_HAM(-2.99)[99.95%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[rivosinc.com,eecs.berkeley.edu,redhat.com,dabbelt.com,sifive.com,lists.infradead.org,catalinasystems.io,gmail.com,ventanamicro.com,vger.kernel.org,kvack.org,lists.linux-foundation.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,rivosinc.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 670E51FBAB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, May 14, 2024 at 04:04:44PM +0200, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Enable ARCH_ENABLE_MEMORY_HOTPLUG and ARCH_ENABLE_MEMORY_HOTREMOVE for
> RISC-V.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>  arch/riscv/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 6bec1bce6586..b9398b64bb69 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -16,6 +16,8 @@ config RISCV
>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>  	select ARCH_DMA_DEFAULT_COHERENT
>  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
> +	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM && 64BIT && MMU

Hopefully this should be SPARSEMEM_VMEMMAP.
We are trying to deprecate memory-hotplug on !SPARSEMEM_VMEMMAP.

And it is always easier to do it now that when the code goes already in,
so please consider if you really need SPARSEMEM and why (I do not think
you do).

 

-- 
Oscar Salvador
SUSE Labs
