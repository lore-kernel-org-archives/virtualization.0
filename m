Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C11C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Apr 2022 02:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58CAD409A9;
	Mon, 25 Apr 2022 02:49:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bFWOsWwZWUR8; Mon, 25 Apr 2022 02:49:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8DBB54099E;
	Mon, 25 Apr 2022 02:49:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28073C0039;
	Mon, 25 Apr 2022 02:49:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47E61C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 02:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2FF2A4014B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 02:49:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ikpAgMgsE5n9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 02:49:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D9DA40112
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 02:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650854980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KCDyepNLXIMjCmD0I9QrPPQw55hA5ANlxUCyUt8honk=;
 b=Stcu18lcAZIvic+2IW01pKjrU6M1mu30qNO5Xt5RH49IFNX3tsSp8kgxryKAmHS+sgQUlt
 VsauHQtzP1s/6mJ2B0UtkIuTxsUpHoE68U/i6ZEr04ThNPm0EvDvpEtIqs5CGT+A/a5I6+
 CyAY+WABAkMDBwk+KtCUa2ItEncd2t0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-Q_-fsNhVOoG1qLHelyLXlQ-1; Sun, 24 Apr 2022 22:49:39 -0400
X-MC-Unique: Q_-fsNhVOoG1qLHelyLXlQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 b16-20020a056512305000b00471effe87f9so2503995lfb.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 19:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KCDyepNLXIMjCmD0I9QrPPQw55hA5ANlxUCyUt8honk=;
 b=Lv7uoRHJE1XMTdTOQuJbHxA8fZcQQGGy1rmRBBQtJSKTaqWnQnU0K8uS6LIKCmxs8y
 mug2A21BGnbNtXzdOCOhIP/q8E0fTSKv/epsgVvCD8pXAPY/YLVRX/BdhXXplyq8J6Cu
 pKmPfuM5Wy5/YL/G2pk30TSi8De+e8qWV5A8ejIxYsdS46iipGZy1mefeagII26KA98H
 6fWKQIf/0h4fmuQVhlILWf+lb+zQ8lPseN3tjFiJ5TslhbnlLUm+/UU1Ta9XXTpt7ZSi
 PwIQpzr601vc2WJIcfJ/Z/wpKEwEScX5C0p+62yTmhS1B5VnXDlub5HZE3s3Awzk6f3c
 ywLg==
X-Gm-Message-State: AOAM531ZEwO8vg5FfYeO2MPSLFSCO7k6ZiAiwgfUfabPoo/8ynCZV4+n
 7dFKSseG0fCgUHQMB6kBy+rB6M468uwcTJIRvrjH8KqE/rK853jY37axmsdRvWzhKYjCKSHifXh
 1HyTtkJy7Rr+t97/HahwiQ0gxZ0jsUTXMyGzr8lzrK9iHHhkksAZWT32sAg==
X-Received: by 2002:a05:6512:33d0:b0:471:a625:fdc0 with SMTP id
 d16-20020a05651233d000b00471a625fdc0mr11800999lfg.98.1650854977602; 
 Sun, 24 Apr 2022 19:49:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1Bvc17jPROA+PgD8i2WHUkLeo7es3ShJCEW8hl7n+TZizuTW12IXBKEaR8K1XNZsBoQg+8eF/ps6c9TnSDWs=
X-Received: by 2002:a05:6512:33d0:b0:471:a625:fdc0 with SMTP id
 d16-20020a05651233d000b00471a625fdc0mr11800984lfg.98.1650854977394; Sun, 24
 Apr 2022 19:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220425024418.8415-1-jasowang@redhat.com>
In-Reply-To: <20220425024418.8415-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Apr 2022 10:49:26 +0800
Message-ID: <CACGkMEu0qSb2o0HM6R2HE2g_fTbEBwPfXk7pO-QYepe3Unk5aw@mail.gmail.com>
Subject: Re: [PATCH V3 0/9] rework on the IRQ hardening of virtio
To: jasowang <jasowang@redhat.com>, mst <mst@redhat.com>, 
 linux-kernel <linux-kernel@vger.kernel.org>, 
 virtualization <virtualization@lists.linux-foundation.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Cindy Lu <lulu@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 eperezma <eperezma@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Mon, Apr 25, 2022 at 10:44 AM Jason Wang <jasowang@redhat.com> wrote:
>
> Hi All:
>

Forgot to add Xuan to the series.

Thanks

> This is a rework on the IRQ hardening for virtio which is done
> previously by the following commits are reverted:
>
> 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
> 080cd7c3ac87 ("virtio-pci: harden INTX interrupts")
>
> The reason is that it depends on the IRQF_NO_AUTOEN which may conflict
> with the assumption of the affinity managed IRQ that is used by some
> virtio drivers. And what's more, it is only done for virtio-pci but
> not other transports.
>
> In this rework, I try to implement a general virtio solution which
> borrows the idea of the INTX hardening by re-using per virtqueue
> boolean vq->broken and toggle it in virtio_device_ready() and
> virtio_reset_device(). Then we can simply reuse the existing checks in
> the vring_interrupt() and return early if the driver is not ready.
>
> Note that, I only did compile test on ccw and MMIO transport.
>
> Please review.
>
> Changes since v1:
>
> - Use transport specific irq synchronization method when possible
> - Drop the module parameter and enable the hardening unconditonally
> - Tweak the barrier/ordering facilities used in the code
> - Reanme irq_soft_enabled to driver_ready
> - Avoid unnecssary IRQ synchornization (e.g during boot)
>
> Changes since V2:
>
> - add ccw and MMIO support
> - rename synchronize_vqs() to synchronize_cbs()
> - switch to re-use vq->broken instead of introducing new device
>   attributes for the future virtqueue reset support
> - remove unnecssary READ_ONCE()/WRITE_ONCE()
> - a new patch to remove device triggerable BUG_ON()
> - more tweaks on the comments
>
> Jason Wang (8):
>   virtio: use virtio_reset_device() when possible
>   virtio: introduce config op to synchronize vring callbacks
>   virtio-pci: implement synchronize_cbs()
>   virtio-mmio: implement synchronize_cbs()
>   virtio-ccw: implement synchronize_cbs()
>   virtio: allow to unbreak virtqueue
>   virtio: harden vring IRQ
>   virtio: use WARN_ON() to warning illegal status value
>
> Stefano Garzarella (1):
>   virtio: use virtio_device_ready() in virtio_device_restore()
>
>  drivers/char/virtio_console.c              |  2 +-
>  drivers/crypto/virtio/virtio_crypto_core.c |  2 +-
>  drivers/s390/virtio/virtio_ccw.c           | 31 ++++++++++++++++--
>  drivers/virtio/virtio.c                    | 24 ++++++++++----
>  drivers/virtio/virtio_mmio.c               |  9 +++++
>  drivers/virtio/virtio_pci_common.c         |  2 +-
>  drivers/virtio/virtio_pci_common.h         |  2 ++
>  drivers/virtio/virtio_pci_legacy.c         |  1 +
>  drivers/virtio/virtio_pci_modern.c         |  2 ++
>  drivers/virtio/virtio_ring.c               | 15 +++++----
>  include/linux/virtio.h                     |  2 +-
>  include/linux/virtio_config.h              | 38 +++++++++++++++++++++-
>  12 files changed, 110 insertions(+), 20 deletions(-)
>
> --
> 2.25.1
>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
