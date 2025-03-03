Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560871DCB24
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 05:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740981157; cv=none; b=nVBW2E63TQoL4Nj6JQGeUAI1K3iaw8k3JketAyrwhGFBj4SlpSsPJmHCP1uKqkpyEfwqpX7J42UepnVWznTuRj3hNhDdHHFbeXRgb0Dh7c4Je5slFRkG+YL/sK7BZ0hPh9dl0j4GJjRkDr44uEFkPNvltHi+wMU8a9FiBOiImPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740981157; c=relaxed/simple;
	bh=gLGOdr0gUHxApp4Lbm9o/HiERNBdmbBhaZlmMFU99LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTVS749bZvbHTm/Vjj+A3DiTxPwWumGhocgNFUIRQ8hiI39o9otKnVPAksz4Vceh1JIACUoPWiN8VbeZT04ecnZGqGOGGkPQ6V66l/v9mDz0S7FZzEXJzGJy1bSAY2VXBxKpVfvgsgbQWh6OVYczn5vW908qdHeA1qGuopahl3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3K7bFtJ; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3K7bFtJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8A6840DB6
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 05:52:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6nvhWHcFFVXm for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Mar 2025 05:52:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8685840DDA
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8685840DDA
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M3K7bFtJ
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8685840DDA
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 05:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740981151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ftdu/1Kbak1I91E2tCsRVJqvNKhfPSzve6d3GLs9Dlw=;
	b=M3K7bFtJmhyn5qcvvXYj2Y35E883qaqZczNtNtVrIGvqfslho1dFkovGmLCwLePGxb4oks
	lgj2kYWZDlupKxYVwfsGibZfQ4kPYgWOTJWn5j4O13xjyAVEkbk62NzU2x+vvLsTQAeqxL
	kpHcE89ALbfNK8NPH/DaR18UpnmTk4A=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-l7fZIhNjPPmMlPYyl118rQ-1; Mon, 03 Mar 2025 00:52:20 -0500
X-MC-Unique: l7fZIhNjPPmMlPYyl118rQ-1
X-Mimecast-MFC-AGG-ID: l7fZIhNjPPmMlPYyl118rQ_1740981139
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fecf10e559so7074049a91.2
        for <virtualization@lists.linux-foundation.org>; Sun, 02 Mar 2025 21:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740981139; x=1741585939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ftdu/1Kbak1I91E2tCsRVJqvNKhfPSzve6d3GLs9Dlw=;
        b=dOYgBBSs03IdLiuPNSAr64C5ahQ8usA7rjptikMC36K1zsJveqDrM2ouSaNz/8gyQa
         zwU4VPzqgS1QVTioPM45Rbfcs4ek2H8+rUud7qIbsJZ4tyh9MDENOA1aVbf1CgmbgxXb
         q7XEYPwcbEV6T9YNadZ6Hd8AMXbJZnvU94MGT/juGkBlSFwGQMZ1pKKQRYYtnbzZn2/k
         OZLmQIyrErAk4nWz71C1cnyrFLIR6cNnI2mhFMh6Txe1W+kSzXVu9utr8jwYVKb7pqw8
         ItkfgWdR9RxPDInKa3ks762FFZFcesctuhyVIooJ/EEaCsfV6J1mg+/IaEW0TPfc9E0b
         g5hw==
X-Forwarded-Encrypted: i=1; AJvYcCUpl6SNB/sXEsqKh3+Evp0tAa6Nd3IaghqW7OZZGTA467g1BtlWG900dCHnf9+MNbS0M/rB0X6j5LhpnEImjA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwylIBkOkE7hhYCt2U3Gja2twav3cYcvsavHaimlMDG6VVr9mAr
	tZjxCTvOIsinUMTqtZ57W9TZMrMtBLOdIE8sAx3XbCGhCTn2XBZJVytDuKMb5H97TIVveQAX3rZ
	pBOpp5Jp0h7L7ILaP67e4lCsN/OnAvhqc7yHRrkgLQCZ7saVE+jPqZEDQ9t949oi4OvPxXOW9Yl
	yf0y7LFCw57xU7SPTNza/6/OMuQjtkKLUzUULmvV1C+gDKofgffuoZYg==
X-Gm-Gg: ASbGncvE/dwAxF6uUphtOI1smGHKa/EABPXldeAl2dA+371GgUmdLqegQ3mTENH2Bbk
	yVB4aadA5gW+hQFoii1NsPcqsfUnHyMbKFvpHKMhYZY9xeD0N5tPS6y8nXLFkUJ8AMr7sZ0idfg
	==
X-Received: by 2002:a17:90b:554f:b0:2ea:712d:9a82 with SMTP id 98e67ed59e1d1-2febabf8577mr18654169a91.29.1740981139345;
        Sun, 02 Mar 2025 21:52:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhYuZxnpRojNpvlHkuk7NDb2qHnc13DCXse6EtUeiPs2yK5wok7qMMepunLQoYKyM78lF2mK6cW4eqe6uBJnU=
X-Received: by 2002:a17:90b:554f:b0:2ea:712d:9a82 with SMTP id
 98e67ed59e1d1-2febabf8577mr18654149a91.29.1740981138899; Sun, 02 Mar 2025
 21:52:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250302143259.1221569-1-lulu@redhat.com> <20250302143259.1221569-9-lulu@redhat.com>
In-Reply-To: <20250302143259.1221569-9-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 3 Mar 2025 13:52:06 +0800
X-Gm-Features: AQ5f1JoMEQP4W-edssF3skwLm-BwfJKNJ3aGcD-m4x5KSoAF-9cVDu-CpqhKZBQ
Message-ID: <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _gJKZJMZdc2bDyNOWWWx3A3ELSG44KRlvE7unjfqe90_1740981139
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 10:34=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> is disabled, and any attempt to use it will result in failure.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/Kconfig | 15 +++++++++++++++
>  drivers/vhost/vhost.c | 11 +++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index b455d9ab6f3d..e5b9dcbf31b6 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
>           If unsure, say "N".
>
>  endif
> +
> +config VHOST_ENABLE_FORK_OWNER_IOCTL
> +       bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> +       default n
> +       help
> +         This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allo=
ws
> +         userspace applications to modify the thread mode for vhost devi=
ces.
> +
> +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to `=
n`,
> +          meaning the ioctl is disabled and any operation using this ioc=
tl
> +          will fail.
> +          When the configuration is enabled (y), the ioctl becomes
> +          available, allowing users to set the mode if needed.
> +
> +         If unsure, say "N".
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index fb0c7fb43f78..09e5e44dc516 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned =
int ioctl, void __user *argp)
>                 r =3D vhost_dev_set_owner(d);
>                 goto done;
>         }
> +
> +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
>         if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
>                 u8 inherit_owner;
>                 /*inherit_owner can only be modified before owner is set*=
/
> @@ -2313,6 +2315,15 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned=
 int ioctl, void __user *argp)
>                 r =3D 0;
>                 goto done;
>         }
> +
> +#else
> +       if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> +               /* When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is 'n', retu=
rn error */
> +               r =3D -ENOTTY;
> +               goto done;
> +       }
> +#endif
> +
>         /* You must be the owner to do anything else */
>         r =3D vhost_dev_check_owner(d);
>         if (r)
> --
> 2.45.0

Do we need to change the default value of the inhert_owner? For example:

#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
inherit_owner =3D false;
#else
inherit_onwer =3D true;
#endif

?

Other patches look good to me.

Thanks

>

