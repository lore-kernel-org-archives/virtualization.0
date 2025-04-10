Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80661202F7B
	for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744322679; cv=none; b=n6dRQZuuQ7B0HRkdxscojmMbUpmkRB2sR7TuLK+3+dTDNhcVCgAfQBRNGvYZcLMoM6wH7/vmEzwEm5/nC+POLCoy8LPWsKfDcN46+8CY3ZiXEibuaCepE3y9wST/gPWg+fxYQiGVAO+5z7RlGaxkLab1Y+T1Ti11WFsQFH7oDTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744322679; c=relaxed/simple;
	bh=3uMBL4NPv3raozz5zKjQqEnw2j9SO97i6WwFa10I4Pg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tu1reDUJvHR9PvDlClEVx5h0aAF5sfrA85o/IzJ6UlSyWZ4YBoJGHRGO9S/5FirvZuBLGCJX+vnBLUE1Qm+KAgb5pefYOMRzvd5RrkBW+GWxmTtguUmWQUesfuzypCUryuHDysRdOqvTUCf290CzsqKPCOeefxPpXZveiGgFYco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RQ2EDgNK; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQ2EDgNK"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2265a09dbfcso20089875ad.0
        for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 15:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744322677; x=1744927477; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7eShhCni2AeN9U5Jc2b4WOHTyOiv0aqWO9tX2xSw/mU=;
        b=RQ2EDgNKiBzZmzcoHxY70r75vompJBFbNt8Jrg3Mk7Cc+refnoSSoV3c8lUDgU9ggv
         eNcTCZUDDVjHrwhYiMa8mR/czhqoRQWB38ne3ykjMkRzzn1GrxvgR07wCXY9lJ/Y1hg0
         vr+Cy+0GWbA7k92XBnXSUPrgTRGPOVayK/zxRYHBOIPc2q0fxXzCQAM7oB/oy1pBCk3b
         4IqE6eVY8UCuHF2vs1ynvwhJy+Lu7a9MKmqMhZ5/a9Q5wieEktIZhgMyp1AJ6kFELCm1
         DKgE/QaqCqMLf2UHsnlem69pQETqrkGgROrM9HiZPKMjjlBWUXhbrtQtetgiaWMhtbb5
         FqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744322677; x=1744927477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eShhCni2AeN9U5Jc2b4WOHTyOiv0aqWO9tX2xSw/mU=;
        b=TzMg1aXVxlUTHZ16YmVbcjyx2rbRyNb3TGX6eW8Bpzd8wZvP0ysxpelxVzWHjulCvE
         XLgX8++hzxsalll6tElPdf//cMy5d5xqQ6o8Zq6xipT/XFQdn9fzZCcN5HWOfPt1InZr
         JBd+7+rtMt6m9ua2vOkq16ZpNauvXxwibK86IYgWIOt9uuJPGRrYB9L1LNgcGfwX0Ara
         eA52U2bCHss6DcTxROqdUEAw725gAI8k7dVMkMdDOrkQ9jXUnOdTCRISavS8uf5jRXux
         AtVpLNWciXkMFY8kQ/u9noJphCY3EfF75s2VnW3NCkIogKLafEWY0AQaI17IH0+RGmrt
         jBdA==
X-Forwarded-Encrypted: i=1; AJvYcCVRPQkvsWQicIFVvBZuY0gakUqo+kq866I2gd44CVVsCVTR8sPntLPKknc28NyZaG91C8wXtnfpNKdAKVjbNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVkyKO4Cr5hjYxO1gsGayE9gx1RSLW4XCnaWj51PwYfilB883I
	S9TcF89r0fj7U6heHhTlBQVQe+wbJY7gKKwjGD0IRZuwp3c4ljLeLp4X6bkKfuu9agAARu/0qm0
	VmA==
X-Google-Smtp-Source: AGHT+IE/nhiyEmsRhP2rb2VCXmUB28XKf+JD6SxynR/MURcWw+q3szzXjCCZ52+kyzlA5ipAqMNlMQqrrE8=
X-Received: from pltj8.prod.google.com ([2002:a17:902:76c8:b0:223:3f96:a29c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d481:b0:220:f59b:6e6
 with SMTP id d9443c01a7336-22bea495687mr4890535ad.8.1744322676625; Thu, 10
 Apr 2025 15:04:36 -0700 (PDT)
Date: Thu, 10 Apr 2025 15:04:35 -0700
In-Reply-To: <20250410152846.184e174f.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404211449.1443336-1-seanjc@google.com> <20250404211449.1443336-4-seanjc@google.com>
 <20250410152846.184e174f.alex.williamson@redhat.com>
Message-ID: <Z_hAc3rfMhlyQ9zd@google.com>
Subject: Re: [PATCH 3/7] irqbypass: Take ownership of producer/consumer token tracking
From: Sean Christopherson <seanjc@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, David Matlack <dmatlack@google.com>, 
	Like Xu <like.xu.linux@gmail.com>, Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 10, 2025, Alex Williamson wrote:
> On Fri,  4 Apr 2025 14:14:45 -0700
> Sean Christopherson <seanjc@google.com> wrote:
> > diff --git a/include/linux/irqbypass.h b/include/linux/irqbypass.h
> > index 9bdb2a781841..379725b9a003 100644
> > --- a/include/linux/irqbypass.h
> > +++ b/include/linux/irqbypass.h
> > @@ -10,6 +10,7 @@
> >  
> >  #include <linux/list.h>
> >  
> > +struct eventfd_ctx;
> >  struct irq_bypass_consumer;
> >  
> >  /*
> > @@ -18,20 +19,20 @@ struct irq_bypass_consumer;
> >   * The IRQ bypass manager is a simple set of lists and callbacks that allows
> >   * IRQ producers (ex. physical interrupt sources) to be matched to IRQ
> >   * consumers (ex. virtualization hardware that allows IRQ bypass or offload)
> > - * via a shared token (ex. eventfd_ctx).  Producers and consumers register
> > - * independently.  When a token match is found, the optional @stop callback
> > - * will be called for each participant.  The pair will then be connected via
> > - * the @add_* callbacks, and finally the optional @start callback will allow
> > - * any final coordination.  When either participant is unregistered, the
> > - * process is repeated using the @del_* callbacks in place of the @add_*
> > - * callbacks.  Match tokens must be unique per producer/consumer, 1:N pairings
> > - * are not supported.
> > + * via a shared eventfd_ctx).  Producers and consumers register independently.
> > + * When a producer and consumer are paired, i.e. a token match is found, the
> > + * optional @stop callback will be called for each participant.  The pair will
> > + * then be connected via the @add_* callbacks, and finally the optional @start
> > + * callback will allow any final coordination.  When either participant is
> > + * unregistered, the process is repeated using the @del_* callbacks in place of
> > + * the @add_* callbacks.  Match tokens must be unique per producer/consumer,
> > + * 1:N pairings are not supported.
> >   */
> >  
> >  /**
> >   * struct irq_bypass_producer - IRQ bypass producer definition
> >   * @node: IRQ bypass manager private list management
> > - * @token: opaque token to match between producer and consumer (non-NULL)
> > + * @token: IRQ bypass manage private token to match producers and consumers
> 
> The "token" terminology seems a little out of place after all is said
> and done in this series.  

Ugh, yeah, good point.  I don't know why I left it as "token".

> Should it just be an "index" in anticipation of the usage with xarray and
> changed to an unsigned long?  Or at least s/token/eventfd/ and changed to an
> eventfd_ctx pointer?

My strong vote is for "struct eventfd_ctx *eventfd;"
