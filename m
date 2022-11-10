Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E353C433FE
	for <virtualization@archiver.kernel.org>; Thu, 10 Nov 2022 06:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2693240940;
	Thu, 10 Nov 2022 06:27:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2693240940
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GGcSFG0A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eg6CKj2Wwide; Thu, 10 Nov 2022 06:27:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6924A40886;
	Thu, 10 Nov 2022 06:27:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6924A40886
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B65AC0033;
	Thu, 10 Nov 2022 06:27:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E56BEC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 06:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC8F140182
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 06:27:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC8F140182
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GGcSFG0A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7tkb7-KfCPSt
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 06:27:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 25D8F40192
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 25D8F40192
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 06:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668061647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JPT2SlSbYl+8u2DBxIMbsp2kZiM/fVVnMLVLMjyKspc=;
 b=GGcSFG0AeeFOcwZjN8zvzfrH/Wn2KFlZUx+276OZyl+ooXumUH+zAXVDIKUE+c22cJ9K6s
 P05b9s+71QkrJKN4clFzgSXPIOOauII45Y1OcKqKdIgRF2yMZkVXoJhzaDRI+GRi1mnXPB
 szBxm3arNCw2Djrwx3SF2elHyetZqkw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-92-L2goq_32MBq8L4ZpfgQ72A-1; Thu, 10 Nov 2022 01:27:25 -0500
X-MC-Unique: L2goq_32MBq8L4ZpfgQ72A-1
Received: by mail-wm1-f71.google.com with SMTP id
 m34-20020a05600c3b2200b003cf549cb32bso2176264wms.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Nov 2022 22:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPT2SlSbYl+8u2DBxIMbsp2kZiM/fVVnMLVLMjyKspc=;
 b=pspyzXKc9wcMDZJ+JPeHVQCm3n5+/LxpI158z6InzLepSPFF0iUCTnMSQRg8Opninu
 2s/heoLWEUbzkuWJKMaWs9tlpC1GEr/jRYHgzJemJgTydWEOi1o9kf9lbqLa9WogJ5En
 dW3I1CsC0rWWQLMFWB+ymLmQjTuuWmwubI31uI4VT8Y39RasC0BBEhRqyPA4HOH3dC3C
 fQE6QIm13M7yJGZ+GDj96zicyjFD5rqSMlGmG8u9femgztbz/hz4AKI7BeJjXWZE7Blb
 xwAXXP9u0nUVZhN53y0zzoABW9KBW4dGZyRwLWqa/2FyX5bte7rDI3vKxntZ6lSQvZdD
 ZL1g==
X-Gm-Message-State: ANoB5pmA7qHKnvW+5Yr2OOZpJE5mtt5qnbkHct8fUiOCWcRpF9haoBnN
 RTuZH88CAs/idrDt+ryn7bbG8GgmBstJxOcXPYnXjRenEM5OgG4TFbXRImPcfDEfvsSH5UtrvD2
 OiFsDXhOHPxk8sWnld8jQUPnGrEcP3FYKRop7lKyf8g==
X-Received: by 2002:a05:600c:4fd3:b0:3cf:a464:e881 with SMTP id
 o19-20020a05600c4fd300b003cfa464e881mr15090841wmq.54.1668061644653; 
 Wed, 09 Nov 2022 22:27:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7F8ljwfsHi6Qg3i6MOW0kqbhg6e9MSwr915+n+jG7X9LJmAIvrroYMgfusPWAjiNyCNwL+cg==
X-Received: by 2002:a05:600c:4fd3:b0:3cf:a464:e881 with SMTP id
 o19-20020a05600c4fd300b003cfa464e881mr15090833wmq.54.1668061644392; 
 Wed, 09 Nov 2022 22:27:24 -0800 (PST)
Received: from redhat.com ([2.52.23.68]) by smtp.gmail.com with ESMTPSA id
 g12-20020adffc8c000000b0022cd96b3ba6sm17304181wrr.90.2022.11.09.22.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Nov 2022 22:27:23 -0800 (PST)
Date: Thu, 10 Nov 2022 01:27:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH] virtio_pci: use PAGE_SIZE for pci vring align
Message-ID: <20221110012603-mutt-send-email-mst@kernel.org>
References: <20221110061111.383076-1-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20221110061111.383076-1-xianting.tian@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Thu, Nov 10, 2022 at 02:11:11PM +0800, Xianting Tian wrote:
> As the comments of VIRTIO_PCI_VRING_ALIGN shows, we should use
> PAGE_SZIE not the hard code 4096.
> 
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>


where does it show this?
what is the problem you are trying to solve?
PAGE_SIZE is generally not valid in uapi

> ---
>  include/uapi/linux/virtio_pci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index f703afc7ad31..ed5f678c682b 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -90,7 +90,7 @@
>  
>  /* The alignment to use between consumer and producer parts of vring.
>   * x86 pagesize again. */
> -#define VIRTIO_PCI_VRING_ALIGN		4096
> +#define VIRTIO_PCI_VRING_ALIGN		PAGE_SIZE
>  
>  #endif /* VIRTIO_PCI_NO_LEGACY */
>  
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
