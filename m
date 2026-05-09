Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9A63B3BF1
	for <virtualization@lists.linux.dev>; Sat,  9 May 2026 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778355496; cv=none; b=Hcl0Vm8AeoK3f6p9lUfdbUh4WqdSDkkdlKBAg7/8AhiBH2MWpP4GiNqg10N7koGX0t9IvyCshZlm+3j9dLqYSOjHavjM0Mu3xAP1WgGAupDpcWvVQSLqcbb2z2KrCp0Uc98vaIoiCqEx98CCsScYRT4v3CGOQmNm91xRYo6kOO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778355496; c=relaxed/simple;
	bh=LJ8prTqaJOJKTib6YJYHS9vdeOjI1c4LQ/IGaYQNqtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IytvA/f7waZCUIxUf7+ZC4xu90W7F2zwM+bpmnbRYeOkelcg0T41q5OHIqxjpaw2wkSxSr6iV68UK5iHatpl3BhIHbSZcNP9ybchywiUltQ7tJ7mD8ZwGR8BEHDVQ732z/oLWGwLT8R/GGExDt40fcF5MpETqvZnPbYhPwRKO+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hyLnaIOS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyLnaIOS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778355492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ANPZRIsHdOb2XjLaWGPcru90KA3pfrVWtS2xY3q4MU=;
	b=hyLnaIOS3sDEi0JTu1cKcJiKUpmIFJVB6/oCXbF6NINqOk+NLJpJcZLIm/RFLHQhlKlgsg
	69b/kVn8kLHKaLgXhtfF31YpwnJFydLinSZj7MGVIENesNNw+NTVBC/OikkT1eQ0eS/dZK
	yAutCo3fWgsMyoFD/9EY3ncCzlcq9Bo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-Vq8aen0GPOC8VObeJFV0Rw-1; Sat, 09 May 2026 15:38:11 -0400
X-MC-Unique: Vq8aen0GPOC8VObeJFV0Rw-1
X-Mimecast-MFC-AGG-ID: Vq8aen0GPOC8VObeJFV0Rw_1778355490
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso18731055e9.2
        for <virtualization@lists.linux.dev>; Sat, 09 May 2026 12:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778355490; x=1778960290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ANPZRIsHdOb2XjLaWGPcru90KA3pfrVWtS2xY3q4MU=;
        b=YHdGpQnWb8MuTerv50YO8mB18tNkrVlbyvSh41Fus6gOqIUE4EV+TjFepTwPwip00n
         3faYLcgf7ePKDL8/55e/7uZGq81+mWn/u3z/KaRWlXODxLclp9cprpk1w21LWh69wXau
         KFriSvGQTKP3epnex7hZX6k1xlEwATP7LxPzIqOV7Js2X9rp5pIx8h2/sVED8Kv9v53H
         SUKPcJ2pcdxwXg0qZ/C/1/ocSbcpRCo9ASxSpjzUfD6qRWNB6sEZohF7w0PYJXDoxEiP
         npagyvNoKvRrP4mBYJpP1VdC7rxgAyJkTLtoPhkRWIJXuH9ySyH1WHFYNwLfiKqmE+b/
         dcpA==
X-Forwarded-Encrypted: i=1; AFNElJ9FEY4KwZW7G80f0RWE84hgg5LN/V3r0MTXHCUdLgRhctcVqhNYmXUn3AJQLEtyd5fHR6nkkKTFpikr1zfOxg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyas1iGbZmS/5T494TxwlcqOymJVDZEXpVg04R3cQlN6Xude1vm
	duj22RJ/9VVum8Sdnyc3W8MAcbHVR3CT6tzBLo3F+2mkencMGCUuj25Sz2O0oDdjR1T5JYAlMnS
	yZIFs4CZ+E/SNANWntEFVLpjM8OPIXhkyb1eRI/RvNiW9uwQlcQamexeC66c8qhBW0Jzm
X-Gm-Gg: Acq92OEiVX19PZalVwcARlkrQ4H0U1m5hPJGfVJoDEH2XdAMSlemCXEkkHmtgyTVAi3
	JpTdtFkTOAMHUTncbZjHatKR6phZm7NRi477p3e6ux9wZG5jk3MbjrqDM8fgyTjb1hScivK6LVo
	zpZDQ2XHlUau7eU3MqCePYeAkg6+xavpFfYcoIHQI1UXSRex7RsKUWimDEYn2BITajMWO1S6QDs
	QJeBHMzOp+H3bWuhgQ7TLp6T9hFXsMM3YPB1qkYDN2QILy85CiNFYoarqY2prz/Lqasl3cnrXvu
	103HS5LtbSwPOqbRb+5JUC9o8tqZbIBzEQh5q3mpKbMadir3CGuyR0fyT1HlKy5T2e/CdLM2Xsb
	z6CkedfiVdRnauH5NOjo2ioeUagzGdKs+AZGdLoTG
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d2 with SMTP id 5b1f17b1804b1-48e635a1b95mr165361425e9.2.1778355489627;
        Sat, 09 May 2026 12:38:09 -0700 (PDT)
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d2 with SMTP id 5b1f17b1804b1-48e635a1b95mr165360785e9.2.1778355489118;
        Sat, 09 May 2026 12:38:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db0fed0sm28105665e9.25.2026.05.09.12.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 12:38:07 -0700 (PDT)
Date: Sat, 9 May 2026 15:38:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Yiqi Sun <sunyiqixm@gmail.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net 0/2] vsock/virtio: fix vsockmon tap skb construction
Message-ID: <20260509153755-mutt-send-email-mst@kernel.org>
References: <20260508164411.261440-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260508164411.261440-1-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WUUtBiNucbN4ktz0UYMeY2ZdFjSGS5DImuzMRcM6iMM_1778355490
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2026 at 06:44:09PM +0200, Stefano Garzarella wrote:
> While reviewing the patch posted by Yiqi Sun [1] to fix an issue in
> virtio_transport_build_skb(), I discovered another issue related to
> the offset and length of the payload to be copied in the new skb.
> This was introduced when we did the skb conversion, and fixed by
> patch 1.
> 
> Patch 2 fixes the issue found by Yiqi Sun in a different way: using
> iov_iter_kvec() to properly initialize all the iov_iter fields and
> removing the linear vs non-linear split like we alredy do in
> vhost-vsock.
> 
> It could have been a single patch, but since there were two affected
> commits, I decided to keep the fixes separate.
> 
> [1] https://lore.kernel.org/netdev/20260430071110.380509-1-sunyiqixm@gmail.com/


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Stefano Garzarella (2):
>   vsock/virtio: fix length and offset in tap skb for split packets
>   vsock/virtio: fix empty payload in tap skb for non-linear buffers
> 
>  net/vmw_vsock/virtio_transport_common.c | 47 +++++++++----------------
>  1 file changed, 16 insertions(+), 31 deletions(-)
> 
> -- 
> 2.54.0

