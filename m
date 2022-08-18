Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA96C00140
	for <virtualization@archiver.kernel.org>; Thu, 18 Aug 2022 08:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 085A0410A1;
	Thu, 18 Aug 2022 08:11:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 085A0410A1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BORCKaWS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kLwBL7_JG1U9; Thu, 18 Aug 2022 08:11:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7F89E40395;
	Thu, 18 Aug 2022 08:11:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7F89E40395
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30CE0C0032;
	Thu, 18 Aug 2022 08:11:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5329C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 08:11:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8BED984012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 08:11:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8BED984012
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BORCKaWS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H-dEgO5XglCc
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 08:11:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BDF0583163
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BDF0583163
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 08:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660810259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jOuXR0tf3DFwelcVW4wVX0u96and2gGVlJpYF1C0zcc=;
 b=BORCKaWSgP+00DQJ1AAl9ZajzQzZkPSWE8ZttASjBV3X0lz2BbDLQ2QVsbvMmweS3xwLq1
 ju+yqbhNjLTNSgvpI4aVH0cpho+RYh5B96xn7CpsTIz04UIMEOZDwTX7DuKOlTBg3zSRUj
 BgKxtwOQ4Sr6hJyhmSb+3EikK0Cc0DM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-288-02sbkW1ZMhGMuYYf5AZsow-1; Thu, 18 Aug 2022 04:10:58 -0400
X-MC-Unique: 02sbkW1ZMhGMuYYf5AZsow-1
Received: by mail-lj1-f200.google.com with SMTP id
 z7-20020a2ebe07000000b0025e5c7d6a2eso261014ljq.20
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 01:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=jOuXR0tf3DFwelcVW4wVX0u96and2gGVlJpYF1C0zcc=;
 b=A4S5hR7xNSZZt/VxTjCztrCx3iHkj4F41S/aDyQphB19Sc6dt6COZNmgx81z6maewK
 r00+Bo/D9vQj5Z84v4wzcuzi55T6WwSSje8ciHi7K8l81UxB94j8v6y6kumnUsMjguE0
 zMxF2Vi46AXh2TK9wEqCmP7iFG5el5DYdBMyP2gWriGWbU/DrmSvVxo81SLKxN5QRWhl
 OkAqa9hUfdbUAruZ5gpQQ4rXy5vgk4oV84K/RX5GYOiIprNgG7L4oX5RG/UPjysO9Llu
 e5uVlcMDf15pcHAS0xLKxuBpDfEvB3bF+EqpmSQnmfj36sc+dAhSvhkYqmoA+Hl1NLAU
 YK2Q==
X-Gm-Message-State: ACgBeo0mMgOzxqnXaoF+uh55/lU7RSiHVuL6fHPeS862sHTvIqzaYf3u
 S0Xc6ehIg9nIhLo+TmVn69iP7tcqk+cl40PIJS/XdG52WfZYhR7yFHq/X3w+n034ijOdbVuV17C
 HnQ79nEyNnPcIfgKiAqy9ue65Rrs/eZen/bT5QFnwrgCUm1RTesJYwqsKlA==
X-Received: by 2002:a05:6512:12c7:b0:48b:3bc4:10f4 with SMTP id
 p7-20020a05651212c700b0048b3bc410f4mr564730lfg.411.1660810256848; 
 Thu, 18 Aug 2022 01:10:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6t6QX4TD6KObXHLBZOqoF41CObCsxt2mjLIJWFI6B9yzm7mHy5t8EhOCjf6XnRivjmY3P2QmeR0d/L04QilNU=
X-Received: by 2002:a05:6512:12c7:b0:48b:3bc4:10f4 with SMTP id
 p7-20020a05651212c700b0048b3bc410f4mr564726lfg.411.1660810256655; Thu, 18 Aug
 2022 01:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220818030404.128597-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220818030404.128597-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Aug 2022 16:10:45 +0800
Message-ID: <CACGkMEvTPLf=Lg_43jSHFuq12xZdYP_c21tsot3ns7sP=Yreag@mail.gmail.com>
Subject: Re: [PATCH v2] virtio/virtio_pci_legacy: debug checking for queue size
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Thu, Aug 18, 2022 at 11:04 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> Legacy virtio pci has no way to communicate a change in vq size to
> the hypervisor. If ring sizes don't match hypervisor will happily
> corrupt memory.
>
> We add a check to vring size before calling
> vp_legacy_set_queue_address(). Checking the memory range directly is a
> bit cumbersome.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>
> v2: replace BUG_ON with WARN_ON_ONCE. @Linus
>
>  drivers/virtio/virtio_pci_legacy.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 2257f1b3d8ae..091e73d74e94 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -146,6 +146,15 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>                 goto out_del_vq;
>         }
>
> +       /* Legacy virtio pci has no way to communicate a change in vq size to
> +        * the hypervisor. If ring sizes don't match hypervisor will happily
> +        * corrupt memory.
> +        */
> +       if (WARN_ON_ONCE(num != virtqueue_get_vring_size(vq))) {
> +               err = -EPERM;
> +               goto out_del_vq;
> +       }

I wonder if it's better to have a num_min instead.

Thanks

> +
>         /* activate the queue */
>         vp_legacy_set_queue_address(&vp_dev->ldev, index, q_pfn);
>
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
