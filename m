Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA6E34EEF6
	for <virtualization@lists.linux.dev>; Thu,  6 Nov 2025 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446250; cv=none; b=jeF3p6VcxQwJYQqXfsUAEZLtmp4oTuClW6dyTZiivfWeznU+ZgRZcvco0pezG51tMCu9G0umYOKEI5ozhFtXV1JdC56Nrpdz7+kU/Xoz+fKEBvep8nl1eq7l/6PVK/VxT4WDozSKU5DuHho+e8swHMAsr+fqRjZ4K32aBF8qMJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446250; c=relaxed/simple;
	bh=0vKjDbLZ5uIsJA1uwTP3kzZUDanfSCuXi6/Z1HKwKG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OfohxfWSfunruIvbZQhQINY/U+ydU9SdSuoJgjBMobh689aurIfjhDNFQUW1KJIdyghOvMXiO9yd270lPPrBBhVGFU6Pik/WiZvgv3vA7A9pm00r8TWmTF2lYuDsBElQlmR9DrNZfPPwRgoHAbEG7H89hpz2beu9+x+XXfGKi5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBi6CCRn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBi6CCRn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762446247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1DG4kG92g8zznE2M/rfvvdgAVk3otj7VoXSOREQcnM=;
	b=KBi6CCRnkBQYux57mT9fYKyyVuxOOWgHrd6L4GGlCo9ZQIBCqrsCZCmpYESrFzU41gihza
	DTUes5j7dSO7QPesoKqxtCLi1q4CiYTtNJ59gi929cxei9WiVPhMT3TFbSJrkVKGucN+fi
	XN2DOjTXbt8VqqgbYSSrAlz2yF31cJU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-zuLwadnWOU6bIPPNv8Qexw-1; Thu, 06 Nov 2025 11:24:06 -0500
X-MC-Unique: zuLwadnWOU6bIPPNv8Qexw-1
X-Mimecast-MFC-AGG-ID: zuLwadnWOU6bIPPNv8Qexw_1762446245
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4776079ada3so10621205e9.1
        for <virtualization@lists.linux.dev>; Thu, 06 Nov 2025 08:24:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446245; x=1763051045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1DG4kG92g8zznE2M/rfvvdgAVk3otj7VoXSOREQcnM=;
        b=Ur1HTNRmBpQq0w5326u1Rxv0AQWqI1bjR1t/2gTeIcN6HPMUFN9Z2cPtQH58kn+4hs
         R7P6sYk0JZT5E2gCIwjHSs/tRtWAxXiX5VbV7oy3bszcm6x7M56A49jjmQTl8ztQeOu8
         Cc2+EEXq3XtQ6wUA3hGrgJxdwORdsP4CZVJq2EAcwZETsajfIMFedwpZS18OyW9Ieqi6
         mmQKUKOeGkSg0qtDs/SESHqNQMjAtsFmHSYAbXuZbf5/zWEaPhnyQk+mhBRpy8fcGK5R
         l3Groig+Z4IVQv0zApFR7Rpg9b4LSSi9JRcoJI0mFh9e91QcyNvWNkSQ0RvTCilrs99c
         oIvA==
X-Forwarded-Encrypted: i=1; AJvYcCVf5myGvTYFo85PetzGj28ArRbjJE42hJZvGzFU+9QyO2Fzr96ibiwIqKQa8g8xAN+Ib4grh0RlUdLYfd1Sig==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyl6ReJOF97JmZPBC53dUFbgB0/gdjSe0JSbis+oDykggD7+bz2
	OJxIxrVXLmWB/BdmowN+4HqFUqn97mFcUXHO1uzRkq+VzYsTssxSLtUgBZXqXU5SvUbvqClU7/V
	vM0Ac8Kj3yJ+GxoI6j6hvAQOnstP/Xq969AyyugJGswjw2rbelwdn/zZAn569vVS6qjlD
X-Gm-Gg: ASbGnctbgekbGG6Y68AQXQk7jaQTFQDKvXQRQO858BNTepprPNR9weNBGpa3zlK3fpv
	2EBq/vRh838yhK0STGPx9e0a9e/cbnWuOKU5mRKY2jCjBZMOMIRtpsV9eWt3XZeiFCeIlOCAzPu
	dCEQzImHSA4rd4ZzGNXuk6s1EmJ1vpLC1DjK5cM8mTeTvz4Qxwqf/yPpMeAZNpnmNkm7fxFpgSJ
	YIC5HurjUF3WnYQBzQljkG6U0foz2e2Q86XsIsJX2LpWdslhWF+ZSRq0x9JrN2ZXq/NWOSPbGfS
	gwKtPYopNA9LSEnwly81c2kriOKIobwag9iXo2lkWZT+ApKm6TSwKU7j6iVo7lZf4B85Nw1VFgW
	Hcw==
X-Received: by 2002:a05:600c:5486:b0:477:5a30:1c37 with SMTP id 5b1f17b1804b1-4775ce9de52mr66234065e9.41.1762446245376;
        Thu, 06 Nov 2025 08:24:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0G1GMRMF16+MzLwvDgk0DmYYlo1r00tXQsnMrr1muBaVhluzHBbanGO0G1csDS3yewZ8H4g==
X-Received: by 2002:a05:600c:5486:b0:477:5a30:1c37 with SMTP id 5b1f17b1804b1-4775ce9de52mr66233365e9.41.1762446243795;
        Thu, 06 Nov 2025 08:24:03 -0800 (PST)
Received: from sgarzare-redhat ([78.209.9.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477625c2f77sm56342755e9.9.2025.11.06.08.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:24:03 -0800 (PST)
Date: Thu, 6 Nov 2025 17:23:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 00/14] vsock: add namespace support to
 vhost-vsock
Message-ID: <4vleifija3dfkvhvqixov5d6cefsr5wnwae74xwc5wz55wi6ic@su3h4ffnp3et>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <k4tqyp7wlnbmcntmvzp7oawacfofnnzdi5cjwlj6djxtlo6xai@44ivtv4kgjz2>
 <aP+rCQih4YMm1OAp@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aP+rCQih4YMm1OAp@devvm11784.nha0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y17WpzLv6xTpttIEMM4cRKChfhjaklENTWRLZwo2ofo_1762446245
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Oct 27, 2025 at 10:25:29AM -0700, Bobby Eshleman wrote:
>On Mon, Oct 27, 2025 at 02:28:31PM +0100, Stefano Garzarella wrote:
>> Hi Bobby,
>>
>> >
>> > Changes in v8:
>> > - Break generic cleanup/refactoring patches into standalone series,
>> >  remove those from this series
>>
>> Yep, thanks for splitting the series. I'll review it ASAP since it's a
>> dependency.
>>
>> I was at GSoC mentor summit last week, so I'm bit busy with the backlog, but
>> I'll do my best to review both series this week.
>>
>> Thanks,
>> Stefano
>>
>
>Thanks for the heads up!

I just reviewed the code changes. I skipped the selftest, since we are 
still discussing the other series (indeed I can't apply this anymore on 
top of that), so I'll check the rest later.

Thanks for the great work!

Stefano

