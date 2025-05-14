Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C5919E806
	for <virtualization@lists.linux.dev>; Wed, 14 May 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747232390; cv=none; b=MKVNkMFrPAOlLPIcFBDZ2Q8RwUVb9qFRl4QmdAogN9Z9s/EM7HWuzhqgU5MDE8WrEZLNgvw4dU5sfhPRiMKwiZBMRjsVubBlmfjY/8oFsuJd2tQc5Nh5rkAaSG/orAVOZ4Q1YY+Rpj3c4IVV7wAHdkCqJHjAqDGgyhJx3rDEvrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747232390; c=relaxed/simple;
	bh=5Sj5KzI/F46StOB82OyP21k7diNVwpEzL2KwJR5OdEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=kEktLocYJ1jToDwVJCKSE/gfHMRkWoy6rz3FDHdUNHDuW5oVB+nIL3NaNbooCCdxQPYj7pfTI0gteeQThlV3U0PpaJfnNoDC7pc8I9uo3sBoMGwwJOL8cDJlxpNqmO8tvLzT+nH9ZAtW+NsolPebRFy9wVsvFB1cVr7dWqsXynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CG67IdUT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CG67IdUT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747232387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Zvmt/u8Of+L1THnq1idxvoVHR9sJvksCbQhIaqH1ko=;
	b=CG67IdUTxGrJRen9V2jnwxUXBNYu3fLjUoT42K7b8VNHeAI5EPX1uuAnuJDGWcYgST1CVk
	Dmqn1oqWwdMtNP9RRKUlH6RaHYtMnVZ2uxwPJ0wJzi35QQM5sOQflDGBsRieHzjSOPx7yy
	/YrOYboDj69Hadn/q3X2WOBjyKZLac4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-sIH2xn79OF2-VQd49ky_DQ-1; Wed, 14 May 2025 10:19:46 -0400
X-MC-Unique: sIH2xn79OF2-VQd49ky_DQ-1
X-Mimecast-MFC-AGG-ID: sIH2xn79OF2-VQd49ky_DQ_1747232385
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a1f6c5f54cso2178802f8f.3
        for <virtualization@lists.linux.dev>; Wed, 14 May 2025 07:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747232384; x=1747837184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Zvmt/u8Of+L1THnq1idxvoVHR9sJvksCbQhIaqH1ko=;
        b=cE3DWJlpZshX4BKy2GkiSxIT4VMdZF8wbHZTFx9JeOLg2FmX6Z8UAxrPJBQwCQnmRy
         TyF/USIkV8tOFzDJYjhmwlksH3PL8Hs7y2xm1RcdqzerRxeQ3XV/NbtXs3MNZ2Q2laun
         pfJdDvJVXaFSseu4LJcLMxJ4WUDDNGDKcVeySaIZ32v3qPo5PZJrjLv4U+WPAAsBoGHG
         obw6E5U8Ut4Fu0iNzq86xnUSPyA5lwjEhvIXgM4QRT7fLkNIjNHfz2Io6F1i/pr+AaGU
         Or2zAicp0jHDWicLDCElg9VAEaHMKBPWuJZeGCqHBWfiPc0KaT/F6P+IRy7DJlDBZqTH
         F8Eg==
X-Gm-Message-State: AOJu0YxrHSIxGS3pAxSokDWOzZDDs1vphuzUq2Bisvubcb1uve91+P97
	FksGt8cS+3CyJjclf8livAcj6/PCfuH2i6r48BfseDQeVPuI4gjVpFu/TYwcOj8ZVYAQbhvrun0
	GUsw0TNMQZAZ7+wpnoQjoHyVgV1ztDN9b4LOCJdtH/txKXtuguCw0mRMAWcYY5WKQfZmN09jN
X-Gm-Gg: ASbGncsYtq/ywtp0nNxxk+rLJjflCIic1dbfMi+B151LyO5dHd8BgEsrJhQGeqCYdqQ
	A/PdXZdm/bdQ9tFGw8IWruYz6hfL7KZb7DVSHBd/crcAbpn/OvqPXh30QlHerNNXN/wEwejkdhH
	hXnzqXDojbZJVoO5Y8uFyEKeMOcNkg9SynDpKfF36slB4gzXbkndhnoj9piFbqLGeTEdLeQbXYc
	LC/tY3MJ+QGQJFlc/WNq34rGdheDgZ3RiVYL1qhs3rgIA2r4+YgniB79luEXWPLp2N4+7yDP9lk
	AyBoiisFIf4KdPzSGg==
X-Received: by 2002:a05:6000:2011:b0:3a1:fcd9:f2ff with SMTP id ffacd0b85a97d-3a349694e9fmr2882895f8f.12.1747232384554;
        Wed, 14 May 2025 07:19:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlD0Y36veSQX0bZUBU4CJr9Oc/mcPJK9k57/34jB6gCQcLqBmTZi0wMgJYerwAAhbWQRLHsQ==
X-Received: by 2002:a05:6000:2011:b0:3a1:fcd9:f2ff with SMTP id ffacd0b85a97d-3a349694e9fmr2882865f8f.12.1747232384019;
        Wed, 14 May 2025 07:19:44 -0700 (PDT)
Received: from stex1.redhat.com ([193.207.203.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f28f7sm19625694f8f.41.2025.05.14.07.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 07:19:43 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/3] vsock/test: retry send() to avoid occasional failure in sigpipe test
Date: Wed, 14 May 2025 16:19:26 +0200
Message-ID: <20250514141927.159456-3-sgarzare@redhat.com>
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
X-Mimecast-MFC-PROC-ID: A8VHRbw6M5dAjqscWZTAydiiDfpWCgGg9ivjExmepdA_1747232385
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

When the other peer calls shutdown(SHUT_RD), there is a chance that
the send() call could occur before the message carrying the close
information arrives over the transport. In such cases, the send()
might still succeed. To avoid this race, let's retry the send() call
a few times, ensuring the test is more reliable.

Sleep a little before trying again to avoid flooding the other peer
and filling its receive buffer, causing false-negative.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- add little sleep [Paolo]
---
 tools/testing/vsock/vsock_test.c | 38 +++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index d0f6d253ac72..68f425af00cc 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1058,17 +1058,34 @@ static void sigpipe(int signo)
 	have_sigpipe = 1;
 }
 
+#define SEND_SLEEP_USEC (10 * 1000)
+
 static void test_stream_check_sigpipe(int fd)
 {
 	ssize_t res;
 
 	have_sigpipe = 0;
 
-	res = send(fd, "A", 1, 0);
-	if (res != -1) {
-		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
-		exit(EXIT_FAILURE);
+	/* When the other peer calls shutdown(SHUT_RD), there is a chance that
+	 * the send() call could occur before the message carrying the close
+	 * information arrives over the transport. In such cases, the send()
+	 * might still succeed. To avoid this race, let's retry the send() call
+	 * a few times, ensuring the test is more reliable.
+	 */
+	timeout_begin(TIMEOUT);
+	while(1) {
+		res = send(fd, "A", 1, 0);
+		if (res == -1)
+			break;
+
+		/* Sleep a little before trying again to avoid flooding the
+		 * other peer and filling its receive buffer, causing
+		 * false-negative.
+		 */
+		timeout_usleep(SEND_SLEEP_USEC);
+		timeout_check("send");
 	}
+	timeout_end();
 
 	if (!have_sigpipe) {
 		fprintf(stderr, "SIGPIPE expected\n");
@@ -1077,11 +1094,16 @@ static void test_stream_check_sigpipe(int fd)
 
 	have_sigpipe = 0;
 
-	res = send(fd, "A", 1, MSG_NOSIGNAL);
-	if (res != -1) {
-		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
-		exit(EXIT_FAILURE);
+	timeout_begin(TIMEOUT);
+	while(1) {
+		res = send(fd, "A", 1, MSG_NOSIGNAL);
+		if (res == -1)
+			break;
+
+		timeout_usleep(SEND_SLEEP_USEC);
+		timeout_check("send");
 	}
+	timeout_end();
 
 	if (have_sigpipe) {
 		fprintf(stderr, "SIGPIPE not expected\n");
-- 
2.49.0

