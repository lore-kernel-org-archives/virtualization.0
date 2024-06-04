Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D6F14372A
	for <virtualization@lists.linux.dev>; Tue,  4 Jun 2024 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717490768; cv=none; b=HDgNftT5h0YlzkAUp1N+uOmr8RxT4TjN8DrVWmZCSVQADHdMFqCID/sKWwuN10rZu2vSUGcSPQKDCm2wVl5GGx+5TEUl76URVhtzwzGb1oh+Z7vnmB8d5lvmmoeHPxJEPu6S5TJj24VSmkci16SUoVbLyn/C/fhXaTb3gE5XUSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717490768; c=relaxed/simple;
	bh=6QW77IH+sNPGTE58ARlK23gSVIkIZyd2+iYehxFk6vE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDVvYllab4IpuGiwbhBC+tbhjgEI70bGHyn0Wp1J4CNqOlC1yqfcqyt/IMCYkH85YPR6E6GTv+8EUWMqTNhWldnAxKEGXP0GmVQR/KiCnng5i34Z5G3UWAnmklYnr4M59TVaH3c62jCaJgIbSMpKuGuTOgR0b7dBeegjD0gtCBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Nvn25SQl; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Nvn25SQl"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a68f1017170so74726466b.0
        for <virtualization@lists.linux.dev>; Tue, 04 Jun 2024 01:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717490765; x=1718095565; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5PIQ5OeoyRbjANDaCct5hBuvny+p+kJOWKhnvw9On+U=;
        b=Nvn25SQl3H9keb4YnjhY7XjtGyA9E1QvpQwQLGlYXj7+MR+FpcwqQHL9zy1IGOK0hm
         uHgy40N9IOMrWrVBVT0hRF8REzerVWxw788prd4la3S89QQA42p5ol+Y51BEuIDmWX0c
         3wa025GCJExsH7u6xoGdRoOm1o7MR4lE0Sebc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717490765; x=1718095565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PIQ5OeoyRbjANDaCct5hBuvny+p+kJOWKhnvw9On+U=;
        b=KDioUH7BjGC/AADAX1W4wTDeeGSWNaC1ejzRzkWXzey40OSiUKGv5cxPpZAPKxuPU4
         q6Sc/xT24eOlNudLjuTxkDSZ5wsp8tSVW1VLzkp8enbn+Iib7wjsAffXGiwbgIFdChCT
         aeqVxbdqFXRuny0s92AqsMeuddveCDBk+fJkAYDn8ZdTMb5oXJHRI6UhgqHNMfF+q4Cl
         9uLYlZcU+YkJ8/2VeRMJbHk0E2Aj398nyVYVilyqiR2JJH2jBpgIrLO24o+TQvdSMLFi
         WAwDATL3fwOjZrUOepmuh8KGmp3KM6xM41rtnhrGzPjyUDWki2pGB2vS39yk2azf6/tM
         Ap7A==
X-Forwarded-Encrypted: i=1; AJvYcCUh8QjqIEByEP/iR19iLkjiivdxpmiVXJNxsf0iI4gxObd4tPsglQNAKEpueghJLKz6MQ/cL+Xh6eoxjyR2+OMw4hDCO2MXd9IVIm5/J0M=
X-Gm-Message-State: AOJu0Yx4Pu2MtHzqkSl0EdH+B/nQ+yXFdH8GzOg84g+hPxWB+LBW92tC
	MRQZ+FCFRlQwRt4Wz6Mi2WdK/Juc8ID0H7+X58t4arM5sNRffpR3pIhytZTHuoag1GbE6KtXS/v
	Aak47SYnbg6kBHeyPhQne8ZjyOBuu0JZnEwi3Rg==
X-Google-Smtp-Source: AGHT+IHgkfusvPHhLtLVHVn4AGoB410H7KwiUyCLgrid+xwql/WK63qVPZkq3l+OoMOi82rukzCMJm1RVEGDIu8UIic=
X-Received: by 2002:a17:906:56ca:b0:a68:f43f:6f31 with SMTP id
 a640c23a62f3a-a68f43f708fmr349833566b.64.1717490764724; Tue, 04 Jun 2024
 01:46:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
 <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
 <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com>
 <20240603134427.GA1680150@fedora.redhat.com> <CAOssrKfw4MKbGu=dXAdT=R3_2RX6uGUUVS+NEZp0fcfiNwyDWw@mail.gmail.com>
 <20240603152801.GA1688749@fedora.redhat.com> <CAJfpegsr7hW1ryaZXFbA+njQQyoXgQ_H-wX-13n=YF86Bs7LxA@mail.gmail.com>
 <bc4bb938b875ef8931d42030ae85220c9763154f.camel@nvidia.com>
In-Reply-To: <bc4bb938b875ef8931d42030ae85220c9763154f.camel@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 4 Jun 2024 10:45:52 +0200
Message-ID: <CAJfpegshpJ3=hXuxpeq79MuBv_E-MPpPb3GVg3oEP3p5t=VAZQ@mail.gmail.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, Idan Zach <izach@nvidia.com>, Oren Duer <oren@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Yoray Zack <yorayz@nvidia.com>, 
	"mszeredi@redhat.com" <mszeredi@redhat.com>, Eliav Bar-Ilan <eliavb@nvidia.com>, 
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>, "mst@redhat.com" <mst@redhat.com>, 
	"lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>, 
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 10:28, Peter-Jan Gootzen <pgootzen@nvidia.com> wrote:

> Will the FUSE_CANON_ARCH then be default/required in init_in from the
> new minor onwards?

No.  It just indicates that fuse can translate constants for this
particular arch.  Also I'm not sure non-virtiofs should advertise this
(though it shouldn't hurt).

> If so, a server/device that supports the new minor, would only need to
> support the canonical format.
> The fuse_init_in.arch_id is then only really used for the server/device
> to know the format of IOCTL (like Idan brought up).

Yes, for ioctl and also to reset the FUSE_CANON_ARCH in fuse_init_out
if the arches match.

> Who defines what the arch names are?

uname -m

It's already defined by the kernel.

> The last time an arch with its own constants was added was 12 years ago
> with ARM64. So the header wouldn't change often. Or is this something
> that the kernel avoids in general?

I don't care much, it's just that I don't think defining constants for
architectures really belongs in the fuse header.

> If arch_id is only used for IOCTL and the rest of the translation is
> through the canonical format with FUSE_CANON_ARCH, then I like this
> approach.

Yes.

> I think that if we introduce the canonical format, and also require the
> server or client to be ready to do translation from and towards the
> handshaked format specified in arch_id. Then it will be overly
> complicated on both sides without adding any value.

The point is to only translate to and from the canonical arch.

That doesn't mean that the kernel *has* to translate some obsolete
arch, because it's useless.  Only add complexity for things that are
actually useful.  And the proposed protocol supports that.

Thanks.
Miklos
