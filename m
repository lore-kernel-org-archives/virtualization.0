Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918A8233D88
	for <virtualization@lists.linux.dev>; Sat,  3 Jan 2026 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767431599; cv=none; b=PYHDf0oXhBMzhFkcdlhsAUUwu4aYMPIZ3IbKt0k97bmELeisaBQOim85fRqEB9mmEP1bgjeg41dwjfO/MlX0i8lHpdRFxociylD7VqcbpmbuI7NzFse+4+l0wYHV3Vvc+cBuCG/f7qIhOQ/2vtVLO//0ODTXe5sqt8bS4Gyj4kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767431599; c=relaxed/simple;
	bh=D2JUwaLgQPVcFVxnKAJxg4vCYvDrhyAGsjt3mPC1zq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sBerhnU46Fos2ww0bQVa+p+7hWJglS0TmYTqoF9eGlc89V468fzDPn/KDKL7WhLDMUh9wM0ZexYsk7Yt+0YEFvzwJI7p4Z1ELTJnJCqmI+DhipnhR3ak0mg3szQ+aKX5w+hv2gveUBdNjc1k+Xe4ToGFHZtMNqdlQd0uYZbJGJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWG7YkCF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWG7YkCF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767431596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Hb8jN/L6fYCR7fWSSvv5cBYqP1P00Le5VoBUo+rlAg=;
	b=PWG7YkCFXoMSJy7ghk1BH/BrbrhNfsQia/RyudIOFjSz2g9ua9Vr1yTp9exalFoAQr72t9
	motspI/nHiLpS0dBcRLDtxFhihWymbi/K2R8h5dgNdXaVZ/sR0xJItiZSDi2xCGSBmeLRZ
	i2WMvo3JHD5N/NJRgsSUPR7mHny+fM8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-_Zigb9-XOYOypkYi4Lb1Uw-1; Sat, 03 Jan 2026 04:13:15 -0500
X-MC-Unique: _Zigb9-XOYOypkYi4Lb1Uw-1
X-Mimecast-MFC-AGG-ID: _Zigb9-XOYOypkYi4Lb1Uw_1767431594
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fb8d41acso6594835f8f.1
        for <virtualization@lists.linux.dev>; Sat, 03 Jan 2026 01:13:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767431594; x=1768036394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Hb8jN/L6fYCR7fWSSvv5cBYqP1P00Le5VoBUo+rlAg=;
        b=m54e+uoZ6fyOqqZtlG9V+zkDTsG5lpYOT0YlDWGx38IIB9+hg1z+D91rFurxuk3NWW
         LihM11BivQLmkjtppAm7QqTC5yULYTmtPLGa996sDnmK0Zy9++oH2qjPqqF8dKKS5tCJ
         2a3ZbiKLXMgwH9cJbCXjV2FAESK7Y+yVSnaTY5B1sxxIf1ZCBJu+buJdLgXARsI/SWBs
         AW94oTHpHZjtfG3RRMPHfdDecTTrqRMHXg5GYnRQxHY2hlpeqNcrNgEl45K6CghT299i
         XB956jWMSDlT3w1iIo4m2VZt6Bmiz5cHjaDbQL5YOq+nGP1f4ixHISGSWj1J7KXXaWHh
         Ksgg==
X-Forwarded-Encrypted: i=1; AJvYcCW2HNu/3bYuqbWNAYFgsogPkcAtyBG0riPWdC4gh+moHpuwKVcPUFv8asAlmCbllDp/2FjtZxoHz6WogUTwOg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyvu0oIo9nRKbbPS34BUn5iQV04XcWppdxeSoXTCuDACy2XEwtS
	rZgSJFKfluw5BlCvbD+l/G7SM5/vG5tW7n/6UJ60s8niOAU76FEMssh20Izo5q84u+mSe+bSXlh
	P8KVeBF1uccGmMNP+bUgyFOhvshSCUP+riFPKf+NcjIM2DqqbH22pHe/6D+ND5cpKggjC
X-Gm-Gg: AY/fxX4A5/4/an08W7UY4O0X+Nd/KoX1at6jjRIOhUJ+eEqmuMLCe7hRBXid93McXJE
	+O3IIXnC4nffhxrSFNIJ4Iu4nrZvPYT6JNCD6y1Ua7SW0wF4p80scaKF09gsHLllUEg0xukvq03
	fjklhvPhKC1jW+n1B35A+r8+T6pmUKeQHHxdlwCUqNlfqJpsTmmh242hm82oOlrhneq1VkgOil5
	dLp9woQ8bQ/WyYJZHXVROO9dd/rLeImxm6uxVe4Szt6pBatcV5TdCI2oBd0LbLnXO/IRGlUm+Qc
	c7st0PasUmgiVI9mAysL/KR4I3bWDBUdfirGsuGtHPI8Z0wKozu2AjpMlazJcHK3WQEJ5G6z1R2
	MdvfCOw==
X-Received: by 2002:a05:6000:40ce:b0:430:f2ee:b220 with SMTP id ffacd0b85a97d-4324e4cb94dmr57084916f8f.19.1767431593696;
        Sat, 03 Jan 2026 01:13:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE26GgQLEflvynAD5o7MsvyW4N7h1D9HT11b4Oml4DoyBao3uW+BjntwVayJEJqPx+C7BOcZA==
X-Received: by 2002:a05:6000:40ce:b0:430:f2ee:b220 with SMTP id ffacd0b85a97d-4324e4cb94dmr57084882f8f.19.1767431593183;
        Sat, 03 Jan 2026 01:13:13 -0800 (PST)
Received: from redhat.com ([2a06:c701:73d7:4800:ba30:1c4a:380d:b509])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4325b6bfe88sm80644627f8f.19.2026.01.03.01.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 01:13:12 -0800 (PST)
Date: Sat, 3 Jan 2026 04:13:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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
	bpf@vger.kernel.org
Subject: Re: [PATCH net v2 0/3] virtio-net: fix the deadlock when disabling
 rx NAPI
Message-ID: <20260103041213-mutt-send-email-mst@kernel.org>
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260102152023.10773-1-minhquangbui99@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PZktrcATg12hwV45Gg2qXlySW5iqdjLdFVuoPXgp-M8_1767431594
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 02, 2026 at 10:20:20PM +0700, Bui Quang Minh wrote:
> Calling napi_disable() on an already disabled napi can cause the
> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
> when pausing rx"), to avoid the deadlock, when pausing the RX in
> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
> However, in the virtnet_rx_resume_all(), we enable the delayed refill
> work too early before enabling all the receive queue napis.
> 
> The deadlock can be reproduced by running
> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
> device and inserting a cond_resched() inside the for loop in
> virtnet_rx_resume_all() to increase the success rate. Because the worker
> processing the delayed refilled work runs on the same CPU as
> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
> In real scenario, the contention on netdev_lock can cause the
> reschedule.
> 
> Due to the complexity of delayed refill worker, in this series, we remove
> it. When we fail to refill the receive buffer, we will retry in the next
> NAPI poll instead.
> - Patch 1: removes delayed refill worker schedule and retry refill in next
> NAPI
> - Patch 2, 3: removes and clean up unused delayed refill worker code
> 
> For testing, I've run the following tests with no issue so far
> - selftests/drivers/net/hw/xsk_reconfig.py which sets up the XDP zerocopy
> without providing any descriptors to the fill ring. As a result,
> try_fill_recv will always fail.
> - Send TCP packets from host to guest while guest is nearly OOM and some
> try_fill_recv calls fail.

Thanks, the patches look good to me.
Sent some nitpicking comments, with these addressed:

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> Changes in v2:
> - Remove the delayed refill worker to simplify the logic instead of trying
> to fix it
> - Link to v1:
> https://lore.kernel.org/netdev/20251223152533.24364-1-minhquangbui99@gmail.com/
> 
> Link to the previous approach and discussion:
> https://lore.kernel.org/netdev/20251212152741.11656-1-minhquangbui99@gmail.com/
> 
> Thanks,
> Quang Minh.
> 
> Bui Quang Minh (3):
>   virtio-net: don't schedule delayed refill worker
>   virtio-net: remove unused delayed refill worker
>   virtio-net: clean up __virtnet_rx_pause/resume
> 
>  drivers/net/virtio_net.c | 171 +++++++++------------------------------
>  1 file changed, 40 insertions(+), 131 deletions(-)
> 
> -- 
> 2.43.0

