Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7D43806A2
	for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774004558; cv=none; b=RkMIiLfM/Tv/RCbP9WDLgX/LMTgGbrIXfOrdNr8HldSaZxJXTvBgweXMNdvNCieBpN8MFf34oUoeivEM+Qv5twgbr30lEVdE1eA+WY1yXEZPFMPQ/aG5QLTMHOErZkEMg4jxrox5nD67pAefSWf6xEYT9Y3PdNDU8FZccWQ88ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774004558; c=relaxed/simple;
	bh=ADuYsDMUdHpn8bfrceLDi1vQuYixzdfca6AIYCwJxyM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nigbj13rWcK8P/KH389+n0U/dXApTkTLz/b8/CdqffJfOoB+YLyKefWWc++zaU5jQG2duoSjn8+V5wPMcHCxKjV9NCWBkAlhuqYx8purshe99H5FQibPrM56Va0dzvRDKCLYR+h/C9fB66As+Rpi3ATNBlnnRGqPnrCN/JdvWxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kSxO7L0M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I0/eEZju; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SnTorjlu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JJUg01bC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kSxO7L0M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I0/eEZju";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SnTorjlu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JJUg01bC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D223D4D24D;
	Fri, 20 Mar 2026 11:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774004555;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ADuYsDMUdHpn8bfrceLDi1vQuYixzdfca6AIYCwJxyM=;
	b=kSxO7L0MVfzj0e1wO9MqhFDmFrce8KVXHSHp1vEEprA3fUqoaB5K9hJZFnNk/Lh9Sd5P1z
	Rv0kyIPemFKCK5mSupKdaNZTNmU/NW/+wtQYO2CPIrkmWoRMlkEUmlAtiUHp7e82a9kCyW
	mX39S/RWop7AcpDma3UUwHnPrie/5fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774004555;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ADuYsDMUdHpn8bfrceLDi1vQuYixzdfca6AIYCwJxyM=;
	b=I0/eEZju2obF86thKoppQTQjmJq097usim5gFUrWQK/p7Z3o6LGRD406/Fkiqv3qiDXazj
	/CLLOHdONgWg9mDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SnTorjlu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JJUg01bC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774004550;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ADuYsDMUdHpn8bfrceLDi1vQuYixzdfca6AIYCwJxyM=;
	b=SnTorjlul6wCyF3+1yHcR7Y4Tr3KkJtwBuYhZA+1H2Z5TbJtTNqdAMN6CaDezBFUHJDfbu
	bO5MO19kGTNXNuKOyvk0HMqS6ToemIeS7s7fQbKX1L6zgWDEBrI6GgLwRNJOfFRon/qPFF
	FseJFGVSxhVO4TVaa7W+tTmSnSo1MAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774004550;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ADuYsDMUdHpn8bfrceLDi1vQuYixzdfca6AIYCwJxyM=;
	b=JJUg01bCzyvruxByQ6brhE3kUcc1uhfDmxCK1OQ8mjwu/bZ/uhX6ufNhtDSpBPP8WvJF09
	k0DuGhVfB4IcSWDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F62742751;
	Fri, 20 Mar 2026 11:02:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wweKGEYpvWnoYQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 20 Mar 2026 11:02:30 +0000
Date: Fri, 20 Mar 2026 12:02:24 +0100
From: Petr Vorel <pvorel@suse.cz>
To: virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
	Valentin Lefebvre <valentin.lefebvre@suse.com>,
	Yu Watanabe <watanabe.yu@gmail.com>,
	Andrei Borzenkov <arvidjaar@gmail.com>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	Luca Boccassi <bluca@debian.org>
Subject: [RFC] loading vmw_vsock_virtio_transport by systemd breaks
 vsock_loopback autoloading
Message-ID: <20260320110224.GA140154@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,suse.com,gmail.com,debian.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: D223D4D24D
X-Spam-Flag: NO
X-Spam-Score: -2.21
X-Spam-Level: 

Hi all,

there is a systemd bug [1] which causes vsock_loopback not to be autoloaded due
previous loading vmw_vsock_virtio_transport in an early phase of boot.
vmw_vsock_virtio_transport requires vmw_vsock_virtio_transport_common and vsock,
vsock_loopback requires vsock.

Reproducer: [2].
Proposed fix in systemd: [3]

While I think the bug should be fixed in systemd with proposed fix [3] we'd like
to know opinion of the kernel vsock developers in case there is a way to improve
vsock modules autoloading.

Kind regards,
Petr

[1] https://github.com/systemd/systemd/issues/41100
[2] https://bugzilla.suse.com/attachment.cgi?id=888729
[3] https://github.com/systemd/systemd/issues/41100#issuecomment-4056603242
