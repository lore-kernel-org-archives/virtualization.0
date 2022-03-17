Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66140C4332F
	for <virtualization@archiver.kernel.org>; Thu, 17 Mar 2022 08:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EF61840B04;
	Thu, 17 Mar 2022 08:07:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ESCGea6kGG3O; Thu, 17 Mar 2022 08:07:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3002B4000B;
	Thu, 17 Mar 2022 08:07:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F40AFC001A;
	Thu, 17 Mar 2022 08:07:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A650C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 08:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 52E83612A5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 08:07:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yc6WruktP8VS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 08:07:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 741D9612A4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 08:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647504441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HhlFyUE6IEBsOcwDfZpsFqlAMN7YDfaF0SxISDC03Tg=;
 b=AJcZzkjA7v9V3oELPBdGubrNtaUwk/fRR5wmLvFXn/NB5b1tEbdfzb9/b8WrD5tXyP5EYC
 mN6mR6TGqHu8Q+yNl59bFfetJ5t+gjWXvNKhrk7gMLeGDZ2gPIpEW3LpfpUDC/zUdmNo7Q
 GyM5uQ3ICuC3E3q6R85Qpd29YEzr2j8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-8NvqgkfwPeSEqXH9YFLakw-1; Thu, 17 Mar 2022 04:07:19 -0400
X-MC-Unique: 8NvqgkfwPeSEqXH9YFLakw-1
Received: by mail-qv1-f69.google.com with SMTP id
 l4-20020a0cc204000000b00435ac16d67cso3440543qvh.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 01:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HhlFyUE6IEBsOcwDfZpsFqlAMN7YDfaF0SxISDC03Tg=;
 b=CuJFYmhkpCkz09cw1msXVrreCh3ilEIQoquLWdVD4QjkUlxOlQTjT3sHuk5mPZArLe
 kn4imgRsCYOzRX5ZKLUu/2KSTakCalCG01paqtfHEOgGcLPEU6WPERWkb9neUaLtFnvR
 4UQfGh4LE5oQD/ozDaqbuTFRouwHJVQYjmS62bHH+kq2aM7MtrSTmmtinO3SVpj1iBmI
 Th+W8rIQKbVdL6KwaRMWUT341NuYzgtnU0OmB35FqPyEswdo3blonQafIwX+yGcg1jJQ
 HQQVUpHcGjuf1ZYEO+VKzSIXnL6RRQkqwNyhwLi4kLKSNr38fh3Nqdqgu2k33sK9nscA
 ytiw==
X-Gm-Message-State: AOAM531cm9A/rX2iSvt2lPSxnxt9KCL+UJFRo+C8qjkVS8aCBcUxlfar
 TvmnzLoRSuiM8qqsd4Dwne4gPe/WUn1AGzk6sVNDI63R5Z0TKcMYmCxLb7TM34qEhAyvqYDs3tn
 DST+0uSbZ8FIWrbYM2Tj0tcrH//JJI37gBF1w2s835A==
X-Received: by 2002:a05:622a:164d:b0:2e1:d592:ade2 with SMTP id
 y13-20020a05622a164d00b002e1d592ade2mr2739619qtj.602.1647504439394; 
 Thu, 17 Mar 2022 01:07:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3SA57vAbApSbgd6VxWAFzL+Wipmtr+x6XIq8uK0YzNcWOmMeuA4rjFzXIwSc3fKrbvcggGQ==
X-Received: by 2002:a05:622a:164d:b0:2e1:d592:ade2 with SMTP id
 y13-20020a05622a164d00b002e1d592ade2mr2739609qtj.602.1647504439118; 
 Thu, 17 Mar 2022 01:07:19 -0700 (PDT)
Received: from sgarzare-redhat (host-79-42-202-12.retail.telecomitalia.it.
 [79.42.202.12]) by smtp.gmail.com with ESMTPSA id
 j11-20020a37a00b000000b0067b436faccesm2040526qke.122.2022.03.17.01.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Mar 2022 01:07:18 -0700 (PDT)
Date: Thu, 17 Mar 2022 09:07:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>
Subject: Re: [PATCH net-next v3 1/2] af_vsock: SOCK_SEQPACKET receive timeout
 test
Message-ID: <20220317080708.duovh4tnf6oxhciq@sgarzare-redhat>
References: <4ecfa306-a374-93f6-4e66-be62895ae4f7@sberdevices.ru>
 <a3f95812-d5bb-86a0-46a0-78935651e39e@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <a3f95812-d5bb-86a0-46a0-78935651e39e@sberdevices.ru>
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

On Thu, Mar 17, 2022 at 05:26:45AM +0000, Krasnov Arseniy Vladimirovich wrote:
>Test for receive timeout check: connection is established,
>receiver sets timeout, but sender does nothing. Receiver's
>'read()' call must return EAGAIN.
>
>Signed-off-by: Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>
>---
> v2 -> v3:
> 1) Use 'fprintf()' instead of 'perror()' where 'errno' variable
>    is not affected.
> 2) Print 'read()' overhead.
>
> tools/testing/vsock/vsock_test.c | 84 ++++++++++++++++++++++++++++++++
> 1 file changed, 84 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 2a3638c0a008..f5498de6751d 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -16,6 +16,7 @@
> #include <linux/kernel.h>
> #include <sys/types.h>
> #include <sys/socket.h>
>+#include <time.h>
>
> #include "timeout.h"
> #include "control.h"
>@@ -391,6 +392,84 @@ static void test_seqpacket_msg_trunc_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static time_t current_nsec(void)
>+{
>+	struct timespec ts;
>+
>+	if (clock_gettime(CLOCK_REALTIME, &ts)) {
>+		perror("clock_gettime(3) failed");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	return (ts.tv_sec * 1000000000ULL) + ts.tv_nsec;
>+}
>+
>+#define RCVTIMEO_TIMEOUT_SEC 1
>+#define READ_OVERHEAD_NSEC 250000000 /* 0.25 sec */
>+
>+static void test_seqpacket_timeout_client(const struct test_opts *opts)
>+{
>+	int fd;
>+	struct timeval tv;
>+	char dummy;
>+	time_t read_enter_ns;
>+	time_t read_overhead_ns;
>+
>+	fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	tv.tv_sec = RCVTIMEO_TIMEOUT_SEC;
>+	tv.tv_usec = 0;
>+
>+	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, (void *)&tv, sizeof(tv)) == -1) {
>+		perror("setsockopt 'SO_RCVTIMEO'");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	read_enter_ns = current_nsec();
>+
>+	if (errno != EAGAIN) {
>+		perror("EAGAIN expected");
>+		exit(EXIT_FAILURE);
>+	}

Should this check go after read()?

Indeed now the test fails on my environment with "EAGAIN expected" 
message.

The rest LGTM :-)

Stefano

>+
>+	if (read(fd, &dummy, sizeof(dummy)) != -1) {
>+		fprintf(stderr,
>+			"expected 'dummy' read(2) failure\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	read_overhead_ns = current_nsec() - read_enter_ns -
>+			1000000000ULL * RCVTIMEO_TIMEOUT_SEC;
>+
>+	if (read_overhead_ns > READ_OVERHEAD_NSEC) {
>+		fprintf(stderr,
>+			"too much time in read(2), %lu > %i ns\n",
>+			read_overhead_ns, READ_OVERHEAD_NSEC);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("WAITDONE");
>+	close(fd);
>+}
>+
>+static void test_seqpacket_timeout_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("WAITDONE");
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -431,6 +510,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_msg_trunc_client,
> 		.run_server = test_seqpacket_msg_trunc_server,
> 	},
>+	{
>+		.name = "SOCK_SEQPACKET timeout",
>+		.run_client = test_seqpacket_timeout_client,
>+		.run_server = test_seqpacket_timeout_server,
>+	},
> 	{},
> };
>
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
