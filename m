Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BADA374178
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496898; cv=none; b=UMwSWAAR73r8GM+Q1mfkvtMWvjhKIzMWRz8P2Z+saR+Zom3rQGSRVz8fx636jRwt5DITkhiXlDr6daolNXQAfEGXdMeGGidaP74LqVwx+y01sFB9IF8MdQDM1FCjsw2FHHscd7DVBlzmlq3M5Lk5dCgOMHhM3q+GdFWyZWgRRnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496898; c=relaxed/simple;
	bh=V8eg8l9LTNxtrgGj41tiN9oiWfET/lpJ8WKuJ9lm5aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VJVDKZGRx45eG6G0IwhYMww8sMuU5Oysh0Mf6d0VgY4Cqvg2EL+OzWVpyrZt4DgodtEzTAEPSTwgOH4v/B0Zns+JzaaxcWgO2ih0fYkl3rHXMdB90vJ94NVWmoGvgi0TaKtW4ZSQNwUNDvSVJEKFzd74mCS6+VTUt9xJCAJwLL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOcR0HU2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOcR0HU2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778496896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DNWy/CV2WRe1jDYLvFjqxiC49eSLSSASB8hrdzj5ZF0=;
	b=cOcR0HU2c2KM+Rj99XNjcn47AKPmN3ndK2tYcblXyomIRx5Uq6/SAorL6MJmhq15T8KWCq
	06eEOtDQ/t8MKwy/z7luA6jwXht64X1QtTgPkAl29opaofQ5N+TniqxtU7iz/d/y4ioIu2
	pWNUwKU7KZlVLXAEUBWabLuFtkXabZI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651--iLoCIX8NUGreBSYXGZKCg-1; Mon, 11 May 2026 06:54:54 -0400
X-MC-Unique: -iLoCIX8NUGreBSYXGZKCg-1
X-Mimecast-MFC-AGG-ID: -iLoCIX8NUGreBSYXGZKCg_1778496894
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-449b2a183d3so3093180f8f.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 03:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778496893; x=1779101693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNWy/CV2WRe1jDYLvFjqxiC49eSLSSASB8hrdzj5ZF0=;
        b=OL1XnX6Db/N0N871X2PtY/7dppeorHW12uwhEHeZs1uvdyiqxznOAkOgOACU/yD38b
         mkL/vOLe6+L1DF8lhijVtv73uJqP8uij2lup6hZujqKNSZfMER/FqI6WeO/Ow9LEYLro
         WFYNMkh+FSPgolJShfXr8tkyjC0EqNqG1ySoA0TyO1qjqSO7ZpJm1sdZiYyUK51TWT1q
         4JGuU4k+EaBongaEoogCU1tVxW073DEn9i5g/gqzVe02w5mshg3C+qt6y3VYq6DCeL/u
         kXP6L5Wq3jUniDc8sJiA8MDfG/tJe7CzT0S49454obWeeelWKh3b97AwEBUwZYZ0745m
         Ff3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+291peliRDaYT0OBQlwHo0jDWsEqeBisYM5GoYHVL0/e1p+dosUj9HbHOj/N+EO6TBSXaTIzEYV+d3asn4VA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2t/KlhQW/LOLGTwoOf45p6i/3wrBw137+L75wvHLm0PtvF7Dy
	giPEDJfLvbhMFf2TgARvi1L05Wye1502v7DDi0HsgrtWNtQCHfQKuSWmzDUytL1HAwWgcUf+yIf
	qQim0F7C5gdQYkNc2iDI3+eV+R9A2AeBF0iAADHZk+YJxZe0UlH6IAymM2kOhBC/Dwg6S
X-Gm-Gg: Acq92OEvAJ46OgDa2T/AvwzlvW6fUjfBKXCcGYh4n4hzAEnwil97z/OXJC8j++cVsxw
	kB/E3HSlcFABkLK8uwdcYAhvGti0St7xlwTeJALYRKUAG03VxwTCSlahEwL2deO+3euVbh9/C47
	gJ3L2gImOHyXoEgJp1BdXTR683m6CvAlz2HI7mbCRL6FBkCZU1PRyx8L3W4pGa66KKcyb20bR9u
	OMnMPHTK7y+F0J0A4wZ3VIA3xOJHnlcHJqzflemK/fyu7urlrfSPjKP7OwVEobA1DryTToUVFkB
	tjCKpJF+d81kMJEL313yXK71HG5fLLl81Df8uPdYOyc5MnsAnf+IoFRVSkogThwbXb72Docse/V
	9hpZtllZbO3TaF0bInS+P5DRE7MvGMPfM4jf+0kvFLrxOZ5Dz/1WdJwY1TCPuret+agXuRSMRul
	ptE52ouXVC
X-Received: by 2002:a05:6000:270f:b0:457:d27e:e4ee with SMTP id ffacd0b85a97d-457d27ee505mr6306176f8f.8.1778496893536;
        Mon, 11 May 2026 03:54:53 -0700 (PDT)
X-Received: by 2002:a05:6000:270f:b0:457:d27e:e4ee with SMTP id ffacd0b85a97d-457d27ee505mr6306143f8f.8.1778496892956;
        Mon, 11 May 2026 03:54:52 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6cd75sm23669841f8f.16.2026.05.11.03.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 03:54:52 -0700 (PDT)
Date: Mon, 11 May 2026 12:54:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <CAGxU2F65pw0P1uKOOJpBc4p6KjCz8iePEh9aPybUyECBm1=otg@mail.gmail.com>
References: <20260508092330.69690-1-sgarzare@redhat.com>
 <20260508055125-mutt-send-email-mst@kernel.org>
 <af2y2Fyp7H-om-ur@sgarzare-redhat>
 <20260508063104-mutt-send-email-mst@kernel.org>
 <af28MAV0LF4qHVmB@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <af28MAV0LF4qHVmB@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ESk8jMi1lpxHlVSp9s6do36Y5JaK6V6MqFtO2A7vLmk_1778496894
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, 8 May 2026 at 12:38, Stefano Garzarella <sgarzare@redhat.com> 
wrote:
>
> On Fri, May 08, 2026 at 06:33:13AM -0400, Michael S. Tsirkin wrote:
> >On Fri, May 08, 2026 at 12:01:50PM +0200, Stefano Garzarella wrote:
> >> On Fri, May 08, 2026 at 05:53:07AM -0400, Michael S. Tsirkin wrote:
> >> > On Fri, May 08, 2026 at 11:23:30AM +0200, Stefano Garzarella wrote:
> >> > > From: Stefano Garzarella <sgarzare@redhat.com>
> >> > >
> >> > > After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
> >> > > queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
> >> > > buf_alloc when checking whether a new packet fits. This reduces the
> >> > > effective receive buffer below what the user configured via
> >> > > SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
> >> > > silently dropped and applications that rely on the full buffer size
> >> > > to deadlock.
> >> > >
> >> > > Also, the reduced space is not communicated to the remote peer, so
> >> > > its credit calculation accounts more credit than the receiver will
> >> > > actually accept, causing data loss (there is no retransmission).
> >> > >
> >> > > This also causes failures in tools/testing/vsock/vsock_test.c.
> >> > > Test 18 sometimes fails, while test 22 always fails in this way:
> >> > >     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
> >> > >
> >> > >     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
> >> > >     Resource temporarily unavailable
> >> > >
> >> > > Fix this by introducing virtio_transport_rx_buf_size() to calculate the
> >> > > size of the RX buffer based on the overhead. Using it in the acceptance
> >> > > check, the advertised buf_alloc, and the credit update decision.
> >> > > Use buf_alloc * 2 as total budget (payload + overhead), similar to how
> >> > > SO_RCVBUF is doubled to reserve space for sk_buff metadata.
> >> > > The function returns buf_alloc as long as overhead fits within the
> >> > > reservation, then gradually reduces toward 0 as overhead exceeds
> >> > > buf_alloc (e.g. under small-packet flooding), informing the peer to
> >> > > slow down.
> >> > >
> >> > > Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> >> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> >
> >> >
> >> > unfortunately, this is a bit of a spec violation and there is no guarantee
> >> > it helps.
> >>
> >> Loosing data like we are doing in 059b7dbd20a6 is even worse IMHO.
> >>
> >> >
> >> > a spec violation because the spec says:
> >> > Only payload bytes are counted and header bytes are not
> >> > included
> >> >
> >> > and the implication is that a side can not reduce its own buf_alloc.
> >> >
> >> > no guarantee because the other side is not required to process your
> >> > packets, so it might not see your buf alloc reduction.
> >> >
> >> > as designed in the current spec, you can only increase your buf alloc,
> >> > not decrease it.
> >>
> >> We never enforced this, currently an user can reduce it by
> >> SO_VM_SOCKETS_BUFFER_SIZE and we haven't blocked it since virtio-vsock was
> >> introduced, should we update the spec?
> >
> >
> >it's not that we need to enforce it, it's that all synchronization
> >assumes this. as in, anyone can use an old copy until they run out
> >of credits.
> >
> >
> >> >
> >> > what can be done:
> >> > - more efficient storage for small packets (poc i posted)
> >> > - reduce buf alloc ahead of the time
> >>
> >> That's basically what I'm doing here: I'm using twice the size of
> >> `buf_alloc` (just like `SO_RCVBUF` does for other socket types) and telling
> >> the other peer just `buf_alloc`.
> >>
> >> But then, somehow, we have to let the other person know that we're running
> >> out of space. With this patch that only happens when the other peer isn't
> >> behaving properly, sending so many small packets that the overhead exceeds
> >> `buf_alloc`.
> >>
> >> Stefano
> >
> >what is "not proper" here, it is up to the application what to send.
>
> Sure, but here we're just slowing down the application by telling it we
> don't have any more space.
>
> Again, without this patch we are just dropping data, which IMO is even
> worse.
>
> So I think we should merge this for now, while we handle better the EOM.
> If you prefer, I can drop the part where we reduce the buf_alloc
> advertised to the other peer, but at least we should drop data after
> `buf_alloc * 2` IMO.

Okay, I thought it over over the weekend, and I agree that this patch 
still doesn't solve the problem and would still result in packet loss.
So, until we resolve the issue permanently, and since 059b7dbd20a6 is 
coming to stable, I'd like to rework this patch so that we only start 
dropping packets when the overhead plus the queued bytes exceeds 
`buf_alloc * 2`.
Removing the other changes to reduce the buf_alloc advertised, but 
terminating the connection so that both peers are aware that something 
went wrong.

Any objections?

Stefano

