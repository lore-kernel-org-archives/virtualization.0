Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF361AA7A6
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293714; cv=none; b=mYTJunOaCdlsxPunZfjzuT5DE5BRnKNA7+NqKcaA4oWYiJIOv5kaHxmRV/3xD7+6q1z7KIhrF57bnRvKFAZNrUaZ5jFCoio0U8PBqArH4F1Ljy3B4/KYa0e8x8AvOJJ9VslkiOr6z8mRZkjnTnRMFSRCqiFBksBDwdCH+mPw+Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293714; c=relaxed/simple;
	bh=SYBJ8I2vOFE20n9zvoCaJ27qw72MtUpQ5WJZf17afpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oVFoZdBjOtMuTXhxsdGG1HqjMOATKci/ARGX7E3+cfp2lXnVT2YSnzpXjlcTwjfCZPJcoei4LCYIRuUMzdgM32sHq6BDO9pyOe3qFn36fDC8DxVA2v8Jfi6/MLDNNrYZ6PmEgHsy4Vd1Oug47E+N5qm9n36VMS8rgpQCn9+jnHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XwtsehLL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwtsehLL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784293712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Adg6o3Sp07Mg8EgEzVHcdip9gLyL6+d2pKPLervpt+o=;
	b=XwtsehLLEb4C9skNKxcXcmu17d+q9T3s/D24Q5463M+x3b1vLkoW+OCr4ACRSi4DsFuFZF
	tmVG2fpiFgD4K9e0qV+lPIk0Wg3V+PNrt4ujyZ64KmAan08NVwtLxlY49vsTtatZZryO8+
	XqiVMvhNQuy/cUGLRJvtHRvJp/LIWcs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-tJfRChMjPmSg0es7Kma1kw-1; Fri, 17 Jul 2026 09:08:29 -0400
X-MC-Unique: tJfRChMjPmSg0es7Kma1kw-1
X-Mimecast-MFC-AGG-ID: tJfRChMjPmSg0es7Kma1kw_1784293708
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-473ac08a6a4so5024322f8f.0
        for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 06:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784293708; x=1784898508;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Adg6o3Sp07Mg8EgEzVHcdip9gLyL6+d2pKPLervpt+o=;
        b=eW4/eyzWZFTZSLq2MmlxoG++qYs06zxoe0Z4CKlEpkC+q/nZenaZu+rs8Cz0HBFpQq
         1EFar2th3tWD5PGItvyj7WCAj1NKrGPGwC2fgVzN28KPv/+riCQT0uIf+X2nF9kGnotf
         PfTPqvA9zUk8xx/YEjJRV/B0DV7yI3NOV14+/DhC+RR1r4hj/+SsbMA4eeRCg+GHmzZK
         hvY//Lf2SCf6FvFah5ioR0gSnqf1wSFmiVdjHEayJ+0ZkqmQmF/crjn63Epmk2OOXtsq
         6vKh6TCrYoQz9yf8d3hn67IYN6GrgZtervIagGXDTeEsFC98nCJnfS7q/Kjg3wR/v7VN
         gT4Q==
X-Forwarded-Encrypted: i=1; AHgh+RqpB8Mjqpbh1sZWRa/wgnxfTEzx2/6ogyc+FBCdINWO3vIDvoCNzQTrpsl8AO3EF7NoPmxZHgzjbNpT08oLsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzN8Jjvm28yqVimrQjaD4I8KjIYTvs0xlB50HWWKze/dHpCHh5+
	nYlDTNc7z7iwxn7QP9GqFnvCZ9A0NGQI28nn0uIBWo1Lcb0SGFvrp4y1oJfQFBNh1twrymlo0aH
	UxayjQhe8EkEO1MBuc9bGBt3aq4vQnGFp2RqkF7V+t+khD5yflTMf8VTO4R4Y4nqxH9k5
X-Gm-Gg: AfdE7cmI16u++B7/gUvJ3d9DI22XZILV0ZIAFKUToACAkY/qtOwKZLDzvXDRc9I2zt6
	TeEKwXI1HOLbreI62mJDu61Cv4KdLQzRND6Iy+PDwkfarU/6bmy3TnvbaZy5OUGhdCG4cQ3Nxjk
	cZ08lkac1eHe+dR/OFu6uLx2LLzAZJfcglRLgJUOdKlyqnhSFeaizzEUorsMFnuyUlBtAd/eviz
	BbZ1iulGT9NTDtdbb0GqLS4gUuLDGSr2WpeugktojJWYUcXgkuGbc9/XbJkoo0oFEV90oomxTTe
	ys2u3jKU5pJUDKwtOcEHUo75/kc+IDH7mmPZNAC1pk2MXITCDJwkf6ij6vU7BEoR5IhvJ0Ia9GU
	+2NY4vCVGePSJ1A7igBuvLc7F
X-Received: by 2002:a05:600c:1d1d:b0:492:40a1:1e16 with SMTP id 5b1f17b1804b1-4954a3d0d86mr27128845e9.8.1784293707935;
        Fri, 17 Jul 2026 06:08:27 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1d:b0:492:40a1:1e16 with SMTP id 5b1f17b1804b1-4954a3d0d86mr27128385e9.8.1784293707339;
        Fri, 17 Jul 2026 06:08:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a2504sm51784305e9.2.2026.07.17.06.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:08:26 -0700 (PDT)
Date: Fri, 17 Jul 2026 09:08:23 -0400
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
Message-ID: <20260717085838-mutt-send-email-mst@kernel.org>
References: <20260717014134-mutt-send-email-mst@kernel.org>
 <3b32a38f-0964-45b9-9529-933abedbf69b@kernel.org>
 <20260717044019-mutt-send-email-mst@kernel.org>
 <2026071746-deviation-clad-1712@gregkh>
 <20260717060822-mutt-send-email-mst@kernel.org>
 <2026071757-grout-composer-165d@gregkh>
 <20260717061901-mutt-send-email-mst@kernel.org>
 <2026071724-asleep-pedigree-ea54@gregkh>
 <20260717065219-mutt-send-email-mst@kernel.org>
 <2026071759-thermal-synopsis-7568@gregkh>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2026071759-thermal-synopsis-7568@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0PDtwar7friWBlX3SO0uG2xV7599OA5gh7NedKP3UMU_1784293708
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jul 17, 2026 at 02:07:50PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 17, 2026 at 06:52:46AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Jul 17, 2026 at 12:46:52PM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Jul 17, 2026 at 06:23:57AM -0400, Michael S. Tsirkin wrote:
> > > > On Fri, Jul 17, 2026 at 12:15:09PM +0200, Greg Kroah-Hartman wrote:
> > > > > On Fri, Jul 17, 2026 at 06:10:41AM -0400, Michael S. Tsirkin wrote:
> > > > > > On Fri, Jul 17, 2026 at 11:14:23AM +0200, Greg Kroah-Hartman wrote:
> > > > > > > On Fri, Jul 17, 2026 at 04:59:32AM -0400, Michael S. Tsirkin wrote:
> > > > > > > > On Fri, Jul 17, 2026 at 10:39:40AM +0200, David Hildenbrand (Arm) wrote:
> > > > > > > > > On 7/17/26 07:48, Michael S. Tsirkin wrote:
> > > > > > > > > > On Thu, Jul 16, 2026 at 05:59:05PM +0200, David Hildenbrand (Arm) wrote:
> > > > > > > > > >>> Or do we just always trust virtio mem devices explicitly?
> > > > > > > > > >>
> > > > > > > > > >> It's hard for me to understand where we draw the line, really.
> > > > > > > > > >>
> > > > > > > > > >> But maybe MST can clarify what we care about in virtio world where the
> > > > > > > > > >> hypervisor is fully in charge of the device,
> > > > > > > > > > 
> > > > > > > > > > Generally:
> > > > > > > > > > - The guest is expected to whitelist drivers (most drivers have not
> > > > > > > > > >   been audited).
> > > > > > > > > 
> > > > > > > > > But even if you audited your driver, who makes sure that we consider all ways
> > > > > > > > > where the device could mess with us?
> > > > > > > > 
> > > > > > > > A lot of this is up to a correct setup. For example, make sure all
> > > > > > > > filesystems are encrypted and refuse to mount unencrypted ones.
> > > > > > > > 
> > > > > > > > > Something feels off here.
> > > > > > > > > 
> > > > > > > > > Handling selected out-of-spec scenarios like this feels like a band-aid. Happy
> > > > > > > > > to be corrected.
> > > > > > > > 
> > > > > > > > Well Documentation/security/snp-tdx-threat-model.rst puts it like this:
> > > > > > > > 	It is important to note
> > > > > > > > 	that this doesn’t imply that the host or VMM are intentionally
> > > > > > > > 	malicious, but that there exists a security value in having a small CoCo
> > > > > > > > 	VM TCB.
> > > > > > > > 
> > > > > > > > and
> > > > > > > > 
> > > > > > > > 	While traditionally the host has unlimited access to guest data and can
> > > > > > > > 	leverage this access to attack the guest, the CoCo systems mitigate such
> > > > > > > > 	attacks by adding security features like guest data confidentiality and
> > > > > > > > 	integrity protection.
> > > > > > > > 
> > > > > > > > 
> > > > > > > > now, when we are talking about "mitigation" it is indeed becoming a bit
> > > > > > > > murky.
> > > > > > > > 
> > > > > > > > 
> > > > > > > > For me, a rule of thumb I came up with is that if the validation happens
> > > > > > > > to also be helful for users e.g. to work around buggy devices,
> > > > > > > > or maybe because we feel failing gracefully is nice because this
> > > > > > > > will allow to later make use of this config and old drivers will
> > > > > > > > fail but at least not panic, then it is good to include.
> > > > > > > 
> > > > > > > Why not do what USB does?  Don't trust the device until AFTER probe()
> > > > > > > succeeds?  All of the needed checking should happen before then, as that
> > > > > > > is a "slow path" so lots of validation and the like can happen at that
> > > > > > > point.
> > > > > > > 
> > > > > > > After that, during the normal data paths, after the driver is bound,
> > > > > > > trust it all you want as attempting to validate every single packet is
> > > > > > > just going to be impossible.
> > > > > > > 
> > > > > > > thanks,
> > > > > > > 
> > > > > > > greg k-h
> > > > > > 
> > > > > > People do expect that data path validation at this point.
> > > > > 
> > > > > Ok, so you want this patch :)
> > > > > 
> > > > > And more, as you need to treat everything from the host as "untrusted",
> > > > > and it must be "verified".
> > > > 
> > > > Well. First it's not me) Second it's only specific configurations -
> > > > for example there's no short term plan to validate filesystem code, people
> > > > are expected to rely on encryption. The reasons have more to do
> > > > with the available manpower than anything else.
> > > 
> > > Sure, but again, for subsystems, you have to define your threat model as
> > > the LLMs are churning against the code base and coming up with lots of
> > > crazy ideas if a device should or should not be trusted and spitting out
> > > patches and reports like the ones that are in the first few patches of
> > > this series.
> > > 
> > > So please, pick a model, let's document it, and go with that.  I am
> > > getting directly conflicting responses here.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Supposed to be this one:
> > Documentation/security/snp-tdx-threat-model.rst
> > 
> > what is missing?
> 
> A policy decision that needs to be made.  All that document does is
> describe a bunch of different "threats" yet does not decide what to do
> about them at all from what I can tell.

That would be this section I think:

	The **Linux kernel CoCo VM security objectives** can be summarized as follows:

it does, indeed, not go into detail about how to interact, safely,
with untrusted entities. Does it really need to be spelled out?

> And that's just for one subset of the CoC world, right?  Is that
> something that all virtio drivers need/want to care about?

What is missing, and what you seem to be asking for, is an opinionated
stance on which drivers we care about in this world?
True.
coco guys tried to annotate drivers at some point to do exactly that.
this was rejected upstream from the position that this is not
different from handling buggy hardware, and just to fix all drivers.
so it's up to users, and I guess for virtio the answer is yes
with some exceptions because we don't have a better answer right now.

> So I don't see a real answer to the "does Linux trust the host to give
> you good data or not" question in that file, am I missing it?
> 
> thanks,
> 
> greg k-h

This? Note the last sentence.

The **Linux CoCo VM attack surface** is any interface exposed from a CoCo
guest Linux kernel towards an untrusted host that is not covered by the
CoCo technology SW/HW protection. This includes any possible
side-channels, as well as transient execution side channels. Examples of
explicit (not side-channel) interfaces include accesses to port I/O, MMIO
and DMA interfaces, access to PCI configuration space, VMM-specific
hypercalls (towards Host-side VMM), access to shared memory pages,
interrupts allowed to be injected into the guest kernel by the host, as
well as CoCo technology-specific hypercalls, if present. Additionally, the
host in a CoCo system typically controls the process of creating a CoCo
guest: it has a method to load into a guest the firmware and bootloader
images, the kernel image together with the kernel command line. All of this
data should also be considered untrusted until its integrity and
authenticity is established via attestation.



