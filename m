Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8947828C
	for <virtualization@lists.linux.dev>; Fri, 22 Mar 2024 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711134994; cv=none; b=Qerh4NylBsaokhchnmzuhmxGZ9TrN05tLNGs6sVbj491oDLnT5BMTCcqLRh7vMO6L9ZIoJvh62yq1dWRM3LEDEeu8PCoEK9rwMKaAwpOR1xXHxkA6K71hmQbTNzi+eXbCPQRK0KYdM9yAFPiedXatFv3927JVD4yaZyIr4XEWM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711134994; c=relaxed/simple;
	bh=75iHcA9RFOUt3YMY5SehfwsBmnLNCyI0S4Wb9m834B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CreCuL4yhfsjWUpfpwCSRTofOYi3iOlTor6FWm4mOE3HBdl0DEIQ5dVubESOwbl05yUJzGZXZrGENOw2FNAdC5tq+0xC37QzE71nZMzl7O+9K1RQ+1N4RxhqIBVtdmw4fwAVCdMfvZP7RxsgyJRM2uO82SEo8ZC177+v2K4VHao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RMH5rSS9; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RMH5rSS9"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5101cd91017so2882070e87.2
        for <virtualization@lists.linux.dev>; Fri, 22 Mar 2024 12:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711134989; x=1711739789; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75iHcA9RFOUt3YMY5SehfwsBmnLNCyI0S4Wb9m834B8=;
        b=RMH5rSS9LCsvspCgwih9FJSfsGHawjmBNWsYv/GYb27DZiEXLeTn8gI0e46IooNI9M
         bsc33WnGuw4D0t+1mj5bG7qnBkmPoSVJlhgjMb35/c3foXhLWU1ksYD9T7IRQJmpyiaD
         vtYlONKtfCo5Jj7wJ+sHDeqzj+fF2q2ZxHjH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711134989; x=1711739789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75iHcA9RFOUt3YMY5SehfwsBmnLNCyI0S4Wb9m834B8=;
        b=Bb4q8dwmoPWj39PtYDiZd5w0pHhlLNU5x3HGnrqkzEHD3ed6zamq+xYrY3jouB/N2i
         VPIU386ebqwaF7frv+QfPkISHvyxZg2xzr9giy0Y6PAxLgD96NUc1s772alzJ6lK/bsY
         LvrUrBJ88iaGi+07GHq561ydo4LBtGkDZnaGUkTbBvPdeREU9N+/ZxlUEJMVijRIzmut
         AFnc77I7e7IbDEMdLM/N9UtwEzlfbvLbtkbnfK48ilIGPrDEsYf0hLF59zmg4Qv+ewZT
         NXwi++LUv4i6jkHiv8/2ESk1DY/hUy0qX023F2ucoWRn7WLpJU4RuEcOC+MLFeZnuLiQ
         aBSw==
X-Gm-Message-State: AOJu0YzC/Df8xUtsgAoGMUfnVmk0JTeXsUrY5SN/RokCtEThqHlAjMwI
	/0aVNh8RfO4uFO9PDM0qORwgYDYH5UpLbYikb1osUtH+1rYnjOAa5X9knFFNuPURDTcConQBdYT
	lcw==
X-Google-Smtp-Source: AGHT+IHfwdpiQa+tDx6hghmHRa/YixwxgE42DmPp1s2xXWvHvefeu078nzgENULPPZX0FdeT6vGuyQ==
X-Received: by 2002:ac2:4db5:0:b0:513:c146:fc02 with SMTP id h21-20020ac24db5000000b00513c146fc02mr236969lfe.6.1711134989466;
        Fri, 22 Mar 2024 12:16:29 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id a20-20020a19ca14000000b00513cb309c8asm20305lfg.52.2024.03.22.12.16.28
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 12:16:28 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so42046151fa.1
        for <virtualization@lists.linux.dev>; Fri, 22 Mar 2024 12:16:28 -0700 (PDT)
X-Received: by 2002:a05:6512:32b2:b0:513:4b90:ae9a with SMTP id
 q18-20020a05651232b200b005134b90ae9amr255604lfe.67.1711134987739; Fri, 22 Mar
 2024 12:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240321101532.59272-1-xuanzhuo@linux.alibaba.com> <20240321101532.59272-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240321101532.59272-2-xuanzhuo@linux.alibaba.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Fri, 22 Mar 2024 12:16:00 -0700
X-Gmail-Original-Message-ID: <CABVzXAkwcKMb7pC21aUDLEM=RoyOtGA2Vim+LF0oWQ7mjUx68g@mail.gmail.com>
Message-ID: <CABVzXAkwcKMb7pC21aUDLEM=RoyOtGA2Vim+LF0oWQ7mjUx68g@mail.gmail.com>
Subject: Re: [PATCH vhost v4 1/6] virtio_balloon: remove the dependence where
 names[] is null
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 3:16=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Currently, the init_vqs function within the virtio_balloon driver relies
> on the condition that certain names array entries are null in order to
> skip the initialization of some virtual queues (vqs). This behavior is
> unique to this part of the codebase. In an upcoming commit, we plan to
> eliminate this dependency by removing the function entirely. Therefore,
> with this change, we are ensuring that the virtio_balloon no longer
> depends on the aforementioned function.

This is a behavior change, and I believe means that the driver no
longer follows the spec [1].

For example, the spec says that virtqueue 4 is reporting_vq, and
reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set,
but there is no mention of its virtqueue number changing if other
features are not set. If a device/driver combination negotiates
VIRTIO_BALLOON_F_PAGE_REPORTING but not VIRTIO_BALLOON_F_STATS_VQ or
VIRTIO_BALLOON_F_FREE_PAGE_HINT, my reading of the specification is
that reporting_vq should still be vq number 4, and vq 2 and 3 should
be unused. This patch would make the reporting_vq use vq 2 instead in
this case.

If the new behavior is truly intended, then the spec does not match
reality, and it would need to be changed first (IMO); however,
changing the spec would mean that any devices implemented correctly
per the previous spec would now be wrong, so some kind of mechanism
for detecting the new behavior would be warranted, e.g. a new
non-device-specific virtio feature flag.

I have brought this up previously on the virtio-comment list [2], but
it did not receive any satisfying answers at that time.

Thanks,
-- Daniel

[1]: https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01=
.html#x1-3140005
[2]: https://lists.oasis-open.org/archives/virtio-comment/202308/msg00280.h=
tml
