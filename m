Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE105E75449
	for <virtualization@archiver.kernel.org>; Tue,  3 Oct 2023 10:41:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 61737404C4;
	Tue,  3 Oct 2023 10:41:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 61737404C4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eA70agjw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OQxduYX-7Tip; Tue,  3 Oct 2023 10:41:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EB0F340449;
	Tue,  3 Oct 2023 10:41:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB0F340449
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB98DC0071;
	Tue,  3 Oct 2023 10:41:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C2DBC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 10:41:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 16B5960F6B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 10:41:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 16B5960F6B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eA70agjw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s2cRNa8mtFJZ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 10:41:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7D6560E53
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 10:41:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A7D6560E53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696329670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0hRC0l1svtCkhl1SogBPC4I+tthKd23rJo8KHVEu7Wg=;
 b=eA70agjwjRZaOWFsL4x6B4bo4kNDk+Zu5cAJAb+ryFuacLveGjF6mtmobYxO6iIvwApKri
 rz5Ymn85pZVX3fKRUOPfUlB0JlKuvEKLtN8s2g1j16WUuHD/1KdEPvGPGD1ghKh3tnGPnw
 kyDl01PAhaYZA3oakH0ATzAdReOJ5OI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-KkgFKDzMMC6dP87KQQa5yQ-1; Tue, 03 Oct 2023 06:41:07 -0400
X-MC-Unique: KkgFKDzMMC6dP87KQQa5yQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9ae5101b152so13883266b.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Oct 2023 03:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696329666; x=1696934466;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uRRAGV+UU6/gJ85E/oblYOeeKk1zoIISwkILmJK6qUg=;
 b=WN3pkhx36Xy3Up7KNFW9yq9KdypqVGg7rlIWQ0JNNLjnJzXaf3ElwT94reyT8EsTu+
 QT5WxTEWPNb3LSzIUDQZ7iYijaUFsghVc0q3SWQkCvXEnify6x/naZURiMOLlBBCDYAq
 4giG0Uk982d/sLCeSVAC/0+6XtpPHoGovHCXrejJwRhJ7h1SMfEbvPuRUJsDblR6pQvq
 WgVwp2rAL2EpnGP+BnBjanwItzk2hygR5B4wQHqiOwks4CtwIwRPQy6/JmXo4q1Lv9dU
 1WYLX4NH8Kf4fWKSBxetSXKjc2+ygi46QXB6AOtQHVxA1gfL2KkElX6zOpr1zTPJ7zs3
 tTxA==
X-Gm-Message-State: AOJu0YzuIGyY5b6bHzLJb92kN+6nCMjz26LxVPyDINyuqqr4q5nwo7wu
 5XziXfOnC+duwgX61xvTScj9vEToIDFQA4Milgd6ov1mEMMnvr/lV7BEDbASL1fUUfiFdWIMMEE
 nwecFFMai0fxzQgkX4gmK0/CnKHY7kCAbzQOyTkcoLA==
X-Received: by 2002:a17:906:101a:b0:9b2:93f0:70b9 with SMTP id
 26-20020a170906101a00b009b293f070b9mr10916208ejm.3.1696329665908; 
 Tue, 03 Oct 2023 03:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0l8fLdJoHjuboygQtpHYXVPvRXsg/ustHtzTXzFiIkT9xq4pzDhV2oPN1PGx5cfXslOhQmg==
X-Received: by 2002:a17:906:101a:b0:9b2:93f0:70b9 with SMTP id
 26-20020a170906101a00b009b293f070b9mr10916180ejm.3.1696329665504; 
 Tue, 03 Oct 2023 03:41:05 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-193.dyn.eolo.it.
 [146.241.232.193]) by smtp.gmail.com with ESMTPSA id
 o13-20020a170906358d00b0099bc8db97bcsm839267ejb.131.2023.10.03.03.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 03:41:05 -0700 (PDT)
Message-ID: <960e16021a529bc9df217b3c2546e0dc7532ce7b.camel@redhat.com>
Subject: Re: [PATCH net v2 5/6] virtio-net: fix the vq coalescing setting
 for vq resize
From: Paolo Abeni <pabeni@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
 virtualization@lists.linux-foundation.org
Date: Tue, 03 Oct 2023 12:41:03 +0200
In-Reply-To: <1b4f480bed95951b6f4805d6c4e72dd1a315acab.1695627660.git.hengqi@linux.alibaba.com>
References: <cover.1695627660.git.hengqi@linux.alibaba.com>
 <1b4f480bed95951b6f4805d6c4e72dd1a315acab.1695627660.git.hengqi@linux.alibaba.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S . Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Gavin Li <gavinl@nvidia.com>
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

On Mon, 2023-09-25 at 15:53 +0800, Heng Qi wrote:
> According to the definition of virtqueue coalescing spec[1]:
> 
>   Upon disabling and re-enabling a transmit virtqueue, the device MUST set
>   the coalescing parameters of the virtqueue to those configured through the
>   VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver did not set
>   any TX coalescing parameters, to 0.
> 
>   Upon disabling and re-enabling a receive virtqueue, the device MUST set
>   the coalescing parameters of the virtqueue to those configured through the
>   VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or, if the driver did not set
>   any RX coalescing parameters, to 0.
> 
> We need to add this setting for vq resize (ethtool -G) where vq_reset happens.
> 
> [1] https://lists.oasis-open.org/archives/virtio-dev/202303/msg00415.html
> 
> Fixes: 394bd87764b6 ("virtio_net: support per queue interrupt coalesce command")
> Cc: Gavin Li <gavinl@nvidia.com>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

@Jason, since you commented on v1, waiting for your ack.

> ---
>  drivers/net/virtio_net.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 12ec3ae19b60..cb19b224419b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2855,6 +2855,9 @@ static void virtnet_get_ringparam(struct net_device *dev,
>  	ring->tx_pending = virtqueue_get_vring_size(vi->sq[0].vq);
>  }
>  
> +static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
> +					 u16 vqn, u32 max_usecs, u32 max_packets);
> +
>  static int virtnet_set_ringparam(struct net_device *dev,
>  				 struct ethtool_ringparam *ring,
>  				 struct kernel_ethtool_ringparam *kernel_ring,
> @@ -2890,12 +2893,36 @@ static int virtnet_set_ringparam(struct net_device *dev,
>  			err = virtnet_tx_resize(vi, sq, ring->tx_pending);
>  			if (err)
>  				return err;
> +
> +			/* Upon disabling and re-enabling a transmit virtqueue, the device must
> +			 * set the coalescing parameters of the virtqueue to those configured
> +			 * through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver
> +			 * did not set any TX coalescing parameters, to 0.
> +			 */
> +			err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(i),
> +							    vi->intr_coal_tx.max_usecs,
> +							    vi->intr_coal_tx.max_packets);
> +			if (err)
> +				return err;
> +			/* Save parameters */

As a very minor nit, I guess the comment could be dropped here (similar
to patch 4/6). @Heng Qi: please don't repost just for this, let's wait
for Jason' comments.

Cheers,

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
