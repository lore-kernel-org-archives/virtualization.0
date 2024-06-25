Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF26149DF8
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719354136; cv=none; b=O86xi5HKdzgT/RlwYE93BXSRvH+kXe3nCq8FuyUItbLvUAeXSCavcoClYFSSbgKjDv2vT9cpyiR2pudHNkglUoO6EolDz/tXf0RR97Bs8BUeO/wFSeaQ7YiNC0HgX3vGrG2pNzXkPEewkS12FAF69b33cjU4WdxFbRgh344s0to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719354136; c=relaxed/simple;
	bh=CT+sk2Ytt9MGpByyhaQ7wR0eTG6aV5txV6U0a2SQdQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3wyXy6Tw3wGKSEhKfriL+d9PkEXaVXIPx8Hde3HejhTTcKfmXFsNt5ZAPjOn+1TQnIrr9zK6+BVCnkgrLwaicxqN55bQtBgbahOWGeQDTCulHA3cTDQ8kMTbA6Ncrz/J7R8jPp2s7aYeSi3Rzadi772XUIVdIkVC8Wg5IQSdNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NgmQt2kx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NgmQt2kx"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-424a3cb87f1so11735e9.1
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 15:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719354133; x=1719958933; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRw32GwIVEPX+VKGt7keuELHgLE2OAFARiZsfNjEDuM=;
        b=NgmQt2kxENNN4dIhYId/npKn0i8+TbzqAf3BBuaJaxj5ldBv1tFiYEK/f+rQYOmcPL
         sABvgKnHpfPyTqkb4Hflq63c3dFMGbTcNMK4zOUAICjDheFZvDsSMEQaEhv+gG78R9Ga
         Rbyvjffy2IAaEESVxpmb9UBhWyTGW/yJT1w28PwPUPbppD3uX2j05PXNf58Hl1bx5tIh
         7Bbfgbc/CgVnqlYZHwN3trj6298RbjcdmGhTb8jPItBJ9y9+VGmNQA+QtjxywOi1bM3Y
         aY4pbBI0/HZ6YJ8xR61yx4twYf+OjG/Otno+wYMHCBpCShHAEwq8HlFXR+SDy6vDOyQT
         nong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719354133; x=1719958933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRw32GwIVEPX+VKGt7keuELHgLE2OAFARiZsfNjEDuM=;
        b=G2agNEvPDtrt+GKuAkycR9JDVpjYo/JM09lkd5Zm3MkQ5QGH25HsmeAb2pQLgFd8QO
         sb16nC7hKAKJhhTkkigsmym+VDFs3B7wcbaW7Z3R9zlj69AYrU3dHY1yp+6bdxQdh/oP
         +HSy87e0XRLXQNE1DVaNHzlSnjSgGcZkm+tib9E3NILc4UTHxcGSY0H3jnV3MlsZWl8r
         Uu/t5wQl4TRF5inL6iVvpR3NbF6wUFU94HjwXHgTl/mz6sRyNZO7LLbAu1WO6BN9fpMF
         ocIQ1xeFicEXAZzklmWWATVehbwkAZu4MkYNzjpkODfHBjFjWp4Mg24oGPG18FE0gGiM
         5ZVg==
X-Forwarded-Encrypted: i=1; AJvYcCU6jFgjxne8iXUunOPnioGFQWfIdgJY5+ZMoKtdsDQl7gFbcC6XCCxT7ACacU3tQKyr3p0e/Qi1PpyIgBtXsqgiO6Do1DnT/nER/ogZofY=
X-Gm-Message-State: AOJu0YzLNU2+6RMEPciaE4c61EHPytrpMXFEITwNaMXid6mnNFMm2UKQ
	MO8pb/kWUewF82UF0VfEyZ2RRPwU1v810A8flUPnLJz4J4+WT8g5Upt4ThckifnLwztNYSVb6xr
	StvE0HPYDlBAtU08s5PKznOg2NQNx93JoPzY=
X-Google-Smtp-Source: AGHT+IF0XX6TI9w/czvpBi7HzAI1d8YJKNGlvcJv6XfswT2Wl99IeE6v4pHQbFEkTmScbB2O/MYGYLKXqh0Ft2bqS7Q=
X-Received: by 2002:a05:600c:6792:b0:424:8b0c:156a with SMTP id
 5b1f17b1804b1-424e5a8f63amr147125e9.2.1719354133301; Tue, 25 Jun 2024
 15:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <87jzic4sgv.ffs@tglx> <ea7c5eda8180904a6caf476c56973a06bd4b5e78.camel@infradead.org>
In-Reply-To: <ea7c5eda8180904a6caf476c56973a06bd4b5e78.camel@infradead.org>
From: John Stultz <jstultz@google.com>
Date: Tue, 25 Jun 2024 15:22:00 -0700
Message-ID: <CANDhNCpi_MyGWH2jZcSRB4RU28Ga08Cqm8cyY_6wkZhNMJsNSQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] ptp: Add vDSO-style vmclock support
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Hilber <peter.hilber@opensynergy.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
	"Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev, 
	"Luu, Ryan" <rluu@amazon.com>, "Christopher S. Hall" <christopher.s.hall@intel.com>, 
	Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>, Stephen Boyd <sboyd@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 2:48=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
> On Tue, 2024-06-25 at 23:34 +0200, Thomas Gleixner wrote:
> > On Tue, Jun 25 2024 at 20:01, David Woodhouse wrote:
> > > From: David Woodhouse <dwmw@amazon.co.uk>
> > >
> > > The vmclock "device" provides a shared memory region with precision c=
lock
> > > information. By using shared memory, it is safe across Live Migration=
.
> > >
> > > Like the KVM PTP clock, this can convert TSC-based cross timestamps i=
nto
> > > KVM clock values. Unlike the KVM PTP clock, it does so only when such=
 is
> > > actually helpful.
> > >
> > > The memory region of the device is also exposed to userspace so it ca=
n be
> > > read or memory mapped by application which need reliable notification=
 of
> > > clock disruptions.
> >
> > There is effort underway to expose PTP clocks to user space via VDSO.
>
> Ooh, interesting. Got a reference to that please?
>
> >  Can we please not expose an ad hoc interface for that?
>
> Absolutely. I'm explicitly trying to intercept the virtio-rtc
> specification here, to *avoid* having to do anything ad hoc.
>
> Note that this is a "vDSO-style" interface from hypervisor to guest via
> a shared memory region, not necessarily an actual vDSO.
>
> But yes, it *is* intended to be exposed to userspace, so that userspace
> can know the *accurate* time without a system call, and know that it
> hasn't been perturbed by live migration.

Yea, I was going to raise a concern that just defining an mmaped
structure means it has to trust the guest logic is as expected. It's
good that it's versioned! :)

I'd fret a bit about exposing this to userland. It feels very similar
to the old powerpc systemcfg implementation that similarly mapped just
kernel data out to userland and was difficult to maintain as changes
were made. Would including a code page like a proper vdso make sense
to make this more flexible of an UABI to maintain?

thanks
-john
