Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EEFC74A5B
	for <virtualization@archiver.kernel.org>; Thu, 30 Mar 2023 06:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 360C084125;
	Thu, 30 Mar 2023 06:18:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 360C084125
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gwX0tFhc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SCYhAtsMV78e; Thu, 30 Mar 2023 06:18:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9D3FC84122;
	Thu, 30 Mar 2023 06:17:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D3FC84122
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7198BC0036;
	Thu, 30 Mar 2023 06:17:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AA03C002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 06:17:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F86084125
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 06:17:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F86084125
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T1Z_QgtyX-jR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 06:17:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E2B6C84122
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E2B6C84122
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 06:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680157075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6xBOVpWxCK25mn4qE7KBnQ/szJiPX1gzHnLt3zUuvz0=;
 b=gwX0tFhc0G+R1VRbGYua9xSz1XY/V9IxWlDXoZn4T5pOlHhIp6VjH51fdnbvHuYx9NaWbK
 lAKGg+AgCP4oWn27Dn30vjWIFunqJdmHgDBggiHVPsZO07g7Y+1XGuS0OpT//qlh/ZWeJ7
 J+6tCfADSE0si4zcUlRvWJoRPq86X4c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-ygX0EUBJPFOIjYT9R1zcnQ-1; Thu, 30 Mar 2023 02:17:48 -0400
X-MC-Unique: ygX0EUBJPFOIjYT9R1zcnQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 j27-20020a05600c1c1b00b003edd2023418so9868610wms.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 23:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680157067;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6xBOVpWxCK25mn4qE7KBnQ/szJiPX1gzHnLt3zUuvz0=;
 b=fMpaYdeTD731EQ3/vD2lGK0OzETX5bu/qupwJTmXfej5bkvtwg9N+TxUsoFV7Ykppj
 4dQTH2CFOuvEGCunnthyczNWoXB1hXwLNB89zUXaYSdh/TM6v1pPkkoXoMfd5S+YNHn8
 f49QrsCgPYebffVfF91B4J+4OvLHLSpz66udoNIKJqtRDwWNAV8tCapkPX/Dc9T0/f2C
 e3USRXwZGwfCoMEh7iePxBf9zUHahxD/cGivEagkVq2qBeantLC8DiplXmQ9tqym171n
 NC8hcrdWCnMMTNQtyl/SxCPShAhFBnRkQ0K2Ljz1QouyKA/uz392srAgO0t9iClB91y7
 4icw==
X-Gm-Message-State: AAQBX9dRjVm6ckMk6mj8uy4v+GjW9u2V3c8pPyIHRGkaBCxGUeR57FeJ
 cgeheHRsiewIG6lwQyDMwZVRzZS2HkS2BLlHLOKSVtFJy9U+wuoEPXIfeEyquCzGC1imWg+I14B
 OHVL0lHLIFZhBSWvKkDdqDjF5jhzyvMR6XrJKZUjL6A==
X-Received: by 2002:adf:e401:0:b0:2d4:896:a204 with SMTP id
 g1-20020adfe401000000b002d40896a204mr16043750wrm.60.1680157067616; 
 Wed, 29 Mar 2023 23:17:47 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZWrzkHbAP6BkiUUe9yyebCiunrV4M5BvT7N+wH2ZkjcjHW/6tNcTYFjDHgUDimgRCyWS3QsQ==
X-Received: by 2002:adf:e401:0:b0:2d4:896:a204 with SMTP id
 g1-20020adfe401000000b002d40896a204mr16043735wrm.60.1680157067244; 
 Wed, 29 Mar 2023 23:17:47 -0700 (PDT)
Received: from redhat.com ([2.52.159.107]) by smtp.gmail.com with ESMTPSA id
 p5-20020adfce05000000b002d64fcb362dsm26643606wrn.111.2023.03.29.23.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Mar 2023 23:17:46 -0700 (PDT)
Date: Thu, 30 Mar 2023 02:17:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 00/16] virtio-net: split virtio-net.c
Message-ID: <20230330015412-mutt-send-email-mst@kernel.org>
References: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
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

On Tue, Mar 28, 2023 at 05:28:31PM +0800, Xuan Zhuo wrote:
> Considering the complexity of virtio-net.c and the new features we want
> to add, it is time to split virtio-net.c into multiple independent
> module files.
> 
> This is beneficial to the maintenance and adding new functions.
> 
> And AF_XDP support will be added later, then a separate xsk.c file will
> be added.
> 
> This patchset split virtio-net.c into these parts:
> 
> * virtnet.c:         virtio net device ops (napi, tx, rx, device ops, ...)
> * virtnet_common.c:  virtio net common code
> * virtnet_ethtool.c: virtio net ethtool callbacks
> * virtnet_ctrl.c:    virtio net ctrl queue command APIs
> * virtnet_virtio.c:  virtio net virtio callbacks/ops (driver register, virtio probe, virtio free, ...)
> 
> Please review.
> 
> Thanks.


I don't feel this is an improvement as presented, will need more work
to make code placement more logical.

For example where do I find code to update rq stats?
Rx data path should be virtnet.c?
No it's in virtnet_ethtool.c because rq stats can be
accessed by ethtool.
A bunch of stuff seems to be in headers just because of technicalities.
virtio common seems to be a dumping ground with no guiding principle at
all.
drivers/net/virtio/virtnet_virtio.c is weird with
virt repeated three times in the path.

These things only get murkier with time, at the point of reorg
I would expect very logical placement, since
without clear guiding rule finding where something is becomes harder but
more importantly we'll now get endless heartburn about where does each new
function go.


The reorg is unfortunately not free - for example git log --follow will
no longer easily match virtio because --follow works with exactly one
path.  It's now also extra work to keep headers self-consistent.
So it better be a big improvement to be worth it.




> Xuan Zhuo (16):
>   virtio_net: add a separate directory for virtio-net
>   virtio_net: move struct to header file
>   virtio_net: add prefix to the struct inside header file
>   virtio_net: separating cpu-related funs
>   virtio_net: separate virtnet_ctrl_set_queues()
>   virtio_net: separate virtnet_ctrl_set_mac_address()
>   virtio_net: remove lock from virtnet_ack_link_announce()
>   virtio_net: separating the APIs of cq
>   virtio_net: introduce virtnet_rq_update_stats()
>   virtio_net: separating the funcs of ethtool
>   virtio_net: introduce virtnet_dev_rx_queue_group()
>   virtio_net: introduce virtnet_get_netdev()
>   virtio_net: prepare for virtio
>   virtio_net: move virtnet_[en/dis]able_delayed_refill to header file
>   virtio_net: add APIs to register/unregister virtio driver
>   virtio_net: separating the virtio code
> 
>  MAINTAINERS                                   |    2 +-
>  drivers/net/Kconfig                           |    8 +-
>  drivers/net/Makefile                          |    2 +-
>  drivers/net/virtio/Kconfig                    |   11 +
>  drivers/net/virtio/Makefile                   |   10 +
>  .../net/{virtio_net.c => virtio/virtnet.c}    | 2368 ++---------------
>  drivers/net/virtio/virtnet.h                  |  213 ++
>  drivers/net/virtio/virtnet_common.c           |  138 +
>  drivers/net/virtio/virtnet_common.h           |   14 +
>  drivers/net/virtio/virtnet_ctrl.c             |  272 ++
>  drivers/net/virtio/virtnet_ctrl.h             |   45 +
>  drivers/net/virtio/virtnet_ethtool.c          |  578 ++++
>  drivers/net/virtio/virtnet_ethtool.h          |    8 +
>  drivers/net/virtio/virtnet_virtio.c           |  880 ++++++
>  drivers/net/virtio/virtnet_virtio.h           |    8 +
>  15 files changed, 2366 insertions(+), 2191 deletions(-)
>  create mode 100644 drivers/net/virtio/Kconfig
>  create mode 100644 drivers/net/virtio/Makefile
>  rename drivers/net/{virtio_net.c => virtio/virtnet.c} (50%)
>  create mode 100644 drivers/net/virtio/virtnet.h
>  create mode 100644 drivers/net/virtio/virtnet_common.c
>  create mode 100644 drivers/net/virtio/virtnet_common.h
>  create mode 100644 drivers/net/virtio/virtnet_ctrl.c
>  create mode 100644 drivers/net/virtio/virtnet_ctrl.h
>  create mode 100644 drivers/net/virtio/virtnet_ethtool.c
>  create mode 100644 drivers/net/virtio/virtnet_ethtool.h
>  create mode 100644 drivers/net/virtio/virtnet_virtio.c
>  create mode 100644 drivers/net/virtio/virtnet_virtio.h
> 
> --
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
