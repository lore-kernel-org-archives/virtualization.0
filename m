Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9194D25A64A
	for <virtualization@lists.linux.dev>; Thu,  6 Mar 2025 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280723; cv=none; b=PjI4F1ZiSCWzhEC3LzWL8GwQVcp7I+mjlcKsJe1qlGrNTpQIWhKy/ZLFoXJf/5eMOFuxCVFIwyj7i5PBDHFwfjQVwWb6buNV6Mp/nApZtZ3wYbE8JfQ3SS1xZ0Ma6zw/7X4sgNOzluTkgfRnI9aKS0qIjcsF1/A46s6cjREaaow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280723; c=relaxed/simple;
	bh=juBDRNImR2QnHw+IxkfJS8lxpFiWsVRDf+BVRf9RC/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=X7Ec+gwA2QtPKykdO1cc0E5LEgXhA23ujyuNJdYvF+be+w+ZtovHnI8T1kpzzUKByvGwINz0oTbkHFZxS1qv0VCZBwlrBmuElF8XIQfTZ60eRneMUv4amO/8izMUl4Pe6+74jTju53pH5XVVxo3dVwoTarpM5wRKnQFzwVa7vSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ID+SbpYN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ID+SbpYN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741280720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rts5eSskbnJp/CQFVaAat8eJ+DA7k4QIn4k1VQ/bSLY=;
	b=ID+SbpYN+XBD/FTkRLLFs7lb6UNEj0p9H36Z04m/LhMlp/s40C4FBHyHLneP/RKxjCKNMT
	O51NTFb3qV1drmU0hXBbVEr/3lMDUHF96kRfSWOniTa3AO1VxlX+WApbZ0mYmBwqUJcdCT
	S8YM6bGGqyNc8Lxue1p6Brt97xx5Id4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-Bf2yjmAtPyOCrqOGUy8Icw-1; Thu, 06 Mar 2025 12:05:14 -0500
X-MC-Unique: Bf2yjmAtPyOCrqOGUy8Icw-1
X-Mimecast-MFC-AGG-ID: Bf2yjmAtPyOCrqOGUy8Icw_1741280713
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912a0439afso368367f8f.3
        for <virtualization@lists.linux.dev>; Thu, 06 Mar 2025 09:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741280712; x=1741885512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rts5eSskbnJp/CQFVaAat8eJ+DA7k4QIn4k1VQ/bSLY=;
        b=PnYdhHI49KPu2sxiO8mydaiKauUWBh8m5KJNWURsHVvHJn9vtI1nQeqBrjm8UZneof
         5oY/peuiZst8i12SLz0lgI5q8mQssMPQNg51oQNclwLvMNs7nZzg35LaHOHJKYDg7uiI
         nsOJiYFWD64zK8nPrDY07S3468mjxDDT5Cjax40qfGq5d7YNSFz9xHmf0Ah9BgWtumAf
         XlO5u0NuOQxyRfwgsJkK36CUOd99UD3LEEr3Vqy2z58FPkguTNzEJwp/dpQvl9/QtcL4
         Y8O4f0bE+r/A1V6yjRZ5wZOPK5JH98bOA3t4j3thQVvnjELsnwWMadVaE6n/RA80NPku
         hHCg==
X-Forwarded-Encrypted: i=1; AJvYcCV3FbyonwYok/v7Qb19JY4VA9m18jlK1mTrsWUGNPDs8lL/2QNEC2qZWYGZk/FFKr5bqJ63Hy75at3qjURXRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsnXEfEfcxa8DVWGZiyqpIgNoX+9m2BqjUR+11MU0j+M7+i6K1
	N3WMOG3IEw/MtSH2GgkA26tnxqJMBNQG4YXPDvb9ZAddk+8vsn2XidyGh2C+KXVDt0R+j3UtfDg
	CiY7mqYJbQ0IsMGAhKD9n2zH23euDfwKgHDRLhA8lJqAGC8IQXct6vBbb7D8nYXDFwhAAROVw
X-Gm-Gg: ASbGncuNy3NAUBrYJ9sKFLK72vsxfbcoW3t24RtRPRU/huyys1M8VG2tvVrUFYtCs6B
	gLRY9wRg567ptcA79VeYjZHmJWcgzy960/30ne1t5nzFV/haQWiO0LOrgaiDCgoHFWVWlmN4dz4
	KVJxgWuTq3Yd6XPekpQHp8NiFYa2j+jz6wYQbx5WAXGXlpVXP7kaJnk6Mhf6K203RO3SckgFrOf
	P9xkWRtsPDBavaxiIWiglLeK+Ua+8FPvwE+/M8SsmdpA7Y5fES8H+RWlVH6puKzj978Qrx9wvK9
	O9t4j6eCufWZGKLTMIBI/4Y5s0S77Qr9x3PqxWEqKJuyWzXkJHJEHzJuVSerg1Ky
X-Received: by 2002:a05:6000:1449:b0:390:f971:4ecd with SMTP id ffacd0b85a97d-3911f764cb9mr7120575f8f.26.1741280712168;
        Thu, 06 Mar 2025 09:05:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkaWSlL+r0y99UcBiSFo86iDccFc9BimFwiW02LQK5dm6lsqELUu1YfKEo2PEg2KrOfTUthA==
X-Received: by 2002:a05:6000:1449:b0:390:f971:4ecd with SMTP id ffacd0b85a97d-3911f764cb9mr7120511f8f.26.1741280711456;
        Thu, 06 Mar 2025 09:05:11 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfdfdsm2679033f8f.34.2025.03.06.09.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 09:05:09 -0800 (PST)
Date: Thu, 6 Mar 2025 18:05:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] vsock/test: Add test for null ptr deref
 when transport changes
Message-ID: <7ea5ikhvo2iupdlwuolemqrtswmogogpofso7u5pir3eggnjab@iacdjg4r64ss>
References: <20250306-test_vsock-v1-0-0320b5accf92@redhat.com>
 <20250306-test_vsock-v1-2-0320b5accf92@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250306-test_vsock-v1-2-0320b5accf92@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: syhLcCP3kBTCKwV_XO8LQmJvrNsDm3ewYcW4PjKNpnc_1741280713
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Mar 06, 2025 at 05:09:33PM +0100, Luigi Leonardi wrote:
>Add a new test to ensure that when the transport changes a null pointer
>dereference does not occur[1].
>
>Note that this test does not fail, but it may hang on the client side if
>it triggers a kernel oops.
>
>This works by creating a socket, trying to connect to a server, and then
>executing a second connect operation on the same socket but to a
>different CID (0). This triggers a transport change. If the connect
>operation is interrupted by a signal, this could cause a null-ptr-deref.
>
>Since this bug is non-deterministic, we need to try several times. It
>is safe to assume that the bug will show up within the timeout period.
>
>If there is a G2H transport loaded in the system, the bug is not
>triggered and this test will always pass.
>
>[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>
>Suggested-by: Michal Luczaj <mhal@rbox.co>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/Makefile     |  1 +
> tools/testing/vsock/vsock_test.c | 80 ++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 81 insertions(+)
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
>index d0f6d253ac72d08a957cb81a3c38fcc72bec5a53..1e00cb6e117859d5c18fb3e52a574444b5489173 100644
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
>@@ -1788,6 +1789,80 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void *test_transport_change_thread(void *vargp)
>+{
>+	pid_t *t = (pid_t *)vargp;
>+
>+	//We want this thread to terminate as soon as possible

Please follow the stile in this file, we use /* Something ... */ for
comments.

>+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
>+
>+	while (true)
>+		kill(*t, SIGUSR1);

Should we check the return value of kill()?

>+	return NULL;
>+}
>+
>+static void test_transport_change_signal_handler(int signal)
>+{

Can you put comment here to explain why it's empty?

>+}
>+
>+static void test_transport_change_client(const struct test_opts *opts)
>+{
>+	__sighandler_t old_handler;
>+	pid_t pid = getpid();
>+	pthread_t thread_id;
>+
>+	old_handler = signal(SIGUSR1, test_transport_change_signal_handler);
>+
>+	pthread_create(&thread_id, NULL, test_transport_change_thread, &pid);
>+
>+	timeout_begin(TIMEOUT);
>+
>+	while (true) {

What about `while (timeout_check_expired()) {` here?

>+		struct sockaddr_vm sa = {
>+			.svm_family = AF_VSOCK,
>+			.svm_cid = opts->peer_cid,
>+			.svm_port = opts->peer_port,
>+		};
>+
>+		int s = socket(AF_VSOCK, SOCK_STREAM, 0);

Please check that `s` is a valid file descriptor.

>+
>+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>+

Maybe I'd add a comment here to explain why we are setting
`svm_cid = 0`.

>+		sa.svm_cid = 0;
>+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>+
>+		close(s);
>+
>+		if (timeout_check_expired())
>+			break;
>+	}
>+
>+	timeout_end();
>+
>+	pthread_cancel(thread_id);
>+	//Wait for the thread to terminate
>+	pthread_join(thread_id, NULL);

Please check return values and fix the comment style.

>+	//Restore the old handler
>+	signal(SIGUSR1, old_handler);
>+}
>+
>+static void test_transport_change_server(const struct test_opts *opts)
>+{
>+	timeout_begin(TIMEOUT);

Instead of using timeout_begin(), etc. on both sides, can we do 
something similar to what we did in test_stream_leak_acceptq_client() 
and test_stream_leak_acceptq_server() ?

>+
>+	while (true) {
>+		int s;
>+
>+		s = vsock_stream_listen(opts->peer_cid, opts->peer_port);
>+		close(s);
>+
>+		if (timeout_check_expired())
>+			break;
>+	}
>+
>+	timeout_end();
>+}
>+
> static void test_stream_linger_client(const struct test_opts *opts)
> {
> 	struct linger optval = {
>@@ -1984,6 +2059,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_linger_client,
> 		.run_server = test_stream_linger_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM transport change null-ptr-deref",
>+		.run_client = test_transport_change_client,
>+		.run_server = test_transport_change_server,

Following the other test, I'd call `test_stream_transport_change...`.

Thanks,
Stefano

>+	},
> 	{},
> };
>
>
>-- 
>2.48.1
>

