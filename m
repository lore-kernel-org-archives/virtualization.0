Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B87E20E005
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 03:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751512005; cv=none; b=VUZEpsDsZpyIjssvibjn6UaSzKOReVv9u0uoOO1ITZFeHzK4ts06P3IMyUyBPuw5zJBXvb2PLbiLNr4e0fgX9XOxlh+/TF76ct7zqG/7CXUgOCHV7ouYp/d2uCmZch+mF8dODUhNxGHwB63qEXrQ3QU8d2J6kywZ1N4mmE5xd4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751512005; c=relaxed/simple;
	bh=g0goUqpz0H5nqzeA/3fuXMeQmy/4V6hWpW6/CbP1VvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l5TFl84bpBDACE9sqF1cQ1Wl2i28AEFzKb+Gunskc/SxFXtvSGyIPJQapND/CSyzVifl0Fl1kg8H+2VNYzafeAAXybcHOuXuv2dBMCtpwVH08o5dJmXJUkuPGDyJw3CBDCypn7+2zf3UkssiPCoDPR7lK/zllqCrwHli4DEjjEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKq2F6RF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKq2F6RF"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so435573b3a.1
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 20:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751512003; x=1752116803; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUDKiPyVRQeazWkY4m2jYwgTMEJufvXw/+pCwXThNj0=;
        b=VKq2F6RFrvc5qpzLbCZWBlRuZFkosSVdnyuQ+iSl3voOd63vJbl6pyPumLjE5oTN6W
         7Z2P/1rXpkGGBzLoNH94YdJ1fk2EDeBTVUjeoU0+W5On9Wb6wBfYxcoq/1JFuC6mPk/g
         dgcD6cz4EEU+2TJOgdZcDhDoQp2LACiOuaPqCxFk06Fr7fyCGm6rgdAi+u84im/KXDBE
         MkgusENbuLRj8NUVK6x5KAiiVixd7w4yVOvD9kpf27e43/BnI2pjS6Si6aFDvPhRDR3Z
         OdwfShcuhoSBero7XX4nSxN3rnGz8fKGghg8UT8avftZACX8hI3B16S56geI0EY43Pgd
         dI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751512003; x=1752116803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUDKiPyVRQeazWkY4m2jYwgTMEJufvXw/+pCwXThNj0=;
        b=OcFhib8LZBUThdjaKIm7gEmV79QU8I6G5qyFUNGhBZxrdJdHQTrMcjz0ycKGn/fs73
         9tRmObo5ls5w7cCHahi9psjM3qK86fAQmKZXRbKVW6CUfdXZUwTbYn6SdlcFKpSB8rLC
         r6RezkQeA0kTdvEAvxxv17Gp6yng7Z4swZZ5TT6V9mATpN+dhqW9rwCWQAc2QnOFWZEo
         BqYFc62mSgerhSI5AEsdFooPzD5eThE5z8LmQ87vjhYrZX7SMhgu3dMAcF3Qp9OuZ0X9
         yR9b0xglj458Z2z1UaZmWp6uBgyW0t0tSbx6AHhhZiXuM9tv+RAtC/QMkAuBBnrTEHu3
         oonw==
X-Forwarded-Encrypted: i=1; AJvYcCXT9sJ0qX+0HFudq7s1mEJ655oCXiE0u6GXKxb9snwDVnQmN3u3I66UZzmycI083Ve4fVEJYNO2ys3JPsV96A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZYIfR2RzzQAT5eppQC7b6p02hLJT9/C+QKlKqaAqTp8rErh7/
	Wtx+IgPgQZlw/ihiqffmlPGIkd2Mz3NRKsbpztROVzxX2fEN8h9pZlCu
X-Gm-Gg: ASbGnctg4ttOKDJ+IxTzrdvhB7paYx3GsCAqJPIeDtZMQQNoNrJtZ6eP65aZNKwUMnf
	ksrnj9TlpGo0Bx4jHjFP6jQZh6P7EdZPtSXq6LCPIUdOveAAr8VX491eOuwMmRuG1NNIT8i62Vz
	0KrEUYkGfk4Wcm9RsM/grXaCGimJYDQuOPf5l64sEJwf51GirNdXGNUsd3ce3X091UNKF2gumxY
	A6ICMOP8PMUM9juMIcJuB9qsiURxY2hsLXmipGkDxHNHE4QhwVRwu8zM+mWS0DjnCldxQRzwOFn
	Js3PNiexOOrYfmZLyntaYAiXjEjVugjtzoISQFpH0xEH/h5DUpCe5/jO2a4cVY6csOuwrTQrbqy
	6HYgTA17L
X-Google-Smtp-Source: AGHT+IFz7kt0Nb7vZz+tzUh5I+gOTwteT4lcjZk9zNPo6PfyuL6H+Px1Zb73lqI3Wo071I67AWpnGQ==
X-Received: by 2002:a05:6a00:2d94:b0:736:9f2e:1357 with SMTP id d2e1a72fcca58-74cd5b575bdmr707117b3a.12.1751512002612;
        Wed, 02 Jul 2025 20:06:42 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af541d9a5sm16108617b3a.62.2025.07.02.20.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 20:06:42 -0700 (PDT)
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
Date: Thu,  3 Jul 2025 11:05:14 +0800
Message-Id: <20250703030514.845623-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2cpqw23kr4qiatpzcty6wve4qdyut5su7g7fr4kg52dx33ikdu@ljicf6mktu5z>
References: <2cpqw23kr4qiatpzcty6wve4qdyut5su7g7fr4kg52dx33ikdu@ljicf6mktu5z>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resend: the previous message was rejected due to HTML
Resend: forgot to reply all...

> On Mon, Jun 30, 2025 at 03:57:26PM +0800, Xuewei Niu wrote:
> >Wrap the ioctl in `ioctl_int()`, which takes a pointer to the actual
> >int value and an expected int value. The function will not return until
> >either the ioctl returns the expected value or a timeout occurs, thus
> >avoiding immediate failure.
> >
> >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
> >---
> > tools/testing/vsock/util.c | 32 +++++++++++++++++++++++---------
> > tools/testing/vsock/util.h |  1 +
> > 2 files changed, 24 insertions(+), 9 deletions(-)
> >
> >diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
> >index 0c7e9cbcbc85..481c395227e4 100644
> >--- a/tools/testing/vsock/util.c
> >+++ b/tools/testing/vsock/util.c
> >@@ -16,6 +16,7 @@
> > #include <unistd.h>
> > #include <assert.h>
> > #include <sys/epoll.h>
> >+#include <sys/ioctl.h>
> > #include <sys/mman.h>
> > #include <linux/sockios.h>
> >
> >@@ -97,28 +98,41 @@ void vsock_wait_remote_close(int fd)
> > 	close(epollfd);
> > }
> >
> >-/* Wait until transport reports no data left to be sent.
> >- * Return false if transport does not implement the unsent_bytes() 
> >callback.
> >+/* Wait until ioctl gives an expected int value.
> >+ * Return false if the op is not supported.
> >  */
> >-bool vsock_wait_sent(int fd)
> >+bool vsock_ioctl_int(int fd, unsigned long op, int *actual, int expected)
> 
> Why we need the `actual` parameter?

We can exit early `if (*actual == expected)`, and the `expected` can be any integer.
I also make it to be a pointer, because the caller might need to have the actual value.

Thanks,
Xuewei
 
> > {
> >-	int ret, sock_bytes_unsent;
> >+	int ret;
> >+	char name[32];
> >+
> >+	snprintf(name, sizeof(name), "ioctl(%lu)", op);
> >
> > 	timeout_begin(TIMEOUT);
> > 	do {
> >-		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
> >+		ret = ioctl(fd, op, actual);
> > 		if (ret < 0) {
> > 			if (errno == EOPNOTSUPP)
> > 				break;
> >
> >-			perror("ioctl(SIOCOUTQ)");
> >+			perror(name);
> > 			exit(EXIT_FAILURE);
> > 		}
> >-		timeout_check("SIOCOUTQ");
> >-	} while (sock_bytes_unsent != 0);
> >+		timeout_check(name);
> >+	} while (*actual != expected);
> > 	timeout_end();
> >
> >-	return !ret;
> >+	return ret >= 0;
> >+}
> >+
> >+/* Wait until transport reports no data left to be sent.
> >+ * Return false if transport does not implement the unsent_bytes() callback.
> >+ */
> >+bool vsock_wait_sent(int fd)
> >+{
> >+	int sock_bytes_unsent;
> >+
> >+	return vsock_ioctl_int(fd, SIOCOUTQ, &sock_bytes_unsent, 0);
> > }
> >
> > /* Create socket <type>, bind to <cid, port> and return the file descriptor. */
> >diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
> >index 5e2db67072d5..d59581f68d61 100644
> >--- a/tools/testing/vsock/util.h
> >+++ b/tools/testing/vsock/util.h
> >@@ -54,6 +54,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
> > int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> > 			   struct sockaddr_vm *clientaddrp);
> > void vsock_wait_remote_close(int fd);
> >+bool vsock_ioctl_int(int fd, unsigned long op, int *actual, int expected);
> > bool vsock_wait_sent(int fd);
> > void send_buf(int fd, const void *buf, size_t len, int flags,
> > 	      ssize_t expected_ret);
> >-- 
> >2.34.1
> >
