Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BCFCDB46E
	for <virtualization@archiver.kernel.org>; Thu, 12 Oct 2023 09:13:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49C2660F33;
	Thu, 12 Oct 2023 09:13:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 49C2660F33
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bIPkrXSa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5lEnqWDkvYZv; Thu, 12 Oct 2023 09:13:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B649860FAB;
	Thu, 12 Oct 2023 09:13:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B649860FAB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7945DC0071;
	Thu, 12 Oct 2023 09:13:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE8BAC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A4EA841695
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:13:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A4EA841695
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bIPkrXSa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mdoLjRlVbOad
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:13:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 386BC4154E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:13:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 386BC4154E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697101998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LilWhAMwJSNCjqPLdL8lOODHHHbgf2yQ5atXlvOll+E=;
 b=bIPkrXSa8j0nwxDTVN5NFrfVU6nOCSaQyCKHFAaQz0HO/8vfXYaPdsjFVk8fOnxF4icd+A
 Uts1fd0k71+zk/F03VNm7p5xfZK5sMQ4eNZ1Q/6VVs749+n+lhSvN5FA+2UavRCozjWlM0
 zEgROotJCkeEmRoHnhS9nB0cchyFUo4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-JQIHXBD_Mo-uWlHPKRolQw-1; Thu, 12 Oct 2023 05:13:16 -0400
X-MC-Unique: JQIHXBD_Mo-uWlHPKRolQw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32320b9d671so507136f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 02:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697101995; x=1697706795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LilWhAMwJSNCjqPLdL8lOODHHHbgf2yQ5atXlvOll+E=;
 b=Rs0aIVBmznqylkSonSkuxIo2jYclu67sG2ty3SU2uEotqhDAZ59yZOLxetKTlTPNV4
 T5Ccuehvw2f+1big9g9LMkGjzxEAW7oWq6+C7JBQfSOcnQL5ym9IQlbgdYuThU2EZWxt
 dsteRO2fPM0rfFy3C5yFDtagygCpkCigMEa46ZXPyf7Ptz6IS3LMPr1NG+O3/n/FRl6c
 VUNVIqrDKM9ytjpA9MJYCSsX/36bwBBSFxs6DArcgomDFnWMSHKIBAP0zPpBbaV89cYv
 nrsUPE2KTc76Twq2AzOnFT2keYEatArdK2QbMs/SiuW+wc+zbRQMBUwuxSJfBTWz+ktZ
 D4Eg==
X-Gm-Message-State: AOJu0YwHTSL8yG5srnqDZoutfuzJcHXTG5dlJELhaR8SZyE5DcQsItxN
 7ys0y/Ksu0GkQ0OMooai75w4/n2Hk5Vl6arjm8l7/HvWy6kLya7R5EraJEBGrXQ+WTkupvuFJNm
 Q18Bu7dVrr+3yycdY8mccVcTVboej8bSpnum1u5/Psg==
X-Received: by 2002:adf:f9cc:0:b0:31f:98b4:4b62 with SMTP id
 w12-20020adff9cc000000b0031f98b44b62mr18218347wrr.37.1697101995334; 
 Thu, 12 Oct 2023 02:13:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSpW0SO/rNFTY5n3WpVsZ+/7XSDbtL1/d1JpDZJXFSNm6HWBH1Ut8sxrQgkbB6ePpIfifh1w==
X-Received: by 2002:adf:f9cc:0:b0:31f:98b4:4b62 with SMTP id
 w12-20020adff9cc000000b0031f98b44b62mr18218327wrr.37.1697101995005; 
 Thu, 12 Oct 2023 02:13:15 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a05600001c900b0032179c4a46dsm17807510wrx.100.2023.10.12.02.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 02:13:14 -0700 (PDT)
Date: Thu, 12 Oct 2023 05:13:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 08/22] virtio_net: virtnet_poll_tx support
 rescheduled
Message-ID: <20231012051159-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-9-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20231011092728.105904-9-xuanzhuo@linux.alibaba.com>
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

On Wed, Oct 11, 2023 at 05:27:14PM +0800, Xuan Zhuo wrote:
> virtnet_poll_tx() support to return budget when busy to be rescheduled.
> 
> When retval < budget, napi_poll() in dev.c will exit directly. And
> virtqueue_napi_complete() will be called to close napi.
> 
> When retval == budget, the napi_poll() in dev.c will re-add napi to the
> queue.
> 
> The purpose of this patch is to support xsk xmit in virtio_poll_tx() for
> subsequent patch.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index bcfd31a55076..f32cfa189972 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -1976,6 +1976,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  	struct virtnet_info *vi = sq->vq->vdev->priv;
>  	unsigned int index = vq2txq(sq->vq);
>  	struct netdev_queue *txq;
> +	int busy = 0;
>  	int opaque;
>  	bool done;
>  
> @@ -1993,6 +1994,11 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
>  		netif_tx_wake_queue(txq);
>  
> +	if (busy) {
> +		__netif_tx_unlock(txq);
> +		return budget;
> +	}
> +
>  	opaque = virtqueue_enable_cb_prepare(sq->vq);
>  
>  	done = napi_complete_done(napi, 0);

This just adds a bit of dead code.
Pls just squash into that patch.

> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
