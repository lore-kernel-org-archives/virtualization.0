Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB1B3E9C3D
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784283848; cv=none; b=slzFigbsX66q1h/0s76d/rJBPvLpgZKGti3ZmoAQEsE/mJ2OvcDHWAtzTL+ACRrDRQXsqx7mNLjL0MktEyt4eUW7A4ZfCL/gRl2f8yy6hp8qrak+AgMVOXOJLPXb+cXZYng3mro+wpBwD1D8uSwjtaJtSagh52XzkDGrGzHtR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784283848; c=relaxed/simple;
	bh=dFnwQxSzZV5PRkOGla0gIrk3G+di+qRW3UiXe3gSizI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JmFWB5CWX5MMeGCzc0BHf7z97vOAjrf4sG8ycedGxStDzqUXcLgVfOTvlJdnhLK1Nc8mtGf9a4iEPzQJwEaq+0Tt2cwJQ/LMRrIY6oRhYC20a9mhqUkXwTElxlCtYMhuuPaigPgHu/LmWOLANv7NcfuLyu8OFZe0mxNJiyoSmUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VDBDHMqZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDBDHMqZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784283844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcifcBgeFrOFIjK2y9k5VWrTOWRUYUBUyPh+odVYasU=;
	b=VDBDHMqZa2j5A4X3yZXAUpe9cCSo1yN5Th4/bJF/ju6jFfX2cSTUv+zjR20VdRIM8piu3e
	whsy1ncnz9mqa3w6mf8qqk2HbAkf0G6X8Ooa3RBlALMCwqosVp/8/+GMdwBe0Qw9nzmxiP
	jmlCrgiIpx6tlWBMEeqiOH0vqSQ764Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-gTlHZoaLOjSp6wg4tU0Ybw-1; Fri, 17 Jul 2026 06:24:03 -0400
X-MC-Unique: gTlHZoaLOjSp6wg4tU0Ybw-1
X-Mimecast-MFC-AGG-ID: gTlHZoaLOjSp6wg4tU0Ybw_1784283842
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-476608a9fefso1512777f8f.1
        for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 03:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784283842; x=1784888642;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rcifcBgeFrOFIjK2y9k5VWrTOWRUYUBUyPh+odVYasU=;
        b=e5SKOu84C5AgVPS4Np8MPRIV4yDv4ViZO74hvOlvWklYe4hPsPyFbulxxKH78Y01D/
         Uvt2sRpWNVYTYwtBZaYGpIQANM89KdyCLF7AeSFtLU4Xk/mWi3sm/IV8DYiQQJZJ1Zs7
         pXGR7wybrz2YS9lbHmHfb03bEzQH5he/q53lsu9VX54NTuejhGClbG3n9gY89Zege2vB
         5epEqWa4gmQ9UuXBRFETDRv/H3yw49bmCkq1W3q0N1tvUADeVgLUs2w8DD0TH8yCxdDx
         J2RGnLXxCC2BN+9Tvghsy3EvlHIIZtlh9nkxSWkcfuiAac3taS6s3c2j8KrJ71M9piJ9
         fdIA==
X-Forwarded-Encrypted: i=1; AHgh+RrVU/wc0WRvr9vq2a3khR/Rf3w66+Nf2WaRd9LBqyxG+Ca3p09SYbLDaYdDXpRVhYWWqEvXla9PQroKAtbK7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7QzPl/QPKpI1/lnFUWYrR8zl3ajX6cddMXSDsyTMSerOIehPa
	KzFABfeHPPr6nCzq+jc9bsqyoofOWt89ylVrkoq9lcqMGRoiGIqcqlyG3q/HWYgRi+RNIpPQKdf
	BVa1gWNuFhgANVyHAMYy1CVEDrTLh3GPRpnpBmBEbyt/9yhFjwxaMVg3Jj1gp8cdwYpHD
X-Gm-Gg: AfdE7clcjgbtGmynEmBrzwEAxLLF3B+DjgJ18520pDQ2B0dq3tytW2jGIhpFHjhSfXo
	RkHthZkTjM/AwXipkN+nBC35q7GcVLq5S0Q7/7GwNAx8u43x50q/V9G3Aq3dNVqpt30O4ZH0K7Q
	cuJWieMaCGFII6mt3bFi94NyEJb6ZH8YOawX9Vd7i3JVA5oCXV4B/Y1GYKKxEW5mEZ7vvk/hglr
	ZiJkZ+SAO1KbxsJWT2UvzEBJ7bbZHiI6zLQXUeg7rDp3m9G83J7zu/hmMuiU/qVi5Mp7/wyH5QD
	iRY+Q6JauTslJ1Xe9ukJoCi4P6hhsx257zeIFhPTSe743k1gedm5UyMhWErMQswwtSbL6nWIpvZ
	Zqxy8mGcI0W7CRm1qdi4Ie2SS
X-Received: by 2002:a05:6000:1885:b0:47d:f6a5:1fd6 with SMTP id ffacd0b85a97d-47f623f189bmr2419385f8f.26.1784283841600;
        Fri, 17 Jul 2026 03:24:01 -0700 (PDT)
X-Received: by 2002:a05:6000:1885:b0:47d:f6a5:1fd6 with SMTP id ffacd0b85a97d-47f623f189bmr2419319f8f.26.1784283840923;
        Fri, 17 Jul 2026 03:24:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ec66ebsm2653245f8f.21.2026.07.17.03.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 03:24:00 -0700 (PDT)
Date: Fri, 17 Jul 2026 06:23:57 -0400
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
Message-ID: <20260717061901-mutt-send-email-mst@kernel.org>
References: <20260715164139.40957-1-harimishal1@gmail.com>
 <b2176313-b444-4f66-a71c-647b92cc16a8@kernel.org>
 <2026071635-relive-flogging-2a81@gregkh>
 <4dda47ba-534a-4297-a25e-0d63d9167033@kernel.org>
 <20260717014134-mutt-send-email-mst@kernel.org>
 <3b32a38f-0964-45b9-9529-933abedbf69b@kernel.org>
 <20260717044019-mutt-send-email-mst@kernel.org>
 <2026071746-deviation-clad-1712@gregkh>
 <20260717060822-mutt-send-email-mst@kernel.org>
 <2026071757-grout-composer-165d@gregkh>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2026071757-grout-composer-165d@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SqCsFmq9aJ53B7z3zfSAhWFhPttbSR6UFHPfKiVAd4k_1784283842
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jul 17, 2026 at 12:15:09PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 17, 2026 at 06:10:41AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Jul 17, 2026 at 11:14:23AM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Jul 17, 2026 at 04:59:32AM -0400, Michael S. Tsirkin wrote:
> > > > On Fri, Jul 17, 2026 at 10:39:40AM +0200, David Hildenbrand (Arm) wrote:
> > > > > On 7/17/26 07:48, Michael S. Tsirkin wrote:
> > > > > > On Thu, Jul 16, 2026 at 05:59:05PM +0200, David Hildenbrand (Arm) wrote:
> > > > > >>> Or do we just always trust virtio mem devices explicitly?
> > > > > >>
> > > > > >> It's hard for me to understand where we draw the line, really.
> > > > > >>
> > > > > >> But maybe MST can clarify what we care about in virtio world where the
> > > > > >> hypervisor is fully in charge of the device,
> > > > > > 
> > > > > > Generally:
> > > > > > - The guest is expected to whitelist drivers (most drivers have not
> > > > > >   been audited).
> > > > > 
> > > > > But even if you audited your driver, who makes sure that we consider all ways
> > > > > where the device could mess with us?
> > > > 
> > > > A lot of this is up to a correct setup. For example, make sure all
> > > > filesystems are encrypted and refuse to mount unencrypted ones.
> > > > 
> > > > > Something feels off here.
> > > > > 
> > > > > Handling selected out-of-spec scenarios like this feels like a band-aid. Happy
> > > > > to be corrected.
> > > > 
> > > > Well Documentation/security/snp-tdx-threat-model.rst puts it like this:
> > > > 	It is important to note
> > > > 	that this doesn’t imply that the host or VMM are intentionally
> > > > 	malicious, but that there exists a security value in having a small CoCo
> > > > 	VM TCB.
> > > > 
> > > > and
> > > > 
> > > > 	While traditionally the host has unlimited access to guest data and can
> > > > 	leverage this access to attack the guest, the CoCo systems mitigate such
> > > > 	attacks by adding security features like guest data confidentiality and
> > > > 	integrity protection.
> > > > 
> > > > 
> > > > now, when we are talking about "mitigation" it is indeed becoming a bit
> > > > murky.
> > > > 
> > > > 
> > > > For me, a rule of thumb I came up with is that if the validation happens
> > > > to also be helful for users e.g. to work around buggy devices,
> > > > or maybe because we feel failing gracefully is nice because this
> > > > will allow to later make use of this config and old drivers will
> > > > fail but at least not panic, then it is good to include.
> > > 
> > > Why not do what USB does?  Don't trust the device until AFTER probe()
> > > succeeds?  All of the needed checking should happen before then, as that
> > > is a "slow path" so lots of validation and the like can happen at that
> > > point.
> > > 
> > > After that, during the normal data paths, after the driver is bound,
> > > trust it all you want as attempting to validate every single packet is
> > > just going to be impossible.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > People do expect that data path validation at this point.
> 
> Ok, so you want this patch :)
> 
> And more, as you need to treat everything from the host as "untrusted",
> and it must be "verified".

Well. First it's not me) Second it's only specific configurations -
for example there's no short term plan to validate filesystem code, people
are expected to rely on encryption. The reasons have more to do
with the available manpower than anything else.



>  Much like the proposed Rust patches we keep
> slowly working on, which would make this much more obvious as to exactly
> what needs to be verified, and where it happens.
> 
> thanks,
> 
> greg k-h

Or much like networking, except it's an old robust codebase.

-- 
MST

