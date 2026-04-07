Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563CA33BBB1
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578599; cv=none; b=e+KDSqWLja828+1B3LEziVaGpGm7q7YZMB51JwMLSqq+kMxd9aGMic8ff0TP0e1f5O4I4roKt3uW3lMEmxXO0rBfmDiS95hFPLJ2IhYcNGM1yZEkg9Iw9qWT/xd+FyAtmSdH9M7sgH29nJsuP1Ew90MiyCmTa1BcnHtA+GipGss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578599; c=relaxed/simple;
	bh=L+U1IJoCmuLYVZDQUIYQpJvdtwxVa0fGgDt4MVAjdeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NTOL1u/y6sZk6RtFoMTY8FQyCSAV9LxrEBTEwDsTzKNb7mKKgRB5a3miUHfuxymfZdsjk8YEAYA5XtVLYOKij6K84Rk+OI+VGm0RAYYDpD/9UxO78BMhVYgKLgrqnhdaUg28CXGZDy5pv2RJip81rlVKiFiQBmrZ8dPuNtdFbhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhezOtSr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhezOtSr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775578596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAYf1W4xKvTyUMVZp1+fGH+3Vreaw6Q1Qt75LyHMYiA=;
	b=RhezOtSrJiybNxx4u4uuyfmL9nEA0PCdtT/SwUjWlI53of9Dj3c3anoO+xarQnR9aA07Yx
	QhPRJO3iXGfPl6gb5+z384jNkcIrbECtEkrEmbi8qJp6E1tnnxAC+OpS6n1tWWGIIeh/rn
	9iaKvagf+0qYIRoatuGW9stBPkM9Hms=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-Q_F5sVw2NUyBE0LyCeIyfg-1; Tue, 07 Apr 2026 12:16:35 -0400
X-MC-Unique: Q_F5sVw2NUyBE0LyCeIyfg-1
X-Mimecast-MFC-AGG-ID: Q_F5sVw2NUyBE0LyCeIyfg_1775578595
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b4987c698so1518731cf.0
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 09:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578594; x=1776183394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAYf1W4xKvTyUMVZp1+fGH+3Vreaw6Q1Qt75LyHMYiA=;
        b=IUCQALHj/rQ6pyPS3uWErJhYJ9dxzmysjc5RhsrCwfUd5CQSC0nul1O7dYJ+5KARzH
         yx4ovM0+flQ1WmrJ8oA23N9/XhM/5iLTM6z0b+eRtI4X68RbkA22bLQoHr4BB3v1ZrhX
         M9+pUBMbwMkikyR31h35GbHUyZVSnLNo0GwBTDZtDjDZbb4AAY/96e2gLtjP9Bj4ENhD
         jRKpQp68LEwTpHTfXsRP7uoIUqjGRcyEuzVHOas6iNzy3BPcncHubw3ER1CCX0FALYzp
         B4Ktv59QJQVIh63780YWI/9Dc+nOpKtHCRAbB0t3xbl2V3gGU6hvYGDzG+db3OSHMMhp
         6V2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvhWvfxnSc3zmph6ZKlmVmYH6yHZdKF8fy47znluLw2trA0qlEmWRsAVbR2uWV9rTkZqVIpr4Aer4wp97qAw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6c4uCAJA0g1so6qoS0vNM02CXpTAF82pNOj323e5exAirkxfb
	aIKRW8OCFWQU6zZLRqT4bz96/ZLANjYxQ4ArvH0K1G0zVrd76NB1RLhO5+tV4tIMHXEFVVbw3oX
	FxxMbWBOJHH/zL3qRZJx9YaKtCtWgQg+g6t+324D6e06m7dTk/jwHHQyfgLGYte0I6FtfWWl5My
	+JfsY=
X-Gm-Gg: AeBDiet6ZCyupwzasIFtpZ+vtg/7gUR/xpv8wcKM6HGSH9zxr1KzS57DyrStGY0lq9R
	137n5whzdTaNYYueWOW1yUfL02OPwJOzNH+orQDuVPMLlfA84jHzJqfUi2R9AAGF/RIsPJ+v7PL
	eU6BxxeVe8BysTYlGo2BeagHfaWHtWLKfTelM2zzE68gpP1CTFub34ilFwuoQoFr5/kCNTypAHC
	6SrCZm2V4jNjwnNue9kYBLpRG+2QJHX/1ILFRD5o1s83lLXk3JUOSi1EQu798dyQXRjpphAzcAQ
	AwRfCiC0n1qO615ssdHQA0P7W4HhbGqZ30IZ1ILDsI4eKAZ2Fx9fxLTA1Jm0N1xp5/pW8cPr1fJ
	qtCxNG3FhMUet
X-Received: by 2002:a05:622a:1e12:b0:50d:7ca3:379a with SMTP id d75a77b69052e-50d7ca33e59mr167476161cf.3.1775578594425;
        Tue, 07 Apr 2026 09:16:34 -0700 (PDT)
X-Received: by 2002:a05:622a:1e12:b0:50d:7ca3:379a with SMTP id d75a77b69052e-50d7ca33e59mr167475651cf.3.1775578593759;
        Tue, 07 Apr 2026 09:16:33 -0700 (PDT)
Received: from redhat.com ([37.19.196.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d9d449f79sm33302871cf.18.2026.04.07.09.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:16:33 -0700 (PDT)
Date: Tue, 7 Apr 2026 12:16:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Message-ID: <20260407121515-mutt-send-email-mst@kernel.org>
References: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nPakNNgSjCJ3ChsTfS5cKvbR17c_DrnXkhJtTrvHWKk_1775578595
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 07, 2026 at 04:31:56PM +0200, Luigi Leonardi wrote:
> `virtio_transport_send_pkt_info` gets all the transport information
> from the parameter `t_ops`. There is no need to call
> `virtio_transport_get_ops()`.
> 
> Remove it.
> 
> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

but I think we should drop the Fixes tag.


> ---
> I marked this as net-next material, but honsetly I'm not sure if I
> should have targeted net. It's not a bug after all, it's just a cleanup.
> ---
>  net/vmw_vsock/virtio_transport_common.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 8a9fb23c6e85..a152a9e208d0 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -60,8 +60,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>  		return false;
>  
>  	/* Check that transport can send data in zerocopy mode. */
> -	t_ops = virtio_transport_get_ops(info->vsk);
> -
>  	if (t_ops->can_msgzerocopy) {
>  		int pages_to_send = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
>  
> 
> ---
> base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
> change-id: 20260407-remove_parameter-f61a3e40cf90
> 
> Best regards,
> -- 
> Luigi Leonardi <leonardi@redhat.com>

