Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCB9C433EF
	for <virtualization@archiver.kernel.org>; Thu, 16 Dec 2021 06:31:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65CA960FD0;
	Thu, 16 Dec 2021 06:31:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JIGnjnIfeeK3; Thu, 16 Dec 2021 06:31:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1538A60669;
	Thu, 16 Dec 2021 06:31:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6968C002F;
	Thu, 16 Dec 2021 06:31:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48B30C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 06:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3732860FBF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 06:31:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RH4f01uV_2K0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 06:31:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 55C0860669
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 06:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639636270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xQP0U4n69dE+5NPu2PjUvLuvcGm/amzZHr33qUMUH4Y=;
 b=SRexPOZfIopmHCFsWVU7ZlFZbmcWUkzoBBvDvgTiFRCmjYStrLctmyDSum8fY3rUps2uup
 DO89oHBoZs9/Oq8OXPK89iv/LQKq4LO8Nyi3Zcwg3UgqAXbby8PNuATyUEmF7Jipy0WjMt
 roxqp2B1rvVG3arwWD82HsvzG4xn4SQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-fWL4ddX4PfiCDwjElEPfDg-1; Thu, 16 Dec 2021 01:31:08 -0500
X-MC-Unique: fWL4ddX4PfiCDwjElEPfDg-1
Received: by mail-ed1-f69.google.com with SMTP id
 v22-20020a50a456000000b003e7cbfe3dfeso22324276edb.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 22:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xQP0U4n69dE+5NPu2PjUvLuvcGm/amzZHr33qUMUH4Y=;
 b=ruLFREwK3brwXlDDbJOHT/9lXVViq4k9fDRQ8qgy/Lcd5p/vChsmNjwQb39A0vxknn
 F3/6ETKscVU0lSZ+WHC7CHOKPtZlkKdLJFFzc4AoI3QgfYvhMeXe3Wx+hA0AzxjRWLNV
 2ejmsJeh+WkImSr6MhtKzr1iLkGdl9kD9/c7DC5ZE0jwtQI18JqLDQcBM9rXAR3/mYmH
 CvT5hKmtOmiGrJMPwOixXLzm6hoFPkahjhKzaZy/EAUPaNVqrNM8fbivWbkU+CBdxxjL
 jfUsFBy7wxtQSU54iBKOl5PZUAOggS8ReVUJLmZ3Ui+CdrBk4Gyowbkn0fncqwTjoIZM
 z42g==
X-Gm-Message-State: AOAM530IEjfz/lSLFVOrczGl5FflWDAzOCKcECfkzfdrket1ENOa7Ca+
 vQPiHjeaG8lV+zKjRo2piqYFgwMD8wUyMlc9geWlYVIqeEjSBhE6mQBs11P/szFT3EJOQW0ypCU
 AlT1EtOQnVVhyYPFE/+ieW7nN+X9/IdAwmwulEG5qQg==
X-Received: by 2002:a05:6402:148:: with SMTP id
 s8mr18866707edu.221.1639636267539; 
 Wed, 15 Dec 2021 22:31:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVfHIwDKSfwdC3Nw5luWnoYiTqEKCAHOR9VdZOJrXYUUC7cbyIBBf1zlKosoiw5hP+2D0kpg==
X-Received: by 2002:a05:6402:148:: with SMTP id
 s8mr18866694edu.221.1639636267359; 
 Wed, 15 Dec 2021 22:31:07 -0800 (PST)
Received: from redhat.com ([2.55.22.18])
 by smtp.gmail.com with ESMTPSA id 6sm1356660ejj.164.2021.12.15.22.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Dec 2021 22:31:06 -0800 (PST)
Date: Thu, 16 Dec 2021 01:31:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wenliang Wang <wangwenliang.1995@bytedance.com>
Subject: Re: [PATCH] virtio_net: fix rx_drops stat for small pkts
Message-ID: <20211216013056-mutt-send-email-mst@kernel.org>
References: <20211216031135.3182660-1-wangwenliang.1995@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20211216031135.3182660-1-wangwenliang.1995@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kuba@kernel.org,
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

On Thu, Dec 16, 2021 at 11:11:35AM +0800, Wenliang Wang wrote:
> We found the stat of rx drops for small pkts does not increment when
> build_skb fail, it's not coherent with other mode's rx drops stat.
> 
> Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 55db6a336f7e..b107835242ad 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -733,7 +733,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  		pr_debug("%s: rx error: len %u exceeds max size %d\n",
>  			 dev->name, len, GOOD_PACKET_LEN);
>  		dev->stats.rx_length_errors++;
> -		goto err_len;
> +		goto err;
>  	}
>  
>  	if (likely(!vi->xdp_enabled)) {
> @@ -825,10 +825,8 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  
>  skip_xdp:
>  	skb = build_skb(buf, buflen);
> -	if (!skb) {
> -		put_page(page);
> +	if (!skb)
>  		goto err;
> -	}
>  	skb_reserve(skb, headroom - delta);
>  	skb_put(skb, len);
>  	if (!xdp_prog) {
> @@ -839,13 +837,12 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  	if (metasize)
>  		skb_metadata_set(skb, metasize);
>  
> -err:
>  	return skb;
>  
>  err_xdp:
>  	rcu_read_unlock();
>  	stats->xdp_drops++;
> -err_len:
> +err:
>  	stats->drops++;
>  	put_page(page);
>  xdp_xmit:
> -- 
> 2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
