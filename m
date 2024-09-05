Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B88518787B
	for <virtualization@lists.linux.dev>; Thu,  5 Sep 2024 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531398; cv=none; b=Rs90lpLCKxQnizG7YbCvdMlNPIZBeU415wYagn+5M7z2Q34nlwWnUd4355IlDpQfTyNtjaidoC27JaovKolUGdeZosEPIaqG0pti/3FmRjfSqqubnHzFGwQgCQZlZ+9qrQpPjNIxAktbA+Wdlm1HRaHFdfcsx5WDqT6yGV6sroI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531398; c=relaxed/simple;
	bh=xd6tRDcBI6nT0vpG0+47dCoixHmT48y9ZIC4bv5qVFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hF7LRQtVO+cmi5C1/NDk86+bLj4mhiArn9OOcGLG95JGMT79xpylr3iR7Im+fF4WY51d6KCNP+ZJgZv4v+6Kj9g0L8ju6ONN44W8rC44NM8RMhmIdyXhKvEc6dpiza/RpMw21xDcRtQRgC8yvwv1xD+PLBmkAVDDLrzp4jIfBk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=gftGyEst; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="gftGyEst"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e1a819488e3so641616276.3
        for <virtualization@lists.linux.dev>; Thu, 05 Sep 2024 03:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1725531395; x=1726136195; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xd6tRDcBI6nT0vpG0+47dCoixHmT48y9ZIC4bv5qVFY=;
        b=gftGyEst4KvLDaus4fpG3ePdFCqfI7I+uACsbiFqdtL64jgKIx3Is70VkSBxhgkBMQ
         YkT+bEMNspoHpEmy6K/Ch+ktqeWvyyUPXJE7ESPxzehiMCalACWO+Ta7/217G8TABQjh
         5/xaB/6Ea4NoUiP0/GiNtHIbBzVLdWpp6WdbfFjJwCYXTEMia7ar3t1vqUhoJn6+5ktV
         2earP2jlu04PZ54mJuNcfd1R8CMyEpg7jInLXEiGoGdgsio6+ESKT6cJXPzkyJbNUBzp
         jwWaf8HydFzxPwqKXQ3slZNroKPiwlcdBagioM6St/CLkoy6jA23ILD8FtmF+cTYJI+6
         Odmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531395; x=1726136195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xd6tRDcBI6nT0vpG0+47dCoixHmT48y9ZIC4bv5qVFY=;
        b=eU0oefR71oCKq3w3zJBxvkisFwrKrcVX3oCUc7YJMTxUidcl+A6I5qPBwZzFBglrYv
         /BywzQ6RhOPQrlXB8Lejm5nOaqNHZi4m+fpSAqtnCh1s4C550Wc45wpWLAV6a7Ydlowk
         lZJWuAqdubGtb/6QoUs4pqn9gvvlasmdCyMruC0TlfaDglMaFW02ke5MhDGzKtyF3pnV
         WSYhzqOy6ZUqAZ4WqicJPkybUlBcN0LPdi+P6ttrWi5X8gZlPEeFWSphpAxBHsQ7qYS/
         N+cYupom8csjnvMJeOVPn3BzA8J1uEdaTWD0NKemZvvgWbJeO3VwwxjHvBuQXrDys2K3
         A1Mg==
X-Forwarded-Encrypted: i=1; AJvYcCU8T+NreRVLcSTZbVlvd4CBGu0+w5f6oni9vanNKsGgopq2ps1QO4BScdfRFUeTbcX5RC/0oi0FzSEZ8iHKSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrNtUFN9CvMmeL6HB09uml2GMu5EppuUXqvsiPT5ryrUxm44dG
	2a5gIPNPLo7hnivHdBZaYDVANF24yksyjtRvfolup057Njud53cKabdtqMM+Uge9dd0ADK7fZQ/
	udUohVH1nd4snzBIvAFX3FlOVaMgkGSt+3O9VUA==
X-Google-Smtp-Source: AGHT+IHOAa2WnFWM0m3QmtHGwmSzixacJsCBpWRBvguStq1YD37bVLj0/P6F5Iapvjw7xs8jP/X43ydPbq380G1rQQ4=
X-Received: by 2002:a05:6902:1547:b0:e1d:1b8a:ac4 with SMTP id
 3f1490d57ef6-e1d1b8a0cbemr3960625276.11.1725531395247; Thu, 05 Sep 2024
 03:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240905093935.2780632-1-vignesh.raman@collabora.com>
In-Reply-To: <20240905093935.2780632-1-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 5 Sep 2024 11:16:23 +0100
Message-ID: <CAPj87rPCctE=iJKfQXR-PJdUHR+5f-t2bRA5Daq2fzUTNekzcg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/ci: uprev IGT and deqp-runner
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, 
	robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, deborah.brouwer@collabora.com, 
	linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vignesh,

On Thu, 5 Sept 2024 at 10:41, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> Uprev IGT to the latest version and deqp-runner
> to v0.20.0. Also update expectation files.

Thanks! This is:
Reviewed-by: Daniel Stone <daniels@collabora.com>
