Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB59E2367CB
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751269140; cv=none; b=kU0cNpiqehErvfDRVBEXz6mWvAk/m6RUSSHiHzCpwFqGCTQpjw2QAww6DqV9fpWb2eB00L3lDGcviLRXYwp55+47Wk3PvWa4Kb4/pElMNdfpjETnbJMKYNOS2Pu/MuFD1p00HE51MJiBX1WkI/iXkhdnl747SMwOa7UXXybHeqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751269140; c=relaxed/simple;
	bh=6e8nhq3wAutajxTDZ1caB5Wt0cNk1tW6jl9nRmn/iB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aFfOGjnG/MMaYIXbWMeJyiLVI/Ul8LmZAuHTVcxr0kpg586Avwo6VSBuG3tjiIwOslhDvcH/U0lhh51zRzB3cKrCJ5h+iABSCeaJAumZwKkHjbWDSMg7ukwiA1ey/KoPmc5pHoJF4FU8o4chNBwNoUg+jMWKcQZQ54ZgR77LBc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBTpgngn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBTpgngn"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74924255af4so1622313b3a.1
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 00:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751269138; x=1751873938; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCu94amvUYw2PYDfqBO7v4QOw2C4FxuMQOpeOs/4SKI=;
        b=KBTpgngnks/qc02mLkNzKx5H014j5p8z0qNBtsHPVh6qRIlmMYxt/gfNlaUmJAJka+
         z+Iai7fHGI4u94Q544rYCHKDgRJ6Qo8uct3OyZDN9Iu4e66IPUrSpeK0XnHandZpGgIO
         KBg/4waY9vectcqlh/hs8/YLMp23J567Gx5CcvU98k2VRU40sKL0kCM+DHhUq6D+QszV
         31L6GgQkvKxqn5MknDN/alDW9J84M2blhANlbJQr4wwIyzYZhegZ4uzBuLWrDo2erh2Q
         3SnhZiktfJSFK9SWhy8w33zmauzikicKKvXpzD1EotnIw7yN22UNLnqF1roY1C32+hvz
         J4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751269138; x=1751873938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCu94amvUYw2PYDfqBO7v4QOw2C4FxuMQOpeOs/4SKI=;
        b=A7YWC07O+/V4lex83Jsomnq6Oz4bI8Ush4CfL804AtOJzyJC4tZfK+h7gPje6qLSHs
         mKo/qpLZI2faLm2j2z94bnldEUXS2Em5ABgFEyzitW21KFl+D8TQryxc/EQpDikgIB0X
         hN3US9p6cV1A9eynxJWKIoluuOTO5uGC58nn09Q8etQ3DyEBxYkkv/hNd9SPyPgZOD8g
         rnb5JDfxekqLYHAo1HtkkeH6drL5vCGrbjenFGiNpyozaLzAvLOCK16tCx0HEbypbQKd
         bUoSto8TfUjpfKh6xApPrB8LWlOqpOxMMWpukrsxhSECyOYeY8vOhXxwjiwcnwUhrAMs
         NXeg==
X-Gm-Message-State: AOJu0Yy78iuWo9fYwVnFTx7FjQoNHzbjvNDWqmWRodr8+Q/be0eun8NU
	ENd8WcGlrDHmJGN58OZOSmGWH7zbk4+4BQnrhQk4jILMK1WL9T6L587j
X-Gm-Gg: ASbGncv+tgxqFOp6WsJZu4VvXx4JogrDxyiFbm5hh2CCyMgUIYeD1YO23FS1QJz5pfm
	xcPrkwRFd6VTu+JjxLWa3O6MP4rS9GHyifPN62Ts8ojeJNiMUtNLf8J9UTdH7oVWWwOMI7Rxn0n
	5QXsTJhLoqj/NDz4nMVtPnkLRyshnRpfAZNPRYk5CvxGDRzlmUgLIwSmhbXMRLzStCMshvPAtJb
	PqU6mIHgoPCM+fKeCnXPqxxZRQfXhHx6ZQ1MtI/WaHv6MAef+d9JZqIhJXkLOOOsngyCwvDTe6u
	3jytnIZx9dWaP2R6PIcGYOagN467EPjTT34KxE/CqLLlIFceiyogAtRVYRLwrdGTBePX5o/uZ1t
	8m3q4SKBo
X-Google-Smtp-Source: AGHT+IG/jR+dNY+ztEgPJIk4JDK34oOEoYzWT7UbmazWLOyYpCAQk+M2Lag6gLOzU5qTgSOklpp6uA==
X-Received: by 2002:a05:6a00:b8e:b0:742:b3a6:db16 with SMTP id d2e1a72fcca58-74af6f6d21amr19468497b3a.20.1751269138035;
        Mon, 30 Jun 2025 00:38:58 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af55c8437sm8075175b3a.115.2025.06.30.00.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 00:38:57 -0700 (PDT)
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
	leonardi@redhat.com,
	decui@microsoft.com
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fupan.lfp@antgroup.com,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [PATCH net-next v4 2/3] test/vsock: Add retry mechanism to ioctl wrapper
Date: Mon, 30 Jun 2025 15:38:26 +0800
Message-Id: <20250630073827.208576-3-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630073827.208576-1-niuxuewei.nxw@antgroup.com>
References: <20250630073827.208576-1-niuxuewei.nxw@antgroup.com>
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
 tools/testing/vsock/util.c | 32 +++++++++++++++++++++++---------
 tools/testing/vsock/util.h |  1 +
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 0c7e9cbcbc85..481c395227e4 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -16,6 +16,7 @@
 #include <unistd.h>
 #include <assert.h>
 #include <sys/epoll.h>
+#include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <linux/sockios.h>
 
@@ -97,28 +98,41 @@ void vsock_wait_remote_close(int fd)
 	close(epollfd);
 }
 
-/* Wait until transport reports no data left to be sent.
- * Return false if transport does not implement the unsent_bytes() callback.
+/* Wait until ioctl gives an expected int value.
+ * Return false if the op is not supported.
  */
-bool vsock_wait_sent(int fd)
+bool vsock_ioctl_int(int fd, unsigned long op, int *actual, int expected)
 {
-	int ret, sock_bytes_unsent;
+	int ret;
+	char name[32];
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
+	return ret >= 0;
+}
+
+/* Wait until transport reports no data left to be sent.
+ * Return false if transport does not implement the unsent_bytes() callback.
+ */
+bool vsock_wait_sent(int fd)
+{
+	int sock_bytes_unsent;
+
+	return vsock_ioctl_int(fd, SIOCOUTQ, &sock_bytes_unsent, 0);
 }
 
 /* Create socket <type>, bind to <cid, port> and return the file descriptor. */
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index 5e2db67072d5..d59581f68d61 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -54,6 +54,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
 int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
 			   struct sockaddr_vm *clientaddrp);
 void vsock_wait_remote_close(int fd);
+bool vsock_ioctl_int(int fd, unsigned long op, int *actual, int expected);
 bool vsock_wait_sent(int fd);
 void send_buf(int fd, const void *buf, size_t len, int flags,
 	      ssize_t expected_ret);
-- 
2.34.1

