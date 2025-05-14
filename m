Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427331BD035
	for <virtualization@lists.linux.dev>; Wed, 14 May 2025 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747232395; cv=none; b=J/b3TWC1IysASPxE4F6nPhwtGGeRWWpCXviAOs/JtKeVJAcVkZ1mOlzN/1NPFNbjflF1JE38TJrPvgojwBGG3gGV+nmQuRJd0Z26h6LhdT9ltw3FbFrGuxT9rcimfJmabSo4UQJ7q6cS/4TL5W3gRcsvPDAwL2w+MlwXiuUbGg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747232395; c=relaxed/simple;
	bh=CcrER2Exd8xwndgBuv285nkTGJ5VgH5wjXS9fED1jP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=CPWD+Xi/CNr23xaKAi5zWlZmjQ8ckB4iAhN/spYsuR5tkyNUgcnPMIxOU2hyu623FIiigS4iZXH+G74f3RCC79o/dmE+jWB89dvnQnUzZPIvzc1+O+atXBrMGGq6TeU6dJueP3zuXShHho7nHMI+emQCTT1dtG904EeN0lNxGnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0a2co6F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0a2co6F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747232392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDm7nJrRE59Z0WBLF69Q9FPldj2cPZK9AVpQiRbnwXM=;
	b=U0a2co6FZEtbYXbK+40PXWfwlX+44GnmXKjh5v9rX7an9U2tC6wCP8z0IO6QnXI9+BH52+
	OkWsNw8fnLFvoYW7tjTy2mLIAZpHhr0vaEdYWIpmoIB33zAyjldGCQg4xj1DJti+B4zm8u
	COvtr3whjwHSMlDnz0SGGP8fVe/bIeM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-WBO5VkdmM6-9y8H-tpEMLA-1; Wed, 14 May 2025 10:19:51 -0400
X-MC-Unique: WBO5VkdmM6-9y8H-tpEMLA-1
X-Mimecast-MFC-AGG-ID: WBO5VkdmM6-9y8H-tpEMLA_1747232390
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso35411665e9.3
        for <virtualization@lists.linux.dev>; Wed, 14 May 2025 07:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747232390; x=1747837190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDm7nJrRE59Z0WBLF69Q9FPldj2cPZK9AVpQiRbnwXM=;
        b=GFjr8LhR+c1tVjIrg1ifGDr7994dlboc2XHOCiGDL91TBZSlHOO5EyPkXRJL6FWp11
         JhsuqJ8o4s3HErLapaZ50ITDWyCKD6EvfKxuKdD9wQ20XXDL6nE2bpp27nVVKxTwue7v
         zBkNba3r7a6swVYBDQDNF7FnMAUKayBWR6PpvuIXxqtykqJHDOSl85PoPfYuYPZD+23N
         rrt3XsC8/YqdITJZj64sxnrxpH0fXfeZofglGolJo3Ma3k0awrM/+LUdaDKUqtFcOEzg
         B3gsRoDsMsuGBDfROeClS+aaanSURhuZ68z5n1tORiKCC70qzZve/sTWDJl4Dgw49qS/
         DASQ==
X-Gm-Message-State: AOJu0Yx9D+KdITIzrvvkQuXk7LMe5bA8V8XTUMvoN0zc4wieUBZbanD8
	tVXypFWZKmpX5bNBIoXZT/tYOEbNzUISOjymA1puldIUGb3/rAFxMvyFUWBG1t4oyloLqeferGb
	G3MXNINvfGngxib5Bkn33bMjWsAmfHPxryLhw5+b83DP+abOOm09zUAczCDTOTXJx
X-Gm-Gg: ASbGncsjonTJnzc2AvU5Jga8IyQ4U/NYeBJF6EYShiS5fOhz5YPYZd2Y7I3SFewxUDY
	zwpQsuev2LqIkHQlU2XCjg4YCXd3CGsslLJWVQ7xwoJFOr9Qoz4nq5nIvoC5lNfROMVekC2YtE1
	dflg9+4oDTqKQqyYqrPYq35anBthuACIgTk/WaJiGYbKyzVVYCjY+ILlX3+LPap56d6xfQNdnhn
	Ie5LaPSZLEtXbIPN6uIbQhWDhF99FRIGtShLV4fEfsflXlPSJuB+gn+tJFpe4I50R3d8NpNT5TG
	ehNyOeN4OSlmjW/UCw==
X-Received: by 2002:a05:6000:144e:b0:3a1:fcd4:eada with SMTP id ffacd0b85a97d-3a34969acb4mr3222050f8f.4.1747232390288;
        Wed, 14 May 2025 07:19:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG75RsnzyRLR1LhB+z1tdqBl/h6dNHdHAx2k1Nlw/1mOd/47oPLqRJ7tYPfYXaURS4y1kTd7A==
X-Received: by 2002:a05:6000:144e:b0:3a1:fcd4:eada with SMTP id ffacd0b85a97d-3a34969acb4mr3222017f8f.4.1747232389836;
        Wed, 14 May 2025 07:19:49 -0700 (PDT)
Received: from stex1.redhat.com ([193.207.203.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4cc2esm20351768f8f.90.2025.05.14.07.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 07:19:48 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/3] vsock/test: check also expected errno on sigpipe test
Date: Wed, 14 May 2025 16:19:27 +0200
Message-ID: <20250514141927.159456-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514141927.159456-1-sgarzare@redhat.com>
References: <20250514141927.159456-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V7G3E6lxiJnj6M7GDIdaQX2qhVpnIGNGT9QbxBJ7zoY_1747232390
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

In the sigpipe test, we expect send() to fail, but we do not check if
send() fails with the errno we expect (EPIPE).

Add this check and repeat the send() in case of EINTR as we do in other
tests.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- fixed loop exit condition [Paolo]
  note: the code changed a bit from v1, but this time I checked it
  better!
---
 tools/testing/vsock/vsock_test.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 68f425af00cc..082c5dd6e8f5 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1075,7 +1075,7 @@ static void test_stream_check_sigpipe(int fd)
 	timeout_begin(TIMEOUT);
 	while(1) {
 		res = send(fd, "A", 1, 0);
-		if (res == -1)
+		if (res == -1 && errno != EINTR)
 			break;
 
 		/* Sleep a little before trying again to avoid flooding the
@@ -1087,6 +1087,10 @@ static void test_stream_check_sigpipe(int fd)
 	}
 	timeout_end();
 
+	if (errno != EPIPE) {
+		fprintf(stderr, "unexpected send(2) errno %d\n", errno);
+		exit(EXIT_FAILURE);
+	}
 	if (!have_sigpipe) {
 		fprintf(stderr, "SIGPIPE expected\n");
 		exit(EXIT_FAILURE);
@@ -1097,7 +1101,7 @@ static void test_stream_check_sigpipe(int fd)
 	timeout_begin(TIMEOUT);
 	while(1) {
 		res = send(fd, "A", 1, MSG_NOSIGNAL);
-		if (res == -1)
+		if (res == -1 && errno != EINTR)
 			break;
 
 		timeout_usleep(SEND_SLEEP_USEC);
@@ -1105,6 +1109,10 @@ static void test_stream_check_sigpipe(int fd)
 	}
 	timeout_end();
 
+	if (errno != EPIPE) {
+		fprintf(stderr, "unexpected send(2) errno %d\n", errno);
+		exit(EXIT_FAILURE);
+	}
 	if (have_sigpipe) {
 		fprintf(stderr, "SIGPIPE not expected\n");
 		exit(EXIT_FAILURE);
-- 
2.49.0

