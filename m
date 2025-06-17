Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732F123B609
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 04:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750136050; cv=none; b=uB3tie7fMcNxMcJsHBFt0+ZKu5LDklKSTK1TUK2+Ze6lOfyGszqLwTHejE0l41N0rOm6ZEivV6XvJX/GbMghlvhHxlPuRY1XwC6ercHqxJ8WgonjjePQqBd/VnnHimGKLJYIIlAw3afWxvjg6mhfLHzIcxgaeC3Rjh2onM7fyyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750136050; c=relaxed/simple;
	bh=qAAEyNvoPsG1J2rvH/RjZ+lSWAbM8Y+vzxmxNzalfo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uAvzTCwYmWCAVAUfFjNFZPBSuhisn1DzHQdurU97GSx/zgULSP6bfP9RlEF3YrOIwfGUPV3ba1vnamsYtmX8fX1tMoLpA64ZbpwKD1kzwxw3+Vb4Xr8UlwDByV583QXfH1o5GZfRKsA4/nx3h563j9hR2ZtZm/K65vREubaweG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpM6IfPE; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpM6IfPE"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b2fca9dc5f8so3817758a12.1
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 21:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750136049; x=1750740849; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgHC0F7sRFE0xD766MwngM3VrQ1DYAvaKq5Aq9oTyWQ=;
        b=EpM6IfPEA9ywax6DoIVD14IjhxKjzMxakT+3PYh06nVW+odew5E7GX63l5SQrp4S1l
         LXuwAiQF4HRwv1UPepttAaytDVMoNtYDmCJq6tf4B0ngDcmD8AJbIVTO8XW1hcN8NvWd
         UW90Q4Qj73NgfyTBloWk59gLkm+35IahbiCZ1SGqADH+tdqpj0PLkOHyMxb5yyVnM/w/
         cgFdJtjPSIS3KQcL+O9+hzANpB2sIfxDSN/5VQjykbGEjFy2asgs9HIYl06ttBmmfoSP
         CONCkM18ETHPucBa4NQTTCVYueQzyEHkl/n/S9pFuxKKkPUjaBqRlxOBDRWIAlCulyWN
         LjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750136049; x=1750740849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgHC0F7sRFE0xD766MwngM3VrQ1DYAvaKq5Aq9oTyWQ=;
        b=SM5mZqnH0yLQB5QpEG5RYNgz5fQbr1NjPdWt1wFxzsLp9ROv8T5VsyUrmBtupkCrwl
         jmROY7PgOnZItiKQjZuJlhw6utVPc5r1JNpSiCqWPXwd+8D/55xwS2NwMU8DLlO+yR3V
         3Hicw32CXn5HRswc3wR6V71yw6rqXoFcDKzGuSH2yvVbexCw4xwx6WQBPrlgp/lxrBp5
         W2E1Rk/R9W+81wV+qJkFFaeIXCECv0/kZro1Cey2B5fwupNNd+V174blQBsJapSrnFa0
         Ih0IP0uQbBrpMAe5naZNXg3fm+hEc92b9R805C4IYx+hF3JoXFxjG/vMvtcFN7AtwM+4
         ZucQ==
X-Gm-Message-State: AOJu0YwiXu5gSSrGE9UBUCEyz3OpcZNAMzFFQBSJGf/pzGCqMZbSr5DD
	BJA1BBdz2fUVE/DjRrrDTIlKd/dpCsSPCJay87wmb9KzodRGQTfhgjJH
X-Gm-Gg: ASbGnctVVA6QvAK6hUvn7j+4T+jU4Wwj3GcE/Wq0a3XFOU8gdPizqCYV9Qoam6NVkr6
	DkdTngQyo0jAN20Vh/FW2aYBoitF3A9GfCjba0n/uNIJOCsk8HV0gJbI4zZwapdi6Ud9Rxj2520
	iccaI2PoW+hjk6+xfNeLUI/vjxufofYJCDB+9QFkCeggAwhUgNoRMR2R8QDDIsxjq4VmVrj+Xi5
	LjuZVT6wEeknuXSpLZaFbfqQRP9nYyTez07QUNJm3Dnkoo9H74qMMgiUyPEB+JrDIZ8SHurQ5KU
	AdBgq2Y1fw3yuZmonnRJU8pbQUCXMXpgcOo6WlVVGk4JX3t+NsDlyjPQ+AVWnGN5dNGPBs9ybh0
	kBrcVQGfP
X-Google-Smtp-Source: AGHT+IEfXDDzD9PnwNIYIzF/TekNHe0XANz+pvj6cipCHX/lkoLuDej0R9GMax6kH5rGQiod4Tat0w==
X-Received: by 2002:a05:6a21:648b:b0:21f:53e4:1925 with SMTP id adf61e73a8af0-21fbd523a1dmr15565101637.10.1750136048640;
        Mon, 16 Jun 2025 21:54:08 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890005f47sm8132852b3a.51.2025.06.16.21.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:54:08 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com,
	mst@redhat.com,
	pabeni@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	stefanha@redhat.com,
	leonardi@redhat.com
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fupan.lfp@antgroup.com,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [PATCH net-next v3 2/3] test/vsock: Add retry mechanism to ioctl wrapper
Date: Tue, 17 Jun 2025 12:53:45 +0800
Message-Id: <20250617045347.1233128-3-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617045347.1233128-1-niuxuewei.nxw@antgroup.com>
References: <20250617045347.1233128-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wrap the ioctl in `ioctl_int()`, which takes a pointer to the actual
int value and an expected int value. The function will not return until
either the ioctl returns the expected value or a timeout occurs, thus
avoiding immediate failure.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 tools/testing/vsock/util.c | 37 ++++++++++++++++++++++++++++---------
 tools/testing/vsock/util.h |  1 +
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 0c7e9cbcbc85..ecfbe52efca2 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -16,6 +16,7 @@
 #include <unistd.h>
 #include <assert.h>
 #include <sys/epoll.h>
+#include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <linux/sockios.h>
 
@@ -97,28 +98,46 @@ void vsock_wait_remote_close(int fd)
 	close(epollfd);
 }
 
-/* Wait until transport reports no data left to be sent.
- * Return false if transport does not implement the unsent_bytes() callback.
+/* Wait until ioctl gives an expected int value.
+ * Return a negative value if the op is not supported.
  */
-bool vsock_wait_sent(int fd)
+int ioctl_int(int fd, unsigned long op, int *actual, int expected)
 {
-	int ret, sock_bytes_unsent;
+	int ret;
+	char name[32];
+
+	if (!actual) {
+		fprintf(stderr, "%s requires a non-null pointer\n", __func__);
+		exit(EXIT_FAILURE);
+	}
+
+	snprintf(name, sizeof(name), "ioctl(%lu)", op);
 
 	timeout_begin(TIMEOUT);
 	do {
-		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
+		ret = ioctl(fd, op, actual);
 		if (ret < 0) {
 			if (errno == EOPNOTSUPP)
 				break;
 
-			perror("ioctl(SIOCOUTQ)");
+			perror(name);
 			exit(EXIT_FAILURE);
 		}
-		timeout_check("SIOCOUTQ");
-	} while (sock_bytes_unsent != 0);
+		timeout_check(name);
+	} while (*actual != expected);
 	timeout_end();
 
-	return !ret;
+	return ret;
+}
+
+/* Wait until transport reports no data left to be sent.
+ * Return false if transport does not implement the unsent_bytes() callback.
+ */
+bool vsock_wait_sent(int fd)
+{
+	int sock_bytes_unsent;
+
+	return !(ioctl_int(fd, SIOCOUTQ, &sock_bytes_unsent, 0));
 }
 
 /* Create socket <type>, bind to <cid, port> and return the file descriptor. */
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index 5e2db67072d5..f3fe725cdeab 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -54,6 +54,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
 int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
 			   struct sockaddr_vm *clientaddrp);
 void vsock_wait_remote_close(int fd);
+int ioctl_int(int fd, unsigned long op, int *actual, int expected);
 bool vsock_wait_sent(int fd);
 void send_buf(int fd, const void *buf, size_t len, int flags,
 	      ssize_t expected_ret);
-- 
2.34.1

