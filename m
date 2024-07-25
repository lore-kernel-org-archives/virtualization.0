Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753E813FD66
	for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 05:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721886868; cv=none; b=OCPUgDVFie4kNjudfZ+WlqOMX6pfATJxhmMo1tmxVEGenWU2IzHBy8bPm4eG+WbiCqYKetbZzeePoKZBI7jB7Zkp3AMQjYViQ0WEmfmVdrK5pTi6703Ef0tMfHwAQmszCkgD57Dxp+WY1Mak1sVg2/xdV6sDQc0XU/Xo0Oh/u1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721886868; c=relaxed/simple;
	bh=gAZvwL67v0vt6xsxrH6XS/itsYUgy+inKlxURoSIcdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QarFp4RZCoUm45tJXRbGuKwB8wl+pp9YyfY9/l2emfnRTt3+dHkAsGu839kIYkiK4FWmK57JvcUg43y9mM9yahgPm82Y7+bN6xZcckJdz4KUfDLE6swvlHJwCzihbrZTwBQ2ssCSu+N4nGYszKnoPJRgQKjyF8/1fhiLX+lZqYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sg/oqDl3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sg/oqDl3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721886864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dh3yyuBj9HXf2A5cEfYqf0NaFgetwfgWSnefr6wKli8=;
	b=Sg/oqDl3/zMVoIHGHP/9dA9o42bLVI+uErD2W0FnHd5ht+/ozbOH1kk/KqA3weiw0r/QCZ
	Od2bx09pFEGgeEtbU1d6dIsOCp+DW3DmB8qZ9O18JPcbJ8TGLi565oG7HHWD3VbiL3bKv8
	IwAsX6opCb1rXSkEfI1XuzfQyxyk9kE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-wO8UeHasPS6gKukG067RhA-1; Thu, 25 Jul 2024 01:54:21 -0400
X-MC-Unique: wO8UeHasPS6gKukG067RhA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36835f6ebdcso420285f8f.1
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 22:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721886860; x=1722491660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh3yyuBj9HXf2A5cEfYqf0NaFgetwfgWSnefr6wKli8=;
        b=tz/mpSGIYK/me/aLqU6IASxSi9IBe+knulUSKni3ECi9irZgFQNVFlf9A9hdKGJMJm
         PT0sGvzyxqfrJKyuZceUJGERN2MMDr9wcne0l3vrI9JgG1+0v7ZOy6hn7UByycz2dmc6
         fgYvAUvg8mWw6o/pemJbh+Hkw1N/kfh9XbfTNOFof3Fqmdx8kNQXCd34XmR+Vi8IH8Qb
         y96DggbI7W+uL7Jd3i8l6Uknd9EM21wuIW6vjf1RFUrbaAnR4CGKUoAGhfDKaijyLz70
         plB7X7orDN9jVF2g2F8Hc2i+sGHAi4kD/J6zgICBgUgSmO/tz0hoPS0IR3HjsJ33VQMp
         8AbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMi3zS1z99Kc/v4GqTutOtAGR70tuYn6yJ6zn5XlKejxCBO8F17Ch1dJoWMigbldWaJ/W8RVzNq/3noGQM/yGHoXAASzNv5AT9pey3uyY=
X-Gm-Message-State: AOJu0YwzfV7+F3m+RtHA82IfKlsQWMxWwc+xt0kCSeZJ1eHkxFHZlKfC
	5NOxNYJZWLkm3mw4vOAiJhfAKmbf3NeI/7T2mlYZtS00REp9wvgqvoApRAvJGKlFXLZAJuleSR3
	v5E3aPIDuRHEX7ghcxxOQ85X7vmGj2DePqWSg3PSyWKpbbe/Hx8Tc3UHWaYZvax5z
X-Received: by 2002:a05:6000:1942:b0:368:3038:8290 with SMTP id ffacd0b85a97d-36b36421ac8mr707598f8f.39.1721886860525;
        Wed, 24 Jul 2024 22:54:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI3Abal444WmsilGMojUOB9llheQDVQUaMgG30HCOZkmwXntXo9Fy/JkeXGpR8m6xgr9AF9A==
X-Received: by 2002:a05:6000:1942:b0:368:3038:8290 with SMTP id ffacd0b85a97d-36b36421ac8mr707561f8f.39.1721886859582;
        Wed, 24 Jul 2024 22:54:19 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ed:8427:35e3:731c:3106:ee46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857dcesm900105f8f.85.2024.07.24.22.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 22:54:18 -0700 (PDT)
Date: Thu, 25 Jul 2024 01:54:10 -0400
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
Message-ID: <20240725015120-mutt-send-email-mst@kernel.org>
References: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <14d1626bc9ddae9d8ad19d3c508538d10f5a8e44.camel@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 24, 2024 at 06:16:37PM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The vmclock "device" provides a shared memory region with precision clock
> information. By using shared memory, it is safe across Live Migration.
> 
> Like the KVM PTP clock, this can convert TSC-based cross timestamps into
> KVM clock values. Unlike the KVM PTP clock, it does so only when such is
> actually helpful.
> 
> The memory region of the device is also exposed to userspace so it can be
> read or memory mapped by application which need reliable notification of
> clock disruptions.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

one other thing worth mentioning is that this design can't work
with confidential computing setups. By comparison, mapping e.g. a
range in a PCI BAR would work for these setups.
Is there a reason this functionality is not interesting for
confidential VMs?

-- 
MST

