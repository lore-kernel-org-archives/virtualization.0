Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047D61292D7
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272595; cv=none; b=O1SuSh1+bbZtApqUz8HhzqAvZtxLGPYA/icZUsoSL5C5K+wfxgRz+OREpsqZo/GM4NErBj+lkbQ7RCueMqWRjpRvUX+IE0rwcYiNMFF4nIAycCnV4cl3WqYvWC466G9SEXVzEbHhA1Sb0VNqekwRQv6+6bjFijLD9gLn6+r3g1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272595; c=relaxed/simple;
	bh=dhYROQg4XWteWDYZ5krf2keKG/9XCEg89sGPS1DTzsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJJok6oRME+A3k7Cx4S5LirlHWK6qySCSt8cshb2bSdrsXZtlzQ3EMhyze19FNbVJp1JqOV391PF8y897JhiZcegmwdB6bj4LwheC04c8h0E59BTS8La6f5xVxBXS/EuHNnuVRnTXndXiXRtMRUoB0JFeT5MhQbWDLF5FcdqL3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lS8IKxyO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lS8IKxyO"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41881bce4b5so11966025e9.2
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 06:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713272591; x=1713877391; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/6q7NOzAqjEGHCoFf5Mh990/OZO+Hd3GsoPPU2va58A=;
        b=lS8IKxyOX2Sdnv7BWI3gnKDKeqs87RRDYlPIpEjnkepdlKBkkWorVNqoJNIVHvwvhD
         BV5M8MGM9PpWX6rP0Rwlex4FUS3Jxj6Oox2ALE7h/UeSVZdhx42hc7BKyobpwFjubSsx
         LIWJR5qZUhCxpYprH8qwT4GzYwRimmmAEpuGUFpKoU0LopjVxwphqlTht9G/3tCWRVU0
         n5tejhe+JXOfsqmcG+KBWckJW3BmULoZMdcC+7A6pfnccVmLPesg418ifb64+LibWPZi
         HxHwuRD9d9f9a+E+Y7z2l+AG+bSaREIWpYoga3Wq3fsyGvOa1LMvG+7cL0xiUwtVn0Vt
         rUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713272591; x=1713877391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6q7NOzAqjEGHCoFf5Mh990/OZO+Hd3GsoPPU2va58A=;
        b=TVuCciy/oCnls2qvPSjYWh4Wqal71JyjlEfJ7hOID4HO4r9aT/wl56ihQPuyfz5emE
         xCpY/P5KKgBmpssgBMWxNvejVVKa5smdJKfB8lIrbulGKiZfbiGI+lkwmYCIQbNPCTvH
         wKhDJyXxph0vmmtLrKU9bVhijO5dVnOJAEchtz/LDbe+0hR52vNoycY2gRxvdpGTbbRI
         qVlxV8kDCVKVxtcFQ6uSDlfgvUjvoQpiGbcfNnOdDWeOlE2vB5G4B6ra5gn1bAwLzc3P
         z2YuAV0YM8vSfmawefJ0hrEVp7M59EvSQnZm1nOudSa9IgyVjm48u6zQudVRZX0UUda7
         XCXw==
X-Forwarded-Encrypted: i=1; AJvYcCU1PNIVrZtk1BGVpXBJ+UDGeHmS2WGY0PE81UsWYoJrcSJicHkxlUe765Qf6ulhVI+SGOOlKlbLNahDbvgpIJBvCQ6DfR/7HOZH7D27Ugw=
X-Gm-Message-State: AOJu0YwTHRx6cmJAcKbRp3YUN0eHAmHxbJSTNG1VW7FC1oyvEOOXGWBq
	/efR5CpmzsclKJZgTq79JwtkvyerWWT7otrLl2MMnGyPK7sGYSL1joMUft+uPRo=
X-Google-Smtp-Source: AGHT+IE43qjBRyIW7+rvy620e+DWtCVePv+9ozMyupytb5Sixra3d6zzt0fBg5YAaNnNdTW6D/PGkQ==
X-Received: by 2002:a05:600c:4fd6:b0:418:9dd2:fd04 with SMTP id o22-20020a05600c4fd600b004189dd2fd04mr1100873wmq.13.1713272591043;
        Tue, 16 Apr 2024 06:03:11 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id e22-20020a05600c4e5600b00418980a1ce5sm1987106wmq.7.2024.04.16.06.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 06:03:10 -0700 (PDT)
Date: Tue, 16 Apr 2024 15:03:09 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, parav@nvidia.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, shuah@kernel.org,
	petrm@nvidia.com, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
	bpoirier@nvidia.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next 0/6] selftests: virtio_net: introduce initial
 testing infrastructure
Message-ID: <Zh53DaJkqxPC4_ZX@nanopsycho>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412180428.35b83923@kernel.org>
 <ZhqHadH3G5kfGO8H@nanopsycho>
 <20240415102659.7f72ae8d@kernel.org>
 <Zh5Kn5OnDdzgB6Rm@nanopsycho>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh5Kn5OnDdzgB6Rm@nanopsycho>

Tue, Apr 16, 2024 at 11:53:35AM CEST, jiri@resnulli.us wrote:
>Mon, Apr 15, 2024 at 07:26:59PM CEST, kuba@kernel.org wrote:
>>On Sat, 13 Apr 2024 15:23:53 +0200 Jiri Pirko wrote:
>>> That is a goal. Currently I do it with:
>>> vng --qemu-opts="-nic tap,id=nd0,ifname=xtap0,model=virtio-net-pci,script=no,downscript=no,mac=52:54:00:12:34:57 -nic tap,id=nd1,ifname=xtap1,model=virtio-net-pci,script=no,downscript=no,mac=52:54:00:12:34:58"
>>> 
>>> and setting loop manually with tc-matchall-mirred
>>> 
>>> Implementing virtio loop instantiation in vng is on the todo list for
>>> this.
>>
>>Just to be clear - I think the loop configuration is better off outside
>>vng. It may need SUID and such. We just need to make vng spawn the two
>>interfaces with a less verbose syntax. --network-count 2 ?
>
>Well, you ask vng for network device by:
>--net=user/bridge
>
>Currently putting the option multiple times is ignored, but I don't see
>why that can't work.
>
>Regarding the loop configuration, I would like to make this as
>convenient for the user as possible, I was thinking about something like
>--net=loop which would create the tc-based loop.
>
>How to do this without root, I'm not sure. Perhaps something similar
>like qemu-bridge-helper could be used.

Ha, qemu knows how to solve this already:
       -netdev hubport,id=id,hubid=hubid[,netdev=nd]
              Create a hub port on the emulated hub with ID hubid.

              The hubport netdev lets you connect a NIC to a QEMU emulated hub
              instead of a single netdev. Alternatively, you can also  connect
              the  hubport to another netdev with ID nd by using the netdev=nd
              option.

I cooked-up a testing vng patch, so the user can pass "--net=loop":
https://github.com/arighi/virtme-ng/commit/84a26ba92c9834c09d16fc1a4dc3a69c4d758236


