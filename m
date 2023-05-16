Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40EBC77B7F
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 20:54:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 16500400E5;
	Tue, 16 May 2023 20:54:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16500400E5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hgEkuInB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F4TTdPVPlMcw; Tue, 16 May 2023 20:54:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 81029403C8;
	Tue, 16 May 2023 20:54:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 81029403C8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65C4CC0036;
	Tue, 16 May 2023 20:54:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CF47C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 20:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 557DF41F5F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 20:54:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 557DF41F5F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hgEkuInB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w8goZqKF_tov
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 20:54:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D9F7F41F4D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D9F7F41F4D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 20:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684270486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Og0TjupE/ZMtNNnlGmkzvRqoScVtlzRc45CzTiUu08g=;
 b=hgEkuInBz83w/QPk4w3T/6aeqfjmY2A8lKOnm95/prBcyhOO7KDltuekIOJkd81QWKUZU+
 nEIldojLiJau9NrhkANLiz83w5DfhL6XWsmk+3OwrkYAHSV4XPg0ZqaiHQYz40TjUVS4Pq
 49hLzt/i0K397RjCUOG9Q4xg164UImY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-76y8dbh2Mcm0_4awAE_DHA-1; Tue, 16 May 2023 16:54:45 -0400
X-MC-Unique: 76y8dbh2Mcm0_4awAE_DHA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f426d4944fso92385e9.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 13:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684270484; x=1686862484;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Og0TjupE/ZMtNNnlGmkzvRqoScVtlzRc45CzTiUu08g=;
 b=BHVYfVVy4lazNghn5l1XwEzJpStbFcNYYYuGUJGMz6ftMBmG7lBPDezIJ84O25+8yF
 P37TKSzjzhFgRQ6u3n7r+HQJOxUrinE9ebq62N326V2ezWsi7L1tLlAmu1GWa7UzOkRd
 uuSe+fZJ2lE5z2jojfKpZD4zDnwEZW6rrEgjLBy8sA6DONfIBA7puG8S3pRs4zVFqFu6
 1iidtid0pgrtOTk+gBCn8Xm8+SOvkH4axbVIFPktz0de+b+PCp2zXMW/EE5vguzj+aoh
 nbTPEcoZNGV2Ui4+u0YSlfy44pj/ml3KC/WWq3aMJJ/Dy11CljoaFSIg7UVNDtGfmtBP
 KWdg==
X-Gm-Message-State: AC+VfDxXYgUUsHXZsB95IBb5K2kSnedqvXZAJztV9A1UWW6rtGB51Mf9
 YBKWzJIPCJx8AlgLeNDK2wjJQCJV4iyoEX7X9S7vPNa+N9RUEjpW7HWBUK7w9dmb8bQS/CZ2B1j
 Yz++iJhF7JQMBWHHaMjY1TzSGHaG3dgp+pSGz8YLQgA==
X-Received: by 2002:a7b:cb07:0:b0:3f1:7972:429d with SMTP id
 u7-20020a7bcb07000000b003f17972429dmr26839740wmj.18.1684270484101; 
 Tue, 16 May 2023 13:54:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5R9yvm854iVUUvoFgNHJv8grGlJ3OJzuwdg8sZzvpw6ibRSkIes59tngjTxXgLwdoqcq163A==
X-Received: by 2002:a7b:cb07:0:b0:3f1:7972:429d with SMTP id
 u7-20020a7bcb07000000b003f17972429dmr26839725wmj.18.1684270483729; 
 Tue, 16 May 2023 13:54:43 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:3448:6dd9:9d1c:f4ae:94f0])
 by smtp.gmail.com with ESMTPSA id
 x7-20020a1c7c07000000b003f182a10106sm77032wmc.8.2023.05.16.13.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 13:54:43 -0700 (PDT)
Date: Tue, 16 May 2023 16:54:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next V2 2/2] virtio-net: sleep instead of busy
 waiting for cvq command
Message-ID: <20230516165043-mutt-send-email-mst@kernel.org>
References: <20230413064027.13267-1-jasowang@redhat.com>
 <20230413064027.13267-3-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230413064027.13267-3-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, david.marchand@redhat.com, davem@davemloft.net
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

On Thu, Apr 13, 2023 at 02:40:27PM +0800, Jason Wang wrote:
> We used to busy waiting on the cvq command this tends to be
> problematic since there no way for to schedule another process which
> may serve for the control virtqueue. This might be the case when the
> control virtqueue is emulated by software. This patch switches to use
> completion to allow the CPU to sleep instead of busy waiting for the
> cvq command.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes since V1:
> - use completion for simplicity
> - don't try to harden the CVQ command which requires more thought
> Changes since RFC:
> - break the device when timeout
> - get buffer manually since the virtio core check more_used() instead
> ---
>  drivers/net/virtio_net.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2e56bbf86894..d3eb8fd6c9dc 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -19,6 +19,7 @@
>  #include <linux/average.h>
>  #include <linux/filter.h>
>  #include <linux/kernel.h>
> +#include <linux/completion.h>
>  #include <net/route.h>
>  #include <net/xdp.h>
>  #include <net/net_failover.h>
> @@ -295,6 +296,8 @@ struct virtnet_info {
>  
>  	/* failover when STANDBY feature enabled */
>  	struct failover *failover;
> +
> +	struct completion completion;
>  };
>  
>  struct padded_vnet_hdr {
> @@ -1709,6 +1712,13 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
>  	return !oom;
>  }
>  
> +static void virtnet_cvq_done(struct virtqueue *cvq)
> +{
> +	struct virtnet_info *vi = cvq->vdev->priv;
> +
> +	complete(&vi->completion);
> +}
> +
>  static void skb_recv_done(struct virtqueue *rvq)
>  {
>  	struct virtnet_info *vi = rvq->vdev->priv;
> @@ -2169,12 +2179,8 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>  	if (unlikely(!virtqueue_kick(vi->cvq)))
>  		return vi->ctrl->status == VIRTIO_NET_OK;
>  
> -	/* Spin for a response, the kick causes an ioport write, trapping
> -	 * into the hypervisor, so the request should be handled immediately.
> -	 */
> -	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> -	       !virtqueue_is_broken(vi->cvq))
> -		cpu_relax();
> +	wait_for_completion(&vi->completion);
> +	virtqueue_get_buf(vi->cvq, &tmp);
>  
>  	return vi->ctrl->status == VIRTIO_NET_OK;

This seems to break surprise removal and other
situations where vq gets broken since callbacks
aren't usually invoked then.


>  }
> @@ -3672,7 +3678,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  
>  	/* Parameters for control virtqueue, if any */
>  	if (vi->has_cvq) {
> -		callbacks[total_vqs - 1] = NULL;
> +		callbacks[total_vqs - 1] = virtnet_cvq_done;
>  		names[total_vqs - 1] = "control";
>  	}
>

There is a cost to this, in that we are burning an extra MSI vector
for the slow path cvq. if device has 3 vectors, suddenly we can't
allocate vectors for rx and tx, big problem.

So I'm afraid we need to pass a new flag that will share
the config changed interrupt and cvq.


  
> @@ -4122,6 +4128,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report)
>  		virtnet_init_default_rss(vi);
>  
> +	init_completion(&vi->completion);
>  	enable_rx_mode_work(vi);
>  
>  	/* serialize netdev register + virtio_device_ready() with ndo_open() */
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
