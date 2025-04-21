Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0436C257436
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 03:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745207157; cv=none; b=YVNkGpqu/Ql4pVMJ5+jkwnLeQd2QaTDkljgJJc6fzqxAPFX30PThWHpXVRjl2OlOj3HJ25x6WzQoAcHhsyR53aVXTLJ5MNJ6SDawkJDzKIlNgy3M5E+PAwMrmzIGhTTLksB9jQ07lzh16yw1XZlcrWfUzRzgPreGnAewmFUOOtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745207157; c=relaxed/simple;
	bh=KNP4l2yPMw2FLp/XhZlTQQJKvOxgUeTNWGn0vwmpkpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWH5P72HpTvpWHjkH7MWoDf7Ky78g5sz8A2k6Uw3JIvTIeFKgCPLJa3+K61EXewjNG4T17+pFrZ0SuI3XORYe8d2cY9KBaqcbK7ttKtCguEEbK6y+pa3SrZFex54j/HdYd45dLztq6uHRSIKpvWwvKzdu5tWAC6KhM86hlt/QtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Akg6yr++; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Akg6yr++"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8453581247
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 03:45:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v8BVeg_jkNK0 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Apr 2025 03:45:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BC28E8113D
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC28E8113D
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Akg6yr++
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BC28E8113D
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 03:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745207153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GCTn28hDkTI90JLQ1WUbwuCZY09MgQ9MgcwPXgLFgGw=;
	b=Akg6yr++AmmI0Mj7lxp1XiLnBXCwSRx+DE3JbrZoRRnq7BaMkQV9wP9xxi4LOQCb6zvhxf
	RQt2TEy8FhNXeTzwN3ZWGajX5M4NWv4C4G5+o/wlutWO8jtZ71AyEKNeeT2AqS1uTiI9xG
	hnYUOa2Dl+LZURCV8NKMuUYZ00esT6s=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-coBewRgmNWmn9DGOAbToKA-1; Sun, 20 Apr 2025 23:45:49 -0400
X-MC-Unique: coBewRgmNWmn9DGOAbToKA-1
X-Mimecast-MFC-AGG-ID: coBewRgmNWmn9DGOAbToKA_1745207149
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5290c7ab367so713959e0c.0
        for <virtualization@lists.linux-foundation.org>; Sun, 20 Apr 2025 20:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745207149; x=1745811949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCTn28hDkTI90JLQ1WUbwuCZY09MgQ9MgcwPXgLFgGw=;
        b=s7y+3JOqYrCkQna9xNp8ZlP8/n4kP6E7rQjMASSgfBQvs+MihaKh91rQuLaMBrXiXT
         T6Cj1LTxvyPKkzuHehZrGpqgn+mKHDVXr9kvqVdXrnxD/gUJDC49CC7Vy5WDMR9PfIkR
         GfoTTGWEicdHJkjnVtuJSxtcmsJ+1yi5c2hbzfND03QkOUXe/30meh2FxbL0R34svpCv
         zvoCDUrKiue1KERq5skqF3O0Udjm3A++TeP9hqxx9dt3viI9CaMFkje/+jhVaqEuNbmB
         ozodlFIP5yeCwuq8cAirTOQY6gNzYPcz5IOKmsJaKIKlDvfoq+IVTeiy+vgCGc1rByB3
         L0fA==
X-Forwarded-Encrypted: i=1; AJvYcCUUXW1LNlvz+CsPifWd3iMOnRuCTpQIClsyV2lWcg4iFbqNEZeSZuX1FWBrfzAmIZIMpT8b59e3nMeUbYz78A==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwbYNhdrhZhTMyB2zPT4eGFKWqcm2qQkLBH933O0F4bTfYWIGmx
	B8eBNK2YL+Bv5bdOT6oRIUE/2eQSLKOIk5zBdOIIzBSJuqLHHGGkHSMcgucACEcks3cptKCgeCH
	0a2UZx+pwug3/5f8/YL+MOZRuzM3Ttt4L//osCO2LIpomnj2LuY0p6dHGv0/a6SH8d4CfioERI5
	4L478jrEh19Unm0U0jzxtAmrsy7skNTXRtDTIzNqSSQ4sjelFaLmghWA==
X-Gm-Gg: ASbGncvdTh4EwF+ktKoi+NrFn5xhdH/Ltd5CAGHXBdo9Jrt2acbS98cz+kq+wnsrpNr
	c75cLLgk0Zj1YiS1YoxDVnwB90u4gYWYd0kY9d8gof7LEg51fsyafOEjeAhrKNnK0SFMrew==
X-Received: by 2002:a67:f089:0:b0:4bb:9b46:3f87 with SMTP id ada2fe7eead31-4cb8011d7e6mr5033336137.6.1745207149222;
        Sun, 20 Apr 2025 20:45:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1i5MplA0k7CxdohZHJOAN8NXQrZKkjU3zR0UFMuopnzkvSvPRh2gSe1jL70oe+NUnRQzp/TgYqM732XBN6FQ=
X-Received: by 2002:a67:f089:0:b0:4bb:9b46:3f87 with SMTP id
 ada2fe7eead31-4cb8011d7e6mr5033333137.6.1745207148893; Sun, 20 Apr 2025
 20:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250421024457.112163-1-lulu@redhat.com> <20250421024457.112163-5-lulu@redhat.com>
In-Reply-To: <20250421024457.112163-5-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Apr 2025 11:45:32 +0800
X-Gm-Features: ATxdqUFgCCkJJ0JXdJQwN88OxMbo6yfhaiyGCN8WzeAS9Lrj99kC3ES_wTxfQwY
Message-ID: <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wPBe9rWbSeMnXVfvmWm_03lC_KtY6ZAYzOaWJgOxMCw_1745207149
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> is disabled, and any attempt to use it will result in failure.

I think we need to describe why the default value was chosen to be false.

What's more, should we document the implications here?

inherit_owner was set to false: this means "legacy" userspace may
still be broken unless it can do VHOST_FORK_FROM_OWNER which is
impractical. Does this defeat the purpose of this series actually?

>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/Kconfig | 15 +++++++++++++++
>  drivers/vhost/vhost.c |  3 +++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index 020d4fbb947c..bc8fadb06f98 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -96,3 +96,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
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
> index fb0c7fb43f78..568e43cb54a9 100644
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
> @@ -2313,6 +2315,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned =
int ioctl, void __user *argp)
>                 r =3D 0;
>                 goto done;
>         }
> +#endif
>         /* You must be the owner to do anything else */
>         r =3D vhost_dev_check_owner(d);
>         if (r)
> --
> 2.45.0
>

Thanks

