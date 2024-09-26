Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33CA1ABEA3
	for <virtualization@lists.linux.dev>; Thu, 26 Sep 2024 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342573; cv=none; b=C71d4kRfVLrye470h5Oe7HHxJSWrfoRkg5SMHyPyfGTdLpjlEkWXpg1c4r0hhNr/dzH7Z2X7YWhGgSxgCtlXO55dOEqpu0+OCwRzfMtt9lWIwz5vMf94zaOv8I/b2/c/JYq/WwnPl9uhc6z6EPknL+blupfnM0pMkNIExV+j+04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342573; c=relaxed/simple;
	bh=aEKvNk2FiZ1iLDNVcf8q+9kZ64H5pWqyrVeZEMQ4y10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoM6noSVVyekAu0TV7wkF6pXvLuOH8n8PBRWJpdqUiluQVG+uuQEqXnHDPocQ8RfhzGU1ZTVCcoVZC2DtufkVFEqgLNP+CmPU+O9EwoNFdVpr4MTHG7S1HQlPepf9rSWFgyEoEkiaAxstTDRJdSlkxmBicQH+vFIDLescyBK/G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a0UUV323; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0UUV323"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727342570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xVwxEp61d36MeUHvdY6DKROPmKsWKa+K587S+dQB5rI=;
	b=a0UUV323lgCzlEvbjA0BneLHzSoEGi2pv5XDQh4bh2aSPdniiCmnhEyCaZ9Ig5yIrOnkUf
	oSx04TWl74tgGErP63nu2DLJmacEjatPUEKFbsvU37a1dSSSPZE/93L7U62VUCIROKGZGh
	GFu4dm45R1z5puf/8Nc19k2jSB0t1qU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-V4OsV4m-MeuosxXeKndEsA-1; Thu, 26 Sep 2024 05:22:48 -0400
X-MC-Unique: V4OsV4m-MeuosxXeKndEsA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cceb06940so4601505e9.0
        for <virtualization@lists.linux.dev>; Thu, 26 Sep 2024 02:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727342567; x=1727947367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xVwxEp61d36MeUHvdY6DKROPmKsWKa+K587S+dQB5rI=;
        b=L4CjbAWIUJqJGK6U81zO1avp/g9M/wZxOHH938Ib12FsyMqSfpzpVhlp6gBRyQhQ2A
         hfkx8UK8ERs4rzHjcp7n+IbYf7WHtB1JViBG3ciGhKXR6kUpemY02yIQGO5MDvDtN8P9
         E1KKLZm4DJCzyVbwMpzIip0klYPSmvJivx9WNg9T9YNnJLVf8cOFaqgZcm0ahTyf+K80
         rqYeX0sA1yhI3dr/wgtf9Ia/j7Z4BkH6A0I+6UYUzEvoea9iFOSAoOc0+AxfLTzoegO7
         HEAONBnfkstT/9jHGhCaTlMAkvzO5cDRmHqTSrXJEoPG3PvfqUuhuKm+ahB3VGbwyDCM
         SbRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpL7zykXbGhsMxTAKZeUTazk3Ps0OmUo++m3tY7krL7Iq205sVe2d8to1S7nWDUh8U3ZlXQsY2GOsGtkrvHw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6nxKRwXiQYqzW7aLeYfm1kWNklNrX6VGUnCb/9ZPPkx3tnXpm
	+Zi1JMpi4UyGUN8VPSwJS0ugeAwOmKIlcWrTjBWK7ZnFWLN9nmq4CgS0a6XN2ieng8jGXExI2at
	vyuUPXNlcEEwi6E2MPUjozdFFvLHZFetqecD2WFp3X+ShxeS2eeFrfSW10cn8bA3p
X-Received: by 2002:a05:600c:314a:b0:42c:bd27:4c12 with SMTP id 5b1f17b1804b1-42e9610a9c8mr39799545e9.10.1727342567196;
        Thu, 26 Sep 2024 02:22:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZMn6vPjZvvRr0z4ON2PfRGPV7mbPum2AR4SR2M3xZoxDr2O7HU2Jo3C+NZbT24MrobqOmyQ==
X-Received: by 2002:a05:600c:314a:b0:42c:bd27:4c12 with SMTP id 5b1f17b1804b1-42e9610a9c8mr39799265e9.10.1727342566712;
        Thu, 26 Sep 2024 02:22:46 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b? ([2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ddb85sm41419025e9.2.2024.09.26.02.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 02:22:46 -0700 (PDT)
Message-ID: <ec30359e-11a6-48fd-9d06-c030307f970c@redhat.com>
Date: Thu, 26 Sep 2024 11:22:44 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] ptp: Add support for the AMZNC10C 'vmclock' device
To: David Woodhouse <dwmw2@infradead.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-rtc@vger.kernel.org, "Ridoux, Julien" <ridouxj@amazon.com>,
 virtio-dev@lists.linux.dev, "Luu, Ryan" <rluu@amazon.com>,
 "Chashper, David" <chashper@amazon.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
Cc: "Christopher S . Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
References: <00fb5876322d2fb77816304b5e2c31731d383b76.camel@infradead.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <00fb5876322d2fb77816304b5e2c31731d383b76.camel@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/20/24 11:32, David Woodhouse wrote:
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

Please have a better run at checkpatch before your next submission, 
there are still a few ones - most relevant white-space damage.

Anyway this is net-next material...

## Form letter - net-next-closed

The merge window for v6.12 and therefore net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Sept 30th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

