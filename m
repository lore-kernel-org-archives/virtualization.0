Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0811B23AB96
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751269144; cv=none; b=uuZAoaEqAuputJAKwcpzk37yq46T/IbpcGTkn0fPTOBfFkbJwhtgKlwFbo3o4ggF6/fn5J4X+B8puj7OCZjpOhW2zLrVCx4/CwUYs7TOkk+hBeSxrwBEKEF9yfcr9k8YJp6pqoECYTUxYM0K/2c7U8YsoHlR9cPhmqAUpUOyyuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751269144; c=relaxed/simple;
	bh=AOZ6oVmWOkitNq/6qx+PmOOk2d4N55RYRHT6AyMe7Lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VEJU7ZjxIItVspoMmj+ZsrRx4KsCNi5GQL1/xHW34BFJxXul/3qsL87fqHwT4x00Wqv/Q9sTF9eSxFjiVYSAaAXbS1jM2HEGYLEyle0i4vYQ4Y6zWkA74BSngxHThtaVk/LJAkGnk4KBKBuyHz6QXF3pUFfWWvOVYtMwVJsdDuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNKmRRsl; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNKmRRsl"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74931666cbcso4298744b3a.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 00:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751269142; x=1751873942; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NP7k3vrg3hSrjisvFnFBQDzzpUXz8NpLnGnPf2tMTWo=;
        b=jNKmRRslo35TXb1KPDAr1+deKu73/FXjzPotsF1/aJgL7cVP3h+X7mgyVguajOpN9u
         P0iZFjYN5GhDgoFyuMUnpOAe608vUOmiy9R+n2jtuhA64axSQ9kR6Q2uWI2e43tgFMaB
         r2bLBEj3LjbFFaNfe6mMhvqai1aoYZWTprqtmKoEMn0A1Zo+I9SinNG5gor6VaM6QZsr
         PD3I2qA2R7dEkpvD6rXMrr9wvGHk1DJaPwRoQH37sWRF8N723S4D1sanuHRiQcVxa6au
         ogvH54YcaHHnkkT1UgozW2k7L/xDmnoPk+Wv0JCdVhqQuOMzvCJ4pfhJ3EH1zV7Eqkn9
         GRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751269142; x=1751873942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NP7k3vrg3hSrjisvFnFBQDzzpUXz8NpLnGnPf2tMTWo=;
        b=KfVVbzYPJ0p+rXOl+iTpUVpd+fnKSWgwDQ3Vp4VnJtrUWYv39X6PzVjQGTp1RFhhUI
         hgAW2SrYaF724cZB7DHPKifNKH64ANscAoDMpUoS5gUAOrKxA5rarZ/Yse+ZHqlzi+C3
         mjAYhfjT3pbtfkIPRWmp8nHLM39u7NiTXzDbwDCHySysQl92HxOFNhKNPUWCg0LViEEN
         bSxQU2TsM/48X67YD+k+sx2NfW/Bnri4F1nYxtxvQUjLlqkjdLimBFn/P2khTvlmiHUm
         DFXNkZOjdHxbpmzbBbU1pX4OhzUxiRFNGMxfyfJ0bVFsla7ROiKdI7KdZivh7nL0SKgo
         av6w==
X-Gm-Message-State: AOJu0YxJoF8ilnZB25whtK/TptWErwT4a1YM/FMchBVbZBKx1Pf5bPFV
	7qOzlcP+lUFHLzdvdI+uhNnhjd7Gtz+c377EuFLQnlbKCHePT9JveuBL
X-Gm-Gg: ASbGncsLDoDBlLSsa9tpYG4LBUwkRVrSA5rWh5ByPIs2MuZuTVJ476FJ+JUpejmOumh
	0G+CYiexTH5TVGD/CFqLz90C8St1fQzfaN3WkwtcHWizJESjRigQss/ukKVmoYdugfIlYIz5vVY
	Nd97k4O6w6Wrm9moRmeMRwbqJePc07ky6D/qU5fIpU+I1VPMr0aASfTASpTcDXz64kqicTyTa+4
	6nsPKjG8YhI37Z4BwhB4eR2MKtP+G9bKLxOWRul1vO7OVuZ7O06Z4u3VpqN+9YCOzHnrBJnu4Tn
	t/eKM6eKxZzA1vdtnoIABC+IzZTO2hDqHnZluzP5M3GgwUjt0ulWHalgSKQnyKYBx5jSP6x06YN
	uomkVqc+Q
X-Google-Smtp-Source: AGHT+IFsEXxcldaRKPnifcj924EJJK7H2ZTMlfpiPLPTt1OR+FEiYFdG6Niq3uwrDxXy9YRewc/0jA==
X-Received: by 2002:a05:6a20:a111:b0:1f5:6f95:2544 with SMTP id adf61e73a8af0-220a1834a51mr18403660637.33.1751269142145;
        Mon, 30 Jun 2025 00:39:02 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af55c8437sm8075175b3a.115.2025.06.30.00.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 00:39:01 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com,
	mst@redhat.com,
	pabeni@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	stefanha@redhat.com,
	leonardi@redhat.com,
	decui@microsoft.com
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fupan.lfp@antgroup.com,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [PATCH net-next v4 3/3] test/vsock: Add ioctl SIOCINQ tests
Date: Mon, 30 Jun 2025 15:38:27 +0800
Message-Id: <20250630073827.208576-4-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630073827.208576-1-niuxuewei.nxw@antgroup.com>
References: <20250630073827.208576-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SIOCINQ ioctl tests for both SOCK_STREAM and SOCK_SEQPACKET.

The client waits for the server to send data, and checks if the SIOCINQ
ioctl value matches the data size. After consuming the data, the client
checks if the SIOCINQ value is 0.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 tools/testing/vsock/vsock_test.c | 80 ++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index f669baaa0dca..1f525a7e0098 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1305,6 +1305,56 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
 	close(fd);
 }
 
+static void test_unread_bytes_server(const struct test_opts *opts, int type)
+{
+	unsigned char buf[MSG_BUF_IOCTL_LEN];
+	int client_fd;
+
+	client_fd = vsock_accept(VMADDR_CID_ANY, opts->peer_port, NULL, type);
+	if (client_fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	for (int i = 0; i < sizeof(buf); i++)
+		buf[i] = rand() & 0xFF;
+
+	send_buf(client_fd, buf, sizeof(buf), 0, sizeof(buf));
+	control_writeln("SENT");
+
+	close(client_fd);
+}
+
+static void test_unread_bytes_client(const struct test_opts *opts, int type)
+{
+	unsigned char buf[MSG_BUF_IOCTL_LEN];
+	int fd;
+	int sock_bytes_unread;
+
+	fd = vsock_connect(opts->peer_cid, opts->peer_port, type);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	control_expectln("SENT");
+	/* The data has arrived but has not been read. The expected is
+	 * MSG_BUF_IOCTL_LEN.
+	 */
+	if (!vsock_ioctl_int(fd, TIOCINQ, &sock_bytes_unread,
+			     MSG_BUF_IOCTL_LEN)) {
+		fprintf(stderr, "Test skipped, TIOCINQ not supported.\n");
+		goto out;
+	}
+
+	recv_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
+	/* All data has been consumed, so the expected is 0. */
+	vsock_ioctl_int(fd, TIOCINQ, &sock_bytes_unread, 0);
+
+out:
+	close(fd);
+}
+
 static void test_stream_unsent_bytes_client(const struct test_opts *opts)
 {
 	test_unsent_bytes_client(opts, SOCK_STREAM);
@@ -1325,6 +1375,26 @@ static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
 	test_unsent_bytes_server(opts, SOCK_SEQPACKET);
 }
 
+static void test_stream_unread_bytes_client(const struct test_opts *opts)
+{
+	test_unread_bytes_client(opts, SOCK_STREAM);
+}
+
+static void test_stream_unread_bytes_server(const struct test_opts *opts)
+{
+	test_unread_bytes_server(opts, SOCK_STREAM);
+}
+
+static void test_seqpacket_unread_bytes_client(const struct test_opts *opts)
+{
+	test_unread_bytes_client(opts, SOCK_SEQPACKET);
+}
+
+static void test_seqpacket_unread_bytes_server(const struct test_opts *opts)
+{
+	test_unread_bytes_server(opts, SOCK_SEQPACKET);
+}
+
 #define RCVLOWAT_CREDIT_UPD_BUF_SIZE	(1024 * 128)
 /* This define is the same as in 'include/linux/virtio_vsock.h':
  * it is used to decide when to send credit update message during
@@ -2051,6 +2121,16 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_nolinger_client,
 		.run_server = test_stream_nolinger_server,
 	},
+	{
+		.name = "SOCK_STREAM ioctl(SIOCINQ) functionality",
+		.run_client = test_stream_unread_bytes_client,
+		.run_server = test_stream_unread_bytes_server,
+	},
+	{
+		.name = "SOCK_SEQPACKET ioctl(SIOCINQ) functionality",
+		.run_client = test_seqpacket_unread_bytes_client,
+		.run_server = test_seqpacket_unread_bytes_server,
+	},
 	{},
 };
 
-- 
2.34.1

