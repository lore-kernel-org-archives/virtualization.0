Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858138;
	b=XV696zk26PI5DFbRXAErYNLmdwD8ZrUuwgQkoCvii2AbVWOTl/PEMpt/dkiIShzdXU3M
	 DK/t+H52Y8AGXuQEGPObo/0s5QO3aSiN5lROc6vs0HPAyjG9ulXWC7JeWponyHkmLDviM
	 MGP6SrHhuQPGPwu183nvaDG80FWJ1AIOTXjri7G+sGGOsm66Smn+NR+wi+4pK49C4Fjhr
	 nc1Mwn8v1KEJYHFTKil5Fie5IWAzLUy9FLw9vsDOMxKHiE4rGOzwUJ0qcWky/VEndOz56
	 RIg3TWi4AhcNIAc4zm53wOgJbJvMcnVU0YmhCIoIhev7dumjN6DIJSwthNtUvtBd41A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jqgo1XywgsdgGPVlo0B4zN6yPIeNTL0VXgREkra6lSU=;
	b=r65lBZVPqBZ6cz71E7L1O/85v9nzJb18tmCj7B2Brtyxt4fGkqCuCDYGeKrjhgBVIb5l
	 Rsu+5P5TXQOp/CSTZcQuYAZEu9qjUnVtwA9t6cUdntvrz0yl6/6vTyBGxhqM5yFBpNlTO
	 HpnBav4/4wwFJQRTdyo02XEvYpZUNAiTS0/BFVXyUHsbMI1rSA2ceHntXdJfN0pfthWZT
	 OoRYbImh4c/DlSwLBBMmxJeey11Cx8LRC3VveQIT2cqYsKp1tNMcuPYb8P08xbgrM0SpQ
	 VFRZP2bfyRHczzmVFmcE9ewCUrMlyfXKWMAu3BTX16/i82aUL7m4L244k2UXVxteQ3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s4JG3Agl;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD77606A31A
	for <virtualization@lists.linux.dev>; Sat, 24 Oct 2026 16:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDD77606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s4JG3Agl
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eac9db5905so639350e0c.0
        for <virtualization@lists.linux.dev>; Sat, 24 Oct 2026 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792858137; x=1793462937; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jqgo1XywgsdgGPVlo0B4zN6yPIeNTL0VXgREkra6lSU=;
        b=s4JG3AglIKSQT5QblxR1lsbH3WMWu3I4Yat6zc0iWTPR+Ez23QFl4XYsaLywGDMTDS
         Ohh8DEjjiSslbMF5ey7xxyWAVXRkEiClF1aluUu/jVYlJS7x/E3wAjkNh1Td2CBNoSBU
         e8gmPLIhPm5qOmqPoBPKVXIHmuQVIPEHl+fkhVOm83fCc8+0fQzy4yhK/h84l5EenDXZ
         O7HD+olA4Sv6Tt0jy2IGKg/F9fLYsjR/C4/zumiDEMWanUtbzJsVK5NfMeUz5YMziB3Y
         ikXlBbcOz3VNMNRZg1jx82pGmmFCEn6RNK8g+8hixljvt5tmEu//zRKTgO9IwfYQM3On
         gGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792858137; x=1793462937;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jqgo1XywgsdgGPVlo0B4zN6yPIeNTL0VXgREkra6lSU=;
        b=aY2hBqRV/O7sjjMzj8+kBatG4/rUvkzrdcBRtnnyZhJ1XgCgdaaffMkxKhcRqQyaLl
         hlB6oKt9SDFvqu8hwJwoAYcE1MwZBz/LBvYmQZvXyHccsrBlA5vKiM/3YiBFt+BDV7Sn
         6S+7KkishkIO1lYx4B8QBRK12JaqjMcuXP3fV3lMzT1B23rtBXEGe6n+G5twpaqXcIdF
         nTnpvkvCb/iDdE+aLLqdZeKfKGmf1HfmbJBjoMeEhD8xBz7UKevUqdhMGHLpGHhNsIPW
         PdyhrhKPzfHNKHGgaz2SynUb1wIqd5SZ2XKnA1lbGSaij0BNLrXdRvpuNSECDTiGZ/C8
         sp6w==
X-Forwarded-Encrypted: i=1; AKwUvBwyRZybg2rmO96sT3SZZO70ZC4GkbyDyj05BvvkrTBkmRd+X0rJi+dQQ/qKFn8SB6xEQvxEpMHOMGKiS6AGeA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKfzEi3ZQHMlPlHCRp4nhYx9YG4NJ5ZJvYeNOuVEP6K/gJrJZJJ
	QvnBiMoEZ8mRNgCkx3kjfuB7rMiWnGBOx2+jW1d6H0/oCpKmYksKj9Yu
X-Gm-Gg: AYBFou2Gignbgn/0K10JWx0QfkMbCL0hbj2keaMFKonl4B5JubX44VhrqkaWalm1b5o
	YPgs62hb3mZ/GZwaJ9Dyz1G3sPLXKvz7K0QoEmiXIvICnNFzcPnab9PekkVWQ2aw/bZMCFpyLvP
	tk545UZkqmw8ycrdytOp2sLLO28UG4OVNMHP0Lnsjo0jt1bvfYtV8POb9dqoMG/bf6NAiZSxkqR
	YAvxv1L8ufnWaUQi54tj1jU1kKUuEnKOuHQYKNP93eKsI9NFg1QfsDGZ8PRReqpMV4CgZcmrHj1
	pO+gm0yjO9IFtcCw/jxCLR2lzXsRgVqg1r41Q/OTUzhUTRqcrpd7JWtdRcxGt+cwm7S51IQOVaC
	2HpT8vhhOa59vPC3qlxedY3KWxaWE8P7rwpHHkUCX0e0j5UmsidIAAtybsGaNbv2+CyoIcOYRx1
	2rT+3VMrXcN0vfTJizSyS/Ghw+HHK8kAUsZAx+39mM1lPd6LPNXwgTICwc6EExjQoHH5AZYSBa7
	G+6lwq2e9iste7RURjUReVRJzaOP1SiXhwS5Lh0KdEzKu5l7VKXoZwClTYqXtpqHfDsigg2rGvB
	k726g/i5lQVV4S6ig9/2uAerI7z+9zbjIiVFiQCtRG312XHUS2pSP0l30LiXWcm8Qh06RA/vOA9
	8gpMSuobL+zcm0O+kmlb8IHOWBlmue+MAKFT3pVsY
X-Received: by 2002:a05:6122:1c07:b0:5ea:a1ad:6376 with SMTP id 71dfb90a1353d-5ec230a26b8mr706060e0c.1.1792858136874;
        Sat, 24 Oct 2026 09:08:56 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec234277b8sm2521988e0c.8.2026.10.24.09.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 09:08:56 -0700 (PDT)
Date: Sat, 24 Oct 2026 12:08:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Chris Arges <carges@cloudflare.com>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Phil Sutter <phil@nwl.cc>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Rusty Russell <rusty@rustcorp.com.au>
Message-ID: <willemdebruijn.kernel.288f04be304a@gmail.com>
In-Reply-To: <20261024113809-mutt-send-email-mst@kernel.org>
References: <cover.1792768096.git.mst@redhat.com>
 <20261024113809-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH net v6 0/5] more virtio-net csum hardening
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> On Fri, Oct 23, 2026 at 11:09:17AM -0400, Michael S. Tsirkin wrote:
> > 
> > Okay this seems to be converging.... But sashiko did find some issues I
> > thought are best fixed. Specifically I thought of a better way to handle
> > short gso in a tunnel - just clear tunnel gso! As a side effect we now
> > fix up the checksum for these dodgy packets like we did before, instead
> > of a drop. Good. And more false positives that prompted me to write a
> > bit more comments. So here goes.
> > 
> > Apologies for reposting so frequently, I know netdev bot will be unhappy
> > with that.  But Paulos's report made a lot of publicity, there is a lot
> > of people looking into this, so I feel there's value in defending
> > against all this class of issues sooner rather than later.
> > 
> > The issues were mostly found by code inspection, but all reproduced by
> > me in a VM.
> 
> Ugh. I found another wrinkle( Firewalls that shape the payload.
> They are currently seem to simply be hoping most traffic is CHECKSUM_PARTIAL and
> only looking at that, and that will break.
> 
> I am not sure what to do yet. Extending the sysctl knob to control what
> happens if validation fails: pass/drop/complete - is the best I could
> come up with. Or ignore the issue. Or just forget the complete at input hack
> and drop if we can't figure it out.

Sounds like such users will just have to disable the sysctl for now: pass.

And update their firewall, then reenable the sysctl?

Does adding a third drop option help in any way? The sysctl is the safety
valve to go back to old behavior.
