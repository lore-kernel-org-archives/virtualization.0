Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45CC213E79
	for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419276; cv=none; b=rXD5zw2SViel1fY4H5B3JPxXHKv1cOWQ+1ErYbCODZEXC9V2QuyhQAi9297bs7cdq+Ci0cPOfBDx5siPSkFmR3YgkWDkCA4PD+7YDuZuhQzOCwX7TeX9jtLrIjpktCHMuKDkw/mw0KnO6pDghfBnM9jRIXmdbdZh2l8bVtNRmAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419276; c=relaxed/simple;
	bh=HMbgGCsuKeJaEf/xCUb+Bjd7Q9sYLjr0dcO6CXChWvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lwVMK7jPDXBbPYh12SH54a8GF9JFS9C7uvukiPFEFrlVlmh00n4nT03MDyU/aJrPhXXs4mEidSNayBZG5dSXDs4kAcRb1Tz/Ynk8r4xFZynbThzM2s9OdLSmXilL8IOYpmdO1es1FvXoPk/YukMmMYkwxd2+TdPNC6RqhzxGitI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHskQM3x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHskQM3x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742419273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2hxaIYTY0GjVflh8gcVmWThYCrbWSu8r9v+XAR6H2E=;
	b=KHskQM3x7vgjsxsJOuFkW5WWLi4AW3w4ccbApPTazsTvzabtHglwH+wmGqXHaISQYrBcPa
	6pKrjZoJxAa6Tb6Yl0gOSxjxlisgFfSvOzmXW9oChUItE+yLJEmVulrcFDqObT+A4vu17+
	T45SC0X/Yr2C7y7qIsUjI/Vi+oqiDAs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-_R16bKdUPYq898uW6z8U8g-1; Wed, 19 Mar 2025 17:21:11 -0400
X-MC-Unique: _R16bKdUPYq898uW6z8U8g-1
X-Mimecast-MFC-AGG-ID: _R16bKdUPYq898uW6z8U8g_1742419270
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d3b211d0eso6727235e9.1
        for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 14:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742419270; x=1743024070;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2hxaIYTY0GjVflh8gcVmWThYCrbWSu8r9v+XAR6H2E=;
        b=XiiDIRkuX68lnccw2xnunYXodYzR+5jvBcTD3XFjWm94KPd4EpUtoQVQtRHp0piaPH
         KbaeflWVv/cyZZ3YUCQiMetIu/OJZbTAiDSt/JtolyOrp1sfwztyGnnkvtWg8S3UPOs8
         ARXt55dIDKLh2eUB0H38W6zcIyNQDlowRt2H+TsXR1bu1tkrnypBoqo7/PKi/MBLwz3T
         vxVMs8yRrVLenh9wkRedR+hgGMO9nhgSMTHFAVNBpSfedJoPQ9UTkErSi8UdiMB+Hg/W
         pwjnqK9KkLXDPzy7LCjyjJOgBo9DvFdwc2R+akS1A1SdmMATG035mQcV/KIxbV8ZbnHs
         P+wA==
X-Forwarded-Encrypted: i=1; AJvYcCW7cuySDUuJveInAYULoJnMD7llwD+rpE7fsacw6sxX0V8AruaqmaPjZ0nLGxBp5hHRf9ErG1udWoj2w36Dkw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeOApIyPA12cjrmUcz5eCWOSN7D5LBu7crg8aCC6jJ9vmOX/yh
	RBtbvujI3jF+TYmIHw1knLk4iOcZwbeYLGcLOSmaz9XwMWTHRcvWdn52weeMRCFaTWqgBuHzDb4
	RYpFM3D4Eaq/fl8Qa1YD5lJ88bPnCUea9vOCj7QMOSKKkWrfIEv/9gHwrLgFLGnNl
X-Gm-Gg: ASbGncsKo3y5B5Sj1uf/OerIvMpY+f1eFzHiDECukBHDMg6W3oG7U8Wbp77dIAlLM29
	uIQE+S4DIsKYFy3/vIXKF8jRjp9qD4Ims4f29HlWYD2LejffAQ9ltaXh1OWVvX65u8yeVzlccZU
	1UKs/SoUnv+WLI6leF8GjhQHGpYOmauRF5pP32asFcFZdpls+TrFsgYzE8wOjqqmuokkjcl1//3
	ooMcSo1hSi6ZtQ5dQus1D2+pZNFG30wNPAoNTxNa13wg5qkXJKf6/FYRqdFBbL5nLSuogRauDOI
	CYdc4hjDSA==
X-Received: by 2002:a05:6000:18a6:b0:390:e9ee:f27a with SMTP id ffacd0b85a97d-39979584450mr995073f8f.28.1742419270415;
        Wed, 19 Mar 2025 14:21:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExhzW9zZnUN2tPz7Fqf6gRe+qwJOMLcgOp2MJcenPvh8K6lyAKT8Ns0f1qp/bUHCnlP61Hng==
X-Received: by 2002:a05:6000:18a6:b0:390:e9ee:f27a with SMTP id ffacd0b85a97d-39979584450mr995050f8f.28.1742419269928;
        Wed, 19 Mar 2025 14:21:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebe3csm22319800f8f.99.2025.03.19.14.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:21:09 -0700 (PDT)
Date: Wed, 19 Mar 2025 17:21:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
	Amit Shah <amit@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, arnd@arndb.de,
	gregkh@linuxfoundation.org, brueckner@linux.ibm.com,
	schnelle@linux.ibm.com
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio spec
Message-ID: <20250319172004-mutt-send-email-mst@kernel.org>
References: <20250225092135.1200551-1-maxbr@linux.ibm.com>
 <f5ab160dadc2219b9576e50588dce88f22e9bcb1.camel@kernel.org>
 <649563cf1b8abd42401ed78d84bfd576d48bdbb8.camel@linux.ibm.com>
 <f27debf87882df65574f21cfced31fecf1dd1da3.camel@kernel.org>
 <dc3ff60fd16e5b5f94c12cf6a5a7893b94f705a8.camel@linux.ibm.com>
 <20250319105852-mutt-send-email-mst@kernel.org>
 <20250319181308.365ee0ea.pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250319181308.365ee0ea.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f4mkRd5D5Xbww-PxM41JVZm7BzfXB5FSkgzk8X_CZeM_1742419270
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Mar 19, 2025 at 06:13:08PM +0100, Halil Pasic wrote:
> On Wed, 19 Mar 2025 11:00:06 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > > I was mistaken in my earlier reply - I had missed this
> > > > virtio_console_resize definition in the spec.  So indeed there's a
> > > > discrepancy in Linux kernel and the spec's ordering for the control
> > > > message.
> > > > 
> > > > OK, that needs fixing someplace.  Perhaps in the kernel (like your
> > > > orig. patch), but with an accurate commit message.  
> > > 
> > > So should I send a patch v2 or should the spec be changed instead? Or
> > > would you like to first await the opinion of the spec maintainers?
> > > 
> > > The mail I initially sent to the virtio mailing list seems to have
> > > fallen on deaf ears. I now added Michael Tsirkin to this thread so that
> > > things might get going.  
> > 
> > 
> > If we can fix the driver to fit the spec, that's best.
> > We generally try to avoid changing the spec just because
> > drivers are buggy.
> 
> I think the call if fixing the driver is possible needs to be made by
> the maintainers of the driver. Fixing the driver IMHO implies that
> if this is seeing any usage in the wild where it properly works a
> fix on the driver side would imply a function regression. But any
> implementers should have complained. So IMHO it is not unreasonable to
> assume that this is not seeing any usage in the wild.
> 
> And people would still have the opportunity to catch the regression
> during testing and complain about it.
> 
> I agree with Michael, changing the spec because of a buggy
> implementation should rather be the exception than the rule. And AFAIK
> it is not like we have declared something a reference implementation,
> so in that sense the implementation in Linux is just one implementation.
> 
> I suppose making it runtime configurable via module parameter is an
> overkill at this point.
> 
> So based no what we know I'm slightly in favor of let us just fix it
> in Linux and see if anybody complains.
> 
> Another thing I noticed during looking at this. AFAICT Linux does not
> seem to handle endiannes here. And AFAIU the message is supposed to hold
> le16 that is little endian u16! Maximilian, is this in your opinion
> something we need to fix as well? Or am I just missing the conversion?
> 
> Regards,
> Halil

Agreed, still, please do a bit of research on open source hypervisors
at least (rust-vmm?) and include the info which ones you checked.

