Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96B2C001DF
	for <virtualization@archiver.kernel.org>; Wed,  2 Aug 2023 08:00:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7623E60655;
	Wed,  2 Aug 2023 08:00:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7623E60655
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FRF/ShVN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ATKQQyPJzziZ; Wed,  2 Aug 2023 08:00:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0591D60DE5;
	Wed,  2 Aug 2023 08:00:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0591D60DE5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3BA3C0072;
	Wed,  2 Aug 2023 08:00:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C552C0072
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 08:00:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 46F3580C29
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 08:00:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 46F3580C29
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FRF/ShVN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KtxNu3Ub0dHM
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 08:00:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 431D082009
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 08:00:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 431D082009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690963241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oX2LNKOIHdzcvnsRpFJ7qJD3bKveDIMqdWllDVDTcVI=;
 b=FRF/ShVNpMQLFCaXAEy0HC8Onc+/W2jErat7a2QSwmt4IWpcim/2Egc8HOzozlKzYaPD2D
 UwQzVc8//gwzpRcAsTQWX8iDyQJVPvgCXw1BXKRd+6YmVRj356jG8gOYcdBKh9fgQ0kSJU
 J2hnN1AOjqRr2HHpqMvqHD2bADC0YYE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-O19Fq2KlPRy1oxK-AUYDRw-1; Wed, 02 Aug 2023 04:00:39 -0400
X-MC-Unique: O19Fq2KlPRy1oxK-AUYDRw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-403b066c6e7so84575901cf.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Aug 2023 01:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690963239; x=1691568039;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oX2LNKOIHdzcvnsRpFJ7qJD3bKveDIMqdWllDVDTcVI=;
 b=OM1nUDjKDEZk4PqV9ZvF595J71fAgJQCBwFXXUvE5HHDAyKGmEnAEKAo+jGPB2bXO0
 nIkeQhFtAWEPfJZ9/601RJnbzuBUKhokAPqOXAXgi59Ha7Hw25i933ZLmCazvaRI9V1L
 JeaniMzLif16Vyr86/YPScVXUW0n3s9YCPbpyIjsUWyaIdySN7wDzjcy7EZl4vK0PIPR
 WkmDYUeUCYs+CNkhJSkpZtaEKzFVuggaSschttiU9sfII0tZ1KMrxqF1+6/Vt86FqL+B
 UkqA03jGdRvhEQpKRvcxrR35O7bUGBeO8xKjjdzGjrLo0xSN01nlsJcskhT8crmV9jP+
 0hEA==
X-Gm-Message-State: ABy/qLZP8OF3voxJCDahfonOKPnKuVWdsZG4OCh+V1yFEstiWfTUWXIG
 xRlq5tKWeYqSuWz/WCF6Epg8hzJBYLqLOoB72S6knSz7ITLWAS6Qn/2CXSDt4vGd7WnxsXz1tKs
 f9rEszgaCrV2zJR9kTnjgqDPAMBIl+EYBvMuHmTozOw==
X-Received: by 2002:a05:622a:208:b0:403:b12b:908d with SMTP id
 b8-20020a05622a020800b00403b12b908dmr22409161qtx.8.1690963239454; 
 Wed, 02 Aug 2023 01:00:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGrOKV3rYZOQ8uyqLMK5NY1CIny88EL3WOMwRsqXwVgCP9aOiPOtdVkUVSrpY7PwwrzUZO25A==
X-Received: by 2002:a05:622a:208:b0:403:b12b:908d with SMTP id
 b8-20020a05622a020800b00403b12b908dmr22409133qtx.8.1690963239236; 
 Wed, 02 Aug 2023 01:00:39 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-214.retail.telecomitalia.it.
 [82.57.51.214]) by smtp.gmail.com with ESMTPSA id
 g8-20020ac87748000000b00401217aa51dsm5074523qtu.76.2023.08.02.01.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 01:00:38 -0700 (PDT)
Date: Wed, 2 Aug 2023 10:00:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 2/2] test/vsock: shutdowned socket test
Message-ID: <76yecufn7766obfi5zae5hpg6yrlestrqocnk56jgnukakkdds@rqbgbhh7xgck>
References: <20230801141727.481156-1-AVKrasnov@sberdevices.ru>
 <20230801141727.481156-3-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230801141727.481156-3-AVKrasnov@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Aug 01, 2023 at 05:17:27PM +0300, Arseniy Krasnov wrote:
>This adds two tests for 'shutdown()' call. It checks that SIGPIPE is
>sent when MSG_NOSIGNAL is not set and vice versa. Both flags SHUT_WR
>and SHUT_RD are tested.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 138 +++++++++++++++++++++++++++++++
> 1 file changed, 138 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 90718c2fd4ea..21d40a8d881c 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -19,6 +19,7 @@
> #include <time.h>
> #include <sys/mman.h>
> #include <poll.h>
>+#include <signal.h>
>
> #include "timeout.h"
> #include "control.h"
>@@ -1170,6 +1171,133 @@ static void test_seqpacket_msg_peek_server(const struct test_opts *opts)
> 	return test_msg_peek_server(opts, true);
> }
>
>+static bool have_sigpipe;
                  ^
We should define it as `volatile sig_atomic_t`:

the behavior is undefined if the signal handler refers to any object
[CX] [Option Start]  other than errno [Option End]  with static storage
duration other than by assigning a value to an object declared as
volatile sig_atomic_t

https://pubs.opengroup.org/onlinepubs/9699919799/functions/signal.html

The rest LGTM!

Thanks,
Stefano

>+
>+static void sigpipe(int signo)
>+{
>+	have_sigpipe = true;
>+}
>+
>+static void test_stream_check_sigpipe(int fd)
>+{
>+	ssize_t res;
>+
>+	have_sigpipe = false;
>+
>+	res = send(fd, "A", 1, 0);
>+	if (res != -1) {
>+		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (!have_sigpipe) {
>+		fprintf(stderr, "SIGPIPE expected\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	have_sigpipe = false;
>+
>+	res = send(fd, "A", 1, MSG_NOSIGNAL);
>+	if (res != -1) {
>+		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (have_sigpipe) {
>+		fprintf(stderr, "SIGPIPE not expected\n");
>+		exit(EXIT_FAILURE);
>+	}
>+}
>+
>+static void test_stream_shutwr_client(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	struct sigaction act = {
>+		.sa_handler = sigpipe,
>+	};
>+
>+	sigaction(SIGPIPE, &act, NULL);
>+
>+	fd = vsock_stream_connect(opts->peer_cid, 1234);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (shutdown(fd, SHUT_WR)) {
>+		perror("shutdown");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	test_stream_check_sigpipe(fd);
>+
>+	control_writeln("CLIENTDONE");
>+
>+	close(fd);
>+}
>+
>+static void test_stream_shutwr_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("CLIENTDONE");
>+
>+	close(fd);
>+}
>+
>+static void test_stream_shutrd_client(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	struct sigaction act = {
>+		.sa_handler = sigpipe,
>+	};
>+
>+	sigaction(SIGPIPE, &act, NULL);
>+
>+	fd = vsock_stream_connect(opts->peer_cid, 1234);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("SHUTRDDONE");
>+
>+	test_stream_check_sigpipe(fd);
>+
>+	control_writeln("CLIENTDONE");
>+
>+	close(fd);
>+}
>+
>+static void test_stream_shutrd_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (shutdown(fd, SHUT_RD)) {
>+		perror("shutdown");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("SHUTRDDONE");
>+	control_expectln("CLIENTDONE");
>+
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1250,6 +1378,16 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_msg_peek_client,
> 		.run_server = test_seqpacket_msg_peek_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM SHUT_WR",
>+		.run_client = test_stream_shutwr_client,
>+		.run_server = test_stream_shutwr_server,
>+	},
>+	{
>+		.name = "SOCK_STREAM SHUT_RD",
>+		.run_client = test_stream_shutrd_client,
>+		.run_server = test_stream_shutrd_server,
>+	},
> 	{},
> };
>
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
