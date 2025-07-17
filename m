Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856D1E5207
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765353; cv=none; b=miXBIr8gQfXH4xbjgV0kZnUQ2CwEuk/lavZgmVKgtU6hh1egpZXFilCdvzOBgfUof4iJUJyptPWEvEqxImAm2tGsf1wz1Zjypbd0xjPtJa8phG3XzGyflzwhiiQByJjHCh/br5r9r+y5YTA/a9wieSxyurMWXf6x83XwyOrkq50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765353; c=relaxed/simple;
	bh=OH9pGD1iFNuSAvyw46rRfSyGtP+Tbz3+klQk+Ryybog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dJiKjE1JCaRcTINYijHdCDO+KPfn6RnLXS1OF+GC+c7BbkjdUYy6TKvuJUMlc3renAfm0/4susmgaX5qj/BNfWPpcmc3AmZ68n95R+0lWgvCdHnXTwGFvhHPSeCx1qO7WSOiZVrZfQyqgrYH37Bd6uXqHtHTptSTmC6o7w+hfXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwnYI017; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwnYI017"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752765350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3tvaS74PSIrIFmziB0xQ3dinCc+KQFLT6M72oZTrSb4=;
	b=hwnYI017WZB63XvyLl7/nqQM+8gS8sbmCqD75fQtGv67WL+BeybfEQVJi8bvI2FmUXjxVI
	6hhsB0HZZbCUrcofiJVujfROAUsMykV0CEutRRrcXmzVuwqXbK3Nh/ArP8BKOrXDJP6N64
	x8ygFhcP9egFCEDaGy5QzJTEGmU0MWY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-8M0pIrs5OdeG0dcDrDnCCQ-1; Thu, 17 Jul 2025 11:15:49 -0400
X-MC-Unique: 8M0pIrs5OdeG0dcDrDnCCQ-1
X-Mimecast-MFC-AGG-ID: 8M0pIrs5OdeG0dcDrDnCCQ_1752765348
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a523ce0bb2so440776f8f.0
        for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 08:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752765348; x=1753370148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tvaS74PSIrIFmziB0xQ3dinCc+KQFLT6M72oZTrSb4=;
        b=LrifoEpsJxCkBsVE+CA+hAjkeDMKDK9jRm03Zk0GTqaFKYbslZWkAXDbUHJg/Epij5
         3IG0Z9saL6qfagsWNt0BjLrE4yZadKfKeU0fJK67gFtovZSCljmrTiJwMp2lpADvz2N1
         bZiF40odS4DLJaz2A74Fho0e+ITthjbrmfYegTgiY3R3jejBiZiuk+YY2k+Cj3qeQ5m1
         CFzRyhYuXcifzh7vi/1RRNTzgwF00LRBmvjRO1eccbX7AJXlZcKYBA5IGPRo8ZVxGSIM
         83Kj2NUkG+Pt8XUFVH3dxs2ScziczdohORvatfaOBeVv/F5aMJFc9r6bLCUzILMNVDrk
         5vBw==
X-Forwarded-Encrypted: i=1; AJvYcCWknxHDZ895Pc42jmbc5Wjj+Mh5m+ncyC6U99vnA/qJlQO7bdInopJHafMW/j3u6NOuGM9EOQebGaWrN2O7Kg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZh4/XFnYTS8i2YMyLNzM6LUOwluIKdfhwKXk0sCxBI4t2t4Px
	gKTrcxZfe5RkekO7wdyOm2TK0Q8bZknEh87GL5U6UyA4tl5jC94NBlE+uPvQiDdP2OT3CfUuQ3Y
	5WnT55cLNjsA3W2citHKJiuKo5CEqc1xj0HMnTzEY9kNpc43xyFDAprN1csbLEjvtS6mm
X-Gm-Gg: ASbGncuKVkk6JnmggMmwIzuKfbap609LE0CWOVx625FtUwM8IwgTDUan6wsv4X0owhM
	COQNGhzUUAH8E+/uUfqzaGOfzNmXbrOrZIYI3wmXkVKb97RwlbZsE0oOkFxtA0Wd51wCyvsGbl3
	SvgPaJ7+zgJIYUTwOEMj+mROT+ga0JnO0VsGFkSfn+8ZqKKJiOM9qsMdqVbbKFm4C6SMQrAVkNQ
	6PV4aJgk635wEi1M/bARzEEtPbmEKhN1JvwywTbn7zkKtrcvDkvBrqi4jQulaJx1lk5r5u4KIYS
	Epoeryp0qOpDVMMvTydahY5d/ocwTocn
X-Received: by 2002:a05:6000:43c6:10b0:3a4:f744:e01b with SMTP id ffacd0b85a97d-3b60e50fde7mr4597792f8f.39.1752765347676;
        Thu, 17 Jul 2025 08:15:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFtPeuqTWsjIxNWgdgPfM7y344zYuORqf7QbkSlUFf9f++5E7a8c5uRhTqR3BnA+eFgTgbHw==
X-Received: by 2002:a05:6000:43c6:10b0:3a4:f744:e01b with SMTP id ffacd0b85a97d-3b60e50fde7mr4597754f8f.39.1752765347181;
        Thu, 17 Jul 2025 08:15:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e8cfsm20568867f8f.80.2025.07.17.08.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 08:15:46 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:15:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <20250717111154-mutt-send-email-mst@kernel.org>
References: <20250715022111-mutt-send-email-mst@kernel.org>
 <20250716222900.GA2556670@bhelgaas>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250716222900.GA2556670@bhelgaas>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: F2NaxQ86AxvkXvkSoCAIyQXag-cFsejXxw4PvCcugag_1752765348
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 16, 2025 at 05:29:00PM -0500, Bjorn Helgaas wrote:
> On Tue, Jul 15, 2025 at 02:28:20AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jul 14, 2025 at 04:13:51PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Jul 14, 2025 at 02:26:19AM -0400, Michael S. Tsirkin wrote:
> > > > On Wed, Jul 09, 2025 at 06:38:20PM -0500, Bjorn Helgaas wrote:
> > > > > On Wed, Jul 09, 2025 at 04:55:26PM -0400, Michael S. Tsirkin wrote:
> > > > > > At the moment, in case of a surprise removal, the regular
> > > > > > remove callback is invoked, exclusively.  This works well,
> > > > > > because mostly, the cleanup would be the same.
> > > > > > 
> > > > > > However, there's a race: imagine device removal was
> > > > > > initiated by a user action, such as driver unbind, and it in
> > > > > > turn initiated some cleanup and is now waiting for an
> > > > > > interrupt from the device. If the device is now
> > > > > > surprise-removed, that never arrives and the remove callback
> > > > > > hangs forever.
> > > > > > 
> > > > > > For example, this was reported for virtio-blk:
> > > > > > 
> > > > > > 	1. the graceful removal is ongoing in the remove() callback, where disk
> > > > > > 	   deletion del_gendisk() is ongoing, which waits for the requests +to
> > > > > > 	   complete,
> > > > > > 
> > > > > > 	2. Now few requests are yet to complete, and surprise removal started.
> > > > > > 
> > > > > > 	At this point, virtio block driver will not get notified by the driver
> > > > > > 	core layer, because it is likely serializing remove() happening by
> > > > > > 	+user/driver unload and PCI hotplug driver-initiated device removal.  So
> > > > > > 	vblk driver doesn't know that device is removed, block layer is waiting
> > > > > > 	for requests completions to arrive which it never gets.  So
> > > > > > 	del_gendisk() gets stuck.
> > > > > > 
> > > > > > Drivers can artificially add timeouts to handle that, but it can be
> > > > > > flaky.
> > > > > > 
> > > > > > Instead, let's add a way for the driver to be notified about the
> > > > > > disconnect. It can then do any necessary cleanup, knowing that the
> > > > > > device is inactive.
> > > > > 
> > > > > This relies on somebody (typically pciehp, I guess) calling
> > > > > pci_dev_set_disconnected() when a surprise remove happens.
> > > > > 
> > > > > Do you think it would be practical for the driver's .remove() method
> > > > > to recognize that the device may stop responding at any point, even if
> > > > > no hotplug driver is present to call pci_dev_set_disconnected()?
> > > > > 
> > > > > Waiting forever for an interrupt seems kind of vulnerable in general.
> > > > > Maybe "artificially adding timeouts" is alluding to *not* waiting
> > > > > forever for interrupts?  That doesn't seem artificial to me because
> > > > > it's just a fact of life that devices can disappear at arbitrary
> > > > > times.
> > > > > 
> > > > > It seems a little fragile to me to depend on some other part of the
> > > > > system to notice the surprise removal and tell you about it or
> > > > > schedule your work function.  I think it would be more robust for the
> > > > > driver to check directly, i.e., assume writes to the device may be
> > > > > lost, check for PCI_POSSIBLE_ERROR() after reads from the device, and
> > > > > never wait for an interrupt without a timeout.
> > > > 
> > > > virtio is ... kind of special, in that users already take it for
> > > > granted that having a device as long as they want to respond
> > > > still does not lead to errors and data loss.
> > > > 
> > > > Makes it a bit harder as our timeout would have to
> > > > check for presence and retry, we can't just fail as a
> > > > normal hardware device does.
> > > 
> > > Sorry, I don't know enough about virtio to follow what you said about 
> > > "having a device as long as they want to respond".
> > > 
> > > We started with a graceful remove.  That must mean the user no longer
> > > needs the device.
> > 
> > I'll try to clarify:
> > 
> > Indeed, the user will not submit new requests,
> > but users might also not know that there are some old requests
> > being in progress of being processed by the device.
> > The driver, currently, waits for that processsing to be complete.
> > Cancelling that with a reset on a timeout might be a regression,
> > unless the timeout is very long.
> 
> This seems like a corner case and maybe rare enough that simply making
> the timeout very long would be a possibility.

Indeed the timeout needs to be very long, and the average would still be
reasonable, but the worst case is terrible and the user can't insert a
replacement card all this time. The system is perceived as flaky.


> > > > And there's the overhead thing - poking at the device a lot
> > > > puts a high load on the host.
> > > 
> > > Checking for PCI_POSSIBLE_ERROR() doesn't touch the device.  If you
> > > did a config read already, and the result happened to be ~0, *then* we
> > > have the problem of figuring out whether the actual data from the
> > > device was ~0, or if the read failed and the Root Complex synthesized
> > > the ~0.  In many cases a driver knows that ~0 is not a possible
> > > register value.  Otherwise it might have to read another register that
> > > is known not to be ~0.
> > 
> > To clarify, virtio generally is designed to operate solely
> > by means of DMA and interrupt, completely avoiding any PCI
> > reads. This, due to PCI reads being very expensive in virtualized
> > scenarios.
> > 
> > The extra overhead I refer to is exactly initiating such a read
> > where there would not be one in normal operation.
> 
> Thanks, this part is very helpful.  And since config accesses are very
> expensive in *all* environments, I expect most drivers for
> high-performance devices work the same way and only do config accesses
> during at probe time.
> 
> If that's true, it will make this more understandable if the commit
> log approaches it from that direction and omits virtio specifics.
> 
> Bjorn

Will do, thanks a lot!

-- 
MST

