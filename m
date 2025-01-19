Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F3E7DA82;
	Sun, 19 Jan 2025 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737319351; cv=none; b=SM7GFANOoY5Znxnp0gDRO9jqu5ljumC6h9asDdpHuRPz0Qj+cspSllOpes9uiKFnMuoZGzxXf3gUb5ist7jFpBrb/2paIP/Y9JfYlxOBV8Zs8Nn5DQ1KahLqKIdb5wWim0EVJ06SfAFetLnNNIU1k2OtZCHxnNi7iPkwgCFbzdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737319351; c=relaxed/simple;
	bh=8lAhJ5IrVPZQcoYHV+i/ViFGYILbt1ZiJAEAksEQQDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbLHkZZpYF5DDKPhekNDONDghw0wFMT49A2+12oKT04NrrlTEh3Opb9TMNJRbfhp89RcnRR7VT2KMg95Z31u+bq3V2TZsuKVSsxQMusnzttN0QTCzudk+WvvEsXOIinthmqjPUO53sAWTAYv/x5WeHZYJH/ZcK8fl7BePMWCtJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuoZOTVZ; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuoZOTVZ"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so5153355276.2;
        Sun, 19 Jan 2025 12:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737319348; x=1737924148; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8lAhJ5IrVPZQcoYHV+i/ViFGYILbt1ZiJAEAksEQQDw=;
        b=NuoZOTVZk0jecqDoCLEpzOEE6wyi5tHTCUna45evkUl98o+cNRhQ2Xo96he0gckPne
         TZoFk3v/2RA+bH/OrXgj5IF4RW5ScjSSbT2oZu5Ime0bHwfSIDt9Em7dnD0XiYVLfbpp
         zUUnhZgB7xy6D58PUP2zqGsJtYwaynMmc/xTQRS4P/reZa50tk5AL8TZ/YFHph9YbnuX
         agcVyacXAalKEL88AWvlCinj4QcmvBZxsttEAlj/sVUJCMn+JYsitVZ+SYMrxymyjV5m
         UkmRWOIX26Tg6BdavJ7BvfZOmtW+SDGxtSbBDmuPllpo/Csl95AzeWrL+UaTdriIIAQK
         pn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737319348; x=1737924148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lAhJ5IrVPZQcoYHV+i/ViFGYILbt1ZiJAEAksEQQDw=;
        b=uBk/thC4vvKLdcruqiM5gMVDA0T+IvkvnO1Nmpjt1drATSBKdaVXolQ8+RNj46FrSz
         9e9EhMrMr/XiilW83Iurhk6HZeq7FOdDRekxWu4j6DN+xJ60UQqa9ALUj3uVLQvuWgM7
         1pnj+JZnkQjMuLORWDFjO/JNtxWs2x+tP20CGITVtJk1vEq5RRdZawckgFPA3p2Epg/k
         P41RuLIifLbNuOMODr2qNtFRAOpWzB46YqWhJEoStsBY35VzFw4dy6FnNrPSs2l+chbR
         WRpscXfrFJnEI+Qz7w9v7Rljr99V5emWibbpJU4wQUSJ5VASa6xQSz2kCS83T7JJn8c3
         GsfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx3uV4QyVy46Aa67IBSNeAU72fthJl8w8jqFfEQn7IV3wrh+wutZymaXv9jYg4vyKZxhLs2rcc6KwGrBwU2wE=@lists.linux.dev, AJvYcCW/4F5N3lf7v4boRLKbKZh2MGuixJ5/XxCz1AWcS9+tAybwh82FuRQZDDEzUOl4y4ePnR6ggw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9zCr2b6KR4vSvppKcODm/wT3TEEkS4x9o/jmZgMvqZUXgi5Fl
	beGyFcEuYNEsdk5k8lu22YDSdWB/633xrVdP2eTHLVjQ6vSTQgtHr8WX0lAfYT9QAm6hjLkfzt8
	B9JjWa+dAm8JKZvdUPHWAb/GDQaE=
X-Gm-Gg: ASbGncuw8OlH3s91XHfnaZ+RFly/MbOaQQNjMAloVk7QEAbqPrWGEQXG0eZackkck0I
	Fz/N/L1j82rQ/eXLKW+GCn/Zc2vnagKEq7USs4sCy2c6msJe0fgrG
X-Google-Smtp-Source: AGHT+IGaPnb11OoaGg2ixbnYgp1PVt4lZ/eQ66+OiZixdaacUCgn7+WUkslkBTJ4yop1zjk2PUW+XSykxJ6BzY4VQ/c=
X-Received: by 2002:a05:690c:d89:b0:6f4:dcb1:5bc7 with SMTP id
 00721157ae682-6f6eb658b77mr77228777b3.1.1737319348517; Sun, 19 Jan 2025
 12:42:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250109-virtgpu-gem-partial-map-v1-1-a914b48776bd@gmail.com>
 <2f51584c-0590-432b-a4db-7a2af99cde15@collabora.com> <CAMT+MTT11xg-14KrcqUTx3DxF=1NnYZAMY8RoZFoTesc0zEiVA@mail.gmail.com>
 <a6b7a3a1-e6f9-4da7-96b3-62aefb82dced@collabora.com>
In-Reply-To: <a6b7a3a1-e6f9-4da7-96b3-62aefb82dced@collabora.com>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Sun, 19 Jan 2025 21:42:17 +0100
X-Gm-Features: AbW1kvY6AyoKzuXRUCeQ-DonU--FYB1N-89W9fTBo1fqGY0YjUfZ_KrqgSImC4M
Message-ID: <CAMT+MTSCKiRMy6r2uDsT0dpv=jru-G-M5qih6vPSe=ZvpKC-kw@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Support partial maps of GEM objects
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Jan 2025 at 21:02, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
> I've tested this patch. Partial mapping with a non-zero offset doesn't
> work because drm_gem_mmap() rejects it. I'd want to see your sample code
> that performs mmaping, maybe I'm missing something.

The entire setup is a huge pile of moving parts, but here is the relevant
function that creates a fd from the cross domain info (this is a part
of the vm agent)
https://github.com/WhatAmISupposedToPutHere/krun/blob/pipewire/crates/muvm/src/guest/bridge/common.rs#L745
After the fd is created, it is passed to a pipewire client running
inside the vm,
which in turn does a simple mmap() (with a non-zero offset) on the relevant fd.
Not sure where exactly pipewire's code does that, the syscall was observed
via stracing the relevant process.
