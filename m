Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C36EC77B7E
	for <virtualization@archiver.kernel.org>; Sun, 28 May 2023 06:16:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C191060D89;
	Sun, 28 May 2023 06:16:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C191060D89
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gnocmnp8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MGLT3wBvRF5x; Sun, 28 May 2023 06:16:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 02E0160B2D;
	Sun, 28 May 2023 06:16:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 02E0160B2D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4F69C0036;
	Sun, 28 May 2023 06:16:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED05CC002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 06:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD31483CA6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 06:16:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD31483CA6
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gnocmnp8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id odg_p_OWK94E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 06:16:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9628B83C9D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9628B83C9D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 06:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685254600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xyjjfsHJGz4btJpbkZnZFyAqXrjeVJSFODC6tRwjNqo=;
 b=Gnocmnp8YdeOfmf8uRjh0Qzq55Br+fL6nUu3pGz/RJWwmW9R5mbG+gC4/Tx5JeFBMBkvaq
 VrPIG25UoElgu9WgwuFv4wnIv4+VvAF7D7RTxCOgbWTjzdRwLTkZ8ZdsBLJNtMAqdmGjfd
 KF//xX6vXKiDgYzTxkQfoSxusPlEd/0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-zVSo9JbnNkSkQyuN4GrLmg-1; Sun, 28 May 2023 02:16:39 -0400
X-MC-Unique: zVSo9JbnNkSkQyuN4GrLmg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30a8f6d7bbdso672198f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 23:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685254598; x=1687846598;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xyjjfsHJGz4btJpbkZnZFyAqXrjeVJSFODC6tRwjNqo=;
 b=a+wrPN7jojg3H62hOUevaojmRH2sy+/npKeX9uFYlZN6sHt3k/2KN5FYbD9otIe7H4
 cepkJNEx00TkDAOCRJfXwtxh1vMtahEaafVBqiMir5bdOU9smALQg+vEhBkEV0X7NOEh
 rtd2mBA+vocd7xtlIg9KOpRIUILmSbs0RHJIxB58gvThcl2PJaJLK201WAYDfF6DIFQl
 FldQjV4IRjTbxNrh558PhrJbc+m1xj9RW24rcfPS0gZFEohA8pTLi2+stZegVW8POafy
 iSj/infWq6HTbS890FQ+3UsCftHKVBlJ+XM5ybgQPi+kKzpAAcMiNb9UiBq/vQq3157N
 l/RQ==
X-Gm-Message-State: AC+VfDxbPOAbKj2JtKNBzxNq50B/n6H99CVzfAd8RaywWosgtN7Nl9bI
 k6OgCzfsJwkaguTcdev0He2z/lE4kVjEmUFmRBce7Z0bOV1nr1tqXsVb7PdzkSQYpmnE8Ynw9Ia
 6r3JYgLbfnCRse2x/x0SHEYqKNDusGHHBTS0NguO2Xg==
X-Received: by 2002:adf:eccc:0:b0:306:2aa0:ce81 with SMTP id
 s12-20020adfeccc000000b003062aa0ce81mr6910622wro.30.1685254598298; 
 Sat, 27 May 2023 23:16:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7dFHG2HLfd2Q3dXDNjbmL0ir54ug1fj6Cozz0mkZHs3U/h67Qlj5dhak5C/0LI3cKmRJ/97g==
X-Received: by 2002:adf:eccc:0:b0:306:2aa0:ce81 with SMTP id
 s12-20020adfeccc000000b003062aa0ce81mr6910604wro.30.1685254597977; 
 Sat, 27 May 2023 23:16:37 -0700 (PDT)
Received: from redhat.com ([2.52.146.27]) by smtp.gmail.com with ESMTPSA id
 l21-20020a1c7915000000b003f603b8eb5asm10308080wme.7.2023.05.27.23.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 May 2023 23:16:37 -0700 (PDT)
Date: Sun, 28 May 2023 02:16:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liang Chen <liangchen.linux@gmail.com>
Subject: Re: [PATCH net-next 1/5] virtio_net: Fix an unsafe reference to the
 page chain
Message-ID: <20230528021008-mutt-send-email-mst@kernel.org>
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20230526054621.18371-1-liangchen.linux@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Fri, May 26, 2023 at 01:46:17PM +0800, Liang Chen wrote:
> "private" of buffer page is currently used for big mode to chain pages.
> But in mergeable mode, that offset of page could mean something else,
> e.g. when page_pool page is used instead. So excluding mergeable mode to
> avoid such a problem.
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>

Ugh the subject makes it looks like current code has a problem
but I don't think so because I don't think anything besides
big packets uses page->private.

The reason patch is needed is because follow up patches
use page_pool.
pls adjust commit log and subject to make all this clear.


> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5a7f7a76b920..c5dca0d92e64 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -497,7 +497,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  			return NULL;
>  
>  		page = (struct page *)page->private;
> -		if (page)
> +		if (!vi->mergeable_rx_bufs && page)

To be safe let's limit to big packets too:

	if (!vi->mergeable_rx_bufs && vi->big_packets && page)



>  			give_pages(rq, page);
>  		goto ok;
>  	}
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
