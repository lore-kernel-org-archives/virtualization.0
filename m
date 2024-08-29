Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08341A00C5
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935075; cv=none; b=JZCj5/+y7kBMWGdJrthdoO79ga4mxk26YN7p54rsdLWw50cLCbYis2GYoLx5s6PugQlmqYw/wi0QQTvHfBknHB+o7NtBvgX9ojdzNd/9NKNkD0N8MWSMXvMAYBmLfd3CzIX6d0VVrOrrkkzU1mNc3LnvFGAt/Q8JFTXBBVnFV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935075; c=relaxed/simple;
	bh=8IVyrfgUZxOCZf/vnKDXcnlww3JCaC6oS7COSF6Fv1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iwXlztGMMtTBXzY5QmAjec6218+ywvrHS5SJIMx1/bcKfByFv4DbUGamTQdpFB9+m45fXjFeyEDgIOFvBLlleQ55dPyDHEZcBpfl8eiGNd6SUSjie/E533VL+psTvtOdhPgeyxv6YeYogaaeamw8AcE/x3tj+sg8O9ZFlVMRC3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ivJASajK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivJASajK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724935073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LCAshlfXQBHJjsZimXGR/lheLVAb7fx9A/Gwhk+G6+8=;
	b=ivJASajKCXrZ7QcgHb8/IyLI6hE1cHnKWy4mnz290JC2Kl9CJrXVDemeLm3PoAeBmuq62A
	ebz+xT4SXqzCK73weM9CqQPij9VxmDUBtHj8mhcBgFqusRIKsWgTa8Mk14laoQvRkoSvJQ
	vpPm2zioSRd8ggv7njTvtrRWmuJiXTA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-mSepurv-OrqovhXRhq6abQ-1; Thu, 29 Aug 2024 08:37:51 -0400
X-MC-Unique: mSepurv-OrqovhXRhq6abQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f3f4dcbee9so3099791fa.1
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 05:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724935070; x=1725539870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCAshlfXQBHJjsZimXGR/lheLVAb7fx9A/Gwhk+G6+8=;
        b=PV1rhGTmLCYvm7dM0WaDUnKXHP6HBBpytwLlH+HCZOEt4JwcuuGb9NwuzgvG8W5DH+
         P+wYKMWJD9KHVT7h38hBdsvA/8SV0XnkNxFUbZd4SYcxzOm5UUvYCPhnwl36Za2zdhDQ
         1MZxu+HwgJgh6TsTPUAgtKITlzZPTuIyi0xCO3AmUfcHunqN8ZdGhh5pZNCxqIpcIpi6
         1xAZLl3lYJ8SvG01fe/hMTF+8d576jOhfI9lF9q9xPzoXo+v6GMRzcssrCezRdhiYB3F
         znk6LTmI49pcy2NNQg3RPmLsDwasHd3x8kbAxE/j9AHboismlXTxQrsF72KAj7EYTzE7
         i9cg==
X-Forwarded-Encrypted: i=1; AJvYcCUa3YVD9H1E45aIZTcCPfISq+viXZr4qWsNVy2qnve1yzAjmu8nQpR8zl03Vk3Wny0aP65Z+TO9ywW3F9WZ0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZwzqxodoeHYDVn0s72T6FvU9vBPiuwwJc6ky7rKrREXAryM6i
	eu+j5KLhIxzbovf0PLuSeoolMEZcUYrZcIykB08zQK4YiI3/xSU14GT6ji09HfwT12jj8aRyG6F
	wh1vhWKOpDAzQ5OLcVQ2maXEQvSE/UD5cFLrfxLzhXrBnzEvQH2L9r5dmI+XK9UkP
X-Received: by 2002:a2e:4c12:0:b0:2f3:c0cc:aa37 with SMTP id 38308e7fff4ca-2f6105d9600mr14616301fa.19.1724935069860;
        Thu, 29 Aug 2024 05:37:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj40PJfS1FTib9Oe7KSH4YTXK1zPG8FNuwxORd2gOmXzgpNlFZMUwpvXHZrEgPUSUWT0t1rA==
X-Received: by 2002:a2e:4c12:0:b0:2f3:c0cc:aa37 with SMTP id 38308e7fff4ca-2f6105d9600mr14616031fa.19.1724935068778;
        Thu, 29 Aug 2024 05:37:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ed:a269:8195:851e:f4b1:ff5d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989221c63sm73982166b.201.2024.08.29.05.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:37:48 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:37:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Luigi Leonardi <luigi.leonardi@outlook.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, marco.pinn95@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com, stefanha@redhat.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v4 0/2] vsock: avoid queuing on intermediate
 queue if possible
Message-ID: <20240829083715-mutt-send-email-mst@kernel.org>
References: <tblrar34qivcwsvai7z5fepxhi4irknbyne5xqqoqowwf3nwt5@kyd2nmqghews>
 <DU2P194MB21741755B3D4CC5FE4A55F4E9A962@DU2P194MB2174.EURP194.PROD.OUTLOOK.COM>
 <20240829081906-mutt-send-email-mst@kernel.org>
 <22bjrcsjxzwpr23i4i3sx6lf5kkxdz6zjie67jhykcpqn5qmgw@jec7qktcmblu>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <22bjrcsjxzwpr23i4i3sx6lf5kkxdz6zjie67jhykcpqn5qmgw@jec7qktcmblu>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 29, 2024 at 02:33:11PM +0200, Stefano Garzarella wrote:
> On Thu, Aug 29, 2024 at 08:19:31AM GMT, Michael S. Tsirkin wrote:
> > On Thu, Aug 29, 2024 at 01:00:37PM +0200, Luigi Leonardi wrote:
> > > Hi All,
> > > 
> > > It has been a while since the last email and this patch has not been merged yet.
> > > This is just a gentle ping :)
> > > 
> > > Thanks,
> > > Luigi
> > 
> > 
> > ok I can queue it for next. Next time pls remember to CC all
> > maintainers. Thanks!
> 
> Thank for queueing it!
> 
> BTW, it looks like the virtio-vsock driver is listed in
> "VIRTIO AND VHOST VSOCK DRIVER" but not listed under
> "VIRTIO CORE AND NET DRIVERS", so running get_maintainer.pl I have this
> list:
> 
> $ ./scripts/get_maintainer.pl -f net/vmw_vsock/virtio_transport.c
> Stefan Hajnoczi <stefanha@redhat.com> (maintainer:VIRTIO AND VHOST VSOCK DRIVER)
> Stefano Garzarella <sgarzare@redhat.com> (maintainer:VIRTIO AND VHOST VSOCK DRIVER)
> "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
> Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING [GENERAL])
> Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
> Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING [GENERAL])
> kvm@vger.kernel.org (open list:VIRTIO AND VHOST VSOCK DRIVER)
> virtualization@lists.linux.dev (open list:VIRTIO AND VHOST VSOCK DRIVER)
> netdev@vger.kernel.org (open list:VIRTIO AND VHOST VSOCK DRIVER)
> linux-kernel@vger.kernel.org (open list)
> 
> Should we add net/vmw_vsock/virtio_transport.c and related files also under
> "VIRTIO CORE AND NET DRIVERS" ?
> 
> Thanks,
> Stefano

ok

> > 
> > 
> > > >Hi Michael,
> > > >this series is marked as "Not Applicable" for the net-next tree:
> > > >https://patchwork.kernel.org/project/netdevbpf/patch/20240730-pinna-v4-2-5c9179164db5@outlook.com/
> > > 
> > > >Actually this is more about the virtio-vsock driver, so can you queue
> > > >this on your tree?
> > > 
> > > >Thanks,
> > > >Stefano
> > 

