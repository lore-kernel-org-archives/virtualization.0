Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756371684AE
	for <virtualization@lists.linux.dev>; Fri,  4 Apr 2025 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755454; cv=none; b=SC0kim1cMsJD3GY6QL4JtotvuqQPEI4X+sdHw30Hq438S8SHWP4lLI4EUh7YFrfHeNvut+rsGb6b9igX/yrIwVZoIilkGEM9hOpyDX0naNmhUwdp5Fq+jpCKzLwehy9GS0I/JfyfEnnZ1HvFHHm4bwgQ2zB0c5h1ilSZvzd49Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755454; c=relaxed/simple;
	bh=8GewlxyW7eoP8HeCQK4EuVSYVIQ9APadJTENW0qBDpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lamd3lUYeXYTNiHv/CDAut7KApEI3BPlK5h0B/h9aG0zh7qwx75qg2ZHpk68fS2m2kbTKL0AwpduDreLRsbtZT29mT+lTzwGnowcDGWh/aKPqWuBCsoF3eJs/yXAvgM57cEt06dYWeiX2uLhmt4whhNKl1E2ClBAw02jXvWd1TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KptVwNPA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KptVwNPA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743755451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T3XzV/U7dY3geuoVqw6S19aFTsTGevyvWrfbHpg+jFw=;
	b=KptVwNPAaznqWtOegYbbcuJOEs314Cv/H3Rq90w5GObhUY5zbX5QwBXTFU1uMBBU0C110z
	GJpbsV+lHs6DpZrH3BzjlsUjJeVqJ6u4ogbQOYB5awsUHOZA9n12XD48WTybNc6g9XPfoA
	8AVo2rNb55mmDHHOVkWze5XW8b7zRW8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-2Jt09tIwOByTu8TUZ2N7eg-1; Fri, 04 Apr 2025 04:30:50 -0400
X-MC-Unique: 2Jt09tIwOByTu8TUZ2N7eg-1
X-Mimecast-MFC-AGG-ID: 2Jt09tIwOByTu8TUZ2N7eg_1743755449
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so14446005e9.3
        for <virtualization@lists.linux.dev>; Fri, 04 Apr 2025 01:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743755449; x=1744360249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3XzV/U7dY3geuoVqw6S19aFTsTGevyvWrfbHpg+jFw=;
        b=aXL4YzKQT42yn0QyQ/ajzmpqcrz1POFNtT1ooSjX+OA+iIyp9sMxPQMNXHDleMUZWO
         vJj2MGej/lmxTWl/sULLbRPpNh2c1+sNjR+VlNurOTjdP7lf96sEjDFt5Kb7QxpkLwQd
         5EfjgPrzh/yHeJT2Ti9cm733Jgyrp4FMJnPBUdb2YAK5HomOq/Ja+LATD0Gj+DY3HaWr
         dLYDPZ8HNVb86OsPtaqDqc/pgBJ4KmqY0IYn6pnBfNPy2hnGsOGXUP4UthMRT7jjP9ti
         NOmDNB/FV/eZgxoz9TmW5C+NmH54cVPtANuAnlid584pef/skOaDa1cBK3AWriFyVc33
         R3Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXd/6JuWVc9I82MfQ0syTGvXbefELsGC4pX8v8iBKX0aN9zQBcprFeHfnJRl+Zn8PkehX0YbLaUAWVyONFBlw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+NBTeErr0591h5sHRI6od9UAZTRoH59CgMAe+rmMso1ZBymMf
	G1cWOFWqffJxkNx8AFCr68yJP6OHd80KLGHJtiL1R/orO91oa+gGZ+XbzD3e5suD52XmqUzJn9S
	DypLE8MqdVa5SLBlAzmFGZUbQb8nKJh9CIauji4JV2aExzYTZ4sc8oB/+FDkY9cXO
X-Gm-Gg: ASbGncs+0yEbF0e8c7Kx529FvI4Q+ClDJWg1IQ14IDyrJHfF3xgXXqq393YHqZKu920
	/yj5uBDmQ6rBA+3wZkozxqUyymwmeBI91VcxWU336S+v/j7fw8Cku1qxZVMqU4V6SVX/UFzs/tB
	Ks9f51LvOScBeEkQ+L+i9i4gRKKAxTgUhLGc9kjHSJrFzZumNP0iSbMWCzuNxjdQ7G+wFF9TSr+
	a9coOw/paq4aJ18VJNgvX2yBjHC24RcksgFcsnI3jAu8r5DRBrRJB899N4KiZ5mBkis4QTLC+ic
	5nhcQxPlbOfbvD2SXd+7U0Wijp67ytnEfM8zOHlJxKXpDFSJjpnoVwU7itM=
X-Received: by 2002:a05:600c:468c:b0:43c:f75a:eb54 with SMTP id 5b1f17b1804b1-43ecf89dddcmr19881915e9.13.1743755448995;
        Fri, 04 Apr 2025 01:30:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1wKJOBp0CxXmSt34i3bMjHqoK6bjtjR9iZitlzkAWs0gUdgf+hp6J8a0hZZYH5whJltcXUA==
X-Received: by 2002:a05:600c:468c:b0:43c:f75a:eb54 with SMTP id 5b1f17b1804b1-43ecf89dddcmr19881525e9.13.1743755448536;
        Fri, 04 Apr 2025 01:30:48 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34a7615sm39259665e9.9.2025.04.04.01.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 01:30:47 -0700 (PDT)
Date: Fri, 4 Apr 2025 10:30:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, Asias He <asias@redhat.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	nh-open-source@amazon.com
Subject: Re: [PATCH v2] vsock/virtio: Remove queued_replies pushback logic
Message-ID: <fiyxlnv7gglcfkr7ue4tiaktqjptdkr5or6skrr6f7dof26d56@wmg3zhhqlcoj>
References: <20250401201349.23867-1-graf@amazon.com>
 <20250402161424.GA305204@fedora>
 <20250403073111-mutt-send-email-mst@kernel.org>
 <32ca5221-5b25-4bfd-acd7-9eebae8c3635@amazon.com>
 <20250404041050-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250404041050-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O68GLt7FsBameGam3GwpYgwzmpowfRPA4YUNQTMnUEY_1743755449
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Apr 04, 2025 at 04:14:51AM -0400, Michael S. Tsirkin wrote:
>On Fri, Apr 04, 2025 at 10:04:38AM +0200, Alexander Graf wrote:
>>
>> On 03.04.25 14:21, Michael S. Tsirkin wrote:
>> > On Wed, Apr 02, 2025 at 12:14:24PM -0400, Stefan Hajnoczi wrote:
>> > > On Tue, Apr 01, 2025 at 08:13:49PM +0000, Alexander Graf wrote:
>> > > > Ever since the introduction of the virtio vsock driver, it included
>> > > > pushback logic that blocks it from taking any new RX packets until the
>> > > > TX queue backlog becomes shallower than the virtqueue size.
>> > > >
>> > > > This logic works fine when you connect a user space application on the
>> > > > hypervisor with a virtio-vsock target, because the guest will stop
>> > > > receiving data until the host pulled all outstanding data from the VM.
>> > > >
>> > > > With Nitro Enclaves however, we connect 2 VMs directly via vsock:
>> > > >
>> > > >    Parent      Enclave
>> > > >
>> > > >      RX -------- TX
>> > > >      TX -------- RX
>> > > >
>> > > > This means we now have 2 virtio-vsock backends that both have the pushback
>> > > > logic. If the parent's TX queue runs full at the same time as the
>> > > > Enclave's, both virtio-vsock drivers fall into the pushback path and
>> > > > no longer accept RX traffic. However, that RX traffic is TX traffic on
>> > > > the other side which blocks that driver from making any forward
>> > > > progress. We're now in a deadlock.
>> > > >
>> > > > To resolve this, let's remove that pushback logic altogether and rely on
>> > > > higher levels (like credits) to ensure we do not consume unbounded
>> > > > memory.
>> > > The reason for queued_replies is that rx packet processing may emit tx
>> > > packets. Therefore tx virtqueue space is required in order to process
>> > > the rx virtqueue.
>> > >
>> > > queued_replies puts a bound on the amount of tx packets that can be
>> > > queued in memory so the other side cannot consume unlimited memory. Once
>> > > that bound has been reached, rx processing stops until the other side
>> > > frees up tx virtqueue space.
>> > >
>> > > It's been a while since I looked at this problem, so I don't have a
>> > > solution ready. In fact, last time I thought about it I wondered if the
>> > > design of virtio-vsock fundamentally suffers from deadlocks.
>> > >
>> > > I don't think removing queued_replies is possible without a replacement
>> > > for the bounded memory and virtqueue exhaustion issue though. Credits
>> > > are not a solution - they are about socket buffer space, not about
>> > > virtqueue space, which includes control packets that are not accounted
>> > > by socket buffer space.
>> >
>> > Hmm.
>> > Actually, let's think which packets require a response.
>> >
>> > VIRTIO_VSOCK_OP_REQUEST
>> > VIRTIO_VSOCK_OP_SHUTDOWN
>> > VIRTIO_VSOCK_OP_CREDIT_REQUEST
>> >
>> >
>> > the response to these always reports a state of an existing socket.
>> > and, only one type of response is relevant for each socket.
>> >
>> > So here's my suggestion:
>> > stop queueing replies on the vsock device, instead,
>> > simply store the response on the socket, and create a list of sockets
>> > that have replies to be transmitted
>> >
>> >
>> > WDYT?
>>
>>
>> Wouldn't that create the same problem again? The socket will eventually push
>> back any new data that it can take because its FIFO is full. At that point,
>> the "other side" could still have a queue full of requests on exactly that
>> socket that need to get processed. We can now not pull those packets off the
>> virtio queue, because we can not enqueue responses.
>
>Either I don't understand what you wrote or I did not explain myself
>clearly.

I didn't fully understand either, but with this last message of yours 
it's clear to me and I like the idea!

>
>In this idea there needs to be a single response enqueued
>like this in the socket, because, no more than one ever needs to
>be outstanding per socket.
>
>For example, until VIRTIO_VSOCK_OP_REQUEST
>is responded to, the socket is not active and does not need to
>send anything.

One case I see is responding when we don't have the socket listening 
(e.g. the port is not open), so if before the user had a message that 
the port was not open, now instead connect() will timeout. So we could 
respond if we have space in the virtqueue, otherwise discard it without 
losing any important information or guarantee of a lossless channel.

So in summary:

- if we have an associated socket, then always respond (possibly
   allocating memory in the intermediate queue if the virtqueue is full
   as we already do). We need to figure out if a flood of
   VIRTIO_VSOCK_OP_CREDIT_REQUEST would cause problems, but we can always
   decide not to respond if we have sent this identical information
   before.

- if there is no associated socket, we only respond if virtqueue has
   space.

I like it and it seems feasible without changing anything in the 
specification.

Did I get it right?

Thanks,
Stefano

