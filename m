Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F1A213E74
	for <virtualization@lists.linux.dev>; Wed, 21 May 2025 02:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747793760; cv=none; b=bXh+P5LSjOBRqRKx+zhMc9nlWI7VQwX/eQGxgVHM4UkWBFQgti8J2MV8YXmxgHyKgbeg3R1eOv/GVrc2S6F3G3WhCmjYhmehqkPVoAiQ4PwsdYMD0ti9IRBVsbcwklyKVtsI1TbaWZaXQcExMQPLG10Y8iQf4ADs5y7wQHo7zn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747793760; c=relaxed/simple;
	bh=Bs4BiJyZnHS+osIO5aswWUeDg/rd7svFNSIs/C9/26E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LJt8YXrUJpvVwm7ryqtQsfU4bQ6EaOgbbejTbbVdauD5PXIQNUeESTP2eIo05vRVZdmIbas6VEuPFFOXFnOtf9HUJ5rfaWS9uM/iMk6TWrW1ksIJ7ak3r5ZKaFU/WiiesKQHsn0EWlnw/FnSvLkOjNLbRJB+U2Y6tiZDW4BEHqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmK0Wj4y; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmK0Wj4y"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30ec226b7d6so3158115a91.2
        for <virtualization@lists.linux.dev>; Tue, 20 May 2025 19:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747793758; x=1748398558; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kd9cM0q6TzRXjUrGv1P7+9M2LieKCrro4Un91zfrq/Q=;
        b=LmK0Wj4yAuwjIMtrgbFN0yZC457ziGfzemDEhSIrxV3b2z5ckcuWKbV/kt3BcUaI+n
         1QLjKCYxorAmB+3AiQbs2bvzikuoXhz8EFqkkWeDMpCZ9bdSHX0RxlS5ShvY7eNUI9wL
         xkKs2igGFgKMuX41TRItZwYWaJHnRlxAOKOg54+eG2OdNkqgrIvEy7IrclsdR+EmMHtN
         t86RhEzbCIgtP88vOl5/pE9CF4Yh8sOBfYtVLUxkf6GhEM2JguoIEMAo9y2X5BqUt//P
         tz1ZKICdHDYkSdKTMblKFEJG2J6awPvk4nFBvNR0qMPATVPrL6w4UI38xYKs5wcnAoIY
         rlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747793758; x=1748398558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kd9cM0q6TzRXjUrGv1P7+9M2LieKCrro4Un91zfrq/Q=;
        b=AUTtohQTXsd8nphE8l02wp7a+l/xmsMCaQhQt45ER664D7So4+NGT5KoGALw9q9pNz
         CCPhdWF8bgkxdfy8xKC1csBUR4f0gwIRiUh1LS81xgrMnZFru40z6flJdr6cSwLF0GRh
         lOTAI1SD8pSnmZtYrqkTf0wKZNESeNyEofeu4BBHYNiLjh0mfFJuO55fqjKT+kQalK3e
         7Eezdd5YI7aRkmI0h2SQm16GwbCIC39tOPzAOldTwi1vWUe1H74ePidJDoykWFUJxvB4
         7TWaq8HAQLXUW03uphpAx6xIku7B8ajP24EN7ZKKaDyfzHwQk4DfSth5sxtHvNkuyRGa
         PJ+w==
X-Forwarded-Encrypted: i=1; AJvYcCXRBlbpkkmIvv6dRl1zp4Nye5+iTaZtAywsKS4Zrl31RUzoY0iFFjR10/WU4JeG5DxA4QAJBbzbDIiJ46NloQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUvDQ5WJKujRK5TItjHT8eFRJY4m184PDzKzbKGXzHQ/cCAgQt
	EYULXXQv6oVI/bqvBMFKFrYJcmnTIDKHUzaavKC6UlMAQJM9chCvtKku
X-Gm-Gg: ASbGncu7xwiS5vMpPNcAViBQgKbVyWPV/1Cv1jnBNhMsY4FFBwV2ckJf/mRQH6AQNRv
	y1BBjyInFP6tHXk9NExNR9PB8CvkmAH6rmKyYSNpCCWctw9npSSP6pAbGjNB3tovWlqOI07SoDc
	BS2uNLCLBHdbJtg/Jjjw3VVohfEDzyeEYCLRavd4MML8fZNPlLj9L1KdLtq+YsYKNY9DhhpC7lo
	Dcm4c68t8WVjpzCaCJxBdmG4vtibmQ7O+uPZRX4e9PiayRGqp7MWAG/IHlhZoyATTRlHNPYNZ2P
	6CnVjmW+Z7VrFU3AJfCKnM3p9Go0yMX5K8O4EglAmYoat3C4E1E1p2GgIIbAh8kKURxhbzIYNA=
	=
X-Google-Smtp-Source: AGHT+IFi6LzKyxEuGPX8+9ng4fooYqUmoGNYHzHrk3u0MP3KOPqggigCsjb9hq7ZYiVqv62DNpiDVA==
X-Received: by 2002:a17:90b:2f85:b0:30e:8f60:b53 with SMTP id 98e67ed59e1d1-30e8f600d9bmr22899418a91.19.1747793757727;
        Tue, 20 May 2025 19:15:57 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f364fff8asm2475124a91.39.2025.05.20.19.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 19:15:57 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com
Cc: davem@davemloft.net,
	fupan.lfp@antgroup.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	niuxuewei.nxw@antgroup.com,
	niuxuewei97@gmail.com,
	pabeni@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH 3/3] test/vsock: Add ioctl SIOCINQ tests
Date: Wed, 21 May 2025 10:15:47 +0800
Message-Id: <20250521021547.3219644-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <66nlxrh4spcyhp666gqhovnevnnarq2a56fxgkffijnwiartrt@622gumoesmde>
References: <66nlxrh4spcyhp666gqhovnevnnarq2a56fxgkffijnwiartrt@622gumoesmde>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Mon, May 19, 2025 at 03:06:49PM +0800, Xuewei Niu wrote:
> >This patch adds two tests for ioctl SIOCINQ for SOCK_STREAM and
> >SOCK_SEQPACKET. The client waits for the server to send data, and checks if
> >the return value of the SIOCINQ is the size of the data. Then, consumes the
> >data and checks if the value is 0.
> 
> We recently fixed the SIOCOUTQ test, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7fd7ad6f36af36f30a06d165eff3780cb139fa79
> 
> Should we do the same here?

Yeah! Indeed, we have recognized this issue before. I think it is better to
wrap this ioctl operation in a function in "tools/testing/vsock/util.c" and
make it reusable.

Will do.

> >
> >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
> >---
> > tools/testing/vsock/vsock_test.c | 102 +++++++++++++++++++++++++++++++
> > 1 file changed, 102 insertions(+)
> >
> >diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> >index d0f6d253ac72..8b3fb88e2877 100644
> >--- a/tools/testing/vsock/vsock_test.c
> >+++ b/tools/testing/vsock/vsock_test.c
> >@@ -1282,6 +1282,78 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
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
> >+	// The data have come in but is not read, the expected value is
> >+	// MSG_BUF_IOCTL_LEN.
> >+	ret = ioctl(fd, SIOCINQ, &sock_bytes_unread);
> >+	if (ret < 0) {
> >+		if (errno == EOPNOTSUPP) {
> >+			fprintf(stderr,
> >+				"Test skipped, SIOCINQ not supported.\n");
> >+			goto out;
> >+		} else {
> >+			perror("ioctl");
> >+			exit(EXIT_FAILURE);
> >+		}
> >+	} else if (ret == 0 && sock_bytes_unread != MSG_BUF_IOCTL_LEN) {
> >+		fprintf(stderr,
> >+			"Unexpected 'SIOCOUTQ' value, expected %d, got %i\n",
> >+			MSG_BUF_IOCTL_LEN, sock_bytes_unread);
> >+		exit(EXIT_FAILURE);
> >+	}
> >+
> >+	recv_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
> >+	// The data is consumed, so the expected is 0.
> >+	ret = ioctl(fd, SIOCINQ, &sock_bytes_unread);
> >+	if (ret < 0) {
> >+		// Don't ignore EOPNOTSUPP since we have already checked it!
> >+		perror("ioctl");
> >+		exit(EXIT_FAILURE);
> >+	} else if (ret == 0 && sock_bytes_unread != 0) {
> >+		fprintf(stderr,
> >+			"Unexpected 'SIOCOUTQ' value, expected 0, got %i\n",
> >+			sock_bytes_unread);
> >+		exit(EXIT_FAILURE);
> >+	}
> >+	control_writeln("RECEIVED");
> >+
> >+out:
> >+	close(fd);
> >+}
> >+
> > static void test_stream_unsent_bytes_client(const struct test_opts *opts)
> > {
> > 	test_unsent_bytes_client(opts, SOCK_STREAM);
> >@@ -1302,6 +1374,26 @@ static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
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
> >@@ -1954,6 +2046,16 @@ static struct test_case test_cases[] = {
> > 		.run_client = test_seqpacket_unsent_bytes_client,
> > 		.run_server = test_seqpacket_unsent_bytes_server,
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
> 
> Please, append new test at the end, so we will not change test IDs.
> 
> Thanks,
> Stefano

Will do.

Thanks,
Xuewei

> > 	{
> > 		.name = "SOCK_STREAM leak accept queue",
> > 		.run_client = test_stream_leak_acceptq_client,
> >-- 
> >2.34.1
> >
