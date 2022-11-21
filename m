Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF45FC4332F
	for <virtualization@archiver.kernel.org>; Mon, 21 Nov 2022 14:53:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E95181B53;
	Mon, 21 Nov 2022 14:53:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E95181B53
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FGk0dMG9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ih7ElEIhvJMw; Mon, 21 Nov 2022 14:53:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DD07E8197D;
	Mon, 21 Nov 2022 14:52:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD07E8197D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97B9DC0033;
	Mon, 21 Nov 2022 14:52:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1549DC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 14:52:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E445A60B27
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 14:52:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E445A60B27
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FGk0dMG9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hENjYvBWutBn
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 14:52:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2702160B23
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2702160B23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 14:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669042376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tyYoQDvW5BLwsxIUp85ljPCfFSUwHbhCNM6YdC5pOm0=;
 b=FGk0dMG9U3VmOgKd7Sbo4spjI63ae6ZNqCDkwDRzV1VAHHl/zJryKze8YlHtokRertcKBI
 JcFCJpV+RZOpG+6TL4Ah0y47NTf/ApGi0GYXpSHcw5T46iiZTqi1k2GsZMlCM6JC5MfuEK
 KHtc0UuUAtcRPG43N6zoTe6pp5XC3cQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-256-FOyfFFbPNmGubBupOqM22A-1; Mon, 21 Nov 2022 09:52:54 -0500
X-MC-Unique: FOyfFFbPNmGubBupOqM22A-1
Received: by mail-wm1-f69.google.com with SMTP id
 1-20020a05600c028100b003cf7833293cso9407761wmk.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 06:52:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tyYoQDvW5BLwsxIUp85ljPCfFSUwHbhCNM6YdC5pOm0=;
 b=CBpBpVtjqnyZT59nvq8l2NpVUgUkMFGPZhDB6O50Q9EHNSTjUAIroAL/0SqeuR/5TV
 UtIWp2691krw1zgM8/fucrkZcCuiJXWSa1sZeA5b9BghyFY2C+5KAGV307IbVKwS/vf3
 MkLldTOQukfHFBIMChnbhv1Pdu6JdysbQhccSxuAhPTuB8/VairvAxAk+OyNfsIWpzWt
 zvVcZ6/SnGF2sKUa5eJY4riZnA11ssM3ilnL807vmrSnXzORGH0srOaqUwXWbQiAgA+e
 qcJNgGU1FguuFVsxRiYPLcsZQGCx/XErInwCeOalFCfGPxpD033Y8y0NQLh9BE3jX0R1
 3kHA==
X-Gm-Message-State: ANoB5plQJCJYhWgGLahsxUxrySiOfRwDLPc/Q9aTULeUxvHjpYFFXVGU
 gsFosYAoALZZ5uG0tW/a0gbawfz3Tgx3Dr+hdkl2+X3IDA+j+HGeWohbCUY0wmSB+MJZZpvXcrb
 8VZa/jtlhOO1xzQk+wpgEQ3ojpKHqq4cnsGILO1JjUA==
X-Received: by 2002:a05:600c:3d16:b0:3c6:de4a:d768 with SMTP id
 bh22-20020a05600c3d1600b003c6de4ad768mr1677483wmb.61.1669042373652; 
 Mon, 21 Nov 2022 06:52:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5jdJos1x+fJLl/VjateAcyVlqjFB0fbz73X92rukgJDZZKLp+g2j6EymPu53UGC0WeUNRsJg==
X-Received: by 2002:a05:600c:3d16:b0:3c6:de4a:d768 with SMTP id
 bh22-20020a05600c3d1600b003c6de4ad768mr1677469wmb.61.1669042373452; 
 Mon, 21 Nov 2022 06:52:53 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 o18-20020a05600c4fd200b003cfa26c410asm20547986wmq.20.2022.11.21.06.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Nov 2022 06:52:53 -0800 (PST)
Date: Mon, 21 Nov 2022 15:52:48 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 2/3] test/vsock: add big message test
Message-ID: <20221121145248.cmscv5vg3fir543x@sgarzare-redhat>
References: <ba294dff-812a-bfc2-a43c-286f99aee0b8@sberdevices.ru>
 <f0510949-cc97-7a01-5fc8-f7e855b80515@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <f0510949-cc97-7a01-5fc8-f7e855b80515@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Bobby Eshleman <bobby.eshleman@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Krasnov Arseniy <oxffffaa@gmail.com>, kernel <kernel@sberdevices.ru>
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

On Tue, Nov 15, 2022 at 08:52:35PM +0000, Arseniy Krasnov wrote:
>This adds test for sending message, bigger than peer's buffer size.
>For SOCK_SEQPACKET socket it must fail, as this type of socket has
>message size limit.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 62 ++++++++++++++++++++++++++++++++
> 1 file changed, 62 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 107c11165887..bb4e8657f1d6 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -560,6 +560,63 @@ static void test_seqpacket_timeout_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
>+{
>+	unsigned long sock_buf_size;
>+	ssize_t send_size;
>+	socklen_t len;
>+	void *data;
>+	int fd;
>+
>+	len = sizeof(sock_buf_size);
>+
>+	fd = vsock_seqpacket_connect(opts->peer_cid, 1234);

Not for this patch, but someday we should add a macro for this port and 
maybe even make it configurable :-)

>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (getsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>+		       &sock_buf_size, &len)) {
>+		perror("getsockopt");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	sock_buf_size++;
>+
>+	data = malloc(sock_buf_size);
>+	if (!data) {
>+		perror("malloc");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	send_size = send(fd, data, sock_buf_size, 0);
>+	if (send_size != -1) {

Can we check also `errno`?
IIUC it should contains EMSGSIZE.

>+		fprintf(stderr, "expected 'send(2)' failure, got %zi\n",
>+			send_size);
>+	}
>+
>+	control_writeln("CLISENT");
>+
>+	free(data);
>+	close(fd);
>+}
>+
>+static void test_seqpacket_bigmsg_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("CLISENT");
>+
>+	close(fd);
>+}
>+
> #define BUF_PATTERN_1 'a'
> #define BUF_PATTERN_2 'b'
>
>@@ -832,6 +889,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_timeout_client,
> 		.run_server = test_seqpacket_timeout_server,
> 	},
>+	{
>+		.name = "SOCK_SEQPACKET big message",
>+		.run_client = test_seqpacket_bigmsg_client,
>+		.run_server = test_seqpacket_bigmsg_server,
>+	},

I would add new tests always at the end, so if some CI uses --skip, we 
don't have to update the scripts to skip some tests.

> 	{
> 		.name = "SOCK_SEQPACKET invalid receive buffer",
> 		.run_client = test_seqpacket_invalid_rec_buffer_client,
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
