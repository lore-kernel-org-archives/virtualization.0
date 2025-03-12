Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4425C1E8327
	for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775481; cv=none; b=Kq/fsvtidLaHpuVGcrbiLbus8MgOwSxSaWeXPcoK/dQe/l42tXuFyPFus/sadGAw5QO+Lcn4ceun3RHQXn3Ia7z46b91C7gWW71MMORHPg0siMkNzb4f59jF0RPa5xYqTIvLjJs3AGicHi7+IZ00BwCmj5Rye8TmTvg1ku8cjrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775481; c=relaxed/simple;
	bh=P99lE3mJwXPj+GEbmP0xwX+rf4eTqzBXZGRaykWQ8v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IdAhAVb0Yo6aLA+tJoWjHRPqybsbcJPvT6AjCnYtI+aOErlSKiPm1kFjikjSvCPcEUPVZCrkUXFGO9GxPl9K2P3yvT9t71RSDOzuWo8lCU5+31uOvPj+otyjGiWLZk9XFaLM7N/XMiLmpUnBWZhxkNNE5J7Lruy93rGbBWrVrtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f88oE9Zp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f88oE9Zp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741775479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cx0qYAqk+Ndkh+zCqVoXeKfQLXTHj6djYkow7w5DHN4=;
	b=f88oE9Zpbv7MKzJlry80YO3Tca2m5WPgHReWHoyXPRdhPyEiIdvwSxOd2n6jFXBLCqpTpt
	TlTdbVIrdkj9rCWdoM0OcXJV3NPun3QBp9VEULPb4+86ZhG3PWRFdSJ39GcdRFvdgHqLwq
	fg9HRy3ubEA596nsZvUQpC1EJI7rrfo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-wiWEF_W1Piu_N-KMChhrBg-1; Wed, 12 Mar 2025 06:31:17 -0400
X-MC-Unique: wiWEF_W1Piu_N-KMChhrBg-1
X-Mimecast-MFC-AGG-ID: wiWEF_W1Piu_N-KMChhrBg_1741775476
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d007b2c79so19065005e9.2
        for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 03:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741775476; x=1742380276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cx0qYAqk+Ndkh+zCqVoXeKfQLXTHj6djYkow7w5DHN4=;
        b=kOoiBWrS1IGfmLjrqK5zFV0LadcUS0F0958BalLULfpHzrK2Kxqaf6YOI6OqD99GT/
         o2cULMQi7J5v1Qo1xXBPLIqu202WItyZqj+S9I6NrQq3rPyE6wO4puypj9Ic6cD/WYw9
         GLURkbAvMC5cxvl+YR79Qnes2AQl7rv4xG2m2dOtA2dgWdBqAQoiHaLV98RN4rNsybPS
         j7LST3lwhALooJDkRrTV/MjHeFvRDgNbdbWaFI2SNvdtaWWyue644m+j+qeVVr3CJVCt
         ST/94lK7wt+hpN0jHDMN/XnywtPXW0aTeGqbhxxZO3enEDwGsNidpju5lovYFSLLG7yw
         g2xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWOvlI/BNlq+0fAF+PN2n2CPTKAiB92VXvb/QvyFyK7fotlh/qN2Mgwo1klfybV5JsPVfzYBMWcUoJznKfnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUTAK0T7GpQ+ctsM7Ueeqj0pzBbJ5OpE7LyqHdIK/3Yma7DtwO
	cQiWHp3Y//uAotK16aXjQ0uRiuj3bALIGWjU3JCYHAhsADRDaLFOEj0C/n5YOKkfEF4JxmRw2Je
	gSkULjhfZXHpPcOhEjj0MFTu1AyryI7jTuyTNLoJnZuC/qhJCLM7v4FpaYUtoOix8
X-Gm-Gg: ASbGncvCFGRKRBDo2cncK0ZVXytsYk/5d1Fk9NOa1AyekO69HXgrRwP/p5nW5bUDRPf
	vSzW2N/3k6sSIeAeyKlqKeJSufr+ujGX0V4F4ZKRD2sy4Zdkqf8GXyhM1ygGAx9PVnVWYowcTxb
	RATZ0LEw74jQR/YjyaTfx8sObOESp2f1j+474A/tXgyOTnr1jazhlKiCOS0qwwV+rHxxOQ0p2to
	O/mZ3QjSzc6j59AEaje12VKEzkaZaVUMeh0zIMUz5ExYpyhQ0HGgiqOmFXrFN/2Vw4mfMDuowDc
	aYdY4PEm0A==
X-Received: by 2002:a05:600c:1c81:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-43d01be6389mr90683955e9.14.1741775475785;
        Wed, 12 Mar 2025 03:31:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMo39VgoZH85nAphCFnLGhSo95m+X8Gu22NIYuOsLFerRQWzuG2jF+y+KHgzz3MHJwbiYZow==
X-Received: by 2002:a05:600c:1c81:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-43d01be6389mr90683655e9.14.1741775475423;
        Wed, 12 Mar 2025 03:31:15 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a72eb5fsm17374525e9.8.2025.03.12.03.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:31:14 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:31:12 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Harald Mommer <harald.mommer@opensynergy.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <Z9FicA7bHAYZWJAb@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr>
 <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DYrEu0Rjr1Hm1xmGr4gEDeve2gPlu9jk3aw3ND4qXCE_1741775476
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On Thu, Feb 01, 2024 at 07:57:45PM +0100, Harald Mommer wrote:
> Hello,
> 
> I thought there would be some more comments coming and I could address
> everything in one chunk. Not the case, besides your comments silence.
> 
> On 08.01.24 20:34, Christophe JAILLET wrote:
> > 
> > Hi,
> > a few nits below, should there be a v6.
> > 
> 
> I'm sure there will be but not so soon. Probably after acceptance of the
> virtio CAN specification or after change requests to the specification are
> received and the driver has to be adapted to an updated draft.
> 
> 
What is the status of this series?

Thanks, Matias.

