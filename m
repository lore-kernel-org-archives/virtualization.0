Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC1224AEB
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 06:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956619; cv=none; b=XS+f26j9HJfoZ0tg1pfDKVVhz3vFW3O7+fR7PiM56oSg3sPCIFrMurIfjPCjNX9+CpAND74qDNZ2xHuFIOAvox5lmN9G1AN0ASK5k39sCm8+byDXferFIhIBntlEA9szf1ogQfSB/WNqmT/KTzOjQESa+jdO9CYLSbts6tx0DxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956619; c=relaxed/simple;
	bh=Doct89OeyNO072Y2Ys7bCVOd+ekwZZ2v2r0ziNK3ALY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oe5M/SCq6syc3P+WZLkAhDKXlrUT3ROMz/gItFWZqLSGnsHGxDPJZuXirH80bHn7Hw80NOxuTdHlFUX/s/fWnsAIOKo7N86h3gE1tcDeCDauFhNmwJl/j7uDNYHTbm2YkQ/xm87WZecjbgKIfQi7s8/qk3ukPZsSiUTbkmAvnXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=Bds2doH7; arc=none smtp.client-ip=115.124.28.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="Bds2doH7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1751956609; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	bh=78u4kXViM2gstT6OJkwZc50WiKMJcTjBxWIBBOazpAI=;
	b=Bds2doH7BZpp6my+ApqRwfxjNT3Bzs086oxibgo4VdO/YuvgrLn0Yv567zpSReijBiMVixYXj4ZU1V58GWDqPFrN+j2Hc4qxn3VrzJfbu/WuR0FAJgEo8WZLr+eVPSTIf9oWgP2rbQ44b7hR20BqY5Ly9PphpQ0S4NuVRZKC184=
Received: from 127.0.0.1(mailfrom:niuxuewei.nxw@antgroup.com fp:SMTPD_---.dhGPAi9_1751956606 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 14:36:48 +0800
From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Date: Tue, 08 Jul 2025 14:36:14 +0800
Subject: [PATCH net-next v6 4/4] test/vsock: Add ioctl SIOCINQ tests
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-siocinq-v6-4-3775f9a9e359@antgroup.com>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
In-Reply-To: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xuewei Niu <niuxuewei.nxw@antgroup.com>, niuxuewei97@gmail.com
X-Mailer: b4 0.14.2

Add SIOCINQ ioctl tests for both SOCK_STREAM and SOCK_SEQPACKET.

The client waits for the server to send data, and checks if the SIOCINQ
ioctl value matches the data size. After consuming the data, the client
checks if the SIOCINQ value is 0.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 tools/testing/vsock/vsock_test.c | 79 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index be6ce764f69480c0f9c3e2288fc19cd2e74be148..a66d2360133dd0e36940a5907679aeacc8af7714 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -24,6 +24,7 @@
 #include <linux/time64.h>
 #include <pthread.h>
 #include <fcntl.h>
+#include <linux/sockios.h>
 
 #include "vsock_test_zerocopy.h"
 #include "timeout.h"
@@ -1307,6 +1308,54 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
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
+	if (!vsock_ioctl_int(fd, SIOCINQ, MSG_BUF_IOCTL_LEN)) {
+		fprintf(stderr, "Test skipped, SIOCINQ not supported.\n");
+		goto out;
+	}
+
+	recv_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
+	/* All data has been consumed, so the expected is 0. */
+	vsock_ioctl_int(fd, SIOCINQ, 0);
+
+out:
+	close(fd);
+}
+
 static void test_stream_unsent_bytes_client(const struct test_opts *opts)
 {
 	test_unsent_bytes_client(opts, SOCK_STREAM);
@@ -1327,6 +1376,26 @@ static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
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
@@ -2276,6 +2345,16 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_transport_change_client,
 		.run_server = test_stream_transport_change_server,
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

