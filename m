Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED5C38BF81
	for <virtualization@lists.linux.dev>; Tue, 11 Aug 2026 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473261; cv=pass; b=LHnZJL4z3WbTi85xk8i2MG6h0wqptNmhJMQ5nkGdiGM5es0VlbTFqpPpYU1VoFonU49xSARzU0jkjbW17xl8jxQcBCthEr2Ajec5o0f7s43pKRgRvvdRk0jszwEQFOMQYpHAV5l2WXfD9Jk1ptaigLN5cW20CHZKB320CikNqbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473261; c=relaxed/simple;
	bh=kLCANoNRd4l6pDLkn5bqVm7bHB+PCvgLtEbTkT1Q00k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fkvo26vOvb2umxlEEyXi/NPhtuRozJBeN7GKYqFwp5lx4yDG4w2BvJVr+OMtMrDHXL1KCE9YdnbTYXlOWvcK0jqljYKFfM20Mif/J7G3WqGq9QM7MWRXs+6ozxT1ORYOP/B8o1h90HJbgg/F56FzgyosI10LqV4uxYPgVj0mEnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JmTbm7mU; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JmTbm7mU"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cede6375caso17395ad.0
        for <virtualization@lists.linux.dev>; Tue, 11 Aug 2026 11:34:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786473259; cv=none;
        d=google.com; s=arc-20260327;
        b=Js+/ic2LXujwjXbwxKhBGaxHiPwGVzNPUAdh9TUAn4ZSb2z+uHgboqKlBPjsYU4yan
         XkHxX5Npm5YYvKB/hgHn10ADGhNH02pJxUBpnIoDwyrFiy2X1599yKGj/YwX2yxh+3UP
         WgOq/7OpseJjxFl59vh8XMAnsS9+HbV0+Dh47qm3qS3VjvZEjPe4dSJe0M7n36MAZiCM
         wcamTgDifsCW7wO/5t/Rk50/wOeVZYEu4mLprDXIxd8DDuEZp5lCcU23boMM6BdFAdrY
         eAhJsA8J4L7gzsnMp8Zpc3OOED9o77+CBVue4VtxTMWaLwgkYmrVdLDg0GEX+1MVEgZs
         6c6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kLCANoNRd4l6pDLkn5bqVm7bHB+PCvgLtEbTkT1Q00k=;
        fh=Q9ZZevP21AQIMiXWUNW9n7SXwwlI8/xA3mLzXyxZukU=;
        b=nmaPJO7H71/OY71xfyr6BafHW/49TXMeGyFe+sGJ6rOWIzxnUzQNo5qlOyYW/ajs5C
         E/v8rwycxW6pmoXJWiciazzqjp4MJUazvUeHAyjK1Ngt7JdklDhRvbtUh1maLH90wol/
         KKo8tQ5lbHyXvBetNztBETBHsNZpUt3QG+scD+AX5HWWiLvI5ooipzXIe6McCe6XwE9m
         R8iPZeOZizwNUdSc47YC5uiJxnnkb22TrHyobIiImOERj2LIHTkAURon9c6ADUGF4Nvb
         2a9nn4LPTrjEgDaE34X3gaAf8A2yuFY8eHmdGOUQ9hlJFBVEkR8pDmqXCggYacF5m8fx
         lGvw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786473259; x=1787078059; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kLCANoNRd4l6pDLkn5bqVm7bHB+PCvgLtEbTkT1Q00k=;
        b=JmTbm7mUrGsGWNT0EM7oSBwRSRMEtCIVKGp+v81ObxJ4rTEoIXEUh3ua2KKzw+YZNG
         UjIsZrrdiRLvaBzXNEIS5xjqW/GCYu8r0UIZaI6tqgoRupNkZafIe0Rg/t4hfixKLKku
         o8XwV5tVA4+AcKI9F2SuGrr3FIrFl6aamd+MY82u9X8fs3DWXZO/iylkJYvzfr/qVl2e
         UiZNHehqy48FyldRzwemdw+Gk+aXigE6gd1WL3zjJ71y4yo4Gxu8W1fdTYagFVhqjPWx
         +mytEoo8gL+t2JRs4dFM+FZ0prhzGJnLK4FhtlQ4rFVTQa/J6Z9+vdgYInviEyEaw7mU
         MOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786473259; x=1787078059;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kLCANoNRd4l6pDLkn5bqVm7bHB+PCvgLtEbTkT1Q00k=;
        b=eyQbSeZxMNYq7p/v4SrHCig/q/pO4/K4OMY1WpNIivF5zAro/HIgeBHjIY3T2t01km
         WCnc+C3K9AF4u2uV64gqUpt9nHCiJnQUR2ajFpr8iEWcIBwowcBiIDnsI8T69giEhhKR
         J5mQ7hzg3jcemT7Tsnvtw4jCL/EzhCbXT/tcORlW61ZBKyuSzLNw7VFoBPedfCoql+Lw
         ItyvJmaaR3pk2HcWhZK3JQ9G9K3CA2LRdSflXiFBLPUMwGs+MFpBlb50HCCNv+wfxlG2
         5CafDRQfvMTLZH/3T9kM3t2Pywdn98olmdZSw2X/INrNFZ/8CprfZfMabeKkdvhaHx8p
         O4PQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYPPTFmrwbualdC1hDCeMOwGoiiUI16MorLd4GvoBKJ4MZvuKqPI7Ufxjp3lI1BwDF8cLo1jAX9NY3UKDgrw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5IgsepkwGaLuJ3be6qg2isckoMixAOFWr2xnKU9hnc8q8Mngp
	VVhsGzHAINnI3pl+wNE11UEeEvbZbRfZFKQQGOcuIhsIdXCsfVITQ7ysF93T/0gs6UJ3y1+m6sA
	F/R7SyDzH/WwkpZJRfN/9tJnvZFtwnqa3vJos4qg=
X-Gm-Gg: AR+sD102anI+Znx6F0CWukNRbyXdK7sJkOnV8jVpdM84JSP5m1zwmuTx2oqsMYcBhmq
	aObI3uEm1IDJyL/sjEtcf3uIuq+s90YsSuLs/eEJh2HlbaJvILV3ZsVZ8rjemG+ffXsWV61/gPu
	0nypz/+p3uwFncdhEnarZkg/gC/xZ8LH0lgi4XXAR3LMpCBJeROiTuDGcAbUkJq6cnDlfig3u7x
	uHNgNvamTOULstCcxBl5K9zj026W0C3K8LxMkerRgHY7f5cu2nC9eBmz0r9DPiEA5MZmdby41dh
	qSPcRyH53aud2Bmip+d3wrBP0q7I04W8G/qV6HMHyNCeKpsRRvYXvjJkvMHyqGBkwRfjm/dR4TS
	NBQ4=
X-Received: by 2002:a17:902:c40e:b0:2c0:defb:557e with SMTP id
 d9443c01a7336-2d33a963518mr1426215ad.1.1786473258400; Tue, 11 Aug 2026
 11:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACzuRyy8_x2XW4hbWn6uzZZjj4LbxpMN_a81Tub-=WSop4anhg@mail.gmail.com>
In-Reply-To: <CACzuRyy8_x2XW4hbWn6uzZZjj4LbxpMN_a81Tub-=WSop4anhg@mail.gmail.com>
From: Brian Daniels <briandaniels@google.com>
Date: Tue, 11 Aug 2026 14:34:06 -0400
X-Gm-Features: AUfX_mxPh1QeCdRNQsNlfbzsj86xBjIyw-ELTDIVTWXToZomyGre9ZVhhK3ENGk
Message-ID: <CAD4i_GTB9Uk=Kd=zZPAdXNZv0Xjvb5i8oHJHLA-ieCxLJHbmzg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] media: add virtio-media driver
To: Dorinda Bassey <dbassey@redhat.com>
Cc: acourbot@google.com, adelva@google.com, Albert Esteve <aesteve@redhat.com>, 
	changyeon@google.com, daniel.almeida@collabora.com, 
	Eugenio Perez Martin <eperezma@redhat.com>, gnurou@gmail.com, 
	Gurchetan Singh <gurchetansingh@google.com>, hverkuil@xs4all.nl, 
	Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mchehab@kernel.org, 
	Michael Tsirkin <mst@redhat.com>, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 4:43=E2=80=AFAM Dorinda Bassey <dbassey@redhat.com>=
 wrote:
>
> Hi Brian,
>
> I've been working on a vhost-user frontend for virtio-media
> in libkrun[1] and tested this series with vhost-device-media[2].
> A few things I noticed:
>
> 1. Wrong constant in vfl_dir detection in virtio_media_driver.c:
> >
> > + if (vd->device_caps & (V4L2_CAP_VIDEO_M2M | V4L2_CAP_VIDEO_M2M_MPLANE=
))
> > + vd->vfl_dir =3D VFL_DIR_M2M;
> > + else if (vd->device_caps &
> > + (V4L2_CAP_VIDEO_OUTPUT | V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE))
> > + vd->vfl_dir =3D VFL_DIR_TX;
>
> V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE is a buffer
> type enum, not a capability flag. So it should be
> V4L2_CAP_VIDEO_OUTPUT_MPLANE.

Good catch! I've staged the fix in v7.

> 2. Kconfig architecture support
>
> > + depends on VIRTIO && VIDEO_DEV && 64BIT && (X86 || (ARM && CPU_LITTLE=
_ENDIAN))
>
> ARM64 is missing here, so the driver cannot be selected on
> aarch64. Also, CONFIG_ARM is 32-bit only, so 64BIT && ARM
> can never be true; that branch is dead code.

I was able to confirm that you can't build it for ARM64 as written in
v6, I've updated it for v7 as you suggested, thanks!

> Since the driver
> has no platform specific code, this could just be:
>
> + depends on VIRTIO && VIDEO_DEV && 64BIT
>
> as it already covers x86_64, ARM64, and any other 64 bit
> architecture without listing them individually.

While it covers the 64 bit requirement, it does not cover the little
endian requirement.

The virtio spec states that the v4l2 structs transferred should be in
little endian format (section 5.22.6.1.5) [1]. Currently, the driver
does not do any translation on big endian guests, so for now the
driver should be restricted to little endian guests.

As far as I can tell, ``CPU_LITTLE_ENDIAN`` isn't specified for all
architectures (importantly, it does't cover x86). Perhaps this could
be made less restrictive with:

+ depends on VIRTIO && VIDEO_DEV && 64BIT && (x86 || CPU_LITTLE_ENDIAN)

I'd lean on others' expertise here if they have suggestions.

I should note this driver has only been tested on x86 and ARM64
platforms, so I can't make any guarantees on compatibility :)

> 3. Error sign convention:
>
> > + resp_header =3D sg_virt(sgs[out_sgs]);
> > + if (resp_header->status)
> > + /* Host returns a positive error code. */
> > + return -resp_header->status;
>
> The comment in the driver and the protocol spec contradict
> each other. The protocol.h describes the status field as
> "one of the standard Linux error codes" without specifying
> a sign. It's probably worth making the protocol spec explicit
> that the host returns positive error codes to match the driver's
> assumption.

I'll update the comment in protocol.h to explicitly state the error
code is positive in v7.

> [1] https://github.com/libkrun/libkrun/pull/811
> [2] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-media
>
> BR,
> Dorinda.

Thanks again for testing and for sending fixes!

[1] https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-cspr=
d01-diff-from-v1.2-cs01.html#x1-8360005
