Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A851FBEB7;
	Mon, 27 Jan 2025 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737968750; cv=none; b=YcIJwgB59qmPBiydVDwSuzk+Z6atLd2FV/mkT9D2+ZiqBCOX2oTa/yifQtUmn/SoDn21+JAHs3e5Q9YlPrJPtLXTEove14fqVxxPp65gNi15TttMYJ9RJly1fje4bepmyncL+G67yFAa/O82lzhYsoVnrKU6j1MHa4p3wpXZcJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737968750; c=relaxed/simple;
	bh=sQGiOSFXQcB/cuKBWCQj3aB6Enw5rpIAAdVFTilt6zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVPGePCjmXsF/cDQ2FzJE2DM4td8m28gWlPY/tE8Jd1XGDIVek2SLYj1CMY4bcywSHVb8TbHU9gAhcWnRIVLojT01ahtA1OwiUDBWr1gcDEao2qScJEV65ZgYMHR7nZCU3gphZUizwu+/ix9D67cEP4MYAolLJoBT+wqEKbF3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tf6Vt9SH; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tf6Vt9SH"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so5540066276.0;
        Mon, 27 Jan 2025 01:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737968748; x=1738573548; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sQGiOSFXQcB/cuKBWCQj3aB6Enw5rpIAAdVFTilt6zE=;
        b=Tf6Vt9SHBDCBbcHh+Dz832By8/Q7CC49Z87cCMnzBPFR9tq1TOaWJ0BJIZFnEu+oRW
         sAuu+Pckml7fSbUdvkqjhdpg5QgSl15ssTOtnuOfe1E/GgKCvcrELJuLPRkBZA355/uV
         ZYpI8fMzht3QZ6ddIrtu9waRDIiZirtuWoOfmZP5cK4nu7J1Ew0QdqGcuyo52l4hhiAs
         O6aFZsIYeU2UnItjRfOjfHVVI47Xp2Uiy1JoV22HKVdda+Rmdh47M6FZUWaojLUdiTsE
         YIPHaJOmRhK1t3c77U6h8Cn89DHXAeKSj5Xfcd+MqScQXxLh3ke81CRzUn21/EKMYHDA
         erZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737968748; x=1738573548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQGiOSFXQcB/cuKBWCQj3aB6Enw5rpIAAdVFTilt6zE=;
        b=cnVA6QZevW1rGnMF4/iXOw2Zvpb97o5CnLQxSNZXv5TH1ilSbQA2Wwua9RQOIPmTTc
         aBWP0Hx0iZMAmxRNkvT+5rA7V5yP+L88rSQB2f7EiCT8q+nECrb+wnJUU4C0B8rEE34D
         qwmjDzfhOwMZm4rU7jfy4Oa4sTa2IjHkhGE8zTK66k6LrpkdaLAnUf1JQ+lUhju5Ozwg
         7Tr72hFHD/FygIYFOKH1b1WYwfoOD3Fh1N5ExXvwjybRF9psi9FWdTDBg6szGUV37Ybh
         Wr1A/2XaJb6BIwdnerH2GXw0z8Lgo+3Mn90HyM/tx4Zgi0Bzy+gcc5DOH7v3zTHHM/RG
         /dlA==
X-Forwarded-Encrypted: i=1; AJvYcCVORXIWS8B3+6fvd5LwvM2dYqCYIbmtBZysORzjZDy6JVKNhC5JRKxadi0li83hUftiPMRX9GdVGL4++kaFaDc=@lists.linux.dev, AJvYcCWZsCqh3d8g6TIr8pk1rBTfz+xRtEx0jQbzEM+bxAwTkrJLGCarBPkcG8QVQ0PE3gK8wfGzCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJOTglJ3OmZF67LNMX8S7V97A2jHateRqiNvOYmWmKNb7MR3ty
	EouFd9IIBWf2kN4QZ+5tntvdcZez5Uk3x7DtB87qCsbLkIou++PhijkGMsBQfsMN1iQf5rH9jj8
	fiBNQGYHLCbFlpwIDeSv6W4HkCfI=
X-Gm-Gg: ASbGncuLHWj1JwKwDls4WveEOr+D/TfbTSYXRYF6JJEyCIRde2vLtE3/omoNRq+HtWN
	wbQwLnmT23Ao+8V+gYH9Mg+dk1C39mxuhi+1M+mtpDVomCjZqZqBV2XZohi6BCq0=
X-Google-Smtp-Source: AGHT+IGa7Yl6B8MJ5QHXf3TY07Rd7fNWx9mqcOicUKXP0SfBOOhR8dEmrgHpYp6Q1QN7SewjsNLFXRP6Yo9F5OKf/IM=
X-Received: by 2002:a05:6902:981:b0:e57:2a07:a975 with SMTP id
 3f1490d57ef6-e57b109e39bmr26749441276.29.1737968747818; Mon, 27 Jan 2025
 01:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250125-virtgpu-mixed-page-size-v2-1-c40c555cf276@gmail.com> <4a1c7ab2-66b8-49ec-9662-6827c811ab69@suse.de>
In-Reply-To: <4a1c7ab2-66b8-49ec-9662-6827c811ab69@suse.de>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Mon, 27 Jan 2025 10:05:36 +0100
X-Gm-Features: AWEUYZkb1KQh_RTJk_H3d8w0L3RB1N-n2GhnQODabid2mVrXgB_zFRDciDlhCzU
Message-ID: <CAMT+MTQY3JFuCUK1OeQ8zBoe51fqPyHs6x6QmuY0eHP_e61Hfw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: Align host mapping request to maximum
 platform page size
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Simona Vetter <simona@ffwll.ch>, "arnd@arndb.de" <arnd@arndb.de>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jan 2025 at 08:31, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> This is per-architecture code and does not belong in a DRM driver.

I agree that this is not quite the place, and ideally i'd use MAX_PAGE_SIZE
from https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
however that series has not landed yet. Would a todo comment
with instructions to replace it with that when that lands be ok?
