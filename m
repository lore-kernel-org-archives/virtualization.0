Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ED52C1A0
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613214; cv=none; b=d8XFQRPo7NdKI4970Zta6qyl4Uz0C84KBgUoTg86JNk0VhI6gzLrOTXO0e3M4SkmRPYcauDqDJ612FZPX6S1tszJ7a2gwoNWskw5x3Uyi188fWTVQTcwd1ufJKVRuCxitPNZKC+46hBqFlHZl8UVXGS8V3q35AK1JUXVKZwanXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613214; c=relaxed/simple;
	bh=/MW0cHjA5IzOddregUHmjjXRlsROk5qw/WwkRF1E0qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ani9IeNkm32FMTujDAAktRslisjlfe32l0Pyo6HdZErPWmGZlB+I3I/Ljb4u1fTNZT73rG5kySz+AkkCqUCmeDxwS4DsvAkGQKVvHHNIPL8qqFyIjFGlUHTYDFylJyRE8KHVSbwvZGuP/MqYJ+2wvjnRb62e5bozBJQVeCV6d5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L2y4PDtP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2y4PDtP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711613211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/MW0cHjA5IzOddregUHmjjXRlsROk5qw/WwkRF1E0qA=;
	b=L2y4PDtPbUMy6OEF7iZciOm2T7jugmA8ghoVoqV+ibdcb0ePAd2erRo47eJ1I9USGTC+fy
	tNwd+cYozVGj/zhDZFI4I9G61NU3E7P2Q6YbUAqocQs74Mpb+UJwNpPNVIy79tgWj1EHcH
	qvF+epPy0qr0WAGha4cHgFuhOxB7zac=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-Ur6lJ-tnOsOFF9q-CKv4Bg-1; Thu, 28 Mar 2024 04:06:50 -0400
X-MC-Unique: Ur6lJ-tnOsOFF9q-CKv4Bg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a04aded772so693134a91.2
        for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 01:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711613209; x=1712218009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MW0cHjA5IzOddregUHmjjXRlsROk5qw/WwkRF1E0qA=;
        b=eKaRYZERtAdLhpEHOQy3PpndajvqHm8O9ylzLboM5OozV4f6afmiyaITErONcoV+ew
         FmBo2g34iKQBU6eqha03y4SV2b5zg4HDsmmBlLS55IbNNn7i3TiQhVGhhKCwze3+Avr/
         jiiA6h/5aPK8U03ZZqRCKcy4Z60NO+w1XfZFMgyr1RX+MFJnimJG1SMBepJwVy/7LyWl
         T88ebPXdRK6BQ+A8H6rjFCHSy68eg4WWHjZ78qPD4zLPEGD6rjkyVLU/VQAWXQ5fyc3R
         PnrxQlqCllRqUZd7QhbKrJDC7su+DZgMcfbLmfLy3O4WDcsfnfex3/XwRnFV0ixSn7X9
         6XZw==
X-Gm-Message-State: AOJu0YySIWvFJySGse+4qyvctNteWQzZnqQAFjigXDBZuB/cUWK4exnA
	QwL4kaoCAN1pgmIuje3FrwJ0ksSy9k9qWbO3jY8jvgBdZWrpwq4fW1wHkHFhPI/pNB151JvUf/d
	7rWnd18A2NBSXn1iKjKm9c91KNC6jIfR6iPrtuXUAoTEoPJiVLncWqCRHsv9FX1A6AKXIrIIKWa
	8E4NHpr6clCiJYXN/HYrJVTbgak7vrKOBbqyJ/qBw=
X-Received: by 2002:a17:90a:dc08:b0:2a0:4c3b:3454 with SMTP id i8-20020a17090adc0800b002a04c3b3454mr1573892pjv.47.1711613209128;
        Thu, 28 Mar 2024 01:06:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr3cKtOM4ZCyHExJ4R7r8BZoA5SFTXeHHD/kYgfJMhl+KEh6JWHIkXDQz44FirN0E+6Cmhpkbslv31U6+rB3Y=
X-Received: by 2002:a17:90a:dc08:b0:2a0:4c3b:3454 with SMTP id
 i8-20020a17090adc0800b002a04c3b3454mr1573868pjv.47.1711613208786; Thu, 28 Mar
 2024 01:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240328080348.3620-1-xuanzhuo@linux.alibaba.com> <20240328080348.3620-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240328080348.3620-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 16:06:37 +0800
Message-ID: <CACGkMEvv5UdAEC4N_AfQRM5TeVnPLC7PWpBvURxn+wSUhjFqrw@mail.gmail.com>
Subject: Re: [PATCH vhost v7 5/6] virtio: vring_new_virtqueue(): pass struct
 instead of multi parameters
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	David Hildenbrand <david@redhat.com>, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 4:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, we pass multi parameters to vring_new_virtqueue. These parameters
> may from transport or from driver.
>
> vring_new_virtqueue is called by many places.
> Every time, we try to add a new parameter, that is difficult.
>
> If parameters from the driver, that should directly be passed to vring.
> Then the vring can access the config from driver directly.
>
> If parameters from the transport, we squish the parameters to a
> structure. That will be helpful to add new parameter.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

