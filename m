Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E718BC4332F
	for <virtualization@archiver.kernel.org>; Thu, 13 Oct 2022 02:29:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75A8483E42;
	Thu, 13 Oct 2022 02:29:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75A8483E42
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JlUjJHB1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XqrMI82ES4gQ; Thu, 13 Oct 2022 02:29:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1C64583E3A;
	Thu, 13 Oct 2022 02:29:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C64583E3A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4B16C0032;
	Thu, 13 Oct 2022 02:29:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6128C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 02:29:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7915A4026F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 02:29:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7915A4026F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JlUjJHB1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1pWGALDGDYZm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 02:29:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3439E40233
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3439E40233
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 02:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665628160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iDiMIcuyeX7LC8mKPvxUszNsXHrwyk0NdQeY660GwNM=;
 b=JlUjJHB1z/cQ6HDp7M/0xSlh5ycJ5tuVvl48jzIgKwjExEJHKF6EMDerah1o7DQl/neSDp
 2Sf1gyYKDIjdPoZnpd1h0Lyij2Kg9Tl7adW1ZQL2/6Ts02ZhFxixlIYr2R/hiJpX6MHodQ
 qeijG+/A8RHBZ32UHMMhetGl6wYlRck=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-215-Q_NiITJvMumpA5asJ9NebQ-1; Wed, 12 Oct 2022 22:29:19 -0400
X-MC-Unique: Q_NiITJvMumpA5asJ9NebQ-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-131d9821d9cso398122fac.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 19:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iDiMIcuyeX7LC8mKPvxUszNsXHrwyk0NdQeY660GwNM=;
 b=xkGdPdYIgRu/qTTnvsYe+HDMFnlpyc8j0KGAFReHBgIb/K8rISN+G+6KlZTFAwsUzR
 uEo1+DTLdFEMq2Oclk301OxZpOITaZs78Goq7+W7u0YgK6PuWbUA+BrZlUjRj14SS7Fo
 j3fwx3Pt5ecEm9dZxVKIaFUN2ZHOGNHn7LnOP2P6RO8+drhGQduSgHoHc+Q47Ua0xBOI
 /6C96dBXMFwCX+SZqettmImafB83dL2wUpyBq7Mj82dKvmPjFlDEWYXp+HwM6SCjhxla
 qqwlHyjqXNN7ialGMk0iLdUE7sYUxgg3Q60YKxr5pNBXbyx/Gbt3FNgPcCKcMhIjhv+k
 aCoA==
X-Gm-Message-State: ACrzQf1O1QzBbN5ZV51A8rgaw6zz586tStq0ZFbRcaAWv1EKjmkxARox
 3u43w9CLAUfxzFMNPcp9TX3/Id/wNby+DjKJwOtksSY1PAVqTEanIF+8W4cPlNeig7xcTNjW3hz
 xJ9ly81sUCzYKevEFk75RM5hntwzz2P/XVysUBuApemOsOukUJOwmwmhccQ==
X-Received: by 2002:a05:6870:eca8:b0:132:df46:5c66 with SMTP id
 eo40-20020a056870eca800b00132df465c66mr3922641oab.280.1665628158852; 
 Wed, 12 Oct 2022 19:29:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6V1/do6f40qJ94o460ugmsH/1enc58fr6Vdw55XrpsZhcRMldKBcRC1wnZgdZg9G9QO27GAwwNEnFzHJw4FWk=
X-Received: by 2002:a05:6870:eca8:b0:132:df46:5c66 with SMTP id
 eo40-20020a056870eca800b00132df465c66mr3922631oab.280.1665628158639; Wed, 12
 Oct 2022 19:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221012220312.308522-1-mst@redhat.com>
In-Reply-To: <20221012220312.308522-1-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Oct 2022 10:29:07 +0800
Message-ID: <CACGkMEuYUwvYVQ71WwEAt+nA7WWcfYWYBwoiZYF4kir7_dKuqg@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: use irq to detect interrupt support
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 virtualization@lists.linux-foundation.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Angus Chen <angus.chen@jaguarmicro.com>
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

On Thu, Oct 13, 2022 at 6:04 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> commit 71491c54eafa ("virtio_pci: don't try to use intxif pin is zero")
> breaks virtio_pci on powerpc, when running as a qemu guest.
>
> vp_find_vqs() bails out because pci_dev->pin == 0.
>
> But pci_dev->irq is populated correctly, so vp_find_vqs_intx() would
> succeed if we called it - which is what the code used to do.
>
> This seems to happen because pci_dev->pin is not populated in
> pci_assign_irq().
>
> Which is absolutely a bug in the relevant PCI code, but it
> may also affect other platforms that use of_irq_parse_and_map_pci().
>
> However Linus said:
>         The correct way to check for "no irq" doesn't use NO_IRQ at all, it just does
>                 if (dev->irq) ...
> so let's just check irq and be done with it.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Fixes: 71491c54eafa ("virtio_pci: don't try to use intxif pin is zero")
> Cc: "Angus Chen" <angus.chen@jaguarmicro.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>
> Build tested only - very late here. Angus any chance you could
> help test this? Thanks!
>
>  drivers/virtio/virtio_pci_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 4df77eeb4d16..a6c86f916dbd 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -409,8 +409,8 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
>         if (!err)
>                 return 0;
> -       /* Is there an interrupt pin? If not give up. */
> -       if (!(to_vp_device(vdev)->pci_dev->pin))
> +       /* Is there an interrupt? If not give up. */
> +       if (!(to_vp_device(vdev)->pci_dev->irq))
>                 return err;
>         /* Finally fall back to regular interrupts. */
>         return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
