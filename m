Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2B53B47CF
	for <virtualization@lists.linux.dev>; Mon, 30 Mar 2026 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774912203; cv=none; b=CNFzo6+O7mX67w3jth+OOhp1zfXdZcn0sDa1Bf47oE7Xp3lAFEiLOpLkeSH6LbLaStRW2PSyRSh03qYTTXRuqD3ek2dRmUsv1k4dyG59Lk4ZLRg9llJNnTlittOCfNXo18iTfQIZHvU8ujgTgN5P9mj1Mmu+FYzvVaGdQu8PDWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774912203; c=relaxed/simple;
	bh=je0nK5GYgw4YWy/87+u34k0PPJBhDhJUBSziNOQACTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ev/E4nWCccS1RbXARNRoZJIYnkyijFcqwg+13MrpsWdHHqN3gXL/h6vPOaflx3iSWDBdVimn3uA2FyYmRBRNyRk+io4M45o4NMmhj1SHOahtAUQadpv8c34KdVadg2JpNy1uoJuo6aNzxzwmecZvkhPjlcVjocic7whHLMX3qfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pN/DWH7B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TwTxOO0o; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pN/DWH7B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TwTxOO0o; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pN/DWH7B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TwTxOO0o";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pN/DWH7B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TwTxOO0o"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 272C54D267;
	Mon, 30 Mar 2026 23:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774912197;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=je0nK5GYgw4YWy/87+u34k0PPJBhDhJUBSziNOQACTc=;
	b=pN/DWH7B+3f/367yUERIqospKSvUnkVHx07ywRM5WYA1kQL4mwaA2vqQehQ49Dm+pT0b8U
	S2hFT7QaN3R7M0DylIxD6yK7YWvzqQJTUusVfSmDSxQ/R4Ez1uMEgkTltF2h0DHalR+TQS
	ONB4Sc/GRjTW1NfGH1R7RI6mGuw3Y3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774912197;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=je0nK5GYgw4YWy/87+u34k0PPJBhDhJUBSziNOQACTc=;
	b=TwTxOO0obSlo/RCv5hZfn22IM7haTn0EyQJ22X0M6Emak33dMD+/vcHoReV4o/I+PkRifc
	OivNIGbajwB687Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="pN/DWH7B";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TwTxOO0o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774912197;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=je0nK5GYgw4YWy/87+u34k0PPJBhDhJUBSziNOQACTc=;
	b=pN/DWH7B+3f/367yUERIqospKSvUnkVHx07ywRM5WYA1kQL4mwaA2vqQehQ49Dm+pT0b8U
	S2hFT7QaN3R7M0DylIxD6yK7YWvzqQJTUusVfSmDSxQ/R4Ez1uMEgkTltF2h0DHalR+TQS
	ONB4Sc/GRjTW1NfGH1R7RI6mGuw3Y3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774912197;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=je0nK5GYgw4YWy/87+u34k0PPJBhDhJUBSziNOQACTc=;
	b=TwTxOO0obSlo/RCv5hZfn22IM7haTn0EyQJ22X0M6Emak33dMD+/vcHoReV4o/I+PkRifc
	OivNIGbajwB687Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C10A54A0A2;
	Mon, 30 Mar 2026 23:09:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cMOQLMQCy2nJZgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 30 Mar 2026 23:09:56 +0000
Date: Tue, 31 Mar 2026 01:09:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
	Valentin Lefebvre <valentin.lefebvre@suse.com>,
	Yu Watanabe <watanabe.yu@gmail.com>,
	Andrei Borzenkov <arvidjaar@gmail.com>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	Luca Boccassi <bluca@debian.org>, ltp@lists.linux.it
Subject: Re: [RFC] loading vmw_vsock_virtio_transport by systemd breaks
 vsock_loopback autoloading
Message-ID: <20260330230951.GB108555@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20260320110224.GA140154@pevik>
 <acqLo6-IQVBzY3UW@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acqLo6-IQVBzY3UW@sgarzare-redhat>
X-Spamd-Result: default: False [-2.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,suse.com,gmail.com,debian.org,lists.linux.it];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.21
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 272C54D267

[ Cc LTP ML ]

> On Fri, Mar 20, 2026 at 12:02:24PM +0100, Petr Vorel wrote:
> > Hi all,

> > there is a systemd bug [1] which causes vsock_loopback not to be autoloaded due
> > previous loading vmw_vsock_virtio_transport in an early phase of boot.
> > vmw_vsock_virtio_transport requires vmw_vsock_virtio_transport_common and vsock,
> > vsock_loopback requires vsock.

> > Reproducer: [2].
> > Proposed fix in systemd: [3]

> > While I think the bug should be fixed in systemd with proposed fix [3] we'd like
> > to know opinion of the kernel vsock developers in case there is a way to improve
> > vsock modules autoloading.

> The original idea of vsock_loopback was to be used just for
> testing/debugging, so maybe even the autoloading when no other transport was
> loaded wasn't a great idea, but at the time we thought it might be useful
> for testing.

Stefano, thanks for info.

> In general, therefore, if you want to use the loopback, it's always best to
> load vsock_loopback.

> What use case is being affected by the fact that vsock_loopback isn't loaded
> automatically?

It's actually testing. Only LTP test cve-2025-21756.c [1] used it.

Reported [2], fixed in systemd [3].
Of course we could call 'modprobe vsock_loopback' in the test, but now not
needed as as fixed in systemd.

I wonder who else uses the module. Searching in Debian's codesearch I see mostly
testing code (+ now systemd :)).

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/cve/cve-2025-21756.c
[2] https://github.com/systemd/systemd/issues/41100
[3] https://github.com/systemd/systemd/commit/7c1075fb8ff2d3b87fa463d542e2e00ac086cbd3
[4] https://codesearch.debian.net/search?q=vsock_loopback&perpkg=1&page=1

> Thanks,
> Stefano

