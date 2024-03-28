Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0877C38388
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 04:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711600183; cv=none; b=I2y43fPfcTfiAOzra1TSIxun3BKyy5rCl1pMsG8JyAjVj+4bbjvXtRKxwpTRbwZDSGasY04x4nbs7TtHQ4a3IWui1MOCNzTWuWatPSYUDDq6xeAFw2J1Az5Z0eJX+mtNlp4HBg330BEIzkN0FbVCoHKCy2KDQEKJsGMvQe0ktyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711600183; c=relaxed/simple;
	bh=1QzCz1Z3ysjSBtKSuwdaJecZAl0r65qpJTzi3fJyIfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VErTX6jXWvlCkn2ktyyXvKKxtwa0c8ZB5Uv4srOVheRRD9g0SqdeBiCnZPBCddNNpQwm5O3ZXHdelPMmxpBfJI+QZiXkaTtE+1NvHmRmwfEPbPuqi3U9KKL9My2+3T04x4G8CeWJdxceziToOZvxz5sZG11vFiro2S1/x37dt78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzeMwpf4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzeMwpf4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711600181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QzCz1Z3ysjSBtKSuwdaJecZAl0r65qpJTzi3fJyIfg=;
	b=HzeMwpf4plDjQ/ZbORqWZ7/ykUus+X2WuryLsJkk4+xEN3gdS1RnystF8Dhwd1C9B58JiL
	Odjde8uOiB4qA3KCMGUsmquqhnVjX1jh4D82cT5mP6pCJ6CrgC0dIGSbZ1xkjGSxufft5U
	9QzaDIbahlSy9UUMswaxxsLAXhs+jaE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-ASOXg4cTN4ODXok7-gBxTQ-1; Thu, 28 Mar 2024 00:29:39 -0400
X-MC-Unique: ASOXg4cTN4ODXok7-gBxTQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5d5a080baf1so385271a12.1
        for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 21:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711600178; x=1712204978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QzCz1Z3ysjSBtKSuwdaJecZAl0r65qpJTzi3fJyIfg=;
        b=c3SnNOy0XmuHSq6TI0jPCL1M3lil4g+DAYN1IdTUIu0AG/wvnxO0Kb/KkePh0wZcYB
         VAolkRyHvR8KpEm83e3Yn/odUM8sQ6G/fDicXOnW1GeMiGZGcfV8mKRIh7kuPwE/yc//
         8kchwJJxh52JY4fs1/RiFpRCqLnYVYHwuCJ/+e6QW/kzl5lzE/FCj3dcZFczIRAddgDp
         DSkZMQ+vN904sLL3KMemGh5i4UQFd1V1h2CNUIWOHrnPhRO9J4PkM+NGL3HmNT1+q61C
         6QRdTzKagFEiTMkX0/2XWI2oQbl2w/QX819rPekTftJwY40NUfC0aNi1GBARHw922L16
         WIBw==
X-Gm-Message-State: AOJu0Yw0Yw1bVFevbm5gvHLS5OH6YqYH02r66kusn0MfjTsmQC1buZs6
	flP/++iFVoz3xv6aJQiCvgJC2PksB+mt32EK7xqKUq2Vus+bFe4yy4RhzukIDBRFJ5T6NM50oeR
	4fOBgzoeNWYSjslTmL8WecLu1eCH64GpBQ7eBUFIsGcE3FqRcCoMeq1EEbUwBq0ikPf4pXpkj+e
	3cFyimVDqHF235jaYnzZBfvHkR5EEB7GSZ9MdfJUM=
X-Received: by 2002:a05:6a20:7f9b:b0:1a3:6ed2:ee27 with SMTP id d27-20020a056a207f9b00b001a36ed2ee27mr2348501pzj.16.1711600178157;
        Wed, 27 Mar 2024 21:29:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdRSG9G7uJHKVNNXcj0F+YxANq94mAXIs7d49a5PjNlTRz4N2ThVivJdAz+RFXtJHhPLT9mm3BTBAY6vJ4ZyA=
X-Received: by 2002:a05:6a20:7f9b:b0:1a3:6ed2:ee27 with SMTP id
 d27-20020a056a207f9b00b001a36ed2ee27mr2348485pzj.16.1711600177897; Wed, 27
 Mar 2024 21:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327095741.88135-1-xuanzhuo@linux.alibaba.com> <20240327095741.88135-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240327095741.88135-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 12:29:26 +0800
Message-ID: <CACGkMEvAUNSC2VnTLpbCR4Zq=rTOW-CHvXLvB1PuGadf6J77UQ@mail.gmail.com>
Subject: Re: [PATCH vhost v6 4/6] virtio: vring_create_virtqueue: pass struct
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

On Wed, Mar 27, 2024 at 5:58=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, we pass multi parameters to vring_create_virtqueue. These parameters
> may from transport or from driver.
>
> vring_create_virtqueue is called by many places.
> Every time, we try to add a new parameter, that is difficult.
>
> If parameters from the driver, that should directly be passed to vring.
> Then the vring can access the config from driver directly.
>
> If parameters from the transport, we squish the parameters to a
> structure. That will be helpful to add new parameter.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

