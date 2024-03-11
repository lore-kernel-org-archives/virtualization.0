Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1BC3C46B
	for <virtualization@lists.linux.dev>; Mon, 11 Mar 2024 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176754; cv=none; b=IzAI59yYcNZn72k1rLkh2WOZh4Jfbil08CeVwQhN43nmBaYRsnoJuu0TTqM/iCG8wus8RKPPb7MHvOcF47KASxmV16g3pQFlBNHsSG5OYtioT1jboDLYs4bMxfLS211YQd9TA3V/EAKs01ilYuCxoV5SuDo7Cfeo8TvAlesEoNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176754; c=relaxed/simple;
	bh=XNwbXKaCLGvCbpxIvSjj9i4O3/8QvDmG0N51zcg49XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=idZNzwLfX/o10VfkMRXRnsUvMB0hURVuCC7GZH1vc68KC+KZ7fwkU8SmiryR5dr16QZIAUtr4yuQbneROiZ5XqB7LX5VdDnJV6CDqtbgcsaYcQLRlwratjk2+2qiAzO9CilGoxOIUrl50DwBMSwST1ZOJquERsC/RBM419psmIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajTDhgMO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajTDhgMO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710176751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ofx1nXrTDjwWTrrBkspXHarb2XIic0gZXzZbExCDCt4=;
	b=ajTDhgMOEQewIwecpiRtHVyQtzfH0UOnh5KhHYlczN0bvE+hRmkw+ou03IAD1KU/P509zU
	VMeqGD2tHO14jSYeCBLux7rvxZcHOaocsnmc5OPfDn3QOZKRsRIdis4mk7ACsIf6DGxtIk
	SIC1GZyFPP8oifo3txmZ5WvTjqdUPzA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-uz6AhLGpP4K4mJKgpGIZ2Q-1; Mon, 11 Mar 2024 13:05:30 -0400
X-MC-Unique: uz6AhLGpP4K4mJKgpGIZ2Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33e8b93b4efso1013936f8f.0
        for <virtualization@lists.linux.dev>; Mon, 11 Mar 2024 10:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710176727; x=1710781527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofx1nXrTDjwWTrrBkspXHarb2XIic0gZXzZbExCDCt4=;
        b=Egq9tVPB3ec5vTinP2A66RaC03qFrUwuCy96jO6ALykA8rRpvYe/W065vRYGhNu+lP
         JhfJMfWxiETtllY4gkNGIVQyEBfNLRRCe+chEJmTqESTS0DWWtg8/ryzAGAwYJAP9oBe
         hz1u2IXDMpZFsegV00PgfosIYNCcM+LnRurmW4SzMBmuvJGPKr/cTfPcrHNc/pbayMSy
         z8J5XNeyxUNFuNfNpUAdf89g0CbYzh9wVhwxA/SlKA0np8jstz5cvoirZ5q/QYIZd/FY
         noCp/AsB9QNxWoqzWewPR0oJ0QcwXNNsVRXz8aiUyYdS3i/Q5nJe7n0+RWgGHrM1gXCM
         8F5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0niQTP58AxKJsrzBtTU0ZaqsK8wt/t1qIqtOC4txBPmZExYSqplhBbeZRxUjnfUU0umAhb2jXvTSlZ7t0GOyfffSpYAcNqAWJcpZmPNQ=
X-Gm-Message-State: AOJu0YxZTtBI/06pB+AGOtSKEAGNfwWfOnR1z8uVKIbuO05Z9TK8+NCl
	0b7AYTrDEzjNOK7dZPqvRud6nvuk1cYtojyr6HPfZ0+AGiR4HZ95qloYpOFBd0b1f+o/VaX+Ef9
	GjuSmUKMm69fws5YoHyTyw/ERM+oNcUN6tDY2Y7J2t4lGPbR4dHhqZ5EjcZGXZij/
X-Received: by 2002:a05:6000:230:b0:33e:96b7:af6d with SMTP id l16-20020a056000023000b0033e96b7af6dmr1971471wrz.6.1710176727049;
        Mon, 11 Mar 2024 10:05:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkykAXhh3ZDBHaIBqo4LqQhaHhS1QTgvnZKN/euSPkgltlwWOCucmDgB5XoQsM841Kz8WUQQ==
X-Received: by 2002:a05:6000:230:b0:33e:96b7:af6d with SMTP id l16-20020a056000023000b0033e96b7af6dmr1971451wrz.6.1710176726496;
        Mon, 11 Mar 2024 10:05:26 -0700 (PDT)
Received: from redhat.com ([2.52.134.16])
        by smtp.gmail.com with ESMTPSA id b3-20020a05600003c300b0033e239040d8sm7123545wrg.84.2024.03.11.10.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 10:05:25 -0700 (PDT)
Date: Mon, 11 Mar 2024 13:05:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Jason Wang <jasowang@redhat.com>, Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20240311130446-mutt-send-email-mst@kernel.org>
References: <42870.123121305373200110@us-mta-641.us.mimecast.lan>
 <20231213061719-mutt-send-email-mst@kernel.org>
 <25485.123121307454100283@us-mta-18.us.mimecast.lan>
 <20231213094854-mutt-send-email-mst@kernel.org>
 <20231214021328-mutt-send-email-mst@kernel.org>
 <92916.124010808133201076@us-mta-622.us.mimecast.lan>
 <20240121134311-mutt-send-email-mst@kernel.org>
 <07974.124020102385100135@us-mta-501.us.mimecast.lan>
 <20240201030341-mutt-send-email-mst@kernel.org>
 <89460.124020106474400877@us-mta-475.us.mimecast.lan>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <89460.124020106474400877@us-mta-475.us.mimecast.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 01, 2024 at 12:47:39PM +0100, Tobias Huschle wrote:
> On Thu, Feb 01, 2024 at 03:08:07AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Feb 01, 2024 at 08:38:43AM +0100, Tobias Huschle wrote:
> > > On Sun, Jan 21, 2024 at 01:44:32PM -0500, Michael S. Tsirkin wrote:
> > > > On Mon, Jan 08, 2024 at 02:13:25PM +0100, Tobias Huschle wrote:
> > > > > On Thu, Dec 14, 2023 at 02:14:59AM -0500, Michael S. Tsirkin wrote:
> > > 
> > > -------- Summary --------
> > > 
> > > In my (non-vhost experience) opinion the way to go would be either
> > > replacing the cond_resched with a hard schedule or setting the
> > > need_resched flag within vhost if the a data transfer was successfully
> > > initiated. It will be necessary to check if this causes problems with
> > > other workloads/benchmarks.
> > 
> > Yes but conceptually I am still in the dark on whether the fact that
> > periodically invoking cond_resched is no longer sufficient to be nice to
> > others is a bug, or intentional.  So you feel it is intentional?
> 
> I would assume that cond_resched is still a valid concept.
> But, in this particular scenario we have the following problem:
> 
> So far (with CFS) we had:
> 1. vhost initiates data transfer
> 2. kworker is woken up
> 3. CFS gives priority to woken up task and schedules it
> 4. kworker runs
> 
> Now (with EEVDF) we have:
> 0. In some cases, kworker has accumulated negative lag 
> 1. vhost initiates data transfer
> 2. kworker is woken up
> -3a. EEVDF does not schedule kworker if it has negative lag
> -4a. vhost continues running, kworker on same CPU starves
> --
> -3b. EEVDF schedules kworker if it has positive or no lag
> -4b. kworker runs
> 
> In the 3a/4a case, the kworker is given no chance to set the
> necessary flag. The flag can only be set by another CPU now.
> The schedule of the kworker was not caused by cond_resched, but
> rather by the wakeup path of the scheduler.
> 
> cond_resched works successfully once the load balancer (I suppose) 
> decides to migrate the vhost off to another CPU. In that case, the
> load balancer on another CPU sets that flag and we are good.
> That then eventually allows the scheduler to pick kworker, but very
> late.

Are we going anywhere with this btw?


> > I propose a two patch series then:
> > 
> > patch 1: in this text in Documentation/kernel-hacking/hacking.rst
> > 
> > If you're doing longer computations: first think userspace. If you
> > **really** want to do it in kernel you should regularly check if you need
> > to give up the CPU (remember there is cooperative multitasking per CPU).
> > Idiom::
> > 
> >     cond_resched(); /* Will sleep */
> > 
> > 
> > replace cond_resched -> schedule
> > 
> > 
> > Since apparently cond_resched is no longer sufficient to
> > make the scheduler check whether you need to give up the CPU.
> > 
> > patch 2: make this change for vhost.
> > 
> > WDYT?
> 
> For patch 1, I would like to see some feedback from Peter (or someone else
> from the scheduler maintainers).
> For patch 2, I would prefer to do some more testing first if this might have
> an negative effect on other benchmarks.
> 
> I also stumbled upon something in the scheduler code that I want to verify.
> Maybe a cgroup thing, will check that out again.
> 
> I'll do some more testing with the cond_resched->schedule fix, check the
> cgroup thing and wait for Peter then.
> Will get back if any of the above yields some results.
> 
> > 
> > -- 
> > MST
> > 
> > 

