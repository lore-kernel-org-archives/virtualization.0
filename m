Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C335C8FC
	for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721941481; cv=none; b=qM6hoR7bT/KvQ3m3VOsgKVt0SFr/DhUeNk1g/e9iqn5NqEBUQAG5zAO+bXN1yXgj2Ir62HqVGvo7XCB9ZmwIFwDeSxizfVXJg7gTgUqhuTnqog/bp0MW80873Q7av04eZVRnJoRjU9P4RC/rIbw8eNebbifHC1vl5ljRlDCWjOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721941481; c=relaxed/simple;
	bh=FEWVOD3+yRKcEuqLgqxmvL5aypghEhU0c65lOoNrXl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ewwij+TfXCd61+46NELQI6DMNeZhFjx72hXK3whZj55qQ0veVsw/fG4iiJNCmGJT52yvcntvVidRsouWennxUBgINFo7yDnf4z7dd1DB20qeeGqctPCbfC2HivfqJMwad/zG5F7Ik9mzx+NfWctKUvRzmmka+6frn8hodh1HbQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hz73QVdY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hz73QVdY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721941478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tTDtUQaLZ7CrF67TfvKh0JSNTMNAlAQ/IuXCIFvbTU8=;
	b=Hz73QVdYJSgFJ9U9vYr8Cia9eiPCuKUqcojCIQvi/nzkLmVEpEKaAb+EdNRcBNaRjzgVxX
	5hYxly59IhviuwPBU/lAs9UKXJVtdajQHd8F8G2dB5rWR7kpYyc/QC+WS0G0s2+h3B2tOm
	7eVqJguzNJgCVp3OYsFL9S64cb2L1C8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-W8zjY7JvOlKsLXSd2OoaJQ-1; Thu, 25 Jul 2024 17:04:37 -0400
X-MC-Unique: W8zjY7JvOlKsLXSd2OoaJQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280a39ecebso1093325e9.0
        for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 14:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721941476; x=1722546276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTDtUQaLZ7CrF67TfvKh0JSNTMNAlAQ/IuXCIFvbTU8=;
        b=d/iNnKoNW++6cihxkBI0PPDX2TtSLO18rEWkcOhdXz08ddagwwlpwW3eUoU7XlImL8
         LncrFMbVwr187JTttEPYNe0+d/oU6x6t+nWD8Ee+Bm14RQN7EnKD10wy+oApCptF1Sgs
         sYPEa5cIQlDsIxd9quRZl3irU3E7xoxi77BZNKZXqIS3qzo550vCPKBoWfBrusBtFIXh
         czUOQQ8L4vqGWDW71PS8bD6wbdTvm7HvP5G7OESBzsp7ZcFowKIfln6l64dAvOjZhyqa
         /1FFamFUIXlOLba7EP+ixVvIOvT1HKVps/i1G467FbzUA7XzL5KRlsxg90RDdsSvCWMw
         Cdqg==
X-Forwarded-Encrypted: i=1; AJvYcCW2qJ/hoY89vMmVn14Y1BWXPi9bRc6QXhAhdDC31S94MYybmQ3RWjRIOkPDINXr9LZsOvKZ0b5KqxbQBsVWQ0vDyte9WMIMraRgehxkvVY=
X-Gm-Message-State: AOJu0YxbxH0OM7z02X+66RuFPCGEOlgA1JbVETez0t13PKFrv32+dxts
	Br+Kj5ZSAgoJWMGIjLzT4uZ0WuMQkvIZDkZ8c6V4bEBMQrxScLFFuRJRd+5xSfU5TlzkiQLJUZ6
	DQqE7bskTRv3Xui6N3ElKCsNv3TN6whqcHkPtYpV2Tkp36JUDB9VI9diJzj02N8WL
X-Received: by 2002:adf:ed90:0:b0:367:8fee:4434 with SMTP id ffacd0b85a97d-36b31b4d48dmr2687312f8f.16.1721941476015;
        Thu, 25 Jul 2024 14:04:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhpTnkp42p1F3wTt6Fx20U3s9cQUoElQmJjW+LG0DsT7CR4O+1x/Cg4YZh3CZ7ii4p+45m0A==
X-Received: by 2002:adf:ed90:0:b0:367:8fee:4434 with SMTP id ffacd0b85a97d-36b31b4d48dmr2687298f8f.16.1721941475033;
        Thu, 25 Jul 2024 14:04:35 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863d87sm3172908f8f.110.2024.07.25.14.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 14:04:34 -0700 (PDT)
Date: Thu, 25 Jul 2024 17:04:29 -0400
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
Message-ID: <20240725170328-mutt-send-email-mst@kernel.org>
References: <20240725082828-mutt-send-email-mst@kernel.org>
 <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
 <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240725100351-mutt-send-email-mst@kernel.org>
 <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
 <20240725122603-mutt-send-email-mst@kernel.org>
 <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
 <20240725163843-mutt-send-email-mst@kernel.org>
 <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2024 at 10:00:24PM +0100, David Woodhouse wrote:
> On Thu, 2024-07-25 at 16:50 -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 25, 2024 at 08:35:40PM +0100, David Woodhouse wrote:
> > > On Thu, 2024-07-25 at 12:38 -0400, Michael S. Tsirkin wrote:
> > > > On Thu, Jul 25, 2024 at 04:18:43PM +0100, David Woodhouse wrote:
> > > > > The use case isn't necessarily for all users of gettimeofday(), of
> > > > > course; this is for those applications which *need* precision time.
> > > > > Like distributed databases which rely on timestamps for coherency, and
> > > > > users who get fined millions of dollars when LM messes up their clocks
> > > > > and they put wrong timestamps on financial transactions.
> > > > 
> > > > I would however worry that with all this pass through,
> > > > applications have to be coded to each hypervisor or even
> > > > version of the hypervisor.
> > > 
> > > Yes, that would be a problem. Which is why I feel it's so important to
> > > harmonise the contents of the shared memory, and I'm implementing it
> > > both QEMU and $DAYJOB, as well as aligning with virtio-rtc.
> > 
> > 
> > Writing an actual spec for this would be another thing that might help.
> > 
> 
> > > I don't think the structure should be changing between hypervisors (and
> > > especially versions). We *will* see a progression from simply providing
> > > the disruption signal, to providing the full clock information so that
> > > guests don't have to abort transactions while they resync their clock.
> > > But that's perfectly fine.
> > > 
> > > And it's also entirely agnostic to the mechanism by which the memory
> > > region is *discovered*. It doesn't matter if it's ACPI, DT, a
> > > hypervisor enlightenment, a BAR of a simple PCI device, virtio, or
> > > anything else.
> > > 
> > > ACPI is one of the *simplest* options for a hypervisor and guest to
> > > implement, and doesn't prevent us from using the same structure in
> > > virtio-rtc. I'm happy enough using ACPI and letting virtio-rtc come
> > > along later.
> > > 
> > > > virtio has been developed with the painful experience that we keep
> > > > making mistakes, or coming up with new needed features,
> > > > and that maintaining forward and backward compatibility
> > > > becomes a whole lot harder than it seems in the beginning.
> > > 
> > > Yes. But as you note, this shared memory structure is a userspace ABI
> > > all of its own, so we get to make a completely *different* kind of
> > > mistake :)
> > > 
> > 
> > 
> > So, something I still don't completely understand.
> > Can't the VDSO thing be written to by kernel?
> > Let's say on LM, an interrupt triggers and kernel copies
> > data from a specific device to the VDSO.
> > 
> > Is that problematic somehow? I imagine there is a race where
> > userspace reads vdso after lm but before kernel updated
> > vdso - is that the concern?
> > 
> > Then can't we fix it by interrupting all CPUs right after LM?
> > 
> > To me that seems like a cleaner approach - we then compartmentalize
> > the ABI issue - kernel has its own ABI against userspace,
> > devices have their own ABI against kernel.
> > It'd mean we need a way to detect that interrupt was sent,
> > maybe yet another counter inside that structure.
> > 
> > WDYT?
> > 
> > By the way the same idea would work for snapshots -
> > some people wanted to expose that info to userspace, too.
> > 
> 



was there supposed to be text here, or did you just like this
so much you decided to repost my mail ;) 

-- 
MST

