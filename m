Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2222C77B70
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 06:43:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 712684095A;
	Mon, 17 Apr 2023 06:43:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 712684095A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SfSaXI7i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3-dCeoLKnNgF; Mon, 17 Apr 2023 06:43:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3FD104093D;
	Mon, 17 Apr 2023 06:43:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3FD104093D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CE87C0037;
	Mon, 17 Apr 2023 06:43:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DED3C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:43:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B48C4092C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:43:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5B48C4092C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RWvmwANG8xj0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:43:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 09EDB4091C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 09EDB4091C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681713822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HU6O3KzfQ0zQunJtU8XAVLCiL1L8OjBQOXvK0FwCmb0=;
 b=SfSaXI7i9rolakEjO4owKe4TQSpiewGYwgn4phOkST6c0iDXFrCOJ9zBRZRFo2dUFyS5nY
 WEpGPSEQieH5MKV9yTv08M7ntAhfe7GghzrDabyjWU9CvDXogZ6utBlWdn152uLD7ctkUm
 EtD3h91YUA8n9pIqZ05FXWc/8Fhd45s=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-49NYjv2OMJ-oieuZa_wCjg-1; Mon, 17 Apr 2023 02:43:41 -0400
X-MC-Unique: 49NYjv2OMJ-oieuZa_wCjg-1
Received: by mail-qv1-f72.google.com with SMTP id
 j4-20020a0cc344000000b005e94fb0d2b0so10915876qvi.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Apr 2023 23:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681713821; x=1684305821;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HU6O3KzfQ0zQunJtU8XAVLCiL1L8OjBQOXvK0FwCmb0=;
 b=hNafaDLEnRDho5uD5oiY69G6G25td8nucs8puMW/9D8hwbwwFDI0tP2A7N0EJII0kj
 7w3a/zXH2GR1AIUIuUvSxAKo4HUM7/7EWB+nu7Gdkpwtdj5UqxEnpkQLTiXRQ50iaOQy
 5M2wUfP5J0XUEJAGjus0SlR5oDVOvGFwKrTENTmRJOj+M+ZrouNQjhK5B0aEy48lP5P2
 yGPRh8Yl7ky3Z46obAfhJBGzwmlKNggo/QgwhJ/t0xogtdocmtHIZan8il7NTVHnSzuF
 hpmZTfPcSs//cwvQfnEd4N9E56YzWptalgeEjEOaCsBkc2H60M3c5dZGEIEM+dw3eBgI
 XwgQ==
X-Gm-Message-State: AAQBX9chk5lcvqJ+zJGJ6UZotqtr2yHGtz8LEFeg+tJpIX3owpRiNZOf
 iVYvn8QkqKYrHLyLioYXWQ7WitNyo64E2i7x/gWtVr4VzRLWjCPb5lLiC6JvOdmYUsA++Eb4ssO
 9t54PclJrnC4JHXtMqKQm/WQaE1SNAPaBmQoKnqD+LA==
X-Received: by 2002:a05:622a:1756:b0:3bf:d8b6:4ca1 with SMTP id
 l22-20020a05622a175600b003bfd8b64ca1mr20925359qtk.28.1681713821387; 
 Sun, 16 Apr 2023 23:43:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350aze/kYu2ExuJQuREbYNzivfTsLWddfaCb28LVbISLKnDjQ8eKYMKUloj0ytrzWgoKdCDYq1w==
X-Received: by 2002:a05:622a:1756:b0:3bf:d8b6:4ca1 with SMTP id
 l22-20020a05622a175600b003bfd8b64ca1mr20925333qtk.28.1681713821133; 
 Sun, 16 Apr 2023 23:43:41 -0700 (PDT)
Received: from redhat.com ([185.199.103.251]) by smtp.gmail.com with ESMTPSA id
 ay43-20020a05620a17ab00b0074577e835f2sm2985905qkb.48.2023.04.16.23.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Apr 2023 23:43:40 -0700 (PDT)
Date: Mon, 17 Apr 2023 02:43:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] xsk: introduce xsk_dma_ops
Message-ID: <20230417024216-mutt-send-email-mst@kernel.org>
References: <20230417032750.7086-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230417032750.7086-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

On Mon, Apr 17, 2023 at 11:27:50AM +0800, Xuan Zhuo wrote:
> @@ -532,9 +545,9 @@ struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool)
>  	xskb->xdp.data_meta = xskb->xdp.data;
>  
>  	if (pool->dma_need_sync) {
> -		dma_sync_single_range_for_device(pool->dev, xskb->dma, 0,
> -						 pool->frame_len,
> -						 DMA_BIDIRECTIONAL);
> +		pool->dma_ops.sync_single_range_for_device(pool->dev, xskb->dma, 0,
> +							   pool->frame_len,
> +							   DMA_BIDIRECTIONAL);
>  	}
>  	return &xskb->xdp;
>  }
> @@ -670,15 +683,15 @@ EXPORT_SYMBOL(xp_raw_get_dma);
>  
>  void xp_dma_sync_for_cpu_slow(struct xdp_buff_xsk *xskb)
>  {
> -	dma_sync_single_range_for_cpu(xskb->pool->dev, xskb->dma, 0,
> -				      xskb->pool->frame_len, DMA_BIDIRECTIONAL);
> +	xskb->pool->dma_ops.sync_single_range_for_cpu(xskb->pool->dev, xskb->dma, 0,
> +						      xskb->pool->frame_len, DMA_BIDIRECTIONAL);
>  }
>  EXPORT_SYMBOL(xp_dma_sync_for_cpu_slow);
>  
>  void xp_dma_sync_for_device_slow(struct xsk_buff_pool *pool, dma_addr_t dma,
>  				 size_t size)
>  {
> -	dma_sync_single_range_for_device(pool->dev, dma, 0,
> -					 size, DMA_BIDIRECTIONAL);
> +	pool->dma_ops.sync_single_range_for_device(pool->dev, dma, 0,
> +						   size, DMA_BIDIRECTIONAL);
>  }
>  EXPORT_SYMBOL(xp_dma_sync_for_device_slow);

So you add an indirect function call on data path? Won't this be costly?

> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
