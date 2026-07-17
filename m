Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489935AC03
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 03:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784257392; cv=pass; b=fxG2mRorFiG5uF01ewKVg/P96PBtbbHsDO2YoFIF0UFxG2gA0XK5fco30q77LY6HeZs+tOTMXhQWmsh95Rsmhz4hqtV4ZdM7eNgdeYIRJpAj/eE+zv6b6Tm+WSwXvIkKoEDt/BhXFD9R/j79PZJ5E8vWLv1RtAvR+cCNAY/t21o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784257392; c=relaxed/simple;
	bh=WAbBvTLsXgnlOQja7as0tCtAkZ5zkXcTjFdj96YQCh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXixBAQX4tZ+wCt/uy5f1CDUvd2Tgqpz3Nq4Zazv16mZ1wi57Cet0vndDSrgppnrtptx/4UZtseL4/eT++VCgcdGXrOGBM1IsxyWWoEGVBvywZn6aq5RD1BWrMBickls86zo6cf7sJyBOebyK0Ws2Zvzdy1tsAULKXwSNBe0/+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OEkgOqvX; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEkgOqvX"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c10ed63c0so243821cf.1
        for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 20:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784257390; cv=none;
        d=google.com; s=arc-20260327;
        b=n7sm2QEm5JP0+s9/UExvw072v/lZonTpkxGtA5zll7eXG477my1GB8F9P7md3DnO94
         4/bzuy4clEu1J0saYn27KZDLfyFUJnLk9lroHEUAawTooYLGgHqgPOAAhZMESG8pJQbI
         sCXSGM1Z9SMjEu0PHussFIn0srCu0HDLbmscu9+46+kHGHcbrctk/jB48WP/TuaCY8Ey
         RD+wSNjkDxmN+4daJ3MwJX41K2prP1MT6FlPCtQwnVawHowz34EGic5kR1nmj4eAjGwe
         se3tFkCDfYDZbxPypJJRm2ned0ISinPE3b6TCv5rvIewwzQX0WGoYhpTu0meaYtZwOz3
         5VEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oikrldI+OBOTPyHwwL9NWbSdthSThDKPFciiKUoHmng=;
        fh=MXw6l98E70IZ1alrgRuiX02XdygTwEFyMJvxzK4rNc0=;
        b=WZp5g2M5s2DAm2hpTCmbmv5M70DC8YELbY/pEO8UaKWPAEUT+N3Tc5qh8PECKwfFgJ
         f0Pkvbxg8wn9HWgcbJAKyUvNxtPJ9RNRVzXykW4lngmEh6UAr/pp4NyQvbru1BjsD6NT
         Civgbp3QuWexEpFKEIs0E9il+DnaPtzmGdzZSR35E2vuQ792ag/Pa5tEmlAwmXdK7o+M
         +EZZILVL1iTq4jOdc1UqQq8WPGEm9kp/5Deu93xa2kDwsGBi2WPepJCUZaGc8Vgv/9/O
         2k0R2NXzsyWZeXi9s7AcyU9ZsrVpPAlWLLpMKOWKmnbuxMaGX69RwQzhoL2qa71x9VAs
         zQlA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784257390; x=1784862190; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oikrldI+OBOTPyHwwL9NWbSdthSThDKPFciiKUoHmng=;
        b=OEkgOqvX8svW2XMvLvEvQc0Ax5OYZE4ubcAJpkBSX7rlL4D0Mi8nacef6VIe8pGuVq
         lNhJIiYnJXSzNDjWUUjh3mp56+JASozvRyNcBASAkM7KqcctIrONzP/O9hlgcwplECk2
         QRMrbbFOqqBQvS7rPcxeGTnEbPeAKIo4gsy5MBdmNEbY8mM6ZDAXEETShUTJIG96wQCh
         HlOozk9YUGnP/bcqz+IeQ2JxYhUNv3dcPTBkab5dyy4USQwK50QBjKl+frKiuAE7/i9g
         Zk2B7H/vNbbaz1X6G4B8cjRE2dx9adyWLM/Es0kyXFOg0OaJ4ujd9Ba2HSd+g8dP9AwW
         J4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784257390; x=1784862190;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oikrldI+OBOTPyHwwL9NWbSdthSThDKPFciiKUoHmng=;
        b=oXvtjfBnvp+QnE+c8PnD0q0ok/YtSEnaOZeUeBbzprVROl7L43VSAn1lRCAM3FW4CK
         oy2cea7QkBHAmhx7nsda/EvE8MjIc/lkWELzibwDu279XqK0jNXjZbDTcdC3IPOs70Nq
         YtH3GcIFJCRYsBa2xE/sd/HPn09gaPa77nFh/jJbeK19tam3y0wju9hQX9+UPxT5pKxo
         xIkiabJAksvBDjUGVE4oz0ynPHbByhHSc92hREy0s25NcRzb9XzVOEMW7QaUSrjoQKFj
         YhaW0vSxj9w/TyYF8Rte1V2b3lLsAWk93lZv0qBh9tviUhFV/PKJB4wxIi42Dh9L2c1u
         r9VQ==
X-Forwarded-Encrypted: i=1; AHgh+RpL7ethE3bG6jryRsNTD7DisLtzQmAWDodhDDFPGFdXrGoLqR2bfnPrSYqsKwC0kfX+8USMWjOoF0tAI0tECg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzT4CJbcOnuAcp3lmmGNJuWAkrDJ0u34xKLKT9QJYTpMTLaz/n
	m9ogpWhr/hJvKpsq8zpFX8kxpViNiCZws/wKqzomyNdT2qm7VFYpSdZLx/ectr2tt2enuPdGPKn
	JlMBt8+2ow6eBAtFm3cHSOqF6IQDZTdw6utw4GfGQ
X-Gm-Gg: AfdE7cmpqyDMLgwLHxcS0jBOs1qDUvD7BGJx/tG9/4aJx6SaEp1hkSg3sk5d9JPIgz+
	27ClEskyMH2VNzJVgyJUZLgQxR38hiT8Akv8P1RS4W6A+Pue2OO5vBOw8fXZasEmPzit5RJSZ1c
	YvESLoSdPyeAb+ERoH1pU1bEzNAn7M+yr/khX2UilnKZr/qv0y9NAq6mQvwYDjkZEERfE6lSGnn
	LfgZUJZaWKiOoJNrQyxkixmw8ZGFZhJCnaMpW2hO6GHCscoasB/WNrDJ6yA1xuzSFOQK0VWYJQy
	9UQCMkbM/5UWWtZm
X-Received: by 2002:a05:622a:3d2:b0:517:38aa:c2b3 with SMTP id
 d75a77b69052e-520d52524e6mr5272751cf.14.1784257389146; Thu, 16 Jul 2026
 20:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260709224330.946683-1-linkl@google.com> <8d316b6c-41fb-4ae3-8923-3b649b92b33d@kernel.org>
 <20260714092146-mutt-send-email-mst@kernel.org> <CALUx4KSxjpHhgkHZ5p1khLSe7+-cDHd+ZtBEJS1HytWSo5WbHQ@mail.gmail.com>
In-Reply-To: <CALUx4KSxjpHhgkHZ5p1khLSe7+-cDHd+ZtBEJS1HytWSo5WbHQ@mail.gmail.com>
From: Link Lin <linkl@google.com>
Date: Thu, 16 Jul 2026 20:02:58 -0700
X-Gm-Features: AUfX_mxvju2ajwqaWLph45EfnN052a5lxttcd4lHH1YraUcmngeJ8Hc_Z-8C0HE
Message-ID: <CALUx4KRiyxDfoA9D48zz0fChrsc_NUFk3gDacZrMjsntj1m=dw@mail.gmail.com>
Subject: Re: [RFC] virtio_balloon: fix Use-After-Free in page reporting during
 PM freeze
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 14, 2026 at 11:05 AM Link Lin <linkl@google.com> wrote:
>
> Per the earlier feedback to keep these fixes independent, I'll format
> v2 as a 3-part patch series:
>   [PATCH v2 1/3] mm/page_reporting: use system_freezable_wq
>   [PATCH v2 2/3] virtio_balloon: fix shrinker UAF during PM freeze
>   [PATCH v2 3/3] virtio_balloon: fix OOM notifier UAF during PM freeze
>
> I'll send that out shortly.

Hi everyone,

I have just sent out the v2 patch series in a new thread:
https://lore.kernel.org/all/20260717002311.681748-1-linkl@google.com/

Just a quick update: I previously mentioned I would include a fix for
the OOM notifier as part 3. However, upon further audit, the PM core
explicitly disables the OOM killer (via oom_killer_disable()) during
freeze_processes() before device drivers are frozen.

Therefore, the virtio_balloon_oom_notify callback cannot trigger while
the virtqueues are deleted. Since it is already safe, I dropped it
from the series.

v2 now consists solely of the page reporting workqueue migration and
the shrinker TOCTOU fix. Thanks again for the reviews!

Best,
Link
