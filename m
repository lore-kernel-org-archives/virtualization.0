Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C6F248897
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 04:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750136054; cv=none; b=jG8GERVJ/b+Xrvz+bzKuaOueeBgH1YhnGBdeBE3Hat7YzWGB9pMnSsCL+h/cuJnoXoe/jtAflZdhcLPzHxGltIGoZSKV5Wl0GERKxAJ+DZLZFvj+v0+UvdzsupcpSmcSC0Tvp4fyXvIvOt73zsFKGx35xQCFgiYZ5j9M966UfNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750136054; c=relaxed/simple;
	bh=hgFFSeG/Y3hy3TRLWUuF2/wDRWFdJSGr2WyqIM1rJ5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JVz1Zg96P+H9MyIA7J4yGqoEE8JT4rxxLjGZFlAV5tvWadHwO1g8jU3kKiY2EvzOKS0/IdQM1TmfEK2QSYG8QIsvQ24Rk0oEDJJ/H4HFW7ShkBTWxdU90yuAV3Hq8vyHTues7qS8PjauihpUv02bPDZsauSw48G2M3m+VZfqnE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPYJOXSG; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPYJOXSG"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so4312729a12.1
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 21:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750136052; x=1750740852; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8zzLDE6njEpryzHGmq8M68mZjr/gPDq07PO+JYQaTc=;
        b=NPYJOXSGDLUyPf+GNgM51V5n6NpsrzjijQ4MFZB2TeBp6Q5D/AgpLqeloGfPy3QfaH
         fBoXSoWTjt4PLzxZTBZvGBWt16nleGQmUh1jseYVw7O6Mnz4YkwKMjp9xVQgT1T5U4nA
         C/yGC8u54IKmTt1FlIQRCyS71KrLqhtvzqQab0Ph1WHEb3bSNYDXCV/Oqb+6XQqqHJiH
         NJLTOgplqP54LwXJpg2AdRu4J/LYXgMYho2WR1go/EBlX+nlMKeN991pD4nvS8ms5vnP
         9LUmbYcHVsrm0F6OEmjIJKzBb+02ufXeCdmULZBPsslC6vz8bk2+51O2sJSg+zFu2+xZ
         HqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750136052; x=1750740852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8zzLDE6njEpryzHGmq8M68mZjr/gPDq07PO+JYQaTc=;
        b=VwN3z16w7ubQscctPvsCVeMuwM9tvZJ8YZdr3ZX3FlESKlcAe9PXLFySq797P+Fako
         SGL7QZeBLtAFRURA1oh7cUdKUU8X1A29lygMWVP/m4odg3+DyMIxBem1V+KeTsknMAr7
         W66womlT3RU7EwveJ10uRvEG40Du2j0brjVx8wZMbhH4FlFssT3NHcP01XXYZATo9bkr
         u1prHO8Sow6C0Cmb2uv2tG3L45SHIcm9de3lE6n3qZ+6yrZ3nujsnMnBCZwpoWXMCihj
         zfi0dvc6X9zG65mROZf1UgXBQ7KmxUd+eXvUSd2R6NOjLk8dn7czll/KXSZk3odbZPuQ
         E/fw==
X-Gm-Message-State: AOJu0Yw7QP8VkckM9lm567ppE01EyteorZz6ZSGwPNfuSRy2xXAo5/qr
	FfpErILuO60KiCf1ziearbGlu2O9Rnnse88expbxezOheoP4mKjqeMUg
X-Gm-Gg: ASbGncstb34hScA4GBAjDMGBvuIGGKMG0JJ8PbAC9ftGTBFgUEOrVMWNblVlEwEY8NP
	x32zXz7xcPm6DDIgZj5jf7A6kWTFxgbET2CfIQtLS6pfxGYC8UQ6qMOzSmxklpbv5NgQla6e/1O
	/vRS+2vVstGJa84e8daAneEUSP2nyu2EOaT5HjS2IBmKkOQTDeRPOAUSPjaGXMHZJzyVcJv6JM9
	qBI+7SISeu2kbAA7qZ981k+jcrgYkkWpz3c2mTdytArRlaTuDZxhJU29IVDXf7teITgfpzfpU6m
	5HMF07QfV72s2j9p5F5X9/boHgd0+jqCnvIOOsfq6nPjFOlIPv82Sldiw/HVDf6V0nIkix0+Vfn
	js6bJpPzW
X-Google-Smtp-Source: AGHT+IHnBLa7t0ubsYSeKkayXhW4mKBqb1+QAMW9EvWq+u4JW6gRZtgfqBWqro4ZYC+uYeX68JLHRA==
X-Received: by 2002:a05:6a21:6005:b0:21a:e090:7b88 with SMTP id adf61e73a8af0-21fbd55a108mr18242268637.21.1750136052423;
        Mon, 16 Jun 2025 21:54:12 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890005f47sm8132852b3a.51.2025.06.16.21.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:54:12 -0700 (PDT)
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
	leonardi@redhat.com
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fupan.lfp@antgroup.com,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [PATCH net-next v3 3/3] test/vsock: Add ioctl SIOCINQ tests
Date: Tue, 17 Jun 2025 12:53:46 +0800
Message-Id: <20250617045347.1233128-4-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617045347.1233128-1-niuxuewei.nxw@antgroup.com>
References: <20250617045347.1233128-1-niuxuewei.nxw@antgroup.com>
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
 tools/testing/vsock/vsock_test.c | 82 ++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index f669baaa0dca..66bb9fde7eca 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1305,6 +1305,58 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
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
+	control_expectln("RECEIVED");
+
+	close(client_fd);
+}
+
+static void test_unread_bytes_client(const struct test_opts *opts, int type)
+{
+	unsigned char buf[MSG_BUF_IOCTL_LEN];
+	int ret, fd;
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
+	ret = ioctl_int(fd, TIOCINQ, &sock_bytes_unread, MSG_BUF_IOCTL_LEN);
+	if (ret) {
+		fprintf(stderr, "Test skipped, TIOCINQ not supported.\n");
+		goto out;
+	}
+
+	recv_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
+	// All date has been consumed, so the expected is 0.
+	ioctl_int(fd, TIOCINQ, &sock_bytes_unread, 0);
+	control_writeln("RECEIVED");
+
+out:
+	close(fd);
+}
+
 static void test_stream_unsent_bytes_client(const struct test_opts *opts)
 {
 	test_unsent_bytes_client(opts, SOCK_STREAM);
@@ -1325,6 +1377,26 @@ static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
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
@@ -2051,6 +2123,16 @@ static struct test_case test_cases[] = {
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

