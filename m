Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487BC28FD
	for <virtualization@lists.linux.dev>; Sun, 29 Jun 2025 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751218098; cv=none; b=XZLpmlAPVq568OMhdVctcIGqnDaZCgHj8qK/quIwUw0c4h+qYJZPHWbt5DTkI9ui3YqrBIJ/JunBjX366Ae+LaX0qYPmIQEyyTBXP9ms6egmucZLst2jMdZzmgAethGI3YSQxkIfo2w8lXbjAl2ol5NmqOu2X0OuXe20A/g+Wts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751218098; c=relaxed/simple;
	bh=J9YDXD4duvC3Wk7QUO6r6W8l64XMHZU2uOpTsU+NisY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gP6mR3++35SusQWwSl0LqRvSDCiYnIRHELU6/VzavCBdpXViVVYXeovswZBBVtpfPiJPagJPuD14lMJRU97AhXYoguGa/bUIvFdkpnv0SraAviBePuPdm8c1qS6ohENOMqbeVrBVIK6ulnywrokt6Y9dEavhhMY+gXP7BkUlOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+Bv1vDT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+Bv1vDT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751218095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uGHkUjNmjIIMPgTkRg7VREABnqYi+wWbJyf4AWH8+h8=;
	b=R+Bv1vDT+AUEJpcGcfqk+fS/E5i1npJihQoy0USLkBM/6uKWC69SDk1poRYSAX1B1BNGys
	tRj4bQDx0Cpcs+RV5AL5NZJQFMkrikPqbHKYSHiXicLIZpUtmPogxcAUa2p16Tu64lrDp7
	igwDSSQTSE5/57Lonc42jwplefjerCc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-lZUvi4wEOreqInK1iCAKUA-1; Sun, 29 Jun 2025 13:28:13 -0400
X-MC-Unique: lZUvi4wEOreqInK1iCAKUA-1
X-Mimecast-MFC-AGG-ID: lZUvi4wEOreqInK1iCAKUA_1751218093
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45359bfe631so16836295e9.0
        for <virtualization@lists.linux.dev>; Sun, 29 Jun 2025 10:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751218092; x=1751822892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGHkUjNmjIIMPgTkRg7VREABnqYi+wWbJyf4AWH8+h8=;
        b=JgFLV9F8csRILslSBfyYuXAm6gTHANMDvr0pRhba/ftUXcSGAowMRusjhOoRIOkCHz
         Z6s8LWiIPcdIaplQv2DBwG0lyUT7+OvIY5m3m7JtqcBQynvgHQssh/FKTQc98eB0gwty
         mPeXzb2LoVbchGwd/SVU4H9NmC9jDV6bgGJ5lvqCAzqQQrDCnOybpg9LzzdBjEh+ma10
         mH6MZCXSCP9qghDwX44GSHlBLr1juRvz8wCqpUJhFzjumvl+DoRjLTlHm+bhkifiIWpm
         0JOp33bXZL6uO7GWWyQDbH0ftco4DTIeVlXJM1JNix7HjJyRh9qcQy8Gf7/qeqbElmtN
         NbMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUayi+YtKgP06Bi2FOOUgLPsoe7I0BK0O4v+jQf8L5xELZ+48TG8M1++fkqO2ETOaxiVMIStugT0jAXKTLSSg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4g2/W9+dOL4VIX+MRbjac4CmUmPkh6Cgvc+4NcrUujAVzV+5z
	J//v0vkc/uBNzzsWNNYWW9kawzEB/f/YrnCxs9laxBQDJKjvxv8fJ0IapGKo4nHNgE91jewqwJF
	haCTBt/o8Zxkuspt/AdE+mLatYENSkbtTsQd6TeXAOQb5fDlANF98nwcJfe2FRxG6EEGp
X-Gm-Gg: ASbGncuOve8NK/6RMCHfoqHDrH9jPYRg151dQE6P8ZMDkPFDzNMyvuZ/iT68IV/iSPH
	A299qB/gLBzMOzJiQTyNZ6OwIZdFgIfsOVBRRJjMmXGsp0EvZ5o5e6bSIS0+D97ynxBeNkv/M3L
	pmB2uNd8Esdv7ajHDafvyUBaCwu7ae1TF6qN8DslapzGJWRsbZ4yTkfgvgagLqoLLfSQN8WR0zj
	gMwLtVWgmgkaW55LR9BYTvT+A9VGMrXcagCpXIAuYen5+s+ZduNnemZtcA7LffcrfQ6lEIV33pM
	B/iRzciYT5b5eIlG
X-Received: by 2002:a05:600c:6095:b0:43c:f0ae:da7 with SMTP id 5b1f17b1804b1-4538ee504demr102969625e9.7.1751218092527;
        Sun, 29 Jun 2025 10:28:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9HJ2OfndwPMREYIRxXW8JXGourHIYbXzVyfj8L8gZMgZLg5HRsqQ4PckajVtmi25Hd1plTA==
X-Received: by 2002:a05:600c:6095:b0:43c:f0ae:da7 with SMTP id 5b1f17b1804b1-4538ee504demr102969455e9.7.1751218092114;
        Sun, 29 Jun 2025 10:28:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e59736sm8185715f8f.74.2025.06.29.10.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 10:28:11 -0700 (PDT)
Date: Sun, 29 Jun 2025 13:28:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Parav Pandit <parav@nvidia.com>,
	virtualization@lists.linux.dev, stefanha@redhat.com,
	alok.a.tiwari@oracle.com
Subject: Re: [PATCH RFC] pci: report surprise removal events
Message-ID: <20250629132113-mutt-send-email-mst@kernel.org>
References: <11cfcb55b5302999b0e58b94018f92a379196698.1751136072.git.mst@redhat.com>
 <aGFBW7wet9V4WENC@wunner.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aGFBW7wet9V4WENC@wunner.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 89UyiFDe7N2vB4z50RfMuWqLKLE21W1bVkXV0rM7sk4_1751218093
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 29, 2025 at 03:36:27PM +0200, Lukas Wunner wrote:
> On Sat, Jun 28, 2025 at 02:58:49PM -0400, Michael S. Tsirkin wrote:
> > At the moment, in case of a surprise removal, the regular
> > remove callback is invoked, exclusively.
> > This works well, because mostly, the cleanup would be the same.
> > 
> > However, there's a race: imagine device removal was initiated by a user
> > action, such as driver unbind, and it in turn initiated some cleanup and
> > is now waiting for an interrupt from the device. If the device is now
> > surprise-removed, that never arrives and the remove callback hangs
> > forever.
> > 
> > Drivers can artificially add timeouts to handle that, but it can be
> > flaky.
> > 
> > Instead, let's add a way for the driver to be notified about the
> > disconnect. It can then do any necessary cleanup, knowing that the
> > device is inactive.
> [...]
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -549,6 +549,15 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
> >  	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
> >  	pci_doe_disconnected(dev);
> >  
> > +	/* Notify driver of surprise removal */
> > +	device_lock(&dev->dev);
> > +
> > +	if (dev->driver && dev->driver->err_handler &&
> > +	    dev->driver->err_handler->disconnect)
> > +		dev->driver->err_handler->disconnect(dev);
> > +
> > +	device_unlock(&dev->dev);
> > +
> >  	return 0;
> >  }

thanks for the feedback. Would appreciate a couple more hints:

> No, that's not good:
> 
> 1/ The device_lock() will reintroduce the issues solved by 74ff8864cc84.

I see. What other way is there to prevent dev->driver from going away,
though? I guess I can add a new spinlock and take it both here and when
dev->driver changes? Acceptable?

> 2/ pci_dev_set_disconnected() needs to be fast so that devices are marked
>    unplugged as quickly as possible.  We want to minimize the time window
>    where MMIO and Config Space reads already return "all ones" and writes
>    go to nirvana, but pci_dev_is_disconnected() still returns false.
>    Hence invoking some driver callback which may take arbitrarily long or
>    even sleeps is not an option.

Well, there's no plan to do that there - just to wake up some wq so
things can be completed. I can add code comments.

> The driver is already notified of removal through invocation of the
> ->remove() callback.  The use case you're describing is arguably
> a corner case.  I do think that a timeout is a better approach
> than the one proposed here.  How long does it take for the interrupt
> to arrive?

It's a virtual device - kind of unpredictable.

>  If it's not just a few msec, consider polling the device
> and breaking out of the pool loop as soon as pci_dev_is_disconnected()
> returns true (or the MMIO read returns PCI_POSSIBLE_ERROR()).

Yes but with no callback, we don't know when to do it.
The config reads in pci_dev_is_disconnected are also expensive
on VMs...

> If/when respinning, please explain the use case in more detail,
> i.e. which driver, which device, pointers to code...
> 
> Thanks!
> 
> Lukas


It's virtio-blk. 

