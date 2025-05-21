Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151181D63DF
	for <virtualization@lists.linux.dev>; Wed, 21 May 2025 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838505; cv=none; b=LC0X3Q8tsZXHThVqvQOV3oJ9G09usphRlxTWD39Tz9dJOUfoGqS5hgffzeJmzl7UhEtmVK+YQETFrZrlgueJ9+6wgupvNTJGcnSMcmUdmE5yLps6dLqGpFCE1Q62azhUYink2kQVcVXjmYDZ+6Y+71p3XUhpBXWO3KvPvelUkfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838505; c=relaxed/simple;
	bh=fJrz4e1Ti/Jt27bWzNcWF73I0K+Q9z0Ka+LDgDGAiMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MTNXfv8+RuOM2SvyNcZadcDUUOYdwGTXvzvjjVvOcbSyGOtqgeB1RWaObXr+lEnWJylczmGODFqNPEyxxYOa/62vq+ZQv2CyB/HDjWkO6Q3XqXB99hn/Nc04nl57kg9OXxarUbIduRKBvdc5h+Q75/bDSMSM+OvxWk/TFTJjdP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cEd/FJqj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEd/FJqj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747838503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mDesXKTayHxGjIGY1j8G0o6g9UGYHXMrYuHHOq5gQRI=;
	b=cEd/FJqjuEwN+FiBB+vAgcFNTKcrRa7ndIC45HqR0iO+wN0X2OJcC2U4HgAdIOsTSBgTF1
	jWIsZytTPHvrJJ0Q+v8b1MmoDwndSkAmWY07tJJpssOfKltofYXEwvAJ6/1lN65X2a/rom
	TnypONEuRrap9YkOyNGHDc4exmq1jdA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-7icX16d-NAaW918kl4lSPw-1; Wed, 21 May 2025 10:41:41 -0400
X-MC-Unique: 7icX16d-NAaW918kl4lSPw-1
X-Mimecast-MFC-AGG-ID: 7icX16d-NAaW918kl4lSPw_1747838501
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-acb66d17be4so477682366b.2
        for <virtualization@lists.linux.dev>; Wed, 21 May 2025 07:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747838501; x=1748443301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDesXKTayHxGjIGY1j8G0o6g9UGYHXMrYuHHOq5gQRI=;
        b=eaHbJPuexV5j/w8Ci/t/OWrOYGg/qIAf40eBaLWuZzw4sScv3TV6YWp2xZKj9S1CpV
         a6u1ZdMeC/KFiVNEfPPAbaHszkEu+lK3F3YbIsXPn4pTx0K3nfb3JsQyQGFCwnv99IPI
         T3lx0nxVff3SH40SNcvwPIq+9MKQtc99ma1jWz0QqXw0cNw/rlg2iT4vy89B9Hrq68x6
         3Y6JHq/utBRp9jMk4DkfJoz3kKAdYA4DzactUw9BbidPhoxuSLSpoU+77NfrZ0ACY+SY
         HCIlgfKg56563y4E4sZC1mAn/d1OFbmMOf4v7+jf0pKH1Q54qnLEugEvcfSkpVXu/nhA
         +Isg==
X-Forwarded-Encrypted: i=1; AJvYcCWbKCIYRj/uec7m8pwZe5RoaUZx6inz7wlHXDgI8uzs2WFuVuQRdt42f+Oz6l6WPC5uC591Wni5TT3e8iwTHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOlHVvgRVgRIl40Qlc0vsxoGzta1J+yNNJbxjA2TvgVpSyjJqd
	elGbvJNFfNxRZA6lg2zzeuhDJFanvPRObrABJ0PEwQ7YSbD8D1p4RzT2XuRTfTRJsz4RZso7fUJ
	yt3JghFXmBkhqx58cJDVQKEth26grPdEQIeuX3kgb1lXNrSsbrhPkJnUJSjxu2LnOf88g
X-Gm-Gg: ASbGncuF9arwPJ7GiwcrK9zcOOyEAV3GG+ncloDOOOOaihRWsiUHFKvF+L1JicUSYir
	IYfhOCXhQD0x0G6Gpcbc2xRIsoXhNLk9dD5/U5CmaTKCq0QprmWs30A7yuln3WLb4k36HZnuaYt
	Mok14TOUHr9eGOnXmBlvQQdWiDOLUJ3vR8kNc5r3WEC53inJgArBPDQoQeiFw3ec5ytq74Ks3UZ
	+jQ/hlIkgGPxqJPB9neiyZQ9bAvuc+DAtkf/NqCnKOcaZFQtA/ZQ0PV9Ec4uRzmLA+rJs6pQPKn
	N4Jzy31JMVb5UxP5yyWZyDZ7HkjxosF0sku1+cQjXWQSosJi6GXpuNOpOa6o
X-Received: by 2002:a17:907:e916:b0:ace:c59c:1b00 with SMTP id a640c23a62f3a-ad52d42dc34mr1768466766b.5.1747838500578;
        Wed, 21 May 2025 07:41:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE66RxXKL2W6d/q5voawNHWMt+eYxa0BkwW3PNFANgomMqz2eIeLzBYh2MlVa3aFRZzUSRf1g==
X-Received: by 2002:a17:907:e916:b0:ace:c59c:1b00 with SMTP id a640c23a62f3a-ad52d42dc34mr1768463566b.5.1747838499992;
        Wed, 21 May 2025 07:41:39 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d06dfa4sm914996266b.57.2025.05.21.07.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 07:41:39 -0700 (PDT)
Date: Wed, 21 May 2025 16:41:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v5 4/5] vsock/test: Introduce enable_so_linger()
 helper
Message-ID: <3uci6mlihjdst7iksimvsabnjggwpgskbhxz2262pmwdnrq3lx@v2dz7lsvpxew>
References: <20250521-vsock-linger-v5-0-94827860d1d6@rbox.co>
 <20250521-vsock-linger-v5-4-94827860d1d6@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250521-vsock-linger-v5-4-94827860d1d6@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q3PLLH5vsVFmZY48VZZiXdW8i0WwqsViRzl3XL_QFWA_1747838501
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, May 21, 2025 at 12:55:22AM +0200, Michal Luczaj wrote:
>Add a helper function that sets SO_LINGER. Adapt the caller.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/util.c       | 13 +++++++++++++
> tools/testing/vsock/util.h       |  4 ++++
> tools/testing/vsock/vsock_test.c | 10 +---------
> 3 files changed, 18 insertions(+), 9 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 120277be14ab2f58e0350adcdd56fc18861399c9..41b47f7deadcda68fddc2b22a6d9bb7847cc0a14 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -823,3 +823,16 @@ void enable_so_zerocopy_check(int fd)
> 	setsockopt_int_check(fd, SOL_SOCKET, SO_ZEROCOPY, 1,
> 			     "setsockopt SO_ZEROCOPY");
> }
>+
>+void enable_so_linger(int fd)
>+{
>+	struct linger optval = {
>+		.l_onoff = 1,
>+		.l_linger = LINGER_TIMEOUT
>+	};
>+
>+	if (setsockopt(fd, SOL_SOCKET, SO_LINGER, &optval, sizeof(optval))) {
>+		perror("setsockopt(SO_LINGER)");
>+		exit(EXIT_FAILURE);
>+	}
>+}
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index e307f0d4f6940e984b84a95fd0d57598e7c4e35f..1b3d8eb2c4b3c41c9007584177455c4fa442334c 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -14,6 +14,9 @@ enum test_mode {
>
> #define DEFAULT_PEER_PORT	1234
>
>+/* Half of the default to not risk timing out the control channel */
>+#define LINGER_TIMEOUT		(TIMEOUT / 2)
>+
> /* Test runner options */
> struct test_opts {
> 	enum test_mode mode;
>@@ -80,4 +83,5 @@ void setsockopt_int_check(int fd, int level, int optname, int val,
> void setsockopt_timeval_check(int fd, int level, int optname,
> 			      struct timeval val, char const *errmsg);
> void enable_so_zerocopy_check(int fd);
>+void enable_so_linger(int fd);
> #endif /* UTIL_H */
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 4c2c94151070d54d1ed6e6af5a6de0b262a0206e..f401c6a79495bc7fda97012e5bfeabec7dbfb60a 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1813,10 +1813,6 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
>
> static void test_stream_linger_client(const struct test_opts *opts)
> {
>-	struct linger optval = {
>-		.l_onoff = 1,
>-		.l_linger = 1

So, we are changing the timeout from 1 to 5, right?
Should we mention in the commit description?

>-	};
> 	int fd;
>
> 	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>@@ -1825,11 +1821,7 @@ static void test_stream_linger_client(const struct test_opts *opts)
> 		exit(EXIT_FAILURE);
> 	}
>
>-	if (setsockopt(fd, SOL_SOCKET, SO_LINGER, &optval, sizeof(optval))) {
>-		perror("setsockopt(SO_LINGER)");
>-		exit(EXIT_FAILURE);
>-	}
>-
>+	enable_so_linger(fd);

If you need to resend, I'd pass the timeout as parameter, so the test
can use whatever they want.

The rest LGTM.

Thanks,
Stefano

> 	close(fd);
> }
>
>
>-- 
>2.49.0
>

