Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFFC29C328
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116053; cv=none; b=a57OZQ1DWVd2bmvEOBZkP2UHUOk8xm0ATeyBRnt5w/k0HxL6SyMYOnqM2RrZMMolimsIijDX8GcxsUm3ntaAPixk69ufTxG2YuypScJxiCQ4VaQd+Nq2bfNfkCNWG7EKvJbGqu23b3UsFdYom1CsMDcqEUsmBewm54KU0Y+/C6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116053; c=relaxed/simple;
	bh=ky+54WzqhwCQn3Ytm4Zf4MQKrizH9ZoY5ZQZgkQiVj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GDAJxIa/WqNg4PJYumA5HFzajJ63gUxZC8m0SNum6HFHYrha0qAR0C1pM2aw6OkMy/bzceDMs/uPv7FDkuZ8YrRvyw2zwRsJLsUlXSEgY7DBf1nt2XDqWopJ7+4BPKEGduAI7neDxSpGGmSSzw+m9uYUodzWGaiLdGKkNFSua4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzD6ewqv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzD6ewqv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781116051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FRdfQpUlvZVI1ND25INGLzSIbMuZeJsmz2jd0r5twS8=;
	b=gzD6ewqvBi2+kQjweSyWB9hx84TNyVaw696AEtRI+wj0X5w1PMktt9PYWUCcHaY+dbchuN
	1ygcvJI9tLKLtvBIQBwXJgpxyQCOmNt6DPpOsflc7bEcLokaDkz/RvyKHqNlB87fuDh+iY
	LOlRBNzB/FouvWtaZ+kwBhpbQioLZ48=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-OGxYbmnWMs-cMlZf3txYPw-1; Wed, 10 Jun 2026 14:27:29 -0400
X-MC-Unique: OGxYbmnWMs-cMlZf3txYPw-1
X-Mimecast-MFC-AGG-ID: OGxYbmnWMs-cMlZf3txYPw_1781116049
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b37e1f47so61621845e9.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 11:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781116048; x=1781720848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRdfQpUlvZVI1ND25INGLzSIbMuZeJsmz2jd0r5twS8=;
        b=X7vHCnnSEzAQdF4I2L/349WEhvyW/fATkxy5rSYd2pDlDpP+2GlqYKH48Jv6+n+jDp
         PngeYA992OZeMS8uE2pHMVatjXQNyASZ/xtlYwB9202xaGF3qwHeUDSSu0Mg6DzM/kUu
         PeG/sNdNjl023rZCR9mGCO8NoR1eeLxhYbswCdzw1LdUBMwfabbfoDWCOFb9pWdZRMta
         U1yL+1SJKEQRHxf0ZOWN1x5JysAqw6plrb7BG04WSG/FN2wu/x0+QNDaWEGkbgqchaPd
         Zsz7fEgehnL4yivymmCJm4t4a+gz/zYc2G5sEMRsqtSJsGZ35m99CJEjFr9fywIsfZQ1
         fKDw==
X-Forwarded-Encrypted: i=1; AFNElJ/qGlma1Yj4Hm8HKMXzEIRooty3uDMcnZzrFu7ibq1WlEP3Mm2FaACfKqIOqpk2zAGKTy4d9gWu0h1GdKqyqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYB5ZT9dp5yIXYR+Y8DPbQc3qK9bt1FG7r/2sIpZ61fehf+t2H
	0TTdvS+MJSsyKph5jJ36KWDVOWBcE40iLLDnDrMJMh/bWKwR3TOOXqQuemiKagPLhqdLDWMT8T+
	Is8ZJTMHkZBlHWe0fg4M4S1lzSCDBijw/mtgWZpBdAXtJDqtzi00o1Ljm+IsVJe8igEGH
X-Gm-Gg: Acq92OGUeDMtuQVWBbyqejryARvh903b0unOq0QM39Jr+x+YxKNWca9C0/766vrXbdU
	Dj0F3pD87vK92dZhPApVB9qdAd/TBiGP+7S05tRB4qcVAjn5KpIORGP0bMzYCLo2w8VtT0Kxmj4
	dfgLtG5sqPP6rf3fhAThJLifWxbOpIpZeO6gLpc35+hdu+p3peMu8ALYa4LAHivfw2InHEeqo9d
	Qyh+FFlctDxjsO+IKRxaiTlYkNhGR63sFDxFZOQyZVZCdhO7qJkZg4r671a5GHTZR/ZBXWn/G/d
	TRU9LoOG7nupZd0r0Mk1u4bOs4qdUVlzBL7/uh8vUoz1gFBDTDtNVf7DXsaTNV8VS1GAHF3JHpZ
	/BCv9coEuIFQ/WMHjj919lsE60nz2UnCUUydjvX0e7rtPTUrPhwSWBg==
X-Received: by 2002:a05:600c:6087:b0:48a:8b02:ae91 with SMTP id 5b1f17b1804b1-490c25b0231mr450959525e9.11.1781116048489;
        Wed, 10 Jun 2026 11:27:28 -0700 (PDT)
X-Received: by 2002:a05:600c:6087:b0:48a:8b02:ae91 with SMTP id 5b1f17b1804b1-490c25b0231mr450959235e9.11.1781116048015;
        Wed, 10 Jun 2026 11:27:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm128623628f8f.27.2026.06.10.11.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 11:27:27 -0700 (PDT)
Date: Wed, 10 Jun 2026 14:27:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Li <gavin.li@samsara.com>
Cc: linux-i2c@vger.kernel.org, viresh.kumar@linaro.org,
	"Chen, Jian Jun" <jian.jun.chen@intel.com>, andi.shyti@kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v5] i2c: virtio: retain xfer with kref to fix UAF on
 interrupted wait
Message-ID: <20260610142623-mutt-send-email-mst@kernel.org>
References: <20260610155834.79207-1-gavin.li@samsara.com>
 <20260610120606-mutt-send-email-mst@kernel.org>
 <CAKvMnUW-3b=cqHcozydnc6K1vD06FGk1ZO_q7S6SqhA5d8eR2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAKvMnUW-3b=cqHcozydnc6K1vD06FGk1ZO_q7S6SqhA5d8eR2g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IyYJGHY5XvTehxsdE1FFxEfkH1VmadSF7EeFhfZD-vA_1781116049
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2026 at 12:32:42PM -0400, Gavin Li wrote:
> On qemu, queue reset is only supported by virtio-net.

Not hard to fix.

> If a queue reset
> is requested, the vhost backend is never notified, and as a result it's
> still at the device's discretion to write to the potentially freed buffer.
> 
> As for device reset, I really don't want to initiate a device reset just
> because a userspace process was signaled (it seems a little extreme).
> I can implement this if you think it is the best path forward.
> 
> Compared to the original patch of making the wait uninterruptible,
> I feel like this patch has become much larger than I originally wanted.
> The commit a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible
> completion wait") that introduced the UAF mentioned that it was originally
> done because a transfer could hang, but IMO this should really be fixed
> in the vhost backend rather than in the driver, mostly since virtio-i2c
> doesn't provide a way to cancel an in-flight request.

Maybe the 1st step is to revert that then. Up to i2c maintainers.

