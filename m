Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DE92D8397
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972093; cv=none; b=ULoGDy7IcCl/opBRgE6RfJzzEMyHMYYUCoBB/WzcwJgUbRCvgkPOpoTijTcrM9h45/M5aa5SkyRIQT4AcGQ63kVnOOaawOud1w007T4chP9uUnHwvSt9JQ3idEnYZtpbYMNwWOQNu7bmM2o58FZFr/XIRft0EURp6Kl1LiBpMZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972093; c=relaxed/simple;
	bh=pt6duYiMCIehtx4IxrjJmNZ1YzZaoG3aJy7HoAatvQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QaMPnw9i+5NEmZqI2A38UcKe+qX/OIado3fTLoW7eOiBSqh/c5R9f8Ar5XPx3tXxz2/Cj6kb8HsCSyCgBfuZJSGfWzWsuzBL2CrdKIVEqe4FNyYGszULL6lnDxSU/uMk9tbV7Wb49VA3UIvV8kohoVXO8377UT0gHqaLp16YfKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1zttYPN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1zttYPN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751972091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6zVRF5eqOqy+l/yn1UXOkezwlr4g/SUUPIur6RAL+Y0=;
	b=d1zttYPNK7ZaacfyXHtfcHHEGk/IuEzmyv4SX9ytwDmEqN03eOXKaOZ5ERM+ogSted3we+
	SY8za+3pGomfaF9/Dl9TV1o8wQ/uFh7Suf0ilPkbmqwpjbS+ZSNU8UEgNBdpjZ5FUPXon4
	nf+XlIcOvIYAP4GJWwDWwK/s8KKa4lo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-jnTkqohtN_yT8-N7T-JROA-1; Tue, 08 Jul 2025 06:54:47 -0400
X-MC-Unique: jnTkqohtN_yT8-N7T-JROA-1
X-Mimecast-MFC-AGG-ID: jnTkqohtN_yT8-N7T-JROA_1751972087
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d38fe2eff2so590132785a.2
        for <virtualization@lists.linux.dev>; Tue, 08 Jul 2025 03:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751972087; x=1752576887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zVRF5eqOqy+l/yn1UXOkezwlr4g/SUUPIur6RAL+Y0=;
        b=Lnmn6pjCFMNhtw6tmjYgFVN+wlYR9YJTjY95KXMNBExiBKc/f1cd0LumGAYDZ+cFQ+
         rm0gUkXKVKVNetFEa8dqkaRi1/wvSmsvVmBzmo1B4sWjnMsbz73FAmdLMUqMd6eIr/NX
         9JmcF/DgTPGZ74yEE2A+oE7Dt/6uExJJpAYdNxYbH5V6/oRIeKIMOcTllKZtWxhGtalL
         dMpvIhFHymnara/8rRxoSy6mWPXy0m/hc11OV39ik+esFBbbIMPenF11H8YhUcotwNLd
         0c/zTWQNSubpjmJPZG/NnFE3nJGVIS3HLpNR0I8Ae3Nce45gZw4xGs9G39FDP2YVXnWD
         S2bw==
X-Forwarded-Encrypted: i=1; AJvYcCU0JttH2ptI+ZEbSjbwaVQu8weNDXxxEMjZkSAnFHSe5/bGHkJKTOn8yPBihwg3sGnhoT8bQtp685LPZvjyEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZwIhUes1ZJpFnq1VtwnG1uUpwcnhkG7BHgCb8EiS6vAUQN/tR
	98+BBKolzRAzdHgGNiDQMLVrPT18SfWvOCE3hNpW2dLCJE+h0b5cxS3Fo0EgaAP/EmctwIjBtz9
	WSTDXFhCuiZnM6wH8w/jyCa8mRcr39I/W5fXPuVY2znuQHDdkL4jxEO4b29Q6F+g+UV79
X-Gm-Gg: ASbGncsrVX/AZH7pn4dRi2neUi7cNW0oz+FEN+btZFXN6T7Jb40nCR1OoaIV9eCad4+
	lJyDz+YjI5OsP3Ry0ZZMC07X5GNKA3lTpDU2wTvW8ciCBTx4vyUtgk4fEwB6tZVHNohE49FNcMQ
	UDjmzQsRaXnNIsq+VPllDboNAfiKFKgvKLoGyjm36Q4c0dLgI8xzrp+ljxnQIXAhbdxBZY6pkd/
	K0HhEUHhs2ghMnMGXOWN9mbWTMy5OwwC0ddSJWQeLjLH48CBIPhOb5eieyHiYmaq1ReHKMUgLPF
	cxE3XJoc4E4Iw5W7VyqvsYofgSAL
X-Received: by 2002:a05:620a:4089:b0:7d3:8f51:a5a5 with SMTP id af79cd13be357-7da04137a83mr344297285a.51.1751972087265;
        Tue, 08 Jul 2025 03:54:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGODJ+k5iQwpBD8zrN9hRkPcNeibB7riAG/EN8ncnQ9dHTW0DTOP7oRQy4VBda/jQ7Oc5xqfg==
X-Received: by 2002:a05:620a:4089:b0:7d3:8f51:a5a5 with SMTP id af79cd13be357-7da04137a83mr344292285a.51.1751972086595;
        Tue, 08 Jul 2025 03:54:46 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.147.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe8f861sm757715685a.86.2025.07.08.03.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 03:54:46 -0700 (PDT)
Date: Tue, 8 Jul 2025 12:54:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, niuxuewei97@gmail.com
Subject: Re: [PATCH net-next v6 3/4] test/vsock: Add retry mechanism to ioctl
 wrapper
Message-ID: <xvteph5sh4wkvfaa754xxakufgwkjzjawzfttnfqcvmei2zcpf@ig6fawckff2h>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
 <20250708-siocinq-v6-3-3775f9a9e359@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250708-siocinq-v6-3-3775f9a9e359@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AT-szjK4XZBcOJLHMfGied3_GgBedxTD5MgSbLi3rXg_1751972087
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 08, 2025 at 02:36:13PM +0800, Xuewei Niu wrote:
>Wrap the ioctl in `ioctl_int()`, which takes a pointer to the actual
>int value and an expected int value. The function will not return until
>either the ioctl returns the expected value or a timeout occurs, thus
>avoiding immediate failure.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> tools/testing/vsock/util.c | 30 +++++++++++++++++++++---------
> tools/testing/vsock/util.h |  1 +
> 2 files changed, 22 insertions(+), 9 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 803f1e075b62228c25f9dffa1eff131b8072a06a..1e65c5abd85b8bcf5886272de15437d7be13eb89 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -17,6 +17,7 @@
> #include <unistd.h>
> #include <assert.h>
> #include <sys/epoll.h>
>+#include <sys/ioctl.h>
> #include <sys/mman.h>
> #include <linux/sockios.h>
>
>@@ -101,28 +102,39 @@ void vsock_wait_remote_close(int fd)
> 	close(epollfd);
> }
>
>-/* Wait until transport reports no data left to be sent.
>- * Return false if transport does not implement the unsent_bytes() callback.
>+/* Wait until ioctl gives an expected int value.
>+ * Return false if the op is not supported.
>  */
>-bool vsock_wait_sent(int fd)
>+bool vsock_ioctl_int(int fd, unsigned long op, int expected)
> {
>-	int ret, sock_bytes_unsent;
>+	int actual, ret;
>+	char name[32];
>+
>+	snprintf(name, sizeof(name), "ioctl(%lu)", op);
>
> 	timeout_begin(TIMEOUT);
> 	do {
>-		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>+		ret = ioctl(fd, op, &actual);
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
>+	} while (actual != expected);
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
>+	return vsock_ioctl_int(fd, SIOCOUTQ, 0);
> }
>
> /* Create socket <type>, bind to <cid, port>.
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index fdd4649fe2d49f57c93c4aa5dfbb37b710c65918..142c02a6834acb7117aca485b661332b73754b63 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -87,6 +87,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
> int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> 			   struct sockaddr_vm *clientaddrp);
> void vsock_wait_remote_close(int fd);
>+bool vsock_ioctl_int(int fd, unsigned long op, int expected);
> bool vsock_wait_sent(int fd);
> void send_buf(int fd, const void *buf, size_t len, int flags,
> 	      ssize_t expected_ret);
>
>-- 
>2.34.1
>

