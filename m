Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6325DC46467
	for <virtualization@archiver.kernel.org>; Mon, 16 Jan 2023 22:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E22DE60E64;
	Mon, 16 Jan 2023 22:13:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E22DE60E64
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WfpGZnRu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LyN8Q_3YmpAh; Mon, 16 Jan 2023 22:13:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 64D1B60B3F;
	Mon, 16 Jan 2023 22:13:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 64D1B60B3F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E1E2C0032;
	Mon, 16 Jan 2023 22:13:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76268C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 22:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5026F60DCA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 22:13:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5026F60DCA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bi_XRr5WUwsh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 22:13:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D2E960B3F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9D2E960B3F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 22:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673907190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SWmw6eIlLIrAqi6cPEzZVmLSGb1Pc0llD3aKiuwhdDA=;
 b=WfpGZnRuT+ZsbB7heT3GKpxh+sI6yqAomszsIftfMKf99cRScPKfTroFms55J+xzQx43Cf
 1mz9YA4BokBsjUms+jpCCm3u4lx6SrtXnfq8tZobMhjAetaVtR0ACdCj+faXh9u01IbfsY
 lF205GmbVG0IOVR8LtnYqkQ/hP9Uz7E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-495-4Wp40KTbMBe8ydWmQy3FYg-1; Mon, 16 Jan 2023 17:13:06 -0500
X-MC-Unique: 4Wp40KTbMBe8ydWmQy3FYg-1
Received: by mail-wm1-f72.google.com with SMTP id
 n9-20020a05600c3b8900b003d9f14e904eso13074107wms.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 14:13:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SWmw6eIlLIrAqi6cPEzZVmLSGb1Pc0llD3aKiuwhdDA=;
 b=4Uk8Hwofkopins0m+CPHhK5/sPV4CNo70o4cG4uAPVNN+tHCmaoxyz9fiZBQyyO7LA
 bbIHa3d2pcBzS3s+4Tb4GMnzW66m9PRtl7GQXU9f6auW+NbFMUSMoO0bT50aAMNqfmAv
 V2AbnpJvS/XQWPbXBl1VgELQWU7F7Etod7AE4sSIAiU4BnYm1yxTmDSsAkhLejuK2X5p
 Tb5eEyWsQ3Wr5ZxsaIDhjyTF0BDl5bF/4HPcD8X2OVdJ5oYQi8VhNbGyVTHfCiAtY6W5
 DEmDTcOvMKb/7WojYuviFeCWtQqTDtw3atgFnex852sUSpHFHrtML7iEhu+oO0OlAFpT
 ETrQ==
X-Gm-Message-State: AFqh2koylC/IRLd0KT4QXWKKfI+MtcdPHSw6DYFLeEjFFcuesIYzqraQ
 LPMG8f4DbyY2uFbW/meNO54IIO6AjR9JYW8le8pdUENIzdkt/41HDHCfWwM6HFtEa5djrs9atjg
 oObTf9BwHT5muAoRoJ+FJfiRIaqJtDAomzXWFZ3TPyg==
X-Received: by 2002:a05:6000:719:b0:2bd:f8db:faa1 with SMTP id
 bs25-20020a056000071900b002bdf8dbfaa1mr6528987wrb.32.1673907185685; 
 Mon, 16 Jan 2023 14:13:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsM9cWxKgdTjEDIlA9m69cdOjnGV43o/LVpzLBt4am3zkVVn7HYsM4jvEnJ8+X3Uszkr6VTeg==
X-Received: by 2002:a05:6000:719:b0:2bd:f8db:faa1 with SMTP id
 bs25-20020a056000071900b002bdf8dbfaa1mr6528973wrb.32.1673907185467; 
 Mon, 16 Jan 2023 14:13:05 -0800 (PST)
Received: from redhat.com ([2.52.132.216]) by smtp.gmail.com with ESMTPSA id
 n16-20020a5d4010000000b002bbed1388a5sm22007633wrp.15.2023.01.16.14.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jan 2023 14:13:04 -0800 (PST)
Date: Mon, 16 Jan 2023 17:13:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next v2] virtio_net: Reuse buffer free function
Message-ID: <20230116170550-mutt-send-email-mst@kernel.org>
References: <20230116202708.276604-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230116202708.276604-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
 pabeni@redhat.com, davem@davemloft.net
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

On Mon, Jan 16, 2023 at 10:27:08PM +0200, Parav Pandit wrote:
> virtnet_rq_free_unused_buf() helper function to free the buffer
> already exists. Avoid code duplication by reusing existing function.
> 
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7723b2a49d8e..31d037df514f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1251,13 +1251,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>  		pr_debug("%s: short packet %i\n", dev->name, len);
>  		dev->stats.rx_length_errors++;
> -		if (vi->mergeable_rx_bufs) {
> -			put_page(virt_to_head_page(buf));
> -		} else if (vi->big_packets) {
> -			give_pages(rq, buf);
> -		} else {
> -			put_page(virt_to_head_page(buf));
> -		}
> +		virtnet_rq_free_unused_buf(rq->vq, buf);
>  		return;
>  	}

Sure.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

while we are at it how about a patch moving
virtnet_rq_free_unused_buf and virtnet_sq_free_unused_buf so
we don't need forward declarations?

E.g. a good place for virtnet_sq_free_unused_buf is likely
after ptr_to_xdp group of functions.

For virtnet_rq_free_unused_buf - after give_pages/get_a_page.

>  
> -- 
> 2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
