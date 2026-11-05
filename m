Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891396;
	b=yy9UoT5OpA/36xr0KVKtteLpo6QY1bJHY8RkDAPa2Vltn6pEfkEeJ1KRIC8uaY4RPVPd
	 /vxLr7Gj8meBCXDGjMGMiOAXrKbRwWpKgrIlwnvkr13tciNoQk//UyfpeF59tSqhC1m5B
	 JMuritWiyvsbtEZTdGu9Md/CMFTRuYN1cUtLneSpjDbfvIEGaUgkETfqyn2VCb+gCyMQG
	 SHmvlb1o4U2H6MZcPkXmjcBcRDC82Fs4Cc/SIQyEKrzRukqWzKo2A7cDczXZNpG6XugMz
	 h8gKGpmYjs8vISOrDDPikqesGocD6E5I7IX1LQfvrTAd2oXEg5ly+YQZrk6lDu1t1jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891396;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=KphLnH6Y7Gp74AYUkx+0gciVD76K0BIzunIfeqpjC3k=;
	b=B888IYIjoUxnSrTf1y4U83VfcpWjUDRJf7gf0WTK7XTT0Abur0q4ajxLLBkMyqHty2i0
	 fDdGBajXjXZ6/Z/qvqfpG+bQ+YJ7LZkOKC1GYBgsGYKKU7ni0WL+Teg/Ff33YsuVlTErV
	 i9g1sVBHztBFgFfMRMrgYKvS2QDskDtUsSr2jRQ9u3WA//XgSIX9D3RXJi3iMMJO992lH
	 C3kqWqlV8QxbAetyI92JBtFTNMGOKFY0SOHzDajvA5yTvqbj8B1IMJmXoME4oktt7KhWE
	 eJwAYjF1pI0fMsY8s9ajIxvI08yzzSewdXflWgZcVMJTHUkQWD/+HE00pRGZcthCIiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IhLmgn6z;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7FD606D815
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 15:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB7FD606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IhLmgn6z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793891394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KphLnH6Y7Gp74AYUkx+0gciVD76K0BIzunIfeqpjC3k=;
	b=IhLmgn6z2wxg3f+EFytsrHGNX7ZYB83YBI5rrU+V1XvJR2soG+/GCHsMKNzUhO3nodTTvd
	1BBvSBF/UGOazGoG8Yqkn5hL3VvagJVpcX9Q5VahElwd5zygHzIPUw2WvRWIaFKW4p0CkJ
	8NP9gccPlFKS6WNvRkN+o6kxE1NaQgE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-MqyShuo4OTaX2lp9unF9UA-1; Thu, 05 Nov 2026 10:09:53 -0500
X-MC-Unique: MqyShuo4OTaX2lp9unF9UA-1
X-Mimecast-MFC-AGG-ID: MqyShuo4OTaX2lp9unF9UA_1793891392
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a20fd059ddso15844975e9.0
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 07:09:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891392; x=1794496192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KphLnH6Y7Gp74AYUkx+0gciVD76K0BIzunIfeqpjC3k=;
        b=X8nDrMWAAZ+56pqwq9r7qu7iaXddnuw/SMovAo9gKVFgX2ydcyLR3Z0RKPi8JkNadD
         PKcMcR8hyddw93fR86/DdzXUfHbeJ9dk9T3COxA46FteUJ+k472hyJ/Vlwz97c2oeiq2
         pJ5SDoHYinlq1amzgeVMxOeGBVDeTbnBL5PYxJbT+TEP5Muxvd86sAHdmNDG37gn4Fzv
         Ow4QFWtNWkPRWbX5MPtx2y6yNXuvhZg8VxAuKIG1Nkf+PK6u4NmIvK+i3RxVuaG1YhZs
         O0Cc5yAYFK9Epo0yEepSiyZ0nRMXns69KmTOIDcAZXLvqfnZhPFE5y3irZgMdmFEREzQ
         tmWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxEO2bqceKtSCR7FTVcVBcafMGgRQNbyF32WrSGsI830Fs2Dk1XS0LhZNxJdngi352ZqK0Sc15qzfmJGuEs1A==@lists.linux.dev
X-Gm-Message-State: APuU4Z/7a6zSsfz5IDcJmy7mM4/cSN/NAtL+2HXZS5XIJEq1PGvGa8Cg
	ui9JLneXhwRZE7Fpc2O/jAluR+0r6FEI7iyvksk130MMcr4RQkWJ29MCWXfVUH/1CCF3hbIoSwX
	nlgII862aUcg7NvE/SzpCZwK4XMS8kKreyVwrR3jNBbCoj0oSgO1AQylK2Rry7LWfZVQI
X-Gm-Gg: AYBFou3qep2+3fgAy34sQNPv4K9luFkKcJDl7Q+9Qkfvfroe02UZqy78RQ0mVkSZl1Y
	Q1tYyFOpf0eYsK1/TsW6bp85LF/aO/mmsPHP7F+vo2Wp1WI/ABV5J0qxbXMmeH1NQQiiwgKN73l
	N8virn0lND2Cm1PVyWQ/aWuaRHzNSOs33eUQ4fmn0OYDYccsJihhpRp7uZAGJFY31L2whWJu+at
	lkw0mDWlGkJgpTS92+cFHMs8CsSQ46R61F04Tpqo8ioedEl8AGbUFWGhYN0Zq4Ah4Yeq3Q0oQeD
	WmRjAYmZYe3iaPDLDVxJbJTd9JYRR7uF9u5B2J7e5MI2gwmdyPOYb9eqP91TR75IGiGYdEkxjUt
	MXt2NVnqkYkScTNOQ2Uh5KmkKFgg7JFj07DfTKBJ+9ebkj3rEYxSbAYT6oQW74eZbyG7NjqGUlb
	7LlOfzKJCWu1quCkcgYMCeeDdvuBYNpqLqsTcO3RsdR70=
X-Received: by 2002:a05:600c:4e02:b0:4a1:e6a9:4086 with SMTP id 5b1f17b1804b1-4ac1228b10amr437949885e9.0.1793891392370;
        Thu, 05 Nov 2026 07:09:52 -0800 (PST)
X-Received: by 2002:a05:600c:4e02:b0:4a1:e6a9:4086 with SMTP id 5b1f17b1804b1-4ac1228b10amr437949535e9.0.1793891391973;
        Thu, 05 Nov 2026 07:09:51 -0800 (PST)
Received: from mszeredi-thinkpadt14gen6.redhat.corp (188-142-154-142.pool.digikabel.hu. [188.142.154.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda207d8sm9961340f8f.52.2026.11.05.07.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:09:50 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev
Cc: German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 3/3] virtiofs: zero the reply region of the argument buffer
Date: Thu,  5 Nov 2026 16:09:42 +0100
Message-ID: <20261105150943.86650-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105150943.86650-1-mszeredi@redhat.com>
References: <20261105150943.86650-1-mszeredi@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 22spp386Mgsti34VN1XFyPZDAiPbfEEImMTCSCdLqyw_1793891392
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

copy_args_to_argbuf() allocates one buffer for the fixed in- and out-args
and fills only the in-arg part.  The remainder is handed to the server as
a device-writable buffer, and the server is under no obligation to write
it: the used length it reports is its own claim and
virtio_fs_verify_response() has nothing to cross-check it against.

A reply that declares its full length without filling the buffer makes
copy_args_from_argbuf() copy the uninitialized remainder to the caller,
so a server that fails partway through writing a reply returns stale heap
contents from e.g. fuse_statfs() or fuse_getxattr() instead of an error.

Commit 5364d081125a ("virtiofs: validate fixed-output response length")
covers the case where the declared length is short.  Zero the reply
region so that the remaining case yields zeroes rather than whatever the
allocator last held.  Only that region is zeroed; the in-arg part is
overwritten by the copy below and the buffer can be as large as
XATTR_SIZE_MAX.

Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-f0d6d4a3-f5df-4f72-ab09-802e5aab49a6
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/virtio_fs.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index c824916f0a9b..cdd6f5c50d6d 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -701,15 +701,16 @@ static int copy_args_to_argbuf(struct fuse_req *req, gfp_t gfp)
 	unsigned int offset = 0;
 	unsigned int num_in;
 	unsigned int num_out;
-	unsigned int len;
+	unsigned int in_len;
+	unsigned int out_len;
 	unsigned int i;
 
 	num_in = args->in_numargs - args->in_pages;
 	num_out = args->out_numargs - args->out_pages;
-	len = fuse_len_args(num_in, (struct fuse_arg *) args->in_args) +
-	      fuse_len_args(num_out, args->out_args);
+	in_len = fuse_len_args(num_in, (struct fuse_arg *) args->in_args);
+	out_len = fuse_len_args(num_out, args->out_args);
 
-	req->argbuf = kmalloc(len, gfp);
+	req->argbuf = kmalloc(in_len + out_len, gfp);
 	if (!req->argbuf)
 		return -ENOMEM;
 
@@ -720,6 +721,14 @@ static int copy_args_to_argbuf(struct fuse_req *req, gfp_t gfp)
 		offset += args->in_args[i].size;
 	}
 
+	/*
+	 * The server is not required to fill the reply region and the length
+	 * it reports in the used ring cannot confirm that it did.  Zero the
+	 * region so that an unwritten reply yields zeroes rather than stale
+	 * heap contents.
+	 */
+	memset(req->argbuf + in_len, 0, out_len);
+
 	return 0;
 }
 
-- 
2.56.0

