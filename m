Received: from mail-vk1-f193.google.com (mail-vk1-f193.google.com [209.85.221.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92311EDA05
	for <virtualization@lists.linux.dev>; Fri, 11 Apr 2025 06:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353389; cv=none; b=dYKS/5tsvQvTF0ua18w8Z7Yg2TDTMzkIuzbVIO1uLPTf/yqD5EEwS+vYDAF8oSmk7I5StDJf25IjXlvvanC3kJMLLsg6veGChOYikU7fvNDID8XyvLyEb1Subu79jXXFjeTziQnGQOjRD2nGDgWSIYhVl9IJP+qdiWefqjWC6xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353389; c=relaxed/simple;
	bh=TmRsfdrl+SkxHKqFCnuLtJKoWjb6p8iTBz1i+VJGK5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=td+WsLI75ssPk6rOnjsrm2vPKQSzMdNPV1P4oBmMQsIzZh6X67gOgzhO4ERIh0K/e0UiBHeZMCndRlqzt4TL6MEM05lkydaFv8BQAyRu0S4MmKHgq2QEvRMZlvcV2vneskeKYjNyvOwFnHeplZ3DPqEA3oSSLzJ5wHT3bdHeNq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f193.google.com with SMTP id 71dfb90a1353d-523f670ca99so773791e0c.1
        for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 23:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744353386; x=1744958186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YaWTI7DWsK4VeI0QvD2ZFS0NMVC1Fl7xtwp7U/95NA=;
        b=TYAKm9g6P5xs8VSZyk5MTT/r8ZuBelcoYBiDIH+ayEmB1FGJKBsPBRP1/C8fhDUnjX
         +xgNQyk2GJupcfgriaYoZJ4Uc9DhH0nfKzpS/zkyvDfTNs5Xy2WXumrijo3NKfiwFbh/
         rc4xOaghITUMSSAsmUXczE3xndoGyBXd1O7Xqo3x3eIWOiKbn5HRkDqHV9g2iRH0/8x4
         gLT8cLx96lh7i/eonzojOLYqwVe/4hUn9jcXGkxzsnCJabdg2SIVbme3ETo2U8l2ATkS
         cJjHWjDGMqn6png+nDxs90dYR9AqpcJ5ApRnz8Zqev8Nxh8ZKvWZpDiYfRIqPnyowDQl
         OkwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKPWIGipW03H2gd/941J1vXyHDU5Rn9+LV/HH1AbtPHuP44vjSO35sE6Z7N0g2klUR0vSaQcWdIOajURxnSg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbUj8kZMUc47Eg+7CCu8zmSu+ZJZ0lHYmtOhsmX5UppeowpVdg
	AsTcGEnWuDp9rprDnshQK497aPqNPo9vYC3xuOtDraNgg4rcMYimpISOe5LZj8fTaw==
X-Gm-Gg: ASbGncsHx1PpUNZmvHRyY8pv9ksbN3uC237zYb6zXTcdhU2aJh9MPveh5QnOsXWE/CX
	Iv5y7W0SyhpMzx1qYZma9y10ih48me9AzNR/qD++IbRYVg+iYqRgbUv5pcF9rZVxdiBaU9/VVKQ
	NS7Z5KzMxNJLvekQhH1dPr+EeH0HkHYCH716rWJdm+AXDOmb7lGodVywepFKiEgOMG8VewI717N
	EPzA3UDXWBisDYsc6R1yZTn4BySdb4Eg+Wvx6xaHv0pIA9++PvMUY6i5/gTTwfkWR3Xt/nJZMho
	8pyuSsRec78Q7JdCt7HD/rbNwlTPyQWQziQDqXNCKTPI9FNkjLCByMutJTRhJVAse7nRufxZnV+
	crj8=
X-Google-Smtp-Source: AGHT+IG5c41qh74nWTCgn5rOACUHa+fpm+pjZK4l7Pv1hjtWrviMxbbKCBOxbNEOWcw1fA3LTJFdTQ==
X-Received: by 2002:a05:6122:1d89:b0:518:a0ac:1f42 with SMTP id 71dfb90a1353d-527c3464832mr712511e0c.1.1744353386553;
        Thu, 10 Apr 2025 23:36:26 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abe8e78bsm984096e0c.32.2025.04.10.23.36.26
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 23:36:26 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86d42f08219so682737241.0
        for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 23:36:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+vc6tqO3k62pzrDWoTseH9DakRO3KOiXaT1vVyyDxoY98VUo22kQNE7Br9N8mBQ+M9+NlhFvfl3g6Cfw06A==@lists.linux.dev
X-Received: by 2002:a05:6102:5489:b0:4c1:924e:1a2a with SMTP id
 ada2fe7eead31-4c9e504c3aemr736947137.25.1744353386128; Thu, 10 Apr 2025
 23:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250410163218.15130-1-ville.syrjala@linux.intel.com> <20250410163218.15130-5-ville.syrjala@linux.intel.com>
In-Reply-To: <20250410163218.15130-5-ville.syrjala@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 11 Apr 2025 08:36:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUt4UkiTqe6T1QPxAwJdLnQfaDjw7_cKYtTx9WVed9Z0w@mail.gmail.com>
X-Gm-Features: ATxdqUGG68dHUm49IQV8G2NJ_HEDfXWabJxNBHJkOpQT2upH4xlbmyKOguLtNHo
Message-ID: <CAMuHMdUt4UkiTqe6T1QPxAwJdLnQfaDjw7_cKYtTx9WVed9Z0w@mail.gmail.com>
Subject: Re: [PATCH 04/19] drm: Pass the format info to .fb_create()
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maxime Ripard <mripard@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Inki Dae <inki.dae@samsung.com>, 
	Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Zack Rusin <zack.rusin@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, amd-gfx@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Apr 2025 at 18:33, Ville Syrjala
<ville.syrjala@linux.intel.com> wrote:
> From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>
> Pass long the format information from the top to .fb_create()

s/long/along/

> so that we can avoid redundant (and somewhat expensive) lookups
> in the drivers.

[...]

> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

>  drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c       |  3 ++-

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
