Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D8125E80A
	for <virtualization@lists.linux.dev>; Thu, 22 May 2025 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747901149; cv=none; b=Gdb/eF85I/jfVn5ylszIMh5GfsEZfi7tDiKBpQK9FzJpzDm+RUmyyjOCbnacq90KLpYqyYrih176LtKDq/Z0N6SdfAoZ/OtrrylW5qQfqcFRSAg+VKH91nIzhD0hOcemKSUmlS6rskiTjgC7ZQTA9C2M8gXOU49+/0W0y4ClxS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747901149; c=relaxed/simple;
	bh=kWJ+8wnhh914ZGBXjyQG8OCRHhwawgFGLPLGp5cMp2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jvtNXVHDufs4lTgs3fEz+FLeL1zjTBPamUzYdh+FxRrx7yuNzrkb3cuY5W2NJXINK0+R4elQetdMMYNkdIvkV149rLCgLjMWTi6HLe/YYYwEhUnNo3Yx/+ZS78SxzG9PWdddX+v9/7l9oSwfNAIupwe2/AqxlPVOA9AYOcIQDqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=djQPBdpJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djQPBdpJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747901146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4n1+uXd36V+722CeTIUBaJYf703izxjGMMRXpA7T1DQ=;
	b=djQPBdpJfzJvD6Fy535GNeYnXfjxKRs1r33fNAWegTRme55gCzoWZ4UAKvNk/eiEb4eb6c
	tZ7kTrtjiLb+EL5pvpBQq2uFIHKIvi5TzsSXnh2+6/FlV97ciUIqY3zYw2Iaq2gC4a2fiM
	BbNHBjin099ULwJqOXDx/pPVNNE9W3o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-Xz0MxJ2xM8W0EWF_xyeYTw-1; Thu, 22 May 2025 04:05:45 -0400
X-MC-Unique: Xz0MxJ2xM8W0EWF_xyeYTw-1
X-Mimecast-MFC-AGG-ID: Xz0MxJ2xM8W0EWF_xyeYTw_1747901144
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43efa869b19so59573375e9.2
        for <virtualization@lists.linux.dev>; Thu, 22 May 2025 01:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747901144; x=1748505944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4n1+uXd36V+722CeTIUBaJYf703izxjGMMRXpA7T1DQ=;
        b=V/7cACIBX9kmrOGf48w+7BQe9onRiE4AlNshBz/ZZk/vTeAjRS7fV5x9CGSfLgxyFg
         diJIIipMSyokVsbjrE5aGnN/8uVwC281Ulk28pMBbTjajTtW4syWORlAO8nVl2JIeVz6
         ICiLQO4w2tvIvmk+Pei9hCHrMQVlU88hEnfVGq+F1Cl/KF1493MNYPpER+Y3duhSqKbz
         cPUvBK/RIzhW0lEVY1+hLLaVSy8ag0epd7YsPGj/LpZxNSzDc7lhUlIF8hbbN5VY7Aha
         9H1I8el2gobh/ockyuXU6V/9BeKDjXkutnwMQNdDYIRxNFFuOn2rGoGI579YNS2cJuUu
         Oe/A==
X-Forwarded-Encrypted: i=1; AJvYcCXljpeU+aDyOw8cVsUlzNmNi7gGLHCu02YIRsQdIT8y5sbgexbUmdui1nJhsZ/piNrguHmTq0GmhrN2S5cRgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPszH+s1EIq7ZMB8l3ri4ErVHOe22sFXWlwvjP9u1S5e++VUyQ
	ztC8hW1P3IeQqiQsqqPxtp8lU9YeAvUiyaZ0RmEzDejXTgn4z9gpLl/kdvfmpFZK7uyXKEDIkVm
	s0wxY30bK07fxPp1l/K2mzBnK8mWLkKlXsSQ55lrq8bZBjcmSsW8uMAFqouogfHUcMwWi
X-Gm-Gg: ASbGncuw571hAkU+ZUAiOfpLrCbqE8QuxP3i9O0kOy6ojgooOZ00HJTDkaW4ZlApQAn
	2jmZa2H38DNiBNP8adSLTIB9BbVWyrN8yRHxiDqq/AZCGyAT2DXSoWZ6Gxtwig/iV2111Zyvej5
	M5Urx01JghvOKNSy1ZNgsBVgtLchS0V+EFZmOGeIOrMzp0U93Ck7exrMWMkR3ZrofCXDStzFvz6
	lEbB6nBhRoL3oYhPc7jhblhvGo0ojKblk1pUapEHp/JHsGJosqTlu09SzSUKy0W5AI306tsrEOn
	y4tasuf9dfKN0dhFDUt3w0hHpijDclRwpZcEtVeF97toaeDcyGsQgQqD3jbN
X-Received: by 2002:a05:600c:3ba1:b0:43d:762:e0c4 with SMTP id 5b1f17b1804b1-442ff03bbaemr215404725e9.27.1747901144388;
        Thu, 22 May 2025 01:05:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO6p/hrwmEdoltdyMAYZsM/Trt1xdM7A/O/RHR4xK1dSQJHwCglht4DgE/PYNhLm3+cM8zWw==
X-Received: by 2002:a05:600c:3ba1:b0:43d:762:e0c4 with SMTP id 5b1f17b1804b1-442ff03bbaemr215401755e9.27.1747901140327;
        Thu, 22 May 2025 01:05:40 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f381465fsm95350675e9.29.2025.05.22.01.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 01:05:39 -0700 (PDT)
Date: Thu, 22 May 2025 10:05:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v6 5/5] vsock/test: Add test for an unexpectedly
 lingering close()
Message-ID: <4huzbqatmv5ohwnwbqoeri55a35yyhlm3drlltldy6mgajjkj2@eptml5ykp54h>
References: <20250522-vsock-linger-v6-0-2ad00b0e447e@rbox.co>
 <20250522-vsock-linger-v6-5-2ad00b0e447e@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250522-vsock-linger-v6-5-2ad00b0e447e@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ap-AjDMz7aVrRdym6fluyG9lxxWbqfLBA_be8ML5HMo_1747901144
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, May 22, 2025 at 01:18:25AM +0200, Michal Luczaj wrote:
>There was an issue with SO_LINGER: instead of blocking until all queued
>messages for the socket have been successfully sent (or the linger timeout
>has been reached), close() would block until packets were handled by the
>peer.
>
>Add a test to alert on close() lingering when it should not.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 52 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 52 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index b3258d6ba21a5f51cf4791514854bb40451399a9..f669baaa0dca3bebc678d00eafa80857d1f0fdd6 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1839,6 +1839,53 @@ static void test_stream_linger_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+/* Half of the default to not risk timing out the control channel */
>+#define LINGER_TIMEOUT	(TIMEOUT / 2)
>+
>+static void test_stream_nolinger_client(const struct test_opts *opts)
>+{
>+	bool waited;
>+	time_t ns;
>+	int fd;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	enable_so_linger(fd, LINGER_TIMEOUT);
>+	send_byte(fd, 1, 0); /* Left unread to expose incorrect behaviour. */
>+	waited = vsock_wait_sent(fd);
>+
>+	ns = current_nsec();
>+	close(fd);
>+	ns = current_nsec() - ns;
>+
>+	if (!waited) {
>+		fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
>+	} else if (DIV_ROUND_UP(ns, NSEC_PER_SEC) >= LINGER_TIMEOUT) {
>+		fprintf(stderr, "Unexpected lingering\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("DONE");
>+}
>+
>+static void test_stream_nolinger_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("DONE");
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1999,6 +2046,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_linger_client,
> 		.run_server = test_stream_linger_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM SO_LINGER close() on unread",
>+		.run_client = test_stream_nolinger_client,
>+		.run_server = test_stream_nolinger_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.49.0
>

