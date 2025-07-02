Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC9819CC11
	for <virtualization@lists.linux.dev>; Wed,  2 Jul 2025 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451666; cv=none; b=QOgkHbl3lFsmCJuVqfEEleuSO+prHLd1qoFf9lc5yUac3phR4o1YP2qHqcIsT3Snz/8llcuGx2MP2tRIo4TF4mIPgQI7M6YI6YBTdV76EXyxQJ8f9wphYRZw6Yu/Zs5KFX7hKSf3tTwfaJv650f8akJ1R76ea2lQ+KUy9nR1Y3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451666; c=relaxed/simple;
	bh=QTZub8qteyJ2SpbKYksOY3pPnrsQfuP9btWZHNiTahM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DORl6j9+8RL1od52GlpGoZEDGIEaG6hS+sAC8JhFvZaPyhJzvUCeiP5kc5sXntWbo1V93pE5s69WyKzPqc50osfqq3moJBveBBYCj2xBISCXuwGIEPk5F5tVzKxaErkKAaW1kXSkCb3E5ovFKTSBKrCQAlieybi2gRuyOVhK+D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWFkujCN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWFkujCN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751451662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z33Cff3RmOVjIT9wRyC2s6MYaglNGGjjzC0Meo8MshM=;
	b=MWFkujCN3ZmGmyUSFFCnPPdHCNc5aLJ7ai0J+mXRzVgRs3MXjghw1QboKeC3OYQ2AgK5qh
	zz1dH4S74aPt94MES8gs6vOVi9J9vBZw1qEXHFe9OaaE3FowMIL6ulzzF0JeXCo2B5Vw2U
	Z2F/y5GtsFO6obWQPGbkA9Dq0lwD504=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-m3ig7DQQMRuDpqcNMiK8bQ-1; Wed, 02 Jul 2025 06:21:01 -0400
X-MC-Unique: m3ig7DQQMRuDpqcNMiK8bQ-1
X-Mimecast-MFC-AGG-ID: m3ig7DQQMRuDpqcNMiK8bQ_1751451661
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-2da802bd11eso2872157fac.0
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 03:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751451661; x=1752056461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z33Cff3RmOVjIT9wRyC2s6MYaglNGGjjzC0Meo8MshM=;
        b=lADaDp3xe1WpZ93F9p//DKKrnKUHHmItN0Ze6uDAE86mGNx1Jf76TSzYSoEt6twh6e
         TfkiGwQRtRgV2rTMxLjKZTW5N01R/VVnNkGm3MyVQSUXlr715NewHRc4M6+zEifh9/Do
         y74qyc9n51E+xkyXB9eLxdqw3cSNuZj1sKD50RpskOUQFZSBxPvxROD6wJHm8UDRBdzg
         Df8/6Wino25LlQwtjSSk6Z9wB508eyknmX4xiwJQOkXTC6wG6rSoON+kk56rkR0PCmym
         KSKXSn8MGrly/EQKtH9VKDUmr8s3wma3kBaNx0YJM88oFyrMQFN+mBxfNXB1hVHW/8KQ
         jjXw==
X-Forwarded-Encrypted: i=1; AJvYcCXvgD2heVgGYgUvKJXjsNZ6u7Hu+r5RUeKHXkXI1MbYWErLLDKWGROfcBvy5oLggejmMG1bu4wgLio2VupSYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YybQC9lcJHDFpmcDifBHfue7+o2IgpOvK8iPN8mVXPusJ5XF/g7
	bWUysSxqpoPlAQi+Lr7QFKrdCcsEveCRhCgxOIUmPDO6NIQzbaKblBSoSun6WsxbdlzYxSFQaOe
	CG0f75zYHIvaQye+LLmCNBsQneGUchkWF39pbzu+CONpdSRsgdIjZtaXwElJLT9x5RJ8M
X-Gm-Gg: ASbGncvp96L4F2somYgcVe1i5Wtxra/vuPDCePaQ6kKhlW/pKAhCZ8JVsPaemeKhABz
	7zHvE4nfc2ZDZAfzLFfz9LpD2oewj2yP87LfpcWrLUGUkcKqjkjTEXxoJPy/ocwhpOvaAFed9bJ
	yWLdjz5DnbaG1CAjMwM15fBFCOgfLrf43jsPrCQAfyGwYjVya9r6CzCq+2oeoqSBnbHTriDkxH8
	qQdZnQi0ljvNWPdtZT6RqtFo1EuqPrrH5D7wlha0sk2dxRojVkiqWU88lDBes3TxzRSsT0aBU7z
	OHpNXbz26QzKZgUWsSem7yHYNqcM
X-Received: by 2002:a05:6871:2101:b0:2d9:8578:9478 with SMTP id 586e51a60fabf-2f5a89a2456mr1620090fac.4.1751451660851;
        Wed, 02 Jul 2025 03:21:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjnqBPdraA9wKo6pHyy4bnNYvJ2ThZk+lGjpFEgWafOmcLKgFaCiU2WyDUSEWN1BVbih6pWA==
X-Received: by 2002:a05:6871:2101:b0:2d9:8578:9478 with SMTP id 586e51a60fabf-2f5a89a2456mr1620073fac.4.1751451660486;
        Wed, 02 Jul 2025 03:21:00 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.164.126])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd4efb7cfsm3767218fac.16.2025.07.02.03.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:20:59 -0700 (PDT)
Date: Wed, 2 Jul 2025 12:20:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: mst@redhat.com, pabeni@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, netdev@vger.kernel.org, stefanha@redhat.com, 
	leonardi@redhat.com, decui@microsoft.com, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, fupan.lfp@antgroup.com, 
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [RESEND PATCH net-next v4 3/4] test/vsock: Add retry mechanism
 to ioctl wrapper
Message-ID: <2cpqw23kr4qiatpzcty6wve4qdyut5su7g7fr4kg52dx33ikdu@ljicf6mktu5z>
References: <20250630075727.210462-1-niuxuewei.nxw@antgroup.com>
 <20250630075727.210462-4-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250630075727.210462-4-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T7WRqcBnW3LfTLz-hbuJ6kLjXvcvQXaoNch8eHEJuSQ_1751451661
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jun 30, 2025 at 03:57:26PM +0800, Xuewei Niu wrote:
>Wrap the ioctl in `ioctl_int()`, which takes a pointer to the actual
>int value and an expected int value. The function will not return until
>either the ioctl returns the expected value or a timeout occurs, thus
>avoiding immediate failure.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> tools/testing/vsock/util.c | 32 +++++++++++++++++++++++---------
> tools/testing/vsock/util.h |  1 +
> 2 files changed, 24 insertions(+), 9 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 0c7e9cbcbc85..481c395227e4 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -16,6 +16,7 @@
> #include <unistd.h>
> #include <assert.h>
> #include <sys/epoll.h>
>+#include <sys/ioctl.h>
> #include <sys/mman.h>
> #include <linux/sockios.h>
>
>@@ -97,28 +98,41 @@ void vsock_wait_remote_close(int fd)
> 	close(epollfd);
> }
>
>-/* Wait until transport reports no data left to be sent.
>- * Return false if transport does not implement the unsent_bytes() 
>callback.
>+/* Wait until ioctl gives an expected int value.
>+ * Return false if the op is not supported.
>  */
>-bool vsock_wait_sent(int fd)
>+bool vsock_ioctl_int(int fd, unsigned long op, int *actual, int expected)

Why we need the `actual` parameter?

> {
>-	int ret, sock_bytes_unsent;
>+	int ret;
>+	char name[32];
>+
>+	snprintf(name, sizeof(name), "ioctl(%lu)", op);
>
> 	timeout_begin(TIMEOUT);
> 	do {
>-		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>+		ret = ioctl(fd, op, actual);
> 		if (ret < 0) {
> 			if (errno == EOPNOTSUPP)
> 				break;
>
>-			perror("ioctl(SIOCOUTQ)");
>+			perror(name);
> 			exit(EXIT_FAILURE);
> 		}
>-		timeout_check("SIOCOUTQ");
>-	} while (sock_bytes_unsent != 0);
>+		timeout_check(name);
>+	} while (*actual != expected);
> 	timeout_end();
>
>-	return !ret;
>+	return ret >= 0;
>+}
>+
>+/* Wait until transport reports no data left to be sent.
>+ * Return false if transport does not implement the unsent_bytes() callback.
>+ */
>+bool vsock_wait_sent(int fd)
>+{
>+	int sock_bytes_unsent;
>+
>+	return vsock_ioctl_int(fd, SIOCOUTQ, &sock_bytes_unsent, 0);
> }
>
> /* Create socket <type>, bind to <cid, port> and return the file descriptor. */
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index 5e2db67072d5..d59581f68d61 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -54,6 +54,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
> int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> 			   struct sockaddr_vm *clientaddrp);
> void vsock_wait_remote_close(int fd);
>+bool vsock_ioctl_int(int fd, unsigned long op, int *actual, int expected);
> bool vsock_wait_sent(int fd);
> void send_buf(int fd, const void *buf, size_t len, int flags,
> 	      ssize_t expected_ret);
>-- 
>2.34.1
>

