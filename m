Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1823546E6
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116154; cv=none; b=NcDAVd5NxaAX7P/hAhVhzRY07tjruqBM8GHlqolZlkC3l1R83t9AQiqCf77WPWf/7muGH4znKJpvOsBk7GzeNXR7aj1zfdmxOfbLaXoelQmrT8T0GcMLUBZBEKSW8HhVATA9s7ehC+5SRwOk7+YKr07HkB54gGqFc59AzFxEjRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116154; c=relaxed/simple;
	bh=5eJc7bdv9UcuO2/Vxvv3fAGYYH6i/iFPsJ6Zo79uDfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kS7BH38csQigeTEeUDvdDyWW6EXIpK4e33BNqpDEQ61ZTH0+xvBWDUaEjNkL0WrBggM3mjixSnLmjxzvbxJPjGBjtH+Mz6ym2YDpKetmSW3OMbnvbXLdQTgV2tH3nHGzx8SpfTqzBnKcmmN/vm37V5F6QOm8Ay7KAEURyjqMDEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gvD3R4aw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvD3R4aw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781116152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NQAVhVT6gguuYJ2zdf4a7mcws54HuCOez18N0LHRhOc=;
	b=gvD3R4awEEVP73iOlG5OQnVW/BDSEKxaFaWGlzm16M/6Z0HhySiEllHXd5aw0uPRQb83mu
	vPokesBeej51+WQ27fMcT83dkqF6BXT8nAstU+3sOE/yfUgpR8HggWRSwwx1PkseGj1RsF
	+ukk38M8dFy18hM//i9surqmeWVRaAc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-Pz8-fIYaP46tjpvgLWs8gw-1; Wed, 10 Jun 2026 14:29:08 -0400
X-MC-Unique: Pz8-fIYaP46tjpvgLWs8gw-1
X-Mimecast-MFC-AGG-ID: Pz8-fIYaP46tjpvgLWs8gw_1781116148
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490addd42bbso44143125e9.3
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 11:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781116148; x=1781720948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQAVhVT6gguuYJ2zdf4a7mcws54HuCOez18N0LHRhOc=;
        b=MWexdyqXbAHYdKkE0ruWCWkiu4Cj2KB/TskZC4bhYN/XE8W7YmrRZkPBFGdJfneKV4
         FNVDb/FgMTrtILcjhE4UYBQeZFcglpxbkJz+rZvpmhDk64SPCDHb+/xra15Udh1O95zi
         cwDPvmXgF6BUtc5vmhbUSkZpUOv4W8EcJc+9AVyWKlkKAxiXp+QXdupkD1nEF+yC+i38
         M37JhQafKR6dujsdTlOTg92DdwQnnu07hHIwG86EhfzXQLCUphyuT4LPzuXBdd38/NWd
         loSmEp1ZCdXgE+wSjPaUBacD2sITm/b6Gqs8RSDhgRIKf/bOeaOBoVx3jnF4uNMPeH4N
         zAiQ==
X-Forwarded-Encrypted: i=1; AFNElJ8MueSC6SSPUG3LCNU5ZjXB2udi3MrslzIQkoEl8PceVLQvLQs7dzcwGNKlMueupYr+p8WmFm3J8DppJFMi0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKwVMsDrPpbrzfzLAC/Dbz4zSLYLcKS9daK1kbAcnB0XY2dcBI
	j73QQzFia186+gRRxHIUTVbVD5bwE5E+tmgc171QuvohMYG8UQ/BXHt/KYNcMF6DaLggjg6H2OE
	2Gb3mHKDGgooReTz9O32KwNiRdRxgalmjg/4/U/6FyAXxzJju2eRmlR4PFZv/ehf6NxnL
X-Gm-Gg: Acq92OF5RAJreAskY4Rq/EYqt8H2PW3R8RKetjyM4/qR2u0uzIQHIddlzvu09pvkdtw
	eHthjJ/epzkk4OAYF7Eia4Smix4yixsLX6o9mMwuR91dwRV9/rMf0d9LQLceCYHAE2q++efatMf
	/sQ8tZYkXGv+6D4UPpbVR9XB7MBhkjlGTXJ7IFdwX/7FXVZoqjS3HupsNZ2WgzwdYseWfKEVpaZ
	qMopUxWPwrQDPhRcQEb2wB3PIU3frvWs6p8wD+/mJivtXneogqNc+K8DSC/eetpQA0psMBaLbu0
	EvaC2Q9h4Q7hVy3UY0Wm8wKLTCHufyhiYMz7UiHLIHV8KISFgktItvRyWnbKAYiRCctNe5tSrSh
	bRWbhyYg6/YENH7tSEEnMmoULKnVF6W6KBZYWs2u5fiD24vIQ4ws/cQ==
X-Received: by 2002:a05:600c:6792:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-490c25ee920mr433186665e9.24.1781116147585;
        Wed, 10 Jun 2026 11:29:07 -0700 (PDT)
X-Received: by 2002:a05:600c:6792:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-490c25ee920mr433186355e9.24.1781116147125;
        Wed, 10 Jun 2026 11:29:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2ca21f4sm3293785e9.7.2026.06.10.11.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 11:29:06 -0700 (PDT)
Date: Wed, 10 Jun 2026 14:29:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Li <gavin.li@samsara.com>
Cc: linux-i2c@vger.kernel.org, viresh.kumar@linaro.org,
	"Chen, Jian Jun" <jian.jun.chen@intel.com>, andi.shyti@kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v5] i2c: virtio: retain xfer with kref to fix UAF on
 interrupted wait
Message-ID: <20260610142758-mutt-send-email-mst@kernel.org>
References: <20260610155834.79207-1-gavin.li@samsara.com>
 <20260610120606-mutt-send-email-mst@kernel.org>
 <CAKvMnUW-3b=cqHcozydnc6K1vD06FGk1ZO_q7S6SqhA5d8eR2g@mail.gmail.com>
 <CAKvMnUXk0GrYNNYOHvME6FYRdKik-7fV5B-NgvRM+i5yYKTmvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAKvMnUXk0GrYNNYOHvME6FYRdKik-7fV5B-NgvRM+i5yYKTmvw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VRBB1ls2wx9DC8o7h7Mw0mzHZornY7RL-fFcci57Uho_1781116148
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2026 at 01:34:10PM -0400, Gavin Li wrote:
> Another option I am considering:
> 
> - Uninterruptible wait with timeout, timeout based on adap->timeout
> - Upon timeout, reset the device with
>   virtio_i2c_del_vqs() + virtio_i2c_setup_vqs() + virtio_device_ready()
> 
> This behavior more closely mirrors what other I2C bus drivers do.
> The device should be completely quiesced when virtio_i2c_del_vqs()
> returns, avoiding the UAF.

I don't know enough about i2c.

Maybe
1. revert
2. some other hack

-- 
MST

