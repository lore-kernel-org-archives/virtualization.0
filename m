Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5C08120C
	for <virtualization@lists.linux.dev>; Wed,  8 May 2024 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162914; cv=none; b=uc6+Yb0ZI6i2zyoeqGNRw/ycuclbnSc1qxl7YH4Ruk4x1/l77OxtQvSjgvmS/QT7++N9hCg/xAA5TW5b51TtdTzE1HRsNN433vkPvpOFEuYuq7ckUXUKf4e8u6fH+LgRF1hcPLkaV2qrq8Bjg+NX2fTkP3O/2v+qaHR3mXfxFVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162914; c=relaxed/simple;
	bh=fi5pC29LO2MTYzLsdcgBABcp9yab2yR9OaBiP6QzX5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RXcKj+zUDl5NyjzXZeYb9BDn7wDJlr5ILr6rxhbeJQgU8GGTxOotv8Zi0yNpVeSFIS6iF1boZNLXnLacm6C/NX8y9Zt5o1hm6MNGZbm5V4s3UHrZTPCQLg5XkMXCQoNGKt8pKpg8Nsowlw7o1WPlTt46jfHaIQjz9tamYA+mMnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K3Z6O0rn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3Z6O0rn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715162911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNHp8YfOUWVmU5olVJkx6F71bvtRkNzxWX8Xu+Hbano=;
	b=K3Z6O0rnx6QKrg1n4p7Ar+gCBs4mlrpfa85EAq2ACcG9JfZBTCjTi0f+gEDbPd5fhPO7ux
	mzpcf4rhd6XgSuv5H1EAmQSF+GRUVMNkfoeVCh8I94KCvfzoHD3UMEUr33Yf1cxBgrUkFq
	Ruqehu7NmR4fJr68Uqr7KDa0C9DK0Oo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-pDbS2wVONgmAJZKVIdWkKA-1; Wed, 08 May 2024 06:08:29 -0400
X-MC-Unique: pDbS2wVONgmAJZKVIdWkKA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34e0d47c9b7so305697f8f.0
        for <virtualization@lists.linux.dev>; Wed, 08 May 2024 03:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715162908; x=1715767708;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNHp8YfOUWVmU5olVJkx6F71bvtRkNzxWX8Xu+Hbano=;
        b=X4A2ysZY3TIca893te/dUfBT0QjfEe/1qjlFFJvv5qQQIyQxlkNt4rGO6f04Rr3Wyf
         5cEC9Ut8U52QEBB+N4lCp8gJAVcZ7HIt2toH6+leqqvxRGx/GEDtPT46TxwZ1XLTwFOo
         5FQc914WxcA99PYuCgVeLC81+PvsYUH6r85acGR4BfshmuzzYn/5mz5EFxgIh2As7Bdx
         r3zRQHb4ajkhOFri9+htW94xJmgWbUBQw+sAIwtWzFqjL0/R/SLUVz7+EI8ongYRKoNx
         G4BdcNysSSql6DSoMkerMASM7b+U8oa0r+LsFwrFOfa3qvbBH1WemdY2PMIYGaAJJ9MO
         Y/SA==
X-Forwarded-Encrypted: i=1; AJvYcCW40P7OuG0hQ4ycIrF23QYKTgQDTLhCxI0aUKDsm1kSPCWWeF6NejMXQdEoNby6NsbU8tupL8eHyJJyyAW6o1H1SbTtC6vNPzhfDfwUoGo=
X-Gm-Message-State: AOJu0YwfYabPp8rKsnaNr16BqQ8HFSEqhOJxhTYoenS4n4ss3z73+9Be
	z6ctTEZRDg9WALzhRvZeRZDTxaMEtzmjE2+07twWdONtUlPJti57kT8q3yIwRJONTwdVaPzY5Wy
	egGwPKQ3EffAysM0/MYVpFfIfNhKYk/6JUistbgpt9Zks6mFyEAYe1yM8RZKwnj5N
X-Received: by 2002:a5d:4609:0:b0:34c:e6ca:b844 with SMTP id ffacd0b85a97d-34fca4326ebmr2121910f8f.10.1715162905481;
        Wed, 08 May 2024 03:08:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXUixP71qOqmXCHqtiRcSiizWmrb8/jKc+n3jGLXeQk7JyzOLQn2I+FaO4/fik1qwM/2xdcQ==
X-Received: by 2002:a5d:4609:0:b0:34c:e6ca:b844 with SMTP id ffacd0b85a97d-34fca4326ebmr2121859f8f.10.1715162904757;
        Wed, 08 May 2024 03:08:24 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-56.business.telecomitalia.it. [87.12.25.56])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600001c300b0034df7313bf1sm15103289wrx.0.2024.05.08.03.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 03:08:24 -0700 (PDT)
Date: Wed, 8 May 2024 12:08:19 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <luigi.leonardi@outlook.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kuba@kernel.org, stefanha@redhat.com, 
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, kvm@vger.kernel.org, 
	jasowang@redhat.com
Subject: Re: [PATCH net-next v2 3/3] test/vsock: add ioctl unsent bytes test
Message-ID: <ziml6kzajkzrtzhl5t7ygselpwqggukrrfdcewfteuvbnehud4@gbu6qomjpvc7>
References: <20240408133749.510520-1-luigi.leonardi@outlook.com>
 <AS2P194MB217007992597CC2E1BF71D679A002@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <AS2P194MB217007992597CC2E1BF71D679A002@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Apr 08, 2024 at 03:37:49PM GMT, Luigi Leonardi wrote:
>This test that after a packet is delivered the number
>of unsent bytes is zero.
>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>---
> tools/testing/vsock/util.c       |  6 +--
> tools/testing/vsock/util.h       |  3 ++
> tools/testing/vsock/vsock_test.c | 85 ++++++++++++++++++++++++++++++++
> 3 files changed, 91 insertions(+), 3 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 554b290fefdc..a3d448a075e3 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -139,7 +139,7 @@ int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_po
> }
>
> /* Connect to <cid, port> and return the file descriptor. */
>-static int vsock_connect(unsigned int cid, unsigned int port, int type)
>+int vsock_connect(unsigned int cid, unsigned int port, int type)
> {
> 	union {
> 		struct sockaddr sa;
>@@ -226,8 +226,8 @@ static int vsock_listen(unsigned int cid, unsigned int port, int type)
> /* Listen on <cid, port> and return the first incoming connection.  The remote
>  * address is stored to clientaddrp.  clientaddrp may be NULL.
>  */
>-static int vsock_accept(unsigned int cid, unsigned int port,
>-			struct sockaddr_vm *clientaddrp, int type)
>+int vsock_accept(unsigned int cid, unsigned int port,
>+		 struct sockaddr_vm *clientaddrp, int type)
> {
> 	union {
> 		struct sockaddr sa;
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index e95e62485959..fff22d4a14c0 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -39,6 +39,9 @@ struct test_case {
> void init_signals(void);
> unsigned int parse_cid(const char *str);
> unsigned int parse_port(const char *str);
>+int vsock_connect(unsigned int cid, unsigned int port, int type);
>+int vsock_accept(unsigned int cid, unsigned int port,
>+		 struct sockaddr_vm *clientaddrp, int type);
> int vsock_stream_connect(unsigned int cid, unsigned int port);
> int vsock_bind_connect(unsigned int cid, unsigned int port,
> 		       unsigned int bind_port, int type);
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index f851f8961247..c19ffbcca9dd 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -20,6 +20,8 @@
> #include <sys/mman.h>
> #include <poll.h>
> #include <signal.h>
>+#include <sys/ioctl.h>
>+#include <linux/sockios.h>
>
> #include "vsock_test_zerocopy.h"
> #include "timeout.h"
>@@ -1238,6 +1240,79 @@ static void test_double_bind_connect_client(const struct test_opts *opts)
> 	}
> }
>
>+#define MSG_BUF_IOCTL_LEN 64
>+static void test_unsent_bytes_server(const struct test_opts *opts, int type)
>+{
>+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>+	int client_fd;
>+
>+	client_fd = vsock_accept(VMADDR_CID_ANY, 1234, NULL, type);
>+	if (client_fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	recv_buf(client_fd, buf, sizeof(buf), 0, sizeof(buf));
>+	control_writeln("RECEIVED");
>+
>+	close(client_fd);
>+}
>+
>+static void test_unsent_bytes_client(const struct test_opts *opts, int type)
>+{
>+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>+	int ret, fd, sock_bytes_unsent;
>+
>+	fd = vsock_connect(opts->peer_cid, 1234, type);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	for (int i = 0; i < sizeof(buf); i++)
>+		buf[i] = rand() & 0xFF;
>+
>+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>+	control_expectln("RECEIVED");
>+
>+	ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>+	if (ret < 0) {
>+		perror("ioctl");
>+
>+		if (errno != EOPNOTSUPP)

I'm not sure `errno` is preserved after calling perror().

I'd suggest something like this:

	if (ret < 0) {
		if (errno == EOPNOTSUPP) {
			fprintf(stderr, "Test skipped\n");
		} else {
			perror("ioctl");
			exit(EXIT_FAILURE);
		}
	} else if ...

Or if you prefer, we can avoid the “Test skipped” message and still fail 
as we do for other tests.

Users already have ways of skipping tests and maybe in this way they are 
sure of what they are doing whether or not they expect this test to pass 
or not.

The rest LGTM!
Stefano

>+			exit(EXIT_FAILURE);
>+
>+		fprintf(stderr, "Test skipped\n");
>+	} else if (ret == 0 && sock_bytes_unsent != 0) {
>+		fprintf(stderr,
>+			"Unexpected 'SIOCOUTQ' value, expected 0, got %i\n",
>+			sock_bytes_unsent);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>+
>+static void test_stream_unsent_bytes_client(const struct test_opts *opts)
>+{
>+	test_unsent_bytes_client(opts, SOCK_STREAM);
>+}
>+
>+static void test_stream_unsent_bytes_server(const struct test_opts *opts)
>+{
>+	test_unsent_bytes_server(opts, SOCK_STREAM);
>+}
>+
>+static void test_seqpacket_unsent_bytes_client(const struct test_opts *opts)
>+{
>+	test_unsent_bytes_client(opts, SOCK_SEQPACKET);
>+}
>+
>+static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
>+{
>+	test_unsent_bytes_server(opts, SOCK_SEQPACKET);
>+}
>+
> #define RCVLOWAT_CREDIT_UPD_BUF_SIZE	(1024 * 128)
> /* This define is the same as in 'include/linux/virtio_vsock.h':
>  * it is used to decide when to send credit update message during
>@@ -1523,6 +1598,16 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_rcvlowat_def_cred_upd_client,
> 		.run_server = test_stream_cred_upd_on_low_rx_bytes,
> 	},
>+	{
>+		.name = "SOCK_STREAM ioctl(SIOCOUTQ) 0 unsent bytes",
>+		.run_client = test_stream_unsent_bytes_client,
>+		.run_server = test_stream_unsent_bytes_server,
>+	},
>+	{
>+		.name = "SOCK_SEQPACKET ioctl(SIOCOUTQ) 0 unsent bytes",
>+		.run_client = test_seqpacket_unsent_bytes_client,
>+		.run_server = test_seqpacket_unsent_bytes_server,
>+	},
> 	{},
> };
>
>-- 
>2.34.1
>

