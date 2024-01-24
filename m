Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D49F77F1A
	for <virtualization@lists.linux.dev>; Wed, 24 Jan 2024 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706103776; cv=none; b=Xc2voqicG51gZX1jckISNdQ7Jtpl/B2uNSzk04KttQo5PLFwk4REb2+4olmXFn+wdBOm9oG3bvzfVh02r8ZStwmAPeZROMW8Y3hFm3Qo5vP3Tetsv6+FlQgxRVWToN9jZgN5bBjxGpqR59455DX+r4RL2czGcc58n0x1RaImWq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706103776; c=relaxed/simple;
	bh=nMKBdjCsBZ3TqGyLrT8XtPzPuxEUUPnNT3AaX+dqYOY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1m6MbLcRgpNBkFpopaMmrEpRvIDXnzow+LeatOXUcQOruUJwkpD4qsQzLF4eoAp2RHr7KcbHMD5v15k3YluC+frLaiD3bKCGNryILgA3zweR+UznTVAGC8V7ae6iY1IgOJoyv7KU9ZYzgiyytZ9c/9RRe/zNso8et8FqwQCZNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q0HQvmDX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4FDc8RDl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HgW6kEUV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UbunKMZg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q0HQvmDX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4FDc8RDl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HgW6kEUV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UbunKMZg"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ECC461FD60;
	Wed, 24 Jan 2024 13:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706103773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0eNlWiBbfnLe7uwn0hD7uZLkeOMpIfrdyRclzBfd1w=;
	b=q0HQvmDXMYY6nsyHxFfGovfe2KybPwFFbjDJRpSdYrlDeBEy5KKGC3E+9GfqaVDMc1HdaS
	h+9KJ+1l6P70nQGLfi/PK09/PVJcZVWIRqESz+OVTkWFEKymMzxy3yxdiT8Uu9cUY1SqBX
	ujFIsC4OUqj2xauT+z6gJFRpU75W2Z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706103773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0eNlWiBbfnLe7uwn0hD7uZLkeOMpIfrdyRclzBfd1w=;
	b=4FDc8RDlVyTbYZzsbIZm0Df44WyVepvTXfZ/hpPrQw+wW+LvorMZNmHzepp+2PsW16tXQX
	BticPyNGHGnyulBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706103772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0eNlWiBbfnLe7uwn0hD7uZLkeOMpIfrdyRclzBfd1w=;
	b=HgW6kEUVoiRJX7ea7H5MVwa8w24xzEE60fkql/Ug29+2zNPpj6vRfTfTsrruoMQY7wXtxt
	uyP9bvbFlPMz9GkFmSKra6gFBJ4uFBEJw1IOv+qNN9MVkbpClEqQ+Qz3/FGLQyA9cQ+RUk
	4ZvrlArt6AFfBYTqiSF5JA3V7/c3v0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706103772;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0eNlWiBbfnLe7uwn0hD7uZLkeOMpIfrdyRclzBfd1w=;
	b=UbunKMZgV4rf3ioiD+q+EOAoBRJEmuvXTMgPP0Ts498S1V59Z6PVkibXfXbPbBTIjFVLbP
	2z4/zg/imkHfgjCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6E1813786;
	Wed, 24 Jan 2024 13:42:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lNXjJtwTsWX2SgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 24 Jan 2024 13:42:52 +0000
Date: Wed, 24 Jan 2024 14:42:52 +0100
Message-ID: <87sf2mlueb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Li RongQing <lirongqing@baidu.com>
Cc: anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	perex@perex.cz,
	tiwai@suse.com,
	virtualization@lists.linux.dev,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH] ALSA: virtio: remove duplicate check if queue is broken
In-Reply-To: <20240124120834.49410-1-lirongqing@baidu.com>
References: <20240124120834.49410-1-lirongqing@baidu.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HgW6kEUV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UbunKMZg
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.33 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.82)[99.23%]
X-Spam-Score: -5.33
X-Rspamd-Queue-Id: ECC461FD60
X-Spam-Flag: NO

On Wed, 24 Jan 2024 13:08:34 +0100,
Li RongQing wrote:
> 
> virtqueue_enable_cb() will call virtqueue_poll() which will check if
> queue is broken at beginning, so remove the virtqueue_is_broken() call
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Applied now.  Thanks.


Takashi
