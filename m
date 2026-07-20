Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AFD3AEB4A
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535476; cv=none; b=h6ywZW+gKzatkorRbac8UThD8UYQKoYutUR1ybm7izX9YYf0/Yy+I6tfmGlY5Z/lGqDXGF1c96kcki22qUycTMLIKO8TyATC9TmxK04LBe3DtiDsyCHx71rCN61GJICsE2VLmUYWm+SJDEiSFn4xWFNin0woThfqHLBS27Of3kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535476; c=relaxed/simple;
	bh=rdJleFptQxOZBI7LMPF/r2MarufA+U1d9dkuzXtOVgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ulMcduV0+O/4cU12xsSZ9s+0xwQ4CJr/K/eh1stq/JnbVF6qU0sxGVa19nB5Nlbeb1ghbFs/vD57YrG2XNcUgPQbETYMD7n9m7w6dEeZ+Z/hdKWWoxhWVeMAonfEBWtUAd4yvklmNnkXbW+JpVrtX7VT8fBsjk4s4Kf5/vvMyvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHMUh6Ii; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHMUh6Ii"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784535473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a1T/3ILBAZWlTf8F+pJIXj/IvpWirJ094fe/3AMtG14=;
	b=YHMUh6IiuSDVtS4zUUSMyxqB4ZiaKjJ5DVMYooeIfEWyjNd8+mEdMPaFYMy09IZMXp6e1G
	SwLYPe78TCKLSGL6/ehW1ttZ917oPbSiQMbKS+ffBcHj27M7a9Vi4SUWwV0C1+PHB3kkps
	uFj1DhH6liPKTMVloG7p4Z6qNVQEI08=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-mcE3184fMcK5JE1RZsfpwA-1; Mon, 20 Jul 2026 04:17:51 -0400
X-MC-Unique: mcE3184fMcK5JE1RZsfpwA-1
X-Mimecast-MFC-AGG-ID: mcE3184fMcK5JE1RZsfpwA_1784535470
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-473bc66c837so8248546f8f.0
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 01:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784535470; x=1785140270;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a1T/3ILBAZWlTf8F+pJIXj/IvpWirJ094fe/3AMtG14=;
        b=q0dCPd92HDXU94er14vGm1CQyEk/kN1jR9ZmnwZacpmYnBAOO8qW16JUIO6aWNbcEL
         1ZJoNag8S1XeLFzQqXUyVCzCQsYIUVZ66Zd8FBCnEF/mN0YWg1OFChQGwqR7eSAOKeiA
         QCvB52tzmcNDGL7oPZb9izQUlmkPeuaqIDfS4dv++rkGZ/4XwuTXebIVX2Tc8WT3lwbI
         pgS/6I7C2gMSNGlHKr4FF+172f0wdDomji+DX5+mgDzXDlBtpZjqAo8BLDvpe1mPpjdv
         jBSxm2rsdhPhg8X2TN/F5pvKXE/fZk+1U7vwK8ulmd8NvEAmYlHB/zJVlJZWDj4QOnOJ
         kdyA==
X-Forwarded-Encrypted: i=1; AHgh+Rp20NHAYetS2COz3QSjxCKUijirltjSFHmYKf7h8rEs9rbaA9F64eFIlz5V9YtTL556QnCJGcIfcOh7M9296w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvibqyIoI13BaydYqt/yMa42gb0SQAOUt9ajIg3zJ4swz6EKDx
	JggNIC/umSBptqDlm2YlmF1QF1aYRl76j24N+/2pvPV45tLEDLi/KI6hHPPQ42lnlCHzwxzmVM+
	/pu1pDycMOVE8w7Xw2o8Xv8yYzGb1Z84OJS92fnGWFMguB1+2SqtLc95gyg3lmbMOuNE8egdBP7
	hG
X-Gm-Gg: AfdE7ckyOaMtPtUoM+F8Tq5cqDyrm41gq8cFjpY8C9l1bY2r7A2HNznZ01oPQkjyG6K
	s+LGttP5RRPaF/6BI5ITrDyBZ3RbDajSoptbBw079owAMVeiQ+HCstIjmdFK+yxrNMAA0DF0GlU
	LzkXJllSk8TDfZd1Byb9ZuXGt7mHt3FnlQjKMTrT6DPEfZIQ/L+r5DS75gJD3TDLTsKBRqpj4E6
	IhW+GGFOASchFPUlU7ZadJ9FiGJkwjzffgOYEbwxRbrwZAYF1XxFVJd/RspQoN/YKvObkG/l2ny
	1TtHmVa40TprN0ByzmLvd5CN/iPmaE9NI3tga3bAvKIh5T7j3iCM+4hT0HZV0i25nutW02waRts
	FXJrPaLcsb48A1otjBSTytLtSQDkbfq4Bh/pWLdid8bRazES+Bg==
X-Received: by 2002:a05:6000:3101:b0:47f:776f:3845 with SMTP id ffacd0b85a97d-47f776f3a7amr3706625f8f.7.1784535470496;
        Mon, 20 Jul 2026 01:17:50 -0700 (PDT)
X-Received: by 2002:a05:6000:3101:b0:47f:776f:3845 with SMTP id ffacd0b85a97d-47f776f3a7amr3706580f8f.7.1784535470043;
        Mon, 20 Jul 2026 01:17:50 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ed1911sm29541750f8f.22.2026.07.20.01.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:17:49 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:17:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
Message-ID: <al3UuvBhfxp82krV@sgarzare-redhat>
References: <20260719220103.684489-1-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260719220103.684489-1-phind.uet@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ad9eLAA6jwJizChXcktRefL1d1O7Ibqkth88MjYuDNs_1784535470
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jul 20, 2026 at 05:57:47AM +0800, Nguyen Dinh Phi wrote:
>After vsock_connect() exits the wait loop due to sk->sk_err being
>set, the error was read but not cleared. This left sk->sk_err set
>for subsequent operations.

So, is this a fix? If yes, we should put a Fixes tag.

Also, can you describe how to trigger the issue?

Because I see this in vsock_connect(), so I thought it was in some way 
already handled:

		/* sk_err might have been set as a result of an earlier
		 * (failed) connect attempt.
		 */
		sk->sk_err = 0;

>Switch to sock_error() which atomically reads and clears sk->sk_err,
>so the error is consumed when returned.
>
>Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com

Can you explain how this patch fixes that issue?
(this should be the first information to be put in the commit message 
IMHO)

I'd like to understand better if this is a fix of real bug or just an 
improvement to the code (which is fine by me).

Thanks,
Stefano

>---
> net/vmw_vsock/af_vsock.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 622dbd046799..43eddc33ed12 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1847,14 +1847,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
> 	}
>
>-	if (sk->sk_err) {
>-		err = -sk->sk_err;
>+	err = sock_error(sk);
>+	if (err) {
> 		sk->sk_state = TCP_CLOSE;
> 		sock->state = SS_UNCONNECTED;
>-	} else {
>-		err = 0;
> 	}
>-
> out_wait:
> 	finish_wait(sk_sleep(sk), &wait);
> out:
>-- 
>2.53.0
>

