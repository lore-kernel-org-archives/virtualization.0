Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0FDC25B4E
	for <virtualization@archiver.kernel.org>; Fri, 20 Jan 2023 12:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4763827E0;
	Fri, 20 Jan 2023 12:57:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4763827E0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ibQqfBf8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lJHcjIseiWbr; Fri, 20 Jan 2023 12:56:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CFA10827CE;
	Fri, 20 Jan 2023 12:56:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CFA10827CE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4AF9C0033;
	Fri, 20 Jan 2023 12:56:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43B4CC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 12:56:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 187D741CD2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 12:56:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 187D741CD2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ibQqfBf8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5vvScLuOFSum
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 12:56:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A244E41CD1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A244E41CD1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 12:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674219414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=67RdguR+gl433cYi2o595AZGinbUWlEV2GdMEq9B1vY=;
 b=ibQqfBf8xUOFAxxwa4tqgFK0ce5TPafx662OosOtKb4tNWNJBzwOwtFntWvx9pBir1Fldh
 itzotDIfnTHNDiMjrGRW9FJPP28QCHru3ZPhM2a5QQITvb1jm003cdioccI52SBN5U5x7w
 zaqBRAYkjVtRpnIF+SnlElEqI+Me5gE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-156-T0VnH2J-NTSA-QtQl4DumQ-1; Fri, 20 Jan 2023 07:56:53 -0500
X-MC-Unique: T0VnH2J-NTSA-QtQl4DumQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 q19-20020a1cf313000000b003d96c95e2f9so1304628wmq.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 04:56:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=67RdguR+gl433cYi2o595AZGinbUWlEV2GdMEq9B1vY=;
 b=VayteTzLBU27oWrxa+foXWSPww8J9rLpp0fBqMqE4q1u4BpLoACSrwoZDsrYftZAQ2
 zrAPUOINf9uUhPUf7eZYdVisuYAIR44qI6/6FUj0aSHzAu5VNvGu0t8D8ZwT5KKEOvZ/
 1tjLkawbBxunrTxIZUX7j3dCbE8OlBezeGyBCi1Xc5ew0HL5bEVrkWqpCgydUA+2l1o1
 aT3kTTXYcyGmqfD6xKxyJ8SxS+lKrsRqdBrOxgoj9QjeknsCZMJ/wbpy+3v37qx9INaE
 J2Z9cEjI2cwMP3cpmMvGpzrztX3ERQVhcWZQ3fQ8wRPLchte307h8LJtiaCU8qF39uyF
 AZfQ==
X-Gm-Message-State: AFqh2kreqRl3WkF3WACm9SzagMQA82B6DJUp+OEvYNopglCAtAYK48RA
 yUPsooo+7zxqK2w/xMh1+FdN7jmIrU8ytWgTWhRrIkgwiR0p63Aoi6XERlz0c946wBl2zBsyfvQ
 CDbakiAUXXq+xhzeL1dvqG4cLfSvqjif9ZXCfGwjW5w==
X-Received: by 2002:a05:6000:1f0f:b0:2b4:e5e:c0a3 with SMTP id
 bv15-20020a0560001f0f00b002b40e5ec0a3mr8416449wrb.21.1674219412145; 
 Fri, 20 Jan 2023 04:56:52 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsvHro5tgAiDLoDeTFfBaz3IKVoGeRkuTWgSPP1YSFThQ9Daguu1quBRSdBhhT+3s5SsO7kQQ==
X-Received: by 2002:a05:6000:1f0f:b0:2b4:e5e:c0a3 with SMTP id
 bv15-20020a0560001f0f00b002b40e5ec0a3mr8416440wrb.21.1674219411869; 
 Fri, 20 Jan 2023 04:56:51 -0800 (PST)
Received: from redhat.com ([2.52.19.29]) by smtp.gmail.com with ESMTPSA id
 t14-20020adfeb8e000000b002baa780f0fasm35571506wrn.111.2023.01.20.04.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jan 2023 04:56:51 -0800 (PST)
Date: Fri, 20 Jan 2023 07:56:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 6/6] virtio_ring: Prevent bounds check bypass on
 descriptor index
Message-ID: <20230120075448-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-7-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20230119135721.83345-7-alexander.shishkin@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
 elena.reshetova@intel.com, virtualization@lists.linux-foundation.org
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

On Thu, Jan 19, 2023 at 03:57:21PM +0200, Alexander Shishkin wrote:
> The descriptor index in virtqueue_get_buf_ctx_split() comes from the
> device/VMM.a Use array_index_nospec() to prevent the CPU from speculating
> beyond the descriptor array bounds and providing a primitive for building
> a side channel.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  drivers/virtio/virtio_ring.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 2e7689bb933b..c42d070ab68d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -9,6 +9,7 @@
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> +#include <linux/nospec.h>
>  #include <linux/hrtimer.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/kmsan.h>
> @@ -819,6 +820,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  		BAD_RING(vq, "id %u out of range\n", i);
>  		return NULL;
>  	}
> +
> +	i = array_index_nospec(i, vq->split.vring.num);

I suspect plain
	 i &= split.vring.num - 1
is more efficient.

We know num is a power of two but compiler doesn't.
And pls add a comment explaining what's going on.

>  	if (unlikely(!vq->split.desc_state[i].data)) {
>  		BAD_RING(vq, "id %u is not a head!\n", i);
>  		return NULL;
> -- 
> 2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
