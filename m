Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1600422D7B0
	for <virtualization@lists.linux.dev>; Wed,  6 Aug 2025 21:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754515877; cv=none; b=i07FVOJQH+cv91iOcfdiKlkqaZD4yWnVmtb7PtY+a/Enb231weLfQsNyez0r6LGQ+hKgYTaiwuv0tYuyGkfFQEjSkcuKZtMDGHLd0qafGXaYvFn0+sgGa3CwJ436bgI9oV36dBoNob/96z9g89nMGAC5q6W0RRaFbZCo6lDgUM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754515877; c=relaxed/simple;
	bh=SL3DNkvGy6rcQuP9q4xv+WVd9ByB3rzfEVd4866Pia0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3PORVkflIoI2G5BcwfRua3PI5BvBLem1W3ip1N4FmtGzMHuO73EdTju1ORPyZyGP4kze8gtS+69KH5xS1WMqsrPnu76mgcqye9ya5E6krTJpro7hgaHk3f/FCwJfKoLQDpm5Px3fb6ZhTUSdoPXefmzYZB/yUp+s85ciJyyz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjNyUT/H; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjNyUT/H"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bd041c431so397756b3a.2
        for <virtualization@lists.linux.dev>; Wed, 06 Aug 2025 14:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754515875; x=1755120675; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CTYKRqC2i2Nuv0ETOsJWl2NT52kw5MEfkUb+WVewcSg=;
        b=LjNyUT/HDMFdh8idTAKYDxKA4ohSTXPpITKW8g/xIHU0yZCBYXnq9WlpDU7xuxtQbU
         /zbBPVkMCwmLTxgAlmRGdiOHnk27jFEOekA8STX7ifBrOyBvKHIGlqkNU/sE09YSPYgo
         1sXoPx+h4q/yTYeVTYBzsAkGGTJkwu6KPaYE8p2s0TurN+wuBeb6E4ajibX/Ei7OJewf
         MrWp4fBXBcxaBsygH836ZCp1dIYFjsn5R9MH+fnOHpQFQarPYxqDKJBx4U6BOD1jetMV
         p5IcKPmfsvNVo6/WhzulfjF8Q5YavV3MLZ4s2Af1IDPhiprzPvxv7MbvMTxUxbB5kbeG
         YJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754515875; x=1755120675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTYKRqC2i2Nuv0ETOsJWl2NT52kw5MEfkUb+WVewcSg=;
        b=KSSTGxkG48IWGtcdPtSo+M3P4asV5+tlIYfqEvvxQdJSM4EOJICSmzyF/mXVSiIB25
         d5uRtS95xUaaqB5KXXTBpi9HDUnyxcVFrNi3C1t6yebwCEtU3vqEZ8SERN7NW1sK8N5/
         WQFzePg+xxNx6PsiA8RUa7o2MlNHiWuvBTQ1QFAEJDRba8m0Mjv4SOyoKXPaEeWLPb2U
         /iiCJuf3/ExgW4ScKJtRgClOXVPyOyGk0kVJO8GmaFqnjEDusC1d9xFH58kZzunR2IzT
         LXbPGit1xIqsPOUJt6faGcQ8oVHjUKiuwxQCS67Kcb5iILZpdUH9W5g2PzUwEgHta/yq
         zVMg==
X-Forwarded-Encrypted: i=1; AJvYcCUCSlcZpO7dDx4ZseZiCHY/U/tu/CSfut0/Tv6XMZ7R9wfajJMCAj1mmdSNSMDCH+MMZ96EmC6KpkEcFwmlPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHvIU2ccojwQZtgksVWdXezKaCLNM9l7oAq9U3tC/7n/awqEuC
	c3EKmo1rKcqzHQzUKSxEQlzJ5vKFBtmhJiiOBlSnPm4sVjtVuHPIgPMxjH6wZzoJ3IQ=
X-Gm-Gg: ASbGncvtiLcuj/FB6W3m9YJphuUc6pHpDmoUsh+qjbBNEvvsv2Ey/Q5yQpG7Zla6USh
	ZB6DQM+3jWVIT7d8/Aqdp6cdmdMrNERZU70pNu9aiSUxqLll3W6/3Ytv2Ph78/D6nyJhHjY51ZE
	ck0NNmiG1x/FAFf3WY21Rnv9Q2+GDkAUN3JQo1ww1PUC2Gxl+9deqy16Ne+7WkVV5Oob++9R+lR
	APHqpLcngmdbulqH0HAiYYojHYKIQCE7iWHBZlDnMCdVmOw/j2LVhSb/UEFpg2gQ65/AHBxDQtL
	VQhphVr64JCKzPEnNfjJn1uQk2sIxM+kUUWVqfgmiUxNAh8qYkfYzYHCCTjVdMdEilSuTW+64d8
	FUuLxHt6jXcrua3hCK6qld3daX4xnzc8rzMU67BrJc5Cy
X-Google-Smtp-Source: AGHT+IFZpVrG9s5vc20jurJQK7sMSyb7Prr6yRfhujcvSVJBKuiNDMVhVBLsWkgkXXUuyjwA2eVNOg==
X-Received: by 2002:a17:902:e88c:b0:240:3c51:1063 with SMTP id d9443c01a7336-242b19c7519mr7983495ad.23.1754515875138;
        Wed, 06 Aug 2025 14:31:15 -0700 (PDT)
Received: from devvm6216.cco0.facebook.com ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2423783a84bsm134870185ad.51.2025.08.06.14.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 14:31:14 -0700 (PDT)
Date: Wed, 6 Aug 2025 14:31:12 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v4 09/12] vsock/loopback: add netns support
Message-ID: <aJPJoDo/0MS+thcl@devvm6216.cco0.facebook.com>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
 <20250805-vsock-vmtest-v4-9-059ec51ab111@meta.com>
 <20250806191239.GF61519@horms.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806191239.GF61519@horms.kernel.org>

On Wed, Aug 06, 2025 at 08:12:39PM +0100, Simon Horman wrote:
> On Tue, Aug 05, 2025 at 02:49:17PM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 

...

> 
> This change needs to be squashed into
> PATCH 3/12 vsock: add netns to af_vsock core
> 
> To avoid build breakage.
> 
> Likewise with the other change to vsock_loopback_seqpacket_allow below.
> And I think also for a number of other changes made by PATCH 3/12.
> 
> Please make sure that patches don't introduce transient build failures.
> It breaks bisection.

Will do, thanks!

> 
> 
> On the topic of vsock_loopback_seqpacket_allow, also:
> 
> * Please line wrap this so that the code is 80 columns wide or less,
>   as is still preferred for Networking code.
> 
>   Flagged by checkpatch.pl --max-line-length=80
> 
> * Can we move the definition of vsock_loopback_seqpacket_allow() here?
>   The function itself is is trivial. And doing so would avoid a forward
>   declaration.
> 
> >  static bool vsock_loopback_msgzerocopy_allow(void)
> >  {
> >  	return true;
> 
> ...
> 
> > +int vsock_loopback_init_net(struct net *net)
> > +{
> > +	net->vsock.loopback = kmalloc(GFP_KERNEL, sizeof(struct vsock_loopback));
> > +	if (!net->vsock.loopback)
> > +		return -ENOMEM;
> > +
> > +	return vsock_loopback_init_vsock(net->vsock.loopback);
> > +}
> > +
> > +void vsock_loopback_exit_net(struct net *net)
> > +{
> > +	vsock_loopback_deinit_vsock(net->vsock.loopback);
> > +	kfree(net->vsock.loopback);
> > +}
> 
> I think EXPORT_SYMBOL_GPL is needed for both vsock_loopback_exit_net and
> vsock_loopback_init_net for the case where CONFIG_VSOCKETS=m
> 
> Also, in Kconfig VSOCKETS_LOOPBACK depends on VSOCKETS. But this code adds
> a reverse dependency. As it stands it's possible to configure VSOCKETS
> without VSOCKETS_LOOPBACK, which will not compile.
> 
> Perhaps stub implementations of vsock_loopback_init_net and
> vsock_loopback_exit_net should be implemented in af_vsock.h if
> VSOCKETS_LOOPBACK is not enabled?
> 

Roger that, makes sense. Thanks for the review!

Best,
Bobby
