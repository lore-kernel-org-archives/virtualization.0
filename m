Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E23C433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 21:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1331A60B85;
	Tue,  8 Mar 2022 21:12:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H7Q73zBFCUMJ; Tue,  8 Mar 2022 21:12:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EB16C60E06;
	Tue,  8 Mar 2022 21:12:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1B85C001D;
	Tue,  8 Mar 2022 21:12:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 205D9C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 21:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17029417A4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 21:12:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3-sJXvNTKEwd
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 21:12:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3FF5441767
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 21:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646773969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o7rskMpOUtPRm21R1L+M5BTZ0/kXolxQOCHs+VUDkYg=;
 b=WNTwPqUgX34VDEjA1Jj2YTQdufWO13Y+EuxB0Xid/kQTDXxkqinLMLoQxT1QzJPG9Cbw/J
 BmRzBqnvVf/n0fCkDXbXjaDLF5g4aMZT+jeYaKVpWtlfSQWhzs46OrvKtFvyrjebd5s6hK
 FTBUA6ND5HD7gm4/hCSMew6DmnOUE80=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-yxhGKyeaPjmUtC171_sgmA-1; Tue, 08 Mar 2022 16:12:48 -0500
X-MC-Unique: yxhGKyeaPjmUtC171_sgmA-1
Received: by mail-wm1-f69.google.com with SMTP id
 f189-20020a1c38c6000000b0037d1bee4847so1668865wma.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 13:12:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=o7rskMpOUtPRm21R1L+M5BTZ0/kXolxQOCHs+VUDkYg=;
 b=LhBK1q4aIrNfTJAqvOzP6Hlymf66m5uLfHFCib5p27JF0HFoSN411+mPcrXugHUElO
 Esu/FE1Hkd7MAmLCAgpmNIil8oHkmcZh7Ljyh1h9SwKF4lL/DsXpEF7waC5TXYk44vjc
 0jJFVMlNHPN5BMnxgs9kifh5DjLU145dkrZNV8u+OZrpXQurKjIom1NI0L3WBIYtoJii
 pdJT4C54WoXB7GIyaOkAaZHCiijycO+qlSIzSeLxTXCdH/h5QTmOIZeSUbC1FsrrYAuV
 RfYanNq2LnaccotPPjFKqArqKV9jOWke96UtOnqwwk79/9uUwvE/jIevmlzpCbIQrbbH
 sU4w==
X-Gm-Message-State: AOAM532/xkYlG3+pcyFbpYlBjoLmmxU2XwMGRizVoX68zpztUegke1fH
 OkT3xnnnblzdhb/RrAR4xsJOBsCAGXKllwe32wLR3sMJostbfL+gb5wd5jXXjdBNLxqhz8KnK70
 DY0j6BhAU+ODEDx0IBKSutQxt3ImupZBh0XxpoLjofg==
X-Received: by 2002:a05:600c:3552:b0:389:95b2:5f4a with SMTP id
 i18-20020a05600c355200b0038995b25f4amr947467wmq.24.1646773966833; 
 Tue, 08 Mar 2022 13:12:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyi92ZKbMYeek4+BuLtBGmKMZo/pMCdGn7HyfqvI8yntVF5I5HjVRe+w8/RlZKLoqHhy9/qog==
X-Received: by 2002:a05:600c:3552:b0:389:95b2:5f4a with SMTP id
 i18-20020a05600c355200b0038995b25f4amr947449wmq.24.1646773966581; 
 Tue, 08 Mar 2022 13:12:46 -0800 (PST)
Received: from redhat.com ([2.55.46.250]) by smtp.gmail.com with ESMTPSA id
 a14-20020a05600c348e00b00389ab74c033sm18008wmq.4.2022.03.08.13.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 13:12:45 -0800 (PST)
Date: Tue, 8 Mar 2022 16:12:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH -next] crypto: virtio - Select new dependencies
Message-ID: <20220308161153-mutt-send-email-mst@kernel.org>
References: <20220308205309.2192502-1-nathan@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220308205309.2192502-1-nathan@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lei he <helei.sig11@bytedance.com>, patches@lists.linux.dev,
 zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Mar 08, 2022 at 01:53:09PM -0700, Nathan Chancellor wrote:
> With ARCH=riscv defconfig, there are errors at link time:
> 
>   virtio_crypto_akcipher_algs.c:(.text+0x3ea): undefined reference to `mpi_free'
>   virtio_crypto_akcipher_algs.c:(.text+0x48a): undefined reference to `rsa_parse_priv_key'
>   virtio_crypto_akcipher_algs.c:(.text+0x4bc): undefined reference to `rsa_parse_pub_key'
>   virtio_crypto_akcipher_algs.c:(.text+0x4d0): undefined reference to `mpi_read_raw_data'
>   virtio_crypto_akcipher_algs.c:(.text+0x960): undefined reference to `crypto_register_akcipher'
>   virtio_crypto_akcipher_algs.c:(.text+0xa3a): undefined reference to `crypto_unregister_akcipher'
> 
> The virtio crypto driver started making use of certain libraries and
> algorithms without selecting them. Do so to fix these errors.
> 
> Fixes: 8a75f36b5d7a ("virtio-crypto: implement RSA algorithm")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks! I'll squash this into the original commit so we don't
have a broken commit during bisect.
zhenwei pi, ack pls?

> ---
>  drivers/crypto/virtio/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/crypto/virtio/Kconfig b/drivers/crypto/virtio/Kconfig
> index b894e3a8be4f..5f8915f4a9ff 100644
> --- a/drivers/crypto/virtio/Kconfig
> +++ b/drivers/crypto/virtio/Kconfig
> @@ -3,8 +3,11 @@ config CRYPTO_DEV_VIRTIO
>  	tristate "VirtIO crypto driver"
>  	depends on VIRTIO
>  	select CRYPTO_AEAD
> +	select CRYPTO_AKCIPHER2
>  	select CRYPTO_SKCIPHER
>  	select CRYPTO_ENGINE
> +	select CRYPTO_RSA
> +	select MPILIB
>  	help
>  	  This driver provides support for virtio crypto device. If you
>  	  choose 'M' here, this module will be called virtio_crypto.
> 
> base-commit: c5f633abfd09491ae7ecbc7fcfca08332ad00a8b
> -- 
> 2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
