Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780EB390C85
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735686; cv=none; b=gPwr7ocQTcrh7WLkBAceQtT08Hp7q8NSb74vTepiJNeWloC89M+dkFKl1UojkVrbID2EpYjLJ7pNWqFGJzbQxrAYuA+KkeW2AZkTgWqnND1MPeE3zzq/Yp4WNOwmGY6M1j6QeARcPM7voBGEaN+JZGjoBZUeg11IQ4eNYb0896Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735686; c=relaxed/simple;
	bh=q9aV8UEMRbT/uR1gFd6YDDhJxj0IDZcbyD15EdPgcc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Pl7iE1+O3lS+lJYK1yRHZb0R9cRdgW59KJ3h4pDAs4xvR9LmOky9FAy+wQbjDo/+CvGcyH1yYnb0OXdV9PsPCMLMRsTNRNBz3P+i+wbmJYnu1mGUntrxZTod+NVna6NlLOPxkpQ8enXP/FuMdRRgx81nm42yonXRnoI8YXiPzBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKPlUlfX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKPlUlfX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789735681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v+JaQ3C2cAyYFQJK2/l9R/7/otniBmov2ptyT3UUpaA=;
	b=iKPlUlfXdznxed0XDB18GmFl+48sWj0fL0zUo9XsTJY5kFlS2Eu8YAPIbl2tPlUTvYtYpV
	7vrUKmp4fncovq4buIhvMpl3TWajbOvCSIUbcwByZcDeru1kOkW98T+DBN5aHBTvI68ERX
	rpjRopwPHDJzodHDeqXSbiACF9YF5uQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-oNgA64SaPwmpPgGCbQ377w-1; Fri, 18 Sep 2026 08:47:58 -0400
X-MC-Unique: oNgA64SaPwmpPgGCbQ377w-1
X-Mimecast-MFC-AGG-ID: oNgA64SaPwmpPgGCbQ377w_1789735677
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49cf9df1eadso4449865e9.3
        for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 05:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789735677; x=1790340477;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v+JaQ3C2cAyYFQJK2/l9R/7/otniBmov2ptyT3UUpaA=;
        b=e0EnAKL758KIfaJ9vPCtqX53Em7Zkf+kp1NQvr7uxIpUce3/dGxWqkOxWtm2h0ccFX
         86VrSjVlmSTCZ2o8X51BQk4SVFQWKzsxDuNXojeGYpL00wBRgnIeUyAwdULbXLk5vXma
         1zd2bwpw/B0v35chpu1cQC/+ai3F3qaX+XbwvikrIojl9+V/iTftbE3EYJaEwMgVXadC
         w6IclagQNkXanfhtcq0wpqMKijFEMVmMLN/En/NvV0U9eIdjbDjyi5K+vdHBcfl23FHH
         QandN8dfm8xpHDg4n85qYACOGz7nfRuCAkq0zoHQw2x0+GXlsmIQdwBid5FOx0/83yy8
         FQNw==
X-Forwarded-Encrypted: i=1; AKwUvBzn87s7cPuxZQ4Bp214bTDL0J2Q7ncWo0GmuwlUEyyNEKk0c4o/n0U8OiCpTCz+NtSN3QZUDkL39JN75M341Q==@lists.linux.dev
X-Gm-Message-State: AFuF++kgw+39iXBXESjhjAs++pR3fXKQWI4+NXHYrWmMx7b6e9I9upFK
	MD7bsTxDP8prum6n6/MjSKImhrwADkE7fROfEU6iDhildGIFC+0b/xhRj1j3Vx8AlnERzfPWlow
	zV5wQ/wAnHlmbK++QtdUu6O/M2GbN3XeidQYw1vTTXa3+ZGQ5DqVKxVAIIwIR+DRSsU29
X-Gm-Gg: AYBFou0VCWvd5P/cAfEd44X3tvY4usL3DoLeHV3JN8eUFfL+LW9u/bYpnJtw3syQ91w
	IeEakNAtIgF/Vff1FifB03wWHJc6zJHUTAFVCxftEpKIVq6TGkW/H2WwBoHB0cm+/Dsy19iG9dJ
	nPdG4iUseblD3igdnjKVv1awzoXJc93Wxig9h3oYK+ekQgk5RVs9alkGKQi/9E4smXMEDdlP/H4
	Lb8Z/zd0m4blbhq/zWMG0FRsSXbYsjh4Peitv+kU4acJVJi15LoeCel2PBtRo2GtHl6/bH2g98U
	iajL12616Xn7XvJpopSs1pzTW/H983dyx/G4RMKcrPpFnUVCkPUOfCqJnKVp7YocYzC6bReS6vY
	YG4Lx6pyQE/cNyivUI0OkSHohZdRxYM+ixpU2zsJWDFGyZQ==
X-Received: by 2002:a05:600c:1d99:b0:499:8ff5:8ecc with SMTP id 5b1f17b1804b1-49fc56dacbfmr35462195e9.15.1789735676769;
        Fri, 18 Sep 2026 05:47:56 -0700 (PDT)
X-Received: by 2002:a05:600c:1d99:b0:499:8ff5:8ecc with SMTP id 5b1f17b1804b1-49fc56dacbfmr35461105e9.15.1789735675472;
        Fri, 18 Sep 2026 05:47:55 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc58a1176sm39414825e9.2.2026.09.18.05.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 05:47:54 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:47:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Ivy Lopez <skunkolee@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock/hv_sock: fix socket/table leak when rescind races
 the delayed close
Message-ID: <aq0ydoRGx4hq7BdR@sgarzare-redhat>
References: <20260917220213.56102-1-bartlomiej.dmitruk@isec.pl>
 <20260918025650.15990-1-skunkolee@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260918025650.15990-1-skunkolee@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XdOvYq7H0QfPnHP1BpK_dYRUFhUbn5KrlZJCovDhDgg_1789735677
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Sep 17, 2026 at 08:56:50PM -0600, Ivy Lopez wrote:
>LGTM.
>
>Should this need a Fixes: tag and possibly a Cc: stable@vger.kernel.org?
>

Yes, please.

Also, if LLM was used, we should add also Assisted-by tag, see 
https://docs.kernel.org/process/coding-assistants.html

Stefano

