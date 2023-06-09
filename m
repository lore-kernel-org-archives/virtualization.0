Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D926C7EE29
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 16:06:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79BC48425F;
	Fri,  9 Jun 2023 16:06:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79BC48425F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dpPcOUdr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sZaHeXyIbDZE; Fri,  9 Jun 2023 16:06:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7D4CB83C7F;
	Fri,  9 Jun 2023 16:06:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D4CB83C7F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EA85C0037;
	Fri,  9 Jun 2023 16:06:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 551E9C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 231BA615FC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:06:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 231BA615FC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dpPcOUdr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N7-prri9uddh
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:06:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 55BBF615FA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 55BBF615FA
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686326764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+M7az6Jbp6Oqou6iuD63oUNoAb5aXxDturRi9Hwe0gE=;
 b=dpPcOUdr2vjeymZGEeYaRwHYQJyZ4sb6aAnOT5udyhYlGYWtiPwItGyCsDSNRjIDlGYXpH
 p12cen3t0qkpW0tAkXFZXXfz1zSJuDVJzJfazrUV8TxZNLPTVeqGUg2NkL7bpd31UIvNyk
 u5IUX2WeXaIYzv0xTAa3YDRPsC6Elvg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-oy-exwFmN6uxUpyRHUTh-w-1; Fri, 09 Jun 2023 12:05:55 -0400
X-MC-Unique: oy-exwFmN6uxUpyRHUTh-w-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso751583f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 09 Jun 2023 09:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686326754; x=1688918754;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+M7az6Jbp6Oqou6iuD63oUNoAb5aXxDturRi9Hwe0gE=;
 b=KXe3mh8EQu28XNF4Fq22GCKn0vW4tgbL5le6ubGtCAxVPNf/6IkcZTRPL2JTqBTvdU
 2zq/7oELBxO8PLoiFTMA+GFPCADzoiRUP2nlIm2CMTJJ1iD6ch77R9RmnKIXMxsSAD7b
 jgAPFEmNyWTauiCsbHW92Clx3Nwh3pRxVaUtAPnZJJulVvp/ovK53rtp6P/887fxBm/H
 SCGb86+IDdObyt+wuSCcte3w31a0m/D7LOaKPYoo/7GfAQtXUCZN5st9tRNXioopJlB8
 RS/nIB6D91hrfTMCJ5XDVTo64qRWlCV5uAn9UPp6Ja1GW0H88V+SYOXcFjXfn5867DI3
 GXMQ==
X-Gm-Message-State: AC+VfDyt+riDDCAoKZFtH0Lss3Pi04QHqst4yrBoq6NHdtpx3sKeoTOI
 VMAG9EUihLJdmV8h3sdZGJiuPUgyHCKoHr9XdRt0YlTYyZf2RAhz4hI+yH2MRLG3X5KDfFwh4GL
 BGqu+LU2yWWJgsrH2dXSIoAiMBcYuDzSPTRROD/XUMQ==
X-Received: by 2002:a5d:4e88:0:b0:309:41d8:eec4 with SMTP id
 e8-20020a5d4e88000000b0030941d8eec4mr1062157wru.39.1686326754292; 
 Fri, 09 Jun 2023 09:05:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70iwfwN+298k3OOZDF7xlgm6Z2CMUhRp6FaLoDmzGdsg4L4C82nksLMOKVyP8jx0VshOn9wQ==
X-Received: by 2002:a5d:4e88:0:b0:309:41d8:eec4 with SMTP id
 e8-20020a5d4e88000000b0030941d8eec4mr1062133wru.39.1686326753971; 
 Fri, 09 Jun 2023 09:05:53 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a5d4e0d000000b002fb60c7995esm4841314wrt.8.2023.06.09.09.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 09:05:53 -0700 (PDT)
Date: Fri, 9 Jun 2023 12:05:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH 2/3] virtio_console: fixup potential cpu stall when free
 unused bufs
Message-ID: <20230609120332-mutt-send-email-mst@kernel.org>
References: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
 <20230609131817.712867-3-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230609131817.712867-3-xianting.tian@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, herbert@gondor.apana.org.au, arnd@arndb.de,
 amit@kernel.org, gregkh@linuxfoundation.org, marcel@holtmann.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-bluetooth@vger.kernel.org, linux-crypto@vger.kernel.org,
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

On Fri, Jun 09, 2023 at 09:18:16PM +0800, Xianting Tian wrote:
> Cpu stall issue may happen if device is configured with multi queues
> and large queue depth, so fix it.

"may happen" is ambigous.

So is this: "for virtio-net we were getting
stall on CPU was observed message, this driver is similar
so theoretically the same logic applies"

or is this

"the following error occured: ..... "

?


> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  drivers/char/virtio_console.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index b65c809a4e97..5ec4cf4ea919 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1935,6 +1935,7 @@ static void remove_vqs(struct ports_device *portdev)
>  		flush_bufs(vq, true);
>  		while ((buf = virtqueue_detach_unused_buf(vq)))
>  			free_buf(buf, true);
> +		cond_resched();
>  	}
>  	portdev->vdev->config->del_vqs(portdev->vdev);
>  	kfree(portdev->in_vqs);
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
