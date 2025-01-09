Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0339142E86
	for <virtualization@lists.linux.dev>; Thu,  9 Jan 2025 03:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736395193; cv=none; b=cqwe1FSccF6G708vGcBHJZU8gEWb5WaqEr6Z/FogvW0WNXEJYIb27PXa5CNc1ykdV9n0a3NkF5qAJ+aBHB3pd2dlOoAvchuL90wBGU1CqzocvL0DwnzD1APKKkE1NiD+Q/mJxedlqDGkJ5L8PksX3Q8dlC6fAoyrubhgQkPzDD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736395193; c=relaxed/simple;
	bh=DsRZEezRzRoZYoVb+0O3qLEW5TiNd+7YrIVz/TNmuno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FI1ZorfAtTJGT4O8L4VNG6fBBvwM/21mftOHb8mSuHbLOMqHYKErb8itq6KLtrtbgXP+swxh4rl/rRmxZN+91b05TZS0AZl8PHypnn1KI5I6AHtyMSBjD5ovCX5CkkglZKUMNu12PIJwbBR4rrIMdTUz1WVJIhOY1bQeH2poWg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=U3egZpQD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NCAf/e6+; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="U3egZpQD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NCAf/e6+"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 0177A1140192;
	Wed,  8 Jan 2025 22:59:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 08 Jan 2025 22:59:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1736395190; x=1736481590; bh=iuO+1lEcQ0
	Y2oEv4cKm+6QD3p3rkNrIsEabaaqaECPw=; b=U3egZpQDpVlpxZLTCXbcJJH+6r
	lKUaNZjzjFig0pn6jsw+yMsvUzrTm+qamBi1leW51QVPDMRPZq95fYGttRKeqpTh
	s8vn049fCYL6+YezCDjWTHEP2VpZyJ8BYb0Q4ldI+L5GzX0EcxCWM8yWSr01GotG
	EpKxl252R3ZRgVAuqYavm5hFXDXJofNQqVcZe9z85oy9lmnSBcq1HRYoEAP626dx
	jljWhPAgh7xfiX3ACO0LaNK2UWwiVzesrdJvvsTeAnAUgBHQ9h+qwmBYVXkSdzDg
	VvmHfqQ81IYocANQm821aTssPXlzgC0vAam/vjlAWyfgsS3OlxGiUahvnxKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736395190; x=1736481590; bh=iuO+1lEcQ0Y2oEv4cKm+6QD3p3rkNrIsEab
	aaqaECPw=; b=NCAf/e6+rneSKBhB63ayToYgrRaaaWKw/KqG7QciwFgtqMxYjas
	jGjrSrUGNMcYPA/38a84QtsfbrT7IvT4m9QVco2smKeM/nMNhejUKFD+p+i+SjwT
	9622X1DOQeF2BG5C8px8hXCaTblkM29uvvrd1DBUJD3Xon5+SAHKIyn+xly1dYRh
	cYqapg7/fsGzTctdhD2AYK1rbk+n/OBo4CYEn7buNdOzvgCXuaeDI+B3O0H3qA7m
	l7I21Oi42yhOFDNjQSVcq6zpE3u9w35t6PIT9rAg6GJqSJ54I4NhxpiOfO/gFhSt
	xTSRm83Piet/sxNBx027dcrhfRUMQ6fLxmQ==
X-ME-Sender: <xms:tkl_Z7zLW-Z5VWzxxEOMRajzwz46MaLTfbetnZSXgJTrnEh1kSucKQ>
    <xme:tkl_ZzTDZq9trWf10HiCmE7MJ4cQ-Wjp2kPXe382fryvQZn-nwAB9sRtJbOELBdAk
    _wjBX7bU3gTr-Or70Q>
X-ME-Received: <xmr:tkl_Z1UtcgXHlqwWV_aeTmVFdjTQmAvWH0Rly50wrff-tMs9ZS4aovA2wZe4MxBuxvPM8B8HkKWtdnpyivnMyLSbc5u-iW36SKCabUghees0eF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeghedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomhepffgrvhhiugcutfgvrghvvghruceomhgvsegurghvihgurhgvrghvvghrrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeevjefgueffgfelvdeigfefgfdvtefhuddvheeffeeg
    gfejteelhfegvedvhfefleenucffohhmrghinheplhifnhdrnhgvthdpkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    mhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopegrmhhitheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopehgrhgvghhkhheslhhinh
    hugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehmvgesuggrvhhiughrvggr
    vhgvrhdrtghomhdprhgtphhtthhopehvihhrthhurghlihiirghtihhonheslhhishhtsh
    drlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehirhgrrdifvghinhihsehinhhtvghlrd
    gtohhmpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:tkl_Z1gXl6vQx06KzNMJkFJvFdZaSppHaCaqAkEPGcNz0bwhnhxldA>
    <xmx:tkl_Z9DEsd8aoJjErzAfpdPNftpSsQRJnlRM2Fz18BwJNorVrWXczg>
    <xmx:tkl_Z-JIKkbUl1amHNP34BzFSUOEnmsYYzlPPHwAcG5WkjfKs1CiFQ>
    <xmx:tkl_Z8ClcXw4YWFsGYUQRzf-F7UwqhFr5kXesI4-4K0sZnqs4JxXtw>
    <xmx:tkl_Zx0Vi-ieng_K0CRImVMSZ70z7KKeHQ8QjkHOkEVIztsqS-muBh0t>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 22:59:48 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Reaver <me@davidreaver.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ira Weiny <ira.weiny@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] virtio: console: Replace deprecated kmap_atomic with kmap_local_page
Date: Wed,  8 Jan 2025 19:59:02 -0800
Message-ID: <20250109035904.168345-1-me@davidreaver.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kmap_atomic() is deprecated and should be replaced with kmap_local_page()
[1][2]. kmap_local_page() is faster in kernels with HIGHMEM enabled, can
take page faults, and allows preemption.

According to [2], this replacement is safe as long as the code between
kmap_atomic() and kunmap_atomic() does not implicitly depend on disabling
page faults or preemption. In this patch, the only thing happening between
mapping and unmapping the page is a memcpy, and I don't suspect it depends
on disabling page faults or preemption.

[1] https://lwn.net/Articles/836144/
[2] https://docs.kernel.org/mm/highmem.html#temporary-virtual-mappings

Signed-off-by: David Reaver <me@davidreaver.com>
---
 drivers/char/virtio_console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index c62b208b42f1..24442485e73e 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -883,9 +883,9 @@ static int pipe_to_sg(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
 		if (len + offset > PAGE_SIZE)
 			len = PAGE_SIZE - offset;
 
-		src = kmap_atomic(buf->page);
+		src = kmap_local_page(buf->page);
 		memcpy(page_address(page) + offset, src + buf->offset, len);
-		kunmap_atomic(src);
+		kunmap_local(src);
 
 		sg_set_page(&(sgl->sg[sgl->n]), page, len, offset);
 	}
