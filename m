Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4332D5B6
	for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044933; cv=none; b=XNvDty/LljBFI9G/3yasrKfay0nrZjKUra2XSRER8cb6J2t08tDq3eFM0gwab2d1BmXGHTL+Q2+clAYjehE4F5X2FelkfQQTkeg7LrkRVvEVrqcoVkYYNFMH+9p74VNIvHM0MDEu3kgNZU7xmpOmmUaOSv5sosmpReNtYvrc8L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044933; c=relaxed/simple;
	bh=NbOq4i9zKkRa2V9I+KrjT0Qn9s31T4hyc04u2fTa/IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hM2qW5fczFZYDBBdxJASBHJLnOhd67bMToaeLc5jZEad0krLQ0z540Uprt68tDMNzV9d/MmXkYBeFp/IwtQoT5Yppin74dHSTq/8Y/O3b9LT7gYjSGukrBhZ7hcgvg47smU/IvhFi1N2bqUUn3OEpA7+unwBYQHE18X9RQRGBqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EASFgVfo; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EASFgVfo"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62f4a8dfadcso2979711a12.1
        for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 10:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758044930; x=1758649730; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbOq4i9zKkRa2V9I+KrjT0Qn9s31T4hyc04u2fTa/IY=;
        b=EASFgVfoqidgEM7KItdA+hKpbWIviYkv122iTPHeKlw19SgwjUFvj4aX7PelFt1K2C
         ZM8l2H2uNnpzQm2753WbIObB2Rbas9KJXVG/GZ318qsDRW2oHWpBK4OR1Oi7jAKT5HBi
         E5OsuO8eBqe6Mxri9/o+Kc27Fho53enrIX9TlK9ZaMF+Z+cCNK+6ns0LOCCjaNs6S8jk
         lUMr6efatG2CXqk29AWcKvQJd6abAMHWiUtYQ9NudX0pQMqiHqfyI/wNcgaS/MLQFN7k
         0luebB0UDqPddxmcJj58K1bKpILTy+3axORx0RxmK0mXzJWGqAY9HC6No9uqm+MAkLfw
         VOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758044930; x=1758649730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbOq4i9zKkRa2V9I+KrjT0Qn9s31T4hyc04u2fTa/IY=;
        b=BTdbwEryWbFH21FhKlrVDHxCwWLdVs8+MoSQtyeRqm/cq9aFyQjq3Rhsezi6zIq1Yv
         91wc39W4xd1R054efMHf4XWdGvtpIkrjZ0Kg7FoB1UeOZjxCofvO09Y6Dl2GaRhOC6Ox
         +mBiWAgacEEeo4EzL9D1DrFBuMqmkG7P72lKoXIEnXamOuOxhLsq768CR1trW+tWKHxU
         eJFEPl2I0ND9CI9i90kxa52foghnNTXRqhRwSzkHppIYiNRvxt39PSsboF2snzeotEEY
         i2btLTji/VcJ0Ig8jBDoKH8btmkUXZqYujihwuWYTTz+bnRke9WYttrQ+nIJe9SxiEcB
         tX5A==
X-Gm-Message-State: AOJu0YwkYYL33om9Jw+zBMSSRGyXaV0dcRb3f4oWTMI0e2e8Q5rDfPqC
	xDIkEyQnxcWDdMy8naO21Goafa/rh5F3Ax+JXLlvR0brrUW1/dqMQREaxnu3PFGyvqrs28YotH2
	tYx1tZycX1XNb1r7gz+/eF5S2NQoZX/1HVLumOAU=
X-Gm-Gg: ASbGncseyX38SpzCJ9OxXc88J3tph7ArbPyLDhlAW1MeP5yAp8CD8+pSZ7xqdd66exm
	n1I06HcJj3CJg+EaEzwT8rc/rLZPLMc1031EHdybOkHBM540gFto3QK/guY/IW9z01gzs0wlZFL
	/8AH++bhmJ0NtzJKbNrQauyTV3kuiDaqAMftywRLQ7OydF+5VXWhXOGe1rWIrbHDYMsiHPh1VOp
	g5low==
X-Google-Smtp-Source: AGHT+IHV4P/1MyKeOs7bN/XFSV0mq7kZ/1K3mKjE33ChD94aALW+8TjgEQ2YOtBJzycitI5jxYHfqT1EL+hLuLqzJ0U=
X-Received: by 2002:a05:6402:524a:b0:62f:4de2:f779 with SMTP id
 4fb4d7f45d1cf-62f4de2fa2fmr5614380a12.17.1758044929642; Tue, 16 Sep 2025
 10:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ff2b81b0-04ba-49b7-8a4e-089f1c875744@suse.com>
In-Reply-To: <ff2b81b0-04ba-49b7-8a4e-089f1c875744@suse.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 16 Sep 2025 13:48:35 -0400
X-Gm-Features: AS18NWBw5rRGbHM45r75OAzFVd_wO4zPVebQpaD1MmrWhoHdqJnQY8VtUL6ULFY
Message-ID: <CAJSP0QWV+=+v9Z0wU9qJcdToDKBnWiGKzOVvAsdyTOtES=oFsw@mail.gmail.com>
Subject: Re: virtio backends in guests
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: virtualization@lists.linux.dev, Stefano Garzarella <sgarzare@redhat.com>, 
	Alyssa Ross <hi@alyssa.is>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 2:01=E2=80=AFAM J=C3=BCrgen Gro=C3=9F <jgross@suse.=
com> wrote:
>
> Today virtio backends are mostly living on the host. At KVM-Forum 2025
> Stefano did a presentation [1] in which he mentioned the idea to have
> virtio devices between a Coco guest and the associated SVSM. One problem
> is to have a simple way to connect the virtio devices' frontends and
> backends in a simple way.
>
> A similar problem is existing when using virtio in a Xen environment:
> Xen allows to use driver domains, so the backends can live in a mostly
> unprivileged guest (this guest will probably need access to a physical
> device like network, though).
>
> With Xen it is possible to use Xenstore to communicate the configuration
> of the virtio device: The Xen toolstack will write the configuration
> related data to the backend- and frontend-specific paths in Xenstore for
> the affected guests to pick them up.
>
> With SVSM it would be possible to communicate the configuration via
> SVSM-calls, but I believe we can do better.
>
> I believe it would be interesting to add the concept of driver guests
> to KVM, similar to the driver domains of Xen. This would add another
> scenario where virtio parameters need to be communicated to guests. Here
> hotplug (both sides, frontend and backend) needs to be considered, too.
>
> With the introduction of a virtio config device most requirements could
> be satisfied: it could enumerate available virtio devices, return config
> parameters of a device (backend and frontend side), signal hotplugging of
> new devices.
>
> For the concept of driver guests those guests would need a way to access
> I/O-buffers of the frontend side. Xen has the concept of grants for this
> purpose, which is similar to a pv-IOMMU. It would be natural to use the
> virtio IOMMU device for this purpose under KVM, probably with some extens=
ions
> for non-static use cases.
>
> This is only a rough outline of the general idea. I'd be interested in an=
y
> feedback. If there is some interest of this concept, I'd be happy to star=
t
> working on a prototype for driver guests.

Hi J=C3=BCrgen,
virtio-vhost-user extends vhost-user into the guest, allowing a guest
to act as a VIRTIO device:
https://wiki.qemu.org/Features/VirtioVhostUser

I think this solves what you are describing, although vhost-user
doesn't have an enforcing IOMMU. The device can access any memory that
was given to it (typically all of guest RAM).

virtio-vhost-user is not part of the VIRTIO spec or merged in QEMU
because no one has needed this functionality enough to spend time
getting it upstream.

Alyssa mentioned a similar use case recently and that the VIRTIO
message transport that's under development could be part of an
alternative solution:
https://lwn.net/ml/all/cover.1753865268.git.viresh.kumar@linaro.org/

Stefan

>
>
> Juergen
>
> [1]:
> https://gitlab.com/qemu-project/kvm-forum/-/raw/main/_attachments/2025/KV=
MForum_20_llGF8DH.pdf
