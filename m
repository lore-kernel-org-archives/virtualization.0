Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5683AFD16
	for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976698; cv=none; b=MEZa6lo2OGarWb0GyuhJZ1QdcOeM/3iuRE50YjUyyIknzWL6hXX1YHyZDrz1+vSzoMxWV/G0V/z2SxnnPwtyMwz6LWxdvoLfKgE7v1YPZ8bBusS5q03C9RwYKKJBwiWrTbJoglouNkQ8n5gbPd9/qCmTCPJW/QTCf5Pm4gJsCT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976698; c=relaxed/simple;
	bh=/DTqqG3V7U7WfD1BzSnvfO5TKElZ9Vr+nrizGyb2ukE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YPaGJ5dgCe8pR5899O/OeumBfMMZ/ZS5nARnz+hqbDd0yxdGBuf443Y+36REJbQI3JTR7nX1Xu4RCzZ/093bceeEhY8QcgyTMBm4ivNNuIbyb403waj+eGxx3f0CaSAm/GCIXWgEUwidQBQIt8csMEl23hvlt3oRHw1Dp6j7VAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jQ3vAmO7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jQ3vAmO7"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-495590dde14so43628055e9.0
        for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786976695; x=1787581495; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/DTqqG3V7U7WfD1BzSnvfO5TKElZ9Vr+nrizGyb2ukE=;
        b=jQ3vAmO7TbPEqvhIdm9L/4rF23O3LqG1n5Ztge823Ju6zNAhS4Ka6UYMIV+70WAUy8
         LKSyDYVfGVtuyUr6M8dBt8NFDDXokeXIenVjqUug2Q49HmxTb3v7sKyF1w7ztaNsP9Cw
         V8IZHihOHQBWf9QiFJF/7oiThqqlzeG7vVZcakzj4MneYfR1FAEkAZ2tStphv3T1nMnc
         MK/LMk6Ns75ADbAYQAn5/8UsAN7+V437OqJGmhVztpH28bdrkj/QD43T6lg/pAV4eH6L
         S0+9tmLTBUw2+d8H+aaPb0HY4mqW4jTxmIhOm1JB4uGkMi9UB3zTzKdeGNYn7kEskQ5k
         JqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786976695; x=1787581495;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/DTqqG3V7U7WfD1BzSnvfO5TKElZ9Vr+nrizGyb2ukE=;
        b=Ti21c9C8VVFtzvzG0tgWOqJe+KIgRiSCf6pAybdoV8euUrTc/39wUeiiIBW+EieHsC
         QtSBtHh/kFuIYB9p2C1+k85oOoRF48seMyuWU0zwgvgGxz9gXElnIbvgqJTrPy0g/zgz
         AEHFrjhZZucUoh5NqY6ZDOxgUeMJbwO0Gm40UjoxJs/j7WEvRCTcMstAnMD4v/I//2jJ
         0SzdtoEtd6t8M16EV+nDR62UOQHxbJdgWcCNsiPZcs097OmdLWb2fPquroK9Gh9qXfXm
         JXExIo5wOMktpgDfLeAdGYzWWZLfBOSoMKW1uhwzz8s95g6zc5h9Hr5hsVNEos3kXsci
         bEqg==
X-Forwarded-Encrypted: i=1; AHgh+Rr0cETmwyjaBAL1Zfbl+bXMxEVxMlh4qXx/SYGd/CwoWVN2ijZyLTAw7ht8aNaaEZa+mgmrJTQilrvCMMlmEw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXfugNu3yxHwvH3t73aVcOyfuA7mEy+67bMthHbmMVWmaLoW1r
	jKgBUjP9mS+eIh7RZhW+T2knDZo1ltUNDxUto/aeBtFnQi+EFGV4kdirO0bdSHS+JOBIiKQ1tRA
	8AA8b
X-Gm-Gg: AR+sD13O/DTV7aN+1WDoMlb5lWg+Lajg8O/XfbLF8CH1qcahwEwmRRaimxPgie3jM6M
	stcpQYH58hrz/Or6Q9PmYnkd+cPFwrvc6UNP9PBTngmEdWdxqOEi9FE6+QeutQIENK5eM32uGOA
	4e7fKQxTq/HU3QS1B9wP3yksyWrZd21osmlIripwudPIVdA7lBM8kSAD0IXBXz1FEyIDxKQ1+F1
	6mN6Mhn1EnwUaNmmuiFJu2ABLQg+tVsKTKOyXYg6Mc+iDb/vawOcHYjwXE4SwIBAUikegA8WSeO
	UZ7aqM9Szm4+ekS0Idn6AAwAPlhbs6gck/NySWVEvd5ey9Hmm+uTdU7wdAKF1onGQ3TVFqQPyBw
	NHjdL3CiEErX8SUYlrFHNV5GVlNkjUbUgNy5NS4xGLrrHR43lEoz00qD6u4gdy0jB8G+G8uyMXI
	rTCHmVEm1gAfgtZ9XfOSkcH10jSn/k+wGTGF9n0RMDcD1g1oDAeomOllea1jMK
X-Received: by 2002:a05:600c:348b:b0:499:5282:f8d1 with SMTP id 5b1f17b1804b1-4999fb76c29mr9022705e9.12.1786976694599;
        Mon, 17 Aug 2026 07:24:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996183b89sm185398105e9.12.2026.08.17.07.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 07:24:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 0C3B05F86C;
	Mon, 17 Aug 2026 15:24:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Huang, Honglei" <honghuan@amd.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  qemu-devel@nongnu.org,
  virtio-comment@lists.oasis-open.org,  dri-devel@lists.freedesktop.org,
  virtualization@lists.linux.dev,  Honglei Huang <honglei1.huang@amd.com>,
  Huang Rui <Ray.Huang@amd.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
  Dmitry Osipenko <dmitry.osipenko@collabora.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,
  Gerd Hoffmann <kraxel@redhat.com>,  David Airlie <airlied@redhat.com>,
  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: About new backend for GPU compute ROCm in qemu
In-Reply-To: <78f0583f-93c0-4374-ba37-fd36f6388f0e@amd.com> (Honglei Huang's
	message of "Mon, 17 Aug 2026 21:44:21 +0800")
References: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
	<ea899a6b-0a59-4a9c-9e81-3ed70711da59@rsg.ci.i.u-tokyo.ac.jp>
	<78f0583f-93c0-4374-ba37-fd36f6388f0e@amd.com>
User-Agent: mu4e 1.14.3; emacs 30.1
Date: Mon, 17 Aug 2026 15:24:52 +0100
Message-ID: <87pkzgsu2z.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Huang, Honglei" <honghuan@amd.com> writes:

> On 8/17/2026 7:44 PM, Akihiko Odaki wrote:
>> On 2026/08/17 12:19, Huang, Honglei wrote:
>>>
>>> Hi Michael, Alex, Dmitry, Akihiko,
>> Hi Honglei,
>>=20
>>>
>>> I'm bringing AMD GPU compute ROCm based on virtio. I posted a ROCm
>>> over virtio
>>> implementation to virglrenderer nine months ago (MR !1568 [1]). The
>>> ROCm side has
>>> been supportted by ROCm offical.
>>>
>>> Current implementation is a virtio gpu context type capset handled insi=
de
>>> virglrenderer, sharing the display path. That's an awkward fit, many
>>> compute GPUs have no display engine at all.
<snip>
>>> =C2=A0=C2=A0 - that instance served by a separate ROCm backend library =
loaded
>>> =C2=A0=C2=A0=C2=A0=C2=A0 in-process by QEMU.
>> First, I think we need to establish why ROCm cannot or should not
>> remain
>> in virglrenderer. The virglrenderer, Venus, and VCL maintainers are
>> likely better placed to advise on that boundary. Once the protocol
>> requirements and performance measurements are clear, we can assess the
>> appropriate QEMU integration.
>
> venus is borned for GFX.
> virCL not merged.
>
> To be clear, I'm not saying virglrenderer can't host a ROCm native
> context it clearly can. My hesitation is more about fit and direction:
> virglrenderer has grown up around GL/graphics, and I haven't yet found
> compute oriented plumbing there to build on, while ROCm moves very
> fast and I need something I can keep current with low friction.

I'm unsure what the current development status of virglrenderer is but
it does see a continuing stream of merges. However the threading model
does make things tricky for QEMU when we are sharing lifetime of blobs
between QEMU proper and the virglrenderer thread. Perhaps there is a
better way to organise things?

Could we do the marshalling of VirtIO GPU commands into ROCm directly
inside QEMU rather than going through additional plumbing? Are the
sequences we need to handle more or less complex than your general gfx
rendering? How might this work with other frameworks?

>
> Regards,
> Honglei
>
>
>> [2]
>> https://developers.redhat.com/articles/2025/06/05/how-we-improved-
>> ai-inference-macos-podman-containers
>> [3] https://www.qualcomm.com/developer/blog/2024/10/vcl-virtio-gpu-
>> opencl-driver
>> Regards,
>> Akihiko Odaki
>>=20
>>>
>>> That reuses the existing pluggable backend model, a second virtio gpu +=
 a
>>> backend library. It doesn't add dedicated queues for
>>> debug/profiling currently.
>>>
>>> Waiting for reply and=C2=A0 happy to share more detail. Thanks!
>>>
>>> [1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/
>>> merge_requests/1568
>>>
>>> Regards,
>>> Honglei
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
