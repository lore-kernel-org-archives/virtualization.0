Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D30B40FD89
	for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777378542; cv=none; b=ep1NumAR+XUP723QCGtuPMBHO2rBwZ0Q5vSYiuWdZLO3hYGwbjoCu1bMOH00ZGX/RQwhKA2JboZiVssQRwD7EpxoexBrgPjVK0wfflOHNhDMMsSlHetzbtuKBESXNK8tC8hoBrabGUjfsD7/dKudSk4ikM0vnnY2JAtGv85ltko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777378542; c=relaxed/simple;
	bh=s59HQ/z0DRUQxzWAOS9RZKTQ0TksCpF9LL3RKo4XTR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ui3dmlCoTc0z50mVi68Tu9uF2k6zyVnqymSWh3WqcSSnt6x8L232B2+GCn6HYPknlt9kHiZNIS4fVycvbkjeO/ywv0OEUVUzi4BOpYCAam/iLpD2I9Gwu5SP73pzQG+9hXS/MH/MqQK+vLINaFOauPScSl8vuVSa+6Sst9wfn6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MB2bK3Gj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MB2bK3Gj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777378536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tK5HQfADPaU9p5E+7yAgbo7JP8UVnZzs4QHnbuo5QyI=;
	b=MB2bK3GjFtxL1pdvdvlw/xFUPrvqZwi2rPSkNqIF+jCqv98FFNJKr6vWEMdnUCpx1Tkjcs
	ewFyz7hCJgetsiYiyG9gvI0fwp07Sgf2CJBa/CO538TanwjUz8mwJ23D5ime6Pjiy/g1yK
	prVn0n5ekcQF9Fbqe+v6B1BwbQd5KPs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-2UIteJ3HP4aEPauneYDUng-1; Tue, 28 Apr 2026 08:15:35 -0400
X-MC-Unique: 2UIteJ3HP4aEPauneYDUng-1
X-Mimecast-MFC-AGG-ID: 2UIteJ3HP4aEPauneYDUng_1777378534
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488f973ddfeso83957135e9.3
        for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 05:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777378534; x=1777983334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tK5HQfADPaU9p5E+7yAgbo7JP8UVnZzs4QHnbuo5QyI=;
        b=MpOEtUoP3iPsBZ/2s7hEabQPqDkeoBvrw6pxpGEQlzdzEcxmakFfm5Yw6s53CVe+ZJ
         H04ZslNojNzatcsSC0kjLXvDpUtvknMDIQ/ZJEgFW0J4z5jyX5z5cYSWanRn/MrqLlAH
         7PaoKZBTbaSlXTuEZiz21aSeWhFRtgjgMejU14j1jENA9ng6YHICEECwZDhe1ML0Dhgj
         7ZJ+EtKvizGTL8Jto+zNbRL9mqp9sdTF4wtrsYjFd89iiXQnC/eklZzvxxoCA4y1L1hL
         HyDNoW6t3cjXhKaaNF9X0XRyUps8THF+x9wjOOFzJKqCNgBO7uZnGLzBxAoTLc7G7hxR
         uReA==
X-Forwarded-Encrypted: i=1; AFNElJ83qqwKJeeRfnRcB6DoQ6iutmuEPfcl5dg01PqBK0l0uYIkTfFRPJpNMqGiSFPwb2hsC6je50CSkERKEbm+Gw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPowgDZV9IL/0L+7NhiOnBTK1Hh7RKMg/RkOptAJC2ZDVaxn4/
	RhQG4f/bkzGuXjVNwuwa3FTuEqflR1EeZ3LKJc3MKdcgr3i9mu0QCYFFSIXvWVw/rA8D8xywG6h
	fqKvFj5bs2xHGAfS0oYTpWeDEyxGoh9tEBFyC9tuH27qZsm/3WSp1iH2gm65pPf+o30aA2x/wEl
	rE
X-Gm-Gg: AeBDietgs+1jL2wJgRLvzV/IbfcS4gcUJ7ZyTKwuTNOhYQwfhKaWiaDP2z9IWXEFi81
	I5aEhMDKJB5b8DmqkqI6oiPlzaXthohYAB3Y8b1Z7hPq2y6fi7NSEt0HjP3h9KrupS8FuTlmOvs
	nuk5uSPzFcF82DAfjZhC6WTnZ6GFS/o5HZL+4EzMip8KCrP7Gy8WdsTK3ksiVh1Ov/8VNGYTjWC
	bbHM1liNWz0uNyG8bdq38RL8c1zZRdhFpCFnkjLSuK4cpKT5m+V+HaFqH26FTizm8TgpRM5+du0
	aMeKox33aPe9c6yfrfagFWRH8DEKsFPPtdGwy83BEqIb6rd1Af1SAVrxzez8+a/AD0Ygn/8fSvH
	1g9ngQvhVxluWe8x6+UpSsRvQdHMneHTTKMNJaYrkWB+vO4NnhjExjNX10UWlus4T0/amNqMh0Y
	M8vgn1cg==
X-Received: by 2002:a05:600c:83c3:b0:489:1ff5:edda with SMTP id 5b1f17b1804b1-48a77aee45amr48089545e9.6.1777378533927;
        Tue, 28 Apr 2026 05:15:33 -0700 (PDT)
X-Received: by 2002:a05:600c:83c3:b0:489:1ff5:edda with SMTP id 5b1f17b1804b1-48a77aee45amr48088625e9.6.1777378533314;
        Tue, 28 Apr 2026 05:15:33 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773a87bfsm64239235e9.2.2026.04.28.05.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:15:32 -0700 (PDT)
Date: Tue, 28 Apr 2026 14:15:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: netdev@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Michael Kelley <mhklinux@outlook.com>, Himadri Pandya <himadrispandya@gmail.com>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@kernel.vger.org
Subject: Re: [PATCH] hv_sock: fix ARM64 support
Message-ID: <afCjpGa4Xm4hIPj6@sgarzare-redhat>
References: <20260428110530.1717647-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260428110530.1717647-1-hamzamahfooz@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OEZHB1lPkq9vSGCLB2MhlPpT4Th0Cd9g_1NAoZxBxSI_1777378534
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Apr 28, 2026 at 07:05:30AM -0400, Hamza Mahfooz wrote:
>VMBUS ring buffers must be page aligned. Therefore, the current value of
>24K presents a challenge on ARM64 kernels (with 64K pages). So, use
>VMBUS_RING_SIZE() to ensure they are always aligned and large enough to
>hold all of the relevant data.
>
>Cc: stable@kernel.vger.org

mmm, this is the first time I've seen this address used for stable. Even 
after searching in the log, I don't see anyone else who's used it.
Where did you get it from?

 From Documentation/process/stable-kernel-rules.rst :

   To have a patch you submit for mainline inclusion later automatically 
   picked up for stable trees, add this tag in the sign-off area::

     Cc: stable@vger.kernel.org


The patch LGTM.

Thanks,
Stefano

>Fixes: 77ffe33363c0 ("hv_sock: use HV_HYP_PAGE_SIZE for Hyper-V communication")
>Tested-by: Dexuan Cui <decui@microsoft.com>
>Reviewed-by: Dexuan Cui <decui@microsoft.com>
>Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
>---
> net/vmw_vsock/hyperv_transport.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 069386a74557..40f09b23efa3 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -375,10 +375,10 @@ static void hvs_open_connection(struct vmbus_channel *chan)
> 	} else {
> 		sndbuf = max_t(int, sk->sk_sndbuf, RINGBUFFER_HVS_SND_SIZE);
> 		sndbuf = min_t(int, sndbuf, RINGBUFFER_HVS_MAX_SIZE);
>-		sndbuf = ALIGN(sndbuf, HV_HYP_PAGE_SIZE);
>+		sndbuf = VMBUS_RING_SIZE(sndbuf);
> 		rcvbuf = max_t(int, sk->sk_rcvbuf, RINGBUFFER_HVS_RCV_SIZE);
> 		rcvbuf = min_t(int, rcvbuf, RINGBUFFER_HVS_MAX_SIZE);
>-		rcvbuf = ALIGN(rcvbuf, HV_HYP_PAGE_SIZE);
>+		rcvbuf = VMBUS_RING_SIZE(rcvbuf);
> 	}
>
> 	chan->max_pkt_size = HVS_MAX_PKT_SIZE;
>-- 
>2.54.0
>

