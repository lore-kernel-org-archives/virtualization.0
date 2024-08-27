Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1D4C152
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724726223; cv=none; b=l+ZSDi4OPVmpr84XYjEfap1mOOlnecAOqIFt4Nm3eoXyHfwmYmOcRdAZv+G5QhluOQwrvk+BWFBJCX089bWBzAx2ZBASy7J+sKIJwG3LH/z7N0dcL+S8LhI1YjvuQxm94uaV/wQmyycKrG5gADqQyEaGZ3xaV8xK1Tl2gyAT060=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724726223; c=relaxed/simple;
	bh=2fJ9UoHqXi1PF6ZiD5S5EF2R045y1Znp0QqjZS2yLTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWQG/6TEiKFPZzeP00BtMKfHGT6CIf6OSbIe5YxR9GORErBMskzvDZs4c4wxxo82oTz9IOWMiaYbZiiN+UOIFMEXubMoNrFb2WsjSWShhCCHyp7KNlGLQ1oIrNbdlyPFif2YfewCR4vhMURRw88VxLkbi5h0ivL1ePDoeMDXZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dcNH+Smu; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcNH+Smu"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7A27640261
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:37:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hdtp_Ep3Ft0W for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Aug 2024 02:37:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 55C2940151
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55C2940151
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dcNH+Smu
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 55C2940151
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724726220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQ5V1VZ6ZfM6F0owIcK94idaQ1AVYwDUarCrXj1TZuE=;
	b=dcNH+SmuY478mZUHHHpxpOR5s3oMUT3xdeyzfRPgiO849/MyqBq00aYVoukNILBzxKuQf3
	eC2Rq8d7kHU7u5ZWBKvV8/zs/OzdXDXNfQwUQbODyFQIDvXZdxv6EWteKtf4TlWmfd27Sq
	7M42jrgt1fa2rm4ZoZu1w9AiFwN1ktA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-UnMWMtqqN-KFc_Ma7KhqSA-1; Mon, 26 Aug 2024 22:36:58 -0400
X-MC-Unique: UnMWMtqqN-KFc_Ma7KhqSA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d3c4d321f4so5062535a91.2
        for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 19:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724726217; x=1725331017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQ5V1VZ6ZfM6F0owIcK94idaQ1AVYwDUarCrXj1TZuE=;
        b=k4uPAJmbgf4peGW7edC2b4pEMo3Pv+ZwpqWymfdhBIXd0nVyLhn2MomM9v34PwbBYS
         ui9vfxdppwtszZ5v4zo+C5b8I7KpnlOd4aFh1a6SK23alsIi23w8Cw6dU9Y3he5KYsja
         Xa/9D62ptVpZNxEnbPB9cosDIOEv4idb8Mw/KQy6c6QTdgTATyTOSQ3/1Bfi64DFTBn3
         ruOY5UFbxSdWQArVK8SczHD/DYzRBiCVq2xxHRifycDk4ZoQoefHktgEUCLHZoNGMV3b
         VoqBZdANGRjVWP3VO9B3pp6EMxPs1DrXShayqWPiRPUrAkBa4ORLIff8Yn1+8eYkeWYi
         JG2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeP1qX0HlWKyBm5ZgCDaR8B7f57qKO3/r+LIk/iar//MJASNih9byViE+M1WDKXtmSZ+jaJkqwM2mO6dNKAw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyObkeSMofMtz7oD6It0iBEA2b4vxIRhXQhGwIPtont9/RzjOuf
	JsFZBjl+Z4YEE6XnrY/y7OYcZ3NMDqfkhOBY+lcf93xAEkqg3TjbtnWFgdP3V8dnAukQptLbNS5
	iloF+Iy0sjDyFQWpLgo7Ydc7aX/Uab6h13gqFX3dHq0Dd91TdnoJD0MjLlPD2I25Z+rXcYdxBlk
	DVrIPsfssAT81FM6I/e6/CoYo8ZOwbN8xFvkr3oiPKm08TTFOPe5MwBw==
X-Received: by 2002:a17:90b:4c4c:b0:2d3:cd22:e66f with SMTP id 98e67ed59e1d1-2d646b8f9b9mr10321994a91.9.1724726217126;
        Mon, 26 Aug 2024 19:36:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWF7r+n5FR6V+WbdMzW70pPdN1pAK9i2g0lgxVgO/2wowduQ/RqmJRGnIlgT1oaJTBJGLKg0fhI0z84OUtQzE=
X-Received: by 2002:a17:90b:4c4c:b0:2d3:cd22:e66f with SMTP id
 98e67ed59e1d1-2d646b8f9b9mr10321979a91.9.1724726216553; Mon, 26 Aug 2024
 19:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com> <20240819092851.441670-8-lulu@redhat.com>
In-Reply-To: <20240819092851.441670-8-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Aug 2024 10:36:43 +0800
Message-ID: <CACGkMEt2O2r7BDLYq0Yus7KP17N_DMUP9OoRMbvqC5V0N6rs7w@mail.gmail.com>
Subject: Re: [RFC 7/7] vhost: Add new UAPI to support changing Kthread mode
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 5:29=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add a new UAPI to support setting the vhost device to
> use kthread mode. The user space application needs to use
> VHOST_SET_USE_KTHREAD to set the mode. This setting must
> be set before VHOST_SET_OWNER is set.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c      | 11 ++++++++++-
>  include/uapi/linux/vhost.h |  2 ++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 0a7b2999100f..d6b71bddc272 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2340,14 +2340,23 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *argp)
>  {
>         struct eventfd_ctx *ctx;
>         u64 p;
> -       long r;
> +       long r =3D 0;
>         int i, fd;
> +       bool kthread;
>
>         /* If you are not the owner, you can become one */
>         if (ioctl =3D=3D VHOST_SET_OWNER) {
>                 r =3D vhost_dev_set_owner(d);
>                 goto done;
>         }
> +       if (ioctl =3D=3D VHOST_SET_USE_KTHREAD) {

Btw, should we enforce this to be called when there's no owner?

> +               if (copy_from_user(&kthread, argp, sizeof(kthread))) {
> +                       r =3D -EFAULT;
> +                       goto done;
> +               }
> +               use_kthread =3D kthread;
> +               goto done;
> +       }
>
>         /* You must be the owner to do anything else */
>         r =3D vhost_dev_check_owner(d);
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b95dd84eef2d..386fe735da63 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,6 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE      _IOWR(VHOST_VIRTIO, 0x82,       \
>                                               struct vhost_vring_state)
> +
> +#define VHOST_SET_USE_KTHREAD _IOW(VHOST_VIRTIO, 0x83, bool)
>  #endif
> --
> 2.45.0
>

Thanks

