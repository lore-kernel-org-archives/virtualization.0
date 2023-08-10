Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18645C001DB
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 08:52:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97CEA83BC3;
	Thu, 10 Aug 2023 08:52:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 97CEA83BC3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YcM4GJA+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6C_gA9HUnE8H; Thu, 10 Aug 2023 08:52:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1CF2E83BBB;
	Thu, 10 Aug 2023 08:52:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1CF2E83BBB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E59CCC0072;
	Thu, 10 Aug 2023 08:52:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A1E4C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 08:52:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1DD33611D1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 08:52:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1DD33611D1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YcM4GJA+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 20_SBcNyZmZV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 08:52:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 468A4611BF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 08:52:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 468A4611BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691657529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mcg6yJyopZb17WipDF8sP3EF15P+/x7wmZ52XLBWKYI=;
 b=YcM4GJA+80u7F/kkTQ9nB9qg21x21dADSu0z1+l/Tm8wTmebZmMUu8clmt0zBR+6fB0jx+
 zz65UHEnuP4G/D/D8Jlv7ufkiy7izrSClMDVUz1AjLC2paVQjmNlrkfdVrGKyBst6KvLN4
 WbHOw5iVrCPCjqF3I7yIwYNcE5lkCEY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-8qbr83cwMaGotYTeujl2hw-1; Thu, 10 Aug 2023 04:52:05 -0400
X-MC-Unique: 8qbr83cwMaGotYTeujl2hw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31800070d70so493355f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 01:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691657524; x=1692262324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mcg6yJyopZb17WipDF8sP3EF15P+/x7wmZ52XLBWKYI=;
 b=ZIwig1MTJXCWKwoj20ZSgbVDAeIyehP8j1KDOg38Mb/aYXfKRG+Z1e2IwPBmE1YuRL
 Yysrk37Y473Bny2d4HWzdY3MPJ98VkcUBRY00NQIAOhBFzAiLZJjRYYpy//KT1zsW88U
 ydT3skDMgeRRgPiGIoKKPtEvXnGKBtjFo3iFWXRqADcNV2kLRPuBvdVVCp4Ps+Mheziw
 kkzx/1ZWQ7SfhMx7OU4xmMPf2wXRjysnkrrUq8FRkS8NAeAn2ZK/WeP85Ffr+zZ3Oq5l
 qE9DN1ZsC2jcwynMM1kD7Vnfno36CNgqiCuNzof1VsADdHTebKBK2o26ebFRv2EcizeJ
 jAGQ==
X-Gm-Message-State: AOJu0YzJzV82ZcjLh4pkm47zdEBdXslU/A8Os13JWTThTuSn0V1V4fcX
 mCvuzVAZr2IDfKWUp0RUMNBwRHn521l44Dsk6KAQI1S6vj1XT7bArYsu0XWCzWlnXARjv3RSZlx
 0qWrxeysUlEvosBJ9XvJBs64X2d3QJACkrdjAZb6LaA==
X-Received: by 2002:a5d:44ca:0:b0:316:ef23:9276 with SMTP id
 z10-20020a5d44ca000000b00316ef239276mr1488197wrr.52.1691657524682; 
 Thu, 10 Aug 2023 01:52:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiGdAa8VcflNuUlj48JmkKBjjk2b+xwDOn+rC9BIlHGKctdobOOWlznGHUPPPPdtwLJAtjxA==
X-Received: by 2002:a5d:44ca:0:b0:316:ef23:9276 with SMTP id
 z10-20020a5d44ca000000b00316ef239276mr1488175wrr.52.1691657524329; 
 Thu, 10 Aug 2023 01:52:04 -0700 (PDT)
Received: from redhat.com ([2.52.137.93]) by smtp.gmail.com with ESMTPSA id
 k7-20020adfe3c7000000b003176c6e87b1sm1427032wrm.81.2023.08.10.01.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 01:52:03 -0700 (PDT)
Date: Thu, 10 Aug 2023 04:51:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hawkins Jiawei <yin31149@gmail.com>
Subject: Re: [PATCH] virtio-net: Zero max_tx_vq field for
 VIRTIO_NET_CTRL_MQ_HASH_CONFIG case
Message-ID: <20230810045106-mutt-send-email-mst@kernel.org>
References: <20230810031557.135557-1-yin31149@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20230810031557.135557-1-yin31149@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, Eric Dumazet <edumazet@google.com>, 18801353760@163.com,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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

On Thu, Aug 10, 2023 at 11:15:57AM +0800, Hawkins Jiawei wrote:
> Kernel uses `struct virtio_net_ctrl_rss` to save command-specific-data
> for both the VIRTIO_NET_CTRL_MQ_HASH_CONFIG and
> VIRTIO_NET_CTRL_MQ_RSS_CONFIG commands.
> 
> According to the VirtIO standard, "Field reserved MUST contain zeroes.
> It is defined to make the structure to match the layout of
> virtio_net_rss_config structure, defined in 5.1.6.5.7.".
> 
> Yet for the VIRTIO_NET_CTRL_MQ_HASH_CONFIG command case, the `max_tx_vq`
> field in struct virtio_net_ctrl_rss, which corresponds to the
> `reserved` field in struct virtio_net_hash_config, is not zeroed,
> thereby violating the VirtIO standard.
> 
> This patch solves this problem by zeroing this field in
> virtnet_init_default_rss().
> 
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>



Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Cc: Andrew Melnychenko <andrew@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>

And this is stable material I believe.



> ---
> 
> TestStep
> ========
> 1. Boot QEMU with one virtio-net-pci net device with `mq` and `hash`
> feature on, command line like:
>       -netdev tap,vhost=off,...
>       -device virtio-net-pci,mq=on,hash=on,...
> 
> 2. Trigger VIRTIO_NET_CTRL_MQ_HASH_CONFIG command in guest, command
> line like:
> 	ethtool -K eth0 rxhash on
> 
> Without this patch, in virtnet_commit_rss_command(), we can see the
> `max_tx_vq` field is 1 in gdb like below:
> 
> 	pwndbg> p vi->ctrl->rss
> 	$1 = {
> 	  hash_types = 63,
> 	  indirection_table_mask = 0,
> 	  unclassified_queue = 0,
> 	  indirection_table = {0 <repeats 128 times>},
> 	  max_tx_vq = 1,
> 	  hash_key_length = 40 '(',
> 	  ...
> 	}
> 
> With this patch, in virtnet_commit_rss_command(), we can see the
> `max_tx_vq` field is 0 in gdb like below:
> 
> 	pwndbg> p vi->ctrl->rss
> 	$1 = {
> 	  hash_types = 63,
> 	  indirection_table_mask = 0,
> 	  unclassified_queue = 0,
> 	  indirection_table = {0 <repeats 128 times>},
> 	  max_tx_vq = 0,
> 	  hash_key_length = 40 '(',
> 	  ...
> 	}
> 
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1270c8d23463..8db38634ae82 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2761,7 +2761,7 @@ static void virtnet_init_default_rss(struct virtnet_info *vi)
>  		vi->ctrl->rss.indirection_table[i] = indir_val;
>  	}
>  
> -	vi->ctrl->rss.max_tx_vq = vi->curr_queue_pairs;
> +	vi->ctrl->rss.max_tx_vq = vi->has_rss ? vi->curr_queue_pairs : 0;
>  	vi->ctrl->rss.hash_key_length = vi->rss_key_size;
>  
>  	netdev_rss_key_fill(vi->ctrl->rss.key, vi->rss_key_size);
> -- 
> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
