Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A531210FE
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814952; cv=none; b=qnw29eEBI+b5tk9XyC4RWbDSdM6XJRJqutYBecHigS/f6ZzMDhpR5tHcPITXD5gPfBz8ouEl9qZ8EDYDCzg2zBfENS1fPUGfQeP8mA+QrkyjYyi5N8V3NlU8rMo+ndugN1hRE9EGxX6S5+hwOxLHNFsYvj7e266v1dFSfxMtKcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814952; c=relaxed/simple;
	bh=Cp2/D//d9oJ6kVI/b4rFwXYX8Q2luVv1b0auxggxWgM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIv+M32+KETS9EYPRbEnLfRLPNiDzw2h+bu1EWKekWneoSX+KRFw6bwj3Z4Hc3SrmG1Cmlm//NMNV7+oVLU3KtzJYFNgpPG1a1xPR6S1vZyIObkWO25nS1Gaqw19mfEZE44HpEVLYdZKP4iTzQ2GmAEp3KHMrWzEljcKts0rKlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DYXo12bp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WmdHBkAl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DYXo12bp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WmdHBkAl; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DYXo12bp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WmdHBkAl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DYXo12bp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WmdHBkAl"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B722F60B03
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 09:02:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.4
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ieqiqepjX8d6
	for <virtualization@lists.linux-foundation.org>;
	Tue, 13 Feb 2024 09:02:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8F5B060A71
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=suse.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F5B060A71
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DYXo12bp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WmdHBkAl;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DYXo12bp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WmdHBkAl
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8F5B060A71
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 09:02:28 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3C2291FC83;
	Tue, 13 Feb 2024 09:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707814945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYByJMWSJENI294WTzqFKlK1zuWI9z4p8HRZjVwVQwE=;
	b=DYXo12bpmrf6RewGH3mEm9iDK2kUEepxWUP9+7ie6zH3Ag1PyIU+JOqHNlmvA1hk3E4wvh
	+A76fmpepWL2M/nw1ffjIA63R7frbeExil5bt5D6Q3GgWL5NqVRhSt7YXhyiGnrM5dOxN3
	4sHBtO0QxT2LP9b0+1T31++DlV25064=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707814945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYByJMWSJENI294WTzqFKlK1zuWI9z4p8HRZjVwVQwE=;
	b=WmdHBkAlJegxhasKOc8cBCWBzTUCIj45So1dcBBx+wZ4j9VnyeG7Sh4uZUvFUTsIESECAk
	v/2L2DCDr4DN2cBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707814945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYByJMWSJENI294WTzqFKlK1zuWI9z4p8HRZjVwVQwE=;
	b=DYXo12bpmrf6RewGH3mEm9iDK2kUEepxWUP9+7ie6zH3Ag1PyIU+JOqHNlmvA1hk3E4wvh
	+A76fmpepWL2M/nw1ffjIA63R7frbeExil5bt5D6Q3GgWL5NqVRhSt7YXhyiGnrM5dOxN3
	4sHBtO0QxT2LP9b0+1T31++DlV25064=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707814945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYByJMWSJENI294WTzqFKlK1zuWI9z4p8HRZjVwVQwE=;
	b=WmdHBkAlJegxhasKOc8cBCWBzTUCIj45So1dcBBx+wZ4j9VnyeG7Sh4uZUvFUTsIESECAk
	v/2L2DCDr4DN2cBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7B4413404;
	Tue, 13 Feb 2024 09:02:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n2pJNyAwy2XtUQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Feb 2024 09:02:24 +0000
Date: Tue, 13 Feb 2024 10:02:24 +0100
Message-ID: <875xyska8v.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
Cc: mst@redhat.com,
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
In-Reply-To: <20240213085131.503569-1-aiswarya.cyriac@opensynergy.com>
References: <20240213085131.503569-1-aiswarya.cyriac@opensynergy.com>
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
X-Spamd-Result: default: False [-0.53 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-2.93)[99.68%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[coverity-bot];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[opensynergy.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

On Tue, 13 Feb 2024 09:51:30 +0100,
Aiswarya Cyriac wrote:
> 
> Fix the following warning when building virtio_snd driver.
> 
> "
> *** CID 1583619:  Uninitialized variables  (UNINIT)
> sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> 288
> 289         break;
> 290       }
> 291
> 292       kfree(tlv);
> 293
> vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> vvv     Using uninitialized value "rc".
> 294       return rc;
> 295     }
> 296
> 297     /**
> 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> 299      * @snd: VirtIO sound device.
> "
> 
> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")

Thanks, applied.


Takashi
