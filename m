Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6382D46D8
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751541897; cv=none; b=LSXPS3cKulOZX3jlu0PsoyRJ5rpnQdv12To3rY8ur55FSXg4Y/OEPCJWZUcrF7exPtHs3Y0kpAcP3uyflCm+tkv1HOsWQqWIgWXLHIYO5elcnKN3yfEmxyvKOpJWktt+nf1v4zgIwYB/eMy6A+KQNY0lXDBOq5R874lb1scrFec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751541897; c=relaxed/simple;
	bh=BsV0eSUAnrB3wda6T9wzig3D/sNdr+8qBzppAP467XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dnLe0CSvu4Y9hzlV5m8BKkNNc+kwoHjRG4JkkKuykyziMiMU1Q2HVella/aL5Mi8C9x9dHp0BgOHiQfLz/b6dNp14PTVUOCjzfL9x4fIzaE+UAinSFT4qQuszCKRxPpwYb8iIbHbriKz6HJJSC3KMMTaLw/MT+ewSwe2Md31nz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKWn5ARH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKWn5ARH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751541895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9Ys+B0kKW0I1OmxDH3RChxDm9/AfOdFHpxEknTEX7s=;
	b=UKWn5ARHmQ9AO9G3hZRhtpm5gPe4z0r9vdj/UXxBusXHHd1vvjMrSlYhG+rO50pEzXhxPY
	drD2zf5lOcjmtwtzDvYPOOH05UODaKQs6XWf+rOauqNVcMxWbs/CvhZL17jCXHg3EooMPF
	f3B/QAye2EvYzPwFVVhqppGxYUHD/Q8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-Gbu5n8G3PRmLgNto9AGffg-1; Thu, 03 Jul 2025 07:24:54 -0400
X-MC-Unique: Gbu5n8G3PRmLgNto9AGffg-1
X-Mimecast-MFC-AGG-ID: Gbu5n8G3PRmLgNto9AGffg_1751541893
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-453691d0a1dso31306025e9.0
        for <virtualization@lists.linux.dev>; Thu, 03 Jul 2025 04:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751541893; x=1752146693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9Ys+B0kKW0I1OmxDH3RChxDm9/AfOdFHpxEknTEX7s=;
        b=SEM7cEal5PQti7P1A+eKLa9uMKLWP4xLXsKFn+CHBwGv824nfnxiaTpz8PoVOEgix8
         wlGYJb/FZVp12xRB2v7cu3/N1Ww15ClhGvVll39h+28JtWvlW+6lAfw5G8lyy84hh5td
         trvTxmictG1EaJ/PNzSM8uiMVgKKDYWhLOS2aNU6m0DXu/inpsvMykLHCpPgOdJfHMyG
         P6BMKIpWevQOA61V7eEyGa45Gr9e3eUKEEyTLM04CpvRRx0nxGSm5aZwVXYyM+ktKlsi
         YhNDZbAPznpIOu+til90EU8eXoSApUkHR+JiIdWX2yanOapoh+DTraN2+7RinSHL7uv3
         A6OA==
X-Forwarded-Encrypted: i=1; AJvYcCVVUUBMDEm+ck29yHF7lGrayhbSW//GBwTKP9hxAGGnMB6+SX5JIDKmrSVNEzzNcMTTxnV7hBv0oRts2Pro5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIEJIN3rTZyKLYaIMSi32CmpiUuDwf6pCM4oCnwi9bPwEyC3pE
	HNQkklbtfuD0pxR6xUF9oTbjfx/Z2S3ocLPzMWpmeD+xvzWr9RSdlHeYW7Hb10TfNqzvs7aa1Mx
	Y1M/bk6nYOZ1ADlEwiVFAFNNQwGjfQjuCuSGGTjSALX2HgN6JVSKgwoBzRCf32cRZhoHK
X-Gm-Gg: ASbGnctDnfkZYDzBMPqqG4PN5u9I4xlq2+mo14B/ArpS1zkSMXa/DTgW7+azpxNHqLY
	8YX1OlMCR6rbku4acwMp7KlJaBPTpDPgN6A91FJgNwl1BC5yJmXwszLarPnIi5fXi8p8lEEzVPj
	1pXjv6M133EK1tzNibIhQLLEjQg8xYY46JgpNvquxTRFeEqhjgr1uiWK4v6/Nj3wLLmlNGyoMFD
	x5yiDm+wyMo51OYyH3/VGExk22hkztaYFGw6AcK52MxSJmchB5yTn2Fe0UXhz3diYC528lpVJ0j
	RGm1DZUiGuyyiVeT
X-Received: by 2002:a05:600c:3b9f:b0:453:6b3a:6c06 with SMTP id 5b1f17b1804b1-454a4311ca9mr61059075e9.29.1751541892608;
        Thu, 03 Jul 2025 04:24:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ4owisLty2PWAU9CFlsOOvJcG4PRg4iHjZY5ASRNKjngFo9l8E2RNGlgQIxnBwYpnCVU+kw==
X-Received: by 2002:a05:600c:3b9f:b0:453:6b3a:6c06 with SMTP id 5b1f17b1804b1-454a4311ca9mr61058815e9.29.1751541892171;
        Thu, 03 Jul 2025 04:24:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9978c83sm24183675e9.13.2025.07.03.04.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 04:24:51 -0700 (PDT)
Date: Thu, 3 Jul 2025 07:24:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev,
	bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net] vsock: fix `vsock_proto` declaration
Message-ID: <20250703072443-mutt-send-email-mst@kernel.org>
References: <20250703112329.28365-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250703112329.28365-1-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VCqW8VfiHEdYqZeeXlKYgjpIDqJ4QB4BLYzHAwK7WqM_1751541893
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 03, 2025 at 01:23:29PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> >From commit 634f1a7110b4 ("vsock: support sockmap"), `struct proto
> vsock_proto`, defined in af_vsock.c, is not static anymore, since it's
> used by vsock_bpf.c.
> 
> If CONFIG_BPF_SYSCALL is not defined, `make C=2` will print a warning:
>     $ make O=build C=2 W=1 net/vmw_vsock/
>       ...
>       CC [M]  net/vmw_vsock/af_vsock.o
>       CHECK   ../net/vmw_vsock/af_vsock.c
>     ../net/vmw_vsock/af_vsock.c:123:14: warning: symbol 'vsock_proto' was not declared. Should it be static?
> 
> Declare `vsock_proto` regardless of CONFIG_BPF_SYSCALL, since it's defined
> in af_vsock.c, which is built regardless of CONFIG_BPF_SYSCALL.
> 
> Fixes: 634f1a7110b4 ("vsock: support sockmap")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/net/af_vsock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index d56e6e135158..d40e978126e3 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -243,8 +243,8 @@ int __vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
>  int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
>  			size_t len, int flags);
>  
> -#ifdef CONFIG_BPF_SYSCALL
>  extern struct proto vsock_proto;
> +#ifdef CONFIG_BPF_SYSCALL
>  int vsock_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
>  void __init vsock_bpf_build_proto(void);
>  #else
> -- 
> 2.50.0

