Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE41D1397
	for <virtualization@lists.linux.dev>; Sat, 29 Aug 2026 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787966473; cv=none; b=Ge9N/CUGx3kGVP86UcUwAIqDt/8im95wv8n3eurRG0F4ZyYVDoDfgEIaL/0l5JXCLbJHUWUjvEHDMWfPpsBPkQRZxmAnDA8CVa4flYn8KATC6phQ5/Q2fAS8mB5xoPtYbJJ1HoH/EKWCZ1njNWwgpk5zmulRNA95pZDBJ0z4EEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787966473; c=relaxed/simple;
	bh=OJ9a9yD6x69uvnPZzsHt9+ANutS0AnVAv5/VBNOSt4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mdPm2jQIxu+IOQ5aZTVb8p+cogMYxeVWSenjwxCRfW/pfIzk8kZiJV6IfcgoCxMxNWSGfvg3AG6Tq1ORgVPDTpu8caC3oIR+eTslQegnombhR83/NW2zZ5/8ALQAcsD0NSfNrIqI4ESFphw3yv1/Kx7Nzwaef7EXKalafVu1sH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+oenmyK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+oenmyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79FD1F000E9;
	Sat, 29 Aug 2026 01:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787966472;
	bh=Qx+o9xEy1b8SNCIdKeaKH0G8YowKOtRy9xGOn3g+BEU=;
	h=From:To:Cc:Subject:Date;
	b=Q+oenmyKGWIW9ElqfAV8eW0YhBKnclr3WufSrH88zQ3xgy4JvgQDYesEPgySlvnzh
	 6C02jzWwL6Ce8kTnf5gr5wkHMAjb2EiDhAe/hM2jr+zHDVoBoK52gZNKKSbnIyOM/C
	 73/lB19Y9xnGXl6tHvg+GTjM7KFCL7o2U7Ctnh1WlXezKor9xNF2B+b4qt3yUhe5Ts
	 /eU/0lmAzHfDJ8KVg+2IYF0OOKkBEhKQSiMFuDFfqDpdABKVVIFNk8D5jKtU3p9R6j
	 bQmk7oxiKZrnh5Gf6xbJTPHj57V5KKlS9niEQa8yZsXwZHZ8bi+k0yupX2200T0d9p
	 CuPAsa94rVrWw==
From: Geliang Tang <geliang@kernel.org>
To: Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	virtualization@lists.linux.dev
Subject: [PATCH] virtio_console: pass gfp flag through in alloc_buf()
Date: Sat, 29 Aug 2026 09:20:39 +0800
Message-ID: <e084d7ed4c03020da3de5cbe1eb3a0c2055cbbd6.1787966331.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The `gfp` parameter of alloc_buf() has been dead code since the
function was introduced. The underlying allocation was always
hardcoded to GFP_KERNEL - first via kmalloc(..., GFP_KERNEL), then
via kmalloc_flex(*buf, sg, pages, GFP_KERNEL), and most recently
via kmalloc_flex(*buf, sg, pages) which defaults to GFP_KERNEL.

This causes a "sleeping function called from invalid context" BUG
when the hvc console flush path calls put_chars() with IRQs
disabled:

  BUG: sleeping function called from invalid context at \
       include/linux/sched/mm.h:322
  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 416, \
	       name: test_progs
  ...
  Call Trace:
   __kmalloc_noprof+0x468/0x7c0
   alloc_buf.isra.0+0x42/0x260
   put_chars+0x1e5/0x2f0
   hvc_console_print+0x29d/0x6e0
   console_emit_next_record+0x21d/0x480
   console_flush_one_record+0x431/0x6a0
   console_unlock+0xda/0x1c0
   vprintk_emit+0x300/0x350

put_chars() correctly passes GFP_ATOMIC, but alloc_buf() silently
discards it and allocates with GFP_KERNEL, which may sleep.

Pass the caller-supplied gfp flag through to kmalloc_flex() so
that atomic callers get atomic allocations.

Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/char/virtio_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 62eecfa61646..7f6cbe851d1e 100644
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
 
-- 
2.53.0

