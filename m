Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A522A307487
	for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779644; cv=none; b=JAjSDdDmojHGthhQUia2M+XIIXEbMqJV5YMVCCoBuJoZ4kbOp39KTW2L93m4fkG/hHa0KMBeCYDCr9+uvW6Hk2aSniwl4Ugn1KFVYgl1OvEZQeU+VCSyQbM69vDwcScEgScVtNbIcK8NT934m+9nodh4a6wKMBSrt7ihBbg2i7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779644; c=relaxed/simple;
	bh=XnpF9V+HGec0qPKFQL1pOWAIGdErMOdhXSe1wmF81IM=;
	h=From:Date:Subject:MIME-Version:Message-Id:To:Cc:Content-Type; b=sZP/A7eSr9l4hk4qJlGs2nmDTqlODrpiJuGtp/IQTb3UwmyEqG1Um4Y75DjL+mFmSTCBQdhgPnA7pETB67s68I+Qp6EE49BP7FT4BECoMYjGYoGTHhSKzu0gyjR9Kg1fMnMlsnMu9LccwNJRS13iiN0kxChBrpm087SHt6EHf7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GYaWF+ea; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYaWF+ea"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750779640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9JAZ9+YCxAR0/JjTzTiIAunISMOF/Pe1+ZV5COze/9k=;
	b=GYaWF+ea/Yz5h1y2xyC64A16nvc/sYnn0mzkjkLHQfM9h0q/zIdqJdx2QkYJd5EV8T4dUX
	kpKy4UIaeOc52RXvAulzcxkI6EbGhVPlrc8rK8hFEHFFEU4ICJZWLqHlHm9nYIDyJLcdin
	IoGdMNovLlK6eq8tE/cFuy/GoYLNcsA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-y9awNcRiNtW8NziKf0KoHQ-1; Tue, 24 Jun 2025 11:40:37 -0400
X-MC-Unique: y9awNcRiNtW8NziKf0KoHQ-1
X-Mimecast-MFC-AGG-ID: y9awNcRiNtW8NziKf0KoHQ_1750779637
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so349300f8f.2
        for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 08:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750779637; x=1751384437;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9JAZ9+YCxAR0/JjTzTiIAunISMOF/Pe1+ZV5COze/9k=;
        b=oGcOHeaS74gVceW2GWsf/bLX3urnyiektwqZGD2Esgf1Tga80cemlVmkotJo1GDP2G
         28cXboH8nsNfcTnj1W1PMbNhSivb9mwzlnaX0ivQKHoTt9C3WxCQeKqCCkegH1SQnoaK
         2jaO1Muq9ykmZ2XDwXGPBY+hQ0pfXq+uham5aOoiabjz6Jv3Ep7mUpw/zRltagAkbsl4
         u4bEzPMl0NPvkCr7AJJ4F/gtxZP6MgfVNGhXLW/0s+YbSlj+EOGVfHeti97Qu938Gg2U
         Viju0YFlMGBEGVuVpT5nQwVn7ertIXdEJo4VvOskm1s8VjCAxlCMcSyMLufXrqt4Emus
         vMDw==
X-Gm-Message-State: AOJu0Yxwxd/KIKm//19eckGhM0C5vbiHfk4pQlyMXmBtXO1z3B+SPlHZ
	HW1YS3zDDppxVd1bORzlQMU4MOBrTg5FFjyWopZpkx7b51wIsa2mPfEGEKqKGgiBBw1r6UAWxMU
	dFOoaRIH7LJvVSPYKrf3K7xxdZV4P8Wl+eCRznbwfZF2x6qRvGliDRqaSf2QnIM1viBj1
X-Gm-Gg: ASbGncuUT16euL3IOZZeZ+P357sbi1WWcyK2+LfJ+FXE3mD4DKG2MfOHly5f8WZocVA
	rj6FOzao6PEehwd/ehlzWn85psUVkvZDk+Fjj8RhS0Hi0pMBMfx+iOzLkGhtwqTdiJclmQPU1wQ
	0l2jheNWGCG9KGlr0WBdWZOGCbFqzfTzF+GRRATTj1ca6cSS0pqmqFUop/b3r7m7WU1A+/c5Kn1
	y39y6mhOJk87BsTlTmEuR0l18nTaoTc8WpOUErl2ADZ2HYtpTETfWb2ZHhe60D/50U9H5Ztm8YP
	WxNgwdv0Bdft8KGx+JYEgtY3jcnbP/tSn5nA795H894j010V+m+pS3Y=
X-Received: by 2002:a05:6000:25f8:b0:3a5:52cc:346e with SMTP id ffacd0b85a97d-3a6d12fb46emr13268384f8f.6.1750779636427;
        Tue, 24 Jun 2025 08:40:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDjVvUEyvp5075LBY9++tgHeiis3fwb6Y5bXctYH4Q1eiPOA+xqjtUIknppyr14yZGWqEktA==
X-Received: by 2002:a05:6000:25f8:b0:3a5:52cc:346e with SMTP id ffacd0b85a97d-3a6d12fb46emr13268353f8f.6.1750779635849;
        Tue, 24 Jun 2025 08:40:35 -0700 (PDT)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([176.201.192.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8050e85sm2310847f8f.14.2025.06.24.08.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 08:40:35 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 24 Jun 2025 17:40:15 +0200
Subject: [PATCH net-next v4] vsock/test: Add test for null ptr deref when
 transport changes
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20250624-test_vsock-v4-1-087c9c8e25a2@redhat.com>
X-B4-Tracking: v=1; b=H4sIAN7GWmgC/23N3QrCIBwF8FcZXmf4Nbd11XtEhOl/TSINFVmMv
 XviTY26PBx+5ywoQrAQ0aFZUIBso/WuBLFrkJ6UuwG2pmTECGsJJxIniOmSo9d3zKHr1KA7xUS
 LCngGGO1cx07IQcIO5oTOpZlsTD686kumtf83mCkmmHBGrq3SehzYMYCZVNpr/6g7mX1ZKjaWY
 Yq5JoqavuuVND+Wf6ykdGN5sb2gQjEjzCi3v+u6vgGt0YhoJwEAAA==
X-Change-ID: 20250306-test_vsock-3e77a9c7a245
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hyunwoo Kim <v4bel@theori.io>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p64vT51FP817i__eQ_fE0shIwud6q0YXOxiET6QUXps_1750779637
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
Changes in v4:
- Addressed Stefano's comments:
    - Minor style changes
    - Use `get_transports()` to print a warning when a G2H transport is 
    loaded
    - Removed check on second connect: Because the first connect is 
    interrupted, the socket is in an unspecified state (see man connect) 
    . This can cause strange and unexpected behaviors (connect returning 
    success on a non-existing CID).

- Link to v3: 
https://lore.kernel.org/r/20250611-test_vsock-v3-1-8414a2d4df62@redhat.com

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
- Link to v1: 
https://lore.kernel.org/r/20250306-test_vsock-v1-0-0320b5accf92@redhat.com
---
 tools/testing/vsock/Makefile     |   1 +
 tools/testing/vsock/vsock_test.c | 178 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+)

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
index eb6f54378667ac7ed324f4823e988ec9846e41a3..095705c7b53b7ad38ab3b8bc3cbe54a9eeb76d5c 100644
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
@@ -1867,6 +1869,177 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
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
+	int ret, tr;
+
+	tr = get_transports();
+	/* Print a warning if there is a G2H transport loaded.
+	 * This is on a best effort basis because VMCI can be either G2H and H2G, and there is
+	 * no easy way to understand it.
+	 * The bug is present in the loopback transport. However, it does not interfere
+	 * if it is loaded.
+	 * The bug we are testing only appears when G2H transports are not loaded.
+	 */
+
+	tr &= ~TRANSPORT_LOOPBACK;
+	if (tr != 0 && tr != TRANSPORT_VHOST)
+		fprintf(stderr, "G2H Transport detected. This test will not fail.\n");
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
+		/* Here we ignore the connect return value because we cannot
+		 * safely assume that it will *always* fail.
+		 * This is because the previous connect was interrupted
+		 * during the connection process. The socket state, as stated
+		 * in `man connect`, is unspecified and can result in strange
+		 * behaviors.
+		 */
+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
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
+	int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
+
+	/* Set the socket to be nonblocking because connects that have been interrupted
+	 * (EINTR) can fill the receiver's accept queue anyway, leading to connect failure.
+	 * As of today (6.15) in such situation there is no way to understand, from the
+	 * client side, if the connection has been queued in the server or not.
+	 */
+	if (fcntl(s, F_SETFL, fcntl(s, F_GETFL, 0) | O_NONBLOCK) < 0) {
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
+			if (client < 0) {
+				if (errno == EAGAIN)
+					break;
+
+				perror("accept");
+				exit(EXIT_FAILURE);
+			}
+
+			close(client);
+		}
+	}
+
+	close(s);
+}
+
 static void test_stream_linger_client(const struct test_opts *opts)
 {
 	int fd;
@@ -2106,6 +2279,11 @@ static struct test_case test_cases[] = {
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
base-commit: 68d019aa14d97f8d57b0f8d203fd3b44db2ba0c7
change-id: 20250306-test_vsock-3e77a9c7a245

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>

