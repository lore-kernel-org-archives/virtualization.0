Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765DC329C57
	for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763152364; cv=none; b=ZctFAgE1w1ty7Bx2J3hwjsxeb5W5EauvSkqimA72vR1kravR4mvbeZ0xBSmfUTap0WdLMktIjktQ18H1mG+z0vGGZmhDGCk9Gt+YkWK1SjfPQCoL8fNxpFogb0Ra2YD6G2WxRsr1cAJEJt/hPuDQNhjyd7/KcldhNNYI6kcZamE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763152364; c=relaxed/simple;
	bh=qMVXn0/pBxfD94D7ztw7lMcKOUUwJxhPmOMbkqfJm7c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cW3oFCq7WbT5vX+CwoqsNuPGMloe+fV7UW89qKk3wr6rKVgLK1UH5pHQ/hkaAtM3HtPb00pV15Rv8dJjK6FKj8tip9vH4VFtU0qtXat8i7uTzctcUyOq7iG/9mjmcDQJfzdDuwi1yoDWuzXXKkxQcejfUre3B1cPjxlXnMI77og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGPBwcxp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGPBwcxp"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47117f92e32so20453535e9.1
        for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 12:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763152361; x=1763757161; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wB/JsODbft6bUwFY61gbtF9VSesiLo/SIsj+xEcELmM=;
        b=kGPBwcxpbJepgsbLQwdLii6wu6LhtIfFKdoww2PCxv37XLgoORPnUGaboXsdahU7nS
         9AnjHJXcIC0t6KiBO7kFKx43WeLVrFxRKbcB2jtZs4n8jlndQD0moBKcw3p9D8u6Mni/
         UVLxktgZj2LgZOGd3WudbcJ8akf+0YGt0cb+DuIJiIwbLvXoWgfyP1vojXyWQ+AbVCJd
         1Ohv8xiyLAcybH6z5dmQ4LbJEU99AIAD55QNV+oTLkBiOHxQl/2f1aWv3Oq5Kodwp1Uf
         DQsgJqM9Y7mMJLRvidGU1cU0qgtR6Scmu+fZ+dxqXFu0p/1dM2ELXtoTgmI419M9YorU
         fx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763152361; x=1763757161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wB/JsODbft6bUwFY61gbtF9VSesiLo/SIsj+xEcELmM=;
        b=v+Shrpsw+axKFVY3qK/lVcZlxhd6mBzMhe2ZYiHeR11Z57qob4o23gHowpz8199wn6
         g+o8t5IWsWQIwkEeQXHH3Je4Ndaw444I3u2OxDbCBxhuyrDDLIcBnD8oQJ5cCi/TzsJB
         UqMn6vqLifEn59EPUyaCSGk5iSHFO5p6QjjSGZSJIaVx5Eg45J72aaf5VeMXGiIaAzHU
         CpvYQVlo7NUCcSSd+xDWaFnx6HR7Lj6avAjf1BsFR8eP6jruBy5RY2fqhCIOQCaz4PaA
         MPk8pLZ1mjv1gnw1QoVfDD9QpbuNLmO8OU+MCRKKVB20Hm/JodAkn2LEmqcHKfGgzi45
         uTCA==
X-Forwarded-Encrypted: i=1; AJvYcCVjOViwAYF0Dms2nhEpV/OjOstClc8uxLB6ecSyTYniL77XMFQP6UzgsQrlg+IMd48+GpRpzYUQZRShcZrc3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNAha8pdbXz76nuStm7xwXsRlMYACyjbzSd7JJiFk5b9EvewN1
	DVB7gKH6FFSujhCF+RS4n6IzFgalaIx84APShZBTtxPHsGWQewj8cNLB
X-Gm-Gg: ASbGncs1rpk06lsj9AP5Mocj6OjiCUbfkR0yBCOurD8GQi0/SUhiLutoT3nYKNc/3CG
	g79+GElPKIjABVcUgEJRjnYhkYxjbonzRwSFlqxkgS2tOQmb1b5UWAZGDimscPEqT+JOBo+/rEf
	kmd7vuImU+fOVFJ6Uu+FutV9kh+0ZeupijY/F4ojzFmNprOy4M8o/YS9oXy+1ZrUrRs3gVR2TGU
	/v7kw5pfL9nlDtY0pj/zZQfkxHSWET9dDYRZRLwEKimIgm6cymOhgRnR5LptLmUotYgzYCdTMpW
	NewUZ3WmNXHP9qs0fqOi3YbfHL1+kug5aHwzfSy6RnrvdZ0nyYoAwFB3btKPYeX39mK/6JnNh6y
	INtPmUL65WpUW2YSQ6d74/RlAHcEDbTrGmCVHE6WuYRWorFpPSFAZSbCxN1ywiju35lJR62QnSe
	bFTP3X/sqHa/Sz87nqWymJAk1xBYYx5SOSsDBsTcV0Q56Q0+ztfvLv
X-Google-Smtp-Source: AGHT+IGJLwKUUv/e7XeLeB5KiDfpWDJD0SeEvFpkKuz3Fu0ygR96nzPtknGu6NvJHta64Jve5dWi4Q==
X-Received: by 2002:a05:600c:35c1:b0:477:54f9:6ac2 with SMTP id 5b1f17b1804b1-4778fe1170fmr49088345e9.0.1763152360456;
        Fri, 14 Nov 2025 12:32:40 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bb2f9c8sm54699595e9.1.2025.11.14.12.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 12:32:40 -0800 (PST)
Date: Fri, 14 Nov 2025 20:32:38 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jon Kohler <jon@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "virtualization@lists.linux.dev"
 <virtualization@lists.linux.dev>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Sean
 Christopherson <seanjc@google.com>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user()
 and put_user()
Message-ID: <20251114203238.51123933@pumpkin>
In-Reply-To: <2CD22CA1-FAFA-493A-8F41-A5798C33D103@nutanix.com>
References: <20251113005529.2494066-1-jon@nutanix.com>
	<20251114185424.354133ae@pumpkin>
	<2CD22CA1-FAFA-493A-8F41-A5798C33D103@nutanix.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Nov 2025 19:30:32 +0000
Jon Kohler <jon@nutanix.com> wrote:

> > On Nov 14, 2025, at 1:54=E2=80=AFPM, David Laight <david.laight.linux@g=
mail.com> wrote:
> >=20
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> >=20
> > |-------------------------------------------------------------------!
> >=20
> > On Wed, 12 Nov 2025 17:55:28 -0700
> > Jon Kohler <jon@nutanix.com> wrote:
> >  =20
> >> vhost_get_user and vhost_put_user leverage __get_user and __put_user,
> >> respectively, which were both added in 2016 by commit 6b1e6cc7855b
> >> ("vhost: new device IOTLB API"). In a heavy UDP transmit workload on a
> >> vhost-net backed tap device, these functions showed up as ~11.6% of
> >> samples in a flamegraph of the underlying vhost worker thread.
> >>=20
> >> Quoting Linus from [1]:
> >>    Anyway, every single __get_user() call I looked at looked like
> >>    historical garbage. [...] End result: I get the feeling that we
> >>    should just do a global search-and-replace of the __get_user/
> >>    __put_user users, replace them with plain get_user/put_user instead,
> >>    and then fix up any fallout (eg the coco code).
> >>=20
> >> Switch to plain get_user/put_user in vhost, which results in a slight
> >> throughput speedup. get_user now about ~8.4% of samples in flamegraph.
> >>=20
> >> Basic iperf3 test on a Intel 5416S CPU with Ubuntu 25.10 guest:
> >> TX: taskset -c 2 iperf3 -c <rx_ip> -t 60 -p 5200 -b 0 -u -i 5
> >> RX: taskset -c 2 iperf3 -s -p 5200 -D
> >> Before: 6.08 Gbits/sec
> >> After:  6.32 Gbits/sec
> >>=20
> >> As to what drives the speedup, Sean's patch [2] explains:
> >> Use the normal, checked versions for get_user() and put_user() instead=
 of
> >> the double-underscore versions that omit range checks, as the checked
> >> versions are actually measurably faster on modern CPUs (12%+ on Intel,
> >> 25%+ on AMD). =20
> >=20
> > Is there an associated access_ok() that can also be removed?
> >=20
> > David =20
>=20
> Hey David - IIUC, the access_ok() for non-iotlb setups is done at
> initial setup time, not per event, see vhost_vring_set_addr and
> for the vhost net side see vhost_net_set_backend ->=20
> vhost_vq_access_ok.

This is a long way away from the actual access....

The early 'sanity check' might be worth keeping, but the code has to
allow for the user access faulting (the application might unmap it).
But, in some sense, that early check is optimising for the user passing
in an invalid buffer - so not actually worth while,

> Will lean on MST/Jason to help sanity check my understanding.
>=20
> In the iotlb case, that=E2=80=99s handled differently (Jason can speak to
> that side), but I dont think there is something we=E2=80=99d remove there?

Isn't the application side much the same?
(But I don't know what the code is doing...)

	David

