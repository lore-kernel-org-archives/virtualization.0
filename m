Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB16C4332F
	for <virtualization@archiver.kernel.org>; Mon, 17 Oct 2022 20:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30F7B60AAF;
	Mon, 17 Oct 2022 20:10:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30F7B60AAF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wj+6L4Df
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fMoKd65Bq9aZ; Mon, 17 Oct 2022 20:09:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1E4AC605EA;
	Mon, 17 Oct 2022 20:09:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E4AC605EA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5A58C0032;
	Mon, 17 Oct 2022 20:09:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83832C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 20:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5612F408D5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 20:09:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5612F408D5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wj+6L4Df
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WQ48aydIqSG5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 20:09:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 38266408CD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 38266408CD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 20:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666037393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tFELe6aznTe/GTRkqn1WfamvdAxLX3z1de1HiNewbYI=;
 b=Wj+6L4Df5q/feO9iFPD0eqllWcqqp64WwmwnuOXeaUrJuga50B0q285rL6Bnx1acwTp1GA
 nKS1rXTYTpcIovmvwk5Or0iAQoEqNNBOLTicIOVhr0ViWbai5/8xyWQ6KY0CTdc+KSMrIY
 pGWv+gCkhUZfDV9GXvNK/1+MUv8nRwQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-110-2ezeVbZpNJ6vgzL7n1rG5w-1; Mon, 17 Oct 2022 16:09:52 -0400
X-MC-Unique: 2ezeVbZpNJ6vgzL7n1rG5w-1
Received: by mail-ed1-f71.google.com with SMTP id
 z11-20020a056402274b00b0045ca9510fc8so10353152edd.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 13:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFELe6aznTe/GTRkqn1WfamvdAxLX3z1de1HiNewbYI=;
 b=VmG+QjsOfKSNeoW986o8j/ucFtFTgzT5ACxFUY0JdexpKMFlCzxv9VJ1HVQQ2NlEOu
 7khJzYrb28ms/T5JwLgeU3oZ6Kz1cEpzVtkLdSd8kQx0CnXBeSfF6dv6ffb14UV0HT5J
 Pq6gBF4GHowrjhVNUppQLhBpwhlFcXSGb65qk1m5CGRHNqBV5wy5FHo7DH1LC4zNBl5I
 FhBnZF5xMMa3A7kDBZVfGhBNpj/Tcs0e8J8Sh0JKZnJQRF5PQE3SdLqqY1XYfna+VvYZ
 6FwI5TgwajR7zWYIl2/Q2OSp23HMPLzrip53+2rNmeM4zQAmTWY8td2b6wpoAHulEBtD
 Uqxw==
X-Gm-Message-State: ACrzQf0HOOtVihGdtNI7jYNLbqfD2oarg3fNA35EMiDHWlapw68EJLTk
 kQUSsx4ny20oC3FRrAKMcamEE0Jl3GxXTPbqz2nZqSUQUiiH/Wj6DvWRpKKWcbBNaANowiVNf4k
 8AqFooW6sQRlb+EHULT5+LJRMid1H3guX6SdxBLJ73w==
X-Received: by 2002:a17:906:3852:b0:78d:b3d2:97a9 with SMTP id
 w18-20020a170906385200b0078db3d297a9mr9642352ejc.565.1666037390725; 
 Mon, 17 Oct 2022 13:09:50 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6Q6w0Yd3Ly3IvBoaGPiiCRRxkBu07y2HUssk6yJS+lWQ7Ff2UU9VnF10nTdkEX3BV7i7IJcA==
X-Received: by 2002:a17:906:3852:b0:78d:b3d2:97a9 with SMTP id
 w18-20020a170906385200b0078db3d297a9mr9642339ejc.565.1666037390474; 
 Mon, 17 Oct 2022 13:09:50 -0700 (PDT)
Received: from redhat.com ([2.54.172.104]) by smtp.gmail.com with ESMTPSA id
 y18-20020aa7d512000000b0044657ecfbb5sm7794413edq.13.2022.10.17.13.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Oct 2022 13:09:49 -0700 (PDT)
Date: Mon, 17 Oct 2022 16:09:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: add cond_resched() to the command
 waiting loop
Message-ID: <20221017160724-mutt-send-email-mst@kernel.org>
References: <20220905045341.66191-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220905045341.66191-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, gautam.dawar@xilinx.com, pabeni@redhat.com,
 davem@davemloft.net
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

On Mon, Sep 05, 2022 at 12:53:41PM +0800, Jason Wang wrote:
> Adding cond_resched() to the command waiting loop for a better
> co-operation with the scheduler. This allows to give CPU a breath to
> run other task(workqueue) instead of busy looping when preemption is
> not allowed.
> 
> What's more important. This is a must for some vDPA parent to work
> since control virtqueue is emulated via a workqueue for those parents.
> 
> Fixes: bda324fd037a ("vdpasim: control virtqueue support")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ece00b84e3a7..169368365d6a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2000,8 +2000,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>  	 * into the hypervisor, so the request should be handled immediately.
>  	 */
>  	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> -	       !virtqueue_is_broken(vi->cvq))
> +	       !virtqueue_is_broken(vi->cvq)) {
> +		cond_resched();
>  		cpu_relax();
> +	}
>  
>  	return vi->ctrl->status == VIRTIO_NET_OK;
>  }
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
