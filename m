Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D852113A3E4
	for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721944066; cv=none; b=eqd3BbBg34hgiBmZo5FC9WIVwEnzHOXcrP/8G4BV8t28XNlIcI1LJoG69lKHU8B4dEWJdCSicAgMnUWXPvgJQteC+6ZhOInA7KiIgu9d/NlfrZYsLgtHP2FfoNEdvhmKhXRbMApNRJpcrIh1PEcX8qmzF3E1/PgSBVnUPZQFJuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721944066; c=relaxed/simple;
	bh=gUNgWcbMs+kkuFsoOhgpg6yX9z7yOPKWd4uiGaPy3AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Fc3EVWprASbMwFV44eW4YFzzN97Yk5FGuVkTeT/RS0htsVbol6XJgQFN0des/KMuBilw4Or4EZYe/nt4Jhxyia6Tp6/6i8uw/PRiRpM52rDM/kucmKnb0hSL7g5kpu35PiWDW48KeOuEh/pxgsm4n9RzXLvKKnrd1SfvmbECv1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ShwE6H9f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShwE6H9f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721944063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6tmy95W8d8fcZK8M4WYbtDZ6SLsWVsRb69dG5sobEig=;
	b=ShwE6H9fpYxQYbIgxQ3Oop4AFuqrRnyl9En3MDGzDbG/OS2VSYw0BAGVhBbFARkQ0YBg3z
	L//X7+CcqYmvzPRxFoxfHrK4xbCv0JHk/CA35leccuZ2H9+z4yTrd/MTgpm1Yc/MwphU31
	VjWwxoGnVHjOQ0wSCH8bShUDaheudS4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-xDqALy76N3GxJf62-FxSYw-1; Thu, 25 Jul 2024 17:47:42 -0400
X-MC-Unique: xDqALy76N3GxJf62-FxSYw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36831948d94so804913f8f.0
        for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 14:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721944061; x=1722548861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tmy95W8d8fcZK8M4WYbtDZ6SLsWVsRb69dG5sobEig=;
        b=PQgcJNqdTNOl49gEcjwcT4XEppUGh9EUxUVfjlfDY3yzyi/eFccrQpG+xk0Z3q+w8x
         6J6fbI7RGlhDcD6UZa2eiqKqWfzzYrxs2oynN0mQwhdKzPL2hGhh9JTcXwGXDkYQR9na
         YK+ZCTM9JmNpWix01nVhSPL140PTnI/YsdX3pr8Yh08Z4kz8n8yhhjmt8nAEc+FIWymK
         FB07SYbtdBD6FOXuoLR3setVp9T5gOfi4LU8HUgSBUba1WlFZ+U+Hv96/6C4T03HuFG5
         7jPS6WvN/9stGY5hb3XPKXfnI5Tt5Stoo6fF2rWtwJU+qZhaO/PSM5WCY78U0yKH04zX
         YFww==
X-Forwarded-Encrypted: i=1; AJvYcCVYFxMUrsGlF+tjPtipJ53ZhQZq0OkkR2+B954KMCHOkuL/hRQtC/khAzbW9c/JfS3cVUAq229cNfKNx6iktDNBBoTTAHTvA4hLEJ+op0o=
X-Gm-Message-State: AOJu0YybY15QNZbB9ScWsXN66NvMyBTWTQwiBajR8X92AxjNdMGRIgPH
	L0QDYte6I8iljJjSc1bdrbi05teEcTtpH2s60eSOQSf3GefrN7ypkpNE/DLT7Iu7cyciUQEbgjg
	79TTqphSeWhbtv+LcUrL2488lMwkIWqW2QobgVP/BxEz5dm2c3CrCqMtHeeySqOtR
X-Received: by 2002:a5d:5752:0:b0:368:57dd:3822 with SMTP id ffacd0b85a97d-36b319f3063mr2690282f8f.37.1721944061119;
        Thu, 25 Jul 2024 14:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnrcTMj8bw6kTD3LLlnmlsS7YJ0E+S2t+2JYqQjwaCK2jQqu4/mn7Hg10XxeeRSeBb6Kchew==
X-Received: by 2002:a5d:5752:0:b0:368:57dd:3822 with SMTP id ffacd0b85a97d-36b319f3063mr2690247f8f.37.1721944060425;
        Thu, 25 Jul 2024 14:47:40 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280573eb03sm52686875e9.12.2024.07.25.14.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 14:47:39 -0700 (PDT)
Date: Thu, 25 Jul 2024 17:47:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Peter Hilber <peter.hilber@opensynergy.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	"Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
	"Luu, Ryan" <rluu@amazon.com>,
	"Chashper, David" <chashper@amazon.com>,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	"Christopher S . Hall" <christopher.s.hall@intel.com>,
	Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
	netdev@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] ptp: Add vDSO-style vmclock support
Message-ID: <20240725174327-mutt-send-email-mst@kernel.org>
References: <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240725100351-mutt-send-email-mst@kernel.org>
 <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
 <20240725122603-mutt-send-email-mst@kernel.org>
 <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
 <20240725163843-mutt-send-email-mst@kernel.org>
 <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
 <20240725170328-mutt-send-email-mst@kernel.org>
 <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2024 at 10:29:18PM +0100, David Woodhouse wrote:
> > > > Then can't we fix it by interrupting all CPUs right after LM?
> > > > 
> > > > To me that seems like a cleaner approach - we then compartmentalize
> > > > the ABI issue - kernel has its own ABI against userspace,
> > > > devices have their own ABI against kernel.
> > > > It'd mean we need a way to detect that interrupt was sent,
> > > > maybe yet another counter inside that structure.
> > > > 
> > > > WDYT?
> > > > 
> > > > By the way the same idea would work for snapshots -
> > > > some people wanted to expose that info to userspace, too.
> 
> Those people included me. I wanted to interrupt all the vCPUs, even the
> ones which were in userspace at the moment of migration, and have the
> kernel deal with passing it on to userspace via a different ABI.
> 
> It ends up being complex and intricate, and requiring a lot of new
> kernel and userspace support. I gave up on it in the end for snapshots,
> and didn't go there again for this.

ok I believe you, I am just curious how come you need userspace
support - what I imagine would live completely in kernel ...


> By contrast, a driver which merely exposes a page of MMIO space
> identified by an ACPI device (without even the in-kernel PTP support)
> could probably be fewer than a hundred lines of code. In an externally-
> buildable module that goes back as far as RHEL8 or even further,
> allowing users to just build and use it from their application.
> 
> > was there supposed to be text here, or did you just like this
> > so much you decided to repost my mail ;) 
> 
> Hm, weirdness. I've known Evolution get into a state where it sends
> completely *empty* messages, but I've never seen it eat only my own
> part before. I had definitely typed responses (along the lines of the
> above) last time.

mutt sucks less ;)

