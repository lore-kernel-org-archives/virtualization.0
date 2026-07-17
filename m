Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A7942CAE5
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305856; cv=none; b=CkUOCPdxT38ukZqcShoeuS3nVi3/sxfbsUGXquVjZb//tSQPc98+zJzpDuJbbAn9nEn1N6po+jA79XxO38dFnQMIHOsROoIzHnOQDqD2SzqI2u1JWD/jI79M2EkvobnX0GP6errgECpi/7Z/RYTbrYk73h3Y2s88mn2B6jT7Q6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305856; c=relaxed/simple;
	bh=RmbGwGg1KzfgJFoufQ7Ebzl+MgXG82cSgzTROQ+0NxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qYoU654OdF/f2clupsugpnJD1PqGsfPNqekXJjeGXYjwAuuHGCpyMLCdtBceCQOzePXtTPS7hlcmUb5Zn5de4FtF6HO8FLayKTyE045fLapnlzA8t7FVEb8PFBHyQ7tYV+j+si8j1Wa5o07sl+EwS6akjyUae3VRaryknfrCNTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tg/mbYQY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tg/mbYQY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784305848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QyVdvyYwjyVRXdVeS5K/eO0SzcexWnTtdt9J6XLMqg=;
	b=Tg/mbYQYK+eXdN1eqNd1dVzolFQ/kz6T6b1OtMmO6ItjB40DGrZ6xLeLn6IwSPGW3JhDEU
	rtEK4ZboRugHfH4DTWvJsNFF9NRkgmJstePSpOHQcTgsGh8GLNwydj41aUOCICHripxHvC
	KMpwwo9QGkWXSLVwFoaC61sngBEJrCs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-WJCm_yADPhWVWTKElbC15Q-1; Fri, 17 Jul 2026 12:30:47 -0400
X-MC-Unique: WJCm_yADPhWVWTKElbC15Q-1
X-Mimecast-MFC-AGG-ID: WJCm_yADPhWVWTKElbC15Q_1784305846
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-473e18559b2so2852020f8f.0
        for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 09:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784305846; x=1784910646;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1QyVdvyYwjyVRXdVeS5K/eO0SzcexWnTtdt9J6XLMqg=;
        b=BEZheys1ItZPWUjIGjUfNNTnXhHHTayY/CLowqDljnMaDOjbQB7MEd2/PYmZxzY23c
         LJr6LEDNepqJSmYXxMpcUmTsLqa0ud33C+oMgqdofQjdoKgvHhv0dTo4VFoCGBQz/ql0
         BeZOR2gZgFCwfaXLg+Krz/UahL8MSl/FF3PYSnrGpHqTi37IevADZ8Q2SsD/1Dsm8QDw
         cGca0+nd4UidiosYl4Z+LZgtq+GTAg3ICG4tCiVRpzuNi594L20zz9Oz15kgr1dhJBmU
         NS3ZYLXJdhmv03LmP2+BhsIjkNGpMqqIzf/6OVAXePVkEr0m8NQOqSGLjM104AlLpbvl
         P40w==
X-Forwarded-Encrypted: i=1; AHgh+RqLGYW+0XfQDTi+DmbzMIrJycJEGQKBTou/1euKgio6eaNJ0rEvErrB4lQttvdABgHIhzdgWLzNtLIZM1NE/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyExjnmUKQ/WtCx9B1hC+aSerQu2/iQwJhmkjVckMIMMTU+jQA6
	bY0233C+EQBQK65opXdvKU7DeMHC3NDbtF/jAS/I1hljikRIQfFbF2UrBJSDzFm0PVSiC3dMHOG
	pkNC6qE3mFl96g5fOSm2Ulj88T6Yl66mncj3HbDELBJ81mYq3qhrw/crYJr8H5o8aplSj
X-Gm-Gg: AfdE7ckpPZgnldy1PP6genP24ZNeBdNcFhGpYtkDQGKUDHIBHT7GtRJUavHVtp07nd0
	73Oj6UDybItrPcqbc3GZ4maSv85DV+LKXTNuTW3ZcuONhF+vfh14IKzlb5dbCUc9rPsYqCOLdDf
	VCfg6OayP+q8LXYr0itDV8wV2Z3FovTEfwDWCBqnWXEKJMtzA9/uf76Wc1X1A1TMe7JgC05NxR6
	sBAgQ987DRkaOyGRcsLckOZ99OgLKaDuUtk8HVoJS4kDYgv200NOZbQOy4Mtl5elqiifr+EGR08
	O4jIsmKWraz/8XtT+/T73aBFftSdWtPTpkR0t0Jx2vMamO9sq1eRaVOmMRPni7LspG+sfIEULK+
	m77fBRJlDn/VXmjyXp3xox1JU
X-Received: by 2002:a05:6000:2c03:b0:473:975c:4fd1 with SMTP id ffacd0b85a97d-47f62314f83mr4384478f8f.25.1784305845549;
        Fri, 17 Jul 2026 09:30:45 -0700 (PDT)
X-Received: by 2002:a05:6000:2c03:b0:473:975c:4fd1 with SMTP id ffacd0b85a97d-47f62314f83mr4384417f8f.25.1784305844884;
        Fri, 17 Jul 2026 09:30:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e52f81sm5426688f8f.9.2026.07.17.09.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:30:44 -0700 (PDT)
Date: Fri, 17 Jul 2026 12:30:41 -0400
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
Message-ID: <20260717122954-mutt-send-email-mst@kernel.org>
References: <2026071746-deviation-clad-1712@gregkh>
 <20260717060822-mutt-send-email-mst@kernel.org>
 <2026071757-grout-composer-165d@gregkh>
 <20260717061901-mutt-send-email-mst@kernel.org>
 <2026071724-asleep-pedigree-ea54@gregkh>
 <20260717065219-mutt-send-email-mst@kernel.org>
 <2026071759-thermal-synopsis-7568@gregkh>
 <20260717085838-mutt-send-email-mst@kernel.org>
 <2026071724-modulator-pliable-fa1c@gregkh>
 <20260717122729-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260717122729-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OFHFFuUo0UGcayOwW7S6LWdkFLKBsuoGyb9yvAbGH4g_1784305846
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jul 17, 2026 at 12:28:45PM -0400, Michael S. Tsirkin wrote:
> On Fri, Jul 17, 2026 at 04:31:03PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Jul 17, 2026 at 09:08:23AM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Jul 17, 2026 at 02:07:50PM +0200, Greg Kroah-Hartman wrote:
> > > > On Fri, Jul 17, 2026 at 06:52:46AM -0400, Michael S. Tsirkin wrote:
> > > > > On Fri, Jul 17, 2026 at 12:46:52PM +0200, Greg Kroah-Hartman wrote:
> > > > > > On Fri, Jul 17, 2026 at 06:23:57AM -0400, Michael S. Tsirkin wrote:
> > > > > > > On Fri, Jul 17, 2026 at 12:15:09PM +0200, Greg Kroah-Hartman wrote:
> > > > > > > > On Fri, Jul 17, 2026 at 06:10:41AM -0400, Michael S. Tsirkin wrote:
> > > > > > > > > On Fri, Jul 17, 2026 at 11:14:23AM +0200, Greg Kroah-Hartman wrote:
> > > > > > > > > > On Fri, Jul 17, 2026 at 04:59:32AM -0400, Michael S. Tsirkin wrote:
> > > > > > > > > > > On Fri, Jul 17, 2026 at 10:39:40AM +0200, David Hildenbrand (Arm) wrote:
> > > > > > > > > > > > On 7/17/26 07:48, Michael S. Tsirkin wrote:
> > > > > > > > > > > > > On Thu, Jul 16, 2026 at 05:59:05PM +0200, David Hildenbrand (Arm) wrote:
> > > > > > > > > > > > >>> Or do we just always trust virtio mem devices explicitly?
> > > > > > > > > > > > >>
> > > > > > > > > > > > >> It's hard for me to understand where we draw the line, really.
> > > > > > > > > > > > >>
> > > > > > > > > > > > >> But maybe MST can clarify what we care about in virtio world where the
> > > > > > > > > > > > >> hypervisor is fully in charge of the device,
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Generally:
> > > > > > > > > > > > > - The guest is expected to whitelist drivers (most drivers have not
> > > > > > > > > > > > >   been audited).
> > > > > > > > > > > > 
> > > > > > > > > > > > But even if you audited your driver, who makes sure that we consider all ways
> > > > > > > > > > > > where the device could mess with us?
> > > > > > > > > > > 
> > > > > > > > > > > A lot of this is up to a correct setup. For example, make sure all
> > > > > > > > > > > filesystems are encrypted and refuse to mount unencrypted ones.
> > > > > > > > > > > 
> > > > > > > > > > > > Something feels off here.
> > > > > > > > > > > > 
> > > > > > > > > > > > Handling selected out-of-spec scenarios like this feels like a band-aid. Happy
> > > > > > > > > > > > to be corrected.
> > > > > > > > > > > 
> > > > > > > > > > > Well Documentation/security/snp-tdx-threat-model.rst puts it like this:
> > > > > > > > > > > 	It is important to note
> > > > > > > > > > > 	that this doesn’t imply that the host or VMM are intentionally
> > > > > > > > > > > 	malicious, but that there exists a security value in having a small CoCo
> > > > > > > > > > > 	VM TCB.
> > > > > > > > > > > 
> > > > > > > > > > > and
> > > > > > > > > > > 
> > > > > > > > > > > 	While traditionally the host has unlimited access to guest data and can
> > > > > > > > > > > 	leverage this access to attack the guest, the CoCo systems mitigate such
> > > > > > > > > > > 	attacks by adding security features like guest data confidentiality and
> > > > > > > > > > > 	integrity protection.
> > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > now, when we are talking about "mitigation" it is indeed becoming a bit
> > > > > > > > > > > murky.
> > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > For me, a rule of thumb I came up with is that if the validation happens
> > > > > > > > > > > to also be helful for users e.g. to work around buggy devices,
> > > > > > > > > > > or maybe because we feel failing gracefully is nice because this
> > > > > > > > > > > will allow to later make use of this config and old drivers will
> > > > > > > > > > > fail but at least not panic, then it is good to include.
> > > > > > > > > > 
> > > > > > > > > > Why not do what USB does?  Don't trust the device until AFTER probe()
> > > > > > > > > > succeeds?  All of the needed checking should happen before then, as that
> > > > > > > > > > is a "slow path" so lots of validation and the like can happen at that
> > > > > > > > > > point.
> > > > > > > > > > 
> > > > > > > > > > After that, during the normal data paths, after the driver is bound,
> > > > > > > > > > trust it all you want as attempting to validate every single packet is
> > > > > > > > > > just going to be impossible.
> > > > > > > > > > 
> > > > > > > > > > thanks,
> > > > > > > > > > 
> > > > > > > > > > greg k-h
> > > > > > > > > 
> > > > > > > > > People do expect that data path validation at this point.
> > > > > > > > 
> > > > > > > > Ok, so you want this patch :)
> > > > > > > > 
> > > > > > > > And more, as you need to treat everything from the host as "untrusted",
> > > > > > > > and it must be "verified".
> > > > > > > 
> > > > > > > Well. First it's not me) Second it's only specific configurations -
> > > > > > > for example there's no short term plan to validate filesystem code, people
> > > > > > > are expected to rely on encryption. The reasons have more to do
> > > > > > > with the available manpower than anything else.
> > > > > > 
> > > > > > Sure, but again, for subsystems, you have to define your threat model as
> > > > > > the LLMs are churning against the code base and coming up with lots of
> > > > > > crazy ideas if a device should or should not be trusted and spitting out
> > > > > > patches and reports like the ones that are in the first few patches of
> > > > > > this series.
> > > > > > 
> > > > > > So please, pick a model, let's document it, and go with that.  I am
> > > > > > getting directly conflicting responses here.
> > > > > > 
> > > > > > thanks,
> > > > > > 
> > > > > > greg k-h
> > > > > 
> > > > > Supposed to be this one:
> > > > > Documentation/security/snp-tdx-threat-model.rst
> > > > > 
> > > > > what is missing?
> > > > 
> > > > A policy decision that needs to be made.  All that document does is
> > > > describe a bunch of different "threats" yet does not decide what to do
> > > > about them at all from what I can tell.
> > > 
> > > That would be this section I think:
> > > 
> > > 	The **Linux kernel CoCo VM security objectives** can be summarized as follows:
> > > 
> > > it does, indeed, not go into detail about how to interact, safely,
> > > with untrusted entities. Does it really need to be spelled out?
> > 
> > Seems like it as I didn't figure it out at all :)
> > 
> > > > And that's just for one subset of the CoC world, right?  Is that
> > > > something that all virtio drivers need/want to care about?
> > > 
> > > What is missing, and what you seem to be asking for, is an opinionated
> > > stance on which drivers we care about in this world?
> > > True.
> > 
> > Yes.
> > 
> > > coco guys tried to annotate drivers at some point to do exactly that.
> > > this was rejected upstream from the position that this is not
> > > different from handling buggy hardware, and just to fix all drivers.
> > > so it's up to users, and I guess for virtio the answer is yes
> > > with some exceptions because we don't have a better answer right now.
> > 
> > Ok, so back to the original question here:
> > 
> > > > So I don't see a real answer to the "does Linux trust the host to give
> > > > you good data or not" question in that file, am I missing it?
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > This? Note the last sentence.
> > > 
> > > The **Linux CoCo VM attack surface** is any interface exposed from a CoCo
> > > guest Linux kernel towards an untrusted host that is not covered by the
> > > CoCo technology SW/HW protection. This includes any possible
> > > side-channels, as well as transient execution side channels. Examples of
> > > explicit (not side-channel) interfaces include accesses to port I/O, MMIO
> > > and DMA interfaces, access to PCI configuration space, VMM-specific
> > > hypercalls (towards Host-side VMM), access to shared memory pages,
> > > interrupts allowed to be injected into the guest kernel by the host, as
> > > well as CoCo technology-specific hypercalls, if present. Additionally, the
> > > host in a CoCo system typically controls the process of creating a CoCo
> > > guest: it has a method to load into a guest the firmware and bootloader
> > > images, the kernel image together with the kernel command line. All of this
> > > data should also be considered untrusted until its integrity and
> > > authenticity is established via attestation.
> > 
> > Great, so you are saying that we need to fix any bug found where a host
> > could be sending "bad" data over the virtio path before, and after, the
> > driver is bound to the device.  That's a solid answer, and let's let the
> > LLMs run with that!
> > 
> > Which also implies that the first 3 patches here are acceptable, right?
> > :)
> > 
> > thanks,
> > 
> > greg k-h
> 
> The 1st patch has nothing to do with coco. Bad values it checks do not
> lead to any information leak. I'm fine with it as such
> but I
> would like the commit log to make that clearer.


Or to be more precise, I'd like the motivation to be documented,
given it is not coco, and then I can judge the merits.

> 
> -- 
> MST

