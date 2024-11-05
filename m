Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C3E1CEEAA
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799602; cv=none; b=I5Cil3Bwhnk3jE4x7pqLcYLZQ5PVzkr2ttee7sZSblz6qQJa4B5Tq53oCbjVSVNGXt0mNFy3FgPJmE0xpflqDiLHemiD5fdXUw+izgtMV1GJG1P4TFSSggBiv04NtfKNS3mNgC2X4eroXA5c+cYdPywrxcEiBwUnfv2VpLQKvgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799602; c=relaxed/simple;
	bh=zbV55dwHjJ2kbTTg3MViuRzCwoRMxpq1N/C5N+zK6zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9iYdCncYZleF+a950MHTAaVduPCnYkKhSzoumju9IjLu2xKX4tW0M1psIzRl7JqAFEq49bf2/1gEU0xODxJIEKeaOADiz/W+68XUNQOt2cCneskNrAs+aVe/SsELz26dXETDT6nTX/RREkZupL+HWe10hT3EJCk+cpPYUHsYBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fh7amOpD; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fh7amOpD"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3489608B2
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 09:40:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VPtE_3Is8dd2 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Nov 2024 09:40:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E0942608B0
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E0942608B0
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fh7amOpD
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E0942608B0
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 09:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730799598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hRwsPPiBOKl8pP2TdmsQrIwR4zMRwzINJIydDBGwl0M=;
	b=Fh7amOpDm4hiVNHB0UFY7bJrvHiztk93bKXPOZKFVVeijMAO1zv6TY62AaeKKsGg4i+oC/
	VNizlOdiT6ktwMB32sU2S45m7qaDXpiukosRaIIlY/EDea63F/ADM8rnHVpdMwPqZ34CO1
	WF7hJl2/IAsh2noKtgJsyzYbu3Sm4PY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-Eh2XZ7zvO2KJ_xZRm7aUCg-1; Tue, 05 Nov 2024 04:39:57 -0500
X-MC-Unique: Eh2XZ7zvO2KJ_xZRm7aUCg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e2bac0c38aso6802106a91.2
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Nov 2024 01:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730799596; x=1731404396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRwsPPiBOKl8pP2TdmsQrIwR4zMRwzINJIydDBGwl0M=;
        b=Rn8uo41MMhPnDbeJYnKzHswbdcGKbY/YfPwRil+T8Lkq3eC5iKVSNn2a2Q/426sTUa
         OGT0t7aeRc7pTSusyWv/JV9AVAw8rNvFOmOMWiixzq68emLWhg3cotSReKZr/2GfX4o4
         bZsHPnYM+cGzs3gXyx2B6moA6E4a2OLId5pBPsYmBaenHp7GxDgMTaL9Zfl6JiaO+PJ8
         o4bNETBQ0cwBNUEZLkwGGPADUxUIs6/sJ8drIzLyE/UR++gYAeGIBg6ZEUwboTyhX/if
         T/2M7gtreuKh1Rl8RC8QUrlind1HGT5/0kePPEBaQ6KrU0tvrwMgSMr81fsg/a2d9dGp
         rjTg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ/LMHBBiw7MzTF0omhPO0drbjdRFTOODlEjF+Arv4mgUu/AYQb059k1CCpWj2MyQKoi7UuGktwS0kMZBXxw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxCdVpv2ARuaxxdbePI/OCs1tbKoqxpjN5Ln9cmVybUyzjpBERd
	IHHpU5JqiX3jMkeZTv/lPBUfvJ0JyVLVAk1kAZ4AYQZocmBYJqiy+7ES2XOHUMDO87JliTmJKwA
	Qn1QzLFCQRJq6rjhZtkUegTjwjFmswISOyLyBXE39Iyrefu5Fxie8q/vnlnEIHAOR1qhEw/cvTy
	sr4HFyRPdZRb2Kc5bdnttQZS00UqQQYCrF0BL/kuywdYLFxa9fuQp8iA==
X-Received: by 2002:a17:90b:2703:b0:2e2:bad3:e393 with SMTP id 98e67ed59e1d1-2e93c1239b8mr24582868a91.3.1730799596552;
        Tue, 05 Nov 2024 01:39:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkWs7EprrlFH5lqTZLM7dQHu2gPsz4loSVUjvX2t1vhkBm4E6upLHhA0nfNQI6ZN+O5cxUBaSpekre3l5wCV0=
X-Received: by 2002:a17:90b:2703:b0:2e2:bad3:e393 with SMTP id
 98e67ed59e1d1-2e93c1239b8mr24582850a91.3.1730799596044; Tue, 05 Nov 2024
 01:39:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241105072642.898710-1-lulu@redhat.com> <20241105072642.898710-8-lulu@redhat.com>
In-Reply-To: <20241105072642.898710-8-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 17:39:44 +0800
Message-ID: <CACGkMEuEyXC7pOfwUTKSSrc-vrGW-v7SucV0qAHDE5Lo-b7zYA@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] vhost: Add new UAPI to support change to task mode
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:28=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add a new UAPI to enable setting the vhost device to task mode.
> The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> to configure the mode if necessary.
> This setting must be applied before VHOST_SET_OWNER, as the worker
> will be created in the VHOST_SET_OWNER function
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c      | 15 ++++++++++++++-
>  include/uapi/linux/vhost.h |  2 ++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index c17dc01febcc..70c793b63905 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2274,8 +2274,9 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned =
int ioctl, void __user *argp)
>  {
>         struct eventfd_ctx *ctx;
>         u64 p;
> -       long r;
> +       long r =3D 0;
>         int i, fd;
> +       bool inherit_owner;
>
>         /* If you are not the owner, you can become one */
>         if (ioctl =3D=3D VHOST_SET_OWNER) {
> @@ -2332,6 +2333,18 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned=
 int ioctl, void __user *argp)
>                 if (ctx)
>                         eventfd_ctx_put(ctx);
>                 break;
> +       case VHOST_SET_INHERIT_FROM_OWNER:
> +               /*inherit_owner can only be modified before owner is set*=
/
> +               if (vhost_dev_has_owner(d))
> +                       break;
> +
> +               if (copy_from_user(&inherit_owner, argp,
> +                                  sizeof(inherit_owner))) {
> +                       r =3D -EFAULT;
> +                       break;
> +               }
> +               d->inherit_owner =3D inherit_owner;
> +               break;

Is there any case that we need to switch from owner back to kthread?
If not I would choose a more simplified API that is just
VHOST_INHERIT_OWNER.

>         default:
>                 r =3D -ENOIOCTLCMD;
>                 break;
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b95dd84eef2d..1e192038633d 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,6 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE      _IOWR(VHOST_VIRTIO, 0x82,       \
>                                               struct vhost_vring_state)
> +
> +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, bool)
>  #endif
> --
> 2.45.0

Thanks

>

