Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66F383B1
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 04:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711600951; cv=none; b=HhDk4RUvUvQq77D3TA3AA6IK4CelKvY49+Tw17e5BV0XWe3E36LLzaVukrJkTdjnzgrSujL7E3XYuucDh/mN8iF0DUAtzlCSoi16vvExA071z4x71OlPOcnSxz87b5jnSgvLGAoTW9mvvMzboluBxYb5vmbGzwWnCTfwgnAQtbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711600951; c=relaxed/simple;
	bh=lke8Mb/+VlM0WFVcd6AGtqJ7F4qGSoxqh/tNas4oTT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2XM+lv288d0ApiGAJeWXHurNTJ3XXQPB0BU1aaKCRpPempu4j0I0nr7+AMIKFQxML0Yg3Zro98omTzYI24ipRjLtAJTKEm5geLx8P9KASkTQD8dHnzX1URnnbtQjX0xpVN+T6CXKaFPgsIZd4coX+eNqRCSfF/Ea5OgbcGjKFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUWtDvUn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUWtDvUn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711600947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lke8Mb/+VlM0WFVcd6AGtqJ7F4qGSoxqh/tNas4oTT0=;
	b=BUWtDvUnAnIP3vOUCsMV3Zl4WsEThtO6dj50v3AHhtqxjmBqp8t97BR3nkqBS/QmhSs3u3
	de1BAv1PRgirrhgB3KhbRl7kPnHyrXKSRtlmgD4u+j8sb7j8a3qjvZMEkokuEwOL1LAasi
	Zu/nHBLMp7KZu9Y0X4yVrugpIe5QKw0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-122UgVcBNDeZTjDHCTzcaQ-1; Thu, 28 Mar 2024 00:42:26 -0400
X-MC-Unique: 122UgVcBNDeZTjDHCTzcaQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c670f70a37so377972a12.2
        for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 21:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711600944; x=1712205744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lke8Mb/+VlM0WFVcd6AGtqJ7F4qGSoxqh/tNas4oTT0=;
        b=LYRa7O9OhnMX+esanwtIGrH/wzFfIoGfNzAbaUMg+VX8yMLLbXqb0OWRxaIGR3tSqH
         06W2aKQzQQYDDCDcennWXN3qhphuGPCURCu+XeXVdJNBir7LNlj2UeOasjauxHtiQq9O
         x2qvBqQ5EGIvWgu/Fk6Rl2E2fKCxgPnAUj6eAvxU4xN2RMKGggDUha0Aw8rSv64bEVjE
         UxYbM48Gc5oBbPDVFHpZjltNB+pjcoNmUeW7n53AK2lKULJO1L1MNukqpo4bD1hW+sZG
         sqV0yHuSQWJd3fs49ujiGL7IpE4EBinM7kjXAiSNDKI/Cjxdc1qvBuh6qjQVQRbfkD0I
         lxtA==
X-Gm-Message-State: AOJu0YyJSSW+CwRQ5MMMrtZYYqQbVmSFZq5b4g2qE58IIOkbGIYX4Q0j
	CZlO1DvY6/XmmQe6ovLuiO0LXlfLMx86P7hN5LC04PkyhdYbK1BJnSJokZOD4qGGPIX4t7YLe7U
	6RIm1m6xdLgTwE1tTm/eyVbqCRIsU5m6XWRxSCF9tvfAbYMDQlekJ+s5R7/IZSy8YlD5Mogbw7g
	7jwBEdINk0+HEUoanA7zmd+m5whZVD14Szdfk6mIrgpHmypj8=
X-Received: by 2002:a05:6a20:3943:b0:1a3:aecb:db60 with SMTP id r3-20020a056a20394300b001a3aecbdb60mr2612158pzg.9.1711600944747;
        Wed, 27 Mar 2024 21:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGqMeGlScFLGjuf9ntL+wJAbmcBUMH9qH8VV+quAV82wNT4oC4BMh5FM/UUwwoJlJBLwmVhiSP74tk9QYL8V8=
X-Received: by 2002:a05:6a20:3943:b0:1a3:aecb:db60 with SMTP id
 r3-20020a056a20394300b001a3aecbdb60mr2612140pzg.9.1711600944494; Wed, 27 Mar
 2024 21:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327095741.88135-1-xuanzhuo@linux.alibaba.com> <20240327095741.88135-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240327095741.88135-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 12:42:13 +0800
Message-ID: <CACGkMEsViOCh-DGuRqZr=XGT+wJcG68CFAdiTcLc-q_2CtZ8tg@mail.gmail.com>
Subject: Re: [PATCH vhost v6 6/6] virtio_ring: simplify the parameters of the
 funcs related to vring_create/new_virtqueue()
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
> As the refactor of find_vqs()/vring_new_virtqueue()/vring_create_virtqueu=
e
> the struct cfg/tp_cfg are passed to vring.
>
> This patch refactors the vring by these structures. This can simplify
> the code.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

