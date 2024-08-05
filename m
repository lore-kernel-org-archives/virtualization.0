Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A482515A4AF
	for <virtualization@lists.linux.dev>; Mon,  5 Aug 2024 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863507; cv=none; b=Fh5TP3XWyAuFiQ1dQ5CyOYDQDTUgApkBlfwPb08IN6bGTfEWlP60izWwsPh7YcjuqVY+k/IRb8Gwo8Rze3pvtbsHU7bMMNgxlCBnNKDUgr4xY2xALyeCCrx+WVcz7Rgj7lGe+CC5lGyAyvrjNF2Gae1KOwOxAuEC/S907f+U+kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863507; c=relaxed/simple;
	bh=wqu7bGkFRyONJ595ZHT2dPa2sQS3elnU8rD7fvADtto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQDjZw1HbyyMg774ppwXZpVjcFGSYgwh2qlhwS3d5P4a+Ou9vIq4iPJwrwAa351e+N936Lh4rRqougFFY6HMlc7WVQZMr9GAZ0zlppVsQsbLfdQytfBJfMlgzcfZAWawXzGmYw7kyvDYoehT6XkSdmbjJU6a5EG/5Ox/e9q87wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=none smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b=eRslpbWy; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="eRslpbWy"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1d42da3f7so647577685a.2
        for <virtualization@lists.linux.dev>; Mon, 05 Aug 2024 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1722863504; x=1723468304; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wqu7bGkFRyONJ595ZHT2dPa2sQS3elnU8rD7fvADtto=;
        b=eRslpbWypzH6BQg1fdEF/UpiPe2P7mHnqGB8EKue3i4NpkpzJxDR8o35WiPipk4OOP
         TayyIzm2NARM5hP7tojzyhWDw+lc82doYJOjkBqP/sWEHqiwCpcY73/c1rCUymDbo15S
         O1Qj+p4hYTmL+hbHrakp9msRTzf6f4H/90rdtkwJNq1K1HKBhbVA1K/hv2RsnTio8eDm
         x3DJZFJyrLCYzeH0Z9aLn+xgCa8HBPCV+A0XoXcQmO3uS9jNpEtsm1w9UiufsncVqgnX
         x68WjwX6RC+Z7VAnZK2jdIq/A1IF0fidxSWzHM7EmvWkMnZDvVSEfSonJQ3FL4cVrT8H
         Gzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722863504; x=1723468304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqu7bGkFRyONJ595ZHT2dPa2sQS3elnU8rD7fvADtto=;
        b=VizpOuUPgrb8pxHlTO6WDAVIE9IXGbnorKJsxE3sokdYAZ/45M78WFhvGCvp8C5GHr
         t5ghdl/meT8H1Y9odWaTqYT+KaDoSXCyWfH8iPZzjpegPl6+DuBFk01GKsvlAjDiF7j5
         8ee6uzAhsoL2RHXbvwn+SxnIlGH9JR4KLGJSjtxx94/8mTvOYNSwE5iASRURN93wSPAt
         BzvLGodN2mNR5nk0LlxWPHGKbGVaiZrCRuueTMp5I2gnobxjy7goOw0+ZULnDjIInNZ+
         2XcmLf8xh+8Ej6Fh5sXfc7nV1fIYMirP1xEPiJX4tkN5G8ivqL4sxhUyCCH1pMq0qgLc
         S54w==
X-Forwarded-Encrypted: i=1; AJvYcCVjCne3pxTT6I/7E2C5IttFj0dUbDA8pWtcLsBH6UQnTURF1yLwhauN5Jqk0P5ZJuaL6WLaC5HID103ykqzMFmRyn0Hey1QDH9HbTQGtGw=
X-Gm-Message-State: AOJu0YyHTGiEr9ONnDjgaZvNWZuOkb7EqREuSnO0K7m+oq2+tFuet4db
	X++04KvHjELlsbyY/zBg+dyG7BvrAsZB6U53lDTAojn4ldZd11b34jtIiTA+2ZgupG+W41N5C/Y
	Wjlz4YQDBMHS4Lg52f7JMLe6VDwyHd2Ud4TLbHpmSPsoOpD6m/io=
X-Google-Smtp-Source: AGHT+IF/O5ePVsP9F9/4LdJgMcHnbAiRBVz6rWucn4L0+VzzRP1U+YIN/SKoA9Ocbj/mAccdLjT4/BuXBtCo084/sM8=
X-Received: by 2002:a05:620a:24c6:b0:7a2:e6c:41e7 with SMTP id
 af79cd13be357-7a34eeb959dmr1463955085a.9.1722863504285; Mon, 05 Aug 2024
 06:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240730021545.912271-1-vignesh.raman@collabora.com>
In-Reply-To: <20240730021545.912271-1-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Mon, 5 Aug 2024 14:11:32 +0100
Message-ID: <CAPj87rOYVCG2A10ruyYan9y6NmMY0fUM6Z5-9ht7dEp_THYmNw@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] drm/ci: Add support for GPU and display testing
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, 
	robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, deborah.brouwer@collabora.com, 
	dmitry.baryshkov@linaro.org, mcanal@igalia.com, melissa.srw@gmail.com, 
	linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vignesh,

On Tue, 30 Jul 2024 at 03:16, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> Some ARM SOCs have a separate display controller and GPU, each with
> different drivers. For mediatek mt8173, the GPU driver is powervr,
> and the display driver is mediatek. In the case of mediatek mt8183,
> the GPU driver is panfrost, and the display driver is mediatek.
> With rockchip rk3288/rk3399, the GPU driver is panfrost, while the
> display driver is rockchip. For amlogic meson G12B (A311D) SOC, the
> GPU driver is panfrost, and the display driver is meson.
>
> IGT tests run various tests with different xfails and can test both
> GPU devices and KMS/display devices. Currently, in drm-ci for MediaTek,
> Rockchip, and Amlogic Meson platforms, only the GPU driver is tested.
> This leads to incomplete coverage since the display is never tested on
> these platforms. This commit series adds support in drm-ci to run tests
> for both GPU and display drivers for MediaTek mt8173/mt8183, Rockchip
> rk3288/rk3399, and Amlogic Meson G12B (A311D) platforms.
>
> Update the expectations file, and skip driver-specific tests and
> tools_test on non-intel platforms.

Thanks, series looks sensible and is:
Reviewed-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel
