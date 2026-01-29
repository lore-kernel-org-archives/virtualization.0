Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFBD337BAB
	for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 02:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769652050; cv=none; b=i9ZwBa5jOZe/TwqTNpI61eXv9zpXToK8gxNwm14UM1A7eKEWaMulkOXRUwXM+AWX9810f9cuQTBDdF4US/Pcmm4LoK4n4HuAQGa9fkfzucC2U0JkKuTDTSHxX0GCmA1okjFx9tgD4xJNQWfubFVjlWDdwCEC7AQ2IeM4j+ZD6HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769652050; c=relaxed/simple;
	bh=wvEcaLwL+OyU7IPHb//TyZ/L3nX8HcPEOdA047ABCTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hoNU/ZQdGltNwlnbkELkQNb+ktnCpfDH50b2SDdeDeMG9hdJ/8sZHC9xNtTE8EbvMezlC8RGwzlBwYBoDfTIZAiOYL7hwIq2LUPPE0GP8T7O7sTnxMPM83e+lRyg6Edd3d74qf/3VyeIaU08ZHUDrug7B07PqztC+OaTeVjEEV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f90kfKii; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f90kfKii"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769652037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uw/UiCzpvl877qlxbTo59H00R161y0KVIHeAnf0YUuk=;
	b=f90kfKiiSDSTmOESgAnBXgty95mOvusqsFf+T4nBKQff9bTOtH+R3hJtvf0ZsfET8dMCTk
	0VYdBR1ScJZGXWcc4HM9R0oo3duQpNfDHZqNUTNn07MRCt1pDQFhNtlZYlOZsQlF6lBOR5
	lCKFxCH3uZgp+G71FepcWjtb8czkBEo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-UnW50YJ7P16xdVkkrcWAtw-1; Wed, 28 Jan 2026 21:00:35 -0500
X-MC-Unique: UnW50YJ7P16xdVkkrcWAtw-1
X-Mimecast-MFC-AGG-ID: UnW50YJ7P16xdVkkrcWAtw_1769652034
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34ab459c051so798630a91.0
        for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 18:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769652034; x=1770256834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uw/UiCzpvl877qlxbTo59H00R161y0KVIHeAnf0YUuk=;
        b=IenrkN/IM/uhBCmHf6kNQCHz4ZBgR75UtviEO0Rb1UaAHCIKbZFp1XhEEezo/F4l2h
         69yQgv2b+q79V03cf0Ovvui/UNQbytEzPVnta7xS+yNUhwXvng/qo9mryecnCfJ1VBuY
         NQmzHqcK2QZSWlTL34HsPkdMrTqDuS8XF6fnffwD47zUbXX8tJbiWbgnr8gQy+JWw0j4
         aX/YEziJRKlfub0mAHTRi8etpUK6aNOprKX8HvHdeXVDmRL4OadxRbBP4cHuIAys1rld
         7Q8kF4FyzJdhR/shtQP0dIc5S4t00OAMoqWxcdk2XTepSX3kpEKfx2dOrB2E+9Ziq9kA
         vABg==
X-Forwarded-Encrypted: i=1; AJvYcCXHFwq07bhL83LCHxeR4LkR6upqsYAHw5ErHo9fCTtSXbG9ACs8GdEZhZ1MSQFEY4/sajfaAxz/qrW/8Du4VQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YznCnwwTYJQp9C63lBsrRlMSCsHxIsvv3yy6KfoegY2xpbvFef5
	eXkRhBwS6YqejfHYhwM3YSVpKAymu+OFHJQlEm1tFHBB/Z80gNKSeXfutnWcgYWYOtmyeK0eOl3
	MU/9I4grgsileCnTgPHKaigmMXmDZeCUKN8uhCH/I3KIyZnKXvWg8+ykrk5DieKfA+KLjuuIZhq
	1gh4h9BT0TV2KOYC6clNUH/+7EbUjoJoY2E/YEXy5vc00=
X-Gm-Gg: AZuq6aL6k/+D+JgZjkuUqLh1UVqdkBd5RNIT5/EYz38m6Dm1uM61l3gEuyJvdFV3E4s
	PW2WJ6nwe4rwlOUEfZ/tr8pfe9F2o8CMXH9j6sOOgJPtGy4OR/Mwytgrd+1/zoEz51LuZ/a52sD
	2dyvO0269vSAHYUD1IpEUCeV/IMy8sjqh9sXSk2qG/eyfDIz9pKSYdHrywIRMQMX7J
X-Received: by 2002:a17:90b:2e52:b0:353:c:643b with SMTP id 98e67ed59e1d1-353fed9c60cmr6302443a91.27.1769652034325;
        Wed, 28 Jan 2026 18:00:34 -0800 (PST)
X-Received: by 2002:a17:90b:2e52:b0:353:c:643b with SMTP id
 98e67ed59e1d1-353fed9c60cmr6302409a91.27.1769652033832; Wed, 28 Jan 2026
 18:00:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128124524.875271-1-eperezma@redhat.com> <20260128124524.875271-4-eperezma@redhat.com>
In-Reply-To: <20260128124524.875271-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Jan 2026 10:00:20 +0800
X-Gm-Features: AZwV_Qhsb2c3gAe09w_inqon5xNBOJYjl9nFwbXoRL5KiXLZ0UO9yXkR20Z_o-8
Message-ID: <CACGkMEspErSiv7y5=zHAfJ-G7HVxv5Yr=AA+ttfyxWVVs7Rmmw@mail.gmail.com>
Subject: Re: [PATCH 3/6] vduse: Add API v2 definition
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fPI9ohiAHhV3XonKzhHf3oedBnED4UXcaypgLT3bGjM_1769652034
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Introduce the definition for VDUSE API V2.  This version serves as a
> gateway for feature negotiation.
>
> The kernel uses this version to determine if the userspace device
> supports feature flags. Devices that do not explicitly negotiate API V2
> will be blocked from querying available VDUSE features, ensuring
> backward compatibility.
>
> The next patches implement the new feature incrementally, only enabling
> the VDUSE device to set the V2 API version by the end of the series.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  include/uapi/linux/vduse.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 68b4287f9fac..dea89ed281a7 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -14,6 +14,10 @@
>
>  #define VDUSE_API_VERSION_1    1
>
> +/* Features support */
> +
> +#define VDUSE_API_VERSION_2    2

If we can catch the next release cycle, I would perfer not bumping
VDUSE version twice in the same release.

> +
>  /*
>   * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION=
).
>   * This is used for future extension.
> --
> 2.52.0
>

Thanks

