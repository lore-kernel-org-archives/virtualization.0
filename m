Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113DD181333
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 20:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715718777; cv=none; b=Kn4RswhL7s+j1di84khZQMkdhSWfcQ8Md1ksiBYV5Zq1NewC+FjGjrlkSsPUZS8xNuSLiOoZ2Qpzt7Bzk44X9cuaeq3Az3+zXZNg1EIp3TkpnG5dHdvic2TyD74m/JLmUXfmEQqJHKgQq2Zbt1xLeV1lbmrW7OHKBZX39z3p3Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715718777; c=relaxed/simple;
	bh=RdkQFK1O+AIwgCXbOlknN6KrMEhO+Se7DoIN+ZAc9xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXiPSluxt9GunR/ip0v2OjJSxMnsY01oGHCLLNqu6lei//0NgoluZBPaMDzvzI9JSBBiQWB+Cvc8+KaP39G6J52OKEEwEAzUZvSf25Yq2yOwFPBIDW/aLgVJVd0wqgDmUKw7kQz3ntOC7sFoHq1kFARYFtV4S8YvDpXy3WP653w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LukJ1p5P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0I+MOdkt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LukJ1p5P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0I+MOdkt; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LukJ1p5P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0I+MOdkt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LukJ1p5P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0I+MOdkt"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A39756069C
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 20:32:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.4
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0FiK4wxXdImb for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 20:32:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A111D6062B
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=suse.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A111D6062B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LukJ1p5P;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0I+MOdkt;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LukJ1p5P;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0I+MOdkt
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A111D6062B
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 20:32:54 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 948CB1F911;
	Tue, 14 May 2024 20:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715718769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kk3PUJn0ZHUnCyV3wo0S0YEaGX6X5EGmXK7wEUx20rU=;
	b=LukJ1p5PWWbiu3qKRQ/sdBVZjjoR0JzQ24HSt7G0MajKuuOYVYByXM20LDzK5JbQMo4ziE
	z56/SLJzivpZcOuRUZw98Ki+vjMIlh040AIgK3vCWPnae6g4phKWqb4LsXlpLf2oKOt2ie
	kBrnRmDUjemc4Kg1FQe04AfOtXVmfyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715718769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kk3PUJn0ZHUnCyV3wo0S0YEaGX6X5EGmXK7wEUx20rU=;
	b=0I+MOdkt9NAN1JNbZ+9l7B9kHwT3WJVbIfpIfdTQse7f9nh8EeVYBmLj1d8T55ebexCPns
	3m0Q9+x/wNs3lhDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LukJ1p5P;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0I+MOdkt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715718769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kk3PUJn0ZHUnCyV3wo0S0YEaGX6X5EGmXK7wEUx20rU=;
	b=LukJ1p5PWWbiu3qKRQ/sdBVZjjoR0JzQ24HSt7G0MajKuuOYVYByXM20LDzK5JbQMo4ziE
	z56/SLJzivpZcOuRUZw98Ki+vjMIlh040AIgK3vCWPnae6g4phKWqb4LsXlpLf2oKOt2ie
	kBrnRmDUjemc4Kg1FQe04AfOtXVmfyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715718769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kk3PUJn0ZHUnCyV3wo0S0YEaGX6X5EGmXK7wEUx20rU=;
	b=0I+MOdkt9NAN1JNbZ+9l7B9kHwT3WJVbIfpIfdTQse7f9nh8EeVYBmLj1d8T55ebexCPns
	3m0Q9+x/wNs3lhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90A4B1372E;
	Tue, 14 May 2024 20:32:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kE0NIHDKQ2aOIAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 14 May 2024 20:32:48 +0000
Date: Tue, 14 May 2024 22:32:43 +0200
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
Subject: Re: [PATCH v2 2/8] riscv: mm: Change attribute from __init to
 __meminit for page functions
Message-ID: <ZkPKazeHI4CENSP3@localhost.localdomain>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-3-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240514140446.538622-3-bjorn@kernel.org>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 948CB1F911
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.49 / 50.00];
	BAYES_HAM(-2.98)[99.92%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Tue, May 14, 2024 at 04:04:40PM +0200, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Prepare for memory hotplugging support by changing from __init to
> __meminit for the page table functions that are used by the upcoming
> architecture specific callbacks.
> 
> Changing the __init attribute to __meminit, avoids that the functions
> are removed after init. The __meminit attribute makes sure the
> functions are kept in the kernel text post init, but only if memory
> hotplugging is enabled for the build.
> 
> Also, make sure that the altmap parameter is properly passed on to
> vmemmap_populate_hugepages().
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> +static void __meminit create_linear_mapping_range(phys_addr_t start, phys_addr_t end,
> +						  uintptr_t fixed_map_size)
>  {
>  	phys_addr_t pa;
>  	uintptr_t va, map_size;
> @@ -1435,7 +1429,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  	 * memory hotplug, we are not able to update all the page tables with
>  	 * the new PMDs.
>  	 */
> -	return vmemmap_populate_hugepages(start, end, node, NULL);
> +	return vmemmap_populate_hugepages(start, end, node, altmap);

I would have put this into a separate patch.

 

-- 
Oscar Salvador
SUSE Labs
