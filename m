Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DAD205E02
	for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084757; cv=none; b=iF2fXQz3zjit6O052i9EPA2mBryYXW0NarD0ZU+Fmeh9FgHn0eIQyjyXbCtfvKkgbPBXau4Mip9tGy/7CEl8BeiW9Z2RuFIWxfphqnWtjeNqLzlVax0vYSZQiLMdwbELeDtqPn/J4z7WwBJrHHQDm+Xkikb7HeE1OsNe3hxZj78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084757; c=relaxed/simple;
	bh=HKgrEzskQah1kQpXe5KfjQW7BxwwaW2ozjakq0K8XTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XcZGvm5mTH6fb9lubHsj2GuapJ7csDJXVRMu2r8J8o+MHIQeL5XJAZGk7lFqoR8sVbiCFGZtYqziGsN/U6OO3FHnq9ne8976F9OKyOLjn5nyyae/3upP6nQ3fRnShJ1B6ziAoucgpt75NjgZgZ4F5vWctz5QTuU5urNMWd49law=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqiWSpRr; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqiWSpRr"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313154270bbso5055937a91.2
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 07:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750084755; x=1750689555; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zx9La2DHHIq1DlwOKe6MkU2Dlwcq/bN6FxF4eJBSvkc=;
        b=IqiWSpRruNKIU+GPcKuGdxQovrCJqzTHzhILueGe+ZRfPLq5OEXzdj0N2sv18GxPj5
         YmeqU/QY+zKmMB7bIPnpeFzg1w/53Rs3lfX0nqyl80jvCywP4wyxeWT3ORTf2F2CUqM/
         1TvfGcl8uuwmQVRuZlaft82A1ywU12oI6zHOUV1dohTbABO91G/qPutGbtCXkerirz15
         kJDoGzK+TvikhbgVYMX7pMPB0iD7BM8XZ8diBnBR/mLehJlT2w2ux7F8bLjUQ/Vhne5H
         SO2gZTc0mozeW0Fp5rr+xyVcgNGyyAQUYUYVI3f5fK5ZAjrVZAcH5QGiLGxEcAKGo0Be
         V9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750084755; x=1750689555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zx9La2DHHIq1DlwOKe6MkU2Dlwcq/bN6FxF4eJBSvkc=;
        b=K7m+10AnHfg3aQ2IyKIgkC43UUcS9pkl/E59a1oD4uLbGnBheGWQxfEtE24JUGIxof
         Dzu7A2D0SmVguLhT24d/cPQJM0aFIUqugwpNbqyRGxRdObypRzqsMjydUW3RWJT1iDFG
         kgiXg1btEULinaDSfCoblpgJMVsPNIYZeMOzFMap59i78LHb/XBTzSssqZZZax0tho6q
         dnZCREWQ6CTyOktbqoktC4EKNtFuzt6tj2Duy+Vt6sPeaQxLiP0B4H3sUpeZ3gOsbBwk
         I3IaVZWGPcpQ5ICEUUjwb6ahIISqQifBZjlDBraVTou3ttq45Q3NNPIk6E9QYaQ8lbvY
         wxfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/fLAEOrtUVb8XYVI32t1v7pjKAHwayvw5+PfvFX3qrj0MICUozE+pAVi8XLxakiyiu/FQEAgRSHhxqarMKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcXWIpMq+y8Y0b4UIMG077fW2zFjaMG6LoZRBVGL11S53tHcMr
	q4DmZY1Rtt7zgbd2wrMN3j7duj/IOgqXZLniL7dIVe/AsFuZSa5cP1QT
X-Gm-Gg: ASbGncuVPGDGMSmWZ2GvAETgUMd/BwvV9RUMAo7VsI20jjb5HFh+1AwVaQzq/4j5/vY
	N1yzKyopT94o/ONh191tT3O+bIiZHYVye5zpEjDqFJWMQS6kAwH7jdDa/5BNxMXOGfU2v3rWLOB
	fGiMzho3stF08SSGCCwG923nTG3WhX08YPwYNBRzuch1w7zB4sztOnqA7B/nLD8udeZxi3+6l4h
	3u5Tb9jSZtvvTU7Nprv2YDurdvhVcgEFh+NzdMQjgxBD0xQ+Oger7Hqi/D/p4HLiqtttQdG7q3b
	NZIBn6ykCPN6KR8uiE1x+vGGWR5FbD+ppvOED3cvDvEtuwlZP/kowUaWQNZxoFhfsD69zFM17Ke
	auXO2ngs4
X-Google-Smtp-Source: AGHT+IGjV03uzGGryagGTCazebPiF0p9H8noP9KcY07UCA2Tb3q2LW2crpB21DlM6Yp5n6X4r7wDrw==
X-Received: by 2002:a17:90b:3842:b0:312:1508:fb4e with SMTP id 98e67ed59e1d1-313f1cd6882mr16350238a91.17.1750084755039;
        Mon, 16 Jun 2025 07:39:15 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365e0d22edsm61735865ad.240.2025.06.16.07.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 07:39:14 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com
Cc: davem@davemloft.net,
	fupan.lfp@antgroup.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	niuxuewei.nxw@antgroup.com,
	niuxuewei97@gmail.com,
	pabeni@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v2 3/3] test/vsock: Add ioctl SIOCINQ tests
Date: Mon, 16 Jun 2025 22:39:01 +0800
Message-Id: <20250616143901.1187273-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2oxz7toygswngn7kfmsrbmpikk5qggwbvk3oxb5ucrbq3pcfff@azc54m4hwlfb>
References: <2oxz7toygswngn7kfmsrbmpikk5qggwbvk3oxb5ucrbq3pcfff@azc54m4hwlfb>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Fri, Jun 13, 2025 at 11:11:52AM +0800, Xuewei Niu wrote:
> >This patch adds SIOCINQ ioctl tests for both SOCK_STREAM and
> >SOCK_SEQPACKET.
> >
> >The client waits for the server to send data, and checks if the SIOCINQ
> >ioctl value matches the data size. After consuming the data, the client
> >checks if the SIOCINQ value is 0.
> >
> >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
> >---
> > tools/testing/vsock/util.c       | 36 ++++++++++----
> > tools/testing/vsock/util.h       |  2 +
> > tools/testing/vsock/vsock_test.c | 83 +++++++++++++++++++++++++++++++-
> > 3 files changed, 111 insertions(+), 10 deletions(-)
> >
> >diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
> >index 0c7e9cbcbc85..472246198966 100644
> >--- a/tools/testing/vsock/util.c
> >+++ b/tools/testing/vsock/util.c
> >@@ -97,28 +97,46 @@ void vsock_wait_remote_close(int fd)
> > 	close(epollfd);
> > }
> >
> >-/* Wait until transport reports no data left to be sent.
> >- * Return false if transport does not implement the unsent_bytes() callback.
> >+/* Wait until ioctl gives an expected int value.
> >+ * Return a negative value if the op is not supported.
> >  */
> >-bool vsock_wait_sent(int fd)
> >+int ioctl_int(int fd, unsigned long op, int *actual, int expected)
> > {
> >-	int ret, sock_bytes_unsent;
> >+	int ret;
> >+	char name[32];
> >+
> >+	if (!actual) {
> >+		fprintf(stderr, "%s requires a non-null pointer\n", __func__);
> >+		exit(EXIT_FAILURE);
> >+	}
> >+
> >+	snprintf(name, sizeof(name), "ioctl(%lu)", op);
> >
> > 	timeout_begin(TIMEOUT);
> > 	do {
> >-		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
> >+		ret = ioctl(fd, op, actual);
> > 		if (ret < 0) {
> > 			if (errno == EOPNOTSUPP)
> > 				break;
> >
> >-			perror("ioctl(SIOCOUTQ)");
> >+			perror(name);
> > 			exit(EXIT_FAILURE);
> > 		}
> >-		timeout_check("SIOCOUTQ");
> >-	} while (sock_bytes_unsent != 0);
> >+		timeout_check(name);
> >+	} while (*actual != expected);
> > 	timeout_end();
> >
> >-	return !ret;
> >+	return ret;
> >+}
> >+
> >+/* Wait until transport reports no data left to be sent.
> >+ * Return false if transport does not implement the unsent_bytes() callback.
> >+ */
> >+bool vsock_wait_sent(int fd)
> >+{
> >+	int sock_bytes_unsent;
> >+
> >+	return !(ioctl_int(fd, SIOCOUTQ, &sock_bytes_unsent, 0));
> > }
> 
> Please split this patch in 2, one where you do the refactoring in 
> util.c/h and one for the new test.

Will do.

> > /* Create socket <type>, bind to <cid, port> and return the file descriptor. */
> >diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
> >index 5e2db67072d5..945c85ff8d22 100644
> >--- a/tools/testing/vsock/util.h
> >+++ b/tools/testing/vsock/util.h
> >@@ -3,6 +3,7 @@
> > #define UTIL_H
> >
> > #include <sys/socket.h>
> >+#include <sys/ioctl.h>
> 
> Why we need this in util.h?

We call `ioctl()` in the util.c. And we use `TIOCINQ` in the vsock_test.c,
where includes "util.h". So including `sys/ioctl.h` in util.h is needed.

> > #include <linux/vm_sockets.h>
> >
> > /* Tests can either run as the client or the server */
> >@@ -54,6 +55,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
> > int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> > 			   struct sockaddr_vm *clientaddrp);
> > void vsock_wait_remote_close(int fd);
> >+int ioctl_int(int fd, unsigned long op, int *actual, int expected);
> > bool vsock_wait_sent(int fd);
> > void send_buf(int fd, const void *buf, size_t len, int flags,
> > 	      ssize_t expected_ret);
> >diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> >index f669baaa0dca..43996447f9a2 100644
> >--- a/tools/testing/vsock/vsock_test.c
> >+++ b/tools/testing/vsock/vsock_test.c
> >@@ -20,7 +20,6 @@
> > #include <sys/mman.h>
> > #include <poll.h>
> > #include <signal.h>
> >-#include <sys/ioctl.h>
> > #include <linux/time64.h>
> >
> > #include "vsock_test_zerocopy.h"
> >@@ -1305,6 +1304,58 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
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
> >+		fprintf(stderr, "Test skipped, TIOCINQ not supported.\n");
> >+		goto out;
> >+	}
> >+
> >+	recv_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
> >+	// All date has been consumed, so the expected is 0.
> >+	ioctl_int(fd, TIOCINQ, &sock_bytes_unread, 0);
> >+	control_writeln("RECEIVED");
> >+
> >+out:
> >+	close(fd);
> >+}
> >+
> > static void test_stream_unsent_bytes_client(const struct test_opts *opts)
> > {
> > 	test_unsent_bytes_client(opts, SOCK_STREAM);
> >@@ -1325,6 +1376,26 @@ static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
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
> >@@ -2016,6 +2087,16 @@ static struct test_case test_cases[] = {
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
> I think I already mentioned in the previous version: please add new 
> tests at the end of the array, so we can preserve test IDs.

My bad. Sorry. Will do.

Thanks,
Xuewei

> Thanks,
> Stefano
> 
> > 	{
> > 		.name = "SOCK_STREAM leak accept queue",
> > 		.run_client = test_stream_leak_acceptq_client,
> >-- 
> >2.34.1
> >
