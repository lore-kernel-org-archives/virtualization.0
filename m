Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0D5C4332F
	for <virtualization@archiver.kernel.org>; Mon,  6 Nov 2023 10:48:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95D466115C;
	Mon,  6 Nov 2023 10:48:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 95D466115C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EcEREucO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6hbLYm6D4X12; Mon,  6 Nov 2023 10:48:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 032356111C;
	Mon,  6 Nov 2023 10:48:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 032356111C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D270BC0039;
	Mon,  6 Nov 2023 10:48:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62458C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:48:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3BD0B41465
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:48:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3BD0B41465
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EcEREucO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0CfG8ZZaWXr0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:48:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A9F7A41464
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:48:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A9F7A41464
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699267711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AY8KQ4dvEPvqonuERioJ87ft9Eic3IHQdrVBtrNqSWo=;
 b=EcEREucOH+GLWegbwMGGfNlERT/ekUyRxxklseJTzdL3FMtQyyHdjhm2gC1f8uQFV96tvP
 /xxNSZJR3k+a3MKtEdNZ8ezhEjlHs0a/zFsO1bGVx22E+MIammMZw65ShBlB4z0oBIsfRs
 C+H37Z9Wj71iHQYu6i5P83kXZtNdxOc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-dJTZ3jqWP_C2erFeRREKFw-1; Mon, 06 Nov 2023 05:48:30 -0500
X-MC-Unique: dJTZ3jqWP_C2erFeRREKFw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6707401e1aeso51760806d6.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Nov 2023 02:48:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699267709; x=1699872509;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AY8KQ4dvEPvqonuERioJ87ft9Eic3IHQdrVBtrNqSWo=;
 b=H3DFiGFJ9F3zPzVOhyrjfn3pJ1kjzJI7bc+uxIOWPN0deBd+265ls8X1Avs2c6KlcW
 0b5yNXNJLlidxhyzBTmGnsaLUPC59QXVGDVb9Z3p2ULptLKYDYMx1koIb7KMdxx5FRP3
 jZEHcAtzrXuJmt3dgT93M5hk+71eN22sih/1JEsqIoXeO/9p054G6fC4JD1N2vQz0WSA
 S8PHCES2g9/zZ7qUgesRmR5noTn/kgODfLDLF/OwZHTFsD3Wmh7/ErzNnbraoLaDlP+C
 x+nkBDGOIR0nB8OZbMLfu9E55xp8HprFplvRCr5AWotm/y6nWQxiHEKiiL2OmINlNFTL
 qBHw==
X-Gm-Message-State: AOJu0YzO0tpWsUKg7qnQ4qz2waekE+JbwGYS4uwa4O1gxEEgA4GUeUTJ
 2u8ys0wfCPwnna/DySg1aK3l9dB8ID3VPsHZJSR5eurCxJ7V2BFQMzUpN0n6PwUu1HZjNud78Wh
 E58Ok7jX0y73CoebXlkXB37tTDjCiJpUa8nUrc+GhSg==
X-Received: by 2002:a05:6214:1bc6:b0:671:c324:9f45 with SMTP id
 m6-20020a0562141bc600b00671c3249f45mr26686713qvc.37.1699267709726; 
 Mon, 06 Nov 2023 02:48:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSWODpMGqUx3V+1IHlXcJNCdjNt6jKwKZosYLRGIC47MezPBYolbbHK/PWFX0kgd39uUHuxA==
X-Received: by 2002:a05:6214:1bc6:b0:671:c324:9f45 with SMTP id
 m6-20020a0562141bc600b00671c3249f45mr26686691qvc.37.1699267709389; 
 Mon, 06 Nov 2023 02:48:29 -0800 (PST)
Received: from sgarzare-redhat ([5.179.191.143])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a0cea45000000b00670bd5a3720sm3334051qvp.97.2023.11.06.02.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 02:48:29 -0800 (PST)
Date: Mon, 6 Nov 2023 11:48:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: f.storniolo95@gmail.com
Subject: Re: [PATCH net 4/4] test/vsock: add dobule bind connect test
Message-ID: <65r6y2wdx3grj6ofsat2c2rpqwijvnfni2yxsbwnr6vcjalbpt@5rh46vj2dbcc>
References: <20231103175551.41025-1-f.storniolo95@gmail.com>
 <20231103175551.41025-5-f.storniolo95@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20231103175551.41025-5-f.storniolo95@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 imbrenda@linux.vnet.ibm.com, edumazet@google.com, stefanha@redhat.com,
 kuba@kernel.org, asias@redhat.com, pabeni@redhat.com,
 luigi.leonardi@outlook.com, davem@davemloft.net
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

On Fri, Nov 03, 2023 at 06:55:51PM +0100, f.storniolo95@gmail.com wrote:
>From: Filippo Storniolo <f.storniolo95@gmail.com>
>
>This add bind connect test which creates a listening server socket
>and tries to connect a client with a bound local port to it twice.
>
>Co-developed-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Filippo Storniolo <f.storniolo95@gmail.com>
>---
> tools/testing/vsock/util.c       | 47 ++++++++++++++++++++++++++++++
> tools/testing/vsock/util.h       |  3 ++
> tools/testing/vsock/vsock_test.c | 50 ++++++++++++++++++++++++++++++++
> 3 files changed, 100 insertions(+)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 2fc96f29bdf2..ae2b33c21c45 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -85,6 +85,48 @@ void vsock_wait_remote_close(int fd)
> 	close(epollfd);
> }
>
>+/* Bind to <bind_port>, connect to <cid, port> and return the file descriptor. */
>+int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_port, int type)
>+{
>+	struct sockaddr_vm sa_client = {
>+		.svm_family = AF_VSOCK,
>+		.svm_cid = VMADDR_CID_ANY,
>+		.svm_port = bind_port,
>+	};
>+	struct sockaddr_vm sa_server = {
>+		.svm_family = AF_VSOCK,
>+		.svm_cid = cid,
>+		.svm_port = port,
>+	};
>+
>+	int client_fd, ret;
>+
>+	client_fd = socket(AF_VSOCK, type, 0);
>+	if (client_fd < 0) {
>+		perror("socket");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (bind(client_fd, (struct sockaddr *)&sa_client, sizeof(sa_client))) {
>+		perror("bind");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	timeout_begin(TIMEOUT);
>+	do {
>+		ret = connect(client_fd, (struct sockaddr *)&sa_server, sizeof(sa_server));
>+		timeout_check("connect");
>+	} while (ret < 0 && errno == EINTR);
>+	timeout_end();
>+
>+	if (ret < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	return client_fd;
>+}
>+
> /* Connect to <cid, port> and return the file descriptor. */
> static int vsock_connect(unsigned int cid, unsigned int port, int type)
> {
>@@ -223,6 +265,11 @@ int vsock_stream_accept(unsigned int cid, unsigned int port,
> 	return vsock_accept(cid, port, clientaddrp, SOCK_STREAM);
> }
>
>+int vsock_stream_listen(unsigned int cid, unsigned int port)
>+{
>+	return vsock_listen(cid, port, SOCK_STREAM);
>+}
>+
> int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> 			   struct sockaddr_vm *clientaddrp)
> {
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index a77175d25864..03c88d0cb861 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -36,9 +36,12 @@ struct test_case {
> void init_signals(void);
> unsigned int parse_cid(const char *str);
> int vsock_stream_connect(unsigned int cid, unsigned int port);
>+int vsock_bind_connect(unsigned int cid, unsigned int port,
>+		       unsigned int bind_port, int type);
> int vsock_seqpacket_connect(unsigned int cid, unsigned int port);
> int vsock_stream_accept(unsigned int cid, unsigned int port,
> 			struct sockaddr_vm *clientaddrp);
>+int vsock_stream_listen(unsigned int cid, unsigned int port);
> int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> 			   struct sockaddr_vm *clientaddrp);
> void vsock_wait_remote_close(int fd);
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index c1f7bc9abd22..5b0e93f9996c 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1180,6 +1180,51 @@ static void test_stream_shutrd_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void test_double_bind_connect_server(const struct test_opts *opts)
>+{
>+	int listen_fd, client_fd, i;
>+	struct sockaddr_vm sa_client;
>+	socklen_t socklen_client = sizeof(sa_client);
>+
>+	listen_fd = vsock_stream_listen(VMADDR_CID_ANY, 1234);
>+
>+	for (i = 0; i < 2; i++) {
>+		control_writeln("LISTENING");
>+
>+		timeout_begin(TIMEOUT);
>+		do {
>+			client_fd = accept(listen_fd, (struct sockaddr *)&sa_client,
>+					   &socklen_client);
>+			timeout_check("accept");
>+		} while (client_fd < 0 && errno == EINTR);
>+		timeout_end();
>+
>+		if (client_fd < 0) {
>+			perror("accept");
>+			exit(EXIT_FAILURE);
>+		}
>+
>+		/* Waiting for remote peer to close connection */
>+		vsock_wait_remote_close(client_fd);
>+	}
>+
>+	close(listen_fd);
>+}
>+
>+static void test_double_bind_connect_client(const struct test_opts *opts)
>+{
>+	int i, client_fd;
>+
>+	for (i = 0; i < 2; i++) {
>+		/* Wait until server is ready to accept a new connection */
>+		control_expectln("LISTENING");
>+
>+		client_fd = vsock_bind_connect(opts->peer_cid, 1234, 4321, SOCK_STREAM);
>+
>+		close(client_fd);
>+	}
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1285,6 +1330,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_msgzcopy_empty_errq_client,
> 		.run_server = test_stream_msgzcopy_empty_errq_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM double bind connect",
>+		.run_client = test_double_bind_connect_client,
>+		.run_server = test_double_bind_connect_server,
>+	},
> 	{},
> };
>
>-- 
>2.41.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
