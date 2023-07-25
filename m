Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C88C001DE
	for <virtualization@archiver.kernel.org>; Tue, 25 Jul 2023 15:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 076F941529;
	Tue, 25 Jul 2023 15:40:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 076F941529
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A1ci2n3N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sHAhYXV2Ya6j; Tue, 25 Jul 2023 15:40:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8189341528;
	Tue, 25 Jul 2023 15:40:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8189341528
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AF37C0071;
	Tue, 25 Jul 2023 15:40:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60CD8C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 15:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F30F8140A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 15:40:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F30F8140A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=A1ci2n3N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KNA9T58lsfmY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 15:40:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1B1D180EC2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 15:40:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1B1D180EC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690299608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DtjuQEYBysLf5IPBPQqG0dtkZp2a3tmx6LZMEFCT4Do=;
 b=A1ci2n3NJ942VeOflzhPUyRN05uN7KPYCbPu/I2/ew62vwZRS3PiyNBQqoGYuXSPW0fGAa
 az+Cl++nq1HapAXVyYapV7pJ/qL9Y4aHXeE4k3XqJF01SbgTvZO+Ef129HZ2CvLjXrLRHD
 HRjI2+OEN/5lbffEq9apNRZXbdmu1oQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-ZvWWRmlkM2qFaQ6rYUUqFw-1; Tue, 25 Jul 2023 11:40:06 -0400
X-MC-Unique: ZvWWRmlkM2qFaQ6rYUUqFw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-765de3a3404so798905785a.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 08:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690299606; x=1690904406;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DtjuQEYBysLf5IPBPQqG0dtkZp2a3tmx6LZMEFCT4Do=;
 b=Cmqg61Zh+wA+RdY5dlJ8uA8VloxTOjMEnvo63GEbskqWmCkQ7JEfWkOMUc3sIr1Km+
 pUpqAsY/eRj6XkAAKW+L/SjhW8BFMKoSut4cMT+fLW3v4EHBdFJ60tztwJSZK13EWPax
 adzWSTnBVjNhecUFwN5mKNQaWHEAeUZLa9woj96XPI3e9B1SpnC4V8g6wGpNs0ERscDa
 MuRzPywip6JaeJ+fr85mHNSy1mKMIQ3BGXv1ZxuaM1oCaRmQiqsZtrgSTkpFdMLrzGwG
 H3R1FYI7kWq6fyTV0DYWTU5Erb2TiC5/Mxt3JvB4gwYsTS1yNAFSN2JaJ/ST8kbtbjmV
 wgpw==
X-Gm-Message-State: ABy/qLbdUu8VkwrhNLTgpGgavo07/9kGeScpBb+h0wp9RqZnwYj5cnsr
 XuxLcFMDfIHbM+xYSk6dCbl8dFX5bXf/w0gXOdJKLfNbmSAB1IQPigIA4f32cKnqQDMJ+ki2yqz
 8Nn7R4VdU4245B+HN+GI1hfFPnPp+eA66bcHIj0+oFA==
X-Received: by 2002:a05:620a:218b:b0:767:dd72:68a0 with SMTP id
 g11-20020a05620a218b00b00767dd7268a0mr3217551qka.73.1690299605987; 
 Tue, 25 Jul 2023 08:40:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFZVy88xuYM5gaAVvj+fpdBp2vTTrdGeiv4z5i5xWjqyut/xez/YNHtY8x0EI0HNIa8YER6+w==
X-Received: by 2002:a05:620a:218b:b0:767:dd72:68a0 with SMTP id
 g11-20020a05620a218b00b00767dd7268a0mr3217536qka.73.1690299605744; 
 Tue, 25 Jul 2023 08:40:05 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.153.113])
 by smtp.gmail.com with ESMTPSA id
 4-20020a05620a06c400b00765a676b75csm3751894qky.21.2023.07.25.08.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 08:40:05 -0700 (PDT)
Date: Tue, 25 Jul 2023 17:39:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 3/4] vsock/test: rework MSG_PEEK test for
 SOCK_STREAM
Message-ID: <fefl2wuphc73qm26n62mhs3x5qrbirfd5334u3xeblpghgkdq5@h4a2t4nljyoi>
References: <20230719192708.1775162-1-AVKrasnov@sberdevices.ru>
 <20230719192708.1775162-4-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230719192708.1775162-4-AVKrasnov@sberdevices.ru>
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

On Wed, Jul 19, 2023 at 10:27:07PM +0300, Arseniy Krasnov wrote:
>This new version makes test more complicated by adding empty read,
>partial read and data comparisons between MSG_PEEK and normal reads.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 78 ++++++++++++++++++++++++++++++--
> 1 file changed, 75 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index ac1bd3ac1533..444a3ff0681f 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -255,9 +255,14 @@ static void test_stream_multiconn_server(const struct test_opts *opts)
> 		close(fds[i]);
> }
>
>+#define MSG_PEEK_BUF_LEN 64
>+
> static void test_stream_msg_peek_client(const struct test_opts *opts)
> {
>+	unsigned char buf[MSG_PEEK_BUF_LEN];
>+	ssize_t send_size;
> 	int fd;
>+	int i;
>
> 	fd = vsock_stream_connect(opts->peer_cid, 1234);
> 	if (fd < 0) {
>@@ -265,12 +270,32 @@ static void test_stream_msg_peek_client(const struct test_opts *opts)
> 		exit(EXIT_FAILURE);
> 	}
>
>-	send_byte(fd, 1, 0);
>+	for (i = 0; i < sizeof(buf); i++)
>+		buf[i] = rand() & 0xFF;
>+
>+	control_expectln("SRVREADY");
>+
>+	send_size = send(fd, buf, sizeof(buf), 0);
>+
>+	if (send_size < 0) {
>+		perror("send");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (send_size != sizeof(buf)) {
>+		fprintf(stderr, "Invalid send size %zi\n", send_size);
>+		exit(EXIT_FAILURE);
>+	}
>+
> 	close(fd);
> }
>
> static void test_stream_msg_peek_server(const struct test_opts *opts)
> {
>+	unsigned char buf_half[MSG_PEEK_BUF_LEN / 2];
>+	unsigned char buf_normal[MSG_PEEK_BUF_LEN];
>+	unsigned char buf_peek[MSG_PEEK_BUF_LEN];
>+	ssize_t res;
> 	int fd;
>
> 	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
>@@ -279,8 +304,55 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
> 		exit(EXIT_FAILURE);
> 	}
>
>-	recv_byte(fd, 1, MSG_PEEK);
>-	recv_byte(fd, 1, 0);
>+	/* Peek from empty socket. */
>+	res = recv(fd, buf_peek, sizeof(buf_peek), MSG_PEEK | MSG_DONTWAIT);
>+	if (res != -1) {
>+		fprintf(stderr, "expected recv(2) failure, got %zi\n", res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (errno != EAGAIN) {
>+		perror("EAGAIN expected");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("SRVREADY");
>+
>+	/* Peek part of data. */
>+	res = recv(fd, buf_half, sizeof(buf_half), MSG_PEEK);
>+	if (res != sizeof(buf_half)) {
>+		fprintf(stderr, "recv(2) + MSG_PEEK, expected %zu, got %zi\n",
>+			sizeof(buf_half), res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Peek whole data. */
>+	res = recv(fd, buf_peek, sizeof(buf_peek), MSG_PEEK);
>+	if (res != sizeof(buf_peek)) {
>+		fprintf(stderr, "recv(2) + MSG_PEEK, expected %zu, got %zi\n",
>+			sizeof(buf_peek), res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Compare partial and full peek. */
>+	if (memcmp(buf_half, buf_peek, sizeof(buf_half))) {
>+		fprintf(stderr, "Partial peek data mismatch\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	res = recv(fd, buf_normal, sizeof(buf_normal), 0);
>+	if (res != sizeof(buf_normal)) {
>+		fprintf(stderr, "recv(2), expected %zu, got %zi\n",
>+			sizeof(buf_normal), res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Compare full peek and normal read. */
>+	if (memcmp(buf_peek, buf_normal, sizeof(buf_peek))) {
>+		fprintf(stderr, "Full peek data mismatch\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
> 	close(fd);
> }
>
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
