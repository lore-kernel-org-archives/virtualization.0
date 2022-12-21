Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B17CC4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 12:33:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CCB441808;
	Wed, 21 Dec 2022 12:33:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8CCB441808
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M39dWPvr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m-YLXJCFVJN9; Wed, 21 Dec 2022 12:33:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D3129417FC;
	Wed, 21 Dec 2022 12:33:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3129417FC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EEB6C0071;
	Wed, 21 Dec 2022 12:33:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EF29C0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 12:33:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2CC3941808
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 12:33:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2CC3941808
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4q2ZYcmL4jdh
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 12:33:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D83AD417FC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D83AD417FC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 12:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671626004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UfwSpMUrbS5QlCiQ/lUZJuhmzHTSBFxV4V+3orKFqcg=;
 b=M39dWPvrUhUZOie2i9qVidkBMX6emZNdOtJkwSl66xRp03wwt//UZeYdCFpbC0UMF+yfJJ
 ZMmdFKMOVk3y7X6l/VwntUhUjsfv3kf9AoE392VMTiRsAMRTVIJ5leLr0Nxkh+HrfGk3iK
 s+AcADEEEvL/AYz9+BlpjXEbsB4sx1Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-516-8SBAyABcPCSiTeKyurFUZQ-1; Wed, 21 Dec 2022 07:33:21 -0500
X-MC-Unique: 8SBAyABcPCSiTeKyurFUZQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 x1-20020adfbb41000000b002426b33b618so2846525wrg.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 04:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UfwSpMUrbS5QlCiQ/lUZJuhmzHTSBFxV4V+3orKFqcg=;
 b=FZCp9m3m7Vmvswk2tR57sFeR68JLNnAc9f0tamQyfWS+RsALKgW+cQOJrp7mrsb4Qt
 VasQz8+EbWFaIfT1LPujx9gJCY5oM5/R6P61VH44eH7wM7mbYaeMU1+AOsOVCe8nQmZI
 pKDOFvUeFkW94ce4/wklHAgfr9OnN3RYGzLWhLO5pVF/5HPHnw4DareYiKtSGad9DmSO
 W9sUnAmFZsW2CGuZRTmW+6H7MLeGYWopnqLKBtbT50GS6FvhSsnen9wPWug9s5gJeng0
 5G+h0matZ16XwTWYO3YNvTUa5/1EYB9jPTLILc7/K3TUd8Y+Hz7WVTq0mmlDvOJFTPbS
 B0wQ==
X-Gm-Message-State: AFqh2kpdtC61u30XZ5Dvdp819O7irTbNaazlkTa493SCQN41cblf2azk
 FgH+6ZUpIw9KUwYc5n3Xcm2ybXwScSqNp8zvztqbF1G9Ze2EMvR7OigaxfcLmGw16/LB2qGkRZl
 CDrFsKml81AykdDmef/JvUKzY0rmAsmWHpD52+QrNKQ==
X-Received: by 2002:a05:6000:1a41:b0:24b:b74d:8012 with SMTP id
 t1-20020a0560001a4100b0024bb74d8012mr1057876wry.18.1671626000063; 
 Wed, 21 Dec 2022 04:33:20 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuVlFqxMHdgatYSltTWh5BxABbnsJVuYp/aWATKsyX3UxK/IJnpGpWhs1rYaZCrHl/VIrOKbQ==
X-Received: by 2002:a05:6000:1a41:b0:24b:b74d:8012 with SMTP id
 t1-20020a0560001a4100b0024bb74d8012mr1057864wry.18.1671625999865; 
 Wed, 21 Dec 2022 04:33:19 -0800 (PST)
Received: from redhat.com ([2.52.8.61]) by smtp.gmail.com with ESMTPSA id
 d1-20020adffbc1000000b002364c77bcacsm15184456wrs.38.2022.12.21.04.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Dec 2022 04:33:19 -0800 (PST)
Date: Wed, 21 Dec 2022 07:33:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH] virtio_net: send notification coalescing command only if
 value changed
Message-ID: <20221221073256-mutt-send-email-mst@kernel.org>
References: <20221221120618.652074-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20221221120618.652074-1-alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
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

On Wed, Dec 21, 2022 at 02:06:18PM +0200, Alvaro Karsz wrote:
> Don't send a VIRTIO_NET_CTRL_NOTF_COAL_TX_SET or
> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command if the coalescing parameters
> haven't changed.
> 
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>

Why do we bother? Resending needs more code and helps
reliability ...

> ---
>  drivers/net/virtio_net.c | 48 ++++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7723b2a49d8..1d7118de62a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2760,31 +2760,37 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
>  	struct virtio_net_ctrl_coal_tx coal_tx;
>  	struct virtio_net_ctrl_coal_rx coal_rx;
>  
> -	coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
> -	coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
> -	sg_init_one(&sgs_tx, &coal_tx, sizeof(coal_tx));
> -
> -	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
> -				  VIRTIO_NET_CTRL_NOTF_COAL_TX_SET,
> -				  &sgs_tx))
> -		return -EINVAL;
> +	if (ec->tx_coalesce_usecs != vi->tx_usecs ||
> +	    ec->tx_max_coalesced_frames != vi->tx_max_packets) {
> +		coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
> +		coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
> +		sg_init_one(&sgs_tx, &coal_tx, sizeof(coal_tx));
> +
> +		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
> +					  VIRTIO_NET_CTRL_NOTF_COAL_TX_SET,
> +					  &sgs_tx))
> +			return -EINVAL;
>  
> -	/* Save parameters */
> -	vi->tx_usecs = ec->tx_coalesce_usecs;
> -	vi->tx_max_packets = ec->tx_max_coalesced_frames;
> +		/* Save parameters */
> +		vi->tx_usecs = ec->tx_coalesce_usecs;
> +		vi->tx_max_packets = ec->tx_max_coalesced_frames;
> +	}
>  
> -	coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
> -	coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
> -	sg_init_one(&sgs_rx, &coal_rx, sizeof(coal_rx));
> +	if (ec->rx_coalesce_usecs != vi->rx_usecs ||
> +	    ec->rx_max_coalesced_frames != vi->rx_max_packets) {
> +		coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
> +		coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
> +		sg_init_one(&sgs_rx, &coal_rx, sizeof(coal_rx));
>  
> -	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
> -				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
> -				  &sgs_rx))
> -		return -EINVAL;
> +		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
> +					  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
> +					  &sgs_rx))
> +			return -EINVAL;
>  
> -	/* Save parameters */
> -	vi->rx_usecs = ec->rx_coalesce_usecs;
> -	vi->rx_max_packets = ec->rx_max_coalesced_frames;
> +		/* Save parameters */
> +		vi->rx_usecs = ec->rx_coalesce_usecs;
> +		vi->rx_max_packets = ec->rx_max_coalesced_frames;
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
