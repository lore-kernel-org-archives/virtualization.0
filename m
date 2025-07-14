Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C353BE65
	for <virtualization@lists.linux.dev>; Mon, 14 Jul 2025 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752476104; cv=none; b=aurEAU+6FEiPNX+zvIu0lKYBl+0FBvklAooLGg8lfQTPILh9dkhMCkgzp6THlCG83/CxxS4v4eHnqd47yW3xSRQkcekR1XRBMBEjWgVhVIl37X1VvlmWeiJSD0V9fxVq0OiEgfLutHQHJtT/7161vOl+Ys0fNMNKFBb2smZPxsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752476104; c=relaxed/simple;
	bh=UGs/+B32gn3cy1d8qhjGPSwAy5GCOeHq/3OLNLkco8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GSWoj7z3gK/fgPqfuCIHUeTuL+WX6KGBTQOdU36wlbq4TQ7ITlxWLeTddR/ZX71Agujnr9Go3hkuZXvTerrzOoR2bg3uRI9E/TlMSQSsQ7UXfGqIK/qVg5Si00JSUjuRshlhX9H5Y7m/i7sCeYhBkp5xpePkM1wmJ1d6nhei86A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Il16xPEm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Il16xPEm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752476100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sPMw9tnfPBR1vsdCImTl+h1akpJagNiW0hA8bPj+ieE=;
	b=Il16xPEmlJN4ebqeQRYH0wDxWSXzdhB8xkTsvGiE9ryzliixlkOUAF8K64EJigfRxzT3i9
	DzMXt3Cl4/RiCnJAupCBglwhqgeTfKF6VXirpImDsADRojHyPK08f76GvN623AGcC+aZ7X
	3/y/czG55KDDvAmWXN+h5cCU3jtiwaA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-Mp02fRW9Mx6jGfylAttQyw-1; Mon, 14 Jul 2025 02:54:58 -0400
X-MC-Unique: Mp02fRW9Mx6jGfylAttQyw-1
X-Mimecast-MFC-AGG-ID: Mp02fRW9Mx6jGfylAttQyw_1752476097
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-453a5d50b81so28525585e9.1
        for <virtualization@lists.linux.dev>; Sun, 13 Jul 2025 23:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752476097; x=1753080897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPMw9tnfPBR1vsdCImTl+h1akpJagNiW0hA8bPj+ieE=;
        b=Oc/ndH6U1rUIDb7erwg9ChaGmQ7nxfDscJou29HJAWO+/hhkzUAvmVaWfON70koPrR
         rfpcmXKG9mS1zMOnFw4ITPvW5McwWjIuzoi8RWcQJXxqyTevrTubazRYiYoosiR1M9x0
         kfTRyicmiqrW24K6fsatZ9CIE1RgKi2DxKpDfyvDPO/W6hLYDqgaRLBUplawmD+uwpgF
         TsYDtkqy7f3QfALm77N5VZDvCzkoR7a+HQoAmJFba/6L2aqXccQZrAw6jfsujkrnbh/d
         A/CUp9BSyoU0NVm7UkKGohSVPtXT20JguInfSkteisdawsqWQqGvKYkfLHTLOkweI52B
         uqJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnvdqSK9oRyCLWiI+X0HwODHFvtrYl+KnWdlN/kSHS4OA5Bl3ZnlMeJu4xMZBK7KBZ2XcJy9FfjApdCqWEuw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzffd7PIpEpSfZEOhfho+raW2v4TDkL1/9of0mjWnSn04dxiHZs
	cwT90RRZXoD3bO1sF3vQCedgRM8xS4fp9cPA8UcHuC3jre0dFDnH1w8RyEbW+03BL0LK4p7MDI/
	c/WAzdFQacrpAa7s6b8UTxONxwTvzi+jheU5Xp++7m0ZDEzdEyyzBFbRPa4c4yWk/P4PX
X-Gm-Gg: ASbGncsAShZhp9tXSJZhlRPnXWigWSnj/luSKgGECXqj3rXnAat6mgrvXjkrHLt+mIC
	4Ds99eLjivuzz7uoWToqUMe8EUQtvWGFoWi/aBrAd/HyPOxoNpz6Xjk8ht01cmd1YZ0OZ4hIb68
	l0TLsB44MyD/6hG9j6nOexwoDnY9lmbCqMG9/sbbO/REy2gOAGxJqJHUGZgmiodW6Zt9gK4qLU9
	2jp9XGeWEPZ3PU9agCfyxQesKCVlY2aoeWK+Ah1AqGf5tjNbLrsE3ipX2O8+sCEQ2UjDKUq7JQL
	exVwCmfDEmafj348JtBugeUQ18QGGHUx
X-Received: by 2002:a05:600c:5024:b0:456:1611:cea5 with SMTP id 5b1f17b1804b1-4561611d3d6mr30785815e9.18.1752476096935;
        Sun, 13 Jul 2025 23:54:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE022c2VHr8WA+kO3hbXoaSxylmvCVJc9OW9gVm8pRiIUhm71J57/fOnW6tWgm61Q3Ykw7IA==
X-Received: by 2002:a05:600c:5024:b0:456:1611:cea5 with SMTP id 5b1f17b1804b1-4561611d3d6mr30785655e9.18.1752476096517;
        Sun, 13 Jul 2025 23:54:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45610c518e9sm46492725e9.17.2025.07.13.23.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 23:54:56 -0700 (PDT)
Date: Mon, 14 Jul 2025 02:54:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <20250714025357-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: rLl63-jpxxnkw-BaAkgU07J9cjCfCFPQ2l-afjaU1Xw_1752476097
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


No, I just missed this corner case.

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
> 
> I also agree with Bjorn's and Keith's comments that the driver should
> use timeouts for robustness,

Yes - we can consider this an optimization, as robust timeouts
are by necessity minutes.

> but still wanted to provide additional
> (hopefully constructive) thoughts.
> 
> Thanks!
> 
> Lukas

