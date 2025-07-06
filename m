Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4DF1C5D4B
	for <virtualization@lists.linux.dev>; Sun,  6 Jul 2025 04:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751776641; cv=none; b=R6M2vLVyTJmoFZ7+0DTq6duBG4ojKyy9ivr0Go90WNs3BNkxDW8XMwWuEo5ojBWAQyv2+Lufd4dOwyZupzXT+sPYVck4AWSkmvwiYWRaTvKsHDddUDAvWR/cXlNsDSMMTtXorCE/zGUydawRDv6a9QbbiQmX6gvCQSwLIeyKdiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751776641; c=relaxed/simple;
	bh=e6+A6V/GIHjY2NtS85toohY3fDmWeS+De+ENSmkaW48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RFKoF3fyglnZ3XTQA+MCNjWkIPKx4DJ8ClPsb1w+zO+PGtk6U2aJB/jFXkgPXQZIrAiRUCbhc7dR9bKvGvHDfh2X07FrCs2sdcG1q5CGShaD/Yx86RbrhzLeIfRgOrNkcwVmNNqy6EHX8f/JfO96jfOo8+NGCy/pL8u14e3xHfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1nqTSr/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1nqTSr/"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso2598450b3a.2
        for <virtualization@lists.linux.dev>; Sat, 05 Jul 2025 21:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751776639; x=1752381439; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Adkwaehj8WQlyxe1tcyATntmfd0OiZXAi1oQdyK2Hg=;
        b=a1nqTSr/DIUHE38u3tEYqkYmT1vyQNdwyUCpv0MTDfdTQW5nAEp2SzRr9j6223Bw9e
         n9LJIsdIcLPJnkG5mn2OUHGbCRC1pRhjOph0t+QK7W9QsHIKdccXz90apn4ZD+cW4BGD
         U4kx5OciNGVJwe+Xoi5fLtKPsVAMCjZmiSQ9zgmvn9UO9o/h0OooydUPwTQAttn1RwiA
         0cqPyfxJXWFkKgTLIKVz10frb97GMzGCMdNfcERX7jLFGqylVb9DPYKgW3yYrAjPIRI5
         I+6s0nlILk1MtL7T4PSaugjTOYyIkr/RJu2+MahtEJG1QI8588LpQw43eTCJmgkdmuwj
         OEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751776639; x=1752381439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Adkwaehj8WQlyxe1tcyATntmfd0OiZXAi1oQdyK2Hg=;
        b=ni2Ad0g6J6J8wIyk/SMvHy4LBXEU+mS98UXhLxdNIHhDY7qLTC416vqwdEy9Nk69ur
         6iGmQ3/ahLbCJBQ8H61dhAmwq4HxA+uWZuTG5iO4Y5wYuJ5HddVOOIKT/IOArd7aR7RT
         /NgRCH0WAqdmmCyHHLRiMCmtC7OwbZTybyNz10iLpwNWg90/mNbtXdDNEjnj1NCDal44
         btkbSc2xx+UfnfxCenNFN3mefwicqFG0S2DTA2ZZmOB2d99pmrZx8ULujC3GUyFjX/pu
         OdViE37RzJydae5N4sEzp7VwazJhH/d/UfeZ5F2dvIvbOKLYk/E3qicUvarfkBobm3H3
         bIkA==
X-Forwarded-Encrypted: i=1; AJvYcCWfpZdvOohxhLxQmHyM24a+PGgUdJp1tMJLbF7JDjJSUewMyh6CQhfZjxlSnMSrk8o1AP5Pe6VF3/ZMd8bHgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkNkr6b0qn/0W4BFiOGjpkT3XYCJs92nEewuLYul+Y3wv2QQe9
	3bJbLHE1INhuNle5hlY/Egie64HmbXTEpkQXwfLBuw96PSnS6+szlI6+
X-Gm-Gg: ASbGncutY28NEzu6dEam2/OeNKa9nARuDYpuwlLNZVlDvyR16oCve2Fz9AGySbqT9yV
	Jj8aPtPhs30quZPU0wcqI1B2PajMn+6HUlyTmYmL+Dg+OysM0cniRlW408iMI/UvcFC20i3zMlz
	0qjHcjJdQpSWKPVnJWpneDO1V9dR1wIoc64KkCwZW1iRHbqanUvR3FIgrDgBo0YQo1Xu6LbV6uZ
	HwUm91S5f8YyvQDl5u7VP5J4HnQh+32ziR3g4AAbMeBhhe1x8teM5YPdTsCBnNfi6K+9EKCghCr
	k4KpBBn87cPk5GWw9HlZO0TfALY3F3pM5YZ8nUj9TR91H0ewgZmPrTGRxVFfdj3jyw==
X-Google-Smtp-Source: AGHT+IFTD8Ubs6vrLh9uOBqgWb9R02OzYwWvb5+TvstZ1sZuMkvbVOBc0mozEtb+peNJ0afHcOnIqg==
X-Received: by 2002:a05:6a20:748a:b0:220:94b1:f1b8 with SMTP id adf61e73a8af0-225b4fe122emr14819222637.0.1751776638842;
        Sat, 05 Jul 2025 21:37:18 -0700 (PDT)
Received: from [127.0.0.1] ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cc2cesm6105137b3a.59.2025.07.05.21.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:37:18 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Date: Sun, 06 Jul 2025 12:36:31 +0800
Subject: [PATCH net-next v5 3/4] test/vsock: Add retry mechanism to ioctl
 wrapper
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250706-siocinq-v5-3-8d0b96a87465@antgroup.com>
References: <20250706-siocinq-v5-0-8d0b96a87465@antgroup.com>
In-Reply-To: <20250706-siocinq-v5-0-8d0b96a87465@antgroup.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xuewei Niu <niuxuewei.nxw@antgroup.com>, fupan.lfp@antgroup.com
X-Mailer: b4 0.14.2

Wrap the ioctl in `ioctl_int()`, which takes a pointer to the actual
int value and an expected int value. The function will not return until
either the ioctl returns the expected value or a timeout occurs, thus
avoiding immediate failure.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 tools/testing/vsock/util.c | 30 +++++++++++++++++++++---------
 tools/testing/vsock/util.h |  1 +
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 803f1e075b62228c25f9dffa1eff131b8072a06a..1e65c5abd85b8bcf5886272de15437d7be13eb89 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -17,6 +17,7 @@
 #include <unistd.h>
 #include <assert.h>
 #include <sys/epoll.h>
+#include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <linux/sockios.h>
 
@@ -101,28 +102,39 @@ void vsock_wait_remote_close(int fd)
 	close(epollfd);
 }
 
-/* Wait until transport reports no data left to be sent.
- * Return false if transport does not implement the unsent_bytes() callback.
+/* Wait until ioctl gives an expected int value.
+ * Return false if the op is not supported.
  */
-bool vsock_wait_sent(int fd)
+bool vsock_ioctl_int(int fd, unsigned long op, int expected)
 {
-	int ret, sock_bytes_unsent;
+	int actual, ret;
+	char name[32];
+
+	snprintf(name, sizeof(name), "ioctl(%lu)", op);
 
 	timeout_begin(TIMEOUT);
 	do {
-		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
+		ret = ioctl(fd, op, &actual);
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
+	} while (actual != expected);
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
+	return vsock_ioctl_int(fd, SIOCOUTQ, 0);
 }
 
 /* Create socket <type>, bind to <cid, port>.
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index fdd4649fe2d49f57c93c4aa5dfbb37b710c65918..142c02a6834acb7117aca485b661332b73754b63 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -87,6 +87,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
 int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
 			   struct sockaddr_vm *clientaddrp);
 void vsock_wait_remote_close(int fd);
+bool vsock_ioctl_int(int fd, unsigned long op, int expected);
 bool vsock_wait_sent(int fd);
 void send_buf(int fd, const void *buf, size_t len, int flags,
 	      ssize_t expected_ret);

-- 
2.34.1

