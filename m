Return-Path: <SRS0=Q5yb=F2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F51C433E6
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 22:32:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C013420855
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 22:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C013420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 66DC385BE4;
	Tue, 22 Dec 2020 22:32:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OA_zAT1Ffjxq; Tue, 22 Dec 2020 22:32:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DE7F185F2B;
	Tue, 22 Dec 2020 22:32:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C07FDC1825;
	Tue, 22 Dec 2020 22:32:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19950C0893
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 22:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0313387238
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 22:32:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hql5lRIP02kg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 22:32:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AA4428716F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 22:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608676355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IonW2o/1Jm2bgtMHyV7imS+O9e7gTHGtzSzw1CivbwI=;
 b=Gxmfqg5D/L3nANOKHAyvk3fPo5DB57L1KgZo4ZED4r/PIzs6SwEO8NfZXDmz1rilvbly5q
 17Op7dUbuBd6xkC6MqYVwRg0KedS3ZUJVp5U6RuCGO/R42K11VGUcSnGgmQFilzAzKfQTk
 ukjUfw6i/ZCpuzJVmLvgk4ZSTgJ9jyg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-SZKdTWFINJuH-4Q5-DBsJA-1; Tue, 22 Dec 2020 17:32:33 -0500
X-MC-Unique: SZKdTWFINJuH-4Q5-DBsJA-1
Received: by mail-wm1-f70.google.com with SMTP id b184so1640532wmh.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 14:32:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IonW2o/1Jm2bgtMHyV7imS+O9e7gTHGtzSzw1CivbwI=;
 b=CzbVdMT0WMWzmIzowfrelwDTxu5jWgLll4uTwyX0ICSbMz+miKnXht58Kv8JCbws0o
 hDhd9JXep4S7brP4SiEZdWif6lXmFTS4oFNotFbq9RPj8aA4UvQncI8W6/UheswiKVy7
 MccF4DKN3CquqNjDp7XjY8A1BP2q0h58f4BWesRP+nvvylFy9EqpxqgGnVn2TFrkGYmk
 ABQo57yaxHqQz8JcYQnLsSa4HJh08UOfUCMWl3MAJrqJEET+5/d7KxXoTaIZchUecmBh
 rEBIc9sdir1wscqEub2bcBKuiSUdvyjdASWzoyLaGsqlBH9napqI9l9d7W/iHuExvVa6
 0RbQ==
X-Gm-Message-State: AOAM531XLnQvIWX2VIXGsFKux28dS2K2LgPL4gSqaGIIFzAd0VTdtreh
 2UUTlWHLwSMtpvR9KnjLo0m0j8wvcSI8LId9gS5xi1HCDhgPKfu3MQswMn+8c67GEsfNwBoCkv5
 xD9Bwb1RtPGBpubDuSZfIZRYP9atCDusurqEwMFK48w==
X-Received: by 2002:adf:d085:: with SMTP id y5mr26964696wrh.41.1608676352525; 
 Tue, 22 Dec 2020 14:32:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyGpvAo0f4ZPURjmyIvE7jVhc03kO5QJPSr/r1EHgA8Wh6rOqz9nWLh09xqTdwx0CHWVxhJmw==
X-Received: by 2002:adf:d085:: with SMTP id y5mr26964692wrh.41.1608676352382; 
 Tue, 22 Dec 2020 14:32:32 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id r82sm28894756wma.18.2020.12.22.14.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Dec 2020 14:32:31 -0800 (PST)
Date: Tue, 22 Dec 2020 17:32:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jeff Dike <jdike@akamai.com>
Subject: Re: [PATCH] virtio_net: Fix recursive call to cpus_read_lock()
Message-ID: <20201222173209-mutt-send-email-mst@kernel.org>
References: <20201222033648.14752-1-jdike@akamai.com>
MIME-Version: 1.0
In-Reply-To: <20201222033648.14752-1-jdike@akamai.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
 virtualization@lists.linux-foundation.org
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

On Mon, Dec 21, 2020 at 10:36:48PM -0500, Jeff Dike wrote:
> virtnet_set_channels can recursively call cpus_read_lock if CONFIG_XPS
> and CONFIG_HOTPLUG are enabled.
> 
> The path is:
>     virtnet_set_channels - calls get_online_cpus(), which is a trivial
> wrapper around cpus_read_lock()
>     netif_set_real_num_tx_queues
>     netif_reset_xps_queues_gt
>     netif_reset_xps_queues - calls cpus_read_lock()
> 
> This call chain and potential deadlock happens when the number of TX
> queues is reduced.
> 
> This commit the removes netif_set_real_num_[tr]x_queues calls from
> inside the get/put_online_cpus section, as they don't require that it
> be held.
> 
> Signed-off-by: Jeff Dike <jdike@akamai.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 052975ea0af4..e02c7e0f1cf9 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2093,14 +2093,16 @@ static int virtnet_set_channels(struct net_device *dev,
>  
>  	get_online_cpus();
>  	err = _virtnet_set_queues(vi, queue_pairs);
> -	if (!err) {
> -		netif_set_real_num_tx_queues(dev, queue_pairs);
> -		netif_set_real_num_rx_queues(dev, queue_pairs);
> -
> -		virtnet_set_affinity(vi);
> +	if (err){
> +		put_online_cpus();
> +		goto err;
>  	}
> +	virtnet_set_affinity(vi);
>  	put_online_cpus();
>  
> +	netif_set_real_num_tx_queues(dev, queue_pairs);
> +	netif_set_real_num_rx_queues(dev, queue_pairs);
> + err:
>  	return err;
>  }
>  
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
