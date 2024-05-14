Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1715D37141
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715719063; cv=none; b=kYtdTwXMhf3tZeqwdBZCj6dbyFqirts1VoxrSEpXr1+8rYKrN2xLCo79TyRenZVJp+UVR2rzMD3cbVWuwnQf7Qxm8QtKhaDgSFkNgjq+VPKcHf24rIuN4LKItuw5A4YoZN3XPRHSlWx8VRzq/y4FsHC4B9Efhbiyktn8U5/Tzvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715719063; c=relaxed/simple;
	bh=qtYRKkRqUl2iLbllESnnPGMb7ZoOLam5WvQiWWaqvhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKBpOv7RwVlAeBd6Ee+Ibpd4kaSNIerHJWx4H8e5iOnYNA57kTvjxDdqN1L16J7A5EtGvZN4veTdhnyawogYNspQE+0zP83JsiYQUKZZu8DHDuwqkGMDY0gs6KX0SRS2bnXXty4triKLyFoh0BWokJj4W3MK3q089dstJcx1VA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZpObK2ca; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UVARiUEa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZpObK2ca; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UVARiUEa; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZpObK2ca";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UVARiUEa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZpObK2ca";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UVARiUEa"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5F7F8233C
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 20:37:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.4
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m2OvYX8avlCQ for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 20:37:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BD20282331
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=suse.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD20282331
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZpObK2ca;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UVARiUEa;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZpObK2ca;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UVARiUEa
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BD20282331
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 20:37:40 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E0E01FB48;
	Tue, 14 May 2024 20:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715719056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYsW9Vv80A6GLzgjCSYellhzJczA30skEMWWKeZBbJk=;
	b=ZpObK2cayBrGFB+P30B4ta0PrzL46RFr44vUY5OO1vAowzek8thfNxxeOGE4BRsC7fIwDq
	+7eTpVOAzgxb7RFh6pnv6Q8JBVIOkawpsPDcTa2ObSEicYd8rCm0YADkPKTN8xOT7XG4tp
	dPHkjGGM+KVPvwqMxmeWz35c4ilgZQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715719056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYsW9Vv80A6GLzgjCSYellhzJczA30skEMWWKeZBbJk=;
	b=UVARiUEao8bnM3tGOX6fumiBKcLPbudeKiBmMYfi0BLZlApPyZMjtuUZjjsrk5V1d0PyxV
	o55zuYS0CbLs8iBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZpObK2ca;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UVARiUEa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715719056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYsW9Vv80A6GLzgjCSYellhzJczA30skEMWWKeZBbJk=;
	b=ZpObK2cayBrGFB+P30B4ta0PrzL46RFr44vUY5OO1vAowzek8thfNxxeOGE4BRsC7fIwDq
	+7eTpVOAzgxb7RFh6pnv6Q8JBVIOkawpsPDcTa2ObSEicYd8rCm0YADkPKTN8xOT7XG4tp
	dPHkjGGM+KVPvwqMxmeWz35c4ilgZQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715719056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYsW9Vv80A6GLzgjCSYellhzJczA30skEMWWKeZBbJk=;
	b=UVARiUEao8bnM3tGOX6fumiBKcLPbudeKiBmMYfi0BLZlApPyZMjtuUZjjsrk5V1d0PyxV
	o55zuYS0CbLs8iBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8341B1372E;
	Tue, 14 May 2024 20:37:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IqYEHY/LQ2aHIQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 14 May 2024 20:37:35 +0000
Date: Tue, 14 May 2024 22:37:30 +0200
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
Subject: Re: [PATCH v2 3/8] riscv: mm: Refactor create_linear_mapping_range()
 for memory hot add
Message-ID: <ZkPLimx-TSkufhjK@localhost.localdomain>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-4-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240514140446.538622-4-bjorn@kernel.org>
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,rivosinc.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6E0E01FB48
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, May 14, 2024 at 04:04:41PM +0200, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Add a parameter to the direct map setup function, so it can be used in
> arch_add_memory() later.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  arch/riscv/mm/init.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index c969427eab88..6f72b0b2b854 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1227,7 +1227,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  }
>  
>  static void __meminit create_linear_mapping_range(phys_addr_t start, phys_addr_t end,
> -						  uintptr_t fixed_map_size)
> +						  uintptr_t fixed_map_size, const pgprot_t *pgprot)
>  {
>  	phys_addr_t pa;
>  	uintptr_t va, map_size;
> @@ -1238,7 +1238,7 @@ static void __meminit create_linear_mapping_range(phys_addr_t start, phys_addr_t
>  					    best_map_size(pa, va, end - pa);
>  
>  		create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
> -				   pgprot_from_va(va));
> +				   pgprot ? *pgprot : pgprot_from_va(va));
>  	}
>  }
>  
> @@ -1282,22 +1282,19 @@ static void __init create_linear_mapping_page_table(void)
>  		if (end >= __pa(PAGE_OFFSET) + memory_limit)
>  			end = __pa(PAGE_OFFSET) + memory_limit;
>  
> -		create_linear_mapping_range(start, end, 0);
> +		create_linear_mapping_range(start, end, 0, NULL);
>  	}
>  
>  #ifdef CONFIG_STRICT_KERNEL_RWX
> -	create_linear_mapping_range(ktext_start, ktext_start + ktext_size, 0);
> -	create_linear_mapping_range(krodata_start,
> -				    krodata_start + krodata_size, 0);
> +	create_linear_mapping_range(ktext_start, ktext_start + ktext_size, 0, NULL);
> +	create_linear_mapping_range(krodata_start, krodata_start + krodata_size, 0, NULL);
>  
>  	memblock_clear_nomap(ktext_start,  ktext_size);
>  	memblock_clear_nomap(krodata_start, krodata_size);
>  #endif
>  
>  #ifdef CONFIG_KFENCE
> -	create_linear_mapping_range(kfence_pool,
> -				    kfence_pool + KFENCE_POOL_SIZE,
> -				    PAGE_SIZE);
> +	create_linear_mapping_range(kfence_pool, kfence_pool + KFENCE_POOL_SIZE, PAGE_SIZE, NULL);
>  
>  	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
>  #endif
> -- 
> 2.40.1
> 

-- 
Oscar Salvador
SUSE Labs
