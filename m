Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12533C433F5
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 11:36:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A305B81D11;
	Wed,  6 Apr 2022 11:36:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lyxfeQ8EsY8K; Wed,  6 Apr 2022 11:36:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 46E8F81C20;
	Wed,  6 Apr 2022 11:36:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29A13C001D;
	Wed,  6 Apr 2022 11:36:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31F76C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 11:36:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D39F405E6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 11:36:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HZLX6pNcYrDb
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 11:36:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D64A640386
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 11:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649244972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QsS3+hPNYqFkkpCy/2zflCp4q5xBw1zafG1zPBrhqj4=;
 b=dY057qsRLqer5mQvBgQZozyVYQuI3qRPWlGE/wyy+AIAV6S6lgDGiF41OQApewJnjpe6Sh
 Hh31ni/5QVgDtFL34URUSHlXlxRO/tCkQwGWUFRqiuH9mQhBCyAdsuD+BeyTtV+P5E71EO
 MGYIinvm4vxh2NzArW2PJwQbsNqgGjM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-YqRTpdWjNdKUFy0Bt40Z7g-1; Wed, 06 Apr 2022 07:36:11 -0400
X-MC-Unique: YqRTpdWjNdKUFy0Bt40Z7g-1
Received: by mail-ed1-f72.google.com with SMTP id
 p14-20020a05640243ce00b0041cbccbe008so1057876edc.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Apr 2022 04:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QsS3+hPNYqFkkpCy/2zflCp4q5xBw1zafG1zPBrhqj4=;
 b=12hXmBco5ZhqxaadxyXSAH+ocLvTaOv1o9e0V6vGa8wNFyE/BQ/foJEF+1I8YYp+NA
 1DhisuQeWPOMvJlLbPbHJZuZ2tCwxnyHLHxr59roIFIMFyG1QsiGHfikHrjJmjMpT1vB
 ybPW/RnoklAOanTcAB2Mi2baGj67HRA+ihFHyPnoM2bJdbAA0x6clJDerFVLNewJBA85
 EKBEMpcvxlxCTmw2aSwihg5kmYJefDTWRPW0IAjCkyBVAuM3q1t9L6ylVIqQ+9k5O1a/
 XxnBD2qCrHLPZt7TCaEdQDKScnn/Wn73L053lcoiHkNQNZgIVSPCvWpZqljy3tsVdKc3
 gpHg==
X-Gm-Message-State: AOAM531sj/0oeyq8A5DmvsDWDNUuCwPuU+fQttCEmUPv5t5i8+RfSG0G
 idUM9NwdFAGAsi+jdaM3pKQVdCVfoNuNsMRLQwdnKT9WBIJyq6LZ2VeLfZANW95bfnIlKs7jqi/
 L/NqJ+XOK2OBXVXeJsWlq4+iJmdqqYbWRIBFHRpDgNw==
X-Received: by 2002:a17:907:6d92:b0:6e5:d50e:9170 with SMTP id
 sb18-20020a1709076d9200b006e5d50e9170mr7892336ejc.506.1649244970491; 
 Wed, 06 Apr 2022 04:36:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypxpXVVLOxhtpSoSl0a6R8c9Uqer3rPVAkc8Pe1+YYicYMzoEDo4eBchIbF2poX4V8YaDCTw==
X-Received: by 2002:a17:907:6d92:b0:6e5:d50e:9170 with SMTP id
 sb18-20020a1709076d9200b006e5d50e9170mr7892318ejc.506.1649244970217; 
 Wed, 06 Apr 2022 04:36:10 -0700 (PDT)
Received: from redhat.com ([2.53.144.12]) by smtp.gmail.com with ESMTPSA id
 m20-20020a170906235400b006e718d8b849sm4612248eja.45.2022.04.06.04.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Apr 2022 04:36:09 -0700 (PDT)
Date: Wed, 6 Apr 2022 07:36:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 0/5] rework on the IRQ hardening of virtio
Message-ID: <20220406073500-mutt-send-email-mst@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220406083538.16274-1-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: peterz@infradead.org, maz@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, tglx@linutronix.de
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

On Wed, Apr 06, 2022 at 04:35:33PM +0800, Jason Wang wrote:
> Hi All:
> 
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
> borrows the idea of the INTX hardening by introducing a boolean for
> virtqueue callback enabling and toggle it in virtio_device_ready()
> and virtio_reset_device(). Then vring_interrupt() can simply check and
> return early if the driver is not ready.


All of a sudden all patches are having a wrong mime type.

It is application/octet-stream; should be text/plain

Pls fix and repost, thanks!

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
> Jason Wang (4):
>   virtio: use virtio_reset_device() when possible
>   virtio: introduce config op to synchronize vring callbacks
>   virtio-pci: implement synchronize_vqs()
>   virtio: harden vring IRQ
> 
> Stefano Garzarella (1):
>   virtio: use virtio_device_ready() in virtio_device_restore()
> 
>  drivers/virtio/virtio.c            | 20 ++++++++++++++++----
>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
>  drivers/virtio/virtio_pci_common.h |  2 ++
>  drivers/virtio/virtio_pci_legacy.c |  1 +
>  drivers/virtio/virtio_pci_modern.c |  2 ++
>  drivers/virtio/virtio_ring.c       |  9 ++++++++-
>  include/linux/virtio.h             |  2 ++
>  include/linux/virtio_config.h      | 24 ++++++++++++++++++++++++
>  8 files changed, 69 insertions(+), 5 deletions(-)
> 
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
