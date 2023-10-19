Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4574FCDB482
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 09:52:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A4D1D404B1;
	Thu, 19 Oct 2023 09:52:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4D1D404B1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PRpc+AQe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id US_cljsfGOYv; Thu, 19 Oct 2023 09:52:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C2A1840151;
	Thu, 19 Oct 2023 09:52:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C2A1840151
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99E10C0071;
	Thu, 19 Oct 2023 09:52:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFA53C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:52:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ADFF142C5B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:52:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ADFF142C5B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PRpc+AQe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vOMc7RuKqOkz
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:52:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6ED7242C58
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:52:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6ED7242C58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697709143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s07yKdQmQaOSMtiWdOLGzN3oWEKTIekP+ixiSoBemg8=;
 b=PRpc+AQeGMLWr4Dlh+3PG5MTlRV6FC4GTfCQYW+W2tyeS6gMzf9JJoU9izh2lhTMmFHvw5
 oRnbvy91Gy9hTgzcR3N563vOSIHUKGXD2W5D8wfVppUeUw4qooDyT9wFfQCDmQpvLvekWI
 xmvCSQDl8vIy546SON14pgzfFugPfoU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-Q9iwJivwMnG-wmhTznJq4A-1; Thu, 19 Oct 2023 05:52:21 -0400
X-MC-Unique: Q9iwJivwMnG-wmhTznJq4A-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32da215295fso3097847f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 02:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697709140; x=1698313940;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s07yKdQmQaOSMtiWdOLGzN3oWEKTIekP+ixiSoBemg8=;
 b=bGzLzgfuaBL1CAoZsMnYsVC5OiUdsfhAU67qWSTnuYHjnSyJmGeY1RDZDAWKGWTKPi
 rMFsb/Cn+FNjjRWwNMoCgBdB1MZZgoFpsCi2ayaFr3Wo3f+iazbUPBD7SQbiDhgQOsdc
 X/OtgUSWCSWt7sfWI7bQ1hE0mpN3rINWBrG00euIfqgS6ROC7HQCY6vCuBd0N2KJyUL1
 YGce+1qqGdn3czRsnReeHLqnJICgf8fJXIvamSmu6abtWxOfKB1vAFjvPSsCq1oh0JYD
 jh9UpCrdPvP2J90tVeA203qdBZ+RELa9tfjJyDkfwC+d75HU02bQp9kc61wb2+R3ZPhw
 XTuA==
X-Gm-Message-State: AOJu0YzhJ+3CD0m6tSyTLlKBxZ87aQUxj7XEPfiHhmLEgR7yvZlOTCj/
 d7ncQhFrUA16GDwB00YinXYS2jLrTNb//214eYf9oqYoxCgpFBgeOSzNEjYAQU4JwQ+eyieHRlb
 pCOWufMkxJs5+2pqQ6OPHPsDD7w7N3NBFPQQzzr1pUw==
X-Received: by 2002:a5d:534a:0:b0:32d:9572:6469 with SMTP id
 t10-20020a5d534a000000b0032d95726469mr1411104wrv.46.1697709140712; 
 Thu, 19 Oct 2023 02:52:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbrIg21JiUOlDeiQ+N0/lCafmoyCQ7Q6G+JcToUR3WGNATzgv3QP9FSlCqPRWoYhSWovXwVw==
X-Received: by 2002:a5d:534a:0:b0:32d:9572:6469 with SMTP id
 t10-20020a5d534a000000b0032d95726469mr1411083wrv.46.1697709140369; 
 Thu, 19 Oct 2023 02:52:20 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 k8-20020adfe3c8000000b0032710f5584fsm4074029wrm.25.2023.10.19.02.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 02:52:19 -0700 (PDT)
Date: Thu, 19 Oct 2023 05:52:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: PING: [PATCH] virtio-blk: fix implicit overflow on
 virtio_max_dma_size
Message-ID: <20231019055134-mutt-send-email-mst@kernel.org>
References: <20230904061045.510460-1-pizhenwei@bytedance.com>
 <dedde8ee-6edb-4950-aa8b-e89e025440b7@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <dedde8ee-6edb-4950-aa8b-e89e025440b7@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
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

On Thu, Oct 19, 2023 at 05:43:55PM +0800, zhenwei pi wrote:
> Hi Michael,
> 
> This seems to have been ignored as you suggested.
> 
> LINK: https://www.spinics.net/lists/linux-virtualization/msg63015.html

Pls Cc more widely then:

Paolo Bonzini <pbonzini@redhat.com> (reviewer:VIRTIO BLOCK AND SCSI DRIVERS)
Stefan Hajnoczi <stefanha@redhat.com> (reviewer:VIRTIO BLOCK AND SCSI DRIVERS)
Xuan Zhuo <xuanzhuo@linux.alibaba.com> (reviewer:VIRTIO CORE AND NET DRIVERS)
Jens Axboe <axboe@kernel.dk> (maintainer:BLOCK LAYER)
linux-block@vger.kernel.org (open list:BLOCK LAYER)

would all be good people to ask to review this.


> On 9/4/23 14:10, zhenwei pi wrote:
> > The following codes have an implicit conversion from size_t to u32:
> > (u32)max_size = (size_t)virtio_max_dma_size(vdev);
> > 
> > This may lead overflow, Ex (size_t)4G -> (u32)0. Once
> > virtio_max_dma_size() has a larger size than U32_MAX, use U32_MAX
> > instead.
> > 
> > Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> > ---
> >   drivers/block/virtio_blk.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 1fe011676d07..4a4b9bad551e 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -1313,6 +1313,7 @@ static int virtblk_probe(struct virtio_device *vdev)
> >   	u16 min_io_size;
> >   	u8 physical_block_exp, alignment_offset;
> >   	unsigned int queue_depth;
> > +	size_t max_dma_size;
> >   	if (!vdev->config->get) {
> >   		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > @@ -1411,7 +1412,8 @@ static int virtblk_probe(struct virtio_device *vdev)
> >   	/* No real sector limit. */
> >   	blk_queue_max_hw_sectors(q, UINT_MAX);
> > -	max_size = virtio_max_dma_size(vdev);
> > +	max_dma_size = virtio_max_dma_size(vdev);
> > +	max_size = max_dma_size > U32_MAX ? U32_MAX : max_dma_size;
> >   	/* Host can optionally specify maximum segment size and number of
> >   	 * segments. */
> 
> -- 
> zhenwei pi

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
