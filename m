Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655A2F693B
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 23:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784850464; cv=none; b=sOWHr/1OpPKBhQ7e3+fi/+O7jZc2/Xqm3dqCNwIQSSDluVPeZumHTYXHbAVRXABNvOknbS9+zGkRNH7rEVVTdbKT4PvopSkz0zFwBLQ/AZl8yQ6uueETCBue8PQ32ksSYscTekxVUbX+9asMURnUz/B9w+24NwGA5C8xfnUv+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784850464; c=relaxed/simple;
	bh=6SNAokzXgt/Gx2HKJTr4w5eRnOLHQUA98oyYn7LFy4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Y2/vyMwfgGyDeICBA9k6N7O7BR28eUEI+oDftjC3QUWOIx3WXDkVBVtyQhj57P4LlaeDkRTGrl73qc3GFOof2zD1gXCpPGGhISwxLW4bwDBhPTe2sGh4GowtCP14rr/CPP2Sn9sWHXWqYsVy89EYu3INqLUckP558xlMGxmArnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eoSzT80K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoSzT80K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784850462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xVCT6C/+IC/13qVP7JW+CwL5y3Xc/SaBtJMMXLOPikQ=;
	b=eoSzT80Kuhx3hNvVnTOtG0G5XerHJFg2T0VZl904MAnAOY5+zboAxjcJp8jEIC5FQT6X+G
	gQe18dxtFsh6T4Ewvf6+58K0DwmCtkA465c11dFk8S3sM7V1OQMc18rE2FFNSjuRmSml/U
	e5uXc+SuOFAnP9JK2G0t1q2Jbu/C9Ws=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-bhW3nyktNgC3rYsncgOK6A-1; Thu, 23 Jul 2026 19:47:40 -0400
X-MC-Unique: bhW3nyktNgC3rYsncgOK6A-1
X-Mimecast-MFC-AGG-ID: bhW3nyktNgC3rYsncgOK6A_1784850460
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f6db77430so723007f8f.0
        for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 16:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784850459; x=1785455259;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xVCT6C/+IC/13qVP7JW+CwL5y3Xc/SaBtJMMXLOPikQ=;
        b=bMAQ8zOcMR8IGpt95jtcsqg5yZdBnsvG91qH3ktvJlm8cKh39c3/KMvtDJQNGpg4Z8
         XDTS6PGhAh/b1lSfFviQbqgVR4dzmBXNSjL7A14dCxhL7L5H2V1rQr+Bzi67OHjUXqz6
         vOxMF1WTaDTzD6aUrgtoFkJD4J1hINM5gD0WRipfmW+Ij3QUgNqUmP+h+K9XPrcksQzW
         PbO+TI8qOvul3/KEPAmGXWWWz+IvK7jAJLBb33mfX6nisO0MAGFpcq6Ko+MThyzZwBDs
         BPlfiX0Q4OzHBaFAG1WfIH86kbnnFMpstuelDyePGkqoGb4T1JRVtpyCMDFwIiDVnSlp
         HZzw==
X-Forwarded-Encrypted: i=1; AHgh+Rr/1CkNyqekS3e39BGALCFd1+00LrTwLCNriFUifi3tZ4IG7wXBQPuIcNGT1MvhogESfIeTV05uL8ZvLY1twQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxYMShTnydVERDNhSsowuKEGmCOrtErI9foDE5n77se2jB2Uo5
	jd9Om+OYIS9vPT8ANs5vI4cE+Q9CMYTdVnCRbb+iMsVeKGUuP83McZkrOgrL0tIiU4hA+L1GMw9
	/oledneVbfEtYs+yDKX7+XoJXEQvF3YtAptguNyTQ998gPzKMqa4q1dg1yWml4h/TIXfQ
X-Gm-Gg: AR+sD13Y71q1EbruWEQAIaXZj2J/J5j3sjPvZbnPexp1Va1tEtJjrPtJB1gd7CAUaAZ
	oldoqGfovER59gaWuz2TbXHSgKHurilG+5S6/POrcWLbGFENxrnZjI5q0uYbm9kg7a0ZsOpGA8F
	tRpM4W7ZSUiT6BMPCUijKeq1ha1hsWPJaG54cKblr2F+iOqR1sCmB3bguIYg7o5y2Ip23kZ3Frx
	U79t7aWbBnimvqDVxK1MNoc8pC6cL9OViYF80nrFxOGvtu7Jyuj8cSGTG96+UlX/LMecxJp6EP+
	EOidopCeodr92/RV46Y7+l7C6W49BVSvnDqPW9Skc6TafwTL1YrBS4GoSUfMrBK65sGvW5tDZKg
	LJW0T6UbA34aMncB8Y3/9yw==
X-Received: by 2002:a05:6000:220b:b0:47f:4c49:4318 with SMTP id ffacd0b85a97d-47f8dc95b55mr6146012f8f.49.1784850459509;
        Thu, 23 Jul 2026 16:47:39 -0700 (PDT)
X-Received: by 2002:a05:6000:220b:b0:47f:4c49:4318 with SMTP id ffacd0b85a97d-47f8dc95b55mr6145997f8f.49.1784850459062;
        Thu, 23 Jul 2026 16:47:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bc62basm19368448f8f.13.2026.07.23.16.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 16:47:38 -0700 (PDT)
Date: Thu, 23 Jul 2026 19:47:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hari Mishal <harimishal1@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	elena.reshetova@intel.com, huster@cs.uni-goettingen.de,
	mhollick@seemoo.de, jiska.classen@hpi.de
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
Message-ID: <20260723194206-mutt-send-email-mst@kernel.org>
References: <20260717065219-mutt-send-email-mst@kernel.org>
 <2026071759-thermal-synopsis-7568@gregkh>
 <20260717085838-mutt-send-email-mst@kernel.org>
 <1fe328d1-edf9-4e72-a145-be74ede20e60@gmail.com>
 <2026071803-passage-dares-8240@gregkh>
 <ae5bc86b-cb8d-4530-9e58-d285007deac0@gmail.com>
 <9569e577-aa82-4642-b9d9-fd496fc12849@kernel.org>
 <2026072036-outburst-rebel-c71b@gregkh>
 <8237ffef-4fb4-40b4-82c3-e9236032ab7e@kernel.org>
 <2c636784-30c4-4de9-86ef-81c0027a85cf@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2c636784-30c4-4de9-86ef-81c0027a85cf@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MXL_-yl7vA_5AbLbmsjWDGHFUMAjDLqQmVNHSxARo1o_1784850460
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 23, 2026 at 04:23:34PM -0700, Carlos Bilbao wrote:
> On 7/20/26 02:19, David Hildenbrand (Arm) wrote:
> 
> > > > > We've the virto-mem config struct layout and the kernel source, so for
> > > > > obvious fixes like a NULL check, static analysis is better than fuzzing.
> > > > > Claude took a few mins to find me two examples:
> > > > > 
> > > > > Patch 1: virtio-mem: reject non-power-of-two device_block_size
> > > > > This one is for virtio_mem_init() to check if
> > > > > !is_power_of_2(vm->device_block_size)
> > > > > 
> > > > > Patch 2: virto-mem: validate region_size and usable_region_size
> > > > > THis one checks region_size != 0 and vm->usable_reion_size >
> > > > > vm->region_size.
> > > > > 
> > > > > An endless factory of "silly" checks like these are low hanging fruit.
> > > > "silly" is the right word.
> > > "silly" in what way?
> > > 
> > As in producing "silly" low-hanging fruit patches that don't move the needle
> > when it comes to security.
> > 
> > > Seriously, I'm trying to figure out what you all care about here and
> > > what exactly the threat model you want this driver to work in, and I'm
> > > getting conflicting answers.
> > > 
> > > Either you all do worry about the "device" sending bad data and want to
> > > protect from that, or you don't and you trust it.  Pick one please so
> > > that we know how to deal with these bug reports we are getting.
> > > 
> > > For example, for USB we have said our threat model is:
> > > 
> > >    - we do NOT trust the device before a driver is bound to the device,
> > >      so if a malicious device can do something to the kernel, the kernel
> > >      needs to be fixed.
> > >    - During the probe() call for a USB driver, the driver does NOT trust
> > >      the device, and again, anything a malicious device can do to the
> > >      kernel, the kernel should fix.
> > >    - After probe() for a USB driver succeeds, it's up to the driver if it
> > >      wants to validate all data coming from the device or not.  Right
> > >      now, in general, the kernel trusts the device at that point in time
> > >      so additional checks are discretionary and at the whim of the
> > >      maintainer.
> > > 
> > > For that last point, I will note that some BIG users of Linux (i.e.
> > > billions of Android devices) still explicitly do NOT want to trust the
> > > USB device at this point in time, and are relying on the kernel to
> > > protect the system from bad devices.  In that case, various patches have
> > > been taken to different drivers and subsystems to play whack-a-mole on
> > > while Android gets their act together to finally come up with a solid
> > > defensive plan (like ChromeOS has had for a decade.)  It will be seen
> > > which happens first, all drivers are properly fuzzed and fixed up, or
> > > Android gets their act together and finally fixes their b0rked system
> > > trust model.  I think Android management is relying on the kernel
> > > community to do the kernel work as they keep refusing to staff the
> > > userspace work that they need to do here...
> > Right, and for virtio devices trusting the device after probe is just extremely
> > questionable.
> > 
> > What changes during probe that the device suddenly sends us good data?
> > 
> > Why would a hypervisor that tried to break us before probe not try to break us
> > after probe?
> > 
> > > And yes, I really need to write this up in a more solid document for USB
> > > and get it into the tree, but at least this email thread has forced me
> > > to write down the above :)
> > > 
> > > 
> > > So, again, for virtio drivers, what exactly do you all want to say is
> > > your threat model that the drivers need to handle?  Can you all agree on
> > > something please?  Otherwise, for new developers like Hari, this is
> > > totaly confusion as to what they should be doing.
> > Well, I am also totally confused why we end up checking against some MUST
> > clauses in the spec, but not against others.
> > 
> > I am very much in favor of making virtio-mem completely safe to use even in
> > coco, where it is currently not used at all.
> > 
> > If it's really about "don't let a device trigger any unexpected kernel code
> > execution by sanitizing all input data", fine with me. We should do exactly
> > that. Try checking all MUST clauses etc.
> > 
> > But I don't think doing the "low hanging fruit" adds any security. It should be
> > done properly or not at all.
> 
> 
> I think you're mistaken in assuming that these "silly" fixes don't move the
> needle at all when it comes to security. We can't really quantify these
> things, and one extra NULL check by itself is probably not going to make a
> meaningful difference. But, IMHO, this should be treated as the opposite of
> "death by a thousand cuts", many small hardening improvements, each
> individually insignificant, can collectively make the kernel substantially
> more robust over long periods of time.
> 
> 
> Thanks,
> 
> Carlos


Simply put - no.

DoS attacks, including NULL ptr accesses, are outside the confidential
computing security boundary.  They have to be - denying service to
whoever is not paying them is exactly how cloud vendors get paid.


My preference is to ignore such non-issues - we need to focus on
handling real ones.


Besides, adding random changes all over the code for non issues
can easily introduce new security bugs. That's the classic death by a
thousand cuts.

Thanks,
-- 
MST

