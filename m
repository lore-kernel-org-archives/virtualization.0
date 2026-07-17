Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F93B245012
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305731; cv=none; b=W2r/To7xtTWMDpOAB0y/jFg6D/wkHw2CjjZfIAA5qB1+rZ9P4i4okLXfIFaQRQW9TzmN9MXBJ3pgT+UovmRCQ3+pqmaYGgTTU6+PxZ8/0EDOdDh/xyMTkiCACc5rO7t4tkTmX7+MB8NQMHqmcwUMemZtA/6eH2s5YCrMY4Ms7YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305731; c=relaxed/simple;
	bh=bSYy+NhgsuFJsgUjXD49ghmGN6ReTVfFZtNgKNW6kH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=s5BETvKU3TTqQdOez+sU2AYeRyo8laabYaXJIu+EvXnqejh2yOeULCjsja+2TTOWb7/QdRyo2krLr82ar98HVKrsmUAtfgyEKWW/ZPmUgYaR+NPhMUk0V86jtb68+S3Cy9Ncjvoqty1e8uyIiRmpAwVYmh6ptPFS3r1wqvjjR3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWBBIlTL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWBBIlTL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784305729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTTDMSxFrSjnI2wmgHZpQssW17vn7AV5vpv8RBL8iLU=;
	b=gWBBIlTLTpi9i2Fqhv1aDRxeCUOeFboJX1DF88MsR0Zu6SJdWG8EaUHh1UB6sWBzsZzI/g
	1D941B5U/J4ZMKCO5FyMMgW1D/FdlVXjrFqV11XOijSU4KE8theXBNwd9aKdMNQUkIyBWn
	fry0JfSeAh5PXpT0pdPhFNcsBuNGuMY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-vXU0RrssN4KlziqZP6yLHQ-1; Fri, 17 Jul 2026 12:28:47 -0400
X-MC-Unique: vXU0RrssN4KlziqZP6yLHQ-1
X-Mimecast-MFC-AGG-ID: vXU0RrssN4KlziqZP6yLHQ_1784305727
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493b0a5e636so73175215e9.3
        for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 09:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784305726; x=1784910526;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uTTDMSxFrSjnI2wmgHZpQssW17vn7AV5vpv8RBL8iLU=;
        b=U/MY37t84Ei8y7Gw+3roW8OS3AFb4KG4MbuUfz/wVCrY8deGu1J6OfdLZlPHH1Ko8s
         QXWJBVo4COys0v9bZDTnpN3xysNT3by9dbnf+dmAR1knMasX5rcKmu9VKNvQo32xJkX0
         x2vz3cFKwO4oTabtWTEvDEETeM0egHSGRgzmalKTDBh0+t3anzUKpFIYf5QfZ9XbTssr
         ioA4ObD6HMbMGl9M2pLYLU4LfQx3uRalaOGrM1nF0YapT7WyDxGAaImRPRqTcqabqDf1
         F6ltYzAamMn4dx2pugGNxwOm3SIOu8VUrpAIylwYSYYSdjAtKv0eCLIkDeK5NsaRALlM
         HoRQ==
X-Forwarded-Encrypted: i=1; AHgh+RqMi4eAK2zPKpOX+WhEzrm3dziA3w892KqftG+CkGhd4HD6PmrgWBD9u83vk1kJxjac2b0Se7iB2UDTS2w4BA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYC5nr6LjPAYH4WLnAirbme6pmYOsmxMxpamXkj/5Aoc6rBnrA
	CO9+8A3qNqenblKq/JJWd1PXRSt/tyjWCT7es8Ojm7Y70iYVnnkMAqoNytWadNh1hclCxN8z/Da
	RF24t4thJfjbPJPQGXALZ/GhI9NlLuPdP9N6c8ahQvN7H8K3YeYGI8Z8tJD0q4jtYsT/K
X-Gm-Gg: AfdE7cnGfU2iV1piAujRNE8g0F+zIjAXbelWx/nVHtyxebo2VLIsmidWv4WFVsgv8ok
	gQxV0S2cu+SdtwuKOKtPHANuqYCavd0rRP8AgwlsA7CCeIVV8GVEIPJPT43hn/OCF2xFBEjKalk
	qYVVP6mPn/W+Aj9ZI5hhC29m3Vu0/Sg4crMUOqgGPlkMusWqxiO6FtfsvQOIywHYxqYCpz7pTFD
	oo8Qoy7kdcQFohm30J7rQ9NIN8I2F1jjTR2u3o2XBJtCYoSTPsLEClw80QwXs8bWv24RaFTow95
	VMCPeNXZHezlJ+riL1b4NP++o2vb3t483soJVrNfWjl4DcZpSOF1l6Is2MXKjn7s/5Y1KfYpayw
	mMqOt9yHcr1HMI26KGDNm7j03
X-Received: by 2002:a05:600c:5698:b0:493:f78f:cd70 with SMTP id 5b1f17b1804b1-4954a405ec6mr30866855e9.18.1784305726199;
        Fri, 17 Jul 2026 09:28:46 -0700 (PDT)
X-Received: by 2002:a05:600c:5698:b0:493:f78f:cd70 with SMTP id 5b1f17b1804b1-4954a405ec6mr30866475e9.18.1784305725699;
        Fri, 17 Jul 2026 09:28:45 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549a3f07esm59293845e9.6.2026.07.17.09.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:28:44 -0700 (PDT)
Date: Fri, 17 Jul 2026 12:28:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Hari Mishal <harimishal1@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	elena.reshetova@intel.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
Message-ID: <20260717122729-mutt-send-email-mst@kernel.org>
References: <20260717044019-mutt-send-email-mst@kernel.org>
 <2026071746-deviation-clad-1712@gregkh>
 <20260717060822-mutt-send-email-mst@kernel.org>
 <2026071757-grout-composer-165d@gregkh>
 <20260717061901-mutt-send-email-mst@kernel.org>
 <2026071724-asleep-pedigree-ea54@gregkh>
 <20260717065219-mutt-send-email-mst@kernel.org>
 <2026071759-thermal-synopsis-7568@gregkh>
 <20260717085838-mutt-send-email-mst@kernel.org>
 <2026071724-modulator-pliable-fa1c@gregkh>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2026071724-modulator-pliable-fa1c@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vxgkOS-apxnTRh_Ewo1WEx2WwzLmL2wYfobUHehEji4_1784305727
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jul 17, 2026 at 04:31:03PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 17, 2026 at 09:08:23AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Jul 17, 2026 at 02:07:50PM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Jul 17, 2026 at 06:52:46AM -0400, Michael S. Tsirkin wrote:
> > > > On Fri, Jul 17, 2026 at 12:46:52PM +0200, Greg Kroah-Hartman wrote:
> > > > > On Fri, Jul 17, 2026 at 06:23:57AM -0400, Michael S. Tsirkin wrote:
> > > > > > On Fri, Jul 17, 2026 at 12:15:09PM +0200, Greg Kroah-Hartman wrote:
> > > > > > > On Fri, Jul 17, 2026 at 06:10:41AM -0400, Michael S. Tsirkin wrote:
> > > > > > > > On Fri, Jul 17, 2026 at 11:14:23AM +0200, Greg Kroah-Hartman wrote:
> > > > > > > > > On Fri, Jul 17, 2026 at 04:59:32AM -0400, Michael S. Tsirkin wrote:
> > > > > > > > > > On Fri, Jul 17, 2026 at 10:39:40AM +0200, David Hildenbrand (Arm) wrote:
> > > > > > > > > > > On 7/17/26 07:48, Michael S. Tsirkin wrote:
> > > > > > > > > > > > On Thu, Jul 16, 2026 at 05:59:05PM +0200, David Hildenbrand (Arm) wrote:
> > > > > > > > > > > >>> Or do we just always trust virtio mem devices explicitly?
> > > > > > > > > > > >>
> > > > > > > > > > > >> It's hard for me to understand where we draw the line, really.
> > > > > > > > > > > >>
> > > > > > > > > > > >> But maybe MST can clarify what we care about in virtio world where the
> > > > > > > > > > > >> hypervisor is fully in charge of the device,
> > > > > > > > > > > > 
> > > > > > > > > > > > Generally:
> > > > > > > > > > > > - The guest is expected to whitelist drivers (most drivers have not
> > > > > > > > > > > >   been audited).
> > > > > > > > > > > 
> > > > > > > > > > > But even if you audited your driver, who makes sure that we consider all ways
> > > > > > > > > > > where the device could mess with us?
> > > > > > > > > > 
> > > > > > > > > > A lot of this is up to a correct setup. For example, make sure all
> > > > > > > > > > filesystems are encrypted and refuse to mount unencrypted ones.
> > > > > > > > > > 
> > > > > > > > > > > Something feels off here.
> > > > > > > > > > > 
> > > > > > > > > > > Handling selected out-of-spec scenarios like this feels like a band-aid. Happy
> > > > > > > > > > > to be corrected.
> > > > > > > > > > 
> > > > > > > > > > Well Documentation/security/snp-tdx-threat-model.rst puts it like this:
> > > > > > > > > > 	It is important to note
> > > > > > > > > > 	that this doesn’t imply that the host or VMM are intentionally
> > > > > > > > > > 	malicious, but that there exists a security value in having a small CoCo
> > > > > > > > > > 	VM TCB.
> > > > > > > > > > 
> > > > > > > > > > and
> > > > > > > > > > 
> > > > > > > > > > 	While traditionally the host has unlimited access to guest data and can
> > > > > > > > > > 	leverage this access to attack the guest, the CoCo systems mitigate such
> > > > > > > > > > 	attacks by adding security features like guest data confidentiality and
> > > > > > > > > > 	integrity protection.
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > now, when we are talking about "mitigation" it is indeed becoming a bit
> > > > > > > > > > murky.
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > For me, a rule of thumb I came up with is that if the validation happens
> > > > > > > > > > to also be helful for users e.g. to work around buggy devices,
> > > > > > > > > > or maybe because we feel failing gracefully is nice because this
> > > > > > > > > > will allow to later make use of this config and old drivers will
> > > > > > > > > > fail but at least not panic, then it is good to include.
> > > > > > > > > 
> > > > > > > > > Why not do what USB does?  Don't trust the device until AFTER probe()
> > > > > > > > > succeeds?  All of the needed checking should happen before then, as that
> > > > > > > > > is a "slow path" so lots of validation and the like can happen at that
> > > > > > > > > point.
> > > > > > > > > 
> > > > > > > > > After that, during the normal data paths, after the driver is bound,
> > > > > > > > > trust it all you want as attempting to validate every single packet is
> > > > > > > > > just going to be impossible.
> > > > > > > > > 
> > > > > > > > > thanks,
> > > > > > > > > 
> > > > > > > > > greg k-h
> > > > > > > > 
> > > > > > > > People do expect that data path validation at this point.
> > > > > > > 
> > > > > > > Ok, so you want this patch :)
> > > > > > > 
> > > > > > > And more, as you need to treat everything from the host as "untrusted",
> > > > > > > and it must be "verified".
> > > > > > 
> > > > > > Well. First it's not me) Second it's only specific configurations -
> > > > > > for example there's no short term plan to validate filesystem code, people
> > > > > > are expected to rely on encryption. The reasons have more to do
> > > > > > with the available manpower than anything else.
> > > > > 
> > > > > Sure, but again, for subsystems, you have to define your threat model as
> > > > > the LLMs are churning against the code base and coming up with lots of
> > > > > crazy ideas if a device should or should not be trusted and spitting out
> > > > > patches and reports like the ones that are in the first few patches of
> > > > > this series.
> > > > > 
> > > > > So please, pick a model, let's document it, and go with that.  I am
> > > > > getting directly conflicting responses here.
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > 
> > > > Supposed to be this one:
> > > > Documentation/security/snp-tdx-threat-model.rst
> > > > 
> > > > what is missing?
> > > 
> > > A policy decision that needs to be made.  All that document does is
> > > describe a bunch of different "threats" yet does not decide what to do
> > > about them at all from what I can tell.
> > 
> > That would be this section I think:
> > 
> > 	The **Linux kernel CoCo VM security objectives** can be summarized as follows:
> > 
> > it does, indeed, not go into detail about how to interact, safely,
> > with untrusted entities. Does it really need to be spelled out?
> 
> Seems like it as I didn't figure it out at all :)
> 
> > > And that's just for one subset of the CoC world, right?  Is that
> > > something that all virtio drivers need/want to care about?
> > 
> > What is missing, and what you seem to be asking for, is an opinionated
> > stance on which drivers we care about in this world?
> > True.
> 
> Yes.
> 
> > coco guys tried to annotate drivers at some point to do exactly that.
> > this was rejected upstream from the position that this is not
> > different from handling buggy hardware, and just to fix all drivers.
> > so it's up to users, and I guess for virtio the answer is yes
> > with some exceptions because we don't have a better answer right now.
> 
> Ok, so back to the original question here:
> 
> > > So I don't see a real answer to the "does Linux trust the host to give
> > > you good data or not" question in that file, am I missing it?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > This? Note the last sentence.
> > 
> > The **Linux CoCo VM attack surface** is any interface exposed from a CoCo
> > guest Linux kernel towards an untrusted host that is not covered by the
> > CoCo technology SW/HW protection. This includes any possible
> > side-channels, as well as transient execution side channels. Examples of
> > explicit (not side-channel) interfaces include accesses to port I/O, MMIO
> > and DMA interfaces, access to PCI configuration space, VMM-specific
> > hypercalls (towards Host-side VMM), access to shared memory pages,
> > interrupts allowed to be injected into the guest kernel by the host, as
> > well as CoCo technology-specific hypercalls, if present. Additionally, the
> > host in a CoCo system typically controls the process of creating a CoCo
> > guest: it has a method to load into a guest the firmware and bootloader
> > images, the kernel image together with the kernel command line. All of this
> > data should also be considered untrusted until its integrity and
> > authenticity is established via attestation.
> 
> Great, so you are saying that we need to fix any bug found where a host
> could be sending "bad" data over the virtio path before, and after, the
> driver is bound to the device.  That's a solid answer, and let's let the
> LLMs run with that!
> 
> Which also implies that the first 3 patches here are acceptable, right?
> :)
> 
> thanks,
> 
> greg k-h

The 1st patch has nothing to do with coco. Bad values it checks do not
lead to any information leak. I'm fine with it as such but I
would like the commit log to make that clearer.

-- 
MST

