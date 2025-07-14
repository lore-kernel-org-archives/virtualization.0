Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADE2223DDF
	for <virtualization@lists.linux.dev>; Mon, 14 Jul 2025 06:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752473938; cv=none; b=p3CiajndKTZDK8Uo6AgO/FEikrNozpaiT9avNfDGagkPbVeFngLbw9qE9PY1h8wkKgitKcBxY29r24d5dUZyVA3fgTKAVIfgX3Xaxhlz9MRVMgPkhaDUr3u+k7VaUBMbfGaMUj0d0orRTzX8v7UGAI1kgKTp99bcen8MBPD/n1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752473938; c=relaxed/simple;
	bh=VHG1aIFrPJUNQ533qITRdf+7pKjRccdsFYN0w/Nahjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uT4Q98xMT8TpRETVUZJBodxuu9PhA4fhj+oQd66lX9VlOdpKoqGEKPqKuClrvNactd3+EnQPcNHczF9v5fQyYJc1yZdptFwGCJSspqFCAR7olF72tl7qUTiPf5lUCu9uwTwN7jp6Il0MVt50BJ4pxU00Syt+c0gS/00HXgZkA2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hn1RA09K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hn1RA09K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752473935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaLtarIqWAh+adH9k5nWd36ANmOKF2pw7KpXjXJAWkI=;
	b=hn1RA09KE4zFsAWilzVfqgXHCbrQNuIUy9XEltWiq2p8ycfS0bvbk3Tybyv93g0JcZQF8D
	Xv+OEqfGYVImNA+lApqeOUxHLD+O1R1rUSpeLiG+n9pO5obtG3lxbUKcDi4GAjwlYlxWtA
	v0HirdPOdxwEoKBjnGJrVzAqsLusWRg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-gfamL1cCP2KPY4fYMfKpGg-1; Mon, 14 Jul 2025 02:18:53 -0400
X-MC-Unique: gfamL1cCP2KPY4fYMfKpGg-1
X-Mimecast-MFC-AGG-ID: gfamL1cCP2KPY4fYMfKpGg_1752473932
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso2031921f8f.2
        for <virtualization@lists.linux.dev>; Sun, 13 Jul 2025 23:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752473932; x=1753078732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaLtarIqWAh+adH9k5nWd36ANmOKF2pw7KpXjXJAWkI=;
        b=dZ6Uf1rRLrjcJJFkUU8GQSCp5bdFfd+3ee2xzy0/bJ9XhxiLmgS1xjCqe4YqARoYkK
         TFkBcCfHvtIm8OLfEEui22t5+Pty1WnudHM1jlcZC9plTw8MNtOXzcpHG4hDWCm0s37e
         SS5VfuUtlmzyRl8NPwmICjCiLdKJw0xVCi3/OHYsL9Nv10pJ30zFkZJuI6EkdSpDmkv1
         iBVFFErQT81Js8dPfso/dBn9czuMQMdOjd/aZDQwiZOsxIs1rZxD9kiTIQs3ItZb78i7
         +SBS3uSg/lBDs6bZQmqBU5fnGJp4vlR6WAL5WA2hZEWfJvSrwCKg1w2k/6dJ1NzQ0LrG
         OADA==
X-Forwarded-Encrypted: i=1; AJvYcCWIyEHjubdOnvQEG08txwFcIA2CdIZosRGbxlzKkJb20e6UVVsikpDmfWNs9nzgwmZbP4XIX1LCTa6lf0xxOA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxfa6ZCUtOZzQAKXrPtgALaYYBnm/6kOb8AQr5afYBxHssdU2aL
	d1HIuE3ncYhYaDxWIB/868eGQbVE9HN3WsKpWGIunQLFRIxhYfEBX9lvbFeqK46+/tZhdMar/2v
	5w+MU7ihkBeUCQhIcFBbTyp11g4UzelOD0kpWDIxEjTpO2zIDhi7uUiwJ8F+kh47JWVO5QW1JE9
	8t
X-Gm-Gg: ASbGnct3L+6BpZhR7pEmoO/F1r43C1Fwqjw1+dRjkh87a0Tn9cfWH8QlpBmqO5ZZQAg
	8ewukXynzduO3jj9v8gMzvVWp3F7t3R5jOCSwgfVJGy0i6ufxK09EwpAKwoQ69Fn8LoI41uJArI
	BHZrhjEUjVb7ATsYvt9Tc1XNjnfXQr3cAUuyNjOFovaXHNEqRGeSD62UM2IJnGmAMxUmiGBUOyU
	aQx/qs1ZN0ODeLWuCzMaS5zs4fciJ+G5YscRUpY/iGBUcBWrDkAcAA/IPlG/tH4dMMoT/R66oKa
	DrdQxYN7GZ7rN5UyYv+9nzHmMVMlbJsk
X-Received: by 2002:a05:6000:210f:b0:3b1:8db7:d1fc with SMTP id ffacd0b85a97d-3b5f1868fabmr7767201f8f.21.1752473932018;
        Sun, 13 Jul 2025 23:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMb84z873pnVV/n6jQQxSrdFm4nCG9iSlLegUH4ZMFaaB/j4zesmp3EvIUrK0S9tmMwnXgsw==
X-Received: by 2002:a05:6000:210f:b0:3b1:8db7:d1fc with SMTP id ffacd0b85a97d-3b5f1868fabmr7767181f8f.21.1752473931613;
        Sun, 13 Jul 2025 23:18:51 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e285e0sm11260714f8f.101.2025.07.13.23.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 23:18:51 -0700 (PDT)
Date: Mon, 14 Jul 2025 02:18:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <20250714021751-mutt-send-email-mst@kernel.org>
References: <cover.1752094439.git.mst@redhat.com>
 <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>
 <aHSfeNhpocI4nmQk@wunner.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aHSfeNhpocI4nmQk@wunner.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rt8HFvwSDmmpSYGyQXHV5FWowMiBxadJiWUS_SSJYzY_1752473932
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 14, 2025 at 08:11:04AM +0200, Lukas Wunner wrote:
> On Wed, Jul 09, 2025 at 04:55:26PM -0400, Michael S. Tsirkin wrote:
> > At the moment, in case of a surprise removal, the regular remove
> > callback is invoked, exclusively.  This works well, because mostly, the
> > cleanup would be the same.
> > 
> > However, there's a race: imagine device removal was initiated by a user
> > action, such as driver unbind, and it in turn initiated some cleanup and
> > is now waiting for an interrupt from the device. If the device is now
> > surprise-removed, that never arrives and the remove callback hangs
> > forever.
> 
> For PCI devices in a hotplug slot, user space can initiate "safe removal"
> by writing "0" to the hotplug slot's "power" file in sysfs.
> 
> If the PCI device is yanked from the slot while safe removal is ongoing,
> there is likewise no way for the driver to know that the device is
> suddenly gone.  That's because pciehp_unconfigure_device() only calls
> pci_dev_set_disconnected() in the surprise removal case, not for
> safe removal.
> 
> The solution proposed here is thus not a complete one:  It may work
> if user space initiated *driver* removal, but not if it initiated *safe*
> removal of the entire device.  For virtio, that may be sufficient.
> 
> > +++ b/drivers/pci/pci.h
> > @@ -553,6 +553,12 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
> >  	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
> >  	pci_doe_disconnected(dev);
> >  
> > +	if (READ_ONCE(dev->disconnect_work_enable)) {
> > +		/* Make sure work is up to date. */
> > +		smp_rmb();
> > +		schedule_work(&dev->disconnect_work);
> > +	}
> > +
> >  	return 0;
> >  }
> 
> Going through all the callers of pci_dev_set_disconnected(),
> I suppose the (only) one you're interested in is
> pciehp_unconfigure_device().
> 
> The other callers are related to runtime resume, resume from
> system sleep and ACPI slots.
> 
> Instead of amending pci_dev_set_disconnected(), I'd prefer
> an approach where pciehp_unconfigure_device() first marks
> all devices disconnected, then wakes up some global waitqueue, e.g.:
> 
> -	if (!presence)
> +	if (!presence) {
> 		pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
> +		wake_up_all(&pci_disconnected_wq);
> +	}
> 
> The benefit is that there's no delay when marking devices disconnected.
> (Granted, the delay is small for smp_rmb() + schedule_work().)
> And just having a global waitqueue is simpler and may be useful
> for other use cases.
> 
> So instead of adding timeouts when waiting for interrupts, drivers would
> be woken via the waitqueue.
> 
> But again, it's not a complete solution as it doesn't cover the
> "surprise removal during safe removal" case.

Did not realize. Will look into addressing this, thanks!


> I also agree with Bjorn's and Keith's comments that the driver should
> use timeouts for robustness, but still wanted to provide additional
> (hopefully constructive) thoughts.
> 
> Thanks!
> 
> Lukas

I'll address these comments in the next version.

-- 
MST

