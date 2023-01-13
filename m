Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861A0C3DA78
	for <virtualization@archiver.kernel.org>; Fri, 13 Jan 2023 23:26:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EC1441B52;
	Fri, 13 Jan 2023 23:26:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0EC1441B52
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=MQSckLaP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JaSYGpbVxJhQ; Fri, 13 Jan 2023 23:26:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3447D41A10;
	Fri, 13 Jan 2023 23:26:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3447D41A10
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E32CC0032;
	Fri, 13 Jan 2023 23:26:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0CF5C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 23:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E551821E4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 23:25:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E551821E4
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=MQSckLaP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nmp-2CyZvFvV
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 23:25:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C29C6821E2
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C29C6821E2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 23:25:58 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id v23so20028366plo.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 15:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7LC7fNege2OL4xDfFuGevF0Ei2VV6+IVloPCGY2mC84=;
 b=MQSckLaP9MDMihN8IVNuJQUpTW1vJIXHEx+t/qCBH6J5ilCMUBM1zf08VHdoX+tKZW
 9HIO1MBvdApwghKPOFszI9JeacZ40ycHgcaWdFyF8OW/YQLSfSEZ55B4kUK60aoCVcxk
 r0QF5AfNJsYBYVyTQ38p/3ckAwJ+CuCsWHWebx8AJ8BPRSdesilMngzYYguQ1bG4Whwi
 crCzTDVEFUtgC8oTVPKClbYg/+k0TgEnx7oHREH6wK/o/NPqFZEHNiOYTDjHfy3JX6Fs
 E80uDnhvZsrVh8N2wRyqp940p2SIEaVgb4/SMxban2vu063kYCx0iB4Zw/7YtKNKD9GM
 DP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7LC7fNege2OL4xDfFuGevF0Ei2VV6+IVloPCGY2mC84=;
 b=03Sf8oc7UgT8BIVbT4aEDmGl1XbpFeiSw46aj4/rnAxXvbLD91k0sCt7FaQKUp5QGa
 pr6BwLx6xzCKgxRG793m0x4LCttbtGxOdSSusROJpY3qgfxLzMfNm5MxQPgJzqMjWxgR
 m9KKDWpDac5REl1MufWJxVVwxv7RgAN4biwU7H2315f9DJFmYsTAtrzOw/exBrexHiuw
 YvwABjv6pBTVUtA0/fLEBONPJR3XucFuyLbDij+PR4vOw/4UxAvliL6hPVaauzmkE7LB
 CubYWWvqXzHk8rZc0Nk+nwxuZUiMuhZabdjagowfpXTVd0BXbOqnIiO8KGn3w2Fc4b9U
 t2QQ==
X-Gm-Message-State: AFqh2krZXLT6bIB3dkxN4tsZSeLoIxo+cJ09bngakJ/NwUr3O4p2sgUI
 /JNPPf9LHb7bjt4ChQKR2cg=
X-Google-Smtp-Source: AMrXdXvMg/bqbsdgPLqa+5sgVJpVn7AqukKkKmjeNH7wQlJ/TWCYDzQm7rVRVLMvJ2a1cv1qO9fXeg==
X-Received: by 2002:a17:90b:280d:b0:21a:1f5f:e798 with SMTP id
 qb13-20020a17090b280d00b0021a1f5fe798mr85938652pjb.48.1673652358133; 
 Fri, 13 Jan 2023 15:25:58 -0800 (PST)
Received: from [192.168.0.128] ([98.97.117.20])
 by smtp.googlemail.com with ESMTPSA id
 oj11-20020a17090b4d8b00b001fde655225fsm4396304pjb.2.2023.01.13.15.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jan 2023 15:25:57 -0800 (PST)
Message-ID: <01a95e4ac97cba9a2f656e5e4e345640d65a5005.camel@gmail.com>
Subject: Re: [PATCH net-next 2/2] virtio_net: Reuse buffer free function
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com, jasowang@redhat.com, 
 netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org
Date: Fri, 13 Jan 2023 15:25:55 -0800
In-Reply-To: <20230113223619.162405-3-parav@nvidia.com>
References: <20230113223619.162405-1-parav@nvidia.com>
 <20230113223619.162405-3-parav@nvidia.com>
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
Cc: edumazet@google.com, pabeni@redhat.com,
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

On Sat, 2023-01-14 at 00:36 +0200, Parav Pandit wrote:
> virtnet_rq_free_unused_buf() helper function to free the buffer
> already exists. Avoid code duplication by reusing existing function.
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d45e140b6852..c1faaf11fbcd 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1251,13 +1251,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  	if (unlikely(len < vi->hdr_len + ETH_ZLEN)) {
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
>  

Looks good to me.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
