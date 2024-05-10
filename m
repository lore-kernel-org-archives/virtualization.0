Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4694C16DEC7
	for <virtualization@lists.linux.dev>; Fri, 10 May 2024 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340437; cv=none; b=gS8ysgM8PRCSdVu+osqMJcY6+kT44/06jl/1DHNhYXfqccPhjlsX0sCLulhzlySob4qcYYCbL/RKqcgpP8ngJY62Je+bTdgekQjGrJW+V6O9Qo6d6rjQaq1YeO4mg1daxvKekeYQrdGZtgHxPMMTEREkDmFIlhJ708XbKwXDid0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340437; c=relaxed/simple;
	bh=1vXN8gl5a8r7UTd15EVbj4/rjwNmtYjpmhhKkt/OoWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UkBHKP+aB0Qh5o63ex01uudzKcUzVORkn2Tr80KpFT42JTl1u9bDHrfvD0KEbU46GJQ64a/olk0aIukU12hpl/UWgQshl9VWO8YoDxyuVnn5oCZPakqoOKdf2XokCR3GCUnFkgbhrxznmIfNwXGtP5ALaoLIB7RFQRbSwDpWE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IoHUtBkl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoHUtBkl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715340435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zL54WMHpUJTHp7vtEEd6YRmkxZQS7WvPD7WIyFt9Pfw=;
	b=IoHUtBklKhX3f9Gkve3kE49DqEr9Zhrvx/vuaawMqO5JRycskGYc7kkjT37CKaH1ws2ou2
	hMaTswwfOe9vJsG6lysKz6GwhFcUcPoVpiXDpAlvxcVyvCtcsi056jA3y21CR1J+lF6bxK
	7FKzCZ98yJlcRYm57NquMBdPoigoC/I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-IKY7NiniOsCm0OKgun5VCg-1; Fri, 10 May 2024 07:27:13 -0400
X-MC-Unique: IKY7NiniOsCm0OKgun5VCg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34dc6410028so1068602f8f.0
        for <virtualization@lists.linux.dev>; Fri, 10 May 2024 04:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715340432; x=1715945232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zL54WMHpUJTHp7vtEEd6YRmkxZQS7WvPD7WIyFt9Pfw=;
        b=v7mz07eLSoIt+VIRAX5iVS9B49TZuRxo3BlqYjNsVorCO1iId/dTEPy5G1PAV0iRzR
         m8FtjXIa9vbkyKbe+RXOE4mi218Zg1iajM2eA4cRWQXeCJ5e9giarBaVD0SSNgdVHBxu
         auzhlso/ehzKnIkr/vEGLIRCt80wjRqLO7LYm50ksHcoTvr4HPJohxlCbWmV3ZxFSP62
         3vMYoFGiEMsMewlyojVpchsga9tEExb7RAuarPRHFNYXoWv9LDAIiTw/+EUl0YGHsVOc
         4I8xssFZXPFHfF8LKmxoiBPFbXMXNfQ+VWTgL+OKwfWcY0iUHtWYtRwRonZIXS4nQtLo
         9A0A==
X-Forwarded-Encrypted: i=1; AJvYcCXUSpOf7kNAPz6xreV4B8ldlMqWrAGq1eQrFCCjyXO4FCbvIwnLSuSrsjNrPmodDh7YaubUdDJKDzlDy8FqSeilbF48FklcIWgbEz3/WrM=
X-Gm-Message-State: AOJu0YyVdAcemkFiLwLWWeeUbhwCVPCr39PEBiYmVLjWvrctEUo+EHe9
	ZUKEmn5RkwFb0Ltn6aFbVIgzb6uq+9l8Df/YLKHx7l34BKw6eubgzdOPiQ3nvjNyoHIeDdzQjKe
	DfKJBl6ZYr8dYQSHEoDhGu/bsEgiXP0XKvSgXVYwg3aor7asBRIsoc/iaskPdOrN9
X-Received: by 2002:a05:6000:1744:b0:351:4e42:c5ff with SMTP id ffacd0b85a97d-3514e42c78cmr702959f8f.51.1715340432493;
        Fri, 10 May 2024 04:27:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHapTqABhwzPCaap/HscARYrgTo7yeZ2giVs7KaAR0eDvOvYnpDDqNhFeiXWiRr9KgbHb8FvQ==
X-Received: by 2002:a05:6000:1744:b0:351:4e42:c5ff with SMTP id ffacd0b85a97d-3514e42c78cmr702919f8f.51.1715340431880;
        Fri, 10 May 2024 04:27:11 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7408:4800:68b:bbd9:73c8:fb50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbc082sm4332589f8f.107.2024.05.10.04.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:27:11 -0700 (PDT)
Date: Fri, 10 May 2024 07:27:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240510072431-mutt-send-email-mst@kernel.org>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
 <20240509102643-mutt-send-email-mst@kernel.org>
 <Zj3425_gSqHByw-R@nanopsycho.orion>
 <20240510065121-mutt-send-email-mst@kernel.org>
 <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 10, 2024 at 01:11:49PM +0200, Jiri Pirko wrote:
> Fri, May 10, 2024 at 12:52:52PM CEST, mst@redhat.com wrote:
> >On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
> >> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
> >> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
> >> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
> >> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >> >> >> 
> >> >> >> Add support for Byte Queue Limits (BQL).
> >> >> >> 
> >> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> >> >
> >> >> >Can we get more detail on the benefits you observe etc?
> >> >> >Thanks!
> >> >> 
> >> >> More info about the BQL in general is here:
> >> >> https://lwn.net/Articles/469652/
> >> >
> >> >I know about BQL in general. We discussed BQL for virtio in the past
> >> >mostly I got the feedback from net core maintainers that it likely won't
> >> >benefit virtio.
> >> 
> >> Do you have some link to that, or is it this thread:
> >> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
> >
> >
> >A quick search on lore turned up this, for example:
> >https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com/
> 
> Says:
> "Note that NIC with many TX queues make BQL almost useless, only adding extra
>  overhead."
> 
> But virtio can have one tx queue, I guess that could be quite common
> configuration in lot of deployments.

Not sure we should worry about performance for these though.
What I am saying is this should come with some benchmarking
results.


> 
> >
> >
> >
> >
> >> I don't see why virtio should be any different from other
> >> drivers/devices that benefit from bql. HOL blocking is the same here are
> >> everywhere.
> >> 
> >> >
> >> >So I'm asking, what kind of benefit do you observe?
> >> 
> >> I don't have measurements at hand, will attach them to v2.
> >> 
> >> Thanks!
> >> 
> >> >
> >> >-- 
> >> >MST
> >> >
> >

