Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B266299A8A
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751529227; cv=none; b=Y4LPmjBYTNylg/iEBv8INF7g9RbkFfBvmZ4vrDJ+nEKPYI3/0WIbUi/ci6kWIOhWzhapXSBoRIjVGNJ3EOd9xhNv1neW9go/csw2eB5KVEU1GpzhBWMRvB2dBT4iXdqDnWcJ4S7QkAk8tf7HPPzcbQWnyIcg+dXrL2951TUDCIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751529227; c=relaxed/simple;
	bh=EAO/alnjYPf1u5+DtQLR/0pbf21VfVmpJZWS6+1VGvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=knaBHDuAbduU4efoUZFWGKTQ65IciP+xyPYvsO9OD60XBPqHwhgmOc/QVla6KfIwGPcbBhnhl1RQnhK26pC7lG+LZ5q1dytb8aoxD4UVV03GCNV5sTyDzOWE37iZphRXL2f8cnGwrZ48urTZC1ZHJ7A0DXnfM2ZF9Y89ZOXhF2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+0/MOgf; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+0/MOgf"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b31d489a76dso4786836a12.1
        for <virtualization@lists.linux.dev>; Thu, 03 Jul 2025 00:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751529225; x=1752134025; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5Z3Ibg5dI0YI2U0Q0aEUI660v44K9U+DyvKSIB5G4w=;
        b=X+0/MOgfvUZ4Aw2m70AOLfeH/ZjhFzruu2YOJgE/oO1cHTgAmutrHai2Lw4uGCLpO/
         7EKGA2LnWtwTd4r1FNi0pBnSSwM/DUQfLrHZJ+sNxPst8yb0bfcAOlVnEWZ61RoT+FnD
         0SpSzHD+U5+U6CqXTYA67b4zCFAcEFoY0fPh5fyYIrZNnpAgFJgA9EBqJbj1I5WfXXwS
         yf90sCYNZcRCgGYOhc/uV8pQObWN3Lb/QptebyZ9CAnDUKU/7MnsEDnOQkAJtEj7Uun4
         a67pu+ySxFxKGlJ74z15dL/dgqtdc40CxocgOGGmm6kx34pdJBk1VyjQ+Rw7nTKn/vFa
         +WRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751529225; x=1752134025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5Z3Ibg5dI0YI2U0Q0aEUI660v44K9U+DyvKSIB5G4w=;
        b=qm2OG8oLPLH7zDGVoHIbBgmd1X2V5OaxQbixR4oXOObzVCYxtugHBV/GtdrcGB9MaA
         ai+DouMdLWSca+wtNjRFSJ4pcHUnVPsJr0VYvu46n7nfDR+XzgybaIQAIcnkljsD9gE5
         7kuTu51ega5KYEZaZxIqk/tNdfA5+zyRuRIF3tDA/0YwklMEauehp1h+tD+MiWsHU/hx
         uJ6gAqpI8AbDCW7znNPLinbTS0Iak09HZp8nyIsHv2tRdPIdu6izhstWYtK8J6W7O5wh
         /PCWKlfeY1DWrwH5dn/5ejzgAX+XEnUqparpEtFThnni7QueRpqe9fqwAUBw8pKGFl2+
         LzTA==
X-Forwarded-Encrypted: i=1; AJvYcCWphBVsHySapvxAdZXCt3bNxQlABhj61vlgelRQJLdB7b4cMoi2Axpu2FdUICnm6+vI1Su0VUZSzVs8kKl/SQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBIXgFpK6dba4pOfjAiGGTAQmgXS+GIB+KBjwnBaMtfyyC5Lyf
	NDgAVz43e0I/MCK1tEwwdSxec1xueJwBA2WcB7fAeMm/E79uU6Wk9WEz
X-Gm-Gg: ASbGncuodstmN9G3QC6l4s4ti9vhzFdmUGfMGrtaJ7UOBBoK7CzrGo4w4XEEVPHRPFd
	YUJ9qWclTjmVl258u/pt1Bf3f0LkcTWYrde2vHqEv0PJu+Ap6cIBWSTtqPCQvb2Boe3a1qjTp5L
	fpT6iAgLdJrNZdiql4tr/Hc45+2OW+6+KYIx9oF0OSVCyKUP9b5yrc224mC2WvC9m7jLKtt3vEn
	jd4lQOqIsf4IJultxdIDThfFCuOJjXe9mCl8mkU2aFi8GVZ9MDO2EMTmr9/p4lnBFgPCWmZDVrR
	qT4WjYNbhhpj4JM+Z/DvvIau9PL1duZk6/ycV1nu0Hef3CgVokbsBSN2umDoKLZxnexmx5x/OOc
	pqzZAbU3WAbra6Yp8DBE=
X-Google-Smtp-Source: AGHT+IG5wCaASyniAIni8ifVqNeDb2b7kJdZU/BUNxpaGI75twsZCp3n4qDX+fcy/2jRkP4DZDxYgw==
X-Received: by 2002:a17:90b:4c84:b0:312:1ae9:153a with SMTP id 98e67ed59e1d1-31a90bef1a8mr8956064a91.25.1751529224280;
        Thu, 03 Jul 2025 00:53:44 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc5a266sm1788596a91.12.2025.07.03.00.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 00:53:43 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com
Cc: davem@davemloft.net,
	decui@microsoft.com,
	fupan.lfp@antgroup.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	leonardi@redhat.com,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	niuxuewei.nxw@antgroup.com,
	niuxuewei97@gmail.com,
	pabeni@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RESEND PATCH net-next v4 3/4] test/vsock: Add retry mechanism to ioctl wrapper
Date: Thu,  3 Jul 2025 15:53:28 +0800
Message-Id: <20250703075328.1004942-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ceulzs7srd77t57ozaauveim4dlp6stqmbvvjh5dketapmjzhv@nu6gruoyidze>
References: <ceulzs7srd77t57ozaauveim4dlp6stqmbvvjh5dketapmjzhv@nu6gruoyidze>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Thu, Jul 03, 2025 at 11:05:14AM +0800, Xuewei Niu wrote:
> >Resend: the previous message was rejected due to HTML
> >Resend: forgot to reply all...
> >
> >> On Mon, Jun 30, 2025 at 03:57:26PM +0800, Xuewei Niu wrote:
> >> >Wrap the ioctl in `ioctl_int()`, which takes a pointer to the actual
> >> >int value and an expected int value. The function will not return until
> >> >either the ioctl returns the expected value or a timeout occurs, thus
> >> >avoiding immediate failure.
> >> >
> >> >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
> >> >---
> >> > tools/testing/vsock/util.c | 32 +++++++++++++++++++++++---------
> >> > tools/testing/vsock/util.h |  1 +
> >> > 2 files changed, 24 insertions(+), 9 deletions(-)
> >> >
> >> >diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
> >> >index 0c7e9cbcbc85..481c395227e4 100644
> >> >--- a/tools/testing/vsock/util.c
> >> >+++ b/tools/testing/vsock/util.c
> >> >@@ -16,6 +16,7 @@
> >> > #include <unistd.h>
> >> > #include <assert.h>
> >> > #include <sys/epoll.h>
> >> >+#include <sys/ioctl.h>
> >> > #include <sys/mman.h>
> >> > #include <linux/sockios.h>
> >> >
> >> >@@ -97,28 +98,41 @@ void vsock_wait_remote_close(int fd)
> >> > 	close(epollfd);
> >> > }
> >> >
> >> >-/* Wait until transport reports no data left to be sent.
> >> >- * Return false if transport does not implement the unsent_bytes()
> >> >callback.
> >> >+/* Wait until ioctl gives an expected int value.
> >> >+ * Return false if the op is not supported.
> >> >  */
> >> >-bool vsock_wait_sent(int fd)
> >> >+bool vsock_ioctl_int(int fd, unsigned long op, int *actual, int expected)
> >>
> >> Why we need the `actual` parameter?
> >
> >We can exit early `if (*actual == expected)`, and the `expected` can be any integer.
> >I also make it to be a pointer, because the caller might need to have the actual value.
> 
> IIUC this function return true if `*actual == expected` or false if 
> there was an error, so I don't see the point of aving `actual`, since it 
> can only be equal to `expected` if it returns true, or invalid if it 
> returs false.

Nice catch! I'll remove it in v5.

Thanks,
Xuewei

> Thanks,
> Stefano
> 
> >
> >Thanks,
> >Xuewei
> >
> >> > {
> >> >-	int ret, sock_bytes_unsent;
> >> >+	int ret;
> >> >+	char name[32];
> >> >+
> >> >+	snprintf(name, sizeof(name), "ioctl(%lu)", op);
> >> >
> >> > 	timeout_begin(TIMEOUT);
> >> > 	do {
> >> >-		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
> >> >+		ret = ioctl(fd, op, actual);
> >> > 		if (ret < 0) {
> >> > 			if (errno == EOPNOTSUPP)
> >> > 				break;
> >> >
> >> >-			perror("ioctl(SIOCOUTQ)");
> >> >+			perror(name);
> >> > 			exit(EXIT_FAILURE);
> >> > 		}
> >> >-		timeout_check("SIOCOUTQ");
> >> >-	} while (sock_bytes_unsent != 0);
> >> >+		timeout_check(name);
> >> >+	} while (*actual != expected);
> >> > 	timeout_end();
> >> >
> >> >-	return !ret;
> >> >+	return ret >= 0;
> >> >+}
> >> >+
> >> >+/* Wait until transport reports no data left to be sent.
> >> >+ * Return false if transport does not implement the unsent_bytes() callback.
> >> >+ */
> >> >+bool vsock_wait_sent(int fd)
> >> >+{
> >> >+	int sock_bytes_unsent;
> >> >+
> >> >+	return vsock_ioctl_int(fd, SIOCOUTQ, &sock_bytes_unsent, 0);
> >> > }
> >> >
> >> > /* Create socket <type>, bind to <cid, port> and return the file descriptor. */
> >> >diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
> >> >index 5e2db67072d5..d59581f68d61 100644
> >> >--- a/tools/testing/vsock/util.h
> >> >+++ b/tools/testing/vsock/util.h
> >> >@@ -54,6 +54,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
> >> > int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> >> > 			   struct sockaddr_vm *clientaddrp);
> >> > void vsock_wait_remote_close(int fd);
> >> >+bool vsock_ioctl_int(int fd, unsigned long op, int *actual, int expected);
> >> > bool vsock_wait_sent(int fd);
> >> > void send_buf(int fd, const void *buf, size_t len, int flags,
> >> > 	      ssize_t expected_ret);
> >> >--
> >> >2.34.1
> >> >
> >
