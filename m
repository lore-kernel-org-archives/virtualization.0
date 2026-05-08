Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1647F3A451B
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236723; cv=none; b=QYN8V7hYvOf+NLwXUN8swV6uO9b1wLdZYhqqD8NxeWiWYOkUkx3ZuvrPttaukReIPLQ6K3ptDoHEgYxF+pLjUt0Pj5JyBkruKMpcKFijFhoCqf4dV0VreUWqsK2j7uJOzI1HbTOyfIfKoAJjeuVTG8bQkKb7pghCcjJY26p0Iz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236723; c=relaxed/simple;
	bh=MSTUs5VmMs5E3z7P5tkkJbr9UZZ5t6JPN4eNIlmTVac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tEQAcAgNt2IYmdYNd7hYdOKeNfgQcyTAlsiIyt0R4xF4dUje+MtpmteOXN/tj41Ur+6mrYdx3L4XV4TodhraCca4wdmDGOiGkO2HxYHfsPB2jpxbBnY8fi39SMI+R6uYMTdui895bm5xdshSxInl0owTXSPki3WTFittniyYpEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EaaBrRgG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EaaBrRgG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778236721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K3CQx535Mhn8kkYAr+IKjhOgoYF3I8ZJ28RdhySKLwo=;
	b=EaaBrRgGFkSbLbhyCM0/yfnimkgl3DEecxBUWG99PUsbVi/8RCk0Ye6H6xahjONoyHbIkz
	mxfGH+rkxQ/TxT97VY2kqH8wmi8I6VsF1lrBA5Map4tL3TYDIXos2HO6KvjbPEG8mho4Lj
	EIMNhOYXKzX1RyngILkW+FUHGaq11v8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-KvEMb0W-PvmcD_KSVaiNcA-1; Fri, 08 May 2026 06:38:40 -0400
X-MC-Unique: KvEMb0W-PvmcD_KSVaiNcA-1
X-Mimecast-MFC-AGG-ID: KvEMb0W-PvmcD_KSVaiNcA_1778236719
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4411a36715dso1316815f8f.2
        for <virtualization@lists.linux.dev>; Fri, 08 May 2026 03:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778236719; x=1778841519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3CQx535Mhn8kkYAr+IKjhOgoYF3I8ZJ28RdhySKLwo=;
        b=CxDWwcbFJ6Ww1g40qUv5fYSHZqBDAurv0Vi37hqrEVVRyG9TxDgHPa0GhogebX6JKs
         yJuGlCVDtiDWZ1qMCen982ChU6QkEiXvdMJMsLeQBqnOOMNGd4hGux9PEVuhB/ydeOcI
         NqKMgkUg+j75PKsv6yzruSdVmYO9MUqEm1vIKBTZGrGDeLg+wT5eNy2gAZYgozuqsD2P
         UpuHh6MbmLqew72e3pEOMxTmaaBaujtv7mIjUhlY3Iym6ygyj3dhYOYMJxsUxEFh8eBa
         a1Rq0Wb3JHtDY8pPp+QkGShEHD/NYPGOJ5oF448XHQ5kTy2nAXZs+lukuwArDy5TdobX
         p9Fw==
X-Forwarded-Encrypted: i=1; AFNElJ9BZLzG5e+jytp2kwk1HnKJkeumjVzZ3yE5vuQ6Sr21suIXagKRzA74uRkrl/btmYpBH2crq9JVcNqTYs0+Xw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxew8G0uu6KFZp/7kDIjvC/6Vk/LgVc+CkPIACJal/D8TGbUWd6
	azJYE/4+bjp1H178pDYP69XPCRymIk8EJWkHEwJE5dqE/QiMyRmYFOR86lRIV2C4mtZYDvEJ/Kf
	HfRlQm7/pe2OwMaSLxpuSKHPMPy5bHXuqDd7DWKWHbEf+gye3ZZdqDsUU4mVXYXSiI019
X-Gm-Gg: AeBDietQ45O3ujAIDqn7KGS6Y6Hu8nA+fTBB1yKuBx85EPPuQr+9RtAOj54lNxSzj91
	/zI4EHNAvkHDG2TzVcPSTN4QHYgixVWyoct+lxWRJmq6Wc0JLTD4b37TuUCTu3+bFWyMir8krcW
	F6apFRTfTISHs3hM9yBZTAgWwbxDtxA+hv+TiIenzvuTPw8i0R7gqHk+HByjUENX70NG7bwZlD0
	kitFaqQOB6fIHph6KOJTyrcofNQ2wbo6q6w9/k7vtfiSQGB4oBWWfthwtdiM5rYtRS9WRZfG9ZO
	eGaMLmhPgTpH/8/0jcioo55PPevbnk3sb3qBjB0s0BoHF4lS8uASndf9lFBVkLNGhoSu0QYI3iY
	j8GSeObbdI9uv2Bd57ZaDtcYzQ4lhynsjcnbbwW+wBAKG3thpkfPjnIzJD/Yp4jo=
X-Received: by 2002:a05:600c:811a:b0:48a:674d:e756 with SMTP id 5b1f17b1804b1-48e51f36569mr193210525e9.20.1778236718691;
        Fri, 08 May 2026 03:38:38 -0700 (PDT)
X-Received: by 2002:a05:600c:811a:b0:48a:674d:e756 with SMTP id 5b1f17b1804b1-48e51f36569mr193209945e9.20.1778236718109;
        Fri, 08 May 2026 03:38:38 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e642e2b29sm26082845e9.1.2026.05.08.03.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:38:37 -0700 (PDT)
Date: Fri, 8 May 2026 12:38:32 +0200
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
Message-ID: <af28MAV0LF4qHVmB@sgarzare-redhat>
References: <20260508092330.69690-1-sgarzare@redhat.com>
 <20260508055125-mutt-send-email-mst@kernel.org>
 <af2y2Fyp7H-om-ur@sgarzare-redhat>
 <20260508063104-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260508063104-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Jzdum0iJZFnXVuxIe1hjdwNMea9auzepLyWUZShe8zs_1778236719
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, May 08, 2026 at 06:33:13AM -0400, Michael S. Tsirkin wrote:
>On Fri, May 08, 2026 at 12:01:50PM +0200, Stefano Garzarella wrote:
>> On Fri, May 08, 2026 at 05:53:07AM -0400, Michael S. Tsirkin wrote:
>> > On Fri, May 08, 2026 at 11:23:30AM +0200, Stefano Garzarella wrote:
>> > > From: Stefano Garzarella <sgarzare@redhat.com>
>> > >
>> > > After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
>> > > queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
>> > > buf_alloc when checking whether a new packet fits. This reduces the
>> > > effective receive buffer below what the user configured via
>> > > SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
>> > > silently dropped and applications that rely on the full buffer size
>> > > to deadlock.
>> > >
>> > > Also, the reduced space is not communicated to the remote peer, so
>> > > its credit calculation accounts more credit than the receiver will
>> > > actually accept, causing data loss (there is no retransmission).
>> > >
>> > > This also causes failures in tools/testing/vsock/vsock_test.c.
>> > > Test 18 sometimes fails, while test 22 always fails in this way:
>> > >     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
>> > >
>> > >     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
>> > >     Resource temporarily unavailable
>> > >
>> > > Fix this by introducing virtio_transport_rx_buf_size() to calculate the
>> > > size of the RX buffer based on the overhead. Using it in the acceptance
>> > > check, the advertised buf_alloc, and the credit update decision.
>> > > Use buf_alloc * 2 as total budget (payload + overhead), similar to how
>> > > SO_RCVBUF is doubled to reserve space for sk_buff metadata.
>> > > The function returns buf_alloc as long as overhead fits within the
>> > > reservation, then gradually reduces toward 0 as overhead exceeds
>> > > buf_alloc (e.g. under small-packet flooding), informing the peer to
>> > > slow down.
>> > >
>> > > Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
>> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> >
>> >
>> > unfortunately, this is a bit of a spec violation and there is no guarantee
>> > it helps.
>>
>> Loosing data like we are doing in 059b7dbd20a6 is even worse IMHO.
>>
>> >
>> > a spec violation because the spec says:
>> > Only payload bytes are counted and header bytes are not
>> > included
>> >
>> > and the implication is that a side can not reduce its own buf_alloc.
>> >
>> > no guarantee because the other side is not required to process your
>> > packets, so it might not see your buf alloc reduction.
>> >
>> > as designed in the current spec, you can only increase your buf alloc,
>> > not decrease it.
>>
>> We never enforced this, currently an user can reduce it by
>> SO_VM_SOCKETS_BUFFER_SIZE and we haven't blocked it since virtio-vsock was
>> introduced, should we update the spec?
>
>
>it's not that we need to enforce it, it's that all synchronization
>assumes this. as in, anyone can use an old copy until they run out
>of credits.
>
>
>> >
>> > what can be done:
>> > - more efficient storage for small packets (poc i posted)
>> > - reduce buf alloc ahead of the time
>>
>> That's basically what I'm doing here: I'm using twice the size of
>> `buf_alloc` (just like `SO_RCVBUF` does for other socket types) and telling
>> the other peer just `buf_alloc`.
>>
>> But then, somehow, we have to let the other person know that we're running
>> out of space. With this patch that only happens when the other peer isn't
>> behaving properly, sending so many small packets that the overhead exceeds
>> `buf_alloc`.
>>
>> Stefano
>
>what is "not proper" here, it is up to the application what to send.

Sure, but here we're just slowing down the application by telling it we 
don't have any more space.

Again, without this patch we are just dropping data, which IMO is even 
worse.

So I think we should merge this for now, while we handle better the EOM.
If you prefer, I can drop the part where we reduce the buf_alloc 
advertised to the other peer, but at least we should drop data after 
`buf_alloc * 2` IMO.


Stefano

