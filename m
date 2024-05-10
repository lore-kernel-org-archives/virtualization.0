Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087F016C43B
	for <virtualization@lists.linux.dev>; Fri, 10 May 2024 10:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715338381; cv=none; b=f+0kvW0RsF0aH48rZ2tapfdBoV4BkxPcYD9Y3Gbq22TpmUtvMR0fDylcFDM/IP/o4H1QbHeYKokfwerN1N2wP/YMDk6lini8v86CsAI9DQ9XAiusSK56DWZrw/73uiFTKyAX3SJGul99lDZ0W+CAb4usohIsKs/RlOkqxZmNr9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715338381; c=relaxed/simple;
	bh=ocV1iitruywNeS3LsDx+ECd6GmmCgzJALrmUamG6X/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tGhhny6xVQHPiDv9EwMOFZG90tYEAIJYfMvaeKb+HMe8BTF8vSuA35Ol9KQLEDBxu+PhSo9dBsDgOg/7u977znOzuCE6MAXH6NO6klkMhNg2pZzoPxGeJrJ+NT+tZ6ytPiwTYssB2TMjQ5julCJl5Y9ncdgdOdiKvwzU3pL9KOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GbbtysMj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbbtysMj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715338379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=87j9es5GKBqYf1Oh12DDQjpVqARqFQ5m4FHRLb5iAAw=;
	b=GbbtysMjS+TQrITABEY+9Gqo0iAO4srrhlAd0IVTB62eoEgDB+uaqIaRSqHELEO0DuRCxk
	ANy13wHI0o/nL/v+2jygSLK0S5h5qj3Xpg2rZYftpRFWz59etvIrb2QyhRu02GLxTPTQBi
	kfDlkXUKmoWDhFIt8stOjiCkaKMS2Ew=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-WNIyVVDRNs-KhGj8oOVEwg-1; Fri, 10 May 2024 06:52:57 -0400
X-MC-Unique: WNIyVVDRNs-KhGj8oOVEwg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41a370b6acdso9710455e9.2
        for <virtualization@lists.linux.dev>; Fri, 10 May 2024 03:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715338376; x=1715943176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87j9es5GKBqYf1Oh12DDQjpVqARqFQ5m4FHRLb5iAAw=;
        b=HikPF8W2OeQ2+T0QdfZmwkAOUoLPLAU/COoyGo8pPTgzMKvOqUU2UFsWBO2+WtAHq7
         sx1mTkxOdbCKAO/ocfpJaoUFzjvOuICoq/+g0/YL61sKBn6oE/So35d3C25xHKTFntCF
         y7BN3DmBFvo/BRaFI26T5JtJdbAZ3bdYbdQpMitLZU/VI7Pd1pvvmy6myqhVJ3Gn+UTf
         wqjn1Pm2KegqX1qwVlX0vCbLT0CzNEBD9DBPpikf/3//BVQNkGP26iEvIE+H+GZjTNPw
         rvt6JJzYiqP9NmoUsDmoagdNEbcLN0PXJdMmiH0LviokdAXjY7YbMWrg4XiKpgK4dzk9
         5E3w==
X-Forwarded-Encrypted: i=1; AJvYcCX7H6ZYWj+zK668lgU1RTmOk/gVQqc7qL3TkcCDtNwcMeg/PPbkv9OCEnP297Xp8LAyzJKjByFOF2NKoRYRm2YjMMEtnRm27XKlLQp2PvY=
X-Gm-Message-State: AOJu0Yzb6hhR/KRp1s1cD4zLcbzgO6+CaG68Vt5sIsRkxwHkVsjDyogE
	eJLCwVsSqfhGNsMStgh9+Edqm5ybBlqGs1PKuP/KjhxfWHR6pTX6HVDUvS4oVUbM83e9KQrM5NS
	CicjyhjMh69u7wEPI7rPmmJRrBJ78OGUpFodRGY4+0Yetp3exXgHZQACyTmbAhcof
X-Received: by 2002:a05:600c:1389:b0:41f:f053:edb4 with SMTP id 5b1f17b1804b1-41ff053ef30mr13398425e9.23.1715338376485;
        Fri, 10 May 2024 03:52:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQo8edf9Bbxrqhzc4y+CNPbsI1HGEi8VtkoHr3pgGLi1CN21Bn41Wng4Rd6DNLwV3eJ3w/LA==
X-Received: by 2002:a05:600c:1389:b0:41f:f053:edb4 with SMTP id 5b1f17b1804b1-41ff053ef30mr13398205e9.23.1715338375927;
        Fri, 10 May 2024 03:52:55 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7408:4800:68b:bbd9:73c8:fb50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccfe1527sm57995985e9.44.2024.05.10.03.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 03:52:55 -0700 (PDT)
Date: Fri, 10 May 2024 06:52:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240510065121-mutt-send-email-mst@kernel.org>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
 <20240509102643-mutt-send-email-mst@kernel.org>
 <Zj3425_gSqHByw-R@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Zj3425_gSqHByw-R@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >> >> 
> >> >> Add support for Byte Queue Limits (BQL).
> >> >> 
> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> >
> >> >Can we get more detail on the benefits you observe etc?
> >> >Thanks!
> >> 
> >> More info about the BQL in general is here:
> >> https://lwn.net/Articles/469652/
> >
> >I know about BQL in general. We discussed BQL for virtio in the past
> >mostly I got the feedback from net core maintainers that it likely won't
> >benefit virtio.
> 
> Do you have some link to that, or is it this thread:
> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/


A quick search on lore turned up this, for example:
https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com/




> I don't see why virtio should be any different from other
> drivers/devices that benefit from bql. HOL blocking is the same here are
> everywhere.
> 
> >
> >So I'm asking, what kind of benefit do you observe?
> 
> I don't have measurements at hand, will attach them to v2.
> 
> Thanks!
> 
> >
> >-- 
> >MST
> >

