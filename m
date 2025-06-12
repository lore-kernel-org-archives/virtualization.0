Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59081170A2B
	for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749715459; cv=none; b=nYXZ0hYvKx6xn+0pS94lNvKDVA02GOuX9NHUXTxGtj50tH1UC26VFoC34xmY/VLUNUQZF3tWe/+eEIcmm/SYMrIci7MX1kw5TpIqlfCyOpukbfw/TVEXRvEI7sDYc6a80LPgGFPLTX4A2UZhg/b0G/UUYv5T3vKEYaKqrCWCXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749715459; c=relaxed/simple;
	bh=dZMHVNBbyE0k8GdpEWwXqBscTuEFNGdf3G5hSUKiNHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foCqED4L/pYr3y0R3sdeESEO9YM7/r5FL7/ODb0rs94LKrtl+P6wC3a053SMw+3XsDIlrfezAKYWWD2PEb8dFEsAWPhvkP6/RAdud6qrHwLUC/MaYw2NgfuD6VDkDFSg7f42dwUyq+S3M9gLa0UgZeiAiBCErnPjup3bL0FgowA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvPsAKye; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvPsAKye"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749715455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZMHVNBbyE0k8GdpEWwXqBscTuEFNGdf3G5hSUKiNHU=;
	b=dvPsAKyeMM+wZAvhdHWOsuLyeuJfM0qVvG9Cv5K4fXe+DIxthEDvxWuz/3Bvmwbi80T/sA
	GELLLAQxhv292HIA3z88URY90THDwWweVKfwk/3hCeefl8xQipTAMOGZSQkfyytR+MYQte
	Zia63cs44dv4MHYASPWrDtTsloej8vs=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-RNqMyGixOZCq4JXBMVUY8g-1; Thu, 12 Jun 2025 04:04:14 -0400
X-MC-Unique: RNqMyGixOZCq4JXBMVUY8g-1
X-Mimecast-MFC-AGG-ID: RNqMyGixOZCq4JXBMVUY8g_1749715454
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-70f841fb19dso9051617b3.1
        for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 01:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749715454; x=1750320254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZMHVNBbyE0k8GdpEWwXqBscTuEFNGdf3G5hSUKiNHU=;
        b=C+KPFrmlryOAwd9JDX4rY3pWFsogUeZvyhIaRCNy1y4hu3d5FwBlsoY5jV3jZhN5Dz
         EyAzrw1Pf86m3/GL3TOwM0A2GOyMS+XfH5dTnwS0//T16EzESQKRvyqpo3M4aw9PhNd4
         65wIwIAt6vUwPWJMtieUVpwnDGVS7R99hJkjH3R2shEu413/+hR5xX798+vFOGv5N0Nm
         tJMLZF8WLxBp54TvsSoL1vZLd9GRRQcrYU97BwdiECC4WggQIR4w7ijj2AaKApaK6G3p
         iE3YPRV1WIKmJLuaMzlUZ2CTb0/QoCxBa2KvUGQZukMTtH718EKtefAhs3jtl6/OnL8z
         Y6uw==
X-Forwarded-Encrypted: i=1; AJvYcCVyPxaXmlpRtpiSoxkGd/Hf2PGp8KSy2Plf2OZyRDFAM3cVS8MKL1v3T0ZEq4rP09/1UFDqCe5mBIoPFt5csQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqPeSqNUgD9jCvxlCf7zxgrejendz6xytOdVIymIotVOCL/i2i
	Vvt2QUOVUmoyTMzGiiA8cdqA6cMM8mQYkyNPx7ILlH08n0tHZzeeJgY5/PmzuTUhh+vosAVI6xz
	oZcrd/9AMdf2HEbex1ypA4zwhQzhhD186q7c7FXQTHqkvzFOsa6X15ZiZ6zdEvBcaAwCSLxlCtu
	2jVnFiwFDuFCJ66ye1u08SydTmHS9YK21XEJzlrOxZXr4=
X-Gm-Gg: ASbGncvxtW62s2RQtqoDGFhXRnJk0CsnXlvQIYgg7VyIYmB6DqHsJHj8D9qRAvKuX68
	FaeSPQY8W3bh5D85MG3gO9qvIiCnjaRb9MjITW1diK0JrnCyohkzk8Zmg0u1B9Tz6hZZl0lgn91
	RA3emTq2D0kxYXZa2Y0MaBl/pJGUq/J+UhglI=
X-Received: by 2002:a05:690c:39d:b0:6fb:ae6b:a340 with SMTP id 00721157ae682-71140af6833mr89683117b3.30.1749715453784;
        Thu, 12 Jun 2025 01:04:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKpH0zV8WAQdWv1lhM5ZZcw077V1kJarsSUj2zqX5HwhgGv6teM4sCUgx4Nym37iltxkdXS6Iqa2//rPnys9A=
X-Received: by 2002:a05:690c:39d:b0:6fb:ae6b:a340 with SMTP id
 00721157ae682-71140af6833mr89682727b3.30.1749715453466; Thu, 12 Jun 2025
 01:04:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250612023334-mutt-send-email-mst@kernel.org> <20250612064957.978503-1-niuxuewei.nxw@antgroup.com>
In-Reply-To: <20250612064957.978503-1-niuxuewei.nxw@antgroup.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 12 Jun 2025 10:04:00 +0200
X-Gm-Features: AX0GCFuxXcX7tZ1g-iY8JvPcecHdu0pQdDpj1BwVsu9-6iJkGFvAwtpFRMmd4Tk
Message-ID: <CAGxU2F6c7=M-jbBRXkU-iUfzNbUYAr9QApDvRVOAU6Q0zDsFGQ@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix `rx_bytes` accounting for stream sockets
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: mst@redhat.com, Oxffffaa@gmail.com, avkrasnov@salutedevices.com, 
	davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	niuxuewei.nxw@antgroup.com, pabeni@redhat.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0pRLfoKM1EAe-kzaT-ciieYsycM3K6JxpfW2Rp2SRMM_1749715454
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Jun 2025 at 08:50, Xuewei Niu <niuxuewei97@gmail.com> wrote:
>
> > On Thu, Jun 12, 2025 at 01:32:01PM +0800, Xuewei Niu wrote:
> > > No comments since last month.
> > >
> > > The patch [1], which adds SIOCINQ ioctl support for vsock, depends on this
> > > patch. Could I get more eyes on this one?
> > >
> > > [1]: https://lore.kernel.org/lkml/bbn4lvdwh42m2zvi3rdyws66y5ulew32rchtz3kxirqlllkr63@7toa4tcepax3/#t
> > >
> > > Thanks,
> > > Xuewei
> >
> > it's been in net for two weeks now, no?
>
> Umm sorry, I didn't check the date carefully, because there are several
> ongoing patches. Next time I'll check it carefully. Sorry again.
>
> It looks like no one is paying attention to this patch. I am requesting
> someone interested in vsock to review this. I'd appreciate that!

Which patch do you mean?

Thanks,
Stefano

