Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279A1EB64DD
	for <virtualization@archiver.kernel.org>; Thu, 22 Jun 2023 19:38:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B3BB740B9C;
	Thu, 22 Jun 2023 19:38:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B3BB740B9C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GrcoEnu/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BjqTfrQI3_tC; Thu, 22 Jun 2023 19:38:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 249AA40BAA;
	Thu, 22 Jun 2023 19:38:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 249AA40BAA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03A6BC0037;
	Thu, 22 Jun 2023 19:38:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C42E6C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 19:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D742409B3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 19:38:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D742409B3
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GrcoEnu/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2ZGWqIzierU3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 19:38:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 745964098C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 745964098C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 19:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687462701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uf7v6utVhvB9SDThVRGOmHwhlWU7bpbJmJ9KRenSJLo=;
 b=GrcoEnu/93mMrZlpSUCjg/N5q0w4E6C/qJaFBSYIaGk1zp91RIDWfTH5sLKm4AD4ZLEWK+
 TbHTUyHggiQoqbKplnZ+eMGGpA3qIw31BRJasug7rtIeY9AKLhFrrtYgNRNhQ1wVzWM5Xt
 0Wm1vluEw+B20MEKURZiNoEJMY7WBMw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-loAzrIFVPL-2pTy0WCZoPQ-1; Thu, 22 Jun 2023 15:38:18 -0400
X-MC-Unique: loAzrIFVPL-2pTy0WCZoPQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9892495397cso241374366b.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 12:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687462696; x=1690054696;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uf7v6utVhvB9SDThVRGOmHwhlWU7bpbJmJ9KRenSJLo=;
 b=hk63exXCdn7z21LubeId0jbAUeBiVPqyjacYcovjROSj8xnsj/5yDo6BGPcAB6ChTD
 msvNkuzzR9ainsoyfNl38WvH0FA7mnnhdkgtKNUp7PAsoNQUlgMKCWzr/IoAXod8/fn6
 3z0em4x8N9LehGRC/V6cwdnJeQapnskmrylR21c00yc7OT1UhwaMOBxjk1bujxPnxMaz
 mJz6naGYezUe6zNFkgfmybbJWFsr9X9lw7CzKHNGKw4LtZaB/23xfuTTevWiIFUXeNrO
 YrJwaGc02cpiZx9twrrptgoIbYz5sTBeyOzOGThb+uOFvSFdDgEMXS0wAvMNXKO9qNhb
 PpjA==
X-Gm-Message-State: AC+VfDwlhqqil9S7q8w8RZJW/ue4QP/lxxQym6Vq3W/sS8p8JvyZtnmY
 hmPNxkkRzNa97axGKxlompjTP3c/83WTnBd4toF5mD7odatNebNEO/kYBs25/iL6tr+t2IDbDpw
 kqmdR5GZvc2DglEuTxZ4+qFmltSe3Fb5qS6JdZTnMAA==
X-Received: by 2002:a17:907:e87:b0:989:1cc5:24c with SMTP id
 ho7-20020a1709070e8700b009891cc5024cmr8386394ejc.16.1687462695941; 
 Thu, 22 Jun 2023 12:38:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Tcekwjt1TlaynLe0SBmlVyxRwtPA1ExOLueATh4jy/8kBynHnMzbZSusq5Pw1XgWlW0F1Vw==
X-Received: by 2002:a17:907:e87:b0:989:1cc5:24c with SMTP id
 ho7-20020a1709070e8700b009891cc5024cmr8386370ejc.16.1687462695588; 
 Thu, 22 Jun 2023 12:38:15 -0700 (PDT)
Received: from redhat.com ([2.52.149.110]) by smtp.gmail.com with ESMTPSA id
 a14-20020a170906368e00b009829dc0f2a0sm5040174ejc.111.2023.06.22.12.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 12:38:15 -0700 (PDT)
Date: Thu, 22 Jun 2023 15:38:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v10 00/10] virtio core prepares for AF_XDP
Message-ID: <20230622153730-mutt-send-email-mst@kernel.org>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Fri, Jun 02, 2023 at 05:21:56PM +0800, Xuan Zhuo wrote:
> ## About DMA APIs
> 
> Now, virtio may can not work with DMA APIs when virtio features do not have
> VIRTIO_F_ACCESS_PLATFORM.
> 
> 1. I tried to let DMA APIs return phy address by virtio-device. But DMA APIs just
>    work with the "real" devices.
> 2. I tried to let xsk support callballs to get phy address from virtio-net
>    driver as the dma address. But the maintainers of xsk may want to use dma-buf
>    to replace the DMA APIs. I think that may be a larger effort. We will wait
>    too long.
> 
> So rethinking this, firstly, we can support premapped-dma only for devices with
> VIRTIO_F_ACCESS_PLATFORM. In the case of af-xdp, if the users want to use it,
> they have to update the device to support VIRTIO_F_RING_RESET, and they can also
> enable the device's VIRTIO_F_ACCESS_PLATFORM feature.
> 
> Thanks for the help from Christoph.
> 
> =================
> 
> XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> copy feature of xsk (XDP socket) needs to be supported by the driver. The
> performance of zero copy is very good.
> 
> ENV: Qemu with vhost.
> 
>                    vhost cpu | Guest APP CPU |Guest Softirq CPU | PPS
> -----------------------------|---------------|------------------|------------
> xmit by sockperf:     90%    |   100%        |                  |  318967
> xmit by xsk:          100%   |   30%         |   33%            | 1192064
> recv by sockperf:     100%   |   68%         |   100%           |  692288
> recv by xsk:          100%   |   33%         |   43%            |  771670
> 
> Before achieving the function of Virtio-Net, we also have to let virtio core
> support these features:

So by itself, this doesn't do this. But what effect does all this
overhead have on performance?

> 1. virtio core support premapped
> 2. virtio core support reset per-queue
> 3. introduce DMA APIs to virtio core
> 
> Please review.
> 
> Thanks.
> 
> v10:
>  1. support to set vq to premapped mode, then the vq just handles the premapped request.
>  2. virtio-net support to do dma mapping in advance
> 
> v9:
>  1. use flag to distinguish the premapped operations. no do judgment by sg.
> 
> v8:
>  1. vring_sg_address: check by sg_page(sg) not dma_address. Because 0 is a valid dma address
>  2. remove unused code from vring_map_one_sg()
> 
> v7:
>  1. virtqueue_dma_dev() return NULL when virtio is without DMA API.
> 
> v6:
>  1. change the size of the flags to u32.
> 
> v5:
>  1. fix for error handler
>  2. add flags to record internal dma mapping
> 
> v4:
>  1. rename map_inter to dma_map_internal
>  2. fix: Excess function parameter 'vq' description in 'virtqueue_dma_dev'
> 
> v3:
>  1. add map_inter to struct desc state to reocrd whether virtio core do dma map
> 
> v2:
>  1. based on sgs[0]->dma_address to judgment is premapped
>  2. based on extra.addr to judgment to do unmap for no-indirect desc
>  3. based on indir_desc to judgment to do unmap for indirect desc
>  4. rename virtqueue_get_dma_dev to virtqueue_dma_dev
> 
> v1:
>  1. expose dma device. NO introduce the api for dma and sync
>  2. split some commit for review.
> 
> 
> 
> 
> Xuan Zhuo (10):
>   virtio_ring: put mapping error check in vring_map_one_sg
>   virtio_ring: introduce virtqueue_set_premapped()
>   virtio_ring: split: support add premapped buf
>   virtio_ring: packed: support add premapped buf
>   virtio_ring: split-detach: support return dma info to driver
>   virtio_ring: packed-detach: support return dma info to driver
>   virtio_ring: introduce helpers for premapped
>   virtio_ring: introduce virtqueue_dma_dev()
>   virtio_ring: introduce virtqueue_add_sg()
>   virtio_net: support dma premapped
> 
>  drivers/net/virtio_net.c     | 163 ++++++++++--
>  drivers/virtio/virtio_ring.c | 493 +++++++++++++++++++++++++++++++----
>  include/linux/virtio.h       |  34 +++
>  3 files changed, 612 insertions(+), 78 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
