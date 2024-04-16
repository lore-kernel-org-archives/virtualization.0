Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0E6127B52
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261221; cv=none; b=anUbGLENAfhEMoCoLhyGttFeV2MSiZQjtQhMwm8Gq1mHrqUlkL+lh2/RG4dkDIIOzRo/EhyAe8mBWkx+k1YuyUoOTGjRXwYeFDcTshqF04x5weGAo8PXqHyc0qj8TsiJ1irgat7UKNCzTwo94iIBQWbioB+Q8dY3arj63h/udzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261221; c=relaxed/simple;
	bh=iIEonw6NbxRylvPksI0bLcfKTL65JpeWOssN5KniBYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8RUl1wTqY2AGKCjuy+MMj8Qm97xoQbIUGK7GNnl0gTBleb3a0X2pa3ZddBfyQyuRm/eWq/zDfYo8X2mdxkfXXtkSVEdrdbh1PpBl7TAqW69Tzr0o2w2Ojdc/w3cbD/JFbsPYnTNEdhlk+ilxvzJk9H2ZWSuNmTXhHDZ+50KhTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=tW7GKk1a; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tW7GKk1a"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso4102023a12.3
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 02:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713261219; x=1713866019; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xyOljcBoxRZtBlXPwq1twMKjVMaHbywxijMJdFOzxMA=;
        b=tW7GKk1aNec/InaYUyDtOf1OfgKtO/OpC2geO9Tt4CgQ4bH6HeOwnoAhyyTwKMwXqi
         WLcjfDr2D+g/wLesBsBD2vZXgFqIH9cQLJb03qIHUT0o73jWpfBRFCbNmMDaJc48Sqpp
         0DFCHiqcr1iLWZXC8G5bi+0pCABw9WP1D8CLfwBbEDSxnfUpOqUhYOW9hBcL0iO/w838
         oOzvxqMGEfwZYM2Gv1c0A5JEM6/6CIAKsBBlU3rhHWgKtqVr4oCcF6Q8E91etEoGCV74
         gi+ooOX8RKvUb2109ZIa7YC1it7vxzqCCb3VmHJzJ9dDKx8+UwP44pyIrPcY/GhELeQE
         9Dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261219; x=1713866019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyOljcBoxRZtBlXPwq1twMKjVMaHbywxijMJdFOzxMA=;
        b=rAzR+nHsE08wqdkqy0+Yj3h2Hxs3tX1oVi+4Cvr62OO7pR9LOnKz7GggYkTySain2D
         yGYaszjjpmRkOHD3GA0rfzDGTRWQEyqWvmHT3BxYxzBnRSXD7g8CZ4RqsmNP0YgE3aAg
         C5kAcN1B2F6ItZyH8FIj2sKkLXUy97jF6Vd427TFb8ZfVjRSUSucyNsDpTkN4nBmoPi9
         YQsr8l23qXKHZr0DcpiFbLQJH1J2tyvxsVZxwdSr0dph9hrincJdZFeCskG17H01f+YW
         pbelPGjuC2+siW835XUDLkJQmuJ/I99MOnm7rxXX/cAtbUWWxDId/jNesUnT1dRQcQ1d
         lEYw==
X-Forwarded-Encrypted: i=1; AJvYcCXqIOprFRsmCaK7MF2cmV/oDfg7EpWi5loVXGoNHjqauUqk5Zrys5YBXj3q8D9LySTMlz3wORqSwvoCrDh50pvHUgzBfROZ94giNzie2/Y=
X-Gm-Message-State: AOJu0YxEgLG/JPLa5QQ5a0DXqtlzJiPMycB4DXTWMyRM12KtpUD2MIMW
	Ol9sW4QbBFAtO1g6nlNVGeoIHA+rkXzwsjWVvUeerOrSso61Txwp9yRAEMq4cVY=
X-Google-Smtp-Source: AGHT+IGPXttzg9aeuCAj6911eurDwuoGohgiWyCghHh4Uj9hzK08/0+nOrj6kSaE/gRrPbhckX7Srw==
X-Received: by 2002:a50:cd5b:0:b0:56e:d9e:f4d3 with SMTP id d27-20020a50cd5b000000b0056e0d9ef4d3mr10605693edj.18.1713261218408;
        Tue, 16 Apr 2024 02:53:38 -0700 (PDT)
Received: from localhost (37-48-42-173.nat.epc.tmcz.cz. [37.48.42.173])
        by smtp.gmail.com with ESMTPSA id ew14-20020a056402538e00b0056fe8f3eec6sm5678489edb.62.2024.04.16.02.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 02:53:37 -0700 (PDT)
Date: Tue, 16 Apr 2024 11:53:35 +0200
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
Message-ID: <Zh5Kn5OnDdzgB6Rm@nanopsycho>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412180428.35b83923@kernel.org>
 <ZhqHadH3G5kfGO8H@nanopsycho>
 <20240415102659.7f72ae8d@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415102659.7f72ae8d@kernel.org>

Mon, Apr 15, 2024 at 07:26:59PM CEST, kuba@kernel.org wrote:
>On Sat, 13 Apr 2024 15:23:53 +0200 Jiri Pirko wrote:
>> That is a goal. Currently I do it with:
>> vng --qemu-opts="-nic tap,id=nd0,ifname=xtap0,model=virtio-net-pci,script=no,downscript=no,mac=52:54:00:12:34:57 -nic tap,id=nd1,ifname=xtap1,model=virtio-net-pci,script=no,downscript=no,mac=52:54:00:12:34:58"
>> 
>> and setting loop manually with tc-matchall-mirred
>> 
>> Implementing virtio loop instantiation in vng is on the todo list for
>> this.
>
>Just to be clear - I think the loop configuration is better off outside
>vng. It may need SUID and such. We just need to make vng spawn the two
>interfaces with a less verbose syntax. --network-count 2 ?

Well, you ask vng for network device by:
--net=user/bridge

Currently putting the option multiple times is ignored, but I don't see
why that can't work.

Regarding the loop configuration, I would like to make this as
convenient for the user as possible, I was thinking about something like
--net=loop which would create the tc-based loop.

How to do this without root, I'm not sure. Perhaps something similar
like qemu-bridge-helper could be used.
