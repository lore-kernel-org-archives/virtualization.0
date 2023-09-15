Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6869EEE6457
	for <virtualization@archiver.kernel.org>; Fri, 15 Sep 2023 12:15:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1378B612DC;
	Fri, 15 Sep 2023 12:15:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1378B612DC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WiyevuVO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AsaYV1xyKUak; Fri, 15 Sep 2023 12:15:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7C31B60BBA;
	Fri, 15 Sep 2023 12:15:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C31B60BBA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64831C0039;
	Fri, 15 Sep 2023 12:15:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13974C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 12:15:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D5AFF41939
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 12:15:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D5AFF41939
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WiyevuVO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SvGa0Yilz6cP
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 12:15:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B9CDB41936
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 12:15:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9CDB41936
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694780116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Wsy1q2POvkf/slH3ci56G5sHfd/fayJdujAf9EVUnI=;
 b=WiyevuVOD9kARfYqkbi9WXhcOMBBx6xWZYKCq2umtAFN7W0iqe7/muSmn9c2kMq+dUZYHO
 VfsQfmq7rIFsJrOn2/Wfa+ul3Dk232/5qLur/1jxSU6AT1SGzUN3s6O9r0Ow10xs4MnCGi
 WUoixHS1NmgKzR/xubs3tDuWck1mIo0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-RLrH20OPMOmypgqGVa5o3g-1; Fri, 15 Sep 2023 08:15:15 -0400
X-MC-Unique: RLrH20OPMOmypgqGVa5o3g-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-402d1892cecso9706205e9.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 05:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694780114; x=1695384914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Wsy1q2POvkf/slH3ci56G5sHfd/fayJdujAf9EVUnI=;
 b=qwc/u+XbGXccpMlAvK0txIojAlNfJLcH78fezcMdN1DZp27bJl3H1gIZpnIjXgFbKX
 RtW2EifBqE5eBrjF0dTaU4WArs2sNF4ITsRJj1Z3zi2/Qa7l90fHn1RhGZRdo9lpWQgq
 ECitrUZ7aT3D1yk09x0oiAmYGhDRuy/YZzzT4KeQCrGj1X1MHqWcEEb1lbwust2w2yTS
 8ejeRn27AMoR5W6i99sVnRcDcfbm79AGFvbJ2vvxHmN2gXWwOOJ5XwfEk0Va6lSmnewt
 ruNmanzwQ/PkwzcWkWlcAsOrbzMx6DajhHzZ6+1j7Lmrz6eu+lvZy86dMyyQiZ+Vbvpn
 Seow==
X-Gm-Message-State: AOJu0Yz+o/6O5HiXupIKO8PtbDKTCbBDnwgFJJUpZPxbY88HDVe8CKDd
 KZsPtB4EBPh7aNhHDCNzgkzwl8Lx1/aCXKIEzQ1Hgzma1Jfa67T/OsrMxCkQUmLDIIk3p+IITNl
 pIyNgzw/unCkYeca4kx0yIZ49oLHa0CTs4PGiXOlz2w==
X-Received: by 2002:a05:600c:1914:b0:401:bcec:be3e with SMTP id
 j20-20020a05600c191400b00401bcecbe3emr3493376wmq.17.1694780113966; 
 Fri, 15 Sep 2023 05:15:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF80cLLN3KCVixXwI3Sp+oFXdhCzhUU59hAIcQenPXVtkDPh17T7T+QOc2QolC6Hazp8647uA==
X-Received: by 2002:a05:600c:1914:b0:401:bcec:be3e with SMTP id
 j20-20020a05600c191400b00401bcecbe3emr3493366wmq.17.1694780113612; 
 Fri, 15 Sep 2023 05:15:13 -0700 (PDT)
Received: from step1.lan ([46.222.72.72]) by smtp.gmail.com with ESMTPSA id
 v13-20020a05600c214d00b00401dc20a070sm7346864wml.43.2023.09.15.05.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 05:15:12 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 3/5] vsock/test: add send_buf() utility function
Date: Fri, 15 Sep 2023 14:14:50 +0200
Message-ID: <20230915121452.87192-4-sgarzare@redhat.com>
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

Move the code of send_byte() out in a new utility function that
can be used to send a generic buffer.

This new function can be used when we need to send a custom
buffer and not just a single 'A' byte.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/util.h |  2 +
 tools/testing/vsock/util.c | 90 +++++++++++++++++++++++---------------
 2 files changed, 56 insertions(+), 36 deletions(-)

diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index fe31f267e67e..e5407677ce05 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -42,6 +42,8 @@ int vsock_stream_accept(unsigned int cid, unsigned int port,
 int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
 			   struct sockaddr_vm *clientaddrp);
 void vsock_wait_remote_close(int fd);
+void send_buf(int fd, const void *buf, size_t len, int flags,
+	      ssize_t expected_ret);
 void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret);
 void send_byte(int fd, int expected_ret, int flags);
 void recv_byte(int fd, int expected_ret, int flags);
diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 2826902706e8..6779d5008b27 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -211,6 +211,59 @@ int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
 	return vsock_accept(cid, port, clientaddrp, SOCK_SEQPACKET);
 }
 
+/* Transmit bytes from a buffer and check the return value.
+ *
+ * expected_ret:
+ *  <0 Negative errno (for testing errors)
+ *   0 End-of-file
+ *  >0 Success (bytes successfully written)
+ */
+void send_buf(int fd, const void *buf, size_t len, int flags,
+	      ssize_t expected_ret)
+{
+	ssize_t nwritten = 0;
+	ssize_t ret;
+
+	timeout_begin(TIMEOUT);
+	do {
+		ret = send(fd, buf + nwritten, len - nwritten, flags);
+		timeout_check("send");
+
+		if (ret == 0 || (ret < 0 && errno != EINTR))
+			break;
+
+		nwritten += ret;
+	} while (nwritten < len);
+	timeout_end();
+
+	if (expected_ret < 0) {
+		if (ret != -1) {
+			fprintf(stderr, "bogus send(2) return value %zd (expected %zd)\n",
+				ret, expected_ret);
+			exit(EXIT_FAILURE);
+		}
+		if (errno != -expected_ret) {
+			perror("send");
+			exit(EXIT_FAILURE);
+		}
+		return;
+	}
+
+	if (ret < 0) {
+		perror("send");
+		exit(EXIT_FAILURE);
+	}
+
+	if (nwritten != expected_ret) {
+		if (ret == 0)
+			fprintf(stderr, "unexpected EOF while sending bytes\n");
+
+		fprintf(stderr, "bogus send(2) bytes written %zd (expected %zd)\n",
+			nwritten, expected_ret);
+		exit(EXIT_FAILURE);
+	}
+}
+
 /* Receive bytes in a buffer and check the return value.
  *
  * expected_ret:
@@ -273,43 +326,8 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
 void send_byte(int fd, int expected_ret, int flags)
 {
 	const uint8_t byte = 'A';
-	ssize_t nwritten;
-
-	timeout_begin(TIMEOUT);
-	do {
-		nwritten = send(fd, &byte, sizeof(byte), flags);
-		timeout_check("write");
-	} while (nwritten < 0 && errno == EINTR);
-	timeout_end();
-
-	if (expected_ret < 0) {
-		if (nwritten != -1) {
-			fprintf(stderr, "bogus send(2) return value %zd\n",
-				nwritten);
-			exit(EXIT_FAILURE);
-		}
-		if (errno != -expected_ret) {
-			perror("write");
-			exit(EXIT_FAILURE);
-		}
-		return;
-	}
 
-	if (nwritten < 0) {
-		perror("write");
-		exit(EXIT_FAILURE);
-	}
-	if (nwritten == 0) {
-		if (expected_ret == 0)
-			return;
-
-		fprintf(stderr, "unexpected EOF while sending byte\n");
-		exit(EXIT_FAILURE);
-	}
-	if (nwritten != sizeof(byte)) {
-		fprintf(stderr, "bogus send(2) return value %zd\n", nwritten);
-		exit(EXIT_FAILURE);
-	}
+	send_buf(fd, &byte, sizeof(byte), flags, expected_ret);
 }
 
 /* Receive one byte and check the return value.
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
