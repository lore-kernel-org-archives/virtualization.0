Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB33EE645A
	for <virtualization@archiver.kernel.org>; Fri, 15 Sep 2023 12:15:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9FA1942114;
	Fri, 15 Sep 2023 12:15:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9FA1942114
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NuNY3WG1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VfV3ZUEZsU9M; Fri, 15 Sep 2023 12:15:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E0E1642117;
	Fri, 15 Sep 2023 12:15:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E0E1642117
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAAC0C0039;
	Fri, 15 Sep 2023 12:15:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE519C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 12:15:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7BD6061321
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 12:15:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7BD6061321
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NuNY3WG1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vO9kV4kRqMU7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 12:15:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4E2C612F4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 12:15:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C4E2C612F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694780127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IzPTIpBjDzBGvsyRo0gBVOG837dBZudcrNhelcBAVs=;
 b=NuNY3WG1WnX4m0MxIHJzurF+eZ0XicILWQUxYh92xYOaJ8S50QOA8NVMwkyznnAQ5N5O+6
 ORNnHX+vMVdrhxaHPoEWdF735SLcZ1nUUH6vJpFaL55/HlIeXy0duGFYf//7Uap1jLQP6M
 j3QuukfkLhdXJUrsP5fxJl3ypQEzhUc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-1xmi5Ta1P7-yDsp4S8mONQ-1; Fri, 15 Sep 2023 08:15:26 -0400
X-MC-Unique: 1xmi5Ta1P7-yDsp4S8mONQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31f9186eb8dso1310388f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 05:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694780125; x=1695384925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4IzPTIpBjDzBGvsyRo0gBVOG837dBZudcrNhelcBAVs=;
 b=oHZXq78ojwIBiKBcw2qFjibY+LdtIRAWbEaKcPzB3n0LMoiP/zBXtVj3VVJ4qoDZ7i
 ybgYxRDV6AJVrDUECqZtI5NfAMmnzmf5XBb3qzVsZR5tpP7qiAKh2LfMAG9R6lPjYQxL
 T/uaz9NMbq98p/ZcjUb1Rfht8JirOcDVXYRIWpoZeDFcw2yyFWh1LV8plR4c8Hk2fVlh
 r3/ghZOVJXPVU69WiJmawE5XgkvR/IzOAx6YNRQdLtX4m2ReAqwMcZxRWf/3CI3Z4zwY
 /PrKtPSmlmdPlMKCvWWIHL5XvThn1naGWaQusxryuvpiwyIQgWGd1ijopJsHw7BUIgQf
 G9Gw==
X-Gm-Message-State: AOJu0YxmPE5WrU01ymUpw6rqubykUJQxBz6XWfUT+GxUUye1p0mMAdga
 en7zGTJwbt4TKPPvdENmQv9LbTHmGML/lfKurea8Ndo2whxpl1mwSS02DOH9NtEfi4e2ZTBxZtu
 0YHPlnSAzN1+wrRAbOP0qc8fJnFK64EmfQMbS0ztq4w==
X-Received: by 2002:adf:cd08:0:b0:31f:afeb:4e71 with SMTP id
 w8-20020adfcd08000000b0031fafeb4e71mr1327909wrm.48.1694780124853; 
 Fri, 15 Sep 2023 05:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAM+qT8oGEefSDmkyANZPTMrHB/rc6Va9KYPc9DtRjeZCpejNAvp5rpxARReDs63NX0XPsvQ==
X-Received: by 2002:adf:cd08:0:b0:31f:afeb:4e71 with SMTP id
 w8-20020adfcd08000000b0031fafeb4e71mr1327892wrm.48.1694780124604; 
 Fri, 15 Sep 2023 05:15:24 -0700 (PDT)
Received: from step1.lan ([46.222.72.72]) by smtp.gmail.com with ESMTPSA id
 s1-20020a5d4ec1000000b0031fbbe347e1sm4287767wrv.65.2023.09.15.05.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 05:15:23 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 5/5] vsock/test: track bytes in MSG_PEEK test for
 SOCK_SEQPACKET
Date: Fri, 15 Sep 2023 14:14:52 +0200
Message-ID: <20230915121452.87192-6-sgarzare@redhat.com>
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

The test was a bit complicated to read.
Added variables to keep track of the bytes read and to be read
in each step. Also some comments.

The test is unchanged.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index b18acbaf92e2..5743dcae2350 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1002,6 +1002,7 @@ static void test_stream_virtio_skb_merge_client(const struct test_opts *opts)
 
 static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
 {
+	size_t read = 0, to_read;
 	unsigned char buf[64];
 	int fd;
 
@@ -1014,14 +1015,21 @@ static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
 	control_expectln("SEND0");
 
 	/* Read skbuff partially. */
-	recv_buf(fd, buf, 2, 0, 2);
+	to_read = 2;
+	recv_buf(fd, buf + read, to_read, 0, to_read);
+	read += to_read;
 
 	control_writeln("REPLY0");
 	control_expectln("SEND1");
 
-	recv_buf(fd, buf + 2, 8, 0, 8);
+	/* Read the rest of both buffers */
+	to_read = strlen(HELLO_STR WORLD_STR) - read;
+	recv_buf(fd, buf + read, to_read, 0, to_read);
+	read += to_read;
 
-	recv_buf(fd, buf, sizeof(buf) - 8 - 2, MSG_DONTWAIT, -EAGAIN);
+	/* No more bytes should be there */
+	to_read = sizeof(buf) - read;
+	recv_buf(fd, buf + read, to_read, MSG_DONTWAIT, -EAGAIN);
 
 	if (memcmp(buf, HELLO_STR WORLD_STR, strlen(HELLO_STR WORLD_STR))) {
 		fprintf(stderr, "pattern mismatch\n");
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
