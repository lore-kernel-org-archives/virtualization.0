Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD94619993F
	for <virtualization@lists.linux.dev>; Thu,  3 Oct 2024 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967990; cv=none; b=EbVZSRctENXOlKhmJMM60jVHvl4wW6F6UO8nyiv9ksY6slRRcHOBQssOMfUH/k77ySaY4VqWxAd4pVcJ4+LD4ZD51OcpSzA2iY7OMcQ9uIofX7SLhMQpVdajm5NIi/1PuIkI6gbdIs73rwE00ykFPRecIn9Y35WcNa4eQSpsxJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967990; c=relaxed/simple;
	bh=7issmRctBTQCoGM92lUpsl5d1G0utqmexzVnmphaKTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eA6FQrsls+W21vnZvBnBJ+V5DJiMcMGQ4559WvN4UV3kIUxtA6BihFOr2p3es8gha+EUufoRo6zDR1v7u3awmK333iH459mCClTe8vmB513In+A04McvTwHrihJFWdEBfItbyd3DWXqQTYWwoSTkgAVOOnCCgB43DhHE1gMR4gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c88370ad7bso1178439a12.3
        for <virtualization@lists.linux.dev>; Thu, 03 Oct 2024 08:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727967987; x=1728572787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4KSvx73nCV7n78PZpzu/vzXVS1JSUP4mhHufTr6XR0=;
        b=vZOZSup++ejXUpeOUo5eZUAOFmUBX+qUecruoFVzm9A9nxJX89TMzQ01XgHcSkDrU5
         b3hgUGDs8XobOKVh3C/+tQff99MiBvueu0do2P9wxqXfmzeIoawCac6rei75qaTQjLFk
         smc/mPriy6DH5ynsUsLmcgv6aS+UtImCpkk47NUVkJcqXwpy1+e5wDVD3/sCd9QQh5xE
         r3aW03AJQ+k/1dc1izWX1Bx3NkcMykj5ZSEmC6txBNqLpTSVK9+13vrmvdt8u9B3bD2a
         KrNHKcLeCNLvsERcuEvYZNoHE1Y4C+Ezhdx9HqyhsOTvrSwuCDZjO/68BuyXngIVLywI
         0MCQ==
X-Gm-Message-State: AOJu0YzVzy3eLxUkcj4sbN61ICEdUzZhUMdCWlbj1AkCkzQJw53/NDtw
	3LwqOBtfEo+OWas1bMCaGe2YwRGjB3rGao5CHgTsquJ5JABSNCsoNg84Vw==
X-Google-Smtp-Source: AGHT+IGX0d8aLok+9ELChOJIxFbkKzG0uUZ3DH4CXEIF891HICs1E87mXL2LbG4Pozd4DP6bCTHGqw==
X-Received: by 2002:a05:6402:26d4:b0:5c8:957a:b1e5 with SMTP id 4fb4d7f45d1cf-5c8b1a3ae69mr6018028a12.16.1727967986881;
        Thu, 03 Oct 2024 08:06:26 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8ca4f70cfsm799418a12.92.2024.10.03.08.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:06:26 -0700 (PDT)
Date: Thu, 3 Oct 2024 08:06:23 -0700
From: Breno Leitao <leitao@debian.org>
To: peterz@infradead.org, gregkh@linuxfoundation.org, pmladek@suse.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	kuba@kernel.org
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, vschneid@redhat.com, axboe@kernel.dk
Subject: Re: 6.12-rc1: Lockdep regression bissected
 (virtio-net/console/scheduler)
Message-ID: <20241003-unbiased-adventurous-chupacabra-6c8acd@leitao>
References: <20241003-savvy-efficient-locust-ae7bbc@leitao>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003-savvy-efficient-locust-ae7bbc@leitao>

On Thu, Oct 03, 2024 at 07:51:20AM -0700, Breno Leitao wrote:
> Upstream kernel (6.12-rc1) has a new lockdep splat, that I am sharing to
> get more visibility:
> 
> 	WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
> 
> This is happening because the HARDIRQ-irq-unsafe "_xmit_ETHER#2" lock is
> acquired in virtnet_poll_tx() while holding the HARDIRQ-irq-safe, and
> lockdep doesn't like it much.
> 
> I've bisected the problem, and weirdly enough, this problem started to
> show up after a unrelated(?) change in the scheduler:
> 
> 	52e11f6df293e816a ("sched/fair: Implement delayed dequeue")

Errata. The commit is missing the first number. The right one is:

	152e11f6df293e816a ("sched/fair: Implement delayed dequeue")
