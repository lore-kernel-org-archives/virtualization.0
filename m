Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C33B13C661
	for <virtualization@lists.linux.dev>; Fri, 26 Jul 2024 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721998349; cv=none; b=OcmOt9xncba/bTB7N2EGo+M0CRc+ZZJAK7EMIHef+lKysB3VZ3eQypoRK4Ya9CaY/RxpFvOTnUaqkSQDy2onSpWlLL6jMZQDx/cFpvM4oVzJ++VNZsqMJtzK8XVZ/huNEtWdL3mtE/97gB1CGETVReFAaQreq2VEG76QcvSuD6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721998349; c=relaxed/simple;
	bh=Sp+ueQmSpfGLiC6k78+rR7dKtxhLr7HvODWfBRy/H98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VNCJz7sySQy/hqZ8NrPWDflqkV4FL3jkSmfsBEfJhxmgzicdOdLN6Mh+BaL38dVt4ZM82kWrt2a2LMni6cOfbYo7YCGhCFF12iUP3uQwdsUP4BpDgHAa/qFJxFwhy6W0wmEjPOM2xA8MuZc/w2LLcAx+4c23MHPaIcP3kT//HGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WMScTzBY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMScTzBY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721998347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yezTynRGclrUQSM6OY+EIuWUKqt9v7YX+5YM6Gwd5wc=;
	b=WMScTzBYQ1SDoRA7Fw5O+VeaIOmPbpiUg1LAYqJFuZVEHZ6TI16fcYT6m9TlApWnq8wA4Z
	vRFOlS1AFnu73M5S8hGHvSsI4OyK7fBD5kPJRGDAOaYO8r+7Pra94RIYdiKjkPrV3Uh6H9
	5WDPwT2nDb0GOl9lnIXFd3N7ndFaRMU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-j-YydNDMOguCZhKO8SRzFg-1; Fri, 26 Jul 2024 08:52:25 -0400
X-MC-Unique: j-YydNDMOguCZhKO8SRzFg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280b119a74so6249485e9.3
        for <virtualization@lists.linux.dev>; Fri, 26 Jul 2024 05:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721998344; x=1722603144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yezTynRGclrUQSM6OY+EIuWUKqt9v7YX+5YM6Gwd5wc=;
        b=hR5UmfLMokL6mJVMdiNrJ7swVT6PdRbM4Odpvb831AnMjrva0fDyUYjBUvwNjeuZAx
         eJDODVAn2dMXyOAymxWW1nl8rDtRGxv/WmQjtojlGE/10j2tpKN9oU+icqbhu8G544ar
         AG4uU0VTN276IU8LLCQby2m9OC7InYeacZfXViYgvA05LZvti1k/YNIANXqly3/7d4RG
         hhsZgFFjGIzqfI2OEujqQQkG1vRFuGXnrtxYOLFIg9i8JHgNZgSi+c7ijMvpl6h2eBQr
         rh3JPfQ9p/A/CkqqiInic8cU2AjtTljV8nEPfQwtWtrsDMqnNB6lIGT2mhKRfKMtckYE
         AZvA==
X-Forwarded-Encrypted: i=1; AJvYcCWa+YaqPXwijWq2KJkRk80vCM8Cs2iacHt1mYiZXJ8ai/P/hDC/WY/AzOjpw7ywVpLHRvfwXuacZtDeL1y6ZglixCEt+DtLadC8XUn/st0=
X-Gm-Message-State: AOJu0YzUZjANe6KLJ3pRN51SLIuju13vtXcm1+i5ITnm37WKPBfbTs7O
	z2LYOLTTthSTDfCQiur5Fuvdd4Ow5m4kttcDwEpTd/XAZkHYb5CbfFikWQ4DbfxmW5raqtvDLeN
	gYCOKjQw1Zg+F+qdqKSFeBp4mvLR423eb7Q01wYwls/f0y+jFW42gQRMItZ1cHTFXXfsYokFE
X-Received: by 2002:a7b:cc13:0:b0:426:6876:83bb with SMTP id 5b1f17b1804b1-42806b94444mr35917475e9.17.1721998343806;
        Fri, 26 Jul 2024 05:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeZtYe8A1GZTEmL+i7voXFimPt8dBDRrCiuydzX4tPFYqbNapaldNesLi/P0+Gt5ylw7JbVQ==
X-Received: by 2002:a7b:cc13:0:b0:426:6876:83bb with SMTP id 5b1f17b1804b1-42806b94444mr35916735e9.17.1721998341579;
        Fri, 26 Jul 2024 05:52:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863b45sm5219141f8f.107.2024.07.26.05.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 05:52:20 -0700 (PDT)
Date: Fri, 26 Jul 2024 08:52:16 -0400
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
Message-ID: <20240726084836-mutt-send-email-mst@kernel.org>
References: <20240725122603-mutt-send-email-mst@kernel.org>
 <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
 <20240725163843-mutt-send-email-mst@kernel.org>
 <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
 <20240725170328-mutt-send-email-mst@kernel.org>
 <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
 <20240725174327-mutt-send-email-mst@kernel.org>
 <9261e393083bcd151a017a5af3345a1364b3e0f3.camel@infradead.org>
 <20240726015613-mutt-send-email-mst@kernel.org>
 <2e427b102d8fd899a9a3db2ec17a628beb24bc01.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2e427b102d8fd899a9a3db2ec17a628beb24bc01.camel@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 26, 2024 at 09:35:51AM +0100, David Woodhouse wrote:
> But for this use case, we only need a memory region that the hypervisor
> can update. We don't need any of that complexity of gratuitously
> interrupting all the vCPUs just to ensure that none of them can be
> running userspace while one of them does an update for itself,
> potentially translating from one ABI to another. The hypervisor can
> just update the user-visible memory in place.

Looks like then your userspace is hypervisor specific, and that's a
problem because it's a one way street - there is no way for hypervisor
to know what does userspace need, so no way for hypervisor to know which
information to provide. No real way to fix bugs.

-- 
MST

