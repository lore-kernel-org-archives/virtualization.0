Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2701E51F6
	for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827010; cv=none; b=QLJKzWUSrddVMzvHxJ0FpyXFldod583SQDVbxH6L547mzGMHEYjUzCJl6M3qww8IO8mu3mCKUrIpH9yCywgZ0nN7Pe2qTlhkqPxcgAzNTXxOdAXPyqUjeUoe3+lHYfYaibGGb6+/r4g9Bo35pf6tt5IhNvUY65GwAPsM+/0kNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827010; c=relaxed/simple;
	bh=cRYeyi32ANevS1OvWRG6UViBewsU9VurRmT5/ra/CsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RsH2rHeqc+fr7hWlVyX4ywtcKfMvE18TkfEjccM5efNsGp/Ao/ll3drMwbzC2EiAFybeLtaHM6xB+zm3zBmEmCF2AF09M+0U2mVViMQkxCyf2YkNkLRPdhapwIQr2sv+wHYSUuWCuWI9rmpSE+rZK8cCuXOHj94HZh5Eq7O5+6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YKSyu0aV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKSyu0aV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749827007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XPptdkmUQWyY2NUgk5R+pR8otplw7JGCI3XWawz+SuI=;
	b=YKSyu0aVp0A9QAIDanrzdyJag4V3KfmxI+6B+ENxhT/5VxTCKZjxH2J38ZlYWqje6CGyfF
	E3Yp3Y7B/lF2Tws6IK66ckvmbHT0589+36JHT6C+dummQcXsjT5TanE1qafKy0iZTBhjMo
	2D0JMpFw9PGOOVrMatRAhKPib/X9650=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-WNRZ4QMuNP26jOsHWA0RMg-1; Fri, 13 Jun 2025 11:03:25 -0400
X-MC-Unique: WNRZ4QMuNP26jOsHWA0RMg-1
X-Mimecast-MFC-AGG-ID: WNRZ4QMuNP26jOsHWA0RMg_1749827004
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so1037955f8f.0
        for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 08:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749827004; x=1750431804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPptdkmUQWyY2NUgk5R+pR8otplw7JGCI3XWawz+SuI=;
        b=xQn7IAGnBRkDYmRXPtXdO1dnIGODvAoXGlk7tfBDR5z1wAUD/KHv09ZZXy4zp3r9CJ
         GFkQr3DS4nqIZ+CPrgOPjUUQ+4LyG7VmlYMa0uM26nD0r4BMtwD3uR6fl8TyKlJOOR5J
         0NFHM6y9/aN3kdPM7swaJtPzjsA5xgpAfhTeW0v3I66HHliqvKOtFbejrkgFnHsrlMZv
         EfHLfek1cVMZANezd+Vlu2W88Bk0PfTM/mjqQT4Nt+8UndlvfX643mXJJNzz/38XRudi
         h5E3pPZwz5oh8k3BABiYRWOQxUoaK5T6a2WjmOds55Ksv98t8n5v2fkD/G1ppExDQzAH
         DsRA==
X-Forwarded-Encrypted: i=1; AJvYcCWWeZIJsuaglKwDEAEVw/2m38SAAiQFWanLPm+QKSKFfCMpM+c6ZT58jU+I6FKdksRy6SmEijVGzrSuPUrYXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYzKnijE65L3oAVrLRYXV9QOQZCtgTFQq2AYr51RvU2FGbeXeE
	eq8A5ZmypgfEyB/JAYChoS9/VpQfvnbLUVFO5Yl92zg4KgO1JOm7nhv4PAQzBBbz0DKg8OZFYHk
	EMgrARxkbkSSFU2FihqHfbxi1MtscZv7EiaTl0VOtZCd3w4gBZPvbUZx1zbSvayMbmBV1
X-Gm-Gg: ASbGnctd1epBXtckK16FbrcZowIRRApAr4F5iP6lLVPlscift7I6Hc5SeBPu/EdriWF
	akgp4emOBfVrzBsYE54CeYXcU2tjHmqJNez9USSXR4SNwTj8LS9c7nwIqt7AJv+rHgXTlBeNiLk
	4t4ysUIuh2BjL+SU5z+3A4c9r23hIE4XH21H228+0T8zToBuKqUHaGEC042P5JFE5FMuB6dTcz5
	aFb7ca9eCPGh+ci8mtOOr0EwB4FEkWmlgB+hdbZC3naeFu1NCZ4dNNTxjRiQNsCtvp1DaSAtVNb
	l3vVfEhW6EpUo0eM8yTs2a1ZPx8=
X-Received: by 2002:a05:6000:144f:b0:3a3:7ba5:93a5 with SMTP id ffacd0b85a97d-3a57237c9a7mr85699f8f.26.1749827001993;
        Fri, 13 Jun 2025 08:03:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuYvZ2dAnZ8I/GhdBHLLhfs4MPExbGzsgktXxUps2HvDq2BLjqswHaLgKzUuLhLc98dafM3A==
X-Received: by 2002:a05:6000:144f:b0:3a3:7ba5:93a5 with SMTP id ffacd0b85a97d-3a57237c9a7mr85548f8f.26.1749827000681;
        Fri, 13 Jun 2025 08:03:20 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b27795sm2607608f8f.71.2025.06.13.08.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:03:20 -0700 (PDT)
Date: Fri, 13 Jun 2025 17:03:18 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] vsock/test: Introduce vsock_bind_try()
 helper
Message-ID: <wt6dvbknnrm7wygcaflwh6jwkox2vveii3hr6qhiepbyetg3sr@y5iuhennusag>
References: <20250611-vsock-test-inc-cov-v3-0-5834060d9c20@rbox.co>
 <20250611-vsock-test-inc-cov-v3-1-5834060d9c20@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250611-vsock-test-inc-cov-v3-1-5834060d9c20@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 46p6Ah7eyv9JwCgqrWhSy4JuBAH6GgGp0Ng_hYhtR0w_1749827004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jun 11, 2025 at 09:56:50PM +0200, Michal Luczaj wrote:
>Create a socket and bind() it. If binding failed, gracefully return an
>error code while preserving `errno`.
>
>Base vsock_bind() on top of it.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/util.c | 24 +++++++++++++++++++++---
> tools/testing/vsock/util.h |  1 +
> 2 files changed, 22 insertions(+), 3 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 0c7e9cbcbc85cde9c8764fc3bb623cde2f6c77a6..b7b3fb2221c1682ecde58cf12e2f0b0ded1cff39 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -121,15 +121,17 @@ bool vsock_wait_sent(int fd)
> 	return !ret;
> }
>
>-/* Create socket <type>, bind to <cid, port> and return the file descriptor. */
>-int vsock_bind(unsigned int cid, unsigned int port, int type)
>+/* Create socket <type>, bind to <cid, port>.
>+ * Return the file descriptor, or -1 on error.
>+ */
>+int vsock_bind_try(unsigned int cid, unsigned int port, int type)
> {
> 	struct sockaddr_vm sa = {
> 		.svm_family = AF_VSOCK,
> 		.svm_cid = cid,
> 		.svm_port = port,
> 	};
>-	int fd;
>+	int fd, saved_errno;
>
> 	fd = socket(AF_VSOCK, type, 0);
> 	if (fd < 0) {
>@@ -138,6 +140,22 @@ int vsock_bind(unsigned int cid, unsigned int port, int type)
> 	}
>
> 	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa))) {
>+		saved_errno = errno;
>+		close(fd);
>+		errno = saved_errno;
>+		fd = -1;
>+	}
>+
>+	return fd;
>+}
>+
>+/* Create socket <type>, bind to <cid, port> and return the file descriptor. */
>+int vsock_bind(unsigned int cid, unsigned int port, int type)
>+{
>+	int fd;
>+
>+	fd = vsock_bind_try(cid, port, type);
>+	if (fd < 0) {
> 		perror("bind");
> 		exit(EXIT_FAILURE);
> 	}
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index 5e2db67072d5053804a9bb93934b625ea78bcd7a..0afe7cbae12e5194172c639ccfbeb8b81f7c25ac 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -44,6 +44,7 @@ int vsock_connect(unsigned int cid, unsigned int port, int type);
> int vsock_accept(unsigned int cid, unsigned int port,
> 		 struct sockaddr_vm *clientaddrp, int type);
> int vsock_stream_connect(unsigned int cid, unsigned int port);
>+int vsock_bind_try(unsigned int cid, unsigned int port, int type);
> int vsock_bind(unsigned int cid, unsigned int port, int type);
> int vsock_bind_connect(unsigned int cid, unsigned int port,
> 		       unsigned int bind_port, int type);
>
>-- 
>2.49.0
>

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

