Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3B61D95A9
	for <virtualization@lists.linux.dev>; Wed,  6 Nov 2024 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884075; cv=none; b=MxQA+liXGxoRnAmY80vRdtt0yJTTjjUdNlwIgzt+YaPre9xmGuV72FRU7uBJCJEBfUTyXd71mK5QQW9HE0rWk2G7QHSZTEegoxPGUcCeibUTR9yl/ETSh0zGyEftmkwccWKL13zlboNc9x/T8aO/cw/p+3xsGCEQv3eEca50DvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884075; c=relaxed/simple;
	bh=iRDvP6Fds9e6sAJFt7TFL1RE85f61k0qNzCwm6EI0ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XpqpgKD/kGERgxRMstZlJY/QA9coB1n1mD+STv9p0+0YcOh9n8C9MIqrXH3CUO/ToUEJFptyD1ATaGuxWdDnzmXXI5Si4yqSTNydjPrm2oapw5/9hGX8oUgq8n3SvwH4DC5G7lzOzLpP9NXBygboQQ9sDh9tLdDS52on/gAV8v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CL3maVck; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CL3maVck"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730884073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=stsh36U7LL9w1fGvl92BzQf3qg6o4uyL96zdePlIQ+M=;
	b=CL3maVckSf1xgnX6jk3OjnzCSnANFFaUFaE8hiAwPIwv62wW7pyrN9r52U7hnhI3X5wu0j
	dzaif0s6u7tVLCj+qXanP6jbyBAIelzOqhLpwMAX4DKTYuzEQ5o5ukCgveQex8UV2Svd+l
	+1HE4/4TH31rpzc7BduCABxmbc608S8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-HIWh2SVCPzOK2KbXR1gAmw-1; Wed, 06 Nov 2024 04:07:50 -0500
X-MC-Unique: HIWh2SVCPzOK2KbXR1gAmw-1
X-Mimecast-MFC-AGG-ID: HIWh2SVCPzOK2KbXR1gAmw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315ad4938fso40870395e9.0
        for <virtualization@lists.linux.dev>; Wed, 06 Nov 2024 01:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730884069; x=1731488869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stsh36U7LL9w1fGvl92BzQf3qg6o4uyL96zdePlIQ+M=;
        b=XD67IT27SpIhrzY1LQNXJ2w7rOHGznAnCoalNt2RzDK0tlL0H1VaRf0GbhQ6cR7Fbd
         j6MeRHcyZNgSmcWU6k2nXUgaMci4UQU381NrhNW/KdU8EhHi6GDen3ARA0OtUoca6qTq
         AGAMG7ctOQtWJZeMgUMPgKPiSOv9/g97EVKvDJ/w6FBiJZDklL0p+CPpcdvveH1RpOqS
         JCujAPscUVCFdQla73BmWETlUaS3L/BdiTNngMOixm2VtD8mBzfJis3Ddi1w6LtcZZrg
         9kiC+7t7BMag+CUlBmkSvFQPOFqsnVl+lgoQD6JHltWOLdHxYLBLKI5upABYX1Zd9Lpn
         wT7A==
X-Forwarded-Encrypted: i=1; AJvYcCWB+il4XLVopu4sRpMOiyrO/9QHNYHogLkP1q7HBWxLE3YlimJvVGxF2cpKySBmPjnS4H0mN4QzfsV/fK+o8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwU5/A2qjV823aFWUaHcFM/wfxRkbUKtulZ06dy2iLa94UuDncJ
	PxallFTyJA7e3Wi06Vifcit7WQIzO2JnqP/y6rwrU9SNPgYdUPTdG6K1jzO4c8GlVVS7Mu8WDqe
	qEk8JTLOJo3XN0I80dLKKo9dFTVMrZkWOSBEtp+MYjF6eIojFzdFe/txdqlUehTDS
X-Received: by 2002:a5d:6902:0:b0:37d:4ebe:164f with SMTP id ffacd0b85a97d-38061200d23mr24637616f8f.46.1730884068794;
        Wed, 06 Nov 2024 01:07:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4QdCH0opectVmr8dgwxLSrIB+qc8WNu2CPVa8NB18xSiYf7L6K01+/errC2pGSWF3kucn/A==
X-Received: by 2002:a5d:6902:0:b0:37d:4ebe:164f with SMTP id ffacd0b85a97d-38061200d23mr24637597f8f.46.1730884068451;
        Wed, 06 Nov 2024 01:07:48 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7e1bsm18681481f8f.1.2024.11.06.01.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:07:47 -0800 (PST)
Date: Wed, 6 Nov 2024 04:07:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Stefano Garzarella <sgarzare@redhat.com>, stefanha@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	mcgrof@kernel.org
Subject: Re: [PATCH v2] vhost/vsock: specify module version
Message-ID: <20241106040705-mutt-send-email-mst@kernel.org>
References: <20240929182103.21882-1-aleksandr.mikhalitsyn@canonical.com>
 <w3fc6fwdwaakygtoktjzavm4vsqq2ks3lnznyfcouesuu7cqog@uiq3y4gjj5m3>
 <CAEivzxe6MJWMPCYy1TEkp9fsvVMuoUu-k5XOt+hWg4rKR57qTw@mail.gmail.com>
 <ib52jo3gqsdmr23lpmsipytbxhecwvmjbjlgiw5ygwlbwletlu@rvuyibtxezwl>
 <CAEivzxdP+7q9vDk-0V8tPuCo1mFw92jVx0u3B8jkyYKv8sLcdA@mail.gmail.com>
 <20241002071602.793d3e2d@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241002071602.793d3e2d@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _oiT0IWlDviPgWKLb9fvvkQDpSsrfdPZWLXy2-rnGYM_1730884069
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 02, 2024 at 07:16:02AM -0700, Jakub Kicinski wrote:
> On Mon, 30 Sep 2024 19:03:52 +0200 Aleksandr Mikhalitsyn wrote:
> > > At this point my question is, should we solve the problem higher and
> > > show all the modules in /sys/modules, either way?  
> > 
> > Probably, yes. We can ask Luis Chamberlain's opinion on this one.
> > 
> > +cc Luis Chamberlain <mcgrof@kernel.org>
> > 
> > >
> > > Your use case makes sense to me, so that we could try something like
> > > that, but obviously it requires more work I think.  
> > 
> > I personally am pretty happy to do more work on the generic side if
> > it's really valuable
> > for other use cases and folks support the idea.
> 
> IMHO a generic solution would be much better. I can't help but feel
> like exposing an arbitrary version to get the module to show up in 
> sysfs is a hack.
> 
> IIUC the list of built in modules is available in
> /lib/modules/*/modules.builtin, the user space can't read that?


So what are we doing about this? Aleksandr?

-- 
MST

