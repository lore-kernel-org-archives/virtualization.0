Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A10264A97
	for <virtualization@lists.linux.dev>; Wed,  2 Jul 2025 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455076; cv=none; b=ug6Hr+WRfX6nCcj8vn9v3y/zQVr1asGjTA1LEkKr/Uz/ziDU7RzTU7BRD27NViF0sCtKuju63vWxNkCYmxaMOYFZpiBTSf45vzsQ7KFQCXkH2zySxEy4CgUlF+1di5urfAmFJY8y//Syh2te+NXU/Mw4gkhGrxh7FPVpZEkVwRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455076; c=relaxed/simple;
	bh=sx6ZXPAv0DNYijJIpFX2qRRFSX+O86QuQitiC9rw1ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kv/KhZ3IzEBXie1yxz8Pqpz72gc6GC7rR99YqxvPbgrQVfgbQ2dad5Ctx98XKrVzvQsUFI7vX2hKjw+BZovnhXIzcxO2txNhfeEc98s0RneEKTFX4nVGruy0U40Ii2rIUdI3uBUydaWWqh7rYYPSVeOBTTkf2PE1pzW5AVRIOu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MzGPaqFN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzGPaqFN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751455073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+6hlIeCKXcjgCGE6QPvE3NZnk0CNW/XPA78sK/38pY=;
	b=MzGPaqFN+v5hYirplLbwri9H9P+OAgn4JHUMtZsKnDNtdpw8Cu2Q9ru4/G4Co5eLnt3YG2
	64A3ezdDyFnVs00+Bp0dHxO1NGcW9mRVIXW8VNxBd4E6REMh0A1htsz+EmL6j4MjVXekZ4
	+6t7gJK9uJa9cP0bZVD9UJVqy1cqP3o=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-6U8_DiSBMr23DqM4fpFPrg-1; Wed, 02 Jul 2025 07:17:50 -0400
X-MC-Unique: 6U8_DiSBMr23DqM4fpFPrg-1
X-Mimecast-MFC-AGG-ID: 6U8_DiSBMr23DqM4fpFPrg_1751455070
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a9783eabc0so13466611cf.0
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 04:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751455070; x=1752059870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+6hlIeCKXcjgCGE6QPvE3NZnk0CNW/XPA78sK/38pY=;
        b=qF7VzO6ZS42IYbYnDTnosrjBVmekUkKurnpS0F7fpdToFeVnawFcZY0FbHbP3rn3AG
         PEk+s/C4ayIQuAptl0ZRPdnm1BK8ZPz0o9Lav2AjCWsWrRNU5Hq/yXMcX4QUIiXLJphx
         u6e5TAcK1hIbyh+eP1k6TDBPJDmJTVZvaALldByW5/eIQvoaWpjfq65NrZ6sTMZsWojp
         5ep2YubA8YMKD6+5P/cWpQ2jThINSPPIsNatvfurM2s2A3NTbqkLX4N5qu7NN9q2ll3x
         9nOa4qQbcFkBZM3WEA5uTb+4gqPA/FcZCqXyS+wYJrTQPlgz2RbB+LxkkiAZHZoL75oR
         94IA==
X-Forwarded-Encrypted: i=1; AJvYcCUXhSdG0kXlP1SPVjxbSah0VSm1BwrEJ/Sednaj49InjpM+yLCDPgC49X3QLJvmDOUdR6hBMnVjJ43gfQrKJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEZnux9BCoceaIZ6nwB0YTANmPiME+YUcXRP5njz822ldHRULp
	/TaS/QJz7TXvzIlDEfrGc/pwxzmPYvZqjSNKDaK0LFvvnXMU6O6dqhzsBKMopqVmMJd+zzPj+Il
	YskJo5fNRelZLEZro3Pt/p5Fy45V3DekiXwtluLF0Jv26mfztU61vliuGyY/MnHcHv/jI
X-Gm-Gg: ASbGnctdQdUpEauIrLnYUkFI6p+Dyd9iUpKzpMd1WRGEBaRJ2TWgP0m2ci558X7hdPp
	3DKzSe6R496ZuhCZxtGnixhvBK02AK+RDQTxIHUcpW3CF9ZUq8as5Pk3YGXzvOJG6LusS/Zov3T
	Z58Mb5JKwEyaiR/vkkA7h4bAW63UcXdT6yfO6pdXXdXiOi1BcazbkoFPMkZwz1WVLmI46rFHEd9
	ctrjblB+lCpWQYEF4MiVpja+9LQ7WwB9pdYAE6KoqDM0IJpQb/7J+7RSYM938lHMjIzK51KU4JI
	zpZaxmhQoh9OZ9nJPLf0sZZ0nymF
X-Received: by 2002:ac8:7f0f:0:b0:4a4:3fb2:113c with SMTP id d75a77b69052e-4a976a28ce1mr33172941cf.45.1751455069569;
        Wed, 02 Jul 2025 04:17:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5cBcz69WvcBm+o8cUuKL9tkLTgDyjUl7ykW1r2X7ywl3Jjzt418LNl2PWk5uGV4HOxkqbIg==
X-Received: by 2002:ac8:7f0f:0:b0:4a4:3fb2:113c with SMTP id d75a77b69052e-4a976a28ce1mr33172511cf.45.1751455068861;
        Wed, 02 Jul 2025 04:17:48 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.164.126])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a97c5826b7sm5693821cf.81.2025.07.02.04.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:17:48 -0700 (PDT)
Date: Wed, 2 Jul 2025 13:17:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hyunwoo Kim <v4bel@theori.io>
Subject: Re: [PATCH net-next v5 2/2] vsock/test: Add test for null ptr deref
 when transport changes
Message-ID: <bmldzyieflxolpa3gttr6txbolva5wqgkqshar2t2l34i2e6it@hspfuah5b6vl>
References: <20250630-test_vsock-v5-0-2492e141e80b@redhat.com>
 <20250630-test_vsock-v5-2-2492e141e80b@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250630-test_vsock-v5-2-2492e141e80b@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KEVC8pwdxgwi0dc5Jf_AFXXkudg3WSdqZ2ZMU01Bmi4_1751455070
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jun 30, 2025 at 06:33:04PM +0200, Luigi Leonardi wrote:
>Add a new test to ensure that when the transport changes a null pointer
>dereference does not occur. The bug was reported upstream [1] and fixed
>with commit 2cb7c756f605 ("vsock/virtio: discard packets if the
>transport changes").
>
>KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
>CPU: 2 UID: 0 PID: 463 Comm: kworker/2:3 Not tainted
>Workqueue: vsock-loopback vsock_loopback_work
>RIP: 0010:vsock_stream_has_data+0x44/0x70
>Call Trace:
> virtio_transport_do_close+0x68/0x1a0
> virtio_transport_recv_pkt+0x1045/0x2ae4
> vsock_loopback_work+0x27d/0x3f0
> process_one_work+0x846/0x1420
> worker_thread+0x5b3/0xf80
> kthread+0x35a/0x700
> ret_from_fork+0x2d/0x70
> ret_from_fork_asm+0x1a/0x30
>
>Note that this test may not fail in a kernel without the fix, but it may
>hang on the client side if it triggers a kernel oops.
>
>This works by creating a socket, trying to connect to a server, and then
>executing a second connect operation on the same socket but to a
>different CID (0). This triggers a transport change. If the connect
>operation is interrupted by a signal, this could cause a null-ptr-deref.
>
>Since this bug is non-deterministic, we need to try several times. It
>is reasonable to assume that the bug will show up within the timeout
>period.
>
>If there is a G2H transport loaded in the system, the bug is not
>triggered and this test will always pass. This is because
>`vsock_assign_transport`, when using CID 0, like in this case, sets
>vsk->transport to `transport_g2h` that is not NULL if a G2H transport is
>available.
>
>[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>
>Suggested-by: Hyunwoo Kim <v4bel@theori.io>
>Suggested-by: Michal Luczaj <mhal@rbox.co>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/Makefile     |   1 +
> tools/testing/vsock/vsock_test.c | 170 +++++++++++++++++++++++++++++++++++++++
> 2 files changed, 171 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>index 6e0b4e95e230500f99bb9c74350701a037ecd198..88211fd132d23ecdfd56ab0815580a237889e7f2 100644
>--- a/tools/testing/vsock/Makefile
>+++ b/tools/testing/vsock/Makefile
>@@ -5,6 +5,7 @@ vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o util.o msg_ze
> vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
> vsock_perf: vsock_perf.o msg_zerocopy_common.o
>
>+vsock_test: LDLIBS = -lpthread
> vsock_uring_test: LDLIBS = -luring
> vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o msg_zerocopy_common.o
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index eb6f54378667ac7ed324f4823e988ec9846e41a3..be6ce764f69480c0f9c3e2288fc19cd2e74be148 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -22,6 +22,8 @@
> #include <signal.h>
> #include <sys/ioctl.h>
> #include <linux/time64.h>
>+#include <pthread.h>
>+#include <fcntl.h>
>
> #include "vsock_test_zerocopy.h"
> #include "timeout.h"
>@@ -1867,6 +1869,169 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+#define TRANSPORT_CHANGE_TIMEOUT 2 /* seconds */
>+
>+static void *test_stream_transport_change_thread(void *vargp)
>+{
>+	pid_t *pid = (pid_t *)vargp;
>+	int ret;
>+
>+	ret = pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
>+	if (ret) {
>+		fprintf(stderr, "pthread_setcanceltype: %d\n", ret);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	while (true) {
>+		if (kill(*pid, SIGUSR1) < 0) {
>+			perror("kill");
>+			exit(EXIT_FAILURE);
>+		}
>+	}
>+	return NULL;
>+}
>+
>+static void test_transport_change_signal_handler(int signal)
>+{
>+	/* We need a custom handler for SIGUSR1 as the default one terminates the process. */
>+}
>+
>+static void test_stream_transport_change_client(const struct test_opts *opts)
>+{
>+	__sighandler_t old_handler;
>+	pid_t pid = getpid();
>+	pthread_t thread_id;
>+	time_t tout;
>+	int ret, tr;
>+
>+	tr = get_transports();
>+
>+	/* Print a warning if there is a G2H transport loaded.
>+	 * This is on a best effort basis because VMCI can be either G2H and H2G, and there is
>+	 * no easy way to understand it.
>+	 * The bug we are testing only appears when G2H transports are not loaded.
>+	 * This is because `vsock_assign_transport`, when using CID 0, assigns a G2H transport
>+	 * to vsk->transport. If none is available it is set to NULL, causing the null-ptr-deref.
>+	 */
>+	if (tr & TRANSPORTS_G2H)
>+		fprintf(stderr, "G2H Transport detected. This test will not fail.\n");
>+
>+	old_handler = signal(SIGUSR1, test_transport_change_signal_handler);
>+	if (old_handler == SIG_ERR) {
>+		perror("signal");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	ret = pthread_create(&thread_id, NULL, test_stream_transport_change_thread, &pid);
>+	if (ret) {
>+		fprintf(stderr, "pthread_create: %d\n", ret);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("LISTENING");
>+
>+	tout = current_nsec() + TRANSPORT_CHANGE_TIMEOUT * NSEC_PER_SEC;
>+	do {
>+		struct sockaddr_vm sa = {
>+			.svm_family = AF_VSOCK,
>+			.svm_cid = opts->peer_cid,
>+			.svm_port = opts->peer_port,
>+		};
>+		int s;
>+
>+		s = socket(AF_VSOCK, SOCK_STREAM, 0);
>+		if (s < 0) {
>+			perror("socket");
>+			exit(EXIT_FAILURE);
>+		}
>+
>+		ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
>+		/* The connect can fail due to signals coming from the thread,
>+		 * or because the receiver connection queue is full.
>+		 * Ignoring also the latter case because there is no way
>+		 * of synchronizing client's connect and server's accept when
>+		 * connect(s) are constantly being interrupted by signals.
>+		 */
>+		if (ret == -1 && (errno != EINTR && errno != ECONNRESET)) {
>+			perror("connect");
>+			exit(EXIT_FAILURE);
>+		}
>+
>+		/* Set CID to 0 cause a transport change. */
>+		sa.svm_cid = 0;
>+
>+		/* Ignore return value since it can fail or not.
>+		 * If the previous connect is interrupted while the
>+		 * connection request is already sent, the second
>+		 * connect() will wait for the response.
>+		 */
>+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>+
>+		close(s);
>+
>+		control_writeulong(CONTROL_CONTINUE);
>+
>+	} while (current_nsec() < tout);
>+
>+	control_writeulong(CONTROL_DONE);
>+
>+	ret = pthread_cancel(thread_id);
>+	if (ret) {
>+		fprintf(stderr, "pthread_cancel: %d\n", ret);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	ret = pthread_join(thread_id, NULL);
>+	if (ret) {
>+		fprintf(stderr, "pthread_join: %d\n", ret);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (signal(SIGUSR1, old_handler) == SIG_ERR) {
>+		perror("signal");
>+		exit(EXIT_FAILURE);
>+	}
>+}
>+
>+static void test_stream_transport_change_server(const struct test_opts *opts)
>+{
>+	int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>+
>+	/* Set the socket to be nonblocking because connects that have been interrupted
>+	 * (EINTR) can fill the receiver's accept queue anyway, leading to connect failure.
>+	 * As of today (6.15) in such situation there is no way to understand, from the
>+	 * client side, if the connection has been queued in the server or not.
>+	 */
>+	if (fcntl(s, F_SETFL, fcntl(s, F_GETFL, 0) | O_NONBLOCK) < 0) {
>+		perror("fcntl");
>+		exit(EXIT_FAILURE);
>+	}
>+	control_writeln("LISTENING");
>+
>+	while (control_readulong() == CONTROL_CONTINUE) {
>+		/* Must accept the connection, otherwise the `listen`
>+		 * queue will fill up and new connections will fail.
>+		 * There can be more than one queued connection,
>+		 * clear them all.
>+		 */
>+		while (true) {
>+			int client = accept(s, NULL, NULL);
>+
>+			if (client < 0) {
>+				if (errno == EAGAIN)
>+					break;
>+
>+				perror("accept");
>+				exit(EXIT_FAILURE);
>+			}
>+
>+			close(client);
>+		}
>+	}
>+
>+	close(s);
>+}
>+
> static void test_stream_linger_client(const struct test_opts *opts)
> {
> 	int fd;
>@@ -2106,6 +2271,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_nolinger_client,
> 		.run_server = test_stream_nolinger_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM transport change null-ptr-deref",
>+		.run_client = test_stream_transport_change_client,
>+		.run_server = test_stream_transport_change_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.50.0
>

