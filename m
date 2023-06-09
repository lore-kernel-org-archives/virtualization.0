Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BC5C7EE29
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 15:58:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24810424D7;
	Fri,  9 Jun 2023 15:58:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24810424D7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c2tHB9uc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TlMFYb2JvXms; Fri,  9 Jun 2023 15:58:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 39A6742405;
	Fri,  9 Jun 2023 15:58:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 39A6742405
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12371C0037;
	Fri,  9 Jun 2023 15:58:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 595D3C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 15:58:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 33A1981381
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 15:58:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 33A1981381
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=c2tHB9uc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TVGpnnVyPMAj
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 15:58:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D428B81357
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D428B81357
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 15:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686326322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZASR5/BmaalzeTJJhd66JJTvqi7hh0GteSbPgdTii+8=;
 b=c2tHB9ucQKJbQcFjEAaGNNW6Piqb12NY6w63KgTHxiIHOuGgMLu8anFm3HQRpshZaLviNs
 swYwmjPzMx6pCUi3WP99YZgO+R2s7WgfJU97/OMtI6MzYB9rcsE81pvug6Rte61ag9EKNP
 qh3njru1yl67Z67nl2Kvcu9Nu8ig2TE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-eUYvFO89ODSYj3z18soeyw-1; Fri, 09 Jun 2023 11:58:39 -0400
X-MC-Unique: eUYvFO89ODSYj3z18soeyw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f7ecc15771so9397515e9.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 09 Jun 2023 08:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686326318; x=1688918318;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZASR5/BmaalzeTJJhd66JJTvqi7hh0GteSbPgdTii+8=;
 b=cy4e13yMzRtV6ZFDVu5QOSzSAu2l4CVy3BRaBIRxPH77WH4OTlt+MH6tN6KbprXEek
 W29Th0W6yv4TQAD2iSG3qjeN9WNlDRLo88DNUcLmABtySayN6g61rL4XYfAxg7VaxTLY
 XoaMU9YOdWkShZXMdFPtbTsSnl2VruDapBudWJk1hCQw51Wj7MCw194I+0498NJUGcpC
 CNa0lAGvfeo5SH3TjeKVGqxsivCMFle2jbtaJZ4aSOQJZ6QBEaFWjc7VoWrKvL/P2g4s
 CywMDGIlbKlq/J8EipOsb9jTIs6/CuXsbstZZRtAn+f99BbnSgtYd+p/oaJKiL1B0u3s
 qP3g==
X-Gm-Message-State: AC+VfDxyrig+J7+IChJmMB03gMovb5hGp5chIDKTsnUUOCoUv94MHeW5
 lI1ZWcjTQniq9ADB6J5O6YYMTLq9u9EhILpFw/mCr7rSAPZAIl1W8Uy1W20ov3F0Dq1wTB6mrLe
 HB+tVS9IwXW1OtfYb/dNFayrhm/jVM5XsL279bV/0XA==
X-Received: by 2002:a05:600c:3547:b0:3f7:f589:b5ca with SMTP id
 i7-20020a05600c354700b003f7f589b5camr4161995wmq.15.1686326318084; 
 Fri, 09 Jun 2023 08:58:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6OksjCtzrynIHd9z5LBpzNB7HtKW+xrrc3WbUfllkzb+rfhixTGuyBW8eVv2rOaSpPAX44dg==
X-Received: by 2002:a05:600c:3547:b0:3f7:f589:b5ca with SMTP id
 i7-20020a05600c354700b003f7f589b5camr4161975wmq.15.1686326317767; 
 Fri, 09 Jun 2023 08:58:37 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
 by smtp.gmail.com with ESMTPSA id
 y19-20020a05600c365300b003f7f60203ffsm3065248wmq.25.2023.06.09.08.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 08:58:37 -0700 (PDT)
Date: Fri, 9 Jun 2023 11:58:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH 1/3] virtio-crypto: fixup potential cpu stall when free
 unused bufs
Message-ID: <20230609115818-mutt-send-email-mst@kernel.org>
References: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
 <20230609131817.712867-2-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230609131817.712867-2-xianting.tian@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, herbert@gondor.apana.org.au, arnd@arndb.de,
 amit@kernel.org, gregkh@linuxfoundation.org, marcel@holtmann.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-bluetooth@vger.kernel.org,
 Xianting Tian <tianxianting.txt@alibaba-inc.com>, linux-crypto@vger.kernel.org,
 luiz.dentz@gmail.com, davem@davemloft.net, johan.hedberg@gmail.com
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

On Fri, Jun 09, 2023 at 09:18:15PM +0800, Xianting Tian wrote:
> From: Xianting Tian <tianxianting.txt@alibaba-inc.com>
> 
> Cpu stall issue may happen if device is configured with multi queues
> and large queue depth, so fix it.
> 
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>

include a Fixes tag?

> ---
>  drivers/crypto/virtio/virtio_crypto_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
> index 1198bd306365..94849fa3bd74 100644
> --- a/drivers/crypto/virtio/virtio_crypto_core.c
> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> @@ -480,6 +480,7 @@ static void virtcrypto_free_unused_reqs(struct virtio_crypto *vcrypto)
>  			kfree(vc_req->req_data);
>  			kfree(vc_req->sgs);
>  		}
> +		cond_resched();
>  	}
>  }
>  
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
