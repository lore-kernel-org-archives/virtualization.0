Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D79E3DDDBC
	for <virtualization@lists.linux.dev>; Sat, 16 May 2026 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778938970; cv=none; b=YFpA0mki5FzqDXb4SZchDp0SOntnzOISjoZXUxzA1cRHfabsg8+2GSHYhjpNopnl1UJ6qz0xumzeS6M7RhzFa3esdatECseH/vZ8ulRqDSUAeJ5Ylcxae/2nim2MBTFvA7lqLUIz7i3hTQioxpJZiXgYs9Xx2Da4cytadU0ZMJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778938970; c=relaxed/simple;
	bh=uC8BsyLmrT03QLjCaAHaGbKUarn/DUx4e6zvTxtJemo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hd4ouW3YE4UWkB0DlZu5XYA0K3OUoZrgF1CSBrOgoMjn4VdbvjfoxZaB8fIQ62BUTXh5ZoQT/UnFGG4r4W5gVyfrtfykuS8brlw+gEF0kLSjdlrU6nqv2CV9siC1ap6hLY/gn64nmoNSd/6GRX33qB1M/XwM1PVsFp5z7W0mQhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X5QicUNS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+ycpOTox; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X5QicUNS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+ycpOTox; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X5QicUNS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+ycpOTox";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X5QicUNS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+ycpOTox"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71260618C3;
	Sat, 16 May 2026 13:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778938967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/iGlt2/sDx2Kingd1aFNcx8cUd6lujRs7wLaloPoelc=;
	b=X5QicUNSAmCjaIYDwQTBAuS0Vx673B/A+Hh+vom9A3TSf8pjGOAHzlBfRqYCmdTcFWrGLU
	czMZUJFnyQzCiJHudZHAqQkYgl3T9h27x6mQFbZisIeMc1E03AN4QJ4h4OiB5npaee1yLe
	LJPP7erTuPKeu2LnUzX5ZPJoLOygMHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778938967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/iGlt2/sDx2Kingd1aFNcx8cUd6lujRs7wLaloPoelc=;
	b=+ycpOTox/5Sqe6MwBPFXvDMmyH59XSQ96oJ3Wy2cJm2rC61slfC5dPasREQo+AqTgEHpFA
	3YAFxYhNDBq6FkAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=X5QicUNS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+ycpOTox
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778938967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/iGlt2/sDx2Kingd1aFNcx8cUd6lujRs7wLaloPoelc=;
	b=X5QicUNSAmCjaIYDwQTBAuS0Vx673B/A+Hh+vom9A3TSf8pjGOAHzlBfRqYCmdTcFWrGLU
	czMZUJFnyQzCiJHudZHAqQkYgl3T9h27x6mQFbZisIeMc1E03AN4QJ4h4OiB5npaee1yLe
	LJPP7erTuPKeu2LnUzX5ZPJoLOygMHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778938967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/iGlt2/sDx2Kingd1aFNcx8cUd6lujRs7wLaloPoelc=;
	b=+ycpOTox/5Sqe6MwBPFXvDMmyH59XSQ96oJ3Wy2cJm2rC61slfC5dPasREQo+AqTgEHpFA
	3YAFxYhNDBq6FkAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EAAF593A8;
	Sat, 16 May 2026 13:42:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EU+WCFd0CGpwYAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 16 May 2026 13:42:47 +0000
Date: Sat, 16 May 2026 15:42:46 +0200
Message-ID: <87se7rxyg9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] ALSA: virtio: Add missing 384 kHz PCM rate mapping
In-Reply-To: <20260515-alsa-virtio-384k-rate-v1-1-35ecb5df835c@gmail.com>
References: <20260515-alsa-virtio-384k-rate-v1-1-35ecb5df835c@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 71260618C3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.51

On Fri, 15 May 2026 15:32:25 +0200,
Cássio Gabriel wrote:
> 
> The VirtIO sound UAPI defines VIRTIO_SND_PCM_RATE_384000, and ALSA
> has SNDRV_PCM_RATE_384000. However, virtio-snd's rate conversion
> tables stop at 192 kHz.
> 
> A device advertising only 384 kHz is rejected as having no supported
> PCM frame rates. A device advertising 384 kHz together with lower rates
> does not expose 384 kHz through the ALSA hardware constraints. The
> selected ALSA rate also needs a reverse mapping for SET_PARAMS.
> 
> Add the missing 384 kHz entries to both conversion tables.
> 
> Fixes: 29b96bf50ba9 ("ALSA: virtio: build PCM devices and substream hardware descriptors")
> Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

Applied to for-next branch now.  Thanks.


Takashi
