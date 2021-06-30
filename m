Return-Path: <SRS0=+NJr=LY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0DEC11F65
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 12:17:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB9661624
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 12:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB9661624
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CE6A140466;
	Wed, 30 Jun 2021 12:17:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bj9oQ-woZcr6; Wed, 30 Jun 2021 12:17:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9360440288;
	Wed, 30 Jun 2021 12:17:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7608FC001A;
	Wed, 30 Jun 2021 12:17:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6453C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 12:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C7E4583B0B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 12:17:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TAlVRZvRSGvu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 12:17:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7434C83B09
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 12:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625055426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S5U28ywwLl6OV7xmavpG2YSBQN6F4k443zEP4QDb3fA=;
 b=IP4a7e9bTjPvR6WU7Mug5ASpSC7cwlIWdndPPRRwwkPKhDcLnex6SqryAYAYhO39dSDku6
 LkXPBHmGMgAcQRXCWnz8tQAG7TdMgyGj+WzrYPVMANWOtd+ZWNNuMWm22m2YrL5Zs7/Ob6
 gTwDIyUr68aREdACRxuPWwsx9KmJK0E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-hFj-TFcvNTS3CdrUf1JbMw-1; Wed, 30 Jun 2021 08:17:04 -0400
X-MC-Unique: hFj-TFcvNTS3CdrUf1JbMw-1
Received: by mail-ej1-f72.google.com with SMTP id
 k1-20020a17090666c1b029041c273a883dso700676ejp.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 05:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=S5U28ywwLl6OV7xmavpG2YSBQN6F4k443zEP4QDb3fA=;
 b=WMz/cuUX+gpbNE4ewYqzhLUXN521ViYGGjzJP8S0TC15roh/ONHbOz+U3vM5FQGOAy
 SymjFOYRD9Mum/3uhfoW7LpAskyI5C3aaFnwRzjfzvPuZKamAnPWwn9xsHa5I8ZaUCt8
 DmRe8vZRnCbSrd9KJ1iZWDRN7CHTbcDklBcXgphshXfkI3eJztUafGlq5+nPDC6JI6z1
 T+wv1VdVmPfQVBpiQ/vNocA2iFYVrU5tye4RZHlT4KdgaxU20BRiMF27+qgGk7ZByByK
 /a+W+e9pUnduISNB6QRu7H+VnrDyxH0lhDAvP3aZmagkXolBwY5u95TxMwNT0atN/OVE
 tpkg==
X-Gm-Message-State: AOAM531kqcatFczbW6LrjT2VPSZ5F3YRL4cD9wmkJILzvwInYhz1oI2k
 rzBQ/Bl/kIAT4haXNv5BUbyAxzmiNrz48ps2Jt8Bce3eAaD0NiYwHDyA8Fng8Fv3HB/ls8K6In+
 F6e9pA9EJ/MiMTffhldGIPGXyChSCIUyv1N16U6cdcw==
X-Received: by 2002:aa7:cb43:: with SMTP id w3mr47972956edt.126.1625055423546; 
 Wed, 30 Jun 2021 05:17:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzTOoXea3dw2KwL4npV9WtK8OeMjBSRZaapsXE1JRl9I0iizB5JdRpr8sX+P8Pm7+k3AQDmw==
X-Received: by 2002:aa7:cb43:: with SMTP id w3mr47972923edt.126.1625055423383; 
 Wed, 30 Jun 2021 05:17:03 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id v24sm799726eds.39.2021.06.30.05.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jun 2021 05:17:03 -0700 (PDT)
Date: Wed, 30 Jun 2021 14:17:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v1 16/16] vsock_test: SEQPACKET read to broken buffer
Message-ID: <CAGxU2F7GswqHk_bkSHx7Q4y_tvdNLG0PRcq0Ujex+cWv+pRCJw@mail.gmail.com>
References: <20210628095959.569772-1-arseny.krasnov@kaspersky.com>
 <20210628100539.572000-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210628100539.572000-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Krasnov Arseniy <oxffffaa@gmail.com>, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Jun 28, 2021 at 01:05:36PM +0300, Arseny Krasnov wrote:
>Add test where sender sends two message, each with own
>data pattern. Reader tries to read first to broken buffer:
>it has three pages size, but middle page is unmapped. Then,
>reader tries to read second message to valid buffer. Test
>checks, that uncopied part of first message was dropped
>and thus not copied as part of second message.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> tools/testing/vsock/vsock_test.c | 121 +++++++++++++++++++++++++++++++
> 1 file changed, 121 insertions(+)

Cool test! Thanks for doing this!

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 67766bfe176f..697ba168e97f 100644
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
>@@ -385,6 +386,121 @@ static void test_seqpacket_msg_trunc_server(const struct test_opts *opts)
>       close(fd);
> }
>
>+#define BUF_PATTERN_1 'a'
>+#define BUF_PATTERN_2 'b'
>+
>+static void test_seqpacket_invalid_rec_buffer_client(const struct test_opts *opts)
>+{
>+      int fd;
>+      unsigned char *buf1;
>+      unsigned char *buf2;
>+      int buf_size = getpagesize() * 3;
>+
>+      fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
>+      if (fd < 0) {
>+              perror("connect");
>+              exit(EXIT_FAILURE);
>+      }
>+
>+      buf1 = malloc(buf_size);
>+      if (buf1 == NULL) {

checkpatch suggests to use "if (!buf1)" ...

>+              perror("'malloc()' for 'buf1'");
>+              exit(EXIT_FAILURE);
>+      }
>+
>+      buf2 = malloc(buf_size);
>+      if (buf2 == NULL) {

... and "if (!buf2)" ...

>+              perror("'malloc()' for 'buf2'");
>+              exit(EXIT_FAILURE);
>+      }
>+
>+      memset(buf1, BUF_PATTERN_1, buf_size);
>+      memset(buf2, BUF_PATTERN_2, buf_size);
>+
>+      if (send(fd, buf1, buf_size, 0) != buf_size) {
>+              perror("send failed");
>+              exit(EXIT_FAILURE);
>+      }
>+
>+      if (send(fd, buf2, buf_size, 0) != buf_size) {
>+              perror("send failed");
>+              exit(EXIT_FAILURE);
>+      }
>+
>+      close(fd);
>+}
>+
>+static void test_seqpacket_invalid_rec_buffer_server(const struct test_opts *opts)
>+{
>+      int fd;
>+      unsigned char *broken_buf;
>+      unsigned char *valid_buf;
>+      int page_size = getpagesize();
>+      int buf_size = page_size * 3;
>+      ssize_t res;
>+      int prot = PROT_READ | PROT_WRITE;
>+      int flags = MAP_PRIVATE | MAP_ANONYMOUS;
>+      int i;
>+
>+      fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
>+      if (fd < 0) {
>+              perror("accept");
>+              exit(EXIT_FAILURE);
>+      }
>+
>+      /* Setup first buffer. */
>+      broken_buf = mmap(NULL, buf_size, prot, flags, -1, 0);
>+      if (broken_buf == MAP_FAILED) {
>+              perror("mmap for 'broken_buf'");
>+              exit(EXIT_FAILURE);
>+      }
>+
>+      /* Unmap "hole" in buffer. */
>+      if (munmap(broken_buf + page_size, page_size)) {
>+              perror("'broken_buf' setup");
>+              exit(EXIT_FAILURE);
>+      }
>+
>+      valid_buf = mmap(NULL, buf_size, prot, flags, -1, 0);
>+      if (valid_buf == MAP_FAILED) {
>+              perror("mmap for 'valid_buf'");
>+              exit(EXIT_FAILURE);
>+      }
>+
>+      /* Try to fill buffer with unmapped middle. */
>+      res = read(fd, broken_buf, buf_size);
>+      if (res != -1) {
>+              perror("invalid read result of 'broken_buf'");
>+              exit(EXIT_FAILURE);
>+      }
>+
>+      if (errno != ENOMEM) {
>+              perror("invalid errno of 'broken_buf'");
>+              exit(EXIT_FAILURE);
>+      }
>+
>+      /* Try to fill valid buffer. */
>+      res = read(fd, valid_buf, buf_size);
>+      if (res != buf_size) {
>+              perror("invalid read result of 'valid_buf'");
>+              exit(EXIT_FAILURE);
>+      }
>+
>+      for (i = 0; i < buf_size; i++) {
>+              if (valid_buf[i] != BUF_PATTERN_2) {
>+                      perror("invalid pattern for valid buf");
>+                      exit(EXIT_FAILURE);
>+              }
>+      }
>+
>+

... and to remove the extra blank line here :-)

Thanks,
Stefano

>+      /* Unmap buffers. */
>+      munmap(broken_buf, page_size);
>+      munmap(broken_buf + page_size * 2, page_size);
>+      munmap(valid_buf, buf_size);
>+      close(fd);
>+}
>+
> static struct test_case test_cases[] = {
>       {
>               .name = "SOCK_STREAM connection reset",
>@@ -425,6 +541,11 @@ static struct test_case test_cases[] = {
>               .run_client = test_seqpacket_msg_trunc_client,
>               .run_server = test_seqpacket_msg_trunc_server,
>       },
>+      {
>+              .name = "SOCK_SEQPACKET invalid receive buffer",
>+              .run_client = test_seqpacket_invalid_rec_buffer_client,
>+              .run_server = test_seqpacket_invalid_rec_buffer_server,
>+      },
>       {},
> };
>
>--
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
