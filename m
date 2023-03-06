Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C4FC61DA4
	for <virtualization@archiver.kernel.org>; Mon,  6 Mar 2023 17:58:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87F4381926;
	Mon,  6 Mar 2023 17:58:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 87F4381926
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cB69Ptuj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h9ZF3luSvpYm; Mon,  6 Mar 2023 17:58:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 06A9880EAB;
	Mon,  6 Mar 2023 17:58:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06A9880EAB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3A72C0035;
	Mon,  6 Mar 2023 17:58:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D235C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 17:58:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 66E1360FA7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 17:58:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 66E1360FA7
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cB69Ptuj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 63WHI6Ll2BGd
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 17:58:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DDF9360F83
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DDF9360F83
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 17:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678125509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sha45Z6kxUfGCsHlDwTHYO9Fd2D72roLvFwFgZw/FPE=;
 b=cB69Ptujx/SMFbQ86i5Z7WbkbHRq3+GepNpGTFGVQg8vGSt0VF503iFkRQ6Z8M22xjMvUW
 2vaP+LkY1UHB4vVlOtqoGV85HudoECZZmYr0i8EfLyQuzEpfQjDd6odUdNV6jYXYDdRy0v
 Ak0zvJ/zLfv760nQi5Sksw35IydVjvc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-SeHeMSwYPbGDvBmpYQMI7w-1; Mon, 06 Mar 2023 12:58:28 -0500
X-MC-Unique: SeHeMSwYPbGDvBmpYQMI7w-1
Received: by mail-wm1-f70.google.com with SMTP id
 k26-20020a05600c0b5a00b003dfe4bae099so4077098wmr.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Mar 2023 09:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678125507;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sha45Z6kxUfGCsHlDwTHYO9Fd2D72roLvFwFgZw/FPE=;
 b=HveaOpfCHV0jrfvm7rmUk1tUUtQCtvrgrSDonu4Xm0Gc2OK2VKirA5cl9ZGIC47Y3h
 OxNlz3Rln1sBwPzdeB++M1E7i344YbS/DX8k+em6Z4AwpTCPVlXs1rpqtKW13mD2sGzG
 xEQJ6oBm/dlWEdsAf5+acvI+65eduHc1QidItaf0ghWcC2doE6jB9cKkKSlo6B9B81Xx
 iB6Inq1c56StCDitJxaWYYJQyzC/gmE/XfNmF8GVTFK6l6SUYWkGsd8iMFQs1exi8G2U
 7aKwcAI4aNkmMEQfLntEBRHui7M46ht4lqQGu05ul8qD1zb1fPBJ/n9PbTZLNqFzJ6Dr
 PX6A==
X-Gm-Message-State: AO0yUKUMACiilvWydCfvBllySDz7xz+gKi12PvWNG8nt/CcZ69TlAivn
 BNVm77TZp+LZrFPLYAsoxH0MSFSDvMA8JKd6vQB7Cs0ifFinZx+QXpQhE3TkC8cW3g291GLyfcl
 RpLMAK6Vb48dg/KTRITDoXZVYj/w7sOL76iaX4tAc2g==
X-Received: by 2002:a5d:4c4b:0:b0:2c9:3955:3948 with SMTP id
 n11-20020a5d4c4b000000b002c939553948mr7190648wrt.70.1678125507608; 
 Mon, 06 Mar 2023 09:58:27 -0800 (PST)
X-Google-Smtp-Source: AK7set/ZqnKJ/0nA9TbgFwZk42oznbVt+r2kcV8jDYft1m0CV33kw5zk5T7j0SazRpSbiKjkf+BORw==
X-Received: by 2002:a5d:4c4b:0:b0:2c9:3955:3948 with SMTP id
 n11-20020a5d4c4b000000b002c939553948mr7190630wrt.70.1678125507339; 
 Mon, 06 Mar 2023 09:58:27 -0800 (PST)
Received: from redhat.com ([2.52.23.160]) by smtp.gmail.com with ESMTPSA id
 c10-20020adffb0a000000b002ce72cff2ecsm849606wrr.72.2023.03.06.09.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Mar 2023 09:58:26 -0800 (PST)
Date: Mon, 6 Mar 2023 12:58:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net 0/2] add checking sq is full inside xdp xmit
Message-ID: <20230306125742-mutt-send-email-mst@kernel.org>
References: <20230306041535.73319-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230306041535.73319-1-xuanzhuo@linux.alibaba.com>
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

On Mon, Mar 06, 2023 at 12:15:33PM +0800, Xuan Zhuo wrote:
> If the queue of xdp xmit is not an independent queue, then when the xdp
> xmit used all the desc, the xmit from the __dev_queue_xmit() may encounter
> the following error.
> 
> net ens4: Unexpected TXQ (0) queue failure: -28
> 
> This patch adds a check whether sq is full in XDP Xmit.
> 
> Thanks.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

needed for stable?

> Xuan Zhuo (2):
>   virtio_net: separate the logic of checking whether sq is full
>   virtio_net: add checking sq is full inside xdp xmit
> 
>  drivers/net/virtio_net.c | 78 ++++++++++++++++++++++++----------------
>  1 file changed, 47 insertions(+), 31 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
