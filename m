Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FDD3ED5B9
	for <virtualization@lists.linux.dev>; Tue, 14 Apr 2026 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183035; cv=none; b=birvqa3U8sTrZ6ETOFBafFFzIzj/xHox4B++litt9OApJJnfZlJsuCo/RWQotwM0SHqTokDOtg32iXjeLBoVw6e4OCuAlO8pXlTTFKPNViFXq0e1WxXTLscEj0HdKFGKj/4zpYHIj+vNLm0j2m6/f5YQk2YOvqVNXm0VC/orC+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183035; c=relaxed/simple;
	bh=jtcpbJn9RIdJlr0hVO963zpJX/82bBkk/hi4mZSImLE=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=Ho0QJpyV5Jf9duBe6wdcvPeD6yBCN/sMW9GQW4WmzF3mDwD7EebK17f4yQnYS9G1bJ+KsViy6u5/uD/D8d/FgPLBQxMcYguogJWmfvcs8iSxs/CLX8+eaWEDANZROxgFu9qCUWdN8T0v/GEEK+snBcNITHxnIpmlzsgBp0arCRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IfJpM3Z6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfJpM3Z6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776183033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4qpSiwLjabUf/q5/q3aDN7iNzObMaLZodRYuDBTSlw=;
	b=IfJpM3Z6c/IGzEMMDyAXfi0zdZY7iL9yZ8eUjMJnnLweWNipFzMCCy+VWWLf/oCci5ftX1
	YeHNxDSoLSy3HlP6LsA1abeHb89NDszDMrhNvubs4LJ0eO39DqGZ/3pjxibbI4vFUqtLkx
	7HN7DiqmNGgFo4WSzaBqKmxhoKELxyw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-kxlJUT7xMXCKIfHc_HA7Vg-1; Tue, 14 Apr 2026 12:10:30 -0400
X-MC-Unique: kxlJUT7xMXCKIfHc_HA7Vg-1
X-Mimecast-MFC-AGG-ID: kxlJUT7xMXCKIfHc_HA7Vg_1776183029
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d7d0947aeso961878f8f.3
        for <virtualization@lists.linux.dev>; Tue, 14 Apr 2026 09:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776183029; x=1776787829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T4qpSiwLjabUf/q5/q3aDN7iNzObMaLZodRYuDBTSlw=;
        b=LbgYt0g0jhUEMMuu4VjldEXmgSufewJSBwApr6hsT+lOj5YbMhgk1haLBBn33lIpum
         05i/6/adV+D5sWl5CTu6lpzg27fBtSu98iGc1C6CimJb/HEa6ycsc8OgmdkRLiBAisdB
         aGJLcAo/kIBjlUtdVGfxaZq5PLSan+4OzApgEMVbIky2ysjdZEw2gtNM6AZ/TxRPlUGa
         H6t+ak85Q6aswUD54H9mbvbhIifzQh258eY9vDYb5P6nxmr37a41tjKVBzF9Pl4iR0w/
         U7KynNTmAX+QQ061sJiWX8z25oi4MAAVg+QcGm3i90ZRa5q3V5B3DlVe7IJSWhzSOVmp
         jzhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+b0bSsBlWx9iqgOpryOv8GBcVdfnoj5eMFwiRFCMgQ+h24nSnxt2lZOsVfq4+inW+6guK875GD0GllEGHeFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxacEb2BUZqS1dJulPcIbjw2PMbUuEeCHwCbYO3UT+/N+XP6SIM
	L5kqgMhyEJs3DFS882+O+xPF7/om0L+1keGD9pMZ5x0BXyzVNMr7X/gW8gC7bxfP2FbMZ2ATzlW
	1iER+Ex8/QkKJ34Nsri/7bPr6GcF8IitggUDxRCSffj+09ONOhEEAgeyCWQqKNA8Qpli0
X-Gm-Gg: AeBDieu5XKMDkTD5Zi/xz6EEgPNXt17GGRlFNUACdmj4uRpP/itlOV+Xd1dm6zxR5MH
	JZpQUCMdw8WtDBGxvzu+MAs7pF57w6SMTv8P4qeiW9HC/30oj5JgI6oxkk1OLXti11JUhYv+rLE
	tNzA4uZ4ftu39MDqvXIvWGLzxrxZ7pUPKqX3NP9DOPjXOnMuZsYplDEMBbOqR83vXhPMqjDT09t
	BCbiZWNPvad7//wvv25WH9+1Xm3u4XSLlAcgf/0Prk4XZ16tbzwRha5jgxOFLxgTgZYhekhjwZT
	7vyCt2Hztubue68FD71HlaD/VMsmtSjNYK/J9d9i1Bkw8XIivBmxQYoT5MERMqrz2J0Nq2T7+W4
	ubgsxOlzPki1utxLBgVfQjf5itwQ7mBdt3rhTVT6rh4cQeS/deMUxZjxgka6c
X-Received: by 2002:a05:6000:1ac5:b0:43c:fa96:d939 with SMTP id ffacd0b85a97d-43d6429c737mr27847303f8f.22.1776183029356;
        Tue, 14 Apr 2026 09:10:29 -0700 (PDT)
X-Received: by 2002:a05:6000:1ac5:b0:43c:fa96:d939 with SMTP id ffacd0b85a97d-43d6429c737mr27847250f8f.22.1776183028882;
        Tue, 14 Apr 2026 09:10:28 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec090sm43035268f8f.12.2026.04.14.09.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:10:28 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 14 Apr 2026 18:10:23 +0200
Subject: [PATCH net v3 3/3] vsock/test: add MSG_PEEK after partial recv
 test
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260414-fix_peek-v3-3-e7daead49f83@redhat.com>
References: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
In-Reply-To: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AJqY-PVe_yRTpTvELhWp6Aq1EPchxqz-l-Pq6JWcBYY_1776183029
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add a test that verifies MSG_PEEK works correctly after a partial
recv().

This is to test a bug that was present in the
`virtio_transport_stream_do_peek()` when computing the number of bytes to
copy: After a partial read, the peek function didn't take into
consideration the number of bytes that were already read. So peeking the
whole buffer would cause an out-of-bounds read, that resulted in a -EFAULT.

This test does exactly this: do a partial recv on a buffer, then try to
peek the whole buffer content.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index bdb0754965df..ab387a13f0ae 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -346,6 +346,38 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 	return test_msg_peek_server(opts, false);
 }
 
+static void test_stream_peek_after_recv_server(const struct test_opts *opts)
+{
+	unsigned char buf_normal[MSG_PEEK_BUF_LEN];
+	unsigned char buf_peek[MSG_PEEK_BUF_LEN];
+	int fd;
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	control_writeln("SRVREADY");
+
+	/* Partial recv to advance offset within the skb */
+	recv_buf(fd, buf_normal, 1, 0, 1);
+
+	/* Ask more bytes than available */
+	recv_buf(fd, buf_peek, sizeof(buf_peek), MSG_PEEK, sizeof(buf_peek) - 1);
+
+	/* Recv rest of the data */
+	recv_buf(fd, buf_normal, sizeof(buf_normal) - 1, 0, sizeof(buf_normal) - 1);
+
+	/* Compare full peek and normal read. */
+	if (memcmp(buf_peek, buf_normal, sizeof(buf_peek) - 1)) {
+		fprintf(stderr, "Full peek data mismatch\n");
+		exit(EXIT_FAILURE);
+	}
+
+	close(fd);
+}
+
 #define SOCK_BUF_SIZE (2 * 1024 * 1024)
 #define SOCK_BUF_SIZE_SMALL (64 * 1024)
 #define MAX_MSG_PAGES 4
@@ -2509,6 +2541,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_tx_credit_bounds_client,
 		.run_server = test_stream_tx_credit_bounds_server,
 	},
+	{
+		.name = "SOCK_STREAM MSG_PEEK after partial recv",
+		.run_client = test_stream_msg_peek_client,
+		.run_server = test_stream_peek_after_recv_server,
+	},
 	{},
 };
 

-- 
2.53.0

