Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164192DF147
	for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763146469; cv=none; b=Fj5HQpb6XsprSjUHZsw20azrI5eY2ezyNxn/KAAEhvqMMGCZmoPqUjuMoroIBg0Kz9Du4IngDuW6ycw6uHOW37Kma391o4yBR0OcAXn122OPi7ZlZlK8H1S2eNLakKI22Lt7HoMwpz9PhHq72EXFqhEios0wrxdnCPaV/IKzyww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763146469; c=relaxed/simple;
	bh=WupAXsUwOqm9N8aItz9IuraBGtbt6+1ogwOCXXBfEo8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3wVb/FcGCDX3mw+nIrXF9AM/QJ9GsecJ3sZUiJR4iI34ErSV0RmKNaYIT9Fki0tZ8T8sq7S3yd//di8yxbsTw2g97TCxqPExS6iIm45zGtHiUILicgwV4FObYIK8FvDrl41WRmijHSHc2TmfAnf+d+wuXBRCI8sGhu0zzPgVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fB2xp50B; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fB2xp50B"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47774d3536dso20353985e9.0
        for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 10:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763146466; x=1763751266; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=su/3DTeyEOfiuZEhYMJ4B5Ixwohi82QW36MCAtfZ6Mw=;
        b=fB2xp50BY6k3lfM+iCnvEJhFs2Hm2xHDbTyv0iY2XF+NUh4hNH8Wr/piiljyGhgwfb
         Oq8trZb+r3gSiNAlM/Me4/oKAyOL9WYtZFNEqjOi801p/gj0qx8HjnTkNUMvp8qp5lll
         TgSplCi0l5Dl/ApWL9zJDG5U0TTUReMo1lz5nAR0qvuyKuj+Cc54DNzApPJyJLU6ZUyH
         BblvlH1Q+dGOm4f+5gaCv2IIqpB/wcs9Ra6BdLoJmB+ZFTvb1M3LLAuUvGF2KejBtDwq
         yIgehee1+0BW6iaVdjKieeFIlFnarSvZLTSnE1ojgjEjY1SWUMpduLOpCfwn6Iw5u94+
         LRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146466; x=1763751266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=su/3DTeyEOfiuZEhYMJ4B5Ixwohi82QW36MCAtfZ6Mw=;
        b=al43lSUmDVsrZhalr9XPRqsT66VSQf8MbGnru5XSpSOnbNBImv80zinBrudfG47rDL
         sPFMkeD5OZln4uUMsKzKXrgtE1Q10wmu4E5ecLouvW/PS3rGFxILVgJ74hOfMjRn/kw2
         7NRw9gRmBUxEMVYJ9BE5TAltJUd4EMCFo84Da7feuoVUKUNBWpD1WVSSbyBpvKJXl6QS
         791qapH6UgrXYpzz/aTA+UdATZtWTIrDzUxOlJkXagncgdKFaqBUIVPN65D/4b71c0Eg
         NbEOOoXvY50eCxak0Ac7lFgb6kjRxt+sPKgWay4HOeFi8h7vXRLytGd5xooO2/K2QV/M
         RF+A==
X-Forwarded-Encrypted: i=1; AJvYcCWtB4OoBKFQvYKVgJuy/pYIQujwOA2ZsidZ2evIE3m3chkCni9+0z84hDzsamSYC058DfXUBXeaDonsGorpzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfUumtkE+5aP66DPitkDfrNrE6qsEX5M/XNczFBzMFxb5AVQDE
	b2kldKiA0XFZKOBqXSYhw7djJ2ZrCHs55ZBBIOxS6xPdVHUbRxbvpqp7
X-Gm-Gg: ASbGncs+qfx36HLu7cRowu7OC/3/QLHIbqj2v9+2KXVDq0jLM5rvs2GFH1wWi5ti/L0
	tP0uH1xFFPh/ZotsBcWptSQzLoIFhDcq6woxgR1cFeq4nMY3g+BcJ6haa/4Y4zsu7IjBiO6C7/I
	l/S9Ljq2JjcqgVWjswjhTSTogwb3tMgs9y/VpNMSnJWj/z/Jphdoo0nGOSE1Hsu6L5cDYtXe3Q+
	vz0X3yVZRtKoEtT3iCkys2KkNA9C5TGOXLYVVeb+Hf/W++d0I3UFnbTm2Sh3vws5M0bef6XDU8x
	kVbOqQtIsenbZUx4u84WFtz2GcP6rugnHGMizIIjYW/q+GU8XPT94y7ArhuVGw5yXMGfBmtrMOc
	qmrHBy9wZhVhDt03iuZngDfCZ+7ZuXey8TaGIAX1Z70kxASiIBF9BGTfKyENi2FTLVZF8fz5ewp
	PJmJM1VaLPGQdin/1GDfdLHr3L9hoBLupPih6sf+8btsuFqtZtvTFQcG4LkbP0DRg=
X-Google-Smtp-Source: AGHT+IEZk9USqhXcykeqQxv6BBqPJ+Ckp0QcbH6DW0s45+kWxw1D0bAUF1znH554QTmUBF8i4qIoUw==
X-Received: by 2002:a05:600c:6002:b0:477:8895:303c with SMTP id 5b1f17b1804b1-4778fd807f3mr32662695e9.3.1763146466154;
        Fri, 14 Nov 2025 10:54:26 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787ea39ccsm156460775e9.15.2025.11.14.10.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 10:54:25 -0800 (PST)
Date: Fri, 14 Nov 2025 18:54:24 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jon Kohler <jon@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Sean
 Christopherson <seanjc@google.com>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user()
 and put_user()
Message-ID: <20251114185424.354133ae@pumpkin>
In-Reply-To: <20251113005529.2494066-1-jon@nutanix.com>
References: <20251113005529.2494066-1-jon@nutanix.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 17:55:28 -0700
Jon Kohler <jon@nutanix.com> wrote:

> vhost_get_user and vhost_put_user leverage __get_user and __put_user,
> respectively, which were both added in 2016 by commit 6b1e6cc7855b
> ("vhost: new device IOTLB API"). In a heavy UDP transmit workload on a
> vhost-net backed tap device, these functions showed up as ~11.6% of
> samples in a flamegraph of the underlying vhost worker thread.
> 
> Quoting Linus from [1]:
>     Anyway, every single __get_user() call I looked at looked like
>     historical garbage. [...] End result: I get the feeling that we
>     should just do a global search-and-replace of the __get_user/
>     __put_user users, replace them with plain get_user/put_user instead,
>     and then fix up any fallout (eg the coco code).
> 
> Switch to plain get_user/put_user in vhost, which results in a slight
> throughput speedup. get_user now about ~8.4% of samples in flamegraph.
> 
> Basic iperf3 test on a Intel 5416S CPU with Ubuntu 25.10 guest:
> TX: taskset -c 2 iperf3 -c <rx_ip> -t 60 -p 5200 -b 0 -u -i 5
> RX: taskset -c 2 iperf3 -s -p 5200 -D
> Before: 6.08 Gbits/sec
> After:  6.32 Gbits/sec
> 
> As to what drives the speedup, Sean's patch [2] explains:
> 	Use the normal, checked versions for get_user() and put_user() instead of
> 	the double-underscore versions that omit range checks, as the checked
> 	versions are actually measurably faster on modern CPUs (12%+ on Intel,
> 	25%+ on AMD).

Is there an associated access_ok() that can also be removed?

	David
