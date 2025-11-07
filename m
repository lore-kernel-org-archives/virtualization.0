Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3592720C038
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 01:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762477775; cv=none; b=Gm03+bwaZyxgkgYgu/xzTFe6+dZ3itZoX5s//yUBa8QzWKb7uChajJU2Ofm5FHOYPFfQXoJJIJG7fedGlwi5pJG/X6CNGJlB+ft8Mb53iPf4ZD2GhUj9uH2PfXcgMpNTOKJqokRlZ6YXZv/5+cwgrzLs/h+UJWlvwbC1eJe4ZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762477775; c=relaxed/simple;
	bh=y8GsXoMpZfP1FEGzB5PcqGcDnM/GiApM178nf5o2DdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uF4WFzXQXDkge4ZgR/ccw7dA8VqaZVgfK6W7RGLwayrPzevcZDk588PyCZP1dG7JHO4aY0ck+I2qH9tydCh3Ekfyg0UQre54WVCPfwBoyrA/LGuyF+GvB7Kn/7t/9DhguqsMBMelLq96v0ROSs/xwAdXJ7NjIYVuNOMBCSc5SL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgrFyxph; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgrFyxph"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-786943affbaso2125367b3.0
        for <virtualization@lists.linux.dev>; Thu, 06 Nov 2025 17:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762477772; x=1763082572; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IvUJ3GAHgLW25cDlFG6h0rQPjnjrIg13OTjYu0f9NLQ=;
        b=JgrFyxphhe2qopjzes8TzjYQ1gGAEoxb2V7YdzUNJqBwec9ApN5PrDhmjnbMbCyOOT
         L+askwe1E3TrjQPXjCLe6IHAAh58bxRCQukjGIPp3WgmZDoWawXP6OAEVzEYYR/iU2ZB
         RxFBAs+Qi6B6ZonAHtgOG8O0E3a+ls09sSVHxTXqojWRH0JnSblnY9wsi3UP0v9BAvCy
         G2OQgdeQjRhdeem28qkddx8FQjmWEK/HvgFiwEgwDfC6CCU8D7boq/wKhiFHheDeAlDl
         0n+M5BF+7yMJGo+cmVlfG+78ZbcUcS06etYC4UXps8gE7/PiRHtJfLUc/QQ7prQxdVej
         4/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762477772; x=1763082572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvUJ3GAHgLW25cDlFG6h0rQPjnjrIg13OTjYu0f9NLQ=;
        b=iSTttvJma5BZehp+uXOiDs0M0+RV4boN6sjSfRTtYCXDkuDFrDN+lwYgyEmaTsI+cL
         4rnvwfWQDSCqQuAA8pacB4TKd9DAsP3oK3HzMh0l9683/C45+N8l/fiPuVazquBTd2vt
         3/GxD4ZRYJo5T19Wq0AGFziz8mmP7Mg0xorEKkwz//uwRIdDMknIamu3j2TvwNu0g85F
         3y0RMKOHPGqMS3ffuFXKbQhdSjn3mP07tdUwAR9nopr8tDVz9XcULKShL5W5LyHf73+c
         vL0co1d6S/lCTdW/W2cj1+abjf0YVy17YJohpTEiSfCpx3c1hGv1C3/ucyjkJH5VTuen
         l1fA==
X-Forwarded-Encrypted: i=1; AJvYcCXILMJl/BS1qKgzPAzrgOfJgAkLgADAsAwn4ku64c3HYGCySkVoQzL9wW39DcH/ZhUy+lAb78uDjKcAljIGrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTTHh498wZKJyO8NpYaTuiqFoKEmyC4A2ApBpcEw9krKDd2SA8
	fz5ToUeCKGxevpAeG/wuVrzOs2BQBq16lk8sHrW6ezy71Gw58GCnyXrG
X-Gm-Gg: ASbGnctOMd6xYQRgHolNV9E+XL3ZWiJIG8BxECkCc/lsmSBJeFvo3LIo6kG1MZ3w5lX
	YqLbvVECdQuJluo+Y8k1So9GFoCrcJUDtLIyTBZmr5mvunOn37YebhW73GOO3TQW7xF7n62924d
	TZbpvTVawhx2RhmQH9JQ87pvsyOw5poz7TGWhHFjGXqRJkV05oyqI1+tT5drD1RiVC515BfXrtA
	CyCQFQHNprEFAkJIgWhPYM/NxxulX+w+FIcfHtB+rUGd08AOFiKMViyDhPSuP9s7wtNbJyuay/8
	2KyeCgPJ47QpMR2YyA0SEWuSMJQtuk919A3fFaTrZ4vulaBJFgJ/NIgvOuup9O+1NSoMnmYfIFD
	PgvE/yG6oX8gTlWz8h0hi8u7HkPXPM7jA2wrVSutCJuMP1rMLX4c01j+A27PX68XdQ3JNDgG0oG
	iLSH+BbeUFxR+OptdLC+/9Hcctu7KkdKsEkX2I
X-Google-Smtp-Source: AGHT+IGIiNSL9xH9R1nGKHm9qDA5dUwel2Gn4NDFwi23AY7T7XKy/BbtnkHOptWZ8jTsfq60FDuFzg==
X-Received: by 2002:a05:690c:6808:b0:786:a817:77a0 with SMTP id 00721157ae682-787c5346349mr13381347b3.31.1762477772177;
        Thu, 06 Nov 2025 17:09:32 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b1598d0asm13031717b3.29.2025.11.06.17.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 17:09:31 -0800 (PST)
Date: Thu, 6 Nov 2025 17:09:30 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 01/14] vsock: a per-net vsock NS mode state
Message-ID: <aQ1Gyp87UYnr/VAO@devvm11784.nha0.facebook.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-1-dea984d02bb0@meta.com>
 <iiakzdk7n7onhu5sncjd7poh5sk34nrtvusbiulsel5uswuekv@p2yzmblg6xx7>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iiakzdk7n7onhu5sncjd7poh5sk34nrtvusbiulsel5uswuekv@p2yzmblg6xx7>

On Thu, Nov 06, 2025 at 05:16:29PM +0100, Stefano Garzarella wrote:
> On Thu, Oct 23, 2025 at 11:27:40AM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>

[...]

> > @@ -65,6 +66,7 @@ struct vsock_sock {
> > 	u32 peer_shutdown;
> > 	bool sent_request;
> > 	bool ignore_connecting_rst;
> > +	enum vsock_net_mode net_mode;
> > 
> > 	/* Protected by lock_sock(sk) */
> > 	u64 buffer_size;
> > @@ -256,4 +258,58 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
> > {
> > 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
> > }
> > +
> > +static inline enum vsock_net_mode vsock_net_mode(struct net *net)
> > +{
> > +	enum vsock_net_mode ret;
> > +
> > +	spin_lock_bh(&net->vsock.lock);
> > +	ret = net->vsock.mode;
> 
> Do we really need a spin_lock just to set/get a variable?
> What about WRITE_ONCE/READ_ONCE and/or atomic ?
> 
> Not a strong opinion, just to check if we can do something like this:
> 
> static inline enum vsock_net_mode vsock_net_mode(struct net *net)
> {
>     return READ_ONCE(net->vsock.mode);
> }
> 
> static inline bool vsock_net_write_mode(struct net *net, u8 mode)
> {
>     // Or using test_and_set_bit() if you prefer
>     if (xchg(&net->vsock.mode_locked, true))
>         return false;
> 
>     WRITE_ONCE(net->vsock.mode, mode);
>     return true;
> }
> 

I think that works and seems worth it to avoid the lock on the read
side. I'll move this over for the next rev.

[...]

Best,
Bobby
