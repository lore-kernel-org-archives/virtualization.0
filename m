Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7B028F51E
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 06:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751523859; cv=none; b=c/oLAHDhuqzKGv4lkLV1ll2/E9ds5xxNCrx+r3TXYy0cXJzWr55EnOw9fi3TuMIVLVbIaiucRV+ATOSCsswKvx3jq5ts3f+euoxYHWSgA9Qk9wAooxExqKSjl8ZRUWRAeOYJ4lw6jfk/in5FR5ZTCtGIHVnIxWNaEeHXG93t/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751523859; c=relaxed/simple;
	bh=dao9nTpC5C1q0JJDCBYH/D3fgkfHONt6s1hu70kqblQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sZcCmxwlalzKBC7KttcpGh9yXtaDdhKM1ECuohulOaga1ouSqCQVsK1aCxgCCUe3kRJ3UTrAVr+ifzg0e6eOBTIHXrfpzHGjUsXIVRVhYJ8s7tWa3qGKiWX/eHZZbrHocamA4skhQwdFg3x6n4zk6pQFLSYARu+v7LoVrHTEQJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OwccRZ4V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwccRZ4V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751523856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oNnWJxGDTYj2oLSlWuvTf5AvF7vq7QQGZ22ViGGEQZQ=;
	b=OwccRZ4Vxh5DvST4BMUgW1HUdqLBFGQUQZM8IJemps9xeyNn+i1bjIyLLHzIkfgc+knLrx
	oq2I4EKT2fXGv38kcl7Iz15z3f/WDdfYF+D3jpJYaA3cBq3X//p5ODYZmnqgNQRfZhlqeu
	GBDw58dC/CblSeyCbj+vA78Wr2TVVDE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-gOKLg_X1MjKHs_sGVoLOuQ-1; Thu, 03 Jul 2025 02:24:14 -0400
X-MC-Unique: gOKLg_X1MjKHs_sGVoLOuQ-1
X-Mimecast-MFC-AGG-ID: gOKLg_X1MjKHs_sGVoLOuQ_1751523853
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so5009221f8f.3
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 23:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751523853; x=1752128653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNnWJxGDTYj2oLSlWuvTf5AvF7vq7QQGZ22ViGGEQZQ=;
        b=PV3TT9rDf00wEcyn5wr8va1Qu2aKnZdQSDOsAXlFVrFAYveLYcJtzdYE40E5a5F8qq
         vTDtIoL7y59t82405nPG9CNFxkttSF9NcF7CV0re9kUv4o1jEh5kFT4GaOyE5bP/hCie
         zA7K9DfjI2iFA3M1cDrxURDCTkgKuh1447YSaUa+srbLKK4twAjR9oz6FlD6UYJiIdwF
         CiM0bC9T4LkNPar/k3Djk5klw/ew+xP22L139GmepR+MD7rtI8s/9NoZOSSoeqsbaiwz
         Wz/VxkGPpPC2ESVijTaVhCpdvwcCeS4ppBw3akMrQIM3S3ILBMWPl+TXbE5vMW+AOkuq
         Zm5g==
X-Forwarded-Encrypted: i=1; AJvYcCWtOWsYPns9h3GRjUKrxMPLhGzdFGcsfwGjw+jMzrhbNo5yonzUx+GxxBc7h9E2j6Sp8J/GlAq2bFdtGzNWJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRNhMPyI+HFlg1zEtASE2YAdHnJGitI4+afyCTloob41oCwggJ
	5QKYbpzL13f2ikbW1YULytk6ElMgmgv7YjzbaTxYjcTfXBPsawGqMACrn44UCfNUerd7W8o7YXg
	jatebqQ9KsKb600OLuARID0hFrfXXe/ze69T29GU/SjYI++I93daoXzT9+tYYBdKUufZB
X-Gm-Gg: ASbGncvrTYyLhsgH1gzmeTmN1+0crtRG1C2l0ZLBhzMLHIjbQdTg0tVsKMqh0tvs4Zm
	SGYn/Y2iHtRl3+XW5I4eEXChu6FVPcy70rzR63YMmiSShVHJK/+PBr5XBSi1N6QwUU8TP/eCGsq
	/16tGpkvzKjD/QopcGxn1B+ufRXoeY0tTO9gQ1b5zPscttC+24+eNYIsvgAPKdIRj7QsFkoUz4E
	TbDfQdVMppC4NDs38AKk5A6BD/3rSEwXyW7OIlKqTNxnv50EGdWXOj/k/S61GfPUxwIBRXNJCEW
	cCqSjhToGn3TmTPk
X-Received: by 2002:a05:6000:490a:b0:3b1:8db7:d1fc with SMTP id ffacd0b85a97d-3b1fe5c07d4mr4360122f8f.21.1751523853191;
        Wed, 02 Jul 2025 23:24:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGxmSX9oSYQVzW9zlIGbTQXs8hI4c+MXz2QtluF728gF5D2N2yEQOE0oBdUYHzNVwqbLlzgg==
X-Received: by 2002:a05:6000:490a:b0:3b1:8db7:d1fc with SMTP id ffacd0b85a97d-3b1fe5c07d4mr4360105f8f.21.1751523852675;
        Wed, 02 Jul 2025 23:24:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fb20esm18034642f8f.36.2025.07.02.23.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 23:24:12 -0700 (PDT)
Date: Thu, 3 Jul 2025 02:24:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: Re: [PATCH RFC v3] pci: report surprise removal event
Message-ID: <20250703022224-mutt-send-email-mst@kernel.org>
References: <1eac13450ade12cc98b15c5864e5bcd57f9e9882.1751440755.git.mst@redhat.com>
 <20250702132314-mutt-send-email-mst@kernel.org>
 <CY8PR12MB719502AAF4847610CD9C7286DC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CY8PR12MB719502AAF4847610CD9C7286DC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J70U1yKU9idGN06pJY-u0-EcubSp8DLUnQ7HqR0SJIE_1751523853
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 03, 2025 at 05:02:13AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 02 July 2025 10:54 PM
> > 
> > On Wed, Jul 02, 2025 at 03:20:52AM -0400, Michael S. Tsirkin wrote:
> > > At the moment, in case of a surprise removal, the regular remove
> > > callback is invoked, exclusively.  This works well, because mostly,
> > > the cleanup would be the same.
> > >
> > > However, there's a race: imagine device removal was initiated by a
> > > user action, such as driver unbind, and it in turn initiated some
> > > cleanup and is now waiting for an interrupt from the device. If the
> > > device is now surprise-removed, that never arrives and the remove
> > > callback hangs forever.
> > >
> > > For example, this was reported for virtio-blk:
> > >
> > > 	1. the graceful removal is ongoing in the remove() callback, where disk
> > > 	   deletion del_gendisk() is ongoing, which waits for the requests +to
> > > 	   complete,
> > >
> > > 	2. Now few requests are yet to complete, and surprise removal started.
> > >
> > > 	At this point, virtio block driver will not get notified by the driver
> > > 	core layer, because it is likely serializing remove() happening by
> > > 	+user/driver unload and PCI hotplug driver-initiated device removal.
> > So
> > > 	vblk driver doesn't know that device is removed, block layer is waiting
> > > 	for requests completions to arrive which it never gets.  So
> > > 	del_gendisk() gets stuck.
> > >
> > > Drivers can artificially add timeouts to handle that, but it can be
> > > flaky.
> > >
> > > Instead, let's add a way for the driver to be notified about the
> > > disconnect. It can then do any necessary cleanup, knowing that the
> > > device is inactive.
> > >
> > > Since cleanups can take a long time, this takes an approach of a work
> > > struct that the driver initiates and enables on probe, and tears down
> > > on remove.
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >
> > 
> > Parav what do you think of this patch? 
> The async notification part without holding the device lock is good part of this patch.
> 
> However, large part of the systems and use cases does not involve pci hot plug removal.
> An average system that I came across using has 150+ pci devices, and none of them uses hotplug.
> 
> So increasing pci dev struct for rare hot unplug, that too for the race condition does not look the best option.
> 
> I believe the intent of async notification without device lock can be achieved by adding a non-blocking async notifier callback.
> This can go in the pci ops struct.
> 
> Such callback scale far better being part of the ops struct instead of pci_dev struct.

Sorry, I don't see a way to achieve that, as the driver can go away
while hotunplug happens.

You would be welcome to try but you mentioned you have no plans to do so.



> > This you can try using this in virtio blk to
> > address the hang you reported?
> >
> The hang I reported was not the race condition between remove() and hotunplug during remove.
> It was the simple remove() as hot-unplug issue due to commit 43bb40c5b926.
> 
> The race condition hang is hard to reproduce as_is.
> I can try to reproduce by adding extra sleep() etc code in remove() with v4 of this version with ops callback.
> 
> However, that requires lot more code to be developed on top of current proposed fix [1].
> 
> [1] https://lore.kernel.org/linux-block/20250624185622.GB5519@fedora/
> 
> I need to re-arrange the hardware with hotplug resources. Will try to arrange on v4.
> 
> > > Compile tested only.
> > >
> > > Note: this minimizes core code. I considered a more elaborate API that
> > > would be easier to use, but decided to be conservative until there are
> > > multiple users.
> > >
> > > changes from v2
> > > 	v2 was corrupted, fat fingers :(
> > >
> > > changes from v1:
> > >         switched to a WQ, with APIs to enable/disable
> > >         added motivation
> > >
> > >
> > >  drivers/pci/pci.h   |  6 ++++++
> > >  include/linux/pci.h | 27 +++++++++++++++++++++++++++
> > >  2 files changed, 33 insertions(+)
> > >
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h index
> > > b81e99cd4b62..208b4cab534b 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -549,6 +549,12 @@ static inline int pci_dev_set_disconnected(struct
> > pci_dev *dev, void *unused)
> > >  	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
> > >  	pci_doe_disconnected(dev);
> > >
> > > +	if (READ_ONCE(dev->disconnect_work_enable)) {
> > > +		/* Make sure work is up to date. */
> > > +		smp_rmb();
> > > +		schedule_work(&dev->disconnect_work);
> > > +	}
> > > +
> > >  	return 0;
> > >  }
> > >
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h index
> > > 51e2bd6405cd..b2168c5d0679 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -550,6 +550,10 @@ struct pci_dev {
> > >  	/* These methods index pci_reset_fn_methods[] */
> > >  	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
> > >
> > > +	/* Report disconnect events */
> > > +	u8 disconnect_work_enable;
> > > +	struct work_struct disconnect_work;
> > > +
> 
> > >  #ifdef CONFIG_PCIE_TPH
> > >  	u16		tph_cap;	/* TPH capability offset */
> > >  	u8		tph_mode;	/* TPH mode */
> > > @@ -2657,6 +2661,29 @@ static inline bool pci_is_dev_assigned(struct
> > pci_dev *pdev)
> > >  	return (pdev->dev_flags & PCI_DEV_FLAGS_ASSIGNED) ==
> > > PCI_DEV_FLAGS_ASSIGNED;  }
> > >
> > > +/*
> > > + * Caller must initialize @pdev->disconnect_work before invoking this.
> > > + * Caller also must check pci_device_is_present afterwards, since
> > > + * if device is already gone when this is called, work will not run.
> > > + */
> > > +static inline void pci_set_disconnect_work(struct pci_dev *pdev) {
> > > +	/* Make sure WQ has been initialized already */
> > > +	smp_wmb();
> > > +
> > > +	WRITE_ONCE(pdev->disconnect_work_enable, 0x1); }
> > > +
> > > +static inline void pci_clear_disconnect_work(struct pci_dev *pdev) {
> > > +	WRITE_ONCE(pdev->disconnect_work_enable, 0x0);
> > > +
> > > +	/* Make sure to stop using work from now on. */
> > > +	smp_wmb();
> > > +
> > > +	cancel_work_sync(&pdev->disconnect_work);
> > > +}
> > > +
> > >  /**
> > >   * pci_ari_enabled - query ARI forwarding status
> > >   * @bus: the PCI bus
> > > --
> > > MST

