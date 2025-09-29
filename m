Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D80423C506
	for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 06:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759125966; cv=none; b=KSgnBvR0x1W8rLKuvDDRo9wXTq7tC7a2HGI1JE7nCqjJtmqfs9lvga7WVMNFRef/wgQihGLPLy9gxO3l0JhInRiUJ/BvFZRs1Ugle2cf5DDKj6q4FhpKKVt7krfNMvJR7UgryxQzRZtQSA3NEDzkP6AiHxNtDrrY0U+zmz8VDOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759125966; c=relaxed/simple;
	bh=4ZVJUKJcStOkfQvNu132ByH2QSL2oYRTRtM5t2938z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kuj8cdbd4SFj+rf2K0VP7ShJMKYqICOITTppOenzZvSFgsUIoqfQyE6XiNk4xtUd2SEg5+X68wSL4iKGURlGGEtOPoCXDQmIjMG7ZtHkMxqYTKrwdVLWgm555CD6lKQ4fmAKr1jMCZzkvwugnwKDwZmWT7ZEXit4VlzmOq48yWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HAVAT8up; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAVAT8up"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759125964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1yGIQOsQZ3m8F6SURAT4ync4Dvco6agAIcb00xK3BQ=;
	b=HAVAT8uptfh8AhqgK/ZaLXvTRjzGLd22dKFp98FDRLm5ozeIAYCYja9BRjHz4senV4S5er
	PClWFjlLYvbANd7d6aenAivwIOP2Lq3ntA/OyaPuJUi/OeAYOSahEyX87hXM53pSOckSXw
	KTXxsBSkymJlzQiriQN7K6wh43iYa8E=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-FUNVrUCgOzGPUCfPIJwDRg-1; Mon, 29 Sep 2025 02:05:58 -0400
X-MC-Unique: FUNVrUCgOzGPUCfPIJwDRg-1
X-Mimecast-MFC-AGG-ID: FUNVrUCgOzGPUCfPIJwDRg_1759125958
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-738a7fc9901so58248727b3.0
        for <virtualization@lists.linux.dev>; Sun, 28 Sep 2025 23:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759125958; x=1759730758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1yGIQOsQZ3m8F6SURAT4ync4Dvco6agAIcb00xK3BQ=;
        b=u4TpL/Qdw9Mkd+6pBENGrP/8Hz4WTke+DY+btjcrV6FgO8jH0yR+lK8rVFJA7wrDSn
         ELIdQ4nSeKmhYxwqi0A7FekqvEhDOCCbK+R9Sa9QRp+uxigIIGif+zAJ0Py0ujd/oGND
         /SwQ2CDQOAtBtrm8Sq6R2i32fwFDp6UCxDfEEhfItvfaeQkDc0Na553sqA+P96GXJ3YM
         sQDLGJr5AMvUmsT5ySeAfmONVlP64KX73vAx3vOLx1Zm9s4sy1N64Ga3vt1MK2HugRpX
         eZ2tTThJk3pyBiZg7MDEOMbRP2/8Wbthj/6t3czOdfLL77HdzY/J9BcK7t2WxVYYjwoW
         vqJw==
X-Forwarded-Encrypted: i=1; AJvYcCXw0+/hLcXasP+idVxFZYcZ/TD8+3nTLO0/lVGGaanOrAtS7qK7fWMk+lU9YRKQW9WZt5a9tSWhQjpnwCL1yg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwC9a3/xpHpZu9xGgW0fFzPhg+FqAIF+zuK/sOfrk+6gFD4FUi8
	Ls4h8UpMO3e7HjBC+o+qYCsjS1x+SvB9+zYc7vJFwCUsSMJuwm/cfN8xVHfrarlvLzJceKLWZ8n
	tw8AKr7hAjCmg10710K0NuHDHPF88ioxKoz51XNv9bKzGnTMCcwGKwK+AU1GUJ/V5jn0Kt6Gmq+
	zvZ4H/GyeipL0wgDfQDjQ7ZCChGhxAOatdKiPpk+SeV0c=
X-Gm-Gg: ASbGncv8f9x3yllRoVP7OPstZ8tEuuEeYnCUxddaVPZ9JP3L4WbHQ6Nu2aytmTCCHl1
	6zkuj+/GhBsETRgmf88mfptgwBqAlaRAeLUWCC4661fQgTPEZmzLD6Cb5xTU2EE36BxrAYtUgd2
	2lbeld9uadSM5pwX5GO9pAZsxUPq6i54q8/Y/F71Kh+7vOs96qr8CxMVt5sO+Dmpbxzx3eVmGhn
	IYgughT
X-Received: by 2002:a05:690e:4289:10b0:636:ca97:d6d2 with SMTP id 956f58d0204a3-636ca97d773mr16173572d50.20.1759125957873;
        Sun, 28 Sep 2025 23:05:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+BjaVuGyoNFx3yUGngOCBRLm43JB3sIAw6ThgC682NtQbB9nf4C73RlWOHPZlMIy2Osnpg0Z6d8vSJeF229Y=
X-Received: by 2002:a05:690e:4289:10b0:636:ca97:d6d2 with SMTP id
 956f58d0204a3-636ca97d773mr16173546d50.20.1759125957498; Sun, 28 Sep 2025
 23:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <aNfXvrK5EWIL3avR@stanley.mountain>
In-Reply-To: <aNfXvrK5EWIL3avR@stanley.mountain>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 08:05:20 +0200
X-Gm-Features: AS18NWBs1i9BHagRuYUX084a7zMJ_6ylNkBNHWiX3YPpcoyysxZQU5lwQENWqTE
Message-ID: <CAJaqyWfBoY0_X=xRnGBecDFUJqSJEitgVKzopumA4fsZVfC11g@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: Set s.num in GET_VRING_GROUP
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4ZatrX7xT9yHxy58wIlgTHNAi42dHXVnioEJvaCSgw4_1759125958
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 2:25=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The group is supposed to be copied to the user, but it wasn't assigned
> until after the copy_to_user().  Move the "s.num =3D group;" earlier.
>
> Fixes: ffc3634b6696 ("vduse: add vq group support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This goes through the kvm tree I think.
>
>  drivers/vhost/vdpa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 6305382eacbb..25ab4d06e559 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -667,9 +667,9 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa =
*v, unsigned int cmd,
>                 group =3D ops->get_vq_group(vdpa, idx);
>                 if (group >=3D vdpa->ngroups || group > U32_MAX || group =
< 0)
>                         return -EIO;
> -               else if (copy_to_user(argp, &s, sizeof(s)))
> -                       return -EFAULT;
>                 s.num =3D group;
> +               if (copy_to_user(argp, &s, sizeof(s)))
> +                       return -EFAULT;
>                 return 0;
>         }
>         case VHOST_VDPA_GET_VRING_DESC_GROUP:


Thank you very much for the report Dan! that should be fixed in v5.

