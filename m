Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B2941C84
	for <virtualization@lists.linux.dev>; Wed, 15 May 2024 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758458; cv=none; b=uqbryRhcBjgvhDY8D2pKibRzBvC6FRND6fwdIEy9wWBxjQUbZ4Sa8yIBtM9lSyqtSEwjO9QWn87IB8hnAccN0z2fbJqwhC1Y1fXMi4juq3YTXIW+0JaIlNI64fiM+3ihADjie38dno/x18dK8YfqmCC9dsBye3O3zNwKNlkt5AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758458; c=relaxed/simple;
	bh=QrPNpXvWtBe6xHxCSukZbnvU65TQ0fHmMLbaLO3xAOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfVIhTuBj/CtJS8gCIwo1pwD3hmCUBRlUMBzMlXn9BVOmEykHbhCMfFHfDSdZWNQ4N8oI+hT6PhWupqnCRZVPyYDpRQTJhgm7K3C34C9Cz+2k5sN07oSEWxwaDVy7A7YNmCjpTI/k3bKp5QqaElkjBMG2NK3zfs8OHwC9DNMoz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=P5+QFomu; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="P5+QFomu"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e0b2ddc5d1so94595051fa.3
        for <virtualization@lists.linux.dev>; Wed, 15 May 2024 00:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715758454; x=1716363254; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kD8/1Qg80X1Lu2w9XeEJiUVipNk99bLcKl/O4FD4s+U=;
        b=P5+QFomuxgiw1Y8dh4PO/4Dj6QFAk1K7PoHnem2Rub4Ap8tE4NTNWGxJWR5X1SDhQf
         xGjD19/PQxnkwf5Kd6r44nPzwTbPCl/caRvFSMgOiRCSXCVTdboNPAmNUnRZ0yJIJsIv
         9M1epMI/LNcWtP4bOnvLtBx1ob/Rt/KtPuhl6JNILJZCJ5vdJA/d5MAjITHI/kKh0Kbf
         Wtdf1j9qnihZd/pKwpI6zr5U1MsSalwDwbjbkU+BfL0lq2GApQJtlI3NCzhTQhuOaqiI
         1vLeeoBbG25tgF3AypCkLvtZXqEkNG9h7spfyITPIS9ZChLd3WjPSSjayPx5e2QvWvDY
         AQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715758454; x=1716363254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kD8/1Qg80X1Lu2w9XeEJiUVipNk99bLcKl/O4FD4s+U=;
        b=SpG6Un1LWdhbiqNZBw5MAl2SmpDHl+ElWiH2r9PIgB/Knpg+SaLHuz93MxB7Z56X0v
         WQx/G8wnN/s47SL2qHIvV3EANqFJ4VwGePJidQwOZ22sB7lkj8DrC+L2fCLnRwMIX7PM
         ocPhoqCc/6HO5zp88N/J82+Y0GkekCDQuud4F7wj/Jbv9YcRdsz0aDoAL+Jq4JdiEhdQ
         6tjF+EILN/K0fA4/Cuz0foju7xYDchim8cFvl6zqvaVSXC7f+PfPY1tensnJdjtHtC0E
         goNT+xX2J7a0gso9wY7NmUA033F5h6ZkV4tFZxqJOWCqHHkEJMv0ce6VAIRaLOEELVuG
         3pcw==
X-Forwarded-Encrypted: i=1; AJvYcCXJVYE3svQcUEFSoXPwHdBO7Ol/ALac1jjzUTpxn9qPN17jikyBCJbBAn+jTBC1e7seIghJeTClwGNP/YJc2UsqWnhazY9ZGNudZt1Itmg=
X-Gm-Message-State: AOJu0YzVG37byisq8vFF/ZYk292BVMNUcBeT1mtKE4g0SGI9ZvyR/tRm
	+izbhYIpu6/HjjcypXreIjoAl6BXBv78cDSqJjZE1ypXBEtbmjgj9yoEnSG5tdE=
X-Google-Smtp-Source: AGHT+IGqKKl0cYTL0wrQzzLOxVpGGYXpsmUrxwQj9LAhg/ZB7zM77qtac7G3ooq+SI3f8B3O1F/AWg==
X-Received: by 2002:a2e:a98a:0:b0:2e6:f769:5124 with SMTP id 38308e7fff4ca-2e6f769532emr7988691fa.39.1715758453984;
        Wed, 15 May 2024 00:34:13 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8f8asm222070475e9.10.2024.05.15.00.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:34:12 -0700 (PDT)
Date: Wed, 15 May 2024 09:34:08 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZkRlcBU0Nb3O-Kg1@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
 <20240509102643-mutt-send-email-mst@kernel.org>
 <Zj3425_gSqHByw-R@nanopsycho.orion>
 <20240510065121-mutt-send-email-mst@kernel.org>
 <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
 <20240510072431-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510072431-mutt-send-email-mst@kernel.org>

Fri, May 10, 2024 at 01:27:08PM CEST, mst@redhat.com wrote:
>On Fri, May 10, 2024 at 01:11:49PM +0200, Jiri Pirko wrote:
>> Fri, May 10, 2024 at 12:52:52PM CEST, mst@redhat.com wrote:
>> >On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
>> >> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
>> >> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
>> >> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
>> >> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
>> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> >> >> 
>> >> >> >> Add support for Byte Queue Limits (BQL).
>> >> >> >> 
>> >> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> >> >
>> >> >> >Can we get more detail on the benefits you observe etc?
>> >> >> >Thanks!
>> >> >> 
>> >> >> More info about the BQL in general is here:
>> >> >> https://lwn.net/Articles/469652/
>> >> >
>> >> >I know about BQL in general. We discussed BQL for virtio in the past
>> >> >mostly I got the feedback from net core maintainers that it likely won't
>> >> >benefit virtio.
>> >> 
>> >> Do you have some link to that, or is it this thread:
>> >> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
>> >
>> >
>> >A quick search on lore turned up this, for example:
>> >https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com/
>> 
>> Says:
>> "Note that NIC with many TX queues make BQL almost useless, only adding extra
>>  overhead."
>> 
>> But virtio can have one tx queue, I guess that could be quite common
>> configuration in lot of deployments.
>
>Not sure we should worry about performance for these though.
>What I am saying is this should come with some benchmarking
>results.

I did some measurements with VDPA, backed by ConnectX6dx NIC, single
queue pair:

super_netperf 200 -H $ip -l 45 -t TCP_STREAM &
nice -n 20 netperf -H $ip -l 10 -t TCP_RR

RR result with no bql:
29.95
32.74
28.77

RR result with bql:
222.98
159.81
197.88



>
>
>> 
>> >
>> >
>> >
>> >
>> >> I don't see why virtio should be any different from other
>> >> drivers/devices that benefit from bql. HOL blocking is the same here are
>> >> everywhere.
>> >> 
>> >> >
>> >> >So I'm asking, what kind of benefit do you observe?
>> >> 
>> >> I don't have measurements at hand, will attach them to v2.
>> >> 
>> >> Thanks!
>> >> 
>> >> >
>> >> >-- 
>> >> >MST
>> >> >
>> >
>
