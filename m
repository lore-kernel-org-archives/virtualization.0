Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6506244EAB
	for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786098; cv=none; b=KXXs2oUvi76HIMfnU0jRJtnpjbmnRYhYUOci+65qq5j0v6EGWr78ys8zI8bu+QtoKhTuJj52/G3ML3ZWR65ehhucQrc6ccrLXIerrdv9UYEj9SZmsYdlEV+53LTHc0NREtRx67MFf1l9UWHIeAT5CpsYLI8Y6X4dgVP/av8d2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786098; c=relaxed/simple;
	bh=bppsgeCLPOVJeGMR97jVKd7rPBeAw9kXU5zpyCLPEJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=E2SRxARIr/q/UbqTewHUhc1U+8hZXmrQL/1knlxZAJAkMhnOu4ZpVQRxKs/fleo4+nWUgdi6dnqt+WeCiWKXuGYH7luhfZHtpRNXedESKLOupc//QxcrQCQZRJVVQoEL727J1mXLaYBWQi7MzCFFcOUgZMQGt/mKIeVGgtr+7x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sv/3pAYv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sv/3pAYv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741786095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cd4wn8Fv1QUp8UgtRjUbrAGy6ACAXSarUlDGzc+cAok=;
	b=Sv/3pAYvpBsFn/8q7A3AwpJzWoAL7ZWKhDdhph+JQWMntNHZbZWSLeboWS2rSByT4G7Bru
	CARtot8l0Jzrivn64QJcchrnwFEVSyjQHu1DPAqUciatwAIlElc+Dr3DJuIvDbyR3Bjra5
	C9MkD7kNjmed91M9frOLe51cvrXCJP4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-tDsqGUYRNy6yO5o8LVxs1Q-1; Wed, 12 Mar 2025 09:28:14 -0400
X-MC-Unique: tDsqGUYRNy6yO5o8LVxs1Q-1
X-Mimecast-MFC-AGG-ID: tDsqGUYRNy6yO5o8LVxs1Q_1741786093
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso34933615e9.2
        for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 06:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741786093; x=1742390893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cd4wn8Fv1QUp8UgtRjUbrAGy6ACAXSarUlDGzc+cAok=;
        b=eGr1z9ItANuejCUyu1ZYkODjFZ4k+abelnvHbB4eP3vk0QGU5PepG5tjonTTXLgX9p
         2o6j2UMf3oAetDcINHqzeY7hj31JqTM5BdRuS/38uSGLRo0+Kk+UxFr+GJZ0opwHQ3Uj
         X7mky7GHgywSWR19auRKROhpzY/Sf+PmxBevU5ueFuyNgeF5iCok1h0zBO8SeWe9mQIk
         6Rv0HfbIi+1EiHjP/Vzwkb8zSvnnTgoy6ulLvGTLsXJL2+ctZrbocv9hpfwSqZjPUa8b
         TO4XuI0734jqV6jy5YIVtiwN7i3BgsQtENKbI8uGkV1rv1yCIzQHSobI3zsRadRrqaKr
         R9sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAvb84S6Qw20VhzkiuVWJ2izcD8slhdg+L08CUJcEUWu6NcRad5NPhVnxJ2HimedafvmPEezeYMH4A/EeDng==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYNZs3J8bsacZAZlKEW+3yYm+tdsbiOwmDsI01zCttLLMsTl8B
	hkgcMeFIuTJ1R0CSG+X2VS1DgLFgIc2/cJ4T6//R6Gx7E9Q4PHFNwKiHqyQK7B7j8XoZ1bGo9hf
	9jHiuza8mcgzH6RZ4ZJeGMzxgjtVPbVZB4d3/k7kClLJcDHnojJ+gVlqqytjNUH8W
X-Gm-Gg: ASbGncs/GAS98WdZw4B6AFHr/5k9Onhwt6b8LU3rMnx96E/YukKuxEx4HwM70fu4B2F
	RVTeAWP+ANHPSuTdsXOn1n07hWC6bydoTW979d1YS6Zgw3/p5VE5kmUqArTtNOxINQVnKKCfYwr
	kbiIT9/zLlMCIqrycFjQXEvM0D+UL81stb+Xebvjs9K2iwETGhoC600qPLaPMG3j4DPwEum3aJb
	KWL7gvwURuoHpkycdeX4Ove0Emx459c4ZFNns9nqMGjuK66pgBYhvKYEfoGLAoPWcnvkuEtTzHW
	qIbCMZNEHg==
X-Received: by 2002:a05:600c:198b:b0:43c:f5fe:5c26 with SMTP id 5b1f17b1804b1-43cf5fe5e0emr116970085e9.4.1741786093069;
        Wed, 12 Mar 2025 06:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrFZYXg7iC/H/VXbl+Ds5zQUdtIQbQ9fB3jQl6MW8bK6C7iTZoHzvzY6YXwej9HbMobpTCbw==
X-Received: by 2002:a05:600c:198b:b0:43c:f5fe:5c26 with SMTP id 5b1f17b1804b1-43cf5fe5e0emr116969905e9.4.1741786092685;
        Wed, 12 Mar 2025 06:28:12 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a72eb5fsm22019125e9.8.2025.03.12.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:28:12 -0700 (PDT)
Date: Wed, 12 Mar 2025 14:28:10 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Harald Mommer <harald.mommer@opensynergy.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
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
Message-ID: <Z9GL6o01fuhTbHWO@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr>
 <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
 <Z9FicA7bHAYZWJAb@fedora>
 <20250312-conscious-sloppy-pegasus-b5099d-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250312-conscious-sloppy-pegasus-b5099d-mkl@pengutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Lf8Pz4a6hCwdB10I9jh4pMx5dTgoS3md5gD1BZtHFXw_1741786093
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2025 at 11:41:26AM +0100, Marc Kleine-Budde wrote:
> On 12.03.2025 11:31:12, Matias Ezequiel Vara Larsen wrote:
> > On Thu, Feb 01, 2024 at 07:57:45PM +0100, Harald Mommer wrote:
> > > Hello,
> > > 
> > > I thought there would be some more comments coming and I could address
> > > everything in one chunk. Not the case, besides your comments silence.
> > > 
> > > On 08.01.24 20:34, Christophe JAILLET wrote:
> > > > 
> > > > Hi,
> > > > a few nits below, should there be a v6.
> > > > 
> > > 
> > > I'm sure there will be but not so soon. Probably after acceptance of the
> > > virtio CAN specification or after change requests to the specification are
> > > received and the driver has to be adapted to an updated draft.
> > > 
> > What is the status of this series?
> 
> There has been no movement from the Linux side. The patch series is
> quite extensive. To get this mainline, we need not only a proper Linux
> CAN driver, but also a proper VirtIO specification. 

Thanks for your answer. AFAIK the spec has been merged (see
https://github.com/oasis-tcs/virtio-spec/tree/virtio-1.4). 

> This whole project is too big for me to do it as a collaborative
> effort.
> 

What do you mean?

Thanks, 

Matias

