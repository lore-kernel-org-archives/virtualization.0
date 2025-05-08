Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588D91D86DC
	for <virtualization@lists.linux.dev>; Thu,  8 May 2025 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746698045; cv=none; b=JdziZgLFJbwh+o+iGQs0VoqENL63B2tI4PHdYSS9x7TtIe+h71rExloa6cFxELMCpu/xlidDuC7iYGgvNSpAAL/IhHFeWNvJKvOa1q/UgaW9NNyWDV6Bhb2+CwZ62ELs3eE62vPnTwRnp118x82CFxdi3QXI8J6VajQ+ie8fWR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746698045; c=relaxed/simple;
	bh=xDgcanYmeQvlUAYvmcYhBQ7PDvJsAKwg/aRNCsXwpB0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGSIYmHTeMPjWpYOGuGzm1/I7kUM9VIUexTx5goxW8ohfgGVMRMiWtze0duNyoPsLQc5g5gFSUExiGP3FhvK4S9fW0aJy9gPIpj+aAVBepA/xksrlnjuEYUhEZlsXMQK9ExxEDtkMkMdYVyc/im6cpf5dWRodhPRSS28NaplV5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lF6+0GDA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ok/Ma3nP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lF6+0GDA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ok/Ma3nP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lF6+0GDA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ok/Ma3nP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lF6+0GDA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ok/Ma3nP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47A912117A;
	Thu,  8 May 2025 09:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746698042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RxG9IVDtsZQdIKj7NVk4b/0wMJ6lHFHL7+BtfPnACi0=;
	b=lF6+0GDAmXkKEPzLgk1qhY3O0ZrQ06C6HQiN31P6WF1MdOWenbDqSNp4fjmlZaTNJfDzE5
	m+RLUvuzxnp5oFMhNHd4/z7zZDSyzWVtIdME5O1CaNOGzVqHJXa2OXhLqAu7ugmasBERZt
	81JZorjsA0M/7r/CrejWLoKKdL8hJz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746698042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RxG9IVDtsZQdIKj7NVk4b/0wMJ6lHFHL7+BtfPnACi0=;
	b=ok/Ma3nPfNT/10rbuz8ViYniGYuSEfcFSRYJ1G5xtfMTkkslLEemTLP4GogL/F5gz0AF7u
	rV1HM4btGhkWf1DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lF6+0GDA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="ok/Ma3nP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746698042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RxG9IVDtsZQdIKj7NVk4b/0wMJ6lHFHL7+BtfPnACi0=;
	b=lF6+0GDAmXkKEPzLgk1qhY3O0ZrQ06C6HQiN31P6WF1MdOWenbDqSNp4fjmlZaTNJfDzE5
	m+RLUvuzxnp5oFMhNHd4/z7zZDSyzWVtIdME5O1CaNOGzVqHJXa2OXhLqAu7ugmasBERZt
	81JZorjsA0M/7r/CrejWLoKKdL8hJz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746698042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RxG9IVDtsZQdIKj7NVk4b/0wMJ6lHFHL7+BtfPnACi0=;
	b=ok/Ma3nPfNT/10rbuz8ViYniGYuSEfcFSRYJ1G5xtfMTkkslLEemTLP4GogL/F5gz0AF7u
	rV1HM4btGhkWf1DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 082C813712;
	Thu,  8 May 2025 09:54:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FWPCADp/HGj3dwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 08 May 2025 09:54:02 +0000
Date: Thu, 08 May 2025 11:54:01 +0200
Message-ID: <87bjs3v35y.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	David Rhodes <david.rhodes@cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 00/12] ALSA: use snd_kcontrol_chip()
In-Reply-To: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
References: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 47A912117A
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action

On Wed, 07 May 2025 06:58:47 +0200,
Kuninori Morimoto wrote:
> 
> 
> Takashi-san
> 
> Many drivers are getting its private data via kcontrol->private_data,
> but we already have common snd_kcontrol_chip(). We should use it.
> 
> Kuninori Morimoto (12):
>   ALSA: sh: use snd_kcontrol_chip()
>   ALSA: i2c: use snd_kcontrol_chip()
>   ALSA: core: use snd_kcontrol_chip()
>   ALSA: virtio: use snd_kcontrol_chip()
>   ALSA: pci: hda: use snd_kcontrol_chip()
>   ALSA: usb: midi: use snd_kcontrol_chip()
>   ALSA: usb: mixer: use snd_kcontrol_chip()
>   ALSA: pci: au88x0: use snd_kcontrol_chip()
>   ALSA: pci: asihpi: use snd_kcontrol_chip()
>   ALSA: pci: ali5451: use snd_kcontrol_chip()
>   ALSA: usb: mixer_quirks: use snd_kcontrol_chip()
>   ALSA: usb: mixer_us16x08: use snd_kcontrol_chip()

Applied all patches now to for-next branch.


thanks,

Takashi
