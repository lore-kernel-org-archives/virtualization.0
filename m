Return-Path: <SRS0=lx0b=J6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71370C43460
	for <virtualization@archiver.kernel.org>; Mon,  3 May 2021 08:00:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93D0610C9
	for <virtualization@archiver.kernel.org>; Mon,  3 May 2021 08:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93D0610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 590BA40003;
	Mon,  3 May 2021 08:00:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h8AHvsEsFfKE; Mon,  3 May 2021 08:00:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id E7F6B40267;
	Mon,  3 May 2021 07:59:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF00CC000E;
	Mon,  3 May 2021 07:59:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA0BFC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 07:59:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E5514404AD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 07:59:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C2s-XcZAZ99i
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 07:59:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4F8B5404A5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 07:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620028795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bl/2ZSTX8uMrXqSmi7rgld0irgeLphGdm6TYit7LvXQ=;
 b=bVt+XJLo+T9U64cvYnmqoo68EaZLbh4spSkG9iDEYgbV5KG9Sv7S/nE22iHUui9bsKJWXK
 s1ZCwHoPwHhj0/9L9nrvU+vP7XKwaCkhuhbNyU3tYRNxjk38a56tXyv24pEu9jXFvaowai
 +zDlbd8JPtmyi9n2XNEsyG2vf+Z+hLY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-_gIyQtePPqak4wccvQVYUg-1; Mon, 03 May 2021 03:59:53 -0400
X-MC-Unique: _gIyQtePPqak4wccvQVYUg-1
Received: by mail-wr1-f72.google.com with SMTP id
 a7-20020adfc4470000b029010d875c66edso3431105wrg.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 May 2021 00:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Bl/2ZSTX8uMrXqSmi7rgld0irgeLphGdm6TYit7LvXQ=;
 b=aduHZFQHr9cPfOKnfVhL/kgeCpahdqA9K5GjVZChGtqd01JXk0nDZmM//55RDtGElv
 s+mjslRLu9tiG2z58UeiCzk9mbVJO2vefagRmGL4yTM1e4K5JvbiLQPqt0WvUg+rQXlt
 DawOTNRHKb0tEe1OvYCvYOuoq3Fx/IDcOFSSECJr7gALKtfo6i5mrfeMFKmGN4fix3r6
 CIZo5kgxTpQ6ACDBXB3Nr7Mhdt8yTv1ToKRPGLw7bjmCesM7zpz6Gy7fTTJxc7WExS5B
 Rmwq54P+SELItrg3TpOOoiAo4hRfNlMhSHy1nExkmWilof4ZnVzxg6n4L3L1I1r3I0Qt
 p8kQ==
X-Gm-Message-State: AOAM530kFoLUFaT00Q3o6hl4c+tlXh95ifCdbMCM4FLn6tg4+2jffpCw
 7oSO6vYRY/BhVNFJcX4OR2B6bVmcXrtdLj34tOx2au7IGm/8pR9PXj+4JOVoJiGuX1Un+HprTze
 LlkfmCz/NYeZtvFYIMiQwX/LFZ7br4Cc0ttjvzUfygQ==
X-Received: by 2002:adf:ffc4:: with SMTP id x4mr22751596wrs.415.1620028792119; 
 Mon, 03 May 2021 00:59:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCffXa6+dAVz5L8aMFmIueQzxjfgmT/aHs6Ms5LyRCC+jspoSf9j339dcA7DinKdFvbJu8Fw==
X-Received: by 2002:adf:ffc4:: with SMTP id x4mr22751582wrs.415.1620028791994; 
 Mon, 03 May 2021 00:59:51 -0700 (PDT)
Received: from redhat.com ([2a10:800a:cdef:0:114d:2085:61e4:7b41])
 by smtp.gmail.com with ESMTPSA id u2sm12707675wmm.5.2021.05.03.00.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 May 2021 00:59:51 -0700 (PDT)
Date: Mon, 3 May 2021 03:59:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] virtio-net: fix use-after-free in skb_gro_receive
Message-ID: <20210503035920-mutt-send-email-mst@kernel.org>
References: <20210422151620.58204-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20210422151620.58204-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

On Thu, Apr 22, 2021 at 11:16:20PM +0800, Xuan Zhuo wrote:
> When "headroom" > 0, the actual allocated memory space is the entire
> page, so the address of the page should be used when passing it to
> build_skb().
> 
> BUG: KASAN: use-after-free in skb_gro_receive (net/core/skbuff.c:4260)
> Write of size 16 at addr ffff88811619fffc by task kworker/u9:0/534
> CPU: 2 PID: 534 Comm: kworker/u9:0 Not tainted 5.12.0-rc7-custom-16372-gb150be05b806 #3382
> Hardware name: QEMU MSN2700, BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> Workqueue: xprtiod xs_stream_data_receive_workfn [sunrpc]
> Call Trace:
>  <IRQ>
> dump_stack (lib/dump_stack.c:122)
> print_address_description.constprop.0 (mm/kasan/report.c:233)
> kasan_report.cold (mm/kasan/report.c:400 mm/kasan/report.c:416)
> skb_gro_receive (net/core/skbuff.c:4260)
> tcp_gro_receive (net/ipv4/tcp_offload.c:266 (discriminator 1))
> tcp4_gro_receive (net/ipv4/tcp_offload.c:316)
> inet_gro_receive (net/ipv4/af_inet.c:1545 (discriminator 2))
> dev_gro_receive (net/core/dev.c:6075)
> napi_gro_receive (net/core/dev.c:6168 net/core/dev.c:6198)
> receive_buf (drivers/net/virtio_net.c:1151) virtio_net
> virtnet_poll (drivers/net/virtio_net.c:1415 drivers/net/virtio_net.c:1519) virtio_net
> __napi_poll (net/core/dev.c:6964)
> net_rx_action (net/core/dev.c:7033 net/core/dev.c:7118)
> __do_softirq (./arch/x86/include/asm/jump_label.h:25 ./include/linux/jump_label.h:200 ./include/trace/events/irq.h:142 kernel/softirq.c:346)
> irq_exit_rcu (kernel/softirq.c:221 kernel/softirq.c:422 kernel/softirq.c:434)
> common_interrupt (arch/x86/kernel/irq.c:240 (discriminator 14))
> </IRQ>
> 
> Fixes: fb32856b16ad ("virtio-net: page_to_skb() use build_skb when there's sufficient tailroom")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reported-by: Ido Schimmel <idosch@nvidia.com>
> Tested-by: Ido Schimmel <idosch@nvidia.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 74d2d49264f3..7fda2ae4c40f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -387,7 +387,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  	unsigned int copy, hdr_len, hdr_padded_len;
>  	struct page *page_to_free = NULL;
>  	int tailroom, shinfo_size;
> -	char *p, *hdr_p;
> +	char *p, *hdr_p, *buf;
>  
>  	p = page_address(page) + offset;
>  	hdr_p = p;
> @@ -403,11 +403,15 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  	 * space are aligned.
>  	 */
>  	if (headroom) {
> -		/* The actual allocated space size is PAGE_SIZE. */
> +		/* Buffers with headroom use PAGE_SIZE as alloc size,
> +		 * see add_recvbuf_mergeable() + get_mergeable_buf_len()
> +		 */
>  		truesize = PAGE_SIZE;
>  		tailroom = truesize - len - offset;
> +		buf = page_address(page);
>  	} else {
>  		tailroom = truesize - len;
> +		buf = p;
>  	}
>  
>  	len -= hdr_len;
> @@ -416,11 +420,13 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  
>  	shinfo_size = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  
> +	/* copy small packet so we can reuse these pages */
>  	if (!NET_IP_ALIGN && len > GOOD_COPY_LEN && tailroom >= shinfo_size) {
> -		skb = build_skb(p, truesize);
> +		skb = build_skb(buf, truesize);
>  		if (unlikely(!skb))
>  			return NULL;
>  
> +		skb_reserve(skb, p - buf);
>  		skb_put(skb, len);
>  		goto ok;
>  	}
> -- 
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
