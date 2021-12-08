Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4A7C433F5
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 19:56:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 40EFF4021C;
	Wed,  8 Dec 2021 19:56:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e23lIqB_RYpl; Wed,  8 Dec 2021 19:56:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 89B4B400FC;
	Wed,  8 Dec 2021 19:56:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EEE2C002F;
	Wed,  8 Dec 2021 19:56:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A81EC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 19:56:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 25A1E837AC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 19:56:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VKQa1F-S9Goc
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 19:56:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D0A918343F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 19:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638993382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qG4PVtbNoLN8AVmrX8I4VEzhm2Rfsmwm+zKfClLGO8w=;
 b=Zl6r3PyKlMbSTFFAwDw+NatHJwsqT/tS1MVQ5TFpeIeiHmjOdA/XQBXncsNfwb2Coc03Nl
 BGVXyFeTj+HzaAw5sbFKHzQB9il7iAivRKq78fj9IqXQHRWMqgiAAwtalLzdMUNgZXNAHZ
 GHvTMbCw6nEYBjxGy3g534hiQCi5NzY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-d1KWEc4OPbm1h6sE5SMkNQ-1; Wed, 08 Dec 2021 14:56:21 -0500
X-MC-Unique: d1KWEc4OPbm1h6sE5SMkNQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 201-20020a1c04d2000000b003335bf8075fso1861653wme.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Dec 2021 11:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qG4PVtbNoLN8AVmrX8I4VEzhm2Rfsmwm+zKfClLGO8w=;
 b=IpPncz0Wp66FfmXMaTwuCyIHWbigbhnoW9UVSZVsC09YCzzAUEtzGw97lhfxlRm/Hi
 JhBbryVO11BfTr7iHUoDuUhMlai1/jDZc+dchR27QN9uQMuDWIK40bZ+UP6v5sCy4oek
 fhPNBwBjBou1LbuZ3/lxl0hpWRYSix1YC7EAInfsv23T7rrmDwZmnP9Te0N2sLgvIGgF
 jfczfvDh8H65Oir/eCSMg7auUz7UCy3b54H/bBBdVhpny+c/3ePsWKWPN4DfH9NtkHFe
 Z54kRidh8DFeRagv/XhVeFblPCu1nzfJESGxR4D4aREt7Aud5YENcqGhgoGkUCcebzMh
 ED4A==
X-Gm-Message-State: AOAM532zR6jG4G3UvTlvLFjcTYFDbuqjv/8jt3bjlHG2qsI3j4AjG/MZ
 owhcqmoR9c7O2fXraHqBBSHni0+PkmEXDWLCQAR2fxGnY7wHKvqSpr1LagGLGKLtQqh52NMuc8V
 HGCpzKa7wIeGEwMmIUwN9pNPgl+jV37jK103Nj91kgg==
X-Received: by 2002:a5d:6dc3:: with SMTP id d3mr891098wrz.159.1638993380128;
 Wed, 08 Dec 2021 11:56:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGLz8QJuT+yslhyH4pgav06KTCxu5937pbGMbW3hVwzuMPBhu7Mm6xS6Af8u9XCeDE2JmTJw==
X-Received: by 2002:a5d:6dc3:: with SMTP id d3mr891083wrz.159.1638993379958;
 Wed, 08 Dec 2021 11:56:19 -0800 (PST)
Received: from redhat.com ([2.55.18.120])
 by smtp.gmail.com with ESMTPSA id y15sm4921076wry.72.2021.12.08.11.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Dec 2021 11:56:18 -0800 (PST)
Date: Wed, 8 Dec 2021 14:56:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] eni_vdpa: alibaba: select VIRTIO_PCI_LIB
Message-ID: <20211208144916-mutt-send-email-mst@kernel.org>
References: <20211203185522.692489-1-arnd@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211203185522.692489-1-arnd@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Eli Cohen <elic@nvidia.com>
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

On Fri, Dec 03, 2021 at 07:55:14PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When VIRTIO_PCI_LIB is not built-in but the alibaba driver is, the
> kernel runs into a link error:
> 
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_features':
> eni_vdpa.c:(.text+0x23f): undefined reference to `vp_legacy_set_features'
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_state':
> eni_vdpa.c:(.text+0x2fe): undefined reference to `vp_legacy_get_queue_enable'
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_address':
> eni_vdpa.c:(.text+0x376): undefined reference to `vp_legacy_set_queue_address'
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_ready':
> eni_vdpa.c:(.text+0x3b4): undefined reference to `vp_legacy_set_queue_address'
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_free_irq':
> eni_vdpa.c:(.text+0x460): undefined reference to `vp_legacy_queue_vector'
> x86_64-linux-ld: eni_vdpa.c:(.text+0x4b7): undefined reference to `vp_legacy_config_vector'
> x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_reset':
> 
> Selecting VIRTIO_PCI_LIB_LEGACY is not sufficient here since that is
> only part of the VIRTIO_PCI_LIB support.
> 
> Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Confused. These are all part of
drivers/virtio/virtio_pci_legacy_dev.c

and
obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o

what gives?


> ---
>  drivers/vdpa/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 50f45d037611..04466603021f 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -80,6 +80,7 @@ config VP_VDPA
>  
>  config ALIBABA_ENI_VDPA
>  	tristate "vDPA driver for Alibaba ENI"
> +	select VIRTIO_PCI_LIB
>  	select VIRTIO_PCI_LIB_LEGACY
>  	depends on PCI_MSI && X86
>  	help
> -- 
> 2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
