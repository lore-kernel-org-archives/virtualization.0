Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA140244664
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270280; cv=none; b=Vq+PWM2rMK4ML8jOWvJSItOJY6M8gNedgXra1Ji0wM4+96IR4Eug74HYvGdU7bLRXsN5uSVQ877PyAAGwvFd90C+UEnFmpueIoPv3k9DcAk5RSN2NTdF1TNMj8kKa/jjMg+1nuGh+A68mAK6K3j9aZ2ub5G5/KU1aZcXYhwbLQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270280; c=relaxed/simple;
	bh=AOZ6oVmWOkitNq/6qx+PmOOk2d4N55RYRHT6AyMe7Lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NYhOqbFTgWetQz/nK4Ijguq1uyIbnNmQ8Zellj0jysa5HPQlqBYLIhsxLkF/N6wCEezK2NoH992Q/VzAqoFuBaSdcHNEFcZ+Q3yrT86kfaQ+Y35codaAIlFWJMNzrcJ7I+5+BiRa1599y+tWbRAfM8XpBdmeJupijTJgLLrRuZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYKdIBbe; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYKdIBbe"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7481600130eso2305533b3a.3
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 00:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751270278; x=1751875078; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NP7k3vrg3hSrjisvFnFBQDzzpUXz8NpLnGnPf2tMTWo=;
        b=SYKdIBbe1QR7M48scB0hFEI3g4M41Nj9BB8GoXJRNexJ7HjHJnAZnuYApFoqK7oBTI
         SVj79qXJmLtAELXovzkmmfezYYK1JK6Q3QXzp7FIJSJXzwjan2H2OwBBjZz35AasP+2s
         Dnaxl5CsUITLbCpoI9ieEFShEq/sk47elMuP02/fL8qGPXYCxOdZkRbEmIauRw4xKsvn
         0AE9GBgRJVXkS1F3KjCM4++/0ieECpE9skddqP8DN9fJ7pkw9zQmZ1qJ/+WTVjiJzJP0
         lOkSdpLtsVhUR3FsetlR9EeELbvhGAvPnTiOyoxuu3/f5dj2wC98B5pda0ImGNuFJPwV
         v1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751270278; x=1751875078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NP7k3vrg3hSrjisvFnFBQDzzpUXz8NpLnGnPf2tMTWo=;
        b=gLO33KRNQYfwydtyIGMiEG1AttmDeLUrtoT9S3BbMgjH5v5Uhrxja2Rz1u2JkWpOUG
         o4El99kIMqb0BcEnInYqXnG2asedibB356W+6bG5ALTcaK9fyMMtvX3Wkf4jjqk1mCMA
         Zj4VDLkgBJ98SmsYptmBeajsar4LBbQWx2MOoLSjCyGbPmB2qbQE7THaSlj4qSv71XUb
         i6BUzHKAfUBLe470F6kM8PhfI7bb1bfSf8ODN1Hk0jJO6Hml6iOh+LkqaYhLRdwPVgpm
         WfCPMD4M25T3L+F9OYoNt4OUPedEgtDbK/mj0i7A/rE41cfeQO/NwMalxXK7CCHeXEVv
         n91A==
X-Gm-Message-State: AOJu0YyaVDNY/eOxqBcEmjm+N4JwoOBh9rnbqQBRgf6k6Zyk9U7WVgzH
	ewVrIJEOEF5IGb4APD5laoITzf9eUOIn2R7+PEOZYkjnoC1TRW16+Dc5
X-Gm-Gg: ASbGncucWGPVrjc0oamTE9e8oHgtnLtyxQTYn6toDnvUvF8Ub3uiC8mqbzLdZ7aa44m
	Fe4LCvb4JrFDl7Ky8p+/8dWeXPIlRCMHSsd9bBoqWooy8sGoDXzSmpcNHj3v0EdhfVrrSL9thdy
	A76RgkTZzmsOXWkhVUHBgo2r/XHNTJeAAGK1Pox+iFE49ThEkRLI+lyr6DzDVgFCiBtEhdVX3PV
	mdqv+8CEC6DEPQYrnGmJp0tgDsTb0NMHqw5+QlLo0VBIXmQxtVnhH6vz4JOSc4XF6j89HXJvZe6
	RqovxGb4R3qsrG/SOe586YCjvxAKryeXSqJYgFqXHIcRKiljLSY4BJiVgz0nulKceazZL5yCavB
	9CqWU6SHo
X-Google-Smtp-Source: AGHT+IGJxQhOgdfS47I3apdJsqJnzzvU1y8CdHZhf/JDLt96PRag9x30UnOO4MrqUqcGY/sgql8/Iw==
X-Received: by 2002:a05:6a21:600a:b0:1ee:d418:f764 with SMTP id adf61e73a8af0-220a16c9a36mr19882874637.38.1751270277975;
        Mon, 30 Jun 2025 00:57:57 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31db02esm7414931a12.63.2025.06.30.00.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 00:57:57 -0700 (PDT)
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
Subject: [RESEND PATCH net-next v4 4/4] test/vsock: Add ioctl SIOCINQ tests
Date: Mon, 30 Jun 2025 15:57:27 +0800
Message-Id: <20250630075727.210462-5-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630075727.210462-1-niuxuewei.nxw@antgroup.com>
References: <20250630075727.210462-1-niuxuewei.nxw@antgroup.com>
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

