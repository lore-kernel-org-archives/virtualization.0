Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA963242BC
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138319; cv=none; b=TAJLYBay17XA+pxkpIlS8b6gi35vrA+q0aUtn18MZgqXC8VPeXHHLKV1t5WCwB0tnMHkp1nG95XJsSrmueXmP/HU5+7Qaf28eDQlDz015d98oW7VLB4a5gjm3Kq/StxdocDVXpV7eIrGvUFWxFEKOx+4+px+QXM02zUZhvX9Rgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138319; c=relaxed/simple;
	bh=ANgf7erO45M6z8OJhY8t3iY3rCsUya439h+4UicQju0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehNH2tCvB0+n4S3KRWOmmOKArQxhFUuX/Baf2QX8uM6EeyeQwXQFXpbZQTd+uP+PAVQDsvhMALr7/D3BJOjcCqmQeIC+Zprupe1ttoAVJcIDOugBsk0HRBWDw7kbeKn/FTyeYXwH19qPQbHl/TFm/84NL23DX5Xx/7xuqh3p5YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYdRryj+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYdRryj+"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so62398045e9.1
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 09:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770138317; x=1770743117; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5tYYcTG2h6gNGfOyutvveFDKr0sO2maCZCmLPcxWJU=;
        b=LYdRryj+S9pyikGBEbVmJ57qYQppLI3lRdS0K9+kNW5C5GIi8nA+zYsgL2/Xp95WK4
         rZ0Wf8ATRNhF1X5UKsnqrvHPM3Wq5WsLQNSLIX5dRtOA0aXTqbTD/hahp7k/+gCRHFhF
         oFGNqVVVXZ+YVGR5rYxn2vBSQDesWgtj9RID8fWDYKKZ+9nHH8T3G+rO5r51Q/bfj/zs
         xPccPgesfy24yIVCt0vbFgOWLl6R4r1tiX2KFRUeinro/18aQBruPVMPPgUWP/1BpUyD
         Byka7BGBrMgXTfGLNjsy+4QNje0AJHJpBz4lF92ZCErdJWW3+boVF52/2cllA2V+YCwy
         fzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770138317; x=1770743117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E5tYYcTG2h6gNGfOyutvveFDKr0sO2maCZCmLPcxWJU=;
        b=gLrE2ce7zerfsjidXCKumYDh4gqtoXkezU1b8+cGbXP80rsc1R/706Pko4EbkF3nov
         sqEi0EOW9zU4hj5Tej7vEI5nPlq+diKtPttw6Fo9GjCDmeAcmG70Fb57XvGWtMOy8ciI
         rwKAT+EQza9GaI5tL4zRWfDTTaXh0YbR5sz9orUFr1dMiamAgCQcEDFp0l21FRirwCFY
         3jNpaQjUb0sGN7RcCOF1RoGIZDiwkHse4IN+AOxx7RCsCJfAkIeK4INxy1Qs01LE0nGh
         TAqj4t5M+oYR5CnDqNSVrgXVWxcFuxI9zZObxpbGELQIedshtKAMSHxEaZhO29tHDEmF
         q+/w==
X-Forwarded-Encrypted: i=1; AJvYcCXqI7N8f+if6K6ssKbsMDmhbRWhlfHf/RYTpnH5p24MUxM5J1rnx+j/10155PEfwg48+BsS7rUQroOMXBB8EQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7SQ7XPrCYHbLQ9Vj6Y9XO7L1mnSxs6b314CpSiKuT1AwAAF17
	3yELTij7GuR295cSe4Gmlswa72lolDUt9YHuuBfzftcmcZ/dxXxRRW8l
X-Gm-Gg: AZuq6aICIkjqOh7pVbJYsnMVi1+7ELrps0ZvdbBxHvNOhK26yCMJgSo7vhxJjNhb7G+
	mlr6X6qvMCMgU7OAcbfdACz41HA8/p6O3qbBP0C6ltYyfMCzYOuRfoz+x4zaUhnF8gk5MOb6MJR
	AxRElp9n6W9yqV2lmDJp7EHHFKuQ8SFkjTyy8cOWrEviRWbBdfXKElSQbiYr2a9cN/PYAbfA7zk
	80MY3jwkwaxtjqX7jh58/oXOw1nTwUuhPJBqcOjH6VBXqO2zuWmf5HPNLY2Njqp0ylCG0bFlvqo
	yElFudtZvXmnKs/gYGTfNy2ycqR3oqy8ezwvJ/02/fAJrbTD3ka6uKd408LysMqAVKWaq5ejZiY
	E1PHU3a+l66ovJSJ2Yg47O0vPZ/Mncpg0jfAm/eaEkJsRDsPIKDFBhKqVaMHJcz2XbUzFt5gknN
	uXQKOZZRjBWdgYOCh6AGtCO8rgL3lJYC0HNVmpA6e+Us/kqzaCRbUF
X-Received: by 2002:a05:600c:8b0f:b0:471:1717:411 with SMTP id 5b1f17b1804b1-4830e97b082mr4293425e9.24.1770138316601;
        Tue, 03 Feb 2026 09:05:16 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ead1973sm2440295e9.5.2026.02.03.09.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:05:16 -0800 (PST)
Date: Tue, 3 Feb 2026 17:05:14 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Johannes Thumshirn
 <johannes.thumshirn@wdc.com>, Alexander Graf <graf@amazon.com>, Jason Wang
 <jasowang@redhat.com>, Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 "open list:VIRTIO CORE" <virtualization@lists.linux.dev>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] virtio_ring: Add READ_ONCE annotations for
 device-writable fields
Message-ID: <20260203170514.4cce4498@pumpkin>
In-Reply-To: <20260203065312-mutt-send-email-mst@kernel.org>
References: <20260131102810.1254845-1-johannes.thumshirn@wdc.com>
	<1770107244.8746088-1-xuanzhuo@linux.alibaba.com>
	<20260203065312-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Feb 2026 07:02:23 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

...
> > > +/*
> > > + * Accessors for device-writable fields in virtio rings.
> > > + * These fields are concurrently written by the device and read by the driver.
> > > + * Use READ_ONCE() to prevent compiler optimizations, document the
> > > + * intentional data race and prevent KCSAN warnings.
> > > + */
> > > +static inline u16 vring_read_split_used_idx(const struct vring_virtqueue *vq)  
> > 
> > "inline" is not recommended in *.c files.  
> 
> why would it be? it's a compiler hint. given this is the hottest path,
> it makes sense.

The compiler will almost always inline trivial functions regardless
of whether are marked inline or not.
So it is unlikely that adding 'inline' to any of this block of functions
makes any difference at all.

Adding inline to the wrong functions just bloats the code and can make the
code run slower if there are two calls near enough to each other that the
code would still be in the i-cache [1].

There are cases where the code would be smaller and faster if a function
is inlined - but the compiler chooses not to.
Those need always_inline.
Apart from some quite bug functions that shouldn't be marked inline at all
it would actually make sense to #define inline always_inline since that is
what most kernel code actually wants to do.
But a lot of the time the compiler gets it right - which is where the
guidance comes from.

[1] gcc has another way of breaking this by generating multiple copies
of a function for different constant parameters.
Sometimes that can make a big difference to the amount of code - then
it can make sense, but sometimes it just means you have two almost
identical copies to fill memory and the i-cache.

	David
 
