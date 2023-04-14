Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44F1C77B6E
	for <virtualization@archiver.kernel.org>; Fri, 14 Apr 2023 07:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2387B400FC;
	Fri, 14 Apr 2023 07:38:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2387B400FC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=glpkoFDP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id coN3CH3YvdxB; Fri, 14 Apr 2023 07:38:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 858F4400F8;
	Fri, 14 Apr 2023 07:38:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 858F4400F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C383C0036;
	Fri, 14 Apr 2023 07:38:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C06A1C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 07:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 888E3400FC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 07:38:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 888E3400FC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m9G23CnlLYWf
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 07:38:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CBE94400F8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CBE94400F8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 07:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681457923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lMIqjynha0lnhe23OoFWtNYm7T0bO0fGReoRZ9IdJV8=;
 b=glpkoFDPTQ3WbxNM6Rer3iskzi+SaflDFJXGiY8+/vurw81cypJntZblXnxKD2DQ4qkECW
 y9zlijC/ZTQwT64eDFWtUFFEAi39BOIYRTYzLQQsxY1YgRheyeQSESFTClsxFDYOxkejNh
 RysZbeuHKj02is0zlFtTikd6ztPS+9Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-letYI95ENHOPJIUaHdFXOQ-1; Fri, 14 Apr 2023 03:38:42 -0400
X-MC-Unique: letYI95ENHOPJIUaHdFXOQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 p4-20020a05600c468400b003f140953152so85419wmo.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 00:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681457921; x=1684049921;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lMIqjynha0lnhe23OoFWtNYm7T0bO0fGReoRZ9IdJV8=;
 b=SMf8rwfc9VMM1O71/Kv88UCqEddadynZtK7amZGzzw3Bly5D8ETvX+qbI83HUsIcbl
 nSl3Rs6beNPd12xN+WcuAiQ+x4SEyef5zoYkalqE7mdJe/i6l83iYMjB5DeNCeSqLtPH
 9YvF5Or73UihETl8DONIF8sBmsL77XcPidSmB3T/nmFPqF0xeK/fZk+u7vHWAkCvrrX0
 wC5pAx9OrshMLnudxfHUe/5lMA3c9FJJceFHIfhpgmgFQmaWX7+mrry07ZhBtctImXK1
 JxVk1urBTCBgFrgvOs0wiqwudpph2GvmcCQRRNPYCF1G8DKyfAjX81pfyiJw+F+C/ZVV
 eqmw==
X-Gm-Message-State: AAQBX9fyma8dDdiqGGNqSxCVedtny4q/WBlb2bRvLcIGdJiOaDBh7jdX
 4LYAyAPki1xoCQLntOWnSaBmRhuFFo+bXNEdR91c77AEpSESSc/ugxEKUjpYXZC5H4/iRXE735B
 4LegmNmb/dBm1G6Zyt8VvLWkVpt0B4bmFyH1Y3k8XZw==
X-Received: by 2002:a5d:688b:0:b0:2ef:ba74:663 with SMTP id
 h11-20020a5d688b000000b002efba740663mr3600351wru.27.1681457921246; 
 Fri, 14 Apr 2023 00:38:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350bKnQLs9BRa6pmx717Y3ZbnYozswFnfUPMxvV8w2vmX/ki/yiZdrxC+QHPU+hLN+NERHNjBdQ==
X-Received: by 2002:a5d:688b:0:b0:2ef:ba74:663 with SMTP id
 h11-20020a5d688b000000b002efba740663mr3600321wru.27.1681457920950; 
 Fri, 14 Apr 2023 00:38:40 -0700 (PDT)
Received: from redhat.com ([2a06:c701:742d:fd00:c847:221d:9254:f7ce])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a1ccc04000000b003f071466229sm3600005wmb.17.2023.04.14.00.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Apr 2023 00:38:40 -0700 (PDT)
Date: Fri, 14 Apr 2023 03:38:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v1] virtio_net: bugfix overflow inside
 xdp_linearize_page()
Message-ID: <20230414033826-mutt-send-email-mst@kernel.org>
References: <20230414060835.74975-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230414060835.74975-1-xuanzhuo@linux.alibaba.com>
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

On Fri, Apr 14, 2023 at 02:08:35PM +0800, Xuan Zhuo wrote:
> Here we copy the data from the original buf to the new page. But we
> not check that it may be overflow.
> 
> As long as the size received(including vnethdr) is greater than 3840
> (PAGE_SIZE -VIRTIO_XDP_HEADROOM). Then the memcpy will overflow.
> 
> And this is completely possible, as long as the MTU is large, such
> as 4096. In our test environment, this will cause crash. Since crash is
> caused by the written memory, it is meaningless, so I do not include it.
> 
> Fixes: 72979a6c3590 ("virtio_net: xdp, add slowpath case for non contiguous buffers")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v1:  add Fixes tag
> 
>  drivers/net/virtio_net.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2396c28c0122..ea1bd4bb326d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -814,8 +814,13 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>  				       int page_off,
>  				       unsigned int *len)
>  {
> -	struct page *page = alloc_page(GFP_ATOMIC);
> +	int tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +	struct page *page;
> +
> +	if (page_off + *len + tailroom > PAGE_SIZE)
> +		return NULL;
> 
> +	page = alloc_page(GFP_ATOMIC);
>  	if (!page)
>  		return NULL;
> 
> @@ -823,7 +828,6 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>  	page_off += *len;
> 
>  	while (--*num_buf) {
> -		int tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  		unsigned int buflen;
>  		void *buf;
>  		int off;
> --
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
