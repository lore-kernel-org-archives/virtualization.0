Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E2AC433EF
	for <virtualization@archiver.kernel.org>; Mon,  6 Dec 2021 03:12:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C80160A80;
	Mon,  6 Dec 2021 03:12:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kSRY279qwzTS; Mon,  6 Dec 2021 03:12:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E8CDD60A4E;
	Mon,  6 Dec 2021 03:12:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0279C002F;
	Mon,  6 Dec 2021 03:12:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76C18C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 03:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 507EE4013C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 03:12:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MZ5v-7wYD62h
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 03:12:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F03E6400EF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 03:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638760337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NUwMELfoN5sdz4QIGxURvLcCWplqvHofYeoKR0bfVRk=;
 b=ABkARrz+WuEJFZqaV5dtMdpfWNR+EYSJp4btCNZgDfjpZld80+9szgWc283yDBlLOIEYOG
 F8nQOYmHupYMDlLxZDF1CSyaYPlc/tmXPyGNyPmpOLilvxfr18w0vJSnOoLg7ohJAIvth2
 xHh54SBgyGreMSlG5wGww5KEB4g3kxQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-334-Ci0Co_GDPlC_cQKeyCu3pA-1; Sun, 05 Dec 2021 22:12:16 -0500
X-MC-Unique: Ci0Co_GDPlC_cQKeyCu3pA-1
Received: by mail-lf1-f72.google.com with SMTP id
 e23-20020a196917000000b0041bcbb80798so1147847lfc.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Dec 2021 19:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NUwMELfoN5sdz4QIGxURvLcCWplqvHofYeoKR0bfVRk=;
 b=PInMhVPb7Wdv4BK/H0aNn3DqFGOwT8bJ2AEf5eCbsCc9h3DahSowvisOsfoHpAA14D
 lZt1xkvJjrIfQkIkeImPohF0AowecsVqr+BFtj2LLheGI0XP7ekIlzBILOfHGEWDmktu
 2jFinuqDDpQrVd/6lJaA7tt7VU5sfZoelwHh5tTPH6J/RGcWHFXkzUVGWjQZzlPRx6wH
 r+C2D3p+L4Q40qtqlAtks+j2pyjlfogq8Z+zAmMddMhTr31nr94DaO0fa8Zca1Bte3VE
 LEf4RQcHjMPVkBmB6RNw1nEl9PGoOf067j9wQdA8IksnvBgqc6LftWOUMltgyhgEVUNZ
 q+7Q==
X-Gm-Message-State: AOAM531URwL4FiL5FSFYNYzS0wJVrVAy7D8d8sLmZNa63VbJPGuuSjZO
 IU7znWrAl+NhqpjX72qmlPjB+1rkt23G3KoCFo/xG6RWfiD/LBdo0RUI7scuFPzlsPrc8m48zaY
 eAeg/yTMSBBNSa9QdUNQ7LFfi211QfWE5wsWxjYD84rcLpztBa6S5NOKy4w==
X-Received: by 2002:a2e:b169:: with SMTP id a9mr34411872ljm.369.1638760334647; 
 Sun, 05 Dec 2021 19:12:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxu4rPiY8eBrUgt2lLw3I3dthDt2zXcE5AbclsSH3qgPuVmutwQVyiDFVxWdCAwAF5lOseVaPhk79/aBFCs+08=
X-Received: by 2002:a2e:b169:: with SMTP id a9mr34411854ljm.369.1638760334455; 
 Sun, 05 Dec 2021 19:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20211203185522.692489-1-arnd@kernel.org>
In-Reply-To: <20211203185522.692489-1-arnd@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 Dec 2021 11:12:03 +0800
Message-ID: <CACGkMEuv2HQxUyxL8hsAXGOKxhTFED5_AcnZ1dOALh2QsL7ZKQ@mail.gmail.com>
Subject: Re: [PATCH] eni_vdpa: alibaba: select VIRTIO_PCI_LIB
To: Arnd Bergmann <arnd@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
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

On Sat, Dec 4, 2021 at 2:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
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

Intersting, all those belongs to the legacy library.

And I just have a try and I can complie alibaba eni without
VIRTIO_PCI_LIB is set.

Can you share your config file?

Thanks

>
> Selecting VIRTIO_PCI_LIB_LEGACY is not sufficient here since that is
> only part of the VIRTIO_PCI_LIB support.
>
> Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
>         tristate "vDPA driver for Alibaba ENI"
> +       select VIRTIO_PCI_LIB
>         select VIRTIO_PCI_LIB_LEGACY
>         depends on PCI_MSI && X86
>         help
> --
> 2.29.2
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
