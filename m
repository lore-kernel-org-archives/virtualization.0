Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C41C636CC
	for <virtualization@archiver.kernel.org>; Tue,  7 Feb 2023 14:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E1E660B8D;
	Tue,  7 Feb 2023 14:36:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E1E660B8D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nd4FbHS6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sT6dOt4CpEQ9; Tue,  7 Feb 2023 14:36:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A78AD6002E;
	Tue,  7 Feb 2023 14:36:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A78AD6002E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FC93C0032;
	Tue,  7 Feb 2023 14:36:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2A5EC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 14:36:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BFA8360AFE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 14:36:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFA8360AFE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rFgoCAXAeJru
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 14:36:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E69B76002E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E69B76002E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 14:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675780579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y7UwxcvAseBsjh7pGrBqJ/wmKCj0VJ5wu3GBO8xXE30=;
 b=Nd4FbHS6n5KXTW4AY9Iawu0f60CFB4pKIu3VJXVncOv/qwisa33ZTUjggtjcn+pZi5CFlg
 uKqHCeX9/lfS2u0LPDoN1A8GFtMqKcD+u4Lt/UkdgrklBflX1/GcS8ls8cyJUez7WeqGVq
 ZQBfTU/yGACfz3XhRXOnEv7CfyCIVFQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-91-PKzhlAU8OO-5xGe6QlJPIQ-1; Tue, 07 Feb 2023 09:36:16 -0500
X-MC-Unique: PKzhlAU8OO-5xGe6QlJPIQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 i9-20020a0560001ac900b002bfda39265aso2132195wry.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Feb 2023 06:36:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7UwxcvAseBsjh7pGrBqJ/wmKCj0VJ5wu3GBO8xXE30=;
 b=C5wS5Hb4y5X7tktD5/U0tUW/+VrGvWhhp24kgOmvlDfegq6SjARJSWptheHDYE5xQ2
 Toie9vL41UHBYNzGYAdp/Frttx9/a2bhaL0JCyUjkrmuC5nypsOoorzTl/AIQ7MIP5ZM
 PTLYDcHBwMPDey8DJIBaU9Tg1xenWjNkz+6WFJcb7rrJozdLkekb8zRPB3r9c6SKsIo5
 8hCGsNPXaUP0KjZLP8pYESat9orEo+zze4v5ceAep4vHNDCgjCL0XakSX7I4ht3xgBC4
 Zujg1KkQ550i8pPatgWaSg/QM1dOF2r8lI9pjOilr/CEktWLGDtIAUFgYFL4dZAv5a2r
 V/VQ==
X-Gm-Message-State: AO0yUKWLT+Jw35GFNuj9mVd7+PyO/QavfrH+59w0Eco+hqoQPnXD0fQf
 IyuHO4D3+TkSXIOeNJPxoAQVoC3Y0mT0cY3YaRKGYeZPLplqQX5ytLk2k6FewRF72r2d8mnbVdi
 EXekVpkJx7mKVN0a5pxdcKLRWYcURcDFFXk/nbbcuUA==
X-Received: by 2002:adf:f692:0:b0:2bf:d0a4:3e63 with SMTP id
 v18-20020adff692000000b002bfd0a43e63mr2834803wrp.44.1675780275060; 
 Tue, 07 Feb 2023 06:31:15 -0800 (PST)
X-Google-Smtp-Source: AK7set9EMyvWAcesJnVx+zWygqLzgzk04YOqSIrlVesjXu4aN4SVh8ZHPZ0ICb66swxD2EjUb062cw==
X-Received: by 2002:adf:f692:0:b0:2bf:d0a4:3e63 with SMTP id
 v18-20020adff692000000b002bfd0a43e63mr2834785wrp.44.1675780274874; 
 Tue, 07 Feb 2023 06:31:14 -0800 (PST)
Received: from redhat.com ([2.52.8.17]) by smtp.gmail.com with ESMTPSA id
 c12-20020adffb4c000000b002b6bcc0b64dsm11357157wrs.4.2023.02.07.06.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Feb 2023 06:31:14 -0800 (PST)
Date: Tue, 7 Feb 2023 09:31:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH bpf-next] virtio_net: update xdp_features with xdp
 multi-buff
Message-ID: <20230207093102-mutt-send-email-mst@kernel.org>
References: <60c76cd63a0246db785606e8891b925fd5c9bf06.1675763384.git.lorenzo@kernel.org>
MIME-Version: 1.0
In-Reply-To: <60c76cd63a0246db785606e8891b925fd5c9bf06.1675763384.git.lorenzo@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: hawk@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 john.fastabend@gmail.com, ast@kernel.org, lorenzo.bianconi@redhat.com,
 andrii@kernel.org, edumazet@google.com, kuba@kernel.org, bpf@vger.kernel.org,
 pabeni@redhat.com, virtualization@lists.linux-foundation.org,
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

On Tue, Feb 07, 2023 at 10:53:40AM +0100, Lorenzo Bianconi wrote:
> Now virtio-net supports xdp multi-buffer so add it to xdp_features
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

makes sense


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 692dff071782..ddc3dc7ea73c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3281,7 +3281,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  				virtnet_clear_guest_offloads(vi);
>  		}
>  		if (!old_prog)
> -			xdp_features_set_redirect_target(dev, false);
> +			xdp_features_set_redirect_target(dev, true);
>  	} else {
>  		xdp_features_clear_redirect_target(dev);
>  		vi->xdp_enabled = false;
> @@ -3940,8 +3940,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
>  	spin_lock_init(&vi->refill_lock);
>  
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
>  		vi->mergeable_rx_bufs = true;
> +		dev->xdp_features |= NETDEV_XDP_ACT_RX_SG;
> +	}
>  
>  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
>  		vi->rx_usecs = 0;
> -- 
> 2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
