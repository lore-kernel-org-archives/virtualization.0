Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A2BEB64DA
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 10:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57900409C9;
	Mon, 26 Jun 2023 10:59:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 57900409C9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BVkcQMUa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 83h6KdrQuVue; Mon, 26 Jun 2023 10:59:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B2D1340914;
	Mon, 26 Jun 2023 10:59:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B2D1340914
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F163C007A;
	Mon, 26 Jun 2023 10:59:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B616CC007A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 10:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82BC440995
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 10:59:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 82BC440995
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b_Tm0RYRV490
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 10:59:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 48AA340914
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 48AA340914
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 10:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687777155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yXfJyOWqEBeEpYhX2cTPTkoQq9Q43qmBhLD8fLh4bpw=;
 b=BVkcQMUa10rVsLefgnSjXWsbRdgpBcPWM8If2saXA+fRkDWqHTmZzmDSjEB71JygGxMLF8
 Kr/yVeECVIYEv1LKIojO6j0OhDAv46Ca0yn9RqAJw7cmTRZEIcoKZ4RdY0cn1YZ/Re22SX
 KFQIBWkNjTx9nqoVSbXzmuNBGmWAOXA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-OA2XLGgdMjmL4e2vWXysVw-1; Mon, 26 Jun 2023 06:59:14 -0400
X-MC-Unique: OA2XLGgdMjmL4e2vWXysVw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so15217455e9.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 03:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687777153; x=1690369153;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yXfJyOWqEBeEpYhX2cTPTkoQq9Q43qmBhLD8fLh4bpw=;
 b=A4k+R824Q3yfIiQB5oXPtx/IzNFRdAuK3x79Xf09D/WqPzNGs0yz4LiQtgk7dtxv5l
 6Lh9NrGi+56H2KRFvXU8VHUJ1VJnjzAeCgWyl7VffCY3xfsCAVgPAKaGfLgIum8VgBhn
 1y6ZvGuBbIsBQIhZCCHfiTVQlhIrozh8ZwQH9I2zioXo68GRD54zbns3H1RttKvfIMy1
 h8QPft/ihTMJbKc6L4Xo1F08mqvfkhmFrh9qzfZVxrqisl5yqAvGGrdJQ0WzLFFhf4Ib
 QJDYvjByERl+7EmogiDS47j6TC24tvlUKJSuajHCU94H7zvsUjx/ct21yCo8TBcgDKTo
 jYcQ==
X-Gm-Message-State: AC+VfDzAhBOAMYFr6wixHKaJ4aVGtSXUJsHNb9/UO/OkHVkOb/dZjZPP
 ZW8cJZ7SlHXaMSCNCtnsfAB76v7TdwNVnn+5IYW+Rq0ZeSOasdK9I7va05+ilJxVXsoLX9RT9G6
 h0urFu+BeLUJxAfN7n4BJ+Di/T3PabVheB3yDeeBfGg==
X-Received: by 2002:adf:f24c:0:b0:313:f152:d7f2 with SMTP id
 b12-20020adff24c000000b00313f152d7f2mr1562822wrp.36.1687777153333; 
 Mon, 26 Jun 2023 03:59:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4fjw6zVMUBlhWvbb5tDKN2R5NJeOpv92J240KhbR98FNxoowwQLPcOEEWKp8EXeaTIPBJXuA==
X-Received: by 2002:adf:f24c:0:b0:313:f152:d7f2 with SMTP id
 b12-20020adff24c000000b00313f152d7f2mr1562809wrp.36.1687777153061; 
 Mon, 26 Jun 2023 03:59:13 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 u13-20020a5d514d000000b0030e56a9ff25sm6981114wrt.31.2023.06.26.03.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 03:59:12 -0700 (PDT)
Date: Mon, 26 Jun 2023 06:59:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH 08/26] virtio-mem: use array_size
Message-ID: <20230626065202-mutt-send-email-mst@kernel.org>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-9-Julia.Lawall@inria.fr>
MIME-Version: 1.0
In-Reply-To: <20230623211457.102544-9-Julia.Lawall@inria.fr>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, keescook@chromium.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Fri, Jun 23, 2023 at 11:14:39PM +0200, Julia Lawall wrote:
> Use array_size to protect against multiplication overflows.
> 
> The changes were done using the following Coccinelle semantic patch:
> 
> // <smpl>
> @@
>     expression E1, E2;
>     constant C1, C2;
>     identifier alloc = {vmalloc,vzalloc};
> @@
>     
> (
>       alloc(C1 * C2,...)
> |
>       alloc(
> -           (E1) * (E2)
> +           array_size(E1, E2)
>       ,...)
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  drivers/virtio/virtio_mem.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

can't hurt I guess.

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 835f6cc2fb66..a4dfe7aab288 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -399,7 +399,7 @@ static int virtio_mem_bbm_bb_states_prepare_next_bb(struct virtio_mem *vm)
>  	if (vm->bbm.bb_states && old_pages == new_pages)
>  		return 0;
>  
> -	new_array = vzalloc(new_pages * PAGE_SIZE);
> +	new_array = vzalloc(array_size(new_pages, PAGE_SIZE));
>  	if (!new_array)
>  		return -ENOMEM;
>
> @@ -465,7 +465,7 @@ static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
>  	if (vm->sbm.mb_states && old_pages == new_pages)
>  		return 0;
>  
> -	new_array = vzalloc(new_pages * PAGE_SIZE);
> +	new_array = vzalloc(array_size(new_pages, PAGE_SIZE));
>  	if (!new_array)
>  		return -ENOMEM;
>  
> @@ -588,7 +588,7 @@ static int virtio_mem_sbm_sb_states_prepare_next_mb(struct virtio_mem *vm)
>  	if (vm->sbm.sb_states && old_pages == new_pages)
>  		return 0;
>  
> -	new_bitmap = vzalloc(new_pages * PAGE_SIZE);
> +	new_bitmap = vzalloc(array_size(new_pages, PAGE_SIZE));
>  	if (!new_bitmap)
>  		return -ENOMEM;
>  

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
