Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C112EC6FD18
	for <virtualization@archiver.kernel.org>; Tue, 18 Apr 2023 11:49:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45917613AD;
	Tue, 18 Apr 2023 11:49:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 45917613AD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RThcin/4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vnkq4vxxu8pu; Tue, 18 Apr 2023 11:49:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BB00760F36;
	Tue, 18 Apr 2023 11:49:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB00760F36
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92B8BC007A;
	Tue, 18 Apr 2023 11:49:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2D13C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 11:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 865D2402E0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 11:49:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 865D2402E0
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RThcin/4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3y2hd7wz95_N
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 11:49:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A5B1A4012D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A5B1A4012D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 11:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681818578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXvHe+hqlmu93yWIU70NYfBDF1m9Fy56L1Ru9xyKRuE=;
 b=RThcin/4KW/yBy0pqcpWPaHPVdBDH/5uFAgmbpMlNsxA4hx8V1ZjWIOPf2KGhB3sOpoI3v
 eC4JSYQkU4E5XxsCOIZoIshM7mEkFWAtkJBCE/xr6X5qN5GefFpfKGL1Buz1s9OBQ33Uyu
 oe36uSEQU0eTDJ/YPSZuOLHWFMjOViE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-mX2UxZ3BOh2O732EtTgAhQ-1; Tue, 18 Apr 2023 07:49:35 -0400
X-MC-Unique: mX2UxZ3BOh2O732EtTgAhQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-2ef39671038so687180f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 04:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681818574; x=1684410574;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZXvHe+hqlmu93yWIU70NYfBDF1m9Fy56L1Ru9xyKRuE=;
 b=YsrhZiWABsgFCXx8tyfQQtqPkAnYF0yx/VKjZJi2xOeUjMV4/rAXr+GTICxM27YZQ/
 1kb/GsARteN97I6GrZbnTadngoi+0KGs4TasAJqlA0/Hl9ypWez78385NODpWRlPJgaR
 9qX+EVBPRAsSTt4v9+vQF7gK/4o9S8Uz20YXPgoOPmOFvr+oEF3SIBzrwJc4plfu3K6L
 w5vmUGKTMH8fWfVAhYQ/Q+8Rx2ialb0N42odoFShtYky+wj+WG4afD9TbqXDa7YiXBv0
 1DFGt/roiBxEBnJ9+2gtW29lkqY2ZtZpvD9XgZ5ar2Q0Q/h4UFn0oNXzyS2nBvDa5mC4
 ai+w==
X-Gm-Message-State: AAQBX9fcMh4cy6+ooeS2nKSm0sXNzdyAMamQFP+4S2gOEhisPtC0ILlf
 b8yn4gWoEj5Cm3Cl14SjvZgGFiVslrbP40TI2yNXaHcCzS3tAZ1Yv4/WUCYdqSOTNeECwkKfQKV
 poF2xCSYHNgg3sKVeVKF+x8OU3jTdgZT3rXWgTdkZ/A==
X-Received: by 2002:adf:fc92:0:b0:2f9:338:743d with SMTP id
 g18-20020adffc92000000b002f90338743dmr1863030wrr.23.1681818574099; 
 Tue, 18 Apr 2023 04:49:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350aYOVN1Z2VSO4baE6EM1hNDxkNcLBVWEre5foX9c33S7tdTllckYbjKhI5GlVc4jsmMnSneYQ==
X-Received: by 2002:adf:fc92:0:b0:2f9:338:743d with SMTP id
 g18-20020adffc92000000b002f90338743dmr1863011wrr.23.1681818573765; 
 Tue, 18 Apr 2023 04:49:33 -0700 (PDT)
Received: from redhat.com ([2.52.136.129]) by smtp.gmail.com with ESMTPSA id
 a7-20020adfed07000000b002fb2782219esm3758368wro.3.2023.04.18.04.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Apr 2023 04:49:33 -0700 (PDT)
Date: Tue, 18 Apr 2023 07:49:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 00/14] virtio_net: refactor xdp codes
Message-ID: <20230418074911-mutt-send-email-mst@kernel.org>
References: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
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

On Tue, Apr 18, 2023 at 02:53:13PM +0800, Xuan Zhuo wrote:
> Due to historical reasons, the implementation of XDP in virtio-net is relatively
> chaotic. For example, the processing of XDP actions has two copies of similar
> code. Such as page, xdp_page processing, etc.
> 
> The purpose of this patch set is to refactor these code. Reduce the difficulty
> of subsequent maintenance. Subsequent developers will not introduce new bugs
> because of some complex logical relationships.
> 
> In addition, the supporting to AF_XDP that I want to submit later will also need
> to reuse the logic of XDP, such as the processing of actions, I don't want to
> introduce a new similar code. In this way, I can reuse these codes in the
> future.
> 
> Please review.
> 
> Thanks.

Big refactoring, pls allow a bit more time for review. Thanks!

> v2:
>     1. re-split to make review more convenient
> 
> v1:
>     1. fix some variables are uninitialized
> 
> Xuan Zhuo (14):
>   virtio_net: mergeable xdp: put old page immediately
>   virtio_net: introduce mergeable_xdp_prepare()
>   virtio_net: optimize mergeable_xdp_prepare()
>   virtio_net: introduce virtnet_xdp_handler() to seprate the logic of
>     run xdp
>   virtio_net: introduce xdp res enums
>   virtio_net: separate the logic of freeing xdp shinfo
>   virtio_net: separate the logic of freeing the rest mergeable buf
>   virtio_net: auto release xdp shinfo
>   virtio_net: introduce receive_mergeable_xdp()
>   virtio_net: merge: remove skip_xdp
>   virtio_net: introduce receive_small_xdp()
>   virtio_net: small: optimize code
>   virtio_net: small: optimize code
>   virtio_net: small: remove skip_xdp
> 
>  drivers/net/virtio_net.c | 625 +++++++++++++++++++++++----------------
>  1 file changed, 362 insertions(+), 263 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
