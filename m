Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44154207A2C
	for <virtualization@lists.linux.dev>; Wed,  6 Nov 2024 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916718; cv=none; b=bZ4qXEpRC5aw8X/YZY+iGMyoKCNCPzgYPMfQmFS0GNBvF/gN/cYMi2cp60Cre5y/uuDYnIGCIOowalxVYZKFCYvJ3ezTMhIj6j0DKqqJfRMDaRYrCFiwPGhdjpnC2k22owWojt0Kcgramc5dSAFwHH8ryxo4qoqaXprpmjiImJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916718; c=relaxed/simple;
	bh=yvjQ/QwuhwWPsHSqO7QwJhd1N8vOUQjWHlUwUQg4CVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EYQBBO0lfZ1QmY3HrsadAEl1EON2l4S55Hw9CaMOBzcgglFVAUtJk9RefWt/L1UDwX9Zm6NEzf7PLtW5JfpnxvHpskO3LAMbYWpIkNrG+lFrf01+yRXpNHlEkWDB+PA9Fi8Dl/UO/hnt8X/eTphqRIA5tY+bPsWo2bJ2hWsSt+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajl2tVKa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajl2tVKa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730916715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7akKK1ASuchRhU3ArIUdcukaaD4eINOXBlBkGEKg9U=;
	b=ajl2tVKaCJS1cQie/su4D3LlyYe96wU7dltJ3NGoPdKdEGi+WGxJw93zhHAWaCktiwRP9T
	c+/F0jGMv8aM9kzKbB7s3r3JRHHdpYEQal9K8jPkV9LL9NRC67igoV8vyhafVJ8boFQz2g
	qQdYMyIFtfDl2DseESw8HxrqzJIT+EE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-_vyjvX19O0GKRMMLWe5mlw-1; Wed, 06 Nov 2024 13:11:54 -0500
X-MC-Unique: _vyjvX19O0GKRMMLWe5mlw-1
X-Mimecast-MFC-AGG-ID: _vyjvX19O0GKRMMLWe5mlw
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539eeb63cc3so4716153e87.2
        for <virtualization@lists.linux.dev>; Wed, 06 Nov 2024 10:11:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730916712; x=1731521512;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7akKK1ASuchRhU3ArIUdcukaaD4eINOXBlBkGEKg9U=;
        b=UFM51oEgHU37XkFOHfNIESyycS3P0F4fOon/Kf2SRbJ4hkEU97YfTrmxRLSFOCPl7a
         +efakTkvzJXf8Ru3e1qaa0ls7q3EBk9QUe5w8LwM2jsRVH5HYfNj95zFZGarPgRydyn9
         6XYrZ74ovwNXgiFZyg7m1mxzTChFEvpDEr+F3kN1uLVcaf8K/7/jYCb7+dtLeIqfY4rf
         EkZKERx+ievfNojGlgN5UR1KtSjP8z+zgdqw9DuIlIEhf7bKeabjZsCgr2c0LQCNFi4N
         7XG6u6oQoe1tAkWTjAnOZpFsSWS3o/30YT65zf/AoYlRTikTa+iBtkofHbuB0IKy+axW
         MXwg==
X-Forwarded-Encrypted: i=1; AJvYcCXWMFQG64nppru6ZzN6mJomR0ke3nh0UF0eZKWUU/dSF0Tm/CKkOCTm9Ymb8FM3M3sC9+H7m4z5Krk+ULpy3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywk4CB8iFNxYBl/YlpPjjOrtlT4iPfzLOdkc7wRbm+vr/XboILY
	R9VExRPE6th3T+d0nVuqr/OUr3ERvEgBtSQ02PSr1QKidgqm1SPzmhvRnm9+7nIZtweSit8E5jK
	2X38PGzEDUGhDqKfmzyKgDpYDT/rcIQcTkfRfbIjjJYOYGyvDXEHNHKInSnHXsIPI
X-Received: by 2002:a05:6512:3195:b0:53a:1a81:f006 with SMTP id 2adb3069b0e04-53b7ecf3f38mr15111909e87.31.1730916712391;
        Wed, 06 Nov 2024 10:11:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmew/gCD5Q2KsewNL/Sf4xnRDh+daCiEmYAl/vHROruwsHL9IQF+rqviyy7n0pjiNi0YbGmA==
X-Received: by 2002:a05:6512:3195:b0:53a:1a81:f006 with SMTP id 2adb3069b0e04-53b7ecf3f38mr15111891e87.31.1730916711812;
        Wed, 06 Nov 2024 10:11:51 -0800 (PST)
Received: from redhat.com ([2a02:14f:179:39a6:9751:f8aa:307a:2952])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5b7fsm32223565e9.4.2024.11.06.10.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:11:51 -0800 (PST)
Date: Wed, 6 Nov 2024 13:11:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [EXTERNAL] Re: [PATCH v2 0/2] vhost-vdpa: Add support for
 NO-IOMMU mode
Message-ID: <20241106131108-mutt-send-email-mst@kernel.org>
References: <Zvu3HktM4imgHpUw@infradead.org>
 <DS0PR18MB5368BC2C0778D769C4CAC835A0442@DS0PR18MB5368.namprd18.prod.outlook.com>
 <Zw3mC3Ej7m0KyZVv@infradead.org>
 <20241016134127-mutt-send-email-mst@kernel.org>
 <ZxCrqPPbidzZb6w1@infradead.org>
 <20241019201059-mutt-send-email-mst@kernel.org>
 <ZxieizC7zeS7zyrd@infradead.org>
 <20241023041739-mutt-send-email-mst@kernel.org>
 <ZxoN57kleWecXejY@infradead.org>
 <DS0PR18MB5368B1BCC3CFAE5D7E4EB627A0532@DS0PR18MB5368.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <DS0PR18MB5368B1BCC3CFAE5D7E4EB627A0532@DS0PR18MB5368.namprd18.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PMkf1-LU_zr2wdHIIw8Y3-XQvU3KYKFXiITFE0gFNFk_1730916713
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Nov 06, 2024 at 12:38:02PM +0000, Srujana Challa wrote:
> > Subject: Re: [EXTERNAL] Re: [PATCH v2 0/2] vhost-vdpa: Add support for NO-
> > IOMMU mode
> > 
> > On Wed, Oct 23, 2024 at 04: 19: 02AM -0400, Michael S. Tsirkin wrote: > On
> > Tue, Oct 22, 2024 at 11: 58: 19PM -0700, Christoph Hellwig wrote: > > On Sat,
> > Oct 19, 2024 at 08: 16: 44PM -0400, Michael S. Tsirkin wrote: > > > Because
> > 
> > On Wed, Oct 23, 2024 at 04:19:02AM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Oct 22, 2024 at 11:58:19PM -0700, Christoph Hellwig wrote:
> > > > On Sat, Oct 19, 2024 at 08:16:44PM -0400, Michael S. Tsirkin wrote:
> > > > > Because people want to move from some vendor specific solution
> > > > > with vfio to a standard vdpa compatible one with vdpa.
> > > >
> > > > So now you have a want for new use cases and you turn that into a
> > > > must for supporting completely insecure and dangerous crap.
> > >
> > > Nope.
> > >
> > > kernel is tainted -> unsupported
> > >
> > > whoever supports tainted kernels is already in dangerous waters.
> > 
> > That's not a carte blanche for doing whatever crazy stuff you want.
> > 
> > And if you don't trust me I'll add Greg who has a very clear opinion on
> > IOMMU-bypassing user I/O hooks in the style of the uio driver as well I think
> > :)
> 
> It is going in circles, let me give the summary,
> Issue: We need to address the lack of no-IOMMU support in the vhost vDPA driver for better performance.
> Measured Performance: On the machine "13th Gen Intel(R) Core(TM) i9-13900K, 32 Cores", we observed
> a performance improvement of 70 - 80% with intel_iommu=off when we run high-throughput network
> packet processing.
> Rationale for Fix: High-end machines which gives better performance with IOMMU are very expensive,
> and certain use cases, such as embedded environment and trusted applications, do not require
> the security features provided by IOMMU.
> Initial Approach: We initially considered a driver-based solution, specifically integrating no-IOMMU
> support into Marvell’s octep-vdpa driver.
> Initial Community Feedback: The community suggested adopting a VFIO-like scheme to make the solution
> more generic and widely applicable.
> Decision Point: Should we pursue a generic approach for no-IOMMU support in the vhost vDPA driver,
> or should we implement a driver-specific solution?
> 
> Thanks,
> Srujana.

This point does not matter for Christoph.

-- 
MST

