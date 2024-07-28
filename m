Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705AC51C3E
	for <virtualization@lists.linux.dev>; Sun, 28 Jul 2024 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722180245; cv=none; b=DT9iY/W2EDaRSzd9ERTbY+pj75ViGBCxEYwCxwBV9zHiTpe5tbyjBY71SUutqSg3kGgXQyJgkJmKGWb8lBNKemdty77+XmS+TTm++PiPV7aUTDrlMFQsVQkzSEvGSw9f2is9V1zqBQoEsgYo0vEzbpws7yKHdU5VRCaD1P+F6XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722180245; c=relaxed/simple;
	bh=IOwAsnqgHoluJc7mNb67jddHNZA6RYbBXNw2KHo1ji0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TY6PsT7anpMJZp4ayKEa0U18O7pPIxG0Vh07y0SKXTCoe2zBASTLTaN5lLnmSO82ED78AUz/By+fYgLaqxrTknmqc1Vnlh+1LaiDjuH4GZX3kF3nbnG3km/e4yUEIehY6F5XJlgwQMgAev6ZgoiyS7GBv67kZpAjpH2bMw7mrD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dcT+0eM8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcT+0eM8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722180242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5bC7CjlZdsdHI4lvHiT2ExOZBWJ7XMhmuhfoptCNZqw=;
	b=dcT+0eM8BW7APhf0SQlvSFgEGeGTGM2vi8sD/0ZaVLUCS96cyeSh5EAC6kCj6QYNaxx/WI
	Afl6CtwiI08M/Tf1qwzRF1Pq9MnTpfkALAjRMU7knEbxZ2w1eWQBnxN9KIljmvF17lEMZ5
	kixlI7Ox6S1Mzcht22PUMcTldXuNNXU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-l1Lr68IGMBO3fbLJvC2edg-1; Sun, 28 Jul 2024 11:24:00 -0400
X-MC-Unique: l1Lr68IGMBO3fbLJvC2edg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef244cdd30so29777081fa.0
        for <virtualization@lists.linux.dev>; Sun, 28 Jul 2024 08:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722180239; x=1722785039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bC7CjlZdsdHI4lvHiT2ExOZBWJ7XMhmuhfoptCNZqw=;
        b=ttMahjJywW0MSGpaDKgkR2eb2BOlNr99zAE2HzkyKHh1tOhqokWbWdccOUb5jNK5Y1
         gr28tLVDEDPz1xMqmSHYCxaoYoGtk9oqj+X5gYfWH45K0aIQY7LbwP+M0c6Av/KG/URN
         VxWqKcPz9hdHUxhnhPe9p3kduMoTytWtK4QgPcg73ZkWf60Abf7eZ8mWR1iCUOrwG7yg
         VgGN95HuLZ8CoRCVSJtEgRgb6GEDp4XWnH9AF+7RCDF22msALUxIIbKiyVmcFMNPrjWU
         TCBljzQuThcgD0UuRZsd5+sKUPSZY5ZKnodECV0cl8Vx6jpx+qhjae6/7DY073799xzv
         JnXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4rD+tgbejq4Noal68HgbLAtzFpgFIPmspo6dVreVTFO+Q1raJGcccDXhQyGp4ixnHpw03UlQgZFHzGVus0eOA/r6wX9wBaMkCQTnZLeE=
X-Gm-Message-State: AOJu0Yy3/2/0Vt3yuH49HLiRiBU+ngzZd3IwEB6xnApocre9RiI4Uafr
	DRy6KC7zfZlwuKw8614MTdtVPxtwno/NUJzgD48uOBuQNXRYE29pyd0bVUR6XYeP28Hm+X78Qk2
	MzACr1SHpfRiyr/l10waqzfmQyQ6tc908TJUReW9XUEJMBuMXSQizBXICmr6ClreXHf8WiVmz
X-Received: by 2002:a2e:be22:0:b0:2ef:1c0a:9b94 with SMTP id 38308e7fff4ca-2f12edfddc0mr34329371fa.16.1722180238923;
        Sun, 28 Jul 2024 08:23:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU13tBt+N37F7ob3Jx0ruuvo8+dsNp9muZtzaqjHOl31gS3qTrnO0jECcjoxvWesNrjNQyHQ==
X-Received: by 2002:a2e:be22:0:b0:2ef:1c0a:9b94 with SMTP id 38308e7fff4ca-2f12edfddc0mr34329181fa.16.1722180238084;
        Sun, 28 Jul 2024 08:23:58 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:98c4:742e:26be:b52d:dd54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428054b9196sm147521925e9.0.2024.07.28.08.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 08:23:57 -0700 (PDT)
Date: Sun, 28 Jul 2024 11:23:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Richard Cochran <richardcochran@gmail.com>,
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
Message-ID: <20240728111746-mutt-send-email-mst@kernel.org>
References: <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
 <20240725082828-mutt-send-email-mst@kernel.org>
 <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
 <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240726174958.00007d10@Huawei.com>
 <811E8A25-3DBC-452D-B594-F9B7B0B61335@infradead.org>
 <20240728062521-mutt-send-email-mst@kernel.org>
 <9817300C-9280-4CC3-B9DB-37D24C8C20B5@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9817300C-9280-4CC3-B9DB-37D24C8C20B5@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 28, 2024 at 02:07:01PM +0100, David Woodhouse wrote:
> On 28 July 2024 11:37:04 BST, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >Glad you asked :)
> 
> Heh, I'm not sure I'm so glad. Did I mention I hate ACPI? Perhaps it's still not too late for me just to define a DT binding and use PRP0001 for it :)
> 
> >Long story short, QEMUVGID is indeed out of spec, but it works
> >both because of guest compatibility with ACPI 1.0, and because no one
> >much uses it.
> 
> 
> I think it's reasonable enough to follow that example and use AMZNVCLK (or QEMUVCLK, but there seems little point in both) then?

I'd stick to spec. If you like puns, QEMUC10C maybe?

