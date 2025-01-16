Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92CB1DE4FC
	for <virtualization@lists.linux.dev>; Thu, 16 Jan 2025 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737030302; cv=none; b=miTAX3+s1pwWXfX9XHOkxXZu46EUbAhneVviFPce71RuceIQTsKdvtb8hJbt6THYqnwgmVYAse84TXwNHNEQb+kPTr0XgGKltmSSjy7cYXRUQd6RzuUbvm5y3/ZhGmWPv57nOATWfpUr/3kRz7fhyZ91CKVnrFw4Xa2fBh1vSmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737030302; c=relaxed/simple;
	bh=GBwF2KOXlFDp1MGeRltem3iAJtpX3AYE0x8w+f0gonM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RK5+sdedy7KhCXCpvkQ1An+7SGY+m70aUPXIoZpAeGT2Ctokz6UfTGSRpnNO5dPrcrAakYQclVxZaoAUM6535Ghgcm9Iaegunb6Nk1gmmcfBq9WuqyKpbQ6Qs3AI1A5Fa3kK26dgwcqX9ix5xsRNJdCkDfVD8Do/JRHrbtg998Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=KE1RqWwS; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="KE1RqWwS"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b6fc3e9e4aso63511685a.2
        for <virtualization@lists.linux.dev>; Thu, 16 Jan 2025 04:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1737030299; x=1737635099; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBwF2KOXlFDp1MGeRltem3iAJtpX3AYE0x8w+f0gonM=;
        b=KE1RqWwSNT0FZZ/jHPB6NLVnPv5YAv0hZ3l+y8GdpJ0edvTpJibCPlWP/zcZ/DaTzK
         mgVoarBX8NLi57Ixu0nc1tDNbE+R9H8aSeUqD+uyFfrQdEsSSM41m6ab/JYldmUu6EaH
         uWuiOvikwyXlP33DIppfHthZ8aq5B56KPCCME7EYegWnQwZH+KI4EXu2os1pzscTuKuE
         HmpgbYIKLOLBk0VCBlPJ8LtrQjBQBy/LY4ykzvKJSy4QIq1KLTlHVyrXY46RVpQ+PNQ6
         gw6imiKsZrRySka6ujDKgFpskgTcq+jrUcjozJonq5l6oRySMpzqijYxLWGGFpL7RhLc
         DUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737030299; x=1737635099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBwF2KOXlFDp1MGeRltem3iAJtpX3AYE0x8w+f0gonM=;
        b=YQDqoMw11/Ibhpk7a5WCVZtwhDvSCYeEieRpdYuKo55fZQW7MEUThrcSORhmkT2mrv
         1dEIBgJUiXSTT3yTCmCx1U4+NUYlt8zXarIWoXpFQROTGQ71ygy17E7ACRFdZlShgYm3
         nv7RUnigQvQ+COd3lHJ+t60A0kSKee8uKH/BEE3DB3+rd1TxfVlHN3ObHHLFrf2uP4KT
         ByKmkA9H2i0cpIc0gzhXwZR4psewLHzMlVyHGtbr3wFz332M9kPrvDT8Qg1LUzRaaIWN
         TSCyk89hY0RmmXDMloYa21U278hXRt9TY3VaYjuZgfmdQ8rp0Ul/6kEedYoMuMUdO36r
         Z0Hw==
X-Forwarded-Encrypted: i=1; AJvYcCX7l4gvf7GLvbTPY9wbUC2C5kFi51tC2ue9AWPgJLtQgR3E73bz1LDerOFYZW7tylAyQiCTs9JqUi+kiYMGyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAVtgOfUYWXQrN6f4Kqs7GqjUXjnVcV6YANKL1v8Q9mkBNYnXB
	6XDNc6xYxkCK4N6RtvuBpGfteRMVfvXXXH+zAQPcFq/SmVD9WjEtXC67ytjJeIwVg9neGelztYi
	lK6yFrne80rDcSVrPrD6R0o27K8YS5T8ruSY3Sg==
X-Gm-Gg: ASbGncv8rwGXGM7XAaxSd4b6jL1hpy4AtTfMrJ14jpq7Fjzd7LGPdWMRbsyo9eE79NH
	22ieYhxNRStnjkrS6ZtNNp4sbejmSA20pcmc=
X-Google-Smtp-Source: AGHT+IHYPoThOqCGG0mIrocl9o1givl0D/RoYwWOKY0kUiZ64KPF9cSvP+6N1Rd6ke2PYtdS9xOibflODkJbaGvT990=
X-Received: by 2002:a05:6214:528e:b0:6d9:3016:d0e7 with SMTP id
 6a1803df08f44-6df9b2b1a21mr442378366d6.29.1737030298608; Thu, 16 Jan 2025
 04:24:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <f3ba05c7-6e49-4641-a3f9-ba418ebdb7c3@ideasonboard.com>
 <c6735280-7c32-4319-8ca9-a7305d8117c3@suse.de> <d67adb03-5cd0-4ac9-af58-cf4446dacee3@ideasonboard.com>
 <0ea6be58-0e04-4172-87cd-064a3e4a43bc@suse.de> <f35cb350-6be9-48ca-ad7e-e9dd418281d5@ideasonboard.com>
 <4af0b6a7-c16a-4187-bbf5-365a9c86de21@suse.de> <e327ad84-b5c9-4480-b873-dc3aca605538@ideasonboard.com>
 <a2bbeb47-2569-4ee0-9265-92bab139bdc6@suse.de> <f3833771-fcd7-45dc-9019-1525fef34429@ideasonboard.com>
 <CAMuHMdXxYa+Na3XxpLTy=-eUL_zQ9kAiUKYu-E04u3KWApusSA@mail.gmail.com> <xz5ncq67bgmdase2jg3cfvyaxpiwhol2eqpfzow6dqpauvslo5@2w3rw27lhnxo>
In-Reply-To: <xz5ncq67bgmdase2jg3cfvyaxpiwhol2eqpfzow6dqpauvslo5@2w3rw27lhnxo>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 16 Jan 2025 12:24:47 +0000
X-Gm-Features: AbW1kvarRJv1VyJjUo1t8ScK0brJ2o4-Qq6ABYK10edUo6rgOW2PAccCb4uQWlM
Message-ID: <CAPj87rNS7quwfqDmxyrW8_vQ6tnrcfWUn=81aTduDXtmdVkkAg@mail.gmail.com>
Subject: Re: [PATCH v2 25/25] drm/xlnx: Compute dumb-buffer sizes with drm_mode_size_dumb()
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, imx@lists.linux.dev, 
	linux-samsung-soc@vger.kernel.org, nouveau@lists.freedesktop.org, 
	virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-tegra@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	xen-devel@lists.xenproject.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Andy Yan <andyshrk@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jan 2025 at 10:35, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
> On Thu, Jan 16, 2025 at 11:17:50AM +0100, Geert Uytterhoeven wrote:
> > On Thu, Jan 16, 2025 at 11:03=E2=80=AFAM Tomi Valkeinen
> > <tomi.valkeinen@ideasonboard.com> wrote:
> > > On the platforms I have been using (omap, tidss, xilinx, rcar) the du=
mb
> > > buffers are the only buffers you can get from the DRM driver. The dum=
b
> > > buffers have been used to allocate linear and multiplanar YUV buffers
> > > for a very long time on those platforms.
> > >
> > > I tried to look around, but I did not find any mentions that CREATE_D=
UMB
> > > should only be used for RGB buffers. Is anyone outside the core
> > > developers even aware of it?
> > >
> > > If we don't use dumb buffers there, where do we get the buffers? Mayb=
e
> > > from a v4l2 device or from a gpu device, but often you don't have tho=
se.
> > > DMA_HEAP is there, of course.
> >
> > Why can't there be a variant that takes a proper fourcc format instead =
of
> > an imprecise bpp value?
>
> Backwards compatibility. We can add an IOCTL for YUV / etc. But
> userspace must be able to continue allocating YUV buffers through
> CREATE_DUMB.

Right. If allocating YUYV dumb buffers works on AM68 today, then we
need to keep that working. But it doesn't mean we should go out of our
way to make CREATE_DUMB work for every YUV format on every device.

Currently, drivers are free to implement their own ioctls for anything
specific they have. But like Laurent said, standardising on heaps and
how to communicate requirements to userspace wrt heap selection / size
/ alignment / etc is imo a better path forward for something generic.

Cheers,
Daniel
