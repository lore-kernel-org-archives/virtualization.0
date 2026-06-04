Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19EE33ADA2
	for <virtualization@lists.linux.dev>; Thu,  4 Jun 2026 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569587; cv=none; b=OJsjsJuxy1lBsTpMkTrlwcFDE0I4nNsuLZzaI9TmdnC7sBoUSrAG3gKU0wzyaDD1lZW5i4f5XBkCwSSqmEmjLuHklkSwpWAlM8HPzy+0KnRfFlOqHZwsg/loyg/NzHJeC0dRRnLSNTXyoPcUISG5ZF2t3o/lQW8zpHNMO21ylxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569587; c=relaxed/simple;
	bh=2Vh56h57Z0T91eA8r4mMnsXiuc3McXuOqM+28axWqVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WiowRxA6TQ+Y/L6h/gRf4qZyf/SBGNiCUuy4hFHAJ0pfjyDz+8h7U9p0KD9tsGk9jBWxtSHiSq77CAag4cCcaRnmzC2e2CJzDpA7vX0jJk40TuUbkTVjukn2rf5HTxMzwBDOKyGMmcPIpg/paIJ6r1HyJJiqaK2MQCuKMlyjmlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJXsZYxw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJXsZYxw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780569586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aXLe0Lyqp3ntcJ5AmrAA7vOVVp+FJ2nW9Yvine+7m/M=;
	b=WJXsZYxwi7WYFRRVHGgVjikGTDJst4Ux3iQGQ7AF2XxMTgD282TKfj56gQhboUGYXx8eo7
	AareeqegprL9iPc9dmMfPdWoz/hxH9raMJ39S05p8oRzdbxKnJ7QSiNF28M+73YCjn0spB
	fimKrlMdlPSeESFHhDwvqAHpyuLQ05A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-A-_zUMDWPxuYogsMr-DUBA-1; Thu, 04 Jun 2026 06:39:44 -0400
X-MC-Unique: A-_zUMDWPxuYogsMr-DUBA-1
X-Mimecast-MFC-AGG-ID: A-_zUMDWPxuYogsMr-DUBA_1780569583
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b3f53c81so2381715e9.3
        for <virtualization@lists.linux.dev>; Thu, 04 Jun 2026 03:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780569583; x=1781174383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXLe0Lyqp3ntcJ5AmrAA7vOVVp+FJ2nW9Yvine+7m/M=;
        b=FNqrtZxUPBVe0G8RytbpvHY3PYwDS98ALFbJku8GDDJVxTDDSyBa20kxxaLM6orrUE
         9xHdQtzql6JrCegkqU6fYYKpmkQIEbcWXjN/5n7QoltHHUjmKQqdJ9T+fAQWzP5Wo4jF
         J1Z3QdA+Ku9pjKQ8BNISLgimXJUtyaLZAqMNSNm3MtzywnmphV5DwGkIsyBbGmcJOsDy
         QGtPnXX5JGNIq9gBUX4hdBQK6hVPNDVYKqk8rltxMWPFPu6f6Ba+lNqfvOzfNCAJ6iTB
         zk0dV58tHVgLBhYXnz6kuxi1iSO+op1sfgbAcpQG+lGv5cveN+Do0W8ZsDIHzNd0ilK9
         M+aQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dvh5IAOVFc2+slAVsDhHPTDftNXsYIdqZYi94sRfBATJCejARE2bwxmNx/PEUWk3Jc7Esn3F7cGAnPCfA9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxActAcvatghw+X+68jSEGcxUmleG3clfRYQUtJ16zjqd+z9esp
	aIkLV315fRt1hg0UMg/qpzLWtYfu07EoQNdlSs3i5wNmpc6wZaqy9puthwoSDCQWw7mtaCx3H/k
	dEhPBu/9G5ju+DdMXyZjwxdQuR5wMQ3h6yXOkI6rZeFXtFWRmJVjxLSZOeCzhpk+vUHt+
X-Gm-Gg: Acq92OGoVzJVIl+AVPv2EGNEQ1tubAi3DliuAYwQ/R5rGqQEnmQR/C5ZVdGHSbqrCF4
	x0fxDUUpqxVAlFFGIQ1FdY2b0HhW9TFT+mlrATxq/2XWU9yVKHUpMJSBYm2QoAnQNo3JQ6Q9i/e
	Ur30tr7HcB8izfwMGBhqinWfENGSJT91uMlKWaBx9/37SnlM8Uy2EtpxWehLBoaf9pvZTrMhvtP
	AO3hAf18wNpwQAbWQ34VIsNmMYs8awcpgccskAE/Fbp1p8bgp4p8Bbb5sfjvS9yck5jf7v/dAPH
	+5uYb/3LmhK3MPLQRQ0QNxRtC2WucLrBejXxd/cFPlrh73qOvr4SN4czLk/7p6GNd84W2uwGyGP
	uWh5MhnNGwdaMyaAen/YULHBZsKERBk1Jh0xuy0yUrLfJkueD9CHrsB58QFFFKnzioSxsAOUWEF
	e41GQe5w==
X-Received: by 2002:a05:600c:608d:b0:490:b8c0:d471 with SMTP id 5b1f17b1804b1-490b8c0d5eemr115722265e9.23.1780569582733;
        Thu, 04 Jun 2026 03:39:42 -0700 (PDT)
X-Received: by 2002:a05:600c:608d:b0:490:b8c0:d471 with SMTP id 5b1f17b1804b1-490b8c0d5eemr115721305e9.23.1780569582103;
        Thu, 04 Jun 2026 03:39:42 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm25192327f8f.29.2026.06.04.03.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 03:39:41 -0700 (PDT)
Date: Thu, 4 Jun 2026 12:39:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, stefanha@redhat.com, 
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] vsock/vmci: fix sk_ack_backlog leak on failed handshake
Message-ID: <aiFT9FBrEW_fW3KW@sgarzare-redhat>
References: <97069506-352b-4152-a57b-5a974320529d@redhat.com>
 <20260601095646.180085-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260601095646.180085-1-rafdog35@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z6U9HaMV9dUkw-v49YySdWUbrHeC2wsD_RCXjy4yvCk_1780569583
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jun 01, 2026 at 09:56:46AM +0000, Raf Dickson wrote:
>On Mon, Jun 1, 2026 at 9:26 AM Paolo Abeni wrote:
>> I'm wondering if sk_acceptq_removed() should be bounded in
>> vsock_remove_pending() ? (even if that change would probably be
>> net-next material).
>
>Agreed, that would prevent this class of bug entirely. Happy to prepare
>a follow-up patch for net-next once this fix lands, if that would be
>useful.

And maybe sk_acceptq_added() calls moved in vsock_add_pending().
That said I was wondering about other transports, but it seems both 
virtio and hyperv have a simplier handshake that doesn't require the 
pending list, since the socket is moved directly in the accept list.

BTW if you are going to sent a follow up, maybe another improvement 
(unrelated so another patch) could be to use sk_acceptq_is_full() 
instead of `sk->sk_ack_backlog >= sk->sk_max_ack_backlog`. Discovered 
while comparing vmci with virtio.

Thanks,
Stefano

