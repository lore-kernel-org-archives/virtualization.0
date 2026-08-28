Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6D7284690;
	Fri, 28 Aug 2026 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931435; cv=none; b=k33w/Q+dc7Efvvi5uzF2aeTZ/AR34XP8xJK+cIa19w3EyXEhcZYVz+aj3SG4oN4rmXz+XhbiQhegdU/mFluqisP1fFKQ/89YnaRjitw1fS0R7afyhGUnBlfPXoQF+OyQG7q4y5iR6zj3ME6PRwOCWOKEfdPnTUmZxvrvx8a22i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931435; c=relaxed/simple;
	bh=udfT/ojpl2mht7ovO3rcfbzfN95Avkhq4CWpcBXSOMw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rQl0bIdWXNclsPXfDsQ+q6ryGcRVju0Zi+kiX8AJ8HmlVkWwAISk2o/e7IfFyA+vLUtLu9NfMErUWpd3FDhA7Cm2DPZZRSmFaomECZzbLZQZBCCpAm7xE/WPxU/YGbM0cGGZMNMvvrTuGmgcHmyuKQHngy2zY0WSMjzvp+WPvwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WSYaSW4s; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WSYaSW4s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=blBHvWHSaNvmEzZ+j864Db5PT0IufbE1dnc2cdL2DYc=; b=WSYaSW4s++prj1OqVSxAI0tlfy
	pSaadey8oPIYFWfugO8YY/DKnzcJxXQrP2k2K2y7JYTHJAFezJGFC+NaWd4k6DjsqGWBWHu8yeosl
	66i40Aks+vCwulWp3DvSe02Mul10v98Ofi0eqNqMwoqYl7ZOOe4JTFMkYlpu+0+lti1UKJdAvAXFT
	rw2g7qnZpRUMtTegZ9ZMjA/k3r7Ag+scgNU04t+Yhi/12NOEfyKxWWrSjC9Kh26ioP1HF2qrU+Du1
	qGw+65x7XgEQMdVpdUij6GqQAQXmEoOB2SdUXjkA1apauMHxMQU25CR3bfekw0bZVOXEePrms7XT7
	XqKp/AkA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzydf-0000000EuCa-2aMp;
	Fri, 28 Aug 2026 15:37:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 77D6030116A; Fri, 28 Aug 2026 17:37:06 +0200 (CEST)
Date: Fri, 28 Aug 2026 17:37:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, Sungho Bae <baver.bae@lge.com>
Subject: [PATCH] virtio_console: Fix alloc_buf(.gfp) usage
Message-ID: <20260828153706.GR687043@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Commit fc220d6be3c7 ("virtio_console: refactor __send_to_port() buffer
ownership") added a .gfp argument to alloc_buf(), but forgot to convert
all allocation calls.

The result is that any GFP_ATOMIC calls, such as those from:

  hvc_console_print()
    put_chars()
      alloc_buf(.gfp = GFP_ATOMIC)

will trip the might_sleep_if() check when used from an atomic context.

Fixes: fc220d6be3c7 ("virtio_console: refactor __send_to_port() buffer
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

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
 
