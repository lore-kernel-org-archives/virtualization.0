Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592D02641DF
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079221; cv=none; b=sL9awqZIlIzGrBhRQNN46ggr16dGoTOsnu/+9FgiQByedux9fEOmeBeocKEV+3Qj96a3qEW4kExTY4pRKfXW1ntpQqdNjSXvraOryZWbrMS7oKiNlXZm8LMbLxCxPbrq4csq2wh7XxnwkpzdHmQxSU5nNBQyrcPlIIPYJC+n4eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079221; c=relaxed/simple;
	bh=BF/qm35P4uKsbrKBn/gLwoY0GozMrLl3uevc+2xL6YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cr2/nuJWK7+eJiF1wCmB+EtBZWgecgRq6oa9bS+iS+g593RhsIHSnv/88/vp16T9OP6Ubfo3diJ/Q4C5yZKQPotRwVJ2S7TBqSGNlOnB1dyjmF9n2931bGOlDOfFiioEKiLTiawSpc6mD+xnGceoKxgKyzXh8NQTK3038wL+ayk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fyeY54JE; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fyeY54JE"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fc29ac55b5so312604a91.2
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 11:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740079219; x=1740684019; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpS2FnqN2TDBERxg5I5MCZqVN24rvf9DEtZLCeAzcmo=;
        b=fyeY54JEF5UU+3FUwKC/s+SyWsRpTYL2ULGqGq+VrGVq6B+naLsgcK1P9Sg6jhEu/B
         b/vDHATx9hi2xBeB9bHfBq/MkU3gs9seTw8Y/TmBLSYQjrUSjyDzbzLIvijJjzvsBrPC
         NZDGCvXNtMeYRDGtzLhTQPSzWivxvDpGClb2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740079219; x=1740684019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpS2FnqN2TDBERxg5I5MCZqVN24rvf9DEtZLCeAzcmo=;
        b=tbr+EBnm2Tbml+L5p4bHEmcCIT5dyQYpkCETsuGbz7aU9kovsOGuj0LAbUf14zzRW5
         u/qB3YeuywKxewny3cOVLqfyOIbTcD2kpi9H6huhhH0kmHcSMV52xR09+qQSFOnTO5US
         WEW+uuGxJkZWOppJ2bisBiJNXoYHg2c17Cum1gFUd8GNQafgzHqf7OIN8gZhBbf99qKT
         OpDfF6P3HlfqOD8yIBBZF9DbCKtka93/DLgTUC57dJDObkn/uXaCQtH98Kf1zItOxxUF
         mkB0ylWQg6ZkWEsQ5tQOmAoCEGCbMlfG0O5XXa/K2v0Nga2eHgN9AiffoGZ3db26zp0b
         hgog==
X-Forwarded-Encrypted: i=1; AJvYcCWZQQtuA1p+FgA54KH5byj/7xcFrVpQfnkjBSahkwCx3Y09526eRMoDZzmFm5HJRj2Knoe0u3C7t7RXyubp1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMewhO41Zvnd4CiwkGBB0aobzvLmjE6H/dWFMm0RtSwKdi85wS
	HWmjZVsiSgjAX8S9xp6vBc6QsCC7oxGMH6GCZ6UPcpwcmGqjPAdGcWwWC8FCj+/61jpb33HYmVT
	O3g==
X-Gm-Gg: ASbGnctHHaN2jrJLuYYj4XW6Y/7I9/kJsyOzMCWq9q9OpxSDps0jOaae2eCT7jMz69W
	JoAaJ1MVHB+Zj5+M8LedY0fkKbQID6IAyZeOfAG/smZ2sAlJq64W2Rb2HJmtdS3IhAUH7nKQs1I
	tKar+o06klI0rajSaoi3fqqxz3Q1m08iYREwll6pOqHiJrIyqDjOmZ+uerTipJlEcABp8o1cjWz
	hErNQCGYOm24QWa7sVmvDYoWmY81MMvBStCn5Qjg/yPPy0wrwUqjRzb8UNR9qxXWkimD+D1rTLX
	BHFkUXwpG2ziVsQusXYhHuYMGToxLsBJi2RlwjgF9ehA/eptmPlAr0U=
X-Google-Smtp-Source: AGHT+IFe4Mo/OlZ+LFspfaW67QMf+9oXJiMO6/V9vVwDxDc95mQuR2EoPJt5Z6LF6b5eFMhjRaqtlA==
X-Received: by 2002:a05:6a00:92a9:b0:730:9a85:c931 with SMTP id d2e1a72fcca58-73426dc2e35mr20449b3a.7.1740079218041;
        Thu, 20 Feb 2025 11:20:18 -0800 (PST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com. [209.85.216.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73277135839sm8618331b3a.20.2025.02.20.11.20.15
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 11:20:16 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fa48404207so2738983a91.1
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 11:20:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVK+kP+mOhfoj94kXO5BbLlEUdZKY3xaTtaWsMbnida4l0onxDy0czhu0UilLlHzEAKuedbvhai63LwLQEHmw==@lists.linux.dev
X-Received: by 2002:a17:90b:3946:b0:2f4:434d:c7ed with SMTP id
 98e67ed59e1d1-2fce78c7fd8mr609023a91.16.1740079215301; Thu, 20 Feb 2025
 11:20:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250220-virtio-shm-page-size-v3-0-874fff6f3979@redhat.com> <20250220-virtio-shm-page-size-v3-2-874fff6f3979@redhat.com>
In-Reply-To: <20250220-virtio-shm-page-size-v3-2-874fff6f3979@redhat.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Thu, 20 Feb 2025 11:19:47 -0800
X-Gmail-Original-Message-ID: <CABVzXA=_S2in+OzfwK6vGQR3VK3YhGRu4B+tp5oCZKHt0Qz=gw@mail.gmail.com>
X-Gm-Features: AWEUYZlJc2Ri_gGb-xTYNfHBI9nY3KXtKqjPGrNSl2kv5ni8-vqVm6Z_S9XKcC4
Message-ID: <CABVzXA=_S2in+OzfwK6vGQR3VK3YhGRu4B+tp5oCZKHt0Qz=gw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/4] virtio-pci: extend virtio_pci_cap with page_shift
To: Sergio Lopez <slp@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, fnkl.kernel@gmail.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 6:30=E2=80=AFAM Sergio Lopez <slp@redhat.com> wrote=
:
[...]
> @@ -829,6 +839,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *de=
v, u8 required_id,
>                 *bar =3D res_bar;
>                 *offset =3D res_offset;
>                 *len =3D res_length;
> +               *page_size =3D 1 << (page_shift + 12);

Maybe this should validate that page_shift is in range to avoid any
funny business from the device; since page_size is u32, this needs
page_shift + 12 < 32. (If it's out of range, I am not sure what this
should do; maybe just warn and set it to the default 4096?)

Also shifting into the sign bit is technically undefined (or
implementation-defined? I don't recall) behavior, so perhaps make the
constant unsigned, e.g. `1U << (page_shift + 12)`.

Other than that, looks reasonable to me:
Reviewed-by: Daniel Verkamp <dverkamp@chromium.org>

Thanks,
-- Daniel
