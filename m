Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1361AC83F2E
	for <virtualization@archiver.kernel.org>; Thu, 31 Aug 2023 15:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99CFB837AC;
	Thu, 31 Aug 2023 15:13:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 99CFB837AC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gwWvJg3T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wM7-m5Dg8FcK; Thu, 31 Aug 2023 15:13:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EC558835D9;
	Thu, 31 Aug 2023 15:13:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC558835D9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7B09C0039;
	Thu, 31 Aug 2023 15:13:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07935C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 15:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C7A97835D9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 15:13:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C7A97835D9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a-RlGM-OPwUR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 15:13:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D38C6836EA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 15:13:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D38C6836EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693494788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7q3Y4yiktGEyTW0UFreHL9GRNARDnev7O8/a837iJGA=;
 b=gwWvJg3TvpczOtxkSOvmmZLRd4/9NNdrzLSi8dPUeRAW7jQHoINKpzRWvkobLnBC0ggksk
 2TnXYcQrW+YVuNTa28Gxb3UFbiVYifd73W0PEA8aDxLlzroRgJoeiHXxNrcB8IoSO0pUzB
 SjHL3RqK2QD7DVZ63S2X7e3vHviy2hw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-CBBpZaYfMJiCqD5y1b9HrA-1; Thu, 31 Aug 2023 11:13:07 -0400
X-MC-Unique: CBBpZaYfMJiCqD5y1b9HrA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-52a08d02c62so706528a12.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 08:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693494786; x=1694099586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7q3Y4yiktGEyTW0UFreHL9GRNARDnev7O8/a837iJGA=;
 b=HBKfqWueZ8TTeltBs8H8GLZW/lbdgw1HbjGcrr8M4WyjT6Zkwmjl7diUZWrqGHU/lO
 ULLSyv++l9ySMmrI3ykVseF/Vtx4ASVnXX1blWZoG0z/vaZ+mOakedeluPodBOaWR6Al
 5DsEUI+sWJM37Y6Ibh78JINHX05r6AYdNCduFkLGJw8kDG7YMnnEB5I8HGOJHlftJU13
 wWXKKV8cDJ+OAs+79NF+yRyLciyRiik+hwbSiVIVXuVnzGCiG4shMEIpaYxyrPr8qM+X
 SkGwkjvEjAdKPEroaP2fWt8X1sDYqn1umQ+Ole1l1jPgpebweLRKf7KOJtGGuQNtO5hX
 7X9Q==
X-Gm-Message-State: AOJu0YyyluPHa5XSt0b9NU8oljy2NzM8p4Z4clBW/TYnI6rCMrjBKngW
 Y4enDIkJDq6k7ekR6Se4+S3sxMFLAxHbfdJpEFgIEvc9ugBc9MJOColx7p7YCgDd8YkLgZJytc6
 Bhmv8oJ3Ma/dgtrB9HiXR08TRc+yQkTnwxDneORxTrQ==
X-Received: by 2002:a17:907:2711:b0:99b:627b:e96d with SMTP id
 w17-20020a170907271100b0099b627be96dmr3925091ejk.44.1693494786297; 
 Thu, 31 Aug 2023 08:13:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF715v/t0gaQyatoS18qed412E+sQSxkJ3L84oJw2LaknRVSuElh16mJtXthOZpoaHZRxEsZQ==
X-Received: by 2002:a17:907:2711:b0:99b:627b:e96d with SMTP id
 w17-20020a170907271100b0099b627be96dmr3925080ejk.44.1693494785954; 
 Thu, 31 Aug 2023 08:13:05 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 i2-20020a1709064ec200b0099bc8db97bcsm852964ejv.131.2023.08.31.08.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 08:13:05 -0700 (PDT)
Date: Thu, 31 Aug 2023 17:13:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [RFC PATCH v2 2/2] test/vsock: shutdowned socket test
Message-ID: <tejk4hvlsjalsrm4fimm7vojhwhluj6ous3im33kmkydpmv6fi@nvy3twy6gtxy>
References: <20230826175900.3693844-1-avkrasnov@salutedevices.com>
 <20230826175900.3693844-3-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20230826175900.3693844-3-avkrasnov@salutedevices.com>
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

On Sat, Aug 26, 2023 at 08:59:00PM +0300, Arseniy Krasnov wrote:
>This adds two tests for 'shutdown()' call. It checks that SIGPIPE is
>sent when MSG_NOSIGNAL is not set and vice versa. Both flags SHUT_WR
>and SHUT_RD are tested.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> tools/testing/vsock/vsock_test.c | 138 +++++++++++++++++++++++++++++++
> 1 file changed, 138 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 90718c2fd4ea..148fc9c47c50 100644
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
>+static sig_atomic_t have_sigpipe;
>+
>+static void sigpipe(int signo)
>+{
>+	have_sigpipe = 1;
>+}
>+
>+static void test_stream_check_sigpipe(int fd)
>+{
>+	ssize_t res;
>+
>+	have_sigpipe = 0;
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
>+	have_sigpipe = 0;
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
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
