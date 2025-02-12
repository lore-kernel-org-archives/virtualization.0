Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F020A5F0
	for <virtualization@lists.linux.dev>; Wed, 12 Feb 2025 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360588; cv=none; b=ma//wWBsinW1VU4FvmhZwiJv10CgRy+A2tpdtUFnH2KVSyIrC5HY+fyxgGlkdMouPUbNb9clx+d2ythI9s0BA6C6lX5o9i1pMC2h+HzoAOr9wI6Q/bOgL08ceS4XC+S5/G1fRTbZiJ5BhFm0AKcO2V1NddWJVBqRn53pj/N6+vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360588; c=relaxed/simple;
	bh=NhqxhiZpfWPEn6pagf0thRaPnjSAZWlw7MZOS2drRSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRuwT0VD/mBXHBwyhLNTeAslfCRCEq6tHXc6dgTZNSyvkkZtjdE6YpWErljbFmrbUgME1ZWzDEcREbvpP4oQw9NPpP7h+FRLyaKqV2idAISbfTZpP3FGGnXRybFaptHaAXg4X74qQ+3HqBiAVp64P1/iBcvmnZnKZVDICBbgeaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vaJN7U1c; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vaJN7U1c"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-51e902b58c0so3209024e0c.0
        for <virtualization@lists.linux.dev>; Wed, 12 Feb 2025 03:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739360586; x=1739965386; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n3Pf9VLqr0zn74ybOM4AB3R6LkV9Kq24XCYfLCd4K6s=;
        b=vaJN7U1ckL0TmaFo3DNdkr3UnKe9XxpDYtRbh9+UndRuq6SmvVLL3GeiKR8pcTPEwU
         dbdvxwJvniEQ1cEMIIjMsdGEizalDX3TB6FPMn2ZVOyWXtzVxVJOn13Vu+UTZuJ6hmCl
         W1p2Z0ixb3yqfhs94KfkmLPDRqeEsghiuhrtqWvo9wzD44mthtlEb2C8NYXOvH086JkB
         Ucn9muR8mgHIGUJw4Ak1VGmhJBHm8eTFi2vu6NvwKMh1euYskNXXSziwl529sYBUuny/
         MxxdypUWnXXu8yS3Vq1A+2DQqE2Hg8vY+TTKaU36+d9ekXbH7VUU34OR14mQstis+v3P
         KmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739360586; x=1739965386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3Pf9VLqr0zn74ybOM4AB3R6LkV9Kq24XCYfLCd4K6s=;
        b=RzUZCH3BS/PNJjBZ10KaGc+lz/eN14YwGc4/Hh/R5KOlWwyex6RZgimqMJ4IWI128X
         ISv13WnVzXGYrhRBvdc2IquxQrpVoKZKOEb1Cm5ZmRGoUevD6ilCAtOVd18UohryKd97
         yUqX/uxE43tmKyUh1zL82mUvPAed6LfwLkZhuYATQk625Aa38+bl4VI2RQN05ZsbLxg/
         ZPbdbey3BSXyJ2NwGqb2QSTAY6ibDHBnUBSGMoSO8rg2azd79KG0ddCMVgBNnlphGGsg
         lhkre/m+CKyTpVEeVUUd/AcOElRlxxz8JxMr1m1PgbexuTDUMQ3R2XEDc1GM1nYjXa+s
         5ZGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYj+DhWcfOh5ubVUUw7SHtV0GX4+z1Qu5weuN3TqvE6je56kQ9SvAiF06RHW4j2LSrd98T0D+BPUpH4/QMbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIdUwZrt3h8dkApx0v/v9CFqOE0E2moARvTjab7FAyNT6+vQ5p
	9IHhCFsR9twB+LIDDBOzAy/pn1eXDTnMNLO28NjacUdanGxxhj7Q+2C8trO1s5sLsv7GppSZwj7
	eQY/PwCp972NxrJSvkMDw/AFORSFxAkXKsGZN+A==
X-Gm-Gg: ASbGnct8zgU5sGEByGOZrxrFIINsPkSwmKPopIb50i9YcFklDLSYUVKMglqejFBpQ3e
	HbMoLlw+5ci5UCTUw9LwudbJRNQvoNvEiuVVHIIhJPCgoWaMimyy68TVxlUT3laEum3RfOdIXPu
	E=
X-Google-Smtp-Source: AGHT+IFOih37+KrqDaHnv2z1gD470AjQX0R923clhFtL4aKxyGDPMwXe6xkjFhG576o5Jmtsc4iPKFF92U7xej2AN4Q=
X-Received: by 2002:a05:6122:3c4b:b0:520:42d3:91c4 with SMTP id
 71dfb90a1353d-52067b4369emr1897998e0c.2.1739360585770; Wed, 12 Feb 2025
 03:43:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+G9fYt6Cuu6=OO9w80yhJbZB77Q0qf7nzYdvjbgDbgAw6t1jw@mail.gmail.com>
 <8634gku30g.wl-maz@kernel.org> <3902208d-8814-46fe-ba98-3db833b9a886@stanley.mountain>
In-Reply-To: <3902208d-8814-46fe-ba98-3db833b9a886@stanley.mountain>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 12 Feb 2025 17:12:54 +0530
X-Gm-Features: AWEUYZm2GCz4FlZi-oNTIdRy1QPKZCSG3F-OJRaS44oBL_Jsi3XOtSmcXBGZNeY
Message-ID: <CA+G9fYsjW2U0k2XWBESRpy+xpn8hHGYTEV3TQu6qdeqj7fu6OQ@mail.gmail.com>
Subject: Re: kvm: nVHE hyp panic at: __kvm_nvhe_kvm_hyp_handle_sysre
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, virtualization@lists.linux.dev, 
	Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Feb 2025 at 17:11, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Tue, Feb 11, 2025 at 11:36:31AM +0000, Marc Zyngier wrote:
> > For the crash at hand, which clearly shows nVHE, can you report
> > whether the following hack fixes it for you?
> >
> >       M.
>
> No luck, I'm afraid.  It still crashes the same way.
>
> https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/anders/tests/2steTT4f2J8ZJjc3jNJFMuow9Cb
>
> Click on "Logs: html" for the dmesg.

Anders tested this patch and the reported issue did not fix,

Link: https://lkft.validation.linaro.org/scheduler/job/8118315#L1379

- Naresh
