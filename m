Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE53C26AAAF
	for <virtualization@lists.linux.dev>; Tue,  6 May 2025 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524604; cv=none; b=NXbrDkjxu7YPtN2wPsmo9YwfWfZdT6mbfc2DNU+Uajjhh/En3BUgRSO9RVrAT9KAjRYe0CFo3FwsS6Z8qaeuMzECqZT5qfR9VfCP4gvnjIsQ/031DSel4kxV/Dzja57uwJVeJd33jTVpgWgM+nz5RKzr5DdPRLyvEloq6R2msBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524604; c=relaxed/simple;
	bh=OdYxdf2NS9wIbAV3ovwDZCL2iMe9F3X5Sqi4us7Hjcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kF9ZAzKI9Y6hm+3yceiKCPo60iHeAbjAV+PH349sDWTGJEzDqihOj3aFJM/6EA0PQY7c/YvKWDj65ewg2Ziu0RPZdYIW3lH4FJrZgAX8ZcoQJ3P0adZ/jlcFG0OV0dPunfJMDgr0g3WvyXzajfsmTav3SOdVWvrGeJdbwf1U/EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/qR00xV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/qR00xV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746524597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DXoAgnolhnIWon+GSP4Yh+No5sQktwbAsoZby2qJ9Oc=;
	b=D/qR00xVZfdpDDdDQo+s+cHuoJP0KyHrnVc0hKFgnt3yZCGxO6OFs5cvsMD+sZEIKTpPfZ
	ioUBv04NSLm3IWgfc6ZBBwnnbQF30y/XW9I3xpyZvcK8WSHAZeLi7l7Vmkpdy0oL3swFZ4
	sJLgM4d0CCjDtS5+WiACaTsdWJTF0GM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-jVixYjgBNCyOud6nX-f3Ng-1; Tue, 06 May 2025 05:43:16 -0400
X-MC-Unique: jVixYjgBNCyOud6nX-f3Ng-1
X-Mimecast-MFC-AGG-ID: jVixYjgBNCyOud6nX-f3Ng_1746524595
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-acb67aad0e2so448261966b.0
        for <virtualization@lists.linux.dev>; Tue, 06 May 2025 02:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746524595; x=1747129395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXoAgnolhnIWon+GSP4Yh+No5sQktwbAsoZby2qJ9Oc=;
        b=P6Ms+aN+9LUqaC0ZfF5j9z3tryO7H3ixfNruZ/Pc0KnXzYwjk/R9/fHl4OkEjlQtiP
         eXydfF/4sZ6mWIqr71zU5X5mnmzqokC9RIYbEDUYw7QRrVa7z9/aMeo1qU0UPfNe/YiR
         kKjrG2L7A110/26b0kAySPkZkm9QAekMmUTpLA/tJf4PvA1xkusEAl4Ua4N6QNUM2T76
         eVAbqn+tG+kVKDE0OOgyMyBwdDKJEmz9tCDjhhEGzl6YsJ5OyC/b5EYB2iABx9dEyhjd
         1BOk/tVWhrahsiCAS6l97Pyi3X4RK1byKpMTjhi5gGbbQ7fFhQYSxWsjxycq/EQWry9i
         6qZg==
X-Forwarded-Encrypted: i=1; AJvYcCUzPmwYchpdZZMZ3u5xrRjAN5K53nlm0CO9xJiEnCL8YOBzS+GW78h995b017o0p7B3WHxZAOG09Y6t4t42yw==@lists.linux.dev
X-Gm-Message-State: AOJu0YynbBs8Zblf9i69Cn1FeIzmZJ30gqVbnBFmx1l37zP288UgJwXG
	OWoILZPADNA8Uej0X5fQOsxgcb4Xf9C/74vQmAHH3OGYKStvQ77QVHCoYeRYZvKBzWGc37C4ENL
	zQ1Pa/g6fjml/Z/Ww9DlvOGgZy2VhWsiiu6iSnRxK9nNZ/fdcMBxJgfzVktIOT61H
X-Gm-Gg: ASbGnct4Bwgny1FB/E5OFPcNW0PaSwyM01in5B+oNcwf1/FpjJ66yDI/DkhMKmLEIdw
	r5xnN+5AlU8HohcdnaDthj+eUO/uy1SW8p/Wxp7NQb+gti1a1BTtNPZwz8uASnzz9El/h19gLRt
	RFmYZEZZPVfNLbiezcNhdt0qb9RzcYCM1srJfoWK5iwV7U3Sz7h3UiKlk1VKHJHVbb59mnvU5dQ
	oEiFhTLcLicfvSY/SNPamjoaG0aF3oaT72ufNM0K9KgFu4ztPt2Q6wLjdCK+hKp0MDtbV8Vc7Nf
	pD5Evm17vtN8dx6o/Q==
X-Received: by 2002:a17:907:6eac:b0:ac7:b213:b7e5 with SMTP id a640c23a62f3a-ad1d2ecb11emr249439266b.18.1746524595045;
        Tue, 06 May 2025 02:43:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr2idRnebYQGCDDQ8BywfWXGWGiLs9tHDNaPLdjiBxzUREqjzvsHE6e+fFczVT0Qkx8Sxwyg==
X-Received: by 2002:a17:907:6eac:b0:ac7:b213:b7e5 with SMTP id a640c23a62f3a-ad1d2ecb11emr249435966b.18.1746524594435;
        Tue, 06 May 2025 02:43:14 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.219.197])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189540dabsm671051666b.171.2025.05.06.02.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 02:43:13 -0700 (PDT)
Date: Tue, 6 May 2025 11:43:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/3] vsock/test: Expand linger test to ensure
 close() does not misbehave
Message-ID: <g5wemyogxthe43rkigufv7p5wrkegbdxbleujlsrk45dmbmm4l@qdynsbqfjwbk>
References: <20250501-vsock-linger-v4-0-beabbd8a0847@rbox.co>
 <20250501-vsock-linger-v4-3-beabbd8a0847@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250501-vsock-linger-v4-3-beabbd8a0847@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PHo6eEybHFhO2CSwUAC7tqAPJ10CGSNLiIIWZdiJcWI_1746524595
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, May 01, 2025 at 10:05:24AM +0200, Michal Luczaj wrote:
>There was an issue with SO_LINGER: instead of blocking until all queued
>messages for the socket have been successfully sent (or the linger timeout
>has been reached), close() would block until packets were handled by the
>peer.

This is a new behaviour that only new kernels will follow, so I think
it is better to add a new test instead of extending a pre-existing test
that we described as "SOCK_STREAM SO_LINGER null-ptr-deref".

The old test should continue to check the null-ptr-deref also for old
kernels, while the new test will check the new behaviour, so we can skip
the new test while testing an old kernel.

Thanks,
Stefano

>
>Add a check to alert on close() lingering when it should not.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 30 +++++++++++++++++++++++++++---
> 1 file changed, 27 insertions(+), 3 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index d0f6d253ac72d08a957cb81a3c38fcc72bec5a53..82d0bc20dfa75041f04eada1b4310be2f7c3a0c1 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1788,13 +1788,16 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+#define	LINGER_TIMEOUT	1	/* seconds */
>+
> static void test_stream_linger_client(const struct test_opts *opts)
> {
> 	struct linger optval = {
> 		.l_onoff = 1,
>-		.l_linger = 1
>+		.l_linger = LINGER_TIMEOUT
> 	};
>-	int fd;
>+	int bytes_unsent, fd;
>+	time_t ts;
>
> 	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
> 	if (fd < 0) {
>@@ -1807,7 +1810,28 @@ static void test_stream_linger_client(const struct test_opts *opts)
> 		exit(EXIT_FAILURE);
> 	}
>
>+	/* Byte left unread to expose any incorrect behaviour. */
>+	send_byte(fd, 1, 0);
>+
>+	/* Reuse LINGER_TIMEOUT to wait for bytes_unsent == 0. */
>+	timeout_begin(LINGER_TIMEOUT);
>+	do {
>+		if (ioctl(fd, SIOCOUTQ, &bytes_unsent) < 0) {
>+			perror("ioctl(SIOCOUTQ)");
>+			exit(EXIT_FAILURE);
>+		}
>+		timeout_check("ioctl(SIOCOUTQ) == 0");
>+	} while (bytes_unsent != 0);
>+	timeout_end();
>+
>+	ts = current_nsec();
> 	close(fd);
>+	if ((current_nsec() - ts) / NSEC_PER_SEC > 0) {
>+		fprintf(stderr, "Unexpected lingering on close()\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("DONE");
> }
>
> static void test_stream_linger_server(const struct test_opts *opts)
>@@ -1820,7 +1844,7 @@ static void test_stream_linger_server(const struct test_opts *opts)
> 		exit(EXIT_FAILURE);
> 	}
>
>-	vsock_wait_remote_close(fd);
>+	control_expectln("DONE");
> 	close(fd);
> }
>
>
>-- 
>2.49.0
>

