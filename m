Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627AD38944D
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285579; cv=none; b=hC9sM8W6M5spUXnbl2Hzqk2uAyXtXZJmSyz5GUkccEfXsufa0YkYDJPtl8O/Bry8VgbW8P3sDiKz4ELpaOLM0hMNY3acaZPoRTIxdfgjvmgKLml3r/QeohiOtRbc9l3HcZIKJzhfFaZc5hEnZZiHGtBZ5CjN9BWM333VSMpgQRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285579; c=relaxed/simple;
	bh=MNcrJ27Gcwu9ihreicb1PwSR6kc3JmhVCZZ4+/19oJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YAwrJ6T1s8ACSl8dF2BLR3BYflNqtHsQ9uv9Lf5WwO33PSsPZHElyMaZ7BkW4s24WlGgKGFjXidlx3dBN7+/UQ4sPIKdqZarlOY7j263VukpqnUm7G5QI/0TJQr4kvj2ppTYxaMTMoVzltkxKPBw52KCxkthRegJ8aVM8Zw0p8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aPaA9GFR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPaA9GFR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784285573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cnNiFM3oYyCzKGopZNerLxOmD+x6ADurdkKBvUE26Zg=;
	b=aPaA9GFRi71vU8yrJaMf26i0r0V1uF2YrnoFiUh+sV7NlBhYKLk++3AwiLwy6lHsldt4Q/
	v70amg0O6QjaREG4iPNykLJXvRMdnJSl7T0qpdvXDNESf60Jl/AABX1A1KWmC7gMTMDin0
	VHoRA1vxn5JLv5amenG4oNBJgD8tRb8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-rj0bhlFfOrK7Lq1pe8RP-g-1; Fri, 17 Jul 2026 06:52:51 -0400
X-MC-Unique: rj0bhlFfOrK7Lq1pe8RP-g-1
X-Mimecast-MFC-AGG-ID: rj0bhlFfOrK7Lq1pe8RP-g_1784285571
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f24a50f0cso6701556f8f.3
        for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 03:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784285571; x=1784890371;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cnNiFM3oYyCzKGopZNerLxOmD+x6ADurdkKBvUE26Zg=;
        b=m8oCZH8mT36mgGTrG/R3J0H5Glhf63soFDZ/bgk19MU7aWA8ZbOGVoSwFV5mX85XoW
         bmwgrx9rbe9Ax1W+uNuFip0v2aCYJpKIvvrVhpfrj0r+Cr+Lk1oAx70rJwt81e0bYJiQ
         QlTKXNyNUWnrpXOJ965CagX33WJ3aXryeJ5Y3CeOsWa6LX3hUmclKWMnAhYaHF6ztIVr
         MRvsecV2vMm5dyPGXk/myQ88yMq49jZa/1J15w4YN0cUzjk6NP0VSwdxFbOhPzudRT8k
         nsCCyDkknCIynGh9exe+nBsoSBzaArUt3UZ96exlWxKCroZVplH0GpQAfaMmySgAN4xy
         Cy4w==
X-Forwarded-Encrypted: i=1; AHgh+RrZnkXvaQhKSkgfYPN8d930y4A7SDrQKftBioIZ+Y9fHWM02YZcK1aa1JbSHtQXm8ApTFRaZ6JWxQTd95O9Eg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaTGAB1JwadMj2jVxCq8cMpROUxo3tfoxZyofC7Q6OwC4ICRvy
	z9z9d5KdYM2IbuXbLVgEcMm9ii2fyH6F4mM6MM/pxfIP/fDMJ8fDp5TrvvrzTFwKdmb+EqR7Jxm
	FCVbQUW0z24haleJJP8kFhPtbS1d4kd8D4mhZfUKj9Fbp2JzF1uJl8IMI91NvAxk9Ira7
X-Gm-Gg: AfdE7clRo+YRQqSULt40r70H3qsmhDDa8mg210ZKBPN32u/qkn3YI4+ZzvR12HcDVdr
	wvm/2v3q0D/DrkTKYKpUYfZ0ByMRFjuFR0inaFql/YRfKUA0b4Pbc1nqDlJs6uxReKiwJ8Rf/f1
	1KEs0RhNehjdRyZ9LhblEVZXgA4ZuvL/jRI0ZY7IFgZmD/gKz1jLVAgA9W2NH5+Y9+nn/VrtDUZ
	7aSIoK/U1ubwHPs0nXn0+BicpIxD+z7lf1jMzfRIkv/Ldr+s8rP5e+jm9q9adi9QW/5j1gx1Dk6
	jNTB1A+6W6gbH8vSzXeLCLtnkiPjReUG/dgLcUV1XXbvBrfTAhgQx/QiyFoRFooupDPK7KgpatJ
	oA5dZTUEu8lSAbBL2ENqgEjFR
X-Received: by 2002:a05:600c:4ed1:b0:495:4cb8:42b9 with SMTP id 5b1f17b1804b1-4954cb842f7mr7060505e9.4.1784285570317;
        Fri, 17 Jul 2026 03:52:50 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed1:b0:495:4cb8:42b9 with SMTP id 5b1f17b1804b1-4954cb842f7mr7060245e9.4.1784285569748;
        Fri, 17 Jul 2026 03:52:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edbe4sm39919225e9.12.2026.07.17.03.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 03:52:49 -0700 (PDT)
Date: Fri, 17 Jul 2026 06:52:46 -0400
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
Message-ID: <20260717065219-mutt-send-email-mst@kernel.org>
References: <2026071635-relive-flogging-2a81@gregkh>
 <4dda47ba-534a-4297-a25e-0d63d9167033@kernel.org>
 <20260717014134-mutt-send-email-mst@kernel.org>
 <3b32a38f-0964-45b9-9529-933abedbf69b@kernel.org>
 <20260717044019-mutt-send-email-mst@kernel.org>
 <2026071746-deviation-clad-1712@gregkh>
 <20260717060822-mutt-send-email-mst@kernel.org>
 <2026071757-grout-composer-165d@gregkh>
 <20260717061901-mutt-send-email-mst@kernel.org>
 <2026071724-asleep-pedigree-ea54@gregkh>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2026071724-asleep-pedigree-ea54@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LH-Ha44z6Ci88HcJIZ_wkuDkwT1raLcP9Ypd3dSW9cA_1784285571
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jul 17, 2026 at 12:46:52PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 17, 2026 at 06:23:57AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Jul 17, 2026 at 12:15:09PM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Jul 17, 2026 at 06:10:41AM -0400, Michael S. Tsirkin wrote:
> > > > On Fri, Jul 17, 2026 at 11:14:23AM +0200, Greg Kroah-Hartman wrote:
> > > > > On Fri, Jul 17, 2026 at 04:59:32AM -0400, Michael S. Tsirkin wrote:
> > > > > > On Fri, Jul 17, 2026 at 10:39:40AM +0200, David Hildenbrand (Arm) wrote:
> > > > > > > On 7/17/26 07:48, Michael S. Tsirkin wrote:
> > > > > > > > On Thu, Jul 16, 2026 at 05:59:05PM +0200, David Hildenbrand (Arm) wrote:
> > > > > > > >>> Or do we just always trust virtio mem devices explicitly?
> > > > > > > >>
> > > > > > > >> It's hard for me to understand where we draw the line, really.
> > > > > > > >>
> > > > > > > >> But maybe MST can clarify what we care about in virtio world where the
> > > > > > > >> hypervisor is fully in charge of the device,
> > > > > > > > 
> > > > > > > > Generally:
> > > > > > > > - The guest is expected to whitelist drivers (most drivers have not
> > > > > > > >   been audited).
> > > > > > > 
> > > > > > > But even if you audited your driver, who makes sure that we consider all ways
> > > > > > > where the device could mess with us?
> > > > > > 
> > > > > > A lot of this is up to a correct setup. For example, make sure all
> > > > > > filesystems are encrypted and refuse to mount unencrypted ones.
> > > > > > 
> > > > > > > Something feels off here.
> > > > > > > 
> > > > > > > Handling selected out-of-spec scenarios like this feels like a band-aid. Happy
> > > > > > > to be corrected.
> > > > > > 
> > > > > > Well Documentation/security/snp-tdx-threat-model.rst puts it like this:
> > > > > > 	It is important to note
> > > > > > 	that this doesn’t imply that the host or VMM are intentionally
> > > > > > 	malicious, but that there exists a security value in having a small CoCo
> > > > > > 	VM TCB.
> > > > > > 
> > > > > > and
> > > > > > 
> > > > > > 	While traditionally the host has unlimited access to guest data and can
> > > > > > 	leverage this access to attack the guest, the CoCo systems mitigate such
> > > > > > 	attacks by adding security features like guest data confidentiality and
> > > > > > 	integrity protection.
> > > > > > 
> > > > > > 
> > > > > > now, when we are talking about "mitigation" it is indeed becoming a bit
> > > > > > murky.
> > > > > > 
> > > > > > 
> > > > > > For me, a rule of thumb I came up with is that if the validation happens
> > > > > > to also be helful for users e.g. to work around buggy devices,
> > > > > > or maybe because we feel failing gracefully is nice because this
> > > > > > will allow to later make use of this config and old drivers will
> > > > > > fail but at least not panic, then it is good to include.
> > > > > 
> > > > > Why not do what USB does?  Don't trust the device until AFTER probe()
> > > > > succeeds?  All of the needed checking should happen before then, as that
> > > > > is a "slow path" so lots of validation and the like can happen at that
> > > > > point.
> > > > > 
> > > > > After that, during the normal data paths, after the driver is bound,
> > > > > trust it all you want as attempting to validate every single packet is
> > > > > just going to be impossible.
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > 
> > > > People do expect that data path validation at this point.
> > > 
> > > Ok, so you want this patch :)
> > > 
> > > And more, as you need to treat everything from the host as "untrusted",
> > > and it must be "verified".
> > 
> > Well. First it's not me) Second it's only specific configurations -
> > for example there's no short term plan to validate filesystem code, people
> > are expected to rely on encryption. The reasons have more to do
> > with the available manpower than anything else.
> 
> Sure, but again, for subsystems, you have to define your threat model as
> the LLMs are churning against the code base and coming up with lots of
> crazy ideas if a device should or should not be trusted and spitting out
> patches and reports like the ones that are in the first few patches of
> this series.
> 
> So please, pick a model, let's document it, and go with that.  I am
> getting directly conflicting responses here.
> 
> thanks,
> 
> greg k-h

Supposed to be this one:
Documentation/security/snp-tdx-threat-model.rst

what is missing?


-- 
MST

