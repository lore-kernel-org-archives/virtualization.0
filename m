Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971206;
	b=IJvZaM0r/bHj9S2bhtqnqGPKdFPtdZMi0YskqFf959YoGYWQK9++02TVK7DHUGWd3Cvj
	 6R0lQl+17ebzCQGdnaaOcfrStwEGGP7m0IhVpEfq1NAF4k/GvnNj6VQDNpV/zZzCWbZWi
	 Kc2AfxQsXojGHM49CirLa1vLvfR2KuGOvW4bUBbIXfxPR0nR7UELvWoIMqHqjHvE3Doa4
	 7JQMd+MnUtHRi2W0GMSzV1JpeOBFUemi8zkeryVP9nVLDT+sBToFU8U1ZCxvwOODrjmm+
	 yAZQoGmDpBmJSsPyZvoYpEngZOiAr+5faUipL5oiAiHJ6oa/PPGCW4fQ6vvoyPSpmyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971206;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hTZCBIjpZOspCZhwg+BKx9PwD4UeGBiWTdjVtWLRfNE=;
	b=vFh2VFzy2rDM41iZWppozO3xv7KsX2fOLMBKGsM8ccdQDwPlB8ZAMLD+iBvQjb1EG4TB
	 jC4nIYJVB3QDXy9SW5HrbvRW0NktcsZzrWSvFMlhxz0OO05MSo9zVWlQ7T5uga6ZxxxKT
	 oIRP+lztVXIJ+lLF0RjZ99WcTH7Q7SBF8rjqUl+WJk1hJH3xNR3QtYOyqKYBh04UO01bC
	 5LYc9RUzoI6q8gwE3I1zyJqguRG9y6pOFoH6opKEmiEw5zjYRVPycE2zJK3vL3wm3IlKu
	 Y3l+loz6xqtvtWgx4OoJ28heXHLLxSw4KvPY4Co1t82mdmsoFKai+QMHzojxzjAUM3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EQcBM+LH;
	arc=none smtp.remote-ip=95.215.58.130
Received: from mta1.migadu.com (out-130.mta1.migadu.com [95.215.58.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8742D606D802
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 13:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8742D606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EQcBM+LH
X-Envelope-To: virtualization@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=SEovZ4ALBXSWOhtuKK3tlcth4LgwnYMDhPbgNF54x8Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793971203; v=1; x=1794576003;
 b=EQcBM+LHwJ0OR3V+WDzYKoGXOOwYzEP0YDOW5Selm8oDi2X3vWhrPxIyQ0lbwpPhWbAX7mqk
 G2zvdIl3kIhRMXnAeUV4N08BcRYyBnvPqnCi0dgHYdU7P7r7w8laCDsGQfyxeVbvhpbvQjfujc7
 TzfqnN/mSbd0oiAUeAw6ZtM0=
X-Envelope-To: virtualization@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 7dc7413b7e7a1b47;
	Fri, 06 Nov 2026 13:20:03 +0000
X-Mizu-Trace-ID: 7dc7413b7e7a1b47
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
Subject: [PATCH 4/7] tracing: account ring buffer pages and trace_array metadata to memcg
Date: Fri,  6 Nov 2026 21:18:26 +0800
Message-ID: <20261106131829.3228926-5-cui.tao@linux.dev>
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

Creating an instance immediately allocates two full sets of per-cpu
ring buffers, array buffer plus snapshot, about 1.375MB per cpu per set
on the default config, plus the trace_array and its name.  None of it
is charged: neither trace.c nor ring_buffer.c passes __GFP_ACCOUNT,
while user_events in the same directory accounts everything it
allocates.

Instance creation is currently gated by tracefs file permissions
alone, so a
rootful container with the host tracefs bound in can create instances
until the host runs out of memory.  Charge the ring buffer pages and
the trace_array metadata to the creating cgroup.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/trace/ring_buffer.c | 8 +++++++-
 kernel/trace/trace.c       | 6 +++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1fd28a72e6ee..676c059c112c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -441,7 +441,13 @@ static struct buffer_data_page *alloc_cpu_data(int cpu, int order)
 	 * gracefully without invoking oom-killer and the system is not
 	 * destabilized.
 	 */
-	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_COMP | __GFP_ZERO;
+	/*
+	 * The subbuffers are charged to the memcg of whoever caused the
+	 * allocation: the creator of a trace instance, or root at boot for
+	 * the global trace.
+	 */
+	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_COMP | __GFP_ZERO |
+		  __GFP_ACCOUNT;
 
 	page = alloc_pages_node(cpu_to_node(cpu), mflags, order);
 	if (!page)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e8c4efa8107b..04b60b9cc4f5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8693,11 +8693,11 @@ trace_array_create_systems(const char *name, const char *systems,
 	int ret;
 
 	ret = -ENOMEM;
-	tr = kzalloc_obj(*tr);
+	tr = kzalloc_obj(*tr, GFP_KERNEL_ACCOUNT);
 	if (!tr)
 		return ERR_PTR(ret);
 
-	tr->name = kstrdup(name, GFP_KERNEL);
+	tr->name = kstrdup(name, GFP_KERNEL_ACCOUNT);
 	if (!tr->name)
 		goto out_free_tr;
 
@@ -8708,7 +8708,7 @@ trace_array_create_systems(const char *name, const char *systems,
 		goto out_free_tr;
 
 	if (systems) {
-		tr->system_names = kstrdup_const(systems, GFP_KERNEL);
+		tr->system_names = kstrdup_const(systems, GFP_KERNEL_ACCOUNT);
 		if (!tr->system_names)
 			goto out_free_tr;
 	}
-- 
2.43.0

