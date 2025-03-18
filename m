Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41206207650
	for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311479; cv=none; b=pL80h9pYheNUy6VKdMZfnvETiFOm9yUbTLZ6EMjPJAXimwy3RNTf9gKBg3jWqWdkbNhZyDl2GnxQKTpg2XMZixrAVIpCs0qnL+ZkO+aK0K5lbqO0PQ7qmD1GlFGyvH0KSbWJ/V34o9D4BZfcpdoWZSomQ5Hiiah+zln0idUFGpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311479; c=relaxed/simple;
	bh=nwUVJN4gAnpHbpMJTe6ZpZkbPRBWjH0WP7Gslu1wwWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=M7xi0ic9k5u4SheD7bbnw2Xw69CZ74/EnnP+JRIS2K2FxnmYwyrPzwkHZwB69u10meZxn5cQ+L0Wyk/qDYzDgLr0qtQBwgCrkw00Yi6iJioTnI+sPk3VbmPtggHHFu4p7t1u6XKBP1S37QS2d0TBq0x9VGsI+2S6gQwuVULxF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVu5yFpS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVu5yFpS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742311476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hqTTkSk1AS0bS0c1yGdSEW4YtI0XIvKuEUyQjEJj824=;
	b=iVu5yFpSh6YY/R2Y1T3vvDrSQhgcHHVW6N2yAz8j7fAiIxnlrhRkmTBRWmC5FwI43dPzq1
	2ozHuS8wcDoHf6yEqdkx/reVdtspJQJ2kt8I8nxCPX4YjepzSE9mvq7K/fBB1HpO1EWGkE
	u+P1g9pvyR56AFNllUTrw3i+2n/j9QA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-V_vph0JoNOOtrpjC-7q3Ug-1; Tue, 18 Mar 2025 11:24:35 -0400
X-MC-Unique: V_vph0JoNOOtrpjC-7q3Ug-1
X-Mimecast-MFC-AGG-ID: V_vph0JoNOOtrpjC-7q3Ug_1742311474
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac31990bdfdso520733166b.1
        for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 08:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742311474; x=1742916274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqTTkSk1AS0bS0c1yGdSEW4YtI0XIvKuEUyQjEJj824=;
        b=sRvIa/zzXVw3TijNN8um70rF8+1tuh4frwM/bav2Ml+0HqScbQj7+g9nw61qIN/cjh
         /yf7U5g3X1JhN3zNKVg1x2qG1bRI4yEdo6jW7eMgxUzyr0gP2mwAnGvhHoAKrIOFHyFm
         R/no24YZ7pPmULSQgvlgPHmJqI9HxGSTagMK7BrQLphLLBm6tyQT/nGRuZO9MFp5+3ol
         qCH241abfKiTOpZ6nEeLP9nnb6JipTVZ8dgLtVyGfs+lhsAPk9ttxK7hC8t/JXLvoG1W
         hbmArefhqedAT9jzGCmpd2GLzJfT9D6GJAP15uZ31su0bbex9RAXTYK9IY4eBATrdQFz
         0rLg==
X-Forwarded-Encrypted: i=1; AJvYcCXUluDpjHItiW4c3KteqncxusEpCNY1w1Rca0krON2N2PrqzJ1530rDU6I4f8dCdveNKMY0jb4vfkrhHq42XA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEpZwv9+4ld/Z25SGZKtxN24HzyG4fOj9n5CdNmFnJV/WCDme8
	2OPqjRNnRAEP9HSZGh6MWmy5JP+gJzj3F59tBgDA3I+JaF9/q5qLJq160ola6y0k39Gy38QuujP
	RaD9BtTV5Q4zQnmsf4Q4joAuc/qjgD0E7J6LGKWjJTFjy+YJrEKj36fQRcxcF/M9W
X-Gm-Gg: ASbGnct1jBIJbe+5Ellw1/ivfGhzHTCGQktszviyQF04T10P1ix8NSIE7NAAxXYl+Y+
	Xm/Lu7rSGDkscU8JO8LaqKnz3mx2pKLZGGL7Iv2fAsIk+voYQQw7LdWEwrvRtTJ0SsURTeQ8JGe
	t04iaScbgjbqqYWK4vXKiEslNvrBZleKEmONXUIeIu8a7e2HUlvmR1sgmr4CUIOg5Egphm/1etS
	5Xp5mYYUkS1neRVLcx0m7BJDrkxg3CpxbIWd7egX4NfZETAyoZWThB4mxx8oYGCL+BT3PFBcjLS
	4NuAjOKn+XndHkeZfF5QR7jGyvw+GnttJmlSR0OnfIGfAGtmCamqSMZEnJqv2RL3
X-Received: by 2002:a17:907:d92:b0:abe:fa18:1fc6 with SMTP id a640c23a62f3a-ac33010b594mr1889901666b.10.1742311473953;
        Tue, 18 Mar 2025 08:24:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYKgdyBOe4N9SqzNdQv0/ja/tFgBWXAA/B9X5QxvZp4bZLbnQYU/EpiDkc3dvPqkEg8rOP6g==
X-Received: by 2002:a17:907:d92:b0:abe:fa18:1fc6 with SMTP id a640c23a62f3a-ac33010b594mr1889895666b.10.1742311473178;
        Tue, 18 Mar 2025 08:24:33 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac37dc4e0afsm292211266b.21.2025.03.18.08.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:24:32 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:24:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hyunwoo Kim <v4bel@theori.io>
Subject: Re: [PATCH net-next v2] vsock/test: Add test for null ptr deref when
 transport changes
Message-ID: <tjuxwbbkwyi2ggjv6744h27rkk3kjhdbkv6mnzflg22brhakzq@dvcduolqwhl6>
References: <20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ndNHHm-9IVUHw1_QgsyewYUWrySvhnTqDmxXErfO33c_1742311474
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Mar 14, 2025 at 10:27:33AM +0100, Luigi Leonardi wrote:
>Add a new test to ensure that when the transport changes a null pointer
>dereference does not occur[1].

I'd add something like this:

"... does not occur. The bug was reported upstream [1] and fixed with
commit 2cb7c756f605 ("vsock/virtio: discard packets if the transport
changes")."

>
>Note that this test does not fail, but it may hang on the client side if
>it triggers a kernel oops.

In my case the test failed (I guess the other side that was still
working), so I'd say: "Note that this test may not fail in a kernel
without the fix, ..."

>
>This works by creating a socket, trying to connect to a server, and then
>executing a second connect operation on the same socket but to a
>different CID (0). This triggers a transport change. If the connect
>operation is interrupted by a signal, this could cause a null-ptr-deref.
>
>Since this bug is non-deterministic, we need to try several times. It
>is safe to assume that the bug will show up within the timeout period.

s/safe/reasonable

>
>If there is a G2H transport loaded in the system, the bug is not
>triggered and this test will always pass.

The rest LGTM.

Thanks,
Stefano

>
>[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>
>Suggested-by: Hyunwoo Kim <v4bel@theori.io>
>Suggested-by: Michal Luczaj <mhal@rbox.co>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
>This series introduces a new test that checks for a null pointer
>dereference that may happen when there is a transport change[1]. This
>bug was fixed in [2].
>
>Note that this test *cannot* fail, it hangs if it triggers a kernel
>oops. The intended use-case is to run it and then check if there is any
>oops in the dmesg.
>
>This test is based on Hyunwoo Kim's[3] and Michal's python
>reproducers[4].
>
>[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>[2]https://lore.kernel.org/netdev/20250110083511.30419-1-sgarzare@redhat.com/
>[3]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/#t
>[4]https://lore.kernel.org/netdev/2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co/
>---
>Changes in v2:
>- Addressed Stefano's comments:
>    - Timeout is now using current_nsec()
>    - Check for return values
>    - Style issues
>- Added Hyunwoo Kim to Suggested-by
>- Link to v1: https://lore.kernel.org/r/20250306-test_vsock-v1-0-0320b5accf92@redhat.com
>---
> tools/testing/vsock/Makefile     |   1 +
> tools/testing/vsock/vsock_test.c | 101 +++++++++++++++++++++++++++++++++++++++
> 2 files changed, 102 insertions(+)
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
>index d0f6d253ac72d08a957cb81a3c38fcc72bec5a53..d2820a67403c95bc4a7e7a16113ae2f6137b4c73 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -23,6 +23,7 @@
> #include <sys/ioctl.h>
> #include <linux/sockios.h>
> #include <linux/time64.h>
>+#include <pthread.h>
>
> #include "vsock_test_zerocopy.h"
> #include "timeout.h"
>@@ -1788,6 +1789,101 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void *test_stream_transport_change_thread(void *vargp)
>+{
>+	pid_t *pid = (pid_t *)vargp;
>+
>+	/* We want this thread to terminate as soon as possible */
>+	if (pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL)) {
>+		perror("pthread_setcanceltype");
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
>+
>+	old_handler = signal(SIGUSR1, test_transport_change_signal_handler);
>+	if (old_handler == SIG_ERR) {
>+		perror("signal");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (pthread_create(&thread_id, NULL, test_stream_transport_change_thread, &pid)) {
>+		perror("pthread_create");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
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
>+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>+
>+		/* Set CID to 0 cause a transport change. */
>+		sa.svm_cid = 0;
>+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>+
>+		close(s);
>+	} while (current_nsec() < tout);
>+
>+	if (pthread_cancel(thread_id)) {
>+		perror("pthread_cancel");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Wait for the thread to terminate */
>+	if (pthread_join(thread_id, NULL)) {
>+		perror("pthread_join");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Restore the old handler */
>+	if (signal(SIGUSR1, old_handler) == SIG_ERR) {
>+		perror("signal");
>+		exit(EXIT_FAILURE);
>+	}
>+}
>+
>+static void test_stream_transport_change_server(const struct test_opts *opts)
>+{
>+	time_t tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
>+
>+	do {
>+		int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>+
>+		close(s);
>+	} while (current_nsec() < tout);
>+}
>+
> static void test_stream_linger_client(const struct test_opts *opts)
> {
> 	struct linger optval = {
>@@ -1984,6 +2080,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_linger_client,
> 		.run_server = test_stream_linger_server,
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
>---
>base-commit: 4d872d51bc9d7b899c1f61534e3dbde72613f627
>change-id: 20250306-test_vsock-3e77a9c7a245
>
>Best regards,
>-- 
>Luigi Leonardi <leonardi@redhat.com>
>

