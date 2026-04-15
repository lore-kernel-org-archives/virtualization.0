Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476403DC4C2
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265791; cv=none; b=W4lGpI1PwTYf2DHLM85Hpn3sAGhib/93E9CoYvxxQg6a2Ku2z2PQWwwCYUZTXzmSv1kn5nYhCW/l/8NfuUth55o3YNHzByoxcdxA8fhPEWKSpM34Jzlh953aTwYSkKNtfoXjacxxXeGWCWw05UM+qZgsqHRKUCA6wY9FUleJsIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265791; c=relaxed/simple;
	bh=LicrGY4V+zsv5KZ7wlpKw3NN40iL41s8FOtyi0yIhNg=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=VFJDN2Xv8tCDFx1CtCr0DRuqcQ9RLuojzNRFh9W4ZR7DajOAbGwR2ChKGw2aSrsigrw48zM8GYSikDrZsdKIS9QXH7vqo7aOeaUS5R45QwEclL/6k24GgOH5UMUKa/plOUGUF6i/tzSGoRh6EXnlgCsx1BZrunVnu/n3JX9hVI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S3fFHEtE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3fFHEtE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776265789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKxh1xV1gWd+m52UTAHmFCb6N+6HL0A4jah73SCv02s=;
	b=S3fFHEtE8A42CZMyfsNGrmv+tCdJbuOazB9kD1OF3XxKjPOjGRO8vPhVfJI+xYMMAV/SpZ
	2L15eASC8/xvKTe7JYVOY32smSl8Mts44PtlNDoWY3oWZ0W7eFFN9SxXBbUCsyGoYazoUp
	5eHZ8J4HaxrbqyXsjP+FeQtKks3mz8w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-xTXJaHUWNQOP8nz-6a_pHw-1; Wed, 15 Apr 2026 11:09:47 -0400
X-MC-Unique: xTXJaHUWNQOP8nz-6a_pHw-1
X-Mimecast-MFC-AGG-ID: xTXJaHUWNQOP8nz-6a_pHw_1776265786
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d1fec59c9so3664546f8f.0
        for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 08:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776265786; x=1776870586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BKxh1xV1gWd+m52UTAHmFCb6N+6HL0A4jah73SCv02s=;
        b=cvE8GYQ56rWJJuzqY020RVEKCwCJWONBBIQHEihQ4UG8GJvgzlhnEzmfW5ILHTO1Sr
         2WZrUoK2NaplwrTRDzLL7yE9NFrctHtT+D4keOkJbw9rJU6x4kpSn6KjiEyVcHpRaK1U
         nk7vfEJl0rrTMlWBzQ2eY0AhbEaySPO76NLxrCHGv72wS3x1d92xjUugc6U6jKk8gz5d
         /cELA0HQ40OdeWtAPg7SQh7D8E7krFXzXEZxCGdDFdOV8GBbb7fWetnUEe/CCmCAUGTp
         t/5xFtB9FvXBRo6TBoj5QOhrRiu1hoDisiKqt45ziCvYMEi9e5CEXP69ATXajzdg576H
         aBIA==
X-Forwarded-Encrypted: i=1; AFNElJ/YItC8FdMUka/eKE3wF8MftrNb0WLD84gf2jcadY9yRujTnoOb64H5+07KU8Pf0xp365kkX310tXsjakpiFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsE3RLUdOA/PQepVnWfoUpxhcFzM3BilBys1PhPceh5NfLBWSG
	PgEybzlFfNV9/akUS7m7GZMg40CHOnMq439VYYvrRxB/a5ReIJ2cHdDCTwR6EbL09LAI6sMo1SB
	YXLgfAYNUfhXJdSGf2lVJPrxFBkBQk+8+R3Uz/HhUHKah0uaw5FW5XfXJRNSRJZRekEvp
X-Gm-Gg: AeBDietDoYR36maf47in/wJTn5csp7IhZjMqifqsvGv/MCsVMgN5jmSpxs561zn+5sd
	W6KcIb54Z5Z6i+FPzM4pmZey+t0yrEesgpLdI9Ns+nbKQE4oq+/RRGSzsiBugSS4oi7q2txSbBI
	euIOyWSwr3qOMh1ZKFROGpQ1Xe9gDQWI8OGDnjQtbfG8LcIDZ7XEHAnJC+iJmfor/2FJABnthUx
	uxjOq5HEEplMIIqM/K8nQG6DBO87cj4pTGatt2n9mObRvu2aDb2kbBnItlmZOBKROoRpZ8tkaCa
	YmwQ7hKhGyJhJQwg1eVL7dEEFfvrLgsyjV3Cypwl/tDA91wA/P+m+jM//kWl1YX+35R2iUkFI8Q
	0wooB/do6rr8phrKFQtszGjpr2XSie/BPn+mIE62Vtvy03zhFzjpHcX868WGo
X-Received: by 2002:a05:6000:2a84:b0:43d:7a5e:8162 with SMTP id ffacd0b85a97d-43d7a5e8360mr12790595f8f.15.1776265785734;
        Wed, 15 Apr 2026 08:09:45 -0700 (PDT)
X-Received: by 2002:a05:6000:2a84:b0:43d:7a5e:8162 with SMTP id ffacd0b85a97d-43d7a5e8360mr12790549f8f.15.1776265785199;
        Wed, 15 Apr 2026 08:09:45 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead35bf1esm5907557f8f.16.2026.04.15.08.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:09:43 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 15 Apr 2026 17:09:30 +0200
Subject: [PATCH net v4 3/3] vsock/test: add MSG_PEEK after partial recv
 test
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260415-fix_peek-v4-3-8207e872759e@redhat.com>
References: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
In-Reply-To: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
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
X-Mimecast-MFC-PROC-ID: oUJnSPkFJsrTip5FQ2BSUnbvWquWOmXbG3IngaGCqMg_1776265786
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
peek the whole buffer content. The test re-uses
`test_stream_msg_peek_client()` to also cover this scenario.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index bdb0754965df..76be0e4a7f0e 100644
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
+	/* Peek with a buffer larger than the remaining data */
+	recv_buf(fd, buf_peek, sizeof(buf_peek), MSG_PEEK, sizeof(buf_peek) - 1);
+
+	/* Consume the remaining data */
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

