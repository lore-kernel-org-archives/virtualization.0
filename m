Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472E0156C6A
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 00:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761092322; cv=none; b=tHfuForbo9d8omoqEamS/Jmayz1ZgcZtr+cQj1nLOcoYgXyhiM2JK8ej4ptRBXaGWqXmWUIlD/nV10Btp0Cy/nryaUCmt1c7pMwXf7Km3MdNPTvo+BIb+d58B7lMFPwDVDXBjdyPB5XxiEe5B1CDxHA4AUJF+0XDwv27URJP8C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761092322; c=relaxed/simple;
	bh=e7zZqGzrVyuJ5QFyUVE7eGJWKcfl4COyVHk9MxNeNKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHWyRRWRK5QJia3bOt8E1dtZrrhk6xUtgcDlhVufdlj1Y+rQGNVSNRWuvNpjOJcPMODrUTaOp8MTD6yN2b5tLv7Rb7BeRbIYE1HQ3D+Nn5sEdtRen+7B+bJlpCy/AOV3oPtJtvV3S67Xqb6PJgriHEVpCFUVehvGJzg/5/niZ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOn98Neh; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOn98Neh"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-781014f4e12so78705707b3.1
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 17:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761092320; x=1761697120; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/VVHhrbKGyn2rHkoA+yo5pqhCOh1qQTtBCOhpEVSIKI=;
        b=MOn98Neh+wtIZFyrq/X0dJXSI6vCKzpGFo6yji9/h/4jy6c+b5mQX+7zdaHgT3+HYu
         GilPAOfZ2art/si1anQKZAlqpE/AbCG1GrVeXLGnI7HjpuQ1Ppb1r0nuoDclMSeHjk9s
         uNAIvB4rhYupv+MEbf+s1RJQq2QEi8O4TKYdXytvUnRXwVfhSbj5YFN5TIHFUYf3kmu1
         MmQwqON1oa/aJrCSkW353bWhtuCryFIMR3VnfzKnn+c9AfDiPmfn/KrM+QrwxQ2s6CxS
         EsdkaFvh8xyLGprb4veCfj6m0baySsAu9RwekQtZzfvWGBzvpjGXT0da2CBum6lzhaKE
         ea0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761092320; x=1761697120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VVHhrbKGyn2rHkoA+yo5pqhCOh1qQTtBCOhpEVSIKI=;
        b=IW04tdyIdzm6UtsWoaTjjYfQY4GRy76nFamwKeSpWZeEu8F+hHqS2XHCxn/Hw2EE7s
         azf35mU8DFWkW3L1HN2EsXMMvsJ9AwGyFBQ/XnFbtsgNycRrSrECIwAhxhIAcOtwMFsp
         hbm1gsZkrelq8GVlIsEW0vY8hR6CIzMBxiCAecFNIeqXxdqWbBhYqlmqkXcABfODKVQs
         Hqxp0RpVOopeiJuMR/8iZNAqUWCeUOZPNSqTUmwKLdvXNkGOaj3ZOF4zr5YZju3rGNxQ
         L7giJ4odh8ITcQ4NlTO68HQEDVnxz6PXf/FVkozIy8dE1WwM779i/PPn1C4jV697UrSs
         fGww==
X-Forwarded-Encrypted: i=1; AJvYcCUl5MGWu70twyPil3E+6uWon8lRvlS8V9XH6g0pMl451f8ghJzTB3lexMH6humlVfOowEUBVlJstxBlNV7A3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyajG0NkwTWm1x0MLawVm+c7xFsDOD7axJeYRvHhFb8t0zyaI4L
	yzhZ1JRULC3HY5VhVPo1flO42VVpegJmM+uyl0GU4hWtA4FgZ8LwgE6Y
X-Gm-Gg: ASbGnct8W2YGxXae/3AmozrJ48Xye9Qgl+E0WnBDtRkhjlaQjrbUPk0BNt+yQFZEVbD
	kI2eo44v1qvPXTQMejy0HWGfkSdWPXAItCjfQzXORBZjDOIX84mmP0SePNOXY1ZMg6GcTiyZSKc
	/cETQipHTjj8cuklTVUwU52+lCqgrb+b/wp/8HrmAeiSN0tv2912JEg8Pbf9CoskXPRjUvq8EpH
	fmh+Dy1riI6nT9BEec2O2taO9na6rRZvXmXqXvrNVUJQvEOa3vgK//+Ili9vlbvMUgi8SAn/S0m
	7DaZEHHVR45iFMPsVSdQDf1GnnQILQMNHVMGMBHm9spckYMP7eQHOTVZy/oEtz55YCv1y62WLhL
	XP1rR4n9wJNzIea724t8gVsamF+YiJ2XUlT49SaOR2UCLRrNNUpCX05IbxgrGK3hrItwevWthpy
	dzRm+3LWV18MnDbupgk9z0iFLd8SxPKa5fpC12Uw6LkL2Hb2I=
X-Google-Smtp-Source: AGHT+IEqYiiuWqadmrSa+ocB1xo5kZsyd7pE12wgODlf319TseLh48deAbNiLMyHfUUvkPdfF1Gc1A==
X-Received: by 2002:a05:690c:45c3:b0:783:7266:58ef with SMTP id 00721157ae682-7837266619dmr152519147b3.5.1761092320133;
        Tue, 21 Oct 2025 17:18:40 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:59::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7846a6cc14bsm32765777b3.60.2025.10.21.17.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:18:39 -0700 (PDT)
Date: Tue, 21 Oct 2025 17:18:38 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
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
Subject: Re: [PATCH net-next v7 08/26] selftests/vsock: improve logging in
 vmtest.sh
Message-ID: <aPgi3vSJGGfBovRf@devvm11784.nha0.facebook.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
 <20251021-vsock-vmtest-v7-8-0661b7b6f081@meta.com>
 <20251021170147.7c0d96b2@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021170147.7c0d96b2@kernel.org>

On Tue, Oct 21, 2025 at 05:01:47PM -0700, Jakub Kicinski wrote:
> On Tue, 21 Oct 2025 16:46:51 -0700 Bobby Eshleman wrote:
> > Improve usability of logging functions. Remove the test name prefix from
> > logging functions so that logging calls can be made deeper into the call
> > stack without passing down the test name or setting some global. Teach
> > log function to accept a LOG_PREFIX variable to avoid unnecessary
> > argument shifting.
> > 
> > Remove log_setup() and instead use log_host(). The host/guest prefixes
> > are useful to show whether a failure happened on the guest or host side,
> > but "setup" doesn't really give additional useful information. Since all
> > log_setup() calls happen on the host, lets just use log_host() instead.
> 
> And this cannot be posted separately / before the rest? I don't think
> this series has to be 26 patches long.
> 
> I'm dropping this from PW, please try to obey the local customs :(

Sorry about that, since these selftest changes were all part of one
messier patch in the previous rev, I wasn't sure if the custom was to
keep them in the original series or break them out into another series.

I'll break them out and resend.
