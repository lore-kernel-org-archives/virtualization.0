Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9BACD4F49
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 10:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D48B813D6;
	Fri, 22 Sep 2023 10:45:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D48B813D6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bm/97yeC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iB8noJ91Tgpz; Fri, 22 Sep 2023 10:45:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F31FF813CB;
	Fri, 22 Sep 2023 10:45:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F31FF813CB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C40E4C0039;
	Fri, 22 Sep 2023 10:45:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0FBDC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 10:45:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7B88813AF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 10:45:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7B88813AF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sgwk7X6fTNyY
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 10:45:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9DCE6813A6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 10:45:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9DCE6813A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695379515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nLpNhLGjQETZ+ujUfFRH54UnlTebZaNFpptS2LIRYtI=;
 b=bm/97yeCT54NgcjpbfrV9KYBvFF4Vl8Zaq8uzjkvdYY+Z78M6U56FM4d4/rTrfF7sNcJIR
 IYiJ8QluhyiFEvhqmzM3TxxSYCw9OU2T2HobFISDYs3UxabnNioxYnn2zl5hX8iTlvvlpx
 IyC/1nwctLWKLLdr5zT95fW2K1pHNIU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-lzUgaUeKOZCNPRtcciyUpQ-1; Fri, 22 Sep 2023 06:45:13 -0400
X-MC-Unique: lzUgaUeKOZCNPRtcciyUpQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9ae52fbac1dso431012666b.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 03:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695379513; x=1695984313;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLpNhLGjQETZ+ujUfFRH54UnlTebZaNFpptS2LIRYtI=;
 b=hcRZH7DLN0s9N8ssoOwReNTOpdZkv7Cy3sQR9B62164K+uHHmizCRneoF499ev35H7
 P+Zwy+zMSo3m3ual+6/B+SLQelo98FkPyaQIt2vKFax9rMoamO2vWHQmkw/FzApr94MZ
 JlYNDFRUSYhkL7KyTCFPI+2E1pWoVHRVYt3maRiwwQg0W+071sIhAdg6REooLS6A2LYb
 rvS19y6ja4hdcpF8fFe1TAVbqK8V5YP8ImqglcixziTj8uRoqUPVXIAck5bQmUxLEraK
 obgiAoKnJ3YegIP2Njms+wCb0ivZyAuH/JrJHV8sg0s/UdNkneA6hfJT4YK7RPpgOSlK
 /AuA==
X-Gm-Message-State: AOJu0YxhuiYxTL2m1/8/TGPcdNmA4zsSPMLxEogG26OQQlEb86lngHD9
 0Z+0ryLfe2WPr1UhQoycfNqgaFV3NkBW27nuZSgsOSwWS8G/XFcCdYa6LggmAuAcyakvh9GqZO6
 HI+OuJH4q9ouwXqOHNcyH+nTWPFvcMrYJVPkGn4z+gA==
X-Received: by 2002:a17:906:53cf:b0:9ae:5866:9745 with SMTP id
 p15-20020a17090653cf00b009ae58669745mr3076371ejo.21.1695379512951; 
 Fri, 22 Sep 2023 03:45:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCXluw8TkNKntzKVsr17973pxMvncloevMaPohthSx4ZnglL5io4Rxq1NTVkmycG/hzpeD6Q==
X-Received: by 2002:a17:906:53cf:b0:9ae:5866:9745 with SMTP id
 p15-20020a17090653cf00b009ae58669745mr3076350ejo.21.1695379512610; 
 Fri, 22 Sep 2023 03:45:12 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 k20-20020a170906681400b0099bd046170fsm2494900ejr.104.2023.09.22.03.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 03:45:11 -0700 (PDT)
Date: Fri, 22 Sep 2023 06:45:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Juergen Gross <jgross@suse.com>
Subject: Re: Weird locking hierarchy in virtcrypto
Message-ID: <20230922064219-mutt-send-email-mst@kernel.org>
References: <bdc81c97-ada4-41ef-89c4-7894201b46c2@suse.com>
MIME-Version: 1.0
In-Reply-To: <bdc81c97-ada4-41ef-89c4-7894201b46c2@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>
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

On Fri, Sep 22, 2023 at 10:36:59AM +0200, Juergen Gross wrote:
> While backporting an upstream patch to one of our older distro kernels I've
> found a weird locking hierarchy in the virtio crypto driver:
> 
> virtio_config_changed():
>   spin_lock_irqsave()
>   ->__virtio_config_changed()
>       ->drv->config_changed()      <- assume drv == virtio_crypto_driver
>         virtcrypto_config_changed():
>           ->virtcrypto_update_status()
>               ->virtcrypto_dev_start()
>                   ->virtio_crypto_skcipher_algs_register()
>                       mutex_lock()
> 
> I don't think trying to take a mutex while holding a spinlock with interrupts
> disabled is a proper thing to do.
> 
> Am I overlooking something here?
> 
> 
> Juergen

Yes - this seems like a bug in virtcrypto - for example, virt blk
queues a work for this reason. It's so common that it might make
sense to move the config work into virtio core.
In any case, patches welcome.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
