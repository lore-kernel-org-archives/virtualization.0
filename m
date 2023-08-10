Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CB5C04E69
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 19:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 94D3B403BE;
	Thu, 10 Aug 2023 19:24:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 94D3B403BE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a5C3fAnJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UuxCqC0wUPlL; Thu, 10 Aug 2023 19:23:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2CDF0408FB;
	Thu, 10 Aug 2023 19:23:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2CDF0408FB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0758C0071;
	Thu, 10 Aug 2023 19:23:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1E14C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 893F861337
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:23:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 893F861337
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=a5C3fAnJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2AcaBSVY9Lof
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:23:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF7C561335
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:23:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF7C561335
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691695435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eNpUhxfG0oagA+OSHR3CBYIVBwq8hSKrFiUJQDT85NI=;
 b=a5C3fAnJillqqDzf9asR/dEcy1BHnCTsbNR3l8JqIohN80KAuZbOM08fcl5sKOfJ6nwQ+B
 cGEqAUNmS42uRAdgcu2BCwJxJKPSh8W87nqlMm329I2Cucs6qZyouwspilCaED6edzzuDU
 vxqesVNudAiZBnogVVknCvWG9s67y90=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-a-OoT0yMNouG1xmQnQjWLA-1; Thu, 10 Aug 2023 15:23:54 -0400
X-MC-Unique: a-OoT0yMNouG1xmQnQjWLA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3176eb6babbso1067858f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 12:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691695433; x=1692300233;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eNpUhxfG0oagA+OSHR3CBYIVBwq8hSKrFiUJQDT85NI=;
 b=NTeHOZSlg+UaX7fQN26GIO24plBmyhham1toUFqSyQjyXX0rEYC+udgdi/GQZemsX+
 op3l+ero1nWvyaJYljiT/SBvYirhKnbRidoMd4AzDOSRmUikYuwrdtDWETrRWpFb/+yW
 otr/HQQTDIUsij3oMPBg/1Hhx+yfdPzIYk7McgyarZotN5jZ95sgRpxaJGHz+pm4SNTf
 jWiMkY9w5cbaDuni2B0JjhdJh0ASfJ53K1EXYW7kbTJ6ZBGHe9/f7RuAGYUF25nt6TBz
 F2tndk7trpPZxcI0Mt02i1GI2K5RGuhKHS4ouksHQCO0A2t0C8nNxZv25wMvplteEOKC
 RmkA==
X-Gm-Message-State: AOJu0YyVngsUvP4bi7YSRpt4+0K9ZyhlEEVl/iBi+Z5ieDfYyQicaZiT
 vXIprW2lAqvdrrbeHSat6neNQb8sNFBi5FWBm3L/cnj3wKCZAvimhTf6jW8Z4fv/5B7cIfHKWyK
 2h2KwtLq6bbZarmBBcmYndvmDNmaWWa2+rq0ydncmgg==
X-Received: by 2002:a5d:444d:0:b0:317:ce01:fe99 with SMTP id
 x13-20020a5d444d000000b00317ce01fe99mr2842387wrr.9.1691695433189; 
 Thu, 10 Aug 2023 12:23:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR0CV1UmR4DNEMAn9v2ToSkc3HIbFYdNRmAuQjKcn2GH2b+kNRcs5y/tG7/rWE1x5qPYNz9w==
X-Received: by 2002:a5d:444d:0:b0:317:ce01:fe99 with SMTP id
 x13-20020a5d444d000000b00317ce01fe99mr2842373wrr.9.1691695432826; 
 Thu, 10 Aug 2023 12:23:52 -0700 (PDT)
Received: from redhat.com ([2.55.27.97]) by smtp.gmail.com with ESMTPSA id
 h6-20020a5d6886000000b00317f01fa3c4sm3018221wru.112.2023.08.10.12.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 12:23:52 -0700 (PDT)
Date: Thu, 10 Aug 2023 15:23:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V3 04/14] virtio-blk: limit max allowed submit queues
Message-ID: <20230810152310-mutt-send-email-mst@kernel.org>
References: <20230808104239.146085-1-ming.lei@redhat.com>
 <20230808104239.146085-5-ming.lei@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230808104239.146085-5-ming.lei@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Wen Xiong <wenxiong@linux.ibm.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
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

On Tue, Aug 08, 2023 at 06:42:29PM +0800, Ming Lei wrote:
> Take blk-mq's knowledge into account for calculating io queues.
> 
> Fix wrong queue mapping in case of kdump kernel.
> 
> On arm and ppc64, 'maxcpus=1' is passed to kdump command line, see
> `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> still returns all CPUs because 'maxcpus=1' just bring up one single
> cpu core during booting.
> 
> blk-mq sees single queue in kdump kernel, and in driver's viewpoint
> there are still multiple queues, this inconsistency causes driver to apply
> wrong queue mapping for handling IO, and IO timeout is triggered.
> 
> Meantime, single queue makes much less resource utilization, and reduce
> risk of kernel failure.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

superficially:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

but this patch only makes sense if the rest of patchset is merged.
feel free to merge directly.

> ---
>  drivers/block/virtio_blk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 1fe011676d07..4ba79fe2a1b4 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1047,7 +1047,8 @@ static int init_vq(struct virtio_blk *vblk)
>  
>  	num_poll_vqs = min_t(unsigned int, poll_queues, num_vqs - 1);
>  
> -	vblk->io_queues[HCTX_TYPE_DEFAULT] = num_vqs - num_poll_vqs;
> +	vblk->io_queues[HCTX_TYPE_DEFAULT] = min_t(unsigned,
> +			num_vqs - num_poll_vqs, blk_mq_max_nr_hw_queues());
>  	vblk->io_queues[HCTX_TYPE_READ] = 0;
>  	vblk->io_queues[HCTX_TYPE_POLL] = num_poll_vqs;
>  
> -- 
> 2.40.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
