Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C4E3A0B39
	for <virtualization@lists.linux.dev>; Sun, 10 May 2026 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778427886; cv=none; b=BtQbdro44Meya0gU3LTD1zK+hBArY8G8d7H5Xb9cPP31tQvGSOHaZDLQpsEmvy7T5AADMtp717WpBVVD6bNce3M1IqZEiHCRd4gsVmBhIPFB6q4pWY2UWfGDHOaWG2h6ReVu389zfyklr29UO+API+lfqxGHjhDzJergqG03Uew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778427886; c=relaxed/simple;
	bh=oCHlo1fqZatJDIDvyJ1SrB7bwf2coY5WCAjVkHb+KpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MrjPvgc5GOPIFFKaNTjoUXsOEfR0Z6oiN2goDiUe6Vp4Vh1RCmAF0ZEZONdo5DyFUBOVNyVsvZanWbvljKGFAd7ZGYAUrZBahXYWr5LUut309KNXp5nLoLwVQKj7aNf+mrUBREsIFby4CeQ2AhVzFBVzFODTBALesrnCJ9MbJ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TsSaEtVL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsSaEtVL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778427883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7jk9H54lMHadSFms9Swh2u6zzH7MNV3xP2hPzoWhQ7I=;
	b=TsSaEtVLqEoQvoOofITICYEp6wj1qZcUULsJ+tO6NZvonMK5YVzdK4hiDC4pBrF6FtK9cy
	dEHyh8xnWTbHisUMzK1GyYoYCOYn1wS1QcoGqAkI9O4ZDWm5AnBXa9di/BudTWdGOjQ3+S
	jdw/cMYKXcIjI4hrxPSPqNKe8K6/DDk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-CkSeZcKZPACV6ye6J2qqzA-1; Sun, 10 May 2026 11:44:40 -0400
X-MC-Unique: CkSeZcKZPACV6ye6J2qqzA-1
X-Mimecast-MFC-AGG-ID: CkSeZcKZPACV6ye6J2qqzA_1778427879
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3939de90af6so18585591fa.3
        for <virtualization@lists.linux.dev>; Sun, 10 May 2026 08:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778427879; x=1779032679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jk9H54lMHadSFms9Swh2u6zzH7MNV3xP2hPzoWhQ7I=;
        b=X4uzWI1mw5zLxowkbgkpO/RKzxyKvTiI+dXHQkx54A3NancprlUMUs/pCZhNiQv0Yr
         8qnpovoU61SOyR3hMj7V0Sr7reriUUW9sYDxBQMzVJH/uidqZIW++qW+2adYazrSfTkN
         KpH2Zm/AKAKdGqKdvuac8KcVBbAdmeBlnxKe9CSB4QP8qNUakjYFPoE5utc0J0/BYT15
         BuP/kAF2dD5NMN9mAO7L7jCkTYD+nj10//osejhD4rhtOx18uYdYN7b7VYvPwpMiB5uP
         pgIV+r8ss3swc5wxZwfcP7QJMZSZT3raG+G+YRy+4mcibTaRhEt8oPhkN6EcFwKyykKj
         no2g==
X-Forwarded-Encrypted: i=1; AFNElJ9+eN2ncoFLef0VeAM8UyO3IooOSEYm95Hw9q7WxGUZcx3e9g9L0o1raIhomw/D4KH5EJiIJjDM6hvUaVCzZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKAwvLLpCs+2FRIpIIfKQWWacys6/LyXEZZ1q6/G5h+3niBSWz
	xoIoLKjFgwjHGx2iAIxKV1eH9++zcuhgDzK4wsEjqIKsRRUDxl338yEypC8AbeMJgjeW/QqMn1d
	1NIpDVOVnk8S8VUWloHVpKgTbcrDp83xyBLHTCG6wttibCykv07nNgC1sxPuHPCGYqf/v
X-Gm-Gg: Acq92OHv8pRicCIwiEdpUZxiyEVoniFC7nbZsrHsZdtUxzaCIjtCcGhcwJoFzIRc4Vg
	3XoxcLoeaZFzcfeIpsZPbHVnlBWY4N2Yg5dnxW6TYBocOf5F+DQoxViPtXrIYc2Ui+xNidc0xB1
	zElah0TsVVu0pF9jSrFqCAMvpn15ERlTn5GVIO9oWucecsA7WvfgeyQng+MWZo+eEmLKYCcHfmp
	+A4TLTQ9RgYTgwTjRK6aqKUxZiSOgQCCKhtLvUq1v87Oe7dGZz/xYgKmmDvo0LSHhX2vIiMqMWp
	bUm2sdYIL2VQO/zwV7kQULsTuJQSwinC6+5/MUNMFiUlLHbiB/BGtjsGdowdbVnnySHeK4L8PkW
	CFG5InOFIBQBIPwAntZ9aOd8ypAougE+LQ/lWTqbZ
X-Received: by 2002:a05:651c:54e:b0:38e:e6fd:65b2 with SMTP id 38308e7fff4ca-39408132229mr19263591fa.21.1778427879025;
        Sun, 10 May 2026 08:44:39 -0700 (PDT)
X-Received: by 2002:a05:651c:54e:b0:38e:e6fd:65b2 with SMTP id 38308e7fff4ca-39408132229mr19263431fa.21.1778427878424;
        Sun, 10 May 2026 08:44:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f60db4f1sm19882511fa.27.2026.05.10.08.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 08:44:37 -0700 (PDT)
Date: Sun, 10 May 2026 11:44:32 -0400
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
Message-ID: <20260510114401-mutt-send-email-mst@kernel.org>
References: <20260508151048.183125-1-simon.schippers@tu-dortmund.de>
 <20260508151048.183125-2-simon.schippers@tu-dortmund.de>
 <dd0a3ef1-d623-4e09-a391-b56fa4bf95af@tu-dortmund.de>
 <20260509183518-mutt-send-email-mst@kernel.org>
 <a14b700a-94e8-44c0-bde0-d8307761c0f1@tu-dortmund.de>
 <9a4458fc-61f2-469b-8260-f144d3827b5d@tu-dortmund.de>
 <20260510094020-mutt-send-email-mst@kernel.org>
 <e5d69f44-4483-49f3-b7fc-aca2cdb24792@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e5d69f44-4483-49f3-b7fc-aca2cdb24792@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9Pqx9fKwnp2jpwjDyTPzgrEZNzf-dqDI9FJOkm9Zo1I_1778427879
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 10, 2026 at 04:01:39PM +0200, Simon Schippers wrote:
> On 5/10/26 15:40, Michael S. Tsirkin wrote:
> > On Sun, May 10, 2026 at 10:55:34AM +0200, Simon Schippers wrote:
> >> On 5/10/26 09:03, Simon Schippers wrote:
> >>> On 5/10/26 00:44, Michael S. Tsirkin wrote:
> >>>> On Sat, May 09, 2026 at 06:31:47PM +0200, Simon Schippers wrote:
> >>>>> On 5/8/26 17:10, Simon Schippers wrote:
> >>>>>> +static void tun_queue_purge(struct tun_struct *tun, struct tun_file *tfile)
> >>>>>>  {
> >>>>>>  	void *ptr;
> >>>>>>  
> >>>>>> -	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
> >>>>>> +	while ((ptr = tun_ring_consume(tun, tfile)) != NULL)
> >>>>>>  		tun_ptr_free(ptr);
> >>>>>>  
> >>>>>>  	skb_queue_purge(&tfile->sk.sk_write_queue);
> >>>>>
> >>>>> Sashiko is right once again. tun_ring_consume() in tun_queue_purge()
> >>>>> operates on a tfile that is being torn down. Its queue_index is no
> >>>>> longer valid. After the swap in __tun_detach(), it points to the
> >>>>> netdev subqueue of a different tfile.
> >>>>> --> We should not wake there.
> >>>>
> >>>> Does it not exactly point at ntfile which is what we want to wake?
> >>>>
> >>>
> >>> I see your point. But calling tun_ring_consume() as done here is
> >>> wrong, because it does not wake if the tx_ring of the tfile 
> >>> (that is currently torn down) is empty. We could change
> >>> tun_ring_consume() to call __tun_wake_queue()
> >>> with consumed=0 if !ptr but I think this would slow down the consumer
> >>> path.
> >>>
> >>
> >> My statement is wrong:
> >> There is no way that the tx_ring is empty and the queue is stopped
> >> at the same time. So we do not need to touch tun_ring_consume() and
> >> this works just fine.
> >>
> >>>>
> >>>>> I will swap tun_ring_consume() with ptr_ring_consume() again and
> >>>>> submit a v12 :)
> >>>>
> >>>> If so then maybe
> >>>> netif_tx_wake_queue(netdev_get_tx_queue(tun->dev, index));
> >>>>
> >>>
> >>> But we should only do this if there is space in the ntfile.
> >>> My approach:
> >>>
> >>> @@ -586,12 +588,18 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
> >>>  		BUG_ON(index >= tun->numqueues);
> >>>  
> >>>  		rcu_assign_pointer(tun->tfiles[index],
> >>>  				   tun->tfiles[tun->numqueues - 1]);
> >>>  		ntfile = rtnl_dereference(tun->tfiles[index]);
> >>> +		spin_lock(&ntfile->tx_ring.consumer_lock);
> >>>  		ntfile->queue_index = index;
> >>>  		ntfile->xdp_rxq.queue_index = index;
> >>> +		ntfile->cons_cnt = 0;
> >>> +		if (__ptr_ring_empty(&ntfile->tx_ring)) {
> >>> +			netif_wake_subqueue(tun->dev, index);
> >>> +		}
> >>> +		spin_unlock(&ntfile->tx_ring.consumer_lock);
> >>>  		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
> >>>  				   NULL);
> >>>
> >>> ntfile->cons_cnt is unvalid, because the new queue might not be stopped.
> >>> That is the reason why I reset it to 0.
> >>
> >> However, I still prefer this approach because the code is easier to
> >> understand.
> > 
> > 
> > So do you want me to finish review of this one and ack, or want to
> > post v12?
> > 
> 
> I will post a v12 with the proposed changes for patch 1.
> No other changes.
> 
> Thanks!

actually can you clarify? why only when ntfile ring is empty?

