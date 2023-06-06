Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDC4C7EE24
	for <virtualization@archiver.kernel.org>; Tue,  6 Jun 2023 08:30:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 832F340A05;
	Tue,  6 Jun 2023 08:30:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 832F340A05
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SujLjYm0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CLH6kcp3Mh8g; Tue,  6 Jun 2023 08:30:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A63E34090E;
	Tue,  6 Jun 2023 08:30:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A63E34090E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CDA4C007A;
	Tue,  6 Jun 2023 08:30:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94ECFC0029
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 08:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5F6CF409FA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 08:30:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F6CF409FA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id joFHbSNSjzVc
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 08:30:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA3964090E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA3964090E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 08:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686040205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lM2mS3A3zk3o/TK+dZncVPidMr9a4SjCD0isQDm9YqI=;
 b=SujLjYm0bxuhN6XKONVg59SR620SvqlJ0JFlyYTXmknI7OpaChaZD75ryHZKp18VBNVMUs
 FS4loW3DZNgyggZHJtwsXYg/U2gx+W55hmJ1nKypwZv+JBiWJsCHPrH8G0/l3HV4rm/77Q
 pOaGvqmqTiccXzwufeJXXjihOENyBpI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-RKuw1aHCNeq4qYNj6h-cEg-1; Tue, 06 Jun 2023 04:30:04 -0400
X-MC-Unique: RKuw1aHCNeq4qYNj6h-cEg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f7e7cfcae4so9084465e9.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Jun 2023 01:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686040203; x=1688632203;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lM2mS3A3zk3o/TK+dZncVPidMr9a4SjCD0isQDm9YqI=;
 b=TvIx6CtTFit7oN3dwYbU5amS7Bx6iFWRF+ajZanM8cuCMjUl2/D1I9NaxmgCP4zmOd
 7pqlbe3A2uIWL5/8Wn5JmjatrgO++QYUzYPC3aePzj2pXGu6BtMfpXhHOT9VKY36/QAs
 nrF77xCq2bhPCOmxQ6JZkbhluMB3u5cgONaPMpUGEqd/IKCJIJASKUmuS4BGuzCe7jvA
 otCU6udWU8f+B48HRdQRDEYIzLjKYgB1JOwDeKTEeBx/YHK1GJoGuoVyrl+n3qJrcL8B
 qotJip94/1RBVpdxUSIOCUapzvH3dqSnol1wLR/t/KNJ1P4ekPFnN84BV9e0sdDUJN15
 o76Q==
X-Gm-Message-State: AC+VfDy01tDdaQhJba1tfJYmg5PQVVX6t+oz+c/JWYrXEWfC+IF0NXEh
 71hyT0OegIm0crcO408LTlcfSA7zuW8Wb7GeTtgttZR56pmI9edd3Ra2ESMRlm0srv5jLHGEi74
 z80GBWaLwarClJ+ongVbC01OP8dMjPZm6rQneT2AZLg==
X-Received: by 2002:a05:600c:218b:b0:3f7:39ed:c9a4 with SMTP id
 e11-20020a05600c218b00b003f739edc9a4mr1718500wme.30.1686040203302; 
 Tue, 06 Jun 2023 01:30:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4wzn5kTFHCj7kpNMtHXKZMzbAwhIp+5L6K4sup6x8HZTdlr5Lt/2XPeXnEL6/uX9ypoH2r+w==
X-Received: by 2002:a05:600c:218b:b0:3f7:39ed:c9a4 with SMTP id
 e11-20020a05600c218b00b003f739edc9a4mr1718474wme.30.1686040202996; 
 Tue, 06 Jun 2023 01:30:02 -0700 (PDT)
Received: from redhat.com ([2.55.41.2]) by smtp.gmail.com with ESMTPSA id
 n16-20020a1c7210000000b003f736e28cd6sm7884431wmc.4.2023.06.06.01.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 01:30:02 -0700 (PDT)
Date: Tue, 6 Jun 2023 04:29:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Brett Creeley <brett.creeley@amd.com>
Subject: Re: [PATCH net] virtio_net: use control_buf for coalesce params
Message-ID: <20230606042942-mutt-send-email-mst@kernel.org>
References: <20230605195925.51625-1-brett.creeley@amd.com>
MIME-Version: 1.0
In-Reply-To: <20230605195925.51625-1-brett.creeley@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 allen.hubbe@amd.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
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

On Mon, Jun 05, 2023 at 12:59:25PM -0700, Brett Creeley wrote:
> Commit 699b045a8e43 ("net: virtio_net: notifications coalescing
> support") added coalescing command support for virtio_net. However,
> the coalesce commands are using buffers on the stack, which is causing
> the device to see DMA errors. There should also be a complaint from
> check_for_stack() in debug_dma_map_xyz(). Fix this by adding and using
> coalesce params from the control_buf struct, which aligns with other
> commands.
> 
> Fixes: 699b045a8e43 ("net: virtio_net: notifications coalescing support")
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

stable material too.

> ---
>  drivers/net/virtio_net.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 56ca1d270304..486b5849033d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -205,6 +205,8 @@ struct control_buf {
>  	__virtio16 vid;
>  	__virtio64 offloads;
>  	struct virtio_net_ctrl_rss rss;
> +	struct virtio_net_ctrl_coal_tx coal_tx;
> +	struct virtio_net_ctrl_coal_rx coal_rx;
>  };
>  
>  struct virtnet_info {
> @@ -2934,12 +2936,10 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
>  				       struct ethtool_coalesce *ec)
>  {
>  	struct scatterlist sgs_tx, sgs_rx;
> -	struct virtio_net_ctrl_coal_tx coal_tx;
> -	struct virtio_net_ctrl_coal_rx coal_rx;
>  
> -	coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
> -	coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
> -	sg_init_one(&sgs_tx, &coal_tx, sizeof(coal_tx));
> +	vi->ctrl->coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
> +	vi->ctrl->coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
> +	sg_init_one(&sgs_tx, &vi->ctrl->coal_tx, sizeof(vi->ctrl->coal_tx));
>  
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
>  				  VIRTIO_NET_CTRL_NOTF_COAL_TX_SET,
> @@ -2950,9 +2950,9 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
>  	vi->tx_usecs = ec->tx_coalesce_usecs;
>  	vi->tx_max_packets = ec->tx_max_coalesced_frames;
>  
> -	coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
> -	coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
> -	sg_init_one(&sgs_rx, &coal_rx, sizeof(coal_rx));
> +	vi->ctrl->coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
> +	vi->ctrl->coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
> +	sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ctrl->coal_rx));
>  
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
>  				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
