Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B14A18C008
	for <virtualization@lists.linux.dev>; Sun, 10 May 2026 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420458; cv=none; b=RnB5S037bCiz7G3IarWSMDTZkt4cfcQyzMRwBe0Qdr6WYKpQH4C26WCbKy3gY8r+Z3f0aG20Adxn/0pvYsT2u7ai++Uc7783ZJPg9Ve7+7bEFg9AmXPpvo6+wRKP2nAQY7KJ/uB1LhsJEmXW/FnOt7I0Nk2GCwZsIlfZl2Ly4w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420458; c=relaxed/simple;
	bh=pN3+xf+lvplk/XSDKnk1tzXRm+HoHaTy2CDzov5pZOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZKVkJ9tHlumoduDWrzXZuITAcYyuroZ9xYYXd5Km+8riAakXndn8WMyKcDreiRZRUYSFsMfqi9ydkXvGxOOseEgU8A5hfiu/YzKXSncN0BN4sGA98tYpqERB/ya39J7LAwMQq92dDkj0eB2csQym2U+LRtJgHk2Pz9PJGhC1KGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ckIxGIhy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckIxGIhy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778420455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L7Q24s236I9i1NyfkoKYidKcVPTH3QXz7TWxO8KOigQ=;
	b=ckIxGIhyimV7gcBE7y2xX625HiGY0TqfEd6eOsVHEFTPHj5xM+rUr/+pXd2KNIrte3zcAI
	sEjG2cHs18T2JtpesjhBk3h8haoW9yem5v5xBtyKPHxYqtj5v/bN138QN1I/pn2uXPlLcE
	tRpqM43TijYGHfKWQAovS6cYCPMl5TE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-B4meiuzLOtOtuSv4BYW0Iw-1; Sun, 10 May 2026 09:40:53 -0400
X-MC-Unique: B4meiuzLOtOtuSv4BYW0Iw-1
X-Mimecast-MFC-AGG-ID: B4meiuzLOtOtuSv4BYW0Iw_1778420453
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a589c7879so34625485e9.1
        for <virtualization@lists.linux.dev>; Sun, 10 May 2026 06:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778420453; x=1779025253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7Q24s236I9i1NyfkoKYidKcVPTH3QXz7TWxO8KOigQ=;
        b=mEsQmRA5Wg3NPvbj8jTbPxAmz/jc+T5Hx+oLIxxtQZIMSnWXPWiGV5uo/yewRjTKf5
         ZgJg2e1k3t9vqol9gpCxd9TMIIDNW2VUlkj7CKjITOxAbGemQuFbLAbRZ/bdFSWQ3SC/
         e698aIbyo0SaV0HdRNO2BY19K3A+9po6Fetu9uczX303dtqWbKs3/47ZBBeoZSEIsuAu
         wOQiWPd9fTduqACXCLzpebfhfJNQ8hMrUDjxKbZfyyuOPbkrygCuLThb/m81jG4ol6wa
         AP6fVtO4ZsWsyPs/ZgQJsMmvx3nLqo2RBS5qGO4GwVBlBk8+b8+F/O+II82B/aNfSfjV
         oaOg==
X-Forwarded-Encrypted: i=1; AFNElJ8xe8WSntuXEo0G4B+XKkxYf2SibXZjt94R3q8nPgw8dAbgMCLzbMyn9xBCw3aofsrhDfr4XVstUjYgK0LwRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHiOLqVI2/lC6p9m4deNZgtntfhk8TcV08wDgEPr62kLOuFNb0
	ZMARfRy6ezEXeZnQWbg5/7o00VO2ACB2c/cjCygTimeLDs6/wUr0nAIBBBKiXOnfYtopLfeicoA
	io4qyKs/2i6UFWIW5Wh1Tjvfr9/9kA7PxTfx9HzvFeZyozTFoPIekL5+qIujHOqwg+7n9
X-Gm-Gg: Acq92OETX1D0IwBtmyMfRyg4Y0vrINbNjRly++O8WDOiMMKVIz6T/itXcj5usTicrU1
	Cv2YuXFPJIwf0y07S93eTyMHSQ2d94YayP6Bw+O6/CEMzXb3Gt6CefOxom9ZMxQR6RvRGRtaAHn
	ylXGqQ8BBws2UOqe2DbOTDvTvWaMG5VNtmVKoJ0oHKBP10etSRXc7IlG6rnlQPvua7FXBW0j5rA
	hQgogc9HZWrhrWZkhSyogX2undXEQjpti1EApgQR4XBfwTonMmsna6H751zhJviEHR1C9pFa2N6
	ESHt7XCus7LiDpzWSKChlkAaKzwxYMfhxZl5EQJzsAUwEKwcMPVsyydr3UU2Ed0pqpV47ioK4Mg
	RtEOUGG/t5j8ZAwSpTTrzODvTs3P+vPjHeWRqIpcQ
X-Received: by 2002:a05:600c:638e:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-48e5e00c1b9mr231940905e9.14.1778420452515;
        Sun, 10 May 2026 06:40:52 -0700 (PDT)
X-Received: by 2002:a05:600c:638e:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-48e5e00c1b9mr231940315e9.14.1778420451950;
        Sun, 10 May 2026 06:40:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d8e4ce1sm43533835e9.9.2026.05.10.06.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 06:40:51 -0700 (PDT)
Date: Sun, 10 May 2026 09:40:47 -0400
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
Message-ID: <20260510094020-mutt-send-email-mst@kernel.org>
References: <20260508151048.183125-1-simon.schippers@tu-dortmund.de>
 <20260508151048.183125-2-simon.schippers@tu-dortmund.de>
 <dd0a3ef1-d623-4e09-a391-b56fa4bf95af@tu-dortmund.de>
 <20260509183518-mutt-send-email-mst@kernel.org>
 <a14b700a-94e8-44c0-bde0-d8307761c0f1@tu-dortmund.de>
 <9a4458fc-61f2-469b-8260-f144d3827b5d@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9a4458fc-61f2-469b-8260-f144d3827b5d@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qCcPasRTDpPs2-KWQRmIqpPEOaZp2jp55sJ52ySyibk_1778420453
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 10, 2026 at 10:55:34AM +0200, Simon Schippers wrote:
> On 5/10/26 09:03, Simon Schippers wrote:
> > On 5/10/26 00:44, Michael S. Tsirkin wrote:
> >> On Sat, May 09, 2026 at 06:31:47PM +0200, Simon Schippers wrote:
> >>> On 5/8/26 17:10, Simon Schippers wrote:
> >>>> +static void tun_queue_purge(struct tun_struct *tun, struct tun_file *tfile)
> >>>>  {
> >>>>  	void *ptr;
> >>>>  
> >>>> -	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
> >>>> +	while ((ptr = tun_ring_consume(tun, tfile)) != NULL)
> >>>>  		tun_ptr_free(ptr);
> >>>>  
> >>>>  	skb_queue_purge(&tfile->sk.sk_write_queue);
> >>>
> >>> Sashiko is right once again. tun_ring_consume() in tun_queue_purge()
> >>> operates on a tfile that is being torn down. Its queue_index is no
> >>> longer valid. After the swap in __tun_detach(), it points to the
> >>> netdev subqueue of a different tfile.
> >>> --> We should not wake there.
> >>
> >> Does it not exactly point at ntfile which is what we want to wake?
> >>
> > 
> > I see your point. But calling tun_ring_consume() as done here is
> > wrong, because it does not wake if the tx_ring of the tfile 
> > (that is currently torn down) is empty. We could change
> > tun_ring_consume() to call __tun_wake_queue()
> > with consumed=0 if !ptr but I think this would slow down the consumer
> > path.
> >
> 
> My statement is wrong:
> There is no way that the tx_ring is empty and the queue is stopped
> at the same time. So we do not need to touch tun_ring_consume() and
> this works just fine.
> 
> >>
> >>> I will swap tun_ring_consume() with ptr_ring_consume() again and
> >>> submit a v12 :)
> >>
> >> If so then maybe
> >> netif_tx_wake_queue(netdev_get_tx_queue(tun->dev, index));
> >>
> > 
> > But we should only do this if there is space in the ntfile.
> > My approach:
> > 
> > @@ -586,12 +588,18 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
> >  		BUG_ON(index >= tun->numqueues);
> >  
> >  		rcu_assign_pointer(tun->tfiles[index],
> >  				   tun->tfiles[tun->numqueues - 1]);
> >  		ntfile = rtnl_dereference(tun->tfiles[index]);
> > +		spin_lock(&ntfile->tx_ring.consumer_lock);
> >  		ntfile->queue_index = index;
> >  		ntfile->xdp_rxq.queue_index = index;
> > +		ntfile->cons_cnt = 0;
> > +		if (__ptr_ring_empty(&ntfile->tx_ring)) {
> > +			netif_wake_subqueue(tun->dev, index);
> > +		}
> > +		spin_unlock(&ntfile->tx_ring.consumer_lock);
> >  		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
> >  				   NULL);
> > 
> > ntfile->cons_cnt is unvalid, because the new queue might not be stopped.
> > That is the reason why I reset it to 0.
> 
> However, I still prefer this approach because the code is easier to
> understand.


So do you want me to finish review of this one and ack, or want to
post v12?

