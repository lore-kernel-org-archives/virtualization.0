Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902E626D5B8
	for <virtualization@lists.linux.dev>; Fri, 28 Feb 2025 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753171; cv=none; b=krHW8Gt98LnBjT7zVAk+nFyz/WDgKg0a4oE30CMSfbBeZH6sct/2dBsPv10UVigI5R5AiVab4Y7MH3PURiZ4OTzDiA51B62aka/FsJNytSgUMw8S0MWDvdbW2VLXSxsVXiRVHIYUDaJjNiPDY5mwy4EQ2WvmKVqma4nAVVT/xb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753171; c=relaxed/simple;
	bh=CkGIJQuiqe49itaAI2kGn76UNrSRVXquqJYxAstk/Pc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FFooVqfVnLL5HfijzK5D+q4Z30vmy4ngdK2PLdbky3ibRd4irOCi3YZw7YfthLd6c9KusFzgS9gdCjU5SOv1KgTV0LH+wtl84F6SSp3yTU+af/iD7oCVAF6BH+Y3GI0F3XBi3H4L4oV4EJ9G1XBz5FhVCdcsZ02ps1Gh6xJ8D+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PbCgF93q; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PbCgF93q"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fec1f46678so2390155a91.1
        for <virtualization@lists.linux.dev>; Fri, 28 Feb 2025 06:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740753169; x=1741357969; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7JGZceXrqb3JDH8Ghpfp/+cyR/E9//d9mR4kGrL6APs=;
        b=PbCgF93qxwvNB7mq1U4roH6jo1Ln88LX0Xr9PBjuABbZFe+Fg6AMb4d1g/zoTAtbkd
         9oDLnBgyS8YTi3w/dnkGvH+OB5FfXwpRlD2k/4v+U0MB6oa8VcaRp0KeIRWnAUIeAb1s
         0QHARg0q6h3aOQ5CgkrvxTOCJHoLEzirm3auuOwuLZBiKACzlAqA9XcRObZdJ1q1+fME
         wBVgjxgK+eCbxlyR+qMVOundzeiPOSQLZ4GVZLlu+ya6nkbm995dk7smfW1y6OtL3te8
         XEIyauCAGOT2nDsvFOmXQWKpSBEtUOUtcJBZro8jVNQzynvpNNIS1nstLYdjR8xl9MPK
         dXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740753169; x=1741357969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JGZceXrqb3JDH8Ghpfp/+cyR/E9//d9mR4kGrL6APs=;
        b=u3z+jE7kl0tPFVKR9EaoVNT8h42QL/T4qTR9KWvBayqqFDjN+CwjXtqUTz7ghHVEk6
         prTtcima8YB9XCB2KdkrCuyOk39DZkuPWw/CZ0EH4Lo03jocibt8ah3hMue3ZPm2P2c/
         ZVKXL0qwIq3cQYP6xblstdlGJ98GRnmGOLaejouPEDVGztL7mGCeiuhEsQGW9KBGfmys
         0n41WUSUutcnTGVVst+ndW8RiOXFzC03yKSGHoOmSQ4endLQocyUmhbjpl0TrLykxkAR
         a1IXPYtjsG8WNZ3/mAtDQEVGjEWKyXL2XzgdEJFmFhhRBsH4na2wNPH6yn+I4Ha/Jn1+
         XszQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhMYtYxmy/9jlb437MtGPF6gU4LmpPcmmEUPmk/u24bar6jcjjSLhcCVOmUWBPUIdGXzyw/QFb0c7wKDXYTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6dsWYllK5u6mpVK1F4pS4r+yj7SqCMoibU/c6fn/fedFGuB6/
	4NK1peVYrCGOTb/8cAtLTaFnh9tmIi2kJR5h7mvWwEjwe+NhEHHQSR//BJbD5t5ONilo42kjsF4
	dCg==
X-Google-Smtp-Source: AGHT+IH1DxS6eOUmZ9xvim3EQOmiQTWoEVkgytjLr2ne7i9BwMNqJZxk8yPz2qlW8r5e1PwFWv8SejB/SnU=
X-Received: from pjbqc9.prod.google.com ([2002:a17:90b:2889:b0:2fa:15aa:4d2b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4acb:b0:2ee:45fd:34f2
 with SMTP id 98e67ed59e1d1-2febab2eca7mr5752926a91.6.1740753168923; Fri, 28
 Feb 2025 06:32:48 -0800 (PST)
Date: Fri, 28 Feb 2025 06:32:47 -0800
In-Reply-To: <Z8HE-Ou-_9dTlGqf@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227230631.303431-1-kbusch@meta.com> <CAPpAL=zmMXRLDSqe6cPSHoe51=R5GdY0vLJHHuXLarcFqsUHMQ@mail.gmail.com>
 <Z8HE-Ou-_9dTlGqf@google.com>
Message-ID: <Z8HJD3m6YyCPrFMR@google.com>
Subject: Re: [PATCHv3 0/2]
From: Sean Christopherson <seanjc@google.com>
To: Lei Yang <leiyang@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, x86@kernel.org, netdev@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 28, 2025, Sean Christopherson wrote:
> On Fri, Feb 28, 2025, Lei Yang wrote:
> > Hi Keith
> > 
> > V3 introduced a new bug, the following error messages from qemu output
> > after applying this patch to boot up a guest.
> 
> Doh, my bug.  Not yet tested, but this should fix things.  Assuming it does, I'll
> post a v3 so I can add my SoB.
         v4

Confirmed that it worked, but deleting the pre-mutex check for ONCE_COMPLETED.
Will post v4 later today.

> diff --git a/include/linux/call_once.h b/include/linux/call_once.h
> index ddcfd91493ea..b053f4701c94 100644
> --- a/include/linux/call_once.h
> +++ b/include/linux/call_once.h
> @@ -35,10 +35,12 @@ static inline int call_once(struct once *once, int (*cb)(struct once *))
>                 return 0;
>  
>          guard(mutex)(&once->lock);
> -        WARN_ON(atomic_read(&once->state) == ONCE_RUNNING);
> -        if (atomic_read(&once->state) != ONCE_NOT_STARTED)
> +        if (WARN_ON(atomic_read(&once->state) == ONCE_RUNNING))
>                  return -EINVAL;
>  
> +        if (atomic_read(&once->state) == ONCE_COMPLETED)
> +                return 0;
> +
>          atomic_set(&once->state, ONCE_RUNNING);
>         r = cb(once);
>         if (r)
