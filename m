Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A68778F41
	for <virtualization@lists.linux.dev>; Wed, 15 Jan 2025 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736951680; cv=none; b=Dgd276OiWQnThpzml8Rk3qD6Wwgpz+nMn5NfMtxnS3kCfXldnl3FRtCUPVV0b8Bf2Z6fEvwpyJqSXzb7FnbqHimtevF1rudN5NT2TMfuKF8epfZMVLnRk/rRpAP8i1IlhbYIO2Cyrxy0MQM5a4QJvb2QbCsOugfRBXyZQIB50t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736951680; c=relaxed/simple;
	bh=wgpCbUXuk0fjx7PlpFBa3YSbnvvXmj+DNx/eEdB8F5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stiCbmpCzQxEtXmljQRpbSrc4jcVNIzDLCsLN3V0HvSINKw08SjlBKCA4yZIh/wFWPDkA04oRT+MPgPNo2pxN8zHVV1x3bDYXd/DkHra7pebWep/qLoVgBp7R0NngLB4zp+0pxzlsTvzO3GFBEVgVwv1VEt9nevyR3VL2eo/c/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=h0qt0OYq; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="h0qt0OYq"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d89a727a19so9128696d6.0
        for <virtualization@lists.linux.dev>; Wed, 15 Jan 2025 06:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1736951678; x=1737556478; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wgpCbUXuk0fjx7PlpFBa3YSbnvvXmj+DNx/eEdB8F5M=;
        b=h0qt0OYqITL9QdntRISFsBR2Spn/VMAQt/Ax02H1QP7JB9QhkzZVZcOoVrzkDMihFX
         MxxUF9hxSbtXthy8OY3jWlTwVDKOCzAQ1kXgnTSOhTvGvPQO1zIH35jWXIb9gbLfGfVg
         OzUsqT0wMA+D8EOpS3XA4RgN9tAAd2xGhCKExv9qM1DSgTtfy8mTHCDeOsZs9HdFln/5
         q/cdyEcaMEsWWN/6FBuv599zW/mnqwC5pRfLSTkbjodWmmjz8jdsxwiricv4P4w7EA1n
         0nK+E4NFQQaO61eZ3UTrTJzbAcn5RYnHB2vwIY0MKCO40ga9eJFt1Le0P6qAPGlVv9+d
         KR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736951678; x=1737556478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgpCbUXuk0fjx7PlpFBa3YSbnvvXmj+DNx/eEdB8F5M=;
        b=QW5+XfN+aOoFIB3H82RcVgvV1QWA86UYc/onCo/3gM6wQLzMtCpM7pYRYzJ9IhuTyX
         TfgVn8houpiK15ax/1BRJGtnZ2CMHni4rdikTrK1/bzfmlm9juexzJ8NQzbjLDoFmMXJ
         lxYt6kSeqITPAqA8zM+x9wgtrPy5Bvj0eyORTR57Iit5hh1V49Xdne6RYKDmCPkc/veo
         /1NPiMTb3ZYdSMrPoLHFn22YuZv9emmxxe1FBDioGG3jtJjTqThmvmLXJeUdfmIY4t6N
         TNt/wwXSWaHK41DdD48EKc8aDgTJBdS3md9tEhRqeQBOhPkPsDS5EsXQpoVULXCjJgw7
         4Okg==
X-Forwarded-Encrypted: i=1; AJvYcCWheAA0lXjMla4dcw5K+qCv7CICGqSldTBSn0m/VB0G9wJRS2rrPT7Ql9YuV0LwTiEsgTXfx7gbXp803PdRxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRa5keWq8QGsZaGqI7YneXZCFkKO6gghLnrO6xMmlINX7t/Y6Y
	ZTyp0z0DuJKKyLrz5cJ3pa99YgYToDodKQjaXec3nnTaAsEm4GBU+bcM4TkvqRtx341iVxViR9h
	gQoxGD6ol8pVp0KX8ka4u7aijkZcBLKijZfuNNQ==
X-Gm-Gg: ASbGncvp7wR/k5bIl9VdLyV6pa2FvlJTSrYnITyO6VenX0G2usCKTCIl8EAAmzHkG+5
	I4ezxcw8Jm1iR91ev6gyhovsqNAyVHlBNH2I=
X-Google-Smtp-Source: AGHT+IFPz9fbMcvhhyZZGYYuWLUwXCRTy8s+kBCbi69J2hIRU1+TB7begqOpM0+xy1s6GqB+nx1X6ZJAR0totDSXOwo=
X-Received: by 2002:a05:6214:486:b0:6d8:e7c9:ffa0 with SMTP id
 6a1803df08f44-6e192c73ef5mr43851476d6.19.1736951677902; Wed, 15 Jan 2025
 06:34:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250109150310.219442-1-tzimmermann@suse.de> <20250109150310.219442-26-tzimmermann@suse.de>
 <cdbe483d-0895-47aa-8c83-1c28220f4a02@ideasonboard.com> <bc97b92e-7f8a-4b92-af8a-20fa165ead55@suse.de>
 <f3ba05c7-6e49-4641-a3f9-ba418ebdb7c3@ideasonboard.com> <c6735280-7c32-4319-8ca9-a7305d8117c3@suse.de>
 <d67adb03-5cd0-4ac9-af58-cf4446dacee3@ideasonboard.com> <0ea6be58-0e04-4172-87cd-064a3e4a43bc@suse.de>
 <f35cb350-6be9-48ca-ad7e-e9dd418281d5@ideasonboard.com> <4af0b6a7-c16a-4187-bbf5-365a9c86de21@suse.de>
 <e327ad84-b5c9-4480-b873-dc3aca605538@ideasonboard.com>
In-Reply-To: <e327ad84-b5c9-4480-b873-dc3aca605538@ideasonboard.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 15 Jan 2025 14:34:26 +0000
X-Gm-Features: AbW1kvZOqZIfsgr5MQqIuf1jKNJtcUmkb-2ddanRpBEhDxEw_Wl931RGN2rzkA8
Message-ID: <CAPj87rOn=RQ615zyaEdFT2ADfPztU7+heVi0G34Rdg-=QO1cCw@mail.gmail.com>
Subject: Re: [PATCH v2 25/25] drm/xlnx: Compute dumb-buffer sizes with drm_mode_size_dumb()
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	imx@lists.linux.dev, linux-samsung-soc@vger.kernel.org, 
	nouveau@lists.freedesktop.org, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, xen-devel@lists.xenproject.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Andy Yan <andyshrk@163.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jan 2025 at 14:20, Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
> No disagreement there, we need CREATE_DUMB2.
>
> My point is that we have the current UAPI, and we have userspace using
> it, but we don't have clear rules what the ioctl does with specific
> parameters, and we don't document how it has to be used.
>
> Perhaps the situation is bad, and all we can really say is that
> CREATE_DUMB only works for use with simple RGB formats, and the behavior
> for all other formats is platform specific. But I think even that would
> be valuable in the UAPI docs.

Yeah, CREATE_DUMB only works for use with simple RGB formats in a
linear layout. Not monochrome or YUV or tiled or displayed rotated or
whatever.

If it happens to accidentally work for other uses, that's fine, but
it's not generically reliable for anything other than simple linear
RGB. It's intended to let you do splash screens, consoles, recovery
password entries, and software-rendered compositors if you really
want. Anything more than that isn't 'dumb'.

Cheers,
Daniel
