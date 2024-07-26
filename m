Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA4D33981
	for <virtualization@lists.linux.dev>; Fri, 26 Jul 2024 06:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721973986; cv=none; b=U49WDvFYjOinY8ow1BlBj3WrNR7FvhTkzYcyJBSn3cYyAKuVzkK3Pr2t3zfi38ROEeuf796csOp10CCS10fnJ26+DXedgq0yNBUzYSA3HnwGecLZBTs/zpA4iEcggvSlpdolmTFrczvPFAQ95V4+Bij+lAm/VI06Bg1dvyW72rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721973986; c=relaxed/simple;
	bh=6a7x76ue8Tb/QiSBhzrn7bO0FzEBds6B8ZU9VxKhPik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PjLKSDUmYRyfugEZZTMFx4OreMNhj/hTj9rFxDqw6MqA45iH24fdJbuu3XDFEtU3faMpPYdVY1WC51r7/hTH9jy8EqD0CmQ2lDRrmdHBdN78bfDSWlTkxCU5c0ekdxhBrTmWxZtu7RUmQ9bJ8L+FF+IcG0wqoa0N5TanC1dKvj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NzmDsLME; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzmDsLME"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721973984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SsMd5ReUoNivIVt7CipMVyDPULIY2oYNW6l4qiM7rgQ=;
	b=NzmDsLMEH51FVrxuW8qTQIm4jt/MsjPaxk+KOCognl04vjKTxqVyTskmGzpugtznMYFp3A
	y5l9Yped6e6+oJGORlxSekLMGRfVmmvlq+Cwc/BvvVgWuKUj3H79i+4PZuiayoC3q37qR5
	fp4Gnz2tswU7Wo061mKpzGvYYeT3uSc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-mm3wvPxZN5WwV28kDjkqWA-1; Fri, 26 Jul 2024 02:06:22 -0400
X-MC-Unique: mm3wvPxZN5WwV28kDjkqWA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-368374dc565so925655f8f.2
        for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 23:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721973980; x=1722578780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsMd5ReUoNivIVt7CipMVyDPULIY2oYNW6l4qiM7rgQ=;
        b=KYJYW2HoehWddkVNXiRlsBWF/pf1v0eStvJy1Zy51g8uAT3DFFvhvuLyxC1sg8ARwr
         4UHHFVvZPMABRUWU3b5Ny5EYtKIRR/glkLcwytTBKMCLt7KvbZKiM3BcufDXKMpX+TFD
         wwhx5sx2SlAgghO2SS2RmpjK9UDTcKsdv3hjQNq+6nMHqsqXwVZic7R7HvdleRqE46gT
         NSdQ94X17X+8akYjdseFYYFfDX4DfRKypCTkr0QjLLKUFlK2rlHxymOapMCFY6AnHXTS
         k16c1iJVqtNksQppkFchEnJxnSgAZVauoKwQc63WUJx5bLHL+kvGLOmzTcowgtgfHVOS
         P4oA==
X-Forwarded-Encrypted: i=1; AJvYcCXYUUIjw9OEm5jaW17enQVTDvEqNekaKl1IrzppG5QOEdZGDqs3/dxV0kW55EEnn9zi6QnfoKAh84F8vzKXCTLNRm6YGUV2bHMB2GavXn4=
X-Gm-Message-State: AOJu0YxnFfAwbYo6ctIPyubVaQb9XTEJ8puTRl5YIo2qdcEjP+1sqgJo
	7exY3yjGy/MrQ+e4GTfjuOU8t0WV4M3uDW/uTP0l1NVrZpd2M4y9NSxNERe/uiJiltbKi8xtrzH
	dLx4YORGqne1zZtSNPbbRuKmbJ1+TccI+O+DQIwUmvbQQTIqUDXfyyFDmaSDJQ0s7a4cz+NXqjg
	4=
X-Received: by 2002:adf:e3d0:0:b0:368:3731:1614 with SMTP id ffacd0b85a97d-36b3639c90cmr2555960f8f.32.1721973980464;
        Thu, 25 Jul 2024 23:06:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECcqinn2RbOzn7J7peOWcha9uEPwJVbe5Fk8jNLudEw/NhTNHYXX4sldsTgb73GWvF/16VyA==
X-Received: by 2002:adf:e3d0:0:b0:368:3731:1614 with SMTP id ffacd0b85a97d-36b3639c90cmr2555913f8f.32.1721973979719;
        Thu, 25 Jul 2024 23:06:19 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863aa7sm4031338f8f.109.2024.07.25.23.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 23:06:19 -0700 (PDT)
Date: Fri, 26 Jul 2024 02:06:10 -0400
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
Message-ID: <20240726015613-mutt-send-email-mst@kernel.org>
References: <20240725100351-mutt-send-email-mst@kernel.org>
 <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
 <20240725122603-mutt-send-email-mst@kernel.org>
 <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
 <20240725163843-mutt-send-email-mst@kernel.org>
 <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
 <20240725170328-mutt-send-email-mst@kernel.org>
 <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
 <20240725174327-mutt-send-email-mst@kernel.org>
 <9261e393083bcd151a017a5af3345a1364b3e0f3.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9261e393083bcd151a017a5af3345a1364b3e0f3.camel@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2024 at 11:20:56PM +0100, David Woodhouse wrote:
> We're rolling out the AMZNVCLK device for internal use cases, and plan
> to add it in public instances some time later.

Let's be real. If amazon does something in its own hypervisor, and the
only way to use that is to expose the interface to userspace, there is
very little the linux community can do.  Moreover, userspace will be
written to this ABI, and be locked in to the specific hypervisor. It
might be a win for amazon short term but long term you will want to
extend things and it will be a mess.

So I feel you have chosen ACPI badly.  It just does not have the APIs
that you need. Virtio does, and would not create a userpspace lock-in
to a specific hypervisor. It's not really virtio specific either,
you can write a bare pci device with a BAR and a bunch of msix
vectors and it will get you the same effect.

-- 
MST

