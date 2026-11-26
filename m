Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704449;
	b=TSWzDPHeqz9dFvSungX+uj7BkC6/r2gnTGkKVGCqfbdw1V1/S72DyoxLZexbJjDJtQLc
	 ET68psb97xZbjF9w6N8RQLKqst94cviWoV4g1EkmZ++sRdOr3X9kLRBakXv6RiSfi6y9p
	 4y+ncq00R66Tl6VHrf1naaaRvgir5mh9e6BnzB6ACMwuVDl0eW0qrKLKOK3o0WmOGpCIA
	 Nu+2s71TjXxZa7g95HMKDrRi9rEu1Kl20tk/adPJCgMtYX0vdQPfd1M53mmZYJKiqLys5
	 wSBp0ogi+m+qEzJMdUIHin+Pe5G0hNbs57qeQeE5u6HqJw9P46j/6fZ+uBG1578LeTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704449;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=FfRYHG7vpHVxNmVaLC0u/Bjda9EfuJdn6UBFGM2VUjo=;
	b=pXF5/rhRsEQf/ix8rfU0NQ4jrjxzytcVBb5wnqiArVvRvng2JAui3Puv3PUnmHQk+ecN
	 oqKgg713qL28CRYSLOD8Aa8G6Nx8V3KjW6V7AnjACYlxi/3Y86sp8RWrltzFhLXNFSqXR
	 tleOH4YytCtZ/f1p0eaWyR5fcicscV0C/CpP/llVj9y0ydj3L9aYlHVVB6IX74jETyMhq
	 GFwJUl4rVh3K/AfXkKIuBs55o/Vc+78NgldEqhWpBtak3l9Rt9LN4wDw0YnZeZOrdEO2b
	 X5yS77hSqwKk1oFAkwas8tV2PT33fxLI2TWQWIPgM8apR/Z52QaEV9Kbo4cktANPXFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h5oZsdyT;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22402606A331
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 14:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22402606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h5oZsdyT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795704448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfRYHG7vpHVxNmVaLC0u/Bjda9EfuJdn6UBFGM2VUjo=;
	b=h5oZsdyTziDprtZx2i93kBfSQqksAIpQlVAWrt0geuMwc4uy/3YE1DsHvkPM/ujA6tRGrf
	F8y6s546E7KFVNORL4rNpP2X1GgSWVa4EtbvnmyYSwbn7qEoCv6gtXxYphIPusOlN+lP6E
	6UURYkE0E4PKtF0jnjk63fo3NmjmNm0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-ha-PtO4pPp27ZBNF0L3KGA-1; Thu, 26 Nov 2026 14:47:26 +0000
X-MC-Unique: ha-PtO4pPp27ZBNF0L3KGA-1
X-Mimecast-MFC-AGG-ID: ha-PtO4pPp27ZBNF0L3KGA_1795704445
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a35db2d6b3so49635245e9.3
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 06:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795704445; x=1796309245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FfRYHG7vpHVxNmVaLC0u/Bjda9EfuJdn6UBFGM2VUjo=;
        b=Xwz9yN8aqiueBB8V4O9ntkRWjgD6KIjkNw3dI/ejRf0A/2rmMHUtl/Pm7aA7v5fTuj
         rPU3VmsJxWL483gqHL8yn8tVOILJXvfvRvT3bl7PSY4ogSkAMGuqLkt6adKtA9au5DhT
         pDWxisIkpY2doq/jNRHAFRQZd9Qt/U74S0kjGN7Ca5bc0Rwq3WpAiKHCoGST7bPwRbUy
         0/OqTo5WBBdO8YHpruNm885+8ORuQ4Wvz4h9ePDDyVWQQefixnh1GBXZUaBD+xf74lzR
         6UyS81vVB43zAXbIg0LCyvH+ek52NnxM8yRAtcJX/taA8c1BsNGpR10y7GFht2TlH/zh
         H/tw==
X-Forwarded-Encrypted: i=1; AL+hErEh2t0icgYOiB4owL6WlJY5fUXXNnsLvlaeJ6Y7YYxqVxW6Gxq+c+vtoLCTFeZc/5f0Ps2orjRgMY4jQvPg6g==@lists.linux.dev
X-Gm-Message-State: APuU4Z99avPgw2zWEc+iqytmh5uZFbhOMMBxHEqTc9t9UJzOppGt9GjU
	WyBwJwk4XKXGtfhMuxAFpZ4DfxoLkeWlnCF5QxHkRc5bY0SP4LGu5dXTEukzWETxIEn6IKJ0+pC
	m2DEtgXUPousZrfMPx6KLjKbpAgqpsjmZTkGbmpxPWDyzWrm/nCQ6KYpsrEGXdT4SUpba
X-Gm-Gg: AZFdTZchkxgvV1BxbAR++bAwgP8Ce+YgJrvdDK4+P23AxUySdda/1zfL989r0UUuhEU
	RL6RXf/u3+GkavaTklQkuGdiN0TWDcXkeQw+nBsZDQa5Nv8Wfe6G+1ZLI2GSE6oOpiaslPwXg82
	83oB1geU0An1I+qS98pU8FVpUrBghzZDDSFaXaGvVV0/b9VHKmS7gB3UAPR/5T4kfl+KwOkN/02
	5lrg38PGK9XclwkBDRLP54jMnBq5oLq0l5f0oI6QLJ4seePlHIIJmVs/jLjCIkWnzrx425VN/x2
	/l28D6eUjXusWDc28RsGz98te9gm6RBc+LNtrYhfoAsKI9U10yoQlFy7UkC8gXH/nQa50CUNEw6
	0G8HpHDMppqnN3N1BFse3Cu2lYl9jEqxP+otQSHii/K6/Mrb4SEULLSlc6emtg/qshww0ROAb+B
	o466jYukYxygNWg29wRB1bstq/h4+JJ7TcThDtHCzs
X-Received: by 2002:a05:600c:c84:b0:4a8:9a2f:d27 with SMTP id 5b1f17b1804b1-4bb8881f47emr439426915e9.25.1795704445021;
        Thu, 26 Nov 2026 06:47:25 -0800 (PST)
X-Received: by 2002:a05:600c:c84:b0:4a8:9a2f:d27 with SMTP id 5b1f17b1804b1-4bb8881f47emr439426315e9.25.1795704444517;
        Thu, 26 Nov 2026 06:47:24 -0800 (PST)
Received: from mszeredi-thinkpadt14gen6.redhat.corp (193-226-214-34.pool.digikabel.hu. [193.226.214.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb905f1489sm388114905e9.0.2026.11.26.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:47:23 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	virtualization@lists.linux.dev
Cc: Li Wang <liwang@kylinos.cn>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 4/5] virtiofs: abort the connection if the server fails to unmap a DAX range
Date: Thu, 26 Nov 2026 15:47:17 +0100
Message-ID: <20261126144719.232329-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126144719.232329-1-mszeredi@redhat.com>
References: <20261126144719.232329-1-mszeredi@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 5uWFm9Irtz-ZcQ2SL42-bh4kkG_CbuU0w3DD_UnvKQI_1795704445
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

If FUSE_REMOVEMAPPING fails, at least one range is still mapped on the
server side.  Both callers return the ranges to the free pool regardless,
so the next allocation can hand one to a different inode while the server
still has it mapped, exposing one file's data in another.

The ranges cannot be reused, but they also cannot usefully be tracked.
The requests are sent in batches and the first failure aborts the rest, so
it is not known which of them the server did drop; and a server that
refuses a request it is required to honour will keep refusing, so every
range ends up retired one by one, with nothing to replenish the pool.
__fuse_dax_fault() then waits uninterruptibly in wait_event() for a free
range that can never arrive.  Quietly retiring ranges only delays the
failure and makes it worse when it comes.

Abort the connection instead.  No FUSE_SETUPMAPPING can succeed after
that, so no range is ever handed out again and the pool stays reusable
without any bookkeeping, which is why both callers can go back to
ignoring the error.  The abort is done in fuse_send_removemapping(),
synchronously, because it has to happen before the caller returns the
ranges to the free pool: deferring it would leave a window in which
another thread could allocate a range and map it on top of the one the
server kept.

A dead connection is not such a case: the server is not going to access
the ranges any more, so they stay reusable.  Test the connection rather
than matching on -ENOTCONN, which missed the -ECONNABORTED and -ENODEV
that fuse_chan_abort() ends requests with.  For that, add a
fuse_chan_connected() accessor, as fuse_chan is private to dev.c.

For the abort to mean what it says, a failure has to be the server's
fault and nothing else.  Send the request with args.force, which allocates
with __GFP_NOFAIL and waits uninterruptibly, so that neither a fatal
signal on the calling task nor a failed request allocation is mistaken
for a refusal.  The remaining kernel-side allocation failures were
addressed by the two preceding patches.

Note that the uninterruptible wait means an unresponsive server now hangs
the caller rather than letting a fatal signal out; the connection's
request timeout, if configured, is what breaks that.  This matches what
the rest of the eviction path already does.

Fixes: c2d0ad00d948 ("virtiofs: implement dax read/write operations")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dax.c | 59 ++++++++++++++++++++++++++++++++++++++-------------
 fs/fuse/dev.c |  5 +++++
 fs/fuse/dev.h |  1 +
 3 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index c5bbb5d91026..ac84ada25a5a 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2020 Red Hat, Inc.
  */
 
+#include "dev.h"
 #include "fuse_i.h"
 
 #include <linux/delay.h>
@@ -229,6 +230,25 @@ static int fuse_setup_one_mapping(struct inode *inode, unsigned long start_idx,
 	return 0;
 }
 
+/*
+ * The server is required to drop the mappings it is asked to drop.  If it
+ * refuses, the ranges stay mapped on the server side, and handing one to
+ * another inode would expose one file's data in another.
+ *
+ * Rather than keep track of which ranges are still live, abort the
+ * connection.  No FUSE_SETUPMAPPING can succeed after that, so no range is
+ * ever handed out again and the pool can be reused without a second thought.
+ * The abort has to happen here, before the caller returns the ranges to the
+ * free pool, so that it cannot race with a concurrent allocation.
+ *
+ * A dead connection is not such a case: the server is not going to access
+ * the ranges any more, so they stay reusable.  Test the connection rather
+ * than matching on -ENOTCONN, which misses the -ECONNABORTED and -ENODEV
+ * that fuse_chan_abort() ends requests with.
+ *
+ * The request is sent with args.force so that neither a fatal signal nor a
+ * failed request allocation can be mistaken for the server refusing.
+ */
 static int fuse_send_removemapping(struct inode *inode,
 				   struct fuse_removemapping_in *inargp,
 				   struct fuse_removemapping_one *remove_one)
@@ -236,6 +256,7 @@ static int fuse_send_removemapping(struct inode *inode,
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	FUSE_ARGS(args);
+	int ret;
 
 	args.opcode = FUSE_REMOVEMAPPING;
 	args.nodeid = fi->nodeid;
@@ -245,7 +266,16 @@ static int fuse_send_removemapping(struct inode *inode,
 	args.in_args[1].value = inargp;
 	args.in_args[2].size = inargp->count * sizeof(*remove_one);
 	args.in_args[2].value = remove_one;
-	return fuse_simple_request(fm, &args);
+	args.force = true;
+
+	ret = fuse_simple_request(fm, &args);
+	if (ret && fuse_chan_connected(fm->fc->chan)) {
+		pr_err("fuse: server failed to remove DAX mapping, aborting connection.  count=%u offset=0x%llx len=0x%llx ret=%d\n",
+		       inargp->count, remove_one->moffset, remove_one->len,
+		       ret);
+		fuse_chan_abort(fm->fc->chan, false);
+	}
+	return ret;
 }
 
 static int dmap_removemapping_one(struct inode *inode,
@@ -340,7 +370,7 @@ static void inode_reclaim_dmap_range(struct fuse_conn_vdax *fcd,
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_dax_mapping *dmap, *n;
-	int err, num = 0;
+	int num = 0;
 	LIST_HEAD(to_remove);
 	unsigned long start_idx = start >> FUSE_DAX_SHIFT;
 	unsigned long end_idx = end >> FUSE_DAX_SHIFT;
@@ -365,11 +395,13 @@ static void inode_reclaim_dmap_range(struct fuse_conn_vdax *fcd,
 
 	WARN_ON(fi->vdax->nr < num);
 	fi->vdax->nr -= num;
-	err = dmap_removemapping_list(inode, num, &to_remove);
-	if (err && err != -ENOTCONN) {
-		pr_warn("Failed to removemappings. start=0x%llx end=0x%llx\n",
-			start, end);
-	}
+	/*
+	 * A failure is dealt with in fuse_send_removemapping(): either the
+	 * connection is already gone, or it has just been aborted because the
+	 * server refused.  Either way nothing can be mapped any more, so the
+	 * ranges are safe to return to the free pool.
+	 */
+	dmap_removemapping_list(inode, num, &to_remove);
 	spin_lock(&fcd->lock);
 	list_for_each_entry_safe(dmap, n, &to_remove, list) {
 		list_del_init(&dmap->list);
@@ -882,15 +914,12 @@ static int reclaim_one_dmap_locked(struct inode *inode,
 	interval_tree_remove(&dmap->itn, &fi->vdax->tree);
 	fi->vdax->nr--;
 
-	/* It is possible that umount/shutdown has killed the fuse connection
-	 * and worker thread is trying to reclaim memory in parallel.  Don't
-	 * warn in that case.
+	/*
+	 * A failure is dealt with in fuse_send_removemapping(), which aborts
+	 * the connection if the server refused.  The caller owns the mapping
+	 * either way.
 	 */
-	ret = dmap_removemapping_one(inode, dmap);
-	if (ret && ret != -ENOTCONN) {
-		pr_warn("Failed to remove mapping. offset=0x%llx len=0x%llx ret=%d\n",
-			dmap->window_offset, dmap->length, ret);
-	}
+	dmap_removemapping_one(inode, dmap);
 	return 0;
 }
 
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index b198cc729cba..c653aabf2449 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -424,6 +424,11 @@ unsigned int fuse_chan_num_waiting(struct fuse_chan *fch)
 	return atomic_read(&fch->num_waiting);
 }
 
+bool fuse_chan_connected(struct fuse_chan *fch)
+{
+	return READ_ONCE(fch->connected);
+}
+
 void fuse_chan_set_fc(struct fuse_chan *fch, struct fuse_conn *fc)
 {
 	fch->conn = fc;
diff --git a/fs/fuse/dev.h b/fs/fuse/dev.h
index dbffd5bed2f5..71f56e71c899 100644
--- a/fs/fuse/dev.h
+++ b/fs/fuse/dev.h
@@ -34,6 +34,7 @@ unsigned int fuse_chan_num_background(struct fuse_chan *fch);
 unsigned int fuse_chan_max_background(struct fuse_chan *fch);
 void fuse_chan_max_background_set(struct fuse_chan *fch, unsigned int val);
 unsigned int fuse_chan_num_waiting(struct fuse_chan *fch);
+bool fuse_chan_connected(struct fuse_chan *fch);
 void fuse_chan_set_fc(struct fuse_chan *fch, struct fuse_conn *fc);
 void fuse_chan_set_initialized(struct fuse_chan *fch, struct fuse_chan_param *param);
 ssize_t fuse_chan_send(struct fuse_chan *fch, struct fuse_args *args);
-- 
2.56.1

