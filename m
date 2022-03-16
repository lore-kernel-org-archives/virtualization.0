Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D169C433EF
	for <virtualization@archiver.kernel.org>; Wed, 16 Mar 2022 08:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 369828134B;
	Wed, 16 Mar 2022 08:53:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3WDqfz9XvWyh; Wed, 16 Mar 2022 08:53:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B5E8A812EC;
	Wed, 16 Mar 2022 08:53:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81C9AC0012;
	Wed, 16 Mar 2022 08:53:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5BFEC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 08:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3A2D60598
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 08:53:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id enEDW4UV6dWT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 08:53:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C718860590
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 08:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647420832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BGSquJZfEU0XpxQDlJiQ9Nf/2e2vYgQ8cePX8MYx0lw=;
 b=NaKceCeMzi+8eQlwKGa3FS+Iztj9I5oSF9mwUzNFWradIwQ//MNrP6fSyC6Nh89MJ6e7yF
 AN2ChVQHV+hfjkk6Xo1ETvaS8JgFu16VG6LL2f3QTVWSw/uNNgMW7P124QI2S6V5Y5JzKw
 kIZKb0YCmp+SR++5wz9a0TEtqMcmWjI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-uXP_5rZpM529N0bmgwpxfA-1; Wed, 16 Mar 2022 04:53:51 -0400
X-MC-Unique: uXP_5rZpM529N0bmgwpxfA-1
Received: by mail-qt1-f199.google.com with SMTP id
 t26-20020ac8739a000000b002e06aa03d4cso1053744qtp.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 01:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BGSquJZfEU0XpxQDlJiQ9Nf/2e2vYgQ8cePX8MYx0lw=;
 b=2Q+evfGj56BbnGefVXM4phq84XoxuOtyDQXjMAH59TnM0JuABfDgQ/L/AzCh1brzPe
 0M470EgkQN8eJCOPxCfqJ8bLVTDGYLyM7ojosWsTtd/74RxWO0kZyVEt9ixJUpufAeDV
 ZbmOIDctXSporEps5QK8ccrBTmbRuXsEVtdiLW4sQFhikALsVYydHupnvdIiQWC+rgLp
 BBFRZvgCKfcukckiXXO+fojriPwSIRmfqW2iv1BeIJHR7l6OxLV70U5Rr5TJl6y8x1tJ
 fec8k9jPrKWE8MmoN4PCLyN1aJSztjJ2da7qgRmPfE8lY2rwr7smhaFiet3S5XohvWPd
 rVog==
X-Gm-Message-State: AOAM533a/BJcqtODe7weEeCLtmucQodrlkv04SxcHa69AUyPsOMJ30im
 y/Wzrn5Rm2rjS0Zd4Dn1n7KCrFxYbVC0ky+6Al6dhB8P05xux25WylLBcTFbYTpdEeWSlnkDRUz
 NfqeLzKY+N+0KbYlq+Tho3qsvgJe4M2peUnqYG11YzQ==
X-Received: by 2002:a05:620a:4085:b0:67b:315b:a09f with SMTP id
 f5-20020a05620a408500b0067b315ba09fmr20513448qko.334.1647420830984; 
 Wed, 16 Mar 2022 01:53:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwb/nFj3dDrpxdws1scoeFcog8y/RQk9LTO0D1ZDQQyiweerrLDje3qSyAQR/5kQ8Sr9cHm0Q==
X-Received: by 2002:a05:620a:4085:b0:67b:315b:a09f with SMTP id
 f5-20020a05620a408500b0067b315ba09fmr20513439qko.334.1647420830768; 
 Wed, 16 Mar 2022 01:53:50 -0700 (PDT)
Received: from sgarzare-redhat (host-212-171-187-184.retail.telecomitalia.it.
 [212.171.187.184]) by smtp.gmail.com with ESMTPSA id
 t66-20020ae9df45000000b0064915aff85fsm638399qkf.45.2022.03.16.01.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Mar 2022 01:53:50 -0700 (PDT)
Date: Wed, 16 Mar 2022 09:53:45 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 2/2] af_vsock: SOCK_SEQPACKET broken buffer test
Message-ID: <20220316085345.ajfmnzg3vx3o3vgs@sgarzare-redhat>
References: <1474b149-7d4c-27b2-7e5c-ef00a718db76@sberdevices.ru>
 <415368cd-81b3-e2fd-fbed-65cacfc43850@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <415368cd-81b3-e2fd-fbed-65cacfc43850@sberdevices.ru>
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

On Wed, Mar 16, 2022 at 07:29:28AM +0000, Krasnov Arseniy Vladimirovich wrote:
>Add test where sender sends two message, each with own
>data pattern. Reader tries to read first to broken buffer:
>it has three pages size, but middle page is unmapped. Then,
>reader tries to read second message to valid buffer. Test
>checks, that uncopied part of first message was dropped
>and thus not copied as part of second message.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> v1 -> v2:
> 1) Use 'fprintf()' instead of 'perror()' where 'errno' variable
>    is not affected.
> 2) Replace word "invalid" -> "unexpected".
>
> tools/testing/vsock/vsock_test.c | 132 +++++++++++++++++++++++++++++++
> 1 file changed, 132 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 6d7648cce5aa..1132bcd8ddb7 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -17,6 +17,7 @@
> #include <sys/types.h>
> #include <sys/socket.h>
> #include <time.h>
>+#include <sys/mman.h>
>
> #include "timeout.h"
> #include "control.h"
>@@ -465,6 +466,132 @@ static void test_seqpacket_timeout_server(const struct test_opts *opts)
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
>+		fprintf(stderr,
>+			"expected 'broken_buf' read(2) failure, got %zi\n",
>+			res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (errno != ENOMEM) {
>+		perror("unexpected errno of 'broken_buf'");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Try to fill valid buffer. */
>+	res = read(fd, valid_buf, buf_size);
>+	if (res < 0) {
>+		perror("unexpected 'valid_buf' read(2) failure");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (res != buf_size) {
>+		fprintf(stderr,
>+			"invalid 'valid_buf' read(2), got %zi, expected %i\n",
>+			res, buf_size);

I would suggest to use always the same pattern in the error messages:
"expected X, got Y".

The rest LGTM.

>+		exit(EXIT_FAILURE);
>+	}
>+
>+	for (i = 0; i < buf_size; i++) {
>+		if (valid_buf[i] != BUF_PATTERN_2) {
>+			fprintf(stderr,
>+				"invalid pattern for 'valid_buf' at %i, expected %hhX, got %hhX\n",
>+				i, BUF_PATTERN_2, valid_buf[i]);
>+			exit(EXIT_FAILURE);
>+		}
>+	}
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
>@@ -510,6 +637,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_timeout_client,
> 		.run_server = test_seqpacket_timeout_server,
> 	},
>+	{
>+		.name = "SOCK_SEQPACKET invalid receive buffer",
>+		.run_client = test_seqpacket_invalid_rec_buffer_client,
>+		.run_server = test_seqpacket_invalid_rec_buffer_server,
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
