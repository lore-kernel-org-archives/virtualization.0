Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682E815E96
	for <virtualization@lists.linux.dev>; Tue, 25 Mar 2025 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923251; cv=none; b=c8+wYP6D1gTeEg3z1ql6c4oQaGTbgFaKzZvmubmOijLqwmtQBamBxd6Z+0usWF7wEz/2Ys2EUHZri3d8CUaw8mG7GSQA6eJWir4YYgz0LptkTxaFLDXH899Y2AcUVoYmll2ji8Zhvlt+xhgCbbOjtoCDJxCwHQu0F5mZzRbLXEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923251; c=relaxed/simple;
	bh=Wws4LjmTc9B1O9BxJT9fmDVrnDzw4nn0cqYHWAHQxVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUjS+S5IeZleGmJaC4oe9mrtAinz5KFOL6Ll06us5S/svCx1gXBbZv8hP7EvzFeQWnlCbASTw6M2gooewk+OnHuviqJ6J7iLgNsyujc59Nn7MeYn3h/jTkbEXPOwE8th2q5u7hplSgEs+h6Ib2bCmYy7+c1ATBmhPQLEoUdq2io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K/zUfGJZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cERb1X96; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K/zUfGJZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cERb1X96; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K/zUfGJZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cERb1X96";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K/zUfGJZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cERb1X96"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3936E21197;
	Tue, 25 Mar 2025 17:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742923242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94+Hm3zQsjU5rvfPJl6l6h8vvqdpKhGRnLCm3EDKDUw=;
	b=K/zUfGJZuATqezCKRJKryWWxl9zsIHjvsNbyO0AWe7DHI2sMBu6EyXtXcR6ZCXvF744S9G
	lD95HXNaOjvz+TDN3IrNSiUvMoW/e4e8B87QduPxNLR3KgtJirpWUq1GhtI0C70r08ZthQ
	nGlSq2gtiDn2zm7LUymt7V+Mei5uJXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742923242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94+Hm3zQsjU5rvfPJl6l6h8vvqdpKhGRnLCm3EDKDUw=;
	b=cERb1X961vbCvnajT2ntQx1lEOO8p9bBZRc6nGEFsikgc6TcCSmN8l5vPb210QSWm9RMXH
	MA6slY0EF3BwWCAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742923242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94+Hm3zQsjU5rvfPJl6l6h8vvqdpKhGRnLCm3EDKDUw=;
	b=K/zUfGJZuATqezCKRJKryWWxl9zsIHjvsNbyO0AWe7DHI2sMBu6EyXtXcR6ZCXvF744S9G
	lD95HXNaOjvz+TDN3IrNSiUvMoW/e4e8B87QduPxNLR3KgtJirpWUq1GhtI0C70r08ZthQ
	nGlSq2gtiDn2zm7LUymt7V+Mei5uJXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742923242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94+Hm3zQsjU5rvfPJl6l6h8vvqdpKhGRnLCm3EDKDUw=;
	b=cERb1X961vbCvnajT2ntQx1lEOO8p9bBZRc6nGEFsikgc6TcCSmN8l5vPb210QSWm9RMXH
	MA6slY0EF3BwWCAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECB2D13A41;
	Tue, 25 Mar 2025 17:20:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eD1YOOnl4mfzWAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 25 Mar 2025 17:20:41 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kraxel@redhat.com,
	airlied@redhat.com
Cc: virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Adam Jackson <ajax@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] drm/cirrus-qemu: Fix pitch programming
Date: Tue, 25 Mar 2025 18:12:49 +0100
Message-ID: <20250325171716.154097-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325171716.154097-1-tzimmermann@suse.de>
References: <20250325171716.154097-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Do not set CR1B[6] when programming the pitch. The bit effects VGA
text mode and is not interpreted by qemu. [1] It has no affect on
the scanline pitch.

The scanline bit that is set into CR1B[6] belongs into CR13[7], which
the driver sets up correctly.

This bug goes back to the driver's initial commit.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://gitlab.com/qemu-project/qemu/-/blob/stable-9.2/hw/display/cirrus_vga.c?ref_type=heads#L1112 # 1
Fixes: f9aa76a85248 ("drm/kms: driver for virtual cirrus under qemu")
Cc: Adam Jackson <ajax@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: <stable@vger.kernel.org> # v3.5+
---
 drivers/gpu/drm/tiny/cirrus-qemu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/cirrus-qemu.c b/drivers/gpu/drm/tiny/cirrus-qemu.c
index 52ec1e4ea9e5..a00d3b7ded6c 100644
--- a/drivers/gpu/drm/tiny/cirrus-qemu.c
+++ b/drivers/gpu/drm/tiny/cirrus-qemu.c
@@ -318,7 +318,6 @@ static void cirrus_pitch_set(struct cirrus_device *cirrus, unsigned int pitch)
 	/* Enable extended blanking and pitch bits, and enable full memory */
 	cr1b = 0x22;
 	cr1b |= (pitch >> 7) & 0x10;
-	cr1b |= (pitch >> 6) & 0x40;
 	wreg_crt(cirrus, 0x1b, cr1b);
 
 	cirrus_set_start_address(cirrus, 0);
-- 
2.48.1

