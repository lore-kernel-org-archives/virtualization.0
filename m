Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27244EB43
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817352; cv=none; b=ONLKSIosHpyhrgFxi5WK0S8iBCWW1iziLVkxh7ElqsjZZYkJEE4dsocQAwnYSJ2wFU9x19XG9TrnK8ij79g2U5QzghcySGMC8Gy0M6FIiJbutnVGl6+8kc7A9Jk/fexkImAkqCypnPO4EUcix0AL8AOaDP1EVHQkeUaflSoT0R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817352; c=relaxed/simple;
	bh=rXimP4nDvNqHFT2twZNZ18Rr3AqFRzvwEhxiHdnnpGY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iDrg/85zCSgoOXvPBTnaa5h3Nog6ZJouypC1xxSatnoCvnaozPk6R1nGs2FgNQYZr7fF7e4T+UH5HC4U7DGz0lQinr4loakhkspK8S2E3vvykNoQx64Sldha9zua7aklP6EG31Rc4Pwoqgwt27JvtMjPlfJLjwtugt8l5K2kskA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R5AyAvv4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sf5YPaxl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R5AyAvv4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sf5YPaxl; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R5AyAvv4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sf5YPaxl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R5AyAvv4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sf5YPaxl"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88F1A40996
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 09:42:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.4
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bCocoXKjrQW4
	for <virtualization@lists.linux-foundation.org>;
	Tue, 13 Feb 2024 09:42:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B881740993
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=suse.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B881740993
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=R5AyAvv4;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sf5YPaxl;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=R5AyAvv4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sf5YPaxl
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B881740993
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 09:42:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A930D1FC31;
	Tue, 13 Feb 2024 09:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707817347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CHR+1FK75Z10rkFlZFkahLAXLVcDrP2VELt6AP2FjvI=;
	b=R5AyAvv4fxRWYJ3hF+ZP6VZflLmX2nvtzWuULqlH7lgp6M6GL+KB07vKPT7pehbFgx3S05
	Sr3hU7FO0XuE9Bd4MX/Esdq3cNUcpOmeu55zFVy1LvOzgtNxqfNmwNb991LL8oJqU/DFZb
	AeNVnRB3hwXyaoXBKtHVlkFnmB8CEAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707817347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CHR+1FK75Z10rkFlZFkahLAXLVcDrP2VELt6AP2FjvI=;
	b=sf5YPaxle8U8X2UoeTPZMWk5GSmXfZUZRxFqnDb0WALPt3FopF46fu+sUPUaVoM2vbWjve
	l83uzGhMJuur/1Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707817347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CHR+1FK75Z10rkFlZFkahLAXLVcDrP2VELt6AP2FjvI=;
	b=R5AyAvv4fxRWYJ3hF+ZP6VZflLmX2nvtzWuULqlH7lgp6M6GL+KB07vKPT7pehbFgx3S05
	Sr3hU7FO0XuE9Bd4MX/Esdq3cNUcpOmeu55zFVy1LvOzgtNxqfNmwNb991LL8oJqU/DFZb
	AeNVnRB3hwXyaoXBKtHVlkFnmB8CEAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707817347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CHR+1FK75Z10rkFlZFkahLAXLVcDrP2VELt6AP2FjvI=;
	b=sf5YPaxle8U8X2UoeTPZMWk5GSmXfZUZRxFqnDb0WALPt3FopF46fu+sUPUaVoM2vbWjve
	l83uzGhMJuur/1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 515F61370C;
	Tue, 13 Feb 2024 09:42:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oKJgEoM5y2ULXQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Feb 2024 09:42:27 +0000
Date: Tue, 13 Feb 2024 10:42:26 +0100
Message-ID: <871q9gk8e5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>,
	jasowang@redhat.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op(): Uninitialized variables" warning.
In-Reply-To: <20240213040658-mutt-send-email-mst@kernel.org>
References: <20240213085131.503569-1-aiswarya.cyriac@opensynergy.com>
	<875xyska8v.wl-tiwai@suse.de>
	<20240213040658-mutt-send-email-mst@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.52 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-2.72)[98.79%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TAGGED_RCPT(0.00)[coverity-bot];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

On Tue, 13 Feb 2024 10:07:35 +0100,
Michael S. Tsirkin wrote:
> 
> On Tue, Feb 13, 2024 at 10:02:24AM +0100, Takashi Iwai wrote:
> > On Tue, 13 Feb 2024 09:51:30 +0100,
> > Aiswarya Cyriac wrote:
> > > 
> > > Fix the following warning when building virtio_snd driver.
> > > 
> > > "
> > > *** CID 1583619:  Uninitialized variables  (UNINIT)
> > > sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> > > 288
> > > 289         break;
> > > 290       }
> > > 291
> > > 292       kfree(tlv);
> > > 293
> > > vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> > > vvv     Using uninitialized value "rc".
> > > 294       return rc;
> > > 295     }
> > > 296
> > > 297     /**
> > > 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> > > 299      * @snd: VirtIO sound device.
> > > "
> > > 
> > > Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> > > Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> > > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > > Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> > > Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")
> > 
> > Thanks, applied.
> > 
> > 
> > Takashi
> 
> Why did you apply it directly? The patch isn't great IMHO.
> Why not give people a couple of days to review?

Sure, we can wait.  I applied it quickly just since it's an obvious
fix and you haven't responded to the original patch over a month.


thanks,

Takashi
