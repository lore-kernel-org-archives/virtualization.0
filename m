Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795756770;
	b=lRF9L3/TfuctE+mSSncIGo5yHNnjB2T0u0Vmi0tulxNgqefH02bbG5kHDCKrcXfv1QRz
	 QXfGop+2n8+uQnvdlXMz4z7Z9GIjd9TAtcWHhzUlTf/sZCHtzBFRk9QGHV5i0T2KC0DKM
	 Oz7gIL5PB3IoxcIC00rf14eFODqn9u9XNPzs2HO81uisaFExkZOkccbByqZprzc7BjdoY
	 4BVVNp+8CmumUiHL7ElOV2xH6So7RlsUJ5RgRMBW69dnHDQkUjL7qHAixKmHI9cB4iL2C
	 iYU538Zvm3WDdXbFmlGTDjNR2depmWu2biqEI8ElSxv2JCSIZk8Us7Bw0pKAM7LT0Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795756770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rNWMVT2gHiNq7DFh40B5BMuJHnSTLGiieTCWA+72rZ0=;
	b=BkM4EPwA7omoeaGZWY/A/bWWVL432vVgcwGH+1Jt7Mv91Dn+obYI1YtPk8TcOFUZzbCe
	 JIZQFQVZ0MddG3nsRLvglAfF2tLk6cMS+ig5G3w4VDbhOWbXse2AcC/fiVXz05dtr581a
	 aI2/E5+5EFA3YiEZtr9VuhKRROZ+ZzCwg4ASFyW7h5h8d2m2y0KS2zKT1T74tjwQZ/mdf
	 2k/VDAMNzRfxnyz4ihwwNU5UbfAnI8B/mYJS83ejU+9Wyqs6o2S77Uz/x4WlRM7buJbjJ
	 oV5qXPBfre3q0aNB/6tW+9GfIk+VrrvNwM6jG9PJ99i7iGWK26kMGg4oRw1H75wus9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=umg0FCNw;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FBA606A323
	for <virtualization@lists.linux.dev>; Fri, 27 Nov 2026 05:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62FBA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=umg0FCNw
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b50a4bd2f3so6664615c88.1
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 21:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1795756769; x=1796361569; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rNWMVT2gHiNq7DFh40B5BMuJHnSTLGiieTCWA+72rZ0=;
        b=umg0FCNwb6Xj50D11z6vFXBlisYUwJMrzDXMT9Myir6+Mk+gEvOHwEpJtt+A8rsh+r
         kMUZcT2HL05351WNtXG2Yt29z/zYM2boy3gm03plIlOezFXBiwQfjX/kDKPOeYWUyGwx
         r5ZisqKhvOpP8ipPgbPbzz+nznVBi6J8E+qPjdTCSOzupjN6C/xk312lUaSE/IcLuO3c
         0LMWG5rX62KRG/rzPSpcqjvS04e2O2vu6Y19Bfh1+u34riMFp6zr3I3t0woD3ewtsSk6
         QGZG8aTzbqMaMMJtdOkZpSQKumILvCv8GIM0MX2fwl+0Bt5gPy4iMWkN6puTobBfeY+i
         F5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795756769; x=1796361569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rNWMVT2gHiNq7DFh40B5BMuJHnSTLGiieTCWA+72rZ0=;
        b=F9gk2BuT//jfVtOekUT5oOYqszvwuN37i7m82ra3xhq0v7LR4+++FVbGLIQMJe5vIa
         I03XPS4LLhDK1OzY2LISdoNvGEu5q1jGCEHbBQcNCbO4FiReA8XRXJuUbbaOmRgUiyFP
         AKmpxu0pGj27Mt54i6Rh9E0Zz+rYnsPKRLGz0+QQIlO4ZfrwrVcXaqAD/dFiv4Q0szL0
         LmsbU1JTsFc2HtCvpgc/tYve6SF/IYxcunrebKpa5OE8Ksbq2YfAZqazWgLKRsFhcB1o
         GUJ6syagp/VR4phRLNt5/2ValK5XjXpghk7jhLVAwr7DSVoEoggRW3vf0po/Qk1MxSwa
         HODg==
X-Gm-Message-State: APuU4Z8yY9Yl5BrgKp8Jq+2Ja6PsqHgBJfjnQDBaYw8e/WPJjMhuqzdg
	wRcyJ++1sM76hhT64rdh2SWraFVDhHnGirYgCA63GtEVANeQgRAFYdqe+K4psLoqDTB5iLBoY83
	VBWmbZA==
X-Gm-Gg: AZFdTZfloTj3PJJ2mmzWgzhKLe1mtWRB+n6pFgIfLpWCcCPFxqLvRrew4Sm76tgBIqO
	xDimgtawE6Mr6cw4ILFFpz77j/C4Xqz63PtQRTFqcq8fhKxg8obx4Dx4ws5w/sAL6FZxEUMP7ba
	Aug0ri8uX8VEoEzyh6Iw0euMxs+Mfu9XR3hdOpJ3HkCTtI2gIST8NdUKu9dxnZwAmULVz/JU5iH
	BsLeqh1yWBRyqWec+WYt0qUtZm9gULzeXIFaXiPCuOmcUep1gPlcIBBFECQDzsW0eA5vSsFbp7i
	HzylBQmJF/So9m7x2t+g45nEaohL//m9Am+SdGUkP0LwjHZ/ak1kYj9CvJQg2Sz/MASPZLNuLry
	DpqF0LWKMB4cW9uMmC24l/xOPfuE34/LCoCS8WxeT/I2l+j+kuGk4Y40X5rGPcjgVv0ezzZSwNK
	+Dxl/VGI/UuGbFsJwNpHse48zx/8MoElQW8WtD+LNsDXLq6iDmq5HEBtehFMuhv76dK8tu2BUjO
	UiPVUar4q/3o0m4GGXXx87ngiTzvfCAbOCcke7X/5SkAp7IO1ra/4jy78NOCrNc2iFeMnvgsNNh
	Kv408KsZ8AXAai2lubFj3jYivPHKVRqhEwnmI9o=
X-Received: by 2002:a05:7022:b044:10b0:181:73fc:e53 with SMTP id a92af1059eb24-1b5568e7699mr26233910c88.29.1795756769479;
        Thu, 26 Nov 2026 21:19:29 -0800 (PST)
Received: from enjou-Legion-Y7000P-2019 ([174.136.206.51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm82950093eec.10.2026.11.26.21.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 21:19:29 -0800 (PST)
From: Ren Wei <weir@nebusec.ai>
To: virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	bobbyeshleman@meta.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	horms@kernel.org,
	arseny.krasnov@kaspersky.com,
	vega@nebusec.ai,
	caoruide123@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 2/2] vsock/test: add stream MSG_WAITALL receive timeout test
Date: Fri, 27 Nov 2026 13:19:14 +0800
Message-ID: <503c1d5538f5b41f8eda756f5ea4491f0bd44518.1795591531.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1795587333.git.caoruide123@gmail.com>
References: <cover.1795587333.git.caoruide123@gmail.com>
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

From: Ruide Cao <caoruide123@gmail.com>

test_seqpacket_timeout covers SOCK_SEQPACKET with SO_RCVTIMEO, but there
is no SOCK_STREAM test for a cumulative receive timeout across partial
reads.

Have the peer drip-feed one byte every 0.8s while the client issues
recv(MSG_WAITALL) with a 1s SO_RCVTIMEO. Without the timeout being
preserved, the wait budget is restarted after each byte and the recv
completes after several intervals. With the fix, the call must return
around the original timeout, either with EAGAIN or with a partial read
shorter than the MSG_WAITALL request.

Keep the data socket open until both sides confirm: the client writes
WAITDONE after recv returns, the server finishes sending all six bytes
and acknowledges, and only then is the socket closed. Failure paths
complete the same handshake so the server does not hang.

Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 tools/testing/vsock/vsock_test.c | 112 +++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 10b9074fb87f..868792f7729c 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -662,6 +662,113 @@ static void test_seqpacket_timeout_server(const struct test_opts *opts)
 	close(fd);
 }
 
+#define STREAM_RCVTIMEO_DRIP_BYTES	6
+#define STREAM_RCVTIMEO_DRIP_USEC	800000 /* 0.8s, inside the 1s timeout */
+
+/* Keep the data socket open until both sides confirm. The client
+ * writes WAITDONE when recv() returns, but must not close until the
+ * server has finished drip-feeding all 6 bytes and acknowledged;
+ * otherwise later sends hit EPIPE. Failure paths complete the same
+ * handshake so the server is not left in control_expectln("WAITDONE").
+ */
+static void test_stream_timeout_waitall_done(int fd)
+{
+	control_writeln("WAITDONE");
+	control_expectln("SRVDONE");
+	close(fd);
+}
+
+static void test_stream_timeout_waitall_client(const struct test_opts *opts)
+{
+	char buf[STREAM_RCVTIMEO_DRIP_BYTES];
+	time_t read_enter_ns;
+	struct timeval tv;
+	time_t read_ns;
+	int failed = 0;
+	ssize_t n;
+	int fd;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	tv.tv_sec = RCVTIMEO_TIMEOUT_SEC;
+	tv.tv_usec = 0;
+
+	setsockopt_timeval_check(fd, SOL_SOCKET, SO_RCVTIMEO, tv,
+				 "setsockopt(SO_RCVTIMEO)");
+
+	/* Enter recv() before the peer starts drip-feeding, so the first
+	 * byte cannot already be queued.
+	 */
+	control_writeln("CLNSENT");
+
+	read_enter_ns = current_nsec();
+	n = recv(fd, buf, sizeof(buf), MSG_WAITALL);
+	read_ns = current_nsec() - read_enter_ns;
+
+	/* Unfixed kernels restart the full SO_RCVTIMEO after each partial
+	 * read, so this recv() returns 6 bytes after ~4.8s. A cumulative
+	 * 1s timeout returns much sooner; use 2s as the cap so the two
+	 * outcomes cannot be confused.
+	 */
+	if (read_ns >= 2ULL * NSEC_PER_SEC * RCVTIMEO_TIMEOUT_SEC) {
+		fprintf(stderr,
+			"recv(MSG_WAITALL) exceeded SO_RCVTIMEO, %lu ns\n",
+			read_ns);
+		failed = 1;
+	}
+
+	if (n == sizeof(buf)) {
+		fprintf(stderr,
+			"recv(MSG_WAITALL) completed under drip-feed\n");
+		failed = 1;
+	}
+
+	if (n < 0 && errno != EAGAIN) {
+		perror("EAGAIN expected");
+		failed = 1;
+	}
+
+	if (n == 0) {
+		fprintf(stderr, "unexpected EOF on recv(MSG_WAITALL)\n");
+		failed = 1;
+	}
+
+	test_stream_timeout_waitall_done(fd);
+	if (failed)
+		exit(EXIT_FAILURE);
+}
+
+static void test_stream_timeout_waitall_server(const struct test_opts *opts)
+{
+	int fd;
+	int i;
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	control_expectln("CLNSENT");
+
+	/* Drip-feed all 6 bytes even after the client times out, so an
+	 * unfixed kernel still collects a full 6-byte recv and fails.
+	 * The client keeps the data socket open until SRVDONE.
+	 */
+	for (i = 0; i < STREAM_RCVTIMEO_DRIP_BYTES; i++) {
+		timeout_usleep(STREAM_RCVTIMEO_DRIP_USEC);
+		send_byte(fd, 1, 0);
+	}
+
+	control_expectln("WAITDONE");
+	control_writeln("SRVDONE");
+	close(fd);
+}
+
 static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
 {
 	unsigned long long sock_buf_size;
@@ -2739,6 +2846,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_seqpacket_timeout_client,
 		.run_server = test_seqpacket_timeout_server,
 	},
+	{
+		.name = "SOCK_STREAM MSG_WAITALL timeout",
+		.run_client = test_stream_timeout_waitall_client,
+		.run_server = test_stream_timeout_waitall_server,
+	},
 	{
 		.name = "SOCK_SEQPACKET invalid receive buffer",
 		.run_client = test_seqpacket_invalid_rec_buffer_client,
-- 
2.47.3

