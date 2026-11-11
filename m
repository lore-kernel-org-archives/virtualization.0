Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355606;
	b=O5GnbKsa/kXzk/FiUBp5uTtj5w9oeaPL+5XSnYtqLE6RUqZlc8PLHx4MAbPA3vDW4CEn
	 w6bONXQ2Zj8GWWikU/qLmwrYUHNE70Cv0zoYGRbPu4IS/GXWbM9skKndg19dMkRjOlaF0
	 DK+f3Dh4/kDUkwrMp5AtrP8nDzrO7rbcq9OML3nSHNyS3yvnFihCvDsjiPlpHC6RPt+x9
	 AM04qurN47MfR2o2AY2sZ3WchMPllc3upeV6MuJ/WR5wlVOElZEWHGkIBc/EmpnEeSELk
	 xJ7F7S277W7M8mK+TVKSnvhLh10Yxx+FA2h9uPZg9Lt/6jkRb8uaieI3Qa3wWKquauA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QVooZCmJPrWWhT96Ks8ytGn0KExMeex3eOhOngE0EKo=;
	b=mQK3ZFjo9Zk/aI5bhFpMPyL90uM6ehVCMid0s3CGnD23Nb8pn40V3S6xMbfIzYMFOTP6
	 Wga0kKEx8s7itycygWcY7oc8/isH9MZVllWm9K1DbpmtZHwmqixHPY85sFNj+/L2MvPDC
	 D2XZfLozRzveN0gjrjG1d8CJAkkpBks/iW7zJX1vpIbZam7CXncQhijg5n355B8pcu8/H
	 xU7bM5FjubfH3VqMhu+APT51QO0RGOOxlS52tsaDXMe808ZzcdNRwF1+cRtEx9PBv6V6C
	 xn88rT32tooJZSW2r/kwd1iYlCgPQjBNX9L00zQwpI5K4E7mIKlPyyfBP/BVWJ4GBhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qmAmdZSP;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E58D606A33A
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E58D606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qmAmdZSP
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso1544937a91.2
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 16:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794355605; x=1794960405; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QVooZCmJPrWWhT96Ks8ytGn0KExMeex3eOhOngE0EKo=;
        b=qmAmdZSPGjOVjmdFoU3mtNTP5Y7r7uD4zAYBQe2FmLM5pHRpAz4GDpMs5M8zdIhgJc
         DGT5QIhtl1XmnBO7bmLVQ7OWlKtZ+xSYNsnfXlO98iwl3c5ULF2c/jx8o6rHa+fKV+0I
         XQEKSUcSV673HfN1gfqKsDD98s7qpZ4IbQYcAH9/vBQ6egO10razh47k5bKblE6abZ50
         dsIGo3TPMZVUxx1ldxM3dfwbA1iRaAVD5dj1H215wAYM1k0aoYtTbcpwFXGP+Pl9C1ur
         JM2UxPTWnO3tXTEsNNljKnz6j7gy6hnpn4bZO5/ct6Qhiz1jFqLjwFW8xmkr2IxwDp3V
         FUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355605; x=1794960405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QVooZCmJPrWWhT96Ks8ytGn0KExMeex3eOhOngE0EKo=;
        b=MrP9SzRauCvyHDFcDerNQQ4sI2WtCt4L4KayFQ8GdudGQd5YKj5tiJ4n4Y5iNG+6/r
         xKov/XAGgec9i3ifszBfj5xJ0CT6EHL8xN//SDxRr7HmYP3plYFvIeqH5siDX5iB7M46
         6sDhJ/EY+ojimOMZUgy65iupO4SMChK01scqqlr+sOMqmD4Qr3rgMAXIcPp/Wyvup37k
         dghELJeSWyxEP68oJoHu9/zZOrUVH8k8w5nF3i5asks+/ArjwMsq0Pju6RMJRkYxDRhc
         yO5zqvF0o63kCZxDmiMsWQmFi6o1fQl2buZg099dki9SSRnwQtIJwVRXbnPmriAnXDsD
         LdTA==
X-Forwarded-Encrypted: i=1; AL+hErEsAljWCJrR1vne1tnSsSFB8DSP3gU1sLje3EcmNXG4bL7sdKY5Te7St8HKTHbeAQ1u1w8sl8J9h+aPdo8b9Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z9llwvUj5VawDXkRgJvPgjXghnxE1swppwYVlPb21UsGHyGk9gO
	4p1XnY0YD5pm9rArclQ6PWUhpN3T8hWhjxzeWRhl0HzMKKEnM+LlQq82
X-Gm-Gg: AYBFou0o5lFIMAk1AeilDbvtYeNanhnmtKK6GAxDchJ7MJVRnoc2Yams6UQDGSO2UWW
	p/nYE09P/wHbHOCIUKlFWVllZ54LFjsyu7ZxjQJ7ijZr7q4wRjycrNUmkXscKm1yM9woL5Vqsxq
	F3xQ2xW+h8e4cG+R+lrNIFefDEwpSMYktxwLhLesSDFhQi+vv/ebPbYwonh1NJpMSa8mAsCcbMk
	H6pU3AcYZb4jfL6ssUfj2r7UcaDFmQ5kk9nSvgFjiSKZTcH4IpIaoQ9SExss1uK9tMZoAipEM8U
	CpC0WWKVxhQO66W9vMmrx9sSHVc5Su39jtJX5DCPmRBytIGL7FkrkO7ARR9ZmXG0OuNYwaBYBgy
	skCwRew0ulCjNpjlFN/VakvKFC9kssnXelbY/GTt4vVwqPYFSmGTLqQ8ZaF/MBn5cMtY1aPgs2V
	yPlEWBA5V/hV5P3xu1rc9E6xaf/61odtAe17mAvWTXjrVJqueEiADA7w0mY8sjReYECDUROREok
	qeodZteOWXquZd3vKH48le8caIzCV2GfrpMfX3pU6XmC5CqVs+zuuEfFKP91iHik5qS6pMBKJqs
	lbwSscpopDxOwKhJ9gno/uX+VSUQIuWTlI0xL73KwYo1LYQbV4RZZURg0M5RyyN5BA2WQ/rgYQX
	eOrOcgVgebmGQhZGu5Ykur13T1qA7LI8vBPbMeeqBuwpJwvM=
X-Received: by 2002:a17:90b:224e:b0:3a4:f75d:d194 with SMTP id 98e67ed59e1d1-3b182ec22a1mr635276a91.36.1794355604794;
        Tue, 10 Nov 2026 16:06:44 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1838e616dsm474361a91.4.2026.11.10.16.06.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 16:06:43 -0800 (PST)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH v24 14/16] docs: describe virtio-sound capture options
Date: Wed, 11 Nov 2026 09:05:41 +0900
Message-ID: <20261111000543.28550-15-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111000543.28550-1-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the request-owned default capture path, its temporary memory
and copy cost, and the two remaining default-off compatibility
parameters. Remove the earlier opt-in staging and short/empty-response
descriptions.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
Documentation/admin-guide/kernel-parameters.txt |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8344,6 +8344,29 @@
 
 			Can be used multiple times for multiple devices.
 
+	virtio_snd.capture_packed_status= [HW,ALSA]
+			Read an explicitly enabled packed status trailer after
+			the returned capture data. The fixed status scatterlist is
+			used by default.
+			Format: <bool>
+			Default: false.
+
+	virtio_snd.capture_pause_restart= [HW,ALSA]
+			Stop and release the stream when pausing capture. On
+			resume, send SET_PARAMS, PREPARE, and START. With this
+			option disabled, pause uses STOP and START while retaining
+			the prepared stream.
+			Format: <bool>
+			Default: false.
+
+			Capture always receives into request-owned buffers, then
+			appends validated, frame-aligned audio to the ALSA ring in
+			request order. A valid short response is retained. Empty
+			responses are tolerated only during bounded startup or for
+			requests already in flight at STOP or PAUSE. This uses up
+			to one PCM buffer of temporary memory and copies returned
+			audio into the ALSA ring.
+
 	vga=		[BOOT,X86-32] Select a particular video mode
 			See Documentation/arch/x86/boot.rst and
 			Documentation/admin-guide/svga.rst.
