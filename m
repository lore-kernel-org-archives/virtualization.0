Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD7523908B
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270276; cv=none; b=usBbSUOhs2tFHf4BJqFJ0PWMD9mB/IWT3QIQ6hy/RaH49kedi5v6Zh5+Mfluvp6OUrS7iOsghxb8niBqQMKzGaWmIgbvncBsY294lWrU2lkVVkOAgnsIXu2FE9F72QuawtUW8sAfiHUtkJL6/sFcWXLkOmsOA1ytin7qVRDF/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270276; c=relaxed/simple;
	bh=6e8nhq3wAutajxTDZ1caB5Wt0cNk1tW6jl9nRmn/iB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aHogBag8NRsbfvIEGSQag94qXRMcOj8WmGneUP1SJeTJ08V/9Zto+DhjGAXoWt3eTwdwVcgQYBSwXslj0lDIBHDee/OMakbOJ1wvwXQ/9fJY1qoQV7owoG0eS48rRey8PIK4tKJIa+mHS33erLGekAOHTnfXiHOa43ucN4FnZW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpHJe6Ni; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpHJe6Ni"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b170c99aa49so3365089a12.1
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 00:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751270274; x=1751875074; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCu94amvUYw2PYDfqBO7v4QOw2C4FxuMQOpeOs/4SKI=;
        b=DpHJe6Ni9MwtoiEwHtkFECPmzSqkT9DPcl3FXSn6HiVVoKDE4KZr+o+MZGBURzbpVg
         B6eUwTlZi775X4DuqRIjdYt2EiO1MXqkyFtIEbZxzo9oNpfu0trglSC9/n42wuY5RiOX
         a+fvCjMGn+9uoClbIHHq1yB0WL9quY1X1xd2BQngcYbFh3D2T45xk45ffEYqS2j184Ln
         hx2MUWibpOF8eAFCmA5rJG6ChSSVCYtEaQoMy/U/mFBFSyVpv4nWmsvF8ybolu8Q7O5l
         DUxD8HnNih5szgCKxk8obqoWWIVUeVibj9omqqn6YM7Dwv5YhIanQpkH77bdPQI6qUrR
         2ilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751270274; x=1751875074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCu94amvUYw2PYDfqBO7v4QOw2C4FxuMQOpeOs/4SKI=;
        b=vKIjHfFFSSqMIK0KyLi3RORORyIyf5cCxsg09dMGJ3U1+AjSkAz/2jeKSSDCIBWXHv
         8MSTMilHrFyLChtHlS/nd/QZO+Gy5tlAyq9yRHsqZCmG0r1IdDgtYD3Q9lfarL3fL/0R
         cUcuiy07UqUp3cRdyX0g1ucL7EBB6gKaEK1ZbfB59gnZiZMhOTOU6Ljp+CF21hzRVcHf
         fSMpwu/jKR+bP/uIwml9kCQsy+brKu6SkaNfhdwTbaDwHJggWrskpYgb3CaB41UzTRij
         lpg/ar4nhBAjEy71SlLZDPDFHZtChaVMPcfy1/IgnLrG0ZZNtnGga+x+7fdZLNoO5Vw1
         TQNg==
X-Gm-Message-State: AOJu0YyRI7DmA11Q1Uh76Ros6SZv3beh00S8ftpH9BwLyWJGgSrrjGiS
	wszSOwg9fPG8jaAxcj30R6pRuVeS29V5uTTbtB9OtbfD4s2/mUgI0zr7
X-Gm-Gg: ASbGncspaY8iV2eBPSaWaIdXvrdRUK5PR747k/PYPlpWjAZyppXnrwJIGFjrzzS/gaP
	CnQ/lt+Y2h4N2bPBbfAzRqxllWKVg1dQL9O0wCZeOtmV6MHbEvpnNHFZrzwx+bPuGqnU2t6dT0Y
	sPT/I70jXArZ+yEP4AD34qqKFHwnnMQGKlCWIgZT9uYWe8DxK3bm9vyrUupbQkoVI4Xf3p3OGjj
	6qSrl1sluoQ++CKq0z1Qouiip5yqhB3N/hqPS5KN3mfWtbLqym8WTo8CuiytsRTwuZCFPweEVZc
	seTpq8xv78FcIPEw/s/5kJmQaA3tjz3I/xfB93bJ2YcjVtZxhAsafhlStPQkLWoYvYLu/3QAoxh
	6tWhD3wsm
X-Google-Smtp-Source: AGHT+IEswJGvdxBSoFaPb2APxP0ZX96sIgqwRd8xIVVkz2BA3zKqHue5sohbeXX3Sz09j+bn0a3pig==
X-Received: by 2002:a05:6a20:734b:b0:220:2e32:4e28 with SMTP id adf61e73a8af0-220a17ffa45mr17177744637.42.1751270274104;
        Mon, 30 Jun 2025 00:57:54 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31db02esm7414931a12.63.2025.06.30.00.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 00:57:53 -0700 (PDT)
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
Subject: [RESEND PATCH net-next v4 3/4] test/vsock: Add retry mechanism to ioctl wrapper
Date: Mon, 30 Jun 2025 15:57:26 +0800
Message-Id: <20250630075727.210462-4-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630075727.210462-1-niuxuewei.nxw@antgroup.com>
References: <20250630075727.210462-1-niuxuewei.nxw@antgroup.com>
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

