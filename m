Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8B1212D69
	for <virtualization@lists.linux.dev>; Thu,  6 Mar 2025 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277438; cv=none; b=cBCk7xICWiuXMYQhJCwYgTFstUUKzBWw0PlTVOWLYAuwOIQ04/EK/wVJoskfQssollMVaXjdJra4ut7A989ooTU7wXMIuvgNLRTOES4gF/tis7rF8rs0NEZq6767SE9kJ0q/+cDP/+qd1kWIbSwWbY/TGVyB3/hYA0zTM80H2Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277438; c=relaxed/simple;
	bh=Pt96Uovd1mpbJtnbuJAU2P1Aa68DKtd8BuptUSAoifY=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=Mpd4rDpFyXsS2tuJ27QJt3xRNZp0JWfeUUs3pBsi20JX5KC5R0R7dnc/k4gD0ak4TO3SJhEFfpYTX1CQzRB7F7CmBSkL7pFSLtQgz4rDMaHDN3CPMEGptVgfek+QaT/hup6ZG0bd1ba0WyI3XQbt5F7wjX1JGsVeqMsl4FDxxzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhnoMWYw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhnoMWYw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741277435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFLrlOS+5ld0nvFR1DksJ9cDKB3+2CeK8laqLKQbEAA=;
	b=UhnoMWYwJZIoNfd1tem/JKi8nuVJgnyIImVdmrNYG6KyaOTGO62NpJq5UYiYXiU1QZZjIZ
	9577cDvWAt9A6kg7H153lAMy4486uIoBgY4rRxZG1nS8aXn9csjDN+SdRj/UtKEMLbM7Cx
	aJRg0YzYhdbJrDqGsopN1ZokaaZUOzg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-wrA_C4zCN_mVVuorrMg57g-1; Thu, 06 Mar 2025 11:10:32 -0500
X-MC-Unique: wrA_C4zCN_mVVuorrMg57g-1
X-Mimecast-MFC-AGG-ID: wrA_C4zCN_mVVuorrMg57g_1741277431
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4388eee7073so10793445e9.0
        for <virtualization@lists.linux.dev>; Thu, 06 Mar 2025 08:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741277431; x=1741882231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFLrlOS+5ld0nvFR1DksJ9cDKB3+2CeK8laqLKQbEAA=;
        b=xDfq9WBBCQUyZSh0fhts3HE0ZCSd5MwlB6hQdkAcwiYDi0pds05Hdezb+LH5aAthLq
         SXPWMI96nT7T3jzh3NbfJ9kls8iSDOex9mCcEGN238B/XD5Lvd+/yU+uDDAbyKHi4Egw
         9Wy0Usi69elIoypBHjGWbV2I719R8fI8prXQKmk2Ub0+zY2+4a025Jt4q1tSQ+8JsERY
         lwNNSou5/9R6okI3Tjy5s02lsIuVAtqHkdiNhkyKFXJaAOfA8XVRryUusB6pSaUrkvPp
         cV8SEFbvWA1JXa7n7CFZCq1XzlF4v7HDkf+lOFHBUjouFJtl8ivlWT/nvsAMjXit0lGh
         +eiw==
X-Gm-Message-State: AOJu0Yyt+47KDKbpG5WkGdhPlFXB0iV1eAD5XyT4JxLA7lgHAqGRO40U
	BTH6Xbm4r5Q4O5BFb2cKS95RQXUEkV+4HnHXPYspKflyxNX/4t5JNJiXZS3mh4ZpeIXdvPj6lD2
	dkPGZLZb9RU4MztJzzYrf3/TMRjppWa0VDMZWPWdKFor19voXXCgdbr87vK96fr+e
X-Gm-Gg: ASbGnctHhZhlPkRSrKqRavnpB6+iRO8fTRym+X/C9T1wjQaXdx9dZ4Tf1u8UpIRAyu1
	oO5Eb6VSnKV/1kRamZw4g5bWvCQPc3SIqYJ4swnCNuDzCOLlOiCvDdls9SaauWBIOlyI/uAH00L
	8gIPM10BSU3i0Wg4JVHeDIu4LSiLam1wEwN8wVFrBc06uYRysbdyUU+GqowD3Z5dVaYJvM6WNp8
	9P82aGemttyI/b+MhtRQVAN1EHMyarp6Hze2D5oLqqLduQ8DCms3r56zsFx9nJxhdTIXjmgmBa1
	0l0dKND2zRfuNtrasxMniTYmFr6wx+vd4Ey0a1f6wHOz
X-Received: by 2002:a05:6000:1842:b0:38d:b52d:e11c with SMTP id ffacd0b85a97d-391320a39c5mr75408f8f.15.1741277431046;
        Thu, 06 Mar 2025 08:10:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdg1mu+YRP1IQFJUy+MGaPyfw9bRzO4/4jxtF7UGS83/MvazwuQz4R3F7VzC0vThUykW3fnQ==
X-Received: by 2002:a05:6000:1842:b0:38d:b52d:e11c with SMTP id ffacd0b85a97d-391320a39c5mr75368f8f.15.1741277430721;
        Thu, 06 Mar 2025 08:10:30 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([151.29.33.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cd31sm2477950f8f.52.2025.03.06.08.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:10:30 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Thu, 06 Mar 2025 17:09:32 +0100
Subject: [PATCH net-next 1/2] vsock/test: Add new function to check for
 timeout
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20250306-test_vsock-v1-1-0320b5accf92@redhat.com>
References: <20250306-test_vsock-v1-0-0320b5accf92@redhat.com>
In-Reply-To: <20250306-test_vsock-v1-0-0320b5accf92@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -IfSFzWbVLXGXaSKg2HVZfO5uHnQYr1H1tVQE2vZjDk_1741277431
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add `timeout_check_expired` function that returns true if the timeout
counter has expired.

This is useful in situations where a timeout does not necessarily mean a
failure.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/timeout.c | 7 ++++++-
 tools/testing/vsock/timeout.h | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/vsock/timeout.c b/tools/testing/vsock/timeout.c
index 44aee49b6cee07deb9443e3c2595ef680b726053..d6c69b14a0385befa6204a311c0a7f0c148ab021 100644
--- a/tools/testing/vsock/timeout.c
+++ b/tools/testing/vsock/timeout.c
@@ -18,7 +18,6 @@
  */
 
 #include <stdlib.h>
-#include <stdbool.h>
 #include <unistd.h>
 #include <stdio.h>
 #include "timeout.h"
@@ -43,6 +42,12 @@ void timeout_begin(unsigned int seconds)
 	alarm(seconds);
 }
 
+/* Check if timer has expired */
+bool timeout_check_expired(void)
+{
+	return timeout;
+}
+
 /* Exit with an error message if the timeout has expired */
 void timeout_check(const char *operation)
 {
diff --git a/tools/testing/vsock/timeout.h b/tools/testing/vsock/timeout.h
index ecb7c840e65ae5d40419bf5f9ca57fdf4051aa41..cbb183e3a73784b82b2139fbf7a00fd62521ad77 100644
--- a/tools/testing/vsock/timeout.h
+++ b/tools/testing/vsock/timeout.h
@@ -2,6 +2,8 @@
 #ifndef TIMEOUT_H
 #define TIMEOUT_H
 
+#include <stdbool.h>
+
 enum {
 	/* Default timeout */
 	TIMEOUT = 10 /* seconds */
@@ -10,6 +12,7 @@ enum {
 void sigalrm(int signo);
 void timeout_begin(unsigned int seconds);
 void timeout_check(const char *operation);
+bool timeout_check_expired(void);
 void timeout_end(void);
 
 #endif /* TIMEOUT_H */

-- 
2.48.1

