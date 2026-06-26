Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4136C3F8245
	for <virtualization@lists.linux.dev>; Fri, 26 Jun 2026 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481722; cv=none; b=q7moevMLHdtYjvZu+CiizKwe+IuN+V8yX/Z3N01HsJTdco/M/64RigCVpK+jCK25O5mhqzZefPpfcbX1xKARkDWRNvmhQ7H+RxSOJ6JDpesW/Lxj2NFF4q+yJUc2K0T1jRbKb8Ap8Mj1Ncdh0D/1oXeWC71LmBJJpCKiXGstHjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481722; c=relaxed/simple;
	bh=h6wI67WE4wGINnOp1v4qFtLNzEeCT9OncC/LXQiBsJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=RFwgJ5ircrrkjjAE6kHnZ/rzNajPwtYbmnPueTP61PJuDMmluGOSUwFR/Owp2EUt/gDLjOxb7lQdvx+IFIKmr5wP8LRVv92Vt4Wqzn1KtC+70hA3m7rd3V5ZqUZuZEAKQ9bPTHybXEDBBM5Drj6+14QQlVCLVcOHeYT+CxN0I9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LxBBN6pk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxBBN6pk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782481718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+x55wPutcqcllhjFEZvXEglHQBic+9gv93y+ngfVIU=;
	b=LxBBN6pkpN580jA4vmhPq0mtPlBWw9ngn+/i8Kdnwph7D4aZGH//lhB6R3CrvhdlxYbT/X
	ADqJgUOOhxAS1dIwM+5tLN17mCJtSwKt1557AVL0cWP8N3A6+Y8dIRPSz6YvccInMMDMa/
	e4S6njgQejI+i+qIiKANlVxRR6O1vEQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-1bahlLyRM4KCcTt3uIOAiA-1; Fri, 26 Jun 2026 09:48:37 -0400
X-MC-Unique: 1bahlLyRM4KCcTt3uIOAiA-1
X-Mimecast-MFC-AGG-ID: 1bahlLyRM4KCcTt3uIOAiA_1782481716
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4924207e640so7691805e9.3
        for <virtualization@lists.linux.dev>; Fri, 26 Jun 2026 06:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481716; x=1783086516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F+x55wPutcqcllhjFEZvXEglHQBic+9gv93y+ngfVIU=;
        b=Bwlte2Ls3FoGj3DguxYFOhxoIfoRKH5zKKMBa65O3g3lr/u2ke+AdRxyGSJ7Siz1H2
         OhVprwwpTJeWZDWT1wAUCJUlnNqe8lPjBdnZli0pLGe7noWdk9J7UDTb07s/9Vq7tO6q
         gQRj9EqeLRnmaDEveNG7ObjZiSGXFRSoUA0tyuIrdTcGZIRhTmA1NomJ6uOzyi5fZHvD
         8jfmRdpOtL9QOK3ETpcAJTzHj3mdzM7Sz/ClOaC9h7D8A06XpDuloij42jtNyyo5Aih7
         LGymph/WpeYQIUt7SotQ9gkuVFcC7yfLwSWGOOtL7istBahr94PWImJZLt4Rv0zFhs79
         f7CQ==
X-Forwarded-Encrypted: i=1; AFNElJ+FARYyebhOwi4QcxIX8esmbxXpVMVtzacno9qmCnaEfVJwa8ej3Fo6GxW6s/eNAOxWV2IEHW6yN1lH5S/TSw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZwGVBNnVviPdVUI9MdVxTpEG6yIC/0W+g7gaw+wiGIUClHelG
	r+Xo4cAecEndEXf3PspT+2phuHOvCzvWT7iuJvmLb5V7kV1h0D78IM0oNOFIRPcSGMjeXiY0zgM
	t/52AzaqrM74/c6eBym0GgWBM6uYG5JOcfM/HIK4IR/2dffDvMvX62AMZRkQM+/AKEEJo
X-Gm-Gg: AfdE7cm9hqeOsyUV/rLqieqTLkXePUxFxI9FNMINXY/okrn1B7PXAG/9CU5bA2fH/Zv
	3HsSpZoEJyieMyTuqGuHKO91tg5b+a2BlpDv71PJAlsY3XeCrlerYDtaYbylnbBul5POepGj+iA
	dN8RLYXA86MUzsRdavVfzxMkW7idC8Y3u9SbSDm6cHg6GHDaVK5XhAGADuiS+/pSi0jTAxq67Xb
	gbQwYEqJ6AT/qvx7fmmKNC6BcKMRyeZ9usib4HmsUIAfy8ijOk9HxdZPnATXf9ePH0mCg/eydFB
	QyM/xK2jkCc6iffkPpCFHpyUyBcbzCYEyxRc8iz3M6cMpMSsXO5a2oBtgGky3QrEa5z01f3YaKS
	Pa6NiXmmPPJ4WPjtOFC9FwFOJwUYFMq+8hwAeah1lr6G65Do=
X-Received: by 2002:a05:600c:1383:b0:492:46c3:c7dc with SMTP id 5b1f17b1804b1-4926fc3a838mr14856415e9.14.1782481715886;
        Fri, 26 Jun 2026 06:48:35 -0700 (PDT)
X-Received: by 2002:a05:600c:1383:b0:492:46c3:c7dc with SMTP id 5b1f17b1804b1-4926fc3a838mr14855905e9.14.1782481715451;
        Fri, 26 Jun 2026 06:48:35 -0700 (PDT)
Received: from stex1 (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46dcbac0c9dsm15336242f8f.19.2026.06.26.06.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:48:34 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH net 2/2] vsock/test: add test for small packets under pressure
Date: Fri, 26 Jun 2026 15:48:23 +0200
Message-ID: <20260626134823.206676-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626134823.206676-1-sgarzare@redhat.com>
References: <20260626134823.206676-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1R2_ldsoN6M3JaFg1H4A5TiPZEPkdLS4H4j-JYeIazc_1782481716
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

Add a test that sends 2 MB of data using randomly sized small packets
(129-512 bytes) over a SOCK_STREAM connection. Packets above
GOOD_COPY_LEN (128) bypass the in-place coalescing in recv_enqueue(),
forcing each one into its own skb.

Without receive queue collapsing, the per-skb overhead eventually
exceeds buf_alloc and the connection is reset. The test verifies
that all data arrives and that content integrity is preserved.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 87 ++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 76be0e4a7f0e..b4ff9f946565 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -2347,6 +2347,88 @@ static void test_stream_tx_credit_bounds_server(const struct test_opts *opts)
 	close(fd);
 }
 
+/* Test that many small packets don't cause a connection reset under pressure
+ * and that data integrity is preserved.  Packet sizes vary randomly between
+ * 129 and 512 bytes, above GOOD_COPY_LEN (128) to bypass in-place coalescing
+ * in recv_enqueue, forcing each one into its own skb.  Without receive queue
+ * collapsing, the per-skb overhead eventually exceeds buf_alloc and the
+ * connection is reset.
+ */
+#define COLLAPSE_PKT_MIN 129
+#define COLLAPSE_PKT_MAX 512
+#define COLLAPSE_TOTAL (2 * 1024 * 1024)
+
+static void test_stream_collapse_client(const struct test_opts *opts)
+{
+	unsigned char *data;
+	unsigned long hash;
+	size_t offset = 0;
+	int i, fd;
+
+	data = malloc(COLLAPSE_TOTAL);
+	if (!data) {
+		perror("malloc");
+		exit(EXIT_FAILURE);
+	}
+
+	for (i = 0; i < COLLAPSE_TOTAL; i++)
+		data[i] = rand() & 0xff;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	while (offset < COLLAPSE_TOTAL) {
+		size_t pkt_size = COLLAPSE_PKT_MIN +
+			rand() % (COLLAPSE_PKT_MAX - COLLAPSE_PKT_MIN + 1);
+
+		pkt_size = min(pkt_size, COLLAPSE_TOTAL - offset);
+
+		send_buf(fd, data + offset, pkt_size, 0, pkt_size);
+		offset += pkt_size;
+	}
+
+	hash = hash_djb2(data, COLLAPSE_TOTAL);
+	control_writeulong(hash);
+
+	free(data);
+	close(fd);
+}
+
+static void test_stream_collapse_server(const struct test_opts *opts)
+{
+	unsigned long hash, remote_hash;
+	unsigned char *data;
+	int fd;
+
+	data = malloc(COLLAPSE_TOTAL);
+	if (!data) {
+		perror("malloc");
+		exit(EXIT_FAILURE);
+	}
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	recv_buf(fd, data, COLLAPSE_TOTAL, 0, COLLAPSE_TOTAL);
+
+	hash = hash_djb2(data, COLLAPSE_TOTAL);
+	remote_hash = control_readulong();
+	if (hash != remote_hash) {
+		fprintf(stderr, "hash mismatch: local %lu remote %lu\n",
+			hash, remote_hash);
+		exit(EXIT_FAILURE);
+	}
+
+	free(data);
+	close(fd);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -2546,6 +2628,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_msg_peek_client,
 		.run_server = test_stream_peek_after_recv_server,
 	},
+	{
+		.name = "SOCK_STREAM small packets backpressure",
+		.run_client = test_stream_collapse_client,
+		.run_server = test_stream_collapse_server,
+	},
 	{},
 };
 
-- 
2.54.0

