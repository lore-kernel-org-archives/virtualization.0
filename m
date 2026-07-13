Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3748449985
	for <virtualization@lists.linux.dev>; Mon, 13 Jul 2026 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926025; cv=none; b=fJmgSahIVS1Wg+NzQvV0SvbWckcMjpSxhP0/Kjtd/wHUOHBJDB1McOAasl33E8bHcN5WseD09y7ujClYaH81Ft2ID8ovErlgP+IVZHXxnaOLhmUCfMx7Q06afK7aNBmpkXQ17gwq3x1mI3jcjIDoa6wNmGP7StsgbJvMQvUTzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926025; c=relaxed/simple;
	bh=eC5GpoKfKxvsELUEqf2RNXAik2cyFhLNi3JDYAbcpUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYyYB8PqwvjmatisVYGFtTCi+nnnHDWSWC+mqCTHUabA8IuuLGMewqbq4q0cOb60tyfnigA+BdgnaCCHrmErRIoqTiWhwGOgLf2ftYud6AK6nxo5nVtp7zLRQLsk7TJRZ6zKn4qL5ePX/gl4962NerLc4pD2qIOsDhanVzbVBvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/fojiQT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/fojiQT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783926022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eC5GpoKfKxvsELUEqf2RNXAik2cyFhLNi3JDYAbcpUs=;
	b=B/fojiQTdlVwcotgVv3TkDqliAd+0ZRO2jvXCd5A+LMw9NzAF3s3qNh5kh5XYaG6uTYqPa
	c7RKjVej+cSgeQzwXxBBvU0NTTq/hQs2vwB2TxAXOJUhlsJGM1d4rU/8ttX3SAy8XmxvwR
	/0koRD17ZnSJbBkuag+vuMKtXa/Gsec=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-tnaiGzLsMG2KcqtHBRaibw-1; Mon, 13 Jul 2026 03:00:21 -0400
X-MC-Unique: tnaiGzLsMG2KcqtHBRaibw-1
X-Mimecast-MFC-AGG-ID: tnaiGzLsMG2KcqtHBRaibw_1783926021
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81e688de6beso104753507b3.0
        for <virtualization@lists.linux.dev>; Mon, 13 Jul 2026 00:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783926021; x=1784530821;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eC5GpoKfKxvsELUEqf2RNXAik2cyFhLNi3JDYAbcpUs=;
        b=FFoFSlMnpzrv74VYKn6G9RxDOUcaWGbKjIYnmVl6CcKYN2Irll6w6LpWp0WZFccF2D
         ro5h29Cn7twEaYLxlOVV5vdwuc4NLDsAMjLAnjtqlAERNlFzoWsjvbQPTK+blJC67cad
         fjO3tOhhwt2tQ3vh+K7RbAbTU/3GqLlC3F1XXKrPQSHQ53FQ+IONlkf2GswKbMah8Fnd
         VdaO7hOs+D2iIDQdmuosgqYhkm1GPwr36rtqrdn9db+XPDxT5wPhO4EVDa9kt8f81eXm
         Ra8j3PvjLp3iKAxBiZ9wOAzjWPXZHhADryxZXGz/w0lPtMn8VaaiK6ykSgiNUu0GKuYY
         jQOQ==
X-Forwarded-Encrypted: i=1; AHgh+Rolzpev030MUF813k2F8yUFSU1zMRBxCqVHSExWrXuHehU0eDCr3WYcPfgwtViyl/3IzxmKWQcDeHZdqXm+nA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYK0PmxuAXS/YkIygN+txbQj3xhRXeIsivJq40r8+K2lLWr/CX
	m58hj/4oeoKUIlZId1k2+0BX5h7vjaJuQfbiee8IoqQcJZIayjnTbHcI4clMhumWMNSZLQDWHza
	SJ1kMJKuc7OegpUybnyZkmmy3hcrLlD+qVP4F8HuC1If3lzcWSzGY03MrPLOR4e3/139/4jc027
	e55VRlG9loEokurNpqL/YmLxnmSbvshRuSSCKcM5owlj4=
X-Gm-Gg: AfdE7ckMYq7o4zgP8+suzr1799QZgxC2lZwiD4K96LUUbdcEIiFMcIwHOnCcA/G4+qP
	MHNo0vIk4Lz9TKjq/o3BWfl3jCNpoLtETf64ZpesBk4MKzu24TCj+vCJjKMkAxrgcUa4pg/AFN5
	EI3N5qP9q8H99rWpT9ppVNen8wYYs3Icw9FiRVzrRwVeAX3kw62gvaZghpVdptB4ScsU4=
X-Received: by 2002:a05:690c:6f03:b0:80e:dc2:873b with SMTP id 00721157ae682-81e9073d1efmr51155507b3.16.1783926020751;
        Mon, 13 Jul 2026 00:00:20 -0700 (PDT)
X-Received: by 2002:a05:690c:6f03:b0:80e:dc2:873b with SMTP id
 00721157ae682-81e9073d1efmr51155287b3.16.1783926020220; Mon, 13 Jul 2026
 00:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622204343.1994418-1-briandaniels@google.com> <20260712091036.5b0f170c@foz.lan>
In-Reply-To: <20260712091036.5b0f170c@foz.lan>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 13 Jul 2026 09:00:08 +0200
X-Gm-Features: AVVi8CeRKs7MaGFl4VgdlnIBfaYMvYk4BjPSu6rUnReNBedWrQaBg8R849tbmoo
Message-ID: <CADSE00JkzGmN8Hvo1fuAsO1o9TKMrPwpmag-dtcFH1+NvkP6HA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] media: add virtio-media driver
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Brian Daniels <briandaniels@google.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, acourbot@google.com, 
	adelva@google.com, changyeon@google.com, daniel.almeida@collabora.com, 
	eperezma@redhat.com, gnurou@gmail.com, gurchetansingh@google.com, 
	hverkuil@xs4all.nl, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mst@redhat.com, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 63iKsVn3ddV3e7LHYvIO1BsdFpWImK7-iOu7_we1_Mo_1783926021
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 12, 2026 at 9:10=E2=80=AFAM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> On Mon, 22 Jun 2026 16:43:35 -0400
> Brian Daniels <briandaniels@google.com> wrote:
>
> > From: Alexandre Courbot <gnurou@gmail.com>
> >
> > Add the first version of the virtio-media driver.
> >
> > This driver acts roughly as a V4L2 relay between user-space and the
> > virtio virtual device on the host, so it is relatively simple, yet
> > unconventional. It doesn't use VB2 or other frameworks typically used i=
n
> > a V4L2 driver, and most of its complexity resides in correctly and
> > efficiently building the virtio descriptor chain to pass to the host,
> > avoiding copies whenever possible. This is done by
> > scatterlist_builder.[ch].
> >
> > This version supports MMAP buffers, while USERPTR buffers can also be
> > enabled through a driver option. DMABUF support is still pending.
>
> In practice, USERPTR was used on several drivers that wanted to
> share buffers between V4L2 and GPU (so, a previous approach before
> DMABUF implementation).
>
> On my tests with this driver, I was unable use a 1080p camera with
> V4L2 and GPU on crossvm. Lower resolutions worked. No idea if this
> was a limitation of crossvm (I only used it to test this driver)
> or if it is due to a poor MMAP implementation.
>
>
>
> > Compliance Testing
> >
> > This was tested using v4l2-compliance. Since virtio-media serves as
> > a proxy to host devices for the guest VMs, we expect the guest
> > compliance test to essentially match the host compliance test for the
> > same device.
> >
> > NOTE: v4l2-compliance changes its test behavior depending on the driver
> > name. In the guest, the driver name for virtio-media proxied-devices is
> > always "virtio-media", even if the actual host device has a driver name
> > of e.g. "uvcvideo". To ensure the test is consistent between the host
> > and the guest, I created a patch for the v4l2-compliance tool that
> > allows you to override the driver name. All test results that follow us=
e
> > this patch:
> > https://lore.kernel.org/r/20260528163448.4031965-1-briandaniels@google.=
com/
>
> As mentioned before, please submit this with their rationale in
> separate as a [PATCH v4l-utils] to linux-media ML.
>
> >
> > All tests used a Logitech USB Webcam C925e.
>
> Please test it displaying inside crossvm - or even better to QEMU if
> you manage to add virtio-media support to it.
>
> Being at QEMU makes a lot easier for everyone to test it.

Hi,

Regarding the QEMU support mention, I created this series in QEMU to
add the virtio-media PCI device:
https://lore.kernel.org/all/20260630112310.552606-1-aesteve@redhat.com/

Testing was done using an older driver version at
https://github.com/chromeos/virtio-media/tree/main/driver as described
in the cover letter. But I can try testing it with this series. Either
way, the procedure for using QEMU is in the cover letter, so anyone
can try it.

BR,
Albert.

>
>
> Thanks,
> Mauro
>

