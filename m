Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C183C6379F
	for <virtualization@archiver.kernel.org>; Tue, 17 Jan 2023 16:34:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 901D9409AA;
	Tue, 17 Jan 2023 16:34:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 901D9409AA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JKXekJVg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Eg3evH-FvSPL; Tue, 17 Jan 2023 16:34:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9C2FE408FB;
	Tue, 17 Jan 2023 16:34:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C2FE408FB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E053C0033;
	Tue, 17 Jan 2023 16:34:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF500C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 16:34:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AAE6360C03
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 16:34:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AAE6360C03
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JKXekJVg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7qo9xDyQWune
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 16:34:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE9F860C02
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE9F860C02
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 16:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673973243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NVmDRrmwM6bLSGgu4CyMQGhit4EFONfy+cKRjvI8WwU=;
 b=JKXekJVgwdk/bgZmNPnOXCGX5q8vcwwnQZLm4SiAfc3RUvkSUCGN7kqoqux2zFXDU8qZdy
 xP1UKoGXnViEzoIXYdwzL9V9kC9mTGf3cZqqI1SXs8c1GqjE1bR/0+DioxEt+7lmR77TfQ
 lR3hqHM/KSM/FRX2cfj7lvGxZEREV08=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-247-8oXdGBGNOFmqPeK_TS5Ceg-1; Tue, 17 Jan 2023 11:34:01 -0500
X-MC-Unique: 8oXdGBGNOFmqPeK_TS5Ceg-1
Received: by mail-qk1-f199.google.com with SMTP id
 bj28-20020a05620a191c00b007068d8b5051so2810304qkb.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 08:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NVmDRrmwM6bLSGgu4CyMQGhit4EFONfy+cKRjvI8WwU=;
 b=F7FJbtPI0YdNnqtTiiyv7SsE0XO0lyjxW1RVuraTaKfv4QRoOrQ36RNrC9uyAoZCJX
 wNFLyTaxIHQVAnIOw5KmSuFFRczteOnGU7s/uTbEZ4vodu7EPy6HyB1ThCYCFJUYQUfY
 OuI5CueH7fRWhyhimh4kJhBeznLtYigfZGn9cTY5AAew5n8Ke5HvejnIObRF1feiXrEG
 MCaU+RDX4eEpH/AX48XE2a6IZL10gIQXcEpV/0WRNAwZmeLUaZWDfDQRAI1PWaFdowwt
 Sp7PfWRKWA/QbG/f5DwoT59NLsTFhaXKyFsUHNwuPWWRIAG7fX4fq6aumnDWTJrYlrsp
 L+Cg==
X-Gm-Message-State: AFqh2kozpb3bJjhFCwut9qa2BPuiAT1eVHtFmPLD3GMk7HKaqvFbeXrU
 vSwvOEAlXQkj46Yz4PrT3aBDM56Hkf7nIEEvOJmlPDQ3wv/0y5p05lfcOnlq+fLO7TMH9SGEFkx
 Yd/9bOJUFS4FSLGAnJUl3jVVjANg5xcgEYVtStuudsg==
X-Received: by 2002:ac8:58c3:0:b0:3b6:2e8b:3364 with SMTP id
 u3-20020ac858c3000000b003b62e8b3364mr5463068qta.38.1673973239503; 
 Tue, 17 Jan 2023 08:33:59 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvCT6ihocQyYU3l2Kv6blvgT/IPPNSTOnvZX1MrQwg2vhNixBBk1UWBmfkHU0tBUVP1CLc5Ow==
X-Received: by 2002:ac8:58c3:0:b0:3b6:2e8b:3364 with SMTP id
 u3-20020ac858c3000000b003b62e8b3364mr5463039qta.38.1673973239174; 
 Tue, 17 Jan 2023 08:33:59 -0800 (PST)
Received: from [192.168.100.30] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 jr49-20020a05622a803100b003ad373d04b6sm13289356qtb.59.2023.01.17.08.33.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jan 2023 08:33:58 -0800 (PST)
Message-ID: <fefccbdb-9ccd-4057-743a-b23bad4e123d@redhat.com>
Date: Tue, 17 Jan 2023 17:33:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH net V3] virtio-net: correctly enable callback during
 start_xmit
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com
References: <20230117034707.52356-1-jasowang@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20230117034707.52356-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Stefano Brivio <sbrivio@redhat.com>,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 1/17/23 04:47, Jason Wang wrote:
> Commit a7766ef18b33("virtio_net: disable cb aggressively") enables
> virtqueue callback via the following statement:
> 
>          do {
> 		if (use_napi)
> 			virtqueue_disable_cb(sq->vq);
> 
> 		free_old_xmit_skbs(sq, false);
> 
> 	} while (use_napi && kick &&
>                 unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> 
> When NAPI is used and kick is false, the callback won't be enabled
> here. And when the virtqueue is about to be full, the tx will be
> disabled, but we still don't enable tx interrupt which will cause a TX
> hang. This could be observed when using pktgen with burst enabled.
> 
> TO be consistent with the logic that tries to disable cb only for
> NAPI, fixing this by trying to enable delayed callback only when NAPI
> is enabled when the queue is about to be full.
> 
> Fixes: a7766ef18b33 ("virtio_net: disable cb aggressively")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> The patch is needed for -stable.
> Changes since V2:
> - try to enabled delayed callback and schedule NAPI instead of try to
>    poll as when TX NAPI is disabled
> Changes since V1:
> - enable tx interrupt after we disable TX
> ---
>   drivers/net/virtio_net.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7723b2a49d8e..18b3de854aeb 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1877,8 +1877,10 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>   	 */
>   	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
>   		netif_stop_subqueue(dev, qnum);
> -		if (!use_napi &&
> -		    unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
> +		if (use_napi) {
> +			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
> +				virtqueue_napi_schedule(&sq->napi, sq->vq);
> +		} else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
>   			/* More just got used, free them then recheck. */
>   			free_old_xmit_skbs(sq, false);
>   			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {

This fix works fine with my test case (netdev stream + passt)

Tested-by: Laurent Vivier <lvivier@redhat.com>

Thanks,
Laurent

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
