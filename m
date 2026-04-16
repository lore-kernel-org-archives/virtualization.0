Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379521A76BB
	for <virtualization@lists.linux.dev>; Thu, 16 Apr 2026 00:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776300531; cv=none; b=YHNe2DABa9KpUxGT3LcM67ODkbspX4/0Bzj0ZEuuxE+/6yXxr02yKOJvSp3gZ7IboQQNwAPH31/DBKHTc9DgXq33Gu1HROvMyvOftuIheymhAg4U7SWQmGR2WOlozR05hI2ASJk+Kp/hcsP1p82oQqQQzIhEWMl6Kh5Tizntgsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776300531; c=relaxed/simple;
	bh=vSZrDHJWdUT3fc0mnfVsASM38Ik77OOrDrcLveHcMs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwlcvpc/uZms8dMhWDmAipeM6xIP+whrGVGnIbBlGZ8TFlS15iZk3QFw3bUKEatV6Lo5xb4awK0ui/J6i5erL5Z23nOjcDPP5nZvT6HhWmzWuSOWjyfCuw2J4E0FCWQOvLwhZ80DX+0LVC75rKXeD1rWHFs40+BGxFQIZkLZdvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM2rLDIm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM2rLDIm"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so51315025e9.1
        for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 17:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776300528; x=1776905328; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wHjoL5bgW6OaCvqxEnCcQc9CZYqGIAVWFc6AfVy0os=;
        b=MM2rLDIme09D4WxO3BgUPBTZIkINEbwa38atOS1XhIJaeGNKXcxnl+Io6Ut659Nn8S
         shYCy4z2Fo51d8JEFoLb75mpi/9AKZypRNLHk7e/LZm9/KZjOyB4st407jI1uplSiZmp
         lmJnYGLqEUGps6Gw9DAfEVfcx7aORzgwazepj7OxYwTDvljgeRj3/Of+oI0OUE/EdaRr
         y8a2BOtJKH4/DHKAkn/CXSFp9+DRiD4LVkJXOjO8YdTtLP6cuBzle/c7ScGM2U/8nCER
         ykGJtw6gLWAIgscI356itTsWdHu0zdSuQlHoGtalVp6O/3aXZloVx5QuEeF8w1qQXbw5
         h/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776300528; x=1776905328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wHjoL5bgW6OaCvqxEnCcQc9CZYqGIAVWFc6AfVy0os=;
        b=VZJwN14myWrH1j6N5nDLfD84WZJZdaDMg69DPvGYmNO1JKtF+HpzdtEQpryXTMasTc
         azT5SRNGbhxivD8P0D8pweg7dW5IrSZQFzwDN9RHPfW6uWdoon68d8IUFnDRbrNAO7EY
         qw3tNBMSxiW/uEnvqCLiJPdfe97uoUZqbQ8EDQY6ZgEcKQyc8QH2bpTIQUwZOrylI40E
         oHr0ebw0/r/N7w/OCB0FrsYGM/rwNrma2gXbF74lBH39YLsqC6V/7W2EqA3ksntAIjxZ
         0ZUqeJjYt4X9jjHQnL8VMAYLZt9V8EYEPqZwF8BeRm5sgxNLRD0kt7gEUrhNhczlRBez
         nsiA==
X-Forwarded-Encrypted: i=1; AFNElJ+0ZiGL5wY3EqD9gPWgVajdhkRmNOJLmv3E1f1cbboWpIMYsq1aI5JJiRX8nu4+I1HSyepeUJNpXP105VP8Vw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8fxOP2bKPveN0C5j7BFfnBpNKD+51ff85XpB3VLCzmtBA8FSC
	wYDsEgKSQzohKTrofvu5bOZOhPJ7NqCouv4gy4FfTsfGfC9HaOP/KPdV
X-Gm-Gg: AeBDiev/Lf+YQsjneoRK5RzIiO1GAhmgVjYZrgGrv7fcbwra2u8w7EjtNrPmU6z1UFV
	jElgELB2TVkBN6KD0gIhldaowb64zd7Js0MRSTrTiOpY4nK+ukIw5JnzCflMjtaJ8Fkuou91eml
	0EAq0JxavJKm69Da+rfPC2h/JybeUOd7QanO+Z2CZ/kTT0jJmVRXdHm7a22V6zm0TNSUqKPV9W0
	LwWkqQQw7NsS1fDlsbI6+vDNlfAhVEnOSUCWCFjjn9jcgXvwcwYaGgzUlvv4gX5ukypK4XqG3RX
	RcVHqLCo8OFobtgBEF64ZDuz67g4TFFFOJyUmGrPQqGnJwGox0qIhQdV4hiqf6hHVZQjDNVPSoX
	jjQbLT7fCFhXk6MlzqvF9Ldm44kyyk9+NBPWTZqH6yLeu95BH4hNnUqzKkFgTNFYGsGLVgcAKet
	Row4fTvpc9d5sGCL51o3LqN/oPGX1mj86kIHLoG6G8moq3Zl9GQWPo
X-Received: by 2002:a05:6000:1a89:b0:43d:7b51:5178 with SMTP id ffacd0b85a97d-43d7b515250mr19740589f8f.5.1776300528339;
        Wed, 15 Apr 2026 17:48:48 -0700 (PDT)
Received: from fedora ([2001:250:3c1e:503:ffff:ffff:74aa:4903])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3dfff3sm8344319f8f.26.2026.04.15.17.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 17:48:47 -0700 (PDT)
Date: Thu, 16 Apr 2026 08:48:26 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, mst@redhat.com, aacraid@microsemi.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	liyihang9@h-partners.com, kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com,
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com,
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org,
	frederic@kernel.org, longman@redhat.com, chenridong@huawei.com,
	hare@suse.de, kch@nvidia.com, steve@abita.co, sean@ashe.io,
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v10 13/13] docs: add io_queue flag to isolcpus
Message-ID: <aeAx2g-nJQO2yyS4@fedora>
References: <adMoon3Zf6gO-UbA@fedora>
 <zawhqvn53mcp4wf7axsmuq4cg73upxs5h2zgrfta5dpat3sfy4@zctfbz2ttz5m>
 <CAFj5m9JE5e4DRGbzQFxDdZWU76ZPQ3G+C9JpLu0mhTB6aesZ9g@mail.gmail.com>
 <a566smu6morqeefqal23eek4ibezfuiwhs774xtxhyyclpbtsx@uzzwgbzmwdjd>
 <adhj_w11cpMfeEgN@fedora>
 <dzpxscrhibmi5okkozf5jfull4dcajgpctldvdyfcjgmpeetk5@tkeyqouyabzy>
 <adpD8M8cNu3IZzEL@fedora>
 <6glgsbk2djsz4cqtbp2ht4274dw4rveq6fojlnpnuvx6zmpjxw@i43jo2l4qlz4>
 <ad0Hk48y5JEeMlFk@fedora>
 <fouvg7qn7g4yah7jsvzkdmweesbp4aqmhx37gf3ow5medzvuyk@5n3ddkijosr6>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fouvg7qn7g4yah7jsvzkdmweesbp4aqmhx37gf3ow5medzvuyk@5n3ddkijosr6>

On Wed, Apr 15, 2026 at 10:56:37AM -0400, Aaron Tomlin wrote:
> On Mon, Apr 13, 2026 at 11:11:15PM +0800, Ming Lei wrote:
> > But typical applications aren't supposed to submit IOs from these
> > isolated CPUs, so in reality, it isn't a big deal.
> 
> Hi Ming,
> 
> While that may be true for general-purpose workloads, it is a fundamentally
> incorrect assumption for the highly specialised environments that actually
> rely on strict CPU isolation, such as High-Frequency Trading (HFT).
> 
> The requirement in these strict environments is not that the isolated CPU
> performs zero I/O. Rather, the requirement is that the isolated CPU must be
> shielded from the unpredictable latency of the hardware completion
> interrupt.

Again it is just your opinion, not a bug report, may not be a fact, right?
Which kind of HFT application submits IO from isolated CPU?

However, as I mentioned, I don't object this patchset, but you have to fix all
wrong comment & document & bug found in review first.


Thanks, 
Ming
