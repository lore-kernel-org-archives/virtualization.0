Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4668C2E889D
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750173070; cv=none; b=alalXj3cp0AVrcUpGJMic5BlTK6O18BZQqw/9uIyn4goCylsoGfT3zc1FBcnQEKu1EGDKmYg9S0hrvzelFlnTGNbJO3Un9lvtbZX3r168IIKeNtimulh6iAcilzhX9sHWzuyhMpw0H/lrZH+uGsoLVRxwVyQZEtwqerYgFMHWOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750173070; c=relaxed/simple;
	bh=pdPq9PlVlHWZ2cVzJk1emG6nTw+vRlKhWuL8ddlKXW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ovLqqcrviWSs+BmzVchHI4k1fd8WDwQy6gvveQgUN8vnryqL5B8bP1LFDj07P8UjE+quKm8yMIURKgseNGxSxc74+WluszXHmvTTjlg34shybw7VTE2Ckwoe7gZlDGrKeOVKq0xhTFK+f1H3RtNY/6613DpHG9fj2Bocm03chUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O4II0Lbc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4II0Lbc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750173068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGX6svIlWpZEQ5EFYjPNzt7elF0IRahwc1dWlkYR+Go=;
	b=O4II0Lbc664ubj4tctw15wGuALPtrNP1aRaxG2rHyfsWUd94VzZ5mCAvW3lJkkK6iExoaY
	0XEK1740IDo+LypxxvO3d8JBCV88uhZyUqu0MrA15DdTB1mIvxtBJ5UFyEc/2TG0dLMwUR
	8orOOrmBkj1/93FRpv9FoW0AgmL/vNU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-DNCRkY-INIik1UG_xa423Q-1; Tue, 17 Jun 2025 11:11:07 -0400
X-MC-Unique: DNCRkY-INIik1UG_xa423Q-1
X-Mimecast-MFC-AGG-ID: DNCRkY-INIik1UG_xa423Q_1750173066
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450d290d542so35530385e9.1
        for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 08:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750173066; x=1750777866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGX6svIlWpZEQ5EFYjPNzt7elF0IRahwc1dWlkYR+Go=;
        b=nCCUdRW3hSZr/Hlkk/xyoZ8bJVOyMo53Kwj/wrfOdaGZ47uwWiJDUN6LZFQv6S03YF
         pveJlcNJMC8SYyevo7r4Vz2Z4rpjTlHixJOjh3HuvMU8qJ4JB9Wp219suUanEdano83I
         EKAaGmxtLLE8AzixJtkQXcjxN45mm44gEQ4pdV/+TVDOTUKMnGs9WdLVMpshXa/zXHCt
         M7KZPAH4PcSTq1un4G8LfmNZoZt0o2ytNliDeCYEWU5X875MbTR0pGDUDZ51W2CpD1V7
         Wgo80GPedBM5xV8kaNB6db2p06ifSIKkKz/kVJbnsaMLO4C2ZBd1qIQ1bV87SCsARLPn
         yDwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLw2jeriMnAZ6h8SvgDWDsGc7MfXX7OTRvp7OYcQU4e96IbSok98x7WsV7bU63TDGg9ll3lHhc6qV1mpN0ng==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjitVIMNE5maN+YxZ5xBMyyOJASWGqaWaLADgj6+o0we+mf4Bn
	xGaaHu9kVDgR7/5jaFMcYDnWbAsiK14ZNUQJR1TS+duVPEZ4tUZlAHYpioTunt9vgz9bGEubnj/
	Gq5q2kEdduaGzgQV546WxneyAsV+6TZ+vFA0cKdPAU59LFxj8BAF/8k57yLHx9jDd9VHi
X-Gm-Gg: ASbGncs1nIrCT/7vlNyTCu6fVudR0Hzbiv1ZySk17nEV/mNvv4B+Gb1FNlRwq+0oZGZ
	C+Sfsf+efv53nnOBCWdhvrHasho178El4ZK1MQ0psO83XArnJ19/0VE8+WCmpJmVCEh0UuVrpya
	pPQ42LKJO3O9PZNn/0+LtxzGTCGusJYoVXRR/RR0YZDuB/KWoXZAYwAxAkJPql8yXqYQ7polXNQ
	ENzcAo4hFCTDWF1qWUp2NMX+Qs4lNA40jH890AV+aHtSOsxCmjH7S/UQBW/qVUtaPKPH31Ia6i6
	G08jlsZS21K0rVGKplQnpHj1vKOn
X-Received: by 2002:a05:600c:4f54:b0:43b:c0fa:f9dd with SMTP id 5b1f17b1804b1-4533cab1c91mr100034775e9.25.1750173064641;
        Tue, 17 Jun 2025 08:11:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLw5YcffSL+V+Aaktp6ydgR00R6Aiz6j5f4o7u0CbWcG6l7Jh0rci6v44UVdISCb4YtYblWQ==
X-Received: by 2002:a05:600c:4f54:b0:43b:c0fa:f9dd with SMTP id 5b1f17b1804b1-4533cab1c91mr100034365e9.25.1750173064079;
        Tue, 17 Jun 2025 08:11:04 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.200.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e13c192sm179620505e9.26.2025.06.17.08.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 08:11:03 -0700 (PDT)
Date: Tue, 17 Jun 2025 17:10:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: mst@redhat.com, pabeni@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, netdev@vger.kernel.org, stefanha@redhat.com, 
	leonardi@redhat.com, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, fupan.lfp@antgroup.com, Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH net-next v3 2/3] test/vsock: Add retry mechanism to ioctl
 wrapper
Message-ID: <uqpldq5hhpmmgayozfh62wiloggk7rsih6n5lzby75cgxvhbiq@fspi6ik7lbp6>
References: <20250617045347.1233128-1-niuxuewei.nxw@antgroup.com>
 <20250617045347.1233128-3-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250617045347.1233128-3-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9LBoRmeByAz9deCOzq8smN-rvWAYn7YGorlp2ot6CKQ_1750173066
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jun 17, 2025 at 12:53:45PM +0800, Xuewei Niu wrote:
>Wrap the ioctl in `ioctl_int()`, which takes a pointer to the actual
>int value and an expected int value. The function will not return until
>either the ioctl returns the expected value or a timeout occurs, thus
>avoiding immediate failure.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> tools/testing/vsock/util.c | 37 ++++++++++++++++++++++++++++---------
> tools/testing/vsock/util.h |  1 +
> 2 files changed, 29 insertions(+), 9 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 0c7e9cbcbc85..ecfbe52efca2 100644
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
>@@ -97,28 +98,46 @@ void vsock_wait_remote_close(int fd)
> 	close(epollfd);
> }
>
>-/* Wait until transport reports no data left to be sent.
>- * Return false if transport does not implement the unsent_bytes() callback.
>+/* Wait until ioctl gives an expected int value.
>+ * Return a negative value if the op is not supported.
>  */
>-bool vsock_wait_sent(int fd)
>+int ioctl_int(int fd, unsigned long op, int *actual, int expected)
> {
>-	int ret, sock_bytes_unsent;
>+	int ret;
>+	char name[32];
>+
>+	if (!actual) {
>+		fprintf(stderr, "%s requires a non-null pointer\n", __func__);
>+		exit(EXIT_FAILURE);
>+	}

I think we can skip this kind of validation in a test, it will crash 
anyway and we don't have in other places.

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
>+	return ret;
>+}
>+
>+/* Wait until transport reports no data left to be sent.
>+ * Return false if transport does not implement the unsent_bytes() callback.
>+ */
>+bool vsock_wait_sent(int fd)
>+{
>+	int sock_bytes_unsent;
>+
>+	return !(ioctl_int(fd, SIOCOUTQ, &sock_bytes_unsent, 0));
> }
>
> /* Create socket <type>, bind to <cid, port> and return the file descriptor. */
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index 5e2db67072d5..f3fe725cdeab 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -54,6 +54,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
> int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> 			   struct sockaddr_vm *clientaddrp);
> void vsock_wait_remote_close(int fd);
>+int ioctl_int(int fd, unsigned long op, int *actual, int expected);

what about using vsock_* prefix?
nit: if not, please move after the vsock_* functions.

The rest LGTM!

Thanks,
Stefano

> bool vsock_wait_sent(int fd);
> void send_buf(int fd, const void *buf, size_t len, int flags,
> 	      ssize_t expected_ret);
>-- 
>2.34.1
>

