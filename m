Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F171CFED9
	for <virtualization@lists.linux.dev>; Fri, 25 Oct 2024 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847251; cv=none; b=S4u7ONw/oCWz7wLjTC/ZZ7WrW2jeRelu3XNzAdZxK8vKjTyovr1pKoAqcahLlAVjTUoJnphm62KU7EGA6NrT4BSlw5btqw6IgkcUY9Aede68epaAJ1ZmvOrOxNL9HdKOS3p7QqcnFQFCN/tDqCzqyWdsK6dlg+BiIXr+4y2xttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847251; c=relaxed/simple;
	bh=MjaRFk1Boxo8P6hdY50yu0DYYNPmnQY1ff3H1sDc0B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFJwv1GVNMck6CNCQrIqM/dTsU8/vjOu8sliOCGQXm9SWIcuoTFkQzsFC9THPlZpvID5bbkqIHoZDGpmL4VllPHpwsgm7p5x1oRf/YI696KPGAd0wm+28me8UWliDaBexIZsxaZWDMtPmLap4BQO/BFI6KzAyQHKvYbwhpv+1A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFvGhKIZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFvGhKIZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729847247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjaRFk1Boxo8P6hdY50yu0DYYNPmnQY1ff3H1sDc0B0=;
	b=AFvGhKIZwH6cKClzVkSRzM7XsZrc2S4bvSOQPj9XJDNSuXTcey8eOJlDLkW1ESdAcyUEVB
	epYzqO9ilv7cmH3GxHuB1tvxW4bRfoPz/X8NAY+uAHnQ/DrmbZX29JFOZETpDISSn8S53R
	vL2yR0nZp7pX0XhSUpfKNWRXJ6VUPfo=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-4X3qXQunMhWroKAUdrz62Q-1; Fri, 25 Oct 2024 05:07:25 -0400
X-MC-Unique: 4X3qXQunMhWroKAUdrz62Q-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-71e6ee02225so2802307b3a.0
        for <virtualization@lists.linux.dev>; Fri, 25 Oct 2024 02:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847245; x=1730452045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjaRFk1Boxo8P6hdY50yu0DYYNPmnQY1ff3H1sDc0B0=;
        b=sVyU7hE6jDH3c3aL+Q6eQPO6ZMiFfcb/yKMnFEtnikn2XH4DxkI56tHxVyrJ4njtNl
         ttvBZUaJLTOSTiEJxNnbc3mF+QyZp07shJo/skMQhLidUpuA4mmYv0fvM10uzd5t053F
         v74eYLBWfPcooRj7nW6RQoPfkhwUwfczDOujRTVga0RpwqqfKiiwmL2GpW6UeYGmP8Ma
         FlLuqm/qzeHzBAM0hiQtGP7ix/aHxK6e3kzwSyhCf6t6CN/DVubpDqEoR3B7hfPQv7E3
         ViZVbqyYwB5paWCFs9XtKBn3UgAWDe7Ai1PnE8w8acgeu2DVwHE1Lnzaw1eRUG/N//SS
         4zPw==
X-Forwarded-Encrypted: i=1; AJvYcCUsaK6L1DM2/uekqkgo+wRdTI3J0G6Ft0xvpVAhxwhw10hwYGzDbL/+SRYHt+9e7SXtPxvoDW9+eweEYBcH/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgboCz5D2FFX7GsclfQpiENvsrGNaCnmpTqsg/AvtQaorrYIX4
	wp19m2DIoX/tXVdC/367dWa+3r5NsGowXPi/pHWqDVSnHbcVCrGoGpNIBJWkPxYCvCtsfdbI6ic
	ybfzJQU5HGJb2FspevmJOt/NTcmg/aO1Bgo1YH6Sm4RQROUj+tZYlQPrIkOjm0x4pgsTxdPQyas
	RDW11W+g26CwV3tRNYse7LT9SY5Ab13nLAe+KsQeE=
X-Received: by 2002:a05:6a20:d526:b0:1d9:1fac:7257 with SMTP id adf61e73a8af0-1d978bae453mr9708029637.32.1729847244773;
        Fri, 25 Oct 2024 02:07:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzm9XIV+b509V+3GLeghUV+i/VsJ2ey2JtmN7aeUp/k8VVTwMbhlUV4fpMutg66Dalz6b6Cf67HYDB5jwMFio=
X-Received: by 2002:a05:6a20:d526:b0:1d9:1fac:7257 with SMTP id
 adf61e73a8af0-1d978bae453mr9708013637.32.1729847244384; Fri, 25 Oct 2024
 02:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241013033233.65026-1-huangwenyu1998@gmail.com>
In-Reply-To: <20241013033233.65026-1-huangwenyu1998@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 25 Oct 2024 17:07:13 +0800
Message-ID: <CACGkMEuMANCHFSCHCPtcQ4L-qT0uz+B7bWL8gxT46Fyj18fVMQ@mail.gmail.com>
Subject: Re: [PATCH v4] virtio: Make vring_new_virtqueue support for packed vring
To: huangwenyu1998@gmail.com
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, sgarzare@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 11:32=E2=80=AFAM <huangwenyu1998@gmail.com> wrote:
>
> From: Wenyu Huang <huangwenyu1998@gmail.com>
>
> It used for testing in tools/virtio/vringh_test.c.
> If vring_new_virtqueue supports packed vring, we can add support for
> packed vring to vringh and test it.
>
> Signed-off-by: Wenyu Huang <huangwenyu1998@gmail.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

