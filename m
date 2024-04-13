Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5551E49E
	for <virtualization@lists.linux.dev>; Sat, 13 Apr 2024 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713014639; cv=none; b=SbkWfR/S6rcZ9dg3fLIlAC+TKFOX6P0BVZ4Q8NqV0dkVJnT3I1P07ZBpi85/1pZFqXU47NcQVNjGt6IGP2nJpDv753PXouEfIyXQyQOG5a6DWbbP8vGQRT1BoFMsudgSZAJI3We4EkX9TbU3sPcgE6Wn3tPTKzIOYwRtAsOl3/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713014639; c=relaxed/simple;
	bh=SRCIyPNQ6adFujDBz3DDPId6nlqW8ilRvRvNjMce8P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRkQSznE8cIbYBNdsF0E1aHCbWb8vAKMSXVmWwekmBCH3J+r1ZX1HnjmXSBgM/8lGk+LgKb8CTBE7A/TOFUCUsRwsT21JNruM8FkfwvaR1ASE5Hl546mGhajNS1Xqy1aHoDRSBs9jdzZG6oaFiFecq4QQocpcgS80z08ikhYvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=pfCfZEvV; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pfCfZEvV"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so2184368e87.2
        for <virtualization@lists.linux.dev>; Sat, 13 Apr 2024 06:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713014636; x=1713619436; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tNdapE51xDmYzRf4qXGuO2j+5WX8I40uaybU2UWwKxo=;
        b=pfCfZEvVZ5IqkaEe2dWrPxmD/nXgDihiHZcYR1ajyQAYnWVDu4HfJaQKO692AXxIww
         /lfhXbc8ME8wbeLWAzZ9Ff1q4cmmFEiL8APf0PntdXxFjMIYPdLxwVSYnOD7ryhG+quN
         l/0btjhhWFpPVzUqlh8u2VaYdvJMPitBLVcGZgoOjOhB/tptCJWXi+kH5Ls/fPqkpTmg
         G6nCYZFAiqCQumLoAsQaTLjwcZY0SUfvDHG++WQOBFlL3WwNCDFmQp0GDx3ebY+v8iLW
         JGHKix7kvlLvYQ8mqI27/TNPAnPYTlD+gecCWMEy5+46RdntXTz3Lj+XfJgIiCEXQZBp
         sF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713014636; x=1713619436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNdapE51xDmYzRf4qXGuO2j+5WX8I40uaybU2UWwKxo=;
        b=cPQ2N0oQYuSJxTqXo8SS5bdBloGfDHuGiX8cFHcuWuiC/wyIC4TfOoZqbb0u1Q/yWb
         1wvn8ss7Ie40Y4MekrjdMQcedpcmyAwcEfPC44m/o/n5PUU5mFw+et1hP9B5bFzVTDX4
         8vbqOEhOOj5hWZxXU6mn24Y2Il3uK0nGglT9L70gry49nl/zUip63H6A33UzLX3X6Swv
         yJ6uHUoGhIvYhhi61JqDjqPWpXnuPS+opF0ZfKZWcxB1x6ZRXnWAbWjxd+SbwiRSGCic
         VBcfbkLn4NIa6Kw4baDWR0xpIm8ETkdiS/TViwgJT7MrzljWn+U7z3FEnZbxneR97PEM
         uriQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoVDRI5y9/ozkato0AZGGVLc6IGpC0fAX4lKVE3elcwZ8nhS23wevhvz0kBQ7njkB/7juxfnmOPqCepoKg4UBSWtW5+rszX43m2X1Qzl8=
X-Gm-Message-State: AOJu0YyUag6n4Bpy73cq7kkWX93f+gMDhVqWWo9sHG6SIc4iUih0n/u7
	F1UuGcLSjgMkZWp/WTZaP/NeRrRonITdaD740LndNxUaIMLduOwege5KKI3Ut+M=
X-Google-Smtp-Source: AGHT+IFELlF2VPV1SnAO8TXfTkNK2OpqLn5CbLd1/1gUGn1Mm7hVFcBg61m0MFKlCcx24mPPnIJjQQ==
X-Received: by 2002:a05:6512:1327:b0:513:d08b:3790 with SMTP id x39-20020a056512132700b00513d08b3790mr3822688lfu.49.1713014636011;
        Sat, 13 Apr 2024 06:23:56 -0700 (PDT)
Received: from localhost (37-48-0-252.nat.epc.tmcz.cz. [37.48.0.252])
        by smtp.gmail.com with ESMTPSA id cn22-20020a0564020cb600b0056e34297cbasm2643255edb.80.2024.04.13.06.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 06:23:55 -0700 (PDT)
Date: Sat, 13 Apr 2024 15:23:53 +0200
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
Message-ID: <ZhqHadH3G5kfGO8H@nanopsycho>
References: <20240412151314.3365034-1-jiri@resnulli.us>
 <20240412180428.35b83923@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412180428.35b83923@kernel.org>

Sat, Apr 13, 2024 at 03:04:28AM CEST, kuba@kernel.org wrote:
>On Fri, 12 Apr 2024 17:13:08 +0200 Jiri Pirko wrote:
>> This patchset aims at introducing very basic initial infrastructure
>> for virtio_net testing, namely it focuses on virtio feature testing.
>> 
>> The first patch adds support for debugfs for virtio devices, allowing
>> user to filter features to pretend to be driver that is not capable
>> of the filtered feature.
>
>Two trivial points: MAINTAINERS should probably be updated to bestow
>the responsibility over these to virtio folks; there should probably
>be a config file. Admittedly anyone testing in a VM should have VIRTIO
>and anyone not in a VM won't test this... but it's a good practice.

Sure, will add these 2.


>
>Did you investigate how hard it would be to make virtme-ng pop out
>two virtio interfaces?  It's a pretty hackable Python code base and
>Andrea is very responsive so would be nice to get that done. And then
>its trivial to run those in our CI.

That is a goal. Currently I do it with:
vng --qemu-opts="-nic tap,id=nd0,ifname=xtap0,model=virtio-net-pci,script=no,downscript=no,mac=52:54:00:12:34:57 -nic tap,id=nd1,ifname=xtap1,model=virtio-net-pci,script=no,downscript=no,mac=52:54:00:12:34:58"

and setting loop manually with tc-matchall-mirred

Implementing virtio loop instantiation in vng is on the todo list for
this.
