Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985B1244676
	for <virtualization@lists.linux.dev>; Wed,  4 Jun 2025 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028124; cv=none; b=levULGgaktoksAvmMhWhFcl6Kh2jIGneURQHofvxZqUx2d0Yrc/1dzHeGgDVYmaeAyvpiSP+W0e3so2qzIOBhRVuKf/VZ3BbGzWqSjbDTzW1Ig9B1s+DLol7+sJym3oCzdLjnuQrd8oCopdvmv1p+RiqlHOP/bcRblYlQZq9DoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028124; c=relaxed/simple;
	bh=ykSrUtJRVrG5C3ewZuDK3v3dKTB5s3CoywV9b/oL5XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TvfxPG+jQRo6PLKipVZuw1e0d1mkTFr2rbrs/WQPNEiPZhWfAdHbi0hgHYCd2znnKsB62S4XO4o1w0HR0Dja9WgF3K5QtMtIipyaqBFXRknNr6clLIF5Z01dCy3RWyQaoNoJjWtrDwUVZF9mxWr2l/cfqw8b8TR81FsQDgHkFXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HpzKGokT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpzKGokT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749028120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n8Q0qUknm0Tw+XsQ3Iumz4ckG8TiyaKNLtuTt/FSDJU=;
	b=HpzKGokT3stj0gcQE+HPVZrvG58YfBm2j2leBxGpU9WbJNzgTHLeddDJFpQxmJT/K7bXDF
	15aQDZ3Df9R2sjMAjJE3DsUHf+50qcMS9f8ai718I0pkmhpoeNSfF+u5RtoqnChGTpdZGt
	Z9zWbt5O+5/+gPctYVjwoDXwhLJCKPk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-LRx4OombOTmLwCjnTQq5hQ-1; Wed, 04 Jun 2025 05:08:39 -0400
X-MC-Unique: LRx4OombOTmLwCjnTQq5hQ-1
X-Mimecast-MFC-AGG-ID: LRx4OombOTmLwCjnTQq5hQ_1749028118
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso3425338f8f.0
        for <virtualization@lists.linux.dev>; Wed, 04 Jun 2025 02:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749028117; x=1749632917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8Q0qUknm0Tw+XsQ3Iumz4ckG8TiyaKNLtuTt/FSDJU=;
        b=tXbJ28EF7pNSpm4qTrvz5rsWA/j2Fo6OUmMaAPwuWx8zqZ2XCBtusImRyI3Ex7O1u0
         ny3Bc3tcNTv/PvEsKrXNOXvQdJvoIABqZ6Tpqx6XBdUq4C7UNwB1UAGAJTmRqteo1vq+
         MPb7Nm9tLd389HtdJPOzB30Dl/Erm18f5sSncPp8CRs8l44Cldc84nih7cwUZtFVOHCZ
         yWeX7QXD3oKu65OFLLBT9yuUUaGrvGPO+iFVDSBiGe70FXdEFIgwMDBVkp+Tk/0bWZ6a
         8YQOri3+6LQZNY4hlAfmU8iLd1qpudsO73zHwzugtmtEwhQZ/U1SvaBdJx3xA20u9Xtz
         akCw==
X-Gm-Message-State: AOJu0YxSCAO0WC7ohUq6rYQzWc8QZGmKZBX1dST5HX0smy84QHjanAYY
	cQjaS69i4wdBsUmg899IiXhVHdTH6Dhoc5Y12LbHMzLmgaRinJyFbBckCjnpfl6PXEMBP+9TJps
	gDxcOe1UcPS/jPWXv3jb2LSunLWLEOOyxzV8czK5wmfUyJ0n0ZHqAQ1Y2kC+STNJZ3K3FHSN1Kc
	m9
X-Gm-Gg: ASbGncuDqDPF7bnDlfeiEFSwoR/8L5ktposbg0JjY+sz7Np1n8kV1O3Kqo/9WIVQ57g
	uGz9ILkq/1ZTPykRL5okv3L4gWO7kLAgH9AgQ+bsQ7Jk7YLilxRK7hS5s2mI8sZOPXUwJA8S6+N
	qkMY/lU8qwD46IZ0gX/LMB/xkP0KXBlpkDNSVLCyOoDHjg7rHh55FQch3OA7hKH46TxNoRJslZj
	DXy4x4YTX3p4UUgVaHh7vYhO3DqxI/C5spTIDJ8X98FDjNBp+gpg6JiOTlB1ipS/9M1OpzP1MvH
	9UWu4Rcu6FwrzuU=
X-Received: by 2002:a05:6000:2888:b0:3a4:dd16:b287 with SMTP id ffacd0b85a97d-3a51d903439mr1437407f8f.19.1749028117607;
        Wed, 04 Jun 2025 02:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcO2c2+diZvmUbgKDdnVKUNfMxIQzDrhP//nieF9e6yFt+1DNHaJUFNS9crcHuZE3m2IlpVA==
X-Received: by 2002:a05:6000:2888:b0:3a4:dd16:b287 with SMTP id ffacd0b85a97d-3a51d903439mr1437378f8f.19.1749028117040;
        Wed, 04 Jun 2025 02:08:37 -0700 (PDT)
Received: from sgarzare-redhat ([57.133.22.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5215e4ce1sm871363f8f.37.2025.06.04.02.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 02:08:36 -0700 (PDT)
Date: Wed, 4 Jun 2025 11:08:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 1/3] vsock/test: Introduce
 vsock_bind_try() helper
Message-ID: <itgkguzg4egcqi6y65cq5wky2vpcbdoxa34vcwgjh72rziy6uo@7bp6x6e4prxq>
References: <20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co>
 <20250528-vsock-test-inc-cov-v2-1-8f655b40d57c@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250528-vsock-test-inc-cov-v2-1-8f655b40d57c@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ddE40BeFJtAU67CxWvz9Xu_KT2KWgcALzIqRfRPTpH8_1749028118
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, May 28, 2025 at 10:44:41PM +0200, Michal Luczaj wrote:
>Create a socket and bind() it. If binding failed, gracefully return an
>error code while preserving `errno`.
>
>Base vsock_bind() on top of it.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/util.c | 24 +++++++++++++++++++++---
> tools/testing/vsock/util.h |  1 +
> 2 files changed, 22 insertions(+), 3 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

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

