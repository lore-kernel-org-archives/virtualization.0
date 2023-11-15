Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75A54404
	for <virtualization@lists.linux.dev>; Wed, 15 Nov 2023 07:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4Od5/O5"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-581f78a0206so3561808eaf.2
        for <virtualization@lists.linux.dev>; Tue, 14 Nov 2023 23:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700032034; x=1700636834; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DD6loysLm1if0z26gUfJWR92/8dI2bMs4fySErE1LEY=;
        b=U4Od5/O5c62Dsm1XgSct+fql3Fd/f/c1e9U+68tv+o/1RmtKvDyQg9mZvTsb5b1Bgz
         2xq6Cd9/56eFmQH4KcrF6uXuA7JGzwdvYg//9/HJEh5477wfZJWVjq79FnIkG1KCW0+p
         NfYldRHLU/YW2zMXLehKCceRwqam1AL8UoW6i9Xitg3hszrwJ4ImNyCoGpAt3WVBS1PM
         r8TPZ+FvyIqrZ6cjjD7Fv4GBvPtqLBzlkUkfpfXQJXt2tgI0Dbiy0QUWbNLfB+byMx6E
         UJIL7WrR5yDkkUkD5xQvOL2vFt4PxyUjXKZkTSRsX398/2R2YOMcPekiFGmGytcwOKK/
         zvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700032034; x=1700636834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DD6loysLm1if0z26gUfJWR92/8dI2bMs4fySErE1LEY=;
        b=IA1cLeDgYKzuK/skNSchy2RvZsTqABWipakgCto4Uftn5vsuXPTloy7EhwKGIWH2NG
         ppl5HvAhYPWWgRL34utGos9Bc5juzrHXjKrb5d03Zu0katXnos8+IUYJLQ0qDnyxQLZf
         DFltz4IMe8dZ7eGMTl/p+Us/oJ9qxRmiQhAfpkoppE9HOSj+Sf+IDnxxGB65kd/pjLFJ
         olUzeE5DDPjvDcMkYGeppZSifOESh3YXuv586IGWpHcCIYy9JDNxV6nCa5CnLbuPD6OJ
         7F+p56b31hPahPJ4mZQ7hQ8zddbjFOiW2t6PopDlsfm617EZKKsGWGQtS2USe0wnz1MP
         vXig==
X-Gm-Message-State: AOJu0YzwERL28FyvPJu+1w6S0ax+3cXPXjkmZxdIrDtKkB0MsM35GncV
	Iv4WRsNEpVF+sm7uwf/2sIYWit0qvz3rQxf6i8k=
X-Google-Smtp-Source: AGHT+IGraImbABbVnYg6Ry57RVFnd3IqKf02szE055lgCefoqqyZvE2zfw+kuPwbsXcgZfPjjXz5Afh8lqooVZbQ9JU=
X-Received: by 2002:a4a:305e:0:b0:58a:211:acf8 with SMTP id
 z30-20020a4a305e000000b0058a0211acf8mr10912431ooz.7.1700032033893; Tue, 14
 Nov 2023 23:07:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231115033459.1228900-1-sashal@kernel.org> <20231115033459.1228900-2-sashal@kernel.org>
In-Reply-To: <20231115033459.1228900-2-sashal@kernel.org>
From: Frediano Ziglio <freddy77@gmail.com>
Date: Wed, 15 Nov 2023 07:07:02 +0000
Message-ID: <CAHt6W4cdQSXbBf4gO_jR-q-Q8SAonNDoQ0f2cO7LsnT__priWA@mail.gmail.com>
Subject: Re: [Spice-devel] [PATCH AUTOSEL 6.5 2/6] drm/qxl: prevent memory leak
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, 
	virtualization@lists.linux.dev, Maxime Ripard <mripard@kernel.org>, 
	Zongmin Zhou <zhouzongmin@kylinos.cn>, kraxel@redhat.com, tzimmermann@suse.de, 
	spice-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Il giorno mer 15 nov 2023 alle ore 06:57 Sasha Levin
<sashal@kernel.org> ha scritto:
>
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
>
> [ Upstream commit 0e8b9f258baed25f1c5672613699247c76b007b5 ]
>
> The allocated memory for qdev->dumb_heads should be released
> in qxl_destroy_monitors_object before qxl suspend.
> otherwise,qxl_create_monitors_object will be called to

Minor, typo: otherwise -> Otherwise.

> reallocate memory for qdev->dumb_heads after qxl resume,
> it will cause memory leak.
>
> Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
> Link: https://lore.kernel.org/r/20230801025309.4049813-1-zhouzongmin@kylinos.cn
> Reviewed-by: Dave Airlie <airlied@redhat.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/gpu/drm/qxl/qxl_display.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index 6492a70e3c396..404b0483bb7cb 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -1229,6 +1229,9 @@ int qxl_destroy_monitors_object(struct qxl_device *qdev)
>         if (!qdev->monitors_config_bo)
>                 return 0;
>
> +       kfree(qdev->dumb_heads);
> +       qdev->dumb_heads = NULL;
> +
>         qdev->monitors_config = NULL;
>         qdev->ram_header->monitors_config = 0;
>

Frediano
