Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2B5206518
	for <virtualization@lists.linux.dev>; Tue, 29 Oct 2024 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212779; cv=none; b=RqNDbvGgcxInQlIC/Q/kqFx1bjtgvmdcymiOuiWYHbNFP/v0rG7xZpaz+jSxyaOPUT8vTqLkf6qan2nNwJiGQXSz2TGZ/X647eZ8uJjGdrG2zY4j7wdjgHL1hbU4WKPs9T6kM75YSsg54HKsVn48DXkBmXnF8Rr+zaYOLEi3Vv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212779; c=relaxed/simple;
	bh=gKvCOqhfqQO5eoJiucugtWbefgBfoDV8crbfrT35tq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZP7RZDDT4KE5JBiLznppb0+ROdiCIE978bR3fTU4OCnNO96F5qsW3L6y8VFTE31MptjelRrhrwEZm0ZB7cCWHp0S+3Wgz/1OJg93UT82nX4ZB9mj37YizwMQFf6AQj86U6CWcyvHZJkq1EVuf1LzwrL9ShOMWn9Jwdiaf/wK3V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SW5/0NR9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+MRDRhQ1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SW5/0NR9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+MRDRhQ1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SW5/0NR9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+MRDRhQ1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SW5/0NR9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+MRDRhQ1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA4A81FDAC;
	Tue, 29 Oct 2024 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730212775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kO5OdcPd5vo7GJYBvTe0oOys9AQrz5F3ZBFhzz1RkjQ=;
	b=SW5/0NR9NH4m0SiEoB4USMTGfqd7oMxK+xbt3eif6ncxUTS40UU7kuk2VaZZk9ibspM1AD
	PJyNywlH6RmXbHxc2sRO3VtR+pAdtf5whKCpXVlU51teGR6atY7KNuyucH2doGj0bCKk8D
	kqPQPOIAKdu7RqVqWaIIRQFHEQl58f8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730212775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kO5OdcPd5vo7GJYBvTe0oOys9AQrz5F3ZBFhzz1RkjQ=;
	b=+MRDRhQ10G7sCiviJfXtIGWRY6INHPK4boqVvcpDm9M7WPr1WSEq1F1VRcVMaCNnehv60h
	fnpo1WhzlT8qACDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730212775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kO5OdcPd5vo7GJYBvTe0oOys9AQrz5F3ZBFhzz1RkjQ=;
	b=SW5/0NR9NH4m0SiEoB4USMTGfqd7oMxK+xbt3eif6ncxUTS40UU7kuk2VaZZk9ibspM1AD
	PJyNywlH6RmXbHxc2sRO3VtR+pAdtf5whKCpXVlU51teGR6atY7KNuyucH2doGj0bCKk8D
	kqPQPOIAKdu7RqVqWaIIRQFHEQl58f8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730212775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kO5OdcPd5vo7GJYBvTe0oOys9AQrz5F3ZBFhzz1RkjQ=;
	b=+MRDRhQ10G7sCiviJfXtIGWRY6INHPK4boqVvcpDm9M7WPr1WSEq1F1VRcVMaCNnehv60h
	fnpo1WhzlT8qACDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 753E9136A5;
	Tue, 29 Oct 2024 14:39:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KdhaG6fzIGd/AwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 29 Oct 2024 14:39:35 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com,
	kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/2] drm/cirrus: Don't pretend to operate hardware
Date: Tue, 29 Oct 2024 15:34:22 +0100
Message-ID: <20241029143928.208349-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The cirrus driver is only for qemu's emulation of that hardware. The
two patches in this series update cirrus to reflect this.

(The driver is still obsolete. Use something else if possible.)

Thomas Zimmermann (2):
  drm/cirrus: Use virtual encoder and connector types
  drm/cirrus: Rename to cirrus-qemu

 MAINTAINERS                                      | 2 +-
 drivers/gpu/drm/tiny/Makefile                    | 2 +-
 drivers/gpu/drm/tiny/{cirrus.c => cirrus-qemu.c} | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename drivers/gpu/drm/tiny/{cirrus.c => cirrus-qemu.c} (99%)

-- 
2.46.0

