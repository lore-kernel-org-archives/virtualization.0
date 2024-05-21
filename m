Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC61712F389
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301241; cv=none; b=aZqfkHhCuKZV697Nj9342reubd0rYerLGcwI3VaFi+yBMJ7MxmH/Jc+3JZulbbnSbCL18ux+8wsJeZgV71I+6WhKUbfjGInn8D9XS9zSSFc0BlvSJPomJSK3WkknKoW5I4NDKR47olWpzYhNGUAzyQipNVjMEnEBnGbF5qVVBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301241; c=relaxed/simple;
	bh=su20utJpl4Q5+4WEWl0JIpZRFLQjyxPG8Dy7FgaLppQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I64unKMbkM0ug66Xv5PgWpho2NaeMGmK53BastB92zU9T1gbYIxbLiiK1app4f++wuyeHH5Fd/CEWHUHUuWRItmzZlE8szci2ER+EL4sXpiJScVwKTqSrbdUw80ssmlexm7Iatv43+tay7TdHGqeD1hGhlBIECtE3qRykhnn/1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rO2eJGX2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RLmDzPRI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rO2eJGX2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RLmDzPRI; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rO2eJGX2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RLmDzPRI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rO2eJGX2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RLmDzPRI"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7AE8F4060B
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 14:20:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.4
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YIcHAyfZE2IP for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 14:20:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=osalvador@suse.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5D8A740603
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=suse.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5D8A740603
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rO2eJGX2;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RLmDzPRI;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rO2eJGX2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RLmDzPRI
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5D8A740603
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 14:20:38 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38F19342D8;
	Tue, 21 May 2024 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716301234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2gl6IIKZoaIcIf/VQk1wtsxiVEKAJnwFVp8xEUBBLc=;
	b=rO2eJGX2DCJrhuV+yZ3rMgnlKH+er2PdvSaY9aJKC/k8tQiX0sB1kwl5fRblWX1Lpm2Nlf
	grAAgFgARm88tcvB9VMdVY52e5DDA07n+cAxv6yUz9gShNiBcXKpDbotyF/HMvfjt9EXvl
	fBq/X2Kyo2xaVnUhaLJq1R6MyAbqgKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716301234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2gl6IIKZoaIcIf/VQk1wtsxiVEKAJnwFVp8xEUBBLc=;
	b=RLmDzPRIx+fhV+XYlKEzah51idE+LCMoIzIxbs59YgHiyMR7BXn6s/ds/Ll/ivLWuobT4k
	UGFf0v2KQ4F3SXBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rO2eJGX2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RLmDzPRI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716301234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2gl6IIKZoaIcIf/VQk1wtsxiVEKAJnwFVp8xEUBBLc=;
	b=rO2eJGX2DCJrhuV+yZ3rMgnlKH+er2PdvSaY9aJKC/k8tQiX0sB1kwl5fRblWX1Lpm2Nlf
	grAAgFgARm88tcvB9VMdVY52e5DDA07n+cAxv6yUz9gShNiBcXKpDbotyF/HMvfjt9EXvl
	fBq/X2Kyo2xaVnUhaLJq1R6MyAbqgKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716301234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2gl6IIKZoaIcIf/VQk1wtsxiVEKAJnwFVp8xEUBBLc=;
	b=RLmDzPRIx+fhV+XYlKEzah51idE+LCMoIzIxbs59YgHiyMR7BXn6s/ds/Ll/ivLWuobT4k
	UGFf0v2KQ4F3SXBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D5DE13A1E;
	Tue, 21 May 2024 14:20:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yy4lELGtTGaZAQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 21 May 2024 14:20:33 +0000
Date: Tue, 21 May 2024 16:20:31 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
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
Subject: Re: [PATCH v3 5/9] riscv: mm: Add memory hotplugging support
Message-ID: <ZkytryG_cAhjLaQT@localhost.localdomain>
References: <20240521114830.841660-1-bjorn@kernel.org>
 <20240521114830.841660-6-bjorn@kernel.org>
 <CAHVXubi_yQ6L5g4dODoHMNvgO6kHy8i6YskRXSPoTU4N2P8rUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVXubi_yQ6L5g4dODoHMNvgO6kHy8i6YskRXSPoTU4N2P8rUA@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 38F19342D8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,eecs.berkeley.edu,redhat.com,dabbelt.com,sifive.com,lists.infradead.org,rivosinc.com,catalinasystems.io,gmail.com,ventanamicro.com,vger.kernel.org,kvack.org,lists.linux-foundation.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Tue, May 21, 2024 at 03:19:37PM +0200, Alexandre Ghiti wrote:
> On Tue, May 21, 2024 at 1:49 PM Björn Töpel <bjorn@kernel.org> wrote:
> > +       if (PageReserved(page)) {
> > +               __ClearPageReserved(page);
> 
> What's the difference between __ClearPageReserved() and
> ClearPageReserved()? Because it seems like free_reserved_page() calls
> the latter already, so why would you need to call
> __ClearPageReserved() on the first page?

__{Set,Clear}Page are the non-atomic version.
Usually used when you know that no one else can fiddle with the page, which
should be the case here since we are removing the memory.

As to why we have __ClearPageReserved and then having
free_reserved_page() call ClearPageReserved I do not really know.
Looking at the history, it has always been like this.

I remember I looked at this a few years ago but I cannot remember the outcome
of that.

Maybe David remembers better, but I think we could remove that
__ClearPageReserved.
Looking at powerpc implementation code, it does not do the
__ClearPageReserved and relies only on free_reserved_page().

I will have a look.

-- 
Oscar Salvador
SUSE Labs
