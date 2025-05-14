Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C47D19C54E
	for <virtualization@lists.linux.dev>; Wed, 14 May 2025 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747232383; cv=none; b=Sn59Ubf/sDTyeXUGIraqSPyAj9eHsRO0gBTrncyZ2OqnvgYhPDHEk83YyhBvI/0dELUzFENxt5ARDbi0W5AcflMayaFJYSGS/zd/y+Y3U8YuCdiy6mOqDXe76pMGd/fjE2V0qIRqkCnNYuNLpdqw42rKx6ytxWOAkjeDnEGxhUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747232383; c=relaxed/simple;
	bh=MDkS8ldGXScRZONUBL673Asf/ksz7j4BMNcyHSf2rFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=PLfGYg1PiySFiMpGDwZseIF2qctSmNfquBeTtbwdH0oXiEyUh1e3sp3Z6SUD9XNln2a1dcorYyZwe0RhR8TyjrGqaYUDUda08L0J5ea6U9B3ZUT9gaXlkFLjxMF8dI0hZM1x7wv3SMY9SC3lI5P1lDn3oLE5anTtfFO68IG4DfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SP/KyPs7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SP/KyPs7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747232380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRSwjGEuphQPWi9/jNcoY4twWfTF60gioe70+GQBSH4=;
	b=SP/KyPs7YGeMBTBG3jUVXEWflLPSbHALms5DhEPZVCwdL0hEZmfL9o7jiT9l66WZn7/ciK
	Uxd2oBBFHSBu4ag7BAzf0mQYu0rIbOqjG6/tn0f+wT7AOSNbdBpCgpusMgsjmPvratTaXn
	g/w6qwvPiugpONMzP2jkeXUlfPghqU4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-YLtu1OtqON6KcWjOa36UWA-1; Wed, 14 May 2025 10:19:39 -0400
X-MC-Unique: YLtu1OtqON6KcWjOa36UWA-1
X-Mimecast-MFC-AGG-ID: YLtu1OtqON6KcWjOa36UWA_1747232378
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43efa869b19so47417675e9.2
        for <virtualization@lists.linux.dev>; Wed, 14 May 2025 07:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747232378; x=1747837178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRSwjGEuphQPWi9/jNcoY4twWfTF60gioe70+GQBSH4=;
        b=EPeVug6h6+v+oofwOW1zmwu7cCshWKVa4QTUhU/ILv0iXipvrAijqVitZr0exbkm6N
         KAtc7w5Ewa1Jg40gSWbyuI2rx09rOR/AqKzoVFse0APibCwAmxx+i+4uDb8nrBGryE0E
         rdJudQy6IcyzaC9Yl6mwgH6Qd1NHvzcCEkS/IYj8FJzjYhCntJhNY0QpglI0X27E6Adq
         jY+DtSIXiAT+HH9GUheImFuoxwP9K0vohPK5fZqSF42EqVDzJu8Pk6/m8AVETBJH8Dg+
         eISrzGs7KM9yz47iQ2TyZGadK5+KQjpLYdKFJ2bN0RXdOQVDJ8hS+0Ezlm4UhnwE6FAI
         slgg==
X-Gm-Message-State: AOJu0YxDlWP3Us6UpvBGVKgT8kHlocAukkOWXLKIuNAtsLzUMoTi8tGt
	eODvmi0ayjD7bR+GbWuBJaAqTZ/wFuzPt/1Eec90Rk4qYreJUYPn+Mjab+SlAFq5KsHb1Fa/M3B
	62WQwvykR+g1RbO9NqBakVBlCqUs/MXTQrz39IKFEnG+cjSzeX/kdzE8SikMCCB1v
X-Gm-Gg: ASbGncukQUaqmEmwyseSkzX7foC5CkDr0ZOmsFUWmfB2V+Tfo1r+ByVh4yG5BPhdMpv
	QYIFWhVjSTrNB9R8t5vzAhFYh5/e7VyS87ZNJvSDwrA6lJc7h0rNW0oPFXjDyR5GflcvPjZGaNL
	ljfjMDXaisH/ldqU5A+L68gw7lN2GIpKVhyEl26AJFrZSwmhgg6aMZ+BATozgU88v9yXLqESaHi
	GqX/nvavobrUnttwugYrh3MdvyYSiVHJ+m7FP8ATsCUnLdw5Vqv402CcUJPUK5kxXTwkqEteBGV
	cCh+MyzdaVQd/DT5NA==
X-Received: by 2002:a05:600c:3494:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-442f20b9b46mr35323515e9.4.1747232378284;
        Wed, 14 May 2025 07:19:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEF2R2tDjrWwT+L3uOaPxQKRvbLVHWMJVYv5KC6EA6jIX0QqXFdhjGQEIvk4sDMFBkXNW9ig==
X-Received: by 2002:a05:600c:3494:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-442f20b9b46mr35323015e9.4.1747232377726;
        Wed, 14 May 2025 07:19:37 -0700 (PDT)
Received: from stex1.redhat.com ([193.207.203.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39e8578sm33288515e9.29.2025.05.14.07.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 07:19:37 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/3] vsock/test: add timeout_usleep() to allow sleeping in timeout sections
Date: Wed, 14 May 2025 16:19:25 +0200
Message-ID: <20250514141927.159456-2-sgarzare@redhat.com>
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
X-Mimecast-MFC-PROC-ID: hdmbxk0F7cA5JerT_b1hcqxUhHu4zE6PBWA5Ksp8dLA_1747232378
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

The timeout API uses signals, so we have documented not to use sleep(),
but we can use nanosleep(2) since POSIX.1 explicitly specifies that it
does not interact with signals.

Let's provide timeout_usleep() for that.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/timeout.h |  1 +
 tools/testing/vsock/timeout.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/vsock/timeout.h b/tools/testing/vsock/timeout.h
index ecb7c840e65a..1c3fcad87a49 100644
--- a/tools/testing/vsock/timeout.h
+++ b/tools/testing/vsock/timeout.h
@@ -11,5 +11,6 @@ void sigalrm(int signo);
 void timeout_begin(unsigned int seconds);
 void timeout_check(const char *operation);
 void timeout_end(void);
+int timeout_usleep(useconds_t usec);
 
 #endif /* TIMEOUT_H */
diff --git a/tools/testing/vsock/timeout.c b/tools/testing/vsock/timeout.c
index 44aee49b6cee..1453d38e08bb 100644
--- a/tools/testing/vsock/timeout.c
+++ b/tools/testing/vsock/timeout.c
@@ -21,6 +21,7 @@
 #include <stdbool.h>
 #include <unistd.h>
 #include <stdio.h>
+#include <time.h>
 #include "timeout.h"
 
 static volatile bool timeout;
@@ -28,6 +29,8 @@ static volatile bool timeout;
 /* SIGALRM handler function.  Do not use sleep(2), alarm(2), or
  * setitimer(2) while using this API - they may interfere with each
  * other.
+ *
+ * If you need to sleep, please use timeout_sleep() provided by this API.
  */
 void sigalrm(int signo)
 {
@@ -58,3 +61,18 @@ void timeout_end(void)
 	alarm(0);
 	timeout = false;
 }
+
+/* Sleep in a timeout section.
+ *
+ * nanosleep(2) can be used with this API since POSIX.1 explicitly
+ * specifies that it does not interact with signals.
+ */
+int timeout_usleep(useconds_t usec)
+{
+	struct timespec ts = {
+		.tv_sec = usec / 1000000,
+		.tv_nsec = (usec % 1000000) * 1000,
+	};
+
+	return nanosleep(&ts, NULL);
+}
-- 
2.49.0

