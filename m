Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039DF3A1697
	for <virtualization@lists.linux.dev>; Thu,  2 Apr 2026 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775117892; cv=none; b=HhH84xQ8vxjBANsAjsCvTsGY1TxiJIHS2FeOPQSrp92NrWqgfkddQPAaNFUTXYBM+JOa09nunKECUzpFmbCG/za0n4sthU4vM5Yz+cUTklNY70VJdQ4GRlvYQVu2dR8fGwLPcOrGaA10S2q2QlwsaakDdmGRFw5WL3KHJX5cS5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775117892; c=relaxed/simple;
	bh=NzXbQuc9ZBk4ObBGtzGs9iu2lFssJbUQBjuKFCUY22k=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=AyEloQ/ZChNz6JBf8fiv34Uso08/B8EWyh20hM5bMzyccA03yOVT9g73SkFpntLnd97ysBQRu67Hj9WCYSTnQKGIMATOUpMVxmcWev74JMNUnRLyPBPAYpbF3FwjA6bP0a+rUTh0trrnhGxp0X8td4C1ZoYLQTdYua/rTqG/fDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ee+ShTDa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ee+ShTDa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775117890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eDGMK8W32A9IJKOzV8D749M8i2eS/0zQjVDT1eVv+dU=;
	b=ee+ShTDaotIHVZmwm7wMtTBxWonWx9v8oqeRfbeMg5CHi/wOC2VTr7OJ2UeGr8lCU+scN5
	a73bM09TEh5cvBzFSnGpnbZKPaKvg+9oNL3FxNQ5PZa9MiXsv3mKXpLDkU97hdKSqUHPJK
	hrT5fQ75II2RGoHK1wSORNvECzsPtBg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-cs6DLmBiNEeDju2B9l3Q1A-1; Thu, 02 Apr 2026 04:18:09 -0400
X-MC-Unique: cs6DLmBiNEeDju2B9l3Q1A-1
X-Mimecast-MFC-AGG-ID: cs6DLmBiNEeDju2B9l3Q1A_1775117888
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-486fc42c83aso4967515e9.0
        for <virtualization@lists.linux.dev>; Thu, 02 Apr 2026 01:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775117888; x=1775722688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eDGMK8W32A9IJKOzV8D749M8i2eS/0zQjVDT1eVv+dU=;
        b=HKyRK3B5OjrQ7c6s21gU5FZ1aTi+fqXzf300U2GNrqU97eQIaIG7U/lgXekfWuxb7q
         SLdyfoJVia8KY+78k+Pujc401f7z1c8stq0kbnpVmYVXDNKVk8vNarXGcMK0XFvQw8Q9
         QBD8/WOpEJGK8N5k7neN7sXBzOCa6g9lLo5Hm5XsGNPhrDjPRgtpIRtBfvXh523Ph/ye
         PimJj+HfAnlRRU4jx87xkXGtu6na7sQyAaNPJTkX9iiLDrGMzx1DqrJLkhBIMrVzAWAe
         Roc9aA2LHUQ1RAT3ONr+xmEcQvGDij4V0lKNSbzhJVv2+Ih6z4i2urewy4xtTCnj6jHw
         BedA==
X-Forwarded-Encrypted: i=1; AJvYcCW3PGwYMghb3V9h1jckkyCo7cUy6jKEgMYwYvI7HMvM6drfMWfOtjepFM4RFt1WqkBPzzLcvKB/AOXqywOliA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdRDSUvtF252wUzWTd2Ya2VRKC8s61R5BKR11ZU1IWMp+PLuz5
	gIameUle/2LEoDI5RIszhOUE972f0SSSUcwUG279y+SDr5oz7WgKWYS/gqHCqBt8ZhZZck0Sajs
	jzdIY9wLvZvv/w75zbBMVcBYdzV8TUS/LbWAwqwrOIkHduKL/8N2K4Oo+84zdpaXmAScl
X-Gm-Gg: ATEYQzyRi3Rz6gILkNxaq0ekO4VW5esNTYfKGHwfpvluKnAOnri0Pl14MDWzni8gluj
	jxM5upz0jnkBxhHR58IVbbjgSq06NR/pO8QS9lAlovsDihQxICUCdTy2B6TQFudVrGnfuaPwUyO
	MiovOXsPqurVw0fJW9/ACeGM/e/NAy0M1QZ9o3ZQr5dI1rd62x5OqRgVMSy5JgwxQ+DHxBBSpW8
	wW7J/Lcz2ialVG4MinRhhG1dl6GFkqFAXo3aWv10dpxcJdfwFIrBx/UYg2KVKn3K7TnoxsbcwGO
	F+p1+QQORbdfz0GRGTu5q2iRr7w3Cgkt386yuoKoptkj06bc5WJAZ41f2FtROcKT7ywo3bPo8Du
	zlWMVy0OQuyz90XeEL2o0OqRibDN05+xCQJSaU5cxzlBF/8GE6A40tzTdi3LV
X-Received: by 2002:a05:600c:8184:b0:483:9139:4c1d with SMTP id 5b1f17b1804b1-48883590456mr113866095e9.14.1775117887555;
        Thu, 02 Apr 2026 01:18:07 -0700 (PDT)
X-Received: by 2002:a05:600c:8184:b0:483:9139:4c1d with SMTP id 5b1f17b1804b1-48883590456mr113865405e9.14.1775117887065;
        Thu, 02 Apr 2026 01:18:07 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e735532sm214476005e9.0.2026.04.02.01.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:18:06 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Thu, 02 Apr 2026 10:18:02 +0200
Subject: [PATCH net 2/2] vsock/test: add MSG_PEEK after partial recv test
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260402-fix_peek-v1-2-ad274fcef77b@redhat.com>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
In-Reply-To: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
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
X-Mailer: b4 0.14.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p6SNJ5T8rt_7p2cizpn8miq1e4oNoVj1F98geHiklIQ_1775117888
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add a test that verifies MSG_PEEK works correctly after a partial
recv().

This is to test a bug that was present in the `virtio_transport_stream_do_peek()`
when computing the number of bytes to copy: After a partial read, the
peek function didn't take into consideration the number of bytes that
were already read. So peeking the whole buffer would cause a out-of-bounds read,
that resulted in a -EFAULT.

This test does exactly this: do a partial recv on a buffer, then try to
peek the whole buffer content.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 64 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 5bd20ccd9335caafe68e8b7a5d02a4deb3d2deec..308f9f8f30d22bec5aaa282356e400d8438fe321 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -346,6 +346,65 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 	return test_msg_peek_server(opts, false);
 }
 
+#define PEEK_AFTER_RECV_LEN 100
+
+static void test_stream_peek_after_recv_client(const struct test_opts *opts)
+{
+	unsigned char buf[PEEK_AFTER_RECV_LEN];
+	int fd;
+	int i;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	for (i = 0; i < sizeof(buf); i++)
+		buf[i] = (unsigned char)i;
+
+	control_expectln("SRVREADY");
+
+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
+
+	close(fd);
+}
+
+static void test_stream_peek_after_recv_server(const struct test_opts *opts)
+{
+	unsigned char buf[PEEK_AFTER_RECV_LEN];
+	int half = PEEK_AFTER_RECV_LEN / 2;
+	ssize_t ret;
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
+	recv_buf(fd, buf, half, 0, half);
+
+	/* Try to peek more than what remains: should return only 'half'
+	 * bytes. Note: we can't use recv_buf() because it loops until
+	 * all requested bytes are returned.
+	 */
+	ret = recv(fd, buf, sizeof(buf), MSG_PEEK);
+	if (ret < 0) {
+		perror("recv");
+		exit(EXIT_FAILURE);
+	} else if (ret != half) {
+		fprintf(stderr, "MSG_PEEK after partial recv returned %d (expected %d)\n",
+			ret, half);
+		exit(EXIT_FAILURE);
+	}
+
+	close(fd);
+}
+
 #define SOCK_BUF_SIZE (2 * 1024 * 1024)
 #define SOCK_BUF_SIZE_SMALL (64 * 1024)
 #define MAX_MSG_PAGES 4
@@ -2520,6 +2579,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_tx_credit_bounds_client,
 		.run_server = test_stream_tx_credit_bounds_server,
 	},
+	{
+		.name = "SOCK_STREAM MSG_PEEK after partial recv",
+		.run_client = test_stream_peek_after_recv_client,
+		.run_server = test_stream_peek_after_recv_server,
+	},
 	{},
 };
 

-- 
2.53.0

