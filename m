Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1857F1944C
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="tEACfAPv"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85D2160AE6
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 13:22:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85D2160AE6
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=tEACfAPv
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I9hBiRmDwq-6
	for <virtualization@lists.linux-foundation.org>;
	Wed, 29 Nov 2023 13:22:38 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 71FDE60ADD
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 13:22:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 71FDE60ADD
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-548f0b7ab11so8953703a12.1
        for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 05:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1701264156; x=1701868956; darn=lists.linux-foundation.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/VP3ii8qzlwzBFXOUvCIlM2ChKhNv0Z2flI0ZUJ06go=;
        b=tEACfAPv1RL1clzItz9Ook9lumu2sSd3X1BACgh9L4DDkAkKKb/H4VnS1o1dUnqb6d
         wTzqm1Shbx8JQZg4norQT0IiDt7TsI9xTa+h5OsZTuoV16bcVK4ErDI8rDUBZ/svsik4
         vMisX2HtO6UZb5Nr+ahbg5QhSiWK8JZUHwZCd+VYoWKyrCxu1e82ab4ywC+XxU0eLyN2
         LFBUwJc97xnbgw5QdJFzNFWd1fefYR7IMEyUJGdd8131NM+zLO9cbdO1ZivqJJXWeyT2
         ub8UJYqwopFw6LrBWvzO3NdlwFF1yLrxESFvJmFlfFLdH4ZsWldQuIAbxn5+Je4KBcXv
         V7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701264156; x=1701868956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VP3ii8qzlwzBFXOUvCIlM2ChKhNv0Z2flI0ZUJ06go=;
        b=Z86Y/+SS7pxcQLb1AXsF/UkmZjjS/rMXQkxv92WpopvJ4Sl0Bi6pd/arBMfamyEthv
         TnMA/fckjAKsDKiDJIJsR1NJA29CltHmFy3m/npqX1KeS11uVMCgF+czwDv2Jk3dxauC
         495/WmhbyJtmj4JXykNBBBVq6S1gTGpxszrYyoWKaP5H7xV0sMGJJj+21np0IG4m7qJR
         0pUPxrdQfgA1EzQarWyvg5LjyFmPJY/CwbQwM7hYryx1Q5GdO8p6C/htE03bgz16t9NM
         N/+FboWpzNe0rsTKFgUzbPCeq/zSfWRMh7uN+1INsz24QnxZFb68SEuBT8tgbblJeSES
         qCUA==
X-Gm-Message-State: AOJu0YzlvIZTyvClwfc7HpY5eOEO09+lENjWKql9ElLEdBsECccrmOgU
	tdvCX5BtMH8IljtHDNOOyCJhbl245g94Xo+C+oWUsQ==
X-Google-Smtp-Source: AGHT+IESfQEmd7uikH5eYlpIkIXnzdfz7yOnSZr9KANdmLWdgeBrFVefxKHw37NvqQrsvZJsay74wE6WyTTIfjyDBNw=
X-Received: by 2002:a17:906:3f88:b0:a02:a2cc:66b8 with SMTP id
 b8-20020a1709063f8800b00a02a2cc66b8mr11788067ejj.14.1701264156218; Wed, 29
 Nov 2023 05:22:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231129121841.253223-1-vignesh.raman@collabora.com> <20231129121841.253223-7-vignesh.raman@collabora.com>
In-Reply-To: <20231129121841.253223-7-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 29 Nov 2023 13:22:24 +0000
Message-ID: <CAPj87rPKywWa8KxTCeJQz4vvgTwhPzL+y4aCX9zxZDkkfrvsoQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/10] drm: ci: mediatek: Set IGT_FORCE_DRIVER for mt8173
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, 
	daniels@collabora.com, emma@anholt.net, gustavo.padovan@collabora.com, 
	linux-arm-msm@vger.kernel.org, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, 
	david.heidelberg@collabora.com, linux-mediatek@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Vignesh,

On Wed, 29 Nov 2023 at 12:19, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> Expected driver for mt8173 is "mediatek" and for mt8183
> it is "panfrost". Set IGT_FORCE_DRIVER to 'mediatek' as
> the expected driver for mt8173.

Actually, for mt8183 it's both. And for mt8173 it will probably be
mediatek+pvr pretty soon. Each of these SoCs (like most Arm devices)
have a separate display controller and GPU, with different drivers for
each. They'll run different tests with different xfails. So we should
figure out a way to support igt running for both devices on the one
system.

Cheers,
Daniel
