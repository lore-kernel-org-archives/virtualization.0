Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BA5EE6457
	for <virtualization@archiver.kernel.org>; Fri, 15 Sep 2023 12:15:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9523483C1F;
	Fri, 15 Sep 2023 12:15:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9523483C1F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dpEww9ZW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rbZrXD7slWp0; Fri, 15 Sep 2023 12:15:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1428E83C1B;
	Fri, 15 Sep 2023 12:15:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1428E83C1B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00656C0039;
	Fri, 15 Sep 2023 12:15:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0DB6C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 12:15:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ABD6383C1B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 12:15:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ABD6383C1B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LJNG3JYZDtSX
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 12:15:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E209283C19
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 12:15:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E209283C19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694780129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RMEGvb3Sq84IyOhcCt8lUx9+cduXmZG2jRi2oEjFcn4=;
 b=dpEww9ZWhA09YjSV5fLYP1s10Asq6CadZ8AtNEhrltQ+tHvqMgxxqwdVgjzUreF+pPluIM
 Mwc29093wqy+xea6d1jjDctVlTskUEpyxJJ1DWqMhahtXBKabEyjwkEHbuAh8vAfWtAY/j
 w7JznimAm2uFO4SSbutwusGMNxv2P5I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-fQ89ZiJjPg2KhydDXE6XdQ-1; Fri, 15 Sep 2023 08:15:28 -0400
X-MC-Unique: fQ89ZiJjPg2KhydDXE6XdQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31c5c762f97so1454145f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 05:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694780127; x=1695384927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RMEGvb3Sq84IyOhcCt8lUx9+cduXmZG2jRi2oEjFcn4=;
 b=SKCyGEtxkT1bFe8SKnmYpYMpmVCoF+IOEoI9dHstKhcDNByHKp2PC3yIZ8hMrK2WtH
 1KH7PZeXh4LuF3GRkfluayyBS/mjf3+DpLeyJqzrw3Cwa7MOjEs3Hp/lwuEOrncIA/aL
 GB1kh4o1BQuaHEsoBum/lhsa34Q/EL/7rRrv8Oo7llXiPc8vwWmYZUADTH0H5VU8I9Lj
 e0fodXw6UVNEObalOwES37Bg2Wz6GUPs1Di6ZKJqcXnTenLHXJT5O4dMbEsZVF0lpJj0
 4jS1LLcsLUgJEM9uc6pPvbg6LL2iJ8LbqoMNAgL0B+KHmMMEpdcb3AsQbPC2sblElkUQ
 Me/w==
X-Gm-Message-State: AOJu0YyIsOBHZaGMFX0dgZXCJwdkRMRWZZNaMQjwzKgyk6bwqWteaIJ/
 w4BTjcPdivSPnjCkBam9/YB3tg41CmsfnDdUf4/8PFZT1H2h9K6RpCS0jtnwJUeqtCS8mr9sldi
 LkPK1CRdCmEzIqXoDkZj8PtCfTN+T4OS0fIkTr7rF+g==
X-Received: by 2002:a5d:6dcb:0:b0:31f:eb8d:4823 with SMTP id
 d11-20020a5d6dcb000000b0031feb8d4823mr1120351wrz.26.1694780115686; 
 Fri, 15 Sep 2023 05:15:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmZEMz8JTAkutLT6oF8NF90vZ5bmQukR1ASa3FCQYrmpM8Mq37F3IN0p/HD9/gA/uhMXLXfw==
X-Received: by 2002:a5d:6dcb:0:b0:31f:eb8d:4823 with SMTP id
 d11-20020a5d6dcb000000b0031feb8d4823mr1119962wrz.26.1694780101879; 
 Fri, 15 Sep 2023 05:15:01 -0700 (PDT)
Received: from step1.lan ([46.222.72.72]) by smtp.gmail.com with ESMTPSA id
 l12-20020a5d674c000000b0030ae53550f5sm4257548wrw.51.2023.09.15.05.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 05:15:00 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 1/5] vsock/test: add recv_buf() utility function
Date: Fri, 15 Sep 2023 14:14:48 +0200
Message-ID: <20230915121452.87192-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915121452.87192-1-sgarzare@redhat.com>
References: <20230915121452.87192-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com
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

Move the code of recv_byte() out in a new utility function that
can be used to receive a generic buffer.

This new function can be used when we need to receive a custom
buffer and not just a single 'A' byte.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/util.h |  1 +
 tools/testing/vsock/util.c | 88 +++++++++++++++++++++++---------------
 2 files changed, 54 insertions(+), 35 deletions(-)

diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index fb99208a95ea..fe31f267e67e 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -42,6 +42,7 @@ int vsock_stream_accept(unsigned int cid, unsigned int port,
 int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
 			   struct sockaddr_vm *clientaddrp);
 void vsock_wait_remote_close(int fd);
+void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret);
 void send_byte(int fd, int expected_ret, int flags);
 void recv_byte(int fd, int expected_ret, int flags);
 void run_tests(const struct test_case *test_cases,
diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 01b636d3039a..2826902706e8 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -211,6 +211,58 @@ int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
 	return vsock_accept(cid, port, clientaddrp, SOCK_SEQPACKET);
 }
 
+/* Receive bytes in a buffer and check the return value.
+ *
+ * expected_ret:
+ *  <0 Negative errno (for testing errors)
+ *   0 End-of-file
+ *  >0 Success (bytes successfully read)
+ */
+void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
+{
+	ssize_t nread = 0;
+	ssize_t ret;
+
+	timeout_begin(TIMEOUT);
+	do {
+		ret = recv(fd, buf + nread, len - nread, flags);
+		timeout_check("recv");
+
+		if (ret == 0 || (ret < 0 && errno != EINTR))
+			break;
+
+		nread += ret;
+	} while (nread < len);
+	timeout_end();
+
+	if (expected_ret < 0) {
+		if (ret != -1) {
+			fprintf(stderr, "bogus recv(2) return value %zd (expected %zd)\n",
+				ret, expected_ret);
+			exit(EXIT_FAILURE);
+		}
+		if (errno != -expected_ret) {
+			perror("recv");
+			exit(EXIT_FAILURE);
+		}
+		return;
+	}
+
+	if (ret < 0) {
+		perror("recv");
+		exit(EXIT_FAILURE);
+	}
+
+	if (nread != expected_ret) {
+		if (ret == 0)
+			fprintf(stderr, "unexpected EOF while receiving bytes\n");
+
+		fprintf(stderr, "bogus recv(2) bytes read %zd (expected %zd)\n",
+			nread, expected_ret);
+		exit(EXIT_FAILURE);
+	}
+}
+
 /* Transmit one byte and check the return value.
  *
  * expected_ret:
@@ -270,43 +322,9 @@ void send_byte(int fd, int expected_ret, int flags)
 void recv_byte(int fd, int expected_ret, int flags)
 {
 	uint8_t byte;
-	ssize_t nread;
-
-	timeout_begin(TIMEOUT);
-	do {
-		nread = recv(fd, &byte, sizeof(byte), flags);
-		timeout_check("read");
-	} while (nread < 0 && errno == EINTR);
-	timeout_end();
-
-	if (expected_ret < 0) {
-		if (nread != -1) {
-			fprintf(stderr, "bogus recv(2) return value %zd\n",
-				nread);
-			exit(EXIT_FAILURE);
-		}
-		if (errno != -expected_ret) {
-			perror("read");
-			exit(EXIT_FAILURE);
-		}
-		return;
-	}
 
-	if (nread < 0) {
-		perror("read");
-		exit(EXIT_FAILURE);
-	}
-	if (nread == 0) {
-		if (expected_ret == 0)
-			return;
+	recv_buf(fd, &byte, sizeof(byte), flags, expected_ret);
 
-		fprintf(stderr, "unexpected EOF while receiving byte\n");
-		exit(EXIT_FAILURE);
-	}
-	if (nread != sizeof(byte)) {
-		fprintf(stderr, "bogus recv(2) return value %zd\n", nread);
-		exit(EXIT_FAILURE);
-	}
 	if (byte != 'A') {
 		fprintf(stderr, "unexpected byte read %c\n", byte);
 		exit(EXIT_FAILURE);
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
