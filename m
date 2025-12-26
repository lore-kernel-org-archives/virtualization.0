Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538B94A3C
	for <virtualization@lists.linux.dev>; Fri, 26 Dec 2025 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766734670; cv=none; b=uqIxGh9In/0sbLpv9NT6oEoqPmWWgmTspVTU44NhyvTI0GVDBYu7mmMICAWGMIraPIziJruu65SZHxxV5Dn8qjCBHgbbbdsBkrVFNncTX+hVI0yiQi+gFv/EKx3pTFxW9h5sF+hmzS9S4LfLoKZvsPwAcO1VJt9epfm1txrcWcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766734670; c=relaxed/simple;
	bh=0rmvrB0jFA9AqaRU7FDxlBBzIIKJKv2DCijQxPr9ssk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nh6Afwvke9+0HErc2M4KUmacZFk3KiYbCJowQLP2i8oFF4KY+JgzxkCm1fLFQisM8o+hHjTgLj7kwsawwVAiC8qUQvRLOwMXkZIGbA1o+N5+ezWQm7FaoIQ9cDiUCytSSEERpU5W2K5tIS1vwPj3ERzKHD4LZ/OGiR4D3ksMK7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbB7AuTM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbB7AuTM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766734667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUh1KaOXjv2HvFwemQznNzF51XENR9Lh865zEQseUv4=;
	b=CbB7AuTMlsg6cj5qvAMo5StUAHfZuv2yHKqxN9BMgBT+AuMQXQacOBLSDVnH5vru9aycwg
	ULY6Uzxnr7Dp/yZu9XGqVe10kkUCz5haLZKoEakKxKYFd93POLROpB7VOUTKC+EDtghrTy
	55smT0tfcwgoU2UDNqGWQmYoEUtL+aw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-O1GfWQ6POeieN7g_lO7F5g-1; Fri, 26 Dec 2025 02:37:45 -0500
X-MC-Unique: O1GfWQ6POeieN7g_lO7F5g-1
X-Mimecast-MFC-AGG-ID: O1GfWQ6POeieN7g_lO7F5g_1766734665
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so53586495e9.3
        for <virtualization@lists.linux.dev>; Thu, 25 Dec 2025 23:37:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766734665; x=1767339465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUh1KaOXjv2HvFwemQznNzF51XENR9Lh865zEQseUv4=;
        b=SRN3G15XPwNVpaBRehYqyzT3zbRa6P9Pit3/6rN9tU9FOTW8ABjQSyeWqjI6Et7GmS
         lk4RI6Dc2GgKAuIIZ2zfm6ah0jwd757BfhB1KawZZIIwTntnuitNIA47A9Yj9tDDzv/N
         fSE8Z6jdt1LXqBZLGzP8nrU8E0/LH4fhP+Xujzx31iUNg9UJzmyVT7By/SitK1kgKeaL
         qJpSNjjzKbWIpL0YKxHyTt79d4K8Zyb/IOzHgseE0qF9/rqptE2yx07LNVFsOFfbm5Ms
         EfWTRt3rY7xKz8iRTwApW0O9GwESF12B8j7hKxVixRbpAVYcGkwWXhcCaU3qU0Cr4Y2q
         PH4A==
X-Forwarded-Encrypted: i=1; AJvYcCWAQU6O3le44sLGysrNHkJVps351KqhFn9gENYfRv47DLG1FOn3MptKIFfcds31tCTEJwNSrto7tYjLTE2OpA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywop1EIKEsdIjGLT41Nh+rNauFVxg5sZ9/b8hQMlsuUGcBolvGR
	J1pAV91CT6eWUP2z4rSsEaaoGXasTWcDkaxwDVM9slUb8WMyjaw9r20yeCLRrY4AtEgsX5Yu065
	Pa4V9jDaVBxzC4tNtJCz3M+W5QIGlHZhXvO70e6KdYsH4JS/JDdf2SyfCk+yqPxLXltkM
X-Gm-Gg: AY/fxX7pddzz2jG15c1hLxzgBqpMtlfaIHdZkeVnsA9N2V245Iajpri/ABgTUUKXATC
	MxQBorTL7qyeJpEHauBj96IkcZ/UwujU0Ols4UE060s6kI88d/K5quBY1nHKlMVPEqPZGbT/SVq
	YoOxIccU2RplKXJBJPoco3Mcv293cLVGh7VCiHCnnylhpLOmDMMq7RTMbYIJFFCQtb2P9g4dIsT
	rTlDRv+81c8It5MSceygMRVK+9XhxPQkK4JX96XnY//F0ZEDZmiTYRz5kS4TWeulqm+B2VoGMns
	lE+tuFMAP0Bc1iqJkXLdfdknihdoCPYySZfBC13aJWrqCPZo55uY5WuEuOuGCFjR4QDkG54YrIs
	FVu9TOZLnKhSdY35Qqa0oUYHFcW2HSwmk+g==
X-Received: by 2002:a05:600c:8183:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47d195a9834mr226258675e9.34.1766734664669;
        Thu, 25 Dec 2025 23:37:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpsFWjeude7gy71vuh6vSWasoySUpj/LvWEgjphgTCKyVNexu8UQ8V6vCGw/Jfq9ZpZj/RgA==
X-Received: by 2002:a05:600c:8183:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47d195a9834mr226258395e9.34.1766734664223;
        Thu, 25 Dec 2025 23:37:44 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193522cdsm363228075e9.4.2025.12.25.23.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 23:37:43 -0800 (PST)
Date: Fri, 26 Dec 2025 02:37:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Bui Quang Minh <minhquangbui99@gmail.com>
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
Message-ID: <20251226022727-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
 <20251223204555-mutt-send-email-mst@kernel.org>
 <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>
 <20251225112729-mutt-send-email-mst@kernel.org>
 <CACGkMEt33BAWGmeFfHWYrjQLOT4+JB7HsWWVMKUn6yFxQ9y2gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt33BAWGmeFfHWYrjQLOT4+JB7HsWWVMKUn6yFxQ9y2gg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nXQVspRC9sVO_8-EKX_I_09tZsrabNHbYqgjrFBnjrQ_1766734665
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Dec 26, 2025 at 09:31:26AM +0800, Jason Wang wrote:
> On Fri, Dec 26, 2025 at 12:27 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Dec 25, 2025 at 03:33:29PM +0800, Jason Wang wrote:
> > > On Wed, Dec 24, 2025 at 9:48 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> > > > >
> > > > > Hi Jason,
> > > > >
> > > > > I'm wondering why we even need this refill work. Why not simply let NAPI retry
> > > > > the refill on its next run if the refill fails? That would seem much simpler.
> > > > > This refill work complicates maintenance and often introduces a lot of
> > > > > concurrency issues and races.
> > > > >
> > > > > Thanks.
> > > >
> > > > refill work can refill from GFP_KERNEL, napi only from ATOMIC.
> > > >
> > > > And if GFP_ATOMIC failed, aggressively retrying might not be a great idea.
> > >
> > > Btw, I see some drivers are doing things as Xuan said. E.g
> > > mlx5e_napi_poll() did:
> > >
> > > busy |= INDIRECT_CALL_2(rq->post_wqes,
> > >                                 mlx5e_post_rx_mpwqes,
> > >                                 mlx5e_post_rx_wqes,
> > >
> > > ...
> > >
> > > if (busy) {
> > >          if (likely(mlx5e_channel_no_affinity_change(c))) {
> > >                 work_done = budget;
> > >                 goto out;
> > > ...
> >
> >
> > is busy a GFP_ATOMIC allocation failure?
> 
> Yes, and I think the logic here is to fallback to ksoftirqd if the
> allocation fails too much.
> 
> Thanks


True. I just don't know if this works better or worse than the
current design, but it is certainly simpler and we never actually
worried about the performance of the current one.


So you know, let's roll with this approach.

I do however ask that some testing is done on the patch forcing these OOM
situations just to see if we are missing something obvious.


the beauty is the patch can be very small:
1. patch 1 do not schedule refill ever, just retrigger napi
2. remove all the now dead code

this way patch 1 will be small and backportable to stable.






> >
> > > >
> > > > Not saying refill work is a great hack, but that is the reason for it.
> > > > --
> > > > MST
> > > >
> > >
> > > Thanks
> >

