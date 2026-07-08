Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB84218A1
	for <virtualization@lists.linux.dev>; Wed,  8 Jul 2026 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506570; cv=none; b=fmXD99iSi5wxZovTBVH8BUAGJ/EgOEvj2Tcmvvd8nN+SIq5iVV8W5IJgHcXBiZ8rlsh1qzG1EA1s2Ct96Z6r3CnOAcRPH3MJANbHQGMXG6FcqLz+gk8soaLPGqYmZKzeq5nmGBUqqy2vdwtFMrOx6ZuvlgmbK9uCxAu7nsnJux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506570; c=relaxed/simple;
	bh=qNZiJSTEfc7fTVZbT1Hdz+TpSbOWakYcGAe5W8RAZ0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ULK0GvusQoH9Vq1ZvFyfwyUNKIAfJhRm5El6M8iXy/Q8EPvMf18543bbzncBhZsGE+tKJrBHsfOkQqMtBJMLgpCd5DkU65I56Y3+I/hk7k4IHC1gneJVzdY/g4pgpLT+NIwWxMzLwH1cqfPobsqPLXdpyrMJGwLhwpRbjMPJ1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAkXTRNK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAkXTRNK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783506559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s31Zp5IE8kvOUi9c30CVIvqfz2iKzORtScqC5v+Omgg=;
	b=JAkXTRNKHaibBx70ISV1xr/IJP3O6STs5FIVickJ1lCR/XysKdLfvCYvXcAfEsieRJo1Lj
	VZx72/9XPa5+SJwMblL6PlYDHoXm1c+Pu8l1L8gr9Q3KEBtRSZWDpgqeNNvNhlWgUjWkdh
	ZoiUSFwnQksJ3nJs/TrVQSRugebAt4Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-jj6_06SBNAiMjOBEJQ0nqQ-1; Wed, 08 Jul 2026 06:29:18 -0400
X-MC-Unique: jj6_06SBNAiMjOBEJQ0nqQ-1
X-Mimecast-MFC-AGG-ID: jj6_06SBNAiMjOBEJQ0nqQ_1783506557
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-473f4a48e9aso388897f8f.2
        for <virtualization@lists.linux.dev>; Wed, 08 Jul 2026 03:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783506557; x=1784111357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s31Zp5IE8kvOUi9c30CVIvqfz2iKzORtScqC5v+Omgg=;
        b=q2EGuh8rhmT17n4xe/QtYlZe6kagjzIMH/m6aCvbUnEe0HuuFrxRGtmJvyC6wv2/ZM
         bkUg3aCQ9l/M+ncQct8WqRkD4p2xI1LigpV0sEQFRL8gkVO2ni5JPRvpvpgErpK5iKUX
         huGvxU8RSuDmDqxfUt2lLdZKTwFQkChhxsUXBLHR7dEtBHdBtwe0Kd8C6JRvoxLqzMMn
         vSrZ1h4GvA7/5u5m3H3l02bwE6fcTwRp4KR9upLDWBnWEKOZtXMCZunGnkL6MTPYO3lp
         ip5XT/GRlJZ7OgfCEFP2mUQM26L5VPfG0HsgUpsPDvh4BnSNM7toDU2Yz0sm2wgJMPCU
         dyhA==
X-Forwarded-Encrypted: i=1; AHgh+RrEREtVLmKQCalUksobqaAd4cZcTJoDkyAZL7+Wx9vy/HVjaRLuaBnTjKfeDYHy5TffhWd3IMkOu6tz2A80AQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPc/NAf2nNe1qdAbvGciokZ+IAdPSX7nFB52f4JlzdOATVNLZr
	H6WkXa1unC0rCtur2H3ILCE0EUv0O1xTDilC3TkjsvmvezcWuNrKcGyawS3tJbl2kEMzamtEZEJ
	nZs2zNbq0qGlHgUQxmX0/W2LfvfFrSGBA43TtDyFt2Ff0AZx3whqnNm1Uiv5K7V1qvQZ+
X-Gm-Gg: AfdE7ck+3hmWkGPmSPGD4sTvuiKGW3ANUdVl7nE7UFL9bg23axPXW7Y8PVBFgly7Gsv
	iPymiJrKpPHtIWy+s6AkRKvLZxZbvCON4+y9OzMmBzgNxipUWLfJWgAytCirMi5J3FlUUUDpNFW
	vB2cD0BT4Bwu/2omp2GsU+PBECuMkDB5KbNVa1CXJTM3kGGGNfYEpCOIiD81wXMKPC1tBS9jcyL
	hFVIvH/wpPqCdgSOVSafeiBQ/0hDAHHiJBXtoFjijeeTG5soCJZNZQBDIj/DlhAVzq4uccWVXcz
	/8i8mXW7VQlKkuy0nI2KArltn7OMuX5vtEfI+wldTounCYpoitD52KZkVlXW+wZrCPg/7DR3G0m
	02H+nIFclc+5c31fHSluyPkMkzvFYtpxopgmL2cDFPk4zXSs=
X-Received: by 2002:a05:6000:24ca:b0:462:e086:35f with SMTP id ffacd0b85a97d-47df0725e5cmr2146629f8f.21.1783506556904;
        Wed, 08 Jul 2026 03:29:16 -0700 (PDT)
X-Received: by 2002:a05:6000:24ca:b0:462:e086:35f with SMTP id ffacd0b85a97d-47df0725e5cmr2146583f8f.21.1783506556408;
        Wed, 08 Jul 2026 03:29:16 -0700 (PDT)
Received: from stex1 (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm40461480f8f.33.2026.07.08.03.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:29:15 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Jason Wang <jasowangio@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH net v2 2/2] vsock/test: add test for small packets under pressure
Date: Wed,  8 Jul 2026 12:29:04 +0200
Message-ID: <20260708102904.50732-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708102904.50732-1-sgarzare@redhat.com>
References: <20260708102904.50732-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: evF992xWLZCiLSPh3BVius3aaFxWM_MRPAPIzHnKp5U_1783506557
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
2.55.0

