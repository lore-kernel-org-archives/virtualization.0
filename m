Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9F1C001DE
	for <virtualization@archiver.kernel.org>; Wed, 26 Jul 2023 08:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70D92611D7;
	Wed, 26 Jul 2023 08:05:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 70D92611D7
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D2y9qFFS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u7vl7GQNNQB2; Wed, 26 Jul 2023 08:05:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 031C860838;
	Wed, 26 Jul 2023 08:05:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 031C860838
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C40A8C0071;
	Wed, 26 Jul 2023 08:05:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 274A6C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 08:05:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F24CA404F8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 08:05:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F24CA404F8
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=D2y9qFFS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id svUb83rFjCYJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 08:05:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E6C5E4039D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 08:05:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E6C5E4039D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690358700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eAjNRIihSOf+ZWCQiGmuIak9rrS2S/b0k59m1Q9Sn58=;
 b=D2y9qFFSWHyEV8u0lnzCJTC/xcib4g3cBlOtoZRigUatAorygFGLzo3jDNsMjg1xn5YKel
 tua/3X3JMomFZEJ/MWmR5UoTN7EvR4A9Hvz/IhsyP9HhoLxRglAaQ+lqCPeZ/UHr85liEr
 cMqnNA10JFFxjvuH6xec7XYg5tDxc6U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-8d3S0xNfP_K-tqaCBydOKw-1; Wed, 26 Jul 2023 04:04:57 -0400
X-MC-Unique: 8d3S0xNfP_K-tqaCBydOKw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-51da39aa6dcso4921034a12.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 01:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690358696; x=1690963496;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eAjNRIihSOf+ZWCQiGmuIak9rrS2S/b0k59m1Q9Sn58=;
 b=HJyN6Yx2XgeWM4J8n8dwtL06WrhaStBkmBn6IwzbGqekJ2y9FV9RMXuKfUL4Esh3h3
 mFugvGfLGzVhyUsFpGOMcXEZ9JbgZ7wp0d490ybcQcR8CyXj9cfxoBkQaBhInuGa+bNH
 yNQET0HaQX9oQ8c96Pv4+aUgDSfRaMObC8ANa+jDSi9ynM+z3icODoB+9DAPi/y9LdVC
 KCfTHCO66TMyGJtQohcraRlyStBib65SKgFpDl0f4DEFpXSFQIE+I0320KSluii2mBHy
 Tm6u7Q9pBoRqL7sTzAkS4eDMNGMThzXAfRK9QtilgCJdkWgpdKS09CIC0MmLZo5c70+A
 kFGg==
X-Gm-Message-State: ABy/qLY+CCh0Gs3TKJ7MZGimpQe2doGtQ0hBBoSiaCeETchQ6qdUIjuH
 5mW88OPEJ1eOhSz0QmqgR0bTyN8km+5Qc3VLeuPjjlKmj1tcb9CBZBFF+JJu+OlmGhEHz493lwx
 Fikd9SnC0fxgi4rHceuUqrZuG96xeteSM2ROLYNOa5Q==
X-Received: by 2002:a05:6402:1489:b0:522:30cc:a1f0 with SMTP id
 e9-20020a056402148900b0052230cca1f0mr1048241edv.14.1690358696042; 
 Wed, 26 Jul 2023 01:04:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH9cTC/+4nVrUrzuc8eu1ehgpHLqa3C+TMwtpTbgkUOYw+ZUE8Z5I+GDauZapCy0HXIvtSFdQ==
X-Received: by 2002:a05:6402:1489:b0:522:30cc:a1f0 with SMTP id
 e9-20020a056402148900b0052230cca1f0mr1048219edv.14.1690358695716; 
 Wed, 26 Jul 2023 01:04:55 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.111.137])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a056402068500b0051ded17b30bsm8479399edy.40.2023.07.26.01.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 01:04:55 -0700 (PDT)
Date: Wed, 26 Jul 2023 10:04:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [PATCH net-next v3 4/4] vsock/test: MSG_PEEK test for
 SOCK_SEQPACKET
Message-ID: <fbyxkuf3z3grrwnj6riwy4fki47yqfrdplhmcsd4ye3ga7apsk@5zeiorqk6uaz>
References: <20230725172912.1659970-1-AVKrasnov@sberdevices.ru>
 <20230725172912.1659970-5-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230725172912.1659970-5-AVKrasnov@sberdevices.ru>
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

On Tue, Jul 25, 2023 at 08:29:12PM +0300, Arseniy Krasnov wrote:
>This adds MSG_PEEK test for SOCK_SEQPACKET. It works in the same way as
>SOCK_STREAM test, except it also tests MSG_TRUNC flag.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 58 +++++++++++++++++++++++++++++---
> 1 file changed, 54 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 444a3ff0681f..90718c2fd4ea 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -257,14 +257,19 @@ static void test_stream_multiconn_server(const struct test_opts *opts)
>
> #define MSG_PEEK_BUF_LEN 64
>
>-static void test_stream_msg_peek_client(const struct test_opts *opts)
>+static void test_msg_peek_client(const struct test_opts *opts,
>+				 bool seqpacket)
> {
> 	unsigned char buf[MSG_PEEK_BUF_LEN];
> 	ssize_t send_size;
> 	int fd;
> 	int i;
>
>-	fd = vsock_stream_connect(opts->peer_cid, 1234);
>+	if (seqpacket)
>+		fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
>+	else
>+		fd = vsock_stream_connect(opts->peer_cid, 1234);
>+
> 	if (fd < 0) {
> 		perror("connect");
> 		exit(EXIT_FAILURE);
>@@ -290,7 +295,8 @@ static void test_stream_msg_peek_client(const struct test_opts *opts)
> 	close(fd);
> }
>
>-static void test_stream_msg_peek_server(const struct test_opts *opts)
>+static void test_msg_peek_server(const struct test_opts *opts,
>+				 bool seqpacket)
> {
> 	unsigned char buf_half[MSG_PEEK_BUF_LEN / 2];
> 	unsigned char buf_normal[MSG_PEEK_BUF_LEN];
>@@ -298,7 +304,11 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
> 	ssize_t res;
> 	int fd;
>
>-	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (seqpacket)
>+		fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
>+	else
>+		fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
>+
> 	if (fd < 0) {
> 		perror("accept");
> 		exit(EXIT_FAILURE);
>@@ -340,6 +350,21 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
> 		exit(EXIT_FAILURE);
> 	}
>
>+	if (seqpacket) {
>+		/* This type of socket supports MSG_TRUNC flag,
>+		 * so check it with MSG_PEEK. We must get length
>+		 * of the message.
>+		 */
>+		res = recv(fd, buf_half, sizeof(buf_half), MSG_PEEK |
>+			   MSG_TRUNC);
>+		if (res != sizeof(buf_peek)) {
>+			fprintf(stderr,
>+				"recv(2) + MSG_PEEK | MSG_TRUNC, exp %zu, got %zi\n",
>+				sizeof(buf_half), res);
>+			exit(EXIT_FAILURE);
>+		}
>+	}
>+
> 	res = recv(fd, buf_normal, sizeof(buf_normal), 0);
> 	if (res != sizeof(buf_normal)) {
> 		fprintf(stderr, "recv(2), expected %zu, got %zi\n",
>@@ -356,6 +381,16 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void test_stream_msg_peek_client(const struct test_opts *opts)
>+{
>+	return test_msg_peek_client(opts, false);
>+}
>+
>+static void test_stream_msg_peek_server(const struct test_opts *opts)
>+{
>+	return test_msg_peek_server(opts, false);
>+}
>+
> #define SOCK_BUF_SIZE (2 * 1024 * 1024)
> #define MAX_MSG_SIZE (32 * 1024)
>
>@@ -1125,6 +1160,16 @@ static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void test_seqpacket_msg_peek_client(const struct test_opts *opts)
>+{
>+	return test_msg_peek_client(opts, true);
>+}
>+
>+static void test_seqpacket_msg_peek_server(const struct test_opts *opts)
>+{
>+	return test_msg_peek_server(opts, true);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1200,6 +1245,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_virtio_skb_merge_client,
> 		.run_server = test_stream_virtio_skb_merge_server,
> 	},
>+	{
>+		.name = "SOCK_SEQPACKET MSG_PEEK",
>+		.run_client = test_seqpacket_msg_peek_client,
>+		.run_server = test_seqpacket_msg_peek_server,
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
