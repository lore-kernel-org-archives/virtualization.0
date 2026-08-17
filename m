Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8F63B9608
	for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957604; cv=none; b=QRh/rVipXpg2OWmjWl66jhNMUu3psUXAmbmKKUxjdgDGAGuWZCy7p1y5tLbHMqDvnYTGO1tqIjv1HDMymF+lb7VRZqKUxueSnhvxOiN00c4Z1pLv8aAQgPKvbMjjLu30iFjUllQ6lmA1didMRx9+TgN+z3RXELaAMuPg6aD4gEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957604; c=relaxed/simple;
	bh=n/Qk5uxofm+WYhpQwjSUJEt6pRrTk5zc2kAL6DmP+s8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cA9sboA21xrV4arQaDIafmeWpko9V15IqzDaXRZ9g4b5tuoIfhJeiL1l/WjA+THZ1UvR04JNNCnVE0mv5hsp9MgVSr9g1k881b6RP+xTurk/GhmHw07dFV1M2pwOjk8Nj+Ho2C9Fiq1pISZy6qVxrIcSJ9RHJApdUlXeyxTdOSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fUGazIu0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUGazIu0"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso15799055e9.3
        for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 02:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786957601; x=1787562401; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3ngolhcvbMqLUeFoPbLYsoQGaTEjccLb93LdN0z4Iq0=;
        b=fUGazIu0JDey8l6kj/Yp9ymgbkBh+XsPlRAuG6W9+sOZwb7479Jebb8kMVrZXILSTP
         gYUfuEyU6rzHr3Zsj3YY6nN6a7Fh/9BU7oUTysWaV3siFSOSaR2aOSWnoLtSGwIMRBMy
         cnSUC2ngBiWO3XxpmUrg8QQ3f3VzWRvVdtJ5NK9MaUSE5q+z+7iHGoLXswM2UUaXzj57
         4KJ+qBmKjhoARMTHrrvj1mZMGzfulRRLWChA64Zg0kEKEot0mKzXEZcg1uOmylRcw0Y/
         pgfhzbPBKJKaFIW7Bx4u8Lu0de+LDZ8U91NkMNlNpd9SWlslJS9Lu5ha80wZgn/Y9Lj/
         0GIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786957601; x=1787562401;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ngolhcvbMqLUeFoPbLYsoQGaTEjccLb93LdN0z4Iq0=;
        b=TGbPHJAtF9Aku2y2Nyb2k8MQZaqpBoEMlAuD4GQY+EvESl7qsdRjt+VZjYqSeZ/TKP
         xlObvMDSil/BVHamecBf84ocNHM2fYBzCXh6jHvzpbS4q6zpge58crqixl6vHVPhQsxD
         n0IfjpOazqxZeZPM3LVXaRFqBBGP9Cm+1klP+9UYUELgpTAi6AMl9eS1JIoAXy1nYhl4
         xXsG1lprLinOuedJItu90oZLousDkAgqPHgX+Oz1CT9OzWszctU60ifW0gw6DT0RzZk4
         JlcwliM4CZsgFwllUfe3SSWxNjsZlZ00A1aVc9qQrUYGeBdpUMdfseOADkcOEBRToOGe
         eb0w==
X-Forwarded-Encrypted: i=1; AHgh+RrzVx2YRiIAhATLTTcJT8FxsZh99Mgq3pdfUSnq3cQip4euQ+R2SfIX0z/UMFehL4lph7+ONfiiYHz8rf7QRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDEbndN841P4StFQAbsy1AuDiTTpEKKxSwECg42vCtXaem96Yx
	WcbKdwRFuLw+c2THYChgsCqnRCe4eOWTjYBmm5zoL5zxZdsbsl8ZV71bDFGTDsCba8I=
X-Gm-Gg: AR+sD13GrTsH6PziEht1FDK9szY0h1/55J41+uVOrhDBIgF+QrH897IYZ6v8u10wTip
	D0n6j1IqM1pLCiEbk2t+AXa5/6cOhkzfSIMfg/fQGPaL37rofImOaxTocaj9sUz8X/OkYxQNzyX
	BF7gF85I8tlTh1UidQqsIkvh8P4XNZN9Eu+0UKBF43V3sp8lv+K9y6dh5VbQI3JssSi12rggR/m
	Paj2reCMrUHFJByKVXpLkYW6C7U2iHSd2HPrDGo2B/2a6wHgrcp8P+y9gYGcp26jXO5D7TBWbVI
	mHuvYkpivnEhbXZGOLUVsMKh0s8HEOks90fcSxx4Y8IbTmL5sjDetHeh5pFtMrWucY3YCmycxeK
	kJJU+/gDmTxUP7x7H1jbPd2v3euTmQIJomp2Ks4hShwItA7GejID0teCKnJ6QEP/otuIoZ6p57e
	Fi4loTi1PGBS10hzlFTRqW5sKtMhOvol5gRuMzHDM+PehOKCxFmTB6ItlRCDKY
X-Received: by 2002:a05:600c:820d:b0:499:7a36:88b with SMTP id 5b1f17b1804b1-4998794402emr411655325e9.5.1786957601263;
        Mon, 17 Aug 2026 02:06:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d0fb872sm34734505e9.9.2026.08.17.02.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 02:06:40 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 3F3B55F86C;
	Mon, 17 Aug 2026 10:06:39 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Huang, Honglei" <honghuan@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,
  Gerd Hoffmann <kraxel@redhat.com>,  David Airlie <airlied@redhat.com>,
  Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
  virtio-comment@lists.oasis-open.org,  dri-devel@lists.freedesktop.org,
  virtualization@lists.linux.dev,  Honglei Huang <honglei1.huang@amd.com>,
  Huang Rui <Ray.Huang@amd.com>
Subject: Re: About new backend for GPU compute ROCm in qemu
In-Reply-To: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com> (Honglei Huang's
	message of "Mon, 17 Aug 2026 11:19:44 +0800")
References: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
User-Agent: mu4e 1.14.3; emacs 30.1
Date: Mon, 17 Aug 2026 10:06:39 +0100
Message-ID: <87v799ru8w.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Huang, Honglei" <honghuan@amd.com> writes:

> Hi Michael, Alex, Dmitry, Akihiko,
>
> I'm bringing AMD GPU compute ROCm based on virtio. I posted a ROCm
> over virtio
> implementation to virglrenderer nine months ago (MR !1568 [1]). The
> ROCm side has
> been supportted by ROCm offical.
>
> Current implementation is a virtio gpu context type capset handled inside
> virglrenderer, sharing the display path. That's an awkward fit, many
> compute GPUs have no display engine at all.
>
> Beyond that, sharing the display path is increasingly painful:
>
>   - Compute hammers the queues more than graphics, so sharing
>     virtio gpu's single control queue with display/virgl causes contention
>     and display stutter.

Is this just due to iteration? From a layman's point of view I'm curious
as to what the queues are doing.

>   - Compute contexts need far more blob / shared memory than a display
>   one.

I guess weights and context are long lived blobs compared to rendering asse=
ts?

>   - Maybe needs a wider ROCm / compute stack, cause the render model
>     fits poorly:
>     rocprofiler (PC sampling, SQTT/SPM, counters, high bandwidth streams)
>     and ROCgdb (wave control, address watch, async exceptions an
>     out of band channel that must not block display).
>   - Events, faults and GPU reset/SMI are async and don't map onto fences.
>   - All of this is hard to extend cleanly inside a display capset.
>
> On the QEMU/host side, would something like this be OK? One step, two par=
ts:
>
>   - a dedicated headless virtio gpu instance for compute.

An oft-asked for VirtIO model is virtio-npu but I wonder if there is
enough commonality for a virtio-compute device with the same sort native
context type handling to deal with the those that want to have guests
targeting specific hardware rather than going through an abstraction
like Vulkan Computer or OpenGL CL.

>   - that instance served by a separate ROCm backend library loaded
>     in-process by QEMU.

Is this library a binary blob or open source? The last time I looked at
ROCm I had to give up as my AMD card was in an Aarch64 AVA machine.

> That reuses the existing pluggable backend model, a second virtio gpu + a
> backend library. It doesn't add dedicated queues for debug/profiling
> currently.
>
> Waiting for reply and  happy to share more detail. Thanks!
>
> [1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1=
568
>
> Regards,
> Honglei

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
