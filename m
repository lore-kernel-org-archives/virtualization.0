Return-Path: <SRS0=KS98=P4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431C9C433F5
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 13:03:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF46061178
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 13:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CF46061178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7B7654013A;
	Tue,  9 Nov 2021 13:03:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sxYiKMvsf8bs; Tue,  9 Nov 2021 13:03:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EDD4C400DA;
	Tue,  9 Nov 2021 13:03:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA98FC0012;
	Tue,  9 Nov 2021 13:03:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D9F2C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:03:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4C2B5605C7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:03:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VSw7GSq_jEJD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:03:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0DF34605C3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636463011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cf4/5CFtCfqfKTzk28jN6LSZwSFGEQhCnZssU3UH2zk=;
 b=ZfSBQfMbsEmoeVEbx94zAUdkALq/+ofCkHYoA3eoxBZpvaHVGGV2Ep8pW0ndGVXewjwPXK
 6yIFsJ5efrXRjfprfoUvjaUdAROwFyZHkBUmQpdtd3XRLPGvTMpuOdJlSAnNfMQsDF6TZT
 tukwEDaDi4zIR8GTy34OWpnoX6mrScA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-voTp5bhyPJ-ssWMTIGwGtg-1; Tue, 09 Nov 2021 08:03:30 -0500
X-MC-Unique: voTp5bhyPJ-ssWMTIGwGtg-1
Received: by mail-ed1-f70.google.com with SMTP id
 q6-20020a056402518600b003e28d92bb85so17807326edd.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Nov 2021 05:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Cf4/5CFtCfqfKTzk28jN6LSZwSFGEQhCnZssU3UH2zk=;
 b=KkJKUcF2Az6mP+k7WgMR47Bxij6JBzMcKil0G5SrubhVZh6thCVL1xen1zb0i4yiKI
 Ys/JKZHfDIDeD6e2XHz4aUbsR8WMZeFW41TTxTcxQYEYg1b3jv1OM8k6Vr0T711csklm
 UWZCtp/nkZrCe6czUWp+Ok+rM0f8gfdEBtn6JD2k3zuKKtMSZa2JmDI9tCTGffueGFKR
 y3Hv2HIIqbhNSYCLINiCU6mk5MwqP7LMsRaTF+XcVcWLk3UgMICbKNdfdwL4qca5IYdd
 ONuBsPvjWvcw7J9cCWiCzF5f15hfiFTQzBE4Tk2hopYXIrg+aQR2EoU2qCCR8Y2TqJ+x
 /g/Q==
X-Gm-Message-State: AOAM530RfTRIgZpUA/Tims/CW1Az4lq/V906A77540UxudqSk1bA4bVs
 AjTCXHHiEgF/2F59A3ZZg1D55Karu+pDAz0tuf1Wr+GGc5x1jn4X2STwwD6FXH8fw9Dg6YtXU4B
 zE5vWO+LznPMGAzvD08Eoc4d177XVJgIzEvpdyBQ28A==
X-Received: by 2002:a50:e707:: with SMTP id a7mr10237695edn.352.1636463009291; 
 Tue, 09 Nov 2021 05:03:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwswjgU9vYPdPQiIhqFtYWaC+jd0TG7EGgxo84FE6Db2sxhysQD3zCTHscC1w7Sr0OCCaAKGw==
X-Received: by 2002:a50:e707:: with SMTP id a7mr10237660edn.352.1636463009146; 
 Tue, 09 Nov 2021 05:03:29 -0800 (PST)
Received: from redhat.com ([2.55.133.41])
 by smtp.gmail.com with ESMTPSA id de15sm211006ejc.70.2021.11.09.05.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Nov 2021 05:03:27 -0800 (PST)
Date: Tue, 9 Nov 2021 08:03:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4 0/3] virtio support cache indirect desc
Message-ID: <20211109080023-mutt-send-email-mst@kernel.org>
References: <20211108114951.92862-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20211108114951.92862-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org
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

On Mon, Nov 08, 2021 at 07:49:48PM +0800, Xuan Zhuo wrote:
> If the VIRTIO_RING_F_INDIRECT_DESC negotiation succeeds, and the number
> of sgs used for sending packets is greater than 1. We must constantly
> call __kmalloc/kfree to allocate/release desc.
> 
> In the case of extremely fast package delivery, the overhead cannot be
> ignored:
> 
>   27.46%  [kernel]  [k] virtqueue_add
>   16.66%  [kernel]  [k] detach_buf_split
>   16.51%  [kernel]  [k] virtnet_xsk_xmit
>   14.04%  [kernel]  [k] virtqueue_add_outbuf
>    5.18%  [kernel]  [k] __kmalloc
>    4.08%  [kernel]  [k] kfree
>    2.80%  [kernel]  [k] virtqueue_get_buf_ctx
>    2.22%  [kernel]  [k] xsk_tx_peek_desc
>    2.08%  [kernel]  [k] memset_erms
>    0.83%  [kernel]  [k] virtqueue_kick_prepare
>    0.76%  [kernel]  [k] virtnet_xsk_run
>    0.62%  [kernel]  [k] __free_old_xmit_ptr
>    0.60%  [kernel]  [k] vring_map_one_sg
>    0.53%  [kernel]  [k] native_apic_mem_write
>    0.46%  [kernel]  [k] sg_next
>    0.43%  [kernel]  [k] sg_init_table
>    0.41%  [kernel]  [k] kmalloc_slab
> 
> This patch adds a cache function to virtio to cache these allocated indirect
> desc instead of constantly allocating and releasing desc.
> 
> v4:
>     1. Only allow desc cache when VIRTIO_RING_F_INDIRECT_DESC negotiation is successful
>     2. The desc cache threshold can be set for each virtqueue
> 
> v3:
>   pre-allocate per buffer indirect descriptors array

So I'm not sure why we are doing that. Did it improve anything?


> v2:
>   use struct list_head to cache the desc
> 
> Xuan Zhuo (3):
>   virtio: cache indirect desc for split
>   virtio: cache indirect desc for packed
>   virtio-net: enable virtio desc cache
> 
>  drivers/net/virtio_net.c     |  12 ++-
>  drivers/virtio/virtio_ring.c | 152 +++++++++++++++++++++++++++++++----
>  include/linux/virtio.h       |  17 ++++
>  3 files changed, 163 insertions(+), 18 deletions(-)
> 
> --
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
