Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5844C7EE2E
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 15:57:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 32ECD419E5;
	Fri,  9 Jun 2023 15:57:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 32ECD419E5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V5YFoPUH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pRYI613C38fL; Fri,  9 Jun 2023 15:57:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CB85340292;
	Fri,  9 Jun 2023 15:57:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CB85340292
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3EA2C0037;
	Fri,  9 Jun 2023 15:57:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B210C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 15:57:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30FB64252D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 15:57:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30FB64252D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=V5YFoPUH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 55T6seF4FMOb
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 15:57:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E5FEB4252C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E5FEB4252C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 15:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686326251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+y+aveIxA7jLi8Qb8e+Oc4pjTAYvwXvNOc23v+nQ9Dc=;
 b=V5YFoPUHc3GFLKFv+U5HDdsiM+v39vFebZYwk9TxlyanFtQOIa5Tp3hypBvxGsobs6FNK3
 0BG+O7WA4XlIq5fw11Q+8XZO89aZyWNwX+jHXJoosphfvLB31Z5mr6aGO+QejFPPcjLZPB
 qfGZ8Z+0H/K95AJLCF3+Ov9BLYufgWI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-0WDECjscPc6VogiL3iHXGA-1; Fri, 09 Jun 2023 11:57:21 -0400
X-MC-Unique: 0WDECjscPc6VogiL3iHXGA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f59c4df0f9so1411436e87.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 09 Jun 2023 08:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686326240; x=1688918240;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+y+aveIxA7jLi8Qb8e+Oc4pjTAYvwXvNOc23v+nQ9Dc=;
 b=ZPd5jC6UVDe1fdgAgKRatdtVziQNR2R1uLefBCGlGrJcNE4PlqPeSqsOtfNPSSy8pl
 nfw1VmgZUw+A1n/mDQcmBt1E81iy19zXwn9U2a7bP/8WZZC2FKSqOdqlRdWnl+j5NNVt
 mXE8FUid2Vz7oaVPbNdnSBElUUBDiirCOOCTmQuJGqOD6ijYhUdYfCHPpdOwsmuuBmOL
 EVZIoiypo/MO5Dyw/qLPstrGnfxG/kdkZT+JGKUw71oCznh+xj7YRXimf8VvITwreA03
 h5+Of1LyTzL6MkP9nEgJbDfZF84Va9NfqXTEF3ZxvdyW2gY13FHiTKVfK/6AxjpN8li7
 /EPA==
X-Gm-Message-State: AC+VfDxFS+6ViTG19pCQVUhG24ffqHQ6jzT3g43ok5TqKvbWCiHagYme
 KJq1aWKrN9m31OnR/tnRrxmqRuapv9GgnaNQSa+Jg+vBWmqtHxx/KvCCJIAUFBQoy4PYob1BDrR
 fy/7qgzgR/qNsvB6MNFHDC8ObY2a9JiqSTx6mpK3BIA==
X-Received: by 2002:a19:f24f:0:b0:4f5:f736:cb9f with SMTP id
 d15-20020a19f24f000000b004f5f736cb9fmr989551lfk.67.1686326240278; 
 Fri, 09 Jun 2023 08:57:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/T5/nSOeffmIMMxsU83CU4sVcwwjp3dmRwDnOHHwbrP+YSlBuBwmQ6CY/6oW8GCAvWshWtA==
X-Received: by 2002:a19:f24f:0:b0:4f5:f736:cb9f with SMTP id
 d15-20020a19f24f000000b004f5f736cb9fmr989534lfk.67.1686326239964; 
 Fri, 09 Jun 2023 08:57:19 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a7bca47000000b003f80b96097esm415596wml.31.2023.06.09.08.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 08:57:19 -0700 (PDT)
Date: Fri, 9 Jun 2023 11:57:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH 1/3] virtio-crypto: fixup potential cpu stall when free
 unused bufs
Message-ID: <20230609115617-mutt-send-email-mst@kernel.org>
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

What does "may happen" imply exactly?
was this observed?

> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
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
