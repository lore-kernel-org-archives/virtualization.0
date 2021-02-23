Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C15C433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 14:26:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A52364E5C
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 14:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A52364E5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 23EEF8722B;
	Tue, 23 Feb 2021 14:26:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id plGUEGj+dWjb; Tue, 23 Feb 2021 14:26:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9EFF78720E;
	Tue, 23 Feb 2021 14:26:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68620C000B;
	Tue, 23 Feb 2021 14:26:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0BC2C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 14:26:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8D20E8722B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 14:26:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6r7K5XTY4OfK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 14:25:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BFFE88720E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614090358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j59T9PY61/DvPyamE3fR/tpe611NAXL0hjfPHhn4QIs=;
 b=EYipTx55Iqi0H/70/Ua+w0SUL543RefVbADcKQWurXmZqFng7EBOKfcDmt1Ls5qDlgaaih
 tg9bjRonWlDQGbhbstOMZa7Z29Phf4UaL3sTLjiV2SaeQT7Vei3Q8wr7eZbzP0vTpbNikv
 TvoSOKbcbQvKQI9F4A+6RECGJMh/lhk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-CDPThidmMgeEabwjkoRJMA-1; Tue, 23 Feb 2021 09:25:56 -0500
X-MC-Unique: CDPThidmMgeEabwjkoRJMA-1
Received: by mail-wm1-f72.google.com with SMTP id f185so719941wmf.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 06:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=j59T9PY61/DvPyamE3fR/tpe611NAXL0hjfPHhn4QIs=;
 b=GXXm0VigMJO96DAAH6vZZJ4Pze3mMn5f1Jhgp3KLCWAXXsWMiicfZorTYJq98/ch38
 /LTe9pvVoBYXquDDRCpnLu7VCiJX3tlV+0Ef3F14ZmbUalXcRE6ml0ask2DLkvyCUkEg
 x47iZWngteuyQbitnbLjS3YpDf9sK+094uj1uu4qS/hxulcFyLCt6pLyh+udPS9gPKyg
 ks3a7sw0zEZhF1ZCBfDlFiUfxipFsaGG2Vl3x2Cjb3hrN0sM7el3r7IcmRo6SHmog15T
 QC0GtDKUneQDBAJ4dVCrUfMy93vKHW8JrR0BXGA+UQqdgxc2VEMaz2nOiP9+tH+jXapK
 IpHQ==
X-Gm-Message-State: AOAM530Z2dX5xO3ga1JTURxcsmmangWQY975LyBH5d7n8Ouyxo8cm+VG
 xX93knybyUYnjdCiG0TvJIdo89YOq4E9cGwGcEN/4ViYp2Dv7nIIV3vGEKPhCexy3umSJAx/lp8
 AzWl4tifuq7jE8HrQ8EeaI0ysDRyhnt1S4cmggJ4Upw==
X-Received: by 2002:a05:600c:214f:: with SMTP id
 v15mr14622940wml.62.1614090354956; 
 Tue, 23 Feb 2021 06:25:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOjX93fAAfT9DnNw4YOICn2RYl95gjK/GlFsQv/m7FcoRtKye19LOKEmxxQFHD91P6//mglQ==
X-Received: by 2002:a05:600c:214f:: with SMTP id
 v15mr14622928wml.62.1614090354823; 
 Tue, 23 Feb 2021 06:25:54 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id a14sm2245520wrg.84.2021.02.23.06.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 06:25:54 -0800 (PST)
Date: Tue, 23 Feb 2021 09:25:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wei Wang <weiwan@google.com>
Subject: Re: [PATCH net v2 0/2] virtio-net: suppress bad irq warning for tx
 napi
Message-ID: <20210223092434-mutt-send-email-mst@kernel.org>
References: <20210220014436.3556492-1-weiwan@google.com>
MIME-Version: 1.0
In-Reply-To: <20210220014436.3556492-1-weiwan@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
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

On Fri, Feb 19, 2021 at 05:44:34PM -0800, Wei Wang wrote:
> With the implementation of napi-tx in virtio driver, we clean tx
> descriptors from rx napi handler, for the purpose of reducing tx
> complete interrupts. But this could introduce a race where tx complete
> interrupt has been raised, but the handler found there is no work to do
> because we have done the work in the previous rx interrupt handler.
> This could lead to the following warning msg:
> [ 3588.010778] irq 38: nobody cared (try booting with the
> "irqpoll" option)
> [ 3588.017938] CPU: 4 PID: 0 Comm: swapper/4 Not tainted
> 5.3.0-19-generic #20~18.04.2-Ubuntu
> [ 3588.017940] Call Trace:
> [ 3588.017942]  <IRQ>
> [ 3588.017951]  dump_stack+0x63/0x85
> [ 3588.017953]  __report_bad_irq+0x35/0xc0
> [ 3588.017955]  note_interrupt+0x24b/0x2a0
> [ 3588.017956]  handle_irq_event_percpu+0x54/0x80
> [ 3588.017957]  handle_irq_event+0x3b/0x60
> [ 3588.017958]  handle_edge_irq+0x83/0x1a0
> [ 3588.017961]  handle_irq+0x20/0x30
> [ 3588.017964]  do_IRQ+0x50/0xe0
> [ 3588.017966]  common_interrupt+0xf/0xf
> [ 3588.017966]  </IRQ>
> [ 3588.017989] handlers:
> [ 3588.020374] [<000000001b9f1da8>] vring_interrupt
> [ 3588.025099] Disabling IRQ #38
> 
> This patch series contains 2 patches. The first one adds a new param to
> struct vring_virtqueue to control if we want to suppress the bad irq
> warning. And the second patch in virtio-net sets it for tx virtqueues if
> napi-tx is enabled.

I'm going to be busy until March, I think there should be a better
way to fix this though. Will think about it and respond in about a week.


> Wei Wang (2):
>   virtio: add a new parameter in struct virtqueue
>   virtio-net: suppress bad irq warning for tx napi
> 
>  drivers/net/virtio_net.c     | 19 ++++++++++++++-----
>  drivers/virtio/virtio_ring.c | 16 ++++++++++++++++
>  include/linux/virtio.h       |  2 ++
>  3 files changed, 32 insertions(+), 5 deletions(-)
> 
> -- 
> 2.30.0.617.g56c4b15f3c-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
