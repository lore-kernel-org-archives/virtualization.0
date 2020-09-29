Return-Path: <SRS0=hez8=DG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E92C4346E
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 06:23:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 854D520BED
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 06:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWMe0NZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854D520BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 00EDB866E7;
	Tue, 29 Sep 2020 06:23:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qv2EHqMkuXn4; Tue, 29 Sep 2020 06:23:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 230868667B;
	Tue, 29 Sep 2020 06:23:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0ACBFC0889;
	Tue, 29 Sep 2020 06:23:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1038C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 06:23:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9F87B844E0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 06:23:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ISoTi1co7ABK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 06:23:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7E96E844A8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 06:23:47 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601360626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WDstdGqtEAJju1eS1p93fmGiOcQC93sT9aqMaSNKp3U=;
 b=eWMe0NZRXAfuTGKbgCnSlx1FPfpDKksv0p6vF+tH4EZZEcrblCZuwGS7k4No7iVkROixBy
 X5fcEtmOET0Ofz361yEwSxY53KiocVJriKtPgKBkvJQ90J+hMqJ601jm2Y/oYriIUP+yIp
 dLrmzRnbCvWT61eSR4QljixYvhiAanE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-SO4AaigVNRK7sRBSqTevSQ-1; Tue, 29 Sep 2020 02:23:43 -0400
X-MC-Unique: SO4AaigVNRK7sRBSqTevSQ-1
Received: by mail-wr1-f70.google.com with SMTP id a10so1275938wrw.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 23:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WDstdGqtEAJju1eS1p93fmGiOcQC93sT9aqMaSNKp3U=;
 b=WGOusx6nzJnDCfPQXCq/mwyy24uaObOTiu9QRozPR7Cg3USooMS15/Mxk6fn8HMyo5
 2KIFKBE6u1KBXKFpr0JNU52bdekXcNkIOrWA4qDk38q6k/9pApuHUhl6t2hu4p+TsqlH
 w62Xj8DibrXdVTRJDbXImHaYhWT98X7Pv0wc37hqWDvWaeKOP2ff/Lkqbdl+6Tvbr+aw
 hJYil37Ecj236KFj/Bb403fpA0VW5v4QQhk+KTiVxAOADeO96YC28UXEWSUElxgViaDM
 P5yyMCZmrbcySaZYid3O9iaQQb2wPkadXX/1u1u/HXf5xo0sGNq7m4qqa/kgzjv8zL9+
 PDQg==
X-Gm-Message-State: AOAM531FCHcfLXZaW/68WynN90PuZCooBeuZk12VEAvZO8zHG3eufcRF
 6SMvLcdSMWpMn2X1HX2kgvL9PyNVoVu0XxtYp6Ft12K+P1a/zPFxlDoEyNXDszdBSbPx3F8AAEH
 ADq6c8Ibtkh2LRQKGq7VAjvS6KspKMiZOY/CLyY+Qug==
X-Received: by 2002:a5d:6cb1:: with SMTP id a17mr2355532wra.386.1601360622339; 
 Mon, 28 Sep 2020 23:23:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx02L8sSPi89+xS1T3nWYZeBR3AqSnXDP1arIPk/zaS8YRXPdPULp0o9ujn5tiIhHfcqjAwaQ==
X-Received: by 2002:a5d:6cb1:: with SMTP id a17mr2355522wra.386.1601360622182; 
 Mon, 28 Sep 2020 23:23:42 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id x16sm4424846wrq.62.2020.09.28.23.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 23:23:41 -0700 (PDT)
Date: Tue, 29 Sep 2020 02:23:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: xiangxia.m.yue@gmail.com
Subject: Re: [PATCH net v2] virtio-net: don't disable guest csum when disable
 LRO
Message-ID: <20200929022246-mutt-send-email-mst@kernel.org>
References: <20200929015806.19171-1-xiangxia.m.yue@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200929015806.19171-1-xiangxia.m.yue@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, willemb@google.com,
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

On Tue, Sep 29, 2020 at 09:58:06AM +0800, xiangxia.m.yue@gmail.com wrote:
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> 
> Open vSwitch and Linux bridge will disable LRO of the interface
> when this interface added to them. Now when disable the LRO, the
> virtio-net csum is disable too. That drops the forwarding performance.
> 
> Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> ---
> v2:
> * change the fix-tag
> ---
>  drivers/net/virtio_net.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7145c83c6c8c..21b71148c532 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -63,6 +63,11 @@ static const unsigned long guest_offloads[] = {
>  	VIRTIO_NET_F_GUEST_CSUM
>  };
>  
> +#define GUEST_OFFLOAD_LRO_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> +				(1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
> +				(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> +				(1ULL << VIRTIO_NET_F_GUEST_UFO))
> +

I think I'd rather we open-coded this, the macro is only
used in one place ...

>  struct virtnet_stat_desc {
>  	char desc[ETH_GSTRING_LEN];
>  	size_t offset;
> @@ -2531,7 +2536,8 @@ static int virtnet_set_features(struct net_device *dev,
>  		if (features & NETIF_F_LRO)
>  			offloads = vi->guest_offloads_capable;
>  		else
> -			offloads = 0;
> +			offloads = vi->guest_offloads_capable &
> +				   ~GUEST_OFFLOAD_LRO_MASK;
>  
>  		err = virtnet_set_guest_offloads(vi, offloads);
>  		if (err)

> -- 
> 2.23.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
