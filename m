Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.188
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971258;
	b=jm/ZsFM9rQ+D6C1I+gWuqooJCLJmD8GJgkKXM9ZcTSKUtDLGnOGlnY90zU5e9LQzPhB8
	 tABJ9AvmVNV0WejOGL2EwvMGGQb5pMWq4O93JBfSxrtVjjQTtziGC2m+afrBCzaNv7xFc
	 4JeKoTexERrfmg5zg1jdlbfOEdkx2gmdoIkXZRqjREAwqoapXVkTy34VmiY6gZ1913Cp7
	 fg3EvvIDFQx1wWV4SsC0K0nxJUV6CR9Ih9TJGyh0PQGtgxrV/EeQ4iSYgpDd9NXlmZGhN
	 8O1BKMW/TtuivAKW7FqNbIHN5wli9XnD+spXtbnhDX+nUIEkxKlwa7fw+zoC6Cvniig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971258;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mBQnCmi6lRqH8GAi8YV/xcgTg4V0TO+wKEtX2yDXFxQ=;
	b=DqOjN/shiZbLHLYnZmpVc+iGWDtXbcxqw3vb3ZAO9GZGi6ZLR+7afi+nYQwGUR0Dz6tU
	 L2gmL15cP2n+NAnOpetI/CrgMZvDhrvpZZRChCZPHiakXdi9UnB7Gv9nnPdHhYPHW9LWZ
	 /kiiRlhQKVR4eHQOeUE62eRNOyDj347kW2ACBMrm3i6L8/8MfR0mKW3eiYknIRKxNCp48
	 n32F68wLs3waldTyWwQVUQHVbPKSor7yyodFLpsupoqRXnB5qFM+Vp8XwFSmEU7/hXo5M
	 PROjj//sjTzidoSwVBYxATSvq6N6tawEuBkxkvXUOHaMWld6rOPhHizU97Sk+e8GGOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AeWGSHSw;
	arc=none smtp.remote-ip=91.218.175.188
Received: from mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DD7606A337
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 13:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08DD7606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AeWGSHSw
X-Envelope-To: virtualization@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=dKQ/3LCCVbNcrSr0Tnyt8Yullo0Ku/Vkln3W2FNUdns=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793971256; v=1; x=1794576056;
 b=AeWGSHSw5gCUCbueF62VSkT4cd4H1UWyOnuiftbsvsH889tMmC2ju0ZopLoCA7ztdQoWRGFj
 Ah9CMYssyGipSVl+fOz0aQ50JMH5mol+kXYjs90BTdwmZzGC1/1QzVy/MXrru2z9UISsupQEMQg
 oQNHTipoer+T01odkijK4tPs=
X-Envelope-To: virtualization@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 178d9492481963cf;
	Fri, 06 Nov 2026 13:20:55 +0000
X-Mizu-Trace-ID: 178d9492481963cf
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: akpm@linux-foundation.org,
	dgilbert@interlog.com,
	mkp@kernel.org,
	loberman@redhat.com,
	jmeneghi@redhat.com,
	kraxel@redhat.com,
	vivek.kasireddy@intel.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	rostedt@goodmis.org,
	vdonnefort@google.com,
	mhiramat@kernel.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	axboe@kernel.dk
Cc: linux-mm@kvack.org,
	James.Bottomley@HansenPartnership.com,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	phasta@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	linux-scsi@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bobbyeshleman@meta.com,
	mathieu.desnoyers@efficios.com,
	robin.murphy@arm.com,
	mason@kernel.org,
	aesteve@redhat.com,
	tjmercier@google.com,
	harry@kernel.org,
	vbabka@suse.cz,
	cui.tao@linux.dev,
	cuitao@kylinos.cn
Subject: [PATCH 7/7] io_uring: account the remaining per-object allocations to memcg
Date: Fri,  6 Nov 2026 21:18:29 +0800
Message-ID: <20261106131829.3228926-8-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106131829.3228926-1-cui.tao@linux.dev>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
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

From: Tao Cui <cuitao@kylinos.cn>

A handful of io_uring allocations still scale with user controlled
counts on plain GFP_KERNEL: the per-ring io-wq and its workers, the
alloc cache entry arrays, the provided buffer peek and import iovec
arrays, and the registered eventfd contexts.  The tctx side is covered
by commit 0b34e7b20a48 ("io_uring: charge tctx nodes and
personalities").

Charge what is left.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 io_uring/alloc_cache.c | 3 ++-
 io_uring/eventfd.c     | 2 +-
 io_uring/io-wq.c       | 4 ++--
 io_uring/kbuf.c        | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/io_uring/alloc_cache.c b/io_uring/alloc_cache.c
index 58423888b736..f41df1878633 100644
--- a/io_uring/alloc_cache.c
+++ b/io_uring/alloc_cache.c
@@ -22,7 +22,8 @@ bool io_alloc_cache_init(struct io_alloc_cache *cache,
 			 unsigned max_nr, unsigned int size,
 			 unsigned int init_bytes)
 {
-	cache->entries = kvmalloc_array(max_nr, sizeof(void *), GFP_KERNEL);
+	cache->entries = kvmalloc_array(max_nr, sizeof(void *),
+				      GFP_KERNEL_ACCOUNT);
 	if (!cache->entries)
 		return true;
 
diff --git a/io_uring/eventfd.c b/io_uring/eventfd.c
index 63fe6e5d79ba..52f5d5b85f30 100644
--- a/io_uring/eventfd.c
+++ b/io_uring/eventfd.c
@@ -132,7 +132,7 @@ int io_eventfd_register(struct io_ring_ctx *ctx, void __user *arg,
 	if (copy_from_user(&fd, fds, sizeof(*fds)))
 		return -EFAULT;
 
-	ev_fd = kmalloc_obj(*ev_fd);
+	ev_fd = kmalloc_obj(*ev_fd, GFP_KERNEL_ACCOUNT);
 	if (!ev_fd)
 		return -ENOMEM;
 
diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 92df54c6f50c..98f3aa378baf 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -981,7 +981,7 @@ static bool create_io_worker(struct io_wq *wq, struct io_wq_acct *acct)
 
 	__set_current_state(TASK_RUNNING);
 
-	worker = kzalloc_obj(*worker);
+	worker = kzalloc_obj(*worker, GFP_KERNEL_ACCOUNT);
 	if (!worker) {
 fail:
 		atomic_dec(&acct->nr_running);
@@ -1358,7 +1358,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 	if (WARN_ON_ONCE(!bounded))
 		return ERR_PTR(-EINVAL);
 
-	wq = kzalloc_obj(struct io_wq);
+	wq = kzalloc_obj(struct io_wq, GFP_KERNEL_ACCOUNT);
 	if (!wq)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index abf44f5dba26..bc6e552a91dd 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -288,7 +288,7 @@ static int io_ring_buffers_peek(struct io_kiocb *req, struct buf_sel_arg *arg,
 	 * a speculative peek operation.
 	 */
 	if (arg->mode & KBUF_MODE_EXPAND && nr_avail > nr_iovs && arg->max_len) {
-		iov = kmalloc_objs(struct iovec, nr_avail);
+		iov = kmalloc_objs(struct iovec, nr_avail, GFP_KERNEL_ACCOUNT);
 		if (unlikely(!iov))
 			return -ENOMEM;
 		arg->iovs = iov;
-- 
2.43.0

