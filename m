Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2429C433FE
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 08:36:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77C994162D;
	Tue, 15 Mar 2022 08:36:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xeb3F6HP0VHi; Tue, 15 Mar 2022 08:36:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BCEC2415F1;
	Tue, 15 Mar 2022 08:36:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61565C001A;
	Tue, 15 Mar 2022 08:36:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFAA5C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:36:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC2A960C03
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:36:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zJJZZGNqzSsP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:36:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3D31605B0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647333387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2TjZMMWckYPCusYdTg3nZxKbfkYGtNa7vCLFQzshC50=;
 b=XcSn76gfc32DlflElyJ3oP53xGMJqq+nvS8NqQVFruAE5eyZZko0N8rLJW0PFZxM8OTLAo
 vpwQkepw/cAiqn4vKK5351BB542e8sdAGHAABPc0Vy+8uAFLmYWtEEGHfHVEKD8Ao3IFB9
 fQPYNWPbymbrQi3s3WG0OL+8uznWqTY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-qf4IdT8EMrqxqKDkL3cbyA-1; Tue, 15 Mar 2022 04:36:26 -0400
X-MC-Unique: qf4IdT8EMrqxqKDkL3cbyA-1
Received: by mail-qv1-f71.google.com with SMTP id
 es11-20020a056214192b00b004354eecad3bso16011897qvb.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 01:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2TjZMMWckYPCusYdTg3nZxKbfkYGtNa7vCLFQzshC50=;
 b=YPxD9Kk7upYkrFOxyFHOSKb70npc1BXxzcEAcLa5HCrBthenbhggTEY6LQo7msN4ug
 oyiHon3mq1StlmHNZAlu0rix77XcJ+9487GVq4f5he8FtfULmP67qgnrUaFX6uhBKdc+
 cVYZPQqlnYklOyNNyGib+muNryurPziwfrW5tY48W1Y/9UjFOfuM0L8foW+bIHHvP5YQ
 thbaz587Q6I621dT01/bfS4lAz23iY/z4AzpRgCoBduuSaLPYTzgYyhPu0DplpUNygXH
 SImGt4v2Bi4m/lCWjTpchFlAUJvKgE/ntawSqZ5vP4cJkGBPv4mlp3cKYTixR/32+40s
 qIkQ==
X-Gm-Message-State: AOAM533uYUVozzTEKMIBYClGJ5vnfavoYDtArGuB5kU8VILnjPjd2u8I
 pc2VgKnNpZ+mmSHMlWhqlsj+AVRYS1gqvSogXqpC2EYhrXvPj4Qx5Z8Chl9Oor6qWGcEUG0j+/h
 rPMfdmiBFA3Bz3wJzc3aN/KEdwV3KQ1dgJFrM8yxPBw==
X-Received: by 2002:a05:620a:d87:b0:67b:30f5:971f with SMTP id
 q7-20020a05620a0d8700b0067b30f5971fmr17004167qkl.512.1647333385879; 
 Tue, 15 Mar 2022 01:36:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUUZR7bfgjjta9OHY2Ktl6o8mWEeq9gZ09J9XQPwax3/1sk/VOL79Wdy02MvWU+bzlFbRntQ==
X-Received: by 2002:a05:620a:d87:b0:67b:30f5:971f with SMTP id
 q7-20020a05620a0d8700b0067b30f5971fmr17004158qkl.512.1647333385560; 
 Tue, 15 Mar 2022 01:36:25 -0700 (PDT)
Received: from sgarzare-redhat
 (host-212-171-187-184.pool212171.interbusiness.it. [212.171.187.184])
 by smtp.gmail.com with ESMTPSA id
 h22-20020a05620a245600b0067d6dae634csm7571560qkn.9.2022.03.15.01.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Mar 2022 01:36:24 -0700 (PDT)
Date: Tue, 15 Mar 2022 09:36:17 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 3/3] af_vsock: SOCK_SEQPACKET broken buffer test
Message-ID: <20220315083617.n33naazzf3se4ozo@sgarzare-redhat>
References: <1bb5ce91-da53-7de9-49ba-f49f76f45512@sberdevices.ru>
 <bc309cf9-5bcf-b645-577f-8e5b0cf6f220@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <bc309cf9-5bcf-b645-577f-8e5b0cf6f220@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>
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

On Fri, Mar 11, 2022 at 10:58:32AM +0000, Krasnov Arseniy Vladimirovich wrote:
>Add test where sender sends two message, each with own
>data pattern. Reader tries to read first to broken buffer:
>it has three pages size, but middle page is unmapped. Then,
>reader tries to read second message to valid buffer. Test
>checks, that uncopied part of first message was dropped
>and thus not copied as part of second message.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 121 +++++++++++++++++++++++++++++++
> 1 file changed, 121 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index aa2de27d0f77..686af712b4ad 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -16,6 +16,7 @@
> #include <linux/kernel.h>
> #include <sys/types.h>
> #include <sys/socket.h>
>+#include <sys/mman.h>
>
> #include "timeout.h"
> #include "control.h"
>@@ -435,6 +436,121 @@ static void test_seqpacket_timeout_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+#define BUF_PATTERN_1 'a'
>+#define BUF_PATTERN_2 'b'
>+
>+static void test_seqpacket_invalid_rec_buffer_client(const struct test_opts *opts)
>+{
>+	int fd;
>+	unsigned char *buf1;
>+	unsigned char *buf2;
>+	int buf_size = getpagesize() * 3;
>+
>+	fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	buf1 = malloc(buf_size);
>+	if (buf1 == NULL) {
>+		perror("'malloc()' for 'buf1'");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	buf2 = malloc(buf_size);
>+	if (buf2 == NULL) {
>+		perror("'malloc()' for 'buf2'");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	memset(buf1, BUF_PATTERN_1, buf_size);
>+	memset(buf2, BUF_PATTERN_2, buf_size);
>+
>+	if (send(fd, buf1, buf_size, 0) != buf_size) {
>+		perror("send failed");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (send(fd, buf2, buf_size, 0) != buf_size) {
>+		perror("send failed");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>+
>+static void test_seqpacket_invalid_rec_buffer_server(const struct test_opts *opts)
>+{
>+	int fd;
>+	unsigned char *broken_buf;
>+	unsigned char *valid_buf;
>+	int page_size = getpagesize();
>+	int buf_size = page_size * 3;
>+	ssize_t res;
>+	int prot = PROT_READ | PROT_WRITE;
>+	int flags = MAP_PRIVATE | MAP_ANONYMOUS;
>+	int i;
>+
>+	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Setup first buffer. */
>+	broken_buf = mmap(NULL, buf_size, prot, flags, -1, 0);
>+	if (broken_buf == MAP_FAILED) {
>+		perror("mmap for 'broken_buf'");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Unmap "hole" in buffer. */
>+	if (munmap(broken_buf + page_size, page_size)) {
>+		perror("'broken_buf' setup");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	valid_buf = mmap(NULL, buf_size, prot, flags, -1, 0);
>+	if (valid_buf == MAP_FAILED) {
>+		perror("mmap for 'valid_buf'");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Try to fill buffer with unmapped middle. */
>+	res = read(fd, broken_buf, buf_size);
>+	if (res != -1) {
>+		perror("invalid read result of 'broken_buf'");

if `res` is valid, errno is not set, better to use fprintf(stderr, ...) 
printing the expected and received result.
Take a look at test_stream_connection_reset()

>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (errno != ENOMEM) {
>+		perror("invalid errno of 'broken_buf'");

Instead of "invalid", I would say "unexpected".

>+		exit(EXIT_FAILURE);
>+	}


>+
>+	/* Try to fill valid buffer. */
>+	res = read(fd, valid_buf, buf_size);
>+	if (res != buf_size) {
>+		perror("invalid read result of 'valid_buf'");

I would split in 2 checks:
- (res < 0) then use perror()
- (res != buf_size) then use fprintf(stderr, ...) printing the expected 
   and received result.

>+		exit(EXIT_FAILURE);
>+	}
>+
>+	for (i = 0; i < buf_size; i++) {
>+		if (valid_buf[i] != BUF_PATTERN_2) {
>+			perror("invalid pattern for valid buf");

errno is not set here, better to use fprintf(stderr, ...)

>+			exit(EXIT_FAILURE);
>+		}
>+	}

What about replace this for with a memcmp()?

>+
>+
>+	/* Unmap buffers. */
>+	munmap(broken_buf, page_size);
>+	munmap(broken_buf + page_size * 2, page_size);
>+	munmap(valid_buf, buf_size);
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -480,6 +596,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_timeout_client,
> 		.run_server = test_seqpacket_timeout_server,
> 	},
>+	{
>+		.name = "SOCK_SEQPACKET invalid receive buffer",
>+		.run_client = test_seqpacket_invalid_rec_buffer_client,
>+		.run_server = test_seqpacket_invalid_rec_buffer_server,
>+	},


Is this the right behavior? If read() fails because the buffer is 
invalid, do we throw out the whole packet?

I was expecting the packet not to be consumed, have you tried AF_UNIX, 
does it have the same behavior?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
