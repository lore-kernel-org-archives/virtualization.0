Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791591CAA90
	for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300281; cv=none; b=DtXrabzyyS6gtqZWrAcPAEsuHLdQcZRJKPEP/Z7wwQDsbvBLjYYNqEULl0dKOGuc0IyI1G8Ja3V/Ac1q2nUlKH8ihaVwydNJxxa03cB8097HlswsdYuf/XaWJSlTTI8lSdJF3/JiHZ2R74h1g+zFl6GwjtgwEChGbdVVPjWaMEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300281; c=relaxed/simple;
	bh=I1HL4EhttE881MicAtF32b66FddNBn0rz1b+bJ5vSpI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q9D/lVgd5G0rbkxcKvUSzgTxvjY0+y2DmvoMmD7BuRdisCToW3rEC32qsCpeIgkzpsXWg2wHcpSjiaRMbduSuH+KJdh3wsqRtflvLIqHun2DwfXO1kTR8Mg/mqFjeuGNHak8NR5ppIfNd/u5Gm7wzLcuXdAt6opyv3Y4HZTGuoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4Q1eHLj; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4Q1eHLj"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22aa75e6653so7870515ad.0
        for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744300280; x=1744905080; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WI+w75MsGfdj1Z+7uV4Y8gvQFBHXDpFpnvwgAEL/2AQ=;
        b=f4Q1eHLjh06cqU5LbO2nDLH4y0Nqn2CxPLF9B7KXvr3Oah+uv5JxMlfwnd06rHn0RF
         v4tfeUyir/NIhFOFF/8TE3eYn0sRmf/DVG7q8CepzReFXmZQo9/XKenVGQsi+0HNQxKl
         8+le6Q02vjqRC86c59+NjkjGruwYEJKsmij41kkea1veoMr16f7fApLd1ecglfugocaU
         NSYKUhKdGvI2BZJXBLlwNuuS6adRbcInX0IOfWyFx+QhJwUsop3boOHbK8PlOy202Ssx
         M5EfAFqTzBnc/E6ElNIRtfLKRA2ftflhh4Xel6BaBmQE/ckwtlNX5rb/G2UdjYhOIXAd
         SXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744300280; x=1744905080;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WI+w75MsGfdj1Z+7uV4Y8gvQFBHXDpFpnvwgAEL/2AQ=;
        b=C18CNOWLIJ7y2kSQhShNuQG+dp9JUtz4C65CXEnwSu0hztSH7QT0AWHxZPNu8cPcE8
         AMSQAMiq8sWCuiryOPOPS/QKWs5cj39959SczY+n4euQl5O8lT3xtpZ0NWXZLiY+4Jgl
         t83vCekY7upPr/iFIK3fUGCtx11uugzzyA3DPZWMrcaX0gUvYDkGvMy7Wun2PcgrOfC5
         OG2ZKKZij9en4RCnkkPqBoJ9FOauHteIk/5UT/ZII7PV4or4e9LaJV6Fgy6EBMEhleU7
         deD49eOY68p7yJ1fJTbqA2/TP98oJ/bM/0HYugvt3N6LRRlTSRNl5w+VDxFCfQRah+du
         OR1A==
X-Forwarded-Encrypted: i=1; AJvYcCUHM88Ncl7DKUK2aEmHkbhIBxLXUDNS+xgVaLeY5Z1aCICpjw73x1Wjo/n0izyIsl/hJZ6ZzX/bzE2Cc+PDAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YypH8ILOITK1UDyBoT0CQ03a1BBv0j8YraFbqbbsW8NoFgHAgyD
	7PhoWB/R/NdTJBf50huMmodh0ldK6QW4Sefpvdjexy5L5jO6zcLX2PPLiQBApbkpeW/xRWeT71v
	QJg==
X-Google-Smtp-Source: AGHT+IHHdPvjX46b6rya58AVmth99Sr4qyG2wQ8QULk3PUwKRfJK74c4z91IfDSthvFsL0y+9dnZ4azBoYg=
X-Received: from plsb7.prod.google.com ([2002:a17:902:b607:b0:229:2f8a:d4ba])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4cf:b0:220:d601:a704
 with SMTP id d9443c01a7336-22be0302063mr29493945ad.18.1744300279479; Thu, 10
 Apr 2025 08:51:19 -0700 (PDT)
Date: Thu, 10 Apr 2025 08:51:18 -0700
In-Reply-To: <BN9PR11MB5276385B4F4DB1919D4908CF8CB72@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404211449.1443336-1-seanjc@google.com> <20250404211449.1443336-4-seanjc@google.com>
 <BN9PR11MB5276385B4F4DB1919D4908CF8CB72@BN9PR11MB5276.namprd11.prod.outlook.com>
Message-ID: <Z_fo9hPpSfpwi5Jn@google.com>
Subject: Re: [PATCH 3/7] irqbypass: Take ownership of producer/consumer token tracking
From: Sean Christopherson <seanjc@google.com>
To: Kevin Tian <kevin.tian@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 10, 2025, Kevin Tian wrote:
> > From: Sean Christopherson <seanjc@google.com>
> > +int irq_bypass_register_consumer(struct irq_bypass_consumer *consumer,
> > +				 struct eventfd_ctx *eventfd)
> >  {
> >  	struct irq_bypass_consumer *tmp;
> >  	struct irq_bypass_producer *producer;
> >  	int ret;
> > 
> > -	if (!consumer->token ||
> > -	    !consumer->add_producer || !consumer->del_producer)
> > +	if (WARN_ON_ONCE(consumer->token))
> > +		return -EINVAL;
> > +
> > +	if (!consumer->add_producer || !consumer->del_producer)
> >  		return -EINVAL;
> > 
> >  	mutex_lock(&lock);
> > 
> >  	list_for_each_entry(tmp, &consumers, node) {
> > -		if (tmp->token == consumer->token || tmp == consumer) {
> > +		if (tmp->token == eventfd || tmp == consumer) {
> >  			ret = -EBUSY;
> >  			goto out_err;
> >  		}
> >  	}
> 
> the 2nd check 'tmp == consumer' is redundant. If they are equal 
> consumer->token is not NULL then the earlier WARN_ON will be
> triggered already.

Oh, nice.  Good catch!  That check subtly gets dropped on the conversion to
xarray, so it definitely makes sense to remove it in this patch.
