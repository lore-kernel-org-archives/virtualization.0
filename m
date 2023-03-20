Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C5FC7618A
	for <virtualization@archiver.kernel.org>; Mon, 20 Mar 2023 15:31:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2CB014020B;
	Mon, 20 Mar 2023 15:31:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2CB014020B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fGCkUo0O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LvEbkG5YP-5L; Mon, 20 Mar 2023 15:31:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8749C40184;
	Mon, 20 Mar 2023 15:31:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8749C40184
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DD2DC0035;
	Mon, 20 Mar 2023 15:31:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47222C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 15:31:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 21CCB415FE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 15:31:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 21CCB415FE
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fGCkUo0O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G7_ZJjKvPAKg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 15:31:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 16F2C409EA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16F2C409EA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 15:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679326303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4kPJZ32Y+l53box6ko+ne5cwDvp4Win8rdXeR0QS2JU=;
 b=fGCkUo0OkgNzQ0OppMZ5fphmJm9DGhO4QUhynQfJ5pDsiYty5IYkXyXxw5sPGblhOsXhdj
 1B0Dtm3LF+VoSTdasXyjFfB2hBeGGSYQZc4lxJGjtviUpekvSV9XxByQw9jM820I/IRkbA
 MljCWqDzgOwd+E9l99itnvsEZEYGTJI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-MVlLuENDMO-3F0b1bd17xg-1; Mon, 20 Mar 2023 11:31:39 -0400
X-MC-Unique: MVlLuENDMO-3F0b1bd17xg-1
Received: by mail-wm1-f69.google.com with SMTP id
 n38-20020a05600c3ba600b003ed29a0b729so5696036wms.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 08:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679326298;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4kPJZ32Y+l53box6ko+ne5cwDvp4Win8rdXeR0QS2JU=;
 b=D02bRmPCVFt3Xe9fKmP+Im0DcK6J3+0JngNsxyK30neeTcqo2xYQFbSupF38Fqg39Q
 YospXQu+QIIZQGjHc2Qm8JIA4aQuQuy7c2FwNyLZZcwiFBnwcl+UsLc1SngilPHldJPd
 uXUdPZ7HF3eInfHfAj0cVSqGZ5lHeEBEyXvu26ik1PW+96bSxDxPxBfklt1U9QQk+bmb
 j2pH0nY7kJ6tBOW4sA8oC8yCok6Wn7GKjhICuT6OB4yzyZ8eS0wFu89pBjQ8u0hMtHov
 +tmfppSJtcrszLRKvlDYQRDikogX1pDtikGS7gCAj0H7yH5oW/0lqclQ2sKZuPETnLO/
 MOmQ==
X-Gm-Message-State: AO0yUKX9ZBRj0zt5J21XZJ49VI25peJEH+TUQ1Al9vNy5uaIwdDKNHn9
 xXYeo09Bo+O9bTZg/xXtrO2Htu8rhEKe5uD3Z+qrEO+L4C4XlzUApo9JN5ccB4dezK/GzHg4GZ2
 hJT0yIj5uKFPU1al6OeYps0Ig+kLon/KiuEg3DrRE4w==
X-Received: by 2002:a05:600c:3aca:b0:3ed:6049:a5ae with SMTP id
 d10-20020a05600c3aca00b003ed6049a5aemr9662594wms.4.1679326298129; 
 Mon, 20 Mar 2023 08:31:38 -0700 (PDT)
X-Google-Smtp-Source: AK7set+K/iSPqBhOxqnDWry6nMA6XFyLEMJvZ5BagJzhVQg80QiS5si7gT89jIVKwdv6jvS+LcnPCg==
X-Received: by 2002:a05:600c:3aca:b0:3ed:6049:a5ae with SMTP id
 d10-20020a05600c3aca00b003ed6049a5aemr9662575wms.4.1679326297864; 
 Mon, 20 Mar 2023 08:31:37 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c314b00b003e7c89b3514sm7332828wmo.23.2023.03.20.08.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Mar 2023 08:31:37 -0700 (PDT)
Date: Mon, 20 Mar 2023 16:31:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 3/3] test/vsock: skbuff merging test
Message-ID: <20230320153132.o3xvwxmn3722lin4@sgarzare-redhat>
References: <e141e6f1-00ae-232c-b840-b146bdb10e99@sberdevices.ru>
 <14ca87d1-3e07-85e9-d11c-39789a9d17d4@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <14ca87d1-3e07-85e9-d11c-39789a9d17d4@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Sun, Mar 19, 2023 at 09:53:54PM +0300, Arseniy Krasnov wrote:
>This adds test which checks case when data of newly received skbuff is
>appended to the last skbuff in the socket's queue.
>
>This test is actual only for virtio transport.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 81 ++++++++++++++++++++++++++++++++
> 1 file changed, 81 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 3de10dbb50f5..00216c52d8b6 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -968,6 +968,82 @@ static void test_seqpacket_inv_buf_server(const struct test_opts *opts)
> 	test_inv_buf_server(opts, false);
> }
>
>+static void test_stream_virtio_skb_merge_client(const struct test_opts *opts)
>+{
>+	ssize_t res;
>+	int fd;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, 1234);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+

Please use a macro for "HELLO" or a variabile, e.g.

         char *buf;
         ...

         buf = "HELLO";
         res = send(fd, buf, strlen(buf), 0);
         ...

>+	res = send(fd, "HELLO", strlen("HELLO"), 0);
>+	if (res != strlen("HELLO")) {
>+		fprintf(stderr, "unexpected send(2) result %zi\n", res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("SEND0");
>+	/* Peer reads part of first packet. */
>+	control_expectln("REPLY0");
>+
>+	/* Send second skbuff, it will be merged. */
>+	res = send(fd, "WORLD", strlen("WORLD"), 0);

Ditto.

>+	if (res != strlen("WORLD")) {
>+		fprintf(stderr, "unexpected send(2) result %zi\n", res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("SEND1");
>+	/* Peer reads merged skbuff packet. */
>+	control_expectln("REPLY1");
>+
>+	close(fd);
>+}
>+
>+static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
>+{
>+	unsigned char buf[64];
>+	ssize_t res;
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("SEND0");
>+
>+	/* Read skbuff partially. */
>+	res = recv(fd, buf, 2, 0);
>+	if (res != 2) {
>+		fprintf(stderr, "expected recv(2) failure, got %zi\n", res);

We don't expect a failure, so please update the error message and make
it easy to figure out which recv() is failing. For example by saying
how many bytes you expected and how many you received.

>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("REPLY0");
>+	control_expectln("SEND1");
>+
>+
>+	res = recv(fd, buf, sizeof(buf), 0);

Perhaps a comment here to explain why we expect only 8 bytes.

>+	if (res != 8) {
>+		fprintf(stderr, "expected recv(2) failure, got %zi\n", res);

Ditto.

>+		exit(EXIT_FAILURE);
>+	}
>+
>+	res = recv(fd, buf, sizeof(buf), MSG_DONTWAIT);
>+	if (res != -1) {
>+		fprintf(stderr, "expected recv(2) success, got %zi\n", res);

It's the other way around, isn't it?
Here you expect it to fail instead it is not failing.

>+		exit(EXIT_FAILURE);
>+	}

Moving the pointer correctly, I would also check that there is
HELLOWORLD in the buffer.

Thanks for adding tests in this suite!
Stefano

>+
>+	control_writeln("REPLY1");
>+
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1038,6 +1114,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_inv_buf_client,
> 		.run_server = test_seqpacket_inv_buf_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM virtio skb merge",
>+		.run_client = test_stream_virtio_skb_merge_client,
>+		.run_server = test_stream_virtio_skb_merge_server,
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
