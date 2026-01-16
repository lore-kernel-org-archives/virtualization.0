Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50393A4ACC
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594546; cv=none; b=dMM3kszy9srE49wkIlhhWx9dPrVMg0OHp7Qg1VWB2HbewzcxnvvYuMkWrmqLAwOqVTNSlEqvZ/TjiasksD4rmuAcd+CFPkbnlcsA47QVLTvcI5q2CiRZVYLet7jQVDWPQZBCHhImEk5zGImqgk/fz5Dj1li9Or0+J68gTI6wR8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594546; c=relaxed/simple;
	bh=SoO7meievLXiEt+HOkmT+4mC7UVVo+dr6edO43jcmvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Nr02GeCeV2u+TQ1E9YExmIQyLz4Wm7CrYZLbVsmklFt7D5twMnCXONhW4uhbrBI0RxwbXuWaLlIdRHdMDH+9uvSo4XvotYB6n0k6Ew/lqWveZeY6/SQZi6fv4XWNbNxNjuwQuI8Nop+VDpaOKvVkt1S5NIerP8ziFGrS8UJ9iAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNCx/fBv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNCx/fBv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768594542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IeRZ4N2lg6mPjyH8cqV8u8lDtZLcsrjhMu6bgHYQOx8=;
	b=eNCx/fBvXUxgdopDtfJDBuFKCFzlnFd/Tk8SKoe+HRQeUDFSd1FRiv+gf0ePnAZkQT2g/j
	jXJP3Ir9Ha9csUt+MqxRRO/Og+j48L6FksNSMc2xVL3eAw/1FUx7xYp104y8GhZFP8sb6b
	aPVhpD8ovil1pxQiTmqWgmhiCNesltg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-WZL_QLFaPHyuuCzXCF00Uw-1; Fri, 16 Jan 2026 15:15:41 -0500
X-MC-Unique: WZL_QLFaPHyuuCzXCF00Uw-1
X-Mimecast-MFC-AGG-ID: WZL_QLFaPHyuuCzXCF00Uw_1768594540
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47ee9a53e8fso14282275e9.0
        for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 12:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768594540; x=1769199340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IeRZ4N2lg6mPjyH8cqV8u8lDtZLcsrjhMu6bgHYQOx8=;
        b=tDu3ArSFIlv2+4sIgXo11IxRlJbtmqkxmSPUhGD5Y6ok7VIebUSpExlMkqXpyVxYkn
         erjaa1V2N6bkjAZDFAt1YgOW5Nn0orc8Haf3pFsaz6dDg4E9dODx2+HD4SlTC5lDAYUQ
         pba7iriQIk6X6xdPUvF8TBY3K8V979vKqlzlPMxARvT1qGmAT/yIeEnZPmC65/vZ9X5H
         IEoQioFJZueJlvFiqP1uKnqAGQAbfCw8W6z59nRnoTPs7A+PO9pGoSZ3Aw6kbURI4OlZ
         pYHyHTuXnYCpIEnmnF3CrU7KLr05bXITermcL1xoJmuKfsvmknhUd1J6VeqqPZSvsXIz
         Vm5w==
X-Gm-Message-State: AOJu0Yzs1uL26J+qbn9DGIvUfmbPQexUcZqos4zJsEu3XqOCA6U6fBkG
	kWmJQDfyYP3D1c+UtBRe4SfzC7i7Z3ZmFJl4vGgfAHpUKyN7iLRr1kADAy1v5brClg+UWogRuB7
	S/Nzk7ILdIK7d/mrXEqAhOf9kbCJlXfJT5XdBlvBpPhrXhNYGAbpFdTC6g+Ct5/9G3k9n
X-Gm-Gg: AY/fxX6Faqa1BDiWb8mz5lO7lW0XWvX0KUn9/ahcKUxs3wQ1JRt1yV+MwPyWHvh0Sxi
	CeO8T16/14AjZQDd57oVjeFOtxr7KIdU9xuuBd1wQjj7+lBCgI1ORd7uaxGzt/IRjYb+1w/C6BH
	yhSppLVO3EeoTMUWtiGhQ8ow54BWaSXGFDQB1IGztByfqEGmSJmzRYXYn6dqEp4xcWDmnzgJ/LH
	BfesdMd/7skj15SUYj27Wc+edWFfnLWbWvUNzM8esrTouwMspgPUyjGu6KcHVLXPsOmch7a0Mqj
	mSJyXqwNobSw8FG8IASVKN44AQ59A3Rxu+XffckuHgs0SRkzHe4hwBiZErSqEtVQAtgs/BUrAND
	Df4xVcfFZDLVyh1iexDwB8xA9rsuNJFbSKnPRZzxZOD53pAg0ZdXXu5oviSqf
X-Received: by 2002:a05:600c:4e93:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-4801eb09274mr39557035e9.19.1768594540389;
        Fri, 16 Jan 2026 12:15:40 -0800 (PST)
X-Received: by 2002:a05:600c:4e93:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-4801eb09274mr39556825e9.19.1768594539909;
        Fri, 16 Jan 2026 12:15:39 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801ea09747sm24213175e9.7.2026.01.16.12.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:15:38 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Asias He <asias@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH RESEND net v5 4/4] vsock/test: add stream TX credit bounds test
Date: Fri, 16 Jan 2026 21:15:17 +0100
Message-ID: <20260116201517.273302-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116201517.273302-1-sgarzare@redhat.com>
References: <20260116201517.273302-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ICvE--gF5Oa_UEOG3L5EDTOSN4QphH5CU1YNEdpyxvA_1768594540
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Melbin K Mathew <mlbnkm1@gmail.com>

Add a regression test for the TX credit bounds fix. The test verifies
that a sender with a small local buffer size cannot queue excessive
data even when the peer advertises a large receive buffer.

The client:
  - Sets a small buffer size (64 KiB)
  - Connects to server (which advertises 2 MiB buffer)
  - Sends in non-blocking mode until EAGAIN
  - Verifies total queued data is bounded

This guards against the original vulnerability where a remote peer
could cause unbounded kernel memory allocation by advertising a large
buffer and reading slowly.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
[Stefano: use sock_buf_size to check the bytes sent + small fixes]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 101 +++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index ad1eea0f5ab8..6933f986ef2a 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -347,6 +347,7 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 }
 
 #define SOCK_BUF_SIZE (2 * 1024 * 1024)
+#define SOCK_BUF_SIZE_SMALL (64 * 1024)
 #define MAX_MSG_PAGES 4
 
 static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
@@ -2230,6 +2231,101 @@ static void test_stream_accepted_setsockopt_server(const struct test_opts *opts)
 	close(fd);
 }
 
+static void test_stream_tx_credit_bounds_client(const struct test_opts *opts)
+{
+	unsigned long long sock_buf_size;
+	size_t total = 0;
+	char buf[4096];
+	int fd;
+
+	memset(buf, 'A', sizeof(buf));
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	sock_buf_size = SOCK_BUF_SIZE_SMALL;
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
+
+	if (fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) | O_NONBLOCK) < 0) {
+		perror("fcntl(F_SETFL)");
+		exit(EXIT_FAILURE);
+	}
+
+	control_expectln("SRVREADY");
+
+	for (;;) {
+		ssize_t sent = send(fd, buf, sizeof(buf), 0);
+
+		if (sent == 0) {
+			fprintf(stderr, "unexpected EOF while sending bytes\n");
+			exit(EXIT_FAILURE);
+		}
+
+		if (sent < 0) {
+			if (errno == EINTR)
+				continue;
+
+			if (errno == EAGAIN || errno == EWOULDBLOCK)
+				break;
+
+			perror("send");
+			exit(EXIT_FAILURE);
+		}
+
+		total += sent;
+	}
+
+	control_writeln("CLIDONE");
+	close(fd);
+
+	/* We should not be able to send more bytes than the value set as
+	 * local buffer size.
+	 */
+	if (total > sock_buf_size) {
+		fprintf(stderr,
+			"TX credit too large: queued %zu bytes (expected <= %llu)\n",
+			total, sock_buf_size);
+		exit(EXIT_FAILURE);
+	}
+}
+
+static void test_stream_tx_credit_bounds_server(const struct test_opts *opts)
+{
+	unsigned long long sock_buf_size;
+	int fd;
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	sock_buf_size = SOCK_BUF_SIZE;
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
+
+	control_writeln("SRVREADY");
+	control_expectln("CLIDONE");
+
+	close(fd);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -2414,6 +2510,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_accepted_setsockopt_client,
 		.run_server = test_stream_accepted_setsockopt_server,
 	},
+	{
+		.name = "SOCK_STREAM TX credit bounds",
+		.run_client = test_stream_tx_credit_bounds_client,
+		.run_server = test_stream_tx_credit_bounds_server,
+	},
 	{},
 };
 
-- 
2.52.0

