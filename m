Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A691CC433F5
	for <virtualization@archiver.kernel.org>; Wed, 30 Mar 2022 06:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3592F41C13;
	Wed, 30 Mar 2022 06:34:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5OH3Af2JjWYf; Wed, 30 Mar 2022 06:34:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6318841A0A;
	Wed, 30 Mar 2022 06:34:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 261CDC002C;
	Wed, 30 Mar 2022 06:34:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64D57C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:34:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3941240CAF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:34:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 60GCbhFpfkLu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:34:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 30AFA40CA2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648622038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8OnziqqDPw1UfFbV4aNhNoy1sEjtLc7+xQm5kwlL89c=;
 b=U0UC9k1bAML5Z84hwkSkF0ipoNUuHQqSbxRKgVkcBvgJMyopj4SHl8jsEzrmbj79bF6Mi0
 bpza1nWdBUjpU3eqLE6sxX6JKCKRFrZqLCHWZ0hJ3EtVJSAcpTbPvk/T/w1Rq8q45ULZjf
 mOFDUVvLUD7ia3M918hSm9i3Qyk4X5o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-jPjUAWFjM5ucHmT24tmP0g-1; Wed, 30 Mar 2022 02:33:57 -0400
X-MC-Unique: jPjUAWFjM5ucHmT24tmP0g-1
Received: by mail-wm1-f72.google.com with SMTP id
 c62-20020a1c3541000000b003815245c642so604597wma.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 23:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8OnziqqDPw1UfFbV4aNhNoy1sEjtLc7+xQm5kwlL89c=;
 b=gEyLQKK82NY6zKXSMkf2omfMo5xuQDi2c49gDooc9kQh/je2TMWCE9x10mwaQXVABf
 SXaGwj4zYYBT/JOcwoBljMDYqAlHWA/Cd+ZDXXxJgs6BLLbnI+hDW4kxng+xFTWica8u
 FCKe9bbneo6EyB2cQgUbsN7UVoy8a7h387K+ySoEwlaaa/LxwzlyZHYMiunzrJrIC0iB
 5E6wZUzNGYpA2iZXK5GMum7i3QlWj2lOw6rysy3Y/h8Z1k9Jl4E1VUmWlo4zg3kD80fu
 NAzPECouTIaeP1wNLc9VHH97lpZT15R1aa8DD21RP7F+ke6OH2OTK66361b0eyJIS+1n
 0iPw==
X-Gm-Message-State: AOAM532XsR0YYn6/EXBNjVPMtPB/SLIH23b/nrKV/+2JF8+WaUxYJ4BV
 eqniyYXAfkT3pGFS+Y0EMbS6JPJ/PFwrZYMYz7c2+IyZeK+Q+CdyEpok9YLgrzyhJsnZOx0WQeq
 XQH6B8wTGUMSwfB2RMIycPzKFOjZg8SD2oVokEiK/mA==
X-Received: by 2002:a05:6000:2cd:b0:204:1bf4:e4f8 with SMTP id
 o13-20020a05600002cd00b002041bf4e4f8mr35140126wry.682.1648622036278; 
 Tue, 29 Mar 2022 23:33:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ87E7eY3qwB6BZvYyIwH4cGmNeD8anl5BueTVKGjjkpvj4rb01CerNy1jhbIZHW0+Foa9Jw==
X-Received: by 2002:a05:6000:2cd:b0:204:1bf4:e4f8 with SMTP id
 o13-20020a05600002cd00b002041bf4e4f8mr35140106wry.682.1648622036067; 
 Tue, 29 Mar 2022 23:33:56 -0700 (PDT)
Received: from redhat.com ([2.52.9.207]) by smtp.gmail.com with ESMTPSA id
 y5-20020a1c4b05000000b0038cbf571334sm3731386wma.18.2022.03.29.23.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Mar 2022 23:33:54 -0700 (PDT)
Date: Wed, 30 Mar 2022 02:33:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 0/9] virtio: support advance DMA
Message-ID: <20220330023258-mutt-send-email-mst@kernel.org>
References: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

On Thu, Feb 24, 2022 at 07:03:53PM +0800, Xuan Zhuo wrote:
> virtqueue_add() only supports virtual addresses, dma is completed in
> virtqueue_add().
> 
> In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> it is necessary for us to support passing the DMA address to virtqueue_add().

I picked up a couple of patches. Others are waiting for some acks
(Jason?) and improved commit logs for documentation.

Thanks!

> v2:
>     1. rename predma -> premapped
>     2. virtio net xdp tx use virtio dma api
> 
> v1:
>    1. All sgs requested at one time are required to be unified PREDMA, and several
>       of them are not supported to be PREDMA
>    2. virtio_dma_map() is removed from this patch set and will be submitted
>       together with the next time AF_XDP supports virtio dma
>    3. Added patch #2 #3 to remove the check for flags when performing unmap
>       indirect desc
> 
> Xuan Zhuo (9):
>   virtio_ring: rename vring_unmap_state_packed() to
>     vring_unmap_extra_packed()
>   virtio_ring: remove flags check for unmap split indirect desc
>   virtio_ring: remove flags check for unmap packed indirect desc
>   virtio_ring: virtqueue_add() support premapped
>   virtio_ring: split: virtqueue_add_split() support premapped
>   virtio_ring: packed: virtqueue_add_packed() support premapped
>   virtio_ring: add api virtio_dma_map() for advance dma
>   virtio_ring: introduce virtqueue_add_outbuf_premapped()
>   virtio_net: xdp xmit use virtio dma api
> 
>  drivers/net/virtio_net.c     |  42 +++++-
>  drivers/virtio/virtio_ring.c | 280 ++++++++++++++++++++++++++---------
>  include/linux/virtio.h       |  12 ++
>  3 files changed, 254 insertions(+), 80 deletions(-)
> 
> --
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
