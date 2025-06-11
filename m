Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD45280CC8
	for <virtualization@lists.linux.dev>; Wed, 11 Jun 2025 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650864; cv=none; b=MdL4B6H/LUJGCqKaRUmluMHF1472T0KDiZdqgKQba7wRS5hGTY65BaG3/pZ9bL1nfqK96lMmZplqz9FyVQHaJUyNtxxf88G3D1ZTlnKakpzziC+4jFD1hHdvE7daF9+G78uT12PSRLuvn7garhPfK6AUE2hKgiEhfedZAmHySh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650864; c=relaxed/simple;
	bh=aWR62073JSJG6G4J5LvR0mS94tdbSX0ohjireAR+M54=;
	h=From:Date:Subject:MIME-Version:Message-Id:To:Cc:Content-Type; b=INJG2z9572mYZzraCSQPPZ+W4s/vLvCmHones4HZnwn0sTXZB+BA35VM/9AlWXKARXm+CyqKVBXqv6Kj8fDKnV18C8z/pQBCbUA9N2P13XHIJZSVYNNdZhYdq+Zl3rIKJl2mw6Q7Dxrru6QMpMh7kHJRWEPaKKD7cFRZ8g2qjio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D7nLmkIh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7nLmkIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749650861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AnUUP0MlMpOkzp6RD+39iGJrHBBH20xNSTOFfa7irtc=;
	b=D7nLmkIhFC3JDc6oobutI2+Q5uWANZeWWUnm1gdpGTt6ucRXi6H0G7yA/Thp5h85olD5vi
	KoGfMjcx0zUwLUAfXkMk1qUUEba3eMGX93IAZxRTJB2TYyTtkHx0oAjr5M5Ir4yJVY7cbi
	TrbJ37o+vNTP/dopYrVqGX4BiMQH2g8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-sUaXd3YUPGedypZWm8j19g-1; Wed, 11 Jun 2025 10:07:39 -0400
X-MC-Unique: sUaXd3YUPGedypZWm8j19g-1
X-Mimecast-MFC-AGG-ID: sUaXd3YUPGedypZWm8j19g_1749650858
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450d64026baso41305325e9.1
        for <virtualization@lists.linux.dev>; Wed, 11 Jun 2025 07:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749650858; x=1750255658;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnUUP0MlMpOkzp6RD+39iGJrHBBH20xNSTOFfa7irtc=;
        b=cUoipqFGeP3aotS9Q9DUm1F/jjERWKlarbWqaaR4flsU14HAwsXmzjk/vlY68HLmkB
         yXdiyYBrT6xVq3wj3EuMsSEuEOf91cdvnzIu8rBN2hj5QomnD79ZDAfPuGvFK8y3Gy/K
         jxqThC01EV9BH2UUcJPeJHmFi9dat8TYukMJBUkkRm7cvdqKPEL1lsGfGpeKP4SGuf9s
         CaqL6EUrjcokU1DJT9FZnY5vvqMzRxbXgoXL3mKT7BE1LXUNIq72cP6PM+Ka22ArqtFM
         F74JLZJ6Dh9QwQ8OISU8nNg/x/KnlV2uula34XeTFRPb5KWljwkZrBsLwnlTiJJi3yaG
         Ce3Q==
X-Gm-Message-State: AOJu0Yxk1kL3gAiQfidd4wo9eyyd3Ly9kGxVSsMqzl5aQo7cyGec5uUd
	JDmLBGgxvqFiY/qhOUjfeStGMbVFDwGeL32Ep2mATKXcg2amdImat2FYpBM9EJ2SNUCdGPXwByu
	Raz0KgPEJTM7Z1lrRaNxAXQbcoKTqCAbVKeH+4qQffzBHvOtphin5i+SICh3IwXXd0w47
X-Gm-Gg: ASbGncvevjKHjLuP/kCNI34atP8anf3mTtvM8JY8Ba4CDsbMiQ8UKuyZuVoO8Fs9uUw
	tG3HTUranKwHoIlysgqeEghBfPl4IfYyWhTDB5Z6z7VwVk2+P3u6GoYTBS2U4JyQKUfrqtyRVN/
	Fhb1MCt5DQR/bZ/UTTtY0PD7Rc0c1y2qkbs8z6MvcIz5/rqugBO7uKRCQo/9/E5WVp7aoWX+EI8
	SDXkoaJGtkRQ94RRmRVpmONGSxYYfZhGg1ibRTz81SAOwWbVrITlCrfmpePK7xUrTzrTpfZ7eMC
	KwW3mqQEMPcpFZZ/1RkUuk0Y0C8X/mFbwHNvXJinm8favP5usTrY+w==
X-Received: by 2002:a05:600c:6087:b0:442:f956:53f9 with SMTP id 5b1f17b1804b1-453248be49emr33557595e9.18.1749650858114;
        Wed, 11 Jun 2025 07:07:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy4TR3L1Dbc0a3hiK3cASSEQaDGRbSJJXRYN485ZuSpojtlGj7TRsKfSHysFnO8sX0D7DY/g==
X-Received: by 2002:a05:600c:6087:b0:442:f956:53f9 with SMTP id 5b1f17b1804b1-453248be49emr33556935e9.18.1749650857553;
        Wed, 11 Jun 2025 07:07:37 -0700 (PDT)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453251a2303sm22235195e9.31.2025.06.11.07.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:07:37 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 11 Jun 2025 16:07:25 +0200
Subject: [PATCH net-next v3] vsock/test: Add test for null ptr deref when
 transport changes
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20250611-test_vsock-v3-1-8414a2d4df62@redhat.com>
X-B4-Tracking: v=1; b=H4sIAJyNSWgC/22NywrCMBQFf6Vk7ZU82qZ15X+ISExubRATSUKol
 P67ISsLLofDzFlJxGAxklOzkoDZRutdAXFoiJ6VeyBYU5hwyjsqaA8JY7rl6PUTBEqpRi0Vbzt
 ShHfAyS41diEOEzhcErmWZbYx+fCpL5nV/V8wM6BABaf3Tmk9jfwc0MwqHbV/1U7mPy5rdy4HB
 kJTxcwgB9Wbnbtt2xcKfDrU6wAAAA==
X-Change-ID: 20250306-test_vsock-3e77a9c7a245
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hyunwoo Kim <v4bel@theori.io>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o9HsNxm_iavuW3lOHGMIL8EbgE3JJ_BhQN1yzEIS-o8_1749650858
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add a new test to ensure that when the transport changes a null pointer
dereference does not occur. The bug was reported upstream [1] and fixed
with commit 2cb7c756f605 ("vsock/virtio: discard packets if the
transport changes").

KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
CPU: 2 UID: 0 PID: 463 Comm: kworker/2:3 Not tainted
Workqueue: vsock-loopback vsock_loopback_work
RIP: 0010:vsock_stream_has_data+0x44/0x70
Call Trace:
 virtio_transport_do_close+0x68/0x1a0
 virtio_transport_recv_pkt+0x1045/0x2ae4
 vsock_loopback_work+0x27d/0x3f0
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x35a/0x700
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30

Note that this test may not fail in a kernel without the fix, but it may
hang on the client side if it triggers a kernel oops.

This works by creating a socket, trying to connect to a server, and then
executing a second connect operation on the same socket but to a
different CID (0). This triggers a transport change. If the connect
operation is interrupted by a signal, this could cause a null-ptr-deref.

Since this bug is non-deterministic, we need to try several times. It
is reasonable to assume that the bug will show up within the timeout
period.

If there is a G2H transport loaded in the system, the bug is not
triggered and this test will always pass.

[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/

Suggested-by: Hyunwoo Kim <v4bel@theori.io>
Suggested-by: Michal Luczaj <mhal@rbox.co>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
This series introduces a new test that checks for a null pointer 
dereference that may happen when there is a transport change[1]. This 
bug was fixed in [2].

Note that this test *cannot* fail, it hangs if it triggers a kernel
oops. The intended use-case is to run it and then check if there is any 
oops in the dmesg.

This test is based on Hyunwoo Kim's[3] and Michal's python 
reproducers[4].

[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
[2]https://lore.kernel.org/netdev/20250110083511.30419-1-sgarzare@redhat.com/
[3]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/#t
[4]https://lore.kernel.org/netdev/2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co/
---
Sorry, this took waaay longer than expected.

Changes in v3:
Addressed Stefano's and Michal's comments:
    - Added the splat text to the commit commessage.
    - Introduced commit hash that fixes the bug.
    - Not using perror anymore on pthread_* functions.
    - Listener is just created once.

- Link to v2:
https://lore.kernel.org/r/20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com

Changes in v2:
- Addressed Stefano's comments:
    - Timeout is now using current_nsec()
    - Check for return values
    - Style issues
- Added Hyunwoo Kim to Suggested-by
- Link to v1: https://lore.kernel.org/r/20250306-test_vsock-v1-0-0320b5accf92@redhat.com
---
 tools/testing/vsock/Makefile     |   1 +
 tools/testing/vsock/vsock_test.c | 169 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+)

diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
index 6e0b4e95e230500f99bb9c74350701a037ecd198..88211fd132d23ecdfd56ab0815580a237889e7f2 100644
--- a/tools/testing/vsock/Makefile
+++ b/tools/testing/vsock/Makefile
@@ -5,6 +5,7 @@ vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o util.o msg_ze
 vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
 vsock_perf: vsock_perf.o msg_zerocopy_common.o
 
+vsock_test: LDLIBS = -lpthread
 vsock_uring_test: LDLIBS = -luring
 vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o msg_zerocopy_common.o
 
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index f669baaa0dca3bebc678d00eafa80857d1f0fdd6..1aed483e7e622d3623be07fcd7fe4295fcfce230 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -22,6 +22,8 @@
 #include <signal.h>
 #include <sys/ioctl.h>
 #include <linux/time64.h>
+#include <pthread.h>
+#include <fcntl.h>
 
 #include "vsock_test_zerocopy.h"
 #include "timeout.h"
@@ -1811,6 +1813,168 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
 	close(fd);
 }
 
+#define TRANSPORT_CHANGE_TIMEOUT 2 /* seconds */
+
+static void *test_stream_transport_change_thread(void *vargp)
+{
+	pid_t *pid = (pid_t *)vargp;
+	int ret;
+
+	/* We want this thread to terminate as soon as possible */
+	ret = pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
+	if (ret) {
+		fprintf(stderr, "pthread_setcanceltype: %d\n", ret);
+		exit(EXIT_FAILURE);
+	}
+
+	while (true) {
+		if (kill(*pid, SIGUSR1) < 0) {
+			perror("kill");
+			exit(EXIT_FAILURE);
+		}
+	}
+	return NULL;
+}
+
+static void test_transport_change_signal_handler(int signal)
+{
+	/* We need a custom handler for SIGUSR1 as the default one terminates the process. */
+}
+
+static void test_stream_transport_change_client(const struct test_opts *opts)
+{
+	__sighandler_t old_handler;
+	pid_t pid = getpid();
+	pthread_t thread_id;
+	time_t tout;
+	int ret;
+
+	old_handler = signal(SIGUSR1, test_transport_change_signal_handler);
+	if (old_handler == SIG_ERR) {
+		perror("signal");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = pthread_create(&thread_id, NULL, test_stream_transport_change_thread, &pid);
+	if (ret) {
+		fprintf(stderr, "pthread_create: %d\n", ret);
+		exit(EXIT_FAILURE);
+	}
+
+	control_expectln("LISTENING");
+
+	tout = current_nsec() + TRANSPORT_CHANGE_TIMEOUT * NSEC_PER_SEC;
+	do {
+		struct sockaddr_vm sa = {
+			.svm_family = AF_VSOCK,
+			.svm_cid = opts->peer_cid,
+			.svm_port = opts->peer_port,
+		};
+		int s;
+
+		s = socket(AF_VSOCK, SOCK_STREAM, 0);
+		if (s < 0) {
+			perror("socket");
+			exit(EXIT_FAILURE);
+		}
+
+		ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
+		/* The connect can fail due to signals coming from the thread.
+		 * or because the receiver connection queue is full.
+		 * Ignoring also the latter case because there is no way
+		 * of synchronizing client's connect and server's accept when
+		 * connect(s) are constantly being interrupted by signals.
+		 */
+		if (ret == -1 && (errno != EINTR && errno != ECONNRESET)) {
+			perror("connect");
+			exit(EXIT_FAILURE);
+		}
+
+		/* Set CID to 0 cause a transport change. */
+		sa.svm_cid = 0;
+		/* This connect must fail. No-one listening on CID 0
+		 * This connect can also be interrupted, ignore this error.
+		 */
+		ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
+		if (ret != -1 && errno != EINTR) {
+			fprintf(stderr,
+				"connect: expected a failure because of unused CID: %d\n", errno);
+			exit(EXIT_FAILURE);
+		}
+
+		close(s);
+
+		control_writeulong(CONTROL_CONTINUE);
+
+	} while (current_nsec() < tout);
+
+	control_writeulong(CONTROL_DONE);
+
+	ret = pthread_cancel(thread_id);
+	if (ret) {
+		fprintf(stderr, "pthread_cancel: %d\n", ret);
+		exit(EXIT_FAILURE);
+	}
+
+	/* Wait for the thread to terminate */
+	ret = pthread_join(thread_id, NULL);
+	if (ret) {
+		fprintf(stderr, "pthread_join: %d\n", ret);
+		exit(EXIT_FAILURE);
+	}
+
+	/* Restore the old handler */
+	if (signal(SIGUSR1, old_handler) == SIG_ERR) {
+		perror("signal");
+		exit(EXIT_FAILURE);
+	}
+}
+
+static void test_stream_transport_change_server(const struct test_opts *opts)
+{
+	int ret, s;
+
+	s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
+
+	/* Set the socket to be nonblocking because connects that have been interrupted
+	 * (EINTR) can fill the receiver's accept queue anyway, leading to connect failure.
+	 * As of today (6.15) in such situation there is no way to understand, from the
+	 * client side, if the connection has been queued in the server or not.
+	 */
+	ret = fcntl(s, F_SETFL, fcntl(s, F_GETFL, 0) | O_NONBLOCK);
+	if (ret < 0) {
+		perror("fcntl");
+		exit(EXIT_FAILURE);
+	}
+	control_writeln("LISTENING");
+
+	while (control_readulong() == CONTROL_CONTINUE) {
+		struct sockaddr_vm sa_client;
+		socklen_t socklen_client = sizeof(sa_client);
+
+		/* Must accept the connection, otherwise the `listen`
+		 * queue will fill up and new connections will fail.
+		 * There can be more than one queued connection,
+		 * clear them all.
+		 */
+		while (true) {
+			int client = accept(s, (struct sockaddr *)&sa_client, &socklen_client);
+
+			if (client < 0 && errno != EAGAIN) {
+				perror("accept");
+				exit(EXIT_FAILURE);
+			} else if (client > 0) {
+				close(client);
+			}
+
+			if (errno == EAGAIN)
+				break;
+		}
+	}
+
+	close(s);
+}
+
 static void test_stream_linger_client(const struct test_opts *opts)
 {
 	int fd;
@@ -2051,6 +2215,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_nolinger_client,
 		.run_server = test_stream_nolinger_server,
 	},
+	{
+		.name = "SOCK_STREAM transport change null-ptr-deref",
+		.run_client = test_stream_transport_change_client,
+		.run_server = test_stream_transport_change_server,
+	},
 	{},
 };
 

---
base-commit: 5abc7438f1e9d62e91ad775cc83c9594c48d2282
change-id: 20250306-test_vsock-3e77a9c7a245

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>

