Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862A92E9753
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174293; cv=none; b=s0jn5nQqWxyEP95x33uN8Tr1hIvnY5vCgwebSgKtSszOfh7Yti1aMg62o7JaB/cJU13/7IiUl4Ql4MvVvUz2D8JCZeoNjvB/Uax0fdpqT7svYoa5+9f6DJTbBFtYkap/AoWIrIVgq/9OmlwoKZ2cCJQADjigvodGRqHCNGnzWvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174293; c=relaxed/simple;
	bh=rqsoueWdM1nAxX6i3TdFvPfMOP8bCIS3N3NGt3+7CO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PXEhFyUeOc/LRr7vkZutx+Xg7nGNYtTCmpBBjBcS4alwLx3K3T2iPP/lBg4fWTBt91aeDEsNkjdNmMx9PZkxjThQWHPeVTjIM1W0n0FSkRMo0ON9J9OqxwA3XN4Ma9AJwUfrnOKgPMeC16PeSKFBDdM32GGrhYMiqAlYjCxg4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itVxwXjV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itVxwXjV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-236192f8770so41404805ad.0
        for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750174291; x=1750779091; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vONKiPDQFvOV04sWTQ5N/d0Nqz6jFzaBcRhqCM37kEI=;
        b=itVxwXjVhQP8XYAuHeZLJADLb/xGn8Qc/O0XAm415QmgXqDU3pgZIqH+LWnk13nnuu
         bM39OqaWv7sSJ1yCjzBi6I/s0aNrBVOumBMVqU3Np6yZDGJ2aclBBttEmnW72VAzkI7C
         qYYwhHYWaOni9fk3cMohNckX2lcZcTBuS8TWirZzgz3P88FsPXmI5Uh5V+Ya6o41v/QH
         vqCW9YVxC46AocUTVElKloWk2IKJHJmOFlKGFC9FlmPNAHloXDHM3N/6yXS1BuOR8Ao1
         F1gSTTeUB3vuNkc1aPiWem40tLdcEtwwJbJpwB6zoave0bVg1FCCUEkR7U8/nlKhDJcw
         L97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750174291; x=1750779091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vONKiPDQFvOV04sWTQ5N/d0Nqz6jFzaBcRhqCM37kEI=;
        b=AKphiIIhZ1hmw5YrG79zxBHnWuElNJRMV4X+tk7tETfcsQYSALm6elIjInen3r8lU8
         LsDNOBXlvxlOA0iQaX5KlR/ltVjYczm6t2SmVrvOApnYAXkg+93T3Uv/pzDRQRdVBKJS
         cv10o9PQs9IG6qQar3T6JA29YT9IyHJwvocNatV6IYRMIa3bBKQu4jzzh0bdxJYtX/7w
         BTK4SCqhaqqSj1oxPaK6kDlnpc7bS0XNda3GVfWkWOYC5nKpbwWG++aQ/n1A7YWV//gO
         NNfuY9z7CCk+TNsjCXv8VFe+02AXGKDoAGjImzQe8wLhlrdTxiZb8j9kIPhh9Ndk9A0K
         lNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlcqlYB2JRCDZG7dHXQJP3M8jA0YGliXt3wUAftUvOcloc4TJ19ko23A5lLzOhGiqBuTMI8taZ12LkIs+wvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTzrzBVz2iaiO29m+yUXk46f6mzQOmS90bMhbJzSiHZMorngI1
	KjZkccLtL24haWVTVFWA98uxefWofd03Bj7w9L35P28iIqfCimDIUw2adDIXdsCSQE10TydC
X-Gm-Gg: ASbGncubK14nmCkaDsz14fCS1zHWh2qH1v67q72Lqy3gkilu9uK6wAif2c1gx+I8SiN
	WRTXKCpzm6H8Qu42UB4bz5k1lAcZfC2ywk//nSHMIGVUMT947vatw/k+e6eszSjoJF3yffV4Mmb
	q/193E2gLllg4wewWdnQ6luC3rx/L+34kQe+8TIXIc890cFM71kZfFG6Q6R+N2EqGWGB0329mqi
	Jksgsth8HjMusodJzZb2D3YS6PiCHkBJCNvtdVGRyqdbBeoLiR7sLDKiDflCir8RtcmnVfrJzY9
	tBBu2WlMp/gw27q0mkKUyOEekRFmDUGEq/lsu7qTzOOPImjGpYLlbAQaz32ux7GlVbDZsRSxZvv
	KXZ034tiK
X-Google-Smtp-Source: AGHT+IGYJo30uXrZf1g+2eeuGKvcXBXQtOlctiDYvFKA0bX2SqJAcMGk1oSS7fnVY2Di05z0qFETSw==
X-Received: by 2002:a17:902:d48d:b0:236:71a5:4416 with SMTP id d9443c01a7336-23691eabe15mr41899625ad.20.1750174290520;
        Tue, 17 Jun 2025 08:31:30 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de7839dsm81188535ad.127.2025.06.17.08.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 08:31:30 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com
Cc: davem@davemloft.net,
	fupan.lfp@antgroup.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	leonardi@redhat.com,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	niuxuewei.nxw@antgroup.com,
	niuxuewei97@gmail.com,
	pabeni@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v3 3/3] test/vsock: Add ioctl SIOCINQ tests
Date: Tue, 17 Jun 2025 23:31:20 +0800
Message-Id: <20250617153120.1348774-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <fnznqsbg56rfk7szjcprpo4mxy7e4patmj2u5yxbtj33dlj34w@7t5xylskewa5>
References: <fnznqsbg56rfk7szjcprpo4mxy7e4patmj2u5yxbtj33dlj34w@7t5xylskewa5>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Tue, Jun 17, 2025 at 12:53:46PM +0800, Xuewei Niu wrote:
> >Add SIOCINQ ioctl tests for both SOCK_STREAM and SOCK_SEQPACKET.
> >
> >The client waits for the server to send data, and checks if the SIOCINQ
> >ioctl value matches the data size. After consuming the data, the client
> >checks if the SIOCINQ value is 0.
> >
> >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
> >---
> > tools/testing/vsock/vsock_test.c | 82 ++++++++++++++++++++++++++++++++
> > 1 file changed, 82 insertions(+)
> >
> >diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> >index f669baaa0dca..66bb9fde7eca 100644
> >--- a/tools/testing/vsock/vsock_test.c
> >+++ b/tools/testing/vsock/vsock_test.c
> >@@ -1305,6 +1305,58 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
> > 	close(fd);
> > }
> >
> >+static void test_unread_bytes_server(const struct test_opts *opts, int type)
> >+{
> >+	unsigned char buf[MSG_BUF_IOCTL_LEN];
> >+	int client_fd;
> >+
> >+	client_fd = vsock_accept(VMADDR_CID_ANY, opts->peer_port, NULL, type);
> >+	if (client_fd < 0) {
> >+		perror("accept");
> >+		exit(EXIT_FAILURE);
> >+	}
> >+
> >+	for (int i = 0; i < sizeof(buf); i++)
> >+		buf[i] = rand() & 0xFF;
> >+
> >+	send_buf(client_fd, buf, sizeof(buf), 0, sizeof(buf));
> >+	control_writeln("SENT");
> >+	control_expectln("RECEIVED");
> >+
> >+	close(client_fd);
> >+}
> >+
> >+static void test_unread_bytes_client(const struct test_opts *opts, int type)
> >+{
> >+	unsigned char buf[MSG_BUF_IOCTL_LEN];
> >+	int ret, fd;
> >+	int sock_bytes_unread;
> >+
> >+	fd = vsock_connect(opts->peer_cid, opts->peer_port, type);
> >+	if (fd < 0) {
> >+		perror("connect");
> >+		exit(EXIT_FAILURE);
> >+	}
> >+
> >+	control_expectln("SENT");
> >+	/* The data has arrived but has not been read. The expected is
> >+	 * MSG_BUF_IOCTL_LEN.
> >+	 */
> >+	ret = ioctl_int(fd, TIOCINQ, &sock_bytes_unread, MSG_BUF_IOCTL_LEN);
> >+	if (ret) {
> 
> Since we are returning a value !=0 only if EOPNOTSUPP, I think we can 
> just return a bool when the ioctl is supported or not, like for 
> vsock_wait_sent().

Will do.

> >+		fprintf(stderr, "Test skipped, TIOCINQ not supported.\n");
> >+		goto out;
> >+	}
> >+
> >+	recv_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
> >+	// All date has been consumed, so the expected is 0.
> 
> s/date/data
> 
> Please follow the style of the file (/* */ for comments)

Will do.

> >+	ioctl_int(fd, TIOCINQ, &sock_bytes_unread, 0);
> >+	control_writeln("RECEIVED");
> 
> Why we need this control barrier here?

Nice catch! It is not necessary. Will remote it.

Thanks,
Xuewei

> >+
> >+out:
> >+	close(fd);
> >+}
> >+
> > static void test_stream_unsent_bytes_client(const struct test_opts *opts)
> > {
> > 	test_unsent_bytes_client(opts, SOCK_STREAM);
> >@@ -1325,6 +1377,26 @@ static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
> > 	test_unsent_bytes_server(opts, SOCK_SEQPACKET);
> > }
> >
> >+static void test_stream_unread_bytes_client(const struct test_opts *opts)
> >+{
> >+	test_unread_bytes_client(opts, SOCK_STREAM);
> >+}
> >+
> >+static void test_stream_unread_bytes_server(const struct test_opts *opts)
> >+{
> >+	test_unread_bytes_server(opts, SOCK_STREAM);
> >+}
> >+
> >+static void test_seqpacket_unread_bytes_client(const struct test_opts *opts)
> >+{
> >+	test_unread_bytes_client(opts, SOCK_SEQPACKET);
> >+}
> >+
> >+static void test_seqpacket_unread_bytes_server(const struct test_opts *opts)
> >+{
> >+	test_unread_bytes_server(opts, SOCK_SEQPACKET);
> >+}
> >+
> > #define RCVLOWAT_CREDIT_UPD_BUF_SIZE	(1024 * 128)
> > /* This define is the same as in 'include/linux/virtio_vsock.h':
> >  * it is used to decide when to send credit update message during
> >@@ -2051,6 +2123,16 @@ static struct test_case test_cases[] = {
> > 		.run_client = test_stream_nolinger_client,
> > 		.run_server = test_stream_nolinger_server,
> > 	},
> >+	{
> >+		.name = "SOCK_STREAM ioctl(SIOCINQ) functionality",
> >+		.run_client = test_stream_unread_bytes_client,
> >+		.run_server = test_stream_unread_bytes_server,
> >+	},
> >+	{
> >+		.name = "SOCK_SEQPACKET ioctl(SIOCINQ) functionality",
> >+		.run_client = test_seqpacket_unread_bytes_client,
> >+		.run_server = test_seqpacket_unread_bytes_server,
> >+	},
> > 	{},
> > };
> >
> >-- 
> >2.34.1
> >
