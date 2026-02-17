Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE1E36F40A
	for <virtualization@lists.linux.dev>; Tue, 17 Feb 2026 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771346398; cv=pass; b=IKqifkzd2JeArnEh3uHvg98efza2SjMn0Xt+4jopE/yy5lEmtVajIxdV+Op5U5R3UsRMRwzBEpTU0VKbU9lm31otsb0l3N0uO15Q6YkjdUVk16jvf48LW3n4Zs/isub//B5TrXZ7NxzMgm10HJI2pmhgFHOpDIi2M9aP/ev1h2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771346398; c=relaxed/simple;
	bh=mhFlo0RTzhPOUkDZzsQsqt965UTKi2HyH+KdNyyHrvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDmth/cR9VUH+Ibenu+1DPI9apYbtbEb/+W6bs0V5HLTDmQeIVlwTMXQjkkl1LRRfjEYfOrftWybtLPoU5q3Me90RNxA3+fAoutbOYzaiOK2CRt4OtwvdtVfjGFMeWTbh11ovjjtOg/lY5oZF9P/Zmb5qO7uc4blsGyu3beyEy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FDzt8b3d; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FDzt8b3d"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50335b926c2so39655931cf.2
        for <virtualization@lists.linux.dev>; Tue, 17 Feb 2026 08:39:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771346393; cv=none;
        d=google.com; s=arc-20240605;
        b=IYbScZvAXF9L2ahLFlVQi6HhExQ6Sll7ygNrFOSizclOguh6/e61UsHzwP88IJk3J0
         qcL7TGlwu1X/o8QqYUCMD4t0PsHuv89GiPINkLqcaoJ7kSdXYt2lzcZe1KQ/hFQwpd7E
         NXQuyxOkgVQdA//4owritYU6yHGP5m+tCHKPOAInt5pt5NIEnNTac2zSFk3y8q6vtvll
         1H6e4uHYj8Tbk5KrCba3pKrbeY97gIfWISnhWyT4Rp6gLpF1on/yuK/58Urnxn2mdnig
         d+49DNrFVcEugPX4lBEwU/J6ouil3MUYDpk7Imo5IEPIDOUxnrXOtjh1O20TmHAybes4
         762Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mhFlo0RTzhPOUkDZzsQsqt965UTKi2HyH+KdNyyHrvI=;
        fh=XaB/QO6TZcBcukaCzD9ZPX6ykHnoSQpKaEkLwTm0QbU=;
        b=e0YE3fzGnVkn1zbpZesPoAONH11m1ZJCcM4eS5Vgk8mrXV8SEBm2+k0MQqP4///WCD
         sjm6gEwjCmfyPdyh8KzBUc9a1CWd5bzOIpdwVr3q5ETztRvsLAiDsTbGPFmnwxK6dwDg
         LFWie1ehhFOSMl7s/DLW+hY5v4JNc9Rf8JV65PunRpxjzojTekLcRjIOypbYBHsWZVQR
         enca2gTA22ZLESjR0EwrP7wtzqJh3brLt2EOTktrUk5Oc8DGPWLEq51WYNYtigiysd7+
         QmgX1NDmF1XJIqtjY+zHMcCmzXHIQPiN6km/dU7eb4/6rXZCrVfSY3zW4pLcaYMJY4ED
         0swg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1771346393; x=1771951193; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mhFlo0RTzhPOUkDZzsQsqt965UTKi2HyH+KdNyyHrvI=;
        b=FDzt8b3dSPa+QiR7/153JRqoYbVGF3FRFRdXfq0XOzA/0Qdx5Uofp5tX/ROJQ43h7h
         RS6f/vJCNsZJiaALwVEpU5CLQ3Chcrv17Fim7leh8IUflPvn9JgEhsOGDDZeeMD3XGu/
         rDSrI9zPBM9CukbI1RhRe28APBQdTHQkNSdFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771346393; x=1771951193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhFlo0RTzhPOUkDZzsQsqt965UTKi2HyH+KdNyyHrvI=;
        b=R2AObNBS7Zypo5bvCyhffFteQGAc4zqDuRJ5pwY9dDgQO2vnLkEp7fSK2c5RyfGBPL
         AWOZ8x0zJQ+1+0fToKw96cRdueNVyhl2Oz0dg3RQWDUu5Mu9gV774PGxFhO1PIuI0PKd
         kLqOUCuT5+XaaaIdGdNe6LMAxnw0/HRMWkSNDX6U2mLP+EGuBKwUq8qUDD0XNa3tvxKw
         WAVJqpz8xozHVxBsPj5NH6OY9MIv5o+cJNCxba7I9mXUwszZ3dIdqbZwz2gXLx4qwjPu
         T8awCPIOwfH7UCwN+sczPp0FauhPLTz/qooQVa791UJ0iUkuWv9evnwK29HGNhRwufEF
         aNaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOCzNO2tmhaJj6mlCRJVvu/w1+v+27ALDoXfa6K1FDX9jdXgcbW+DuK80UJ2Y+nEJsuw9OJcNz9rWndg/ekQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAceUfCiC3AgP/qjntT+908hYx01Hh1aSNomB84kDIKEYxkFNN
	ZPhIS/R96rjsVowQ/rYluCthn+wPE1vtqbZKMcFmEdepDthbql66GRnjY3qSZVLVTdgnwEw5nms
	rQGXvrb0QDnOzQi18gTFqkXZNZqpkH6rgBb5zVRCA9g==
X-Gm-Gg: AZuq6aLNnUJFJ2XyVZWkAX45yj5VNTZ28JMMvlcOAjcPM6IwDlOoxxdC8gJo7eokem9
	6ms1fX+1bWxidQN43nS4IF3lUwiwcopAf4QYwrfm2FjND0246GDlfiR6lfvQhjzo+YDUVUhTapi
	+4evmHls8hpIlNbQgDwf9i2ts/dJ3/tjz1W9gENCbIVM2Ro3SQGqeJ7nQBHYAdW+PdwzEbFQOwt
	8ovrq59KCiwXNz/ZYUU40/19V/fDhh6XFjiW5Axc7rRMMe6EPnNUtP6ASSusXU5lF339bThgF61
	pSXyKrs=
X-Received: by 2002:a05:622a:1483:b0:4ee:146f:2502 with SMTP id
 d75a77b69052e-506a82a4d8cmr174569751cf.25.1771346393387; Tue, 17 Feb 2026
 08:39:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260216073158.75151-1-ytohnuki@amazon.com>
In-Reply-To: <20260216073158.75151-1-ytohnuki@amazon.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 17 Feb 2026 17:39:41 +0100
X-Gm-Features: AaiRm50ZJQWukD4STFELd-seNULmcITyjXX8VmFAZxxkRzbE7k8jrX2FOuh4BkQ
Message-ID: <CAJfpegtN2ufQQcPh1G6zzZzXF-PRcp942pE3Oxmqfo_5GVey5g@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: add FUSE protocol validation
To: Yuto Ohnuki <ytohnuki@amazon.com>
Cc: German Maglione <gmaglione@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Feb 2026 at 08:32, Yuto Ohnuki <ytohnuki@amazon.com> wrote:
>
> Add virtio_fs_verify_response() to validate that the server properly
> follows the FUSE protocol by checking:
>
> - Response length is at least sizeof(struct fuse_out_header).
> - oh.len matches the actual response length.
> - oh.unique matches the request's unique identifier.
>
> On validation failure, set error to -EIO and normalize oh.len to prevent
> underflow in copy_args_from_argbuf().
>
> Addresses the TODO comment in virtio_fs_request_complete().
>
> Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>

Applied, thanks.

Miklos
