Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C572F1D54E9;
	Mon,  7 Oct 2024 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317376; cv=none; b=LYdTan/HgCqo/PGe0ZzutSTc5kO0m6m28K8UWXUWfPvQIZ7Ke9KMu2TXWzmiZjEmkUvHVaqH8+coT9hfQN8O3H0U8tWwK7r6dviYqQ8kIdzMPnCH2ZJz+pMaDrq/pUGVjkOVS/b0IyW6LxfP0/UxHSMzBP5Nz8486SxyL4Lwehk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317376; c=relaxed/simple;
	bh=3mb7yUzPJBdZPVqbA7eNyAp58cTHLMDgCs9vohGGY2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZwPQVXiO+ijvKI6atg/iQ6FwLNkoRH61SUA6RaHvSE8jQxNHnbUJDR16HlIvsqJCNdnAaSWPADCDKWwaCbpjZDvWuxegmr66GvQQfQJAcJyRFX9xYwc4lHaz3I2e1jNuGrVcNbo9OK0PKQAAtlTXtZygXjvob2/dK/soCsCygs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mu/J7FQX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu/J7FQX"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b4a0940e3so44169065ad.0;
        Mon, 07 Oct 2024 09:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728317374; x=1728922174; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jbnVqVnf/+P0rl51L6+didESx8C92ZvLSqC1mWtGnLk=;
        b=mu/J7FQXiT/pEGMUR+0ysELTv6NqYpC30roXVI5rk2F/dRU/384CGxc/W9VC5rxdEu
         ODR+++6N9h1wcZIC935Vg6iujdnMevTFu1SGQcH1Ct8Z5VT4WlEJMlOSU/NCycYVsADE
         TlUuxQiPx3NmSW9d9IMfCvRWsGYNrQc84VQ7Ve058Jt4IqI4l6rhZAbNiMVCfX6n1HlJ
         DFtmatJNEJG8j+YtjdwA/gcVXxSC09af72xss1FLC67Q/FLf7gYKjM9Q7RK6DvNiyBpq
         VzzLExmDzj3cMXwjtixrJ5xGVjyCtJdPmX12+0dAq3wMOCgzjPkLwJ6sxgrtWOXupxsn
         hRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728317374; x=1728922174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbnVqVnf/+P0rl51L6+didESx8C92ZvLSqC1mWtGnLk=;
        b=B2/2umr1hqth+Nm8yR0n4f6ACDLfhf/5/slDGT15voTUbhwKfMtZQdq6VRxooF6dY0
         cDyFnXIidRKiLiDTENoXtHQccpW/CMfrUE8nESvH6coxsVFZHWqeTeAQ3R9WyhfoNgw1
         rN2kPctzAO1oukfKpocnHK4EmzkRvVf/rtZIUf5K2+Ex6H+CRMXthhBy3yMMnp6DWBWo
         Hpbgh4y2ciIKgIAJjC/lDomeGi9+GS69WlwwtCOV8AZD6M/MUpdODjao3oh87+ykDwS8
         Diy6O1AYplqMNx3AL3SZWOn6l7CgDuhBZb7aec67RInHgNTlYx2Y6H1ZReIWBQr6pDGW
         JqSA==
X-Forwarded-Encrypted: i=1; AJvYcCVTTX1P4JiUkCm2To8BeWzEBLJeEJitjfWjFe5RgtTEdfSYFIX3Iv3lvnPFVyE13doOlcy/cGTX/pbWFrJm6eo=@lists.linux.dev, AJvYcCXA7uIgaiJe19yinZmbvRL5lvEaGq9cF8V7AhlBGAWwxHtQoqzDbfePj3MUgZjo39NnZQpqmHoyiTkZ@lists.linux.dev
X-Gm-Message-State: AOJu0YxZpVUPz0WgEeCDJ7NxoanAowFQhWQhp6jotkowo87xFTzl/DGs
	S37zUsNGbEo4Wu4TrIwX1BrfXIX2gQM8DarbRQ0QM9WNoWAMxP3D
X-Google-Smtp-Source: AGHT+IGRJ8PDY2uvOdrScF+lvW+ErLKYmvUUU9Ley7KXKt2lpYDNWDc7FzwaUgY9vidSx6egFuHhvA==
X-Received: by 2002:a17:903:2445:b0:20b:ab4b:544a with SMTP id d9443c01a7336-20bfe49471amr194072435ad.43.1728317373996;
        Mon, 07 Oct 2024 09:09:33 -0700 (PDT)
Received: from hoboy.vegasvil.org ([198.59.164.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13988d0bsm41141785ad.262.2024.10.07.09.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 09:09:33 -0700 (PDT)
Date: Mon, 7 Oct 2024 09:09:24 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	"Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
	"Luu, Ryan" <rluu@amazon.com>,
	"Chashper, David" <chashper@amazon.com>,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Christopher S . Hall" <christopher.s.hall@intel.com>,
	Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
	"Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v7] ptp: Add support for the AMZNC10C 'vmclock'
 device
Message-ID: <ZwQHtD5lVNuc4aAf@hoboy.vegasvil.org>
References: <78969a39b51ec00e85551b752767be65f6794b46.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78969a39b51ec00e85551b752767be65f6794b46.camel@infradead.org>

On Sun, Oct 06, 2024 at 08:17:58AM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The vmclock device addresses the problem of live migration with
> precision clocks. The tolerances of a hardware counter (e.g. TSC) are
> typically around ±50PPM. A guest will use NTP/PTP/PPS to discipline that
> counter against an external source of 'real' time, and track the precise
> frequency of the counter as it changes with environmental conditions.
> 
> When a guest is live migrated, anything it knows about the frequency of
> the underlying counter becomes invalid. It may move from a host where
> the counter running at -50PPM of its nominal frequency, to a host where
> it runs at +50PPM. There will also be a step change in the value of the
> counter, as the correctness of its absolute value at migration is
> limited by the accuracy of the source and destination host's time
> synchronization.
> 
> In its simplest form, the device merely advertises a 'disruption_marker'
> which indicates that the guest should throw away any NTP synchronization
> it thinks it has, and start again.
> 
> Because the shared memory region can be exposed all the way to userspace
> through the /dev/vmclock0 node, applications can still use time from a
> fast vDSO 'system call', and check the disruption marker to be sure that
> their timestamp is indeed truthful.
> 
> The structure also allows for the precise time, as known by the host, to
> be exposed directly to guests so that they don't have to wait for NTP to
> resync from scratch. The PTP driver consumes this information if present.
> Like the KVM PTP clock, this PTP driver can convert TSC-based cross
> timestamps into KVM clock values. Unlike the KVM PTP clock, it does so
> only when such is actually helpful.
> 
> The values and fields are based on the nascent virtio-rtc specification,
> and the intent is that a version (hopefully precisely this version) of
> this structure will be included as an optional part of that spec. In the
> meantime, this driver supports the simple ACPI form of the device which
> is being shipped in certain commercial hypervisors (and submitted for
> inclusion in QEMU).
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Acked-by: Richard Cochran <richardcochran@gmail.com>
