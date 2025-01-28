Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F951A3A8D
	for <virtualization@lists.linux.dev>; Tue, 28 Jan 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070749; cv=none; b=CSaRLrpew4xc7fWRu6+J6iEbcezRuzmjNgXjoeYDsX09ZGbSc5BVx1P3RXkwKf+GOzE4SUGUxnYBDqDqNrTH2eGHp6zZRhGDAeOECXCuD2SXQwyh6tzteFJT5sUwiBMEJy8CjHsSTrUbuYyBZydtpkmmVtngYBewuVKaQtrNzn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070749; c=relaxed/simple;
	bh=xXmQSPCOE/q0+j4J49P0P6RP4ItkqYK84im10n0cc6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SAU+DEkHwb1tpOx85maIfOl+a3387rnAajbpRGrfkr5fIGTM5lS9fe5ot7IB0mZWmw1w5IMrEn9UQ0wZhUsDZsqH6Q9HqispWnGAWMlOuKa7ZSFcFeqGY3vr+r8i1KoTjjevjH2Wl0T0MiO6DqJ7O0zt6nkP/zZryT64TDrOEeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xxn69lTI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xxn69lTI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738070745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5n485xg/tbqT5XAK7sBKs4ZveDcXWXBDinLLkF7KVwU=;
	b=Xxn69lTI1TXbsaxWXBCOxyQl3gNjscRJof4JD0LHnkudGBcJ4pwkGI+ZQ5sifH2WkR3t4S
	+e8mGvv5fb3HlFsCJ0H94gzx50Qxkgp4Zh+XnuEXqi6B3yQkm+f9IHAg2W1D/5JRHRl7Q/
	F56gneamqjqoaK2TM+3cKbrBtSOvM2E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-aoh_RUCcNJOMMeO1uYYKRA-1; Tue, 28 Jan 2025 08:25:43 -0500
X-MC-Unique: aoh_RUCcNJOMMeO1uYYKRA-1
X-Mimecast-MFC-AGG-ID: aoh_RUCcNJOMMeO1uYYKRA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-386333ea577so2093895f8f.1
        for <virtualization@lists.linux.dev>; Tue, 28 Jan 2025 05:25:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738070742; x=1738675542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5n485xg/tbqT5XAK7sBKs4ZveDcXWXBDinLLkF7KVwU=;
        b=bhSHUpjgr+h0hDfZohQJ6iEIl8uuFSZYeSMZhQ1y4SStB8NM1ySl5syZFWHpKnV0D/
         u4eRgRmVfSXHxTix7m393GAmBpc6yU84rUQeyjH19K5Yf1Y9J1t6f6kvmHdNjNCC0u7E
         gaAfd8RzaplQGvg6jFI1zAWKZhK4K13uhpUTE6XnhbyD7y1Vnr/yHqV+SIvYD88wBZEP
         GXuZ7B5+nBWZwJRAIkULKXyIUWaPE+vndm63MtP4S+uz2YpUSBoZvfaxR8aryrg5OtUZ
         GPrM1xUAZDCgqUIsuZ9eQDLX7NXHU89pRJCZGwPJVJtNa4Aea31VxkWc36K5XgNfrQ3G
         ypEA==
X-Forwarded-Encrypted: i=1; AJvYcCWALA7Ds5//BV9OXz3veBxYdkC75pzbIbksJFUsA2EmYUs4lK93793/K668ALgHwqX6rCUuWVn1Z8ZCdqBy2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrAiiNaaW6N8fhUpJbhxX550tJgTFsdRdwsoURq3L8kAvylXVn
	pln2+TF8WGBYnjcOfzMvalV0QLyKcCpge4l7OHsAn9CbG8na4I0XBqrXzF+VIEW2AXG3Xz0j/l0
	nmYTU5yRHYn2dg6+dSjc0CfAWwukvC2In67Kp++U8jWrdPiBdSEnDuy9MRVouwDZh
X-Gm-Gg: ASbGnctDnmYj+yNhmOL1bmh4KnwIiYZK1T+5EjfQXaVew6J79NQPBp1boi/AlcIoUWE
	L/TbT8WHtxBuS45lY/gBphbrdR5qcImCuYieM9LLYj6TFpqbIser4Ch0tsB84diEJ9I+h0Yvn49
	ybd8zC8XscHAFXic348IqraO0yRy+IUSnTN38eXYuyYBzQDKfdBK2otdSrQKAUP6NiP+R5Q5y4J
	nvFEM8XFU4cuAaPvVoX+JgEy5gYmjgspk0cWSFxoRCuzxnrMqomt3gUMYLtMKHwFqxvE038arWi
	DocGpj6V
X-Received: by 2002:a05:6000:2a3:b0:38a:888c:679c with SMTP id ffacd0b85a97d-38bf59e21d6mr38958524f8f.42.1738070742317;
        Tue, 28 Jan 2025 05:25:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI1ckDOGbH2Z/XjBCGkfB1aD+MOGF0AFxjkiOnY1C6dGrybeYxKyU2FFmlM6TSPD89uDvoSA==
X-Received: by 2002:a05:6000:2a3:b0:38a:888c:679c with SMTP id ffacd0b85a97d-38bf59e21d6mr38958494f8f.42.1738070741914;
        Tue, 28 Jan 2025 05:25:41 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd507dc9sm172083215e9.19.2025.01.28.05.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 05:25:41 -0800 (PST)
Date: Tue, 28 Jan 2025 14:25:39 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net v3 0/6] vsock: Transport reassignment and error
 handling issues
Message-ID: <xqtxs5auazrrfqess6fewfjt3vc6t7jato3if3thnjtkwr5g34@anly3yn64yxo>
References: <20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W4Vvoch-nMtlgPob7ka-luPKRKmDSMWrleA8EAfOQSM_1738070742
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jan 28, 2025 at 02:15:26PM +0100, Michal Luczaj wrote:
>Series deals with two issues:
>- socket reference count imbalance due to an unforgiving transport release
>  (triggered by transport reassignment);
>- unintentional API feature, a failing connect() making the socket
>  impossible to use for any subsequent connect() attempts.
>
>Luigi, I took the opportunity to comment vsock_bind() (patch 3/6), and I've
>kept your Reviewed-by. Is this okay?
Hi Michal,

Yes, absolutely! Thanks for adding the comment :)

Cheers,
Luigi

>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
>Changes in v3:
>- Rebase
>- Comment vsock_bind() (Luigi)
>- Collect Reviewed-by (Stefano, Luigi)
>- Link to v2: https://lore.kernel.org/r/20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co
>
>Changes in v2:
>- Introduce vsock_connect_fd(), simplify the tests, stick to SOCK_STREAM,
>  collect Reviewed-by (Stefano)
>- Link to v1: https://lore.kernel.org/r/20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co
>
>---
>Michal Luczaj (6):
>      vsock: Keep the binding until socket destruction
>      vsock: Allow retrying on connect() failure
>      vsock/test: Introduce vsock_bind()
>      vsock/test: Introduce vsock_connect_fd()
>      vsock/test: Add test for UAF due to socket unbinding
>      vsock/test: Add test for connect() retries
>
> net/vmw_vsock/af_vsock.c         |  13 ++++-
> tools/testing/vsock/util.c       |  88 +++++++++++-----------------
> tools/testing/vsock/util.h       |   2 +
> tools/testing/vsock/vsock_test.c | 122 ++++++++++++++++++++++++++++++++++-----
> 4 files changed, 153 insertions(+), 72 deletions(-)
>---
>base-commit: 9e6c4e6b605c1fa3e24f74ee0b641e95f090188a
>change-id: 20250116-vsock-transport-vs-autobind-2da49f1d5a0a
>
>Best regards,
>-- 
>Michal Luczaj <mhal@rbox.co>
>

