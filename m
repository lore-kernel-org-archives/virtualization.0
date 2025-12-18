Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E63230B51A
	for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766051270; cv=none; b=FYOCi5mQTzdXHSPyTA8d9DKyQ+cyeFg0Vli46v1W4TepIHAKGInjSR2hdIjCsTID2Tbqxd+j1Bx2nJDHq7GcqmKYpxiur7HHWXGIxvx9YZZw+Pt8aA3q8pjB1oLNINn6YDD/5uNDA7nM2ncXknno9+TlDjT56A4Ith89dv47N6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766051270; c=relaxed/simple;
	bh=to2eeWM8ngJq0ie1W1Pn6uqxr8LR35+DjQk3tPBicMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AQGtbdErznrBMICFM5BMS5kfmvMpM67fmCTLd/h2w7tj0m4o48WSez4J5OnwX23GLUOLajiPhUmW1/GICv5tUW8cbnAx4b8uv4pOZlmskpgeZT7bBDkOeQQACuTyX8NY+gd3viL3xW1ACJ3vPs5kP49YNZ/7ty23XseV/FAfc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GRtXRlt1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRtXRlt1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766051267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ha5qM5XeJSqkOafL9yYIppX28PYIQ3jEighrNXdvbo=;
	b=GRtXRlt1DxCfo6XQxqsSKXWPdOtAOhjS4Ex2UPSEC63Pu7ah+v+6FWyFJOB0UivqOkfNHy
	qcq7MlnMe6SE23XhdxBxgQV84ijsMNAjAQkOJlnrupwFrWr2tg29xE0YJNE7NMb+oVIW5e
	jyJ7w+S+TQDMzwSOfE3Of815/Cm4Wts=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-oqlKi5U1NZCwAf_wlWmr0Q-1; Thu, 18 Dec 2025 04:47:45 -0500
X-MC-Unique: oqlKi5U1NZCwAf_wlWmr0Q-1
X-Mimecast-MFC-AGG-ID: oqlKi5U1NZCwAf_wlWmr0Q_1766051265
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b7a7049e202so50186566b.1
        for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 01:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766051264; x=1766656064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ha5qM5XeJSqkOafL9yYIppX28PYIQ3jEighrNXdvbo=;
        b=xOryvLl8Eks+Ay+5PiUwiCRraynOp/xIN/pwLlEHNGykkGMhYjGFp8+OfBaZUgCxnm
         OSY4NeQn4q9yecIz8Mkc32LBKISePzKWTOYgT5I8eFp4DQ8O3REsNKQ5shLpZwLDMwn5
         ICBlJaMyvyunT5pFM63NJRHq8wzGjCkBPzghaHt3wSPrJ2XTaiosgED8ZVV0/5ihP5Se
         eQH5BNNdYHr69fbuvg/Gs/PVCjsRXV0QoGgOGg0ElUvYWPVviPn9cSp8JhgkojC4qFc2
         EcArvBcpk8RMLz4aaEoEYGTRaTbiEzZFuV/RtndB+Swyh2Wubvwz5fVkeS+0N0wCKgIb
         lNiA==
X-Forwarded-Encrypted: i=1; AJvYcCUrPzCBB/GCRJNDIu/3Mllah8dekzbxtuMUBq0St7l8/RWG2S9emhKbjOeH14F9HBNPwuwRemw35OP+dG8AkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YztO6/dV8SYrnCCx/+aSQTtaR6PUobm+oyBZiOiXCzLlMnAqpIM
	VYjIRu9Y+7ITY3p8uDNYBh2yyK1YgnhphzGUlnGc8pvVmQlgmNFaSSme36THyA+vt3aE2i7NzIG
	CTHwaTJKTLV6wtQDvg8q7wrxrJoEAE5HjxZX42YrEOhSpvUr+XFtugufPnheo7/MKGOsl
X-Gm-Gg: AY/fxX5ppF1WOciuoxTwO9Ls+4URnzgwNY5+at6HiU6UMsGQsebXA5ZJY6YcllhSU9T
	CUrPin/FsqfKADMp7UrKl6xZNUQv/VfJ6O3zUdHYBmR2gqU2TS3EHEf6qcanJ4//PEBSzIvf1j3
	bmV9vbUSb+068ImuVb6QdzQIAAPhkVIHbXz8y9jhanAyFF57JIhr5OfWVrlMxnfIhyb6f6dJzeU
	JqQ8ga/LUrPIOZFMtKU+U3yGpkWC3jQykRPYcKWxWx/vsjX75mEArUzLPS3NEv0ypn7pQvMINR2
	P7S6I55AedoCiq3A7JZBGrTFeLa2Q3FyljExYshJAKSaVX/fksxDszG+90cHbm6iPzrb26f/TG9
	UBLICserkxRcdX/Q=
X-Received: by 2002:a17:907:7213:b0:b73:7c3e:e17c with SMTP id a640c23a62f3a-b7d23a1c75dmr2253184166b.44.1766051264497;
        Thu, 18 Dec 2025 01:47:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeRtf141WERtGc9q8wsZHSiDYrGGvPHvPunOfHx7fqtpGGAw2i6oJ8jd6f+UF+jIGp/dMRcw==
X-Received: by 2002:a17:907:7213:b0:b73:7c3e:e17c with SMTP id a640c23a62f3a-b7d23a1c75dmr2253181266b.44.1766051263854;
        Thu, 18 Dec 2025 01:47:43 -0800 (PST)
Received: from sgarzare-redhat ([193.207.200.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b80234a2fa2sm173611566b.55.2025.12.18.01.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 01:47:43 -0800 (PST)
Date: Thu, 18 Dec 2025 10:45:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Subject: Re: [PATCH net v4 4/4] vsock/test: add stream TX credit bounds test
Message-ID: <fyuxxdc4rgop73kkevef5gfujgac3f3we5mii4bpoznonlr3nn@6mjpi5df3dlg>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
 <20251217181206.3681159-5-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251217181206.3681159-5-mlbnkm1@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y4Yyls0QJQQqIsBOajSVxOEOyPm5jVhrCk5SWDa1oE4_1766051265
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Dec 17, 2025 at 07:12:06PM +0100, Melbin K Mathew wrote:
>Add a regression test for the TX credit bounds fix. The test verifies
>that a sender with a small local buffer size cannot queue excessive
>data even when the peer advertises a large receive buffer.
>
>The client:
>  - Sets a small buffer size (64 KiB)
>  - Connects to server (which advertises 2 MiB buffer)
>  - Sends in non-blocking mode until EAGAIN
>  - Verifies total queued data is bounded
>
>This guards against the original vulnerability where a remote peer
>could cause unbounded kernel memory allocation by advertising a large
>buffer and reading slowly.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
>---
> tools/testing/vsock/vsock_test.c | 103 +++++++++++++++++++++++++++++++
> 1 file changed, 103 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 0e8e173dfbdc..9f4598ee45f9 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -347,6 +347,7 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
> }
>
> #define SOCK_BUF_SIZE (2 * 1024 * 1024)
>+#define SMALL_SOCK_BUF_SIZE (64 * 1024ULL)
> #define MAX_MSG_PAGES 4
>
> static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>@@ -2203,6 +2204,103 @@ static void test_stream_nolinger_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void test_stream_tx_credit_bounds_client(const struct test_opts *opts)
>+{
>+	unsigned long long sock_buf_size;
>+	char buf[4096];
>+	size_t total = 0;
>+	ssize_t sent;
>+	int fd;
>+	int flags;
>+
>+	memset(buf, 'A', sizeof(buf));
>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	sock_buf_size = SMALL_SOCK_BUF_SIZE;
>+
>+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>+			     sock_buf_size,
>+			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
>+
>+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>+			     sock_buf_size,
>+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>+
>+	flags = fcntl(fd, F_GETFL);
>+	if (flags < 0) {
>+		perror("fcntl(F_GETFL)");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (fcntl(fd, F_SETFL, flags | O_NONBLOCK) < 0) {
>+		perror("fcntl(F_SETFL)");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("SRVREADY");
>+
>+	for (;;) {
>+		sent = send(fd, buf, sizeof(buf), 0);
>+		if (sent > 0) {
>+			total += sent;
>+			continue;
>+		}

This is confusing IMO, also perror() when `sent == 0` is not right.
What about this:

		sent = send(fd, buf, sizeof(buf), 0);
		if (sent == 0) {
			fprintf(stderr, "unexpected EOF while sending bytes\n");
			exit(EXIT_FAILURE);
		}

		if (sent < 0) {
			if (errno == EAGAIN || errno == EWOULDBLOCK)
				break

			perror("send");
			exit(EXIT_FAILURE);
		}

		total += sent;

>+		if (sent < 0 && (errno == EAGAIN || errno == EWOULDBLOCK))
>+			break;
>+
>+		perror("send");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/*
>+	 * With TX credit bounded by local buffer size, sending should
>+	 * stall quickly. Allow some overhead but fail if we queued an
>+	 * unreasonable amount.
>+	 */
>+	if (total > (size_t)(SMALL_SOCK_BUF_SIZE * 4)) {

Why "* 4" ?

>+		fprintf(stderr,
>+			"TX credit too large: queued %zu bytes (expected <= %llu)\n",
>+			total, (unsigned long long)(SMALL_SOCK_BUF_SIZE * 4));
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("CLIDONE");

This can be moved after the for loop.

>+	close(fd);
>+}
>+
>+static void test_stream_tx_credit_bounds_server(const struct test_opts *opts)
>+{
>+	unsigned long long sock_buf_size;
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Server advertises large buffer; client should still be bounded */
>+	sock_buf_size = SOCK_BUF_SIZE;
>+
>+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>+			     sock_buf_size,
>+			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
>+
>+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>+			     sock_buf_size,
>+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>+
>+	control_writeln("SRVREADY");
>+	control_expectln("CLIDONE");
>+
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -2382,6 +2480,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_unread_bytes_client,
> 		.run_server = test_seqpacket_unread_bytes_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM TX credit bounds",
>+		.run_client = test_stream_tx_credit_bounds_client,
>+		.run_server = test_stream_tx_credit_bounds_server,
>+	},
> 	{},
> };
>
>-- 
>2.34.1
>

