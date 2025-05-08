Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D4227054B
	for <virtualization@lists.linux.dev>; Thu,  8 May 2025 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714030; cv=none; b=BsyGbFhcwHedEK0+wFGjsGGPHdcaw6yR19kJOfkvL6TDVXI08ZQA3ohpOROagBxQ+ZaSN0xRMlH4ibLQBELEsExstkRAGkvzX2S4PeP5sBAoGKwdMRaVVSuUQqJcWcp/FhmbKsporJOMgfzOZevZi/y5kdOCpA6PcuaTorpTmh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714030; c=relaxed/simple;
	bh=YvRNLSi/VrpoieogGKGsgCKAlWpBPuTAmyy56vB3yh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QeTQcTQFPwuCRQX4YwPCGzetmyEmmTqJASdNd+5T768e4bBJbi9xeSb1NrSg6OCKFDafsBL5jN7/gv78boJ4XUpPaGgN89sJF+F2gmWc0aVbJJktGzon+zmq4K+yPSMLsPkcmmsGUB9hyb/lvS+hF+mgYiEY8oDgXzncnP/abns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akON1GhP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akON1GhP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746714027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/inhQIAJVDlclzovizj1G424bvRWbJSy56O+ePhgtM=;
	b=akON1GhPG+3TTRNV1P3WOAok9N6Bb9nT3licqHyhrfMUKmfiegL/QzPTPtE1L4bcRDp3oo
	rNZ5QfL+L8TsaWhq7hWPR9B/QlM8zHRWDgmExmWf7xX+g+BySoDfF/Sq7juCXjNZXqD8Kq
	4Co+g7iNSBDZIHcwN7Ufw5yhL1Cd7fI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-MpztXviiPROGQ_l4Qf8N_g-1; Thu, 08 May 2025 10:20:24 -0400
X-MC-Unique: MpztXviiPROGQ_l4Qf8N_g-1
X-Mimecast-MFC-AGG-ID: MpztXviiPROGQ_l4Qf8N_g_1746714023
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac6ef2d1b7dso106148766b.0
        for <virtualization@lists.linux.dev>; Thu, 08 May 2025 07:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746714022; x=1747318822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/inhQIAJVDlclzovizj1G424bvRWbJSy56O+ePhgtM=;
        b=EpGFC+GDpRMi1tTxgaveRyLt+aq5q3aN9CRzw+e/5OOUTSikO+c8xYY6+cz+l9a4++
         LrKmG11NAbvp715AQ1zBrC+TmZe1mVwvaW9H5gQCN9Ya2pqdyJNfUfltWICFt9MEtppe
         y0sy6LytQRNsWcNdY/FKtt7qABxebq6y3SR2CAFgc5rlqCENhqk8e9GgjswrVuUve/Er
         T9X9cVrNappatcXQ7c+cFnMacffX2Y4AABhT/25TyxR8oJpFaK8RP+ba8Zgm6MwmowF9
         +lwAIAiuCJ+hU6UhdBaurxgjm45PUo2646uzo1UOD+XC+vBLSRGAGVtCAJE+Jb3msNss
         va2A==
X-Forwarded-Encrypted: i=1; AJvYcCXFeGoIKCJ/6lQyzLBtP2mIYTgXKm65+sPhDKtoGkV5wc2gDoqvCvLw3nr2h43a+KM+JyIp8BlI2VR7WU2ifQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4r1f0d/c18Ly8/Eo5y6e7oo+llusaUw4zO0xdja9Y5d4ltaVO
	0BJTvqSCBQ8V8uk9T8S6z1nFQTsLQkhJNp/pV1Exgps6S+3LnEz9zhysxWogEAIva2jIEd1p+ar
	qZnJrKYiACY/1qIY7nlkLS54rGyMwoXOrWRNwxuR8d7+Z3KgqSxI+IcMXK3SQrS7A8WmxKBrz
X-Gm-Gg: ASbGncvlU3NL8UqOQW9PMmr17WPNJY+4aVS6EnjV9Hyunb65ItBXqbh1OlBikj3N270
	BJzsvkyQnYCAaPRsJ7k0nLWQQ9fYJV1ZBqaz0QI/9bgHWPywiBhQjQedRd/6RwmX6E/OZtl0ZlI
	e4Cf0zJsN2IweDxA6MaN2Z+KbL3jrPuIHDIkX5ULceu5YVcU2nVr7FUsvxE+BVPWz5xRsSpjjgJ
	a6S+9d2RQmP2KVyEgMIElOk3Uh1HJnb8dhS1WrJZxEnuF8e5Hb1pqLk9ywXS/YFpeAN2LKhwH67
	pvy2YHPTC+M+/ZsH9cy8W/Y6mw==
X-Received: by 2002:a17:907:96a7:b0:ac7:b368:b193 with SMTP id a640c23a62f3a-ad1fe6f68b4mr342644766b.27.1746714022440;
        Thu, 08 May 2025 07:20:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRTgUh6IEfYQONbpJtEOHpIxAXun5putCZzRRkLB2V22yE0BXo1RjIX+rhP121YMlrUvpBiQ==
X-Received: by 2002:a17:907:96a7:b0:ac7:b368:b193 with SMTP id a640c23a62f3a-ad1fe6f68b4mr342639966b.27.1746714021843;
        Thu, 08 May 2025 07:20:21 -0700 (PDT)
Received: from localhost.localdomain ([193.207.221.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189540d5bsm1096012366b.176.2025.05.08.07.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 07:20:21 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net-next 1/2] vsock/test: retry send() to avoid occasional failure in sigpipe test
Date: Thu,  8 May 2025 16:20:04 +0200
Message-ID: <20250508142005.135857-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508142005.135857-1-sgarzare@redhat.com>
References: <20250508142005.135857-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sP1mFYdZt8ctHnO77gZni2ukd-LxTcpMhGaGHAPVCIo_1746714023
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

When the other peer calls shutdown(SHUT_RD), there is a chance that
the send() call could occur before the message carrying the close
information arrives over the transport. In such cases, the send()
might still succeed. To avoid this race, let's retry the send() call
a few times, ensuring the test is more reliable.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index d0f6d253ac72..7de870dee1cf 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1064,11 +1064,18 @@ static void test_stream_check_sigpipe(int fd)
 
 	have_sigpipe = 0;
 
-	res = send(fd, "A", 1, 0);
-	if (res != -1) {
-		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	/* When the other peer calls shutdown(SHUT_RD), there is a chance that
+	 * the send() call could occur before the message carrying the close
+	 * information arrives over the transport. In such cases, the send()
+	 * might still succeed. To avoid this race, let's retry the send() call
+	 * a few times, ensuring the test is more reliable.
+	 */
+	timeout_begin(TIMEOUT);
+	do {
+		res = send(fd, "A", 1, 0);
+		timeout_check("send");
+	} while (res != -1);
+	timeout_end();
 
 	if (!have_sigpipe) {
 		fprintf(stderr, "SIGPIPE expected\n");
@@ -1077,11 +1084,12 @@ static void test_stream_check_sigpipe(int fd)
 
 	have_sigpipe = 0;
 
-	res = send(fd, "A", 1, MSG_NOSIGNAL);
-	if (res != -1) {
-		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	timeout_begin(TIMEOUT);
+	do {
+		res = send(fd, "A", 1, MSG_NOSIGNAL);
+		timeout_check("send");
+	} while (res != -1);
+	timeout_end();
 
 	if (have_sigpipe) {
 		fprintf(stderr, "SIGPIPE not expected\n");
-- 
2.49.0

