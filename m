Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968526AF5
	for <virtualization@lists.linux.dev>; Fri, 28 Feb 2025 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756589; cv=none; b=YH2o3CFMT0/CELlnjjknK9K8vqJi8+4/bD2FbD/VPemZ3EMRAFv0eS9TfblyK8C55TAT8Ok7oOXb3rUIPb1aqIg6niMQGJafGCKaFkc4GfSHBs/flD+Fm1+xGNewi6yIRPBK/bfagfN+SBGcC+mjH9Xkikm2VLqktPfMJtIyf7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756589; c=relaxed/simple;
	bh=XCJk2h9jZrkXzyM4MzFEXBe8P2mFNejO149x+dHUVj8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HE0gzCFkoptGS+ogwhpKnfgCoHd7Hej6u2aAy882V/5WoE8QtBSEcCA0vmodrloJ5tHAECkAEgi+JxHoJw5nl9lZ34JEPFeLihVhcu7/7Ma3ymNthfEWtLPwDj+IAZM6SAE2ssc2Z749tYW+x+I3sFsYb/hd+wYLSdIeWy9e7iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f9TSOCHh; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f9TSOCHh"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe862ea448so7139227a91.3
        for <virtualization@lists.linux.dev>; Fri, 28 Feb 2025 07:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740756587; x=1741361387; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0NdNWjsGqI6Dafogyd1Kwr8H92XGqubxgRj7O/f1eiU=;
        b=f9TSOCHhwSO0NAH+GVPC6+ZrJFqzocH9yf0cD8cRRc66T8raez8/KPR1hRniiduvK2
         IeZ61Kf7Y2wE/IRtV8AG1BjGx826XXyNhcQYnOazSFKYXB2Yfb1ymTzLhmsmnQrNxRwV
         uezR0f1vn0hqFnxv3U5Dgf0KAA22b+jg19yIC9kuapO7Hauy85hspe9k0a2qbAV5pk25
         4lelI/2BMmXAuSGI5rTCNDBBEEs13OyYBNc397Cw2QP1MYLP42kpn/yCEtUdGf9FwoUV
         bUVDRbRuTxHltvjTYMda4I2Ppyqi+G5LqWnpQ6cPatmqVMB6onA1hTlYz0uMbztHbp5c
         izbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740756587; x=1741361387;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NdNWjsGqI6Dafogyd1Kwr8H92XGqubxgRj7O/f1eiU=;
        b=Ptx6oI2vFlf/ppClvdV/2vAgyVEi5/q5D1fU1I1wuihMcS+yLYeG3ZOBcrtgtaGaTg
         UudfQhc3G9tVuC5iuCNXlnRkYT2ZzFmhIArCEYScgnkfYQ4KNYI6C9btbLmuUn9/9nMq
         MBFwtcdPxqkETeJHbx30zxo0eV4XhhbaONBKcj7p8tckrhKI18kwBa+BH4joQF1UMhwL
         p2uR8AQSekpHUsdASTxU6aBnBVUPEVJFlpg7Vl2O4szXXcRfiCYLSKXRrr5fJXGbfv6H
         OvEfUkdF7XuDWaUNTFsFnAhi8tb5fw+OOWIduFr5BuyAuwZgogtAZS3gpxl64siwJT+n
         Gzig==
X-Forwarded-Encrypted: i=1; AJvYcCU39GzWiNGkKMCYjoP8Gp2CyhCVVaVLn25zNfy1dlO67RjU0WcKOaR6CBLzpbxJ7zGjBkUcwsP+03hjYV6O/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlzqHXOJWRSJpg7VHghugqIkyfWkAkIsBy2f3Wq9WnuM8+JIye
	h6lWA/WZ+ReOxbJm9/dyKTHQycPPUjcXufl57OxlpkaPNF9+qZTz/8XknMIS/+wG6skeSXSr7I6
	icg==
X-Google-Smtp-Source: AGHT+IEk/ms6AP8TpnMjRdBXF3xnEipvWGFCCXnDnNMxEOlOgXa2qA7dn9VfelOnGm0U+bmMyOfy55V6fHE=
X-Received: from pfbde10.prod.google.com ([2002:a05:6a00:468a:b0:730:7d9a:3251])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4323:b0:1ee:e0c0:85a8
 with SMTP id adf61e73a8af0-1f2f4ce57d2mr6819058637.15.1740756587183; Fri, 28
 Feb 2025 07:29:47 -0800 (PST)
Date: Fri, 28 Feb 2025 07:29:45 -0800
In-Reply-To: <Z8HPENTMF5xZikVd@kbusch-mbp>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227230631.303431-1-kbusch@meta.com> <CAPpAL=zmMXRLDSqe6cPSHoe51=R5GdY0vLJHHuXLarcFqsUHMQ@mail.gmail.com>
 <Z8HE-Ou-_9dTlGqf@google.com> <Z8HJD3m6YyCPrFMR@google.com> <Z8HPENTMF5xZikVd@kbusch-mbp>
Message-ID: <Z8HWab5J5O29xsJj@google.com>
Subject: Re: [PATCHv3 0/2]
From: Sean Christopherson <seanjc@google.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Lei Yang <leiyang@redhat.com>, Keith Busch <kbusch@meta.com>, pbonzini@redhat.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 28, 2025, Keith Busch wrote:
> On Fri, Feb 28, 2025 at 06:32:47AM -0800, Sean Christopherson wrote:
> > > diff --git a/include/linux/call_once.h b/include/linux/call_once.h
> > > index ddcfd91493ea..b053f4701c94 100644
> > > --- a/include/linux/call_once.h
> > > +++ b/include/linux/call_once.h
> > > @@ -35,10 +35,12 @@ static inline int call_once(struct once *once, int (*cb)(struct once *))
> > >                 return 0;
> > >  
> > >          guard(mutex)(&once->lock);
> > > -        WARN_ON(atomic_read(&once->state) == ONCE_RUNNING);
> > > -        if (atomic_read(&once->state) != ONCE_NOT_STARTED)
> > > +        if (WARN_ON(atomic_read(&once->state) == ONCE_RUNNING))
> > >                  return -EINVAL;
> > >  
> > > +        if (atomic_read(&once->state) == ONCE_COMPLETED)
> > > +                return 0;
> > > +
> > >          atomic_set(&once->state, ONCE_RUNNING);
> > >         r = cb(once);
> > >         if (r)
> 
> Possible suggestion since it seems odd to do an atomic_read twice on the
> same value.

Yeah, good call.  At the risk of getting too cute, how about this?

static inline int call_once(struct once *once, int (*cb)(struct once *))
{
	int r, state;

	/* Pairs with atomic_set_release() below.  */
	if (atomic_read_acquire(&once->state) == ONCE_COMPLETED)
		return 0;

	guard(mutex)(&once->lock);
	state = atomic_read(&once->state);
	if (unlikely(state != ONCE_NOT_STARTED))
		return WARN_ON_ONCE(state != ONCE_COMPLETED) ? -EINVAL : 0;

	atomic_set(&once->state, ONCE_RUNNING);
	r = cb(once);
	if (r)
		atomic_set(&once->state, ONCE_NOT_STARTED);
	else
		atomic_set_release(&once->state, ONCE_COMPLETED);
	return r;
}
