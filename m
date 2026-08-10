Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF142641B;
	Mon, 10 Aug 2026 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380023; cv=none; b=sHhZF4a7j6yDQUWSzZdtw9zD4yQC3XkCdDw++HFT9emevS985Vy+/jM7QYdF7NIZZdqbOc7ylj20GtvF4suAoGAs6aVtqYpG0khWwA7F21iQmlX+2QxMv1daj/Hao0FySI96uyiOpDlD0ekZkJ2qke1j6sYC3h+x0n6A8RxujhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380023; c=relaxed/simple;
	bh=AQ1oun/6qosgKY6n4kYQLUjA92UVpoAqVkAfGokSIqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Zf2JpsfBLXqSXocP3LZy9WP7wR/EvEqjOxMkOzNqM2RpqQBzBghW5BkikeWIsnJ94ktmJA9WMjx6T4YhU0LsVljsu5ahoDj6u1qXFACzm30OUrPuTrXrmhz1JM/u8sH7BZbFpDmxDJd7gE1B5MsBZxMRWTzaZ087dia71LzLkNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=hBmi4cV9; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="hBmi4cV9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=FcdtcF+yPR4yRlsq2nKgHkbYHOu0vQYWCUN4KSaMCnA=; b=hBmi4cV9FnYTDqsdNoINoYkL3p
	wbHy4FbLYGmGDvbKvjlxlH6A0us53PpJxwVotTY3EiecUZHOc/vqlKP056camhdoKfqkDYDMfdRrj
	tUZrW8B+6IDJHUvC/JnkWXCxnHF2zIJsE6PhDcOTeAlhuAI7221e7tilaviRKjr3Tm/RPRrTvyq2D
	ElZ0Ifzm5WdxlI/MglUqL7/CwtaT36GHk/xgu8fvEAONkBTK541uiKptSh02uX6Xhs7BDsvLxpKZc
	49qSY+W2pPvtBlRuSqsZ7tE4hFubLKxSLNL8D49KCHIKhTUd+9NnOqETZY0NAPXO+hO2W66975Tz8
	rYiR9Wlw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtT2s-002vPa-1m;
	Mon, 10 Aug 2026 16:40:15 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 10 Aug 2026 09:40:00 -0700
Subject: [PATCH] virtio_console: allocate the port_buffer with the caller's
 gfp
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-serial-v1-1-abbe51602c13@debian.org>
X-B4-Tracking: v=1; b=H4sIAN/+eWoC/x3MQQqAIBAF0KsMf50wCkV6lWhRNtVAWChEEN09a
 v94N4pklYJAN7KcWnRPCGQrQlyHtIjRCYHg2DXcWjafHzYz+dHVXqK3zKgIR5ZZrz/q+ud5AVY
 7/v1YAAAA
X-Change-ID: 20260810-serial-d9b259ec9100
To: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sungho Bae <baver.bae@lge.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=2002; i=leitao@debian.org;
 h=from:subject:message-id; bh=AQ1oun/6qosgKY6n4kYQLUjA92UVpoAqVkAfGokSIqc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqef7pRmv7V6/qdwMuQXlRm+LfqYlS63tgEHil4
 /kV9h3GGoyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCann+6QAKCRA1o5Of/Hh3
 bZGMD/9hwPBteGx/tTogR1lDDfAUgSgkRWUgpZGhOxRimIVe7IPRcstJIBxoJslP0btmbEr8PZx
 UQ4SiiByq8Tp0h3TyyE6XyLFdrcUrBs+Df0XkaHdGFuiAQegjBBu1+cK1/AU4ZWE/2citItqW7k
 yw0U8Xn8vqtv/12W744V5d4ANvbkKwtBLdebP57dRvLv6lcFXd4Q1WDIfVhhUFh9kJRHe3FRrP7
 G58qRcIzsT2QLjXaTPoleJVN6snQ9ew8KjwdiMXjoeWOFWHYi6rIzcGfx3ZRxvSJH3yZRPXFBlJ
 paZqkXnTxr762QYK1JQVCCCIH8T0Zy3kzWT+79/l987Gj3gt4M2U/rNyrUe7w87YsYKc+3CEb3w
 b4WJxaVyG1oyAMcrKwwd9UDF3UAlpr6UjhQseXvRpY5Txg9HRKILc+TxYY8+2MzmAajpt2NcdcX
 qky48N7E5Zi8WlsNkblanDKzHlEG68trMMzO6bk2WU1OprkirrfPJ+mx70MjSvnh+Vd8ih32yob
 4pZ7wE/nzdAffAvFUomuWcO5NNwjARZnuaxmExzL+SMSY8ILj7cto4HlzNEQbXKOYU12m7BrU4f
 Sk0e69RoGy4pQZZw0tIvgDdXfZGlUe88DL5QC+LNzDcV17nXTS8oVDKzXlCuYvavJgU8ULD+jJS
 7teqooD80YzDgDQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

put_chars() runs from the hvc console write path with preemption
disabled, so it asks alloc_buf() for GFP_ATOMIC. Only the data buffer
gets it: the struct port_buffer itself keeps the GFP_KERNEL default, so
the allocation can enter direct reclaim and sleep. A write to /dev/kmsg
on a CONFIG_DEBUG_ATOMIC_SLEEP kernel splats:

  BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:320
  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: virtme-ng-init
  preempt_count: 1, expected: 0
  Preemption disabled at:
  [<ffffffff813fd90d>] vprintk_emit+0x17d/0x510
  Call Trace:
   <TASK>
   dump_stack_lvl+0x69/0xa0
   __might_resched+0x37a/0x4d0
   __kmalloc_cache_noprof+0x94/0x5f0
   put_chars+0x209/0x3e0
   hvc_console_print+0x234/0x640
   console_flush_all+0x4fc/0x950
   console_unlock+0xbf/0x1b0
   vprintk_emit+0x312/0x510
   devkmsg_emit+0xba/0x110
   devkmsg_write+0x21b/0x2e0
   vfs_write+0x4dc/0x9d0
   ksys_write+0x108/0x1e0
   do_syscall_64+0xfa/0x460
   </TASK>

Pass gfp on to that allocation too.

Fixes: fc220d6be3c7 ("virtio_console: refactor __send_to_port() buffer ownership")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/char/virtio_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 62eecfa61646d..7f6cbe851d1e1 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -426,7 +426,7 @@ static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size
 	 * Allocate buffer and the sg list. The sg list array is allocated
 	 * directly after the port_buffer struct.
 	 */
-	buf = kmalloc_flex(*buf, sg, pages);
+	buf = kmalloc_flex(*buf, sg, pages, gfp);
 	if (!buf)
 		goto fail;
 

---
base-commit: 6b8c8af514d739d0335f5579b585e02babe8a727
change-id: 20260810-serial-d9b259ec9100

Best regards,
--  
Breno Leitao <leitao@debian.org>

