Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3273456DE0
	for <virtualization@lists.linux.dev>; Wed,  2 Sep 2026 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390091; cv=none; b=REth3N4xexSMnxFgQMZmdxdw0bhVJYoJm/zzObzyW2A3ifBXisU+WsV0UHyND4fXmDq+UG83Klr8MKaflEEt9ua+w6bljwk5VOEYcB5ShGmqrjPu1P3Lhpx6FOkg1tq/+RRQrJE7AQUUthGNhrNdgP73MiBUAGGAyKUjnpv0Gkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390091; c=relaxed/simple;
	bh=jkKXEIPOwBCki7hEhUKs4g/CFbe6ChFGK0eVQgaU6nU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vw4MK2f1dtPHwXyEBuyFNrY42CaWzUBn4EmifBWMV1iDr7lA1hgt7pSwBC8NfpBlnaVwkx/ORcz9szA1KMh/sJgWYW6xWpUVT22Uqp2j0ZVZbfuLMafE9qiV7gHalIa+or0brDT0aQ5m1vXHe/Gzg0DR88u1q1Q1kojPbsNQUpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtNxv5GV; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtNxv5GV"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-46ac24346b1so1001254fac.2
        for <virtualization@lists.linux.dev>; Wed, 02 Sep 2026 16:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788390082; x=1788994882; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0SPSwC6FIuR2igZB1JOk61BDdzgs1mNnqoV9+SaxkZ8=;
        b=QtNxv5GVSnm7aB2Y604D123kFVW9DOGa1FzLBo/23DH7l2wg4ijrhV7qwsnup+5VRK
         I8g58LcgU1tIoEZOK8mixgr8xnn1g2Lfv+1BK7Mv+PIS6LydAYOAO9/AJt13In3VSwut
         /zH5RCIk8c7fa+7HrMg9DfRh2OeoZYXj4MVG91Ruk3HFg5RA1H8grDXZJUyLXYVmfQdS
         HszSTPYSwyd7p6LcMXFBdDhnZq6/1lSAINH0NZX26u6frYRLF8lVaTEDt4Gp3ZgNMdn/
         vcgFwvrPQQIP+PZAO5O/63skOVo7zhMKG5Do20pnwhAzyhtoi/ZHQjGoTejQobwnC2Oi
         Fm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390082; x=1788994882;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0SPSwC6FIuR2igZB1JOk61BDdzgs1mNnqoV9+SaxkZ8=;
        b=el7ydqqV0tXUwmYAS1D6t0qe9Yna86Po+yxTkYhglTitb7JjCxlh64ZGRGtyiqcE1a
         OLWwM6G5dHmZq6UvaPLRWvL5pNaHRXkaOVmOxoJnige8OA86hvB3KqU0pp8AMqCXdn0q
         tbQr4RfYzqW/mPo890yAYFv1z3vCJ7KOv09+C4xTc7sPY4+eWEHAbdLC3IRtgJqGG0qg
         QJ9jrwygeJypGt4Se9LF/sMtSSH/Yl/uao9UXQklQZuQsWMCiu9Xbx7WGwnNW/a96+oL
         SSFXS6Cctnbm28gM/aEoW0HiAtMRq1mczVW82W5SfOp+paS8BknFmjikNAYla6TnMNgN
         GNCg==
X-Gm-Message-State: AFuF++l8fe1Oat3fImrXXu37NaZpAyck8FwB9KXhKxFgvg3LHS66k9Bx
	3MnFnzUUnMA+D3sSS8YfknxSVm0D9m2ebstXFv1ZZBcl0rcKcjnO+CG4
X-Gm-Gg: AYBFou0rg0DEoLdoNr1IrCKl2hHBdbafyz4WesUTOVeNzbuVBmnkuPHL7dNMTTCa6Ff
	mPIb68+w4EUWNziPpURV0rHYdmrTNcMYN459CZFcNe7jZqloFkLwR9RK5hn3zBPZ+riv7BU2zKN
	Mr8TBfZtX4tQj172I/pw95CYUv6lV0qRvjX5//HWDnX67Ifqr+EmsiLSXeeff/MADwPlOQXUglP
	UL9Uc4mWe04Vf7KTW7YDTw3eHkjBpmL2Vlosh0+67XtMXd4R6rFMH4cjanpznSeZGMOQ7WF6/Id
	eL3T7XMmsZtoRkZBjNOhzVF4WCtabYG6cBahrXpgcHotwX8x0GorbcHls/RjM+QK5xdC+To7JIO
	8++UA5+fTARqtJ+ZRjInHYWIEonLKQKWBo30eLyzZhUX0rk63j2XhFzIoTA5cIWjAbwfbLeR3SM
	pIR1gRBjK8yrEF0lh8nT5ap8q9nW/ntPtw3gHuxSY83y02NxI1JV+V+nfR
X-Received: by 2002:a05:6870:1426:b0:46a:dfdc:c77a with SMTP id 586e51a60fabf-46f86ce6964mr7916129fac.10.1788390081873;
        Wed, 02 Sep 2026 16:01:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:10::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46f336c72fdsm4762834fac.17.2026.09.02.16.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 16:01:19 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 02 Sep 2026 16:00:50 -0700
Subject: [PATCH net-next 4/6] selftests/vsock: add a helper to assign the
 g2h device to a netns
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-vsock-guest-ns-v1-4-9995383e9a8b@meta.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
In-Reply-To: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me, 
 jlinbox@meta.com, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

No shell tool can issue IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS, so anything
that wants to move the guest's vsock device from a script needs a small
program to do it.

It exits with the ioctl's errno so a caller can differentiate the
reasons for failure.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/.gitignore           |  1 +
 tools/testing/selftests/vsock/Makefile             |  3 +-
 .../selftests/vsock/vsock_assign_g2h_netns.c       | 45 ++++++++++++++++++++++
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/.gitignore b/tools/testing/selftests/vsock/.gitignore
index 9c5bf379480f..ffca0d9c34b1 100644
--- a/tools/testing/selftests/vsock/.gitignore
+++ b/tools/testing/selftests/vsock/.gitignore
@@ -1,2 +1,3 @@
 vmtest.log
+vsock_assign_g2h_netns
 vsock_test
diff --git a/tools/testing/selftests/vsock/Makefile b/tools/testing/selftests/vsock/Makefile
index c407c0afd938..d7170a15150f 100644
--- a/tools/testing/selftests/vsock/Makefile
+++ b/tools/testing/selftests/vsock/Makefile
@@ -11,7 +11,6 @@ $(OUTPUT)/vsock_test: $(VSOCK_TEST_DIR)/vsock_test
 $(VSOCK_TEST_DIR)/vsock_test: $(VSOCK_TEST_SRCS)
 	$(MAKE) -C $(VSOCK_TEST_DIR) vsock_test
 TEST_PROGS += vmtest.sh
-TEST_GEN_FILES := vsock_test
+TEST_GEN_FILES := vsock_test vsock_assign_g2h_netns
 
 include ../lib.mk
-
diff --git a/tools/testing/selftests/vsock/vsock_assign_g2h_netns.c b/tools/testing/selftests/vsock/vsock_assign_g2h_netns.c
new file mode 100644
index 000000000000..6f15629af607
--- /dev/null
+++ b/tools/testing/selftests/vsock/vsock_assign_g2h_netns.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Assign the guest->host vsock transport, i.e. the guest's virtio-vsock
+ * device, to the network namespace of the invoking process.
+ *
+ * Exits with the ioctl's errno, so that callers can tell why it was refused.
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#include <linux/vm_sockets.h>
+
+#ifndef IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS
+#define IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS	_IO(7, 0xba)
+#endif
+
+int main(void)
+{
+	int fd, ret;
+
+	fd = open("/dev/vsock", O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "open /dev/vsock: %s\n", strerror(errno));
+		return -1;
+	}
+
+	ret = ioctl(fd, IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS);
+	if (ret < 0) {
+		ret = errno;
+		fprintf(stderr,
+			"IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS: %s (errno %d)\n",
+			strerror(errno), errno);
+	}
+
+	close(fd);
+
+	return ret;
+}

-- 
2.53.0-Meta

