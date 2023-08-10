Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2139FC001DB
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 08:49:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82C4F611C9;
	Thu, 10 Aug 2023 08:49:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 82C4F611C9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a1511v8S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0IiHyfNLy1zG; Thu, 10 Aug 2023 08:49:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F26D76119B;
	Thu, 10 Aug 2023 08:49:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F26D76119B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2012C0072;
	Thu, 10 Aug 2023 08:49:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68B57C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 08:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3082E414A1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 08:49:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3082E414A1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=a1511v8S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id II2BEtmeREfg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 08:49:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 40A26400E7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 08:49:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 40A26400E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691657392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tr5wgmKh2lO7n8excjkJqlp64FQQtsDJMCPcsqi5jJ4=;
 b=a1511v8SNLPuL58gWvumAvDQwwKjEPfC0mRgaj2ZEbSXSr72N4+rF781G4nYNcRdy+iYxK
 FDzIPUuTS5jVp1NT+MWJnMV+VdVBAzy06F7hwSTpxEoaSLW0K9ID0YMCGalJWGi049VMIe
 LOWoslnha94Gebw6XCRsEUm5kGkKl+A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-8q73W_icP6yOBnu-4dxL7Q-1; Thu, 10 Aug 2023 04:49:50 -0400
X-MC-Unique: 8q73W_icP6yOBnu-4dxL7Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe57d0e11eso4117345e9.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 01:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691657389; x=1692262189;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tr5wgmKh2lO7n8excjkJqlp64FQQtsDJMCPcsqi5jJ4=;
 b=I8KS/GoBMUqqOTojUTEJSM3pwWpiQnTCt2kGaHhOdmCpSE/GvwmYmG8DREMt5wdpIF
 aJ8jXrXyHevBLgwnTTpRBzUEtOMW+ZoSDMhIeeraKpy3Hi6YDmyoztoFDKgGgJwK5/fc
 1wErXSBXVVPI50lcmXl/niEpk/cWSRyVMs2eznUr9BXFvLQC7uO53/I0VlHXzpowZO0c
 +w6Y/uMSC8rfSCAkVIYoiippXZVkekoRCQF9OsA27in7OA1G6/upaO/vSdtrv1A+ye8M
 c3BJkd0cltHwnJFH7qfhmErzvCy6Z1ss/2r/dbf4gxDRa+p3Lf0dHaXwke3MUkLJWHWj
 kUTA==
X-Gm-Message-State: AOJu0Yw4unjshPGoCKvTJIz00r/o3hxEGwhGPBvzNVvZtvkbmok/ovgz
 pK5nTD11x3BTWNTGxnf4R/SkCVY2lXBi+iat6MtGiUmTUBDtH1EisIGKbRogxu4oM7pY8PflI7E
 CYW2JnEQlM8YF7ysK5XKwb/tRvwzFW8x2WRjFKLdAQA==
X-Received: by 2002:a05:600c:2a53:b0:3fa:96db:7b7c with SMTP id
 x19-20020a05600c2a5300b003fa96db7b7cmr1355741wme.35.1691657389736; 
 Thu, 10 Aug 2023 01:49:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9G1uTIpyiFvUarklkAwC6rr28NspOp66gkgdxQBV3p3OYye0b+YHH4y0QncONpY4KIjuasg==
X-Received: by 2002:a05:600c:2a53:b0:3fa:96db:7b7c with SMTP id
 x19-20020a05600c2a5300b003fa96db7b7cmr1355731wme.35.1691657389380; 
 Thu, 10 Aug 2023 01:49:49 -0700 (PDT)
Received: from redhat.com ([2.52.137.93]) by smtp.gmail.com with ESMTPSA id
 n24-20020a7bcbd8000000b003fbb0c01d4bsm1439523wmi.16.2023.08.10.01.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 01:49:48 -0700 (PDT)
Date: Thu, 10 Aug 2023 04:49:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hawkins Jiawei <yin31149@gmail.com>
Subject: Re: [PATCH] virtio-net: Zero max_tx_vq field for
 VIRTIO_NET_CTRL_MQ_HASH_CONFIG case
Message-ID: <20230810044935-mutt-send-email-mst@kernel.org>
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

Fixes tag pls?

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
