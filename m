Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D606784DFF
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Apr 2024 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875001; cv=none; b=fst3PIzBsQepCHpWuEPJ4U5TZWy9DwWk7sUmr0GdFQZjnlxb3ypZCXNaizRFbBumUdbOjqefLNfDeCXAyXiRaz8Aq7UJB++uU1s5Bn+5FItTqvRMdWTnwnR/4a179l9gKycFjeX06PbHr0mhe2NhRrNtFsm58yXmucRvvbrY/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875001; c=relaxed/simple;
	bh=zdEuS8XRlyMWs8i+nahfC/xh1vWX2u7uUNV94NmtyxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adBiLarVW4SaSg3dl3U7+v9x4TEH7YeDDisRvx2zn2cSK8+lMSNHe/GLUAcUr3IbnNoE5FH54B8C21gF6+qCIgsV+1sNMcwU+RqQBtTCEYouPlj7YNV8NrNcLaut72V3nINxEI64Q2kdtGA6yC9b5gZpxl/Qx1WfieWGToo4iRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZhKD8zgQ; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZhKD8zgQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 657F440542
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Apr 2024 12:23:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0hOLhAia6Ddg for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Apr 2024 12:23:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b32; helo=mail-yb1-xb32.google.com; envelope-from=dmitry.baryshkov@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DCAFB4052D
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DCAFB4052D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZhKD8zgQ
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DCAFB4052D
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Apr 2024 12:23:18 +0000 (UTC)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-de54c2a4145so892009276.0
        for <virtualization@lists.linux-foundation.org>; Tue, 23 Apr 2024 05:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713874997; x=1714479797; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdEuS8XRlyMWs8i+nahfC/xh1vWX2u7uUNV94NmtyxI=;
        b=ZhKD8zgQNI/lx/YVCYfP2T8TqOuLnUFUvwIjNWJUILAcjOOeCl5OElQPKVVZmSnSGg
         UCELJWduXySvmQzI3W64P961RwZazEhqdCXH6UBPTjb3dQNV6uzLxJwe014XO6QAoMN2
         b1NM2EAC4uMB3AXIgaD80r2OGaZ+bfsjnTZo+EaZxGpIVrzvPM1IDmJdaWwV1hRJbyW3
         noYNLYV0uQjtEwdIrPXXseLjWVINk3Mzw1xpUJrKdTqkT+WWmk50ENliUCf/VSHWgT1u
         /nhQKntTk0RAwjOzBD1Ccr1fUE/LSAuu3vH01dogv4gy+7Uw9aJvsz/HTSl8MXK6V9/G
         R8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713874997; x=1714479797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdEuS8XRlyMWs8i+nahfC/xh1vWX2u7uUNV94NmtyxI=;
        b=fgUyWbaZbKn3lajXT9O+gHUv8nqU7G1AXz1loJD8NepXiLMMxE7GO4tvXWJYSoTwBQ
         tkhMEQV4dPH+zOl0jBqHRIoQwvPgs2e0Xw1spZWmO+p+1zaUh0TKn0HoJPzeGpqDvoGz
         8IeKV1iOicIGVHAwM5+tBFSHY8lUtHvl6An5SyYFOeYXP3wBifxJK6+kcDqRgS1cYSdf
         SgYqglsLQx6C1ielVrcdfmqmf+d9YsF1CSdqe6JNQI6gAdH4yno/169Omy85/jtmyJeF
         QaP0f9fJp1XAXtY27+rPhT1wHXQ+sTLhC3yTs26shph46TYcPZQJRDFu5GV96FRQz94I
         VQyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU480smoBZJtJLNuC6e3f6Khln66n5+qsyJM/EB9AfgoKDJpvwJsplKlMV0S51d7SHXULSjxTgNvBw85SHAUkh063YMZmSrpjEOotuTQkGkYDCb6hdiKdH/sQ==
X-Gm-Message-State: AOJu0YwLH2eAUgrvs+nbLzQLBaPSNgPh4BmG+IiriztM3vlsobVI92Rw
	gbK7JENSL5uW8M9ETG3tCae3UxZpGuWlymXXq9tYXKw89RBT6yDwLYqwmGqxqkLLZD1rtCKU5wB
	a7B2Wn2rPRKpat0lhygPrfuz73xulLMJFXD/Scg==
X-Google-Smtp-Source: AGHT+IFGEmHXL5CwAkBYa70XCoYWKwe8UnjgAcbc2h7iJmpsycDinZVPrwrOVKWCKX5O935DZ/QH6hClp73iSys2pzI=
X-Received: by 2002:a25:8251:0:b0:dc7:4067:9f85 with SMTP id
 d17-20020a258251000000b00dc740679f85mr12766959ybn.58.1713874997608; Tue, 23
 Apr 2024 05:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240423040243.448091-1-vignesh.raman@collabora.com>
 <20240423040243.448091-4-vignesh.raman@collabora.com> <e3a0ea8f-d306-488c-a69c-aa18078e5e03@igalia.com>
In-Reply-To: <e3a0ea8f-d306-488c-a69c-aa18078e5e03@igalia.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Apr 2024 15:23:06 +0300
Message-ID: <CAA8EJppaaitcXkXSFTB4-S2CbBcrAVHouB0wWiU5Nw2FvpagqA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] drm/ci: uprev IGT and generate testlist from build
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Vignesh Raman <vignesh.raman@collabora.com>, dri-devel@lists.freedesktop.org, 
	daniels@collabora.com, helen.koike@collabora.com, airlied@gmail.com, 
	daniel@ffwll.ch, robdclark@gmail.com, david.heidelberg@collabora.com, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Apr 2024 at 13:24, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
>
> On 4/23/24 01:02, Vignesh Raman wrote:
> > Uprev IGT to the latest version and stop vendoring the
> > testlist into the kernel. Instead, use the testlist from
> > the IGT build to ensure we do not miss renamed or newly
> > added tests.
>
> Nitpick: wouldn't it be better to (1) stop vendoring the
> testlist into the kernel in one patch and then (2) uprev
> IGT to the latest version? I feel that this patch is changing
> a lot of different stuff.

Definitely. Otherwise it's hard to understand whether a change to
fails/flakes is caused by the uprev or by the testlist change. E.g. in
several cases the list of failing subtests seems to be replaced with
the test itself.

>
> Best Regards,
> - Ma=C3=ADra
>
> >
> > Skip kms tests for panfrost driver since it is not a kms
> > driver and skip driver-specific tests. Update xfails with
> > the latest testlist.
> >
> > Increase the timoout of i915 jobs to 2h30m since some jobs
> > takes more than 2 hours to complete.
> >
> > Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> > ---


--=20
With best wishes
Dmitry
