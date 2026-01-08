Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33036425481
	for <virtualization@lists.linux.dev>; Thu,  8 Jan 2026 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767872669; cv=none; b=lx6mjgh+x0oGP9dgu78dKDwsLPuUlaIC46BilhvjZAsnTq4oOk4nBnY7IbW3GHMeLuWacoFjevX9XOhqOzsAM+Cq+a8qqNyZw9Zle4LCuYrNF6Va24ZXvYaHHu6ZxHcPjy/a/FDnvVISpb0JXcsrLsIhgwl/Rvy+f9vzIOo0jkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767872669; c=relaxed/simple;
	bh=MhjOQ6tmOpwUURIT+Tj/wOwtK7iu+4OcYSITUD2+mYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=o/vGkOKMfa18H9ot0TKwJZGpzmymRXVRsJ3JzAg5v0XPuJ7wLlBjrDBRRr7QnBm8d+8g6V4WzjE78Y96f2L13X/3NP0lzn2IrXJV183sMVhXBXvn3uGvCthQKNUjsPxN4aevSkmIEGrjf59VDxc292sJ7AuMgTT1slhxlFwjgyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNjhN+N2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNjhN+N2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767872665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G1ixihK0gQ+hFNZb+Yl0BISPWkVFMXZp1kkOJZgBibE=;
	b=aNjhN+N2S9GbKZZHaqXrbMox8ySB/B2/BvcIIxAOAWvQm0sK+8JApqcn5EPUZGbNdJJZ1m
	vaRdu1BhKdIp0rk50HDCuuOKBDzQGN//kS2rJHGQ5KXx8oMEaPY/hwdP9EE3ICNZc0q94M
	wYv5jDPi2AnmViMR/jGKHo+UFOQY8wA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380--MsBJPKCMcKyC0JBQSSkwQ-1; Thu, 08 Jan 2026 06:44:24 -0500
X-MC-Unique: -MsBJPKCMcKyC0JBQSSkwQ-1
X-Mimecast-MFC-AGG-ID: -MsBJPKCMcKyC0JBQSSkwQ_1767872663
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fd96b2f5so2223456f8f.3
        for <virtualization@lists.linux.dev>; Thu, 08 Jan 2026 03:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767872663; x=1768477463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1ixihK0gQ+hFNZb+Yl0BISPWkVFMXZp1kkOJZgBibE=;
        b=PmK5a7mZciRMlyMmRaAzKedlIALnOPSfjU809xqIcUIEhpm544GtaBTCBJPeWmLWmm
         uabsAjeAhoFnrJOt+2q1wibELpNB81WRMX6mSSYR0j2mOq9fj2kOX4oHM0sFFGAKy79Z
         YinBjWZbf/E8lPIsrvi6e2qw+NyNXS0X7nkg16zUC9oAryB/os+PvSNU3oixAcoatsUH
         HjqNPlri5IZwSWDwujk+RRDGCwyUdpsfA4G83lJrYVi2N/09t2sY8eyfSdvRc9b8JGKh
         h2rb7FdpM4Zr89LgFZI+bPLcT1DVrQqLxxbKweIz66LX8Bup3xrq0gKCFI9XlvkYKJkh
         Th/A==
X-Gm-Message-State: AOJu0Ywe9uM2Z+m7AEU2IVw3iwVi43mWCHRHYv+eEvikG1x5eSYJFoqC
	1iDKw0NmIZE9zSJmj7N7k1SSVNHzDMueeI8vkBuQF6Pke/iCanVn1Edt5C29b6W1OUbZ+LQep8c
	ZpYG3Ox9CToW7t6asyrfr//wXPYJ/L7KtNTqUlYUiFbBmafNEO6qFSvGJWKCfH2gFcJ17
X-Gm-Gg: AY/fxX6VoFlu7f4yXEmv/DWN6TWS5eqYsKMLulS4g57m8v51u/xjC4ISDe8qP7TzBrW
	ahwhD6/PT1qJ7LABtMEYu5uSn2GPZk//4N4BaajojzkFuh0aHl85dKEyGQurIBGm/lGQoJcR0Lp
	K2wvSbNx1c8OrIllw7fztcZqwrdhjiH4LtsqctSgl0SpCZ+thwD1t238oik80BayCJszBZjQ6wx
	Vd6xAAbhcXv+7eXm+06GXqMJM0t+BFjo6Y+/9UPrUQ+/3I1nOEbp++wb7APBf6qG0aazvjAq0j0
	LyDc52NaGTzeIoLrAugUVODoccQE7ttDNZnnEAJFSo/OAMb2IPW3MlVt752RUQM2/VNIsyKTzhB
	9AjVTtdUZObgxgcMi7g==
X-Received: by 2002:a05:600c:3556:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-47d84b3bb18mr71180715e9.22.1767872662846;
        Thu, 08 Jan 2026 03:44:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkHKGejy8Hjd+SNLXzLlfus0//cWgbdRbbQV3EefELMJbpz06K9AfM6OsyNmFE2rKQ3DJOqg==
X-Received: by 2002:a05:600c:3556:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-47d84b3bb18mr71180415e9.22.1767872662398;
        Thu, 08 Jan 2026 03:44:22 -0800 (PST)
Received: from stex1.redhat.com ([193.207.178.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8660be14sm37910885e9.1.2026.01.08.03.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 03:44:21 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net v2] vsock/test: add a final full barrier after run all tests
Date: Thu,  8 Jan 2026 12:44:19 +0100
Message-ID: <20260108114419.52747-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: anI8-TvKXSSmmUR5hAWGgu2at2g04l4JjqOVbtott74_1767872663
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

If the last test fails, the other side still completes correctly,
which could lead to false positives.

Let's add a final barrier that ensures that the last test has finished
correctly on both sides, but also that the two sides agree on the
number of tests to be performed.

Fixes: 2f65b44e199c ("VSOCK: add full barrier between test cases")
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- code unchanged from v1
- target net tree and add fixes tag [Paolo]
- added Luigi's R-b

v1: https://lore.kernel.org/netdev/20251223162210.43976-1-sgarzare@redhat.com/
---
 tools/testing/vsock/util.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index d843643ced6b..9430ef5b8bc3 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -511,6 +511,18 @@ void run_tests(const struct test_case *test_cases,
 
 		printf("ok\n");
 	}
+
+	printf("All tests have been executed. Waiting other peer...");
+	fflush(stdout);
+
+	/*
+	 * Final full barrier, to ensure that all tests have been run and
+	 * that even the last one has been successful on both sides.
+	 */
+	control_writeln("COMPLETED");
+	control_expectln("COMPLETED");
+
+	printf("ok\n");
 }
 
 void list_tests(const struct test_case *test_cases)
-- 
2.52.0

