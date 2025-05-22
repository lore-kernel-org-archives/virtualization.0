Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5FF2620C9
	for <virtualization@lists.linux.dev>; Thu, 22 May 2025 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747901136; cv=none; b=W9jDZ+RGqa/23moBawBBSQWc1J3JCaRcK714EoJQ3ozkvwJlr2P5M1WqdCe+W7dG1bfzOehUhQ5IlL4g6aTeX32ISxnf9ids/9i0ubTUnJML7daBCr1Iu8HAGAfDsUpHbvKlUaRIW4KUXUL4CHKzLKyNGJqhUCKvZxW9sQ8lQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747901136; c=relaxed/simple;
	bh=XB1DMlWvcWPFzBP+Imok5+hdMej12hjrOWoDR2YlK1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eOt/ZDXcAOyO/OddLR1lW/So8A5epb0jggB0kO7CyuaWpc389sYc5J7IByttYiyLjdLvaFPsp81zaX2ZMXK07YJ+Dpql8Zuq9KAda7+6zmNETnQzV3G98hyoPllOWe2qtBK3dbwwQzNZB5zbDpEx55PL+msTgomFcskX/Du1jz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LI6bwfy9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LI6bwfy9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747901133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7k5iTkA7yVBLFLMB+U1JSV+k17S5HvwfFdvLDBIgyTc=;
	b=LI6bwfy9f04rDvcn20p/leJGOJ8zvh/h2J90WiLQf6m4Mpbe0v5tHUGrfESfTNHtfGBcHc
	4KR5c4rjgfzAc6QPbE6Ucz6gInH4SeM8KtqyyI87ozfKzpI3DoVIbHDOgjcLqO3HnZfN8u
	6WASutCzzgP00VOoYiTvkPfw7NmO8cc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-AYOru2haMJya5oZABmlYtw-1; Thu, 22 May 2025 04:05:29 -0400
X-MC-Unique: AYOru2haMJya5oZABmlYtw-1
X-Mimecast-MFC-AGG-ID: AYOru2haMJya5oZABmlYtw_1747901129
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso39492815e9.0
        for <virtualization@lists.linux.dev>; Thu, 22 May 2025 01:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747901128; x=1748505928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7k5iTkA7yVBLFLMB+U1JSV+k17S5HvwfFdvLDBIgyTc=;
        b=NqOx23n/NKrjrybeZyQESzc4B8bmVVP4IzMD6JDuChzO0SUo/BdvjSZmzt1vv4szGG
         hfAurobXAqtq17lvLSAG2rS0dK3Yz609RDVR13iN0MfJCUOuVK8RXb2ZuCWpi+Om0zXq
         NgtuCa5SYIs4j1cEnnWV7d61R2tvS78eyCFFxscgGMNWZzrkwr+EEsJ+kvcztQZE2Jm0
         LVVDUoYg9A2G2IAf4xvMlxvJiCDxjwcieW4G4dIxa4OlGEdC2NJ4x3yuB3RVTtwkuCv6
         AL2/l47vqMbJuY2mC7DfXQi9+23SxDqN5S61Yh71vTsKZRu51W7OAJzq79Jq7pLWv2Hq
         CrtA==
X-Forwarded-Encrypted: i=1; AJvYcCWIPK+5HoPvuzw0nQ/g5LtELSj7jXLXGHhQdmIjj9mcCOkbIM6Ihay+W6aW7THlUhExQPTtCuJyt2iurls09A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3uaRgEFCtOiByu7xJb6k6l5S/PDW4VpWOtK16v0nMA8A9srJ7
	L2mujrDfmg0s4hf54qXe7FUI/0aBmVrIRFfHL/ksvOluiDSB+6myfZdK0Y4ou5/QuzKBWaTUo9N
	UaAHqYGqVvQvas3d2+SjaY2kOncmtHK1hYZPK7x+eNaY0cfb6FJV3jjsDvo0/7cErneRi
X-Gm-Gg: ASbGnctXS4Xg7RM7c31ljNo4FKpirVW/Ripp4JIBY60ewQmBI6S80QcpOUeRtlwyDix
	dBdF0TK9eiL1518ND5eLz8pAeQI7+PThHvQ5OzrcRt5JbhBlHQRlyiLW1ORNTqvSeO+gMfwaGiF
	/HaZWKEFRWVa6ggqKn4LDmGMCVUC+zyKKorbZbTTcgULKscFdfY2MkS7vhEy55mWfKofTbvXlrC
	qo0jiE0zbYMI+xGR45Qx3H7lz5Bm6VSgrdBjt/0yXMB6lpJHHwikg+VPRhXqucteHfa8gV9XDo9
	wO9spNmWuTfPDGbKabr5qrku2MY2O8JIySBAarhOc+8kUdmT2fzb+d0Q/IkH
X-Received: by 2002:a05:600c:821b:b0:43b:bfa7:c7d with SMTP id 5b1f17b1804b1-442f84c2008mr257388735e9.2.1747901128584;
        Thu, 22 May 2025 01:05:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOJr/dg0WH1mCD/vKgYtxTFY+fPT/s3TzPpEZ0P+tVyaywIvhuNO5rWcBUW3o5S0oEleDuOw==
X-Received: by 2002:a05:600c:821b:b0:43b:bfa7:c7d with SMTP id 5b1f17b1804b1-442f84c2008mr257388275e9.2.1747901128132;
        Thu, 22 May 2025 01:05:28 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ebd46aa4sm203871645e9.1.2025.05.22.01.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 01:05:27 -0700 (PDT)
Date: Thu, 22 May 2025 10:05:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v6 4/5] vsock/test: Introduce enable_so_linger()
 helper
Message-ID: <hzkiu4tq7bxucsvjtc6pz2mkm2eoeoeqcygjtykuuo2jcfnbpv@2blkh2sdcp27>
References: <20250522-vsock-linger-v6-0-2ad00b0e447e@rbox.co>
 <20250522-vsock-linger-v6-4-2ad00b0e447e@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250522-vsock-linger-v6-4-2ad00b0e447e@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RHtkUWmoZO9I9jsYECQMXDPbfkECe2xsx_K8jfNbvgM_1747901129
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, May 22, 2025 at 01:18:24AM +0200, Michal Luczaj wrote:
>Add a helper function that sets SO_LINGER. Adapt the caller.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/util.c       | 13 +++++++++++++
> tools/testing/vsock/util.h       |  1 +
> tools/testing/vsock/vsock_test.c | 10 +---------
> 3 files changed, 15 insertions(+), 9 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 4427d459e199f643d415dfc13e071f21a2e4d6ba..0c7e9cbcbc85cde9c8764fc3bb623cde2f6c77a6 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -823,3 +823,16 @@ void enable_so_zerocopy_check(int fd)
> 	setsockopt_int_check(fd, SOL_SOCKET, SO_ZEROCOPY, 1,
> 			     "setsockopt SO_ZEROCOPY");
> }
>+
>+void enable_so_linger(int fd, int timeout)
>+{
>+	struct linger optval = {
>+		.l_onoff = 1,
>+		.l_linger = timeout
>+	};
>+
>+	if (setsockopt(fd, SOL_SOCKET, SO_LINGER, &optval, sizeof(optval))) {
>+		perror("setsockopt(SO_LINGER)");
>+		exit(EXIT_FAILURE);
>+	}
>+}
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index 91f9df12f26a0858777e1a65456f8058544a5f18..5e2db67072d5053804a9bb93934b625ea78bcd7a 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -80,4 +80,5 @@ void setsockopt_int_check(int fd, int level, int optname, int val,
> void setsockopt_timeval_check(int fd, int level, int optname,
> 			      struct timeval val, char const *errmsg);
> void enable_so_zerocopy_check(int fd);
>+void enable_so_linger(int fd, int timeout);
> #endif /* UTIL_H */
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 9d3a77be26f4eb5854629bb1fce08c4ef5485c84..b3258d6ba21a5f51cf4791514854bb40451399a9 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1813,10 +1813,6 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
>
> static void test_stream_linger_client(const struct test_opts *opts)
> {
>-	struct linger optval = {
>-		.l_onoff = 1,
>-		.l_linger = 1
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
>+	enable_so_linger(fd, 1);
> 	close(fd);
> }
>
>
>-- 
>2.49.0
>

