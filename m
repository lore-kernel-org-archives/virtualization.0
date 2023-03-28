Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57184C76196
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 09:31:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F282382258;
	Tue, 28 Mar 2023 09:31:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F282382258
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ToDI76g6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D7zy2_iA-bRX; Tue, 28 Mar 2023 09:31:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8BA4382257;
	Tue, 28 Mar 2023 09:31:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8BA4382257
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F87EC0037;
	Tue, 28 Mar 2023 09:31:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AEA7C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:31:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DD3A082258
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:31:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD3A082258
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vud_plm8hOBU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:31:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1680D82257
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1680D82257
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679995858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KWP56QTwI0j5S4y9OZwMMK69ElYFfc3hdgO7pVbXfvc=;
 b=ToDI76g6aWsfP86V1zNUmDsznEW03GiWX55RSZIeQrB813+k/n9nSYD/30x79CZZDj+dkv
 LG8H2NNCG161hQmDc95vcmoqFoHJNPcj3L3IIms43bfT+SfPvjeEOZJ+1jvSVnao5A8XNF
 Du71QXyE+YXn+i743sAP0ws1rbmVlTU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-a_9DHmAYMvC8PJcNs6rqHA-1; Tue, 28 Mar 2023 05:30:57 -0400
X-MC-Unique: a_9DHmAYMvC8PJcNs6rqHA-1
Received: by mail-qv1-f70.google.com with SMTP id
 c15-20020a056214070f00b005bb308e7c12so4741003qvz.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679995857;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWP56QTwI0j5S4y9OZwMMK69ElYFfc3hdgO7pVbXfvc=;
 b=PfenOHfq+ydXaLa2U3gwjLSlHQYZvrLpill2JtReRB27/4rx/UcEvjTthzC800CEMq
 xsNJKYuNIN+far06UwX73zdIMgHVuoelAXKY2vFxfsy0tyepL37azVYdfOzxnaAwqGSg
 XnkhPjG3hfc3WM9d5W73PPsxxp3EUnd5PP80Dqxf5aluscsmhG641AG5LBVl5i3fRerp
 5LWeVuEj+UhXLGdkrjBqMPzK9hi3lLqQbkw+d5Wecdka+4uyAkS8roBrL9nN2lBsibUy
 QhYtn3KOyHBOcN27reT2lvQ0y+4SaUI5lnPvPZzgS3SIN1vKC6/KzGZHEC8Ucd4iVSeG
 aLOA==
X-Gm-Message-State: AAQBX9fhZ978NgQ0OvLuxEhP6Y8qsn0SiRy1TRCGTtL0us2HQkZZBqq+
 xSfFOzr1YNMCoqbOFnBGlfmP6pkMHfyFmqwz4ny0ohlchuGFY71gzTmpKR9g5EFkE/920NTG01p
 /UKkwK3dcy/ac44YaQCajXlzldUFSjZKfr6Li1m9lcg==
X-Received: by 2002:a05:6214:f67:b0:5a9:d6dd:271e with SMTP id
 iy7-20020a0562140f6700b005a9d6dd271emr28333797qvb.18.1679995856866; 
 Tue, 28 Mar 2023 02:30:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZwIE40bSx1WKsFgqe2PCHGzCXvqVs53jO1BzC3wYrOuhs7M2wOyYY3HNPlwUdzzs+Ntl0tyQ==
X-Received: by 2002:a05:6214:f67:b0:5a9:d6dd:271e with SMTP id
 iy7-20020a0562140f6700b005a9d6dd271emr28333776qvb.18.1679995856610; 
 Tue, 28 Mar 2023 02:30:56 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it.
 [82.53.134.98]) by smtp.gmail.com with ESMTPSA id
 cy2-20020a05621418c200b005deeeba2aa2sm1892696qvb.43.2023.03.28.02.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Mar 2023 02:30:56 -0700 (PDT)
Date: Tue, 28 Mar 2023 11:30:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 3/3] test/vsock: new skbuff appending test
Message-ID: <fgtpnj6zgti2ed2xcwwfetv5lnie7onph3inqm6y3mrisaumtw@y47xhizbyf7m>
References: <728181e9-6b35-0092-3d01-3d7aff4521b6@sberdevices.ru>
 <776a30e8-3cd5-35ba-5187-63c9b83eaa44@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <776a30e8-3cd5-35ba-5187-63c9b83eaa44@sberdevices.ru>
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

On Sun, Mar 26, 2023 at 01:10:16AM +0300, Arseniy Krasnov wrote:
>This adds test which checks case when data of newly received skbuff is
>appended to the last skbuff in the socket's queue. It looks like simple
>test with 'send()' and 'recv()', but internally it triggers logic which
>appends one received skbuff to another. Test checks that this feature
>works correctly.
>
>This test is actual only for virtio transport.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 90 ++++++++++++++++++++++++++++++++
> 1 file changed, 90 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 3de10dbb50f5..12b97c92fbb2 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -968,6 +968,91 @@ static void test_seqpacket_inv_buf_server(const struct test_opts *opts)
> 	test_inv_buf_server(opts, false);
> }
>
>+#define HELLO_STR "HELLO"
>+#define WORLD_STR "WORLD"
>+
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
>+	/* Send first skbuff. */
>+	res = send(fd, HELLO_STR, strlen(HELLO_STR), 0);
>+	if (res != strlen(HELLO_STR)) {
>+		fprintf(stderr, "unexpected send(2) result %zi\n", res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("SEND0");
>+	/* Peer reads part of first skbuff. */
>+	control_expectln("REPLY0");
>+
>+	/* Send second skbuff, it will be appended to the first. */
>+	res = send(fd, WORLD_STR, strlen(WORLD_STR), 0);
>+	if (res != strlen(WORLD_STR)) {
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
>+		fprintf(stderr, "expected recv(2) returns 2 bytes, got %zi\n", res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("REPLY0");
>+	control_expectln("SEND1");
>+
>+	res = recv(fd, buf + 2, sizeof(buf) - 2, 0);
>+	if (res != 8) {
>+		fprintf(stderr, "expected recv(2) returns 8 bytes, got %zi\n", res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	res = recv(fd, buf, sizeof(buf) - 8 - 2, MSG_DONTWAIT);
>+	if (res != -1) {
>+		fprintf(stderr, "expected recv(2) failure, got %zi\n", res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (memcmp(buf, HELLO_STR WORLD_STR, strlen(HELLO_STR WORLD_STR))) {
>+		fprintf(stderr, "pattern mismatch\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("REPLY1");
>+
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1038,6 +1123,11 @@ static struct test_case test_cases[] = {
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
