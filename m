Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274A439F173
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503591; cv=none; b=SgmjxWChGB5Bckxmb4gwEH8je2XvTvH2cKQndbOp7tQd9mCHNsMpeq0Olu8CmG89Uc9D5DVMJWGNM0WPO+5q89/0icvISQmbtLm63kSh4uAWqoJld71Awhfk9L5r3VCQBYD0LCC5WZlHxP82/NgiRU3QK1lHYxic/u9aOVaQ5mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503591; c=relaxed/simple;
	bh=Ugs/xjDpsbPmanWITKMhKdhwotw3HHy735HCKeIxttI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hhR8ERVZdq4aj0epC4ZO3YQO1CxxOl0nM0a67aRqm9GZXmMe3C706gkACAn30gqEhBXzvQA5Q0ExSbhpLMFhDVmDPqGSc7eOrRVmMIFY0BBt8gC3COyftqvJEK8iR3F3qAHut+rpZApYaAsXZuDmK4phnS6jJZh9NU5+Dbu2LuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ARH1ZESY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARH1ZESY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778503589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Xz/1zJ+MWlJ9Av9Kr7QaYQGfRn7oNzrnu40h3srvyM=;
	b=ARH1ZESYpJNtXPP/7R+45DKk0lMnFLLKh7I/L1mfmYYAvv/votSQcW2AiwdOvvgtAW9RPc
	apwn+jwf11cr8+mC7sCqT+hodafH4vqsmY54Twz1chfSD9i0GNtrVMKwar7GNloV2xFQXe
	BxjLVv0kkVhK17EigSC7HjeDatzx8MU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-pumG8SSOP7ykeWNI2oEaww-1; Mon, 11 May 2026 08:46:26 -0400
X-MC-Unique: pumG8SSOP7ykeWNI2oEaww-1
X-Mimecast-MFC-AGG-ID: pumG8SSOP7ykeWNI2oEaww_1778503585
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48e5eecd0aaso24348655e9.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 05:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778503585; x=1779108385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Xz/1zJ+MWlJ9Av9Kr7QaYQGfRn7oNzrnu40h3srvyM=;
        b=VfnU8RNzhDQjq2419wSRbpKBxcQnvAXTOoX3d8PZ9Ly6p6tCM5mx1F92jdt/cvuJ1B
         etP9KBqu2TyRx5uXucMykYQt/ZHqgxJB5W8YjAGLXc7uqPCmSqKS0Yb6JElgdn6jDjE0
         x8t+t+LZVMeldZNj4CIzjMi5x029u+kQgA48afH0lIMYct8WAiQZ9iVU96EJIjWeOKIv
         W7ObOhjrs3IXcQDEZsZXVK/cBK+zc+usqS34OgfAPWjzsWoVYnrsThPejMcceSWxDXtn
         AowrJNwIG6KG/r7vE9moexpobVoBovlvYiMHay+1gPDmE+qjtX26pi3W4yfzSGZSuAZy
         AJ+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/0gDTZdS6vRwd0GbBayIjDLD3kd2y72FnHnWtkycp3BRjXYhFdGE8QdOJRJqGBQc5HP6r8NaQIVRlOOS0OCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNXhG/zCnXjwrMGNAh67mtsp4OffJBCJN4EG3gPSmUYcs1hWoB
	WONUWZ52U88rY+JLxbZCk9FlN3hqtC79oNtOt8+8xm5ynOcnLdt0W2s0oz1QMaLn05X0c+XrKVz
	qCx6XCjrfyoHlbmp0QUq0N6Kf7x05A5K99Pa+mOnMNHoLCOlsFhfv241QInmd07+A1Yut
X-Gm-Gg: Acq92OEWvg/z2gNMyfdLQPatjsAX9M0R9A1fpeAG4gKLKXvwIQ4ntyAyc/7gI06ro0k
	dHtdOztCFW1WdHsWwvVUo/DsAnTLhxYqsiLjKWjGOIARdyEXKN0/UjZP9JHzRHUEvNlvOB3sX1i
	T/HCi8jMAIfN8MRPrsHIiPWfKPiKS2msJO5YkS/a/dbvJMQeS9Z05HrkkW30QTPptLwNHPSMznm
	QgnxC8mSdn1RoAaOZBa88FmTGaqqfubOfMJUqsIrIDCjXkAFogNpWuqwv10dcGVa1bW/g9JwEA2
	2oRFGsLLI7pQ4CEiVREKGBw1eZAZvlAP4FBmxKQTdTgt5LgUMjahPevS2kkLbDEfhYVoF69Nbjy
	mkUfDBNhcJeoBzDq6Miufx0PufrqnaIvrpFfbdP0V
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d2 with SMTP id 5b1f17b1804b1-48e635a1b95mr271700145e9.2.1778503584633;
        Mon, 11 May 2026 05:46:24 -0700 (PDT)
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d2 with SMTP id 5b1f17b1804b1-48e635a1b95mr271699365e9.2.1778503584063;
        Mon, 11 May 2026 05:46:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d895781sm114542925e9.0.2026.05.11.05.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:46:23 -0700 (PDT)
Date: Mon, 11 May 2026 08:46:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <20260511084551-mutt-send-email-mst@kernel.org>
References: <20260508092330.69690-1-sgarzare@redhat.com>
 <20260508055125-mutt-send-email-mst@kernel.org>
 <af2y2Fyp7H-om-ur@sgarzare-redhat>
 <20260508063104-mutt-send-email-mst@kernel.org>
 <af28MAV0LF4qHVmB@sgarzare-redhat>
 <CAGxU2F65pw0P1uKOOJpBc4p6KjCz8iePEh9aPybUyECBm1=otg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAGxU2F65pw0P1uKOOJpBc4p6KjCz8iePEh9aPybUyECBm1=otg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4HZhnD6lt8uS48rfhudaSX2rPbH1aukfg0PguKwuW1k_1778503585
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2026 at 12:54:44PM +0200, Stefano Garzarella wrote:
> On Fri, 8 May 2026 at 12:38, Stefano Garzarella <sgarzare@redhat.com> 
> wrote:
> >
> > On Fri, May 08, 2026 at 06:33:13AM -0400, Michael S. Tsirkin wrote:
> > >On Fri, May 08, 2026 at 12:01:50PM +0200, Stefano Garzarella wrote:
> > >> On Fri, May 08, 2026 at 05:53:07AM -0400, Michael S. Tsirkin wrote:
> > >> > On Fri, May 08, 2026 at 11:23:30AM +0200, Stefano Garzarella wrote:
> > >> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > >> > >
> > >> > > After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
> > >> > > queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
> > >> > > buf_alloc when checking whether a new packet fits. This reduces the
> > >> > > effective receive buffer below what the user configured via
> > >> > > SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
> > >> > > silently dropped and applications that rely on the full buffer size
> > >> > > to deadlock.
> > >> > >
> > >> > > Also, the reduced space is not communicated to the remote peer, so
> > >> > > its credit calculation accounts more credit than the receiver will
> > >> > > actually accept, causing data loss (there is no retransmission).
> > >> > >
> > >> > > This also causes failures in tools/testing/vsock/vsock_test.c.
> > >> > > Test 18 sometimes fails, while test 22 always fails in this way:
> > >> > >     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
> > >> > >
> > >> > >     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
> > >> > >     Resource temporarily unavailable
> > >> > >
> > >> > > Fix this by introducing virtio_transport_rx_buf_size() to calculate the
> > >> > > size of the RX buffer based on the overhead. Using it in the acceptance
> > >> > > check, the advertised buf_alloc, and the credit update decision.
> > >> > > Use buf_alloc * 2 as total budget (payload + overhead), similar to how
> > >> > > SO_RCVBUF is doubled to reserve space for sk_buff metadata.
> > >> > > The function returns buf_alloc as long as overhead fits within the
> > >> > > reservation, then gradually reduces toward 0 as overhead exceeds
> > >> > > buf_alloc (e.g. under small-packet flooding), informing the peer to
> > >> > > slow down.
> > >> > >
> > >> > > Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> > >> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > >> >
> > >> >
> > >> > unfortunately, this is a bit of a spec violation and there is no guarantee
> > >> > it helps.
> > >>
> > >> Loosing data like we are doing in 059b7dbd20a6 is even worse IMHO.
> > >>
> > >> >
> > >> > a spec violation because the spec says:
> > >> > Only payload bytes are counted and header bytes are not
> > >> > included
> > >> >
> > >> > and the implication is that a side can not reduce its own buf_alloc.
> > >> >
> > >> > no guarantee because the other side is not required to process your
> > >> > packets, so it might not see your buf alloc reduction.
> > >> >
> > >> > as designed in the current spec, you can only increase your buf alloc,
> > >> > not decrease it.
> > >>
> > >> We never enforced this, currently an user can reduce it by
> > >> SO_VM_SOCKETS_BUFFER_SIZE and we haven't blocked it since virtio-vsock was
> > >> introduced, should we update the spec?
> > >
> > >
> > >it's not that we need to enforce it, it's that all synchronization
> > >assumes this. as in, anyone can use an old copy until they run out
> > >of credits.
> > >
> > >
> > >> >
> > >> > what can be done:
> > >> > - more efficient storage for small packets (poc i posted)
> > >> > - reduce buf alloc ahead of the time
> > >>
> > >> That's basically what I'm doing here: I'm using twice the size of
> > >> `buf_alloc` (just like `SO_RCVBUF` does for other socket types) and telling
> > >> the other peer just `buf_alloc`.
> > >>
> > >> But then, somehow, we have to let the other person know that we're running
> > >> out of space. With this patch that only happens when the other peer isn't
> > >> behaving properly, sending so many small packets that the overhead exceeds
> > >> `buf_alloc`.
> > >>
> > >> Stefano
> > >
> > >what is "not proper" here, it is up to the application what to send.
> >
> > Sure, but here we're just slowing down the application by telling it we
> > don't have any more space.
> >
> > Again, without this patch we are just dropping data, which IMO is even
> > worse.
> >
> > So I think we should merge this for now, while we handle better the EOM.
> > If you prefer, I can drop the part where we reduce the buf_alloc
> > advertised to the other peer, but at least we should drop data after
> > `buf_alloc * 2` IMO.
> 
> Okay, I thought it over over the weekend, and I agree that this patch 
> still doesn't solve the problem and would still result in packet loss.
> So, until we resolve the issue permanently, and since 059b7dbd20a6 is 
> coming to stable, I'd like to rework this patch so that we only start 
> dropping packets when the overhead plus the queued bytes exceeds 
> `buf_alloc * 2`.
> Removing the other changes to reduce the buf_alloc advertised, but 
> terminating the connection so that both peers are aware that something 
> went wrong.
> 
> Any objections?
> 
> Stefano

Let's try to first fix it upstream properly please. Discuss backporting
later.

-- 
MST

