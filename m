Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA75E306D26
	for <virtualization@lists.linux.dev>; Sun, 10 May 2026 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778437689; cv=none; b=T3J7AKeHKBlOatsqYbrAcGknY7QWX63ewFGxJdZEP3el+tE/l2bQBL7JpQ5oTib390eG4nW9vWTUg/kxv7HKbnss0LYuJ1tuWelTbei78wMNFwM39qjxOIUmLfqTa497Zs3Zibxi9wydqJQaORnrNQWyYAkFncwRCACDhh8V/wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778437689; c=relaxed/simple;
	bh=Nds78ZQv+k1dBd4zeRMpIKfcLCYRSolg2HIQ5VEH2Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=T7BGhH0SshE9rqHIklbKfXfVvBPwQD26+TxmvJNV9tyot2yC2aSdlooEg38GIsJ3zk2aXcYs/VyKXNiakVk2ALcFjywZQ8nkTyJV7txqL+T5oHlPLaTLxEFm4kVEzfv7Vljc5+JrMYFz2gvMODKmoRF/TZ+pEYDGVZF83QhdHY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHIipxFb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHIipxFb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778437686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20vi7jjXaNmaH582QbUJViOW3O2EFOcheWh4ZH6Qnn8=;
	b=VHIipxFbEHGwZaYI7LqGUZST0hQX1sOmcdJkNyxRVDsx648nS2Md+FUOrIOtj5O3OT5b/i
	RA2IF6vixT3mBL8etA1N09SOsmWNnSRZ/KxVtDBzVk0ZY525cduC0cF0ljuvlrP1T20laR
	BoM2vZkgstkqvw7TlVBU5dkXGHWi8TY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-Y9REULrJNTe0JwngMbV-vw-1; Sun, 10 May 2026 14:28:05 -0400
X-MC-Unique: Y9REULrJNTe0JwngMbV-vw-1
X-Mimecast-MFC-AGG-ID: Y9REULrJNTe0JwngMbV-vw_1778437684
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d789cebcfso3250953f8f.1
        for <virtualization@lists.linux.dev>; Sun, 10 May 2026 11:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778437684; x=1779042484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20vi7jjXaNmaH582QbUJViOW3O2EFOcheWh4ZH6Qnn8=;
        b=iOwZkOYLDdWvC47fuyeB6+tjwnTREV9EBpVrt2jOoFA7vLUH0FjOrR+M2dIs1YLoCb
         BidSZNDFv0KFbknJd4menWzKYlqsRyRokn5xOdhaIIP12a9v04TUbZk5w5bsFnmh/NfU
         +MFm25AcOr6PqVbap+TIrZuvDITBc1s8+mF4/vxSpaBJhLWNkn8yhR6nBh9vw/lteRUy
         fuh2VZ0TJWigEFt49C8LmP183ougmHr5x5cRn6ZxtCk5zI29pu9MgAfrxO3Wt4YOmSKR
         hQEfhTRKOe2QB4bbjUBWegDyVDiVJ6gyX8y6Iy9QXG+RQ9wHb4wQVpm/u3WRryVi3hcc
         0log==
X-Forwarded-Encrypted: i=1; AFNElJ8N+b+jnVpCVX6Tega3aFuvWT4ZPBr/0vsaQeLuQ2jU2xwHBQcwYpyKplvT0KuLsqgV5DNT1Sh6WDWyPHyqnw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPddno1YIjnlceLuzg6l9J6dlMDQzqPgI5QMOfSPpudxMoUCyD
	3jPzI6rHyXkr9A4vX0ASz9rNljbazSDg6rd+EaA83mMCdgunxtWkxi2jxLjisyxhgHx1jXObhqU
	Ic9Bzyxin+AO4ZwiEcT+W7WCwnMmyvPdqta6TIuzepsZq8dcQncFvNvF2r018EckgHDmD
X-Gm-Gg: Acq92OGlngg5NX+47UoUSRUYbwgmsipLOkAr4iMOuUoNq6DxvWG1MfRXyeR06o9al6k
	PAY6Ikr0rbpTfAoz89yhkTkpJM6GWXHOOUqgGyqThIyJi6e+0KGiHbp/RC1iVr2BphNtINwmbQg
	EZBWhZWOj3VBxRZ9hZQioNEukfqrYGhLV1/ZnaaCZAGrBpfnOfBl3Allg0MOY7dS80y5giLpRmb
	H+1fCZzJ7eKn5+LYNZrtcPi8E5JVUGcbkbld9Kw8qQFRN9fnIUBNDXwUc1a7m93lHssTvcxLJRv
	x/YKdT1OHNynGT1EYGOe+wly+Ebo76rWGtD5oDRL+rYzNHJjp0b74et4ru85Mdc0jrJYl/hvmhD
	wnjDeX/5fK/zNgFTyjkb5jWgk4BO5LhBSnJ2Fs3BP
X-Received: by 2002:a05:600c:c0d8:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48e5e000c1cmr177492265e9.12.1778437683982;
        Sun, 10 May 2026 11:28:03 -0700 (PDT)
X-Received: by 2002:a05:600c:c0d8:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48e5e000c1cmr177491905e9.12.1778437683333;
        Sun, 10 May 2026 11:28:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e7040a9a9sm225839165e9.9.2026.05.10.11.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 11:28:02 -0700 (PDT)
Date: Sun, 10 May 2026 14:27:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v11 1/4] tun/tap: add ptr_ring consume helper
 with netdev queue wakeup
Message-ID: <20260510142743-mutt-send-email-mst@kernel.org>
References: <20260508151048.183125-1-simon.schippers@tu-dortmund.de>
 <20260508151048.183125-2-simon.schippers@tu-dortmund.de>
 <dd0a3ef1-d623-4e09-a391-b56fa4bf95af@tu-dortmund.de>
 <20260509183518-mutt-send-email-mst@kernel.org>
 <a14b700a-94e8-44c0-bde0-d8307761c0f1@tu-dortmund.de>
 <9a4458fc-61f2-469b-8260-f144d3827b5d@tu-dortmund.de>
 <20260510094020-mutt-send-email-mst@kernel.org>
 <e5d69f44-4483-49f3-b7fc-aca2cdb24792@tu-dortmund.de>
 <20260510114401-mutt-send-email-mst@kernel.org>
 <5f39493e-b2f0-446b-9896-98a074f5ed6b@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5f39493e-b2f0-446b-9896-98a074f5ed6b@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3CDPK0zFHFEakEOgLqlNe4M0R91s9jM-WUGqfKRdW2k_1778437684
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 10, 2026 at 06:22:15PM +0200, Simon Schippers wrote:
> On 5/10/26 17:44, Michael S. Tsirkin wrote:
> > On Sun, May 10, 2026 at 04:01:39PM +0200, Simon Schippers wrote:
> >> On 5/10/26 15:40, Michael S. Tsirkin wrote:
> >>> On Sun, May 10, 2026 at 10:55:34AM +0200, Simon Schippers wrote:
> >>>> On 5/10/26 09:03, Simon Schippers wrote:
> >>>>> On 5/10/26 00:44, Michael S. Tsirkin wrote:
> >>>>>> On Sat, May 09, 2026 at 06:31:47PM +0200, Simon Schippers wrote:
> >>>>>>> On 5/8/26 17:10, Simon Schippers wrote:
> >>>>>>>> +static void tun_queue_purge(struct tun_struct *tun, struct tun_file *tfile)
> >>>>>>>>  {
> >>>>>>>>  	void *ptr;
> >>>>>>>>  
> >>>>>>>> -	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
> >>>>>>>> +	while ((ptr = tun_ring_consume(tun, tfile)) != NULL)
> >>>>>>>>  		tun_ptr_free(ptr);
> >>>>>>>>  
> >>>>>>>>  	skb_queue_purge(&tfile->sk.sk_write_queue);
> >>>>>>>
> >>>>>>> Sashiko is right once again. tun_ring_consume() in tun_queue_purge()
> >>>>>>> operates on a tfile that is being torn down. Its queue_index is no
> >>>>>>> longer valid. After the swap in __tun_detach(), it points to the
> >>>>>>> netdev subqueue of a different tfile.
> >>>>>>> --> We should not wake there.
> >>>>>>
> >>>>>> Does it not exactly point at ntfile which is what we want to wake?
> >>>>>>
> >>>>>
> >>>>> I see your point. But calling tun_ring_consume() as done here is
> >>>>> wrong, because it does not wake if the tx_ring of the tfile 
> >>>>> (that is currently torn down) is empty. We could change
> >>>>> tun_ring_consume() to call __tun_wake_queue()
> >>>>> with consumed=0 if !ptr but I think this would slow down the consumer
> >>>>> path.
> >>>>>
> >>>>
> >>>> My statement is wrong:
> >>>> There is no way that the tx_ring is empty and the queue is stopped
> >>>> at the same time. So we do not need to touch tun_ring_consume() and
> >>>> this works just fine.
> >>>>
> >>>>>>
> >>>>>>> I will swap tun_ring_consume() with ptr_ring_consume() again and
> >>>>>>> submit a v12 :)
> >>>>>>
> >>>>>> If so then maybe
> >>>>>> netif_tx_wake_queue(netdev_get_tx_queue(tun->dev, index));
> >>>>>>
> >>>>>
> >>>>> But we should only do this if there is space in the ntfile.
> >>>>> My approach:
> >>>>>
> >>>>> @@ -586,12 +588,18 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
> >>>>>  		BUG_ON(index >= tun->numqueues);
> >>>>>  
> >>>>>  		rcu_assign_pointer(tun->tfiles[index],
> >>>>>  				   tun->tfiles[tun->numqueues - 1]);
> >>>>>  		ntfile = rtnl_dereference(tun->tfiles[index]);
> >>>>> +		spin_lock(&ntfile->tx_ring.consumer_lock);
> >>>>>  		ntfile->queue_index = index;
> >>>>>  		ntfile->xdp_rxq.queue_index = index;
> >>>>> +		ntfile->cons_cnt = 0;
> >>>>> +		if (__ptr_ring_empty(&ntfile->tx_ring)) {
> >>>>> +			netif_wake_subqueue(tun->dev, index);
> >>>>> +		}
> >>>>> +		spin_unlock(&ntfile->tx_ring.consumer_lock);
> >>>>>  		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
> >>>>>  				   NULL);
> >>>>>
> >>>>> ntfile->cons_cnt is unvalid, because the new queue might not be stopped.
> >>>>> That is the reason why I reset it to 0.
> >>>>
> >>>> However, I still prefer this approach because the code is easier to
> >>>> understand.
> >>>
> >>>
> >>> So do you want me to finish review of this one and ack, or want to
> >>> post v12?
> >>>
> >>
> >> I will post a v12 with the proposed changes for patch 1.
> >> No other changes.
> >>
> >> Thanks!
> > 
> > actually can you clarify? why only when ntfile ring is empty?
> > 
> 
> This avoids waking when ntfile->tx_ring is full. We can not use 
> __ptr_ring_can_produce() with consumer locks, therefore I chose
> __ptr_ring_empty() instead.
> 
> If there are any elements in ntfile->tx_ring we do not have to wake.
> This will be done by the consumer in tun_ring_consume() &
> __tun_wake_queue() after consuming those elements.

worth a code comment if you need to do v13.

