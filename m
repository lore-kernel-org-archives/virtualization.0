Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C663290B9
	for <virtualization@lists.linux.dev>; Wed,  5 Aug 2026 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913176; cv=none; b=BeauARD0lOVqH4nzifaoqNgy2eGpLdH1yMRrSLJVmgRNC4Ob/d+3qqZoX2FcvJpj7bmB41Oh4eEquBL3DYgkNWf5BfxUHfszTdztPSJPgnZu2iNWFl3D5lnudukMjJUJGrTFcfUU9lpSE8LqiRxkULnGrwyMrziqHC2/h2cn/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913176; c=relaxed/simple;
	bh=TgALdl+iEj9JSliTz8VrDMLm1WU+EhCs6+N4E75pEjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FRksrp524/CNLegqmdnfuKvx6HQOgKqrhDCwX2jFN/QtB+oJKbycH7ba2guABK7expJHtufrc9lA4wNTnnWKgoLlHpWhSDhyouNPT7hERRNBr6OChmAWLiIYwZ6KauPqwAqPOIn0LCzBjbzlfqQiJmvVorHe8HPseYunRmzvBOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ElQ4oo5R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ElQ4oo5R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785913173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lEhxxpwyE/rpJMtoGJj64x34mE0/II12LvK1GhW6WUk=;
	b=ElQ4oo5RDE8UEsQJ8JFJKuQzUxNDJj0TgygIldFi/r+nrIxOSVRN9746Zdi0jHPy4spdKR
	vKsm968DFMfqsb1a3M5mWGEUbBtTvJXOC1XxjXdTRDXpIYtbDG1HdqI2grs9zADQ9F9cfk
	H2dA4quWjGx20RFmNYMmMqwZPOiDrFw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-XdN9WUUUNj-T_0-WGAZ77g-1; Wed, 05 Aug 2026 02:59:32 -0400
X-MC-Unique: XdN9WUUUNj-T_0-WGAZ77g-1
X-Mimecast-MFC-AGG-ID: XdN9WUUUNj-T_0-WGAZ77g_1785913171
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f8398ed9fso491461f8f.0
        for <virtualization@lists.linux.dev>; Tue, 04 Aug 2026 23:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785913171; x=1786517971;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lEhxxpwyE/rpJMtoGJj64x34mE0/II12LvK1GhW6WUk=;
        b=hEPbLNfNHUFOn4Psna7RhsoHt84Yxs6LI7/ABMfLd2HbXTKrbKxniCtZmk0bNEOL4E
         sC4YXI5fy91b+7c039j0Ymi97JkdI3ap7kIHzWAMThyyHnEZ1RxsSGLHoRitoU+cCtPH
         drMI1yornzyZoy8R6URc3YXo/n8dfb24MAldAUPH2PZNck1juHHINxyx9i4+9TN0dnrc
         mz/ZoD+KRZcf5NAD3fDKjCTsSmKhDLFqW0s+OtAnDlNIT13X/LjqvWP8CDNs+kdJXYT1
         c/p2SGNMio4BTb8Pset7fXkNTIiJobkEcAO98iU34Bob4eMJlcPXNgZuyV+lp2ZoJUAg
         Io6w==
X-Gm-Message-State: AOJu0YwLUrh9Crygnm2ZlXHNmfttX4huOOcF5eBFq7R5LaoQv8Jp1VBO
	XFDRujEL+VLiXi64ep2+2fLCcuRMmqba1uciBfTjqSZn8WaSOxUj+A7cMn1mCdl7agKtPj3S/zu
	2nrk5MgEkclIi9miYj1KAl8BOTVLrVENDuwlilyZMQy2AVeRJEDMcscK4Ar3y1aDcLDht
X-Gm-Gg: AR+sD11Ev4semfOT7d98ZYa9lzKMuLK4b/O1nhBPAvlL/tbn+hjl5T1ohEubgEG6A29
	y0FzhuFCzeg4fyhvpRcLV1f7MN1QU7d48kw1oTkHiKoWu8P9I46KLMrznT5UQFXzKIEuskVWbPY
	UfH9K+TnK1Zh8v9rYwWMuv36N4AChSA3wiJRkp0zGKm6A6TzjtXcKl2qkDiOmIY0YuYniyyaoTE
	wLJNe0jtMUnWG+J3gwjNYTzWXCOLiGxsV8UX04gjau1GOeaHr08L54IpnGBLDqJV7LHqcQQ7HnX
	55yNwtmM5ZbqhDyXzsVjP66Y04xiW2vscLy7rfq8vmAIky+MozzXfUIz4IeEikPr8hL7hRgNqQu
	KOZsnY5zi2k4cGiBm24U1Sg==
X-Received: by 2002:a05:6000:4211:b0:47f:96e3:5309 with SMTP id ffacd0b85a97d-47fec50d87amr7251149f8f.9.1785913171412;
        Tue, 04 Aug 2026 23:59:31 -0700 (PDT)
X-Received: by 2002:a05:6000:4211:b0:47f:96e3:5309 with SMTP id ffacd0b85a97d-47fec50d87amr7251098f8f.9.1785913171014;
        Tue, 04 Aug 2026 23:59:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febfe5d7csm6573640f8f.15.2026.08.04.23.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 23:59:30 -0700 (PDT)
Date: Wed, 5 Aug 2026 02:59:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiong Weimin <xiongweimin@kylinos.cn>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jason Wang <jasowangio@gmail.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] virtio_pci: do not mutate caller irq_affinity.pre_vectors
Message-ID: <20260805025834-mutt-send-email-mst@kernel.org>
References: <20260805032934.1606700-1-xiongweimin@kylinos.cn>
 <20260805013203-mutt-send-email-mst@kernel.org>
 <178591242683.1657366.2004019380773321385@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <178591242683.1657366.2004019380773321385@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RlSnJ_zwq0WJSdzbdcHvGRZEFxrDByiW_G1rrUuWSdE_1785913171
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 05, 2026 at 02:47:06PM +0800, Xiong Weimin wrote:
> On Wed, Aug 05, 2026 at 01:37:01AM -0400, Michael S. Tsirkin wrote:
> > "tmp" in what sense? if we can come up with a sensible name, just
> > "affinity" will do.
> >
> > We do not need a comment arguing with previous version of the code.
> >
> > just assign to desc, instead?
> 
> Thanks, will do. I will post a fresh [PATCH v2] as a new standalone
> mail (not threaded under this one) with:
> - a local "affinity" copy
> - that comment dropped
> - desc = &affinity, and keep passing desc
> 
> On the virtio_input thread you also asked whether this is real or
> theoretical for stable. For this virtio_pci patch: real when the caller
> passes irq_affinity and MSI-X policy falls back.
> 
> vp_find_vqs() retries EACH -> SHARED_SLOW -> SHARED. A failed
> vp_request_msix_vectors() currently does desc->pre_vectors++ in place,
> so a later successful attempt sees a polluted pre_vectors and gets the
> wrong affinity layout. That fallback path is unconditional in the
> driver.
> 
> I have not collected a userspace failure log yet. Please let me know if
> you still want Cc: stable on the v2.
> 
> Thanks,
> Xiong

do not cc stable on theoretical issue.

there is a bit of a language issue.

if the issue is real describe it:

"this was observed: ... "

if theoretical say so

-- 
MST

